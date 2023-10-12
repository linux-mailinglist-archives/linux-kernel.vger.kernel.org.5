Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4966B7C62A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjJLCSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjJLCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:18:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C0C98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:18:42 -0700 (PDT)
X-UUID: a514f6f668a511ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UauXr2ir/AFZi9scYZoXQ3rEpKw7vajfOmjJRa+Wh9E=;
        b=MO3Pyinj4/EUBvU05s4LDDC2n9C31IDAFh4fpJCEzpmWJ9VE7xAnr6laAoaBB4O2yUNFSm+mOE0bqnTBeTuBjtjQzcD+TqnAzNEnhGRBVXbkhCHPeHW+2Gx6pC+rDEkq6J0u3ObcMCMuKRhStjPHXtnxHmCbE1oZPi9kyelv2WA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6d3d8647-80d2-46f8-9c4b-d7e78f040517,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:94d8b0f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a514f6f668a511ee8051498923ad61e6-20231012
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 747935185; Thu, 12 Oct 2023 10:18:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 10:18:33 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 10:18:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsP5yxbJvCKAFCGGkkggEErTBf3UB2eglvOiKkmjinPHywfMux19TwV2Lmh0e08KlFnOllmoLnmk/8nPyWnn9icxnWJqyokgUv0dnc4N5HWhPMREi0a7T7UHfjqMkFCSEpGeYySMsbbO3t0tZVkot3dQSBMTZX3z67vMOztiAh6IIilWlvJM9IgWcz/RpCHkmTbCRCw1gGJV9cZf3f5XKm71pB+o1L3brrVwu3SNvsyA3dA5d9cxIqHF58LrQYEFvZQCD8VyL4jkqF011D4IAkFsKTDeVEl2fl45pT9R++6WqF/y+xAAN17ZG98USljD6B4bI33vSnZbsZJAlt6VDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UauXr2ir/AFZi9scYZoXQ3rEpKw7vajfOmjJRa+Wh9E=;
 b=mpI2dIXgZlwbU/fE1T09DRpKURbURsF8c1MDFiKCbKYg0bYJdQze28qFw4owPJJ7RiWl4VSCFRXlpALdS6d76Vfz/VblXvfm91SF27w/rcmx8QayjmvJgC4Ua3Oc2x1WQfF72kZwB+j2npgqU3gaUco7eMxFTPsWr0o/EVWzAvUsXrfCjMAWxN5t/4P+6b55IjZud7ArwwKTtMek4EYo26Ipu183O3OC0ifnlmEWVzOZjj0YU2/wqEpS54mxF9P5Kagg//FU7QARSds6JvCiczt0Trw/4MdrlnFtXcqgSv0MzAFzaoPkDX71UexNxwmFqlsg1RQFQtpiViuK9lvXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UauXr2ir/AFZi9scYZoXQ3rEpKw7vajfOmjJRa+Wh9E=;
 b=P5a4DopmpTeMjzc5QLQFmsp1JhNDObVdg9bz+SEgnFLcuVURM0NvZitZ7/X6bgAIM8mYZcYbslsrmprGf6s5QOvUkwckMJ68uSMsWI319Psalx5QrsAFv2jXSOP+Ml4eNl0RhdbvTy9efczpcn4a6I+NN5MNAn/x6u7ABrWaD08=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SI2PR03MB5625.apcprd03.prod.outlook.com (2603:1096:4:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 02:18:31 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 02:18:31 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 04/11] drm/mediatek: Add OVL compatible name for MT8195
Thread-Topic: [PATCH v2 04/11] drm/mediatek: Add OVL compatible name for
 MT8195
Thread-Index: AQHZ6gwiJ9IMYcSA5UyotrP5ZCP/fbAgS3iAgAADhACAJCotAIAAJWqAgADyGAA=
Date:   Thu, 12 Oct 2023 02:18:31 +0000
Message-ID: <723b33c08e3cfed2dd2b8551b8c3db5c6ab3ddb2.camel@mediatek.com>
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
         <20230918084207.23604-5-shawn.sung@mediatek.com>
         <ffcf35cb8ca1ff0fe0a0f0176e3199b9c944b3b9.camel@mediatek.com>
         <30cc93a5-b3de-d23f-fd4d-e695551a71e3@collabora.com>
         <4f16a8ab0b2f5af0bf0d31ad26c83d7ab695c304.camel@mediatek.com>
         <ea747fbe-7311-dcec-20dc-2649bc5dd531@collabora.com>
