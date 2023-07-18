Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00FD757825
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjGRJdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGRJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:33:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC15E56
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:33:47 -0700 (PDT)
X-UUID: 2e50855c254e11eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nlRxVWr3hibZB31Fkkp3R3vR3rtmyZpqzumVo+9MmdA=;
        b=b2/+/mB8nrZHvCKfexCmZKBXly7RnaQQLzmWujwoyDNbiNcQWcnUZiaqRUqvv3kS0QIxnOR325+wbkF6TriUfs5xpMhn3kr+uBcvC11U1UizsukOvuWF6x28idW5feDTloDW9PlMsMLZ1T2cymCZz+nEWxW3xzCkuTTSZJqpfVw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:35cbbf7d-df76-4ffc-98be-71115ea2922f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:2b80badc-dc79-4898-9235-1134b97257a8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2e50855c254e11eeb20a276fd37b9834-20230718
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 703046127; Tue, 18 Jul 2023 17:33:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 17:33:39 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 17:33:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbqvP5rbILk+dpsCLEiTgZCz1tGlLKHR6xGVPqcSgtvncXhv6W01t097+lcwuWE8bLt3dV662ibOCBpBLVsjAHvBRYd58nRfd6JmZCXq6bU/Q0oUWK0UOFbU9NU7jIQuDMjQjWs0Lk/2oQzZFnr7xRMs0RWpAIIn2w/3sgA/0UtSGHMevB3Tg78orkecWYrcI+Mgbgmk8+5Pci7m7YWMCuxKua+5VaJdRrvepNwfwbT9JXkhIkFO9xxHdTJSoMuILljww1C5yQ9+9q4JPlhAW8VElLon1eOciMlpwQZgaQTkxmTOggkhX2LSnz04ZBsJprS4vCBL8PuzF/94eqzi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlRxVWr3hibZB31Fkkp3R3vR3rtmyZpqzumVo+9MmdA=;
 b=WSI2ZWrP50hWYSebgvn17bdfHORkxxLO1bBPhWpNHH9Rp1EnI2SxtLVxoPqUOVaV2l0rDArB22W5FIZ8Bgu02YP1l5cMZWHlGUKrzr8RkZzCwAY2VEQGdKZtUvlvEFVeyV4DygpL5FPJ1vV6SlyES9mNfI9chotaWbBEWq816A3UC95JJNgOtv2br+57n5ZJRmvC9wUjQumU4/J/1gtO9vzq447B2ZPnTFQR0k1w5zeRraV5a6gaokqj8FexGsLT+42LcnKFvPUrCjew33pWnIwJVfLoQiLTv0YwZndHV1+ppJnAOUbEpMzFE7Tybgd+v6h+DZ1BUENUCzqrY0fcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlRxVWr3hibZB31Fkkp3R3vR3rtmyZpqzumVo+9MmdA=;
 b=bXoIQwJCTdCfc0Vlo+R0oVK1OJ89pcdwXab70kNV5QbYCvOCuDUV+b8vG11CmYWWwcDEwK/8d/VWH+X3dOTVg6cueaf73beAx3scbrUkek3LAz8JB/OkQJFIPBa0P2are6P1MM/M6qHwKvQB83TqlbuowYlZCiEvcC5rRtzHQTA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8101.apcprd03.prod.outlook.com (2603:1096:400:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:33:36 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:33:36 +0000
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
Subject: Re: [PATCH v6 04/11] drm/mediatek: dp: Use devm variant of
 drm_bridge_add()
Thread-Topic: [PATCH v6 04/11] drm/mediatek: dp: Use devm variant of
 drm_bridge_add()
Thread-Index: AQHZuLkYUe0O4+N+d0iCM7ELrHwPg6+/RGcA
Date:   Tue, 18 Jul 2023 09:33:36 +0000
Message-ID: <0be54099a44dcaeafa3ff930dcd87a780da045fb.camel@mediatek.com>
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
         <20230717141438.274419-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717141438.274419-5-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8101:EE_
x-ms-office365-filtering-correlation-id: 8e4ed415-5dbc-4dd2-9fae-08db87720fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EP3+CycHi8eddT/+zHaGhMLyKAwu1eG4yPDeHmzw3sfUvRb88FAQhLpec4pbPOcNZEcbucn9tFQ0BBzmGivgHFodjTrT/h7PI+WckrTbbDpYfntaC/M9Y5fo6h+Z8vhSSZpqvdZvSl2zy1AGsIUyy/nrtwPXZIVc6OQNl2FmW2jY9U/hdVUY9hqU9WcjoExfl7XRo9fVY+iTEHxLRMCIOVyy+N2H1z+2OHYHqJezgsT0+DWSJt2l1bzzywNAWjc0yaqZadWRMUnhJq0CL5hmwbODVbYUmXpM6bNtSafMntskjf4LEjR9NDGQzo12Mq3k0pHTL5cjLUUHSyqtmre7X8YlwArO9qp89GzSi949Gi9vXbfppXttxL+zE5rfz3lm6vQCMJvGfocpGMFw0EIztvZtE4synmr+mhUyQuzY5sVXVv96iqR29c6WUddJmu+aKukV+sCWGNTwmTqqFgpFqukW4amedSiplY2WIqJ0lSQbVN+O55Xp6dgawmvkDv+g3/Y5urRsNr4g5P/N0mxTHf7vk8ybJvXY/49zjGgzN9iyx74L17c8ZOCfr3pYRikGkpIOeMDEbKPwRL5S97VzUPK2cEiIScjubwY0WqMV+vG4MNYxaiz8r5Y4bC3iCgDy81SxwTH2AT3cbSikwhlJJy+Iy+NV1LIrkhIYGldMA0U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(5660300002)(86362001)(4326008)(41300700001)(38100700002)(66476007)(316002)(66946007)(76116006)(66446008)(66556008)(64756008)(2906002)(83380400001)(2616005)(38070700005)(122000001)(8936002)(7416002)(8676002)(36756003)(85182001)(110136005)(478600001)(54906003)(6486002)(6512007)(6506007)(26005)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU14YUFNR1hVWWhMd0FYa1NVMFdyWE9nYU5wUFpjaVBTcmdSUTBWdlNTbjEr?=
 =?utf-8?B?dlE2MnFiU09kV2psdzNuRjV3M2xIV1BidWRLbVVIQlVBc1BmQkhnQWUrNXpi?=
 =?utf-8?B?eVF2cVBIQWMrMTErMDlmV3VqMlNCY3ZLOXZVbWFQZ2pubFI3MlpGTVF5ZkJn?=
 =?utf-8?B?c2FyNXJrVnYvVGh3eUE1YXIrRE5lKzVBU0UxSkh5L3YrL2l6UThwT3lHRWFx?=
 =?utf-8?B?VU1mYXR6eU8wVTFmU3lKUUhKdFN1dmMyeHV0dmE4UC9wcFlDYUhhVnlPd093?=
 =?utf-8?B?SWsvZ3laVS9SaFo4TkpXd291MkFDcnowM0JhSXFxams2ZG14SnRpY044TEZX?=
 =?utf-8?B?UkVZVHl2SXFuMUxzcjdsNFkyamU0UG9QUUozVzRFakVIeVN6eStoMnpGeGNO?=
 =?utf-8?B?WHRuVzNmT0JBOTV0T0d1blBSREdSajYxM2Z5dWMxcTVzL3Uwd3NrQ2lnT0NY?=
 =?utf-8?B?Wlo1QmlUajRvc3hkcm9Db2tjaGJTTDl2WEZqaXA0U2s5TzdxVjBpN012T1pj?=
 =?utf-8?B?VHdhNjhEWjFhZEhEalRFRzIrVDJTU1RvUDJNdDlLY1FqdHBRdFoyT2R0SUN3?=
 =?utf-8?B?M0xoNmp0Rm9yQ2ZwZjhDZy83Mm5XMlVCZEJkN2JPSVpZMFJ5cnM5TUVZZFlL?=
 =?utf-8?B?dnA3R1NBcGRMSmh0eGF6UHlpN3N6akRkRmhDNUFJUW1qd3d3V3EzT0E4QndC?=
 =?utf-8?B?ZXAxUmVXUHlmY05RNzNhVWRUMXRqN2g2TkE5bUIrSFNTVlJha1psZU1JaGtO?=
 =?utf-8?B?QmZmWVBzcWVvRTljL2hRVER4bnhvNit5MFU1b05Ld1BVSXpBRDhnbjF6c3Fa?=
 =?utf-8?B?MkFWTGhJNHRlQ0ZKbWlNVDhxeXdLOVR5aFc3dDdvaVBGeDZqdThHY29qYmxR?=
 =?utf-8?B?QzEwMVVTZ0JxQU1NOW4yS04zeGRQZk1kWEtocXZvUlpzR2lBWGRNdDhxQkky?=
 =?utf-8?B?SWU4ODZPSGxubGtnWkl4aXhTdXlhT1NCVEk4azNaVjI0Q1ExMk1JWGpYdlpF?=
 =?utf-8?B?azFVUkJNb0I5QjFJNWVZazlDUXZyOVlXUnhFWFR5eDdjZHJKOTBTME5DQlpS?=
 =?utf-8?B?U0JyRERyeW1JVEx0dlNYYVh3d2R6NmkwSWZvaXBRYVp0ZWYybjZnamFreGY4?=
 =?utf-8?B?VXRWcmNwK3JEZDNEK3k4NjhyaUFFaUljQm8weEZBWksyYVJYMkIwVm1jeVdY?=
 =?utf-8?B?aXE1TUNSNFZxZzA3aVNMWERkc2RjOTRUUkNCWDIvZVhhTzVVV0RMMTRLRXBM?=
 =?utf-8?B?YXQveEl0dlJjUmg5OUNPNHoraCtWaGovVVVjN3RPMVhIbHB2YjQxZzRxN0w0?=
 =?utf-8?B?bDN0c0tOU0tvcCtNQmI1L0lWb0JMaU1vQnV4SU5tZUhkWkw2VTV3eDVKb095?=
 =?utf-8?B?UGRQTUtFbkN5K2xoenpKRUpDY2Q1TnpsWDZ6dTQzbkw3M1oyd0FNaDB1SmVr?=
 =?utf-8?B?cVM3QTRPbnVsdytwZnB2Wm10dGQ4WUlLQVAweDFrL2p3N1ZNczFmejZrM3hU?=
 =?utf-8?B?alcwTjlrVTVyaVZ5Y2tYZS9KRHgxSi9pZ2Z2OHMxYXYzUTNMRm9MUXpHTWtK?=
 =?utf-8?B?M1VtZy9nMUlCRnBENDNEZUl5QVlXM1ltQkNCNHpJOVJ0N0YrdmpNK0x3YjFV?=
 =?utf-8?B?QnlibDBETG1saTRqc1pmMGtqcThxUnoxR3pUMTlqTzRtR1V1U2hhQXVsQ016?=
 =?utf-8?B?Qm1PR0JHS25nYjhTTkRtMGhPam5DYTJxc2d6VGtVSnpUaGs5ZXdLWWl2czRP?=
 =?utf-8?B?U0MweXdrRmdMTlozY0VkWXZkOTVmeUhFZHRkK1VxYks0eTNMSWx5cWlWYld3?=
 =?utf-8?B?blZYbE9Bb1o3eENkMGt5OFhRTzFwZDl4bzlPSEZWK2laL3VCMU1BMTZOQzhp?=
 =?utf-8?B?a1FKTTU2Z2V4ekFiTWNEeHVVdjBCa2NlZlVXWjYwTnphekxsUVlEMEwydXQx?=
 =?utf-8?B?T0RHT0FlbUFoSEZHUTRMMXdGUzZUY2VEUXduTmwyMjB6ZjRhcFZzNmF1U1Nj?=
 =?utf-8?B?ZVY4MFZZZGttZzlpTXIwbHFmdnBReVArVFFTeDRIQ0NNb05MWWwxV2dTUFlK?=
 =?utf-8?B?NzdDVE9hdkh5NkZ3Nk16K0VSa0VsR1FCeE90dTBMVVpxWjVyYzNaNkdnWERG?=
 =?utf-8?Q?lAr8MroLm835wc4TBUGWzRFki?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DD883AACCD6224B8BC936395E9381EC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4ed415-5dbc-4dd2-9fae-08db87720fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 09:33:36.4049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxNc/sDEX47ADRsKWe0cn9NmCZFuM4vLsxM2vlqJckoY80EtYM3piRGuu0BjJ5iKxmX7b6GGR/lH2qCY3VAY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDIzLTA3LTE3IGF0IDE2OjE0ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbiBwcmVwYXJhdGlv
biBmb3IgYWRkaW5nIHN1cHBvcnQgZm9yIGF1eC1idXMsIHdoaWNoIHdpbGwgYWRkIGEgY29kZQ0K
PiBwYXRoIHRoYXQgbWF5IGZhaWwgYWZ0ZXIgdGhlIGRybV9icmlkZ2VfYWRkKCkgY2FsbCwgY2hh
bmdlIHRoYXQgdG8NCj4gZGV2bV9kcm1fYnJpZGdlX2FkZCgpIHRvIHNpbXBsaWZ5IGZhaWx1cmUg
cGF0aHMgbGF0ZXIuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0K
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gVGVzdGVkLWJ5OiBDaGVu
LVl1IFRzYWkgPHdlbnN0QGNocm9taXVtLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAu
Yw0KPiBpbmRleCA5OGY2M2Q4MjMwZTQuLmZjNmNhYmY1MzcwYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHAuYw0KPiBAQCAtMjU1Miw3ICsyNTUyLDkgQEAgc3RhdGljIGludCBtdGtf
ZHBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAkJRFJNX0JSSURH
RV9PUF9ERVRFQ1QgfCBEUk1fQlJJREdFX09QX0VESUQgfA0KPiBEUk1fQlJJREdFX09QX0hQRDsN
Cj4gIAltdGtfZHAtPmJyaWRnZS50eXBlID0gbXRrX2RwLT5kYXRhLT5icmlkZ2VfdHlwZTsNCj4g
IA0KPiAtCWRybV9icmlkZ2VfYWRkKCZtdGtfZHAtPmJyaWRnZSk7DQo+ICsJcmV0ID0gZGV2bV9k
cm1fYnJpZGdlX2FkZChkZXYsICZtdGtfZHAtPmJyaWRnZSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJ
cmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8gYWRkDQo+IGJyaWRnZVxu
Iik7DQo+ICANCj4gIAltdGtfZHAtPm5lZWRfZGVib3VuY2UgPSB0cnVlOw0KPiAgCXRpbWVyX3Nl
dHVwKCZtdGtfZHAtPmRlYm91bmNlX3RpbWVyLCBtdGtfZHBfZGVib3VuY2VfdGltZXIsIDApOw0K
PiBAQCAtMjU3MCw3ICsyNTcyLDYgQEAgc3RhdGljIGludCBtdGtfZHBfcmVtb3ZlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJcG1fcnVudGltZV9wdXQoJnBkZXYtPmRldik7
DQo+ICAJcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KPiAgCWRlbF90aW1lcl9zeW5j
KCZtdGtfZHAtPmRlYm91bmNlX3RpbWVyKTsNCj4gLQlkcm1fYnJpZGdlX3JlbW92ZSgmbXRrX2Rw
LT5icmlkZ2UpOw0KPiAgCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKG10a19kcC0+cGh5X2Rl
dik7DQo+ICAJaWYgKG10a19kcC0+YXVkaW9fcGRldikNCj4gIAkJcGxhdGZvcm1fZGV2aWNlX3Vu
cmVnaXN0ZXIobXRrX2RwLT5hdWRpb19wZGV2KTsNCj4gLS0gDQo+IDIuNDAuMQ0K
