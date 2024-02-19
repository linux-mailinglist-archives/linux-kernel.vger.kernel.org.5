Return-Path: <linux-kernel+bounces-71526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD3B85A6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FED280DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E493839B;
	Mon, 19 Feb 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2KOTLnOO";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UGDgtJ/R"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB037704;
	Mon, 19 Feb 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354608; cv=fail; b=LUK3NIuWNCxcAynnNitcxX/akqz+xW5tHEQmPyqIQ1lflOJzGkiKfkcyb+1xjzMArpFneWQILZ5BBg1xheGLsLXqny30UXu38em8aiWhVLgOmdHI1d9erp4T4sCkfe6LRFdHho5ERidEjyPDXsUSerJGRfPV+LvbnIQdzXjz2TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354608; c=relaxed/simple;
	bh=p2R3C6aXVaRxiUaQdl5j2ZOw/bc3dG0bKcxROJw7Sug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dZ1SNz0eI0mrJG3j7jhzETeW9u2qfOt38NDHZe8A/hZ3lSFL+dfSa26T8B0AApZzPTxmycJB7sbLftAbLVCLriwq9OFMBgkUMsalmS6kfrSTMt56XInWG+omcI/VW+7maoMJAJay2k2QGq3LqYDzamVnHyJ3snCgQYz5SH/H2O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2KOTLnOO; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UGDgtJ/R; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708354605; x=1739890605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p2R3C6aXVaRxiUaQdl5j2ZOw/bc3dG0bKcxROJw7Sug=;
  b=2KOTLnOOfZa59siFE2MaKCLTdnA4nnhceJRTXkb7A3pXwPFZmvzljkjA
   qFqpYGYNzRFpM24721tXPnRVsz1ZwejRWs08A1sSvGqSlKLzblhzAc/oV
   doIjMEehh2a9jXtvQHlCCq697zkHPQ+1JD3nBkzqjxkx4h/sMfRn88Kkm
   OgHhJCnhtP6mTntmoXIrrS+my5YhAsLORiJ/wih75/dckcJy2zKQZj/np
   +4+pYL7uvFVAdg45xJ8O8gvvw5oo/NsOLEKACp5Dp/kf9HMg4raXnh2ps
   c7J4Ks3va9qlvq3IDCPPVUx0iDMGJhvlfrxSz4mtBzA/y6xSemvklYe/j
   w==;
X-CSE-ConnectionGUID: UjEx9t+STcqRUJvg1jlafw==
X-CSE-MsgGUID: iGG8BXwkSuehzQVHbYHQaw==
X-IronPort-AV: E=Sophos;i="6.06,170,1705388400"; 
   d="scan'208";a="17959971"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Feb 2024 07:56:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 07:56:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 07:56:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ4yGswXkMVOH7YgsXDOSnMXZY6d2DY5w99FTtEjAre2+it/MR2iHZVPSQCrOcBzCrwtJ+laFIeGpFC4fm7WrRER5Vny6ckQ5kdmhxVx3aEyB4o9iYoinsfpDiP6xZlv9Qfqsep1N5neSPJH3SnKXkt7fG5ZXb/tAft68r4CmASbqdn4oeo1vcvHXsciM49HvS7UdJH349HT/HvPM6X4TdkjR7M6bR0+4cbUkTgVK/h7d5kquedAA39vYXKwN/pYxgq8/2s2XOp5beJN/4NUZqNCYVPNM2CYa4KqLtQzQen69OOovBhGnuetlOySbESico0yCxPUbijggOUeh9ovrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2R3C6aXVaRxiUaQdl5j2ZOw/bc3dG0bKcxROJw7Sug=;
 b=oVV458UD9PLuE0+R19Bn+9KSp+aj/bGjQX9XvyptQynt0SXR8ivR41u3d6MALdcf6awjXqk6/QSC16Y/5AtZhclyeePdypKjIFRsGkwF3dDjVZrd8SBQ6ux45wfq0sgrWNvwAlH1jpeDKXcfGi87f5U4zQTC8KcS+4qjP1In0B11FUm3EjQ6ynP5owz+Ev/2VHAlMzoIEoZw/QLOKd1NewnT9CLaQEXAV8kctzoS5q88wccLXwf5zqNzZvg+ITKlnB17fc/d79M0yogOKHderGt5ZjH8GcRsD/gsou+AJ3UexJmalEoDfZXMPM06qRDTf2Blqn/udwdr38wyHhzyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2R3C6aXVaRxiUaQdl5j2ZOw/bc3dG0bKcxROJw7Sug=;
 b=UGDgtJ/RCgc8S3DHOZ7KoRZ6jX/WXPrY4VKhMLFpOo1jMtVOBlBvbQCuZvNVxmtc6Z/e1fB4wZLn7DKzy3y4WknMKLZuIjC4IdP5L1+kr2cBBv85I+e2ylzogR2DhdR/u4HB6jJVjRowmqUwO8uvDMWpPZmgpyk7sl1eH8S5zd+NEMqTtnIWBzerFMZuwe7gmwUWXgWrXJS8D5PxemGgV3w3GDjv/2Wm+e8FY+hDB2k/K6KnfaPovHG31N96Dy3tYWBJbjYj4TMr5HO2Q7kkG9elBGzwEvNlANgKngETsYdLiMRdtR3OXknJRvYu1QF2ytyLFb6rNoGwoBT/wy51Vw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by LV3PR11MB8482.namprd11.prod.outlook.com (2603:10b6:408:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 14:56:27 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::a1ae:867c:66d4:123b]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::a1ae:867c:66d4:123b%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:56:27 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: Add support for
 bridge port isolation
