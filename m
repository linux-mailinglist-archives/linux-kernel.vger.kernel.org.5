Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDD79B594
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjIKUuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbjIKNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:45:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF4CD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:45:46 -0700 (PDT)
X-UUID: 7f089aa850a911eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WChv2fiR+dhb9PtEZmf6Old0bxJfN29tdF6oryVA4o8=;
        b=Kr2O2/oWlzfst5LtHb/xEiNima4OtfLAS2rjTdsBJ+HBBp3pHSEpk53IsPpEFMUStTqYR4f0WX196uvsjLZXReWzMDFxnUfUAkOZEcSuDe7sH4Eb35e8Qt11P7OeVi6lO/BtyabfZyJW4uBJS5L3Nvp7E7+wOz0BWZW1YhUO7Xw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f923d119-5f47-4217-a8ee-6044c5de5626,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:4f0ce5c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7f089aa850a911eea33bb35ae8d461a2-20230911
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 925272760; Mon, 11 Sep 2023 21:45:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 21:45:39 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 21:45:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAMUKWk5DSjRZVpif26Y8gdx3/PBJTGP1CS4GSnsvjwDTeRCwQqbekY+D9aO7v2dwIcnutiw4sSMgWoyZs1AMXxmtlelJK5OhudfOp0XHQVbBkIGqxo5fEPmsbx5kNKRwwGoff/6fXci+r9fp5qyAx+HpWZisSLQETVSMQlxFKnwA+2WbwLUCZzDWhJa94HLN5fjvf1SGxGoImbzsiHFxi/RIjlIa31HpMDTUcJ5IlKMN2GsIe4yzIY2FiuYRNLPYOox7XnakroiaJRP0tOoxp4RD8jJ4P+hENUKaR4Yy8db2IPoY0F8KkEBpcoT0InW10tqDIDGgg6yRG41IG1FNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WChv2fiR+dhb9PtEZmf6Old0bxJfN29tdF6oryVA4o8=;
 b=AZXwevi3TViJRxVeYs2ReOP/AMoAwTyA9g8i9qAecqALu73S5wNQgtkIfWND++gw163HwJk0GI/EePYiLV4Nd6yrHzGqm3dNp3845ijTMZrvtSa3bR7RATJ28FrDVX1X4n0kpyjqtFgXPCzDiA+dbVzhRyyG6BmFHJx9mUQJ9lKHJjWUIcPuxJ20EhH+aRHqSrHi2M6K2t785t/XQfy19FP6I3Jj4kcxkXny3Fjhg9BudGAwgWEqWSkFV+KpVKVRxrzy1Qa508znC0m8t7h/mLyIt9y3s6P4vQ/fyAdq7YbjodnKRfa0K+qDQyR9GgTjOkWEWSYo/fyAYpBJUIDVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WChv2fiR+dhb9PtEZmf6Old0bxJfN29tdF6oryVA4o8=;
 b=M73WrdRU20PObTcV1/GpLYArwpONIgHtOF77Ttg2kbzFxyu7q758GYw/zzvGbFWZQnNmCuYwSXeVLBfzehcdTxHeQf0ygJ2nCZCDUHjOUJAKXrex0UJXfWvHi7YFsfAJTgs/9bwKYkniFaj45rxEv3v4fE+J0a9K3U1U4BTRlw0=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEZPR03MB7373.apcprd03.prod.outlook.com (2603:1096:101:12e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 13:45:34 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a441:8f4:4de6:2437]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a441:8f4:4de6:2437%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 13:45:34 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 13/15] drm/mediatek: Add missing plane settings when async
 update
Thread-Topic: [PATCH 13/15] drm/mediatek: Add missing plane settings when
 async update
Thread-Index: AQHZ1dSXiFA3TVMB4UyuRIssiWQXb7APY1mAgAZddoA=
Date:   Mon, 11 Sep 2023 13:45:34 +0000
Message-ID: <e1f07420c9d7abf26cf9ce111c063224001ba561.camel@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
         <20230823151332.28811-14-shawn.sung@mediatek.com>
         <d43e0d7b-1e93-f9ae-df3f-cbf8a3381a70@collabora.com>
