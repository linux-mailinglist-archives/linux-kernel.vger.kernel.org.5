Return-Path: <linux-kernel+bounces-156522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25108B03E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1881F2385A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B45C1586D3;
	Wed, 24 Apr 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="np6+MMOJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A113DBA0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946128; cv=fail; b=B5gI9MzNgnROi7zRNKSAf5FBff4zx7iSMk3JaEHZwZ29MjJiI/r3Zav2U/yzLMEO3qb9gbXg9zEDJXIzBdDq/KnG9TzvQDhFN+TJULhccd7YmWluqzrjkzL7BE9WrS9VKzJQITUc6MMu7ycvcb5ZDCvshNX8VoM6b4k1kyXVxkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946128; c=relaxed/simple;
	bh=c99K7uj0CKMLTt9itgzeToH98LXBlSXQxicoWys5lA8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RRGUObpuSzj2HNfq0idyCUtLb5Fjr38aJTwRVbAYGtNpGA+2uYGGkKOO4Z4yLLjCQUXyyhb/+pcppLKKg5MgYFZIL04INqpjIRTh5O//ow8nIShXkE+7YFfLR8JxWwmShHJQIWLsgSEUVR9EQWaj72HgwEcI3o5+hl269SN1UnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=np6+MMOJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713946126; x=1745482126;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c99K7uj0CKMLTt9itgzeToH98LXBlSXQxicoWys5lA8=;
  b=np6+MMOJqc/8DyguE5SKpLZuF56bEgZI9EIZ3IqKx9TWgG7MP1SYfq17
   fqMLcw/rXAW4vFB1IatYcLi75z0hJZzhyUk5yczy8CwjB5PlYLgBtgF3+
   uKAgqk5p/RYvKuELC1TB6e7xHaQNwIiYuZgu7erlZXom17Pw9HeNmQopU
   ujZajhsEe4nBPujPXoAAewsvsZU9GQptquoBWiD1+qGccXu54kmrWopVK
   zyPajuxpcuoEdOQ7vJ10wrl1SPlnVyZGnNNaw+JvHEjdy4gklv24w5sF9
   YsYS4GE1boLLA5uiVx/GQUlFVczBCtqxgDPAgVunkRZN22N4qSbosOIIE
   g==;
X-CSE-ConnectionGUID: sbkcEVTRRMWk75YiQyYfvg==
X-CSE-MsgGUID: M3kukKQdSdmMSRnolozO+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34964672"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="34964672"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:08:45 -0700
X-CSE-ConnectionGUID: L6t3caW1QGCc1AQunabrfg==
X-CSE-MsgGUID: +h/PjmvXRXeKENSqhDPxEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="47891686"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 01:08:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 01:08:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 01:08:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 01:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBAomDF484A0E7O/hzXav/c43Q4AgQsesQze/gA2SdmnaGJBj54JyyRpyklQTOIvqSHyYMI0jpfr5r/agzvDRTD3zT7F6nF5AMYRilc3WIp/YM34wO6lsKO9v5VgNe7XPD8XbnIT1MExPLJa3K+T+82tCbF60Vubf47nJCs0w5La+NHXGxG6m9za9po6X02LpNlUOmKo1Dr3u9QGCJBknFC1+6yiiv9YMmJxc8/CmBW36Iu1XdkfViESalbaXskbz0bap6vuehLCl/YZT91ShzzW7mFa0E4LvBwhPc33F3GicKX4Y2E6WBOT/9aQx0Hi8eY2Qf/kNp8A420z9ZOP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxGDAqD42ohE3JK07mKMDFWMQoBkyex5UJW1gdjqaR0=;
 b=QIulNgxoffPQzQKx315aoTU6lmnI/YoTIxFWoOvVl1d+rClipqvM/uTSzI8tdJnAO2QKeXwqXK9ittlHVIlzZDicDK7QBYEzJjr8HDUqcb7T6oELJEZZhVjmws2XjI1HqYpZMYM1t4gooPO6f4o09hC69/RNxWIB2/yVwo91ivgzrWo45mRkXqA8b1JmxkGnNr24v5LlYQfjBtB7GSwpIH9A0smX6iKgL2o3UUfXQCXw9prmJeqg8Cj+Xdtqf9NZKjjQ2iy7/Mch3HVb/q2i3jCdKq7DNmTZJ3emDH3yUwZrcXY2vT70oIAiGE3O+p9hLjnqO7Ytb2vfEVU/Rs/hFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Wed, 24 Apr
 2024 08:08:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:08:20 +0000
