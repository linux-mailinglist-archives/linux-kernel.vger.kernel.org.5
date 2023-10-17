Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E47CC18B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjJQLJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQLJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:09:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F0A2;
        Tue, 17 Oct 2023 04:09:43 -0700 (PDT)
X-UUID: a9bfbd306cdd11eea33bb35ae8d461a2-20231017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/9rDtTSVWsNNEoPb+30lKOQILpNV1IYfvZXmz52YaG4=;
        b=Fr347d1BMiKPJFUhl3blOJWCCeUnm4xX2nxQa2inhsHV0hEZ/X8XveGefTKLbNXr/uGHd0qyPzXX1dyOhHNpbznzakKNLb3pzWyKxVrxQhb/PCO96NOGNboaUa2On+ypZqQ+dfAqdgiqm+oRJI/Nh16tfcDvlSu1pnUH4FJx714=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:7db28caf-0100-492b-8f38-a0b67d282427,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:75bb08c0-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a9bfbd306cdd11eea33bb35ae8d461a2-20231017
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1165233395; Tue, 17 Oct 2023 19:09:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Oct 2023 19:09:37 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Oct 2023 19:09:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLKw/fwFdXKYyeN56lsylQ+CUOCOAhxton6Dkrnfxg0djI7DSLYNwkOkBTO1t6XBjY1CVFRWX24vt2mavJXPMmxtwAdlXgGM1wSyRB44lz6RryGjc+tQ6/oN4kfa1CroG28dREmKmecY1DI4/MqmK1FJJ3CsyVNFzzuWgXt+U4PMipBSgfm6FP5B5tBE3UtC1rrk6UzmNvyCI00fQquCM5QhTpC0Rzn2Y13UtuGJpsm1UL36onlxm4ed0vLoKasSXNjseaoIVLusrXQTqfX/djxLpUlf6LV/cn+evd5HjdBLyRojLisXK8W9dQzqBmZAv3ISp2dESSrXwHoTTiTb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9rDtTSVWsNNEoPb+30lKOQILpNV1IYfvZXmz52YaG4=;
 b=bkspD3B7Lk87lbV8j6SZDxBVt8N+6qtshUgi0p25+2v4IBCYS9/TTZh9/I1auPzb1LmFOepEuRT33o/QMhvEQ8Mv8TBpj7TjXGIZF5lZbwADCkVCoVzq0GWFzZwH2rkoyLMsLJlSDwjGYWnGPVbCqvjQN1I61zxoZFjpF4zmif+uabawphcv5+/lVP0CQTXjGLCbds/+pNYnDUFmN8IlhMVV+4tUqeuDZQZIG48nZ9ytAvSr0/IfzgrRR4Ru/xYAMWVhWk5D7q9rKP3gPx78r/HNFa6enxUG/7+9PW3zCws0kKE3OzFTWGh5VG6iAGd5UzUYRszM3PeTQfKYr20dcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9rDtTSVWsNNEoPb+30lKOQILpNV1IYfvZXmz52YaG4=;
 b=e/J+iYe15iPbcN2h4csN+/XQ4LayP5jGZ/EB8pYZbRtp+ZFGtTx5zXJ1lxtAt6lHCm0T2vPCTANcBldTWAhQqyRXjRo8Q4kuu0EDJKORh8ta9qOBur4xr1ROREgQHtG68pljJtrh3LWZEPDXIyG8/gQ8AMjrUsyR3fSYKAVUSZs=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB7026.apcprd03.prod.outlook.com (2603:1096:400:338::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 11:09:34 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:09:34 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v8 18/23] drm/mediatek: Add Padding to OVL adaptor
Thread-Topic: [PATCH v8 18/23] drm/mediatek: Add Padding to OVL adaptor
Thread-Index: AQHaAB1E7FjHyV0zgEaqCIF4KzE6wrBNvcuAgAAWyoA=
Date:   Tue, 17 Oct 2023 11:09:34 +0000
Message-ID: <1343d1aff7beb2f85d5a45f300a9f14f11e85531.camel@mediatek.com>
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
         <20231016104010.3270-19-shawn.sung@mediatek.com>
         <97dae7c0-0bcb-456f-b808-b794ba9e3c8a@collabora.com>
