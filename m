Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83CA76E00D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjHCGIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjHCGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:08:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E523272C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:08:42 -0700 (PDT)
X-UUID: 2ebbcb4631c411ee9cb5633481061a41-20230803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=L/vKz9h/zbM/6EO0xuf7JFOmXdz+lfL/4iAQBSQqgA0=;
        b=cmMSXKTcLd9Bgc0lhRB8uXj03Btosl9XVcoSKa9k5XwfpMDgJ1GsoqYcnu0846/QdsW+3nrFhp7cGmQLoPBCX3zhdtwD+oVcsLpICJY8T0sPy2qJJLPtDRHARBFi49Av8imSdo4OkJ+KKnO5Kv8D4giTMKIUdns1TSFM796J9k8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:287fe73c-4979-4c99-b974-b8b9fd6ca7c2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:e64219b4-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2ebbcb4631c411ee9cb5633481061a41-20230803
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 733838133; Thu, 03 Aug 2023 14:08:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Aug 2023 14:08:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Aug 2023 14:08:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyg280GPAlOexf7nc5b/ti6rXQeKpHqY4iZswQpjBwJK/g+26l9JXyJK9HZTkArfhjOfl5ZfXcKGGJtfB8rB2twgZHG9CCvX7gM4W3vEravQa08LmyMufx2jzSL42p3QDYrF0YfY6Jw+VkGRKlv/75Q5kkd18e8Pfzc7qjrK8fYxh5Z/qh3vPQAkLWylVdT+hkZ4b3SXQpHh2RsxPx/IeYGSwa06Zv4Kg1hleVHRMRam5LkorBjZSi3EftNhBHQp6sj75Lo0ImCTuePnFQkX8S9LOMaBnJVZtumldUR1C7N7r1tS+5cTlCJGajFqQqF64/IAfEvnq4nm44GJX9VcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/vKz9h/zbM/6EO0xuf7JFOmXdz+lfL/4iAQBSQqgA0=;
 b=I/CT+GOJVikAvJvpoxo8tznuCW12KO0cuws4JmPS+a+doTpygf5WS71Y2COBCKVlW2Q172+OxETIgHl71lcAH7vq6C9XCPvzMCYZSxn0XQXySzFT8vy1t6eZoKiGbwIOtS8i/gZKWnyCIswGP3KU5e8kLdkHPaKI64jmnPLj6rUngtxzAc/NCL5T5+jQz88YoHgIzEOcZyfiCODhzTzg0fhZZrrHRQIribQcNIK7adPsvMCx38JDgVg2zPnhJl6MV++eqfFnnxUac713chNMAP8Q7LVWOGYdwSq+IoMTDveFC6nOvbGyCO1oSwT8juJTfpwV60EgqdAmKky2NlJrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/vKz9h/zbM/6EO0xuf7JFOmXdz+lfL/4iAQBSQqgA0=;
 b=gbb/KvWhdSbXG/hVdi68c0QqpLcmEOMQYNfiZySoR1TuzZ4n07Om1tOF7CWGqyPnQtI5sIkuFNDKqZmct3tIfWTQ/SS6YbfBVIzJHgqc9MjOqzq/7XwLb/AhOGqpqdpkoELOdj5o/IqLAiN8zqpOoQS9zJiaH6FIapIjZ6NJB8o=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7039.apcprd03.prod.outlook.com (2603:1096:820:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 06:08:31 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 06:08:31 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>
Subject: Re: [PATCH v8 08/13] drm/mediatek: gamma: Support multi-bank gamma
 LUT
Thread-Topic: [PATCH v8 08/13] drm/mediatek: gamma: Support multi-bank gamma
 LUT
Thread-Index: AQHZxG+ywRwsuWkUMUaJbHLP3rmfya/WZiyAgABIQYCAAWqNAA==
Date:   Thu, 3 Aug 2023 06:08:31 +0000
Message-ID: <762c7ad2a51f896c42b7ec4558c40f5fee484d4d.camel@mediatek.com>
References: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
         <20230801115854.150346-9-angelogioacchino.delregno@collabora.com>
         <92e1ddd531f9b029b89b1f234b9a1dfbb38d454a.camel@mediatek.com>
         <ad3c2877-3381-daa1-da38-ce196a645ce3@collabora.com>
In-Reply-To: <ad3c2877-3381-daa1-da38-ce196a645ce3@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7039:EE_
x-ms-office365-filtering-correlation-id: 9120023a-4b31-4367-d44c-08db93e80fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9CuQcX6oCC/4lweGnMlIpNPBMPa2jJELhbdDzkivqSv8Xvqwom0qA7suS7c4gcWK21mTSZJe9HDGsgcxDSmDR7qVsrCgIDb0h+uSeUYMlIyEcfGUQ89QrNbZmPyagaKJ3LRj6iLj7ecpbqmSqAGeXBsZdQDVJ7NMo9ElLY6DP4tcbBFZjslj7wBWkgPWlP+WYleWaQUxcEdAm1xROlCqcG+KE0FpZLRu7+WRcczxpmUs6qW5In5tYIvuzwH7L8rxVPaLhqT1JQkglctqLqT1S+T1JmIG/hZhfvequwAvezzRZlOtbjpy7fko0SnzFF4GDkEF5snl3I1TNH+/FYG2RZZaMRUcbfG6yJCQdAwjjyxM1FUQKuYFJ5skRAzKaJkNkXzazUnGbzGzfCmy/zsDe6b7U9e8o/+rNYmIXlVGaoolOt8SI90BI3wpq1Vv23R6xe5wNOy47fObHUH7WtSGuQBtvQ4iSh9nvPRPUulKET3gTmW7/1blhl0hXDQhj6bb6TbxjhIdHPieDMZs0laaHwMqd3AKJXoTGoO2ZxxAWhU8p/SguTDIziodSesLMOTbSFFfjwRREmxqnIprbQMxqTd38K7+1iuP5vySs5slEVk8uBTcxFqC7a4cbNYjgaFjDhegVU4JAg4KxAWLFYro6Zzqm+Dt55fWi5OY2VIfm0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(122000001)(6506007)(26005)(38100700002)(186003)(38070700005)(2616005)(83380400001)(2906002)(85182001)(36756003)(5660300002)(7416002)(15650500001)(8676002)(478600001)(110136005)(54906003)(86362001)(71200400001)(6512007)(6486002)(41300700001)(316002)(8936002)(4326008)(76116006)(66446008)(66946007)(66556008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzRPRE9kVUhQZ3c0OEQzVVlxWVFRMmVMUHhXMGhFQTdYK2xuTjJPS2p4SHJQ?=
 =?utf-8?B?WGhXUDBJNnlFeUYwb3VwcWFUKytrNmc2R2phTGFvRmhlYU1mVU9wUk5aZ2dK?=
 =?utf-8?B?NTlXd0JwalBJR2hmbTR4MGVwYWczb0w2VElWSDlZTTg0TW1GcW5udDBlNC9m?=
 =?utf-8?B?MSswTzF3d240VnRZSDNnS2JKRSttdWc5S0pUMlc1eGxKTUhNYjJLMThqN3Fz?=
 =?utf-8?B?MkNzY2o5ZmlKOHN1WC9XeUxZdEdUdkE3dmdOQ2JiWjFUTTJHZEdHS2kzeURG?=
 =?utf-8?B?dktVYTVTNTVFbi9RVzlGR3R1UmIvNkR5cHBBdmxFSHRqMUFVeTMrZUZFQk50?=
 =?utf-8?B?ajZXR0FwaXZhVHcwWlhjV3AwS0x5QVUrd29VekpCelVYZzRaQTEraFJJcDNv?=
 =?utf-8?B?NFJVUnBpZGhiRVIzTGVuT0c4cmJWbDBCVktxS1kyM05FRjhZeUZLam96dk5Q?=
 =?utf-8?B?S2F4TkpRUkZDVkhDYnZnTkJpQkQrYUNYaW93TjFOajFDY3JqL1Zib2gyLzhP?=
 =?utf-8?B?NUZ0NnJaZTR4Y1ZjYnBLaXNieU56cjNWb0dObFZtTStLZEJ5ek01S2ZWMWVV?=
 =?utf-8?B?a3E2dWFDRzdFbFBQaUtNU0xydG9GMU4vbFA2elR2VTNmbElEL2pZY2dCU2Iy?=
 =?utf-8?B?TVhaL0hwWm9wdXJkakx6M3AraGFkZTgreG5ITitrK09vRjZJZjJpeFM3UmZX?=
 =?utf-8?B?MlUzbS9JaTNXS2EramFPTlFlMjZjRXlxajRMdnRQanVBKzJlM1JwbGlPQjZC?=
 =?utf-8?B?bDczSU9uVEN5Rk5tei9JTDJQM24yMjcramU2MXhhRmo2QTB6SWJuR3hWREYy?=
 =?utf-8?B?UEI5cGtIL25JSjRnSHFQeWsrblhubS95VmVZKzJZaFMxNi9hK1ByYldYVHNQ?=
 =?utf-8?B?Y1FVYnJIbUN1bjNuQjBsRVZGaDdjcDN3OVNOby9BSFNsZzNZcW5Oc3pBd1B2?=
 =?utf-8?B?Y0RMSllIczRwamZCMWYrSjd1cTRkYmwwTEptTjZqQjNIenJUY09aSFgvTFZF?=
 =?utf-8?B?WTJ6SVNJMlQxVCtJTC9WNk1TdnRCOWM4UHFFczlzN1diUHM3Ym5vekVZYllF?=
 =?utf-8?B?aUQwRjR0NngyaUdwVW5DdVoxVGtkUFh6SXhneHowSEl1UmxzbDBOV2QwVGRZ?=
 =?utf-8?B?bEIyZnBVMm5tZlRWYTNMZ0g0dm1HZWphQ0xZRENRRGVVSitDeXh1V2FCaWZO?=
 =?utf-8?B?UHkvNTN3akhzN0J6RURIeG1ETlJNV3VJcVhpV2VZWHNhd2ZRWWVQbnlkVFVj?=
 =?utf-8?B?ZlYwRlBLK01HTzN0Sml2elhkT1lNSzZidW1lT2xhU0JzcDZDbHArYk9qWnht?=
 =?utf-8?B?bVJucTl4RGN6S1pQL2tzUlh5NnFpOXZtY0YzNTlDZXZjTE5ubkhOaDdhWndL?=
 =?utf-8?B?T0VyaWNEV1YrNzBwejVnNmI0MlVHaEkyT3J5VGdaTjdOZnJqTUZqRDd2TndC?=
 =?utf-8?B?NXZ0UXpISVJBV1U4Ujl0K1QrZDN6QU5iMElkNXovSmd4RWszSEM2SnpXZGNF?=
 =?utf-8?B?bGQ2T1dpTUVNNE5kb2RNdTh2N2FuOGlZUVB1K1JpZkoySURMcmxMcVhkSkpZ?=
 =?utf-8?B?WnkxTWx1ZmczY1V4dGkySS80N1VzU3Z2V3hmT1JsMzZqeUg4SEY5SG9qQjVN?=
 =?utf-8?B?TE5JQ3pNbUlhT0VWMzl2K0F0YWR2UkE1YWJ5OHkvakRXMWhRQTVwWUVnSVBy?=
 =?utf-8?B?cmp4ZDRja3ptdkNGUCtXS2ZrVlhDRXg2bmhNWENxb3ZuSEJqV0V4ZTFUUE43?=
 =?utf-8?B?TFZlQkFYTU1HMTVrY04wbUhhTU9PVGJxVC9TMTZKOFV5OU5wOFpNUllIcFhL?=
 =?utf-8?B?V3VVTXRBY3JvQkRHT2FWVlUvMWpVZmpQTUhvYVBTY25MTldFcEU2OHJobE4w?=
 =?utf-8?B?ZVM0dEYvVUVCa2o1TFZrYXJQdGRMU1FrSTFhdUs4aG0rdDJrbi9lMHM5ajZH?=
 =?utf-8?B?TzlBU2FqSjFrQ0lpbXBESlBNZlhhWDA2ekN0TllmNTdZczlld1VwbkxYT3Bq?=
 =?utf-8?B?ZnZuNXI1YXdwWkxINVg1T3FDZnJtM1VuSG0ydG9SNENtejEyUmo3V2Zob1Jy?=
 =?utf-8?B?NUkzcXhMdmkyczNqUEdlTEpPQXdzd2ZwS0dlQjIxQy9xRkhWRkI3ajBhTDFR?=
 =?utf-8?Q?JfiqXsPp3xM+LH1D72ry4bjvv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3939ACCA5F6EE242B5BB418745C3F637@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9120023a-4b31-4367-d44c-08db93e80fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 06:08:31.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNnoO1p5iR/BzC6x5MVc4Olusm2zfjzWypJkH0eRVeTTvg1MRbf26SX5/osVXOFRowYAZRF360H4mnDyuXP7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDIzLTA4LTAyIGF0IDEwOjMwICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDIvMDgvMjMgMDY6MTIsIENLIEh1ICjo
g6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBUdWUs
IDIwMjMtMDgtMDEgYXQgMTM6NTggKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+
ID4gd3JvdGU6DQo+ID4gPiBOZXdlciBHYW1tYSBJUCBoYXZlIGdvdCBtdWx0aXBsZSBMVVQgYmFu
a3M6IHN1cHBvcnQgc3BlY2lmeWluZw0KPiA+ID4gdGhlDQo+ID4gPiBzaXplIG9mIHRoZSBMVVQg
YmFua3MgYW5kIGhhbmRsZSBiYW5rLXN3aXRjaGluZyBiZWZvcmUNCj4gPiA+IHByb2dyYW1taW5n
DQo+ID4gPiB0aGUgTFVUIGluIG10a19nYW1tYV9zZXRfY29tbW9uKCkgaW4gcHJlcGFyYXRpb24g
Zm9yIGFkZGluZw0KPiA+ID4gc3VwcG9ydA0KPiA+ID4gZm9yIE1UODE5NSBhbmQgbmV3ZXIgU29D
cy4NCj4gPiA+IA0KPiA+ID4gU3VnZ2VzdGVkLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+ID4gPiBbQW5nZWxvOiBSZWZhY3RvcmVkIG9yaWdpbmFsIGNvbW1p
dF0NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4g
PiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+IFJldmll
d2VkLWJ5OiBBbGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jIHwg
NzMgKysrKysrKysrKysrKysrLQ0KPiA+ID4gLS0tDQo+ID4gPiAtLS0tDQo+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5j
DQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ID4g
PiBpbmRleCBhNmY3YWYxYTllOGUuLmZiN2MzNjUwYTlmNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiA+ID4gQEAgLTI0LDYgKzI0
LDggQEANCj4gPiA+ICAgI2RlZmluZSBESVNQX0dBTU1BX1NJWkUJCQkJMHgwMDMwDQo+ID4gPiAg
ICNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX0hTSVpFCQkJCUdFTk1BU0sNCj4gPiA+ICgyOCwgMTYp
DQo+ID4gPiAgICNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX1ZTSVpFCQkJCUdFTk1BU0sNCj4gPiA+
ICgxMiwgMCkNCj4gPiA+ICsjZGVmaW5lIERJU1BfR0FNTUFfQkFOSwkJCQkweDAxMDANCj4gPiA+
ICsjZGVmaW5lIERJU1BfR0FNTUFfQkFOS19CQU5LCQkJCUdFTk1BU0sNCj4gPiA+ICgxLCAwKQ0K
PiA+ID4gICAjZGVmaW5lIERJU1BfR0FNTUFfTFVUCQkJCTB4MDcwMA0KPiA+ID4gICANCj4gPiA+
ICAgI2RlZmluZSBESVNQX0dBTU1BX0xVVF8xMEJJVF9SCQkJR0VOTUFTSygyOSwgMjApDQo+ID4g
PiBAQCAtMzIsMTAgKzM0LDEyIEBADQo+ID4gPiAgIA0KPiA+ID4gICAjZGVmaW5lIExVVF8xMEJJ
VF9NQVNLCQkJCTB4MDNmZg0KPiA+ID4gICAjZGVmaW5lIExVVF9CSVRTX0RFRkFVTFQJCQkxMA0K
PiA+ID4gKyNkZWZpbmUgTFVUX0JBTktfU0laRV9ERUZBVUxUCQkJNTEyDQo+ID4gPiAgIA0KPiA+
ID4gICBzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWFfZGF0YSB7DQo+ID4gPiAgIAlib29sIGhhc19kaXRo
ZXI7DQo+ID4gPiAgIAlib29sIGx1dF9kaWZmOw0KPiA+ID4gKwl1MTYgbHV0X2Jhbmtfc2l6ZTsN
Cj4gPiA+ICAgCXUxNiBsdXRfc2l6ZTsNCj4gPiA+ICAgCXU4IGx1dF9iaXRzOw0KPiA+ID4gICB9
Ow0KPiA+ID4gQEAgLTgwLDcgKzg0LDkgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+ID4gPiB2b2lkDQo+ID4gPiBfX2lvbWVtICpyZWdzLA0KPiA+ID4g
ICAJdm9pZCBfX2lvbWVtICpsdXRfYmFzZTsNCj4gPiA+ICAgCWJvb2wgbHV0X2RpZmY7DQo+ID4g
PiAgIAl1OCBsdXRfYml0czsNCj4gPiA+IC0JdTMyIGNmZ192YWwsIHdvcmQ7DQo+ID4gPiArCXUx
NiBsdXRfYmFua19zaXplOw0KPiA+ID4gKwl1MzIgY2ZnX3ZhbCwgbGJhbmtfdmFsLCB3b3JkOw0K
PiA+ID4gKwlpbnQgY3VyX2JhbmssIG51bV9sdXRfYmFua3M7DQo+ID4gPiAgIA0KPiA+ID4gICAJ
LyogSWYgdGhlcmUncyBubyBnYW1tYSBsdXQgdGhlcmUncyBub3RoaW5nIHRvIGRvIGhlcmUuDQo+
ID4gPiAqLw0KPiA+ID4gICAJaWYgKCFzdGF0ZS0+Z2FtbWFfbHV0KQ0KPiA+ID4gQEAgLTkxLDQx
ICs5Nyw1NCBAQCB2b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gPiA+IHZvaWQgX19pb21lbSAqcmVncywNCj4gPiA+ICAgDQo+ID4gPiAgIAlpZiAoZ2FtbWEg
JiYgZ2FtbWEtPmRhdGEpIHsNCj4gPiA+ICAgCQlsdXRfZGlmZiA9IGdhbW1hLT5kYXRhLT5sdXRf
ZGlmZjsNCj4gPiA+ICsJCWx1dF9iYW5rX3NpemUgPSBnYW1tYS0+ZGF0YS0+bHV0X2Jhbmtfc2l6
ZTsNCj4gPiA+ICAgCQlsdXRfYml0cyA9IGdhbW1hLT5kYXRhLT5sdXRfYml0czsNCj4gPiA+ICAg
CX0gZWxzZSB7DQo+ID4gPiAgIAkJbHV0X2RpZmYgPSBmYWxzZTsNCj4gPiA+ICsJCWx1dF9iYW5r
X3NpemUgPSBMVVRfQkFOS19TSVpFX0RFRkFVTFQ7DQo+ID4gDQo+ID4gTFVUX0JBTktfU0laRV9E
RUZBVUxUIGlzIG9ubHkgZm9yIEFBTCBkcml2ZXIsIHNvIHBsYWNlIGl0IGluIEFBTA0KPiA+IGRy
aXZlcg0KPiA+IGFuZCBwYXNzIGl0IGludG8gdGhpcyBmdW5jdGlvbi4NCj4gPiANCj4gDQo+IEkg
Y29tcGxldGVseSBkaXNsaWtlIGhhdmluZyBhIGZ1bmN0aW9uIHRha2luZyB0b28gbWFueSBwYXJh
bWV0ZXJzLg0KPiANCj4gU2luY2UgbXRrX2dhbW1hX3NldCgpIGluIERJU1BfR0FNTUEgd2lsbCBh
bnl3YXkgZXhwYW5kIGluIHRoZSBmdXR1cmUNCj4gdG8NCj4gc3VwcG9ydCBuZXdlciBoYXJkd2Fy
ZSwgSSdtIHRoaW5raW5nIGFib3V0IGp1c3QgcmVtb3ZpbmcgQUFMIHN1cHBvcnQNCj4gZnJvbQ0K
PiB0aGlzIGZ1bmN0aW9uIGFuZCBkdXBsaWNhdGUgdGhlIGZldyAoMTUgb3Igc29tZXRoaW5nKSBs
aW5lcyBvZiBjb2RlDQo+IGluDQo+IG10a19kaXNwX2FhbCBpbnN0ZWFkLCBzbyB0aGF0IHdlIHN0
b3AgY29tbW9uaXppbmcgdGhlIG10a19nYW1tYV9zZXQNCj4gZm9yDQo+IGJvdGggRElTUF9BQUwg
YW5kIERJU1BfR0FNTUEuDQo+IA0KPiBBbnkgb3BpbmlvbnMgb24gdGhhdD8NCg0KT0ssIGxldCdz
IHN0b3AgY29tbW9uaXppbmcgdGhlIG10a19nYW1tYV9zZXQNCigpLg0KDQpSZWdhcmRzLA0KQ0sN
Cg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4g
PiANCj4gDQo+IA0K
