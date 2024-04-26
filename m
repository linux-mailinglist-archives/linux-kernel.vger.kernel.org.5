Return-Path: <linux-kernel+bounces-160700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0669E8B4149
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0081F22466
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE57364A4;
	Fri, 26 Apr 2024 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UD+w/SqI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0762C85F;
	Fri, 26 Apr 2024 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167318; cv=fail; b=gznGmh9v+STnO2SoaEgI5fLPMHfpGE23q1xSzMyCo8jmv0Px7IDwlJswa/lzyhbMypIfPAQ7pDu2gdKJTps364bYtgTqyjFNZ0M76WBJgUa0hgFflxoprt+v6qxMaxI7KF+l5wzm/FxJ/gIzkuuxzvI0I8mvJUNU3bQ1EsvJHAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167318; c=relaxed/simple;
	bh=ZiGkIm4XuCmTGjZEN+FUzrhgC07TlZobtviS9KVYCOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DigbU6AJPwS4RoKrRLS4HkIidD8lKUUzGAKfnAj9q40mw1DzJX6Gf/HIwWjG+sXq306WACtz8WoMSFfG+Y31BQw/v3km+QCnUk457RyaozBBSnaygPgaO/h6TynYuLSW7+341esymSGCL5LLmmgRtS8Q4kKNxiWsycFVcGwec6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UD+w/SqI; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714167316; x=1745703316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZiGkIm4XuCmTGjZEN+FUzrhgC07TlZobtviS9KVYCOM=;
  b=UD+w/SqIJCvIlieVYEltkGmzX55cFl+YIQ1O7g/a056NnWNgj3vWXSNy
   2y94ZCqn8r6ws9qdrWbLNErGSFsiYCTLLLIhHTqaqZEQ2xw4xFclBuyQh
   B6zchgGUgLH+0WBs7CHPJ467Ifkk/j4qspAWaSPUtn1ZX77SWmAeWwtEE
   Gl4ngJ8OX8UnmvMA3YJBUIn06GlwKYoxtRqFEFAZ98ndvn5t51VqLYoxR
   bL0abtbMZCC5HJTP5nyQPQcl8Kwi+HgvvgqnB2Sz15wzW2s9ali3Hd7T7
   1N5Z46+REm4ezmUbW5+rPRtsVxTgA1TvmHN701jH/OC0kRbO3P/C2q+QM
   w==;
X-CSE-ConnectionGUID: VZBY8wT+SXWHeM3EX5EfKA==
X-CSE-MsgGUID: pzdWH5MxT1mPa0swvDdjng==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="32416490"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="32416490"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 14:35:15 -0700
X-CSE-ConnectionGUID: wQ/uJcHYSG6EHw7MpCSgrg==
X-CSE-MsgGUID: tWmCK9C8Sp6y/8YCHMkNTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25942989"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 14:35:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 14:35:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 14:35:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwW8vmDhurpMU7HNqQvcSr/lorZ3Vn90YyXZLXl4DsbujDpu2nSxQvGFDfUMWx2btDMBsLYvj2bdPMIKDJvObAPcNvWRJ0hYTaTeilz6IzXftV+9Czy8sKjB0utd5uh5xqzDni+VH4OxHd5dCub4NUZjwV+zU0OA0fKdv5Or/oOnKxSB97ywP3bZ7UYNszj1oxPIcxYQYqCFiZq95uirGP3qHmvxoKkUiKysE1US4QeDiEF/90bdQzA3B9ZBJ8TiKHUYn4lRvWb6TTEBFfTY0nEP5DGggXoK1isdc6ecL5XwaqeIHaY0ZuHW359BeIfbAVqS8Slaazq0C5jkdRrBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiGkIm4XuCmTGjZEN+FUzrhgC07TlZobtviS9KVYCOM=;
 b=ZQ9syaZPyj/j7oqwSnBfJ+xPDDW7eM+KAtOpz0lbg2DOyBGcN0N9m1Q5HZzL07BAii8+E2kexJM5LOZGFrCwFvW4JTAzTVVJstpazwgf5R/w1RKJf/bIynTWgu3gh3kkRb5faN2E8QKXqmGy3+y746DEgLRG3UxzNirELmJGFEfTRtdH4Hf4o9HAXTUhy8qM97Y8ZEovtvcNSHIMpXDexT1HbCX8b3Vs7KNSrV+OHp+P6SUVWhAnwl8XITVdoRD26FX4cyKsnEq6kOUqR998W/+SH2BndDUd21T0HsaU1eVr3uVFmUrbr6LAea0qHUfa/cSGLRxoDDN6Box3OjB+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SN7PR11MB7539.namprd11.prod.outlook.com (2603:10b6:806:343::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 21:35:07 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b%7]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 21:35:07 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom"
	<trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH] fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card
