Return-Path: <linux-kernel+bounces-5691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9251818E14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCB11C2491B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572931A6C;
	Tue, 19 Dec 2023 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mUr9dixL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E735298;
	Tue, 19 Dec 2023 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Wy+dqEMD0fD3SiSoQTCMIh22G6kunTv2KgK0jEZ8iYFc+ATSTSZJlMZSF8Vp7JGo37rEwECbARKRDAw/ZWEZWD8OdHt/U9Liu4QTn6wiY+mS2NgqS3xhe1H6ZiwiEixsTpY5dVqlZ+4/yG6gVr8KpwSXtsevjTimHU8TQVFGtPKZy2i16UHn9INq8YfVTe+VLkPQYzISeYcDuYBtfr+7dviqUAenwbeuqcV2JpiVBCGOSAK+iPn8NLBhizYdRzOH+oZqgwaPS4OOo/IsP+TSwo/8AJCNSA+r5fGaiUBqAOddifSscbZCMnmV8a8xUBY0DhVX2xZX+hoMSJVpy7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qs7qhJZEK00nHJVzGUyo/djSx+sHwko+KwvbKoGAoA=;
 b=OmUQ+UvTtiNDnBmbqAGHTKtfb9EZvjeU/hHyxo5SdE9EPWlTayFE63OU0cGBCmPybWVx+6/64E4eQg1zVAcNqs4mjkpq2MTrH1YUIEQH7JoyWooPkdiCFYq642BS7MQCjl0h2jui4pIK8L3UT2cK8b0y57jz47BSgz+o0x6pRhbWUizTeGR0aTCFVw/Ta/p4O4V+0bpUGuFw02KL0Vbp3J7y9GIqPmt2luqnsPF8LLsVSAa3+D37qhUDiqYsEFdccbsZ728biws7qC1IpcPS6qpXhgL1IglbHkasbQtpqN9rR67W7ZsfwRqYYw+5BXy0vWp9Ntrx7r7L1bEEKbPW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qs7qhJZEK00nHJVzGUyo/djSx+sHwko+KwvbKoGAoA=;
 b=mUr9dixLv0dA1dk4CuigNcwdz7ZHDWfLbIKaUCtuW02FFGw8NP08oz4VG4SzUm4gEqq+3t0bcjMjPtXUtNvuqxCvZpPJdJ7vCldUNLufnHVnpHk/FhtsXDzEjyGs9MlP2aqOzE1o4b6tO8+JK7JbghoLctg4GMz4UyCT7dBKs5A=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS7PR01MB11682.jpnprd01.prod.outlook.com (2603:1096:604:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 17:27:44 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::6a25:e98a:8e0c:c57c]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::6a25:e98a:8e0c:c57c%7]) with mapi id 15.20.7113.010; Tue, 19 Dec 2023
 17:27:43 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Conor Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
CC: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, "geert+renesas@glider.be" <geert+renesas@glider.be>,
	Atish Patra <atishp@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>, "alexghiti@rivosinc.com"
	<alexghiti@rivosinc.com>, Bjorn Topel <bjorn@rivosinc.com>,
	"suagrfillet@gmail.com" <suagrfillet@gmail.com>,
	"jeeheng.sia@starfivetech.com" <jeeheng.sia@starfivetech.com>,
	"petrtesarik@huaweicloud.com" <petrtesarik@huaweicloud.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Thread-Topic: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Thread-Index: AQHaKE/Uj1kSBoBrKE6vg5v7tZ0OfrCdyoEAgAACn4CAEyD4gIAAAXdg
Date: Tue, 19 Dec 2023 17:27:42 +0000
Message-ID:
 <OSZPR01MB70195C6084CF2CDA5EE13D68AA97A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20230810-crewless-pampers-6f51aafb8cff@wendy>
 <mhng-550dee8b-a2fb-485b-ad4d-2763e94191b4@palmer-ri-x1c9>
 <20231206-precut-serotonin-2eecee4ab6af@spud>
 <CA+V-a8s3MjvpD8gAE7-mOUc6PEytbPOR6x_PHuw0J0hOLkaz-w@mail.gmail.com>
 <20231207-buffalo-varmint-de843c8a12bb@wendy>
 <20231219-fernlike-device-4d7186aa4deb@spud>