In-Reply-To: <ea747fbe-7311-dcec-20dc-2649bc5dd531@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SI2PR03MB5625:EE_
x-ms-office365-filtering-correlation-id: d0162cf1-ac3e-4534-713d-08dbcac98783
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPNEJxo49G8NNVN8wglxrXn9RbmXaOZBxMrKWT2sdjE6F5G6d0QMMmWzAtpNEn+PEWNYm/V8N9ULW3yg4Zjy1sEV6YcDOhKs/40kV+NXXGuwIeEVkRGYv71VO3txY4yK1iwgIWeZCtLhuNkakaMA7yZXLZvR5T/zOGrStj8d+s0zj8osCWlZoBfmbvbkLotY3ZrCimg9NDupDVwpXb8WNlT3QztXcBIW47wCxEswiJzwTXNA4rt3AdmGlnaAwUb0dHaeMzf394sci9Na000IhSRJsOuGJslOwdrOt/LvlQ2hJzqQV9E61/L75H2htOGR36CnQnL/YWqM5q0CziAOAVZpdJ7J3ti55a1YiQYH2N178xo9VQBfw1TBBXs7F9pqMdl68KvEYfD6J1LTRx2aBiYg1QJojnwSD8DqSshCaVCbzt+mY8uoKWbA36ocwSOqzAbdgae3dUPBNGVxfcMbjzac19ANVrDm25lBvASs9y7NZja0uNgPZQBCUxG6nffLSs4uaGpnng+MFA1xI1/HpMtDzIbhCQp8WeLwMkSKnJP8xT7B5eVsbRN3wIaLYG5wJ8CDWZRNM04ekbpZ7V0ookFYCJIGOq0P341JqaYsUMjBqPmDgBOLslyok9OMy+E1n2DzO26mIiL/PQWJBGm2D1vH1IoAPwmgF/BkXymF8x0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(8676002)(4326008)(26005)(7416002)(38100700002)(122000001)(38070700005)(86362001)(2906002)(85182001)(4001150100001)(36756003)(41300700001)(5660300002)(6512007)(478600001)(71200400001)(6486002)(6506007)(66446008)(316002)(64756008)(66946007)(66556008)(66476007)(54906003)(2616005)(76116006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N041T1dSdVFqUlEzVUlnU0d0a1cyTlBXaFNnM3ByY05GRGdzdGVXUTBscmxw?=
 =?utf-8?B?UGI2ZXFtVC9JUmN3eXhadlVpdlc0UytITEpweDNwTzlTUHR0dDVnOXhLQmgv?=
 =?utf-8?B?NEdia25zWGtub2JmK2RkRm82SUpDeEVKYk1MdUJCb1R2YnhpTTNPZy9GYjVt?=
 =?utf-8?B?RVVJRVJUbnlvWDdsc2JlMmR2Nkp6T1JpVUVQcUMyNi9ZTlZkSUZpTTRNUURI?=
 =?utf-8?B?UUZQV0xXaXd0RDh2d3cxTUcxR3MrQ09JVTd0K1NyRGxqUGNmVGd1QkhCTDlN?=
 =?utf-8?B?NHFQS2RYQ3dDdWRRbnRrb2I1TVp5ZGRXS3J1STdkOUhaZ2JteGpUb1ZyNE1m?=
 =?utf-8?B?aENkRkRUZEQySm9oNVViQmY5ZVlnMWFTdis5RFpUMXVOekhYbVBoZi9MUkVu?=
 =?utf-8?B?eWZhVExrMzRrdHh4Mk1VS1Q5Z1lJOGtQVWZvdEZxSjZTc3lJd2hwbjdmZ1FH?=
 =?utf-8?B?NFArSHlMS1JiWUllS1FlY3ZuVDlCd3NRMjRyWDNlZnhFdkxvd2ZuSFlKRWd0?=
 =?utf-8?B?S2lMaS9pQzdzb1g3MTZibjlyT2FyeEtxdjhkanlrTm5BZnRXVk5jbU16eWVZ?=
 =?utf-8?B?NWk1bjRXenlKZnF2WGpDUk1tbTBVSFpJK2h5UTJDWDdjb0h1MmxOMzBiR1ll?=
 =?utf-8?B?SVdJdFBGanhzZGJpRk0wV2ZQNXE4S0RNclRnQzFIK3NUT241dSt2S1lPai9z?=
 =?utf-8?B?UFg4U1RRQStjaW1DRlJpMHdPZWRqdEhKK1F5MVZ4QlhGN2ZBRWZseGsxbXN2?=
 =?utf-8?B?UzU2T3prVDhhNy9GSFE1QmhZZGdoWWRJMjJ5K2l0bFR3Z1lYMVJDZW5aUkJZ?=
 =?utf-8?B?WnNCZXhWVm9uWkYxVEo4VTUzTUt3YnpqTGNHYmcvazd2Y1M0KzFVSkFOdjB5?=
 =?utf-8?B?TVJBK3hwZlJ6YSthTjBzRlYzMlJtd0Z3ekVXZlE0cmw5d2E0OE1oTG9GZ2E2?=
 =?utf-8?B?c21vZUtXWWlERkh1TWZzTWhPbFpUbGlOeDZBcmZJV2NTWTJmaVY3UTdiNHhE?=
 =?utf-8?B?ZXZYeFMxejJHVE8rVzdkTkhlZFBRdDBoQ3UrVEMvVjV4d0lYMUNDN1Rod0t2?=
 =?utf-8?B?TUZnN0lvUjBwcmVmR2FjZkxBQ1UwMWhGN2o2cVU4cXQrVThEWmpXNTl5VUtN?=
 =?utf-8?B?d1NQRjM5c2hWY0hmNnRYRWV3Y3A4M3pxOUFkdmZyYUpyTUZRQXhaVlNaS0RZ?=
 =?utf-8?B?K3EwOWtZQmdVdFhUZHU1L1lHUGN4UmptbWxwR1kvZFZhOFRpTkt2V2QxYUlM?=
 =?utf-8?B?TG9yZGxqcGE5WVJnMFliQXRiU0xLYlJBQVlMcFczd3A1dk4xRENlY3lCdmV0?=
 =?utf-8?B?QWxZWnhBcHNUcVB2NzZMeGFJa29ZNTRjNmo1SS9rMUl0V2t2dGs3SCtFZi9w?=
 =?utf-8?B?Uk11T3I3VHdiUm9XNFM1OGdIVmJXc0d0NVJaWFVOQUNNSzZmdkhvc0hCeEJP?=
 =?utf-8?B?Ykp0STdaMEIwNGtCYkZJVnJRajNtdGlHZlJFNUJDajNMeTQ1OVlOWmJRRzNo?=
 =?utf-8?B?OHdRQ2lzRXR6VkNZeVIyQ1VDNzh6bTFQSUdIVkh6cTl1N1B2a3JVUE01NUty?=
 =?utf-8?B?ZE5SMjY4MGdrZDJZNHBVUUVtNGlEbDgwM29EbnhsZUFHSDIzZXFhYldZSTQw?=
 =?utf-8?B?ZXFpK1ZWNVRTWmFFSmFBeXFuNDVNZm5wNkpWMlVqUjBELzV4WDBKNWZNUUdv?=
 =?utf-8?B?Y0Y5NTdxUVZudlZFWG1OUU03TGdaeWp1clJ1aTU0OWYydXU3VFdleHgyQjU3?=
 =?utf-8?B?NHdvMllHMzJvNWk5ZjJhOFVwZW9LVXVOZmc0SFdINytCUVdRbTlvbGlEUnlK?=
 =?utf-8?B?VEl1RDVrWUdFUW1sQk9iT0dIdmhUb3lVRkdBc3B5QWs1dTU5U1pNdEdIdkQ3?=
 =?utf-8?B?QjdVOFViVit6N1ZhMktHeEJZcG5iZTB0eUttaTVyUWsyQkQ3WklEYk1zbXFv?=
 =?utf-8?B?cGNoK2tvQjhaS1BkOE5IM2dGM1dtVDZ4MXZyeUR4RTd1UmIwdWJtekJEQ2VK?=
 =?utf-8?B?ZHBVYzlUWHl4dFVDVXhJU3VEaUtCeDJuaFRiUWlDRCt0K1ZrekU3SGR2VW1u?=
 =?utf-8?B?VjF6NlE5M1ViblpuOTQybkRjNlBqY3dqaXJUdFpGMHlwU0oydVh6c3FDR0VY?=
 =?utf-8?B?SHVCSyt3MXMvTzdPeHQyNmNsOTVDYkdTdmdsMkNRa0N5ajFFKzN1QXBKSUww?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EDAB6F45B577F4DAB90B191C36A0455@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0162cf1-ac3e-4534-713d-08dbcac98783
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 02:18:31.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qrkl/NmcKUBh6/ImUYE03cPxdPP3nfNYxly9rZaD+FyBPpG2+NdFndOCNFQDcSXDs53FNRIgbDCeaWXM1nPuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5625
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.699000-8.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
        bY7xfgXYuTy74kQkEIKTxebrH0zkSlhdPEiZHlm8Y1bQMCMvmn64vBuE2X0HleOxOq7LQlGLGJ4
        tqoRyLskNDfGmw9mdvh3l7vlEbA5torXvpLj1Q0cVglQa/gMvfDoSfZud5+GgYmQk5BUIinBWFs
        MQfbcNE3suQxnfs9eeEA2YfbVfiNH0GGSQQaBfERlckvO1m+JcfS0Ip2eEHnylPA9G9KhcvZkw8
        KdMzN86KrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.699000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7571AAE41D67D4DA43A7C1024C651A5CB0208A161B268AFE88E0FF2B322C4B172000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBXZWQsIDIwMjMtMTAtMTEgYXQgMTM6NTEgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxMS8xMC8yMyAxMTozOCwgU2hhd24gU3Vu
ZyAo5a6L5a2d6KyZKSBoYSBzY3JpdHRvOg0KPiA+IEhpLCBBbmdlbG8gYW5kIENLLA0KPiA+IA0K
PiA+IE9uIE1vbiwgMjAyMy0wOS0xOCBhdCAxMToyMSArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IElsIDE4LzA5LzIzIDExOjA5LCBDSyBIdSAo6IOh
5L+K5YWJKSBoYSBzY3JpdHRvOg0KPiA+ID4gPiBPbiBNb24sIDIwMjMtMDktMTggYXQgMTY6NDIg
KzA4MDAsIEhzaWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+ID4gPiA+ID4gQWRkIE9WTCBjb21wYXRp
YmxlIG5hbWUgZm9yIE1UODE5NS4NCj4gPiA+ID4gDQo+ID4gPiA+IFJldmlld2VkLWJ5OiBDSyBI
dSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gYnV0IGl0J3Mgd2VpcmQg
dG8gcHV0IHRoaXMgcGF0Y2ggaW50byBJR1Qgc2VyaWVzLiBXaXRob3V0IHRoaXMNCj4gPiA+ID4g
cGF0Y2gsDQo+ID4gPiA+IG10ODE5NSBkcm0gZHJpdmVyIGRvZXMgbm90IHdvcmsgbm90IG9ubHkg
SUdULg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhlIGRyaXZlciBkb2VzIHdvcmsgYmVjYXVz
ZSB0aGUgZGV2aWNldHJlZSBub2RlIGRlY2xhcmVzIHR3bw0KPiA+ID4gY29tcGF0aWJsZXMsDQo+
ID4gPiAibWVkaWF0ZWssbXQ4MTk1LWRpc3Atb3ZsIiwgIm1lZGlhdGVrLG10ODE4My1kaXNwLW92
bCIgd2hlcmUgdGhlDQo+ID4gPiBzZWNvbmQNCj4gPiA+IGNvbXBhdGlibGUgaXMgbWF0Y2hlZCBp
biBtdGtfZHJtX2RydiwgYW5kIHRoZSBmaXJzdCBpcyBtYXRjaGVkIGluDQo+ID4gPiBtdGtfZGlz
cF9vdmwNCj4gPiA+IGFzIGJvdGggYXJlIHBsYXRmb3JtX2RyaXZlci4NCj4gPiA+IA0KPiA+ID4g
VGhpcyBjb21taXQgaXMgbm90IG5lY2Vzc2FyeSwgZXZlbi4uLiA6LSkNCj4gPiA+IA0KPiA+ID4g
UmVnYXJkcywNCj4gPiA+IEFuZ2Vsbw0KPiA+ID4gDQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+
IENLDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFv
IENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+
ID4gPiA+ICAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIHwgMiArKw0K
PiA+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5j
DQo+ID4gPiA+ID4gaW5kZXggOTM1NTJkNzZiNmU3Li43NzU5YTA2ZTVjMGUgMTAwNjQ0DQo+ID4g
PiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+ID4g
PiA+IEBAIC03MTUsNiArNzE1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQN
Cj4gPiA+ID4gPiBtdGtfZGRwX2NvbXBfZHRfaWRzW10gPSB7DQo+ID4gPiA+ID4gICAgCSAgLmRh
dGEgPSAodm9pZCAqKU1US19ESVNQX09WTCB9LA0KPiA+ID4gPiA+ICAgIAl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5Mi1kaXNwLW92bCIsDQo+ID4gPiA+ID4gICAgCSAgLmRhdGEgPSAo
dm9pZCAqKU1US19ESVNQX09WTCB9LA0KPiA+ID4gPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTUtZGlzcC1vdmwiLA0KPiA+ID4gPiA+ICsJICAuZGF0YSA9ICh2b2lkICopTVRL
X0RJU1BfT1ZMIH0sDQo+ID4gPiA+ID4gICAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTgzLWRpc3Atb3ZsLTJsIiwNCj4gPiA+ID4gPiAgICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJ
U1BfT1ZMXzJMIH0sDQo+ID4gPiA+ID4gICAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTkyLWRpc3Atb3ZsLTJsIiwNCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gUGxlYXNlIHJlZmVy
IHRvIGM2YWE1ZjFmYjUwNS4gVGhpcyBpcyB0aGUgbWFpbiByZWFzb24gd2h5IHdlIGhhdmUNCj4g
PiB0bw0KPiA+IHVzZSBNVDgxOTUgaW5zdGVhZCBvZiBNVDgxODMvTVQ4MTkyLiBNb3N0IG9mIHRo
ZSBmb3JtYXRzIHJlcXVpcmVkDQo+ID4gYnkNCj4gPiBJR1QgaXMgbm90IHN1cHBvcnRlZC4NCj4g
PiANCj4gPiBXaXRob3V0IHRoaXMgY29tbWl0LCBEUk0gd29uJ3Qgd29yayBhZnRlciBjaGFuZ2lu
ZyB0aGUgY29tcGF0aWJsZQ0KPiA+IG5hbWUNCj4gPiBvZiBvdmwwIHRvICJtZWRpYXRlayxtdDgx
OTUtZGlzcC1vdmwiIGluIHRoZSBkdHMuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFNoYXduDQo+
IA0KPiBZb3UgZG9uJ3QgaGF2ZSB0byBjaGFuZ2UgYW55dGhpbmcgYXQgYWxsIGluIHRoZSBkdHMu
DQo+IA0KPiBUaGUgY3VycmVudCBtdDgxOTUuZHRzaSBkZWNsYXJlczoNCj4gY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxOTUtZGlzcC1vdmwiLCAibWVkaWF0ZWssbXQ4MTgzLWRpc3Atb3ZsIjsN
Cj4gDQo+IC4udGhpcyBpcyBlbm91Z2ggdG8gZ2V0IHRoZSBtZWRpYXRlayxtdDgxOTUtZGlzcC1v
dmwgbWF0Y2ggaW4NCj4gbXRrX2Rpc3Bfb3ZsLg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQoN
CldlIGFyZSBydW5uaW5nIElHVCBvbiBNVDgxODggYW5kIGN1cnJlbnQgcGF0Y2ggaXMgYmFzZWQg
b24gS2VybmVsIDYuMS4NCg0KUmVnYXJkcywNClNoYXduDQo=
