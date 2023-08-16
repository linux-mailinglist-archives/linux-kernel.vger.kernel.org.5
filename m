Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1207E77DB08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbjHPHRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbjHPHRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:17:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE91F212E;
        Wed, 16 Aug 2023 00:17:34 -0700 (PDT)
X-UUID: f545c4843c0411ee9cb5633481061a41-20230816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BwsFW1C8Oi/7PAfzuxY9IMlgXLA43CBcKG86Qkh542M=;
        b=Bnq+U9ojyhOAl00VxgPzKylER50pfNni+MSikKGV3n+N9xRyAZrrDQNmA9nxsUT/KcSuRC8HbIZox4iBM+qWm+/Magkdo0+/WQcBL+Ni7fEHv9eUNYg/n6EJTkQ6wMSnLHvbHPy74ijAwV+hGvRi8kvBNQPtUdLOvHOh1gjx8DQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:aab88898-f30d-41de-b8ef-47fa66a0b43d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:4ec295ee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f545c4843c0411ee9cb5633481061a41-20230816
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1436013030; Wed, 16 Aug 2023 15:17:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 16 Aug 2023 15:17:27 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 16 Aug 2023 15:17:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9hzouHZUEcnwaeu55MZ/2lssZSCUrYh7F9Jpp9MraC/3HJIS9+CB0oWG0RqTT1sYaXtfVoucwFTlqYXPRgIvhH1STqkPQvWG8wYcSwG4ZLubzYO5hHTBiMt255FKcIG7rmurK3XtSM5IwOfyxNvhfbZzLup1zpqRX1/sQ/r/rSW4Qum2mTdUDvtz74VzcFOzU078N5jHcN3/s9Dr/ZK8vFxjAgDSFxybTrcQUKUTsLdxV5BHW7r3pslxfFI5Cz3pGarXh4uD4TR6O17SynAyKDaJRz2JDLxge4jBIp/CAbj1yBaIKSsJLxJpqRtAwOoea8bRj1K21OTlGWLE1qNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwsFW1C8Oi/7PAfzuxY9IMlgXLA43CBcKG86Qkh542M=;
 b=Dqs6xGIGDhWz9fomGmrVoEns6X83jF1etwqoNVsDtOnkqtIq3xWSs4sHIGz7LlYEdYrtzw9lR+4uVVwCXyoPEbKc/0G2p8HlYGvRpg4G9d4veWdkx88VmSn3yeYyHRjl9Z3/lxmc4L7RH0Enf1praiFQpNvVLsxmSAVTmMXg+iRjeu4IhPzAnA4ujWK9sHJxyCtqXjY1f4RlP/RISGhxXOcfjAaGsliBJpEEFNAvh6DjagfbVuPG0fofqpqwHqcElJ/gM2ggBGsxnU6vZk0N+E8yqBwhb1qpFHqi7jtISlsg/aB9coWRTjR+KO6bcIgOecYNb/Jf+bGdSar/IZXBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwsFW1C8Oi/7PAfzuxY9IMlgXLA43CBcKG86Qkh542M=;
 b=URyc7u4on5H0OgN1t8OIjqewg2pi9l+LOz0J4W3Wgk8JR+gtPn+3ahjnQGsjWj/mmnvv+ExMpzJ5O413G+pDduJjr/ePoXsEf4n1RH1oK3/oXAl3pvXeNx4A8g8DyRlmiLfQdZjueekbCaBXqRDLTTUWpTu6UqHieBZ0beZLKyE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6451.apcprd03.prod.outlook.com (2603:1096:400:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Wed, 16 Aug
 2023 07:17:24 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 07:17:24 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4, 2/3] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
Thread-Topic: [PATCH v4, 2/3] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
Thread-Index: AQHZzoEWX9Dm4ym4ZEGTk1tgRPxF4K/shmSA
Date:   Wed, 16 Aug 2023 07:17:24 +0000
Message-ID: <e6d22c2d11605c69baf862914237599c3f8cd860.camel@mediatek.com>
References: <20230814072842.28597-1-shuijing.li@mediatek.com>
         <20230814072842.28597-3-shuijing.li@mediatek.com>
