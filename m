Return-Path: <linux-kernel+bounces-161779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F1B8B5116
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A591F23DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24411713;
	Mon, 29 Apr 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="i1sllePd";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZrVSjHNP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901A10A1D;
	Mon, 29 Apr 2024 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371267; cv=fail; b=JdqfMTQct0QlmA8vwxGhHAh/P8BhCGU0s9JfPXBVXjpIACoErGPN0XFCNFk/shS8IJb+onbXenIzbVsumzeGY37eDG+JSMdIzeEcu+BJ+I3qa7arz9BNvnIKkhqUQoQrBR7xBPYz6871csGRqhU5RqyZ1uBJForhNaAzYTCr5tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371267; c=relaxed/simple;
	bh=gNNuFBZCHMlKvHIUe44PqeRGCKznFFews75qDXyDePo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kH+ZO7SA1EnvZAgsrfiI31v+VgNhuFyYk2nNO3EJd2Q1kBoWQK3WK8aWHLZoqWakcCO4nulVC4MggKsYwZUoUscwlFwMv+T5B2B2KzI2ivClsBAtniH277Bx5yLTCkJL9fHij380q1xVRtktosiH0CFa6jOzwjK5L1udaO993os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=i1sllePd; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZrVSjHNP; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714371265; x=1745907265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gNNuFBZCHMlKvHIUe44PqeRGCKznFFews75qDXyDePo=;
  b=i1sllePdk82qGdbbcYATpSr2ywWW1rBEOKGUq0PbWATx29Hk8gwNJvXH
   a628SevW15IB0z3P7pJViG4KH0okGybn6EGfXu2I0s2gHt3/jl1ALEOFW
   +sJ/WiCCOwQlRH2ch55KPtSXrw0GR1XFq5mP1w7eq3kqYFdboC8N2j+CT
   i776BD7eXyBjqHY53ujf01HSyBED8ELAZm2SuXsY1N5O1H8+1BMHCtDfz
   cp2Gjuhk97TEPo+d0zJAzpLXkwJ/HgACsDxaJGgQEhpnDhir7GzsOShP7
   jjiSKn4Te8iqIIP0LiUrYxFMhi1Fim4RLlcgVALDQuS5aIvh+zO6/121b
   w==;