Thread-Topic: [PATCH] fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card
Thread-Index: AQHal5Buo9oogKBY1kiKbRW6LaH79LF7FBOA
Date: Fri, 26 Apr 2024 21:35:07 +0000
Message-ID: <0081a4ba1304f37142e6b1714d022fd4e7c9821f.camel@intel.com>
References: <20240422230257.1959-1-peter.colberg@intel.com>
	 <ZispK+l5kWCxtfns@yilunxu-OptiPlex-7050>
In-Reply-To: <ZispK+l5kWCxtfns@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SN7PR11MB7539:EE_
x-ms-office365-filtering-correlation-id: 9433ffc0-7fc1-4b09-699a-08dc6638be14
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RkFHcnpCeTV2aXVvTTUzNkV3MEtkTGJsdVh3UGlNYUJSMHFMQnV1bXllM2o2?=
 =?utf-8?B?L0xOUklNZUZRZFJHVHBXbVNUMmJuUGp4TVJlWHlXZ3JqY1J1NkNhZ0krQm1l?=
 =?utf-8?B?YVc2OTZvMGQrNnpRakZOM0FpZnBMTTZpS0ZDQ1cyUERweHJidExNWFFTUTNZ?=
 =?utf-8?B?SmFUS0hjUlVTcVVlVzM1WnBjdUI0WjZTdkdQVzJVVlBoU2YraFF1N3RJbVJL?=
 =?utf-8?B?MHRzT3FTa1FmTkVkSy9jcDRrU1E0dVFpZ092c0xyaWh4aUsva2ZqUlUraFU0?=
 =?utf-8?B?bW9XV2pGa2lRS1VLQi9taG9kNnJucDR0cFREYTN1WVZTaVJIeWR4UGdOYWhD?=
 =?utf-8?B?WWVhc0tjcFA1WFpqVXFnQTJSOEZmVEJrdnJBT1VtK1BwUnlIN1BmM1pydHlX?=
 =?utf-8?B?YzRYVm90TVEzSHVOQy85ckFsSzlRVXVWemQ0YkZjOEhMNWVrTDJpdkNyMXBw?=
 =?utf-8?B?a2VVZjlrSllLN3U0Y0xGcW9WNy9GbHhLSVMwSFI5THRpYWVXTHZjR205ekUx?=
 =?utf-8?B?aGdDaWY3T0NZVmVhN0dzY0lXdGYxdXJhZWJpdy93OEZKREt5cGJjVEd3OVhh?=
 =?utf-8?B?ekFhTUxlQXExWFlpdDRjNmxDVTJXaFR0SEJNdmVncEJPV0lSdFRpdk5CZjJ0?=
 =?utf-8?B?NDZXNzU5dExpT1VpVGl6cDF0VEN1ZlNmcDAvaUdXTUlOZXF2aFR6RkE1WGhk?=
 =?utf-8?B?TWloRzVUUGlGc0ZQMzk1eDUyd0kwY3V4UmppT1dQbmkrYVlTK29ieXY5THNh?=
 =?utf-8?B?dWM5UkVSVnQyT3VUdFMvckt3NStoNU92dDkrOHJBbUtZelpHcTdISTFKazBT?=
 =?utf-8?B?eXphRlE5UzJDbFRFRVcxWUZKVkxjZ1JWeVlnV3UvdUNBSGVkMndiUXY0MHlu?=
 =?utf-8?B?S0tQWmR5TmRCTEV4dlg2SkRaQklXS1ZqRWhPREJ1azIveUFkbUNwWEtERmVQ?=
 =?utf-8?B?UDRoM041NzR2N25GUkUzTS9Rakg5SUx4TGF5eEFuZnh4N0VlMzdVdU1QQVZp?=
 =?utf-8?B?MTZRTDJwM2RvL2VjSG9vdElSU3RidmlFem9jckZQb0wrdlpMaDlwajhZN3Zi?=
 =?utf-8?B?R3loM09KeVZ3aUJrbm5uSjhoSXFIS3dNTjRGd1lQR1I5WDZWL2lzcEFFTklQ?=
 =?utf-8?B?azhOMERqK3RyWDR6UzkvS2VRZVM1N0hZUGN1MUlhRW1QRVY5Ly9Ud2ZKZC9Y?=
 =?utf-8?B?aDZaUC9DVG9RaCtabHhBbitjdG1QT2YrNHdEb3E0bFJjMUw0M1NsV21iQzIz?=
 =?utf-8?B?cXh3dFRRUTZCenZWeG1wQ01sd0FyTytuWVBkZmhwK1hpVERyV0NHQm9Dd2t6?=
 =?utf-8?B?L1RUV3ZrRG1SaUxZa2d5OU1lUitVV2pSMTRrNjQ0b3FPU2J1c2ZzV2tSSElW?=
 =?utf-8?B?NjJKNjRBTE92OWVPaXZrKzF3S29xT2tlSUZBdHByNDZWcU1ITHQwVURoVUtW?=
 =?utf-8?B?MllwbkVYMUtUWDNpNDZMZjNzN0ZnN1VDaGNqbExjY3BxWFFKR1VDVk5PTXJo?=
 =?utf-8?B?TVNueXE0ZjNjb0VtUDFLTWpEblhOVHFJSk55S2xLeTBncjJwSmcxTUM0MnJM?=
 =?utf-8?B?cEdaNmlVcUFTSDlPMFluYng4VUJUcUlVYi9GUGZaa25KSm9DZW9nWTFCemFo?=
 =?utf-8?B?bElTQ1kreUp4eFJCL1pkcFZUKzFkc1IwU0RNeWRhUVlHWldTclpScXFpQ1FF?=
 =?utf-8?B?eE1pMHp2M1NIV2IxcUpTOURlODJBbWxaSVFvWnpvTEpJODNQMXE4d1hheUFO?=
 =?utf-8?B?TkZ2RGsrN1I0WjBjeVowd1lFbnlGcTF2L2RGRkZSQ2ZnYXVYQ1pxemRuWmND?=
 =?utf-8?B?UHFuVU4ySFg4ZGxMd0EzQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWo4bTdpam5oWFdXUHYzZ01kVng3M21MdTdZQ3BweDg0OFFaeGN3R21SQUhv?=
 =?utf-8?B?dFV4ck03dnh5bERYblZOZXV2cWNMbFlGM0hXdHdjYXBRVHV1NjlkajV5dUh0?=
 =?utf-8?B?a2pveW9zRnU1bVlrTzJsYTE5Y0RXcUYySzBLWW9xMURMaFBRUmZkVWVmWXZL?=
 =?utf-8?B?RlBnUndWYTN3ejQ1UGplMWREQTB0dkM1S1AwdWhYZkJYdjA2b1MwV1NYN25Y?=
 =?utf-8?B?bG1YM3ZjckFUbmRqMFc3R282WU0veG9talFvUjR3UVhLajRuVFJZWFNiZlRr?=
 =?utf-8?B?bEVlMFV0R0pzZE1YelUwT2dwV3IxR1FHWmZZdW1oNm84ZldMYS82eTlabzlm?=
 =?utf-8?B?QUp4Wjhib1hkTGtXZ1Y3ZkkyVkVJQVBNSDFSbkZZRWlYY2Z3VWp6WVdFZEhB?=
 =?utf-8?B?U0swY2dXRnNFM2IxUDljNzhsMWcyS2F0aU8xNC9UdTlaWCsyTWQrVmJvdWlk?=
 =?utf-8?B?Y0JrUXpQL24wNXBaOFVFOWJjeXdRcnA4aFd2MmN3U3lqdTcrRDd2SzJEbVZW?=
 =?utf-8?B?U1VjWmFSOFhxY0Uva0I4c1V0Nm4rNHpJR2hVdWNGaHFva2tPcEhBSjVwY3JS?=
 =?utf-8?B?T0pLdlpTUEw4Zk52OUNCemNURUxsMTU5NkswaGQzdlQ5Q0dhVDUrM3I5STZ6?=
 =?utf-8?B?SCtYcmhkdTlsRXAxUmt4OUxOYVJJTTFLWFBtRGdFMUxMdU1PSFc1cEpOV0hi?=
 =?utf-8?B?N0F1a0RDUThzOXNsNmh2UzliU0hFUVdOeEZrZ3RNaEp0azFUS2J2bit1bUZn?=
 =?utf-8?B?Z3MramRBZWFxZmdqM1NqcHpuQmxjTnM4d293ZVNka0V4SUE4SXNSZ1UyVUVu?=
 =?utf-8?B?QnFaOVNZT2NMT2dyc1JNV2VPN1dJalE3Y3BoZHpIUGVxUkpqNWpXZElwZFVL?=
 =?utf-8?B?dWcxWEJjV0xIbVJQY2hLWkNLRU5QbUFIQ2FFTkN0eXBRcVNxZTlCMU5yTUVl?=
 =?utf-8?B?L1Q4b1FaVEN6aktMc3d4Q0gwL0ZlbGFQVkdMdkt4WkZEZHNRNXdueUJnbTc0?=
 =?utf-8?B?OUN2bnY5dE16QXBpZ0pQYVp1cGdtNGg3VGdhN0E4OVRMeTNDSDlEaXJwV1hH?=
 =?utf-8?B?bTFWTVV4bGZ2Wlk2bWF5ai84YlRBVmQ5RmZVQzU4QlowMUtDS3RlbWx1UXVO?=
 =?utf-8?B?c29icWt5QVF3RU1kWkpDYllkOWhvQ21ERHhZcGpEK2JEMVVsdE54RDJ1UjE4?=
 =?utf-8?B?eVpXVWVBOWNDYmsyNkxVcC91QVNET3Q2NVNtZWNJL09ZcnBHRDJhZDlZNWpO?=
 =?utf-8?B?dDR6dWorRUVtU2l0OTUwV1JCMjdXd2pBZXBVaWR0bnFTNFc4M3NHbExncWpR?=
 =?utf-8?B?Y240bllsUjVIZUFNQTJVc1lodXhhZFZWN25rL3lwd25RVytQNmd2VFpzUVU4?=
 =?utf-8?B?L3Ywa1E1QXZmUmtlc2NZL2t5eFpNdGRia3BYaFNqNHp3SEVJYUpuTURuekJL?=
 =?utf-8?B?TFRyaC93b1RLSG1uOTZXUWFPSmpUNStvSE9xVDNSc3VEbHJhNU5WRlMraUFv?=
 =?utf-8?B?R3Q3dW0xS1RITlhHdmZFcVVGQUs0MkFTVkxLUWVpcXRmQStKaWxOUjRablhF?=
 =?utf-8?B?UGJJRFNZd0pGZDI1VXd1aW1ocGh4QTJmM1RrSXJJNndxcmp5Nm1mczVPb2xB?=
 =?utf-8?B?Nm1SNi9TUDJDdXFrNDJXYmxDbTJ4aW0xVWp6MjJ2NXhESnBRTUEweEZLT0R1?=
 =?utf-8?B?R1NRQlpRcUlabmtPdVc5a2FHSnNZT3l3WXRFZm5POG1lMzcyTjBKRDIyNnNm?=
 =?utf-8?B?YzU4TnpVYVNsZmh5ZFR4azNvS2JoZnc2WEU4RTd4STJ3YXVlbEdlSzBRZWFx?=
 =?utf-8?B?aVRjUnNuTDkxUG1pSHZMWmxQZy9qemdiYW5UY3VVQjVHSWJXTitNTlZSWWtS?=
 =?utf-8?B?OHlnRFpWbjg4b204MzM2UWQwblpJSTBmK0RxNkpSbitPakFaQVJRc2toSVND?=
 =?utf-8?B?U2tNaDJqUWlqellQbFlSbkZ5L0ZWUGhDN3BUSTQxWlN4VVFOYUFMZUpDU3hz?=
 =?utf-8?B?ZTBFME1wdzNhTGxBdzEvKzB6N0x1MEVweG11YnlzQ1BMQTBZY29PMkpWV0cx?=
 =?utf-8?B?aWkvckJYZDRBWUY1RTFoVnF2SkxhR0lsaHp2WmN0T0J6MDY0dXJYYWV4dHhD?=
 =?utf-8?B?UWRucktPQ1BQVWdlRGptUldjME0yWnBOT0U1dzVOUlRsd0FNalN4bVBPOU53?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96BF78CFC1F87D49921080FBF7296D12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9433ffc0-7fc1-4b09-699a-08dc6638be14
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 21:35:07.2702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6N0V70uNXxnIvvZO6GuHshEKRNgux/G9CVcbbEljLYPw8H/2W14EXzG4sQmRoUAIq6RbsObzKjXFytnPszr9cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7539
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTI2IGF0IDEyOjEwICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
TW9uLCBBcHIgMjIsIDIwMjQgYXQgMDc6MDI6NTdQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBBZGQgUENJIHN1YmRldmljZSBJRCBmb3IgdGhlIEludGVsIEQ1MDA1IFN0cmF0aXgg
MTAgRlBHQSBjYXJkIGFzDQo+ID4gdXNlZCB3aXRoIHRoZSBPcGVuIEZQR0EgU3RhY2sgKE9GUykg
RlBHQSBJbnRlcmZhY2UgTWFuYWdlciAoRklNKS4NCj4gPiANCj4gPiBVbmxpa2UgdGhlIEludGVs
IEQ1MDA1IFBBQyBGSU0gd2hpY2ggZXhwb3NlZCBhIHNlcGFyYXRlIFBDSSBkZXZpY2UgSUQsDQo+
ID4gdGhlIE9GUyBGSU0gcmV1c2VzIHRoZSBzYW1lIGRldmljZSBJRCBmb3IgYWxsIERGTC1iYXNl
ZCBGUEdBIGNhcmRzDQo+ID4gYW5kIGRpZmZlcmVudGlhdGVzIG9uIHRoZSBzdWJkZXZpY2UgSUQu
IFRoZSBzdWJkZXZpY2UgSUQgdmFsdWVzIHdlcmUNCj4gPiBjaG9zZW4gYXMgdGhlIG51bWVyaWMg
cGFydCBvZiB0aGUgRlBHQSBjYXJkIG5hbWVzIGluIGhleGFkZWNpbWFsLg0KPiA+IA0KPiA+IExp
bms6IGh0dHBzOi8vZ2l0aHViLmNvbS9PRlMvZGZsLWZlYXR1cmUtaWQvcHVsbC80DQo+IA0KPiBB
bnkgcmVhc29uIHRvIHB1dCB0aGUgTGluayBpbiBjaGFuZ2Vsb2cuIEkgZGlkbid0IHNlZSBpdCBw
cm92aWRlIGFueQ0KPiBleHRyYSBpbmZvLg0KDQpUaGUgbGluayBpcyBwcm92aWRlZCB0byBwb2lu
dCB0byB0aGUgY29ycmVzcG9uZGluZyBjaGFuZ2UgaW4gdGhlIGRmbC0NCnBjaS1pZHMgcmVnaXN0
cnksIGZvciBzb21lb25lIHdobyBtaWdodCBub3QgYmUgYXdhcmUgb2YgaXRzIGV4aXN0ZW5jZS4N
Cg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBDb2xiZXJnIDxwZXRlci5jb2xiZXJnQGlu
dGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3Lmdlcmxh
Y2hAbGludXguaW50ZWwuY29tPg0KPiANCj4gQmVzaWRlcywNCj4gDQo+IEFja2VkLWJ5OiBYdSBZ
aWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPg0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoN
ClBldGVyDQoNCj4gDQo+ID4gLS0tDQo+ID4gVGhpcyBwYXRjaCB3YXMgYXBwbGllZCB0byBMaW51
eCB2Ni45LXJjNSBhbmQgdGVzdGVkIG9uIGFuIEludGVsIEQ1MDA1DQo+ID4gY2FyZCBmbGFzaGVk
IHdpdGggdGhlIGxhdGVzdCByZWxlYXNlZCBPRlMgMjAyNC4xLTEgRDUwMDUgRklNLg0KPiA+IA0K
PiA+ICMgZnBnYWluZm8gZm1lIEQ4OjAwLjANCj4gPiBJbnRlbCBGUEdBIFByb2dyYW1tYWJsZSBB
Y2NlbGVyYXRpb24gQ2FyZCBENTAwNQ0KPiA+IEJvYXJkIE1hbmFnZW1lbnQgQ29udHJvbGxlciwg
TUFYMTAgTklPUyBGVyB2ZXJzaW9uOiAyLjAuMTIgDQo+ID4gQm9hcmQgTWFuYWdlbWVudCBDb250
cm9sbGVyLCBNQVgxMCBCdWlsZCB2ZXJzaW9uOiAyLjAuOCANCj4gPiAvLyoqKioqKiBGTUUgKioq
KioqLy8NCj4gPiBJbnRlcmZhY2UgICAgICAgICAgICAgICAgICAgICAgICA6IERGTA0KPiA+IE9i
amVjdCBJZCAgICAgICAgICAgICAgICAgICAgICAgIDogMHhFRDAwMDAyDQo+ID4gUENJZSBzOmI6
ZC5mICAgICAgICAgICAgICAgICAgICAgOiAwMDAwOkQ4OjAwLjANCj4gPiBWZW5kb3IgSWQgICAg
ICAgICAgICAgICAgICAgICAgICA6IDB4ODA4Ng0KPiA+IERldmljZSBJZCAgICAgICAgICAgICAg
ICAgICAgICAgIDogMHhCQ0NFDQo+ID4gU3ViVmVuZG9yIElkICAgICAgICAgICAgICAgICAgICAg
OiAweDgwODYNCj4gPiBTdWJEZXZpY2UgSWQgICAgICAgICAgICAgICAgICAgICA6IDB4MTM4RA0K
PiA+IFNvY2tldCBJZCAgICAgICAgICAgICAgICAgICAgICAgIDogMHgwMA0KPiA+IFBvcnRzIE51
bSAgICAgICAgICAgICAgICAgICAgICAgIDogMDENCj4gPiBCaXRzdHJlYW0gSWQgICAgICAgICAg
ICAgICAgICAgICA6IDB4NDAxMDAwMjE4M0M4OEE5DQo+ID4gQml0c3RyZWFtIFZlcnNpb24gICAg
ICAgICAgICAgICAgOiA0LjAuMQ0KPiA+IFByIEludGVyZmFjZSBJZCAgICAgICAgICAgICAgICAg
IDogYTE5NWI2ZjctY2YyMy01YTJiLThlZjktMTE2MWUxODRlYzRlDQo+ID4gQm9vdCBQYWdlICAg
ICAgICAgICAgICAgICAgICAgICAgOiB1c2VyDQo+ID4gDQo+ID4gTGluazogaHR0cHM6Ly9naXRo
dWIuY29tL09GUy9vZnMtZDUwMDUvcmVsZWFzZXMvdGFnL29mcy0yMDI0LjEtMQ0KPiA+IC0tLQ0K
PiA+IFRoZSBtaXNzaW5nIHN1YmRldmljZSBJRCAweDEzOGQgd2FzIG5vdGljZWQgd2hpbGUgdGVz
dGluZyB0aGUgcGF0Y2gNCj4gPiBzZXJpZXMgImZwZ2E6IGRmbDogZml4IGtlcm5lbCB3YXJuaW5n
IG9uIHBvcnQgcmVsZWFzZS9hc3NpZ24gZm9yIFNSSU9WIg0KPiA+IGFwcGxpZWQgdG8gdjYuOS1y
YzQgb24gYW4gSW50ZWwgRDUwMDUgY2FyZC4gVGhlIGFic2VuY2Ugb2YgdGhlIHN1YmRldmljZQ0K
PiA+IElEIHdhcyBzaGFkb3dlZCBieSBhbiBpbnRlcm5hbCBwYXRjaCBpbiB0aGUgZG93bnN0cmVh
bSBMaW51eCBERkwga2VybmVsDQo+ID4gKCJmcGdhOiBkZmw6IEFkZCB3aWxkY2FyZCBzdWItZGV2
aWNlIElEIGZvciBpbnRlbCBERkwgZGV2cyIpLg0KPiA+IA0KPiA+IExpbms6IGh0dHBzOi8vZ2l0
aHViLmNvbS9PRlMvbGludXgtZGZsL2NvbW1pdC8yN2QzZDcxODI0ZjA4NmFjYWU4NmU0MWE4N2I1
OTE4MzhiN2ZhOWQxDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwtcGNpLmMgfCAzICsr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLXBjaS5jDQo+
ID4gaW5kZXggOThiOGZkMTYxODNlLi44MGNhYzNhNWY5NzYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9mcGdhL2RmbC1wY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMNCj4g
PiBAQCAtNzgsNiArNzgsNyBAQCBzdGF0aWMgdm9pZCBjY2lfcGNpX2ZyZWVfaXJxKHN0cnVjdCBw
Y2lfZGV2ICpwY2lkZXYpDQo+ID4gICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfU0lMSUNPTV9QQUNf
TjUwMTEJMHgxMDAxDQo+ID4gICNkZWZpbmUgUENJRV9ERVZJQ0VfSURfSU5URUxfREZMCQkweGJj
Y2UNCj4gPiAgLyogUENJIFN1YmRldmljZSBJRCBmb3IgUENJRV9ERVZJQ0VfSURfSU5URUxfREZM
ICovDQo+ID4gKyNkZWZpbmUgUENJRV9TVUJERVZJQ0VfSURfSU5URUxfRDUwMDUJCTB4MTM4ZA0K
PiA+ICAjZGVmaW5lIFBDSUVfU1VCREVWSUNFX0lEX0lOVEVMX042MDAwCQkweDE3NzANCj4gPiAg
I2RlZmluZSBQQ0lFX1NVQkRFVklDRV9JRF9JTlRFTF9ONjAwMQkJMHgxNzcxDQo+ID4gICNkZWZp
bmUgUENJRV9TVUJERVZJQ0VfSURfSU5URUxfQzYxMDAJCTB4MTdkNA0KPiA+IEBAIC0xMDEsNiAr
MTAyLDggQEAgc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIGNjaV9wY2llX2lkX3RibFtdID0g
ew0KPiA+ICAJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJRV9ERVZJQ0VfSURf
SU5URUxfUEFDX0Q1MDA1X1ZGKSx9LA0KPiA+ICAJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9T
SUxJQ09NX0RFTk1BUkssIFBDSUVfREVWSUNFX0lEX1NJTElDT01fUEFDX041MDEwKSx9LA0KPiA+
ICAJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9TSUxJQ09NX0RFTk1BUkssIFBDSUVfREVWSUNF
X0lEX1NJTElDT01fUEFDX041MDExKSx9LA0KPiA+ICsJe1BDSV9ERVZJQ0VfU1VCKFBDSV9WRU5E
T1JfSURfSU5URUwsIFBDSUVfREVWSUNFX0lEX0lOVEVMX0RGTCwNCj4gPiArCQkJUENJX1ZFTkRP
Ul9JRF9JTlRFTCwgUENJRV9TVUJERVZJQ0VfSURfSU5URUxfRDUwMDUpLH0sDQo+ID4gIAl7UENJ
X0RFVklDRV9TVUIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJRV9ERVZJQ0VfSURfSU5URUxfREZM
LA0KPiA+ICAJCQlQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0lFX1NVQkRFVklDRV9JRF9JTlRFTF9O
NjAwMCksfSwNCj4gPiAgCXtQQ0lfREVWSUNFX1NVQihQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0lF
X0RFVklDRV9JRF9JTlRFTF9ERkxfVkYsDQo+ID4gLS0gDQo+ID4gMi40NC4wDQo+ID4gDQo+ID4g
DQoNCg==

