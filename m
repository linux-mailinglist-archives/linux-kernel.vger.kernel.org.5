Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2E7981B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjIHGCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbjIHGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:02:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB31BD3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694152969; x=1725688969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z1x9UCJwV/8gVIKzEPbzDP1L/cdAdLLShC1out+avmM=;
  b=fT/dGt3ny+YLugoiNO42qPiVIFRFpyjeoGjLDAY0voYSwrJxpH9wSIIh
   QqXxzsFK59XQDBuj9TJ+qK0kUcKNVuwU7QZGdRH/ATe4z6/KPOpyzM/Jf
   t2IFHqAWTdA6ppTCRvNQAQfnybYCdHSSVuCeHuKM5cy8bpqQMaKQwr01B
   yQ/eflW4zQbDDBAB73lkYVSarehgfZUq+WuM99dlB7IzWDNG4MfhgDeyq
   6rc2BYMA9ajtzuFh+wSLXbRmkpy9GhPjo+skPOA1BX62sc8bRuSvmDL7Y
   0DqlDB5f8iI4lzHu62mrXtvcg5R3LL/0pDatDVWHcgJf6iPyfPdpN5HWo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="380306839"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="380306839"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 23:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="1073178255"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="1073178255"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 23:02:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 23:02:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 23:02:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 7 Sep 2023 23:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2DlNgaJT6wPwOVKBEGGmjfRuvusnej6tjkHA2hmWth4OXqVIQiHNZ+/lguBYSalYv/pjln0J3DdLNTYzqGJF7q0RFn3/sylVHJVLzKpHHV9BygEPYJ6DYz1Cm5jQ5/nlYf9ArDDtCrL5MAU1U7nZGDfooh8beqTU9YqUlijBKngdieS7/eqdY4A+dwAgI+15qun6QTUWq3jYThE6oYGpWkY72Aa3oCY9XQKuMVkLMmnEkdxmLaErl7xmr3YeokiSEKzv8T3qFh+b9zQHALeaqx84Wpj6AW0GeEhhqfsPcYYMdROMp8ANQyU8JukKgbF76gBR6RLmLrzI0uy8lw3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EbkJhUREzuYA58y1VCgzWYEr8MwcmNpxM7xFOIR/NU=;
 b=OKiTEwFQMatfOdjqre/T5L3wDCBD5uAuZppSw7wgbQEcGKZ5oaFOH8hkMgMi9OzUOHhe7kkF/x+VHMwSO8LmiSQDJ7AeQUy5KcHqP1shpi5NAEu31V1AueuX2ShBfBXbgLQh+cBnwnziGn93g0Z1CU7rQoaJPFvt7h+8EUlCl7C6ZL3DFRidykUFSyuVWec/7a9LaCj99GRq+xiGJqwSdNhXFJ5GGEBHwNB/EBBuZAS3fiuuzuqtwWsEzZqEHBQb/pMUzHKvXW3rCyhhuOw1Ye+L2OCfrLWaWdWNHIGzn6AnnOCjlacp+ijq4cnpLsbg3hbukRUfnpXN/qYR8C9gqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 06:02:41 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 06:02:41 +0000
