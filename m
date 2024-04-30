Return-Path: <linux-kernel+bounces-164012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EC38B7722
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F941C230E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936717332E;
	Tue, 30 Apr 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oGLS6021";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TNNWMFMb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198D17165A;
	Tue, 30 Apr 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483843; cv=fail; b=ncZGSdNXWQihXmxctyZDBb27MWfXpC2yl9xbOekFr7FjGmNe+NlU2KaMCvMT0SCd7QSYyMHsuVKu67L9Pm3aEL+vW1pf+qFCJGkNgZJhjx/hNhMbHDYmsimsjsh6f9Tsv+ENgpuu6AqMF4pqWjc1Ckk2ZuEtS2TpAcXJevkIBxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483843; c=relaxed/simple;
	bh=pyUa5/bGTNEIDlFG85N2yMVGE9LAqlt+Vwz9DsjlvAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wn2NvMzSHmpxUg6vEw3aUJ9j/pXhgRWPq1h8maCXid01fDh5TfO0BLmAlZcpFCrUwFnyyoq20jmQEdx3D2nXO9/hUsF7ib1vNqN/YholJQC83r1sn/iL/ysH5kEmbvLdou9Yim49/toLa3sIIJwBcZc9+RsTIz/2Cn8o9e7XGk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oGLS6021; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TNNWMFMb; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714483840; x=1746019840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pyUa5/bGTNEIDlFG85N2yMVGE9LAqlt+Vwz9DsjlvAc=;
  b=oGLS6021kKmQXwlBvDuftLn6zZt5Adv8MxiImvzehhBjt1YpENlrCDDm
   1dhlnb1VQWbop3CnSFPA2orKuP4e7EjYvg880E+2NR267qmboSTxMmarg
   q20jExoR/Qjm8py6Wg7Rlraf4eLwHK7uV7aqFZQ+VxW75Zw5bRN6FDB6f
   K5fFfkKn9QCtpcyQHQyQe9+aUKyPNCyTeBQwtIKfPJRONWK9ko8MyJ/RX
   muOYD/dXZKagHxXn5uUM0t9oQlapQpqJ+RNeLnNgYy2vNDh66mbM8Z1mU
   IYY2jqAShIZlIhxhDkP0RqHwyvb08YzAFd2OhiOr/pmLoDDPCP+8/w7Ff
   g==;
X-CSE-ConnectionGUID: Rb8hEjLXRGG/Q+AddBaXdw==
X-CSE-MsgGUID: wu50+BeJSamLf+Ix3oh7/g==
X-IronPort-AV: E=Sophos;i="6.07,242,1708412400"; 
   d="scan'208";a="23249103"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2024 06:30:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 06:30:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 06:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kkvld9mVRv4Oyo6x5z6YrciEAcvjjvbz1Xfng9Sxoyw/4Jj8fVUTZZq5tEzte5XvUNZniy6RPu9AP60zH2ZP4AQbhEf8tQ6Dy82W0+z2IcSvajrKxe3NNuD6k/qlsF07fYH7Ac6RrzRWFTKQrXDOCZb1CaCQfT+iosTSyDAIlTrldqArBu9gojfcy5HQBrRD3+DriHXK+gQ8hAcJxwAJRj+hyuLq/irFIRWe+2zD7wWsHO8cIJrhpeEtVjgRf9Kztw+MYyYdONqx85ubVzOfTI2aoTuVY0WTjqbh/NS5w3PWRXF2qmi2mzPNrfTKM8mSDBnJkKyVHhhpTq0hIkGKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyUa5/bGTNEIDlFG85N2yMVGE9LAqlt+Vwz9DsjlvAc=;
 b=A/G/u6Zhk9VSek6GpZe1PdnNqvlOx7wXsYIs8okYn/JQlNJ35tZrWo0KKNjTOi0jrARd4T7j0UHDxlLVJqnghzfbGSHsJvOys4ve0j1ch8zcROgulwNTj9jsdOltjJbXdzQg6gE7Qo/+P8oUNBaelsd5c5cr16gjk5/Mv+hkzWjDYsgzNFZ3g2KyRD6a1bLkbqWu32/NGPkL1xW+nbrwtA4drTzcVLRyUAk9RlG7Vtwz6XzEO1DziQLaGmHh9EwBxmwPpY0PV8yawOzM/XWsMz2Sn6NDJHzr1dsDPTiUci9GDeM3z6873rr18vE46BvtHognhqkSkKY/xslbwfpnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyUa5/bGTNEIDlFG85N2yMVGE9LAqlt+Vwz9DsjlvAc=;
 b=TNNWMFMbTH7o+jBD2mhBP4PO3zJoINrJhbY+yPKKkx3XR1PmBXzKFTpLxf5qwJWWAWhhZJbBra7fl/UvqaVqNjdA1QkedzJjdW2XnjdsVme95ngWV7BBOoGY8f/II86V2PMsDVDph2wZKIqVD2tuN/UkLHjNIEXhlQQEf3lENytO1JlLFauGHJHcXxWXJvIxM9Mw5SeCRoEOhgWggm+QHc0TsBVt3GReJfkB+CFlvX40GUwRwyT+yvi8RNZ/U23biQMUxWriK6KkuC9X6lQE/Lmj1wXEg6ravuZfwjv8rwmRuIdK715hmE5eZk8mt3vF/GM1ONV1M9g56cAvE3cimg==
