Return-Path: <linux-kernel+bounces-107540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7F87FDDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6196F1F2281E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394A7F7FE;
	Tue, 19 Mar 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HXsHECrz";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oXiYK/ck"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A73BBE9;
	Tue, 19 Mar 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852916; cv=fail; b=cd7JyphofSUsPEuSP+aHBRnOeXV4w9uyeARHUdNxlzsw90ei1TYd6FwW/2YhcMCK8gY/wCyj9FLA6qyGcT6IVbHZiuj8Kmo5sVL/iOYRmH6wBY5qFNPnJZGuHyUjgUbx+1NsWdutPWDS7jizCufbOeNWeGVFWDNp6YWRwmCG7Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852916; c=relaxed/simple;
	bh=v81dnH/qgF+lSM7gipuQ5Cyq1/4cetu0a11bsn++v50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ktLCHGeN2CacsUis0UJOSRt4tvk8HW8ZZ39bFxN1amP+shytqJpkswth+j3kVDO9Vfx+p5lfvXPaNpWUzYc8Zk+kLd58VcAKjJuMRducQAvYbPN7TOSe9CtTU4s80ZnIpJj3XtSCgiS7BAd/zHn8oOW/rWJog4Qv0PoBWqB8oTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HXsHECrz; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oXiYK/ck; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710852913; x=1742388913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v81dnH/qgF+lSM7gipuQ5Cyq1/4cetu0a11bsn++v50=;
  b=HXsHECrz/uSa23yma1AukJUhw2Qr8oyrucvAb9RkmkMcNFt16ULqc8S6
   5T3uBOGzN8blGceQfj992MUseX2o5EJJBte6CEnlDXKUcultg5SNzMPJn
   ct/vsXoXgI9WFGLaK2qRu3jIWRnvv6Yc/TWhgXAdQUyZEQ5jhpmaghPxy
   0WPjmhBRocue2uibfD1DXb+5DGHSaLJuXFFXp2TEwvCd/rrQRxe4n8qzn
   mSQ2T/LNnPpOTFZQJVR2sMahwqfgLmDUQNvH3s5MV28hHOMQqcCEKFJ9c
   qsZC0gjIEu3gZJfGVSsPdSZKOGOpi7fNO6JtuRvkmoWEJUEuasPCHaSjp
   g==;
X-CSE-ConnectionGUID: DK9r8ICLT2qBN5CRDfeRaA==
X-CSE-MsgGUID: YweG4Op/RnS058rRTI/9GQ==
X-IronPort-AV: E=Sophos;i="6.07,137,1708412400"; 
   d="scan'208";a="17808864"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 05:55:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 05:54:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 05:54:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBVISy8K7ePuPLVm9J/M9wU2N0RfYDrqPWusS4jd8kamQHCI3qZOn8yjhQc4ZbRKLYXIg6feKSobx7lNt3VLKdObUGpWQQ4FPhsLoQ489SLSR49BIlYIE94gB6cEmXFIiZNLrivURlTJbhIlTOvqX6cNBDk6Ed3Hz+Y4jhGKkGbJS2z7xIprM41ujM+Fl62xwfe362RNy21/Tb3/F0jXhd1oiFq7Fs03rzW9bGpZQ8vhj99Bbl1Pcjq13hQL4PKyKWzik2mmZ5fHjIVXd7KMUMfLWJ2HH6hytXGor7Q2uTh/XL2159zzBX6UX2EY0HuQ5vrTJwlIutJl4wB+chPeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v81dnH/qgF+lSM7gipuQ5Cyq1/4cetu0a11bsn++v50=;
 b=P8PoMsz3ZFdI1qDoPnwffiJ4h185DxFSHAQ4b9d1LJe3kMtGHt5ZFFwz7pTnXWs0fj085//J4FI1pDzHuqFp3jv0DhjL/aHq4l2q+BX5N+g5pt2XMqaKxujWYQCZVBRjVYFKzosPkO9eyIrypp9+FSQ2ZV+FzZj8qdyg871C3UIOYuo4sDhsAyVBht+VZkAkJrhxTLJ0cvECa//xSgs5c+8QDmnh0rwoRERsayIYBvr0wPdzzRD+Q+HJRXeLeTRvMaC0a33zML2W2aVgL1rKE9KTNQ+XKphVTPXtxBSTVxV33dscROU8v4/hgtre+PTQRXmss/mBGYdrj5ahBlrXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v81dnH/qgF+lSM7gipuQ5Cyq1/4cetu0a11bsn++v50=;
 b=oXiYK/ckLLgEZdfiyxxiZnRqhHKGcLUgoYGfrffPkak0z5GnlUKX2VLL8PkthoSgAty1eeUco1xVdILYNOiR0uyg6LFebqsWvWGI/zA7Mh8ENPLqICvfjmaNp632NiVJbsbzDKXRVVXll+JOPwVJJo2RNHepxRzYxxM79FLk+w2VkkmVsTuK8pGnzq3CQDpXzAVLNEKuCxbMVyHpYqiBMRw2h1LIXXtNNqCKVJPxTWJJAQO2Bd7GEaBPrXlrkLmocqvuwdEHMwXUZnRVJv9l+aaGyKXbV7j9PhLs/79Gj9PR0O6zS0A9vhTXGEL7plHQgzjw9QM4JjMNqDTlnbh1qQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Tue, 19 Mar
 2024 12:54:30 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Tue, 19 Mar 2024
 12:54:30 +0000
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
Subject: Re: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Topic: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Index: AQHab6OSKZ/bhrjyTk2coMHmsOmbgbEshPoAgBKU84A=
Date: Tue, 19 Mar 2024 12:54:30 +0000
Message-ID: <f9d8a18c-b1fe-450c-a5ca-d91f96793a04@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-9-Parthiban.Veerasooran@microchip.com>
 <208fb61b-4740-46bf-8c70-29ab59cbb965@lunn.ch>
