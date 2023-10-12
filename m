Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035177C6354
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376666AbjJLDgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJLDgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:36:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40728A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 20:36:12 -0700 (PDT)
X-UUID: 7b6d633268b011eea33bb35ae8d461a2-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WO1STEvAjUazqMYe9i9GqJpsd1CMV0EH+drOifelr2s=;
        b=ktYse4bwuhS7IDytLrXL3sl90BVsE8+CFwB8Gf8PuhM8gWKzql0Fk9VkRYr6Ull/GGJK6BL8op34yhWOMRv/epAOgK+hH24tY/HI+bgD0JzHVUi8ACq2QPeuxZS17fK1wHhGrjnMer28NQ1FcC7YlCxuvXKxcgHqPaoRb2cAVz0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:d97cb097-51e9-45cb-9bdb-b8417ad71698,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:dd6cd5bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 7b6d633268b011eea33bb35ae8d461a2-20231012
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 475568377; Thu, 12 Oct 2023 11:36:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 11:36:07 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 11:36:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjMWHfLQEoJR7oeZUW1e5PEGvbb5JRtc7wVo67tl6be+3y4cNrvcUlBrqDsUmL3OVRHdx/6FtesmD/CANu5ri36DRAZeNCL1A3cDrRLlK/UOw2BoQErNlsJdxojK9aRBh8qrUoaG1B85+QclXXEqZFsEhNNPoZs8jWZXDF81jE/Z4J1uURlf2OcWYCodKBWwU3DOjGJHjSHN0KF2m3Vw5WbZiEOEKn/ghGqnB0AB9JTeCTkJdoUmU2vaYiUon8QssceTFEXjHAu1JUCftxD+Qk60deqPCf7LKSKn5oeT8UlyQim0Or7vdMD9pp+I3jcyiuJoSzBaQkYZ1KdITAiPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO1STEvAjUazqMYe9i9GqJpsd1CMV0EH+drOifelr2s=;
 b=f1BSzd2qL43flY2w2I3mKDzQI6DfMJuqSlKsLMt99W34qSXa9hWLzdwRAOFfp446Z83fKpvrrLCS1sQXFBorZVWDHM4qRl8+pwWtY0FJrEU2RvzYpE6rEWH+TCXNa4s0/sFO1NoH9GFEwapvmQpR5hR+qrAgQDrcQk1R4CE8ah44Zo5GAPTVV3/16A6GhcBsi6a+3sxzt1h+ZsPC+EXLJdBFC4pai+OpradhQ6XGczfZLoR1J0ABs9meGzqHmae3tilwDj9/rv7MAdblHC1NKRXTekqG0qkTHS4v7thgjutrQrLSFkfkFPS7K4o3zUfd1bxh9YNNlXeeDiQvYggcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO1STEvAjUazqMYe9i9GqJpsd1CMV0EH+drOifelr2s=;
 b=s0+/JAX2Gcha/cUGYQO6Yrr5DtImpggKSCGAr8S4QFv/DH2XTgIqdU1uqZx8A4Cr7ViW84p3cmYv74mAWzWOeYt8I1UcWmIfojnPeuFZYTrXOr/DsZjrPrKut9i/Bqp/qDySIAg5zQ9+Ni4ZqjcT90dX8ZZqRmO2R9UT1xjUzN8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6500.apcprd03.prod.outlook.com (2603:1096:400:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 03:36:05 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 03:36:04 +0000
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
Subject: Re: [PATCH v10 10/16] drm/mediatek: gamma: Support multi-bank gamma
 LUT
Thread-Topic: [PATCH v10 10/16] drm/mediatek: gamma: Support multi-bank gamma
 LUT
Thread-Index: AQHZxqV37t6gxeE7wUKmxmzIABhKb7BF7SkA
Date:   Thu, 12 Oct 2023 03:36:04 +0000
Message-ID: <9e6b3b3d7568d66e337a5455a4310ba5f81f3165.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-11-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6500:EE_
x-ms-office365-filtering-correlation-id: 53578526-ed6e-41f3-a97e-08dbcad45d36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lj/7xq31jKiGfhct5VVeSHONCMQyY3gfdFUXXBXR/5LKIvBGAwxV5tFet8/0Ccx7JKrZX8XC9QOeEZMHP7vXDc/W6wrgNa94z//ZXzGhkJoWr3+EqRfDnYsVNP891fUI6XjEK3eYjyFmpLTSZvsb0GBKcnElGkHINegW6TTRZclfAJSf3jZMditZIVMY2LBW66AHFTpu8jpi8zwhXfjA6iack2HzbA/4xdOLwi1ly0zYpzjixT9Hb48vx3knBmCFLS2QsJ78MGEbzyU7rMr6T4mQ7hnQziiZm6WRBPovyRJHnjabcYuWOzlDGNJ2E0n90jnL8pw/2c/6IvxU2ptRvUllwEh9IXyNtIosSqvxlvud1OvJi+rkf5AV0IHrfY77115TFJ5Sf+30quVdA4I6UQ/rK94pE2o6YSSsg8HbAn4fNauGYUwJeWBIIHKKd4JKgHRVrPgccMRP21bktLKLqIeWGtYfSuIUnzzkREUN/kYiJJia8fY+z+VUkl8PiyRK2XqYCMDLHy9+wJx3kc+B3XXNlggSJ8hoZr6klR4Y3yKwbEk8b4cMhN1nNQ3QIYcLRXvKH1mc4tDP4+wOdi3Fr3oNlYsupqEuI3Yp3nL6k+Wkk+5rmDhrILBI2MSxL4A67mztSpbTmU57X6osWYr6dWW0QkQtpKcTCHFL112pRLA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(8676002)(478600001)(5660300002)(66946007)(41300700001)(2906002)(4326008)(316002)(54906003)(66556008)(64756008)(66476007)(110136005)(15650500001)(7416002)(66446008)(6486002)(83380400001)(6506007)(26005)(2616005)(6512007)(76116006)(38100700002)(38070700005)(86362001)(122000001)(36756003)(85182001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFBtczRkNXpvY2F3VHNNci9wUlhtUWl4Z1FXLzlkQ0RGSlRudUFDR0xrZWF6?=
 =?utf-8?B?RytLTGk3eTJNckRpNVRjMUE5Yy9zZmhiR2JNNkpDQTlxNis5a3VkZUNTYjd4?=
 =?utf-8?B?dHhZQTdIdzRzZ2tWbW5YT2xyMG9NR3pVMjFFWEhSRzJ1dExjc2tuS25VRU42?=
 =?utf-8?B?VDBsblZyTGE5bTYrcS9iVlNOemM2dHRIQU9uNWpiRnlHZGtWM3cwUWlYb3lt?=
 =?utf-8?B?WUE4WDRsU0psS04zMGtWalQyTmNLbWcyOUtSUGYrOENVMnRPMnBncHFuUGpH?=
 =?utf-8?B?bklPRjFZS2VHcVBKc01acEhaL3Z0OExvRUxUQTJvQThPYk9lRVJlL0ZIdTRv?=
 =?utf-8?B?aE5kaDVnRkpRL3EwRTdqYmU1aTBPNjRwZy9MZnY1VWpXZzF1aHNKRXVwdm9i?=
 =?utf-8?B?aWE1V1U4bVVKaG1OcEFwbnpheXNIcEdVUGxnMG1XbnRjZFN3Qjh5N0VML0NW?=
 =?utf-8?B?dzdxRFdEa04zRVlmMitkeHA0MWxITlFrM3B5bHVUT1BYZDVTSDV1Vkk2Q2Ez?=
 =?utf-8?B?cUhQOTBOVFJvS1RPL04zZ01rSzUzZ2dSaHdOb1VrOVZNY05HVU5wSjlRbnlP?=
 =?utf-8?B?d0RaODdMYUdVZmIvelN5Mm1sZmFFUDJEYzlmL040QkRWZTltODN3ZWw3WXQv?=
 =?utf-8?B?TVZDWjF2VHJycG5ZdlRBT3BtSHBXbzc5R3RoU2VDVFR0a2dxVGFBNkpZR1Zx?=
 =?utf-8?B?YWlVYjN3OXhYak9RTDJHb2dNOGlUV1lNeFE3MUN4Q21JOVExUEdaTVFNdHZm?=
 =?utf-8?B?WG53T21ONDVBOXhDanhpR3l6cjBRZFFjVDcvSlVPU09FdXVxYnN2VW9GUU92?=
 =?utf-8?B?Y3JtTmVpQzkrZElBRXhlTjlMdUhoTU9TcE5reEJ0MDJSY2lnQWdyZ2VWU0Jo?=
 =?utf-8?B?NWhmVjg5NnFjeU5MdERFbHZtczRkdVpTN3k2eE95dHZwQ3U1Lzk4Rzh3MThW?=
 =?utf-8?B?aWRZRHMxT1UzSmE2d1Ztb1BWdlJOSHVFMklwOWFWRk9iWENpUmc4TGVWQWxh?=
 =?utf-8?B?ZmdnMkViLzhDM0krc2ZuZzRZbjFBVHowOTFSdm1RS1lRUThLUEd5cnZYRml4?=
 =?utf-8?B?YUZaSjRMektNRTlmOGFLdTRXNnpWZEZGeEU5OGIzRUhFaVVRNmgrUDZteUN2?=
 =?utf-8?B?TDhOaUpLS1pWQkhEcmJwY3JzMnRJV29PS1FCTXRwcmZGOXB4SW9JaWhka3FP?=
 =?utf-8?B?RXRKZjdGY3VWMXA1Zno3TGRMNVNnK2FVTzJvTHFDdVp1L0xoWnRKUWRPcUdT?=
 =?utf-8?B?VStzYnB6TmxjWmNXb1NjQ1JWM3ljd3NzQ1VvUnAzaHMwVW5uczJhdDVtMzg2?=
 =?utf-8?B?MitTQVZrdk9lWVdxWjVPWUdQVGRCK0pBS1ZqWlVwNG9ydTRtWHliRVRkeEw3?=
 =?utf-8?B?cVBMVDU0a1p3bG82L2phOTJIekdEZGh5TEFaSURiN3dSSXlLTlJySjJKcGxE?=
 =?utf-8?B?Zy9XWWdwMncrb1hjektQNjJhbVdwK01TbzVVdFZEdk9MdytHcVhieVFKSjB6?=
 =?utf-8?B?YkFLZkJTVUM3SFNES1dPRkt3OXc0TCszMGxEMGRsV2FSZE9zdzdJblVUY2p2?=
 =?utf-8?B?dkRqZXRnZlRXRkVRSFlVaVR6TE9qckllWFNLMUVtY2RFeHZsRTErUU1HMno5?=
 =?utf-8?B?QjJOZHU4TGxZWVFqZFV1djNNNlU0dk1yNHVBanZYY3FFV3Y0L2tkV1pYZ2hN?=
 =?utf-8?B?TzIrUy9aTDJMRE1ic0ErcHI4ZVhiR0gxbmFlWGs3NHBmaVNNUFE4clAwd3NS?=
 =?utf-8?B?a3kzUzA0WS94enlENDk5aDhYQkFseWgvOWFJWm9JN0hkK2h2TkQvWlZuWmg0?=
 =?utf-8?B?NkR2bFBVTVJ0Nk94Q2czSXY5QzJvdmpCaUwrdVJRczlXMTI0dFR2aDZ3em9L?=
 =?utf-8?B?dGhJUkJZSmNHSUVxZU0xV3NNRU1CaXhUVkRwQU9NWElid21NUEZTdkoxZVRO?=
 =?utf-8?B?aVRlbmIwMksvdW11eXZ6dlczalN3QzBTU01FckN4V1JZU1drMWJkWm5JeS85?=
 =?utf-8?B?dzJkanhZVHZxQUJxNjFsdmNUMlA2ZVZiMnFuSTZSWW5idnUrWkRzbVNyVmJD?=
 =?utf-8?B?SFBqZG1ZUzBtbWRSMStQOWxQOStETHU2NFBFSndWMGRNcUxGbGx6SjA3QVpz?=
 =?utf-8?Q?bd8sZY3q7bshNd5bUqqFpF6Js?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46DE7F8F906E49459063C79D19847D40@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53578526-ed6e-41f3-a97e-08dbcad45d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 03:36:04.8278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WigGMU4mAZsLSjV3kqqn8ngzYih5POpAbaRR2xBJ/0QTr9Iu9MkLzBkmPq86kb0pDEkm74hrND6hQksJvafB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6500
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.196500-8.000000
X-TMASE-MatchedRID: HXSqh3WYKfsNtKv7cnNXnSa1MaKuob8PC/ExpXrHizyeLRPBGqw/vqoy
        tXMP4p4TdNJNCeB8OhEsTrWjnK6DICUtdpGicV4RA9lly13c/gEK3n1SHen81Y9osn8JrdJPsxm
        BCv9mGmhHj3SvIVKiUB3sQB/VVLFrfTYIha6O7Pz0hv/rD7WVZH607foZgOWyDxjBugJBzzyBKS
        UXG3panWdNfQ/gmrCQj4SYXbqoxPo23LDAh/mSxW3NvezwBrVmfS0Ip2eEHnylPA9G9KhcvbLn+
        0Vm71Lcq7rFUcuGp/EgBwKKRHe+r5rns0VcZdfRN/hURYlFSOh7d6WWxOPcXybHcbxCxegmLyJL
        Uwy0FQw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.196500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DA5641E208C9B526253107026835F40604E239EAE2134D7A0BD535768A91C8EE2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTmV3ZXIgR2FtbWEgSVAgaGF2ZSBnb3QgbXVs
dGlwbGUgTFVUIGJhbmtzOiBzdXBwb3J0IHNwZWNpZnlpbmcgdGhlDQo+IHNpemUgb2YgdGhlIExV
VCBiYW5rcyBhbmQgaGFuZGxlIGJhbmstc3dpdGNoaW5nIGJlZm9yZSBwcm9ncmFtbWluZw0KPiB0
aGUgTFVUIGluIG10a19nYW1tYV9zZXRfY29tbW9uKCkgaW4gcHJlcGFyYXRpb24gZm9yIGFkZGlu
ZyBzdXBwb3J0DQo+IGZvciBNVDgxOTUgYW5kIG5ld2VyIFNvQ3MuDQo+IA0KPiBTdWdnZXN0ZWQt
Ynk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gW0FuZ2Vsbzog
UmVmYWN0b3JlZCBvcmlnaW5hbCBjb21taXRdDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEu
Y29tPg0KPiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEu
YyB8IDcwICsrKysrKysrKysrKysrLS0tLS0tLQ0KPiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQ0
IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gaW5kZXggMTg0NWJkMzI2YTZkLi4zZjFjNjgx
NWVhNWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9n
YW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5j
DQo+IEBAIC0yNCw2ICsyNCw4IEBADQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfU0laRQkJCQkweDAw
MzANCj4gICNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX0hTSVpFCQkJCUdFTk1BU0sNCj4gKDI4LCAx
NikNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX1ZTSVpFCQkJCUdFTk1BU0sNCj4gKDEyLCAw
KQ0KPiArI2RlZmluZSBESVNQX0dBTU1BX0JBTksJCQkJMHgwMTAwDQo+ICsjZGVmaW5lIERJU1Bf
R0FNTUFfQkFOS19CQU5LCQkJCUdFTk1BU0soMSwgMCkNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9M
VVQJCQkJMHgwNzAwDQo+ICANCj4gICNkZWZpbmUgRElTUF9HQU1NQV9MVVRfMTBCSVRfUgkJCUdF
Tk1BU0soMjksIDIwKQ0KPiBAQCAtMzcsNiArMzksNyBAQA0KPiAgc3RydWN0IG10a19kaXNwX2dh
bW1hX2RhdGEgew0KPiAgCWJvb2wgaGFzX2RpdGhlcjsNCj4gIAlib29sIGx1dF9kaWZmOw0KPiAr
CXUxNiBsdXRfYmFua19zaXplOw0KPiAgCXUxNiBsdXRfc2l6ZTsNCj4gIAl1OCBsdXRfYml0czsN
Cj4gIH07DQo+IEBAIC04MCw0MSArODMsNTQgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0KHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0DQo+IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIAl1bnNpZ25l
ZCBpbnQgaTsNCj4gIAlzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqbHV0Ow0KPiAgCXZvaWQgX19pb21l
bSAqbHV0X2Jhc2U7DQo+IC0JdTMyIGNmZ192YWwsIHdvcmQ7DQo+ICsJdTMyIGNmZ192YWwsIGxi
YW5rX3ZhbCwgd29yZDsNCj4gKwlpbnQgY3VyX2JhbmssIG51bV9sdXRfYmFua3M7DQo+ICANCj4g
IAkvKiBJZiB0aGVyZSdzIG5vIGdhbW1hIGx1dCB0aGVyZSdzIG5vdGhpbmcgdG8gZG8gaGVyZS4g
Ki8NCj4gIAlpZiAoIXN0YXRlLT5nYW1tYV9sdXQpDQo+ICAJCXJldHVybjsNCj4gIA0KPiArCW51
bV9sdXRfYmFua3MgPSBnYW1tYS0+ZGF0YS0+bHV0X3NpemUgLyBnYW1tYS0+ZGF0YS0NCj4gPmx1
dF9iYW5rX3NpemU7DQo+ICAJY2ZnX3ZhbCA9IHJlYWRsKGdhbW1hLT5yZWdzICsgRElTUF9HQU1N
QV9DRkcpOw0KPiAgCWx1dF9iYXNlID0gZ2FtbWEtPnJlZ3MgKyBESVNQX0dBTU1BX0xVVDsNCj4g
IAlsdXQgPSAoc3RydWN0IGRybV9jb2xvcl9sdXQgKilzdGF0ZS0+Z2FtbWFfbHV0LT5kYXRhOw0K
PiAtCWZvciAoaSA9IDA7IGkgPCBnYW1tYS0+ZGF0YS0+bHV0X3NpemU7IGkrKykgew0KPiAtCQlz
dHJ1Y3QgZHJtX2NvbG9yX2x1dCBkaWZmLCBod2x1dDsNCj4gLQ0KPiAtCQlod2x1dC5yZWQgPSBk
cm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLnJlZCwgZ2FtbWEtDQo+ID5kYXRhLT5sdXRfYml0
cyk7DQo+IC0JCWh3bHV0LmdyZWVuID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtpXS5ncmVl
biwNCj4gZ2FtbWEtPmRhdGEtPmx1dF9iaXRzKTsNCj4gLQkJaHdsdXQuYmx1ZSA9IGRybV9jb2xv
cl9sdXRfZXh0cmFjdChsdXRbaV0uYmx1ZSwgZ2FtbWEtDQo+ID5kYXRhLT5sdXRfYml0cyk7DQo+
IC0NCj4gLQkJaWYgKCFnYW1tYS0+ZGF0YS0+bHV0X2RpZmYgfHwgKGkgJSAyID09IDApKSB7DQo+
IC0JCQl3b3JkID0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9SLA0KPiBod2x1dC5y
ZWQpOw0KPiAtCQkJd29yZCB8PSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0csDQo+
IGh3bHV0LmdyZWVuKTsNCj4gLQkJCXdvcmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8x
MEJJVF9CLA0KPiBod2x1dC5ibHVlKTsNCj4gLQkJfSBlbHNlIHsNCj4gLQkJCWRpZmYucmVkID0g
bHV0W2ldLnJlZCAtIGx1dFtpIC0gMV0ucmVkOw0KPiAtCQkJZGlmZi5yZWQgPSBkcm1fY29sb3Jf
bHV0X2V4dHJhY3QoZGlmZi5yZWQsDQo+IGdhbW1hLT5kYXRhLT5sdXRfYml0cyk7DQo+IC0NCj4g
LQkJCWRpZmYuZ3JlZW4gPSBsdXRbaV0uZ3JlZW4gLSBsdXRbaSAtIDFdLmdyZWVuOw0KPiAtCQkJ
ZGlmZi5ncmVlbiA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLmdyZWVuLA0KPiBnYW1tYS0+
ZGF0YS0+bHV0X2JpdHMpOw0KPiAtDQo+IC0JCQlkaWZmLmJsdWUgPSBsdXRbaV0uYmx1ZSAtIGx1
dFtpIC0gMV0uYmx1ZTsNCj4gLQkJCWRpZmYuYmx1ZSA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChk
aWZmLmJsdWUsDQo+IGdhbW1hLT5kYXRhLT5sdXRfYml0cyk7DQo+IC0NCj4gLQkJCXdvcmQgPSBG
SUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX1IsDQo+IGRpZmYucmVkKTsNCj4gLQkJCXdv
cmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9HLA0KPiBkaWZmLmdyZWVuKTsN
Cj4gLQkJCXdvcmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9CLA0KPiBkaWZm
LmJsdWUpOw0KPiArDQo+ICsJZm9yIChjdXJfYmFuayA9IDA7IGN1cl9iYW5rIDwgbnVtX2x1dF9i
YW5rczsgY3VyX2JhbmsrKykgew0KPiArDQo+ICsJCS8qIFN3aXRjaCBnYW1tYSBiYW5rIGFuZCBz
ZXQgZGF0YSBtb2RlIGJlZm9yZSB3cml0aW5nDQo+IExVVCAqLw0KPiArCQlpZiAobnVtX2x1dF9i
YW5rcyA+IDEpIHsNCj4gKwkJCWxiYW5rX3ZhbCA9IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9CQU5L
X0JBTkssDQo+IGN1cl9iYW5rKTsNCj4gKwkJCXdyaXRlbChsYmFua192YWwsIGdhbW1hLT5yZWdz
ICsNCj4gRElTUF9HQU1NQV9CQU5LKTsNCj4gKwkJfQ0KPiArDQo+ICsJCWZvciAoaSA9IDA7IGkg
PCBnYW1tYS0+ZGF0YS0+bHV0X2Jhbmtfc2l6ZTsgaSsrKSB7DQo+ICsJCQlpbnQgbiA9IChjdXJf
YmFuayAqIGdhbW1hLT5kYXRhLT5sdXRfYmFua19zaXplKSANCj4gKyBpOw0KDQppbnQgbiA9IGN1
cl9iYW5rICogZ2FtbWEtPmRhdGEtPmx1dF9iYW5rX3NpemUgKyBpOw0KDQpBZnRlciB0aGlzIG1v
ZGlmaWNhdGlvbiwNCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoN
Cj4gKwkJCXN0cnVjdCBkcm1fY29sb3JfbHV0IGRpZmYsIGh3bHV0Ow0KPiArDQo+ICsJCQlod2x1
dC5yZWQgPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W25dLnJlZCwNCj4gZ2FtbWEtPmRhdGEt
Pmx1dF9iaXRzKTsNCj4gKwkJCWh3bHV0LmdyZWVuID0NCj4gZHJtX2NvbG9yX2x1dF9leHRyYWN0
KGx1dFtuXS5ncmVlbiwgZ2FtbWEtPmRhdGEtPmx1dF9iaXRzKTsNCj4gKwkJCWh3bHV0LmJsdWUg
PSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W25dLmJsdWUsDQo+IGdhbW1hLT5kYXRhLT5sdXRf
Yml0cyk7DQo+ICsNCj4gKwkJCWlmICghZ2FtbWEtPmRhdGEtPmx1dF9kaWZmIHx8IChpICUgMiA9
PSAwKSkgew0KPiArCQkJCXdvcmQgPQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklU
X1IsIGh3bHV0LnJlZCk7DQo+ICsJCQkJd29yZCB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFf
TFVUXzEwQklUX0csIGh3bHV0LmdyZWVuKTsNCj4gKwkJCQl3b3JkIHw9DQo+IEZJRUxEX1BSRVAo
RElTUF9HQU1NQV9MVVRfMTBCSVRfQiwgaHdsdXQuYmx1ZSk7DQo+ICsJCQl9IGVsc2Ugew0KPiAr
CQkJCWRpZmYucmVkID0gbHV0W25dLnJlZCAtIGx1dFtuIC0gMV0ucmVkOw0KPiArCQkJCWRpZmYu
cmVkID0NCj4gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYucmVkLCBnYW1tYS0+ZGF0YS0+bHV0
X2JpdHMpOw0KPiArDQo+ICsJCQkJZGlmZi5ncmVlbiA9IGx1dFtuXS5ncmVlbiAtIGx1dFtuIC0N
Cj4gMV0uZ3JlZW47DQo+ICsJCQkJZGlmZi5ncmVlbiA9DQo+IGRybV9jb2xvcl9sdXRfZXh0cmFj
dChkaWZmLmdyZWVuLCBnYW1tYS0+ZGF0YS0+bHV0X2JpdHMpOw0KPiArDQo+ICsJCQkJZGlmZi5i
bHVlID0gbHV0W25dLmJsdWUgLSBsdXRbbiAtDQo+IDFdLmJsdWU7DQo+ICsJCQkJZGlmZi5ibHVl
ID0NCj4gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYuYmx1ZSwgZ2FtbWEtPmRhdGEtPmx1dF9i
aXRzKTsNCj4gKw0KPiArCQkJCXdvcmQgPQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEw
QklUX1IsIGRpZmYucmVkKTsNCj4gKwkJCQl3b3JkIHw9DQo+IEZJRUxEX1BSRVAoRElTUF9HQU1N
QV9MVVRfMTBCSVRfRywgZGlmZi5ncmVlbik7DQo+ICsJCQkJd29yZCB8PQ0KPiBGSUVMRF9QUkVQ
KERJU1BfR0FNTUFfTFVUXzEwQklUX0IsIGRpZmYuYmx1ZSk7DQo+ICsJCQl9DQo+ICsJCQl3cml0
ZWwod29yZCwgKGx1dF9iYXNlICsgaSAqIDQpKTsNCj4gIAkJfQ0KPiAtCQl3cml0ZWwod29yZCwg
KGx1dF9iYXNlICsgaSAqIDQpKTsNCj4gIAl9DQo+ICANCj4gIAkvKiBFbmFibGUgdGhlIGdhbW1h
IHRhYmxlICovDQo+IEBAIC0yMTgsMTEgKzIzNCwxMyBAQCBzdGF0aWMgaW50IG10a19kaXNwX2dh
bW1hX3JlbW92ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX2dhbW1hX2RhdGEgbXQ4MTczX2dhbW1hX2RyaXZlcl9k
YXRhID0gew0KPiAgCS5oYXNfZGl0aGVyID0gdHJ1ZSwNCj4gKwkubHV0X2Jhbmtfc2l6ZSA9IDUx
MiwNCj4gIAkubHV0X2JpdHMgPSAxMCwNCj4gIAkubHV0X3NpemUgPSA1MTIsDQo+ICB9Ow0KPiAg
DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX2dhbW1hX2RhdGEgbXQ4MTgzX2dhbW1h
X2RyaXZlcl9kYXRhID0gew0KPiArCS5sdXRfYmFua19zaXplID0gNTEyLA0KPiAgCS5sdXRfYml0
cyA9IDEwLA0KPiAgCS5sdXRfZGlmZiA9IHRydWUsDQo+ICAJLmx1dF9zaXplID0gNTEyLA0K
