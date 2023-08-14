Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158F277BE61
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjHNQvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjHNQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:51:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4F4E61
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692031875; x=1723567875;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/GEfgoaLNaU+hBGvmDYAQyjf2CyI9MN1J/P7YWajf0Q=;
  b=MqQCyw7GUZfMaSW7YomsOdM0wsxFRVTRVhDfN3MgQKXRYK9Lq4x66A5z
   Sj+CaAgJDy5vDrZ1b8tiskDsYtz2hT9oOWWC4jl8QgRB1ZQxaCVNGz3Rc
   ScnbsHxdXJr/utDWm0JOltzIl7b+MkJv0eWj86z9qFxwT52ai7PgjCpSx
   qT5uVsXR0ekZ60vhlpQ0Sfu6ledZUq7zQeIRQa8VfYtKLxL4QuE01oRRt
   GtoChADBO6Haq0tWT1LR/5NbvG6q37VgoOe+d58mtp192F0dOzOBUIlHs
   jpR9wizVx65USvIJo75CRgkL3SnFqkBkQas3TaUH3aOWSATk+bRIXfxmh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="375804662"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="375804662"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 09:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683367661"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="683367661"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2023 09:43:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 09:43:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 09:43:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 09:43:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 09:43:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZn4OeQVUu3ZmnjPQSCmWlMpw2cDbKMT8GKa5WqFWmm+BTR/nyyO+qJsrt8mESGiGh3PtVmPfkJHMzD1r22XOUwEL4AwUEoEBN1PPs0/p5axmFZJMY5BCcpuXSZmvQgBzx5smhSRdZl8K9HwpW9cEO0TnQytVAhq/Xlsn9Ih7/kIDBE1d93cuXwhSs6m5BmbWIyDrsiaVtD/LNLjue86s/tUlt/eTGr/WT99bZdVldkINBqlwBXegIKATT8xdMzdIL+Esxn8QInuYjoCgaihufDynF+z4tmZUQwrgg5zO3DRy1AfAQWO4as9KFdWenXSAm0MJup79w2R2Wqhwixeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzOXHydbMHuAvoXCQPXCwN/jaDOzEyemwJmWTdD5dqM=;
 b=BYL32P/nBR2zHygNHSzQu6zx1uabtnv+ZP5M+qNJaETMI9ijygoEJhuqDQLt0cTMv7GtivYlbUefo2zhhswP11T8jkZl5KR8ssN58wu4410UCgifkfNVIYM7LN8zBKfNexPz0krhbAtcsIkpSNRVZC2ToOUYJ216aOgGh11i9T4oAgZ9pNGTFGc7GRoMy8schg8Jzjk3sajV9DpuTLRh7YcQJF0G9Py0gXOJK/FLxgjBikZszDMaemLNbnOSMgBF+LMdAhzl3FPU1HPvL+LMxv+u9JFCqY6kI6pN55GDfbD81HI2BjR3z0cLWOFJh0TeDBRcRSpcndTGu5r9ZSpdXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 16:43:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 16:43:40 +0000
Date:   Mon, 14 Aug 2023 09:43:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-coco@lists.linux.dev>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation
 reports
Message-ID: <64da59b9924d2_2138e2947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
 <2023081432-evade-proofing-fb8c@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023081432-evade-proofing-fb8c@gregkh>
