Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7914680EE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376571AbjLLOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376564AbjLLOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:19:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ACB8F;
        Tue, 12 Dec 2023 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702390799; x=1733926799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N/ZmDhtAf2VmIJb1u31EnYcx/r7Z91EOaZrKuUrdlO8=;
  b=lOshBoef39kmq8OsiX9WlCZOfuBEOg/9msmHCPJIJqHMD7EGxI8R3H2F
   Odya6dghPyTmg4TEdVOqL9henh82+P6dZbr9B5CrZZStb8INBuUMoBt1x
   PN7Bu0CpFvaSQO9nw0gpW1VmlultWKd7XugDiSjohHnHZu506YB5Jx6CG
   OMZSMmW5jR4x9BSj635Oc+J3JMUGBeGgi17yzkIk2Lpb7Ttm/MSEJQ/g3
   nl5O1ZRsPbjpg7+RuvGvVyw3JM5QJSWfHOpUfkWF/GQkV1EhpwELG68T3
   TT6b8CQXPf4B0mtDMSqxwvSS8ATTKHWQsQHcQQVyYvNb/YgP/u6xzLaj9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1967072"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1967072"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864222767"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="864222767"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 06:19:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 06:19:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 06:19:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 06:19:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 06:19:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+ALiPsMr/zbItXlYO3smWVEAPnN4H5voAMe42SQQ+/oRATk4RLNFEYFa3Adysvvz63fmUULUyNRKTQx9vX1eBv127jX9DF+g0AVk8y2H935q+QXqXRzQ3qasLkgaUmn3GqSdVFlWgkQgghhA7e0DJH1R7v44zPo1+wNGx1pJsNz8hJWqP9z6iffa7id8nzRymJXAXix6dNiwj4Txjb+xBAxbYO0FlKwaPhgFzk3SZlAm8mKc4+F6RtuoF5N6P3N7HFKXPGXtr5Pz39DxHZ6Eu8RXVc6STBa8F4CWi1ZeRWS0gyvr+/K5Qclbm+Zze42q7ZT+Zi7gUZ97FxD//lMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w09lW5qOdKUcfm5+20Yn/ZTfkwewNfE3ioIhTrBLO1g=;
 b=Z7uax62Xr9hsnNlZYceIo6kTx5ymIlv3NFvwJvMwQvHtJsxrFf6IUR4glnaWV6CCIgq0XMBKnnvaYrOCwLRRVGjk9+wYc4fyMsIQK/ycJ5ZxgvBaSJ2BeWmpdzF5qKySHWiidtLG/rjwsKHFPIwNfAPLrbAXqQI6TdMNiWTrQNAol6BBTHQHoVE/T2cJbOaqwSl1jSd+eTSVoREoOU11v6LVf6p6XJFNVuTimG14O33QsXxNoOQltL+kCHwwsOQUVRszVwN65zoQD7EDf3HL6bvSwe8L9gToOgBH88AsiktDPK7nKsFYijJzgeUJr5/EMhLhguY9ge2bagBGxA2SKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:19:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 14:19:53 +0000
Date:   Tue, 12 Dec 2023 22:19:45 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Budimir Markovic <markovicbudimir@gmail.com>,
        <linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [perf]  382c27f4ed:
 WARNING:at_kernel/events/core.c:#perf_event_validate_size
