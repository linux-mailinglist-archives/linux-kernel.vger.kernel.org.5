Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1C799E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbjIJOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIJOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:15:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10DCC5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694355332; x=1725891332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xw8FWr44r9rLDWdsdg6QGByNyzCGPU1PjNJfVuCBCYs=;
  b=cvaEcAA6hhTuOb78OTu6/CIhY8uX/RCYkNBmeaaO9kbrx67uNMxxlQ5V
   2jAZZkJlGAe9e64LB/qdTeFmdduJDsLQgf9KzNj42y7VrS5dnPIr6dNnt
   FE/CPLNPhY3mn0KmmZE7cS2f7Di1x+00Vgu35Y0wpKaeuopFygSb3axOp
   8NiUt8g5w/3StTQYP18GQAzEvaRfRo5YEUrKTDou4dThPFfcxJT5uF7lW
   AnE1qr8SmXDLo5lq57k7hyUvrJyuivbjS2GNihbMJXm0sFE9JIJcgN80A
   qM7JEmLi3hHnFERSiyoEM2h2p6GwhyWkzIu0OHFNTEY4Up6X+KOWrUC/d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="408873290"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="408873290"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 07:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="719695751"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="719695751"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2023 07:15:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 07:15:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 07:15:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 10 Sep 2023 07:15:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 10 Sep 2023 07:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGp98FCWHEVNlm5GykU6WRMq0nxfFC+1ADFByUaKz7b42gK07w+sjmekqiFqvi119vkxzRFK9SCt4Z3IFv4/PleaIHKLQFwJDuJRfiKbQgrhkh65djVY9h4CZ2ThYSL/QWYE1z7xKG1YFQlAxK1F5qsoZRPWRzv/dGlBJIkYaclLRBN6tvlvzmmuwrkCB2rz2PGwyN9ejG55TTFmNxSzXSop47UcqiwyK85UuC5k5NPcS1PSI/vxpME/SvAM3HYrfzffceePH2HSYBggOWcSv4XIoBFty4td7SqV7X8H4vItglMNUSGpf21kFreIyBFL9tDnIoBopi8mOmQwMefIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTyZDBcXI3Wpa2ZkKeNiNeFMD1V403OUyqj+laNb5G0=;
 b=L13eI0B00fgDl7HZbHUSMH4EPbAdx1/Okuz2XQNX7/fBMivCeglioEXYqGkgVYx6+8IUEvJQQYhZYlouujTIQkMeF6IMI7A8PWaV2hMC5SI67SsAKsw4oz2Q3lDILs9CdwdVFUzsneJ2RMFS/ImlBfscF/jbhNcVYQ/BT/8E6Zw4oNJfEYC48g2jb278w23dm5rVuwtliAhC1VDwlgPPGCXP8HDU+dXG74rnkddTHY21OqQCdHEMGrNqyw2BHu0jKf0SU58zAOaK2RamwOfEHq2J9sSdWbTYoExP2oJ9DqA2VOAsdDL4/SLAa3kRYZroc2JItEJaL2Mi7bdo//hy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Sun, 10 Sep
 2023 14:15:26 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 14:15:26 +0000