Received: from SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10)
 by LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:30:23 +0000
Received: from SJ0PR11MB8294.namprd11.prod.outlook.com
 ([fe80::f85b:116f:aab1:9b27]) by SJ0PR11MB8294.namprd11.prod.outlook.com
 ([fe80::f85b:116f:aab1:9b27%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 13:30:22 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <conor@kernel.org>, <ramon.nordin.rodriguez@ferroamp.se>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
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
Thread-Index: AQHakZAq1RqgTRBTy0mY7YMhKP6dQLF8jIwAgAAKqICAAnocgIAAJ6wAgAGo6gA=
Date: Tue, 30 Apr 2024 13:30:22 +0000
Message-ID: <bc54d514-cd93-4b12-a10a-3d613efc98a2@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder> <20240427-vaporizer-pencil-be6a25030f08@spud>
 <1ae4f1d5-140b-41b1-9191-da14fd67d409@microchip.com>
 <243dab3b-ac07-4d88-8c43-aed53a34cea9@lunn.ch>
In-Reply-To: <243dab3b-ac07-4d88-8c43-aed53a34cea9@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB8294:EE_|LV3PR11MB8742:EE_
x-ms-office365-filtering-correlation-id: 59ba3044-7ba1-4fc9-1baf-08dc6919afc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TkNkV3lONjhxMlQwYmVoN2xyQ1JIT0pEZWlVV1JVVTRHczhiVUhmNmdZYlhn?=
 =?utf-8?B?R1VzQjRGbHByRW0vQ2ticTIyRDZNQVdENDVoUFcrUU1pOWRrR05udWhnSmc3?=
 =?utf-8?B?Qm5hdHhpZlVYWnZ1UnVxa0dpNjVHYXZZVGM0UjBzRHgrSkhqWmJ1elFBQ0p4?=
 =?utf-8?B?ZG1SQnZSd1FzemNTNDlRUzBjV0NxL0lQSnNsNEhBV1ZaSFJRamswWHZXbSt2?=
 =?utf-8?B?V0hzTU9VaGpEN2l4b3Z0RG9aVVJBWlZzcTJzT0pFZHJKa3VxTHlpcTUzUlRP?=
 =?utf-8?B?Mnc0N05INnJudmdkMVhXLzRLbVlOTDM5ZHg0Z3U1ZGVPSDVHdWJYeU5jWG1Q?=
 =?utf-8?B?M1FMb04wL3hNZnIycGJPcHpXb1BMV1lBRHR2Z0tNbFlxcVlsOGRvQnZNNFVw?=
 =?utf-8?B?Zmp2Z1RIaXh5OXFwQXJzbUlJRnpTQzBBTUl1TC82YU1RQWFSTEpuK04vcHRw?=
 =?utf-8?B?NXl0YStCeStWSGNTZndlR0JMZHA3OTg0MWdTQ3MzS2pDWUZ5SnVkMGFja0Ux?=
 =?utf-8?B?YndNVk9VOFI5Vlg2VCtvbFBkeGFZOW82L1pPbVIwVlpIZkNJdFNmWEp0Y0pp?=
 =?utf-8?B?SUJKVkFvVk9MVjgwNlpnUWw5MzFwT3RDV3ovNXJNOUI3K25rVFluRlM0T3or?=
 =?utf-8?B?N0tRa0VpMWRSWUtOVGtYVWtoYmRyV0k1RGlHMEVaL3BudklCRzR0cEx5NUxS?=
 =?utf-8?B?OFpnNGl2M2R6RGhCY0l4d0sxckIySmlwdjBEK1NoUTRTT1BnZjBKTTZpRnRi?=
 =?utf-8?B?Y1cxUDJwNThydjdxaFZiTStWeENwSDV6Q25DbDNBNzNXMzBKUDZ5cm80UDl0?=
 =?utf-8?B?OTdHUEhmYTRtRURXR2pJLzNkVWZMdXRKYVpJM0xzaWt2V0Q0SWxaelJtbzhi?=
 =?utf-8?B?YUpadSs3MkpqODRhVVBRMHB6Y2J0M1ZFTFBWMnpYcGZXNnd0eGtvTWtYMjky?=
 =?utf-8?B?RWF4ZHEzZUVGQkpFWmZER0ZIMnI5U3lyT0szT202ZTdRanJQOS9XZUo2cGI1?=
 =?utf-8?B?a1BKZGJ5MlhwenNjR0xGbHhPbGNqeEpsTVZDSGt1TE1BblJseXVnRUwzVmhj?=
 =?utf-8?B?L2w5V3Q1UmZhVXg4Q1EwT0Z0Mmp3U0RmakZOelV2NEFyaUh2OFlBZ0NqbXND?=
 =?utf-8?B?VUtVQ2U2RE00dlp5MEVFcWx6dnBidWZCMmNhM05MblVWZWZMNVExcFA5cHRv?=
 =?utf-8?B?UVpzT3RxdjdlKytLd2srT0RlVjFjNk0rTkNvNzBjV2FqRWh2NGFYaU5qblBy?=
 =?utf-8?B?MHFNalBlQkhOZjg1K0hGL0QxSXZpdUhxdEtMTm95ellRQ09CU25EanQ0b0dQ?=
 =?utf-8?B?eHdGN2ZQRWgxYTBKVHVHN01FU1NVVnlkek5qMTBpb1N0MktpU05mRG9JbGR2?=
 =?utf-8?B?ckFaQy9CZWphaDJYSmNwS0dGcmQxSGptdEh5TllGa0t1L3ZYY0sreC9kc1d2?=
 =?utf-8?B?Y0JjVGw0VHc4Y1dldFF5VDRnTm1WSGFUZlBZOXBRM1VhbnQ2VDVwbkFDVnNt?=
 =?utf-8?B?V2VTKzU5c25nL2tobWNJMFRmblJPZVhCY1paQ1pMNXY0QUZhYkJVS1NNTEZZ?=
 =?utf-8?B?bktWYVVjVHNjUnVrbnBXRmtvTkk0Q0haeWc1djJ0ZVUvbExlN1oweS9QWG9H?=
 =?utf-8?B?OWFpZmVJc2NFbjAxeDB5K0NIT2R5RkRnZm1LT0xZaG05d3k2NjVsTllBTHht?=
 =?utf-8?B?VGxWakc1Q1ZYMGhsNnBUVE8xRERkVCtBblJJSk1DMGRCaUVTSTl3T29oMTkv?=
 =?utf-8?Q?fr2k7LUkOaHzT9LYME=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB8294.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1h3a3FJaDNZZVg2eHNXT0U4YzhyRGFFQjVtbnJYa2IzV1RmVWQ0MmE4STgy?=
 =?utf-8?B?ZDFCQk5XU2JaT1hGNkxLMjFFdHlBR0M5RHZwOU94SGNEcWw0R1Z3a0dXNVZV?=
 =?utf-8?B?ZUZocDZYcmNpclBTL3J3c2JEUXFRaEdEeldNN0Iva2xub1VML0RHdTd0ZW9x?=
 =?utf-8?B?b3czd3lMSENaQ3QxTTBENUd1S2pOcTd3c2dremFJcEtPakVCOVBIckIycGFN?=
 =?utf-8?B?ZDBNa0VNRkVVQ1pFVnZCa0xlc1h1ZUFvSkZNd21mZUhlYmMrK29XdjBoSDNK?=
 =?utf-8?B?MXg4MnExZ2VYS2tsdGloSkpOaWM0QzhuR3pSYnJmY0ZCalVaUGF2WWVETmYy?=
 =?utf-8?B?c2pDbEZFcXVjN3I5dUdySk5ZNGUyZnoyQlJKbEc2Z21NTlkwdWkvcEJCd0ND?=
 =?utf-8?B?emxJcDJBOTE3R2MvdHdiekVmdzcrdlJ2T2F3NjFGQmlYd0s4Wm0wVE9ncWdP?=
 =?utf-8?B?STdrUFRVMm55SmlPUnV4bHB1d1ZRUmZsblR5U3FTVVJ4VDV4K0toTU9XdURC?=
 =?utf-8?B?eEczejV1UlRiVC9Kczl0N2VyN1JtTmZqdVlWTkt3WS9meFJKOHVzV1RZeTJr?=
 =?utf-8?B?WjY4NWxtc1ZNR1NzSFJxaHA3QUtXTHdCbHF1SnkwUnBydEw3RXkxUHVzN1ow?=
 =?utf-8?B?MEtaaWJhclBDNzhvbFFXR0dBVXcrY1YvSmJSdlg0L0kvUlk4VXYwNjIyL0pI?=
 =?utf-8?B?eGZOUjRMWHlyMVAwMnRIb2ZhVTFFcSt2LzhhMnYzTGl5OHFsYXF5Uk5BSzlZ?=
 =?utf-8?B?a2svZmlPSDhVVWpYa3F2WlJaTHlvaGpVdEhXc25ab1gzUVcwVVBYZ1ZWQ0d0?=
 =?utf-8?B?SzFHU1dpUTlyUkZOU0V1SDBzS3FKMTJCY2NreGxUVXUwMVdFdW5qY3J2aHF6?=
 =?utf-8?B?ODVmU08vQnZnSzRWaDVDcGRwbUx2RmpqeGVudDZGd3NOSlVBL25LMkFERlU4?=
 =?utf-8?B?WE8yT1h5OW1FRU40R050RXViNFhZVVE5VGNPNnFTNnpxSm1lNHF2clN5Mno4?=
 =?utf-8?B?aFVMTENZY3dYb1dXUXVYNzZEbkw5cW5PUVF2UmZNTmxUdFlCNVdrQW1TSlBZ?=
 =?utf-8?B?UlFOdlU3OExUdFpaT1JtY1VXVmlueTBxTEpYbHhHcy9kMDN0NnJiZVZndVA0?=
 =?utf-8?B?K1h3UVBLbFpISGpIR29JeGhjVS81Sndnc3QrNG5POGdiTXAzMnZSL3N2Zmpk?=
 =?utf-8?B?dFI2bW14NTdYOVBKOUtnVGdwWjU4alovbVFQRzFVT3AyV05RSDdMUlpyclI1?=
 =?utf-8?B?Mlh5TkNiUkxaQlN4R0tLbkkvU0lqY1BwUjhWUU1NSlBLQ1VLd1k0S3BRUlBm?=
 =?utf-8?B?dmtNczhPQzZKQjNUUEMwWEorbXJpL1dXUkl6Vlc5NHBwTFZWUVA1emNYaXhP?=
 =?utf-8?B?MjdBTWRRaDRpNTJ0bnQ3Y0ZtemhyR3ZmZWRHdC8zWVRjeTRFandnSmRSb3Q4?=
 =?utf-8?B?QXFKOURqcUQvVmNJRHFiLzRvZVppditrQ2dLZURwNWppUlNjYXFHRHZRUUlX?=
 =?utf-8?B?UjcrRkhGbXRwTmJJVnUvT21wMWJkanJjQkpOQ3dodWc0c2JxMUJneGszOFM4?=
 =?utf-8?B?YWFXUGNocWh5V3RuQXA2Njg4d2tUd0RtZkxINFMvSG55VmcrUTIvWmlKejJO?=
 =?utf-8?B?UytYOXEzUlc5eWRnTjZJeUthblJTTGxWcUtyV0VtRWFpOHlSbjNnQ3NUb3JL?=
 =?utf-8?B?VzBwa3NjMWMxU1VWbXBHWmVvSTBkbEMvS05uSHE4SVFkL1k3UXYvTGZvVkl6?=
 =?utf-8?B?bkIwTFh2UGdqd3J2eTMyVndIQ3dZZGhaNUgzWE4rZjNSWE8xa1E2ZlVXaGE0?=
 =?utf-8?B?ZkkybHl3aDVXOG1vbVZ2ZGRTL2d3VzdvWE9LTHNZd3VQZlhyamtWaFdDeUg1?=
 =?utf-8?B?RkxydDVraGR5NG9nTVFNbktkelZianpwYkM3aUNzN3JLZzVqZ2pvSTU1aVpz?=
 =?utf-8?B?SzhSM0E4RHljMXZXcGRqVHBOTXBrSjJ1N3E3R25ObWFyak03ZkoxN2phTnli?=
 =?utf-8?B?ZS9zOU5HT1pxZEh3QVMxc3pheVUrNEZKV3hnZm9PRTA2Y1dZM21GVUhRRGxW?=
 =?utf-8?B?Z2FoR0lHSFZyS0x4ME1zYzgvd0VGbzdSYkY5NTlhYzVGZkpsSTNMQUpQSVRp?=
 =?utf-8?B?c0FJS0dZRzBadE1tMVRVR1lKOU1vb0xVbmpMbnB5ZVoxK2hHN1FadVEvb1Jt?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2EFF96A0D95624080526EDF588ACC6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB8294.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ba3044-7ba1-4fc9-1baf-08dc6919afc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 13:30:22.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RB6Ed0SXirybYqnXv++ibdy+kswThZhrCyDaW8OUWjEJCCjKsL4gfUYnYncnP9duCiFii6vzfLv4HlhS1556ek5BneWyveVNnHIU95ovNn+znArfXOCPJK+ZxbskAT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8742

SGkgQW5kcmV3LA0KDQpPbiAyOS8wNC8yNCA1OjM5IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gTG9va3MgbGlrZSwgdGhl
IGJlbG93IGNoYW5nZXMgbmVlZGVkIHRvIHdvcmsgY29ycmVjdGx5LA0KPj4NCj4+IGxhbjg2NXgu
YzoNCj4+IC0gY29tcGF0aWJsZSBzdHJpbmcgdG8gYmUgY2hhbmdlZCBsaWtlIGJlbG93IGFzIGl0
IGlzIGEgZmFsbGJhY2sgZm9yIGFsbA0KPj4gdmFyaWFudHMsDQo+PiAgICAgICAgLmNvbXBhdGli
bGUgPSAibWljcm9jaGlwLGxhbjg2NTAiDQo+PiAtIERSVl9OQU1FIHRvIGJlIGNoYW5nZWQgbGlr
ZSBiZWxvdywNCj4+ICAgICAgICAjZGVmaW5lIERSVl9OQU1FICAgICAgICAgICAgICAgICAgICAg
ICAgImxhbjg2NTAiDQo+Pg0KPj4gbWljcm9jaGlwLGxhbjg2NXguZXhhbXBsZS5kdHMgZm9yIGxh
bjg2NTA6DQo+PiAtIGNvbXBhdGlibGUgc3RyaW5nIHRvIGJlIGNoYW5nZWQgbGlrZSBiZWxvdywN
Cj4+ICAgICAgICAuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MCI7DQo+PiAgICAgICAg
T1INCj4+IG1pY3JvY2hpcCxsYW44NjV4LmV4YW1wbGUuZHRzIGZvciBsYW44NjUxOg0KPj4gLSBj
b21wYXRpYmxlIHN0cmluZyB0byBiZSBjaGFuZ2VkIGxpa2UgYmVsb3csDQo+PiAgICAgICAgY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MSIsICJtaWNyb2NoaXAsbGFuODY1MCI7DQo+Pg0K
Pj4gSSB0ZXN0ZWQgd2l0aCB0aGUgYWJvdmUgY2hhbmdlcyBhbmQgdGhlcmUgd2FzIG5vIGlzc3Vl
cyBvYnNlcnZlZC4gQW55DQo+PiBjb21tZW50cyBvbiB0aGlzPyBPdGhlcndpc2Ugd2UgY2FuIHN0
aWNrIHdpdGggdGhlc2UgY2hhbmdlcyBmb3IgdGhlIG5leHQNCj4+IHZlcnNpb24uDQo+IA0KPiBB
cyBDb25vciBzYWlkLCB0aGlzIGlzIHByb2JhYmx5IHJlbHlpbmcgb24gdGhlIGZhbGxiYWNrDQo+
IG1lY2hhbmlzbS4gUGxlYXNlIGxvb2sgYXQgb3RoZXIgU1BJIGRldmljZXMsIGUuZy4gaHdtb24s
IGFuZCBzZWUgaG93DQo+IHRoZXkgcHJvYmUgZm9yIG11bHRpcGxlIGRpZmZlcmVudCBkZXZpY2Vz
Lg0KSSBqdXN0IHJlZmVycmVkIHRoZSBiZWxvdyBkcml2ZXJzIGZvciB0aGUgc3BpIGRldmljZXMg
aGFuZGxpbmcgYWxvbmcgDQp3aXRoIHRoZSBjb21wYXRpYmxlLA0KDQpodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Rhdmlj
b20vZG05MDUxLmMjTDEyMzkNCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0
ZXN0L3NvdXJjZS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hZGkvYWRpbjExMTAuYyNMMTY0NA0KDQps
YW44NjUwIC0gTUFDLVBIWSBjaGlwDQpsYW44NjUxIC0gRVRIIENsaWNrLU1pa3JvZSB3aXRoIE1B
Qy1QSFkgY2hpcA0KDQpTbywgdGhleSBhcmUgZGlmZmVyZW50IGluIGludGVyZmFjZSBidXQgbm90
IGluIGZ1bmN0aW9uYWxpdHkuIFRoZXJlIGlzIA0Kbm8gZGlmZmVyZW5jZSBpbiB0aGUgY29uZmln
dXJhdGlvbi4gU28gbGV0J3MgY29uc2lkZXIgbGFuODY1MCBpcyB0aGUgDQpmYWxsYmFjayBvcHRp
b24gZm9yIGxhbjg2NTEuDQoNCkJ5IHJlZmVycmluZyB0aGUgYWJvdmUgbGlua3MsIEkgaGF2ZSBy
ZXN0cnVjdHVyZWQgdGhlIGNvZGUgbGlrZSBiZWxvdyB0byANCnN1cHBvcnQgd2l0aCBsYW44NjUx
IGZhbGxiYWNrLiBTdGlsbCB0aGVyZSBpcyBubyBjaGFuZ2UgaW4gdGhlIGV4aXN0aW5nIA0KZGV2
aWNlIHRyZWUgYmluZGluZy4gVGhpcyBpcyB0aGUgb25seSBjaGFuZ2UgaW4gbGFuODY1eC5jLg0K
DQpzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9kZXZpY2VfaWQgc3BpZGV2X3NwaV9pZHNbXSA9IHsN
CiAgICAgICAgIHsgLm5hbWUgPSAibGFuODY1MCIgfSwNCiAgICAgICAgIHt9LA0KfTsNCg0Kc3Rh
dGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbGFuODY1eF9kdF9pZHNbXSA9IHsNCiAgICAg
ICAgIHsgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjg2NTAiIH0sDQogICAgICAgICB7IC8q
IFNlbnRpbmVsICovIH0NCn07DQpNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBsYW44NjV4X2R0X2lk
cyk7DQoNCnN0YXRpYyBzdHJ1Y3Qgc3BpX2RyaXZlciBsYW44NjV4X2RyaXZlciA9IHsNCiAgICAg
ICAgIC5kcml2ZXIgPSB7DQogICAgICAgICAgICAgICAgIC5uYW1lID0gRFJWX05BTUUsDQogICAg
ICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IGxhbjg2NXhfZHRfaWRzLA0KICAgICAgICAg
IH0sDQogICAgICAgICAucHJvYmUgPSBsYW44NjV4X3Byb2JlLA0KICAgICAgICAgLnJlbW92ZSA9
IGxhbjg2NXhfcmVtb3ZlLA0KICAgICAgICAgLmlkX3RhYmxlID0gc3BpZGV2X3NwaV9pZHMsDQp9
Ow0KDQpJIGFsc28gcmVmZXJyZWQgdGhlIGJlbG93IHR3byBsaW5rcyBmb3IgdGhlIGRldmljZSB0
cmVlIGJpbmRpbmcgYW5kIA0KZHJpdmVyIGluIGNhc2Ugb2YgZmFsbGJhY2suDQoNCmh0dHBzOi8v
ZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC9zbXNjLGxhbjkxMTUueWFtbCNMMTgNCg0KaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L3Ntc2MsbGFuOTExNS55YW1sI0wxMDINCg0KaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zbXNj
L3Ntc2M5MTF4LmMjTDI2NTINCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAg
ICAgICAgIEFuZHJldw0KDQo=

