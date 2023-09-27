Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892C7B01B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjI0KUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjI0KU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:20:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C100B59EE;
        Wed, 27 Sep 2023 03:20:24 -0700 (PDT)
X-UUID: 74cb8fb45d1f11eea33bb35ae8d461a2-20230927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3v91nSc3F2fmZXSruPV2wMcFWpe6uHWgbycCe4dvG3s=;
        b=bPJ5utybxbnp9m5N6i4CG0c5cokot3VzJNmChzUms9xegtngqyxUhAfEtb33oqG4BhFarZuDsVA7UVZ/q3x59G3C6lZAPTlf2czpdYj3pdVYBFdJQzE/D3rYOCgTZXreXpq412j4AysaoJgxNO0DQAHRjMJMUJB64UStvq7ciI4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2278264f-767a-4762-a51c-50bd52e0a3ae,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:47a855bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 74cb8fb45d1f11eea33bb35ae8d461a2-20230927
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1039699654; Wed, 27 Sep 2023 18:20:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Sep 2023 18:20:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Sep 2023 18:20:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVgTyeiSvmOfGlJCaUb0Rjvg4KajRzo+FyL8LaLlAf0tZWP4S3DBGN1nmWq//nhByyebbm3Izj0JS/0JNEhZXdxTT7mvZv0wNsePh6t84S/ttU6vHJRRvlx3by6uDxvbHZNalksiCdhYUi2uH35rzZu1kxgwLMiYgMdvsnv/4kNdH5APBjVkEFoPR4mspmmSItYacOem2qIMZ2a/WKwc5nQ0ncoQxLaMmgbwGyqVteL2Qw9ZF7pGnqRECCNMzoKRosaNKvFNI63IbrgFw+ekcXOGHHRez4/Amwd8tvoSGtck/pddUevgOeULhCyj0xwuQ46d3W9IzFeWk3mQfLK0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v91nSc3F2fmZXSruPV2wMcFWpe6uHWgbycCe4dvG3s=;
 b=i+kAoJ4n1Ow+edrrcVD4LQbicDcSzKgATtBnz4suI8bq8YVuKuMEY7um8RuNQNH0VEpRvtHlW6hrzyEhuhLX+a81oUQSwVpSBAGmvNdg7GDtE9qmDHiqHiAMQIi0fIym0KRXJ3IObzHkgXro9fsplXU0ALXENp/igMV2v7Wrm9lf+WtV5Url/q01ooUyv5ryHheWIRSrrUa8SdSaR8f39eqnN4MQ/b4QvrfEOHCa6SlChj+0txEMT1KALtmHCtPB1Dnx3HgFXJosNOh5sXHZsyfKZO25GXllFNbPdUn/uG+2ehvkH02zydkBXjxkyGFrXk/dGmxJgg7EodVe7q+Ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v91nSc3F2fmZXSruPV2wMcFWpe6uHWgbycCe4dvG3s=;
 b=socdDyYjl0dH41BTP7sbhH2ahOr3EjB0tzOkZhoiBxDJbeGbXctf/E6xgfzOQI5M2MKxTRoNV754SlqG0E4N9Eg1cq+oDoK6m1UVmriw5G2w+2kdz1z6LuVvZZCM2bGmlQOKby0xFLTiClQeI7wdaZC7VShIXfbW2DttaR0UHGo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7141.apcprd03.prod.outlook.com (2603:1096:101:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 10:20:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 10:20:12 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND PATCH v6 11/20] drm/mediatek: Rename
 OVL_ADAPTOR_TYPE_RDMA
Thread-Topic: [RESEND PATCH v6 11/20] drm/mediatek: Rename
 OVL_ADAPTOR_TYPE_RDMA
Thread-Index: AQHZ5IOtFbVN3hllBkiE7eXMGllSsLAuj12A
Date:   Wed, 27 Sep 2023 10:20:12 +0000
Message-ID: <87aea1ca8e220bef72232486b647397e6ac267ff.camel@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
         <20230911074233.31556-12-shawn.sung@mediatek.com>
