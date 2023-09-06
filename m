Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6B793532
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjIFGU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIFGU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:20:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D0127
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693981219; x=1725517219;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=fQb3+Z3/hQ4tPx/qHKupHi/J6EeLIGEofEmwzRbiKag=;
  b=J4azMFiqdxSDulmfbG1RKQggFRxSRIW1m0pp2WFi96leacmLnEJIxwjS
   8LZndlVDX6NS0QNaR39MP6iWZ7X8X8jdMjO3KbmGw/Q0AXPJFLmp2Xvr0
   WoMHu/E6DL1kkyewIGaA+MR6rfJRwWMKPFEYfvO4OOzlDkmeutw0F13N1
   P4eg3Utri6ha2VpNhjVE0zKN/Ug/KTTk9sKKJRoQ18N0WUHh9u9PqTKgr
   irOCnLBppwz/ydk/tGP8Q9kVoZxzr/oaM5zAKGD3H6iirOyx41ubwdwhG
   wtiJM5AHfJEUHfosSRGRnmDbK9OtMM8t13ybBtJ+7aHsX4sHc4ACA+0sE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="362010005"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="362010005"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 23:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884565625"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="884565625"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 23:20:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 23:20:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 23:20:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 23:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ3wlC2mpZzUwMpEhKLEYUwLYhHhWtLiFf+cOvV7LakwhFeWpmK1ngzweyKNzJcKjuEet4AktlhSl44dZBmxbSBKe/8/Kp2FIecDkpctllwGGCn3tyabeNHra6dGTHUygVGYJ30OaSCuv2OOFElHnkc5QyIzJ4tG3+7/Ccy85BWDZz4vdWIS/5r/I+A4s+YEw0rXJj7eq14zD1MpWyaoK5N4VlgYceAmI0ddfLrC6Gc7emK4NUkiB9zUA3VZMwRxpFkpbZ5ybRWW5847uiNxZTS0B7Bqpjb31CbMhn64DjpH8r4pFeG4WuzDHF0Y8Foew8CkSeCCs/bWFwewJ2JW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1HchvY1BV2YR1HkC/QFgDD5pmUzwovG9dkA0rT+reg=;
 b=E3u0MKuxsZaNiPVbhZ4JmP4vk9lF/9zAMxulbF2oGkmVzSMNgm5RItWTbNzSFI4/iom1TLr/yWzHPLO1qstFG+8z5PKYqRIq5CkEN/HTBG9EzJfAf8EQNoHJsonZPW+RlK/0kTkhtmMbLASCpec2KbWyphcxUS7p9KAlFzujt1f5UENRBA4SRmj5DX1pxYo3h5gBeGvEC/fDJS4pw/W8Fl2M7bRGffrf9JaF84zo/tHzoYapD5gdIda1DS9U3lTBTDc7GrXl/LShKQ480ntNzaOQQzHooTuKM9oCxLTAt+8UwXaSGt6tFjCWPna/CmGVI32Vj+wZ+7LJZx3ITvKpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by DM4PR11MB5565.namprd11.prod.outlook.com (2603:10b6:5:39e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 06:20:16 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::ad05:7752:a9bd:2eb9]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::ad05:7752:a9bd:2eb9%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 06:20:16 +0000
Date:   Wed, 6 Sep 2023 14:20:06 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [ardb:x86-efi-peheader-cleanup-v2] [x86/boot] 9958e6cacd:
 BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code
