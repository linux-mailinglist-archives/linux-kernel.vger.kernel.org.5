Return-Path: <linux-kernel+bounces-5817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 437BB818FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639551C20BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2C1DFE4;
	Tue, 19 Dec 2023 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="A8dguRqf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2099.outbound.protection.outlook.com [40.107.114.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB31DDE9;
	Tue, 19 Dec 2023 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiCL372oKzCMuaCdX/fudaoJQPKO0uCAAMK8kMslKN9zNAB6FZPjl6pZNuMjzfLV6v0JodWPWQY1Jc16OWtJJEeaGHfwczK9tdG2/60ZccaB/ByDz9u9NjAt5Ad0SUmbU8wTDwgrVgRd19KcJr2sR5t1dkDvQ8cQp2od4Mwd0VeZyx1H54ufAQom1/21shbz0c+XPXu6Cc+kIJAuyF2mWpsWECefg+rFa9Eejnd0JFoELWICKLe2mM8N2CdhmpPl/EtlcFaCKmUVr3l/6naN0bnpWrbL+8uuv4W8yyZSqaGkLFTt0ySINblVddSd2ldqcirbC8eTnye6CGuSSovXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu5KswyY/bT3JxfS9TvLaYTTEY01uxvJ+OzBmP9i1YM=;
 b=gCEUcpsq87Zfmfytihk8mzzAuofC8aGESTf53H08z+RdatCGjfPA5ot+Aw/8bJe4zFQfTPpG0L0/SbHPoOTwLm2lptkcpwDS8kwPk9K8TogliKdRSYTbumWfYhONwb1RXukQ6dCSthbdX5gWaI3qt2+HuA72JqVc9syNElqqklujIygfnvV7OC5EFE5Bl+cr7p0O0QYIU1OzNWhThKD7KaF7Te3kFXNB5mVhNDjR/PxMBIJmmmijt8MPdR7t5o3WALt8XTfi8CT9rO+gKY4Df7ZzQVMsQ7c9NeZHJa3XgervBMBbyirs1kYnYtT1jYy3UAIofLaaUHKY2yOmgMIXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu5KswyY/bT3JxfS9TvLaYTTEY01uxvJ+OzBmP9i1YM=;
 b=A8dguRqfKXxWLcPmyYaP9/NyOJAQ5vP0EazZtMjAr4SVXCnggqYFRDiPMTJHf5yS7EfoTSCopa1Fv1tJc18jMu+rUf2XBbaBgT05GLAeQUR9tmm7x0Q/szG39U6IymRUe/bc5vKVZL5qifghCwUjAlRu3pyhlm3jy6oaMUO5UsE=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB9451.jpnprd01.prod.outlook.com (2603:1096:400:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17; Tue, 19 Dec
 2023 18:38:30 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::6a25:e98a:8e0c:c57c]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::6a25:e98a:8e0c:c57c%7]) with mapi id 15.20.7113.010; Tue, 19 Dec 2023
 18:38:30 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor@kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, "prabhakar.csengg@gmail.com"
	<prabhakar.csengg@gmail.com>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Atish Patra <atishp@rivosinc.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, "apatel@ventanamicro.com"
	<apatel@ventanamicro.com>, "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
	Bjorn Topel <bjorn@rivosinc.com>, "suagrfillet@gmail.com"
	<suagrfillet@gmail.com>, "jeeheng.sia@starfivetech.com"
	<jeeheng.sia@starfivetech.com>, "petrtesarik@huaweicloud.com"
	<petrtesarik@huaweicloud.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Thread-Topic: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Thread-Index:
 AQHaKE/Uj1kSBoBrKE6vg5v7tZ0OfrCdyoEAgAACn4CAEyD4gIAAAXdggAAMFQCAAAcsUA==
Date: Tue, 19 Dec 2023 18:38:30 +0000
Message-ID:
 <OSZPR01MB7019F6BECABB1C57BBC8FAE0AA97A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References:
 <OSZPR01MB70195C6084CF2CDA5EE13D68AA97A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <mhng-378700ef-2f59-431a-bba6-2c70e0584738@palmer-ri-x1c9a>