In-Reply-To: <20230814072842.28597-3-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6451:EE_
x-ms-office365-filtering-correlation-id: d2f3ebb5-c6e6-4f0b-4685-08db9e28d6d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ru4CDEPXDgeQ337i8/+zMg/90SKnhG/55Wylbi9wa1QNGBP+clniRk5ALUplSK/l/K+jpnmQzw0afHYR7QRIPO34uiC9a8W7Qd3HDHKgAgIsFPvz75Zeif/Hah8TpPvZYnRX0fWshiOFk8FDzif2dFdHTeCt5gAolhqWf+O4jp/97Vohn1x1Oie1kq3m2uSLNqyChKGohNjYBzwJI8JXZOzdFSZdda79Xr486f7dRsaPjUVaH9faJV/umdFJ2ZnHrAtpwV7ah0xc4bwF/ehR6e9BMPBEagMebw3LaTOuPeJCqhs8F+yTTliQPT7sk0AJA8CHrtjFy9J5i2cQIZwewzj1/QghikC7MlYqOEmHS8jxUSb7EnGUz+LZ26hfxKKC6ELXfQM7Dd289aD4HIUVLPkxh0toC5ComeNL5I9E51kqsv4ouFB2em65ftlcxNpNx9THf3EQT/o7xuNrKbzIwbYOgXVGcbUVGoWmBNW6XSK8E9T3xqPr3kewHTc8O7deKha+mje1ZpLulwyqRgE/JbvPEMHNhGJPlcF8Jq0TQ6qmi5wDA2K7sMgRqyiAEJ//RhL1VKTp8ELVqD79Zuie37KhmiHzVvos2pBsdTBn/qsApTCM6U2Ji6IlLL38BvxnUq+y3NjtUJIyo8rLjJPD6pR7R5WRmm9bwfMDi47V6d3cEZGOp+6ng/AKK6b1ViXK0ynXEkpxghySBFhRwPMeHmcj8LgLON3stPSBtvrpxto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(1800799009)(451199024)(186009)(7416002)(122000001)(38100700002)(478600001)(6486002)(966005)(921005)(71200400001)(12101799020)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(41300700001)(316002)(54906003)(110136005)(8936002)(8676002)(5660300002)(38070700005)(2616005)(36756003)(85182001)(6512007)(83380400001)(86362001)(2906002)(107886003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTZzNkc3NVpYc045NTdWdDQ0RU9xNFJ0VkZZQ1MrUHdaYyswL3dTZkFjR0U3?=
 =?utf-8?B?VmVrZ1J1OFp1Z2pvcGJOUzA1bnNiZmZmZEJVQllJTmw5SjU0Zk5kRXhnNDBJ?=
 =?utf-8?B?LzFGMUppckNhVTgvcCtteDN5U2tzYlFqdFVFeURROW1lOExGWFBoa0FWM3J0?=
 =?utf-8?B?aGxHWkdQVlV2MHBoeWNQWGdTcEYxK2dhOVFuVXpNQkdjQk5DSm9wVjN0WUFp?=
 =?utf-8?B?TURLZWgyV3NIUysrVktsRW9QdEpYTUZCSHJHTGluVktHL3ppRXczZVY3TVZy?=
 =?utf-8?B?NWFuZ3hTMW1EUlJubjd4bS9Cb3NtanhyTDRnUjJmV1BsaVhTMm5CQXI4d3N3?=
 =?utf-8?B?UWk0aUdEVzFGc0hGdDVZRGJsTjMzSWpwbGNCekZXUjcrT2kycjlKOHhlSjFR?=
 =?utf-8?B?R3pKUGVJeXhBT0pUQXFvZXFFTnh0WHBKdVVYQVluZ3dHZHliRGhNNTN6RkVy?=
 =?utf-8?B?Wmh5U1VZUjEzMUt4aHdDNTNMY0dHbXdnS0dYOGh1a0RvVjR1azhDak51aFVt?=
 =?utf-8?B?ai8ySlN6MERUdVlBWmoxTGpoU2JxOE1jZndZbFQvQ04wTGZRM1IwR3piZVVE?=
 =?utf-8?B?NVJkcjg3ZElZaHF0U0pKVk1RNTVhZEU3WmxvZjRHYUVQNjViWVg3T09ObVJz?=
 =?utf-8?B?ck93Wnh0RlY0N1diaWQwbk54SXhwWXRtRXNQd0FVeDNxbUdsWG5pdS9zcGRV?=
 =?utf-8?B?S1dHYjdyRHducTB4ZkMyRWpLQ1lPWU1qSjBSdXNqakFJRVZSRHIwc21OMTQx?=
 =?utf-8?B?a1dmQ1ByTzBUaDloeGJFd3ByOTJpVkN6TzlxR1phRTE4UTNDMVloZHA1WlZ5?=
 =?utf-8?B?WTl1dStBNkFuV09RSGNhZGhRbmJPM3lhcS9ZMGxqUUZqM0pDK1FRblo1Y3Ex?=
 =?utf-8?B?dCtsVVdadDcwcUdzdlBwMUMzNXJGejVRWDQ4ODdTRWFuNnZQQzhKa0dnLzlo?=
 =?utf-8?B?ZzF5dTlEQTBHNGhxSTZqejc3VG5ib0tYeDBZVzBqNGdnSzhHeGRmNC83a2pa?=
 =?utf-8?B?RUE2aXJITzBwa25zSFdTYkRWK1JPMHN4amkwQXRYcXI1cCtURzMrcjVFYVFj?=
 =?utf-8?B?aXc4TlpUM2RweEZCTUtVV2dXTHVOd0NpSW5xQVhYOXlyUktlbEU3NDdidU9y?=
 =?utf-8?B?cmlMVjk3OU84L3VydFl0OWFsc0toU09tUW92NG1IR0FTQWJJbHZXNlUvUURi?=
 =?utf-8?B?ZG9ZV0diN0p1MUwxQnlyeGR1QUVUNFdhUVJuV3o4NVl1VVBNU2FUNDl0SVZJ?=
 =?utf-8?B?MDE1QWl2dmNHcnRYS2lKY2toQndrQ0FJdGo1M3hpbHZ5d2lTTDN2OUNDS0Iz?=
 =?utf-8?B?UENnYmZrS1YrN094K2t4MmhmeTdVV1gzMW0vM1krU3poZVhZWmQrWlJNUU1r?=
 =?utf-8?B?ckI4WCtHb0cwOFMrd2FTUVZTaUw0eDNUZDFqREszTzd1MWY4dGo3VDgvaW14?=
 =?utf-8?B?anowWG44d1c3aGxtMk9jQW5heUhPY05IUEVERlV2V3pwM0FOOUFpVVNaQWov?=
 =?utf-8?B?YzVGTC9VaDM0bHgxbklqQWhVMjd2b0grWUFlb2JFcjVNNG1laWxCYjR1VUYr?=
 =?utf-8?B?U0lIckpuWjZ3aGdJbCtJbFJ5UVZCUlBxRmpmL29kVU56Mi9xZnBOd1VEdTBG?=
 =?utf-8?B?U0dWbkZzM0ZqdEttK2V1K1A1L3VTUVBkUCthTGt6V016eFFlTnI5N0J2OEVj?=
 =?utf-8?B?RnVrRkNUS2lobXhOck1vR2F0c2VkaFhmLzJDQkdRaVZrY2FlVi9PaER3ZzFN?=
 =?utf-8?B?NUM5dm9wRVBYSFYyWU5OcFdzTDZhdExXKzEvWkFVZUh2MTJhdHVHdFZWRmxo?=
 =?utf-8?B?UUVONEw3OTRlbnp4TkVYbTlsU1RQNy9BL255YzJhVUZQRzZwK2w4RkdJNW16?=
 =?utf-8?B?VDRHUy9OblovWFBOOW05RDJhZUdHYlpTSTc0c1FCL1BVaDJEM3FyeE9PamdM?=
 =?utf-8?B?Y2laSWRnZ3JhUlBnemFMSFNrdUI0RUs4Y2ZSblM3Z1kvVThzb0lQaHU1R2dJ?=
 =?utf-8?B?T2xlQjB3RW5SYWk4K1llWmVyOEtwOHFYYzAvaTR6aEZ5d0hIOGhPazlJam5S?=
 =?utf-8?B?c0M2QUQwL0MzZ0hldllrUXZPZ3BoVld3WjNha3dIc3FsS2tSR0VxRERSWEd5?=
 =?utf-8?Q?1dJE3J1RzKwaWKjSWUii2rCIl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD28B1B456148540843862C441B3FC55@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f3ebb5-c6e6-4f0b-4685-08db9e28d6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 07:17:24.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GaBHGWp0VnKserxBB2KhRq6Fk9kbEA22eXyRlPE3Qu7IGdZnOpicsEfmKSB5d2H3BNAkjaP654qUxSs7epvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBNb24sIDIwMjMtMDgtMTQgYXQgMTU6MjggKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBUaGUgYXVkaW8gcGFja2V0IGFycmFuZ2VtZW50IGZ1bmN0aW9uIGlz
