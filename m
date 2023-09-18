Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E437A41D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjIRHKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbjIRHKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:10:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C55120
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:10:11 -0700 (PDT)
X-UUID: 660292d655f211eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Z9GKyutHwnnk2dAronUIquVAcLgI5mIwwaLLSIeCf/k=;
        b=WZPrItKU88tVoc8ixlIcVW1DJScLRglBqJO24lBOkkMHXtkT0ui4MaYesxV0xjpZrzIerOwv13mkcu0BtSwiOuIRf9yc/L2xA/+bllrdslkmtCv2WzpBsMtOZadgVISLKRb9kAO3Q0+ehBG+g4Fbx16nvfXATHopx53THw++RkQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:93fb07fd-de11-4b39-acbb-697f30128b09,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:93cfd1ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 660292d655f211eea33bb35ae8d461a2-20230918
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 619868087; Mon, 18 Sep 2023 15:10:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 15:10:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 15:10:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IedQt5+2JdHr6pvWqOxyBGRYeX34W+XQZJBRrP1+CHrKK2c3N4X2iJh/wlwT7kXBIX/1XGK3qDuJDZEsb337K/ygOJ8pS1sLpNj3sGIWEKxR0YDZpQxlkDhOkZgKPLBTA3RMnQHjyYzBWWVxvZgHn346gpnUVSqSPCgEKGs0TwZeBjiktt6r0bpTE28wBrxttCdT9jx4XwFFiBu9pMprkefLGlQQ/Eo8yiM8BogYRSwDwjcRB/KaaCI3/8I0l9SiiI99O3ugy2UYApDF3bZGGFoKtj9CzHBYa59hFfZ355Gz68xPlikUoaK7exn3hMS0jsYt24CMV8gn7Zn8DRwCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9GKyutHwnnk2dAronUIquVAcLgI5mIwwaLLSIeCf/k=;
 b=GX0vVvlFwlUcc4PEaNHyPeKx3FJnjVI0CDVRLV2fNMlvcpTBO7fnUreomNHhJxGzLKXXRDYA2Ol4DWSTZKFZ/6O6Xp0YZtByguUWgzbylGhyw+XECirOTACzX5hs8BAYX6vyiRgRbm8+XYEcb38YdeWe+Q5s+FLSpfu1ZaqYA1g3tK5i1WtClmj0RnqWf6no0u5yv+hSkrMYULjPG2gXvOGYYgS+aRTVqw4UX5BREikfAg7xGkLqqCJujIG2o/hmbO4ER8A16EYm8AynibA0vyhrc5JcIuj7Ftgm5WvkUiIvbsfXxse8SE0q+FK2zcyAadZclWpET64d5v0bJJqcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9GKyutHwnnk2dAronUIquVAcLgI5mIwwaLLSIeCf/k=;
 b=OJQutVIB2baEmZ7eQ6fHQyOhSWZtubXbl0pcwUszBvILS8FaL2XzEtzZzCuZhp+lIrzA/F9zEIgOT92ZKn6G4khlAvMVd+EgImmYen6hYYhV3sCTPpu54KsJipXeM/4nhOUcvdRHtAmaAJkgg9X68qQpgibucS4Pys8VXxXYFSE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7581.apcprd03.prod.outlook.com (2603:1096:400:40e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 07:10:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 07:10:03 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v9 6/7] drm/mediatek: dsi: Support dynamic connector
 selection
Thread-Topic: [PATCH v9 6/7] drm/mediatek: dsi: Support dynamic connector
 selection
Thread-Index: AQHZyu2PCfr/LUydHUCbIUSxcLEeD7AgaG6A
Date:   Mon, 18 Sep 2023 07:10:03 +0000
Message-ID: <19a32b7eba540c4ef7dda990bac95f88335f5fe5.camel@mediatek.com>
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com>
         <20230809181525.7561-7-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-7-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7581:EE_
