Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E117C7C83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjJMESc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMES2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:18:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1BB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:18:26 -0700 (PDT)
X-UUID: 8c58d5a8697f11eea33bb35ae8d461a2-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fNO8GbxCwUQNozWGEMaNDkpuok+DDWRnkxXF03l2XZ8=;
        b=cxK6S9Nqgkqt8vzrls3VgiI7nN/3TjwwY0m8tmdNvsLxpGPFPPRidwC6cXi2RdiqL8P0/aLuLclBTKm8NOcEQmTXsOGq9cdYMqkN8jvX+GTKRTFNsgzv0NwYhvosHKeVhSVzq5jKp/vMp2htP/bPIYVxgWsOp6wqdb3AdcMwBFw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:a99cf671-4502-41a5-9d4b-f23554a0fe68,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:839c12c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8c58d5a8697f11eea33bb35ae8d461a2-20231013
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1830048657; Fri, 13 Oct 2023 12:18:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 12:18:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 12:18:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyrkVqJz26n+r3nSmBf7QNt3+g/gHeTX5lAFzV4zH3aUqSIQKwzpAgQXF3cprNV2Rs/b/RC6tVYJ4vksarWww3+pZ8ufrf4Z+aqA+ZL8ScBt6KyTzunYEWBiQLAN0rB7NgAa6jBsslZbfZGSeEzLV15uHx3sfL/Ai1U+wt0xi1nlp7sIJJxHRb+sNnOpjyl28nAuZNMjXVEn+B6KO1smiIw36jIbQjLQANNlg0sfFowOoB6xvUvW6UKKmnRzchY0IV8gAIpwu/jY3ptKcegdaCGv6nIPKqyNxAePlcQ0MvrUIZSBKw4JLKJzks89H1Y21OGrEtHD0x9jNCKvWqkJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNO8GbxCwUQNozWGEMaNDkpuok+DDWRnkxXF03l2XZ8=;
 b=N35roRfI1KT+T9lkMR1/Nqhd2tYgEaqlIEV8zd/ke44ClJsv239XZGUbcvsTtiy6gjh1mjOKhHlg5CwSFMvtAIvEcFoGaCe1RmMoOdN101ysbJ+fdw8PX+XsJiZYx6/yqYjc/O4UUgP3KEr4iOXYHPYLLGKnSZvZdidXsdKXa4K2zoY8ldHcECINgaxmJurXiLzA4VkqsBfQGNojBM7PevOg1izRGrgOzjjLv/4/NuENMexD2kZNrb++zaIYI6XLAjxFbC9pixW90vs3OaAI4V4GJhp0KljTu3B5C/yNO/icF7bHiBEg9NPOXELnRwV4yBPF1BLrGVFztWnve2Jxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNO8GbxCwUQNozWGEMaNDkpuok+DDWRnkxXF03l2XZ8=;
 b=BiPBSIGTkB/ePZa2UC9yABd5Z6Pv/7vtxHU4gusPTnTTjnaUr4ogovFys1Mg8zOGauBhCRkEKGpcFUG5AnQc1DBcrDxhd1LjLO6xDacXUnhdBJ6tbHZwbMq12ikrDQWPqH9H4bF33L9lFzskxWcWb4ICVxBleq8jLbSMBAhymgE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8239.apcprd03.prod.outlook.com (2603:1096:820:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 04:18:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 04:18:18 +0000
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
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v11 10/16] drm/mediatek: gamma: Add support for 12-bit LUT
Thread-Topic: [PATCH v11 10/16] drm/mediatek: gamma: Add support for 12-bit
 LUT
Thread-Index: AQHZ/PK7vgoJEtoaSke3dlkg5vIIDrBHHrAA
Date:   Fri, 13 Oct 2023 04:18:18 +0000
Message-ID: <53ec10846cd81958546ac6cfd2bf7e865aa5c91a.camel@mediatek.com>
References: <20231012095736.100784-1-angelogioacchino.delregno@collabora.com>
         <20231012095736.100784-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231012095736.100784-11-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8239:EE_
