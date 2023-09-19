Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDBC7A5712
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjISBns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjISBnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:43:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B085994;
        Mon, 18 Sep 2023 18:43:40 -0700 (PDT)
X-UUID: f1c19b96568d11eea33bb35ae8d461a2-20230919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=E9965dRmosJoiueByMK637R+dhGrsk277CbuNAsfcJ0=;
        b=lLuveQbei3CG2BM7TPOp6VkOD/kuux2wvKY9mMCNMNqw/SnnrUGgXcrm72Ekgnh06OvPEvE/SPYDCqh6+2H9GbbQ07p9v1Tpte3YMXOuIM7ef0AgcKfwnP9XfKRl+IjZOxexIOYYg+lxICoEkNdahoEL1E1DtfBfVLhZlw9CNXI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f873294a-563b-4023-91e4-cd0fcb573658,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:0ad78a4,CLOUDID:f844fdbe-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f1c19b96568d11eea33bb35ae8d461a2-20230919
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 659554160; Tue, 19 Sep 2023 09:43:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Sep 2023 09:43:33 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Sep 2023 09:43:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=empZNRmnlnLbbCLDbi6zaLiLnKzQ8/0Zz2b8/dQlUJregnK/A5StVfOiGqtd41pbK6IkHcShDyd78I2/JFd7bIHv7dXI3kB968Q5qWGWleze2U6U+KxiHt/YHqiReeIWiElStACc0J9flmNFclQiNgBYbLKqabMWyLnHHFIJp6Te6CRg1WzaKyGvwa09LZmSMbAtkOco1i67jSASmLmKXYjIRDwwDQ9V8KO0MTlufn6/lHNMI/AcgAV6hQeCabCzceoaNp1JCIZx8g8sAJopH/Gvq5QqpYPLbzriDXRQHYB8o5ypdPOCN6+x+0jczQ+24F0VY5HNOT1Hz8OD6WI1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9965dRmosJoiueByMK637R+dhGrsk277CbuNAsfcJ0=;
 b=RiwZT2sR/khO7U1GrB6kz8ecSpdzlpiIeVX1M4ppqkAFx7A9h1EoUvcz/WJb0Jv1MHn5uTNudEiyAAF5S1C7p6Pvxoe990NJbiFmGYUY/AY8kSFa4F0zJYxVmHbcAo3SL7vfu0FP7OwDFSrTyMp9qGuDIaauF6y1+AOSYl0Mo7VHGdLEPUDSVnTkBCij90HkxhCWsNjba4j2gMLEHVthn3XOVBd+xVif92/rd1tdAGJuxPDkrHpkQe72LKnCmwGpbpu8IGUuQZEa6aEWY9XYrHPEAohhadUTlwsMHbDVFX217QNw65np/pD4lzjp5NTI6Dx1uQNiWfWi0MprBAHtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9965dRmosJoiueByMK637R+dhGrsk277CbuNAsfcJ0=;
 b=nZSGnoZw52AWFiiAzyzFAKmcvYNwinryqG+bsTAbMFdCWK077emLjfMx/LSsuVJ8yUaW1dLOJytMWHGL/yT1kjA8Yd946cq5XUEUlufBSITM+15VWRPZ8RnxJgcuR7XUsUoZE2qtnpvqB9gaFTbBOP4LYPQlzFwhfMFHPHHeMEI=
