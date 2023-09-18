Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED07A4922
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbjIRMDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbjIRMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:03:37 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32CE5F;
        Mon, 18 Sep 2023 05:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiAd5TGkfErUT7agV65LMPTSlO+7noAlgvb9EIyiU+msPY8QW5USQ4ibnrzoew+xa5eZSZ2BMgj+ECcWbdiKp6wbafPhefES6L+54g7aSMqaJzxkBv6F1x5uW1Mv9mI7ZnOH34qGe+WUBiILD3pdaeyHBAc363dktmQ0Iabuq3vVEq+Y+T57VTzzaWUShQ1tPfoFxh/0G0rxlGXUxp6mdahU2cpx98u1ceGoWjjWL2PDuGRgSyPFlaS3qo4IbMSowg9BRkV5CVL82JpYF2WNQkf4UkJ7xDRJCXPPv9sHOj6hZYbpyS2jfSLIslzR782lrGtNArzcN7YUQ2rLkCU6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDVJO7zhXXesKFum/FbJZTn8lZIBFoeTYFZa8/2fBbY=;
 b=ZeU4q8AElegHnZPkSYZxK1RXv1kVN/VPd23wNwJQH8ZYdTK2P/DdSpBDv1n1e7RsoWcc9kb5ydP4JsgEU5j1ziGYR7JMCX7DmloP3oW1zc/OSOe5DcUeM4zRY5nUYjy4sJ3NgxD1Hhs3lVjlwcXQ097j73JvKb0GOsppr+a3NeoeLClIjHCOtPtWxEgrecuQ/bTRgpYv67ssNsgwUggee60ZbCk45uvJMv3OpOHAuKAYbN+ZPLl2ufohz4HHryOnrbQRcHt5gPxNRNB2mEpJXKsWphIAXUFSDT6tzRypszXZbc86NfN1mD2Jr+GmiBiiraeLuKaLWIvLLOlj8KhgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDVJO7zhXXesKFum/FbJZTn8lZIBFoeTYFZa8/2fBbY=;
 b=nOVgJ2EjjTz80Yis7oa9WO0m6pGGaHjTitnsdereYlmW49gp4igxKR9Cg1FwivzLWCmvphojPeuyxFcnJiGRfqFa78aHL9YgCltGTZnDp4ouCfvAmCs3MQ+ntnB4Mlgl3l3GKt1vZZVMiB6e9ENMgQE2cFI2ZRsrqaX3oJ+vqGA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8746.eurprd04.prod.outlook.com (2603:10a6:20b:43f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 12:01:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 12:01:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] mailbox: imx: support channel type tx doorbell v2
Thread-Topic: [PATCH 2/2] mailbox: imx: support channel type tx doorbell v2
Thread-Index: AQHZ6WP7qiUe9e+Pf0mwWh1wNBkNbLAgZSqAgAAWpnA=
Date:   Mon, 18 Sep 2023 12:01:16 +0000
Message-ID: <DU0PR04MB94170D1357C13A2EC66A05F488FBA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
 <20230917-imx95-mbox-v1-2-440245287356@nxp.com>
 <CAEnQRZBbdrwX3mq=1RVHwzPAUtWjrKmz3y4ezOann6yZUwZAYA@mail.gmail.com>
