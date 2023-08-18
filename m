Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464F1780848
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359099AbjHRJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359086AbjHRJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:29:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4012B;
        Fri, 18 Aug 2023 02:29:45 -0700 (PDT)
X-UUID: c2731ccc3da911ee9cb5633481061a41-20230818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0XEHwdFeK+KXpRK29Fv7+mMdCZYT/IxZPgRchBYHlRo=;
        b=MdoI5T5iKi69iJyvqVuIiCeGqVDyLyg6Oe9xIziA4bbqgegOVN7Fgmgesi2i30RJVIldOB7BZW8Lf8Y8XOMaa71DYyumiDk3dJPGOETaO2fNuUai1RmUfSx4cO9rCkMjsGEV2n8Xu71Z8EOuurs4rD+J5ouRig4FG54gzzsb85M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:c13ec69a-a46c-4ced-932b-0e606b3d00f6,IP:0,U
        RL:0,TC:0,Content:11,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:11
X-CID-META: VersionHash:0ad78a4,CLOUDID:e553eb12-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c2731ccc3da911ee9cb5633481061a41-20230818
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1189877533; Fri, 18 Aug 2023 17:29:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 18 Aug 2023 17:29:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 18 Aug 2023 17:29:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byfC/2HkyCff632HaQ3kgbComynCg1BJ8H2GaM78g0h61U3qboXzWgU+KISJUEvJLmsbS0QEzKK7GXjK1pk0y4bMtPz/iXusmujkdof9RCg3JQSt0//rO8ScPiCB3DmnfikzFj73qwuiPBXJX2Tia2/6Mn2desdqoKepQhc1KyYsTB36JvOprTlyejd8HsYniP6Qx0/106W9mKkr7YLMxVzam0fI6djcyjkOXgNeh29ccFvwc88jUkSlmf1f3eXpvVpFx/P2TCXFuKxXgSTQzZxR6rtzoqOWnWBCiorrBEwdj7YXztK4k1jWa07rQyWVzE1qEvPNXn4+iUZ3zdxfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XEHwdFeK+KXpRK29Fv7+mMdCZYT/IxZPgRchBYHlRo=;
 b=jKuTvkT5fq338hsZ2LUcRJYq1QSJpa3X9k5FsDcwxJzYCWEnbm0Cu29AhG8TQBSkyHcsn0hJZtZtWASqoGDxEAGZf2MoHEJE58f8W7EgV3ECH8kYaUHkjtaKBQptEnSkrXaBvSkplKuaFrAf7ChRxvyWumYAn7LYqogvPvpe1iM7tV/X0zfFy8Uv3DadJ5P1w36WoZ4mL2qGnzSY9zmvOjKwJ4qjmugn3LrOXqvGKJdssPho+1YDMTCC72NiqWXh4dEQoBCF2rI4JKpKCn6Kz9Mt40tTOAsh46CVU+D7K+oyEoEQ+7MPcJYEA2ilGye8Ej1GRasfOxQDfGmZJDQBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XEHwdFeK+KXpRK29Fv7+mMdCZYT/IxZPgRchBYHlRo=;
 b=Kzi8swpEJnLmXKxf2EaTHkNfZZe3FqDgULi5W93qvg8ALSnyWYDO217cRa9s9MIL18ViSybHl5ikiQMf96Xqf3xLmanWabbyp1QFj0CWEHT4R6Qmiwft9S0SoHOaNfBVNYW82LVdcawhR5VgIlKCq167o+E6zaJNrGNKiAIq3EU=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by TY0PR03MB6982.apcprd03.prod.outlook.com (2603:1096:400:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:29:37 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::e495:a4b2:4d75:32ac]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::e495:a4b2:4d75:32ac%2]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 09:29:37 +0000
From:   =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Disable timer before
 programming CVAL
Thread-Topic: [PATCH] clocksource/drivers/arm_arch_timer: Disable timer before
 programming CVAL
