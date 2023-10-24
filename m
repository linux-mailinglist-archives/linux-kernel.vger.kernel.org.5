Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB727D5809
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbjJXQXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjJXQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:22:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7D26A3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:21:51 -0700 (PDT)
X-UUID: 6c06eac0728911ee8051498923ad61e6-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=thQZC35ntK4wcuxbTqngLNARsPB21X91LuuppQ54MGM=;
        b=touDfhRkyoV+8S12+zs5hYhdAKQO17Qv2CmeKpmoZvu1Cdu+OXnZrkqwGMGmesWcDtP6DZKMbkoC2AWMucffEqLOhz/qN3pSa2MXVdqcBm6y487bRO1DVUVPbo6uhTZLq+i+uvLasYArjC9yIWmht9M6zy9nshsSIhV2/I1X6Oo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:61495e46-63fc-45aa-b838-ee61b1ceb7eb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:7f2d44d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6c06eac0728911ee8051498923ad61e6-20231025
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 76952462; Wed, 25 Oct 2023 00:21:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 00:21:43 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 00:21:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVsl8unvxu7czvfviFhuzaHy3L6QVXwGzizWM5o96wnTJu6mJGB/n33cr2cetj4D21Ry0Dh+/Hi/9SZoBuDLsFFhwuVFk1OZxaNcp7wPWzhK2LK6PC1yagh2G+Df1C8o9NuXj172sYjuoqOtDoLSlrkdLUGB7RMwo+/eBjTm2JQY3tErVfspOsXgXha11dOgCflzSqkL8jsVgAWN8qbiTVzXbSKyjvwdqkhFvSWoyoZuWfyv2VcHdIVZzEAm6xm+mc2DYoRnkR3uFsHeL1/kyq1R4V0KlIP3uhNkSUvJYyXzf7Xisp5pMw6XOb2qS/S85BPoAma19WfyIpzi/AZ9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thQZC35ntK4wcuxbTqngLNARsPB21X91LuuppQ54MGM=;
 b=XnfdvC5S7JfE+zCtNW7/uJ8tnL2Sln0FZI5R7qVEs68s3Q6zcv57XA4y6mPRl1XyCoh1AFOvNINXdEWdNiK20EzejiGnTU6WcF5FdN9R6s3pbgtI9nmS0aGyHPNeAND/maulNUU3yCdu+S4tjiWEok5u9DUfxgSAtROFOcMUizI6AnYzKxaysxbZqvAYOMitqEH9sphk6EHApVqI4AfPaQRI1hlnolK+P4Cu0pezIxkd0FxwiynRWx7/JWeoXzknteWVrgrXVUqBeCGrzcOZrLfl3zsPq13szVeFMoxQDwxfFhSJ5tggTuiEfn7Lhbs5Djikfm06/rmu31RMxoDWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thQZC35ntK4wcuxbTqngLNARsPB21X91LuuppQ54MGM=;
 b=t9ESLdv8TXLw14qRLF4/Rg8W2l1PYXwORfteJM+zvGjiiYHi8ItbcRaw6234SD5YPRMRi8Ye74gQ/SiNOd1ibhzfLijietDqh9to8tS38ro0YG4YXtpvliUWnjUiSa93I+STFSfTXG/gQhCLAmSU0IaMm+Taxn2zt/ZK5CSRmwE=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7895.apcprd03.prod.outlook.com (2603:1096:400:454::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 16:21:39 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 16:21:39 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Thread-Topic: [PATCH v2 1/9] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Thread-Index: AQHaBYUzQpra4sLuvU2qkG87EeylgLBW/7uAgAIhjgA=
Date:   Tue, 24 Oct 2023 16:21:39 +0000
Message-ID: <86c3548bca53fb15f9df02b0989af6f2de2cdb7a.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-2-jason-jh.lin@mediatek.com>
         <d93ff8f4-984a-4a20-9b81-5c088baf12e8@linaro.org>
         <28cec468-e575-4d76-ac3b-52528ec5aebb@linaro.org>
In-Reply-To: <28cec468-e575-4d76-ac3b-52528ec5aebb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7895:EE_
x-ms-office365-filtering-correlation-id: d8b297eb-0b19-4544-fc13-08dbd4ad4d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vF08QodQIWIAINMy5QB+ORxRkgzk8UD+UtySL3UVMtfJO4Fo9MIj4ac1mxAHgBb5w9uD9qtWAU4f3bIGCewyLQ7kPjZ/QWYxvTeG9mHryB4BbYvjqKx7ASdgizz3VOfRLghtsiJzYYmig+jGsCgKk9YQKYjnVaI4lYbtOK4zFmagrL66/7AFidNzI5WtJkWOU1dITr9XGwk6OBVM+9xpL2w+cZWGr2vtZ0lzVqW1BEEX0W8waoo/qgiaJ0fMQP/R2A0wshdNEsVVtCi2C9YDIr7oyNxWwQcfooOoHxfU75mJBD6B0LjzAfH+jPEYeHiqpzo9E0/O5iuZy3bdD7GFRK6eQY0s32cTD1ggKIPJp1i6hABNjCV0EGw02Vo1JyR8LUliSxh/kvAHx4/h0w0XeX6tkFtkV7Z8lMj/DgmIKeUeKgRViR83W3yOL3JIKG83y4FqHdPIIPvDTPNPjXUvQx1+nT5G7QUnD9XBnKetDGCbgDSBxSLvyTR3sY6wG//It2q4JI5RMd0FPJH1/shSORmhhSlIGKgjM14NVrhy9ji59LM0te1SOO069/vQdBh02msUfOzPV5luYUHaNOu3isphWNDClNOAB11LGJH1WwLYYxaKK9jvpP9If+9Yq6txbz1rCB3j1rkZNadsG+72GEyQ9RkpWFAQrDnD+TKRnV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38070700009)(38100700002)(36756003)(83380400001)(54906003)(6512007)(122000001)(26005)(6506007)(53546011)(478600001)(71200400001)(4326008)(91956017)(110136005)(6486002)(76116006)(66446008)(8676002)(66556008)(66476007)(64756008)(5660300002)(316002)(66946007)(8936002)(85182001)(7416002)(41300700001)(86362001)(4001150100001)(2906002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEFHT3B0VzFNVU9vTTNmTjZpbkR2cFRBdDBEMlhKdG5jSS9mWE5NWC9HYzRK?=
 =?utf-8?B?clhjS3VkVWNGaDJXVW5EOFhvYkI1aVFSTkN4QjJTVVJzSGc4YTY2cjdRR2xO?=
 =?utf-8?B?QmlwOGpnN0tWSmtPY0EzQjBHUG15dzdER3RzUlB2Y1pOZjZjeFJ3eWo3OHVu?=
 =?utf-8?B?MDFxZjVtSUdTT1FIQXp0M3lMMDkvSDdYdjJXUHNEZjV1RHhFZzlFK3RTOXZY?=
 =?utf-8?B?YkdNSlFaV3VhVkJ0Yy82ZUJEVmJ0U1MzVEZHbEl6SC8xUVB1Q3B1alJ1Z05U?=
 =?utf-8?B?Z09QWWQrbjB1TXZ5blJ0ZXVNa3d1clc5ZDRJRm1qNk1LclA1elNCSlBYWHlS?=
 =?utf-8?B?bCtqRkZVSVd6UUMyNEMvMGk0T040TWVvK0c3VmgwZ052YlBPYmhIaVA1ZjJN?=
 =?utf-8?B?ZWEyUjdTZHM0dnhaV29XZDkrWnRHRjBXbTJXZ0tCbXUrZWoxc2s4a21HcjUr?=
 =?utf-8?B?QzRxODRKaUY4anE3N1NubU9XVGZrU0N2Mnl4SjFRUzhrdnE0ZFZUek9oNTdh?=
 =?utf-8?B?SlJSR1NDbDRNV2RRS25rbm1OaHBQbW9qMVc2aFRiZGthRGhIMXRjOHgvcDd0?=
 =?utf-8?B?cmsvYkJocE1jdDY1aVdrK2lnTzROQ2xGbjlFekN6b1FJdDloWlU1L1A2S0s2?=
 =?utf-8?B?VXZvdXVHYmtSQk1CUHQzRWJpOEhmc1pPRDlDbnFRdVlMZEsxdkJsc01qdkhi?=
 =?utf-8?B?UHZmQmluZjkxUmt1NlZSRlczcjFnV1FGc1EwYVBRcXVGdWFqNmtsMUpjd3dO?=
 =?utf-8?B?MnZjVm5yZ3JqY3ExQi9pd0xET1VnRFkvQ2MvK0RtWHE1OGNxK0hSTWlGa2Rt?=
 =?utf-8?B?UWY1QUxoNUpXWncyYVN6bzdkbkZSaEJMWnZvem4rUXFwSVNpOHFPUWhVY2ha?=
 =?utf-8?B?VGN2VklmWXMrOVZNYXZ3NFJzSHJCM214N0Vhb28wQ29aWjdhcmg3V3BBNTNq?=
 =?utf-8?B?Q0tac3QwajlDai9aelFBSFgwcWRweWV4elFSdldOaVVmeEJiVGM5ckd5ZVVS?=
 =?utf-8?B?SDNnYXJEVUdUaHUybm94YXFQNk4vRlNGNGx1YUlxc1V5SVFPR29ROVFHb0lU?=
 =?utf-8?B?ZW9pWkhJekluZzZVRXBVV1hXa29JNFhqdCtOSHRBNFhBRUVBMEN4QmRISDFD?=
 =?utf-8?B?bVhTWFJ5WWxaSjNNdXYxVmdEUWNZQjJhdnJRL01xeExQVTlHR0UwU2hSbm5l?=
 =?utf-8?B?N3JpdEhiOVUySzFsZmptMGwzcElIZ0FMN1p3MnZWWkd5UHpFVnhNTnJVZDRQ?=
 =?utf-8?B?QmxtK2l6Qk5rTE5PL3RpM2dMQUZtY3BleUhaWDNEZFR1cXBGbG5oNnNlUVpj?=
 =?utf-8?B?cWwvV1NUano1YUNlTHVZaThBcUlnSU5FOTduZUVIY21DU0k4V1Q3Y1VuKytq?=
 =?utf-8?B?Sks3VHZuRCs4c3JidDA1QytvNmtBeW0vamZLU0JrVEQ5OXNMWDF0MmlOMWZW?=
 =?utf-8?B?MTFkdmZEaG1nYjIzbWpJVlpFdjlFTkI5TzkwcXk4OVJHek43ck1hTG5kVkM1?=
 =?utf-8?B?MHZQNWhmaHZqcXNadmNDYnMyRmdBcmRyd0dTSVliNFVrY0duUFZ2cjVUSW9E?=
 =?utf-8?B?S3Bqcjg5TWRBNjNtK2l1R3ByNDhEUzJwUm5PSEF4VWdXSnVZNmx1dVgyNUNn?=
 =?utf-8?B?cnR2b3diZ2NZU29pYkxtZ3g3bGhIVDlZcHV1eWdleTB3ZDFINlltSmJUNksz?=
 =?utf-8?B?cXhhNHRXcmNDbldkWnJIdUpENmdCWDBDREdQc2NxLzVodHhJdXBzbHVKVUFT?=
 =?utf-8?B?b2ZzL2FJOWZGN09JcTEzTGt5V29iZ1RtbWN6V0pDeC9yRE0xcmVEdFJwTFpY?=
 =?utf-8?B?OEV3MWh6dmFyTnJZbHQ5ellpU1BRL1pkaDFWSU4zWVlXdzVBZVJ4TFdlcTE1?=
 =?utf-8?B?SWhzTWd2bzBiVnZVTTZiSFFRZlBxVGIwQnVzYVVhRTFsYlJPMEE2djJBaXdn?=
 =?utf-8?B?c3dicklqWERSRjU5MlRuNVRqeFJRWXdUN2RVSXhqSyt3TmxnNXd3MWVCVTdE?=
 =?utf-8?B?RXlkeWgvZXpVeDRMQ3M0eXFRQjR2TEM1SDkxSVFrMGdzYXNvTitOSHhSSWhY?=
 =?utf-8?B?a3BoSGQyT3FHZWNnazV4WEtTcTlrbkRzN2tSQ1o0dnBnYjZoeDVYbkxtK2Zw?=
 =?utf-8?B?UU5nNmV5YWc2bUdwSVRRTFFlL3Y1dnR0ZnFvZGgvbTVwUDMxZlo3cElxbXg0?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <516F4C3FC9CE604AB6381CD07E0D8634@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b297eb-0b19-4544-fc13-08dbd4ad4d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 16:21:39.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkBu5HKPAqrBXJVk2t48i5ZHkG3gbzxtJUGQ8DqWFk4D8H6BBhbp0KHoeFszBx854sdP4AmhQmWRuqvzXYz4w2o8Ix9vu66RNbtyeIi33hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7895
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.290500-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaaoB6BkKpx1keYAh37ZsBDCA9UhA/EMrwNV1lQ/Hn0TOskU
        hKWc+gwPyGJ1SiZNgOOsXAiB6VK48AbbLE2rYg/9wvqOGBrge3t2esxkSbCUdN5NZWlS7cHXvrw
        Rp4uT426ULKbroIyd51wl+qk7GZJzltBdgzMET5mXXOyNnX/prMMdI0UcXEHzai33DfrtRUrTll
        KjCwsxmf2PR32U32yKz4keyqnis/bDBNgbKIiiTJ4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrItRnE
        QCUU+jzjoczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.290500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2D7E0DF695F94DB397E4A25ABE940C11FCA1F78C6FE35F7C9198719CD02FBBA62000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBLcnp5c3p0b2YsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAy
My0xMC0yMyBhdCAwOTo0OSArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gIAkg
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ICBPbiAyMy8xMC8yMDIzIDA5OjQ3LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3Rl
Og0KPiA+IE9uIDIzLzEwLzIwMjMgMDY6MzcsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPj4gQ01E
UV9TWU5DX1RPS0VOX1NFQ1VSRV9USFJfRU9GIGlzIHVzZWQgYXMgc2VjdXJlIGlycSB0byBub3Rp
ZnkNCj4gQ01EUQ0KPiA+PiBkcml2ZXIgaW4gdGhlIG5vcm1hbCB3b3JsZCB0aGF0IEdDRSBzZWN1
cmUgdGhyZWFkIGhhcyBjb21wbGV0ZWQgYQ0KPiB0YXNrDQo+ID4+IGluIHRoZWUgc2VjdXJlIHdv
cmxkLg0KPiA+IA0KPiA+IHMvdGhlZS90aGUvDQoNCkknbGwgZml4IHRoaXMgdHlwbywgdGhhbmtz
IQ0KDQo+ID4gDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24t
amgubGluQG1lZGlhdGVrLmNvbT4NCj4gPj4gLS0tDQo+ID4gDQo+ID4gVGhpcyBpcyBhIG5ldyBw
YXRjaCwgc28geW91IG11c3QgbWVudGlvbiBpdCBpbiB0aGUgY2hhbmdlbG9nLiBUaGVyZQ0KPiBp
cw0KPiA+IG5vdGhpbmcgaW4gdGhlIGNoYW5nZWxvZyBzYXlpbmcgYWJvdXQgdGhpcyBuZXcgcGF0
Y2guDQo+IA0KPiBIbSwgbm93IEkgZm91bmQgcHJldmlvdXMgdGhyZWFkLiBJIGFza2VkIHRvIHNx
dWFzaCB0aGUgcGF0Y2ggd2l0aCB0aGUNCj4gYmluZGluZy4NCg0KT0ssIEkgdGhvdWdodCBJIGhh
ZCB0byByZXZlcnNlIHRoZSBvcmRlciBvZiBkZWZpbml0aW9uIHBhdGNoIGFuZCB0aGUNCmFkZCBw
cm9wZXJ0eSBwYXRjaC4NCg0KSSdsbCBzcXVhc2ggdGhlbSBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0K
DQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQo+IA0KPiANCg==