In-Reply-To: <20231219-fernlike-device-4d7186aa4deb@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS7PR01MB11682:EE_
x-ms-office365-filtering-correlation-id: 79956af2-4961-436f-f8b5-08dc00b7cee5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PWIDz8DIJ8tTpVP4/6o6ceydPHStzuIgWwgd1IKSeIuy23I/teP0m75B8Yd6OfobkKXJvwEDLjG4gNIfoH57SFCeBo3dk3QHTZBxe1526qvVkSdbqZSRw4WzF4Ghk7/Z8Hcv1+lV9V6z2vLirqL135ex6h9Ao35FuXt2lJ1o3uzOqYPZexHxDG81faLIi+CLtfS7/flR/4SxQdpaj6dy+C2S8qd0ORiyg5M1y8MMNAjVjgzlFCNSk6eaCiZhLR7vqSgDkEG8EBbk4j28wqQmIuBQ8ixolW3ljhFcskkpOuZlB/fNheees3R99pAVF3ojU12txibsSB66G3EaVHDtcXT6y7vp9d7rXKTHSaI3FLRrs2WGGcJM6koQvlvkamkIQx4pAh60XwGV2uYcen2/3g+WfZsp3nCBo2uSTlNwQLJod7s3AjxTHZpj2q/gH2eeW+bJ0te5WVl9uu8b4i4zqbcBx8su4MzhyaqwtgSMqFNQk/srM05wVz/Ta5YYOaCV2sqApKxjOoLhOV7075SyeDvCTvkGoqG6e+D6bkWCV+N/mqGAxOI8iH8z0ByLxvdcNUO5zIVUWDeviLIJGd4Vji/7MMRYUuJh7uVunIxPmkM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38070700009)(52536014)(55016003)(4326008)(8676002)(8936002)(38100700002)(122000001)(5660300002)(7416002)(2906002)(478600001)(966005)(66946007)(64756008)(54906003)(76116006)(110136005)(66446008)(66476007)(66556008)(316002)(26005)(83380400001)(41300700001)(9686003)(53546011)(71200400001)(86362001)(7696005)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SytUVjUyd20vUUtZb3I2MlVDV0kzOUdMeTdTZmRJRjhGOUlKMy9ZQlFlRU1N?=
 =?utf-8?B?Q1FoaUxjTEpIaUZwZU9SYTZEQzhFLzZ5QXJoUWJ1cloyZkdFenRKUW0wQkRk?=
 =?utf-8?B?TW81bWFTLzBZVkx5MTVjU2lQa2VGUXJWeHNoMTBMZXp2T0trZDk3bUY3RVF2?=
 =?utf-8?B?NS9QQTBBSGdPNWFOSU5zcVhRKzZBMW4rblJjQ1FFc0orVThSZERIL0tWb1hE?=
 =?utf-8?B?M3ovdkdwK1NDQ0dNS1RYNTBUblphZW4yOE15d1Fndjl6eHZudURJUjBIdmcw?=
 =?utf-8?B?OVA1VjFSck5hWE1YaFhTeEJhbERjdXVXL1BlSkdpbk1GMVVsSDRHZ2NEK0NI?=
 =?utf-8?B?eWdkaVF3VTBPZDQ0bHNYVFN2MWxKTWtCOEVlOTNXcU5mZUg1b2ZVMkpEdU85?=
 =?utf-8?B?eW0vSU1oMitJWVQrUkVzWE5ZQ0xJaXNRbUtRNUxWZUo3VlZlQk5QSWc1UGEw?=
 =?utf-8?B?TUQyYStkeXlvNVB5bm9GM3gyTzRRYzdoa2UyVEMvN3BmWk9QTm54N0o3dUtZ?=
 =?utf-8?B?blhuV2syOHJ3YXBZdUFXWS9TUnFXM0hmT3lHaUVyR0V4Q0NwcHdKbVMxdm5P?=
 =?utf-8?B?b2pZdzlWaTdnOTE4VDdNVURIckFpa0JJbkN2ZWVnSnhMbGphZHh5bzA3cENX?=
 =?utf-8?B?M0RSc2E5d2crcVVsSnVHa2lMd0l2amJzYXpRS3NUaEpONEE4dUY4cFdjMThi?=
 =?utf-8?B?amdyU2ordE5zUlQvUTNQdlZwTGtXRGRIaUp2eVhacCs3bmx2Q2NCR081c2NB?=
 =?utf-8?B?dlJiWTJEamJXRGZKYXpDeTY4aTJCaGFqcUh0Ykt6aWREcjFnTTdJYkN2S0Yr?=
 =?utf-8?B?MStqZE1aRjA1WGhnTGswN1JTM2drWFRtbm9GdkFGQ29KeWJoYXZCT1FiZzVZ?=
 =?utf-8?B?YWJlbEZOZ2xCNkExc3RRM3hFNFZDbmZnV3cwNUtKZTc0Q01BTlp3VGhaeDJl?=
 =?utf-8?B?QW5tZEEyeUJpbE4zUzV3YzgvU0ZCUHg5SzBEMkROUUxVaUk4U0lXeUxZelkv?=
 =?utf-8?B?QkJqajZUYlVzQkFsNzA1c3BMVW5Jb2RjMjdiMHNPY0VVV2VuN0tudDQ0WDR5?=
 =?utf-8?B?TFNvaDFXblA4OWpOS2pITlNXV2NNb0g0LzZ5eTJEZk9IZGJCR21hWTZqaUxy?=
 =?utf-8?B?WFMyS1FrRVg3eEdab3FWQnE3eW5zd1lDRUhFMzRFUEx5TWFrd1lTY2hWUmhr?=
 =?utf-8?B?dXVybEJMUEhtSi96bTRONXZGekgrQjduRVFxaWdiSUJaMVVqR01qZEVUNExt?=
 =?utf-8?B?dEk5VTJhTDRZWHVkZEVvZGlKaFJ5aGZrdCttZDJaVHRHVTdDNEtNdmYyOGNz?=
 =?utf-8?B?WU9zUHZVWW9Gb3NIL2p3d2M0em9sMXJ3V1F6WlI3SEJrYkhPNDFtS0luK3Rj?=
 =?utf-8?B?Nk45ZXk5OEp6a3d3TE82aGRDN281YTR3U0xWVUlicldoNFNuV3hRbDhrcW9j?=
 =?utf-8?B?OUJhYmU2MktPd0pvcU5HRFJzUGJDOUFOTytrTFlHaFlXTU9oeGY1MXA2NElD?=
 =?utf-8?B?S2poQitSMDcxcjNvdm4xcEhHOVN0LzQ5TXAwNDN6VE1aNUhKTFh2MWpNVTNq?=
 =?utf-8?B?eVR4U2o5Mnl4eWoyamVSRmpvMy9Eamd5MHBueGd5dk9GNURNQVgxZmVWS20y?=
 =?utf-8?B?NWpKeG1Yd0VtRkdJeE5iR3BhVnF2d0RISTYyYTRGRjB2SS9CbitHQ3VYYXE4?=
 =?utf-8?B?YVJ0cEJicUZURUJyVXd1bm54alc0Ryt6d2puS0Mvc09xdDFzZUdPUlZnVk9k?=
 =?utf-8?B?cG10MGlQbWFkQUZOWUl1KzBpZm1uV0pUWmlpYWR4cHFnd2paUUo2eUVkaktZ?=
 =?utf-8?B?VldhSktqVFFiSnZMdzh4V3gxd0E2U2k0NFBiZjZYRDVGRUMrR0htUHF5OGdk?=
 =?utf-8?B?SVV5MytvajkxT2JhR0FZUEEzN1N4cmpYQUFiN0lIdUdOTjd5NnUvY2dVQkVy?=
 =?utf-8?B?UFhuTFpEUVJqNjFpb2tnT3VIUFhMK2p1c0ZzYW5hc3QrYVI0RWlqM1k2QjYy?=
 =?utf-8?B?cG5xZmRCSWRRNnAzYTNpd3ZGakNMN2lReEJSOGQ1TmdlSkdqMmFiYkROUGV3?=
 =?utf-8?B?Z0MxcHBVbzFTeDFnbWxGd3E4bmNlTk53QVVFdUl3c1Z1bXNIcm5Nc2ZWcUk5?=
 =?utf-8?B?L2pqWXFMZXExNURHc2Mxc3VNa3RvcGtTR2hNdjVuaU41SCtwYm9CaVQ4YXI4?=
 =?utf-8?Q?UtHc8ihHk0CfRMtflXT2zjQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79956af2-4961-436f-f8b5-08dc00b7cee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 17:27:42.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDPP8CsTGkp8cM3uPcf2IMDI0/Jq/SzTyaYrqRXkndaAynMTeGAQP0+WCt7c92ArvrIXJUuw+U5uATtCCgZGzY2Ljd3PqLG2NjKjZOiSobo0vRjPFWuNKPZ6sKozegl5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11682

