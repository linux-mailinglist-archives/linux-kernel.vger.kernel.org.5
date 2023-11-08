Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E207E50E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjKHH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:27:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38E71AC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:27:34 -0800 (PST)
X-UUID: 45dfeede7e0811eea33bb35ae8d461a2-20231108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0LO/QJupJmLT4SLwdwrwIGhXYGgV5bZ9dE1uSV8dGMM=;
        b=HIHUkNyTNWFRGTXILYrzC5wCCYCk7tdxPRWky0vsROmeAWa5q08GDrUqBJQfIEZhjrgu+v+YEYLlNCEyaniKYSCSe86cCEMAHUkAIE5idy1FXr5PDVCzA0mCpaYu4BZ9jQCRK4smSbXHP41MzP17Hxy0+WfBhnpEuq+eb5AhYDo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:aeebbaf9-3f18-4e12-b5a1-face4b901431,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:7fad6872-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 45dfeede7e0811eea33bb35ae8d461a2-20231108
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2020792641; Wed, 08 Nov 2023 15:27:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 Nov 2023 15:27:28 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 Nov 2023 15:27:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC0K3UslwfqDiHVR9Mv+UiwsZNt5H2aHxsyhly2DRTBhGH/uBWgpr8t2SUPGxUm7w5kTVsSW+Lk9+Oavl56sQjJlIWT23n8KpdMh7OjxW9pxpMTafVPtiXz3ZZ9MgAHD3RUj4anoT18x1uWSaRXbASEj38PFXrOR8b4jI3ShgKEOSacpGU7qEjPbVJvjcDAY5OkSp+z16Y67DxkNRGwvwB74H5K0MZcjTQ3hiHGnLwohEGzY1mDV9tY0mX10UvQ6ZecXH9Ax1NlyVZvtpg92JV3yNQ35MB5W0eCyRyQGedmZB8e9zHY5p0qQjNno2nFF4kOHjDlBrd9H9leFeZ/RkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LO/QJupJmLT4SLwdwrwIGhXYGgV5bZ9dE1uSV8dGMM=;
 b=FshjI+Ijj6J/RuadMyI7/qgC8of//NZlVdkE795Yy5HO36bTPMBjNN3FERYF1bB3XNQPOyn/W7fkqVNIOYQpTChpFdr72zu1nxInaQ/PuVjkBNo1sLgj4srE5CGJhZG5hH3vmmDomGiflU1oj3s6jWVK2YxdQ8FC1VexD44027JwkAZwlw/ypr92fxTVylfnuZs3RNkpOFHC8pzyutEMP29/Eiu6Mx8ufTstDHt7mYCYo9zEBEBVoOeo9jnVKnsFuM6mb5a/6+g+pmuUL9tNGKO6GHNP4Hxv6QLdEQSxE7Zg8VUHrk+N7zEeLdAo3PZPHtAf+TynNGi6sTwiNByLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LO/QJupJmLT4SLwdwrwIGhXYGgV5bZ9dE1uSV8dGMM=;
 b=v42yAeSXhDXRAlffpu1Fl2Q+rfKYqbWnz/otRcs+CdpovjTLBF3/XNS1aNw7SIGqNxpvDkHb9eNyznahjfysFu0BId5iyNUPWYreoY3P0ElBr3/2rSxjjU7ouQh1Wh2H3ms2UBmphW59D5VtCs1QpQjIsuP/qxri8eS7CakKZJE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7828.apcprd03.prod.outlook.com (2603:1096:820:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 07:27:24 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 07:27:24 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] drm/mediatek: Add spinlock for setting vblank event in
 atomic_begin
Thread-Topic: [PATCH v2] drm/mediatek: Add spinlock for setting vblank event
 in atomic_begin
