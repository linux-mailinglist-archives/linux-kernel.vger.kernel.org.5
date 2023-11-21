Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EC87F259F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjKUGIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:08:33 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4A9F;
        Mon, 20 Nov 2023 22:08:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdfkiiixDYAYh7c6DggRZsUIqAnWVSXK8rVdCR7CpfRSKDgQzpcbz1IP67LLyChpQDjCV1LiaBwq9ZGv+8JbkRqnRV7/6r5653bbGzL2hDOvpBOZGLNGeacbssTIw1SmV3Cm7UviKjmf9SddLi6M5cFVaQwvPdt+Zs1V5BYRTx8IK4GFmsGVTCxVIJEcW74xhP7a6j4YUAjwgtXkoZrHTVVtbHikjfiIaAIhQVb1uMOa8JqaAtPcUFcGadHh9xoGX93mCoVf2OPX1H25+NKnvq52B5Y6i0iNwlldikSfC0BPMos14ilLhGNjl4JXXhIBN1lf7Dy1j6mnCYydpP/WGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI1iVIAAIAx5g4ur18Q3TviJnaQ5l+tBkzKb+8V+yWc=;
 b=oNzKy0JN1r/x79QoqPobNR6K67Yvb0EyKX7Z/wwzZ2LeXMUJSrWJRq+/sN/UsoMkwneqBSTo1bn4IQFYmaFIL0zieBqTJa5gtxeQwCShsvp9fxg3pj539bMDb58bMD5c378vDOSghxwSe7GpQb9mb78WvM7TStAqghxZ5lBU3EEtlUn5doHx5kEtiHrufRnwX6MFW89P2eYOLTmYxnIS+x/wOyD1bzzE1orzUoe9KYd0Hf77WxkvX3YQvF2dgqj8ZmG/hydkMUH1ogJPU5tSygIkm5uwTPN8jUgePzwTNcAWu0gAEU4y5NliB6ZLxWfzpzDPypK4IKVqvGxi5W9sBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI1iVIAAIAx5g4ur18Q3TviJnaQ5l+tBkzKb+8V+yWc=;
 b=qc74lNZjK32+RGO1RElnFCwfu+4jxq9K7GxGoJcPDM0s5vaJYMdvqWo0uIPwHRiTtKs6dfl9a59bCm5Ai8DHz8lxQJ2ZDBOZZf2gLUDukb79v1V8tDuQtICk6ZiHevXR7gdG8irSvRgAfe+tSsFZcC/Y/lQI59/1dc3n9W+vKTo=
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 06:08:25 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 06:08:25 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: Re: [RESEND v2 3/3] ASoC: dt-bindings: fsl,mqs: Convert format to
 json-schema
Thread-Topic: Re: [RESEND v2 3/3] ASoC: dt-bindings: fsl,mqs: Convert format
 to json-schema
Thread-Index: AQHaHEEjio/GDyW+FE6fMt7o6TsBuA==
Date:   Tue, 21 Nov 2023 06:08:25 +0000
Message-ID: <DB9PR04MB9498926086E27ECBA09CB142E3BBA@DB9PR04MB9498.eurprd04.prod.outlook.com>
References: <20231120084905.664-1-chancel.liu@nxp.com>
 <20231120084905.664-4-chancel.liu@nxp.com>
 <2fec766b-dd75-4b96-8114-394ff16c63a7@linaro.org>
