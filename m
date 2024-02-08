Return-Path: <linux-kernel+bounces-57661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9C84DBE9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B1128885F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CDE6D1D0;
	Thu,  8 Feb 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="FWWrDUQl"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2B6BFC8;
	Thu,  8 Feb 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382144; cv=fail; b=MoeVhbp6nSM3b7KRDS7ZDZgLBXmn3pEqVCmuxMnFk5fEwzdOXXJBNnH5+/q8NcXqlrIq5AP7pcqAjGHW5oltjp91mAfBjvRGYKGt8WyJVebV7ajeTVL9+pqaeCzO6KHueaOttbF7qis85TCklz8/TUrVJvC7D+mW0dJzN0Cs6bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382144; c=relaxed/simple;
	bh=csj73llLFRe1Nd9skhF1dJmhaivGww0sUG8nODcjHSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsJT3fe6ppgmcW0OxUVWJy4hxO2JP71lKV3svsUQGNpWdfjIYXjsXkQ/i5kkTVdqWi1EB7H2BRnMvWV3cWcFfSmUWfdGsOoIp1043yqgo2+QLoRjf5PiNvc3SGe/9za61eZCRl/WFN56AZ1i17lzhTIFfEJY9MjC9x+cTSZLU4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=FWWrDUQl; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrywOTqGrnpg1sy+5tCgX83jCxkXYe7sVXBUqS9hxe5tCGNFS3itTxrOeBStNAdNvNDYnFBnOWYPuvNPUPBofAUAy8oVnBz93ddhGBnZiPo8NaHdgkqTKtwhVzHw/YZcRXgmaftIdEQc6Fc/pZo1kOW4PC73qp4y6mSMPgjRnHd98bXTyTS74hO77SxnUEpOQ7tn8zmdTYedlTUsJ93itTqn+Dkif6orrr/6+x5zMqheuBapQBeumtsvslZH1xS6Igj5DaZXh9EBzkA2FVK7o1dHVR1MuINTKNuJVBvI0PTza69Il99wTS/IR8KH/ATlPqPgN14I+Pi/vgEfk33sCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csj73llLFRe1Nd9skhF1dJmhaivGww0sUG8nODcjHSk=;
 b=jmGMbmLFBQzXu1Z7Ylm1U8Wg4F2bZlZKTOBSqqUrLGKhcmCK+ZyYtpnxzQMe1ZLGITdutpRgT409ICR6UaZVJvPKnOej+4uRfS+Ihellg9g95EsPwB0iCpYF6D5uFLhIFacWV9McnCBUbezT0YkmU2TMdDUtaFKkt5xncgPobRspK9lo7GK9k9d8HkNuXjqHpuNJHj4FD3u7MnDy4FFFNMMJ1UFThm4A6hygq20oe4BHcOhrnGQs+r6zMlbu0LL+oeFdXqw5lZsTkuhYn+PoPLMv6L2+g2NUOXRSYPCFxDNUoK6liSxHa9wnZc8xXgZl8Sef/fnenYG2ktQTykxw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csj73llLFRe1Nd9skhF1dJmhaivGww0sUG8nODcjHSk=;
 b=FWWrDUQlbEL4UMnc2V95j8lYZjAy2i1arRnsyTaXKoD/TYzza8dQ25CwpDsudHQSPaxYjlbcHWQAIZtOfShWFNWdekT0abmoeR4nFnk34dQY/pe/33F6Htwr1t7LRkINpMJVUnUXdM58Dt/mbly65eFKqot3IaeKDQvWuA6mNEg=
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com (2603:10a6:20b:59::18)
 by PAXPR06MB7390.eurprd06.prod.outlook.com (2603:10a6:102:15b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Thu, 8 Feb
 2024 08:48:59 +0000
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a]) by AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a%6]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 08:48:58 +0000
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
Thread-Index: AQHaWe9VCJAw32n0qU6/fjbc9pjQ+LEADwYAgAAUagA=
Date: Thu, 8 Feb 2024 08:48:58 +0000
Message-ID: <83f00386-e741-4bde-bcfb-462fadde1519@leica-geosystems.com>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <a4949983-f6ba-4d98-b180-755de6b11d0f@linaro.org>
In-Reply-To: <a4949983-f6ba-4d98-b180-755de6b11d0f@linaro.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR06MB4705:EE_|PAXPR06MB7390:EE_
x-ms-office365-filtering-correlation-id: e9cf9f03-01d8-4543-fff9-08dc2882ca6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8y9kGRvPH5FbWcECXoFCY2g4w7rdZ6YwavcEJFD9nGEEDl/QL0z0vvIe5iy3PeaJZNK/5e5VVbG5b0R4KiwOGooMJmNx92pCA0BboH3wADiOQf/LtCeDD5wfBpZF561kHnG9pvhaeGfkXjEJgnbuvxg5t6obVUP8PDRu9elC2SWrE6X0B6aSvEwgg0pkES/bEMOIHZQexfA+ukSDBpHL8yH827zsBnNyYFKPHtVRU/n561rnFzGgWwrWIndNo7hRdV0z0s7x1OMk3eoZMbeOf/VMjVc3eJ9/Y8hz5Qinc40j7NHlEjmMIu3385+ZM4DVpDUdDy/oWiWT9sR59nKLuriW/KY7yK/eIpsTDSBem5lVhSA8cBEmf+bhDElc4s/VNVrPl3IxBJxTCoXPBd+4IgKXIPBRT4bl7b2oQgb90pia9nNtoqm5vZD9uu1Yqqg0gKDPKztJu0Oibkzk6i8apLkWCXwFQXaRKW18xcDo/00Q6ej6iovmsWgx4GGYPtg4HthikTQZYnWFfb+H8JqYI8+qxsfFBkrvJdcwcgt+4zVzF4UZmED5K17gXihhHotXw5NiFJ5Nm3adOEYOEc+gyaXiQ7n2FM+rQL/oUjtKSrbBgA2Or0Mt1Ey8D1kZl890BEyYYpCfWZ4J8PRtXdG09A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4705.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230273577357003)(230922051799003)(230473577357003)(1800799012)(451199024)(64100799003)(186009)(36756003)(921011)(38070700009)(6506007)(478600001)(966005)(6486002)(53546011)(71200400001)(45080400002)(26005)(2616005)(66946007)(6512007)(110136005)(66476007)(2906002)(5660300002)(7416002)(76116006)(66556008)(91956017)(64756008)(8936002)(66446008)(8676002)(316002)(54906003)(4326008)(86362001)(31696002)(38100700002)(122000001)(41300700001)(31686004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlBtb0hNdGRnMVplQXhEdlhFaFlhRnY2K2hLZ1pyUFVuTDlBNjZISVFnOENs?=
 =?utf-8?B?U3VjeUhHbC9sVjRHZUx6VVo1bWJMbFhaWXZONHpGY3ljN3FqdjZhNTZjeDBP?=
 =?utf-8?B?bitzb01wRkNYdGF5VEMvd1dXRG13YjNCakZ1cGh1OEk2Z2ZRVkNuN0xOQi9M?=
 =?utf-8?B?akp0YnUwcXl1YlJmNlBjUFc2SHY3MTFsdHVQeTBoMzJBZG5jbTdjMjVkRXQ5?=
 =?utf-8?B?TmpwaHJ2Z1FuWTJrdUUzYU42cmJkQnpYcnBINlVyK1VROTR6b0tRNlNibTF4?=
 =?utf-8?B?U0lBL0pOUWZJOWJuY2oyRDVvSW5DUzhwckxWS3JkYlRiVHpyOGtSMWhFUWc0?=
 =?utf-8?B?RkZaZjhIVEdrT0R4Vnc1amh5THpXcVBFV2NvNmJiRitMUkwyZjgzVXJBV0lQ?=
 =?utf-8?B?dFpsN0NaN1VOMnhwM1JxNlZBOHFHTEMvOEpFN05jVUVhdFAxK0doS3hWSHB0?=
 =?utf-8?B?dUFwU3Bra2VtWnA2WWJwVTgvTVVsVW8zYlJFdFBsT2MrOS9PMko4NGRtM0do?=
 =?utf-8?B?NVQzNlBRUWFFNG1sb3l4Nzl2R05iR3hkM2RtdmlnRjgzVlpQOWdudktwU0lt?=
 =?utf-8?B?MHdYZVJ2R0hNV3oxekV0Rkl3eGxpOFUxb1BneEJ3WUdmdGJRYWFKNmIvQ0ZI?=
 =?utf-8?B?TnAvRTZRbWQ5RHBKUnZUakFxN0xEU01uUDlmdlNHZ1F5UXBDOVlGblBoT2RN?=
 =?utf-8?B?UU0yZFpVRVRSV1NoblVwRG1tcDVoUUxMSUNvaHptRmxmYUx3T0t1V0trRk1G?=
 =?utf-8?B?SFVqOUNZbmhVb2szWlVDSkxrem5vSU84QnNZUXY2b1R3UUpCN1grWEJvMjVW?=
 =?utf-8?B?N0wxSGtyYnV1dzlzQkNqdHVaa3o1bFVEZVBMbnJDSk44c0JuOFFSM0Y0NDUw?=
 =?utf-8?B?Y2FmYmVxZ3o1QnhJZXUwU2tqL1RTbmF5d0VwdXpTK1lFM0JVTHVJd0Y5bG5Z?=
 =?utf-8?B?NHlyaCsvSlFlTWdVUzFsRGRYTGNNeXhJbnhhaTRkc1VndHdTSFUwSy9XWmlY?=
 =?utf-8?B?dUZ6VnhEajZ6QW9JVDEzMVRoUTNneU9nbjNQMnY2RXpxMllVdER2U3ZMaStu?=
 =?utf-8?B?WXVCZG9HTVlIQWFSU2hFWms3Z1ZOTXdPNG5pdSsyMkhtdjl1QUdlODE3L1V1?=
 =?utf-8?B?U1lzNE94ZkVoQS8rNmoxK3ljOUk0aDBpdFJaKzVRUlZJbmZrRm51ajkzbmNM?=
 =?utf-8?B?VGN2THcrR1p1MlZhVUFrQm41RHl5TGlvQVZFcTcwcHR5b2F3ZFBXeElwckNG?=
 =?utf-8?B?eDg4bTdVWGU5TitFMDA5TlNEQnIwQnRjSkRXNXdLSFVoVytDR2RjYnRibGtI?=
 =?utf-8?B?MmFOWi9pQklOQmR5bXZ0WHZEYlNwc0QxK0I3K3NUTGVER01pODVBd3pPaFdy?=
 =?utf-8?B?emRQaXpscllkNFJEK2hLK0dyRWVpS0s2WjYzTWN5OGJaYW9PWktZR3E0Z0Rx?=
 =?utf-8?B?U2kvRnJFcjJZL095cUVFcFRObHRCSSs4VmszYXQrcEtyaWo1Vmd4M1czMjds?=
 =?utf-8?B?L2prNU9HZjNCYjErUkloWHM1RmdZTG0rNTAzdDZYRUFjK25jOG92SldJTEMx?=
 =?utf-8?B?aDV4bXZVTkQvVUo2VlB5WnJwdkRXOGdsMU4zQkFLR3pXaXhBa09Ib3RFRWRZ?=
 =?utf-8?B?TXFveC8xR1pjRlVWS1Q3WlJqU1BMdmZlWHVVcGpmTndpNEUxTEFjQWtpeFZD?=
 =?utf-8?B?bzFGR1QxSEN4b1NwZzB1S2tONGtCb1NDY1c0anhhZDVHbnpwcTVUam5ZS2Fn?=
 =?utf-8?B?VE82Qnp2dERlMUlURFhvc29HOWZBcFU1SEN4QzBVSmFkOFJUVnU5NU56UUt4?=
 =?utf-8?B?N1JHK0svVVhyT3BWV0pGQzVqQzdCbVc5TUVPbmE5ajlQUTh4VFJYc3UzeEhw?=
 =?utf-8?B?ZDhPK3g2ZDNBaEVXVS8wcnRXc1crYU4ydEMwSDgxUnEzZjQyVGdoc2FjU1Q2?=
 =?utf-8?B?VW9YUGpqd0hSUVZZSDFKM0dMK00vdW5jSUlkRDNrVGxMVVR1eGJQWEtrV0p5?=
 =?utf-8?B?Ymo2R3ZIQk50Z2ozUWpnMjNpMSt5bHNDazk2VmhkUWFoNEtEOFdxZ0RycE51?=
 =?utf-8?B?clk0VElVbWtFSnhPUE9NSHFEZU5ubGZtWVAvQWhWSjBIb2gwdEtHZVk4bVdZ?=
 =?utf-8?B?ZWdzUWd5NzUwNTRKOGVycktHR1llUWgxUUEwdUhHc3k2UUhPNlVDempQd0tz?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2723F4DB937274480DCECDF2728DD67@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cf9f03-01d8-4543-fff9-08dc2882ca6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:48:58.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMj1cjzCJaxPDQt2PNwLrrYYYQOoJ39iGCrSiExc9BbdcwakavdCfjSOaVQA9rDJnGCTwJiOr5ChmnWqX62GurnQtcGm+heAHO8Vh/VZ2LyGoVEe7O/lF0xBOC9yjeK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7390

T24gMDguMDIuMjQgMDg6MzUsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20ga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnLiBM
ZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u
4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2lu
ZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4N
Cj4NCj4NCj4gT24gMDcvMDIvMjAyNCAxODo1OCwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4g
QWRkIHByb3BlcnRpZXMgdGksY2ZnLWRhYy1taW51cy1vbmUtbWlsbGktcGVyY2VudCBhbmQNCj4+
IHRpLGNmZy1kYWMtcGx1cy1vbmUtbWlsbGktcGVyY2VudCB0byBzdXBwb3J0IHZvbHRhZ2UgdHVu
aW5nDQo+PiBvZiBsb2dpY2FsIGxldmVscyAtMS8rMSBvZiB0aGUgTUxULTMgZW5jb2RlZCBUWCBk
YXRhLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENhdGFsaW4gUG9wZXNjdSA8Y2F0YWxpbi5wb3Bl
c2N1QGxlaWNhLWdlb3N5c3RlbXMuY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGluIHYyOg0KPj4g
ICAtIHNxdWFzaCB0aGUgMiBEVCBiaW5kaW5ncyBwYXRjaGVzIGluIG9uZSBzaW5nbGUgcGF0Y2gN
Cj4+ICAgLSBkcm9wIHJlZHVuZGFudCAiYmluZGluZyIgZnJvbSB0aGUgRFQgYmluZGluZ3MgcGF0
Y2ggdGl0bGUNCj4+ICAgLSByZW5hbWUgRFQgcHJvcGVydGllcyBhbmQgZGVmaW5lIHRoZW0gYXMg
cGVyY2VudGFnZQ0KPj4gICAtIGFkZCBkZWZhdWx0IHZhbHVlIGZvciBlYWNoIG5ldyBEVCBwcm9w
ZXJ0eQ0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIy
LnlhbWwgICAgfCAxOCArKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L3RpLGRwODM4MjIueWFtbA0KPj4gaW5kZXggZGI3NDQ3NDIwN2VkLi42
YmJkNDY1ZTUxZDYgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L3RpLGRwODM4MjIueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4+IEBAIC02Miw2ICs2MiwyNCBAQCBw
cm9wZXJ0aWVzOg0KPj4gICAgICAgICAgZm9yIHRoZSBQSFkuICBUaGUgaW50ZXJuYWwgZGVsYXkg
Zm9yIHRoZSBQSFkgaXMgZml4ZWQgdG8gMy41bnMgcmVsYXRpdmUNCj4+ICAgICAgICAgIHRvIHRy
YW5zbWl0IGRhdGEuDQo+Pg0KPj4gKyAgdGksY2ZnLWRhYy1taW51cy1vbmUtbWlsbGktcGVyY2Vu
dDoNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICAgRFA4MzgyNiBQSFkgb25seS4N
Cj4+ICsgICAgICAgU2V0cyB0aGUgdm9sdGFnZSByYXRpbyAod2l0aCByZXNwZWN0IHRvIHRoZSBu
b21pbmFsIHZhbHVlKQ0KPj4gKyAgICAgICBvZiB0aGUgbG9naWNhbCBsZXZlbCAtMSBmb3IgdGhl
IE1MVC0zIGVuY29kZWQgVFggZGF0YS4NCj4+ICsgICAgZW51bTogWzUwMDAwLCA1NjI1MCwgNjI1
MDAsIDY4NzUwLCA3NTAwMCwgODEyNTAsIDg3NTAwLCA5Mzc1MCwgMTAwMDAwLA0KPj4gKyAgICAg
ICAgICAgMTA2MjUwLCAxMTI1MDAsIDExODc1MCwgMTI1MDAwLCAxMzEyNTAsIDEzNzUwMCwgMTQz
NzUwLCAxNTAwMDBdDQo+IEkgc2VlIGFsbCB2YWx1ZXMgYmVpbmcgbXVsdGlwbGUgb2YgYmFzaXMg
cG9pbnRzLCBzbyB3aHkgbm90IHVzaW5nIC1icA0KPiBzdWZmaXg/DQoNCkkgY2FuIHJlYWQgOg0K
DQogwqAgIi1icCQiOg0KIMKgwqDCoCAkcmVmOiB0eXBlcy55YW1sIy9kZWZpbml0aW9ucy9pbnQz
Mi1hcnJheQ0KIMKgwqDCoCBkZXNjcmlwdGlvbjogYmFzaXMgcG9pbnRzICgxLzEwMCBvZiBhIHBl
cmNlbnQpDQoNCkluIG15IGNhc2UgaXQncyAxLzEwMDAgb2YgYSBwZXJjZW50LiBBcyBJJ20gbm90
IHN1cmUgZXhhY3RseSB3aGF0IHRoZSANCmF1dGhvciBtZWFudCBieSAiYmFzaXMgcG9pbnRzIiwg
d291bGQgdGhpcyBhcHBseSB0byBteSBwYXRjaCBhcyB3ZWxsPw0KDQo+DQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQo+DQoNCg==

