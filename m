Return-Path: <linux-kernel+bounces-57710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFAB84DCA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7B82885EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486D46BFA1;
	Thu,  8 Feb 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="MbuUphje"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2067C45;
	Thu,  8 Feb 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383989; cv=fail; b=Zf3aa9UVmziPl0muKwVgZmj0EgD3VyG6gWh8KDeY1GHwDCsnCF4BYImJ02IUmxUr4gFnB3KmRHY2nESm1xlYcJXS5fD2UiAPLj6M10ziXnMm4dBXIXT3jjZuIhOhT/2X0UbPUMg5OrG/na+yeOJKoKsYd+hVTSR7WgETdnfLIII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383989; c=relaxed/simple;
	bh=NyDhb2sIAlXq9TmI1vxtbGcisVzy4vBVbRWKoCnojZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gLLbbhQCVaPaIwFdh7v/3jMOzqSxiBM9+7xZ44uZ4eC6b5oYRz5yD6BwfMVcJg9O15ZIDq/0ChMBfIEwTPZkqHFSJ2mXD2yoIHWQqzhwPOerWWDZ/lA0atrp4cj6fXnfIL0uCSguqoojv3E2ZYaDgjKp88QykCoHvGdMPXRySS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=MbuUphje; arc=fail smtp.client-ip=40.107.15.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD9q9CMbWCyhQzHBL84JbGph7atXD378yA4B/ERLNtHNQfsKrRL3CGPBn2JfCUHTD7IQmlj6PR9Ab+43i7ovIQdCiKuh3bcJtyMhLZmP2ohK0K84WPu9Nbq8ENgeNNYdHTmebOhk0KMhhSk7P0sB0QxBv02AAD330NwCF/GU+ik//ChehG1y+eHjSgNRuzreu91neY7FFfpKcsnGpSq1lFzGHJKxY3jvahZ/8XoB4+JSAgHQgeWTxMBX1JeK9bZSQI5xKkQU95qCyrO6ajZ8mcyvDpJqkgLnNRud0TZ/1z4jRHHY1XGJ6DcMwH9Qr17QFBMFaLoDLcU1lEf4jW03Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyDhb2sIAlXq9TmI1vxtbGcisVzy4vBVbRWKoCnojZM=;
 b=m8i0u36G20yRUbHo/e8OX2GDDKD9c/PiPL6fy5VK7UgitCa/Yv8wOSKt3MflQ9KisV39pqbfrB3NWUJ+wdZbzkG81TANLLb7W7ZYx1n4ymXsP0kPX/oDXYS8RmgkZ3kkr/j2RWndffqYaXrI2GNFGWuLT6yfFCDd/xZt5r4CpyZcAXwxNRtzh6lhbNZalWGpDyxpCYGQPUbrlabESpbZ0sY/jcDGstxe0RwLxMDXbMl5Dzzp43uyvCW6i/jyFWQ4Fs8QPR2aifd/vZgefp8HZ72u7+JxExA8O9c8/CY6m6tNrGbQtz4isL1oxSGUIo0NUU2ixfawOM1ZZqgwrUCBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyDhb2sIAlXq9TmI1vxtbGcisVzy4vBVbRWKoCnojZM=;
 b=MbuUphjeUf4vRVdAPNImxmMAcG2GM8u5RpRjD46Rc5luC+uKmrrOoMZiWoVZK7cElvp5tpPKifVEH5bFYX/Yk1K/e2rbImtuwVVC19HxSeJpTcd5CGqsKAMD+pAE7asbCLyy81iL+oSBYqx7YH0dKFLVF2RBQe2ICrmP7N3yr50=
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com (2603:10a6:20b:59::18)
 by AM0PR06MB6370.eurprd06.prod.outlook.com (2603:10a6:208:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 09:19:44 +0000
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a]) by AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a%6]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 09:19:44 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: dp83826: support TX data voltage
 tuning
Thread-Topic: [PATCH v2 1/2] dt-bindings: net: dp83826: support TX data
 voltage tuning
Thread-Index:
 AQHaWe9VCJAw32n0qU6/fjbc9pjQ+LEADwYAgAAUagCAAABlgIAABSCAgAABDACAAAIGgA==
