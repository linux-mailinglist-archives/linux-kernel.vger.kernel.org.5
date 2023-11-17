Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ACF7EEDAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345704AbjKQInB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjKQInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:43:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5350C11F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700210573; x=1731746573;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=NZkWQk9g8FOdmMI4VEMKJteYnFp7WbK0uodVlJTSQcc=;
  b=fSTN9WAqTvFjOAuMqGwWOPRb52BMqsyFgJpt0pM3XY3a7E0qco/ewJHD
   DBrgJ9g6U2DtCxKtAyP2pk5J3S62sDPmcIGJptMl+wXVVsW/3EX7lOGlr
   n/zgndxvYf8BKiAJMjTHIymt5vE5u2a+/bEtx91LFI1lttJQwk6Q1+yyw
   1APMx0Psk6Q5cL0+vcomqsEnIdKIL20mZLpoEeAGC2WQpFX96reDmm+MZ
   PtlLXF0Nd55UhDOFe/5dEeDb7IeqvBZ1I3c7cqW8IBhK4uT7qNKMOxpqG
   41ogg9rZ9tYZN+JSyPs5feQodomiM0HNSw0apIvDKjQk8/r34UOd2eHr5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="477478671"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="477478671"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 00:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="742033053"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="742033053"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 00:42:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 00:42:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 00:42:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 00:42:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZSjpGI2kDVqTvqDGH97KAwYMPz3uS2leVC98Ir1NV2tHJqMytSCxJmyjrDW84TL7doUlykckFmNg0rVXpRy+qAUMpT3ViACDYw8SVBIW+Q5rOq6tuOt/L/9BBCmNyJrt519H+EwudlkdnsePJIeycA4uh7UvrjnlDG2lgH6JbJiltE9JiqceuCMCjW+kI3JLqRLzK2l2zagIbU8nZUsoehBYg5vxtczu13VKYLbmzgCahSv2aO7mO9lPGstpqX+b0AXPWudVlGfPm8Y/QBMcZTE+wj4V8gs1kpo4eCtHysRhw1rpDwzhWxko/CdxwlsKa1vVSAAy/GDDDCLPw90Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z0epJ/G2QLgPQ/AfgcLo/T3Od+rzSUhtD/lVYdZRfw=;
 b=Z9TnXdguBXysE8xftFXrEvV/zTZQk12MEM6+3PBseXQTPn23sLg6a8WAp5VjDp2sIX89CrAQI9gunzOaJJ0uMa4torOGqWw/uCTWauhR8MUew+ehVS4+z/ATmXtJxU3fixzEtBRVIzKNlYHsHbM0yPTdtYv6tlyfesWeZMEVULvyEuG66vxKRMtiuAShZgAM+//i2o3hU7GPnBQDFm6k2vj2zdXQoAKZNjcLWr86a/8x4rEBZr7am1cYOr6aTvtfovqx2Ayay80YLtbM92delCoj5L1nsNhBd4DwwBJwFGTESvIfCMvuW0/zewnyCtOt93Goi2yYtg3eSc35hQK2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB7774.namprd11.prod.outlook.com (2603:10b6:208:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 08:42:44 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 08:42:44 +0000
Date:   Fri, 17 Nov 2023 16:42:31 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Huang Ying <ying.huang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  51a755c56d:  will-it-scale.per_thread_ops 21.7%
 improvement
Message-ID: <202311171535.870e7726-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 5212ba2c-0ba5-4ac0-d426-08dbe749299e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dgV1wY6faXgimgCz93wZGL7uBrNwJEVlIUYRwugr6ljIzDZ3Y/fa8lhGXdcpHd+xPsvDRPsjfDsiNkMQLRvNeCzVHwAKvkHIHk3EkWQLJxzkv88LwbREejnXfIW7vfec1/0X+5ViyInExKHh8AwaqvDbJFCiUf/+/GzLuZdvdkIENyDrScx12tpowN0sCbr8yOKTh2RQZspakwiE3bR2ha4p9o+LqMwzAts8egBCyl+D3TSD0vG+JaqoUjIASTdmObis9Ryy3QInaCt2awjwnrnBnuu0bBraksImfw9Yh4b3JkQibzXgkYmVXp0EJU8ERfQrgxSwPUKkx/Wg5lOoEVxCm1J5gqMLYg8tz6/XmufzVRhHpe43MIDkpQ5Sy+WFdBkXTWtNr6kDPaTycpIccqlnSbuuusIOYedCEJrspQbn+k8ZuAJpc5SJOX9WMjJ9//Q/4eue650Tdxlz7wPaNq16tW+Rs8DKce94tXypvV+q43rhu1wJetre+Oo59W+DUYWS/ONA5jOrCSSBjO2Z+eXdYtaDMXqK9VW0dfcMBoJE3Q2IHlLbIHS8sxoLlh2KEuyUoK7iX0BE9RF90Urah3rNm2FPU2x08m+O8W+NMdahBkFTTnd1WX/g+oXa+bCvPBJu5d1YHlneVSg9i/mYCh30weDcAzb7yXHysqFSnS7wb/AJa6WrxKrp98XdFTLWRSFcRlL/D/bs1MHuQjeMSWZHqaZg3Jide3Emm4Hi9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(230273577357003)(230473577357003)(230373577357003)(230173577357003)(1800799009)(451199024)(64100799003)(186009)(6486002)(966005)(478600001)(19627235002)(2906002)(6506007)(6512007)(2616005)(6666004)(5660300002)(86362001)(7416002)(6636002)(316002)(37006003)(66556008)(4326008)(66476007)(8936002)(66946007)(8676002)(6862004)(30864003)(54906003)(38100700002)(83380400001)(41300700001)(82960400001)(26005)(1076003)(36756003)(559001)(579004)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JpyyXWg7Kh7pBv9IniY4gC8jQ7oTAJ2nBuvcuWGJI7EhDhAYHr+ChvRuxE?=
 =?iso-8859-1?Q?CjakwAUu5P+C2H8MCniz9ZQH0IpBR92cFF95nSYcpvJ6rabtMlfnFkopMu?=
 =?iso-8859-1?Q?h6EZCVOGtcbFm0uVzVYcAn0cyt1Mxoxj5LohoB87CTHBdrRlbOXS4BnJcd?=
 =?iso-8859-1?Q?2qCd5xDCI6yZb5xdaLAoPZrD/MOwhfhLQSh7ppvC7uloC/r+bLYgOc0RPy?=
 =?iso-8859-1?Q?qo0wVtAb6RcajAu/IlsvfG9uU515W+yaPql6NdSbQ/99PGnE2HDe1aPDcr?=
 =?iso-8859-1?Q?e8CM5WnH10GyrUT3bT1EnIePDH6re2eTgExDWCd3oN/7NcBOIaD8ocjMhG?=
 =?iso-8859-1?Q?XV/FoF3LPImIuLIfXpy9Etq0hVFF+D6fKtSyZ5XbVM1e4I62hnEUTWjl0J?=
 =?iso-8859-1?Q?dlpbFTQ9oBUjh1wQuUIBhKWGn40FNE4UvmTWgCqh7KJs5s88wpmFPT/FFA?=
 =?iso-8859-1?Q?XC3DUl0Yq0TlIxytW5X5c+4bzdWYmCFeMrJiBrLxTJpI4HtWjP6OHfbpZL?=
 =?iso-8859-1?Q?3l/hD1X88y/qTgdlLbMdlDGO3Rw3BddrFjLevXEGA3dP/rEhO1/RXveAkJ?=
 =?iso-8859-1?Q?P/N7Oo3tr9O6rlax1IWmfM4+unWS8TzYPnpQsGJnXFfsRb3dbexmHDCs4D?=
 =?iso-8859-1?Q?XS4FzH5gxBV2ohrbbhTGR2ODFhZBjvtjNTkTPvSfkRSOQK3hIi1dEczvnO?=
 =?iso-8859-1?Q?M4fPESyugGL/E41x6fgT8LUapYA1MZ25khd5njfLSDQy/5xgrhAkbKaAER?=
 =?iso-8859-1?Q?/qN7hEC4Bhb/1b9cnDNmwggF6/K6hwGz3/+eYtARAk6h5c0sMXAbfhGXo4?=
 =?iso-8859-1?Q?IiNqNXUCqBSWheKFKE6bkh/o/KDnfD5JjODNXiYxWp3iY/ke2i49XA/Vm1?=
 =?iso-8859-1?Q?rAyZ+4aGq/EOGCDOEowpw0/u9lkHFHkdoTXg4l2hX1jSmPfMcN6GW6inAF?=
 =?iso-8859-1?Q?7QjNgKl+g4rHJ+AduNMda4VsSCljhX2sx6lfZZth0lYiC/DVQfaDp/PsRt?=
 =?iso-8859-1?Q?ognRODmzY3NdrEImxCJ6AuzZB8F3ePNqFnS/wWZVMOsl7piDXC/Wz0/9f9?=
 =?iso-8859-1?Q?K2ylTfRpwvzsj9QJTFCGZQSONRtCJlMM0jcFdXUwg2OFqwAeFjw52lIr82?=
 =?iso-8859-1?Q?WZPBOY3gJMR7wp33uoAQZjoVt8pMdiQKXLqpRjfOAF1xsNjbW3/NMeRnR8?=
 =?iso-8859-1?Q?gW34sRc0YBTfWfqnyBfmsKFEyPtcbzcEIcEwQcJJlEJSKFXPzWMBD0R7L8?=
 =?iso-8859-1?Q?1Agh+9IEokQk63N9r+6C3FVsbSmSds8m3mxn2jpTqqm1CRcqPlygAQUdTO?=
 =?iso-8859-1?Q?zDfRo0cpIxVJ2IAH4NTSfr0rO4sS4HhZqq86emEA7DFikak6pA4lKA+PBs?=
 =?iso-8859-1?Q?O5IoY8CRagrn95LmGnW++N6jlThveY6eWe+X/5kZ6gns3ipW833GsrBawV?=
 =?iso-8859-1?Q?DZ/UNmoGlfnhjEGESLp0CzmTl/9VMrGnmuTL4EB0jArF1a7rJ7BR5ZyknD?=
 =?iso-8859-1?Q?q7CpLA5EbLMKeMTX1djMnfQ5KFGBlUNq6NIul19tx/baKggMIBx82sEGh/?=
 =?iso-8859-1?Q?H41FNpt4cnz8HH3Pn2SNTtPGIHcUEA/DHgQumEv2B2IpemGr+8Z6F8aLyE?=
 =?iso-8859-1?Q?ZWlEG6FRB6yfGmexZ2fyoi7rtyMZmNzUGWWZ8Ta5y4lCtBV/ZLWLxi2g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5212ba2c-0ba5-4ac0-d426-08dbe749299e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:42:42.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGNwlimugvc/oxpUKRMSWoIaWwIIB54DmXODbWYYr4sHBUNxnylrOTmyTCBFIoCY/b2kBXoDSkSpW+v4RHldqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7774
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


hi, Huang Ying,

FYI.

we reported a "8.4% improvement of will-it-scale.per_process_ops"
in https://lore.kernel.org/all/202310311001.edbc5817-oliver.sang@intel.com/
when this commit is a review patch.

now we got more results for this commit from different testsuites.


Hello,

kernel test robot noticed a 21.7% improvement of will-it-scale.per_thread_ops on:


commit: 51a755c56dc05a8b31ed28d24f28354946dc7529 ("mm: tune PCP high automatically")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: page_fault2
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.tee.ops_per_sec 7.3% improvement                                           |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=os                                                                                        |
|                  | cpufreq_governor=performance                                                                    |
|                  | disk=1HDD                                                                                       |
|                  | fs=ext4                                                                                         |
|                  | nr_threads=1                                                                                    |
|                  | test=tee                                                                                        |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | kbuild: kbuild.buildtime_per_iteration -4.3% improvement                                        |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory     |
| test parameters  | build_kconfig=allyesconfig                                                                      |
|                  | cg_count=8                                                                                      |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_instances=8                                                                                  |
|                  | nr_task=100%                                                                                    |
|                  | runtime=300s                                                                                    |
|                  | target=autoksyms_recursive                                                                      |
+------------------+-------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231117/202311171535.870e7726-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

commit: 
  90b41691b9 ("mm: add framework for PCP high auto-tuning")
  51a755c56d ("mm: tune PCP high automatically")

