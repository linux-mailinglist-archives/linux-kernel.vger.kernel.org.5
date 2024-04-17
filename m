Return-Path: <linux-kernel+bounces-148905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49878A88C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3FD1F22BED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6C1494A0;
	Wed, 17 Apr 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IF6prD7N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8E1487D2;
	Wed, 17 Apr 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371049; cv=fail; b=EubFc/ypxYrXhNzYNlZfgHwA5Eya5AZvdkAdpc0I/iNk6hEZ9jXDP35JQ/RygJOAjjf+6tj4UoRQKpmucfkLHPgGF/eMMMOHv0xtJefdnsKcDyd2UwF8sPcQstdwQYh4QL+NLEHEpdj+o8GcK9hBDMaSNfIiu7ASN/fVjdvdcPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371049; c=relaxed/simple;
	bh=Ovmp7uHPu8fazOeB3Ucr4G6QTIDJ8jkd4J1JXQPsUV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwQ5RvaTXAS4Yu/BWQ4Yb0Uk5BIKs8P4Cm9dTLfLDhIgW78F3isaUwofD/+bjqECKxEMvkMSaKb8+1uxFlxGD8YOas1U/IEc+LFV3498OFOMELS1l4tBeIdBtaTpD8PUIKjjkAgm6+MF9qpZqE/LWqLYg0rz0Zr6+dRISCNX6XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IF6prD7N; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713371048; x=1744907048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ovmp7uHPu8fazOeB3Ucr4G6QTIDJ8jkd4J1JXQPsUV8=;
  b=IF6prD7NPhCU6xm1xM2OGJYVLvWhm9azVayShP4gDCbnSdk6T3MDutlf
   btosqCqz8+WE9oYpf0qjj99FUR3Lj8yXW2tVnPbA7jaIWqUmttUtVEtMp
   Pe1VBoPUcmZx4LLzdozWj4bfqNxUDG4UNTowyp+zGmS/Z2bqUMs5dqRx9
   fFbRGgiUa6MK+pceKGofqd82Sm3vPvonvEgjVFkwxjqCfrRSV0qxuhl61
   wm/Olm/QcFx0jnN7k9CTT/xMe57TKLWtSfMB9MhVMfsnr5qL5P6xIrI2U
   S3boRRWv4g1+CVq8TmK+b1Gxdu6PcZW6cItOz8eOVB+kIAXXZYSl/zTBg
   Q==;
X-CSE-ConnectionGUID: nuzojiOJTjWsVRpTjGIoZQ==
X-CSE-MsgGUID: /pfLvpgyT9CN4Z+cB7jCmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19579055"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="19579055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:24:07 -0700
X-CSE-ConnectionGUID: 2Yp/Q36uRV2XRUDsOiaklw==
X-CSE-MsgGUID: A6/9NKlDQYGwKnjBCjUuSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27452488"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 09:24:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 09:24:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 09:24:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 09:24:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 09:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHC+IuiAa7/29j43kst0WrAwy2vXqwJsziL6+Sw7lHsPE2pXFa8AVX+Vlb+zek6xXkRk5GmiTsqGIagPIXjcFSBzoXrUlzeGemOD0Fja8CcpYat9PfiI9nNElO3h94syZJ3FXq6oGyJGXNI12ytHU8cJ2hPPMZAtxQkfqmPxOri5V34jFIQPBFxrYZaEOpYfOvt4Vq93lON6yy/hSTQaEryyzLrbMLhM2dEr8ZXVw6pUGX+S3XuILwYZb39AZGYfWAhCaf9+jrqNsGwm0CdLTzWZzhT+mZHoZpm7dkt/jSmNmdZnX1AqwOu1IqRO40wXtu57NVOpeAf6Zjl6h+I+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ovmp7uHPu8fazOeB3Ucr4G6QTIDJ8jkd4J1JXQPsUV8=;
 b=iY6JD1BOtLeJFN3ySSKh+b8eTKYig6GOc9dp/2SVR+9aTBHCJ4Mk8v4AbPJjhRzT6tT/wqm953sabN1wYM7zJwCd0XU1u51fyx3zItYte3ImdbpivnC+xkd64MovvYdG2qYsuBZIq1cHMRVeVJeMXNWu/O8gyuZ58pOTkX8PYqpCgtIn03+IK2Ci9thFhRfO5XFeshfOimBbBC2gLSvaHPXri1OteO6EWhG22c/vE+QcGafJnFGyhZ1l9eLr4ebJrwSU3FTYDzQJNQo3W/FE0VQ5sjS+5bDj0U3TLx6S/KZlvjPqsWLrRbZ1S45KFWLJe7fKCi9BnIjTvobrcYB8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Wed, 17 Apr
 2024 16:24:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 16:24:03 +0000
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
Thread-Index: AQHakEQ9MBqgf/dBmUOaCObVibeHIrFsHAWAgACIdMA=
Date: Wed, 17 Apr 2024 16:24:03 +0000
Message-ID: <SJ1PR11MB608394505D03C51EC2583BFCFC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212247.9949-1-tony.luck@intel.com>
 <CAHp75VcQvNqaTj6GTNmhoMbTj-qbn=WX7OSuRwiPaFO5pzPd9g@mail.gmail.com>
