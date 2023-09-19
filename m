Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130707A5C95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjISIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjISIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:32:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4F5114;
        Tue, 19 Sep 2023 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695112366; x=1726648366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p5b47tBzw/+3ty++y9okl7mAy08SzXvVi+NKQmeDnms=;
  b=HBMsip+xex6GOZXS/yqiPkcfW7uqr5zM0uIOKo4BjZb6Tcb7bPOj8edO
   08nSQiC1ldWQN5oXXRW3k27dmj3ah4FmKBI1V7pogBFLJwBgTevdC9dPw
   5Rc3nI73QnmxsuY+yOTNjkg2gNKsdgOTLrB2zcyTt0Zip1um8pPn+cvCg
   C/sbWb9eBmN7mFlDRNfDrHzO39mE92O5eIcyp24QoZpFLJ/UXY7HfOrV+
   yn62Q1CUaff/oKOCh90HCStwbexJH8GqKsHaDtUsmGCRFjNKX8577GLUp
   Usqa5DTEihiGadig9KVSMzN9FlkrDQ3d7NZknbI9WC1yDbMZ0MUL/E7HO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383708703"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="383708703"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 01:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811650032"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="811650032"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 01:32:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 01:32:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 01:32:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 01:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHDcTlzGgFAFBxG1kO+vBhL9Cm9DJgwFEBxHgjvN/9ABZv4JOYB4C0uLfuI4mkDXt9lMb2/Tr5jlX/+DHGCtfxUAZmHEm8NpJJB0F/Hyz/6s4BeoVKA5VYb4OzEpC0UzcdFh5lgewI3AevyucfFt13R/9Cy/5jF+L/lMyrxsaa/Uz6YaJnvWQIB/1hCJP0EMKbnLpW0kpielxhr3c/+oRQkBiiNbbOqQpYv0cRM0LCf0ZTMut/HQ3Nk4BFo3vL/SHesQZRmZhwb8CUt6QZ8+446BfSny7oCwBSQ5ryUi3nZWKiagPiRpLz53iZft4C7K8zejN9DItFsDMStSc2F6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8zHZwp9Qtb1tpPjsm5BNdIwBXX8DjPDMAiAsvyH/kY=;
 b=RZRHDij4eF7tm5PRNWj76HKaT2BQ4txTRkEn6COiSAOaaMhb69nJSayFS24CEw6RypXSWjLCVumtK93YtzdIbdHscVDgI6kXpc+UWs6l4N9ohdooS91sRwN7W1OST8KCgp+uvTuKwIoBMx++o+Lk7zvqrDgVG9CW7epYipqaDlBNXvEWMgVsAPPqF9gT9uLGi4Z+NKlrinF4zeyquKF1vVdFvdV8d2UPU9oto1pF3oQ3dGBgr8STVwmhvkEkiamee2WBfEjAlKj2ecAgv4XKAYuTNwXf5pPXaq7FKAt1llQk26UH75KZox5fNP+j+Gcd2HOVl/vxLASTJPsAdHYZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:32:20 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 08:32:20 +0000
Date:   Tue, 19 Sep 2023 16:32:09 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [selftests]  8ae9efb859:
 kernel-selftests.net.fib_tests.sh.fail
