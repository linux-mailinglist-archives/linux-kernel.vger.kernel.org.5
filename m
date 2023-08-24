Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80A8786F85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjHXMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbjHXMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:49:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4D81BDB;
        Thu, 24 Aug 2023 05:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8s6718f6lZ8bDKxjxtS9rUltL+Q9NRugeU5eNbVulCJyDr+xtWvS8+qGFsImPrVprLxAkYnxeMI0Rb0TwBpa6D0y2J/xxuahYFFEF06Dk05i/qdOFZXSfffTvkvsR0KAm55onq8dZYU7K81t/JalTaTjHQIM2ykKr5Qwc931R83SgiOuhGv+akMwyXkoTXlMkUwgMV2BAo0/I5947afOVgQQMqsuuCclnybGsdvb0nZKN07Er3KKUkLrFlKd5NnDoKUDABf9nxexjfcfqdgSqbMx2Wxu+LzjmQQBIsBJMw/srk7Ans6W1fJE3jEoSLfUlpHut7R+RLFN/oXuSSEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yjZqiY4ACKd3QQxpG6/yjqrWRWS/DdAAQTQvKoApD0=;
 b=CyHHmILcKPkmdMrcU013bJoIFsqI/JnII5OOMgsBnVL7CIprSFFhHz/fh66CPiddjgDa4QWlaEdk1Cc25K8FvMekDuEPVBxsjUnIfvBAWuGCz1X+lqkz5xrA347i2O7QiVirD/pK52zegKZcN8TeopNUdVtRCPv9MCKheB1acU+ngyndo47f/YIbe4GzJaDCMGuePcMCAqR0sFbaQ4CPK3+0rlBUDTMW/552ZP/mY4uh/6WmfqgGgW1gP/MxCC0JJ2Ztr83gmc8m4MT1eCif8EoUfvD3SX69Z05BbclXCNbGLypWcUEVAUhDUD/1eL6BqiAJR5M5DtlGmgobNsgYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yjZqiY4ACKd3QQxpG6/yjqrWRWS/DdAAQTQvKoApD0=;
 b=LJZ1k1PeTpU2rwuBdp/vW+VhJa6WRx4nuJUpDN4xzeHMoQLH6uOO1dV8/PYxyyUuPIVcwGPJhiANQy7Dg+2MNUBsyMWcCUlGoi3yVy3psW+11mEcxCuX/jhIfbH9fefbQbbG1ntRFR0Po5Sl/91w56zI6UNJ35U6ELEdYNI7uKE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 12:47:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 12:47:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "oleksii_moisieiev@epam.com" <oleksii_moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [RFC] scmi: pinctrl: support i.MX9
Thread-Topic: [RFC] scmi: pinctrl: support i.MX9
Thread-Index: AQHZ1ljQGymVJC/R70ObhTQ99JrC7K/5IV8AgABBfyA=
Date:   Thu, 24 Aug 2023 12:47:51 +0000
Message-ID: <DU0PR04MB9417B3CB9638F936DF19C523881DA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230824070611.3335107-1-peng.fan@oss.nxp.com>
 <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
