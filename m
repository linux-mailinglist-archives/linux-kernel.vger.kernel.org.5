Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798297EC42A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjKONzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjKONzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:55:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEDE127
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700056525; x=1731592525;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TdFFV965Ly/Xin3/FG4ncI3zGfQsBv80HPMGYPqk6TE=;
  b=S5vsK203GZ2hWkIeBiVPWWquKxBnlwJLPYK1g+B8yZ93+3PFJ8M8/Hor
   xKYVoGyA891/5+wefvf9C+deC9NXh//btTtp9dGoekYgNRZeClisS1aLo
   rzIl1nhgQwa0Vhk7YR4qoJ5q1WbSDJd1N1yLYPW1YMn4LrHy2uhG/1oUs
   lKAiomDSPnLfuFeR81xm1Qg27+JWDL/o/ZiglxWt8VuCFE2MCoUeWDezg
   xl/ShzqbJUUDwA/F+4N7km9a5zVg5oyfzcuOPXG1BQEEbdBB8eLyFHq9R
   J5TL8uOSB2ts1XuKUKXWKavroUvMCgn3d6IXC95MgpXSwrDxFH8ox62n9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="3958375"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="3958375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:55:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908781633"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="908781633"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 05:55:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 05:55:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 05:55:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 05:55:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 05:55:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNiXsZDqIho4VyjhgDDXUqI35GNkJwrb9RFMYTQGdPT+cyiBCF1rRfzD4jMeOxpP9R9sQfJvCQ0ugP/ZCNLrHMupvmNt3foc//Qvez4qx0dYRUi62yu4f0NWMAmj+Bd1ge1V1GctiCrqnTLuIESQ49EZTq41Po/TWmHo+eLVpcTWr9GNQelOdcCxpteyWW22k8Iqwuu/zFu284xzs0orzwIEjF1sDnT0jlaWTHsmhXxroHHqiAW5L2vvPEDnj2CobaCCC+vR+KJWnniY4RWA1rrorQxN4HQYQGorkR8Q2aJ9ii0AB0a7SC0wz4fPXPFH4VFew8W+Q78HvZfPyDKimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6lgTZ+XPNYiVEHtswnzdHOkJll7hURKAVIkRuU5mQs=;
 b=BLoUrfls7xHfJJICG24rWYEIiPWf1P0bnrapBQt2iP1UHe+TnN5C+1tu+lGJxbg/yFYyi10jNOts0Q/cRhV65w7cG7XqvbTdIuNN9d5B01W6cmRDMVY8aUjGpxdtTNAkkTwz5FxXbR0cEZB5V+h+UOY1nBxtMTQTO9rsbrozQ9DZVB4tJJqIg5P6fOFSZrgyvW9ItjTo5fgBLRjFnmU+tmKuoqnGDvBKrT3cNW3d9n/1p0dEiM+OjQEM4eomX1Da8Pbff0XgYMP/Tyqc35rYJe+v+d7/FaOKbzCr+Hg1BUnfBbqN6FybYkFKtnRHFXGZVXIQCga+86fkUIWhWbKU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 13:55:12 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 13:55:12 +0000
