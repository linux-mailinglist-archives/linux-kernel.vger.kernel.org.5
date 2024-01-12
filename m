Return-Path: <linux-kernel+bounces-24597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F0D82BEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E9B284641
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FFA5FEEC;
	Fri, 12 Jan 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="KEfdKTOA"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2096.outbound.protection.outlook.com [40.107.22.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2858229;
	Fri, 12 Jan 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP6qDeTvTCxSOo8g5xUEngXTFYSfXV2QP3XcLbIa6NSJx90n9HyAKSeDrabyrIJSKUGRo/3xavzydJ1GQztjghvyL9vZhiW+aChz5hZrYyAZiwlXkNydvYL6BCIJ0bUpE4v9eisofv8xvBs7Fx2fAVAIjhSIrazeAwIkVxvayO/i5Wnjum+F9wTlLFT6U3LBysP0N0vZXpEDfoxUM6P4OLpFd3MWa3Lksqi3zUvgHy9vmVZxBjci4IuB3mNNYpis1VfjmfjasHieNZPLfWS633UzLD0iye85INiJyR88EaEjAm/fTpWfGF637BwtUhkvMcblx7E/Wf8gB5vJGFlg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjNy9hwI2wifQ6uk53InenkOSbeV+0t2j83aRfT+KVc=;
 b=dP/g3PmvRmSEn6Sawn80/d/8c1QQVvBXaf4DhIKwqx9wMvn3/YkyAKEc92DRoroh/VzOuJpEVGPQLctjq4qvp24+H2ZFGbv+1HZcgzCl5bVQmwM44mXLpOCgeSNMx1RXB8hYXqaPCHcbSgSClP11A2/DuYth6I/TAbNPbjOyky6RQsAjO4XXFNTv5y7/j8fUOEMqwW+mWFc0S88y1xbnwHwYbkFRuKWN+A2qRQuiwlJ3BXeXkMnuqRI9m2dh/Lwy/ztl0LmDpRpGVHhoc41SA7zCv9noF744QpSqE++glvoPHkvAV37ZYPl0HO2m4+UJLuN81vp0bE96NjlpdlXjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjNy9hwI2wifQ6uk53InenkOSbeV+0t2j83aRfT+KVc=;
 b=KEfdKTOAj5Dm2+7bCADPM2PZzVYmxutkfuHvynv8tg0ltxM5SWC15+JSGEu+RZnYj7Ly0oRIlnxZqH53XtaIHyuJnLDkA42KEk/0SVjT5UFmKuBSN1PVowT6trLa28MTYLiVlijuAscJY714sVPVh4xkzf+r0pnZE9Mo53BMchA=
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com (2603:10a6:10:103::23)
 by DB9PR06MB8910.eurprd06.prod.outlook.com (2603:10a6:10:4c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 10:56:23 +0000
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039]) by DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039%5]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 10:56:23 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Topic: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Index: AQHaRKoS6UQg1dt3TU+QGYO25gfEa7DUzvGAgAAC4gCAAACsAIABMCIA
Date: Fri, 12 Jan 2024 10:56:23 +0000
Message-ID: <70644dde-b759-48a6-9598-6365d0443853@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <c795aa28-b6a2-4db8-b941-05b51b44f1fe@lunn.ch>
 <a4af4a08-6eea-420b-b76f-47f4e836b476@leica-geosystems.com>
 <5f57479b-59e8-458b-a19c-8306fbfe8ff7@lunn.ch>
