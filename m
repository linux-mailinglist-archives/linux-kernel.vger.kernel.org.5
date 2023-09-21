Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F57A9624
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjIUQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjIUQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:59:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9318E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695315410; x=1726851410;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=nbGqf1Eevq95c6gJz9lxCeV+qiBs9xuIIhoj7lurwrg=;
  b=Oysw02ljbogB+G9H/CAphmbZ98WJQdoTIkZexffByV02JjH+cL43/Mey
   oxAZr+Rc5OEHFHQUuDSZDsooajh2jdhaM3Z/fLtqjkD9GsAlONxR7uxfA
   97d8tE2TMk99igj7SwFLn0RupSPYUtUbm7Wlew33nqG0Nq6+mLvvOcsdX
   ghkRGspJMEBOxTJbfaYIYf2vCAH9odsB7H4nPUSs8OES/RSGvARJC6mQo
   EFxgK6YbrudkHMqglofy/PJSN1FIAg5fXzLyqmi4FhG5Fnu3rMQ7r7ArB
   nn2HeSCs5jbKDoWIyOR3vYmhzallaoWTPYFNqwInUYV8FnYjI4zBRuYBz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360770239"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="360770239"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="750386302"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="750386302"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 06:34:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 06:34:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 06:34:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 06:34:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+wncgk4uWtiOy0YTLYKtXkxWORcMhfRSV0lycQN06uXM81E2mVgQ6BxApMegTbDyFkh3632UMx06LeoutSs0zxuagVsLvaPXJKyBerh8RmJ4FrRlZuWKnfGuoyerjeubGzt0csbpluE2RJP/QEMrvy/hxuU4+2hy1YGOOJM08D1wSzwaRDOGldmPK+C9a21vgElKqEVzf8Gff65n/KvadR5lJO0sPoRbQzBoFxE+jZMLtjiNQxpbJSq3kL4mgNDSGL3FY0htRNy0IPEOOiEozI7CIDhV6AorLi2C3Z0FtzUHPE9C8bLWkY0tGUd8Ff4L8h41jtLtpqPKLTC2+cEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mezJ1dhCyCq2GweR60tnUfXiA3F3ORTx3k0aTu1sX4Q=;
 b=jIj7CszYRO3nLU4dCjXjhza5euLkXgVA+McgkHl2r0eocm1pVUa9ZPNlzB1SIXsNT38H41LWTQwVPSwHYHDz243WaprQ7zZ7QumlqbycCoBJEmRKyQEd494uksMvdRsI77AGc4o5wfnrXBknovMtztmZjFEwgwTI5y82v4M5B/VzVwL5cg70/F2eRsuomQz5RfUPYm4ayUQa4YbzkKGk3ofawWyp8DhGAIpIScgXLnQGcnvOBKqvM6snEHlQpXJdSEBsbS7wCb7QcITjvoqbDMD9B/SifrisYh8yPWOUMtlAFQxe08NWYZWw8Byg4MJ8YktfZVJRX1tL299fg5K8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 13:34:23 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 13:34:22 +0000