Date:   Wed, 15 Nov 2023 21:55:00 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <bsegall@google.com>, <dietmar.eggemann@arm.com>, <efault@gmx.de>,
        <wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>,
        <daniel.m.jordan@oracle.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Message-ID: <202311151636.fcc1117b-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023154319.102437-1-daniel.m.jordan@oracle.com>
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 090ad882-993b-4796-29e4-08dbe5e27c2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Eo2cCRCEsSBgx6txfx2yMQuoviAJEjllqgFQ9mUGIPd8xWk/CBjMQsVGxa3EpIuJkKek6Puo02VLgJfYM671ixDZLkItp+qMzmfY8zjJ3AytMEWazEEh7FygMmS1D0Ncbwm8TcMEFCly+6ETsOTQeXpy28KZawXRaJ0QexGxZJNWOh7Qk/S7rjD2ZpJZlv8IztHAJdWS87gQDDLLjuqNGdu2oBF4La9vPoFMibDCLMEoKZOXcRBMIMG+6ybipLFySAubOrOs6igcC16LY8Xk+OWb8KJ/CmEajOQ1aftlxXtmCMuiZmUz+pTEO5+pd9xoIqGqZIEQNKNZ2Gt+V8O9Zi66ZxSH2QItxT9TC0v+XCCwGAveWCK5muwtCuHG0D3SjTv7Athf2cRwfN3/fwLW1V97X6We/H7FuQ/yt40QfsgcQKH/gtjMpar0W2zZrhxCbUdQFvs4x4FRj2ZcZ0z5h55/cVQnsuAKJ5Av5//zSHGo7FqPjnWCh9KLJj1KgEXJXUEdVrViJrGaH/LSi6/8oTkRyBtEw8/tKFWl+NesYr2AD9PPv0kbEr1WlSk+iCKpaVTmoXo8AMWP/kBhQLJBZ47l2xjGJYVrnDQNSXxur/BcFWFEq+ghm6kyNw8bZIcOhqnsgf+QkcmDAkFkDQ68Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230373577357003)(230473577357003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7416002)(38100700002)(2906002)(5660300002)(86362001)(30864003)(6512007)(6506007)(83380400001)(82960400001)(1076003)(26005)(2616005)(966005)(478600001)(6666004)(36756003)(41300700001)(6486002)(6916009)(316002)(66946007)(8936002)(8676002)(66556008)(54906003)(4326008)(66476007)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wZDc2WqCOGo85EIVGJwP3+vDTnGFMJTUbqpDcTbGndZJUnj2MCHwgQTj8e?=
 =?iso-8859-1?Q?JyfS/Sj/+zwX/JNB28f+LkGxCSI3fKG/l0Gcu+Sip/+zSvGgfKAEBk//0+?=
 =?iso-8859-1?Q?fDS/VtgTwqJepsPMZQMdUcPe3apQ3VKiepCod5pyVWXHkccvtDCnKoeqT+?=
 =?iso-8859-1?Q?TotgpgSCI+ChtsyXJW1CIISDexXPN5MfAzJJK+bESiuL0mDJ/4xgiK5rpV?=
 =?iso-8859-1?Q?6R1oy//P7wuOr0hZ7Btpu57zwMjFyU5vjTn+SibEWxu1h9+ScN4dIkeQ37?=
 =?iso-8859-1?Q?mWcTLapsVE3au48BbP1uK6M1QT52oOG+2W142cVfPskTMJA0LBti6+dw4E?=
 =?iso-8859-1?Q?rml6KWxQ+5Yy6yBYyjv89tiupDn3iYrnETlM494g9S1KGUPpAr9XF8/UNf?=
 =?iso-8859-1?Q?c/vG4P/z3IeawQv9nfrw1RlZ7mFOBo9RabdNLlI6cM70YVtrDGa9EZcCYD?=
 =?iso-8859-1?Q?h3Cf8TlmBIdvy2679/VHTqczWpDeg5cXTraXrwPO4kv/j/uDRLuuMG8vcV?=
 =?iso-8859-1?Q?4gvUjQ3Yj+DdFQXXCG246Jxymt7wQ//ApGPFWFjOrOsrTp73WsrIZrHFhr?=
 =?iso-8859-1?Q?8BgUWjYzWh5jFQ2kR0p87sh095NwNPN2pXAOJXK9ndlISaJ/5CyKo7yTaJ?=
 =?iso-8859-1?Q?7zPXAdUY2ghX6T3g7A3+oLP5XMMcQOjvGr/mZJpDRCvT59KULCxSHZgQMa?=
 =?iso-8859-1?Q?9D4RAHGwKVWbtuZo5K9fOZif0e2+Nwv/HlGgsQUJN921TLSKr5oMZnDNBS?=
 =?iso-8859-1?Q?DaJ3Uub0ym8G/4323cilSEMANW1Its+cya56aboKao0NAQGaTjoWSLqjzB?=
 =?iso-8859-1?Q?tFucs/umUzXI1WJCyIqLEfp+aGaFvHrZhpF79A1EboxxJCzor5R5P+DNW/?=
 =?iso-8859-1?Q?2LyP/eY/OYLwq2rJaJmedw7Vq139dDGk/Lv3nM4q1HuTUgLOCcqxWv/PLc?=
 =?iso-8859-1?Q?eJmhG1j5N6faJFiNJzvq0TsQGXDiL4QkXpPU1rfHOnPRj+Efszrvfvtxhh?=
 =?iso-8859-1?Q?wtYtIUOVIR2Gyx/gQ9K+7F6E9l9gM2fF5jrgPkeYZ4tveAL0rKPFPvpvLq?=
 =?iso-8859-1?Q?H0SV/32CH5Xk6yiSGk2yCPtB/no3a7C7lR7gotgv0wmtqIoksrf7UDDMgA?=
 =?iso-8859-1?Q?L8DP6sU2ATYchrTPbogHuet1OS6TXP8AYtl68pBQvIbVh1MWxsXdvyZOEd?=
 =?iso-8859-1?Q?OE3sDDY2BBGkoe6cz44tFopuc6HIu2SQELMJWJVr7OJ4wkuZ/IYqf6Jdlo?=
 =?iso-8859-1?Q?6gutu+v7VgfMNigMQ+Poy8kj4pb8k9PwKj7/+syN5L9ea8uHvbZ4+mHFAB?=
 =?iso-8859-1?Q?Dv8nzd2031IaWx27Sz1atcowB4ORhpLD9GxYr/Th4KeZU5BSsp2f72wtBx?=
 =?iso-8859-1?Q?mspUozbcDGdkakr60AbOucV/RXZ7aZcn/3NodNKGUBkwBQYjNfVjFFAKF9?=
 =?iso-8859-1?Q?GqHHHbbiRl1cYSz0t5GFsksp+VWkIym+RRikQZ2IKcnAdo1Cn3Vl0e+TtB?=
 =?iso-8859-1?Q?IWU816aFYbiiyacf5fWuSbFyXTTwvex4Nghwatu+STiOOca9Pfq7QP8LLV?=
 =?iso-8859-1?Q?NCCy8eeh2ERE4C5ny9bDzVsVLfwa5ysfybbWXeT9/6LxqtgaFo3Lv6JrJX?=
 =?iso-8859-1?Q?hz6i0VBnqDW5JOCuep+BK2f465BMFZbZWB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 090ad882-993b-4796-29e4-08dbe5e27c2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 13:55:11.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mx3o4CQFmzF4LyiloN0FxutWXM7dOAUa1pTnmdH1CN8sqfkNJMcRfh+ShqwcEJeZBJzIjmVcpW+R0LbvywosHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 40.9% improvement of stress-ng.sigio.ops_per_sec on:


commit: 8ffa799074002d86c6164e9ad782d92f327721e7 ("[PATCH v3] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline")
url: https://github.com/intel-lab-lkp/linux/commits/Daniel-Jordan/sched-fair-Preserve-PLACE_DEADLINE_INITIAL-deadline/20231023-234710
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 4e5b65a22ba0cabe58f895cd797cb10a763d6994
patch link: https://lore.kernel.org/all/20231023154319.102437-1-daniel.m.jordan@oracle.com/
patch subject: [PATCH v3] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
parameters:

	nr_threads: 100%
	disk: 1SSD
	testtime: 60s
	class: interrupt
	test: sigio
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231115/202311151636.fcc1117b-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  interrupt/gcc-12/performance/1SSD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/sigio/stress-ng/60s

commit: 
  4e5b65a22b ("Merge tag 'v6.6-rc7' into sched/core, to pick up fixes")
  8ffa799074 ("sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline")