90b41691b9881376 51a755c56dc05a8b31ed28d24f2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  12802502 ±  7%     +15.8%   14830950 ±  6%  numa-meminfo.node0.MemUsed
     11.27 ±  2%      +2.2       13.50 ±  4%  mpstat.cpu.all.sys%
      1.98 ±  3%      +0.5        2.47 ±  4%  mpstat.cpu.all.usr%
     13.16 ±  3%     +38.4%      18.22 ± 14%  vmstat.procs.r
    108191            +1.6%     109948        vmstat.system.in
     75070 ±  2%     +11.1%      83424        meminfo.Active(anon)
  26324616 ±  2%     +15.9%   30519400 ±  3%  meminfo.Memused
  30162143           +10.7%   33394722        meminfo.max_used_kB
 4.287e+08           +21.0%  5.187e+08        numa-numastat.node0.local_node
 4.288e+08           +21.0%  5.189e+08        numa-numastat.node0.numa_hit
 4.305e+08           +21.2%  5.217e+08        numa-numastat.node1.local_node
 4.306e+08           +21.2%  5.219e+08        numa-numastat.node1.numa_hit
 4.288e+08           +21.0%  5.189e+08        numa-vmstat.node0.numa_hit
 4.287e+08           +21.0%  5.187e+08        numa-vmstat.node0.numa_local
 4.306e+08           +21.2%  5.219e+08        numa-vmstat.node1.numa_hit
 4.305e+08           +21.2%  5.217e+08        numa-vmstat.node1.numa_local
   2787817           +21.7%    3391765        will-it-scale.104.threads
     85.06            -3.6%      82.03        will-it-scale.104.threads_idle
     26805           +21.7%      32612        will-it-scale.per_thread_ops
   2787817           +21.7%    3391765        will-it-scale.workload
    408.33 ±  2%     +18.6%     484.17 ±  3%  turbostat.Avg_MHz
     15.25            +2.7       17.92 ±  2%  turbostat.Busy%
    135494 ±  3%     +12.7%     152740 ±  2%  turbostat.C1E
      5.43 ±  7%     -13.1%       4.72 ± 14%  turbostat.Pkg%pc2
     39.26            +7.5%      42.21 ±  2%  turbostat.RAMWatt
    578660 ±  8%     +22.6%     709175 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.avg
    660265 ±  8%     +23.9%     817928 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.max
    498820 ±  9%     +24.7%     622028 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.min
    578660 ±  8%     +22.6%     709175 ± 11%  sched_debug.cfs_rq:/.min_vruntime.avg
    660265 ±  8%     +23.9%     817928 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
    498820 ±  9%     +24.7%     622028 ± 11%  sched_debug.cfs_rq:/.min_vruntime.min
     18767 ±  2%     +11.1%      20856        proc-vmstat.nr_active_anon
   2295948 ±  2%      -6.9%    2137726 ±  3%  proc-vmstat.nr_anon_pages
   4232098            -2.5%    4127279        proc-vmstat.nr_dirty_background_threshold
   8474544            -2.5%    8264649        proc-vmstat.nr_dirty_threshold
  42600519            -2.5%   41550790        proc-vmstat.nr_free_pages
      5982 ±  2%      -4.7%       5703 ±  4%  proc-vmstat.nr_page_table_pages
     18767 ±  2%     +11.1%      20856        proc-vmstat.nr_zone_active_anon
 8.595e+08           +21.1%  1.041e+09        proc-vmstat.numa_hit
 8.592e+08           +21.1%   1.04e+09        proc-vmstat.numa_local
     17609           +14.5%      20168 ±  2%  proc-vmstat.pgactivate
 8.588e+08           +21.1%   1.04e+09        proc-vmstat.pgalloc_normal
 8.532e+08           +21.2%  1.034e+09        proc-vmstat.pgfault
 8.588e+08           +21.1%   1.04e+09        proc-vmstat.pgfree
    221.04 ±  9%     -20.2%     176.48 ±  9%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault
    236.20 ±  4%     -17.9%     193.89 ± 12%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    481.80 ±  6%     -12.6%     421.09 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    372.17           +21.9%     453.67 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    525.17 ±  3%     +17.8%     618.83 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
    859.18 ±  7%     -22.6%     664.65 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault
    826.77 ±  3%     -17.4%     682.64 ±  8%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    902.26 ±  2%     -17.6%     743.88        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    898.76 ±  2%     -17.9%     737.48 ±  2%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
    892.16           -19.3%     719.72 ±  3%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      3200 ± 23%     -36.0%       2047        perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    221.03 ±  9%     -20.2%     176.47 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault
    236.19 ±  4%     -17.9%     193.88 ± 12%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    257.10 ± 11%     -24.3%     194.65 ± 16%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    481.79 ±  6%     -12.6%     421.07 ±  5%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    859.17 ±  7%     -22.6%     664.64 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault
    826.76 ±  3%     -17.4%     682.61 ±  8%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      4.99           -26.7%       3.66 ± 46%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    902.25 ±  2%     -17.6%     743.87        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    898.76 ±  2%     -17.9%     737.47 ±  2%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
    892.15           -19.3%     719.71 ±  3%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      3200 ± 23%     -36.0%       2047        perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     17.81            +5.4%      18.77 ±  2%  perf-stat.i.MPKI
 2.757e+09 ±  2%     +12.3%  3.095e+09 ±  4%  perf-stat.i.branch-instructions
  17802341 ±  2%     +10.0%   19577239        perf-stat.i.branch-misses
 2.478e+08 ±  2%     +18.7%  2.942e+08 ±  4%  perf-stat.i.cache-misses
 3.278e+08 ±  2%     +16.4%  3.817e+08 ±  3%  perf-stat.i.cache-references
      2171            +4.4%       2266        perf-stat.i.context-switches
 4.121e+10 ±  2%     +18.9%  4.901e+10 ±  3%  perf-stat.i.cpu-cycles
   4473669           +13.9%    5095078 ±  3%  perf-stat.i.dTLB-load-misses
 3.428e+09 ±  2%     +13.0%  3.875e+09 ±  4%  perf-stat.i.dTLB-loads
  23278813 ±  3%     +19.0%   27706904 ±  4%  perf-stat.i.dTLB-store-misses
 1.984e+09 ±  2%     +12.3%  2.229e+09 ±  4%  perf-stat.i.dTLB-stores
   3269062 ±  2%     +10.1%    3599182 ±  3%  perf-stat.i.iTLB-load-misses
  1.37e+10 ±  2%     +12.1%  1.536e+10 ±  4%  perf-stat.i.instructions
      0.33 ±  2%      -7.5%       0.31 ±  3%  perf-stat.i.ipc
      0.40 ±  2%     +19.0%       0.47 ±  3%  perf-stat.i.metric.GHz
      1093 ±  2%     +14.7%       1255        perf-stat.i.metric.K/sec
     81.59 ±  2%     +12.7%      91.99 ±  4%  perf-stat.i.metric.M/sec
   2713788 ±  2%     +19.3%    3237427 ±  4%  perf-stat.i.minor-faults
    853023 ±  4%     +18.9%    1013893 ±  5%  perf-stat.i.node-store-misses
  18724346 ±  3%     +23.7%   23169388 ±  5%  perf-stat.i.node-stores
   2713788 ±  2%     +19.3%    3237428 ±  4%  perf-stat.i.page-faults
     18.08            +6.0%      19.16        perf-stat.overall.MPKI
      3.01            +6.2%       3.19        perf-stat.overall.cpi
      1.16            +0.1        1.23        perf-stat.overall.dTLB-store-miss-rate%
     77.36            +1.2       78.59        perf-stat.overall.iTLB-load-miss-rate%
      4193            +1.7%       4265        perf-stat.overall.instructions-per-iTLB-miss
      0.33            -5.8%       0.31        perf-stat.overall.ipc
   1545577            -6.5%    1445085        perf-stat.overall.path-length
 2.746e+09 ±  2%     +12.4%  3.088e+09 ±  3%  perf-stat.ps.branch-instructions
  17737673 ±  2%     +10.1%   19529869 ±  2%  perf-stat.ps.branch-misses
 2.468e+08 ±  2%     +19.0%  2.936e+08 ±  4%  perf-stat.ps.cache-misses
 3.265e+08 ±  2%     +16.7%  3.809e+08 ±  3%  perf-stat.ps.cache-references
      2163            +4.4%       2258        perf-stat.ps.context-switches
 4.104e+10 ±  2%     +19.2%   4.89e+10 ±  3%  perf-stat.ps.cpu-cycles
   4454691           +14.1%    5081224 ±  3%  perf-stat.ps.dTLB-load-misses
 3.415e+09 ±  2%     +13.2%  3.866e+09 ±  3%  perf-stat.ps.dTLB-loads
  23183123 ±  3%     +19.3%   27649621 ±  4%  perf-stat.ps.dTLB-store-misses
 1.977e+09 ±  2%     +12.5%  2.223e+09 ±  3%  perf-stat.ps.dTLB-stores
   3254884 ±  2%     +10.3%    3590936 ±  3%  perf-stat.ps.iTLB-load-misses
 1.365e+10 ±  2%     +12.2%  1.532e+10 ±  3%  perf-stat.ps.instructions
   2702503 ±  2%     +19.5%    3230643 ±  4%  perf-stat.ps.minor-faults
    849448 ±  4%     +19.1%    1011660 ±  5%  perf-stat.ps.node-store-misses
  18626748 ±  2%     +24.0%   23103310 ±  5%  perf-stat.ps.node-stores
   2702503 ±  2%     +19.5%    3230644 ±  4%  perf-stat.ps.page-faults
 4.309e+12           +13.8%  4.901e+12        perf-stat.total.instructions
      3.01 ±  2%      -1.9        1.14 ±  2%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc
      3.46 ±  2%      -1.9        1.60        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio
      3.72            -1.8        1.88        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault
      4.47            -1.8        2.65        perf-profile.calltrace.cycles-pp.__folio_alloc.vma_alloc_folio.do_cow_fault.do_fault.__handle_mm_fault
      5.19            -1.8        3.38        perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      4.36            -1.8        2.56        perf-profile.calltrace.cycles-pp.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault.do_fault
      5.08            -1.0        4.03 ±  2%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      5.10            -1.0        4.05 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      5.10            -1.0        4.05 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      5.10            -1.0        4.05 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      5.59            -1.0        4.55        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.59            -1.0        4.55        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.54            -1.0        4.51        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      5.54            -1.0        4.51        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.54            -1.0        4.51        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      5.54            -1.0        4.52        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.54            -1.0        4.52        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.64 ±  2%      -0.9        0.73 ±  4%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range
      3.28 ±  2%      -0.8        2.47 ±  3%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      3.08 ±  2%      -0.8        2.29 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range
      1.37 ±  4%      -0.3        1.05 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.26 ±  4%      -0.3        0.97 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.79 ±  4%      -0.3        0.54 ±  4%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.68 ±  4%      -0.2        0.44 ± 44%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.87 ±  4%      -0.2        0.66 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.86 ±  4%      -0.2        0.65 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.77            +0.0        0.80 ±  2%  perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.75 ±  4%      +0.1        0.87        perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages
      3.24 ± 70%      +1.9        5.18 ±  3%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.testcase
      4.78 ± 71%      +3.6        8.36 ±  9%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     35.49 ± 70%     +19.0       54.48        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     35.70 ± 70%     +19.2       54.86        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     45.53 ± 70%     +24.5       70.04        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     49.48 ± 70%     +26.7       76.19        perf-profile.calltrace.cycles-pp.testcase
      2.18 ±  2%      -2.0        0.19 ± 13%  perf-profile.children.cycles-pp.rmqueue_bulk
      3.03 ±  2%      -1.9        1.17 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      3.48 ±  2%      -1.9        1.63        perf-profile.children.cycles-pp.rmqueue
      3.76 ±  2%      -1.8        1.92        perf-profile.children.cycles-pp.get_page_from_freelist
      5.24            -1.8        3.43        perf-profile.children.cycles-pp.vma_alloc_folio
      4.46            -1.8        2.65        perf-profile.children.cycles-pp.__alloc_pages
      4.50            -1.8        2.68        perf-profile.children.cycles-pp.__folio_alloc
      5.67            -1.1        4.61        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.67            -1.1        4.61 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
      5.11            -1.1        4.05 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      5.10            -1.1        4.05 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      5.10            -1.1        4.05 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
      5.10            -1.1        4.05 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
      5.54            -1.0        4.51        perf-profile.children.cycles-pp.do_vmi_munmap
      5.54            -1.0        4.51        perf-profile.children.cycles-pp.do_vmi_align_munmap
      5.54            -1.0        4.51        perf-profile.children.cycles-pp.unmap_region
      5.54            -1.0        4.52        perf-profile.children.cycles-pp.__vm_munmap
      5.54            -1.0        4.52        perf-profile.children.cycles-pp.__x64_sys_munmap
      2.31 ±  2%      -1.0        1.31 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      1.12 ±  2%      -1.0        0.16 ± 17%  perf-profile.children.cycles-pp.free_pcppages_bulk
      1.87 ±  2%      -0.9        0.96 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      0.88 ±  2%      -0.8        0.08 ± 17%  perf-profile.children.cycles-pp.__free_one_page
      3.70 ±  2%      -0.8        2.91 ±  2%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      3.70            -0.8        2.91 ±  2%  perf-profile.children.cycles-pp.release_pages
      1.84 ±  2%      -0.3        1.52 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.69 ±  3%      -0.3        1.40 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.86 ±  3%      -0.2        0.62 ±  4%  perf-profile.children.cycles-pp._compound_head
      1.26 ±  2%      -0.2        1.05 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.25 ±  2%      -0.2        1.04 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.03 ±  2%      -0.2        0.88 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.75 ±  3%      -0.1        0.65 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.64 ±  3%      -0.1        0.55 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.62 ±  3%      -0.1        0.53 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.20 ± 10%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.27 ±  3%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.42 ±  4%      -0.0        0.38 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.25 ±  5%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.22 ±  4%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.__do_softirq
      0.26 ±  3%      -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.07 ± 11%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ±  8%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.rebalance_domains
      0.22 ±  3%      +0.0        0.25 ±  7%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.61 ±  2%      +0.0        0.65 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.22 ±  4%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.free_unref_page_commit
     63.85 ±  2%      +2.3       66.11        perf-profile.children.cycles-pp.asm_exc_page_fault
     50.80 ± 70%     +27.4       78.16        perf-profile.children.cycles-pp.testcase
      2.29 ±  2%      -1.0        1.29 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.81 ±  2%      -0.7        0.08 ± 16%  perf-profile.self.cycles-pp.__free_one_page
      0.83 ±  3%      -0.2        0.59 ±  4%  perf-profile.self.cycles-pp._compound_head
      0.16 ±  9%      -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.22 ±  4%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.07 ± 11%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.18 ±  5%      +0.1        0.24 ±  6%  perf-profile.self.cycles-pp.free_unref_page_commit
      4.82 ±  4%      +0.3        5.12 ±  3%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/tee/stress-ng/60s

commit: 
  90b41691b9 ("mm: add framework for PCP high auto-tuning")
  51a755c56d ("mm: tune PCP high automatically")

