Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679DE7FD30C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjK2JpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjK2JpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:45:06 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C308619A0;
        Wed, 29 Nov 2023 01:45:12 -0800 (PST)
X-UUID: fbb8c75a8e9b11eea33bb35ae8d461a2-20231129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MbTYRamByj2i2AceOWpP8LDyqDA4qDzCaip64X89hjM=;
        b=fOmBfN4zwhDrJjUAXLLePvOJKu+zwtKGmGQa9DgU9IEHIfUDdqKyFM2XvvQV5JDdjCN5eZxDhkjfMbRybFRLskHDIme7cSi0vhIY7saF/99eEeuX3L40iQc08ZNnzBpxitklm9vmPqq04QG6hMDL9OY3OjzY+CcmNeXk4BFe+Xk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:24cc97b2-75df-4923-9b31-f4c532077bb8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:790816fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fbb8c75a8e9b11eea33bb35ae8d461a2-20231129
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1308087502; Wed, 29 Nov 2023 17:45:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 Nov 2023 17:45:07 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 Nov 2023 17:45:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IejUiLU7cAnFK/IQmGrqJ1PdvEp4LArx7WildD/0NAoe0V1kuHP1Meo0ZlO48rsDFGqPSWCPsJplPVyb0OyUfPwa1A6KavqXtdxmK6oTQ7tc0kHLDTW3S1GwdNt8vDf5S8TgW5r1cCmyBd4FvrfYXJi7YsuF8U3pg0g+7pj3JZpXiN6SQQ/Gou48iOV0D5FB8p4mZWOEvoptslzqDngiyaKTu/+uwlJYrFeq22CGwvbLgEwAsPGMbLvZRdNjm6/pNoQcBgWQyTEq2TjfMfZfpOVrANVOP1f8c4977QygcaXKx6ajfj8O9KCVsqQaPmLInos6eg1YWxRbUnGDzkqE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbTYRamByj2i2AceOWpP8LDyqDA4qDzCaip64X89hjM=;
 b=JN+/yRk+MVSAqxwRekWgHK0zyqLOZFOVcpZJbBk3AnTO45NhXnabl2wrfxKQ6cX08vRL7e1sAc3p7Km5XbKysTl9dnciW5RKwNcjGGEVeherSC4qqwWFRRlMEo0dYYs8DbA8AMUEdppYsx1jS78tt1/2/nOkt+bfAcRS0AiJBzJQ2aQjetEeDEpOY0Qt3ergXpXOuOYLDXJRilLqc8K7656Y8Rqw0Z2UkF1TlXmF0aZzx+eYhLXSY1cklzGLEyZVEO9suHwwqGYNlf99aoVi2jrArcSs7qdHIkshLcVPnVPxKiSzf+RI1l7S/WYKeTMJJQMEtZ3VCqMsjeqIkV+wNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbTYRamByj2i2AceOWpP8LDyqDA4qDzCaip64X89hjM=;
 b=cj2uXlVL/tKZ6NgpN2FdLCLZ4L/DSyKRH9uVqm0n0Ui4+x5wg3qKkXOXQEiBDVacPN82q2+VVT1z62J41A5HjA53ox7FHcVuvaDpTVyoRt486QhNa/73mTntboz4Oe7qzGO3NDzAjWaQZUhyKvvS+glmN+/Hfar4l6LHKAmf+Yk=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB6225.apcprd03.prod.outlook.com (2603:1096:820:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 09:45:05 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7c84:3d3d:a026:c1be]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7c84:3d3d:a026:c1be%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 09:45:05 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [PATCH v3 07/11] drm/mediatek: Support alpha blending in VDOSYS0
Thread-Topic: [PATCH v3 07/11] drm/mediatek: Support alpha blending in VDOSYS0
Thread-Index: AQHaAMXyc29Ulk7e4UOEksrm/SUdJLCH25yAgAl0TQA=
Date:   Wed, 29 Nov 2023 09:45:05 +0000
Message-ID: <1e982a7b2673ac1ee9a7c64b0373e515a4f779d3.camel@mediatek.com>
References: <20231017064717.21616-1-shawn.sung@mediatek.com>
         <20231017064717.21616-8-shawn.sung@mediatek.com>
         <efae77be2cf1ffbcf4f4fa3e991b5375bb41664a.camel@mediatek.com>