x-ms-office365-filtering-correlation-id: 63c34d74-872c-46ca-c68d-08dbb81647e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nbB/DVMP5pFmTvkj0a48dXESynhWVdgvUaSzevtH5SwEAN98UKpA8jdmXeZ2PQqKoMSVwZqwIfueIdmfrqdPm8OSrfEY8Kp8U45nUjwijvPKccngrryYb2uA7axBUFtUexafyRqMTQjgg2/LREIj8lOkw4XSdMdM6kCY61BksW9vJNxOo4Id9BAqfDU5mTrAdTzGkDzbtfAbjmnHsVzoA3SIctbdfx5w0b+2CDnEL6RaWBZcGbzmH17EGKewyUFB/rbKlOajLY+VF2d5VxQoC8lQDiBsXTUzZVw0pOG5DQYFcP1SKrgaBxOeeHdtStlo5Dm7jX78raTVqrbUUWMzpEcHpOpI5bCmont5FL7azXYucwiFNOla0KTno13G7FtSyBzXAqMfik+WKUhP+p/nXGEGWpDp86PzATs6ETpDXqp3EXPx90PViGWMpwAy1FVhFiJJVKOGkcQaE8WfZ6WXazPW/sgdVHgKwgoQzABh8i1NKKgeyDSvSKNt9tl4z88Mn54gNx0wpIHCxGQbr5uBEOXr6Rrob7x3m7C5gWfldY2X4is9KlrmHImWzejfpEwtWXE3rMmPBiK2OKvDBHbE1SSiYL3uUXk1Lgi4LkCU6bh3zVfUfeqIoc2dI0U2HgUYM8N0dmxqVBHop0skuY3mJZoro+m2xOqrPAkWx7rOXKQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(186009)(451199024)(1800799009)(2906002)(5660300002)(26005)(41300700001)(76116006)(316002)(66476007)(54906003)(64756008)(66556008)(66446008)(66946007)(110136005)(478600001)(8936002)(8676002)(4326008)(6506007)(6486002)(71200400001)(6512007)(2616005)(36756003)(38100700002)(85182001)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVhVa3VGdnc3RzZNMUVoTlpiN1ZRNUJlOUdmNzFYcS90ck9RSWpyeXdTYVJP?=
 =?utf-8?B?eE85T1EzWkhpdUs1Yzc2a1hDS2tLWWo2bUU1VHBSNnM4Y29BeC9tSm9US2tO?=
 =?utf-8?B?UTh6NzlsdTFaT0oxUkJ5anVwZHRqK2V4Q2tBM3RrSDZsUUFQRzBsOWk3ZkJV?=
 =?utf-8?B?Q2d2dEcwOU5VVy9RUEtFN2NrdndZNk0zeFNnN1pCYTlidTAxalhwb3NhTjF0?=
 =?utf-8?B?UGM3ckxIMUxTOC9lbDhJNVV6d1NZY0VrSjdySXFZVE1TY0xnd1ZBdG9rNEJG?=
 =?utf-8?B?NnZPaVVHQW1WaXN3dGRra0U0cW9udmVoSnpoN01LaFdnYzZlOEhDejJmNVhk?=
 =?utf-8?B?NVFaS2FycllJVDJxVnlKcVg1OHZVdm5IZmVFOERFeno4S2NDUVhnNXVaZGhp?=
 =?utf-8?B?TlhRL3NmT0NKMjhwWGR2YjVDaDlvdkRaOUZzV1VSS1JHVXdWQmRseEk1QmZJ?=
 =?utf-8?B?S09PR1NoT2p3ZVcvSnY0TGxZMjg5TVEvelFKY1d1Q0FmQStCTEVPNWhvZWtP?=
 =?utf-8?B?Qk5lUGJjbXhFbWNDR3FsTzNmdVFOMksxcEs4STBpZ2pnM3hSRTBuYUs4ZWQ5?=
 =?utf-8?B?ZkxiZWJOUFU5ZTFmVTBwTXNXQU5HbFgrWGY0cExybnRtcFllajZsdzNVMHR0?=
 =?utf-8?B?QVhBSGZTcXZTcHZGT1IrcWVHYlMwL2Y5L2JncklLSWx3QmJqeEZqV3NlQ0pJ?=
 =?utf-8?B?TUhxbEdEZS9leG5tSGVxV0Z2Q3J1bS90M3R6b1VLSnM2UGUrYXZnN3RQd2xz?=
 =?utf-8?B?cldRN0QybEZQNFYxSmxEZTBjQUdYZ2JHYzdJUzAxbmxyTzBJOTNDL2crQnFV?=
 =?utf-8?B?ZmJXOFh1RDhUeWNjVGd1OHNGMmhmKzU1VURLUmFZQkh4enB3clZPR08zOTUx?=
 =?utf-8?B?a2pKRnFIY0k3Tlgrc3VZUE01Tlh2NXZ0dG0yeWk1RVhUbVk2NWpNNHplOWpG?=
 =?utf-8?B?WTRNeW1JVUNDN1RFN1R0eFdxK0hTKzV5ZFh5eWJQdFNlQ3g5YlNwaGlyekJ0?=
 =?utf-8?B?V081eG5sVXlqTnRlaDJzdlUvWHZZdENpNXJiR2U0K0EyZlRKbHpMU0s0OE42?=
 =?utf-8?B?SDE1cXYxR0YxK0VxWVlvaUNIVEVoVEhIUjlnKzFmWm10dGp3dFdCY2QzUEdn?=
 =?utf-8?B?NFJxSUFTSzdhNk9mSVA0alFxa2RxMTB2Rlg5V1JSRzd4QkMxQXhIMng1UVA5?=
 =?utf-8?B?Ukh5NzZWVlNhLzhTb0MvUm1Zc0pNbWpYYzZNK0xaZExvNVFkNTIrbTJMem5I?=
 =?utf-8?B?VGFCR1V3S3ErNEY5K2FlbzMvcVp1eC9BeFZEQlFlZVZhVjVleUdyVXFmdHV0?=
 =?utf-8?B?L2cxTHV0Y1p6Tk4xOTBMU2M5ZG4zVzNWcml5Qmp5WDdueE5tekM5VkIreURS?=
 =?utf-8?B?Y01RdWlOVGtFMW9ZMmJXaktYMUs5QzBkMmJ5ZEQ5V3ZyMlg2RStYN1JoMEdI?=
 =?utf-8?B?R1pqNEcwSDgvMFpnV1dJUU9NbThiSGZQY2EzTjlWamluNHE0OTJ5YW9TMEJp?=
 =?utf-8?B?MVJ5cUVYTGFCVUZqZ2RKY0JMWTNncU9aUG1VcW4rY1B3cXFvaXlZVllsaDJk?=
 =?utf-8?B?Q3QyQWR4YnYyTHhZbXFLRmlZbGpzMzBmNGMxdlJqTU1TV3JUUm5uNnQ1OGQ2?=
 =?utf-8?B?Z1dhRzN5dHlCTFh2ZkM0akRsaG52VE5QSlYxRVhkaEtJU1pJOU12ZGpTcWdR?=
 =?utf-8?B?dVVlWW1XUHRWVU1pL2xCejZiVCtvalRMZ2VNYThTblp1dFU4VVJwaGxiYkZ5?=
 =?utf-8?B?UGkvWVJXYndTSy9MNXpTY3JLRlZ5VlBrNFIzb1NXUXhWektZTk91R1RlTW01?=
 =?utf-8?B?Mis1VjZON0RZbkR3azBaWVcwMUhaL2RIeFllRFA0MnF5MUxrUExDNVZTd2Mw?=
 =?utf-8?B?NmgwYlQ5d3NVMlNoa1BMTWpsTFlPMHl1L0h6aFJwZ0QremhqWXUwaW52Tkxm?=
 =?utf-8?B?eC9WUDYyK1gxN0lvZTF3QUs4UTNabVVPTWowVFlmTllTZE9rYmIwcVlRNlkw?=
 =?utf-8?B?WThPWmRZYUJobzZBdFZMZG4yQnB0M0FEbjA4TUlIMTRqMXBEempLdlNFMitJ?=
 =?utf-8?B?aHlWUWFwL3BNQUg5L00wME14L2VvUzBLSkcra3JmMlZLWlByTFFOUllJajNH?=
 =?utf-8?Q?zOIcVayodGx/wqsraDm9soxWi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A572D7B10A732345A86A03FCF02A3B8B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c34d74-872c-46ca-c68d-08dbb81647e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 07:10:03.7993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgzqOZmyzMKy1CABDulK9vBcDMfBIlDnVSn6j4JgUqKkcGdtr9JnBNJv1a8kxh5vz2OO834D1OXBXs4BKcjkNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjMtMDgtMTAgYXQgMDI6MTUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIGltcGxlbWVudGF0aW9uIG9mIG10a19kc2lfZW5jb2Rlcl9pbmRl
