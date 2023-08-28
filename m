Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5298478B7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjH1TKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjH1TJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:09:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B89110;
        Mon, 28 Aug 2023 12:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiiFWcQj3rXLIEqvtgrVeQYfFC7Rree9L5ptNvffAY1X5wpbmLt8vEVRnjOWinRJYc/6ZkphzgOvKn+M5SyZRmZA3dlsV7Ex6xO6TmSwAKx7ID80N7enhLqGemg24xeJIfkjfG4QwaLZFSfNYzAI+/Q0r7bF2VS1piZtApjwBmGM6Vu2oCyyiNOP6hv6tD4hpmonSss/6lG3dXYZ35yQOua0sI7rpwnrIB9EeoBp05FEjjP0pBwTASpljCl1VCY+V/4taWYm4k3hYnl0/m7aUSxQVMwmeiVfBA0bgtA1BE4tdIAAEB+ftQArQFv5QaGha8pIRJ1UiBfg31HqCzeZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9fK4ct5WsLzoGbJAI7PL7odmUZAOAJK8hgPyEeYdw8=;
 b=SiSZCtyyJWf6gYiQXlzE0g2a3T0L/adFC5tnfl78jKMjm4WAPoSk/8tpw3MQ+9bEWDIugxtdixgIFcMDzmOpSR5UXR1/kUI9ClFcIOF445Kv/md1x5jm0Q7VqhNJ+XWNQ/IVuaWIlU54QzaakgNEKmx56r0HWRFcRHdIgh1OJOIsbCMRGd0KmYatXa7xZF/1XuVx5RfsVyk2F2SaFi+548AT7cUcNj9q+y3Qn4lKKl44KC4Pgij0aioaUzOSW9W9QmAXjC9zLCzPzlAW3bfA/qZ+gHMTedix0siSopG7HpYhfmUqjCRlF9eRLYqkvm1zhj9mP+ijNyfWznqOm/zLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9fK4ct5WsLzoGbJAI7PL7odmUZAOAJK8hgPyEeYdw8=;
 b=GBsZPMd4n/iltapjT3g+xeBTrk3YzxPnoa5wiOCrAMQyDyOQ4Rwu07/mxTA7OMtWyzV/iIULiexhSVcXfNW6zF1WtLlkKtAIWPJmVGgsYSmkFJoIEvTi4B0Sb6tUKKxHuhFu1RXKYvBLAfjdG+Gnj6O8yJTy2SuI4BdZ0hIchaQ=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAWPR04MB10006.eurprd04.prod.outlook.com (2603:10a6:102:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 19:09:37 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 19:09:36 +0000
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
Thread-Index: AQHZ2eMvcFa+iifit0Wlgxkc5z6VlA==
Date:   Mon, 28 Aug 2023 19:09:36 +0000
Message-ID: <PAXPR04MB9185D87525AA88A8C3543EEA89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
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
In-Reply-To: <f3e89479-14ab-d1d0-ad87-6f457f313c39@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAWPR04MB10006:EE_
x-ms-office365-filtering-correlation-id: 4d21eb5f-d99c-4d61-f8aa-08dba7fa524d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSXPh0JzrY78uGuApECvcFmsc42hHBo3aGiWDTAf4SAJXg2rOPMgA1n2faxcW6sRVHXnE+16/QAVlgIZFezRBSDnX3I0Qd+trb2FlZaV9pPry0XKy2AHCg2hCaRz/njYFbr+UxkSjFO+zhcD+G3VvyqEl6Wzl6X8y8SyGZ4s0fxf5rKfjLCbxFDMKtLzQYrYy9sf8f2TxfAdV98BzBy3++4u4AfEhjGKEC0JsfCjPQKZlSS5MuOwXEyoxuhdHUD79cv8MyKFwp/kTKtmYxyDZ34mrHMFCF+6OPF5Rx9A6pmg+MKHz5bhd09gG+4Z0N9Lznoh5C+ZBuQRP1wbVrpJ6VkDowXByL6Lh76i97AFIfugCZ4FA8ftA8nkQLiUDgkhTfMrgcnypDYR9QKTcTR+oWszicj2OdhEF8PJdZFq0ft+Ag9OLKiNL2SRjgi4aBQtaf0WRSSwQh9aHA2ognbIhqnMuVpOdkfGY6+y/bdfhBwRlNCE/onPiaxDSnRRFrGwlwF/UAYce5rfjL0A7l6VZuwLm0/e4JxoflG0cAHNsPM5qvAoS1pnXp8Ex4a0HCMwcjqQH2rmHy61YZcz/RcYYFSggpR1R87VIBDMg90JNy0MQ9zuj6N6fL/E5xWm8aaF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(1800799009)(186009)(451199024)(6506007)(7696005)(71200400001)(9686003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(55016003)(83380400001)(2906002)(26005)(53546011)(55236004)(478600001)(76116006)(110136005)(52536014)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(5660300002)(44832011)(41300700001)(7416002)(66446008)(54906003)(316002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVlPVUpocGZZY0pCczM5ZHVLZThnOCtnMUluVlJzMDRRZklLN2drRDBnSDVz?=
 =?utf-8?B?dXFLNFhIMGlyQmsxSUFWdFJMOXMxWk9ab2pwVkRTeEcxZTkrRVpIUTV2STVq?=
 =?utf-8?B?aC8wTXpaZXZVemJqZHB4UTZJYTVRVE1FbFBDYWhFdWd1cWJNWHU5N0FaVWpz?=
 =?utf-8?B?M1Fkbi84Z3BFRWcxcERiUCtjTWtVRmJkc09JWW5UNHRPUWkvT241d1FFZTNJ?=
 =?utf-8?B?V1FVL3NzcGNWQ2U5bC83dlFUVGY1K1ZjdW9RbVhYQnRkeXhRTTVUb0xuajRY?=
 =?utf-8?B?VWMvMUl1ZWhNOHVJOGR1OG1oZVNRMUhDQkRoT3NUeXVxNjVWM2NOeHhVdU80?=
 =?utf-8?B?VGJ1ZFZka1NTTDFndlp2MkUzK3BmSjc4enZkTHNmU0V1ZTJZWDlZZ01sMURu?=
 =?utf-8?B?MTJkSjEyMW5GdWpQeWUxazZYS3BQY3ZYcGRZOFdwc00yV25VcWJyM2YxMFBJ?=
 =?utf-8?B?aGlxSmZrQzRhTmlWTEdzRlRTQVNEVThnTnY4RFJqR1ZlU0FlV3lBaFh3QUpG?=
 =?utf-8?B?MXg2Um9vcHhJTWY4T2FsZ1I3QVYxNWFKT2prNGF6K0ZJbW1Nd2wxT3hsbmY1?=
 =?utf-8?B?dGZXM2EvdGlUR2xWeW1oSitJeEVTY083SmFSRm0ycTRkQWtHYi8wMFdudldu?=
 =?utf-8?B?OEs0QUlSMzVYM2d1SzVDcEh6dzdDa2pBbXB1LzRaRUZKbWJlMnVwczRkR1A3?=
 =?utf-8?B?WXpnZ21LZXVmMUpCN3BlTUlzWGYxYks1VDJJUTZkZ3VOdE5pRHEzVVNJSmR4?=
 =?utf-8?B?WUN4Qm9OQXdGdUJjdXBqSHlTYVJzNnJtTjRtVFg2Z0o4OUZPTnNhOXdSZjV6?=
 =?utf-8?B?RXZ2U08rSlIvSFBONHRIZjZEc3JjTGgySmMvOTBlOHhUblhsZ3lGenNQZVpr?=
 =?utf-8?B?dnhqZFpySUxPUTdaMFFFekJJSUdTT2VJYVl0cUkzR0pYNzd2cWZueS9DekZW?=
 =?utf-8?B?SW83S0Z4aXBWZDZhVE16eDhEVm56Z0NrZmZIVzlwUnZabjlrYVVjZDlBUFo4?=
 =?utf-8?B?c3l4cWxDbEliUkhnZk9vcHhVS0Jlb1plaFNrTmFrajh0dWExZlUzYUV2dDdI?=
 =?utf-8?B?K2RqOW5wMFJTWUZzb1NrNnFTbFFEaVVWQ2RJeE9ZL2ZubDJhSHRuL3pyTk1Q?=
 =?utf-8?B?RDlXcXJjcDBxK0Q3WUZYS3J1SzNlNjNuU09waVozOGtuRlRhV3IzbXV1bWs0?=
 =?utf-8?B?YjN1RWpVK1NBUmp1bXBCOUdBWW1JKzVzd0xDa0F4RXk0eVczaXQrNnpFcWhy?=
 =?utf-8?B?S1ZoOEM1V0xVY3BwUEFjY2xSVGlxTlExQU5ZYlcyM3Q2VFNiYTY4Si9ud2NV?=
 =?utf-8?B?L3BaMzBHUEhqV290ZjBzSThrNzNvd3Zzc1lNaGdVUElIdENYYWd5cGhxbHRx?=
 =?utf-8?B?MzZzaUtDWWVzSjJ5SmhLT3FCTmJGUjh2NnFxQkFXcGRRd2ZDY2xURHpTbkls?=
 =?utf-8?B?MEVsdW5kSlQxcmVrMlNqbS94cEhrUkxYVkoxMXF2WFNqR2NxWTZKN2QwR1NO?=
 =?utf-8?B?dU1GcXhyOVhNMnlURFJkV2Q5MTkwRDRrZi9GVzZyQWl2WjdQSGVHUCtXdzM0?=
 =?utf-8?B?YWd5SlM1TE5CRUovcGhwV2lPS0RzRDMrOEJ5Q2VYWkVBUGVVeWI2dHI2MGtN?=
 =?utf-8?B?enhVUUt1M1BuM3lRbWhDTE1kOFhZelhmbEhna1A5dHJ2ckpzR2NzUUN6aWhy?=
 =?utf-8?B?MUJUVURkbEI2TVR1S1AwUWltc3hPUlRJUHFBaDcyMjZ1c2pPZ3hXMTJ0TDRU?=
 =?utf-8?B?bXVqZktQZ3hxWDBaTXlibGpLWW9EdUswWjRzODFrUEcvbmdwaHRtT2phOTNq?=
 =?utf-8?B?akZ3OUtzbmpLTllnb0NVeUEvSlVnREZFaStjalJibW1VSXhWSStmUlBkcHNj?=
 =?utf-8?B?VTZPbzhlaS9EaVJsQ1pjcmJ4U2xkbVVMTEFOTEtVdU5WY1VMRUUrTUdEWFUv?=
 =?utf-8?B?RitDTlR3RGJQa1AwZngzSlh3YzZKd0tMS2o0cXcxK0hzZExpWlpNMHlaQzdE?=
 =?utf-8?B?T0c3TFdmK091WXN3RFJvYkMyRGpFMzFHY3EwQVRPenErUGtlcVpqNWFlRlQr?=
 =?utf-8?B?cUZFZXhWK0grVUdVUkJKellrQnF3dzZpc0FycENYL2llbGZGeHVsblRqUEVH?=
 =?utf-8?Q?cc+J8JWMX+yGgmhKiGh74l2Ik?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d21eb5f-d99c-4d61-f8aa-08dba7fa524d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 19:09:36.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Icc0/GrWc8BrVL86SVUoeUmrRsLK5o5XgWKQTZzXvi5cwpYOpmU3og1f+UK/yV7De2DOGbe66cDNpLncuZkUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10006
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
Z3VzdCAyOCwgMjAyMyAxOjUzIFBNDQo+IFRvOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0Bu
eHAuY29tPjsgVWxmIEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENjOiBS
b2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcmVndWxhdG9yLXBkIHlhbWwgZmls
ZQ0KPiA+Pj4+Pj4+IEFyZSB5b3Ugc3VnZ2VzdGluZyB0byBtb3ZlIHRoZSByZWd1bGF0b3ItcGQg
dG8gdGhlIGlteCBkaXJlY3RvcnkNCj4gPj4+Pj4+PiBhbmQgYWRkIGEgY29tcGFueSBwcmVmaXgg
dG8gdGhlIGNvbXBhdGlibGUgc3RyaW5nPw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZXJlIGlzIG5v
IHN1Y2ggcGFydCBvZiBpTVggcHJvY2Vzc29yIGFzIHN1Y2gNCj4gPj4+Pj4+IHJlZ3VsYXRvci1w
b3dlci1kb21haW4sIHNvIEkgZG9uJ3QgcmVjb21tZW5kIHRoYXQgYXBwcm9hY2guIERUUw0KPiA+
Pj4+Pj4gbm9kZXMgcmVwcmVzZW50IGhhcmR3YXJlLCBub3QgeW91ciBTVyBsYXllcnMuDQo+ID4+
Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGF0J3Mgbm90IGFsd2F5cyB0aGUgY2FzZSwgYXMgd2Ug
ZG8gc29tZXRpbWVzIG5lZWQgYSB2aXJ0dWFsIGRldmljZS4NCj4gPj4+Pj4gQXMgYW4gZXhhbXBs
ZSwgdGhlICJyZWd1bGF0b3ItZml4ZWQiIGFjdHMgYXMgYSBzb2Z0d2FyZQ0KPiA+Pj4+PiBhYnN0
cmFjdGlvbiBsYXllciB0byBjcmVhdGUgdmlydHVhbCByZWd1bGF0b3IgZGV2aWNlcyBieQ0KPiA+
Pj4+PiBpbnRlcmZhY2luZyB3aXRoIHRoZSB1bmRlcmx5aW5nDQo+ID4+Pj4gR1BJTyBkcml2ZXJz
Lg0KPiA+Pj4+DQo+ID4+Pj4gTm90IHRydWUuIFRoaXMgaXMgYSByZWFsIHJlZ3VsYXRvciBkZXZp
Y2UuIFJlYWwgaGFyZHdhcmUgb24gdGhlIGJvYXJkLg0KPiA+Pj4+IFlvdSBjYW4gZXZlbiBzZWUg
YW5kIHRvdWNoIGl0Lg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gVGhlIHBoeXNpY2FsIGhhcmR3YXJl
IGNvbXBvbmVudCBpcyB0aGUgR1BJTyBwaW4sIHdoaWNoIGlzIHdoYXQgeW91DQo+ID4+PiBjYW4g
b25seQ0KPiA+PiB0b3VjaC4NCj4gPj4NCj4gPj4gTm8uIFRoZSByZWd1bGF0b3IgaXMgdGhlIGNo
aXAuDQo+ID4+DQo+ID4NCj4gPiBJbiB0aGUgZGVmaW5pdGlvbiBvZiBkdHMgbm9kZSBiZWxvdywg
d2hlcmUgaXMgdGhlIGNoaXA/IFRoZSByZWFsIGhhcmR3YXJlIGlzIGp1c3QNCj4gYSBHUElPIFBp
bi4NCj4gPiAgICAgcmVnMTogcmVndWxhdG9yLTEgew0KPiA+ICAgICAgIGNvbXBhdGlibGUgPSAi
cmVndWxhdG9yLWZpeGVkIjsNCj4gPiAgICAgICByZWd1bGF0b3ItbmFtZSA9ICJSRUcxIjsNCj4g
PiAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMDAwMDAwPjsNCj4gPiAgICAgICBy
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMDAwMDAwPjsNCj4gPiAgICAgICBncGlvID0gPCZs
c2lvX2dwaW80IDE5IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICAgICAgIGVuYWJsZS1hY3RpdmUt
aGlnaDsNCj4gPiAgICAgfTsNCj4gDQo+IFRoZXJlIGlzIGEgY2hpcC4gVGhpcyBpcyB0aGUgY2hp
cC4gSWYgeW91IGhhdmUgdGhlcmUgb25seSBHUElPIHBpbiwgdGhlbiB5b3VyIERUUyBpcw0KPiBq
dXN0IHdyb25nLiBEcm9wIGl0LiBJZiB5b3UgbGVhcm4gZnJvbSB3cm9uZyBEVFMsIHRoZW4gc3Vy
ZSwgcG93ZXItZG9tYWluLQ0KPiByZWd1bGF0b3Igc2VlbXMgbGlrZSBncmVhdCBpZGVhLi4uDQo+
IA0KDQpXaGVuIHlvdSB0YWxrIGFib3V0IHRoZSBjaGlwLCBjYW4geW91IHBsZWFzZSBiZSBtb3Jl
IHNwZWNpZmljPw0KDQpSZWdhcmRpbmcgdGhlIGR0cyBub2RlLCBob3cgYWJvdXQgdGhlIGV4YW1w
bGUgaW4gdGhlIGZpeGVkLXJlZ3VsYXRvci55YW1sIHVuZGVyIHRoZSBiaW5kaW5ncyBkaXJlY3Rv
cnkuDQoNCiAgICByZWdfMXY4OiByZWd1bGF0b3ItMXY4IHsNCiAgICAgIGNvbXBhdGlibGUgPSAi
cmVndWxhdG9yLWZpeGVkIjsNCiAgICAgIHJlZ3VsYXRvci1uYW1lID0gIjF2OCI7DQogICAgICBy
ZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCiAgICAgIHJlZ3VsYXRvci1tYXgt
bWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KICAgICAgZ3BpbyA9IDwmZ3BpbzEgMTYgMD47DQogICAg
ICBzdGFydHVwLWRlbGF5LXVzID0gPDcwMDAwPjsNCiAgICAgIGVuYWJsZS1hY3RpdmUtaGlnaDsN
CiAgICAgIHJlZ3VsYXRvci1ib290LW9uOw0KICAgICAgZ3Bpby1vcGVuLWRyYWluOw0KICAgICAg
dmluLXN1cHBseSA9IDwmcGFyZW50X3JlZz47DQogICAgfTsNCg0KSWYgeW91IHRha2UgYSBsb29r
IGF0IHRoZSBmaXhlZCByZWd1bGF0b3IgZHJpdmVyIChmaXhlZC5jKSwgSSBkb24ndCB0aGluayB5
b3UnbGwgZmluZCBhbnl0aGluZyByZWxhdGVkIHRvIGEgaGFyZHdhcmUgDQpjb21wb25lbnQgKGNo
aXApIG90aGVyIHRoYW4gdGhlIEdQSU8gUGluLg0KDQpUaGFua3MsDQpTaGVud2VpDQoNCj4gPg0K
PiA+Pj4gVGhlIHJlZ3VsYXRvciBmdW5jdGlvbnMgdmlydHVhbGx5IHRocm91Z2ggc29mdHdhcmUg
bGF5ZXIgYWJvdmUgb2YNCj4gPj4+IHRoZSBHUElPIGRyaXZlci4gV2hpbGUgd2UgbWF5IGNhbGwg
aXQgYSAicmVndWxhdG9yIiBvciB3aGF0ZXZlcg0KPiA+Pj4gZWxzZSwgdGhpcyBjYW5ub3Qgb2Jz
Y3VyZSB0aGUgZmFjdCB0aGF0IHRoZSB1bmRlcmx5aW5nIGhhcmR3YXJlIGlzDQo+ID4+PiBqdXN0
IGEgR1BJTyBwaW4gYmVpbmcNCj4gPj4gdXNlZCBpbiBhIHNwZWNpYWxpemVkIHdheS4NCj4gPj4N
Cj4gPj4gVGhlIHJlZ3VsYXRvciBpcyBzb21lIHRpbnkgbGl0dGxlIGJveCwgeW91IGNhbiB0b3Vj
aCBhbmQgY2FsbGVkDQo+ID4+IHRpLHRwczUxNjMyIG9yIHNpbWlsYXIuDQo+ID4+DQo+ID4NCj4g
PiBXZSBhcmUgdGFsa2luZyBhYm91dCB0aGUgc3BlY2lmaWMgInJlZ3VsYXRvci1maXhlZCIgZHJp
dmVyLCB3aHkgZGlkIHlvdSBicmluZyB1cA0KPiAidGksdHBzNTE2MzIiIGhlcmU/DQo+IA0KPiBK
dXN0IGFuIGV4YW1wbGUuIENhbiBiZSBUUFMxMjMwOTguDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQo=
