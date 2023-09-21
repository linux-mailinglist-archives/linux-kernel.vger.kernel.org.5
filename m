Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D297A9EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjIUUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjIUUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:13:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02058099;
        Thu, 21 Sep 2023 10:19:04 -0700 (PDT)
X-UUID: 31836e40588b11ee8051498923ad61e6-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Y4EEzlQmC3aKGXWFEAa1rmxs0XA1YJ2PmOPQBusZeAY=;
        b=lFGXFzxJMYGugQuo4NkNWuWC7uXAdR4Bl7THIINXDVUxivp4kmjGe7/xKEAQLgrW8jML6ZwwHYwKp1TT+uZ+YEpfx1u0i8Cmh//rXhAdQPWAZxH4VorOo6EBXS/5e1b8erWRXaljCyzvVQK7iD3zarb+F3T6GKEGtsNHqEaTMV0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ba9f76f5-30be-4051-97e6-d796b51cd9e5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:abae3614-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 31836e40588b11ee8051498923ad61e6-20230921
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 747555200; Thu, 21 Sep 2023 22:28:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 22:28:53 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 22:28:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGbZC5smzlqTbhNjyx6BToJ0BBYyWOZgd2yIBjBY6l9aLz+F5CD5uGcFRXVKWgV7anjJvcm+n3tLUb0q46U6ylh9R99+5N1Xk7FCkr0dWrq/kB1p//KeNM+dkqKLCYR3XkTO+9dmkrL+x3i4sSOPVUXLIjcYUfTOI9FM4/CnutMyJ9LCDPuK/HS6QbgxJ5/GWlcK0m0aazBNBf67/FmW3qFWfnP/6SzLXF84AjWsXdqA0w16S+Hx5uJuutJpPMK7UV/yZTKjHXyM+KnxNOsD7fYhNqbFDY2c3gZLFKSzDVnjtUldvoo2x6AqUmyPIqzgRwm1mt22IBuoqD4g73tYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4EEzlQmC3aKGXWFEAa1rmxs0XA1YJ2PmOPQBusZeAY=;
 b=HS/Vi6YSixuNGq7n9PEGgjDaubARJ3Ib8eWQX2VXmFweEdS628E0jInIA8EKzSbWLdpx0zmU8xjO1YvXJsJMLxNtlzDZ6J4nvmzcX4K0sRGu1Iwxwot54rWu8IQVa5IK5koM5ha7K2Qq9TrFz33UhIM9vBSbuYndQRVCz1OiBj9aLrYf3lAbwlJkbPkwGE9WCcM0nyKqwXXUxkQ55kUMMAzrgmDBX0Nkk9LGV0aCPffc7CV205EQAlERNJ8UW44SOCUKDFqznycXWbZdlD6W/RJHr3qf9gRvKfbpljS4htxEoDQu+ICT+8VJwU52Dy56wZ/xMlVMWEVCNeEs+ud3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4EEzlQmC3aKGXWFEAa1rmxs0XA1YJ2PmOPQBusZeAY=;
 b=vjBVEpt4Pn88G7JKq41tf2hZJQd1AOEan/IQC+CHQPm8F2rI0Z3hAKTRiFpvXrjBnSJi174Wd4FuGdBfIhQU58hcEEZXqk1daxPo8g+ETTk+aNkYF8FmC1U36RFUL7jTR4T7o2imxMc8PDBsnJzqUgE4A0RfooX/r5TmbZ3/Zmw=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB8158.apcprd03.prod.outlook.com (2603:1096:400:471::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29; Thu, 21 Sep
 2023 14:28:51 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:28:51 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 11/15] soc: mediatek: Add cmdq_insert_backup_cookie before
 EOC for secure pkt
Thread-Topic: [PATCH 11/15] soc: mediatek: Add cmdq_insert_backup_cookie
 before EOC for secure pkt
Thread-Index: AQHZ6mWECSNhxYO6UEKJWBycxx0b5bAhd0sAgAPjygA=
Date:   Thu, 21 Sep 2023 14:28:51 +0000
Message-ID: <c0357d53f6a8a4abbe7a869514bf3f13e74500b2.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-12-jason-jh.lin@mediatek.com>
         <2d12673fbbd62a14e3108ce92230c90d4e5c75c2.camel@mediatek.com>
