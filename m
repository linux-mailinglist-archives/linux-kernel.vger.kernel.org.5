Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9C7ADF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjIYT1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYT1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:27:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63556BE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695670013; x=1727206013;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o3S8VpIU/WXBzUlDHT5mjEoSw91wa+EQX36ffJ8VjwU=;
  b=Hl8QobTuG3hqB1JEPus+AG9eEpvjSbaJNwbzUcIFopM9La1NYvXJu9Ht
   SmZKZrDHN61FUnNRuy78+1wt1pEJnBtANr7ifvtRWRGaLDRiMC+LinBWE
   ot3J3nRmhfTFRJT05gYBB+Ne4J30OH8WebNMRQhQYErS1f1ATYljdOM0f
   s8XJdlt5+b/ggf7p3XijBulgjk59dbHjbMMawSZYosvyN6CUUv6g3eVl9
   lnCo/9BQOGXu1nf+9bJ5NuHMdqnsxMvFRDd6z8soURajSITgWyOijEg6r
   ns6ffpr37gkE2qpSiI6bCMMZp1urL176fATSJV14keYHYhXATgl84xkpD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360734809"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="360734809"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="864060544"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="864060544"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 12:26:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 12:26:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 12:26:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 12:26:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9U1SWCYdgOcFMHRLaLIH4a8r6sVkoXtyE9fTyT8RJKedk5o32aPGg7Zt9IXSgjzMey2B4wOtW/WQy8voG4aX5H8vCfa5NU3T9HLBBWy2Wevc8ORGldfIO96fHoY3j0UcYfErFrR52jWuYDfT8LByv3Jrjsc4WAJc7K7nshAyvKRjUYSoEFCVoD1oK34IuYEtzIN6Nk4NfSZPq+ojtSwaZsatnK3LJ03q9mEf2zVt02aSEIPDPqAiU2WoCUt/jpdicbUtHPxQzaqXDzgPrLQDs4Y3FIQHJB0BpMRspbWT5F/aft/p+ZvpherYZiV0cm1StulZYZ2bTirw5Nu1j7oOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOZml55dGps6H9RddZNO0ANTCkWZxOl23gCJiwj8upo=;
 b=mEe0CHqTE/UG47DJMlGg9sYl7Rz4gDw7rocH5fjQBgy40V3h1BBixhew3iaoNMvfeIB4fXBG6s5za/T4iotqybuv+gEMJt3hhIwc+N5SDKAxQ1myLFsXpW8nva4C+OLotqr0arxntBM0G10S2q1qmP+5obBpukx59OttqdSRQTlRRKaUD9swcJUA7JeRySuy2OX+nt/Xk1uGdm5Uwzni5hSRXZW4vTFz2EbutyLrgBU8omxpJ8oEuZZuLRQjVNFvC36xS8nPnnMiiFdJMf6Ayvlmjf8pyPegyReLsGl4V7Z2t7Aexv/lw0L9yqs2HO8+RfGYV+U3jFip3wK/KL/svw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4654.namprd11.prod.outlook.com (2603:10b6:806:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 19:26:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 19:26:49 +0000
Date:   Mon, 25 Sep 2023 12:26:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Samuel Ortiz <sameo@rivosinc.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        <linux-coco@lists.linux.dev>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <lukas@wunner.de>
Subject: Re: [PATCH v3 0/5] configfs-tsm: Attestation Report ABI
Message-ID: <6511def636f90_acca29486@dwillia2-xfh.jf.intel.com.notmuch>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <080d834d-9ca0-437f-8f18-b7a311af0060@linux.microsoft.com>
 <64f2169e5c381_4c1f329451@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZPmD/xJic2QrfIf5@vermeer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPmD/xJic2QrfIf5@vermeer>
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: a062241b-bf7b-463f-4dec-08dbbdfd5d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DCSCysfAxAyMOaQTjQ3gt5x6JhGID9BSbfcf3kzuf3gZo3KDpZJLrYRHncFBd8+48IBuNxILAJ7n909MzSwiHry3odHL/Z4hYAjtNNJGJhu5z2/Q5HQ80u8OZaXpehsqmfFeblhke2P2mkYJHN6YmxQfF4ytASGKENJLF/ZRA/JIdMEFkRlySpt3RGEVRCSgrwy9zrQ6DHX9l09lQbQUPooMusTvuPrGTkqyeJLh8hVdSalzmPixObdWsF/O+o5OVaBpA4L6gqX1gpi3EvDKEKH05+KwPioH7KJuf2tRkHa8PiGYXa8Nt6lN/UdIfqVkcWtB8ilVqbijU4ISb8XrHyGHipvUHPFnmoPwYiwmy/pSKTdXfXG1j+4RK8FK5ieA+jgklTT6LNQ+VoWjhsBPpj5bpnbpg1G8E+tWrhTQq5hmvTO8GM+m1+ifKwbwbInWGOPrUL1S/ndV2w15a35Vcqmdrs4lKPhtWRhQ4zV03t5Hy+D50F3QHMHOEMAoCKRx20mAR+ROWfs+Z+Fe2upTuin09pIMJbQHZkQPyWuGcPmAmPJpZ6X+Yn4wzyQ5gvS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(6486002)(7416002)(83380400001)(8936002)(26005)(5660300002)(478600001)(8676002)(4326008)(2906002)(86362001)(6666004)(38100700002)(66556008)(316002)(54906003)(66476007)(110136005)(66946007)(41300700001)(9686003)(6506007)(6512007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7vwb7T+2XOolzWX9ckSRxXt7vw9P8ypbuq7RppFhpcmT93tqzHr4NPXkJNP?=
 =?us-ascii?Q?/vRk5pM2Q747Q5Fv9UyEWYQqA6pEXfM3GJ1iO7zFzW3KnQSpVL41mx8EY4TO?=
 =?us-ascii?Q?X0U6iiLzBCEVW9SP49JEeUG1f5sp29k4Zi8I559eY7PZ4jHy5Sf8LEs/LgtS?=
 =?us-ascii?Q?DDRJPFRaYV/yvNC02Cyd7f2ctywGreFEmJiQlPiGa0iK92lsyQpit5gkuOpv?=
 =?us-ascii?Q?RpdOusYtN4RB3YYq7VRrtidiFFp2RX8/TiarVfslB1PO1T++zMYj4jBdJ7QV?=
 =?us-ascii?Q?VfUEkyJwl2aHfcyiRTfH3LveR+weWhoDNZKB6hVnxKVKF9LEU/g2SOkMXvni?=
 =?us-ascii?Q?USV+wkmwWuMEgIK+Mm3DnbRbhwUGxq6FZi2+p4HBwEp69nmLAi9cGgsrI4NG?=
 =?us-ascii?Q?6E6mRdHQzcWXsjUphEAmZ06kc9j9u/5zxCMTMUetw110XYFnLepT9VS7RFDE?=
 =?us-ascii?Q?4ZgQ1Yumepe9kJiHRITXqhuUQ7X8KULuPkHLhTE2thfxScG8SEkqFJ5+JVHk?=
 =?us-ascii?Q?E02BNc3riX7TIxc2Rhp2rnFQAf5izyPmnsJBOpvWYaY9UwsxC60Vs0lu0qd5?=
 =?us-ascii?Q?9rEacT7vXtYwBgDJRaefwWJxUOb/2S2fHxslY9HQBfPJDaUvQ9iv0Mrl8Bgr?=
 =?us-ascii?Q?gvrRY9ZZ1BRfUCft9ksdqTw74rg/03WJhiGG4bgjXJpmkcnrpQ3NIykZLv0U?=
 =?us-ascii?Q?cgmfnmpBNwO5CuNpP7E95ZjHcvs4VVTZN/ASSlcCTlHlkwvmKWeHRv5I+Atl?=
 =?us-ascii?Q?xQAGWs1s5aAy2NxRj6ROugzrly1e5Md/79Bp3qlNejO23CL9h3wEYgFUyLtd?=
 =?us-ascii?Q?7kew4w7X9SDStQeEeQZOCo5pHh8AhJNg/D3z1iKFZ2yL538KzkfS+8+Td3zv?=
 =?us-ascii?Q?lFAi+AgNld1HtIVSRm2F8hpbE9UUse8D0t5nkl/YfWsth5zLsBDF24CKsqXW?=
 =?us-ascii?Q?VQwTEzmAqB3namSVJECtgezZlWVfvhFaLW9exlIms0pivz7BX/aCVqb55O23?=
 =?us-ascii?Q?Xd7hfRKP2xX7a3mGYBc8UQx/9AqSbZGSDmIIiruF1f2sg7q+ZoUKtviuFtsH?=
 =?us-ascii?Q?ZoCrNvNB7PwKJXpkKNDe9E7Hiw9uA1f9s5fMBvDdmMccFLIKLsMlN+UC9/p/?=
 =?us-ascii?Q?1dmeklQf4V2w4H6w52lTb+HyZKbLoSmkhm1kwlDmcHN/S2sL70PQGXMrBZwC?=
 =?us-ascii?Q?bdJaoCLYQJcRNpL93IJsitKiQSBTICOW8cgvADt8mpN9kZBND1N+m4/+cyUU?=
 =?us-ascii?Q?2Mkb5KIJn58LAdXbqVJzUClIqgU40TGdfY2K7hxItCd14e3WqEiyhGe4OfjT?=
 =?us-ascii?Q?R5LyJp42L6epTEFG41mAEoNznpVcSjmVbDYn6eif4EMjpEPlwGnocV+BWqD/?=
 =?us-ascii?Q?yrg3dyJ2nDTjubAfH1Jg+zz1fDFZpljHGMiL48chTbuX7UrZYmgvBGl9gxM4?=
 =?us-ascii?Q?5rlpJVR6CynHx497N+DF5xxl506EossD0nwtV1hw4Bs4pUSVCHT7OTrYHL6r?=
 =?us-ascii?Q?rei/aT7Y3DPX53wcpsXY2ZLMllCVkg75nqsNe95SPVJfqzeSEEKGdHiXT3c/?=
 =?us-ascii?Q?Wuq2iKD2HWbR7Ap79G9srqsCYjkkkjc5VfjxxqXvx7IxtVpnInBBVLTRyfwl?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a062241b-bf7b-463f-4dec-08dbbdfd5d55
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:26:49.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f3DKVV7HErn+ZRxQDPX+mhU+KXFABEFspANgYtyUYgSDOa50UFAucHJ4kZ2Hji8Q/bzL035Sc249Vi3HW0yBKMFYn77hJFdfAtbmu5vErU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4654
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Ortiz wrote:
> On Fri, Sep 01, 2023 at 09:51:42AM -0700, Dan Williams wrote:
> > [ Add Lukas since 'SPDM' was mentioned ]
> > 
> > Jeremi Piotrowski wrote:
> > [..]
> > > > An attestation report is signed evidence of how a Trusted Virtual
> > > > Machine (TVM) was launched and its current state. A verifying party uses
> > > > the report to make judgements of the confidentiality and integrity of
> > > > that execution environment. Upon successful attestation the verifying
> > > > party may, for example, proceed to deploy secrets to the TVM to carry
> > > > out a workload. Multiple confidential computing platforms share this
> > > > similar flow.
> > > 
> > > Besides the platform (cpu) attestation report, there are also attestation
> > > reports from individual secure PCIe devices that we'd want to fetch. This
> > > uses the SPDM protocol[1]. There is a CHALLENGE command which (too me)
> > > roughly maps to an attestation request, but also separate interfaces to
> > > fetch individual measurements and certificates (like the SNP extended
> > > report interface allows).
> > 
> > Yes, but I am not yet convinced this configfs-tsm interface would get
> > involved there.
> 
> User space will want to get those devices attestation reports, and those
> would be carried through the TSM. It would be nice to be able to use a
> common ABI for this. A CPU/platform attestation report is not that
> different from a device one.
> 
> > > 
> > > If this is to become the one attestation interface then we'll need to
> > > consider that. That will probably require adding a second level
> > > directory: /sys/kernel/config/tsm/<device path>.
> > 
> > The SPDM situation is different in my mind in that the kernel has an
> > interest in being able to attest a device itself. Think of cases like
> > power management where userspace is frozen, but the kernel needs to
> > validate the device in the resume flow.
> > 
> > For TVMs the kernel would validate devices
> 
> That means the TVM kernel would be provisioned with reference values and
> policies that are likely to be tenant specific. The same TVM kernel,
> running the same user space stack, getting the same PCIe device
> attached, could either accept or reject such device, depending on the
> tenant/workload owner policies and acceptable reference values. That
> means each tenant would have to build its own guest images, and maintain
> and update them with potentially each new device or new device stack it
> wants to support.
> Keeping most of the device attestation stack (similar to where the
> platform attestation stack lives today) in user space seems more
> flexible to me, and allows for tenant to use single guest images.

I am not seeing how moving the verification mechanism into the kernel
makes this less flexible. For an analogy the kernel supports firewall
policy without requiring userspace network stacks.

Userspace still has a role play in dynamically updating device
validation policy, but the design is such that the kernel can be
independent of userspace in scenarios like power management where it is
awkward to round trip to userspace.

> 
> > and the verifying party would
> > validate the kernel as part of the guest measurement.
> > 
> > The main difficulty again here is evidence format differentiation. My
> > hope is that there is some standardization
> 
> FWIW there are IETF driven standardization efforts like e.g. EAT [1]
> that go into the right directions imho. The latest CC implementations
> (CCA, CoVE) follow those specs (EAT, CWT/JWT).
> 
> DMTF (driving the SPDM spec) defines also its own format, through its
> measurement format spec. Device vendors may choose to implement that or
> to e.g. add their EAT formatted attestation report in the reported
> certificate chain. Realistically, we'll have to support all of those
> flows.

Yes, but hopefully the differentiation here converges to a static or
slowly moving set of evidence types. If Linux makes it painful for new
evidence types to be invented that seems like a *good* thing from a
maintenance perspective.

> 
> > or otherwise a way to update
> > the kernel's verification logic for per-device evidence-formats.  Maybe
> > eBPF has a role to play in that story, but that's a converstation for a
> > different patch set.
> 
> This conversation will hopefully include a user space architecture.
> Potentially something we could talk about at the CC LPC microconference?

Definitely. I have been distracted from submitting a formal topic
proposal here, but I definitely think LPC is a chance to converge on a
direction here.