Date:   Sun, 10 Sep 2023 22:15:15 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Binderman <dcb314@hotmail.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        Vernon Yang <vernon2gm@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [maple_tree]  a5199577b1: canonical_address#:#[##]
Message-ID: <202309102139.f96019d5-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS7PR11MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 015fbe62-0df1-4400-2fb6-08dbb20860d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/YVjPshR9rWBJD84GrJ8qH9z49yplEvb3HxavlXQGLCRH0ZIkJEA/iADHOe43V8iEj+XMfwG2QJBe20O7JkI5YANeWE86j8seZop8eO0yIUmTrMKgNDVwLDJtKi49vTPXEfgQ/jYIcXCMY0ICZ/bFx/rZ2C6lzkXApLEqFw+dBG5DEAq8JlGmJ4htKmkGLMr9bsQ9uZALBFx3fmeZBORJa0onCEvT95AeWuTCDb8Z3gzbfbcj3naskHgQdwktqRcNYxbqKkegWHEzZ8f5j9SQUXE3AQfKV3AmBBk0FBkDi4LJWnr+joYSsrBGG1/Xv+L/+RcQPTOojW48nDJQWb+ojkVELRxt0kYR36b3K8AivS+zG0fnfIwjIE4az/HQY/+zjRnxk1TaYVWX5exG844dt5Z8tmUrm92iB/tckbb66P0LwmpHiksLJBaEF1LJi5A9x/+ObQaLIHKgXmA5hiBlkRx2Ytkgjmbco1+iJ4gKNOV9MsAfyNt3YlGpVNYWVPniXTtlLnuImuXsskpDu1zNgNxcOkLH8hfuNivcBCUQ6/yF5ihE/yGVLy4HXXFscdO895nZMy4VVUHq1ipAfoSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(83380400001)(6512007)(82960400001)(38100700002)(2616005)(86362001)(6506007)(6666004)(6486002)(966005)(478600001)(1076003)(107886003)(26005)(8936002)(66946007)(4326008)(316002)(5660300002)(8676002)(66476007)(6916009)(66556008)(54906003)(41300700001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FgRzeQPhdTq1vOm+3pUsUvRuqVmzqyJOZPrm6M/dnlyDSpi3sVVxvElqSXY0?=
 =?us-ascii?Q?ZHJkEaAlHI51hkcVGFgkSFcUk+ktGHhV4F3m97vd4NDI43aIdjvXOrfB5kdL?=
 =?us-ascii?Q?q83EoDH8ZhseiXf/BIlUeUEWhQFE3eNJgOmy3jM45MfQmdePJQUFyLSTVYO0?=
 =?us-ascii?Q?9PTQsAHukDaAX9v0SN+QV1Tp2BP3UZdvaSMXXrNHw5L1nwOKJowg12hju1Ty?=
 =?us-ascii?Q?V/E2v6kmpJ7vHYLleTjMnQxv2jDwO/MFCgyULwBEfJLLKpdrh4bD85ux7Qiv?=
 =?us-ascii?Q?YJpP4LPxPT7OFGMy+IOMHeutagw6ClL4iSd322eMD+u+IynpllrCKjxWZq//?=
 =?us-ascii?Q?PFO6/QFO7E1VTvc/nFR4sOE+cJGvOYbG1AbFO5WWWN0J9gvFLzFG4CRTIujl?=
 =?us-ascii?Q?ATCVhxQXs5s6fiSDlUd4b8SuXFX/j8i5YE4VO8XYfPzRFJRKzV0QuymWPTkh?=
 =?us-ascii?Q?o8eLINkPekzLB731NyTMhcs6A1bwAwcs/4BI2GuWf2Zn5hjY42dgjdyU9H9u?=
 =?us-ascii?Q?Wu7D8LS9fFxK11PfbfyELdXkuoTDy/8C6BDngglZ4YyNO5PespEGBhQvR/IC?=
 =?us-ascii?Q?62vBbko6x4X4X3jT3o20A1SInE04siubs/dtiaociSkVsnR9TSdY86jl6/DI?=
 =?us-ascii?Q?7a2UJbngCMDNDfUuCtCvTphEqmYbiCF4n3k7wUpzZxyNSBxufx4X/cctBdVA?=
 =?us-ascii?Q?uw4AuPdBb4Zn8Pd2xwfvE8TVMm9/Fg5XDYZTzw+Z+W4lfTXSYLi/wa91PRRX?=
 =?us-ascii?Q?aiEE1nwiFWB/rytJQySlIOwS/U/hzcf0IcCTqE5G+e17hneGkDR7kVIKUfCO?=
 =?us-ascii?Q?csZ9+qNkuHNzTBwKaN4JO9Pgzjjk4qJeC3BhxtLDrfcTLytfs0etxozp6xCq?=
 =?us-ascii?Q?TH3jwv6aaul97r72kSSU8dr7NpIHxdRVsRzI+bWtnZExOt/xNf5cWnmJUOQP?=
 =?us-ascii?Q?QQVhCOXcqv4v08K/kkkQMxxzbHoWYJdmmWXGKVds3IE4GBzTfBHU69P27wnN?=
 =?us-ascii?Q?5vbIVMuafApyESJkYXklJV2KnzRKwZv4CsU9V9gxAKn0QAsjx2dr1ThQtA88?=
 =?us-ascii?Q?NUu1Ac0Oqv1XvfhxTbsK6RFLmMNLAw3rFF4Qq2MpbJeWIlEyL7dTmNdH6jbL?=
 =?us-ascii?Q?smCAIwqdw/FymyExCMXtSEddb+prOdKNddkeS3PQA9PAxMZqdHq9vSdWNpwR?=
 =?us-ascii?Q?SwmdaNZUme27jUKS+AIx498tG/T8IUJUaAA9oCeEB5cAO8aJQS6uidReOsNS?=
 =?us-ascii?Q?iL03UhtzBW9zrEdJOIr84CKoLS7K8oH97Zg8Br4NiQvJN92qna7yscQw3JS6?=
 =?us-ascii?Q?ciL4hs36AuOJJQpnFt52xQuKw27sf9dGc66dEjA4ohvhYbZCQQEIeT1d1wN6?=
 =?us-ascii?Q?KH0GJQo9fhX2fspoRfZQ6ED+YIVt4pfvvgRtF0k9gnN/4hDQQnC0XPOlSGUs?=
 =?us-ascii?Q?DI9YRGRaT2dzRVZZ1CN9pK4XvanSD8y/clFqxExcAyhzyKWph+C87L+kpWn5?=
 =?us-ascii?Q?Nuf0kBvcVsKXZY78Xg/ReIEi25hOkdCngPmkR0JjKF6sydAALTFhy1fM6GGY?=
 =?us-ascii?Q?9L5W97aGdg41xZjyrEbWpKDo3ClNtDiZc/6669M5xkyEbgtiIziAhQB6iSF0?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 015fbe62-0df1-4400-2fb6-08dbb20860d5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 14:15:25.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxc0/ZVNwnOCe7RFOyWpra62V2Dkl6tZdAs9RwQwMEya785d9zIXG6tvIZ7dHlrGv7PvxPgfX3Co7qSAfhR3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
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



Hello,

kernel test robot noticed "canonical_address#:#[##]" on:

commit: a5199577b1ddae696528d7e4e7a406d5a8f23a7b ("maple_tree: make test code work without debug enabled")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master a48fa7efaf1161c1c898931fe4c7f0070964233a]
[test failed on linux-next/master af3c30d33476bc2694b0d699173544b07f7ae7de]

