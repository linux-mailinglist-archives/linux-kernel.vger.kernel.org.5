Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDEC7628B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGZC0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGZC0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:26:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D466268B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:26:12 -0700 (PDT)
X-UUID: c60025a22b5b11ee9cb5633481061a41-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LqZ1o3bgrhnkp+YXnU3GzULJMrKsThZz6QENYSvMa0E=;
        b=o/EOreaEO+41vvdAl4exPdO97b7ez4H9TWgt0gorw+wRxuU1P+yHkwvEhJMX3Pw5wRIRhxTHxnvrdUzEI0TwKzzeg2Vta7yRoyxtsFNBDw4TFtVgkQkQhjcaWcaONcS2vfFQHrvrWaQ9Y7uqsUegMraDPMzMVGP6Hvp5eJUXmSk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:39a94a35-95a3-4937-ae49-f1f650ae7eb3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:44c753d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c60025a22b5b11ee9cb5633481061a41-20230726
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 78556519; Wed, 26 Jul 2023 10:26:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 10:26:04 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 10:26:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il8er7JW/mM4IZXmhe8aXkRUAz9Rarw71n4KDTh38Nom8oLxXMXzRrKBXng3RHFCclXNYEz1ynScOeZWX/EJZAp1FQOOElxDxZodwPwY4yhHmrjrHM65QgHjzahphoBxa+QasTPvzKTTBxt1NHCphjX1v6aXFfUfQ2AptULvH0GnQGd6fFqwm4b3DoRWloN+KLEwpNRuOmX5/Jj9t/lGQsiWTfEuBR9QLzpYxpadTDz1fL24rCpy4NAxGRksjt40ERtmcvHhU3REXteuwvqTsCeqflKYWdOxgSsQ1CooRRDHk1zMiQD082gOXgND6DD+BfnAADAu7ZOCymJzT0ZPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqZ1o3bgrhnkp+YXnU3GzULJMrKsThZz6QENYSvMa0E=;
 b=U2joum6aUrawnoV4/8L0yiE3GqDKbORla1xy3vX60Gzmt2U1vJqFNh/7sU5UOFKWzjnMDj2V7pZz5tt8/iV1dRFNBOFyvGTKFX5o4eeDqORHfX1HxuZOifkSDKBnIcVKqwBtD2FMswXk1HniwZDYccDMOJqm8eu4v/CQ5/GtiJVkIqu9g6ZTQ9fn1MKOUmmhDiz18NF7BMXBhHOf0TKykbvSbHwChxTSYYp867TI6qOaG/pYCg8h4OPiYaMvJ/B620zF19Rv6IDFKa6PfI02oRg5Hf56Iow+jJzeMSqfxZ3g4dvYnlwrbZJJaK7xbsmEPl966iT64+7C8ull8p017A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqZ1o3bgrhnkp+YXnU3GzULJMrKsThZz6QENYSvMa0E=;
 b=GlW6ALarZAAEPkb/AfZAX0OdsW1vE9U1I9ygcqUrovARSGtp5MBKwkLmzQY593QLMbqQQ8OypfpEMoiFkj0bghH2ktz7UZFem88mBuYYppC9lz1t+pv28CyB8zaPCQIC2SnRyZ+lWGjXsfGHAG1NWzUIxhnEwI8eshP5IL745ow=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SG2PR03MB6611.apcprd03.prod.outlook.com (2603:1096:4:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 02:25:01 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:25:01 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 3/3] ASoC: mediatek: mt8188-mt6359: add SOF support
Thread-Topic: [PATCH 3/3] ASoC: mediatek: mt8188-mt6359: add SOF support
Thread-Index: AQHZvquXgZmLLX0Uz0mrRmMvDmVTFq/KERIAgAFCVwA=
Date:   Wed, 26 Jul 2023 02:25:01 +0000
Message-ID: <11f54c022cb21ad2ee416cf6ee4130e4351f0482.camel@mediatek.com>
References: <20230725035304.2864-1-trevor.wu@mediatek.com>
         <20230725035304.2864-4-trevor.wu@mediatek.com>
         <229d6df5-9abb-64be-a095-dd6f5fbc3c77@collabora.com>