SGkgQ29ub3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29ub3Ig
RG9vbGV5IDxjb25vckBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxOSwg
MjAyMyA1OjE4IFBNDQo+IFRvOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAu
Y29tPg0KPiBDYzogTGFkLCBQcmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPjsg
UGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47DQo+IGdlZXJ0K3JlbmVzYXNAZ2xp
ZGVyLmJlOyBBdGlzaCBQYXRyYSA8YXRpc2hwQHJpdm9zaW5jLmNvbT47IFBhdWwgV2FsbXNsZXkg
PHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47DQo+IGFwYXRlbEB2ZW50YW5hbWljcm8uY29tOyBh
bGV4Z2hpdGlAcml2b3NpbmMuY29tOyBCam9ybiBUb3BlbCA8Ympvcm5Acml2b3NpbmMuY29tPjsN
Cj4gc3VhZ3JmaWxsZXRAZ21haWwuY29tOyBqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tOyBw
ZXRydGVzYXJpa0BodWF3ZWljbG91ZC5jb207IGxpbnV4LQ0KPiByaXNjdkBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwu
b3JnOyBQcmFiaGFrYXIgTWFoYWRldiBMYWQNCj4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBi
cC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRlQgMS8yXSBSSVNDLVY6IGhhbmRsZSBt
aXNzaW5nICJuby1tYXAiIHByb3BlcnRpZXMgZm9yIE9wZW5TQkkncyBQTVAgcHJvdGVjdGVkIHJl
Z2lvbnMNCj4gDQo+IEhleSwNCj4gDQo+IE9uIFRodSwgRGVjIDA3LCAyMDIzIGF0IDAxOjExOjIz
UE0gKzAwMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4gPiBPbiBUaHUsIERlYyAwNywgMjAyMyBh
dCAwMTowMjowMFBNICswMDAwLCBMYWQsIFByYWJoYWthciB3cm90ZToNCj4gPiA+IE9uIFdlZCwg
RGVjIDYsIDIwMjMgYXQgMjoyNuKAr1BNIENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4g
d3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgRGVjIDA2LCAyMDIzIGF0IDA0OjUyOjExQU0gLTA4MDAs
IFBhbG1lciBEYWJiZWx0IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgMTAgQXVnIDIwMjMgMDI6
MDc6MTAgUERUICgtMDcwMCksIENvbm9yIERvb2xleSB3cm90ZToNCj4gPg0KPiA+ID4gPiA+ID4g
SSdtIHBlcmZlY3RseSBoYXBweSB0byBkcm9wIHRoaXMgc2VyaWVzIHRob3VnaCwgaWYgcGVvcGxl
DQo+ID4gPiA+ID4gPiBnZW5lcmFsbHkgYXJlIG9mIHRoZSBvcGluaW9uIHRoYXQgdGhpcyBzb3J0
IG9mIGZpcm13YXJlIHdvcmthcm91bmQgaXMgaWxsLWFkdmlzZWQuDQo+ID4gPiA+ID4gPiBXZSBh
cmUgdW5hZmZlY3RlZCBieSBpdCwgc28gSSBjZXJ0YWlubHkgaGF2ZSBubyBwcmVzc3VyZSB0bw0K
PiA+ID4gPiA+ID4gaGF2ZSBzb21ldGhpbmcgd29ya2luZyBoZXJlLiBJdCdzIG15IGRlc2lyZSBu
b3QgdG8gYmUNCj4gPiA+ID4gPiA+IHVzZXItaG9zdGlsZSB0aGF0IG1vdGl2YXRlZCB0aGlzIHBh
dGNoLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSUlVQyB5b3UgZ3V5cyBhbmQgUmVuZWFzIGFyZSB0
aGUgb25seSBvbmVzIHdobyBoYXZlIGhhcmR3YXJlDQo+ID4gPiA+ID4gdGhhdCBtaWdodCBiZSBp
biBhIHNwb3Qgd2hlcmUgdXNlcnMgYXJlbid0IGFibGUgdG8gdXBkYXRlIHRoZQ0KPiA+ID4gPiA+
IGZpcm13YXJlIChpZSwgaXQncyBvdXQgaW4gcHJvZHVjdGlvbiBzb21ld2hlcmUpLg0KPiA+ID4g
Pg0KPiA+ID4gPiBJIGR1bm5vIGlmIHdlIGNhbiByZWFsbHkga2VlcCB0aGlua2luZyBsaWtlIHRo
YXQgdGhvdWdoLiBJbiB0ZXJtcw0KPiA+ID4gPiBvZiBwZW9wbGUgd2hvIGhhdmUgZGV2aWNldHJl
ZXMgaW4gdGhlIGtlcm5lbCBhbmQgc3R1ZmYgYXZhaWxhYmxlDQo+ID4gPiA+IGluIHdlc3Rlcm4g
Y2F0YWxvZyBkaXN0cmlidXRpb24sIHN1cmUuDQo+ID4gPiA+IEkgZG9uJ3QgdGhpbmsgd2UgY2Fu
IGFzc3VtZSB0aGF0IHRoYXQgY292ZXJzIGFsbCB1c2VycyB0aG91Z2gsDQo+ID4gPiA+IGNlcnRh
aW5seSB0aGUgc3ludGFjb3JlIGZvbGtzIHBvcCB1cCBldmVyeSBub3cgYW5kIHRoZW4sIGFuZCBJ
DQo+ID4gPiA+IHN1cmUgaG9wZSB0aGF0IEFuZGVzIGV0YyBoYXZlIGxhcmdlciBjdXN0b21lciBi
YXNlcyB0aGFuIHRoZQ0KPiA+ID4gPiBpbi1rZXJuZWwgdXNlcnMgd291bGQgc3VnZ2VzdC4NCj4g
PiA+ID4NCj4gPiA+ID4gPiBTbyBJJ20gYWRkaW5nIEdlZXJ0LCB0aG91Z2ggaGUgcHJvYmFibHkg
c2F3IHRoaXMgbW9udGhzIGFnby4uLg0KPiA+ID4gPg0KPiA+ID4gPiBQcmFiaGFrYXIgbWlnaHQg
YmUgYSBnb29kIGNhbGwgb24gdGhhdCBmcm9udC4gSSdtIG5vdCBzdXJlIGlmIHRoZQ0KPiA+ID4g
PiBSZW5lc2FzIHN0dWZmIHdvcmtzIG9uIGFmZmVjdGVkIHZlcnNpb25zIG9mIE9wZW5TQkkgdGhv
dWdoLCBndWVzcw0KPiA+ID4gPiBpdCBkZXBlbmRzIG9uIHRoZSBzZXF1ZW5jaW5nIG9mIHRoZSBz
dXBwb3J0IGZvciB0aGUgbm9uLWNvaGVyZW50DQo+ID4gPiA+IHN0dWZmIGFuZCB3aGVuIHRoaXMg
YnVnIHdhcyBmaXhlZC4NCj4gPiA+ID4NCj4gPiA+IEFUTSwgSSBkb250IHRoaW5rIHRoZXJlIGFy
ZSBhbnkgdXNlcnMgd2hvIGFyZSB1c2luZyB0aGUgdXBzdHJlYW0NCj4gPiA+IGtlcm5lbCArIE9w
ZW5TQkkgKGFwYXJ0IGZyb20gbWUgYW5kIEdlZXJ0ISkuIEN1cnJlbnRseSB0aGUgY3VzdG9tZXJz
DQo+ID4gPiBhcmUgdXNpbmcgdGhlIEJTUCByZWxlYXNlcy4NCj4gPg0KPiA+IFRoYXQgZG9lc24n
dCByZWFsbHkgYW5zd2VyIHdoZXRoZXIgb3Igbm90IHlvdSAoYW5kIHlvdXIgY3VzdG9tZXJzKSBh
cmUNCj4gPiB1c2luZyBhbiBhZmZlY3RlZCB2ZXJzaW9uIG9mIHRoZSB2ZW5kb3IgT3BlblNCST8N
Cj4gPiBUaGUgYWZmZWN0ZWQgcmFuZ2UgZm9yIE9wZW5TQkkgaXRzZWxmIGlzIFt2MC44IHRvIHYx
LjMpLg0KPiANCj4gRGlkIHlvdSBwZXJoYXBzIG1pc3MgdGhpcyBtYWlsIFByYWJoYWthcj8NCj4g
DQpPb3BzIHNvcnJ5IGZvciB0aGF0Lg0KDQpJIGNhbiBjb25maXJtIHRoZSBCU1AgdmVyc2lvbiB1
c2VkIGJ5IHRoZSBjdXN0b21lcnMgaXMgdjEuMCBbMF0uDQoNClswXSBodHRwczovL2dpdGh1Yi5j
b20vcmVuZXNhcy1yei9yel9vcGVuc2JpL2NvbW1pdHMvd29yay9PcGVuU0JJLVBNQS8NCg0KQ2hl
ZXJzLA0KUHJhYmhha2FyDQo=

