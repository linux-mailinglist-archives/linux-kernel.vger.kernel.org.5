Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4B7D48E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjJXHrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJXHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:47:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB58E8;
        Tue, 24 Oct 2023 00:47:14 -0700 (PDT)
X-UUID: 8759c1e6724111eea33bb35ae8d461a2-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n0rCUymJOuhTe1lYgmiE/FWhOdDDsSj3H4DsL9LJIoM=;
        b=hhUZb7G7w+3UG6qtVU3cduNdOMzVJe7YmVrXBCKamMMqcS6tw4kYs7CtzxEQfGg8D2GA8FPZaxgyaLmpiwTP0zZStaqP8P2Z9OleSPigdryRQj9up+58iROeN8toXK5fON3GLTYa2cfrXR81fzuMc3ywAuLLjqOeoBHysReC/Bs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:dd20d14b-2d75-4d78-9692-ffc35db8c6f5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:55bfb3fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8759c1e6724111eea33bb35ae8d461a2-20231024
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yu-chang.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 272476635; Tue, 24 Oct 2023 15:47:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 15:47:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 15:47:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Juz6yTJHpg31evy4s+ctAKOkB1qVmlQ3CVPVDbke6DT45lN09NIGVHWTXAEgOfVaLbIDJsgra+KwWQU4k5JjtQZF6XS2WrwbWXOjJ0ulqporm/ZXZjARc2t2dxhAHHykgsn7IxeiWX/jLPasqxIQN0Z8x8XLXk7MqBXFAdnHHY1LcJgJ9+SF3UkeGrn5IuefxXc/RvjBj+JtIU7HNNLLcH8ZQf+GdE3SrDIcvpjNPpjrobGUjMQOq7+eisgxmpkVQ0BKVZyzvtWnIsFX7lwh0omcHRVbYWTCEoAWfBwkUDYn81/dBD1Gbx6ZSMjWT8BN9GIfknP5lVqtAyvirAUuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0rCUymJOuhTe1lYgmiE/FWhOdDDsSj3H4DsL9LJIoM=;
 b=STDB/rlx/D8j/kz2ZaqXKQ+K+MV8OIs+ei7Tm8Sp/u3lU5OgApONa8SiSIyYNm/+ABHns1Y2Kz8uBUQGfz+4F7cvhWatNufslHH9+M0jUgVscpKuA6H0aF4S/jPOhvP2KfUncKTJ2mihGIC2rrXCXCAKEMFtjhoQZ06PRLTJYFLtZME7ZCUcV5uvnbmAdqYquz62Zg0WLJlpb26WbcNG+fbUSzaf1ariIhnD9SavcYeITVvxw3oPATiPhbwwtDNQXIFeBkcCIDeyCQV1HztC+v1Lfxuki3/21NRgrfEyNcrsS053jcni555axEw181WBfrgbcXyfnwIp8P59/MLahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0rCUymJOuhTe1lYgmiE/FWhOdDDsSj3H4DsL9LJIoM=;
 b=EpKTkeHFiIMbsjDtyXtgf3ClRsLQ21+/xLC1kDUrCLIEoRBJfJVrgAN/gjAMP+0UoATV2RibkMMNumIKeDYdhfTrHdHdhnI8LHonY3EwmifPBrnIdiGn1GEgKxfvI6Rj7JILURkiQtAfCpyrMeU2pZ5DnNkso8fH5O7aBinapwI=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by KL1PR03MB5540.apcprd03.prod.outlook.com (2603:1096:820:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 07:47:00 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::eae7:2692:e6a8:e278]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::eae7:2692:e6a8:e278%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 07:47:00 +0000
From:   =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        =?utf-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
Thread-Topic: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
Thread-Index: AQHaBaaHQyCeGVCVIkaRHyl/V0yhJrBSGxiAgAYj9oCAAAG2gIAAUHkA
Date:   Tue, 24 Oct 2023 07:47:00 +0000
Message-ID: <9c1e10b56db315e03daa3df5918cde844297c680.camel@mediatek.com>
References: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
         <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com>
         <283d18028590d57025e5654d18b8b5b7.sboyd@kernel.org>
         <CAGXv+5EpBLnXVdxnk9wBZi5F7U5wdJRfYH7fgg4Lkr1HJXm+WA@mail.gmail.com>
