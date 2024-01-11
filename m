Return-Path: <linux-kernel+bounces-23352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D750482AB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8879E1F2401C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4586112E5D;
	Thu, 11 Jan 2024 10:01:05 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2089.outbound.protection.partner.outlook.cn [139.219.146.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84979125D2;
	Thu, 11 Jan 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9ZCmwduJzclreWkGbmuyEKkfAv5XsLiVKaizacptVGEptn/nYI/YNUsRnQ+e8xU7ZJlO5/aOtckDiIC+7bjBO9yP4rTbx7okGhqJS2nULw6+ZVPZjCc+Dsw5hN9mBruzKwg4dRMCg9ufSkxLvLaFhNTWAPGtOzM9RNNPR0vFhCfZXs/fdJ4ofGvXQcKfCCZvNP2WBuZJAfIB1IsC6lipkukifgxkU2DtBedBYobrHHjE8qO/zuF9VOam9dkmGdw/Vz7wI5oRbbwwfbF/xhqc338mPkx1Ui6b9gKz9NrVmSSsI9ePnuR83uF11a56DjD4DGkQjyaEViEWnky0Z2jEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTAS8EvdvDeA/+I0dScKG54TNP9cC7fBlHG2seiwsOQ=;
 b=Z4en9hhb4Jj084hbYKphx4yuQ2bJHFXoOGWTQ+PDtE8HkJsC495ynNKGzK7L1rQdbaliSUKlUISIdRwiXSwZRD37V+AIKXA/utv2avRmL5WpM3uhHuS+BBhhTpYZnpecKCqOY2D6YVxFivMA2aa7to5XrU+LCDNn/JpflwJzSVLaVwifKdoimBjpUXq9wM1svJE23jlAc0B3r9EP5jzdZNXB0tAwh38HIegGgcJnOeAmpo5u3zxjgHThCb4CzZNf3j0oEDvHduy2oYC+aSrLi98tUfTVORbzIscBV0DPsNcRyTZOX6M4pQXqe+KltPBCWKLZEd6IlnQ3YhpJ890nBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0497.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 10:00:54 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::9fb5:b2ec:ed6f:b0a4]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::9fb5:b2ec:ed6f:b0a4%3])
 with mapi id 15.20.7135.032; Thu, 11 Jan 2024 10:00:54 +0000
From: ChunHau Tan <chunhau.tan@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Andrew Halaney <ahalaney@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Russell King <rmk+kernel@armlinux.org.uk>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, JeeHeng Sia
	<jeeheng.sia@starfivetech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 0/1] Add StarFive JH8100 dwmac support
Thread-Topic: [PATCH v2 0/1] Add StarFive JH8100 dwmac support
Thread-Index: AQHaRDmqsipYoNxwaUyY+SPLvcms7LDUQKGAgAAAJoCAABpz4A==
Date: Thu, 11 Jan 2024 10:00:54 +0000
Message-ID:
 <BJSPR01MB05957755EEAE00C9B853927D9E68A@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
References: <20240111025531.2875-1-chunhau.tan@starfivetech.com>
 <5e2b83c5-8b13-4d95-8346-1ad36a937129@linaro.org>
 <7a25ce75-e4da-42b5-92ca-3e46b8e1ffba@linaro.org>