X-ClientProxiedBy: MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6ea8b3-1139-42c1-66ef-08db9ce59d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhBpsVms4l7SyAvpUYXMv4oZ28f7u1B3NHfQi8+21pHZaIwvFxiiL1m/x3sEVwtnnqxiKgHdB6JhKHJJmcry1jspC0CEe3/mkglM17w7oJLlCW7XV+dwdnvJkLUIXnVV/tlXIBnD5/5/vlYPNHMqbkWIkBETqkr4EDY7feWUCvtxtakDiHzYhWdImlJTT4NrqEW7KEYWHDzozJG//CEQPUgnt9l6vfpHP501K/tVOr56PRuXEaaQMj+pzHMvXa5g5fSfRwbpwJZrUtvaNbIvKxqgCBsfTYXImu1DfqF+04v5YFXkvDfaZSF2d4OtM0D2aAlneg5tkU199OmYPwDNQT7oMFuPCwQPuBBtw2jfJPpfnuJIi4MUgjuvCmctW8gn6Pgda7ySSOeJgsgpGawIsS7K2iqeo8rZzAIw+DNkB1oScUWTEcsUZoQbj09bucQJe+Ju3ihV/x2SVugdjzP1BGXyDx4X74QYlET5KCattQvQ8NUrNGnb+LUaoh7v4AlJ2VGRbsGwOKhES+bH7bLHcYGI5wV6cG3b0uhsKdGVoSP5dCycyDjxPAfur4fOsV24TGxLXqc69l5mwOAqq06xqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(1800799006)(186006)(38100700002)(54906003)(110136005)(6486002)(478600001)(82960400001)(7416002)(5660300002)(2906002)(86362001)(30864003)(4326008)(6666004)(66476007)(66556008)(66946007)(41300700001)(8936002)(316002)(8676002)(6506007)(26005)(83380400001)(6512007)(966005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBvgQuLls99inK1wfcnaQprLFwsHoN1Ye0QAzbaginHP5sPjzOA3s11XiGyw?=
 =?us-ascii?Q?xEJ4FFbHB0bRDbhE/n3VAF24Bl5jmkiuWmaS4bKuvBO+Xw7TFpzek8E8t0j1?=
 =?us-ascii?Q?OidX5q3jxdWq9tohxfo+HGk9aCLSBzRoDcOih5VpvbLeokLkze9tKKnvhFVw?=
 =?us-ascii?Q?VmcZmdTvx3x6whxvoRk8C3PgoLu4/KfoEbY2THjGvIQlumYVObo7lkZMFo6I?=
 =?us-ascii?Q?zzbox07MN1lRQ3n6pnujNM9HeTHvU8znCeDqdTNHuqIEXaxeoBSoY49rNHph?=
 =?us-ascii?Q?u0xrYCN+a3616RILOiD6V2YNG7CG2k/5VUTWG5pOgu/j7L4qycnS3vNe+PqG?=
 =?us-ascii?Q?0bDCVLFet+cSfstJI59yq9thBie84lOjg8SutcNOF/Ptr4H7bh+AKszQ5JWb?=
 =?us-ascii?Q?fH2RYz/UUObNocPRFcTPtYV0pnCKC5rEyX91itTTL/H1E2mtpsbdZ7gvo3WZ?=
 =?us-ascii?Q?7mbZByi/aR9nLUGsC+iyLE8B/MFVUj5E30nzm6/JxnCQFX7ctpvF1UypWTL5?=
 =?us-ascii?Q?wfxo+uItQJ5mLF2a/9kajgVFC0WAIJuPBmrUd3Gzy47WYTMzaUjFulKxkW1V?=
 =?us-ascii?Q?j6QKOoFW6/aDSZM2KOlx/lFcnwfm68eSBmU3UZnqMQ2L8QqNjvO72Pj0DroY?=
 =?us-ascii?Q?+4qkg2Z2BpmNeeaxSdtir6gyJFPhxK+ImvEC+aVAkHIx8V16dxNxPasvZdH9?=
 =?us-ascii?Q?/gE5frvihMDwGAnqdfciUM3fDbZ9nGhdfcbeoJ64ullur+PkHg/C2GrLbig8?=
 =?us-ascii?Q?4DczGh+QdGXNeIWbSh+8C0HLcUfEtie1aYN7t5vHagr8Vmx2b/zNrawuFOyE?=
 =?us-ascii?Q?Ime7MpOxMbZrSJt2J+fom6atu6b8Ywh1+Zod7YaicxYguciFxe2D3KpKA1BO?=
 =?us-ascii?Q?H/+MJZTuhDer9OGWSx9wN2brTotkt9XHXwLvjyyMeXRoim9x353R1m58WpHD?=
 =?us-ascii?Q?i7/I5qB6uowUsE7oPj6GJcY9tWOvbmVmTxzAUPhABvMrpc23SQi92Qw44eey?=
 =?us-ascii?Q?toGVvYSZk5Eyu/KUevk7MSa90IxnCIVsUFaZiDTKyQagZIElT0QYmuN7Ou53?=
 =?us-ascii?Q?x1vtbjkMP06sqFqKMvgU5w2AWm8m/jPaBv4ylEFW0N+Ci5X+hcHedU1r06Pp?=
 =?us-ascii?Q?Cu3gDxuOroNs50leTK0R/0onlVr1vZaW3kVyBxNaNnLzYKRPd3vTMlMXRNXq?=
 =?us-ascii?Q?haE8xnyrNOLipapLvSd7fXtpQ/iTLCSAFyCOjUHI0YKFWBTiJ8Zu08Dk2sSc?=
 =?us-ascii?Q?Psd8lplUmK3ydfqD4Os3pazS9V8axFKgmG2tYmLBt07FhX0cjrHpWutQ8pso?=
 =?us-ascii?Q?WzGUR3s+W+2Wfk9rNKLU/gF1ppP92lEKU8AaTBVeXENFce2n/eOTkOb8uKEp?=
 =?us-ascii?Q?RjrK9wTVi5HCwdIdXpQHD0Pxq+JjD8zyD3iu4TQj0P4LAWFZ80qDDYd3zYys?=
 =?us-ascii?Q?fbupPu77PzfuyGjYCpnqSmWz+7/RSk9NbxtXESBb/xq/3+84vU+BglEcLwdq?=
 =?us-ascii?Q?Yq4ur9RnGQ+F8s6F92QzoJ30ScUcwbRbO/eqS0l64J9rUXe6AhX0H2tcBoAT?=
 =?us-ascii?Q?wOwQ5CSbBYseoSRYff3BqXlJr2pzvX5m7EIaR2FTXR+KyKlHheKa05wn49hP?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6ea8b3-1139-42c1-66ef-08db9ce59d4d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:43:40.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNIpVGKosvvIRYUv1DxDQNW90yVuinA629QPIcWveCBIjGhV6jdUXYHmDe+WN4MuQ7dIhfVtz2hX67lv/kCJZpA9G9S5rDQYDAZ06OW61oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> On Mon, Aug 14, 2023 at 12:43:21AM -0700, Dan Williams wrote:
