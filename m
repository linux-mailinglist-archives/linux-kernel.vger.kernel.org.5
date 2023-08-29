Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2345978C033
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjH2IZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjH2IZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:25:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6554CC;
        Tue, 29 Aug 2023 01:25:20 -0700 (PDT)
X-UUID: 9472083e464511ee9cb5633481061a41-20230829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9x4Cpf81uDQjlpNZN5uDFzPa/iVqMWVveaqpNQvi3QY=;
        b=R9LFMRFXpLVFdkGv6sC5QsvrVh/2EAyAZYIZ6fBuAAAn7F+89j3DAH6I27FGohc6hPg5/0yorkhePAK5o/rIJ03DySD4xXE/nLYd2ey0tRK1lzRariNUTyroKWNKYIj5Dxdq3mfOFiQ+Vaxapzw5eb0CrPs3j2AIAeZTnufm0Sk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:9a537fc0-7edd-41b2-8e37-a5a48d3945f6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:647865c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9472083e464511ee9cb5633481061a41-20230829
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1843081293; Tue, 29 Aug 2023 16:25:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Aug 2023 16:25:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Aug 2023 16:25:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0GWDM9CAkW8f06Du8Gs3l1PzXVTpVCAtzz0KFvL1GpSjC5KarGRBxgsmpsmPI61nqK1jDfVZmbgAjIlD0xzBP6+0xMWaR7cwDqYOB6IyJjtZtoUUD+L24DTnu1+nJztzIMX+uBPqFVJZqZhb/+4WAjslOi6D9mMcqfKumC4XyagOFW2KmkTsuqLTEB4Gq6WzYIyiKMbKnkqceEmOunLaxmsbbzXnkcugKtu9KtaWQRXYCmwW8a9mPr+Q4YP1Z8R/aBGjq1wcPmX1qcieooBhgCWhogMI/rtzy6ypXoPvR20fx9Bw1KIwpl4h6kemmWkJytmnu1APka7zvHsKYP89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x4Cpf81uDQjlpNZN5uDFzPa/iVqMWVveaqpNQvi3QY=;
 b=fUa3ixX5kDgR8dK0JWs4cxD9m26pAHd9xcc/DkqJgMhEcMEnGCLtepVxMua6x1MdqxRlj/BYPzR+qd4o8kytvO/dyJDJ4Qumju7A2uCAwzb5GgPzhrvXZevUDjbfUyP1ScohwNK2t6vd73u6ioH/LJIw1YkblhD/PzLqzud8SCjLzrGSWnhcOcYEnG5kmEicHCXwd/RTuJ2jad2x1mX/bTkJ2+Z1q31USviIWBE+54WcnJAfvAPFDtPIYIz1qJzkEyvwf0RNxzNxBmbN3NJiqIhRFbZSd2xk/uMSespuKz8zj1rBT9rZbQK/hO74/Z9epeREK62CyWY8Ix4uOzV0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x4Cpf81uDQjlpNZN5uDFzPa/iVqMWVveaqpNQvi3QY=;
 b=Nm1JUqzYMOhuZBQZIGOUt2jBHwzqBNdgX5nebfUECZAHwqn6/3DPZMtvP03d4fRHP4lFizNT4l97LCUYyuWVD0x68vwFunqSmS9lkfLjmpVpi4zPD6sROT5BE7xvmSh9Ns42/qKVQArlyTTHnk4oK7cYb3BeFAsuL2NhU8Shwrk=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by SEZPR03MB7838.apcprd03.prod.outlook.com (2603:1096:101:179::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 08:25:11 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::699f:9f30:a65b:547d]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::699f:9f30:a65b:547d%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 08:25:11 +0000
From:   =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
To:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sumitg@nvidia.com" <sumitg@nvidia.com>,
        "sanjayc@nvidia.com" <sanjayc@nvidia.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Thread-Topic: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Thread-Index: AQHZ0Xi9TfPkbDiP9kmQ3+dUnwTXR6//UboAgAGXWACAAAO8AIAAFOYA
Date:   Tue, 29 Aug 2023 08:25:11 +0000
Message-ID: <d0745e1cee9fae33252bb8d3db741c2a463983d6.camel@mediatek.com>
References: <20230818020616.4748-1-chun-jen.tseng@mediatek.com>
         <20230828063904.r7huxclehlblkkjx@vireshk-i7>
         <86f49ce84f32941185c961da8a5c671e7aed46b1.camel@mediatek.com>
         <20230829071022.n7wubb2dhbt3ukyk@vireshk-i7>
