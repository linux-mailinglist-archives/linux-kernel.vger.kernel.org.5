Return-Path: <linux-kernel+bounces-148192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A238A7EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4508D1C20D29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59C13D279;
	Wed, 17 Apr 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CEQAnsDm";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2tInLu0r"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3213C9CD;
	Wed, 17 Apr 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344123; cv=fail; b=ljjQKojPE8pG8V+qG7sZkz+pOUTrmwTgxP4dzTcD6+WqsH7JNc4hwRik3R7bP5/zeO0a3IY4kG6TOYSnmziKmblE0ATI8Mqqgw8umxqgawsuECIQo4GJFp8dc0x+dGdVhknBf654OVTIAezdENEOhHYxqcbMDzSrjA2GhZViU3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344123; c=relaxed/simple;
	bh=JDWfcynaD4xRnfCjRkP08kKzwOrYSmJ2B1ubivSWxzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f0Cd6Mv/YcUqgz8WHqnaWWhpGleLGHUgvPR/aSmD6EQQ8FHmQ52/NYKmp7Vr6P668taYkwKQbyVkCPTnMn4V6wBCrOD2VmDA+zrwhZvs0wAYIfUG7mB7l8gFV20PrQS3w+TwTuc0QA55yIM2+CXdKzxh75HiV3aHVZwSrfcEejY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CEQAnsDm; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2tInLu0r; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713344121; x=1744880121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JDWfcynaD4xRnfCjRkP08kKzwOrYSmJ2B1ubivSWxzI=;
  b=CEQAnsDmtNibJgUikPJ0BqSnUJwSFa/19Ad6xL+Mseiz0udDKGk6+aD9
   k57Sh1K0KS4nOGaY20z4jJu/psLLCk1Xb8F2OqzWwnsHkeao2iaWMXjGF
   evXz5CIICJh8qce/wW/bEGHAA1zzZ5LkRoF/TqCXfIH8fz86ApjEZnOxj
   K9pe1SMVz80IGzwfKBO1Gw1i1NEufdmJwChjAdfKw3OhSU2XbzHaiYbcU
   Lld02CYlzuUdg1pBKwkeFOPQWcyV/z0253lT11rmAYqUaesMfcW7ksuxG
   /TZBpr3Oer+i4FNiRgjSmsJxwfkyPT2MELt3PPVbmxwO8UBzfYcbQIu5c
   A==;
