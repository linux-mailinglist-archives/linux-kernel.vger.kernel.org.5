Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047147BB3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjJFJLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjJFJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:11:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622593;
        Fri,  6 Oct 2023 02:11:16 -0700 (PDT)
X-UUID: 4b9236ba642811ee8051498923ad61e6-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Z/BTzDjjJBp7fBA9xsbOLAzx+aL8UlQDwfE3F4hld2M=;
        b=nbehlOs12xbED7OdBshNsmUceXD420cReilR7Qctwc2OIvLzjMzQRR8H048PKUiGDNiUrHrgbd/s0Y/uErMzqpydgaDwq77OdyrkCp0SBbXThkuKmgTl0sCC5+tmVrJoObOS7d/bGOhgCOkOHXFFHjcbSiIU1/zPM14VwY5Y53s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8af9aa74-b7b5-4544-a1af-6e2806d7d696,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:94f083f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4b9236ba642811ee8051498923ad61e6-20231006
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1314106109; Fri, 06 Oct 2023 17:11:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 17:11:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 17:11:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqcLC0pzrN42OmqqzQdY8+oJX9oUqAD8ydcMOtrDd1863xrchaSdyh0DCDE4mA9cKo2IhepIqHvoBXLCyjkik65py0Dn3Dy1cqVK5z3xp9Ckz6+lOJC4hN/KrNUX4GU0ZQYSvGyfx+KPknDz+RZjsdRFTnATsJI2BCMggipvjwCXhiE5q+Ar9g0XyAk4mh+z3thi+H7hfY5FLQrTNyfJroJNaPyACyCKjr8beooRXihTdPtXP4suzkE0VKMbcFzgEAmQdehEaAPJdWBDAW2LXRFn3TGyy14LTXBHphpV76o0K65ttCEs4zQwOOusqEAFo6msuE2qz39teRJAEX+OAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/BTzDjjJBp7fBA9xsbOLAzx+aL8UlQDwfE3F4hld2M=;
 b=K36irRbVTv3Chut3GnKkAvDt0UdqwgUmcREIvygb6OnRxoqO/ftyesF5YYNO12U38MnLEf6MKToSTaET+yhsUgr5UlIXwPbSJWLeoaRq5SJsZzAXKxxguX70QKVuYXSLxCdkjg5cjSjBLzJNZ/SnK3OblIkbeL7XytWfrG0MU+HNf8R3oYNGxlEHMg87mUZEMnsmQxYIKEn3JCFdz9Utlb+liVvxAP/Ga2vIp6yS38PzkGOwVvutV4VytBx9N9QHPly27ZWmWSwvyurisbb0p5UpegLwIWYVhjnw/6lEqYJc54kvK+EiGCzeDMtKr2juKuCnRYEskP4jeqtKhyvmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/BTzDjjJBp7fBA9xsbOLAzx+aL8UlQDwfE3F4hld2M=;
 b=mJF73x9kCQnwq0QNHV4MlM7KxmRj6FZTADS5iVuAOZC48z+tj9KpOhV28oQpYf5xIh9Fuoi98I8P+igTYtBuAGOPUiZfNIHZTJn+HPyUlK3xnhDEs3os9y/6zFndu1obQfgE5xqLnSQaevZHmMvaxDtQwPR8Hj3YO1f3NUgwk3U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8289.apcprd03.prod.outlook.com (2603:1096:990:46::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 09:11:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 09:11:07 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 20/23] drm/mediatek: Remove the redundant driver data
 for DPI
Thread-Topic: [PATCH v7 20/23] drm/mediatek: Remove the redundant driver data
 for DPI
Thread-Index: AQHZ+CgvyPF4Bm3940yBadfla4nAnbA8ecOA
Date:   Fri, 6 Oct 2023 09:11:07 +0000
Message-ID: <ec4bae581ac120276cc041d82203ff07a48d5c2f.camel@mediatek.com>
References: <20231006073831.10402-1-shawn.sung@mediatek.com>
         <20231006073831.10402-21-shawn.sung@mediatek.com>