Message-ID: <202309191658.c00d8b8-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b6d750-608a-435a-f1bd-08dbb8eaf0bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ch8v/HYKhiDCjvu2fu4Y4/5PvQhNkSWU2gbFkxWjkkkNuLBRmM0Z73/PxcdEaRofHXXqbxOeQmZ6DgXeoT/2PT4Iu8QJPDRsJDG/TZAAHw6cnnDOkVqmHqfruzUiuPfof9bNaNTwcf8nYfX5xUtXmd2eJTjg5rGhdrD5uBd/scQ+jwoQjQptoamM0jE3ldPOlghNkToZXfmBlUc8DtOShpVx0SIPMsv26WuXzukyKlLNNQLumjxhJjXPAzgXKO6Og5Yfj0aFXmmn6J08oNZa+vthtyXCoFHEArM13tDzolKsYFOC7S9ve282tfs4kyvAtCLsLvv6eNZovjfwiJ+qZSXS6InJfsSkhZCeS6binDJxGIyaVjJdA5/tKO1ETth0Lx1/17q4TwmnJMEMP4N4vwxQ54z+HOPOsHObsKPnrfWYGJfTDPMhZscl8+Xqyu/yKsZMDWZt3j6S8iuGH65UZVcvLMjiWgcxCKghd8+8TDspAo9yyvGwVPPELJkCJsCnAZ0aKINg22MAShMwi2tlUGaZunz1lciG4Z+mBzSEfmX/R0QOsXknxVrbV6hUJVssibaB+d0W+3U2X+P1GEr77IXIFD2sQFfReoSW8zIWhifxIYFvQWx2CC25TggF8Ahlow4u53ZXri1UNqOP0UpVcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199024)(186009)(1800799009)(6506007)(6666004)(6486002)(83380400001)(478600001)(82960400001)(86362001)(38100700002)(36756003)(4326008)(1076003)(2616005)(2906002)(966005)(6512007)(8676002)(5660300002)(26005)(41300700001)(107886003)(8936002)(66476007)(316002)(66946007)(66556008)(6916009)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g6zU5kA//knElrntyPc5g0Fjk2fc+IZMP/WVUgg3FOGmVbRN5FgtLxTOt4rO?=
 =?us-ascii?Q?7IkNkKkzOnd/oT1NR1ucWpqr7iRb88ffDI1W+Ds9bd0gEIo/y5a4zKLrKOrV?=
 =?us-ascii?Q?2aHdGm/+6Xk3UcEhpfac7ZtNZJ0ExiQtucxhp7KXq/enrJNfHYfYZB88LlXt?=
 =?us-ascii?Q?XNKxfG1FYE5xLTtNpvTWCrLEFihz7mTfwo7AG9FuXBhlZl9UhmCLvWYoY8Yi?=
 =?us-ascii?Q?UXvHPCaU/HYi1xLtLV1twb+BBUeKN2XKpYzhZ+X/+fM7+XoJL8oTkD/eyjuZ?=
 =?us-ascii?Q?/Hx3FWc1JDDXl/s81rkICTtzHFEUUZCtbjcBaG/RlrY+8kRzyeCxQ5H8aJSS?=
 =?us-ascii?Q?vmr0BIcsf9biEAelXeD3lvHl4XEOYGAhIoo6O4q2PGGVG8Ep+Vq7MPhICsm2?=
 =?us-ascii?Q?ZEm25LWQzJEvpyWj3oct8KdR4gvJJ+5Yqrkrd5J3CPHE6XYekeX9f8T9SsfV?=
 =?us-ascii?Q?HsjT0I42dDoSKTfz2UHcubcwIe2UarQfK//0z0VfQWKgbnJLS9HeI7kWBTCg?=
 =?us-ascii?Q?t7wHvhL+Uefwb6mwl4Dz4ti5l34y5PMkets4mrXtYQ1oI8UfpVG3ifw1kVhk?=
 =?us-ascii?Q?o+1RuBUncxqSM54oZUrm+OPw+2gc+ZFbzHYE8YsIDWm1oBFMWjJ6NzEZ5tTy?=
 =?us-ascii?Q?HmId30xhoLAYqJEcHayj35cB22FEyQV0Whpj4+CQp9gms6OX4DFw2avidPNb?=
 =?us-ascii?Q?bWUwC4efQGkcLnCGLasQaReQecsGOdrGr+yecx24j4K7VONyi7+EOn72Yq5O?=
 =?us-ascii?Q?TNF7jktjPQnsJM5xSFaz9ALtTDadaDuyC9OwqzJjWTc2M7l+sNgJu0QOJXiT?=
 =?us-ascii?Q?PQajQnoQdjCTwPqNIzfCNUy63hEji6uljSYf5P3TkayASJMzQMFwo/i+2iyE?=
 =?us-ascii?Q?+YKefyzSFI5Wq4r6Lh/Mrx3wsWqNDaUNId8fsAKHljul/cN583iiPK1JX8U1?=
 =?us-ascii?Q?Ge7P/Wz9fkvdepgaEDnnvlHoyS+2hL9hgaGx4whAwrPJWUEQ0gD4YodSZ7IT?=
 =?us-ascii?Q?caYJgbRkRp0aiFcStU5yjKkkl68U9pnTFc/kEqG6E+XQTRg0d/nuay2Cnqla?=
 =?us-ascii?Q?YZiIbQ1ZyLY+kM3ABkj2FkBdb3bZgPBHQ93VFKi/JuTRHVpBua7BUszVHVn1?=
 =?us-ascii?Q?hhxqc+zRJ1r4rms4EhHOZCxEHqtmW3j3LYiGlZD/am+2wB7/cjXd7mZ6VAgo?=
 =?us-ascii?Q?715HXYsy/SEYft3/EFNwiaIdy73fyyAqZOTcjLXf2MgkUlIqrmlSFg+I1yNe?=
 =?us-ascii?Q?1PEDI2F47Zf2UWQfxJlBc4Vl3mZ0foh05rTLQvno9BIEAYQTIkiaPK6nMDlM?=
 =?us-ascii?Q?tkdVeUCG/lb9MZrxSGDikOLTgOGd/fFJh6qZowcXIFaapXOD69ipEmflYj6/?=
 =?us-ascii?Q?meVD4WvioUPfMp10MVJkA5WWrC+rhhHDOJwyRsDLdzgOm0EtvNqG/iVd2FyJ?=
 =?us-ascii?Q?eg4tDNnZnc26DBJQXp2YTDDbQu4bfaKmCv1o0nn53qYWv6AhsXhIY8JXi6vm?=
 =?us-ascii?Q?tj8OV/ikzFqc//mUieWW7bw0OGN0XnfVCpl5+2sDZiDoKTET9pV16rVw5NTr?=
 =?us-ascii?Q?5vV5IVgLCQfKLL0SHnO2eUvE593pNgstRgpvUHIV6OdaFfPCsXGEIm7AlBKw?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b6d750-608a-435a-f1bd-08dbb8eaf0bd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:32:20.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUBfzm+z94nNgtZIGLWwnWwuQ5FrdrsyBM1spCLO/uKWzkgXdW7mx3dL8I2fYvGHW/LtP4w4evmk3FJVh9LAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Sriram Yagnaraman,

we noticed two new added tests failed in our test environment.
want to consult with you what's the dependency and requirement to run them?
Thanks a lot!

Hello,

kernel test robot noticed "kernel-selftests.net.fib_tests.sh.fail" on:

commit: 8ae9efb859c05a54ac92b3336c6ca0597c9c8cdb ("selftests: fib_tests: Add multipath list receive tests")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309191658.c00d8b8-oliver.sang@intel.com



# timeout set to 1500
# selftests: net: fib_tests.sh
# 
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [ OK ]
#     TEST: IPv6 fibmatch - no route                                      [ OK ]

...

# 
# Fib6 garbage collection test
#     TEST: ipv6 route garbage collection                                 [ OK ]
# 
# IPv4 multipath list receive tests
#     TEST: Multipath route hit ratio (.06)                               [FAIL]
# 
# IPv6 multipath list receive tests
#     TEST: Multipath route hit ratio (.10)                               [FAIL]
# 
# Tests passed: 223
# Tests failed:   2
not ok 17 selftests: net: fib_tests.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230919/202309191658.c00d8b8-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