X-CSE-ConnectionGUID: rfPXvNJOShSxHQwTNJQ11A==
X-CSE-MsgGUID: hJcTg4PPR6GKD0Or4Sfa0Q==
X-IronPort-AV: E=Sophos;i="6.07,208,1708412400"; 
   d="scan'208";a="252215901"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2024 01:55:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 01:55:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 01:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoByORp6W2cIfWuWYhYe+hNjUAf/nexi3g0H4XuQiUzQ9rcrwdv3fM4PpN7iVf7oWE8hRZelXORh/iRgkzLZKepaQd+dzxWKiY2mJZTqYnUItjFg+ok4VcXXEhtgMjlpUVfN9QnTiEsQ142NL9u+5ASH9SEE5YNuCQtrI1PGk5TbrtiYd5lYM3TJYv4TcFheKRetvLUPfLqQUxmJZV8xXZB7cWDmgZoYzWSBYnzx9eusInt3PqNeOlvyNH/p2g47a20umB0rFP2bagGb4KGXK7CPacLXdCXT54JnkoAACRzhbuHGg4ju9fz6XxJC1MAfZJk755O49Ftz0ghzjZFHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDWfcynaD4xRnfCjRkP08kKzwOrYSmJ2B1ubivSWxzI=;
 b=nhma7Xd2SevlQGaCKMxe4xZ/cVO8JNAumS8AQl98KYXmJ8YJch34lM75JcBB0TOzpYFmxkCyn2z9nsQTxqWOsoWaHrtATGVZ/8QI6qiyPtieqrmS4eSlHNWTnfMTBp9Cca1131ahS+pUpXF6F7x6CPLbr+XE9aHPiTX1j5TQ8O4iyTdL/Dsy6p+nrTTqUsEAkHPvlSVoqKTI9GMc+e2qrmpnZpaRLG9wEQwv/5BG9PVuN1a/Mbu7aw7AdoJ22tdGklq/sdKP8Mirl8jwZdIVG4WqX0y/LT2w4CfGPbpJzVIdqc97IU83v1wqoSZeo/LxNv2dr1d3YxiL6H5g4qfMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDWfcynaD4xRnfCjRkP08kKzwOrYSmJ2B1ubivSWxzI=;
 b=2tInLu0rt1BWYAnuXq5PMlCfoGx8u+HyNffNCAYC5OxoasN+XiXClocQGIILa+4wxYTmSED909s+l7/pakH8I6IcY0b/AI/DlN+bCCVXdtN4rIdRyGkTz3+7VNK+/NxURJafS4RA0EYigB1b+XuptY2b8VS05TsfAPNZU/TbYQa9uXG4UuT38wEqzHePuaY/317xf8Zqd25ndvpg8ZEOeJRm9ZFqrod2fZpR4fOZtiq0+enYUnmbcYL9Rh2INU00FBOCIq1k5bcHZurEqzqyQfo63UmboW5vY6T51DQl+k2VaiM6Vono7A3R0bztQ0SzBVzECzE01vv66v85X2UErg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 08:55:01 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 08:55:01 +0000
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
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Topic: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Index: AQHab6OHj5kLkYW7WEGlK1Xe+8KWTLEregYAgADhwoCAACAwgIABRrCAgAAYZQCAD4ziAIAnRUiAgAThfYCAAW1PAIAAebiAgAD064A=
Date: Wed, 17 Apr 2024 08:55:01 +0000
Message-ID: <c2012ac6-d12f-4c87-90bc-a89c4557a2e9@microchip.com>
References: <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
 <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
 <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
 <e9bc573e-61f0-484a-b1fb-b5100eb9ee0a@microchip.com>
 <8de7a4bb-a127-4771-97dd-038f08fcce9d@lunn.ch>
 <372a45c3-1372-4956-8d42-8e989f86d131@microchip.com>
 <ee5dcd07-7c44-4317-9d62-0fc68565988a@microchip.com>
 <3fc3b5c3-0750-4aff-ab26-240f4bc55236@lunn.ch>
 <5100ab9d-1b70-46fb-b3ba-d4bcff6d6870@microchip.com>
 <af6d3a74-7e7b-4953-bba7-f9ceb26df2d3@lunn.ch>