90b41691b9881376 51a755c56dc05a8b31ed28d24f2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.49 ±  2%      +5.1%       4.72        iostat.cpu.system
     13.17 ± 37%    +297.5%      52.33 ± 10%  perf-c2c.DRAM.local
   4220495           +41.3%    5963110 ±  2%  meminfo.Memused
   4413400           +49.6%    6602610 ±  2%  meminfo.max_used_kB
      1.88 ±  9%     +15.1%       2.16 ±  3%  vmstat.procs.r
    392790 ±  6%     +12.2%     440728 ±  2%  vmstat.system.cs
   7949050           -17.1%    6588099 ±  2%  turbostat.C1
   5086443 ±  2%     +45.5%    7401168 ±  2%  turbostat.POLL
      0.64 ±  4%      +0.2        0.88 ±  2%  turbostat.POLL%
     10.14           +17.4%      11.90        turbostat.RAMWatt
      4937            +7.9%       5328        stress-ng.tee.MB_per_sec_tee_rate
   4337007            +7.3%    4653199        stress-ng.tee.ops
     72283            +7.3%      77552        stress-ng.tee.ops_per_sec
    156.00            +3.1%     160.83        stress-ng.time.percent_of_cpu_this_job_got
  12919919            +6.8%   13799190        stress-ng.time.voluntary_context_switches
   3159837            -1.4%    3116345        proc-vmstat.nr_dirty_background_threshold
   6327400            -1.4%    6240310        proc-vmstat.nr_dirty_threshold
  31845599            -1.4%   31410045        proc-vmstat.nr_free_pages
  70507884            +7.8%   75976213        proc-vmstat.numa_hit
  70782062            +7.6%   76126317        proc-vmstat.numa_local
    191701            +5.0%     201297        proc-vmstat.pgactivate
  69867033            +7.2%   74928835        proc-vmstat.pgalloc_normal
  69646767            +7.3%   74699424        proc-vmstat.pgfree
      0.00           +45.8%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ± 19%     -73.3%       0.00 ±111%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.do_tee
      0.00 ± 16%     +32.0%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00 ± 14%     +66.7%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.00 ±  9%     +43.5%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±  7%     +25.8%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  9%     +39.4%       0.01 ±  6%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 25%     +58.3%       0.02 ± 22%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 19%     +52.9%       0.01 ± 14%  perf-sched.sch_delay.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.01 ± 11%     +30.0%       0.01 ±  7%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01           -10.0%       0.01        perf-sched.wait_time.avg.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
      0.15 ± 70%    +214.9%       0.49 ± 24%  perf-sched.wait_time.max.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
      0.15 ± 70%    +198.1%       0.46 ± 20%  perf-sched.wait_time.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.70 ±  4%      +9.5%       0.76 ±  2%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.68 ± 76%    +155.9%       1.75 ± 10%  perf-stat.i.MPKI
 1.122e+09 ±  6%     +12.9%  1.267e+09 ±  2%  perf-stat.i.branch-instructions
  11559790 ±  4%      +6.7%   12333216        perf-stat.i.branch-misses
      2.20 ±  7%      +6.6        8.76        perf-stat.i.cache-miss-rate%
   1668949 ±  3%    +520.8%   10360464        perf-stat.i.cache-misses
  1.09e+08 ±  4%     +12.9%   1.23e+08 ±  2%  perf-stat.i.cache-references
    413226 ±  6%     +11.6%     461308 ±  2%  perf-stat.i.context-switches
      2.44 ± 33%     -24.0%       1.86 ± 15%  perf-stat.i.cpi
 9.239e+09 ±  4%      +9.0%  1.007e+10        perf-stat.i.cpu-cycles
     21785 ± 11%     -95.0%       1082 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.452e+09 ±  6%     +12.3%   1.63e+09 ±  2%  perf-stat.i.dTLB-loads
      0.03 ±100%      -0.0        0.01 ±128%  perf-stat.i.dTLB-store-miss-rate%
     17646 ± 48%     -33.9%      11661 ± 40%  perf-stat.i.dTLB-store-misses
 8.473e+08 ±  6%     +11.8%  9.471e+08 ±  2%  perf-stat.i.dTLB-stores
     55.72 ±  3%      +3.9       59.62        perf-stat.i.iTLB-load-miss-rate%
   2800892 ±  6%     +18.4%    3316672 ±  4%  perf-stat.i.iTLB-load-misses
 5.564e+09 ±  6%     +12.5%  6.259e+09 ±  2%  perf-stat.i.instructions
      0.36 ± 61%    +229.0%       1.19 ± 25%  perf-stat.i.major-faults
      0.26 ±  4%      +9.0%       0.28        perf-stat.i.metric.GHz
     97.93 ±  6%     +12.5%     110.14 ±  2%  perf-stat.i.metric.M/sec
    175796 ±  7%    +538.3%    1122134 ±  5%  perf-stat.i.node-loads
    129758 ±  9%   +3017.5%    4045214 ±  2%  perf-stat.i.node-stores
      0.30 ±  5%    +449.8%       1.66 ±  2%  perf-stat.overall.MPKI
      1.03 ±  2%      -0.1        0.97        perf-stat.overall.branch-miss-rate%
      1.54 ±  4%      +6.9        8.42        perf-stat.overall.cache-miss-rate%
      1.66            -3.2%       1.61        perf-stat.overall.cpi
      5531 ±  4%     -82.4%     972.35        perf-stat.overall.cycles-between-cache-misses
      0.00 ± 54%      -0.0        0.00 ± 43%  perf-stat.overall.dTLB-store-miss-rate%
     54.97            +4.8       59.81        perf-stat.overall.iTLB-load-miss-rate%
      1987            -5.0%       1888 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.60            +3.3%       0.62        perf-stat.overall.ipc
 1.105e+09 ±  6%     +12.8%  1.247e+09 ±  2%  perf-stat.ps.branch-instructions
  11395753 ±  3%      +6.6%   12144343        perf-stat.ps.branch-misses
   1646114 ±  3%    +519.7%   10200462        perf-stat.ps.cache-misses
 1.074e+08 ±  4%     +12.8%  1.211e+08        perf-stat.ps.cache-references
    407030 ±  6%     +11.6%     454150 ±  2%  perf-stat.ps.context-switches
 9.102e+09 ±  4%      +9.0%  9.917e+09        perf-stat.ps.cpu-cycles
 1.431e+09 ±  6%     +12.2%  1.605e+09 ±  2%  perf-stat.ps.dTLB-loads
     17420 ± 48%     -34.0%      11490 ± 40%  perf-stat.ps.dTLB-store-misses
 8.347e+08 ±  6%     +11.7%  9.324e+08 ±  2%  perf-stat.ps.dTLB-stores
   2759091 ±  6%     +18.3%    3265175 ±  4%  perf-stat.ps.iTLB-load-misses
 5.482e+09 ±  6%     +12.4%  6.162e+09 ±  2%  perf-stat.ps.instructions
      0.36 ± 61%    +228.8%       1.17 ± 25%  perf-stat.ps.major-faults
    173361 ±  7%    +537.3%    1104794 ±  5%  perf-stat.ps.node-loads
    127864 ±  9%   +3014.6%    3982491 ±  2%  perf-stat.ps.node-stores
 3.744e+11            +6.9%  4.001e+11        perf-stat.total.instructions
     10.56 ±  7%      -3.4        7.13 ±  4%  perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
     10.71 ±  7%      -3.4        7.29 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
     10.24 ±  7%      -3.4        6.82 ±  4%  perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write
     10.06 ±  7%      -3.4        6.64 ±  4%  perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyin._copy_from_iter.copy_page_from_iter.pipe_write
     19.90 ±  7%      -3.2       16.70 ±  4%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.06 ±  7%      -3.2       16.86 ±  4%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     20.13 ±  7%      -3.2       16.94 ±  4%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     20.26 ±  7%      -3.2       17.07 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     20.22 ±  7%      -3.2       17.03 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     20.54 ±  7%      -3.2       17.36 ±  4%  perf-profile.calltrace.cycles-pp.write
      2.81 ± 13%      -1.2        1.60 ± 11%  perf-profile.calltrace.cycles-pp.anon_pipe_buf_release.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.71 ± 13%      +0.2        0.86        perf-profile.calltrace.cycles-pp.__wake_up.do_tee.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69 ± 14%      +0.2        0.84        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up.do_tee.__x64_sys_tee.do_syscall_64
      0.71 ± 11%      +0.3        0.97 ± 10%  perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_unref_page.pipe_read.vfs_read
      0.42 ± 71%      +0.3        0.72        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up.do_tee
      0.44 ± 71%      +0.3        0.75 ±  2%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up.do_tee.__x64_sys_tee
      0.74 ±  7%      +0.4        1.14 ±  9%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages
      1.04 ± 12%      +0.4        1.46 ± 10%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page.pipe_read.vfs_read.ksys_read
      3.47 ±  6%      +0.5        4.00 ±  4%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.pipe_write.vfs_write
      0.00            +0.7        0.66 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.01 ±  7%      +0.8        1.81 ±  7%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages.pipe_write
      4.58 ±  9%      +1.1        5.68 ±  3%  perf-profile.calltrace.cycles-pp.do_tee.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
      4.68 ±  9%      +1.1        5.78 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
      4.81 ±  9%      +1.1        5.92 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
      4.90 ±  9%      +1.1        6.02 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.tee
      5.40 ±  9%      +1.2        6.59 ±  3%  perf-profile.calltrace.cycles-pp.tee
      8.09 ±  5%      +1.4        9.45 ±  4%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     42.84 ±  4%      +3.4       46.27 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     49.48 ±  3%      +3.5       52.94 ±  3%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     42.60 ±  3%      +4.0       46.61        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     42.60 ±  3%      +4.0       46.63        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     42.53 ±  3%      +4.0       46.56        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     37.69 ±  4%      +4.2       41.89        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     36.47 ±  4%      +4.3       40.76        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     21.20 ±  3%      -4.0       17.18 ±  5%  perf-profile.children.cycles-pp.rep_movs_alternative
     48.37 ±  3%      -3.6       44.78 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     48.17 ±  3%      -3.6       44.60 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     10.57 ±  7%      -3.4        7.14 ±  4%  perf-profile.children.cycles-pp._copy_from_iter
     10.39 ±  7%      -3.4        6.96 ±  4%  perf-profile.children.cycles-pp.copyin
     10.73 ±  7%      -3.4        7.30 ±  4%  perf-profile.children.cycles-pp.copy_page_from_iter
     20.07 ±  7%      -3.2       16.87 ±  4%  perf-profile.children.cycles-pp.vfs_write
     19.94 ±  7%      -3.2       16.74 ±  4%  perf-profile.children.cycles-pp.pipe_write
     20.14 ±  7%      -3.2       16.96 ±  4%  perf-profile.children.cycles-pp.ksys_write
     20.57 ±  7%      -3.2       17.39 ±  4%  perf-profile.children.cycles-pp.write
      3.22 ± 10%      -1.2        1.99 ±  7%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.17 ± 11%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.__cond_resched
      0.04 ± 47%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.opipe_prep
      0.64 ±  6%      +0.3        0.92 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.72 ± 11%      +0.3        1.00 ± 10%  perf-profile.children.cycles-pp.__free_one_page
      0.75 ±  6%      +0.4        1.15 ±  9%  perf-profile.children.cycles-pp.rmqueue_bulk
      1.04 ± 12%      +0.5        1.52 ± 11%  perf-profile.children.cycles-pp.free_pcppages_bulk
      3.50 ±  6%      +0.5        4.02 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.77 ±  7%      +0.5        1.29 ±  5%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      1.03 ±  7%      +0.8        1.81 ±  7%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.99 ±  9%      +0.8        1.83 ±  5%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      1.02 ±  9%      +0.9        1.87 ±  5%  perf-profile.children.cycles-pp.__mutex_lock
      4.60 ±  9%      +1.1        5.68 ±  3%  perf-profile.children.cycles-pp.do_tee
      4.68 ±  9%      +1.1        5.79 ±  3%  perf-profile.children.cycles-pp.__x64_sys_tee
      5.49 ±  9%      +1.2        6.70 ±  3%  perf-profile.children.cycles-pp.tee
      8.30 ±  5%      +1.2        9.53 ±  4%  perf-profile.children.cycles-pp.poll_idle
     44.37 ±  4%      +3.4       47.74 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
     43.09 ±  4%      +3.4       46.51 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
     43.07 ±  4%      +3.4       46.49 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
     49.48 ±  3%      +3.5       52.94 ±  3%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     49.48 ±  3%      +3.5       52.94 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
     49.42 ±  3%      +3.5       52.90 ±  3%  perf-profile.children.cycles-pp.do_idle
     42.60 ±  3%      +4.0       46.63        perf-profile.children.cycles-pp.start_secondary
     20.97 ±  3%      -4.0       16.96 ±  5%  perf-profile.self.cycles-pp.rep_movs_alternative
      3.20 ± 10%      -1.2        1.98 ±  7%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.75 ± 12%      -0.2        0.50 ± 14%  perf-profile.self.cycles-pp.get_page_from_freelist
      1.97 ±  6%      -0.2        1.77 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.60 ± 10%      -0.2        0.42 ±  8%  perf-profile.self.cycles-pp.__alloc_pages
      0.55 ±  5%      -0.1        0.49 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.12 ± 18%      -0.0        0.07 ± 21%  perf-profile.self.cycles-pp.__cond_resched
      0.11 ± 12%      +0.1        0.17 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.36 ± 10%      +0.1        0.46 ± 18%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.61 ± 13%      +0.3        0.87 ± 12%  perf-profile.self.cycles-pp.__free_one_page
      0.62 ±  4%      +0.3        0.90 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.34 ± 19%      +0.5        0.80 ±  9%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.75 ±  7%      +0.5        1.27 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.98 ±  9%      +0.8        1.83 ±  5%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      8.23 ±  5%      +1.2        9.44 ±  4%  perf-profile.self.cycles-pp.poll_idle



***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
build_kconfig/cg_count/compiler/cpufreq_governor/kconfig/nr_instances/nr_task/rootfs/runtime/target/tbox_group/testcase:
  allyesconfig/8/gcc-12/performance/x86_64-rhel-8.3/8/100%/debian-11.1-x86_64-20220510.cgz/300s/autoksyms_recursive/lkp-spr-2sp4/kbuild

commit: 
  90b41691b9 ("mm: add framework for PCP high auto-tuning")
  51a755c56d ("mm: tune PCP high automatically")