Message-ID: <202312122135.dcf51112-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca1da07-f985-4514-2139-08dbfb1d6868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfeVUvYZ0NweEwy2VhFiEAUwT7N07axQaswSjPg+3nyyMbVcK+M0wA1Eicl4rQUp+/PTodG1kS/gov+qUWrGXUY0YdeBXdNMVyUZa0fBQ+iONl1U+m/r4s3BDbyfycy7i8N8aABZ4ZciAKTN5MsA1cRHIg5J0cc1LEW5rLyP8borOkIdFCg9yJ4obud06tafCgfgYEpTVPzOWhj+WbyD3ee6OKpoPofMspeY2+Zld/Wt+F3uR629SEmVmkY+2wFqMMhrsXeaMo3Xe54LvSQTJYKteheyBl+C4H3pq0pExArXfgAUJeszOxBkw+e+9Fv4hLCeZKGnVkbrYFu18FG8XDuCbYebCR8YlVKB+/9e4XA7nDBsrYbM1Mxikd6Nn7yyFT/TUBrllWi0/Di/U2z1qlvNY278UVyS38PF76v10GKZ3x2KfgGzARKSN+us3IaXLQ64BPp2z8oI5SEToISN0HOdD/EpLpr2astCX6ugj6wO1ZMUx6uH0NBnOOnCCUFduWeSTCfYfUU+fogVk//ZtwXk7v6bfZ81S7WAwl46NPtoLzMqldtGdKQKhT4yGVbNTXuHM5AbjKVaX1e5uAUnGSi8vFQvE4kTkTrzbod8iEiq3TwVZ/Jr5wBZMCQHDq1TsZWuZg0ffhVNCi4NZz2n6s6juRsWV5FNxvLhXyycLG3XjgadZC1aJtzTcsoYDf4j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(8676002)(41300700001)(2906002)(4326008)(5660300002)(478600001)(6486002)(966005)(45080400002)(107886003)(1076003)(83380400001)(26005)(2616005)(6512007)(6506007)(6666004)(82960400001)(6916009)(316002)(86362001)(66476007)(66946007)(66556008)(36756003)(38100700002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ELZNB/P7dyehF6Vf99Lxgnj0VDuVMKapvCEK0BF60gE+W9ID3nP7NG/ohai?=
 =?us-ascii?Q?8jIlpQpOpIJVpyyd3kOBRzsIGlwYcXF3GvKvBkx+LEH1aitZSJsUzk5QqRNq?=
 =?us-ascii?Q?XlxErw4M+V5NQx+lfqHBGREnpOu6zyyI1rHKv49e1yfm+KWiVe9V2hyMkPnQ?=
 =?us-ascii?Q?zAfaXjYwbEZYHnCse6X2ETXKku2YypuEgWkCFSALq6u0WOzVL0dEGC3yLOMe?=
 =?us-ascii?Q?J7zE0s29yypLy1I0gQeCeND11AVU+jDkbLu8dSO4oyOPFKtN0XqZwHMomSmo?=
 =?us-ascii?Q?deJ6C3Hha1wEO6LPKzsru7Wo+nYKHyAdyWnkKTuY9lhNkWva754/VfYHfuFY?=
 =?us-ascii?Q?dZzJLuu2b+FK7YHEi7TcptZJZmpULsX9qWX14eoShQkevhoRPSGP9nVyFn4h?=
 =?us-ascii?Q?D4BZTL9xUChJE0Wx31iAy0R2eDORVKI8w60SqBslg/cSTWb4lkf4KtCnWL69?=
 =?us-ascii?Q?/GCFNQmk6C6B4CqQmpmndK8ZYY8UwxmnxH783sS9KmCo6JM8FLSBKg/Ityl9?=
 =?us-ascii?Q?dwwMjI2Uw6vYffPfW+FfTd/bzX7NbER7im5AuG37m3fccDZjENZ4XENGNG7C?=
 =?us-ascii?Q?MCfpOf2iTXwkOjFNlOR15+DBQq5U+qKmUAXIHrPUdL44Dh6oBh/5an6Zi1dJ?=
 =?us-ascii?Q?Dp26fw8Q+miigk0yPjQrqi1CG0KmK8xjjfch0qutBkYZvt3SgdpF8MHx4Oz9?=
 =?us-ascii?Q?KBZYH+3tNBAS7pu3CTVDi7bofY+zLXDkg7CqIlgIu9TDYHhC0Bxm4KYmrs+A?=
 =?us-ascii?Q?KLSsbpK6dh2flIvNYk/tqy0j2AwnqSPWycMhfKgZJIyDr3ee103R20yIOFLY?=
 =?us-ascii?Q?AZer+Oacv4Osri+wAt3hhmn8imN0+gGo7FFpNlDr99oLGYgd3fjdNs/9b0U6?=
 =?us-ascii?Q?oOuyya9UmUmgjr8X9rXT5gwcZikSN+g3pA9VCvi1DS59sBW20i5QGzFoQCLu?=
 =?us-ascii?Q?/+iN/GGi3luOhUvwaeUB+Mx7caPMkopu9COU6U2yj9n+ZSAfML5baipb9ua1?=
 =?us-ascii?Q?tjBjJMXcakR1bHuCLE9ckNEODcyWYlV6Yo8Y7S4Hyck9/ZwccJCMg/60oMqk?=
 =?us-ascii?Q?QUA0YGhHQmdo/wVvMm1NepjZ2qh4CBPdsa+VD2VPAV9xyo2LUzLYZ7kwEIEg?=
 =?us-ascii?Q?DmFAg1lXiuG17voIuQphRAJQJe4DAM83Y7eEnVYQO+fkwd/5zjmj4YoKC80F?=
 =?us-ascii?Q?f+wGaR+C7Wig3DHWqLnm3rTK/kN9kmoFA+2Ib04fryHGsRIOvZlQzuf5aID3?=
 =?us-ascii?Q?py8E4lpfQJqoQ1FMusy439CglvKJ+sEySHrI53vSgQx5Ozgjq+Os7XkTkmiS?=
 =?us-ascii?Q?CUE+cOOOBz2gAwIuMI34/VWR6GLTEFMpS3/utPJlnFyjtrMqLzatzmqpfqk1?=
 =?us-ascii?Q?XRX/Y7kqYWqIhVK+WkLg29EpwQpGFT/ML0pmmPHzaDFS9l4byOwimFdSZW/o?=
 =?us-ascii?Q?jbisrF0wh8olF0Zfnfv8FhariQh3R1XhTQKuT54Zy/EjGcQ3daBH5as28bhJ?=
 =?us-ascii?Q?M9dSvLixu5foNghSm1dCJncq2UxW4p5xuSTxhbK9Y3rgkOcGtEQnfPrsFYo7?=
 =?us-ascii?Q?VqRZiQDM8dcWXU46V4LsWhwhoyQQxTH70OV5mVOVwi6KQQH1oXdPNmBJhXh4?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca1da07-f985-4514-2139-08dbfb1d6868
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:19:52.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb66wgwMoLuFszI13/4GY+9cF6+o2PamGMm4JwDkMe4LIqLi/V4PxRczVbPjMa542v/HKqkFsS7Dp/aPD2H/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

