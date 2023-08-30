Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4933478DD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbjH3Ss2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbjH3Hbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:31:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C6CC9;
        Wed, 30 Aug 2023 00:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmvm5mYFEwye+229AbJnX5274Fwxc04rNkLDfQ2ByK0gY0zye6DJw444EovI4X6SMjoKadfDFJmkFdtHJhoVxNfn6tPSTswenal3Ukj5GT1HZ/4IhQn5AtH3haqujIURuS/x8Ph7bV0e17+sZ7aID4w3YQxzQelso47CJoaNjz7juF0t25SqMrgjzJmWNXO7cZQkubylqJycWrpZG/QK9Fe6CNtVAUNgyXQrA8BD51BRrt1a9f/Xwo1G1hWjAKJ00A/XPQ+zAHkMmfo1MbgZJZpQg4fn25yZ8Kl2m4h4oM189w0rHLBzIEwqIa1fTlOILVaiPfiW25R0lH6rrBfQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcg5nt4aLLuoBPjJ6VKOaGTIV3wc4/gXf+9/FbFGhXQ=;
 b=T2TSQdOWWpcsJC0wtAgqPjNJUdmxsmYHboYd8+9rrzPKUJwsKDwuO5NjJxZ9wCvGfvf1aqIX9nmU2vIxmjCywDhScJVXYq5uwSTjP7hMUDQlGtysBk0xF6AqQnXIUq9vEbX1kuKaTBk24kvb8iZkhhDgJiMKC3/DMh41r+obrLnlu/V5HXZ8itAdBBHfrCv7w4XJNii1dpe6GVO1NmcXo5DX9Y0flkspdJieooG2OJPPzgvUIWHdVyvNaJGhpdTkQqV5G42p7rnuaxf/0p2yZh8+luDLnD9TFoIKnJN4UBEUD/h9kHBqphlNdgcD8keHPKFsbkKueqmND8qme2MK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcg5nt4aLLuoBPjJ6VKOaGTIV3wc4/gXf+9/FbFGhXQ=;
 b=Ib/2Vcx0xuUespGwYzVdQBBQoYpOSBwpG9iwpExBfRXoAPCinOFB8wKu5Z+NGK5mHLmM30hvCLRDr5mITIbr47x5wPimV+fB8s4jBf3ArYdlBBgOH6GhE0gOZwHsSw1EitqgVxpQ+F2xeCs3wK7GnNajWfCHyHS9zhey7X6KsHg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB9086.eurprd04.prod.outlook.com (2603:10a6:150:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 07:31:24 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 07:31:24 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 1/3] dt-bindings: phy: Add i.MX8QM PCIe PHY binding
Thread-Topic: [PATCH v1 1/3] dt-bindings: phy: Add i.MX8QM PCIe PHY binding
Thread-Index: AQHZ2klmZUX6Ja0EJ0SXpP8EIwL9DbAA5awAgAE+P1A=
Date:   Wed, 30 Aug 2023 07:31:24 +0000
Message-ID: <AS8PR04MB8676B511250439EF71D0E3488CE6A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1693291534-32092-1-git-send-email-hongxing.zhu@nxp.com>
 <1693291534-32092-2-git-send-email-hongxing.zhu@nxp.com>
 <7c083976-81cc-96e3-af76-43944ce571ac@linaro.org>