> > One of the common operations of a TSM (Trusted Security Module) is to
> > provide a way for a TVM (confidential computing guest execution
> > environment) to take a measurement of its launch state, sign it and
> > submit it to a verifying party. Upon successful attestation that
> > verifies the integrity of the TVM additional secrets may be deployed.
> > The concept is common across TSMs, but the implementations are
> > unfortunately vendor specific. While the industry grapples with a common
> > definition of this attestation format [1], Linux need not make this
> > problem worse by defining a new ABI per TSM that wants to perform a
> > similar operation. The current momentum has been to invent new ioctl-ABI
> > per TSM per function which at best is an abdication of the kernel's
> > responsibility to make common infrastructure concepts share common ABI.
> > 
> > The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> > more, is to define a sysfs interface to retrieve the TSM-specific blob.
> > 
> >     echo $hex_encoded_userdata_plus_nonce > /sys/class/tsm/tsm0/inhex
> >     hexdump /sys/class/tsm/tsm0/outblob
> 
> Why is one way a hex-encode file, that the kernel has to parse, and the
> other not?  Binary sysfs files should be "pass through" if at all
> possible, why not make them both binary and not mess with hex at all?
> That keeps the kernel simpler, and if userspace wants the hex format,
> they can provide it much easier (with less potential parsing errors).

I can do that. The concern was the contract around what to do with
partial writes since binary attributes allow writing the middle of the
buffer. So either the attribute needs to enforce that @offset is always
zero, or that the unwritten portion of the buffer is zeroed. I will go
with just enforcing offset=zero writes.