Thread-Index: AQHZ66HiGkans6e6KkKLgSXwtRDeaLBwUsUA
Date:   Wed, 8 Nov 2023 07:27:24 +0000
Message-ID: <4b55632a4cc92932384844f94a7d237aa3f471e3.camel@mediatek.com>
References: <20230920090658.31181-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20230920090658.31181-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7828:EE_
x-ms-office365-filtering-correlation-id: a0e28e96-63d8-4a80-64ea-08dbe02c275a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4eB0IeUYWdUYJ8B0pvwu5kswZeAraO232Bo7hJE2HP0vxiHXqYrizFE0tMAx1QKgzhsb5d9/BvTcomJI94Z0Egsu8BWHWMUJg74JnsK8Ec8r7FWxmg79WGA/AVh/Jg64Iz/m7WxWEzuYouUFJlvijc0Gl3KddmxzglS8HFq68v0qLmE+Q9FsC/Eq8FWxn799yP+g1wC2lE3BWPWRKxEe715rKGEBa2j63jSj67EQp7iMgm86+HwP1k5zIrG2XoTKdXary1s9BdZa65RT7wqEE3E0NIiCJ899la5pQgP4Ffx/eT+HmVq9ynDkWaa+jwWLk6ZxPDxdwEmgxV2L7E2+nXoJSF7GJ32qVjwt5KMQ0tydROD1w/liGNLaIHGlEOozUpEHiSLUBByrAHcZJfdQd9iAba+EbtOi74WqmFE61ihsbfVxsF6C3nJ1hTfDYlFHluDavkIs7Gjq8iI8sf7qtL8CLGWo9pGmGf7CyJ5y9J49eUZrsmX3RfwEgH7FNaathFyv93ACpQRi2RcQ1bQcPtrQ2WjqPe5rgU2Slb4tM+Avuyly0NHaYPO2HfS/GqAQaI93mPMUJIeZAiYMO3Npfv2V4mAY87atbssBuFYuHovfP+/C8s8bhtU2A5W2UKWZ+zS7ZYg0WQZlZyjXCFOYYEZKg0R8k5hU8jXIWErTI7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(122000001)(38070700009)(26005)(2616005)(76116006)(83380400001)(66946007)(6506007)(478600001)(71200400001)(6486002)(6512007)(66556008)(66476007)(8676002)(2906002)(36756003)(4326008)(110136005)(41300700001)(8936002)(38100700002)(5660300002)(86362001)(66446008)(54906003)(316002)(64756008)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU9YR0RoRTVwayt5am5SS0lhWlA5ZXU1OVQreWJBaGNDUkpvbWtEZDRvNXlS?=
 =?utf-8?B?dktKaW9uTExhZFJUQ3dDbzR4WFNMYURrSVhuaExCRnFqQnBPSEtiL3lCYnZI?=
 =?utf-8?B?aDBKRnF4aEFaMTZ5UjJkQVdEKzJoMFJTS3NCODE1YVN3V0E1N3RHSHZOVG81?=
 =?utf-8?B?U09BN3lZUDgzM3VQbllZNmlEY3N1MHJJeTJQQlhnSGRoaHdyQmNsOTFkSkNW?=
 =?utf-8?B?RlRZOTd5eE8rYi8vTThVeVByWkljNVg1Wk9wNE5Lc3QxS212ekRRbDRuUlVv?=
 =?utf-8?B?L3U1SFFIdjFZVUZENWo4SUxnSGdkZ0dRanFpdlc2NzUzanYvM3RxV0pZeExX?=
 =?utf-8?B?aStJYnhOUkFUaWNtL09NUGxKcWFhdDlBbndOQjlPRmkrdlNaTlI4YllMV3Nr?=
 =?utf-8?B?OXVlQXhwWjV0TjJSMUhvZmdldC9lMFIza0ZSV1J4TkN1dWZjMjVLdVZCSVhr?=
 =?utf-8?B?ZVhDNmxyTDlqYzBQZ3ZOTGdZeFRzeENwTFpOeG5xMnk2bFFsRkxLMmxCcnR5?=
 =?utf-8?B?cnlSWXQ2amlmM1FmM0JjYTk1K1E2UVIvUkxib05Uc2xWWXZkcDRpNWRnOUdI?=
 =?utf-8?B?V0Y2Rlk3UFF5ZnQ1MkdBSnRzN2xQdmYxK0ZueFJ6Rm9heWpmdHUraGhaek5P?=
 =?utf-8?B?T0VxSFNHc1ZMS1VhRWNRWk5UZUE2a25xNzBjQmdjYzJvaHczREIycXR6MDIr?=
 =?utf-8?B?Z0RPSnJiNE5jSER5SWhGZVRERUR3WVdmaGgvamt0RzBFdjBhSU9UZXczenF6?=
 =?utf-8?B?c0hyRWpxZ09Jc3laSjlwd0lqVkVHK1N4K1VvN3VEbXdUSFBiL2o3K0VGT2FT?=
 =?utf-8?B?aWVDa2xUQmRta05STzllT3UxNXFjdnI3VUxRMTE1VW9GS2MxNEtPM1loRVlO?=
 =?utf-8?B?ME0xMXMyZFJEQnllWm9kWVFNSWRnR1NwcDV1dm9lMUlBRHJFZXFwMkYwbnhP?=
 =?utf-8?B?Tk5wOWx1Sjd1cmtwcis5c3JqNi9DZ1k2cmFpN0RyZ29vd25yenY2K3QvY0FU?=
 =?utf-8?B?bWMwaE91ZGNpdDhpajBTTkJkeWlERlNxR0s2c3RrRGVIWUZXeUdzUjZvZzlK?=
 =?utf-8?B?M0w0V04wVTZ3aGZrQmFuUGZmZmlpZUh6NXFidXRuQVRqZWFKdzNnRUdxZFpH?=
 =?utf-8?B?L2t2MU5SaGlkd1I3NSt2Z1hRaS92QkJBM1llQVZ3MXN6WHh5VldORk5HbDNY?=
 =?utf-8?B?M09wdTg5V0VzNGhvTVhMTDgzNlJKZmVwcU9XelJRQWZOSlNWQlFtUjN1elMw?=
 =?utf-8?B?Vy8rbmNnY0RwU2NWQlVydEQ0MzBURm5SSi9VV090VklvTE5qbWo0L3pGcklR?=
 =?utf-8?B?b2RxMmU2ekNMNDYxUWJqWVlCNnc3QjlDUGlYSm1XNXJVNU9ZV3RCbFplUTgv?=
 =?utf-8?B?ZHg4ZU9yU2lRUDFGaXZDRTVOMlZHT1NJTGxVdnZYSCtId1F5dTRRYkJGUG9C?=
 =?utf-8?B?amhiWXQyM3ZqQUdHUTZKc1RNTVMxeE5EaGU0d3lETk1waWJ5bGRjbDVzOEh5?=
 =?utf-8?B?SXdEYmx3RkxZYnUvbGtLQjRTaVZ3d3dZbGRQVnp6VEliUUp2MlAyeE1OaURr?=
 =?utf-8?B?UlFWNjNTcko2ZFJLVlVnTVhBbTJMVy9Vb3h1Smx2VGhHb3kweng4dWIvanBq?=
 =?utf-8?B?eDhiYWMzdUltQkE0UExPdVZJcC9ad0pjT201SFFhVDlhcU01a1ZKMjRyb1pQ?=
 =?utf-8?B?MnhXY2pFSFJ4Yk9aZ3lUU202SEtjcVYxNG9UalVpaEQ2NW1TT1ZRUmp0QjRw?=
 =?utf-8?B?c1pNSGJSWTRvb1Z5K2RSeVpkUzFjd3dBQlZxeHZHQXJsV0tMS2N3dnFKc2Rw?=
 =?utf-8?B?eUVmeGI2ZTlYOGV5b0VlSVBwdGt3cXA0RTZpZmpoa2tBSjNCWVdzQ3M1VmpH?=
 =?utf-8?B?TDFXWTlvUDNxNlRPaDVQd28xUlFiVFlTaEJqL2xxeXowNG9RVHBsNHA0Mmd1?=
 =?utf-8?B?R1phbm9NOGpKb3BNM2xJKzV2MzZKdEowM3VvUlQ0S3daK21QYXNUNC8xRFI3?=
 =?utf-8?B?VDEzRWdVNjJUSHFjYnIrRU9XOTk3RTBmNlcyb1dXdnE0TlcvZzFUZUp3NElr?=
 =?utf-8?B?NW1ucXVGZ2c1a3RTSmZNQXhhekZidk5ybUxCZFBpdlc1YlJqZEJXcDB1dEdz?=
 =?utf-8?Q?1GlKQBsfWI03AHdSX/X2Iz3ld?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9BF6AFD7AC48349BA95549918AE4BD9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e28e96-63d8-4a80-64ea-08dbe02c275a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 07:27:24.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7x2fHshAIcjrEDVX/tuOQ6qryhcp0XtXBIiOPlzEt04c6KC1FYyDf+VnaSjGqttv78CtJQeDgE0wUDDs8qIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7828
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjMtMDktMjAgYXQgMTc6MDYgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIHNwaW5sb2NrIHByb3RlY3Rpb24gdG8gYXZvaWQgcmFjZSBjb25k
aXRpb24gb24gdmJsYW5rIGV2ZW50DQo+IGJldHdlZW4gbXRrX2RybV9jcnRjX2F0b21pY19iZWdp
bigpIGFuZCBtdGtfZHJtX2ZpbmlzaF9wYWdlX2ZsaXAoKS4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1
IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVzOiAxMTlmNTE3MzYyOGEgKCJkcm0v
bWVkaWF0ZWs6IEFkZCBEUk0gRHJpdmVyIGZvciBNZWRpYXRlayBTb0MNCj4gTVQ4MTczLiIpDQo+
IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4N
Cj4gU3VnZ2VzdGVkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dp
b2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRy
ZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IFJldmlld2VkLWJ5OiBGZWkgU2hh
byA8ZnNoYW9AY2hyb21pdW0ub3JnPg0KPiBUZXN0ZWQtYnk6IEZlaSBTaGFvIDxmc2hhb0BjaHJv
bWl1bS5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBpbmRleCBiNmZhNGFk
MmY5NGQuLmNhYjRmZTA5MmYxMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYw0KPiBAQCAtNzQ0LDYgKzc0NCw3IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0
Y19hdG9taWNfYmVnaW4oc3RydWN0DQo+IGRybV9jcnRjICpjcnRjLA0KPiAgCQkJCQkJCQkJDQo+
ICAgY3J0Yyk7DQo+ICAJc3RydWN0IG10a19jcnRjX3N0YXRlICptdGtfY3J0Y19zdGF0ZSA9DQo+
IHRvX210a19jcnRjX3N0YXRlKGNydGNfc3RhdGUpOw0KPiAgCXN0cnVjdCBtdGtfZHJtX2NydGMg
Km10a19jcnRjID0gdG9fbXRrX2NydGMoY3J0Yyk7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsN
Cj4gIA0KPiAgCWlmIChtdGtfY3J0Yy0+ZXZlbnQgJiYgbXRrX2NydGNfc3RhdGUtPmJhc2UuZXZl
bnQpDQo+ICAJCURSTV9FUlJPUigibmV3IGV2ZW50IHdoaWxlIHRoZXJlIGlzIHN0aWxsIGEgcGVu
ZGluZw0KPiBldmVudFxuIik7DQo+IEBAIC03NTEsNyArNzUyLDExIEBAIHN0YXRpYyB2b2lkIG10
a19kcm1fY3J0Y19hdG9taWNfYmVnaW4oc3RydWN0DQo+IGRybV9jcnRjICpjcnRjLA0KPiAgCWlm
IChtdGtfY3J0Y19zdGF0ZS0+YmFzZS5ldmVudCkgew0KPiAgCQltdGtfY3J0Y19zdGF0ZS0+YmFz
ZS5ldmVudC0+cGlwZSA9DQo+IGRybV9jcnRjX2luZGV4KGNydGMpOw0KPiAgCQlXQVJOX09OKGRy
bV9jcnRjX3ZibGFua19nZXQoY3J0YykgIT0gMCk7DQo+ICsNCj4gKwkJc3Bpbl9sb2NrX2lycXNh
dmUoJmNydGMtPmRldi0+ZXZlbnRfbG9jaywgZmxhZ3MpOw0KPiAgCQltdGtfY3J0Yy0+ZXZlbnQg
PSBtdGtfY3J0Y19zdGF0ZS0+YmFzZS5ldmVudDsNCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmY3J0Yy0+ZGV2LT5ldmVudF9sb2NrLCBmbGFncyk7DQo+ICsNCj4gIAkJbXRrX2NydGNfc3Rh
dGUtPmJhc2UuZXZlbnQgPSBOVUxMOw0KPiAgCX0NCj4gIH0NCg==