Date: Wed, 24 Apr 2024 16:08:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Masahiro Yamada <masahiroy@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [kallsyms]  0bdad28369:
 UBSAN:array-index-out-of-bounds_in_kernel/kallsyms.c
Message-ID: <202404241532.b583b55f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 4508f1cd-a9d4-4af7-4bc4-08dc6435b462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?13DnfOVJlGoMr+mwA8SyPxvAxoYOjk+atzTITUruvahg35ZbG2ODIkUBcaGv?=
 =?us-ascii?Q?4kj5XrXMsF5s7myrEXLJETuQivVNKUgnLvLbpgavP4T1mJf+XBSPDxIkOQvv?=
 =?us-ascii?Q?NqG4aB74PCspMLqhEO8vp1XMTLynmJk6xtYDFB5eJLHULol8kYUIfTX3Lgdx?=
 =?us-ascii?Q?xYCYB1Kur/10y/qcL/hdkVL9MbcpnYnTsg1F/WV1xOLbdBYSCLjLUcFj5BFl?=
 =?us-ascii?Q?p9anXG8Pgp3A73bWvnN04KJ6qI+Gw57fHOrRXoWSzVZMCCOSnHwF4GkktyDL?=
 =?us-ascii?Q?rjnDkklwHdYEaZfyBQTZ3Ct/+K7w9qrMe7uFkgJKNzAznhTjp0nPPJ0nMXIa?=
 =?us-ascii?Q?yEm6e6jcX9IRhOPDxpCktOfSCJLrmDHAjHciaPYRlSKOK5D03x4fDtLKiNDU?=
 =?us-ascii?Q?8XCuJmlKGk1kmN8vta//f6z9btZA7aJb1eXc4Ulj6fFBA8N36+F3vhbvd+kJ?=
 =?us-ascii?Q?724Wd3nyqKCRA+UIl6m8JzAtEJk8RGqJmxaqyriqvWleeJBfM60TvJdAfng/?=
 =?us-ascii?Q?WrjeNTS+shyZmIW0eKbvkj7VAJUhOm/zqhnPASrB1y+gR4ih7BXw1CVYZB7q?=
 =?us-ascii?Q?DtOrxk4g+pRRAAouPOx+FQSpZyQ4mUPIuE+OgX8SdoQ1fd7NZyB3phhw0sw3?=
 =?us-ascii?Q?DotfDbSbDdzg9v05WfXdo2p3anRirX26A3i99rCcfF3WnWIa19jrNSrA2Rfq?=
 =?us-ascii?Q?SCGL9syaVqe1QKKbUNFlggbRsoIij1K5yF4zX/322hel+60hkTolt0zfD3Gl?=
 =?us-ascii?Q?BXtsxuSL+vI9FUzL7aR6lV7ZJHXcXXEyZySrRhC29WC2BWWw7AnpvnNV35LB?=
 =?us-ascii?Q?nQZ8AoPDS/mxlSy9L/ZbtcX3vW36AMAoYw4VE7n5IHPd50rrclj4cIzMSNYI?=
 =?us-ascii?Q?WTVN4Lj1EUk2EnJziV5kEj4hV/YwSV9wFZrNR2wRdT8u8sNrQMLA8sOZ498i?=
 =?us-ascii?Q?ua7UtBrph/0ZskPTKaekDreRSIBxjDHDrvU8rucwLE2uZBkWf113gIPtPacU?=
 =?us-ascii?Q?xVikLx41xaGGcbsyuQSTgUMpRmZ97bfLYUASlJ1h37OTH+UFZgsAMRW8n07F?=
 =?us-ascii?Q?kV+bYUFdLBqVSGlA4XEgXg8vPyGDiHIFqwAgnZTiHTkqFg0shMvd76/uXTI6?=
 =?us-ascii?Q?r6dj2rrc2QbRO/fRqg4dq43zgWzwZzPZG5GePstclqoxD77SUnkm+uBFZyIM?=
 =?us-ascii?Q?vJyuA0kwaANge0/2o96tmTit7iRIOs1D+XVGFStZ5pJBRZ6iGpEJGZtnfnk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6UAbMYhYhQctHI7azMNneJK8Xvwk2S1uaqut4fosbAs985O8fgUBy0ViZ38N?=
 =?us-ascii?Q?AnethWi5BfrLpL/IrhT+T8EyWYlNQ2yI3x80yimpr5f7XzLfqME/mBwDB4WN?=
 =?us-ascii?Q?eawB5WpIoiO6R8Lxu87/SfyYL9VR1/5zHmhOMG2a+bB2cNrPWV3OM+P1FIjp?=
 =?us-ascii?Q?JEZeQW34cmCqkm3epGH4yrpPK1K3qrDzNQRW+j8Nfnks3M5yVtqXMa6gcPLS?=
 =?us-ascii?Q?e4bYVcKNRk8HB1MWkeibDm30OZ6GfE1mKl7qG7E+zaaSBJHrqNx3JI+dITiV?=
 =?us-ascii?Q?zRN0YVbqFdqcWQqBUgitWG7C7ogGCQXbWMFR7x5nNFwIMcpbsWRUU1oqoASl?=
 =?us-ascii?Q?grzdnA/5gw/wJS/Z33weQPUQLNvJNo9fxyf5zDyo7DVEeqPhofOlsfqLNjjO?=
 =?us-ascii?Q?vkR6djZQj9pRhCKmKZAIN9a6JiVbhiAAaIxE7+TsFG7dPSeWlKVTpnmPFWvV?=
 =?us-ascii?Q?jzXaT64amU9/DX7gRJjClr/Nw2pJq2K/Y4Qrlh1ZK7IpQ67h+RnchtjWDQbB?=
 =?us-ascii?Q?ov+4A7ZiEjT5jnbFFyoUKYO1oSKMewVQu7MPYtEXYhiT8/X1RGwLcoxaRLiw?=
 =?us-ascii?Q?Yiu4cyay+nswFGJt1SRZj05+NWHCqGwwTr6nBpfOErZYNAAj2mDyfo12nN2F?=
 =?us-ascii?Q?/6oaAtAGVqn7nd8z48fyZ4b6mTQyNFrZgp9TCbfs7qqHUPjFY0WX76rvYBTo?=
 =?us-ascii?Q?zFbg0qeVmJtGmP+y7mK3jn2oKuLJWm84lNYoHS9CdD1qrPbPcKgwqfB0iXVO?=
 =?us-ascii?Q?qXUbvUIIW240nr0cHE0HWqb2xYDv3S1o8fllAAXoAAVt3yoJDbWuR2b5w5+U?=
 =?us-ascii?Q?Zxb/Ez7xZJlEr6wu3ta6S3GElUEuGHxStOuckkGdiMXNkoKr5//1n4Y3UtG5?=
 =?us-ascii?Q?N8O+km70b6xU/ieP99un2R7FGGdiG2paC/y+Um8a36kwLYqdBLXCMp6Tj5F6?=
 =?us-ascii?Q?cikr8WbDX7f8THyzUV8IcYlQL8dsy9s6xS7bMVbyka2rgAMSzXrzXRfHWRwU?=
 =?us-ascii?Q?MeY5JTm6cznHJX15qXgMlDr2ux+f1cxqC/Hy0Lpy3H/m+1Uc+CQ7EJptTEsR?=
 =?us-ascii?Q?GYCVf0ASK5ls6IDHoh2h9FVZQ5Ou9yuGK7SNhaa3xBnDRqTDF0MwEKLAM4qq?=
 =?us-ascii?Q?gmbu0YGnDsclqjs41kZgaHiTx3guYf+mJpSvwaDo3qz2z2Ebfwo6HKHbOgb/?=
 =?us-ascii?Q?XiswdQAhQ/mMtumaETU+zw2HiIdE9DTcDLFrM4YpYhW6HxJizUpi3znX9B8V?=
 =?us-ascii?Q?NG3ccTqslrBoqGpiBx3J/ointBAv4WxDZndXHR1COulqSavefF90Dl1OUB4l?=
 =?us-ascii?Q?Us31Nc0cccAeV+HkDsHsfiD/9/MH0cli+VWX7NgxccHWTytvoQ7aTGxmVzWB?=
 =?us-ascii?Q?ms23+Bti9320Reep1FRI2KFYWIXVWykzQjKRvz9xgtwxdQ9TeaAkyLy0KMTB?=
 =?us-ascii?Q?CIx1/tQXoiIgImmbp+eIgL1kIw0aKODWfnf6k2pNhxFAyG2mvv8T1vwmCu26?=
 =?us-ascii?Q?vZEPbNZuDsTtQOKp2Hh0E3nWaJ64OB+60YKpGUzFDtyroQcIU0/35J2a28Iu?=
 =?us-ascii?Q?Dr54QarxDvJxur+eFGzQ46UpfwA63PxDg2NIo2Bm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4508f1cd-a9d4-4af7-4bc4-08dc6435b462
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:08:20.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7weMwwfU448wRJljJA9rzZwo4qIG3ZT254y0e4HQPpyghZcB71xv3EGz0yrOoflYxCxKh8MpbsZZZZtNrbwzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_kernel/kallsyms.c" on:

commit: 0bdad28369fc5e93de39b5046228ed78e982fc71 ("kallsyms: Avoid weak references for kallsyms symbols")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------+------------+------------+
|                                                      | 82d460edc1 | 0bdad28369 |
+------------------------------------------------------+------------+------------+
| UBSAN:array-index-out-of-bounds_in_kernel/kallsyms.c | 0          | 12         |
+------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404241532.b583b55f-lkp@intel.com


[    0.148342][    T0] ------------[ cut here ]------------
[    0.148746][    T0] UBSAN: array-index-out-of-bounds in kernel/kallsyms.c:181:40
[    0.149452][    T0] index 69197 is out of range for type 'const int[1]'
[    0.149954][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc5-00005-g0bdad28369fc #1
[    0.150594][    T0] Call Trace:
[    0.150834][    T0]  <TASK>
[ 0.151048][ T0] ? dump_stack_lvl (lib/dump_stack.c:? lib/dump_stack.c:114) 
[ 0.151403][ T0] ? __ubsan_handle_out_of_bounds (lib/ubsan.c:232 lib/ubsan.c:429) 
[ 0.151851][ T0] ? format_decode (lib/vsprintf.c:2592) 
[ 0.152205][ T0] ? __cfi_kvm_guest_apic_eoi_write (arch/x86/kernel/kvm.c:337) 
[ 0.152658][ T0] ? get_symbol_pos (kernel/kallsyms.c:?) 
[ 0.153016][ T0] ? __cfi_kvm_guest_apic_eoi_write (arch/x86/kernel/kvm.c:337) 
[ 0.153469][ T0] ? __cfi_kvm_guest_apic_eoi_write (arch/x86/kernel/kvm.c:337) 
[ 0.153921][ T0] ? kallsyms_lookup_buildid (kernel/kallsyms.c:429) 
[ 0.154333][ T0] ? __cfi_kvm_guest_apic_eoi_write (arch/x86/kernel/kvm.c:337) 
[ 0.154785][ T0] ? __cfi_kvm_guest_apic_eoi_write (arch/x86/kernel/kvm.c:337) 
[ 0.155236][ T0] ? __sprint_symbol (kernel/kallsyms.c:513) 
[ 0.155597][ T0] ? symbol_string (lib/vsprintf.c:?) 
[ 0.155958][ T0] ? pointer (lib/vsprintf.c:?) 
[ 0.156273][ T0] ? vsnprintf (lib/vsprintf.c:2828) 
[ 0.156602][ T0] ? vprintk_store (kernel/printk/printk.c:2228) 
[ 0.156963][ T0] ? lock_release (kernel/locking/lockdep.c:?) 
[ 0.157305][ T0] ? vprintk_emit (kernel/printk/printk.c:2329) 
[ 0.157645][ T0] ? lock_release (kernel/locking/lockdep.c:?) 
[ 0.157986][ T0] ? _printk (kernel/printk/printk.c:2376) 
[ 0.158287][ T0] ? __cfi_kvm_guest_apic_eoi_write (arch/x86/kernel/kvm.c:337) 
[ 0.158740][ T0] ? kvm_guest_init (arch/x86/kernel/kvm.c:?) 
[ 0.159100][ T0] ? setup_arch (arch/x86/kernel/setup.c:1156) 
[ 0.159435][ T0] ? start_kernel (init/main.c:906) 
[ 0.159776][ T0] ? x86_64_start_reservations (??:?) 
[ 0.160195][ T0] ? x86_64_start_kernel (??:?) 
[ 0.160574][ T0] ? common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.160956][    T0]  </TASK>
[    0.161176][    T0] ---[ end trace ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240424/202404241532.b583b55f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