In-Reply-To: <7c083976-81cc-96e3-af76-43944ce571ac@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB9086:EE_
x-ms-office365-filtering-correlation-id: a4745452-d92b-4fea-44ea-08dba92b1d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjCK1cTI/c0Fs/8lHpdKo1e/75DYNDhyT0n7Ybk6GecPScOh9Iv9WMh02X0ob4SNjrvs5Z6YasqzPW4rRT6T1HhIr6izllkQQoX1mfaiVW5HdvoM41+42TLD5YIEC1MTaboNjWoFvTux6TEQUXS3WV07Tn1doAywdmGuqtzCMvyiHHX0H/t98sUPtLzMAJ6fgHmX92S/SyI/QwIDtmh8bLBAKZcvdFS+qm9BHkWLaMj6z/qy/+Ko3nrBjzaOHszrWRnICac43czFo/AGzbKgRcrUa/UMR8iIpzeq1ca8cj4AaRDF7Ga+udisYecsBBRjE57MZhVSAX0KurovwdadKqg9xmjFog73HxGkrBm6YATpbXip6EmlztS4S2zr0s3xHvf/2ZTR+Paknyn9TF3nLOXN7v424wC01X5eE0MDBsgm2I3cyosutmDtNZlY6VkH2Jn4+HF5rU2XCKzE69P1iYANjH+8Qfg06hb9ybo5qWQHk7799G/qzq+3XTEYZKPCKtpLsSgNpX/TNnhRfE0BiW25EmLZcX/1+p3QpQhyTUZHVO9BvGtF56P/nQu//BjLGyCh3mwq5S2eIph7o9AK4G62WfQOsjkLgDtZwlzoPw8+4urKT0UAYbw5zHBjomfbOGnKKSI4r8OegBdl87AYpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(1800799009)(186009)(451199024)(6506007)(71200400001)(9686003)(7696005)(478600001)(83380400001)(26005)(2906002)(7416002)(316002)(64756008)(54906003)(41300700001)(66476007)(66446008)(76116006)(8936002)(66946007)(52536014)(110136005)(44832011)(5660300002)(4326008)(8676002)(33656002)(53546011)(38100700002)(55016003)(38070700005)(86362001)(122000001)(66556008)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEYvejFoNnlBYWo5dFRGcW50ZzJpaFErcFlkbWdVMncrSVVoeExHZUY3N2tS?=
 =?utf-8?B?ZFc2SDBYRDh2VEhjK2hTem8xTXdQZzdDQ2ttQW93aXp5cmt3UnZ5WW5pcVhu?=
 =?utf-8?B?L05kbk1OSHUxVUNBNi96R1dEU1VpbDB2ZUMvVk84TUY5aEg3K0F1MFlpay9a?=
 =?utf-8?B?WWpIa3pqNzA2OEk0N1lRSEVzaitOV2UzQmpISTU4eFVJY2pRRDJITHZEYjFk?=
 =?utf-8?B?UDYvS2wzMHhpQ0ZmSDRmdUFaQXJaNE1QakluTEY5N3Fhc1dGL3U1Y1hkbGM3?=
 =?utf-8?B?K0dOLzdxQ2QxVnQwVU11Zk1aSXhoS0VOVzUrYWtGR0RTOUxva255K1czdm9l?=
 =?utf-8?B?bEUzM1lWbm1WSzEwWEdSRVN2NmV1R3VuQXRxWUVRUGxsbEJMYUZHTVoyeUls?=
 =?utf-8?B?V3AvZ2NvV0dkYUNHMmxWRHlhK2tNR2xnMWpOaGl3d2g2ZDZVSU5BS0J4ck9k?=
 =?utf-8?B?Qmk2b2c0SkRjdVl1bHkvOXk4cU9IYXZWcVBaYjBQcXJMSFROcmVlQ1VFTU5P?=
 =?utf-8?B?Z2hkSzlKNmducXBWUnZEZ0RpSXc1NGV0elE1UmhsVWVxTjlwR291WVZCbFgv?=
 =?utf-8?B?WEM3dmE0eFZYU2VsTzdVUThndEVXcWsrQ3c3ZGNEZ2lOQ2QzSkcxRFIrQTU2?=
 =?utf-8?B?OURjTmd5Tkx6bjg5V08zeTJkV2NQd1l1MEFuQ08wdlZhWllIYWs0N2l6SjMv?=
 =?utf-8?B?N2cwYU52ZEl4bGI3YktvdHpJbDlZR3dNdjhrRzc5N3Zpd3ljczBwRmpzdEhz?=
 =?utf-8?B?ZTgwTlZiMzVMNG16MnRTZ3c3Rkc0OFRIcnFoM0JoUlZoTE5sdUc0MCt2YXll?=
 =?utf-8?B?c2Z4dm1yRDF4bHNVOGZrWE1ZcktrN01zazlNYXY2K2wrWWh6YkpXbXhaUHBt?=
 =?utf-8?B?OEZCWmxOOWZGazNXRkZ4NHNDOGwrMWNlL0hkck13aVkwbm8yT0Frd2NCb1NS?=
 =?utf-8?B?SlpPNHRVclkra0Y0ZXl1aGIwVVM1Rk10MEJrRDFOd2RIUzNWRDNkYi9QcDcw?=
 =?utf-8?B?ZmZsSFZBTWpIU2M3aUMrYlA0b1YrYnFHYXBNa00xN2FuR3Ava3ZZODhZN01q?=
 =?utf-8?B?T3d5dWlNdlNYbzZzbDVJWmJTMkgzcFJiMFRWYU1HK2JYWXFROXVTSUxTeEg5?=
 =?utf-8?B?ekpGWVNwcEdEc3JNZGZSSUQyb0RlWlY5UXpSUWlaQi9RaEF1Nitob1A4MHJ4?=
 =?utf-8?B?NjJFM3BXVHl4aWw3K0RxZ3ZIUmgwSnNqNzIvNGd0dERKdUVKWmxYeWNXdXU4?=
 =?utf-8?B?TVBFRVptUFFvWHlJTGdHQWZaQUpPRnd2VDJ6VVlnWlJWRG91OEhmSTBqbjNI?=
 =?utf-8?B?ZGQzdUo1MHArZ1NYMnI0NGRzcjR2UGxsZENxV0ppbnNNdHk5bm9zdnNYY0ZN?=
 =?utf-8?B?c1g3ZkJHTlhQVXM3anc5YzZKSmdrSFd6QUJpc1VDa2x6MXJkcmVuRFQ1dGVR?=
 =?utf-8?B?bVYrRjNHYnh6QU1ocy85YWNGWmhVOUFpbFhOZStGUXhvQ3k1a2hqa0xIdEd4?=
 =?utf-8?B?ZTJGbURLdFE1V1ZMMTFYTDRUcHpFZXA2UWcrb1V6d2MxMGJqanViRHVZaHgv?=
 =?utf-8?B?dzEzV3RvbnZHUlAxb1hWRzFlb1FETlpDSVB2SjZiNERwdlRXNXErb1ZEc2J5?=
 =?utf-8?B?dzN4eEZPenhMb1I3VFp2VExwREFQaG9YQ2pKWHRVSVRhK3NIejhDeVF4cnIv?=
 =?utf-8?B?bXd1VitXWTgya2NYM05CdWY2bUI3SEE0eTNZanlFWC9xeVVPbTBlU2c2UGxj?=
 =?utf-8?B?WktlZlZoMWRib1dRMVhSbUlWOFZibW9ERzJzQnVUT1VKOUlqYk9SVkp5Nlkw?=
 =?utf-8?B?RzIyUjdPWXZWWmo0NDJmc00vL1ZtcUhXZjZqb05kOWxiNHlUQXIxdy8zRm9O?=
 =?utf-8?B?L2t0WXo5OW1PMWcyL1d6bkJ3NkFqS2JRaVR4d2pnZ0pxU0lDTFdDYXJNSGR5?=
 =?utf-8?B?bFMxV3NHUXhXbWE1L0k2Q2U3aUx0ajFyRS9jSG5idlBJdmthNTI2T0RieGJn?=
 =?utf-8?B?dkwwR1pyOWV3SjZTcW91L3cxWkY1bFpKM0dwaWVjbmFFOGdneGhqMGZJVGJL?=
 =?utf-8?B?eXkrN1lyWWRpWkMyWTBJcjdJYjROelNhZ0JOU2w0MG52c3MyNXNoK1F2bW1P?=
 =?utf-8?Q?MxqF/JCeqX6nuM9HaYc24a9Md?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4745452-d92b-4fea-44ea-08dba92b1d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 07:31:24.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqUE6McFcW4+DZMOkT8LsBbiIzZsGM4My69jR/zk4hT3MuNgiUWO/dqhcB+FcRg0wPgFu2JW3S4iriJiUPr67Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6c3p0b2Y6DQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyM+W5tDjmnIgyOeaXpSAxNTo0OA0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5vcmc7DQo+