In-Reply-To: <af6d3a74-7e7b-4953-bba7-f9ceb26df2d3@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH3PR11MB7372:EE_
x-ms-office365-filtering-correlation-id: 0feb1be0-5fa5-48d5-9b00-08dc5ebc1121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFuOmYonKaafCJKfdKHvcjNVGiYDYxBdglf5l/oR/1lbgv8X93cgDOUJ0p2t2MgIAP/CcRK1HRm/AIu7FOul83OfjweqKqU7vT4DID2qs53BYmMz4N+aNLwP5/Clmx3KS3BFIGr+4CxDhm6kG5B9plP7PEga4YmbzBrSDZkhes8Xt+lCLghDxARtzrgb0QTQKVdGKdKlK8fJNZbXknSrIYpuL1tJ4I3cKg/tnl4VgODDKU8Zpxpl45OI5hFV/Dg/8pTfirUcQ/XLd5V0ABKl8AqbdNnEPFMyom6Ue0Y3ES7+e8keB2NxAUYXlUdMVm0ALNRu1o64sPmwv84SrP51iM9twGdcaqRfUvoF+7IaTFaBZ5fvYoXMJHuofDjyHHHIIW3Z/Tw+56SymNLE4AmSoGwLibsgC9SOLW9W83pYoP/wJbgMrQ+3JrUWM/gMNrNjvrEXpSKJ9IDB0KS06vtvFjrnQycU+xq7p+eJI2IEkE4mENc0qx1A/cH2TZSiyrT1QvvSWvxAhzf2VH8jigLnOuC91rNA+8OrJfIP0LlGHu+HdmBrAy/nZyl5NSz2th/UYsb0WZF3Ra8QNypm+u6lOrdxEN6doOGR1v61QCDbQwLJqxlZPRCTCvGpF6eKsCHt3EcP3S6gtCPeC+AjNzohBTZA9UbM088UH2tS+6zi3/KLeCnk33efQLrn++t11BS/Pc1DWdIIFKYZQB0vwNdkk8pQwTYKsErk+GjbBWqGW0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjJZcm9CUURPL0pra1h6MTdHYXNpS3p4RzFLSnpDY3hqNmI5QUV4cU1xbjJi?=
 =?utf-8?B?eC9SNkFqdkZ1bUd2QTVHWGRVc0U4NGxPT1dFVnpyYXB0NEoxejJUZ1oxL0Rp?=
 =?utf-8?B?ekhSYmQvcnFZaVlSYWtnUVFMVVJrS1BQMXBsbGVZeWUrb3l3UVVBTnY0bFA1?=
 =?utf-8?B?SnE3L1JFVXBEOHcvaEJ2eHdxM2hJeWwrRG9MLzBOV3FmZzhISnNFNnIxc2Zj?=
 =?utf-8?B?SStjbmlwS2RmaWZaZ3lmVENVS1FUcE5UVUNta1Z6L2xHd3VJOEtDeXd0WDZu?=
 =?utf-8?B?Zyt6UmpjTC93a0ZpYTNQWUQyVDR4VWVmTzBlQ0hMK2hrZDY5c1FnTStxVnpy?=
 =?utf-8?B?a2t1Qi8vcmdKNzJGOW51Vzg3aFNzaWFYQ3hrQk9aZkhDbytPOW04b2YzVEll?=
 =?utf-8?B?S2RETkxZYjVoUkxDQWx0VEVpeEh1M0t4R3JjK0kyWCtXVHYrbThGMmpJc0o3?=
 =?utf-8?B?Z2hFb0tGM2YwSHArOXllLytqZzE5ZUlpNi9KUUpyRS9TS21rU0dFTmNjSDVv?=
 =?utf-8?B?eDhGeDgxR1pKNTRSRStvdStXb2NLQUlsU29CK2VZVDN1ZS9ubGkxRys5T0RG?=
 =?utf-8?B?RFZUSys1QUpKcExGUFZqR2YzcHZOMDVycUZaZ004VWpTOHJKUnhYZW1hN2Vq?=
 =?utf-8?B?WU9hdDh2WmdjdGN2KzQxdE9neS9XcG1GOHRxUk1OQmNBdkNhTXFrdC8zVUpB?=
 =?utf-8?B?OXR4dGF3QXdTK203c3BkL21wV3o3SlNWNGlXM1JBSHJVVDFIdjZFS3NoL1RX?=
 =?utf-8?B?amt5RDZlN0NFTFNUTks5b0NUQytCTWFtVXNnZlQzNitKU1NCZkpPYWVuQmVO?=
 =?utf-8?B?NjVDWm5iSXptMmJVeTRoRVRRU0g0dStqVmR4Vk9rYjRwY0pnbVRvdnZpMnVk?=
 =?utf-8?B?VHhDNWJNN1dqdGhtTld5eGZKVnRYOXR2MFY3Yjh0K3RhenlYUktlZ21zYVFH?=
 =?utf-8?B?Z1IvQmFZdlcyRklIMkdNWmYzZWNsQVUxUXBzZ2lRbXVVaDcrRGxLdXcvZlM0?=
 =?utf-8?B?c25VeXU4a0lxYSt2cU1XOG1Eam1Qd29aa3ZZOFgySHloVHNrRjM2R2lMamNZ?=
 =?utf-8?B?SWpZNE9uU3g4QmxQYUl6NkcybFNwSEVaT3JUNnZQL1BWZWw4VFRPbkE1c2xT?=
 =?utf-8?B?VTZqcDRHV0JFMXk0ZU1DU2lOYlZjdHYzQzZZcWY0K1h4KzY5RzlXNmpxVjJh?=
 =?utf-8?B?bGRyY3NaOThKTWhycCsxVmdjS0tIcUdrb0JLbDVkenlzM1dRdWxlWWJmSW1n?=
 =?utf-8?B?V0NMZWNLbG9WdDkvazlZWmovZDVoUXBGbmxtRHUwT2hIdWE4UVFKWmdKRGZ6?=
 =?utf-8?B?VHJKcFFvL04xaThFQ2pEeGp0TUM2RzZDdEE2MFRSRW9zeWRqVTNuOTZzYmxO?=
 =?utf-8?B?Uy9EazNkRlU1YVhXWlBMRHlHbHpmRk0xUWVvSzBSdEVtUmd6TDAxRCtnYkFY?=
 =?utf-8?B?K1M1QmxjcG84YXozQkFnNHluSU50cEcvb2g2MjZqd2lHVVd1ZzVYUmpvaWFa?=
 =?utf-8?B?eU80RnQ1NTIzeGhpRGtReTkvdWlmd0tLY3hncDVYVWhZZFNJbnFQcWd2THpq?=
 =?utf-8?B?L1IrdWJSRHR2MmtQd0c5T1dhdVh4akd1aUZkbGlLSzJmUjBoOUlBcXUxVlpW?=
 =?utf-8?B?Ri9ud3hUblpoNHVLOVNZMUhGZS9WTmxvMFR0aENxQmMwTzlEbEJHS2F1NHVV?=
 =?utf-8?B?Y3E1U2p6UFEzd2xYVjdyQnNWeUtCZFllT1dwNWliLzlQaXh5Q1R0b1BzYzJE?=
 =?utf-8?B?QjZ6M3E2M3IrczBqTGRSR29JdzV6eEZ6VFQ2TlZ5VFJ2enVVYjdaTEdKQkpF?=
 =?utf-8?B?M2lqTEZLMXkzSlFjY1Z4RnB1Y1RvSDF2aXhHOVpGaWVrSGs4dnlTeDFoN3RM?=
 =?utf-8?B?N2tkdWFya2NYb1BrRktpdjJ3NEZsSFJCT1lNcnEwcThoTlZvWDlmdG5TVzJw?=
 =?utf-8?B?WHY2TzJaQWV1c29EWEVRZ2l6STVrbFh1bzJpemFhL2dvZUdrQUNMMG9uNzBr?=
 =?utf-8?B?Tkt1ZzE3S0FuK2hVUkc0ZlFMV0U0dHdvSW5xT1pnYk1NU1hTRjNOaFNYbk5F?=
 =?utf-8?B?K0ZNZ1IraDRXa1BqMjlzRmhnYmowMzV1NVplR2JrVkJuSnlQWHUraHpmbmtE?=
 =?utf-8?B?VkE0b0RDRGY5ZUlFM1JQL0lKNWg1RWdMUUxwLzYxTmthNytNOXRTM0pEMjVx?=
 =?utf-8?Q?dJK3j+/fOD8BWZW8QR42Elc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5B568EAC7EEB459E6DCBCC89CF621B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0feb1be0-5fa5-48d5-9b00-08dc5ebc1121
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 08:55:01.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rIb/tZHeB1yEyVDQPh+IcYbfD5Sv3ja9CaP79V7lNvIPSQOiKxvGqX+M0ohW3rwSN3eYUEAs6/du1IJJp2zb1k5V0pW7y3inruOlBT2hz5WfvaPVoTr31M/qsamhTnH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372

