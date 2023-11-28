Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859AC7FC161
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbjK1OAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345525AbjK1Nzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:55:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B685
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701179752; x=1732715752;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=wZyK7+4J5r1fG9hfmTZmT7VE4VkpoJDoKJIP6zXSpBw=;
  b=c6nNLqFuymVp0ZE8aJAgp/u3vyeqvswirhIKgaCgk7KmiPvdBFqPS98c
   0z7gOUVd6xdi0c5At2I+CATtubYMadBgwA7dJMWym8jwXbxwkQ9W8zxln
   a+eUfKNeGS0w1Zsbm2L6dwQA/Yan00qjSYqjtjWzNTDjIT0Ujkqlgjncx
   T6upfAKMnWGCTFurfveHVIdRFNmD0ek3cYWitlsYsZhUTVxJWJxhpThVD
   va8WITVI8MfYpYXJadH21Wx4xDA6oeCfXtOpiwFHs8oHwUgOp+wVilKQb
   CLzdxmVgNeEutD2OtYe5vOljXg6rsI8uNjywDJnokm9UlpLi0vR4rgbwr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="383312207"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="383312207"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="892079846"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="892079846"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 05:55:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 05:55:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 05:55:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 05:55:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 05:55:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SERJ2+khM+CvkFAvIX1Jz5KN5iFHp6RIX35VfFGXf57P+Q6tiHX4Gl2A6JDkumuXJPj//DE5W/karBPiWkNSHvwadE6texIBFadtQrugF18JUxZUfn0z3gDuWFT/FO3b5drcbf4oyAfXtN8S5LzdfJoMFMzxjt3/fx+kqF1aP7v6xu0dGL8cLwMzlWYJrv+/zWyTYb8RGqo8FB3EPQI2nObPWY/xzi5gTT1Rz7j2nDDFe2YPhf6asj31o5wLfiCXqJq7r3odwU6IQfwKdsaCmG0ltQ25R+p1RJrXSWFqqlUrxRNN0rVY+VISbovYKzsPnz1J2WrdkXx1kzErWjgd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDI+5Q5x8xUEfoSljglp9Q3Nh9b1GdJyMzHxFyVU3us=;
 b=QP7KUtDAc7ef90p/28q7eup/zZAOCB4z6lXuqU7on6n0GP/jJbc0/+Fb9NqBYfjY1IthUQfJVaBeTj7e4dRDUFK1ZndX27xi/MWM6J1Q31dMe9PkodHJXOoI3jzqOXd7C3KMS6F4u+ckUHbvFyb25Q+tHt5Hl7/yuy3uj6SFmw5C0uM0SwxDuWssqbCmaeTVOIktjq7Q44+fq0yjX2/PikLBacZUT/ny4ML64Qv0nmzgPHeeYAirRWYTOlS1uCJB2wVuyREIfoBwj+l3JIrAHEZq7/IPXe1KFerMOnWYglG8/29D8wDOhis9gchhVZs8hUjD7invHb9usCGbeX+Hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8693.namprd11.prod.outlook.com (2603:10b6:408:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 13:55:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 13:55:46 +0000
Date:   Tue, 28 Nov 2023 21:55:33 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linux-next:master] [fork]  6e553c6bcb:
 will-it-scale.per_process_ops 94.7% improvement