we reported
"[tip:perf/urgent] [perf]  382c27f4ed: WARNING:at_kernel/events/core.c:#__do_sys_perf_event_open"
in
https://lore.kernel.org/all/202312052248.1270bdba-oliver.sang@intel.com/
when this commit is
commit: 382c27f4ed28f803b1f1473ac2d8db0afc795a1b ("perf: Fix perf_event_validate_size()")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/urgent

now we noticed it is merged into mainline, and observed below issue FYI.



kernel test robot noticed "WARNING:at_kernel/events/core.c:#perf_event_validate_size" on:

commit: 382c27f4ed28f803b1f1473ac2d8db0afc795a1b ("perf: Fix perf_event_validate_size()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 26aff849438cebcd05f1a647390c4aa700d5c0f1]
[test failed on linux-next/master abb240f7a2bd14567ab53e602db562bb683391e6]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------+----------+------------+
|                                                           | v6.7-rc3 | 382c27f4ed |
+-----------------------------------------------------------+----------+------------+
| WARNING:at_kernel/events/core.c:#perf_event_validate_size | 0        | 12         |
| RIP:perf_event_validate_size                              | 0        | 12         |
+-----------------------------------------------------------+----------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312122135.dcf51112-oliver.sang@intel.com


[  180.010094][ T3401] ------------[ cut here ]------------
[ 180.010717][ T3401] WARNING: CPU: 0 PID: 3401 at kernel/events/core.c:1950 perf_event_validate_size (kernel/events/core.c:1950 (discriminator 31)) 
[  180.011699][ T3401] Modules linked in: floppy evbug qemu_fw_cfg fuse
[  180.012385][ T3401] CPU: 0 PID: 3401 Comm: trinity-main Not tainted 6.7.0-rc3-00001-g382c27f4ed28 #1 934d94ae775b173a8bcc12c6e74f54b31bec9e32
[  180.013690][ T3401] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 180.014751][ T3401] RIP: 0010:perf_event_validate_size (kernel/events/core.c:1950 (discriminator 31)) 
[ 180.015371][ T3401] Code: e8 1a cd 73 02 31 f6 48 c7 c7 50 ac 16 86 83 f8 01 89 c3 40 0f 95 c6 31 c9 31 d2 e8 bf e8 f6 ff 83 fb 01 0f 84 83 fe ff ff 90 <0f> 0b 90 be 01 00 00 00 e9 77 fe ff ff 4c 89 f7 e8 60 b2 1d 00 e9
All code
========
   0:	e8 1a cd 73 02       	call   0x273cd1f
   5:	31 f6                	xor    %esi,%esi
   7:	48 c7 c7 50 ac 16 86 	mov    $0xffffffff8616ac50,%rdi
   e:	83 f8 01             	cmp    $0x1,%eax
  11:	89 c3                	mov    %eax,%ebx
  13:	40 0f 95 c6          	setne  %sil
  17:	31 c9                	xor    %ecx,%ecx
  19:	31 d2                	xor    %edx,%edx
  1b:	e8 bf e8 f6 ff       	call   0xfffffffffff6e8df
  20:	83 fb 01             	cmp    $0x1,%ebx
  23:	0f 84 83 fe ff ff    	je     0xfffffffffffffeac
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	be 01 00 00 00       	mov    $0x1,%esi
  32:	e9 77 fe ff ff       	jmp    0xfffffffffffffeae
  37:	4c 89 f7             	mov    %r14,%rdi
  3a:	e8 60 b2 1d 00       	call   0x1db29f
  3f:	e9                   	.byte 0xe9

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	be 01 00 00 00       	mov    $0x1,%esi
   8:	e9 77 fe ff ff       	jmp    0xfffffffffffffe84
   d:	4c 89 f7             	mov    %r14,%rdi
  10:	e8 60 b2 1d 00       	call   0x1db275
  15:	e9                   	.byte 0xe9