In-Reply-To: <20231006073831.10402-21-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8289:EE_
x-ms-office365-filtering-correlation-id: 5a168e91-bc33-4d43-7fdf-08dbc64c2d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f3OG9Y2lVwiX1Au7Rx6kflWRJKeFOyNymEfyPGl5PJugEmbcC87ncee4B29wLQCcZ5j/PmvF2UYvl8afshtKXEMHWBqSPegtYj57flR5oS9JBnh62Z+tiCENZ6jDBf7QJuwOSLxD7wj88MduFB7IxPUwsU4dUQ6u90Wi001Kpznn9Bv8jcC+gTgrT+6fWzsFNRD6Sf+NAjH2iZC/2FjyfYCEAM2W2FseOHjgLdtQd/O+V7vk/rfk94Y6qHS+GmLczOAvt+q1WXhkIrHzCIbnsfGWAp9W2uI1e/rBFvGpHl4U5OEsPLg/Db0g1Mcyjov38RkLiNOI0+kJPekOrYAHBYmyTLDKNo4+a/EooZvdg9sDM6Vgeu/Xyrk0nSi77R14ykE/ZtTf0zJSO4Z/czXnmvvrj/cmO4r0BWlrwFDExesiJQeT56xDzCDI+N0DcxHxvzudibOTuxvZ8mGncOqPo/TCN3WwHlE1e6CKn+SszcyLoy8QYH6NMfsU7ucB6/S2+jUOlbAz0P5E7luNCgI644RYflazXAwHEV+Yyo3nqPjEAeMghG1wxH1WiyORDZTjuQM3cKGz9QTzYbXR+8CGQlFpspYxjwu+oJRuI4b88AjkmrHhH5ElPN6Z2oxLq90YDqsIvelAbPW8mRaWfdZYjeUMjEEmPul3IHKwVmDPKSw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(26005)(2616005)(38070700005)(85182001)(36756003)(86362001)(122000001)(5660300002)(38100700002)(2906002)(7416002)(83380400001)(6506007)(6486002)(6512007)(71200400001)(41300700001)(54906003)(66446008)(316002)(4326008)(8936002)(66476007)(66556008)(110136005)(64756008)(76116006)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTJ2b1FuMEhiZm95NnlJQVFhZ1pGM3MveEQraGN3NVhsSzVCN3hnc1Y3c3lX?=
 =?utf-8?B?QXBBOVZXWHlDQ2p3ZDdDU1pjMUU5V0U1QzFabWlnK2NRSDJZTFlObzAxd0tI?=
 =?utf-8?B?ZkRGQWRJUWdndkJUVGhEdGRJelBoWGE0YTl5SEh3NG5uZ2tLcEpPalZTOVhl?=
 =?utf-8?B?SnhhNkU4OXpaQ1Uyb0pzbGx2b056clYzWURNZ1VkSEYwdEhqRzJQZzIzbmRs?=
 =?utf-8?B?YzN6dXZxSFB3bFIxZ1lrbCszK1IvYUNrYzlYV1dqNTdrT3hORUNHQnNLbHRt?=
 =?utf-8?B?N2s4allqVG41dHJ2Snh2bXFyZkw2cFRObURBZmV4NFJuUEMrRDJvdCtITjlN?=
 =?utf-8?B?QzhXSXRzaWxDcitCMENlYlpVTStKbUdwOFlDTXhjajNnMHhsYXQ3VGQrc2p0?=
 =?utf-8?B?aForMzRJbGVUcXZPbFdxekx6d2tya0xoeThsVzBHNmhpaU9XUFdlRndPL3dU?=
 =?utf-8?B?RG5OK3RaMGNkaUNpRFE0cUZYK1NGcisxclBBNzJ0VWVQa1E0ZzVEQlcyR2Fi?=
 =?utf-8?B?YW5DN25GcFpNaXFZTVRRRnNxblFQdEMyTnpmcWp1QkVDTUNuUzdIdlNibi9N?=
 =?utf-8?B?dG9kS2h2b1Z4QzV2YmZCM1dmZlFCU1pkbHBLL0FIL1VJcGJCaUY0bHNrM2ta?=
 =?utf-8?B?TElRa1JCR3pkWkpETU13aFJRUlhiZFhsNlpTSE9vQTFDSExmOWZBT1RaOTN3?=
 =?utf-8?B?UmFUbnhQS0cwOVpvTGdHdnExajl0aVNEbDYvREoxalMwWS9Dd0pva0hkdHNj?=
 =?utf-8?B?TWZ2Q2VVdkVLTVdDblJxci96V1BVVzhKaWcrSU9qcHlueWxOTXNscXB0Q0p3?=
 =?utf-8?B?ZkkxcTd0bGs3ZWVnQXFjRmkyWVdXZ1Q3c2E2SndsSXVGQ2VRWGxDam1HMGth?=
 =?utf-8?B?Q0FZK2h3ZndPcU4wSmdTUHlnZWIxbmhaS2EzbHVWOXdBQ2FSeFpEUTI0M055?=
 =?utf-8?B?RlBUQUYwek5nQ1l4KzV5WFVtR2pmdGJSVFIzYVlnWTFidDJFUVIySFVyckZx?=
 =?utf-8?B?V1IzeHBDUkdsU1NVMC9zS2dFb3VjdGRhSE1jYjZTQmdqMkZsODBHQjRFZW56?=
 =?utf-8?B?VElVbE5tRG5YNERCdjRlNTR5UklGUll1QWJLVTBLbUZhMEcwL2lLSUNmV2l6?=
 =?utf-8?B?Z1JYQlJ1YlJhWGZsNHEvMnZrVy9NVE5MYUNFSmU1MUhGL0UwUnFmT3FFekdk?=
 =?utf-8?B?eWRNL2VVZFBIbWxhaDNYZFFvYkVGVkpqRlFBR01IYWdJQUw2bUMwZWpFVmFK?=
 =?utf-8?B?L0RvRDNiQTgvMWtSMWVNRjFoSEVINzJEYld1WVRrY05oSzFDVmVWb0JpekZ5?=
 =?utf-8?B?NDIxSXlhdW83blZXZndDUTl5MlEzU3FBRUtGN1pGU0lYL0taTjlJbnZlejd3?=
 =?utf-8?B?cXd1K3ZWK2t4UDhDdnJubDN5SW84b1puUXpaS0lObzNPcWNybmxJVFJhWFZC?=
 =?utf-8?B?dFA3K2Jjd0xpellIRmdIWTM0M1JBOGI5SHNmZFBMVU13eFUxWThPMFhrMFA5?=
 =?utf-8?B?Rk84cG5zS0JtRzBYT2ZpWlE1RHhPZCtKbC9BdHJxZzZiSzFTUE5OVEVEUHYw?=
 =?utf-8?B?eDFhcmFGbVZqMDhWRW1YZ05TTWE0T3huTHJuVk44TVZJU0M3a0ZUMUVrQmFU?=
 =?utf-8?B?YllmL1lFY1czOGU4OFdNaUh2RlFkSzVGZzJSVzhrVHRVc3RDallvR2FmUWNQ?=
 =?utf-8?B?a3FGR0hlMnB2Ym1NZHlkMjA0cnBTY2NWUThzUDUwQ1R0KzdWYkcwZ011MUFD?=
 =?utf-8?B?TzV1and6aHNqYlBUTWF5Vy9oUUNsRG1Zdzk3MENRTFRVMUpCeFBqdG1YdjVY?=
 =?utf-8?B?ekZPTzN5QnRiWXBpSFQ5ZHFYZU93N0pTSTliSThZNFdaaW5mU1A1djVQM2xa?=
 =?utf-8?B?bUN5OHNKNis5SHBoWEpNVUNJTzRMcWJGd0N3VmdTb1o4bXprUlNsTTZyZWw3?=
 =?utf-8?B?SHh4U3N2blFtcGFHVG5vZkZUTTQvWElpWlNxL2xXSmZxM3B5UDhGVWs5cEkr?=
 =?utf-8?B?VWlqN3Yyb3U4R1B6WE10dlozd3hibGd6WjdOTUhkODU1eDJBclBabXFqRUQ5?=
 =?utf-8?B?Q0I5WmlCL1BuVE1rZFlCMzRWelJkL0t2NEJScGJQVS96TDVvSDVYWUpNYTBF?=
 =?utf-8?B?TVFlNWdoKzd2MHVieHUxRTVXbHA5aW9JaWZiQmUzQWovRDBla3luSm5YeDRn?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38A5D08FA450B4418951863E7F9B1D85@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a168e91-bc33-4d43-7fdf-08dbc64c2d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 09:11:07.8576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0WwTYGDtTyUz41nW1W8pzTFwdngJx9NM2Dm1rJiXgnHLwRZgOGu90zcRHiBjxUHo4IFvqZ4r3zycTIh3lEk8wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8289
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBGcmksIDIwMjMtMTAtMDYgYXQgMTU6MzggKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IERQSSBpbnB1dCBpcyBpbiAxVDJQIG1vZGUgb24gYm90
aCBNVDgxOTUgYW5kIE1UODE4OC4NCj4gUmVtb3ZlIHRoZSByZWR1bmRhbnQgZHJpdmVyIGRhdGEg
dG8gYWxpZ24gdGhlIHNldHRpbmdzLCBvcg0KPiB0aGUgc2NyZWVuIHdpbGwgZ2xpdGNoLg0KDQpS
ZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDI4
NDdjZDdlNjQwMyAoImRybS9tZWRpYXRlazogQWRkIG10ODE4OCBkcGkgY29tcGF0aWJsZXMgYW5k
DQo+IHBsYXRmb3JtIGRhdGEiKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3Vu
ZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcGkuYyB8IDE2ICstLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMNCj4gaW5kZXggMmY5MzFlNGUyYjYwLi5iYzA3M2E2YjM2N2UgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBAQCAtOTU3LDIwICs5NTcsNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxODZfY29uZiA9IHsNCj4gIAkuY3Nj
X2VuYWJsZV9iaXQgPSBDU0NfRU5BQkxFLA0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTg4X2RwaW50Zl9jb25mID0gew0KPiAtCS5jYWxfZmFjdG9y
ID0gbXQ4MTk1X2RwaW50Zl9jYWxjdWxhdGVfZmFjdG9yLA0KPiAtCS5tYXhfY2xvY2tfa2h6ID0g
NjAwMDAwLA0KPiAtCS5vdXRwdXRfZm10cyA9IG10ODE5NV9vdXRwdXRfZm10cywNCj4gLQkubnVt
X291dHB1dF9mbXRzID0gQVJSQVlfU0laRShtdDgxOTVfb3V0cHV0X2ZtdHMpLA0KPiAtCS5waXhl
bHNfcGVyX2l0ZXIgPSA0LA0KPiAtCS5pbnB1dF8ycGl4ZWwgPSBmYWxzZSwNCj4gLQkuZGltZW5z
aW9uX21hc2sgPSBEUElOVEZfSFBXX01BU0ssDQo+IC0JLmh2c2l6ZV9tYXNrID0gRFBJTlRGX0hT
SVpFX01BU0ssDQo+IC0JLmNoYW5uZWxfc3dhcF9zaGlmdCA9IERQSU5URl9DSF9TV0FQLA0KPiAt
CS55dXY0MjJfZW5fYml0ID0gRFBJTlRGX1lVVjQyMl9FTiwNCj4gLQkuY3NjX2VuYWJsZV9iaXQg
PSBEUElOVEZfQ1NDX0VOQUJMRSwNCj4gLX07DQo+IC0NCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2RwaV9jb25mIG10ODE5Ml9jb25mID0gew0KPiAgCS5jYWxfZmFjdG9yID0gbXQ4MTgzX2Nh
bGN1bGF0ZV9mYWN0b3IsDQo+ICAJLnJlZ19oX2ZyZV9jb24gPSAweGUwLA0KPiBAQCAtMTA5NCw3
ICsxMDgwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gbXRrX2RwaV9v
Zl9pZHNbXSA9IHsNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1kcGkiLCAu
ZGF0YSA9ICZtdDgxNzNfY29uZiB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTgzLWRwaSIsIC5kYXRhID0gJm10ODE4M19jb25mIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxODYtZHBpIiwgLmRhdGEgPSAmbXQ4MTg2X2NvbmYgfSwNCj4gLQl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1kcC1pbnRmIiwgLmRhdGEgPQ0KPiAmbXQ4MTg4X2Rw
aW50Zl9jb25mIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtZHAtaW50
ZiIsIC5kYXRhID0NCj4gJm10ODE5NV9kcGludGZfY29uZiB9LA0KPiAgCXsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTkyLWRwaSIsIC5kYXRhID0gJm10ODE5Ml9jb25mIH0sDQo+ICAJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtZHAtaW50ZiIsIC5kYXRhID0NCj4gJm10ODE5
NV9kcGludGZfY29uZiB9LA0KPiAgCXsgLyogc2VudGluZWwgKi8gfSwNCg==
