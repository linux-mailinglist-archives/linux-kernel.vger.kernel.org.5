Return-Path: <linux-kernel+bounces-23890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11782B343
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934371C269AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6551C4C;
	Thu, 11 Jan 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="sZ/x5BEf"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2098.outbound.protection.outlook.com [40.107.21.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200151036;
	Thu, 11 Jan 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7KvP1YNS8JmcP1KWCSSxo+AT6V+wmqcHO1CfP2+1QVSF0BUW/bcQYCAtf/gOAqYFjQvafPDER+5JmJ/wz1t4maur2m6wBNWeRnMJuoPrCBSs8LF7GnqbZ/n6JgyFSEEg7hPG1LAbPL2gYg22BhAPWxSRWyye9/PuNdp9vKOSnAubUuPEptPKnxIgYIZvU9A9uOL3d5Wi1nGCK5ZdKESskUrwJ7tBqM4ME6bhab06ucKSD1L6xU1e5Ftj8Uv17TKNP72J8kBoTKx+OODO9lHiDQ6lyel2Wb9Lokqq+HGMZhrO6HacFrHLYxwACie6d23Sj/tW4nhhoQKdfxIjOhE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui1ll13J7eCI7+JGlHd3K4KhaRDJlZAaAVYRBGna1mE=;
 b=aWqjGHXUeXNAoong5YtaAXXPhoS9NRn5rp4XaKLWbTv+FNReIZiBdNTVGkZqETy8Coy/GvBSWZiOvnT4pELQVRdB7p9B+O4kTIN/zUHs/vLy9jMEdxHfW7vrPAiGsIwhSqg3Xg9+x+o7TpaAXPTKVrQbUBYEwWEjcV4t3z2/sGTq+9ZulLv4O0LwB//i+JwIr4SdXKcQFFyj76ojaVnrdq1M73UUJfvY2kkMXpDQxpQrCItYAvspAWcWRRGmZ6gjcMiBBdTJ8GvfIKxnyotVVljkxpD0bzc0bGt5XzmxqdaaX2YKDwwQomHeLh45Mqq90NnSBShVjEslBBf8Vxq5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui1ll13J7eCI7+JGlHd3K4KhaRDJlZAaAVYRBGna1mE=;
 b=sZ/x5BEfWWgnns+tI0HvutDO5CNKBNdt4wdw6T+2kTrfyqQ/9cYm8p27ahHVBFnwnistQLuHHfDuvnkWWMB4ae67qXkCx9gJh0JLuzq9gN5ce73W1NTTPdAj/EL7udJXeejK9UVhZCJecYzF/V1Co+zDJ8+kvx2zBadawnA4mD4=
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com (2603:10a6:10:103::23)
 by AS8PR06MB7862.eurprd06.prod.outlook.com (2603:10a6:20b:3c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 16:45:58 +0000
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039]) by DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039%5]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 16:45:58 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 2/3] dt-bindings: net: dp83826: add ti,cfg-dac-plus
 binding
Thread-Topic: [PATCH 2/3] dt-bindings: net: dp83826: add ti,cfg-dac-plus
 binding