[  180.017292][ T3401] RSP: 0018:ffffc90002abfd10 EFLAGS: 00010297
[  180.017871][ T3401] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  180.018648][ T3401] RDX: 1ffffffff0c2d58e RSI: 0000000000000001 RDI: ffffffff8616ac70
[  180.019419][ T3401] RBP: ffffc90002abfd30 R08: 0000000000000001 R09: fffffbfff0dffeff
[  180.020209][ T3401] R10: ffffffff86fff7ff R11: ffff8881563f88e2 R12: ffff888157f3b040
[  180.020959][ T3401] R13: 0000000000000001 R14: ffff888157f3b0c0 R15: fffffffffffffff9
[  180.021788][ T3401] FS:  0000000000000000(0000) GS:ffffffff852df000(0063) knlGS:00000000f7edb280
[  180.022713][ T3401] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  180.023413][ T3401] CR2: 0000000057cff06c CR3: 000000015654e000 CR4: 00000000000406f0
[  180.024212][ T3401] Call Trace:
[  180.024558][ T3401]  <TASK>
[ 180.024869][ T3401] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 180.025372][ T3401] ? __warn (kernel/panic.c:677) 
[ 180.025795][ T3401] ? perf_event_validate_size (kernel/events/core.c:1950 (discriminator 31)) 
[ 180.026407][ T3401] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 180.026866][ T3401] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 180.027322][ T3401] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 180.027797][ T3401] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 180.028342][ T3401] ? perf_event_validate_size (kernel/events/core.c:1950 (discriminator 31)) 
[ 180.028931][ T3401] __do_sys_perf_event_open (kernel/events/core.c:12655) 
[ 180.029576][ T3401] ? __pfx___do_sys_perf_event_open (kernel/events/core.c:12391) 
[ 180.030215][ T3401] ? __lock_release+0x10a/0x580 
[ 180.030741][ T3401] ? __ct_user_exit (kernel/context_tracking.c:623) 
[ 180.031295][ T3401] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4567) 
[ 180.031960][ T3401] ? syscall_enter_from_user_mode_prepare (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 kernel/entry/common.c:122) 
[ 180.032669][ T3401] __ia32_sys_perf_event_open (kernel/events/core.c:12388) 
[ 180.033281][ T3401] __do_fast_syscall_32 (arch/x86/entry/common.c:164 arch/x86/entry/common.c:230) 
[ 180.033807][ T3401] do_fast_syscall_32 (arch/x86/entry/common.c:255) 
[ 180.034360][ T3401] do_SYSENTER_32 (arch/x86/entry/common.c:294) 
[ 180.034816][ T3401] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[  180.035486][ T3401] RIP: 0023:0xf7ee0589
[ 180.035922][ T3401] Code: 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:*	00 51 52             	add    %dl,0x52(%rcx)		<-- trapping instruction
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231212/202312122135.dcf51112-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