Date:   Thu, 21 Sep 2023 21:34:13 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
Message-ID: <202309211632.67e4c1e0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM6PR11MB4612:EE_
X-MS-Office365-Filtering-Correlation-Id: 98445d2c-85ed-4b8f-7c68-08dbbaa77747
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTG4Cl/lcGw6DnJtDln74YUDrHwU8uOYIawdhJcmVZAnQU2OOC4VT3H7Mo5rC9FOOqpfoM9cy5q90JC8ilWZwWM1PwYqqE2RvifCUxxjw7+vHE07ixJ1FEVm603gbibXQKMpr5/pdaGE5x5UdnKOiwk0kwqwbkOIl/bBAGeUBiRpwGKuQeV/MBHBGNfYWHig0KkKV+t6XbbI9xzfX+ERAzLVbWzL6HtajQTabPvTBv1KcvweBusJAm/0NP1v/VQDCpfKEA5zb2IeJATgk4m5Hy9AIDOeZL1Qp/+z/sYsbJiLl237ei2szqPG1OVjF4OBdswL7pT+cyt7P26KQy3DEjQjiUdSf2kIPtZ0Wo6jTBH1hoiowo0tLxL0dNJxYW3WV6pX1dYc9MQw+PGQZUki/L/UdyPSyr7COEgXPoPPbLK2RQX/0gL7OT1wl8LMioHCIYbQ47FLJKwU6/BEyd1uvJMUIqf5CxIdEYhT8IqyNgx8XSg23JpPxwHqBojht0OkITuC3APsIVMf/mtctU8gj+OI6s/XB+cu2SJYaxuH0n3owhN0b1PwoTml2tApHZlJjoPOAhTRR5QJnKshcySuRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199024)(186009)(1800799009)(66476007)(66556008)(66946007)(6916009)(54906003)(316002)(6506007)(6486002)(6666004)(6512007)(966005)(45080400002)(478600001)(5660300002)(82960400001)(2906002)(38100700002)(36756003)(86362001)(41300700001)(4326008)(8676002)(8936002)(83380400001)(1076003)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7/XNJtSoOUfWPBf/vdaSkozcehFvrYwuEGs7jVJlqMdMCdFNAbxAfmQZUHc?=
 =?us-ascii?Q?qzkvlunyY4GU2N7kdV7fJRIzc1g9q+UdqHolBJMbXgfrQ14AjdUkGabvLKTn?=
 =?us-ascii?Q?M2FGEr/Tc+Gaqk5Ry1SiNNUp8XijpsY7ve/G1PUGS79DagJG+8yDx6jWKrZ+?=
 =?us-ascii?Q?a+VdE7mRGRdQ1LJmoXPTbwUG7DuEUHbkQWvz4QXm7kBfu0MkCnQ4aFDmCy16?=
 =?us-ascii?Q?4XlcPo2SHM4FTktNjkkNdAjGKkR8H8wAgINEFF5WwF+eVtN3Ob04j/76UQ+u?=
 =?us-ascii?Q?MB1ZIvQmYWMYekni1hgY/G3So7JaimH2yyx764k+Yp70Eh0DQxc5xQM6Cn1j?=
 =?us-ascii?Q?asQUArD5iC1kfh0Y9mWNMsZUc2q/JWOieY5eASMOtqO5OEG3hlOAQJ5T3UtP?=
 =?us-ascii?Q?J3kPlBZFAtjbZdgy1CdRDP6Ddk7/9hVf5cv6B9LcPLePuoZBvzhyqgmL/Ptc?=
 =?us-ascii?Q?VeppbX0xxa7qpuL+FySigibWJmwyyRnJNDsiyYj3xZT8vZD5d5Wla/1tLe4T?=
 =?us-ascii?Q?1ocyf8qk5QvoOAcO2anzThvKsJksoUmGJIl79PvyKq/cF33LDirdLzqx2gix?=
 =?us-ascii?Q?hdBRhEQDITes4j2TtzkeEgHVh8rkh34bv4H1mBS39wXa6hw53mlgcdwPNOST?=
 =?us-ascii?Q?fsWoFvOpYAem30T7uCMErix785GN0eprUCeC+Q6w/uypt5CNnraoZ8umxL7q?=
 =?us-ascii?Q?Vg8h3kvh6jkN1iUWGpAJhkJNv07WZj/l0m8DvZZk29eQ1o0jZ5ki/6PT2hv7?=
 =?us-ascii?Q?AGksfvJsx0ScMfTnrs+/pzgu9a68zbWP1JM2KKQWhHTUkhW+JxXaUY3emNRR?=
 =?us-ascii?Q?h3h+P441xlKwRbKVzdhcGzFDrTvHtULoUs27Bte89g506Dy5RTikYupAypbD?=
 =?us-ascii?Q?sgHbXTMBNB2rpHTOHjanKa6kIQeXHtG+5Bdn7RgVaZGp1dC8zVB3pvYGLXJH?=
 =?us-ascii?Q?suZnHRbqsiLRVLfrkmTRRofDJWRox4WnnjyZfdxrnRdAAkwG2Qmm9LEjFAPh?=
 =?us-ascii?Q?RFHhaHitLERy9TtWwg2+YTTw+CVLrB+6VG5Sw1shuNq8ldZVEiVIsOnT4PTg?=
 =?us-ascii?Q?oMouKB302vM7850gr9PO2v2dPbCNf/gP22fRKfa68CMnZHkXRgY1HfzMIHet?=
 =?us-ascii?Q?kVjNJwBQjftJNFNQ6bKLzRTx/kHaxnQc2ZhsAykd81gt0u2cfBJ/IlKz65T9?=
 =?us-ascii?Q?VMYJuStyZq+Yn4c9vctBBU3nqbyx1TiPmF8R/HgdE7ND6gjYkpNFF6ruE9Nx?=
 =?us-ascii?Q?9AoItpeo/c0whfAIWh/aeF3X4KfRZh3paMkAGJ30oKhdSMqWzQAHTf2BCJrT?=
 =?us-ascii?Q?4meyCjb5Cf8T2bktjnXHab2/A+Hsvk/YT9AUxNivj7xsKkbVkeKQW1EzyXVS?=
 =?us-ascii?Q?5TZl+i/AFx7kDotzuiCiH8QE0rkOIPB9tuiRhWzhvPpy7QEkiCbnneb1W8i7?=
 =?us-ascii?Q?/rs9XKYDMXW3025SxkYm3nPLnWMLGcJ3joNcGLlXU9+1iN56GqpJkHCUtInT?=
 =?us-ascii?Q?xvRaTef+zM6ZedgFCvy/oSPKR13walGnQJ46Cg54/HE6wGrKFZAHYJKjpM0V?=
 =?us-ascii?Q?qmdpEs5hw4Ljpx0FwWLoK9CxTjYMke3vmIXF7+Ly/uECF0THNOpuk5b8Nq/5?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98445d2c-85ed-4b8f-7c68-08dbbaa77747
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 13:34:22.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDnNALYgtLMten3D+o2KYXDDEro7GN/qszaXuiEdFEt0Dis52+r3+rqgBkhhtzgInfUEnl7i04EJXCAL/bNEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_fs/sysfs/file.c:#sysfs_emit" on:

commit: d4004295e5502a1eb3e361e97ea4dd1686046af6 ("[PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()")
url: https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/params-Introduce-the-param_unknown_fn-type/20230912-231033
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
patch link: https://lore.kernel.org/all/20230912150551.401537-1-andriy.shevchenko@linux.intel.com/
patch subject: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


what we observed is this issue doesn't always happen. we run the test upon
this commit almost 500 times, it happened 42 times.
however, the parent keeps clean.

        v6.6-rc1 d4004295e5502a1eb3e361e97ea
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :497          8%          42:496   dmesg.EIP:sysfs_emit
           :497          8%          42:496   dmesg.WARNING:at_fs/sysfs/file.c:#sysfs_emit



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309211632.67e4c1e0-oliver.sang@intel.com


[  243.129633][ T4012] ------------[ cut here ]------------
[  243.130401][ T4012] invalid sysfs_emit: buf:94f9d7f6
[ 243.130980][ T4012] WARNING: CPU: 1 PID: 4012 at fs/sysfs/file.c:734 sysfs_emit (fs/sysfs/file.c:734) 
[  243.131846][ T4012] Modules linked in: rtc_cmos aesni_intel evbug parport_pc qemu_fw_cfg
[  243.132786][ T4012] CPU: 1 PID: 4012 Comm: trinity-c5 Not tainted 6.6.0-rc1-00001-gd4004295e550 #1
[  243.133731][ T4012] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 243.134826][ T4012] EIP: sysfs_emit (fs/sysfs/file.c:734) 
[ 243.135330][ T4012] Code: 5b 5e 5f 5d 31 d2 31 c9 c3 3e 8d 74 26 00 55 89 e5 8b 45 08 85 c0 74 07 a9 ff 0f 00 00 74 13 50 68 f9 89 e2 c1 e8 6e ce e0 ff <0f> 0b 59 58 31 c0 eb 12 8d 55 10 52 8b 4d 0c ba 00 10 00 00 e8 01
All code
========
   0:	5b                   	pop    %rbx
   1:	5e                   	pop    %rsi
   2:	5f                   	pop    %rdi
   3:	5d                   	pop    %rbp
   4:	31 d2                	xor    %edx,%edx
   6:	31 c9                	xor    %ecx,%ecx
   8:	c3                   	ret
   9:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
   e:	55                   	push   %rbp
   f:	89 e5                	mov    %esp,%ebp
  11:	8b 45 08             	mov    0x8(%rbp),%eax
  14:	85 c0                	test   %eax,%eax
  16:	74 07                	je     0x1f
  18:	a9 ff 0f 00 00       	test   $0xfff,%eax
  1d:	74 13                	je     0x32
  1f:	50                   	push   %rax
  20:	68 f9 89 e2 c1       	push   $0xffffffffc1e289f9
  25:	e8 6e ce e0 ff       	call   0xffffffffffe0ce98
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	59                   	pop    %rcx
  2d:	58                   	pop    %rax
  2e:	31 c0                	xor    %eax,%eax
  30:	eb 12                	jmp    0x44
  32:	8d 55 10             	lea    0x10(%rbp),%edx
  35:	52                   	push   %rdx
  36:	8b 4d 0c             	mov    0xc(%rbp),%ecx
  39:	ba 00 10 00 00       	mov    $0x1000,%edx
  3e:	e8                   	.byte 0xe8
  3f:	01                   	.byte 0x1

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	59                   	pop    %rcx
   3:	58                   	pop    %rax
   4:	31 c0                	xor    %eax,%eax
   6:	eb 12                	jmp    0x1a
   8:	8d 55 10             	lea    0x10(%rbp),%edx
   b:	52                   	push   %rdx
   c:	8b 4d 0c             	mov    0xc(%rbp),%ecx
   f:	ba 00 10 00 00       	mov    $0x1000,%edx
  14:	e8                   	.byte 0xe8
  15:	01                   	.byte 0x1
