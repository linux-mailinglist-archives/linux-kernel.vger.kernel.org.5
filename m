Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45179FB92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjINGEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjINGEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:04:32 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A054DCFA;
        Wed, 13 Sep 2023 23:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFkyFzFfV0qOpTCXt358MIN5ImeqaTX390gkjFN5eIRltCHCPCYr4MmN21WKsS0bE6c5FLBIutjdsZv2Bbmc81n/rBcQDK5BLWaOzIJ0fM6FayfK7doay1HtTtFHs+a0si8V2Da+zJVnXSX3hhL110iGwR4xMUhseAkFiGBSYR1uPamgUSGgRueWOQnAdQ52o1dD4JOpxYxSvoAPpTRSZjp4QRJL4ThrlXmb6n+fhIoIN83EzSqq3ugVN3ztg6h/UVfWLTslhPyFvUqLqywz3CCh7IndQOZWjrKdTZ40FIS4DqnWsky9BIMbDV/DIUX6U5nisbb/6/jLk9MJzxMTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akIvmdxJ1DlqYoMlyBtJVbF16OexhzOAfA/m5gEM4x4=;
 b=BqSeHK4rhAwlWaRYZgdcXAHw0r/GAWzxy6/4DtC/y+sWG7VqxfJJM1gb7sB2pX4KLDJnxDOGahuHl+eT2WQ9o56h+XR7djt17RRQG6yduOeYDVUzlQBa9xI5/gxnl1hRNBfkZIqHPYIFRIIJPWW28knEDqVeLsfepfM+QPPgf39Y9KOwImq70WNe0iB1bo3foCn6j66cUgAjJY66b78ru2mo45Wl18Sb4L84nVprwZuXWhe3Z+SeCu4PbrV2yvor55a7ofZ3mcsRVYon1itmVaf+GGQauqNsTSuTePTy1XDhum72kw5+xuTAL1p150HljIx8iDFSPY9EJ6GpKFWVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akIvmdxJ1DlqYoMlyBtJVbF16OexhzOAfA/m5gEM4x4=;
 b=VhzMAZSvA7FoqNPAOaGboJLVZGzHaIRo74Di+p9F3R0K8q4yJbsDq1cqxu46YlghSp0ltCvQnQn3QRNoA3qEOsepyFZ4DvmIA67wGn5QKNgf90oo2pU3e3g6Qis0vZsnu+MODZyLSbERn9GCOU0yXyP8DJUWBJUarFzszUh523Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7813.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 06:04:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 06:04:23 +0000
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
Thread-Index: AQHZ5rGG9QLxnHCRQEOiHX1ZRRTVWLAZ0M8AgAACOZA=
Date:   Thu, 14 Sep 2023 06:04:23 +0000
Message-ID: <DU0PR04MB941722CE1A9BF9F87946DE0A88F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-5-3ed418182a6a@nxp.com>
 <bc122417-6d59-4c1d-3f73-c20711f9a32f@linaro.org>