Thread-Topic: [PATCH net-next v1 1/1] net: dsa: microchip: Add support for
 bridge port isolation
Thread-Index: AQHaYzXcqCF1zuDuPUuSLDto36SDfbERwYiA
Date: Mon, 19 Feb 2024 14:56:27 +0000
Message-ID: <e0108e653754a552409b822f22004964e57a902d.camel@microchip.com>
References: <20240219131614.3724037-1-o.rempel@pengutronix.de>
In-Reply-To: <20240219131614.3724037-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|LV3PR11MB8482:EE_
x-ms-office365-filtering-correlation-id: 390cd023-ac04-4fa8-dbc4-08dc315af30d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: my/B18BF+rfKl3t1pe2JHbR7F1XE7CcxQ/SoSPdKCL1arrYhG11rTHqP8kKouV0SHokEmXdClWvf7qRkk+BUNK+mzxVk0kDGBcH1adP4e908EBFmgtGp1DzefI/zIsExVUaB30X6s4i419yJJLJbEO+mRqRUQktE0YR5eSXtWbycCBYP1ZH4zc/bn9yT7ZiFt4HfLzs8o85zi4K40PGHXtGJF2HPvRCrboUnClJpPJn5i7lOxOvBFiwcidZAC/Dm4j/HE31wXchc+6yTN2KgffUJkLZlChYdox50E9Q0n36LXic9UkjnTe7EMA5PIp7yk5hzxk2cZym8w8K15V+UCQWmE2cVXQmEC2J5Mo4BXlI1OgrCpX2dsXamuMkW2AmQJPr8YqmEjASbK6tcrl3wO0bLxnMvc39SBlgNJABTdeFHNUFXob1g2+Ur10oW/i3+D80UEYSgVxIipgJjKMfSyy4Jq4K2ejFPQVwteaKRuApBIbaKlJVbMsVC/xEvFyZ7Q0CWzgR5ij4P6MJjJxPCNjYTeUtmuHN1U+r5C9yBT0qv7QL5VOjLSFEfUby8OSmTT5HADiXfIOaG5HQTVAB68F1mgZusv4rnDSQZtTn/fqsjdDk41XVIbxI9yJcBBolR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFVyUHRRcWlGc0pzUlVnUUJlZ3c0SFlHUm50NGcyT2lUTHZ0R3FuekpEQVhF?=
 =?utf-8?B?RDluNnhDQ29oS2N4eUVUZThBclFZa2l2bTV5K2FJelhuMzgvdW13bVZRVFJM?=
 =?utf-8?B?OVdtblRoKzQ4WEtoRWVRM29sM2hWNG4rTHB2K3BNVGVwcGUvR09BYlhIb0lB?=
 =?utf-8?B?U3gxQmcxVEdFYStQbkNlNW41b1NJQkZWWHkwWGRQZDhrcHVlbHZ5c3QrSFlY?=
 =?utf-8?B?elNGbVFyaEduWGs5N3VKbzF5VU82bythaVZ4eFc5TGVmY215SFhzL1p5QTdl?=
 =?utf-8?B?U0NRMUtLS3FZTjFHYlhGTUVFNkpYemNmVWQ5ZlBpdndoK2U5RlRXeW9yZE5M?=
 =?utf-8?B?ajFuMy9uWDllUlJFclppb0FreUZlSGREZU43bWQweWFHek4rOGx5QUE5ZHU4?=
 =?utf-8?B?d2xSdjlEZlNDMmxQT1Zydit4aitiZWNlZ0tHMUpGMk0rcFIvSEwxY3ZZM3Mr?=
 =?utf-8?B?YUJ5aW1BNmIvc2lLR0NlMjRacXhVZHEvWWRVcUVWZmVuTEdmTkJRemc2ZmRw?=
 =?utf-8?B?bm9hUk8vREJKcGQvaUZjNExaNUswWjBpekl3RjFNdGhlWW5qaVR2T1pqM0FW?=
 =?utf-8?B?ck1KV3dPRU9CbCtueEppY1NnRnJvSVJINCtKMjZrZXFtcHNpZjZ2QWdySEdV?=
 =?utf-8?B?M3kxQ3pJSkVsOU1XZVRFbmI5M3FRZlQ2VVA0NEtEKzZqK3JTRVBUYnRDWE1X?=
 =?utf-8?B?Tm92QzJJVitlSWVKakhQUHBlMitTTlREZ2hSdFRkRVlFeEQ3VC9pTHpDOGtC?=
 =?utf-8?B?cXB3UzdQZ3pHN3hNak93aGRpenFmM1hycGNIK3dxQ1liVnJSTlBSOFJGZnNS?=
 =?utf-8?B?Y0VqRGdQU1ppbzBmdzdEMG5QUHdqNnV6ekU4SDZibVh6WnNsMlhHSmwyTTRk?=
 =?utf-8?B?YmJFbkZmaXYxZWhGSzBjRktEbTYweEZIRmdDTUZITDlEdysxa0JwdFJIWTQw?=
 =?utf-8?B?OU1XaUZlWlFrbktuTTN0b1EzTjgyaEtldklSRFFsTlp1ZmE2V0xWZXFEN1VY?=
 =?utf-8?B?d2FlT1RuYmZIcGJzeHFJbTZ3T0MvRkY3L09IT0hWRVo1dCtBcFBkck9Md1lP?=
 =?utf-8?B?b2VUREFvZkczaEVPM3ZRaW00dkdhRC9NejVyK0NVcUV2N2t2RW95VEpsRUNK?=
 =?utf-8?B?Y0xueEFMVEpvcnBRcEpPOWI2VFdrSWoyNC9oUDdBU1pTVk14eTJnTm1iaUF6?=
 =?utf-8?B?SW0zbWJKcFFBYmptUXVTVmNKUmZTVG1ZdEh3eHZ1RjFkWVdadlFRWkJSazF4?=
 =?utf-8?B?VlpReUIxN3ZtRWhFUjc0WklsWDV4YWpsMHlaUnBLN2VYcC9mcUY5MWQ1MEhw?=
 =?utf-8?B?NGt3Z1Z5aFozamx6WmREVHQ2VlIwNnZzbVVVQk1rK3kwbmIyVWV3NXI1cTla?=
 =?utf-8?B?TjFjK290ek9YeXZTM2J2SVEzOVZmdDVRWHYzRnEzVUt1ZDVPTW5xMk5INkw1?=
 =?utf-8?B?RWl0aHBEdDQ4UDRjSVMvK1dGNDFtNVNjNXFKeVBuOVpxUklzU3FkaVhNTmVK?=
 =?utf-8?B?dC9rMk1ielNPS0JZaXFFU3EyMnVNSW9sNVNPLzdtTzN5NmtXYW5Jb0pBMXVS?=
 =?utf-8?B?ZjVNaW5kZGd6UjNra05nRjFXeDQvejgyWExTTVN6aHZqWVNEaGZjK3krVkcz?=
 =?utf-8?B?UmtoemhPOWNBRi9udFg4U1FtLzBUZjlBRnFSNkJOWlNORDZqL21IaVRWdk1W?=
 =?utf-8?B?c0tnSjhwMjJ6TEdIbWFaMWlDUjZPK0p0cEk2ZTBrRDl5bkQ5SmNBZkRrRGR4?=
 =?utf-8?B?RjJndkhvOGg4Y2k0UGdGeHhibkZOcEcxRVpmeVpqWkpQQjBjUlRiR0RHZWhv?=
 =?utf-8?B?d2Fuaks2enovbjBUVkVjVTNjeEEva2JDWHJxSWwrNmJLUHIxTzBzRjh6OGpj?=
 =?utf-8?B?MUVrNmpxeDdqRWRibkFpUWh4dVZkZjdmakIvM1kraEYyVHZxUmFhbWN2SjZw?=
 =?utf-8?B?bGh0SDZVS1I5T01iRWRyMGJvVFNFQlg0bFJybXNzUEN0OGpwcSt1Q0hRdy9h?=
 =?utf-8?B?bUZtTnBqOG44TUFEai9VallJZkVWMjdFc29TcTNRa0YxeitZbkovNUcyV093?=
 =?utf-8?B?bHh0ZDI1OGxrVnpPaml4c0lRUEd3M21uaE1tT0thT21TRzc3bGVXblVReURX?=
 =?utf-8?B?SVBLQzJFNDdQWU1KL1FzNU9GOFZqL3dXUTBpUkV6RUh4aDhmTS9ldExxS1pj?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEA3545F2D7D6C4D8D41F8F55AEC296B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390cd023-ac04-4fa8-dbc4-08dc315af30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 14:56:27.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vm2itHuUWgypH341aU0Vg8s3qgfCTXLf9XrmkxjIjjjyxEUBUHrDbclU6lNFauHCMNzjzl/M/5ovcTXP9Dk7qgngqhY11+2eeADnqXemnP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8482

