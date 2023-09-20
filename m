Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E687A8773
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjITOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbjITOpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:45:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB200AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695221094; x=1726757094;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=KjVmvZYD2ac5YjUXkYBPdxIVRMqn1s2+yC2UDHQv75s=;
  b=nWXr98AwAIvl4R6aZbc8ULZAXSJjLnFOYTfSgHPaVojwlP27dKP9qgv4
   HluIqXoNqKMaJhF82EntEgfMuMatC5eKK/wGmKUSdj6yAOOW4+Rw4J8/g
   nWOBvTrTdzvpWHpp2ZuNpWXOT7UEC6YOEvmw5AnqoxFL8/8GnZA+b7sfU
   +7jnh5HJ7XvnzXHmXOYMmedsH1zxl1N9YiP0wQ9eOoGA02AHqRO5AMYrB
   yxoo4s42Xaq8mxZvcdt1K9hYDVUd8MtwpYx+5enxUZlmVD7JWrwL6l7ZB
   wTtV6ly16A2sEszUrtyE7TeYhvxdkPSheoCSGSTZN1CaqUIpWYdAwVtNm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466551974"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="466551974"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 07:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="749939082"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="749939082"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 07:44:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 07:44:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 07:44:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 07:44:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkwpK7OAWLE1rMKmdhh34D2TsboyNP97FYhc3QW/Dx7BApfW4S/z/N/HvTTkTU6gTFltn2oSSeyOe05vOBqEGxJ2BajuxdQoZkxwmzWY2J7PZNS1JDdksnUdkmvdGAq0LSBSkm8MidswtnCYbY0yyDG03lNg74/8pyvqYiLh8Aa0YQhSqQ9sfY8wpsg0FuK30zaCqPJuE6qR/eP+2j6UWSwbfXjDzSV47fdgs5ZUP3D9f5F5SDqayIUwmQt1tke1b9MyfZJKgo85Q5BhEf+UK3xruv1UG2zud0+enujDHUDnTmCDrsANlGZgBfS1ayLoXqSLrhNwsJO9dHCONYb2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhtvhI1L/Vo2bTdF2RBzj9L0gyLVCie3DwqJIB5M/m0=;
 b=d/WSJbAL1aktuQZPpNGNh3pbt5kkB+BW2WkwoOOoOJqbLb7GwvQmCFjquWXJr8PqxO8v1wNjbHMfmga8LrSDA4pre86bO7r1Usb3EawGbpmNqhClziXp4ypN1XBuWUVArdabl+YesamYbztpp/oaiTyOkr1dnHYMp+Juin5BHQUwCrjMC2/MZwTijZcOu+T8PLRgvKC18Frz5s9e1M8ygCUePK/qaZo9AVoNT/T28+jlkpi+oVftboO90ez6XqffgrTcnG7pipy6Lm9JPFBWUKO1Ug2/UABhG/GmOi0FKL97ACT1fjCj3xIphTChXsQTiaplOFp0FjGg/40x3k6ueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS7PR11MB6247.namprd11.prod.outlook.com (2603:10b6:8:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 14:44:48 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 14:44:48 +0000
Date:   Wed, 20 Sep 2023 22:44:34 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Zi Yan <zi.yan@sent.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Rohan Puri" <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH 4/4] mm/compaction: enable compacting >0 order folios.
Message-ID: <202309202236.2848083f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230912162815.440749-5-zi.yan@sent.com>
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS7PR11MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: a39f7a38-bcc8-4c68-13cd-08dbb9e8232f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/mugVg59FORKJiE6BXvjhfXojLAXLPQ5z35K2BG6gbIlBk1r2dI9fo+wLr1r9cgKJ317Rvvz7IrDJc3ArSx24ZN0B/PTMHVwRUAYDXc2ripk3uF7vEqpK7tJlMqE1DeX9xvnYFi8aM3Tb6rmxIA4831rcCRuDw7B5xgOPOEoCajJpd3AumX9pY0TyYU5DgAkdZEZij5hkZqudEBOfe2sClkICDlVLB1/kPU494rP5UCxZ2sVtyvKmp9+bo8CoXjQUdMXXZTTVRxQVCgXrht3JfecF6TrRZ1szEwAj3B6GpgyXnO2qbseTEidIvjplPZwQD0x4rqBKGvDjG1r6DDndRwZxn7qE+xFgpjkcuu8KpaiP4NMJqNUxjtQnkmVCMHgo8QEwLdFchVghQqt9KNaFFsB7eKRXGp2p2FtC2YqwIJdJJ4IeApeow1KohafFGLoqZzmS9tM8Ge1JSPIlPPdj/gbbFuKvSxT6+muyTaHcS5ummz77fqLrBG8pfCzf6/qFj97+GSfFkwJw60iLiFtDeWzRyQPozP1IqG2ItzmNmHPh0cll8c7KLnAKtMvWvzJomFF1hOprIxnpCGjUJ9vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(186009)(451199024)(1800799009)(478600001)(45080400002)(6486002)(6666004)(6506007)(86362001)(82960400001)(36756003)(38100700002)(2906002)(26005)(6512007)(83380400001)(8676002)(8936002)(5660300002)(2616005)(4326008)(966005)(41300700001)(66556008)(316002)(54906003)(7416002)(66946007)(6916009)(1076003)(107886003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZmQc7KPRsUlBSWB1vqD/19Iw9+GVW5rZeDv5tOCWQZYE4/ca84dJu3/YCdI?=
 =?us-ascii?Q?sewxtVG60AQ6vaQfeX9s2OirP/P/gPiZ04Hs46JLpm1NaQog+7mgiOVPlwU9?=
 =?us-ascii?Q?Ir8BJ9lK33dIgZvZuVwaFPaGJf20kscn0eERElphZtXlpjgcAz+UPbWeiGXx?=
 =?us-ascii?Q?6RrN40RcaJasog+avvGB2lCeb08XXJ4VThWwBYhaWuutM1gtw0wO0QsKTonS?=
 =?us-ascii?Q?U1CfnkLs36L2CBn/I9Wwyz2utZYw4nD5eMmDhlxQj+7qR2AQrwr5FJI4cwIe?=
 =?us-ascii?Q?BZFv2T6dDXOGs9nPezhswREKXwbhyfeQVyJ2ChNQ+sSOU21dy/6a4jKNgkG2?=
 =?us-ascii?Q?bTM0W9dp3Ywdqiv9cRHEI1LuLawf73wgFLViMxjW0Y6/mgooJ1bUMyGnuxkv?=
 =?us-ascii?Q?FP3hsQJAQRuLO8qaXqK6YmWp14pn4bqjOKRftpibNxbpiXIlGbE6le/dhuBZ?=
 =?us-ascii?Q?xrzeOneGjc/DCC8YMYsglUxSSGPHzpRclGPynUXxFOWViUOdziF+Ye2LeD5F?=
 =?us-ascii?Q?MxpJs9amsLnAzZ61791yln/ezWndk/MY2+DSnJmSTsJloGS4QvcV+bmMSsOa?=
 =?us-ascii?Q?OZy4bMALc0hRVaSPOkoJjv0fS/EHpcb7k3Wo0xlYNtG6r2JS9y4gEmlRjdv5?=
 =?us-ascii?Q?80EhWy3gpAS9qRQ+uqXuG97WJIZv8jEem7/AuyT4e9WzOKbF0Pd3GnFeNqrA?=
 =?us-ascii?Q?k7gKcBTu5YgJb+WoOUnoUF7XVYwZZUrDGBq8Z3I+Oyw9aACkGVNQMwvPCV9/?=
 =?us-ascii?Q?t7S/+a7xS65atMYhF9XtehSJSFlK6m7+Nx6iNWa6mvQdFg+qyGdgqLCFUrB9?=
 =?us-ascii?Q?gAuaHlCCaaIng1p8ma1y6UH8TvEmdh8maCdHQNQtQGqXtRD+FyG1j3KZFAgZ?=
 =?us-ascii?Q?2lcTMmiHU8XXItmlj8I3+iVOm8X8g0H2+jx9HK7Wh/DBlpQDyFFji51GjM7N?=
 =?us-ascii?Q?FVgv1sQyBXVgwO3Y4/ZPfHSR1PREE1zEfBxprIvVLg4y45TpBwa3BTf7k9sS?=
 =?us-ascii?Q?Dm0r4RXJY/EWYyi4H0xvoXqF1N2G6cmYem3eeMC8qmhYPvXJy3K5nN9rzVgH?=
 =?us-ascii?Q?AId1rdi95ON/8Rjd6UbXj455UzqHrEp6KmrzugoL+iWRncdrqxDwK68eXjd6?=
 =?us-ascii?Q?sgqLBJviWT4TTIMQZHMizPgR3mCnUJFABhvCuRGibvm39Oo371LE3FYgVZ40?=
 =?us-ascii?Q?TjpFq91FEmirHtH7Da5O2aVhHKbzkHO7yJWZFJ2hdu4bPGfbiNM8Q3Q3cJ0V?=
 =?us-ascii?Q?5FR1HecbB9R7ZEfcqdPUg00ZpOaTTfmTkql3haz9releB6ix8NM83zHG4+oL?=
 =?us-ascii?Q?pWQeOqRYSGzq+uE6oczZIHRYgRZg/rQVosiilQvYj+wNHwBIJxGnWGsYIAiT?=
 =?us-ascii?Q?sCI0bRw17TouBfGoGM6aOYRrbHA1T++mPpUYnt+TfENbMW6gO+xLkqrziSDw?=
 =?us-ascii?Q?QOJZaL8N1vcMWQRp603+RQQugUFMlrHadRf7HypOjfbf5rVRpjIuCNOA625z?=
 =?us-ascii?Q?/EOqV4NsYR+JEYqeIVlmQIYVS+XoR6eJ0RsCVRY1W4hXCOKnIP5YyCIcfPFj?=
 =?us-ascii?Q?jXSfalJ3aygTMkOk0z80qv/likDdqubIghSnrsgelxqB74X5v2ydqY04165H?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a39f7a38-bcc8-4c68-13cd-08dbb9e8232f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:44:48.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkVMaLUKew8ESEAJqq5w6zD+donrYtbPPA/AGuZtlVYw70W0fzsh52h+pTkJW4Lzmi+9vYz4TaNTeponemnUkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6247
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "kernel_BUG_at_lib/list_debug.c" on:

commit: 810d9ce367799ba4fef1e894b342e5ab74d44681 ("[RFC PATCH 4/4] mm/compaction: enable compacting >0 order folios.")
url: https://github.com/intel-lab-lkp/linux/commits/Zi-Yan/mm-compaction-add-support-for-0-order-folio-memory-compaction/20230913-003027
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20230912162815.440749-5-zi.yan@sent.com/
patch subject: [RFC PATCH 4/4] mm/compaction: enable compacting >0 order folios.

in testcase: vm-scalability
version: vm-scalability-x86_64-1.0-0_20220518
with following parameters:

	runtime: 300s
	test: lru-file-readtwice
	cpufreq_governor: performance

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/


compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480L (Sapphire Rapids) with 512G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309202236.2848083f-oliver.sang@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230920/202309202236.2848083f-oliver.sang@intel.com


[  104.256019][ T1493] list_del corruption, ffd40001e3611490->prev is NULL
[  104.264911][ T1493] ------------[ cut here ]------------
[  104.272315][ T1493] kernel BUG at lib/list_debug.c:54!
[  104.279501][ T1493] invalid opcode: 0000 [#1] SMP NOPTI
[  104.286658][ T1493] CPU: 91 PID: 1493 Comm: kcompactd1 Not tainted 6.6.0-rc1-00153-g810d9ce36779 #1
[  104.298169][ T1493] Hardware name: NULL NULL/NULL, BIOS 05.02.01 05/12/2023
[  104.307252][ T1493] RIP: 0010:__list_del_entry_valid_or_report+0x6e/0xf0
[  104.315987][ T1493] Code: b8 01 00 00 00 c3 cc cc cc cc 48 89 fe 48 c7 c7 80 c1 71 82 e8 e3 37 a3 ff 0f 0b 48 89 fe 48 c7 c7 b0 c1 71 82 e8 d2 37 a3 ff <0f> 0b 48 89 fe 48 c7 c7 e0 c1 71 82 e8 c1 37 a3 ff 0f 0b 48 89 fe
[  104.339068][ T1493] RSP: 0018:ffa0000010a37910 EFLAGS: 00010046
[  104.346919][ T1493] RAX: 0000000000000033 RBX: ff110080749b5ab8 RCX: 0000000000000000
[  104.356938][ T1493] RDX: 0000000000000000 RSI: ff11007f416dc6c0 RDI: ff11007f416dc6c0
[  104.366914][ T1493] RBP: ff110040b00af858 R08: 0000000000000000 R09: ffa0000010a377b8
[  104.376873][ T1493] R10: 0000000000000003 R11: ff11007f40dfffe8 R12: ffd40001e3611400
[  104.386808][ T1493] R13: 0000000000000000 R14: ffd40001e3611400 R15: ffa0000010a37938
[  104.396739][ T1493] FS:  0000000000000000(0000) GS:ff11007f416c0000(0000) knlGS:0000000000000000
[  104.407739][ T1493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.416072][ T1493] CR2: 000055a550b5eb38 CR3: 0000008069078004 CR4: 0000000000f71ee0
[  104.425986][ T1493] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  104.435870][ T1493] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  104.445790][ T1493] PKRU: 55555554
[  104.450668][ T1493] Call Trace:
[  104.455221][ T1493]  <TASK>
[  104.459360][ T1493]  ? die+0x36/0xb0
[  104.464363][ T1493]  ? do_trap+0xda/0x130
[  104.469839][ T1493]  ? __list_del_entry_valid_or_report+0x6e/0xf0
[  104.477666][ T1493]  ? do_error_trap+0x65/0xb0
[  104.483614][ T1493]  ? __list_del_entry_valid_or_report+0x6e/0xf0
[  104.491418][ T1493]  ? exc_invalid_op+0x50/0x70
[  104.497453][ T1493]  ? __list_del_entry_valid_or_report+0x6e/0xf0
[  104.505246][ T1493]  ? asm_exc_invalid_op+0x1a/0x20
[  104.511655][ T1493]  ? __list_del_entry_valid_or_report+0x6e/0xf0
[  104.519423][ T1493]  split_huge_page_to_list+0x3ad/0x5b0
[  104.526306][ T1493]  migrate_pages_batch+0x1f6/0x970
[  104.532797][ T1493]  ? __pfx_compaction_alloc+0x10/0x10
[  104.539564][ T1493]  ? __pfx_compaction_free+0x10/0x10
[  104.546219][ T1493]  ? __pfx_compaction_alloc+0x10/0x10
[  104.552955][ T1493]  migrate_pages_sync+0x99/0x230
[  104.559201][ T1493]  ? __pfx_compaction_alloc+0x10/0x10
[  104.565917][ T1493]  ? __pfx_compaction_free+0x10/0x10
[  104.572522][ T1493]  migrate_pages+0x3d9/0x530
[  104.578341][ T1493]  ? __pfx_compaction_alloc+0x10/0x10
[  104.585033][ T1493]  ? __pfx_compaction_free+0x10/0x10
[  104.591617][ T1493]  compact_zone+0x286/0xa30
[  104.597313][ T1493]  kcompactd_do_work+0x103/0x2f0
[  104.603487][ T1493]  kcompactd+0x238/0x430
[  104.608873][ T1493]  ? __pfx_autoremove_wake_function+0x10/0x10
[  104.616315][ T1493]  ? __pfx_kcompactd+0x10/0x10
[  104.622284][ T1493]  kthread+0xcd/0x130
[  104.627371][ T1493]  ? __pfx_kthread+0x10/0x10
[  104.633117][ T1493]  ret_from_fork+0x31/0x70
[  104.638664][ T1493]  ? __pfx_kthread+0x10/0x10
[  104.644390][ T1493]  ret_from_fork_asm+0x1b/0x30
[  104.650309][ T1493]  </TASK>
[  104.654264][ T1493] Modules linked in: xfs loop btrfs intel_rapl_msr blake2b_generic intel_rapl_common xor ses x86_pkg_temp_thermal enclosure raid6_pq sd_mod scsi_transport_sas intel_powerclamp libcrc32c sg coretemp crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel nvme sha512_ssse3 ahci nvme_core rapl ast ipmi_ssif libahci t10_pi mei_me intel_cstate drm_shmem_helper crc64_rocksoft_generic i2c_i801 crc64_rocksoft acpi_ipmi drm_kms_helper megaraid_sas joydev dax_hmem intel_uncore libata mei i2c_ismt crc64 i2c_smbus wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter drm fuse ip_tables
[  104.717626][ T1493] ---[ end trace 0000000000000000 ]---
[  104.807226][ T1493] RIP: 0010:__list_del_entry_valid_or_report+0x6e/0xf0
[  104.815628][ T1493] Code: b8 01 00 00 00 c3 cc cc cc cc 48 89 fe 48 c7 c7 80 c1 71 82 e8 e3 37 a3 ff 0f 0b 48 89 fe 48 c7 c7 b0 c1 71 82 e8 d2 37 a3 ff <0f> 0b 48 89 fe 48 c7 c7 e0 c1 71 82 e8 c1 37 a3 ff 0f 0b 48 89 fe
[  104.838334][ T1493] RSP: 0018:ffa0000010a37910 EFLAGS: 00010046
[  104.845773][ T1493] RAX: 0000000000000033 RBX: ff110080749b5ab8 RCX: 0000000000000000
[  104.855343][ T1493] RDX: 0000000000000000 RSI: ff11007f416dc6c0 RDI: ff11007f416dc6c0
[  104.864898][ T1493] RBP: ff110040b00af858 R08: 0000000000000000 R09: ffa0000010a377b8
[  104.874452][ T1493] R10: 0000000000000003 R11: ff11007f40dfffe8 R12: ffd40001e3611400
[  104.884001][ T1493] R13: 0000000000000000 R14: ffd40001e3611400 R15: ffa0000010a37938
[  104.893543][ T1493] FS:  0000000000000000(0000) GS:ff11007f416c0000(0000) knlGS:0000000000000000
[  104.904152][ T1493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.912119][ T1493] CR2: 000055a550b5eb38 CR3: 0000008069078004 CR4: 0000000000f71ee0
[  104.921634][ T1493] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  104.931149][ T1493] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  104.940655][ T1493] PKRU: 55555554
[  104.945174][ T1493] Kernel panic - not syncing: Fatal exception
[  105.991260][ T1493] Shutting down cpus with NMI
[  106.046902][ T1493] Kernel Offset: disabled

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

