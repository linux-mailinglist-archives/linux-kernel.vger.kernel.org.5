Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8929C7CBE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjJQJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjJQJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:01:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEC8E;
        Tue, 17 Oct 2023 02:01:18 -0700 (PDT)
X-UUID: b035ba786ccb11ee8051498923ad61e6-20231017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Uj41C0g3l4TqsERPsmgTbSdsATS12hNb59xpPQ8R/CQ=;
        b=oVpDFvepghuAwjgo8ag49b+bvMJAFmAyLYyk0nhdEiE5YvNKlDWrWqoIW7XxxAf/mPSExHzkvAyPel7YHxV6i7NEiEtI0VGJqjHu3x1Fr/2pPCDdREiN2KcYRoBbvzZo2R01xp4ZvsZzwXLQNwdwsvWpBBEZkESbj2+HGk6TTDc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:fdb46a7a-17d5-46df-a0e7-1c0dc31b2403,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:259738c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b035ba786ccb11ee8051498923ad61e6-20231017
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 733038210; Tue, 17 Oct 2023 17:00:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Oct 2023 17:00:57 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Oct 2023 17:00:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6JElZufVWcNWtDBUTbyCvGY/Ye150M+xjEVPjVF/H/vRy7dyibXDgF05qUaN5XS/WOgcFXrQdRhMv3c9zYBGbMbKlOOl9bK9rVjT43ONaFtW2jEPbqB6NHZOK4nlScEy0dQ2QkQCIHu6UEzY5x7RhLWZYu7jOfKPholHRUcAeO0JhfeJzWx8tuCpdbvzOIQdqHmY1ukJo5H5DvFwfglUEkH+7qar/+b/DR7TQN7L9lkjzjLpnb4AkrJROT3d6oYeKlZgDxnBOdHaqNqJHPiDeZ6DcZ9BH2deQ31t+3Z2K2OtJBBXsGUl3bg/C36KsgKFuVHqWAmH0QVUJrekojV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj41C0g3l4TqsERPsmgTbSdsATS12hNb59xpPQ8R/CQ=;
 b=hEgwagVU8TU5pjoTCuyqmWwWz3wWiyWt+L1HI8toMdFL/Ozjf9r5q1LR53493kqHwtuIC71C284YTROmC88CAG/TXQ7nQcMstZHu+ACCRwqIXfI7iqtG0d5H4CAHnFrSZpygjLYmbmsF2ebORdh20SjmJWL82nEA2B1xpFTfrE7Lg5UkL6yc4TQ+Htghfj6C6CJFZ0aD4aQntcNcz3bI7JxpYGIX6XgXAcI+xT+iexHnYWBBd8dJ1WK8L2/PlLJQQNiOodX16o4wEWwBrAV0ZBmKVgW8AmITQk/Mxd/2x23bwmFdle0Ja5iPbvlltGiNPgUr/Mf3g3i6u/WRbZ96pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj41C0g3l4TqsERPsmgTbSdsATS12hNb59xpPQ8R/CQ=;
 b=JtZd0czfcO/A7dOK1MVc8dxhIB4uMUdqOSdPh5oTp3QmsZSFzH/xGzgbshhU0JGiDjvuzENpY20BYt/vQ7KLWkeCSkLmO2N7qwQcENWvaDx23HFoT+UMF7Ae2o7ctHqOPnNBzpVOJKolIHD5aRSuWK+FSyPJ6GuQhgv6vVALfbM=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by JH0PR03MB7633.apcprd03.prod.outlook.com (2603:1096:990:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 09:00:54 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::2af0:27:71c5:dd5c]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::2af0:27:71c5:dd5c%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 09:00:53 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH v4 4/4] arm64: dts: Add MediaTek MT8188 dts and
 evaluation board and Makefile
Thread-Topic: [RESEND PATCH v4 4/4] arm64: dts: Add MediaTek MT8188 dts and
 evaluation board and Makefile
Thread-Index: AQHZ7FFalJ6zc1jmQUiVa/R6os7gALBN0e0AgAAGS4A=
Date:   Tue, 17 Oct 2023 09:00:53 +0000
Message-ID: <75daa6e9978c8cdf0a9847cf488410947ea0cd8f.camel@mediatek.com>
References: <20230921060235.32478-1-jason-ch.chen@mediatek.com>
         <20230921060235.32478-5-jason-ch.chen@mediatek.com>
         <ecd6a00f-2166-48b7-a6ae-e165a2a6d70b@collabora.com>
