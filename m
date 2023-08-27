Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1736789AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjH0CTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjH0CTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:19:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31F1124
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 19:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693102756; x=1724638756;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vyhJeu+qy5rINhT6TPkbLSNglM1dB1xC9pLrqF1cH0w=;
  b=b0p+1YKtr2Npvn6K4pCETpyN0G++VABJ0XnfjiSufWn0pWBuX94suZi/
   lbEWO5X1O7di4Ja08HimO96cij3LQt8Srwi5RYtl0Vcp5ed5HW73IW6dy
   uLD5U6bdiLPEKMLj9KvqRBiHUpRD72UqE/zWNcdGVtdF+QEyDg3lC0wsQ
   FK/fX6B0v0N3KsIZObl7h6nkJvfxUdFM3BMoAEchJU3u/b18luDg+AdAk
   EBMLE04HtrOdzHEz3wMECfiqnL1PmCFuL00ocGsCJX5q1tfUyro8KqWvz
   EiJyUf4m2ubTtDGs/88xe1tJ/LKjACYC8HsWbCiCQAlFDD+0Zp0qbzhXw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="354436997"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="354436997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 19:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="687713104"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="687713104"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2023 19:19:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 26 Aug 2023 19:19:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 26 Aug 2023 19:19:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 26 Aug 2023 19:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5ZMvP9JUxnYTkwqS+TpeKpXbQdBqkWgqL7oXhcp6K4ARw8jMt2uyZjYWPQ7hYSIwHj0HZIhyRCSr5YglJXF2XdIbZKM9LbITBAm4QRw9tRF/XgiLoz0JZXAMh1LDkrRXTXnSMP3Hwy0AP2BbU4a0DUiMfv9jw2/v8J9R6+g4Pee/JN509kfWmsG591UHiv5driDWgaYhmGJyiSZGsqNuRwmkz+cidu21VmaiomCOgFYY8c4bZgmv1ThcRhjoWJcvOIC/ZCLSTAIQfbZk7IeKeW0A2NsH3856ztr4GBAsSd9okD0VvYkXvXQ2HtDN7aMuTUkJkguaQIOlCxyJFY9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c06nD1PIi8XOq88lvOOV7zaPm5JHdl8IUZiiwbFG2E8=;
 b=KjKhU0xW5DG8jbsJ347+dLUnpDb9gignU0DOPLFfNDSTHaLJj99Wh1AlUp9dbGtEKcufUwCm4Fpcc9B+L43G8lAIr43bcChP8/u4mRpYAlfs8TycdDsqeClrvuhWH1cAkm76rBRh+0RjCPvxyHbkIrbeLUlSgXD6xtupbwAvX6eHcVhjPGxIHyw6j3lBpkWgovjPCPzowgVYo+Iq8N0IZ1YKR9jfm9K45SDbMpzpYt2luX9B4ZfSnPUASXPytm+TL77YY1j3UkeGHhOyJnTyIBiWrTviFQQ55W+iPnRWPHRUX89XadfZVsMegjwniG3ammdOQi7almMl1qzWOFOC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sun, 27 Aug
 2023 02:19:08 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d718:207a:ec74:2556]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d718:207a:ec74:2556%5]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 02:19:07 +0000
Date:   Sun, 27 Aug 2023 10:18:57 +0800
From:   Philip Li <philip.li@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [gustavoars:testing/fam01-next20230817] BUILD SUCCESS WITH
 WARNING dbd3e479335bc8b09ea540102109ac38b0a73336