In-Reply-To: <bc122417-6d59-4c1d-3f73-c20711f9a32f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7813:EE_
x-ms-office365-filtering-correlation-id: dba308d5-468d-4c31-3ae7-08dbb4e871cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKLSOrrDH4kMTFx3SG6wfkSmesMyWXPhjwdtpSMUD78S/1M0I/AQLmqK4Bu+GMbCCocpOKF/qBxjMLpaMj/9fay92vYITdp1mVKuyir0F1F8xo2K4SA4/4cwktC5L0+3LiZnQthra5fxWlW0KsJC/lViuNp3vkDuAlwoG9c88t3bzpvrRqCacp4F3pOmTHx5tqL5Dgv+edhn0sGmLXCs9J2YSzm5+08P3p0RNchGYvoQUmXIrma7u5VFEiz5y/aJknM2/J/qXAskNXuG8UkoWr4mdon2WOGAdOn+uHy+bpWSJrfKHo5MGnjJidjZMEswbd3Z4BE00FUp9STVe4cOMpWVJvqpzjyDfcDe6s3lXX3pkvZEvJYbU1rTMiFxegbdKHzL62BUyO3JPy4E47pn0R7Jf2ZiZz9QWzdX33fa+hCyGO2nsarls2mnolR2+rCmYu/XkGzqmc0kE4vQODwDd/UZUohKlwcKrDm6m7d8MQgLsOqKxTKH6WYUdvMrt2GAIjH8eOJrp9lMwGi+5qkW57yu8e4k+vUB+Zrh/oaNhVilo0pWRJ+rg0yeKbzNivUGsliIr+cRDPXEjMjgtz1lipEh45QjTBhI/yoGDj9wmncoGtbkAGn6pBpFYvMmPz6nPQGsvBMA2lPQUsZr1y6L8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(26005)(4326008)(8936002)(8676002)(52536014)(71200400001)(38100700002)(921005)(38070700005)(53546011)(83380400001)(478600001)(5660300002)(44832011)(66556008)(66476007)(66946007)(110136005)(76116006)(54906003)(64756008)(6506007)(41300700001)(6636002)(7696005)(122000001)(9686003)(316002)(66446008)(7416002)(15650500001)(2906002)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnMrRXRPTE9KZUVOSmF2N1RwZ21kbEpiSXdhUW50YysweksvVjMrVjNZZm5a?=
 =?utf-8?B?QUhIdEswL1FCelcwQWhFWll5Uk96YjNsM1BuZUNaRWgzYUZnTUNwU1lBdXZO?=
 =?utf-8?B?dFkzM25NMXYveDhzMy9VV1RyZ0tmL2VTdnZzbm5ycWVCZmlNaGQrOGg0bi9I?=
 =?utf-8?B?MWNKMzVaaFRXcUpjcXU5cno4OWRjOU9SV0l1MlR6S1ZtbW1zZmZhQkJVSWZ4?=
 =?utf-8?B?TXFmVytML2JMTWlzWkRVbE0xeXBTd1FaRndyeDR0Y3V5TUV3TUYyR2RRTmtB?=
 =?utf-8?B?SExwR0RvVG8ycHc5aWRseVYrOFpobGRCYWkrWE9iQzc3cDl2bk0ySmF2Rzdr?=
 =?utf-8?B?TEpxdEFpczZQUjRFWDRQeWx4QW1kMXFFWWdHYVZncWdxSHdzNFNwbEhCemVn?=
 =?utf-8?B?TXlTbyt3NHBZc0kvaDdCcTF6K1l5MW54OCtwc3I2NzA4MThvUmNTQTJMbmll?=
 =?utf-8?B?OXp2UXNQVmlIYXIwNjhNNndzbVcyNlNOU0lSYVVlMjFNdFlZZXB5c29PaDVu?=
 =?utf-8?B?ZjkyS0FKNkRzcjlzblZBbnJ5by9NR2RmaExFd0ViUTU4dmVTREY1WWNnUzl1?=
 =?utf-8?B?cGhiRnRBVTlFbnBIR1huOElXWGxlZnZicUw0SFhKUXlGS2FqZWJSV2ZlOSs3?=
 =?utf-8?B?MFh3U3B0bVY3YlpHQWZiVFJ6WFNFVFBVbTBJK1NjSmd4OGdPbVB3YmFPSWdF?=
 =?utf-8?B?Vm42V2tLbmdwdkgyaDN1WmFVcEF3TUhna3RlTDlpS0dhWUUvdmpkMmMzMlNP?=
 =?utf-8?B?VlR1WkNKQVRBN0YraHZ2Q29iTGNnem5paldPL0Y4Vi9wVVVYZWg3SFMrVE9K?=
 =?utf-8?B?Sm9YRFc0L2UzSFA2aXBVVnZDSW43SCt5cnBCRGFtUTlsSUI4ODRoNHYzMzMz?=
 =?utf-8?B?UWs5RkZxeUlEUjM3L3M2NElSOWZkS1NNcHFRSXVGOEhpdUF2dmNGd0RlNjlw?=
 =?utf-8?B?SkIyZW5GWWdkZ1JoYnB0eGhRQk5XSDFWVlZGcndvTFl3a21nZGl0S1dXUFh1?=
 =?utf-8?B?MytucXVZZjNPV3dVemtKTWY3dTBrUG1idjJFY2pJYXBUcVRVcllwTzd6RFBV?=
 =?utf-8?B?cWRhWkY4c0dZb1JhejNtUklGR3dNOFZOaEt1UlRmWHY3QmRBUHlmS2ZBcW9V?=
 =?utf-8?B?RmNEWDlYcHpxV1pjaHlHeWg3ZXlTSk5qdFRaUStZS0lNOGo1MGRqTEZUWi9n?=
 =?utf-8?B?cDM1WXlXZUdxM2pEeEw4YXRvaE52eWtDTnhObzd1UGNXQlNwbmNnRWVPRjNn?=
 =?utf-8?B?OG5jbGhJK0dnblZiZklEYnhvTUUxVjVMbTRiWFFQOFd5TTE3ZWhWdFkrdmtp?=
 =?utf-8?B?TndwREw5L0RKRzdtbC8xWDZmUXRqV3o0M3p2bFlaUFhKUlZHYzBNWXFyV3ov?=
 =?utf-8?B?akZZMXR5alJ6aHlXMzdjMlhqZUNKSkV3bjQreDVWbmx5T3RnUytvMGMrbGJG?=
 =?utf-8?B?REhyN3hxdThVbzJOMUtiTTZBOXdHMjJBR3k4citRdENHTnNONkJVWTNsazRF?=
 =?utf-8?B?bERKWHcvbE5UZzd1YUttQ2dWL2FwaGtGZzcwMmtGM3lXOHNNMnA3cGpUVlQy?=
 =?utf-8?B?RVFoQk9sL2tHWWRjdTJLdGY5SDl0dXM1SzVRblQwYXk3M093TFdEK0NYYUIz?=
 =?utf-8?B?eVNNMDJ6SUwramp0RFo4SFk0R3B4N2VIdzlzYU8wd1E1cW03RE5pTDByV1Jj?=
 =?utf-8?B?QzBCV2NPVGp0eFJvUzBRT0wzR2xjMy9PMHBEVDlobnZqNDZ0dzVNTEc1MnFV?=
 =?utf-8?B?TXEvdmFOVjExWjFGdGhsZ3N1MVpaK1h2dmx5bGNwMU5FVklXby9yejdseGVo?=
 =?utf-8?B?Zkl4YUhDL1gxZDYyRWg2VHkrSDZURXpqQzBzMUNEajRZaFNuS2FzMjRTclBS?=
 =?utf-8?B?QmN5WnNBWDF2ZEVWemNSd080WXpjU0NnWFFDY1MrSXRBUkdrOEhsWW93TFE4?=
 =?utf-8?B?TXdRa1ZjRUhtUGJ2Yk5FUnUrRndYWThKWFhOak5hL1MxVTlmc3lncTcrak9h?=
 =?utf-8?B?SnJueVZCSHlaTlBTVU9Pa3g1cHZJVTlidlcybUFZMGZMcUcvaFFNUGhLSEth?=
 =?utf-8?B?aUtad3UvSnJRekVDSHhNbjhRR20xRkhHNWl6bXpha3NiWmFjZWVuakxPeUFo?=
 =?utf-8?Q?0PKI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba308d5-468d-4c31-3ae7-08dbb4e871cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 06:04:23.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvcIBxVF9gElpZlBJrOGbc9Q4SEGJycbL/SjCpIqWTaWLhDJRM33aanxkaGgzw9a9qAlIEJayvX/UY0+Y3en3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNV0gYXJtNjQ6IGR0czogaW14OTM6IHVwZGF0ZSBncGlv