Thread-Index: AQHaRKoXF4N7IPsFp0OxQEd+BLc1/7DU0fkA
Date: Thu, 11 Jan 2024 16:45:58 +0000
Message-ID: <5dc5529c-0951-4cb2-9aed-893f1c55228e@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <20240111161927.3689084-2-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20240111161927.3689084-2-catalin.popescu@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6332:EE_|AS8PR06MB7862:EE_
x-ms-office365-filtering-correlation-id: e129681c-33d9-4446-0398-08dc12c4c9bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZSo/vL19sM5BRQW9G0X8a7LVo9tPyQWPHT7f8oznvzRzwj1pzoV0FmWIw7y0iBuoBwdmLaUx3Q/n8OfHy0UML+1GzKUp6tgxsPo2d9RTMw722QabbR4XjgOL/vXZ/Xeckmj/STwcn7fkRoa7O6S/F5ezYPJtvj0W3Qgcub60080mxyceOARGLXvHHUkEKx66svAGvgDki2NSu3AwWg2t2e0tFRsj5w4z5Xlu+042wTXSsHAW7/+EeKITcFKPUgpROG9pTKcBhJL/9GzOZTy4RuNe2Cgg6XWqwyXlOL3/mYri6AICqBN8OBQPdTqwO6zG37wZzWtpFzxxgxBGB9cPjegH0ih1BfrjLV+9m3yYm1sFCpLjJZ/JrulMXrIjz0WaBh4l9P6Olt2D86t/xeHsvzYsl+qLhkoXarosuF8XPoSVvEB7aNe3CF99Xu6E0qPW/IBgPlQgItlTUDWpXYPt8BRkBVUC63HHiHuy/RELQNwYyHiWwMvSn6uwa9G6+q5LojdqgEJgCzhKW2eXecxPp8zmRurrWbJkeAFWFhDAQyxvBqRPCJ7IFdaoDDUY1bkqzkLCVsyjZDz1zA0yT/mA0WfEveiVNOcQ5wNgawiDD/VmoUx8ThwAVKlJ7shYrojRUa7ujA+WbjAy81Q1HEodT7xaIti52NqYIyiDoAv/kQE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6332.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(53546011)(316002)(31686004)(54906003)(38100700002)(122000001)(5660300002)(6506007)(6512007)(66446008)(64756008)(66476007)(76116006)(107886003)(71200400001)(66556008)(2906002)(7416002)(66946007)(6486002)(8936002)(4326008)(8676002)(478600001)(110136005)(2616005)(26005)(91956017)(921011)(41300700001)(31696002)(36756003)(86362001)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEVXV3g4UVQ5c0ovMWxScXR3ZklsZUFoV0pienY2T2hFaC91bTFGUjZzYjlQ?=
 =?utf-8?B?cXB6ajgvR0xsRDdrWkg0QjJDZWZYcHBOR2swZUd5bDNEWGlvVW8zM291d0tO?=
 =?utf-8?B?WUdCeDUrWDdMNnJUTEZ4cGZHK1F6a0tKRjlNNE05cXVhbHA1UFBNczNNaTdK?=
 =?utf-8?B?UGVWUFQvZ2ZNSVNoSjg5RlVIRHR4TDVEM2xoY1hmWWpQSUE3d3RubHdacWdq?=
 =?utf-8?B?WFoyVzlvaHFXbDFraEg5TkViU052RXc3bFptckpWUFQzaGZjdkpYQWdtazFT?=
 =?utf-8?B?S1B4TzRaM2pKU3RkTWlwSHZ4MTZFTWozL29ycURKd2tZbXVCYUZsQXBha3ZL?=
 =?utf-8?B?a3d0b21uWE82VFNhQ1FuOTd4Z2pESnR5cTl1QkF3K3RFOVhnMWUvRnIxZmJl?=
 =?utf-8?B?Znl4VkhZaUY0VHEzanY3aXQzeW9MM0QzdGp0R2xPQVUzakgvTysyMVk4THZM?=
 =?utf-8?B?THA2RkFOYXVrNjdCYTAzTDhITEU4YTF6aU1RVHgwRktpNUl3bWR0QmFCZHZ2?=
 =?utf-8?B?NkU0NkFhaGttL2dia2pEK0NjMk9yd2NPN2VGMmYyeVZkbnhIRlZCVGdqclNF?=
 =?utf-8?B?ejd0NWYyMndnWmt4Tk9yM0NKbDV4ck9QODRObFpTRVBhZGdzTmE0dFVNOTIx?=
 =?utf-8?B?ZE5rT3BzS3ljeEJwdDI0ekR1MzlaYkxtdnBzRlhLYTZ3MHErWUVTaWQxQXIz?=
 =?utf-8?B?WnpxVmQ3YVgxZFF2RW93NlpaQVBMWGRUSmNwSktTaE9keVljQXJKUEdwa1p1?=
 =?utf-8?B?WXlEaS9TOEl6MHFFOFFIc2Yvd2xuREVQd0cxdjNCSXVzZkRqaUxlNVROSHVI?=
 =?utf-8?B?Um9LVEcvSHVaMnZVVFBWNnhiVXc4WmhzTzFNeVZCd2NaK3BKSXNVWThuNVls?=
 =?utf-8?B?R0RQWGp0aVI0bjFrUm5SKzJ6TVBVbkhwRDZ1cjNqM3RSUHdHcHNqOFFKcVYv?=
 =?utf-8?B?VFYzcTRrakY1Wjdmdm1VdGNWTFFIWktmYnJhbTh5dk4yOTlNOUdaNnVneVNC?=
 =?utf-8?B?UFVZUzI3bzVrWXlIbWNOMm9jdUFpYVJZK1Q5ZThCRHd6aVBhb3oxZzNvUE9h?=
 =?utf-8?B?SnV0eXNDdnlraEhNU0J1MS9ZNnBoV0JhNHVFRHhuNFlJUlpRejNaQld6aCt2?=
 =?utf-8?B?QkdibC94ekNGVFhHU2FLMW1jd2NJYWI0WGM2Q2YzREJDY0xyT1JpS0JpNEN5?=
 =?utf-8?B?Q2FCRlFsQ01hckxnUzFla1BoVzdaYXVWd0hRZ1ltOGlISGhUUlBzdkJsdGg0?=
 =?utf-8?B?bUQ5UEIvbGpjcmZuQmNqc2JZdUZHWWIwM0QzQlIyQ2Z6Y0VNRm1uRW9vclFL?=
 =?utf-8?B?NnA1YzVBQUdkZXppSkhzRXkzT3I5NUdPcnhSclJBS0ZPUWFVZE9EVWE1VHVq?=
 =?utf-8?B?Yk93aWpSRUZURm01VVNZVWpPNm1tT1BTTHJpWmlSYXBPUWprOHpBUmp3TThT?=
 =?utf-8?B?WGluTUt6WUxmVnlhdE01d3JjQ21GSUd4S2duWS9TMkJ5cE5rSTN5Sk5tWU0w?=
 =?utf-8?B?bjl2cGR4VVcwcmZxdkgzaFVPaHZLalpmOFRsTnpqaE1LS0h5OGVlOS9lQTR2?=
 =?utf-8?B?ZXNOa1hPdkY2ZUN5Q20rVmprTFZHS0pjVzhlN1RxUEFEcjdHdFk5aTY1VjJ6?=
 =?utf-8?B?U0Jwd2lLcXB2dkREcDVOd2UyQXI4TmFEeXRDOEtVTHF6N0Q5MGtINXF0UjR4?=
 =?utf-8?B?bW5CbnEvYStuV0tod2M0MCthcFhzUm05U3JhaUlTQlhpWGJCOExhWWY1a0J1?=
 =?utf-8?B?VnEzejV6QU1uN3V4UThCaXFyVVMzbXZTQkZ0NTlJSG9oVlJMdjNJbWVZZFEv?=
 =?utf-8?B?dFRrL3U0MzRHMGs3UnV0anlPMXdNamU1RVprUlRnODZaVWp5UVNKV1RZdnN3?=
 =?utf-8?B?RUZSZkl1d0xUdXhnSDk1bVRxUTlSR1VDazlZSnZZT2RqS2dkVUUxRVE5Mnlk?=
 =?utf-8?B?STJyeDJjajBVNTl6dHRkV0JTOXd1V0JhOTdJeG0rWjJBeGxXYlc2Ukg1Tjd3?=
 =?utf-8?B?SEJHR2lMRVhJVnYySWNtNldsNWdxSW1HRzRTVHZsYUR1ekJkYTFTMHM0aE92?=
 =?utf-8?B?RG1LVmRZa2ZGQktDa3FNQ3E4c09GcmpucENrMUJhMmpDUmtiSHE2bG5odm9u?=
 =?utf-8?B?elUzdmtVUnRUYTRWbzVGaE53VFgyeDdNUFdob3NJUVFjOXZIZzhSa3Z2alF2?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <802588FC6C8B6548A3F15CFE50B1F785@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e129681c-33d9-4446-0398-08dc12c4c9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 16:45:58.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8EVDjIxFyk/+mr6R3sWmSkFJDSk87wKiZ+wWNuadKmkRWhtYuAjmCFZL/0Vp2D8LMlsRW38g6ZHr5hM7dOWrkBdLviuCmPOzjCVE7928eJ9ia4f4yZbMImjj80PKH0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7862