Message-ID: <ZOqykd6tVGip+Swy@rli9-mobl>
References: <202308181544.cTQDCUcQ-lkp@intel.com>
 <d8fd6210-84eb-6d32-6486-1d90c86186ca@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d8fd6210-84eb-6d32-6486-1d90c86186ca@embeddedor.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SN7PR11MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3c88a6-c843-4b86-a82b-08dba6a3fdab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XX1Wbb/qg2lPi6AnE+7rY5s/2Kf+ppobQl0pGaZke9YkhyOK0cQpfZupkpjNpAP1XEor2xKH0LnURBnWfNwfsGIe1G3GEa872BK7v0VJRgBPTxroKYv9LDbF7fYxSEUSheMsR+83RmjfjphdGhd13P+onaYc2lhprXbBr8c6az+0Hrr1RvrCfN0KB7/Go40eiJ4PAvJhnkVg/E4DVYXm2zYGTpRcYT4QkgCDFniMYy1/keVW9b/JGQz95COyYW5/AtdNT3755V9Xv7pDMhVKrasFXxxb6uSNpHpmFhpn5FOBB3t4bGis/6DfY0oa4FA1dnh+1x8BeON5Tdk+i7fko/molmAU9WqjzxQCNQI9jYfRWNudGVl01teROcb6fgRY6djzPCN98hYoDIffnmXFV8GyWL8mCz4c9TK3Uy4kToi/JAZa2eJ+exaC4SWmCdahlmw+lMTSket8gedBAjTYHUCLzeRz47DkAtyLAsEf3d+vuGS5fGu61ghoaUO38O/FQJV7raHqGd75tWWU7KaI8fF+ONBvoaEeBqtpA5MNyELAdeyC6nOESBXScnfw678aA9PNqI/PtjhfV1OMV7BFdOBUOkS4tujA6yIemOv4tbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(186009)(451199024)(1800799009)(41300700001)(33716001)(38100700002)(6666004)(86362001)(83380400001)(82960400001)(966005)(478600001)(26005)(9686003)(6512007)(53546011)(6506007)(6486002)(66556008)(66476007)(54906003)(6916009)(2906002)(316002)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8q1D+MpbsNVY2FXozSSIh/LLm6nPxa/948Jw47qR8WzxHShrnw/iE8tX4Ty?=
 =?us-ascii?Q?hBJlpkIhoWWHOQrgPVzfFJmIUy3yc5wNtMh1bMqFjRSWw4zggW9uSPiDPLeb?=
 =?us-ascii?Q?G5Bs0fPGAeIeHDArix43eQeICP/kmmaFi6LPMtxFYOT+LU1/zdP54tgFRsrY?=
 =?us-ascii?Q?frg4rC45wP+53v5PhDumLLqKDkGmSd/Hegd2znob5HwAQQwQ3edza9dK+sbx?=
 =?us-ascii?Q?JEzXIeOrHb+8hL9hpydn9O2ATG1NMOrflUejgawO7ILNr7UJ3pnuEyEQjzd/?=
 =?us-ascii?Q?nnMmQ8xbdXqK9NWZLj3lmJiEB+Mf+MQo5drGs2TlpxAdqePvQRhTh13S/Wsz?=
 =?us-ascii?Q?kZw1Vaxf7SWSug71qAEh3tksSMm61fTdYiCud8VpgYwLKhF5rZPElRtZQEyf?=
 =?us-ascii?Q?Ehm35dBTQeaVteVq8MBYeyMHS0/AjJpMG3myr7zkDGc1lUyga7TVPTVvBSJ9?=
 =?us-ascii?Q?mZwdujko5zLLHp3Dne9D6r7JKcIGC/svGdc8SuR63GnarviF3pfht5G4HDbL?=
 =?us-ascii?Q?/3di0AezuyRxtBmh5TDH5MzCNtsE39yvJ0IuKdR2QndaXHZYTmWBlT7TblHp?=
 =?us-ascii?Q?vhqwEyq2zLuInPUIm3aWDqq37p68L0nNcCId6Y/mkswMzaih6wUrjWhcl9cb?=
 =?us-ascii?Q?2xUbzkd8XHNieRS+rue0HpaGF4UKk3POjAQskiFU0CludTGBvLx9/db4fKXY?=
 =?us-ascii?Q?vAFCSYcClZpiYkWHie/upOqKNk2wLzEoopo6fHec3rR4aQAnpnPX3U4bCkxv?=
 =?us-ascii?Q?3QN3iSmiFnMWGWMMJX3eA5UEFSnHBRWa38w+I0r/5/GTmaMOM3AVVhAD1PXq?=
 =?us-ascii?Q?GxMj3c55sW+ilQS+pwGRV/kDaezJyxYxA1VFj+P3rGj4qwfpv61p5OsTPmjI?=
 =?us-ascii?Q?QQ9T5fyE3MHieBR3URAznhYTVgUiCp003mFRQu27suNLYSsQ05rUrE1PfJ2x?=
 =?us-ascii?Q?X5vuPhqgAdn055V4URBMEgjfFRCbP/+pWgltOAzb8gkut2FYtGPlVovekiPr?=
 =?us-ascii?Q?DULJO8crXv2hfop8CTHqrxSx7nYywKgntXKljWTM541NzZBzije0TtV4Q4jA?=
 =?us-ascii?Q?Uq/X8kuhhdTl90Y8S2eGvZRFChRp4q4N4ggGmoopumc5ghc1OQWWp82ZIX+v?=
 =?us-ascii?Q?XxuyaN1z79r45IE3zp+oWQ1ZIRF6I+aJNKKqmHEndsZt0W8c3FjF2Iyhuefo?=
 =?us-ascii?Q?zzTas4Yl+9EiwQL/ZLku3lPkYppVLsRtUjU04NJsiZF3mI2El/kaBjHKA37t?=
 =?us-ascii?Q?HRrfOQ5IxFtNc73v/vLQNDzzcZ1UOXjLVfdxC73qiTwhhojRbhPxH1MWDNLf?=
 =?us-ascii?Q?P7CEMQaQj39yMUi/EVH0Vig7/KsMEhlfqv8uVqZzPVQ8l0nHNGvxmhpscSD6?=
 =?us-ascii?Q?UtxTcpFPDjjtK+oDpetr6AytUjOB8yALzGQuhUsDTXf5FvdlHxnrpcqHh8Ln?=
 =?us-ascii?Q?wupwD6YeLa5Lq4vhObEhYGiF7/dt92EITvfwKNZ/3JUoFMy+WQy9jAPx1eMb?=
 =?us-ascii?Q?k8M3jLQMc18O3vRmrWptzoBE+Yjc3edgE674WG+hJUrCvKlWp4IpiVNh07My?=
 =?us-ascii?Q?rpY5/Z1DPb5/Itipj00XNIGt5/+UIjBWInLrQKof?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3c88a6-c843-4b86-a82b-08dba6a3fdab
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 02:19:07.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kb5E2njp0lA686y3Uu3i8KPM3Jjz7hWYDN25BKqwNzYWIHzy5186ShqZ/9h6CAfTwqjI1keV1fbnHkQ5BNuVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:26:17AM -0600, Gustavo A. R. Silva wrote:
> Hi there!
> 
> It'd be great to add to these reports the versions of the compilers you are using
> to build the kernel.
> 
> It's not uncommon that some compiler versions contain bugs. And in cases where kernel
> developers are aware of those issues, knowing the exact version used to build the
> kernel will help us determine whether the issues reported may be false positives or
> not.
> 
> Maybe just one line at the beginning mentioning the versions:
> 
> `GCC 13.2.0 and Clang 16.0.0 builds`