Message-ID: <202311282145.ff13737b-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: c5710794-e74b-4d86-b4f8-08dbf019b880
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPwhJFNbSPHMYqMBij+1xvM2TORqEkqSelG3d8TWlqzQ/oLd7XpFweyczPSfRRF/Zv/uTQcXErigIg49LdH07nHo8kK6Qwfs6hSCMGlyPmmgSHwxqKGZL4aMbwomKCrAqY6N7pD2C3u5SHR0eFuFo/7k6entHaLRUTXNCqkLpYHqOBI/asK5mnzBP2fJuS8XtI/6jQgYA9wLoLKE3MeJBve0/Wce+brn9UQwM3ZpXXamXFwXZjFmYdkttI3alWGSvfA4ZfzoAN5dJxHEYW6mbUrtaPS3hBT9kbV/uees/66XqoW//xq2uggo1VdjlXDrbQGDn7jeBmksOeRNfVDg0EThH0itYQDw5AR7ncf49fqrFfmozcbCGlLBq3l9NNuITxl8vyGHq31Kb+S1ePRs351zW4LlcxBcp7iroT8LhcpXmaZQ8RR/hGYg76iw8W3q2O61Vdcfc7LKSShRerxQ2WgnjbmysmatcsU4fvxoNJzcTbmwEcHkHGiTSRNGA2Dr8Js0fcH/dwwe+FEZloWwwsYWHFRrBviHWsblyaG3XMhZqsDXvMuW+VcHWQHpRs2Jgr9K0ezGdQuwJ+DYqi2Lc7V5pW+f5cTd0/6PMph46WNAct8Y1LdL36EKHiQ0MOoiue4P0WfPxyHbhzuNZ0f9pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(230373577357003)(230473577357003)(186009)(1800799012)(64100799003)(451199024)(2616005)(26005)(1076003)(6512007)(107886003)(478600001)(82960400001)(36756003)(86362001)(38100700002)(83380400001)(7416002)(5660300002)(2906002)(30864003)(6506007)(6666004)(66556008)(66476007)(54906003)(8936002)(8676002)(6916009)(316002)(4326008)(41300700001)(66946007)(6486002)(966005)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Py51BzSvSuiY/0QvM6n0SQFVzXm7UepX5Fl1OjAAtO5jX/8brZwerkppuD?=
 =?iso-8859-1?Q?f8q555ZkNsDhaXyJJZPvpREMmSyiMAfsXOkdTAf/7sh+ZoIN4lfWkhIJUQ?=
 =?iso-8859-1?Q?tbEBKBqs8c3EwzurVmuUWIsHDuHfKLWDMrvtsEu1MxKxMCf8nkP3avESVV?=
 =?iso-8859-1?Q?qGa8RKATnzcO+n9/0M2DQRBVK5GGrnlAUbHj8uSGvspt8xlyezbZvRHtFj?=
 =?iso-8859-1?Q?Rq0PLQRn8LlPgxrZJ/rPmu0F6FRZZMpInhgSgZ9gB2hwiiJfDy39mOwWja?=
 =?iso-8859-1?Q?gxA26s656JAI4pw72ReeKlc0iqJGjiyvcohnVhqzmzd4BZxmVe8Kd9+bQA?=
 =?iso-8859-1?Q?d1tCirMGxbZNUio4uXWA+Mhftwq+JIWG8wzGXOyHChbl4sNzTFb8rQp/0C?=
 =?iso-8859-1?Q?96Z3EoMLIlL5ZcJEoDn31MAosrASDsrFaiyBBIM6zQ1yBA6vupD+JwnDAv?=
 =?iso-8859-1?Q?V4NOqrgmBIMjJ4HGsEWDB5MK0E67W9y1HHrE4b2vsJOrRGWfdYW2/OEJog?=
 =?iso-8859-1?Q?7+P1jX0IpWlugAtT7D29HG7ZgiKUa+qnaI/Yw5VTHWtBWGdBcBm0UlI6BA?=
 =?iso-8859-1?Q?kpW0GHUuiNxuGn7z0s2opjqiMg/pbWetRzRJY0UkdlG+plFdrNHka5o+WR?=
 =?iso-8859-1?Q?nmTmz3V/9NCD5G9TofXnJ9o0XWr8wQzp6SwyOXfhJSCXAcNpV9wG+S+cSD?=
 =?iso-8859-1?Q?Nhvl1ITaxHk2unwPKpEzlSrq+boG64oGho3PsuxWUY4vaexsshYs96842S?=
 =?iso-8859-1?Q?J2qqGQm/a1n+ubzB19U8Jf5P1/S9OMAB/phLtCmCSe5lfxqDULWtpYx0g+?=
 =?iso-8859-1?Q?S4pMtyTLCRuKektPkoZeLUgdCnRly9JTmKM147S0sT3JsmruLepiZ4zcM9?=
 =?iso-8859-1?Q?RzSR5/72gU3bWARH3CEPgTmHa2o9KFK+uSSv+k0576Z+U9vh3sVe8IMnpk?=
 =?iso-8859-1?Q?zUVgElD7f4CmLLULdWwCcjzssGBtm8/hfdo+tbKg2bIm54a0zhMxzKtL08?=
 =?iso-8859-1?Q?nJDVbC2Ts535MEbo3HNIfXfFBkd8sO3kRBbBq/KTkAkXk2yPndCT/X3aQ5?=
 =?iso-8859-1?Q?Hekzq46M9h5vqb09VqC+ifSIPrgplNHOUvYRlRNb7lRKYcekBTGIGxSumG?=
 =?iso-8859-1?Q?nTLvuW7fnEdT/TbsevOV9tPe7EqcNxjvaIsoSOcVjMrJ3JeH/gElJKpPPn?=
 =?iso-8859-1?Q?nBZZeYfKkmVxyaVNTJlUxCtmQfiVZRaRRP27yC9l9m6KPGa0AS3+NRTllX?=
 =?iso-8859-1?Q?41aBJrRhdwUGJ9zVBA8KwPbJsH/NwcfIz2c1GZD25DzDTSdBXC8RvgsjPs?=
 =?iso-8859-1?Q?nHoFBsuasmVAe1Qu7T1lnFzktU9KhUQYwvd+lSvtc57XevOEy7repOIY2T?=
 =?iso-8859-1?Q?3FG0Yp54YWKq5ikkWRXp9H927VJZJUuR+9vnbl1UIGf3Rv9+3y+YItFUvN?=
 =?iso-8859-1?Q?bjAnf3viVaQ1ELhJgdEoDuWZVALQZdQZpdud+cbJT/IstRLXXOiHKx1M24?=
 =?iso-8859-1?Q?/qEkVZkLr60RRi+DrkGbjkgSBvlkWx5iUOILM/74Y2DOSFtLDLqrjf0RCL?=
 =?iso-8859-1?Q?UUy3qHJfYzWYygiR9nOdLjq8YwirCWu9WL8v3u6l96Nm6BcaIV+SpgfXbS?=
 =?iso-8859-1?Q?2XsaKPKtDtG+TvhVeLzjc+J7NctyITRCxL0wyb/GgeJQjtUaU8/sOhlQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5710794-e74b-4d86-b4f8-08dbf019b880
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 13:55:46.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msdxnk94jiyv488MdkBi1qxMW2BTl/4lMn+JyasuCIywDUmnEoIyajtmPL0qMZpjBJuN8LRQSnVz66BobqhPxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8693
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 94.7% improvement of will-it-scale.per_process_ops on:


commit: 6e553c6bcb7746abad29ce63e0cb7a18348e88fb ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: brk2
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231128/202311282145.ff13737b-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/brk2/will-it-scale

commit: 
  ec81deb6b7 ("maple_tree: preserve the tree attributes when destroying maple tree")
  6e553c6bcb ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")