SGkgQW5kcmV3LA0KDQpPbiAxNi8wNC8yNCAxMTo0OCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEkgdHJpZWQgdGhpcyBh
cHByb2FjaCBhbmQgaXQgd29ya3MgYXMgZXhwZWN0ZWQuIE1lYW5zIHdoZW5ldmVyIHRoZXJlIGlz
DQo+PiBhIGM0NSByZWdpc3RlciBhY2Nlc3MsIGl0IGRpcmVjdGx5IHVzZXMgdGhlDQo+PiBvYV90
YzZfcmVhZF9jNDUoKS9vYV90YzZfd3JpdGVfYzQ1KCkgZnVuY3Rpb25zLiBIZXJld2l0aCBJIGhh
dmUgYXR0YWNoZWQNCj4+IHRoZSBwYXRjaA0KPj4gKHY0LTAwMDYtbmV0LWV0aGVybmV0LW9hX3Rj
Ni1pbXBsZW1lbnQtaW50ZXJuYWwtUEhZLWluaXRpYS5wYXRjaCkgd2hpY2gNCj4+IGhhcyB0aGlz
IG5ldyBpbXBsZW1lbnRhdGlvbiBmb3IgeW91ciByZWZlcmVuY2UuIElzIHRoaXMgeW91IGV4cGVj
dGVkPw0KPj4gQ2FuIHlvdSBjb21tZW50IG9uIHRoaXM/DQo+IA0KPiBQbGVhc2UganVzdCBwb3N0
IGEgbmV3IHBhdGNoIHNlcmllcy4gSSB3aWxsIHRoZW4gcmV2aWV3IGl0IGp1c3QgbGlrZQ0KPiBv
dGhlciBwYXRjaGVzLiBJdHMgTy5LLiB0byBzZW5kIHBhdGNoIHNlcmllcyBmcmVxdWVudGx5LCBu
b3QganVzdCBtb3JlDQo+IHRoYW4gb25lIHBlciBkYXkuDQo+IA0KU3VyZSwgdGhlbiBJIHdpbGwg
c2VuZCB2NCBwYXRjaCBzZXJpZXMgd2l0aCB0aGlzIGNoYW5nZXMgYXMgd2VsbCBzb29uIA0KZm9y
IHRoZSByZXZpZXcuDQo+PiBJIHRyaWVkIHRoaXMgYXBwcm9hY2ggYnkgc2V0dGluZyB1cCBpc19j
NDUgZmxhZyB3aGVuIEkgdXNlDQo+PiBwaHlfcmVhZF9tbWQoKSBmdW5jdGlvbiBidXQgZW5kZWQg
dXAgd2l0aCB0aGUga2VybmVsIGNhbGwgdHJhY2UNCj4+IChjNDVfa2VybmVsX2NhbGxfdHJhY2Uu
cG5nKSBhdHRhY2hlZCBoZXJlIGZvciB5b3VyIHJlZmVyZW5jZS4NCj4gDQo+IFBsZWFzZSBwb3N0
IHBsYWluIEFTQ0lJLiBJIGFzc3VtZSB5b3UgaGF2ZSBhIHNlcmlhbCBwb3J0LCBzbyB5b3UNCj4g
c2hvdWxkIGJlIGFibGUgdG8gY2FwdHVyZSBpdC4gSSdtIG5vdCB0b28gc3VycHJpc2VkIHRob3Vn
aCwgbm8gb3RoZXINCj4gZHJpdmVyIHBsYXlzIHdpdGggaXNfYzQ1Lg0KTy5LLiBQbGVhc2UgZmlu
ZCB0aGUgYmVsb3cga2VybmVsIHRyYWNlLA0KDQpbMTU4OTAuMTI3NTI1XSAtLS0tLS0tLS0tLS1b
IGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NClsxNTg5MC4xMjc1NDBdIHBoeV9zdGFydF9hbmVnKzB4
MC8weDU4OiByZXR1cm5lZDogLTIyDQpbMTU4OTAuMTI3NTkyXSBXQVJOSU5HOiBDUFU6IDAgUElE
OiAzOTM3IGF0IGRyaXZlcnMvbmV0L3BoeS9waHkuYzoxMjMzIA0KcGh5X3N0YXRlX21hY2hpbmUr
MHhhYy8weDJmMA0KWzE1ODkwLjEyNzYwMl0gTW9kdWxlcyBsaW5rZWQgaW46IGxhbjg2NXhfdDFz
KE8pIG1pY3JvY2hpcF90MXMoTykgcmZjb21tIA0Kc25kX3NlcV9kdW1teSBzbmRfaHJ0aW1lciBz
bmRfc2VxIHNuZF9zZXFfZGV2aWNlIGNtYWMgYWxnaWZfaGFzaCANCmFlc19hcm02NCBhZXNfZ2Vu
ZXJpYyBhbGdpZl9za2NpcGhlciBhZl9hbGcgYm5lcCBicmNtZm1hY193Y2MgaGNpX3VhcnQgDQpi
dGJjbSBibHVldG9vdGggYnJjbWZtYWMgYmluZm10X21pc2MgYmNtMjgzNV92NGwyKEMpIHJwaXZp
ZF9oZXZjKEMpIA0KYmNtMjgzNV9jb2RlYyhDKSBiY20yODM1X2lzcChDKSB2NGwyX21lbTJtZW0g
YnJjbXV0aWwgDQpiY20yODM1X21tYWxfdmNoaXEoQykgdmlkZW9idWYyX3ZtYWxsb2MgdmlkZW9i
dWYyX2RtYV9jb250aWcgY2ZnODAyMTEgDQplY2RoX2dlbmVyaWMgZWNjIHZpZGVvYnVmMl9tZW1v
cHMgdmlkZW9idWYyX3Y0bDIgcmZraWxsIHZpZGVvZGV2IGxpYmFlcyANCnJhc3BiZXJyeXBpX2h3
bW9uIHZpZGVvYnVmMl9jb21tb24gc25kX2JjbTI4MzUoQykgcmFzcGJlcnJ5cGlfZ3Bpb21lbSBt
YyANCnZjX3NtX2NtYShDKSBudm1lbV9ybWVtIGdwaW9fZmFuIHVpb19wZHJ2X2dlbmlycSB1aW8g
aTJjX2RldiBmdXNlIGRtX21vZCANCmlwX3RhYmxlcyB4X3RhYmxlcyBpcHY2IHNwaWRldiB2YzQg
c25kX3NvY19oZG1pX2NvZGVjIGRybV9kaXNwbGF5X2hlbHBlciANCmNlYyBkcm1fZG1hX2hlbHBl
ciB2M2QgZ3B1X3NjaGVkIGRybV9rbXNfaGVscGVyIGRybV9zaG1lbV9oZWxwZXIgZHJtIA0KZHJt
X3BhbmVsX29yaWVudGF0aW9uX3F1aXJrcyBpMmNfYnJjbXN0YiBzbmRfc29jX2NvcmUgc3BpX2Jj
bTI4MzUgDQpzbmRfY29tcHJlc3Mgc25kX3BjbV9kbWFlbmdpbmUgc25kX3BjbSBzbmRfdGltZXIg
c25kIGJhY2tsaWdodCBbbGFzdCANCnVubG9hZGVkOiBtaWNyb2NoaXBfdDFzKE8pXQ0KWzE1ODkw
LjEyNzc1Nl0gQ1BVOiAwIFBJRDogMzkzNyBDb21tOiBrd29ya2VyLzA6MSBUYWludGVkOiBHICAg
ICAgICBXQyBPIA0KICAgICAgIDYuNi4yMCtycHQtcnBpLXY4ICMxICBEZWJpYW4gMTo2LjYuMjAt
MStycHQxDQpbMTU4OTAuMTI3NzYzXSBIYXJkd2FyZSBuYW1lOiBSYXNwYmVycnkgUGkgNCBNb2Rl
bCBCIFJldiAxLjQgKERUKQ0KWzE1ODkwLjEyNzc2N10gV29ya3F1ZXVlOiBldmVudHNfcG93ZXJf
ZWZmaWNpZW50IHBoeV9zdGF0ZV9tYWNoaW5lDQpbMTU4OTAuMTI3NzczXSBwc3RhdGU6IDYwMDAw
MDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyANCkJUWVBFPS0tKQ0KWzE1
ODkwLjEyNzc3OF0gcGMgOiBwaHlfc3RhdGVfbWFjaGluZSsweGFjLzB4MmYwDQpbMTU4OTAuMTI3
NzgzXSBsciA6IHBoeV9zdGF0ZV9tYWNoaW5lKzB4YWMvMHgyZjANClsxNTg5MC4xMjc3ODddIHNw
IDogZmZmZmZmYzA4NmMyYmQ2MA0KWzE1ODkwLjEyNzc5MF0geDI5OiBmZmZmZmZjMDg2YzJiZDYw
IHgyODogMDAwMDAwMDAwMDAwMDAwMCB4Mjc6IA0KMDAwMDAwMDAwMDAwMDAwMA0KWzE1ODkwLjEy
Nzc5OF0geDI2OiBmZmZmZmY4MWZlZjc4MWE4IHgyNTogZmZmZmZmODEwMTkwNjY0MCB4MjQ6IA0K
ZmZmZmZmODEwMDEwY2EwNQ0KWzE1ODkwLjEyNzgwNl0geDIzOiAwMDAwMDAwMGZmZmZmZmVhIHgy
MjogZmZmZmZmODEwM2U0MWM5OCB4MjE6IA0KMDAwMDAwMDAwMDAwMDAwNA0KWzE1ODkwLjEyNzgx
NV0geDIwOiBmZmZmZmY4MTAzZTQxY2YwIHgxOTogZmZmZmZmODEwM2U0MTgwMCB4MTg6IA0KMDAw
MDAwMDBmZmZmZmZmZQ0KWzE1ODkwLjEyNzgyMl0geDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjog
ZmZmZmZmZTczNDZiNWI2MCB4MTU6IA0KZmZmZmZmYzA4NmMyYjk2MA0KWzE1ODkwLjEyNzgzMF0g
eDE0OiAwMDAwMDAwMDAwMDAwMDAwIHgxMzogMzIzMjJkMjAzYTY0NjU2ZSB4MTI6IA0KNzI3NTc0
NjU3MjIwM2EzOA0KWzE1ODkwLjEyNzgzN10geDExOiAzNTc4MzAyZjMwNzgzMDJiIHgxMDogZmZm
ZmZmZTczNWNhMzcwOCB4OSA6IA0KZmZmZmZmZTczNDcwOTQ2Yw0KWzE1ODkwLjEyNzg0NV0geDgg
OiAwMDAwMDAwMGZmZmZlZmZmIHg3IDogZmZmZmZmZTczNWNhMzcwOCB4NiA6IA0KODAwMDAwMDBm
ZmZmZjAwMA0KWzE1ODkwLjEyNzg1Ml0geDUgOiBmZmZmZmY4MWZlZjY3ZDQ4IHg0IDogMDAwMDAw
MDAwMDAwMDAwMCB4MyA6IA0KMDAwMDAwMDAwMDAwMDAyNw0KWzE1ODkwLjEyNzg2MF0geDIgOiAw
MDAwMDAwMDAwMDAwMDAwIHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IA0KZmZmZmZmODEwNWYx
YmQ4MA0KWzE1ODkwLjEyNzg2OF0gQ2FsbCB0cmFjZToNClsxNTg5MC4xMjc4NzJdICBwaHlfc3Rh
dGVfbWFjaGluZSsweGFjLzB4MmYwDQpbMTU4OTAuMTI3ODc4XSAgcHJvY2Vzc19vbmVfd29yaysw
eDE0OC8weDNiOA0KWzE1ODkwLjEyNzg4N10gIHdvcmtlcl90aHJlYWQrMHgzMmMvMHg0NTANClsx
NTg5MC4xMjc4OTNdICBrdGhyZWFkKzB4MTFjLzB4MTI4DQpbMTU4OTAuMTI3OTAyXSAgcmV0X2Zy
b21fZm9yaysweDEwLzB4MjANClsxNTg5MC4xMjc5MDhdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAw
MDAwMDAwMDAgXS0tLQ0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAg
ICBBbmRyZXcNCj4gDQoNCg==