x-ms-office365-filtering-correlation-id: fe109016-f3bc-46fc-98a4-08dbcba36df8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oibH8SNbTTs73tiy7N09jsDnVvlSkD1OEr/ZFsYRovUmN4bAUCQZdtlYVg72oM0cYJJ6y8RgarqqiN0oyGTPCKZphmL95R9grLUK5dOuGWa9a6aIgE5xg1zM1+OamC+V+G5IeVT21UV1qTDsbWY3K8JhVDww75d/iuoZExH06xDeN5h0veYn5LeI80A2MSWZwABqj3K9hyZKZA8LsQPE7cSDDdFtLD2+0dIW0sW781GbbvSBrkcwR51JHuDnAU0ifsjwcjpjzQ2o3IL+gjKhfV+yMCzGVKQlVH9tIHnR3ZJ8BX626aZbX8yiE/T0aKy2GpwQNICLqDsXTRtUgLXRfgHtuvzYbbqFMMFK5fWp6/MzW4UrdeQpY3zbu1rAOZ8nW+OHpmwT3mBt7e7PzPXid8O0gXetBukZ9DEc1iFfp7JyKULLmh8NHM6cZ4E3d+96bB1TlrnxfEvj/JQElwaxwo+QY7T78Rxq0U26GtDMmh6JBBl3CW9T9G+SYllDtBvEslN96JlCW5Jn1o+p6KroPKyj9REDkENgkE59UbHL0+680tFZ5Ec2Fx1TgnUXGlhSjPiUe3q3GGcRfdNFzH1lnhKpCBYgvAk8V5Nu+akGkip9wEbGSh9+D6dsfUTa7VpWitWWvgrud3fZ5w9jMDXZbWz52YQckwx0iocG3lXb7dY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7416002)(71200400001)(2906002)(6486002)(478600001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66556008)(66946007)(54906003)(66476007)(66446008)(64756008)(110136005)(76116006)(316002)(36756003)(6506007)(85182001)(83380400001)(26005)(6512007)(2616005)(122000001)(86362001)(38070700005)(4001150100001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnpvRXQzRHVwWTNJRjlMUkxXQlRUb0VFK2Ixc3BwajAvWWkvdjNCZ29YKzdH?=
 =?utf-8?B?QmN0dENCcFYzM3dyQ1ZKWVdtUDd2NmR2UlhTM3dZdUdheGlqV0VYTC9ROC85?=
 =?utf-8?B?NTlzWjNiL2t1YkNVYVMya1pwNHBicDNodG5zeEpvNFZHTXBsVEg0Qk1KdXVQ?=
 =?utf-8?B?S1RPQk50TWtCRzd2RmxGU1FHazhEL0J1T0g4RzJmOXI5Q1pOZGlRTFUreGJl?=
 =?utf-8?B?a2hpZVg5eTZBU3NLZERSbUF5eHRGY0hIZUpJQzVwUHU0ZnM5US9LWFl6dUs0?=
 =?utf-8?B?d0J0ZEluUFBCS3JSeHE3bTYxYnF0UkY0emI3OHJBS3N2clRQa3RpRk9kSHRC?=
 =?utf-8?B?cUwyeXdobXU3bFhsa2pEeEhRQVlYQmdjQWxRcjBQb3BIZ0J3bUcwM1cwdi9z?=
 =?utf-8?B?VFlSd2tJKzlheXRMU1grVzkrV01URHFNdjNidE9zVkdpTlpWUCszc2tBRVhR?=
 =?utf-8?B?bTBkU3RxRVJWYmp6NGt6emRGMTcyb2tzQXVwc2ZIaStrNTlBSFR2S1RMVW1x?=
 =?utf-8?B?SUdnb3RCRXFBUFNQZGNGREFBcDUvU24rMHBjVWZTZFFzNjg2b2FlQnpuNEtR?=
 =?utf-8?B?VXpyUThTc3hia0hrMXFOQUd1Z0IvcjdESTdlblV3U2luQVAvVGhqWVdCTmtC?=
 =?utf-8?B?UDRmbFJ2S3BpbUVJcGpOb0RpZFBRbnlYUDU2YzFXZ1V6SjdzdE1WRmVwTVZX?=
 =?utf-8?B?QWdEa2RlbmNEWUVrckQzSlY3ZUxMR3Fla0ZCY0lDd2JTZ0J4RUpDTzBaS3hr?=
 =?utf-8?B?MkpobTJXdXJZWktwYzQ2RVlpODltU0t3cWx5S29jYjY3aTQwQTJqdkE1V0VE?=
 =?utf-8?B?TlNaSm1NQjk2V1VyeTVBdWV3cXpBRnlFQVNSSlFiaWk0ZXhlaWdoWjF2OTNt?=
 =?utf-8?B?UUVsUGNnOHNYR09uQnBEalZvUDRTcy9BS0c4WXJDQVZ1cDhySkUyd2RGdDdy?=
 =?utf-8?B?TDZ3L1kzNHAwanBmTVVQeE1BaGxEaVRnMTdNVVNrS1IzdlNJVllETzJpbnov?=
 =?utf-8?B?aXFSODR1amRzNktkWmJPZ3VuNFJHNjNGMWlmZUFrOHNSeWxDd2UwQmowMnJm?=
 =?utf-8?B?QjVXaU5XR2lzN2tETE4vUTVFME12YmxUY29YbjdXQzRwUzRvYUJGNWYyS3hB?=
 =?utf-8?B?c3pjOWNRT3ZZNXB1d3E2bkZwQmRnQnZtVFQ2cmthdG9vemc3TEJNeVFtUDRB?=
 =?utf-8?B?eDFYZ3FrbC9hdHZhNUlHaWwyTlBEcXRDNU9wN1A4NHFTc0xZRjlBb3RDY2hm?=
 =?utf-8?B?cU02NTlXaXhZNm42RWI5WGw0UmtaRmh1b1JvOEo0UHFzZVNFMGs3bm9Cdkxh?=
 =?utf-8?B?UDR4MFBTN2J6SmtZSUwxTGExVXA5bmFjUW11UEt3dWhreDZ3UTNmbzdKa052?=
 =?utf-8?B?Vk50dnM1bTl0SUJ4ajZIMGVoQnMzZ2MyMURmMEVOSGNBMWM1T3Y5bkhkakcz?=
 =?utf-8?B?M0YrdXJnQTlKVENuKzh2aUtxWHI2NHVTNjlQbm4wL0tPWERnU1FibUVGOExs?=
 =?utf-8?B?TzZBa1BjczNpQ29BSTZTU2Z4dVVDRGFlZ1c4dFlpZUdLZWZYZEp2Q29UOFMz?=
 =?utf-8?B?YW1kZ3YwMWwyT0lqYVJlWmVKbGJsTHRlWkEyQUpoWWZERXE3cDdBYU5PNmZ3?=
 =?utf-8?B?ZHFqN2ExVmJKOGZ6K1BLSWxpNTVuaDhzS3pyRzJqNGozVXZaTSt4L3lDWUwy?=
 =?utf-8?B?TjFUejBQTmRnZjhmRnd5Vm8wV2ZzcTRPaXJzMUxjSU5WQVYvay9OUUY1cVBS?=
 =?utf-8?B?a1ZSR2tIUEM5bXZqV3hMVkV1Zmp6Z1F2ZjlQNTlDcUhFS1FnWTRPZUNrOHNM?=
 =?utf-8?B?M29YMERZNm1mQUpkWkNNbCtWNXk4QTc4SUNWMS8xZGprYnhNdW5zVytTYVpu?=
 =?utf-8?B?UCt5RCtJMWVzYWZwNHRZb2FNZnhZRGR1K0xDZk95ZDdiUFF3YWRzdGlnZkpK?=
 =?utf-8?B?N1lPbUs4ZlRlc3ZVT0VuVER5aXE3WkxZRG5zYXB0MkV3eWVDaEl4OEVKYWNo?=
 =?utf-8?B?Wi90MVFERmlnSks1eS85aThmUzNTaUVDTW9lQmtRbGEzZ3JCNGFwSE1lME4r?=
 =?utf-8?B?dUd2NjFCZDV6QXFnM2l1MGpYZWNVSktLdjJTTGFhbGJraFpYcFh5TmpiU3pp?=
 =?utf-8?Q?359rTxNYfseHByN97xnjh8JV8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBC43EFA7750044088CF888F51DCDDF0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe109016-f3bc-46fc-98a4-08dbcba36df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 04:18:18.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5udDfHVfOnKubtjOzfIohqHCb95zAfCV/FAswR/r0HFM5Bm79h2YoMZQepCZqmgFSdfzdactVZgW57kVkOXag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTEwLTEyIGF0IDExOjU3ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTmV3IFNvQ3MsIGxpa2UgTVQ4MTk1LCBub3Qg
b25seSBtYXkgc3VwcG9ydCBiaWdnZXIgbG9va3VwIHRhYmxlcywgYnV0DQo+IGhhdmUgZ290IGEg
ZGlmZmVyZW50IHJlZ2lzdGVyIGxheW91dCB0byBzdXBwb3J0IGJpZ2dlciBwcmVjaXNpb246DQo+
IHN1cHBvcnQgc3BlY2lmeWluZyB0aGUgbnVtYmVyIG9mIGBsdXRfYml0c2AgZm9yIGVhY2ggU29D
IGFuZCB1c2UgaXQNCj4gaW4gbXRrX2dhbW1hX3NldF9jb21tb24oKSB0byBwZXJmb3JtIHRoZSBy
aWdodCBjYWxjdWxhdGlvbnMgYW5kIGFkZA0KPiBzdXBwb3J0IGZvciAxMi1iaXQgZ2FtbWEgbG9v
a3VwIHRhYmxlcy4NCj4gDQo+IFdoaWxlIGF0IGl0LCBhbHNvIHJlb3JkZXIgdGhlIHZhcmlhYmxl
cyBpbiBtdGtfZ2FtbWFfc2V0X2NvbW1vbigpDQo+IGFuZCByZW5hbWUgYGx1dF9iYXNlYCB0byBg
bHV0MF9iYXNlYCB0byBpbXByb3ZlIHJlYWRhYmlsaXR5Lg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IEphc29uLUpILkxpbiA8
amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBNZXJn
bmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5j
IHwgODMgKysrKysrKysrKysrKysrKystLQ0KPiAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjQg
aW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiBpbmRleCA5MTE0Njg5ODRhZDUuLjYzMDVjZDk1
ZTZkNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dh
bW1hLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMN
Cj4gQEAgLTI2LDE3ICsyNiwyNiBAQA0KPiAgI2RlZmluZSBESVNQX0dBTU1BX1NJWkVfVlNJWkUJ
CQkJR0VOTUFTSw0KPiAoMTIsIDApDQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfQkFOSwkJCQkweDAx
MDANCj4gICNkZWZpbmUgRElTUF9HQU1NQV9CQU5LX0JBTksJCQkJR0VOTUFTSygxLCAwKQ0KPiAr
I2RlZmluZSBESVNQX0dBTU1BX0JBTktfREFUQV9NT0RFCQkJQklUKDIpDQo+ICAjZGVmaW5lIERJ
U1BfR0FNTUFfTFVUCQkJCTB4MDcwMA0KPiArI2RlZmluZSBESVNQX0dBTU1BX0xVVDEJCQkJMHgw
YjAwDQo+ICANCj4gKy8qIEZvciAxMCBiaXQgTFVUIGxheW91dCwgUi9HL0IgYXJlIGluIHRoZSBz
YW1lIHJlZ2lzdGVyICovDQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfTFVUXzEwQklUX1IJCQlHRU5N
QVNLKDI5LCAyMCkNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9MVVRfMTBCSVRfRwkJCUdFTk1BU0so
MTksIDEwKQ0KPiAgI2RlZmluZSBESVNQX0dBTU1BX0xVVF8xMEJJVF9CCQkJR0VOTUFTSyg5LCAw
KQ0KPiAgDQo+ICsvKiBGb3IgMTIgYml0IExVVCBsYXlvdXQsIFIvRyBhcmUgaW4gTFVULCBCIGlz
IGluIExVVDEgKi8NCj4gKyNkZWZpbmUgRElTUF9HQU1NQV9MVVRfMTJCSVRfUgkJCUdFTk1BU0so
MTEsIDApDQo+ICsjZGVmaW5lIERJU1BfR0FNTUFfTFVUXzEyQklUX0cJCQlHRU5NQVNLKDIzLCAx
MikNCj4gKyNkZWZpbmUgRElTUF9HQU1NQV9MVVRfMTJCSVRfQgkJCUdFTk1BU0soMTEsIDApDQo+
ICsNCj4gIHN0cnVjdCBtdGtfZGlzcF9nYW1tYV9kYXRhIHsNCj4gIAlib29sIGhhc19kaXRoZXI7
DQo+ICAJYm9vbCBsdXRfZGlmZjsNCj4gIAl1MTYgbHV0X2Jhbmtfc2l6ZTsNCj4gIAl1MTYgbHV0
X3NpemU7DQo+ICsJdTggbHV0X2JpdHM7DQo+ICB9Ow0KPiAgDQo+ICAvKg0KPiBAQCAtNzIsMjgg
KzgxLDQ4IEBAIHVuc2lnbmVkIGludCBtdGtfZ2FtbWFfZ2V0X2x1dF9zaXplKHN0cnVjdCBkZXZp
Y2UNCj4gKmRldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArLyoNCj4gKyAqIFNvQ3Mg
c3VwcG9ydGluZyAxMi1iaXRzIExVVHMgYXJlIHVzaW5nIGEgbmV3IHJlZ2lzdGVyIGxheW91dCB0
aGF0DQo+IGRvZXMNCj4gKyAqIGFsd2F5cyBzdXBwb3J0IChieSBIVykgYm90aCAxMi1iaXRzIGFu
ZCAxMC1iaXRzIExVVCBidXQsIG9uDQo+IHRob3NlLCB3ZQ0KPiArICogaWdub3JlIHRoZSBzdXBw
b3J0IGZvciAxMC1iaXRzIGluIHRoaXMgZHJpdmVyIGFuZCBhbHdheXMgdXNlIDEyLQ0KPiBiaXRz
Lg0KPiArICoNCj4gKyAqIFN1bW1hcml6aW5nOg0KPiArICogLSBTb0MgSFcgc3VwcG9ydCA5LzEw
LWJpdHMgTFVUIG9ubHkNCj4gKyAqICAgLSBPbGQgcmVnaXN0ZXIgbGF5b3V0DQo+ICsgKiAgICAg
LSAxMC1iaXRzIExVVCBzdXBwb3J0ZWQNCj4gKyAqICAgICAtIDktYml0cyBMVVQgbm90IHN1cHBv
cnRlZA0KPiArICogLSBTb0MgSFcgc3VwcG9ydCBib3RoIDEwLzEyYml0cyBMVVQNCj4gKyAqICAg
LSBOZXcgcmVnaXN0ZXIgbGF5b3V0DQo+ICsgKiAgICAgLSAxMi1iaXRzIExVVCBzdXBwb3J0ZWQN
Cj4gKyAqICAgICAtIDEwLWl0cyBMVVQgbm90IHN1cHBvcnRlZA0KPiArICovDQo+ICB2b2lkIG10
a19nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0
YXRlKQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZGlzcF9nYW1tYSAqZ2FtbWEgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gLQl1bnNpZ25lZCBpbnQgaTsNCj4gLQlzdHJ1Y3QgZHJtX2NvbG9yX2x1
dCAqbHV0Ow0KPiAtCXZvaWQgX19pb21lbSAqbHV0X2Jhc2U7DQo+IC0JdTMyIGNmZ192YWwsIGxi
YW5rX3ZhbCwgd29yZDsNCj4gKwl2b2lkIF9faW9tZW0gKmx1dDBfYmFzZSA9IGdhbW1hLT5yZWdz
ICsgRElTUF9HQU1NQV9MVVQ7DQo+ICsJdm9pZCBfX2lvbWVtICpsdXQxX2Jhc2UgPSBnYW1tYS0+
cmVncyArIERJU1BfR0FNTUFfTFVUMTsNCj4gKwl1MzIgY2ZnX3ZhbCwgZGF0YV9tb2RlLCBsYmFu
a192YWwsIHdvcmRbMl07DQo+ICsJdTggbHV0X2JpdHMgPSBnYW1tYS0+ZGF0YS0+bHV0X2JpdHM7
DQo+ICAJaW50IGN1cl9iYW5rLCBudW1fbHV0X2JhbmtzOw0KPiArCXN0cnVjdCBkcm1fY29sb3Jf
bHV0ICpsdXQ7DQo+ICsJdW5zaWduZWQgaW50IGk7DQo+ICANCj4gIAkvKiBJZiB0aGVyZSdzIG5v
IGdhbW1hIGx1dCB0aGVyZSdzIG5vdGhpbmcgdG8gZG8gaGVyZS4gKi8NCj4gIAlpZiAoIXN0YXRl
LT5nYW1tYV9sdXQpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAgCW51bV9sdXRfYmFua3MgPSBnYW1t
YS0+ZGF0YS0+bHV0X3NpemUgLyBnYW1tYS0+ZGF0YS0NCj4gPmx1dF9iYW5rX3NpemU7DQo+IC0J
bHV0X2Jhc2UgPSBnYW1tYS0+cmVncyArIERJU1BfR0FNTUFfTFVUOw0KPiAgCWx1dCA9IChzdHJ1
Y3QgZHJtX2NvbG9yX2x1dCAqKXN0YXRlLT5nYW1tYV9sdXQtPmRhdGE7DQo+ICANCj4gKwkvKiBT
d2l0Y2ggdG8gMTIgYml0cyBkYXRhIG1vZGUgaWYgc3VwcG9ydGVkICovDQo+ICsJZGF0YV9tb2Rl
ID0gRklFTERfUFJFUChESVNQX0dBTU1BX0JBTktfREFUQV9NT0RFLCAhIShsdXRfYml0cw0KPiA9
PSAxMikpOw0KPiArDQo+ICAJZm9yIChjdXJfYmFuayA9IDA7IGN1cl9iYW5rIDwgbnVtX2x1dF9i
YW5rczsgY3VyX2JhbmsrKykgew0KPiAgDQo+ICAJCS8qIFN3aXRjaCBnYW1tYSBiYW5rIGFuZCBz
ZXQgZGF0YSBtb2RlIGJlZm9yZSB3cml0aW5nDQo+IExVVCAqLw0KPiAgCQlpZiAobnVtX2x1dF9i
YW5rcyA+IDEpIHsNCj4gIAkJCWxiYW5rX3ZhbCA9IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9CQU5L
X0JBTkssDQo+IGN1cl9iYW5rKTsNCj4gKwkJCWxiYW5rX3ZhbCB8PSBkYXRhX21vZGU7DQo+ICAJ
CQl3cml0ZWwobGJhbmtfdmFsLCBnYW1tYS0+cmVncyArDQo+IERJU1BfR0FNTUFfQkFOSyk7DQo+
ICAJCX0NCj4gIA0KPiBAQCAtMTAxLDI5ICsxMzAsNDMgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0KHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIAkJ
CWludCBuID0gY3VyX2JhbmsgKiBnYW1tYS0+ZGF0YS0+bHV0X2Jhbmtfc2l6ZSArDQo+IGk7DQo+
ICAJCQlzdHJ1Y3QgZHJtX2NvbG9yX2x1dCBkaWZmLCBod2x1dDsNCj4gIA0KPiAtCQkJaHdsdXQu
cmVkID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtuXS5yZWQsDQo+IDEwKTsNCj4gLQkJCWh3
bHV0LmdyZWVuID0NCj4gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtuXS5ncmVlbiwgMTApOw0K
PiAtCQkJaHdsdXQuYmx1ZSA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbbl0uYmx1ZSwNCj4g
MTApOw0KPiArCQkJaHdsdXQucmVkID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtuXS5yZWQs
DQo+IGx1dF9iaXRzKTsNCj4gKwkJCWh3bHV0LmdyZWVuID0NCj4gZHJtX2NvbG9yX2x1dF9leHRy
YWN0KGx1dFtuXS5ncmVlbiwgbHV0X2JpdHMpOw0KPiArCQkJaHdsdXQuYmx1ZSA9IGRybV9jb2xv
cl9sdXRfZXh0cmFjdChsdXRbbl0uYmx1ZSwNCj4gbHV0X2JpdHMpOw0KPiAgDQo+ICAJCQlpZiAo
IWdhbW1hLT5kYXRhLT5sdXRfZGlmZiB8fCAoaSAlIDIgPT0gMCkpIHsNCj4gLQkJCQl3b3JkID0N
Cj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9SLCBod2x1dC5yZWQpOw0KPiAtCQkJ
CXdvcmQgfD0NCj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9HLCBod2x1dC5ncmVl
bik7DQo+IC0JCQkJd29yZCB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0Is
IGh3bHV0LmJsdWUpOw0KPiArCQkJCWlmIChsdXRfYml0cyA9PSAxMikgew0KPiArCQkJCQl3b3Jk
WzBdID0NCj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMkJJVF9SLCBod2x1dC5yZWQpOw0K
PiArCQkJCQl3b3JkWzBdIHw9DQo+IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTJCSVRfRywg
aHdsdXQuZ3JlZW4pOw0KPiArCQkJCQl3b3JkWzFdID0NCj4gRklFTERfUFJFUChESVNQX0dBTU1B
X0xVVF8xMkJJVF9CLCBod2x1dC5ibHVlKTsNCj4gKwkJCQl9IGVsc2Ugew0KPiArCQkJCQl3b3Jk
WzBdID0NCj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9SLCBod2x1dC5yZWQpOw0K
PiArCQkJCQl3b3JkWzBdIHw9DQo+IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfRywg
aHdsdXQuZ3JlZW4pOw0KPiArCQkJCQl3b3JkWzBdIHw9DQo+IEZJRUxEX1BSRVAoRElTUF9HQU1N
QV9MVVRfMTBCSVRfQiwgaHdsdXQuYmx1ZSk7DQo+ICsJCQkJfQ0KPiAgCQkJfSBlbHNlIHsNCj4g
IAkJCQlkaWZmLnJlZCA9IGx1dFtuXS5yZWQgLSBsdXRbbiAtIDFdLnJlZDsNCj4gLQkJCQlkaWZm
LnJlZCA9DQo+IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLnJlZCwgMTApOw0KPiArCQkJCWRp
ZmYucmVkID0NCj4gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYucmVkLCBsdXRfYml0cyk7DQo+
ICANCj4gIAkJCQlkaWZmLmdyZWVuID0gbHV0W25dLmdyZWVuIC0gbHV0W24gLQ0KPiAxXS5ncmVl
bjsNCj4gLQkJCQlkaWZmLmdyZWVuID0NCj4gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYuZ3Jl
ZW4sIDEwKTsNCj4gKwkJCQlkaWZmLmdyZWVuID0NCj4gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRp
ZmYuZ3JlZW4sIGx1dF9iaXRzKTsNCj4gIA0KPiAgCQkJCWRpZmYuYmx1ZSA9IGx1dFtuXS5ibHVl
IC0gbHV0W24gLQ0KPiAxXS5ibHVlOw0KPiAtCQkJCWRpZmYuYmx1ZSA9DQo+IGRybV9jb2xvcl9s
dXRfZXh0cmFjdChkaWZmLmJsdWUsIDEwKTsNCj4gLQ0KPiAtCQkJCXdvcmQgPQ0KPiBGSUVMRF9Q
UkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX1IsIGRpZmYucmVkKTsNCj4gLQkJCQl3b3JkIHw9DQo+
IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfRywgZGlmZi5ncmVlbik7DQo+IC0JCQkJ
d29yZCB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0IsIGRpZmYuYmx1ZSk7
DQo+ICsJCQkJZGlmZi5ibHVlID0NCj4gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYuYmx1ZSwg
bHV0X2JpdHMpOw0KPiArDQo+ICsJCQkJaWYgKGx1dF9iaXRzID09IDEyKSB7DQo+ICsJCQkJCXdv
cmRbMF0gPQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEyQklUX1IsIGRpZmYucmVkKTsN
Cj4gKwkJCQkJd29yZFswXSB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEyQklUX0cs
IGRpZmYuZ3JlZW4pOw0KPiArCQkJCQl3b3JkWzFdID0NCj4gRklFTERfUFJFUChESVNQX0dBTU1B
X0xVVF8xMkJJVF9CLCBkaWZmLmJsdWUpOw0KPiArCQkJCX0gZWxzZSB7DQo+ICsJCQkJCXdvcmRb
MF0gPQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX1IsIGRpZmYucmVkKTsNCj4g
KwkJCQkJd29yZFswXSB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0csIGRp
ZmYuZ3JlZW4pOw0KPiArCQkJCQl3b3JkWzBdIHw9DQo+IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9M
VVRfMTBCSVRfQiwgZGlmZi5ibHVlKTsNCj4gKwkJCQl9DQo+ICAJCQl9DQo+IC0JCQl3cml0ZWwo
d29yZCwgbHV0X2Jhc2UgKyBpICogNCk7DQo+ICsJCQl3cml0ZWwod29yZFswXSwgbHV0MF9iYXNl
ICsgaSAqIDQpOw0KPiArCQkJaWYgKGx1dF9iaXRzID09IDEyKQ0KPiArCQkJCXdyaXRlbCh3b3Jk
WzFdLCBsdXQxX2Jhc2UgKyBpICogNCk7DQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gQEAgLTIyNSwx
MSArMjY4LDEzIEBAIHN0YXRpYyB2b2lkIG10a19kaXNwX2dhbW1hX3JlbW92ZShzdHJ1Y3QNCj4g
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9n
YW1tYV9kYXRhIG10ODE3M19nYW1tYV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuaGFzX2RpdGhlciA9
IHRydWUsDQo+ICAJLmx1dF9iYW5rX3NpemUgPSA1MTIsDQo+ICsJLmx1dF9iaXRzID0gMTAsDQo+
ICAJLmx1dF9zaXplID0gNTEyLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZGlzcF9nYW1tYV9kYXRhIG10ODE4M19nYW1tYV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkubHV0
X2Jhbmtfc2l6ZSA9IDUxMiwNCj4gKwkubHV0X2JpdHMgPSAxMCwNCj4gIAkubHV0X2RpZmYgPSB0
cnVlLA0KPiAgCS5sdXRfc2l6ZSA9IDUxMiwNCj4gIH07DQo=
