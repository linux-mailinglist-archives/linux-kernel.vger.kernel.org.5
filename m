Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC878B8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjH1Tu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjH1Tt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:49:57 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C8AD2;
        Mon, 28 Aug 2023 12:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ2VBMUs9FehNh8JRHdxAZxTOoGLwf1l3PkfCg6e5BTHDJ5i3wFrfzxglvle23LkxHdXyk+OVZ3aGXe4FajY1vZChjMvSV9iffKo9X43CkrtAn3d3jIn/RNw/81fzWiOevrIEcFfcxr1r+jMxU62Jql0x6fybI2NC+ZdBW8utB1LddpbKOypBXBgaXnW6/IzHuDcUcx7eEIe7Rh26xZp2k8qCSHbfp1+j3wWLALjZCCTC78up1LLiXhz9WG4BTlbQx9XonYF5jqssD+Zm5SLB1WD5DARnHiqpITECYFHyqxY8g58J1Iwk5HZc2yAB6141XPB8RHfdEq/shMlq7OOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gGLIyoqtPdsKANoywwAfhbE7p6/vqW5M/56nruevIw=;
 b=db+7w6kV5I37PeLgx9G3XNahQixJkDU1wmqN4uHUrRomEe2vCJJOwum6vkBaxuyP43kZ7XG83pRUmKHzoLQmNNEvutUspA/XIb1daBhP6sBkMSaDfGdv4tD4wADkGts7760MuNgoaKUQW9tpk5BaxLwQj69mehZ8UpK/tp5dIthIZqa+ZWhdjrlcnzPETm8VLOm2RyP/277+4afvBWK0o2A1FKvFlKU+oUmW01gyVqs/bhDgQtVpcau59JnKqLYQjWwEdywGl8OjOdhfWv1ebNnGCVG84dibKjHnpYgkWs1A5cUdWY1NdNMl+YlfzQJgw3OF2TXa01uTGmQDrhN7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gGLIyoqtPdsKANoywwAfhbE7p6/vqW5M/56nruevIw=;
 b=kl1KtuyU4He9QXrbVrHhfREOp4+AA5L86x9G/h6c9k6GSCt7NJhtAMp9lqHf6yQ1PBt7BIx2wkOHz+V3kUszStamkk7+InguaCOXvk2u/+AHNzLN99g8P49FRLNfTIJZO1uYCndOHdC/16lIHVYlWkAWTe0sHXxXA/eoysg/YKI=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB8930.eurprd04.prod.outlook.com (2603:10a6:20b:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 19:49:50 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 19:49:50 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ2ejObqX7KyqGd02iM5cb041tsQ==
Date:   Mon, 28 Aug 2023 19:49:49 +0000
Message-ID: <PAXPR04MB9185526385C775306A87D85989E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
 <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
 <PAXPR04MB91852AD4E5242306B57A910B89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <f3e89479-14ab-d1d0-ad87-6f457f313c39@linaro.org>
 <PAXPR04MB9185D87525AA88A8C3543EEA89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <465e61a0-895d-54b9-d1b9-424265c82855@linaro.org>
 <PAXPR04MB91851302EAB989EC8261AEFD89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <2bd01950-20e0-51f1-91d2-88c9ee2e8dc0@linaro.org>
In-Reply-To: <2bd01950-20e0-51f1-91d2-88c9ee2e8dc0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB8930:EE_
x-ms-office365-filtering-correlation-id: 7f555c98-f9b2-4e5d-86b1-08dba7fff0c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5nd41P5lheCQ8S9kwZa3mMAdXPaSSxEL1hnDDQFV3aOgpq3AQB0g6FwJnkwP2XT1UchM0rthraQ2E1FMRiiaLC2TzEv1jKWlGGkpWVlokequLIWVTDHNnEfakihnMYAG3ljhKH8XX8/8fagcqpXtW34xMQtlJT32iI0Iuhr/aAKNkU4NzfIPvtDiGzJ+oukAOwFuP5RhrvAt4PO1h8W2yfyOPefHic/ExoIf4Xl8BAbtyVAtaK16WnLZEM99oPasK6GlTHAVWpAE//rf3dEwJyx2p8Yrehz9XdlshgYRe6R2Bj3CFvb49TNfYEF+6ULQqvtsWgaNaf6ZY4T4a3Vx1RXfzzeppKkTB7OHfNLXUtva8i0Il+hAMaiMdQ4YFum7MFqOiZdk9bshlhjs5a+gHk+nf4atuPDejQuq5WRLPjnaZ+5FTGGoHC7HttRuRC70K1Ds9GoxcWt0UtgAJcbnViVZouoQSGGghxEIk6vm5ETVmkip8r+Q0HCflJZfZ9VAl+0Gdse5LJzswmrVysKT7qw2dQMBoTlLXfdJFJ5Lp+HpdF0ADidp4+VsmdhwQWQ0oVEGY73L8Hbg+JJ6x8xkAU9VcUauoK+9BnkwqfU5DTJ8Lf50WdyArJOq6IZDC4+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(1800799009)(186009)(451199024)(478600001)(83380400001)(122000001)(26005)(9686003)(7696005)(110136005)(53546011)(55236004)(6506007)(71200400001)(55016003)(86362001)(33656002)(44832011)(2906002)(52536014)(7416002)(316002)(38100700002)(66476007)(8676002)(4326008)(38070700005)(5660300002)(64756008)(66446008)(76116006)(41300700001)(66946007)(8936002)(54906003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzNTSmRpWHZiSjVYS1JVMERNK0JnVStCSFF6UkVZb1B3YTJMaExkWUt0Y0Qw?=
 =?utf-8?B?TUdyaUxubzQ4aEFFeVY1VmV1Z1p4bi93N3JlNEtqd202enArbGtQaGFURnBY?=
 =?utf-8?B?eGJNL29Jb3pkTS9hK3o4OUFyTi9rSmR1REg5ZXZpTkRYQ3ZaeEdjZEEybmk0?=
 =?utf-8?B?akk0Slk4VzBrRTdVcEZBQkhmTGxyWllLQ1o2azBKVnRZNCs1eCs1L2NrcHRH?=
 =?utf-8?B?d0pQS2lzanlWWk16bk8zVkN6dWpyM0hCZDJLc2dEZzBxS3BVY09LeG5KMXRZ?=
 =?utf-8?B?WGtGVlhqUEtxMlN0Y2pnUElGSUtQZzRzYk8wWW1hQklGKzdMWmswaDdVTlpV?=
 =?utf-8?B?b3FiQmhHdVJrZ0QvR2FTZEZ4QktXOU9DNkY2d29PV3QxOTFsZFlCVjNEYmt6?=
 =?utf-8?B?QUpyb2dHSjB1bGQ3RStpRmVaR0NwOTJualVySG0vNitObjlsZU5qd3dWUEw3?=
 =?utf-8?B?MXpheVJNMk84NytPK0F5Mlk3SVNRd1ROTllLRzR0dWRYb2Q5SmFrUWFsWTdF?=
 =?utf-8?B?VUU1TmxlOFlSaHJ6Q290VWZDajZLM1VRc2VsSVgyK2xuVjl1Uzd3Q1lBbFZr?=
 =?utf-8?B?cWdzV3dLOXVjenVtOWx2dkFpQ2hveGM1THo4TDJVSUhHQkdnSk5qV1p5R3NN?=
 =?utf-8?B?UjVmcHlQWllGYlFrWFlrNGFBZ2xsQjJEcW44bExibkM2N3Jrc0NEK2ZvUXdu?=
 =?utf-8?B?N2hCSXJuTmJZZ2UvQWEzQXJJdDM3YldESEFzdEhrT1Qyby9NWEF5U2dNdE00?=
 =?utf-8?B?UmV0NG5VMXBuY1ZiZEJTdXlxUGN0MWFrdVY5QTBrRExnbUsreXMvRklyL1l3?=
 =?utf-8?B?RVhhZHFtenVFdGpyK2xrREpSaDQ4Vnh0UFpzTVBlWGVPMnMyL1pEN0lZZFhG?=
 =?utf-8?B?QlFjSU1oOGprRVdHcUlWai9vN29uMjBFSGl1SG1abE1qZUlpQ01QcFp4bFpZ?=
 =?utf-8?B?akJVdWZ0NkZMZEZmbWJXMlFDUmRtSDE2SHhBeVJ0TG1RaEZtU21rRytqM1Ur?=
 =?utf-8?B?TFcrYVZJK2FmUjVPT1Q0U214OFNjeER1MmYza3Z5NTVuVHNiVkNMa0tTQ0Fz?=
 =?utf-8?B?Z2RxcTdZQ29KZElBUE52QUc4a09mTGk4UkE3d2h6YTN2TXY1Um9LZDFqU2NM?=
 =?utf-8?B?YkhST3o2SEVyUmNkZlZoZVM1djJtY2E5bng3WWNGeFNLQUVIN3BnenhneUJu?=
 =?utf-8?B?TGNLdTVFUm9EMzhJclhtd1pWblp4T3pzcFVSUEJTMzcyZHpoQlpBclIyeElL?=
 =?utf-8?B?OEtDSTlpQ2lkcnhYbTZQdDRaRDlLM3NSWTQxbUVWNmQ1OWJ6d3J2NlFkOTN2?=
 =?utf-8?B?UWR3NG5jc1dLY1J3aXhsTmpYS3NjdjRmMUJMQnZRTk80WlA5UHRTV25VVisx?=
 =?utf-8?B?R2hUK0dhWUM4cWpZbUtXL3VYRTRlbUltSlFibGQ0YWlHY1FrNitwZWNyNWZI?=
 =?utf-8?B?QlV4elUwKzIwU3NSY3NSM2dLOGJrK3dDS3JNUUlwZlJUeVV6b3JRSTE2dDhj?=
 =?utf-8?B?Y0wzVVVvMEdpRWN3cE9icnRaSldFb0RDQmp2SHN6eUlpdUZNRU9ralhjL2tO?=
 =?utf-8?B?WEM0YVZPWXRqc0dXTFpIYi9pMWFGVS9tOG5kR05DcXJuc3lLQ3J3ZDBiekdH?=
 =?utf-8?B?aDIzVytDTjVEdlZPVHh2TDYxWjFkOEdpT3dGUXVrKzM0ZGlOa3BzTzN4NTBH?=
 =?utf-8?B?WEJpbTl2UTl1WXF1YVZpMlpTRS9zRDQzSU1UQXZ4MFc5S0FpdGRiNEJPTEpC?=
 =?utf-8?B?OTM0R3Q0YVlCY2JLYi9PTTEyb1BZMFJsbCt4WG13Y295cmVTdnFaNUNaayti?=
 =?utf-8?B?N3JJQTl3dnI2MVMzdEtnbzZUTlRkK2FnUkljTm9IeFlqUzlUMVhHUVh5QStL?=
 =?utf-8?B?WGxOd3RRVTNFRXh3cThPOWt2aDM3T1FIUk1GWXhpYnM4dk10cEM2cTlIVmFk?=
 =?utf-8?B?S3ZjdjJHS01nR3FXWnlSRFVuVVdoMDJFaEdDZGV3dWMvTlJid2d1ZmZUNHNR?=
 =?utf-8?B?QUtXeSs4SmRnQnJFbDZCUzVOVk92dmlrS1ovUnZ3M2Q1V2Z3R2lBcjJQT3Zl?=
 =?utf-8?B?by9jOXlPV2dkUW1IcEdXK2hmYllaNmduaGtkTUt4OE9wWDUzTXlxRHd0TmNK?=
 =?utf-8?Q?f1fD92V3ab/WxF1AIROgTcmOx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f555c98-f9b2-4e5d-86b1-08dba7fff0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 19:49:50.0232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O85J8aw7vbi1eX1sXsu9P60isnvan8fArKtUz9wF5WBlEkK9BjKUPipolLuwFrIUJ4BMtntuPhIelvSRYPTYKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEF1
Z3VzdCAyOCwgMjAyMyAyOjMxIFBNDQo+IFRvOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0Bu
eHAuY29tPjsgVWxmIEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENjOiBS
b2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VYVF0g
UmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBwb3dlcjogQWRkIHJlZ3VsYXRvci1wZCB5YW1s
DQo+ID4gVGhlIGZpeGVkLXJlZ3VsYXRvciBpcyBhIHZpcnR1YWwgcmVndWxhdG9yIGRyaXZlciB0
aGF0IHVzZXMgdGhlIEdQSU8gcGluLg0KPiANCj4gV2UgZG8gbm90IHRhbGsgYWJvdXQgZHJpdmVy
cyBidXQgYmluZGluZ3MgYW5kIERUUy4gV2h5IGRvIHlvdSBicmluZyBhZ2Fpbg0KPiBkcml2ZXJz
LCBhbGwgdGhlIHRpbWU/DQo+IA0KPiA+IFlvdSBjbGFpbWVkIHRoaXMNCj4gPiBhcyBhIGhhcmR3
YXJlIGNoaXAuDQo+IA0KPiA/Pz8gU29ycnksIHRoaXMgaXMgZ2V0dGluZyBib3JpbmcuIFRoZSBE
VFMtc25pcHBldCBpcyBhIGhhcmR3YXJlIGNoaXAuDQo+IElmIGl0IGlzIG5vdCwgdGhlbiBkcm9w
IGl0IGZyb20geW91ciBEVFMuIEkgaW5zaXN0LiBTcnNseSwgdGhpcmQgdGltZSBJIGluc2lzdC4N
Cj4gDQo+IA0KPiA+DQo+ID4gVGhlIHJlZ3VsYXRvci1wZCBkcml2ZXIgYWxzbyB1c2VzIHRoZSBz
YW1lIEdQSU8gcGluLg0KPiANCj4gQWdhaW4sIHdoYXQgaXMgd2l0aCB0aGUgZHJpdmVycz8gQ2Fu
IHlvdSBzdG9wIGJyaW5naW5nIGl0IHRvIHRoZSBkaXNjdXNzaW9uPw0KPiANCg0KSSBoYXZlIHRv
IGFkbWl0IHlvdSBoYXZlIGEgcmVhbCB0YWxlbnQgZm9yIGRlYmF0ZS4NCg0KVGhhbmtzLA0KU2hl
bndlaQ0KDQoNCj4gPiBZb3Ugbm93IGNsYWltZWQgdGhpcyBhcyBhIHNvZnR3YXJlIGxheWVyLg0K
PiANCj4gPz8/DQo+IA0KPiA+DQo+ID4gV2hhdCdzIHlvdXIgc3RhbmRhcmQ/DQo+IA0KPiBJIGRv
bid0IHRoaW5rIHRoZXJlIGlzIGFueXRoaW5nIG1vcmUgdG8gc2F5LiBZb3UgY2xlYXJseSBkbyBu
b3QgdW5kZXJzdGFuZCB3aGF0IGlzDQo+IERUUywgc2NoZW1hdGljcyBhbmQgaG93IHRoZSBhY3R1
YWwgaGFyZHdhcmUgbG9va3MgbGlrZS4NCj4gDQo+IEkgYW0gbm90IGdvaW5nIHRvIHJlc3BvbmQg
bW9yZSB0byB0aGlzIHBhdGNoc2V0ICh3aGljaCBpcyBhIGNsZWFyIE5BSyBqdXN0IGluDQo+IGNh
c2UpLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