Date:   Fri, 8 Sep 2023 14:02:30 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230908060230.GA283801@ziqianlu-dell>
References: <20230829114816.GA508985@ziqianlu-dell>
 <ZO3hQ0rbr8QuUjVI@debian.me>
 <20230829125134.GA509331@ziqianlu-dell>
 <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907131409.masxz42ik6u456qp@box.shutemov.name>
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA1PR11MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 658c3c2b-accb-4d6e-7291-08dbb0313606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wC0oJg0xK0wnFuQ2vlV2KJnDkvd71/b36dG+ozeZralE5ClLEiUDF//bCF0MtxX1EAjABsR/zicRtkoXTkIv3X6A/Pdu4cXnwliaeNND7OBfAJJ9v8hsWexbnZFFCHmFHGts70hUfj64tR6lnk/04FuyP+Cme3DKx2obHKKbs1l5eRJV3692CFJAYoYoX8MVY7N1OvMxoEdQPrQSvc5YIukdX2LhUQGuR2LMddp62yXOcLe9rfkb3em3S3HlaQhdb2lOYNFWUGPoHM3G+ZsQNL4sQk6p0+4cUrF9gpfhrlGDq68ORGpjXuUgm1zbSsQDAlDWYwjU2fUiRRfA/kMvGNEAZLDaM0UQu644eFbODeuBEAb3dnuQ/RD2WbhprfgFTremSAvbgLlWi7P3rLjKvGgYOv3O6S6re7TOgAZHc4wbhDCj8C67IpkIkC3MlsfKyqqsAGfl3e2UmDsxiFwRBWIVmid9twqy3vBMxoQjxc3TVTA12B69uExLoSGACPVTpt7CzNo+jmQ/kTGoOABISrYR9VloXgu0yu1wuy4V9WTbHlV+bFE5SsT56MgBrX56
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(366004)(396003)(136003)(1800799009)(451199024)(186009)(82960400001)(38100700002)(86362001)(33656002)(33716001)(478600001)(2906002)(6512007)(9686003)(6666004)(6486002)(4326008)(6506007)(8676002)(8936002)(44832011)(5660300002)(54906003)(6916009)(66476007)(66946007)(316002)(66556008)(41300700001)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s+xDB/1ld5DBP2XB4e9jvCPL0Br4/o6q/JC0SiBQbw0yDN+Rzfv/G7fpkvle?=
 =?us-ascii?Q?ZlJRu1fuBgmEpSYbQiwg9XaxH0yJH66NIpVwqiAlZ69X4i7g+mJ3HmqJnmAW?=
 =?us-ascii?Q?CO2LL1fOQ+qyg652Bqy92GqVcnxm/ZS6pNbAShXRx2MstHp+vXJ9025OPTdT?=
 =?us-ascii?Q?Tjkfeed763JX6MBE1n4YFSr/1uaaOANcUpxyPkv5lBuGYSsx/PR3nqMmFHkS?=
 =?us-ascii?Q?xY6SAp4ZamKkYF1WTC0Z88lqI1ebC3EJ6Lo80E/RXUtcILENSz1OwJvEjNMl?=
 =?us-ascii?Q?qQCuvQ8PnBh0+grI+jLYpm3feT3G9ZgB+zblApxu/yx7x5jfqM1p3vIKq3qe?=
 =?us-ascii?Q?wCAANrXFckjrJItOX7hPA18Ieatt7ofFcRd+uCqszuigTNOMQB4qsnRC0qCg?=
 =?us-ascii?Q?KsQ/uI+/zEajGqqiMse24E9VJbnBhlQDgTCuhjtDJ+dqoUXDiaauby8uKtFg?=
 =?us-ascii?Q?R05JMrY3vWrc/OKzbRirY3OSK8f71Y/DVu02jxFpz9qbG4nM2kJAdzDntaaq?=
 =?us-ascii?Q?aBWa/8qISUKAtVBK4yXwgh+nRBgkGImw/kCNz7PUt1CC+YbXYzofQfCb80e8?=
 =?us-ascii?Q?WqFNtHAIp0W8EvuJStk/1S6NA/p9lXZTqyTxZfcFpjRyVomGaHmZDtXfdk9x?=
 =?us-ascii?Q?94YN8mrp9NOaPdkpPrBPN0wPCKbZr3JFFoEcKPnSA0Ey16vvzoPYZnr020+I?=
 =?us-ascii?Q?PnxZsQanETltuNgZ6KLCgre7tyWUzwSgRgN+S3EbHhnJxj70fraCrOFOn2J0?=
 =?us-ascii?Q?LwaM1QxEfGpsD80VJNQCivD3FwwDBqJuQR1JSjH6Rkb8wWAtypQWMUfR3Kdo?=
 =?us-ascii?Q?N346hawiUK8ZwLl42o9DdkQLUp57fcwSEr6ROxa3UxCde9qLjChPR9XbfR0t?=
 =?us-ascii?Q?WBbjwkruNGwn7GNurIXEQpO8+a7NiKsAAQ3hpJeRQWLMQWpvP8gWoTWg4g0j?=
 =?us-ascii?Q?zt7gRJ13J9+yidf8VNFF0IOICBS63e5fsZLeo89rWHako9+F+Ex90MZzAnFf?=
 =?us-ascii?Q?KQFiYpESk0KCbx0nzaTTPVAiSv/CbyANiTZrL86s6PD3TksxW6EjSzkWvmO0?=
 =?us-ascii?Q?pCQE/algt+7MS34MPp0iZk6tdxDU5WQiWtwkGPidVdV9bOrlRrAFZA2PV1C3?=
 =?us-ascii?Q?1PSoFOVLWlaafzHSw+D8WOhSwxXPQS7G4KrWhn3R4Lut+IeumsVHQefn6J2z?=
 =?us-ascii?Q?WsVr2ySHoh3bOw5PF4l7bqqJ/oYy+AMmRnLUui4gk3bSV/0anyq2hTkvd6Pv?=
 =?us-ascii?Q?kU3+J4+GZLKmXx3/U1qE/m5ZSxsZkHyZsqH944291GYC1s7aZt12Q2KGWR5S?=
 =?us-ascii?Q?Mv2ShE1hg8z51DOmEZiRVgSF9Lb6q9Aoe0Z3WboviyjZyuFJGetD6WWSkqrt?=
 =?us-ascii?Q?2c54pzZdmeV3ptKIVWODeOfe70zvedhoKZvYFFonjS9Zhn7ByfXdvTU7E26+?=
 =?us-ascii?Q?FqfEUAX2q4n2nCZhYZTLlLftkNnHP3un/bCnRmBrxeAEA+HHJJjs6dUzUg6l?=
 =?us-ascii?Q?gBIwRFOJhUtj3ZL7R/2pCdQVsYCfZvp6H+HyOfJvlYJK7PiYJq7S3OkP44qx?=
 =?us-ascii?Q?U1TIzkRWtFaqqBSLMxQWVf6T5RptdBNW02LzjLJP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 658c3c2b-accb-4d6e-7291-08dbb0313606
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:02:41.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdgLgCkqjDwSNmUw5W5GNyNoOeJ3wtjelgj3dZWIZzBRidMxCSQBD3einb+gHL7aJsSkQqqDLwFp0z3hKo0p6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:14:09PM +0300, Kirill A. Shutemov wrote:
> On Tue, Aug 29, 2023 at 10:04:51PM +0800, Aaron Lu wrote:
> > > Could you show dmesg of the first kernel before kexec?
> > 
> > Attached.
> > 
> > BTW, kexec is invoked like this:
> > kver=6.4.0-rc5-00009-g75d090fd167a
> > kdir=$HOME/kernels/$kver
> > sudo kexec -l $kdir/vmlinuz-$kver --initrd=$kdir/initramfs-$kver.img --append="root=UUID=4381321e-e01e-455a-9d46-5e8c4c5b2d02 ro net.ifnames=0 acpi_rsdp=0x728e8014 no_hash_pointers sched_verbose selinux=0"
> 
> I don't understand why it happens.
> 
> Could you check if this patch changes anything:
> 
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 94b7abcf624b..172c476ff6f3 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -456,10 +456,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  
>  	debug_putstr("\nDecompressing Linux... ");
>  
> +#if 0
>  	if (init_unaccepted_memory()) {
>  		debug_putstr("Accepting memory... ");
>  		accept_memory(__pa(output), __pa(output) + needed_size);
>  	}
> +#endif
>  
>  	__decompress(input_data, input_len, NULL, NULL, output, output_len,
>  			NULL, error);
> -- 

It solved the problem.
