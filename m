Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3976E33E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjHCIgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjHCIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:35:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831DF3ABC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:33:02 -0700 (PDT)
X-UUID: 586610b431d811eeb20a276fd37b9834-20230803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8UauAPglruVzPTeL1vqBzuPGZ4I2xYduAu/C+s80cd8=;
        b=N8iuKUirVnRV2owViv3ONZkaR9caofljvlsOTulvWpXAdQyjQ6vzqo0o/DCUkkjrs4/920SDIsnF/5VAKWWyDJctK1NFZsMrCwBtBjguuwCjIkF1qqINiXY7u2apHiWxf4KiCUsOqadE5wzCobMZpQBHXn6IAabhW8yqkHR5Ync=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:70cb4ce3-be62-44fc-be6f-a9dc42595542,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:71991ab4-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 586610b431d811eeb20a276fd37b9834-20230803
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 88224360; Thu, 03 Aug 2023 16:32:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Aug 2023 16:32:55 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Aug 2023 16:32:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpLWST64F1QNsNAk5Mln1IsBkV+rTlm/FvsB3pVMJ2I2CK7sxAY95TNOPpsTN3W68/eyHlJ8DCRnBHZbTDXtnEROao3GIfCJyf6E4SsOSCFgSGNf93/7I5qaoBlYry9o/qawo+ngjtiIFo3NUVJAT6oQfk1J73KRitaLI+/bMkTNU2rEEVvNxFEhNsGMJm95Q+TaDuDKp3iagNEMiMY49qoKpoZOGH/zWwalsPlfLm4sEKbeXAb5awmkdId85E+ipI3ICvMnIWUW8PX0fUB59dFc53Ng85+qTXBq73cQYw7uOKMoWOfL0g7iB02qEMG7gadk8yLTOSs/z6CMjSd2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UauAPglruVzPTeL1vqBzuPGZ4I2xYduAu/C+s80cd8=;
 b=dcCFsOuQBL1rmEIcplY7w0iDvaod8c6th96OeQX9TqY5ljPdFzfXFYcUMF5EZxO8FX3kfo1zOcaj8g/Tk8Sa690wDEDhuYGCUMBt1UabO+OgXyPSk9WR8jEDtG5r288h+9U9Ne+QeXgmkn4PQB4fuRimU53d4uR2NasKKwdYedYMeeOaA8ExrSSPg73Kc6hOm6LNR3DuzDft0szjG09JvgegxOcjYl5o0oCMPoEIv7YOGDjCUk+1wulMPRLgk1FVveDaddb+kt+8pWcKBkLVoY4buLaopXrTrz1Dwg4SUqViz06SquFV9QP5jQDbQcBA6Jcdkl//0h69PJVFHkWw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UauAPglruVzPTeL1vqBzuPGZ4I2xYduAu/C+s80cd8=;
 b=NkRGhW94kJWcI/V9ULEnqCj7UyCTMuu+MdyTf9bfEHcQXQXyqIq+8Sh0EM9cSP6uc1Uwg29MMCz/8Yq8bFm352wQo6RentXaMgp1OBssubT8eof0AMr5I3B2/h1JhRQrcklWiOJh7aqh2lOwmhe+tTckKgLdXJCVX9TkvUqx38M=