> > This approach later allows for the standardization of the attestation
> > blob format without needing to change the Linux ABI. Until then, the
> > format of 'outblob' is determined by the parent device for 'tsm0'.
> > 
> > The expectation is that this is a boot time exchange that need not be
> > regenerated, making it amenable to a sysfs interface. In case userspace
> > does try to generate multiple attestation reports it includes conflict
> > detection so userspace can be sure no other thread changed the
> > parameters from its last configuration step to the blob retrieval.
> > 
> > TSM specific options are encoded as 'extra' attributes on the TSM device
> > with the expectation that vendors reuse the same options for similar
> > concepts. The current options are defined by SEV-SNP's need for a
> > 'privilege level' concept (VMPL), and the option to retrieve a
> > certificate chain in addition to the attestation report ("extended"
> > format).
> > 
> > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: Peter Gonda <pgonda@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-tsm |   47 +++++
> >  MAINTAINERS                               |    8 +
> >  drivers/virt/coco/Kconfig                 |    4 
> >  drivers/virt/coco/Makefile                |    1 
> >  drivers/virt/coco/tdx-guest/Kconfig       |    1 
> >  drivers/virt/coco/tsm.c                   |  290 +++++++++++++++++++++++++++++
> >  include/linux/tsm.h                       |   45 +++++
> >  7 files changed, 396 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
> >  create mode 100644 drivers/virt/coco/tsm.c
> >  create mode 100644 include/linux/tsm.h
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> > new file mode 100644
> > index 000000000000..37017bde626d
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-tsm
> > @@ -0,0 +1,47 @@
> > +What:		/sys/class/tsm/tsm0/inhex
> > +Date:		August, 2023
> > +KernelVersion:	v6.6
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RW) Hex encoded userdata to be included in the attestation
> > +		report. For replay protection this should include a nonce, but
> > +		the kernel does not place any restrictions on the content.
> 
> "inhex" and it's read/write?  Naming is hard :(

True, could be write-only.

> 
> 
> > +
> > +What:		/sys/class/tsm/tsm0/outblob
> > +Date:		August, 2023
> > +KernelVersion:	v6.6
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Binary attestation report generated from @inhex translated
> > +		to binary and any options. The format of the report is vendor
> > +		specific and determined by the parent device of 'tsm0'.
> > +
> > +What:		/sys/class/tsm/tsm0/generation
> > +Date:		August, 2023
> > +KernelVersion:	v6.6
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) The value in this attribute increments each time @inhex or
> > +		any option is written. Userspace can detect conflicts by
> > +		checking generation before writing to any attribute and making
> > +		sure the number of writes matches expectations after reading
> > +		@outblob.
> > +
> > +What:		/sys/class/tsm/tsm0/privlevel
> > +Date:		August, 2023
> > +KernelVersion:	v6.6
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RW) If a TSM implementation supports the concept of attestation
> > +		reports for TVMs running at different privilege levels, like
> > +		SEV-SNP "VMPL", specify the privilege level via this attribute.
> 
> Where is the list of potential values for this file at?

Good idea, let me bound this with some reasonable values.