QWRkaW5nIG1vcmUgcGVvcGxlIGluIENDLg0KDQpPbiAxMS4wMS4yNCAxNzoxOSwgQ2F0YWxpbiBQ
b3Blc2N1IHdyb3RlOg0KPiBBZGQgcHJvcGVydHkgdGksY2ZnLWRhYy1wbHVzIHRvIGFsbG93IGZv
ciB2b2x0YWdlIHR1bmluZw0KPiBvZiBsb2dpY2FsIGxldmVsICsxIG9mIHRoZSBNTFQtMyBlbmNv
ZGVkIGRhdGEuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENhdGFsaW4gUG9wZXNjdSA8Y2F0YWxpbi5w
b3Blc2N1QGxlaWNhLWdlb3N5c3RlbXMuY29tPg0KPiAtLS0NCj4gICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L3RpLGRwODM4MjIueWFtbCB8IDkgKysrKysrKysrDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3RpLGRwODM4MjIueWFtbA0KPiBpbmRleCAy
ZjAxMDMzM2JlNDkuLmY5YjY4YmRlNTdhNCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4gQEAgLTcxLDYg
KzcxLDE1IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAgIDEzID0gMTMxLjI1JSwgMTQgPSAxMzcu
NTAlLCAxNSA9IDE0My43NSUsIDE2ID0gMTUwJS4NCj4gICAgICAgZW51bTogWzAsIDEsIDIsIDMs
IDQsIDUsIDYsIDcsIDgsIDksIDEwLCAxMSwgMTIsIDEzLCAxNCwgMTUsIDE2XQ0KPiAgIA0KPiAr
ICB0aSxjZmctZGFjLXBsdXM6DQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgICBEUDgz
ODI2IFBIWSBvbmx5Lg0KPiArICAgICAgIFNldHMgdGhlIHZvbHRhZ2UgcmF0aW8gb2YgdGhlIGxv
Z2ljYWwgbGV2ZWwgKzEgZm9yIHRoZSBNTFQtMyBlbmNvZGVkIGRhdGEuDQo+ICsgICAgICAgMCA9
IDUwJSwgMSA9IDU2LjI1JSwgMiA9IDYyLjUwJSwgMyA9IDY4Ljc1JSwgNCA9IDc1JSwgNSA9IDgx
LjI1JSwgNiA9IDg3LjUwJSwNCj4gKyAgICAgICA3ID0gOTMuNzUlLCA4ID0gMTAwJSwgOSA9IDEw
Ni4yNSUsIDEwID0gMTEyLjUwJSwgMTEgPSAxMTguNzUlLCAxMiA9IDEyNSUsDQo+ICsgICAgICAg
MTMgPSAxMzEuMjUlLCAxNCA9IDEzNy41MCUsIDE1ID0gMTQzLjc1JSwgMTYgPSAxNTAlLg0KPiAr
ICAgIGVudW06IFswLCAxLCAyLCAzLCA0LCA1LCA2LCA3LCA4LCA5LCAxMCwgMTEsIDEyLCAxMywg
MTQsIDE1LCAxNl0NCj4gKw0KPiAgIHJlcXVpcmVkOg0KPiAgICAgLSByZWcNCj4gICANCg0KDQo=