In-Reply-To: <208fb61b-4740-46bf-8c70-29ab59cbb965@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM4PR11MB6335:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Po+2BlHhWOf4EgRJp0uevpOl8KxZ5CbKvQRJ5fMECkncSuKnAAr7k+9lzUgrD8VNKpcM6jrfOFS9aLrCB+p9cbi+eTZhYG2UPKqBD2qzp2r5ZzHBYeV8nwdT9N19G2MTaRR0JRFEB8YYYrxuozIw4xaw8iGPpyXdnP64ix+X9X4TkNY5q1nPMdPm7m/1qyB9TrNY8fiHRxbI0IYLsxyajuk5x669moPalwPBgfjxb4/WemZOk8rJ9/p/joiMHIM37LvrZeIfmuDBOY3cs7jOVmuIepasdcynQtFbR79P/B/ZvZRyhbGhVGRNg+8Ax/fUB8m5TYO4RgxVAKTSdQ/s3ratVegBOySFKgmDRZJQ84iEDDmkJCmjBHvh6lH48Wvn5iYs86jiWM8LqCL0QTQjcb5Ch+xyDbLkb4c+A8pnea8RYDT8e9PU+f4AOg9F4rZDMlqPNS3hKTQMFvKNIitJxLOoJ0OZlxPQhUmiydRRQ84b8CeVwILfKap2WTbHgNQ41iJgtT2VzrfMdGX+rgwd9cHE6G8hNLXmiuKTAUzbfOdTMXJ47fW32ukFtI3Yu/zGXb57bZPfXEga/OaTZkAnyii2sKHLjzGlqtP0QLEgomGWbnZmjTM/8EsCD+RXUf2IQZ+S+XwINUojTXtTWhIQkSaT5Z0ux3szetFLAYayVOs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mi9HWkZodmdIZFpOL1c2ekxzbi9oc2hlSTV0endZYS9YWi9mbXgrcktFWVh1?=
 =?utf-8?B?bkNjSENra0p4L1dQRzNlVjA2eklMUWNNZDNmVG9hMzlEUmx0SnFUOEI3S2ZU?=
 =?utf-8?B?dXNNMVM5YU4yclhWdmM3VjFmMVNCYzFEU3FrNkJjZkQ2Z2EzZkRFb3h6QjVO?=
 =?utf-8?B?SXBDS2VjSW11MlNicHYrT1FDSzRWUEw0YUJ1NDY4WDBJUGZrd01pNi9aWGtX?=
 =?utf-8?B?NnJudU5VU3NNMU0vM0VRdkVQYUFCUFNYdUIvQmNlSFdkZ1RGbkc1cllwQWt4?=
 =?utf-8?B?RlZWeVJCSVErd3lTLzRYdlFNUVp4RDJUOThDeHI5b0NIZnoyWjFsVm9CbmJT?=
 =?utf-8?B?S2dmRWJrcUI4Y0JpbTVUZ2ZVU0l4UDVPNXdXd1JQTlNaT2o3bzY4TlJ3T3Nh?=
 =?utf-8?B?bFJ5aUJ6MGhidkF2L0R6Q2dKSGVuUkFMRHJQb0x2YXRZSmZ3dFhvNzN6aGlP?=
 =?utf-8?B?ak9nR1JRWmNuKzhjU1JEa29xdkNrdTVEY0lHaEZWZVI0b3NhOUxyRHhob2RY?=
 =?utf-8?B?WngvMldJdUExY1hvcDkyRWtJWnN2V290UWMwZktVckZuQTFwRWNaUit3YUNI?=
 =?utf-8?B?M0RYek44VUhaMnNwbTF0dngzTDc1RmxSQzd2K1lPRkFrRUl5OG1CVFpVTzFv?=
 =?utf-8?B?VFFQbUpSdUtwTy9yb0RIN1ZUcmNMbnpYOHlyazJPczVBdzlMUEx1VVhXQVE0?=
 =?utf-8?B?Rit5NUwxLy83bFkwL0tocStzV0NXSG13Znp0RjE3OVpvWktURWR3L1pDOGlq?=
 =?utf-8?B?M3Bva3F4NXpjc0ZEclVIVU1PYkNwY0F3bjVnZ25BZWgwRFhGK0lMWVlPOFds?=
 =?utf-8?B?LzloQy8zRm1QK1BaWkQwekZvQnJDV1NFZ21RdVlydDZjZUVER3ArTzlGZFNU?=
 =?utf-8?B?dHl4ZDQwMHlPcTR5T3A0RGNQUGJ0YzI5ajhCOGNDKzFVb1l5RzUwaU5URWpS?=
 =?utf-8?B?SDBYOTJGLzI5d1V6RkJRcjRyZ2NYbFovWE84cFh6VUd4WVgzYTl4VkZIUjlC?=
 =?utf-8?B?cHJPOXZmWStXOHMrYlBBZldobHVuRFlVTmRyOVdEM2VaWnNoQ1E4MytxOGhT?=
 =?utf-8?B?b25zVUMxTUFvYmNzK1F4TTNJOXJSMW9ibWNmL2RMTzVINFVTQUY0VFhjZ2Ur?=
 =?utf-8?B?ZXdDRjBVUWNzbWVkMjRwc2YwWFVQcFJ0cEtFM0NxRmtZOTVYNC8vWW9JOHQr?=
 =?utf-8?B?blhtdTZlY0liZUpBNDYwM2FFc3BGczNWUlNYWjVlMFRvRElMakFNTnNVZWVt?=
 =?utf-8?B?ZDhUY1U2cHYxSzF4ZDRjYy9odFcrZU9ndUk0TFdlczIwQXdUeGhzMFBkRkx0?=
 =?utf-8?B?MlBReFFJZTNYQzhRcWNsM1ZTRzZrYXRYblgyWExWbEUyRkM0eGwxVWZwQ3Yz?=
 =?utf-8?B?Y1JDbFdIM21UQVBWdzZxU0Eya1VDZHRxRmhhWlFremZSU29JUTh4WWI2OE0v?=
 =?utf-8?B?T1U3MTE3UVp5Mk9lOTFRNFV4ckxFbVU4cXJwUVBCcUhVQ1BqZFh0N2ZZaERI?=
 =?utf-8?B?OEVHVlVCQ3FxcjNKbTc0NDBLd2R0MDdkYmdSYmVlV3ZrdUVzNGc0cTVkQ0ZZ?=
 =?utf-8?B?M2s4am9uSDVhSVIvNndmancvWXpEN3BMUkhHWURjeTlNUjNoa2JibTFuM1Ir?=
 =?utf-8?B?VzRyc2ZJbVhjVXo1TDBxRGZxUDdTenYvSHdzSk5sMG9TeVdCSE1QWVROcVVi?=
 =?utf-8?B?K2ZpM3hZZDZVSFl4NHBTdE5TMU0zVFZXQ0Naa0R4cUJMNXpyZjNYekFIU3dp?=
 =?utf-8?B?OERKWiszcVNEUnNjVkNSYm1wR0VWNk4wQ29TblFIak02KzlGVkdZbHpJTVI5?=
 =?utf-8?B?VmhKdGNRZ0JjbUR0THJ0QnZYeW9UYUUvbi8reXdTSlNXZ3A1eVZxai8yaHR1?=
 =?utf-8?B?Njl3bTdaQjFYeFlXMldJQlppaGtlNWlJMDQrYXhkbjNRUjVlRjZwa1pXUFFG?=
 =?utf-8?B?WW9tdUxubmY0Z3R4ZU91NXhiZFE2NDdJNWJhUEZoMEJDSFdnMVNxRytzeW1w?=
 =?utf-8?B?VTI5Slhobk5uMnk3Wk9kdTAvTHdJZTZHL2FaM0dNcG5WWTRjbVpONjFBUmUy?=
 =?utf-8?B?RUw5YkdaYlFTK0lHSDAvOThEcTNJa3lrMnlMcGUwWitCbWJWeE9FUlBJR2pH?=
 =?utf-8?B?VHg4MWs2Y3dLOTAzMnZ5LzB1KzBaUGZBWHdEczZ1QWpabVdXd3Vwb1dYaC9z?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4677261D1388694988B63DACF215755E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a4a65c-5197-41d6-7bdc-08dc4813b7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 12:54:30.4835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6Txo+rx8DbrsmkSb29tgaR3eE0EuFKE/ZWlyEnGg1Za52k34kLXkGwZmAsoOUfJjYsBe3O0z6hfQkVJExppe0Lcqozrl7qGhEfFg7SoKj0DPeP+EAo1iEKbhaLqr3i7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335