In-Reply-To: <229d6df5-9abb-64be-a095-dd6f5fbc3c77@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SG2PR03MB6611:EE_
x-ms-office365-filtering-correlation-id: 3279e38e-252e-477b-f9a1-08db8d7f83c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +BrBN8rAIqRdKBAAY4ZcOryXgX0WrOaaxefFqElaDds7naY52TsqBVKzUIeAB7rCmmgujxTN2LZrvaoknGW4eoeTsJEmLIhgeMFrzcbNQ+tIsL6o0OZObJ7A6k5zIU0MF8VVMaYkWKODLhMldzSpJncaEFRNA4FxutMT9Jhz22UzPnHFyvSt9NS8rK0FkJ5vHroXSi5mLim5fHjbOVRh+8nRR6DBU/6H8ygu1ZrECTXld1V94XWeW+Skm4iT1xHOYUbpiThNJXghKvU0AcZzvkkqAEOFzJ8xHyzYLLQb0L/jWdorkknXerIUaDMLdnMzMF7ioXkGa3MMKj/jYRmOemNL1K1p+gi1v8ZGtg2EdtjqHL8ZF+0O3h2VpqdDZvLF/moblFc0pMwzM3Ec3yFrhROu6Fn6ZsLhr+X+cbqRDel3W7cX+C4o6wNLNG9X/w+1amytbMv0w0Pxcx5WEYzWO+QNMZmue+O8pZH1h/ICpORmu9TJUDd7sAebXnqQdkvj4sXe0Et8Dw4TsuRLM92PQK0tYLk2zPquYiI20wQp5sugc8bBnkchdo7+P7fvF26KKTXa0elkO9JT6q/FiNd86F+2fh8TzNdUQ0Lux+Nn2guuyYzlBnj6eBynYgk5ghzu7nirApGBcVrzw0W+CCPI04zNdfMXYGEpTpQ1MsQtHjKKkm+bARkJd3DZEO1+lkKf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(71200400001)(6512007)(186003)(6486002)(85182001)(122000001)(83380400001)(110136005)(54906003)(4326008)(76116006)(64756008)(91956017)(66446008)(66556008)(66476007)(66946007)(41300700001)(86362001)(316002)(478600001)(36756003)(2616005)(26005)(6506007)(5660300002)(7416002)(8936002)(8676002)(38100700002)(38070700005)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWNqWm1sZDk0WW5qS0lNVXNiSTJYS2FyU2t5QS9hNGo0OUdjdVV1MGl4M2xr?=
 =?utf-8?B?Rk8rUFM3TWVlZ0Y1K0tnUTRTR2lyOWd5L0t6V2luc2FXL2hkRFVwMmtGNzhv?=
 =?utf-8?B?Y1ozSFVQenJvT2VhblBjL0lLUW5VZnRNQ2kxVThNcnkvaGJHMUNNZDF3bDVJ?=
 =?utf-8?B?OU9ueHROdUpTck9uNXNBUWNFNXFCYlMzQk9MUDlFRlpvcGZSS1VSUndaWEw5?=
 =?utf-8?B?Qkp2TFFOaGtiUldYNkc0VDdsMWJrSGF5VjRyd2lRY1VuRjkxWHBTSTZxM3Jk?=
 =?utf-8?B?b1dvSU5FeEVLRU02SkxZTXhzZEEzUEhJWUN5SzZjdFlXNktTbG1CaWhRbFdk?=
 =?utf-8?B?WkdweEpId3h6ell1eXNJdW8wd2dWL3BpbFkxam1GQ3oxenBvR0xZeXcwbVBv?=
 =?utf-8?B?bk5xNlZTMlZQZWowT2p2T2hHZEt0UFRxQXJQMVBCYjB3c3laM1B2eGlNcm9q?=
 =?utf-8?B?VmdURUdQT0NNU3Rkb01tbk40WFZnV2JhdFNiS01XMjRsZnNiZGg4QXp0VHVp?=
 =?utf-8?B?cm5FdlBkWGRnM0hXeW0xamt0OG1jd2JybEY0NmhjWDJpdjJNYU5RbTZEMUll?=
 =?utf-8?B?T2NiZXFLQ3NXQXZ1WUkvZG9tVnRIdTFyb3VIa0Q3eCtNVXpQakhVdHFsTjRI?=
 =?utf-8?B?STltT1VDVHBaL29Gek1yOEMrL2ZSb1pDVXdUckoremkyNUk4dUVCS2VjZ0dP?=
 =?utf-8?B?RnlvdVJGSGVOcDQ5bU1kRDJQd3hvM25uTng2R01pTVdnWXovbnlBTzkvWnVC?=
 =?utf-8?B?VS9kQkdWbmgyRXhCWHduYTg0ZC9nU2RKanlJUjEwN2VEQTc2MW5najlPdkZp?=
 =?utf-8?B?ZHM5SFlLT0lVUlFqZ2ttYVZEZUxrRy9BSVFoSWwzUlhqN3hvYlJZbytvME9u?=
 =?utf-8?B?Qk5tRjlDV0dZT2YzdTlESzJ6WG9jNVZGaExVVExuNU53OGtsUzJ6Y0tWdGxs?=
 =?utf-8?B?R0JKRzJnN05QcVZjUXUxRG45UDZ6Wit5UUZHMnUwNTZMMWZZM0lpV3lVV2JZ?=
 =?utf-8?B?ZmlObEI3eXh5WmNPUTZlai9oMnFwL1NEdXVtYUMwZW5RVlVZWkRORDRrN1cw?=
 =?utf-8?B?VmZRbVhhTXdDWmtYYmRlZGRWY0tkSUZNYkRHbit0MW9vZXN2OGdhdU5MeHZu?=
 =?utf-8?B?Wm1RVFd2VHJSKzEwUDMrU0g3V040WUpHdEdaQzdVZnNYVFI5VUVybThTdHh4?=
 =?utf-8?B?bmxHN21lZDhYeW02SXdXakV1eDFKTHBSMjhodDIvZTdyd3RSc1Mvd2JQTlla?=
 =?utf-8?B?bTREZHNGK2IwaEdOZm9rLzNGMEM0ZmpEVXhWc1FLMU0yM0hpRFF0SzgxL0Uw?=
 =?utf-8?B?N2pBOHVkcE8xeFdzYmhsaFFlMVBVNk9jUjdZak5ycE0wK2V0RXFGMm5RVFJx?=
 =?utf-8?B?eGs3WXRGREd4ZUJObHI2Z2NoRnVTME1STjBabW0vbTBPdGxQam1pZ2s1Qnl3?=
 =?utf-8?B?WFlTeTN4blQrR0FOZkppdmprVnR5RHNwYVlXVjcvMWdpZXBoQVJrN1ViMXIy?=
 =?utf-8?B?eVdJL1RDTTN1dmQxVTMzK2RRNVFtOUhobnZNYmZvZnFTa3Z4elNHVENZN3E2?=
 =?utf-8?B?MVJXa1JWQmNiekhIdEF0U1FaT3Q3SVJ3TXFTVHhGOGdXdkxmekpGNDVDTVJv?=
 =?utf-8?B?S0hrL0NQYnFJRzdJZjh2VHA5ZkkwVEhWTC95Z0dBNmlNb2VHemgwc3NVY2Ry?=
 =?utf-8?B?QTh4Z0ZqcFVUekdpMFVSQ01LMnlHR01tT29ySWFMdzN0UFUzb2p2VDNsVFN5?=
 =?utf-8?B?WGpyWERPN1NsMVZ5Q0hETkRTOGhDMlZjbC95QlZrSW52S3VCREd5UUFkSHBN?=
 =?utf-8?B?MnM5WDhQbGJjNUJVNUt3bU42R3NuVkdJVm03Q3I2NlVTc2pOdVZtQ1BLdVI3?=
 =?utf-8?B?Ty9PVFNUSGNTTFgxTVVZUVY3TkNsU3NLSlZJcjBCNW5BTjd4YjdjN0Z5WHdC?=
 =?utf-8?B?SWtaWVg4U3hGZmRCMy81VCtUWTB5TERXOFowdmxDVkcvOGtUc1p5bngrME9l?=
 =?utf-8?B?cjVXNWR4R1RHK05uL3dzZjhaUURMYXVkVC9qTFhFNFc1OU9SNTRNd3A1bmNv?=
 =?utf-8?B?ZnEwUlB0QnVmQUV6cnpvMFh6cm5mUTdiVzd2ZWl0cVlUNjZKT3JRcm11WEQ2?=
 =?utf-8?B?QUpheFN0YXpjUUhSTXptZ0dUNFVjbTFURGxXaXRjSDR5RG1LVXdVK05uMnNZ?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3700C6147672544AB1B59FE0308FD6CF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3279e38e-252e-477b-f9a1-08db8d7f83c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:25:01.3935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GMyPWfhzpp996ANCd6sjS4wh+d/80KZsvNF4LKL4jlw3EVh+ylHCQhb3r5yoB7mH5KlLuOhT7S6QSC707qvGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6611
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTI1IGF0IDA5OjExICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjUvMDcvMjMgMDU6NTMsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IFNPRiBpcyBlbmFibGVkIHdoZW4gYWRzcCBwaGFuZGxlIGlzIGFzc2lnbmVkIHRvICJtZWRp
YXRlayxhZHNwIi4NCj4gPiBUaGUgcmVxdWlyZWQgY2FsbGJhY2sgd2lsbCBiZSBhc3NpZ25lZCB3
aGVuIFNPRiBpcyBlbmFibGVkLg0KPiA+IA0KPiA+IEFkZGl0aW9uYWxseSwgIm1lZGlhdGVrLGRh
aS1saW5rIiBpcyBpbnRyb2R1Y2VkIHRvIGRlY2lkZSB0aGUNCj4gPiBzdXBwb3J0ZWQNCj4gPiBk
YWkgbGlua3MgZm9yIGEgcHJvamVjdCwgc28gdXNlciBjYW4gcmV1c2UgdGhlIG1hY2hpbmUgZHJp
dmVyDQo+ID4gcmVnYXJkbGVzcw0KPiA+IG9mIGRhaSBsaW5rIGNvbWJpbmF0aW9uLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jIHwg
MjE3DQo+ID4gKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIw
NSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4gPiBiL3NvdW5kL3Nv
Yy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jDQo+ID4gaW5kZXggNjY3ZDc5ZjMzYmYy
Li5lMjA1ZGUyODk5YTkgMTAwNjQ0DQo+ID4gLS0tIGEvc291bmQvc29jL21lZGlhdGVrL210ODE4
OC9tdDgxODgtbXQ2MzU5LmMNCj4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210
ODE4OC1tdDYzNTkuYw0KPiANCj4gLi5zbmlwLi4NCj4gDQo+ID4gQEAgLTEwNzQsMjEgKzEyMTUs
NjQgQEAgc3RhdGljIGludCBtdDgxODhfbXQ2MzU5X2Rldl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAJaWYgKCFjYXJkLT5uYW1lKQ0KPiA+ICAgCQljYXJk
LT5uYW1lID0gY2FyZF9kYXRhLT5uYW1lOw0KPiA+ICAgDQo+ID4gLQlwcml2ID0gZGV2bV9remFs
bG9jKCZwZGV2LT5kZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KPiA+IC0JaWYgKCFw
cml2KQ0KPiA+IC0JCXJldHVybiAgLUVOT01FTTsNCj4gPiAtDQo+ID4gICAJaWYgKG9mX3Byb3Bl
cnR5X3JlYWRfYm9vbChwZGV2LT5kZXYub2Zfbm9kZSwgImF1ZGlvLXJvdXRpbmciKSkNCj4gPiB7
DQo+ID4gICAJCXJldCA9IHNuZF9zb2Nfb2ZfcGFyc2VfYXVkaW9fcm91dGluZyhjYXJkLCAiYXVk
aW8tDQo+ID4gcm91dGluZyIpOw0KPiA+ICAgCQlpZiAocmV0KQ0KPiA+ICAgCQkJcmV0dXJuIHJl
dDsNCj4gPiAgIAl9DQo+ID4gICANCj4gPiArCXByaXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRl
diwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIXByaXYpDQo+ID4gKwkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJc29jX2NhcmRfZGF0YSA9IGRldm1fa3phbGxv
YygmcGRldi0+ZGV2LCBzaXplb2YoKmNhcmRfZGF0YSksDQo+ID4gR0ZQX0tFUk5FTCk7DQo+ID4g
KwlpZiAoIXNvY19jYXJkX2RhdGEpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+
ICsJc29jX2NhcmRfZGF0YS0+bWFjaF9wcml2ID0gcHJpdjsNCj4gPiArDQo+ID4gKwlhZHNwX25v
ZGUgPSBvZl9wYXJzZV9waGFuZGxlKHBkZXYtPmRldi5vZl9ub2RlLA0KPiA+ICJtZWRpYXRlayxh
ZHNwIiwgMCk7DQo+ID4gKwlpZiAoYWRzcF9ub2RlKSB7DQo+ID4gKwkJc3RydWN0IG10a19zb2Zf
cHJpdiAqc29mX3ByaXY7DQo+ID4gKw0KPiA+ICsJCXNvZl9wcml2ID0gZGV2bV9remFsbG9jKCZw
ZGV2LT5kZXYsIHNpemVvZigqc29mX3ByaXYpLA0KPiA+IEdGUF9LRVJORUwpOw0KPiA+ICsJCWlm
ICghc29mX3ByaXYpIHsNCj4gPiArCQkJcmV0ID0gLUVOT01FTTsNCj4gPiArCQkJZ290byBlcnJf
YWRzcF9ub2RlOw0KPiA+ICsJCX0NCj4gPiArCQlzb2ZfcHJpdi0+Y29ubl9zdHJlYW1zID0gZ19z
b2ZfY29ubl9zdHJlYW1zOw0KPiA+ICsJCXNvZl9wcml2LT5udW1fc3RyZWFtcyA9IEFSUkFZX1NJ
WkUoZ19zb2ZfY29ubl9zdHJlYW1zKTsNCj4gPiArCQlzb2NfY2FyZF9kYXRhLT5zb2ZfcHJpdiA9
IHNvZl9wcml2Ow0KPiA+ICsJCWNhcmQtPnByb2JlID0gbXRrX3NvZl9jYXJkX3Byb2JlOw0KPiA+
ICsJCWNhcmQtPmxhdGVfcHJvYmUgPSBtdGtfc29mX2NhcmRfbGF0ZV9wcm9iZTsNCj4gPiArCQlp
ZiAoIWNhcmQtPnRvcG9sb2d5X3Nob3J0bmFtZV9jcmVhdGVkKSB7DQo+ID4gKwkJCXNucHJpbnRm
KGNhcmQtPnRvcG9sb2d5X3Nob3J0bmFtZSwgMzIsICJzb2YtDQo+ID4gJXMiLCBjYXJkLT5uYW1l
KTsNCj4gPiArCQkJY2FyZC0+dG9wb2xvZ3lfc2hvcnRuYW1lX2NyZWF0ZWQgPSB0cnVlOw0KPiA+
ICsJCX0NCj4gPiArCQljYXJkLT5uYW1lID0gY2FyZC0+dG9wb2xvZ3lfc2hvcnRuYW1lOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wocGRldi0+ZGV2Lm9m
X25vZGUsICJtZWRpYXRlayxkYWktDQo+ID4gbGluayIpKSB7DQo+ID4gKwkJcmV0ID0gbXRrX3Nv
Zl9kYWlsaW5rX3BhcnNlX29mKGNhcmQsIHBkZXYtPmRldi5vZl9ub2RlLA0KPiA+ICsJCQkJCSAg
ICAgICAibWVkaWF0ZWssZGFpLWxpbmsiLA0KPiA+ICsJCQkJCSAgICAgICBtdDgxODhfbXQ2MzU5
X2RhaV9saW5rcywNCj4gPiArCQkJCQkgICAgICAgQVJSQVlfU0laRShtdDgxODhfbXQ2MzU5DQo+
ID4gX2RhaV9saW5rcykpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZGV2X2Vycl9wcm9i
ZSgmcGRldi0+ZGV2LCByZXQsICJQYXJzZSBkYWktbGluaw0KPiA+IGZhaWxcbiIpOw0KPiA+ICsJ
CQlnb3RvIGVycl9hZHNwX25vZGU7DQo+ID4gKwkJfQ0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlp
ZiAoIWFkc3Bfbm9kZSkNCj4gPiArCQkJY2FyZC0+bnVtX2xpbmtzID0gREFJX0xJTktfUkVHVUxB
Ul9OVU07DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCXBsYXRmb3JtX25vZGUgPSBvZl9wYXJzZV9w
aGFuZGxlKHBkZXYtPmRldi5vZl9ub2RlLA0KPiA+ICAgCQkJCQkgIm1lZGlhdGVrLHBsYXRmb3Jt
IiwgMCk7DQo+ID4gICAJaWYgKCFwbGF0Zm9ybV9ub2RlKSB7DQo+ID4gICAJCXJldCA9IC1FSU5W
QUw7DQo+ID4gLQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgcmV0LCAiUHJvcGVy
dHkNCj4gPiAncGxhdGZvcm0nIG1pc3Npbmcgb3IgaW52YWxpZFxuIik7DQo+ID4gKwkJZGV2X2Vy
cl9wcm9iZSgmcGRldi0+ZGV2LCByZXQsICJQcm9wZXJ0eSAncGxhdGZvcm0nDQo+ID4gbWlzc2lu
ZyBvciBpbnZhbGlkXG4iKTsNCj4gDQo+IFdlIGNvdWxkIHNob3J0ZW4gdGhpcyB3aXRoDQo+IA0K
PiByZXQgPSBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIC1FSU5WQUwsICJQcm9wZXJ0eSAuLi4u
Iik7DQo+IGdvdG8gZXJyX2Fkc3Bfbm9kZTsNCj4gDQo+IC4uLmJ1dCBJIGRvbid0IGhhdmUgc3Ry
b25nIG9waW5pb25zIGFib3V0IHRoYXQsIGl0J3MgeW91ciBjaG9pY2UuDQo+IA0KDQpJdCBpcyBj
b25jaXNlLiBJIHdpbGwgYXBwbHkgaXQgaW4gdjIuDQoNCj4gPiArCQlnb3RvIGVycl9wbGF0Zm9y
bV9ub2RlOw0KPiA+ICsNCj4gPiAgIAl9DQo+ID4gICANCj4gPiAgIAlyZXQgPSBwYXJzZV9kYWlf
bGlua19pbmZvKGNhcmQpOw0KPiA+IEBAIC0xMDk2LDggKzEyODAsMTIgQEAgc3RhdGljIGludCBt
dDgxODhfbXQ2MzU5X2Rldl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gICAJCWdvdG8gZXJyOw0KPiA+ICAgDQo+ID4gICAJZm9yX2VhY2hfY2FyZF9wcmVsaW5r
cyhjYXJkLCBpLCBkYWlfbGluaykgew0KPiA+IC0JCWlmICghZGFpX2xpbmstPnBsYXRmb3Jtcy0+
bmFtZSkNCj4gPiAtCQkJZGFpX2xpbmstPnBsYXRmb3Jtcy0+b2Zfbm9kZSA9IHBsYXRmb3JtX25v
ZGU7DQo+ID4gKwkJaWYgKCFkYWlfbGluay0+cGxhdGZvcm1zLT5uYW1lKSB7DQo+ID4gKwkJCWlm
ICghc3RybmNtcChkYWlfbGluay0+bmFtZSwgIkFGRV9TT0YiLA0KPiA+IHN0cmxlbigiQUZFX1NP
RiIpKSAmJiBhZHNwX25vZGUpDQo+ID4gKwkJCQlkYWlfbGluay0+cGxhdGZvcm1zLT5vZl9ub2Rl
ID0NCj4gPiBhZHNwX25vZGU7DQo+ID4gKwkJCWVsc2UNCj4gPiArCQkJCWRhaV9saW5rLT5wbGF0
Zm9ybXMtPm9mX25vZGUgPQ0KPiA+IHBsYXRmb3JtX25vZGU7DQo+ID4gKwkJfQ0KPiA+ICAgDQo+
ID4gICAJCWlmIChzdHJjbXAoZGFpX2xpbmstPm5hbWUsICJEUFRYX0JFIikgPT0gMCkgew0KPiA+
ICAgCQkJaWYgKHN0cmNtcChkYWlfbGluay0+Y29kZWNzLT5kYWlfbmFtZSwgInNuZC0NCj4gPiBz
b2MtZHVtbXktZGFpIikpDQo+ID4gQEAgLTExNDAsNyArMTMyOCw3IEBAIHN0YXRpYyBpbnQgbXQ4
MTg4X210NjM1OV9kZXZfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiA+ICAgCX0NCj4gPiAgIA0KPiA+ICAgCXByaXYtPnByaXZhdGVfZGF0YSA9IGNhcmRfZGF0YTsN
Cj4gPiAtCXNuZF9zb2NfY2FyZF9zZXRfZHJ2ZGF0YShjYXJkLCBwcml2KTsNCj4gPiArCXNuZF9z
b2NfY2FyZF9zZXRfZHJ2ZGF0YShjYXJkLCBzb2NfY2FyZF9kYXRhKTsNCj4gPiAgIA0KPiA+ICAg
CXJldCA9IGRldm1fc25kX3NvY19yZWdpc3Rlcl9jYXJkKCZwZGV2LT5kZXYsIGNhcmQpOw0KPiA+
ICAgCWlmIChyZXQpDQo+ID4gQEAgLTExNDksNiArMTMzNywxMSBAQCBzdGF0aWMgaW50IG10ODE4
OF9tdDYzNTlfZGV2X3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
PiAgIGVycjoNCj4gPiAgIAlvZl9ub2RlX3B1dChwbGF0Zm9ybV9ub2RlKTsNCj4gPiAgIAljbGVh
bl9jYXJkX3JlZmVyZW5jZShjYXJkKTsNCj4gPiArDQo+ID4gK2Vycl9hZHNwX25vZGU6DQo+ID4g
K2Vycl9wbGF0Zm9ybV9ub2RlOg0KPiANCj4gSnVzdCBvbmUgbGFiZWwgaXMgZW5vdWdoLiBLZWVw
IGVycl9hZHNwX25vZGUsIHJlbW92ZQ0KPiBlcnJfcGxhdGZvcm1fbm9kZS4NCj4gDQpPSy4gSSB3
aWxsIHJlbW92ZSBvbmUgbGFiZWwgaW4gdjIuDQoNClRoYW5rcywNClRyZXZvcg0K