in testcase: boot

compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


there are below diff between parent and this commit's config in our tests:

@@ -5899,7 +5899,7 @@ CONFIG_STACKTRACE=y
 # CONFIG_DEBUG_SG is not set
 # CONFIG_DEBUG_NOTIFIERS is not set
 # CONFIG_BUG_ON_DATA_CORRUPTION is not set
-CONFIG_DEBUG_MAPLE_TREE=y
+# CONFIG_DEBUG_MAPLE_TREE is not set
 # end of Debug kernel data structures


we observed a5199577b1 shows various issues as below.

acd4de60dd356ffe a5199577b1ddae696528d7e4e7a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :95          17%          16:91    dmesg.Kernel_panic-not_syncing:Fatal_exception
           :95          78%          74:91    dmesg.Kernel_panic-not_syncing:System_is_deadlocked_on_memory
           :95          78%          74:91    dmesg.Mem-Info
           :95          78%          74:91    dmesg.Out_of_memory_and_no_killable_processes
           :95          17%          16:91    dmesg.RIP:mas_safe_min
           :95          17%          16:91    dmesg.canonical_address#:#[##]
           :95          78%          74:91    dmesg.invoked_oom-killer:gfp_mask=0x



since we are not sure if they are expected after this commit, just report FYI.



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309102139.f96019d5-oliver.sang@intel.com


