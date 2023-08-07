Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDCF771820
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHGB71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHGB7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:59:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5B10FE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 18:59:23 -0700 (PDT)
X-UUID: 057998f834c611ee9cb5633481061a41-20230807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j3sTvkRElgUOUMDoE5JbI7F6jyrdCB89WqHYoGTf1Z4=;
        b=fGzL6L0J6wu9G3C/zyWuMDPZPhSzLVpwHGq5DY5mVUU+PF0sLXPDXQ/IV1MPDnV+0/KiEAwiwitJDcxEY7FV4/GHE8OVxjBlvac7/DaYidbcn09RjJiia8VwjjMo/pyHFkcGm3YGk8gBU0EmPkT50I3PGIf/aXtuSirqdO92AIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:939b6abd-1fef-447f-a6a5-0317d8a08ed7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:c1c7e042-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 057998f834c611ee9cb5633481061a41-20230807
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1199290363; Mon, 07 Aug 2023 09:59:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Aug 2023 09:59:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Aug 2023 09:59:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfwELaz0KYMVbRs8xc8XBiK48xYdxTtyZiaZ6n6PGBdsmZW/rJkwxuFhG7f7Xe7UA919j1Wjfsvpmktyq4GtDRnZM2my+ylMYUfb0TeSta5xPm0ZAZsZzVMTanrfMkkAR/Nl73iRTmmNbwwODp9Tmv0ZVVd59RSYIZ5Ss0kU3wil+IYKZb4qkMriFpXsl74z2kr6p7VjQ6mM+tp5tdVQwiT5jWerS3etOn0LJzdkqPIIQ/v6ew8LQjlx1n84uE5nX8sIgizr43XeBO7fzyNZ79alL0+u8+O78EmP3RMTn9ndt3xqMeGiLTtModPOTd/WU4LpH+GLhW8c6BJNJAg1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3sTvkRElgUOUMDoE5JbI7F6jyrdCB89WqHYoGTf1Z4=;
 b=iu+aPzE6qloD4U4eh3zhP7eWA0LdI3f5GxasauRYLYdMB0j6X8aRn8WVHIkoCSJ4nP7rYEFqSdf2Og7zaYbSAiJ30aONAYSxN0KjO7fxFaS8TvYYD3M8RXvwoUOW/lAwqlG2b/EUgaoj1zIQPIzc37xIb2dalldq0dBJDlMpm6aUbcpgOJnKF2quCVIFYxDuKmpjfN0JPcpLMdDYlF/JJvnIryCO6b0EHXyprgsqbAbLtok4mNrEuSnqHW/EOnSJCcB7MZlpeuP4WO+/LnlEWGIuYcc7xWN969T76p550CoA5mYeie0Cu5NpQjlNnACmFTniZH/OnDNQEjUlMiiFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3sTvkRElgUOUMDoE5JbI7F6jyrdCB89WqHYoGTf1Z4=;
 b=sEhx0MIxu+rfo0dp++4Okhn1HENQ5PXXRx1omz1G+uTuBID1BDv3XaPvQxsXcL2xIj16qSLyXcI1EG7xtZcJttSuyThUbz5XxNPcv8gsmeVlETq/MjRc/rf5AvvUDM8urpnREAv7Pt+BtDbGlAnvzltE55Xp/7UrcdlUpFXp+ik=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEYPR03MB7464.apcprd03.prod.outlook.com (2603:1096:101:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 01:59:15 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a%2]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 01:59:15 +0000
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
Subject: Re: [PATCH v2 2/3] ASoC: mediatek: common: revise SOF common code
Thread-Topic: [PATCH v2 2/3] ASoC: mediatek: common: revise SOF common code
Thread-Index: AQHZxcsFCbhN1gxLdEiL9L3yxJB1/6/YO+8AgAXeAgA=
Date:   Mon, 7 Aug 2023 01:59:15 +0000
Message-ID: <d15759427f3f23fcb141ff7059f03685aee19ad8.camel@mediatek.com>
References: <20230803052607.25843-1-trevor.wu@mediatek.com>
         <20230803052607.25843-3-trevor.wu@mediatek.com>
         <b363f992-9e70-cf10-6b21-801aa266ec68@collabora.com>
