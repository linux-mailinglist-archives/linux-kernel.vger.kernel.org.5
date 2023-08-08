Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EFA773F70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjHHQra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjHHQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:46:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B685559E3;
        Tue,  8 Aug 2023 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510196; x=1723046196;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wIhlzhV0Tzea0huzfQVdpXrn4EwoQTfOjPUX6W8btp8=;
  b=W0ag+7YGKgPlQwtxtevH9xdKjOODNtpUYEU63Vr4nzo0SbMunjaeF3oO
   R/rPW7qRjyJaecfPux8HBta1HF03A7Y/fokd3l2JbqNYt0v63SQgXdKjp
   fOBs9GpXfIPb7r2YhSFbbSkRDsh2ibNFwIjTSyid7X7y58jLxlzB3gywD
   vKcnuvhdyKC2NTF9PgaAiqAsFhpHBvplZyFD5dHm2T82dZ5Vt33HlXuV0
   hYB8U5MVePAqtN4aEDAnVy0oliqhKPEDpAB18uDn6JdZY3w71+lwih0FA
   4YtIrrk5d0I5xMfj+VgKMH6pCz+ozKl9q1fwZRhq+M7VRJf7C6E1R3w4i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437184886"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="437184886"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 08:14:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731446340"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="731446340"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2023 08:14:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 08:14:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 08:14:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 08:14:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 08:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0N81W7UqthMJUsFYe3vKnTaS669jMMy7r443oXZSh4BaU+PPfgYPRDcFuudBqC91MaN+iZkSVLmIffhQ42U2vjAVNETTeVIWJTNTUnWUg0Aq5bdrY1t0pdU990c7zw3eMBezm4hVEj8cZOskTC1Q9SDniZIovuf3Mg7LTSudIT+xegxW7lbzS/k3NNvwxa3jLu5bf4k2U5oVUjKkXI8xB/jfrqYzoZMJ6XkIg+Gb0lIQNbGncMVHCttk8n9ug4zJC20leiDb4SoFELhekF9rw3iRWBN0KhlUrA/7J8yPbIzeU+pglX+lChrwgVczs/WbLsxtAi5M7eulowilsECyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sBZSp60/BrKzCDjCuvdWMud8rSgivEu8yvatomiFsA=;
 b=FyxNfD3oB3yPTrQtem21UhkvGoaoFbhUIWfDMo8MF7GQRptHg690hf/fi6GEv+OOzj8M6XcRIZ7g9b1d3gwqzDpJ8g/wPXQOkJuDQU+XDHkR8EmBVR2kAXaoglwYD4nMMK0oeeTlC/rtTn0fxozgkOmJ0DvSSX19mYxdwcrYKfn1ASo5BavlKaHIvU5YmuVgiChLocAS1hNYLdvulWGram6gznGZIeAmN/rZe1WW0jA87P/twVGSqJctfv5wysHIY8FFhs9qyLnDeI/v1IiPrVVyT1qJP/2CieRxbnLpejW6GZ40tM1OhLZ211BYq2afrkBbXidFpPspIsGwlwYdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8571.namprd11.prod.outlook.com (2603:10b6:510:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 15:14:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:14:06 +0000
Date:   Tue, 8 Aug 2023 08:14:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Williams <dan.j.williams@intel.com>, <dhowells@redhat.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64d25bbb55d5e_2138e2942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f201ae-5583-413b-697d-08db98221bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgykI/MJP8Dk56kq136OkVgkK4IMMIYbQWmNASD08qvFA8/OKSy9ycJFd7auFR33gQCLlKFsph6rpINp9adqOecwv5nc20bgxv8/Ha8DWYwVj2aR/2pH+kfvlweUry31af+prl6pkDHXhj/0VLCBV35mrQXD26DEYti1R04RyI+pvlvjfok4UKMsUa6+csm6nsDUSN0LHQxW5Giv4KEiaNvsFjsjJ8VDcAmb9E0sVq1wAOFt8d4dLs1wHnQjEHZqv8E69lzhWMYn0F67/SGJG7GDwl4YzKahY2nCjQ/6o6egvsfd6Rq+QQyCSaY6rC7AZzJHDFqeIG9rL1U25xTfZxEEF3dGGDOVh8z5pEaQZO1wCYZLaNGsfN4ysY50WrTGAXGUC46oA3gU/Zrv8KrumNp2zalp2ggNNWWQr0i2/QLwi+3M3I2svUx3c+13qvDb725aIrknrb4ZzOWDPVNmDa7GX/rYRrQRcvbFaO/exmnjzafHqtz5tpwH6hQ2sfKzpifzA0AmLTzMydPrbZzAy/QVA42gZ6DPoYz2Ee8ZBTblcIKltTMNBwR4r2wmUsmbhzlWDx4zjp9hKZ5nG2GXnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(6512007)(4326008)(966005)(9686003)(316002)(38100700002)(110136005)(54906003)(6486002)(6506007)(6666004)(86362001)(66946007)(66476007)(66556008)(478600001)(82960400001)(41300700001)(26005)(8676002)(8936002)(4744005)(2906002)(7416002)(5660300002)(15302535012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YmNI008rOo1APH3HNWY3mouTyJE7BXVocalK4DZ4Mf/a174Qfh53M8r5sDMw?=
 =?us-ascii?Q?0mNNeZqMyVt9+m8lQdPlLUUoXjEg3y4GLedh3Kh1WXyqZSlMFOVdrRs7kB9S?=
 =?us-ascii?Q?8IVaV7Nx2KFhnQ0vVsdeqzOTSKa0+VarT7rFCmhtajcFAXyKS2Ev8+4nLDKf?=
 =?us-ascii?Q?McaRfzUvGbvPn1olYJNLh3JTGeWoTzWiD0PLuhI2O89C3GId4CoqcXoqOFwf?=
 =?us-ascii?Q?4JS7gKIW14a6NdSTl7LshpRNA+b8UFx65cL5td/PvOqp1OCWEl76mRRTM7Aa?=
 =?us-ascii?Q?TydL7PahQUPO9urb7iZ3IS2SY95qcyExrpk4PgwiJjGsD3S/YlULmEOWeFY9?=
 =?us-ascii?Q?LySPOoOc3gy84rkuVLIUSO1wlVJiolp3FpG+wUb2MwYwljy+AqPKH22wOpUb?=
 =?us-ascii?Q?+8t0yZJQHHjtsU7+4nKZZUdNN1EfoTLaPLjUaTBP5lCOT05h0Cd7uwUdWsiD?=
 =?us-ascii?Q?W+fekip5C7XWjlUfvLRk93riGSAD+9K1j/cNCRdE6lEhAcm1LsVZXcyr40x3?=
 =?us-ascii?Q?dXXbPqzLsAiy/hBmXrALP9BVycMfKqDDjDrSVRXW6LOa9LF9nTTovkI+LTnk?=
 =?us-ascii?Q?oWY1RO0y2VyxAc3INwPTG7L087aPQJhzRJDLr7fatZPNgViNoN4zbmsxFnnn?=
 =?us-ascii?Q?7mILDwF7hZtgZ1plPYGTZoifHVw5yOkw7diC2X6J4bco2LbRdTuyhleEQzQD?=
 =?us-ascii?Q?sOSLNb6qPqQCRAj/4akHvNzM6DRetc8JQUegOn3DQfsTfKRkaNxCqn2xebRk?=
 =?us-ascii?Q?K+dNJy1i1p+Lk3TExKvZ23JFfZ9aGNXZzwg9xnsGpKZiqu7Zy5smlDwwMGR4?=
 =?us-ascii?Q?1vgWBI+oHcMtDsg1TPeBfVOyONxOO2M3GedVOJgeUiNlkjh8FREWPqxvYr5/?=
 =?us-ascii?Q?m0Xc5F6f0+slu694c40RDKIYBxEiemHBjoJ18vF8NusqN+N1mjHBDWeKjqcf?=
 =?us-ascii?Q?i7pSrn7THgRQYg55Jz9qrLJctAQjjEsqiV5Ki39AzydbFL/nDnr3jEp4B85e?=
 =?us-ascii?Q?T0XR8PKIAApbKBisTnbfwNwIuB9NIiIufTlppJgWIFaNCE+bVBWBl6BM2w5N?=
 =?us-ascii?Q?b4fvvjZiHBcZNu7voiitTKktvy8cke4Cxn/a1CBxLCae5+rNdEMos3lV2mMq?=
 =?us-ascii?Q?NMpEV4cFo+8cRCjpjVt8bvX7FONoxg71rXNSc9fue2UDV0HUDjOCGFamUf2X?=
 =?us-ascii?Q?+l4BWjc9EMfQ7Arjc+lOkT4kyj25N79ti0fabkUQzIuZrYU+jcRhBVCPOpY6?=
 =?us-ascii?Q?Pn0WNiEYNIwdYqjJZdkNbVqkX3JtOsfAjPBKmdgRbLwCuur7aI3EQHD2lANo?=
 =?us-ascii?Q?+4whC016hrcj4m77AP/slzmPnBnmhoaMYbUjrz3hSHfPdu0G6z6zcsfcnx4L?=
 =?us-ascii?Q?0PDciLYN3yqL0SRTYg3j6ptRmqC/mniWNka0fvBeMwCEwiIOQXSz/K0GvJ6O?=
 =?us-ascii?Q?Xr7pepjH/M81iCZmUHPeH9Xgl1ks6gGfSSv1VG5eBonoghGzRBLsLS+esTFw?=
 =?us-ascii?Q?U6SI8i4zdCs982rmjNX+lihwk7Hh7kbMxKRv2megfgTNwd1yInCeuC9C2z2W?=
 =?us-ascii?Q?xaYlD0fhUldUKRF7D59mf0441u9cTwAImSOW8I3fSTGeBR/VZOLb2AHCr8PG?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f201ae-5583-413b-697d-08db98221bc5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:14:06.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+1WDrS62GTmUedU/InIAA5h9VqW9GdFTr7u2eoDRDGPpCVl6Z7pmDqjldmEL1A098c4ouRAA4L21d1ZaoM+oqVoYrM+DAWmHNvrRxyYhUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
[..]
> > This feedback cast doubt on the assumption that attestation reports
> > are infrequently generated:
> > 
> > http://lore.kernel.org/r/CAAH4kHbsFbzL=0gn71qq1-1kL398jiS2rd3as1qUFnLTCB5mHQ@mail.gmail.com
> 
> Well, I just read attestation would be called more than once at boot. 
> That doesn't necessarily require a concurrent interface.

Ok, I have not seen vigorous defense of the high frequency use case, and
that problem is solvable, it just needs a userspace daemon to front the
interface.