In-Reply-To: <CAGXv+5EpBLnXVdxnk9wBZi5F7U5wdJRfYH7fgg4Lkr1HJXm+WA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|KL1PR03MB5540:EE_
x-ms-office365-filtering-correlation-id: cbf26b5b-b020-49c2-f676-08dbd4656838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZ6L8gLHU+fmFOC5E6M159Rqq7oT5Dr/vPmFk6VrtblAsqsEEawdt8eGSClMuX2JqhiVYxLcxpBO/Du29qU9OucrzETZU1G/6rB9KVNAJlXkn5ElgxIJdsLexMgo8mJybYnxS6q8q/RcJpuAHQDRyhHVE5pp2B+mKNeB5biPMJXeqkVtzzE3+VSi1MY+vUZEkBryILT9y0/v99Ju2UN0mUyE7OzH31jgOrfJXCIWZXpNJabwyEhwS4p/L6xrLDWqyff6boJLFoP3yBkzdsUvKWaownIVz8szAXHVLmEbH6tILVDWBDHaka0wT7iioCq2gJSfkbWhCosM9Q1ZK2m+hoQ7S1x5wo3E2UGgv85JMojT8cW4lJH0R9VGtPlra8rdRJbuz+79sFTFC1OJcdw8meKu8sFzQFZlXXgDzNktY/sb/ER3it7cJVxi7y/Kj/aYrnKiRsSJ90y+MRCoEVq5oUzcNnipyUnc07FI/AvJAZWPNUp7H8LG4Vp28Jm8eszbzEaMO8jOqvlaMOPZCJnbIpWAIuUwD/BBKmc48Za/AINs5IxAzz38OBPHJe4tUjIt1CfMuGf5F10UKWK98d/QNVFqLqiGDAaZIDz+oPYaQ3YJG7/LREoz68OGKthgqxdkcyIKKdWUrZ0etoU5FmNw6/TgjNv1SdfTIB6A3+4CWsI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(41300700001)(38100700002)(66946007)(122000001)(110136005)(66446008)(64756008)(76116006)(54906003)(66476007)(316002)(66556008)(6506007)(2616005)(71200400001)(91956017)(478600001)(6486002)(53546011)(6512007)(83380400001)(86362001)(7416002)(5660300002)(36756003)(4326008)(85182001)(8936002)(8676002)(26005)(38070700009)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHd2OE5UNGhxWDh2SGFZN084VVFyWnBKcVNLM2Y2SGd4aUtCMDAyQkJaall6?=
 =?utf-8?B?L1NpVVk3S0JZQVpIL0ZmOEhHdUZFZ2plS0k2clphb2IvWllsclp4KzRsTnRF?=
 =?utf-8?B?QnZETVhHSVRpV1dwU2RTVXRlVitEWjVubitkTTlZMFZHb3pJcGd0QzU4bzM0?=
 =?utf-8?B?ejBEc21maXhPSUUzbVdRckxuRXQwZDVQczRFR3AyNFEycEpmS0JBckZ1VHpZ?=
 =?utf-8?B?YWdZT3lhWENsQ0tvQ3FNclV2QklSVnZ0MVJyWnFLTWZsbnAzallwTjdDa0Rq?=
 =?utf-8?B?YU9sdzBqL0d2SkxJUHdZMngxQkJwVFh6K1FPSVZvTGdKMGp0dEljRmZWektt?=
 =?utf-8?B?S0c3SEZhcG9pVndwMWxiTm1iZlJjcXFsb0lBdXNvVFJheG1jcTI0dVNvOHUx?=
 =?utf-8?B?dUtxNUthQi9aekh0enlrTDc3L0d0Wk1BSTJaQTFEYUR4Zmd3anlLTDA2dVNZ?=
 =?utf-8?B?K3dTY1J2S1l2NzBPa2RXZlZUQVQ3Njg5TkU5Y2F3cDlsdkZFTkNxcm5wUlVX?=
 =?utf-8?B?YVBaQmFzWUhQZk9pL3ZZblJzdnhBb3dUaGhxUEo1R25ZbjJ3TStKTDBSTlRK?=
 =?utf-8?B?SjBVWnNJa1I2YTNEWmZad3k5VkcxWkF0SmEzTUxYcFpOaWszUkNCZHg4S3Vr?=
 =?utf-8?B?aFNnajNHL1ZXWEhhS3hhR1AxWnpTVThnd3ZaVWZtWHk0VU5UQm9JWW5GRW9Z?=
 =?utf-8?B?R3h6T1J4ZUtQeU9ZZW1zK2wwV0ttRGlDaytEWW8xVjlraUR5R2tIWHRXZlJQ?=
 =?utf-8?B?ckgyS0VteksvN2U0eDNWRkRIaWl3UW8zZU9RaE5ncmx2M2V3dndnbEtiNmpB?=
 =?utf-8?B?a3BKQlAvNEw2VTRWckh6dVZYT2JNOW16L3NtTVh0dittUlduVE5VVWpxMHFt?=
 =?utf-8?B?emJUR1BRdnhkNmFMcDQyK2dqeHBSYWx1ZzA4eHBMb1VLMUlZaVgremQ2UWU3?=
 =?utf-8?B?TDA2dDVEZldqcTZTOGVvbFNEYUFpQktmekFuTnBURm42L2pXclgzdEdTQUpD?=
 =?utf-8?B?bjdlcC9Dblo3QlpPYUFuSFQzbE9JbU9obTFNbWpNNkJ0QzNPMHVKN1VvREln?=
 =?utf-8?B?alJNVGhqMERUemRndU14SkRLSkVIQVVaOG5Zai9qdUhWekxLaFl2WlBWeGtv?=
 =?utf-8?B?VmZYekRRRXBRRjUvQlN1NkYyMm0wL1RhQmxDWkNqY2lHQUxrMDZrOUZwS1pl?=
 =?utf-8?B?ZGlEZjVwUFhWNU93cHZGbGdUdFA4c0lMaDVuS3ZWSlhGbE1SN21aWGNXUUxm?=
 =?utf-8?B?SVA4aW5LYmJiaDZ1TnBBOUZHUDVWbzcrT3lmY29GQVZ0OHlxNW5uSkRvL3Yx?=
 =?utf-8?B?NFh2a20zVmVOSGxDSGQ1RFBaTFkyMFpqM0ZKOENDd3JGZ2VQWjhuLzJGMDN0?=
 =?utf-8?B?ZTRJOE0zdGpITDUxREtSSW02SHNCREpEV2ttdWM3QjhPVUpXWmF2RUdEOXRD?=
 =?utf-8?B?cWoya0xmMWRSTy91V1orT0ZZMGE0TFp4b2JjalZ1YjEvRFhXSTRjNW9qVERy?=
 =?utf-8?B?clRrbkFsYVVpUjNFbFFaM1F2cWtXRFZNUHR3OG5rZHphS2JGUzFkc2NlaEhV?=
 =?utf-8?B?OXdLdEp3cFM1VVM4eFliMGZjVHJSTTRsNzlueFVuQWdIdXlIczcvWUhrUy8z?=
 =?utf-8?B?d0dPVVhiVXRyekRnVjVDVVppSkY5R3hHb252WmpZamhESXJmK3J3M29ESVJU?=
 =?utf-8?B?S2VWUzA3Sjd6WjFzNHYyQzJrazh1c1pEQWQwam1rVGcrVlgva3lvYTdyVTVs?=
 =?utf-8?B?U0ttbmVBTVQzNGNxSW9VRDR0N2NVeVEzVWJIT2oxZmZZWEQzS1owZitGT3dB?=
 =?utf-8?B?WnJlREtMTVBsWHNsSHQ4aWdCY0ZVeUFiNnFaMW5OenJRMlZyb0ZlajFzbWIr?=
 =?utf-8?B?enNIek81SjhsZ1JSWkZVZ2QvZ1h5THFNNFdWUlhxVmo2NnF0U0owZy9OVmZ6?=
 =?utf-8?B?WU4ySjlmQzE3ZzBCWkoyUlVNTkQvTUlvbUp0SmR0MzdvK3RBbHZDRkpZdnFm?=
 =?utf-8?B?Z01BeHJnTW5zTHBLbGMrMEwzTk5QbkNvZzI4TDIxMEkzMCtKWHdEbkRuL3pq?=
 =?utf-8?B?SFJrUm1BSk1MTVhGUW9paXpoWTlpQUttR3hYS2FoNCthZHlsZ045eG84YzNw?=
 =?utf-8?B?eEJia1hxWGdZN1ZMZTNLR2pDWTBFaGVjNVkrYnZXb05KTUR0LzI2dGdNYkY4?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45D0F809F7EA3E40966EAC2246C57253@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf26b5b-b020-49c2-f676-08dbd4656838
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 07:47:00.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iL5CcC7RKnwxl/kHcd25V8p0FPV1MOtHdcrg7/0Sd+aLWIHcvRAyDxGghHpMUR6Xeh0QUg3jHzenvnMTnoOgsHBrhwP3lP8Vp4iFbfDBA5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTI0IGF0IDEwOjU4ICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDEwOjUy4oCvQU0gU3RlcGhlbiBCb3lkIDxzYm95ZEBr
ZXJuZWwub3JnPg0KPiB3cm90ZToNCj4gPiANCj4gPiBRdW90aW5nIENoZW4tWXUgVHNhaSAoMjAy
My0xMC0xOSAyMjowNjozNSkNCj4gPiA+IE9uIFRodSwgT2N0IDE5LCAyMDIzIGF0IDg6NDnigK9Q
TSBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+ID4gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVs
cmVnbm9AY29sbGFib3JhLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBGaXggdGhlIHBh
cmVudGluZyBvZiBjbG9ja3MgaW1wX2lpY193cmFwX2FwX2Nsb2NrX2kyY3s0LTZ9LCBhcw0KPiA+
ID4gPiB0aG9zZQ0KPiA+ID4gPiBhcmUgZWZmZWN0aXZlbHkgcGFyZW50ZWQgdG8gaW5mcmFfYW9f
aTJjezQtNn0gYW5kIG5vdCB0byB0aGUNCj4gPiA+ID4gSTJDX0FQLg0KPiA+ID4gPiBUaGlzIHBl
cm1pdHMgdGhlIGNvcnJlY3QgKGFuZCBmdWxsKSBlbmFibGVtZW50IGFuZCBkaXNhYmxlbWVudA0K
PiA+ID4gPiBvZiB0aGUNCj4gPiA+ID4gSTJDNCwgSTJDNSBhbmQgSTJDNiBidXMgY2xvY2tzLCBz
YXRpc2Z5aW5nIHRoZSB3aG9sZSBjbG9jayB0cmVlDQo+ID4gPiA+IG9mDQo+ID4gPiA+IHRob3Nl
Lg0KPiA+ID4gPiANCj4gPiA+ID4gQXMgYW4gZXhhbXBsZSwgd2hlbiByZXF1ZXN0aW5nIHRvIGVu
YWJsZQ0KPiA+ID4gPiBpbXBfaWljX3dyYXBfYXBfY2xvY2tfaTJjNDoNCj4gPiA+ID4gDQo+ID4g
PiA+IEJlZm9yZTogaW5mcmFfYW9faTJjX2FwIC0+IGltcF9paWNfd3JhcF9hcF9jbG9ja19pMmM0
DQo+ID4gPiA+IEFmdGVyOiAgaW5mcmFfYW9faTJjX2FwIC0+IGluZnJhX2FvX2kyYzQgLT4NCj4g
PiA+ID4gaW1wX2lpY193cmFwX2FwX2Nsb2NrX2kyYzQNCj4gPiA+ID4gDQo+ID4gPiA+IEZpeGVz
OiA2NmNkMGI0YjBjZTUgKCJjbGs6IG1lZGlhdGVrOiBBZGQgTVQ4MTg2IGltcCBpMmMgd3JhcHBl
cg0KPiA+ID4gPiBjbG9jayBzdXBwb3J0IikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25v
QGNvbGxhYm9yYS5jb20+DQo+ID4gPiANCj4gPiA+IEknbSBjdXJpb3VzIGFib3V0IHdoYXQgbGVk
IHRvIGRpc2NvdmVyaW5nIHRoaXMgZXJyb3I/DQo+ID4gPiANCj4gPiANCj4gPiBJcyB0aGF0IGFu
IGFja2VkLWJ5Pw0KPiANCj4gTWVkaWFUZWsgZW5naW5lZXJzIGFyZSBzYXlpbmcgdGhlIG9yaWdp
bmFsIGNvZGUgYWxyZWFkeSBtYXRjaGVzIHRoZQ0KPiBkb2N1bWVudGF0aW9uIHByb3ZpZGVkIGJ5
IHRoZWlyIGhhcmR3YXJlIGVuZ2luZWVycy4gSSdtIHRyeWluZyB0byBnZXQNCj4gdGhlbSB0byBy
ZXNwb25kIG9uIHRoZSBtYWlsaW5nIGxpc3QuDQo+IA0KPiBDaGVuWXUNCj4gDQpBZnRlciBjaGVj
a2luZyB3aXRoIEkyQyBjbG9jayBoYXJkd2FyZSBkZXNpZ25lciB0aGVyZSBpcyBubw0KaW5mcmFf
YW9faTJjezQtNn0gY2xvY2sgZ2F0ZSBpbiBiZXR3ZWVuLiBBbmQgdGhlIGNsb2NrIGRvY3VtZW50
IGF0IGhhbmQNCmFzbG8gc2hvd3MgdGhlIHNhbWUgcmVzdWx0LiBHZW5lcmFsbGx5IHNwZWFraW5n
LCB3ZSB3b3VsZCBsaWtlIHRvIGtlZXANCnN3IHNldHRpbmcgYWxpZ24gd2l0aCB0aGUgaGFyZHdh
cmUgZGVzaWduIGRvY3VtZW50LiBJIHdvdWxkIHJlY29tbWFuZA0Kbm90IHRvIGNoYW5nZSB0aGlz
IHBhcnQgb2YgY29kZSwgYnV0IGVuYWJsZSBpbmZyYV9hb19pMmN7NC02fSBwcmlvciB0bw0KdGhl
IHVzYWdlIG9mIGltcF9paWNfd3JhcF9hcF9jbG9ja19pMmMgY2xvY2suDQoNCkJlc3QgUmVnYXJk
cywNCll1Q2hhbmcNCg==
