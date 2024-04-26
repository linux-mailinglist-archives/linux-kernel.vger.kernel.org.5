Return-Path: <linux-kernel+bounces-160056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8538B387D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8655F1C23893
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D7147C7D;
	Fri, 26 Apr 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XFgawSYo";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C5o+BKof"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8D13E88A;
	Fri, 26 Apr 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138373; cv=fail; b=NYWECt3KkJ3F4rT4pHzcPnUmNy2cIMzCtM44bvU13WwlwCC2fJbuuMoOx7t3kerWQbAN3jRGmUEHwjmZtotOJSeDix9qpHbUmRw8omj5CsSpmgLx4eTiV9oT2e6TxXAemRLSqphowQ7/edvHJavm88dehU8fMPd3E44bVzDeoZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138373; c=relaxed/simple;
	bh=ZFI8HfCEjnhZTXMl58S1eRFt59mSP58uoWk1bAUl3H0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5yFeUeNCliKtSnZ2CnD/b4YqNxgdHev+2MSToHgGf6qx1MI/XVo5uwOKAZ8+i+qTRjj9lYLeET/H4penKyxcPffKCSMLlvIuCCaHneR1xz7ECnFIzGLM0ftsLj11JgBTZS0UVL/SPfKHKzY0Vihzu2b8aqr/FtYlCY1JTeDSKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XFgawSYo; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C5o+BKof; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714138371; x=1745674371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZFI8HfCEjnhZTXMl58S1eRFt59mSP58uoWk1bAUl3H0=;
  b=XFgawSYoy/7vY50aEWdqEqgOmMF/Bw80B88GmYFxIePBTeAiAFb2QtSP
   rUJquyvTUgpZ/5XzmkMIH+d2TyGmUcMYJ54fPu7zM28WhiUiiuEowvNkJ
   CQNHKOZVp62mr0gpQ+hkXn+rWc4mcuZOllstlYt9VI41xx+tDCER42tty
   eXWpMuPdUDD8qsJ58n28d4cpamnsOe8MHAIWBkJthDSoUvLNt9Bh3l5eb
   Edv8dpk6xjWDEruafpdYVyEqZ8+HqCSdTC6XlkPobi/lNgNxE2sDoKElq
   PcnzGfCJLOwwjn79loWXfZ9QOQOBbikuxe1ZRSumOOYSEXdeDF526sCmC
   g==;
X-CSE-ConnectionGUID: 0sIOBVQ9SFm8q3ndJBibsg==
X-CSE-MsgGUID: yMogvDTMSR6HjiU1Mv0obw==
X-IronPort-AV: E=Sophos;i="6.07,232,1708412400"; 
   d="scan'208";a="22770641"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2024 06:32:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 06:32:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 06:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYLPRBL1IFu6Lh6A/wcRCO5x0c3Cl91O3Rk6UthJ46a7VU+jSVifbNzK7HtLICmfNB5R3KrG0bfH8fuO4vDieztZUiKWdFedufEeeBljgapogS3SciunoIB9ozfvUkQqqy2GI7oVlqUO40J96zywLIE7XcGyNHW8enVfkdOU6F+9+zPxdn6PpREn/RMyYv/F8gScqhezkHBAQpQh3vM2qhPkX39kO5D6JJ5FeN/NMebtlKH1oWRsd04KakG4L8sGgu2FHpF7IfHDEd6TZXzyT+5WlbgVdcK5IBRoADMXrqjEyYteric4o4woS6i/3eh+70Z951KYkAAGQYCsO3Vcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFI8HfCEjnhZTXMl58S1eRFt59mSP58uoWk1bAUl3H0=;
 b=KelWK9rbQBFF4myYPtgKYnqazGxAj/tYRiyNvK8KddF945lIFN5cRsWivEc76QEr62g+tSITVOIFIZUXxV1Yv/qFvPJLor6AwvXMKVCHroW+eSDLnMI4ImPU2L29mbER2IpvjoPE8QnPoM4JhaAwIONur8tqOtDKdXeDbS6P/OSEVWAcdiC5baet2G2llsTQXGMOnYF1e7HlJgjhSKdjJYK22Pe9v7yfre9hjVuffZeFqj5NyDGxL94D045dloAhuSp9kbipIQzDtEh9RBGxeLzZSWekmZ6I83Z0LmI2Ak6GPLz3tuUYSju1Wqs43izBk37pfC1eZG8A52QYRoWyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFI8HfCEjnhZTXMl58S1eRFt59mSP58uoWk1bAUl3H0=;
 b=C5o+BKof+LrAymNNNh93SXGUnRYvzr+WbKwtTHT8R22ZEHWznC+eqmuTomYPWAwo+ujvU/tOWE7gbp3229TUeYQqlml5weFimfliBfTnEOLl7Uhe7qXvoac8c2NSjbDYqV7OG2CG/LUqiu87EdQgalg71n9CZSgkfE0LqZFVYm49yz9kt7oOen/1k+M5iQo9mhDc+68t+AGK4+H3nVq/LEwMKL9Vf+q3LUjq8oj4U8Jd7DjxroPdvUusLiMGCvRrZGsQ6wZOezCQwT4XLqL8o4n7sI1wK8VO0y3oPcZpHddWxYIBvpXmS7IIMhz3557OH68iHlo4DklzTkHXClbemw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 13:32:22 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 13:32:22 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Topic: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Index: AQHakZAq1RqgTRBTy0mY7YMhKP6dQLF2mT0AgAQAEAA=