In-Reply-To: <CAEnQRZBbdrwX3mq=1RVHwzPAUtWjrKmz3y4ezOann6yZUwZAYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8746:EE_
x-ms-office365-filtering-correlation-id: 6205a82f-803e-4520-8f20-08dbb83ef6b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yjEiLIHMGhQxyqbM26UuMvS2HzudYZYA4I5OoeaaQPyD/+QvZYj24O+BcGgJnfpCAXUbzrOWsBzgkMW9sobKLYEcbvZjciI/WjWv4SJyLHzEf0PjyKqVDCOZZ4CaCjIAPgGrKNygQiy2O43PHM3nquXQVB0ciP6yR1Kw6c57bpM+XMKr3OeHUhOS/BU8qzJJ4bJ2JZmoE9bBTdX1u+HI0ZzbFmodJTIiwkiYdsOgXJl1774qNPr6CBGWrNyBCqGpgzWxp/zlKN0J3PffjI9v5eTy1RWkxXeJVoVoTtDtTtjj3B4r4kGLUUp9pDl/lJDB71ml7QdgC8xVRwerJvYIo+P+gRFNc2BTmvf8G8lvyXgqv8M58L3gQ/iJAQbdS5gvuT+E53DX2qbgVVg83FiEBzN51pFkFhuLrdV3jJX2BA7lIdamu6r10MvzbbKG+m9lGTGmv/W9nyRVrxM/9B6eizjraKQetpuWDB6uu6SusNdbjoEmXE3T0imkbxbzEhfmBd7avgQirXUEpsr8YcrY2SgpGJNqzwmZlc7fvpfnbtE/YEfoBwjtBk2zFBgyf5c4MlhAqUXZQpcPbS8IT0FmPDPC9SyqkL5mIp5t4+8PbC/B1qNMjO30O7og4BMkCdj/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(186009)(1800799009)(451199024)(122000001)(38070700005)(55016003)(38100700002)(86362001)(33656002)(7696005)(6506007)(53546011)(478600001)(52536014)(5660300002)(66946007)(66556008)(54906003)(66446008)(64756008)(44832011)(76116006)(66476007)(2906002)(8676002)(4326008)(8936002)(71200400001)(9686003)(83380400001)(41300700001)(7416002)(110136005)(15650500001)(316002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajdDZkNqMjc3TFBmOTd4WFo5TFM3TjBHeG1DUDFEZ2doYkdBRjVMdzl6WHFK?=
 =?utf-8?B?U2hub1praXlpVEh6ZFRpck1SVi9VZXc1ei9FWjFBMUFRejN1dTdRMjJpdUFO?=
 =?utf-8?B?aDlITHR6OHFDeUx1VUNCbDdMcCtuaXVYVHBtYnJZSXQ0Q1pQdFBRL1NxVW44?=
 =?utf-8?B?TVlJMVBncnZyTWJWL0dFOUNBVlhjSHdhTDJ4KzVBWHVCbWdOVjRTNjQ5Vncy?=
 =?utf-8?B?RmFEV005VXc4S3plclREYVdPUUJjSHhybmppWjEyVk8ydURXOEpYdUdUQkZ0?=
 =?utf-8?B?OXRpZFp1L2FJQVlJeVA5ajlBcHpyYndlWVVIMWpUa1JYNER2TzZUOXl4L3ZQ?=
 =?utf-8?B?bXUvVE93Z2MxaVlkck5NQWhKZEdOdVordU1HWkk1SVZOWGg3a0JJeUlUSlZh?=
 =?utf-8?B?ZVZweHRBV2ttdEpJL2ZOTGg2L1RuZW5xTi9yRTIvWW9DYk1lTHBxL0RVVnY0?=
 =?utf-8?B?Z2cvM1Y0d0VzTTJIQmczaGxxVXEzTWVleW5tMGdHSG0yZUw4RmFQL2xjVUhP?=
 =?utf-8?B?MVR5VDczQ1VZZVFNUUF5TENGa1h6VE1oZ0dya2JDWU1RVU1sdXZlRjNIbXdB?=
 =?utf-8?B?NGdSTE5DdTF2bjBtV1k4OVZvVXladFdVRXExd25VU0g5R2lNcGcrRlptUzBW?=
 =?utf-8?B?OXA4ZkRFZlNFZm16WDZ3dlhSQlN4K2ZtcndJVUI5MEhtQVljLzV6WFZHQ3hD?=
 =?utf-8?B?ZFYzQ1dpY1BCaEdFdzdCaWFnQ1FUa1VzMG9NM3ArS0FKai9kZGNQNk1MWUcy?=
 =?utf-8?B?TE53bVFkbE0waGFZVW1JaG9pN2NaRjNVdFdRZXBWc2NManNxMnpaLy9BR0Zz?=
 =?utf-8?B?WDJzOXYzNFpsRzNYMmdZQ0Jwd1NVSEhvTXhTSHFJZXN6eEF1alpmZ0lvUWRJ?=
 =?utf-8?B?THRxMjFiWW5MV3N0UkNNQVBWeTZRZC9EdWtiQzRQOXluci9Zc2taQ0VYY2Rp?=
 =?utf-8?B?QjNSeGFiY2tScm13U0Y4NFEzSmdRRDBWUGtiWS9vWWk0T3kwbVVyUXl5OCtR?=
 =?utf-8?B?MFd4V3hpaFdzU0xucG5nRDRPS3R4enBuNmpyYzl0S2NlVUgzVFh3YUo1Vmd2?=
 =?utf-8?B?MjZXY0x2clEwYmYvM1NLMkNyb1pheHh5eWY0bWJKd241SUUxQlV5RkJmVjB6?=
 =?utf-8?B?MlRwL0JFTTdoNmpVMTFmNFdOYU1zdGxlL2tSc3Rsak54YmRSZkxQdWlPbmJy?=
 =?utf-8?B?bEtLVmJGZFZyQkxoMXErbllFOVUrdmMrcUxlcXB4TVFjMTVKM0RacFlTZWI5?=
 =?utf-8?B?TjRTSWJIRGVtQ1g3Y3QrMmZUT1NWR3N1Zk14R1VWU1JJYTVXdEhYaDhDdVRQ?=
 =?utf-8?B?VjBpN283MXFaeDkwTG9DYzcyVU9wSlNJTW04S0JJK2Z2Y0xIVGlvb1VPRWxC?=
 =?utf-8?B?OGtqWWpaZXVSTE1kdVFXQ2hDakl4NVY5OWRYdERRcDdQQit0Y2UrMDExRjhy?=
 =?utf-8?B?Q2loVCtDR014c3B3TkNIR2xuMEJPd1I3NlE4VGcyS2xUZEFlTExJL3FLQ0ZI?=
 =?utf-8?B?NDVTb0dTZ3A4Yk9Cc1UxenpJY3N2ZkhSeEM3b1Z4ZkpsS3NkcVZwODZiTkhN?=
 =?utf-8?B?bTZMTFplODl3YjNiODNuTW5nS2FxSkNJNDBiNGlDQkI2SFF6QUNoQStJa2kz?=
 =?utf-8?B?Nko5eTI3alVaL3ZreVpDb2V4TUhtd0kxVUFxWmU1UHQyckJibHZuZHVOUWVG?=
 =?utf-8?B?bjhhcXZnTmI5VXNHeXJWOEYzRUNqUTMwQ1ZPZHQ0SzVxdzVIV0pvaDRIZ29O?=
 =?utf-8?B?VUJrZUtIRnVBblRxQ3hjWVo3clNqSTNEdzUrTlBFcnF4QjVEZFBTa3ZLb1dr?=
 =?utf-8?B?Y29DUUp2U1FFS01mMndHU2ZsQ3BLL0FsaCtacVNBb0gwY0wzVHBoZ0txVmxX?=
 =?utf-8?B?QWZ1SUdGaFIxbEcrb1NaU0NxTklZZTR3eWwxa0ZKN1U1cS9zVE05Tk1JZWdm?=
 =?utf-8?B?cWgrTGtHTEpRMDMwbzBvUTlKbXJEM1laZGlHMUo3VUYwbFBncVRScG4xMGVQ?=
 =?utf-8?B?WnNPRFp4RU1FRUxDSnJJUU1sTWlyU1NtM05iS2NoVXpwR2IrTXpQQ09PN0VJ?=
 =?utf-8?B?dEZDWnlqcUh5T1RWK0ZLdE1UKzFrUFE0YzFlUHdIaWhQUFFHWDRYNmJjdWlU?=
 =?utf-8?Q?3hlU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6205a82f-803e-4520-8f20-08dbb83ef6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 12:01:16.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHdxm9VNbFT7KZ6QWY/vBF+3nUFfRlZv9MViCwyHuA2X/TlMIn/0+Lye9E9APv9NZhRsMHU+2EVrxi+YzVzkzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8746
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBtYWlsYm94OiBpbXg6IHN1
cHBvcnQgY2hhbm5lbCB0eXBlIHR4IGRvb3JiZWxsIHYyDQo+IA0KPiBPbiBTdW4sIFNlcCAxNywg
MjAyMyBhdCA1OjQ14oCvUE0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0K
PiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+
DQo+ID4gVGhlIE1lc3NhZ2UgVW5pdChNVSkgR2VuZXJhbCBQdXJwb3NlIENvbnRyb2wgcmVnaXN0
ZXJzIGFyZSB1c2VkIGZvciBUWA0KPiA+IGRvb3JiZWxsLCBidXQgdGhlcmUgaXMgbm8gaGFyZHdh
cmUgQUNLIHN1cHBvcnQuDQo+ID4NCj4gPiBUaGUgY3VycmVudCBUWCBkb29yYmVsbCBjaGFubmVs
IGlzIHVzaW5nIHRhc2tsZXQgdG8gZW11bGF0ZSBoYXJkd2FyZQ0KPiA+IEFDSyBzdXBwb3J0IHRv
IGtpY2sgdGhlIFRYIHRpY2sgZnJvbSBjb250cm9sbGVyIGRyaXZlciBzaWRlLg0KPiA+DQo+ID4g
VGhlIG5ldyBhZGRlZCBUWCBkb29yYmVsbCBjaGFubmVsIFYyIG5vdCB1c2luZyB0YXNrbGV0IHRv
IGVtdWxhdGUgdGhlDQo+ID4gaGFyZHdhcmUgQUNLIHN1cHBvcnQuIFRoZSBiZWhhdmlvciBmb3Ig
dGhlIGNoYW5uZWwgaXMganVzdCB3cml0aW5nIHRoZQ0KPiA+IEdDUiByZWdpc3RlciwgYW5kIG5v
IGVsc2UuIFRoaXMgd2lsbCBiZSB1c2VkIGZvciBTQ01JIG1haWxib3guDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMgfCAzMiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3gu
Yw0KPiA+IGIvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMgaW5kZXggM2VmNGRkOGFkZjVk
Li4wYWY3MzlhYjU3MWMNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvaW14
LW1haWxib3guYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4g
QEAgLTIwLDcgKzIwLDkgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPg0KPiA+IC0jZGVmaW5lIElNWF9NVV9DSEFOUyAg
ICAgICAgICAgMTcNCj4gPiArI2luY2x1ZGUgIm1haWxib3guaCINCj4gPiArDQo+ID4gKyNkZWZp
bmUgSU1YX01VX0NIQU5TICAgICAgICAgICAyNA0KPiA+ICAvKiBUWDAvUlgwL1JYREJbMC0zXSAq
Lw0KPiA+ICAjZGVmaW5lIElNWF9NVV9TQ1VfQ0hBTlMgICAgICAgNg0KPiA+ICAvKiBUWDAvUlgw
ICovDQo+ID4gQEAgLTM5LDYgKzQxLDcgQEAgZW51bSBpbXhfbXVfY2hhbl90eXBlIHsNCj4gPiAg
ICAgICAgIElNWF9NVV9UWVBFX1RYREIgICAgICAgID0gMiwgLyogVHggZG9vcmJlbGwgKi8NCj4g
PiAgICAgICAgIElNWF9NVV9UWVBFX1JYREIgICAgICAgID0gMywgLyogUnggZG9vcmJlbGwgKi8N
Cj4gPiAgICAgICAgIElNWF9NVV9UWVBFX1JTVCAgICAgICAgID0gNCwgLyogUmVzZXQgKi8NCj4g
PiArICAgICAgIElNWF9NVV9UWVBFX1RYREJfVjIgICAgID0gNSwgLyogVHggZG9vcmJlbGwgd2l0
aCBTL1cgQUNLICovDQo+ID4gIH07DQo+ID4NCj4gPiAgZW51bSBpbXhfbXVfeGNyIHsNCj4gPiBA
QCAtMjI2LDYgKzIyOSw5IEBAIHN0YXRpYyBpbnQgaW14X211X2dlbmVyaWNfdHgoc3RydWN0IGlt
eF9tdV9wcml2DQo+ICpwcml2LA0KPiA+ICAgICAgICAgICAgICAgICBpbXhfbXVfeGNyX3Jtdyhw
cml2LCBJTVhfTVVfR0NSLCBJTVhfTVVfeENSX0dJUm4ocHJpdi0NCj4gPmRjZmctPnR5cGUsIGNw
LT5pZHgpLCAwKTsNCj4gPiAgICAgICAgICAgICAgICAgdGFza2xldF9zY2hlZHVsZSgmY3AtPnR4
ZGJfdGFza2xldCk7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgY2Fz
ZSBJTVhfTVVfVFlQRV9UWERCX1YyOg0KPiA+ICsgICAgICAgICAgICAgICBpbXhfbXVfeGNyX3Jt
dyhwcml2LCBJTVhfTVVfR0NSLCBJTVhfTVVfeENSX0dJUm4ocHJpdi0NCj4gPmRjZmctPnR5cGUs
IGNwLT5pZHgpLCAwKTsNCj4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICBk
ZWZhdWx0Og0KPiA+ICAgICAgICAgICAgICAgICBkZXZfd2Fybl9yYXRlbGltaXRlZChwcml2LT5k
ZXYsICJTZW5kIGRhdGEgb24gd3JvbmcgY2hhbm5lbA0KPiB0eXBlOiAlZFxuIiwgY3AtPnR5cGUp
Ow0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiBAQCAtNTU0LDYgKzU2
MCw5IEBAIHN0YXRpYyBpbnQgaW14X211X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikN
Cj4gPiAgICAgICAgIGludCByZXQ7DQo+ID4NCj4gPiAgICAgICAgIHBtX3J1bnRpbWVfZ2V0X3N5
bmMocHJpdi0+ZGV2KTsNCj4gPiArICAgICAgIGlmIChjcC0+dHlwZSA9PSBJTVhfTVVfVFlQRV9U
WERCX1YyKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiArDQo+ID4gICAgICAg
ICBpZiAoY3AtPnR5cGUgPT0gSU1YX01VX1RZUEVfVFhEQikgew0KPiA+ICAgICAgICAgICAgICAg
ICAvKiBUeCBkb29yYmVsbCBkb24ndCBoYXZlIEFDSyBzdXBwb3J0ICovDQo+ID4gICAgICAgICAg
ICAgICAgIHRhc2tsZXRfaW5pdCgmY3AtPnR4ZGJfdGFza2xldCwgaW14X211X3R4ZGJfdGFza2xl
dCwNCj4gPiBAQCAtNTk1LDYgKzYwNCwxMSBAQCBzdGF0aWMgdm9pZCBpbXhfbXVfc2h1dGRvd24o
c3RydWN0IG1ib3hfY2hhbg0KPiAqY2hhbikNCj4gPiAgICAgICAgIGludCByZXQ7DQo+ID4gICAg
ICAgICB1MzIgc3I7DQo+ID4NCj4gPiArICAgICAgIGlmIChjcC0+dHlwZSA9PSBJTVhfTVVfVFlQ
RV9UWERCX1YyKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X3N5bmMocHJp
di0+ZGV2KTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgICAgfQ0KPiA+
ICsNCj4gPiAgICAgICAgIGlmIChjcC0+dHlwZSA9PSBJTVhfTVVfVFlQRV9UWERCKSB7DQo+ID4g
ICAgICAgICAgICAgICAgIHRhc2tsZXRfa2lsbCgmY3AtPnR4ZGJfdGFza2xldCk7DQo+ID4gICAg
ICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X3N5bmMocHJpdi0+ZGV2KTsgQEAgLTY3MSw2ICs2
ODUsNyBAQA0KPiA+IHN0YXRpYyBzdHJ1Y3QgbWJveF9jaGFuICppbXhfbXVfc3BlY2lmaWNfeGxh
dGUoc3RydWN0IG1ib3hfY29udHJvbGxlcg0KPiA+ICptYm94LCAgc3RhdGljIHN0cnVjdCBtYm94
X2NoYW4gKiBpbXhfbXVfeGxhdGUoc3RydWN0IG1ib3hfY29udHJvbGxlcg0KPiAqbWJveCwNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgb2Zf
cGhhbmRsZV9hcmdzDQo+ID4gKnNwKSAgew0KPiA+ICsgICAgICAgc3RydWN0IG1ib3hfY2hhbiAq
cF9jaGFuOw0KPiA+ICAgICAgICAgdTMyIHR5cGUsIGlkeCwgY2hhbjsNCj4gPg0KPiA+ICAgICAg
ICAgaWYgKHNwLT5hcmdzX2NvdW50ICE9IDIpIHsNCj4gPiBAQCAtNjgwLDE0ICs2OTUsMjUgQEAg
c3RhdGljIHN0cnVjdCBtYm94X2NoYW4gKiBpbXhfbXVfeGxhdGUoc3RydWN0DQo+ID4gbWJveF9j
b250cm9sbGVyICptYm94LA0KPiA+DQo+ID4gICAgICAgICB0eXBlID0gc3AtPmFyZ3NbMF07IC8q
IGNoYW5uZWwgdHlwZSAqLw0KPiA+ICAgICAgICAgaWR4ID0gc3AtPmFyZ3NbMV07IC8qIGluZGV4
ICovDQo+ID4gLSAgICAgICBjaGFuID0gdHlwZSAqIDQgKyBpZHg7DQo+ID4NCj4gPiArICAgICAg
IC8qIFJTVCBvbmx5IHN1cHBvcnRzIDEgY2hhbm5lbCAqLw0KPiA+ICsgICAgICAgaWYgKCh0eXBl
ID09IElNWF9NVV9UWVBFX1JTVCkgJiYgaWR4KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9l
cnIobWJveC0+ZGV2LCAiSW52YWxpZCBSU1QgY2hhbm5lbCAlZFxuIiwgaWR4KTsNCj4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4gKyAgICAgICB9DQo+IA0K
PiBJIGRvbid0IHVuZGVyc3RhbmQgaG93IGlzIHRoaXMgcmVsYXRlZCB0byBpbnRyb2R1Y3Rpb24g
b2YgYSBuZXcgZG9vcmJlbGwNCj4gY2hhbm5lbC4gQ2FuIHlvdSBwbGVhc2UgYWRkIGl0IGluIGEg
c2VwYXJhdGUgcGF0Y2ggd2l0aCBwcm9wZXIgZXhwbGFuYXRpb24/DQoNClJTVCBvbmx5IHN1cHBv
cnRzIDEgY2hhbm5lbCwgYnV0IGl0cyB2YWx1ZSBpcyA0LCBzbyBoZXJlIEkgZXh0ZW5kIHRvIDQg
Y2hhbm5lbA0KZm9yIFJTVCBpbiBjb2RlLCB0byBtYWtlIHRoZSBjYWxjdWxhdGlvbiBhIGJpdCBl
YXNpZXIgdG8gZ2V0IFRYREJfVjIgY2hhbm5lbA0KcG9pbnRlci4gQnV0IGZyb20gdXNlciBzaWRl
LCBub3RoaW5nIGNoYW5nZWQNCg0KSU1YX01VX1RZUEVfUlNUICAgICAgICAgPSA0LCAvKiBSZXNl
dCAqLw0KSU1YX01VX1RZUEVfVFhEQl9WMiAgICAgPSA1LCAvKiBUeCBkb29yYmVsbCB3aXRoIFMv
VyBBQ0sgKi8NCg0KSXQgZG9lcyBub3QgbWFrZSBtdWNoIHNlbnNlIHRvIHNlcGFyYXRlIHRoaXMg
Y2hhbmdlLCBiZWNhdXNlIHRoaXMgY2hhbmdlDQpXb3VsZCBvbmx5IG1ha2Ugc2Vuc2UgdG9nZXRo
ZXIgd2l0aCBUWERCX1YyIGNoYW5nZXMuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IA0KPiA+
ICsNCj4gPiArICAgICAgIGNoYW4gPSB0eXBlICogNCArIGlkeDsNCj4gPiAgICAgICAgIGlmIChj
aGFuID49IG1ib3gtPm51bV9jaGFucykgew0KPiA+ICAgICAgICAgICAgICAgICBkZXZfZXJyKG1i
b3gtPmRldiwgIk5vdCBzdXBwb3J0ZWQgY2hhbm5lbCBudW1iZXI6ICVkLg0KPiAodHlwZTogJWQs
IGlkeDogJWQpXG4iLCBjaGFuLCB0eXBlLCBpZHgpOw0KPiA+ICAgICAgICAgICAgICAgICByZXR1
cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgcmV0
dXJuICZtYm94LT5jaGFuc1tjaGFuXTsNCj4gPiArICAgICAgIHBfY2hhbiA9ICZtYm94LT5jaGFu
c1tjaGFuXTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAodHlwZSA9PSBJTVhfTVVfVFlQRV9UWERC
X1YyKQ0KPiA+ICsgICAgICAgICAgICAgICBwX2NoYW4tPnR4ZG9uZV9tZXRob2QgPSBUWERPTkVf
QllfQUNLOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBwX2NoYW47DQo+ID4gIH0NCj4gPg0K
PiA+ICBzdGF0aWMgc3RydWN0IG1ib3hfY2hhbiAqaW14X211X3NlY29feGxhdGUoc3RydWN0IG1i
b3hfY29udHJvbGxlcg0KPiA+ICptYm94LA0KPiA+DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0K