[  243.137360][ T4012] EAX: 00000000 EBX: c1aa8260 ECX: 00000000 EDX: 00000000
[  243.138145][ T4012] ESI: 00000002 EDI: 00000001 EBP: eb36be20 ESP: eb36be18
[  243.138905][ T4012] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
[  243.139712][ T4012] CR0: 80050033 CR2: 00000004 CR3: 2b263000 CR4: 00040690
[  243.142408][ T4012] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  243.143135][ T4012] DR6: fffe0ff0 DR7: 00000400
[  243.143614][ T4012] Call Trace:
[ 243.143991][ T4012] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 243.144451][ T4012] ? sysfs_emit (fs/sysfs/file.c:734) 
[ 243.144908][ T4012] ? __warn (kernel/panic.c:673) 
[ 243.145339][ T4012] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 243.145854][ T4012] ? sysfs_emit (fs/sysfs/file.c:734) 
[ 243.146345][ T4012] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 243.146841][ T4012] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 243.147327][ T4012] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 243.147820][ T4012] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 243.148398][ T4012] ? rwlock_bug (kernel/locking/spinlock_debug.c:147) 
[ 243.148866][ T4012] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 243.149344][ T4012] ? sysfs_emit (fs/sysfs/file.c:734) 
[ 243.149806][ T4012] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 243.150299][ T4012] ? sysfs_emit (fs/sysfs/file.c:734) 
[ 243.150759][ T4012] param_get_int (kernel/params.c:239) 
[ 243.151232][ T4012] param_array_get (kernel/params.c:485) 
[ 243.151757][ T4012] param_attr_show (kernel/params.c:568) 
[ 243.152295][ T4012] ? param_attr_store (kernel/params.c:560) 
[ 243.152814][ T4012] ? func_ptr_is_kernel_text (kernel/params.c:890) 
[ 243.153400][ T4012] module_attr_show (kernel/params.c:903) 
[ 243.153930][ T4012] sysfs_kf_seq_show (fs/sysfs/file.c:60) 
[ 243.154456][ T4012] kernfs_seq_show (fs/kernfs/file.c:206) 
[ 243.154966][ T4012] seq_read_iter (fs/seq_file.c:230) 
[ 243.155453][ T4012] ? fsnotify_perm+0x3b/0x40 
[ 243.156039][ T4012] kernfs_fop_read_iter (fs/kernfs/file.c:279) 
[ 243.156570][ T4012] call_read_iter+0x12/0x19 
[ 243.157109][ T4012] vfs_read (fs/read_write.c:389 fs/read_write.c:470) 
[ 243.157571][ T4012] ksys_read (fs/read_write.c:613) 
[ 243.160726][ T4012] __ia32_sys_read (fs/read_write.c:621) 
[ 243.161225][ T4012] do_int80_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:132) 
[ 243.161784][ T4012] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[  243.162309][ T4012] EIP: 0xb7f8e092
[ 243.162720][ T4012] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230921/202309211632.67e4c1e0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