90b41691b9881376 51a755c56dc05a8b31ed28d24f2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  18226183 ± 22%     +39.4%   25416239 ± 18%  numa-meminfo.node0.MemUsed
      2593 ±  2%     -20.1%       2072 ±  4%  perf-c2c.HITM.local
  39641220           +24.9%   49492150        meminfo.Memused
  42616232           +23.9%   52807785        meminfo.max_used_kB
      1.91            +0.2        2.12        mpstat.cpu.all.irq%
     20.96            -5.3       15.65        mpstat.cpu.all.sys%
      2788            -2.6%       2716        turbostat.Bzy_MHz
     46.81            +2.5%      47.98        turbostat.RAMWatt
     48335           +10.3%      53328        vmstat.system.cs
    243545            +1.4%     246887        vmstat.system.in
    676.95            -4.3%     647.61        kbuild.buildtime_per_iteration
    683.28            -4.3%     653.96        kbuild.time.elapsed_time
    683.28            -4.3%     653.96        kbuild.time.elapsed_time.max
    874893           +12.4%     983574        kbuild.time.involuntary_context_switches
      2325            -1.1%       2298        kbuild.time.percent_of_cpu_this_job_got
      4038           -29.5%       2849        kbuild.time.system_time
     11853            +2.8%      12185        kbuild.time.user_time
    404788            -1.9%     397181        proc-vmstat.nr_active_anon
   2497825            +3.5%    2586257        proc-vmstat.nr_anon_pages
  12122127            -2.0%   11876339        proc-vmstat.nr_dirty_background_threshold
  24273893            -2.0%   23781716        proc-vmstat.nr_dirty_threshold
 1.219e+08            -2.0%  1.195e+08        proc-vmstat.nr_free_pages
   2567768            +3.2%    2650558        proc-vmstat.nr_inactive_anon
     99311            +6.7%     105976 ±  2%  proc-vmstat.nr_mapped
    141797            -4.4%     135589        proc-vmstat.nr_slab_unreclaimable
    404787            -1.9%     397181        proc-vmstat.nr_zone_active_anon
   2567768            +3.2%    2650558        proc-vmstat.nr_zone_inactive_anon
  15311625            -3.9%   14717625        proc-vmstat.unevictable_pgs_scanned
      2.76            +2.4%       2.82        perf-stat.i.MPKI
 1.002e+11            +3.3%  1.035e+11        perf-stat.i.branch-instructions
      2.20            +0.0        2.24        perf-stat.i.branch-miss-rate%
 2.322e+09            +5.3%  2.445e+09        perf-stat.i.branch-misses
 1.147e+09            +5.1%  1.206e+09        perf-stat.i.cache-misses
 2.928e+09            +5.5%  3.089e+09        perf-stat.i.cache-references
     48084           +10.4%      53070        perf-stat.i.context-switches
      1.11 ±  2%      -6.3%       1.04        perf-stat.i.cpi
 5.181e+11            -3.6%  4.996e+11        perf-stat.i.cpu-cycles
     10310            +4.1%      10735        perf-stat.i.cpu-migrations
      0.13            +0.0        0.13        perf-stat.i.dTLB-load-miss-rate%
  1.45e+08            +9.7%   1.59e+08        perf-stat.i.dTLB-load-misses
 1.247e+11            +3.5%  1.291e+11        perf-stat.i.dTLB-loads
  75094568            +4.6%   78514400        perf-stat.i.dTLB-store-misses
 5.555e+10            +4.0%  5.776e+10        perf-stat.i.dTLB-stores
 4.564e+11            +3.3%  4.716e+11        perf-stat.i.instructions
      0.98            +6.0%       1.04        perf-stat.i.ipc
    195.54 ±  2%      +9.0%     213.12 ±  3%  perf-stat.i.major-faults
      2.31            -3.6%       2.23        perf-stat.i.metric.GHz
    602.63            +4.8%     631.56        perf-stat.i.metric.K/sec
      1266            +3.5%       1310        perf-stat.i.metric.M/sec
   5839785            +4.4%    6093830        perf-stat.i.minor-faults
  31985083            +5.0%   33576960        perf-stat.i.node-load-misses
 2.898e+08            +4.9%   3.04e+08        perf-stat.i.node-loads
   5839980            +4.4%    6094043        perf-stat.i.page-faults
      2.51            +1.7%       2.56        perf-stat.overall.MPKI
      2.32            +0.0        2.36        perf-stat.overall.branch-miss-rate%
      1.14            -6.7%       1.06        perf-stat.overall.cpi
    451.99            -8.3%     414.64        perf-stat.overall.cycles-between-cache-misses
      0.12            +0.0        0.12        perf-stat.overall.dTLB-load-miss-rate%
      0.88            +7.2%       0.94        perf-stat.overall.ipc
 1.015e+11            +3.3%  1.048e+11        perf-stat.ps.branch-instructions
 2.353e+09            +5.3%  2.479e+09        perf-stat.ps.branch-misses
 1.162e+09            +5.1%  1.221e+09        perf-stat.ps.cache-misses
 2.963e+09            +5.6%  3.127e+09        perf-stat.ps.cache-references
     48354           +10.3%      53346        perf-stat.ps.context-switches
 5.251e+11            -3.6%  5.065e+11        perf-stat.ps.cpu-cycles
     10378            +4.1%      10799        perf-stat.ps.cpu-migrations
 1.471e+08            +9.8%  1.616e+08        perf-stat.ps.dTLB-load-misses
 1.263e+11            +3.5%  1.307e+11        perf-stat.ps.dTLB-loads
  76132602            +4.6%   79625307        perf-stat.ps.dTLB-store-misses
 5.625e+10            +4.0%  5.852e+10        perf-stat.ps.dTLB-stores
  4.62e+11            +3.4%  4.776e+11        perf-stat.ps.instructions
    196.30 ±  2%      +8.8%     213.49 ±  3%  perf-stat.ps.major-faults
   5916974            +4.4%    6176104        perf-stat.ps.minor-faults
  32263415            +5.0%   33875660        perf-stat.ps.node-load-misses
 2.942e+08            +5.0%  3.087e+08        perf-stat.ps.node-loads
   5917171            +4.4%    6176318        perf-stat.ps.page-faults
      0.27 ± 76%     -91.6%       0.02 ± 68%  perf-sched.sch_delay.avg.ms.__cond_resched.dentry_kill.dput.step_into.open_last_lookups
      0.00 ±144%   +7400.0%       0.15 ±118%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.prepare_exec_creds.bprm_execve
      0.25 ± 39%     -68.8%       0.08 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.18 ±  6%     -13.9%       0.15 ±  3%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.05 ±  2%     -24.1%       0.04 ±  4%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ±  3%     -26.1%       0.09        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     11.20 ±170%     -95.2%       0.54 ±174%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.93 ± 74%    +155.1%       2.37 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      2.06 ± 20%     -28.7%       1.47 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_expand.mmap_region.do_mmap
      0.18 ±202%    +411.3%       0.91 ± 83%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±144%   +7400.0%       0.15 ±118%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.prepare_exec_creds.bprm_execve
      2.25 ± 36%     -71.7%       0.64 ± 51%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      2.07 ± 32%     -72.8%       0.56 ± 72%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      3.45 ± 87%     -63.5%       1.26 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      3.40 ± 12%     -29.2%       2.40 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     76.10 ± 74%    +248.4%     265.15 ± 71%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.20 ± 38%     +60.1%       3.52 ±  8%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
     29.64 ±  2%     -10.7%      26.46 ±  3%  perf-sched.total_wait_and_delay.average.ms
    214402 ±  3%     +11.9%     239860 ±  3%  perf-sched.total_wait_and_delay.count.ms
     29.39 ±  2%     -10.8%      26.22 ±  3%  perf-sched.total_wait_time.average.ms
     26.27 ±  7%     -34.9%      17.09 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.76           -19.9%       3.81 ±  2%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.99 ± 20%     -59.6%       0.40 ± 22%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     71.65 ±  2%     -20.5%      56.99 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1639 ±  3%     +52.9%       2506 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
    119.83 ±  5%     +27.8%     153.17 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     37.83 ± 10%     +29.5%      49.00 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      6515 ±  3%     +14.4%       7456 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      7256 ±  3%     -11.4%       6428 ±  3%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     16839 ±  3%     +25.4%      21112 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1755 ±  4%     +22.2%       2145 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      9486 ±  4%     +19.0%      11291 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     27801 ±  3%     +27.9%      35569 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2016 ± 56%     -76.5%     473.24 ± 71%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     14.87 ± 97%    +294.2%      58.60 ± 88%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.26 ± 53%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__do_huge_pmd_anonymous_page.__handle_mm_fault
     22.99 ± 44%     -92.2%       1.80 ±115%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
     22.76 ±  7%     -24.3%      17.23 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__do_sys_clone
      0.45 ± 29%     -43.1%       0.25 ± 31%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.vfs_statx.__do_sys_newlstat
      0.23 ±110%    +339.2%       1.00 ± 62%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      0.22 ± 19%     -49.4%       0.11 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      0.50 ±140%   +1233.0%       6.61 ± 67%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
     26.24 ±  7%     -35.0%      17.07 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 35%     -49.5%       0.03 ± 79%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.shift_arg_pages.setup_arg_pages
      0.19 ± 10%     -26.4%       0.14 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.12 ± 92%   +1899.0%       2.42 ±103%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.58           -20.2%       3.66 ±  2%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.94 ± 21%     -62.3%       0.35 ± 24%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.03 ±  8%     +31.0%       0.04 ±  8%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
     71.60 ±  2%     -20.5%      56.95 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.68 ± 79%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__do_huge_pmd_anonymous_page.__handle_mm_fault
    782.28 ± 32%     -99.1%       7.08 ±137%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.05 ±186%   +1480.8%       0.76 ±103%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.82 ± 56%    +158.9%       2.12 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.do_vmi_align_munmap
      4.95 ± 24%   +6720.4%     337.33 ±139%  perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      2.14 ±150%    +616.4%      15.36 ± 89%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      1.35 ±140%   +1757.2%      25.08 ±101%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      6.74 ± 46%     -65.3%       2.34 ± 74%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      9.24 ± 62%     -65.1%       3.23 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.constprop
      5.84 ± 24%     -42.7%       3.34 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.21 ± 87%   +2209.8%       4.77 ±123%  perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2016 ± 56%     -76.5%     473.17 ± 71%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.04 ± 14%     +84.3%       0.08 ± 28%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.90           -15.6%       0.76 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
    375643 ± 11%     -33.9%     248453 ± 12%  sched_debug.cfs_rq:/.left_vruntime.avg
   9540928           -32.0%    6487858 ±  4%  sched_debug.cfs_rq:/.left_vruntime.max
   1799327 ±  5%     -32.5%    1213880 ±  8%  sched_debug.cfs_rq:/.left_vruntime.stddev
     49654 ± 17%     -25.4%      37018 ±  7%  sched_debug.cfs_rq:/.load.avg
    124994 ±  7%     -17.0%     103789 ± 12%  sched_debug.cfs_rq:/.load.stddev
      0.88           -15.7%       0.74 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
      2.29 ±  4%     -12.1%       2.01 ±  3%  sched_debug.cfs_rq:/.nr_running.max
    375643 ± 11%     -33.9%     248453 ± 12%  sched_debug.cfs_rq:/.right_vruntime.avg
   9540931           -32.0%    6487859 ±  4%  sched_debug.cfs_rq:/.right_vruntime.max
   1799327 ±  5%     -32.5%    1213880 ±  8%  sched_debug.cfs_rq:/.right_vruntime.stddev
    921.84           -15.3%     781.22 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      2328 ±  3%      -9.2%       2113 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
      1.31 ± 37%     -49.3%       0.67 ± 64%  sched_debug.cfs_rq:/.spread.stddev
    891.19           -15.0%     757.76 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      2194 ±  4%      -9.0%       1998 ±  4%  sched_debug.cfs_rq:/.util_avg.max
     43.85 ±  3%     -44.6%      24.30 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    893.15 ±  2%     -19.1%     722.42 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.max
    131.87 ±  2%     -24.6%      99.39 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
     38891           -15.0%      33045 ±  5%  sched_debug.cfs_rq:/kbuild.1.avg_vruntime.avg
     51222           -17.4%      42323 ±  5%  sched_debug.cfs_rq:/kbuild.1.avg_vruntime.max
     29198 ±  4%     -16.1%      24490 ±  7%  sched_debug.cfs_rq:/kbuild.1.avg_vruntime.min
    274.96 ± 24%     -43.2%     156.19 ± 20%  sched_debug.cfs_rq:/kbuild.1.left_vruntime.avg
     24717 ± 26%     -37.0%      15567 ± 12%  sched_debug.cfs_rq:/kbuild.1.left_vruntime.max
      2430 ± 25%     -39.9%       1459 ± 14%  sched_debug.cfs_rq:/kbuild.1.left_vruntime.stddev
    276.40 ±  3%     -13.8%     238.39 ±  9%  sched_debug.cfs_rq:/kbuild.1.load_avg.avg
      1798 ±  5%     -17.0%       1492 ±  4%  sched_debug.cfs_rq:/kbuild.1.load_avg.max
    366.69 ±  3%     -12.9%     319.32 ±  5%  sched_debug.cfs_rq:/kbuild.1.load_avg.stddev
     38891           -15.0%      33045 ±  5%  sched_debug.cfs_rq:/kbuild.1.min_vruntime.avg
     51222           -17.4%      42323 ±  5%  sched_debug.cfs_rq:/kbuild.1.min_vruntime.max
     29198 ±  4%     -16.1%      24490 ±  7%  sched_debug.cfs_rq:/kbuild.1.min_vruntime.min
    274.96 ± 24%     -43.2%     156.19 ± 20%  sched_debug.cfs_rq:/kbuild.1.right_vruntime.avg
     24717 ± 26%     -37.0%      15567 ± 12%  sched_debug.cfs_rq:/kbuild.1.right_vruntime.max
      2430 ± 25%     -39.9%       1459 ± 14%  sched_debug.cfs_rq:/kbuild.1.right_vruntime.stddev
      1027 ±  3%     -13.1%     893.11 ±  4%  sched_debug.cfs_rq:/kbuild.1.runnable_avg.max
    291.95           -10.6%     261.03 ±  5%  sched_debug.cfs_rq:/kbuild.1.runnable_avg.stddev
    131.60 ±  2%     +37.5%     180.90 ± 10%  sched_debug.cfs_rq:/kbuild.1.se->avg.load_avg.max
      9.34 ±  3%    +120.1%      20.55 ± 73%  sched_debug.cfs_rq:/kbuild.1.se->avg.load_avg.stddev
      1024 ±  3%     -12.9%     892.58 ±  4%  sched_debug.cfs_rq:/kbuild.1.se->avg.runnable_avg.max
    291.82           -10.6%     260.92 ±  5%  sched_debug.cfs_rq:/kbuild.1.se->avg.runnable_avg.stddev
    287.81           -10.5%     257.48 ±  5%  sched_debug.cfs_rq:/kbuild.1.se->avg.util_avg.stddev
    100596           +42.7%     143547 ± 14%  sched_debug.cfs_rq:/kbuild.1.se->load.weight.avg
    144300           +58.7%     229007 ±  2%  sched_debug.cfs_rq:/kbuild.1.se->load.weight.max
     12701          +249.6%      44403 ± 38%  sched_debug.cfs_rq:/kbuild.1.se->load.weight.stddev
     39174           -15.1%      33278 ±  5%  sched_debug.cfs_rq:/kbuild.1.se->sum_exec_runtime.avg
     51528           -17.4%      42578 ±  5%  sched_debug.cfs_rq:/kbuild.1.se->sum_exec_runtime.max
     29463 ±  4%     -16.2%      24694 ±  7%  sched_debug.cfs_rq:/kbuild.1.se->sum_exec_runtime.min
  10009988           -13.6%    8649524 ±  5%  sched_debug.cfs_rq:/kbuild.1.se->vruntime.min
     33192           -18.0%      27206 ±  2%  sched_debug.cfs_rq:/kbuild.1.tg_load_avg.avg
     39349 ±  2%     -17.3%      32549 ±  3%  sched_debug.cfs_rq:/kbuild.1.tg_load_avg.max
     28480           -18.5%      23202 ±  3%  sched_debug.cfs_rq:/kbuild.1.tg_load_avg.min
    276.76 ±  3%     -13.7%     238.72 ±  9%  sched_debug.cfs_rq:/kbuild.1.tg_load_avg_contrib.avg
      1795 ±  6%     -16.4%       1501 ±  3%  sched_debug.cfs_rq:/kbuild.1.tg_load_avg_contrib.max
    367.31 ±  3%     -12.8%     320.20 ±  5%  sched_debug.cfs_rq:/kbuild.1.tg_load_avg_contrib.stddev
    998.35 ±  2%     -12.5%     873.63 ±  4%  sched_debug.cfs_rq:/kbuild.1.util_avg.max
    287.86           -10.5%     257.50 ±  5%  sched_debug.cfs_rq:/kbuild.1.util_avg.stddev
     38707           -14.2%      33217 ±  5%  sched_debug.cfs_rq:/kbuild.2.avg_vruntime.avg
     50702 ±  3%     -13.6%      43798 ±  4%  sched_debug.cfs_rq:/kbuild.2.avg_vruntime.max
     28497 ±  4%     -15.1%      24193 ±  5%  sched_debug.cfs_rq:/kbuild.2.avg_vruntime.min
      0.22 ±  2%     -20.0%       0.18 ± 18%  sched_debug.cfs_rq:/kbuild.2.h_nr_running.avg
    229840 ±  2%     -20.0%     183766 ± 18%  sched_debug.cfs_rq:/kbuild.2.load.avg
    264.22 ±  2%     -19.3%     213.09 ± 17%  sched_debug.cfs_rq:/kbuild.2.load_avg.avg
     38707           -14.2%      33217 ±  5%  sched_debug.cfs_rq:/kbuild.2.min_vruntime.avg
     50702 ±  3%     -13.6%      43798 ±  4%  sched_debug.cfs_rq:/kbuild.2.min_vruntime.max
     28497 ±  4%     -15.1%      24193 ±  5%  sched_debug.cfs_rq:/kbuild.2.min_vruntime.min
      0.22 ±  2%     -20.0%       0.18 ± 18%  sched_debug.cfs_rq:/kbuild.2.nr_running.avg
    226.91           -19.6%     182.40 ± 18%  sched_debug.cfs_rq:/kbuild.2.runnable_avg.avg
      1026 ±  3%     -10.8%     915.64 ±  3%  sched_debug.cfs_rq:/kbuild.2.runnable_avg.max
    131.24 ±  3%     +41.7%     186.02 ± 13%  sched_debug.cfs_rq:/kbuild.2.se->avg.load_avg.max
      9.37 ±  4%    +271.6%      34.80 ± 58%  sched_debug.cfs_rq:/kbuild.2.se->avg.load_avg.stddev
    226.86           -19.6%     182.33 ± 18%  sched_debug.cfs_rq:/kbuild.2.se->avg.runnable_avg.avg
      1026 ±  3%     -10.9%     915.40 ±  3%  sched_debug.cfs_rq:/kbuild.2.se->avg.runnable_avg.max
    222.65           -19.7%     178.90 ± 18%  sched_debug.cfs_rq:/kbuild.2.se->avg.util_avg.avg
    996.03 ±  2%     -10.2%     894.69 ±  4%  sched_debug.cfs_rq:/kbuild.2.se->avg.util_avg.max
    100604           +36.9%     137720 ± 16%  sched_debug.cfs_rq:/kbuild.2.se->load.weight.avg
    143462 ±  2%     +58.7%     227639 ±  4%  sched_debug.cfs_rq:/kbuild.2.se->load.weight.max
     12720          +287.4%      49284 ± 40%  sched_debug.cfs_rq:/kbuild.2.se->load.weight.stddev
     38985           -14.2%      33449 ±  5%  sched_debug.cfs_rq:/kbuild.2.se->sum_exec_runtime.avg
     51001 ±  3%     -13.6%      44050 ±  4%  sched_debug.cfs_rq:/kbuild.2.se->sum_exec_runtime.max
     28735 ±  4%     -15.1%      24404 ±  5%  sched_debug.cfs_rq:/kbuild.2.se->sum_exec_runtime.min
   9950458           -13.4%    8615908 ±  5%  sched_debug.cfs_rq:/kbuild.2.se->vruntime.min
     32454           -16.3%      27158 ±  6%  sched_debug.cfs_rq:/kbuild.2.tg_load_avg.avg
     38866 ±  3%     -16.3%      32532 ±  7%  sched_debug.cfs_rq:/kbuild.2.tg_load_avg.max
     27838 ±  2%     -16.0%      23374 ±  5%  sched_debug.cfs_rq:/kbuild.2.tg_load_avg.min
    264.60 ±  2%     -19.3%     213.48 ± 17%  sched_debug.cfs_rq:/kbuild.2.tg_load_avg_contrib.avg
    222.77           -19.6%     179.03 ± 18%  sched_debug.cfs_rq:/kbuild.2.util_avg.avg
    995.93 ±  2%     -10.2%     894.64 ±  4%  sched_debug.cfs_rq:/kbuild.2.util_avg.max
     38626           -14.6%      32994 ±  4%  sched_debug.cfs_rq:/kbuild.3.avg_vruntime.avg
     28760           -15.8%      24224 ±  3%  sched_debug.cfs_rq:/kbuild.3.avg_vruntime.min
      0.22           -15.1%       0.19 ±  9%  sched_debug.cfs_rq:/kbuild.3.h_nr_running.avg
      1.44 ± 15%     -21.7%       1.13 ± 10%  sched_debug.cfs_rq:/kbuild.3.h_nr_running.max
    306.39 ± 35%     -45.3%     167.74 ± 25%  sched_debug.cfs_rq:/kbuild.3.left_vruntime.avg
     27052 ± 15%     -44.1%      15121 ± 28%  sched_debug.cfs_rq:/kbuild.3.left_vruntime.max
      2654 ± 21%     -43.8%       1491 ± 26%  sched_debug.cfs_rq:/kbuild.3.left_vruntime.stddev
    232518           -15.1%     197389 ±  9%  sched_debug.cfs_rq:/kbuild.3.load.avg
   1514609 ± 15%     -21.7%    1186267 ± 10%  sched_debug.cfs_rq:/kbuild.3.load.max
    268.77           -14.7%     229.14 ±  9%  sched_debug.cfs_rq:/kbuild.3.load_avg.avg
     38626           -14.6%      32994 ±  4%  sched_debug.cfs_rq:/kbuild.3.min_vruntime.avg
     28760           -15.8%      24224 ±  3%  sched_debug.cfs_rq:/kbuild.3.min_vruntime.min
      0.22           -15.1%       0.19 ±  9%  sched_debug.cfs_rq:/kbuild.3.nr_running.avg
      1.44 ± 15%     -21.7%       1.13 ± 10%  sched_debug.cfs_rq:/kbuild.3.nr_running.max
    306.39 ± 35%     -45.3%     167.74 ± 25%  sched_debug.cfs_rq:/kbuild.3.right_vruntime.avg
     27052 ± 15%     -44.1%      15121 ± 28%  sched_debug.cfs_rq:/kbuild.3.right_vruntime.max
      2654 ± 21%     -43.8%       1491 ± 26%  sched_debug.cfs_rq:/kbuild.3.right_vruntime.stddev
    229.26           -14.7%     195.60 ±  9%  sched_debug.cfs_rq:/kbuild.3.runnable_avg.avg
      1027 ±  3%     -11.6%     908.27 ±  5%  sched_debug.cfs_rq:/kbuild.3.runnable_avg.max
    133.36 ±  3%     +50.7%     201.01 ±  7%  sched_debug.cfs_rq:/kbuild.3.se->avg.load_avg.max
      9.47 ±  3%    +225.6%      30.84 ± 69%  sched_debug.cfs_rq:/kbuild.3.se->avg.load_avg.stddev
    229.19           -14.7%     195.54 ±  9%  sched_debug.cfs_rq:/kbuild.3.se->avg.runnable_avg.avg
      1026 ±  3%     -11.5%     908.26 ±  5%  sched_debug.cfs_rq:/kbuild.3.se->avg.runnable_avg.max
    224.33           -14.5%     191.80 ±  9%  sched_debug.cfs_rq:/kbuild.3.se->avg.util_avg.avg
    378657           -12.0%     333135 ±  5%  sched_debug.cfs_rq:/kbuild.3.se->exec_start.min
    100743           +41.5%     142595 ± 12%  sched_debug.cfs_rq:/kbuild.3.se->load.weight.avg
    147367           +54.2%     227311 ±  3%  sched_debug.cfs_rq:/kbuild.3.se->load.weight.max
     12961          +240.4%      44122 ± 43%  sched_debug.cfs_rq:/kbuild.3.se->load.weight.stddev
     38902           -14.6%      33226 ±  4%  sched_debug.cfs_rq:/kbuild.3.se->sum_exec_runtime.avg
     49775           -11.9%      43833 ±  7%  sched_debug.cfs_rq:/kbuild.3.se->sum_exec_runtime.max
     29015           -15.8%      24434 ±  2%  sched_debug.cfs_rq:/kbuild.3.se->sum_exec_runtime.min
   9895916           -13.1%    8595093 ±  4%  sched_debug.cfs_rq:/kbuild.3.se->vruntime.min
     32797 ±  2%     -16.2%      27495 ±  4%  sched_debug.cfs_rq:/kbuild.3.tg_load_avg.avg
     39086 ±  3%     -16.3%      32699 ±  5%  sched_debug.cfs_rq:/kbuild.3.tg_load_avg.max
     27797           -15.0%      23617 ±  3%  sched_debug.cfs_rq:/kbuild.3.tg_load_avg.min
      2410 ±  9%     -21.6%       1890 ± 10%  sched_debug.cfs_rq:/kbuild.3.tg_load_avg.stddev
    269.18           -14.8%     229.45 ±  9%  sched_debug.cfs_rq:/kbuild.3.tg_load_avg_contrib.avg
    224.45           -14.5%     191.88 ±  9%  sched_debug.cfs_rq:/kbuild.3.util_avg.avg
     38775           -14.6%      33120 ±  5%  sched_debug.cfs_rq:/kbuild.4.avg_vruntime.avg
     49378 ±  3%     -12.1%      43404 ±  6%  sched_debug.cfs_rq:/kbuild.4.avg_vruntime.max
     29502 ±  2%     -16.7%      24567 ±  6%  sched_debug.cfs_rq:/kbuild.4.avg_vruntime.min
    269.24           -13.4%     233.24 ±  8%  sched_debug.cfs_rq:/kbuild.4.load_avg.avg
      1835 ±  4%     -15.5%       1551 ± 11%  sched_debug.cfs_rq:/kbuild.4.load_avg.max
    363.47           -13.4%     314.83 ±  8%  sched_debug.cfs_rq:/kbuild.4.load_avg.stddev
     38775           -14.6%      33120 ±  5%  sched_debug.cfs_rq:/kbuild.4.min_vruntime.avg
     49378 ±  3%     -12.1%      43404 ±  6%  sched_debug.cfs_rq:/kbuild.4.min_vruntime.max
     29502 ±  2%     -16.7%      24567 ±  6%  sched_debug.cfs_rq:/kbuild.4.min_vruntime.min
      1049 ±  5%     -12.7%     916.36 ±  6%  sched_debug.cfs_rq:/kbuild.4.runnable_avg.max
    136.18 ±  2%     +27.9%     174.11 ± 14%  sched_debug.cfs_rq:/kbuild.4.se->avg.load_avg.max
      9.58          +150.8%      24.03 ± 64%  sched_debug.cfs_rq:/kbuild.4.se->avg.load_avg.stddev
      1049 ±  5%     -12.7%     916.20 ±  6%  sched_debug.cfs_rq:/kbuild.4.se->avg.runnable_avg.max
      1016 ±  4%     -12.2%     892.17 ±  6%  sched_debug.cfs_rq:/kbuild.4.se->avg.util_avg.max
    100702           +37.7%     138703 ± 12%  sched_debug.cfs_rq:/kbuild.4.se->load.weight.avg
    145050 ±  2%     +59.2%     230990 ±  7%  sched_debug.cfs_rq:/kbuild.4.se->load.weight.max
     12826          +275.4%      48146 ± 42%  sched_debug.cfs_rq:/kbuild.4.se->load.weight.stddev
     39057           -14.6%      33353 ±  5%  sched_debug.cfs_rq:/kbuild.4.se->sum_exec_runtime.avg
     49676 ±  3%     -12.1%      43661 ±  6%  sched_debug.cfs_rq:/kbuild.4.se->sum_exec_runtime.max
     29761 ±  2%     -16.7%      24785 ±  6%  sched_debug.cfs_rq:/kbuild.4.se->sum_exec_runtime.min
   9955167           -12.7%    8686330 ±  5%  sched_debug.cfs_rq:/kbuild.4.se->vruntime.min
     32625           -17.5%      26931 ±  4%  sched_debug.cfs_rq:/kbuild.4.tg_load_avg.avg
     38916           -17.1%      32268 ±  5%  sched_debug.cfs_rq:/kbuild.4.tg_load_avg.max
     27950           -17.3%      23122 ±  4%  sched_debug.cfs_rq:/kbuild.4.tg_load_avg.min
    269.60           -13.4%     233.56 ±  8%  sched_debug.cfs_rq:/kbuild.4.tg_load_avg_contrib.avg
      1841 ±  4%     -15.4%       1557 ± 11%  sched_debug.cfs_rq:/kbuild.4.tg_load_avg_contrib.max
    364.34           -13.4%     315.66 ±  8%  sched_debug.cfs_rq:/kbuild.4.tg_load_avg_contrib.stddev
      1016 ±  4%     -12.2%     892.06 ±  6%  sched_debug.cfs_rq:/kbuild.4.util_avg.max
     38271           -14.3%      32807 ±  2%  sched_debug.cfs_rq:/kbuild.5.avg_vruntime.avg
     51259 ±  2%     -15.6%      43283 ±  3%  sched_debug.cfs_rq:/kbuild.5.avg_vruntime.max
     28805 ±  3%     -17.1%      23887 ±  2%  sched_debug.cfs_rq:/kbuild.5.avg_vruntime.min
      4100 ±  7%     -14.1%       3523 ±  8%  sched_debug.cfs_rq:/kbuild.5.avg_vruntime.stddev
      0.32           -15.5%       0.27 ±  5%  sched_debug.cfs_rq:/kbuild.5.h_nr_running.stddev
    321.60 ± 21%     -43.5%     181.63 ± 35%  sched_debug.cfs_rq:/kbuild.5.left_vruntime.avg
     27331 ± 14%     -36.0%      17480 ± 29%  sched_debug.cfs_rq:/kbuild.5.left_vruntime.max
      2746 ± 16%     -39.3%       1666 ± 30%  sched_debug.cfs_rq:/kbuild.5.left_vruntime.stddev
    333897           -15.5%     282023 ±  5%  sched_debug.cfs_rq:/kbuild.5.load.stddev
      1840 ±  4%     -16.1%       1544 ±  9%  sched_debug.cfs_rq:/kbuild.5.load_avg.max
    367.92           -15.5%     310.78 ±  6%  sched_debug.cfs_rq:/kbuild.5.load_avg.stddev
     38271           -14.3%      32807 ±  2%  sched_debug.cfs_rq:/kbuild.5.min_vruntime.avg
     51259 ±  2%     -15.6%      43283 ±  3%  sched_debug.cfs_rq:/kbuild.5.min_vruntime.max
     28805 ±  3%     -17.1%      23887 ±  2%  sched_debug.cfs_rq:/kbuild.5.min_vruntime.min
      4100 ±  7%     -14.1%       3523 ±  8%  sched_debug.cfs_rq:/kbuild.5.min_vruntime.stddev
      0.32           -15.5%       0.27 ±  5%  sched_debug.cfs_rq:/kbuild.5.nr_running.stddev
    321.60 ± 21%     -43.5%     181.63 ± 35%  sched_debug.cfs_rq:/kbuild.5.right_vruntime.avg
     27331 ± 14%     -36.0%      17480 ± 29%  sched_debug.cfs_rq:/kbuild.5.right_vruntime.max
      2746 ± 16%     -39.3%       1666 ± 30%  sched_debug.cfs_rq:/kbuild.5.right_vruntime.stddev
      1044 ±  3%     -14.2%     896.40 ±  6%  sched_debug.cfs_rq:/kbuild.5.runnable_avg.max
    291.07           -13.4%     252.00 ±  5%  sched_debug.cfs_rq:/kbuild.5.runnable_avg.stddev
      1044 ±  3%     -14.2%     896.65 ±  6%  sched_debug.cfs_rq:/kbuild.5.se->avg.runnable_avg.max
    291.01           -13.4%     251.96 ±  5%  sched_debug.cfs_rq:/kbuild.5.se->avg.runnable_avg.stddev
      1014 ±  3%     -13.6%     877.29 ±  5%  sched_debug.cfs_rq:/kbuild.5.se->avg.util_avg.max
    286.73           -13.3%     248.58 ±  5%  sched_debug.cfs_rq:/kbuild.5.se->avg.util_avg.stddev
    100632           +48.8%     149721 ±  8%  sched_debug.cfs_rq:/kbuild.5.se->load.weight.avg
    144929 ±  3%     +55.1%     224809 ±  6%  sched_debug.cfs_rq:/kbuild.5.se->load.weight.max
     12786 ±  2%    +180.4%      35850 ± 12%  sched_debug.cfs_rq:/kbuild.5.se->load.weight.stddev
     38549           -14.3%      33038 ±  2%  sched_debug.cfs_rq:/kbuild.5.se->sum_exec_runtime.avg
     51555 ±  2%     -15.5%      43545 ±  4%  sched_debug.cfs_rq:/kbuild.5.se->sum_exec_runtime.max
     29059 ±  3%     -17.1%      24090 ±  2%  sched_debug.cfs_rq:/kbuild.5.se->sum_exec_runtime.min
      4110 ±  8%     -14.0%       3533 ±  8%  sched_debug.cfs_rq:/kbuild.5.se->sum_exec_runtime.stddev
    129940 ±  5%     -14.2%     111427 ± 10%  sched_debug.cfs_rq:/kbuild.5.se->vruntime.stddev
     32930           -16.6%      27451 ±  4%  sched_debug.cfs_rq:/kbuild.5.tg_load_avg.avg
     39220           -16.4%      32787 ±  4%  sched_debug.cfs_rq:/kbuild.5.tg_load_avg.max
     28063           -15.9%      23609 ±  4%  sched_debug.cfs_rq:/kbuild.5.tg_load_avg.min
      2400 ±  3%     -18.8%       1949 ±  8%  sched_debug.cfs_rq:/kbuild.5.tg_load_avg.stddev
      1845 ±  4%     -16.0%       1550 ±  9%  sched_debug.cfs_rq:/kbuild.5.tg_load_avg_contrib.max
    368.90           -15.5%     311.80 ±  6%  sched_debug.cfs_rq:/kbuild.5.tg_load_avg_contrib.stddev
      1014 ±  3%     -13.5%     877.27 ±  5%  sched_debug.cfs_rq:/kbuild.5.util_avg.max
    286.71           -13.3%     248.59 ±  5%  sched_debug.cfs_rq:/kbuild.5.util_avg.stddev
     38635           -13.6%      33375 ±  5%  sched_debug.cfs_rq:/kbuild.6.avg_vruntime.avg
     50281 ±  3%     -14.1%      43180 ±  5%  sched_debug.cfs_rq:/kbuild.6.avg_vruntime.max
     29527 ±  2%     -17.1%      24479 ±  4%  sched_debug.cfs_rq:/kbuild.6.avg_vruntime.min
      0.32           -15.7%       0.27 ±  5%  sched_debug.cfs_rq:/kbuild.6.h_nr_running.stddev
    245.34 ± 27%     -34.5%     160.58 ± 19%  sched_debug.cfs_rq:/kbuild.6.left_vruntime.avg
    333520           -15.7%     281233 ±  5%  sched_debug.cfs_rq:/kbuild.6.load.stddev
    362.59 ±  2%     -13.1%     315.04 ±  5%  sched_debug.cfs_rq:/kbuild.6.load_avg.stddev
     38635           -13.6%      33375 ±  5%  sched_debug.cfs_rq:/kbuild.6.min_vruntime.avg
     50281 ±  3%     -14.1%      43180 ±  5%  sched_debug.cfs_rq:/kbuild.6.min_vruntime.max
     29527 ±  2%     -17.1%      24479 ±  4%  sched_debug.cfs_rq:/kbuild.6.min_vruntime.min
      0.32           -15.7%       0.27 ±  5%  sched_debug.cfs_rq:/kbuild.6.nr_running.stddev
    245.34 ± 27%     -34.5%     160.58 ± 19%  sched_debug.cfs_rq:/kbuild.6.right_vruntime.avg
      1041 ±  5%     -12.0%     916.56 ±  5%  sched_debug.cfs_rq:/kbuild.6.runnable_avg.max
    293.32 ±  2%     -13.9%     252.60 ±  4%  sched_debug.cfs_rq:/kbuild.6.runnable_avg.stddev
    134.78 ±  5%     +39.3%     187.70 ±  7%  sched_debug.cfs_rq:/kbuild.6.se->avg.load_avg.max
      9.66 ±  4%     +46.9%      14.20 ±  5%  sched_debug.cfs_rq:/kbuild.6.se->avg.load_avg.stddev
      1041 ±  6%     -12.0%     916.60 ±  5%  sched_debug.cfs_rq:/kbuild.6.se->avg.runnable_avg.max
    293.23 ±  2%     -13.9%     252.53 ±  4%  sched_debug.cfs_rq:/kbuild.6.se->avg.runnable_avg.stddev
      1018 ±  5%     -12.1%     894.70 ±  5%  sched_debug.cfs_rq:/kbuild.6.se->avg.util_avg.max
    288.96           -13.7%     249.43 ±  4%  sched_debug.cfs_rq:/kbuild.6.se->avg.util_avg.stddev
    100518           +49.6%     150358 ±  7%  sched_debug.cfs_rq:/kbuild.6.se->load.weight.avg
    144121 ±  2%     +58.7%     228659 ±  4%  sched_debug.cfs_rq:/kbuild.6.se->load.weight.max
     12832          +180.4%      35984 ± 12%  sched_debug.cfs_rq:/kbuild.6.se->load.weight.stddev
     38915           -13.6%      33608 ±  5%  sched_debug.cfs_rq:/kbuild.6.se->sum_exec_runtime.avg
     50579 ±  3%     -14.1%      43434 ±  5%  sched_debug.cfs_rq:/kbuild.6.se->sum_exec_runtime.max
     29784 ±  2%     -17.1%      24691 ±  4%  sched_debug.cfs_rq:/kbuild.6.se->sum_exec_runtime.min
   9895144           -12.3%    8681704 ±  4%  sched_debug.cfs_rq:/kbuild.6.se->vruntime.min
     32347 ±  2%     -16.5%      27016 ±  6%  sched_debug.cfs_rq:/kbuild.6.tg_load_avg.avg
     38119 ±  2%     -15.2%      32306 ±  6%  sched_debug.cfs_rq:/kbuild.6.tg_load_avg.max
     27889 ±  2%     -15.7%      23505 ±  5%  sched_debug.cfs_rq:/kbuild.6.tg_load_avg.min
    363.42 ±  2%     -13.1%     315.84 ±  5%  sched_debug.cfs_rq:/kbuild.6.tg_load_avg_contrib.stddev
      1017 ±  5%     -12.1%     894.76 ±  5%  sched_debug.cfs_rq:/kbuild.6.util_avg.max
    288.97           -13.7%     249.42 ±  4%  sched_debug.cfs_rq:/kbuild.6.util_avg.stddev
     38466           -14.1%      33059 ±  5%  sched_debug.cfs_rq:/kbuild.7.avg_vruntime.avg
     50272 ±  2%     -14.5%      42973 ±  5%  sched_debug.cfs_rq:/kbuild.7.avg_vruntime.max
     28341 ±  3%     -15.2%      24046 ±  7%  sched_debug.cfs_rq:/kbuild.7.avg_vruntime.min
    270.14           -12.1%     237.53 ±  9%  sched_debug.cfs_rq:/kbuild.7.load_avg.avg
     38466           -14.1%      33059 ±  5%  sched_debug.cfs_rq:/kbuild.7.min_vruntime.avg
     50272 ±  2%     -14.5%      42973 ±  5%  sched_debug.cfs_rq:/kbuild.7.min_vruntime.max
     28341 ±  3%     -15.2%      24046 ±  7%  sched_debug.cfs_rq:/kbuild.7.min_vruntime.min
    230.10           -11.5%     203.68 ±  9%  sched_debug.cfs_rq:/kbuild.7.runnable_avg.avg
    132.11 ±  2%     +35.5%     178.95 ± 16%  sched_debug.cfs_rq:/kbuild.7.se->avg.load_avg.max
    230.03           -11.5%     203.67 ±  9%  sched_debug.cfs_rq:/kbuild.7.se->avg.runnable_avg.avg
    225.36           -11.2%     200.01 ±  9%  sched_debug.cfs_rq:/kbuild.7.se->avg.util_avg.avg
    100726           +43.4%     144485 ±  9%  sched_debug.cfs_rq:/kbuild.7.se->load.weight.avg
    143011           +59.2%     227628 ±  5%  sched_debug.cfs_rq:/kbuild.7.se->load.weight.max
     12777          +221.0%      41012 ± 29%  sched_debug.cfs_rq:/kbuild.7.se->load.weight.stddev
     38744           -14.1%      33297 ±  5%  sched_debug.cfs_rq:/kbuild.7.se->sum_exec_runtime.avg
     50572 ±  2%     -14.5%      43228 ±  5%  sched_debug.cfs_rq:/kbuild.7.se->sum_exec_runtime.max
     28601 ±  3%     -15.2%      24262 ±  7%  sched_debug.cfs_rq:/kbuild.7.se->sum_exec_runtime.min
   9936693           -13.7%    8573976 ±  4%  sched_debug.cfs_rq:/kbuild.7.se->vruntime.min
     32776           -15.9%      27550 ±  4%  sched_debug.cfs_rq:/kbuild.7.tg_load_avg.avg
     39035           -15.7%      32904 ±  4%  sched_debug.cfs_rq:/kbuild.7.tg_load_avg.max
     27953           -14.9%      23783 ±  4%  sched_debug.cfs_rq:/kbuild.7.tg_load_avg.min
      2381 ±  8%     -16.5%       1988 ±  7%  sched_debug.cfs_rq:/kbuild.7.tg_load_avg.stddev
    270.66           -12.1%     237.88 ±  8%  sched_debug.cfs_rq:/kbuild.7.tg_load_avg_contrib.avg
    225.49           -11.3%     200.08 ±  9%  sched_debug.cfs_rq:/kbuild.7.util_avg.avg
     38298           -13.1%      33289 ±  5%  sched_debug.cfs_rq:/kbuild.8.avg_vruntime.avg
     49463 ±  3%     -12.8%      43112 ±  7%  sched_debug.cfs_rq:/kbuild.8.avg_vruntime.max
     28357 ±  5%     -13.5%      24524 ±  5%  sched_debug.cfs_rq:/kbuild.8.avg_vruntime.min
      0.31 ±  2%     -11.2%       0.28 ±  6%  sched_debug.cfs_rq:/kbuild.8.h_nr_running.stddev
    327390 ±  2%     -11.2%     290633 ±  6%  sched_debug.cfs_rq:/kbuild.8.load.stddev
    357.57           -12.2%     314.04 ±  5%  sched_debug.cfs_rq:/kbuild.8.load_avg.stddev
     38298           -13.1%      33289 ±  5%  sched_debug.cfs_rq:/kbuild.8.min_vruntime.avg
     49463 ±  3%     -12.8%      43112 ±  7%  sched_debug.cfs_rq:/kbuild.8.min_vruntime.max
     28357 ±  5%     -13.5%      24524 ±  5%  sched_debug.cfs_rq:/kbuild.8.min_vruntime.min
      0.31 ±  2%     -11.2%       0.28 ±  6%  sched_debug.cfs_rq:/kbuild.8.nr_running.stddev
      1016 ±  2%     -11.9%     896.35 ±  3%  sched_debug.cfs_rq:/kbuild.8.runnable_avg.max
    290.98           -13.2%     252.66 ±  4%  sched_debug.cfs_rq:/kbuild.8.runnable_avg.stddev
    129.58 ±  2%     +38.0%     178.78 ± 11%  sched_debug.cfs_rq:/kbuild.8.se->avg.load_avg.max
      9.28 ±  2%     +45.6%      13.51 ± 11%  sched_debug.cfs_rq:/kbuild.8.se->avg.load_avg.stddev
      1017 ±  2%     -11.9%     896.16 ±  4%  sched_debug.cfs_rq:/kbuild.8.se->avg.runnable_avg.max
    290.90           -13.2%     252.61 ±  4%  sched_debug.cfs_rq:/kbuild.8.se->avg.runnable_avg.stddev
    988.35 ±  2%     -10.7%     882.87 ±  3%  sched_debug.cfs_rq:/kbuild.8.se->avg.util_avg.max
    379672           -12.2%     333491 ±  5%  sched_debug.cfs_rq:/kbuild.8.se->exec_start.min
    100737           +50.1%     151255 ±  5%  sched_debug.cfs_rq:/kbuild.8.se->load.weight.avg
    143775           +59.0%     228659 ±  5%  sched_debug.cfs_rq:/kbuild.8.se->load.weight.max
     12761          +193.0%      37394 ±  7%  sched_debug.cfs_rq:/kbuild.8.se->load.weight.stddev
     38578           -13.1%      33522 ±  5%  sched_debug.cfs_rq:/kbuild.8.se->sum_exec_runtime.avg
     49761 ±  3%     -12.9%      43366 ±  7%  sched_debug.cfs_rq:/kbuild.8.se->sum_exec_runtime.max
     28608 ±  5%     -13.5%      24732 ±  5%  sched_debug.cfs_rq:/kbuild.8.se->sum_exec_runtime.min
   9977772           -12.9%    8687669 ±  4%  sched_debug.cfs_rq:/kbuild.8.se->vruntime.min
     32647 ±  2%     -16.5%      27252 ±  4%  sched_debug.cfs_rq:/kbuild.8.tg_load_avg.avg
     38982 ±  4%     -16.0%      32728 ±  4%  sched_debug.cfs_rq:/kbuild.8.tg_load_avg.max
     27832 ±  2%     -16.9%      23127 ±  5%  sched_debug.cfs_rq:/kbuild.8.tg_load_avg.min
      1708 ±  6%      -7.2%       1584 ±  5%  sched_debug.cfs_rq:/kbuild.8.tg_load_avg_contrib.max
    358.49           -12.2%     314.80 ±  5%  sched_debug.cfs_rq:/kbuild.8.tg_load_avg_contrib.stddev
    988.51 ±  2%     -10.7%     882.70 ±  3%  sched_debug.cfs_rq:/kbuild.8.util_avg.max
     27.17           -14.2%      23.30 ±  3%  sched_debug.cpu.clock.stddev
      0.89           -15.0%       0.75 ±  4%  sched_debug.cpu.nr_running.avg
     77987            +6.0%      82656 ±  4%  sched_debug.cpu.nr_switches.avg
      0.04 ± 19%     -79.6%       0.01 ± 63%  sched_debug.cpu.nr_uninterruptible.avg
     13.07 ±  8%      -3.5        9.62 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     13.06 ±  8%      -3.5        9.61 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.88 ± 14%      -2.9        0.95        perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.82 ± 14%      -2.9        0.90        perf-profile.calltrace.cycles-pp.__folio_alloc.vma_alloc_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      3.81 ± 14%      -2.9        0.90        perf-profile.calltrace.cycles-pp.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page.__handle_mm_fault
      3.71 ± 14%      -2.9        0.81        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
      8.47 ±  5%      -2.8        5.69        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.93 ±  4%      -2.7        3.19 ±  3%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.92 ±  4%      -2.7        3.18 ±  3%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      6.26 ±  3%      -2.7        3.52 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.26 ±  3%      -2.7        3.52 ±  3%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.26 ±  3%      -2.7        3.52 ±  3%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.92 ±  4%      -2.7        3.18 ±  3%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      6.29 ±  5%      -2.4        3.85        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      2.69 ± 13%      -2.3        0.34 ± 70%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      2.70 ± 13%      -2.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.70 ± 13%      -2.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      2.69 ± 13%      -2.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.69 ± 13%      -2.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.70 ± 13%      -2.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.__munmap
      2.69 ± 13%      -2.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.68 ±  2%      -2.0        4.66        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      7.10 ±  2%      -2.0        5.13        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      7.12 ±  2%      -2.0        5.16        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      7.68 ±  2%      -1.9        5.78        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.88 ± 10%      -1.4        0.43 ± 44%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      2.01 ±  9%      -1.4        0.63 ±  4%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.99 ±  9%      -1.4        0.62 ±  4%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      3.13 ±  4%      -1.3        1.84        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      3.18 ±  4%      -1.3        1.88        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      3.17 ±  4%      -1.3        1.88        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      3.22 ±  4%      -1.3        1.93        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      1.06 ±  6%      -0.4        0.70        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.build_decl
      1.12 ±  5%      -0.4        0.76        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.build_decl
      1.12 ±  5%      -0.3        0.77        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.build_decl
      1.29 ±  4%      -0.3        0.96        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.build_decl
      0.56 ±  2%      -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.56 ±  2%      -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.87 ±  5%      -0.3        0.58 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.make_node
      0.92 ±  5%      -0.3        0.64        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.make_node
      0.92 ±  5%      -0.3        0.64 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.make_node
      1.05 ±  4%      -0.3        0.80        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.make_node
      1.99 ±  3%      -0.2        1.78        perf-profile.calltrace.cycles-pp.build_decl
      1.66 ±  3%      -0.1        1.52        perf-profile.calltrace.cycles-pp.make_node
      0.93 ±  5%      -0.1        0.81 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.93 ±  5%      -0.1        0.82 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.80 ±  5%      -0.1        0.69 ±  4%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.80 ±  5%      -0.1        0.69 ±  4%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.79 ±  5%      -0.1        0.68 ±  5%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      0.78 ±  5%      -0.1        0.67 ±  4%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      0.90 ±  4%      -0.1        0.79 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.84 ±  5%      -0.1        0.73 ±  4%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.63 ±  2%      -0.1        0.56 ±  3%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.58 ±  3%      -0.1        0.53        perf-profile.calltrace.cycles-pp.allocate_struct_function
      1.23 ±  2%      +0.1        1.29        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.28 ±  2%      +0.1        1.34        perf-profile.calltrace.cycles-pp.read
      1.24 ±  2%      +0.1        1.30        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.59 ±  3%      +0.1        0.66        perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.62            +0.1        0.69        perf-profile.calltrace.cycles-pp.pop_scope
      0.80 ±  3%      +0.1        0.87 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.53 ±  2%      +0.1        0.62 ±  2%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.56            +0.1        0.66 ±  2%  perf-profile.calltrace.cycles-pp.ggc_internal_alloc
      0.66 ±  2%      +0.1        0.78        perf-profile.calltrace.cycles-pp.cfree
      0.81            +0.1        0.94 ±  2%  perf-profile.calltrace.cycles-pp._cpp_lex_direct
      0.76 ±  2%      +0.1        0.89 ±  2%  perf-profile.calltrace.cycles-pp.size_binop_loc
      0.71 ±  2%      +0.1        0.86 ±  2%  perf-profile.calltrace.cycles-pp.linemap_location_in_system_header_p
      1.72 ±  2%      +0.2        1.87        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.71            +0.2        1.87        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.85 ±  2%      +0.2        2.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      1.84 ±  2%      +0.2        2.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.89 ±  2%      +0.2        2.06        perf-profile.calltrace.cycles-pp.open64
      1.43            +0.2        1.64        perf-profile.calltrace.cycles-pp.type_hash_canon
      1.51            +0.3        1.78        perf-profile.calltrace.cycles-pp.malloc
      0.25 ±100%      +0.3        0.56 ±  2%  perf-profile.calltrace.cycles-pp.df_bb_refs_record
      0.66 ±  2%      +0.3        1.01 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.67            +0.3        1.02 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.61            +0.3        0.96 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.52            +0.4        0.88 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.96 ± 23%      +0.4        1.34 ±  4%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.17 ±141%      +0.4        0.59 ±  2%  perf-profile.calltrace.cycles-pp.c_parser_declspecs
      0.84            +0.4        1.27 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.90            +0.4        1.34 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.19 ±  2%      +0.5        3.66        perf-profile.calltrace.cycles-pp.htab_find_slot_with_hash
      0.08 ±223%      +0.5        0.57        perf-profile.calltrace.cycles-pp.variably_modified_type_p
      0.34 ± 70%      +0.5        0.85 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp._cpp_skip_block_comment
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.17 ±141%      +0.7        0.84 ±  3%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      4.72            +0.8        5.56        perf-profile.calltrace.cycles-pp.c_lex_with_flags
     10.91 ± 14%     -10.3        0.56 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     10.74 ± 14%     -10.3        0.40 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      6.45 ± 13%      -6.3        0.18 ±  2%  perf-profile.children.cycles-pp.rmqueue_bulk
      8.59 ±  9%      -6.0        2.54        perf-profile.children.cycles-pp.get_page_from_freelist
      8.90 ±  8%      -6.0        2.89        perf-profile.children.cycles-pp.__alloc_pages
      7.11 ± 11%      -5.9        1.22        perf-profile.children.cycles-pp.rmqueue
      6.95 ± 12%      -5.9        1.08        perf-profile.children.cycles-pp.__rmqueue_pcplist
      8.27 ±  8%      -5.5        2.74        perf-profile.children.cycles-pp.__folio_alloc
      8.41 ±  8%      -5.5        2.90        perf-profile.children.cycles-pp.vma_alloc_folio
     23.17 ±  3%      -5.4       17.74 ±  4%  perf-profile.children.cycles-pp.do_syscall_64
     23.19 ±  3%      -5.4       17.77 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.25 ± 14%      -5.1        0.17 ±  5%  perf-profile.children.cycles-pp.free_pcppages_bulk
      5.36 ± 14%      -5.0        0.35        perf-profile.children.cycles-pp.free_unref_page_list
      6.28 ± 11%      -5.0        1.28 ±  2%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
     15.21 ±  3%      -5.0       10.22        perf-profile.children.cycles-pp.__handle_mm_fault
      6.16 ± 11%      -5.0        1.18        perf-profile.children.cycles-pp.release_pages
     15.62 ±  3%      -4.9       10.69        perf-profile.children.cycles-pp.handle_mm_fault
     16.38 ±  3%      -4.8       11.62        perf-profile.children.cycles-pp.do_user_addr_fault
     16.42 ±  3%      -4.7       11.68        perf-profile.children.cycles-pp.exc_page_fault
     12.32 ±  5%      -4.7        7.62        perf-profile.children.cycles-pp.do_anonymous_page
     18.43 ±  2%      -4.5       13.93        perf-profile.children.cycles-pp.asm_exc_page_fault
      4.52 ± 12%      -3.6        0.90 ±  4%  perf-profile.children.cycles-pp.tlb_finish_mmu
      6.33 ±  3%      -2.8        3.53 ±  5%  perf-profile.children.cycles-pp.exit_mmap
      6.34 ±  3%      -2.8        3.54 ±  4%  perf-profile.children.cycles-pp.__mmput
      6.31 ±  3%      -2.7        3.56 ±  4%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      6.31 ±  3%      -2.7        3.56 ±  4%  perf-profile.children.cycles-pp.do_group_exit
      5.94 ±  4%      -2.7        3.19 ±  3%  perf-profile.children.cycles-pp.exit_mm
      6.30 ±  3%      -2.7        3.56 ±  4%  perf-profile.children.cycles-pp.do_exit
      3.96 ±  5%      -2.3        1.64 ±  7%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      3.98 ±  5%      -2.3        1.66 ±  7%  perf-profile.children.cycles-pp.do_vmi_munmap
      3.08 ±  9%      -2.2        0.83 ±  5%  perf-profile.children.cycles-pp.unmap_region
      2.92 ± 11%      -2.2        0.73        perf-profile.children.cycles-pp.__vm_munmap
      2.80 ± 12%      -2.2        0.61 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
      2.70 ± 13%      -2.2        0.52 ±  2%  perf-profile.children.cycles-pp.__munmap
      3.59 ±  3%      -1.3        2.31        perf-profile.children.cycles-pp.unmap_page_range
      3.57 ±  3%      -1.3        2.30        perf-profile.children.cycles-pp.zap_pmd_range
      3.64 ±  3%      -1.3        2.37        perf-profile.children.cycles-pp.unmap_vmas
      3.56 ±  3%      -1.3        2.28        perf-profile.children.cycles-pp.zap_pte_range
      3.24 ±  4%      -0.7        2.56 ±  2%  perf-profile.children.cycles-pp.elf_read
      0.47            -0.4        0.06 ±  6%  perf-profile.children.cycles-pp.__free_one_page
      0.99 ± 11%      -0.2        0.77 ±  8%  perf-profile.children.cycles-pp.copy_process
      1.13 ± 11%      -0.2        0.92 ±  8%  perf-profile.children.cycles-pp.__do_sys_clone
      1.30 ±  9%      -0.2        1.10 ±  6%  perf-profile.children.cycles-pp.kernel_clone
      0.69            -0.2        0.49 ±  2%  perf-profile.children.cycles-pp.wp_page_copy
      2.12 ±  3%      -0.2        1.93        perf-profile.children.cycles-pp.build_decl
      0.32 ± 10%      -0.2        0.13 ±  6%  perf-profile.children.cycles-pp.___slab_alloc
      0.84 ±  9%      -0.2        0.67 ±  8%  perf-profile.children.cycles-pp.mm_init
      0.68 ± 16%      -0.1        0.53 ± 11%  perf-profile.children.cycles-pp.dup_mm
      1.78 ±  2%      -0.1        1.65        perf-profile.children.cycles-pp.make_node
      0.42 ±  2%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.do_cow_fault
      0.98 ±  5%      -0.1        0.86 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.63 ±  9%      -0.1        0.51 ±  8%  perf-profile.children.cycles-pp.alloc_bprm
      0.97 ±  5%      -0.1        0.85 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      1.26 ±  4%      -0.1        1.15 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
      0.80 ±  5%      -0.1        0.69 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.90 ±  4%      -0.1        0.79 ±  4%  perf-profile.children.cycles-pp.kthread
      0.84 ±  5%      -0.1        0.73 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.68 ±  4%      -0.1        0.60 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.18 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.dup_task_struct
      1.00 ±  4%      -0.1        0.93 ±  3%  perf-profile.children.cycles-pp.alloc_empty_file
      0.63 ±  2%      -0.1        0.56 ±  4%  perf-profile.children.cycles-pp.__libc_fork
      0.13 ±  5%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.50 ±  3%      -0.1        0.44        perf-profile.children.cycles-pp.tree_cons
      0.14 ±  3%      -0.1        0.09 ±  6%  perf-profile.children.cycles-pp.pte_alloc_one
      1.28            -0.1        1.22        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.17 ±  6%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.21 ±  7%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.get_arg_page
      0.64 ±  3%      -0.1        0.58        perf-profile.children.cycles-pp.allocate_struct_function
      0.27 ±  5%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.elf_create_section
      0.16 ±  7%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.__get_user_pages
      0.12 ±  8%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.copy_p4d_range
      0.12 ±  8%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.copy_page_range
      0.38 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.cgraph_node::create
      0.11 ±  3%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.copy_string_kernel
      0.12 ±  6%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.08 ±  4%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.perf_rotate_context
      0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__pte_alloc
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.mas_preallocate
      0.20 ±  5%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.14 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.build_string
      0.13 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.build_tree_list
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.shift_arg_pages
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.get_alias_set
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.finish_record_layout
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.avail_exprs_stack::lookup_avail_expr
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.lra_constraints
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.rpo_vn_valueize
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.build_int_cst
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.__next_zones_zonelist
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.__irqentry_text_end
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.execute_fixup_cfg
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.push_stmt_list
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.make_location
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.free_unref_page_prepare
      0.09            +0.0        0.10        perf-profile.children.cycles-pp.build_type_inheritance_graph
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.place_field
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.c_parse_file
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.sizeof_pointer_memaccess_warning
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.build_asm_expr
      0.10 ±  3%      +0.0        0.11        perf-profile.children.cycles-pp.build_pointer_type
      0.09            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.error_entry
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.07            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.add_dependence
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.errseq_sample
      0.12 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.__do_sys_newfstat
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.delete_trivially_dead_insns
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.hash_rtx_cb
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.c_token_starts_typename
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.generic_simplify
      0.06 ±  6%      +0.0        0.07        perf-profile.children.cycles-pp.gimple_fold_stmt_to_constant_1
      0.12            +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.setlocale
      0.13 ±  5%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.10            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.malloc@plt
      0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.parser_build_binary_op
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.cpp_interpret_integer
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.et_below
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mark_dfs_back_edges
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.shorten_compare
      0.21 ±  2%      +0.0        0.22        perf-profile.children.cycles-pp.fold_build2_loc
      0.09 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.build_pointer_type_for_mode
      0.08 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.get_parm_info
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.compute_may_aliases
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.extract_constrain_insn_cached
      0.06 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.compute_fn_summary
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.ira_init_register_move_cost
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.start_decl
      0.19 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.update_sg_lb_stats
      0.14 ±  2%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.09            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.df_compact_blocks
      0.09            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.walk_tree_1
      0.10 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.handle_pte_fault
      0.10 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.get_inner_reference
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.c_fully_fold
      0.08 ±  4%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.07            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.vn_reference_lookup
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.execute_update_addresses_taken
      0.08            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.c_parser_require
      0.08            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.dom_walker::walk
      0.08            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.realloc
      0.13 ±  5%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.strncpy_from_user
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sched_rgn_compute_dependencies
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.clear_huge_page
      0.08 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.post_order_compute
      0.18 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.filemap_get_read_batch
      0.16 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__fxstat64
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.layout_decl
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.update_stmt_operands
      0.10            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.cleanup_tree_cfg
      0.10            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.walk_stmt_load_store_addr_ops
      0.10            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.build_unary_op
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.c_parser_declarator
      0.09            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.build_external_ref
      0.09 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.inchash::add_expr
      0.09            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.fold
      0.09 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.linemap_lookup
      0.09            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.mark_irreducible_loops
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rebuild_jump_labels
      0.21 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.find_busiest_group
      0.13 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.cgraph_node::remove
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.wide_int_binop
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.cpp_classify_number
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.general_operand
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.inverted_post_order_compute
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.get_attr_type
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.schedule_insns
      0.19 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.filemap_get_pages
      0.13 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.free@plt
      0.11 ±  3%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.substitute_and_fold_engine::substitute_and_fold
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.extract_insn
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.memchr@plt
      0.11            +0.0        0.13        perf-profile.children.cycles-pp.lra_inheritance
      0.11            +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.cleanup_cfg
      0.09 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.ferror@plt
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.max_issue
      0.28 ±  3%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.ht_lookup_with_hash
      0.13 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.finish_decl
      0.11 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.warnings_for_convert_and_check
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.gimplify_expr
      0.26 ±  2%      +0.0        0.28        perf-profile.children.cycles-pp.newidle_balance
      0.25            +0.0        0.28        perf-profile.children.cycles-pp.load_balance
      0.20 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.19 ±  4%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.getname_flags
      0.16 ±  3%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.check_function_arguments
      0.11 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.rewrite_update_dom_walker::before_dom_children
      0.21 ±  3%      +0.0        0.23        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.12 ±  5%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.blk_cgroup_congested
      0.11 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.side_effects_p
      0.24 ±  3%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.12 ±  4%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.get_ref_base_and_extent
      0.26 ±  3%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.13 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.remove_unused_locals
      0.12            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.iterative_hash
      0.11 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.ssa_propagation_engine::ssa_propagate
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp._cpp_pop_context
      0.23 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.mtree_range_walk
      0.30 ±  2%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.18 ±  3%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__libc_calloc
      0.16 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.update_load_avg
      0.13 ±  2%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.declspecs_add_type
      0.13 ±  2%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.build_qualified_type
      0.30 ±  4%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.14 ±  3%      +0.0        0.17 ±  8%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.13 ±  3%      +0.0        0.16        perf-profile.children.cycles-pp.type_hash_canon_hash
      0.13 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.linemap_resolve_location
      0.16 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.fold_convert_loc
      0.22            +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.build_null_declspecs
      0.14            +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.rtx_cost
      0.14 ±  4%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.regstat_compute_ri
      0.24            +0.0        0.27        perf-profile.children.cycles-pp.fix_string_type
      0.16 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.pre_and_rev_post_order_compute_fn
      0.15 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp._IO_ferror
      0.21 ±  2%      +0.0        0.24        perf-profile.children.cycles-pp.linemap_line_start
      0.17 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.single_def_use_dom_walker::before_dom_children
      0.18 ±  3%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp._cpp_find_file
      0.15 ±  4%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.diagnostic_report_diagnostic
      0.14 ±  4%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.cselib_lookup
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.set_source_range
      0.20            +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.htab_traverse
      0.42 ±  3%      +0.0        0.45 ±  4%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.17 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.integer_zerop
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.get_range_from_loc
      0.28 ±  2%      +0.0        0.32        perf-profile.children.cycles-pp.mas_walk
      0.22 ±  2%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.build_function_call_vec
      0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.convert
      0.38            +0.0        0.42        perf-profile.children.cycles-pp.lru_add_fn
      0.23 ±  2%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.convert_lvalue_to_rvalue
      0.20 ±  2%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.bitmap_set_bit
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.strncmp@plt
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.df_analyze
      0.21 ±  2%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.gimple_call_flags
      0.22            +0.0        0.26        perf-profile.children.cycles-pp.default_conversion
      0.22            +0.0        0.26        perf-profile.children.cycles-pp.c_parser_consume_token
      0.14 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.36            +0.0        0.41        perf-profile.children.cycles-pp.__mod_node_page_state
      0.25 ±  2%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.calculate_dominance_info
      0.78            +0.0        0.83        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.44 ±  3%      +0.0        0.48        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.31 ±  2%      +0.0        0.36        perf-profile.children.cycles-pp.decl_attributes
      0.25 ±  2%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.df_insn_rescan
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.fold_ternary_loc
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.schedule_block
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.c_build_qualified_type
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.finish_function
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sched_free_deps
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.warning_at
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.bitmap_bit_p
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mark_exp_read
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.regstat_compute_calls_crossed
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.recompute_tree_invariant_for_addr_expr
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.may_trap_p_1
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.build_c_cast
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.c_process_expr_stmt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.gimple_resimplify2
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.delete_unreachable_blocks
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.access_error
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.string_concat_db::record_string_concatenation
      0.27 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.verify_sequence_points
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.41            +0.1        0.46        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.36            +0.1        0.41        perf-profile.children.cycles-pp.___perf_sw_event
      0.30            +0.1        0.36        perf-profile.children.cycles-pp.fold_unary_loc
      1.32 ±  2%      +0.1        1.38        perf-profile.children.cycles-pp.ksys_read
      1.32            +0.1        1.38        perf-profile.children.cycles-pp.vfs_read
      0.35            +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.lookup_name
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.account_user_time
      0.34 ±  3%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.wi::force_to_size
      0.42            +0.1        0.48        perf-profile.children.cycles-pp.__perf_sw_event
      0.37            +0.1        0.43        perf-profile.children.cycles-pp.fold_binary_loc
      0.46            +0.1        0.52        perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.38            +0.1        0.44        perf-profile.children.cycles-pp.getenv
      0.35 ±  2%      +0.1        0.42        perf-profile.children.cycles-pp._cpp_handle_directive
      0.33 ±  3%      +0.1        0.39        perf-profile.children.cycles-pp.execute_one_pass
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.50            +0.1        0.57        perf-profile.children.cycles-pp.df_bb_refs_record
      0.58            +0.1        0.65        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      1.28 ±  2%      +0.1        1.35        perf-profile.children.cycles-pp.read
      0.23            +0.1        0.30        perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.41 ±  2%      +0.1        0.48        perf-profile.children.cycles-pp._cpp_clean_line
      0.66            +0.1        0.73        perf-profile.children.cycles-pp.folio_batch_move_lru
      0.35 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.init_alias_analysis
      0.33            +0.1        0.40 ±  3%  perf-profile.children.cycles-pp.constrain_operands
      0.41            +0.1        0.48 ±  2%  perf-profile.children.cycles-pp.build_binary_op
      0.33            +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.47            +0.1        0.54 ±  2%  perf-profile.children.cycles-pp.layout_type
      0.41            +0.1        0.48        perf-profile.children.cycles-pp.operand_equal_p
      0.44            +0.1        0.52        perf-profile.children.cycles-pp._cpp_skip_block_comment
      0.62            +0.1        0.70        perf-profile.children.cycles-pp.pop_scope
      0.02 ±143%      +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.36 ±  2%      +0.1        0.44 ±  4%  perf-profile.children.cycles-pp.df_worklist_dataflow
      0.64            +0.1        0.72        perf-profile.children.cycles-pp.folio_add_lru_vma
      0.51            +0.1        0.59        perf-profile.children.cycles-pp.variably_modified_type_p
      0.05 ± 80%      +0.1        0.14 ± 34%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.88            +0.1        0.97        perf-profile.children.cycles-pp.native_irq_return_iret
      0.55 ±  2%      +0.1        0.64 ±  2%  perf-profile.children.cycles-pp.c_parser_declspecs
      0.52 ±  2%      +0.1        0.62 ±  2%  perf-profile.children.cycles-pp.location_get_source_line
      0.80            +0.1        0.91        perf-profile.children.cycles-pp.sync_regs
      0.58            +0.1        0.68 ±  2%  perf-profile.children.cycles-pp.ggc_internal_alloc
      0.73 ±  2%      +0.1        0.84        perf-profile.children.cycles-pp._compound_head
      0.10 ± 76%      +0.1        0.23 ± 27%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.84            +0.1        0.97        perf-profile.children.cycles-pp._cpp_lex_direct
      0.73 ±  2%      +0.1        0.87        perf-profile.children.cycles-pp.cfree
      0.10 ± 74%      +0.1        0.24 ± 28%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.10 ± 74%      +0.1        0.24 ± 28%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.82 ±  2%      +0.1        0.96 ±  2%  perf-profile.children.cycles-pp.size_binop_loc
      0.72            +0.1        0.87 ±  2%  perf-profile.children.cycles-pp.linemap_location_in_system_header_p
      0.55 ±  4%      +0.2        0.73        perf-profile.children.cycles-pp.__irq_exit_rcu
      1.90 ±  2%      +0.2        2.08        perf-profile.children.cycles-pp.open64
      1.82            +0.2        2.01        perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.11 ±  6%      +0.2        0.31 ±  2%  perf-profile.children.cycles-pp.check_cpu_stall
      0.12 ±  4%      +0.2        0.33 ±  2%  perf-profile.children.cycles-pp.rcu_pending
      1.44            +0.2        1.65        perf-profile.children.cycles-pp.type_hash_canon
      0.14 ±  4%      +0.2        0.35        perf-profile.children.cycles-pp.rcu_sched_clock_irq
      2.42            +0.2        2.64        perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.58            +0.3        1.85        perf-profile.children.cycles-pp.malloc
      0.53            +0.3        0.84 ±  2%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.53            +0.3        0.84 ±  2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      1.03            +0.4        1.45        perf-profile.children.cycles-pp.scheduler_tick
      3.20            +0.5        3.67        perf-profile.children.cycles-pp.htab_find_slot_with_hash
      1.70            +0.7        2.40        perf-profile.children.cycles-pp.hrtimer_interrupt
      1.72            +0.7        2.42 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.56            +0.7        2.28        perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.29            +0.7        2.01 ±  2%  perf-profile.children.cycles-pp.update_process_times
      1.30            +0.7        2.02        perf-profile.children.cycles-pp.tick_sched_handle
      1.35            +0.8        2.12 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      2.32            +0.9        3.19        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.86            +0.9        5.74        perf-profile.children.cycles-pp.c_lex_with_flags
      2.46            +0.9        3.35        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     10.90 ± 14%     -10.3        0.55 ±  7%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.43 ±  2%      -0.4        0.05 ±  7%  perf-profile.self.cycles-pp.__free_one_page
      1.24 ±  4%      -0.1        1.12 ±  4%  perf-profile.self.cycles-pp.clear_page_erms
      1.25            -0.1        1.19        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.12 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.rmqueue
      0.28            -0.0        0.25        perf-profile.self.cycles-pp.get_page_from_freelist
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.ferror@plt
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.ggc_internal_cleared_alloc
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.extract_constrain_insn_cached
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.gimple_fold_stmt_to_constant_1
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.shorten_compare
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.get_alias_set
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.lra
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.finish_record_layout
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.c_common_truthvalue_conversion
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.dom_opt_dom_walker::before_dom_children
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.asm_exc_page_fault
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.link_path_walk
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.filemap_read
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.place_field
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.realloc
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.execute_fixup_cfg
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.build_type_inheritance_graph
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.mas_walk
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.compute_may_aliases
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.make_location
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.sizeof_pointer_memaccess_warning
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.mark_dfs_back_edges
      0.09            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.09            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.build_unary_op
      0.09            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.df_compact_blocks
      0.07 ±  5%      +0.0        0.08        perf-profile.self.cycles-pp.add_dependence
      0.07            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.cpp_interpret_integer
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.lra_remat
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.errseq_sample
      0.05 ±  8%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.delete_basic_block
      0.05 ±  8%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.eliminate_dom_walker::before_dom_children
      0.08            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.error_entry
      0.08            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.malloc@plt
      0.08 ±  4%      +0.0        0.09        perf-profile.self.cycles-pp.pop_stmt_list
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.build_int_cst
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.hash_rtx_cb
      0.06 ±  6%      +0.0        0.07        perf-profile.self.cycles-pp.delete_trivially_dead_insns
      0.06 ±  6%      +0.0        0.07        perf-profile.self.cycles-pp.flow_loops_find
      0.15 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.10            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.cpp_classify_number
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.c_parser_declarator
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.vma_alloc_folio
      0.08            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.start_decl
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.do_anonymous_page
      0.10 ±  3%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ira_init
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.gimplify_expr
      0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.build_stmt
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.build_pointer_type
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__perf_sw_event
      0.06 ±  7%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.___slab_alloc
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.et_below
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.reg_scan
      0.13 ±  2%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.cgraph_node::remove
      0.08 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.linemap_lookup
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ira_init_register_move_cost
      0.08            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.c_parser_require
      0.11 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.cleanup_cfg
      0.10 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.copy_node
      0.09 ±  5%      +0.0        0.11        perf-profile.self.cycles-pp.parser_build_binary_op
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.build_external_ref
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.inchash::add_expr
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sched_rgn_compute_dependencies
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.max_issue
      0.07 ±  5%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.post_order_compute
      0.12 ±  3%      +0.0        0.14        perf-profile.self.cycles-pp.lru_add_fn
      0.12 ±  3%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.unshare_all_rtl_in_chain
      0.15 ±  3%      +0.0        0.17        perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.14            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__alloc_pages
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.cleanup_tree_cfg
      0.04 ± 44%      +0.0        0.06        perf-profile.self.cycles-pp.lra_constraints
      0.12 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.layout_decl
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.inverted_post_order_compute
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.free@plt
      0.08            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.fold
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.c_fully_fold
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.rebuild_jump_labels
      0.06            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.get_attr_type
      0.12 ±  5%      +0.0        0.14        perf-profile.self.cycles-pp.cgraph_node::create
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.walk_stmt_load_store_addr_ops
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.wide_int_binop
      0.09            +0.0        0.11        perf-profile.self.cycles-pp.extract_insn
      0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.finish_decl
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp._IO_ferror
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.warnings_for_convert_and_check
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.substitute_and_fold_engine::substitute_and_fold
      0.09 ±  4%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.get_inner_reference
      0.08 ±  4%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.general_operand
      0.07            +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.update_curr
      0.12            +0.0        0.14        perf-profile.self.cycles-pp.build3
      0.14            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.handle_mm_fault
      0.11 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.lra_inheritance
      0.13 ±  2%      +0.0        0.15        perf-profile.self.cycles-pp.declspecs_add_type
      0.13 ±  2%      +0.0        0.15        perf-profile.self.cycles-pp.build_qualified_type
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.11            +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.side_effects_p
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.check_function_arguments
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.get_combined_adhoc_loc
      0.11 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ssa_propagation_engine::ssa_propagate
      0.11 ±  4%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.update_stmt_operands
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.fold_convert_loc
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.rewrite_update_dom_walker::before_dom_children
      0.22 ±  3%      +0.0        0.25        perf-profile.self.cycles-pp.mtree_range_walk
      0.14 ±  2%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.regstat_compute_ri
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.remove_unused_locals
      0.12            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.get_ref_base_and_extent
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.type_hash_canon_hash
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.linemap_resolve_location
      0.11 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.iterative_hash
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.pre_and_rev_post_order_compute_fn
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.tree_cons
      0.57 ±  2%      +0.0        0.60 ±  2%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.rtx_cost
      0.16 ±  4%      +0.0        0.19        perf-profile.self.cycles-pp.__libc_calloc
      0.14 ±  3%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.diagnostic_report_diagnostic
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.add_stmt
      0.18 ±  2%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp._cpp_find_file
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.convert
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp._cpp_pop_context
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.fold_build2_loc
      0.13 ±  2%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.cselib_lookup
      0.20 ±  2%      +0.0        0.23        perf-profile.self.cycles-pp.pushdecl
      0.20 ±  2%      +0.0        0.23        perf-profile.self.cycles-pp.fix_string_type
      0.14 ±  2%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.integer_zerop
      0.20            +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.build_null_declspecs
      0.20            +0.0        0.23        perf-profile.self.cycles-pp.htab_traverse
      0.19 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.linemap_line_start
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.build1
      0.16 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.get_range_from_loc
      0.40 ±  2%      +0.0        0.44 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.17 ±  2%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.single_def_use_dom_walker::before_dom_children
      0.23 ±  3%      +0.0        0.26        perf-profile.self.cycles-pp.convert_lvalue_to_rvalue
      0.22 ±  3%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.ht_lookup_with_hash
      0.21 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.build_function_call_vec
      0.27 ±  2%      +0.0        0.31        perf-profile.self.cycles-pp.allocate_struct_function
      0.21 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.default_conversion
      0.16 ±  2%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.set_source_range
      0.26            +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.build_call_array_loc
      0.29            +0.0        0.32        perf-profile.self.cycles-pp.___perf_sw_event
      0.20 ±  2%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.bitmap_set_bit
      0.21            +0.0        0.25        perf-profile.self.cycles-pp.c_parser_consume_token
      0.20 ±  3%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.gimple_call_flags
      0.35            +0.0        0.39        perf-profile.self.cycles-pp.__mod_node_page_state
      0.28            +0.0        0.32        perf-profile.self.cycles-pp.build2
      0.24 ±  2%      +0.0        0.29 ±  3%  perf-profile.self.cycles-pp.calculate_dominance_info
      0.26            +0.0        0.31 ±  2%  perf-profile.self.cycles-pp.verify_sequence_points
      0.30            +0.0        0.34        perf-profile.self.cycles-pp.decl_attributes
      0.24 ±  2%      +0.0        0.29 ±  3%  perf-profile.self.cycles-pp.df_insn_rescan
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rtx_alloc
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.wi::lshift_large
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.compare_tree_int
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.schedule_block
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.insn_extract
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.sched_free_deps
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.regstat_compute_calls_crossed
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.delete_unreachable_blocks
      0.29            +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.fold_unary_loc
      0.07 ± 11%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.rcu_core
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.rtx_equal_for_cselib_1
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.30 ±  2%      +0.1        0.35 ±  2%  perf-profile.self.cycles-pp.linemap_enter_macro
      0.34 ±  3%      +0.1        0.39        perf-profile.self.cycles-pp.build_function_type
      0.32 ±  2%      +0.1        0.37        perf-profile.self.cycles-pp.wi::force_to_size
      0.34 ±  2%      +0.1        0.40        perf-profile.self.cycles-pp._cpp_handle_directive
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.34 ±  2%      +0.1        0.40        perf-profile.self.cycles-pp.lookup_name
      0.37            +0.1        0.42        perf-profile.self.cycles-pp.getenv
      0.34            +0.1        0.40        perf-profile.self.cycles-pp.fold_binary_loc
      0.32 ±  2%      +0.1        0.38        perf-profile.self.cycles-pp.execute_one_pass
      0.39            +0.1        0.45 ±  2%  perf-profile.self.cycles-pp.build_binary_op
      0.39 ±  2%      +0.1        0.45        perf-profile.self.cycles-pp._cpp_clean_line
      0.62 ±  2%      +0.1        0.68        perf-profile.self.cycles-pp.copyout
      0.23            +0.1        0.30        perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.43            +0.1        0.50 ±  2%  perf-profile.self.cycles-pp.layout_type
      0.40            +0.1        0.47        perf-profile.self.cycles-pp.operand_equal_p
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.update_process_times
      0.32            +0.1        0.39 ±  2%  perf-profile.self.cycles-pp.constrain_operands
      0.36 ±  3%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.df_worklist_dataflow
      0.60            +0.1        0.68        perf-profile.self.cycles-pp.pop_scope
      0.43            +0.1        0.50        perf-profile.self.cycles-pp._cpp_skip_block_comment
      0.34 ±  2%      +0.1        0.42 ±  2%  perf-profile.self.cycles-pp.init_alias_analysis
      0.49 ±  2%      +0.1        0.57        perf-profile.self.cycles-pp.variably_modified_type_p
      0.43 ±  2%      +0.1        0.51 ±  2%  perf-profile.self.cycles-pp.df_bb_refs_record
      0.54            +0.1        0.63 ±  2%  perf-profile.self.cycles-pp.elf_read
      0.51            +0.1        0.59 ±  2%  perf-profile.self.cycles-pp.c_parser_declspecs
      0.88            +0.1        0.97        perf-profile.self.cycles-pp.native_irq_return_iret
      0.47 ±  2%      +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.location_get_source_line
      0.55            +0.1        0.65 ±  2%  perf-profile.self.cycles-pp.ggc_internal_alloc
      0.71 ±  2%      +0.1        0.81        perf-profile.self.cycles-pp._compound_head
      0.80            +0.1        0.90        perf-profile.self.cycles-pp.sync_regs
      0.67            +0.1        0.78        perf-profile.self.cycles-pp.make_node
      0.63 ±  2%      +0.1        0.74        perf-profile.self.cycles-pp.cfree
      0.81            +0.1        0.93        perf-profile.self.cycles-pp._cpp_lex_direct
      0.78 ±  3%      +0.1        0.91        perf-profile.self.cycles-pp.build_decl
      0.74 ±  2%      +0.1        0.87 ±  3%  perf-profile.self.cycles-pp.size_binop_loc
      0.70 ±  2%      +0.1        0.84 ±  2%  perf-profile.self.cycles-pp.linemap_location_in_system_header_p
      1.79            +0.2        1.96        perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.11 ±  6%      +0.2        0.31 ±  2%  perf-profile.self.cycles-pp.check_cpu_stall
      1.39            +0.2        1.59        perf-profile.self.cycles-pp.type_hash_canon
      0.31            +0.2        0.53 ±  2%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      1.58            +0.2        1.82        perf-profile.self.cycles-pp._cpp_create_definition
      1.46            +0.3        1.72        perf-profile.self.cycles-pp.malloc
      3.14            +0.4        3.58        perf-profile.self.cycles-pp.htab_find_slot_with_hash
      4.74            +0.8        5.57        perf-profile.self.cycles-pp.c_lex_with_flags





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