Received: from SEZPR03MB7616.apcprd03.prod.outlook.com (2603:1096:101:123::9)
 by SEZPR03MB7375.apcprd03.prod.outlook.com (2603:1096:101:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 08:32:52 +0000
Received: from SEZPR03MB7616.apcprd03.prod.outlook.com
 ([fe80::2310:62b8:e345:dae4]) by SEZPR03MB7616.apcprd03.prod.outlook.com
 ([fe80::2310:62b8:e345:dae4%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 08:32:52 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "fshao@chromium.org" <fshao@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] drm/mediatek: fix uninitialized symbol
Thread-Topic: [PATCH v2] drm/mediatek: fix uninitialized symbol
Thread-Index: AQHZc/dVWUY2pJ1cl0a+Yt4DL3ZbCa+5gtAAgARbdwCABPgaAIAWC96A
Date:   Thu, 3 Aug 2023 08:32:51 +0000
Message-ID: <ecedbe0bd06a67654bc90421569ad6e6bd9ddfe7.camel@mediatek.com>
References: <20230421021609.7730-1-nancy.lin@mediatek.com>
         <ae96299cffaacdbf51beae96e3a257c95a04ac95.camel@mediatek.com>
         <CAC=S1njEG2sV28XAWDw8FoQ0p5w=-sU4i+D-ESfapHMQC1ZW3Q@mail.gmail.com>
         <7e1124a15395dbb6906c17e240e5011a4274a9b5.camel@mediatek.com>
In-Reply-To: <7e1124a15395dbb6906c17e240e5011a4274a9b5.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7616:EE_|SEZPR03MB7375:EE_
x-ms-office365-filtering-correlation-id: 1035d5ca-b0ec-4523-74fb-08db93fc3a39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O32J/DTluzFoqNq/kx67DkFXIafJdFqFzP4LeRueMSniY9vDPOFy9jVQ9mbAqdEl/vUIEMsG6ChmieZjxCYsakPMDRExQIE0IFUP5LwXsqKAzJwP60TSvW82ygU8/Nf3yqFc8uokIz5dpoHjYRgFyAvtWP7k06Dxi6UtugaEpe9UnBB/c8Fqxj7oDgt8aUijLpm/u2oLtovDGQDL3+lnw8jf8AzryFFwYStICghs/oGDtlg6at9WO41+6OGoOUr/mrXlNk4b0xYbya8DXschyAX5lsz+gd0x4Rmajsz0JAzwHT6731fpcdER/asx3lOQREoxCIm1qlWGaHSAmRIQcfl2BElUwmP9qaGiun5a822m/ISM49V88aJ4UbgQJSbfRLs5UuyQJapn/dDIgJHIM1qVxVYy6evVDqly4Bcjnlbq5d5U4Kh3Fbissh+JadoF0rNgydKZ/jLtmE5aFtVlyednvjJSo6KCWv9V0q36oLZLQnVKz1Z0C4kuCH+YeK/+ihqNMWjLfwFA5pju0ptkBc6o1EAmRjP3d1DEOKaQHRQd9cFuWQmqT1Ww2dyIq5+iMBVjdLbkHjTlJpsigZmbD3mX2lqNvsEsPttkGwwJF3S5z9kkRF4Az3Py1yvD1O9xeZj6YhJlGHTVL2K1NKkUwrl+eQFM//7dM8Mr8VUGiyA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7616.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(122000001)(53546011)(6506007)(26005)(38100700002)(186003)(38070700005)(2616005)(83380400001)(2906002)(85182001)(36756003)(5660300002)(7416002)(8676002)(478600001)(110136005)(86362001)(6512007)(54906003)(71200400001)(6486002)(41300700001)(316002)(91956017)(8936002)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXQvcTYxclJPTnZieVJxVm9aRmFSbWlxSzdlSjBYR2NBK2ozL3JuZlptcmRp?=
 =?utf-8?B?YTBwakJNaTFLMWhFMzVoYXFvckxaaGcvdGh2MEhqRmh6MlZYMFFqcjZEOVpJ?=
 =?utf-8?B?cFFud3k1ZkkzM2M1WGFRL3hLaDhab01ucTNTeHlWU1BFdGtFU01oTGxXSUpN?=
 =?utf-8?B?QVNkcHp3dEgyY3Zydi9MRnBoTC9qYmNRNlVDSHBTU1lJNk5ERTg3UER3UWc5?=
 =?utf-8?B?N2EwZHlvUktUSmNENGdPc0JTNmQwVGxQZm04SVlTVUNOZzVqZ1F6VHFQZFha?=
 =?utf-8?B?OVlOTjNrclV4bTAxQWc3RTFPbGo4UjBhbnRRUVRXQ3d4eG1sbHJ5WVAyVVZt?=
 =?utf-8?B?aHhlRVN0R1Yzc2tmQ1NPd2cxc0RrTGg5Q3JrVzZ1cnhaVW0ybi92Ym1OeFVE?=
 =?utf-8?B?bVZCOE9KWUZvSGVVWEpja3VYd2JzVTIwSXcxM0hmVUtLMzAxRXQ0N2dIK2Vn?=
 =?utf-8?B?cVJ3QTNBS0trdzhsUUpCUmFlaE55N3MvczUrN1NveTJxanRTMy85bHovL2NX?=
 =?utf-8?B?N3M5S2hzMVI0WDMxa3FGemtuelVjYWZmYktnNnN5L0hwVmpudVQvSnRRcnox?=
 =?utf-8?B?a2V6T3MrMWdVTHNEeDJJNFpXYnVpZHdTRlhZWlMrN29hMGhWTkZhM2o1VFN2?=
 =?utf-8?B?dXYwWWp1UDZmbWtxenlZczJGRGs0ODVDQ09jcHhEd3ovWnNmRVVjUGl1cktw?=
 =?utf-8?B?WXBVYUw3M2NqWWNXU0VFdE1DZVBOWDI5eGhSRHVrK1cxWkszZzJLaGN1N0hX?=
 =?utf-8?B?cVpsVTlpOENkMHY0YzVzNXM2d0MxcDlpSmFDYVZLb2d4NnZvSTI1VnJxaVE5?=
 =?utf-8?B?TCtXbnR0dHh5dFUvd3pOVEVtYlBEbFdncHNEQXBKS0svb0daZG9Ccy82WFRZ?=
 =?utf-8?B?OURSaVE2VmRhRi9qNG5ETHIzL050RWdET3NHY0FWdmovQkg1dUh2bXcyYzVn?=
 =?utf-8?B?WkIzaWZRSEJvSEVGUVJRanhxbEdDamtEQU5SQUJTR0hoTUFrak13dXY4L09j?=
 =?utf-8?B?WDdlMjYzNFVPODZXOXY0aU9iL0Uvclg4RDY0aC9oZ25qVUprRURyTWgxN3V5?=
 =?utf-8?B?T3lBNEtTVGVza3JsMG50TjBQS0QyUFgyZDFxNFJsWWVZZmp1SDhoMDhHWFFP?=
 =?utf-8?B?dDA1YWFRK2ZUblR1YVlCeEdTUUE1dC9hWnlIM2p0M2FlQXNzOVZWVW9MMUtp?=
 =?utf-8?B?QUFyNUlBajJUbWxvd1lpbGQ3eHBCMlNtZXZwdWU3YTRKNFNYOFNSVWdoaTFs?=
 =?utf-8?B?VFRmaFNkR3N2Mm5NSVJUM05GTmtSMG5uZXp1NDFRSVppR284eXA4VUhET1dQ?=
 =?utf-8?B?Qmt3MkxPUHpEUkl6enlCdmRVMDFmczR1VDR4YjkxeC8xejhZSHl4ZXJxUnRv?=
 =?utf-8?B?N0Rkd1liS2FKYnVFd2d1dyszcHYxWnJoM2hUanllQkR3ZWRrUmxzdjVHMWsx?=
 =?utf-8?B?eVA0MGJwR1RUM3ZMdUViRENKTHVEckpQaS9KRi9NZWNCOXZyYVM3Q2pmZDNV?=
 =?utf-8?B?MFVESzRPNHhIVzNiYXNXV3BqTU1oNDR3ZUdNZ3RSZFhSMXp6MHhBU2VjbWgw?=
 =?utf-8?B?WjBLL2hrM1RVV0l4dmJNWHZBZ0hPVDZFdTFVTk12b1JtLyt4MW1rci8rNml1?=
 =?utf-8?B?ekQ3M2JXSmI0Nkgyd1B6REpwZCtlMDNxOWRVQVhCVE4wa2g4bTgwL29SQnVV?=
 =?utf-8?B?OGVPdzBPaHFOcnZjMmxvc0t0UGxpVFhqVk9kYWRjK2pPUzcxTDFncm5UNzBK?=
 =?utf-8?B?WG11ZmxtKzdLZ0JqanpkTTROUFBKMWVRbkQ4OVZvNTN5N0cwOEhYN0w2RG1Z?=
 =?utf-8?B?SUMzek95cmhTKytDOCtDTUx0NFNoSGJoTzJOQ05QcHBGMzFJOTAweHRMQ0ds?=
 =?utf-8?B?Tk9jTEZaUWpwMVJnUDIyNVFPUWd3SitHVXljZW8vS3JLdmhiU09FZUlXWlgz?=
 =?utf-8?B?TS9yMU5HS1VFQWQ1TFhuRmp6R0FaUFJ4d2FOYzlOaTJ4bVcxS2VPcGUrQ0da?=
 =?utf-8?B?SWdVZEZyOWdKVEVtKzB3dG54ZGhHaERrZld6V3ZvT3Z1MGhhdkQvRkluZUhm?=
 =?utf-8?B?c3lhZUF1Z0lEMWxDYWRtakxxN3pCaFdlMHdIU0NhbEUzL1ZpRzRKdmwrMjZv?=
 =?utf-8?B?MERUUXZHT2lOdkgwOEF1V3R3VnUzV2xIOGVzOFliYjNXTTdCS0FNWUxKU1kz?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFDBC3588F495C49B1B0E8ED31381835@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7616.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1035d5ca-b0ec-4523-74fb-08db93fc3a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 08:32:52.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5yQjOouypQdiItFoZeDh/nbrPOPpYC+e51DVm2HgS0EsS0cHHi5cuMEFcTSehCbhzGhjDmIqPZQ+3j9WH+bdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7375
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0sgYW5kIEZlaSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBUaHUsIDIwMjMt
MDctMjAgYXQgMDc6NTIgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiBIaSwgRmVp
Og0KPiANCj4gT24gTW9uLCAyMDIzLTA3LTE3IGF0IDExOjU5ICswODAwLCBGZWkgU2hhbyB3cm90
ZToNCj4gPiAgCSANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+IHVudGlsDQo+ID4geW91IGhhdmUgdmVyaWZpZWQg
dGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiAgSGkgQ0ssDQo+ID4gDQo+ID4gT24gRnJp
LCBKdWwgMTQsIDIwMjMgYXQgNToyN+KAr1BNIENLIEh1ICjog6Hkv4rlhYkpIDxjay5odUBtZWRp
YXRlay5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IEhpLCBOYW5jeToNCj4gPiA+IA0K
PiA+ID4gT24gRnJpLCAyMDIzLTA0LTIxIGF0IDEwOjE2ICswODAwLCBOYW5jeS5MaW4gd3JvdGU6
DQo+ID4gDQo+ID4gc25pcA0KPiA+ID4gDQo+ID4gPiBJbiBsaW5lIDU2NiwgdGhlIHN0YXRlbWVu
dCBpcw0KPiA+ID4gDQo+ID4gPiBpZiAobm9kbykgew0KPiA+ID4gICAgICAgICBjb21wX3BkZXYg
PSAuLi4NCj4gPiA+IH0NCj4gPiA+IA0KPiA+ID4gVGhlIGNvbW1lbnQgc2F5cyB0aGF0IG9ubHkg
b3ZsX2FkYXB0b2VyIGhhcyBubyBkZXZpY2Ugbm9kZSwgc28NCj4gPiA+IHRoZQ0KPiA+ID4gY2hl
Y2tpbmcgc2hvdWxkIGJlDQo+ID4gPiANCj4gPiA+IGlmICh0eXBlICE9IE1US19ESVNQX09WTF9B
REFQVE9SKSB7DQo+ID4gPiAgICAgICAgIGNvbXBfcGRldiA9IC4uLg0KPiA+ID4gfQ0KPiA+ID4g
DQo+ID4gPiBhbmQgbGF0ZXIgaXQgd291bGQgcmV0dXJuIHdoZW4gdHlwZSA9IE1US19ESVNQX09W
TF9BREFQVE9SLA0KPiA+ID4gc28gdGhlcmUgd291bGQgYmUgbm8gcHJvYmxlbSBvZiB1bmluaXRp
YWxpemVkIHN5bWJvbC4NCj4gPiANCj4gPiBUaGF0IHNvdW5kcyBmYWlyLCBidXQgSUlVQyB3aGF0
IE5hbmN5IHRyaWVzIHRvIHJlc29sdmUgaGVyZSBpcyB0aGUNCj4gPiBmYWxzZS1wb3NpdGl2ZSBT
bWF0Y2ggd2FybmluZy4NCj4gPiBIb3cgYWJvdXQgdGhpczogZ2l2ZW4gdGhlIGBpZiAobm9kZSlg
IGJsb2NrIHdhcyBleGNsdXNpdmVseSBhZGRlZA0KPiA+IGZvcg0KPiA+IG92bF9hZGFwdG9yIGlu
IFsxXSwgcGx1cyB0aGUgaW5pdCBmdW5jdGlvbiB3aWxsIGltbWVkaWF0ZWx5IHJldHVybg0KPiA+
IGFmdGVyIHRoYXQgaW4gdGhpcyBjYXNlLCBpdCBzaG91bGQgYmUgc2FmZSB0byBkbyB0aGUgZm9s
bG93aW5nDQo+ID4gDQo+ID4gYGBgDQo+ID4gLyogTm90IGFsbCBkcm0gY29tcG9uZW50cyBoYXZl
IGEgRFRTIGRldmljZSBub2RlLi4uICovDQo+ID4gaWYgKG5vZGUgPT0gTlVMTCkNCj4gPiAgICAg
cmV0dXJuIDA7DQo+ID4gDQo+ID4gY29tcF9wZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShu
b2RlKTsNCj4gPiAuLi4NCj4gPiANCj4gPiBpZiAodHlwZSA9PSBNVEtfRElTUF9BQUwgfHwNCj4g
PiAuLi4NCj4gPiBgYGANCj4gPiANCj4gPiB3aGljaCBpcyBlcXVpdmFsZW50IHRvIGFkZGluZyBh
IGBub2RlID09IE5VTExgIGNoZWNrIGJlZm9yZSBbMV0uDQo+ID4gVGhpcyBzaG91bGQgc3VwcHJl
c3MgdGhlIFNtYXRjaCB3YXJuaW5nIGJlY2F1c2UgYGNvbXBfcGRldmAgd2lsbCBiZQ0KPiA+IChh
Z2FpbikgdW5jb25kaXRpb25hbGx5IGFzc2lnbmVkIHRvIHNvbWV0aGluZywgYW5kIHRoZSBgdHlw
ZSA9PQ0KPiA+IE1US19ESVNQX09WTF9BREFQVE9SYCBsaW5lIGNhbiBiZSBkcm9wcGVkIGFsc28g
KG9wdGlvbmFsPykuDQo+IA0KPiBUaGlzIHNvbHV0aW9uIGFsc28gbG9va3MgZ29vZCB0byBtZS4N
Cj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KSSB3aWxsIHNlbmQgdGhlIG5leHQgdmVyc2lvbiBv
ZiBtb2RpZmljYXRpb25zIGJhc2VkIG9uIHlvdXINCnN1Z2dlc3Rpb25zLg0KDQpUaGFua3MsDQpO
YW5jeQ0KDQo+ID4gDQo+ID4gWzFdOiBjb21taXQgMGQ5ZWVlOTExOGI3ICgiZHJtL21lZGlhdGVr
OiBBZGQgZHJtIG92bF9hZGFwdG9yIHN1Yg0KPiA+IGRyaXZlciBmb3IgTVQ4MTk1IikNCj4gPiAN
Cj4gPiBSZWdhcmRzLA0KPiA+IEZlaQ0K
