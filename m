Return-Path: <linux-kernel+bounces-154507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F488ADCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8DDB231F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030C200C7;
	Tue, 23 Apr 2024 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="inEbV5zN";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qUuLJeTZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE61CAB3;
	Tue, 23 Apr 2024 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713847143; cv=fail; b=HyASu7jZTNkpn1Wb+zYCpD75Gpb2dsESCT+sLUVWbyxfU5BSP7aonr4CQYYCFNagBeKUJfdwgLPEbMsv6kZEpalu9qzyz4o2s0qEBqELPh6lNV04O4jRAIp3YwAOLg2jxnRY5SzZDWTqkx3Ml9HWcxj62mkeK/o22C6AqVeDVqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713847143; c=relaxed/simple;
	bh=cPXzl9xmFYpBaeublKgoWZoR96ASiRdlB2OvCtVpdAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hAOog7NbfmxOJZ1xwLQ7u7jh57JrpWmshMWuchzRQZyB5IdkE9K7c9dKUaZm7u15lr6F0v7UzlFmII9mLTlbYhzDzO682ZouD6CMgFGIYuK2XuGbaiwWwQJX8I5q8SlUpzZCcbDlIFbwt+Rm2dnGzANbRh7mPRJVq8SBUToXtNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=inEbV5zN; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qUuLJeTZ; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713847141; x=1745383141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cPXzl9xmFYpBaeublKgoWZoR96ASiRdlB2OvCtVpdAA=;
  b=inEbV5zNF3RbE06gRPbUour1ZctyfLrWvym+2bSjHxYMerZpizZ+ncH2
   IStpiAA5eFV3/W1dtjtp/MOMAcxPF9i+41Q+MoPNldXaFJ8HM6FQ8r5kD
   rNc783uuOraceiRIjhYwHVtE/hRDtp7Ea7rZkhTLBCerNn9Ur5mlWJQn3
   eWO6UarzLycLGYLaRBiHfmpy7MkFMdIA70gKgNPtwu1zwQtbdYyb0nbEi
   fo/MstpJmwaqfQOdnv5VivRLidRGNbo5GOchzEEQ4T+QzBXDqWDrlFUml
   w8fbe5YW9CHY8G0OH/7sfvRFfbmsW5rQT6rLDKxIujHtHXxqJOksLCpAN
   Q==;
X-CSE-ConnectionGUID: jENQghnQSB24Ydz8mqOmHA==
X-CSE-MsgGUID: Q7fNrH7bQZ2y9Faf/2gw4Q==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208";a="22227976"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2024 21:38:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 21:38:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 21:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eklFM3iR17EoQDXnRyhVu2AaD4gG33jt3DTkAThFUX5N+H1uSYzw5at4H+vIifL+sxVNN1nWNApjpr0+xq4y3ZxyPCD0CE91zT92bgOEy6rI8tYJhmK5t7n9QvApN8ESRvz2WuEnXvOTE1SfRw6jmZipncS/GITrlAJahzVkgLgeEmDkRRlxxdy1xXz2t8uWyXszYpGplRUmaQ0CpDg+BFrWNbZ2J2TItixYa08/fUPScebRxkk87Zag12S5m0QXb2qDy+nIp9qnV/xWrd/YnnKVzQQJ5HoPfFnu/P4SZrg3TNZaoZC/rAJQ1uY9jkHCQ4X7VAgffhrO9ZWaeGRK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPXzl9xmFYpBaeublKgoWZoR96ASiRdlB2OvCtVpdAA=;
 b=dRXnvPq2d49kot9VaVAbzNnNI4jkwxXDIDKADar/yvE8dnTx0N2+RSBEhcNyrh7zzWWcw8GY29RHHR8DZuKuhHx3Y1X2Dop507MrWAGarfvuwnFw0FHSvB9aEpJqyHJKEhZKN0rhCNvNaCb9sIrPducJeItpR92SHS7kbE1A8Ep33jgNcH7EzVMg9MyVTNLwGc8kiL+XvA6JaJi7pw6IKhgJmEizJp61qMSOVkjJhufTy7rENRWBx8LdiVdxktiHTvWksAhWo+aFuMj7yRhCxYnTeL/i0x0KGgsa7aDQ+tTn3rst514rFbryEjLZ6oF9OZQ287oflGw7CdDEy60c2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPXzl9xmFYpBaeublKgoWZoR96ASiRdlB2OvCtVpdAA=;
 b=qUuLJeTZSuylSoXk3PWLgiLDBTIPwPXz0AuQ+f1PoyayUjQpEu9iJyPrnHovhbv5PZlMEs0lcAe4a4EQbGi3rcO3oqoG3ZYpoIHNQl/VfwBJ8rRorAoQ893nIncNSNykReG8MvTcpvuGRuTS6Q6aDn1ePkyzERVAZR2ReG3kt/Zo2u5JT4zouJRbfXkjuc+CRdVmDp+kz3s/PVTi9F6C/K/77c5dqNGqyYSypMYjrhc9iTyQm7a5p9L6ad0AtLpUFd5xWOWgZv4PNBPdK/0azVH318u6fEq1115W+W+3g9/A3CcmriMVvViWIBuLS9cpNgR1vgxkCqxFnm1UexO3vA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 04:38:27 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.018; Tue, 23 Apr 2024
 04:38:27 +0000
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
Subject: Re: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Thread-Topic: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Thread-Index: AQHakY/7YkCkDGvlBEeB5IUYnNps7rF0++YAgABROwA=
Date: Tue, 23 Apr 2024 04:38:26 +0000
Message-ID: <9b9d0be5-fa62-402f-be10-f0a4b77ed066@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>
 <358658e7-70b8-41c3-8999-0d6ebbc8c9b8@lunn.ch>
