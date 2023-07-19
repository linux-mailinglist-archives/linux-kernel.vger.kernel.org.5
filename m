Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098507597B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGSOI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSOIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:08:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B518E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689775695; x=1721311695;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Obvsmy09PmiaSNlftAfuRJA5/uF1BtkYN3zLtmaSdZw=;
  b=Ic7QyPA0/Y4cF+WG+Iog9F4rUKKJGbwwonoUoLNlkHDyHWKWC1pKQ3/0
   0psOSCBjfYY7igqclZWKHwWLLKYJMD9O7HmXS5eb8cgIsqC3qCBGX1ssi
   msQxouWEIRFWL6rSM7pNkhgpZllv1l9NC6V2+rWVw+rGvm4tvqo7SBmGk
   bCgAgXKb+Kg+ybbMkvgAgy0JGEC4UcM17kwq/i+zpmjDFMdKCGFnp2oDd
   m080v1kkBjcKpH5wadKiiIOLEL5PH6eF+HXk3/JdNuvTPSqstr8OgboOu
   WC8mEOgO+xpo62L1Mb/4D7AADH1+/kB7tZDJH2Nv6aHhdaOnXruVAngab
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430242071"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="430242071"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 07:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717991261"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="717991261"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 07:08:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 07:08:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 07:08:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 07:08:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 07:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbmLWf/9dVLXxJ5f6C9BNwH6gY8MnJve35CjB+qtArcXM4FuTAmocwMpBauAHDR9WtaPQ2ZIxgv+IVmSMT/OGOJ3JxnNi6VXkeNEVl0MMuWjMXREanItQXNnLmDUpQKCZjpelOb14adSCI1Q7Mnq9x8aMwPLIFH5MD7osfBQJh16UumLditKw/dDNOx9a1iin02SjLO47gwoXD7881ck7y90imNvpJNJhj/wzt+KjBNSJ8hXYej89Y6u1aan2h1v4g3ADGJgB/GZRTDoDjZCMInoLYIObjBVQ8NNXc1Ls0RLn4AUXTDTcBhrlmg55FocOz8M2sdcSmzIjN5y5xwPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsT9zhSZ2GhMfr7HyBmb6Qx/uTjFBdbggvJYALZVaSo=;
 b=OjDAI8vOa15cVc7wna++M4h1PZ8jqfyvtKHTmHW/e6+6P0MWVg1WYnyRkPbGrkcR3Akz84dJGW0duB/Q6mjBZnH6N4meONERzLmPZ2y30gilVxv525/IKU/hximoAQH4fCgwxSdqHrgOPe2iEO+4MuoGGfDAB18c1p9WJEER7t7Bl7U7rNJVUU/iF2obNW0TH3OZkiMnObBjuJW+bgTAnXuTM/E+qH3V5MTJduWCnZ4aLqTjYbpiwaHJVzZVke0mYQyWyYbVClGX1o6UMvziP8e3cWzOobPFkhsi6RiFbjNBsSgC5AicM7d3O1Y5jVinGXlM8wKVU7GF7cBQdd11sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 14:08:03 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b2e3:de01:2d96:724e]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b2e3:de01:2d96:724e%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 14:08:03 +0000
Date:   Wed, 19 Jul 2023 22:07:52 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [x86/fpu]  b81fac906a:  stress-ng.af-alg.ops_per_sec
 -34.6% regression