IG5vZGUNCj4gDQo+IE9uIDE0LzA5LzIwMjMgMDQ6MjEsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0K
PiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gUGVyIGJpbmRp
bmcgZG9jLCBpLk1YOTMgR1BJTyBzdXBwb3J0cyB0d28gaW50ZXJydXB0cywgYW5kIG5vdA0KPiA+
IGNvbXBhdGlibGUgd2l0aCBpLk1YN1VMUC4gU28gdXBkYXRlIHRoZSBub2RlDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaSB8IDIwICsrKysrKysrKysr
Ky0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDkzLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkz
LmR0c2kNCj4gPiBpbmRleCA2Zjg1YTA1ZWU3ZTEuLjAxMWMzNGE1N2M1MyAxMDA2NDQNCj4gPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpDQo+ID4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+IEBAIC04MjUsMTEg
KzgyNSwxMiBAQCB1c2RoYzM6IG1tY0A0MjhiMDAwMCB7DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJ
CWdwaW8yOiBncGlvQDQzODEwMDgwIHsNCj4gPiAtCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OTMt
Z3BpbyIsICJmc2wsaW14N3VscC1ncGlvIjsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14
OTMtZ3BpbyIsICJmc2wsaW14OHVscC1ncGlvIjsNCj4gDQo+IEFzIHlvdXIgZHJpdmVyIGNoYW5n
ZSBwb2ludHMsIGl0IGlzIGJyZWFraW5nIHVzZXJzLCBzbyBubyA6KA0KDQpvay4gQWx0aG91Z2gg
aS5NWDkzIEdQSU8gaXMgbm90IGNvbXBhdGlibGUgd2l0aCBpLk1YN1VMUCBmcm9tIEhXDQpwZXJz
cGVjdGl2ZSwgdGhlIGNvbXBhdGlibGUgc3RyaW5nIHNob3VsZCBrZWVwIGFzIGl0IGlzIG5vdyBh
bmQgYmluZGluZw0KZG9jIGtlZXAgYXMgaXQgaXMgbm93Pw0KDQpUaGFua3MsDQpQZW5nDQoNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
