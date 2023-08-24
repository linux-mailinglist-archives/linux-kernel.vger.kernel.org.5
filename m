Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816DE786780
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbjHXG3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbjHXG3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:29:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902EC170B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692858517; x=1724394517;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=n4+O9uLpNkUWNPN9LMFOiMUb0XCjcyF2GyV9yp0NjIA=;
  b=ixJSFeHnLhdVs7leNEMHZg0OisTIwDjB8DGC0DcQDVOKrkC2lg47j0Nc
   2kXebFfvghj4c1JsNdIp67ZD96sjfRoyO6QEk2CTSiKP92uRo1Fe95y7K
   cSx9l/k/WVF5DKU71N4Dum4n5ACDa7vs3hLbEP09HL4UN7b+RrH/T+BQj
   p6R2LofjngqDuGHODz17hCuRxW3h3r7J5/pwK1gJ6NaV4elEWPldZKnqx
   kOv0x/2DqccI33OMgxQ0gRMmey1574T8I/lppDL/MwxiehC3ZWhDSoeS3
   AxzCIiZ5uTrGiyLwcAaHejegWnXpYQK5oS6qKF9ncu539ladkqmpTrZQg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="377084463"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="377084463"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 23:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="827010210"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="827010210"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2023 23:28:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 23:28:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 23:28:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 23:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daxY4r0I6HLoPtImt5oXTHTfp7h/LYaayUVV0BhfJyRSGHhbvTllzK94hEcYtAjJiB1CFLUL2m+mINzL1lwMChMunbZwsdYn1ZebIW8mQr0WtFDbY/d6uWk5HJ1X4tlllMqcS5HhSOIADoiYlBAeZiN5TTFKd5+0LvkHZ9fJT7cSwHchZ2B0Gu5bvnFBk9x1x6HjT0dQ5CudGLhYqduICCf1xpo4ft3ksUVRb/KXUnX6BYMCOIJpIlBCJuLLSJ8iPO2XjZfpnWpc6mxPYlYeZN+tJrTGuGHORUtfkYjRwbR0VygIT9DpxFZ1Ut2reDL78DLTO2/ecbrZFO5z85WlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGm3QRWr3hQ0JdH+4jOurqq8PY8wVSA5pzWeiDZEYTA=;
 b=XDl2TFdvbavJofb+mW6i9l/vzsATHNIpP8qdJIDR2nKZxeSwVkZ2Iv/iIUUV99XqKpr5HJ0pDOs7hMIqS2noCBCbbhAlfqC3aRjLZn9posTrUMJ8v7VLuLOivm49XBZebDE4ZAithwY67gVaZdg5xqIAGbTQOKmA9bItTSIRsdDjeoQJBlSJs79EplFWHCWeTGGxUo5OwuVW0l4SCWyKYB6omMcHi5VEd0XfrO1mPYTH4Etl7KOjq9cTgVT1cDldh0RoidO8ZoD8UhZhiixrIlkIS/2gCacZqyJ2jjpJstVZUX89m3irw7ojJMztdBhgSNYir1vO0JAlQM7J3oWz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 06:28:32 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 06:28:32 +0000
Date:   Thu, 24 Aug 2023 14:28:20 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Chris Li <chrisl@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        <baolin.wang@linux.alibaba.com>, <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, <david@redhat.com>,
        <willy@infradead.org>, Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>,
        <linux-kernel@vger.kernel.org>, Chris Li <chrisl@kernel.org>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH RFC 2/2] mm/page_alloc: free_pcppages_bulk clean up