Received: from KL1PR0302MB5347.apcprd03.prod.outlook.com (2603:1096:820:4a::9)
 by TYSPR03MB8131.apcprd03.prod.outlook.com (2603:1096:400:471::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 01:43:31 +0000
Received: from KL1PR0302MB5347.apcprd03.prod.outlook.com
 ([fe80::645f:bf16:124e:cf31]) by KL1PR0302MB5347.apcprd03.prod.outlook.com
 ([fe80::645f:bf16:124e:cf31%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 01:43:30 +0000
From:   =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: mediatek: add mt8188 svs
 dt-bindings
Thread-Topic: [PATCH v2 1/2] dt-bindings: soc: mediatek: add mt8188 svs
 dt-bindings
Thread-Index: AQHZ6d791BRnTIV4okC+4NK9xElGibAggTEAgADgcwA=
Date:   Tue, 19 Sep 2023 01:43:30 +0000
Message-ID: <7eee2929faeaaaabe38df8222856e2102f09501f.camel@mediatek.com>
References: <20230918031835.12352-1-chun-jen.tseng@mediatek.com>
         <20230918031835.12352-2-chun-jen.tseng@mediatek.com>
         <d70ae419-0038-c9da-8e4a-5ce90fe61f79@linaro.org>
In-Reply-To: <d70ae419-0038-c9da-8e4a-5ce90fe61f79@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0302MB5347:EE_|TYSPR03MB8131:EE_
x-ms-office365-filtering-correlation-id: 95e57320-5503-49a1-a8fb-08dbb8b1d40a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwWC9B7wHNH4ktTIy1dGxylhIfuLt536gsB32ibQOoWiqUFoZ+vEtRr9Xv26+0NaiCCk2w5VjMpFBg2APRWqWV/JZy4ko/61qcC25CLibKOtWD8dAzjhp3VeXtBkEO6KctHsRTrsggfiagWR5uN6+lhD+Pi4PzHc4JgrpbJ7QCIHnKvTfmWJ8qcYcrf2pxhME/V4u1oPKaWDMlKER5pS+oEjVo9rxLslYgTQJ7yt6RlkjzY+L7+uQ9LJb92UpzAFhge3hcRUnWn70suDTHdOqpaZ/pcWVw6Tw94tO39zxSHbz6bbTLEsS+qayRvvQbErZVUxwi1khMSWH2GpuPoo3LLXfrJtEOE1wftpdYiL/PZC6ShqXhl9fulp2IAPDp2rvUqp3mFnqewep6xKvsShcyypAQHfIRIDd25hsUG0qd4c2qhJaR790pMIh2AYU7w5NpjqUWJtiOgRDo0P9Yf1Dws1lDnP9qgWxlpPngWuSQk2btfbXD3QbfQj0kDXRWyildTUsmhfOTaQxKB6HlJfTNJPrkisoqn5dHc+HM1BCCtOEVJLBjfmIC3m0zoGk7qMMj6mixO934NUCY9x45GYLBWtobkZ6XsjID02VUBL6W0H7Ej6u6+S1zsNVTbIhL5QXh1GDyJ09RFTUe6TYwqFMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0302MB5347.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199024)(186009)(1800799009)(6506007)(6486002)(53546011)(38100700002)(85182001)(36756003)(122000001)(38070700005)(71200400001)(86362001)(2616005)(107886003)(26005)(2906002)(966005)(6512007)(478600001)(83380400001)(4326008)(5660300002)(110136005)(41300700001)(8676002)(91956017)(8936002)(76116006)(7416002)(66476007)(316002)(54906003)(64756008)(66946007)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2NCTm80Wk42WmFsT29DQTlOR2UwUXNicXlQQUJ3dzFud2pHMGRGb0hCRldU?=
 =?utf-8?B?a0ttb2ZsTUQ4czBFTG0rNmFoaGw2bXcwU2RYZ3hXL0FuaHhCaHJDS1dUc2VU?=
 =?utf-8?B?UlNLeHJtdDMwWFJIdjZjbVljWllDOTVIUTdsT0tFcUZ0d2FZY1hvcGV4cFdF?=
 =?utf-8?B?dnV1NHNTdnlUUHBMUlM5cDRFajhtdWtRS1l0NjFQUVpzVjl3S1gxK1ErQmRv?=
 =?utf-8?B?RmtUa1A5WDUxN0s5RHBOR1ErOCsxZWpyL3Y2eGxpVjhEeklXSWZHbEx0SXJV?=
 =?utf-8?B?QzRJZUZ6akJJdGdWRloyRFliTVZHSUowOVBXQ0pEcTN6Z21lcWZyb2lHK3N5?=
 =?utf-8?B?N0h5dnJZZXUxUmkxWG40RVZXdkoxU09NMldQS0p2akI0L0dVYXVmSXRvbkFk?=
 =?utf-8?B?c2lyMjNFSjAyQ1F4bjdUOTZHdWYwUmc4MTN6b3NZTUlnYlpheUN4NlM3N3FR?=
 =?utf-8?B?NGswc0tWSE5OU3VyUzJYRWc2dUduL2N1TENqZFJVYUxOSUl2ckhLcjcwNndO?=
 =?utf-8?B?LytjQ2Zic3d0NmUveXEvVkErcUFSNDc1UEFxQlk5aGQ3QjZkOGY0TThBQU4x?=
 =?utf-8?B?SDhpeG0zWFY0MW5QMWszL3NMeFE1N05TZGRUUXgwcjVDRlA2RmIxMEpiUmlC?=
 =?utf-8?B?WDh4VHpGV01tZTRuWFNDZnR5aXJ2alJzay96UmVHUk1IMmZ3eGRQWUhsV1hy?=
 =?utf-8?B?YzYzQVQ3YmJPQXljOTh4cnpRN3ZHNWhwZWtCNVFnemhFS2pnSUN0MnR4aHRY?=
 =?utf-8?B?MmJhRzFnSGpnbnVwZkphcW1KZ2xGMzdEbi9hZWZVWHBhMHpxNURDYm52alhl?=
 =?utf-8?B?ZWhvNy9UYkNEVTBidDNPOFhMNkh1SUZtcXdPczdwNnQ2Tkthcm42UDZIRld1?=
 =?utf-8?B?bTljMm5BTkpaa1VvK3J0U2R0dnVReWZKUDEzQ1d2QW5xbWY2OVFWZDBMVUdF?=
 =?utf-8?B?VXNtUHZSMkM3ZUcxMzBBeXlpL1N0QlNQN3hFc0VHSjJoWWNUanh2YjJLbmx1?=
 =?utf-8?B?L2s0ZXVxWDhTeVRpZGJObVp6c3lUYTZodXNJcjF2c085d2oreTZlekdoeEJh?=
 =?utf-8?B?VlJpMFM4TjcyM2JPN3RoMFpGTlU5V2tuRzc3dzd5ZTh0a3hiM0lXd2o0M0p6?=
 =?utf-8?B?QXdoSU5BSjlRcmt6TVZHRWp5d3o1QnIxbTdNOTlnTzlpajc3bkViUFd3bjUx?=
 =?utf-8?B?a1hhTDlCSXl0andhQWtDZ2kwbE1sTFFrRkFpZUllUXVwUnZSam5ZZ0EyNmkr?=
 =?utf-8?B?bnpQb2NLZmFLSHV2bnB5NXFOdHkzY1I4VzlDZDJMUGJmcE9HRXU5TVQxK2wr?=
 =?utf-8?B?U1NUUGFhVGJXODBMMG1yeTdWRExXU3VRY2locHJHZTFGb05oRWlvQ2E4eEJv?=
 =?utf-8?B?aHBuRlBIZUd1RnkxNGVnbWN1a0RjMGlNOW1XM29TaTIxT25qeVRRYi9VV056?=
 =?utf-8?B?VFZ2Vlk5RDNnUEx3eFY4a1Vqc3A3YzVQOVJxV1ZaTG9ONlBsckdzZGgvYzRi?=
 =?utf-8?B?WXFTNTdQZW90d28yZTBvNDlCbUd1Nm1EY3ArVkpyQ0xYenh2cDJtT1FwS2dD?=
 =?utf-8?B?RWJzZnlOMk9hZEp6UTVVYUxtdElJeVdpaG5pRUFudm5pbE1BYUdqOXNsOFBM?=
 =?utf-8?B?akRUN2kvVlQzMGwyRFJrYzNxb0x5RExna1YyM1RoRFpRR2YyY3BIaGt1a1dX?=
 =?utf-8?B?UkxHb0lHTzhYZG9PWjZiZUdod0M0dlhIMnRDZUpZeWFERmlHMjJGVUFtM2lv?=
 =?utf-8?B?MnlSNWpLYTBudkxHTFNXK0NHWG5jNk5jUFVra1FCZ2gycm9DaEVVaitqV25J?=
 =?utf-8?B?K0ZaREFFSjg4ZSt3dmhCbnYvRFVMNjJrZFNrM0IwcUR2Zm02bGZqRzFRdXg1?=
 =?utf-8?B?UDh2cVB5eWlhTjVtYUx5Rk0weGFYNFA3RnNiV2ZoYWtJc3d2Q25kRDdrektl?=
 =?utf-8?B?YitNVGlueGxLell5cGtlenhVa2NFU1pCZmVZYjNzVStRS1M5c0xIMzh6SHZX?=
 =?utf-8?B?d2ptaUN6eEJvMnBJYnUxOEhqZE5kd3ZJN2FaVHdUaU84VHR3M2xrVkRNK0Q4?=
 =?utf-8?B?dEFXc2VyNGgxUndZVXJMbEtRNk44SmtHdllUditKa1BicmpESTlva281dlRL?=
 =?utf-8?B?VGUwaHRmRjdCcnFOUjU2YzdpR2dkWWdxQnpkN3B4WldZK3R6UjM5TmVxQlQ5?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC128CB0FD6D054ABCC4296B24AEED14@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0302MB5347.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e57320-5503-49a1-a8fb-08dbb8b1d40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 01:43:30.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHVeuNb+kORcYIFQ8HKStv590Vtirp3DTFqTZnz1pToKoqbYHgPyfOARrWB+3KFchpuCjnCjPTgNDAAL5aQe22xqk+DsQXrbi5at9m1iNzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDE0OjIwICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE4LzA5LzIwMjMgMDU6MTgsIE1hcmsgVHNlbmcgd3Jv
dGU6DQo+ID4gQWRkIG10ODE4OCBzdnMgY29tcGF0aWJsZSBpbiBkdC1iaW5kaW5ncy4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJrIFRzZW5nIDxjaHVuLWplbi50c2VuZ0BtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+IA0KPiBUaGlzIGlzIGEgZnJpZW5kbHkgcmVtaW5kZXIgZHVyaW5nIHRo
ZSByZXZpZXcgcHJvY2Vzcy4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgeW91IHJlY2VpdmVkIGEgdGFn
IGFuZCBmb3Jnb3QgdG8gYWRkIGl0Lg0KPiANCj4gSWYgeW91IGRvIG5vdCBrbm93IHRoZSBwcm9j
ZXNzLCBoZXJlIGlzIGEgc2hvcnQgZXhwbGFuYXRpb246DQo+IFBsZWFzZSBhZGQgQWNrZWQtYnkv
UmV2aWV3ZWQtYnkvVGVzdGVkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldw0KPiB2ZXJzaW9ucywg
dW5kZXIgb3IgYWJvdmUgeW91ciBTaWduZWQtb2ZmLWJ5IHRhZy4gVGFnIGlzICJyZWNlaXZlZCIs
DQo+IHdoZW4NCj4gcHJvdmlkZWQgaW4gYSBtZXNzYWdlIHJlcGxpZWQgdG8geW91IG9uIHRoZSBt
YWlsaW5nIGxpc3QuIFRvb2xzIGxpa2UNCj4gYjQNCj4gY2FuIGhlbHAgaGVyZS4gSG93ZXZlciwg
dGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0bw0KPiBhZGQNCj4gdGhl
IHRhZ3MuIFRoZSB1cHN0cmVhbSBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBmb3IgdGFncyByZWNl
aXZlZCBvbg0KPiB0aGUNCj4gdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiANCj4gDQpodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC92Ni41LXJjMy9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9j
ZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QjTDU3Nw0KPiANCj4gSWYgYSB0YWcgd2FzIG5vdCBh
ZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQo+IA0K
VGhhbmtzIHlvdXIga2luZGx5IHJlbWluZCBtZS4NCkkgd2lsbCByZXNlbmQgcGF0Y2ggYWdhaW4u
DQoNCkJScywNCg0KTWFyayBUc2VuZw0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiAN
Cg==
