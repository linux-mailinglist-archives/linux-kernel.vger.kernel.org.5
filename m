Return-Path: <linux-kernel+bounces-163527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31498B6C94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98FEB22078
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4577B3E5;
	Tue, 30 Apr 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mZgT9b2S";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cvOjmyMm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838924652F;
	Tue, 30 Apr 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464912; cv=fail; b=fgui0Xb29vNwTRZD6VZQQSuniJSM5lMdikSqMFJQyjIObnscnhURWhkV9F2AbHsk2Mfutmd8Bfw2wiCyYp/zbJP1OsexBPdDQ1uT+HRr1unFrTacKdVZ27deBp/+N+OtrgcWuWtoSW1fJemUgkVDm+csMPy2Ulw48/4SUn/Cmjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464912; c=relaxed/simple;
	bh=Y58/4BZh3fBsLaM4bg5EtaOhgxOZY2pWHauLxb7wZNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rxLprPFiS3dTRdPTgH5ItLOcPzUQ7uWedkUmQwr7Q1C44Q5elZxwrpzB+bE6lndj8wdL9K2xRt1KNr6F9ivVlowl3nSvoyhj0BBHWDCnt89BiqUVOZ5FKFHNBkIEeJBsEuEFRKQN2MOs/Fw5ahw534T4E33OgrXvoQ2woBD4mlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mZgT9b2S; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cvOjmyMm; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714464909; x=1746000909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y58/4BZh3fBsLaM4bg5EtaOhgxOZY2pWHauLxb7wZNQ=;
  b=mZgT9b2SifvITS9pq+XC4QpT81AV2WkbqcukLmnSEBF8/ynaNvuvay1v
   fjNGrk9gw5a3XZcCl8r+6842b3Z8BimjTdKelA0ZIR5jwEfaZS+3kWMF2
   ZoM4bMwctBjDDnZi1BkS/RiER/xcCZogb3UKy56kLZ4fuXhGyZvLLbPPG
   7JXCJLw4NVQrKRjOgyrj5u8tEEd1+a7L4yQpg1tCvtix3bRadzIh8+oNf
   VvbwkeB29Gwk3XwFYR/xunJiU/kAKdLxyCWmQYAK32rWWahAkJYYVGDIs
   xR+knkbctRXxPSskLlHFLqeoP6kK1YfBX6QFOMZC3oDGeZNuA8bz/91Os
   g==;
X-CSE-ConnectionGUID: RPDpzJlSSYC0seemLuqVGQ==
X-CSE-MsgGUID: v0HGf+GMQsyfIK/zoT8OyQ==
X-IronPort-AV: E=Sophos;i="6.07,241,1708412400"; 
   d="scan'208";a="25377107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2024 01:15:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 01:15:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 01:15:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgnbQShBPdDbxb4K2BQK08vqPNeS1ZjQ1PkK/xUuVKupI8YS4SMZVSoekoB/aXk20WXQ2IAV2Fdxi1zDclsqfeGdSL6Qt1kxE1jQEWXpTrx8x2ZpTLE+Sfi3n5zVN9Nd0fkcUKDoj7pLj2R14Q3Gh9smGyZn6STuTuhAlVReK9NQhwTHPTpMs1u1frDMEsQo5XYbi9s+1fbSYrkCQVtGLctte4tlywelGi+UFtTEln+MlpNktyVlXd3MDHrbsRvQ8INYmWGR4vSGdbWpTH2O7qjQNsIRVCLkGTLG2Jl+NYE1wpwtwmCyRPMzEzb7W3kG7QKLtD7tLlKWae5ZWBv8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y58/4BZh3fBsLaM4bg5EtaOhgxOZY2pWHauLxb7wZNQ=;
 b=T0+kyQKFNllhiiCFtzShoLxciG3i6wVy6DkWEIPvjQqRVu7+rWJ9I4fGTpXwlsSlClwjeNBM9/3eWhvwt82+rLFENRrtqbZxYNVVo2VA/5+XQZ/K/QUXYhofesLKMGd8BrGWeasiBzxDprvDRUvHzBT2pbgD4Qtq+ie7zq1MFttuH00b1dyLU0+3UG9IBjxAF4VU8/Yhx7IsQD3gCiUyrjMw7Md+1PMI4/H+r1yKkOAkgXH+iNaALcNWXlKzopqjp/y5VeBANi5UDK4eM7RJCZPSt955qCi72RP5hV3nbvGSXzq6yUyWY/UTOO8rCG9SBp7NsbpcRbskFlBJpkHU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y58/4BZh3fBsLaM4bg5EtaOhgxOZY2pWHauLxb7wZNQ=;
 b=cvOjmyMmYxRGVhwrPfhNA7ZwBNU1ri0ktYo/6UYZpdezxo8SSnGS5WwLSHsQDKbiQfIxLTiYTKwPFdB2DXiAebnDu3w3C/+H53EIaZRlG7/hX6MajJSQmLDIwswuta5TQDRNFx/y0JFIhlBBySn2XtaT/Gm3ol7Tr6oIbu6Bm83u3o4ttuqzBZttPcVJleUNeF5sIDBRIlJz30GTmJgi/VgGBgOSqsCOPckwatTunONXZ+blqVTXkjep+UrL7TZ5EpjRoWYZrn79ojqeHhEqF7EwRodzdRoHsTXxFE9xzxSLwWn9ss+mm+qCrA1yg8MtcNdeEhCCj7mOcJisJny0bA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Tue, 30 Apr 2024 08:14:59 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:14:59 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Thread-Topic: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Thread-Index: AQHakY/7YkCkDGvlBEeB5IUYnNps7rF/g6YAgAEGI4A=