In-Reply-To: <2fec766b-dd75-4b96-8114-394ff16c63a7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9498:EE_|DB9PR04MB8218:EE_
x-ms-office365-filtering-correlation-id: c5bb5dd9-fe4d-4c72-473e-08dbea5845c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lLOYtT47vksrO3r6BR9NBS3lYGPgiUTSqO5XHeCKPz4Hc8LHb5/6ybFARu4cw/JK2sWlKO1RxG7rAVgoDP8gbVzhw8jRkPWs1QjRN0eLFwYLyOZf+mCROjh6y26MpkobdkJeGP58GYzsF9oUODo49glNGKIuSb6RLFKjOyxU2pGhuT594pWXeQHQCBl4+uditc1am2rDwrvNDEAdySbl0GPQMRusGoAcwVgnK4LY5KG61RNTKk5b8HVFeAgjnCwSYBRZDrpFCiu4gOIO/PS0z25rILpHN3Mfn1zTOB52ycTRtM00cmlAE0/xzpG8hn/5jb59QaVxtowtPVhBYw6ok9GYhd5ID3ZYg3A/64VQ3kx3qs7jkVUe+eY6BUADYznhUSkjHY7aFFwZ8Tnfkf4452qN670drs6rtgeyYQwQGQCTZnWc2rYgRZAEXcS9Lbwj4z/tqw0HXMu1CwLNpRVFKV/VOlupCxnYNSahTae2z+Wl8g7DVn7+ZzbFT+P1kd5kReT62QF8HR44MUw3h7GOGC3v+gvisIixGU6J15ZtuC4N3Yci0Yixb+RyjYwMABsnMHTdyrg6jIaZhLRZ9UrzgGOGIve2vXvQKeOQoeGVFXdOUfbjUJC+Z8adigoYXTDXBBot6QTpNkogyNC3OFT7Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(44832011)(2906002)(55016003)(8936002)(52536014)(41300700001)(8676002)(7416002)(5660300002)(316002)(64756008)(66556008)(66946007)(66476007)(66446008)(76116006)(110136005)(86362001)(478600001)(26005)(38070700009)(71200400001)(9686003)(7696005)(6506007)(122000001)(83380400001)(33656002)(38100700002)(921008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T21GU1JDQ1pMV1Bqdm52eHZJSTdBMWpnOGRHblpLb2RsclBham1ncjNTQ253?=
 =?utf-8?B?a3NIRk1rT3BxTGFEMjVLbDZKb3hENUpiS2kzZzQ1ZGJ4elhMakQ5R3NPNzcv?=
 =?utf-8?B?ZlFSdGU3Q011SG1QRzJJQ1VieXcwbm9ZK0FkVWlqQ1orZlF3YjRONk5QR0h1?=
 =?utf-8?B?U2U1enExa3ZzT0RUSTNSZ0RqbnR2T21nOTRHLzZpa3FqenFnK0Y5SHhSNDdN?=
 =?utf-8?B?ZDBHb3JPSnFXU0tNR1FtVXQ4enJGY2NnbW55bFJ6QVpWWFY2SWxtRXljVlRu?=
 =?utf-8?B?T2ZzT1NtR1k2Qll0SmhlOVFoendVWkNBTVNxLzh4WVFuYXFRcC9zM1pvUFd5?=
 =?utf-8?B?MVpsWm1sVEdFa3piZHFuUXh3ekt3QW9XR0lFRzFTWXVtYTJOZ1NSc2FnT3ZC?=
 =?utf-8?B?VzVIbytmaGZmSThhVjZPY1ZlTUJLaXU1WlE5dW40QmY5T05RRGdVUkxIYklX?=
 =?utf-8?B?c2F4aWM2UEdWcFU2RWxqWStEdTVrSmd5MGdFR0R0TGZuaDZIdGxudDQra05J?=
 =?utf-8?B?VTFaNVFobkNobmlicE55cytHZU9uVWJPTW41dnU5MFlqUXhRczVKNXZJcVJG?=
 =?utf-8?B?RTVzVzFoV1JpellERk5lRkVlQlZuMFRjNUh0c3JxbmRCSEZaQnVWOGp5SkFi?=
 =?utf-8?B?TUlnbWllRVhxalIreEdxS0lSVFJSdGh0aTFKRWVEZk03NGtXSWY0dE9Nak5K?=
 =?utf-8?B?anptUEplM2dvS3N4N0Fkb2JCbXhHd2REenVDMVhPUWp5UEtRWFgweVpMMlNN?=
 =?utf-8?B?T0JZdkZIbkhQSlNSd1ozRlFPc3BrUkE5dnBnWWRrSmc3WnNlMmRkcXhtUVB5?=
 =?utf-8?B?bDFvQlo5OWZZR3JiWkE3Nm0vM0lxbGNzUmhqcTcvTEI4OThYdFl5VDJPYkk1?=
 =?utf-8?B?VmMwNWFuRlFsV0pBTG1MVDlIeGhOZitBN1JOTVVKNjZwbDg5TjFwSnVLMXVm?=
 =?utf-8?B?WU9DaGQ3L01sL2VkODZsdGhzTG5idm1kOTlDa3hDVVFsMTJJWUZ6bW5lNHRQ?=
 =?utf-8?B?bVpzSlRYS1BtODdpTDQybC9BWU82UmxBK2JtTksxSUl1S0JpZ3Q3V0xHWW9U?=
 =?utf-8?B?c25iZmY3SWpjWlNKMWxiOXpUS2drYXhDWU5XM2FrSTBNTXFnY0lPT0c0eUpC?=
 =?utf-8?B?L3NKdDYzSHNGazRIa2RGbGE2STZLVnR6b3Arbng0bFNIWldwZ01BZTI2WkFv?=
 =?utf-8?B?OUNzNnVGY3M1Z2pJbExMRGgwNGlLK2JMR2N4NlBIWGNTTmhDeW1KY1AxQmhx?=
 =?utf-8?B?QXEvMnU3ZGtsdmRGVVRpd2J1WHhiRnF3VE1IZk55UmZ3QUNHdS8zWnVvSU9V?=
 =?utf-8?B?K3NhdEpnYVhERHFCVU5yaHFoUXBma2ZJWUw1QzNNek42WEdkV2V1VUdKOUVj?=
 =?utf-8?B?VXZleVVia2o1ZzUvbUZIOSswUmV5VWVZRkdRckh6MjdqcFI3NXROdGZPT2Nz?=
 =?utf-8?B?aExLTDBBMEt6VzVMbE5ETU5YTnBzWW9QVkhqY0UzeXJuTjNZMHRQeUIxQllh?=
 =?utf-8?B?NDQyRFlnaHRtWGsxUExPUHh3aEpOTWdZamJHdHNXRGNIdk1nZGp1VjNUcjg2?=
 =?utf-8?B?VWtweHdxYXdXT1FmT0tkTTJ1YzhYVlplUzdleWpqQ0oxbHl1LysyZXpaRFU1?=
 =?utf-8?B?WlVkSmo3TWQzS2Z5MDB0bmlEOUZzK1BTTkVFd2x2R0wvMXJtQ2FrNThPd2Zw?=
 =?utf-8?B?NjgrTzJ3TlJRbDF2UFEzVFdYNy9BZ2MrOWFQc3EzUWsvM2RPZ2N6N095NGtD?=
 =?utf-8?B?VHpzRHljR042R1g1TEFCNVlxcXVlbXluaVVpOGRmeER0cFpaQlpjVlNDMFJ5?=
 =?utf-8?B?RDQ0VnA5azh4MWdvVmJUdXlBNzNoVFBYMkRBSURnMCtLdVJ4OUI3OHJwaUlk?=
 =?utf-8?B?NEliZWJUMER0NFZ4UERrWC82OXRpeVAxQjN6RU1ObUtjZ0JzNUpMa0RVcTFX?=
 =?utf-8?B?L2xNS3puZGZESFp4QWxSWTBJMHFIbkxCd2RyU2oyTnpOVzh5MXpSNnVzdzRw?=
 =?utf-8?B?dDBNWVJGNXdlb0ZlSjJQZUJ1U3NUSVdvTy9DNTZnSmZBMmxuWVZjQ2l5SlV0?=
 =?utf-8?B?cngxUm5zUnhkeXlzSkRCdEQwTjhiUG5pZGk4NWJtcTFHTi9STEVmcGdiWXc2?=
 =?utf-8?Q?XwSQigNsP3BdEbWeYHuXT0DTM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bb5dd9-fe4d-4c72-473e-08dbea5845c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 06:08:25.1373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wM2i8cQb79gGPullPCi02LpN7nxaCGN4kdKNLS/42eZfSYOx+TM2T9ewlmjRvf+gXGdXUrsOnPyRUPpAgB1HcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICthbGxPZjoNCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsg
ICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAg
ICAgICAgY29uc3Q6IGZzbCxpbXg4cW0tbXFzDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBw
cm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNsb2NrczoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0K
PiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBNYXN0ZXIgY2xvY2sNCj4gPiArICAgICAg
ICAgICAgLSBkZXNjcmlwdGlvbjogQ2xvY2sgZm9yIHJlZ2lzdGVyIGFjY2Vzcw0KPiA+ICsgICAg
ICAgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAg
IC0gY29uc3Q6IG1jbGsNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogY29yZQ0KPiA+ICsgICAg
ICByZXF1aXJlZDoNCj4gPiArICAgICAgICAtIHJlZw0KPiA+ICsgICAgICAgIC0gcG93ZXItZG9t
YWlucw0KPiA+ICsgICAgZWxzZToNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAg
ICBjbG9ja3M6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBkZXNj
cmlwdGlvbjogTWFzdGVyIGNsb2NrDQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXM6DQo+ID4gKyAg
ICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogbWNsaw0KPiA+ICsNCj4g
PiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGli
bGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAgZW51bToNCj4g
PiArICAgICAgICAgICAgICAtIGZzbCxpbXg2c3gtbXFzDQo+ID4gKyAgICAgICAgICAgICAgLSBm
c2wsaW14OTMtbXFzDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICByZXF1aXJlZDoNCj4gPiAr
ICAgICAgICAtIGdwcg0KPiANCj4gVGhpcyBpcyBhIGJpdCBjb25mdXNpbmcuIE9ubHkgImZzbCxp
bXg4cW0tbXFzIiByZXF1aXJlcyAodXNlcz8pIHJlZy4NCj4gaW14NnN4IGFuZCBpbXg5MyB1c2Ug
Z3ByLiBUaGVuIHdoYXQgZG8gdGhlIG90aGVyIHZhcmlhbnRzIHVzZT8NCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQoNClRoYW5rcyB0byB5b3VyIHBvaW50aW5nIG91dC4gSSBjaGVj
a2VkIHRoZSBoaXN0b3J5IGFuZCBmb3VuZCB0aGUgbGVnYWN5IA0KImZzbCxjb2RlYy1tcXMiIGlz
IG5vdCB1c2VkIGFueW1vcmUuIEkgd2lsbCBkcm9wIGl0IGFuZCBhbHNvICJmc2wsaW14OHF4cC1t
cXMiDQppcyBjb21wbGV0ZWQgd2hpY2ggdXNlcyByZWcuDQoNClJlZ2FyZHMsIA0KQ2hhbmNlbCBM
aXUNCg==