In-Reply-To: <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6925:EE_
x-ms-office365-filtering-correlation-id: 01221adb-6f37-4008-7247-08dba4a05442
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lJl6czGk8I9C1pljut5fziHOd2D6KEjJxPunxgrbuIlW0uwR02ey495PBr740np26MSTzkUwlvoqtJaK3XeLwD0yOxP936MjyQHB4rxMXebvxP7utDx6bS1/b2cjhHEwy/BZKYFpr2g4WqZPY7xCUVOH7VmBVlPx4BVWPtyWx1VJ1csfOlzjKYc4buN2MDxJWdwnmEN1zgv7V7v4uCBzLl++0W0NHuTjUnEPMH3OvyP0DIwF6l0OoUnuBQA+52w/sbUvXnl21nw3OrdVlUpCHmUvo9ZKpjGDcE9XbnrKFo6qm43Cgk6IvsjC6O5zxDyLRlwU5PkPb3aDgjBt86TQIAawiE55ov3KAufsvJP3eKP/RPuigfoT+eIi7E+XKC1s40LnHidvLJE+CU8CO+PvqwqCIzGw62kPU9DKvdXEU+4SM+FR2sW4VSnejQNBIRH82btCB7+fXRC5X1xANgV6/ItQxLfIYX2nT2l8XaCZ+EL1gtR8kxRynuPVUDLqBKcJSxOt+Ao++34iKeyAOUELW09ve2Yx0qRjTgA8ihxuhiYBE2m2K5Sn8fE1PZYIU9yuZULjQLhC9k1YrybksFT9C0g0YS6A85sMGwUJ/zrnI1rjkf+UX+ajqjOZsrEQvhSrt7o/OyRYkJDjWmUyNJgNKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(1800799009)(186009)(451199024)(33656002)(83380400001)(2906002)(38070700005)(122000001)(38100700002)(86362001)(55016003)(9686003)(66446008)(41300700001)(110136005)(76116006)(64756008)(54906003)(66556008)(66476007)(66946007)(316002)(6506007)(7696005)(53546011)(52536014)(8936002)(4326008)(8676002)(478600001)(71200400001)(26005)(7416002)(5660300002)(44832011)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVhVTDBuNUorallQbzFxZzRaY1RzWmNpb1Z4THRWZFRlN1Q3ZUZ0MmFmUHZP?=
 =?utf-8?B?bXdPcFg3OFJxS2VPY21SazVoK2h2UjR5cE1ZRENrRzZmM3MxVDhLbS9ROXhy?=
 =?utf-8?B?dlBnMjJUc2dZeVZvRUxlY2E4bHJlNWxXR2U3b3FyNGVPU1BoODZlbkV6QTFK?=
 =?utf-8?B?L1pYaVBqbm5yWXhZcjQ5WW5BZC9td085bkRxdis3ZjRIbUJGZFcyMC9SbGtn?=
 =?utf-8?B?Y1NqSFJERGRpR29FUnNiWk5Senk1QXFNZ1ZSWitGcFVZTTdmcDU2L2ZnM3hN?=
 =?utf-8?B?bVZaK0Rab3EyZFducVlTYWpIZm9VcjQ2am9vMnhHSjFjNkpid2g3UWZkZGRJ?=
 =?utf-8?B?eSsxVnIwV01iY0ozZTh0aUQvaUc2dDFsWEE4bi9tRDJ0Wng2U0pWWUVVd2lP?=
 =?utf-8?B?Q0g0ell6Z0hCMUNZWDRuWkNHcVIreXptREFTUDBvbmtFeDBVN3VoYXBxZnIv?=
 =?utf-8?B?eXo0cGI5TU1IS0xodDNWNWM5b3BvaXBkditaNnZHVklqTDk4K29nNEZjUVVV?=
 =?utf-8?B?cWZSSUg4ckFRSjhUc2djWEI1cGlNU09CNnVkRXlmait0ZTB4RXpRQlc3RGN6?=
 =?utf-8?B?STc0ank5c1ZRMVdabjZocm9OVllaZ3c2TDRmSnBOWDV4U1p5amxLNUk1dnN3?=
 =?utf-8?B?cThXdWxBaHhramV0eUxWWXF0aXRvc1d0M2VEQUZ2V09Qc3ZWQTZ4S2dITkZn?=
 =?utf-8?B?NEpOemswdVZRUHB1bzcySm1HcmdlNnFBVlVEUTJmanY0NHYzVUhtcU52Ukxx?=
 =?utf-8?B?bmVpN040RTc5WHFVdzhzdkF2MDlpZSswZHB5M3BCNHdwRVR6THk3VW1KL29Y?=
 =?utf-8?B?VUFKd1RUMDgweVpBWm0xTXV5a3NtMytpUnpiMGV3Yy9ldEFJQ2kvRWFFM0I1?=
 =?utf-8?B?V3A5YTdLWkJGMXRUa1FmaFMwanN1Z2VrTHRWRDBOSlg2bFcwRVFkSFJTQ2Ji?=
 =?utf-8?B?aXRXQzlwU216anBuenRyanY4bWhGY0ZTUGczR050RXozdUYwKzJtUEhoZENX?=
 =?utf-8?B?TXJOUGo3YXhmUGpFSmFaUVJhYTRwOGxmWDEyWi9WQzVCTFE4cDd2d2NYSFhT?=
 =?utf-8?B?aDdUZlY2MHUvTEpBUm9PQXhhMHJtOU4zSlUvak9ndXZKTU9NQnFGaTZyM2Ni?=
 =?utf-8?B?enhBRk9qWkE4RytxTlZZczdMVjI3NlBrRE00TWxrUG5vUHdIOTVjaW1WbXB6?=
 =?utf-8?B?T0RTSXRMZVh2a04zWWFCT09TL3ZUUzZjNnQ4TEFPcjFFUExxWnNBSEtyUW90?=
 =?utf-8?B?UlAySVVnTzA1WWVYSlZTRUhCQ0JrNTN6UVJvS0RSKzBSUzNaVEdXVnNmMWlv?=
 =?utf-8?B?LzZHTmtvaXJSaGY0QUsrRnlwWFZzbDVsMnkwQk5MYjN5c01NM0h5TloxTDdJ?=
 =?utf-8?B?QlJIZmw1VC96VFFiZWpwajNkYmE3WGREN01pWkdtYzZwcy9tUmVsaFFZS0cr?=
 =?utf-8?B?MXpmVkJzQnREZjlqcmxSYWhmbGFWcDBxaXREOG9GY0NVRi9zbHZTeEZNNEFT?=
 =?utf-8?B?WWk2T2cvU3dTaTFlWEx1dURRTFFSUVQxMU5qL2VNNlFpaG9uTFEya0J6c1Ex?=
 =?utf-8?B?cC9tbUZiMVVIMVhTU0FxR0hpRkhqMnB2ZEdlQzdUd0xrcDlJM2lmQ25tUnVa?=
 =?utf-8?B?aXF5eEh0WGhpY1d0YmVMT29QZGNjTXgwN1NMNHcyWk12bjVxQk5QK21LVUJW?=
 =?utf-8?B?QldMUlVPNmxxeXMvTUJjUmxTNWRTT1NHdWF5K3VIQm1qYzF2MzZHamp0aG9B?=
 =?utf-8?B?eTlvc2ZOR2Zad25aVFlJSGhZZ0lyMGtKUHpiaGVzOEhJYXlCaGxMb01oK285?=
 =?utf-8?B?VkVtbVFWYjBWeGpLeFNoZHhpVGlyMk5PY1pXZGxMa2lOMFVIV214STY0U3hI?=
 =?utf-8?B?UWFTZWpyaEJWUGtSZElKVGZUOFpCRDF2TWhPWGVmQlpXRzJ0QmJYZ3ljZ0d1?=
 =?utf-8?B?TEtDWjJFZmV2SE43emFDV0VOZlMxU2ZzUTVneE5hWElEdHpxbTNJM0pHVUhm?=
 =?utf-8?B?N3V2N2d3WEZrUmJUT2p1bGNjUnJhUHJ0aWlNc0lXMnovL2ZBZ0xuWUY3L1NC?=
 =?utf-8?B?M01LR2c1ZkZsbHY2QzR1THJJZ0RkMm9SZVJnNmZzcWo4L3VoYW05Rnk3WWM1?=
 =?utf-8?Q?6UsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01221adb-6f37-4008-7247-08dba4a05442
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 12:47:51.8210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMpQ33kml9ZFSN4NUO3KJfIyC7dFvgdipTUDt7/nZjMUCXToLK7NsmTEXnAhH15PKBrKUAcz0aoZfMUKPir0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgcXVpY2sgcmVwbHkuDQoNCj4gU3ViamVjdDogUmU6IFtS
RkNdIHNjbWk6IHBpbmN0cmw6IHN1cHBvcnQgaS5NWDkNCj4gDQo+IE9uIFRodSwgQXVnIDI0LCAy
MDIzIGF0IDk6MDHigK9BTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+
IHdyb3RlOg0KPiANCj4gPiBUaGlzIHBhdGNoIGlzIGp1c3QgdG8gaW50cm9kdWNlIGkuTVggc3Vw
cG9ydCB0byBzZWUgd2hldGhlciBwZW9wbGUNCj4gPiBoYXZlIGNvbW1lbnRzIGZvciB0aGUgZGVz
aWduLg0KPiANCj4gVmVyeSBpbnRlcmVzdGluZyENCj4gDQo+ID4gVGhlIGJpbmRpbmcgZm9ybWF0
Og0KPiA+IDxtdXhfcmVnIGNvbmZfcmVnIGlucHV0X3JlZyBtdXhfbW9kZSBpbnB1dF92YWw+DQo+
ID4gZHRzOg0KPiA+ICAgICAgICAgcGluY3RybF91YXJ0MTogdWFydDFncnAgew0KPiA+ICAgICAg
ICAgICAgICAgICBmc2wscGlucyA9IDwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBNWDkz
X1BBRF9VQVJUMV9SWERfX0xQVUFSVDFfUlggICAgICAgICAgICAgICAgICAweDMxZQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIE1YOTNfUEFEX1VBUlQxX1RYRF9fTFBVQVJUMV9UWCAgICAg
ICAgICAgICAgICAgIDB4MzFlDQo+ID4gICAgICAgICAgICAgICAgID47DQo+ID4gICAgICAgICB9
Ow0KPiA+DQo+ID4gaS5NWCBwaW5jdHJsIG5vdCB1c2UgZ2VuZXJpYyBwaW5jb25mLCB0aGlzIGhh
cyBiZWVuIGFncmVlZWQgYnkNCj4gPiBtYWludGFpbmVycyBiZWZvcmUuDQo+IA0KPiBZZXMsIGl0
IGhhcyBoaXN0b3JpY2FsIHJlYXNvbnMuDQo+IA0KPiA+IFNvIGFmdGVyIG1vdmluZyB0byBTQ01J
LCB3ZSB3aWxsIHN0aWxsIGtlZXAgdGhlIHNhbWUgYmluZGluZyBmb3JtYXQsDQo+ID4gYW5kIGku
TVggU0NNSSBmaXJtd2FyZSBhbHNvIHVzZSBzYW1lIGZvcm1hdCB3aGVuIGNvbmZpZ3VyZSByZWdp
c3RlcnMuDQo+ID4gU28gd2UgbmVlZCB0byB1c2UgaS5NWCBzcGVjaWZpYyBkdF9ub2RlX3RvX21h
cCBmdW5jdGlvbi4NCj4gDQo+IEkgdGhvdWdodCB0aGUgaWRlYSB3aXRoIFNDTUkgd2FzIHRvIGFi
c3RyYWN0IGFuZCBoaWRlIHRoZSBjaGFyYWN0ZXJpc3RpY3Mgb2YNCj4gdGhlIHVuZGVybHlpbmcg
aGFyZHdhcmUuIEkuZS4gdGhlIGZpcm13YXJlIGlzIHRvIHByZXNlbnQgZ3JvdXBzIGFuZA0KPiBm
dW5jdGlvbnMgYW5kIGdlbmVyaWMgY29uZmlnIG9wdGlvbnMgYW5kIHRoZW4gdGhlIGRyaXZlciB3
aWxsIHVzZSB0aGVzZS4NCj4gDQo+IFRoaXMgcGF0Y2gsIGl0IHNlZW1zLCBjcmVhdGVzIGEgaHli
cmlkIGJldHdlZW4gdGhlIG9sZCBmcmVlc2NhbGUgZHJpdmVyIGFuZA0KPiB0aGUgU0NNSSBmaXJt
d2FyZSBjb21tdW5pY2F0aW9uIGxpbmsgd2hlcmUgdGhlIFNDTUkgaXMganVzdCBhIHRyYW5zcG9y
dA0KPiBtZWNoYW5pc20gdG8gc29tZXRoaW5nIGluc2lkZSBTQ01JIHRoYXQgcG9rZSB0aGUgc2Ft
ZSByZWdpc3RlcnMgdGhhdA0KPiB1c2Vyc3BhY2UgY291bGQgcG9rZSwgaWYgaXQgY291bGQgb25s
eSBhY2Nlc3MgdGhlc2UgcmVnaXN0ZXJzLg0KPiANCj4gSS5lIHVzaW5nIFNDTUkgb24gdGhpcyBw
bGF0Zm9ybSBpc24ndCBjcmVhdGluZyBhbnkgYWJzdHJhY3Rpb24gb2YgdGhlIHBpbg0KPiBjb250
cm9sIGhhcmR3YXJlLCANCg0KUmlnaHQuDQoNCml0IGlzIG1lcmVseSBtYWtpbmcgdGhpbmdzIG1v
cmUgY29tcGxleCBhbmQgYWxzbyBzbG93ZXINCj4gYnltYWtpbmcgdGhlIHJlZ2lzdGVycyBvbmx5
IGFjY2Vzc2libGUgZnJvbSB0aGlzIFNDTUkgbGluay4NCg0KVGhpcyBpcyBmb3Igc2FmZXR5IHJl
YXNvbiwgdGhlIHBpbmN0cmwgaGFyZHdhcmUgbXVzdCBiZSBoYW5kbGVkDQpieSBhIHN5c3RlbSBt
YW5hZ2VyIGVudGl0eS4gU28gbW1pbyBkaXJlY3QgYWNjZXNzIG5vdCBhbGxvd2VkDQpmcm9tIENv
cnRleC1BIHNpZGUuDQoNClRoZSBTQ01JIGZpcm13YXJlIGlzIHZlcnkgc3RyYWlnaHRmb3J3YXJk
LCB0aGVyZSBpcyBubyBncm91cCBvcg0KZnVuY3Rpb24uDQoNCkl0IGp1c3QgYWNjZXB0cyB0aGUg
Zm9ybWF0IGFzIHRoaXM6DQpNVVhfVFlQRSwgTVVYIFZBTFVFLCBDT05GX1RZUEUsIENPTkZfVkFM
LCBEQUlTWV9UWVBFLA0KREFJU1kgSUQsIERBSVNZX0NGRywgREFJU1lfVkFMVUUuDQoNClNpbWls
YXIgYXMgbGludXggTU1JTyBmb3JtYXQuDQoNCk91ciBpLk1YOTUgcGxhdGZvcm0gd2lsbCBzdXBw
b3J0IHR3byBzZXR0aW5ncywgb25lIHdpdGggU0NNSQ0KZmlybXdhcmUsIG9uZSB3aXRob3V0IFND
TUkuIFRoZXNlIHR3byBzZXR0aW5ncyB3aWxsIHNoYXJlDQp0aGUgc2FtZSBwaW5jdHJsIGhlYWRl
ciBmaWxlLg0KDQpBbmQgdG8gc2ltcGxpZnkgdGhlIHNjbWkgZmlybXdhcmUgZGVzaWduKGFueXdh
eSBJIGFtIG5vdCBvd25lcg0Kb2YgdGhlIGZpcm13YXJlKSwgdG8gbWFrZSBwaW5jdHJsIGhlYWRl
ciBzaGFyZWQgdy9vIHNjbWksDQp3ZSB0YWtlIHRoZSBjdXJyZW50IGluLXVwc3RyZWFtIGZyZWVz
Y2FsZSBpbXggYmluZGluZyBmb3JtYXQuDQoNClRoYW5rcywNClBlbmcuDQogDQo+IA0KPiBCdXQg
SSBjb3VsZCBoYXZlIG1pc3VuZGVyc3Rvb2QgaXQsIHNvIHBsZWFzZSBjb3JyZWN0IG1lIQ0KPiAN
Cj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCg==
