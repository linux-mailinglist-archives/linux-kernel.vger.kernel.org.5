Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E647EDC25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbjKPHoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344845AbjKPHnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:43:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56DD199;
        Wed, 15 Nov 2023 23:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700120632; x=1731656632;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=AABKaGa2PB1tGrGHtG417Zb4cdFDsaHfRkAPCjTc1OE=;
  b=cIThplyxWDu0ZNHGyLEIxHcrOnT9mXjwJl0ZDEMbFajfFBj0PwxIYeCZ
   0Dms/vfYX2eMXCp9U8i52eeS4h7SZ3dJIp3dB6TEubUdTCC9T/udqDuYd
   zyjbMp7EWpKQFKD5kF1ziFkZhU7TxqOb+zDM0MKDxR851YUAvDB6xIyq/
   MNY3YYa19l9DKEWyKBiggHaZa4VSMgT8BcSu4PvfWLL9SEflSBuZNiDZ4
   Ftc1/zliW51N/mI04pKnr5U/IhBcFwAgT6MzWoYEBKMqzKV3vMKAOq6Kl
   tdeJ5kWipsn/Ptppeg5VYp6XVvdp0fH9Jzprv4uzFCi+bfulGZqwMM40A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394952741"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="394952741"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741680940"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="741680940"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 23:43:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:43:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:43:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 23:43:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 23:43:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY+3pTfTU0cj1TgdTbmP7Is20BeAbjNK+apC35i+FCMCb95GV0m/wkHViQM2S7G386YT9Xd1wSCEzRZJbV/kYYP0rSid1fhj7PTgS+Jz74agsgFuBIYYRRP+l7yprESlPOjLJ2KnNeLCbYXIjS90SHycfjiueEguBqmXxIauIxZnesmNux7DBkEmiUn9zeosbVZjZmtHQsr5S+gfpASiPRCs0K+pl6GcDvih+hA/RTBzqsqKqbzFib/lzhTnmquldj2t8dyUnx7W8yyn4aUuWCFwT0LtX5LfuI1YX8WSQUrDzvW4XxmhUT5InXCjgdOmQorwd0TzlaP0B01jQ26a5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmGIfeZpelFDOxCCgSayfNUWRTWod7nQRX2XcrB/lSI=;
 b=aRkIximc7ta9KB//IhR7aF0CUL5XppXZnY6gGD7fKKx6vDnQjashs/TQOuaqhp47qz9q/+H3Z1akDhgGssqKktk+ZqY81uV1d0FYk9uFlAngXJ0fq2RLdS+CdoyNpkVlsbIQuE4AH/eH0YI7vMYW0ZKQoEEm6iWjfvs/3EogWACdpcI7GFHDih3Xh8fM/mk+CydYlqxpTzBi7Go0OCLkLbfq/GdJKW5eqljELjHK9Elpz0tMVw+R4ovCqOhL0hIBPEp7vStoeFoxdQ9DPZ7jAVDqHmyCC/H4g/iRoPfPAJQIl9cqVENU8WZ69IQp+G1L++peGx0vwisXYWENwiSqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB6548.namprd11.prod.outlook.com (2603:10b6:510:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Thu, 16 Nov
 2023 07:43:46 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 07:43:46 +0000
Date:   Thu, 16 Nov 2023 15:43:38 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [rt-devel:linux-6.6.y-rt] [printk]  78f4b59c6f:
 BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code
