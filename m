Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA7179FC58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjINGxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjINGxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:53:41 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65982CF1;
        Wed, 13 Sep 2023 23:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvbFeCXCBzviltvbBxNVuB86dnk58FwiKW7HfVQ0OPYa4mmmKZQAdaCnLFTwGf3cKy8tvJF7Z8qCXsj4Flq7MJNo6prnSWdZ00rOl69OfWWLrLaMqt1cR9Wxu+z52niydD/5sr5EH/50IS7cEZG5PTTeVqxfNDdQACH+LJqz3wkmEiYbppMJo5BdFv7Aei+XbHajoMZ/NHdBMEC1fyUtc2mNZcP/iRP3zwcAjjy3VBPWlm1bJVIAbeAdN5zQ/grmeeu8qAIJoiNDVY4PN4+/u353iuA4uJtRANN5wGUI59Df+KzDWPlttoecqMmhD80KGJrjP9l/lEGhgMLUam31vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqp69CfiKA7yWoE57Ck+Kpt9l24iCssYfp1CzLw7F2U=;
 b=hEdS64WdPKBpAZBy8PCfhMU3pRnsBDZDCpJgclLsRgA/PoKa2LHpVvG0UYBpGvjtrrm1rj3Sdx9kNj7s/yYQkpbk/1kiCOc1XBKqGNjb4i8+ga7V+Hfh895L1gbqBlV8JY+9hDnts3AuTxHgw11QkbQRtwuhqRlu9NgV+VFK6Sfrq/8dOncgZFts7PdqJudUhJ0C1J2fLTlibtulYHmMwRPucZQbxN9yaHlB+Gc5VUZ9xmjxPtuIBRR+s4QGU8Q93I3c2LpNCqUV7QZobNYT7il7n7pxlLQSZRwCuDeej2Ve1iTBxK3ma5+m3DXcNzFLqGT2WuGp7J8wUt9rSFhuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqp69CfiKA7yWoE57Ck+Kpt9l24iCssYfp1CzLw7F2U=;
 b=adfE41bvL+PutmHIJCZemVXazSieC6oTp5SqeIY13v0U0HPL7DBZYmBl5dNALLsYWeeHN7ZwMTauxTaffxFY3a6d/x26K9HVyJZRwDH3FJbXSaoh6bwkRk85AzL3VoychqcDoTCkJ3N/4r6Tk7j63w/26ogCByYWEXkIbVr42jI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 06:53:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 06:53:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 5/5] arm64: dts: imx93: update gpio node
Thread-Topic: [PATCH 5/5] arm64: dts: imx93: update gpio node
Thread-Index: AQHZ5rGG9QLxnHCRQEOiHX1ZRRTVWLAZ0M8AgAACOZCAAAniAIAAA0oA
Date:   Thu, 14 Sep 2023 06:53:34 +0000
Message-ID: <DU0PR04MB94177EF6250838FFFB5FD6D188F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-5-3ed418182a6a@nxp.com>
 <bc122417-6d59-4c1d-3f73-c20711f9a32f@linaro.org>
 <DU0PR04MB941722CE1A9BF9F87946DE0A88F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <9fc4817d-00ae-aaf4-bfb6-b24361f55799@linaro.org>