In-Reply-To: <efae77be2cf1ffbcf4f4fa3e991b5375bb41664a.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB6225:EE_
x-ms-office365-filtering-correlation-id: 5d264348-3302-40c8-7726-08dbf0bfddd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VCsTbCUwmc+tXjOBa/ksiWPU674k8p26/6KGCpPri3crVepyUkox0ktNSvIsWNQYZhet9EBrvEFiBXAyTYs6dXEbO+RpjP6TGmmCCQ6IEYbLw4O8OSj4jH0JB2eowBhTkFKzLtrNt+jOUhUwWEILmkWGl6ndNPN/xke8fnidIUxg0Y2n5v8/Q8rethfBseyn0WaQSBS6N/JmBJ/O189w9lk5rOVUHIEol71VuFyVWPwnoJSJ9fR7RYN82EUz7l+JJ76/cdMcBR9DBnKbLCfx6u43xZkyjFh4tEL9Iva7/EnOmtFvpkLqpDlwislk+tvHHuLQ4o2hklOJXH7Hx83IxrNAc52eqxKKfOrw4ALikYzsenKLZOAAiGgtUs0a+6MXgv5qDXI9TqcATtFNQv2mU2vybmXIe61ecePD7KErvL3sL10c7YMFQFKwp4+PieZrP2i/dNo0OXudxoEISybI5Hx2UNr/eQJnnhvUEIRO7SHShsAYduupyU0/1B2vluSE3PM+NfreJcy59oU9LSZ5npcg9+RSbmUHipLRxbscuUJskznifPOzt2iquRqrn99KlkluS2thlru063dzqapBXcayd3qVjLIO3YzFy5Y2p8S3OdCvDyJQoHOHNzcc3TZxEIwoF+8ZBcltzqTWonZueBLraM2C/I0pBT6cqrbjZg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(2616005)(478600001)(26005)(71200400001)(122000001)(85182001)(36756003)(86362001)(38100700002)(38070700009)(5660300002)(316002)(83380400001)(110136005)(4001150100001)(8676002)(66556008)(7416002)(4326008)(54906003)(64756008)(66476007)(66446008)(2906002)(76116006)(6486002)(66946007)(41300700001)(8936002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3Z6QVZ2M3pxdXNPM3JzMHIvc1UvWEU4K0pXNDh3S0xKWXFqRTJJTFd3Rmlo?=
 =?utf-8?B?c1NlcVpPWm00R2pZY0txaUpFVFhFYlZqWXhvWTh3QUFZOGV6TUdUNVVzUEUy?=
 =?utf-8?B?Vk1wVzFWOU0wVmtkazlJRmV4TkFsT25xNWxIRkw1VjdGQnpoVUswQlV5Tko2?=
 =?utf-8?B?RzJRZmxjd1IxUWVyL25oNTN0Rzg3N0tscVJQa0M1dmJES0J3b2FjY0xxOFln?=
 =?utf-8?B?VEFFNjEzVC9BaTVvWjFQRUNoZk0yWVdUVno1QzY4RXVkUHFSOVRXQzR5M2l6?=
 =?utf-8?B?eFJQZjVLcDFDaVIxLzF3cDhiU1JmL3pwY1VJWUJ6SHpRczZWZE9rYkJpQzRi?=
 =?utf-8?B?NzlQQmZLeEQrSU1XQ1JsRjJrSi81aFovcnBpUHFvQnA1ZmsremZQbTZ0QVFK?=
 =?utf-8?B?ZTBTK2UrTU5BcVh2eVQzV0Y4K0NDcDdiVXlOcWVkd2JPZmEySk5PUzlRbFpI?=
 =?utf-8?B?RC9qeG0wVmRzRm5HQUdtSjZQMkljNmp3eVl1SlhzQ01LbjZ3K1dqSGxVUmtp?=
 =?utf-8?B?aDhva2pKV3puQjNVNlFMQkR1M20xNlZlQUErNXBBUjhtNnoxdUVLNzMvSVpU?=
 =?utf-8?B?cU5tRTYwV2JKN1FDdWpqc3B3QUg2b25KUTh5QkFBeVRHamxHRHNJd1BtQUp0?=
 =?utf-8?B?RzJPVVdNQkswM3pSNGhlTWRySitCNDBXQTVyMFBzWi9mbW1Eb0ZYV2ZMQ04y?=
 =?utf-8?B?bVh4dG93dDZ2Snp6RzVsejJRYTc0ZXFuQ2dRV0JiOU9YY1BWS2lOSWlnMVNW?=
 =?utf-8?B?aXZPeDhQN3hzRnNjNkFOc0NKcVBseUNEOGMwcVBKZlczdkEySWJNZEFqWVBY?=
 =?utf-8?B?U2JBZ0g4RGZleVVpNlRWakxnUmFPSGZBQzVPcDhKY2d0NW9nWG1MTVNzNDZW?=
 =?utf-8?B?cjEzbkdvN3ZVWGpmeDdPVThsa082YktnUmJsWFY0VkRoNkhBTmFjQWNZUG40?=
 =?utf-8?B?WlQwNTdMdFNuV2dzV3lLSGlLaEd3VnJTeDNMUGxpVnhOR1VKbEozMStpTFZ3?=
 =?utf-8?B?Y1EwU04zdnk5bi9IWWpBdFREeTRkc2RDZXVSZTdMVGU2YjNwRVZqWmU3S05i?=
 =?utf-8?B?SVY0N2lTYkpacFI4b21RenNBcU0yNDgxYUlLamRJdWN2Tlhka29YeElKOUlB?=
 =?utf-8?B?WUNadGFSMUdoTjFTYUJMVzNRTnJOY1VUZnh1RW80NEU1aVorRm9mUjBuNDZB?=
 =?utf-8?B?WG5aRFB2TVQ3bEpOKzBoaEtFVTBxZlVsczdkR0ZMeTlmR3d5VXhoeERTU3o3?=
 =?utf-8?B?NlBuYlNjZWhQSHhob2E3U0lBYVZDdjk2ZGRES1lNMll0blBhU1NRMThFTWpu?=
 =?utf-8?B?Qnh2a3lLNDRHYjRIcEZsWS9CUUdJaUQ3ODVxZzk4bW1JcEJkcHM1ai9XczBH?=
 =?utf-8?B?N0kyaTlNSjhQUStwRUxxdGFKVXVWL2hhL2tSdE0vM0E0USt4MEdMNk1mbWZT?=
 =?utf-8?B?cVV6YzhEdGVmUnNYNHdBeng2Um1QUmVrMkdtenMxVUFNT25tR0JPTXVCR1kw?=
 =?utf-8?B?cjFta3Z5TGxPVUw5Y00yNFVEMFlRWGVvcjJTRmVVOEZqelVQbCtlLzk4SDFZ?=
 =?utf-8?B?RzFLaVRiYzdqcVU2US93K3dreU96MmRqSGVpZEF3MDh5eElDMVhrQTdoL2N0?=
 =?utf-8?B?a00zaDQ3amkrRG9xWW1KR0ljRTV5ZnI3L01sem81aEdtWWZpOU1tZkF4Y1M0?=
 =?utf-8?B?QVREWEM0SU5md0J4RXM0RU1GeW9zL1drc0EwTVpLOGoyN3pZTFRWUDVRZ1N6?=
 =?utf-8?B?T0lhQlpTWkFna3BuVE5VeDFvZEJVQ2pTRXA5ZHVYRUU1MktGOWRmS2hVb3BY?=
 =?utf-8?B?NXNxUWFRSFBsQkFqcHlLdXpHY0VnY3FBOWJvU2hHNHNobGZOUFIrWXVacVJI?=
 =?utf-8?B?Sk1NcFZ2TW01YjI3SVRwZzc5ekM4Z05NRjFUUy9scTJkMjNUT2V0bC84MURS?=
 =?utf-8?B?bmVqTWJvajE2bHNXNk14SU5yWDFyWkRyM3ZDajhCaER2elJLdE1lL0crdzdS?=
 =?utf-8?B?cVVCM3g2bkxpc1NiL2cwMTI2a1hFbHJxZ09EcVg0RjhwMjlWYUZBSkpMcEJY?=
 =?utf-8?B?Qitoc1BlQXBJQ3BmSTRCMlRVOVpCdFFmcWp0OGdhS3hhdjU5WG5NbDk5aU5O?=
 =?utf-8?B?SDA4N2J4QTFVREhQRnBQQkk5ZDR0N3AxM2tmSUZSSDMwVDREempZdi9yemdH?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AD346D2D995BE45894F9E91CADD5D37@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d264348-3302-40c8-7726-08dbf0bfddd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 09:45:05.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXml4mqUKhXFqomST3iunLoSI1FekjVCrBfIb1XsvDPqTceuCj7Ogc8aiVYbiZRhxPSwuMLBfUJTnRV87IUg2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTIzIGF0IDA5OjIyICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEhzaWFvLWNoaWVuOg0KPiANCg0KLS0tLQ0Kc25pcA0KLS0tLQ0KDQo+ID4gQEAg
LTQyMCwxNCArNDk2LDkyIEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiA+IHVuc2lnbmVkIGludCBpZHgsDQo+ID4gIA0KPiA+ICAJb3ZlcmxheV9waXRj
aC5waXRjaCA9IHBpdGNoOw0KPiA+ICANCj4gPiAtCWlmICghcGVuZGluZy0+ZW5hYmxlKSB7DQo+
ID4gKwlpZiAoIXBlbmRpbmctPmVuYWJsZSB8fCAhcGVuZGluZy0+d2lkdGggfHwgIXBlbmRpbmct
PmhlaWdodCkgew0KPiA+ICAJCW10a19vdmxfbGF5ZXJfb2ZmKGRldiwgaWR4LCBjbWRxX3BrdCk7
DQo+ID4gIAkJcmV0dXJuOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCWNvbiA9IG92bF9mbXRfY29u
dmVydChvdmwsIGZtdCk7DQo+ID4gLQlpZiAoc3RhdGUtPmJhc2UuZmIgJiYgc3RhdGUtPmJhc2Uu
ZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KPiA+IC0JCWNvbiB8PSBPVkxfQ09OX0FFTiB8IE9WTF9D
T05fQUxQSEE7DQo+ID4gKwljb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQsIGJsZW5kX21v
ZGUpOw0KPiA+ICsJaWYgKHN0YXRlLT5iYXNlLmZiKSB7DQo+ID4gKwkJY29uIHw9IE9WTF9DT05f
QUVOOw0KPiANCj4gSXQgc2VlbXMgYWxsIFNvQyBvdmwgaGFyZHdhcmUgc3VwcG9ydCBhbHBoYSBi
bGVuZGluZywgd2h5IGluIG1tc3lzDQo+IGp1c3QNCj4gc29tZSBzdXBwb3J0Pw0KDQpCZWNhdXNl
IGFscGhhIGJsZW5kaW5nIHdhcyBub3QgaW1wbGVtZW50ZWQgYmVmb3JlLCBhbmQgd2Ugb25seSB2
ZXJpZmllZA0KdGhpcyBwYXRjaCBvbiBNVDgxOTUgYW5kIE1UODE4OC4gV2lsbCByZXZpZXcgdGhp
cyBwYXJ0IGFnYWluLiBUaGFua3MuDQoNCj4gPiArCQljb24gfD0gc3RhdGUtPmJhc2UuYWxwaGEg
JiAweGZmOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChibGVuZF9tb2RlID09IERSTV9NT0RF
X0JMRU5EX1BJWEVMX05PTkUgfHwNCj4gPiArCSAgICAoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRl
LT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkpDQo+ID4gKwkJaWdub3JlX3BpeGVsX2FscGhh
ID0gT1ZMX0NPTlNUX0JMRU5EOw0KPiA+ICsNCj4gPiArCS8qIG5lZWQgdG8gZG8gWTJSIGFuZCBS
MlIgdG8gcmVkdWNlIDEwYml0IGRhdGEgdG8gOGJpdCBmb3IgQ1JDDQo+ID4gY2FsY3VsYXRpb24g
Ki8NCj4gDQo+IFJlZHVjaW5nIDEwIGJpdCB0byA4IGJpdCB3b3VsZCBsb3NlIGNvbG9yIGRldGFp
bC4gSnVzdCBmb3IgQ1JDIHRvDQo+IGxvc2UNCj4gdGhpcyBkZXRhaWw/IFdoeSBub3QganVzdCB1
c2UgMTAgYml0IHRvIGNhbGN1bGF0ZSBDUkM/DQo+IA0KDQpUaGlzIGlzIGEgaGFyZHdhcmUgbGlt
aXRhdGlvbiwgT1ZMIHdpbGwgb25seSByZXRyaWV2ZSA4IGJpdHMgcGVyDQpjaGFubmVsIGZvciBD
UkMgY2FsY3VsYXRpb24uIEFsdGhvdWdoIHdlIGRvIGxpbWl0IHRoaXMgZnVuY3Rpb24gdG8NCjgx
OTUvODE4OCBvbmx5LCB0aGUgY29sb3IgZGV0YWlsIHdpbGwgc3RpbGwgbG9zZSBvbiB0aGVzZSBw
bGF0Zm9ybXMgaWYNCndlIG11c3Qgc3VwcG9ydCBDUkMuDQoNClJlZ2FyZHMsDQpTaGF3bg0K
