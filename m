Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432927DDAF4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjKACYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjKACYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:24:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5743DA;
        Tue, 31 Oct 2023 19:24:35 -0700 (PDT)
X-UUID: c9dfbeae785d11eea33bb35ae8d461a2-20231101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jORAfPDKeK1Bho9lvsYHVcpmvRbIglM2bzAH+h7J/Ok=;
        b=WpuY7U6cGsACdheCHEXO8bJO69PC8BwHR4ARMAjn0upraac0D7leLlL2/IV9sbntZKecH4yi7i9nC5BLpNpHVH4sQKKQLYsMaXzVJHxDDiEqh0XXEq/cuQUiVAQ0zNYVoMNf3Mov98knvc9sScqmpQyinEdLUDkDFXmAa+cgJZA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:218ed829-aac5-498c-986f-92593ff3259a,IP:0,U
        RL:0,TC:0,Content:14,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:14
X-CID-META: VersionHash:364b77b,CLOUDID:a87dde94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c9dfbeae785d11eea33bb35ae8d461a2-20231101
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 414643021; Wed, 01 Nov 2023 10:24:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 1 Nov 2023 10:24:29 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 1 Nov 2023 10:24:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McMmQhezLTfcyoBnZDUdWCVI2sSno1Zrp1eG3HaesSZVB5E09cvXfIpBPBRwGIenCQKKpbeyDQmQzjdkVDDCZRBkKYakTpLWEZvgacjfbC1rDLx9xLZvyh5ugMY6MF9MPF8nmLPzUdRZWvsDMrVyZJ1cgg6V+JMW7EDv3fiC/zzT2FeqXdDKbc5omrQFaThCthCtFxNG+aG3aRnatRBo6OcLLIJ05MXsNEkgcTD5qjmzI7KoP/6mEU4sTo327fdPcJWnOEetRWuKwfuJrrkIjmCg+lvJphmb9xJAN+gKv1/FF4IgIEYLcKzm5L9b0fNWIMp9avMulDTH0hRAO+h4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jORAfPDKeK1Bho9lvsYHVcpmvRbIglM2bzAH+h7J/Ok=;
 b=EJHCEpJ7f4b9tiDk9h5MwxSF7+uDMmRzux1eA/2w8BmafEzT5Wy0CZFPkKXrghIFk9q80Fu29RPrr3BX7FVFMbrft1ROAaih1hCgwy9m7qRsAA/eIKH0N/1Jy/B9ggHNEimZohpBaV7vFyop4fthIqYsUoo6m7SwJ+GEQIa5/aGAkz5s6r9cHjFlqvxjJzbGSf6e+pZvSk/eK4PwYryj+bqcUXl4Z69/85TkzGky3YKBaqqVdGrc1Tab6EfaJXv6g41rbIGrntQGFRL39ndthRi/ksohbJgSlZiH/Ug+NM5wVCYtx+BM8AvJ2okMwqj1vQmfiu/I4cnMvRQtLBPH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jORAfPDKeK1Bho9lvsYHVcpmvRbIglM2bzAH+h7J/Ok=;
 b=icZ9IQQF6SvDeqVlZ0ifZciuezq/TQ2/u8h1bmYsXIflbyajO3PX2KpvEMDwBZ6YQynRMKJzBQGPKj0zJr2Rif+g6gT7V5CyLb4prLAWZVV9GLSxPtL7IfO0+rPb4kF0J1pA0ZP8SfMhThto6Z1aqx1E8YReNAxQvnZoiKCk+k4=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 TYZPR03MB5775.apcprd03.prod.outlook.com (2603:1096:400:89::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.31; Wed, 1 Nov 2023 02:23:26 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 02:23:26 +0000
From:   =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     =?utf-8?B?V2lsbCBTaGl1ICjoqLHmga3nkZwp?= <Will.Shiu@mediatek.com>,
        =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>
Subject: Re: [PATCH 1/1] block: Check the queue limit before bio submitting
Thread-Topic: [PATCH 1/1] block: Check the queue limit before bio submitting
Thread-Index: AQHaByTnzFC4rhYmWUKg+y7lOe9n1bBkxn0A
Date:   Wed, 1 Nov 2023 02:23:26 +0000
Message-ID: <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
In-Reply-To: <20231025092255.27930-1-ed.tsai@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|TYZPR03MB5775:EE_
x-ms-office365-filtering-correlation-id: bfb4c5f8-fbb3-4875-646a-08dbda8187a0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cd/QwnKVH7ljlI5Dt5pJnFZsuPYXZyuordEbMkrePgs/10C2bPLvNjOxBTrIp/FqczBHpjokPyQwTxB9QIN4w/Cs5nvHM5J2pyyPMm6bBZ8vBbCTcIpuQ4ShthFu1xhipli4md55fVQBZ/XoJlSu+qg8sjAJ5S9MikoiEXxhSXrcznuvrh9sEW00PpNu1PLsYCN+ONqODJpgOWnh/LO7EusX4RDHB7E2zx3mOSOY9KaBLSwpT6KiS2k4gqbW/u3M1qxQ5nsAeFGOhIf1BXm2DErP2vi4sIuhEnziFoEk+H2cHAzeHNJ3krE61qvocEB8jjX8YIQl+A8rlbfjshk8IaQRMcqnnGdU0nQLwSAaBdc/cUsJBTILbzVnZtXtjx9RxlWzfnsCpOtRHu7gzzho1Tqu/OD4AKlk0xoO5iz2b1Jmr9ttWLRI7a7zOr8hMTw46gYVRIeF3mQbNZZ0vBgLVxb8DEajg4LWW+3f6oal8a1QZJ9fI4PzhZlcZWlipYIq+jWKl4TLa+zY066N+O+WHcbB8Nj2+EupSnTrLUQ97s9V0RDHzMmiBe9gzStpWnGbHWiZkPHOKFI874v1sXvJpBZk4EuJY4mOCpT0c8kS0euBFYOkXshGVIYJc1d/6ccLjVwR+f7Nd3gduw0J/jup51hWURBCmcc+LxodNKJatVg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38070700009)(6512007)(26005)(38100700002)(86362001)(85182001)(36756003)(122000001)(2906002)(478600001)(83380400001)(4001150100001)(71200400001)(107886003)(6506007)(64756008)(66446008)(316002)(8676002)(6486002)(54906003)(4326008)(8936002)(2616005)(66476007)(66556008)(110136005)(41300700001)(5660300002)(66946007)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnNmOTgzbWE4Lzl2eWNETk5MR0tPb1ptcFRuc2RjOGpQZzk1NC9rR2lGeXBR?=
 =?utf-8?B?bkhCRWM5bytWeGdQT24yL1Z1R203eVBSZm5oWUZNb2NzWThUN0tTT09DRy8z?=
 =?utf-8?B?d29WY2w1eWVqeGRqaCt1TkRWbWJjNmc5czk2UjBNT25ZT0VNdlpvSTkrS0do?=
 =?utf-8?B?Q1BmZ2RqZzRqYm1sOEpRUGEzR3J6TG05NzdldExhWGR4R3NBdUl4VlhGckhx?=
 =?utf-8?B?ZEd6THZJMS9xek9VK0pWSlhGMWJKSUNvQjBZZFpXQ2hsYTFTSTA5SHNBQllr?=
 =?utf-8?B?UmV6R3FUUStMc1lVYkNvK1dFWmRYOTl5QjlLK3RrVFlaaHNLNVU5eHI1YVBa?=
 =?utf-8?B?c0EyRDJGa0VtTUxqLzZieDJxaVFZWDB6Qnh3cWVzczFtdnVFTGJCQ1pISDVa?=
 =?utf-8?B?TktzcXFpaUM3ZU1GTUx2QlpGdUdzcmsrdy9lSzRwcGM1UVNOYmtPVVNZSytZ?=
 =?utf-8?B?L2w4cU1Fblc1NkJzakxmOUpLbTdhSEN4ckRmYTNDY1BXa1ZTUmtiaGFBeTJw?=
 =?utf-8?B?Y09aT3hYYmFKUXZ4K1hIQysyRGZ3OTFieGZLczM2L2svRzdCMGFldGJYZG9p?=
 =?utf-8?B?NXh0WENGUERwTmNmOW1ia2I5cEkyL090VDkvdEtJenU1RWF6Lzg4Qnd3Sk9i?=
 =?utf-8?B?RGlOMnEyd3Z6QWZkTXZNUUlRSFJqUjh5UXpnMHA0ZkZFd3ZpUDZVUFpiUmRo?=
 =?utf-8?B?U0NuWXdKWk52SlMvQXF0NmY1QUduUGNXYjlYRGl1WC9aUU91WDU0NE9ld1ht?=
 =?utf-8?B?bGFxSm02dEtzLzJzeVhXMUVnQTNud25EeEVMdEJMZTFqZUtXdzNvQ3dHTjVv?=
 =?utf-8?B?d3dyV1JYZUhXaFBpR29GRGJIc3AxT1NPeU0xUm9zK3VaVUdrUUdlazNOZG5h?=
 =?utf-8?B?SkRpK2MrRVFwcTBWNnV2c3IyOEpTUzMwREJ1YnAzVjdXNDR6VXkzR3ZXSkt3?=
 =?utf-8?B?V0I3VkI2VXZ6K1VhRDUvcXJGeCtrdDVsWkVHRkszOTNPUDlHZGZUN0hwMnpC?=
 =?utf-8?B?S2F6aEZMZjRXcWRMdEdPSUFleGQ2RnZ1MEdpdmh5Z242M0hYZWNQWWRhb1o1?=
 =?utf-8?B?ZTdoNGE5QTRYZkxxdEUxZ0N5RHFzT3RzV2dZQ2xRNnNFZ2U2UUowSnVLL3hU?=
 =?utf-8?B?eGZWQzNMS0VYblF4WWJZb2V1NVJCQWwvY1h4MFJJZ1pEQnA3N1lNbW1nTFA3?=
 =?utf-8?B?UXJ1NGpKZ0VtdTZFcVF3T3BYNnZwSHhockpCZUFkQTE0SjB6UE85cGFtZlpD?=
 =?utf-8?B?YmtIUWpkUDZYMzdaZTA5MmpMYndDQVBFdUdWYktpVFQwWExkejVqUXZLMHVY?=
 =?utf-8?B?YTRxM0xjSmtiZGRtS3hjYnN6NWg3Ni92dGQrQ3R3LzVjWVFMVWlVbmFlRGt5?=
 =?utf-8?B?S21SUXp2MzZPdDZISmpGa3Jjb1NkMm05SjhFSHlWdy9DSDM0WGNQU2pvNWJI?=
 =?utf-8?B?TGpYK2pDY3VQL2U3TXE3V1hPQ2ZHNnp0TEFtUFhTdTJkRW5TeHFYNHMwRDFZ?=
 =?utf-8?B?T1lLZlRYWFZZdWlJcUJ4MElkVEJOTWZlcEVsRVUyQWdrUDNoTzBwSmhMNnlL?=
 =?utf-8?B?VDFrNlA0YW42YVhxOW93NzA2TDFnRzNseFVjMVZKUXdVY3JIYVJsOUp3S0Fo?=
 =?utf-8?B?WW1FY0YzdEJYTVJMMmJRNW1PZzhSOGFheDlQNVhRbGo0TkM1ZGp2ZmhlODFK?=
 =?utf-8?B?dEZYejlQTytwbzl4WTJoMk5qTnB4bnU3Sm9wb1d0MjdrVGJ6dVI3ZFZRUG5X?=
 =?utf-8?B?OHN0dDFrM2tVRWJGRC9XVElxY1BGbWhQMk1CSmhXSnJnNGIrNFdJNW5GWUEy?=
 =?utf-8?B?WDZHNUZrd1pEdUdQRGZvSjIzc3lud0VJblhpYUpHRmFkM3NmcHM3Q1d2cFc2?=
 =?utf-8?B?UjJOeldpWXVQd2w0ZmpUdGszdjQxaVcrQjcxcllmVEtpaDZaRWZDTXFZdm1L?=
 =?utf-8?B?S2NNT05LWEZIZ2RENDlhT0J5cXd4b1RnUkZvTnppMm1La0JaUGxjdERDaFk0?=
 =?utf-8?B?SHJROHNNWXE3WVlkSFpwak0vcjMydU9ra2lmN0pzUnozVGx4NDlDZmM3VkxB?=
 =?utf-8?B?bVcweGtIUzA5SFNUNWRyRjMyWGNiMGRHN2dxeTEyQnczcEszYVVFNGl2bzNI?=
 =?utf-8?B?OTRaK3BJcElmNW5wQ1pnY1laQTJqa0JvMWRWaHhmbzZ5VkFFY1o2dzBrWk1X?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED3FDEF0E32EE642BA55572688F16F35@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb4c5f8-fbb3-4875-646a-08dbda8187a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 02:23:26.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNsW/LDSmSzR7I9/ZrDpqZ2xUvN6XthFafSvs/uhxl2ogcqPyhppyZTGHhf63p6CBTZjy9GPOl6MCq3y/5tSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5775
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.028100-8.000000
X-TMASE-MatchedRID: a3sLnpBpvfTUL3YCMmnG4rhzZI/dfrdOjLOy13Cgb4+qvcIF1TcLYDQq
        rqK/M/JqBIbeFm+CMiEPO54Cyom6Kw6iz8JOSFIInu1HSadECDX6Vf9FxCgbYcnJhTYnTng9plt
        rkRvr+RONQXnllFqLb5H6sOUhKFhAhi8uFzr7cft/TWpwlAOFXtsE4j/Y3E9Eo0LZViYXld2cXK
        sopitOMaE3uI1B9uu5XgOjBlkjxG5OjNu6RY8dSxWCVBr+Ay98si3nm+6QLrzL2ewfGE+i4/lYo
        V6p/cSxI1/Ds5nW8XAEWuy9Dt5OU62IX6n70FjpV96W6JwvGvcxmbT6wQT2a3RNGrhtzGYfUKmz
        H22CobI2WmZJAyNkH/zY2JLKJyDry7mgwFdMot5K2kj7j4ouANMNeBxSUI2jh8BhJvgqWBlh4r/
        wCPzhZBEyEcHRT1oHzaWPHHSujhZ5X0FJZbmEpp4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrItRnEQ
        CUU+jzjoczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.028100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7956427A9E7F8E0531678A365CB155D2AB58632E6F391F4A5086FB122CED08872000:8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDE3OjIyICswODAwLCBlZC50c2FpQG1lZGlhdGVrLmNvbSB3
