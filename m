Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C520E7AD2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjIYIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIYIHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:07:50 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88BCA2;
        Mon, 25 Sep 2023 01:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6OSn5EGtIAIzvSQYswZOj+OyMJaawu4NcFMc/3TAcrANqpXrC07g5ff/GVpZ010hL4++drSn1+x8aRT7LHY7YSZ1ltlEKH/3sFa40V9NmiqO1IbuFqWYOrrbzy0YbZE6zocvJmlOqoILrTJepvL9rGtiP9w9ShwleXVtj/pVaGdV0rXn+cACdgXmE7HHs1Yj+oHFtgl4B2oaakvQFMPw/FSaSxQ39Oq247hNy9rVle71MlCZxShwESE8NzUbTUoNVU283nSVA8wOVmhJYVFRIwi24wvgYcUJCNhz/W/FetKwib9wcQBWx2gpztw+rYeo0b9Mhnhtbgej1n5WqETqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQwHjTBbjSN4GpJygiKvtp1Vq0Nv6cGAzIpC/l5GSO8=;
 b=Xd4CnYRUIU4UuW2IBXPULtKL9X7LECGzgYBLauw1oJ+HO6ZFr9FewkNk4YBygfQEL7SA+5NGmdQlrjLN0068QKqhwG67a4M6MJOWKV8NppOr9D+f2A9LZ9p9Z6QF1yPZQVDj4PCNyanCFy94MUWmz1aWk8Y/Nm54QGhvjmVcv0L3dDniWmEriBINHc3X+qKacX2QgqlNp3oU5fo+2IVdB3souS+k6d0HdvO/3Y+EDa9VsgeHC14aAjl/p24af2AyW7TBP6DpiMwGJd9vCQ8Z+gSK8s6jYHEVxE6X7LA2x8FkNApEHdbOjrnOrEnpvjJ40MqO4oXAhrj6QXc3CeJL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQwHjTBbjSN4GpJygiKvtp1Vq0Nv6cGAzIpC/l5GSO8=;
 b=Re9YVVzAJnajf/z+cfcGC5DyiC3BA7byDylieo851NlVL28NVLdcwbYs3AhPh3aa4KT1nqvynoA8FuQZNFs5AOZJJr/2gCgPI4+5arrSFTSlG03Qn/g4Dfm4vAtpBpUX3Q6bejPf+J/EHlu2qkLSQQwqY+GUz187T5UtWWy10MA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:07:41 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:07:41 +0000
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
Subject: RE: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ74PEbqAT2ziWZ0ufS4Z9Kh2CJrArLgAAgAAA7LA=
Date:   Mon, 25 Sep 2023 08:07:40 +0000
Message-ID: <AM6PR04MB63418AE18D3D0ED98CCC1A0FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230925074131.10133-1-ming.qian@nxp.com>
 <20230925074131.10133-2-ming.qian@nxp.com>
 <bbc8dd05-8589-44ec-87dd-f2d7b4368245@linaro.org>
