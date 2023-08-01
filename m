Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BA476AD70
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjHAJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjHAJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:29:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD373AB3;
        Tue,  1 Aug 2023 02:27:44 -0700 (PDT)
X-UUID: 89c69d56304b11ee9cb5633481061a41-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sU6u0nBaiiyNKxtNM18jUob7UBaVh6PLd5oLzE7xPcg=;
        b=Gd4DjMVnXO4ehgUwzUt4pQL5DZALgRf9dOakUmSv+GleO2X4rBK8dEjHbHVMSyC8o2ZBjgLFqQiPn38qQqxffiVmzfLpuz6bMc1j5zNOfOX2GwYGm7aoB3zCoqDyVUiB/gT7/RP2oBfDCk8ubevNw7gx22lXSIlYH5d3TqWZmHw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:b5537da5-5394-40b4-9351-9c8f654158af,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:a18cc3a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 89c69d56304b11ee9cb5633481061a41-20230801
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 841480304; Tue, 01 Aug 2023 17:12:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 17:12:28 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 17:12:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXUhWRsnT5LUMSeH3LwxcHjgex95ZkyK5Vs/YM9CjKmfxygF16QMGNuaNYG1hJ0nkWyRb592IlZ9fJwCFLwVeXV+rnKm9XdVZO7ArJUVsmd0WBdmav1rXjF18276OwPmMMfAqjcvZ5pXJpIuoWvGZd5KwQIbwvGwtG2Q82yaFoRqf4GttxhHbMCspEfRP698AOh8fSJEV+shF9LBJCi0LicbjtvrWgBdIocGKmGsxXsksO2K+J5c9CwXEkVMhp2eWOHMTEe906GNMaBvclw2k0ltZ/FEtKlCM4EsMvbhbEmJzbRkggQ2Uk6HsnyhnhLn7lF12eUPMSVJnbMDOvYPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU6u0nBaiiyNKxtNM18jUob7UBaVh6PLd5oLzE7xPcg=;
 b=eDKPtPj3WbXzCrS8+WGBlU9REtLzldD7YMo+T1RPQ0iZSsOMQx3RjxqECOiku6Xqa+jz0TyvZpgGZHXOi7dcvMMK01mZkT6IIjt37kXQBMASziU2h1Mo0mMxDwhlsFus1u4PS5yLvUA1PMyKcvJgCwN044lqqfCryTzKlWpbGQ8nNJn2DHTdJKOgU5TVijNk9SkF/UX4EHN6nFSJ3cWHKYa/nMKM/BeS+r2pEo7Ho+IM/4d9cEu35QWPYgbJCXaK8VxpKqWJJkCuYq0w0qTzgZqOu0JrjF46fElerXQH68755UQJQ5JCyVJRr6gz8+C6Hzl9gRWfde8X34ZKPbK7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU6u0nBaiiyNKxtNM18jUob7UBaVh6PLd5oLzE7xPcg=;
 b=c+x9WskvL1FY9D4jR6Mc+uuGJYNtF2LjTY8gADO2VE3usZ+/d3/hwnzeEl0FhpxGNzEvylVV6P7JKFSpSdHf7tkz3Kdsa8tgsJ+voajqAGqAtpiPXXttaWMoIvU/a4RcYzaL2j53Mo1Q47YLXcCTYiy58fgsQyGcU3GXEFL4Y9w=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7225.apcprd03.prod.outlook.com (2603:1096:400:33c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 09:12:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 09:12:26 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "maxime@cerno.tech" <maxime@cerno.tech>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>
CC:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [v5, PATCH] drm/mediatek: add dma buffer control for drm plane
 disable
Thread-Topic: [v5, PATCH] drm/mediatek: add dma buffer control for drm plane
 disable
Thread-Index: AQHZrwcT38y2+2g6EUytkMVWz8m92a+qzASAgCpzDwCAABNxgA==
Date:   Tue, 1 Aug 2023 09:12:26 +0000
Message-ID: <784b6e5fcd580384dba95316635412477d00e513.camel@mediatek.com>
References: <20230705060719.14700-1-yongqiang.niu@mediatek.com>
         <gmzb7lja2lfciu5m7ggxkftacaa6fbui45icwerabqad3lwrcn@nhdxug7fvh6u>
         <0fe99eef64fada0cc8b58d7cbfc5a174b3e8ebbc.camel@mediatek.com>
In-Reply-To: <0fe99eef64fada0cc8b58d7cbfc5a174b3e8ebbc.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7225:EE_
x-ms-office365-filtering-correlation-id: 87de95a5-0c51-49d4-0371-08db926f6c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TezD2vzOxWtLYjJt/L75Ht5TY86eigThL7vXolrndbTFRRZ++e++rSkiH3xhCqjKQffHgyFz28tza22abAssPiKQ4VCCbfQ+Otkr1PH3spvi5sqswqtJijXS6E4WeVzMTHBTRN/rZXjaZjfRs9jT0VCoQQC/S/zjMtybd10AYBQuhJxUglMvwmjV1JcvtARaRDphCtAMzcBhUjyXpQIZ92wUgyTBFGKkgSFB4HbkUOsaPXowI1SkGlXqW8jKv4b7zmr4WacAm2Zb/3G+yijGzsmHajSbyovALdBB5X97oN5HtnOpQauwfVfGOYcLi19NYJnTw9/kdAwb4hZinXVH1wgnTO/Nbl66jEh3drBA2JziSrOt8cE+pA9MUttKruTrFd6SwZp3Rm3EwC3L3crSQprvulLe6o64vflkr/b5rnEZfENYs1MnJqTgSaP/qYROZ1p+x9N6ZgU5qrxBf63INQ01hIZUOgR0SzaQi4vM9DlNabvQrszhDZlAkcp9tFitCttFga0HxhmAdJlWHMYFWjj1znwmoXDwHuWb5kBERlyHlp8snJGesdX2vtgTbjY/68tR6O0zrqYsTM5iykWf7XKSGFFqM7UvwJ+51ui+aR/aPiJ7BGiDA0xh5KxBjERNV7Ee6H3vR0NiBH2zoiRTxpn9zCpEI6kcr+fBnXn00FQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(71200400001)(6486002)(83380400001)(2616005)(85182001)(36756003)(186003)(26005)(6506007)(6512007)(316002)(41300700001)(64756008)(66446008)(4326008)(66476007)(38100700002)(122000001)(6636002)(66556008)(2906002)(66946007)(76116006)(5660300002)(7416002)(86362001)(8676002)(38070700005)(8936002)(110136005)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUwzWFFuM3lucXJMbkJWWWlSQkhZVEVpVC9Ec0JZalRSV0ZnWldrYmo2MHNh?=
 =?utf-8?B?Zm9LTmFLNFo2R1RoSXVkTVMvS21iQWtKeE5pVnQzQ2hZTDNkN3VsTXkyOUVa?=
 =?utf-8?B?TEYwRTdMUUtMcVdpUzdTYXk0OWV1UkpVZ0lrUkxxeTA4djNJVzNaWkVTRHA1?=
 =?utf-8?B?dmtLWWZXUVlhdjJoSTBSOUFOQkRkZU1NdWIyYURSenNjdWpmWHdQWWVMcHhl?=
 =?utf-8?B?WWdLWWhSN1ppdVo2NlpUWXlsck5ONU9ZOTlQcTRZTGM3d1dFYmxzdjNVcUFJ?=
 =?utf-8?B?Tmh2a0EwaTlFU29UUzZFSzVhS3Y0Z3hyZURtcEVnc3h1VHlMdXFIdkNQQVhL?=
 =?utf-8?B?V285Zk5lcHhxTGZWQ2ZNWVpuOUdmOHNPUkhpSS80czNwVnpXNWRwa1pJbmNW?=
 =?utf-8?B?UG55NldVb2puY2JDRnZKQzRRd2tqY3B0Z1IwQThvRzBIM2RnTmZ2VXRJd25t?=
 =?utf-8?B?K2xHdG5DdTJhVFp1OWFBdjBFN2xkUDhlRUtFZ2tKS3dkUXpNd1hGRmwxN2g5?=
 =?utf-8?B?UE1QbmpNWGN2RWdWT05YZVBicUREQ1pCU2dsUVVUeWx2aW5BNXRjVjBoNHk0?=
 =?utf-8?B?YWlzMmk0TzE5NFkwbGpJNHJFSjg0c3RUNWJNMjc2NGx6czk5SEpydFlHYm9s?=
 =?utf-8?B?Y0xHaEhxNnlwejIwVzhuc29SQ3VFdkp4VmRYWWR3dElHaTBrMExtcHhYc1E1?=
 =?utf-8?B?bWJWTFFNSEZNOFFlb2w0RlFxdGFHVmdSTTZkZTR4RmNjK1MvaTdwaTdoZnhR?=
 =?utf-8?B?cUZSUXlVdkIvU2pBZ1M1aExDTlhWZXZRcXZCREgxM3pVdUk2QTIzNytBYi9k?=
 =?utf-8?B?Q2RRNDh6SllPSkk4Q3ByUXlUMmE5ZjFxOU9DQWNjbHFPaENySGd1bnVJc3ZC?=
 =?utf-8?B?RmdaeFFJZHB2WXhGbTlNQ1NiQlo5cXpVbHhPdzVVU3BPZU1ZUG9oYzRDb3Rn?=
 =?utf-8?B?UGN3R2MrcnlDS0dCYWpZN01oMjVTWXQ2bWQxUnJFMUpOZC81Ynh0Q3RBSGgr?=
 =?utf-8?B?ekFOR2pDRG9JY251Wm5iRjdraS9QZTRPeVFqemFUQnN5NkRhRUlrQmNMaVo4?=
 =?utf-8?B?WUM1TVVXejNjbjlCMjBMNFEzREQyNGtDeW5uSFFodllEbnpiL0RLdVlVMUxU?=
 =?utf-8?B?UEVJM0tRUEZOcGw2MWhoVUprWEVycmp0cURpNE5UbkQ2S3RxVThjdlNYOURz?=
 =?utf-8?B?MWtsT1YwZWlmWHN1WGd4bW1zL29HS1lSd2M5S0hvZWJneEtuZHZFMEt3MURq?=
 =?utf-8?B?YklsamR3ZjhjditqQ3lTbnZESUgvSEMwMS8rMDVYamZid2VSbDFxZEovT2lx?=
 =?utf-8?B?MFowZFlwV3lpemZLMGNJZU5Wc09CQlFIM0paRWUwUlBPWFNSeDlPZkJSRS9Q?=
 =?utf-8?B?dkhld3EzcVhMZFM0RCtJNTY4ZGxRa29rRWJoRi95OFlqSHRQS0JFaUExdHJ0?=
 =?utf-8?B?amc4QllBVE84L0FuL3pFTXFKZXBENXZKSG1FTDYyb1FTMm1EVFNndmRYdVBl?=
 =?utf-8?B?YTUxcDI1S09UeGZnYUlibmxDTVdlUk5YR0NYbWpSSkFnT1lSdDNCb0wwWWVD?=
 =?utf-8?B?WTFVNXdSR1pjOVoreXZwYlV6K210SmFuWjcwYVZKS3VTd2JaR3NQZzBwMDBQ?=
 =?utf-8?B?U2NpWU5NYTFpZWMrTGRsYk5pbWVCTlRsbWJobGxRL21KVGJZa043OTdqcDdN?=
 =?utf-8?B?ZGNZaEdtUlRuazBGeTJMTmxXRU1oUFZweTlvbUxydUVKVlhuSUVKSkl4ck0w?=
 =?utf-8?B?Z1RIcytWMDk2elprZ0ZNVUhpOU9tMGpJSTI0ekUvbXNtV21KRVNQT3BkZjFQ?=
 =?utf-8?B?aHkwL0VpU3h6eEcxSitRdTJtMWwwUkJJT3N4RHdoYU5JMUpuM0tXVlVLclZu?=
 =?utf-8?B?N0Z2UEgvREg2bE1LdTZtUUxzNWRzWW5BaWZscmIvVW10U3ZyZ0c0ZU52WGZK?=
 =?utf-8?B?NzFiUUp3M29tMWIvNjNucTM5eTZEL2lIYStLeGQ2azczcks2WG9EemliVnl3?=
 =?utf-8?B?NHRRZWtzNUNsa0UxVlk1dWMxd21DME94dTVqU0hDSmZ1OVRGcHoyN2dEUU5w?=
 =?utf-8?B?WkRISnJCSFVTZE5MSG96eDZQUUI2YkRWMW8yMno2a1BLY3ZjaFVKcjdsSzd3?=
 =?utf-8?Q?oubEFNWKeWSL8eqHFUi833mO5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75B7D57892AB8D409584D565FE4329CF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87de95a5-0c51-49d4-0371-08db926f6c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 09:12:26.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqS1juOB//Vz5zWbFJ4XYkojpLk+QPea4NqT3onhUtwu9xWf1OYK2RNEYZLtenMg2yELwAcpk8EZh/jbUI37EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7225
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1heGltZToNCg0KT24gVHVlLCAyMDIzLTA4LTAxIGF0IDE2OjAyICswODAwLCBDSyBIdSB3
cm90ZToNCj4gSGksIE1heGltZToNCj4gDQo+IE9uIFdlZCwgMjAyMy0wNy0wNSBhdCAwOTo0OCAr
MDIwMCwgTWF4aW1lIFJpcGFyZCB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBPbiBXZWQsIEp1
bCAwNSwgMjAyMyBhdCAwMjowNzoxOFBNICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+
ID4gZG1hIGJ1ZmZlciByZWxlYXNlIGJlZm9yZSBvdmVybGF5IGRpc2FibGUsIHRoYXQgd2lsbCBj
YXVzZQ0KPiA+ID4gbTR1IHRyYW5zbGF0aW9uIGZhdWx0IHdhcm5pbmcuDQo+ID4gPiANCj4gPiA+
IGFkZCBkbWEgYnVmZmVyIGNvbnRyb2wgZmxvdyBpbiBtZWRpYXRlayBkcml2ZXI6DQo+ID4gPiBn
ZXQgZG1hIGJ1ZmZlciB3aGVuIGRybSBwbGFuZSBkaXNhYmxlDQo+ID4gPiBwdXQgZG1hIGJ1ZmZl
ciB3aGVuIG92ZXJsYXkgcmVhbGx5IGRpc2FibGUNCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDQxMDE2
ZmUxMDI4ZSAoImRybTogUmVuYW1lIHBsYW5lLT5zdGF0ZSB2YXJpYWJsZXMgaW4NCj4gPiA+IGF0
b21pYw0KPiA+ID4gdXBkYXRlIGFuZCBkaXNhYmxlIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlv
bmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEkgdGhp
bmsgd2UgbmVlZCBtb3JlIGRldGFpbHMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGFib3V0IHdoYXQg
dGhlDQo+ID4gaXNzdWUNCj4gPiBpcyBleGFjdGx5IGFuZCBob3cgaXQncyBmaXhlZC4NCj4gPiAN
Cj4gPiBUaGlzIGRlZmluaXRlbHkgZmVlbHMgbGlrZSBpdCdzIG5vdCBzb21ldGhpbmcgZHJpdmVy
cyBzaG91bGQgaGF2ZQ0KPiA+IHRvDQo+ID4gZG8uDQo+IA0KPiBCZWNhdXNlIE1lZGlhVGVrIGRp
c3BsYXkgaGFyZHdhcmUgaGFzIG5vIGludGVybmFsIFNSQU0gd2hpY2ggY291bGQNCj4gc3RvcmUg
dGhlIG9uIHNjcmVlbiBidWZmZXIsIHBsYW5lIHNob3VsZCBiZSB1cGRhdGVkIGluIHZibGFuayBw
ZXJpb2QNCj4gdG8NCj4gcHJldmVudCB0ZWFyaW5nIGVmZmVjdC4gSW4gTWVkaWFUZWsgcGxhbmUg
ZGlzYWJsZSBjYWxsYmFjayBmdW5jdGlvbiwNCj4gaWYNCj4gd2Ugd2FpdCB2YmxhbmsgcGVyaW9k
IHRvIGRpc2FibGUgcGxhbmUsIHRoZSBzb2Z0d2FyZSB3b3VsZCBiZSBibG9ja2VkDQo+IGZvciBh
IGxvbmcgdGltZS4gSWYgdGhlcmUgYXJlIGZvdXIgcGxhbmVzIHRvIGJlIGRpc2FibGVkLCB0aGUg
dG90YWwNCj4gYmxvY2tpbmcgdGltZSB3b3VsZCBiZSBhbG1vc3QgNCB2c3luYyB0aW1lLiBTbyB0
aGlzIHBhdGNoIGlzIGp1c3QgYQ0KPiB3b3JrIGFyb3VuZCB0byB1c2UgZ2V0X2RtYV9idWYoKSB0
byBwcmV2ZW50IGJ1ZmZlciB0byBiZSBmcmVlZCBiZWZvcmUNCj4gdmJsYW5rIHBlcmlvZCBhbmQg
bm90IGJsb2NrIHRoZSBzb2Z0d2FyZS4gRm9yIHRoZSBiZWhhdmlvciBEUk0gY29yZQ0KPiBmcmVl
IHBsYW5lIGJ1ZmZlciBqdXN0IGFmdGVyIHBsYW5lIGRpc2FibGUgY2FsbGJhY2sgZnVuY3Rpb24g
cmV0dXJuLA0KPiBJJ20gbm90IHN1cmUgaXQncyBEUk0gY29yZSdzIGJ1ZyBvciBpdCdzIERSTSBj
b3JlJ3MgY29ycmVjdCBiZWhhdmlvci4NCj4gSWYgdGhpcyBpcyBjb3JyZWN0IGJlaGF2aW9yLCBp
dCBtZWFucyB0aGF0IERSTSBjb3JlIGFzc3VtZSB0aGF0DQo+IGhhcmR3YXJlIHNob3VsZCBoYXZl
IGludGVybmFsIFNSQU0gYnV0IE1lZGlhVGVrIGRpc3BsYXkgaGFyZHdhcmUNCj4gdmlvbGF0ZSB0
aGlzIGFzc3VtcHRpb24uIElmIHNvLCBJIHRoaW5rIEkgY291bGQganVzdCBhY2NlcHQgdGhpcyB3
b3JrDQo+IGFyb3VuZCBwYXRjaC4NCg0KU29ycnkuIEkndmUgZm91bmQgdGhhdCBkcm1fYXRvbWlj
X2hlbHBlcl9jb21taXRfdGFpbCgpIGhhcyB3YWl0IGZvcg0KdmJsYW5rIGFmdGVyIGNvbW1pdC4g
U28gSSB0aGluayB0aGF0J3MgTWVkaWFUZWsgZHJpdmVyJ3MgcHJvYmxlbS4NCk1lZGlhVGVrIGRy
aXZlciBzaG91bGQgcHJvbWlzZSB0aGF0IGNvbmZpZ3VyYXRpb24gc2hvdWxkIHRha2UgZWZmZWN0
DQpiZWZvcmUgc2VuZCB2YmxhbmsgZXZlbnQuDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBSZWdh
cmRzLA0KPiBDSw0KPiANCj4gDQo+ID4gDQo+ID4gTWF4aW1lDQo=