> 
> > +
> > +What:		/sys/class/tsm/tsm0/format
> > +Date:		August, 2023
> > +KernelVersion:	v6.6
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RW) If a TSM implementation supports the concept of attestation
> > +		reports with "extended" contents, like SEV-SNP extended reports
> > +		with certificate chains, specify "extended" vs "default" via
> > +		this attribute.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3be1bdfe8ecc..97f74d344c8a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21625,6 +21625,14 @@ W:	https://github.com/srcres258/linux-doc
> >  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
> >  F:	Documentation/translations/zh_TW/
> >  
> > +TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
> > +M:	Dan Williams <dan.j.williams@intel.com>
> > +L:	linux-coco@lists.linux.dev
> > +S:	Maintained
> > +F:	Documentation/ABI/testing/sysfs-class-tsm
> > +F:	drivers/virt/coco/tsm.c
> > +F:	include/linux/tsm.h
> > +
> >  TTY LAYER
> >  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >  M:	Jiri Slaby <jirislaby@kernel.org>
> > diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> > index fc5c64f04c4a..d92f07019f38 100644
> > --- a/drivers/virt/coco/Kconfig
> > +++ b/drivers/virt/coco/Kconfig
> > @@ -2,6 +2,10 @@
> >  #
> >  # Confidential computing related collateral
> >  #
> > +
> > +config TSM_REPORTS
> > +	tristate
> > +
> >  source "drivers/virt/coco/efi_secret/Kconfig"
> >  
> >  source "drivers/virt/coco/sev-guest/Kconfig"
> > diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> > index 55302ef719ad..18c1aba5edb7 100644
> > --- a/drivers/virt/coco/Makefile
> > +++ b/drivers/virt/coco/Makefile
> > @@ -2,6 +2,7 @@
> >  #
> >  # Confidential computing related collateral
> >  #
> > +obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
> >  obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
> >  obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
> >  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
> > diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
> > index 14246fc2fb02..22dd59e19431 100644
> > --- a/drivers/virt/coco/tdx-guest/Kconfig
> > +++ b/drivers/virt/coco/tdx-guest/Kconfig
> > @@ -1,6 +1,7 @@
> >  config TDX_GUEST_DRIVER
> >  	tristate "TDX Guest driver"
> >  	depends on INTEL_TDX_GUEST
> > +	select TSM_REPORTS
> >  	help
> >  	  The driver provides userspace interface to communicate with
> >  	  the TDX module to request the TDX guest details like attestation
> > diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> > new file mode 100644
> > index 000000000000..1bf2ee82eb94
> > --- /dev/null
> > +++ b/drivers/virt/coco/tsm.c
> > @@ -0,0 +1,290 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/tsm.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/device.h>
> > +#include <linux/string.h>
> > +#include <linux/module.h>
> > +#include <linux/cleanup.h>
> > +
> > +struct class *tsm_class;
> 
> Nit, we are moving away from using class_create(), please make this a
> const static class and register it with the driver core instead.  That
> way we don't have to fix it up in the future when we finally catch up
> with all of the existing class_create() calls we have left.
> 
> See the patches in this -rc cycle for a bunch of them already, with many
> more on lkml for examples of how to convert this.  Here's one example:
> 	https://lore.kernel.org/r/20230810174618.7844-1-ivan.orlov0322@gmail.com

Got it.

> 
> > +static struct tsm_provider {
> > +	const struct tsm_ops *ops;
> > +	struct device *dev;
> > +} provider;
> > +static DECLARE_RWSEM(tsm_rwsem);
> > +
> > +/**
> > + * DOC: Trusted Security Module (TSM) Attestation Report Interface
> > + *
> > + * The TSM report interface is a common provider of blobs that facilitate
> > + * attestation of a TVM (confidential computing guest) by an attestation
> > + * service. A TSM report combines a user-defined blob (likely a public-key with
> > + * a nonce for a key-exchange protocol) with a signed attestation report. That
> > + * combined blob is then used to obtain secrets provided by an agent that can
> > + * validate the attestation report. The expectation is that this interface is
> > + * invoked infrequently, likely only once at TVM boot time.
> > + *
> > + * The attestation report format is TSM provider specific, when / if a standard
> > + * materializes that can be published instead of the vendor layout.
> 
> Published where?

Likely via a new attribute so that old scripts dependent on vendor
specific attestation formats do not break.

> 
> > +/*
> > + * Input is a small hex blob, rather than a writable binary attribute, so that
> > + * it is conveyed atomically.
> > + */
> > +static ssize_t inhex_store(struct device *dev, struct device_attribute *attr,
> > +			   const char *buf, size_t len)
> > +{
> > +	u8 inblob[TSM_INBLOB_MAX];
> 
> Can this get too big for the stack?

As it stands the current implementations only allow 64-byte inputs. The
question would be whether RISC-V or ARM need more space for their
attestation report input buffers. Will keep an eye on it.

> > +static ssize_t inhex_show(struct device *dev, struct device_attribute *attr,
> > +			  char *buf)
> > +{
> > +	char *end;
> > +
> > +	guard(rwsem_read)(&tsm_rwsem);
> 
> I like seeing the guard() usage, very nice :)
> 
> Overall, the sysfs api is ok, except for the hex values, which is easy
> to change.  The usage of sysfs is ok as well, no complaints from me
> there.

Thanks Greg.