Date: Tue, 30 Apr 2024 08:14:59 +0000
Message-ID: <40552191-d285-4807-9a3c-56dec855b627@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>
 <20240429163630.GA516117@kernel.org>
In-Reply-To: <20240429163630.GA516117@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM3PR11MB8670:EE_
x-ms-office365-filtering-correlation-id: 2c12f355-8ebd-4e0a-94cc-08dc68eda0af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WTB3Z2RwOEh2dUYvRHJybmRIdS9VMk9SUjQwQnNkS2E1aXY5c1cwNVFhcWc2?=
 =?utf-8?B?WHdOSFMwaXQ3bW8xdFBUcDNqQy9GM3FyNll2VGY3enh3NkJkc0U1ZW9MU2lB?=
 =?utf-8?B?WkM3bldYWUV1VXdJelJKRkpDWTlXUllmb2xna2wyQ01KaXFnWmYwcXdiaElN?=
 =?utf-8?B?TTQ1aGRicVVYMll4VU8wWkthbklHTUhqVnZKMjV2STdhQkhQeXoyYTdYd3pa?=
 =?utf-8?B?aFJqKzlzbmpxSnRyVkJDYXBEZm50REptc3lyK2U1dm9DZUxMRDZRRDNKZm0y?=
 =?utf-8?B?RWRwcTJ4NzFIWG5iOXMvdElCUUNodHFPK3l3WjRRTnRKVTN5Q1p2NHhrYnV2?=
 =?utf-8?B?SXladlNtTk5CVEtxVXZDcFNnYko2RG9OVklEamlFV0p4YnVjb3Ewajc3ZEls?=
 =?utf-8?B?eTgxajFqM29LdFA3bkNoMmkzSXhJM0xvdmh3K0V2aVVOeWs3NlJLb0YyQ0o0?=
 =?utf-8?B?bCtsZVd2L3Y3OWowNSt5RXpZaHA4NUdDTUhJMEdISDl4c0tiVVJWdkk5bmNO?=
 =?utf-8?B?Vy9nNFJoby9XeFIxbElkakJxNXdIUXgzSEs5U3oyT2o2UFVOdDN5WmMvc0Qy?=
 =?utf-8?B?MXRvT1gxYklFU1ZhcC9JeUxhSWVYOVoxSFdjQ1M3cE1JZVdDWFpRdzYrNzB5?=
 =?utf-8?B?WFY5NVhGUktFanVJenJWeEZlZkM1b1NKZVZ5bEF3RVY2VVRpb2dKbWQyRS9i?=
 =?utf-8?B?dDd5d2Y2ZnYrVmIxbEhoSXl4SmJYVEpSVXFCNVF4L2VSQTE1SzA1c3ZCOTNn?=
 =?utf-8?B?RmhzZ3lIN2g2K09HSDZ5OVJIOVdxZE02bzFkR1BOWHZNUFFaYnNYUW9Oemdq?=
 =?utf-8?B?Z281L2RUMlNSSGkxYWVvVnU2TEMyaEVoTWpSamFtZGdNUmFaaElvN01WSU9v?=
 =?utf-8?B?ZEgrUndzb2FudVEwNkdpK2tLdnltUzNKNFZFaWY3WkFMRGZzY3NsUi9YNHRq?=
 =?utf-8?B?TVpIRVlZcnBOYzNWTzk5YlpVdmRCejlFTjd6enp1eTJveDd1a3FxZnBEcVZQ?=
 =?utf-8?B?SGR3RCt2bStma2pLWkowenA3NnlPRVFraHB3VlVvc0NYNEQwTEJ3dVBlZ2wv?=
 =?utf-8?B?TlFBVkJ4YktnRk5CQXNscWMreGJ2T0RRd0dKVUNxR2VmMS9uRXlXN2lXUWU0?=
 =?utf-8?B?NWJnZ1pJdFlNVjdVc2I0cDZ6YWFqQW1HSVlVZEMzVFdLSDJ0L21md1F3S05j?=
 =?utf-8?B?OEVKMVJzejlxMXFWQ0hrR0sxcStkT2FDNjc3R3NCWDFtRU8rMWlFM0F2ZVhL?=
 =?utf-8?B?eFZ0QzRjc2Q1Qk5XcFA0ZGZoSXlMVUpxVTF4NjRwVnZtWjV3OWFFeE00NkVh?=
 =?utf-8?B?T2MwRFUxRlFrd2NzRGRFQTlHK1RwbzUyY2EzdGVaMWZhUHNQTUpqZVJIWGF6?=
 =?utf-8?B?ZU1HQnNsbTE3aHA1L2xVTVE1Nk8weU5HWlI5bG9xSGtMRkVHWER6dWJNNjhl?=
 =?utf-8?B?S3J3RkMyTDZYT3M3SkxtTzgzRFM5WW9qUDdwbWZSa1gzNkNJVEx3WUNUTTk2?=
 =?utf-8?B?c3ZEYmg1OEI2MVd0V2tMTThBU2VtMUJTYUtjT0RuUXYybk9tQVhPaHY0a05Q?=
 =?utf-8?B?bW8zWVcybkFXVWR0cWtSRFRRZ3c5OTNIVFpzRXNETWNCWVlXUTZmL0RLNFVi?=
 =?utf-8?B?b3AzczYxT1hCYjZFQ0dLNkJyaUJMZnhYclRCL2ZLaUZVZExtQ3BqV3NRNllI?=
 =?utf-8?B?bGRXekJUNmRUTzg5MGFVa1lweXQ5eUQ1MXp5N1lWSWlpYzNocGZDZk5TMjN5?=
 =?utf-8?B?NkVLNTNTT1pDeHRpY0I5dCtKZHlveW5TbnlmNy9lRkNrem5WdEF2SGVJUTZt?=
 =?utf-8?B?R0RIU0crRkZ4ekFjVkZqdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUNqMnBtNTZXMHdhMXdveVI3TERTbDJCR3E1WFRkd3oyM3ZRc1hNTVVmMUZX?=
 =?utf-8?B?RDRDbENtRU5yMzJ1MUtmU21Sd0RGNlBYMTRBUWtlN1JKd3l0YXRxbmhZdWR2?=
 =?utf-8?B?T3NoTC95STV0NWFwRDl5OGFUbnI4SFlGQUx1a3M1dm1xc21qKzFLdnNZUTF6?=
 =?utf-8?B?ek1GbDdyNWJ3WWs1Nm1HTFVBQXN2VHJ3YnE3OXdFRERpT0ZjMmRuR0llZ1Fh?=
 =?utf-8?B?T0xyTkJyZllIT2hQWDFlMnUzRXFUNUxHYVpGZTdJaWZlTmJDS2xIWHV6TkR1?=
 =?utf-8?B?aFdwdzJYUjU2cjNWTFRneUdmQXhnVEJnOGFtUHl6Mnh5RmkrVmFZbk9GQlVW?=
 =?utf-8?B?Z0JzcnhsSjJiaVVDWEhvcGxOYkQ4ZjJkYkJ1bFpSUzF3V3ZMQlU0dGdjV2x3?=
 =?utf-8?B?WjBpQnpic1kvWTc5MjNKM1pIMjk4Y3lMOVBaNmM0UEVJRldnajlUS0Q5VlY4?=
 =?utf-8?B?N2NRQXkvSkhSZ2NWcmhJY2hJdDJsYS9TaG0rNkNtOWFTeDJaNFd4SlB3OHVC?=
 =?utf-8?B?clJna3pzdVl1LzdwZldTTW8vZHhYZWltQVhSRzVLNThsdmQzcVBwZGp0MUMw?=
 =?utf-8?B?ajNvNmdWVVExbXc3ZkxsSkNXR0VmczN6ZUFpalgvTldhNDhLVS9ZSkVnTWNS?=
 =?utf-8?B?N2JJT2dJOEpvNGlab3pOc2YxUTU1TlNjY3lpZVhUazVMQm9jRERrN3hPL2Uy?=
 =?utf-8?B?ZHNvc1BVK1NrQ0xrYVJyWmdudFZldGFtYmhNQWRiNEVuRXhWSGVZQ3pLdDVx?=
 =?utf-8?B?VmpHNXpHZkpBVHpqWm9Xc1lUQXRua0RxZ1NtOGtrVFM2UEpVYzVuTUlabkFD?=
 =?utf-8?B?UkxoNTNXand2NVpLQ2hZMmF1SmpVMlN3Q2NUazBjeS9QZlRnU2NsYXd1Nnps?=
 =?utf-8?B?WjF4MWszeEcvc2pFY0V2T1orcExCbGtJL0YvdFlUQ1h6eGlsL1NiYzRUUUQx?=
 =?utf-8?B?M2xSNTZPNk5tOC9XSy9JK2hnMERHOTM4Q2FYc281YjJ5eU1EQ3dsTjBSQkZJ?=
 =?utf-8?B?VTRiZ210TzE0ZENvMXJvRS9CcWZjN3J4NXBhLzJhNGZDU3U2anJyTkdkNG1h?=
 =?utf-8?B?ZkdYL2pVQWV6eC9vOHlhT3EwNXN4cnVGczlSTzhwR1Q3dURZOCtseHIwUUVI?=
 =?utf-8?B?MzM3UnRKQlpxbVRjaXpUN1EzYUIxNFQwbXIyMmYwanRDbEl5a28vVVdQaFlW?=
 =?utf-8?B?T21BbnRrVG1ScEE1U1JuTlFaRnBzdnYxdW01cU0rWlJSQU9xbng0VDB1OUVJ?=
 =?utf-8?B?eXJDMHVLWWJJamZjZmVia3VsR1BFTmVtOWNuTEQvaTQyVXMwc0tEZ1RZNS85?=
 =?utf-8?B?R012SU13dEJKZzhMOFJFeGV6Vy9VZTZtOW5KN0tlOWxvVENIV0hSd2lMcDdN?=
 =?utf-8?B?UmFFMjNiRzcveXRuRk1CUVFrUUs0RnN6N0YvZFJQL1MrUlY4UUVodG5aMG1I?=
 =?utf-8?B?Uy9IRGNIK2Nsenpvck8rRU40d0NnRnhpd0VocHhoT2RiUkJ3Q1lzb0dlQXNN?=
 =?utf-8?B?VmRoQXpORjFPMkZNS3FhbEs5WGJmVTlyVm43UE9CRUs4dmI4THU2eTY0UVFq?=
 =?utf-8?B?YzNWVnQvMlJUa2RDVEhadlBNdjl3V1RzOWVNWGg0Rkt1RUNCeHpvVkUvQlZK?=
 =?utf-8?B?NG1tVGtydlZRUm52UkJiK0ZCWDlYOFBiY3FBSGlESTBscmpKNGc4dlhWcVdq?=
 =?utf-8?B?RnNYSG5MbDB6YUFTSjJQOW0yeXBxLzU5QU5JZythUVFGV3hBTlYwWVZKMWZM?=
 =?utf-8?B?blp0cjV5cGVZd3RTb0hWVXovdlhxNWswSDY4MFRDSG96WllFR0hSUXl3cE5Y?=
 =?utf-8?B?MTdtbFZBUjBFa2I2OG1nZ1ZRakYrUXNIM3JZSk1QSjhFeGN2b2x0RGtHUG5y?=
 =?utf-8?B?ckV4NFNpeThnRU13b0ZjTEk2ZlIrM3FFWE04dnhJSUREcWJHZVVIdE5oSHhx?=
 =?utf-8?B?alNhc0hVYnhnWVZvamw2M0h2RHhvNTRYcGIyNW15dnRWYVM0akRPMnhmalJT?=
 =?utf-8?B?cmVoMWczM0dxVDV2T0N4Mk9NblFjYlZHRHlPaFYwV082U2QwYWZyc2dxbkc1?=
 =?utf-8?B?b09VeWVNVm40V0tYNHp1SklmTk15bTJnVkFSbUIwWkU4eHVhTEhBSHozVEpP?=
 =?utf-8?B?OVN2ZzJ2eThNdWU0Z29oWmdvcVF5U2NKMnBhMnBuYVUvbFZ3bjJhZEw0NUFV?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAB6D99F4AE12B439ECA38ED08CD84BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c12f355-8ebd-4e0a-94cc-08dc68eda0af
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 08:14:59.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58kMr2Ij40zOYc05Teow4o8kxhiNcdAnRG6i6Szxr9Fonmp2y1iYJ3jAwG3NWd1ikVUOyAUKM1u+FVvyEGVi4Tu9s+E+TvbYmu9M+I3+ffkYkFiE5jaFg1tCatf1UudR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670