eCB0byBtdGtfZGRwX2NvbXBfZnVuYw0KPiB0byBtYWtlIG10a19kc2kgc3VwcG9ydCBkeW5hbWlj
IGNvbm5lY3RvciBzZWxlY3Rpb24uDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2Rydi5oICAgICB8IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYyB8IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyAg
ICAgICAgICB8IDkgKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
ZHJ2LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gaW5k
ZXggNWYwNzAzNzY3MGU5Li5mZGFhMjFiNmE5ZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTQ4LDYgKzQ4LDcgQEAgdW5zaWduZWQgaW50IG10
a19kcGlfZW5jb2Rlcl9pbmRleChzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpOw0KPiAgDQo+ICB2b2lk
IG10a19kc2lfZGRwX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19kc2lf
ZGRwX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gK3Vuc2lnbmVkIGludCBtdGtfZHNpX2Vu
Y29kZXJfaW5kZXgoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIA0KPiAgaW50IG10a19nYW1tYV9j
bGtfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19nYW1tYV9jbGtfZGlz
YWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gaW5kZXggYzFlYTExMmU2YmU4Li5jOTNiMWJhZTAwZGMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0K
PiBAQCAtMzE4LDYgKzMxOCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1
bmNzIGRkcF9kc2MgPQ0KPiB7DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9m
dW5jcyBkZHBfZHNpID0gew0KPiAgCS5zdGFydCA9IG10a19kc2lfZGRwX3N0YXJ0LA0KPiAgCS5z
dG9wID0gbXRrX2RzaV9kZHBfc3RvcCwNCj4gKwkuZW5jb2Rlcl9pbmRleCA9IG10a19kc2lfZW5j
b2Rlcl9pbmRleCwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9j
b21wX2Z1bmNzIGRkcF9nYW1tYSA9IHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5j
DQo+IGluZGV4IDdkNTI1MDM1MTE5My4uOGM0NWRjMTlkMzlmIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMNCj4gQEAgLTg2NSw2ICs4NjUsMTUgQEAgc3RhdGljIGludCBtdGtf
ZHNpX2VuY29kZXJfaW5pdChzdHJ1Y3QNCj4gZHJtX2RldmljZSAqZHJtLCBzdHJ1Y3QgbXRrX2Rz
aSAqZHNpKQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gK3Vuc2lnbmVkIGludCBtdGtf
ZHNpX2VuY29kZXJfaW5kZXgoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBt
dGtfZHNpICpkc2kgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwl1bnNpZ25lZCBpbnQgZW5j
b2Rlcl9pbmRleCA9IGRybV9lbmNvZGVyX2luZGV4KCZkc2ktPmVuY29kZXIpOw0KPiArDQo+ICsJ
ZGV2X2RiZyhkZXYsICJlbmNvZGVyIGluZGV4OiVkXG4iLCBlbmNvZGVyX2luZGV4KTsNCj4gKwly
ZXR1cm4gZW5jb2Rlcl9pbmRleDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBtdGtfZHNpX2Jp
bmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsDQo+IHZvaWQgKmRh
dGEpDQo+ICB7DQo+ICAJaW50IHJldDsNCg==