In-Reply-To: <7a25ce75-e4da-42b5-92ca-3e46b8e1ffba@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0595:EE_|BJSPR01MB0497:EE_
x-ms-office365-filtering-correlation-id: e4ff475d-8bef-4f07-613b-08dc128c332f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4/uDluzV+7GoLcC3s8lPColkDFZD1Ii8xu11ZB2/0sZxr/S1OgtYPzirTYFsTQBwezrG/q5NQcxywrANsF/xu9+QypdkGGQePE1G9GaOin2+CcKUK/+Vp4vlw1JP7jjMwB4uQsv6ZAFCUzS916sJo3QJe4q0tx/f0D4TnWBzVALXlk8A4sXYMCrKSXPpq7QKqcvWSUBXvfNVTJmunFJtSALAbWPZLMdLAlXmzbSU8Q+zaq+KWwEwgVww4yLyg3UJsE45gxZldouFDYBURjrhjE5GsUGGXdcdTspZtsPjxV2TStk2Fp4qPK3twbU6LV7xU7F/78MSD5NfXGqwJmSCr+82ZtRem5Pk1LSqgC7CnWr00C+9mjqPeCigTgBJJWr4uV8S4DZerkkAeNQLhrXVZKW6rREeeBnmlfSXn6JfZtO9cubhCHUPFK92ar3rHxV+Sh/hy336g+iTaGnN3ZArosQuXKBRYloEjST7y7r1Ii1rSQo/S3bq6mhao2f3W/98F4IxhijGFIRovaYHOfpwoMdtAmKTFwIXFhaZyZcCHpZsMUeE5bdF8aueMe80D3X2y6/OF3O6RfXVmeSgEob1tQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39830400003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41320700001)(83380400001)(26005)(54906003)(40160700002)(53546011)(9686003)(55016003)(76116006)(64756008)(66476007)(66946007)(110136005)(66556008)(66446008)(4326008)(8676002)(71200400001)(8936002)(38100700002)(921011)(508600001)(7696005)(122000001)(40180700001)(41300700001)(5660300002)(38070700009)(86362001)(7416002)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1VsR3E2M2N0OFNJbGlPMDNnaTFtMDRHRkpjbVlrL1NRWXVBYm5RRUg5WE5z?=
 =?utf-8?B?SjZtQlBMZk5JWlJEVGZWdmRiRDJNWTltRnFCNDhjbGhQUFBWMVpkVXArKy93?=
 =?utf-8?B?Q1d4Sy9FeEdnRHhHR1V1RXVFVmRSYXpGTnZPMEpFR2M5K2htUFhuTVd0STdL?=
 =?utf-8?B?dHVaTVJQQnZhYU5RWVdaVzh4VUZlTHY0Q3BTRkc1SnYxTVBTS2pSMmUwd2Vt?=
 =?utf-8?B?VHVqVmdQN3MwN0Q0VUVFK081ZmsyOGFDZjJ4c3dtWlNTbnYxVmJobUJvbTNC?=
 =?utf-8?B?dGNpOHZlUVFGd2xsNkZBcVBXZXRGWHlRbkJyVW9RTi8yMERYTkx4ak1LZnNj?=
 =?utf-8?B?UXh0Y2N6RkRkT05pb04wN1g0N2tDUVZOWHQ3cTcxR1FvaUJyRDJvVWJCVlJB?=
 =?utf-8?B?RzRueUtGNUUxcForaG9EV0JKTjJickFPSVRzS3pCaDZwWkFtdUNLOGRJVGZn?=
 =?utf-8?B?dithbk1JTXY2eVQxWWcvbERjMHRMdU1IZ3lUZ1dkaElVV3FCdFFiTHNLWG9J?=
 =?utf-8?B?UTV5alNPNlFGWE5oaFRza1BaSU1XRHJHZmNKVEs3dUI0b2gwYldMS3pGU1RK?=
 =?utf-8?B?KzAwL1B5VkZmZ0thanQreHQydGVOWGFWS2J5aGszK2pBandMNy9KNnZsajJh?=
 =?utf-8?B?cXhZODFPb05FK0k5TE1yNmVyWlFhb093ejY3T3dpMGxkeEpoWnVndFljQXQ3?=
 =?utf-8?B?aTk1bEdKK0ZrNWlRQjIvZ2xZTkRzMHRmRVMvZm9aMk1naHlsNUMrUFRtWkhC?=
 =?utf-8?B?OW1UNUxRVEVkQklQSVZ2RmQvbHY0a2V5Z3I0cm1aQW1YaVlwSlBmOWNDNHFq?=
 =?utf-8?B?ekU1dzhaS3QvMDFIVlBYUEpubGo2WkZ1bVdKdkZCellQYTBqVFc5QnFCck9w?=
 =?utf-8?B?UjR5MXY2dlNlVFNpVmZIb2VmYUFXQm9Vc0lQaGRDZG81YkVKRm00d1gvMXhF?=
 =?utf-8?B?eGJSeVEyL2NzRkNsY0NsVlhocDRMRzNOcDVQL0hMZFJQYTZPcVh2L0g4Ukdv?=
 =?utf-8?B?QTJSTTBZV3paU3ExRjVzNUFLd0JZZmNlbWRLZlpuOHZsaHJWS3hneHRlaHl2?=
 =?utf-8?B?b2E2UndRQWJYNCtmNktRSUtJdXk2QzFTeVcrZlF2eXJidUlMLzRxQjZGZXJa?=
 =?utf-8?B?VEZOTjlPMlNJTnh1T0ZWNkw2dDNMQ0dxYUFWR3BhaDRhQXJwWGdScngxZjdT?=
 =?utf-8?B?L0EwWExWTkNnbjdNQk5NVnNud3czZTF5T3FlWEVyQVVhaE9LNVdEUzNPeVdT?=
 =?utf-8?B?aHZqK2tIMkp0Nld4L1VNcGhtZTRaNVQ0eDhaNktlcW1iVDJNK1lmYUM2Zkkw?=
 =?utf-8?B?cHNmaUtZWkg2cWwrMnNhMEhHZjc1aVZWWmNVN0tmWm9TU2I4ajFodTEvaFZS?=
 =?utf-8?B?MW56MTZGa2Z5WWVheXlBTllYTGZrMldpdDZ5MkJQWE9kRWJQNDNUTmZhY3BK?=
 =?utf-8?B?T3FaQ25rRkp3NXRqc2hmNzNWMTg1QnlKUUZSUGN3WTcyUjlVM1IzN25oZ1RX?=
 =?utf-8?B?akdRMUFVTUdPb0laV1NLSGZTZjRkRFJxaTFkSUkyK212UTZINVRvR0RFbU01?=
 =?utf-8?B?Sndkb1o3SkFYTDd1ZVFUMzJWZDc2K2Y2MWFhdXB3bk5DNW1vdngrdXZqUnJW?=
 =?utf-8?B?VHRET0N5R0t6VWF6d21DSnJsWkZyNG42b2JVRUdXMHlhRTlaeHBTVWVKMHJM?=
 =?utf-8?B?ZlArUlU5ZkdZRjV1VVg4dDFkNkVhU21wUytnU0MycG14U3YyYUs2RXZ6SEVW?=
 =?utf-8?B?emtLMy9zUVRta1FzcTVzY2dsN2E1azRGc1hvVUVaNDRubmlScUFLY3VHRU8z?=
 =?utf-8?B?aHdSWVVHakVXNFJabTBKL3NoWkhCUGpNOEdidnRsTzhiN1FiNWdYRi93c3Nj?=
 =?utf-8?B?d0FTeUZYaFR0TDhOM09iNk5LZitEY2puSjcvY1RKaGNoZFNUQlowNE1PNElj?=
 =?utf-8?B?M3p4cE1jZC94ekhCYk5VeHlLOTQrRTlHbEVXaEgrTnRUSkp6aFBSTGtlbXRT?=
 =?utf-8?B?ZXlkeE9OZVJHTTdoK0hpSnhxYVFmMkVneWRiK3JsTHpFZ0J6ZnBvdUJUWm9R?=
 =?utf-8?B?Uk1pOENxbHRDWjNrWTVJVm9GaERBL01IcnhNNVgvY2Y5a1BVVXFkWEF1elhs?=
 =?utf-8?B?UGg0UDhZK0hjeEYyRW9ab0tNQmYvcFJtQlZFblNEb1I4eXQwaWFIUHlWakYr?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ff475d-8bef-4f07-613b-08dc128c332f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 10:00:54.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1oyAGxxYFgp7hVQglewWJtDVAohsx4wd6QPezp3AmcAD7sDK7KFhczAw+Nr3KoMcKyH2Gi7NT8DSXBPRlXoXozvuwdRQJ4wgWggxlU6xXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0497

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
MTEgSmFudWFyeSwgMjAyNCA0OjAzIFBNDQo+IFRvOiBDaHVuSGF1IFRhbiA8Y2h1bmhhdS50YW5A
c3RhcmZpdmV0ZWNoLmNvbT47IERhdmlkIFMgLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5u
ZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUm9i
IEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEVtaWwgUmVubmVyIEJlcnRoaW5nIDxr
ZXJuZWxAZXNtaWwuZGs+OyBSb2IgSGVycmluZw0KPiA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsNCj4gQ29u
b3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTWF4aW1lIENvcXVlbGluDQo+IDxtY29x
dWVsaW4uc3RtMzJAZ21haWwuY29tPjsgQWxleGFuZHJlIFRvcmd1ZQ0KPiA8YWxleGFuZHJlLnRv
cmd1ZUBmb3NzLnN0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47IEJhcnRv
c3oNCj4gR29sYXN6ZXdza2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz47IEFuZHJl
dyBIYWxhbmV5DQo+IDxhaGFsYW5leUByZWRoYXQuY29tPjsgSmlzaGVuZyBaaGFuZyA8anN6aGFu
Z0BrZXJuZWwub3JnPjsgVXdlDQo+IEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5n
dXRyb25peC5kZT47IFJ1c3NlbGwgS2luZw0KPiA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+
DQo+IENjOiBMZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT47IEplZUhl
bmcgU2lhDQo+IDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb207
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtcmlzY3ZAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvMV0gQWRkIFN0YXJG
aXZlIEpIODEwMCBkd21hYyBzdXBwb3J0DQo+IA0KPiBPbiAxMS8wMS8yMDI0IDA5OjAyLCBLcnp5
c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+IE9uIDExLzAxLzIwMjQgMDM6NTUsIFRhbiBDaHVu
IEhhdSB3cm90ZToNCj4gPj4gQWRkIFN0YXJGaXZlIEpIODEwMCBkd21hYyBzdXBwb3J0Lg0KPiA+
PiBKSDgxMDAgZHdtYWMgaGFzIG9uZSByZXNldCBzaWduYWwgaW5zdGVhZCBvZiAyIHJlc2V0cyBh
cyBpbiBKSDcxMTAuDQo+ID4+DQo+ID4+IENoYW5nZXMgaW4gdjI6DQo+ID4+IC0gRHJvcCBkcml2
ZXIgcGF0Y2guDQo+ID4NCj4gPiA/IEJ1dCBkZXZpY2VzIGFyZSBub3QgY29tcGF0aWJsZSwgc28g
aG93IGNhbiBpdCB3b3JrPw0KPiANCj4gV2FpdCwgeW91ciBzZWxlY3QgY29uZnVzZWQgbWUuLi4g
bGF0ZXIgeW91IG1hZGUgdGhlbSBjb21wYXRpYmxlLg0KDQpTb3JyeSBmb3IgY29uZnVzaW5nLCBs
ZXQgbWUgdHJ5IHRvIGV4cGxhaW4gaW4gZGV0YWlsLA0KRm9yIEpINzExMCwgdGhlcmUgYXJlIHR3
byByZXNldHMgKHN0bW1hY2V0aCAmIGFoYikNCkZvciBKSDgxMDAsIHRoZXJlIGFyZSBvbmx5IGEg
cmVzZXRzIChzdG1tYWNldGgpDQpBbmQgYm90aCBhcmUgdXNpbmcgc2FtZSBkcml2ZXIgY29kZSAo
ZHdtYWMtc3RhcmZpdmUuYyksIGFuZCANCmluIHRoZSBkcml2ZXIgY29kZSBhY2tub3dsZWRnZXMg
eyAuY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaDcxMTAtZHdtYWMiCX0gDQoNCkluIHYyIHBhdGNo
LCBJIHRyeSB0byBtYWtlIGFtZW5kIHRoZSB5YW1sIGZpbGUgYnkgYWRkaW5nICJzdGFyZml2ZSxq
aDgxMDAtZHdtYWMiDQphbmQgcHJvdmlkZSBpbmZvIHJlZ2FyZGluZyB0aGUgZGlmZmVyZW5jZXMg
aW4gcmVzZXRzLg0KDQpGb3IgbG9hZGluZyB0aGUgZHJpdmVyIGZvciBKSDgxMTAsIA0KV2lsbCBp
bmNsdWRpbmcgInN0YXJmaXZlLGpoNzExMC1kd21hYyIgaW4gZGV2aWNlIHRyZWUgZmlsZSwNCg0K
cGxlYXNlIHJlZmVyIHRvIGJlbG93IGV4YW1wbGUgb2YgSkg3MTEwICYgSkg4MTAwIGRldmljZSB0
cmVlIGZpbGU6DQoNCkV4YW1wbGUgb2YgSkg3MTEwOg0KZ21hYzA6IGV0aGVybmV0QDE2MDMwMDAw
IHsNCgkJCWNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3MTEwLWR3bWFjIiwgInNucHMsZHdtYWMt
NS4yMCI7DQoJCQlyZXNldHMgPSA8JmFvbmNyZyBKSDcxMTBfQU9OUlNUX0dNQUMwX0FYST4sDQoJ
CQkJIDwmYW9uY3JnIEpINzExMF9BT05SU1RfR01BQzBfQUhCPjsNCgkJCXJlc2V0LW5hbWVzID0g
InN0bW1hY2V0aCIsICJhaGIiOw0KCQl9Ow0KDQpFeGFtcGxlIG9mIEpIODEwMDoNCmdtYWMwOiBl
dGhlcm5ldEAxNjAzMDAwMCB7DQoJCQljb21wYXRpYmxlID0gInN0YXJmaXZlLGpoODEwMC1kd21h
YyIsICJzdGFyZml2ZSxqaDcxMTAtZHdtYWMiLCJzbnBzLGR3bWFjLTUuMjAiOw0KCQkJcmVzZXRz
ID0gPCZhb25jcmcgSkg4MTAwUlNUX0dNQUMwPiwNCgkJCXJlc2V0LW5hbWVzID0gInN0bW1hY2V0
aCI7DQoJCX07DQoNClBsZWFzZSBzaGFyZSB3aXRoIG1lIGlmIHlvdSBoYXZlIGFueSBzdWdnZXN0
aW9ucywgdGhhbmsgeW91Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