Date: Thu, 8 Feb 2024 09:19:43 +0000
Message-ID: <f5eadb96-06b4-4492-b7a7-1adf555f49a5@leica-geosystems.com>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <a4949983-f6ba-4d98-b180-755de6b11d0f@linaro.org>
 <83f00386-e741-4bde-bcfb-462fadde1519@leica-geosystems.com>
 <2c4e76f5-0a13-44b5-8ece-3deb957dd260@linaro.org>
 <f35e239d-3f78-40e1-8d5b-4d7b949f08aa@leica-geosystems.com>
 <cb7b7f91-5fcc-4efe-9066-2eb3de836361@linaro.org>
In-Reply-To: <cb7b7f91-5fcc-4efe-9066-2eb3de836361@linaro.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR06MB4705:EE_|AM0PR06MB6370:EE_
x-ms-office365-filtering-correlation-id: a1c2f644-166f-469a-d164-08dc28871657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k6fz6gbyy9GScd5HkYt/F62gvcmFtfv89eHoiJv3O0PE6WM3t9vo2YrDfm+Ax9e/xgkd7M2ZokmopQ0kAZkk6G9FzSIqxTAw4c+X6y8Zy5Iawlc/93Xvbb7rkdOqeHiTDchzMhFPVGG8f+TXSgb6bv/rLaeJlQ9fKK8QYhpFHTwIHh8whIkaxjoEKObwG/gyA3c4WsxU3271m1YpE0rs3ErVDuvGcTC19elrmok0poI2ZtUyzOqBQWkVpQ3/Qs0R6jakE7cz5yIeriqVBcSYC5I4qqs6q1/dUbEOMU05Hg810JCdSbtM4uarMptXh0EF1bpS/E3BFTdhVtUe+iKWdRVlWYmRPiFFRe5zRqUqXMYSi4/Oh+zCWAxqhlL19gKj9g6FBFQ9kHfPOOXRxQQHLZL8Smi1mVGmQLrrykEwh1z/FC2DUEZrRVLuFiwFwG/qAjpf7eqJP4qtRWCZa3e6kSYE3c3AUFbTJqAOYf0IszXi8XXSqjq47P6hRh3KNyBPtzQJdyCKk34kn77qEPYh/uZapQKUB3E+/oE/aN/+F0RkQp+jfvW5RZoWtFovsgPtZ1hJerIs49yJ4cZqTbEI1NXnZsxp4n8rFPAICKksnSk1BAxGA7oJG4WK5GHPS6w4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4705.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(230273577357003)(230473577357003)(186009)(451199024)(1800799012)(64100799003)(31686004)(38100700002)(53546011)(31696002)(54906003)(6506007)(122000001)(83380400001)(86362001)(7416002)(41300700001)(6512007)(26005)(2616005)(8936002)(4326008)(8676002)(36756003)(71200400001)(966005)(6486002)(2906002)(478600001)(921011)(5660300002)(66556008)(316002)(66476007)(66446008)(66946007)(64756008)(45080400002)(76116006)(91956017)(110136005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnNjVmVSZXlrYnhaa1R2Q1BoTEhSc0dzbTU3UEY4aTJ3WmcvWTlJM1c5ekI5?=
 =?utf-8?B?RFAwOWhveE1YSkFBZ0RtOE5iYVZidDJ0QUdCNE05UTRDZkdZS0JRREhDS3E0?=
 =?utf-8?B?ZGU2dWo3ZTVHblhObXM0YmpETEZjaE5yQUl1YWx0V3ZzelpoWE9sbEczQmt6?=
 =?utf-8?B?T1BsK2V5WVlZK2pRYjZrWkgyT0g4d25sZ0xxM3FZblFVQktaenY4czNvYWxH?=
 =?utf-8?B?aGF6eVBqRGJIRHJoQnQxTGN1N2hwRWRadWhJeExUQlYwWlhoZFRQY1R4cG9u?=
 =?utf-8?B?QVlmcVdoZEF2cktZUExYR056REgrWGVzcEV2ZGNzR1V1R0hFWEFCdi9RNExm?=
 =?utf-8?B?bnNONUgxeWpXUnZ6R2ZHa29oZVQ1dGsvaTh4TklpU29yZGFyQnNMWDlHamFE?=
 =?utf-8?B?WTM3RkdBL3lXZEVqV29mdTNRVm93Q2w2cUxuYUgrWFd2RUFFaHNBY2dxcDVv?=
 =?utf-8?B?YzltRlVVSWZqV3lCQmNxQTZWTHZ1L2NsTCtwaGZOQkgwTVJVMXlPSjNHNzhU?=
 =?utf-8?B?eFdVK1FzdnQ4RzlLRm44YkZhY2FTY21DU3B5VWdhMUhOalRhcExBM2NkbXhp?=
 =?utf-8?B?S21uWEZ2OFFhYW9tRFFnRUJzdWNhUlBTS1pmaGxMdmFUQmRyaWJLQnFvNGI4?=
 =?utf-8?B?VFIxRkhPbkg5NUY4M0JjQk9pUU5hV2xXM3hZNFRmOFBmQXV1NEVqb2RLdWNE?=
 =?utf-8?B?Y2F6YTZYZVNJRkpBMjJCNFBCZFJONEIzNEZFc3BGbXpvQjdNQjRnQU1XSlND?=
 =?utf-8?B?WnZZU3R2ZUZtQ3hOTDUwdEk2TUFVUXZaK0Z4TUtsQjZHeHVIVzMwOXVXWHVL?=
 =?utf-8?B?aDg2S1hBT3RwcytMd0JBeXA5NDFBTGdxZCtjQ1JrRVFzbE0ySlllSWhUWEpO?=
 =?utf-8?B?OGp5d3ZKQkJEOUNrbkRnQlByUy9rdXFDcjUxTTJsNzhUQWNocnlXQjRROGth?=
 =?utf-8?B?U29Remc2ajdMQS9VSVFHclFBeUhlVjQ5d1FvMzhRTXVjNzVWYW9ZZm53VGtU?=
 =?utf-8?B?NTdFYXRNbFBNckVodUdyWDVLNE5PS0JSUm5sQkI4d1ZFNVpvdUJrN3prbEs1?=
 =?utf-8?B?R3JTQ1pBRXhVZ3EzclRmQ3QvK1F6bnBOTXJjSUp5amJKaXRMLytNWTdBb0hv?=
 =?utf-8?B?NEt5a2VlcjJFai9TYjlTbXI3QktNZ050OXJ4MU94cnIxYWhCRFVVSjN2YlYz?=
 =?utf-8?B?Z3NvOGY0enF5cnM1UUpGcTI0RFhEWEYrWTJlQ0dZMkFaaFMreHVZek9rb29Z?=
 =?utf-8?B?aVR4MzFjelprOEJFVkhQYXF4M25yYlk4NVhMK3ViT2JzUDNYaGpnNVdhRXpE?=
 =?utf-8?B?Y3NoR0lHa0F3eGN0UThVM05LajBJaHppUXBMdDdPdkx3b2FvNmdURmxIanFx?=
 =?utf-8?B?SVZEYnd3b2tEa2UxZlZRNzZBNmdqWEpmTU00N3hhdlJjcnQ1VklQa2dydjN2?=
 =?utf-8?B?Q3FRZzVKSktIS2o5YStNc2QwYlhIeGlibmFRbVdzUUNVc1o5c3JuTGVCL3h2?=
 =?utf-8?B?cHJlZUFBL3FPdHl0eTBLcXQ5Sk45Sm95NU5MU1Ewa1BiR2xPM2Y5dHdjV1Na?=
 =?utf-8?B?QmxVaEZCYktFOVU5SmM1UmZQcjVQUzF5MlcxaUdIRmhuWmhZclliRXltZXEw?=
 =?utf-8?B?V0RyVWYvWDViQytNNWVBblMvZFN4eER5VEFDY1Y2OVQzRjlJMlI5cXFtR0Yy?=
 =?utf-8?B?cnhQZHdnZnlubVphQWRtU0Zsd2gvaWJlWlJtT1pzTzZWcHdsd0pRZWZyaTF5?=
 =?utf-8?B?Z2xaNHZkNE4vZ2NKZ0ZkNUt5RlJqbm9uOVJ2VmVINGN5MVo1c3haRkVnWjZE?=
 =?utf-8?B?K293ai96dGlaeGJOSWdreUpxRGE0R092MlNYTHJmKzhCdkYxYlNNN2pOakhW?=
 =?utf-8?B?b1JpaW1EenRkRHBDWmE2MEczaEI4NThqSHlacTdJcVZYdm54bHRrVGdBQUQ5?=
 =?utf-8?B?R1YrZGRXUWtiYkNPN0NpY3ZLOXRTcTN4aGFsMlRESDRNQzBHdGpsdVN3M0xO?=
 =?utf-8?B?MUZZSFFnbUI5dGtsOGY3WjBBMzJHQmt1R2pubUdwSVQ4UXAxSkRjSkgwajln?=
 =?utf-8?B?enhDck1Obi9LY0lxZCtmYTRNME1aMVB5bE5EWVNyVEdaMGVQWnV2V2Ztby9H?=
 =?utf-8?B?WDFDdDh0YUNma3BqbkZKZ3VrSnVuWkNTYkFPUjlrSmFaOWxsOVhtVEFETWdH?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2FDC744C1C16546856958C91CF3CB47@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4705.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c2f644-166f-469a-d164-08dc28871657
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 09:19:44.0082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVgTQ9PBKKjfAyTCHsQKPUr9o6HMhM5MBQVvUzrYnQafiCOlgQzl1xCXGhvv04NAsW+ORn7DBd1NMgY2ppXjHif7dxeSWpHVYE6Zjfxe/wV+9klwtngDhyw24AuXhIRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6370

T24gMDguMDIuMjQgMTA6MTIsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFRoaXMgZW1h
aWwgaXMgbm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJl
IGNhcmVmdWwgd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJl
cGx5aW5nIHRvIHRoaXMgZW1haWwuDQo+DQo+DQo+IE9uIDA4LzAyLzIwMjQgMTA6MDgsIFBPUEVT
Q1UgQ2F0YWxpbiB3cm90ZToNCj4+IE9uIDA4LjAyLjI0IDA5OjUwLCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPj4+IFRoaXMgZW1haWwgaXMgbm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNl
IDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwgd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9w
ZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRvIHRoaXMgZW1haWwuDQo+Pj4NCj4+Pg0K
Pj4+IE9uIDA4LzAyLzIwMjQgMDk6NDgsIFBPUEVTQ1UgQ2F0YWxpbiB3cm90ZToNCj4+Pj4gT24g
MDguMDIuMjQgMDg6MzUsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+PiBbWW91IGRv
bid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZy4g
TGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRT
ZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBlbWFpbCBpcyBub3QgZnJv
bSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGls
ZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhp
cyBlbWFpbC4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gT24gMDcvMDIvMjAyNCAxODo1OCwgQ2F0YWxp
biBQb3Blc2N1IHdyb3RlOg0KPj4+Pj4+IEFkZCBwcm9wZXJ0aWVzIHRpLGNmZy1kYWMtbWludXMt
b25lLW1pbGxpLXBlcmNlbnQgYW5kDQo+Pj4+Pj4gdGksY2ZnLWRhYy1wbHVzLW9uZS1taWxsaS1w
ZXJjZW50IHRvIHN1cHBvcnQgdm9sdGFnZSB0dW5pbmcNCj4+Pj4+PiBvZiBsb2dpY2FsIGxldmVs
cyAtMS8rMSBvZiB0aGUgTUxULTMgZW5jb2RlZCBUWCBkYXRhLg0KPj4+Pj4+DQo+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lz
dGVtcy5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+Pj4+PiAgICAg
LSBzcXVhc2ggdGhlIDIgRFQgYmluZGluZ3MgcGF0Y2hlcyBpbiBvbmUgc2luZ2xlIHBhdGNoDQo+
Pj4+Pj4gICAgIC0gZHJvcCByZWR1bmRhbnQgImJpbmRpbmciIGZyb20gdGhlIERUIGJpbmRpbmdz
IHBhdGNoIHRpdGxlDQo+Pj4+Pj4gICAgIC0gcmVuYW1lIERUIHByb3BlcnRpZXMgYW5kIGRlZmlu
ZSB0aGVtIGFzIHBlcmNlbnRhZ2UNCj4+Pj4+PiAgICAgLSBhZGQgZGVmYXVsdCB2YWx1ZSBmb3Ig
ZWFjaCBuZXcgRFQgcHJvcGVydHkNCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L3RpLGRwODM4MjIueWFtbCAgICB8IDE4ICsrKysrKysrKysrKysrKysr
Kw0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+DQo+
Pj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
dGksZHA4MzgyMi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90
aSxkcDgzODIyLnlhbWwNCj4+Pj4+PiBpbmRleCBkYjc0NDc0MjA3ZWQuLjZiYmQ0NjVlNTFkNiAx
MDA2NDQNCj4+Pj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0
L3RpLGRwODM4MjIueWFtbA0KPj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvdGksZHA4MzgyMi55YW1sDQo+Pj4+Pj4gQEAgLTYyLDYgKzYyLDI0IEBAIHBy
b3BlcnRpZXM6DQo+Pj4+Pj4gICAgICAgICAgICBmb3IgdGhlIFBIWS4gIFRoZSBpbnRlcm5hbCBk
ZWxheSBmb3IgdGhlIFBIWSBpcyBmaXhlZCB0byAzLjVucyByZWxhdGl2ZQ0KPj4+Pj4+ICAgICAg
ICAgICAgdG8gdHJhbnNtaXQgZGF0YS4NCj4+Pj4+Pg0KPj4+Pj4+ICsgIHRpLGNmZy1kYWMtbWlu
dXMtb25lLW1pbGxpLXBlcmNlbnQ6DQo+Pj4+Pj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPj4+Pj4+
ICsgICAgICAgRFA4MzgyNiBQSFkgb25seS4NCj4+Pj4+PiArICAgICAgIFNldHMgdGhlIHZvbHRh
Z2UgcmF0aW8gKHdpdGggcmVzcGVjdCB0byB0aGUgbm9taW5hbCB2YWx1ZSkNCj4+Pj4+PiArICAg
ICAgIG9mIHRoZSBsb2dpY2FsIGxldmVsIC0xIGZvciB0aGUgTUxULTMgZW5jb2RlZCBUWCBkYXRh
Lg0KPj4+Pj4+ICsgICAgZW51bTogWzUwMDAwLCA1NjI1MCwgNjI1MDAsIDY4NzUwLCA3NTAwMCwg
ODEyNTAsIDg3NTAwLCA5Mzc1MCwgMTAwMDAwLA0KPj4+Pj4+ICsgICAgICAgICAgIDEwNjI1MCwg
MTEyNTAwLCAxMTg3NTAsIDEyNTAwMCwgMTMxMjUwLCAxMzc1MDAsIDE0Mzc1MCwgMTUwMDAwXQ0K
Pj4+Pj4gSSBzZWUgYWxsIHZhbHVlcyBiZWluZyBtdWx0aXBsZSBvZiBiYXNpcyBwb2ludHMsIHNv
IHdoeSBub3QgdXNpbmcgLWJwDQo+Pj4+PiBzdWZmaXg/DQo+Pj4+IEkgY2FuIHJlYWQgOg0KPj4+
Pg0KPj4+PiAgICAgICItYnAkIjoNCj4+Pj4gICAgICAgICRyZWY6IHR5cGVzLnlhbWwjL2RlZmlu
aXRpb25zL2ludDMyLWFycmF5DQo+Pj4+ICAgICAgICBkZXNjcmlwdGlvbjogYmFzaXMgcG9pbnRz
ICgxLzEwMCBvZiBhIHBlcmNlbnQpDQo+Pj4+DQo+Pj4+IEluIG15IGNhc2UgaXQncyAxLzEwMDAg
b2YgYSBwZXJjZW50LiBBcyBJJ20gbm90IHN1cmUgZXhhY3RseSB3aGF0IHRoZQ0KPj4+PiBhdXRo
b3IgbWVhbnQgYnkgImJhc2lzIHBvaW50cyIsIHdvdWxkIHRoaXMgYXBwbHkgdG8gbXkgcGF0Y2gg
YXMgd2VsbD8NCj4+PiBTbyBwbGVhc2Ugc2hvdyBtZSB0aGUgdmFsdWUgd2hpY2ggZG9lcyBub3Qg
Zml0IGluIC1icC4NCj4+ICJCYXNpcyBwb2ludHMiIGRvZXNuJ3QgbWVhbiBhbnl0aGluZyB0byBt
ZSwgdGhhdCdzIHdoeSBJIHdhcyBhc2tpbmcgZm9yDQo+PiBjb25maXJtYXRpb24gOikNCj4+IEkg
ZG9uJ3QgaGF2ZSBhbnkgaXNzdWUgdG8gdXNlICItYnAiIGF0IGFsbCwgSSdtIG5vdCBwdXNpbmcg
YWdhaW5zdC4NCj4gaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvQmFzaXNfcG9pbnQNCj4N
Cj4gTG9va3MgbGlrZSBhbGwgeW91ciB2YWx1ZXMgZml0IHRoZXJlLCBhdCBsZWFzdCBmb3IgdGhl
c2UgZGV2aWNlcy4gTWF5YmUNCj4geW91IHdvdWxkIG5lZWQgdG8gYmUgc3VyZSBvdGhlciBkZXZp
Y2VzIGRvIG5vdCByZXF1aXJlIG1wZXJjZW50IGFmdGVyIGFsbC4NCkdvdCBpdCEgSW5kZWVkLCAi
LWJwIiBjb21wbGV0ZWx5IGZpdHMgbXkgbmVlZC4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCj4NCg0K