Message-ID: <202309061355.4b4a5b6e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|DM4PR11MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: 16331d50-36f7-42cb-7a95-08dbaea155c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSW7tl1EG5vD7mAGtBxq/WPfXo8IB/2HR2B7LNsmkZo9dxw1oKWaTQvlgFTkRfo2gQQOfcHmWC8iL3bwpnmI6PfSf8D4QxdC1df+MbPhainQoCP/rrdzAfgBHV1MBfQN7CvMF/6YtSLhfRmLJSneVNcr5q4mfNsEBMvFbCKwzK6J9jWJhbmWdw9RUn67VCtIwFmcmbEeXdrHguGx7yuAdMSLhNOtKZ68O56+apkiB7HvtGI6f+1AFLR7vePHsF/Pd69YFGzp6a8bAcOPMwR/MKof9++4HEL4J8UkUcs1JH4HYUcISU6T73rQmxj9AlrTr5RE9FL1G0WMkMI4qNviFKAs4ZwFmgMnknKKndBVyPsxR8dsveme4oPjIodpm3Ww72lGp9yMAsWuxn6hCc+BHgg1EM0z7ESVyhm3unUW6oSYQxZ82YbDZTaZ2lit/2t8zM32NpwWQO9zY2i9eyoHMdSUOL91Rd9vuSOR3Z2RU5o0/Rfd6qbC26YSEAWcldZrPbSmtGwEchejIh398QAKa4k4ZJ2Z0YDlLcMzxAnsuN4bg0W652T/+8owisVYk6f0QafqUKTxqjcx/lcjXZnQsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(1800799009)(451199024)(186009)(36756003)(478600001)(26005)(6666004)(6486002)(316002)(6506007)(107886003)(1076003)(2616005)(6512007)(966005)(41300700001)(66946007)(6916009)(66556008)(66476007)(38100700002)(82960400001)(83380400001)(2906002)(86362001)(8936002)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0hrh77/u805lUcnZPZMY/Wa/mr/JAPDRnIq/7f162xjmLOcI65VPmVvk5cYe?=
 =?us-ascii?Q?1bwYfxdLYtAxdz9gJVtVbrKNRuWL6cGsRvxMhavAHVNX3eoiZFhOfVvn4LeT?=
 =?us-ascii?Q?bTZ+4Ti5f7hsa5v4ugs7OgFS9d7nqaM4p+SQ92AXi1oJ9jhaPYlSDECgLA+Z?=
 =?us-ascii?Q?TGSJQB5tosiYuEklhU/3/IFaCvZJ9pGN3cgQo+N9AelgLucnpQ2f63NuwO3w?=
 =?us-ascii?Q?Agoeljf70qlX3ZFaSEcSUld6Bg/l6wBm1yhewuaMDSWF0+d6twAIzM8tAaf6?=
 =?us-ascii?Q?C2FmV9UqdXtvm9NKS3CQ0vyBL+eSgtVy5if+KddC6Fkb+CbM1saXIOIj8ykg?=
 =?us-ascii?Q?CrzzWfHUtbrG1tsO8WNP3ngKklM/E1+Lr8ts5Gj4eLdIrUiUIa8e/aTfAPWO?=
 =?us-ascii?Q?YTxfXX4KIF8RtyL3dR53sa8erWuMUfjvZhVGvXFdr6ACFGBQtSmO4hC+NoP1?=
 =?us-ascii?Q?1/fj9u2TEUwzd75QTtHVz75wi/xnrHU4K3CGUBeiZpC9f4GwVvkc0N5IQ6jJ?=
 =?us-ascii?Q?PgEFWBer+iZjj3y/4Wzhdv/y+0l3d9st8fRlhZD1FmWoqSbqNhQRlJly+cfT?=
 =?us-ascii?Q?t22zWi3JIko6Cjc+Xaq46SRG2PZy3CVpoT7xtslat2pyrnE4bM8gqMbLUACO?=
 =?us-ascii?Q?1ZGKyNfLctAnPKsUWV68Ron8eeMqTAjsN3EoIv8oI8nbd9GJCw9ywV8lME0g?=
 =?us-ascii?Q?otFPXR7Woru9IpnrLAUtzLoprSrStevItBFbLDhJ5v2HbHh8osuRKMIPLX7H?=
 =?us-ascii?Q?LlH1hMOJlQ8c9fKjcsBPSl+oPQ2qgN5Yg7TTVS2fG75YsvHy67RQ+9N7O1Js?=
 =?us-ascii?Q?PuWcMJ8rLPuVwvCFJehqx6JUW6AmnoDQ8P3BjGQ5+lZZ3gHPMZmX/p5VtA64?=
 =?us-ascii?Q?5b8e2IZHmAqlv3vLKfCXl++vJEJT/v9OrTOXrWPYJhEY90dmdtbAb/hvOL5P?=
 =?us-ascii?Q?v5ZydZV+LgZOGFaDEYBzqpc4ASBTPYzteWlMBowG5szwJM9+U3swc2OaBdvZ?=
 =?us-ascii?Q?Ij4uQO4fuL7IdKvYz0oF6SyfrUQJed7rlMVlgX2gRzI1YMr7PB0KPPbnuo84?=
 =?us-ascii?Q?58aQcTwjUvdK4LnV2WkVvZW75HSgSUrgbBbwsamEY/oYVqgxazgdV9q7se94?=
 =?us-ascii?Q?Vr0LV8riDFXbBwBXnVeBf0vKF/+QfONXShWoxCp6Xh09RS5yj8KjtHqfuySu?=
 =?us-ascii?Q?rACcT895nbfGdTZjbKj0trD+0TsDLHHmWjwomuCWVfky4/dA2GWy+KJ9LviI?=
 =?us-ascii?Q?iG560nd7yDuNxt5QfikjJoc2qmXbCGxOes43CgfqP8lWRYnGOYhv+Q+Sz0ix?=
 =?us-ascii?Q?Bl6Dln9HZQxmYqFvBpFTZlTFM0QM/ZPWz5lTMc31yyHOEWa6vfLbwzN9duCU?=
 =?us-ascii?Q?TGzobFZfb8UhRVgVES5NNGrYHl9oB5lZ+ZE46f4kHX7c6Y8jjxDPwViSLZj+?=
 =?us-ascii?Q?lFqmHYY4a8hctMIl3mqK2uO2NndmzNMV6rUyvo0TAbwNjqjx4W9XNgDQIg1j?=
 =?us-ascii?Q?nmCFfQ/vwdqrsxZj18eiZsBdOJsHsAUxurxPH5TrVAv3XhQCRCYFpgKtNyIJ?=
 =?us-ascii?Q?DEG0u3R6pgNtZedwoVc4l4AMmYC0wbA6N9rRzvNZJwstLBSpjwelpIdRCrhr?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16331d50-36f7-42cb-7a95-08dbaea155c0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 06:20:16.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+BO1yzZFgZbFwCb0gMZSXaxKAJsa9Z8AQufma5IgDUjKfKrYVdW3t7t4h0cicEDLbOM4Xg6HbEc49HswRg6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_print=
