Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3221A7D7B57
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjJZDtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZDts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:49:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542EC187;
        Wed, 25 Oct 2023 20:49:38 -0700 (PDT)
X-UUID: adaaba4073b211eea33bb35ae8d461a2-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=c57016u59H1Fjy0BdjYmjN1tyC0TFya9i0cT21OJmJQ=;
        b=W3m6At3uUaSkw0G9k3+/jGuaF1uObLpYz8qPzU2WEcP7SLQgo9v+UlZGKvmQFQ45R1ZH7FcAV3o7MDeEXtsSICrfulRCIR7YrmyxzTuObLmXcgQEtqDsSwszkVwP6UvDaeepu26N/7siw2L/MDLPAGeNHObscjf7D1TrSVjosE8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8af48ae0-bfe5-42a6-a475-05d1d0d8f4a5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:697555d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: adaaba4073b211eea33bb35ae8d461a2-20231026
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yu-chang.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1372694080; Thu, 26 Oct 2023 11:49:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 11:49:31 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 11:49:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drukXVaNvBz60Prks0hxEnKypbNzoEW/hDdNnzxdMLm+QUH8VPhcYrEJan/3hbl81Y4k5AHrx8KC2DkuTsEkBhw4lY8gs49s0eS2wRsdvXON2bKjrN8YAR0K6axfRIV2DLfyaiXO7m2XuocSoZSA9UlGpqcRIEknEcLd5MeSe1KqtSSAO4XQBDKczHD3jxCqQXuIoAyK8h/SbMkD+mDqR/nBIUzFpW6S8oYZ88nUtnphVR71+4gd5uQIkihKRopr8idQ0WGqWkua3qTj01rQrBtNLjnFt+NEDEAwpFFpfBEs95rb9Gplgr1pcXetrZgJYBOerrje3BsKgk3Fv9rOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c57016u59H1Fjy0BdjYmjN1tyC0TFya9i0cT21OJmJQ=;
 b=ivqAyW3NEJOwgUjxY5eI1+l/4GQsx5GZF4MPfiCFESYjs9bmP5o1GPNu1fZdmkYX1RkSbwgGNYbGpLYTan3D3UVX063f7Hqsam5GRuVVIky/HmElgwHXKe/ksJpAYV5r9XL/wQtCjlpXwDZat4ARH41lUBXhKGlcHVUQSIaSS/UFSGe7Fkg2iyx00iGN7ecdjPYD2TIGphSQtMzp2pVouplGBQibp1y5WRQxjCVUdh5tC3XKSSG08eFr8rwWEGAjWq3tRHVTvlKlbxVs8DNnI3MP8+VtJ+jmfoPIa1idjKcYa7aG0uVBE1QxcbN6QhPpUz7TPjPWETh8lejOq+cbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c57016u59H1Fjy0BdjYmjN1tyC0TFya9i0cT21OJmJQ=;
 b=OQYbb9Xn5bxnOeatLlsVGZLKovPlhtfNtwCOMmM3LMJveiRft2NuQhbfqeVHZLt4sgV/JEaEurmvcu2QtjMkwdN9dgsrc7nZ5sh/qKiloISdGe9ij+MJfbGJLiXYvioblGUiHxRoWGREzWjL1V2WLxNHM/1hI3HDTfNDqMzbRx4=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by KL1PR03MB8118.apcprd03.prod.outlook.com (2603:1096:820:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 03:49:28 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::eae7:2692:e6a8:e278]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::eae7:2692:e6a8:e278%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 03:49:27 +0000
