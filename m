Return-Path: <linux-kernel+bounces-155103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5F8AE54D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21295B24B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542B13BC02;
	Tue, 23 Apr 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHnyyhn8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637168613B;
	Tue, 23 Apr 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873016; cv=fail; b=rije8X3lDSM6Z3pmbbHfudXPScmfCVqEwLdyZfhRKb+jLLcWDysWofCJPqDcedchcFmpipieWZVNHdmYDS3MTMGG0z2k8/9bJloZUha8cbQmDEJ2IVxgxnOiUMyKVcrOpDTCkly2Ht6CDeIRZ0JfGLG/ga37IBIT8oyLyryU4MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873016; c=relaxed/simple;
	bh=RrOR4waaK2yZKMBiaGRD3F9DcPtYZzJHwC5rKfjcr/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=STRS6EDy7wwa0JK8iqWQBRotKL1tdwWfNbT5hfOLitTg6DSeLLY+82saGHzyI11+wrTSTKdAyF21shC9VlVnCP9bAKTry5L6SfPf3VSoIcjh6SFoTL55LVjcsw0b58AqA949UPYk68FVFdvbi8h3+Nb9cYQumEQKM1NvOTKQ1yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHnyyhn8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713873014; x=1745409014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RrOR4waaK2yZKMBiaGRD3F9DcPtYZzJHwC5rKfjcr/g=;
  b=fHnyyhn8hCFTwFhlcJc1DNyCZ/TcO4IYftOIWfQ29xZFqTDYVge9Hag/
   qEjgXQcU+OkZMf1oeePL3gD+5R1L01nIoBCgmqRVNHZCaB0niBA1X7D+n
   5tsAiN3PghfGaEONXfldv4DM/a0WB0kZkkG5st//X1GQy7tZKElbFuMTB
   o4jlGgO5YS8azALiAH3MqTemFBe/KA1SMmDg/ZkRuzpOwyz8/Cp3TIFAN
   hdThkgGku0Q1G9Rhf8o55Es/JiZHfLkFWmqgx1kxM79ZHqbHg3tuzoS/1
   JWWuPYPf8FUaYSNQ4IhEZSR4lV+BhhijTvXJYaSj/EvL5Nm215lk3/hM6
   g==;
X-CSE-ConnectionGUID: /mgNCsPcT0y6Oox0UYewIw==
X-CSE-MsgGUID: 7VdnGq0qS0aWZCO07NfD5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="12385319"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="12385319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:50:12 -0700
X-CSE-ConnectionGUID: SLrRBbP3RQa0roQNPdtXdw==
X-CSE-MsgGUID: wZ9VKagGTBie8OPvWjLpRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24350754"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 04:50:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:50:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 04:50:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 04:50:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9inyXnACzpTjDJv9Hr5rkO66OaX4l09N6bC073Iq4+b2+53+bVPEGbw0ACQaCU5mbILdqzMi5DDqffo/OBX9smlgvU5ettFiPl6C37tdd16WAy7UgVtPPez7xUup3+RxRE7Gis679NhBjWsvx3iG8pj+XlG/NTm1VBAoh2R8YriuMsQNxakV5KpUtXp5MyMTo6PPeuFcHIQjcNkyLvYkEdcX4rGa5Ac/8PGLwzME35+Dcb7/BsMclNqnk7ZC4BOlDuUy5Zx4O8C9Z/o1gSbGBDWLGHf+15q62ECOsLBECRQEXXp4k8Ca/wkitWlqiown7FLXU9EVt06WZKsJ4oYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrOR4waaK2yZKMBiaGRD3F9DcPtYZzJHwC5rKfjcr/g=;
 b=RvO6pZ3wyImMTaqJgvdd1qD0c3c80Tw5Die+lzJ66aL3Y5xj6ZbmqS33ErX0jmJZSLNVzaHjLt4PNl9HRbu67zhCl4WzcpPvVtkBzzQcEeDNZFirg7C+l4Yw2rFeLgDiNIZRNh6yvcOXoM+t+PohjOMpnznv6dR4Zzn68KxVL2uXISck67FmslkKGk9iP3ofdo/gX0D3cN1G9HSQTsr1GoN46Xt7U077SOXvNVeuP621i6EDZUwqJvARo8m/27WYlLPULELY1KSIWY4lqf1DLpsOJq9w+8q1oB3PIdD6B6ivquQDErbL0Iqcyx48rFOl3nZpnwRUgEWSHsFDzjQG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 11:50:05 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 11:50:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"zhubojun.zbj@antgroup.com" <zhubojun.zbj@antgroup.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "Liu, Shuang" <ls123674@antgroup.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
