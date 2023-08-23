Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9899D785B10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbjHWOtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbjHWOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:49:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD4EE77
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692802155; x=1724338155;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=npFrrZhUwRIQUlAyE2we6/eksyTiIhjGZi3r9SUB1G0=;
  b=d/a+s09hRepsKjCzWWaMiJ0RdDK9AQeyeh8TDxkTMXRfyIgEGae/11mY
   onV9LC7NvhhenofSuXESt6iXWpN6R/SWoYYO3E7ErfA5aAdvt9N2VpWPu
   kCbm9nmCRVTPe2CQ2QFFK6Inqf4OIYiVvrk0VriBmQ1X7FIVeHCfTYsgD
   fWe7yOn1ukhYZ6vjwWAlTC24+kU6OPg2jzOYU9T/PULoRHdK9bkFpmrOA
   6Z5LsSqhF7NqbRk+duX30N2rLpPB8EDFTy2m46IEncuBPGeC+oQyZ3ybr
   Rb0ihCWfD8JAvKNi7EG7lokVogZft7YLcrMMsIRYCq+cp7DRlcrHUGW6w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373066535"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373066535"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 07:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="736702000"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="736702000"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2023 07:49:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 07:49:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 07:49:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 07:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6tfoEEha7wyNmC446Yxuy0JllzrmIhX9/ouLOfHZ5VmlAwcVb8qIP8ekbgvQwTXdHtoHv+i/AZaG8uP8CWYoycsh18gL3FF22kCiHnGm+9hAyPZfoC4KB9eDca9VwSuxLdkh3n7lzU9GsrVebb0/GqSkpU0pIG+MBT4NOPfQpemCFjFymr0H8xUewtHLE+xRRi+7T7aLiKUgZtJhrlHjll7QFjDZxcz3at+7aAfsQkV5KNhK7XYLGpGJVPi3rMOiH24X7Fi6fuillFLTg21xUpXfheDONi4b3iryZ71mdXXxiTCLXhqRbgGJLqX9dNgnH5e0DpPKvaVD+k9zWPpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi0sDv56JlFktM9Hxuh9S0qGlq7ytEkebjJtxdzLDTc=;
 b=S/vC16NFBd9ju0bLIKI31kIHtVT75GYnXbqsvYh5q4LJmziDqCRNbePT4FgdFemWcgz69e59/1g+epUCHaANsxaRuL6wHkXOfDxR/eb5+ZaiDqFVVwSa7YSH18b9L+Z1Dtqv2TeZD7k/JCPKoDjM1ajx94H4e+eXkz3VzT8QIA0NSgTQ1dCYUAZ57YZQbFXiZ6NaoXZ8sA1YAUtcXOO0ZwV2ll3dvT60BcNFlbEWejQZ0jSpNzgScJvSRBh2J3WJBlETr1uyu/b4cpoA0CCNXl/yYEPY1fSYCHO1gDQ7NK69RprgWil1oNB1uCvD8AhWPs8Zgj24YadZhG9UEtzaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6821.namprd11.prod.outlook.com (2603:10b6:806:29d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:49:08 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:49:08 +0000
Date:   Wed, 23 Aug 2023 22:48:58 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Song Liu <song@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [kallsyms]  8cc32a9bbf:
 Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:test_entry
Message-ID: <202308232200.1c932a90-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 3883b798-08a8-47dd-2fd6-08dba3e81b37
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9OgkYZifzFYPs1uDjyvtz1eFq3MsUuqSa6hbEkvRUUe3yHQQW706c0xydE7n+0K1eBCWtDA3IQildTCWn2MLCXqLN0Rz+Kzc2yYFCt26/Mkqc3A4XvfmVfXZh+79JmzW8lJYuX0B45EW4yTlApmO74+v+nxAqVZ1TUg1t7yDsie/bA3ev+gw09KcRHn3LwzoL5Po+4Z4zQgGfONZui1OzzXArk3ZGFr4CQ+gfLCS3omS7KDe2QkCKDS5k2n5olyoMcQ9XEu9qqIhO7G0Amxi+kAgc9VY7NkY+zT/pwpWjv94HgzdDKNAcjtuKOpsOkCJ9c9ywugTLc+SbEnhhTD+N0JH22rK934WntoZyAsukfVM0gUlOU4ZOXv5s9xo0hVYOj/yQaga4KregxrPi0kxRnUQVoh3NVTbDHDwfFpn9xn+JRHspy54zsPgTZFutc0D/bsc0YpmJdSx7KMRLIQU9DtHtKBiqlTkaQ7ohZnTz3mkjW6SmB7RFL4+dpST6dAFhkGUNpf1SopkC8nbdieVa9m0FxYf0xrH0YFZievDxqf3g7qiiOE1iU/xA4r6HmMVLFVZUebgd8/BqIa1/XOtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(1800799009)(186009)(451199024)(966005)(6666004)(6486002)(478600001)(1076003)(107886003)(6506007)(6512007)(2616005)(2906002)(26005)(5660300002)(8676002)(8936002)(66946007)(54906003)(36756003)(41300700001)(6916009)(86362001)(316002)(4326008)(66556008)(66476007)(82960400001)(38100700002)(83380400001)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/yIGePZzfMuQCx7W9Al7QniIJpItk+1BsR+WmW46QuP6fJUpPKwnFjrZn56?=
 =?us-ascii?Q?U5IGjURc4tFKzvvQoNvOOVQ+t0LuEamJJU2dbrjBsGHc23Nyb79eCccVtZk0?=
 =?us-ascii?Q?ec4317G7IzwFNS5+8K11JKRayMzVwxujw3/+0lNYmcFq6s7oU+w9vKD5/Bul?=
 =?us-ascii?Q?FNazqWWbxv0VZHQ6U754bU7fEWqP0Ylxrh0DwueOWPATeYD6x2G95c9VBAU6?=
 =?us-ascii?Q?HFlPCHKvYE9c6VwLn8duMaFz9gG6lE+SOExV9dm5uRUFrRBK+lr48SsxpTvz?=
 =?us-ascii?Q?z1Q9a6r+YQCboh33Dlh6I3+AhX4sMysRdbE7vc+pBcTCB0vShVRacRbrRWnc?=
 =?us-ascii?Q?/t7MpZpGHE2ptl840ioXactu+piD7tf4qOEtw1vVmiuMMc7kdrM5OQB3swof?=
 =?us-ascii?Q?ZUNkHNF/rlUHZVBWNo1Q67d4PGTbxSpYO56N9Jb9faRO6iZcvzqVh7p4iEJg?=
 =?us-ascii?Q?BIdgKjFsu9OncrApX33D8CMjyDUOKk4WF/OwjanCH1H8g+XPnMe3JqzWJRrT?=
 =?us-ascii?Q?aaXR3jzWLN9utlEsEdLRlM8eotMr8iFQTaCI2NbAybp4+3RsaV2VZjfZchhT?=
 =?us-ascii?Q?wt/y7oBG7ojTZXvy+Fhc1zLBKQ7+FpHjgwvpDIVvxfUrnPRKN0opwY8S0H73?=
 =?us-ascii?Q?P7nTnwgvUc05Bl4TwTkwGmMkbHRB1hBMA722xSsEln1yWrdSY3PkvG0waBcx?=
 =?us-ascii?Q?mG0Ry07SzmfAxsNeDioroubrjooK1kT8LYdaf7kq4uXlQOUBz7LYL8s6AMQe?=
 =?us-ascii?Q?V4wLfBoNsx2963QoGxe/BkV5fZZy0hMQwpFyeafr4CXzeH1sQKPExi0N8CgH?=
 =?us-ascii?Q?w1AyY89xe4axc4NcrrBdBPsVDSvEilqs+h/P2guxuUXZcDNV6URtVresjEYt?=
 =?us-ascii?Q?5DqSXzmOX6HCxSxvZt9cAqtSDBKhA4SuPieZo3A2QG5xb4A0wGML8u3NNjFS?=
 =?us-ascii?Q?hRDiRk9Yiqfc4NSWTgnY/deI2aQO+YRrtE934mVv2JLa/FpvxPwBLSlK09S+?=
 =?us-ascii?Q?B9Y9qnReALbWCKki8Ece0Bp+6oD4MExdojSqYQ5HMo9RR/f0piQvcMmhd0QK?=
 =?us-ascii?Q?hazv+mZr3arWDcpx3oL5ZA+fPbYx9S3QMZjlLeTAAaYKcjcq5gtmPLz5HYey?=
 =?us-ascii?Q?UDlHaK/Z7+dDq7P9UYajkGP61H6FJQ9/VStq07JxFg3TlfaD8cd3JMdRNfQ+?=
 =?us-ascii?Q?NFE24NwYwH+YZceChQAaE2Oif2DMRakTfIeWFn5W9LavIXZB9UtQkEHkKj9u?=
 =?us-ascii?Q?Bnx0p9UMHQfsE1U+1SFuXVDy0OZS/86FsVP9bHAW6EUp4H9w2MliyD3h/Ng1?=
 =?us-ascii?Q?+gf8Fmy3TNvfOpsnjlyyvIKucq+ZDrE1JTCgZB/pknko/n3Pgvmnuzw7WPZe?=
 =?us-ascii?Q?ZzcbeeneUN9nQfuZQkKgKexpe7LLxGfE05cjNzsaNbPbG/r7LuZ8Rn9aCFeZ?=
 =?us-ascii?Q?a8SBc1XStpbh/qVJx7W9Ao3rtw8f68oYqcAQCHtZdNp2fZlltlH5lKjEWaha?=
 =?us-ascii?Q?cv1zMz8Rwfc7co3l1x23V/6WKbiVLgFAksYttx1qF95RmcUZRZw0zAr8MB+D?=
 =?us-ascii?Q?mNyzJ3rdVHenX8uCBzJ3sfUJxly9GamAQm7oqOFpTZOdAR7bngev2F9wkcx2?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3883b798-08a8-47dd-2fd6-08dba3e81b37
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:49:08.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja/4ljBmKvQWD4+VrwrkotZ6JXes9plURhRRjr/Aa7eWPHGMfIYMWR5+cI+3Gmdz/LLNIYjs1V9qa2iVoeirZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6821
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

kernel test robot noticed "Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:test_entry" on:

commit: 8cc32a9bbf2934d90762d9de0187adcb5ad46a11 ("kallsyms: strip LTO-only suffixes from promoted global functions")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master f7757129e3dea336c407551c98f50057c22bb266]
[test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308232200.1c932a90-oliver.sang@intel.com



[   28.923687][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[   28.926842][    T1] systemd[1]: Failed to find module 'autofs4'

Welcome to Debian GNU/Linux 11 (bullseye)!

[   30.135342][  T115] kallsyms_selftest: Test for 1153th symbol failed: (show_trace_log_lvl) addr=c1033b00
[   30.135366][  T115] kallsyms_selftest: abort
[   30.137440][  T115] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: test_entry+0x1419/0x1430
[   30.138878][  T115] CPU: 0 PID: 115 Comm: kallsyms_test Tainted: G                T  6.5.0-rc1-00002-g8cc32a9bbf29 #1
[   30.140321][  T115] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   30.141688][  T115] Call Trace:
[   30.142207][  T115]  panic+0xf4/0x31c
[   30.142789][  T115]  __stack_chk_fail+0x10/0x10
[   30.143470][  T115]  ? test_entry+0x1419/0x1430
[   30.144141][  T115]  test_entry+0x1419/0x1430
[   30.144802][  T115]  ? __die_body+0xb0/0xb0
[   30.145432][  T115]  ? 0xc1000000
[   30.145962][  T115]  ? __die_body+0xb0/0xb0
[   30.146642][  T115]  kthread+0x203/0x220
[   30.147262][  T115]  ? sprint_backtrace_build_id+0x20/0x20
[   30.148032][  T115]  ? kthreadd+0x2f0/0x2f0
[   30.148656][  T115]  ret_from_fork+0x19/0x24
[   30.149412][  T115] Kernel Offset: disabled



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230823/202308232200.1c932a90-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

