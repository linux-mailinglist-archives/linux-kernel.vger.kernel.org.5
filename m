Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A07A5B38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjISHiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjISHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:37:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6886218F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:37:39 -0700 (PDT)
X-UUID: 66d02dc256bf11ee8051498923ad61e6-20230919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=x/aFX06CAddht/Ac7PktCHQJ8dxV3y2sPDTyNCOW+ps=;
        b=f1yUSeeAuzJap4DDmZccNVmqOnBGy7VJuXdmdIpwga+QNnPnsHFErT09FnfgUXgPwJXqLr81z6LL/K/qyK6cRPcYSkyWqcBEF+x0ozLqxgcKIjxJ4bAEIjqUWr4bTlZoSQ58Ym5HMoCaSttfu9GdjyBZHblKSl4ukomaLh12YN0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:590c5650-cfe7-4e26-a5eb-e6e698b0d895,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:20e4ddef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 66d02dc256bf11ee8051498923ad61e6-20230919
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 717127907; Tue, 19 Sep 2023 15:37:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Sep 2023 15:37:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Sep 2023 15:37:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUT9zevxH4JjPGA3EWliarkqE2ZhI8yn2+/z2OfpVGIoRcPnB3rrIRm1EDssO01gvUqtkCEVe+9kyJarfWCiy/tYRpEIlNiBsTaXjYIOzii0rbn23qmmMSdyRcvvezkmpyf88jaLqME3UwZelZWk9L9gRuxHYMw5NRUezNMCt8KqVbs/FWKQNqJtLvucrn70EOsJm+VEMRSvyYNHWDxZQ+EcMiVuFp1CBCAfXPUpfvOuxDXTKhqNa63MivFk05yfvk9OmkUVykhvHjSk90d6hTks5FguqEjRjTL2EegqGQtfNLX7jmecTNPHdIavk3rg6gLQK16gBExAvGtctDfo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/aFX06CAddht/Ac7PktCHQJ8dxV3y2sPDTyNCOW+ps=;
 b=Xa5SPMEczL08UXm4lwWSLv7beFUBKsJKPIqcMfBMEQzQ/HXOl/nJsYNNYG5/v9C9j32tAdil9u22fFh2wPFiDtYQedALwUiHvCMPMw5CPHMFebvvsWxIWx4qvVuWsTCCofMN1tjvRVKIW56/dLuD2Oq/ZfPF4XCG/1wnVS/XRa/Kc/MzyhA4KDfQjNiX5ahL5D3O2MnCq1DtYiZoI8+5t0b1thRaRbifuU67uPCdEQlW8QJ4v646mbjqhbMTnWeholkt9yE8fE9crEK5ms2vs7KwcasB+rVSzdCrLtjagPEz12SoNa6qhMGV3TlBmiu0q9K3r1ta37WADWBaFYO5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/aFX06CAddht/Ac7PktCHQJ8dxV3y2sPDTyNCOW+ps=;
 b=M1tc4ZgcK5YSd/c3jbXgSG8lQ32viJLGydfBlb2q8VOGFZomj2Pta+16/MQa2Pqx7nxm9baYvN8v6QxxUkwM+1TXA3bHE3nfGfTp1k8PbBUneO6ke0br9AD9781nAAQqCrhQTiSRARuXMGaHRMEkF2af3JUCQrjpfulobyPlQbA=