X-CSE-ConnectionGUID: 4E6a9gUPTF2iytnOJoEu/Q==
X-CSE-MsgGUID: lK+FPD3dQ261DrjnYnVDUw==
X-IronPort-AV: E=Sophos;i="6.07,238,1708412400"; 
   d="scan'208";a="23139041"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2024 23:14:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 23:13:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 23:13:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIYNeKxRJOJ5DZr/R06p2gK1oVKbEeD4LxeahqFJyeb2F/sjHmYrbbBDPLt7jy0Snn2wE3q0CJsH03BL5s1siYa75L7FoQiOkjcVt7dOrUioGu5ttJsLGTDaNt1ZHLwdFSY81bkE49BAFQUkzDv1Ei7GiDQbo2ZTuw9qqf6Tp6gcvSDkM0rndONWXTJGOED0r+bqqO+CSErrABW0HlteVoWpWXLOl0qsZx+R3/1Fd0j4Hp7QvByLojXYGZvWw2F8DWuK0ytbvZvX+Yb6xEY3nWn6MEwDdGHYETp74B1hFYjmps3J5STznPwxFAsDb0nU20Lf68O8Uh2xj0rxxD3gJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNNuFBZCHMlKvHIUe44PqeRGCKznFFews75qDXyDePo=;
 b=UhYUIDXIhL8RDOsPJyOOGjV0xNLUkGyfyZhg/rCMkvgxEP5thgI1jyDmU4ophPAuaX4Sjn9AE9PdyqCVB+ocyWtnb2Rv1IGOrL3YactRcKkfkneAyynDa1fVBa1tpv01FoHpy/vYWeOWHDXTMnCTfyQsvEUNfOApCognKXHyrre8GS/1E8Tsfp/imj8cfRoYmXeeTfjPDlDEcnKhIx7jcgOga5MaJwHktBVB2u2kFqomKrk7/YmqoJUDz0HJRNdl04ZchgGvPTevqRnKL5qVdCmDIzfRI69humBgwx3z6OyTrFRgEoqdpfoBVfBWwhxn+iDqyEiI2ScJ5o383xARjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNNuFBZCHMlKvHIUe44PqeRGCKznFFews75qDXyDePo=;
 b=ZrVSjHNPXy3WzE/+gmHAwW27MREdSZNwy3MYxDexAI4ePjshe56zlS72vcc4ut8Gc3NXepHmP8pn5NkWlO313c7/KzMTMRYQCePrI2GFdOZQbF33UWAlBfzd2kGKmoutTa6oNUFPM0app5OxLb44zJ6XgMQkuAcPu8py3baocFQV/O8jAvkv046q6g/e7FUdLqOUrSGZABhakfxxIjS4Jox3J3jAuVWOLqD+ONmixhgTPbYx18R21GpG5P1myRcqCL3znvpcW5iPy40cl7dWb+nTNFtdXPF7JChhigEwCuwSF2uKZiZ2d23QbwCZ0GXggINAFAgL6l5ttbERwDW/Ig==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:13:45 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:13:45 +0000
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
Thread-Index: AQHakZAq1RqgTRBTy0mY7YMhKP6dQLF2mT0AgAQAEACAAE7HgIAD7a8A
Date: Mon, 29 Apr 2024 06:13:45 +0000
Message-ID: <0a052801-9662-4d19-8cfb-13d912c03637@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <231ce196-6a68-4f09-8f9a-976c5ce1495d@lunn.ch>
 <9909d4c4-b3b9-4c4e-9923-64945b6c7bb3@microchip.com>
 <4f6bac89-d6bb-43d8-8675-58a290fb8d5f@lunn.ch>