In-Reply-To: <b363f992-9e70-cf10-6b21-801aa266ec68@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEYPR03MB7464:EE_
x-ms-office365-filtering-correlation-id: 7b751596-0815-4aea-232a-08db96e9e75f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eXbMkNGmC/JBPVLWJ553ThvEXiuwDNiMCJ3NzayDBUAKDm+bLmBp4OxyoJ49eGLPU8JJy3LN3Y10IZUoeGq4Io+9GfE89B7HLBhxA9+oa7h+QJ5mmDZAGWvwuk4tR3plpb9HwLmFR4dzZQrbcKLmTFpJIcDL/XVVrXkXhRSb4GjEcpKN8q1nBmJwZFqWAKk8j26tJYRwN7J1CeWJtenwChmuDW3iKJJR5vkspVjgkc6SQq2kd5BGaTogN07+4S2YNbJP2ckelZMVoSbr6xEfBviBXmdJ3R0l0cgO4feWm06h78Fe7NiWeBJD9CV4ClMVi+QmWxl4VwzRPHim90+FWM7jUhOc0T1c5sIbWNWQdezr4S9vHNwBPdr4YH9ttTImqPQpXtbL9skq949UdjdDoaWTDPYGKKFta31JuRxfbNpB0AP/BCmDOxWs7OpIknt+3zxaD8I5c+zuhrBqud76lncgBSyyVmQndVwtgAIwhbhByvSGVhGt8ptb99gVnv8qbyJ7zUIkM/Hm1HjVsciH5mv6I9WaoHNCypDzQgJj/6roevCabIcsW5lhlJSPQx5T5d1aGANy5NTn+JN/VlSVYgANRzCs4hEZl3gORODv66H6WPwTgQ57xUD//547IQEk9Yt2bvF/6rRToLBMqrf5kzaDChvKhxHz5tjMYEUWvHNIhATzqZiN42M7YIJH9tP2CCjkgnjXRnMF5WnUN9Ed/XJsNa7tlvKzOvszxu4JE7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(1800799003)(186006)(12101799015)(110136005)(54906003)(478600001)(6486002)(6512007)(71200400001)(26005)(66556008)(66476007)(66446008)(64756008)(91956017)(76116006)(66946007)(316002)(4326008)(2616005)(83380400001)(36756003)(85182001)(86362001)(2906002)(5660300002)(38070700005)(38100700002)(122000001)(6506007)(41300700001)(8936002)(8676002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1dONjRBWXpkYUFMNGRDeGZBbkNUQ3dmTDRNYk1DSlFWUXpycmRYU0s4bjZY?=
 =?utf-8?B?THpsSlVDN3JtUGluamtCckg5ajZDSExLa0JsRndWWjBONmFtQmZhTFFpbHRH?=
 =?utf-8?B?emNyb00vK2hDUFc3d1RMSmVMR0t6aXo4WTAzOXBBUTZSaDJCQ3dyL1RVa2VF?=
 =?utf-8?B?Y3F3KzZxVnFFSnd6Njl6TC93QWp4L2d6YjdpakdVWGtSRUdkMDU5V1A1dWRH?=
 =?utf-8?B?MGorbXhxWFNVOVlRaExGL09QaGdCYjFFVWJXN2JYM2ZKYmU3MGhEZUZ2dTdX?=
 =?utf-8?B?alNuaHhXRHhlWXFid3RzREZONENveHFGWVBtVlgxMzNWVGREUDNSZ0VBbnJD?=
 =?utf-8?B?a3YycUtMOE5xa2J3Nm0zakVSalFLQU0yVTgvcE51aWwwWUU1aUdKSGYxL2ZF?=
 =?utf-8?B?ZDAyUDREQmozQUdTVm9oeFQ5RUhTb1dySUZkTi9BTEVUSzRxM2lIcFdoRm4r?=
 =?utf-8?B?RVFDZ2JwckVzTE1GUEExdFQzdjdaY2k2TnYwVGFqbXEyaWd3VkhyNldaV21B?=
 =?utf-8?B?WEZoSTNGZzdhSHB4NHprTkcrajFzSEM3TnlZMXVkc3Y4cXdQUk9qK2UvRWpy?=
 =?utf-8?B?UjBKU0RKbWdVTHVHZWFZck5FcEJNOTd1RlRaZ1Y5bGFZREUrWnJiNkNUK1VU?=
 =?utf-8?B?dU1YYkwxY0x0ZGtzZWk4VmZsU0tqZzY3N3NvNmNxbTBMbHVXS1ZnWlhFbW85?=
 =?utf-8?B?aW92ck1iaERuVU5HYnRFd00xa2JrRUc2MExLRVQrZnJNOVd2eW5ERHkvQ1Q1?=
 =?utf-8?B?T0Q0ZGF2L294RWM4QTFvQnJKTEp3a29MOEVEK2h4VkVzTVFBemVmMWVnNDVJ?=
 =?utf-8?B?Rm5PN1dyYXJMVXNuVzJQUmF0UlVVdkVDRHdwOTVLQWZDWndGTVY5ZHpPSlFM?=
 =?utf-8?B?QUdSQ0g4WXRuL1VoejFMdXo4cFJwQnh4UU5EeTBZc1Q5U0ZLSnI5YWF1dVBS?=
 =?utf-8?B?UXUvVjlhYUQySy81R2N3Yjk5UUxKSFJ1dXpqL3FxZm5QVGRZWnpzMlc4OFU5?=
 =?utf-8?B?dTBkS3d3SXZZSWZ1a3RNRU1CQytvSmREbWhDVUcxMVJ5d0ZySDdQSjN6MlNN?=
 =?utf-8?B?R0docW12Tnp3akhVNnVlZ0NZYXIzSVBZcm1WODYzTVdDZ2hjT1o1TTVKd05G?=
 =?utf-8?B?U3Z0S2pPWUcwanc2UlpSRDhIMDBJSnhDdW1Ubk9la3NGVm9icEo5MEo3UlFP?=
 =?utf-8?B?Z05qR3ZMQ1hFdjVwbm9jYUV4TkIwSVUzNjdCQzhHcEo3VFpRL2dvVURzeTdn?=
 =?utf-8?B?cE9yUlBuQTBEaVRWelQrWDBqQVg0YkxRelpNdmxuUDcvaC9rV3lZK01BSjI2?=
 =?utf-8?B?cllDTnVNWE1zajdQcWhkWTg1a2lRSXNSZ2hONFY5em9FV1pacEFOM1lNQjhI?=
 =?utf-8?B?ZHBZWExDVFgxc1hCeWc3RHEyS3FuNDkvbzFJaEpBUEs5M0VZZFpzd1QrWXhC?=
 =?utf-8?B?L01zNnh2OUpnVG1VSC9jZ01UM0Q2WlBIRUExSUNWNHZ3N3ZWb0hFcGtLKzlV?=
 =?utf-8?B?dkNkc0o4VE11UUZwMzhtS1JEd0U2VlZ4SGNGbDU4Y2k2N3hWa1NXN09Oa2hu?=
 =?utf-8?B?ZDVqNUkxUGl3SDdpYkg4YklaN2wvRDB3OFFFdTh4Y3M4MmtTdENIQ1FSVkdm?=
 =?utf-8?B?MFE2Q1ZlV2hoZHlxVy9SZ0FYZklmcFZManF6K0lveTQyRXluYk5vNFd1cmVW?=
 =?utf-8?B?b2xJbjA5MTNKSUFic2dhNkRKZDRVOWZaZExvRDdrbnhhUHp1VjRjb3hPVTYw?=
 =?utf-8?B?cUxIbk9uVEg1NGJKVC93aTZIWHFabHVVSk0zOU4wMi9Td3Z2YlVQeElML2c0?=
 =?utf-8?B?U2JLcEhBYTJiOUhIYWVYaFJHSFgxMjNNUGtNaUhsVWJtOGxRUlJ5TzN3YUs1?=
 =?utf-8?B?aU1scENxeW9vUU1EVitFR1ZJK1dNY25wWVZ1VFpyT0lBMWpqbUdQQVBZLzlC?=
 =?utf-8?B?VjVHZ1N2TTZkK1Vhai81ZDl6d0c2YUtoaDhLZmQvbk83M3E1QzdUdkEzVFZh?=
 =?utf-8?B?eDB6V08yQU1EYldQcnpkelFlZ2hHbk9DeFN3bWx1akp4VnQ2WnFrV0FZc3E4?=
 =?utf-8?B?K1lSb3RPY1pzN2RYRUo3clNyQmVkUWp3THNNSnB5VUtTY0YzaFU3MzNkbFV5?=
 =?utf-8?B?cnBlRkJKdHlOODV6WXVFZTdOUXkvRENnbWt1djBvM3QxcEJJZzgwK20yTGtE?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA8D7C3DF0818C48A33CD52B4E2E119B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b751596-0815-4aea-232a-08db96e9e75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 01:59:15.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5WjoaTl5V8Dt5TR6B1S8azGqRuyoV/0B7p3+840s7VEsYT/h6YTRxQu+mVGqOThO2oBJnOXoZz6YkDQox9s8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7464
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTAzIGF0IDEwOjIzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDMvMDgvMjMgMDc6MjYsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IE9yaWdpbmFsbHksIG5vcm1hbCBkYWkgbGluayBmaXh1cCBjYWxsYmFjayBpcyBvdmVyd3Jp
dHRlbiBieSBzb2YNCj4gPiBmaXh1cA0KPiA+IGNhbGxiYWNrIG9uIG10a19zb2ZfY2FyZF9sYXRl
X3Byb2JlIGFuZCBpdCByZWxpZXMgb24gdGhlIG1hcHBpbmcNCj4gPiBkZWZpbmVkDQo+ID4gb24g
c3RydWN0IHNvZl9jb25uX3N0cmVhbS4NCj4gPiANCj4gPiBJdCdzIG5vdCBmbGV4aWJsZS4gV2hl
biBhIG5ldyBoYXJkd2FyZSBjb25uZWN0aW9uIGlzIGFkb3B0ZWQsIHVzZXINCj4gPiBuZWVkcw0K
PiA+IHRvIHVwZGF0ZSBzdHJ1Y3Qgc29mX2Nvbm5fc3RyZWFtIGRlZmluZWQgaW4gbWFjaGluZSBk
cml2ZXIgd2hpY2ggaXMNCj4gPiB1c2VkDQo+ID4gdG8gc3BlY2lmeSB0aGUgbWFwcGluZyByZWxh
dGlvbnNoaXAgb2Ygbm9ybWFsIEJFIGFuZCBTT0YgQkUuDQo+ID4gDQo+ID4gSW4gdGhlIHBhdGNo
LCBtdGtfc29mX2NoZWNrX3RwbGdfYmVfZGFpX2xpbmtfZml4dXAoKSBpcyBpbnRyb2R1Y2VkDQo+
ID4gZm9yDQo+ID4gYWxsIG5vcm1hbCBCRXMuIEluIG10a19zb2ZfbGF0ZV9wcm9iZSwgYmFjayB1
cCBub3JtYWwgQkUgZml4dXAgaWYNCj4gPiBpdA0KPiA+IGV4aXN0cyBhbmQgdGhlbiBvdmVyd3Jp
dGUgYmVfaHdfcGFyYW1zX2ZpeHVwIGJ5IHRoZSBuZXcgY2FsbGJhY2suDQo+ID4gDQo+ID4gVGhl
cmUgYXJlIHR3byBjYXNlcyBmb3IgRkUgYW5kIEJFIGNvbm5lY3Rpb24uDQo+ID4gDQo+ID4gY2Fz
ZSAxOg0KPiA+IFNPRiBGRSAtPiBub3JtYWwgQkUNCj4gPiAgICAgICAgIC0+IFNPRl9CRQ0KPiA+
IA0KPiA+IGNhc2UgMjoNCj4gPiBub3JtYWwgRkUgLT4gbm9ybWFsIEJFDQo+ID4gDQo+ID4gSW4g
dGhlIG5ldyBmaXh1cCBjYWxsYmFjaywgaXQgdHJpZXMgdG8gZmluZCBTT0ZfQkUgd2hpY2ggY29u
bmVjdHMNCj4gPiB0byB0aGUNCj4gPiBzYW1lIEZFLCBhbmQgdGhlbiByZXVzZXMgdGhlIGZpeHVw
IG9mIFNPRl9CRS4gSWYgbm8gU09GX0JFIGV4aXN0cywNCj4gPiBpdCBtdXN0IGJlIGNhc2UgMiwg
c28gcm9sbGJhY2sgdG8gdGhlIG9yaWdpbmFsIGZpeHVwIGlmIGl0IGV4aXN0cy4NCj4gPiANCj4g
PiBBcyBhIHJlc3VsdCwgdGhlIHByZWRlZmluZWQgcmVsYXRpb24gaXMgbm90IG5lZWRlZCBhbnlt
b3JlLg0KPiA+IEhhcmR3YXJlDQo+ID4gY29ubmVjdGlvbiBjYW4gYmUgY29udHJvbGxlZCBieSB0
aGUgbWl4ZXIgY29udHJvbCBmb3IgQUZFDQo+ID4gaW50ZXJjb25uLg0KPiA+IFRoZW4sIERQQ00g
ZmluZHMgdGhlIEJFIG1hcHBpbmcgYXQgcnVudGltZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4v
c29jL21lZGlhdGVrL2NvbW1vbi9tdGstZHNwLXNvZi1jb21tb24uYyAgfCAxMDYNCj4gPiArKysr
KysrKysrKysrKystLS0NCj4gPiAgIC4uLi9zb2MvbWVkaWF0ZWsvY29tbW9uL210ay1kc3Atc29m
LWNvbW1vbi5oICB8ICAgOCArKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA5OSBpbnNlcnRpb25z
KCspLCAxNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL21l
ZGlhdGVrL2NvbW1vbi9tdGstZHNwLXNvZi1jb21tb24uYw0KPiA+IGIvc291bmQvc29jL21lZGlh
dGVrL2NvbW1vbi9tdGstZHNwLXNvZi1jb21tb24uYw0KPiA+IGluZGV4IDZmZWYxNjMwNmY3NC4u
M2ZiMTkzYzFmMGQ5IDEwMDY0NA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9jb21tb24v
bXRrLWRzcC1zb2YtY29tbW9uLmMNCj4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvY29tbW9u
L210ay1kc3Atc29mLWNvbW1vbi5jDQo+ID4gQEAgLTU0LDYgKzU0LDggQEAgaW50IG10a19zb2Zf
Y2FyZF9wcm9iZShzdHJ1Y3Qgc25kX3NvY19jYXJkICpjYXJkKQ0KPiA+ICAgew0KPiA+ICAgCWlu
dCBpOw0KPiA+ICAgCXN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpkYWlfbGluazsNCj4gPiArCXN0
cnVjdCBtdGtfc29jX2NhcmRfZGF0YSAqc29jX2NhcmRfZGF0YSA9DQo+ID4gc25kX3NvY19jYXJk
X2dldF9kcnZkYXRhKGNhcmQpOw0KPiA+ICsJc3RydWN0IG10a19zb2ZfcHJpdiAqc29mX3ByaXYg
PSBzb2NfY2FyZF9kYXRhLT5zb2ZfcHJpdjsNCj4gPiAgIA0KPiA+ICAgCS8qIFNldCBzdHJlYW1f
bmFtZSB0byBoZWxwIHNvZiBiaW5kIHdpZGdldHMgKi8NCj4gPiAgIAlmb3JfZWFjaF9jYXJkX3By
ZWxpbmtzKGNhcmQsIGksIGRhaV9saW5rKSB7DQo+ID4gQEAgLTYxLDEwICs2Myw3NCBAQCBpbnQg
bXRrX3NvZl9jYXJkX3Byb2JlKHN0cnVjdCBzbmRfc29jX2NhcmQNCj4gPiAqY2FyZCkNCj4gPiAg
IAkJCWRhaV9saW5rLT5zdHJlYW1fbmFtZSA9IGRhaV9saW5rLT5uYW1lOw0KPiA+ICAgCX0NCj4g
PiAgIA0KPiA+ICsJSU5JVF9MSVNUX0hFQUQoJnNvZl9wcml2LT5kYWlfbGlua19saXN0KTsNCj4g
PiArDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTCht
dGtfc29mX2NhcmRfcHJvYmUpOw0KPiA+ICAgDQo+IA0KPiBzdGF0aWMgaW50IG10a19zb2ZfZmlu
ZF90cGxnX2JlX2RhaV9saW5rKHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lDQo+ICpydGQsDQo+
IAkJCQkJIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rDQo+ICoqc29mX2RhaV9saW5rKQ0KPiB7DQo+
IAkuLi4gdmFyaWFibGVzIGhlcmUuLi4NCj4gDQo+IAlmb3JfZWFjaF9wY21fc3RyZWFtcygpIHsN
Cj4gCQlmZSA9IE5VTEw7DQo+IA0KPiAJCS4uLi4uDQo+IA0KPiAJCWlmICghc3RyY21wKC4uLikp
IHsNCj4gCQkJc29mX2RhaV9saW5rID0gLi4uLg0KPiAJCQlyZXR1cm4gMDsNCj4gCQl9DQo+IAl9
DQo+IAlyZXR1cm4gLUVOT0VOVCAob3Igc29tZXRoaW5nIGVsc2UgZXJyb3IpOw0KPiB9DQo+IA0K
PiBQLlMuOiBvdGhlcndpc2UganVzdCBtYWtlIHRoaXMgZnVuY3Rpb24gcmV0dXJuIGEgc25kX3Nv
Y19kYWlfbGluaw0KPiBwb2ludGVyLi4uDQo+IA0KPiA+ICsvKiBmaXh1cCB0aGUgQkUgREFJIGxp
bmsgdG8gbWF0Y2ggYW55IHZhbHVlcyBmcm9tIHRvcG9sb2d5ICovDQo+ID4gK3N0YXRpYyBpbnQg
bXRrX3NvZl9jaGVja190cGxnX2JlX2RhaV9saW5rX2ZpeHVwKHN0cnVjdA0KPiA+IHNuZF9zb2Nf
cGNtX3J1bnRpbWUgKnJ0ZCwNCj4gPiArCQkJCQkJc3RydWN0DQo+ID4gc25kX3BjbV9od19wYXJh
bXMgKnBhcmFtcykNCj4gPiArew0KPiA+ICsJc3RydWN0IHNuZF9zb2NfY2FyZCAqY2FyZCA9IHJ0
ZC0+Y2FyZDsNCj4gPiArCXN0cnVjdCBtdGtfc29jX2NhcmRfZGF0YSAqc29jX2NhcmRfZGF0YSA9
DQo+ID4gc25kX3NvY19jYXJkX2dldF9kcnZkYXRhKGNhcmQpOw0KPiA+ICsJc3RydWN0IG10a19z
b2ZfcHJpdiAqc29mX3ByaXYgPSBzb2NfY2FyZF9kYXRhLT5zb2ZfcHJpdjsNCj4gPiArCXN0cnVj
dCBzbmRfc29jX3BjbV9ydW50aW1lICpmZTsNCj4gPiArCXN0cnVjdCBzbmRfc29jX3BjbV9ydW50
aW1lICpiZTsNCj4gPiArCXN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpzb2ZfZGFpX2xpbmsgPSBO
VUxMOw0KPiA+ICsJc3RydWN0IG10a19kYWlfbGluayAqZGFpX2xpbms7DQo+ID4gKwlzdHJ1Y3Qg
c25kX3NvY19kcGNtICpkcGNtOw0KPiA+ICsJaW50IGksIHN0cmVhbTsNCj4gPiArCWludCByZXQg
PSAwOw0KPiA+ICsNCj4gPiArCWZvcl9lYWNoX3BjbV9zdHJlYW1zKHN0cmVhbSkgew0KPiA+ICsJ
CWZlID0gTlVMTDsNCj4gPiArCQlmb3JfZWFjaF9kcGNtX2ZlKHJ0ZCwgc3RyZWFtLCBkcGNtKSB7
DQo+ID4gKwkJCWZlID0gZHBjbS0+ZmU7DQo+ID4gKwkJCWlmIChmZSkNCj4gPiArCQkJCWJyZWFr
Ow0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJaWYgKCFmZSkNCj4gPiArCQkJY29udGludWU7DQo+
ID4gKw0KPiA+ICsJCWZvcl9lYWNoX2RwY21fYmUoZmUsIHN0cmVhbSwgZHBjbSkgew0KPiA+ICsJ
CQliZSA9IGRwY20tPmJlOw0KPiA+ICsJCQlpZiAoYmUgPT0gcnRkKQ0KPiA+ICsJCQkJY29udGlu
dWU7DQo+ID4gKw0KPiA+ICsJCQlmb3IgKGkgPSAwOyBpIDwgc29mX3ByaXYtPm51bV9zdHJlYW1z
OyBpKyspIHsNCj4gPiArCQkJCWNvbnN0IHN0cnVjdCBzb2ZfY29ubl9zdHJlYW0gKmNvbm4gPQ0K
PiA+ICZzb2ZfcHJpdi0+Y29ubl9zdHJlYW1zW2ldOw0KPiA+ICsNCj4gPiArCQkJCWlmICghc3Ry
Y21wKGJlLT5kYWlfbGluay0+bmFtZSwgY29ubi0NCj4gPiA+c29mX2xpbmspKSB7DQo+ID4gKwkJ
CQkJc29mX2RhaV9saW5rID0gYmUtPmRhaV9saW5rOw0KPiA+ICsJCQkJCWdvdG8gRklYVVA7DQo+
ID4gKwkJCQl9DQo+ID4gKwkJCX0NCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICtGSVhV
UDoNCj4gDQo+IFBsZWFzZSwgbG93ZXJjYXNlIGxhYmVscy4uLiBvciB5b3UgY2FuIGF2b2lkIGdv
dG9zIGVudGlyZWx5Og0KPiAJcmV0ID0gbXRrX3NvZl9maW5kX3RwbGdfYmVfZGFpX2xpbmsoLi4u
KQ0KPiAJaWYgKHJldCA9PSAwICYmIHNvZl9kYWlfbGluaykgew0KPiAJCWlmIChzb2ZfcHJpdi0+
c29mX2RhaV9saW5rX2ZpeHVwKQ0KPiAJCQlyZXR1cm4gc29mX3ByaXYtPnNvZl9kYWlfbGlua19m
aXh1cChydGQsDQo+IHBhcmFtcyk7DQo+IAkJZWxzZSBpZiAoc29mX2RhaV9saW5rLT5iZV9od19w
YXJhbXNfZml4dXApDQo+IAkJCXJldHVybiBzb2ZfZGFpX2xpbmstPmJlX2h3X3BhcmFtc19maXh1
cChiZSwNCj4gcGFyYW1zKTsJDQo+IAl9IGVsc2Ugew0KPiAJCWxpc3RfZm9yX2VhY2hfZW50cnko
ZGFpX2xpbmssICZzb2ZfcHJpdi0+ZGFpX2xpbmtfbGlzdCwgDQo+IGxpc3QpIHsNCj4gCQkJaWYg
KHN0cmNtcChkYWlfbGluay0+bmFtZSwgcnRkLT5kYWlfbGluay0+bmFtZSkgDQo+ID09IDApIHsN
Cj4gCQkJCWlmIChkYWlfbGluay0+YmVfaHdfcGFyYW1zX2ZpeHVwKQ0KPiAJCQkJCXJldHVybiBk
YWlfbGluay0NCj4gPmJlX2h3X3BhcmFtc19maXh1cChydGQsIHBhcmFtcyk7DQo+IAkJCQllbHNl
DQo+IAkJCQkJYnJlYWs7DQo+IAkJCX0NCj4gCQl9DQo+IAl9DQo+IA0KPiAJcmV0dXJuIDA7DQo+
IH0NCj4gDQo+IFAuUy46IEknbSB0cnVseSBzb3JyeSBmb3Igbm90IG5vdGljaW5nIHRoYXQgYmVm
b3JlIQ0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQoNCkhpIEFuZ2VsbywNCg0KVGhhbmtzIGZv
ciB5b3VyIHN1Z2dlc3Rpb24uDQpJIHdpbGwgYWRkIG10a19zb2ZfZmluZF90cGxnX2JlX2RhaV9s
aW5rKCkgdG8gaW1wcm92ZSB0aGUgcmVhZGFiaWxpdHkNCmFuZCByZW1vdmUgdGhlIHVzZSBvZiBn
b3RvIGluIHRoZSBuZXh0IHBhdGNoLg0KDQpUaGFua3MsDQpUcmV2b3INCg==