From:   =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
Thread-Topic: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
Thread-Index: AQHaBaaHQyCeGVCVIkaRHyl/V0yhJrBSGxiAgAYj9oCAAAG2gIAAUHkAgAAaCYCAAZq1AIAAG6OAgAER54A=
Date:   Thu, 26 Oct 2023 03:49:25 +0000
Message-ID: <1a734157709adc0cd85e084174bb4889301f1c1a.camel@mediatek.com>
References: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
         <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com>
         <283d18028590d57025e5654d18b8b5b7.sboyd@kernel.org>
         <CAGXv+5EpBLnXVdxnk9wBZi5F7U5wdJRfYH7fgg4Lkr1HJXm+WA@mail.gmail.com>
         <9c1e10b56db315e03daa3df5918cde844297c680.camel@mediatek.com>
         <CAGXv+5HQ2sVx=F3my2jOGMw3j3pU2aarEg+Dj1XgNzwio98ezA@mail.gmail.com>
         <e049985de9da9958ba425824ab5f38c7cf41025b.camel@mediatek.com>
         <eb4f7d6e-0e4c-4b2d-b889-cad9fc9262d8@collabora.com>
In-Reply-To: <eb4f7d6e-0e4c-4b2d-b889-cad9fc9262d8@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|KL1PR03MB8118:EE_
x-ms-office365-filtering-correlation-id: 8c54ef49-ed8c-4c00-3382-08dbd5d68c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KlMx0ZUVZ6uRQ1z4nYNSVMXqAb+vaZT0AoabdlVMdiEYweg3kxMJ1FL78tvQDxFKDrD4eUW3JMgWZzms/bmHPzKF130ggITadskEF7LUOl6yjZ39VTkXfbApAFnIG+OMthV2enyOgxma12dxd6ueZ3HKbILLXejCrk0YBm/nrBVWr2xBbSJzwFWe1J9vwmulXFaCe0BeGowcix7G/A7xZTQixAhRRzH5837ND7YVr8RUbO4oHQAtwkxnmb9yxv7f50QHAaL7dT8CwBWtrYE2yNDlFPfAetkwozNGagVbJ+/y3IEUBudAqO5YYEWOUmzUvgJ/Ef8+OTGG4YzIdhMfJIyHw5ccR4D5iV8YT7HT736QcbeG/gJnCiIVy75CEP2u7BfCrfWwz4iWmx9hGqK/PekP2tE94fNDkXPpK0CWvylIB6Jwfc9uk9SZpJ5ziYfWwbYMOk0CRAp/PsCrbo+mrmLukpdpsc6M9J3CwpEfpymSNsA0NeYTvOlZOZV44mo6ahIBuQnfnkOOyUHhL9Kh1tEiKzRkFN2N9Xe+RMYw1n4UE45fh9YrEAd3ImNS+CHYei54gM9JUkEPstyNlwoEaAfJvMI5cgYBoYbM8tXLctTGL/Kg/v/86kHjC0hb6Z4vqEOlMm2yGININokZVbxAMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4001150100001)(4326008)(38070700009)(2906002)(7416002)(38100700002)(122000001)(5660300002)(41300700001)(8936002)(8676002)(86362001)(66556008)(54906003)(64756008)(110136005)(316002)(66476007)(66446008)(76116006)(66946007)(83380400001)(966005)(478600001)(2616005)(36756003)(53546011)(26005)(6512007)(71200400001)(6506007)(6486002)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0x6WmpkdGVFTzZyMGRVdk9jeDdqR2dtSGhTZklnNWM5MmowMGFMWDEvcExG?=
 =?utf-8?B?ZXN0WG5mMTA4ekE5VXdRRHBRSnQ5R0lhM0ZKZmJkb0hWYWgreDg3TlRTU2ow?=
 =?utf-8?B?WndWOWs4d2djd25oS085a2dOQkZRYXF2SWE5N0Q4em12YmI3UHpYdnVWeHBK?=
 =?utf-8?B?SlZva2QxRnM0TmFMRjNPeHcxWGtlSUt4a1Z3U3N0RFJQclpwK2xNbjR5VGRS?=
 =?utf-8?B?UUh4TGFEL3RvMm5PcE1NUzUybENmNjcyUnpxSnVZWUdhQjZoeiswUlBSdzha?=
 =?utf-8?B?ZnBpSTBndjFOZnllQmlURER4WnA2ZlRJRmFBTEpmR3d5T3Bnd3I2YVZQN0Vm?=
 =?utf-8?B?a3lDdm5KbzhTaWxiZ0JTZFRJWWVmdnMrM0ZFYmJwUXU3bDE1WW1PSFZ5T0k2?=
 =?utf-8?B?OHZqd1o3UFplam5kWnZRUkd2QkJRNkZVc28wdmgxS2c5dzJ0NnkyRlVDK2FE?=
 =?utf-8?B?WityenZYREt0aXAyM2ZCRm4ya29kK1hqS1hyWVp5cEkrdWtjcnhQZk50Qkcx?=
 =?utf-8?B?OVE4SmlMbFNFWTB2Vk9BYjNoZXhVQmQ2b1NMSTYwMzhGRHJRRDlRcHFISGhq?=
 =?utf-8?B?bElFQzVvQlVOUDZJdzJJTjAvdEt4VHNzRlkyVTFRYTQvNWNzMjg3UmZ5bm9U?=
 =?utf-8?B?UmJMZUdDaldBZzM0NXR3T0tCTnlQVEtmN3U1UEEwaHIwcTFvL3lxekVLdGVu?=
 =?utf-8?B?aWlMdWlTQWlTQTBzYkRSdmJhUVNGYUZicHpuM3liZEFSWnlaZUxDUjhWM2tj?=
 =?utf-8?B?S2pmSTRHM0pmMTR0dnlSLzFFRDZtcDVhQ0wxREkwQ2dhTFYzUkVxSEZjeHBN?=
 =?utf-8?B?WlBxM05KNVU4ZWl4R1FRQmlUYUVudHFZOHExZW43MTBlSmtHdEhPczJRMTY5?=
 =?utf-8?B?emMxejBZQm9wZkRxQmpQOFQyemRKRzRjb09vQXJxcmpUaXVMZUNaRktxTEtw?=
 =?utf-8?B?U1pSZGx0M1MrUklLc0w0Y3ZJejgvWTdhZnRTa3UvNHZ6ZHdVZk90K0NuOHVM?=
 =?utf-8?B?Q3ZITlVtV1VCNnVBNW8wcE9WbmJ5cEtVSlpCYUFHU0N6TlBzY2lrdlppYlFN?=
 =?utf-8?B?R2NwS1h0bUR3VVErNUpsSHF1NXdxbUN6clp4WndqaTZ4US94enpTem1hYWZR?=
 =?utf-8?B?UndraWppVUhEOE5wTkhYZUI4UmR4bHB2OHNycE5DUC9kQWNGR1RnazNnWkNL?=
 =?utf-8?B?c3RoN3F0Q2FOdkFIQWJMa0JmUHl3Q2FXNWF1WHZSSzF4TlNremM2MlEvamJ5?=
 =?utf-8?B?V2pWVy8vTGx5amd6Z1FTQUlyR2FyTElxdEtkQVpSWTFaVzhPWkh1UEQwL0VK?=
 =?utf-8?B?L0xIaXM5UGtmM0NER0IyeTZsenFzaDZxWUtVcW9sc0R3SnFDRGNTNnYzbEJP?=
 =?utf-8?B?WmdIdjdmQlBkNmVoRjFDdGRybk9vWFBKaG5uUFZVczR0ZzdLSVcwNDZhc2Q0?=
 =?utf-8?B?dUpNdG9zcllsNElsdjRFeVk0VU4zTUdEWW9ZemZEdnU2ek9xOVM5VTdhVmNV?=
 =?utf-8?B?NHM4cWU2VG5lV3RaNDR4MngzNkZuZ0h2NGx0TE05MHRvY2s3MzBxTjlRdFgv?=
 =?utf-8?B?NXIvcVBSc1hYNWJUZUZJdjFaejdTdzdSZ2hCb2RwcDYyU2p5aVBvdjRVWDhJ?=
 =?utf-8?B?VVF5aVhya1NNV0ZsRHQ5WU9TWmFTc2ZFMFE0U0NSODd3SGVLMzBzVUtsUnFM?=
 =?utf-8?B?WmhUS3pyN21WZVN4REdSbThJRHpoK2xJTXZ2R0R0NlAyYXNON0tkZDFHWkYr?=
 =?utf-8?B?MVczSnk1dXVNMWgyNlRhaEFEZC84R3dodG1FNUJHZkRmZUZYSzlEV2ZMWXJh?=
 =?utf-8?B?UTJjMEFabnVsVkl4N2JvVDBCWWE5eUF2NDFScG5SdWVaME1tZmdERzBaNGhU?=
 =?utf-8?B?eVQ0b2NmZzBYczc5TS80SU90b2g0UXVSbXc2RXJBMlBSbStrbHJ2SFdEYjUx?=
 =?utf-8?B?V1ZjVnNxV0E2cDVCL0gyaG5PWGtIYnR5eHpwMCtqVGJLU2RlTWRhMzBIOWJP?=
 =?utf-8?B?anNQOW1ZQXFnblhNbmluNjJ4djNjemxHUm13cGZ3MUFvM040eStpbU1xQ0Jz?=
 =?utf-8?B?dmEyYmJtSUxaVHFXY1dwbDYwWDlIY3dJTzFhVlQ1bWFZdWdxNXFHbHB0eHVY?=
 =?utf-8?B?NlZ0RVloWFllKzhRY1ZHMmhtdGlRVlFTdFp1RE5ISVpVbmk5WmpjcWIyWjhp?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3B37E09125FD347A617FF89E8B05600@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c54ef49-ed8c-4c00-3382-08dbd5d68c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 03:49:25.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fU8ZJvU/rEVA2ftJkgOigcL7iTSVGpIIgdg9HtaOsxzncinD4c+Wgnh5i30i9gUrsfm+wuizC69mMBQdZMHwCDC9XC/WSfg6CejlzvcoW4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8118
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.159600-8.000000
X-TMASE-MatchedRID: xLkcAt3TQsXUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
        bY7xfgXYlJxMC94GqDWteL4840o+NTchyiq37BQwvHKClHGjjr2cyCGZko2aplVqIv0mjuMGeDg
        I4iMaw3LhfjC215b2DdmrsqfAJHEma7aDmzqnyU8AIeMYnjom2f3zj+0h3ZMpgrAXgr/AjP2NQC
        Hv4KBPajAhOMhrMDNMaFCYCprws4YWA/Bj66hcB+Q0jDxGUAJDc3ewuwbSaG52tmRAtFk5V/EnV
        Vij2P3p8kVP1EEY3ww+K4Yl3VDW5mlm2w5uC3SGQ5lZokGzOaohotH7bEpEMph8u7mojKy+r2Zq
        hEtkqj2Sg1/uMFG+r58mxCDGyv3tQEdNChTTbLXzh2yKdnl7WArefVId6fzV+3n3Z6rbGhOhetP
        Rq5gu7VaqomimMSnxEeHs7CCjBEeROBVNmXUDuKMVgdN9w+TC9pLnYtQ99xJRuqFUR05v1HRkZD
        wt6TorpZ5KvbL6hfs3J4yJ10Xc50kjllSXrjtQ0gVVXNgaM0pyZ8zcONpAscRB0bsfrpPI6T/LT
        DsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.159600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4BBE4C3AAC7496F7611521543E0C83D7A46656EA399C21B796EB5E810068F65C2000:8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDEzOjI5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjUvMTAvMjMgMTE6NTAsIFl1LWNoYW5nIExlZSAo5p2O56a555KL