In-Reply-To: <97dae7c0-0bcb-456f-b808-b794ba9e3c8a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB7026:EE_
x-ms-office365-filtering-correlation-id: cf14f085-863a-48b7-96f9-08dbcf018b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gpe8BlQUNEXw7EtRnm1ZX+A/QtyOTAu2z8CPv04VGxxTUc+gFfUzbTd9863VxkP4rue3xw8GS+BBMlE4eKWENVYtDvBYSxD4LGocwPc9315srEVYnDhQqfnn/d9sw0zkdYIMIRNAEQs/Slots7DYKUlFBBu31sPjhgRzbAz5azmVYHQmGx0rID9H7+Zn+/NwaYBKZMB78vtQzBa2ppm3LN3Y1osQOdopIwK2cSgF8NIucSA6ySqe5EfmlYdHP5hTeT50UEAA0OYBE/dXXvjFWGX6/0nGlf3MvSlhSR+o7OsT01QsUaFx4VBKQRefbqjtGKnXRmQEiiMmJQtT6Vr15qb7Bz2skHUnCqvmwdLXzI0d+cV+dBdEnrxRwBn2hg8kfIz+srCCYAjyEBrm0XHjjIZalV1JHvfbzwvtkroYzEeaCAPWzbDTaPXRCmjb3Vk6YoL9LF57oXoWTxn9vzR4FjvuMboVUaiAjG2Z/f5BfRHcLaVOriVqSv40WeVIUE2hcPJkmKrDWc8USllJ2FnngWbkPSirlHhXiznonq/pysLAWmCt85xpmqUl2U3memaXroSEgHbyt5Tm90IQtL7WwuidWBlsxbpa093pD0WGKIw2F/+If8L8Sqk+aJ/zX1CmCqdSmDV1kemycW7FPMPNJAcUn50A2ayX2GaUDL0BXiY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4001150100001)(110136005)(7416002)(41300700001)(6486002)(86362001)(2906002)(478600001)(64756008)(36756003)(54906003)(66556008)(66476007)(66446008)(66946007)(76116006)(85182001)(6512007)(6506007)(316002)(38070700005)(8936002)(8676002)(26005)(2616005)(122000001)(4326008)(71200400001)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHh3L2pzS2hRN3dMYVZSRjBGWDBjOUk1OVUxaHZBQ2MxY0FBaC9aZ2x6VXRy?=
 =?utf-8?B?RTlRaW54cmRoZmhJYmNRei90STA1eFRadEU4dzJ3aER1bDQxbjUvUHp2Slpq?=
 =?utf-8?B?OGpTWjhUeXVVT2NSanhVR0hQREVFSWFzNWdQSTJZYXU1eG96MytBTS94bnh3?=
 =?utf-8?B?TzNJVEMzS0RWa25BUG1oWXJuaDE3UFhXeE1SeUQvUExnNTByMG41ckYwdEtx?=
 =?utf-8?B?SVRmZmZQZ3M2RlJkVXBiWC8zemt5WjZVekF4THpmUGdSVXF1U2JIeXc0Tm5p?=
 =?utf-8?B?RkJ2VER6a2pOUUlIZFBuc1V6QTZ1LzJRYjdyZ05PUFBKTEFabHdYYm5VRkdV?=
 =?utf-8?B?RDAxYzNkQmJraGduWUVPa3g2NlpuTGJ4YnU0RDVhSkc3TjlkUUt4dmFYWS8r?=
 =?utf-8?B?OW5lSWF6Y0tXUW05cnlBcno4QStVSDQ1enlNY1JrOW9WRXhnTFBFQjU0b3Zj?=
 =?utf-8?B?L3QvcXJ2ZVBFWU56eUtTd1F4Y05rd2I0S2FKTXRLSUVIMGNvTEVCNWhOYXV4?=
 =?utf-8?B?dDVCK3NjUFRjVWN6Z1Z2b045TmNQVDltQUlLNklOWW1FR3BHMGFqdVNUQ3Nz?=
 =?utf-8?B?dU1oNVpoZndsSjRSMVNrUmUrQnN2cVhnS05peWgxWjMweURCakxoNzA4SFVj?=
 =?utf-8?B?SWIwUGxJa0c3QkZzaC9jMHBwV2sveUJBZU5jY0FsTWZmazhsSHdsaCtOMGVh?=
 =?utf-8?B?NXhrTm1pa0ZHSnpFdTJ6NTZhV2VVS0xPT0tIWFdmUDJ2OGZxM3VUTmsxVmNu?=
 =?utf-8?B?UVhFcTlHQjFZTnE3YW11WjArQWhtdUxkTzlhZk1XaExiZ0JzbVRlQzVJSTVT?=
 =?utf-8?B?YTJUUHZXM0JITnRzZCtUQ2ZTcUJuZGk3RkZ0S0RVNHA5K3A5QzZObTl6N2c1?=
 =?utf-8?B?RzI1YjRGV2wxQzhYQlNZdjlKd3NvZEFUWFBmL2dRSXRqMWdFMmlyNTNscWN6?=
 =?utf-8?B?NE1yclhPRHUwYmI1UGM5SC9GeHI1UjZoc2lWZVZxRzNTS1QwVExIWUJiYUta?=
 =?utf-8?B?QUR6ZXFMZFZMZExwNmY3OEh6NVhMb0FyWEZYZHBoaXRxWlZDQzBaWkZEUnNu?=
 =?utf-8?B?RzFPSkRxamRxZnh1Q0Y1bm5oMDgrZGhHQTRZaXNkN04wcXYwMWtJYzM5SWxG?=
 =?utf-8?B?R2RObS9PZVZOV1NWN0Mwci8rWDBtQ1lWUmp5aVp4TVk3M216MDhYeGN6VGFw?=
 =?utf-8?B?ajBjMEJ0TXo0S3lvQ3BqbjlEbnBaeG9rZlNMRzZiSS84N2kxT2lxZXJHSWU3?=
 =?utf-8?B?RGE4QVFQU0V1cDFXaTNqVG1YcU1QdWkwSElNNEhZWHBjdkFmUnZuaDIveVRk?=
 =?utf-8?B?ekEwcWQzTVhIK0tiRTh0UW91VHFtMDhEV3VsdVpIeS9KblAxTlUwc29LdEFP?=
 =?utf-8?B?MzhQVTZoYktPUEdwcVkyNXRXTW94M3g0Yno3aTNBaW5CUUVjMTJMeTVHUURy?=
 =?utf-8?B?ci9uME9QQ3MzOHgva0xVSkMwQkxzRHl0SGNnSTZWeUhITGxtVTJ3R3MxZWtm?=
 =?utf-8?B?RmowZGtXZWl4dGhJeWpLK3d2MklPcFFFYVh3bkhucHNnZWV4dkFuUUtFKzNO?=
 =?utf-8?B?N1ltVTBQeGlGZmVjeW9jNDZ0Tlhnd0VESlhFaVVmOGxnL3oyb1Q3YjJuNGQ3?=
 =?utf-8?B?U1R4V2hhUnkvRVRKTVZCbnUrUTRzM2NkcFAyS0c4Y2NYbnpNQ2lEWjVleTZk?=
 =?utf-8?B?SDlGZnJrN3JHWGhsZmFkL2c3c3pRTnp4eHZBVVdyS0JRRWpWN21lQTJ6Y3Rw?=
 =?utf-8?B?bis2U1RLYjhXUE9jR2FJajFIdlIyQndtd1FvY1ZXSVB3RnJ4ZmlUVjNDZVhi?=
 =?utf-8?B?ZFc0amRkVy9JaGlLM3NMK0xiTXllNnQ2c1g0bS9oNlo1TDhpak1CaVF1ZGR1?=
 =?utf-8?B?UUo0YzdmakM5QldFNU9DbEN5QVdOS0gvRjhpMjhWdWtkK0t2VWNRb2gvOXQx?=
 =?utf-8?B?c0k5ZmFPRGFRTElVZmJzS25LVHIwckhJOXVKRkk0a2pXL0ZPUFZ5M2FoMjRp?=
 =?utf-8?B?d2hYa2tuK29mQ3NpemZnVVAxbExLRWs2KzNuaTlmU1ZxelM2VzQ3Q1ZwKytU?=
 =?utf-8?B?c0ZvOGRSMTZ1MTE3T0tucWxXMUN5VVJmWDE1ckNlT3FVZHROMjBhcU1JSGRW?=
 =?utf-8?B?V0Y2SnBuWFFKcjZxeUN5aGwvQjlDK2FCV1BkV2Z6ZjNORU9aZ2czdlh5RnlO?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3136A656B410894FAEE6E2C2297CA29A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf14f085-863a-48b7-96f9-08dbcf018b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 11:09:34.2611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEY/FYkyfU8RpgedPQyTemOoWnpt/7nuSFPpIpzuaJtacjyfPzkc/2CS/zX5al71bynXM032SjcclyYOB2xxYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7026
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.211600-8.000000
X-TMASE-MatchedRID: ewN4Wv8Mz/jUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU/wt
        lOVHF2NRUmsNbSHn8eBWz2eiIuWGmj1LciJB3541A9lly13c/gGeEP0DdJrulvNhzIgXtFJVPJ0
        5UREtjOVv/C2XaVSa9thO8fRmaO0J9BhkkEGgXxGeAiCmPx4NwMFrpUbb72MU1kTfEkyaZdz6C0
        ePs7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.211600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 569AB66FDCAF1ED998624A1AC96B219F067D99BF15E773D6EA17FF5E6E129C602000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUdWUsIDIwMjMtMTAtMTcgYXQgMTE6NDcgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxNi8xMC8yMyAxMjo0MCwgSHNpYW8gQ2hp
ZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+IEFkZCBNVDgxODggUGFkZGluZyB0byBPVkwgYWRhcHRv
ciB0byBwcm9iZSB0aGUgZHJpdmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENo
aWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuDQo+ID4gLS0tDQo+ID4gICAuLi4vZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAyNg0KPiA+ICsrKysrKysrKysr
KysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRh
cHRvci5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0
b3IuYw0KPiA+IGluZGV4IDM1NGJhNjE4NjE2Ni4uYjgwNDI1MzYwZTc2IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4g
PiBAQCAtMjksNiArMjksNyBAQCBlbnVtIG10a19vdmxfYWRhcHRvcl9jb21wX3R5cGUgew0KPiA+
ICAgCU9WTF9BREFQVE9SX1RZUEVfRVRIRFIsDQo+ID4gICAJT1ZMX0FEQVBUT1JfVFlQRV9NRFBf
UkRNQSwNCj4gPiAgIAlPVkxfQURBUFRPUl9UWVBFX01FUkdFLA0KPiA+ICsJT1ZMX0FEQVBUT1Jf
VFlQRV9QQURESU5HLA0KPiA+ICAgCU9WTF9BREFQVE9SX1RZUEVfTlVNLA0KPiA+ICAgfTsNCj4g
PiAgIA0KPiA+IEBAIC00Niw2ICs0NywxNCBAQCBlbnVtIG10a19vdmxfYWRhcHRvcl9jb21wX2lk
IHsNCj4gPiAgIAlPVkxfQURBUFRPUl9NRVJHRTEsDQo+ID4gICAJT1ZMX0FEQVBUT1JfTUVSR0Uy
LA0KPiA+ICAgCU9WTF9BREFQVE9SX01FUkdFMywNCj4gPiArCU9WTF9BREFQVE9SX1BBRERJTkcw
LA0KPiA+ICsJT1ZMX0FEQVBUT1JfUEFERElORzEsDQo+ID4gKwlPVkxfQURBUFRPUl9QQURESU5H
MiwNCj4gPiArCU9WTF9BREFQVE9SX1BBRERJTkczLA0KPiA+ICsJT1ZMX0FEQVBUT1JfUEFERElO
RzQsDQo+ID4gKwlPVkxfQURBUFRPUl9QQURESU5HNSwNCj4gPiArCU9WTF9BREFQVE9SX1BBRERJ
Tkc2LA0KPiA+ICsJT1ZMX0FEQVBUT1JfUEFERElORzcsDQo+ID4gICAJT1ZMX0FEQVBUT1JfSURf
TUFYDQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gQEAgLTY2LDYgKzc1LDcgQEAgc3RhdGljIGNvbnN0
IGNoYXIgKiBjb25zdA0KPiA+IHByaXZhdGVfY29tcF9zdGVtW09WTF9BREFQVE9SX1RZUEVfTlVN
XSA9IHsNCj4gPiAgIAlbT1ZMX0FEQVBUT1JfVFlQRV9FVEhEUl0JPSAiZXRoZHIiLA0KPiA+ICAg
CVtPVkxfQURBUFRPUl9UWVBFX01EUF9SRE1BXQk9ICJ2ZG8xLXJkbWEiLA0KPiA+ICAgCVtPVkxf
QURBUFRPUl9UWVBFX01FUkdFXQk9ICJtZXJnZSIsDQo+ID4gKwlbT1ZMX0FEQVBUT1JfVFlQRV9Q
QURESU5HXQk9ICJwYWRkaW5nIiwNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIF9ldGhkciA9IHsNCj4gPiBAQCAtODAsNiArOTAs
MTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgX21lcmdlID0NCj4g
PiB7DQo+ID4gICAJLmNsa19kaXNhYmxlID0gbXRrX21lcmdlX2Nsa19kaXNhYmxlLA0KPiA+ICAg
fTsNCj4gPiAgIA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBf
cGFkZGluZyA9IHsNCj4gDQo+IFBsZWFzZSwgX3BhZGRpbmcgLT4gcGFkZGluZyBvciBtdGtfcGFk
ZGluZw0KPiANCj4gDQo+IFRoYW5rcywNCj4gQW5nZWxvDQoNCkdvdCBpdC4gV2lsbCBjaGFuZ2Ug
aW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KU2hhd24NCg==