In-Reply-To: <4f6bac89-d6bb-43d8-8675-58a290fb8d5f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB7639:EE_
x-ms-office365-filtering-correlation-id: 936950e7-fe42-4f92-09a0-08dc68138697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SzkwSmd4YnB1YU5lWXFWVmkzem5wdXdnR2NjdXVqVzk0ajJBWUg5YzFhZG1S?=
 =?utf-8?B?TysxOFhFL1RmZDNyTVRkOWJRbWxMMWRvY1dZWVE0a3VicEhWVWRsS05xcDl2?=
 =?utf-8?B?d0JpaU0vWUR0L3FJM3d5T0JYSVkrN1o1Vzk3eEE0ZksyOGpCWVM3RHNZcDNL?=
 =?utf-8?B?SXhDN3EwQ3BLdUJ5dUxsbzRyK2VTdEY0MEM0eUY5T3F2TTduUzZWNWJDbWlp?=
 =?utf-8?B?MkZITnMwVlZOWkxQUDlTSDhDTldGeU44djB2SHJzZnVPOUp0UDlxRTBUQ1h0?=
 =?utf-8?B?NHRlWUVaWWZKVlRXRE5oRkJ0TFBoQmZjelV2MDFOZnprb0xrV05mWnl2emtO?=
 =?utf-8?B?WWlxOXEvdUV1ekl6ZDZPUmx1Tyt6V05pRHpUTHNwZHB4eXBlSmVyWk1scEdO?=
 =?utf-8?B?OWJDUU9CMk10MUdOcUVlNno1TWM3UXZld2ZSSEJieE8yQ0h3UUUxM25HdENB?=
 =?utf-8?B?QXVrQUFsU1dzMXEzQXR3K3VVL1IxWHBndjZBRGczMVpnM3V5MlhLa0h5aDI4?=
 =?utf-8?B?K3lwaU1WeFJvN3o0NXVwUU82QVRpRjZGZkMzbjY0QUZ6d01xQXNWa1Aya3My?=
 =?utf-8?B?aGpOM1QyaDdlYWRCbTFHN2tUbjQ1MXB1RzF6UExDV2ptaWh5aEpHZFBBWHlY?=
 =?utf-8?B?YVJSMWhjbUlDUkZvd1hkY3NWUm1wWUUrdGp2ekJwOHZMZHhPWnJFWnBNZkhI?=
 =?utf-8?B?N2FHVXJWM0VFVWdMNkpsa2d5aTUvY2JMaFg5bW92azArM1F1Y0pQeTQvQXdK?=
 =?utf-8?B?ZVVqdERiQVg0dldzUUN3cG9wdDNrN3Q5ZzR2cmdrd3hkU0Z6ZWJ1aTBLUFlR?=
 =?utf-8?B?cDlFRGxGY3NoOTdDV0Y3MlRwTW40V2VqQkwxa0RicDNPKzl6cGVuUjlPWU5t?=
 =?utf-8?B?bmdqSkNoZTFQMER6ejJnZ1BPaFh1VzduWVl4ZVlFNllHY01FZThzeGxna0hO?=
 =?utf-8?B?cWdEVGlGVXBrVGpIaFNadmpQYTFtZ3g0d2xVRGJZSGU1dE5OQWxKS1RMcHQx?=
 =?utf-8?B?ajZDMDB6SjVUOGtTdkh2eGxBQmdnbi9tUmg1cHNaV0FLZFRHOGh6a2VFcjJ0?=
 =?utf-8?B?WXFCTUpBaUxnR3Y0OGNhbnhJTXpNdVRrL05Mdy9BYnJSelJycGs0bll1YUQz?=
 =?utf-8?B?aFZ3V1VjUzZGN0cxYWIzOFYvZHMvNU9SaDBIcVlwVDVXSG1MV3RlZ2xvSzcw?=
 =?utf-8?B?VmtFelBoT1ZSZ0tEM2NmaXFtbkJqM1JTYXZLakxzVTVWSHhHUHRtOGZhTlRW?=
 =?utf-8?B?WW1xUTY0SVgrV3hSUmZEOXVOdks4T3ZpUVpEcnBrYTc1VVJvbkFsdkVoNUlH?=
 =?utf-8?B?dGxNaXJFNTZvWnBMclhxbDg0UmRKWC9PQ2NtT3VoVGF0OE5waUcrbDBHWTUx?=
 =?utf-8?B?WktXSkxxUVhMU25NbGZ1SUo1R29LN3RTWjdFRHZ6NU1PaEY2L3h1cHp3eHA4?=
 =?utf-8?B?YytVK0dMY1BLdUVhcHBycHJ0TjlqdWZ3d0tjejdZMWhwOVNXcUFQZlM4UXdr?=
 =?utf-8?B?ZGxPOXNQNGpEd0FOWkZTN1Y0WndZK0tETm9Md3prWGd4RHJKVmhBbFpYcjVj?=
 =?utf-8?B?QlBaNWtSaXZHVUxQRmdackw5UncwNkp4NHdwQlJIeFQ2MGRyMXlycURXUEFu?=
 =?utf-8?B?cytPejcrTnNXZjhlSzdZVGdqc2lHdEVLTHgvWDE2ajlQaGJRRkpvUVJ0bHh2?=
 =?utf-8?B?YW0xcHR3dDNGYUs1SnNCTHNqRGhzQTl1Wk11dytQYUFsVEd3M3JhTGJhbVJL?=
 =?utf-8?B?UzgyTXUxdUR4QUpNbStJNWgzSG5Rc0JoaHRYdUwveXByZ0o2RTFBMG1CQXBX?=
 =?utf-8?B?Vm1Jb3FHdkFaQk5tNng5UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG1wd05HRUI3YWl6TnVSWEErNEhtQmFLbXBRRU9IcXNzZVorV0I1UWVHekZU?=
 =?utf-8?B?VjVjanNwNVhxaUgweDk2TDhNVFpqUXByQjJsQ3hjc3ZLVEFCd2xTRVJpZlNh?=
 =?utf-8?B?dUxpZWM3RzlucEZYMEEzUytldG9OWjVRQS96QXh5Nmd6alUvQmorb2ZWNkxm?=
 =?utf-8?B?cUs0c0tNRXpCbHFkRW9lZmdwem05SzZyWVZrWjhpNzRpRGxQMVdRMDRrTTdR?=
 =?utf-8?B?dG4xaHlkN2IzTXNYaERmWVl4b1BmbC91ODRKcXl1WTBZYk1yVEczRXdjVngr?=
 =?utf-8?B?UXY0emhlVXdINU9ZdDY3bWo2VlJnMXZTSjhtcU5CVDNIVGNYQmxrWGYvSk9P?=
 =?utf-8?B?cklrSEp1OFhCeVc2dkJveW9vd0g0SndQL2FFTno2U1U4VmRsMFd5R05NTVNt?=
 =?utf-8?B?Rjc3VElwbFN3ZkxBSk5JTVJPWndIcGZVZk1CNUxHUGFkUFFQcnhPZjFsY0kv?=
 =?utf-8?B?NnRqQ0RMTEJNOGlkV2xxNktncW45Y3hKSHl2SGJvUldINHRaTk9sOG1ac3U2?=
 =?utf-8?B?eGF3bE9ZL0JUbnFZU20zcmw1aWtHcVRHU1NXRERQazV6NG5xRmJTQ1NFMzdS?=
 =?utf-8?B?WFJpZnZBRjR2TUgxdHRaWWZucm1TamZJUGJkcmJGam95OGtLbHE3T1pjVk5p?=
 =?utf-8?B?cENOQkxIOHF6OU10eG9makp6THNta0o4YkNiNk1kVUU0VWx2MnJ6SFRrbTMw?=
 =?utf-8?B?dlFZZ2Y5L1drRjZITFdQNmdNRUhhcEZSYmtoZGF0R2tBSlNEU2ZDUEp1QXd1?=
 =?utf-8?B?Y3A4SHl3M0FPWEpId3NIOEF5MXE4UEladnRoQyswSEVkaG4ySnRUZXJrbDVu?=
 =?utf-8?B?VG1NSkxPa21wc3VMcU16SzRKQWREa1Nhb0tmbVZhaE5teWNqUHpDekF5aXpP?=
 =?utf-8?B?dVZzakV3cXJQUzh1YUNWcjVCaGtKY3JaSmpHQzV2SWxuc2x4aC9QcVFvQmdV?=
 =?utf-8?B?UzJSQitQTmZCN3BJWW54SHlFZGhMaExBb0N6T0V0THN2d1NIaHMyOHJRbG5L?=
 =?utf-8?B?RUlSL0hCRVRqWEVGN0pZWUxWNEdPQlRSc0dLRGxDejF2Y0czYXlsKzJrSGts?=
 =?utf-8?B?djR6bEU3dkVpR1RWdnNFSlMva2wyTlVSQ2FLUWRSNE9CNGZ5RU90eEw1RUlJ?=
 =?utf-8?B?ajF6cmdvemY3dW9kWlFrUHBZV1Y3eEcrblZqTTByK0xpOFFVYlp3N0hTWHVk?=
 =?utf-8?B?SXIxMmtxdzF0L1RKdThMeXpHMzdBSDJlb2ZrbUhFVGsrZWdtbVo1bzcwRW0w?=
 =?utf-8?B?ZTFEUW4vR3MzWlJuckMrYStvSHVMRWw5SWJ6cXdtekM4SWFFVXFGeXZYQWhH?=
 =?utf-8?B?SVhTalhxWHQ3T2txcitwY3hsNFNtRUt4UUxmcEYwRU9SYVZPSUIzdHRNM0Jk?=
 =?utf-8?B?c3JXS1dqdUZMQmljVHJoK2pGeGtaT210azdLOHJJU1p4cWZ0bWlkVFB3TFgw?=
 =?utf-8?B?S0RYTlF0VE9nc2FXVHZ0ZmlJcEpCNDR6ZzRRUlRtaldxMnZNWUhjanlYdHQw?=
 =?utf-8?B?T2ZaY1Qwa3RhU0VlVXJ4THdRZnFsUEdrRVZzNCt5ZU84NkkxcFo2a0Znblk4?=
 =?utf-8?B?V0I4dDVlYlRySmZ6VVpORXlTQXV4RGdERVhMV2dBUkxObGlPTEpIczlIT2JU?=
 =?utf-8?B?MVRmWWNIL3VZUTg5Z3FsaFl3UnpwTXY1TElmNDVzdVo2aWZuSDFvdEUwR0o1?=
 =?utf-8?B?VGdwMWFHajlxbWRZUzlKK2NqUStwRG9LNFVLMXc3NlJEQ3M4aG0zUVdpYXN6?=
 =?utf-8?B?dENNYVFoWGNHdEZzNVgxZUpVSWZqUkx2c0pYdUllSjNCM1hzczEwMHNKMXRQ?=
 =?utf-8?B?UGhJbHZhUUtRUmIxZzF0OHFIdWQ2WDZ1VTZBMTFFMzFXSVhTODJ3SWV6R2hL?=
 =?utf-8?B?Nk0wMG1Rd0tQQlBwRGNlUGZuU0Z1b3p4elJ6dUFnWmw2cExsY0RuMTNuVU9I?=
 =?utf-8?B?Y1ZkMjc1T1c3MEQvU2VsaHNNVHBwYzgyV21ZaGVldDJ5WFMwd1phKytiTUFF?=
 =?utf-8?B?Z0phSE8raHF6ejJhVVBMVmJhaWhaTjdMUHM3aUlpeDArZG8yT1ZTTW41b3dj?=
 =?utf-8?B?bTJNbzB3Ykt6aGtMdlEvVUdkam9ibDVxVVYyTEZkeGhZNmxEQ01MUE5sd2cr?=
 =?utf-8?B?RmZtc2hlbzdQVHZ0Q2F0bzJmM2tVbWtERkdWKysyMHFoZE8wSmMwZGtSejcy?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31A2014B36F8AA40833C10C38C942982@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936950e7-fe42-4f92-09a0-08dc68138697
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 06:13:45.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qe0Yt7tV6tLB3GM6cM72qAN0XryM6d0R8ZEwRj/TTu5KQjs+Y4+bYyABWaf/RkS84c6sD5ad2xs0BUsGIuJg8hzoBrmpy1QACPZjcdIHlXom1EzrccfhUC9nfZBn5ZZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639

SGkgQW5kcmV3LA0KDQpPbiAyNi8wNC8yNCAxMTo0NCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IE9LLCBJIHdpbGwgaW1w
bGVtZW50IHRoaXMgaGVscGVyIGZ1bmN0aW9uIGFzIG9hX3RjNl9lbmFibGVfemFyZmUoKSBpbg0K
Pj4gdGhlIG9hX3RjNi5jLiBBbHNvIGRvIHlvdSB3YW50IG1lIHRvIG1vdmUgdGhpcyBoZWxwZXIg
ZnVuY3Rpb24NCj4+IGltcGxlbWVudGF0aW9uIHRvIGEgbmV3IHBhdGNoPw0KPiANCj4gWWVzIHBs
ZWFzZS4NCk9LLiBUaGFua3MuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAg
ICAgIEFuZHJldw0KDQo=