In-Reply-To: <5f57479b-59e8-458b-a19c-8306fbfe8ff7@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6332:EE_|DB9PR06MB8910:EE_
x-ms-office365-filtering-correlation-id: 4243b63a-3868-42c0-d741-08dc135d1e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 P9eL9pDp2BCJI3R3tyo1q2FS/kWf8mIKRgBszy5Wg2DE6h4RHNxA8s6qxl3m4LsTET1qmoxcmYNmveA0IECI3MwmhBwBlT2PMuj5MAwAmH3mfxIXbPaA53UspDZMOTM3YeVxL0vLA/wfNdnt+CTaotGJ1G6NwEJZnvYFc1WbG7UrOEjaq0hUv/0bTLv8daemBSziFqGBODzhNOWRXfo0cMx5lk9mQe6oHUjdupi8EfS44ZZ6xsROTkcoB5EJYh2XGJg4NFSaEFD48em5MvklJk970rqbY6aIB7p8Sdugnrab301UwPxtuAHB1/Mxta1JYRwNkSD0SD3YGKHfJk0RbIE05cvjHHD8JSA3JD/OP7ZwVXOOIrAabTfKlk8kd04A0/IOGQMx6GBJfmPor/+gBl1Ccj0PvuL9nXw6Z4o0B6oDKFStzWCQTox2Yd6Pi7yiZ2yDqD9JKCLGjMBGd+hlj3KhO7Mjq3uM/kfScSB5S1EdYviA+NkHTCkfPgZJyPVLIur1A6QHjv3ANhipBCJRbKmUdctg2xmIwE3/pbmgsFdtzExXVOqGlmRCKAonrb0i8zeMk2PcIpqpj3235wWc3FMfYQmpaw+/05zWBKTFLhNVusws6AgXV5ObQjY8Zfk98x+CR2T30/prMrMGDsIEfg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6332.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6486002)(6512007)(6506007)(26005)(53546011)(2616005)(71200400001)(36756003)(107886003)(38100700002)(86362001)(122000001)(31696002)(38070700009)(41300700001)(478600001)(4326008)(8676002)(8936002)(5660300002)(31686004)(4744005)(7416002)(2906002)(45080400002)(91956017)(316002)(6916009)(64756008)(54906003)(66446008)(66556008)(66476007)(76116006)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2xzWlZ4L3QrRHBFM0tuaTIzQnVZbEZXYWpDdW9Jd1pQbkx3ekxiM1pwSTEx?=
 =?utf-8?B?ZGpraVdTYmFCV2t4S2hkQWpnK3ZjM3g0RGgydGhPUHM4aldrS3hDUzN5M2xV?=
 =?utf-8?B?ZE9TMjFaUnF1RTJNT3RwK09OeWZNaTJFVExpdXRqT3V1MTBOUGFIa0hWVHNE?=
 =?utf-8?B?djVHR2xBdXVEc05rdjZ2RlRHL2FyUXZaUjZuN3RZcEkwN0tBSjIyWlJxRnNG?=
 =?utf-8?B?R0NUT0RXWnlaVjJmY0M5MGs4bk1jMnJLMzhvdHdhbCtOQ3JabEIvajJOYXZm?=
 =?utf-8?B?MFVvanJnOUptdXFpY1krSVlHWk0yc0R0UXpOSnNZNlBoNTlKeG5HTEpFTmN3?=
 =?utf-8?B?SlEzc0NhQlk0bDZMRzZmekpUdHRRYUtKeFBPTzdNM3RpN0JzdTV4YlFpL2RJ?=
 =?utf-8?B?RE5KRWprT0syQVVPN2tKd3Zkbmowc1lGdWhGNGVNTjgwUDcySFpGcGNVOURQ?=
 =?utf-8?B?TFd4TGhwZ1E5LzlIbVp0c0tOdncrU2lEUlBETXZjZzI3VjljTjkyVEVKbkY2?=
 =?utf-8?B?cElLNjdheXFxZ1puR3NJYmhUTXR6VWdpTGJCUUFiaFc5cGd4M01tUzJKVHJy?=
 =?utf-8?B?eWxzbW9IaUYwSHBlVTd1WEtDNXlMUWJ0ZUorUmJ0MmV3cm1UMUEyT3FUbVBi?=
 =?utf-8?B?a0cwR01pNW9TcTkrQWpKTDlXclJ6QXNIVDFkaHBsWWxOZXZUd1RLQUN5c2sr?=
 =?utf-8?B?OTJzYmJieWVIZmtKd1ZtR2k3Y2doV25BbGpCTlliT1ljWXFpdmJJa2RJdmpI?=
 =?utf-8?B?dUw1em9sSXVKOCtBdWhZaDA5d0ttY05GS21CempxQ0hVUE5Ca1huZmtZQVJa?=
 =?utf-8?B?N1dUQTB3cC9hRVk3UFpkT096WUJ6ejROaWNHSkZLVUlacHN6MkJvOGZ0NGlt?=
 =?utf-8?B?UjduSlpVbC83L2pQcUpIbHk2c2EwdUFyQzZYSkRDOVN5ZmNBVlpPc3gvWlRN?=
 =?utf-8?B?Nyt0UkJCQytHR1pFUko3THlGcHg5cXhpazFsRkpEVE5OcWtEdnVaUEJaUmF4?=
 =?utf-8?B?cTJYYjA3NXZhRkxoSmNya29hZ1RnY2FoZ3FxUm93RS9NNDd6bno1UnNHNWRj?=
 =?utf-8?B?WXYzS1Y1amNGdHNxd24yaWZGZkthVUpUcnJEZ1AzZE1DRFh0dUNtUDlKYUxL?=
 =?utf-8?B?ZVdJUW1vUFZxUEc3bWZMRUVWSWVDaUw3eVZKWlhUUjY5SXF3ZnY2MHYyeXRn?=
 =?utf-8?B?UjVHTXc0OGVwNHUzRTduSFNOQjBMVVloanhmYWxVTFJ4NGZHaFpZMmNMNGdQ?=
 =?utf-8?B?VDd3WCt4QzVDWW9qMVhmbXNjUDJhazZ0RURFblB1S0FydE9nL0d0RDJqelNS?=
 =?utf-8?B?MEh0aEt5K1N0WkFDRkRrczBnbWduR292c1hXUnJrOU9PQ3FUSHNQL2YxVTY3?=
 =?utf-8?B?ZGtLVlFsUVhxU1I2RzZuTzlabGxRc2h2QWcwRklUN0JXVXNuSFlCaUE3amI3?=
 =?utf-8?B?eUJqTittUXZRVEkvUDJSK0N3WGZmd2IwWmpqMW13RFhFSjBwMGZDQlJGRWd3?=
 =?utf-8?B?MGlscFBmSVhqM0NLNVFxaW5SNWZMaEowYXlFQ0pTQTJQZ3dLM1BQdEhFdlhr?=
 =?utf-8?B?SEYrTkUzZ2VLbVJyVUtlUkY4aFIyVkZSM0hrZzJ5cHN0V3IxblQ2SVdDWkVo?=
 =?utf-8?B?UVpkQm1EZTY0Vk13SE16MEV6bGZJUGR5Sit4SGUwb1RNaVJuQXBLUm4rY1F1?=
 =?utf-8?B?MU95S3RtajF2RVRCYy9XZ0VuNlNWQVhGckN3YnQyRGNrSGN0NTlsb2VKaU9q?=
 =?utf-8?B?L3lpVTdCaE5wZEZnbkpyWDFHNGJpMXVGWUFPSDFWL0dRZmVLSm53L0RhL05t?=
 =?utf-8?B?UDJZQVZHWkhkNDMvK0o4N28yM09iakxCanoyZGN3cFRJQXJtQUwxZHV2OEFy?=
 =?utf-8?B?VVpHeGVyU3BBWUh2eXlEa3Q2a3Y4Q3RDaWpLQlhIS21ZK09ZdDNvTEFmWTJJ?=
 =?utf-8?B?Y0NFTXdCVi8ycW96WEN3M01wOGU2Um9WS2wzUmhwVHBuRTBZaVhxekF5eG5X?=
 =?utf-8?B?ZVVaYkRDaTNETWZqTktHSEFiQVJTR3crVW1VUDloc1dqdHhWOVBWSmpXYjNt?=
 =?utf-8?B?SVdYQ2s3UHYrMWxoYVpyOEtnZlF4VUZFZkdrNTdiNU5UUUhkODZ3dmZuNURF?=
 =?utf-8?B?ODk1aUZxU2FJN1luU3d2ZVAxMm0yNWU2MHEvYk0xUTB1WEZ4Mk1ZNXY4cnE5?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AA3D9B7A42D994799C0A245553198AA@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6332.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4243b63a-3868-42c0-d741-08dc135d1e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 10:56:23.7028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iA6sSVGOzxywDqj4e3tpKUE50nOGiUy5VKXwSuru0k15FKlssQTGa339SRY2hHlGDGZ4Nkq06PVGaJVvQJunF+c1cW/1td7p5nXEanUv6MGPOWBUwQFYB6kZdoXFqPYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8910