4e5b65a22ba0cabe 8ffa799074002d86c6164e9ad78 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    258.00 ± 50%     -68.5%      81.33 ±120%  perf-c2c.DRAM.local
      7040 ± 51%   +2448.4%     179427 ± 42%  turbostat.C1
     51961 ±  7%     +32.4%      68804 ±  9%  turbostat.C1E
     15870 ±136%   +1458.5%     247352 ± 16%  turbostat.POLL
   1530591 ± 62%    +218.9%    4880722 ± 23%  meminfo.Active
   1530514 ± 62%    +218.9%    4880644 ± 23%  meminfo.Active(anon)
   5362555 ±  7%     -73.3%    1430799 ± 16%  meminfo.Inactive
   5362273 ±  7%     -73.3%    1430589 ± 16%  meminfo.Inactive(anon)
   2257499 ± 26%     -47.6%    1182376 ± 26%  meminfo.Mapped
     12079 ± 10%     -22.8%       9321 ± 21%  meminfo.PageTables
     63426 ±  9%     -73.4%      16842 ± 27%  stress-ng.sigio.SIGIO_signals_per_sec
 2.608e+08           +40.9%  3.675e+08 ±  6%  stress-ng.sigio.ops
   4346344           +40.9%    6124205 ±  6%  stress-ng.sigio.ops_per_sec
 1.051e+08           -17.9%   86256650 ±  5%  stress-ng.time.involuntary_context_switches
      1588            -3.7%       1529        stress-ng.time.system_time
    503.68           +12.5%     566.54 ±  2%  stress-ng.time.user_time
 2.514e+08           -18.3%  2.053e+08 ±  5%  stress-ng.time.voluntary_context_switches
     31734 ± 32%    +118.3%      69262 ± 23%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     11868 ± 17%     -38.8%       7262 ± 51%  sched_debug.cfs_rq:/.load.min
     31734 ± 32%    +118.3%      69262 ± 23%  sched_debug.cfs_rq:/.min_vruntime.stddev
    625.00 ± 10%     -62.2%     236.21 ± 52%  sched_debug.cfs_rq:/.runnable_avg.min
    470.25 ±  8%     -58.6%     194.62 ± 51%  sched_debug.cfs_rq:/.util_avg.min
      2.91 ± 10%     -41.9%       1.69 ±  8%  sched_debug.cpu.clock.stddev
     92.02 ± 10%     -19.5%      74.07 ± 12%  sched_debug.cpu.clock_task.stddev
      1.03 ±  2%     -16.1%       0.86 ± 18%  sched_debug.cpu.nr_running.avg
    379771 ± 62%    +221.3%    1220242 ± 23%  proc-vmstat.nr_active_anon
    102036 ±  3%     -11.8%      89979 ± 10%  proc-vmstat.nr_anon_pages
   1342882 ±  7%     -73.4%     357722 ± 16%  proc-vmstat.nr_inactive_anon
    565472 ± 26%     -47.7%     295754 ± 26%  proc-vmstat.nr_mapped
      3023 ± 10%     -22.9%       2330 ± 21%  proc-vmstat.nr_page_table_pages
    379771 ± 62%    +221.3%    1220242 ± 23%  proc-vmstat.nr_zone_active_anon
   1342882 ±  7%     -73.4%     357722 ± 16%  proc-vmstat.nr_zone_inactive_anon
  75670620           -17.9%   62143457 ±  5%  proc-vmstat.numa_hit
  75686923           -17.9%   62154566 ±  5%  proc-vmstat.numa_local
  75685257           -17.9%   62159432 ±  5%  proc-vmstat.pgalloc_normal
  73474177           -18.0%   60233297 ±  5%  proc-vmstat.pgfree
      0.02 ±198%    +784.7%       0.16 ± 76%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.08 ± 48%    +104.0%       0.15 ± 28%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ± 76%    +363.2%       0.01 ± 56%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.02 ±198%   +5087.4%       0.96 ±148%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.35 ± 45%    +551.5%       2.28 ± 56%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 45%     +34.1%       0.03 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.33 ±141%   +2900.0%      10.00 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     62.83 ± 47%     +91.8%     120.50 ± 10%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    264.83 ± 45%     +43.2%     379.33 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 45%     +40.6%       0.02 ± 10%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 45%     +47.4%       0.02 ±  7%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.02 ± 45%     +77.3%       0.03 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pipe_write.vfs_write.ksys_write
      0.04 ± 58%   +2928.2%       1.20 ± 91%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      2.25 ± 37%      +2.5        4.72 ± 72%  perf-stat.i.branch-miss-rate%
      7.63 ± 27%      -3.2        4.41 ± 12%  perf-stat.i.cache-miss-rate%
   7694631 ±  8%     -34.7%    5021832 ± 20%  perf-stat.i.cache-misses
  23380905 ± 10%     -31.8%   15942730 ± 32%  perf-stat.i.dTLB-load-misses
   1279220 ± 17%     -69.0%     397160 ± 32%  perf-stat.i.dTLB-store-misses
      7127 ± 23%     -44.3%       3968 ± 30%  perf-stat.i.instructions-per-iTLB-miss
   2310670 ± 30%     -77.9%     509599 ± 29%  perf-stat.i.node-loads
      1.62            +0.2        1.81        perf-stat.overall.branch-miss-rate%
      5.30 ±  8%      -1.2        4.09 ± 12%  perf-stat.overall.cache-miss-rate%
      2.33            +8.5%       2.52        perf-stat.overall.cpi
      0.02 ± 22%      -0.0        0.01 ± 49%  perf-stat.overall.dTLB-store-miss-rate%
      0.43            -7.8%       0.40        perf-stat.overall.ipc
   7594493 ±  8%     -34.8%    4950527 ± 20%  perf-stat.ps.cache-misses
  23069286 ± 10%     -31.7%   15745301 ± 31%  perf-stat.ps.dTLB-load-misses
   1262448 ± 17%     -68.8%     393354 ± 31%  perf-stat.ps.dTLB-store-misses
   2280155 ± 30%     -77.9%     504638 ± 29%  perf-stat.ps.node-loads
  3.53e+12            -7.4%  3.268e+12 ±  2%  perf-stat.total.instructions
     16.24            -3.6       12.62 ±  4%  perf-profile.calltrace.cycles-pp.__select
     14.26            -3.2       11.10 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__select
     13.79            -3.0       10.74 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
     22.78            -1.9       20.90 ±  2%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.76            -1.6        5.15 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      6.67            -1.6        5.08 ±  4%  perf-profile.calltrace.cycles-pp.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      8.73            -1.6        7.18 ±  5%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.56 ±  3%      -1.4        6.12 ±  6%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_read.vfs_read
      8.67 ±  2%      -1.4        7.26 ±  6%  perf-profile.calltrace.cycles-pp.schedule.pipe_write.vfs_write.ksys_write.do_syscall_64
      5.90            -1.4        4.49 ±  4%  perf-profile.calltrace.cycles-pp.core_sys_select.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.69 ±  3%      -1.4        6.28 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_read.vfs_read.ksys_read
      8.46 ±  2%      -1.4        7.07 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_write.vfs_write.ksys_write
      7.32 ±  3%      -1.4        5.92 ±  6%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_read
      7.95 ±  2%      -1.3        6.63 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.44            -1.3        4.14 ±  4%  perf-profile.calltrace.cycles-pp.do_select.core_sys_select.kern_select.__x64_sys_select.do_syscall_64
      7.30            -1.2        6.10 ±  4%  perf-profile.calltrace.cycles-pp.stress_sigio_handler
     24.20            -1.2       23.02        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      4.83            -1.2        3.66 ±  4%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select.__x64_sys_select
      5.53 ±  2%      -1.1        4.42 ±  3%  perf-profile.calltrace.cycles-pp.__send_signal_locked.do_send_sig_info.send_sigio.kill_fasync.pipe_write
      3.12            -1.1        2.04 ±  4%  perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      6.11            -1.1        5.04 ±  3%  perf-profile.calltrace.cycles-pp.do_send_sig_info.send_sigio.kill_fasync.pipe_write.vfs_write
      6.88            -1.0        5.86 ±  3%  perf-profile.calltrace.cycles-pp.send_sigio.kill_fasync.pipe_write.vfs_write.ksys_write
      5.13            -1.0        4.12 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      5.14            -1.0        4.14 ±  4%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      7.70            -1.0        6.74 ±  2%  perf-profile.calltrace.cycles-pp.kill_fasync.pipe_write.vfs_write.ksys_write.do_syscall_64
     24.84            -0.9       23.92        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.90            -0.9        2.97 ±  4%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      3.80            -0.9        2.89 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.do_select.core_sys_select
      4.44            -0.9        3.58 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      3.23 ±  3%      -0.8        2.39 ±  2%  perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.do_send_sig_info.send_sigio.kill_fasync
      3.10 ±  4%      -0.8        2.27 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info.send_sigio
      3.57 ±  2%      -0.6        2.95 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_write.vfs_write
      4.15 ±  2%      -0.6        3.54 ±  8%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.22            -0.6        3.63 ±  6%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.33 ± 19%      -0.5        0.80 ± 19%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      1.29 ± 17%      -0.5        0.78 ±  7%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      3.37 ±  2%      -0.5        2.87 ±  8%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.46            -0.5        1.96 ±  4%  perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.36 ± 19%      -0.5        0.86 ± 19%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      3.26 ±  3%      -0.5        2.76 ±  8%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.10 ± 20%      -0.5        0.61 ±  7%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
      3.35 ±  2%      -0.5        2.87 ±  5%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      2.37            -0.5        1.90 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_sigio_handler
      3.23 ±  2%      -0.4        2.78 ±  6%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      2.27            -0.4        1.82 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigio_handler
      2.26            -0.4        1.82 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigio_handler
      2.12            -0.4        1.68 ±  5%  perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      1.75            -0.4        1.36 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      1.60            -0.4        1.21 ±  5%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_hrtimeout_range_clock.do_select
      1.74            -0.4        1.36 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info
      1.75 ±  4%      -0.4        1.38 ±  5%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_write
      1.87            -0.3        1.52 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.31 ±  2%      -0.3        1.97 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      1.72            -0.3        1.38 ±  4%  perf-profile.calltrace.cycles-pp.__irqentry_text_end.stress_sigio_handler
      0.61 ±  3%      -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.59 ±  2%      -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_write.vfs_write
      0.68 ±  2%      -0.3        0.36 ± 70%  perf-profile.calltrace.cycles-pp.collect_signal.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      1.43 ±  2%      -0.3        1.13 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.complete_signal.__send_signal_locked
      1.38            -0.3        1.10 ±  4%  perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      1.32 ±  2%      -0.3        1.04 ±  4%  perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.29 ±  2%      -0.3        1.01 ±  5%  perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      1.47            -0.3        1.19 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_write.vfs_write
      1.37 ±  2%      -0.3        1.10 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.complete_signal
      1.25 ±  2%      -0.3        0.98 ±  4%  perf-profile.calltrace.cycles-pp.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64
      1.62            -0.3        1.36 ±  4%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.54            -0.2        1.30 ±  6%  perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.send_sigio.kill_fasync
      0.82 ±  2%      -0.2        0.58 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_hrtimeout_range_clock
      1.35 ±  2%      -0.2        1.12 ±  7%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.14            -0.2        0.93 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.94 ±  4%      -0.2        0.73 ±  5%  perf-profile.calltrace.cycles-pp.__alloc_pages.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.12 ±  2%      -0.2        0.92 ±  7%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.pipe_write.vfs_write
      0.94            -0.2        0.75 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigio_handler
      1.06 ±  2%      -0.2        0.88 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81 ±  3%      -0.2        0.64 ±  5%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__select
      0.66 ±  3%      -0.2        0.49 ± 45%  perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.95 ±  2%      -0.2        0.78 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ±  2%      -0.2        0.59 ±  4%  perf-profile.calltrace.cycles-pp.restore_fpregs_from_user.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn
      0.76 ±  4%      -0.1        0.62 ±  4%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.94 ±  4%      -0.1        0.80 ±  8%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.__folio_put.pipe_read.vfs_read.ksys_read
      1.00 ±  4%      -0.1        0.86 ±  8%  perf-profile.calltrace.cycles-pp.__folio_put.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.00 ±  5%      -0.1        0.87 ±  6%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.90            -0.1        0.77 ±  6%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.send_sigio
      0.79            -0.1        0.66 ±  6%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.88 ±  3%      -0.1        0.76 ±  8%  perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ±  4%      -0.1        0.62 ±  8%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.pipe_read.vfs_read
      0.65 ±  2%      -0.1        0.54 ±  3%  perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.pipe_write
      0.69 ±  2%      -0.1        0.58 ±  7%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.77 ±  2%      -0.1        0.67 ±  9%  perf-profile.calltrace.cycles-pp.wakeup_preempt.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.71 ±  4%      -0.1        0.61 ±  9%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.58 ±  3%      +0.1        0.68 ±  5%  perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.53 ±  2%      +0.2        0.71 ± 11%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.55 ±  3%      +0.2        0.74 ±  7%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69 ±  4%      +0.2        0.89 ± 10%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      0.80 ±  3%      +0.2        1.01 ±  9%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.06 ±  3%      +0.3        2.35 ±  8%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.45            +0.3        1.74 ±  3%  perf-profile.calltrace.cycles-pp.__entry_text_start.read
      0.34 ± 70%      +0.3        0.66 ± 11%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.07            +0.3        1.39 ±  5%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      1.74 ±  2%      +0.3        2.07 ±  3%  perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyout._copy_to_iter.copy_page_to_iter.pipe_read
      1.83 ±  2%      +0.4        2.19 ±  2%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read
      1.98 ±  2%      +0.4        2.38 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      2.04 ±  2%      +0.4        2.46 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.08 ±223%      +0.5        0.57 ±  5%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      4.34            +0.6        4.90        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      0.00            +0.6        0.65 ±  8%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_write.ksys_write.do_syscall_64
      0.62 ± 55%      +0.7        1.30 ± 23%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      3.40            +0.7        4.14 ±  5%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     30.66            +0.7       31.41        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.54 ±  3%      +0.9        1.41 ± 26%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.read
      2.97            +0.9        3.86 ±  5%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
     27.05            +1.2       28.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     36.62            +2.0       38.62        perf-profile.calltrace.cycles-pp.write
     34.59            +2.2       36.82        perf-profile.calltrace.cycles-pp.read
     16.29            -3.6       12.66 ±  4%  perf-profile.children.cycles-pp.__select
     70.34            -3.2       67.18        perf-profile.children.cycles-pp.do_syscall_64
     16.03            -2.9       13.14 ±  5%  perf-profile.children.cycles-pp.schedule
     15.68            -2.8       12.85 ±  5%  perf-profile.children.cycles-pp.__schedule
     10.48 ±  3%      -2.2        8.26 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
     76.40            -2.0       74.36        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     22.86            -1.9       20.97 ±  2%  perf-profile.children.cycles-pp.pipe_write
     10.57            -1.8        8.78 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      6.77            -1.6        5.16 ±  4%  perf-profile.children.cycles-pp.__x64_sys_select
      8.81            -1.6        7.21 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      6.69            -1.6        5.09 ±  4%  perf-profile.children.cycles-pp.kern_select
      7.58 ±  3%      -1.4        6.13 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      5.92            -1.4        4.51 ±  4%  perf-profile.children.cycles-pp.core_sys_select
      7.72 ±  3%      -1.4        6.32 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      5.44            -1.3        4.14 ±  4%  perf-profile.children.cycles-pp.do_select
      8.15 ±  2%      -1.3        6.88 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
      4.84            -1.2        3.67 ±  4%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
     24.23            -1.2       23.06        perf-profile.children.cycles-pp.vfs_write
      5.55            -1.1        4.44 ±  3%  perf-profile.children.cycles-pp.__send_signal_locked
      6.14            -1.1        5.07 ±  3%  perf-profile.children.cycles-pp.do_send_sig_info
      6.62            -1.1        5.56 ±  3%  perf-profile.children.cycles-pp.stress_sigio_handler
      6.89            -1.0        5.87 ±  3%  perf-profile.children.cycles-pp.send_sigio
      5.20 ±  2%      -1.0        4.19 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      5.15            -1.0        4.15 ±  4%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      6.00            -1.0        5.04 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      7.77            -1.0        6.81 ±  2%  perf-profile.children.cycles-pp.kill_fasync
     24.86            -0.9       23.94        perf-profile.children.cycles-pp.ksys_write
      3.23 ±  3%      -0.8        2.39 ±  2%  perf-profile.children.cycles-pp.complete_signal
      1.92 ± 17%      -0.8        1.14 ±  5%  perf-profile.children.cycles-pp.select_task_rq
      4.81            -0.8        4.04 ±  4%  perf-profile.children.cycles-pp.activate_task
      1.64 ± 20%      -0.8        0.89 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      3.72            -0.7        3.00 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.63            -0.7        3.92 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      3.13            -0.6        2.49 ±  4%  perf-profile.children.cycles-pp.handle_signal
      1.10 ± 29%      -0.6        0.46 ±  6%  perf-profile.children.cycles-pp.select_idle_sibling
      2.65 ±  3%      -0.6        2.03 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
     18.57            -0.6       17.96 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.72            -0.6        2.15 ±  4%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      1.34 ± 20%      -0.5        0.81 ± 19%  perf-profile.children.cycles-pp.queue_event
      2.48            -0.5        1.98 ±  4%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      2.95            -0.5        2.45 ±  4%  perf-profile.children.cycles-pp.update_curr
      1.36 ± 19%      -0.5        0.86 ± 19%  perf-profile.children.cycles-pp.ordered_events__queue
      2.89 ±  3%      -0.5        2.42 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      2.13            -0.4        1.69 ±  5%  perf-profile.children.cycles-pp.get_sigframe
      2.36 ±  2%      -0.4        1.93 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.76            -0.4        1.40 ±  4%  perf-profile.children.cycles-pp.restore_sigcontext
      2.37 ±  2%      -0.3        2.03 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      1.82            -0.3        1.48 ±  3%  perf-profile.children.cycles-pp.reweight_entity
      1.73            -0.3        1.40 ±  4%  perf-profile.children.cycles-pp.__irqentry_text_end
      1.30 ±  2%      -0.3        1.02 ±  5%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      1.32 ±  2%      -0.3        1.04 ±  4%  perf-profile.children.cycles-pp.fpu__restore_sig
      1.26 ±  2%      -0.3        0.99 ±  4%  perf-profile.children.cycles-pp.__fpu_restore_sig
      1.62            -0.3        1.37 ±  4%  perf-profile.children.cycles-pp.get_signal
      1.55            -0.2        1.30 ±  6%  perf-profile.children.cycles-pp.__sigqueue_alloc
      1.30 ±  2%      -0.2        1.06 ±  7%  perf-profile.children.cycles-pp.prepare_task_switch
      1.19 ±  2%      -0.2        0.95 ±  6%  perf-profile.children.cycles-pp.set_next_entity
      1.30 ±  3%      -0.2        1.08 ±  7%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.14            -0.2        0.93 ±  3%  perf-profile.children.cycles-pp.dequeue_signal
      0.95 ±  4%      -0.2        0.74 ±  5%  perf-profile.children.cycles-pp.__alloc_pages
      1.33 ±  3%      -0.2        1.13 ±  8%  perf-profile.children.cycles-pp.switch_fpu_return
      1.04 ±  4%      -0.2        0.84 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      1.09            -0.2        0.90 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.96            -0.2        0.78 ±  5%  perf-profile.children.cycles-pp.__pick_eevdf
      0.89 ±  2%      -0.2        0.72 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      1.04 ±  2%      -0.2        0.88 ±  7%  perf-profile.children.cycles-pp.wakeup_preempt
      0.88            -0.2        0.71 ±  5%  perf-profile.children.cycles-pp.pick_next_entity
      0.81 ±  2%      -0.2        0.66 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.62 ±  2%      -0.2        0.47 ±  8%  perf-profile.children.cycles-pp.put_prev_entity
      0.74 ±  2%      -0.2        0.59 ±  4%  perf-profile.children.cycles-pp.restore_fpregs_from_user
      0.68 ±  2%      -0.2        0.53 ±  4%  perf-profile.children.cycles-pp.collect_signal
      0.95 ±  3%      -0.1        0.80 ±  8%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
      1.01 ±  3%      -0.1        0.86 ±  8%  perf-profile.children.cycles-pp.__folio_put
      0.79            -0.1        0.65 ±  7%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.75 ±  2%      -0.1        0.61 ±  7%  perf-profile.children.cycles-pp.os_xsave
      0.72 ±  3%      -0.1        0.58 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.50 ±  5%      -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.91            -0.1        0.78 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.34 ±  5%      -0.1        0.21 ±  8%  perf-profile.children.cycles-pp.select_idle_cpu
      0.52 ±  3%      -0.1        0.40 ±  5%  perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
      0.80 ±  2%      -0.1        0.68 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.74 ±  5%      -0.1        0.62 ±  7%  perf-profile.children.cycles-pp.uncharge_batch
      0.71 ±  2%      -0.1        0.59 ±  7%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.76 ±  4%      -0.1        0.65 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      0.70 ±  4%      -0.1        0.58 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.37 ±  2%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.53            -0.1        0.42 ±  5%  perf-profile.children.cycles-pp._copy_from_user
      0.55 ±  3%      -0.1        0.44 ±  5%  perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
      0.52            -0.1        0.42 ±  4%  perf-profile.children.cycles-pp.save_xstate_epilog
      0.54 ±  2%      -0.1        0.44 ±  6%  perf-profile.children.cycles-pp.avg_vruntime
      0.57 ±  3%      -0.1        0.47 ±  6%  perf-profile.children.cycles-pp.place_entity
      0.33 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.restore_altstack
      0.47 ±  4%      -0.1        0.38 ±  4%  perf-profile.children.cycles-pp.__calc_delta
      0.44 ±  5%      -0.1        0.35 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.31 ±  2%      -0.1        0.22 ±  5%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.49            -0.1        0.41 ±  4%  perf-profile.children.cycles-pp.fpu__clear_user_states
      0.30 ±  2%      -0.1        0.22 ± 12%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.36 ±  4%      -0.1        0.28 ±  6%  perf-profile.children.cycles-pp.update_min_vruntime
      0.62            -0.1        0.53 ±  6%  perf-profile.children.cycles-pp.perf_tp_event
      0.25 ±  3%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.36 ±  2%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.poll_select_finish
      0.51 ±  5%      -0.1        0.43 ±  8%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.55 ±  2%      -0.1        0.47 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.31 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.check_xstate_in_sigframe
      0.35 ±  4%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.ktime_get_ts64
      0.28 ±  6%      -0.1        0.20 ± 10%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.27 ±  5%      -0.1        0.20 ±  6%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.39 ±  3%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.sched_clock
      0.32 ±  3%      -0.1        0.25 ±  7%  perf-profile.children.cycles-pp.cpuacct_charge
      0.44 ±  3%      -0.1        0.37 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.26 ±  4%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.signal_setup_done
      0.36 ±  5%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.36 ±  4%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.24 ±  4%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.30 ±  4%      -0.1        0.25 ±  6%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.37 ±  2%      -0.1        0.32 ±  6%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.30 ±  4%      -0.0        0.25 ±  7%  perf-profile.children.cycles-pp.__dequeue_entity
      0.26 ±  3%      -0.0        0.21 ±  9%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.23 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.recalc_sigpending
      0.22 ±  4%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.19 ±  3%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.__enqueue_entity
      0.26 ±  4%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.33 ±  4%      -0.0        0.29 ±  5%  perf-profile.children.cycles-pp.kmem_cache_free
      0.21 ±  5%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__set_current_blocked
      0.20 ±  3%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.23 ±  4%      -0.0        0.19 ±  5%  perf-profile.children.cycles-pp.entity_eligible
      0.20 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.set_current_blocked
      0.13 ±  2%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.23 ±  6%      -0.0        0.19        perf-profile.children.cycles-pp.read_tsc
      0.26 ±  3%      -0.0        0.22 ±  5%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.20 ±  4%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.20 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.select_estimate_accuracy
      0.11 ± 14%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.__bitmap_and
      0.10 ±  4%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.timerqueue_del
      0.23 ±  2%      -0.0        0.20 ±  9%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.timerqueue_add
      0.12 ±  3%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.15 ±  8%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.switch_ldt
      0.26 ±  4%      -0.0        0.23 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      0.16 ±  5%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.11            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp._copy_to_user
      0.15 ±  5%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.14 ±  5%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.12 ±  3%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.15 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.fpregs_mark_activate
      0.14 ±  7%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.10 ±  6%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.09            -0.0        0.07 ±  8%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.09 ±  6%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.memset_orig
      0.09            -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.fpu__alloc_mathframe
      0.10 ±  4%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__hrtimer_init
      0.10 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.hrtimer_init_sleeper
      0.08 ±  4%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.aa_file_perm
      0.05            +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.rw_verify_area
      0.12 ±  3%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.__x64_sys_write
      0.22 ±  4%      +0.0        0.25 ±  5%  perf-profile.children.cycles-pp.__x64_sys_read
      0.38 ±  3%      +0.0        0.42        perf-profile.children.cycles-pp._raw_read_unlock_irqrestore
      0.21 ±  3%      +0.0        0.26 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.15 ±  7%      +0.0        0.19 ±  7%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.19 ±  4%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.file_update_time
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.policy_node
      0.25            +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.timestamp_truncate
      0.19 ±  4%      +0.1        0.25 ± 16%  perf-profile.children.cycles-pp.fsnotify_perm
      0.01 ±223%      +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.maps__find
      0.47 ±  2%      +0.1        0.54 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.40 ±  2%      +0.1        0.48 ±  5%  perf-profile.children.cycles-pp.mutex_unlock
      0.80            +0.1        0.89 ±  2%  perf-profile.children.cycles-pp.mutex_lock
      0.04 ±109%      +0.1        0.14 ± 25%  perf-profile.children.cycles-pp.perf_env__arch
      0.48 ±  4%      +0.1        0.58 ±  5%  perf-profile.children.cycles-pp.atime_needs_update
      0.00            +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.49 ±  2%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.03 ±147%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.machine__findnew_thread
      0.58 ±  3%      +0.1        0.69 ±  5%  perf-profile.children.cycles-pp.touch_atime
      0.04 ±111%      +0.1        0.16 ± 26%  perf-profile.children.cycles-pp.thread__find_map
      0.20 ±  4%      +0.2        0.35 ±  8%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.41 ±  3%      +0.2        0.57 ±  9%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.08 ± 63%      +0.2        0.25 ± 23%  perf-profile.children.cycles-pp.machines__deliver_event
      0.00            +0.2        0.20 ± 27%  perf-profile.children.cycles-pp.__mutex_lock
      0.14 ± 56%      +0.2        0.39 ± 26%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      2.07 ±  3%      +0.3        2.36 ±  8%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.86 ±  2%      +0.3        1.17 ± 11%  perf-profile.children.cycles-pp.__fget_light
      0.92 ±  2%      +0.4        1.27 ± 11%  perf-profile.children.cycles-pp.__fdget_pos
      1.18            +0.4        1.54 ±  8%  perf-profile.children.cycles-pp.apparmor_file_permission
      1.88 ±  2%      +0.4        2.27 ±  2%  perf-profile.children.cycles-pp.copyout
      1.29            +0.4        1.68 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.98 ±  2%      +0.4        2.39 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      1.36 ±  2%      +0.4        1.77 ±  7%  perf-profile.children.cycles-pp.security_file_permission
      3.88            +0.4        4.30 ±  5%  perf-profile.children.cycles-pp.rep_movs_alternative
      2.04 ±  2%      +0.4        2.47 ±  2%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.68 ± 39%      +0.6        1.31 ± 23%  perf-profile.children.cycles-pp.perf_session__deliver_event
      4.38            +0.8        5.15 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      8.18            +1.3        9.48 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
     36.84            +2.1       38.91        perf-profile.children.cycles-pp.write
     34.87            +2.3       37.16        perf-profile.children.cycles-pp.read
      1.31 ± 19%      -0.5        0.78 ± 19%  perf-profile.self.cycles-pp.queue_event
      2.33 ±  2%      -0.4        1.91 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.73            -0.3        1.40 ±  4%  perf-profile.self.cycles-pp.__irqentry_text_end
      1.50 ±  2%      -0.2        1.27 ±  7%  perf-profile.self.cycles-pp.__schedule
      0.44 ± 31%      -0.2        0.21 ±  6%  perf-profile.self.cycles-pp.select_idle_sibling
      1.30 ±  3%      -0.2        1.08 ±  7%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.51 ±  3%      -0.2        0.31 ±  5%  perf-profile.self.cycles-pp.dequeue_entity
      1.29 ±  5%      -0.2        1.08 ±  7%  perf-profile.self.cycles-pp.update_load_avg
      1.04 ±  4%      -0.2        0.84 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.92            -0.2        0.73 ±  5%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      0.99 ±  2%      -0.2        0.80 ±  4%  perf-profile.self.cycles-pp.reweight_entity
      1.26 ±  6%      -0.2        1.10 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.78 ±  2%      -0.1        0.64 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.84            -0.1        0.70 ±  4%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.82            -0.1        0.68 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
      0.74 ±  2%      -0.1        0.60 ±  6%  perf-profile.self.cycles-pp.os_xsave
      0.72 ±  3%      -0.1        0.58 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.67 ±  2%      -0.1        0.53 ±  5%  perf-profile.self.cycles-pp.restore_fpregs_from_user
      0.69            -0.1        0.57 ±  7%  perf-profile.self.cycles-pp.__pick_eevdf
      0.78 ±  2%      -0.1        0.66 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.51 ±  3%      -0.1        0.40 ±  4%  perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      0.55 ±  3%      -0.1        0.44 ±  5%  perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
      0.74 ±  4%      -0.1        0.63 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.54 ±  5%      -0.1        0.43 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.62 ±  5%      -0.1        0.52 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.63 ±  4%      -0.1        0.53 ±  7%  perf-profile.self.cycles-pp.__switch_to
      0.42 ±  4%      -0.1        0.32 ±  7%  perf-profile.self.cycles-pp.try_to_wake_up
      0.39 ±  4%      -0.1        0.30 ±  5%  perf-profile.self.cycles-pp.core_sys_select
      0.22 ± 12%      -0.1        0.13 ±  9%  perf-profile.self.cycles-pp.select_idle_cpu
      0.52 ±  2%      -0.1        0.42 ±  6%  perf-profile.self.cycles-pp.avg_vruntime
      0.47 ±  4%      -0.1        0.38 ±  5%  perf-profile.self.cycles-pp.__calc_delta
      0.42 ±  6%      -0.1        0.33 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.38 ±  4%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.do_select
      0.36 ±  2%      -0.1        0.28 ±  5%  perf-profile.self.cycles-pp._copy_from_user
      0.54 ±  2%      -0.1        0.46 ±  6%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.22 ±  8%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.41 ±  2%      -0.1        0.34 ±  3%  perf-profile.self.cycles-pp.fpu__clear_user_states
      0.32 ±  4%      -0.1        0.25 ±  5%  perf-profile.self.cycles-pp.update_min_vruntime
      0.25 ±  2%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.set_next_entity
      0.12 ± 25%      -0.1        0.05 ± 52%  perf-profile.self.cycles-pp.__ordered_events__flush
      0.45 ±  5%      -0.1        0.38 ±  7%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.27 ±  7%      -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.26 ±  3%      -0.1        0.19 ± 11%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.35 ±  3%      -0.1        0.28 ±  4%  perf-profile.self.cycles-pp.x64_setup_rt_frame
      0.21 ±  4%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.pick_next_entity
      0.31 ±  3%      -0.1        0.24 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.24 ±  3%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.36 ±  5%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.20 ±  6%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.put_prev_entity
      0.30 ±  3%      -0.1        0.24 ±  6%  perf-profile.self.cycles-pp.place_entity
      0.35 ±  4%      -0.1        0.29 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.14 ±  4%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.handle_signal
      0.40 ±  4%      -0.1        0.35 ±  8%  perf-profile.self.cycles-pp.prepare_task_switch
      0.40 ±  3%      -0.1        0.34 ±  7%  perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      0.46 ±  5%      -0.1        0.40 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.23 ±  4%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.29 ±  3%      -0.1        0.24 ±  7%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.36 ±  2%      -0.1        0.31 ±  7%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.24 ±  5%      -0.1        0.19 ±  8%  perf-profile.self.cycles-pp.memcg_account_kmem
      0.30 ±  8%      -0.0        0.25 ±  8%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.18 ±  3%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.35 ±  3%      -0.0        0.30 ±  8%  perf-profile.self.cycles-pp.schedule
      0.32 ±  4%      -0.0        0.28 ± 10%  perf-profile.self.cycles-pp.switch_fpu_return
      0.27 ±  3%      -0.0        0.22 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.22 ±  4%      -0.0        0.17 ±  5%  perf-profile.self.cycles-pp.__get_user_nocheck_4
      0.18 ±  5%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__enqueue_entity
      0.22 ±  4%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.entity_eligible
      0.22            -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.recalc_sigpending
      0.21 ±  3%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.__fpu_restore_sig
      0.18 ±  2%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp.__x64_sys_rt_sigreturn
      0.19 ±  3%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.24 ±  5%      -0.0        0.20 ±  8%  perf-profile.self.cycles-pp.__dequeue_entity
      0.18 ±  5%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.kern_select
      0.13 ±  8%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__select
      0.42 ±  2%      -0.0        0.37 ±  5%  perf-profile.self.cycles-pp.perf_tp_event
      0.22 ±  3%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.get_sigframe
      0.22 ±  5%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.read_tsc
      0.25 ±  2%      -0.0        0.22 ±  5%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.16 ±  4%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.activate_task
      0.26 ±  4%      -0.0        0.22 ±  6%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.16 ±  4%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.schedule_hrtimeout_range_clock
      0.08 ± 10%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.15 ±  8%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.switch_ldt
      0.10 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.poll_select_finish
      0.09 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.timerqueue_add
      0.19            -0.0        0.16 ±  8%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.16 ±  4%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.16 ±  6%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.autoremove_wake_function
      0.28 ±  2%      -0.0        0.25 ±  6%  perf-profile.self.cycles-pp.select_task_rq
      0.19 ±  4%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      0.14 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.fpregs_mark_activate
      0.16 ±  4%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.12 ±  7%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.alloc_pages
      0.14 ±  5%      -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.ktime_get_ts64
      0.19 ±  3%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.restore_sigcontext
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.check_xstate_in_sigframe
      0.14 ±  5%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.arch_do_signal_or_restart
      0.15 ±  4%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.save_xstate_epilog
      0.14 ±  5%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.collect_signal
      0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__x64_sys_select
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp._copy_to_user
      0.12 ±  5%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.13 ±  2%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.12 ±  8%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.11 ±  8%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.07 ±  6%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.restore_altstack
      0.09 ±  7%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.08 ±  8%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.09 ±  4%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.fpu__alloc_mathframe
      0.10 ±  5%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.select_estimate_accuracy
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.memset_orig
      0.07 ±  6%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.aa_file_perm
      0.20 ±  5%      +0.0        0.22 ±  4%  perf-profile.self.cycles-pp.send_sigio
      0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.09 ±  5%      +0.0        0.12 ± 12%  perf-profile.self.cycles-pp._copy_to_iter
      0.12 ±  4%      +0.0        0.14 ±  8%  perf-profile.self.cycles-pp.__x64_sys_write
      0.19 ±  4%      +0.0        0.23 ±  6%  perf-profile.self.cycles-pp.security_file_permission
      0.20 ±  4%      +0.0        0.24 ±  6%  perf-profile.self.cycles-pp.__x64_sys_read
      0.11 ±  6%      +0.0        0.15 ±  7%  perf-profile.self.cycles-pp._copy_from_iter
      0.20 ±  2%      +0.0        0.23 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.32 ±  2%      +0.0        0.36 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.16 ±  4%      +0.0        0.20 ±  6%  perf-profile.self.cycles-pp.__wake_up_common_lock
      0.37 ±  2%      +0.0        0.41        perf-profile.self.cycles-pp._raw_read_unlock_irqrestore
      0.24 ±  5%      +0.0        0.29 ±  7%  perf-profile.self.cycles-pp.atime_needs_update
      0.06 ± 11%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.18 ±  4%      +0.0        0.23 ±  9%  perf-profile.self.cycles-pp.copyin
      0.19 ±  4%      +0.1        0.24 ± 17%  perf-profile.self.cycles-pp.fsnotify_perm
      0.06 ± 11%      +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.__fdget_pos
      0.14 ±  3%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.__wake_up_common
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.timestamp_truncate
      0.25 ±  2%      +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.rw_verify_area
      0.45 ±  2%      +0.1        0.51 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.17 ±  4%      +0.1        0.23 ±  7%  perf-profile.self.cycles-pp.copyout
      0.01 ±223%      +0.1        0.08 ± 25%  perf-profile.self.cycles-pp.machines__deliver_event
      0.00            +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.__mutex_lock
      0.51 ±  2%      +0.1        0.59        perf-profile.self.cycles-pp.read
      0.38 ±  2%      +0.1        0.47 ±  4%  perf-profile.self.cycles-pp.mutex_unlock
      0.43 ±  2%      +0.1        0.52 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.03 ±111%      +0.1        0.13 ± 27%  perf-profile.self.cycles-pp.perf_env__arch
      0.25 ±  3%      +0.1        0.34 ± 10%  perf-profile.self.cycles-pp.ksys_write
      0.49 ±  3%      +0.1        0.59 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.1        0.10 ± 29%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.38            +0.1        0.50 ±  5%  perf-profile.self.cycles-pp.write
      0.14 ± 33%      +0.1        0.26 ± 25%  perf-profile.self.cycles-pp.reader__read_event
      0.21 ±  5%      +0.1        0.34 ± 15%  perf-profile.self.cycles-pp.ksys_read
      1.18 ±  2%      +0.1        1.31 ±  3%  perf-profile.self.cycles-pp.pipe_write
      0.84 ±  3%      +0.1        0.98 ±  7%  perf-profile.self.cycles-pp.pipe_read
      0.36 ±  3%      +0.1        0.50 ±  9%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.19 ±  4%      +0.1        0.34 ±  8%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.60 ±  3%      +0.2        0.79 ± 15%  perf-profile.self.cycles-pp.vfs_read
      0.85 ±  2%      +0.3        1.14 ± 11%  perf-profile.self.cycles-pp.__fget_light
      1.09 ±  2%      +0.4        1.44 ±  8%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.71 ±  2%      +0.4        1.10 ± 12%  perf-profile.self.cycles-pp.vfs_write
      3.73            +0.4        4.14 ±  5%  perf-profile.self.cycles-pp.rep_movs_alternative
      3.96            +0.7        4.64 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      6.16            +1.1        7.29 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.83            +1.1        8.96 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      8.17            +1.3        9.47 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