In-Reply-To: <d43e0d7b-1e93-f9ae-df3f-cbf8a3381a70@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEZPR03MB7373:EE_
x-ms-office365-filtering-correlation-id: 25175f4d-9f5e-45c7-1cb0-08dbb2cd5f79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnsROai78qyXt88kS0y3u/7/Sb3Lydv4GroIxMOlrZ7kuMgQGhTPecveLPkFxmySqp6Z2FJ5l7u8FmkLKNb2vSpVYqgNdIKTmT5pYtaRS2tPx7Rb5h4rMelmkpVvSWFUkx1jhRASvbguRyatKJeMRJ0ifw+NpfOJhGeRENgttU6G5TIXvO+Ea7Mu0cYqFW56yiMrBGCoXA9x4GLSa7MasCmdh2t+R8lQEv0jBgN5cRqc2+sB1HT7PHdviSiT5/urqaLnW9NJKiVteqxtSmBmzzJcLWpCHUszERb/iqe/92QhBOutYNq4P6ndOsd77yA7ONXZA7Q2h4HaDuU5AHquOt8CI8p5xjuIw/ZzYAXupkvGUnf97IuNdJ+dGLz8EtBKrUFvEW7tQA6JJmSHrwLAcbZUdz2P5zfTUH5COm7VyRNkq7d8raKYrdKD9LiN3fHEkpQ+ugI6FIFKYmZ5HGHO6t9unpC4SLsrfGFrbwLpUoY/Bw9nJhepHQoYtG7hYJJMCCjvqTXlwPCwh+UqNaLd3hEnCajWKcinlfs/huHcmIkOrzKhz2xR74nOknQbTeGPVdB7H81rzeGKouYDAr83sMXVG2asF6+hX19x4z/rIpo2rcK3M6xg9D04VDlLShEeCAUb1uDsSUJOB0n2zDdvxHT7iTSYpz9G591qysI/ztA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(186009)(1800799009)(451199024)(6506007)(6486002)(71200400001)(6512007)(478600001)(83380400001)(26005)(107886003)(2616005)(4744005)(15650500001)(2906002)(7416002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(76116006)(110136005)(41300700001)(4326008)(5660300002)(8676002)(8936002)(86362001)(36756003)(85182001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bndic3hQc3dON3phV09VMGE1S1hGUno1TEhLaFlVdms4L2cxSWJNMXRoMnFk?=
 =?utf-8?B?OWVzMG40TkpMU3M2TS9jQVpCU2xPSVdlZ2xMLzdROFY2Rm1pK3cyRkczVlVI?=
 =?utf-8?B?OXdKQzR4UmJnZS9Qajl1b2xBSWJSSUN1NlpWbzI3blJabG1BUUIzZFFVeWJw?=
 =?utf-8?B?RXJmM2hNUzNBdi9Xa0J5MWtaSkNlc01XWWFGRUdkeWdpam1TWnorbllnMHN1?=
 =?utf-8?B?SzlydlZBanVKRzdEU3J4N2ZXcHZqUFBKUXVEdTVNSnMxMzlCcE55ZGpUMHpj?=
 =?utf-8?B?MURqVDhINmliQTd6SVRMOFREUFRrRFZVSWVMYmtiWlZheUV6c1J4MFV2LzBt?=
 =?utf-8?B?SGhiZVUzeCs2Um42MlZCUFRVUW92Yy9jWktMSFNrY3Q3N2hNOHI5MDBNSnV6?=
 =?utf-8?B?WnBrNjB6OE9NN3hrZG85OGF5Z2lYWVlicmRESEliMy9TUnNJdkZidldMT0d0?=
 =?utf-8?B?RTZPZjduRHNEeVdFUmM3VGhkQXFwMUxaZlpQMWZvK3NRQktrbEplazlTOE9Z?=
 =?utf-8?B?ZXRGTzBYblQzMjdzQzJjaWdUaVRKa09Tb0xGR24rOWdIY0tsSEpielNsMW9Z?=
 =?utf-8?B?V1M3eTNRS2JqTjFFaEp6TjRQcXZ6SVg3OW5VWFprYTQ3VGxEQjFxTUptaEJI?=
 =?utf-8?B?ZmRwWnZmMUVzdEM1czlkaUpmL213cGJYS0tUMXpYN1JlWVhEN1drU2U2ZDRs?=
 =?utf-8?B?QWd4TUhscmx2djRWTlR0enlzbHE2d05BMXZJM2FjM2tMQTIwMFRuVW40bWhV?=
 =?utf-8?B?dnk5S0lveXNOQU45d1RSVWF0RzlSQndjQUhKRXJqdE9oNmJjRDdldXk0UElq?=
 =?utf-8?B?R0dQUStlM2U1dXpaSElqOXl3ME5hU0lIU1pIYUlIRjh6SFMxekdwNCtTdEsw?=
 =?utf-8?B?ZFpqR3dmTzZDbEcrOFMwODQvSWhGOUpoL0hvS0I0NlR6ZFFOZEd1TGRxb2Rt?=
 =?utf-8?B?WW1vbFVBRTZWUTA2aDVGRnQvajJlMWFnNGZuSGxTSmd6MW9WSGlWdkU3SEdu?=
 =?utf-8?B?SzNaeEVSSGM2dnRzd3pQa0gxVWZJM05nK0RJYkEvSDMreUtHWjNuTmJvQVNX?=
 =?utf-8?B?a0xXbm45Q2wyVS9uYlRIcmhpSzNzbmUreVZZeUgzL05FcmZqL3RhWnFCRGw3?=
 =?utf-8?B?amlOb2lBZUlmUWw3WEUvMWhRQ2F6ajRqTHZLNXYvelRyQkxYQlM1SXNZeGFx?=
 =?utf-8?B?Q0hML1lJTlQrcmNKZGRVTEFTVmFVYTlJNXVvV1ZWd0F1V1ZHM0tRa2JVMVB0?=
 =?utf-8?B?V3ZjcTE1bzRMQ2xoWDRWSU9DbzBNQk9BcWN1TW5LTGhFMkpVU1BLM1dCdXl4?=
 =?utf-8?B?SGJYazJzbUxrR2cvc0UyU3pzMlFkcmVIWUZSTWNEa0VOTzhTL3ZYdmUzSzNl?=
 =?utf-8?B?OWptbStKdUtZeHZ5UWY4UUF0MjlWc1RVTVhSTXJINmQ2UTdHUU94S0RNVkZG?=
 =?utf-8?B?R2djbGNWdGNlUFE2MzFQUlZPdVRENVNnL0hyVFhJWUkydDRKNU05ZFBJMHBP?=
 =?utf-8?B?THhYaGQ4NFV4UmVJSmZ3U2NaYmxrWmNzOElkWEZsQ3VkUnFhd2VSYlpJRWgv?=
 =?utf-8?B?cmIxWG9CbnVJelhEMmI3MzZsZkdwcXk3a01TY0phU05hdjF1ejBQV3JaNXdt?=
 =?utf-8?B?TWJDS2hoenFGdW8wMG9OZWIrTHlhbEQzcFBneSsrQmNaajBWYUdtNEpjUnd0?=
 =?utf-8?B?RXFzdEoxMzFMcWdMUVdPUUo5a0txbThFVkVua0pCdzYxK0JqMi9NTVpranV1?=
 =?utf-8?B?TWtrenNKaW9mYmxuTFZRREpKWEcwdE9JSXhRcG9LSnIwRjhQWGtPeHpZYzV3?=
 =?utf-8?B?RUNVL2p4SmliMkZ4bEwyZUZkNkVkb2E3Ym9Gc0ZJNTMrSFhHMUl3cDFXQTJY?=
 =?utf-8?B?S05zQlF1TnZFUmVncGhKZEx0ZWJNTFdLc1A5SlZtRTJhcFZOa2N3Ni9WdWxM?=
 =?utf-8?B?WnFFWlh4amlXNEZtNHlEcXl3T0wrd3Q2U1hhcm1SN1Q5VDdVUlgrR1ZXMndI?=
 =?utf-8?B?NjlUTmlSY3JtM3hBNkJkTytYTkNnV05tMisyUHcxUDBZTHllaVp3cHdrdFQy?=
 =?utf-8?B?M3lROWdYZmVwdGRtVmZJbUtSeHlvU2Zaa25SVDZtSXcxMzk4TTJBWGhQbitS?=
 =?utf-8?B?eHhKczR1MXYyam14cjY0dERDREVzeTdabDZneHBrcE51NWdCNGh3eXpmRGxY?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F8CA34133EDE5439D062AD08065417F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25175f4d-9f5e-45c7-1cb0-08dbb2cd5f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 13:45:34.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dviAzqN3nYtclJNjA+dlkv2gCKv4LXd/LXR2n8+O4DYz+1Pyp1EszpT1TKY/JJseVmCv43KxIOJqu6vzo/AtTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7373
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjMtMDktMDcgYXQgMTQ6MzMgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyMy8wOC8yMyAxNzoxMywgSHNpYW8gQ2hp
ZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+IEZpeCBhbiBpc3N1ZSB0aGF0IHBsYW5lIGNvb3JkaW5h
dGUgd2FzIG5vdCBzYXZlZCB3aGVuDQo+ID4gY2FsbGluZyBhc3luYyB1cGRhdGUuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5j
b20+DQo+IA0KPiAgRnJvbSB3aGF0IEkgdW5kZXJzdGFuZCwgdGhpcyBpcyBhIGZpeCBmb3IgYW4g
aXNzdWUgdGhhdCB3YXMgcHJlc2VudA0KPiBiZWZvcmUNCj4geW91ciBuZXdseSBpbnRyb2R1Y2Vk
IGNvZGUuDQo+IA0KPiBUaGlzIG1lYW5zIHRoYXQgeW91IHdhbnQgdG8gYWRkIGEgRml4ZXMgdGFn
LCBhbmQgdGhhdCB5b3Ugc2hvdWxkIGFsc28NCj4gc2VuZA0KPiB0aGlzIGNvbW1pdCBzZXBhcmF0
ZWx5IGZyb20gdGhlIElHVCBzZXJpZXMuIFBsZWFzZSBkbyB0aGF0Lg0KDQpHb3QgaXQsIHdpbGwg
YWRkIGEgZml4IHRhZyBpbiB0aGUgbmV4dCB2ZXJzaW9uLiBCdXQgc2luY2Ugd2l0aG91dCB0aGlz
DQpwYXRjaCwgSUdUIHdpbGwgZmFpbCBhdCBzb21lIHRlc3QgY2FzZXMsIGNvdWxkIHdlIHN0aWxs
IHNlbmQgdGhlbSBpbg0KdGhlIHNhbWUgc2VyaWVzIHNvIElHVCBjYW4gcGFzcyBvdXQtb2YtdGhl
LWJveD8NCg0KVGhhbmtzLA0KDQpIc2lhbyBDaGllbiBTdW5nDQo=