Message-ID: <202308241221.cc5ac84a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817-free_pcppages_bulk-v1-2-c14574a9f80c@kernel.org>
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA3PR11MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c2c927-7201-4de6-af92-08dba46b5648
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIALQoWENzRkSB+K8c2JOVWYzq2CPSGwn9B0X3bkmJwiWcAcOcNq07BGJfwSS2HY7DYM78Z1QYQf6nK0rpzXeu++AZEC4c4pf0no4Dw3zZNHZdHQKO17vOyN5VNTpaQTmXuwTQ0Ol3J3wRcU2CtFUqRZl3JKTMW5OsilZE6VXu/rzmayAmDktC/+UVTSgwmZAvraiPZVGsQEIwiQggE+oQrp0apWkFiTkQnEUngHSE7/yspYfv5Hg8iLOmi3dnf35MLTBd3WJK7eIBBDBkPCCTGBjTjpeM6aUEsfGwS8QZH4fqmTgxgJ1LC7ezB+4NYJBAIYGtgad1mHb1QD0C0i2kPDcgzEyxvrU7ajfhKImVkEERoEILN+IYDWQb5/lBaHdYBI3rvuulpErOKoGoiL93a7zB+B7bn50qKp1RNv6jWpRtkim1qzFQJm6NdekXi5oM69qA143K1m5a68Etb/nLF4KYuXHXgDrllEQhpDZ3moxx8YCE3RxV4mtYxMX8oacmwC0u+Os9Iv7Gj933OLnztFMtkotNYlTFSd2ZmGxK2NBfm4ULaFlyY/iimkO2AWH5lqsFXqSQfnnOx95rMA6XLaQWE5fSsv80zOs9v1uOuMYkgNr43bCwsQt0cJjOVWftiN1i6kWjtw4716IZNJlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(107886003)(4326008)(8676002)(8936002)(36756003)(83380400001)(7416002)(26005)(38100700002)(6666004)(82960400001)(66476007)(66946007)(66556008)(54906003)(6916009)(316002)(478600001)(966005)(45080400002)(41300700001)(6512007)(2906002)(6506007)(86362001)(6486002)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfdraYoJ2CzjF//6TAxNkwerdxnKTUWMNSQKB5zfKIcZzLoV+7ZG9GruNAs6?=
 =?us-ascii?Q?oW9qdDcVxdT3uIA1I2pngOS9fbGSpeOyOmuXupi/PtjFj2hDR9Rzrx22r190?=
 =?us-ascii?Q?WoICZjzudeESjY4MUj42PStD0S7TwqJ7Tn8vPw8BsBInWvBBwRAj0rDYlTis?=
 =?us-ascii?Q?F9smZoZgMoiBy8III/qvHQSE/yxKU9AQBvhhKTpJJM1Wn8sSCVcMv+OJosib?=
 =?us-ascii?Q?Or5mFiWP/x5BTJ5teoDvnY9yugmAOeLFhvoB3wqc4CmnVXfTqtSQkUzEtTBb?=
 =?us-ascii?Q?6B5XxYsNgYoSF2IvBlF4fBjWcxmTlOYsPZYPDMcHCsX40w3j86Qy+RMbiIZY?=
 =?us-ascii?Q?yt2lrbNZo9N0kTRi7zdUccARF9cAQlKOnBNK6H+/lIHoN8mbxGwi2QFKgPK0?=
 =?us-ascii?Q?m6AzQEavRp4EuxRrRFMrCSAJ/4RGyCDwjKIya8xuWud2A8JotvmRPImGq7Tv?=
 =?us-ascii?Q?2bpr1a78babVwBQvnrGG164Zm2slPmjxNYXZU8P5EnJlUmr3TcTf/6FzcIBU?=
 =?us-ascii?Q?vA419SIc6mEYd86SdNu7vhscCMs/w7AentXxLAaFofpwVDntoQQVwrJLuU2f?=
 =?us-ascii?Q?u/PJgM9qcJ1++GfjJURvw40Zu7qsguROVuy2pX4y5E3Co/Jek9WSl5g1v1i4?=
 =?us-ascii?Q?AYQi5xFeCs5gu4tO75+GNxv4ekMgLJLzxrB5zY7u2dMnJjFkjB+DdVbBUNRg?=
 =?us-ascii?Q?ZNu6dQduwRSV3YGkHjATM4xhEq11C+NcgpqCoHgvTRwCZWBkY93i+DOgkRmB?=
 =?us-ascii?Q?Lkgr/MttEPRZXcgTbSe/+isa9TX86smAF2IKyBcHtew2OWKuOCo6/yuT2TDi?=
 =?us-ascii?Q?OEzTm1yJ6k7bIb67m0werJUpqcT98coMixDxfHCmZOS162zw+T/cc08+X/Jl?=
 =?us-ascii?Q?Q8yeNTAykXzklv1ZEh+ff0lJ3kERap8XUdCOK5/yGmXr0e7RuMhyULac9gnU?=
 =?us-ascii?Q?JPOSzpybRCEtKLHN28syPGOQFPv6jMo2vrfAjtAT6Jq90Nxx5dMVbeMIyLlj?=
 =?us-ascii?Q?vpHCam9fmM3MWj+FIIyHWUkL+AxzLXFZ1VvmOKReaurHQyhRtBUpwsehKTdb?=
 =?us-ascii?Q?hYD8B0ANfJxl8jkMm8akinkof2NlyQKSuoXR4OeqN9NELJ/Bcp5pX38cYQiA?=
 =?us-ascii?Q?rhcRpGRTx2wA6ykeKiU7Ws26mv1SLPMS9gibYJ6Rl3Bz+/jG4Q5JomM7G3XP?=
 =?us-ascii?Q?cdPmnwY7H+qs23vjSSPYS1ZjOQVmEzAbsXr2TJ/3NmcRc6x1w4tykCwyNfqf?=
 =?us-ascii?Q?cXEM6rVi+CL01dt4sp+9a7uiiZzshuIP+FHywVFOs8QPYq1JEr7F8vUjJxKB?=
 =?us-ascii?Q?tiJalh8pUZzPGYk8HdTr9V0Eu6P4ul1Vcyza13mFar/TkzwtelE4us7G0YDf?=
 =?us-ascii?Q?EloZTS+WXDBuw8ifu43wkRVCTxuH6OvW8YjvXgMqjEvi+a+PRjHKAGenZ6bT?=
 =?us-ascii?Q?e8XS4t/oLHxBsMN97tXlQAWgRr8UU04FKSdV8oqNs3i05yHSG6mLxdGUacsf?=
 =?us-ascii?Q?w50eH0hsNoL4Qz+ULJFbTkPVb+yoHgIZv3j1Z9hNnP1jQyp5ND124EDTapbt?=
 =?us-ascii?Q?Ey4ggjukBY2YcWIZGIcBN1uWK5JHpxdvW3+w07KwMP7aYDuIW7wjcUztjA5k?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c2c927-7201-4de6-af92-08dba46b5648
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 06:28:32.1481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwcI9pxABTq4XcQsYNfy6aNHOb4lqHhC2IdxJRBXgnxTPFVn1jiNVi5d5uW8GhuWksOrlAeh2FYkIYiceQGfgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7461
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