In-Reply-To: <CAHp75VcQvNqaTj6GTNmhoMbTj-qbn=WX7OSuRwiPaFO5pzPd9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6660:EE_
x-ms-office365-filtering-correlation-id: 7527cc18-b55a-4681-1b77-08dc5efacbbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3LBgg7vEoeBIBeSyicg0NDi9Gk5pHtI5V6Q1dVVnlR827e76Gjsy3U02h8VmYqZY5bagFPwVm7eaOA8h004tRKlj/aScrzAZuivbj2MTgNXYH5+9Rwx5ypV5yEyRiOe68fqi0KJ/ltOUiNmY3RHTJBYjxH/GS4fFMEl1qkwluoT1L7B/ms1ZTG5vd3G3UdPBtdNasroKepl5bZAijBUoeWXKinQNV1wmZHZE00XzRhRtX/PHceVfX5deiTza2PX5o3MpJPiPRqHrXIRpC8bDRZh4H051xT7Fbn4x5IxC/CfNbeK8eeutJNuPe9914M8vu7aiNdUZG6/BzZezJTa1cJN88nrCrem5fkTh+pukR8q+SJbB825Wn3zUZ3v8UbrLVJvbVCUts7UVA3mUF1BzCB/8Jevq88ohCD//pM0gV6J+OuW6n/+/QYPrSHAzOJPyXMxBWcROK5e3nZ75aQjAxIsPHy2T8C5RngnFkj7BxdgKSZnuTyRfGiJiqbjH0qwW2OmWUGtT7SwlGAjBXYzg0Eig9+6MXiSKhrhE5iv4qdLlGL3QMdfiir9Y/E9ERrq63ZHNOeZYeCAAvAl68FyKOQB3fLmUD2JhhTvMVFz5xIzzK73JpedLiQ8emSN9OJFis5I4Zo+UeApKyZi7iFcAr53VLSu9HMf0BsmZ4U4ji2g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlZoR05xeGYrVk5UbVhOeDVLbnVEb2VZWXk0RXBJWVNtLzhjNjhzR2djOUsv?=
 =?utf-8?B?aTEyWCtMYXRvOEE5bXBZNFVZb29YMTlBUVpYUUVKNmJIeHp6QmRZRytlQXp3?=
 =?utf-8?B?cW9TQzA3Q3VMMWFsRVJHMDhmM0JBVTZ1SU5RcEI5U3JTQkpRcDRuaC8vbkdS?=
 =?utf-8?B?c3paZkc3WDRKV2lOdzZma2tQdENrRW9DeElrdnltY3V6cDJIQmVQS1kxVldI?=
 =?utf-8?B?K3M0NUhTSnBNRDM1MnR5QjV6WnViemhleDF3eFhhaUJycXpBblN0SkJzT29a?=
 =?utf-8?B?UE1Yekt2eEE5TjAxNS9Dd2FVNVZISm5YN1RPTkFFU0VJVXdKMlNTN1hHQU5q?=
 =?utf-8?B?STFHQWRTY3BhR09rbG5lQ1pNT3Z6YjJQYlk0eFJtQmYrTUJ1WDgyR0laL3M5?=
 =?utf-8?B?TlZ4QkQyTDk0dTZUcnBheVJwUVhsTkloSHJuN3lWQTQ0R0JnSThiWXBFdzRV?=
 =?utf-8?B?QkIvanQvTERWWEtBTUFnUmd4S2tVZ1NmWVdVdWZWb1JFaGVlQVRuQTRXUHhw?=
 =?utf-8?B?N2U3ZDAvVEFhZWJVYlZ1QXBDTk42OGNTNGZHelMzRDkycUQyRHdOZlROUWpO?=
 =?utf-8?B?NDN0U2JOQUp6anh2Zm1HZXpwVFdXbDNuc3hTZmI1QWFDVENFS00yRGk5eVJm?=
 =?utf-8?B?QjVBcVFQNlVXeWt1aHJHSExlRjM5ODNGWitDV0VoMWdKeVN4dTBYUmJza3FC?=
 =?utf-8?B?WXRHSGRMaWZTbEErNCt3VHdMbEFtODRqRlVSYTdBRGllYXQwWEtsdzJJU254?=
 =?utf-8?B?cmltNnZ3UloxOXZ4bklQN3NwZjNJL0ZQVzA1Nk13aVhvOWVqQjc4UEZCR2RB?=
 =?utf-8?B?Nkh6aExUbFpiMHlMVFMreDdQWkVwQXlpZjJTaVA1YVp5a2dIMFVNR0RCbFdv?=
 =?utf-8?B?NkdIcTRDV01lcHZHcHlBN3o4L1JLNVhSaXJYMzkyNk5nZy9aeWx5ckdJeDZR?=
 =?utf-8?B?cXkwdUFOckNYc2NiVWRDdlRCSCtDSHNMS0VReDNlQ0dudzJYTDdxOWh2YTlh?=
 =?utf-8?B?b2xpUnNaZUgzdU0wa3pnem9ZcDlHKzVCcVpZYW90ZTdBWDZFUFlPL05pS3Vr?=
 =?utf-8?B?c1V5cXF1UkZ5cnQ2RUhqWTl4VEsxaHAzS1IzdFgvWkNkVE45K0pvMDJQUS9m?=
 =?utf-8?B?NVdNYlJTd1F4U3J2Q2wzWExKODdJWVhBZVpETnkvcFlCYlAyOHBZQy9VNldD?=
 =?utf-8?B?VmI4anRDZ25BQVZ4THpHaENLenp5N21XeE9HWDh3bk8vTTV5eC9WM015dzdO?=
 =?utf-8?B?Q0YydlpwZXFYN2VmS1dWNmhQZ2VxMTErM3gxZ1pRNTlSMkdGUkE1bFduWEV4?=
 =?utf-8?B?T2JCOWFBcm5pMmFCWHI4NnhEUlVydVEzUUFqcHFsZDlxektuREdSRUg5amp3?=
 =?utf-8?B?RTlCeU03Um1TOXFzUmFlangrKzFwMEdoVHptL05TdElYd0xySDFjbngzTnYx?=
 =?utf-8?B?MTJETmJVNHhIMDR1Y0F0VmV4aVpIalRKNW5ISTVnRDVwU3o3cVlGeGJqZEtY?=
 =?utf-8?B?NXd6amQ2VjN4UkpIZTU2QzlMSHYyUmQ1anJRbDkxT1hEOHhrVWZnd1hOc2Ir?=
 =?utf-8?B?WldzRjRMWExNZFJVZ01DSU1ZczRlZUxIUzhOdnU5cU9FUStDeHRDcmRYZ3Z0?=
 =?utf-8?B?WnRGMEQ5eTNqQTlha3dHbEkzVlJDKzhOODQzcmdyVXBUYzlvVW9ZcFAwbE1u?=
 =?utf-8?B?UklTamNFWCtjZEllUzJFOTlLOWpSNnh5RUNRL1NreXpsRVBWZFVmZ2RWemlT?=
 =?utf-8?B?RnlZWGJKVmR4dW9wdnF4SjRCS1dqbWNqWWxRc05ZaktaOTNGa0I1ajI2K2d2?=
 =?utf-8?B?bGQyL0lFTHJ1alVVaVh2UnhPUGRwQXBMT3VycFVVMG1ML09POTJJKzkyeHJo?=
 =?utf-8?B?U2Y5MVV4TGVCejlEVEFMYWZ0cCtwYUsrOHpOaXhudDFoVEZPUjVVT3drRFBB?=
 =?utf-8?B?blZxbXNvQ1gwK3Rhd0cxSTRQaG4xUy9YWTdRNnVXa0VpOVNCOFptK053MHFG?=
 =?utf-8?B?djlOWjJPWnJReWZkM3YwRVN5TERvaEM0WmY3V1F0Mkh3VzA1T2xHRUROY0hU?=
 =?utf-8?B?QVE0aUhmWGc5SS9KTWVCOUxUV2N1L3QvY0VmRGFNK2hhdlRDOTV0bWxtb2x3?=
 =?utf-8?Q?TwvX49add9TZ0YZHmKiCoEh/t?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7527cc18-b55a-4681-1b77-08dc5efacbbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 16:24:03.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgcAtu8S3or9XKinjbfR2+d4FicIRlAOT5o/1M/kV8gDcvcvTRCXFjShTW3d6+Dj4Xyzv0bcXVaMoYUSgFnfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-OriginatorOrg: intel.com

