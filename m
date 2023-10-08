Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030857BCE69
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344760AbjJHMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 08:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbjJHMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 08:55:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B05B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 05:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/WZHhPGeFPR+tRksvfYZq2ZETLR/1y93PK96dJSIpEQyJ6ddbG3LH8HVH7+dYpAMEZ/7H5C2BT0Scz2MuUz1+5/YE38iH7CMMj6BbLrTmJor6akryJbg76rRRl30e3fKOdAhrYnB6zvc75V4gSeyq3WTnIMSr5jq3pedq24qcPeD9HbwOgtrU/KFShId2CdLvkZ7LThvq5geu86oe87YJMVS5KPFU0OPA67jyrBSFzAMhvIwxm949D1hamFFkdtjpdPYfNTSdHSfEgUeSicF6LsqaJfedCucesBPxx3J0Oe2lvkXPQI5gXthNc/1rhB0uPtIlPBqsZ46Z/VTynmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkR7xcNXprE+Mk/Q79BdbtCjZi0wGM0YzumcLiRBHYk=;
 b=mYbh0amxtMACN330ZD3mluFhEydMec+tQO3DsIk8604MGES87uN9X6Dm8RSkYRV/8/AkqZVkFu2yb1nlXfGo8YXUlEpTYZeRy/5nIWQrTzwZWrYIez09YYUvpNfA19y05xBWB74eL7tvMIONLsjFwNRjCsI63CC8OP/t1RPBdsM/h2GrPBwmQxmaqgFR7o/b31KUKWp3hPnjjF9ypX2cyQbuznIEltYf8mf1PPqh40ZN8lm14pX7hxAUu1zKEUQ0swShW+VjNVni+0ab7NyiRmHlfiPha+KmWuhiHB5k8PesoFbcgzk75kyz53+21m33XRQpC0QLNeqfpeBLC8OjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkR7xcNXprE+Mk/Q79BdbtCjZi0wGM0YzumcLiRBHYk=;
 b=dDVTsTpyue444m7IRB81wyvSHHqIA9gJtrdRQuZHlyyt2ogwJU1XsV7ZW4tEaPpiCw1EOygS1ZZzaP/muY5ki6LpNHmqnQRHmnefU6w8gSZcvt/iWgeEbhGdK/SghvxC3TtG8jJhoYxldsmBKv0wtkFkauTvFVnSzDzAoOFFbEbwjKSPbU2s79UH07ovqyBBOij3L+HhoiQP4gw6010xPKHwk+k6gpFZzpmY1qiG/PcN2L4JknPW1jj+aXSrOL3sAbAIaH8PkF4shX/K7qkeZ1ZymBKraPqg7EC1DllPBhg0YmVWtdrTbNvGM6hJ0ZJXq8G0oBBSBEOJ9PEkSIlmEw==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by KL1PR06MB5922.apcprd06.prod.outlook.com
 (2603:1096:820:d0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Sun, 8 Oct
 2023 12:55:25 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::dcd7:b551:2d36:b7ee]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::dcd7:b551:2d36:b7ee%4]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 12:55:24 +0000
From:   Rex Nie <rex.nie@jaguarmicro.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBpcnFjaGlwL2dpYy12MzogbW92ZSByZWFkaW5nIG9m?=
 =?gb2312?Q?_GICR=5FTYPER_later?=
Thread-Topic: [PATCH] irqchip/gic-v3: move reading of GICR_TYPER later
Thread-Index: AQHZ71lU0aqbZD6+AkCaUa1YQ2OcErAtUVmAgBKbh5A=
Date:   Sun, 8 Oct 2023 12:55:24 +0000
Message-ID: <KL1PR0601MB5773BDEFC14175F54A201DB8E6CFA@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20230925023408.1441-1-rex.nie@jaguarmicro.com>
 <87msx8nb24.wl-maz@kernel.org>