SGkgT2xla3NpaiwNCg0KT24gTW9uLCAyMDI0LTAyLTE5IGF0IDE0OjE2ICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbWljcm9j
aGlwL2tzel9jb21tb24uYw0KPiBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1v
bi5jDQo+IGluZGV4IDdjZDM3MTMzZWMwNS4uMTBlNGExNDY3MWUyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uYw0KPiArKysgYi9kcml2ZXJzL25l
dC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uYw0KPiBAQCAtMTkyNiw3ICsxOTI2LDggQEAgc3Rh
dGljIHZvaWQga3N6X3VwZGF0ZV9wb3J0X21lbWJlcihzdHJ1Y3QNCj4ga3N6X2RldmljZSAqZGV2
LCBpbnQgcG9ydCkNCj4gICAgICAgICAgICAgICAgIGlmIChvdGhlcl9wLT5zdHBfc3RhdGUgIT0g
QlJfU1RBVEVfRk9SV0FSRElORykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7
DQo+IA0KPiAtICAgICAgICAgICAgICAgaWYgKHAtPnN0cF9zdGF0ZSA9PSBCUl9TVEFURV9GT1JX
QVJESU5HKSB7DQo+ICsgICAgICAgICAgICAgICBpZiAocC0+c3RwX3N0YXRlID09IEJSX1NUQVRF
X0ZPUldBUkRJTkcgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAhKHAtPmlzb2xhdGVkICYmIG90
aGVyX3AtPmlzb2xhdGVkKSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICB2YWwgfD0gQklU
KHBvcnQpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0X21lbWJlciB8PSBCSVQoaSk7
DQo+ICAgICAgICAgICAgICAgICB9DQo+IEBAIC0xOTQ2LDcgKzE5NDcsOCBAQCBzdGF0aWMgdm9p
ZCBrc3pfdXBkYXRlX3BvcnRfbWVtYmVyKHN0cnVjdA0KPiBrc3pfZGV2aWNlICpkZXYsIGludCBw
b3J0KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodGhpcmRfcC0+c3RwX3N0YXRlICE9
DQo+IEJSX1NUQVRFX0ZPUldBUkRJTkcpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29udGludWU7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXJkX2RwID0gZHNhX3Rv
X3BvcnQoZHMsIGopOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoZHNhX3BvcnRfYnJp
ZGdlX3NhbWUob3RoZXJfZHAsIHRoaXJkX2RwKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGRzYV9wb3J0X2JyaWRnZV9zYW1lKG90aGVyX2RwLCB0aGlyZF9kcCkNCj4gJiYNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICEob3RoZXJfcC0+aXNvbGF0ZWQgJiYgdGhpcmRfcC0N
Cj4gPmlzb2xhdGVkKSkNCg0KUmV2aWV3ZWQgdy5yLnRvIHJlYWRhYmlsaXR5IGFuZCBtYWludGFp
bmFiaWxpdHkuDQpibGFuayBsaW5lIGFuZCBjb21tZW50cyBhYm92ZSB0aGUgaWYgc3RhdGVtZW50
IHdpbGwgYmUgZ29vZC4NCg0Kb3RoZXJ3aXNlDQpBY2tlZC1ieTogQXJ1biBSYW1hZG9zcyA8YXJ1
bi5yYW1hZG9zc0BtaWNyb2NoaXAuY29tPg0KDQo=