In-Reply-To: <20230829071022.n7wubb2dhbt3ukyk@vireshk-i7>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|SEZPR03MB7838:EE_
x-ms-office365-filtering-correlation-id: 7dacb92e-1a30-481b-14e9-08dba8697681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejwTNrsAtDeQDezA0NzQdWuTUyHTKXVPYNI1/FGJEVxwQsMpH6NrY8YgimwJy2NQL6FpLnIDuVtamW6bT7qkmxRy+VhL4HPXDgj89pca6y0QPUhsTVfDEoWm+hPwap5Bp0s+8B5hXkKKY4d3hX+7skO3rZqpMTIe5gFMmP9V7oadFJyzts59jPNWRisBMt4qOkxhbiX3oC3Dgc2+13Sxg11JSoLnUoeNzjE+qh57lOe7kS9nf93qEddoswdFiVDuB1CQfWxUIym9zAOvgfQ+Vgt1rRW85OXmcNlpbdjfIaRtRwp2qDOt7rMdz6qFZgYDiUFnHMpQ8n2wq4QA/ZwCay7i/eX7vF94NYHYu809EGauTfadVC19Bv0VDRa0idWc16GTLK9+G/qe/h7oNfpeiX7ZU4xWl3EAUBfQ0P7J1KSsai4GaYCwBMIU0IKoMGJ+QEs1YqEzD5daJkU8hk7IIVnfFEBX3vkP21FfhcmnX1ZjuzOY+QIzZlBeVpDHwT3YwlZXiwC9OLl24jb4Fk2VH5nHhO/HXuDopm643/Yn4wTD8+FViRYy9uEXFaRI73HdSfuv4PakBcTRVV679uEOqaeUqNP5DlDkRZASOHQyc2FHRjNXS2TxAP4s3MV65KZxTz4mQb20tY0Wq2Bd5VYJhysHZVKGpM4CXbQQKrnjcXtA6NwQmFQuCX0GuGorU+G3SVyHLr6WtIQocGSU3D9WBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199024)(1800799009)(186009)(8676002)(4326008)(5660300002)(8936002)(6506007)(6486002)(53546011)(12101799020)(71200400001)(6512007)(26005)(2616005)(83380400001)(122000001)(478600001)(38100700002)(316002)(6916009)(85182001)(66476007)(54906003)(38070700005)(66946007)(76116006)(66446008)(66556008)(64756008)(91956017)(36756003)(86362001)(2906002)(7416002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3Qrc0dqUlQ4am04SzBxUzNlenE1d2NvNFBpWE9sR0hPOEF5RENCVUM2TjVJ?=
 =?utf-8?B?MEYwWmd1NG45Ympqakhva054Vlk0RlQwOG1RczFrS3FiaTNRUW02Q09OdTBv?=
 =?utf-8?B?NFNPaDY5bVVUMUZjdFpFbzNva3Z4QzF0TWM0MDZ0dDdlb1ZDdC96ZjlJMkxJ?=
 =?utf-8?B?eVp2VHFXUG5jdVdpSi9FL1ZVbzQwd1ZHQmxpaFNvYVVHU3hPNi9LRnJuUTd1?=
 =?utf-8?B?cGhUUHBGVm5DUXhFUDNaUi94bEZGMS9EaUxCdWpEQXB6Z0hpVUlnaUc1MVZr?=
 =?utf-8?B?Q3lCM3kxQSszT3Y5RTJnSDl1VjZLY3o2NGE0OEt5L3UraHBJTzZDNmsxYjRh?=
 =?utf-8?B?YkszOHYvdUF4dk9pRmdudVNwejFvaXFIUVRyd1dZRXRLODU1cC9ObUdmUmdq?=
 =?utf-8?B?UjNQQUxQVjNmMGNqTnpBY05HeXp0eUpDbDhhY2kreVhJWXE2K0V6VTRKdmFW?=
 =?utf-8?B?Q3g3MjE1WHl4NDZrZ2Y4SVNRSGR2d2ZjTXM0NW9pYjJqYW8xNC9sSHR1NVhN?=
 =?utf-8?B?Vm5LdTdTaDFPUWR0dmhNYjJxNGxsSFd5aStDUkw1NzZsNFZwOW5YZ3A3M1hR?=
 =?utf-8?B?VEcyTUVSWHpTSXBMd3pORFhhVWM3VU1TVW9oVVdSRmJOTlVtcGVNVENkd3Uz?=
 =?utf-8?B?bTJXRHBRSG92b3FFcWVvZ0VEODlpR3pIMHdIN0FtY2xSQjM1ck9qSEJlaTlt?=
 =?utf-8?B?S283WURtWXZtMU5YTHVSUUJNdWM0Sm9HVldnRUQyd3hkZ1I0dnBwZVJEZU5J?=
 =?utf-8?B?VGN0T1BXem5WTDlndzdPWFR3ckpjYUFTbmZuMkQwUWNIWllMTm5FVXRvVVF6?=
 =?utf-8?B?L2p2QzdmYnU1RzRPWllTYjNWN3I3R0QvbU1Yd1Z2ZmhqZ3BRSThiRW5DV1FO?=
 =?utf-8?B?Ulh3UDJGUEZCQ3dqRTlxSTY2alhXNTVYTnFhQml2QlJQZlliV012eGZrRk9B?=
 =?utf-8?B?SjAxRjdVbVFuNjRZOVN2YVBjY0ZSREN6MmVObkZlWXVyczRpSVpXc1pLWmFB?=
 =?utf-8?B?dzBoeDBKNXhFMFhVLy9WWTVsY0NrQ21jRDduWVZvZlVzcWpsdHB4WVlBQVNT?=
 =?utf-8?B?OXlqVFJpOHlVd2pYS2wzNFh1TmtHbzVTNi9KTFFlMjlYWXVURWlZVGswQTR1?=
 =?utf-8?B?ZkJlaDlxOW1BYmpaOGVtdU81TXJOekFITE94UTNVL0E1cEdVb0x1bXRuOXZk?=
 =?utf-8?B?YWdzc1p4WTl6NEdDVVpyYTZISFBHRXFGK3BBQy8yVzJicklUVTRoREFtNGgw?=
 =?utf-8?B?MGlzNlBZL05IYUU5aXl3VG5KU1hIeG0rYVhBUkRLenhwaE1PQWNGUE9XZFFx?=
 =?utf-8?B?QnNUakcyd24zaXJ4TkdwV0p4K2FoS01XWmVTV0wzWnBubzBDalEwcVRNVWpv?=
 =?utf-8?B?dFVla3pNY0JNQVJyQ2l3YnBsakJwM2hOd1dpR21uRUxWQzE4anJsNkh5NDky?=
 =?utf-8?B?WVlQS0EwcnljTFpybGtzT1pUSDRQbEM3WVlBc0FtUHNESEJWeDJmRVhKRHZw?=
 =?utf-8?B?V2c5b3dHcm52c2V6WG9YNW5jK0loNXV6Y3FBVGF2U0puRE1JK0N6M1pYbXp5?=
 =?utf-8?B?ekVQZXVJUVN4V1I5cUg4VFFqVHlzZmhGRUNMODZOVEl1ZERQb2ptMi9DLzM0?=
 =?utf-8?B?V3JERmlGVXh3LzNKM0ZIQW1ObVBCYUFIeEkvSThxRk1sK1Z0MUpNWjYxOG1M?=
 =?utf-8?B?bDNkbDdwL1J6cHI5V3BNZTJsS1VNWGNBdC9LeVBtSmdXN2pkaFJNbmxzdjRY?=
 =?utf-8?B?NGNBSjVxNmgvWWpJeWxlZ2tZaHo0WHBPQ0NsbXVVVXVrTW9qT0twYWFRUEM1?=
 =?utf-8?B?KzBlZnM0ZHZwNjlIUmxvZS9jUHpBUHA4WjN0ODFkOFZxaGRZU2U4WCtOYnAz?=
 =?utf-8?B?SVQxYS95d1Q5NFVObExnQWZIU2hEQnJZTXcvU2U2VHZNT2kxQUYrdnUvUnM3?=
 =?utf-8?B?L3lCMW94K2lVQTkycTVBU09oQzNzUjVjRUFJUHgvM0lleE4yMjRFcEhoWnc1?=
 =?utf-8?B?RmtLbFMybkROSTc2TjNjUkkvUnNIWEtGOHRnZDk1dW54bmNRb0tZQ1pHOGpo?=
 =?utf-8?B?RmN5ZFVTTUJIWThKMERlTGhuT0R1c1BvK0RCOERiTm5GTTlGRmppVVRMQ0VI?=
 =?utf-8?B?cTZ5NHVmeXBHNUdPQkF2OGNvQmlaRVl6NkMwVGs5Z244RW1vOXlqUzVwejJu?=
 =?utf-8?Q?6Pl+nY+PhN/h29KXWnaqbMk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81C8078C74C57D48AAB96F6352DDC2E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dacb92e-1a30-481b-14e9-08dba8697681
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 08:25:11.5797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x68AbixUwSeJgQDdI6WuKigxnO8VK+vEzDw7ObNnGt0sW6gJ68jHSM9cdjdH8TPm0jJciaDRoV3rTYAGu8mtXPLFLtYBOuJGI6TJBFOS3GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7838
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTI5IGF0IDEyOjQwICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgDQo+IE9uIDI5LTA4LTIzLCAwNjo1NywgQ2h1bi1KZW4gVHNlbmcgKOab
vuS/iuS7gSkgd3JvdGU6DQo+ID4gRm9yIE1UODE4NiBzZXQgZnJlcSBtdXN0IEJpZyBDUFUgLT4g
TGl0dGxlIENQVSAtPiBDQ0kgbGlrZSB0aGlzDQo+IG9yZGVyDQo+ID4gYW5kIGl0IA0KPiA+IHRh
a2VzIDEwIG1zLg0KPiA+IA0KPiA+IEJ1dCBpbiBjcHVmcmVxICYgZGV2ZnJlcSBmbG93ICwgd2hl
biBCaWcgQ1BVIG9yIExpdHRsZSBDUFUgY2hhbmdlDQo+IGZyZXENCj4gPiAsIGl0IHdpbGwgY2Fs
bA0KPiA+IENDSSBzZXR0aW5nIGJ5IGRpZmZlcmVudCBwb2xpY3kuIEl0IHdpbGwgYmVjb21lIEJp
ZyBDUFUgLT4gQ0NJDQo+IHNldHRpbmcNCj4gPiBvciBMaXR0bGUgQ1BVIC0+DQo+ID4gQ0NJIHNl
dHRpbmcuIEhvd2V2ZXJ5LCBJdCB3aWxsIGNhdXNlIENDSSBzZXR0aW5nIHRvIHdyb25nIHZhbHVl
DQo+IHdoZW4NCj4gPiBwZXIgMW1zIGNhbGwgZ292ZXJub3INCj4gPiBhbmQgY2hhbmdlIGZyZXEu
DQo+ICANCj4gPiB0aGlzIHBhdGNoICg0NDI5NWFmNTAxOWYpICwgZml4ZWQgY3B1ZnJlcV9vdXRf
b2Zfc3luYygpIGNvbmRpdGlvbg0KPiBmcm9tDQo+ID4gMTAwMCBNaHogdG8gMSBNaHouDQo+ID4g
U28sIHdoZW4gY3B1ZnJlcV92ZXJpZnlfY3VycmVudF9mcmVxKCkgY2FsbCBjbGtfZ2V0X3JhdGUo
KSBvdmVyIDENCj4gTWh6LA0KPiA+IGl0IG11c3QgdG8gZG8gZnJlcSBzeW5jDQo+ID4gYnkgY3B1
ZnJlcV9vdXRfb2Zfc3luYygpLiBJbiBNVDgxODYsIGl0IG9mZmVuIG92ZXIgMSBNaHogd2hlbiBj
YWxsDQo+ID4gY2xrX2dldF9yYXRlKCksIHNvIEkgbW9kaWZ5DQo+ID4gdHJhbnNpdGlvbiBkZWxh
eSBmcm9tIDEgbXMgdG8gMTAgbXMgZm9yIG1ha2Ugc3VyZSBmcmVxIHNldHRpbmcNCj4gZG9uZS4g
DQo+ICANCj4gPiBJbiBNVDgxODYsIGlmIENDSSBmcmVxIGlzIGxvd2VyIHRoYW4gQmlnIENQVSBm
cmVxIDcwJSwgaXQgd2lsbA0KPiBjYXVzZXMNCj4gPiBrZXJuZWwgcGFuaWMNCj4gPiBvbiBCaWcg
Q1BVLg0KPiANCj4gT2theSwgSSBnZXQgaXQgbm93LiBGaXJzdCBvZiBhbGwsIHRoZSBrZXJuZWwg
c2hvdWxkbid0IGNyYXNoIGJlY2F1c2UNCj4gb2YgYSBzaW1wbGUgZGVsYXkgYW55d2hlcmUsIGxp
a2UgdGhlIGxhdGVuY3kgZGVsYXkgaGVyZS4gSWYgdGhhdCBpcw0KPiBoYXBwZW5pbmcgaXQgbWVh
bnMgc29tZXRoaW5nIGVsc2UgaXMgd3Jvbmcgc29tZXdoZXJlIGVsc2UuDQo+IA0KPiBGcm9tIHdo
YXQgSSB1bmRlcnN0YW5kIG5vdywgeW91ciBDQ0kgaGF2ZSBhIGNvbnN0cmFpbnQgY29tcGFyZWQg
dG8NCj4gdGhlDQo+IGZyZXF1ZW5jeSBvZiB0aGUgQklHIENQVSAoYW5kIGxpdHRsZSBDUFUgdG9v
KS4gWW91IG5lZWQgc29tZXRoaW5nDQo+IGVsc2UNCj4gdGhhdCBndWFyYW50ZWVzIHRoYXQgdGhl
IENDSSBpcyBhbHdheXMgY29uZmlndXJlZCBpbiB0aGUgcmlnaHQgcmFuZ2UuDQo+IFBlcmhhcHMg
YSBkZXZmcmVxIGdvdmVybm9yIG9yIHNvbWV0aGluZyBlbHNlIHRoYXQgdGFrZXMgY2FyZSBvZiB0
aGlzLg0KPiBJdCBzaGFsbCBldmFsdWF0ZSB0aGUgbmV4dCBzdGF0ZSBiYXNlZCBvbiBib3RoIGJp
ZyBhbmQgbGl0dGxlIENQVQ0KPiBmcmVxdWVuY2llcyBhbmQgbm90IG9ubHkgdGhlIGNhbGxlciB2
aWEgd2hpY2ggd2UgcmVhY2hlZCBDQ0kuIFBsZWFzZQ0KPiBzZWUgaG93IG90aGVycyBoYXZlIHNv
bHZlZCB0aGlzLg0KPiANCj4gSSBhbSB2ZXJ5IHN1cmUgdGhpcyBpcyB3b3JraW5nIGJ5IGNoYW5j
ZSBoZXJlIGFuZCB3aWxsIGJyZWFrIHdpdGgNCj4gc29tZQ0KPiBvdGhlciBkZWxheSBzb21ld2hl
cmUgZWxzZS4gRml4IHRoZSByZWFsIGNhdXNlIG9mIGl0Lg0KPiANCg0KQWN0dWFsbHksIHRoZSBy
b290IGNhdXNlIGlzIHRoZSBDUFUgZnJlcSBzZXR0aW5nIGZpbmlzaCB0aW1lLiBJZiBNVDgxODYN
Cm5lZWRzIDEwIG1zIGZvciB0d28gY2x1c3RlcnMgZmluZGlzaCBzZXR0aW5nIENQVSBjbG9jayBk
b25lLCBJIHNob3VsZA0Kc2V0IHRyYW5zaXRpb24gZGVsYXkgMTAgbXMgd2hpY2ggYXZvaWQgY2Fs
bCBjbGtfZ2V0X3JhdGUoKSBnZXQgcHJldmlvdXMNCmNsb2NrIHZhbHVlLiBJZiBJIGdldCBwcmV2
aW91cyBDUFUgY2xvY2sgYW5kIGl0IG92ZXIgMSBNaHosIHRoZQ0KY3B1ZnJlcV9vdXRfb2Zfc3lu
YygpIHdpbGwgc2V0IENQVSBmcmVxIGFnYWluIGJ1dCBpdCB3cm9uZyBDUFUgZnJlcS4NCg0KSG93
ZXJ2ZXJ5LCB0cmFuc2l0aW9uIGRlbGF5IHNldGluZyBpcyBieSBpbmRpdmlkdWFsIFNvQyAsIGl0
IHNob3VsZCBub3QNCmZvcmNlIDEgbXMgZm9yIGFsbCBTb0MuIFNvLCBJIHdpc2ggSSBjYW4gZG8g
dGhpcyBwYXRjaCBoZXJlLg0KDQoNCj4gLS0gDQo+IHZpcmVzaA0K
