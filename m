Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129C2776542
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHIQmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:42:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B21982;
        Wed,  9 Aug 2023 09:42:31 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379EvsIQ002928;
        Wed, 9 Aug 2023 11:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=RsxAKHSVqUeG/X72iR6erAo0YEGAJsEzg5b5fV+QQ
        lM=; b=gqIK+lbzwY7srwgVF8UuKukkX840ymnLmayaz1D5GgMWE0QMpyxpK/DhU
        9k2A8NGq4D8epFKdg0PKnMK/CQDXnZpyFBgp8Rm6DvFZtFCVkC9t19XR+FjvqLFs
        u0y0xa2RAxlOLJDA2uDCCXyNg+c/Do7W2WH8U2psO1GSN21wGs/Xke7vKfRJkhAp
        n1Q5DS0khRGRoMf83LwZPP28XgmaK1Lkpae5ujEpzExj0nRWCqL1OLJz/NXa0Deo
        WApi4dK5H+e2R2oVtF8PhpUPWabW/4nPRUYJZOD4WlDyTiO31I8Sdk8Z9f/pll1K
        pI3KJVn24RxF5I3fnADTS59gNDNSg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhuxf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 11:42:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OukE5+XGm0QTfLHJAvs8B0UIFlEl8d1du0yeT4wKJ7B0ceileWBHVoYokFoQZpA0IXtQuybEkcpv0imbrgAfHBckHlrdGlKZ4NkO3FFZxEhCZ0LbSY3W8ThjrjA1PsKVJ4K5UaHCIN6A/Oo2BbxT8qkb2HloM0g1oHAT9/9ndU1ZIm4yR7lBC7HCPbdoJlBxAsPwyiMdwFzO6iVRePPn+dNcM2naLgdvmRyKeUeUqarsfbONsIRyK/CVN3hzcwqeKZ40yYpbvnj4N9nLFwd1DUxmVqCnttADD63ftWyLibtn/HcycVADmDSN2KCGZa6EHgAivdK8dDcW6dxC7UD9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsxAKHSVqUeG/X72iR6erAo0YEGAJsEzg5b5fV+QQlM=;
 b=c+eMRfid+ws0NJHbsNcwIart+R6qWnD5Ka+F0UriFuZy3wIlS1G6HNvmkQR6UqFNjVLjoJdQrMX9js2T/ibVg7dTl7fAXNC6D2qq4tjcnejjmoWvFVTv/4y95eUKPbIAIw9UpLUDV3Yx5VM0ZJlWXTU+Z49GQrq4bYgdUk0q+HfgZGz+C2q2FD/c0HMPK1ReL9v34WOjZOrPmgkLjKi7h0crqJDezRc2t6+gfxao5FlE8gxYDF7ool/6/YIEWdhjjQVf9DYq1LvzhLcI1lc3M1Gtt9HTHJ1u8HSY0RsbY2ckRlivxUmF+dac94lc5FrkGzmP8F18Feh0bPW84N9JNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsxAKHSVqUeG/X72iR6erAo0YEGAJsEzg5b5fV+QQlM=;
 b=sXFrw2xAPvRpNOmg/U56RsSufw5bxYSKuRLXqqBU4hsY1CdCV0WiVDGGW/ng9F3PbAJOd0CVEx/GqsY0hGMe+zC5xbBTdZHn1j4Hp0ZK+WYdraqJRwUVgbVpjHLr0Xfl0VacuzNDbdCK8Gz/LcVNMetueuG/BTsvA2TioO47DGU=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by MN2PR19MB3904.namprd19.prod.outlook.com (2603:10b6:208:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 16:41:29 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:41:28 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jeff LaBundy <jeff@labundy.com>, Peng Fan <peng.fan@nxp.com>,
        Eddie James <eajames@linux.ibm.com>,
        Jean Delvare <jdelvare@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "patches@cirrus.com" <patches@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: cirrus,cs40l50: Support for
 CS40L50
Thread-Topic: [PATCH 1/2] dt-bindings: input: cirrus,cs40l50: Support for
 CS40L50
Thread-Index: AQHZyh7JXcj7PWZYh0aNSmkcGd15UK/hhUSAgACnIYA=
Date:   Wed, 9 Aug 2023 16:41:28 +0000
Message-ID: <2D6A6A19-5EA2-4D2A-A15B-894DA154D616@cirrus.com>
References: <20230808172511.665787-1-james.ogletree@cirrus.com>
 <9a85bc7f-8f20-6241-beba-6d705f62e071@linaro.org>
In-Reply-To: <9a85bc7f-8f20-6241-beba-6d705f62e071@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|MN2PR19MB3904:EE_
x-ms-office365-filtering-correlation-id: 470d2b20-7a7a-4237-0f72-08db98f77a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nYh98Jhl0MofowEAI2DLeVolIQZglF+LKA6AldRZJR+ixszu8a97aZIpaUbM+DyAoE59dmPKZ/vvAZX8sEUqo6+c3sWztWsn0ZG/ip2TNYjkGtB/+26hRBcbT5PVt8iq7w5snJRXsbc6QnuI50YiseKb7vepGLRCd2IVXjlHB1vlSUf8TUpcc1z1mB9y6FzTHxuvWKGO4Smsu5pAdo1aFj1+fd2vblcr0MYbAPr+ctQQHwOAVQ2P75VEO5oLZ4acXeljZ2TIP9DzOqM4lc8gWBk5Mi1+FoAORsDCGjoi5nvHIEzdlC3/XIIylfWqauP5YHZeSBCCN+0Gq7vbEUFlb2OIj2tXtBpEkTYdrO26PL4+oH1Gj7YrJ/nObUbS6sktySZYu0C0zEgn5hE6INAyKuvfJtL8lm6XOlbnYVAra8G6RBHsqkSyQj3S+DVqwa0HLZkqzk/KkCIP0ECg9vkbg6HbpBiwNWRZJEMBUbKEe78FPzj1j8KUKqg9GG9dDl0YCxWP7tcL70gd0JgccFjjilG4bhhFioda82MutX6rSnML12pM87ktAWU//aKeQ5C91joQLhwLMXi3PTLy0QnbxSSiiKQThS8H9HtD4CXiBX5KaHCuToUr1gnR3YKYDqsEQkDwL4jhbOBbjLU+TVF1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39850400004)(396003)(346002)(376002)(186006)(451199021)(1800799006)(2616005)(71200400001)(54906003)(6916009)(4326008)(66946007)(7416002)(8936002)(8676002)(5660300002)(316002)(38070700005)(2906002)(66556008)(91956017)(66446008)(66476007)(38100700002)(76116006)(64756008)(86362001)(6512007)(478600001)(122000001)(966005)(6486002)(33656002)(41300700001)(36756003)(53546011)(26005)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkYzM3IrYnFnNmNWMVNtUmJFN0Zlb1BRSkdrVUdhRmtadTRkNXhQbFp4ajVv?=
 =?utf-8?B?bjdZSlB4ek1qaFJBeldzYWlDYklCV2Y0RVduV3JKcldRVDZLeWRoam5lTCt2?=
 =?utf-8?B?YnJ3MkJ3cjFlbDdoRkVRU3U1UUJLVmpBdVB4a2JTbk11bENmS1FXeHNwMG1E?=
 =?utf-8?B?WS9sV3IzUzJjYTVCMk5xRmZzMmdEeTVkN0szdGd2Q2J3bXJhOUpqWEZLS2JL?=
 =?utf-8?B?aERTQWd4YytnZGZXMVhZZ0x3QmZRRmRQVEpYbEk2YWJKVDlRK0ErNkFFS0Nr?=
 =?utf-8?B?UlRYUFlHd2NuQjRoM2VPcXQ1bjAwQmxmMGJ4Nnd3VXppMUlUakhJUHd5QWVO?=
 =?utf-8?B?bEZISVRjTHFuZ29lL0REeUZTZHNRWGhnM2xGUlpOK1RxOEM2K214ZXREdkNS?=
 =?utf-8?B?cVRON1lQaHZpVDBKa0cxOXpnOHJDQjNmUkpUQnZwcS9aeVBEVExMZnpDdVc5?=
 =?utf-8?B?L2drVXVZV1RSTTdWZkhjS1JjQVYwVUxLTEpoVFA1UGs2VDdHWEdQcGVzWHVo?=
 =?utf-8?B?N1pDSm1TY0l4UzNRRDMxZitBd0lSbVk5YzVIbGpTdlV4UFRlWU82VUhQT214?=
 =?utf-8?B?VDE2NVNvZVM1RmwwTENkajRHUnQ3THJnTkFRRkxFSXhlUkE4dFROWnloTC9p?=
 =?utf-8?B?Z1NMT0huQkYvakRtVWxzRGVEdEsyYldNdk5qcHd2M1hKRk1vSWJ0WWR0UlNG?=
 =?utf-8?B?cnZjNk9ONTMvMktFTzdOWjJNaWN1NXRoZU1ZR1krZ2RSNDJNMDJiRXUyT2dP?=
 =?utf-8?B?UzBWQzhTdUN1a2FCM2RzTzZOMkJZTnBjQzU2azcrN1VMcDFRMXNRNjhHVHFH?=
 =?utf-8?B?S2M2UGRESmpEWVdwUE5HVTVBSS9zQWZLci9yd09UWjJpOXNQcjl1ck5WL0J4?=
 =?utf-8?B?anlzQ3Z0Z05OUWdiVGhKQ2tGUmZWVTE4UGZ6eXdlZk91TTAzWkhmdVo0WlpC?=
 =?utf-8?B?WHQxYW1JQTR6d3FPbDhVakl0TTJpRG5YVkhDMDJNV2N1ZEd4Uzg2eVEzRXBU?=
 =?utf-8?B?QVEwVTJnQWtBUEFuenkycjFVU1RHMEdxSVdMRWcwQzI3NTZ5UUdVYVllOGJs?=
 =?utf-8?B?cHB3UjV2NThUTkdzQWRBM0Jsb3UwL3MrTDdaWm12czlLSjFEeXE3NnBkVlFm?=
 =?utf-8?B?QitqUDlQRUdGbmE0WkFKRFhwRGM5SEpDbU9PbW9NeFVyM0VuYWdRS2wydmhN?=
 =?utf-8?B?czZiRnRQbnRNNGRMU1JORFFsTjQxRld6YXV4ZjBXNUdsS0FBZkE4UDRlNzhJ?=
 =?utf-8?B?OHdkbTVCL0xsNjAzWVdOSkJqNWtGWTRlNlZkK0hldzh0MFdyR3RmNFpyL3Ro?=
 =?utf-8?B?SVpHNWNBTldlVUdVZ0RoeDBsMHJUd3RIRHBTWnVrT1p1NWhqTnRHUWg0NEtX?=
 =?utf-8?B?L0tlNXo4eXFEcEQvRThHTHRVQ0NmQUV6M2M0TXJ5OG1YcHlSSFFNVFgrSXZT?=
 =?utf-8?B?VXUrMjdrbTFIYkY2cWV1TjRNVUVnRlhQN1hXQk03N3ExZ1U0VTJCYisvSzMy?=
 =?utf-8?B?UWhwWm4zQ3poU2UvODB1ZEVLVHdURHo4emUvZy9mbTFzMmdUblpFOHpPYVdu?=
 =?utf-8?B?eVVYRkh1VmZmdnpxZTBMUmhtT2N4YXZlMlZvbEhOdjZLRmpxL0tNc0dNbUNB?=
 =?utf-8?B?Zi9aWkZsVHNVbldpWTJhaDNHdi80WFRWckpWNUw3ODJiczlCWUJBa0h6ZWdS?=
 =?utf-8?B?U0RLb05STnRGOS91WmJIN0xLelUxbWNac1lZVVY1QXRvaHh5ZHFLSGxuZHZ5?=
 =?utf-8?B?UHNTMTRhN1VrU1QrRGxoQ3hEa01ZTWpaZlRXSm54M20zZHc0N2tyTW85RUlL?=
 =?utf-8?B?ZjMyQlJ4MnBSc3loODBXZmFUcTBrS0w4eVEwNTl2bE0yYVlwdGdBM1JyLzcy?=
 =?utf-8?B?ZEhUSjc0U1ViYW5DdXBWeU4xZGhMTHk3Sk9jekpUZjFUQ3MwbEViZC9SRVQr?=
 =?utf-8?B?dksxekdYd2czam9qYXlQL3RXUzBIVnlXZHB5K0Z5RVZ0cE0xMERvaWtvTVJn?=
 =?utf-8?B?RDJUNFF5bDVtRVFpekZFaGFBMUxvSkNBL3BjbDBzdDR0R0VCamJENlp1bGh4?=
 =?utf-8?B?ZUNFNFBaV2YycmN2b2t5LzF3UGljQk5ReG8yNG9zTlNWY0xxYngrWjl5dGNG?=
 =?utf-8?B?L1ZzSWluSkd2K3NCbWdBMUxjRHQwYXBBbDl5cFNsVTdxZ1FJWjZlRzVicCsz?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A64FE3526AE9049B02190ABDBF0A1C5@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470d2b20-7a7a-4237-0f72-08db98f77a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 16:41:28.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtXN0/hVbMaXj8vCBbrAJwFc2N7NSc9aVwLRJF63AgbjZq4W0cf4GqPlC2TWVKBOc8PJysJiBNoDMbIvSTL/B80AK8EPxV6Cv0fldWWB/WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3904
X-Proofpoint-GUID: NVDZmlG5KXZRk6WQbCYelRQlaj0hOGU9
X-Proofpoint-ORIG-GUID: NVDZmlG5KXZRk6WQbCYelRQlaj0hOGU9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEF1ZyA5LCAyMDIzLCBhdCAxOjQzIEFNLCBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5
c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4gT24gMDgvMDgvMjAyMyAx
OToyNSwgSmFtZXMgT2dsZXRyZWUgd3JvdGU6DQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogSmFtZXMg
T2dsZXRyZWUgPGphbWVzLm9nbGV0cmVlQGNpcnJ1cy5jb20+DQo+PiAtLS0NCj4+IC4uLi9iaW5k
aW5ncy9pbnB1dC9jaXJydXMsY3M0MGw1MC55YW1sICAgICAgICB8IDc3ICsrKysrKysrKysrKysr
KysrKysNCj4+IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICA5ICsrKw0KPj4gMiBmaWxlcyBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspDQo+PiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2NpcnJ1
cyxjczQwbDUwLnlhbWwNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9pbnB1dC9jaXJydXMsY3M0MGw1MC55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2NpcnJ1cyxjczQwbDUwLnlhbWwNCj4+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjU0MzdjNmJlYjFiMw0KPj4gLS0t
IC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lu
cHV0L2NpcnJ1cyxjczQwbDUwLnlhbWwNCj4+IEBAIC0wLDAgKzEsNzcgQEANCj4+ICsjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlDQo+PiArJVlB
TUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaW5wdXQvY2lycnVzLGNzNDBsNTAueWFtbCpfXztJ
dyEhRFEzS2Z3SSEyaW9IaEkyaWczYXhWUkQtN01ZcXFUMUxGX2JpdFdlMWwtQi1GUURKZlVYX0Vh
VExyTG1VbnF0eUR0RVhDVkUyY05vemo3T0RBRjdmMDlKZHdtalM5YXZ5SHMxM0hpdyQgDQo+PiAr
JHNjaGVtYTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFEUTNLZndJITJpb0hoSTJpZzNheFZSRC03
TVlxcVQxTEZfYml0V2UxbC1CLUZRREpmVVhfRWFUTHJMbVVucXR5RHRFWENWRTJjTm96ajdPREFG
N2YwOUpkd21qUzlhdnllRHhSdW5BJCANCj4+ICsNCj4+ICt0aXRsZTogQ2lycnVzIExvZ2ljIENT
NDBMNTAgQWR2YW5jZWQgSGFwdGljIERyaXZlcg0KPiANCj4gRHJpdmVyIGFzICJtb3RvciI/IElm
IHllcywgdGhlbiBvay4gSWYgIkxpbnV4IERyaXZlciIgdGhlbiBub3QuDQoNClRoZSBmb3JtZXIs
IHNvIGtlZXBpbmcgYXMtaXMuDQoNCj4gDQo+PiArDQo+PiArICBjaXJydXMsZXh0ZXJuYWwtYm9v
c3Q6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEJ5cGFzcyB0aGUgQ1M0MEw1MCBi
b29zdCBjb252ZXJ0ZXIuDQo+PiArDQo+PiArICAgICAgVGhlIGFtcGxpZmllciBvbiBDUzQwTDUw
IGNhbiBiZSBwb3dlcmVkIGludGVybmFsbHkgdGhyb3VnaCB0aGUgYm9vc3QNCj4+ICsgICAgICBj
b252ZXJ0ZXIsIG9yIGVsc2UgY2FuIGJlIHBvd2VyZWQgdXNpbmcgYW4gZXh0ZXJuYWwgc3VwcGx5
LiBJZiBhbg0KPj4gKyAgICAgIGV4dGVybmFsIFZBIHN1cHBseSBpcyB1c2VkLCB0aGUgYm9vc3Qg
Y29udmVydGVyIG11c3QgYmUgYnlwYXNzZWQuDQo+PiArICAgIHR5cGU6IGJvb2xlYW4NCj4gDQo+
IElzbid0IHRoaXMgcHJvcGVydHkgdGhlbiBjb25mbGljdGluZyB3aXRoIHZhLXN1cHBseT8NCg0K
4oCcVkEiIHdhcyBpbnRlbmRlZCB0byBtZWFuIGFtcGxpZmllciB2b2x0YWdlLCBub3QgYW5hbG9n
IHZvbHRhZ2UuIEkgd2lsbCByZW1vdmUg4oCcVkEiIHRvIGZpeCB0aGUgYW1iaWd1aXR5LiANCg0K
QmVzdCwNCg0KSmFtZXMgT2dsZXRyZWUNCg0KDQo=