SGkgQW5kcmV3LA0KDQpPbiAwNy8wMy8yNCAxMDozOCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEBAIC01NSw2ICs3Nywx
NCBAQA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
T0FfVEM2X0NUUkxfTUFYX1JFR0lTVEVSUyAqXA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBPQV9UQzZfQ1RSTF9SRUdfVkFMVUVfU0laRSkgK1wNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0FfVEM2X0NU
UkxfSUdOT1JFRF9TSVpFKQ0KPj4gKyNkZWZpbmUgT0FfVEM2X0NIVU5LX1BBWUxPQURfU0laRSAg
ICAgICAgICAgIDY0DQo+PiArI2RlZmluZSBPQV9UQzZfREFUQV9IRUFERVJfU0laRSAgICAgICAg
ICAgICAgICAgICAgICA0DQo+PiArI2RlZmluZSBPQV9UQzZfQ0hVTktfU0laRSAgICAgICAgICAg
ICAgICAgICAgKE9BX1RDNl9EQVRBX0hFQURFUl9TSVpFICtcDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0FfVEM2X0NIVU5LX1BBWUxPQURfU0laRSkN
Cj4+ICsjZGVmaW5lIE9BX1RDNl9UWF9TS0JfUVVFVUVfU0laRSAgICAgICAgICAgICAxMDANCj4g
DQo+IFNvIHlvdSBrZWVwIHVwIHRvIDEwMCBwYWNrZXRzIGluIGEgcXVldWUuIElmIHVzZSBhc3N1
bWUgdHlwaWNhbCBNVFUNCj4gc2l6ZSBwYWNrZXRzLCB0aGF0IGlzIDEsMjM4LDQwMCBiaXRzLiBB
dCAxME1icHMsIHRoYXQgaXMgMTIwbXMgb2YNCj4gdHJhZmZpYy4gVGhhdCBpcyBxdWl0ZSBhIGxv
dCBvZiBsYXRlbmN5IHdoZW4gYSBoaWdoIHByaW9yaXR5IHBhY2tldCBpcw0KPiBhZGRlZCB0byB0
aGUgdGFpbCBvZiB0aGUgcXVldWUgYW5kIG5lZWRzIHRvIHdhaXQgZm9yIGFsbCB0aGUgb3RoZXIN
Cj4gcGFja2V0cyB0byBiZSBzZW50IGZpcnN0Lg0KPiANCj4gQ2h1bmtzIGFyZSA2NCBieXRlcy4g
U28gaW4gcHJhY3RpY2UsIHlvdSBvbmx5IGV2ZXIgbmVlZCB0d28NCj4gcGFja2V0cy4gWW91IG5l
ZWQgdG8gYmUgYWJsZSB0byBmaWxsIGEgY2h1bmsgd2l0aCB0aGUgZmluYWwgcGFydCBvZg0KPiBv
bmUgcGFja2V0LCBhbmQgdGhlIGJlZ2lubmluZyBvZiB0aGUgbmV4dC4gU28gaSB3b3VsZCB0cnkg
dXNpbmcgYSBtdWNoDQo+IHNtYWxsZXIgcXVldWUgc2l6ZS4gVGhhdCB3aWxsIGFsbG93IExpbnV4
IHF1ZXVlIGRpc2NpcGxpbmVzIHRvIGdpdmUNCj4geW91IHRoZSBoaWdoIHByaW9yaXR5IHBhY2tl
dHMgZmlyc3Qgd2hpY2ggeW91IHNlbmQgd2l0aCBsb3cgbGF0ZW5jeS4NClRoYW5rcyBmb3IgdGhl
IGRldGFpbGVkIGV4cGxhbmF0aW9uLiBJZiBJIHVuZGVyc3RhbmQgeW91IGNvcnJlY3RseSwNCg0K
MS4gVGhlIHR4IHNrYiBxdWV1ZSBzaXplIChPQV9UQzZfVFhfU0tCX1FVRVVFX1NJWkUpIHNob3Vs
ZCBiZSAyIHRvIGF2b2lkIA0KdGhlIGxhdGVuY3kgd2hlbiBhIGhpZ2ggcHJpb3JpdHkgcGFja2V0
IGFkZGVkLg0KDQoyLiBOZWVkIHRvIGltcGxlbWVudCB0aGUgaGFuZGxpbmcgcGFydCBvZiB0aGUg
YmVsb3cgY2FzZSwNCkluIGNhc2UgaWYgb25lIHBhY2tldCBlbmRzIGluIGEgY2h1bmsgYW5kIHRo
YXQgY2h1bmsgc3RpbGwgaGF2aW5nIHNvbWUgDQpzcGFjZSBsZWZ0IHRvIGFjY29tbW9kYXRlIHNv
bWUgYnl0ZXMgZnJvbSB0aGUgbmV4dCBwYWNrZXQgaWYgYXZhaWxhYmxlIA0KZnJvbSBuZXR3b3Jr
IGxheWVyLg0KDQpXaWxsIGltcGxlbWVudCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCj4+ICtz
dGF0aWMgdm9pZCBvYV90YzZfYWRkX3R4X3NrYl90b19zcGlfYnVmKHN0cnVjdCBvYV90YzYgKnRj
NikNCj4+ICt7DQo+PiArICAgICBlbnVtIG9hX3RjNl9kYXRhX3N0YXJ0X3ZhbGlkX2luZm8gc3Rh
cnRfdmFsaWQgPSBPQV9UQzZfREFUQV9TVEFSVF9JTlZBTElEOw0KPj4gKyAgICAgZW51bSBvYV90
YzZfZGF0YV9lbmRfdmFsaWRfaW5mbyBlbmRfdmFsaWQgPSBPQV9UQzZfREFUQV9FTkRfSU5WQUxJ
RDsNCj4+ICsgICAgIF9fYmUzMiAqdHhfYnVmID0gdGM2LT5zcGlfZGF0YV90eF9idWYgKyB0YzYt
PnNwaV9kYXRhX3R4X2J1Zl9vZmZzZXQ7DQo+PiArICAgICB1MTYgcmVtYWluaW5nX2xlbmd0aCA9
IHRjNi0+dHhfc2tiLT5sZW4gLSB0YzYtPnR4X3NrYl9vZmZzZXQ7DQo+PiArICAgICB1OCAqdHhf
c2tiX2RhdGEgPSB0YzYtPnR4X3NrYi0+ZGF0YSArIHRjNi0+dHhfc2tiX29mZnNldDsNCj4+ICsg
ICAgIHU4IGVuZF9ieXRlX29mZnNldCA9IDA7DQo+PiArICAgICB1MTYgbGVuZ3RoX3RvX2NvcHk7
DQo+PiArDQo+PiArICAgICAvKiBTZXQgc3RhcnQgdmFsaWQgaWYgdGhlIGN1cnJlbnQgdHggY2h1
bmsgY29udGFpbnMgdGhlIHN0YXJ0IG9mIHRoZSB0eA0KPj4gKyAgICAgICogZXRoZXJuZXQgZnJh
bWUuDQo+PiArICAgICAgKi8NCj4+ICsgICAgIGlmICghdGM2LT50eF9za2Jfb2Zmc2V0KQ0KPj4g
KyAgICAgICAgICAgICBzdGFydF92YWxpZCA9IE9BX1RDNl9EQVRBX1NUQVJUX1ZBTElEOw0KPj4g
Kw0KPj4gKyAgICAgLyogSWYgdGhlIHJlbWFpbmluZyB0eCBza2IgbGVuZ3RoIGlzIG1vcmUgdGhh
biB0aGUgY2h1bmsgcGF5bG9hZCBzaXplIG9mDQo+PiArICAgICAgKiA2NCBieXRlcyB0aGVuIGNv
cHkgb25seSA2NCBieXRlcyBhbmQgbGVhdmUgdGhlIG9uZ29pbmcgdHggc2tiIGZvcg0KPj4gKyAg
ICAgICogbmV4dCB0eCBjaHVuay4NCj4+ICsgICAgICAqLw0KPj4gKyAgICAgbGVuZ3RoX3RvX2Nv
cHkgPSBtaW5fdCh1MTYsIHJlbWFpbmluZ19sZW5ndGgsIE9BX1RDNl9DSFVOS19QQVlMT0FEX1NJ
WkUpOw0KPj4gKw0KPj4gKyAgICAgLyogQ29weSB0aGUgdHggc2tiIGRhdGEgdG8gdGhlIHR4IGNo
dW5rIHBheWxvYWQgYnVmZmVyICovDQo+PiArICAgICBtZW1jcHkodHhfYnVmICsgMSwgdHhfc2ti
X2RhdGEsIGxlbmd0aF90b19jb3B5KTsNCj4+ICsgICAgIHRjNi0+dHhfc2tiX29mZnNldCArPSBs
ZW5ndGhfdG9fY29weTsNCj4gDQo+IFlvdSBwcm9iYWJseSBuZWVkIGEgY2FsbCB0byBza2JfbGlu
ZWFyaXplKCkgc29tZXdoZXJlLiBZb3UgYXNzdW1lIHRoZQ0KPiBwYWNrZXQgZGF0YSBpcyBjb250
aWd1b3VzLiBJdCBjYW4gaW4gZmFjdCBiZSBzcGxpdCBpbnRvIG11bHRpcGxlDQo+IHNlZ21lbnRz
LiBza2JfbGluZWFyaXplKCkgd2lsbCBjb252ZXJ0IGl0IHRvIGEgc2luZ2xlIGJ1ZmZlci4NCkFo
IG9rLiBUaGVuIHByb2JhYmx5IEkgaGF2ZSB0byBhZGQgdGhlIGJlbG93IGNvZGUgaW4gdGhlIA0K
b2FfdGM2X3N0YXJ0X3htaXQoKSBmdW5jdGlvbiBiZWZvcmUgYWRkaW5nIHRoZSBza2IgaW50byB0
aGUgdHJhbnNtaXQgcXVldWUuDQoNCmlmIChza2JfbGluZWFyaXplKHNrYikpIHsNCglkZXZfa2Zy
ZWVfc2tiX2FueShza2IpOw0KCXRjNi0+bmV0ZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7DQoJcmV0
dXJuIE5FVERFVl9UWF9PSzsNCn0NCg0KPiANCj4+ICtzdGF0aWMgaW50IG9hX3RjNl90cnlfc3Bp
X3RyYW5zZmVyKHN0cnVjdCBvYV90YzYgKnRjNikNCj4+ICt7DQo+PiArICAgICBpbnQgcmV0Ow0K
Pj4gKw0KPj4gKyAgICAgd2hpbGUgKHRydWUpIHsNCj4+ICsgICAgICAgICAgICAgdTE2IHNwaV9s
ZW5ndGggPSAwOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICB0YzYtPnNwaV9kYXRhX3R4X2J1Zl9v
ZmZzZXQgPSAwOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICBpZiAodGM2LT50eF9za2IgfHwgIXNr
Yl9xdWV1ZV9lbXB0eSgmdGM2LT50eF9za2JfcSkpDQo+PiArICAgICAgICAgICAgICAgICAgICAg
c3BpX2xlbmd0aCA9IG9hX3RjNl9wcmVwYXJlX3NwaV90eF9idWZfZm9yX3R4X3NrYnModGM2KTsN
Cj4+ICsNCj4+ICsgICAgICAgICAgICAgaWYgKHNwaV9sZW5ndGggPT0gMCkNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgcmV0ID0gb2FfdGM2
X3NwaV90cmFuc2Zlcih0YzYsIE9BX1RDNl9EQVRBX0hFQURFUiwgc3BpX2xlbmd0aCk7DQo+PiAr
ICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBuZXRkZXZf
ZXJyKHRjNi0+bmV0ZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlNQ
SSBkYXRhIHRyYW5zZmVyIGZhaWxlZC4gUmVzdGFydCB0aGUgc3lzdGVtOiAlZFxuIiwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCk7DQo+IA0KPiBXaGF0IGRvZXMgUmVz
dGFydCB0aGUgc3lzdGVtIG1lYW4/DQpIbW0sIGFjdHVhbGx5IGlmIFNQSSB0cmFuc2ZlciBmYWls
ZWQgdGhlbiBpdCBjYW4gYmUgaGFyZHdhcmUgZmFpbHVyZSBvciANCnBvb3IgU1BJIGNvbm5lY3Rp
b24uIE5vdyBJIHJlYWxpemUgdGhhdCBqdXN0IHJlc3RhcnRpbmcgdGhlIHN5c3RlbSB3aWxsIA0K
bm90IGhlbHAuIEkgd2lsbCByZW1vdmUgIlJlc3RhcnQgdGhlIHN5c3RlbToiIGFzIGl0IGlzIG5v
dCB0aGUgY29ycmVjdCBpbmZvLg0KPiANCj4+ICtzdGF0aWMgaW50IG9hX3RjNl9zcGlfdGhyZWFk
X2hhbmRsZXIodm9pZCAqZGF0YSkNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3Qgb2FfdGM2ICp0YzYg
PSBkYXRhOw0KPj4gKyAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgIHdoaWxlIChsaWtlbHko
IWt0aHJlYWRfc2hvdWxkX3N0b3AoKSkpIHsNCj4+ICsgICAgICAgICAgICAgLyogVGhpcyBrdGhy
ZWFkIHdpbGwgYmUgd2FrZW4gdXAgaWYgdGhlcmUgaXMgYSB0eCBza2IgKi8NCj4+ICsgICAgICAg
ICAgICAgd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKHRjNi0+c3BpX3dxLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIXNrYl9xdWV1ZV9lbXB0eSgmdGM2LT50eF9z
a2JfcSkgfHwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGt0aHJl
YWRfc2hvdWxkX3N0b3AoKSk7DQo+PiArICAgICAgICAgICAgIHJldCA9IG9hX3RjNl90cnlfc3Bp
X3RyYW5zZmVyKHRjNik7DQo+IA0KPiBTaG91bGRuJ3QgeW91IGNoZWNrIHdoeSB5b3UgaGF2ZSBi
ZWVuIHdva2VuIHVwPyBJdCBzZWVtcyBtb3JlIGxvZ2ljYWwNCj4gdG8gdGVzdCBoZXJlIGZvciBr
dGhyZWFkX3Nob3VsZF9zdG9wKCkgcmF0aGVyIHRoYW4gaGF2ZQ0KPiBvYV90YzZfdHJ5X3NwaV90
cmFuc2ZlcigpIGhhbmRsZSB0aGVyZSBpcyBub3QgYWN0dWFsbHkgYSBwYWNrZXQgdG8gYmUNCj4g
c2VudC4NCk9rLCB0aGVuIEkgd2lsbCBhZGQgdGhlIGJlbG93IGNvZGUgYmVmb3JlIHRoZSBvYV90
YzZfdHJ5X3NwaV90cmFuc2ZlcigpLg0KDQppZiAoa3RocmVhZF9zaG91bGRfc3RvcCgpKQ0KCWJy
ZWFrOw0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5kcmV3
DQo+IA0KDQo=

