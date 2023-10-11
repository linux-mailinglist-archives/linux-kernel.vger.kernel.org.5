Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF17C486D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbjJKDYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJKDYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:24:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FBC94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:24:30 -0700 (PDT)
X-UUID: ac87dc1667e511ee8051498923ad61e6-20231011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hrMn6VwDao4RotfTYSS1oe3y9/QOwI1YAvraz4lo4fo=;
        b=BvDCivBzWw3B7SRSuj5/3NgZrIPOOT5RgqYPCHIih7HuLuRW1RFFlLdVGU2foyl3+N5rT4iN6IfiMeyKgzL8CJIS1JoYob7Ah7D3UGAyvvBioyxar+wWMmzbhKGDaxeUnMPheqSh/pYvUHBGe6bxInC1BRgWVkAX+tVL2tPxR9E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:bd5485bd-a1be-422a-a555-3fae7623f493,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:e68ffac3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ac87dc1667e511ee8051498923ad61e6-20231011
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 528802514; Wed, 11 Oct 2023 11:24:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Oct 2023 11:24:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Oct 2023 11:24:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5SJG8iHVvyLgexGZ2Ruo6OfvbkRBu/EVUpadyEJsM6Fs32MOpuv2281NaJ19z8YNPJreWfU5ra9APjbb94OEQKqLkIsnXYubFN8o2/S1LTMINCvaFMhzwch0vY8km1gVD5hWvOW/OVVb78lQrfO/BP+ghhinNZmutHA6qAb9b+T4pnpvp3DGm2kDayhdCQWjwcHzWJy0LIMEldt5zDQnDxhP7N3hGatIRvjJarMqXrU50lMaxr7i/tUehw+hcebXsSSTZX4+tPWg+aduTAxUZZOLVHHQRz6zYn/NWL4VsLvNBhy5fuhvbaTQirNgfsZ+o40xGDKpTYR5f5ORL45CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrMn6VwDao4RotfTYSS1oe3y9/QOwI1YAvraz4lo4fo=;
 b=UUZ9+so5nnWhUIIKtV4Qt2JwHaw4BlZ/NrdBGgALEUCj2oIMQPp5hmn1+GuiBg/7qADO9GKBPj0ytrLssHj9mB2LkeaXv9Azw7IQBdtnUmR3yU2twmegiGK+dHKrUvb8LksVq34RGWLoL5W4iFnIha+ksMADEx5w8eHcrpDJrF+MwWyUoK0oWtdOfl50xVWeg4p4eoEScawaaWF5xEm0Mo718CnBbFL7wISge9CMThoJbu7I0NKye2Nwri6bxzxkkfOqywXE+BeaQwFECrTqRaXNy0jd313VjPm6duFSyA+N34ZNJLzQpw1J8xc9E7JM/PdM9HuikXC1gHtbX4qTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrMn6VwDao4RotfTYSS1oe3y9/QOwI1YAvraz4lo4fo=;
 b=MZPShmNBvZkY8fH49wsCipfsWYxy9P2GnbCD6dnKOrwqqM7bYH0uZrGNe3BvXaFr4vrAH9Z8A9LrOIDO3K0v27clPxT9+osc4ztDuPlPP+6w7Du0wRIbDtp9+32gxKT6dS+R/17qtZQ6DCqfduK4RqowA2ynShepr5TGl99Rdpw=