Date: Fri, 26 Apr 2024 13:32:22 +0000
Message-ID: <9909d4c4-b3b9-4c4e-9923-64945b6c7bb3@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <231ce196-6a68-4f09-8f9a-976c5ce1495d@lunn.ch>
In-Reply-To: <231ce196-6a68-4f09-8f9a-976c5ce1495d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ1PR11MB6083:EE_
x-ms-office365-filtering-correlation-id: 7d742273-5ede-430e-4da4-08dc65f54db2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QktnTEQ3UHFETWJsTFlJZGhhKzhIY0Jpd0FVYlR2bGF3Z2c3clFHcjVmSS9t?=
 =?utf-8?B?N3RtZlVTcFJNSmVnTlRTY0tYK3JORVlUdVJrTnRWUm9RWWM1ZndyRWlCc2I0?=
 =?utf-8?B?UWxiTFRQeGNYWDFpQjFuUVBWMUdmMzVOcVdEL2NXT2RTMTlsUHRMSE5uK3hY?=
 =?utf-8?B?WE0xSVNGZHErekR4dStWdEUyamx5QjZ3enNUd2dibkFmZ1l6MnZaZWpObjdM?=
 =?utf-8?B?K09Ud0hMMWpubnRmcjBabnloZFNCNkpvVFgvRTVTL2tPem5KTG1admFxdWtN?=
 =?utf-8?B?aGNWVmV2ZEpDaHJsNlFtangzWWlBMDdETTR6a3pyaE8rM05SWXNQYzJTUVp6?=
 =?utf-8?B?bVcvUW4vUWErTVJ3c202bWxtci9PSVc2cHZHN1pIUlpDWUU1ZDZQbDBFbFNY?=
 =?utf-8?B?aGdNUHg1YWc2dzdCTmlvUGlyUFUxV2VTUkp1Y3pidHhNK3lyZWlNYnZ2b3V0?=
 =?utf-8?B?ZHg5Z0JOcGVJZ0R3MktTaWNjS0hMempva1FUQUVQcHRWbndKdjQrNTJNNGZj?=
 =?utf-8?B?aGpueldmWnJNM0h5TEQwQ0lobmNCUktkdmtPR1hsVWp3SERBbUpUK0RudUFZ?=
 =?utf-8?B?Ymc1eVJYcjV1R01oYUxKa24vZnBZWnhIejJ3dlBKNEZVWVJVS2o1ZUd3NTBt?=
 =?utf-8?B?ZjIwaHRqQjk1dnhpckdTNnF4a014bUNGencremdaRWdzMzlsQlNXRlY3R2h5?=
 =?utf-8?B?eHB6QXQ4KzUzTnVxZzU0cC9uTGRzdW50ZW1iTE9ZV3FtL3VLZVYzdVNFMVF0?=
 =?utf-8?B?U3VldjJjQVpSczZuMVhUS1k2L1poMUVyWUt0a2lEUTBjUmFmN2NCWFoyOXZy?=
 =?utf-8?B?cFE1L3F4SXNNUklpeTVWZmZvN1FHYnhEcWJsQXM0Vm56NXBoR1pPa09qWkVM?=
 =?utf-8?B?aGFObXI1VjZ6bzY2dHRQMHUwL0Fqak1iZUhlaXJ4N0IxcjlXdE9qbjVqa0tq?=
 =?utf-8?B?bDgvV29weXpVRkJFODIvaEY1TDFvUWFlMjFaZ0xCWlZGMEZPdml2cGhpN0FP?=
 =?utf-8?B?WkRWeTc3OEg3UElnamUwY1NBTzFhd3hDWlZVejNnZ1FETUoyOW1EL2UxMW0z?=
 =?utf-8?B?RWpTY2wzRU93dUFsRGo3R2R2aUFiNUpHMEZ3cXFSUlhGZkRWQTBqV1o0ZEF6?=
 =?utf-8?B?a2pGS3lWSWNvNHk5TTlXZ1B2UXNqdDdVOCs0YmNyWjNrM0NwYkFzSVBhRTd6?=
 =?utf-8?B?Qi96SmFMbjB4elZjYU4vNUlhS2ozbVdRYkEvS0pQU0VIMHBsMUhvWFl2Rmlj?=
 =?utf-8?B?ZXU0cjNYU3dEVFV3Y2VqSU1La1h2K1lZWVJMM0N4aEpzQW9iM0c4UHpTUEZi?=
 =?utf-8?B?UkJsQ28zQVhiNnZjd0k4UEFsUGV0dFR2YmFZYjZmeUJQOXkxM0F0YnV0VEdM?=
 =?utf-8?B?L1FKaXMxUEVELzJaTmZWaGtzRXF4NytJUHgrVTJXVzk2NTRpQkVJa0hWejBM?=
 =?utf-8?B?dXVyNE1LNTZjKzArd2RvNG1LSkhaZFRBQmpxS1JUc1A1TFRTeFl4N0k5UlY5?=
 =?utf-8?B?WTZCSTdKWThsZjZPYzJaSDl4ekQ5THI5SWlmZGxYMDNlRWhOWXAvL0wxSkdj?=
 =?utf-8?B?TzlCQSs3b21HZ3dXTTdvcWFuY3BzbU95NG1oUUkvOGFKYWxYTDVRNVBVNmpm?=
 =?utf-8?B?d0FPWFhPTEZQblRmVHBLV3o5dDRxcWN3TnFGWEZFSU03VlJ1S1VxVWVSZjg5?=
 =?utf-8?B?ckxUcmRMLzlFWHQ4a0tDYjRRZ2FPOFVYMWh2ZEdLM1dMOUJEVGZCWmVjQlhm?=
 =?utf-8?B?TGdUQ0hPblZDUWR1NW5nWWFyeEhJckR3QWlNTThnUzNWQmJRRDRHVlNOOWhp?=
 =?utf-8?B?dEZwL3gwVllBNldZQTFZZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXIwR2tnKzFTaDVqUThFdE5KcFdJVmtYRmRlWlpDMTRUU2RLK2RiV2RGRExC?=
 =?utf-8?B?bFNkb2ZjemNrdG9yMDVsdUJram9qTmVMbjdGRlVOMXhkVkgwY3pmYVY1ZGJw?=
 =?utf-8?B?VE5nTUdWZWZsVTR5S3l5LzZVV09GVlNtWitpYUhtd0xWRy9QWGtvanBVVktp?=
 =?utf-8?B?aWJBMmZUSnJhMHRuRW5XZFhZaWlVMkI4NXZOekFxUnVhcW96WkJlbjREaXJo?=
 =?utf-8?B?K05iR0NKb3V3c01lU214Yys0cDVCb2pmbmFFcHk3dWdwejhCUEJlV1k5Vllu?=
 =?utf-8?B?cFdrNTQxRCtMbU4wRFNDNmh4NFRvSW1pNDRJU282TmlOcGZPbXZ5MmZLUTZ5?=
 =?utf-8?B?Ym9mUXRsdHZMM2E2OXJyWExzMUVyM0Y3WWt1NVl4V05NOXlVc0c0dDlkS1ky?=
 =?utf-8?B?TFFKUXJSM3YzS3N3YTZrWTJNNUhTNjdOOEtDUDU4WnJGUUF0citwb29WbU1K?=
 =?utf-8?B?em15ZEZHdlM2U3l3NU5hSEZrN2ZaeWFuazVJU245c0c4LzNoUzFsTHIyZGRR?=
 =?utf-8?B?MloyUldkM2RTSVNma3NOZm9hZUxBWFdkR0JhQUVESDlpWGQxb3RvU1Q0ZmpH?=
 =?utf-8?B?QlA3N3p2MXBoYXpxdWtHMjFjcXY4SVI3dkRNTjVHc3J3VnlNK1k2U2ZVTVA2?=
 =?utf-8?B?RmdFSktVbThOWnZBNzY5Z1ZDbkVwQUNPKzRzc0JMMW1RVzk0eUtnZXNleFNv?=
 =?utf-8?B?OXhpdytJcmh6cS9SR08rSUp1WFJDaHIzbVQ4T09GMi8zdUxTakp4emdseXMw?=
 =?utf-8?B?Tnh6ZkJnUDdwQ0V2Wjg4VjczSDA3b3dsNVg0M1lTaHU2cnVrNE9MMjZvblVk?=
 =?utf-8?B?dE5ySW5Kbkhkdnoxa0Q0dUF3ZFltbDFtQ3NnREVRaGtEYjlzdVVvOTlZS1VL?=
 =?utf-8?B?VzFMTURoWkVkTUNpKzl2ZzQrTUptdzhSTGlQUGg2N3E4N1NkeHFoUnpNaTJF?=
 =?utf-8?B?T1RMMEFMKzZVQ2JlRW1DOGxFWVNHMU9QQ1dVWk1PVnpuczBQNlVxM0E5WjFN?=
 =?utf-8?B?cGN1V2J0YnNRRWl1KzYrN0g3a1BsVTM2RDFaaFJTOFZGQ3dNaDlZUzNUZUs0?=
 =?utf-8?B?b0g5NkE1ZEQ2SkJBR1M3WnVzdjZ6eWdqTHpvRkZrckJhQXA0RmFyc1JvVlRK?=
 =?utf-8?B?NDZoSEFBdEdSdDJFK3ppSGJoOWYxR1lpWHByZXlyREFiQitNNlVHVTdQTFd1?=
 =?utf-8?B?bUZUWUhsMmJDcEt6YWROZXlOL080NUN6aXlUcGVNaVRGQXhWWWV5Tyt4S3A0?=
 =?utf-8?B?RDF3MUhjZkFkSHE0dEhzN2VzSlZRUit4bjZabzd4RDl4S3pNVkRta09KWS9Q?=
 =?utf-8?B?Y1JkT0RYb3dzaW9vOG9CY21Ha1d6c0w4d2VKSXRyR1g5dk9WOXdPWVdHZVc4?=
 =?utf-8?B?bGlNSHkxM20zNktvWTA2bHo3bkxvSmFDQi80cTBBTnl6NkwzNHQwNG9MMjlY?=
 =?utf-8?B?dkhxSkNYaFhQRFlRMU9OSFlVOE9IYXQ4RlZoUVFXa1NTdFhzS0hhNEpRTkRD?=
 =?utf-8?B?a0hOQUp1aDdkc2tlQTdOcVJlTHVIVHJiUnNNc1BGc2kvVzhFdUVvSSs5anFV?=
 =?utf-8?B?UU5rQUV0RVlNNXluendrMWp0Mm5OT0pJQ20waE1NQ3p5QmFCeFNHN0lKRm5U?=
 =?utf-8?B?aklZNW1xN2RLUEo1NjExSnlkc1RoU1dKbTRpZy9VNU5HTWsvVGZHR1piQkV5?=
 =?utf-8?B?T2MyOU5Temk5ZVA0NG5oWDVUd3ZhSFZ6WXZ4SG5acGZHdm9ZNm1BWmV0eTAz?=
 =?utf-8?B?R2VpaHFKVlFaM0xuZWFmS3BrOGlpVHpOczg2T2Vic1FjQ3RnVU5lWjRYUFlY?=
 =?utf-8?B?Q2Z5ODBPQWUzVCtaYnlacDBjN0htWGZjczVNNWgwWkZmRElBeEk1RGZUMi9O?=
 =?utf-8?B?RVJ1eTNZdFN3dk9kQ1VJZCswWWRaVENrZFR2Q3JSUW1HemFtZlBySE4wNGIv?=
 =?utf-8?B?WW5mU0psdUVaS2dyOWp4bVNHZXVsajlxSndndGdzMlFIY21qcm5INTFCcWsz?=
 =?utf-8?B?VHBCNGU1dkpnWDk1ZnFyWGRIejBiRG4zNE9manAwbFhHTkxZOW9XL2ZITGYr?=
 =?utf-8?B?dm4wY05veDFZZWdvcDNjWm5xVldrYUFSTERtcXdncTd3NUNjelpycTRVcTZl?=
 =?utf-8?B?a0lTcjIxU1lWZ244cEhxVW5CNWpPUHkvUnkwdEU0ZjVwZE9LbnJ2bkswcXpy?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AD18BBF0D712E4D91B4D6D4EEA26DE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d742273-5ede-430e-4da4-08dc65f54db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 13:32:22.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbSjB/+BU5A0Rn0aoyJgf5QU3kGPMz4Te+Mr52540dRa3ugSaFGpLKNEJq9OYBDOygOUGtn4HJIC6shQ4Hp/nCNrD0OAXdconLyU2obtsybnXDivegX/e2Ug+5RvZ547
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083