In-Reply-To: <ecd6a00f-2166-48b7-a6ae-e165a2a6d70b@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|JH0PR03MB7633:EE_
x-ms-office365-filtering-correlation-id: 89189518-8865-4291-ff54-08dbceef916c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ikv15g/dnORW1tu595ADFKoGtDRCeqbRCHczCBwPhScLK9xAdF2gGmzJZ1jzHWY/2PX8ehXAkwbLe/1CZZYe9bcCrXuJZx3Ii1lNMrCkbqcCmafqzRFEN6wlmHLJjgp9c7rNiQJEkInsB2m81Nm4CV5Kzjxvrt/Za/wsI/43eKLa/zxbsGnq3GJzn4YmfdaEvaPrRdybmBHW9K4WLCiYBOkMVb8m0srNZRh8cehZ77dS/9I4t/XUXmtdjAWeRTtVac+YsqJFECOYv4SvmYyr0a+BWUsa+HAp5LvVJvI8jCa6z7EkDf7LiscZrqOMemGLiV6EHQ6oUaDPzvZnVg7WNWA4Zpgb7UiPD/wyUcBiqANB8lfV/DblrtXhE5O7qazCx7CBtaXfK7ozEl6s+7nXS2ai4tPJ/X5UxaFN6x/4jIrHecroljvjheenxQj+LSK1sDuitvrAe77IgRZMbHfsYRg0c1M8mpDfiGpP0PmjynNrsbj3QwdAM0yeyW3WpEccjyOfz8Tw6mgPozqFQqmDLoqZktZ1dbzK4BbBXcvbBDP+NT+nDXZy8wL2KiQ2bkbjNIfvIu5LDY6rMI6E9isJzBNEq3wPrZkROZE/bxjzAOl8zPpQhFmv/bjU41gxZhgpW9wSABcAPXXPb+36so6ZxOQH0GAmLEnmhqxPXhF4FjU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(85182001)(86362001)(316002)(38070700005)(36756003)(4001150100001)(66476007)(54906003)(66946007)(76116006)(110136005)(91956017)(66446008)(2906002)(83380400001)(6506007)(8936002)(4326008)(2616005)(8676002)(38100700002)(26005)(66556008)(64756008)(122000001)(7416002)(6512007)(6486002)(41300700001)(53546011)(478600001)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWRja29QRnZHM05aRUhYZmwzK1cyRFlIRFZiUjBhQVg5RXRpbDk4NUI1R2w4?=
 =?utf-8?B?aWdIdFgyUDFMZjhkaWRVUXdHU0kzMTlUbXNyVzF6UVVPdlZSWGk3SGZ6Z09j?=
 =?utf-8?B?RjFqUGVIUS95OHdLZEwwYlFhcFBYdDBZK3UzUXhISzRucjM1S3NhdUMxVmlq?=
 =?utf-8?B?Y3NtWHA1enhLaWxNY2FyUmZqVnE4NnY4MVg1eDVoS3c0Rm1ncWNEb1hoWDJK?=
 =?utf-8?B?a3BpZGh3bVBVcERJZ3M4VHJjaHd3c2xtdG1PZGtvbFdLd1ZYQlp6dXpOVDRa?=
 =?utf-8?B?NDZXaHl5UGI1L2VNRjNXYnU5eW9YaTJGZmU0bGxodVRsbUk2Q2ZzUGV6YnE2?=
 =?utf-8?B?YlRDMnJvSVNqQVNrRWllc2g4TTkxRDVHcTR3eU4rZ0oyUkY1SUl2Mm5HMEVE?=
 =?utf-8?B?aWUvMG50d2RmVllhaXFRd25xNisxaTQ0T0R0TCtnaG9LS214SjZ4OTRjNjdz?=
 =?utf-8?B?bFdwcGgrZkY5Y3VLNUFibE8rM0RGS0txVjF3Znc0eWQxZlQ1c2NjODZDZWRt?=
 =?utf-8?B?cUZFam83TUFrZW5LMG40MEdyakxGRVRNSVBhbE41SzhtVUNyZnpYQ1I4Ykth?=
 =?utf-8?B?MlpIamFDZzNndm9Na1d2SUlSVFkxYmxpZEZQdTFFQmI4dzBkbXhDcXhFRWFX?=
 =?utf-8?B?Tmg4QUNoa0RCcWwxNlJYbnhEbzdQVUYwSDNhbkp4Ritxd096MzN2eTN6aU1W?=
 =?utf-8?B?ajA0RnNHNkwzaGg2eUNqRHpzUVJkbU1PaE5CMDhiSTFIQ2dWU2FHYmduRFRN?=
 =?utf-8?B?U0lTbFBPZ2tjTzRRK3BCeDBxVEgwTGpKeUZaRU9ZYVM5aFQxT1ZSMWJBZmVN?=
 =?utf-8?B?b0lzM3lxU2ROeWttR1NDNG5rNUROYlpCWE9TZVlrK3E4S2NKNHdBNW8xb0JQ?=
 =?utf-8?B?dVUyUmhxR3hNM04xT2RITS9ONnF2d3h3NEFCdTZncm5HM1o4cU9XVGlMY0Z3?=
 =?utf-8?B?MFk0bmlTc05mbnpRa05TSkdFMXFEbjB2S09xd2JqYjY4Zkd6L2ViazhnNGlK?=
 =?utf-8?B?YjVZSW5kaVpFbWI0SE15SjBnb01nRUhwaHpQZVFSNE9DR2ZYdjdzdllUdGpr?=
 =?utf-8?B?OVo5dTI3a051QVlJblVmWTBIaURtNWdOWFlNclVZT1ZqejNrTTJodE1zQ3Rm?=
 =?utf-8?B?YlVlNnFkdHNKbTlXSHNjbjh0RTA1c1VmMjA0U1ZJZm1WTVIvV0dsQ0l4T1hx?=
 =?utf-8?B?ekNwSmJYWUdXMEhhWEVsUktKd2N6Ky8zemxETTc3eFRPNHFiWGFuZ29wcFIx?=
 =?utf-8?B?clVaVVVrdWtRYzdFZWlQNDN2YVE5K1FxOWxCOHV3STNCMDM2eGFJVDdnbW1R?=
 =?utf-8?B?NC9EK2pJMHNXVWtXUkJPWFQxbUFpbGo1YVpCbm9DcEEvK09ycWx0a0xVbDAw?=
 =?utf-8?B?UUNJZWVCcEFMdzdMZHB5eGpKenVrRlkrOVN3U2VDVEVTM3FQaTFRbUIrY3pG?=
 =?utf-8?B?VGo1N0xZT3FIaFM1STR3NHNVZTVVamwrSHMveXQ3VzRDdS96cElTaGQ2Q1FV?=
 =?utf-8?B?ZmszRkhVSjYzbEorM3NwbUpYa3FTVU9XSm1BeVVBVDBJSWtEWVMvQXQ2Wjhm?=
 =?utf-8?B?Rkd2RXlVYldyQkphWlBzWDlxWVRMMU1qQWtTZGZWT2hqK09saEJoM2JKUlJY?=
 =?utf-8?B?UlZwSjBVOU1YN2N0eFRxcDYyU05XOEE0Z1d1aG84OHU0aWdSQ3JwNEs5dnVr?=
 =?utf-8?B?d2tKcEdHTC91QWtaMU82aHcwMjYvOUh6bHZGWEk4Ty9xZWxmM0FxL2pDL0FK?=
 =?utf-8?B?dTZtSUZlclRHS25OYVlaZERCWGlVWERhRUNrWndFV0ZmNWdGR0dBbGEzYTVh?=
 =?utf-8?B?T3gyL2ppMCtSQ08va25KdTBaQUdHQm9IMHpxaDVBdFJ3bnJYb1c5Qnl4RE1B?=
 =?utf-8?B?VldMWkxQRVJmZTVTdi9pYnFFbHY2TFM4am81aUluZzhlalR0aUpJY2NyVS9I?=
 =?utf-8?B?M21yN2k4NTA4K2JoV3pGckFjYmVNNDA5aFdxZ3lBb2JWV25lUG9KTnlTSEpl?=
 =?utf-8?B?dFZNMVY0UDlUK1I0UXdHYm5uYXhIM0MvMlVSK0Q3WHEyWnAzZ3lZZWJEcFl2?=
 =?utf-8?B?V01yeWJvVnQ2azFPWFRjRmVJTmtCVDBMZDNvUkpaY2xncldOc1NtWVZ0Tm5H?=
 =?utf-8?B?QVBTUkxWM1hDWmVSemtjTHdiSHNMTWNIUFREZDFTUW1PZjFBTDlqZWdGUmk5?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B4F4FF749D8274D9EE765BF8006E54E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89189518-8865-4291-ff54-08dbceef916c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 09:00:53.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PD33Hxw5YOWoQU/lbIinB5P26mIOH2IcQJuIR3CRRwt1uVQd1ARQPk7WhnkTQq0cLfSJLBJ5wX51YnCPZyifVamu5fLekcuLh/3MmcLF718=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7633
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXVnZW4sDQoNCk9uIFR1ZSwgMjAyMy0xMC0xNyBhdCAxMTozOCArMDMwMCwgRXVnZW4gSHJp
c3RldiB3cm90ZToNCj4gT24gOS8yMS8yMyAwOTowMiwgSmFzb24tY2ggQ2hlbiB3cm90ZToNCj4g
PiBGcm9tOiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1jaC5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAN
Cj4gPiBNVDgxODggaXMgYSBTb0MgYmFzZWQgb24gNjRiaXQgQVJNdjggYXJjaGl0ZWN0dXJlLiBJ
dCBjb250YWlucyA2DQo+ID4gQ0E1NQ0KPiA+IGFuZCAyIENBNzggY29yZXMuIE1UODE4OCBzaGFy
ZSBtYW55IEhXIElQIHdpdGggTVQ2NXh4IHNlcmllcy4NCj4gPiANCj4gPiBXZSBhZGQgYmFzaWMg
Y2hpcCBzdXBwb3J0IGZvciBNZWRpYVRlayBNVDgxODggb24gZXZhbHVhdGlvbiBib2FyZC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1jaC5DaGVuQG1lZGlh
dGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0K
PiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgfCAgIDEgKw0K
PiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODgtZXZiLmR0cyB8IDQwMCAr
KysrKysrKw0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODguZHRzaSAg
ICB8IDk1MQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQs
IDEzNTIgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg4LWV2Yi5kdHMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4OC5kdHNpDQo+ID4gDQo+IA0KPiBb
Li4uXQ0KPiANCj4gPiArCXNvYyB7DQo+ID4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4g
KwkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsN
Cj4gPiArCQlyYW5nZXM7DQo+ID4gKw0KPiA+ICsJCWdpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJA
YzAwMDAwMCB7DQo+IA0KPiBIaSBKYXNvbiwNCj4gDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTg4LmR0c2k6MzIwLjM3LTM0MS41OiBXYXJuaW5nIA0KPiAoYXZvaWRfdW5uZWNl
c3NhcnlfYWRkcl9zaXplKTogL3NvYy9pbnRlcnJ1cHQtY29udHJvbGxlckBjMDAwMDAwOiANCj4g
dW5uZWNlc3NhcnkgI2FkZHJlc3MtY2VsbHMvI3NpemUtY2VsbHMgd2l0aG91dCAicmFuZ2VzIiBv
ciBjaGlsZA0KPiAicmVnIiANCj4gcHJvcGVydHkNCj4gDQo+IA0KPiBUaGlzIHdhcm5pbmcgcG9w
cyB1cCB3aGVuIHRyeWluZyBkdGJzX2NoZWNrLg0KPiBDYW4geW91IGhhdmUgYSBsb29rIHBsZWFz
ZSA/DQoNCkkgaGF2ZSBydW4gZHRic19jaGVjayBiZWZvcmUgc2VuZGluZyBhbmQgZGlkIG5vdCBl
bmNvdW50ZXIgdGhpcw0Kd2FybmluZy4gSSB3aWxsIHBlcmZvcm0gYW5vdGhlciBjb25maXJtYXRp
b24gYmVmb3JlIHNlbmRpbmcgdGhlIG5leHQNCnZlcnNpb24uDQoNClRoYW5rIHlvdS4NCg0KPiAN
Cj4gRXVnZW4NCj4gDQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiYXJtLGdpYy12MyI7DQo+ID4gKwkJ
CSNpbnRlcnJ1cHQtY2VsbHMgPSA8ND47DQo+ID4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0K
PiA+ICsJCQkjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArCQkJI3JlZGlzdHJpYnV0b3ItcmVnaW9u
cyA9IDwxPjsNCj4gPiArCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ2ljPjsNCj4gPiArCQkJaW50
ZXJydXB0LWNvbnRyb2xsZXI7DQo+ID4gKwkJCXJlZyA9IDwwIDB4MGMwMDAwMDAgMCAweDQwMDAw
PiwNCj4gPiArCQkJICAgICAgPDAgMHgwYzA0MDAwMCAwIDB4MjAwMDAwPjsNCj4gPiArCQkJaW50
ZXJydXB0cyA9IDxHSUNfUFBJIDkgSVJRX1RZUEVfTEVWRUxfSElHSCAwPjsNCj4gPiArDQo+ID4g
KwkJCXBwaS1wYXJ0aXRpb25zIHsNCj4gPiArCQkJCXBwaV9jbHVzdGVyMDogaW50ZXJydXB0LXBh
cnRpdGlvbi0wIHsNCj4gPiArCQkJCQlhZmZpbml0eSA9IDwmY3B1MCAmY3B1MSAmY3B1Mg0KPiA+
ICZjcHUzICZjcHU0ICZjcHU1PjsNCj4gPiArCQkJCX07DQo+ID4gKw0KPiA+ICsJCQkJcHBpX2Ns
dXN0ZXIxOiBpbnRlcnJ1cHQtcGFydGl0aW9uLTEgew0KPiA+ICsJCQkJCWFmZmluaXR5ID0gPCZj
cHU2ICZjcHU3PjsNCj4gPiArCQkJCX07DQo+ID4gKwkJCX07DQo+ID4gKwkJfTsNCj4gPiArDQo+
IA0KPiBbLi4uXQ0KPiANCg0KUmVnYXJkcywNCkphc29uDQo=
