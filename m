Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283BE7AD845
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjIYMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjIYMuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:50:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7119A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:50:29 -0700 (PDT)
X-UUID: 1981dc2c5ba211eea33bb35ae8d461a2-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8RkK7min34DC7hbhVw/80tYFuCT2+gqHZCZwDuCxmCo=;
        b=nMpN/OFfkPaw2jBX0Vqh6YzAynCP25vLkSwGRklEpEBY38iq/5N/DQyNZmKy+mGRYdlNrJTj8lmfrOBKou16ZoF6B/mWK22Z7E0afD8LNjaMxnIRqHCbZKAVoZo+UET+14rG+mazsarEgztIF1kZR5i6ohJ+ghEHV8C1vsRu530=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:fa2312e7-fe99-4339-afa2-c34319130e86,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:7b9670c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1981dc2c5ba211eea33bb35ae8d461a2-20230925
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 636163786; Mon, 25 Sep 2023 20:50:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 20:50:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 20:50:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJZUrG1BOX/v5fwEXZXo/sbxtgDvLHQ4f84lLv5Zvc/Akx8eR7aA51rqkkXGOBeogROz5NA8RMUVkR2Wf5DW4i8aKrJ1D0bsxVoB6ajWUffGs12nrzqhkDpCHnurAAxej/z6/lBDUUItQhkJXagSmnS24mgO9LbttqDzZ1mnhlO1g94vKwSkDI4r6C93RK3yGoE1872GBUX0FJJ9HbkF/4AM/qKjadFI8uL69qXyPZnyzUHTZfFIqJPLwqhCazvy3KXtfEdSjRz2i+leINX1msH26AxoIfrDGXUlj0HSkpWtax1Nd5YXxVBfwYVvEGYSKp8e0pJK/4/PlbMrblrGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RkK7min34DC7hbhVw/80tYFuCT2+gqHZCZwDuCxmCo=;
 b=e8ka28lZ5xr51YIDABBF99LtP6UAJi1bJOkX9cXuo3DWjwx296DtwpSoV+Qddlo+nMZMnsKIj/FHu3hKJ00EsEfa8sIUyBsY5RnOhhoeF1z1a8o1ETm1xnN+JI+K5AzOmR1BA1tMVfunnIAaOE8DQhwE9GI+HL7tW4geCJu/5Bido+IiL1ZlD17ZG2BkhzMTmAzU+zdK3J/6wntMwQQlTyCgMKPHT3RlOyA/ih/DVpTc0KQf54zUdO79KNNAcUDA4s7nR1RuwVNp+e3LG1QkntPxbKwgp6gwEo4R9d4LQF7Ld3grmzk86PDdjr9icf0sua2QLHMsCHEvC2tHzymfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RkK7min34DC7hbhVw/80tYFuCT2+gqHZCZwDuCxmCo=;
 b=vG064I2VvBrqOQsjO+GvSTuXZGfcgKMaP7Y+DQOFlZTPL8aOotfovw1FoNHzYC2BSdv10TCrVMS6of/StABCH7T1DGccHBLsyQs3EFpgIkbGpUj+gi8BbP+EAqH5bJN5juQu+MJRNkG6pMwuXXRGbfsr3Mf+A+bWMoJ9sRTo/wo=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB6820.apcprd03.prod.outlook.com (2603:1096:400:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 12:50:23 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::e148:3390:1eb2:28e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::e148:3390:1eb2:28e3%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 12:50:23 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "tjmercier@google.com" <tjmercier@google.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>
Subject: Re: [PATCH 1/4] iommu/mediatek: Initialise the secure bank
Thread-Topic: [PATCH 1/4] iommu/mediatek: Initialise the secure bank
Thread-Index: AQHZ5E3qysHKk79NkEWZcXv/xfoJu7AVWnwAgBY6mQA=
Date:   Mon, 25 Sep 2023 12:50:23 +0000
Message-ID: <409168b540948d312a91022f375fa71a470e9d60.camel@mediatek.com>
References: <20230911011751.29906-1-yong.wu@mediatek.com>
         <20230911011751.29906-2-yong.wu@mediatek.com>
         <28b81a20-5cfa-b474-41c3-c01b7b846e21@collabora.com>
In-Reply-To: <28b81a20-5cfa-b474-41c3-c01b7b846e21@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB6820:EE_
x-ms-office365-filtering-correlation-id: f120cdf4-8d2c-46b9-2d4a-08dbbdc5fbc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kh34C3tFwiopBdl7f2gRoxoa2cXAK+aeWIXXVv1Z/iQ4di7ljk2hPlZXgD0rVt9r57XDi+C+iDCU5NUISAeU5XHzFfkVjNyr9TxOIRvFV+Dvq1GAtoGsNcjOA9+Q9g6T65R+SxzJscr0pkBqYHiWewclQnrAZeHe+sJHYdRJrB64AmHKpc81BQrU3JKt0MCywKL3mi961fUfGhbznxoBunkAg+fSQ+/kaJrsMzm/gCdsn/L5n140NaS1PMVxL1ZrFP3yNYgXV82fnqLhmzvLJPSsN/KNOHc3lesEWge7BZdHt4tNIsJZJBNIqxJgIyJuAYFvFiKRIqPs9jOMbgk/yaunotbzplQwHDftfoLYoWYsi7a8JSqY8Zgvtk4kvqUpDvKDAjqBfhAyhNBId6re7eKmxJ7JZgEMXD0Ef0tlEFyP8OLYQsrDlKq4Eo1iAePjB0l6nn6gXtxZCHF+Iy2UPqYZR4Fs7THjCJFQ8fNY5unX/QHbaWl5eBUzL/y0Zp1drh/3nYZzYR7LBroP1PAYzVABwOZV8DQjuWrMr68tJfJT0OENzkAtuhCYkD2NiO3s9FTe2sgG2OzbODhqiDUumtTKd/FXqchRcyCJHwIoav73pP2PhsHplesM3oyHBJwZDklaXeWkn4ZecuGaV9h+gvp8/N0/MFlUuo7kGoy87zDvEGIpGJNXaz+hOklMLZBa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(26005)(71200400001)(478600001)(107886003)(2616005)(83380400001)(85182001)(36756003)(86362001)(122000001)(38070700005)(5660300002)(6486002)(38100700002)(6506007)(6512007)(2906002)(4326008)(8676002)(41300700001)(54906003)(316002)(91956017)(110136005)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(7416002)(8936002)(15650500001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVZpeU1KN1ZjeGszN1FGdjdoZVdDZU1RMys3eXR5V0xwRTQ4U3owcVpFeDR4?=
 =?utf-8?B?aHNFMDRWTWpza2d4dDVFUFVZa215ZkVSbk1iTnhrT0dFN0hMVFhmaE94TkdL?=
 =?utf-8?B?K1UydjdySDhzc2JFb0dJcXViUzVCVDFleXRvRk9WdWhnV2wyTHdJaWlyTkcr?=
 =?utf-8?B?SXBvTlRHazlwNkZpTUJ3a05pdG8xODR1QzhtTE44Rm5NVFE5dXF2WlErSmxL?=
 =?utf-8?B?akhuV3RWNWdKR3lZNHZQVEhkZ1JtRHBkVXhRRU1CQzVhMllxWjVWMVdWRVZB?=
 =?utf-8?B?Vk1kZEtGTHdIajZHZEhyMWlDRFJaZjl6K1VjM1gzS1Ftbi9xalBrM2JNZkZU?=
 =?utf-8?B?M3VTWWQ3OWtWSE9nSHVHZ2w1WFRpa2NpMURMVlNUUEl6YUlmM2FGRlBJd1hL?=
 =?utf-8?B?cnowUDFWbFppeFczeEJ5YUozWkgxRDk1Q0gvR3h6THdMWVpEajFnYjQ3dDZh?=
 =?utf-8?B?d0RSS0p0RVFuMUpwNXIwZkhlR0JINmduR2ppZ2VtcWZZY3BEZHJleG9xamM5?=
 =?utf-8?B?a1krQ1laMXZHUHN5RjZQNHJmOWJMdXVCRENGNHBmSGV2SVFHVU96dVFkMU0y?=
 =?utf-8?B?OVV2bWtQdHZiRnN4WXFuanN2eVdFanorakNZaWdjR2Z4RytTS0lUQzNmNFIy?=
 =?utf-8?B?Qzd5UkQwbkFjTXkyVVpKeEEyMjFHNXRtREY4a2hZN2xnOS9wQ2pjblI4OGp0?=
 =?utf-8?B?czFFbzdGQTdoRVN1TG4yYU04ZmZVRVgzTFJEczBLNmtBY2hJWDM1WXArc1JF?=
 =?utf-8?B?WXpic2VLUmR2MDZnUms5eG5LN2dydVVmbFFCcG5xMG1xYUw3MlFudUZia3RZ?=
 =?utf-8?B?U2ozQkZZcUhsRkUzZlVTQndDTE9BUGIxNG5sbGdCQWcreDgxdVpSbEJ0Tkkv?=
 =?utf-8?B?MUVhVnBxUHRER010V3d1bEE4SEdVdFJvRUxMd0tOSXkyVkE3MXVpK25JalZz?=
 =?utf-8?B?NEVIYTFrdjFUbkY1UU9kZWlBRmZQQU85dUl5a0RWSmxwS1Z4aW9ERWEyV3Np?=
 =?utf-8?B?QzFJdG42bVJxWEFsREpPQ3NNOTFCRHhid0gwSHVpVWEycEM5SkJGZVg0WDJF?=
 =?utf-8?B?NzJGanJwZ3JOeXVFQjB6QlAyQ3pzWk0zcU1obzY4WGhOdWhSYjE4TDlLd1N4?=
 =?utf-8?B?T2kyRzRadmVTTGsrbzNPRS90SWx4ektxZW5hWDRPTWVMN1hmM0h0bFc0WkZV?=
 =?utf-8?B?MVN5OVpuM2tOUURGNzVHbEJPc05yZnJidjNUNkpHdytwMWkrUFljTHNqUTRi?=
 =?utf-8?B?emNLMW5BckhodURTUTF4UWdMVDJDRm5DNWU3ejNOaGV0UVBxWE02VTRPMThW?=
 =?utf-8?B?LytIU1VsbmEvSG11c05qMWVJTGFmWFNSZkIyZ3REc2d4WTFYWWp1NHNvaHkx?=
 =?utf-8?B?YmhFRHhiMGtQSHlpdjZMZzM5cFZPNUkxZFBoM29OY0xJWUM5ODBhNUFaSksy?=
 =?utf-8?B?TzBsL3liQ3dCb3ZVczVWc3NWYkJmSE92M1ZGdk10Y2xPTDRSRXdvZUJxZnQ0?=
 =?utf-8?B?alkyaGJ4Wi9UdmU2SmFEN2twK2JkK20yV1JyaURRRHZKY3dwVTVZbjJHVG5B?=
 =?utf-8?B?RXlxR2hETGl2SFEzMjNIQ2RzeTAwKzZOK0NSUlVjN0FTMWRscHRpT2duYS9O?=
 =?utf-8?B?cUNCOVEyOHNCWTJWSkQ1bGQwQWF4S1V6amVTamtoK3VKNkRRVzlQV3RzT00v?=
 =?utf-8?B?WUVsMkk2S2ZKak5RS0xlRERRL21VVFhlbUNPOHo1Sit5blhleUtWOU0xSnNl?=
 =?utf-8?B?T3MvaC9sMU9VNEFIYkNoak1vamFXRTJjWEpVNXljY2tPT2RLeE9WSGw1eUR1?=
 =?utf-8?B?a0t3RVprMHVCQXphcms2VTJkOFRZcW9jV0JoNnhPV0ExNTVvMGtjaTFRak94?=
 =?utf-8?B?Smg5ekhDSlVVZHN6ZlUwT2UzTDJhZTQ3SjE5a2xsTG0rR2hSRTBHdU0rTUdo?=
 =?utf-8?B?N2xwcGhlWnJKODdTWnF3ejEyVWx2V2NLMkpFQW1LTEJJWEhPTmh5QUZ5L1ov?=
 =?utf-8?B?Z0Vjak13ekp3QWhXY05USFNINlhYQS9vUW05UitHa29TK1A0b0ltU2c4U2ZN?=
 =?utf-8?B?MFo5QlRxUXZwaHRDYkFVdmVSQVY0b1JLZUUzVFhMNG5weXNyZ0RJWGpOVjdL?=
 =?utf-8?Q?RzToQJpr3OeZXMa154AIYX62W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F9EED925BC30B499F983E078B6A634C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f120cdf4-8d2c-46b9-2d4a-08dbbdc5fbc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 12:50:23.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGdvQ0mmEWevJkJ3jKizsnFhbe5tn1X0bxUg8fZbFptylSYxA6GYTApKbgTj0jgnw/EzGqx7OH2nNDX6Q9ldlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6820
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

T24gTW9uLCAyMDIzLTA5LTExIGF0IDExOjIyICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTEvMDkvMjMgMDM6MTcsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBUaGUgbGFzdGVzdCBJT01NVSBhbHdheXMgaGF2ZSA1IGJhbmtzLCBhbmQgd2UgYWx3YXlzIHVz
ZSB0aGUgbGFzdA0KPiA+IGJhbmsNCj4gPiAoaWQ6NCkgZm9yIHRoZSBzZWN1cmUgbWVtb3J5IGFk
ZHJlc3MgdHJhbnNsYXRpb24uIFRoaXMgcGF0Y2ggYWRkIGENCj4gPiBuZXcNCj4gPiBmbGFnIChT
RUNVUkVfQkFOS19FTkFCTEUpIGZvciB0aGlzIGZlYXR1cmUuDQo+ID4gDQo+ID4gRm9yIHRoZSBz
ZWN1cmUgYmFuaywgaXRzIGtlcm5lbCB2YSAiYmFzZSIgaXMgbm90IGhlbHBmdWwgc2luY2UgdGhl
DQo+ID4gc2VjdXJlIGJhbmsgcmVnaXN0ZXJzIGhhcyBhbHJlYWR5IGJlZW4gcHJvdGVjdGVkIGFu
ZCBjYW4gb25seSBiZQ0KPiA+IGFjY2Vzc2VkDQo+ID4gaW4gdGhlIHNlY3VyZSB3b3JsZC4gQnV0
IHdlIHN0aWxsIHJlY29yZCBpdHMgcmVnaXN0ZXIgYmFzZSwgYmVjYXVzZQ0KPiA+IHdlIG5lZWQN
Cj4gPiB1c2UgaXQgdG8gZGV0ZXJtaW5lIHdoaWNoIElPTU1VIEhXIHRoZSB0cmFuc2xhdGlvbiBm
YXVsdCBoYXBwZW4gaW4NCj4gPiB0aGUNCj4gPiBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogQW5hbiBTdW4gPGFuYW4uc3VuQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRy
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAxOSArKysrKysrKysrKysrKysrKy0tDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCj4gPiBpbmRleCA2NDAyNzU4NzNhMjcuLjRhMmNmZmIyOGM2MSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC0xNDYsNiArMTQ2LDcgQEANCj4gPiAgICNkZWZpbmUg
VEZfUE9SVF9UT19BRERSX01UODE3MwkJQklUKDE4KQ0KPiA+ICAgI2RlZmluZSBJTlRfSURfUE9S
VF9XSURUSF82CQlCSVQoMTkpDQo+ID4gICAjZGVmaW5lIENGR19JRkFfTUFTVEVSX0lOX0FURgkJ
QklUKDIwKQ0KPiA+ICsjZGVmaW5lIFNFQ1VSRV9CQU5LX0VOQUJMRQkJQklUKDIxKQ0KPiA+ICAg
DQo+ID4gICAjZGVmaW5lIE1US19JT01NVV9IQVNfRkxBR19NQVNLKHBkYXRhLCBfeCwgbWFzaykJ
XA0KPiA+ICAgCQkJCSgoKChwZGF0YSktPmZsYWdzKSAmIChtYXNrKSkgPT0gKF94KSkNCj4gPiBA
QCAtMTYyLDYgKzE2Myw4IEBADQo+ID4gICAjZGVmaW5lIE1US19JT01NVV9HUk9VUF9NQVgJOA0K
PiA+ICAgI2RlZmluZSBNVEtfSU9NTVVfQkFOS19NQVgJNQ0KPiA+ICAgDQo+ID4gKyNkZWZpbmUg
TVRLX0lPTU1VX1NFQ19CQU5LSUQJNA0KPiA+ICsNCj4gDQo+IElzIHRoZXJlIGFueSBTb0MgKHBy
ZXZpb3VzLCBjdXJyZW50IG9yIGZ1dHVyZSkgdGhhdCBtYXkgaGF2ZSBtb3JlDQo+IHRoYW4gb25l
DQo+IHNlY3VyZSBjb250ZXh0IGJhbms/DQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRoZSBiZWxv
dyBkZXRhaWwgc3VnZ2VzdGlvbi4gQnV0IE5vLCBmb3IgTU0gSU9NTVUsDQpUaGUgYmFuazQgaXMg
bWFuZGF0b3J5IHRoZSBzZWN1cmUgYmFuaywgYW5kIHRoZXJlIGlzIG9ubHkgdGhpcyBvbmUNCnNl
Y3VyZSBiYW5rLCBhbmQgdGhpcyBpcyB0aGUgY2FzZSBmb3IgYWxsIHRoZSBjdXJyZW50IHByb2pl
Y3RzLCB3ZSBoYXZlDQpubyBwbGFuIHRvIG1vZGlmeSB0aGlzIGF0IHRoZSBtb21lbnQuIFRoZXJl
Zm9yZSBJIHRoaW5rIGEgbWFjcm8gaXMgb2sNCmZvciBpdC4NCg0KVGhhbmtzLg0KDQo+IA0KPiBJ
J20gdGhpbmtpbmcgYWJvdXQgaW1wbGVtZW50aW5nIHRoaXMgZGlmZmVyZW50bHkuLi4NCj4gDQo+
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODhfZGF0YV92ZG8g
PSB7DQo+IAkuLi4uDQo+IAkuZmxhZ3MgPSAuLmZsYWdzLi4gfCBBVEZfU0VDVVJFX0JBTktTX0VO
QUJMRQ0KPiAJLmJhbmtzX251bSA9IDUsDQo+IAkuYmFua3NfZW5hYmxlID0ge3RydWUsIGZhbHNl
LCBmYWxzZSwgZmFsc2UsIHRydWV9LA0KPiAJLmJhbmtzX3NlY3VyZSA9IHtmYWxzZSwgZmFsc2Us
IGZhbHNlLCBmYWxzZSwgdHJ1ZX0sDQo+IAkuLi4uDQo+IH0NCj4gDQo+IC4uLnRoaXMgd291bGQg
bWVhbnMgdGhhdCB5b3Ugd29uJ3QgbmVlZCB0byBzcGVjaWZ5IGEgc3RhdGljDQo+IFNFQ19CQU5L
SUQsIGFzDQo+IHlvdSdkIGdldCB0aGF0IGZyb20gYmFua3Nfc2VjdXJlLi4uIHNvIHRoYXQuLi4u
DQo+IA0KPiA+ICAgZW51bSBtdGtfaW9tbXVfcGxhdCB7DQo+ID4gICAJTTRVX01UMjcxMiwNCj4g
PiAgIAlNNFVfTVQ2Nzc5LA0KPiA+IEBAIC0yNDAsOSArMjQzLDEzIEBAIHN0cnVjdCBtdGtfaW9t
bXVfcGxhdF9kYXRhIHsNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0cnVjdCBtdGtfaW9tbXVf
YmFua19kYXRhIHsNCj4gPiAtCXZvaWQgX19pb21lbQkJCSpiYXNlOw0KPiA+ICsJdW5pb24gew0K
PiA+ICsJCXZvaWQgX19pb21lbQkJKmJhc2U7DQo+ID4gKwkJcGh5c19hZGRyX3QJCXNlY19iYW5r
X2Jhc2U7DQo+ID4gKwl9Ow0KPiA+ICAgCWludAkJCQlpcnE7DQo+ID4gICAJdTgJCQkJaWQ7DQo+
ID4gKwlib29sCQkJCWlzX3NlY3VyZTsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlCQkJKnBhcmVudF9k
ZXY7DQo+ID4gICAJc3RydWN0IG10a19pb21tdV9kYXRhCQkqcGFyZW50X2RhdGE7DQo+ID4gICAJ
c3BpbmxvY2tfdAkJCXRsYl9sb2NrOyAvKiBsb2NrIGZvciB0bGIgcmFuZ2UNCj4gPiBmbHVzaCAq
Lw0KPiA+IEBAIC0xMzA5LDcgKzEzMTYsMTUgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUo
c3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgCQkJY29udGludWU7DQo+
ID4gICAJCWJhbmsgPSAmZGF0YS0+YmFua1tpXTsNCj4gPiAgIAkJYmFuay0+aWQgPSBpOw0KPiA+
IC0JCWJhbmstPmJhc2UgPSBiYXNlICsgaSAqIE1US19JT01NVV9CQU5LX1NaOw0KPiANCj4gLi4u
LnRoaXMgd291bGQgYmVjb21lOg0KPiANCj4gYmFuay0+aXNfc2VjdXJlID0gTVRLX0lPTU1VX0hB
U19GTEFHKGRhdGEtPnBsYXRfZGF0YSwNCj4gQVRGX1NFQ1VSRV9CQU5LU19FTkFCTEUpICYmDQo+
IAkJICBkYXRhLT5wbGF0X2RhdGEtPmJhbmtzX3NlY3VyZVtpXTsNCj4gDQo+IGlmIChiYW5rLT5p
c19zZWN1cmUpDQo+IAliYW5rLT5zZWNfYmFua19iYXNlID0gcmVzLT5zdGFydCArIGkgKiBNVEtf
SU9NTVVfQkFOS19TWjsNCj4gZWxzZQ0KPiAJYmFuay0+YmFzZSA9IGJhc2UgKyBpICogTVRLX0lP
TU1VX0JBTktfU1o7DQo+IA0KPiA+ICsJCWlmIChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxh
dF9kYXRhLA0KPiA+IFNFQ1VSRV9CQU5LX0VOQUJMRSkgJiYNCj4gPiArCQkgICAgYmFuay0+aWQg
PT0gTVRLX0lPTU1VX1NFQ19CQU5LSUQpIHsNCj4gPiArCQkJLyogUmVjb3JkIHRoZSBzZWN1cmUg
YmFuayBiYXNlIHRvIGluZGljYXRlDQo+ID4gd2hpY2ggaW9tbXUgVEYgaW4gc2VjIHdvcmxkICov
DQo+ID4gKwkJCWJhbmstPnNlY19iYW5rX2Jhc2UgPSByZXMtPnN0YXJ0ICsgaSAqDQo+ID4gTVRL
X0lPTU1VX0JBTktfU1o7DQo+ID4gKwkJCWJhbmstPmlzX3NlY3VyZSA9IHRydWU7DQo+ID4gKwkJ
fSBlbHNlIHsNCj4gPiArCQkJYmFuay0+YmFzZSA9IGJhc2UgKyBpICogTVRLX0lPTU1VX0JBTktf
U1o7DQo+ID4gKwkJCWJhbmstPmlzX3NlY3VyZSA9IGZhbHNlOw0KPiA+ICsJCX0NCj4gPiAgIAkJ
YmFuay0+bTR1X2RvbSA9IE5VTEw7DQo+ID4gICANCj4gPiAgIAkJYmFuay0+aXJxID0gcGxhdGZv
cm1fZ2V0X2lycShwZGV2LCBpKTsNCj4gDQo+IFdoYXQgZG8geW91IHRoaW5rPw0KPiANCj4gQ2hl
ZXJzLA0KPiBBbmdlbG8NCg==