In-Reply-To: <bbc8dd05-8589-44ec-87dd-f2d7b4368245@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AM7PR04MB6886:EE_
x-ms-office365-filtering-correlation-id: 91da95af-0edd-4b3a-89b6-08dbbd9e7d74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXqOEK9cn5iKDXm18X5XQYNl/tzMzG9IO3V/ivjtIxoOQN23k+zEmbJbl1S2VQ6nX71EoflyT6VWFP+bQFSDMlr/B4aaxTo2fqnDA/Dl97bjZI1E6xYn9qSby1k14JVs2Mf91pYGDUfVSy0bLDfbEAkFflEvnVBI+xTJGmjQEAb2hR/0jX7H1XzTUDurh1aONAIhH+t+4ogHOdyKNRD8vDBMllorm/foxz1bJ5UlsVD5mNrWjZuHdcJdgLn8wBvkhHLZekcxOtrwVjcrVgtOZCeqbjTdz3BRe3DGvM6NCQXWwV56dtSFrb59N/X4YGSrgS/shHsq40SShFhdRzEaHe5meSH1/1Jt2hnzHD9hxRqGVTHrmDD8vL7hzwebN9EMKnjjB9vVuRDK8a0/wrTREL7lSIH3o/EweX/XRqETwUWiBfuNSbIajnIosEehih2oq5GmpIo8okgXng6vlPwfrfc9LdwC6scZF37budnD6nosp6pEOOlNEZUZQ2QSZV0md69QRnCgwVACc/Xo+EbCII1uFxiAkfxNT4RLN+oqdbOwMys0qp1onsdBqu4QeqgX/pDjW88boo4mVG/kWZZfZ3SOoWpqGsFXt24ylEx5jDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(7416002)(54906003)(83380400001)(2906002)(55016003)(5660300002)(316002)(41300700001)(44832011)(52536014)(8676002)(8936002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(33656002)(86362001)(110136005)(45080400002)(9686003)(7696005)(6506007)(26005)(71200400001)(122000001)(38070700005)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SWdic2JyMkk2VEY5TWY0QmhVMGRMMEx5ZkYwZDNEa283NVMyKzltZnR4bXR3?=
 =?gb2312?B?STgzK3dHcVJFWWVqdnlLdlV2WE83YWR4QmJpRWp4cUlBTWNjZkxIOWJPVWpt?=
 =?gb2312?B?Q05Telp6V2p2VG11N1IzaFVYeDVMY3ZiUUhLNXJ5Z1FwR1g3ZDcwYVFZQkpU?=
 =?gb2312?B?ZnlaeUQ4VUJndEJTRTR2dHBjV3p1aXRJOVBScFd6ZUpQaTJJb3JYaC9Dam5I?=
 =?gb2312?B?Yko0ZTMrUUJLZzBTQzQ5YkZkckc0Y3ZTeWcxWVBxQnRPcStXRnhzSzBUSXk1?=
 =?gb2312?B?eVp0azRBeE0rN29OTkNNazBqZnVLSmg1bkMvMForOTFWOHZRTDNpVkhpdjFW?=
 =?gb2312?B?QjBwcDlqTXV1UzE0amhwRDFxMlJRL3g2SjArbXl1U0JhZ0ZkNXVkSWxBMTAy?=
 =?gb2312?B?ZmtLWlRRUitndXFJRGpUd3BwZEFzYUJtYVcvOVNDMjFESXUrV0hEU2NPUTJO?=
 =?gb2312?B?a0JNZDNya2pPRTZudHROQWJ3MXdCYXJSVmQ5L3dTSGo5a1l2elpzRGlXMDIz?=
 =?gb2312?B?MWkyZzBDUXlBbjM0UktYWXRsS1hvUzNnTUhZV3NZSjNDZEo4VXhBRDAvK24v?=
 =?gb2312?B?ZjNaWUdPSU14OWZzc1hxMmg0SmpJaE5BaGl6aXpqMjh3NVRCL0I4bVRCVTFs?=
 =?gb2312?B?ZUF2Yzk1aXluaXRpN3BmR1o5TmxRTXpOSlU2OU5tYStTUXI1N211c05CdHBD?=
 =?gb2312?B?T1lMeUtrZVJpNWw4VW5ONUc5WG12SFpJUGdLUHp4SXRENnBNSDIzVWwxK2lP?=
 =?gb2312?B?NkZ3NTJSdlpmSDlzRzZnRG04VWhLRjZwY3daRTRobkw2VGprU2hHdmNSd2E4?=
 =?gb2312?B?M1l3S0IyUjJKRVMwTXZONXZ2cDR3VjdtU29MTXcyS2g1Uk51Mi82WENyemtR?=
 =?gb2312?B?cVdveHRyZ1NEa3MzdkZ4cGlKTzYwTDRPV08zMmlFYTBnZENId0RVeCtVYnJR?=
 =?gb2312?B?RG9CSGJDUEU0YmxJekN4d3FaVzFSaCtZRmlXV01mSzZqbE9UUWdOdHhQQUJN?=
 =?gb2312?B?U1NGVEp4d1FzSm04K0dKWm1iK1Bkb0QzZGcrV2VxQjY0U3RKaWxHWVMrS21R?=
 =?gb2312?B?YnhEajdkZzhzcUhXemxvd3c3eldNaCt5amYrYVI2eEJSckcxTzZENG5EYUhD?=
 =?gb2312?B?NC9HTHIxdExjUFpUQ3I0d0MvY3htajZVNCsybkhCeEFBWm8xVm1PVFQrOHBo?=
 =?gb2312?B?SEsvdWRsRmpOOVI4TEx3dTFHWUI4NnlpbUlZWW1JdFhCWHZydWtmL09ZcFJr?=
 =?gb2312?B?WWpwNlAvV0xPMUphQkZHdC9PVkV2TzYzaVh2S1FodExiWjloT0R4NFhkUm9C?=
 =?gb2312?B?ajhYWHlCTVJJOXVFc2RDQ3RLZ1VHUVNDTkxWM29BU2h5VnFTaU9VR25NWHZJ?=
 =?gb2312?B?TzhycEZ0UmNyOVJDd25TcmgxWTVSRldsWEJGL1MwSlAvT21ZTURqNlBYMFV1?=
 =?gb2312?B?K1hsSVVvQlp4eEtaWmpTTEFNVmxKYVU5dEsxaHpnaDRmOHFKZVZxVUQ2UVlv?=
 =?gb2312?B?SjdaSVdDcUVLNGlKalFSVW5ocDU2S0tuRVdqNUI1ZHZhMjZtMWFkaUljR1hK?=
 =?gb2312?B?M1dNeHJjV1RvcHZtQk1OMW1LSlpuSm9wZWdDRlBLMTQ5Uks0WHRaMkw0Ly82?=
 =?gb2312?B?NDVXdjFGODJRZnlWV2FiajZoeElhaWo5amQ4emNwSEhIOWlTWVpIVCtFU0FM?=
 =?gb2312?B?cFM1Nnp4elZHRFVEWkZPSDNtTEdocEpoR2JMK2d2T3ZhTnNaTlQwNll0d1Vt?=
 =?gb2312?B?ZEFWUHlGWUJ2aWgzNEhzYTk2cUEzaHRjMGl2ZzRaYWU0eCtYTE1RclZTb1Ri?=
 =?gb2312?B?TTFZOGt2TStteTRxd1ptcGZZMXQ2RFRvSEZjYTNMdGRZSmN4ZXhDaFU5cURJ?=
 =?gb2312?B?dzdQOW9BWGFYandiZm1oeFBzR1p6RDhaZ01NUDlBaWgrSGdUOWpBM1lsUzJx?=
 =?gb2312?B?emsvdUUvSUJzcW9mZlJHaVYxSnZWQnRQRWpqWVBLbk1VVlFNRmptaFhLRDFE?=
 =?gb2312?B?dkdXd0pUVXRZVklSQWtteE9jNCttSTJRY0VFRHEzdTN0TmNLTlp3OXN3NU5Z?=
 =?gb2312?B?K3Y4WTIyZ0M1OGdEMTN2cXRpVVAzcXMwR2ZJcndzOUwzS2plVkFQRVFZMnZP?=
 =?gb2312?Q?878M=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91da95af-0edd-4b3a-89b6-08dbbd9e7d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 08:07:40.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGhRD7wFhOGk3xw01VdzZnzEjdBaY4Wp4K7SRP29yacxqoIEJascx+06UabEwEgjkPE0m28H0vqc5+NfukCUSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886
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
Zz4NCj5TZW50OiAyMDIzxOo51MIyNcjVIDE2OjAyDQo+VG86IE1pbmcgUWlhbiA8bWluZy5xaWFu
QG54cC5jb20+OyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPjxtaXJlbGEucmFidWxlYUBvc3Mubnhw
LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPkNjOiBrcnp5
c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+bWNo
ZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IFgu
SC4gQmFvDQo+PHhpYWhvbmcuYmFvQG54cC5jb20+OyBFYWdsZSBaaG91IDxlYWdsZS56aG91QG54
cC5jb20+OyBUYW8gSmlhbmcNCj48dGFvLmppYW5nXzJAbnhwLmNvbT47IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+Ow0KPmRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1t
ZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFtFWFRdIFJlOiBb
UEFUQ0ggdjMgMi8yXSBkdC1iaW5kaW5nczogbWVkaWE6IGlteC1qcGVnOiBBc3NpZ24gc2xvdCBm
b3INCj5pbXgganBlZyBlbmNvZGVyL2RlY29kZXINCj4NCj5DYXV0aW9uOiBUaGlzIGlzIGFuIGV4
dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj5v
cGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNp
bmcgdGhlICdSZXBvcnQNCj50aGlzIGVtYWlsJyBidXR0b24NCj4NCj4NCj5PbiAyNS8wOS8yMDIz
IDA5OjQxLCBNaW5nIFFpYW4gd3JvdGU6DQo+PiBUaGVyZSBhcmUgdG90YWwgNCBzbG90cyBhdmFp
bGFibGUgaW4gdGhlIElQLCBhbmQgd2Ugb25seSBuZWVkIHRvIHVzZQ0KPj4gb25lIHNsb3QgaW4g
b25lIG9zLCBhc3NpZ24gYSBzaW5nbGUgc2xvdCwgY29uZmlndXJlIGludGVycnVwdCBhbmQNCj4+
IHBvd2VyIGRvbWFpbiBvbmx5IGZvciAxIHNsb3QsIG5vdCBmb3IgdGhlIGFsbCA0IHNsb3RzLg0K
Pg0KPk5vIGNoYW5nZWxvZyBhbmQgSSBkbyBub3Qgc2VlIG11Y2ggb2YgaW1wcm92ZW1lbnRzLiBE
byBub3QgaWdub3JlIHRoZQ0KPmZlZWRiYWNrIGJ1dCByZXNwb25kIHRvIGl0IG9yIGZpeCB0aGUg
cGF0Y2guIFJlYWxseSwgd2hhdCBoYXBwZW5lZCBoZXJlPw0KPg0KDQpIaSBLcnp5c3p0b2YsDQog
ICBXaGF0IGRvIHlvdSBtZWFuIHdyYXAgY29tbWl0IG1lc3NhZ2U/IERvIHlvdSBtZWFuIGxpbmUg
d3JhcHBlZCBhdCA3NSBjb2x1bW5zPw0KDQogIC0gVGhlIGJvZHkgb2YgdGhlIGV4cGxhbmF0aW9u
LCBsaW5lIHdyYXBwZWQgYXQgNzUgY29sdW1ucywgd2hpY2ggd2lsbA0KICAgIGJlIGNvcGllZCB0
byB0aGUgcGVybWFuZW50IGNoYW5nZWxvZyB0byBkZXNjcmliZSB0aGlzIHBhdGNoLg0KDQoNCj5Q
bGVhc2Ugd3JhcCBjb21taXQgbWVzc2FnZSBhY2NvcmRpbmcgdG8gTGludXggY29kaW5nIHN0eWxl
IC8gc3VibWlzc2lvbg0KPnByb2Nlc3MgKG5laXRoZXIgdG9vIGVhcmx5IG5vciBvdmVyIHRoZSBs
aW1pdCk6DQo+aHR0cHM6Ly9lbGl4aXIuYi8NCj5vb3RsaW4uY29tJTJGbGludXglMkZ2Ni40LQ0K
PnJjMSUyRnNvdXJjZSUyRkRvY3VtZW50YXRpb24lMkZwcm9jZXNzJTJGc3VibWl0dGluZy0NCj5w
YXRjaGVzLnJzdCUyM0w1OTcmZGF0YT0wNSU3QzAxJTdDbWluZy5xaWFuJTQwbnhwLmNvbSU3Qzlh
NzhjYTI5Mg0KPmE1NzQ0NzkwZGIyMDhkYmJkOWRhOGUzJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUlN0MwJQ0KPjdDMCU3QzYzODMxMjI1NzA2MTc2OTgwMiU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpXSWpvaU1DNHcNCj5MakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJQ0KPjdDJTdDJnNkYXRhPWdEbk1pbTJu
ckxJUWZsbW1HdTZjYWh6MHByWlY5aUtzbGV2djIwOHUwNlUlM0QmcmVzZXINCj52ZWQ9MA0KPg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+PiAt
LS0NCj4+ICAuLi4vYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sICAgICAgICAgfCA0
MiArKysrKysrKy0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDI0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQNCj4+IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL254cCxpbXg4LWpwZWcueWFtbA0KPj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sDQo+
PiBpbmRleCAzZDlkMWRiMzcwNDAuLmRmMzgxYjIxMzM2ZCAxMDA2NDQNCj4+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlhbWwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1q
cGVnLnlhbWwNCj4+IEBAIC0zMiwyNSArMzIsMjkgQEAgcHJvcGVydGllczoNCj4+ICAgICAgbWF4
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
dGlvbnMvdWludDMyDQo+PiArICAgIGRlc2NyaXB0aW9uOiBJbnRlZ2VyIG51bWJlciBvZiBzbG90
IGluZGV4IHVzZWQuDQo+PiArICAgIG1pbmltdW06IDANCj4+ICsgICAgbWF4aW11bTogMw0KPg0K
Pk5vdGhpbmcgZXhwbGFpbnMgd2hhdCBpcyBhIHNsb3QgYW5kIG5vdGhpbmcgZXhwbGFpbnMgd2h5
IGRvIHlvdSBuZWVkIHRoaXMNCj5wcm9wZXJ0eS4NCj4NCj4+DQo+PiAgcmVxdWlyZWQ6DQo+PiAg
ICAtIGNvbXBhdGlibGUNCj4+ICAgIC0gcmVnDQo+PiAgICAtIGludGVycnVwdHMNCj4+ICAgIC0g
cG93ZXItZG9tYWlucw0KPj4gKyAgLSBueHAsc2xvdA0KPg0KPk5BSywgdGhhdCdzIGFuIEFCSSBi
cmVhay4NCj4NCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQoNCg==