ec81deb6b769dc1b 6e553c6bcb7746abad29ce63e0c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     24.47            -7.2       17.29        mpstat.cpu.all.soft%
      8.76            +7.6       16.36        mpstat.cpu.all.usr%
      8.80           +85.5%      16.33        vmstat.cpu.us
      7732           -18.3%       6318        vmstat.system.cs
  13467005           +94.7%   26223847        will-it-scale.104.processes
    129489           +94.7%     252151        will-it-scale.per_process_ops
  13467005           +94.7%   26223847        will-it-scale.workload
 1.792e+08           -13.6%  1.549e+08        numa-numastat.node0.local_node
 1.793e+08           -13.6%  1.549e+08        numa-numastat.node0.numa_hit
 1.867e+08           -12.6%  1.631e+08        numa-numastat.node1.local_node
 1.867e+08           -12.6%  1.632e+08        numa-numastat.node1.numa_hit
 1.793e+08           -13.6%  1.549e+08        numa-vmstat.node0.numa_hit
 1.792e+08           -13.6%  1.549e+08        numa-vmstat.node0.numa_local
 1.867e+08           -12.6%  1.631e+08        numa-vmstat.node1.numa_hit
 1.867e+08           -12.6%  1.631e+08        numa-vmstat.node1.numa_local
    122.70           +43.4      166.10        turbostat.PKG_%
     56.67 �  2%      -6.8%      52.83 �  3%  turbostat.PkgTmp
    376.36            +1.3%     381.14        turbostat.PkgWatt
     45.03            -5.8%      42.40        turbostat.RAMWatt
    121103            -2.7%     117803        proc-vmstat.nr_slab_unreclaimable
     68338 �  7%     +24.8%      85281 �  6%  proc-vmstat.numa_hint_faults
  3.66e+08           -13.1%  3.181e+08        proc-vmstat.numa_hit
 3.659e+08           -13.1%   3.18e+08        proc-vmstat.numa_local
 7.155e+08           -15.6%  6.038e+08        proc-vmstat.pgalloc_normal
   1025781            +2.6%    1052377        proc-vmstat.pgfault
 7.131e+08           -15.5%  6.028e+08        proc-vmstat.pgfree
  12305161           +10.3%   13578139        sched_debug.cfs_rq:/.avg_vruntime.avg
  12419603           +10.6%   13739004        sched_debug.cfs_rq:/.avg_vruntime.max
    122981 �  5%     +41.3%     173809 � 12%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    376.33 � 43%     -53.5%     174.89 � 34%  sched_debug.cfs_rq:/.load_avg.avg
     85.75 �  9%     -59.1%      35.08 � 16%  sched_debug.cfs_rq:/.load_avg.min
  12305176           +10.3%   13578151        sched_debug.cfs_rq:/.min_vruntime.avg
  12419621           +10.6%   13739007        sched_debug.cfs_rq:/.min_vruntime.max
    122979 �  5%     +41.3%     173810 � 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
     13056           -15.6%      11025        sched_debug.cpu.nr_switches.avg
      9228           -22.3%       7174        sched_debug.cpu.nr_switches.min
      0.28 �  7%     -63.7%       0.10 � 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.08 �  5%     -27.0%       0.06 �  8%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.56 � 45%     -79.6%       0.73 �199%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.02 � 62%     -70.0%       3.01 �  2%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     11.16 � 29%     -48.2%       5.78 � 45%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     41.80           +25.8%      52.58        perf-sched.total_wait_and_delay.average.ms
     37576 �  2%     -21.0%      29680        perf-sched.total_wait_and_delay.count.ms
     41.73           +25.8%      52.50        perf-sched.total_wait_time.average.ms
      4.50 �  2%     -16.1%       3.78 �  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__do_sys_brk
      4.61 �  6%     -18.0%       3.78 �  2%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      4.26 �  7%     -11.7%       3.77        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
     32.16           +53.0%      49.20        perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     63.20           +35.4%      85.56 �  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    735.00 �  2%     -68.0%     234.83 �  4%  perf-sched.wait_and_delay.count.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__do_sys_brk
      3090 �  6%     -93.8%     190.50 �  4%  perf-sched.wait_and_delay.count.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
    975.67 �  3%     +61.5%       1576        perf-sched.wait_and_delay.count.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
    298.17 �  4%     +54.6%     461.00 �  4%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
    524.33 �  4%     +56.2%     819.17 �  2%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_brk_flags
    402.83 �  2%     +54.2%     621.17 �  3%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
    265.50 �  4%     +28.7%     341.67 �  2%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
    661.33 �  7%     -27.6%     478.83 � 10%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     66.33 �141%    +310.3%     272.17 �  7%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      1517 �  4%     +72.0%       2609        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      6322 �  3%     -41.1%       3725 �  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     14299 �  2%     -25.3%      10677        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.65 � 25%     -38.8%      12.03 �  7%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__do_sys_brk
     20.07 � 27%     -42.3%      11.57 �  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
     18.62 � 28%     -32.5%      12.56 � 12%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
     71.03 � 10%     +44.2%     102.39 � 36%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     23.72 � 26%     -33.5%      15.79 � 12%  perf-sched.wait_and_delay.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
     14.70 � 21%     -33.3%       9.80 �  2%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4.50 �  2%     -16.1%       3.78 �  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__do_sys_brk
      4.61 �  6%     -18.0%       3.78 �  2%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      4.26 �  7%     -11.7%       3.77        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      4.26 �  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
      4.61 �  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.do_brk_flags
     32.13           +53.1%      49.19        perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     63.12           +35.5%      85.50 �  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.65 � 25%     -38.8%      12.03 �  7%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__do_sys_brk
     20.07 � 27%     -42.3%      11.57 �  8%  perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
     18.62 � 28%     -32.5%      12.56 � 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
     16.69 � 36%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
     16.03 � 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.do_brk_flags
     70.43 � 10%     +45.4%     102.38 � 36%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     23.72 � 26%     -33.5%      15.79 � 12%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
     17.57 � 34%     -29.3%      12.43 �  7%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      8.69 �  9%     -20.8%       6.88        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.62           -12.2%       2.30        perf-stat.i.MPKI
 2.471e+10            +5.8%  2.614e+10        perf-stat.i.branch-instructions
      0.82            +0.1        0.90 �  3%  perf-stat.i.branch-miss-rate%
 2.032e+08           +14.1%  2.319e+08        perf-stat.i.branch-misses
     61.39            +1.3       62.74        perf-stat.i.cache-miss-rate%
 3.567e+08           -14.2%  3.061e+08        perf-stat.i.cache-misses
  5.81e+08           -16.2%  4.871e+08        perf-stat.i.cache-references
      7695           -18.5%       6271        perf-stat.i.context-switches
      2.04            +2.6%       2.09        perf-stat.i.cpi
    249.60           -26.8%     182.76        perf-stat.i.cpu-migrations
    780.53           +16.7%     911.09        perf-stat.i.cycles-between-cache-misses
      0.05            +0.0        0.08 �  4%  perf-stat.i.dTLB-load-miss-rate%
  15775916           +75.7%   27724344        perf-stat.i.dTLB-load-misses
  3.43e+10            +5.8%   3.63e+10        perf-stat.i.dTLB-loads
    459336 �  4%     -18.1%     376380 � 10%  perf-stat.i.dTLB-store-misses
 2.189e+10            -2.7%   2.13e+10        perf-stat.i.dTLB-stores
  31159069           +37.1%   42716400        perf-stat.i.iTLB-load-misses
    456253 �  4%     +83.6%     837671 � 31%  perf-stat.i.iTLB-loads
 1.364e+11            -1.9%  1.337e+11        perf-stat.i.instructions
      4379           -28.5%       3131        perf-stat.i.instructions-per-iTLB-miss
      0.49            -2.1%       0.48        perf-stat.i.ipc
      1327           -23.4%       1017        perf-stat.i.metric.K/sec
    783.30            +3.4%     809.81        perf-stat.i.metric.M/sec
      2733            +2.7%       2807        perf-stat.i.minor-faults
   4668970           -23.7%    3562283 � 12%  perf-stat.i.node-load-misses
  44341556           -21.0%   35024109 �  2%  perf-stat.i.node-loads
      2.44            -0.5        1.91 �  9%  perf-stat.i.node-store-miss-rate%
   2146790           -44.9%    1183052 �  2%  perf-stat.i.node-store-misses
  85964398           -24.9%   64569512 �  2%  perf-stat.i.node-stores
      2733            +2.7%       2807        perf-stat.i.page-faults
      2.62           -12.5%       2.29        perf-stat.overall.MPKI
      0.82            +0.1        0.89        perf-stat.overall.branch-miss-rate%
     61.39            +1.4       62.83        perf-stat.overall.cache-miss-rate%
      2.04            +2.1%       2.08        perf-stat.overall.cpi
    780.25           +16.6%     910.13        perf-stat.overall.cycles-between-cache-misses
      0.05            +0.0        0.08        perf-stat.overall.dTLB-load-miss-rate%
      0.00 �  4%      -0.0        0.00 � 10%  perf-stat.overall.dTLB-store-miss-rate%
      4376           -28.5%       3130        perf-stat.overall.instructions-per-iTLB-miss
      0.49            -2.0%       0.48        perf-stat.overall.ipc
      2.44            -0.6        1.80 �  2%  perf-stat.overall.node-store-miss-rate%
   3051945           -49.6%    1539638        perf-stat.overall.path-length
 2.462e+10            +5.8%  2.605e+10        perf-stat.ps.branch-instructions
 2.025e+08           +14.1%  2.311e+08        perf-stat.ps.branch-misses
 3.555e+08           -14.2%  3.051e+08        perf-stat.ps.cache-misses
 5.791e+08           -16.2%  4.855e+08        perf-stat.ps.cache-references
      7668           -18.5%       6250        perf-stat.ps.context-switches
    248.68           -26.7%     182.19        perf-stat.ps.cpu-migrations
  15739140           +75.6%   27640979        perf-stat.ps.dTLB-load-misses
 3.418e+10            +5.8%  3.618e+10        perf-stat.ps.dTLB-loads
    458389 �  4%     -18.1%     375627 � 10%  perf-stat.ps.dTLB-store-misses
 2.181e+10            -2.7%  2.123e+10        perf-stat.ps.dTLB-stores
  31053977           +37.1%   42572874        perf-stat.ps.iTLB-load-misses
    454414 �  4%     +83.8%     835372 � 31%  perf-stat.ps.iTLB-loads
 1.359e+11            -1.9%  1.333e+11        perf-stat.ps.instructions
      2730            +2.6%       2802        perf-stat.ps.minor-faults
   4653258           -23.7%    3549888 � 12%  perf-stat.ps.node-load-misses
  44203348           -21.0%   34917073 �  2%  perf-stat.ps.node-loads
   2139791           -44.9%    1179122 �  2%  perf-stat.ps.node-store-misses
  85677729           -24.9%   64357015 �  2%  perf-stat.ps.node-stores
      2731            +2.6%       2803        perf-stat.ps.page-faults
  4.11e+13            -1.8%  4.038e+13        perf-stat.total.instructions
     33.52           -19.0       14.50        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     17.05           -14.1        2.93        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.58           -11.6        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate
     10.92           -10.9        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.do_brk_flags.__do_sys_brk
     10.60           -10.6        0.00        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.do_brk_flags
     10.54           -10.5        0.00        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
     10.26           -10.3        0.00        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64
     11.70            -9.9        1.78        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64
     12.19            -9.2        2.97        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     69.63            -9.1       60.49        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      8.93            -8.9        0.00        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma
      7.42            -7.4        0.00        perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes
      7.32            -7.3        0.00        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_prealloc.do_brk_flags.__do_sys_brk
     12.16            -6.0        6.13        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.__do_sys_brk
     12.28            -5.9        6.43        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      6.38            -5.6        0.73 �  2%  perf-profile.calltrace.cycles-pp.mas_destroy.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64
     15.46            -5.0       10.49 �  4%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     15.44            -5.0       10.48 �  4%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     15.44            -5.0       10.48 �  4%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     15.47            -5.0       10.50 �  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     15.47            -5.0       10.50 �  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     15.47            -5.0       10.50 �  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     15.44            -5.0       10.48 �  4%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
     15.42            -5.0       10.46 �  4%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
     74.20            -4.5       69.66        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     20.44            -3.4       17.09        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.84            -2.5        1.34 �  4%  perf-profile.calltrace.cycles-pp.__slab_free.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
     76.40            -2.4       74.03        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      4.90 �  2%      -2.0        2.86 �  4%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      4.89 �  2%      -2.0        2.84 �  4%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      2.88            -1.9        1.03        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.__do_sys_brk
      3.53            -1.3        2.22        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.95 �  3%      -0.2        0.71 �  4%  perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      0.71            -0.1        0.62 �  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      0.74 �  3%      +0.2        0.94 �  4%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.rcu_do_batch.rcu_core.__do_softirq.irq_exit_rcu
      0.67            +0.3        0.97 �  3%  perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      0.56 �  2%      +0.4        0.97 �  5%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
      0.56 �  2%      +0.4        0.97 �  5%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode
      0.58 �  2%      +0.4        1.01 �  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.58 �  2%      +0.4        1.01 �  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.mas_pop_node.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap
      0.00            +0.5        0.52 �  2%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.5        0.53 �  2%  perf-profile.calltrace.cycles-pp.mas_pop_node.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete
      0.43 � 44%      +0.5        0.97        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.00            +0.5        0.55        perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
      0.63 �  2%      +0.6        1.18        perf-profile.calltrace.cycles-pp.get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.56 �  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.mas_destroy.mas_store_prealloc.do_brk_flags.__do_sys_brk
      6.03 �  2%      +0.6        6.62 �  4%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      0.71 �  2%      +0.6        1.31 �  4%  perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.6        0.63 �  2%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_wr_slot_store.mas_wr_store_entry.mas_store_prealloc.do_brk_flags
      0.73 �  2%      +0.6        1.36        perf-profile.calltrace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.00            +0.7        0.69        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_brk_flags
      0.74 �  2%      +0.7        1.46        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc.mas_alloc_nodes.mas_wr_node_store.mas_wr_store_entry
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc.vm_area_dup.__split_vma
      0.72            +0.7        1.46        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.8        0.80 �  2%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      1.00 �  5%      +0.9        1.89 �  4%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.brk
      1.00 �  5%      +0.9        1.89 �  4%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.brk
      0.00            +0.9        0.89        perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_wr_store_entry.mas_store_prealloc.do_brk_flags.__do_sys_brk
      1.03 �  5%      +0.9        1.94 �  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.brk
      0.56            +0.9        1.48        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_brk_flags.__do_sys_brk
      1.04 �  4%      +0.9        1.96 �  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.brk
      0.00            +1.0        0.98        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.25 �100%      +1.0        1.24 �  2%  perf-profile.calltrace.cycles-pp.mtree_range_walk.mas_walk.mas_find.__do_sys_brk.do_syscall_64
      0.75            +1.0        1.74        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55            +1.0        1.57 �  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.13 �  2%      +1.1        2.18        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
      0.95            +1.1        2.03        perf-profile.calltrace.cycles-pp.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      1.30 �  2%      +1.2        2.49        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.__do_sys_brk
      0.00            +1.3        1.28        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.mas_alloc_nodes.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp
      1.50            +1.4        2.90        perf-profile.calltrace.cycles-pp.__entry_text_start.brk
      1.62            +1.5        3.08        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      1.78            +1.5        3.28        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.00            +1.5        1.52 �  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap
      0.00            +1.5        1.52        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap
      0.00            +1.5        1.53        perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete
      0.00            +1.7        1.74        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +1.9        1.90        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.brk
      2.35            +2.2        4.51        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
      2.30            +2.4        4.65        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap.__do_sys_brk
      2.62            +2.5        5.10        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.12            +2.6        5.70        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74            +2.8        5.53        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      4.28 �  3%      +2.9        7.16 �  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__unfreeze_partials
      4.38 �  3%      +2.9        7.31 �  4%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__unfreeze_partials.rcu_do_batch
      4.41 �  3%      +2.9        7.35 �  4%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.__unfreeze_partials.rcu_do_batch.rcu_core
      4.43 �  3%      +3.0        7.38 �  4%  perf-profile.calltrace.cycles-pp.free_unref_page.__unfreeze_partials.rcu_do_batch.rcu_core.__do_softirq
      3.44            +3.5        6.99        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.91            +3.8        7.74        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.brk
      4.63            +4.3        8.91        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     83.68            +4.7       88.36        perf-profile.calltrace.cycles-pp.brk
      0.00            +4.8        4.76        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      0.00            +5.5        5.54        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
     32.01            +6.3       38.28        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +6.4        6.35        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk
      0.82            +6.7        7.53        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
     29.25           -20.1        9.14        perf-profile.children.cycles-pp.mas_store_prealloc
     33.60           -18.9       14.67        perf-profile.children.cycles-pp.do_brk_flags
     27.84           -17.3       10.50 �  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     27.53           -17.1       10.38 �  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     13.75           -13.7        0.00        perf-profile.children.cycles-pp.mas_wr_bnode
     13.22           -13.2        0.00        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
     12.52           -12.5        0.00        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
     15.06           -10.7        4.36        perf-profile.children.cycles-pp.mas_alloc_nodes
     15.78           -10.5        5.29        perf-profile.children.cycles-pp.mas_preallocate
     10.28           -10.3        0.00        perf-profile.children.cycles-pp.mas_wr_spanning_store
     12.34            -9.9        2.40        perf-profile.children.cycles-pp.___slab_alloc
      9.30            -9.2        0.09 �  4%  perf-profile.children.cycles-pp.get_partial_node
     69.68            -9.1       60.59        perf-profile.children.cycles-pp.__do_sys_brk
      8.99            -9.0        0.00        perf-profile.children.cycles-pp.mas_split
     27.56            -8.0       19.53        perf-profile.children.cycles-pp.rcu_do_batch
     27.59            -8.0       19.56        perf-profile.children.cycles-pp.__do_softirq
     27.58            -8.0       19.55        perf-profile.children.cycles-pp.rcu_core
      7.37            -7.4        0.00        perf-profile.children.cycles-pp.mas_spanning_rebalance
      7.54            -6.5        1.02        perf-profile.children.cycles-pp.mas_destroy
      5.92            -5.9        0.00        perf-profile.children.cycles-pp.mas_topiary_replace
     12.39            -5.8        6.61        perf-profile.children.cycles-pp.vma_complete
     15.46            -5.0       10.49 �  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
     15.44            -5.0       10.48 �  4%  perf-profile.children.cycles-pp.run_ksoftirqd
     15.47            -5.0       10.50 �  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
     15.47            -5.0       10.50 �  4%  perf-profile.children.cycles-pp.ret_from_fork
     15.47            -5.0       10.50 �  4%  perf-profile.children.cycles-pp.kthread
      8.32            -4.6        3.78 �  2%  perf-profile.children.cycles-pp.__slab_free
     74.27            -4.5       69.76        perf-profile.children.cycles-pp.do_syscall_64
     15.32            -4.2       11.08 �  2%  perf-profile.children.cycles-pp.__unfreeze_partials
     20.53            -3.3       17.27        perf-profile.children.cycles-pp.__split_vma
     12.15 �  2%      -3.1        9.09 �  3%  perf-profile.children.cycles-pp.irq_exit_rcu
     12.47 �  2%      -3.0        9.42 �  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     12.50 �  2%      -3.0        9.46 �  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     76.50            -2.3       74.18        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.91 �  4%      -1.8        0.16 �  3%  perf-profile.children.cycles-pp.get_any_partial
      1.09            -0.9        0.14 �  2%  perf-profile.children.cycles-pp.memcpy_orig
      1.72            -0.7        1.05        perf-profile.children.cycles-pp.mas_pop_node
      1.14            -0.2        0.98 �  2%  perf-profile.children.cycles-pp.mas_prev_slot
      1.71 �  2%      -0.1        1.57 �  4%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      1.10            -0.1        0.98        perf-profile.children.cycles-pp.mas_next_slot
      0.32 �  2%      -0.1        0.22 �  3%  perf-profile.children.cycles-pp.inc_slabs_node
      0.60 �  2%      -0.1        0.52        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.48 �  2%      -0.1        0.40 �  2%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.47 �  2%      -0.1        0.40        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.38 �  3%      -0.1        0.31 �  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.18 �  2%      -0.1        0.11        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.44 �  3%      -0.1        0.37        perf-profile.children.cycles-pp.__alloc_pages
      0.27 �  2%      -0.1        0.22 �  4%  perf-profile.children.cycles-pp.mt_free_rcu
      0.25 �  3%      -0.1        0.20 �  3%  perf-profile.children.cycles-pp.rmqueue
      0.20 �  6%      -0.0        0.16 �  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.15 �  3%      -0.0        0.11 �  5%  perf-profile.children.cycles-pp.discard_slab
      0.16 �  4%      -0.0        0.12 �  3%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.08 �  5%      -0.0        0.06        perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.24 �  2%      -0.0        0.22 �  2%  perf-profile.children.cycles-pp.__free_one_page
      0.19 �  2%      +0.0        0.21 �  3%  perf-profile.children.cycles-pp.update_process_times
      0.44 �  2%      +0.0        0.46 �  4%  perf-profile.children.cycles-pp.setup_object
      1.00            +0.0        1.03        perf-profile.children.cycles-pp.shuffle_freelist
      0.20 �  3%      +0.0        0.24 �  4%  perf-profile.children.cycles-pp.should_failslab
      0.09 �  4%      +0.0        0.14 �  3%  perf-profile.children.cycles-pp.strlen
      0.06            +0.0        0.11 �  4%  perf-profile.children.cycles-pp.__kmalloc_node
      0.06 �  8%      +0.0        0.10 �  4%  perf-profile.children.cycles-pp.__init_rwsem
      0.05            +0.0        0.10 �  3%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.memcg_account_kmem
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.testcase
      0.06            +0.1        0.11 �  4%  perf-profile.children.cycles-pp.memcg_alloc_slab_cgroups
      0.05 �  7%      +0.1        0.10 �  4%  perf-profile.children.cycles-pp.__pte_offset_map
      0.00            +0.1        0.05 �  8%  perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.00            +0.1        0.06 �  8%  perf-profile.children.cycles-pp.__free_slab
      0.02 �141%      +0.1        0.08 � 18%  perf-profile.children.cycles-pp.machine__process_mmap2_event
      0.07 � 13%      +0.1        0.13 �  5%  perf-profile.children.cycles-pp.may_expand_vm
      0.05 � 50%      +0.1        0.11 � 18%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.05 � 50%      +0.1        0.11 � 18%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.00            +0.1        0.06 �  6%  perf-profile.children.cycles-pp.memset_orig
      0.12 �  3%      +0.1        0.18 �  2%  perf-profile.children.cycles-pp.anon_vma_clone
      0.08 �  4%      +0.1        0.14 �  3%  perf-profile.children.cycles-pp.vma_dup_policy
      0.07 �  6%      +0.1        0.14 �  2%  perf-profile.children.cycles-pp.free_pgd_range
      0.03 �100%      +0.1        0.10 � 20%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.00            +0.1        0.06 �  7%  perf-profile.children.cycles-pp.mas_prev
      0.11 �  3%      +0.1        0.18 �  2%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.01 �223%      +0.1        0.08        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.11 �  6%      +0.1        0.18 �  2%  perf-profile.children.cycles-pp.unmap_single_vma
      1.17            +0.1        1.24 �  2%  perf-profile.children.cycles-pp.mtree_range_walk
      0.09 �  5%      +0.1        0.17 �  2%  perf-profile.children.cycles-pp.up_read
      0.02 �141%      +0.1        0.10 �  6%  perf-profile.children.cycles-pp.vma_prepare
      0.06 �  6%      +0.1        0.14 �  3%  perf-profile.children.cycles-pp.can_vma_merge_after
      0.10 � 10%      +0.1        0.19 �  6%  perf-profile.children.cycles-pp.kfree
      0.08 �  6%      +0.1        0.16 �  3%  perf-profile.children.cycles-pp.strnlen
      0.10 �  4%      +0.1        0.20 �  2%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.18 �  2%      +0.1        0.27        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.09            +0.1        0.19 �  2%  perf-profile.children.cycles-pp.refill_obj_stock
      0.00            +0.1        0.10 �  4%  perf-profile.children.cycles-pp.mlock_drain_local
      0.10 �  5%      +0.1        0.20 �  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.11 �  4%      +0.1        0.21 �  3%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.10 �  5%      +0.1        0.20        perf-profile.children.cycles-pp.current_obj_cgroup
      0.10 �  6%      +0.1        0.20 �  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 �  5%      +0.1        0.23 �  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.14 �  4%      +0.1        0.26        perf-profile.children.cycles-pp.cap_mmap_addr
      0.15 �  6%      +0.1        0.27        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.10 �  3%      +0.1        0.23        perf-profile.children.cycles-pp.downgrade_write
      0.14 �  3%      +0.1        0.28        perf-profile.children.cycles-pp.remove_vma
      2.56            +0.1        2.70        perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.14 �  2%  perf-profile.children.cycles-pp.mas_is_err
      0.14 �  3%      +0.1        0.28        perf-profile.children.cycles-pp.lru_add_drain
      0.08 �  5%      +0.1        0.22 �  2%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.15 �  3%      +0.1        0.30 �  2%  perf-profile.children.cycles-pp.__x64_sys_brk
      0.15 �  3%      +0.1        0.30 �  2%  perf-profile.children.cycles-pp.vma_adjust_trans_huge
      0.22 �  2%      +0.2        0.38 �  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.06            +0.2        0.24 �  2%  perf-profile.children.cycles-pp.mas_prev_range
      0.16 �  4%      +0.2        0.35        perf-profile.children.cycles-pp.mas_wr_store_setup
      0.24 �  3%      +0.2        0.42        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.22 �  3%      +0.2        0.41        perf-profile.children.cycles-pp.security_mmap_addr
      0.20 �  3%      +0.2        0.39 �  2%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.17 �  5%      +0.2        0.36 �  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.14 �  6%      +0.2        0.34 �  2%  perf-profile.children.cycles-pp.strscpy
      0.01 �223%      +0.2        0.24        perf-profile.children.cycles-pp.mas_wr_append
      0.19 �  4%      +0.2        0.43 �  2%  perf-profile.children.cycles-pp.mas_nomem
      0.25            +0.2        0.50 �  2%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.26            +0.3        0.51 �  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.27 �  2%      +0.3        0.53 �  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.27 �  2%      +0.3        0.56        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.35 �  2%      +0.3        0.68        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.36 �  2%      +0.4        0.72 �  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.39 �  3%      +0.4        0.78        perf-profile.children.cycles-pp.up_write
      0.44 �  2%      +0.4        0.85 �  2%  perf-profile.children.cycles-pp.free_pgtables
      0.35            +0.4        0.77        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.38 �  2%      +0.4        0.81        perf-profile.children.cycles-pp.down_write_killable
      0.56            +0.4        1.01 �  2%  perf-profile.children.cycles-pp.down_write
      0.53 �  2%      +0.5        1.00        perf-profile.children.cycles-pp.zap_pte_range
      0.31 �  2%      +0.5        0.82        perf-profile.children.cycles-pp.mas_wr_end_piv
      0.56            +0.5        1.10        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.89            +0.6        1.45        perf-profile.children.cycles-pp.__cond_resched
      0.64 �  2%      +0.6        1.20        perf-profile.children.cycles-pp.get_unmapped_area
      0.72 �  2%      +0.6        1.32 �  4%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.48 �  2%      +0.6        1.08        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.73 �  2%      +0.6        1.37        perf-profile.children.cycles-pp.check_brk_limits
      0.77 �  2%      +0.7        1.50        perf-profile.children.cycles-pp.zap_pmd_range
      0.94            +0.8        1.77        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.68            +0.8        1.52        perf-profile.children.cycles-pp.mas_wr_walk
      0.00            +0.9        0.90        perf-profile.children.cycles-pp.mas_wr_slot_store
      1.22            +0.9        2.17        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      1.14 �  2%      +1.1        2.20        perf-profile.children.cycles-pp.perf_event_mmap_output
      0.91            +1.1        2.02        perf-profile.children.cycles-pp.mas_walk
      1.32            +1.2        2.54        perf-profile.children.cycles-pp.unmap_page_range
      3.44            +1.3        4.69        perf-profile.children.cycles-pp.__call_rcu_common
      0.33 �  4%      +1.4        1.74        perf-profile.children.cycles-pp.mas_update_gap
      1.63            +1.5        3.10        perf-profile.children.cycles-pp.perf_iterate_sb
      1.79            +1.5        3.30        perf-profile.children.cycles-pp.unmap_vmas
      1.60            +1.6        3.19        perf-profile.children.cycles-pp.mas_find
      1.85            +1.9        3.73        perf-profile.children.cycles-pp.__entry_text_start
      2.39            +2.2        4.60        perf-profile.children.cycles-pp.perf_event_mmap_event
      2.62            +2.5        5.12        perf-profile.children.cycles-pp.perf_event_mmap
      3.15            +2.6        5.79        perf-profile.children.cycles-pp.unmap_region
      2.75            +2.8        5.55        perf-profile.children.cycles-pp.vm_area_dup
      3.46            +3.6        7.04        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.94            +3.9        7.80        perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.68            +4.3        9.03        perf-profile.children.cycles-pp.mas_store_gfp
      3.74            +4.7        8.40        perf-profile.children.cycles-pp.kmem_cache_alloc
     83.90            +4.9       88.80        perf-profile.children.cycles-pp.brk
     32.12            +6.4       38.51        perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.24 �  2%     +11.0       11.20        perf-profile.children.cycles-pp.mas_wr_node_store
      1.38           +13.6       14.95        perf-profile.children.cycles-pp.mas_wr_store_entry
     27.53           -17.1       10.38 �  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.60            -0.8        3.76 �  2%  perf-profile.self.cycles-pp.__slab_free
      0.94            -0.8        0.12 �  4%  perf-profile.self.cycles-pp.memcpy_orig
      1.52            -0.6        0.94        perf-profile.self.cycles-pp.mas_pop_node
      0.79            -0.5        0.30        perf-profile.self.cycles-pp.___slab_alloc
      0.31            -0.2        0.12 �  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.28 �  3%      -0.2        0.09 �  5%  perf-profile.self.cycles-pp.__unfreeze_partials
      1.68 �  2%      -0.1        1.55 �  5%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      2.14            -0.1        2.02        perf-profile.self.cycles-pp.kmem_cache_free
      0.37 �  2%      -0.1        0.28        perf-profile.self.cycles-pp.rcu_nocb_try_bypass
      0.30 �  2%      -0.1        0.22 �  3%  perf-profile.self.cycles-pp.inc_slabs_node
      0.52 �  2%      -0.1        0.46 �  2%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.17 �  2%      -0.1        0.10 �  4%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.26            -0.0        0.21 �  4%  perf-profile.self.cycles-pp.mt_free_rcu
      0.15 �  3%      -0.0        0.11 �  3%  perf-profile.self.cycles-pp.discard_slab
      0.17 �  2%      -0.0        0.14 �  2%  perf-profile.self.cycles-pp.get_any_partial
      0.08 �  5%      -0.0        0.06        perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.15 �  3%      -0.0        0.13 �  3%  perf-profile.self.cycles-pp.__free_one_page
      0.10 �  3%      +0.0        0.12 �  4%  perf-profile.self.cycles-pp.rcu_segcblist_pend_cbs
      0.08 � 10%      +0.0        0.10 �  4%  perf-profile.self.cycles-pp.should_failslab
      0.08            +0.0        0.12 �  3%  perf-profile.self.cycles-pp.strlen
      0.06            +0.0        0.10 �  6%  perf-profile.self.cycles-pp.vma_dup_policy
      0.08            +0.0        0.12 �  3%  perf-profile.self.cycles-pp.anon_vma_clone
      0.06 �  9%      +0.0        0.10 �  6%  perf-profile.self.cycles-pp.may_expand_vm
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mas_prev
      0.03 � 70%      +0.1        0.08 �  5%  perf-profile.self.cycles-pp.__init_rwsem
      0.09 �  8%      +0.1        0.14 �  4%  perf-profile.self.cycles-pp.kfree
      0.00            +0.1        0.06 �  6%  perf-profile.self.cycles-pp.__vm_enough_memory
      0.07 �  6%      +0.1        0.13 �  2%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.03 � 70%      +0.1        0.09 �  7%  perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.15 �  3%      +0.1        0.21 � 11%  perf-profile.self.cycles-pp.setup_object
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.memset_orig
      0.07 �  5%      +0.1        0.13 �  3%  perf-profile.self.cycles-pp.security_mmap_addr
      0.00            +0.1        0.06 �  6%  perf-profile.self.cycles-pp.tlb_batch_pages_flush
      0.06 �  7%      +0.1        0.13 �  3%  perf-profile.self.cycles-pp.free_pgd_range
      0.08            +0.1        0.15 �  2%  perf-profile.self.cycles-pp.check_brk_limits
      0.08 �  6%      +0.1        0.14 �  3%  perf-profile.self.cycles-pp.khugepaged_enter_vma
      0.09 �  4%      +0.1        0.17 �  2%  perf-profile.self.cycles-pp.unmap_single_vma
      0.00            +0.1        0.08 �  6%  perf-profile.self.cycles-pp.vma_prepare
      0.07 �  5%      +0.1        0.15 �  4%  perf-profile.self.cycles-pp.up_read
      0.06 �  7%      +0.1        0.14 �  5%  perf-profile.self.cycles-pp.strnlen
      0.16 �  2%      +0.1        0.24        perf-profile.self.cycles-pp.tlb_gather_mmu
      0.07            +0.1        0.15 �  3%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.09 �  6%      +0.1        0.17        perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.mlock_drain_local
      0.04 � 44%      +0.1        0.12 �  3%  perf-profile.self.cycles-pp.can_vma_merge_after
      0.14 �  2%      +0.1        0.22 �  3%  perf-profile.self.cycles-pp.get_unmapped_area
      0.01 �223%      +0.1        0.09 �  5%  perf-profile.self.cycles-pp.__pte_offset_map
      0.06 �  7%      +0.1        0.15 �  3%  perf-profile.self.cycles-pp.remove_vma
      0.08 �  4%      +0.1        0.17 �  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09            +0.1        0.18 �  3%  perf-profile.self.cycles-pp.refill_obj_stock
      0.08 �  4%      +0.1        0.17 �  3%  perf-profile.self.cycles-pp.current_obj_cgroup
      0.09 �  4%      +0.1        0.18 �  2%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.00            +0.1        0.10 �  4%  perf-profile.self.cycles-pp.mas_is_err
      0.09 �  6%      +0.1        0.19 �  3%  perf-profile.self.cycles-pp.mas_nomem
      0.11 �  4%      +0.1        0.21 �  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.24 �  2%      +0.1        0.35        perf-profile.self.cycles-pp.mas_destroy
      0.12 �  3%      +0.1        0.23 �  2%  perf-profile.self.cycles-pp.cap_mmap_addr
      1.02            +0.1        1.13        perf-profile.self.cycles-pp.mtree_range_walk
      0.15 �  4%      +0.1        0.26 �  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.12 �  6%      +0.1        0.22 �  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.09            +0.1        0.20 �  2%  perf-profile.self.cycles-pp.downgrade_write
      0.13            +0.1        0.25 �  2%  perf-profile.self.cycles-pp.__x64_sys_brk
      0.22 �  2%      +0.1        0.34 �  2%  perf-profile.self.cycles-pp.unmap_vmas
      0.13 �  3%      +0.1        0.26 �  2%  perf-profile.self.cycles-pp.vma_adjust_trans_huge
      0.12 �  4%      +0.1        0.25 �  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.16 �  3%      +0.1        0.30        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.12 �  4%      +0.1        0.26 �  2%  perf-profile.self.cycles-pp.mas_wr_store_setup
      0.14 �  4%      +0.2        0.29 �  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.14 �  2%      +0.2        0.31        perf-profile.self.cycles-pp.free_pgtables
      0.12 �  4%      +0.2        0.28        perf-profile.self.cycles-pp.strscpy
      0.00            +0.2        0.17 �  4%  perf-profile.self.cycles-pp.mas_prev_range
      0.14 �  4%      +0.2        0.31 �  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.18 �  2%      +0.2        0.35        perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.18 �  3%      +0.2        0.36 �  2%  perf-profile.self.cycles-pp.zap_pte_range
      0.15 �  3%      +0.2        0.33 �  2%  perf-profile.self.cycles-pp.zap_pmd_range
      0.27            +0.2        0.47        perf-profile.self.cycles-pp.unmap_region
      0.00            +0.2        0.20 �  2%  perf-profile.self.cycles-pp.mas_wr_append
      0.00            +0.2        0.20 �  3%  perf-profile.self.cycles-pp.mas_wr_slot_store
      0.18 �  2%      +0.2        0.39        perf-profile.self.cycles-pp.vma_complete
      0.34 �  5%      +0.2        0.55 �  3%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.22 �  2%      +0.2        0.44 �  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.45 �  2%      +0.2        0.68        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.20 �  2%      +0.2        0.43 �  2%  perf-profile.self.cycles-pp.down_write_killable
      0.20 �  3%      +0.2        0.44        perf-profile.self.cycles-pp.perf_event_mmap
      0.18 �  3%      +0.2        0.42 �  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.24            +0.3        0.49        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
      0.27 �  3%      +0.3        0.54        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.36 �  2%      +0.3        0.66 �  3%  perf-profile.self.cycles-pp.down_write
      0.30 �  2%      +0.3        0.62        perf-profile.self.cycles-pp.vm_area_dup
      0.32 �  2%      +0.3        0.64 �  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.35            +0.3        0.68        perf-profile.self.cycles-pp.mas_walk
      0.34 �  2%      +0.3        0.68        perf-profile.self.cycles-pp.perf_event_mmap_event
      0.33 �  2%      +0.4        0.68        perf-profile.self.cycles-pp.up_write
      0.44 �  2%      +0.4        0.80        perf-profile.self.cycles-pp.perf_iterate_sb
      0.58            +0.4        0.94 �  2%  perf-profile.self.cycles-pp.__cond_resched
      0.30 �  2%      +0.4        0.68        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.51            +0.4        0.88        perf-profile.self.cycles-pp.mas_next_slot
      0.44 �  2%      +0.4        0.82        perf-profile.self.cycles-pp.unmap_page_range
      0.58            +0.4        0.96        perf-profile.self.cycles-pp.mas_find
      0.26            +0.4        0.68        perf-profile.self.cycles-pp.mas_wr_end_piv
      0.48 �  2%      +0.4        0.90        perf-profile.self.cycles-pp.brk
      0.45            +0.4        0.88        perf-profile.self.cycles-pp.mas_prev_slot
      0.49            +0.4        0.94        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.34 �  2%      +0.4        0.78        perf-profile.self.cycles-pp.mas_store_prealloc
      0.20 �  3%      +0.4        0.65 �  2%  perf-profile.self.cycles-pp.mas_update_gap
      0.41 �  2%      +0.5        0.92        perf-profile.self.cycles-pp.mas_store_gfp
      0.64            +0.6        1.23        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.59 �  2%      +0.6        1.22        perf-profile.self.cycles-pp.__split_vma
      0.44 �  2%      +0.7        1.10        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.66            +0.7        1.35        perf-profile.self.cycles-pp.mas_preallocate
      0.59            +0.7        1.33        perf-profile.self.cycles-pp.do_brk_flags
      0.58            +0.7        1.32        perf-profile.self.cycles-pp.mas_wr_walk
      1.03            +0.8        1.81        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.78            +0.8        1.57        perf-profile.self.cycles-pp.__do_sys_brk
      1.79            +0.9        2.66        perf-profile.self.cycles-pp.__call_rcu_common
      1.02            +1.0        1.98        perf-profile.self.cycles-pp.perf_event_mmap_output
      1.33            +1.4        2.74        perf-profile.self.cycles-pp.kmem_cache_alloc
      1.64            +1.7        3.30        perf-profile.self.cycles-pp.__entry_text_start
      2.26            +2.2        4.50        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.23            +3.3        6.58        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.21 �  2%      +3.6        3.82        perf-profile.self.cycles-pp.mas_wr_node_store
      3.93            +3.9        7.78        perf-profile.self.cycles-pp.syscall_return_via_sysret




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