Received: from SI2PR03MB5580.apcprd03.prod.outlook.com (2603:1096:4:12e::5) by
 SEYPR03MB6601.apcprd03.prod.outlook.com (2603:1096:101:87::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.42; Wed, 11 Oct 2023 03:24:20 +0000
Received: from SI2PR03MB5580.apcprd03.prod.outlook.com
 ([fe80::a8c0:4146:462f:76e6]) by SI2PR03MB5580.apcprd03.prod.outlook.com
 ([fe80::a8c0:4146:462f:76e6%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 03:24:19 +0000
From:   =?utf-8?B?S3V5byBDaGFuZyAo5by15bu65paHKQ==?= 
        <Kuyo.Chang@mediatek.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] sched: Fix stop_one_cpu_nowait() vs hotplug
Thread-Topic: [PATCH] sched: Fix stop_one_cpu_nowait() vs hotplug
Thread-Index: AQHZ+7UZCyMf2NfMl0q7ikoQbptwy7BD7WsA
Date:   Wed, 11 Oct 2023 03:24:19 +0000
Message-ID: <172a3c89d7937725b61721e869eab3e5ae582643.camel@mediatek.com>
References: <20230927033431.12406-1-kuyo.chang@mediatek.com>
         <20230927080850.GB21824@noisy.programming.kicks-ass.net>
         <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
         <20230929102135.GD6282@noisy.programming.kicks-ass.net>
         <8ad1b617a1040ce4cc56a5d04e8219b5313a9a6e.camel@mediatek.com>
         <20231010145747.GQ377@noisy.programming.kicks-ass.net>
         <20231010200442.GA16515@noisy.programming.kicks-ass.net>
In-Reply-To: <20231010200442.GA16515@noisy.programming.kicks-ass.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5580:EE_|SEYPR03MB6601:EE_
x-ms-office365-filtering-correlation-id: 37aa33c3-e4c1-4a57-0e5f-08dbca098e98
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bsR5adrleZ/XJHT7H8r8k3jpSWElLvPt5gtZXm80GboFWwWFZIvF/Fm48Uxp2MEdV5LtqdYQqt+Bu/ptBFXbS0kdIJfYqdRmyPQbJXbqfW/ii02D142uWNk3qHo1lQEM2uf4fic4o5YJVRr/C4BPvIUfyM3Taj2lu8MDHd4ewJ4SbwyVi5F539g96sqGNxbnscBe978S1CF4UOiU/UvjWskRArQK0BUe1JU4P+aTc6q1KG6nHc2YNrRDGwU0A9KduAoVf91FIJLBJpGGkrjEqa16EHQOTuXpCac6XrW8l67Ed8wkj9Y38HjMInUenL98X0YrHjH59aRmA/pSDN6Q5H9j3CNZYE3dN1hplJe9YW5EnPlWe+SLONPIa1Myph4KPotzczrBJMX7GHWqxtA77L8UWngPOcgd+OEml0s+OeREYIwt6glAxFJazGjCGws8UZibZknxtWDwGc5McT/PttbuqlVMKWrQIjDwpBlsbHo3kzpp/yXssP5NMeoMQxRo8Wi53PAEnIzrmWumnX8NP+FW4R7SglaEvcT1g3DDfgvYZS3Oop5zAcy0lALoWwi9h1VX6GiP1JzWoBCE6+RMk8Yrt9YLIujero2DzP3I6ZpWZ0AfKnF/qDdtn+6t45757qWXiONqmWFObgy7eVENSFyzoqjaCNWMV34aRmeCbnA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5580.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(85182001)(38100700002)(6506007)(71200400001)(2616005)(478600001)(6486002)(83380400001)(6512007)(122000001)(4001150100001)(2906002)(86362001)(8936002)(8676002)(4326008)(26005)(7416002)(5660300002)(316002)(38070700005)(64756008)(66446008)(6916009)(54906003)(66476007)(66556008)(91956017)(66946007)(41300700001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE1VYTR1SDhUVHArbkx1YnFnVFpOcjd1dDBFZ25zeWtKSWo1clMrbjhQbGE5?=
 =?utf-8?B?dmxTcHlZSmdFbmdpWnRVNm55K01za01BZlVpYVBrUlc3N0lDOFljM1MyZE1F?=
 =?utf-8?B?YjJpWGdNOTNWdmxHeEVmaUtsV1hmQmNzc3ZtM0lsUTE2VmI4azR3Zm0zQzk4?=
 =?utf-8?B?TTc5ZjBtVE5QZW5DZFVYZjdTL09aQXIzTE0wZ3JNUmlHTzlOME9VZ0ZRZGcv?=
 =?utf-8?B?UUxmdmNMNjUrT2dHaVlyak1iZVBsUFdqNFN6REJYc0FCa1l2MjViaFAxRHYx?=
 =?utf-8?B?T1RVbXBIU0hhSkNjS0lBY1A3Mlp1WUtPcUlpVnhtMDdYY3E5RHI1eWJnYldV?=
 =?utf-8?B?VzRRMUx3SUZGUHdFU0hWd09SSFlHc1ZtVHFpT1hHcFg1OURHeWxRK3g3dXor?=
 =?utf-8?B?Y09YbHBNK2hMcDhHYmdRaFlieDFVUFJOK2tTaTFZS0I1czRvNkRzbmljeWh0?=
 =?utf-8?B?cy9xUE1tanBDZXVyNXVmNlVlT3MzSkFxN25oK3VHTmNSWm9tNmJJNCtRSlpo?=
 =?utf-8?B?ckpEM2dHOXpia3RnUDlYL1pYenloQThDaGpUbzcvUmlsR1Z2VlpUOU9pT1I0?=
 =?utf-8?B?V0Y4ZDkrVGJvbTFTbGpvamhJWVdQY3oyUjlPZ2UvVlRyS245dmp0dGlMWWJ6?=
 =?utf-8?B?blhrbjZIcVZjMVJqYU82ZnZ3VzlOSHpxSFVvTWRMR3hTWTJRbUlDVnNQRzVN?=
 =?utf-8?B?OUVkWW82c3hLeHBlTEw4a3gxdDQ0SnlSOW5vMm51dG9OK1RwaEs4L0pZWUlE?=
 =?utf-8?B?ejcySGtnbTl3WFpUOENTeGEzNmd0dWt5Q3pkODZNTmVoWW9RRjJ4aUFWWE1N?=
 =?utf-8?B?YmNpRlAxU2tJZjVHTmg5WndlUGtIMnZ1ZWtpdEF3TTAvUHFhL0k5L2MyWXdN?=
 =?utf-8?B?NWx3ZEtWVjNpbUh1ajhQcXNPWlBCa29jdlVuZ2ozYjhYeTBBWExhUmRDZW5s?=
 =?utf-8?B?TFhZdW5RMHJaQ05YK05tWnV6TDF5NnB0Z1A4NWw5YStsbXBobFJGN0J2Tm5F?=
 =?utf-8?B?aURhWC8raHpTN2tlWlhMRXgvMUlvZnJOcVRHOFhVNC9lamZ2cnZadmphQkFH?=
 =?utf-8?B?dTE0d3hKeHYwdVFDdmRsQ0Z3OFRiby9xRTBFbGRCdEs4ZkIzbkNaQTBGUTZO?=
 =?utf-8?B?cmtRYzk2RFRCQ29taDF2UHFhSUFhNEhTQ0p6clRUbGpNY0R2UC9VL0t4Mkpn?=
 =?utf-8?B?cFdVRnJWRkZkNFNrK1ZCMytBNGxuY2VtMks3VzNhZC9nYXRDSFJxOUI1UHFy?=
 =?utf-8?B?YzBHa0IvcG1JdzNNQk5zeVdMeDlibVVlei9TL3puK3VlUndNSEd0ZnpYQnlD?=
 =?utf-8?B?K0VVcnpNcTdGTVB6alF5ek1RTmZWRlVVQUZIZjE4ZkFVLy8yNDkyTlU2d3Zz?=
 =?utf-8?B?L05zbStZYitOYU9RSVgyMjYxM1pXQUJxRFFPZjNhWHRaSmt2b2REdUkvaFVj?=
 =?utf-8?B?NzYydk5xMzhQQ1VQajJFbWpLOE9uaGpWNDJQeFlJamRqbG5hTER4RTNIcjlF?=
 =?utf-8?B?R0w2SnFLRTFDYVVuNitrNGszVm9CZnhVek91U1E5TVdIbFh5d1prRUUrRGow?=
 =?utf-8?B?T0svNXZla2dTK3RCSnlVVys0Zit2VW0xOFNCL2xLazliODZIWVF6S3d1NDdY?=
 =?utf-8?B?SEVPZkUwYzZQaVZFd0gxZ05ucnM5RHo0dEFPa1VuUGVPd2xsbGpXanhJK3hQ?=
 =?utf-8?B?aHVWVTMzMndrMldKb1J4VnltSENCbk5LeXVXalJBQUVTdU54RWlaTzlwWXRz?=
 =?utf-8?B?djA4aGU5Ry9IZW5DSy9kaWk4YTBDYXhFelF3bmkxZml5VWJmZldmaEl4TUdS?=
 =?utf-8?B?aHdqZU9LWmZHOEVlUVFKdUlaK3l6d0FyUFhOa1R1aTdIOW1qWjZvUENzelFN?=
 =?utf-8?B?UXE5OWkxcU96MGVXREZNU3p4b292VVU0eS9sbysxQTIwa1I1WW4rK3ZkQ0Ri?=
 =?utf-8?B?dHQyQlRnN2ZYeFpPdU5CL0tzUDhRR1JKMjh3M2k0VDFuWTFRWlhzYjUrK1Ir?=
 =?utf-8?B?V2pMUk5pb0ZTYThzc3hNQzJNM2xOdmJLa3JqYXBwTVlremkyY2lMemZjY0JN?=
 =?utf-8?B?L3lMSHYwK3p3ZFpIWWp1WUJCQmFwQjBPNmk3dldDOGZ3emdSamIrdnRUbitY?=
 =?utf-8?B?bW9tOUtrUVpPWStRMDJFcW1rT01iUGFtdkdVcmNjQ1hoRG9DbFpPU1o1Zlp4?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <250974B270176046A0F4B98824CACAE6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5580.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa33c3-e4c1-4a57-0e5f-08dbca098e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 03:24:19.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xtKVdbwSDSLloASxwreoc90vxUV2Ma8yVnM1Z6DtgJLebQE17QtE9h//dvqVZ31I0MQgz7nk9GVPviB3QqPWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6601
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDIyOjA0ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBUdWUsIE9jdCAxMCwgMjAyMyBhdCAwNDo1Nzo0N1BNICswMjAw
LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gPiBPbiBUdWUsIE9jdCAxMCwgMjAyMyBhdCAwMjo0
MDoyMlBNICswMDAwLCBLdXlvIENoYW5nICjlvLXlu7rmlocpIHdyb3RlOg0KPiANCj4gPiA+IEl0
IGlzIHJ1bm5pbmcgZ29vZCBzbyBmYXIobW9yZSB0aGFuIGEgd2VlaylvbiBob3RwbHVnL3NldA0K
PiBhZmZpbml0eQ0KPiA+ID4gc3RyZXNzIHRlc3QuIEkgd2lsbCBrZWVwIGl0IHRlc3RpbmcgYW5k
IHJlcG9ydCBiYWNrIGlmIGl0IGhhcHBlbnMNCj4gPiA+IGFnYWluLg0KPiA+IA0KPiA+IE9LLCBJ
IHN1cHBvc2UgSSBzaG91bGQgbG9vayBhdCB3cml0aW5nIGEgY29oZXJlbnQgQ2hhbmdlbG9nIGZv
cg0KPiB0aGlzDQo+ID4gdGhlbi4uLg0KPiANCj4gU29tZXRoaW5nIGxpa2UgdGhlIGJlbG93Li4u
ID8NCj4gDQpUaGFua3MgZm9yIGlsbHVzdHJhdGUgdGhlIHJhY2Ugc2NlbmFyaW8uIEl0IGxvb2tz
IGdvb2QgdG8gbWUuDQpCdXQgaG93IGFib3V0IFJUPyBEb2VzIFJUIGFsc28gbmVlZCB0aGlzIGlu
dm9jYXRpb25zIGFzIGJlbG93Pw0KDQotLS0NCiBrZXJuZWwvc2NoZWQvcnQuYyB8IDQgKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9z
Y2hlZC9ydC5jIGIva2VybmVsL3NjaGVkL3J0LmMNCmluZGV4IGU5M2I2OWVmOTE5Yi4uNmFhZjBh
M2Q2MDgxIDEwMDY0NA0KLS0tIGEva2VybmVsL3NjaGVkL3J0LmMNCisrKyBiL2tlcm5lbC9zY2hl
ZC9ydC5jDQpAQCAtMjA2Myw5ICsyMDYzLDExIEBAIHN0YXRpYyBpbnQgcHVzaF9ydF90YXNrKHN0
cnVjdCBycSAqcnEsIGJvb2wNCnB1bGwpDQogICAgICAgICAgICAgICAgICovDQogICAgICAgICAg
ICAgICAgcHVzaF90YXNrID0gZ2V0X3B1c2hfdGFzayhycSk7DQogICAgICAgICAgICAgICAgaWYg
KHB1c2hfdGFzaykgew0KKyAgICAgICAgICAgICAgICAgICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7
DQogICAgICAgICAgICAgICAgICAgICAgICByYXdfc3Bpbl9ycV91bmxvY2socnEpOw0KICAgICAg
ICAgICAgICAgICAgICAgICAgc3RvcF9vbmVfY3B1X25vd2FpdChycS0+Y3B1LCBwdXNoX2NwdV9z
dG9wLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdXNoX3Rh
c2ssICZycS0+cHVzaF93b3JrKTsNCisgICAgICAgICAgICAgICAgICAgICAgIHByZWVtcHRfZW5h
YmxlKCk7DQogICAgICAgICAgICAgICAgICAgICAgICByYXdfc3Bpbl9ycV9sb2NrKHJxKTsNCiAg
ICAgICAgICAgICAgICB9DQoNCkBAIC0yNDAyLDkgKzI0MDQsMTEgQEAgc3RhdGljIHZvaWQgcHVs
bF9ydF90YXNrKHN0cnVjdCBycSAqdGhpc19ycSkNCiAgICAgICAgICAgICAgICBkb3VibGVfdW5s
b2NrX2JhbGFuY2UodGhpc19ycSwgc3JjX3JxKTsNCg0KICAgICAgICAgICAgICAgIGlmIChwdXNo
X3Rhc2spIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHByZWVtcHRfZGlzYWJsZSgpOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgcmF3X3NwaW5fcnFfdW5sb2NrKHRoaXNfcnEpOw0KICAgICAg
ICAgICAgICAgICAgICAgICAgc3RvcF9vbmVfY3B1X25vd2FpdChzcmNfcnEtPmNwdSwgcHVzaF9j
cHVfc3RvcCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHVz
aF90YXNrLCAmc3JjX3JxLQ0KPnB1c2hfd29yayk7DQorICAgICAgICAgICAgICAgICAgICAgICBw
cmVlbXB0X2VuYWJsZSgpOw0KICAgICAgICAgICAgICAgICAgICAgICAgcmF3X3NwaW5fcnFfbG9j
ayh0aGlzX3JxKTsNCiAgICAgICAgICAgICAgICB9DQogICAgICAgIH0NCg0KPiAtLS0NCj4gU3Vi
amVjdDogc2NoZWQ6IEZpeCBzdG9wX29uZV9jcHVfbm93YWl0KCkgdnMgaG90cGx1Zw0KPiBGcm9t
OiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IERhdGU6IFR1ZSBPY3Qg
MTAgMjA6NTc6MzkgQ0VTVCAyMDIzDQo+IA0KPiBLdXlvIHJlcG9ydGVkIHNwb3JhZGljIGZhaWx1
cmVzIG9uIGEgc2NoZWRfc2V0YWZmaW5pdHkoKSB2cyBDUFUNCj4gaG90cGx1ZyBzdHJlc3MtdGVz
dCAtLSBub3RhYmx5IGFmZmluZV9tb3ZlX3Rhc2soKSByZW1haW5zIHN0dWNrIGluDQo+IHdhaXRf
Zm9yX2NvbXBsZXRpb24oKSwgbGVhZGluZyB0byBhIGh1bmctdGFzayBkZXRlY3RvciB3YXJuaW5n
Lg0KPiANCj4gU3BlY2lmaWNhbGx5LCBpdCB3YXMgcmVwb3J0ZWQgdGhhdCBzdG9wX29uZV9jcHVf
bm93YWl0KC5mbiA9DQo+IG1pZ3JhdGlvbl9jcHVfc3RvcCkgcmV0dXJucyBmYWxzZSAtLSB0aGlz
IHN0b3BwZXIgaXMgcmVzcG9uc2libGUgZm9yDQo+IHRoZSBtYXRjaGluZyBjb21wbGV0ZSgpLg0K
PiANCj4gVGhlIHJhY2Ugc2NlbmFyaW8gaXM6DQo+IA0KPiBDUFUwQ1BVMQ0KPiANCj4gLy8gZG9p
bmcgX2NwdV9kb3duKCkNCj4gDQo+ICAgX19zZXRfY3B1c19hbGxvd2VkX3B0cigpDQo+ICAgICB0
YXNrX3JxX2xvY2soKTsNCj4gdGFrZWRvd25fY3B1KCkNCj4gICBzdG9wX21hY2hpbmVfY3B1c2xv
Y2tlZCh0YWtlX2NwdV9kb3duLi4pDQo+IA0KPiA8UFJFRU1QVDogY3B1X3N0b3BwZXJfdGhyZWFk
KCkNCj4gICBNVUxUSV9TVE9QX1BSRVBBUkUNCj4gICAuLi4NCj4gICAgIF9fc2V0X2NwdXNfYWxs
b3dlZF9wdHJfbG9ja2VkKCkNCj4gICAgICAgYWZmaW5lX21vdmVfdGFzaygpDQo+ICAgICAgICAg
dGFza19ycV91bmxvY2soKTsNCj4gDQo+ICAgPFBSRUVNUFQ6IGNwdV9zdG9wcGVyX3RocmVhZCgp
XD4gDQo+ICAgICBhY2tfc3RhdGUoKQ0KPiAgIE1VTFRJX1NUT1BfUlVODQo+ICAgICB0YWtlX2Nw
dV9kb3duKCkNCj4gICAgICAgX19jcHVfZGlzYWJsZSgpOw0KPiAgICAgICBzdG9wX21hY2hpbmVf
cGFyaygpOw0KPiBzdG9wcGVyLT5lbmFibGVkID0gZmFsc2U7DQo+ICAvPg0KPiAgICAvPg0KPiBz
dG9wX29uZV9jcHVfbm93YWl0KC5mbiA9IG1pZ3JhdGlvbl9jcHVfc3RvcCk7DQo+ICAgICAgICAg
ICBpZiAoc3RvcHBlci0+ZW5hYmxlZCkgLy8gZmFsc2UhISENCj4gDQo+IA0KPiBUaGF0IGlzLCBi
eSBkb2luZyBzdG9wX29uZV9jcHVfbm93YWl0KCkgYWZ0ZXIgZHJvcHBpbmcgcnEtbG9jaywgdGhl
DQo+IHN0b3BwZXIgdGhyZWFkIGdldHMgYSBjaGFuY2UgdG8gcHJlZW1wdCBhbmQgYWxsb3dzIHRo
ZSBjcHUtZG93biBmb3INCj4gdGhlIHRhcmdldCBDUFUgdG8gY29tcGxldGUuDQo+IA0KPiBPVE9I
LCBzaW5jZSBzdG9wX29uZV9jcHVfbm93YWl0KCkgLyBjcHVfc3RvcF9xdWV1ZV93b3JrKCkgbmVl
ZHMgdG8NCj4gaXNzdWUgYSB3YWtldXAsIGl0IG11c3Qgbm90IGJlIHJhbiB1bmRlciB0aGUgc2No
ZWR1bGVyIGxvY2tzLg0KPiANCj4gU29sdmUgdGhpcyBhcHBhcmVudCBjb250cmFkaWN0aW9uIGJ5
IGtlZXBpbmcgcHJlZW1wdGlvbiBkaXNhYmxlZCBvdmVyDQo+IHRoZSB1bmxvY2sgKyBxdWV1ZV9z
dG9wcGVyIGNvbWJpbmF0aW9uOg0KPiANCj4gcHJlZW1wdF9kaXNhYmxlKCk7DQo+IHRhc2tfcnFf
dW5sb2NrKC4uLik7DQo+IGlmICghc3RvcF9wZW5kaW5nKQ0KPiAgIHN0b3Bfb25lX2NwdV9ub3dh
aXQoLi4uKQ0KPiBwcmVlbXB0X2VuYWJsZSgpOw0KPiANCj4gVGhpcyByZXNwZWN0cyB0aGUgbG9j
ayBvcmRlcmluZyBjb250cmFpbnRzIHdoaWxlIHN0aWxsIGF2b2lkaW5nIHRoZQ0KPiBhYm92ZSBy
YWNlLiBUaGF0IGlzLCBpZiB3ZSBmaW5kIHRoZSBDUFUgaXMgb25saW5lIHVuZGVyIHJxLWxvY2ss
IHRoZQ0KPiB0YXJnZXRlZCBzdG9wX29uZV9jcHVfbm93YWl0KCkgbXVzdCBzdWNjZWVkLg0KPiAN
Cj4gQXBwbHkgdGhpcyBwYXR0ZXJuIHRvIGFsbCBzaW1pbGFyIHN0b3Bfb25lX2NwdV9ub3dhaXQo
KSBpbnZvY2F0aW9ucy4NCj4gDQo+IEZpeGVzOiA2ZDMzN2VhYjA0MWQgKCJzY2hlZDogRml4IG1p
Z3JhdGVfZGlzYWJsZSgpIHZzDQo+IHNldF9jcHVzX2FsbG93ZWRfcHRyKCkiKQ0KPiBSZXBvcnRl
ZC1ieTogIkt1eW8gQ2hhbmcgKOW8teW7uuaWhykiIDxLdXlvLkNoYW5nQG1lZGlhdGVrLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+DQo+IFRlc3RlZC1ieTogIkt1eW8gQ2hhbmcgKOW8teW7uuaWhykiIDxLdXlvLkNoYW5n
QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBrZXJuZWwvc2NoZWQvY29yZS5jICAgICB8ICAgMTAg
KysrKysrKystLQ0KPiAga2VybmVsL3NjaGVkL2RlYWRsaW5lLmMgfCAgICAyICsrDQo+ICBrZXJu
ZWwvc2NoZWQvZmFpci5jICAgICB8ICAgIDQgKysrLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0tIGEva2VybmVsL3NjaGVkL2Nv
cmUuYw0KPiArKysgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+IEBAIC0yNjQ1LDkgKzI2NDUsMTEg
QEAgc3RhdGljIGludCBtaWdyYXRpb25fY3B1X3N0b3Aodm9pZCAqZGF0YQ0KPiAgICogaXQuDQo+
ICAgKi8NCj4gIFdBUk5fT05fT05DRSghcGVuZGluZy0+c3RvcF9wZW5kaW5nKTsNCj4gK3ByZWVt
cHRfZGlzYWJsZSgpOw0KPiAgdGFza19ycV91bmxvY2socnEsIHAsICZyZik7DQo+ICBzdG9wX29u
ZV9jcHVfbm93YWl0KHRhc2tfY3B1KHApLCBtaWdyYXRpb25fY3B1X3N0b3AsDQo+ICAgICAgJnBl
bmRpbmctPmFyZywgJnBlbmRpbmctPnN0b3Bfd29yayk7DQo+ICtwcmVlbXB0X2VuYWJsZSgpOw0K
PiAgcmV0dXJuIDA7DQo+ICB9DQo+ICBvdXQ6DQo+IEBAIC0yOTY3LDEyICsyOTY5LDEzIEBAIHN0
YXRpYyBpbnQgYWZmaW5lX21vdmVfdGFzayhzdHJ1Y3QgcnEgKnINCj4gIGNvbXBsZXRlID0gdHJ1
ZTsNCj4gIH0NCj4gIA0KPiArcHJlZW1wdF9kaXNhYmxlKCk7DQo+ICB0YXNrX3JxX3VubG9jayhy
cSwgcCwgcmYpOw0KPiAtDQo+ICBpZiAocHVzaF90YXNrKSB7DQo+ICBzdG9wX29uZV9jcHVfbm93
YWl0KHJxLT5jcHUsIHB1c2hfY3B1X3N0b3AsDQo+ICAgICAgcCwgJnJxLT5wdXNoX3dvcmspOw0K
PiAgfQ0KPiArcHJlZW1wdF9lbmFibGUoKTsNCj4gIA0KPiAgaWYgKGNvbXBsZXRlKQ0KPiAgY29t
cGxldGVfYWxsKCZwZW5kaW5nLT5kb25lKTsNCj4gQEAgLTMwMzgsMTIgKzMwNDEsMTMgQEAgc3Rh
dGljIGludCBhZmZpbmVfbW92ZV90YXNrKHN0cnVjdCBycSAqcg0KPiAgaWYgKGZsYWdzICYgU0NB
X01JR1JBVEVfRU5BQkxFKQ0KPiAgcC0+bWlncmF0aW9uX2ZsYWdzICY9IH5NREZfUFVTSDsNCj4g
IA0KPiArcHJlZW1wdF9kaXNhYmxlKCk7DQo+ICB0YXNrX3JxX3VubG9jayhycSwgcCwgcmYpOw0K
PiAtDQo+ICBpZiAoIXN0b3BfcGVuZGluZykgew0KPiAgc3RvcF9vbmVfY3B1X25vd2FpdChjcHVf
b2YocnEpLCBtaWdyYXRpb25fY3B1X3N0b3AsDQo+ICAgICAgJnBlbmRpbmctPmFyZywgJnBlbmRp
bmctPnN0b3Bfd29yayk7DQo+ICB9DQo+ICtwcmVlbXB0X2VuYWJsZSgpOw0KPiAgDQo+ICBpZiAo
ZmxhZ3MgJiBTQ0FfTUlHUkFURV9FTkFCTEUpDQo+ICByZXR1cm4gMDsNCj4gQEAgLTk0NTksOSAr
OTQ2MywxMSBAQCBzdGF0aWMgdm9pZCBiYWxhbmNlX3B1c2goc3RydWN0IHJxICpycSkNCj4gICAq
IFRlbXBvcmFyaWx5IGRyb3AgcnEtPmxvY2sgc3VjaCB0aGF0IHdlIGNhbiB3YWtlLXVwIHRoZSBz
dG9wIHRhc2suDQo+ICAgKiBCb3RoIHByZWVtcHRpb24gYW5kIElSUXMgYXJlIHN0aWxsIGRpc2Fi
bGVkLg0KPiAgICovDQo+ICtwcmVlbXB0X2Rpc2FibGUoKTsNCj4gIHJhd19zcGluX3JxX3VubG9j
ayhycSk7DQo+ICBzdG9wX29uZV9jcHVfbm93YWl0KHJxLT5jcHUsIF9fYmFsYW5jZV9wdXNoX2Nw
dV9zdG9wLCBwdXNoX3Rhc2ssDQo+ICAgICAgdGhpc19jcHVfcHRyKCZwdXNoX3dvcmspKTsNCj4g
K3ByZWVtcHRfZW5hYmxlKCk7DQo+ICAvKg0KPiAgICogQXQgdGhpcyBwb2ludCBuZWVkX3Jlc2No
ZWQoKSBpcyB0cnVlIGFuZCB3ZSdsbCB0YWtlIHRoZSBsb29wIGluDQo+ICAgKiBzY2hlZHVsZSgp
LiBUaGUgbmV4dCBwaWNrIGlzIG9idmlvdXNseSBnb2luZyB0byBiZSB0aGUgc3RvcCB0YXNrDQo+
IC0tLSBhL2tlcm5lbC9zY2hlZC9kZWFkbGluZS5jDQo+ICsrKyBiL2tlcm5lbC9zY2hlZC9kZWFk
bGluZS5jDQo+IEBAIC0yNDIwLDkgKzI0MjAsMTEgQEAgc3RhdGljIHZvaWQgcHVsbF9kbF90YXNr
KHN0cnVjdCBycSAqdGhpcw0KPiAgZG91YmxlX3VubG9ja19iYWxhbmNlKHRoaXNfcnEsIHNyY19y
cSk7DQo+ICANCj4gIGlmIChwdXNoX3Rhc2spIHsNCj4gK3ByZWVtcHRfZGlzYWJsZSgpOw0KPiAg
cmF3X3NwaW5fcnFfdW5sb2NrKHRoaXNfcnEpOw0KPiAgc3RvcF9vbmVfY3B1X25vd2FpdChzcmNf
cnEtPmNwdSwgcHVzaF9jcHVfc3RvcCwNCj4gICAgICBwdXNoX3Rhc2ssICZzcmNfcnEtPnB1c2hf
d29yayk7DQo+ICtwcmVlbXB0X2VuYWJsZSgpOw0KPiAgcmF3X3NwaW5fcnFfbG9jayh0aGlzX3Jx
KTsNCj4gIH0NCj4gIH0NCj4gLS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiArKysgYi9rZXJu
ZWwvc2NoZWQvZmFpci5jDQo+IEBAIC0xMTI5OSwxMyArMTEyOTksMTUgQEAgc3RhdGljIGludCBs
b2FkX2JhbGFuY2UoaW50IHRoaXNfY3B1LCBzdA0KPiAgYnVzaWVzdC0+cHVzaF9jcHUgPSB0aGlz
X2NwdTsNCj4gIGFjdGl2ZV9iYWxhbmNlID0gMTsNCj4gIH0NCj4gLXJhd19zcGluX3JxX3VubG9j
a19pcnFyZXN0b3JlKGJ1c2llc3QsIGZsYWdzKTsNCj4gIA0KPiArcHJlZW1wdF9kaXNhYmxlKCk7
DQo+ICtyYXdfc3Bpbl9ycV91bmxvY2tfaXJxcmVzdG9yZShidXNpZXN0LCBmbGFncyk7DQo+ICBp
ZiAoYWN0aXZlX2JhbGFuY2UpIHsNCj4gIHN0b3Bfb25lX2NwdV9ub3dhaXQoY3B1X29mKGJ1c2ll
c3QpLA0KPiAgYWN0aXZlX2xvYWRfYmFsYW5jZV9jcHVfc3RvcCwgYnVzaWVzdCwNCj4gICZidXNp
ZXN0LT5hY3RpdmVfYmFsYW5jZV93b3JrKTsNCj4gIH0NCj4gK3ByZWVtcHRfZW5hYmxlKCk7DQo+
ICB9DQo+ICB9IGVsc2Ugew0KPiAgc2QtPm5yX2JhbGFuY2VfZmFpbGVkID0gMDsNCg==