In-Reply-To: <mhng-378700ef-2f59-431a-bba6-2c70e0584738@palmer-ri-x1c9a>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB9451:EE_
x-ms-office365-filtering-correlation-id: 5e37c71a-88d2-47e8-b915-08dc00c1b267
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3lNnIpF0HaAGMHvlVAN6664IxCBjeVf46F02/MjluVk4Fi5+QMAxSEPovAFFG8nDaqcbTRuWae/Q+oUvh6Oxq6dxQfkZGiCUjezLmCWteSytDRQhf6/RSempfrf3pYf4W2bxPKfm+i3V4KK1n/XA/K0ajKFiDxJVoH88+cT30KmOiuIdZo4T6KGXNhihWF/SyDwBR7Z16ORGAP97Dp593zR5Clj+nbfigO8mKuy0kKkAKyoO1+ttaUpO7chIv6gZSbFxbiQqCG0dsxRavNeRYGwfSGhR0YGtenmCVZyt2hN6aukEAGAu1Ifrp+VTgVdm97lGGOFwFuS68icJSZ1cs8liQyI37sn1Mzr7Dd2pxGguxjl4uPsgYfa4OXJmfFMUbJmNEW0NqKMhX3C/jNqfn7AxJFB3PEUukPSiLDzkXhxo+jA8hnX4vIffhkxfNE3Ku+8MZRCTYmDTksw4Nhf6Q94FPZKJ5K5DQvz1DqmHsBp142U3WF5M5iDHjg51woATYBgzaOo9EI51c19onbzjedHaCyv3t7LdUKSEkug7fB56wC3DjrhxJ1PKHOOmE/yMLrT/hd3EmAL/gdIPjTcr0kwrVsLetd0FFAruJizT52HwIRs0UvVfQM+K2QgEQXNP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(4326008)(8676002)(2906002)(55016003)(966005)(478600001)(52536014)(45080400002)(316002)(6916009)(66556008)(66476007)(76116006)(64756008)(66946007)(71200400001)(66446008)(54906003)(7696005)(5660300002)(9686003)(83380400001)(122000001)(38100700002)(33656002)(7416002)(6506007)(86362001)(38070700009)(53546011)(41300700001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUh3TkxaZEpidEU3bHI2OElLQVlSTTBpbkhQS1IwRU51QStDbTZIVDBLSy9V?=
 =?utf-8?B?S0JQR253c2pJbUZTVzlEM2xjdTJDbjQ4Q3FIMG5LeitraDQzM3Y2YUt4Slhi?=
 =?utf-8?B?T1QyWnFWSFRVZ3hmSG9RTDV0WmF0MXNDa0lTYngyZmRmYmJ4dXdRZmpldTl4?=
 =?utf-8?B?MjFZQm5FMEZiVUtzck1UMWtZQU9TQlFNK1FuL05yOC81RklOdFU2U0FIT0Fw?=
 =?utf-8?B?bTc2aGFuZGk1ZlFGblJlTStMMmJySkRaR1FCTDh4dVQ3KzQrdmJ0QXNkUi9Z?=
 =?utf-8?B?Q29zZVFXK3lobmo1WnIxNmV2anhsMzl4NHozLyt3MUlVL2JGOFYvbjdwSklt?=
 =?utf-8?B?S0VhVlpOUWNnVi8xUVFXM1h5VGZ5akplRWNqRnMzQ0Nsa01MYUxncnEySGs1?=
 =?utf-8?B?bzMyTnJBTFROOTV2M2Q0QWdKK0s5Q0xBd1R6cmR6VHFlSnhNUkM2NDlwSzNx?=
 =?utf-8?B?UVpDWnJTcWJYcTMvWDN4aHMyejJPd1lvZ2h4aEp1eTdSSE42cWNndUhSTjdX?=
 =?utf-8?B?QWtQekxRR2VRdzZuV2o2UlpTSE5QWmFoa29QVWhSaFFWc0tHelhPN3Joc2kr?=
 =?utf-8?B?dG5aZlFYR1E2dEN1Q3BmUXBwRzJiazFBQ2R3cEZoaUZuRWxWclVTN25keFIr?=
 =?utf-8?B?bUZnYnh4RS9xaEZEU3lyY3JvanFxZFhZWTBvTjVQU1oyOGx3eEI5bnI0VVhU?=
 =?utf-8?B?UGtZVk5xaFUwdmhHNG5Iblh0ZlVmQVpxMlFpRCtjYmxzZWx5c1BpWkpyMGFt?=
 =?utf-8?B?QXl6K0NDT01GOWdTZm5MVWwwcGlVbXB1VzFac3RjamJwZkhDeStJY2N1a3B1?=
 =?utf-8?B?U2RDS09hbmlsVS9PdVg2S3V4QXZGU0xWeHhNaVpjUVNIOE15NVhDM01hL28z?=
 =?utf-8?B?Q0ZEYnNOZmQ1bEhSWHJmU1JvYXY3UmVxMllGMEhtbzFOUXNob1hBbHlrdnor?=
 =?utf-8?B?L1ZqMFNYZW9PTW1NU1c2d3BRNHFJYm5tMjdFNmViWGQzZXhFUHdLTHVPTlRX?=
 =?utf-8?B?b1hRZHdKWlN1L3ZON2toWWQwNFdidUxqbVQrckV6ajVLRUlYS3RKVHVKaHoz?=
 =?utf-8?B?ZGRFSHE1R3VweEgwYjVQQ0JIcGZjeit6dktHdlc1Z1cyWnMxcUZTU2FhWkov?=
 =?utf-8?B?eWc0bEV6UWt5ZGRGV1NvY3krTC9lL2xUZGV6T2x5THdaNDRmSFRyRXZkOE95?=
 =?utf-8?B?VGtJb21FeEFya25ibXJqSXNtNkxScDA5Mk5TZXFNTkVmUG1hMS9Xc0doT3l0?=
 =?utf-8?B?aFIyZnoxYUoyeXRkaDRTUTlmclcySVF1ckNzb3NOQ0cwYVZDMmdxNzJOV3Q2?=
 =?utf-8?B?ZktTTDFPVmVBbFpPWFZ1c0Y5VjlQdzA4Uno2RHFVd215bUovZGpqZE43SXh4?=
 =?utf-8?B?UUlmYWRCR3BERGFyOHpleTdUQ2FZcndJZ3Rua2lGVjVGMGdXT0Z5aksxY0Rm?=
 =?utf-8?B?d3BZZ1VDUUpFVmdnQkFZZG4wZTZNbmZPQXhDZithMTRGY3ZESDQrR3ErT2tC?=
 =?utf-8?B?WkFjczFIK3VjMzBhQnowekVkaEVJMlpkaXRNSUk5dHB0bFFIU3o5S25XYXpX?=
 =?utf-8?B?ai9lMVNaZFdjNzlaVkRScGlwK1VzSnYwU0hhQm44SUh5d01DYWxSN0plSUdY?=
 =?utf-8?B?RHUza2xLWTkyR0ZVY2N4NDF3MzcrNlBLQ3A3WEcwbTRTWFRGRVg0YWdrV1NJ?=
 =?utf-8?B?WllBNzNjUDg5UTFDcEFuT0pXSkpFYjNjYW5WYnFNMDBIZCtON0puV2QxbHkw?=
 =?utf-8?B?VkNER1dURnU3WXdBOEpLTGZEQmY0L0p0eWxsUmI2aE05RU1xLytjQXVjVkpU?=
 =?utf-8?B?L25QUnRXTUlneWwzNndiRHhZSENFdVhGdEVmNDR1bVZuaXRybUM0bXU3US9D?=
 =?utf-8?B?Z2JaZktmNUpWTDRqK0xTa2kzdmxGZVY2c204WXl6YXZGcUk0N0RUaHpNNnRX?=
 =?utf-8?B?N25GaERhRVc0V3QxWW1CSG9HVE1zWmNJZFZMOFhEOTlvYW16M29aZWVtS1dh?=
 =?utf-8?B?bjE0S2c3cDRyQWRFZTY1ZHBtWkNPVzFaOGJkWURSZWFWZzgvYnc1Wjc5TmYx?=
 =?utf-8?B?cUEwS2xhQlp2bmRzZXpobXl4TVd2dTBaeWNqa0JlaGRFRmc0d09TT1JzRzIw?=
 =?utf-8?B?blk2NGJGWUFrSEtETmRvMWJqZDNPQmFmWWM2WHRrV0dHNVIwa2VTY0xOcTNq?=
 =?utf-8?Q?MJt99bjXbkxNnfo94FbYuMs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e37c71a-88d2-47e8-b915-08dc00c1b267
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 18:38:30.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7vPQF68o7K3pI8YYf5RELcWQXUSFdfQe/PAVq5jqj7ThY221DnrySnoGpr8iy8y4DPSS5Tj6Yi3erfjqxCUb/cr8jAMaY6EDcc7Q80AHXOtckAKn7QRr+rIHJG+W9RO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9451

SGkgUGFsbWVyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhbG1l
ciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVy
IDE5LCAyMDIzIDY6MDcgUE0NCj4gVG86IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2Fy
Lm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBDYzogQ29ub3IgRG9vbGV5IDxjb25v
ckBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT47
DQo+IHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tOyBnZWVydCtyZW5lc2FzQGdsaWRlci5iZTsg
QXRpc2ggUGF0cmEgPGF0aXNocEByaXZvc2luYy5jb20+OyBQYXVsIFdhbG1zbGV5DQo+IDxwYXVs
LndhbG1zbGV5QHNpZml2ZS5jb20+OyBhcGF0ZWxAdmVudGFuYW1pY3JvLmNvbTsgYWxleGdoaXRp
QHJpdm9zaW5jLmNvbTsgQmpvcm4gVG9wZWwNCj4gPGJqb3JuQHJpdm9zaW5jLmNvbT47IHN1YWdy
ZmlsbGV0QGdtYWlsLmNvbTsgamVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbTsNCj4gcGV0cnRl
c2FyaWtAaHVhd2VpY2xvdWQuY29tOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJFOiBbUkZUIDEvMl0gUklTQy1WOiBoYW5kbGUgbWlzc2luZyAibm8tbWFwIiBw
cm9wZXJ0aWVzIGZvciBPcGVuU0JJJ3MgUE1QIHByb3RlY3RlZCByZWdpb25zDQo+IA0KPiBPbiBU
dWUsIDE5IERlYyAyMDIzIDA5OjI3OjQyIFBTVCAoLTA4MDApLCBwcmFiaGFrYXIubWFoYWRldi1s
YWQucmpAYnAucmVuZXNhcy5jb20gd3JvdGU6DQo+ID4gSGkgQ29ub3IsDQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ29ub3IgRG9vbGV5IDxjb25vckBr
ZXJuZWwub3JnPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxOSwgMjAyMyA1OjE4IFBN
DQo+ID4+IFRvOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiA+
PiBDYzogTGFkLCBQcmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPjsgUGFsbWVy
IERhYmJlbHQNCj4gPj4gPHBhbG1lckBkYWJiZWx0LmNvbT47DQo+ID4+IGdlZXJ0K3JlbmVzYXNA
Z2xpZGVyLmJlOyBBdGlzaCBQYXRyYSA8YXRpc2hwQHJpdm9zaW5jLmNvbT47IFBhdWwNCj4gPj4g
Z2VlcnQrV2FsbXNsZXkgPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47DQo+ID4+IGFwYXRlbEB2
ZW50YW5hbWljcm8uY29tOyBhbGV4Z2hpdGlAcml2b3NpbmMuY29tOyBCam9ybiBUb3BlbA0KPiA+
PiA8Ympvcm5Acml2b3NpbmMuY29tPjsgc3VhZ3JmaWxsZXRAZ21haWwuY29tOw0KPiA+PiBqZWVo
ZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tOyBwZXRydGVzYXJpa0BodWF3ZWljbG91ZC5jb207IGxp
bnV4LQ0KPiA+PiByaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiA+PiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBQcmFiaGFrYXIgTWFoYWRl
diBMYWQNCj4gPj4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4g
Pj4gU3ViamVjdDogUmU6IFtSRlQgMS8yXSBSSVNDLVY6IGhhbmRsZSBtaXNzaW5nICJuby1tYXAi
IHByb3BlcnRpZXMgZm9yDQo+ID4+IE9wZW5TQkkncyBQTVAgcHJvdGVjdGVkIHJlZ2lvbnMNCj4g
Pj4NCj4gPj4gSGV5LA0KPiA+Pg0KPiA+PiBPbiBUaHUsIERlYyAwNywgMjAyMyBhdCAwMToxMToy
M1BNICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+ID4+ID4gT24gVGh1LCBEZWMgMDcsIDIw
MjMgYXQgMDE6MDI6MDBQTSArMDAwMCwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+ID4+ID4gPiBP
biBXZWQsIERlYyA2LCAyMDIzIGF0IDI6MjbigK9QTSBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPiA+PiA+ID4gPiBPbiBXZWQsIERlYyAwNiwgMjAyMyBhdCAwNDo1Mjox
MUFNIC0wODAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToNCj4gPj4gPiA+ID4gPiBPbiBUaHUsIDEw
IEF1ZyAyMDIzIDAyOjA3OjEwIFBEVCAoLTA3MDApLCBDb25vciBEb29sZXkgd3JvdGU6DQo+ID4+
ID4NCj4gPj4gPiA+ID4gPiA+IEknbSBwZXJmZWN0bHkgaGFwcHkgdG8gZHJvcCB0aGlzIHNlcmll
cyB0aG91Z2gsIGlmIHBlb3BsZQ0KPiA+PiA+ID4gPiA+ID4gZ2VuZXJhbGx5IGFyZSBvZiB0aGUg
b3BpbmlvbiB0aGF0IHRoaXMgc29ydCBvZiBmaXJtd2FyZSB3b3JrYXJvdW5kIGlzIGlsbC1hZHZp
c2VkLg0KPiA+PiA+ID4gPiA+ID4gV2UgYXJlIHVuYWZmZWN0ZWQgYnkgaXQsIHNvIEkgY2VydGFp
bmx5IGhhdmUgbm8gcHJlc3N1cmUgdG8NCj4gPj4gPiA+ID4gPiA+IGhhdmUgc29tZXRoaW5nIHdv
cmtpbmcgaGVyZS4gSXQncyBteSBkZXNpcmUgbm90IHRvIGJlDQo+ID4+ID4gPiA+ID4gPiB1c2Vy
LWhvc3RpbGUgdGhhdCBtb3RpdmF0ZWQgdGhpcyBwYXRjaC4NCj4gPj4gPiA+ID4gPg0KPiA+PiA+
ID4gPiA+IElJVUMgeW91IGd1eXMgYW5kIFJlbmVhcyBhcmUgdGhlIG9ubHkgb25lcyB3aG8gaGF2
ZSBoYXJkd2FyZQ0KPiA+PiA+ID4gPiA+IHRoYXQgbWlnaHQgYmUgaW4gYSBzcG90IHdoZXJlIHVz
ZXJzIGFyZW4ndCBhYmxlIHRvIHVwZGF0ZSB0aGUNCj4gPj4gPiA+ID4gPiBmaXJtd2FyZSAoaWUs
IGl0J3Mgb3V0IGluIHByb2R1Y3Rpb24gc29tZXdoZXJlKS4NCj4gPj4gPiA+ID4NCj4gPj4gPiA+
ID4gSSBkdW5ubyBpZiB3ZSBjYW4gcmVhbGx5IGtlZXAgdGhpbmtpbmcgbGlrZSB0aGF0IHRob3Vn
aC4gSW4NCj4gPj4gPiA+ID4gdGVybXMgb2YgcGVvcGxlIHdobyBoYXZlIGRldmljZXRyZWVzIGlu
IHRoZSBrZXJuZWwgYW5kIHN0dWZmDQo+ID4+ID4gPiA+IGF2YWlsYWJsZSBpbiB3ZXN0ZXJuIGNh
dGFsb2cgZGlzdHJpYnV0aW9uLCBzdXJlLg0KPiA+PiA+ID4gPiBJIGRvbid0IHRoaW5rIHdlIGNh
biBhc3N1bWUgdGhhdCB0aGF0IGNvdmVycyBhbGwgdXNlcnMgdGhvdWdoLA0KPiA+PiA+ID4gPiBj
ZXJ0YWlubHkgdGhlIHN5bnRhY29yZSBmb2xrcyBwb3AgdXAgZXZlcnkgbm93IGFuZCB0aGVuLCBh
bmQgSQ0KPiA+PiA+ID4gPiBzdXJlIGhvcGUgdGhhdCBBbmRlcyBldGMgaGF2ZSBsYXJnZXIgY3Vz
dG9tZXIgYmFzZXMgdGhhbiB0aGUNCj4gPj4gPiA+ID4gaW4ta2VybmVsIHVzZXJzIHdvdWxkIHN1
Z2dlc3QuDQo+ID4+ID4gPiA+DQo+ID4+ID4gPiA+ID4gU28gSSdtIGFkZGluZyBHZWVydCwgdGhv
dWdoIGhlIHByb2JhYmx5IHNhdyB0aGlzIG1vbnRocyBhZ28uLi4NCj4gPj4gPiA+ID4NCj4gPj4g
PiA+ID4gUHJhYmhha2FyIG1pZ2h0IGJlIGEgZ29vZCBjYWxsIG9uIHRoYXQgZnJvbnQuIEknbSBu
b3Qgc3VyZSBpZg0KPiA+PiA+ID4gPiB0aGUgUmVuZXNhcyBzdHVmZiB3b3JrcyBvbiBhZmZlY3Rl
ZCB2ZXJzaW9ucyBvZiBPcGVuU0JJIHRob3VnaCwNCj4gPj4gPiA+ID4gZ3Vlc3MgaXQgZGVwZW5k
cyBvbiB0aGUgc2VxdWVuY2luZyBvZiB0aGUgc3VwcG9ydCBmb3IgdGhlDQo+ID4+ID4gPiA+IG5v
bi1jb2hlcmVudCBzdHVmZiBhbmQgd2hlbiB0aGlzIGJ1ZyB3YXMgZml4ZWQuDQo+ID4+ID4gPiA+
DQo+ID4+ID4gPiBBVE0sIEkgZG9udCB0aGluayB0aGVyZSBhcmUgYW55IHVzZXJzIHdobyBhcmUg
dXNpbmcgdGhlIHVwc3RyZWFtDQo+ID4+ID4gPiBrZXJuZWwgKyBPcGVuU0JJIChhcGFydCBmcm9t
IG1lIGFuZCBHZWVydCEpLiBDdXJyZW50bHkgdGhlDQo+ID4+ID4gPiBjdXN0b21lcnMgYXJlIHVz
aW5nIHRoZSBCU1AgcmVsZWFzZXMuDQo+ID4+ID4NCj4gPj4gPiBUaGF0IGRvZXNuJ3QgcmVhbGx5
IGFuc3dlciB3aGV0aGVyIG9yIG5vdCB5b3UgKGFuZCB5b3VyIGN1c3RvbWVycykNCj4gPj4gPiBh
cmUgdXNpbmcgYW4gYWZmZWN0ZWQgdmVyc2lvbiBvZiB0aGUgdmVuZG9yIE9wZW5TQkk/DQo+ID4+
ID4gVGhlIGFmZmVjdGVkIHJhbmdlIGZvciBPcGVuU0JJIGl0c2VsZiBpcyBbdjAuOCB0byB2MS4z
KS4NCj4gPj4NCj4gPj4gRGlkIHlvdSBwZXJoYXBzIG1pc3MgdGhpcyBtYWlsIFByYWJoYWthcj8N
Cj4gPj4NCj4gPiBPb3BzIHNvcnJ5IGZvciB0aGF0Lg0KPiA+DQo+ID4gSSBjYW4gY29uZmlybSB0
aGUgQlNQIHZlcnNpb24gdXNlZCBieSB0aGUgY3VzdG9tZXJzIGlzIHYxLjAgWzBdLg0KPiA+DQo+
ID4gWzBdDQo+ID4gaHR0cHM6Ly9qcG4wMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aA0KPiA+IHViLmNvbSUyRnJlbmVzYXMtcnolMkZyel9v
cGVuc2JpJTJGY29tbWl0cyUyRndvcmslMkZPcGVuU0JJLVBNQSUyRiZkYXQNCj4gPiBhPTA1JTdD
MDIlN0NwcmFiaGFrYXIubWFoYWRldi1sYWQucmolNDBicC5yZW5lc2FzLmNvbSU3QzAxNGNmNGRk
ZmQxZTQ4DQo+ID4gMWZmNWJjMDhkYzAwYmQ0NjdmJTdDNTNkODI1NzFkYTE5NDdlNDljYjQ2MjVh
MTY2YTRhMmElN0MwJTdDMCU3QzYzODM4Ng0KPiA+IDA2MDEzMDQxMDczMSU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU0NCj4gPiB6SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJnNkYXRhPWEwdGNzWFk0
RVFsT0RpDQo+ID4gSTM0UXlnWFM5UXBKblZCcUw4Yk5reEU4TjVKMmclM0QmcmVzZXJ2ZWQ9MA0K
PiANCj4gT0ssIHNvIHNvdW5kcyBsaWtlIHdvdWxkIGVuZCB1cCB3aXRoIGJyb2tlbiBzeXN0ZW1z
IGZyb20gdGhpcyBidWcsIHRoZW4/DQo+IA0KPiBJSVJDIHdlIHN0aWxsIGhhdmUgdGhlIFJlbmVz
YXMgc3lzdGVtcyBhcyBOT05QT1JUQUJMRSBkdWUgdG8gdGhhdCBETUEgcG9vbCBLY29uZmlnIGNv
bmZsaWN0LiAgU28gaWYNCj4gaXQncyByZWFsbHkgb25seSB0aGVzZSBSZW5lc2FzIHN5c3RlbXMg
dGhhdCBoYXZlIHRoZSBidWcsIG1heWJlIHdlIGNhbiBzdGlsbCByZW1vdmUgaGliZXJuYXRpb24g
ZnJvbQ0KPiBOT05QT1JUQUJMRSBhbmQganVzdCBhZGQgaW4gc29tZSBzb3J0IG9mIEtjb25maWcg
dG8gZGlzYWJsZSB0aGUNCj4gUmVuZXNhcytoaWJlcm5hdGlvbiBjb21iaW5hdGlvbnMgdGhhdCB3
b3VsZCBicmVhaz8NCj4gDQpXZWxsIGN1c3RvbWVycyB1c2luZyBCU1AgdXNlcyB2MS4wIGZvciBP
cGVuU0JJIGFuZCBrZXJuZWwgNS4xMC1jaXAsIGFuZCBwZW9wbGUgd2FudGluZyB0byBydW4gdXBz
dHJlYW0ga2VybmVsIHdpbGwgaGF2ZSB0byBvbmx5IHVzZSB0aGUgdXBzdHJlYW0gT3BlblNCSSBh
cyB0aGUgT3BlblNCSSB1c2VkIGluIEJTUCBpcyBub3QgY29tcGF0aWJsZSB3aXRoIHVwc3RyZWFt
IGtlcm5lbChMaW51eCBkb2VzbuKAmXQgYm9vdHVwKS4NCg0KQVRNIEkgY2FuIHNheSB0aGF0IGl0
cyBvbmx5IG1lIGFuZCBHZWVydCB1c2luZyB1cHN0cmVhbSBPcGVuQlNJIGFuZCB1cHN0cmVhbSBr
ZXJuZWwuDQoNCldpdGggdGhhdCBpbiBtaW5kIHdvdWxkIHdlIHN0aWxsIHJlcXVpcmUgdGhhdCBj
aGFuZ2U/DQoNCkNoZWVycywNClByYWJoYWthcg0K

