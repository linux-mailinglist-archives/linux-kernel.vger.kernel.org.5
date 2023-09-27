Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76147AFFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjI0JZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjI0JZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:25:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1485F3;
        Wed, 27 Sep 2023 02:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXprLa4EhbIVGrzMSPz5v0CIiXbSrrQqMUIJKhATixgxFKFhXAW9T2FeFyjbMDAhZLFJiED3fXlwTUzpF2WpJbiKQqOoZ4zEYEKBZpzVExBspYZEdDk4DLUU+4O9Z2SFCm5RuXvhB8va4yaczPH5W/F1fTClemcjpGmp8tndO1Ske9QlP7IJF7+6jFysbQOvw0lpZMPKIhgSZTGktVhsnRk29/JJr4WnVF8bx3tsXxYmBy53pHvPo3uYaLSRf+vhHB5PAs7hITldWLmXkC28a453l4VAy+qyJQtY+O9uQXs3rkolQkvwBC04jgx7s1lh9MabEY3vn5hyl1vDGETYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13BfLocB1v8zngKcx1ApUTrZOf91vFChm3zUk4BY8hk=;
 b=h4FW5O3tmXosgvmOyhAWYOg1XFuNe51kS+7cdWMlSj29iAjH8asaPq1AuTctJpWOrvK5hIaRcozbZCjmODgD3CVxjlAiiKRP3XEmSVSherVelq32L5lSlKlVUI6rwAuJrUbyCQGJOiLZCLwQR4+RTN3Y+QKwST8K/S7Hl3Tpu5fS6ARuUpvrbk+07fdVMgq2Gp5VEdirMA4qeVY6prQxCwl6YFsrLNURI5Hq8VUdMOwvE80Q3XAHW5/Hhqn25bgTzSijny3iNe/FsS4qUDolAQp3qLkSJZP/Ov3+mQgx689Hg6EHO8FSOLHEuleQENs5sknM466b7TUdkKTJmx1opQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13BfLocB1v8zngKcx1ApUTrZOf91vFChm3zUk4BY8hk=;
 b=Upzf538W9NeQhqV9R47MEix99TjQNnm+/feN2YNoUfe5Rl+tTupV6BeqrTqd7xNMWbs9I90A5paIoVe+eSDSppVy0b7sx+Ldw+43uVM5sIhwQ/iUeoOXlDczQ5vwJ+AU7x/f+U8HAjhRBcd7bc8CS+LqIhyrEOhbjokemYUvAWs=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB9786.eurprd04.prod.outlook.com (2603:10a6:800:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 09:25:31 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 09:25:31 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
CC:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
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
Thread-Index: AQHZ8GGrmZBLZQgREEat4sCPmu/sQrAtGSWAgADFGZCAAHUzAIAAE0xA
Date:   Wed, 27 Sep 2023 09:25:31 +0000
Message-ID: <AM6PR04MB6341B76B30FBF12A58B77AE1E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <20230926-slackness-target-b74e33ab1031@spud>
 <AM6PR04MB6341B0D9EC8146149CF8ADB0E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <54c87219-de9f-4c5b-9c70-11de22c7c612@linaro.org>
In-Reply-To: <54c87219-de9f-4c5b-9c70-11de22c7c612@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|VI1PR04MB9786:EE_
x-ms-office365-filtering-correlation-id: 043dcb42-8398-4aed-271e-08dbbf3bb232
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KziA2MOBo53C3wGKnxpjvVcrcWz/Wq9dDnJ0KPR/o3PsYEJyu291MWp46nJ4Rr6abpkTzO0iO0Ju7plLe0oR4jWOjKyXHvQw2aYIxaha6Pa+NmArWo/jgfXeOru/8bG4RCx1CvxRwu25XWz9qPHT8gpKfXGN7aAAzknsXZNxKd3Q9yrGFItfUerLQwEREk/u1Qo0MDw6Pa/015kvORPRy5E/qdXYnI7dUCnO3B3d3EvFxpKRiYbE5/1rbfRqv3G14k0umROagvy3v3jcFfFlXGfvNR4al0CjyWfjxYa5+nnbsF0ssMzPSjIknL1MVxJHIUdCUnSe0NtXUXuiPm+6MuVJFOnM+4p7D08gf9hdxJpjDpe5buuG0qSvhqWj1P2Zvxf/fnUNJi0LOvcrrD0Jye8/XiQIBmdLGOAQdA8deYKHE5juMzhGVFxh+/Xd2dVP4AoJAaXyelYe/p8Phu941DXAL9DtkgV1qYKKWg3vfk/xN5bY/YJ7ZSlfqKDW/9VlQGM42UuQN/DxQny7xfL2gf9OnboR3d7SHt3eVujtsRrCXx+qQBXNq2p5rQdhQd+F+5cRc3sjGmBy0UFtxZ/MW2gmkW3VzGBjwC6T2HuOQX0pSLSZldFQU/8ScOt1a8w6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(6506007)(478600001)(9686003)(76116006)(66946007)(7696005)(33656002)(86362001)(66556008)(53546011)(966005)(71200400001)(45080400002)(26005)(110136005)(66476007)(122000001)(38100700002)(38070700005)(64756008)(66446008)(2906002)(5660300002)(83380400001)(55016003)(7416002)(8936002)(41300700001)(8676002)(4326008)(52536014)(316002)(44832011)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Um1yeUJ4alhtWitxamZ3Ukk2TmVSVG1jeGpIZXZQLzBqU0JtVE5ackRwdCtu?=
 =?gb2312?B?V2Z1RDJsZkpPb29icUl5S3BCV09nSTFHSjlWelViRUFHZFU5THMzenNTSkN6?=
 =?gb2312?B?ZHpoV2NlUzQvS1BpWWlCN0NvZkt0WmVTOVE3MGlyTU5zRys1YjhsWWJxbXUw?=
 =?gb2312?B?TWNnbEVxaG95WmYwdkQwS1BwdW1CcTVxOGZrdDZ3NHRwN1U3T3JMYkQzWWp2?=
 =?gb2312?B?ajljYkZVOEJBUVk2NlBLYjNnamJzNGF5a3h5SFBiZTM3T2laeHZrVnhXdUo2?=
 =?gb2312?B?WVJ1NDE5RVlCZyttVElsRnlaYjZ1cVlIbHJRbGt2ckh2Z0JONlNRYklicW8y?=
 =?gb2312?B?ZTZuNTAwQ3g5allqcTNkem53a3ZkdmtDTTdZY1M2ZUlmVm5hSG1NMHZtb0Zz?=
 =?gb2312?B?MitlNndoYmR3ZDkybGlvWGpaendGM3VmRW03bVVBMTB0cnVRMVlBTkI1bHor?=
 =?gb2312?B?L3h2cWJSWkluOGEzdDlNZ2drTWpUZzNqRlZ3UloxSEZrbjJ4dHNQWXB1MmFY?=
 =?gb2312?B?YUdzWFlWUEdCNGpNWkJkdVdzMWNwdmRLcG1KM3hmazY2QjRLOFpTZ3RXWVps?=
 =?gb2312?B?a0ZPTHJBakVwRG5pQmhNNEcvazh3aXJCd2U0T0J6TlBadHR6eTBROGc5akd4?=
 =?gb2312?B?TGxGSXh0WFNEcDZtZ1dhbTVTZW00Q0NsUE9HZjZWYzM1MmxaYUI0ZHJWRHN6?=
 =?gb2312?B?RlM3dndvSUloQTFBcGR3N2RxWTQ4YUl6TXZueTVpamNPUW9KMHUyZFVQM2Nz?=
 =?gb2312?B?TUc1M2R1TTR5UUQ2REsxQ1hQTjNERytkanZzczFBME1sbGwwanhwYUNSY29U?=
 =?gb2312?B?RWJlb2ViNDZPWldEc1BSSlp5L05ySit4THpqK0JEdCtkdzV4VmNvT2l2SWRq?=
 =?gb2312?B?N042aytPUmVoMWZCRytndXdHMmJYMkp6VjZHNXBiNXlHamR2cE9DMGpYdGxk?=
 =?gb2312?B?dHp5c1RQalMxVlRFN3BDS0pDVklSRzNVWHpmVXp0Sk90Q056WU1YTTU0cmdj?=
 =?gb2312?B?NHJjUTJ1VEtmYW1iQVV1YlE1eDk5V0ZVVXE0RlhhdnhBNjhDdmtVNDllcVpU?=
 =?gb2312?B?SXR2TXRzMEhIMThWV3pWQUwwcFo0bG0vVzh4bmlwMDNXZjhHaUF3N3JPaXBR?=
 =?gb2312?B?b01samlkaHNhNERDOEJCcHJqdHV4RzFZTnVoTW9OZnVhWVBDbjVwbmtUVy96?=
 =?gb2312?B?SXo3Z0FBMTdsRmpIR05JOU1aNHlwU084clNJY0IwSS9hTzgyNXhXNUc3cTBE?=
 =?gb2312?B?UE13WU5ZbzJKYUY5SDlkRyt1dUZDM2lVOTEzTXUxR2tyK2NjU0dRQ3FvNS9M?=
 =?gb2312?B?OGtFRGtWcDZCWWUrWXZUSDRxRFE2ZG9BQ21uSVlBS3kvTGkxTitRT3VURVUx?=
 =?gb2312?B?ejN6M3dCU2ppenlwZmprZWxDR1ZmNnhtUVcvYVcwWjk0NzJZdEtWNjE2QzBF?=
 =?gb2312?B?SDdHc0ZjczZWejJpcTdMMEZZSWFlTVc4aGllWUxoWWNqTjFReUs0NlVteDdx?=
 =?gb2312?B?QUtDbWhlSk1Va2dudTErQ2dpY25jYWsyaFUyZWo0U1FXUzA5WTEyRVN5ZnM2?=
 =?gb2312?B?RDgrQkdjb2NIWjFvaFhaMUszOVJaaVVYdGZVcjRzRWIrVXBFaUxQN004Y0pT?=
 =?gb2312?B?c1Rldi9LTjAzNmx2anZTd1dLZW84SWNFdGYvWms1b2JnbTlSbktxNTVockFy?=
 =?gb2312?B?QnAyVnRYbkdRekYyTWJ3SGRCN0tuM3ZmaFhTRTh3SlZ6Ym53aDY4akZEUXRp?=
 =?gb2312?B?ekpDUEhnTnlzTmh1b2E4dGF6c3NJb3V2emVnTGMxTXVPeVFzOWpxOXhHbVRC?=
 =?gb2312?B?aXpjcUVSUFFDMHdsYUFkKzFpZG5tOWsyd2Jhb2NIcXBYcXF4OTlEZ2xaVzhr?=
 =?gb2312?B?RGtXZkw3UjliRy9FcGNMckZ1cXNDNjBlQWt1RENvOEV1UFlSUFJ3dXVwNmJr?=
 =?gb2312?B?ejgza3JsRWdoeHo3dnBINUNlbWxNOWVvRXk0aGZraGZwMXlzc1M4OU1GalYv?=
 =?gb2312?B?c2JVNjRTY0tNME1tZlB2cDh4MjQ0VDErZHgxN3YvOWR4b1krMmlGMFBLcGt3?=
 =?gb2312?B?WjdtNXlMZ1N6TVREWmExYjhuTjFBNEttQkx1MUt6WC9MZFFCYkw1WndXd0lM?=
 =?gb2312?Q?DsT8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043dcb42-8398-4aed-271e-08dbbf3bb232
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:25:31.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOlT7Ouaukuf6Ib4rgg5t9b8xVwTQC3Vh8WiQFNVgnD3d4A2Xm2+7NLveY1hd876i001mun9yKn5pdP7cfxAlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9786
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
Zz4NCj5TZW50OiAyMDIzxOo51MIyN8jVIDE2OjExDQo+VG86IE1pbmcgUWlhbiA8bWluZy5xaWFu
QG54cC5jb20+OyBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+Q2M6IE1pcmVsYSBS
YWJ1bGVhIChPU1MpIDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47DQo+cm9iaCtkdEBrZXJu
ZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPmtyenlzenRvZi5rb3psb3dza2krZHRAbGlu
YXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj5tY2hlaGFiQGtlcm5lbC5vcmc7IGh2ZXJr
dWlsLWNpc2NvQHhzNGFsbC5ubDsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj5rZXJuZWxAcGVu
Z3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgWC5ILiBCYW8NCj48eGlhaG9uZy5iYW9A
bnhwLmNvbT47IEVhZ2xlIFpob3UgPGVhZ2xlLnpob3VAbnhwLmNvbT47IFRhbyBKaWFuZw0KPjx0
YW8uamlhbmdfMkBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnDQo+U3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMi8yXSBkdC1i
aW5kaW5nczogbWVkaWE6IGlteC1qcGVnOiBBc3NpZ24gc2xvdA0KPmZvciBpbXgganBlZyBlbmNv
ZGVyL2RlY29kZXINCj4NCj5DYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVh
c2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj5vcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj50
aGlzIGVtYWlsJyBidXR0b24NCj4NCj4NCj5PbiAyNy8wOS8yMDIzIDA0OjEwLCBNaW5nIFFpYW4g
d3JvdGU6DQo+Pj4gRnJvbTogQ29ub3IgRG9vbGV5IDxjb25vckBrZXJuZWwub3JnPg0KPj4+IFNl
bnQ6IDIwMjPE6jnUwjI2yNUgMjE6MjYNCj4+PiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5Abnhw
LmNvbT4NCj4+PiBDYzogTWlyZWxhIFJhYnVsZWEgKE9TUykgPG1pcmVsYS5yYWJ1bGVhQG9zcy5u
eHAuY29tPjsNCj4+PiByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+
Pj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3Jn
Ow0KPj4+IG1jaGVoYWJAa2VybmVsLm9yZzsgaHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sOyBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOw0KPj4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1A
Z21haWwuY29tOyBYLkguIEJhbw0KPj4+IDx4aWFob25nLmJhb0BueHAuY29tPjsgRWFnbGUgWmhv
dSA8ZWFnbGUuemhvdUBueHAuY29tPjsgVGFvIEppYW5nDQo+Pj4gPHRhby5qaWFuZ18yQG54cC5j
b20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4+PiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4+PiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4+PiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY0IDIvMl0gZHQtYmluZGluZ3M6IG1l
ZGlhOiBpbXgtanBlZzoNCj4+PiBBc3NpZ24gc2xvdCBmb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNv
ZGVyDQo+Pj4NCj4+PiBIaSwNCj4+Pg0KPj4+IE9uIFR1ZSwgU2VwIDI2LCAyMDIzIGF0IDA2OjEw
OjAwUE0gKzA4MDAsIE1pbmcgUWlhbiB3cm90ZToNCj4+Pj4gVGhlcmUgYXJlIHRvdGFsIDQgc2xv
dHMgYXZhaWxhYmxlIGluIHRoZSBJUCwgYW5kIHdlIG9ubHkgbmVlZCB0byB1c2UNCj4+Pj4gb25l
IHNsb3QgaW4gb25lIG9zLCBhc3NpZ24gYSBzaW5nbGUgc2xvdCwgY29uZmlndXJlIGludGVycnVw
dCBhbmQNCj4+Pj4gcG93ZXIgZG9tYWluIG9ubHkgZm9yIDEgc2xvdCwgbm90IGZvciB0aGUgYWxs
IDQgc2xvdHMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pbmcgUWlhbiA8bWluZy5xaWFu
QG54cC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiB2NA0KPj4+PiAtIGltcHJvdmUgY29tbWl0IG1lc3Nh
Z2UNCj4+Pg0KPj4+PiAtIGRvbid0IG1ha2UgYW4gQUJJIGJyZWFrDQo+Pj4NCj4+PiBXaGF0IGRv
ZXMgdGhpcyBtZWFuPyBDYW4geW91IHBsZWFzZSB0cnkgdG8gZXhwbGFpbiB0aGluZ3MgYSBiaXQg
bW9yZQ0KPj4+IGNsZWFybHkgaW4geW91ciBjaGFuZ2Vsb2dzPw0KPj4+DQo+Pj4gQWxzbywgd2hl
cmUgaXMgdGhlIGNvZGUgdGhhdCBhY3R1YWxseSBtYWtlcyB1c2Ugb2YgdGhlc2UgcHJvcGVydGll
cz8NCj4+DQo+PiBJbiB2MyBwYXRjaCwgSSBtYWtlIHRoaXMgcHJvcGVydHkgcmVxdWlyZWQsIG1h
a2UgaXQgYW4gQUJJIGJyZWFrLCBzbyBpbiB2NCwgSQ0KPnJlbW92ZSBpdCBmcm9tIHJlcXVpcmVk
LCBhbmQgZGVmYXVsdCB0byB0aGUgcHJldmlvdXMgYmVoYXZpb3IgaWYgaXQgaXMgbWlzc2luZy4N
Cj4NCj5TbyBzYXkgdGhhdCB5b3UgZHJvcHBlZCBsaW5lIG1ha2luZyB0aGUgcHJvcGVydHkgcmVx
dWlyZWQuDQo+DQoNCkdvdCBpdCwgdGhhbmtzDQoNCj4+DQo+PiBUaGUgY29kZSBwYXRjaCBpcyBz
ZW50IGJlZm9yZSwgYnV0IHRoZSBkdHMgY2hhbmdlIGlzIG5vdCBhcHBsaWNhYmxlLCBzbyBJIHNl
bmQNCj5pdCBzZXBhcmF0ZWx5LiBUaGUgY29kZSBwYXRjaCBsaW5rIGlzIGFzIGJlbG93Og0KPj4g
aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGcGF0Yw0KPj4gaHdvcmsubGludXh0di5vcmclMkZwcm9qZWN0JTJGbGludXgtDQo+
bWVkaWElMkZwYXRjaCUyRmNkYWRiNGEyMzY5N2ZkYzk3ZA0KPj4NCj5lZjk1OGM2OWIxMmNkMDBm
NTQ3MjEyLjE2ODU0MzA4NDEuZ2l0Lm1pbmcucWlhbiU0MG54cC5jb20lMkYmZGF0YT0wDQo+NSU3
DQo+Pg0KPkMwMSU3Q21pbmcucWlhbiU0MG54cC5jb20lN0M4ZWE2ZGQ3YzkwNTY0ZjMzMWQ5MTA4
ZGJiZjMxM2VjYSU3Qw0KPjY4NmVhMWQNCj4+DQo+M2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM4MzEzOTkwNDQ1OTQ3MDEyJTdDVW5rbm8NCj53biU3Q1RXRg0KPj4NCj5wYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDDQo+STZNDQo+Pg0KPm4wJTNEJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT1IbDZGMVRoOEZ2
Zm9HdWw1bmhudnNmJTJGS3NYcXBqWkZocA0KPnIyeTNVM0MNCj4+IGhodyUzRCZyZXNlcnZlZD0w
DQo+Pg0KPj4gQnV0IGluIHRoZSBwYXRjaCwgdGhlIHByb3BlcnR5IG5hbWUgaXMgInNsb3QiLCBu
b3QgIm54cCxzbG90IiwgSSB3aWxsIG1ha2UNCj5hbm90aGVyIHBhdGNoIHRvIGZpeCB0aGUgcHJv
cGVydHkgbmFtZSBhZnRlciB0aGlzIHBhdGNoIGlzIHJldmlld2VkLg0KPg0KPkZvcm1hdCB5b3Vy
IGVtYWlscyBwcm9wZXJseS4gSXQncyBkaWZmaWN1bHQgdG8gcmVhZCBpdC4NCj4NCj5JIGFscmVh
ZHkgTkFLZWQgaXQsIEkgd2lsbCBiZSBOQUtpbmcgc3RpbGwuIERvbid0IGVtYmVkIE9TIHNwZWNp
ZmljIGludG8gdGhlDQo+YmluZGluZ3Mgbm9yIGludG8gdGhlIERUUy4NCj4NCj4NCj5CZXN0IHJl
Z2FyZHMsDQo+S3J6eXN6dG9mDQoNCkhpIEtyenlzenRvZiwNCiAgICBEbyB5b3UgbWVhbiB0aGUg
bGluayBpcyBpbmFwcHJvcHJpYXRlIG9yIHNvbWV0aGluZyBlbHNlPyBJIHdpbGwgYXZvaWQgbGlu
a3MgaW4gbXkgZW1haWxzIGluIHRoZSBmdXR1cmUuIEknbSBzb3JyeSB0byBib3RoZXIgeW91Lg0K
DQpCZXN0IHJlZ2FyZHMsDQpNaW5nIFFpYW4NCg0K