In-Reply-To: <87msx8nb24.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|KL1PR06MB5922:EE_
x-ms-office365-filtering-correlation-id: b71a58df-b1f9-46a2-81fc-08dbc7fdd6d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MxjeYzH6Wleqel0W8+SxBgtNgYerVKM5Bkeutj/FO9Qi3G11VxOfOtFgKVp+xoQUuwER5JP0oRUW1RKHr+vo7MKQlezDUqQCck5sAD/BMk6iawuIoVE7JiFJgFa1vRcjVnMshhbQ6T5Uj9OSw9f0l/wDdQNrzOOnsCvG3QIJZevLwwoFaX1f4H+bGzdncf+xjHlOA82RnfF89Yh+W39CkF8Sg4u2T7OSFVPDaYjf8Hc+KjksqgCHDiceDc0hhicKxccjzdptU3UwGSVFn96ml30N44RtbS9PTRpzjuFSTkOe40V8M39//1+GmWLOTEvI1A4Rc6Ps7EBjM7x3Zw3yULUi+ifMZlfcJJU7NdQPaKRaZKUFLEmcAYhakqH0RfPpKk0eACTLzH72HNPkUZ1Bd/nt3O+o1OTqS5NYpk8YFbci6dVfFTr7YuBXeqKlEMQfm06Bwapocs1x4iY1PPlufFlEAQNm4O9Mq9RVioVRfhl2WGZ4i6rdGXBv2MIWlugTTnUvz02wi6F47lIWPIKOZxmvjuva+8OBzjXRvEWVplZCX6SglYvCtSlPFOgHZC5dkqMbIirhAMMGloFxxxtT2DFenKZWOUfby3mpXQbH057xKEELkD0M2v5NfoxEtjf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39830400003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(83380400001)(9686003)(38070700005)(26005)(71200400001)(122000001)(6506007)(7696005)(224303003)(41300700001)(76116006)(478600001)(66556008)(66476007)(316002)(66446008)(66946007)(64756008)(6916009)(54906003)(8936002)(52536014)(5660300002)(44832011)(86362001)(4326008)(33656002)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WitzbWh0RC9oTngyMi9xb1RVMCtGMDhYbE9kK3dLeTJ2SkJJK2Q1bElMTm1Y?=
 =?gb2312?B?VUNaNlJBdXlRYWU0MUZ0MG9LbkhWK0lHWFE3U0t0emdGMXNyZWc2ZE5VZnJL?=
 =?gb2312?B?M0kvc1g2c1h0MkFWOHd1Rit1cEx5ZXBtb2R6RFJTbVlERWtmSVplVXE5K29O?=
 =?gb2312?B?Z0pTaXVSVzZqZC9hMjhKZUJ1ZHh2RlpQOE4vTC81Z0x3OGwwTURGV3VwQm1X?=
 =?gb2312?B?QUlRWDJLUVptZ3JhbWtBRE5ZKzJNdTc4czY4bnNWbm11YjdJNHF1UmRYQWxX?=
 =?gb2312?B?QS9xYVBHcVJ4L0UxdXN5VHBodUNpdnhRcTVnVXNqdWFRVGs4Uy9tdHZvTHpH?=
 =?gb2312?B?VVAzbnhKaHVuTVpYRzJXUUViRFJBajZiMlNQT0JtK043NEZWcXJndUtiQlFS?=
 =?gb2312?B?ZVE4a3NDR3hmZlE4MzYxRVlqdkhKTVQ2Q0wwU3ovUE1xeG1qbDd3dUp0SlhB?=
 =?gb2312?B?SUVyY0x1NmVvZ3ZEL3dMUlZwQ3ZiNjJoQVBOQk9ESGo4L0ZyR29zR0hvbU1u?=
 =?gb2312?B?aVNxMVFQUU9nWDhoeWpONzFTMGYzbmRaS05heVd4cFF1a0RzdEhINkIwb05D?=
 =?gb2312?B?aUZWWDJQOG13ZkRVOEZrcTQvanNydW9KVitaNVBLU2FIeEpDWnExZkpQRHJM?=
 =?gb2312?B?SDhObjM5a0JHeE5OZkh5bktpZFlJUHZqUHZDRFllT1RUTnpGc2lNRUUycUNk?=
 =?gb2312?B?V3kwTlpUMzBaRE84RVBkTmpDdjJtOVZiazJITXd3cGZTbm40ZEFOcmNJL29h?=
 =?gb2312?B?MXlYTkI4TmlWbGhBNnRCVUZ5UlpBTmhxTE9oM1FEREZubWtIeThHMDhBWkUr?=
 =?gb2312?B?M002QkRld2Vxbi81dE9ORWlMb0hjRWVxVFY3SE92aGt2cmpQODE2V05LOE9l?=
 =?gb2312?B?bXg3UEhXRnZGdGg2bkQ5R1JEZlIrNDQvUWI0a05CeDQrZlRwMmd4TGppMU9z?=
 =?gb2312?B?UDhXbzVnMUJoTXA5RGZublJwZG5zWHRqbHRjSGRFeEZOUDdDcFVaTHQ0ZkJ3?=
 =?gb2312?B?eTBnMnlncm0yTGJPWW82ZUR3OHBwa0hLM29iMHNnMCtEV25wTWlGRVlQZEY4?=
 =?gb2312?B?bm52VGtMdlBiQi9IS3grQVJabHpLSXJTY1RlWCtYb0tuQXR2UnZQNlpOMXJu?=
 =?gb2312?B?Vm13UEY3KzZKd0QxblVrV3dIRDVINDZhU1p1aFVndFlRcHNPY0krMkNHRHZ6?=
 =?gb2312?B?dnVhWWl0WEdWclRZU0VIcU9tQUVwdUxDc1RLMU9QLzVSQmM0VDVNb2Rtd2pE?=
 =?gb2312?B?d3hKSXoxbllWYmY3U20yd3I0NlI0MDg3MXJKdGRPQVYrWHp6K3YzS21HeXlG?=
 =?gb2312?B?YnJuYTF6OWprdkw0dUFBN252dHdVM0NLU0xFR040R2F6N2k4Q2lZYnlYR1hE?=
 =?gb2312?B?QW0zakVIVy92R2wwcmtocVB3cXpqZCtFY3FOU2JXNmJUR0d4ZkdkcFhtcUtU?=
 =?gb2312?B?QllpUHQveFJFS0tDT2lma0d2dUpEb1R6bDFVRkQ2YS9vTW11R2dIOGpFdkE0?=
 =?gb2312?B?MXkzL3A0cWQ5KzViSlpaYndzNmVZeE9hMXFaRUpKSkdTbE1sU09uakpTMGdQ?=
 =?gb2312?B?WlRjcE02VlZjOFA0VUFLdGhwenkyWXlpWXRTU2ZxSlBicEUrR0ZRU00zVDlL?=
 =?gb2312?B?OWM0cnNNT3RQaUdaRExldzZIcDFNSlM4WGh1WG5HZWxtM2VKc1o0MXVrM0xU?=
 =?gb2312?B?RGVOelk2R0xPOUJVeDBtYjR6WVFiYWU2UmIyOElFT28vNnMxd1JhWGQxeldZ?=
 =?gb2312?B?UG1WZjJyd1Ryb285bm4xWHBwMUEyY1J5VVJaYmQ2SFVIOUVHUHZxVFBXWXB3?=
 =?gb2312?B?N1RFTGJ2SXR0OG1ZNTM0N1dRYzUvRytieXIxaGl6OUlETkZHdjJ3WjRuSzdx?=
 =?gb2312?B?NVZhWFRMdCtLUktQR25XRmswWTBZWVJaTmMvcjlkZVlCeUxXb0hrbDRST0pI?=
 =?gb2312?B?OVJCNG5qYkI2QWpPRWRLeHJuVUQ0NmswZkVGK3JpcTlaWFU1NmVtZWpVK294?=
 =?gb2312?B?VUFNMHFHZlpqaU5iV1hsc3hobkFQbzFleURVN1lXQ2QzOTNzTVo3V2o2MWRF?=
 =?gb2312?B?QzNSYXNsVDA0ZnZQNVMzUld0Sm1WOUtGWGdNVkFaaDRsWXhjV3ZEQWI5RGRl?=
 =?gb2312?Q?G4exgygpqryB8rnIcRIRGBILS?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71a58df-b1f9-46a2-81fc-08dbc7fdd6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2023 12:55:24.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNTLIFCyWnbx2dzmZkFvv15mSjSEkUTmNaIeup+eirkr7uBvLUZ+RxNmgAv9QplDcFVcBAgvpROwWmGP063V4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEkgTWFyYywNCglUaGFua3MgZm9yIHlvdXIgY29kZSByZXZpZXcsIEFncmVlIHdpdGggeW91IGFi