Thread-Index: AQHZuI5PjiCw5eb/JkWx9dsyP3tuSa/v++UA
Date:   Fri, 18 Aug 2023 09:29:37 +0000
Message-ID: <9c428d54c07f60e79c63119621bf03b797f79a37.camel@mediatek.com>
References: <20230717090735.19370-1-walter.chang@mediatek.com>
In-Reply-To: <20230717090735.19370-1-walter.chang@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|TY0PR03MB6982:EE_
x-ms-office365-filtering-correlation-id: 53f76906-fc1a-4dc3-0005-08db9fcda432
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJ8/Qq0POo8fgEA8ege1EmvxTdbRGbpkXsHpLzF5x7Pnwit3WDhZwFPfrHwfEfstoQrk3R+4HrK4rD2WIm6252v/le1qkpVnLyMVFZc+iw5oWxC9Oe7yVGtzAw29X+laeoY3omsAjPSP293xgqCtr5NGF6p/1jQ7T+ixejudj9t+70s2HoGl/1meXJFVe6+v5MFFzU5TXJNB5SOYTZ6cK8EQqsBtTCzC5fR9Sgvw/gTd6GFUpWQiWwrUJYAZawmqs2ncAcSTe/CuwIqoItPfPLJo5ilxtAPUXGTbDjhuqbbHgT16NcnKYZbVW64hpX233NnBWEXWJv+nD29+9oSqb47/oKKeMthQH58kxmPzO/e5FlHkQyDVu7dM7gH+szEKYKyF6V+fOWrhZtLY+P8OEGvHTEFxQWQC1hUEgWXvDyZ/yrTu7ZFCzndjib9K1zCpXAFtBOP5quGwtd6bAQz4F0N4vlCuQZnsW3gX1NewZ7FdHmZuN+m5PvAgbenFrgI60UKlBUvVM2nV8+tq5JMb7G2XBLihTul2nBzO3CtvDCVm40aPSc0bfL+8jKJ21Ng1Vj6ZMBmXityXtsiwSHIS123jZhh8hVcyWcaOWaqdvKEkFR9APWvzBtUKjEfHLwVCrRD1wFxSxbdGVP/ykX345sNNFPKH2JZBFA+brErfS1Zv4w/hA3pP6gtdEDEbWmM9oTaPPrXmWWat/sYz+kS+KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(1800799009)(186009)(66446008)(2616005)(107886003)(71200400001)(26005)(6486002)(6506007)(6512007)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(7416002)(478600001)(41300700001)(76116006)(110136005)(54906003)(64756008)(66476007)(66556008)(316002)(66946007)(91956017)(38070700005)(38100700002)(122000001)(86362001)(85182001)(36756003)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnFYYlZ5YU93VDRkYUhFb2t1UndVM2syaFFacExkOGlabEhaZHhTaitIZ1lr?=
 =?utf-8?B?STdzN0ZxMVZ3dFhaUTBEVjlwMmZoSDVTdXk2SWxoaVFSZUhqWGVTbW5DY1JE?=
 =?utf-8?B?TDZNd09NNHBtWjl3R1ZXaVNNUVRvb3o2b2RnRTVwYWkyS1ArcDlNd0k2RVlz?=
 =?utf-8?B?UHNpT0JuclZrSDFEZEVHM0hjUzQ3cFhHNVRNRGRtc3JsdzlOcWxCQ0diNzJN?=
 =?utf-8?B?Zkh2RGVBOXNtbDAvSDF2Z0JKeXM0bU9Tc2RkV20xVFJ3S2ZYU3FwOEJOOExq?=
 =?utf-8?B?V0t3K0JLMCswVThOSmszQ3ViQ2RuQUdKYlZsRWNTdndZdjhraFMySmtSbjAr?=
 =?utf-8?B?TER0UEpqYmh0VVU5cmlCd0t5OUpsL3RCbEQyVzFpVmV3VWdqZ0tVTmdaeEo5?=
 =?utf-8?B?MlJDVUI0aEF4aStUM0hjdFhTTEcyMGlKcFpvaFp4N2pzQ3BTbzMxTHY2T0k4?=
 =?utf-8?B?NTlMWU5adkQvM1EweDY5aEowL0h1OGdCNnNNbjZhUzhNb1ZZTFF1YUE1VDJH?=
 =?utf-8?B?bTdHaUVtdmFrQVR6M3R2aXBpT1ZqUGJiWjlXay9nV1BlbnAvZ0NYL2ppanFj?=
 =?utf-8?B?WGtNTjBndUtYMU5lVS9zYllRbjV4UkhnRXI0TjdySm1JaEMxU2dPdzMwY1pT?=
 =?utf-8?B?YVI1VXVSb0Y1NVdqY01OdUNEQkRURkxBUkdibEpNd1ZBTkNPeVdvakxTZXdt?=
 =?utf-8?B?bEhKWGgzZk1LZitmd1h3NUFQM2xYSnFBR3RZYk91RGgxZ05Id0RmOGVFTlhr?=
 =?utf-8?B?Y3F3c0lTUkl3SjlhMHR4QVc3SnBaT3RTbmNNSGxjTnlEaDA3VTNNNzB6ZDZD?=
 =?utf-8?B?VjlydWIxOXZKWG1yRUppaGhBa21qWHNmV0hrSC9RNEhCT3BKZjd3MlAxeldx?=
 =?utf-8?B?dExzcTFmRGd3aFJCTXBXa0IwcW9HYWxJTGlEbkJHV1N2Rmc3MG90TW82eEJ5?=
 =?utf-8?B?Y25lVkkveEpMZzIwa3duRWtkZ3NMNnE4cGVYR1NjWDI1MEo5a3JGSzExZFFB?=
 =?utf-8?B?MWJhVWxFOGo2ZmxLMDBWN3RuS3Q3RlhJKzZEZk9pVTlieWFUczNObDUyeloy?=
 =?utf-8?B?VEdCL3RPeUs5Z3hqeFFFbjk0aUliL1pKR0Qwc3FsWUR1QVFBbm5tVGYzT3U5?=
 =?utf-8?B?Y2lYTzVIcERGUWhiMG52d0F6Tlhad3p3allZVS9HQzFTV2NML2t2SmVKK1No?=
 =?utf-8?B?MGJzcDQ3V1dYOHYrWWk0ZUYydGMwL3ZycC9qV0tXcytyVmZDMytoa21ZSFQz?=
 =?utf-8?B?L1pmak9GNjdDVVc2SHJldFNGdThuSG9tUFN5UWthUFFiV0hLMDI1TWtXOFhi?=
 =?utf-8?B?QVEySTh4Mm9JZXJFank3M2FyMlB0VlhqbVpIL205WEN0b1JYWGxNdVNuNkVW?=
 =?utf-8?B?M25uR2ZRVHpiUTR3TCtwWC9YUnpPbkU2M2ZvUWU0eWVaM3RMNE5kcG5qcHJJ?=
 =?utf-8?B?VEE0V1M5NXBLb2h1SGo2a0FKWExxakhZVlNIU3U0eE8rc2dqbm1BUmtlS0Zp?=
 =?utf-8?B?RGduM3BydUZRbS9EbFRJWXVzeVhzNFlFMy9BMXRXbHRGQS9jVmxzdFNMWUp2?=
 =?utf-8?B?TGhxR0djUytaMmxGZGh1V2pocFpWcHdOMEZFbjhFRlpHY3FGeldkN0tNOUxj?=
 =?utf-8?B?YitiY3Vaa093aGwyTG1XcXBhOHNWRVprbHMwY3B4aXVwcy9sUjljRmlXT3Jl?=
 =?utf-8?B?dHpSU3JtdWVSQnNVYzFZcXdhcnBPbFU4YmZVYXVCUDIybmcvbHE1YUs4bEo5?=
 =?utf-8?B?Qk04dVNxQXRKT1gyYmlDODFGSGRWdXVHL0JKUG5CckJ4S05JbFo3bmtCOC9y?=
 =?utf-8?B?TmNlektzUnFsRHZSeHRlaEpEME5NV1p2bnBXaldOOVVpUGw5Sk9FK3ZDYjdZ?=
 =?utf-8?B?NFR5d2hIeVJnQUZ3Y3FGdS9aSW9QSUUwZHJkeDJSV1dLaTZFcnZBcDBjV1Fh?=
 =?utf-8?B?cmpiL0hzNmc5MzBIVDFSZ05tL0cyV25PMExBREFMSUZxN1B0QXR0MkRwOU9y?=
 =?utf-8?B?YjBpQUZRT25FYmVUQW1iOHJicks2NHlpVHFRTnNMbDFpNlFKemhXOWVrSnpQ?=
 =?utf-8?B?Y0gxYnZtRnBjSWdtc2ZYcnJkNlZtK1UwYzNOUzNRdnhzQTNIdUdORXRGdlA2?=
 =?utf-8?B?UnEwdUM0aWE0bXRaVExWaDRPTEc4ZmIxekg3RlZrYk1tazhJazNScWJScmMv?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <886F4CD6FFBB18458E8DEBC0BB452560@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f76906-fc1a-4dc3-0005-08db9fcda432
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 09:29:37.4792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZFmEPEEckg9zHA2k1D7AdagWNqLVg6DwkhmJhUHWuTgg5JTKPIrteZoW3fzhQVH4JrJgSoEZJjzO69YeAMLN97oXMbdhpE6gXmYal9JzRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDE3OjA3ICswODAwLCB3YWx0ZXIuY2hhbmdAbWVkaWF0ZWsu
Y29tIHdyb3RlOg0KPiBGcm9tOiBXYWx0ZXIgQ2hhbmcgPHdhbHRlci5jaGFuZ0BtZWRpYXRlay5j
b20+DQo+IA0KPiBEdWUgdG8gdGhlIGZhY3QgdGhhdCB0aGUgdXNlIG9mIGB3cml0ZXFfcmVsYXhl
ZCgpYCB0byBwcm9ncmFtIENWQUwgaXMNCj4gbm90IGd1YXJhbnRlZWQgdG8gYmUgYXRvbWljLCBp
dCBpcyBuZWNlc3NhcnkgdG8gZGlzYWJsZSB0aGUgdGltZXINCj4gYmVmb3JlDQo+IHByb2dyYW1t
aW5nIENWQUwuDQo+IA0KPiBIb3dldmVyLCBpZiB0aGUgTU1JTyB0aW1lciBpcyBhbHJlYWR5IGVu
YWJsZWQgYW5kIGhhcyBub3QgeWV0DQo+IGV4cGlyZWQsDQo+IHRoZXJlIGlzIGEgcG9zc2liaWxp
dHkgb2YgdW5leHBlY3RlZCBiZWhhdmlvciBvY2N1cnJpbmc6IHdoZW4gdGhlIENQVQ0KPiBlbnRl
cnMgdGhlIGlkbGUgc3RhdGUgZHVyaW5nIHRoaXMgcGVyaW9kLCBhbmQgaWYgdGhlIENQVSdzIGxv
Y2FsDQo+IGV2ZW50DQo+IGlzIGVhcmxpZXIgdGhhbiB0aGUgYnJvYWRjYXN0IGV2ZW50LCB0aGUg
Zm9sbG93aW5nIHByb2Nlc3Mgb2NjdXJzOg0KPiANCj4gdGlja19icm9hZGNhc3RfZW50ZXIoKQ0K
PiAgIHRpY2tfYnJvYWRjYXN0X29uZXNob3RfY29udHJvbChUSUNLX0JST0FEQ0FTVF9FTlRFUikN
Cj4gICAgIF9fdGlja19icm9hZGNhc3Rfb25lc2hvdF9jb250cm9sKCkNCj4gICAgICAgX19fdGlj
a19icm9hZGNhc3Rfb25lc2hvdF9jb250cm9sKCkNCj4gICAgICAgICB0aWNrX2Jyb2FkY2FzdF9z
ZXRfZXZlbnQoKQ0KPiAgICAgICAgICAgY2xvY2tldmVudHNfcHJvZ3JhbV9ldmVudCgpDQo+ICAg
ICAgICAgICAgIHNldF9uZXh0X2V2ZW50X21lbSgpDQo+IA0KPiBEdXJpbmcgdGhpcyBwcm9jZXNz
LCB0aGUgTU1JTyB0aW1lciByZW1haW5zIGVuYWJsZWQgd2hpbGUgcHJvZ3JhbW1pbmcNCj4gQ1ZB
TC4gVG8gcHJldmVudCBzdWNoIGJlaGF2aW9yLCBkaXNhYmxlIHRpbWVyIGV4cGxpY2l0bHkgcHJp
b3IgdG8NCj4gcHJvZ3JhbW1pbmcgQ1ZBTC4NCj4gDQo+IEZpeGVzOiA4YjgyYzRmODgzYTcgKCJj
bG9ja3NvdXJjZS9kcml2ZXJzL2FybV9hcmNoX3RpbWVyOiBNb3ZlIE1NSU8NCj4gdGltZXIgcHJv
Z3JhbW1pbmcgb3ZlciB0byBDVkFMIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogV2FsdGVyIENoYW5nIDx3YWx0ZXIuY2hhbmdAbWVkaWF0ZWsuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYyB8IDcgKysrKysr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYw0KPiBiL2RyaXZlcnMvY2xvY2tz
b3VyY2UvYXJtX2FyY2hfdGltZXIuYw0KPiBpbmRleCBlNzMzYTJhMTkyN2EuLjdkZDJjNjE1YmNl
MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fYXJjaF90aW1lci5jDQo+
ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYw0KPiBAQCAtNzkyLDYg
Kzc5MiwxMyBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQNCj4gc2V0X25leHRfZXZlbnRf
bWVtKGNvbnN0IGludCBhY2Nlc3MsIHVuc2lnbmVkIGxvbmcgZQ0KPiAgCXU2NCBjbnQ7DQo+ICAN
Cj4gIAljdHJsID0gYXJjaF90aW1lcl9yZWdfcmVhZChhY2Nlc3MsIEFSQ0hfVElNRVJfUkVHX0NU
UkwsIGNsayk7DQo+ICsNCj4gKwkvKiBUaW1lciBtdXN0IGJlIGRpc2FibGVkIGJlZm9yZSBwcm9n
cmFtbWluZyBDVkFMICovDQo+ICsJaWYgKGN0cmwgJiBBUkNIX1RJTUVSX0NUUkxfRU5BQkxFKSB7
DQo+ICsJCWN0cmwgJj0gfkFSQ0hfVElNRVJfQ1RSTF9FTkFCTEU7DQo+ICsJCWFyY2hfdGltZXJf
cmVnX3dyaXRlKGFjY2VzcywgQVJDSF9USU1FUl9SRUdfQ1RSTCwgY3RybCwNCj4gY2xrKTsNCj4g
Kwl9DQo+ICsNCj4gIAljdHJsIHw9IEFSQ0hfVElNRVJfQ1RSTF9FTkFCTEU7DQo+ICAJY3RybCAm
PSB+QVJDSF9USU1FUl9DVFJMX0lUX01BU0s7DQo+ICANCg0KR2VudGxlIHBpbmcgZm9yIHRoaXMg
cGF0Y2guDQoNClRoYW5rcywNCldhbHRlciBDaGFuZw0K
