Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4BD76C2F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjHBCe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHBCey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:34:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AEB1BF;
        Tue,  1 Aug 2023 19:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAnh3yugu9q3L2UxeMd1RgaIaJckg2a1fa2OuduvoXPiMvgAVw4aRl7jLvmxi0r/lM+CO9YlngL+I/OIee9tEYhF4NxczKnWlbu64bnpcf9XPgTeEnQ0gF8TfE+ZzkYuGSACinkAVw/fGY9ZagGlXew2p1gXKGgCgaeRA7Oa1c4sFHpRWWMr0wf2yzr1e8rDckOrTAqYF/se21ZpyaYHhl7Dt2Tma5ZvgxziCo7Ywm+9L/TPFApFuVtd6poRwgpGLXDoZXPo8+VGWklKCcjKbtqiA2QymQ3eShD7tgHoNrUG7KV9Hd6U6ilS04f9/9974hIbwf09G6o89hoUqdGbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCp1LxpDHsfflqqbpz9t/AJ9BQ+0oe2mV+CVtGR4ojc=;
 b=Q/VVwr0PJ9VmwlbvX6XizYbzkKgw+4eigw11AHzmqtSL/ZIKkan/dENcTfiSAIaVOogAU1mIC/+BdEpxfYgZkqnzzfhxijID6VKZqutTG4ca72diLDnJCrgCEzOVoo+jXK1gV+mEgXxh2gLVEhGNcLeztvQ3NWGXFEDrP75c0XNybz2+ZryEk5eJg/hfkY++cp/sP5p9K/UcaO5jFskR0kOM8HtxtR4w7P5jvmck5jO7d7+xYT+SsfPrlI75K9mJoDKveVY8VX26lpXJt/NZIbHc4zlzDh2DzuEpw+pVKYjASTkh7eYQ7qg5X4Xnf5yM+YGdRBme8h5z19KCVhMceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCp1LxpDHsfflqqbpz9t/AJ9BQ+0oe2mV+CVtGR4ojc=;
 b=PjthAHOrWFHlvVeHuTlD+2BUFiOpCwLZZGUBVzR++Ys0tE9QMRDOxhSCoIacgbSta8wI1u7WI3oRyHMenLA8Lar/BV4bGIGD69hA8m3usZ0ueemmkvYZ4hEdX5zDFSMJmGvK481uEVK7uUrrNhF1LhieFUjQcVeCMhpFLV/plRI/oSsK1DKv2rsZw293okpc3gLHifq7ovfAj5WB9k5UNQuKhdXVYFaMjCVax+xszGn8tCBAlW+uCODlfuq9rxoVZa6y+7BcYbtCCMCkM5UaSTLNUuDXCYVIxeAOGGGo21h5syCRICydeNdK7QWJfhPE1oJooUXoU0Znf5DfucvYNw==
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com (2603:1096:300:61::21)
 by SEYPR04MB6309.apcprd04.prod.outlook.com (2603:1096:101:b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 02:34:48 +0000
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::c49b:a607:6c17:a90f]) by PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::c49b:a607:6c17:a90f%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 02:34:48 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4
 board
