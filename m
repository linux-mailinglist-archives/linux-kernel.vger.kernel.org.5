Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0876F7EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjHDCkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjHDCkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:40:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820C94224;
        Thu,  3 Aug 2023 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691116808; x=1722652808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u3Yd4vhvDW8aGx2x6eO5tzf7HQrP9Vrnn9E+eIiKhp4=;
  b=WU+wC3+9O5kwPiPCBGwbIwpuVF4rTvQi53E1lgcNUIbUAl+d5RfB56L6
   IO730mxCTWYdO6HKjmd0uKcpvc9Tqz24e+5CUTo6wDgmCBcHs630UF3SB
   YohW3z8kFXNJbuTpvjNbRuBKFfOPXY/lS4T0tvV2qAYwPur7Cy/LcbBaa
   RLoWY7yCZ28W6U2uUY65UCDvkX7JGGtJIICHhtfb5aKRsJ77zkPd2ZLZj
   vNN8afDZCmEl1qzS/shtN8MwzC6Ey5ptM/MZ2hmCkzXVxfKfDTedcBs6a
   yanJC9JkQ+fDDDiLmRG4FLhjPUIk8aIaAXbQCi9mZDKG8vnClujMlkW35
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349640514"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="349640514"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 19:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="799833419"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="799833419"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2023 19:40:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 19:40:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 19:40:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 19:40:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 19:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFHyGWITLbHXmquMEn85OvT3JpdjFMBp9SSyO5dMGP48ssMDgNby+hnWsIM2EqeJkpbBCNuw8y1YYiqAZgvw3u3NH1+PLcvgss/57BPcHZzVc34LHuYkmTNvEPYqG3ObgeODOw+485i9Sf64ZnjK60VxSnKUpY0uNd3Brjvd6Av4b62aYgQoLofNLnyq4dFhnHIbQOdasAfm2Hi1/+jRpM/P3gC90X/Jq9Kc5mIrvhyd3UKNkPL1eJnYsC05tidEkarhg9AcAKYdF7g1lDmWroffcwQ/B9eDhK4bNrvkeujq21OnhNT1e+ZnlJJPI8I4F8Bfxh++5hIiPrlLms6zgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nH8xSH/GsRUxjsPP1J9a3y0+EUYq/hvVSQGfwsg5/4=;
 b=LgBddyx85jjl8afSyLx5yb7XHfmJvhxYzO3LnQzD1yrpaXrv88800UeuHvXPc5rbO8GhMkd+Zu2ozCHts94yPVKPPONAiNJZGY/q8g0BrAqWLgJjam5iB6KjajFXfozi46U8FcFoPmth1zUQc+NAajHfzOahOtm+NVcs8kdmFc+p/sRKwE1t6Jfb4CMJWt3+E7D4ogsSCWl12xMagK2528Of/WY+JOCkONMNLiEMVTAKOKb788AFg+OOHwv+hwU6VPDBr29N8hGXwwJxU0opBLSP9KppvKJ5Gt2zRi63IyReVU6jULvwVrNwZB39kVyRfUctNO5TbZ5FiGLqz0APOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 02:40:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 02:40:05 +0000
Date:   Thu, 3 Aug 2023 19:40:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Gonda <pgonda@google.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <dhowells@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
Message-ID: <64cc650233ef9_782a329489@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
 <CUHEL5OD3UR8.FRBWNF6MTP1Y@suppilovahvero>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CUHEL5OD3UR8.FRBWNF6MTP1Y@suppilovahvero>