In-Reply-To: <358658e7-70b8-41c3-8999-0d6ebbc8c9b8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW4PR11MB6887:EE_
x-ms-office365-filtering-correlation-id: 853f608e-95b0-426b-cd74-08dc634f37ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Yk9QbFBYYXNvU2VFT0xCejNyL1FVTnlYS1g2WE5wNmV3VmphNnVGQXMzUkIw?=
 =?utf-8?B?ZFpxRUNuYmY2eVo2MVNsUW5obC82dlBGQTFiSDd3TFZqTHdhRjIwajFiTk4x?=
 =?utf-8?B?TG1PZWdXRitvK2YxamFjeWdIWjh1cVc2UTRMZS9ySy96UUdvbDhxOUF3N3ZD?=
 =?utf-8?B?MUN5Vlc4N3ZacVpWY3FhZjV3MHBRYXB1YjVVRDdLcTBVRHdra0tueXZsRVdn?=
 =?utf-8?B?TGU5R2UvaUZHcHZTa0NKWkk0V2RETVhuU1d3NG1oM2Iweks5ZlNKa3h1TWw2?=
 =?utf-8?B?K3RyZkZQTFVVckF2dUwzdm8wWm10cmNoaW1mcWFya29ONkhvQ0MxNytzbkhy?=
 =?utf-8?B?UXVYSmNGL3ZzK2s1NUtoU0Z5SlpuM3F3NERXdVk1cmdHMk42d0k3cDBPS3pu?=
 =?utf-8?B?YTF6QW5JSXhxS3hrMHA3RHEyU0pPYUNqbkM0RDVrSWUraCs2L1UrbUFIeXZY?=
 =?utf-8?B?SnJVSTVuMmlkRW4yQjJEdlFlQS90azM5Mms2cnV5WnN6aldmZjJHdk9CbGZB?=
 =?utf-8?B?eDdJZ09ZQjB4QTM4ZC9XdU9JN3RhRlE4U2R4QU9JL3J1biszZ0s5Q3FKeDVX?=
 =?utf-8?B?ODd2Rzl1L3hBRFA4Znp3d3dOeld1cnlESXpFRlIrS2FvZHRnWkY3cU9VTjN2?=
 =?utf-8?B?OU50ODNRODhJUFZXY2NGTXNPZ0ZERlJJdEw1SEp4Y3M0dXN2dTlpUjBHeGFY?=
 =?utf-8?B?OXZPSTE5NUk3NlAzdGdxZ3o2N25rUGVFWXNjUllXY2dVbHduSTlXa2Q1NlB0?=
 =?utf-8?B?b2M0VlFoM3JlZEdUMi9DTmFpQ1VtbGlIVVRQU3JLQSthTDg3UC9rSVFXSU5R?=
 =?utf-8?B?czBWRFdoRUNDRXl3WEJPU24rMjFLUDBjSDZsaGxlb0dXU21FQlU5U2R3a1ZK?=
 =?utf-8?B?aVpQc1VSaHdIcHZTUm1QT2UvWmtmbjRZZHFXNVVHWlJZU0VpM1EyemNnejZL?=
 =?utf-8?B?Q0xGMjJ2TUpkSG9TK3hTS1FLb3RWejhQZEtFOXk5cm1yZk9ERW5PbE9ZQWtN?=
 =?utf-8?B?SThVaHZzaEFVeGUxR2F2N3ErRVdDV3ZYTXFLSzd2b2poV05OK21PVnhBa2dy?=
 =?utf-8?B?Sm5XUzZxVGRiZEsrY0ZlU2R0UTdNUjRkN1ZIZEhoK0pKa2RtQk9yZ3pGVUJo?=
 =?utf-8?B?bE1WMXJJZDdxM3FnRVB6ZldmWXAzWEdIbjY1RXRFUUlxRFhlUldoOFpJKzcw?=
 =?utf-8?B?cGlubVM3Sm1QL1p4TVA1WEsvQmIyTXhaNmpDaXBNWHZKTTNaWWFMbUlEazFU?=
 =?utf-8?B?d283aFV5cDdVYmJYSG10QmYyaTBvMnh5Wk5Ta1NYeUM4c0Y2SS9YOXo1bnlW?=
 =?utf-8?B?Tk1UNVFwVmV1U1FXZFByRlA3K0pNa09LY2tSZTl3NDJGSFpYMUhFckxxa0J2?=
 =?utf-8?B?MDYybHVGTWdodUdHVzQvblI2ZUVWSE40aUZrcEkrOGo0aXpPUzlFMXBlUlQ0?=
 =?utf-8?B?L3crV2VBSUxSOWVYWVM1NG1JSDZteXB5SVU2WElBMm1xUmhjRkFKSk50cmdU?=
 =?utf-8?B?Y1ZLbzI2ZzBNVzltZU8xdjZzNHhMVWFYYjRUVkUvank2K0RyQVFKWm5Sdmty?=
 =?utf-8?B?L29KdXdxTHRtL0Vpd3c2YnFuZWhsK0UrbDkxd0xZOU5LOTRjY2xNY0FTcms0?=
 =?utf-8?B?UU54SVpveElmTlpXWWdKVFpHWHhBSFRmeFFsaDA3OUZZWkpPbGR2TkNmUXJw?=
 =?utf-8?B?VU9WNGlsTkNmQllCMUdiUU9iMmZOdS9HN3pGWkZic1dtNHNNRHBaamRhZ214?=
 =?utf-8?Q?pHfB/97Y9YXpRfWNzs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3pyZWtDQXBJM0NZWjNKWHdWN1lXenRwLzhuSjhsUEdIVHR6YWNjdXBMWnl1?=
 =?utf-8?B?Q2o3Zi9RclpHbkxROC9HNWRINTlUWldpMlgzWDBJRzJnT0RvNkJGZzVxNXRQ?=
 =?utf-8?B?d0VQcE5QZlgwNk5NTlFMaVlOV2tjQ3Z0RStUL1VVVGRTN0ZUUjlKM1pwNVVX?=
 =?utf-8?B?Smt2RlRibVZ6dVZMNnM1aDR0NW5CUjdNU2xDcVNONG1WNjdnTHNBQys4V00w?=
 =?utf-8?B?WEJXVHlDdlZYY2UrV3RXTVE0Q0dqcGtUZk9GUmNDU2pXSU1UZDlTMzkyNndn?=
 =?utf-8?B?dG96aEpLeklrcVkxc0pVTWhlR1FoakRWLzhtaVpXS01lNDhHRU16eHIyZkRC?=
 =?utf-8?B?N1lvUnhpOUpLMDVQUHhydy95VXNscjhuWlJKL1dLNjU0US8wZ2hQdkxMZ09z?=
 =?utf-8?B?RS9RUDZyOStnSnMyTStTUUVPSVE1dS9DZmpmQ0lvZ1VnTWRxVU5STUl1UXo1?=
 =?utf-8?B?V3MvLzFoR1dPcXFHNDJOdHl5YkdoMjVEVVJkb1lrUFQxdE9EMHJqQ0M1ODhY?=
 =?utf-8?B?R1J2VXc2RTJxbDV6MmtiZWhqS1ZrRlN3cGs5REtqdVZBTWFhSnYwWks1K3Ix?=
 =?utf-8?B?RDRqU0lhKzFWT2Y5SlhBOXRGdVJpbjNqbW5EMGdMSVl0TC91dW1OeEhWYmdR?=
 =?utf-8?B?N3BLSUErN1Y3dERRR1loR1VPekpiZmpBL0gwaTZlSmlpV0FSeUg0aVJEL2lS?=
 =?utf-8?B?TnFCenNLcTB6UGVLdUxndmFPYUYyMlFORWtQeEZkdnVIN0dkSUt2MndxYS8z?=
 =?utf-8?B?ejA0Smg4YkpVZjNpMlVoM3ZMU3kyU3pKQ21HOHVDeVYrUUlOWVJoZlBnNVdJ?=
 =?utf-8?B?dHdIQ3E4dnlyR0hqZXBIOGtYWGYySTZ1SUZxT1JuZzNaOTN2OTlYSnRUTnZP?=
 =?utf-8?B?NVdTQTlDQ0tnU0dSanJBUzNQWWprWUxHcTVGaHJ5aEtkd3cvYUpPcWp1WThB?=
 =?utf-8?B?SWtiQTJyYWRnRjhaYXhzeEx4dU80d01lbUk4VWV3SFFzZk1JSDlYcHlsNFda?=
 =?utf-8?B?NlgwWnN1WllTQjBYNS80eUtkdGxSNHMxcDhMVGREY3pXdU5CU2xRR2pWQVU0?=
 =?utf-8?B?a3BoSWgyT09TM1pReTl6WThkVHBEbWRBRXgrUFhBcndrSmRZVnJFRlRZaDRp?=
 =?utf-8?B?bVQ3U0pneVlTZnRSYUxjYjd3Y0V1bFl3NmdBVWJKWndlVG9YVngxWUhEY3dM?=
 =?utf-8?B?N2R1SkUrZ3RlRVpsY0h4Q01tbGhRRW10NFpzTkxaWWt3YmxtMmlKcnFrN1ds?=
 =?utf-8?B?SGMxeE0rRHVpREYzRncvSEEveHdQTWgwZ0ZPOUt4M01VUEZnektVMU9GanFm?=
 =?utf-8?B?YnBKbzU4ciswcW9aMytyaTdueko1TGJzbjFENVFmeGxCMEdvdmYxMWxuTTlv?=
 =?utf-8?B?UVIra1NEWXE4REtib3JWVVFrWURVVXFXSTh5YjZpa3J2clBNUkMvU0JnaFEx?=
 =?utf-8?B?RWxWellKYVNBdjYvdzVpMEJ0WFZoczIvZzhxelExeW5mb1g0cm9OVmxiZW93?=
 =?utf-8?B?V2tzT0lFRWlZcmZ0d25INGZ0bGRQN2hNcnNDM0VXN09tRnpPR3dqTWRYMkxP?=
 =?utf-8?B?QkpvTk8yUTQyNGd4elVYS2grZEw5elhGT3BwUmZTZDNnVmgwSHM1UUxkSjd2?=
 =?utf-8?B?M2xIVitxdlpLT0FhZzNaM3RjMVR3MjlKZXZWR25oOW84RG1zazVRaWt3NWRZ?=
 =?utf-8?B?VER5Y0I2aXkybDRQNWR6WU54ZGY1QnZkNDBzOHI3M1IrcTNMczRBeGdHL1Iw?=
 =?utf-8?B?M0xOS3dYc1kvYmUrNmtBc1kxTzBtVnhNQ3RydGNIb28vOCtsVFNWRU1TQXdF?=
 =?utf-8?B?T0NrWU9xMGdNcko4WmxxVFgwazFJQUlQQTl4V1V2alNiN1IwOFNnd2N1dE5s?=
 =?utf-8?B?YWRpSFlIWnhzYTZWanlPZEgwamZhb1NEMS9uMEJXZzBSR1l5L2F0eUZlOXVp?=
 =?utf-8?B?TXBteU5CcmJma0tqOG4yeWlSeE9tSzYvbTQ3TGE2R3RiNnNURUxzN1Q3eUty?=
 =?utf-8?B?RmFwcW13dktJSGpucTR5cnhqZTd6bEJ3ODZkaWhpQXR6SkJWZzMyV0gvejNY?=
 =?utf-8?B?S0gySVpjWThlSVpQV0NBQVVCSlRNeElYUzhicDhnVUxzZm9IL1N6bjViRXZE?=
 =?utf-8?B?c2w1V0NYSHc2S0wrNFVWS293YUpoQUwvaVZKdldPK0xjeGp6TWxjRGp3NFhx?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D836371E9BFDFD4AABE99EB01E3A3F81@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853f608e-95b0-426b-cd74-08dc634f37ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 04:38:26.9528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcYS3xm4DlQ0T0gtDRYkIyKOqkkTiMsu+fQtTQh5oZK+DzFq5NlDoKQzDSqFqnWujHwnS5b5VgU/1t4M4MkyahUH6wf8DLSRd9eINVPgKWu+R44KTyCHvVn7I8w6weoE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6887