Thread-Topic: [PATCH 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4
 board
Thread-Index: AQHZwDvz7mf7a/3GTUmfLqehWY+O4a/NLF2AgAkkwmA=
Date:   Wed, 2 Aug 2023 02:34:47 +0000
Message-ID: <PS2PR04MB35928B386F03C987061433D2B70BA@PS2PR04MB3592.apcprd04.prod.outlook.com>
References: <20230727033926.1904529-1-Delphine_CC_Chiu@wiwynn.com>
 <c9062d5c-b536-f89c-b380-8a0c9b858526@linaro.org>
In-Reply-To: <c9062d5c-b536-f89c-b380-8a0c9b858526@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR04MB3592:EE_|SEYPR04MB6309:EE_
x-ms-office365-filtering-correlation-id: 1cd3c69d-85c6-40f7-af88-08db93010a2c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGGKjm6QSWDUHolFsK0EObI0YYg46OiyPGiZm+lPhF5Pxfn7DrZMxZjyVElENKVZXzKdxO7nyCc1rcnoipzynIoUeZwuQIiDsytiDh4iNyLRas8lBpOnOCkElek4DOqpjHAYlBAiNd+Con3HhYbKSglszGY2iN3QxuoiDyHcSHWxcSQSIKPcHM806zdNOycftDjJJoHhwZizmc9hoPyoqu1P4FiUcoovAIctmgQA0+QNQRt89ZUo9njlGriVP/jx5zSM5+zdgvyJwbV9zTJuCvw/gscjwwlSXUUlCtl96DB++acPsNxzpif7l+UyfEuSQrfnfH/K9e1o4RM8Yg++fW9mjjSNvlgR2rwTX9euZ5j9REPmMpR0rffLP2qxe0WZZPHO/aNAXAX5S49xNN3Dlz8LxaT7ovjpS8HGEgXPua/RspiOXpe5iFqXffuUQk5clHu5eb4o45v1Y6CYO0LV9RGE37w4B6mZWq7OiCLjXAEwzsfQbUcjjOKRxL9JvbnHhvQ/riwC52aTSSnmbZP0h8QZDOVWJrtvu3DGnrfUWt8VjW/SVnm/U3i3HNtdAtn/VlcigKZQndLOPHMHdo1gJWhUlHDmaADAodwD2bQY5GGnfchm6bhP2KiwmbFBWuPC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR04MB3592.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(47680400002)(451199021)(55016003)(186003)(9686003)(316002)(86362001)(122000001)(478600001)(54906003)(110136005)(38100700002)(76116006)(66946007)(71200400001)(66446008)(66556008)(66476007)(33656002)(64756008)(7696005)(4326008)(53546011)(26005)(6506007)(41300700001)(5660300002)(8676002)(8936002)(83380400001)(7416002)(38070700005)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1N1elF3UG1DZ0JwNUdpZ2I1VTJabnl5K1NDNG5lc3hBcSszM0dNSElPS2NR?=
 =?utf-8?B?NjRlTzFuWmxLOEY2amRaaTN4dDVDTGI5Ky8wSjN0eHpDd2poemtNL2hDNnlZ?=
 =?utf-8?B?T2Zhcisvc2tIN1dlUHZkMjJVajhWYjVTdG1ycFYvdHQ0UC91YTNGUDNUNGly?=
 =?utf-8?B?WnpTM010WGxWcVZOTWpqTk9TZno2cmRteDFsTDNpZzgveTd6VTIyYmRUbm9S?=
 =?utf-8?B?YkJxYWlIZjdLb3RCYVp2REpDUm0zMW9nNWdNZTRIaGp1TkN0K2dqK2tHMzdl?=
 =?utf-8?B?cWxHL28veU14UytkNUF1SFJPcUpxQmJWLzdrekd1ZkNOVjNnR3BiUzhXQTI2?=
 =?utf-8?B?cysxdjNmSU9lMG5HWktMKzNMZHk4dHB3SVA5TWlxVVk1S1MzOVRaNTRkWnY0?=
 =?utf-8?B?Z1hFVU9Pb1NwbTFCb0FSRmZvaFZRczFUZUJhQjRmT3d2RjhWUFIxS0hXck1B?=
 =?utf-8?B?bmcyU0tQQ0o5cUt2aUhCSU53ZWRqdmh0VVdQeU1ReER3V3JjZ2paWFpwaHM4?=
 =?utf-8?B?QmlGb0RES1FjSmxTN0R2TGtKaGwrd1M0RmR2QTJYbnVlckdjU0NQc3p3cU5E?=
 =?utf-8?B?Tld2d1o3QkhzQWFyLzdCMVEzNzVmZ0ZvVi9PMGRSalpGN2J4Nm1oREFtMDMx?=
 =?utf-8?B?dm1WRzk1MnpZVXpJZUFqbEVSdzR4N2xKcXZyZlRabTBUMWhpT0ovdmZYVDJt?=
 =?utf-8?B?MUtxR1BRYXowVmVKS2txcWFOTWl6UnZtOVNKTUpKUzZ2amYxaTg2SVZ6NGtD?=
 =?utf-8?B?MDg3QUFFY3JjV2lzUVZZUzNOWmlibWhHNCs4WFFVbEo5SWl2eG9xVGFRNzkw?=
 =?utf-8?B?SGEyMkRGOE9NU09QdDNiRm1mK1Q5MG5qeWQzSzF3TTdvRjJtd2NLTXNTM3Rp?=
 =?utf-8?B?V05jdWxENTZpSXQ1T3ZpQzRUOXUyZE5YdFpZbmZNNmMvVFFnS1dRUFhGdTlo?=
 =?utf-8?B?TEhZSHNmVEROekhyN2o3WGlHelJ3YnJlUnBRODhsSElwSlczL21YeW1pcTFw?=
 =?utf-8?B?bjdENmRQZmhVTktlN3pHT0VkVGViSjdIdlZEa3gyVHBUVmNkeFd3SXZMaWht?=
 =?utf-8?B?eE55R3d1cFdpUHhPNU1XTWpiWU52R3pTR3c2cFhKdk85UURnNHN4UTcyU3RW?=
 =?utf-8?B?UElGVSsrTE5BNHZqbUdMaUdhUnJ5U2trS0N1UkdvLy9YbXNlamE1VjN1Zmpi?=
 =?utf-8?B?SHYxYkh6Z3hCUGwvWTNlWDBQb3hXdjR2VEpqYVFzR2JjMFQ1NWRTelg4ckox?=
 =?utf-8?B?RXlTUVg3ME5UQ3NsUUxiSzcwMG4zUzZnYitUVEtNdm1XKzNzZVRxdWR3SmIx?=
 =?utf-8?B?RkF5ZGhuYnI0SEJRcEF2YURYQVBBN3VlNG9CUWYybVVhYmJRK2JLeVZiam5i?=
 =?utf-8?B?ZDJWUlJrUzFWc2s0YjJQamhtM254NXZpNGxjaWZ1U3FXUUExZllQMVNON1U3?=
 =?utf-8?B?eC8rUHZlYmM3bWZoYXBCUlJ4eklMSVZiUjZ3K0d0d05xSHNxOEFhRlNKeDVv?=
 =?utf-8?B?Sk5tZGRyMEt1V0RwWk9sSXdxdVRQemxPNUhXYVJVbUM0R2oyRnZCYm9DSlli?=
 =?utf-8?B?S3oxNUVzbVhJY0lkQ2dNc2hJOTg3U1VFSWFZdlo1cGhLQ1RCekdKUDhaL1lw?=
 =?utf-8?B?UDhLaWdNakFrU0VjK0VDaStkWFRwMUtXVDJCeGdpWTErTG92V1QyajRPOUpr?=
 =?utf-8?B?ZE5ZVEVKQXJMdVFpUmF5TmIrdGlmMzAzeEdnU01OSlBzS2RCaGFrRENtZVl4?=
 =?utf-8?B?azZJMWw5d0RmUzBVUHhmNGJMMklIR3ZZV3FpWW5ZRTZDZGpLT3QrYm9KTE1v?=
 =?utf-8?B?T3hZb01RQ1lKOWVlU1UzUVdWSythWHhlczc3Ti9RQTVjWElRTkpVVjFKYjVU?=
 =?utf-8?B?V1RaQi9SRHJHR0Q5ekdoK0lLOTNLZVB1b0Z4RFZRbGZqSXhjZ2h5U0poQ084?=
 =?utf-8?B?UEpKNEZ3amdMd21iaWdIcjRoYUhtRDRqWnN2UkQ3dVNTdmM5WGg2RTVVY255?=
 =?utf-8?B?YVdQTHo2ZzJ0REh6enJsTEJJd3Z4Z2hXYStTT1czZFphSTA1RVVKMi96VzZD?=
 =?utf-8?B?bnB0bG9KWFNuMEROY3NUK0YyQmZEQzhMR0x1cnJOTXZELzh4OUdrTHRMMXF4?=
 =?utf-8?Q?CWthW622AaNZ92FKdWb4m+WUU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR04MB3592.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd3c69d-85c6-40f7-af88-08db93010a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 02:34:47.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+FUBLSi4kzN2fKltXP56u0rs/mz92lB/hSBotAAjq05vWfCN/Byy639rnWrGcZKeMYcIj2z655divl2WDD/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSAyNywgMjAyMyAyOjQ5IFBNDQo+IFRvOiBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5u
IDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+Ow0KPiBwYXRyaWNrQHN0d2N4Lnh5ejsgUm9i
IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRA
a2VybmVsLm9yZz47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBBbmRyZXcgSmVm
ZmVyeSA8YW5kcmV3QGFqLmlkLmF1Pg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYXNwZWVkQGxp
c3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBhcm06IGFzcGVlZDogYWRkIEZhY2Vib29rIFlv
c2VtaXRlIFY0DQo+IGJvYXJkDQo+IA0KPiAgIFNlY3VyaXR5IFJlbWluZGVyOiBQbGVhc2UgYmUg
YXdhcmUgdGhhdCB0aGlzIGVtYWlsIGlzIHNlbnQgYnkgYW4gZXh0ZXJuYWwNCj4gc2VuZGVyLg0K
PiANCj4gT24gMjcvMDcvMjAyMyAwNTozOSwgRGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gPiBE
b2N1bWVudCB0aGUgbmV3IGNvbXBhdGlibGVzIHVzZWQgb24gRmFjZWJvb2sgWW9zZW1pdGUgVjQu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZWxwaGluZSBDQyBDaGl1IDxEZWxwaGluZV9DQ19D
aGl1QHdpd3lubi5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vYXNwZWVkL2FzcGVlZC55YW1sIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gSSBnb3QgdGhlIHNhbWUgcGF0Y2ggZm91ciB0aW1lcy4u
Lg0KSXQgd2FzIG15IG92ZXJzaWdodCB0byBzZW5kIHRoZSBzYW1lIHBhdGNoIG11bHRpcGxlIHRp
bWVzLg0KV291bGQgeW91IHBsZWFzZSB0byB0ZWxsIHRoYXQgc2hvdWxkIEkgcmVzZW5kIGEgbmV3
IHZlcnNpb24sIG9yIHRoZXNlIHBhdGNoZXMgaGFzIGJlZW4gYWxyZWFkeSB1bmRlciByZXZpZXdl
ZC4NClRoYW5rIHlvdS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