SGkgQW5kcmV3LA0KDQpPbiAyNC8wNC8yNCA1OjU3IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKy8qIE9QRU4gQWxsaWFu
Y2UgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAjMCAqLw0KPj4gKyNkZWZpbmUgT0FfVEM2X1JFR19D
T05GSUcwICAgICAgICAgICAweDAwMDQNCj4+ICsjZGVmaW5lIENPTkZJRzBfWkFSRkVfRU5BQkxF
ICAgICAgICAgQklUKDEyKQ0KPiANCj4gSWYgdGhpcyBpcyBhIHN0YW5kYXJkIHJlZ2lzdGVyLCB5
b3Ugc2hvdWxkIHB1dCB0aGVzZSBkZWZpbmVkIHdoZXJlDQo+IG90aGVyIGRyaXZlcnMgY2FuIHVz
ZSB0aGVtLg0KT0suIFdpbGwgbW92ZSBpdCB0byBvYV90YzYuYyBpbiB0aGUgbmV4dCB2ZXJzaW9u
IGFzIHlvdSBoYXZlIGFsc28gDQpzdWdnZXN0ZWQgdG8gdXNlIHRoaXMgYXMgYSBoZWxwZXIgZnVu
Y3Rpb24gaW4gdGhlIGJlbG93IGNvbW1lbnQuDQo+IA0KPj4gK3N0YXRpYyBpbnQgbGFuODY1eF9z
ZXRfbWFjX2FkZHJlc3Moc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwgdm9pZCAqYWRkcikNCj4+
ICt7DQo+PiArICAgICBzdHJ1Y3QgbGFuODY1eF9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYobmV0
ZGV2KTsNCj4+ICsgICAgIHN0cnVjdCBzb2NrYWRkciAqYWRkcmVzcyA9IGFkZHI7DQo+PiArICAg
ICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgcmV0ID0gZXRoX3ByZXBhcmVfbWFjX2FkZHJfY2hh
bmdlKG5ldGRldiwgYWRkcik7DQo+PiArICAgICBpZiAocmV0IDwgMCkNCj4+ICsgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgIGlmIChldGhlcl9hZGRyX2VxdWFsKGFkZHJl
c3MtPnNhX2RhdGEsIG5ldGRldi0+ZGV2X2FkZHIpKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4g
MDsNCj4+ICsNCj4+ICsgICAgIHJldCA9IGxhbjg2NXhfc2V0X2h3X21hY2FkZHIocHJpdiwgYWRk
cmVzcy0+c2FfZGF0YSk7DQo+PiArICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgZXRoX2h3X2FkZHJfc2V0KG5ldGRldiwgYWRkcmVzcy0+
c2FfZGF0YSk7DQo+IA0KPiBJdCBzZWVtcyBtb3JlIG5vcm1hbCB0byBjYWxsIGV0aF9jb21taXRf
bWFjX2FkZHJfY2hhbmdlKCksIHdoaWNoDQo+IGJldHRlciBwYWlycyB3aXRoIGV0aF9wcmVwYXJl
X21hY19hZGRyX2NoYW5nZSgpLg0KT0ssIHNvIEkgd2lsbCByZXBsYWNlIGV0aF9od19hZGRyX3Nl
dCgpIHdpdGggDQpldGhfcHJlcGFyZV9tYWNfYWRkcl9jaGFuZ2UoKSBpbiB0aGUgbmV4dCB2ZXJz
aW9uLg0KPiANCj4+ICtzdGF0aWMgaW50IGxhbjg2NXhfc2V0X3phcmZlKHN0cnVjdCBsYW44NjV4
X3ByaXYgKnByaXYpDQo+PiArew0KPj4gKyAgICAgdTMyIHJlZ3ZhbDsNCj4+ICsgICAgIGludCBy
ZXQ7DQo+PiArDQo+PiArICAgICByZXQgPSBvYV90YzZfcmVhZF9yZWdpc3Rlcihwcml2LT50YzYs
IE9BX1RDNl9SRUdfQ09ORklHMCwgJnJlZ3ZhbCk7DQo+PiArICAgICBpZiAocmV0KQ0KPj4gKyAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgLyogU2V0IFplcm8tQWxpZ24g
UmVjZWl2ZSBGcmFtZSBFbmFibGUgKi8NCj4+ICsgICAgIHJlZ3ZhbCB8PSBDT05GSUcwX1pBUkZF
X0VOQUJMRTsNCj4+ICsNCj4+ICsgICAgIHJldHVybiBvYV90YzZfd3JpdGVfcmVnaXN0ZXIocHJp
di0+dGM2LCBPQV9UQzZfUkVHX0NPTkZJRzAsIHJlZ3ZhbCk7DQo+PiArfQ0KPiANCj4gVGhlcmUg
ZG9lcyBub3QgYXBwZWFyIHRvIGJlIGFueXRoaW5nIHNwZWNpZmljIHRvIHlvdXIgZGV2aWNlIGhl
cmUuIFNvDQo+IHBsZWFzZSBtYWtlIHRoaXMgYSBoZWxwZXIgaW4gdGhlIHNoYXJlZCBjb2RlLCBz
byBhbnkgZHJpdmVyIGNhbiB1c2UNCj4gaXQuDQpPSywgSSB3aWxsIGltcGxlbWVudCB0aGlzIGhl
bHBlciBmdW5jdGlvbiBhcyBvYV90YzZfZW5hYmxlX3phcmZlKCkgaW4gDQp0aGUgb2FfdGM2LmMu
IEFsc28gZG8geW91IHdhbnQgbWUgdG8gbW92ZSB0aGlzIGhlbHBlciBmdW5jdGlvbiANCmltcGxl
bWVudGF0aW9uIHRvIGEgbmV3IHBhdGNoPw0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0K
PiANCj4gICAgICAgICAgQW5kcmV3DQo+IA0KDQo=