b3V0IHRoZSBjaGFuZ2VzZXQgd2lsbCBtYWtlIHRoaXMgY29kZSBtb3JlIGZyYWdpbGUuDQpCUnMN
ClJleCBOaWUNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+IA0Kt6LLzcqxvOQ6IDIwMjPE6jnUwjI3yNUgMDo0MA0KytW8/sjLOiBSZXgg
TmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCrOty806IHRnbHhAbGludXRyb25peC5kZTsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6IFtQQVRDSF0gaXJxY2hpcC9n
aWMtdjM6IG1vdmUgcmVhZGluZyBvZiBHSUNSX1RZUEVSIGxhdGVyDQoNCk9uIE1vbiwgMjUgU2Vw
IDIwMjMgMDM6MzQ6MDggKzAxMDAsDQpSZXggTmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4g
d3JvdGU6DQo+IA0KPiBUaGlzIGNoYW5nZXNldCB3aWxsIHJlZHVjZSBvbmUgcmVhZGluZyBvZiBH
SUNSX1RZUEVSIHJlZ2lzdGVyIHdoZW4gYW55IA0KPiBvZiBuZXh0IDIgY29uZGljdGlvbnMgbWVl
dHM6DQo+IDEuIGZvdW5kIHJlZGlzdHJpYnV0b3IgZm9yIGN1cnJlbnQgY3B1IDIuIHNpbmdsZV9y
ZWRpc3QgaXMgdHJ1ZSBmb3IgDQo+IGdpY19kYXRhLnJlZGlzdF9yZWdpb25zW2ldDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBSZXggTmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pcnFjaGlwL2lycS1naWMtdjMuYyANCj4gYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My5j
IGluZGV4IGVlZGZhOGU5ZjA3Ny4uZDA4YTQ3NzNmNjMxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2lycWNoaXAvaXJxLWdpYy12My5jDQo+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYz
LmMNCj4gQEAgLTk4Miw3ICs5ODIsNiBAQCBzdGF0aWMgaW50IGdpY19pdGVyYXRlX3JkaXN0cyhp
bnQgKCpmbikoc3RydWN0IHJlZGlzdF9yZWdpb24gKiwgdm9pZCBfX2lvbWVtICopKQ0KPiAgCQl9
DQo+ICANCj4gIAkJZG8gew0KPiAtCQkJdHlwZXIgPSBnaWNfcmVhZF90eXBlcihwdHIgKyBHSUNS
X1RZUEVSKTsNCj4gIAkJCXJldCA9IGZuKGdpY19kYXRhLnJlZGlzdF9yZWdpb25zICsgaSwgcHRy
KTsNCj4gIAkJCWlmICghcmV0KQ0KPiAgCQkJCXJldHVybiAwOw0KPiBAQCAtOTkwLDYgKzk4OSw3
IEBAIHN0YXRpYyBpbnQgZ2ljX2l0ZXJhdGVfcmRpc3RzKGludCAoKmZuKShzdHJ1Y3QgcmVkaXN0
X3JlZ2lvbiAqLCB2b2lkIF9faW9tZW0gKikpDQo+ICAJCQlpZiAoZ2ljX2RhdGEucmVkaXN0X3Jl
Z2lvbnNbaV0uc2luZ2xlX3JlZGlzdCkNCj4gIAkJCQlicmVhazsNCj4gIA0KPiArCQkJdHlwZXIg
PSBnaWNfcmVhZF90eXBlcihwdHIgKyBHSUNSX1RZUEVSKTsNCj4gIAkJCWlmIChnaWNfZGF0YS5y
ZWRpc3Rfc3RyaWRlKSB7DQo+ICAJCQkJcHRyICs9IGdpY19kYXRhLnJlZGlzdF9zdHJpZGU7DQo+
ICAJCQl9IGVsc2Ugew0KDQpJIHBlcnNvbmFsbHkgcHJlZmVyIGVzdGFibGlzaGluZyB0aGUgZXhp
dCBjb25kaXRpb24gZm9yIHRoZSBsb29wIGFzIGVhcmx5IGFzIHBvc3NpYmxlLiBEb2luZyBpdCBs
YXRlciBtYWtlcyB0aGlzIGNvZGUgc2xpZ2h0bHkgbW9yZSBmcmFnaWxlLCBhbmQgSSBzb21laG93
IGRvdWJ0IHRoYXQgeW91IHdpbGwgbm90aWNlIHRoZSBleHRyYSByZWFkcy4NCg0KQ2FuIHlvdSBh
dCBsZWFzdCBxdWFudGlmeSB0aGUgaW1wcm92ZW1lbnQ/DQoNCglNLg0KDQotLQ0KV2l0aG91dCBk
ZXZpYXRpb24gZnJvbSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90IHBvc3NpYmxlLg0K