cm90ZToNCj4gRnJvbTogRWQgVHNhaSA8ZWQudHNhaUBtZWRpYXRlay5jb20+DQo+IA0KPiBSZWZl
cnJpbmcgdG8gY29tbWl0IDA3MTczYzNlYzI3NiAoImJsb2NrOiBlbmFibGUgbXVsdGlwYWdlIGJ2
ZWNzIiksDQo+IGVhY2ggYmlvX3ZlYyBub3cgaG9sZHMgbW9yZSB0aGFuIG9uZSBwYWdlLCBwb3Rl
bnRpYWxseSBleGNlZWRpbmcNCj4gMU1CIGluIHNpemUgYW5kIGNhdXNpbmcgYWxpZ25tZW50IGlz
c3VlcyB3aXRoIHRoZSBxdWV1ZSBsaW1pdC4NCj4gDQo+IEluIGEgc2VxdWVudGlhbCByZWFkL3dy
aXRlIHNjZW5hcmlvLCB0aGUgZmlsZSBzeXN0ZW0gbWF4aW1pemVzIHRoZQ0KPiBiaW8ncyBjYXBh
Y2l0eSBiZWZvcmUgc3VibWl0dGluZy4gSG93ZXZlciwgbWlzYWxpZ25tZW50IHdpdGggdGhlDQo+
IHF1ZXVlIGxpbWl0IGNhbiByZXN1bHQgaW4gdGhlIGJpbyBiZWluZyBzcGxpdCBpbnRvIHNtYWxs
ZXIgSS9PDQo+IG9wZXJhdGlvbnMuDQo+IA0KPiBGb3IgaW5zdGFuY2UsIGFzc3VtaW5nIHRoZSBt
YXhpbXVtIEkvTyBzaXplIGlzIHNldCB0byA1MTJLQiBhbmQgdGhlDQo+IG1lbW9yeSBpcyBoaWdo
bHkgZnJhZ21lbnRlZCwgcmVzdWx0aW5nIGluIGVhY2ggYmlvIGNvbnRhaW5pbmcgb25seQ0KPiBv
bmUgMi1wYWdlcyBiaW9fdmVjIChpLmUuLCBiaV9zaXplID0gMTAyOEtCKS4gVGhpcyB3b3VsZCBj
YXVzZSB0aGUNCj4gYmlvIHRvIGJlIHNwbGl0IGludG8gdHdvIDUxMktCIHBvcnRpb25zIGFuZCBv
bmUgNEtCIHBvcnRpb24uIEFzIGENCj4gcmVzdWx0LCB0aGUgb3JpZ2luYWxseSBleHBlY3RlZCBj
b250aW51b3VzIGxhcmdlIEkvTyBvcGVyYXRpb25zIGFyZQ0KPiBpbnRlcnNwZXJzZWQgd2l0aCBt
YW55IHNtYWxsIEkvTyBvcGVyYXRpb25zLg0KPiANCj4gVG8gYWRkcmVzcyB0aGlzIGlzc3VlLCB0
aGlzIHBhdGNoIGFkZHMgYSBjaGVjayBmb3IgdGhlIG1heF9zZWN0b3JzDQo+IGJlZm9yZSBzdWJt
aXR0aW5nIHRoZSBiaW8uIFRoaXMgYWxsb3dzIHRoZSB1cHBlciBsYXllcnMgdG8NCj4gcHJvYWN0
aXZlbHkNCj4gZGV0ZWN0IGFuZCBoYW5kbGUgYWxpZ25tZW50IGlzc3Vlcy4NCj4gDQo+IEkgcGVy
Zm9ybWVkIHRoZSBBbnR1dHUgVjEwIFN0b3JhZ2UgVGVzdCBvbiBhIFVGUyA0LjAgZGV2aWNlLCB3
aGljaA0KPiByZXN1bHRlZCBpbiBhIHNpZ25pZmljYW50IGltcHJvdmVtZW50IGluIHRoZSBTZXF1
ZW50aWFsIHRlc3Q6DQo+IA0KPiBTZXF1ZW50aWFsIFJlYWQgKGF2ZXJhZ2Ugb2YgNSByb3VuZHMp
Og0KPiBPcmlnaW5hbDogMzAzMy43IE1CL3NlYw0KPiBQYXRjaGVkOiAzNTIwLjkgTUIvc2VjDQo+
IA0KPiBTZXF1ZW50aWFsIFdyaXRlIChhdmVyYWdlIG9mIDUgcm91bmRzKToNCj4gT3JpZ2luYWw6
IDIyMjUuNCBNQi9zZWMNCj4gUGF0Y2hlZDogMjgwMC4zIE1CL3NlYw0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRWQgVHNhaSA8ZWQudHNhaUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgYmxvY2svYmlv
LmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jpby5jIGIvYmxvY2svYmlvLmMNCj4gaW5kZXggODE2ZDQxMmMw
NmU5Li5hNGExZjc3NWI5ZWEgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Jpby5jDQo+ICsrKyBiL2Js
b2NrL2Jpby5jDQo+IEBAIC0xMjI3LDYgKzEyMjcsNyBAQCBzdGF0aWMgaW50IF9fYmlvX2lvdl9p
dGVyX2dldF9wYWdlcyhzdHJ1Y3QgYmlvDQo+ICpiaW8sIHN0cnVjdCBpb3ZfaXRlciAqaXRlcikN
Cj4gIAlpb3ZfaXRlcl9leHRyYWN0aW9uX3QgZXh0cmFjdGlvbl9mbGFncyA9IDA7DQo+ICAJdW5z
aWduZWQgc2hvcnQgbnJfcGFnZXMgPSBiaW8tPmJpX21heF92ZWNzIC0gYmlvLT5iaV92Y250Ow0K
PiAgCXVuc2lnbmVkIHNob3J0IGVudHJpZXNfbGVmdCA9IGJpby0+YmlfbWF4X3ZlY3MgLSBiaW8t
PmJpX3ZjbnQ7DQo+ICsJc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltID0gJmJkZXZfZ2V0X3F1ZXVl
KGJpby0+YmlfYmRldiktDQo+ID5saW1pdHM7DQo+ICAJc3RydWN0IGJpb192ZWMgKmJ2ID0gYmlv
LT5iaV9pb192ZWMgKyBiaW8tPmJpX3ZjbnQ7DQo+ICAJc3RydWN0IHBhZ2UgKipwYWdlcyA9IChz
dHJ1Y3QgcGFnZSAqKilidjsNCj4gIAlzc2l6ZV90IHNpemUsIGxlZnQ7DQo+IEBAIC0xMjc1LDYg
KzEyNzYsMTEgQEAgc3RhdGljIGludCBfX2Jpb19pb3ZfaXRlcl9nZXRfcGFnZXMoc3RydWN0IGJp
bw0KPiAqYmlvLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpDQo+ICAJCXN0cnVjdCBwYWdlICpwYWdl
ID0gcGFnZXNbaV07DQo+ICANCj4gIAkJbGVuID0gbWluX3Qoc2l6ZV90LCBQQUdFX1NJWkUgLSBv
ZmZzZXQsIGxlZnQpOw0KPiArCQlpZiAoYmlvLT5iaV9pdGVyLmJpX3NpemUgKyBsZW4gPg0KPiAr
CQkgICAgbGltLT5tYXhfc2VjdG9ycyA8PCBTRUNUT1JfU0hJRlQpIHsNCj4gKwkJCXJldCA9IGxl
ZnQ7DQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiAgCQlpZiAoYmlvX29wKGJpbykgPT0gUkVRX09Q
X1pPTkVfQVBQRU5EKSB7DQo+ICAJCQlyZXQgPSBiaW9faW92X2FkZF96b25lX2FwcGVuZF9wYWdl
KGJpbywgcGFnZSwNCj4gbGVuLA0KPiAgCQkJCQlvZmZzZXQpOw0KPiAtLSANCj4gMi4xOC4wDQo+
IA0KDQoNCkhpIEplbnMsDQoNCkp1c3QgdG8gY2xhcmlmeSBhbnkgcG90ZW50aWFsIGNvbmZ1c2lv
biwgSSB3b3VsZCBsaWtlIHRvIHByb3ZpZGUNCmZ1cnRoZXIgZGV0YWlscyBiYXNlZCBvbiB0aGUg
YXNzdW1lZCBzY2VuYXJpbyBtZW50aW9uZWQgYWJvdmUuDQoNCldoZW4gdGhlIHVwcGVyIGxheWVy
IGNvbnRpbnVvdXNseSBzZW5kcyAxMDI4S0IgZnVsbC1zaXplZCBiaW9zIGZvcg0Kc2VxdWVudGlh
bCByZWFkcywgdGhlIEJsb2NrIExheWVyIHNlZXMgdGhlIGZvbGxvd2luZyBzZXF1ZW5jZToNCglz
dWJtaXQgYmlvOiBzaXplID0gMTAyOEtCLCBzdGFydCBMQkEgPSBuDQoJc3VibWl0IGJpbzogc2l6
ZSA9IDEwMjhLQiwgc3RhcnQgTEJBID0gbiArIDEwMjhLQiANCglzdWJtaXQgYmlvOiBzaXplID0g
MTAyOEtCLCBzdGFydCBMQkEgPSBuICsgMjA1NktCDQoJLi4uDQoNCkhvd2V2ZXIsIGR1ZSB0byB0
aGUgcXVldWUgbGltaXQgcmVzdHJpY3RpbmcgdGhlIEkvTyBzaXplIHRvIGEgbWF4aW11bQ0Kb2Yg
NTEyS0IsIHRoZSBCbG9jayBMYXllciBzcGxpdHMgaW50byB0aGUgZm9sbG93aW5nIHNlcXVlbmNl
Og0KCXN1Ym1pdCBiaW86IHNpemUgPSA1MTJLQiwgc3RhcnQgTEJBID0gbg0KCXN1Ym1pdCBiaW86
IHNpemUgPSA1MTJLQiwgc3RhcnQgTEJBID0gbiArICA1MTJLQg0KCXN1Ym1pdCBiaW86IHNpemUg
PSAgIDRLQiwgc3RhcnQgTEJBID0gbiArIDEwMjRLQgkNCglzdWJtaXQgYmlvOiBzaXplID0gNTEy
S0IsIHN0YXJ0IExCQSA9IG4gKyAxMDI4S0INCglzdWJtaXQgYmlvOiBzaXplID0gNTEyS0IsIHN0
YXJ0IExCQSA9IG4gKyAxNTQwS0INCglzdWJtaXQgYmlvOiBzaXplID0gICA0S0IsIHN0YXJ0IExC
QSA9IG4gKyAyMDUyS0INCglzdWJtaXQgYmlvOiBzaXplID0gNTEyS0IsIHN0YXJ0IExCQSA9IG4g
KyAyMDU2S0INCglzdWJtaXQgYmlvOiBzaXplID0gNTEyS0IsIHN0YXJ0IExCQSA9IG4gKyAyNTY4
S0INCglzdWJtaXQgYmlvOiBzaXplID0gICA0S0IsIHN0YXJ0IExCQSA9IG4gKyAzMDgwS0INCgku
Li4NCgkNClRoZSBvcmlnaW5hbCBleHBlY3RhdGlvbiB3YXMgZm9yIHRoZSBzdG9yYWdlIHRvIHJl
Y2VpdmUgbGFyZ2UsDQpjb250aWd1b3VzIHJlcXVlc3RzLiBIb3dldmVyLCBkdWUgdG8gbm9uLWFs
aWdubWVudCwgbWFueSBzbWFsbCBJL08NCnJlcXVlc3RzIGFyZSBnZW5lcmF0ZWQuIFRoaXMgcHJv
YmxlbSBpcyBlYXNpbHkgdmlzaWJsZSBiZWNhdXNlIHRoZQ0KdXNlciBwYWdlcyBwYXNzZWQgaW4g
YXJlIG9mdGVuIGFsbG9jYXRlZCBieSB0aGUgYnVkZHkgc3lzdGVtIGFzIG9yZGVyIDANCnBhZ2Vz
IGR1cmluZyBwYWdlIGZhdWx0cywgcmVzdWx0aW5nIGluIGhpZ2hseSBub24tY29udGlndW91cyBt
ZW1vcnkuDQoNCkFzIG9ic2VydmVkIGluIHRoZSBBbnR1dHUgU2VxdWVudGlhbCBSZWFkIHRlc3Qg
YmVsb3csIGl0IGlzIHNpbWlsYXIgdG8NCnRoZSBkZXNjcmlwdGlvbiBhYm92ZSB3aGVyZSB0aGUg
c3BsaXR0aW5nIGNhdXNlZCBieSB0aGUgcXVldWUgbGltaXQNCmxlYXZlcyBzbWFsbCByZXF1ZXN0
cyBzYW5kd2ljaGVkIGluIGJldHdlZW46DQoNCmJsb2NrX2Jpb19xdWV1ZTogOCwzMiBSIDg2OTI1
ODY0ICsgMjE0NCBbVGhyZWFkLTUxXQ0KYmxvY2tfc3BsaXQ6IDgsMzIgUiA4NjkyNTg2NCAvIDg2
OTI2ODg4IFtUaHJlYWQtNTFdDQpibG9ja19zcGxpdDogOCwzMiBSIDg2OTI2ODg4IC8gODY5Mjc5
MTIgW1RocmVhZC01MV0NCmJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNTI0Mjg4ICgpIDg2OTI1ODY0
ICsgMTAyNCBbVGhyZWFkLTUxXQ0KYmxvY2tfcnFfaXNzdWU6IDgsMzIgUiA1MjQyODggKCkgODY5
MjY4ODggKyAxMDI0IFtUaHJlYWQtNTFdDQpibG9ja19iaW9fcXVldWU6IDgsMzIgUiA4NjkyODAw
OCArIDIxNDQgW1RocmVhZC01MV0NCmJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MjgwMDggLyA4Njky
OTAzMiBbVGhyZWFkLTUxXQ0KYmxvY2tfc3BsaXQ6IDgsMzIgUiA4NjkyOTAzMiAvIDg2OTMwMDU2
IFtUaHJlYWQtNTFdDQpibG9ja19ycV9pc3N1ZTogOCwzMiBSIDUyNDI4OCAoKSA4NjkyODAwOCAr
IDEwMjQgW1RocmVhZC01MV0NCmJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNDkxNTIgKCkgODY5Mjc5
MTIgKyA5NiBbVGhyZWFkLTUxXQ0KYmxvY2tfcnFfaXNzdWU6IDgsMzIgUiA1MjQyODggKCkgODY5
MjkwMzIgKyAxMDI0IFtUaHJlYWQtNTFdDQpibG9ja19iaW9fcXVldWU6IDgsMzIgUiA4NjkzMDE1
MiArIDIxMTIgW1RocmVhZC01MV0NCmJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MzAxNTIgLyA4Njkz
MTE3NiBbVGhyZWFkLTUxXQ0KYmxvY2tfc3BsaXQ6IDgsMzIgUiA4NjkzMTE3NiAvIDg2OTMyMjAw
IFtUaHJlYWQtNTFdDQpibG9ja19ycV9pc3N1ZTogOCwzMiBSIDUyNDI4OCAoKSA4NjkzMDE1MiAr
IDEwMjQgW1RocmVhZC01MV0NCmJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgNDkxNTIgKCkgODY5MzAw
NTYgKyA5NiBbVGhyZWFkLTUxXQ0KYmxvY2tfcnFfaXNzdWU6IDgsMzIgUiA1MjQyODggKCkgODY5
MzExNzYgKyAxMDI0IFtUaHJlYWQtNTFdDQpibG9ja19iaW9fcXVldWU6IDgsMzIgUiA4NjkzMjI2
NCArIDIwOTYgW1RocmVhZC01MV0NCmJsb2NrX3NwbGl0OiA4LDMyIFIgODY5MzIyNjQgLyA4Njkz
MzI4OCBbVGhyZWFkLTUxXQ0KYmxvY2tfc3BsaXQ6IDgsMzIgUiA4NjkzMzI4OCAvIDg2OTM0MzEy
IFtUaHJlYWQtNTFdDQpibG9ja19ycV9pc3N1ZTogOCwzMiBSIDUyNDI4OCAoKSA4NjkzMjI2NCAr
IDEwMjQgW1RocmVhZC01MV0NCmJsb2NrX3JxX2lzc3VlOiA4LDMyIFIgMzI3NjggKCkgODY5MzIy
MDAgKyA2NCBbVGhyZWFkLTUxXQ0KYmxvY2tfcnFfaXNzdWU6IDgsMzIgUiA1MjQyODggKCkgODY5
MzMyODggKyAxMDI0IFtUaHJlYWQtNTFdDQoNCkkgc2ltcGx5IHByZXZlbnRzIG5vbi1hbGlnbmVk
IHNpdHVhdGlvbnMgaW4gYmlvX2lvdl9pdGVyX2dldF9wYWdlcy4NCkJlc2lkZXMgbWFraW5nIHRo
ZSB1cHBlciBsYXllciBhcHBsaWNhdGlvbiBhd2FyZSBvZiB0aGUgcXVldWUgbGltaXQsIEkNCndv
dWxkIGFwcHJlY2lhdGUgYW55IG90aGVyIGRpcmVjdGlvbnMgb3Igc3VnZ2VzdGlvbnMgeW91IG1h
eSBoYXZlLg0KVGhhbmsgeW91IQ0K
