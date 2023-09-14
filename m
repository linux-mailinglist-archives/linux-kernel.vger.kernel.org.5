Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F87B79FD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjINH03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:26:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B79F3;
        Thu, 14 Sep 2023 00:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGjWVFHaXy5AAyOkei65ddahQkVqSs21+wfZmMDUYEdagmcPNJA86boOWoYSLJkkf2nhoh/0N4RZu/psTez3scJ+uQnG15Y8XG/MGef1HKAIcXnU0c7SjOJFMazgueBPHI7alYBJfzmSKRrk5Fztd9pnmMlss5ItTRBelKPUmucPb3p4oGJ+GSSf/4bRkowFH4VXMNowSI17fnKg8IrsF8UACGzJn34IMrZEXNBfUG9Klycz3je7BAIDlcWGhgVmUIN5ABcLIW+1Yme+YmMQT+4xmCVgB/BPvu7j6BBsjYmmJcWrSe7OH9lTVj9RODgGO6JGSM/YRt1MY17Xhf9HsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0kEcIZmoLiYxq8FiWfvdxqejenJ2zzU8SBA9Y0OB3g=;
 b=i80Q4UqQ1L8EDT+Tpb3YqPy+G1lwv1WOAz4L89GvhfmFzqGSDvk2t/oZgsB+vTmQ6QOEstNtBB9JXe4UeO6jSGR0zvzFIrLRD9Z+kTA/Q3n8y7tN7N6aFISaWgGDB7X1BUz6C8YmBYKUjDmRWo3mXtxmqpWWZGy0+l+kM/zrHJPEv5g4PK6qFY5SNOZnWd/l+8Y/Obok2p+LQajIh6jYCpyCu5sx9rjl01hWcHL8x/K82kcXKelLVSLJ9dlLSyLmYnNKHIZX763dPyMwi8eGe6yvu/cHshrlw70OPiaEl63vcDbUyYaZHEcRcQMX0dED4GO+cQ7iKZQEIMDaZIN5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0kEcIZmoLiYxq8FiWfvdxqejenJ2zzU8SBA9Y0OB3g=;
 b=N4+YaZbPCLs8ZOnGl7/6lk6TSnxrOdd6rhgz9nZdbVOdatwJs7v/2LDi/vmWeEvmkajGEWTEIrHVMCRv3wcwrymHpfm+rNLUfqndIkz6mVHDr8eYakWZ6ppvCgiflREFtg0JOUAqvS2dl6ycShhJv9vLRT2aQ5TImEObCF2keTM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7976.eurprd04.prod.outlook.com (2603:10a6:20b:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 07:26:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 07:26:21 +0000
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
Thread-Index: AQHZ5rGG9QLxnHCRQEOiHX1ZRRTVWLAZ0M8AgAACOZCAAAniAIAAA0oAgAAHtgCAAAEDkA==
Date:   Thu, 14 Sep 2023 07:26:21 +0000
Message-ID: <DU0PR04MB94171F4AB2D0A4031BC8EBAE88F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-5-3ed418182a6a@nxp.com>
 <bc122417-6d59-4c1d-3f73-c20711f9a32f@linaro.org>
 <DU0PR04MB941722CE1A9BF9F87946DE0A88F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <9fc4817d-00ae-aaf4-bfb6-b24361f55799@linaro.org>
 <DU0PR04MB94177EF6250838FFFB5FD6D188F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <cc25b9ba-08e6-24e1-8e21-f3e43bb73311@linaro.org>
In-Reply-To: <cc25b9ba-08e6-24e1-8e21-f3e43bb73311@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7976:EE_
x-ms-office365-filtering-correlation-id: 0f3f99fd-6083-4771-40e4-08dbb4f3e4d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LfusYdgHsu42JKF3DH2V2eCdCWeOwwF5mT1NncnRJHXtx7+32NVDQrQx7q1z51BIDTF16n82y1ToYEB4P24203xCGOqAQ1E1bvpWMINlq5lIlgNNk65C5HbV6ouCZAyF+6DmY0gt7M81+hywwTSVzHLd8FsNlkUyx5XRCK4kSeeuXQWUi70vaJ46hA9kIZ/WhGVy/pRGi7kwLl4nDgZ0yHFl7C/SOvEzF6H/d5WwKJ3fMjaEAlj42HvfsGE60LB0Pfycr9Tm1nhR6eqIUJ8CNu681yToZ03s3ROnLkn5rIr/kn+KNA2LUYd9dQe9AVC58MnmDAHoUOUejJhN1Mk7P1KqhfXCBecZzuaWsGaivoOCqCG9wGxgN1T6f5hrZ0liTAwT2mR5jlaUlz/n2hBC9cTp5CcXTl7RFpOxRfi0mRCYjHxtgKmG7I4Nldxes7mXlk4gh188t5Es5Rq+JtRCed24Nd50d9syCgywuM7vjsq0o4UYpktJxVgpO0BqfabHDe9QqaA+gLoSIHRx37yHsVTHiC5sOHjODsZSV8PO5gU+gcb/a4MraVe82cUfJiUjoRAcJfhAXP+Pr2L+u6YhWVMy2L6PMLsa36Sq/nK20L+xBeJVTOU5/prh/3dQ3/EYOzJcr8QQrbJyzd8SbCh7bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(1800799009)(451199024)(186009)(71200400001)(7696005)(6506007)(53546011)(122000001)(33656002)(86362001)(921005)(38070700005)(55016003)(38100700002)(7416002)(15650500001)(2906002)(6636002)(9686003)(26005)(478600001)(83380400001)(5660300002)(52536014)(110136005)(8936002)(8676002)(4326008)(76116006)(41300700001)(66556008)(66446008)(54906003)(44832011)(66946007)(66476007)(316002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEhnWXM1Y3pveHhtK0MwMDFFRnJwdUQ1ZFJtQzNvUTdGcFBkVGttcDJXbXA2?=
 =?utf-8?B?Qm5IV2N2ZXNHcytKNUI2aGYxNGNIbzBmQ05YOVNMNVIxM0tzMy9DaU5BZzUv?=
 =?utf-8?B?a09IQkZ2bit0ZWlqNTBKY0FaSDVMQ1BkTkptZER3TXZoek9aYnJ5a3pwcUtG?=
 =?utf-8?B?YTNWbnhYRFlsaTRBWHpkTFJJeVo1djd4L2VxSkxLQWhsWGhQV2NnaGxNajh6?=
 =?utf-8?B?SFpvNkMwMk5XWXRBYkNqcW1jNkdrMTR6N2NQempyd1hTM3hhS1FzcDVENThV?=
 =?utf-8?B?N3JUK0VhWkNWa0xkNzdnb3NCOXNEbGNMYWozY2pIT1lxLzVxVHBGeDNyOEJX?=
 =?utf-8?B?ZHlGQ2NRSWFqZDEva2s1bkthYnRRL2dYNmpjMGkrT1R0L3ZnUnY0anJrLzNy?=
 =?utf-8?B?V2JPUkZBZHBDbCt4Z0Ezd0EyUm1WVFRXTkVBcmJXcTJZMHV6cnArRFV2ZHJV?=
 =?utf-8?B?OGlzSytVTk5TUHNrcFdCc3NnNnFkWXkzMnN6bFdDMDVUUFpqbXA4d3VYTW5K?=
 =?utf-8?B?ZjAzbGJvMDU3bVRubFNmVnpqTElhT1JNUkR0OXBHYWtCeWUwQXdMVmFSa3JP?=
 =?utf-8?B?UjBaQ2dZWnNNZDV0YWhYcE1oNytXTTVmc3FiS2ZodlNaL1pBY3c0MTU1eG9s?=
 =?utf-8?B?d08yTE1CbHZsT3RuTkp6bWJ3K2FZak1GRTQwYXd4dmU2Qi9BbHNnZkVYdDli?=
 =?utf-8?B?NmtGRWNna0QvU0Jjd2VKV1pGRWpjTFRWeWFBeWpVNjBBWmxlNFFQNlNubFBJ?=
 =?utf-8?B?KzRHV0JzTGh4RnBvOW1XV2tLMFI2VWFDYXZpcGtobUNnb3NpN1ZRUDZ2UDB6?=
 =?utf-8?B?clFnS2hGZEFSY0VSdk9xQkJmZW9UYTR4VFRwZkkzeGg5L1o4ZWRIa1NlVU51?=
 =?utf-8?B?ai91bUg5ODA5ZkhIbTI1eUhLbEJPNHlhTnVTaWwvZURWb0RNTk9YWDJKbWZY?=
 =?utf-8?B?ZTI5OFpRY3IyZVBJcjNzbnVOVjV1UlpSMmpUMEsrK1V3Z2JDcFNJWHowc0dS?=
 =?utf-8?B?MDRTSDhadXRJMk5JcmVVcjZKcExLNE5DdXptbVVLemFsSytVazltQ2NCTG9p?=
 =?utf-8?B?ZzVpUXBaSC84VHY3WjVjMk5RclRQdThHek43dUFlNnd6UkhjbXMzem5JU2dk?=
 =?utf-8?B?azE1R3ZUano0WkI4dTVTYk50NmVtdmt6aS9WcjRYUHQwcGQ5RDJtZXRyZWZj?=
 =?utf-8?B?WTh2cjY5MlhkMnV0dnFvRlR1YXlUY3hRYmpIWEh5cU9hQWhLVCsrcy9SOXU0?=
 =?utf-8?B?RWtDcTZTSG5aN2FIYW9uMklFNzF0OGtRSGZOcVJQWXZLdENhUGhiVVRXdXBz?=
 =?utf-8?B?d3cxcE5SRXRkT0tFbWFuSkpLNUxjTkhvaGhTSU05WFpHb2RKWEVib0gxdS80?=
 =?utf-8?B?bDNpdlp6c01KSVZ5UG95bzN2VWFwMTBJbWE5bGRBN1kxTkhJZHFjVjRpR1Ju?=
 =?utf-8?B?RXgxbVpTVHVQRWZZVG5mQ0RIdUI3clNrTjhyRkk2ZmFQMkhXcmJJN0RheDFJ?=
 =?utf-8?B?Q1lCYjA4a0taNUZwaXJnd3drcElKT1VMd21GS1dpdU9FQmZwL3dGb05MV2Uw?=
 =?utf-8?B?Wjg5Vnk5N2x5YlZCV2EzM2lLNWFyd1VBMTVXQnFaWkVuTHVqZ1RYR1lMOXVH?=
 =?utf-8?B?WWtJTmgrVldvQm94V3FHbUVYekVSL2IrdDBmZmpCaGZKSEhSR2o3YXZoNFdM?=
 =?utf-8?B?cEN3WnIwc0htOElyYzBibnh0TlI2d2hqODZ4R3NmRmNKRkQwUmx3bGVIUmk3?=
 =?utf-8?B?RVExMVlvQVRaOTJxS0lDK2loRDJsTzBNQnhJUVdCZndtTitEbm9CeHJ6czQv?=
 =?utf-8?B?SFpBK3NaTC9vcjQ5NzE4bDdwdzcwOXpTTDcyd2hhYkxzN0lROG0vazZzbFp4?=
 =?utf-8?B?Z25sU3U2TXpoZkhyUGlpTkdMTWwvQWo3d09kdHJWb0NvQTMvQmhna2hHWCtu?=
 =?utf-8?B?eHpTTGZvcUFRNEFnV3dDT2hreDNqRWRwTG1qdGYydjVSTHdjeTJpbnhZZmxB?=
 =?utf-8?B?eXNUM2dtRTFka1RuRExKUWRxcktnTFh4MEU2S2FydTJaV292VnYrdVh6NHRQ?=
 =?utf-8?B?OWhMK1VLbXFWYnFuSUdjQlc3RVNObGovTTJkdVRnU05zeEt2MHdwZzlhNHVq?=
 =?utf-8?Q?cD3s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3f99fd-6083-4771-40e4-08dbb4f3e4d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 07:26:21.1849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXf7tmushDIFZJhsjb/jhxUwXPID6n8lnA9Qs7E0I5zwBajUwFOvNWuXzMSMAZh9+Mx1h/UoDZON6+kbiZMwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7976
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNV0gYXJtNjQ6IGR0czogaW14OTM6IHVwZGF0ZSBncGlv
IG5vZGUNCj4gDQo+IE9uIDE0LzA5LzIwMjMgMDg6NTMsIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBT
dWJqZWN0OiBSZTogW1BBVENIIDUvNV0gYXJtNjQ6IGR0czogaW14OTM6IHVwZGF0ZSBncGlvIG5v
ZGUNCj4gPj4NCj4gPj4gT24gMTQvMDkvMjAyMyAwODowNCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzVdIGFybTY0OiBkdHM6IGlteDkzOiB1cGRhdGUgZ3Bp
byBub2RlDQo+ID4+Pj4NCj4gPj4+PiBPbiAxNC8wOS8yMDIzIDA0OjIxLCBQZW5nIEZhbiAoT1NT
KSB3cm90ZToNCj4gPj4+Pj4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+
Pj4+DQo+ID4+Pj4+IFBlciBiaW5kaW5nIGRvYywgaS5NWDkzIEdQSU8gc3VwcG9ydHMgdHdvIGlu
dGVycnVwdHMsIGFuZCBub3QNCj4gPj4+Pj4gY29tcGF0aWJsZSB3aXRoIGkuTVg3VUxQLiBTbyB1
cGRhdGUgdGhlIG5vZGUNCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiAgYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaSB8IDIwDQo+ID4+Pj4+ICsrKysrKysrKysrKy0tLS0t
LS0tDQo+ID4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4gPj4+Pj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg5My5kdHNpDQo+ID4+Pj4+IGluZGV4IDZmODVhMDVlZTdlMS4uMDExYzM0YTU3YzUz
IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5
My5kdHNpDQo+ID4+Pj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkz
LmR0c2kNCj4gPj4+Pj4gQEAgLTgyNSwxMSArODI1LDEyIEBAIHVzZGhjMzogbW1jQDQyOGIwMDAw
IHsNCj4gPj4+Pj4gIAkJfTsNCj4gPj4+Pj4NCj4gPj4+Pj4gIAkJZ3BpbzI6IGdwaW9ANDM4MTAw
ODAgew0KPiA+Pj4+PiAtCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OTMtZ3BpbyIsICJmc2wsaW14
N3VscC1ncGlvIjsNCj4gPj4+Pj4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDkzLWdwaW8iLCAi
ZnNsLGlteDh1bHAtZ3BpbyI7DQo+ID4+Pj4NCj4gPj4+PiBBcyB5b3VyIGRyaXZlciBjaGFuZ2Ug
cG9pbnRzLCBpdCBpcyBicmVha2luZyB1c2Vycywgc28gbm8gOigNCj4gPj4+DQo+ID4+PiBvay4g
QWx0aG91Z2ggaS5NWDkzIEdQSU8gaXMgbm90IGNvbXBhdGlibGUgd2l0aCBpLk1YN1VMUCBmcm9t
IEhXDQo+ID4+PiBwZXJzcGVjdGl2ZSwgdGhlIGNvbXBhdGlibGUgc3RyaW5nIHNob3VsZCBrZWVw
IGFzIGl0IGlzIG5vdyBhbmQNCj4gPj4+IGJpbmRpbmcNCj4gPj4NCj4gPj4gSWYgaXQgaXMgbm90
IGNvbXBhdGlibGUsIHRoZW4gaG93IGNvdWxkIGl0IHdvcmsgYmVmb3JlPw0KPiA+DQo+ID4gaS5N
WDdVTFAgcmVnOg0KPiA+IDBoIFBvcnQgRGF0YSBPdXRwdXQgUmVnaXN0ZXIgKFBET1IpDQo+ID4g
NGggUG9ydCBTZXQgT3V0cHV0IFJlZ2lzdGVyIChQU09SKQ0KPiA+IDhoIFBvcnQgQ2xlYXIgT3V0
cHV0IFJlZ2lzdGVyIChQQ09SKQ0KPiA+IENoIFBvcnQgVG9nZ2xlIE91dHB1dCBSZWdpc3RlciAo
UFRPUikgMTBoIFBvcnQgRGF0YSBJbnB1dCBSZWdpc3Rlcg0KPiA+IChQRElSKSAxNGggUG9ydCBE
YXRhIERpcmVjdGlvbiBSZWdpc3RlciAoUEREUikNCj4gPg0KPiA+IGkuTVg4VUxQLzkzIGhhcyBk
aWZmZXJlbnQgcmVnaXN0ZXJzIGFkZHJlc3MsIGJ1dA0KPiA+IGkuTVg5MyByZWdpc3RlcnMgaGFz
IDB4NDAgb2ZmIGFzIGJlbG93Og0KPiA+IDQwaCBQb3J0IERhdGEgT3V0cHV0IChQRE9SKQ0KPiA+
DQo+ID4gRXZlbiBsaW51eCBpLk1YN1VMUCBncGlvIGRyaXZlciBjb3VsZCB3b3JrIHdpdGggaS5N
WDhVTFAvOTMgR1BJTyBIVw0KPiA+IHdpdGggZHRzIG5vZGUgdXNpbmcgYW4gMHg0MCBvZmZzZXQg
KyBiYXNlIGFkZHIgZm9yIGkuTVg5MyBncGlvLiBJDQo+ID4gdGhpbmsgZnJvbSBodyBkZXNpZ24s
IHRoZXkgYXJlIG5vdCBjb21wYXRpYmxlLiBCZXNpZGVzIHRoZSB1cHBlcg0KPiA+IGRpZmZlcmVu
Y2VzLCB0aGVyZSBhcmUgb3RoZXIgZGlmZmVyZW5jZXMuDQo+IA0KPiBTb3JyeSwgSSBkb24ndCB1
bmRlcnN0YW5kIGl0LiBJIGFza2VkIGhvdyBjb3VsZCB0aGV5IHdvcmsgYmVmb3JlIGluIExpbnV4
LCBpZg0KPiB0aGV5IGFyZSBub3QgY29tcGF0aWJsZSwgYW5kIHlvdSBwYXN0ZWQgcmVncy4NCj4g
DQo+IFNvIGFnYWluIC0gaWYgdGhleSBhcmUgbm90IGNvbXBhdGlibGUsIGhvdyBjb3VsZCBpdCB3
b3JrPyBPciBtYXliZSBpdCBuZXZlcg0KPiB3b3JrZWQ/IEJ1dCB0aGVuIGNvbW1pdCBtc2cgd291
bGQgc2F5IGl0Lg0KDQpIbS4gRnJvbSBodyBkZXNpZ24gcGVyc3BlY3RpdmUgdGhleSBhcmUgbm90
IGNvbXBhdGlibGUsIEkgdGhpbmsuDQpCdXQgZnJvbSBwcm9ncmFtbWluZyBtb2RlbCBwZXJzcGVj
dGl2ZSwgcGFydGlhbCBvZiBpLk1YOTMvOFVMUCByZWdpc3RlcnMNCmFyZSBzYW1lIGFzIGkuTVg3
VUxQLCB3aXRoIG9mZnNldCBub3Qgc3RhcnQgZnJvbSAwLg0KDQpGcm9tIHByb2dyYW1taW5nIG1v
ZGVsLCB3ZSBjb3VsZCBzYXkgdGhleSBhcmUgY29tcGF0aWJsZS4NCg0KVGhlbiBmb3IgaS5NWDk1
LCBJIGNvdWxkIHN0aWxsIHVzZSAiZnNsLGlteDk1LWdwaW8iLCAiZnNsLGlteDd1bHAtZ3BpbyIu
DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
Cg==