k:early_console_in_setup_code" on:

commit: 9958e6cacdfbfbb6636b0826c546a1d48590fd9b ("x86/boot: Use fixed size=
 of 20k for setup block")
git://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git x86-efi-peheader-=
cleanup-v2

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------=
--------+------------+------------+
|                                                                          =
        | dc2ef6efb8 | 9958e6cacd |
+--------------------------------------------------------------------------=
--------+------------+------------+
| BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_=
code    | 0          | 15         |
+--------------------------------------------------------------------------=
--------+------------+------------+

besides on vm, this commit also caused boot failure on our bare metal machi=
nes.


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309061355.4b4a5b6e-oliver.sang@=
intel.com


early console in setup code
convert early boot stage from reboot-without-warning to failed
BUG: kernel failed in early-boot stage, last printk: early console in setup=
 code
Linux version 6.5.0-rc5-00035-g9958e6cacdfb #1
Command line: ip=3D::::vm-meta-320::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/re=
sult/boot/1/vm-snb/openwrt-i386-generic-20190428.cgz/i386-randconfig-003-20=
230902/gcc-12/9958e6cacdfbfbb6636b0826c546a1d48590fd9b/8 BOOT_IMAGE=3D/pkg/=
linux/i386-randconfig-003-20230902/gcc-12/9958e6cacdfbfbb6636b0826c546a1d48=
590fd9b/vmlinuz-6.5.0-rc5-00035-g9958e6cacdfb branch=3Dardb/x86-efi-peheade=
r-cleanup-v2 job=3D/lkp/jobs/scheduled/vm-meta-320/boot-1-openwrt-i386-gene=
ric-20190428.cgz-i386-randconfig-003-20230902-9958e6cacdfb-20230905-81243-1=
0dllv6-3.yaml user=3Dlkp ARCH=3Di386 kconfig=3Di386-randconfig-003-20230902=
 commit=3D9958e6cacdfbfbb6636b0826c546a1d48590fd9b mem=3D4G nmi_watchdog=3D=
0 vmalloc=3D256M initramfs_async=3D0 page_owner=3Don max_uptime=3D600 LKP_S=
ERVER=3Dinternal-lkp-server selinux=3D0 debug apic=3Ddebug sysrq_always_ena=
bled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3D=
on panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_r=
amdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr =
ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,1=
15200 vga=3Dnormal rw mem=3D4G rcuperf.shutdown=3D0 watchdog_thresh=3D240

Kboot worker: lkp-worker76
Elapsed time: 60


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230906/202309061355.4b4a5b6e-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