Message-ID: <202307192135.203ac24e-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="GnpOZ+qGXYIRlwek"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 658dc243-a9a6-4f7b-e428-08db88619056
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgNbrrcJzo82aVua10EvMNi5X4ncK7HSSqpudhUnraR1H+P4sfZsW4JWE0oK76N17/OSWcwsEJrJ/xw6yAQzeOk00ATPhkFrOQB76ToBeCVXC1A0otACiGBNUiiHnc17c0H+bG+HNrcwmC5D/J85JP/EONjHqLF8wmmdjEMQr47aCjZDGDIZ1fyTPR4JS4061ZSQ6saNkSgzTRQDpLTWiOU6LLQ/R1aq1EmNnlGIVQLmAh6l8jdRm22CgN9hwVr+MO3eEqU4IT7zDu5OlAgTaFoqjSF2ninwlETeLkOs9XN5rEXcDV5C7CiE/PCEV+xu1Zm9Q3lKsNkZQLz4MCPsq3+2NVESCmlnPY2jbGuWB381zo8dE8iML4AURofOkgJQSCx5YizSOJnFT35+cwAGchFl5lXpfo/NIlTu5aqFPNBW7eucFdcvxDJ/uLUnVC4eOQP9Aont2ps4oUvvWuy5DBKL/7sQmI6Q9Nj+BphLhBW6ez/qAdXmUsKs+xorYxNu2CF+FeH7dnXrf/PdL+4tio3Y5QtUkLP0MyJvDxMeoVaF0BL4rwwiHHmFur2qIrYuBvwwzJS/QETZJmzob4JSQRNMW4CZzFWMaH0ic2GJ6P2xhDczpJNrR224zwHgbLh+4BFaxl7LLxccsLtOlLL3Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(86362001)(41300700001)(4326008)(8936002)(8676002)(235185007)(5660300002)(316002)(66476007)(66946007)(66556008)(6916009)(38100700002)(19627235002)(30864003)(2906002)(478600001)(82960400001)(6666004)(44144004)(21490400003)(6512007)(966005)(6486002)(107886003)(83380400001)(36756003)(186003)(1076003)(26005)(6506007)(2616005)(2700100001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5W2b8tJEVbM3+YhXYPlTdfw/sKYlg5racdZSryJsQ38285K9vrXp/m/IRy?=
 =?iso-8859-1?Q?XyIvc5F6vhhUMYuTeVFCbKKiyTNIALjxHMZfA+RlL/pt6tnlpnpBGNRIL/?=
 =?iso-8859-1?Q?7sceO2WC/U5kHyMbsnv2a5eCIY+MdGvKcci+0/IpnaZZRmxZG9TRguTpjI?=
 =?iso-8859-1?Q?tSNP8ljGUo+wwei5tV8yjMc+3C6Jm/5RrY7N/qogLCyyhzSxUEi5NDOHbv?=
 =?iso-8859-1?Q?IqVom/KluYY/BSEGb4EKCYOHkxh+fS9mJL7Pxxk1GVKbfRA8gfMHAfryN7?=
 =?iso-8859-1?Q?eilLU5Qh/DI4U4vlp+8JpnGZzqSlLvU9Yj9aNm8YccuC7V/nc6Josh/dGI?=
 =?iso-8859-1?Q?IPdilYMTwDnMHWPWO4fnEVOCmzxUV8PxpDXpZSSEPKJdieEaN/3WYXeMhY?=
 =?iso-8859-1?Q?rkcI//L03GoT04pl8B3JqIruSNmDcBiLnFtXutzfa2+s4nXA06WqKRhHwH?=
 =?iso-8859-1?Q?DqmNxMxI21kASNwgQw9SsvepMNEzHng3xLsTGTkqo++NF5bJpSjIDerImW?=
 =?iso-8859-1?Q?jGkVqIG+aa1ljp+44YTEh6rwwPJbAz5YoMUK+CDoNGNTrkgEHBVs1ZL57c?=
 =?iso-8859-1?Q?n4RdnY0PZ7zUcF8cHcSOsSvY0aagQWXoTFQ8yhQAwpO5KelwnGUtA33zA6?=
 =?iso-8859-1?Q?MUxMrPWx1NxnfhsPdR7pcjVlXvvipUEKtvuiPgWooO2x5a6k6cxNtmZkbp?=
 =?iso-8859-1?Q?SeIUBqsfWXit1CPo08+Vgy6GJhaljwxPt1AqprLNYum7FbQz0aHE9uMDvK?=
 =?iso-8859-1?Q?e3mfsfk+piZf8Avil44LpLpz+ABNad3Nq3TUPHNzsJ3TtpyLS58JSQKQsy?=
 =?iso-8859-1?Q?zwJTOZhe9G+3Oc9IkECEeo9b3aPnmkRVUPnaaPrkx+D8SOb7zn+lt/BwSZ?=
 =?iso-8859-1?Q?oi6jtOq5noA9qE0XAVuo0XHBwISFqEXfP+xwCkudlxjyvrrVrNCSImBOUq?=
 =?iso-8859-1?Q?B/GRbYvniBlQhO5rm6QKVSvUB1jnsdoq0rtta/F/6svhyR6K/jqa11Z+/w?=
 =?iso-8859-1?Q?ZLpKNHdjSwXaAfu01rI09ekYiSvJSWSrKtu9nUVJZvaSh+ctTY5rPwXKCS?=
 =?iso-8859-1?Q?TOxOAt4r1NLih7+loYkF7vbw2HzRaCwFbAkeyY3FHheYC3iZyB40qtIY4A?=
 =?iso-8859-1?Q?5XkKta56mEMrXth7mzZqwoysXOsZiWevwXU6iVrVgs56dbz+ej5W7VOn6S?=
 =?iso-8859-1?Q?MuvEVVrZuPfig9v5jl3T5r8YzgeZxOzGBE3z3hfzmklMD/EfAXBoDoAAQ5?=
 =?iso-8859-1?Q?ZhY2apTIa087yGZ5ogM1oSRGdwMToIVXnoQJN40HLf+rbaBwP8HjEOTw2X?=
 =?iso-8859-1?Q?K+IzgJZUkGDgEGaQgNvPi6dLa5O5wcFm0yfBZjGMnNd+0ypO6SIGHoCY3M?=
 =?iso-8859-1?Q?hfiEPp4EjrBymbuydFCSAnsQLO1Jq8/ZBiCz1IjFlFNnzll4xVjRxOW7qG?=
 =?iso-8859-1?Q?p7aBG4pwHim3n1hAY27YH4FSUNy+q76q2rI0wbFHsmXx8uR80iwR2r0I4f?=
 =?iso-8859-1?Q?cqYMwaJGY3Bq4BUon8hmFMLQJ4dfY0YGNG94LejPxVTtOTFF5brTcfibnB?=
 =?iso-8859-1?Q?F/5L+YS3GrkTg1l2bRfs+M6rmN9GoWoCJeAC6QTLR5db/MVfB+71kgB2F7?=
 =?iso-8859-1?Q?YBpKJ6aCrm40T7I8mdM8enO4qJS0HtzZNm/cvO8pR1tKm4vAAbL3h5yg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 658dc243-a9a6-4f7b-e428-08db88619056
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:08:02.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RS720/S+iCOwoY3gcHcKqJnfR43y+U0DAgaBvmmweCikul+IjQou7x/YMFt8PaCeQs6Q9kTUCyS+bFVtPpa6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GnpOZ+qGXYIRlwek
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a -34.6% regression of stress-ng.af-alg.ops_per_sec on:


commit: b81fac906a8f9e682e513ddd95697ec7a20878d4 ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

still regression on:
fix commit: fe3e0a13e597c1c8617814bf9b42ab732db5c26e
linus/master: ccff6d117d8dc8d8d86e8695a75e5f8b01e573bf

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: af-alg
	cpufreq_governor: performance


besides, we noticed there are below information in dmesg (attached kmsg.xz),
which we didn't see in dmesg for parent:

kern  :info  : [   65.660392] AVX or AES-NI instructions are not detected.
user  :notice: [   65.661743] stress-ng: info:  [4738] af-alg: 9 cryptographic algorithms are internal and may be unused

kern  :info  : [   65.720205] AVX or AES-NI instructions are not detected.
kern  :info  : [   65.820334] AVX2 instructions are not detected.
kern  :info  : [   66.130644] AVX or AES-NI instructions are not detected.
kern  :info  : [   66.167749] AVX or AES-NI instructions are not detected.
kern  :info  : [   66.213178] AVX2 instructions are not detected.
kern  :info  : [   66.318235] AVX or AES-NI instructions are not detected.
kern  :info  : [   66.360766] AVX or AES-NI instructions are not detected.
kern  :info  : [   66.437318] AVX2 instructions are not detected.
kern  :info  : [   66.683666] AVX or AES-NI instructions are not detected.
user  :notice: [   66.713976] BMC ARP Control         : ARP Responses Enabled, Gratuitous ARP Disabled

kern  :info  : [   66.738790] AVX or AES-NI instructions are not detected.
kern  :info  : [   66.822332] AVX2 instructions are not detected.
kern  :info  : [   67.083360] AVX or AES-NI instructions are not detected.
kern  :info  : [   67.122804] AVX or AES-NI instructions are not detected.



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202307192135.203ac24e-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/af-alg/stress-ng/60s

commit: 
  1703db2b90 ("x86/fpu: Mark init functions __init")
  b81fac906a ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")

1703db2b90c91b2e b81fac906a8f9e682e513ddd956 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4453936           +17.2%    5218922        cpuidle..usage
    475.17 ±  9%     -39.4%     288.00 ±  4%  perf-c2c.HITM.local
     68421 ±  6%     -68.2%      21789 ±115%  numa-meminfo.node1.AnonHugePages
    397537 ± 11%     -30.9%     274577 ± 25%  numa-meminfo.node1.AnonPages.max
  11275439 ±  8%     -40.6%    6702239 ± 12%  numa-numastat.node0.local_node
  11307159 ±  8%     -40.5%    6726387 ± 12%  numa-numastat.node0.numa_hit
  11307295 ±  8%     -40.5%    6726432 ± 12%  numa-vmstat.node0.numa_hit
  11275576 ±  8%     -40.6%    6702284 ± 12%  numa-vmstat.node0.numa_local
     90.28            +2.6%      92.63        iostat.cpu.idle
      6.74           -23.4%       5.16        iostat.cpu.system
      2.95           -26.4%       2.17 ±  2%  iostat.cpu.user
      0.12            -0.0        0.10        mpstat.cpu.all.soft%
      5.78            -1.7        4.12        mpstat.cpu.all.sys%
      3.02            -0.8        2.22 ±  2%  mpstat.cpu.all.usr%
      5.67 ±  8%     -29.4%       4.00        vmstat.procs.r
     27980           -29.5%      19716        vmstat.system.cs
     69859           +18.8%      83015        vmstat.system.in
    137449           -21.7%     107685        meminfo.Active
    135863           -21.9%     106091        meminfo.Active(anon)
    538488 ±  5%     +52.9%     823250 ±  4%  meminfo.DirectMap4k
     78913 ±  2%     -14.6%      67370        meminfo.Mapped
    181011           -22.4%     140469        meminfo.Shmem
     90999           -34.6%      59547        stress-ng.af-alg.ops
      1516           -34.6%     992.18        stress-ng.af-alg.ops_per_sec
     87.83           -32.8%      59.00        stress-ng.time.percent_of_cpu_this_job_got
     52.14           -32.7%      35.10        stress-ng.time.system_time
    175731           -34.6%     114964        stress-ng.time.voluntary_context_switches
    317.50           -22.4%     246.33        turbostat.Avg_MHz
     10.35            -2.1        8.23        turbostat.Busy%
      3073            -2.4%       2999        turbostat.Bzy_MHz
     14183           +20.3%      17060 ±  4%  turbostat.C1
    783741 ±  2%    +124.3%    1758028        turbostat.C1E
      7.98 ±  2%      +8.2       16.21        turbostat.C1E%
   4538585           +19.2%    5411831        turbostat.IRQ
     30452 ±  2%     -62.3%      11490 ±  9%  turbostat.POLL
    157.35            -3.5%     151.83        turbostat.PkgWatt
     33967           -21.9%      26523        proc-vmstat.nr_active_anon
     89639            -1.3%      88437        proc-vmstat.nr_anon_pages
    748728            -1.3%     738629        proc-vmstat.nr_file_pages
    101000            -4.0%      96980        proc-vmstat.nr_inactive_anon
     19752 ±  2%     -14.7%      16856        proc-vmstat.nr_mapped
     45267           -22.4%      35122        proc-vmstat.nr_shmem
     37642            -1.1%      37241        proc-vmstat.nr_slab_unreclaimable
     33967           -21.9%      26523        proc-vmstat.nr_zone_active_anon
    101000            -4.0%      96980        proc-vmstat.nr_zone_inactive_anon
  21330465           -30.8%   14764467        proc-vmstat.numa_hit
  21264274           -30.9%   14698273        proc-vmstat.numa_local
     74767 ±  8%     -26.1%      55256 ± 23%  proc-vmstat.numa_pte_updates
     77297           -21.4%      60741        proc-vmstat.pgactivate
  21716615           -30.7%   15050540        proc-vmstat.pgalloc_normal
  24651421           -31.0%   17003260        proc-vmstat.pgfault
  21608074           -30.8%   14960607        proc-vmstat.pgfree
    576512          +309.8%    2362624        proc-vmstat.unevictable_pgs_scanned
 2.657e+09           -28.1%   1.91e+09        perf-stat.i.branch-instructions
  55105518           -27.9%   39728424        perf-stat.i.branch-misses
      5.80 ±  2%      +1.3        7.13 ±  2%  perf-stat.i.cache-miss-rate%
   6856942 ±  3%      -9.4%    6209194 ±  2%  perf-stat.i.cache-misses
 1.314e+08           -28.1%   94523874        perf-stat.i.cache-references
     28932           -29.8%      20310        perf-stat.i.context-switches
      1.16            +7.1%       1.24        perf-stat.i.cpi
 1.969e+10           -22.9%  1.519e+10        perf-stat.i.cpu-cycles
    649.36 ±  2%     -37.1%     408.14 ±  2%  perf-stat.i.cpu-migrations
      3018 ±  2%     -15.6%       2548        perf-stat.i.cycles-between-cache-misses
      0.04 ±  2%      +0.0        0.06 ±  3%  perf-stat.i.dTLB-load-miss-rate%
   1941644            +8.1%    2099200 ±  2%  perf-stat.i.dTLB-load-misses
  4.69e+09           -29.1%  3.326e+09        perf-stat.i.dTLB-loads
      0.12            +0.0        0.13        perf-stat.i.dTLB-store-miss-rate%
   2651571           -26.7%    1942815        perf-stat.i.dTLB-store-misses
 2.113e+09           -29.5%   1.49e+09        perf-stat.i.dTLB-stores
 1.698e+10           -27.7%  1.227e+10        perf-stat.i.instructions
      0.87            -6.4%       0.81        perf-stat.i.ipc
      2035 ±  3%     -61.7%     778.70 ±  9%  perf-stat.i.major-faults
      0.31           -22.9%       0.24        perf-stat.i.metric.GHz
    167.15 ±  2%     -13.2%     145.14 ±  3%  perf-stat.i.metric.K/sec
    149.81           -28.9%     106.53        perf-stat.i.metric.M/sec
    388617           -31.0%     268024        perf-stat.i.minor-faults
   3246190 ±  7%     -23.5%    2483951 ±  4%  perf-stat.i.node-load-misses
     32.23 ±  2%      +6.0       38.26 ±  2%  perf-stat.i.node-store-miss-rate%
    886521 ±  3%     +24.8%    1106439 ±  3%  perf-stat.i.node-store-misses
   1968660 ±  2%      -8.4%    1802894        perf-stat.i.node-stores
    390652           -31.2%     268802        perf-stat.i.page-faults
      5.24 ±  2%      +1.3        6.59        perf-stat.overall.cache-miss-rate%
      1.16            +6.7%       1.24        perf-stat.overall.cpi
      2863 ±  2%     -14.8%       2440        perf-stat.overall.cycles-between-cache-misses
      0.04 ±  2%      +0.0        0.06 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.13            +0.0        0.13        perf-stat.overall.dTLB-store-miss-rate%
      0.86            -6.3%       0.81        perf-stat.overall.ipc
     30.85 ±  2%      +7.0       37.89 ±  2%  perf-stat.overall.node-store-miss-rate%
 2.617e+09           -28.1%  1.881e+09        perf-stat.ps.branch-instructions
  54225753           -27.9%   39076523        perf-stat.ps.branch-misses
   6779427 ±  3%      -9.6%    6127594 ±  2%  perf-stat.ps.cache-misses
 1.294e+08           -28.1%   93009393        perf-stat.ps.cache-references
     28483           -29.8%      19996        perf-stat.ps.context-switches
  1.94e+10           -22.9%  1.495e+10        perf-stat.ps.cpu-cycles
    638.69 ±  2%     -37.1%     401.75 ±  2%  perf-stat.ps.cpu-migrations
   1913060            +8.0%    2066590 ±  2%  perf-stat.ps.dTLB-load-misses
  4.62e+09           -29.1%  3.275e+09        perf-stat.ps.dTLB-loads
   2610836           -26.8%    1912030        perf-stat.ps.dTLB-store-misses
 2.081e+09           -29.5%  1.468e+09        perf-stat.ps.dTLB-stores
 1.673e+10           -27.8%  1.208e+10        perf-stat.ps.instructions
      2005 ±  3%     -61.8%     766.73 ±  9%  perf-stat.ps.major-faults
    382594           -31.1%     263761        perf-stat.ps.minor-faults
   3194487 ±  7%     -23.5%    2443082 ±  4%  perf-stat.ps.node-load-misses
    872822 ±  3%     +24.7%    1088214 ±  2%  perf-stat.ps.node-store-misses
   1956457 ±  2%      -8.8%    1783576        perf-stat.ps.node-stores
    384599           -31.2%     264527        perf-stat.ps.page-faults
 1.046e+12           -27.3%  7.603e+11        perf-stat.total.instructions
      0.00 ± 20%     -72.7%       0.00 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.async_synchronize_cookie_domain.call_usermodehelper_exec_async.ret_from_fork
      0.00 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.00 ± 17%     +84.6%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ±  7%    +375.3%       0.07 ± 11%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 20%     +52.0%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ±  7%     +29.3%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00 ± 20%     -72.7%       0.00 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.async_synchronize_cookie_domain.call_usermodehelper_exec_async.ret_from_fork
      0.00 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.02 ± 29%     -78.2%       0.00 ± 89%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_kernel_cred.call_usermodehelper_exec_async.ret_from_fork
      0.01 ± 38%     -55.6%       0.00 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init.mm_init
      0.02 ± 82%     -64.2%       0.01 ± 60%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      0.02 ± 27%     +67.6%       0.04 ± 19%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.03 ± 44%     -58.0%       0.01 ±  8%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00 ±223%    +900.0%       0.02 ± 29%  perf-sched.sch_delay.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.02 ± 23%     +72.0%       0.03 ± 20%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 31%     -83.9%       0.00 ± 99%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      4.04 ± 46%    +382.2%      19.47 ±  2%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 35%    +223.4%       0.03 ± 13%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      4.20 ± 17%     +60.4%       6.74 ± 18%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.01 ±  6%    +108.1%       0.01 ±  6%  perf-sched.total_sch_delay.average.ms
      5.58 ± 10%    +249.1%      19.47 ±  2%  perf-sched.total_sch_delay.max.ms
     13.94           +47.6%      20.58        perf-sched.total_wait_and_delay.average.ms
     79638           -29.4%      56254        perf-sched.total_wait_and_delay.count.ms
     13.94           +47.6%      20.57        perf-sched.total_wait_time.average.ms
      0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.08 ±  2%     +51.4%       3.15 ±  2%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    384.28           -30.6%     266.53 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    298.54 ± 13%     +63.3%     487.41 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    368.03 ±  5%     -80.2%      72.93        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.48 ±  8%     -19.7%       1.19 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.crypto_larval_wait.crypto_alg_mod_lookup
      1.82           +61.9%       2.95 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
     78.21 ±  3%     +32.4%     103.56        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
     14.85 ±  2%     +37.7%      20.44        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    726.00 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     12628 ±  2%     -29.5%       8908 ±  2%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     12520 ±  2%     -29.7%       8797 ±  2%  perf-sched.wait_and_delay.count.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work
    618.00 ±  3%     -41.8%     359.83 ±  8%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      5408 ±  4%     -62.3%       2039 ±  7%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    167.33           +55.0%     259.33 ±  2%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     52.67 ±  8%     -39.9%      31.67 ±  8%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     13.50 ±  8%    +860.5%     129.67        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1478 ± 23%     -69.8%     446.50 ± 18%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.crypto_larval_wait.crypto_alg_mod_lookup
     12518 ±  2%     -29.7%       8800 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
      7535           -23.4%       5772        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     22238           -25.8%      16493        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      0.06 ±112%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      3.92 ± 29%     -40.6%       2.33 ±  4%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.crypto_larval_wait.crypto_alg_mod_lookup
      5.35 ± 11%   +3637.0%     200.02 ± 11%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
      5.03           +68.3%       8.46 ± 14%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.88 ± 12%   +2136.1%      42.02        perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.08 ±  2%     +51.4%       3.14 ±  2%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 39%     -70.6%       0.00 ± 56%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.56 ± 17%     +48.9%       0.84 ±  9%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.10 ±223%  +51536.6%      51.98 ±  5%  perf-sched.wait_time.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
    384.27           -30.6%     266.52 ±  2%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    298.54 ± 13%     +63.3%     487.40 ± 18%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    368.02 ±  5%     -80.2%      72.92        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 37%     -79.4%       0.00 ±159%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      1.48 ±  8%     -19.8%       1.18 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.crypto_larval_wait.crypto_alg_mod_lookup
      1.82           +62.1%       2.94 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
      4.08           +18.6%       4.84 ± 13%  perf-sched.wait_time.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
     78.20 ±  3%     +32.3%     103.49        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.89 ± 12%   +2117.5%      42.02        perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     14.84 ±  2%     +37.7%      20.43        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      0.02 ± 29%     -68.5%       0.01 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.05 ±146%     -87.6%       0.01 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.[unknown]
      0.01 ± 56%     -69.8%       0.00 ± 70%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 57%     -84.4%       0.00 ±141%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      3.76 ± 12%   +2857.8%     111.15 ± 11%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.28 ±223%  +41327.3%     116.13 ± 12%  perf-sched.wait_time.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.02 ± 38%     -92.1%       0.00 ±141%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      0.03 ± 57%     -94.4%       0.00 ±142%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      3.92 ± 29%     -40.7%       2.32 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.crypto_larval_wait.crypto_alg_mod_lookup
      5.12 ± 10%   +3808.0%     200.02 ± 11%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
      4.09          +126.9%       9.29 ± 65%  perf-sched.wait_time.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      5.02           +68.5%       8.45 ± 14%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.79 ± 12%   +2833.2%     111.15 ± 11%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     24.78 ±  2%      -6.4       18.42 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     24.75 ±  2%      -6.4       18.39 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.72 ±  3%      -3.2        7.54 ±  4%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.46 ±  3%      -3.2        7.31 ±  4%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      9.77 ±  3%      -3.0        6.75 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.81 ±  3%      -3.0        6.79 ±  4%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.15            -2.5        7.63 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.15            -2.5        7.63 ±  3%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.15            -2.5        7.63 ±  3%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.43 ±  2%      -2.4       14.98        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     15.02 ±  3%      -2.4       12.59        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      9.32            -2.4        6.94 ±  4%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      9.27            -2.4        6.89 ±  4%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      9.31            -2.4        6.93 ±  4%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     16.35 ±  2%      -2.4       13.98        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     16.27 ±  2%      -2.3       13.93        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     12.31 ±  4%      -2.2       10.08        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     15.14 ±  2%      -2.2       12.93        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      9.96 ±  8%      -2.1        7.90 ±  3%  perf-profile.calltrace.cycles-pp.jent_kcapi_random._rng_recvmsg.sock_recvmsg.sock_read_iter.vfs_read
      9.96 ±  8%      -2.1        7.90 ±  3%  perf-profile.calltrace.cycles-pp.jent_read_entropy.jent_kcapi_random._rng_recvmsg.sock_recvmsg.sock_read_iter
      9.96 ±  8%      -2.1        7.90 ±  3%  perf-profile.calltrace.cycles-pp.jent_gen_entropy.jent_read_entropy.jent_kcapi_random._rng_recvmsg.sock_recvmsg
      9.95 ±  8%      -2.1        7.89 ±  3%  perf-profile.calltrace.cycles-pp.jent_measure_jitter.jent_gen_entropy.jent_read_entropy.jent_kcapi_random._rng_recvmsg
      9.96 ±  8%      -2.1        7.90 ±  3%  perf-profile.calltrace.cycles-pp._rng_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
      6.08 ±  4%      -1.9        4.14 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      6.01 ±  4%      -1.9        4.08 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      9.37 ±  5%      -1.8        7.52 ±  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      8.37 ±  8%      -1.7        6.63 ±  3%  perf-profile.calltrace.cycles-pp.jent_lfsr_time.jent_measure_jitter.jent_gen_entropy.jent_read_entropy.jent_kcapi_random
      9.11 ±  5%      -1.7        7.38 ±  3%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      4.25 ±  3%      -1.3        2.94 ±  5%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      7.37 ±  3%      -1.3        6.12 ±  3%  perf-profile.calltrace.cycles-pp.next_uptodate_page.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      6.49            -1.2        5.32 ±  3%  perf-profile.calltrace.cycles-pp.call_usermodehelper_exec_async.ret_from_fork
      6.36            -1.2        5.20 ±  3%  perf-profile.calltrace.cycles-pp.kernel_execve.call_usermodehelper_exec_async.ret_from_fork
      2.67 ±  5%      -1.0        1.68 ± 10%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      1.25 ± 12%      -1.0        0.30 ±101%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      1.35 ± 11%      -0.9        0.43 ± 72%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      4.68 ±  3%      -0.8        3.83 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      2.26 ±  3%      -0.8        1.44 ±  7%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      4.44 ±  3%      -0.8        3.63 ±  3%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      4.79 ±  2%      -0.8        3.98 ±  3%  perf-profile.calltrace.cycles-pp.bprm_execve.kernel_execve.call_usermodehelper_exec_async.ret_from_fork
      4.40 ±  3%      -0.8        3.60 ±  3%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      4.32 ±  3%      -0.8        3.54 ±  3%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      4.22 ±  2%      -0.7        3.48 ±  3%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.kernel_execve.call_usermodehelper_exec_async
      4.24 ±  2%      -0.7        3.50 ±  3%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.kernel_execve.call_usermodehelper_exec_async.ret_from_fork
      4.14 ±  2%      -0.7        3.42 ±  3%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.kernel_execve
      1.93 ±  3%      -0.6        1.28 ±  6%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.89 ±  3%      -0.6        1.25 ±  6%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      1.41 ±  5%      -0.6        0.78 ± 10%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      1.32 ±  9%      -0.6        0.74 ± 11%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      1.50 ±  4%      -0.5        0.98 ±  7%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      1.57 ± 18%      -0.5        1.10 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.55 ± 18%      -0.5        1.08 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.78 ±  2%      -0.4        1.34 ±  3%  perf-profile.calltrace.cycles-pp.call_usermodehelper_exec_work.process_one_work.worker_thread.kthread.ret_from_fork
      2.92            -0.4        2.53 ±  2%  perf-profile.calltrace.cycles-pp.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.64 ±  4%      -0.4        0.28 ±100%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.72 ±  5%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_map.load_elf_interp
      0.64 ±  7%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.sendmsg
      2.02 ±  2%      -0.3        1.68 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.02 ±  3%      -0.3        1.68 ±  3%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.41 ±  3%      -0.3        1.08 ±  3%  perf-profile.calltrace.cycles-pp.kernel_clone.user_mode_thread.call_usermodehelper_exec_work.process_one_work.worker_thread
      1.41 ±  3%      -0.3        1.08 ±  3%  perf-profile.calltrace.cycles-pp.user_mode_thread.call_usermodehelper_exec_work.process_one_work.worker_thread.kthread
      0.59 ±  4%      -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.getenv
      1.49            -0.3        1.17 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.50            -0.3        1.18 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      1.51            -0.3        1.19 ±  3%  perf-profile.calltrace.cycles-pp.__munmap
      0.68 ±  5%      -0.3        0.37 ± 71%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      1.54 ±  7%      -0.3        1.23 ±  5%  perf-profile.calltrace.cycles-pp.jent_memaccess.jent_measure_jitter.jent_gen_entropy.jent_read_entropy.jent_kcapi_random
      1.47 ±  2%      -0.3        1.16 ± 16%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.49 ±  2%      -0.3        1.18 ± 16%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75 ±  3%      -0.3        1.45 ±  4%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.41 ±  2%      -0.3        1.11 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.40 ±  2%      -0.3        1.11 ±  3%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.16 ±  4%      -0.3        0.87 ±  5%  perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.76 ±  5%      -0.3        0.47 ± 44%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_map.load_elf_interp.load_elf_binary.search_binary_handler
      1.11 ±  5%      -0.3        0.82 ±  9%  perf-profile.calltrace.cycles-pp.alloc_bprm.kernel_execve.call_usermodehelper_exec_async.ret_from_fork
      0.74 ±  6%      -0.3        0.46 ± 44%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_map.load_elf_interp.load_elf_binary
      1.07 ±  4%      -0.3        0.78 ±  5%  perf-profile.calltrace.cycles-pp.elf_map.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm
      1.03 ±  5%      -0.3        0.76 ± 10%  perf-profile.calltrace.cycles-pp.mm_init.alloc_bprm.kernel_execve.call_usermodehelper_exec_async.ret_from_fork
      1.39 ±  4%      -0.3        1.13 ±  6%  perf-profile.calltrace.cycles-pp.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.12 ±  3%      -0.3        0.86 ±  4%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.user_mode_thread.call_usermodehelper_exec_work.process_one_work
      2.00 ±  2%      -0.2        1.77 ±  2%  perf-profile.calltrace.cycles-pp._dl_addr
      0.93 ±  4%      -0.2        0.71 ±  4%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.68 ±  6%      -0.2        0.47 ± 45%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      1.48 ±  5%      -0.2        1.26 ±  6%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.75 ±  3%      -0.2        0.55 ±  3%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.user_mode_thread.call_usermodehelper_exec_work
      1.09 ±  2%      -0.2        0.90 ±  4%  perf-profile.calltrace.cycles-pp.__mmap
      1.07 ±  2%      -0.2        0.88 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.06 ±  2%      -0.2        0.88 ±  4%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.07 ±  2%      -0.2        0.88 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.04 ±  3%      -0.2        0.86 ±  4%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.86 ±  6%      -0.2        0.68 ±  9%  perf-profile.calltrace.cycles-pp.elf_map.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      1.08 ±  2%      -0.2        0.90 ±  6%  perf-profile.calltrace.cycles-pp.copy_page.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.92 ±  2%      -0.2        0.75 ±  4%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.65 ±  5%      -0.2        0.49 ± 45%  perf-profile.calltrace.cycles-pp.filemap_fault.__do_fault.do_cow_fault.do_fault.__handle_mm_fault
      0.72 ±  5%      -0.1        0.58 ±  8%  perf-profile.calltrace.cycles-pp.do_set_pte.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.76 ±  4%      -0.1        0.62 ±  6%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.94 ±  3%      -0.1        0.80 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.95 ±  3%      -0.1        0.81 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.00 ±  5%      -0.1        0.86 ±  8%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.80 ±  3%      -0.1        0.67 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96 ±  3%      -0.1        0.82 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.78 ±  4%      -0.1        0.65 ±  4%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98 ±  3%      -0.1        0.85 ±  3%  perf-profile.calltrace.cycles-pp.open64
      0.74 ±  4%      -0.1        0.61 ±  5%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.95 ±  3%      -0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.81 ±  4%      -0.1        0.69 ±  4%  perf-profile.calltrace.cycles-pp.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind
      0.81 ±  4%      -0.1        0.69 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind
      0.82 ±  4%      -0.1        0.70 ±  4%  perf-profile.calltrace.cycles-pp.bind
      0.74 ±  5%      -0.1        0.62 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81 ±  5%      -0.1        0.70 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.bind
      0.81 ±  4%      -0.1        0.70 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind
      0.80 ±  5%      -0.1        0.68 ±  5%  perf-profile.calltrace.cycles-pp.alg_bind.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.73 ±  4%      -0.1        0.62 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.41 ±  3%      -0.1        1.31 ±  3%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.67 ±  5%      -0.1        0.58 ±  7%  perf-profile.calltrace.cycles-pp.__do_fault.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.67 ±  3%      -0.1        0.60 ±  6%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.71 ±  5%      -0.1        0.66 ±  3%  perf-profile.calltrace.cycles-pp.finish_fault.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.69 ± 10%      +0.1        0.84 ±  3%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      1.28 ±  7%      +0.2        1.50 ±  3%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      1.32 ±  7%      +0.2        1.54 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      2.00 ±  5%      +0.3        2.28 ±  3%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      2.38 ±  5%      +0.3        2.71 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      2.41 ±  5%      +0.3        2.74 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.73 ±  5%      +0.4        3.13 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      3.18 ±  6%      +0.5        3.67 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.6        0.61 ±  6%  perf-profile.calltrace.cycles-pp.verify_pkcs7_message_sig.verify_pkcs7_signature.mod_verify_sig.module_sig_check.load_module
      0.00            +0.6        0.62 ±  6%  perf-profile.calltrace.cycles-pp.module_sig_check.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.62 ±  6%  perf-profile.calltrace.cycles-pp.mod_verify_sig.module_sig_check.load_module.__do_sys_finit_module.do_syscall_64
      0.00            +0.6        0.62 ±  6%  perf-profile.calltrace.cycles-pp.verify_pkcs7_signature.mod_verify_sig.module_sig_check.load_module.__do_sys_finit_module
      0.00            +0.6        0.65 ±  3%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.58 ±  5%      +0.7        4.23 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.60 ±  5%      +0.7        4.25 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      5.61 ±  5%      +0.9        6.50 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      5.88 ±  5%      +1.0        6.83 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.3        1.33 ±  7%  perf-profile.calltrace.cycles-pp.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +1.9        1.90 ± 11%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      0.00            +2.5        2.51 ±  4%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      6.02 ±  2%      +2.8        8.78 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +3.2        3.18 ±  7%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit._printk
      9.98            +3.4       13.35        perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +3.6        3.56 ±  8%  perf-profile.calltrace.cycles-pp.do_one_initcall.do_init_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.8        3.82 ±  8%  perf-profile.calltrace.cycles-pp.do_init_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     12.24 ±  3%      +4.3       16.55        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     12.51 ±  3%      +4.4       16.96        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.43 ±  3%      +4.6        7.98 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
     13.69 ±  3%      +4.7       18.35        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     13.69 ±  3%      +4.7       18.35        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     13.67 ±  3%      +4.7       18.33        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.68 ±  2%      +4.7        7.34 ±  3%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      2.38 ±  3%      +4.7        7.05 ±  3%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +4.7        4.67 ±  3%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
     13.10 ±  3%      +4.7       17.80        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     13.93 ±  3%      +4.7       18.65        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +4.7        4.73 ±  3%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      0.00            +4.7        4.73 ±  3%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      0.00            +4.7        4.73 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      0.00            +4.7        4.74 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      0.00            +4.8        4.76 ±  3%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
      0.00            +4.8        4.76 ±  3%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      0.00            +4.8        4.79 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.00            +4.8        4.80 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.00            +4.8        4.80 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.00            +5.2        5.18 ±  7%  perf-profile.calltrace.cycles-pp.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +5.2        5.19 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +5.2        5.19 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +5.2        5.19 ±  7%  perf-profile.calltrace.cycles-pp.syscall
      0.00            +5.4        5.38 ±  3%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +5.4        5.38 ±  3%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
     49.25 ±  2%      -4.4       44.89        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     49.19 ±  2%      -4.3       44.84        perf-profile.children.cycles-pp.do_syscall_64
     12.99 ±  2%      -3.6        9.34 ±  4%  perf-profile.children.cycles-pp.vm_mmap_pgoff
     12.84 ±  2%      -3.6        9.21 ±  4%  perf-profile.children.cycles-pp.do_mmap
     12.50 ±  2%      -3.6        8.91 ±  4%  perf-profile.children.cycles-pp.mmap_region
     10.87 ±  3%      -3.2        7.67 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
     21.46 ±  2%      -2.9       18.51        perf-profile.children.cycles-pp.asm_exc_page_fault
     20.13 ±  2%      -2.8       17.30        perf-profile.children.cycles-pp.exc_page_fault
     20.06 ±  2%      -2.8       17.25        perf-profile.children.cycles-pp.do_user_addr_fault
     18.96 ±  2%      -2.7       16.28 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
     18.50 ±  2%      -2.6       15.88 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
      8.98 ±  3%      -2.6        6.42 ±  3%  perf-profile.children.cycles-pp.do_vmi_munmap
     10.39            -2.6        7.84 ±  3%  perf-profile.children.cycles-pp.do_group_exit
     10.39            -2.5        7.84 ±  3%  perf-profile.children.cycles-pp.__x64_sys_exit_group
     10.37            -2.5        7.83 ±  3%  perf-profile.children.cycles-pp.do_exit
      8.82 ±  3%      -2.5        6.30 ±  3%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      4.66 ±  7%      -2.5        2.19 ± 16%  perf-profile.children.cycles-pp.down_write
     15.37 ±  2%      -2.4       12.93 ±  2%  perf-profile.children.cycles-pp.do_fault
      9.35            -2.4        6.96 ±  4%  perf-profile.children.cycles-pp.exit_mm
      9.32            -2.4        6.94 ±  4%  perf-profile.children.cycles-pp.__mmput
      9.29            -2.4        6.90 ±  3%  perf-profile.children.cycles-pp.exit_mmap
      3.93 ±  9%      -2.3        1.64 ± 18%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      3.74 ±  9%      -2.2        1.55 ± 19%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     10.28 ±  8%      -2.1        8.16 ±  3%  perf-profile.children.cycles-pp.jent_gen_entropy
     10.27 ±  8%      -2.1        8.16 ±  3%  perf-profile.children.cycles-pp.jent_measure_jitter
      9.96 ±  8%      -2.1        7.90 ±  3%  perf-profile.children.cycles-pp.jent_kcapi_random
      9.96 ±  8%      -2.1        7.90 ±  3%  perf-profile.children.cycles-pp.jent_read_entropy
      9.96 ±  8%      -2.1        7.90 ±  3%  perf-profile.children.cycles-pp._rng_recvmsg
     12.31 ±  3%      -2.0       10.28 ±  3%  perf-profile.children.cycles-pp.do_read_fault
     12.18 ±  3%      -2.0       10.16 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      8.64 ±  8%      -1.8        6.85 ±  3%  perf-profile.children.cycles-pp.jent_lfsr_time
     10.05 ±  3%      -1.6        8.42 ±  3%  perf-profile.children.cycles-pp.next_uptodate_page
      5.94 ±  2%      -1.6        4.30 ±  5%  perf-profile.children.cycles-pp.__split_vma
      3.62 ±  4%      -1.5        2.14 ±  9%  perf-profile.children.cycles-pp.free_pgtables
      3.81 ±  4%      -1.3        2.49 ±  9%  perf-profile.children.cycles-pp.vma_prepare
      2.60 ±  6%      -1.2        1.37 ± 13%  perf-profile.children.cycles-pp.unlink_file_vma
      2.24 ±  5%      -1.2        1.03 ± 17%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      6.49            -1.2        5.32 ±  3%  perf-profile.children.cycles-pp.call_usermodehelper_exec_async
      6.36            -1.2        5.20 ±  3%  perf-profile.children.cycles-pp.kernel_execve
      2.98 ±  4%      -1.0        2.00 ±  4%  perf-profile.children.cycles-pp.unmap_region
      5.35 ±  2%      -1.0        4.39 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      5.05 ±  2%      -0.9        4.15 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      4.97 ±  3%      -0.9        4.08 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
      4.92 ±  2%      -0.9        4.04 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
      1.33 ± 19%      -0.8        0.48 ± 28%  perf-profile.children.cycles-pp.osq_lock
      4.88 ±  2%      -0.8        4.07 ±  3%  perf-profile.children.cycles-pp.bprm_execve
      2.60            -0.8        1.82 ±  4%  perf-profile.children.cycles-pp.tlb_finish_mmu
      4.28 ±  2%      -0.7        3.56 ±  4%  perf-profile.children.cycles-pp.exec_binprm
      4.26 ±  2%      -0.7        3.54 ±  4%  perf-profile.children.cycles-pp.search_binary_handler
      4.18 ±  2%      -0.7        3.48 ±  4%  perf-profile.children.cycles-pp.load_elf_binary
      2.02 ±  2%      -0.7        1.36 ±  6%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      2.78 ±  4%      -0.5        2.24 ±  7%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      1.62 ±  4%      -0.5        1.09 ±  7%  perf-profile.children.cycles-pp.release_pages
      2.45 ±  3%      -0.5        1.94 ±  3%  perf-profile.children.cycles-pp.__vm_munmap
      1.94 ±  5%      -0.5        1.48 ±  6%  perf-profile.children.cycles-pp.elf_map
      1.78 ±  2%      -0.4        1.34 ±  3%  perf-profile.children.cycles-pp.call_usermodehelper_exec_work
      3.03            -0.4        2.64        perf-profile.children.cycles-pp.do_cow_fault
      1.91 ±  3%      -0.4        1.53 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
      1.17 ±  3%      -0.4        0.79 ±  7%  perf-profile.children.cycles-pp.up_write
      0.66 ± 13%      -0.4        0.31 ± 12%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.02 ±  2%      -0.3        1.68 ±  3%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      2.02 ±  3%      -0.3        1.68 ±  3%  perf-profile.children.cycles-pp.do_mprotect_pkey
      1.41 ±  3%      -0.3        1.08 ±  3%  perf-profile.children.cycles-pp.user_mode_thread
      1.58 ±  4%      -0.3        1.26 ±  3%  perf-profile.children.cycles-pp.vma_complete
      1.46 ±  2%      -0.3        1.14 ±  3%  perf-profile.children.cycles-pp.kernel_clone
      1.52 ±  2%      -0.3        1.20 ±  3%  perf-profile.children.cycles-pp.__munmap
      1.59 ±  7%      -0.3        1.27 ±  5%  perf-profile.children.cycles-pp.jent_memaccess
      1.76 ±  3%      -0.3        1.46 ±  4%  perf-profile.children.cycles-pp.mprotect_fixup
      1.12 ±  5%      -0.3        0.83 ±  9%  perf-profile.children.cycles-pp.alloc_bprm
      1.17 ±  4%      -0.3        0.88 ±  5%  perf-profile.children.cycles-pp.load_elf_interp
      1.96 ±  3%      -0.3        1.68        perf-profile.children.cycles-pp.__x64_sys_openat
      1.94 ±  3%      -0.3        1.67        perf-profile.children.cycles-pp.do_sys_openat2
      1.04 ±  5%      -0.3        0.77 ± 10%  perf-profile.children.cycles-pp.mm_init
      2.01 ±  2%      -0.3        1.74        perf-profile.children.cycles-pp.do_filp_open
      1.99 ±  2%      -0.3        1.72        perf-profile.children.cycles-pp.path_openat
      1.16 ±  2%      -0.3        0.90 ±  4%  perf-profile.children.cycles-pp.copy_process
      2.08            -0.2        1.84 ±  4%  perf-profile.children.cycles-pp.mas_store_prealloc
      2.02 ±  2%      -0.2        1.78 ±  2%  perf-profile.children.cycles-pp._dl_addr
      0.82 ±  5%      -0.2        0.57 ± 12%  perf-profile.children.cycles-pp.pcpu_alloc
      0.85            -0.2        0.61 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.29 ±  2%      -0.2        1.05 ±  6%  perf-profile.children.cycles-pp.do_set_pte
      2.10 ±  2%      -0.2        1.87 ±  2%  perf-profile.children.cycles-pp.__do_softirq
      1.63 ±  4%      -0.2        1.40 ±  5%  perf-profile.children.cycles-pp.page_remove_rmap
      1.18 ±  4%      -0.2        0.95        perf-profile.children.cycles-pp.mas_alloc_nodes
      0.65 ±  4%      -0.2        0.43 ± 11%  perf-profile.children.cycles-pp.__percpu_counter_init
      0.68 ±  6%      -0.2        0.46 ±  2%  perf-profile.children.cycles-pp.vma_expand
      1.08 ±  4%      -0.2        0.86        perf-profile.children.cycles-pp.mas_preallocate
      2.14 ±  2%      -0.2        1.93        perf-profile.children.cycles-pp._raw_spin_lock
      0.95 ±  2%      -0.2        0.74 ±  6%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.65 ±  3%      -0.2        0.45 ±  2%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.76 ±  3%      -0.2        0.56 ±  2%  perf-profile.children.cycles-pp.dup_task_struct
      1.09 ±  2%      -0.2        0.90 ±  5%  perf-profile.children.cycles-pp.__mmap
      0.41 ±  5%      -0.2        0.22 ±  5%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      1.11 ±  2%      -0.2        0.93 ±  6%  perf-profile.children.cycles-pp.copy_page
      1.38 ±  2%      -0.2        1.22 ±  2%  perf-profile.children.cycles-pp.rcu_core
      0.36 ±  7%      -0.2        0.20 ± 10%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.60 ±  3%      -0.2        0.44 ±  3%  perf-profile.children.cycles-pp.__vmalloc_node_range
      1.26 ±  2%      -0.2        1.10 ±  2%  perf-profile.children.cycles-pp.rcu_do_batch
      0.65 ±  4%      -0.2        0.50 ±  4%  perf-profile.children.cycles-pp.stress_mwc8
      0.94 ±  5%      -0.1        0.80 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.31 ±  7%      -0.1        0.17 ± 13%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.37 ±  8%      -0.1        0.23 ±  8%  perf-profile.children.cycles-pp.delayed_vfree_work
      1.79 ±  3%      -0.1        1.65 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.68 ±  6%      -0.1        0.55 ±  8%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.99 ±  3%      -0.1        0.85 ±  2%  perf-profile.children.cycles-pp.open64
      0.77 ±  4%      -0.1        0.64 ±  6%  perf-profile.children.cycles-pp.begin_new_exec
      0.56 ±  5%      -0.1        0.43 ±  8%  perf-profile.children.cycles-pp.exec_mmap
      0.51 ±  5%      -0.1        0.38 ±  5%  perf-profile.children.cycles-pp.__fput
      0.66 ±  3%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.41 ±  5%      -0.1        0.28 ± 10%  perf-profile.children.cycles-pp.free_swap_cache
      0.64 ±  7%      -0.1        0.52 ±  9%  perf-profile.children.cycles-pp.sendmsg
      0.58 ±  4%      -0.1        0.45 ±  4%  perf-profile.children.cycles-pp.task_work_run
      0.53 ±  5%      -0.1        0.41 ±  6%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.53 ±  8%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.56 ±  7%      -0.1        0.44 ±  8%  perf-profile.children.cycles-pp.___sys_sendmsg
      0.42 ±  4%      -0.1        0.30 ±  8%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.81 ±  4%      -0.1        0.69 ±  5%  perf-profile.children.cycles-pp.__x64_sys_bind
      0.81 ±  4%      -0.1        0.69 ±  5%  perf-profile.children.cycles-pp.__sys_bind
      0.52 ±  7%      -0.1        0.40 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.06 ±  2%      -0.1        0.94 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap
      0.80 ±  5%      -0.1        0.68 ±  5%  perf-profile.children.cycles-pp.alg_bind
      1.02 ±  2%      -0.1        0.91 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.57 ±  5%      -0.1        0.46 ±  4%  perf-profile.children.cycles-pp.flush_tlb_func
      0.82 ±  4%      -0.1        0.71 ±  4%  perf-profile.children.cycles-pp.bind
      0.48 ±  9%      -0.1        0.36 ±  9%  perf-profile.children.cycles-pp.stress_rndbuf
      0.32 ±  8%      -0.1        0.21 ±  8%  perf-profile.children.cycles-pp.remove_vm_area
      0.75 ±  5%      -0.1        0.64 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.32 ±  5%      -0.1        0.21 ± 21%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.36 ±  5%      -0.1        0.25 ±  9%  perf-profile.children.cycles-pp.kernel_wait
      0.63 ±  4%      -0.1        0.53 ±  5%  perf-profile.children.cycles-pp.open_last_lookups
      0.36 ±  5%      -0.1        0.26 ±  8%  perf-profile.children.cycles-pp.do_wait
      0.78 ±  5%      -0.1        0.68 ±  3%  perf-profile.children.cycles-pp.mas_store_gfp
      0.68 ±  6%      -0.1        0.58 ±  4%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.47 ±  7%      -0.1        0.37 ±  6%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.43 ±  7%      -0.1        0.33 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.18 ± 15%      -0.1        0.08 ± 26%  perf-profile.children.cycles-pp.__rb_erase_color
      0.74 ±  5%      -0.1        0.65 ±  6%  perf-profile.children.cycles-pp.__do_fault
      0.65 ±  3%      -0.1        0.55 ±  5%  perf-profile.children.cycles-pp.__slab_free
      0.63 ±  3%      -0.1        0.54 ±  5%  perf-profile.children.cycles-pp.mas_destroy
      0.69 ±  4%      -0.1        0.59 ±  9%  perf-profile.children.cycles-pp.filemap_fault
      0.72 ±  3%      -0.1        0.63 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
      1.06 ±  3%      -0.1        0.97 ±  4%  perf-profile.children.cycles-pp.__schedule
      0.46 ±  5%      -0.1        0.36 ±  7%  perf-profile.children.cycles-pp.filename_lookup
      0.62 ±  3%      -0.1        0.53 ±  6%  perf-profile.children.cycles-pp.getenv
      0.38 ±  3%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.45 ±  5%      -0.1        0.36 ±  6%  perf-profile.children.cycles-pp.path_lookupat
      0.51 ±  4%      -0.1        0.42 ± 10%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.49 ±  5%      -0.1        0.40 ± 10%  perf-profile.children.cycles-pp.__mmdrop
      0.38 ±  3%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.lru_add_drain
      0.51 ±  4%      -0.1        0.42 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.69 ±  7%      -0.1        0.60 ±  5%  perf-profile.children.cycles-pp.mtree_range_walk
      0.69 ±  5%      -0.1        0.60 ±  6%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.62 ±  2%      -0.1        0.53 ±  7%  perf-profile.children.cycles-pp.do_open
      0.50 ±  3%      -0.1        0.42 ±  4%  perf-profile.children.cycles-pp.vfs_fstatat
      0.48 ±  3%      -0.1        0.40 ±  9%  perf-profile.children.cycles-pp.do_dentry_open
      0.41 ±  8%      -0.1        0.33 ± 12%  perf-profile.children.cycles-pp.___slab_alloc
      0.47 ±  6%      -0.1        0.39 ±  8%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.57 ±  7%      -0.1        0.49 ±  6%  perf-profile.children.cycles-pp.mas_walk
      0.70 ±  5%      -0.1        0.63 ±  5%  perf-profile.children.cycles-pp.crypto_alloc_tfm_node
      0.32 ±  4%      -0.1        0.24 ± 11%  perf-profile.children.cycles-pp.lru_add_fn
      0.50 ±  4%      -0.1        0.43 ± 11%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.42 ±  5%      -0.1        0.35 ±  5%  perf-profile.children.cycles-pp.vfs_statx
      0.52 ±  5%      -0.1        0.44 ±  4%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.45            -0.1        0.38 ±  6%  perf-profile.children.cycles-pp.rebalance_domains
      0.11 ± 13%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.free_vmap_area_noflush
      0.30 ±  7%      -0.1        0.23 ± 13%  perf-profile.children.cycles-pp.getopt_long
      0.27            -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.dput
      0.28 ± 11%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.getdents64
      0.41 ±  3%      -0.1        0.34 ±  6%  perf-profile.children.cycles-pp.__xstat64
      0.27 ± 12%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.64 ±  6%      -0.1        0.57 ±  6%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.33 ±  9%      -0.1        0.27 ±  4%  perf-profile.children.cycles-pp.mas_find
      0.25 ± 12%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.__close_nocancel
      0.44 ±  4%      -0.1        0.38 ± 10%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.39 ±  6%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.walk_component
      0.40 ±  6%      -0.1        0.34 ±  8%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.25 ± 10%      -0.1        0.19 ±  3%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.26 ± 11%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.iterate_dir
      0.16 ±  7%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.28 ±  6%      -0.1        0.22 ± 11%  perf-profile.children.cycles-pp.wake_up_new_task
      0.46 ±  3%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.mas_split
      0.38 ±  4%      -0.1        0.33 ±  5%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.34 ±  6%      -0.1        0.28 ±  5%  perf-profile.children.cycles-pp.crypto_create_tfm_node
      0.22 ±  8%      -0.1        0.16 ± 18%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.30 ±  6%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      0.42 ±  4%      -0.1        0.36 ± 11%  perf-profile.children.cycles-pp.find_idlest_group
      0.36 ±  5%      -0.1        0.31 ±  5%  perf-profile.children.cycles-pp.step_into
      0.17 ± 12%      -0.1        0.12 ± 18%  perf-profile.children.cycles-pp.vfs_fstat
      0.36 ±  6%      -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.__getrlimit
      0.32 ±  6%      -0.1        0.26 ±  6%  perf-profile.children.cycles-pp.jent_kcapi_init
      0.32 ±  6%      -0.1        0.26 ±  6%  perf-profile.children.cycles-pp.jent_entropy_collector_alloc
      0.27 ±  5%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.touch_atime
      0.15 ±  8%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.security_file_alloc
      0.32 ±  6%      -0.1        0.27 ±  6%  perf-profile.children.cycles-pp.rng_bind
      0.20 ± 10%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.wait_task_zombie
      0.22 ±  5%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.folio_add_lru_vma
      0.16 ±  8%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.74 ±  4%      -0.0        0.69 ±  3%  perf-profile.children.cycles-pp.finish_fault
      0.26 ±  8%      -0.0        0.22 ±  7%  perf-profile.children.cycles-pp.xas_find
      0.18 ± 12%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.find_unlink_vmap_area
      0.16 ±  3%      -0.0        0.11 ± 17%  perf-profile.children.cycles-pp.__wake_up_common
      0.26 ±  8%      -0.0        0.21 ± 11%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.18 ±  8%      -0.0        0.14 ± 14%  perf-profile.children.cycles-pp._compound_head
      0.49 ±  3%      -0.0        0.44 ±  4%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.20 ±  9%      -0.0        0.15 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
      0.23 ±  6%      -0.0        0.18 ±  8%  perf-profile.children.cycles-pp.unmap_single_vma
      0.18 ± 12%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.put_cred_rcu
      0.10 ±  8%      -0.0        0.06 ± 52%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.32 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.18 ±  8%      -0.0        0.13 ± 14%  perf-profile.children.cycles-pp.do_wp_page
      0.15 ±  3%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.percpu_counter_destroy
      0.12 ± 11%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.11 ±  9%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.08 ± 14%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.security_inode_getattr
      0.17 ± 10%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.release_task
      0.30 ±  6%      -0.0        0.26 ±  9%  perf-profile.children.cycles-pp.wmemchr
      0.37 ±  3%      -0.0        0.33 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      0.28 ±  7%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.vm_area_dup
      0.17 ± 12%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.try_to_unlazy
      0.15 ± 11%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.free_percpu
      0.31 ±  4%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.mas_next_entry
      0.16 ±  5%      -0.0        0.12 ± 12%  perf-profile.children.cycles-pp.__fxstatat64
      0.12 ± 15%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.atime_needs_update
      0.15 ±  7%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.userfaultfd_unmap_prep
      0.23 ±  7%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.pick_link
      0.16 ±  8%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.dcache_readdir
      0.16 ± 10%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__crypto_xor
      0.17 ±  8%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.__pthread_initialize_minimal_internal
      0.12 ±  8%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__lookup_slow
      0.22 ±  5%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.d_path
      0.14 ±  4%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.11 ± 12%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.22 ±  6%      -0.0        0.19 ±  6%  perf-profile.children.cycles-pp.vm_area_alloc
      0.09 ±  8%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.12 ±  8%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.af_alg_get_rsgl
      0.14 ±  4%      -0.0        0.12 ± 10%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.12 ±  8%      -0.0        0.09 ± 11%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.18 ±  4%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.14 ±  6%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.13 ±  5%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.folio_test_hugetlb
      0.10 ±  4%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.07 ± 11%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.dentry_kill
      0.08 ±  6%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.check_heap_object
      0.10 ±  6%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.09 ±  9%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.06 ±  9%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.ct_idle_exit
      0.08 ± 12%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.finish_task_switch
      0.12 ± 12%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.16 ±  4%      +0.0        0.20 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.17 ± 10%      +0.0        0.20 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      0.11 ±  9%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.16 ± 10%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.17 ± 45%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.xts_decrypt
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.camellia_decrypt_cbc_2way
      0.11 ± 10%      +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.trace_module_notify
      0.01 ±223%      +0.1        0.09 ± 16%  perf-profile.children.cycles-pp.shmem_read_folio_gfp
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.__serpent_enc_blk8_avx
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.serpent_ecb_enc_8way_avx
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.serpent_ecb_dec_8way_avx
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.shash_digest_unaligned
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.shash_update_unaligned
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp._sha256_update
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.sha256_base_do_update
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.sha256_ni_transform
      0.01 ±223%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.shmem_read_mapping_page_gfp
      0.01 ±223%      +0.1        0.10 ± 16%  perf-profile.children.cycles-pp.drm_gem_get_pages
      0.01 ±223%      +0.1        0.10 ± 16%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages
      0.01 ±223%      +0.1        0.10 ± 16%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages_locked
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.drm_client_buffer_vmap
      0.01 ±223%      +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.mpihelp_addmul_1
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.mpih_sqr_n_basecase
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.blocking_notifier_call_chain
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.notifier_call_chain
      0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.early_mod_check
      0.01 ±223%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.drm_gem_shmem_object_vmap
      0.01 ±223%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.drm_gem_shmem_vmap_locked
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.pkcs7_verify
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.pkcs7_digest
      0.01 ±223%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.drm_gem_vmap_unlocked
      0.01 ±223%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.drm_gem_vmap
      0.00            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.__camellia_enc_blk_2way
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.38 ± 45%      +0.1        0.50 ±  3%  perf-profile.children.cycles-pp.ecb_encrypt
      0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.__serpent_dec_blk8_avx
      0.39 ± 44%      +0.1        0.52 ±  5%  perf-profile.children.cycles-pp.ecb_decrypt
      0.00            +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.free_module
      0.00            +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.io_serial_out
      0.03 ±103%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.__mutex_lock
      0.00            +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.mpih_sqr_n
      0.00            +0.1        0.14 ± 14%  perf-profile.children.cycles-pp.native_flush_tlb_global
      0.00            +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.__flush_tlb_all
      0.00            +0.2        0.15 ± 15%  perf-profile.children.cycles-pp.fast_imageblit
      0.00            +0.2        0.16 ± 15%  perf-profile.children.cycles-pp.sys_imageblit
      0.88 ±  8%      +0.2        1.04 ±  4%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.2        0.18 ±  7%  perf-profile.children.cycles-pp.camellia_dec_blk_2way
      1.59 ±  7%      +0.2        1.77 ±  3%  perf-profile.children.cycles-pp.perf_event_task_tick
      1.57 ±  7%      +0.2        1.75 ±  3%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.46 ±  6%      +0.2        0.66 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.2        0.20 ± 15%  perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.00            +0.2        0.20 ± 17%  perf-profile.children.cycles-pp.flush_tlb_kernel_range
      0.00            +0.2        0.22 ± 17%  perf-profile.children.cycles-pp.fbcon_putcs
      0.00            +0.2        0.22 ± 17%  perf-profile.children.cycles-pp.bit_putcs
      0.00            +0.2        0.24 ± 16%  perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.lf
      0.00            +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.con_scroll
      0.00            +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.vt_console_print
      0.00            +0.3        0.30 ± 10%  perf-profile.children.cycles-pp.mpihelp_submul_1
      0.00            +0.3        0.33 ±  8%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.00            +0.3        0.33 ±  8%  perf-profile.children.cycles-pp.mpihelp_divrem
      0.00            +0.4        0.36 ±  8%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.94 ±  6%      +0.4        4.32 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.4        0.39 ± 30%  perf-profile.children.cycles-pp.set_memory_ro
      0.00            +0.4        0.40 ± 31%  perf-profile.children.cycles-pp.module_enable_ro
      0.00            +0.4        0.42 ±  9%  perf-profile.children.cycles-pp.sysvec_call_function
      0.00            +0.4        0.42 ± 28%  perf-profile.children.cycles-pp.change_page_attr_set_clr
      0.25 ±  5%      +0.4        0.69 ±  4%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.4        0.45 ±  5%  perf-profile.children.cycles-pp.drm_fbdev_generic_damage_blit_real
      0.00            +0.5        0.46 ± 23%  perf-profile.children.cycles-pp.__purge_vmap_area_lazy
      0.00            +0.5        0.48 ±  6%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.5        0.48 ±  6%  perf-profile.children.cycles-pp.mpi_powm
      0.00            +0.5        0.48 ±  6%  perf-profile.children.cycles-pp.pkcs1pad_verify
      0.00            +0.5        0.48 ±  6%  perf-profile.children.cycles-pp.rsa_enc
      0.00            +0.5        0.49 ± 24%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.00            +0.5        0.50 ±  5%  perf-profile.children.cycles-pp.public_key_verify_signature
      0.00            +0.5        0.50 ± 23%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.00            +0.5        0.50 ±  5%  perf-profile.children.cycles-pp.pkcs7_validate_trust
      0.00            +0.5        0.50 ±  5%  perf-profile.children.cycles-pp.pkcs7_validate_trust_one
      0.00            +0.5        0.51 ± 18%  perf-profile.children.cycles-pp._vm_unmap_aliases
      0.00            +0.5        0.52 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      4.44 ±  5%      +0.5        4.97 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      4.42 ±  5%      +0.5        4.95 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +0.6        0.61 ±  6%  perf-profile.children.cycles-pp.verify_pkcs7_message_sig
      0.00            +0.6        0.62 ±  6%  perf-profile.children.cycles-pp.module_sig_check
      0.00            +0.6        0.62 ±  6%  perf-profile.children.cycles-pp.mod_verify_sig
      0.00            +0.6        0.62 ±  6%  perf-profile.children.cycles-pp.verify_pkcs7_signature
      6.73 ±  5%      +0.7        7.45 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.01 ±223%      +0.8        0.76 ± 21%  perf-profile.children.cycles-pp.delay_tsc
      7.07 ±  5%      +0.8        7.89 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +1.3        1.33 ±  7%  perf-profile.children.cycles-pp.load_module
      0.14 ± 23%      +2.4        2.50 ± 11%  perf-profile.children.cycles-pp.io_serial_in
      6.13 ±  2%      +2.8        8.90 ±  2%  perf-profile.children.cycles-pp.intel_idle
      0.18 ± 18%      +3.1        3.26 ±  7%  perf-profile.children.cycles-pp.wait_for_lsr
      0.18 ± 18%      +3.2        3.40 ±  7%  perf-profile.children.cycles-pp.serial8250_console_write
      9.98            +3.4       13.36        perf-profile.children.cycles-pp.ret_from_fork
      0.19 ± 18%      +3.5        3.66 ±  7%  perf-profile.children.cycles-pp.console_flush_all
      0.19 ± 18%      +3.5        3.66 ±  7%  perf-profile.children.cycles-pp.console_unlock
      0.00            +3.6        3.56 ±  8%  perf-profile.children.cycles-pp.do_one_initcall
      0.19 ± 18%      +3.6        3.80 ±  7%  perf-profile.children.cycles-pp._printk
      0.19 ± 18%      +3.6        3.80 ±  7%  perf-profile.children.cycles-pp.vprintk_emit
      0.00            +3.8        3.82 ±  8%  perf-profile.children.cycles-pp.do_init_module
     12.69 ±  3%      +4.5       17.19        perf-profile.children.cycles-pp.cpuidle_enter_state
     12.72 ±  3%      +4.5       17.24        perf-profile.children.cycles-pp.cpuidle_enter
      3.43 ±  3%      +4.6        7.98 ±  3%  perf-profile.children.cycles-pp.kthread
     13.69 ±  3%      +4.7       18.35        perf-profile.children.cycles-pp.start_secondary
      2.68 ±  2%      +4.7        7.34 ±  3%  perf-profile.children.cycles-pp.worker_thread
      2.38 ±  3%      +4.7        7.05 ±  3%  perf-profile.children.cycles-pp.process_one_work
      0.05 ± 48%      +4.7        4.73 ±  3%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.05 ± 48%      +4.7        4.73 ±  3%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.05 ± 48%      +4.7        4.73 ±  3%  perf-profile.children.cycles-pp.memcpy_toio
      0.05 ± 48%      +4.7        4.73 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.06 ± 47%      +4.7        4.74 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.06 ± 21%      +4.7        4.76 ±  3%  perf-profile.children.cycles-pp.commit_tail
      0.06 ± 21%      +4.7        4.76 ±  3%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.08 ± 32%      +4.7        4.80 ±  3%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.08 ± 32%      +4.7        4.79 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
     13.93 ±  3%      +4.7       18.65        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     13.93 ±  3%      +4.7       18.65        perf-profile.children.cycles-pp.cpu_startup_entry
      0.08 ± 32%      +4.7        4.80 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
     13.92 ±  3%      +4.7       18.65        perf-profile.children.cycles-pp.do_idle
     13.34 ±  3%      +4.8       18.10        perf-profile.children.cycles-pp.cpuidle_idle_call
      0.00            +5.2        5.18 ±  7%  perf-profile.children.cycles-pp.__do_sys_finit_module
      0.00            +5.2        5.19 ±  7%  perf-profile.children.cycles-pp.syscall
      0.11 ± 20%      +5.3        5.38 ±  3%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.11 ± 20%      +5.3        5.38 ±  3%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      8.53 ±  8%      -1.8        6.76 ±  3%  perf-profile.self.cycles-pp.jent_lfsr_time
      9.90 ±  3%      -1.6        8.32 ±  3%  perf-profile.self.cycles-pp.next_uptodate_page
      2.19 ±  5%      -1.2        1.02 ± 17%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.30 ± 18%      -0.8        0.48 ± 29%  perf-profile.self.cycles-pp.osq_lock
      2.99 ±  2%      -0.6        2.37        perf-profile.self.cycles-pp.zap_pte_range
      2.75 ±  4%      -0.5        2.20 ±  6%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      1.14 ±  3%      -0.4        0.78 ±  6%  perf-profile.self.cycles-pp.up_write
      0.66 ± 13%      -0.4        0.30 ± 11%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.54 ±  8%      -0.3        1.23 ±  6%  perf-profile.self.cycles-pp.jent_memaccess
      0.95 ±  4%      -0.3        0.67 ±  7%  perf-profile.self.cycles-pp.release_pages
      1.72 ±  2%      -0.2        1.50 ±  2%  perf-profile.self.cycles-pp._dl_addr
      1.47 ±  5%      -0.2        1.25 ±  6%  perf-profile.self.cycles-pp.page_remove_rmap
      0.94 ±  2%      -0.2        0.73 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.68            -0.2        0.49 ±  9%  perf-profile.self.cycles-pp.down_write
      1.09 ±  4%      -0.2        0.92 ±  6%  perf-profile.self.cycles-pp.copy_page
      0.82 ±  6%      -0.2        0.67 ±  4%  perf-profile.self.cycles-pp.filemap_map_pages
      0.37 ±  4%      -0.1        0.25 ± 11%  perf-profile.self.cycles-pp.free_swap_cache
      0.50 ±  4%      -0.1        0.39        perf-profile.self.cycles-pp.stress_mwc8
      0.18 ± 10%      -0.1        0.08 ± 18%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.29 ±  4%      -0.1        0.20 ± 20%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.28 ±  5%      -0.1        0.18 ± 17%  perf-profile.self.cycles-pp.pcpu_alloc
      0.67 ±  7%      -0.1        0.58 ±  3%  perf-profile.self.cycles-pp.mtree_range_walk
      0.63 ±  3%      -0.1        0.54 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.46 ±  6%      -0.1        0.37 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.41 ±  6%      -0.1        0.32 ±  6%  perf-profile.self.cycles-pp.mmap_region
      0.16 ± 14%      -0.1        0.08 ± 26%  perf-profile.self.cycles-pp.__rb_erase_color
      0.40 ±  4%      -0.1        0.32 ±  7%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.44 ±  4%      -0.1        0.37 ±  7%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.52 ±  5%      -0.1        0.44 ±  4%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.51 ±  4%      -0.1        0.44 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.30 ± 12%      -0.1        0.24 ± 14%  perf-profile.self.cycles-pp.stress_rndbuf
      0.16 ±  7%      -0.1        0.10 ± 14%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.22 ± 10%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.27 ±  7%      -0.1        0.22 ±  9%  perf-profile.self.cycles-pp.___slab_alloc
      0.27 ±  5%      -0.1        0.22 ± 12%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.20 ± 10%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.12 ± 11%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.22 ±  7%      -0.0        0.17 ±  8%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.07 ± 17%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.apparmor_file_open
      0.43 ±  3%      -0.0        0.38 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.15 ±  9%      -0.0        0.10 ± 17%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.22 ± 10%      -0.0        0.17 ±  8%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.22 ±  9%      -0.0        0.17 ±  9%  perf-profile.self.cycles-pp.do_dentry_open
      0.10 ±  8%      -0.0        0.05 ± 50%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.30 ±  6%      -0.0        0.26 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.12 ±  7%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.filemap_read
      0.16 ±  9%      -0.0        0.12 ± 16%  perf-profile.self.cycles-pp._compound_head
      0.32 ±  5%      -0.0        0.28 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
      0.22 ±  8%      -0.0        0.18 ± 12%  perf-profile.self.cycles-pp.unmap_single_vma
      0.13 ± 14%      -0.0        0.09 ± 19%  perf-profile.self.cycles-pp.__fput
      0.12 ±  8%      -0.0        0.08 ± 20%  perf-profile.self.cycles-pp.alloc_vmap_area
      0.28 ±  6%      -0.0        0.24 ±  4%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.09 ± 12%      -0.0        0.06 ± 46%  perf-profile.self.cycles-pp.xas_start
      0.10 ± 11%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.10 ± 13%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.__schedule
      0.14 ±  9%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__crypto_xor
      0.07 ± 14%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.mas_spanning_rebalance
      0.10 ±  9%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.folio_test_hugetlb
      0.07 ± 16%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.16 ±  6%      +0.0        0.19 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.11 ± 12%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.trace_module_notify
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__serpent_enc_blk8_avx
      0.00            +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.sha256_ni_transform
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.mpihelp_addmul_1
      0.20 ±  6%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.__camellia_enc_blk_2way
      0.00            +0.1        0.12 ± 20%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.00            +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.__serpent_dec_blk8_avx
      0.00            +0.1        0.13 ± 13%  perf-profile.self.cycles-pp.io_serial_out
      0.00            +0.1        0.14 ± 23%  perf-profile.self.cycles-pp.vprintk_emit
      0.00            +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.native_flush_tlb_global
      0.00            +0.2        0.15 ± 15%  perf-profile.self.cycles-pp.fast_imageblit
      0.88 ±  8%      +0.2        1.04 ±  4%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.2        0.18 ±  5%  perf-profile.self.cycles-pp.camellia_dec_blk_2way
      0.34 ±  5%      +0.2        0.56 ±  3%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.3        0.29 ± 10%  perf-profile.self.cycles-pp.mpihelp_submul_1
      0.24 ±  6%      +0.4        0.68 ±  4%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.5        0.46 ± 25%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.01 ±223%      +0.8        0.76 ± 21%  perf-profile.self.cycles-pp.delay_tsc
      0.14 ± 23%      +2.4        2.49 ± 11%  perf-profile.self.cycles-pp.io_serial_in
      6.13 ±  2%      +2.8        8.90 ±  2%  perf-profile.self.cycles-pp.intel_idle
      0.05 ± 48%      +4.7        4.71 ±  3%  perf-profile.self.cycles-pp.memcpy_toio




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--GnpOZ+qGXYIRlwek
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc2-00017-gb81fac906a8f"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--GnpOZ+qGXYIRlwek
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh

export_top_env()
{
	export suite=3D'stress-ng'
	export testcase=3D'stress-ng'
	export category=3D'benchmark'
	export nr_threads=3D6
	export testtime=3D60
	export job_origin=3D'stress-ng-class-os.yaml'
	export queue_cmdline_keys=3D
	export queue=3D'int'
	export testbox=3D'lkp-icl-2sp7'
	export tbox_group=3D'lkp-icl-2sp7'
	export branch=3D'linus/master'
	export commit=3D'b81fac906a8f9e682e513ddd95697ec7a20878d4'
	export kconfig=3D'x86_64-rhel-8.3'
	export repeat_to=3D6
	export submit_id=3D'64b795dc0b9a93051aab1f48'
	export job_file=3D'/lkp/jobs/queued/int/lkp-icl-2sp7/stress-ng-os-performa=
nce-1HDD-ext4-10%-af-alg-60s-debian-11.1-x86_64-20220510.cgz-b81fac906a8f-2=
0230719-66842-1x1uv4s-1.yaml'
	export id=3D'0be5513728414ebaedaa25c843e04c0c3c24beb6'
	export queuer_version=3D'/lkp/xsang/.src-20230719-094325'
	export model=3D'Ice Lake'
	export nr_node=3D2
	export nr_cpu=3D64
	export memory=3D'256G'
	export nr_ssd_partitions=3D3
	export nr_hdd_partitions=3D6
	export hdd_partitions=3D'/dev/disk/by-id/ata-WDC_WD20SPZX-22UA7T0_WD-WXK2E=
319F11A-part*'
	export ssd_partitions=3D'/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF7414=
01PU4P0IGN-part1
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part2
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part3'
	export rootfs_partition=3D'/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF74=
1401PU4P0IGN-part4'
	export kernel_cmdline_hw=3D'acpi_rsdp=3D0x6988f014'
	export result_service=3D'tmpfs'
	export LKP_SERVER=3D'10.239.97.5'
	export avoid_nfs=3D1
	export brand=3D'Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz'
	export need_kconfig=3D'{"XFS_DEBUG"=3D>"n"}
{"XFS_WARN"=3D>"y"}
{"PM_DEBUG"=3D>"n"}
{"PM_SLEEP_DEBUG"=3D>"n"}
{"DEBUG_ATOMIC_SLEEP"=3D>"n"}
{"DEBUG_SPINLOCK_SLEEP"=3D>"n"}
{"CIFS_DEBUG"=3D>"n"}
{"SCSI_DEBUG"=3D>"n"}
{"NFS_DEBUG"=3D>"n"}
{"SUNRPC_DEBUG"=3D>"n"}
{"DM_DEBUG"=3D>"n"}
{"DEBUG_SHIRQ"=3D>"n"}
{"OCFS2_DEBUG_MASKLOG"=3D>"n"}
{"DEBUG_MEMORY_INIT"=3D>"n"}
{"SLUB_DEBUG"=3D>"n"}
{"EXPERT"=3D>"y"}
{"PREEMPT_VOLUNTARY"=3D>"y"}
{"PREEMPT_NONE"=3D>"n"}
{"PREEMPT"=3D>"n"}
{"PREEMPT_RT"=3D>"n"}
{"PREEMPT_DYNAMIC"=3D>"n"}
{"PREEMPT_VOLUNTARY_BEHAVIOUR"=3D>"y"}
{"PREEMPT_BEHAVIOUR"=3D>"n"}
{"PREEMPT_NONE_BEHAVIOUR"=3D>"n"}
{"PREEMPT_DYNAMIC"=3D>"n"}
{"PREEMPT_VOLUNTARY"=3D>"y"}
{"PREEMPT_NONE"=3D>"n"}
{"PREEMPT"=3D>"n"}
{"PREEMPT_RT"=3D>"n"}
BLK_DEV_SD
SCSI
{"BLOCK"=3D>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=3D>"y"}
EXT4_FS'
	export ucode=3D'0xd000389'
	export rootfs=3D'debian-11.1-x86_64-20220510.cgz'
	export enqueue_time=3D'2023-07-19 15:50:57 +0800'
	export compiler=3D'gcc-12'
	export _id=3D'64b795e60b9a93051aab1f4f'
	export _rt=3D'/result/stress-ng/os-performance-1HDD-ext4-10%-af-alg-60s/lk=
p-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/b81fac906=
a8f9e682e513ddd95697ec7a20878d4'
	export kernel=3D'/pkg/linux/x86_64-rhel-8.3/gcc-12/b81fac906a8f9e682e513dd=
d95697ec7a20878d4/vmlinuz-6.4.0-rc2-00017-gb81fac906a8f'
	export result_root=3D'/result/stress-ng/os-performance-1HDD-ext4-10%-af-al=
g-60s/lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/b=
81fac906a8f9e682e513ddd95697ec7a20878d4/3'
	export user=3D'lkp'
	export scheduler_version=3D'/lkp/lkp/src'
	export arch=3D'x86_64'
	export max_uptime=3D2100
	export initrd=3D'/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append=3D'root=3D/dev/ram0
RESULT_ROOT=3D/result/stress-ng/os-performance-1HDD-ext4-10%-af-alg-60s/lkp=
-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/b81fac906a=
8f9e682e513ddd95697ec7a20878d4/3
BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-12/b81fac906a8f9e682e513ddd9569=
7ec7a20878d4/vmlinuz-6.4.0-rc2-00017-gb81fac906a8f
branch=3Dlinus/master
job=3D/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-performance-1HDD-ext4-1=
0%-af-alg-60s-debian-11.1-x86_64-20220510.cgz-b81fac906a8f-20230719-66842-1=
x1uv4s-1.yaml
user=3Dlkp
ARCH=3Dx86_64
kconfig=3Dx86_64-rhel-8.3
commit=3Db81fac906a8f9e682e513ddd95697ec7a20878d4
nmi_watchdog=3D0
acpi_rsdp=3D0x6988f014
max_uptime=3D2100
LKP_SERVER=3D10.239.97.5
nokaslr
selinux=3D0
debug
apic=3Ddebug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=3D100
net.ifnames=3D0
printk.devkmsg=3Don
panic=3D-1
softlockup_panic=3D1
nmi_watchdog=3Dpanic
oops=3Dpanic
load_ramdisk=3D2
prompt_ramdisk=3D0
drbd.minor_count=3D8
systemd.log_level=3Derr
ignore_loglevel
console=3Dtty0
earlyprintk=3DttyS0,115200
console=3DttyS0,115200
vga=3Dnormal
rw'
	export modules_initrd=3D'/pkg/linux/x86_64-rhel-8.3/gcc-12/b81fac906a8f9e6=
82e513ddd95697ec7a20878d4/modules.cgz'
	export bm_initrd=3D'/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipco=
nfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_2022051=
3.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.c=
gz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/d=
eps/debian-11.1-x86_64-20220510.cgz/stress-ng_20230716.cgz,/osimage/pkg/deb=
ian-11.1-x86_64-20220510.cgz/stress-ng-x86_64-0.15.04-1_20230716.cgz,/osima=
ge/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/d=
ebian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-1=
1.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osima=
ge/deps/debian-11.1-x86_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debi=
an-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimag=
e/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/os=
image/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/de=
bian-11.1-x86_64-20220510.cgz/rootfs_20220515.cgz'
	export ucode_initrd=3D'/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd=3D'/osimage/user/lkp/lkp-x86_64.cgz'
	export site=3D'inn'
	export LKP_CGI_PORT=3D80
	export LKP_CIFS_PORT=3D139
	export job_initrd=3D'/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-perform=
ance-1HDD-ext4-10%-af-alg-60s-debian-11.1-x86_64-20220510.cgz-b81fac906a8f-=
20230719-66842-1x1uv4s-1.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=3D/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=3D1 $LKP_SRC/setup/disk

	run_setup fs=3D'ext4' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=3D1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-c2c
	run_monitor debug_mode=3D0 $LKP_SRC/monitors/no-stdout/wrapper perf-profil=
e
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class=3D'os' test=3D'af-alg' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=3D
	export stats_part_end=3D

	env class=3D'os' test=3D'af-alg' $LKP_SRC/stats/wrapper stress-ng
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=3D1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-c2c
	env debug_mode=3D0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--GnpOZ+qGXYIRlwek
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"
Content-Transfer-Encoding: quoted-printable

---

#! /lkp/lkp/src/jobs/stress-ng-class-os.yaml
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 10%
disk: 1HDD
testtime: 60s
fs: ext4
stress-ng:
  class: os
  test: af-alg
job_origin: stress-ng-class-os.yaml

#! queue options
queue_cmdline_keys: []
queue: int
testbox: lkp-icl-2sp7
tbox_group: lkp-icl-2sp7
branch: linus/master
commit: b81fac906a8f9e682e513ddd95697ec7a20878d4
kconfig: x86_64-rhel-8.3
repeat_to: 6
submit_id: 64b795dc0b9a93051aab1f48
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-performance-1HDD-e=
xt4-10%-af-alg-60s-debian-11.1-x86_64-20220510.cgz-b81fac906a8f-20230719-66=
842-1x1uv4s-2.yaml"
id: 11fd56cf392243dba2c6ebedbd372e4af1037cad
queuer_version: "/lkp/xsang/.src-20230719-094325"

#! hosts/lkp-icl-2sp7
model: Ice Lake
nr_node: 2
nr_cpu: 64
memory: 256G
nr_ssd_partitions: 3
nr_hdd_partitions: 6
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20SPZX-22UA7T0_WD-WXK2E319F11A-p=
art*"
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part1"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part2"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part3"
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0=
IGN-part4"
kernel_cmdline_hw: acpi_rsdp=3D0x6988f014
result_service: tmpfs
LKP_SERVER: 10.239.97.5
avoid_nfs: 1
brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz

#! include/category/benchmark
need_kconfig:
- XFS_DEBUG: n
- XFS_WARN: y
- PM_DEBUG: n
- PM_SLEEP_DEBUG: n
- DEBUG_ATOMIC_SLEEP: n
- DEBUG_SPINLOCK_SLEEP: n
- CIFS_DEBUG: n
- SCSI_DEBUG: n
- NFS_DEBUG: n
- SUNRPC_DEBUG: n
- DM_DEBUG: n
- DEBUG_SHIRQ: n
- OCFS2_DEBUG_MASKLOG: n
- DEBUG_MEMORY_INIT: n
- SLUB_DEBUG: n
- EXPERT: y
- PREEMPT_VOLUNTARY: y
- PREEMPT_NONE: n
- PREEMPT: n
- PREEMPT_RT: n
- PREEMPT_DYNAMIC: n
- PREEMPT_VOLUNTARY_BEHAVIOUR: y
- PREEMPT_BEHAVIOUR: n
- PREEMPT_NONE_BEHAVIOUR: n
- PREEMPT_DYNAMIC: n
- PREEMPT_VOLUNTARY: y
- PREEMPT_NONE: n
- PREEMPT: n
- PREEMPT_RT: n
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- EXT4_FS
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-c2c:
perf-profile:
  debug_mode: 0

#! include/category/ALL
cpufreq_governor: performance
sanity-check:

#! include/disk/nr_hdd

#! include/fs/OTHERS

#! include/stress-ng

#! include/testbox/lkp-icl-2sp7
ucode: '0xd000389'
rootfs: debian-11.1-x86_64-20220510.cgz
enqueue_time: 2023-07-19 15:50:57.382991645 +08:00
compiler: gcc-12
_id: 64b795e60b9a93051aab1f50
_rt: "/result/stress-ng/os-performance-1HDD-ext4-10%-af-alg-60s/lkp-icl-2sp=
7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/b81fac906a8f9e682e=
513ddd95697ec7a20878d4"
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-12/b81fac906a8f9e682e513ddd95697ec7=
a20878d4/vmlinuz-6.4.0-rc2-00017-gb81fac906a8f"
result_root: "/result/stress-ng/os-performance-1HDD-ext4-10%-af-alg-60s/lkp=
-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/b81fac906a=
8f9e682e513ddd95697ec7a20878d4/1"

#! schedule options
user: lkp
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=3D/dev/ram0
- RESULT_ROOT=3D/result/stress-ng/os-performance-1HDD-ext4-10%-af-alg-60s/l=
kp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/b81fac90=
6a8f9e682e513ddd95697ec7a20878d4/1
- BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-12/b81fac906a8f9e682e513ddd95=
697ec7a20878d4/vmlinuz-6.4.0-rc2-00017-gb81fac906a8f
- branch=3Dlinus/master
- job=3D/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-performance-1HDD-ext4=
-10%-af-alg-60s-debian-11.1-x86_64-20220510.cgz-b81fac906a8f-20230719-66842=
-1x1uv4s-2.yaml
- user=3Dlkp
- ARCH=3Dx86_64
- kconfig=3Dx86_64-rhel-8.3
- commit=3Db81fac906a8f9e682e513ddd95697ec7a20878d4
- nmi_watchdog=3D0
- acpi_rsdp=3D0x6988f014
- max_uptime=3D2100
- LKP_SERVER=3D10.239.97.5
- nokaslr
- selinux=3D0
- debug
- apic=3Ddebug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=3D100
- net.ifnames=3D0
- printk.devkmsg=3Don
- panic=3D-1
- softlockup_panic=3D1
- nmi_watchdog=3Dpanic
- oops=3Dpanic
- load_ramdisk=3D2
- prompt_ramdisk=3D0
- drbd.minor_count=3D8
- systemd.log_level=3Derr
- ignore_loglevel
- console=3Dtty0
- earlyprintk=3DttyS0,115200
- console=3DttyS0,115200
- vga=3Dnormal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-12/b81fac906a8f9e682e513ddd=
95697ec7a20878d4/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_2022=
0515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/os=
image/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osima=
ge/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debia=
n-11.1-x86_64-20220510.cgz/stress-ng_20230716.cgz,/osimage/pkg/debian-11.1-=
x86_64-20220510.cgz/stress-ng-x86_64-0.15.04-1_20230716.cgz,/osimage/deps/d=
ebian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.=
1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_6=
4-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/d=
ebian-11.1-x86_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debian-11.1-x=
86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/deb=
ian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/dep=
s/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/debian-11.1=
-x86_64-20220510.cgz/rootfs_20220515.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20230718234219/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
job_initrd: "/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-performance-1HDD=
-ext4-10%-af-alg-60s-debian-11.1-x86_64-20220510.cgz-b81fac906a8f-20230719-=
66842-1x1uv4s-2.cgz"
dequeue_time: 2023-07-19 17:21:28.206851122 +08:00
last_kernel: 6.4.0-rc2-00017-gb81fac906a8f
acpi_rsdp: '0x6988f014'
job_state: finished
loadavg: 6.00 2.58 0.96 1/749 113650
start_time: '1689758592'
end_time: '1689758654'
version: "/lkp/lkp/.src-20230719-143127:54ad2dc0206a:c956062703c0"

--GnpOZ+qGXYIRlwek
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

dmsetup remove_all
wipefs -a --force /dev/sdb1
mkfs -t ext4 -q -F /dev/sdb1
mkdir -p /fs/sdb1
mount -t ext4 /dev/sdb1 /fs/sdb1

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "mkdir" "-p" "/mnt/stress-ng"
 "mount" "/dev/sdb1" "/mnt/stress-ng"
 "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" "--af-alg" "6"

--GnpOZ+qGXYIRlwek
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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
Asu5E3r5fDixxGf7AgAAAAAEWVo=

--GnpOZ+qGXYIRlwek--