Thread-Topic: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
Thread-Index: AQHalWKxh3aLqK2oAEW0jm6Q2AbS37F1vfoA
Date: Tue, 23 Apr 2024 11:50:05 +0000
Message-ID: <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
	 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
In-Reply-To: <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW3PR11MB4620:EE_
x-ms-office365-filtering-correlation-id: 32572b24-6455-4234-8db6-08dc638b8456
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?K2lhYjRDNnc0c0E0amZiTlhGMXhaM2lwMTd2blhXMzlRa1IwKzNLam5QR3RR?=
 =?utf-8?B?VUdCcTdyb0NNNXY5ZWVOaEdOOTlzNC9qMmVTdFBYZzgvWnNDYStqRzlRcjZq?=
 =?utf-8?B?UXZBS2tMU2QxbjczM2E4bU90N0Z6dURpU0pBUm5SczlRdzhNeWJLREpuTFEx?=
 =?utf-8?B?L0xrdVpLaUtJbWhSQWVUdmFCS1Y4Z0Z4OGVtMitVUUdLKzA1MkN1aUZDY21N?=
 =?utf-8?B?T25QK3RobTVEVmY2L0Q2aGRGNWc4ZG9ESmtaL1hOQ2g5TU5meUZsbGFibjVj?=
 =?utf-8?B?NTBvUHFQVkZRVlpZVi80dVhUT1lTK3RYV1N3Z3JZaVRmL3ZMMGM5dUZrNGxB?=
 =?utf-8?B?RTJLVzdqSWo5V2MrQWpaNnZDUHpTNGVJRm56cjhWZDNIMEVkTnFGcE80V05C?=
 =?utf-8?B?bnBOVzRsSitwekVxRVVNVTBKMk84UlBYcEFRZGwyTnZ2bDJCeWc2UDNkZlMr?=
 =?utf-8?B?WUc3ZjlFSlZydHV0QUd0QVpIbDdCUlVvMGxmbjMrR1QrWHJ4d1JqV2RLVmlW?=
 =?utf-8?B?N1pFbXBJL2JqR3VuTzdZUDJnOVNsbDF1SlR2SFNrM1hacEpSemlnQThvVG1t?=
 =?utf-8?B?TWw3MGpzaXFtQjVHcWNlYnd1ZWU3SWplODkybkR1WXNPb2pZbHd3dm1ZbFIy?=
 =?utf-8?B?dkR3SE9IUlRzYm5pM0NKYVlKWk5JQmlscDNwRjBjMXVhV0lyTU5EVmJqcWJ6?=
 =?utf-8?B?SjB4WklldjN0WUk2VWVON0hLNm1OWFdxMThYMXZpcEZBb1VFcUl1eDNMWEFQ?=
 =?utf-8?B?WEVxb3ZBOWpCbmt2WENvZno5WXc3QWFBbVNkV05DL1NINWJnY2RWSitwcUg0?=
 =?utf-8?B?OFE1MHE3SDdkZVNrM0huNHFrS2hFcHhXM21sdklUUm1DcVR5SzlmbGhQcS9J?=
 =?utf-8?B?OTdQTC9SekVSdjNpeFhyUDFUWEsyVEFjNGlVcWJzTFVnNjBEcVkxdXB3N0Qy?=
 =?utf-8?B?SkVtNlpONjExU2IyQ0l1UTNvUndwU0luUTVaVlY2ZXlrMmdUNEtRMjdNOUZO?=
 =?utf-8?B?bU0zSU4xK1A0SHVXbTQ4Mzc4M1VOY2pLdzVzRThQKyswZkZOYStBaDgzdUQ4?=
 =?utf-8?B?UFpXb29NZXFEOUp6aW5QOFFsa3F4eDI4b0dObE55bEtXQ3FmTVhqTDdoZEpj?=
 =?utf-8?B?ZnIveEV5TlFwMnZreXJCdm1PdkhaNE9JenR0VkZlRU9nSXY0SEVPNTdMWTdk?=
 =?utf-8?B?eitTQVFIRU43SWswcHJOQktPWEVPV0dCMFIvWGpaYklMZGZtNk4veER5eUd3?=
 =?utf-8?B?c2ZxcjZQOHd4Q0N5QnhTRjQ5K0U3MlQwcE45bStMdTVMZWhXaDdqS1JlMHB3?=
 =?utf-8?B?TkIvd1VsTm51a1AwMWk5QXpuUjJSWG13dGlZUDdlSGEzVzVjMkFyTy9CNVRU?=
 =?utf-8?B?S2dZNG52dmtURFB2bFFCSU12eUoyVER5bjZVQ2w5ZC9kS0hiMnkrc2c1bG44?=
 =?utf-8?B?MXJjaUt3SENTOCtCY3NPUUNkV3RJT2lEcHExNGpqamdHbU50aCt3ZGh6UlJY?=
 =?utf-8?B?N3RRQkVmYk9TRUdYUkdsNDcyNFNtdFlTb2NNN1lTMDgrVjYzdnoyRDdxZWpO?=
 =?utf-8?B?MnJKV2ZwTW5xSWVacDA1QnlyVXJSbWpFREJFcVU2R0FNY3JsdVFQSFJBcVFz?=
 =?utf-8?B?cTBPWWpKSXZsdWtSb0pDWGV1YW1RandnWkszVDJnM05qQnlIL2p1MWhoRkhV?=
 =?utf-8?B?bWJiMzR3TlEySWVPSTQxUzNES3lNYkxsUlVHRUdoQkRrMjlvT1N2OHh4Nmla?=
 =?utf-8?B?MHJlZ0tubDBoY1pLaXhLL1JPTEZzeGZFU09zcm1aTml1ZFdNUzNWQUxZTjFm?=
 =?utf-8?B?c2JzRW5mdUhWTEw5ZFkwQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJuUG9OT2VtUUpaNll5T0JiN2xBcHcwUFJGYUNVWTR2UmZtWWk5QkpocWhZ?=
 =?utf-8?B?TkVMdzRlb3ZUSDdqb01hMTRyaHNBSk1TWVc3Qm5XYjZDL0x5bUUrZTR0Z2xG?=
 =?utf-8?B?b2FNNWt4N0JWdDZhMXJGcDNOdWtSd3V3UVp2ZjEzbnhnMytENUkyeHJtV2p2?=
 =?utf-8?B?cms3Q2t1U0l2TmxIQ0pHZE9VYzFRVVg3c2JRcHl3SlR2RlpSWll0d2NtK0k2?=
 =?utf-8?B?dHg1SFZzUEZQQ3BSUUYxQmtsNFRsK1ArOFZxOGZtRjkxYWJXOVNlTU5YcEJF?=
 =?utf-8?B?cUowdUN2OHcrR0IwbEpVdm00bllJYUxaSDlvT005eFdWYzIrZDhIMCtDRDVz?=
 =?utf-8?B?RVlWVUc0Y2p6UGphQUpWZVBBTjNmcGg3M3NSRXUyTGRtbm9jL2dhOGVwd01W?=
 =?utf-8?B?Q1UvVkwrRXdHTFV2UHNpakhqOVM0UThveHo3YjQrdHVTNWpDWTNUWHp5Mktx?=
 =?utf-8?B?M3BFNjc1V1JzV3docHdkL2hadDQyUTlGZUo2Z3lnQjB3MmYrSkJpemdVOWFw?=
 =?utf-8?B?Mm1sL3lmRHdVNjVNWXFySTB6V0trcnlRaEVMZ0kwZ0tVV0Nacm1VTWZ2RUUz?=
 =?utf-8?B?SGZCZklHTVNKc2tFYnI3NVJkSmlQcGNiVFBCZlo4RTkrVFRxMFhIRE9MSUhz?=
 =?utf-8?B?dmhMOUJRNnVwZTJWUEFJUER0OTJQZVZydlRKblZtYy9ZQXNtYXMxM2QyTWZz?=
 =?utf-8?B?YUFneWlzemRvcVFqdnpvUlpZY2tkRE1SZ0ZxME1oTTA0eGx2dGEyN09WS3FJ?=
 =?utf-8?B?NEUxbUhEVURVbHJIeU5DOVUvTVNxTWwzS08wUlhxa1k0cy93dU04T3VyNFJZ?=
 =?utf-8?B?TndTYWt4YU1VT2F6QnZHYVdCcDQxanJ1dkp4Mzg1YjEvMGlkOERlU0dMa1hK?=
 =?utf-8?B?RjJUVGdlK1JCblNrQ2ZaWDhGQmZ3Q0ltV05Ob1pRREJ4WW9rUWJHL3dGWjdZ?=
 =?utf-8?B?OTByZDlQdmRDb0p5R05WdDJNVDRlSXM0eVRGcGZmNnFROUkwR0pUSlFZNkpL?=
 =?utf-8?B?UDQ0aUwzQ1NFdG93c3RwenQ0Vm9YaFRUUDdlY0N3NnpnSE1hSkdScnMrUHhh?=
 =?utf-8?B?cWMxR25pTkNibm1HVnRLdVRsL1prRkxmYWJrRFYvalE4MFFBVUdzUkdNYmF3?=
 =?utf-8?B?d0FFOEFBcjg5bU5kWlJVZFRzYndHNDhDZkF6S29xUnN0NEQ2WXF3Z0ZZd3U0?=
 =?utf-8?B?U1BsYTcrMUR5UlpyTUllSDE3bHNxTDJMTDJGb1RlK2ZndjNLUFFwY09maVVE?=
 =?utf-8?B?WXIrRWZyQ1QzaUxjcnExWUZ2LzJOOWtzSkR4b0tQblNNTTVtenFCMjhndDlT?=
 =?utf-8?B?VHg5amxMMFd2Y3hQTkFnM2lCOWo4ZDhnancyNzJiQ1BnUUNaeVMyM21WOG00?=
 =?utf-8?B?QUtvdmE0dDVENldFMGNyVytycTFVNnUvZFp1blN0MzMvejg2OGtienBxVEJW?=
 =?utf-8?B?cnpCN3dCSlFPQUhqNGkreHVvNDlTZm1wN24vSFdkcy9TelU2VGxiK2E4emJH?=
 =?utf-8?B?UDFvUFVJbkJxOHJoMHp3cDA0am5JUE1ielpneS8xZ3pxdXU4WW5oMEdZRGQ3?=
 =?utf-8?B?Q280dUNrS1g3WFh0QndZSW41d2lLM1RJVCt3c3pkcHV6aTdhVXpBQUZaYm9Q?=
 =?utf-8?B?Wk9mZjRLM2FhVEVoOUtaMXdWVWlXUkhnV0pLVWhjaXMyR1NlcW9JSkFLUXdr?=
 =?utf-8?B?aSthQ2tNQitsbmRJMkRMVUJSVEZLdWRVN01XMlUzTDBQSDFjRXp2Y2s1QldL?=
 =?utf-8?B?WlFrNmZwZDQ1S1Z1d2dxcE9yU2NIY1A2MFZtRGh5SklXZ0MzWHdkTUJSSFNU?=
 =?utf-8?B?cmk0U1FOVnpRVXpGQ0ZXYUNlRWV1bWJGMWJESTZ6MzN3TUJHMEkvdmJsUEVl?=
 =?utf-8?B?RUNuK1A5V1NiSi8rMEM0eTBjUGRoNWhLOVNIMFgwT1BBQTdpK0VGVktOanNk?=
 =?utf-8?B?RXpoL1h5WHNTS1VzK01PeWdEQlB2c1U5SjR4ZERpWU5nb0NlUlZIOUIzOGpx?=
 =?utf-8?B?N2J1TS9CUzUzVTNvVmtZSGpJbkw1UVkzRWwvSnhrcWxDb0xVNFU5VkR1eVVO?=
 =?utf-8?B?STJqQktPWUlzQjByWWRwaGp1NTc4ZWtPL2krQTVYK0RwbmVrTDdpQ25TeUFn?=
 =?utf-8?B?MEt5VE5VbzdPd3JnUGdkODVoZDZ5ZEd3WlQzNVpxelBQRk9vSEpLM2xBaVZS?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15778193567DC8469B1143970958E81F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32572b24-6455-4234-8db6-08dc638b8456
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 11:50:05.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyUTKPPvAZiOfvOJB4l5e5XQwpF1xpLaobIzrWGihv0P/HgNdhcMJBA+T9T2+dlT8wUDRnJIEG3sev6/SMXwVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDE3OjI1ICswODAwLCDmnLHkvK/lkJso5p2w6ZOtKSB3cm90
ZToNCj4gRURNTSdzIGlvY3RsKClzIHN1cHBvcnQgYmF0Y2ggb3BlcmF0aW9ucywgd2hpY2ggbWF5
IGJlDQo+IHRpbWUtY29uc3VtaW5nLiBUcnkgdG8gZXhwbGljaXRseSBnaXZlIHVwIHRoZSBDUFUg
YXQNCj4gdGhlIGV2ZXJ5IGVuZCBvZiAiZm9yIGxvb3AiIGluDQo+IHNneF9lbmNsYXZlX3sgbW9k
aWZ5X3R5cGVzIHwgcmVzdHJpY3RfcGVybWlzc2lvbnMgfCByZW1vdmVfcGFnZXN9DQo+IHRvIGdp
dmUgb3RoZXIgdGFza3MgYSBjaGFuY2UgdG8gcnVuLCBhbmQgYXZvaWQgc29mdGxvY2t1cCB3YXJu
aW5nLg0KPiANCj4gVGhlIGZvbGxvd2luZyBoYXMgYmVlbiBvYnNlcnZlZCBvbiBMaW51eCB2Ni45
LXJjNSB3aXRoIGtlcm5lbA0KPiBwcmVlbXB0aW9ucyBkaXNhYmxlZChieSBjb25maWd1cmluZyAi
UFJFRU1QVF9OT05FPXkiKSwgd2hlbiBrZXJuZWwNCj4gaXMgcmVxdWVzdGVkIHRvIHJlc3RyaWN0
IHBhZ2UgcGVybWlzc2lvbnMgb2YgYSBsYXJnZSBudW1iZXIgb2YgRVBDIHBhZ2VzLg0KPiANCj4g
ICAgIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiAgICAgd2F0Y2hkb2c6
IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjNDUgc3R1Y2sgZm9yIDIycyEgW29jY2x1bS1ydW46Mzkw
NV0NCj4gICAgIC4uLg0KPiAgICAgQ1BVOiA0NSBQSUQ6IDM5MDUgQ29tbTogb2NjbHVtLXJ1biBO
b3QgdGFpbnRlZCA2LjkuMC1yYzUgIzcNCj4gICAgIC4uLg0KPiAgICAgUklQOiAwMDEwOnNneF9l
bmNsYXZlX3Jlc3RyaWN0X3Blcm1pc3Npb25zKzB4YmEvMHgxZjANCj4gICAgIENvZGU6IDQ4IGMx
IGU2IDA1IDQ4IDg5IGQxIDQ4IDhkIDVjIDI0IDQwIGI4IDBlIDAwIDAwIDAwIDQ4IDJiIDhlIDcw
IDhlIGY1IDkzIDQ4IGMxIGU5IDA1IDQ4IGMxIGUxIDBjIDQ4IDAzIDhlIDY4IDhlIGY1IDkzIDBm
IDAxIGNmIDxhOT4gMDAgMDAgMDAgNDAgMGYgODUgYjIgMDAgMDAgMDAgODUgYzAgMGYgODUgZGIg
MDAgMDAgMDAgNGMgODkgZWYNCj4gICAgIFJTUDogMDAxODpmZmZmYjU1YTY1OTFmYTgwIEVGTEFH
UzogMDAwMDAyMDINCj4gICAgIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmZiNTVhNjU5
MWZhYzAgUkNYOiBmZmZmYjU4MWU3Mzg0MDAwDQo+ICAgICBSRFg6IGZmZmZiNTlhOWU0ZTgwODAg
UlNJOiAwMDAwMDAwMDAwMDAwMDIwIFJESTogZmZmZjkxZDY5ZThjYzAwMA0KPiAgICAgUkJQOiBm
ZmZmYjU1YTY1OTFmYjcwIFIwODogMDAwMDAwMDAwMDAwMDAwMiBSMDk6IGZmZmY5MWQ2NDZlMTJi
ZTANCj4gICAgIFIxMDogMDAwMDAwMDAwMDAwMDA2ZSBSMTE6IDAwMDAwMDAwMDAwMDAwMDIgUjEy
OiAwMDAwMDAwNzIwNTJkMDAwDQo+ICAgICBSMTM6IGZmZmY5MWQ2OWU4Y2MwMDAgUjE0OiBmZmZm
YjU1YTY1OTFmYmQ4IFIxNTogZmZmZjkxZDY5ZThjYzAyMA0KPiAgICAgRlM6ICAwMDAwN2ZlMTBk
YmRhNzQwKDAwMDApIEdTOmZmZmY5MjE2M2U0ODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAw
MDAwMA0KPiAgICAgQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMw0KPiAgICAgQ1IyOiAwMDAwN2ZjMDQxODExMDAwIENSMzogMDAwMDAwNDBkOTVjODAwNSBD
UjQ6IDAwMDAwMDAwMDA3NzBlZjANCj4gICAgIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAw
MDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+ICAgICBEUjM6IDAwMDAwMDAw
MDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwN2YwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiAg
ICAgUEtSVTogNTU1NTU1NTQNCj4gICAgIENhbGwgVHJhY2U6DQo+ICAgICAgPElSUT4NCj4gICAg
ICA/IHNob3dfcmVncysweDY3LzB4NzANCj4gICAgICA/IHdhdGNoZG9nX3RpbWVyX2ZuKzB4MWYz
LzB4MjgwDQo+ICAgICAgPyBfX3BmeF93YXRjaGRvZ190aW1lcl9mbisweDEwLzB4MTANCj4gICAg
ICA/IF9faHJ0aW1lcl9ydW5fcXVldWVzKzB4YzgvMHgyMjANCj4gICAgICA/IGhydGltZXJfaW50
ZXJydXB0KzB4MTBjLzB4MjUwDQo+ICAgICAgPyBfX3N5c3ZlY19hcGljX3RpbWVyX2ludGVycnVw
dCsweDUzLzB4MTMwDQo+ICAgICAgPyBzeXN2ZWNfYXBpY190aW1lcl9pbnRlcnJ1cHQrMHg3Yi8w
eDkwDQo+ICAgICAgPC9JUlE+DQo+ICAgICAgPFRBU0s+DQo+ICAgICAgPyBhc21fc3lzdmVjX2Fw
aWNfdGltZXJfaW50ZXJydXB0KzB4MWIvMHgyMA0KPiAgICAgID8gc2d4X2VuY2xhdmVfcmVzdHJp
Y3RfcGVybWlzc2lvbnMrMHhiYS8weDFmMA0KPiAgICAgID8gX19wdGVfb2Zmc2V0X21hcF9sb2Nr
KzB4OTQvMHgxMTANCj4gICAgICA/IHNneF9lbmNsX3Rlc3RfYW5kX2NsZWFyX3lvdW5nX2NiKzB4
NDAvMHg2MA0KPiAgICAgIHNneF9pb2N0bCsweDFhYi8weDkwMA0KPiAgICAgID8gZG9fc3lzY2Fs
bF82NCsweDc5LzB4MTEwDQo+ICAgICAgPyBhcHBseV90b19wYWdlX3JhbmdlKzB4MTQvMHgyMA0K
PiAgICAgID8gc2d4X2VuY2xfdGVzdF9hbmRfY2xlYXJfeW91bmcrMHg2Yy8weDgwDQo+ICAgICAg
PyBzZ3hfdm1hX2ZhdWx0KzB4MTMyLzB4NGYwDQo+ICAgICAgX194NjRfc3lzX2lvY3RsKzB4OTUv
MHhkMA0KPiAgICAgIHg2NF9zeXNfY2FsbCsweDEyMDkvMHgyMGMwDQo+ICAgICAgZG9fc3lzY2Fs
bF82NCsweDZkLzB4MTEwDQo+ICAgICAgPyBkb19zeXNjYWxsXzY0KzB4NzkvMHgxMTANCj4gICAg
ICA/IGRvX3B0ZV9taXNzaW5nKzB4MmU4LzB4Y2MwDQo+ICAgICAgPyBfX3B0ZV9vZmZzZXRfbWFw
KzB4MWMvMHgxOTANCj4gICAgICA/IF9faGFuZGxlX21tX2ZhdWx0KzB4N2I5LzB4ZTYwDQo+ICAg
ICAgPyBfX2NvdW50X21lbWNnX2V2ZW50cysweDcwLzB4MTAwDQo+ICAgICAgPyBoYW5kbGVfbW1f
ZmF1bHQrMHgyNTYvMHgzNjANCj4gICAgICA/IGRvX3VzZXJfYWRkcl9mYXVsdCsweDNjMS8weDg2
MA0KPiAgICAgID8gaXJxZW50cnlfZXhpdF90b191c2VyX21vZGUrMHg2Ny8weDE5MA0KPiAgICAg
ID8gaXJxZW50cnlfZXhpdCsweDNiLzB4NTANCj4gICAgICA/IGV4Y19wYWdlX2ZhdWx0KzB4ODkv
MHgxODANCj4gICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQo+
ICAgICBSSVA6IDAwMzM6MHg3ZmUxMGUyZWU1Y2INCj4gICAgIENvZGU6IDBmIDFlIGZhIDQ4IDhi
IDA1IGM1IDc4IDBkIDAwIDY0IGM3IDAwIDI2IDAwIDAwIDAwIDQ4IGM3IGMwIGZmIGZmIGZmIGZm
IGMzIDY2IDBmIDFmIDQ0IDAwIDAwIGYzIDBmIDFlIGZhIGI4IDEwIDAwIDAwIDAwIDBmIDA1IDw0
OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggOGIgMGQgOTUgNzggMGQgMDAgZjcgZDggNjQg
ODkgMDEgNDgNCj4gICAgIFJTUDogMDAyYjowMDAwN2ZmZmIyYzc1NTE4IEVGTEFHUzogMDAwMDAy
NDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMTANCj4gICAgIFJBWDogZmZmZmZmZmZmZmZmZmZk
YSBSQlg6IDAwMDAwMDA3ODAwMDAwMDAgUkNYOiAwMDAwN2ZlMTBlMmVlNWNiDQo+ICAgICBSRFg6
IDAwMDA3ZmZmYjJjNzU1MjAgUlNJOiAwMDAwMDAwMGMwMjhhNDA1IFJESTogMDAwMDAwMDAwMDAw
MDAwNQ0KPiAgICAgUkJQOiAwMDAwMDAwMDAwMDAwMDA1IFIwODogMDAwMDAwMDAwMDAwMDAwMCBS
MDk6IDAwMDA3ZmZmYjJjNzU1OTQNCj4gICAgIFIxMDogMDAwMDdmZmZiMmM3NTVjOCBSMTE6IDAw
MDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMGMwMjhhNDA1DQo+ICAgICBSMTM6IDAwMDA3ZmZm
YjJjNzU1MjAgUjE0OiAwMDAwMDAwNzgwMDAwMDAwIFIxNTogMDAwMDdmZTEwZTFhNzk4MA0KPiAg
ICAgIDwvVEFTSz4NCj4gICAgICAtLS0tLS0tLS0tLS1bIGVuZCB0cmFjZSBdLS0tLS0tLS0tLS0t
DQoNCkNvdWxkIHlvdSB0cmltIGRvd24gdGhlIHRyYWNlIHRvIG9ubHkgaW5jbHVkZSB0aGUgcmVs
ZXZhbnQgcGFydD8NCg0KRS5nLiwgcGxlYXNlIGF0IGxlYXN0IHJlbW92ZSB0aGUgdHdvIHJlZ2lz
dGVyIGR1bXBzIGF0IHRoZSBiZWdpbm5pbmcgYW5kDQplbmQgb2YgdGhlIHRyYWNlLg0KDQpQbGVh
c2UgcmVmZXIgdG8gIkJhY2t0cmFjZXMgaW4gY29tbWl0IG1lc3NhZ2VzIiBzZWN0aW9uIGluDQpE
b2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdC4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQm9qdW4gWmh1IDx6aHVib2p1bi56YmpAYW50Z3JvdXAuY29tPg0KPiAtLS0N
Cj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2lvY3RsLmMgfCA5ICsrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvc2d4L2lvY3RsLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9pb2N0bC5j
DQo+IGluZGV4IGI2NWFiMjE0YmRmNS4uMjM0MGE4MmZhNzk2IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni9rZXJuZWwvY3B1L3NneC9pb2N0bC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUv
c2d4L2lvY3RsLmMNCj4gQEAgLTgwNiw2ICs4MDYsOSBAQCBzZ3hfZW5jbGF2ZV9yZXN0cmljdF9w
ZXJtaXNzaW9ucyhzdHJ1Y3Qgc2d4X2VuY2wgKmVuY2wsDQo+ICAJCX0NCj4gIA0KPiAgCQltdXRl
eF91bmxvY2soJmVuY2wtPmxvY2spOw0KPiArDQo+ICsJCWlmIChuZWVkX3Jlc2NoZWQoKSkNCj4g
KwkJCWNvbmRfcmVzY2hlZCgpOw0KPiAgCX0NCj4gIA0KPiAgCXJldCA9IDA7DQo+IEBAIC0xMDEw
LDYgKzEwMTMsOSBAQCBzdGF0aWMgbG9uZyBzZ3hfZW5jbGF2ZV9tb2RpZnlfdHlwZXMoc3RydWN0
IHNneF9lbmNsICplbmNsLA0KPiAgCQllbnRyeS0+dHlwZSA9IHBhZ2VfdHlwZTsNCj4gIA0KPiAg
CQltdXRleF91bmxvY2soJmVuY2wtPmxvY2spOw0KPiArDQo+ICsJCWlmIChuZWVkX3Jlc2NoZWQo
KSkNCj4gKwkJCWNvbmRfcmVzY2hlZCgpOw0KPiAgCX0NCj4gIA0KPiAgCXJldCA9IDA7DQo+IEBA
IC0xMTU2LDYgKzExNjIsOSBAQCBzdGF0aWMgbG9uZyBzZ3hfZW5jbF9yZW1vdmVfcGFnZXMoc3Ry
dWN0IHNneF9lbmNsICplbmNsLA0KPiAgCQlrZnJlZShlbnRyeSk7DQo+ICANCj4gIAkJbXV0ZXhf
dW5sb2NrKCZlbmNsLT5sb2NrKTsNCj4gKw0KPiArCQlpZiAobmVlZF9yZXNjaGVkKCkpDQo+ICsJ
CQljb25kX3Jlc2NoZWQoKTsNCj4gIAl9DQo+IA0KDQpZb3UgY2FuIHJlbW92ZSB0aGUgbmVlZF9y
ZXNoY2VkKCkgaW4gYWxsIDMgcGxhY2VzIGFib3ZlIGJ1dCBqdXN0IGNhbGwNCmNvbmRfcmVzY2hl
ZCgpIGRpcmVjdGx5Lg0KDQo=

