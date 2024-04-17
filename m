Return-Path: <linux-kernel+bounces-148992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C388A8A31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD4B1C23260
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B73172768;
	Wed, 17 Apr 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8edtbrN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE017166F;
	Wed, 17 Apr 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375085; cv=fail; b=HeCAm6nq3/Z/XJHs1rURXjkQuB8tcQxLBEkCeI+rrWXC6+MKc0v1Ug9WS4O/hP1AuB717COrf/OIE/siPremlAJdalrP/mEJxkPqgys1Ema5TQ4RevOLLkGM24aeQeNwBF8Vm23d1sBvvtePr1MSNEss+f35aSih9q3RHUXW+LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375085; c=relaxed/simple;
	bh=/bgD/dBFhmPOHqW3381b3oq9KtVJ0MFmFAohe8nwYfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDzQZxrhXQYtUOQdWA/irR/oO9GcpTfd0gqoKHoqroI2wO75IYXW3NI2G5Ydw99x5imp68ZnLfzU0lMWhGWxsCl7NT4G5zr13YoHGU+w2T9wj1XI2gm9ZvbRUfjoy3fqekP0eQ1mcVPLJnAP89+vUEiJve9nSdVUAGeqref3mKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8edtbrN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713375085; x=1744911085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/bgD/dBFhmPOHqW3381b3oq9KtVJ0MFmFAohe8nwYfM=;
  b=k8edtbrNLvJ0x41oyIlZUeZC75XJzyVnLSpoHoSVnpn/XWOuUJVQRrC3
   +SxohCoBejJibiOenGLPQFkBJcWRzHf+NGj4+1wzjvyyj4IT2ICJXJd0j
   7Sg3uDcCL75e2PregV4rE7q2Na8AhklX6/Nzm/grjJNocNBtIAvaq0sgP
   7bpmEcNPkZgW/64/8SmryDYldTRLKltadKEL8qEJyhihOFG08k6xOL7kK
   3W9d26XtMZmZBgYvjx/GemMX46ImSdM8+5DectlKXejKsi3W3FeSi7uSP
   ZXTW5+PkzMZQCUosZ8vHpDkwIOS7zL/RLWh+HlWEuv58qxNVpFVVeGDxr
   w==;
X-CSE-ConnectionGUID: D/7TzOdRT1O7SScd2mbdfA==
X-CSE-MsgGUID: VNmCrnzDT2WG0a+FobHBHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9009960"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9009960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:31:24 -0700
X-CSE-ConnectionGUID: 6DpU/i99RhuAzwxYgEn1gw==
X-CSE-MsgGUID: cJx3KAzwRc6h21ARnVHe0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="60109845"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 10:31:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 10:31:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 10:31:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 10:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdjfMoSN/tksQ+Mz7kND55tvrI5sZoVcLdwKoJWligEnaspW/vN+MrZC8ZaTbtqMg81apvE66Wi714fHeZDcLaIX5uFk5S6aJyawxG2BaRb6+x0e0q/S/ltVJT+POsG5rRsgtMFi6Hq0KzjOdXUg1ib8aA3MYSOC1oEfVq6I2ob2lm4fTAmdhruFCLGDHmz4+spRlB+hW9MdH3X/MyUg+LzDEmNbLf478Pm+r0PUZoKmK9TGGAMgNukMJr4CJhCI1EmFc5esliI47A51epXRhtcaKjNSNP10+IUpAiCnGnZI5CNpjmLUAuL+V6/x/zWJOV5oa0ABpm9bTMKtzE+ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bgD/dBFhmPOHqW3381b3oq9KtVJ0MFmFAohe8nwYfM=;
 b=THUmvV1GWOsLALUNlIV8TdQ9OkrIWzypIb6Vx/gPplXVuqfOp+PUXqDNksdObzpRxdJgjvWU1fjRs7eRJNfW4toh/qqmyQAGWrsjy0SyLVKKv1YK4RTF/EZBU14UtwAZuyvLVKzxHiw5yzZILRiypG2P68VmDOm1QffnewrTAcPrM5Fgbcav7ofJO/BPcH3x5KV8fSqUyzBHsFL6+MiVEshGd8S0Www4BJdKHHPXfBSCWluje+Uw9LlZQ1UTIVlqdUsw3y6J/9r+qs/wN3N8wjmLvoFQgXAw52ZC72rJ5F43VozLuotfwlaMb1+B5XJbKqVfXJZkfPFCk18BtWsUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 17:31:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 17:31:21 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v3 68/74] x86/cpu/vfm: Update
 drivers/staging/media/atomisp/include/linux/atomisp_platform.h
