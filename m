Return-Path: <linux-kernel+bounces-129864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754289716A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B045B2AAC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D226148831;
	Wed,  3 Apr 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UO8rdfJq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643A148308;
	Wed,  3 Apr 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151824; cv=fail; b=cZZeU2C9eI9nfTkOmFzZ8D60CZ1bIe7vaZo18oFOfIBHN3jOsGwSgvHaqsvGyu+9Eduf+++ZmlfAGfdz2XhsuC95E2ic/tfV8L9SQyhMY/KaqAyvK3KqtfvweSGT46qPT1p4xoidMkoaOuRjzP+rIAZzrSLymkSnMt/YXi1nf/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151824; c=relaxed/simple;
	bh=f8gPOpFRy3x7FASSuw+eXaYuQUPwqGsB/OMYVg37tPc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PFntfs4bgufP2aE67BAp9PoL2GTwB5fAA3ZnOVLTo2ohwXqOkkC9MZyZxRUuATg6Z7hptFYOf/njheC3JkNl3CgJlmbA9ZQ6MIQ+jqdnap5Q3vyrrVYEWA8glv9mxPgG/ms9e+7RXGamiVGZ9n2OA7gCN1o0Ese11FwEfCAfzjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UO8rdfJq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712151821; x=1743687821;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f8gPOpFRy3x7FASSuw+eXaYuQUPwqGsB/OMYVg37tPc=;
  b=UO8rdfJqXbANAn3fG9IepmDGX04es/omw3kLriaahZXlAREJn+wKIB2O
   CF/zucEujscveE56F2dxFUAoCea9Bohp7GX1WVguTtUzNW0hw60gC5Y6v
   FyEl2B+U0iLK4UU5Sx6qhUchHurU7SKLfLUohtCy8p8XIoHve40KSLfO/
   +JYO6PTJk5hyhtO7gMWZLBa0OyMyXoUjuoolqpuICDo0UfSMH2eno8xCB
   PNMAD09jRpE77uBWOk74ItM5kilKwvm7U6ATOM9iaBGyyxDGaCiuSxfg+
   S9OwMBHbg/Iw0wB0cBlH6/cPbcHyJw65IAhQkINB6RSFEU90FyCMtaYa6
   g==;