In-Reply-To: <9fc4817d-00ae-aaf4-bfb6-b24361f55799@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
x-ms-office365-filtering-correlation-id: 2d59697e-299d-4748-bd83-08dbb4ef5060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBDkWxENQ0H8Ayi/0BMkZhtLI/Gm2SqpVSdB3QDg9rt+pPEFNLdzoboRHtYYj/mi91uVw7GFPcTWlcRDoMw4Bc2d8VkovoB1lsZQTV37hdOy/ZFh4BJCl92GXA7hftSq1VrgxQhDFNausC06HT4jhrA3Qq/XKJ8qETp9XRyH8Z478u6yCQ4UUaGS/kjPNFF4x7v25iSUEir1XkNPTJttcZaA1OnXwzJevFoQR1gxfS3pJY+oPtNUpmIFiw+FWKhUUcfA63jiZRvG3NRuMSCt04elvcSAAXnaStA2afcGqLYKxt4MMdG5E7W0V8WMKLQFJ6ir5vqF4m3WoYXXgi7cihWk/RvacbU02mIxicDXcN8X3kfSAwCw4fGB460o2xucKwuK/QDfjyus3bAZ5QHaInv2LKQHtqOmUBA5pVe5ZMEBbL+Il6owj+7+kjHryD9dKmmeO7rwlDNYnLLxrRpQCfff9VHbdTZ3F5vDlvNG2OfBW6TFYv/oZD97YPt3RckK8KTre/VwbBeWhZ8JZEFRmOYUPmFvYGTuEbQVGhj+MPbrH+40p1WM57/tzxyrCh3OLS1kqMmqKXIyw4mEm82XoJrZhyXC/4yoUQDBcn/eTcy+WkppFRmIr5pbQARTsZEnhryuL8EmLhmd+ithXUYszA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(1800799009)(186009)(451199024)(41300700001)(921005)(71200400001)(6506007)(53546011)(7696005)(83380400001)(478600001)(6636002)(8936002)(2906002)(52536014)(110136005)(66946007)(5660300002)(7416002)(66476007)(76116006)(66446008)(66556008)(64756008)(8676002)(316002)(44832011)(26005)(4326008)(54906003)(86362001)(55016003)(9686003)(15650500001)(38100700002)(33656002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkdxV1pMZG0zd1gyOFhsbC9Mc2ZmcFh2SE9jaUlBcDhWQWxRQ3ZsNkVacDJV?=
 =?utf-8?B?ejJNSGNic25DOHQzNkFoSnl3eFlxbUJzK1lER2t0Tk9JWFE1Unk2bE93aFFI?=
 =?utf-8?B?ZTY1RU5VbE8wVjRxWWJTNURzUUFxeGFZWERhcU1mem5Qd0pCbTI3UFFhNXM1?=
 =?utf-8?B?QnJZa1dVWFpnZHNvQkZDalBBcHVtaGtHZ0E0dDN2SnZVeXE2UnYwc1U5Ri80?=
 =?utf-8?B?ZElsNXRKVUZMdkpMM1p0NnhBZVZuYkRxZ3IwQ2lwTGlqT3BDeDI3SjRWMHhS?=
 =?utf-8?B?TlRaaCtHNFhuN3ZLbC9PQlE2UGNaeHo0OVBzUnFHMlJZWUZhaDJObEIvZUt2?=
 =?utf-8?B?YTBSN0VHVy9LYzF0bDlVSXV1QVphTGV4b21QNVp3aDJrTm8rYUh2Ukw3UmYz?=
 =?utf-8?B?TWdTZnFLRzBlTE9ZaHV0ODk1ZjE5NWtuK0FJS21KUitZWVB2dHhaZHZIOEhl?=
 =?utf-8?B?TDBwMkxSVmtnTUlPcFIwb3p5Z2RNVlBGNnRzQks4ekQ2M05KMHVuWlFwTGJB?=
 =?utf-8?B?Vlh0MHUzRUplYWg2WnpSRnUxQ2tIL0x4ZW91ZmVTWDg2N0tmNHJkZ252M1d2?=
 =?utf-8?B?S3NjSE13bVFndGVja3ZLeSs4VW9UeUZUWEJlNE44L2VBaEVUNGFjQjhvQUNQ?=
 =?utf-8?B?OHBZaEZvVXdCclYvY1RRa0FnK2hER2l5SU1XSFZmaVo1aFJmU201WVR1R1VQ?=
 =?utf-8?B?QW9NdjBzVnlRMnFJdkdIUzREWlpRSCs3TEpYNmYwV1VOUXM3eERyN3BQdTQw?=
 =?utf-8?B?NkdhdW5BY3kySU92ODhkajRaUjhPamtCcEYwZVdIWTdqZXFEMXlxaHQxeTdv?=
 =?utf-8?B?QjJla2t1TFE1eU1yL3NKTlpkaFdta1FsVGdLd09ZOHEzYTVPZFVFOVBkK1lh?=
 =?utf-8?B?SmFlMS9jWHlVbjVWVHN3WFVrTVVhb0xjN3JURWxETnQ1ZHA3cXZ2YUZ6OVVQ?=
 =?utf-8?B?d203b3FOaVBMd01kVDJWbEd6MkMrU1FmQm1NRU5BNXlUbWNzKzIzbjF0NGdw?=
 =?utf-8?B?OE94S3NTNnQ4YlJoeUpualdCQ2pzSzZubitQZ0VHdzlFRTUvMkRLcVVlRkpM?=
 =?utf-8?B?N1IvUG9wSmt6aVMyRVEvanRlb2JZQ1REcktpSVd3RWwzZ0ZxVkduRW1UOE51?=
 =?utf-8?B?enJIUjFxMjlDWWRVc1RUdGJpandzRVltUzMwY2l0VWdSUkpqMHgvTXhjd2x6?=
 =?utf-8?B?SVdzTjZvSHA0cWl0cVYyazZPU2NkZC9HWTIxNHFBVHpaOUY4YXl1bTcyNVBR?=
 =?utf-8?B?OHh4UVFob2RyRDBWak5xdnpIWHJDS0lCOEVtZWhrQnFaMjVPY2JyQjlRWTB1?=
 =?utf-8?B?djU2UzVCQ21pY1VoNGlIdFc0QUtRSENKWVh1cHd0K2hQOWJySm0ya3NzRlVv?=
 =?utf-8?B?MVZ6WVhjeUE3SHJ5MVNtS0ZKMlVOL3NPUDFSZldMeFdIa3ZEcHZ5aG1sNVZs?=
 =?utf-8?B?cVJNN0hVSXQ3VUNKUDB5K2cxV2V1akM0RFJGU3A3U3lnUUpkQmxtSGpFTjkw?=
 =?utf-8?B?WGpGRU8wc09hUkIxSjRkQ2NaYjZMUmUwL2lBTUoyam5rRUIyZ1Q5T24vL2d2?=
 =?utf-8?B?V1l6d2VCOEtabzFmSGF2T2t6SHJBaHpIY200RS9aanNKb2g4QWlOZ2RDM1Zk?=
 =?utf-8?B?OFlDWWJqbXczZ0djdTJXWjk1VWpsWDVHWDI0U1E4bmk1S05iWlc3TGU4QTVX?=
 =?utf-8?B?YXk2SkdjRHJEYWZDTjBmZTVIU2tWZFpqYjY1aHU3dFU1Q0VGaVo0bXczQ3Ny?=
 =?utf-8?B?M1Z4YTJQU2IveXZBckM3MGg1NW45YXIyYTZQOXhTWE5zY1hHblpFb3lvdkZZ?=
 =?utf-8?B?Y0s5NVVNVWRoaTVoK3kwM2w0aG5GVGFVejB5SFFZa3ZRaER4TGNSRFR5bHVT?=
 =?utf-8?B?bGlrclFBNUVCQ3JzS0VuMnE3MitlVy95eVpBUXZuZFJicUoycVkwNVJuVkJ6?=
 =?utf-8?B?Y2JORnd5dXFxZTFpR1pSdmloL25oQUIvb05OU3NhU0s4TUJyQjZUbGZKcHhM?=
 =?utf-8?B?ZDN3VDBWbmNOeEc3T2FSZ3hnSER0NGtITXVRN2hHSTMyeFF4TEQ5ZzdDMjNj?=
 =?utf-8?B?U0VQVkdVOFkyaE5aSi8wSDZ2U3RMRWVxZHc2T0VWNW1HRkd6MlYxbi9tUSt0?=
 =?utf-8?Q?xvns=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d59697e-299d-4748-bd83-08dbb4ef5060
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 06:53:34.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ARZMCYrKsiJOOi3v2rD7SLWWcgQ2SsC9oXYH9pa/OxFk+f5MhhDSXl6dLx4KO6UjbYTycGgJeRcI/Xb8pCeAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNV0gYXJtNjQ6IGR0czogaW14OTM6IHVwZGF0ZSBncGlv
IG5vZGUNCj4gDQo+IE9uIDE0LzA5LzIwMjMgMDg6MDQsIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBT
dWJqZWN0OiBSZTogW1BBVENIIDUvNV0gYXJtNjQ6IGR0czogaW14OTM6IHVwZGF0ZSBncGlvIG5v
ZGUNCj4gPj4NCj4gPj4gT24gMTQvMDkvMjAyMyAwNDoyMSwgUGVuZyBGYW4gKE9TUykgd3JvdGU6
DQo+ID4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4+DQo+ID4+PiBQ
ZXIgYmluZGluZyBkb2MsIGkuTVg5MyBHUElPIHN1cHBvcnRzIHR3byBpbnRlcnJ1cHRzLCBhbmQg
bm90DQo+ID4+PiBjb21wYXRpYmxlIHdpdGggaS5NWDdVTFAuIFNvIHVwZGF0ZSB0aGUgbm9kZQ0K
PiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+Pj4gLS0tDQo+ID4+PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRz
aSB8IDIwICsrKysrKysrKysrKy0tLS0tLS0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4gPj4+IGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+Pj4gaW5kZXggNmY4NWEwNWVlN2Ux
Li4wMTFjMzRhNTdjNTMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg5My5kdHNpDQo+ID4+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg5My5kdHNpDQo+ID4+PiBAQCAtODI1LDExICs4MjUsMTIgQEAgdXNkaGMzOiBtbWNA
NDI4YjAwMDAgew0KPiA+Pj4gIAkJfTsNCj4gPj4+DQo+ID4+PiAgCQlncGlvMjogZ3Bpb0A0Mzgx
MDA4MCB7DQo+ID4+PiAtCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OTMtZ3BpbyIsICJmc2wsaW14
N3VscC1ncGlvIjsNCj4gPj4+ICsJCQljb21wYXRpYmxlID0gImZzbCxpbXg5My1ncGlvIiwgImZz
bCxpbXg4dWxwLWdwaW8iOw0KPiA+Pg0KPiA+PiBBcyB5b3VyIGRyaXZlciBjaGFuZ2UgcG9pbnRz
LCBpdCBpcyBicmVha2luZyB1c2Vycywgc28gbm8gOigNCj4gPg0KPiA+IG9rLiBBbHRob3VnaCBp
Lk1YOTMgR1BJTyBpcyBub3QgY29tcGF0aWJsZSB3aXRoIGkuTVg3VUxQIGZyb20gSFcNCj4gPiBw
ZXJzcGVjdGl2ZSwgdGhlIGNvbXBhdGlibGUgc3RyaW5nIHNob3VsZCBrZWVwIGFzIGl0IGlzIG5v
dyBhbmQNCj4gPiBiaW5kaW5nDQo+IA0KPiBJZiBpdCBpcyBub3QgY29tcGF0aWJsZSwgdGhlbiBo
b3cgY291bGQgaXQgd29yayBiZWZvcmU/DQoNCmkuTVg3VUxQIHJlZzoNCjBoIFBvcnQgRGF0YSBP
dXRwdXQgUmVnaXN0ZXIgKFBET1IpIA0KNGggUG9ydCBTZXQgT3V0cHV0IFJlZ2lzdGVyIChQU09S
KSANCjhoIFBvcnQgQ2xlYXIgT3V0cHV0IFJlZ2lzdGVyIChQQ09SKSANCkNoIFBvcnQgVG9nZ2xl
IE91dHB1dCBSZWdpc3RlciAoUFRPUikgDQoxMGggUG9ydCBEYXRhIElucHV0IFJlZ2lzdGVyIChQ
RElSKSANCjE0aCBQb3J0IERhdGEgRGlyZWN0aW9uIFJlZ2lzdGVyIChQRERSKQ0KDQppLk1YOFVM
UC85MyBoYXMgZGlmZmVyZW50IHJlZ2lzdGVycyBhZGRyZXNzLCBidXQgDQppLk1YOTMgcmVnaXN0
ZXJzIGhhcyAweDQwIG9mZiBhcyBiZWxvdzoNCjQwaCBQb3J0IERhdGEgT3V0cHV0IChQRE9SKQ0K
DQpFdmVuIGxpbnV4IGkuTVg3VUxQIGdwaW8gZHJpdmVyIGNvdWxkIHdvcmsgd2l0aCBpLk1YOFVM
UC85Mw0KR1BJTyBIVyB3aXRoIGR0cyBub2RlIHVzaW5nIGFuIDB4NDAgb2Zmc2V0ICsgYmFzZSBh
ZGRyDQpmb3IgaS5NWDkzIGdwaW8uIEkgdGhpbmsgZnJvbSBodyBkZXNpZ24sIHRoZXkgYXJlDQpu
b3QgY29tcGF0aWJsZS4gQmVzaWRlcyB0aGUgdXBwZXIgZGlmZmVyZW5jZXMsDQp0aGVyZSBhcmUg
b3RoZXIgZGlmZmVyZW5jZXMuDQoNClNvIEkgdGhpbmsgYmV0dGVyIG1vdmUgdG8gbmV3IGNvbXBh
dGlibGUgc3RyaW5nLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiANCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
