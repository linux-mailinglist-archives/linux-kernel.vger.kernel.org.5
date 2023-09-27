Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E267AFF85
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjI0JLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjI0JK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:10:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5377097;
        Wed, 27 Sep 2023 02:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpjSVXSnciCR7D4/r+7Ta+w0lJCYkTEgbWA5CWcOpS0zOAJ89mn1ZpIh8RqoGdCkpCgEWDq1xbJt6bsVnRbRIJ2nMe0VKChOBDMGzD2s7Y39+0GxCzP4HM6zED+SEz3TmRe4Busi+UcfVuGNzMtkPo/wskiFfSREpNRAvn3T5EXo/qxXwspJmtMowIHUkgVp5SlCuCafsl+Ep+PFr2LtsBXQgxd8pEtGZ0IRhG3vgqIdVchQto1u0XLfsgy34ElC5yxNmwln+Z4ugXdcgGU6P/XTnST7GLIGVUFI04X/vkqJfgqbeX0pLv3czeAUaJ866PEioWvyNm33lBPuZEcROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdljU9CgOsdsU4kIlvNwU9DwgofNTvHltA89LMDc1lY=;
 b=S7PCY0HmyERqBDBFJ7UvSUHC+R29RLD/OAx+ZYEd1G3Whf760KZAE7QQLNfW+aZJ05snyADZxUXEfosTvBuD9Er4tHW2g+B02Eh1aGq1k9dZaOc8bPDh+mW5uoidtx6QPFRxjMlHXYG7n9j5e/nTMfxHs9EYU8CNx3eyIv/oCLPHv/Y4EkhOgJbrIi0imbDmd+NPKB5Avk2937mGqeWHQ9wip4+heULNGfzHEWrMvm6UTW+iSuqz6bi4Gr9sxQzqQ5v1zQk5KlkC/dwotMJpQmr+j757E+mz1+mQNGCZDTqMVnfEceVtmgyci3Y0QS7AdxkgINmuW4tWRSagE0GKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdljU9CgOsdsU4kIlvNwU9DwgofNTvHltA89LMDc1lY=;
 b=EVrdEEI8SX+Zj6C/F0hdSQ8JWpVDw7SKcqHiTzosTJxdD5ZoxGAq7lqgSoQRN1BKx/q1S01pxd40ZCp3V3jgUqlF/kdB0Xrrf9giCeYYuUXYZqNarJzOC1LKK/Nrgjb/S9Ihi+zdIPjSehmyfEg7WemEpwMyo0nF6d8NmxOscW4=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9217.eurprd04.prod.outlook.com (2603:10a6:102:232::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 09:10:53 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 09:10:53 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ8GGrmZBLZQgREEat4sCPmu/sQrAuUiWAgAANvVA=
Date:   Wed, 27 Sep 2023 09:10:52 +0000
Message-ID: <AM6PR04MB63415CF2EDCF0AF33F778774E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <2c351ca0-cee4-4c1b-956b-6134ad101a9a@linaro.org>
In-Reply-To: <2c351ca0-cee4-4c1b-956b-6134ad101a9a@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|PAXPR04MB9217:EE_
x-ms-office365-filtering-correlation-id: 9c4de147-05b0-4cab-7a45-08dbbf39a677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLEC6ZjDBHhLGQspIcPa3/PabXyRwMVE/CCWrMSOhhxKTcI6+ZD2WqNOAP+kt3pIKn+y1OZosFstDoU9Pu6oTdnLXZdAllXkwWt+iDVQKjMe0GRR1IyCKE8deeVaEJlQH2JYaqxprDPSLgeRcyWwW1Mz8I0KZolblPW7K5Rxh93HfQShj/KHncZHzkvrlfB1dohvWW0NFkRpOOfTuA5vZOLYYhQFb/5RgxrVe0JsF1kCJhQnum2f486TCQ9IhActAg+32pjkkJ78bjEk3mb+M1jfpKFg6133GefivOx6NKpW6JoGOS6DGHZ7RbPq7bTYqtfL0m/OkI8EQnKWGQGS0TDd+3BtEABu6/e+7jahsSY4t0ZagFbxtC+GlzeIIpMCr6gaMxhVrJ/bWCsV/i1VA0Y6l0L4Zfk+UQFsJIQby3eJAQqpcAH/di4rWwXJDkEr+JXCaDGXo5nN3HTjYO0dXTx1fI6LUrX8y5jnp7/kzR4ZK+FnjHEKmiZZX9MZLXnK6J+6cD+6H/qP7ho7p4DI/OE1OEv6E62PZsU9w83pQhx7iysE245BbRFuCmtN2w7yLSZfwwAN3mgwVWZsqx7vyWQjLP/f8P+aTONfQMyGDI3liUZMcqLz5FNSmskupgcw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(7416002)(316002)(41300700001)(55016003)(26005)(2906002)(52536014)(5660300002)(8676002)(66556008)(110136005)(478600001)(66446008)(64756008)(44832011)(54906003)(66476007)(66946007)(76116006)(4326008)(8936002)(71200400001)(6506007)(7696005)(9686003)(83380400001)(86362001)(33656002)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3dHOFlkMzhjTnN1OFhwTGZzOHRmRmVNSnFEYWVZUWFRVGdqdDJ1azJ5K3Zn?=
 =?utf-8?B?VGNhd25EVU5oVlJqZUw4bUVtbk5zcE9FcjVJYm9yM3U0ekdsTUxPdkg2UWxw?=
 =?utf-8?B?SGkzOWlIMmgvbXl6TUZlQWprM1N0cU9GVXhHc0dTYTZxMTNoWU5wR2MrdGtK?=
 =?utf-8?B?aE9zNlNjNmc5eVg3aXlxcTZZR0pJakRpWGN5aVUwYlVlczJ6UnpEeFZmZ3BK?=
 =?utf-8?B?SHBuSHpaQ3pyOXBiTXp1S2hBOGFqTjRRTEhPKzlLQTVzYUJEbysyS3h5RTkr?=
 =?utf-8?B?YjNqVGZXVlhSelJwYnQ0L1RXY0hRMWJmalpOUm1WSjZDUFZ0cUM4SnNlUC95?=
 =?utf-8?B?N3Y0eHFnRE95NjlmeUxxUnlIdGNiMitMQkthVVhyemZJWU1LQW9PWTM2YnJo?=
 =?utf-8?B?cFRleWZOK1NwNXVXZ2dWa1hKZXRHcnFBNEdhWUY2ZlhwT0VEQVp0OHZ2WC81?=
 =?utf-8?B?dW9jZmZnVmlNNjVNbHFsaTMrQVp0WlJER2owQnNXMVZDd0dkVmRodnVoUWhj?=
 =?utf-8?B?K1lxKzNWcUFMY2hwU3JRMGcxQlJXQnRGUFA3SEpnSE5zaWNwYS9KbDBWZHll?=
 =?utf-8?B?bWJ4ekhZNlFOclBwcldEa3Uzd3YwTndFZFZ3enpXS1c5TmdjU1NvclBEUk1s?=
 =?utf-8?B?RkRnaTd5SmNIbVdvVUpmNXlBN2pCcGdETmNudk5KVnIxNkhsVjlsNTVBeHFL?=
 =?utf-8?B?SmtVQTR5SGU2cE8rWDMzM0pkZVZ6TkhabEpQd0RyVHBxUG5SWFNhU0ZGZU1q?=
 =?utf-8?B?ZFJOcldSREVQbFFFRGlROFo0aVZYaE5XR215aUVnVVFnRGIwRnZJVVgzYk1X?=
 =?utf-8?B?WFpVMnBGOXVpZDdOR0grMGJUU2NpVVRqNWZFeTJnSDYrbkFtVzQva1l4Smg0?=
 =?utf-8?B?YUxXMURaaUZlNlNPdGxzR1AxMW9LRitmZjk3NkVkQWc4Q0svYTJVbGwrd3pF?=
 =?utf-8?B?OUlvd2NqRXFSdFJCcFFXMklGWDZ0S1lCWHBrOUlQbG9lV0ZjazBBZ2pUUURj?=
 =?utf-8?B?cmFja1FIbWI0QjRYK3hKNTRzY0VveElycG9EYWUyczZ2ODlMUlV3Wjl1R3k2?=
 =?utf-8?B?bU9nUHFoM0x5NE95NnMvalBoQ0ZBSU4rUFJQdklaTEJTRzJHd0ZOZHM5UG5T?=
 =?utf-8?B?d0o4K05CK1NPRXdoVzFSK1ZPdzRFM2dPdHBsNHM0QTAwMTFLZ2p3cTQ4dzZ6?=
 =?utf-8?B?MllWSTB3TlppcW9mVG1nMWV5VGs5VlJGK25JRldScTByT3c1Tk1YOTVqb3FF?=
 =?utf-8?B?R1ZPY0ZoWHN4WGFDRDIvWDVsWUY2eEU3dXMyY3JKTFowR1k1Z0k2TlQ1U3pO?=
 =?utf-8?B?eEh0aThneFArMDJGamZxWkFEdEZmUVdnNHMwZnQzSTdsdzBnYy9kdk9jWFJm?=
 =?utf-8?B?a0NLSWVQRG42SFVzRmYvUHV0ZUZpSlplYnZGS3pjL3ExN1cvTWxWZnc1T01x?=
 =?utf-8?B?LzlBT1I4UWVSMlk4a0x0UllWRGhCLzNndTA3YXBpa1loakJ6b0E5cVIyRFo2?=
 =?utf-8?B?YUVhMnREOEFNZEhiZW9maDcza29kNTVISFRQQkpuSHpMWFZRUUhib1A0cHV3?=
 =?utf-8?B?S2VTWFpvNEUzZ3NjTWd0ZzJHVGp2amMybXJlSzhwRTdrMUFBUDJGY2IzekZ4?=
 =?utf-8?B?MTFZTXBDeHNrR3N3NXV6dFdraWljTGh1WjlCcTJMYUZicGVDU3pUQ0JieFlT?=
 =?utf-8?B?QlZGN3g2eFR6ZTBxWjlvQ0NaZ2VhTTcxbUNMaDlFcDVDVEVJR1dZL3BXMVc1?=
 =?utf-8?B?Mm5ZcldNSUpwUW5MekRORTRMQ1dUTW9SRW1WYzYyVUFLYjhKdmJLYjI2K2dH?=
 =?utf-8?B?MDlqcVJGeWFjSFF2OU8xd2FzVlE5Qzhjemp6bVY4TXpzQ1dnL0JqSitwSldn?=
 =?utf-8?B?QXpicTdmS05vd053V04xU09lUVBNcVp1Z21VUDVybFFYSEZDV2k2UmN4T2FC?=
 =?utf-8?B?ZU1RTWhwTGhIbU9JakhJWjdwUHo0aC9vaFFpbUdocE9uQk1ReDI5R2dHcGR4?=
 =?utf-8?B?U284Q0cyVTkzQUhFYVdpcnVHbjJOdFBpS1JrdElicXU3NHJXSVFZNFpvbjRr?=
 =?utf-8?B?TUlDN1J1Rmw2OXFZVkxKR21LV0F4cUd3NXNGNHhaT05kanZTWW1Qb3Fsa2N1?=
 =?utf-8?Q?bkU0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4de147-05b0-4cab-7a45-08dbbf39a677
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:10:52.9579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4+47cXt6Jowy5V6/xhlBuJN57RhSxtv63ikeN91O2JepI5mgPNEwBlieSFJd/oycljlUEM2kdsmqkkN24YjoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDI35pelIDE2OjA2DQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
aWFuQG54cC5jb20+OyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPjxtaXJlbGEucmFidWxlYUBvc3Mu
bnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPkNjOiBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+
bWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
IFguSC4gQmFvDQo+PHhpYWhvbmcuYmFvQG54cC5jb20+OyBFYWdsZSBaaG91IDxlYWdsZS56aG91
QG54cC5jb20+OyBUYW8gSmlhbmcNCj48dGFvLmppYW5nXzJAbnhwLmNvbT47IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPmRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggdjQgMi8yXSBkdC1iaW5kaW5nczogbWVkaWE6IGlteC1qcGVnOiBBc3NpZ24gc2xv
dCBmb3INCj5pbXgganBlZyBlbmNvZGVyL2RlY29kZXINCj4NCj5DYXV0aW9uOiBUaGlzIGlzIGFu
IGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3IN
Cj5vcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2Ug
dXNpbmcgdGhlICdSZXBvcnQNCj50aGlzIGVtYWlsJyBidXR0b24NCj4NCj4NCj5PbiAyNi8wOS8y
MDIzIDEyOjEwLCBNaW5nIFFpYW4gd3JvdGU6DQo+PiBUaGVyZSBhcmUgdG90YWwgNCBzbG90cyBh
dmFpbGFibGUgaW4gdGhlIElQLCBhbmQgd2Ugb25seSBuZWVkIHRvIHVzZQ0KPj4gb25lIHNsb3Qg
aW4gb25lIG9zLCBhc3NpZ24gYSBzaW5nbGUgc2xvdCwgY29uZmlndXJlIGludGVycnVwdCBhbmQN
Cj4+IHBvd2VyIGRvbWFpbiBvbmx5IGZvciAxIHNsb3QsIG5vdCBmb3IgdGhlIGFsbCA0IHNsb3Rz
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+
PiAtLS0NCj4+IHY0DQo+PiAtIGltcHJvdmUgY29tbWl0IG1lc3NhZ2UNCj4+IC0gZG9uJ3QgbWFr
ZSBhbiBBQkkgYnJlYWsNCj4+IHYzDQo+PiAtIGFkZCB2ZW5kZXIgcHJlZml4LCBjaGFuZ2UgcHJv
cGVydHkgc2xvdCB0byBueHAsc2xvdA0KPj4gLSBhZGQgdHlwZSBmb3IgcHJvcGVydHkgc2xvdA0K
Pj4NCj4+ICAuLi4vYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sICAgICAgICAgfCA0
NSArKysrKysrKystLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KyksIDI0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQNCj4+IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL254cCxpbXg4LWpwZWcueWFtbA0KPj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sDQo+
PiBpbmRleCAzZDlkMWRiMzcwNDAuLjRiY2ZjODE1Yzg5NCAxMDA2NDQNCj4+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlhbWwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1q
cGVnLnlhbWwNCj4+IEBAIC0zMiwxOSArMzIsMjYgQEAgcHJvcGVydGllczoNCj4+ICAgICAgbWF4
SXRlbXM6IDENCj4+DQo+PiAgICBpbnRlcnJ1cHRzOg0KPj4gLSAgICBkZXNjcmlwdGlvbjogfA0K
Pj4gLSAgICAgIFRoZXJlIGFyZSA0IHNsb3RzIGF2YWlsYWJsZSBpbiB0aGUgSVAsIHdoaWNoIHRo
ZSBkcml2ZXIgbWF5IHVzZQ0KPj4gLSAgICAgIElmIGEgY2VydGFpbiBzbG90IGlzIHVzZWQsIGl0
IHNob3VsZCBoYXZlIGFuIGFzc29jaWF0ZWQgaW50ZXJydXB0DQo+PiAtICAgICAgVGhlIGludGVy
cnVwdCB3aXRoIGluZGV4IGkgaXMgYXNzdW1lZCB0byBiZSBmb3Igc2xvdCBpDQo+PiAtICAgIG1p
bkl0ZW1zOiAxICAgICAgICAgICAgICAgIyBBdCBsZWFzdCBvbmUgc2xvdCBpcyBuZWVkZWQgYnkg
dGhlIGRyaXZlcg0KPj4gLSAgICBtYXhJdGVtczogNCAgICAgICAgICAgICAgICMgVGhlIElQIGhh
cyA0IHNsb3RzIGF2YWlsYWJsZSBmb3IgdXNlDQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAg
ICAgIEludGVycnVwdCBudW1iZXIgZm9yIHNsb3QNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+DQo+
PiAgICBwb3dlci1kb21haW5zOg0KPj4gICAgICBkZXNjcmlwdGlvbjoNCj4+ICAgICAgICBMaXN0
IG9mIHBoYW5kbGUgYW5kIFBNIGRvbWFpbiBzcGVjaWZpZXIgYXMgZG9jdW1lbnRlZCBpbg0KPj4g
ICAgICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9wb3dlcl9kb21h
aW4udHh0DQo+PiAtICAgIG1pbkl0ZW1zOiAyICAgICAgICAgICAgICAgIyBXcmFwcGVyIGFuZCAx
IHNsb3QNCj4+IC0gICAgbWF4SXRlbXM6IDUgICAgICAgICAgICAgICAjIFdyYXBwZXIgYW5kIDQg
c2xvdHMNCj4+ICsgICAgbWluSXRlbXM6IDEgICAgICAgICAgICAgICAjIFZQVU1JWA0KPj4gKyAg
ICBtYXhJdGVtczogMiAgICAgICAgICAgICAgICMgV3JhcHBlciBhbmQgMSBzbG90DQo+PiArDQo+
PiArICBueHAsc2xvdDoNCj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5p
dGlvbnMvdWludDMyDQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEludGVnZXIgbnVt
YmVyIG9mIHNsb3QgaW5kZXggdXNlZC4gVGhlcmUgYXJlIDQgc2xvdHMgYXZhaWxhYmxlIGluIHRo
ZSBJUCwNCj4+ICsgICAgICBhbmQgZHJpdmVyIGNhbiB1c2UgYSBjZXJ0YWluIHNsb3QsIGl0IHNo
b3VsZCBoYXZlIGFuIGFzc29jaWF0ZWQgaW50ZXJydXB0DQo+PiArICAgICAgYW5kIHBvd2VyLWRv
bWFpbi4gSW4gdGhlb3J5LCBpdCBzdXBwb3J0cyA0IG9zIG9yIHZtLiBJZiBub3Qgc3BlY2lmaWVk
LCAwDQo+PiArICAgICAgaXMgdXNlZCBieSBkZWZhdWx0Lg0KPj4gKyAgICBtaW5pbXVtOiAwDQo+
PiArICAgIG1heGltdW06IDMNCj4NCj5OQUssIHlvdSBzdGlsbCBkaWQgbm90IGFuc3dlciBjb25j
ZXJucyB3aHkgdGhpcyBpcyBuZWVkZWQgYW5kIGp1c3RpZmllZC4NCj5JIGtlZXAgYXNraW5nIGFu
ZCB5b3Uga2VlcCBpZ25vcmluZy4uLg0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCg0K
SGkgS3J6eXN6dG9mLA0KDQo+IE5vdGhpbmcgZXhwbGFpbnMgd2hhdCBpcyBhIHNsb3QgYW5kIG5v
dGhpbmcgZXhwbGFpbnMgd2h5IGRvIHlvdSBuZWVkIHRoaXMgcHJvcGVydHkuDQoNCkkgdGhvdWdo
dCBJIGhhZCBhbnN3ZXJlZCB0aGF0IHF1ZXN0aW9uLCBidXQgc2VlbXMgeW91IGRvbid0IGFncmVl
IHdpdGggdGhhdCBleHBsYW5hdGlvbi4gDQpXb3VsZCB0aGUgZm9sbG93aW5nIGRlc2NyaXB0aW9u
IGJlIGFueSBiZXR0ZXI/DQoNClRoZSBzbG90IGlzIHRoZSBJUCB1c2VkIHRvIHNoYXJlIHRoZSBq
cGVnIGVuZ2luZSBhY3Jvc3MgbXVsdGlwbGUgVk1TIGFuZCBvcywgdGhlcmUgYXJlIDQgc2xvdHMg
YXZhaWxhYmxlIGluIHRoZSBJUC4gV2UgY2FuIHVzZSBvbmUgc2xvdCBpbiBsaW51eC4gVGhlIHNs
b3QgaW5kZXggaW5kaWNhdGVzIHdoaWNoIHNsb3Qgd2UgY2hvb3NlLiBJZiBub3Qgc3BlY2lmaWVk
LCAwIGlzIHVzZWQgYnkgZGVmYXVsdC4NCg0KDQo=
