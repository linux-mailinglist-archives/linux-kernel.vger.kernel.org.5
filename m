Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935367577BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGRJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjGRJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:19:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124E81722
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:19:16 -0700 (PDT)
X-UUID: 2676a570254c11eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JQRYvncjIcZ5QY9xkXciGk4o1HNYL39ON390tScsYD4=;
        b=pZ9GQ+fsNGe/iPW+jtATi/H5i4h0khkqBgfY8NrW7eSA0Gq8zOIkVz6sG2CqkDlW947j9JLxXYjYbgqOmC/viP66cVC8/wtBA4tlf1qICV/Irns3xfqSrevInHY+hB3+oDQrT9oZX9dXAcWfu1RaWLKA/hA9BdFPhJWaViimE1k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:bd265fb2-5862-45ed-a81c-61ade19ab31e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:3c56badc-dc79-4898-9235-1134b97257a8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2676a570254c11eeb20a276fd37b9834-20230718
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1730217085; Tue, 18 Jul 2023 17:19:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 17:19:08 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 17:19:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXVa+zPeg5u3Gz6yPk74U2g+UwWU+9QY8eDTVY+n1SOn4V99aBZXeENs5Fnimaicc/A316joQSoDP+blIXtSmAR4E0INFNMijDe/TYha9LTY4cKy6g7zPK0dGIAj0WqqEmgX2oI4di1mmsZ6UDD+NozNXG6d1tNkKGhzeTY26tnn6D5iODG7Wd43Ggbz+zQsqyQ6UGU42xPgtW0yZ4TSk3o7zX7yvUfQmrpox/98MD2eTA3lPjulaOArFEz7h59aTyIUdgcL4XjKsgP2Oa/J2cdwjkkPdkDKmYEGo53CF/MemWh3ry9rH/TAn/NRWLy1JlXKglqOXxPipwSxlA2bIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQRYvncjIcZ5QY9xkXciGk4o1HNYL39ON390tScsYD4=;
 b=ae+kYXKPRDDjp0OmRe2GKg3XCKaKXk/olXbv2eDQs/7PpfFE5uHnQdXRlTpuRS1c1O8qDUerXB1hw6xJ2MrrhdMJXi3EXGM45WN8X7p0Yxq9/qpJLKPGo5+IStg2r2cl7JfUoTVzpriG8tyeWp+Eh5k8qHg69jrkpJxyTvrwDA5IAtsDHJxYIhWN666c1XV+y63mijBo/tGtO8pvXozw+lSLGMEkEj09vcB7G2wBtnnN2PvzGaomGsunxwhfIVaFAB5YgZeZoC672+pf0kZBjcNUDXaGK75JclnAGDKOhy8BLy6dXxUWejVNVCP/THDybOhmB23KrC3Py2Mh3tACmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQRYvncjIcZ5QY9xkXciGk4o1HNYL39ON390tScsYD4=;
 b=IU0s77tB7JqsTAUkDFXXVb3mEifLYdca75t3wlnKCfMB0lkZzdpXKRRU4Gpn/KMfCxCifYezNtBSmsQuM9pQUbr7JjStS5fuZX4gMMAgIUr5nVpF9bJDRq/mshAPoY3EjZ2dFXg/wJSfrnVuq9lHhRN7J39/nUAVpgwC0M3nlZ0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB5699.apcprd03.prod.outlook.com (2603:1096:820:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 09:19:06 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:19:06 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v6 03/11] drm/mediatek: dp: Change logging to dev for
 mtk_dp_aux_transfer()
Thread-Topic: [PATCH v6 03/11] drm/mediatek: dp: Change logging to dev for
 mtk_dp_aux_transfer()
Thread-Index: AQHZuLk9RsPwe8ENqECexkwNMNm0dK+/QFmA
Date:   Tue, 18 Jul 2023 09:19:06 +0000
Message-ID: <37256c8abfaf2cfaa53a677eccd7edecdc5a5dd8.camel@mediatek.com>
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
         <20230717141438.274419-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717141438.274419-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB5699:EE_