hi, Chris Li,

we noticed "This patch does not have functional change" in commit message.
however, the issue seems keep happening randomly while we run up to 100 times.
at the same time, the parent keeps clean.

55aea7978bd8df28 3373e582e78e8aaaf8977b42bc8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :100         12%          12:100   dmesg.BUG:kernel_NULL_pointer_dereference,address
           :100          3%           3:100   dmesg.BUG:unable_to_handle_page_fault_for_address
           :100         16%          16:100   dmesg.EIP:free_pcppages_bulk
           :100         15%          15:100   dmesg.Kernel_panic-not_syncing:Fatal_exception
           :100          1%           1:100   dmesg.Kernel_panic-not_syncing:Fatal_exception_in_interrupt
           :100         16%          16:100   dmesg.Oops:#[##]
           :100         16%          16:100   dmesg.boot_failures

and since there is
[   15.898250][    C0] EIP: free_pcppages_bulk+0x7d/0x200
and free_pcppages_bulk() is changed in this commit, we just report this to you.
FYI


Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 3373e582e78e8aaaf8977b42bc8edd8487310033 ("[PATCH RFC 2/2] mm/page_alloc: free_pcppages_bulk clean up")
url: https://github.com/intel-lab-lkp/linux/commits/Chris-Li/mm-page_alloc-safeguard-free_pcppages_bulk/20230818-140815
patch link: https://lore.kernel.org/all/20230817-free_pcppages_bulk-v1-2-c14574a9f80c@kernel.org/
patch subject: [PATCH RFC 2/2] mm/page_alloc: free_pcppages_bulk clean up

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308241221.cc5ac84a-oliver.sang@intel.com