T24gMTEuMDEuMjQgMTc6NDcsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBUaGlzIGVtYWlsIGlzIG5v
dCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJlZnVs
IHdoaWxlIGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWluZyB0
byB0aGlzIGVtYWlsLg0KPg0KPg0KPj4gVGhlc2UgYXJlIG5vdCByYXcgcmVnaXN0ZXIgdmFsdWVz
IGFuZCB0aGVzZSBhcmUgbm90IHZvbHRhZ2UgdmFsdWVzIGJ1dA0KPj4gdm9sdGFnZSByYXRpb3Mu
IEknbSBtYXBwaW5nIHRoZSB2b2x0YWdlIHJhdGlvcyB0byBlbnVtIHZhbHVlcyBbMC0xNl0NCj4+
IHdoaWNoIGFyZSBjb252ZXJ0ZWQgdG8gcmVnaXN0ZXIgcmF3IHZhbHVlcyBieSB0aGUgZHJpdmVy
LiBJIGRvbid0IHNlZSBhDQo+PiBiZXR0ZXIgd2F5IHRvIGRvIHRoaXMuDQo+IEkgYXNzdW1lIDgw
Mi4zIHN0YXRlcyB3aGF0IHRoZSBhY3R1YWwgdm9sdGFnZSBzaG91bGQgYmU/IFNvIHlvdSBjYW4N
Cj4gY2FsY3VsYXRlIHdoYXQgNTAlIG9mIHRoYXQgaXM/DQo+DQo+ICAgICAgICAgICAgQW5kcmV3
DQpUaGUgYWN0dWFsIHZvbHRhZ2UgZGVwZW5kcyBvbiB0aGUgbW9kZSAoSSBrbm93IHRoYXQgZm9y
IDEwMEJBU0UtVFggYW5kIA0KTUxULTMgaXQncyArLy0xVikgOiBpdCBtYWtlcyBubyBzZW5zZSB0
byB0cnkgdG8gY29kZSB0aGUgYWN0dWFsIHZvbHRhZ2UsIA0Kd2UgbmVlZCB0byBrZWVwIHZvbHRh
Z2UgcmF0aW8gaGVyZS4NCg0KDQo=