SGkgU2ltb24sDQoNCk9uIDI5LzA0LzI0IDEwOjA2IHBtLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCBBcHIgMTgs
IDIwMjQgYXQgMDY6MjY6MzhQTSArMDUzMCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0K
Pj4gSW1wbGVtZW50IHJlZ2lzdGVyIHdyaXRlIG9wZXJhdGlvbiBhY2NvcmRpbmcgdG8gdGhlIGNv
bnRyb2wgY29tbXVuaWNhdGlvbg0KPj4gc3BlY2lmaWVkIGluIHRoZSBPUEVOIEFsbGlhbmNlIDEw
QkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UNCj4+IGRvY3VtZW50LiBDb250cm9sIHdy
aXRlIGNvbW1hbmRzIGFyZSB1c2VkIGJ5IHRoZSBTUEkgaG9zdCB0byB3cml0ZQ0KPj4gcmVnaXN0
ZXJzIHdpdGhpbiB0aGUgTUFDLVBIWS4gRWFjaCBjb250cm9sIHdyaXRlIGNvbW1hbmRzIGFyZSBj
b21wb3NlZCBvZg0KPj4gYSAzMiBiaXRzIGNvbnRyb2wgY29tbWFuZCBoZWFkZXIgZm9sbG93ZWQg
YnkgcmVnaXN0ZXIgd3JpdGUgZGF0YS4NCj4+DQo+PiBUaGUgTUFDLVBIWSBpZ25vcmVzIHRoZSBm
aW5hbCAzMiBiaXRzIG9mIGRhdGEgZnJvbSB0aGUgU1BJIGhvc3QgYXQgdGhlDQo+PiBlbmQgb2Yg
dGhlIGNvbnRyb2wgd3JpdGUgY29tbWFuZC4gVGhlIHdyaXRlIGNvbW1hbmQgYW5kIGRhdGEgaXMg
YWxzbw0KPj4gZWNob2VkIGZyb20gdGhlIE1BQy1QSFkgYmFjayB0byB0aGUgU1BJIGhvc3QgdG8g
ZW5hYmxlIHRoZSBTUEkgaG9zdCB0bw0KPj4gaWRlbnRpZnkgd2hpY2ggcmVnaXN0ZXIgd3JpdGUg
ZmFpbGVkIGluIHRoZSBjYXNlIG9mIGFueSBidXMgZXJyb3JzLg0KPj4gQ29udHJvbCB3cml0ZSBj
b21tYW5kcyBjYW4gd3JpdGUgZWl0aGVyIGEgc2luZ2xlIHJlZ2lzdGVyIG9yIG11bHRpcGxlDQo+
PiBjb25zZWN1dGl2ZSByZWdpc3RlcnMuIFdoZW4gbXVsdGlwbGUgY29uc2VjdXRpdmUgcmVnaXN0
ZXJzIGFyZSB3cml0dGVuLA0KPj4gdGhlIGFkZHJlc3MgaXMgYXV0b21hdGljYWxseSBwb3N0LWlu
Y3JlbWVudGVkIGJ5IHRoZSBNQUMtUEhZLiBXcml0aW5nIHRvDQo+PiBhbnkgdW5pbXBsZW1lbnRl
ZCBvciB1bmRlZmluZWQgcmVnaXN0ZXJzIHNoYWxsIGJlIGlnbm9yZWQgYW5kIHlpZWxkIG5vDQo+
PiBlZmZlY3QuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFydGhpYmFuIFZlZXJhc29vcmFuIDxQ
YXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4gDQo+IC4uLg0KPiANCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L29hX3RjNi5jDQo+IA0KPiAuLi4NCj4gDQo+PiArLyoqDQo+PiArICogb2FfdGM2X3dy
aXRlX3JlZ2lzdGVycyAtIGZ1bmN0aW9uIGZvciB3cml0aW5nIG11bHRpcGxlIGNvbnNlY3V0aXZl
IHJlZ2lzdGVycy4NCj4+ICsgKiBAdGM2OiBvYV90YzYgc3RydWN0Lg0KPj4gKyAqIEBhZGRyZXNz
OiBhZGRyZXNzIG9mIHRoZSBmaXJzdCByZWdpc3RlciB0byBiZSB3cml0dGVuIGluIHRoZSBNQUMt
UEhZLg0KPj4gKyAqIEB2YWx1ZTogdmFsdWVzIHRvIGJlIHdyaXR0ZW4gZnJvbSB0aGUgc3RhcnRp
bmcgcmVnaXN0ZXIgYWRkcmVzcyBAYWRkcmVzcy4NCj4+ICsgKiBAbGVuZ3RoOiBudW1iZXIgb2Yg
Y29uc2VjdXRpdmUgcmVnaXN0ZXJzIHRvIGJlIHdyaXR0ZW4gZnJvbSBAYWRkcmVzcy4NCj4+ICsg
Kg0KPj4gKyAqIE1heGltdW0gb2YgMTI4IGNvbnNlY3V0aXZlIHJlZ2lzdGVycyBjYW4gYmUgd3Jp
dHRlbiBzdGFydGluZyBhdCBAYWRkcmVzcy4NCj4+ICsgKg0KPj4gKyAqIFJldHVybnMgMCBvbiBz
dWNjZXNzIG90aGVyd2lzZSBmYWlsZWQuDQo+IA0KPiBOaXQ6IEkgdGhpbmsgeW91IG5lZWQgYSAn
OicgYWZ0ZXIgIlJldHVybnMiIChvciAiUmV0dXJuIikNCj4gICAgICAgaW4gb3JkZXIgZm9yIGtl
cm5lbC1kb2MgLVdhbGwgdG8gcmVjb2duaXNlIHRoaXMgYXMgYSByZXR1cm4gc2VjdGlvbi4NCj4g
DQo+IExpa2V3aXNlIGVsc2V3aGVyZSBpbiB0aGlzIHBhdGNoKHNldCkuDQpPSy4gVGhhbmtzIGZv
ciB0aGUgaGludC4gWWVzIEkgbm90aWNlZCBzb21lIHdhcm5pbmdzIG9uIHRoaXMgIlJldHVybnMi
IA0KYXJlYSB3aGlsZSBydW5uaW5nIHRoZSBiZWxvdyBjb21tYW5kLA0KDQouL3NjcmlwdHMva2Vy
bmVsLWRvYyAtV2FsbCAtdiAtbm9uZSBkcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYw0KDQpX
aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGli
YW4gVg0KPiANCj4+ICsgKi8NCj4+ICtpbnQgb2FfdGM2X3dyaXRlX3JlZ2lzdGVycyhzdHJ1Y3Qg
b2FfdGM2ICp0YzYsIHUzMiBhZGRyZXNzLCB1MzIgdmFsdWVbXSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICB1OCBsZW5ndGgpDQo+PiArew0KPiANCj4gLi4uDQoNCg==