In-Reply-To: <2d12673fbbd62a14e3108ce92230c90d4e5c75c2.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB8158:EE_
x-ms-office365-filtering-correlation-id: 2767715c-d9c6-4274-ecd3-08dbbaaf139a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKYqaMywvH1OlNFajI+J30Ue9KCPN/diPwCqlZPppHSKcwRM2E5HF9dJs5AwJicfnFrl6Zw3+KKCo6jpLSC8yVEvns2+LdWMhDfItc5VQ4vqjrDyRhXDPs+yZjVPrPbWGlr1gkPtgGTWNlQbAa8/GSjDV0fs2COia3FhkrMmLYY/3SHkGVLsVoERhG/fw4YRE2ZMUVpgkF84kdV4ttpkFfo4rtTK8JweST+a1cWeYRje8FM5NGCA1E3xq7mUNnkDHProyfLivDi89U++81/s9Bvur7rq1HTPWA1RE1rIlJH//YlEaXivi1pb0halBffmzqjqy1bL5uI9AEQ8qERJMot+3wG26zBlcNM+9+ARLPfQKLSAuIRqyWQOSNQMA/QKTLXCKsHDXYXl67FHCNQVzx5EzXXgpz+E3Z7mDKL/mKA40xsxkfj85xsCSftZ0gHHhEKxQ9/zkXP/12TikzP4yBvDH9XjcnuxntxI9Z0QQpK+CHVKUEMoVMS0sFrOgX2IV3W/lqMOUEyXiBoyfqUODJ0hJLvIM+dJsp+8mFv/NdYT/HgnbfmEDxaOchWe+1xksYPNXz6VcE3A7oc9+rVZ2BhEwpVLUam4ZQxxLAmZLieVvhXdidOy+eyCTuTX7gWxlGV60NdRZeXVdiPNkjPoVaHvyIdg+fNKS1kpNxs5sa8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(1800799009)(451199024)(186009)(64756008)(54906003)(316002)(66556008)(91956017)(66946007)(66476007)(110136005)(66446008)(76116006)(26005)(107886003)(38070700005)(6506007)(36756003)(71200400001)(6486002)(6512007)(2616005)(38100700002)(86362001)(122000001)(85182001)(478600001)(2906002)(7416002)(5660300002)(8936002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTAyQkNmRVRGZ0JOa1ZNb1Y0cGZJeXVyR0Z2TXd3RFc4RXNaWW5zOFA4Ym8r?=
 =?utf-8?B?MW1ESDZkUlErTWhscS9NQkljM3hUdUVjZmptM29STWh1bkg0dlR1MHdxOGtD?=
 =?utf-8?B?U2pDd21JQ0RjUExEV2d1NkxEdVVobDBPY1kxdXAwdnNIb3VHMWJua3ZpWVg4?=
 =?utf-8?B?SkRQdjNUTFNGL0grbTNGK1NndXpobWtPY2xsL1lFelRSakNmcUwvOEZRanZG?=
 =?utf-8?B?UU14NTVkL3pNYVE1TVBoR1lBdHFPRlV1TDl2Rzg0NFBnVlgzeHlxWkNYMGpL?=
 =?utf-8?B?ZTkyUEk2T2Z2ZmpzSnJMYUUxUlhYcTZDcXN5bVFUSDY4OTZmMGNiQitGaDFH?=
 =?utf-8?B?Q0FHY3AxT2hXRkFFbURaOTVUcXAvWXVvVVJxTHZFZUlXc2RGd2JZMW1oRE1Z?=
 =?utf-8?B?Uk5IZFJHb2d0TVFqWWs2NklvRko2MUkza1hpeFNDdWEraXROUy80Q1lFbkhq?=
 =?utf-8?B?VytIZUt4N29BalZpaXQxWXl6eWZzeDdYSW1UUXZZdllmdDVWSWpUME5WN1Vk?=
 =?utf-8?B?OC9ncVdKaVVhUy9VdXlhZ3p4R2JGajVOeGYvaTJ0d0V2Wll4dERZbkFndjh2?=
 =?utf-8?B?Vm43ZkhITTRkKzE5MmoycTZxVSs3dW9lQmxRRGwzUWE1RFZTMk5QSWFnamdD?=
 =?utf-8?B?Z1ptMm1HdTFFWFU2R0xVMlRNV1V6WVdieXdSRk50RDFOdmFoVjVteWltdEU5?=
 =?utf-8?B?THVkdzZaM2JkdUNyUmMvWFg5ZHA3ZjNFS0tER3NjWVcwZW1QZmc2anh1WnBs?=
 =?utf-8?B?bldTdnU4S3lmbFQ5WVp5N2JlQ3prdnRyQUEyZS9wK29Ic2ZOQmVrMXpmdHRK?=
 =?utf-8?B?cS9yeVA5dTZHK2lET3ZMbHo0REdvVk5CK0JWQnY1V0pTYzkvODd3M3RYaHJw?=
 =?utf-8?B?MEVnSjVyTEpUSi9oNCt6WWtnank3K1I2aWEveE5jWGZIRGQ0cHpGZCswVnc0?=
 =?utf-8?B?Q0JmRFR2dUdKNWpOOEJMb25za2pIZmtTc2NpRWcrcnhuUjAxMjNQa0YrSjF0?=
 =?utf-8?B?eTNiankxZzgxQ2RZOEJIMWhQSTRqMUlyaEFjM25oT3I3TG05RjhOcFpBUGVo?=
 =?utf-8?B?dFdmYzl4cVUxRWlLcVYxcGs1c1A0RXhZUVV1Q3NFTEtMQ3k2dGpFTWJ2QnNQ?=
 =?utf-8?B?TnlneGtMZm9NYmxZbEJKK1J0ZzVxZmZHRVgrenhtZldEbkdSUnVHaFZvMjcw?=
 =?utf-8?B?cjZta3lYODBqZm9MMG9WNmM4bGM2Y0ZPZld5TFFnY0hIczhsQzc2T3l1QmhT?=
 =?utf-8?B?ekJtcDNLNXVJbm0vTjdmaXhEeGtOc09YZFZHUTNSRVphMUp2VUJyWkZENFRF?=
 =?utf-8?B?ZUhrSU1TY2lQNWxsSGxDZWlVek1IQjNXekpyV0d5MTlIaklVZVMySmtIc3d6?=
 =?utf-8?B?UTNVdUdLNDNYL2dDc3hWeWFtMHF2dEdaNWM4RlluTm9vdXhmd3BId2JZeHpm?=
 =?utf-8?B?RFhWcEp1eVYzOFkzd3QxWDlvMkUybVRmUGQvWThucU1sQ1BYMVUwenNnbGpM?=
 =?utf-8?B?QkI3bW42alNvVjQrYjUrY0lzeWJqNVF0ZllTYWM0cVFuVGRlakhib0xvT3Bj?=
 =?utf-8?B?THhqelovbnhCS1c1VjNUYWl2dDYyV1VESnlXMzYzSWhkNDJtUmtKM0dvd24x?=
 =?utf-8?B?NjFwK09QbzVjZVBUbG85RVBkVExRMGhhQkx1RlljVDZDYjM1RzNvTWtRYm53?=
 =?utf-8?B?KzB4V1BkRG1zNTR3TUlWNEF5QjAyS1ZJUE1hQnBsTnBpcWhET2U0OWV2VmY3?=
 =?utf-8?B?TW5JT1RmeGtoeXg0NXFud1I2dVdjWFUxOEQxVDFYWU1CRVk0bXYrOG9pSkFu?=
 =?utf-8?B?OHVXOW1oSG9rYWptT1hxYkxzSk14cjRkYVVhNk1HWi9OUGU5UVZhRkpWNkxO?=
 =?utf-8?B?cnQ4TTJQZzN1UDZmcU9qR3l4VTc3UFdLT0Q1OUhyNytFMlhhazVNZ3ZsaTZz?=
 =?utf-8?B?dGhYeUtZZDF6YWRxMFVLRkdYQkllZHg4SFprQkFPdGF6RmJMMWJZV1JGTmxN?=
 =?utf-8?B?NVVGWkgwZERBMWhrRTdjSEt6TlkyNTZTMEZqdGhIMjcxSUY1ZkNDK1ByTDF6?=
 =?utf-8?B?WDJPb3JsbnFaaWxVZ2tNeXRxenZIc3hOdVBNWjJuMGxxbGFtZk8vblNaTWFR?=
 =?utf-8?B?Y0hJYmVxQ0pqeGxzelMyVEVYNU9ydzEyOXhhMURQbmFrZzBSdzYzMmhuSUNN?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <658A09F7B0A1DE409AD31E453CEC8527@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2767715c-d9c6-4274-ecd3-08dbbaaf139a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:28:51.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhwmQ3rQH+MC3TkndFGmlXqIendGefgwDo/I4jUQo9yRXSLgvCVpjsC2JxND+rtUwxJvonD7AqK/It6gB4a1cpdjuT3lF+eSHOVZynXsfUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8158
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJlaXZld3MuDQoNCk9uIFR1ZSwgMjAyMy0wOS0xOSBh
dCAwMzowNCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIFR1ZSwgMjAyMy0wOS0xOSBhdCAwMzoyMiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEFkZCBjbWRxX2luc2VydF9iYWNrdXBfY29va2llIHRvIGFwcGVuZCBzb21lIGNvbW1h
bmRzIGJlZm9yZSBFT0M6DQo+ID4gMS4gR2V0IEdDRSBIVyB0aHJlYWQgZXhlY3V0ZSBjb3VudCBm
cm9tIHRoZSBHQ0UgSFcgcmVnaXN0ZXIuDQo+ID4gMi4gQWRkIDEgdG8gdGhlIGV4ZWN1dGUgY291
bnQgYW5kIHRoZW4gc3RvcmUgaW50byBhIHNoYXJlZCBtZW1vcnkuDQo+ID4gMy4gU2V0IGEgc29m
dHdhcmUgZXZlbnQgc2lnYW5sIGFzIHNlY3VyZSBpcnEgdG8gR0NFIEhXLg0KPiA+IA0KPiA+IFNp
bmNlIHRoZSB2YWx1ZSBvZiBleGVjdXRlIGNvdW50ICsgMSBpcyBzdG9yZWQgaW4gYSBzaGFyZWQg
bWVtb3J5LA0KPiA+IENNRFEgZHJpdmVyIGluIHRoZSBub3JtYWwgd29ybGQgY2FuIHVzZSBpdCB0
byBoYW5kbGUgdGFzayBkb25lIGluDQo+ID4gaXJxDQo+ID4gaGFuZGxlciBhbmQgQ01EUSBkcml2
ZXIgaW4gdGhlIHNlY3VyZSB3b3JsZCB3aWxsIHVzZSBpdCB0byBzY2hlZHVsZQ0KPiA+IHRoZSB0
YXNrIHNsb3QgZm9yIGVhY2ggc2VjdXJlIHRocmVhZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgOSArKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCBiYmIxMjc2MjBiYjMuLjdi
NTM5Mjg3OGFiYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQo+ID4gQEAgLTgsNiArOCw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L21haWxib3hfY29udHJvbGxlci5oPg0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21haWxib3gvbXRrLWNtZHEtc2Vj
LW1haWxib3guaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
Pg0KPiA+ICANCj4gPiAgI2RlZmluZSBDTURRX1dSSVRFX0VOQUJMRV9NQVNLCUJJVCgwKQ0KPiA+
IEBAIC0xNTMsNyArMTU0LDkgQEAgdm9pZCBjbWRxX3BrdF9kZXN0cm95KHN0cnVjdCBjbWRxX3Br
dCAqcGt0KQ0KPiA+ICANCj4gPiAgCWRtYV91bm1hcF9zaW5nbGUoY2xpZW50LT5jaGFuLT5tYm94
LT5kZXYsIHBrdC0+cGFfYmFzZSwgcGt0LQ0KPiA+ID4gYnVmX3NpemUsDQo+ID4gDQo+ID4gIAkJ
CSBETUFfVE9fREVWSUNFKTsNCj4gPiArDQo+ID4gIAlrZnJlZShwa3QtPnZhX2Jhc2UpOw0KPiA+
ICsJa2ZyZWUocGt0LT5zZWNfZGF0YSk7DQo+ID4gIAlrZnJlZShwa3QpOw0KPiA+ICB9DQo+ID4g
IEVYUE9SVF9TWU1CT0woY21kcV9wa3RfZGVzdHJveSk7DQo+ID4gQEAgLTQ1OCw2ICs0NjEsMTIg
QEAgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiA+ICAJc3Ry
dWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gIAlpbnQgZXJyOw0KPiA+
ICANCj4gPiArCWlmIChwa3QtPnNlY19kYXRhKSB7DQo+ID4gKwkJZXJyID0gY21kcV9zZWNfaW5z
ZXJ0X2JhY2t1cF9jb29raWUocGt0KTsNCj4gPiArCQlpZiAoZXJyIDwgMCkNCj4gPiArCQkJcmV0
dXJuIGVycjsNCj4gPiArCX0NCj4gDQo+IENsaWVudCBkcml2ZXIgY291bGQgZGlyZWN0bHkgY2Fs
bCBjbWRxX3NlY19pbnNlcnRfYmFja3VwX2Nvb2tpZSgpDQo+IGJlZm9yZSBjYWxsIGNtZHFfcGt0
X2ZpbmFsaXplKCkuIEkgd291bGQgbGlrZSBoZWxwZXIgcHJvdmlkZSBzaW1wbGUNCj4gQVBJDQo+
IGFuZCBjbGllbnQgZHJpdmVyIHdvdWxkIGludGVncmF0ZSBzaW1wbGUgQVBJIHRvIHdoYXQgdGhl
eSB3YW50Lg0KPiANCk9LLCBJJ2xsIG1vdmUgdGhpcyB0byB0aGUgY2xpZW50IGRyaXZlci4NClRo
YW5rcy4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0K
PiA+ICsNCj4gPiAgCS8qIGluc2VydCBFT0MgYW5kIGdlbmVyYXRlIElSUSBmb3IgZWFjaCBjb21t
YW5kIGl0ZXJhdGlvbiAqLw0KPiA+ICAJaW5zdC5vcCA9IENNRFFfQ09ERV9FT0M7DQo+ID4gIAlp
bnN0LnZhbHVlID0gQ01EUV9FT0NfSVJRX0VOOw0K