x-ms-office365-filtering-correlation-id: 4fc74878-cc80-4b7b-ca38-08db8770092a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eqs1N7MdN8tY8moJVBZ/j4LshsVJxHi4j+5wezxDZFvogVFJ/V4tJiW+P4fufHyrd/sqwyhxaLlfJlH/Yc17nc5pmouKVfPK48GRLteIbMKScvjplsxjjtTqTkFhvgcq28A5+MjI9Ff8QvbKUUPvtLkC7rhoAPJaIB2tok16G0pxTHHNBXr8IJxD48uhTOFqd1zmAcRlEWRBo12UtFIx98W98mOVO1qTvZUWIG5+zzYfivxI0TMHlJsk/QyFiQuqBaQC48W2mj77riIgD9lr4cCb8sb5tB3KCmBKra7mOKlCOaLEm0xxVNOPxnEhtBCZNRPyHqDXhVvd1HT0f5VWM/EchGqmkmIYpsPs1f5EBG5KCjQ2Kpuy94TSEXDjTQwq/6t0q/4IVjQok3oTLHPd9lJubFkqpR4YcYhTpEtcUP4Zz+OXTzUJbySqmuyj1KCTuXrQxSa2koSYf2JEEvyTd4UBBYSM27lY57FZWX4SgQ3zKAohiLBGb7Bm3Qu97RrC9vJMoi4WYjm52iWj79/YBPAmSPMLlMCVAdwC8Me6spb7N6rFP0Yrcd6wg+IZj9DuYy97LEWgtL4092lzgwI0wsKeh4osdoVmjAlAYu87H8sI/efrQl4QaJRJXwEeWEAPWeSNXV1V6e7EuE8lnlgDksk9sSHCV9A3X3tcxT/2duk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(54906003)(71200400001)(122000001)(6486002)(38100700002)(110136005)(41300700001)(8676002)(8936002)(5660300002)(76116006)(478600001)(66946007)(66556008)(66476007)(66446008)(316002)(64756008)(4326008)(186003)(83380400001)(6512007)(2616005)(26005)(6506007)(86362001)(36756003)(85182001)(38070700005)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzRWM3FXbjBmNEE1djducHJRWXFkRVRxVmg0OFFPb0VCMzhpNURDSUtYZm90?=
 =?utf-8?B?VHU0MlZ3TDc5YXNLTHNnS2l0bUUxY3RpZ0ROK1V5clZHYUJKQmJ5UkhpOTBS?=
 =?utf-8?B?NU5rWU9GQkptSGpBem9Xc05QeVVERVhqd1FVM2VTbDJkbGhzcE5wQXRzQXJZ?=
 =?utf-8?B?OTZZdkdlY3dZTUcxUVZ5V0s3YVJ6aWpPYkxOZzd2WWo4d0dyRWRZdEJNZ05F?=
 =?utf-8?B?QjZxVXJsR1BxZmhIVHMyRVhtL1RNNWdlNFZPNXJJeFV6dFFjczVzcEp0cmE5?=
 =?utf-8?B?THV6em51aldIYURQL3BRQzBQS2dobEFBcjBxTSs3dm9SbE95emtZbjBjaDdL?=
 =?utf-8?B?eFB1ZUl1RXpwc2JxakNmVVQ1SDUrb0FBdDRHQnlMbExBempkRzB5TXB6WEpq?=
 =?utf-8?B?T25kTDZzcVZWNVVrRnNPYTRMNWxsNGtpK0RSaUc2YnFnM0Z6dDh6cno5ckl5?=
 =?utf-8?B?RnhvdmpYZDlvYVJYMjNjNUQyeTlhMGQ2YkdwMnFDczRFbjRoMVBuZHlDeTAz?=
 =?utf-8?B?Q0dPNWZndXN4eVNxMlU3MVZ2VGNmNXVUSmU1MlUzOXNSbWFBYWJvZGxiby9j?=
 =?utf-8?B?QmZaQUtaejI3Z3o3bVZnK2U3eHlZR0paejRUK3FlSWlPTERKZHUwSHVOSThh?=
 =?utf-8?B?UWVzVXVwaG1wQTREdExqVHJsYjRPK3J5d3FqVENjMHFnSitKSjY1T05YRm5t?=
 =?utf-8?B?SDZuUHI5dVZhRjdNY05WcGRHWEF5dWF1S0ZEWEdDYUhROUdTRGNFT2doYmgz?=
 =?utf-8?B?cWVsaTVWc01MMEcwRmRESzlqcksyOFBHY3NZVy95ZTE2b1NBTDdET212V29U?=
 =?utf-8?B?WEpENzExRUtFUEtzZUlYT0RYZ3lhb1huamxFWjEvSkoydDdEUmxEZmxMOTFu?=
 =?utf-8?B?L2ZjeVE3TlozUnF6ZG1vVk9ENnU5dHhyaGN5dGhoQmU5RXc3SkxoWExaTVVC?=
 =?utf-8?B?VTZxUHNwU1RtampWU2VZbkR4aUxqUUpBWXVpWEVjazhzZDJGQ3g0SG5zTy9N?=
 =?utf-8?B?SHdSbWh1VnV2TDRqNEdTTG4rdlJ6b1poMDkrd29JOUI5STAreHoxS3VEVW5N?=
 =?utf-8?B?VnhRTlhRNmNDZ3VyVzRqUktidzZWQWtpYXVidGNBWFZTdXM5TW9HT1E5VjVN?=
 =?utf-8?B?QytkaEl6TFZLNWhobE54ME5aSFlPT1UrbUYyejJlVVBiQWM1TTFVKzBlT3Iy?=
 =?utf-8?B?eGlPNXYvYlZKeEliKzNsQmlLd2RKOXo2Mk9mV3I0WHVhN1IvcFVKWUFUdTd4?=
 =?utf-8?B?ZGRNR1p0K1M3RjlueTRBTHZPZ0ZwVnliT1dVTUlJWkQwMS8yOFlBVXk0N0dH?=
 =?utf-8?B?aFhKNy9JYUk1TFNhaU4wMGRMUWV5cnp6QkMxVlpDbUFUMmtFbjVaMTVYdDQ4?=
 =?utf-8?B?NDJXbjg5RDBTNE5aVjdUQm9GNzRnNm9EQU80WXJGclpBNG1SYjJqOWxPTTJF?=
 =?utf-8?B?OVRqRjNtRnBySldINUcxOVpLVXN6ODdFRWpWQjBkOEdsNENmWmhHZU83VlVt?=
 =?utf-8?B?UXBKRzBFK2xVdFVZNm02R0FyWjdyTDJDYUFEQnJjTVIxcXFnNTJQK2ZDTSta?=
 =?utf-8?B?T3BoWG02SXNsY0JDcEZTejk0azI0MTFqU3g4V1VqbCs5dGJJdm9INkQvYm1q?=
 =?utf-8?B?TGRMQUh5OEluaGVjaFQxanFNbDlDa0p6OS9jUzlGcDl2ZGVuUmNVMjROaHVa?=
 =?utf-8?B?YTVMM0o3d2o4cWxyR3RwT0JmcExVbE9UalplYVdYS0F6dVFaSkIzbnJvNk10?=
 =?utf-8?B?NjVDYjlPNit0YTI1UlQ2SWJQSTk5V3Y4S1JTclN0aVZienlzR2kxVkx0c3JF?=
 =?utf-8?B?dTQ1Vkx0WmJiNzZTbVFOTW5CbXRxREFNN0loeTFFWGZSSURwUFc4alE1MUNa?=
 =?utf-8?B?eDJnTjhSSDkvZWJOQTU1dHBJa2xZTDFzL3dSRlcvM0gyQkEwL1hwV0lvaEp3?=
 =?utf-8?B?dERpcUMrb05LUnhUajRMUFZzNy9GYVRHUXgyakJ0eE1HVFd5SEVVU0NXOXpy?=
 =?utf-8?B?bDdMTlN3bGlrZ2pXVEhoMk1EOERKN0puckUyb3g5MTZ1dEU3bno3UkpQNkZl?=
 =?utf-8?B?MlNuVWlnV2RnWXYyR2Y3OXZ4czY0eWkyOHI4RnZMNkFpZXNCZy9pTGptNkFn?=
 =?utf-8?Q?VLExLjoG4zuxuzXAV0f6xU9Kf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C11B5ABA888F2248A39014032A56525D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc74878-cc80-4b7b-ca38-08db8770092a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 09:19:06.2814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9hb5zsZL+Ko431mEvJpeqYj1WlTCyHo/gIdbTXm+wG69Hk2cxIKmM+sQaEkH/bGMH/jfg7c4iP+/lBJLnml+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5699
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDIzLTA3LTE3IGF0IDE2OjE0ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBDaGFuZ2UgbG9nZ2lu
ZyBmcm9tIGRybV97ZXJyLGluZm99KCkgdG8gZGV2X3tlcnIsaW5mb30oKSBpbg0KPiBmdW5jdGlv
bnMNCj4gbXRrX2RwX2F1eF90cmFuc2ZlcigpIGFuZCBtdGtfZHBfYXV4X2RvX3RyYW5zZmVyKCk6
IHRoaXMgd2lsbCBiZQ0KPiBlc3NlbnRpYWwgdG8gYXZvaWQgZ2V0dGluZyBOVUxMIHBvaW50ZXIg
a2VybmVsIHBhbmljcyBpZiBhbnkga2luZA0KPiBvZiBlcnJvciBoYXBwZW5zIGR1cmluZyBBVVgg
dHJhbnNmZXJzIGhhcHBlbmluZyBiZWZvcmUgdGhlIGJyaWRnZQ0KPiBpcyBhdHRhY2hlZC4NCj4g
DQo+IFRoaXMgbWF5IHBvdGVudGlhbGx5IHN0YXJ0IGhhcHBlbmluZyBpbiBhIGxhdGVyIGNvbW1p
dCBpbXBsZW1lbnRpbmcNCj4gYXV4LWJ1cyBzdXBwb3J0LCBhcyBBVVggdHJhbnNmZXJzIHdpbGwg
YmUgdHJpZ2dlcmVkIGZyb20gdGhlIHBhbmVsDQo+IGRyaXZlciAoZm9yIEVESUQpIGJlZm9yZSB0
aGUgbXRrLWRwIGJyaWRnZSBnZXRzIGF0dGFjaGVkLCBhbmQgaXQncw0KPiBkb25lIGluIHByZXBh
cmF0aW9uIGZvciB0aGUgc2FtZS4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRl
ay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBUZXN0ZWQt
Ynk6IENoZW4tWXUgVHNhaSA8d2Vuc3RAY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHAuYw0KPiBpbmRleCA3N2RhMGQwMDJlOWYuLjk4ZjYzZDgyMzBlNCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBAQCAtODQ3LDcgKzg0Nyw3IEBAIHN0YXRpYyBp
bnQgbXRrX2RwX2F1eF9kb190cmFuc2ZlcihzdHJ1Y3QgbXRrX2RwDQo+ICptdGtfZHAsIGJvb2wg
aXNfcmVhZCwgdTggY21kLA0KPiAgCQl1MzIgcGh5X3N0YXR1cyA9IG10a19kcF9yZWFkKG10a19k
cCwNCj4gTVRLX0RQX0FVWF9QMF8zNjI4KSAmDQo+ICAJCQkJIEFVWF9SWF9QSFlfU1RBVEVfQVVY
X1RYX1AwX01BU0s7DQo+ICAJCWlmIChwaHlfc3RhdHVzICE9IEFVWF9SWF9QSFlfU1RBVEVfQVVY
X1RYX1AwX1JYX0lETEUpIHsNCj4gLQkJCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LA0KPiArCQkJ
ZGV2X2VycihtdGtfZHAtPmRldiwNCj4gIAkJCQkiQVVYIFJ4IEF1eCBoYW5nLCBuZWVkIFNXIHJl
c2V0XG4iKTsNCj4gIAkJCXJldHVybiAtRUlPOw0KPiAgCQl9DQo+IEBAIC0yMDU0LDcgKzIwNTQs
NyBAQCBzdGF0aWMgc3NpemVfdCBtdGtfZHBfYXV4X3RyYW5zZmVyKHN0cnVjdA0KPiBkcm1fZHBf
YXV4ICptdGtfYXV4LA0KPiAgCQlpc19yZWFkID0gdHJ1ZTsNCj4gIAkJYnJlYWs7DQo+ICAJZGVm
YXVsdDoNCj4gLQkJZHJtX2VycihtdGtfYXV4LT5kcm1fZGV2LCAiaW52YWxpZCBhdXggY21kID0g
JWRcbiIsDQo+ICsJCWRldl9lcnIobXRrX2RwLT5kZXYsICJpbnZhbGlkIGF1eCBjbWQgPSAlZFxu
IiwNCj4gIAkJCW1zZy0+cmVxdWVzdCk7DQo+ICAJCXJldCA9IC1FSU5WQUw7DQo+ICAJCWdvdG8g
ZXJyOw0KPiBAQCAtMjA3MCw3ICsyMDcwLDcgQEAgc3RhdGljIHNzaXplX3QgbXRrX2RwX2F1eF90
cmFuc2ZlcihzdHJ1Y3QNCj4gZHJtX2RwX2F1eCAqbXRrX2F1eCwNCj4gIAkJCQkJICAgICB0b19h
Y2Nlc3MsICZtc2ctPnJlcGx5KTsNCj4gIA0KPiAgCQlpZiAocmV0KSB7DQo+IC0JCQlkcm1faW5m
byhtdGtfZHAtPmRybV9kZXYsDQo+ICsJCQlkZXZfaW5mbyhtdGtfZHAtPmRldiwNCj4gIAkJCQkg
IkZhaWxlZCB0byBkbyBBVVggdHJhbnNmZXI6ICVkXG4iLA0KPiByZXQpOw0KPiAgCQkJZ290byBl
cnI7DQo+ICAJCX0NCj4gLS0gDQo+IDIuNDAuMQ0K