[  444.720153][   T35] Writes:  Total: 23172604  Max/Min: 11656389/11516215   Fail: 0
[  506.160379][   T35] Writes:  Total: 25012806  Max/Min: 12602093/12410713   Fail: 0
[  567.601589][   T35] Writes:  Total: 27405411  Max/Min: 13810351/13595060   Fail: 0
[  577.965424][    T1] BUG at check_dup_gaps:2486 (1)
[  577.966713][    T1] Pass: 3756763 Run:3756764
[  577.967637][    T1] general protection fault, probably for non-canonical address 0xdffffc000000001e: 0000 [#1] PREEMPT KASAN
[  577.969546][    T1] KASAN: null-ptr-deref in range [0x00000000000000f0-0x00000000000000f7]
[  577.969546][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.4.0-rc4-00075-ga5199577b1dd #1
[  577.969546][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 577.969546][ T1] RIP: 0010:mas_safe_min (kbuild/src/consumer/lib/maple_tree.c:726) 
[ 577.969546][ T1] Code: e8 d9 3b 90 fe 84 db 74 37 e8 d0 3b 90 fe 0f b6 db b8 ff ff 37 00 ff cb 48 c1 e0 2a 48 63 db 49 8d 1c dc 48 89 da 48 c1 ea 03 <80> 3c 02 00 74 08 48 89 df e8 fe 0f b8 fe 4c 8b 23 49 ff c4 eb 28
All code
========
   0:	e8 d9 3b 90 fe       	call   0xfffffffffe903bde
   5:	84 db                	test   %bl,%bl
   7:	74 37                	je     0x40
   9:	e8 d0 3b 90 fe       	call   0xfffffffffe903bde
   e:	0f b6 db             	movzbl %bl,%ebx
  11:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  16:	ff cb                	dec    %ebx
  18:	48 c1 e0 2a          	shl    $0x2a,%rax
  1c:	48 63 db             	movslq %ebx,%rbx
  1f:	49 8d 1c dc          	lea    (%r12,%rbx,8),%rbx
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 fe 0f b8 fe       	call   0xfffffffffeb81036
  38:	4c 8b 23             	mov    (%rbx),%r12
  3b:	49 ff c4             	inc    %r12
  3e:	eb 28                	jmp    0x68

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	74 08                	je     0xe
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 fe 0f b8 fe       	call   0xfffffffffeb8100c
   e:	4c 8b 23             	mov    (%rbx),%r12
  11:	49 ff c4             	inc    %r12
  14:	eb 28                	jmp    0x3e
[  577.969546][    T1] RSP: 0000:ffff88811037f9a8 EFLAGS: 00010206
[  577.969546][    T1] RAX: dffffc0000000000 RBX: 00000000000000f0 RCX: 0000000000000000
[  577.969546][    T1] RDX: 000000000000001e RSI: ffffffff829b7dfb RDI: ffff88811037fc50
[  577.969546][    T1] RBP: ffff88811037fc50 R08: 0000000000000001 R09: 0000000000000100
[  577.969546][    T1] R10: ffffffff81504a19 R11: ffffffff848decbf R12: 0000000000000000
[  577.969546][    T1] R13: 000000000000001f R14: ffffffffffffffff R15: dffffc0000000000
[  577.969546][    T1] FS:  0000000000000000(0000) GS:ffffffff83cca000(0000) knlGS:0000000000000000
[  577.969546][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  577.969546][    T1] CR2: ffff88843ffff000 CR3: 0000000003ca8000 CR4: 00000000000406f0
[  577.969546][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  577.969546][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  577.969546][    T1] Call Trace:
[  577.969546][    T1]  <TASK>
[ 577.969546][ T1] ? __die_body (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421) 
[ 577.969546][ T1] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:462) 
[ 577.969546][ T1] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:786 kbuild/src/consumer/arch/x86/kernel/traps.c:728) 
[ 577.969546][ T1] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:564) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230910/202309102139.f96019d5-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