[   15.890907][    C0] BUG: kernel NULL pointer dereference, address: 00000005
[   15.891555][    C0] #PF: supervisor read access in kernel mode
[   15.892037][    C0] #PF: error_code(0x0000) - not-present page
[   15.893161][    C0] *pdpt = 000000002c9e7001 *pde = 0000000000000000
[   15.894410][    C0] Oops: 0000 [#1] SMP PTI
[   15.895385][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G            E      6.5.0-rc4-00242-g3373e582e78e #1
[   15.896801][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   15.898250][    C0] EIP: free_pcppages_bulk+0x7d/0x200
[   15.899281][    C0] Code: 8d 34 c6 89 75 e4 83 f8 0c 0f 84 ee 00 00 00 ba ab aa aa aa f7 e2 b8 01 00 00 00 89 d1 d1 e9 d3 e0 89 45 e0 8b 45 e4 8b 50 04 <8b> 72 04
 8d 5a fc 83 ee 04 39 c2 0f 84 0a 01 00 00 89 4d e8 eb 28
[   15.914130][    C0] EAX: e4c7520c EBX: e4c9f510 ECX: 55555555 EDX: 00000001
[   15.915477][    C0] ESI: e4c7520c EDI: e4c75200 EBP: c1819d98 ESP: c1819d60
[   15.916755][    C0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210006
[   15.918067][    C0] CR0: 80050033 CR2: 00000005 CR3: 2ca6a000 CR4: 000406f0
[   15.919278][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   15.920468][    C0] DR6: fffe0ff0 DR7: 00000400
[   15.921446][    C0] Call Trace:
[   15.922298][    C0]  <SOFTIRQ>
[   15.923149][    C0]  ? show_regs+0x55/0x80
[   15.924069][    C0]  ? __die+0x1d/0x80
[   15.924934][    C0]  ? page_fault_oops+0x65/0xc0
[   15.925890][    C0]  ? kernelmode_fixup_or_oops+0x73/0x100
[   15.926986][    C0]  ? __bad_area_nosemaphore+0xdc/0x1c0
[   15.928086][    C0]  ? bad_area_nosemaphore+0xf/0x40
[   15.929061][    C0]  ? do_user_addr_fault+0x1ac/0x3c0
[   15.930036][    C0]  ? exc_page_fault+0x51/0x140
[   15.930957][    C0]  ? pvclock_clocksource_read_nowd+0x140/0x140
[   15.931997][    C0]  ? handle_exception+0x133/0x133
[   15.932938][    C0]  ? pmd_clear_huge+0x7b/0x80
[   15.934885][    C0]  ? pvclock_clocksource_read_nowd+0x140/0x140
[   15.935963][    C0]  ? free_pcppages_bulk+0x7d/0x200
[   15.936915][    C0]  ? pvclock_clocksource_read_nowd+0x140/0x140
[   15.937954][    C0]  ? free_pcppages_bulk+0x7d/0x200
[   15.938876][    C0]  free_unref_page_commit+0x120/0x180
[   15.939826][    C0]  free_unref_page+0xe7/0x100
[   15.940688][    C0]  __free_pages+0x87/0xc0
[   15.941519][    C0]  __free_slab+0xa1/0x100
[   15.942383][    C0]  free_slab+0x27/0xc0
[   15.943187][    C0]  discard_slab+0x38/0x40
[   15.944014][    C0]  __unfreeze_partials+0x20c/0x240
[   15.946439][    C0]  put_cpu_partial+0x5b/0x80
[   15.947347][    C0]  __slab_free+0x287/0x380
[   15.948207][    C0]  ? __mod_memcg_lruvec_state+0x3e/0x80
[   15.949138][    C0]  kmem_cache_free+0x329/0x340
[   15.950003][    C0]  ? mt_free_rcu+0x10/0x40
[   15.950805][    C0]  ? free_task+0x4d/0x80
[   15.951594][    C0]  ? mt_free_rcu+0x10/0x40
[   15.952390][    C0]  mt_free_rcu+0x10/0x40
[   15.953181][    C0]  rcu_do_batch+0x158/0x440
[   15.953998][    C0]  rcu_core+0xce/0x1c0
[   15.954751][    C0]  rcu_core_si+0xd/0x40
[   15.955512][    C0]  __do_softirq+0xad/0x233
[   15.956293][    C0]  ? __lock_text_end+0x3/0x3
[   15.957084][    C0]  call_on_stack+0x45/0x80
[   15.957871][    C0]  </SOFTIRQ>
[   15.958525][    C0]  ? irq_exit_rcu+0x6a/0xc0
[   15.959284][    C0]  ? sysvec_apic_timer_interrupt+0x27/0x40
[   15.960136][    C0]  ? handle_exception+0x133/0x133
[   15.960900][    C0]  ? alarm_handle_timer+0xfb/0x100
[   15.961669][    C0]  ? sysvec_call_function_single+0x40/0x40
[   15.962542][    C0]  ? default_idle+0xb/0x40
[   15.963234][    C0]  ? sysvec_call_function_single+0x40/0x40
[   15.964026][    C0]  ? default_idle+0xb/0x40
[   15.964703][    C0]  ? arch_cpu_idle+0x8/0x40
[   15.965379][    C0]  ? default_idle_call+0x2a/0xc0
[   15.967867][    C0]  ? cpuidle_idle_call+0x122/0x180
[   15.968680][    C0]  ? do_idle+0x79/0xc0
[   15.969357][    C0]  ? cpu_startup_entry+0x25/0x40
[   15.970106][    C0]  ? rest_init+0x96/0xc0
[   15.970770][    C0]  ? arch_call_rest_init+0xd/0x80
[   15.971505][    C0]  ? start_kernel+0x347/0x480
[   15.972209][    C0]  ? early_idt_handler_common+0x44/0x44
[   15.972969][    C0]  ? i386_start_kernel+0x48/0x80
[   15.973678][    C0]  ? startup_32_smp+0x156/0x158
[   15.974397][    C0] Modules linked in: intel_rapl_msr(E) intel_rapl_common(E) ata_generic(E) ppdev(E) crc32_pclmul(E) crc32c_intel(E) aesni_intel(E) ipmi_devintf(
E) ipmi_msghandler(E) crypto_simd(E) ata_piix(E) cryptd(E) rapl(E) i2c_piix4(E) psmouse(E) evdev(E) serio_raw(E) bochs(E) drm_vram_helper(E) drm_kms_helper(E) drm_tt
m_helper(E) ttm(E) libata(E) parport_pc(E) floppy(E) parport(E) qemu_fw_cfg(E) button(E) drm(E) configfs(E) fuse(E) autofs4(E)
[   15.978905][    C0] CR2: 0000000000000005
[   15.979621][    C0] ---[ end trace 0000000000000000 ]---
[   15.980419][    C0] EIP: free_pcppages_bulk+0x7d/0x200
[   15.981222][    C0] Code: 8d 34 c6 89 75 e4 83 f8 0c 0f 84 ee 00 00 00 ba ab aa aa aa f7 e2 b8 01 00 00 00 89 d1 d1 e9 d3 e0 89 45 e0 8b 45 e4 8b 50 04 <8b> 72 04
 8d 5a fc 83 ee 04 39 c2 0f 84 0a 01 00 00 89 4d e8 eb 28
[   15.983663][    C0] EAX: e4c7520c EBX: e4c9f510 ECX: 55555555 EDX: 00000001
[   15.984705][    C0] ESI: e4c7520c EDI: e4c75200 EBP: c1819d98 ESP: c1819d60
[   15.985738][    C0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210006
[   15.986822][    C0] CR0: 80050033 CR2: 00000005 CR3: 2ca6a000 CR4: 000406f0
[   15.987832][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   15.988839][    C0] DR6: fffe0ff0 DR7: 00000400
[   15.989679][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[   15.996118][    C0] Kernel Offset: disabled



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230824/202308241221.cc5ac84a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