IHRvIG9ubHkgYXJyYW5nZSBhdWRpby4NCg0KVGhlICcuJyBpcyByZWR1bmRhbnQuDQoNCj4gcGFj
a2V0cyBpbnRvIHRoZSBIYmxhbmtpbmcgYXJlYS4gSW4gb3JkZXIgdG8gYWxpZ24gd2l0aCB0aGUg
SFcNCj4gZGVmYXVsdCBzZXR0aW5nIG9mIG10ODE5NSwgdGhpcyBmdW5jdGlvbiBuZWVkcyB0byBi
ZSB0dXJuZWQgb2ZmLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2h1aWppbmcgTGkgPHNodWlqaW5n
LmxpQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlA
bWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gZHJvcCBtdDgxODhfZWRw
X2RhdGEgYW5kIHJlbW92ZSB1bm5lY2Vzc2FyeSBtb2RpZmljYXRpb24uDQo+IHBlciBzdWdnZXN0
aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvYmRkYjFhMWE0NDVlYWQ4NTA1NjIwMmMzNTU2Mjc2OTgwNTFmMTJjOS5jYW1lbEBtZWRp
YXRlay5jb20vDQo+IENoYW5nZXMgaW4gdjM6DQo+IFNlcGFyYXRlIHRoZXNlIHR3byB0aGluZ3Mg
aW50byB0d28gZGlmZmVyZW50IHBhdGNoZXMuDQo+IHBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHBy
ZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2UyYWQyMmJj
YmEzMTc5N2YzOGExMmE0ODhkNDI0NmEwMWJmMGNiMmUuY2FtZWxAbWVkaWF0ZWsuY29tLw0KPiBD
aGFuZ2VzIGluIHYyOg0KPiAtIGNoYW5nZSB0aGUgdmFyaWFibGVzJyBuYW1lIHRvIGJlIG1vcmUg
ZGVzY3JpcHRpdmUNCj4gLSBhZGQgYSBjb21tZW50IHRoYXQgZGVzY3JpYmVzIHRoZSBmdW5jdGlv
biBvZg0KPiBtdGtfZHBfYXVkaW9fc2FtcGxlX2FycmFuZ2UNCj4gLSByZWR1Y2UgaW5kZW50YXRp
b24gYnkgZG9pbmcgdGhlIGludmVyc2UgY2hlY2sNCj4gLSBhZGQgYSBkZWZpbml0aW9uIG9mIHNv
bWUgYml0cw0KPiAtIGFkZCBzdXBwb3J0IGZvciBtZWRpYXRlaywgbXQ4MTg4LWVkcC10eA0KPiBw
ZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC9hYzBmY2VjOS1hMmZlLTA2Y2MtYzcyNy0xODllZjdiYWJlOWNAY29s
bGFib3JhLmNvbS8NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMg
ICAgIHwgMzANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5oIHwgIDUgKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MzUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBp
bmRleCA2NGVlZTc3NDUyYzAuLjc1YWY2ZGU3YmM0MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHAuYw0KPiBAQCAtMTM5LDYgKzEzOSw3IEBAIHN0cnVjdCBtdGtfZHBfZGF0YSB7DQo+
ICAJdW5zaWduZWQgaW50IHNtY19jbWQ7DQo+ICAJY29uc3Qgc3RydWN0IG10a19kcF9lZnVzZV9m
bXQgKmVmdXNlX2ZtdDsNCj4gIAlib29sIGF1ZGlvX3N1cHBvcnRlZDsNCj4gKwlib29sIGF1ZGlv
X3BrdF9pbl9oYmxhbmtfYXJlYTsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2RwX2VmdXNlX2ZtdA0KPiBtdDgxOTVfZWRwX2VmdXNlX2ZtdFtNVEtfRFBfQ0FMX01BWF0g
PSB7DQo+IEBAIC0xMzYyLDYgKzEzNjMsMTggQEAgc3RhdGljIHZvaWQNCj4gbXRrX2RwX3NkcF9z
ZXRfZG93bl9jbnRfaW5pdF9pbl9oYmxhbmsoc3RydWN0IG10a19kcCAqbXRrX2RwKQ0KPiAgCQkJ
ICAgU0RQX0RPV05fQ05UX0lOSVRfSU5fSEJMQU5LX0RQX0VOQzFfUDBfTUFTSykNCj4gOw0KPiAg
fQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBtdGtfZHBfYXVkaW9fc2FtcGxlX2FycmFuZ2Uoc3RydWN0
IG10a19kcCAqbXRrX2RwKQ0KDQpUaGlzIGZ1bmN0aW9uIGlzIHRvICdkaXNhYmxlJyBhcnJhbmdl
bWVudCwgc28gYWRkICdkaXNhYmxlJyBpbiB0aGUNCmZ1bmN0aW9uICBuYW1lLg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiArew0KPiArCS8qIGFycmFuZ2UgYXVkaW8gcGFja2V0cyBpbnRvIHRoZSBIYmxh
bmtpbmcgYW5kIFZibGFua2luZyBhcmVhDQo+ICovDQo+ICsJaWYgKCFtdGtfZHAtPmRhdGEtPmF1
ZGlvX3BrdF9pbl9oYmxhbmtfYXJlYSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJbXRrX2RwX3Vw
ZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX0VOQzFfUDBfMzM3NCwgMCwNCj4gKwkJCSAgIFNEUF9B
U1BfSU5TRVJUX0lOX0hCTEFOS19EUF9FTkMxX1AwX01BU0spOw0KPiArCW10a19kcF91cGRhdGVf
Yml0cyhtdGtfZHAsIE1US19EUF9FTkMxX1AwXzMzNzQsIDAsDQo+ICsJCQkgICBTRFBfRE9XTl9B
U1BfQ05UX0lOSVRfRFBfRU5DMV9QMF9NQVNLKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQg
bXRrX2RwX3NldHVwX3R1KHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gIHsNCj4gIAl1MzIgc3Jh
bV9yZWFkX3N0YXJ0ID0gbWluX3QodTMyLA0KPiBNVEtfRFBfVEJDX0JVRl9SRUFEX1NUQVJUX0FE
RFIsDQo+IEBAIC0xMzcxLDYgKzEzODQsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfc2V0dXBfdHUo
c3RydWN0IG10a19kcA0KPiAqbXRrX2RwKQ0KPiAgCQkJCSAgICBNVEtfRFBfUElYX1BFUl9BRERS
KTsNCj4gIAltdGtfZHBfc2V0X3NyYW1fcmVhZF9zdGFydChtdGtfZHAsIHNyYW1fcmVhZF9zdGFy
dCk7DQo+ICAJbXRrX2RwX3NldHVwX2VuY29kZXIobXRrX2RwKTsNCj4gKwltdGtfZHBfYXVkaW9f
c2FtcGxlX2FycmFuZ2UobXRrX2RwKTsNCj4gIAltdGtfZHBfc2RwX3NldF9kb3duX2NudF9pbml0
X2luX2hibGFuayhtdGtfZHApOw0KPiAgCW10a19kcF9zZHBfc2V0X2Rvd25fY250X2luaXQobXRr
X2RwLCBzcmFtX3JlYWRfc3RhcnQpOw0KPiAgfQ0KPiBAQCAtMjYxNiw2ICsyNjMwLDE0IEBAIHN0
YXRpYyBpbnQgbXRrX2RwX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICANCj4gIHN0YXRp
YyBTSU1QTEVfREVWX1BNX09QUyhtdGtfZHBfcG1fb3BzLCBtdGtfZHBfc3VzcGVuZCwNCj4gbXRr
X2RwX3Jlc3VtZSk7DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4
MTg4X2RwX2RhdGEgPSB7DQo+ICsJLmJyaWRnZV90eXBlID0gRFJNX01PREVfQ09OTkVDVE9SX0Rp
c3BsYXlQb3J0LA0KPiArCS5zbWNfY21kID0gTVRLX0RQX1NJUF9BVEZfVklERU9fVU5NVVRFLA0K
PiArCS5lZnVzZV9mbXQgPSBtdDgxOTVfZHBfZWZ1c2VfZm10LA0KPiArCS5hdWRpb19zdXBwb3J0
ZWQgPSB0cnVlLA0KPiArCS5hdWRpb19wa3RfaW5faGJsYW5rX2FyZWEgPSB0cnVlLA0KPiArfTsN
Cj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZGF0YSBtdDgxOTVfZWRwX2RhdGEg
PSB7DQo+ICAJLmJyaWRnZV90eXBlID0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCwNCj4gIAkuc21j
X2NtZCA9IE1US19EUF9TSVBfQVRGX0VEUF9WSURFT19VTk1VVEUsDQo+IEBAIC0yNjMxLDYgKzI2
NTMsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZGF0YSBtdDgxOTVfZHBfZGF0YQ0K
PiA9IHsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10
a19kcF9vZl9tYXRjaFtdID0gew0KPiArCXsNCj4gKwkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTg4LWVkcC10eCIsDQo+ICsJCS5kYXRhID0gJm10ODE5NV9lZHBfZGF0YSwNCj4gKwl9LA0K
PiArCXsNCj4gKwkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWRwLXR4IiwNCj4gKwkJ
LmRhdGEgPSAmbXQ4MTg4X2RwX2RhdGEsDQo+ICsJfSwNCj4gIAl7DQo+ICAJCS5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5NS1lZHAtdHgiLA0KPiAgCQkuZGF0YSA9ICZtdDgxOTVfZWRwX2Rh
dGEsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5o
DQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0KPiBpbmRleCA4NGUz
OGNlZjAzYzIuLmYzOGQ2ZmYxMmFmZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcF9yZWcuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwX3JlZy5oDQo+IEBAIC0yMjgsNiArMjI4LDExIEBADQo+ICAJCQkJCQkJIFZJREVPX1NUQUJM
RV9DDQo+IE5UX1RIUkRfRFBfRU5DMV9QMCB8IFwNCj4gIAkJCQkJCQkgU0RQX0RQMTNfRU5fRFAN
Cj4gX0VOQzFfUDAgfCBcDQo+ICAJCQkJCQkJIEJTMkJTX01PREVfRFBfDQo+IEVOQzFfUDApDQo+
ICsNCj4gKyNkZWZpbmUgTVRLX0RQX0VOQzFfUDBfMzM3NAkJCTB4MzM3NA0KPiArI2RlZmluZSBT
RFBfQVNQX0lOU0VSVF9JTl9IQkxBTktfRFBfRU5DMV9QMF9NQVNLCUJJVCgxMikNCj4gKyNkZWZp
bmUgU0RQX0RPV05fQVNQX0NOVF9JTklUX0RQX0VOQzFfUDBfTUFTSwkJR0VOTUFTSw0KPiAoMTEs
IDApDQo+ICsNCj4gICNkZWZpbmUgTVRLX0RQX0VOQzFfUDBfMzNGNAkJCTB4MzNmNA0KPiAgI2Rl
ZmluZSBEUF9FTkNfRFVNTVlfUldfMV9BVURJT19SU1RfRU4JCQlCSVQoMCkNCj4gICNkZWZpbmUg
RFBfRU5DX0RVTU1ZX1JXXzEJCQkJQklUKDkpDQo=