Pj4gTmV3IENQVSAjZGVmaW5lcyBlbmNvZGUgdmVuZG9yIGFuZCBmYW1pbHkgYXMgd2VsbCBhcyBt
b2RlbC4NCj4NCj4gVGhhbmtzLCBidXQgSSB3b3VsZCByYXRoZXIgc2VlIHRoaXMgdXNpbmcgdGhl
IGZvbGxvd2luZw0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni45LXJjNC9z
b3VyY2UvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL3g4Ni9zb2MuaA0KDQpBcmUgeW91IGFz
a2luZyBmb3IgZHJpdmVycy9zdGFnaW5nL21lZGlhL2F0b21pc3AvaW5jbHVkZS9saW51eC9hdG9t
aXNwX3BsYXRmb3JtLmgNCnRvIGJlIHJlZmFjdG9yZWQgdG8gdXNlIHRoZSBuZXcgZnVuY3Rpb25z
L21hY3JvcyBpbiA8bGludXgvcGxhdGZvcm1fZGF0YS94ODYvc29jLmg+Pw0KDQpNYXliZSBmb2xr
cyB3b3JraW5nIG9uIHRoaXMgc3RhZ2luZyBkcml2ZXIgY2FuIGRvIHRoYXQ/IEkgZG9uJ3QgdGhp
bmsgSSBoYXZlIHRoZSBkb21haW4NCnNwZWNpZmljIGtub3dsZWRnZSB0byBtYWtlIHRoaXMgdXBk
YXRlLg0KDQpOb3RlIHRoYXQgcGF0Y2ggNjkgaW4gdGhpcyBzZXJpZXMgZG9lcyB1cGRhdGUgPGxp
bnV4L3BsYXRmb3JtX2RhdGEveDg2L3NvYy5oPiB0byB1c2UNCnRoZSBuZXcgdmVuZG9yLWZhbWls
eS1tb2RlbCBzY2hlbWUuDQoNCi1Ub255DQo=