X-CSE-ConnectionGUID: NgyKx6sDQmmpP3fj+Y16iw==
X-CSE-MsgGUID: zViOhcZrSymKjRcXyUrVdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7253124"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7253124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:43:41 -0700
X-CSE-ConnectionGUID: Eh7qqYH0TtG//37yYSQsgg==
X-CSE-MsgGUID: x2vkhD87SxK8RNULrQOviQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18542901"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 06:43:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 06:43:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 06:43:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 06:43:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 06:43:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CizNDdCZmrWTzFUU83KcQYTMqJPxODVxqGtRK4QEtU81B7SdAkQe8IsEmo0lS0/aCvq2nKSH/BGR3pVGnsqFMkaLV4oesJrXcda+aZAPTHFGLpCwaspfvxab9K+uzzDR4W43g0XPL20lf67gY3ep8k1rA+4VHyNgOc0XKJhaMc6B+SYZyM+WJWO1aau6sP08zUuIvvAKgLRBu9sW3COwi0kthG9N+vfW6bggDA/gDj8IsonQoJUQiCIMiF+HPx/YjbLVjinQDXvXa1WKBEUE2Om18ZeBR0nerNM53+XNenUKlWCM5i2RW4s/hHwM4S7fb/50ttxz32kJ5XGSc0x0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0QtEr3SAZ+cuBMHz2v6JrSJpq0kyQk7wTS/ydYz78A=;
 b=mdpujoGgfQrr7hiuyV2uVd/DAU8PtFA2flV8V1uI3oGHuGfZhe8f9tmN6cXw6nVsIPcGG0WHdteR/DAiQu3uYIRoyaOwKYe53Ma7BR68FdCISv+oHdZBqx0pNCzulkjkVtokxmWZVbL7twaiVmLJV9uSw9lo21kfX7dsJN58xAESP1LnN5gmHlseqQbR5Nr/d/hv47tyeyT+IQ0P/l5zFeoVVIcdTmaMbTMadxp2IvgkcNnKITmd53tA30z/V4C7u/WTeglflGUmJbmcuzcVr8eglmW/LKH7vVXVIDIh0Yr0hTzSrrvcsONgYLeGtlRnjKyKJVqxYx1T24OpTseRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6260.namprd11.prod.outlook.com (2603:10b6:930:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 13:43:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 13:43:37 +0000
Date: Wed, 3 Apr 2024 21:43:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yicong Yang <yangyicong@hisilicon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, <linux-serial@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [serial]  43066e3222:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202404031607.2e92eebe-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6260:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hKzR4eqH9MlcAoe8R9I4DwXt050cs/M+NzHthLukkYO3yQstxIg+24xIlecCZZNmoLBj7FStOm1s3sMH0ejNZS5Eah8F3srcYVgrQuMVs53FhMQZIliPu6Len7Iv4F42sBpiWc0UgXevWZXgd7T8t2NiCsHrKF9x2h3upz0yoVh+YdDuBjhi6H7hQQy42h4+nhz0KzDWGH9xJgQfXrZsOH7gLI1txhB4Sc0RU4EdEIqQf7dxsrC9vMXJ4+YJwrJq0beWFTUFB0VNISouQgUxHwzBmvvsvhqXN+RpnV97dUUqROtOwx1uOMkYR5hhiUvyfAOrrtJYS2iGgnDBlWRhniFpOM4sn0AWalVm+20lu0BWimRTxaVkoayLs1MIJQGiIKcbbycaKevgbBwnVo543U7tE21V/f0cTZ60aLTS1MHMjm393HiXs73nVfYYdIajmqqQnEbSoxHNH2CnqlC/Sqt0Cjux/nPXwGPHLpd/+nDRu6nqBWMV4hY1YcjfsLMSH1d1ReCggmCffgywdw4BYg6pBgOJAxC8foFFwCa+HFeB0J3ASM1DygDzJo3iDwzHhbCzRs+Z1v0aMCAisBvKjkOpaw/Ms7CfNO3+4b56effluWepgha/TEy+fIJlZH8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E+pRITTdQRBU28We+pec1a3VZMPrrQFUGV8ZszLv/G2RJEKw2yBUD/qRcxev?=
 =?us-ascii?Q?vdev1HS1WNAnNgsmc0PXIUmQdFq97PBH+Zod2mopJ7L9bM7ANzzoKzbynGzq?=
 =?us-ascii?Q?oS7GQ56Ou2HVuU7hvtmLQeVrFN91PkzU1EC5S25KL2erySWOnG3gmmc4rqiG?=
 =?us-ascii?Q?gWke7psTT7jVbmmD/Ezxfzkw8oQAQ0lboJgYTk1dmDjq6lmZvFdVy0YM7W8s?=
 =?us-ascii?Q?f9QjTZBIo+yd62VUhJM3Uc9Xsmh31G1Bqdz9PMq4UAw75PmX77gRPrjX4e2y?=
 =?us-ascii?Q?I6d+EOaZnc9O62cBJChos7cZZZbHSZDPJeGDbCgOE3z3izrk/5F1X7vLVSUs?=
 =?us-ascii?Q?MCiHe3BpHIFsZeO/7n4TdV7LMK7gizflTRYNFxvn0Lv/PiOn4CW3KzSsCceJ?=
 =?us-ascii?Q?hbAB61JvhvWOjvfgrVkbFlpMBZiwFMOpVIVshI4nXoPxW15mFzbDvfxsweYX?=
 =?us-ascii?Q?BMxr73OBenHGoJn5ODePvu9qlZyS8O/vX+pl9bErcSmdldu0A84rmEYI/t+9?=
 =?us-ascii?Q?zGeR0xLa7rYezcMQftap3ldkguE+Nr96kOjb4oI9y74abltl4+ItnF8zQc52?=
 =?us-ascii?Q?UBu8sCaFJiNGPihD8IkWx5dCFQh9MUgtMzljOnIqhW+hjg5WICOghw7suktW?=
 =?us-ascii?Q?KQb7hFPmceLoZ7VKQasw/r3hcsHwDUPZ3NOCkSOxXCMD9hjGHNGw5BXR4j2M?=
 =?us-ascii?Q?JJCpJiD3bAInsopdSMiPWpGPxHAq437K6tlWUmZOso/DV9q0twp2SRL9dJNY?=
 =?us-ascii?Q?LTGBZ+gqHHVKXCoJ3b6Z6qx3zGsARW38EZDilX4Rpre+H4D8C92dFMOiu9jk?=
 =?us-ascii?Q?xMke+ROE8GkISqxX4HEKeD9FSD1alkTEpk6CD2YknZm4COGn8U/IBdp8Jzd1?=
 =?us-ascii?Q?N/OM2UY/XN3mFrs3G763VducC7nOtjY+BzHLq7Ep+l/79nrU214b12Neu9n6?=
 =?us-ascii?Q?LXqqMX3UZaBs0clCQF1TtbDYzaXfm22Ck44cdhjqNAz+Sq8NlEe3MiCqW4BX?=
 =?us-ascii?Q?a1sxEzv3Izba6+diFgFHJ0bRUSgnq/+4j/MPP/CRPiQNBy+Roc54PfhiYUlb?=
 =?us-ascii?Q?4I5lZqO/HpVzrV240KzpCY94QX+zBxsKVJnmgL9UMrefcoa8hmE7rDSvxwAP?=
 =?us-ascii?Q?jSrX/NwVJ7MAHs+1K+3JIBLYHLfwrR+GDPXbCo59tc8J+t3Pv3rnGn3JboBc?=
 =?us-ascii?Q?U40gB8ke0rGMlxtnzL3+bIHtMzmesl/52L7Pq3IGrk0F8U9rjUuUf4lzUZ0N?=
 =?us-ascii?Q?RUqSrH/70bgMFErXlUcYFpz/U2Nxf5apBaBANPVKd1wzEM9xpy08kH9ZuH/k?=
 =?us-ascii?Q?iI+DygEgu+MqFYGas+iBx8IVT8S3NfqXNyU78eMa7446oWOluAG3b/ExpJFq?=
 =?us-ascii?Q?y6wR7zfXiwyK4p2YR6WVOxrFXWNaICg8/cv63RZFB1kfmDBKI5v9suo4SVhk?=
 =?us-ascii?Q?6B2yc8UW64nAvj+8A+a2GR82f7FMCtzyUM91XhAYoTmC3E3uQOCQ4zm8wEx0?=
 =?us-ascii?Q?mgnvm/Cds92gbXU8PYgKXpUkORkjhtN6RA90wWOWAzCDlWbnNpWVW1wdOD64?=
 =?us-ascii?Q?xDzsHnAaK4bgbxLjbeNQgVrPo+2OH0qPwJhE4sONIAxJt6EcjKLBxzDvn2Dq?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 658914c0-9fbc-4af3-d83c-08dc53e4103e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 13:43:37.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH7ZJaH9kBDzuuqw3xIc49ff5tAlD7URBwP/wtH+9VCCd/WCYvZqIE+M1DSD9OTG21Oe1I22vDCDKKm4KeNjmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6260
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 43066e32227ecde674e8ae1fcdd4a1ede67680c2 ("serial: port: Don't suspend if the port is still busy")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 026e680b0a08a62b1d948e5a8ca78700bfac0e6e]
[test failed on linux-next/master c0b832517f627ead3388c6f0c74e8ac10ad5774b]

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