Thread-Topic: [PATCH v3 68/74] x86/cpu/vfm: Update
 drivers/staging/media/atomisp/include/linux/atomisp_platform.h
Thread-Index: AQHakEQ9MBqgf/dBmUOaCObVibeHIrFsHAWAgACIdMCAAAx5gIAAB6PA
Date: Wed, 17 Apr 2024 17:31:21 +0000
Message-ID: <SJ1PR11MB60839EFAC1A7984287ABDBE3FC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212247.9949-1-tony.luck@intel.com>
 <CAHp75VcQvNqaTj6GTNmhoMbTj-qbn=WX7OSuRwiPaFO5pzPd9g@mail.gmail.com>
 <SJ1PR11MB608394505D03C51EC2583BFCFC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAHp75VcbtB=UEjBVM+C3_7Rbt9y1VSVkBOxjpyTA6TBYvtLqzw@mail.gmail.com>
In-Reply-To: <CAHp75VcbtB=UEjBVM+C3_7Rbt9y1VSVkBOxjpyTA6TBYvtLqzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4603:EE_
x-ms-office365-filtering-correlation-id: fbf42a0d-0c27-4f5b-e1f4-08dc5f0432e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NaFkfr5xqZUC4848w5BEiDU5527ZEGk7QYB/byViHvEod98kH/tq0to7a3YpsfnwSZ7LoHByV20nTp/TlFoDO1rQDCAFdNaX8A2CnjIXtazcUzb4kgQolAZJvY506dzAMxpsw31dDNjAS7VVSNb4yE9ucm/Cq3KNxL1ES+OCw4NOld2csWzb27vVgng24Hcij2X0ocobKMiUN6VvxRfEU10vpl/LJLrep/z0+3Sa9Z0pevalMQ2pBHUC5Q0R/UOQnLa9Hu5eiG/pjBRXLaAfaj2STG52uepNp/KGHdNLcHseJXFWLdn+IYMVc0A4L/n09MnMK4cfojMcQrabJUve8Z1/iaaMuxhhbpOJ3jaazgZez//IiAKuiCo0dS4Vjw6KZPFZqyaGY5eCvpUcTpa5400Bv4jCbFxxh9mpg5vMNEmqHy2DU+3W6tM6yB32T/uBiXneEPZS0JqJya9iAVB1BGSuE7iNXgqyOmXfkxr2+FPtwfxm1T8vhyVHQXLhbSP6vrUsjqRAIusDaMjl5LoKVxJx4NeR/AxoRrayZDDweNCTfv7Fdnf2t2DuKdO0/2KdJZRsJ45ObFvIOW7CTYxKBSxW0+Kazy/D5hVWM9H7FgRXJu9bcRXVv/mufyX8POSp+V+99JhficXuWQ0gkiR8JOeV9RY643sxsC2P5CEv2LWbW19nG+EexaiMItNMk8uyHiBFVL7RO2imJ7BIoZJDeCxcIY6R0UlDGJYZeaJmAcI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGNPNEJVWWdqandBTjA5L0x5VjMxZ3RkTGxmZDIyY3UzUmlkdGpsMkFEdEFF?=
 =?utf-8?B?VUhyaU5LMHdac3AvM2lDaSs0UlpWNTJCS2VSeDE5R0xqWVNMbHVsTno4dUVD?=
 =?utf-8?B?bmxXTVkrRWNpMVcrR3ZzZnhJVlUyczFCY0cydUJFUk9tOGM5enoxQlYrWDk0?=
 =?utf-8?B?UFBKSHBncDNXUjZkVjBpd21ZNmtOVUVTSzM4VnJSSG1xZE5vaTM0WG44ekha?=
 =?utf-8?B?cjgwS2ZxcVN5dUt5NUYvMHYrV25PUlM3aHYxSWY3MHNkdG4xL1VrcWxEMGFM?=
 =?utf-8?B?dFNxczd5ZVl6dG9mbENuUVRXUnVwWERaVWlTS1UxT2NXcUY0UVNwejBRTW5x?=
 =?utf-8?B?SVNIZ24wVXBudFNSYWZCaGg3TEFkL3JGMk1WdHJiM3dMajhOV2dBV1J2WERq?=
 =?utf-8?B?S3h6L1BualBxNHBiQmJNSXNmTlZRR2ZOT3VKcmpzR2dFMDVhS1NNM1hZSHpN?=
 =?utf-8?B?QzMxSGFOYlBsU2FpZ2FpUlBrV3FmZ2YwMVhacEl5SzhEc3BZY2xRRGxRWEQ1?=
 =?utf-8?B?YmRySFp2YlBMRGVpZ1daVlVIdS9iUy9KOVdoTG4zRlhGQ29JWUZza0FsZzhJ?=
 =?utf-8?B?dXBuWGxybUtHOEdkRitBUnduYWVEZ1hOUVN0dDVNNDBqZVBjSjNxZ3Jnc0g2?=
 =?utf-8?B?ZkVDTUxVa1ZMbEpqak5MUVJUcTNXdmxwRGdaTnJGK0grd0FMR2tUZkdLaWN4?=
 =?utf-8?B?WTlVZ2xPakFVSXh0Wk0wY2Nxcm9wdjJvTGIvZmlrWlFGMFJMTWZuYUVsZE1x?=
 =?utf-8?B?YjBFVmFtdE93V1dKZTZkcHdUMXkweXArSUxtS0NoR2plNE5UYVp2S28zS2d2?=
 =?utf-8?B?MG1jVmNxQXJxc244ZWF6SFVsUGM2cnc3dEhRaUNSV3Y4NlhkOWMwQVFhcjVO?=
 =?utf-8?B?d0o4UE1jY1FYb0p2Y1JCZFFwS2hyNGlQb0ZSM2xlSFBCV1plbU9jblk3S1VB?=
 =?utf-8?B?ZFJIZzFSNDNpS0JLbHcxcjQ5Tytxb1czdnFzczVZd0U2VFZWN2RWbVowaWlX?=
 =?utf-8?B?Rnc2amZjbjlSYkpPUFlFSG5XRUtUeFhzUjBEUDYyQWtOd29icnJSS2FOa1dK?=
 =?utf-8?B?QnYvV1d1aVZrWDd4TEg5ZjMyRXdMdzZUUm51R3Q3R2NHd2NScGg0K1NxN2dZ?=
 =?utf-8?B?bmJadXZsT2hmMlhYQ0g0eTR1ZVJPcEV1S1ZkRlNXMytVQnI3UUd1Rmx0Tkcw?=
 =?utf-8?B?NmxzS1hzNmxaTU1QQTdoMmFCZ0RieXFOb2IydklHSHE2ZFEvaEd2T05Md2JP?=
 =?utf-8?B?MlRyRmNPYktXY1RlVmRZV2o3QVI3QXFvZzdPUHRuUXY5TnhNWk9udy9uTWhl?=
 =?utf-8?B?YTdSMHJOanV6bEVReGJXQ3ZyT3NhSVVNSHByMUpIWndSdFppSmJWUDRjdDk5?=
 =?utf-8?B?MzVkbk9xQzRVRTEwYTB4THN6MnNBZkI0Mk1SOEZ3MGE5N1NOM0VJVnFGUm5U?=
 =?utf-8?B?cXVMbWRhTUdTZWYvOFA0MG9kMmRCemYrNVNsYnJib0l3M0dINEkzRGFzOStE?=
 =?utf-8?B?MWw2TkJHN1ZVdVZhc3Z2bTRCc1p6MkdHWWRCZUNpbm5yZTgwU2RWOEJaNU1P?=
 =?utf-8?B?VVcyTk9PYlJLZzE3KzNMTU81UHB1MTFBb09ZZm9HTE80ZFZRR3NZN2dsdTZ5?=
 =?utf-8?B?aHh4NElkY0UyVzI1c0dxTEg0L1prQ3J2aXhnTWh3cDZUaE5iajhqQkMzdUMz?=
 =?utf-8?B?aUdDVFVhUzJBVm1tLzM5dk9CZGYzQjV4VVpGOFduL0p2R0huVTdvZHBPa3RF?=
 =?utf-8?B?cG9sMlY5SVlDbnZSL0kwTkJBQnZmOGU1YlRUQ0NBQ3dsakVlbkNvM3Y3bmht?=
 =?utf-8?B?YUk1ZG9OK2ptWFdrc3RWck1jYkJWOUFoeXppRG1LMmRmS3l2SzF2Si9WMDRn?=
 =?utf-8?B?TGRnQ0xtZ295RlhOTWtmUTRFblZadTF2M04rejJlZktLTkVIQmMrRkdKOXpl?=
 =?utf-8?B?RS9iVHBTMlVQV2wrN1gwN01LZENHNzRBK1NVYlBnMHRpaEZLVjVmZVVRWHBN?=
 =?utf-8?B?ZjgvWURCZndIakVVV2xxU0lvZkVkSDQ5dm1CLzBMOW9NTkRrTng3a2pXaE1P?=
 =?utf-8?B?OXdiOXZjOEMwNU9ZTGQ0WS80a3BsYWZPdVN0QjN3K3M2MmpnbVZ3M2VXb0Qv?=
 =?utf-8?Q?R73fUuEv4cXDgUw4FdjvIR9eP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf42a0d-0c27-4f5b-e1f4-08dc5f0432e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 17:31:21.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9yxL3tvqsIm8dPsFieHR4u9Ip5vGqpeTY4hlQe5Aym9OyisLHCMAIoxTbquXDckC72fboyHy/6Y6Resm6WyCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com