In-Reply-To: <20230911074233.31556-12-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7141:EE_
x-ms-office365-filtering-correlation-id: e41839e3-68a5-402b-86c8-08dbbf435582
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8YiZ/VAIal7pUqy7HlAlZIB6K6B7bphMGyTeFLI/L+6eX6BaMAWrEuQXbNQdRNP84o2YCWf12oKFg5/+tBZ7xlE5FKG8MkSKi6r75yX6yDKLh5DlZ2AlFNTZ3CMZfDTHj3rBCquAQhTENJ2xIrpw1W2QR8NVAGPGBEYI3yCfEaAsDqPwkR5Oiobzf+4RLQ3UGlEfbfIKwzy1UoHnTPvPxDTB7MdfAecWnXXGKYZybA3Ut3UGG6JeS2lx0cEvMFaoWkUmFfMYPgjThEzewrJxDe0tR0Sge+PO6/AUZqSqWkrHxHUB0I2LB8zLs5oQ7VKr+KoRHJQColLWB/O5HitQh2ZDwSz7gqxp8kEmeTgazuK/ITtCJD/Xrk41TCcEJVzrMSeE8HNu+5+iA4FYpPJsihqiLFep3y7aosoo3W8z6CO0iOxui3Lf+o2YsG/yAWbnu7WpLqVug0h058QUoqrVZYrGM58jyxQEAcwOjEK1QV4OTDUK0YNqFwFlq4k+RzP8KO7Sua+8KoBZua/J02WcArIQisnqOKVdOP710pOyVBCKGJ/Hj3dt9HIdrFKZFD0fEfKNYfXdBy22u+V/Qgk+5wnKgmigtaotf4uEVsr4BsDPbLOddyGqA6OfPlUBJjj0zXxwd7cZPkcywc/0TltDLSlPIUXahqBGJKc6VMORn4Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(6486002)(478600001)(6512007)(110136005)(64756008)(66556008)(4326008)(66446008)(66946007)(54906003)(66476007)(316002)(76116006)(41300700001)(8676002)(2616005)(8936002)(6506007)(2906002)(26005)(5660300002)(83380400001)(7416002)(71200400001)(86362001)(38100700002)(36756003)(122000001)(38070700005)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2xNZ0sxQXYrYVczMzQ4SldCZDRJL2l6TytUUGZHallkTmNjaURqSnRVVllL?=
 =?utf-8?B?b0xGdVJuV1daTUJyZkMvM1k4VWRCV2kzcUllVS8zMU9BWjNMVjlpZHVTL2JQ?=
 =?utf-8?B?VEg4WFZJcGFsTUV5a0l2c1hoYW5ETzFLTXF2NUZ0V1ZpOWtueGpWTDdtWTc1?=
 =?utf-8?B?K245WG82OGVjeHpBUDJyR0dFVmFHSlNYcjBTUEttVU45UlZuQ01yOG1hQ1B1?=
 =?utf-8?B?dGlPaWxZU215V2dJUVlSRDgxS3JpZ015YWxLVktaMnN3V1QxUms1TDBFTjBE?=
 =?utf-8?B?NkM0cUlIVFhLZHFoWEUrSDhpNmZETk1lOWZYdnpWSmNYeWYxOGROU2I3a3Y4?=
 =?utf-8?B?M015NE4vaEVaQ2QydmRJNkorc01GRmRlb29iamJEbTNESk1QclQ5OWRHQnJ4?=
 =?utf-8?B?VnZWbmRzdHZzaS93NmFQQ1RuQUc3RWwycHJDNVlOVnU1VWhKUjVlTUIrUW1L?=
 =?utf-8?B?R0JKNVBwWWVWVHN6OEoyTW9MV0lRUTErejFKWm8rNFJ3SWFEb2hDTG9zTnR0?=
 =?utf-8?B?NkdoQ2Z3Ym9ETlhzb1IwdFk4QVdrWWttcEx3cXBsU0FlTFVpdnZiOU0vZUZG?=
 =?utf-8?B?M045eDBJTWVNUWVySWNkQzZha2hLa3hCT2prMit3VFBqd3lYZUJnMlFNMTZ0?=
 =?utf-8?B?a2RTZ2lzZitVOFNkeUxsMnhISWd0Q0dkR2p0eUc3Y0k1c3JWVU8xT1dML0ZX?=
 =?utf-8?B?emxyY053ZDFvYjIrbnBCYjVBdnJwWlpuOWJ3Z1hjMXhZcTVUc2NjWHFEaG8x?=
 =?utf-8?B?a0Y3SElQdERIenZiMlhUdC9ScHVCdHNrWVNZVGh6SllnZURrdm5NTGd5YkY2?=
 =?utf-8?B?RDNXelpKaVVPMUM3Kzd4bERueXd5NU43NWZYNjVZMjZHOGZIR0JBTEFSQ0ZV?=
 =?utf-8?B?c21kaTZtUmFDSTVBV2JkNGJxczZUYkcvOEp4dzh4YktlL3VJKzdwb2hVQXV6?=
 =?utf-8?B?TFd2ZEp3WkpZRjNKWHJhMUFtVjljRFBiRGJnQzl5akdpOFRsRDh0N0RjUThC?=
 =?utf-8?B?UXV2S3dQbUJKWnFyNHlaRHNXMTlBZlRVZnRrN1NvV3kvQWQzemxmL2xua1Fr?=
 =?utf-8?B?ZkNnN2JrZE8zYk44SitBenNGOWNUU0NmQ3RwRk5CZHo0SkhINzFKVGFRNlpY?=
 =?utf-8?B?ckI3a2VOWG1wOFRybW4xK0dvOFROREFyLzg4NVJTQ0RSUUUzSGJSMlVaU0wz?=
 =?utf-8?B?ZnFpRnNJczRIeHlXSHhHdUZmQzVzNFdjTGUrMCtxSzU2Z3g0eFIwZ1k0aTFN?=
 =?utf-8?B?UWJ5MW5DRHlCTi9IWktxQ2FabzloU0xuRlY1bGtxNXpNVFBQWUt1YVZXellU?=
 =?utf-8?B?Mnp4RzhPNGErTUZGYm1yNlVuYVo0dE5DYTJacFpJMjVXais0SFpyY1ZYV2ZK?=
 =?utf-8?B?eitCMWMxVjF2U2JTMU5Ka0xSVHk5VTRiVmZtbnI4bzRybFFuUEIrNnJ0RGZN?=
 =?utf-8?B?V0tDSU9sV0FzMk4ySERGTTZMMU9ObWFFL2RkSUcwK3IvbnFOOUZ3N09GMTRk?=
 =?utf-8?B?ai9VdjN3b3NrQ3QxNXZyTXV0VExuK1RGSllEQURsZyt3dENLOEFMVmRVUnFj?=
 =?utf-8?B?Zzh5dnZKSTUyMzhEejJ0Y2hBa1l1SngzQnN3dFRVcmI5NGVxaW1rRFNRZkpW?=
 =?utf-8?B?TFRHWDY3c1IvaUVPTWV5ZmJmNFhnV096VGl1c0luNlJWMEdSbnRRUGhjb0VP?=
 =?utf-8?B?dXhEeksyZGFmaitsVEVVbHJ1M09hSjNKb2xFL0RYT1hYc3d2U0FRQ0orREN1?=
 =?utf-8?B?Y3Z3bE1tK0gyZkRDV3lYU21tczFuOFF3Z2VMbGZsbHU2N29rWEkvOEVCZjha?=
 =?utf-8?B?UG4zNmhMbHY1K1p2b1g1NXJ0b25XYll1R3l1a2NJZzZ3dlFBNVlhTnJ3V0xp?=
 =?utf-8?B?NE91dEZIYWVONjNQTk9kM3FDTGVTalRvR2RDc2I5ajBpUVFFa1Q1NDB1UGZM?=
 =?utf-8?B?cjJvSEVTbFliblFzU1pEUGE1amtUNEpyems0TGlROWlFeGZJMHZPcit3a3pQ?=
 =?utf-8?B?elZUajFMaVA3RHRJQld2SE5SQ29vZjlxSXdpQ2RWTjArWGQ5U0tRM2FNM1BX?=
 =?utf-8?B?QytwZzdIc21pc2hvVkxxejVaL2xtQncrKzZHMjVYVmU4bzRPTHlodHlnRmVz?=
 =?utf-8?Q?Y4c3j7VpMudrPa0AnaPvQWa2Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07804C5DAFCD0844AA42882D97562337@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41839e3-68a5-402b-86c8-08dbbf435582
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:20:12.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsZoWJl4YUm/4Nu7zGqUbL50Pe17k987TQrq1rJq7bdNR1JO2UY5x5a64zo1S4Ek5MGBWbsWwTJ2sBZQt7325Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTEgYXQgMTU6NDIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFJlbmFtZSBPVkxfQURBUFRPUl9UWVBFX1JETUEgdG8g
T1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQQ0KPiB0byBhbGlnbiB0aGUgbmFtaW5nIHJ1bGUgb2Yg
bXRrX292bF9hZGFwdG9yX2NvbXBfaWQuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVk
aWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3
bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICAuLi4vZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmxfYWRhcHRvci5jICAgfCAyMiArKysrKysrKystLS0tLS0NCj4gLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4g
aW5kZXggNmJmNjM2Nzg1M2ZiLi4xMTRlZGVkODE3N2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IEBAIC0yNyw3ICsyNyw3
IEBADQo+ICAjZGVmaW5lIE1US19PVkxfQURBUFRPUl9MQVlFUl9OVU0gNA0KPiANCj4gIGVudW0g
bXRrX292bF9hZGFwdG9yX2NvbXBfdHlwZSB7DQo+IC0JT1ZMX0FEQVBUT1JfVFlQRV9SRE1BID0g
MCwNCj4gKwlPVkxfQURBUFRPUl9UWVBFX01EUF9SRE1BID0gMCwNCj4gIAlPVkxfQURBUFRPUl9U
WVBFX01FUkdFLA0KPiAgCU9WTF9BREFQVE9SX1RZUEVfRVRIRFIsDQo+ICAJT1ZMX0FEQVBUT1Jf
VFlQRV9OVU0sDQo+IEBAIC02MiwyMCArNjIsMjAgQEAgc3RydWN0IG10a19kaXNwX292bF9hZGFw
dG9yIHsNCj4gIH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBwcml2YXRlX2Nv
bXBfc3RlbVtPVkxfQURBUFRPUl9UWVBFX05VTV0gPQ0KPiB7DQo+IC0JW09WTF9BREFQVE9SX1RZ
UEVfUkRNQV0JCT0gInZkbzEtcmRtYSIsDQo+ICsJW09WTF9BREFQVE9SX1RZUEVfTURQX1JETUFd
CT0gInZkbzEtcmRtYSIsDQo+ICAJW09WTF9BREFQVE9SX1RZUEVfTUVSR0VdCT0gIm1lcmdlIiwN
Cj4gIAlbT1ZMX0FEQVBUT1JfVFlQRV9FVEhEUl0JPSAiZXRoZHIiLA0KPiAgfTsNCj4gDQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IG92bF9hZGFwdG9yX2NvbXBfbWF0Y2gNCj4gY29tcF9tYXRjaGVz
W09WTF9BREFQVE9SX0lEX01BWF0gPSB7DQo+IC0JW09WTF9BREFQVE9SX01EUF9SRE1BMF0JPSB7
IE9WTF9BREFQVE9SX1RZUEVfUkRNQSwgMCB9LA0KPiAtCVtPVkxfQURBUFRPUl9NRFBfUkRNQTFd
CT0geyBPVkxfQURBUFRPUl9UWVBFX1JETUEsIDEgfSwNCj4gLQlbT1ZMX0FEQVBUT1JfTURQX1JE
TUEyXQk9IHsgT1ZMX0FEQVBUT1JfVFlQRV9SRE1BLCAyIH0sDQo+IC0JW09WTF9BREFQVE9SX01E
UF9SRE1BM10JPSB7IE9WTF9BREFQVE9SX1RZUEVfUkRNQSwgMyB9LA0KPiAtCVtPVkxfQURBUFRP
Ul9NRFBfUkRNQTRdCT0geyBPVkxfQURBUFRPUl9UWVBFX1JETUEsIDQgfSwNCj4gLQlbT1ZMX0FE
QVBUT1JfTURQX1JETUE1XQk9IHsgT1ZMX0FEQVBUT1JfVFlQRV9SRE1BLCA1IH0sDQo+IC0JW09W
TF9BREFQVE9SX01EUF9SRE1BNl0JPSB7IE9WTF9BREFQVE9SX1RZUEVfUkRNQSwgNiB9LA0KPiAt
CVtPVkxfQURBUFRPUl9NRFBfUkRNQTddCT0geyBPVkxfQURBUFRPUl9UWVBFX1JETUEsIDcgfSwN
Cj4gKwlbT1ZMX0FEQVBUT1JfTURQX1JETUEwXQk9IHsgT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRN
QSwgMCB9LA0KPiArCVtPVkxfQURBUFRPUl9NRFBfUkRNQTFdCT0geyBPVkxfQURBUFRPUl9UWVBF
X01EUF9SRE1BLCAxIH0sDQo+ICsJW09WTF9BREFQVE9SX01EUF9SRE1BMl0JPSB7IE9WTF9BREFQ
VE9SX1RZUEVfTURQX1JETUEsIDIgfSwNCj4gKwlbT1ZMX0FEQVBUT1JfTURQX1JETUEzXQk9IHsg
T1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQSwgMyB9LA0KPiArCVtPVkxfQURBUFRPUl9NRFBfUkRN
QTRdCT0geyBPVkxfQURBUFRPUl9UWVBFX01EUF9SRE1BLCA0IH0sDQo+ICsJW09WTF9BREFQVE9S
X01EUF9SRE1BNV0JPSB7IE9WTF9BREFQVE9SX1RZUEVfTURQX1JETUEsIDUgfSwNCj4gKwlbT1ZM
X0FEQVBUT1JfTURQX1JETUE2XQk9IHsgT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQSwgNiB9LA0K
PiArCVtPVkxfQURBUFRPUl9NRFBfUkRNQTddCT0geyBPVkxfQURBUFRPUl9UWVBFX01EUF9SRE1B
LCA3IH0sDQo+ICAJW09WTF9BREFQVE9SX01FUkdFMF0JPSB7IE9WTF9BREFQVE9SX1RZUEVfTUVS
R0UsIDEgfSwNCj4gIAlbT1ZMX0FEQVBUT1JfTUVSR0UxXQk9IHsgT1ZMX0FEQVBUT1JfVFlQRV9N
RVJHRSwgMiB9LA0KPiAgCVtPVkxfQURBUFRPUl9NRVJHRTJdCT0geyBPVkxfQURBUFRPUl9UWVBF
X01FUkdFLCAzIH0sDQo+IEBAIC0zODgsNyArMzg4LDcgQEAgc3RhdGljIGludCBvdmxfYWRhcHRv
cl9jb21wX2dldF9pZChzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9kZSAq
bm9kZSwNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19vdmxfYWRhcHRv
cl9jb21wX2R0X2lkc1tdID0gew0KPiAgCXsNCj4gIAkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTk1LXZkbzEtcmRtYSIsDQo+IC0JCS5kYXRhID0gKHZvaWQgKilPVkxfQURBUFRPUl9UWVBF
X1JETUEsDQo+ICsJCS5kYXRhID0gKHZvaWQgKilPVkxfQURBUFRPUl9UWVBFX01EUF9SRE1BLA0K
PiAgCX0sIHsNCj4gIAkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWRpc3AtbWVyZ2Ui
LA0KPiAgCQkuZGF0YSA9ICh2b2lkICopT1ZMX0FEQVBUT1JfVFlQRV9NRVJHRSwNCj4gLS0NCj4g
Mi4xOC4wDQo+IA0K