SGkgQW5kcmV3LA0KDQpPbiAyMy8wNC8yNCA1OjE4IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKy8qKg0KPj4gKyAqIG9h
X3RjNl93cml0ZV9yZWdpc3RlcnMgLSBmdW5jdGlvbiBmb3Igd3JpdGluZyBtdWx0aXBsZSBjb25z
ZWN1dGl2ZSByZWdpc3RlcnMuDQo+PiArICogQHRjNjogb2FfdGM2IHN0cnVjdC4NCj4+ICsgKiBA
YWRkcmVzczogYWRkcmVzcyBvZiB0aGUgZmlyc3QgcmVnaXN0ZXIgdG8gYmUgd3JpdHRlbiBpbiB0
aGUgTUFDLVBIWS4NCj4+ICsgKiBAdmFsdWU6IHZhbHVlcyB0byBiZSB3cml0dGVuIGZyb20gdGhl
IHN0YXJ0aW5nIHJlZ2lzdGVyIGFkZHJlc3MgQGFkZHJlc3MuDQo+PiArICogQGxlbmd0aDogbnVt
YmVyIG9mIGNvbnNlY3V0aXZlIHJlZ2lzdGVycyB0byBiZSB3cml0dGVuIGZyb20gQGFkZHJlc3Mu
DQo+PiArICoNCj4+ICsgKiBNYXhpbXVtIG9mIDEyOCBjb25zZWN1dGl2ZSByZWdpc3RlcnMgY2Fu
IGJlIHdyaXR0ZW4gc3RhcnRpbmcgYXQgQGFkZHJlc3MuDQo+PiArICoNCj4+ICsgKiBSZXR1cm5z
IDAgb24gc3VjY2VzcyBvdGhlcndpc2UgZmFpbGVkLg0KPj4gKyAqLw0KPiANCk9LLiBJbiB0aGlz
IGNhc2Uga2VybmVsLWRvYyB0b29sIHRha2VzIGl0IGFzICoqRGVzY3JpcHRpb24qKiB0aGF0J3Mg
d2h5IA0KZGlkbid0IGNvbXBsYWludCBhbnkgZXJyb3Igd2hlbiBJIHJ1biB0aGUgYmVsb3cgY29t
bWFuZCwNCg0KJCBzY3JpcHRzL2tlcm5lbC1kb2MgLXYgLW5vbmUgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvb2FfdGM2LmMNCg0KZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmM6MzEzOiBpbmZvOiBT
Y2FubmluZyBkb2MgZm9yIGZ1bmN0aW9uIA0Kb2FfdGM2X3JlYWRfcmVnaXN0ZXJzDQpkcml2ZXJz
L25ldC9ldGhlcm5ldC9vYV90YzYuYzozNDM6IGluZm86IFNjYW5uaW5nIGRvYyBmb3IgZnVuY3Rp
b24gDQpvYV90YzZfcmVhZF9yZWdpc3Rlcg0KZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmM6
MzU3OiBpbmZvOiBTY2FubmluZyBkb2MgZm9yIGZ1bmN0aW9uIA0Kb2FfdGM2X3dyaXRlX3JlZ2lz
dGVycw0KZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmM6Mzg3OiBpbmZvOiBTY2FubmluZyBk
b2MgZm9yIGZ1bmN0aW9uIA0Kb2FfdGM2X3dyaXRlX3JlZ2lzdGVyDQpkcml2ZXJzL25ldC9ldGhl
cm5ldC9vYV90YzYuYzoxMTU0OiBpbmZvOiBTY2FubmluZyBkb2MgZm9yIGZ1bmN0aW9uIA0Kb2Ff
dGM2X3N0YXJ0X3htaXQNCmRyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5jOjExODU6IGluZm86
IFNjYW5uaW5nIGRvYyBmb3IgZnVuY3Rpb24gDQpvYV90YzZfaW5pdA0KZHJpdmVycy9uZXQvZXRo
ZXJuZXQvb2FfdGM2LmM6MTMwNjogaW5mbzogU2Nhbm5pbmcgZG9jIGZvciBmdW5jdGlvbiANCm9h
X3RjNl9leGl0DQoNCkdvdCB0aGlzIGluZm8gZnJvbSBiZWxvdyBsaW5rLA0KDQpodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL0RvY3VtZW50YXRpb24vZG9jLWd1
aWRlL2tlcm5lbC1kb2MucnN0I0w1Mw0KDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC9sYXRlc3Qvc291cmNlL0RvY3VtZW50YXRpb24vZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0I0w4
MQ0KDQo+IEkgdGhpbmsgdGhlIHN0YXRpYyBhbmFseXNlciB0b29scyBhcmUgZ2V0dGluZyBtb3Jl
IHBpY2t5LCBhbmQgd2hhdA0KPiAnUmV0dXJuOicgLg0KPiANCj4gaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJu
ZWwtZG9jLnJzdCNMODYNCj4gDQo+IEFsbCB0aGUgZXhhbXBsZXMgdXNlIFJldHVybjoNCk9LLiBU
aGFua3MgZm9yIHRoZSBpbmZvLiBJIHdpbGwgY2hhbmdlIGl0IGFuZCBhbHNvIGluIG90aGVyIEFQ
SXMgYXMgd2VsbCANCmluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkV4Og0KUmV0dXJuOiAwIG9uIHN1
Y2Nlc3Mgb3RoZXJ3aXNlIGZhaWxlZC4NCj4gDQo+IFRoYXQgZG9jdW1lbnQgYWxzbyBzYXlzOg0K
PiANCj4gVGhlIGRvY3VtZW50YXRpb24gZm9ybWF0IGlzIHZlcmlmaWVkIGJ5IHRoZSBrZXJuZWwg
YnVpbGQgd2hlbiBpdCBpcw0KPiByZXF1ZXN0ZWQgdG8gcGVyZm9ybSBleHRyYSBnY2MgY2hlY2tz
OjoNCj4gDQo+ICAgICAgICAgIG1ha2UgVz1uDQpVbmZvcnR1bmF0ZWx5IGl0IGRpZG4ndCBjb21w
bGFpbnQgYW55dGhpbmcgYXMgIlJldHVybnMiIGxpbmUgY29uc2lkZXJlZCANCmFzICoqRGVzY3Jp
cHRpb24qKiBJIGd1ZXNzLg0KPiANCj4gQW5kIGlmIHBhdGNod29yayBjYW4gYXBwbHkgeW91ciBw
YXRjaGVzLCBpdCBhbHNvIGNoZWNrcyBmb3IgcHJvYmxlbXMNCj4gbGlrZSB0aGlzLg0KT0suIElm
IEkgdW5kZXJzdGFuZCB0aGlzIGNvcnJlY3RseSB0aGUgYWJvdmUgY2hhbmdlIHdpbGwgcmVzb2x2
ZSB0aGlzLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICBBbmRyZXcN
Cg0K