Received: from KL1PR03MB7669.apcprd03.prod.outlook.com (2603:1096:820:e2::6)
 by SI2PR03MB5753.apcprd03.prod.outlook.com (2603:1096:4:153::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 07:37:30 +0000
Received: from KL1PR03MB7669.apcprd03.prod.outlook.com
 ([fe80::c210:9fde:c618:2253]) by KL1PR03MB7669.apcprd03.prod.outlook.com
 ([fe80::c210:9fde:c618:2253%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 07:37:29 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "fshao@chromium.org" <fshao@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/mediatek: Add spinlock for setting vblank event in
 atomic_begin
Thread-Topic: [PATCH] drm/mediatek: Add spinlock for setting vblank event in
 atomic_begin
Thread-Index: AQHZ1PxfxV8/BZUh3kmdQ81IuhpdUbAYkGaAgAgAqgCAAV08AA==
Date:   Tue, 19 Sep 2023 07:37:28 +0000
Message-ID: <9a7b56ec641f79fc14ecd83faff61bfed05b12a5.camel@mediatek.com>
References: <20230822132646.9811-1-jason-jh.lin@mediatek.com>
         <5a4a0d12-d16a-0836-f6c5-6e6c2f3a9097@collabora.com>
         <CAC=S1ng8033sSGNFYr1vYfYfHbdG0Dk_0xai08=uomGO-EN66A@mail.gmail.com>
In-Reply-To: <CAC=S1ng8033sSGNFYr1vYfYfHbdG0Dk_0xai08=uomGO-EN66A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7669:EE_|SI2PR03MB5753:EE_
x-ms-office365-filtering-correlation-id: 3ea3740a-22ba-4955-784c-08dbb8e346a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fcCvwT7VOSXaN0ummAdzinJvb6f9oMd4EEGWAOktJ8mHZIFMYb7oXbOCbfKorvYYILYG8x3hQBUt0l9qRjkBFOa2mxNLXZXPwwaaUMbJ0MsbuQY+N4jWVeMHaGkK4xIhq77dJ64BFzZOIgr4aoQ3Bj52UEFi16utYQRlukE2LAHYqkGxVwRTvu2stzxr/FJJAyTzCCXL/JBgyExqPFtAWTA/VioGGFXShw2+wZXsvi7bN6WuxWCjEGUgtBafl7pOahl6bv7PDWDT0CJh6zSy3oygFpZYZOKIGSslSanK00hbGBzR5TgdFnbPAo570N3Tl1/vSsVGmbK+vDfB6CE+bDri5z+aJ33QNspCTMExJblvo6ehWOvVCAIPklmFnWi/u64nL500yNkc1bHWtRlPaUKEA8fm99961fuHWAVIPh/KVkj+aoFrMqRIViIU+izv0cyn2j+7tnt2c4mylM5n3vYN8lmeTBGeumA4dN0wW84+DX6hgA5fZUhgNzaRH4uagK9cEOyt9K0L18vJlPlAdvKxInKJb5QV4JTGo7p/qPe46JErnXYlIcJXkXKLrhfiXI2b3B7ulL1odrnzksDJr5VerRTJyiGdYIAKJJGqVm0kOnY4v6xE0pq3d4HpXbdzNwqcSDdzR2PDqMlZLhQvSKY7DTn0kdx3qLs49lKrPu0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7669.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(186009)(1800799009)(451199024)(53546011)(6512007)(6506007)(6486002)(71200400001)(36756003)(122000001)(83380400001)(86362001)(38070700005)(38100700002)(85182001)(2616005)(26005)(76116006)(110136005)(91956017)(66476007)(316002)(66946007)(66556008)(54906003)(64756008)(41300700001)(66446008)(2906002)(5660300002)(8676002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXNwT3VKSzdqb3A0bkFkN1pFR09lamt6RWxYVklTZm1jUjFrTmdzeThScUtr?=
 =?utf-8?B?a2ZKeWo1UC9BNTJkcjRiL05zNytvajJJbkhGRnREY0kzOEZsUG9TT1JzY2pT?=
 =?utf-8?B?KytEYTdZTXBtc1JNRE4zWHV3YVdDQ09NdDdiVXEvY25QQkI3TFMxNGdPYUEv?=
 =?utf-8?B?RDdEdjdZbGFyTzBTbVFGNDViaHkxVHF5VVFFbnFJZzdRZFVvY3VUMDN4UmIz?=
 =?utf-8?B?QWQrSlJZeEtaRVJFQmpmS3MzcHExS05kdDFYUFFrZUVzdkdBOHdQMkFwZ3A5?=
 =?utf-8?B?WEtQbzJRMDdML2VXNmVYYU1RMmJjU0JqNExKR2g2QzQ4NXB2UlFSUFdxNE9o?=
 =?utf-8?B?YWZxd0tzRUIzL0wrMW1BR2VUQTI3NHU2cVhYOHQ3WXFESE9YS09YS281VXhL?=
 =?utf-8?B?RGpqMjdZUkN2Mkw1VjlubWhNQnVQVHRjZ1BWeXE0UE4xRHI0ZGloNmUrNHVQ?=
 =?utf-8?B?T1ZGUHFkRGtKWXJNYjQveXBUdkJMM2lLaHRqYUErUEdMTlg1aGtoQmVHcjBX?=
 =?utf-8?B?ZS9DQzFyNFhLb0p2YU1kNEs2T1ExbTZGR2lzdC9VVXlzLzhqTEhycnpSSCtY?=
 =?utf-8?B?VmlXNTgwN1k3ZlVxemtsYW5DSEJVbXROSnUxZG1SMFkwdGNUd0tqamZNd3Zm?=
 =?utf-8?B?b0RWc2tUcFhON0szaWdMbncrTFcxWlA3N1VwRmN0anpzeTUxY2FuVm5CRlN1?=
 =?utf-8?B?K1N2Vkt0Z0IrS05zRE1HZzk5STViRkNpcFRBc1BqcERxeVdOdm16ZDNyWmRq?=
 =?utf-8?B?MDVIVENYN3QxY21Md0loWk9pMzlYSHk3L0ZIMUN1czh4VWtNSktMRXIwcVZp?=
 =?utf-8?B?bUJudWZ6UktudUxQeFFYd1BjMXltYllLeVNwU0I2VUZEZzBCM0V5R0VaK0lI?=
 =?utf-8?B?aU5CemhNeE9PQ2hkQ00vSFdNWGhzb09mSmxUVndyZGJ6TnNjL3pveHArcnY2?=
 =?utf-8?B?N2tlZEVSbm5mZmVja1NCM3FlVkFPWmJRTjhXTEpkK1JxSEpFNjBPcEt3ZGZv?=
 =?utf-8?B?aHlOWXMrTFBsa1pRZy9wcFVudmQrL1hsZzcxdmZqanAyRW9CQnE3emhWYm9R?=
 =?utf-8?B?NDB6VlovSzlkRXRaRjVjNUVuRVdnejg4WE5CeHp0aFZLT1hzckhCTjZmRnVk?=
 =?utf-8?B?ck1kQklhQk5sSmpXejZPV1loaFBXcDY3bTlKeE83ZnBoZnV3eEdUaVFZTnVG?=
 =?utf-8?B?RFVEL3dVMlFsdEtHVzRQbkxwb3hpVEtPdkJpeC9HRTB1YTFabWdNVEpwcG1j?=
 =?utf-8?B?TnNoNTdZWFM1ZUY2RGd4L2hkZm9MaVplb0ZQdVZidkJ0Rk5YK21ZUm9yZURj?=
 =?utf-8?B?V1RJN3RydlliQ2hMZ0lheEZLNDhBdm1jYVlkbldTaUxuLzFJQWVFdUNvcDlI?=
 =?utf-8?B?Q3VSLzZCZWZ4eCtDRHlDejNTSFVuVWxJSTJ5a2UxeHNSZzVKU0tUMU9yOTVj?=
 =?utf-8?B?cUV0UFBVK0NJaHVEMWVmQmtrZmo3bG45ZzFqWlpkYW5PVDNvaDYzQzlsNDN5?=
 =?utf-8?B?N01qRG84SEdnWHQxNHRqTzJBZlVpTzFQWmZRY0tiOVdCVmVJZlNDRGttZ056?=
 =?utf-8?B?aDRYeExZSkwzekxwV0VtaGx2QmhySUpsUXRwbVpZS05KTytCWE9taEJTM3U3?=
 =?utf-8?B?NUZYcmI3S0NRbmxsYlhVUEZ3d1FZemExeU5XOHdQZjJnajVFMitXNTc5dlJh?=
 =?utf-8?B?SExpM3R0ZThOZE80TWdlR05GaXhUQ2tDQmVFVktwc0VpaFR1VDBUajNINGlq?=
 =?utf-8?B?SnFsSzNXSUFjUmVpRG1hNTJjc29SZWxud2RrWFVDNlJtWDFRT2lGVHdTY3FY?=
 =?utf-8?B?Y3VMYm4yNjRrWURiNVFMUVhBa1VGemU1V0s0NVhyb252T0xTUzUyS3U0NzZq?=
 =?utf-8?B?ZGw4cGlwUlR2UnYxRlB5cm5JYjZ6bkthT1lFTS9PSENWKy8yOHRRRCtRUnpj?=
 =?utf-8?B?TVRONi9HTW9URnNWQldsQURxOVBnazJRR29QZXYra1ExTmtHNk9GRzIwVDhk?=
 =?utf-8?B?Q0FjdjJKU2Npa1N6NUZ3K2xCVG8yWUFFZlhxRzk4QnkxWU1LMG1IS2Q4ak9X?=
 =?utf-8?B?L0YzRFJHbE1INGg4RDFrY285eVQ2MU5XRVZ2dkdVMzdrNkhyME5ldHl1Q3Ju?=
 =?utf-8?B?TjFTTkFRWWVlTU44ajZCQkxmNWFSQVVDQXRLQ1lJV2dwM2ZpSjN0c0pVZXVi?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1E5C2FF30ED7C43AA1A067FD12596D3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7669.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea3740a-22ba-4955-784c-08dbb8e346a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:37:28.4875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +B7jtUpXUF0MjEzZ1Odr0gPZJ2EewkJ6YKGFaYpusCQBrGSLj2ur+Vn/tnRvipcAL6ViJjcLNErahsrPmrKYvTEmIMzVv00GIYzLyp+AN0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5753
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--37.012200-8.000000
X-TMASE-MatchedRID: qsaWi0FWcYuQ4R94VvPFueYAh37ZsBDCA9UhA/EMrwNV1lQ/Hn0TOskU
        hKWc+gwPyGJ1SiZNgOOsXAiB6VK48AbbLE2rYg/9wvqOGBrge3skYouZhPZl5lPWpfvgNzrm4U5
        fw1tgyF5XnKguhI6seKFhcHRcvXnaC9YpJ/fXjNdCxKB9Mp7mVVpq//Jp4zBuQqGClHCq678rfc
        YgIq43/4nn9W1yuBoqEqqN2VH6x4eQqMvYg6LYsLiMC5wdwKqdQKuv8uQBDjrRUbnWFKhwyHhEd
        muwBgpiJX3CLvrOxwLflRAgUhoe3zlcyhHfhEXKY6Gjtu6/t32yiNuZzgQ4vHc925yOJXmFB+hH
        BMtDxUioiiN2IVM4S8dnz6O/QLNgDHlMveoJOAQCg1rav4R3DVg3VqSTJ7SoWyDPHQGazmDNNqG
        L1kALUxvl6IbwiTw/wGxAFFE8FQDhez6tE6KL5rdQIb8hCnY+YpovC7zX5q9X4w68ZFbuYnx5Wx
        RUVnTcULd14sEtBkG+SPGKY6mFSKgZpBOIU5sDEhGH3CRdKUUsCc2iFTIxrTRCaZSKE/OsXRxSZ
        VQRJCvIOsAWWn6A1C4uTX25THJ4wQSURGcMkcI2WQDmLqSM2lo0Sa3mjlr+myiLZetSf8n5kvmj
        69FXvKEwgORH8p/AjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--37.012200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D673CEBD8A7E346009011620F4B1DA40AAF01EFA7F3876790F21025E97BE1F7A2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCkhpIEZlaSwNCg0KVGhhbmtz
IGZvciB0aGUgdGVzdGluZy4NCg0KT24gTW9uLCAyMDIzLTA5LTE4IGF0IDE4OjQ3ICswODAwLCBG
ZWkgU2hhbyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBIaSBBbmdlbG8sDQo+IA0KPiBPbiBXZWQs
IFNlcCAxMywgMjAyMyBhdCA0OjM14oCvUE0gQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4g
PGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBJbCAyMi8wOC8yMyAxNToyNiwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gPiBBZGQg
c3BpbmxvY2sgcHJvdGVjdGlvbiB0byBhdm9pZCByYWNlIGNvbmRpdGlvbiBvbiB2YmxhbmsgZXZl
bnQNCj4gPiA+IGJldHdlZW4gbXRrX2RybV9jcnRjX2F0b21pY19iZWdpbigpIGFuZA0KPiBtdGtf
ZHJtX2ZpbmlzaF9wYWdlX2ZsaXAoKS4NCj4gPiA+DQo+ID4NCj4gPiBIZWxsbyBKYXNvbiwNCj4g
Pg0KPiA+IENhbiB5b3UgcGxlYXNlIHByb3ZpZGUgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB0aGlz
IHJhY2UgY29uZGl0aW9uPw0KPiA+IChjaGVjayBiZWxvdykNCj4gPg0KPiA+ID4gRml4ZXM6IDEx
OWY1MTczNjI4YSAoImRybS9tZWRpYXRlazogQWRkIERSTSBEcml2ZXIgZm9yIE1lZGlhdGVrDQo+
IFNvQyBNVDgxNzMuIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24t
amgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgfCA1ICsrKysrDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jDQo+ID4gPiBpbmRleCBkNDAxNDI4NDJmODUuLjEyOGE2NzJmZTNjOSAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMu
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+
ID4gPiBAQCAtNzQ2LDYgKzc0Niw5IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19hdG9taWNf
YmVnaW4oc3RydWN0DQo+IGRybV9jcnRjICpjcnRjLA0KPiA+DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAg
ICAgIGNydGMpOw0KPiA+ID4gICAgICAgc3RydWN0IG10a19jcnRjX3N0YXRlICptdGtfY3J0Y19z
dGF0ZSA9DQo+IHRvX210a19jcnRjX3N0YXRlKGNydGNfc3RhdGUpOw0KPiA+ID4gICAgICAgc3Ry
dWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMgPSB0b19tdGtfY3J0YyhjcnRjKTsNCj4gPiA+ICsg
ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPiArDQo+ID4gPiArICAgICBzcGluX2xvY2tf
aXJxc2F2ZSgmY3J0Yy0+ZGV2LT5ldmVudF9sb2NrLCBmbGFncyk7DQo+ID4gPg0KPiA+ID4gICAg
ICAgaWYgKG10a19jcnRjLT5ldmVudCAmJiBtdGtfY3J0Y19zdGF0ZS0+YmFzZS5ldmVudCkNCj4g
PiA+ICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJuZXcgZXZlbnQgd2hpbGUgdGhlcmUgaXMgc3Rp
bGwgYSBwZW5kaW5nDQo+IGV2ZW50XG4iKTsNCj4gPiA+IEBAIC03NTYsNiArNzU5LDggQEAgc3Rh
dGljIHZvaWQgbXRrX2RybV9jcnRjX2F0b21pY19iZWdpbihzdHJ1Y3QNCj4gZHJtX2NydGMgKmNy
dGMsDQo+ID4NCj4gPiAuLi5iZWNhdXNlIG15IHN1c3BlY3QgaXMgdGhhdCB3aGF0IGNyZWF0ZXMg
dGhlIHJhY2UgY29uZGl0aW9uIGluDQo+IHRoaXMgZnVuY3Rpb24gaXMNCj4gPiB0aGUgdW5sb2Nr
ZWQgKmFzc2lnbm1lbnQqIHRvIG10a19jcnRjLT5ldmVudCwgbm90IHRoZSByZXN0Lg0KPiA+DQo+
ID4gSWYgSSdtIHJpZ2h0LCB5b3UgZG9uJ3QgbmVlZCB0byB1bmNvbmRpdGlvbmFsbHkgc3Bpbmxv
Y2sgYXQgdGhlDQo+IGJlZ2lubmluZyBvZiB0aGlzDQo+ID4gZnVuY3Rpb24gaGVuY2UgZXZlci1z
by1zbGlnaHRseSBpbXByb3ZpbmcgcGVyZm9ybWFuY2UgY29tcGFyZWQgdG8NCj4gdGhpcyB2ZXJz
aW9uLg0KPiA+DQo+ID4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRoaXMgb25lIGFuZCBjaGVjayBpZiB0
aGlzICphbHNvKiBzb2x2ZXMgdGhlDQo+IGlzc3VlPw0KPiA+DQo+ID4gICAgICAgICBpZiAobXRr
X2NydGNfc3RhdGUtPmJhc2UuZXZlbnQpIHsNCj4gPiAgICAgICAgICAgICAgICAgbXRrX2NydGNf
c3RhdGUtPmJhc2UuZXZlbnQtPnBpcGUgPQ0KPiBkcm1fY3J0Y19pbmRleChjcnRjKTsNCj4gPiAg
ICAgICAgICAgICAgICAgV0FSTl9PTihkcm1fY3J0Y192YmxhbmtfZ2V0KGNydGMpICE9IDApOw0K
PiA+DQo+ID4gICAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZjcnRjLT5kZXYtPmV2
ZW50X2xvY2ssIGZsYWdzKTsNCj4gPiAgICAgICAgICAgICAgICAgbXRrX2NydGMtPmV2ZW50ID0g
bXRrX2NydGNfc3RhdGUtPmJhc2UuZXZlbnQ7DQo+ID4gICAgICAgICAgICAgICAgIHNwaW5fbG9j
a19pcnFyZXN0b3JlKCZjcnRjLT5kZXYtPmV2ZW50X2xvY2ssDQo+IGZsYWdzKTsNCj4gPg0KPiA+
ICAgICAgICAgICAgICAgICBtdGtfY3J0Y19zdGF0ZS0+YmFzZS5ldmVudCA9IE5VTEw7DQo+ID4g
ICAgICAgICB9DQo+ID4NCj4gPiBQLlMuOiBJJ2QgdHJ5IHRoYXQgbXlzZWxmLCBidXQgSSBjYW4n
dCBzZWVtIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUuDQo+IA0KSSBjYW4ndCByZXByb2R1Y2UgdGhl
IHN5c3RlbSBoYW5nIGlzc3VlIHJlcG9ydGVkIGZyb20gY3VzdG9tZXIgYnkNCnRvZ2dsaW5nIHRo
ZSBuaWdodCBsaWdodCBtb2RlIGluIFVJIHBhbmVsIGVpdGhlci4NCkJ1dCBJIGNhbiBzZWUgdGhl
IGVycm9yIG1lc3NhZ2UgIm5ldyBldmVudCB3aGlsZSB0aGVyZSBpcyBzdGlsbCBhDQpwZW5kaW5n
IGV2ZW50IiB3aGVuIEkgd2FzIHJlcHJvZHVjaW5nIHRoZSBpc3N1ZS4NCg0KSGVyZSBpcyB0aGUg
ZGVidWcgaW5mbyBmcm9tICJXZWktU2h1biA8d2Vpc2h1bmNAZ29vZ2xlLmNvbT4iOg0KDQpGcm9t
IHRoZSBrZXJuZWwgdHJhY2luZzoNCjk5MzQyLjM3NzE3MzogbXRrX2NydGNfZGRwX2lycSA8LW10
a19kaXNwX292bF9pcnFfaGFuZGxlcg0KOTkzNDIuMzc3MjI2Og0KZHJtX2NydGNfc2VuZF92Ymxh
bmtfZXZlbnQgPC1tdGtfY3J0Y19kZHBfaXJxDQo5OTM0Mi4zOTM4MzE6DQptdGtfY3J0Y19kZHBf
aXJxIDwtbXRrX2Rpc3Bfb3ZsX2lycV9oYW5kbGVyDQo5OTM0Mi4zOTM4ODc6DQpkcm1fY3J0Y19z
ZW5kX3ZibGFua19ldmVudCA8LW10a19jcnRjX2RkcF9pcnENCjk5MzQyLjQxMDQ2OToNCm10a19j
cnRjX2RkcF9pcnEgPC1tdGtfZGlzcF9vdmxfaXJxX2hhbmRsZXINCjk5MzQyLjQxMDUxOToNCmRy
bV9jcnRjX3NlbmRfdmJsYW5rX2V2ZW50IDwtbXRrX2NydGNfZGRwX2lycQ0KOTkzNDIuNDI3MDk0
Og0KbXRrX2NydGNfZGRwX2lycSA8LW10a19kaXNwX292bF9pcnFfaGFuZGxlcg0KOTkzNDIuNDQz
ODMxOg0KbXRrX2NydGNfZGRwX2lycSA8LW10a19kaXNwX292bF9pcnFfaGFuZGxlcg0KOTkzNDIu
NDYwNDk1Og0KbXRrX2NydGNfZGRwX2lycSA8LW10a19kaXNwX292bF9pcnFfaGFuZGxlcg0KOTkz
NDIuNDc3MTU3Og0KbXRrX2NydGNfZGRwX2lycSA8LW10a19kaXNwX292bF9pcnFfaGFuZGxlcg0K
OTkzNDIuNDkzODQxOg0KbXRrX2NydGNfZGRwX2lycSA8LW10a19kaXNwX292bF9pcnFfaGFuZGxl
cg0KOTkzNDIuNTEwNDUzOg0KbXRrX2NydGNfZGRwX2lycSA8LW10a19kaXNwX292bF9pcnFfaGFu
ZGxlcg0KDQpFdmVyeSBtdGtfY3J0Y19kZHBfaXJxIHNob3VsZCBjb21lIHdpdGggYSBkcm1fY3J0
Y19zZW5kX3ZibGFua19ldmVudC4NCkhvd2V2ZXIsIHdoZW4gdGhlIGlzc3VlIGhhcHBlbnMsIHRo
ZSBtdGtfY3J0Y19kZHBfaXJxIGtlZXBzIGZpcmluZyBidXQNCm5vIGRybV9jcnRjX3NlbmRfdmJs
YW5rX2V2ZW50LiBJIHN1c3BlY3QgdGhpcyBpcyB0aGUgbWFpbiByZWFzb24NCmNhdXNpbmcgZmxp
cF9kb25lIHRpbWVvdXQuDQoNCkluIG10a19kcm1fY3J0Yy5jLCBtdGtfY3J0Yy0+Y29uZmlnX3Vw
ZGF0aW5nIGFuZCBtdGtfY3J0Yy0NCj5wZW5kaW5nX25lZWRzX3ZibGFuayBhcmUgdGhlIGNvbmRp
dGlvbnMgdGhhdCBtYXkgaW1wYWN0IHRoZSB2YmxhbmsNCmV2ZW50Lg0KDQpzdGF0aWMgdm9pZCBt
dGtfZHJtX2ZpbmlzaF9wYWdlX2ZsaXAoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQp7
DQogICAgc3RydWN0IGRybV9jcnRjICpjcnRjID0gJm10a19jcnRjLT5iYXNlOw0KICAgIHVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQoNCiAgICBkcm1fY3J0Y19oYW5kbGVfdmJsYW5rKCZtdGtfY3J0Yy0+
YmFzZSk7DQoNCiAgICBzcGluX2xvY2tfaXJxc2F2ZSgmY3J0Yy0+ZGV2LT5ldmVudF9sb2NrLCBm
bGFncyk7DQo9PT4gaWYgKCFtdGtfY3J0Yy0+Y29uZmlnX3VwZGF0aW5nICYmIG10a19jcnRjLT5w
ZW5kaW5nX25lZWRzX3ZibGFuaykgew0KICAgICAgICAgbXRrX2RybV9jcnRjX2ZpbmlzaF9wYWdl
X2ZsaXAobXRrX2NydGMpOw0KICAgICAgICAgbXRrX2NydGMtPnBlbmRpbmdfbmVlZHNfdmJsYW5r
ID0gZmFsc2U7DQogICAgfQ0KICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNydGMtPmRldi0+
ZXZlbnRfbG9jaywgZmxhZ3MpOw0KfQ0KDQoNClRoZXJlIGFyZSAzIGxpbmVzIGFyZSBjYWxsZWQg
aW4gbXRrX2RybV9jcnRjX2ZpbmlzaF9wYWdlX2ZsaXAoKToNCmRybV9jcnRjX3NlbmRfdmJsYW5r
X2V2ZW50KGNydGMsIG10a19jcnRjLT5ldmVudCk7DQpkcm1fY3J0Y192YmxhbmtfcHV0KGNydGMp
Ow0KbXRrX2NydGMtPmV2ZW50ID0gTlVMTDsNCg0KU28gSSB3YW50IHRvIHByb3RlY3QgdGhlc2Ug
MyB0aGluZ3MgdG8gYXZvaWQgdGhlbSBlbmNvdW50ZXJpbmcgcmFjZQ0KY29uZGl0aW9uczoNCm10
a19jcnRjX3N0YXRlLT5iYXNlLmV2ZW50IC8vd2lsbCBiZSBwcm92aWRlZCBvbiBhdG9taWNfY29t
bWl0IGNvbXBsZXRlDQpkcm1fY3J0Y192YmxhbmtfZ2V0KGNydGMpDQptdGtfY3J0Yy0+ZXZlbnQN
Cg0KDQpJIGhhdmUgdHJpZWQgdG8gcHJvdGVjdCB0aGlzIGxpbmUgb25seToNCg0Kc3Bpbl9sb2Nr
X2lycXNhdmUoJmNydGMtPmRldi0+ZXZlbnRfbG9jaywgZmxhZ3MpOw0KbXRrX2NydGMtPmV2ZW50
ID0gbXRrX2NydGNfc3RhdGUtPmJhc2UuZXZlbnQ7DQpzcGluX2xvY2tfaXJxcmVzdG9yZSgmY3J0
Yy0+ZGV2LT5ldmVudF9sb2NrLGZsYWdzKTsNCg0KSSBjYW4gc3RpbGwgc2VlIHRoZSBlcnJvciBt
ZXNzYWdlICJuZXcgZXZlbnQgd2hpbGUgdGhlcmUgaXMgc3RpbGwgYQ0KcGVuZGluZyBldmVudCIg
d2hlbiBJIHRvZ2dsZWQgdGhlIG5pZ2h0IGxpZ2h0IG1vZGUuDQoNCk1heWJlIHRoYXQgaXMgbXRr
X2NydGMtPmV2ZW50IGhlcmU6DQppZiAobXRrX2NydGMtPmV2ZW50ICYmIG10a19jcnRjX3N0YXRl
LT5iYXNlLmV2ZW50KQ0KaGF2ZW4ndCBzZXQgdG8gTlVMTCBieSBtdGtfZHJtX2NydGNfZmluaXNo
X3BhZ2VfZmxpcCgpLg0KDQpCdXQgdGhhdCBub3QgYSBwcm9ibGVtIGJlY2F1c2Ugd2Ugd2lsbCBw
cm90ZWN0IG10a19jcnRjLT5ldmVudCBoZXJlOg0KbXRrX2NydGMtPmV2ZW50ID0gbXRrX2NydGNf
c3RhdGUtPmJhc2UuZXZlbnQ7DQoNCg0KU28gc2hvdWxkIHdlIHJlbW92ZSB0aGF0IGVycm9yIG1l
c3NhZ2Ugc2luY2UgaXQgZG9lc24ndCBoZWxwIGFuZCBtYXkNCmNhdXNlIHRoZSBjb25mdXNlIGFm
dGVyIHdlIGZpeCB0aGlzIGlzc3VlPw0KDQoNCj4gSSdtIHN0aWxsIGFibGUgdG8gcmVwcm9kdWNl
IGl0IHNvIEkgZ2F2ZSBpdCBhIHRyeSwgYW5kIHRoaXMgYXBwcm9hY2gNCj4gYWxzbyBzZWVtcyB0
byBmaXggdGhlIGlzc3VlLiAgOikNCj4gRldJVywgdGhlIHdheSBJIHJlcHJvZHVjZSB0aGF0IGlz
IHRvIHRvZ2dsZSB0aGUgbmlnaHQgbGlnaHQgbW9kZSBvbg0KPiBhbmQgb2ZmIHJlcGVhdGVkbHkg
dGhyb3VnaCB0aGUgVUkgcGFuZWwgd2hpbGUgcGxheWluZyBZb3VUdWJlIHZpZGVvcw0KPiBvbiBt
eSBkZXZpY2UuDQo+IA0KPiBKYXNvbiwgY2FuIHlvdSBwb3N0IGEgbmV3IHZlcnNpb24gd2l0aCBB
bmdlbG8ncyBzdWdnZXN0aW9uPw0KPiANCg0KT0ssIEkgY2FuIHRha2UgQW5nZWxvJ3Mgc3VnZ2Vz
dGlvbi4gVGhhbmtzIQ0KQnV0IEkgYW0gd29uZGVyaW5nIGlmIHdlIHNob3VsZCByZW1vdmUgdGhp
cyBsb2c/DQpEUk1fRVJST1IoIm5ldyBldmVudCB3aGlsZSB0aGVyZSBpcyBzdGlsbCBhIHBlbmRp
bmcgZXZlbnRcbiIpOw0KDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRzLA0K
PiBGZWkNCj4gDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IEFuZ2Vsbw0KPiA+DQo+IA0K