Thanks Gustavo for the input, we will add detail version of compiler in the
summary report.

We will start with the line you suggested, and later will look for a way
to add it to the warning line since multiple gcc/clang could be involved
in one round test.

Thanks

> 
> Thank you!
> --
> Gustavo
> 
> 
> On 8/18/23 01:55, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230817
> > branch HEAD: dbd3e479335bc8b09ea540102109ac38b0a73336  net: sched: cls_u32: Fix allocation in u32_init()
> > 
> > Warning: (recently discovered and may have been fixed)
> > 
> > arch/arc/include/asm/io.h:129:9: warning: array subscript 0 is outside array bounds of 'volatile void[0]' [-Warray-bounds]
> > arch/loongarch/include/asm/atomic.h:174:9: warning: array subscript 1 is outside array bounds of 'struct cpumask[1]' [-Warray-bounds]
> > arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' forming offset [132, 257] is out of the bounds [0, 132] of object 'send_data' with type 'u8[132]' {aka 'unsigned char[132]'} [-Warray-bounds]
> > include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'unsigned char[2147483647]' [-Warray-bounds]
> > lib/vsprintf.c:2893:33: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
> > mm/mempolicy.c:3117:26: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
> > 
> > Warning ids grouped by kconfigs:
> > 
> > gcc_recent_errors
> > |-- arc-allyesconfig
> > |   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
> > |-- arc-randconfig-r043-20230818
> > |   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
> > |-- loongarch-randconfig-r001-20230818
> > |   `-- arch-loongarch-include-asm-atomic.h:warning:array-subscript-is-outside-array-bounds-of-struct-cpumask
> > |-- mips-randconfig-r012-20230818
> > |   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-unsigned-char
> > |-- sparc-randconfig-r026-20230818
> > |   `-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-forming-offset-is-out-of-the-bounds-of-object-send_data-with-type-u8-aka-unsigned-char
> > `-- x86_64-defconfig
> >      |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
> >      `-- mm-mempolicy.c:warning:writing-byte-into-a-region-of-size
> > 
> > elapsed time: 845m
> > 
> > configs tested: 111
> > configs skipped: 4
> > 