X-ClientProxiedBy: MW4PR04CA0251.namprd04.prod.outlook.com
 (2603:10b6:303:88::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 942ff2f1-5e47-4162-f2ad-08db94941c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBg971/A+7e4joAomIAgEKd7HNCrYqNqg6KYvEGXB3BzGjdGhH8i7nTye/bpCxK6AglR8Pl4zHquFbCpWX6JS66IC5PPKH0D6BuUbBVZTK/CDmdYPKv0bkybayAaq8ZWl+5o3D3PwY105LEkukncsJSyTKgiWkB3Q4TaUstrKn2NpSJ34aMVlo6iH5r0JPwszjtCQgI3dIG4iIXIV/M6iEMlflRrgCewahkbYGFk3TxM/XjW1GMamlX9HuajwyKDNGvmNbXBcatYExtf6fXLaRj6rIaHLQiSFJjlLbi1Ul5h43dwP1BKv1ezaMSZZWzfpFIc+rcDnikDb7Zbh/VRNfYWVnex3P7NYexvdF3lLcOMpZjzFzMBhXejEpy6HYBNeJQQbEBUH/4WZyWs91YiXjmh6wb48Shf9a0HKWKUCi77k6S2W4kUkUfGsFY5ULFrJRKJUoJa9qb8gJEpb+TCSTzE+LhOkwomNIUdF3xZS8fCjPd+8Xi/yg4ZWGePwDg96WU90wR7y6IbsQs8smvAoT0tP3T8k4mzF+qVPvn/+rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(1800799003)(451199021)(186006)(316002)(478600001)(5660300002)(83380400001)(2906002)(7416002)(86362001)(38100700002)(82960400001)(6666004)(26005)(6506007)(8936002)(8676002)(6512007)(966005)(9686003)(41300700001)(6486002)(4326008)(54906003)(110136005)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+CzQ/2goR74j3p69c/wp63cx4/u2Uh4AxVpGeaiL4lG3PEU+nso9j55vXkH?=
 =?us-ascii?Q?8A9A3jancIMuq3FRg4Xer4m9peKWaTKP9Vkd+whpaXsj4Ime3Vl1jpVxRLAu?=
 =?us-ascii?Q?cCxowvAqu6i63xiBHplqIWc4wecy3sxYCP9zwbGcsxOeXhFN5NQPgSKzdfzJ?=
 =?us-ascii?Q?RxYZkhacfZtyE8APsc8eVgY4VTU/+09xQ6V/4vSNalSV35LApLOW4dXep9t8?=
 =?us-ascii?Q?XKwQwD2hsVs+HBa/qAUwTRZQXywH9Ep2MiQcxErTkgkV4RbwXoBXLpvczP6r?=
 =?us-ascii?Q?fa6n6mYlcuxcvtvPiNNFpgTwljmlN4SGrn4TeeHUFV5xpD8aKG+JPeUwhhvk?=
 =?us-ascii?Q?LpKkNgTfsnbjk/2iuKfzT30aMjfKI40HBm/wDmdQSVIg5vcSAZhDFsWsPMqV?=
 =?us-ascii?Q?0gqueVpc6idDvjQG8aAQ22NxGbUkVz3dP17rtDGjU6/DdsBJDPAV4Zp7a5C3?=
 =?us-ascii?Q?QyhAKd+jFSboKr1eoHPRp+TlUFhbpmqa/pFZXNcKUwqRREfwv14xF6ThXojM?=
 =?us-ascii?Q?xrq7UOX0CMTEvTUNPJql02u3yEIR/6taxkL9VXX4KwhfqEEorEMYkZDFOTue?=
 =?us-ascii?Q?cE4gDJS4B4u4j2tYrN+Owo/tUZLP3iUPoBhRKdn2sOpedybgr3y0eTZDkMOd?=
 =?us-ascii?Q?/gnRXZ7S7EOoVzmIUS1aG865++q/eK5d2kvHXhEFQOh4YfK5dT+IhqePXsrP?=
 =?us-ascii?Q?Duonq9VAZjw8qtWR0bxI6ryw0iCbexCnazc57xMRu77qqeWaOCMFDb7O9KsQ?=
 =?us-ascii?Q?YpliMLacmOKiWXl8q2Vm4lM29OGY6KCRPui3BCLgGbjqLk1FxHYsnKDpZU8u?=
 =?us-ascii?Q?Z3rVAxkbwYOe/kH6FcxiXWxdck7fdqvDc0DzFqfATJXzhMvgUnTzzD6arO4L?=
 =?us-ascii?Q?1j5dRibZQCsHwouLZHeQ0MXHDykC/mUSOsBQCWDb6iGyaqqhW8rW4tQoLup6?=
 =?us-ascii?Q?oIq2kYZy29Is1parqAmQQsDUMPKMiUAPktbNP3QiXPg2xYom7Ib94pwMAzA+?=
 =?us-ascii?Q?3PAFI6iGsGI+B9Qy0Ybi60I3vMBRvAaciQpljj8b+NxRNXryCPQvaEqsVli4?=
 =?us-ascii?Q?PsOyz0Q0oqd3cEjtigMM+Oy79juBAoTdxqCPa8/GVOyTkU1Ywtp5x52xcNAy?=
 =?us-ascii?Q?bZ3ZGtQ2Komb4yKOhQsOB17w4X58QV1FvpbCroV1XUHZakMVnWF5E1i5lLBg?=
 =?us-ascii?Q?05MlhhrfdvHuQkcA2NUDuPcK5bVL7Kz4ULlY1hVp4SRqccgeklihe13fcL+s?=
 =?us-ascii?Q?gmHrSJ3b9cQUiBJn79RrWgcE95jm3+BWxkKTquP8efYqRah6KjiUnrlaCOiB?=
 =?us-ascii?Q?sC4bG52T7bdArEg21c5BoS4eZDsDR3MLAM5pQq0jjhhqpenORPWm54gUNnN+?=
 =?us-ascii?Q?433LjoDLkzD9Gx79o/OxLhBgUVGz4iFbbswfsHCLHhXW4F1qn9xY4NY4vl5T?=
 =?us-ascii?Q?UjTq3oZOg3TYWdw65I0JENsZ4/+UXpXgFY7l/QRvBK8JkelkjYsq50UhEYmv?=
 =?us-ascii?Q?DAK4UyFhHo4sR8+qs1BEVa5MNeWveckVjPtwPrci0X+n4Uy2tRJq2mV0FLXY?=
 =?us-ascii?Q?DikLUS/d375nHVZXhXSyZtTeHVV+++rPG3I8KCGEnbNUevajDmunXMI+UWb9?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 942ff2f1-5e47-4162-f2ad-08db94941c1a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 02:40:05.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGqx9A4lufp/9Bl5BF270D6YqZwnsupd1aFU1HN2WbiVqOExqMLKlHqsjB7Q68jFvVn0SqlEn2o+kdc/S4l2kxQOzXT1Rkb4gZBpC4SpI3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen wrote:
> On Mon Jul 31, 2023 at 7:33 PM EEST, Peter Gonda wrote:
> > What is the purpose of this report? What does it prove to whom? I'm a
> > bit confused because it doesn't seem like there is an ability for a
> > remote party to participate in a challenge and response to introduce
> > any freshness into this protocol.
> >
> > Also shouldn't the report have a little more context into the key we
> > are signing? For instance what type of public key is this? And what is
> > its purpose? In your example this isn't even a valid public key.
> 
> Yeah, I agree.
> 
> It is pretty hard to even evaluate whether this should be in kernel or
> could handled by the user space (perhaps with something less intrusive
> added to the kernel).
> 
> With cover letter starting with not one but two three letter acronyms
> that are not common vocabulary is already a red flag for me at least.
> 
> A lot more clarity is needed on what the heck this thing is anyway.

Apologies Jarkko, the assumption of this code was that because
drivers/virt/coco/sevguest.c was already exporting an ABI that put no
definition on the payload that this new key type would not need to
either.

However, your questioning proves the point that stashing security
relevant ABI in drivers/virt/coco/ is not a recipe to get worthwhile
review from security minded kernel practitioners.

So I can see why my explanation of "just do what sevguest was getting
away with" is not a great answer. Lets try again.

As mentioned in the AMD whitepaper [1]. Confidential computing has a use
case for a guest to prove to an attestation agent that it is running in
a valid configuration before that agent deploys other keys and secrets
to that VM to run a workload. One way to do that is to wrap a report of
the launch state of the VM with a public-key and if that report passes
validation use that key to send encrypted payloads back to the guest.

In this model the kernel is only a conduit to get 64-bytes of data
signed by the report, and the kernel need not have any requirements on
that data. That said, it could. That's where I would look to
recommendations from Dionna and James and others about what contract the
kernel *could*  enforce to ensure that best security practices are being
deployed.  I expect that also helps this implementation cross the
threshold from "blob store" to "key" as the Keyring expects.

[1]: Section "VM Launch & Attestation" https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf
