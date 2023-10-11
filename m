Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595B77C4CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJKIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJKIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:09:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DD92;
        Wed, 11 Oct 2023 01:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697011754; x=1728547754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/UCxlTrhnns8Rb4AfoMFc7jo+o5WNJsFVrhu0pLvZPo=;
  b=NEktFmMZQTMbcoRj9trGp4papF2Olm8cF65369slUo6E9Lke2rwmYXM1
   IpmCwVMfH3fMgbHt5qS0ZH7qyTjjegCkGdON3LSVKz8/z5otPA0/LN7Ek
   aGPBFnhkc063qpnYh/LS5PX+d1leOVrsGXM2GWKMWaLs3yD6vG1EuVI1P
   asX2lcA+8W7OKbmBgDaYZaH8dd2xl9TCJucGnB1fT2O1uocE5A3mp5+QT
   WyyIKvUhOhvdE1zZLGMLYJsQJqifl5TXZLCvFrkLrO0s+qtNPN5ZFfpiu
   ZM32znyigXePcO6zIOtgQPZZpnOoBNqdGfU8rQCFpyVpqq5BrXCQhZpt0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="384459201"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="384459201"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="757461465"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="757461465"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 01:09:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 01:09:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 01:09:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 01:09:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 01:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0LXRFi9lHnhQSPp0EA58YJDZqRjuMZxxssZX/fPRWAYLfMjXoBJn2hPKbKRONhmOT9is9r1RLYa3hRZsopXDGA3JYZRfgnZioMrQZ3R7xiW+QiC03/8NCoslFqEanyeUBZAuxE5TAB2POf3PhNPa4fhQfAlPo7w8sBosApRuY8/LNCwS7MxCL8OFBJLRYBdVcYmaHBeSLAaRoTtzIzClqEE0heTLuVZ2d4RdjUmQinZGiT/STqvA2teppRLp64pVntA2VgKqZuedUMrjXYrPQ+RulLhmT++HU7yUyF1DAcFbbyPVZwNcEHogZRC+/JTPte+hfEyVurwD1rcRX900A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5qnq+LZM4d2+68rCg6n9R4FZOVea6v8GX2VsGFf6F4=;
 b=U874FTYNsA+xrjGMoPGASPY0z9Ro0NR/DHLx7XhMEfjmGe91T5EqLcUAfdaOb5ocjjMp+WPnrT7zhyDXBO63vW7b1KOuHn0j8PzD/cL+2ouDoqvwL59pFoeOV9NmZJePnFViqfniVWkFVHDdmOi+puE1/wQSPMbaBuKRw//0sSTH+doUQgLawkYPG/B2cKVankT8ByEbZGH7FRCYz6S2w/ZurcN6475UjYpAdxihFc5x2NNhx0hb4Sp9Y80taLs5K6rQU/gpZDyars1MxekWgv1COFPQYJnW1rMDNaM/TchlHvwshMLc0y9GUv2I+/Kq4QU8FaPaXbZIKaVcjDVGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB5791.namprd11.prod.outlook.com (2603:10b6:a03:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 08:08:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Wed, 11 Oct 2023
 08:08:58 +0000
Date:   Wed, 11 Oct 2023 16:08:50 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     James Morse <james.morse@arm.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [rmk-arm:aarch64/hotplug-vcpu/v6.6-rc1] [ACPI]  9d0b332731: Kernel
 panic - not syncing: Fatal exception
Message-ID: <202310111516.ba5ea8dc-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ab5825-039f-4774-13bb-08dbca31524b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BMqqugHOV3iAxtvqCFA/vKtSS4c7p9M/DWVBhTQxjFnNthRddX8mbsXHZrIKUJOxTn7JjU8ClkTlgHl0uYuTc6/UQ7hrUTM00sU1Dyx1ICSerFMI+1sFGsHEi2nL6fldA6iTPREDsYfrxAFeVJjGuE2OBke6L9XvLPQrZ2xZg8doARRyTSBvcf0db1DjUZSUWtVJ2G6HCs2PAkrHSOX4QACl5Vtv+SFqs8njnre/3eGeWriMXiTyOLjtjF5sXBYCDk4kSRPifP2o7IpxN+waNVxiFCso1QB9LklXD/IsDCD9DyvUX7DQugvUBX1V7czNj9af7dXP3mQgZln1+utx6tBv5bJZb0ifwsFYRAKF2ezyjNaCG9QDv0kiup3dD+8ZJAAnh03rrpMDHtJVu/mcRGEFj21M7MUByG2HXgBMnJZkAf1mmAKyyqAY3LT7oQOIh7ZWJeHDzLNg3Q9sH4eI+6ib/RuxJwlV05K2B/RG49sxuek8M60UaQDMJR4QEj/+Xd4KiBAziw77UjkK1JLlNNIc7YxTw9WkjQY1yRYh3wpxVerVAEdgkT1LeQioKAzbNWz7B4U9O7PYL/n2E/GtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6512007)(107886003)(1076003)(6506007)(478600001)(6486002)(966005)(2616005)(6666004)(45080400002)(8676002)(83380400001)(30864003)(66476007)(8936002)(316002)(66556008)(5660300002)(66946007)(2906002)(4326008)(41300700001)(6916009)(82960400001)(26005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlDc0zX+vnXgvUAWVw02HNcBcACU+g3M+RIHKyd17altaYJBW7+NPoBWXggO?=
 =?us-ascii?Q?leJM/H5+u/y/ZUWEVMo9qP9eXmCZXKT/ArIcoFjjir9Ut9qIbw3Uin7n88IW?=
 =?us-ascii?Q?OGvgg9cJv5gGK6lYBRVZindqj05F75IZDGQQ5e7JEXRtcC2/euiFdIdAeYd0?=
 =?us-ascii?Q?y2Fyed/N1CRPSeSrlHWLlz5WlQxHKS0ZfKoD0dejdFpBkzBe/bPdE1UxaftI?=
 =?us-ascii?Q?ZmaUfmdLUWhRwcleB9Ru2q+NmCl7F3S0RpNZMktO7m8ggwA+RyKd7Us9RoJe?=
 =?us-ascii?Q?mpdpNNDXZfPLEqkR3fIuKHEJ+6LlDZp9zmMPCaiMhIrzKg1qHZKAmAaVWIoZ?=
 =?us-ascii?Q?Vm9/JHydD0DWp/JswksLejip9hJfeRX2/fg11X9z3djIpxeIXpSAHH0BRaeE?=
 =?us-ascii?Q?AYgyjnJjRqETc5LUbiDLHquI9VO3vPlPtaZezegJYrg0wrzuoOfv+KJKXfZB?=
 =?us-ascii?Q?3X3lASQPZ+Gi3Ceh8rVH763DVsS/JdGG/d4v/li3eQZ4IjYmGFspuaS4i6fc?=
 =?us-ascii?Q?kSVnip/JRxHNCZLrlPsXis5bDeNL+K37jNHeeaWtpRtivXh5knHLmiqhXwN9?=
 =?us-ascii?Q?wiCj9bTHlqowtUo4fZPqpq/L9W0/gWeTZLAYgyCInLU6iLuH+am+qoCpQ6b5?=
 =?us-ascii?Q?yaC25y462/2e864UIKue82uZcxGkd56i4VBMnhopFPwYHVeptTmTTLY3jg0p?=
 =?us-ascii?Q?Ev1wv+nwRBVd8SsPE0JyqSz03NqR2f885cQboxF18WXGLBqCionezM5ep0nH?=
 =?us-ascii?Q?L24NubBU3vsDXAQLIQEsnsZdY9wDsuktQaA0+Ak+Adxxc3pP5zjVb+n0TNon?=
 =?us-ascii?Q?vADdIQVMrkORIC3iokOyx0S6oPq3qpcS+c9V7CUwD7kcPCjX1YjhjSkpuvIJ?=
 =?us-ascii?Q?xXG1aQsloJTgKRSyv6/spr7WM3oe+hVkWW4DxEr9J+F+dz6/lTPCQtgVKWbJ?=
 =?us-ascii?Q?n1KMz5+JvZXKJdfD+VV4gLeuzc8gs391NINaw7md6sVUsWXxDUMWL/Q0DxbL?=
 =?us-ascii?Q?K6M0hTfdM/H4yGc9Vzc07iq1NbaepPKLvSbCDoH01tHNjejapUy4i3hXcheQ?=
 =?us-ascii?Q?iEW1T7X46mYEAD9X7Y8Gonz3kmNhCiBKMVf16N+zQsYy1dP5FzBZs9dwWaS6?=
 =?us-ascii?Q?Eo5GWhqbwlrG1n4dYbVENPpJutHFBVOwAqX5dixpljWd3naOTnxSdMzTxQIh?=
 =?us-ascii?Q?r1NU7X3VWgswE+ublZXy+TR8I2HCcpU+UawrT+2I7fpnoS6wGEq5Nt2in8NW?=
 =?us-ascii?Q?MXbU1914DN8hRhPe5wCR9Q2NFGE1u1TbU+VbED6Z0o6lFwqUaV6kCiMMqhzC?=
 =?us-ascii?Q?BbCD1xdWOtewaWPqAw8KIb/DkSVnSctSlDX9tZv9eQjopigscHOJv8t4zbdW?=
 =?us-ascii?Q?7TBKqPexVyRpQQ3vD4SMQBvf2mtXg5N/ZFyPA78fkpKGVjUpvLPJv/l/4xhm?=
 =?us-ascii?Q?qK7F6Sx5ZniQfyvvx1nOCcExeobssLBIzKdj6NOkzJ1+env3taYCX3lBjrBe?=
 =?us-ascii?Q?yb5fse0sKif+Ts30YOGC557kvqFKL/wJeXpNg4rogRGyVE0HwD4XTcYh1AUQ?=
 =?us-ascii?Q?OF2IzTkokiawnQvloUGRx3XPB933X9IzxJsG31UX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ab5825-039f-4774-13bb-08dbca31524b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 08:08:58.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR/H2m2ioED1mZMbfwRg3LiEShNEmLjD4PqCJj2IbHHHvwl1DT+GpVeaIkUQEuNwVu9Sok4j6hln7a+cFfrYSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5791
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "Kernel panic - not syncing: Fatal exception" on:

commit: 9d0b33273119d6c0d9112a28c2cc2eb8c671fbeb ("ACPI: processor: Register all CPUs from acpi_processor_get_info()")
git://git.armlinux.org.uk/~rmk/linux-arm aarch64/hotplug-vcpu/v6.6-rc1

in testcase: boot

compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310111516.ba5ea8dc-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231011/202310111516.ba5ea8dc-oliver.sang@intel.com



we are sorry that the dmesg in above link is not full and misses final crash.
this is due to some of our service issues which is under investigation now.

below further information is captured from serial:

[    4.434655][    T1] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    4.442711][    T1] .... node  #1, CPUs:   #24 #25 #26 #27 #28 #29 #30 #31 #32 #33 #34 #35 #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47
[    0.676292][    T0] masked ExtINT on CPU#1
[    0.676292][    T0] masked ExtINT on CPU#2
[    0.676292][    T0] masked ExtINT on CPU#3
[    0.676292][    T0] masked ExtINT on CPU#4
[    0.676292][    T0] masked ExtINT on CPU#5
[    0.676292][    T0] masked ExtINT on CPU#6
[    0.676292][    T0] masked ExtINT on CPU#7
[    0.676292][    T0] masked ExtINT on CPU#8
[    0.676292][    T0] masked ExtINT on CPU#9
[    0.676292][    T0] masked ExtINT on CPU#10
[    0.676292][    T0] masked ExtINT on CPU#11
[    0.676292][    T0] masked ExtINT on CPU#12
[    0.676292][    T0] masked ExtINT on CPU#13
[    0.676292][    T0] masked ExtINT on CPU#14
[    0.676292][    T0] masked ExtINT on CPU#15
[    0.676292][    T0] masked ExtINT on CPU#16
[    0.676292][    T0] masked ExtINT on CPU#17
[    0.676292][    T0] masked ExtINT on CPU#18
[    0.676292][    T0] masked ExtINT on CPU#19
[    0.676292][    T0] masked ExtINT on CPU#20
[    0.676292][    T0] masked ExtINT on CPU#21
[    0.676292][    T0] masked ExtINT on CPU#22
[    0.676292][    T0] masked ExtINT on CPU#23
[    0.676292][    T0] masked ExtINT on CPU#24
[    0.676292][    T0] smpboot: CPU 24 Converting physical 0 to logical die 1
[    0.676292][    T0] masked ExtINT on CPU#25
[    0.676292][    T0] masked ExtINT on CPU#26
[    0.676292][    T0] masked ExtINT on CPU#27
[    0.676292][    T0] masked ExtINT on CPU#28
[    0.676292][    T0] masked ExtINT on CPU#29
[    0.676292][    T0] masked ExtINT on CPU#30
[    0.676292][    T0] masked ExtINT on CPU#31
[    0.676292][    T0] masked ExtINT on CPU#32
[    0.676292][    T0] masked ExtINT on CPU#33
[    0.676292][    T0] masked ExtINT on CPU#34
[    0.676292][    T0] masked ExtINT on CPU#35
[    0.676292][    T0] masked ExtINT on CPU#36
[    0.676292][    T0] masked ExtINT on CPU#37
[    0.676292][    T0] masked ExtINT on CPU#38
[    0.676292][    T0] masked ExtINT on CPU#39
[    0.676292][    T0] masked ExtINT on CPU#40
[    0.676292][    T0] masked ExtINT on CPU#41
[    0.676292][    T0] masked ExtINT on CPU#42
[    0.676292][    T0] masked ExtINT on CPU#43
[    0.676292][    T0] masked ExtINT on CPU#44
[    0.676292][    T0] masked ExtINT on CPU#45
[    0.676292][    T0] masked ExtINT on CPU#46
[    0.676292][    T0] masked ExtINT on CPU#47
[    4.669736][    T1] 
[    4.677645][    T1] .... node  #0, CPUs:   #48 #49 #50 #51 #52 #53 #54 #55 #56 #57 #58 #59 #60 #61 #62 #63 #64 #65 #66 #67 #68 #69 #70 #71
[    4.689709][    T1] .... node  #1, CPUs:   #72 #73 #74 #75 #76 #77 #78 #79 #80 #81 #82 #83 #84 #85 #86 #87 #88 #89 #90 #91 #92 #93 #94 #95
[    0.676292][    T0] masked ExtINT on CPU#48
[    4.712712][    T1] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html fo
r more details.
[    4.714070][    T1] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_m
mio_stale_data.html for more details.
[    0.676292][    T0] masked ExtINT on CPU#49
[    0.676292][    T0] masked ExtINT on CPU#50
[    0.676292][    T0] masked ExtINT on CPU#51
[    0.676292][    T0] masked ExtINT on CPU#52
[    0.676292][    T0] masked ExtINT on CPU#53
[    0.676292][    T0] masked ExtINT on CPU#54
[    0.676292][    T0] masked ExtINT on CPU#55
[    0.676292][    T0] masked ExtINT on CPU#56
[    0.676292][    T0] masked ExtINT on CPU#57
[    0.676292][    T0] masked ExtINT on CPU#58
[    0.676292][    T0] masked ExtINT on CPU#59
[    0.676292][    T0] masked ExtINT on CPU#60
[    0.676292][    T0] masked ExtINT on CPU#61
[    0.676292][    T0] masked ExtINT on CPU#62
[    0.676292][    T0] masked ExtINT on CPU#63
[    0.676292][    T0] masked ExtINT on CPU#64
[    0.676292][    T0] masked ExtINT on CPU#65
[    0.676292][    T0] masked ExtINT on CPU#66
[    0.676292][    T0] masked ExtINT on CPU#67
[    0.676292][    T0] masked ExtINT on CPU#68
[    0.676292][    T0] masked ExtINT on CPU#69
[    0.676292][    T0] masked ExtINT on CPU#70
[    0.676292][    T0] masked ExtINT on CPU#71
[    0.676292][    T0] masked ExtINT on CPU#72
[    0.676292][    T0] masked ExtINT on CPU#73
[    0.676292][    T0] masked ExtINT on CPU#74
[    0.676292][    T0] masked ExtINT on CPU#75
[    0.676292][    T0] masked ExtINT on CPU#76
[    0.676292][    T0] masked ExtINT on CPU#77
[    0.676292][    T0] masked ExtINT on CPU#78
[    0.676292][    T0] masked ExtINT on CPU#79
[    0.676292][    T0] masked ExtINT on CPU#80
[    0.676292][    T0] masked ExtINT on CPU#81
[    0.676292][    T0] masked ExtINT on CPU#82
[    0.676292][    T0] masked ExtINT on CPU#83
[    0.676292][    T0] masked ExtINT on CPU#84
[    0.676292][    T0] masked ExtINT on CPU#85
[    0.676292][    T0] masked ExtINT on CPU#86
[    0.676292][    T0] masked ExtINT on CPU#87
[    0.676292][    T0] masked ExtINT on CPU#88
[    0.676292][    T0] masked ExtINT on CPU#89
[    0.676292][    T0] masked ExtINT on CPU#90
[    0.676292][    T0] masked ExtINT on CPU#91
[    0.676292][    T0] masked ExtINT on CPU#92
[    0.676292][    T0] masked ExtINT on CPU#93
[    0.676292][    T0] masked ExtINT on CPU#94
[    0.676292][    T0] masked ExtINT on CPU#95
[    4.917591][    T1] smp: Brought up 2 nodes, 96 CPUs
[    4.924513][    T1] smpboot: Max logical packages: 2
[    4.925656][    T1] smpboot: Total of 96 processors activated (403200.00 BogoMIPS)
[    5.186590][  T593] node 1 deferred pages initialised in 257ms
[    5.186860][  T592] node 0 deferred pages initialised in 257ms
[    5.212648][    T1] devtmpfs: initialized
[    5.216686][    T1] x86/mm: Memory block size: 2048MB
[    5.224648][    T1] ACPI: PM: Registering ACPI NVS region [mem 0x67a30000-0x6845ffff] (10682368 bytes)
[    5.234938][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    5.244753][    T1] futex hash table entries: 32768 (order: 9, 2097152 bytes, vmalloc)
[    5.253275][    T1] pinctrl core: initialized pinctrl subsystem
[    5.260790][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    5.267923][    T1] audit: initializing netlink subsys (disabled)
[    5.274549][  T690] audit: type=2000 audit(1696931170.998:1): state=initialized audit_enabled=0 res=1
[    5.274803][    T1] thermal_sys: Registered thermal governor 'fair_share'
[    5.283695][    T1] thermal_sys: Registered thermal governor 'bang_bang'
[    5.290657][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    5.297657][    T1] thermal_sys: Registered thermal governor 'user_space'
[    5.304554][    T1] cpuidle: using governor menu
[    5.315654][    T1] Detected 1 PCC Subspaces
[    5.320661][    T1] Registering PCC driver as Mailbox controller
[    5.327622][    T1] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    5.335700][    T1] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    5.343778][    T1] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    5.353697][    T1] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as E820 entry
[    5.361700][    T1] PCI: Using configuration type 1 for base access
[    5.368813][   T19] BUG: kernel NULL pointer dereference, address: 0000000000000030
[    5.369510][   T19] #PF: supervisor read access in kernel mode
[    5.369510][   T19] #PF: error_code(0x0000) - not-present page
[    5.369510][   T19] PGD 0 P4D 0 
[    5.369510][   T19] Oops: 0000 [#1] SMP NOPTI
[    5.369510][   T19] CPU: 0 PID: 19 Comm: cpuhp/0 Not tainted 6.6.0-rc1-00015-g9d0b33273119 #1
[    5.369510][   T19] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[    5.369510][   T19] RIP: 0010:sysfs_merge_group+0x1e/0x130
[    5.369510][   T19] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 55 31 d2 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 10 48 8b 36 <48> 8
b 7f 30 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 c7 04
[    5.369510][   T19] RSP: 0000:ffffc90008887e10 EFLAGS: 00010282
[    5.369510][   T19] RAX: 0000000000000007 RBX: ffffffff82207680 RCX: 00000000000001b0
[    5.369510][   T19] RDX: 0000000000000000 RSI: ffffffff822b9088 RDI: 0000000000000000
[    5.369510][   T19] RBP: 0000000000000000 R08: ffff88bf7f61c148 R09: ffff888107728090
[    5.369510][   T19] R10: ffff88bf7f61c120 R11: 00000000ffffffff R12: 0000000000000000
[    5.369510][   T19] R13: ffff88bf7f61c120 R14: ffffffff81046350 R15: ffff88bf7f61c148
[    5.369510][   T19] FS:  0000000000000000(0000) GS:ffff88bf7f600000(0000) knlGS:0000000000000000
[    5.369510][   T19] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.369510][   T19] CR2: 0000000000000030 CR3: 000000807ea18001 CR4: 00000000007706f0
[    5.369510][   T19] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.369510][   T19] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.369510][   T19] PKRU: 55555554
[    5.369510][   T19] Call Trace:
[    5.369510][   T19]  <TASK>
[    5.369510][   T19]  ? __die+0x23/0x70
[    5.369510][   T19]  ? page_fault_oops+0xa4/0x170
[    5.369510][   T19]  ? exc_page_fault+0x67/0x130
[    5.369510][   T19]  ? asm_exc_page_fault+0x26/0x30
[    5.369510][   T19]  ? __pfx_intel_epb_online+0x10/0x10
[    5.369510][   T19]  ? sysfs_merge_group+0x1e/0x130
[    5.369510][   T19]  ? __switch_to_asm+0x38/0x70
[    5.369510][   T19]  intel_epb_online+0x37/0x70
[    5.369510][   T19]  cpuhp_invoke_callback+0xf1/0x3b0
[    5.369510][   T19]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    5.369510][   T19]  cpuhp_thread_fun+0xde/0x170
[    5.369510][   T19]  smpboot_thread_fn+0xb0/0x170
[    5.369510][   T19]  kthread+0xcd/0x130
[    5.369510][   T19]  ? __pfx_kthread+0x10/0x10
[    5.369510][   T19]  ret_from_fork+0x31/0x70
[    5.369510][   T19]  ? __pfx_kthread+0x10/0x10
[    5.369510][   T19]  ret_from_fork_asm+0x1b/0x30
[    5.369510][   T19]  </TASK>
[    5.369510][   T19] Modules linked in:
[    5.369510][   T19] CR2: 0000000000000030
[    5.369510][   T19] ---[ end trace 0000000000000000 ]---
[    5.369510][   T19] RIP: 0010:sysfs_merge_group+0x1e/0x130
[    5.369510][   T19] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 55 31 d2 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 10 48 8b 36 <48> 8
b 7f 30 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 c7 04
[    5.369510][   T19] RSP: 0000:ffffc90008887e10 EFLAGS: 00010282
[    5.369510][   T19] RAX: 0000000000000007 RBX: ffffffff82207680 RCX: 00000000000001b0
[    5.369510][   T19] RDX: 0000000000000000 RSI: ffffffff822b9088 RDI: 0000000000000000
[    5.369510][   T19] RBP: 0000000000000000 R08: ffff88bf7f61c148 R09: ffff888107728090
[    5.369510][   T19] R10: ffff88bf7f61c120 R11: 00000000ffffffff R12: 0000000000000000
[    5.369510][   T19] R13: ffff88bf7f61c120 R14: ffffffff81046350 R15: ffff88bf7f61c148
[    5.369510][   T19] FS:  0000000000000000(0000) GS:ffff88bf7f600000(0000) knlGS:0000000000000000
[    5.369510][   T19] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.369510][   T19] CR2: 0000000000000030 CR3: 000000807ea18001 CR4: 00000000007706f0
[    5.369510][   T19] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.369510][   T19] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.369510][   T19] PKRU: 55555554
[    5.369510][   T19] Kernel panic - not syncing: Fatal exception


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