Message-ID: <202311161555.3ee16fc9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 58aeb0cb-e218-4f51-bd26-08dbe677c3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvjt312moHVCU5TT1hTth4jJv+eHw7+liKcFi6tNnAd24cbTatwYLDMZ+8zmEVSHk6HReRZBHjmC02I4U7xwzlfiRhS9V+yW8pPYVgfqOdI6uQ28mFHxsYHEuwDRvVAMQcigz2Kh1Dzlzkv4on13Y2Tng5Q7Zq35MwxTZonPUNdXTZLHzPayTjP/TVGtUxuP+PS5bbDNoztEjOgLzBGmkV5SnV08Y6b27UcY6gWqFhQqf2E8O9i3cuwPNjo2eXUkQqq4kDO+zSPBTTG9vbpSGtNE0mxXudJuoq92dpMRLxCZA6NshGp57BObWIuqqF7ziDhQE/ka44xQByE+pkVFOuR4upbz8mE8xCB+bqYjjeQ2+DqYCljBtikOn5OzUMMY2HQzusj6Hg1qXo4lgOoyCXCguqaPNC5OC4QIWEKXele+JOZmf8tiu6PMyRuj7X/PiFrMRaojACliMsFepBCftulvHy4+nlZE6xA6Wf/P8qc0+Q4iuktS8Fl3HMQI+1pGqh2Z2pUXB+QCJrQZJUkM2uMA+hMyWSNQSzr+XCnQbiwbPJAsEfMqAyJaTiQXBRcLk+7XbaOZjleQ+ouyod+ZMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(107886003)(86362001)(2906002)(2616005)(5660300002)(41300700001)(1076003)(36756003)(8676002)(4326008)(66556008)(6916009)(966005)(26005)(83380400001)(8936002)(6506007)(316002)(6512007)(82960400001)(478600001)(6666004)(66476007)(38100700002)(6486002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJualD41ItxYZP0222xDwuYZSyRjLAB/Gs7cNySzHjhu6ke3p4zm+AqW/F8Q?=
 =?us-ascii?Q?nxfOKstTp5ohbzsPRDRqCNvGZiDL//4iKr0BVXUyxZjYhVAcyntV3XjsiDin?=
 =?us-ascii?Q?er9LMyu+cfWhF5w0TnKXF58obo10DXJSMPJ4WN3+p//bbl88049uPWWI7kL5?=
 =?us-ascii?Q?SOuanG7Q6PWsXH+tBVg6N+yTq3l8HkQNKDfgHC7vde/cKxb/n+aJtYXhyiKu?=
 =?us-ascii?Q?lHGbt9FqCPu/XoIREbSdRmM10e/tJARjxBnpXlHTbs827v3w8XRff7kvgrLy?=
 =?us-ascii?Q?dHr5J4xN7G5EX8oRMMKRepX+c+acTpjq6Gvof3amoUY0o0fVd57nOpHwFYNC?=
 =?us-ascii?Q?mGaPAKgO1BxQRsOgXVaclhNdl0i/uK1IsWj1Oroj0NXQ4M32JoJiGnSORrB3?=
 =?us-ascii?Q?K248pGeGuBZe0MCzOYFMbHi8kIM+7OWvz0sdDroNX3Jz3v61VzeqsHB55KL2?=
 =?us-ascii?Q?9wyEQmVR9Av7JAHxd66oqsKqkieqbLFbcdUNptPZTdFbgqCzPhlaVKdPz1W6?=
 =?us-ascii?Q?2Kr/ibyi9HSWgHTLpOofbuKumn+aK+/qcmFw6z6OHL8LC3KTYITZDDCJ3XfF?=
 =?us-ascii?Q?okyQYvrcI7gfiiMD4O6c/8Nmizoz2mklHSAeDjulW1pzst1JAadb7Qgd8S2A?=
 =?us-ascii?Q?y5b1AM6NQG666EUv1omHFm/AuSNBE3LjQ7sHscK1S3P/xWmtopbSRa86ZCx4?=
 =?us-ascii?Q?bxBRznpb8KJPxJFKXOD7iJNM6fVOVYd2xHMbvhL8KFmWix8vMbprZ7XEgjhU?=
 =?us-ascii?Q?366+6DJUdUmhsSJJWS4XonZVTbBJbEYeI7kgeg6MEq4iQnaacnc/tVwN0ZW7?=
 =?us-ascii?Q?SW4PPGnhacaGMbv9hKYU8HlOX2ncWDUUm0nykYwgnRFy28srX4oCgjcoWrf/?=
 =?us-ascii?Q?OgqaCSMB/uwjrXOaldjpR2goDGclmfq4vzi1XMqSPumhcPsgodMdg/yzRhz1?=
 =?us-ascii?Q?0dF9X+CMPPcCWjxvDwsgfuOM39jUOrmkjldgOWkp3n756icmIyVWu3q1zUgw?=
 =?us-ascii?Q?ji4dZ4MZeeLUr9pfb2CWKxdPdUf7t3OynnmpMdHd8j5MVOP5c0qXvYzXOk9l?=
 =?us-ascii?Q?P4saj0DKSJqyOV+8OXXzorAMh+1rZi08qcINTuKjBYvMSJ+w/Ay1HQpebCiV?=
 =?us-ascii?Q?O3TglvIYcx699Bwfw/aCyol9nwYBjtFzeKaBbnKlWf9aOMxj0X71MQLpOrHX?=
 =?us-ascii?Q?/jA9aHoiFHC8KfrW96oZ2ftSdmI5oSbZ9jCtl0rpq3XTlseHlJYhPdjV2CzZ?=
 =?us-ascii?Q?cySQhL6VRkTICPcTTJH8EWA4VnL1a6kSteBML/Wm4I+Uf8cCqSdYOZKaYB8A?=
 =?us-ascii?Q?5yDJ4qUeByxvm1Xs434TpnNCPkEP8LabfGf/DAg+PDroDl4yXsoQ7vgh0P19?=
 =?us-ascii?Q?X76K5iABJcFId3eksrDU0Y2P9vFB+ClbJvM1mcOKPFSmT6Q9F1/1KLRRwKKF?=
 =?us-ascii?Q?WC1CXwmo+2BsmQSo80OGIG65joXA91iO8gAD4547herkHWy9q62V4iQk/8y7?=
 =?us-ascii?Q?5xxT7Y+30tJwtjnaYBAaGDOVNveg7Q4EA8Sr40G32Ko2OSvkpOqn8K5IljlO?=
 =?us-ascii?Q?VWMe/OZsH2W3dPSSDnWFyFKfMH8E0wPpPf+pRYXmQASjetp0uNt/DmpJKIGh?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aeb0cb-e218-4f51-bd26-08dbe677c3b5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 07:43:46.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI3J5ozEGr4L5ife/3/XXbd6MyRjrK1OHBIeLOK1DHftTAasygEhNPQInbbeByePENI/gORAl1daCe7NT619LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_print=
k:early_console_in_setup_code" on:

commit: 78f4b59c6faa7afe24b973210151d4a82b5669eb ("printk: Update the print=
k series.")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-6.=
6.y-rt

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------=
--------+------------+------------+
|                                                                          =
        | 99199e32f0 | 78f4b59c6f |
+--------------------------------------------------------------------------=
--------+------------+------------+
| BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_=
code    | 0          | 23         |
+--------------------------------------------------------------------------=
--------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311161555.3ee16fc9-oliver.sang@=
intel.com


early console in setup code
convert early boot stage from hang to failed
BUG: kernel failed in early-boot stage, last printk: early console in setup=
 code
Linux version 6.6.0-rt12-00111-g78f4b59c6faa #1
Command line: ip=3D::::vm-meta-31::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/res=
ult/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-006-2023110=
9/gcc-12/78f4b59c6faa7afe24b973210151d4a82b5669eb/19 BOOT_IMAGE=3D/pkg/linu=
x/i386-randconfig-006-20231109/gcc-12/78f4b59c6faa7afe24b973210151d4a82b566=
9eb/vmlinuz-6.6.0-rt12-00111-g78f4b59c6faa branch=3Drt-devel/linux-6.6.y-rt=
 job=3D/lkp/jobs/scheduled/vm-meta-31/boot-1-debian-11.1-i386-20220923.cgz-=
i386-randconfig-006-20231109-78f4b59c6faa-20231113-60184-77bbov-19.yaml use=
r=3Dlkp ARCH=3Di386 kconfig=3Di386-randconfig-006-20231109 commit=3D78f4b59=
c6faa7afe24b973210151d4a82b5669eb mem=3D4G nmi_watchdog=3D0 vmalloc=3D256M =
initramfs_async=3D0 page_owner=3Don max_uptime=3D600 LKP_SERVER=3Dinternal-=
lkp-server selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu=
_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 sof=
tlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt=
_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel c=
onsole=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnorma=
l rw mem=3D4G rcuperf.shutdown=3D0 watchdog_thresh=3D240

Kboot worker: lkp-worker04
Elapsed time: 660


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231116/202311161555.3ee16fc9-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