Pj4gTm90ZSB0aGF0IHBhdGNoIDY5IGluIHRoaXMgc2VyaWVzIGRvZXMgdXBkYXRlIDxsaW51eC9w
bGF0Zm9ybV9kYXRhL3g4Ni9zb2MuaD4gdG8gdXNlDQo+PiB0aGUgbmV3IHZlbmRvci1mYW1pbHkt
bW9kZWwgc2NoZW1lLg0KPg0KPiBTby4gbWF5YmUgaWYgdGhpcyBwYXRjaCBpcyBwbGFjZWQgYWZ0
ZXIgdGhhdCBvbmUsIGl0IGNhbiBiZSBlYXNpbHkNCj4gc2VlbiBob3cgdG8gYW1lbmQgaXQ/IEkg
d291bGQgaGVscCB3aXRoIHRoZSBjb252ZXJzaW9uIGFzIEkga25vdw0KPiBzb21ldGhpbmcgYWJv
dXQgQXRvbUlTUCBkcml2ZXIgY29kZSAobm90IGFzIG11Y2ggYXMgSGFucyBkZSBHb2VkZSwNCj4g
dGhvdWdoKS4NCg0KT2suIEkgcHV0IGEgaG9sZCBvbiBwYXRjaCA2OCB1bnRpbCA2OSBpcyBhcHBs
aWVkIHNvbWV3aGVyZSAodGhhdCBvbmUNCmhhcyBhIEFjayBmcm9tIFJhZmFlbCwgc28gaXMgaGln
aCBvbiB0aGUgbGlzdCB0byBtb3ZlIGZvcndhcmQgb25jZQ0KcGFydHMgMS0zIGFyZSBhcHBsaWVk
LikNCg0KLVRvbnkNCg==