KSBoYSBzY3JpdHRvOg0KPiA+IE9uIFR1ZSwgMjAyMy0xMC0yNCBhdCAxNzoyMCArMDgwMCwgQ2hl
bi1ZdSBUc2FpIHdyb3RlOg0KPiA+ID4gICAJDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFz
ZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4g
PiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiAg
IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDM6NDfigK9QTSBZdS1jaGFuZyBMZWUgKOadjuemueeS
iykNCj4gPiA+IDxZdS1jaGFuZy5MZWVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+IE9uIFR1ZSwgMjAyMy0xMC0yNCBhdCAxMDo1OCArMDgwMCwgQ2hlbi1ZdSBUc2FpIHdy
b3RlOg0KPiA+ID4gPiA+IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDEwOjUy4oCvQU0gU3RlcGhl
biBCb3lkIDwNCj4gPiA+ID4gPiBzYm95ZEBrZXJuZWwub3JnPg0KPiA+ID4gPiA+IHdyb3RlOg0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBRdW90aW5nIENoZW4tWXUgVHNhaSAoMjAyMy0xMC0x
OSAyMjowNjozNSkNCj4gPiA+ID4gPiA+ID4gT24gVGh1LCBPY3QgMTksIDIwMjMgYXQgODo0OeKA
r1BNIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsDQo+ID4gPiA+ID4gPiA+IFJlZ25vDQo+ID4gPiA+ID4g
PiA+IDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+IHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEZpeCB0aGUgcGFyZW50aW5nIG9mIGNsb2Nr
cw0KPiA+ID4gPiA+ID4gPiA+IGltcF9paWNfd3JhcF9hcF9jbG9ja19pMmN7NC02fSwNCj4gPiA+
IA0KPiA+ID4gYXMNCj4gPiA+ID4gPiA+ID4gPiB0aG9zZQ0KPiA+ID4gPiA+ID4gPiA+IGFyZSBl
ZmZlY3RpdmVseSBwYXJlbnRlZCB0byBpbmZyYV9hb19pMmN7NC02fSBhbmQgbm90DQo+ID4gPiA+
ID4gPiA+ID4gdG8NCj4gPiA+IA0KPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gSTJDX0FQLg0K
PiA+ID4gPiA+ID4gPiA+IFRoaXMgcGVybWl0cyB0aGUgY29ycmVjdCAoYW5kIGZ1bGwpIGVuYWJs
ZW1lbnQgYW5kDQo+ID4gPiANCj4gPiA+IGRpc2FibGVtZW50DQo+ID4gPiA+ID4gPiA+ID4gb2Yg
dGhlDQo+ID4gPiA+ID4gPiA+ID4gSTJDNCwgSTJDNSBhbmQgSTJDNiBidXMgY2xvY2tzLCBzYXRp
c2Z5aW5nIHRoZSB3aG9sZQ0KPiA+ID4gPiA+ID4gPiA+IGNsb2NrDQo+ID4gPiANCj4gPiA+IHRy
ZWUNCj4gPiA+ID4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+ID4gPiA+IHRob3NlLg0KPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEFzIGFuIGV4YW1wbGUsIHdoZW4gcmVxdWVzdGluZyB0
byBlbmFibGUNCj4gPiA+ID4gPiA+ID4gPiBpbXBfaWljX3dyYXBfYXBfY2xvY2tfaTJjNDoNCj4g
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBCZWZvcmU6IGluZnJhX2FvX2kyY19hcCAt
PiBpbXBfaWljX3dyYXBfYXBfY2xvY2tfaTJjNA0KPiA+ID4gPiA+ID4gPiA+IEFmdGVyOiAgaW5m
cmFfYW9faTJjX2FwIC0+IGluZnJhX2FvX2kyYzQgLT4NCj4gPiA+ID4gPiA+ID4gPiBpbXBfaWlj
X3dyYXBfYXBfY2xvY2tfaTJjNA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEZp
eGVzOiA2NmNkMGI0YjBjZTUgKCJjbGs6IG1lZGlhdGVrOiBBZGQgTVQ4MTg2IGltcCBpMmMNCj4g
PiA+IA0KPiA+ID4gd3JhcHBlcg0KPiA+ID4gPiA+ID4gPiA+IGNsb2NrIHN1cHBvcnQiKQ0KPiA+
ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwN
Cj4gPiA+ID4gPiA+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJJ20gY3VyaW91cyBhYm91dCB3aGF0IGxl
ZCB0byBkaXNjb3ZlcmluZyB0aGlzIGVycm9yPw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gSXMgdGhhdCBhbiBhY2tlZC1ieT8NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBNZWRpYVRlayBlbmdpbmVlcnMgYXJlIHNheWluZyB0aGUgb3JpZ2luYWwgY29kZSBhbHJlYWR5
DQo+ID4gPiA+ID4gbWF0Y2hlcw0KPiA+ID4gDQo+ID4gPiB0aGUNCj4gPiA+ID4gPiBkb2N1bWVu
dGF0aW9uIHByb3ZpZGVkIGJ5IHRoZWlyIGhhcmR3YXJlIGVuZ2luZWVycy4gSSdtDQo+ID4gPiA+
ID4gdHJ5aW5nIHRvDQo+ID4gPiANCj4gPiA+IGdldA0KPiA+ID4gPiA+IHRoZW0gdG8gcmVzcG9u
ZCBvbiB0aGUgbWFpbGluZyBsaXN0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENoZW5ZdQ0KPiA+
ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQWZ0ZXIgY2hlY2tpbmcgd2l0aCBJMkMgY2xvY2sg
aGFyZHdhcmUgZGVzaWduZXIgdGhlcmUgaXMgbm8NCj4gPiA+ID4gaW5mcmFfYW9faTJjezQtNn0g
Y2xvY2sgZ2F0ZSBpbiBiZXR3ZWVuLiBBbmQgdGhlIGNsb2NrIGRvY3VtZW50DQo+ID4gPiA+IGF0
DQo+ID4gPiANCj4gPiA+IGhhbmQNCj4gPiA+ID4gYXNsbyBzaG93cyB0aGUgc2FtZSByZXN1bHQu
IEdlbmVyYWxsbHkgc3BlYWtpbmcsIHdlIHdvdWxkIGxpa2UNCj4gPiA+ID4gdG8NCj4gPiA+IA0K
PiA+ID4ga2VlcA0KPiA+ID4gPiBzdyBzZXR0aW5nIGFsaWduIHdpdGggdGhlIGhhcmR3YXJlIGRl
c2lnbiBkb2N1bWVudC4gSSB3b3VsZA0KPiA+ID4gDQo+ID4gPiByZWNvbW1hbmQNCj4gPiA+ID4g
bm90IHRvIGNoYW5nZSB0aGlzIHBhcnQgb2YgY29kZSwgYnV0IGVuYWJsZSBpbmZyYV9hb19pMmN7
NC02fQ0KPiA+ID4gPiBwcmlvcg0KPiA+ID4gDQo+ID4gPiB0bw0KPiA+ID4gPiB0aGUgdXNhZ2Ug
b2YgaW1wX2lpY193cmFwX2FwX2Nsb2NrX2kyYyBjbG9jay4NCj4gPiA+IA0KPiA+ID4gQXJlIGlu
ZnJhX2FvX2kyY3s0LTZ9IGFjdHVhbGx5IHVzZWQgYnkgdGhlIGhhcmR3YXJlPyBJZiBzbywgZm9y
DQo+ID4gPiB3aGF0DQo+ID4gPiBwdXJwb3NlPw0KPiA+IA0KPiA+IEFjY29yZGluZyB0byBoYXJk
d2FyZSBkZXNpZ25lciBpdCBzZXJ2ZXJzIG5vIHB1cnBvc2UuIEp1c3QgYSBsZWdhY3kNCj4gPiBv
Zg0KPiA+IHByZXZpb3VzIGRlc2lnbi4uLg0KPiA+IA0KPiA+ID4gSWYgaXQgaXMgYWN0dWFsbHkg
bmVlZGVkIGJ5IHRoZSBoYXJkd2FyZSBhbmQgaXQgaXMgbm90IGluIHRoZQ0KPiA+ID4gZXhpc3Rp
bmcgcGF0aCwNCj4gPiA+IHRoZW4gaXQgbmVlZHMgdG8gYmUgZGVzY3JpYmVkIGluIHRoZSBkZXZp
Y2UgdHJlZSBhbmQgaGFuZGxlZCBieQ0KPiA+ID4gdGhlDQo+ID4gPiBkcml2ZXIuDQo+ID4gPiAN
Cj4gPiA+IENoZW5ZdQ0KPiA+IA0KPiA+IEFmdGVyIHJldmlld2luZyBoYXJkd2FyZSBkZXNpZ24g
ZGlhZ3JhbSwgaGFyZHdhcmUgZGVzaWduZXINCj4gPiBjb25jbHVkZXMNCj4gPiB0aGF0IHRoZSBj
bG9jayB0cmVlIGlzIGluZGVlZA0KPiA+IA0KPiA+IHRvcF9pMmMgLT4gaW5mcmFfYW9faTJjezQt
Nn0NCj4gPiB0b3BfaTJjIC0+IGluZnJhX2FvX2kyY19hcCAtPiBpbXBfaWljX3dyYXBfYXBfY2xv
Y2tfaTJjezQtNn0NCj4gPiANCj4gPiBzbyBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIHRoaXMgY2xv
Y2sgcmVsYXRpb24gdW5jaGFuZ2VkLg0KPiA+IA0KPiA+IFRoYW5rcw0KPiA+IFl1Q2hhbmcNCj4g
PiANCj4gDQo+IENhbiB5b3UgcGxlYXNlIGFsc28gZXhwYW5kIG9uIENMS19JTkZSQV9BT19JMkN7
MSwyLDV9X0FSQklURVIgY2xvY2tzPw0KPiBJcyB0aGUgSTJDIGFyYml0ZXIgYWxzbyBsZWdhY3kg
b2YgcHJldmlvdXMgZGVzaWducz8NCj4gDQo+IFBsZWFzZSBjaGVjayBbMV0sIGFzIEkndmUgc2Vu
dCBhIGNvbW1pdCBhZGRpbmcgdGhvc2UgaW4gdGhlDQo+IGRldmljZXRyZWUuDQo+IA0KPiBUaGFu
a3MsDQo+IEFuZ2Vsbw0KPiANCj4gWzFdOiANCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMzEwMjAwNzU1NDAuMTUxOTEtMS1hbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxh
Ym9yYS5jb20vDQoNCkFjY29yZGluZyB0byBIYXJkd2FyZSBkZXNpZ25lciB0aGlzIGFyYml0ZXIg
Y2xvY2sgaXMgYWxzbyBsYWdlY3kgb2YNCnByZXZpb3VzIGRlc2lnbiBhbmQgc2VydmUgbm8gZnVu
Y3Rpb24uIEFuZCB0aGV5IGFyZSBjb25uZXRlZCB0byB0b3BfaTJjDQphcyB3ZWxsLg0KDQp0b3Bf
aTJjLT4gQ0xLX0lORlJBX0FPX0kyQ3sxLDIsNX1fQVJCSVRFUg0KDQpBbHNvIG1heSBJIGtub3cg
dGhlIGV4cGVyaW1lbnQgdGhhdCBsZWFkIHRvIHRoZSBjb25jbHVzaW9uIHRoYXQgeW91DQpuZWVk
IHRoZSBBUkJJVEVSIGNsb2NrLCBhbmQgdGhlIGNsb2NrIHRyZWUgaXMgaW5jb3JyZWN0PyBJIHdp
bGwgYnJpbmcNCml0IGJhY2sgdG8gZGlzY3VzcyB3aXRoIG91ciBJMkMgb3duZXIuIA0KDQpUaGFu
a3MsDQpZdUNoYW5nDQoNCg0KDQo=