IGtpc2hvbkBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dz
a2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBsLnN0
YWNoQHBlbmd1dHJvbml4LmRlOyBhLmZhdG91bUBwZW5ndXRyb25peC5kZTsNCj4gdS5rbGVpbmUt
a29lbmlnQHBlbmd1dHJvbml4LmRlDQo+IENjOiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxIDEvM10gZHQtYmluZGluZ3M6IHBoeTogQWRkIGkuTVg4UU0gUENJZSBQ
SFkgYmluZGluZw0KPiANCj4gT24gMjkvMDgvMjAyMyAwODo0NSwgUmljaGFyZCBaaHUgd3JvdGU6
DQo+ID4gQWRkIGkuTVg4UU0gUENJZSBQSFkgYmluZGluZy4NCj4gPg0KPiA+IGkuTVg4UU0gSFNJ
TyhIaWdoIFNwZWVkIElPKSBtb2R1bGUgaGFzIHRocmVlIGluc3RhbmNlcyBvZiBzaW5nbGUgbGFu
ZQ0KPiA+IFNFUkRFUyBQSFlzLCBhbiBpbnN0YW5jZSBvZiB0d28gbGFuZXMgUENJZSBHRU4zIGNv
bnRyb2xsZXIsIGFuDQo+ID4gaW5zdGFuY2Ugb2Ygc2luZ2xlIGxhbmUgUENJZSBHRU4zIGNvbnRy
b2xsZXIsIGFzIHdlbGwgYXMgYW4gaW5zdGFuY2UNCj4gPiBvZiBTQVRBIDMuMCBjb250cm9sbGVy
Lg0KPiA+DQo+ID4gVGhlIEhTSU8gbW9kdWxlIGNhbiBiZSBjb25maWd1cmVkIGFzIHRoZSBmb2xs
b3dpbmcgZGlmZmVyZW50IHVzZWNhc2VzLg0KPiA+IDEgLSBBIHR3byBsYW5lcyBQQ0llYSBhbmQg
YSBzaW5nbGUgbGFuZSBTQVRBLg0KPiA+IDIgLSBBIHNpbmdsZSBsYW5lIFBDSWVhLCBhIHNpbmds
ZSBsYW5lIFBDSWViIGFuZCBhIHNpbmdsZSBsYW5lIFNBVEEuDQo+ID4gMyAtIEEgdHdvIGxhbmVz
IFBDSWVhLCBhIHNpbmdsZSBsYW5lIFBDSWViLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGlu
Z3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5LnlhbWwgICAgICAgfCA3MCArKysrKysrKysrKysrKysr
KystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5LnlhbWwNCj4gPiBpbmRleCAx
ODJhMjE5Mzg3YjAuLjc2NDc5MGYyYjEwYiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5LnlhbWwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5
LnlhbWwNCj4gPiBAQCAtMTcsMTYgKzE3LDE4IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBlbnVt
Og0KPiA+ICAgICAgICAtIGZzbCxpbXg4bW0tcGNpZS1waHkNCj4gPiAgICAgICAgLSBmc2wsaW14
OG1wLXBjaWUtcGh5DQo+ID4gKyAgICAgIC0gZnNsLGlteDhxbS1wY2llLXBoeQ0KPiA+DQo+ID4g
ICAgcmVnOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPg0KPiA+ICAgIGNsb2NrczoNCj4gPiAt
ICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgbWF4SXRlbXM6
IDUNCj4gPg0KPiA+ICAgIGNsb2NrLW5hbWVzOg0KPiA+IC0gICAgaXRlbXM6DQo+ID4gLSAgICAg
IC0gY29uc3Q6IHJlZg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiA1
DQo+ID4NCj4gPiAgICByZXNldHM6DQo+ID4gICAgICBtaW5JdGVtczogMQ0KPiA+IEBAIC03MCw2
ICs3MiwzNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgZGVzY3JpcHRpb246IFBDSWUgUEhZICBw
b3dlciBkb21haW4gKG9wdGlvbmFsKS4NCj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4NCj4gPiAr
ICBoc2lvLWNmZzoNCj4gDQo+IE1pc3NpbmcgdmVuZG9yIHByZWZpeCBiZWNhdXNlIGl0IGRvZXMg
bm90IGxvb2sgbGlrZSBnZW5lcmljIHByb3BlcnR5Lg0KT2theSwgd291bGQgYWRkIHRoZSBmc2ws
aHNpby0gcHJlZml4IGxhdGVyLg0KDQo+IA0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiAr
ICAgICAgU3BlY2lmaWVzIHRoZSBkaWZmZXJlbnQgdXNlY2FzZXMgc3VwcG9ydGVkIGJ5IHRoZSBI
U0lPKEhpZ2gNCj4gPiArIFNwZWVkIElPKQ0KPiANCj4gSSBkb24ndCBrbm93IHdoYXQgYXJlIHRo
ZSB1c2VjYXNlcy4uLg0KU29ycnksIG1pc3Mgb25lIHNwYWNlIGJldHdlZW4gInVzZSIgYW5kICJj
YXNlcyIuDQppLk1YOFFNIEhTSU8gbW9kdWxlIGNhbiBiZSBjb250cm9sbGVkIGJ5IERTQy9zb2Z0
d2FyZSBpbiB0aGVzZSB0aHJlZQ0KIGRpZmZlcmVudCBtb2Rlcy4gU28gSSBhZGQgdGhpcyBwcm9w
ZXJ0eSAoZnNsLGhzaW8tY2ZnKSBoZXJlIHRvIHNwZWNpZnkgdGhlDQogd29yayBtb2RlIG9mIEhT
SU8uDQo+IA0KPiA+ICsgICAgICBtb2R1bGUuIFBDSUVBWDJTQVRBIG1lYW5zIHR3byBsYW5lcyBQ
Q0llYSBhbmQgYSBzaW5nbGUgbGFuZSBTQVRBLg0KPiA+ICsgICAgICBQQ0lFQVgxUENJRUJYMVNB
VEEgcmVwcmVzZW50cyBhIHNpbmdsZSBsYW5lIFBDSWVhLCBhIHNpbmdsZSBsYW5lDQo+ID4gKyAg
ICAgIFBDSWViIGFuZCBhIHNpbmdsZSBsYW5lIFNBVEEuIFBDSUVBWDJQQ0lFQlgxIG9uIGJlaGFs
ZiBvZiBhIHR3bw0KPiA+ICsgICAgICBsYW5lcyBQQ0llYSwgYSBzaW5nbGUgbGFuZSBQQ0llYi4N
Cj4gPiArICAgICAgUmVmZXIgaW5jbHVkZS9kdC1iaW5kaW5ncy9waHkvcGh5LWlteDgtcGNpZS5o
IGZvciB0aGUgY29uc3RhbnRzIHRvDQo+ID4gKyAgICAgIGJlIHVzZWQgKG9wdGlvbmFsKS4NCj4g
DQo+IE5vbmUgb2YgYWxsIHRoaXMgaGVscGVkIG1lIHRvIHVuZGVyc3RhbmQgd2hhdCBwYXJ0IG9m
IGhhcmR3YXJlIHRoaXMgaXMgcmVzcG9uc2libGUNCj4gZm9yLiBJdCBzZWVtcyB5b3UganVzdCB3
YW50IHRvIHByb2dyYW0gYSByZWdpc3RlciwgYnV0IGluc3RlYWQgeW91IHNob3VsZCB1c2Ugb25l
DQo+IG9mIGV4aXN0aW5nIHByb3BlcnRpZXMgbGlrZSBwaHktbW9kZXMgZXRjLg0KSXQncyBteSBi
YWQuIERpZG4ndCBkZXNjcmliZSB0aGUgSFcgY2xlYXJseSBhYm92ZS4NClRoZSBmc2wsaHNpby1j
ZmcgaXMgdXNlZCB0byBzcGVjaWZ5IHRoZSB3b3JrIG1vZGUgb2YgSFNJTyBzdWJzeXN0ZW0sIG5v
dCBvbmx5DQogdGhlIFBIWSBtb2RlLiBTaW5jZSB0aGUgUEhZcyBhcmUgY29udGFpbmVkIGluIHRo
ZSBIU0lPIHN1YnN5c3RlbSwgY2FuJ3QgYmUNCnVzZWQgYnkgUENJZSBvciBTQVRBIGNvbnRyb2xs
ZXIgZnJlZWx5LiBUaGUgdXNhZ2Ugb2YgdGhlc2UgUEhZcyBhcmUgbGltaXRlZA0KIGJ5IHRoZSBI
U0lPIHdvcmsgbW9kZXMuIEJUVywgdXAgdG8gbm93LCBJIHN0aWxsIGRvbid0IGhhdmUgYSBnb29k
IGlkZWEgdG8NCiBkZXNjcmliZSB0aGUgSFNJTyBieSBwaHktbW9kZXMgcHJvcGVydHkgYWx0aG91
Z2ggSSBwcmVmZXIgdGhpcyB3YXkgaW4gbXkgbWluZC4NCj4gDQo+ID4gKyAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGVudW06IFsgMSwg
MiwgMyBdDQo+ID4gKw0KPiA+ICsgIGN0cmwtY3NyOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+
ID4gKyAgICAgIHBoYW5kbGUgdG8gdGhlIGN0cmwtY3NyIHJlZ2lvbiBjb250YWluaW5nIHRoZSBI
U0lPIGNvbnRyb2wgYW5kDQo+ID4gKyAgICAgIHN0YXR1cyByZWdpc3RlcnMgZm9yIFBDSWUgb3Ig
U0FUQSBjb250cm9sbGVyIChvcHRpb25hbCkuDQo+IA0KPiBQbGVhc2UgdHJ5IHNvbWUgaW50ZXJu
YWwgcmV2aWV3IGJlZm9yZSBwb3N0aW5nIHRvIHBhdGNoZXMuIENvbW11bml0eSBpcyBub3QgY2hl
YXANCj4gcmV2aWV3ZXJzIHRha2luZyB0aGlzIGR1dHkgZnJvbSBOWFAuIEkgYW0gcHJldHR5IHN1
cmUgTlhQIGNhbiBhZmZvcmQgc29tZW9uZQ0KPiBsb29raW5nIGF0IHRoZSBjb2RlLg0KPiANCj4g
VGhpcyBtaXNzZXMgdmVuZG9yIHByZWZpeCwgYXMgZXhwbGFpbmVkIG1hbnkgdGltZXMgZm9yIGV2
ZXJ5IHN5c2NvbiBwaGFuZGxlLiBBbHNvDQo+IG9wdGlvbmFsIGlzIHJlZHVuZGFudC4NClNvcnJ5
IGFib3V0IHRoZSBtaXNzaW5nIHByZWZpeC4gVGhlIHByZWZpeCB3b3VsZCBiZSBhZGRlZCBsYXRl
ci4NCkFuZCB0aGUgb3B0aW9uYWwgd291bGQgYmUgcmVtb3ZlZC4gVGhhbmtzLg0KPiANCj4gQnV0
IGFueXdheSBzdGF0dXMgb2YgUENJZSBvciBTQVRBIGNvbnRyb2xsZXIgaXMgbm90IGEgcHJvcGVy
dHkgb2YgdGhlIHBoeSwgc28gaXQNCj4gbG9va3MgdG8gbWUgeW91IHN0dWZmIGhlcmUgc29tZSBw
cm9wZXJ0aWVzIGJlbG9uZ2luZyB0byBzb21lIG90aGVyIG1pc3NpbmcNCj4gZGV2aWNlcy4NCkkg
c2VlLiBZb3UncmUgcmlnaHQgdGhlIHN0YXR1cyBvZiBQQ0llIG9yIFNBVEEgY29udHJvbGxlciBp
cyBub3QgYSBwcm9wZXJ0eQ0KIG9mIHRoZSBQSFkuIFNvbWUgYml0cyBjb250YWluZWQgaW4gdGhl
IGN0cmwtY3NyIHJlZ2lvbiwgYXJlIHVzZWQgdG8ga2ljaw0Kb2ZmIHJlc2V0cyB0aHJvdWdoIHRo
ZSBpbnRlcm5hbCBnbHVlIGxvZ2ljLiBTbywgdGhpcyBwcm9wZXJ0eSBpcyBhZGRlZA0KIGZvciBw
aHkgZHJpdmVyLg0KPiANCj4gPiArDQo+ID4gKyAgbWlzYy1jc3I6DQo+ID4gKyAgICAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4gKyAgICBkZXNjcmlw
dGlvbjoNCj4gPiArICAgICAgcGhhbmRsZSB0byB0aGUgbWlzYy1jc3IgcmVnaW9uIGNvbnRhaW5p
bmcgdGhlIEhTSU8gY29udHJvbCBhbmQNCj4gPiArICAgICAgc3RhdHVzIHJlZ2lzdGVycyBmb3Ig
bWlzYyAob3B0aW9uYWwpLg0KPiANCj4gU2FtZSBwcm9ibGVtcy4NCj4gDQoiZnNsLGhzaW8tIiBw
cmVmaXggd291bGQgYmUgYWRkZWQgbGF0ZXIuDQo+ID4gKw0KPiA+ICsgIHBoeS1jc3I6DQo+ID4g
KyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4g
KyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgcGhhbmRsZSB0byB0aGUgcGh5LWNzciByZWdp
b24gY29udGFpbmluZyB0aGUgSFNJTyBjb250cm9sIGFuZA0KPiA+ICsgICAgICBzdGF0dXMgcmVn
aXN0ZXJzIGZvciBwaHkgKG9wdGlvbmFsKS4NCj4gDQo+IFNhbWUgcHJvYmxlbXMuDQoiZnNsLGhz
aW8tIiBwcmVmaXggd291bGQgYmUgYWRkZWQgbGF0ZXIuDQo+IA0KPiANCj4gPiArDQo+ID4gIHJl
cXVpcmVkOg0KPiA+ICAgIC0gIiNwaHktY2VsbHMiDQo+ID4gICAgLSBjb21wYXRpYmxlDQo+ID4g
QEAgLTc4LDYgKzExMCwzOCBAQCByZXF1aXJlZDoNCj4gPiAgICAtIGNsb2NrLW5hbWVzDQo+ID4g
ICAgLSBmc2wscmVmY2xrLXBhZC1tb2RlDQo+ID4NCj4gPiArYWxsT2Y6DQo+ID4gKyAgLSBpZjoN
Cj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsg
ICAgICAgICAgZW51bToNCj4gPiArICAgICAgICAgICAgLSBmc2wsaW14OHFtLXBjaWUtcGh5DQo+
ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNsb2Nr
czoNCj4gPiArICAgICAgICAgIG1pbkl0ZW1zOiA0DQo+ID4gKyAgICAgICAgICBtYXhJdGVtczog
NQ0KPiA+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgICAgICAgb25lT2Y6DQo+ID4g
KyAgICAgICAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAgICAgICAtIGNvbnN0OiBwaXBl
X3BjbGsNCj4gPiArICAgICAgICAgICAgICAgIC0gY29uc3Q6IGN0cmxfaXBzX2Nsaw0KPiA+ICsg
ICAgICAgICAgICAgICAgLSBjb25zdDogcGh5X2lwc19jbGsNCj4gPiArICAgICAgICAgICAgICAg
IC0gY29uc3Q6IG1pc2NfaXBzX2Nsaw0KPiANCj4gRHJvcCBjbGsgZXZlcnl3aGVyZS4NClNvcnJ5
LCB3b3VsZCBiZSBjaGFuZ2VkIGFuZCBhbGlnbmVkIGxhdGVyLg0KPiA+ICsgICAgICAgICAgICAt
IGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAgICAgLSBjb25zdDogYXBiX3BjbGsNCj4gDQo+IE5v
LCBvcHRpb25hbCBjbG9jayBnb2VzIHRvIHRoZSBlbmQgYW5kIHBsZWFzZSBleHBsYWluIHdoeSBB
UEIgaXMgb3B0aW9uYWwuDQpJIHVuZGVyc3RhbmQgdGhhdCBwaHkgc2hvdWxkIGhhdmUgdGhlIGFw
Yl9wY2xrIHdoYXRldmVyIGl0IGlzIHVzZWQgaW4NCiB3aGljaCBtb2RlLiBXb3VsZCBrZWVwIGFs
aWduZWQgaW4gdGhlIGNsb2NrIGRlZmluaXRpb25zIGxhdGVyLiBUaGFua3MuDQoNCkJlc3QgUmVn
YXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCg0K