in our tests, the issue does not always happen, 15 times out of 200 runs as
below.

e5d6bd25f93d6ae1 43066e32227ecde674e8ae1fcdd
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200          8%          15:200   dmesg.BUG:kernel_NULL_pointer_dereference,address
           :200          8%          15:200   dmesg.EIP:serial8250_tx_chars
           :200          8%          15:200   dmesg.Kernel_panic-not_syncing:Fatal_exception
           :200          8%          15:200   dmesg.Oops:#[##]



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404031607.2e92eebe-lkp@intel.com


[   66.918163][   T61] BUG: kernel NULL pointer dereference, address: 00000cf5
[   66.919684][   T61] #PF: supervisor read access in kernel mode
[   66.920890][   T61] #PF: error_code(0x0000) - not-present page
[   66.922103][   T61] *pdpt = 000000002c4f1001 *pde = 0000000000000000
[   66.923402][   T61] Oops: 0000 [#1] PREEMPT SMP PTI
[   66.924417][   T61] CPU: 0 PID: 61 Comm: kworker/0:2 Tainted: G        W       TN 6.8.0-rc6-00003-g43066e32227e #1
[   66.926478][   T61] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   66.928396][   T61] Workqueue: pm pm_runtime_work
[ 66.929411][ T61] EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809) 
[ 66.930475][ T61] Code: 10 02 00 00 75 09 89 f1 e8 b7 01 00 00 eb db 8b 9e d0 01 00 00 89 7d f0 90 90 90 90 90 90 90 90 90 90 90 90 8b 8f 0c 02 00 00 <0f> b6 0c 01 8b 7e 30 89 f0 31 d2 e8 8a 49 51 00 f6 86 cc 01 00 00
All code
========
   0:	10 02                	adc    %al,(%rdx)
   2:	00 00                	add    %al,(%rax)
   4:	75 09                	jne    0xf
   6:	89 f1                	mov    %esi,%ecx
   8:	e8 b7 01 00 00       	call   0x1c4
   d:	eb db                	jmp    0xffffffffffffffea
   f:	8b 9e d0 01 00 00    	mov    0x1d0(%rsi),%ebx
  15:	89 7d f0             	mov    %edi,-0x10(%rbp)
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	8b 8f 0c 02 00 00    	mov    0x20c(%rdi),%ecx
  2a:*	0f b6 0c 01          	movzbl (%rcx,%rax,1),%ecx		<-- trapping instruction
  2e:	8b 7e 30             	mov    0x30(%rsi),%edi
  31:	89 f0                	mov    %esi,%eax
  33:	31 d2                	xor    %edx,%edx
  35:	e8 8a 49 51 00       	call   0x5149c4
  3a:	f6                   	.byte 0xf6
  3b:	86 cc                	xchg   %cl,%ah
  3d:	01 00                	add    %eax,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f b6 0c 01          	movzbl (%rcx,%rax,1),%ecx
   4:	8b 7e 30             	mov    0x30(%rsi),%edi
   7:	89 f0                	mov    %esi,%eax
   9:	31 d2                	xor    %edx,%edx
   b:	e8 8a 49 51 00       	call   0x51499a
  10:	f6                   	.byte 0xf6
  11:	86 cc                	xchg   %cl,%ah
  13:	01 00                	add    %eax,(%rax)
	...
[   66.934169][   T61] EAX: 00000cf5 EBX: 00000010 ECX: 00000000 EDX: 00000000
[   66.935518][   T61] ESI: c33128e0 EDI: c35b824c EBP: c37e7e50 ESP: c37e7e40
[   66.936922][   T61] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010087
[   66.938425][   T61] CR0: 80050033 CR2: 00000cf5 CR3: 28938000 CR4: 000406b0
[   66.939773][   T61] Call Trace:
[ 66.940519][ T61] ? __die_body (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420) 
[ 66.941445][ T61] ? __die (arch/x86/kernel/dumpstack.c:434) 
[ 66.942304][ T61] ? page_fault_oops (arch/x86/mm/fault.c:703) 
[ 66.943233][ T61] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:761) 
[ 66.944260][ T61] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:808) 
[ 66.945368][ T61] ? bad_area_nosemaphore (arch/x86/mm/fault.c:857) 
[ 66.946377][ T61] ? do_user_addr_fault (arch/x86/mm/fault.c:?) 
[ 66.947406][ T61] ? exc_page_fault (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1506 arch/x86/mm/fault.c:1554) 
[ 66.948424][ T61] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1511) 
[ 66.949709][ T61] ? handle_exception (arch/x86/entry/entry_32.S:1058) 
[ 66.950749][ T61] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1511) 
[ 66.951963][ T61] ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809) 
[ 66.953001][ T61] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1511) 
[ 66.954188][ T61] ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809) 
[ 66.955245][ T61] __start_tx (drivers/tty/serial/8250/8250_port.c:1551) 
[ 66.956129][ T61] serial8250_start_tx (drivers/tty/serial/8250/8250_port.c:1654) 
[ 66.957146][ T61] serial_port_runtime_suspend (include/linux/spinlock.h:406 include/linux/serial_core.h:667 drivers/tty/serial/serial_port.c:63) 
[ 66.958275][ T61] __rpm_callback (drivers/base/power/runtime.c:393) 
[ 66.959234][ T61] ? serial_port_remove (drivers/tty/serial/serial_port.c:50) 
[ 66.960282][ T61] ? serial_port_remove (drivers/tty/serial/serial_port.c:50) 
[ 66.961297][ T61] rpm_suspend (drivers/base/power/runtime.c:447) 
[ 66.962165][ T61] ? process_one_work (kernel/workqueue.c:?) 
[ 66.963182][ T61] pm_runtime_work (include/linux/spinlock.h:401 drivers/base/power/runtime.c:983) 
[ 66.964177][ T61] process_one_work (kernel/workqueue.c:2638) 
[ 66.965223][ T61] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787) 
[ 66.966246][ T61] kthread (kernel/kthread.c:390) 
[ 66.967118][ T61] ? pr_cont_work (kernel/workqueue.c:2733) 
[ 66.968018][ T61] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 66.968932][ T61] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 66.969891][ T61] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 66.970813][ T61] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 66.971755][ T61] entry_INT80_32 (arch/x86/entry/entry_32.S:948) 
[   66.972650][   T61] Modules linked in: input_leds aesni_intel crypto_simd evdev button drm fuse drm_panel_orientation_quirks
[   66.974751][   T61] CR2: 0000000000000cf5
[   66.975631][   T61] ---[ end trace 0000000000000000 ]---
[ 66.976733][ T61] EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809) 
[ 66.977784][ T61] Code: 10 02 00 00 75 09 89 f1 e8 b7 01 00 00 eb db 8b 9e d0 01 00 00 89 7d f0 90 90 90 90 90 90 90 90 90 90 90 90 8b 8f 0c 02 00 00 <0f> b6 0c 01 8b 7e 30 89 f0 31 d2 e8 8a 49 51 00 f6 86 cc 01 00 00
All code
========
   0:	10 02                	adc    %al,(%rdx)
   2:	00 00                	add    %al,(%rax)
   4:	75 09                	jne    0xf
   6:	89 f1                	mov    %esi,%ecx
   8:	e8 b7 01 00 00       	call   0x1c4
   d:	eb db                	jmp    0xffffffffffffffea
   f:	8b 9e d0 01 00 00    	mov    0x1d0(%rsi),%ebx
  15:	89 7d f0             	mov    %edi,-0x10(%rbp)
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	8b 8f 0c 02 00 00    	mov    0x20c(%rdi),%ecx
  2a:*	0f b6 0c 01          	movzbl (%rcx,%rax,1),%ecx		<-- trapping instruction
  2e:	8b 7e 30             	mov    0x30(%rsi),%edi
  31:	89 f0                	mov    %esi,%eax
  33:	31 d2                	xor    %edx,%edx
  35:	e8 8a 49 51 00       	call   0x5149c4
  3a:	f6                   	.byte 0xf6
  3b:	86 cc                	xchg   %cl,%ah
  3d:	01 00                	add    %eax,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f b6 0c 01          	movzbl (%rcx,%rax,1),%ecx
   4:	8b 7e 30             	mov    0x30(%rsi),%edi
   7:	89 f0                	mov    %esi,%eax
   9:	31 d2                	xor    %edx,%edx
   b:	e8 8a 49 51 00       	call   0x51499a
  10:	f6                   	.byte 0xf6
  11:	86 cc                	xchg   %cl,%ah
  13:	01 00                	add    %eax,(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240403/202404031607.2e92eebe-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


