Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2DF7A40A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbjIRFwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbjIRFwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:52:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B8E133;
        Sun, 17 Sep 2023 22:51:45 -0700 (PDT)
X-UUID: 717c8d2055e711eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j21iXD2EXWL2GdrQKzkb5LDI80ENWR13kaDWe7e2DSE=;
        b=mdaNNKWiQRZXeZnp5k87PqZfPp4RF+1mq0+97ovDB34zj6sL9KtZOMWWxmjHAQ2nYpGk87h4gRqYqaR84ZrpyE56jNyS8ze0S+kV86B03oGPlf0WRtz7bOyf7DHvGIWHBBe3ULp5vo26Wy2WRb5lUq/VEbeToX7JylFOXVmSlxY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:748c19dd-ce7c-48f0-a03e-6086f063a41f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:1bb30e14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 717c8d2055e711eea33bb35ae8d461a2-20230918
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 641183140; Mon, 18 Sep 2023 13:51:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 13:51:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 13:51:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXAOyz12LXcYj8UwKJTrnm0IuKKh8Jqi4CqYBxDhh/vXv8bPVeAB81Ht5SRDzfo1u+gQcUXNLMoFm+e963Z4x1PyXBZMh/aAHmab4c5TzlLdTVA3plpnTUH7PTqI6z3WkPGUEhE9l6VoECwVJoRRX+1xav8P4lCusxhqhfpOT0TZO7M3+ey20SXfpi86KWYPneFgWbA22hzVPynQaou0Syoh8hQX/ZVzqE26X7cB4lz7VXEd8u3UL4ysgoL/phUQtDKTyc7pSwGKPcZPQ2Gq8D/IaGU3hDxYOfH8vSzjw+WZzlal8S4DUiT3iuwakkjRidWZaBKZwM32TNx9U46vIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j21iXD2EXWL2GdrQKzkb5LDI80ENWR13kaDWe7e2DSE=;
 b=kCdvR+y6L5h+bQ0czgLhuaP3YulH3LtR1u03HhuxxY/lzoy9QeWvF4v/0PZhJrWTWSk5iBSwun9RElgNhhE6NS52bASFS+GuQG4GCM643CyDKOBdAF2mwQiJZo7BMUENQL4Sv8xUfOZ+oSzyw+BZiVWsDloVyqaMQBYH2cFoXToq/c5UkI2xq699v03jr1y2KLk9x2ZkwmeWDVmMKFLJu5iSiTMwq1jYtj3ueJMDChGovZ4HJdQ5T5E7YgMufbWS83kbj6rM+zDertsmxzExSdEZAKZC+GhyQmfQetTFWky45O5RvFe4x5AprrfTsQoYXttiVyIfl5dSaIJr/toIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j21iXD2EXWL2GdrQKzkb5LDI80ENWR13kaDWe7e2DSE=;
 b=kMrHE6J5oHJnKeh+ff3f5WEOse1giq7ljfAihiMwSjAX5QDpOe8p+AV80DUYy8YwAq7DOIfvT/pNIjEMQsi3AWKcDxGvvm3hDsvN9oIT0lnPtqqrKdOfTkRRBqR9gs3/Bp0E9pss7exBvj3d2rdBc4y5ISgoOFYSoDsxOaPs0Ho=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB6720.apcprd03.prod.outlook.com (2603:1096:400:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 05:51:38 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::34d1:7152:7f28:8af8]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::34d1:7152:7f28:8af8%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 05:51:38 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder
 driver
Thread-Topic: [PATCH 12/14] media: medkatek: vcodec: set secure mode to
 decoder driver
Thread-Index: AQHZ5K/xmXjsPSANs0u2pLMArEpvXrAVxwwAgAEnPICABKRcgA==
Date:   Mon, 18 Sep 2023 05:51:37 +0000
Message-ID: <081e3399a75d8788ea26eac44c1f52c028869996.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-13-yunfei.dong@mediatek.com>
         <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
         <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
In-Reply-To: <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB6720:EE_
x-ms-office365-filtering-correlation-id: c956f2cf-0bb4-4e5b-46e6-08dbb80b52da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Nt0B/4J7tM9V+buCD0srZ8RZJDjgggPTX84AH1C1nzfGk98kYpxSvmI7FMr09+Y679lTNF8YzrEA0hOfEiLdSb/AObnNHtheSvLDzm6AmXcyjhlpGFzXRUnPTukyYCO9t42/60Jo9saYGPrbx1x5lDQmAzXrthXbHilR5z3yt+KuUAloeRcPJVq/7Z/r4PsN3GE1NuKSiHC+BM0g96wnGgLQH4WOE+AkZ9zeo/CdboLXa5zq3g+oSGaLOkT0zH77OQkLqqJvdtN1YR8xHco0gDXuDiGwt7PPk2pwonkgtCE9nl4qWXQUmHOIPTTV5Zk3UoOUqn9y1ANfT7X28DcPMcHf0kECsLkeGTvR1dB6cqVb4jDUUGzIeASaBWOUrqEn03IXvvsSbyOh4RZlVQxoW2ZyaDu8/hdE8Yp2+HAe+R/ZbWQnwg1lL6dpOf4IhSmjI4SqTouoOPpgiRplDh7GOp9oDvMkb0wOU/OICC1ZVkRg0B4T4pfY3gQy2MoX0OJGVwbMM/Fa0XUA5dwCtwtLgt2Vyj/eWkNopoXPK6LOi73TuoUqyKWl37qpKS/L0tOgnwIxmq0tDguak98jIq8m7WxelzZPEtsT4jOMSnivuob+IxkpvfF+htWhzyHXMeniKD02552GPopeo+6yBDeCaGN1Ao+NcTd9ohbOMBWSKuajhauXGmJPlXKClCSpQ1B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199024)(1800799009)(186009)(85182001)(86362001)(83380400001)(122000001)(36756003)(6486002)(2616005)(53546011)(26005)(66574015)(6506007)(6512007)(66556008)(66446008)(66476007)(478600001)(316002)(54906003)(64756008)(71200400001)(66946007)(91956017)(76116006)(110136005)(2906002)(7416002)(5660300002)(38100700002)(38070700005)(4326008)(8676002)(41300700001)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzRpZkFaYUpPdnRRdm1BUkxYV3dHaHhTa2FDQW9yUVEwVlEwU0dibkdPSmVN?=
 =?utf-8?B?cUhEem1DeURaWnc2Tmw4RDYyeUxPZUN2N0I0WDRpckxqYzdOMjRoMWdtQ2I0?=
 =?utf-8?B?cjZoMGQ5VlFxKzNTRWtTUUd2eDJWQ2F5M04wdzZJbDUvSHlPSzZzYitCY2Nt?=
 =?utf-8?B?VkpCeVNRN2tpWkNzajE3cjNrbzVkNE1XK0ovSVFDdE5ITmFoVjdaM0JST29k?=
 =?utf-8?B?VUVSblYzVkQ0YWlxUVZFeExCQUp4U1VmcUJzSWF4ekRBTUtHaFBXMGFHeTVZ?=
 =?utf-8?B?alNwSGRBbERWVmhkUVl1ckdONGE4UmQ4b0JsYVRHOXQzcTNPdWdRR3VJS3lF?=
 =?utf-8?B?RjQ3UHZZQ3crUlVGZEdqemhRSlVlR3l0WHFEbnpHRE9NTWVZenJNdnFOSzZ4?=
 =?utf-8?B?cXdyZE1idXhLRFE5Qm1tWFo0QlA1UitQbnFwbUFxQXRheXlqaTdocU4rcDVE?=
 =?utf-8?B?RGFtSGlRakFTN0Q1S1I5dXdsb2JCQ2FoOVpjR3M5VlQvVU0vT3VxcFpSelps?=
 =?utf-8?B?RWdXdDgrT1A3MkdYWVVpR2ZGWXRxQ29MT3dMUGlHdXg4V0lwSGVtZ3h4ZG5Y?=
 =?utf-8?B?NEU4U3BnMWI5dTZQVVRqVFFFNC84UXpONjh5YnJXUmV3NmRJeVFmcU9hMm90?=
 =?utf-8?B?SmdkS1laeUZQQlpndVBVaGVRRkZ6YXRhSG5VVHVoc1Q1ekxUZy9COTIyWjdI?=
 =?utf-8?B?UFJid0dHdVN4THN5TlIwSlpNd2hKSllCaU9BWUcvYkVBa29iL0IvZ3J6VDND?=
 =?utf-8?B?T285am9sU2xYTWpnNm5mTVVZM3JJSHBFalovYk9ueDc3ZHJTQnA0ZEIzdGFE?=
 =?utf-8?B?YUdnVXlzemVJS2lIbVFqTUFoVEpDSVI0aHg2amZvQ2hoZHU5cWYyZkI3eHp4?=
 =?utf-8?B?dEpWUEx6QWJyYWp2cHMrVkVIL0V1c2VXdDFDdDBXTE9zRTZ0NGd2aU9BQzBr?=
 =?utf-8?B?MzdRZUlIVTl3UzBkY2lKNzRaL3A5SnZubmVabzQ1Qi9vZnNrT3RlZEFSaHho?=
 =?utf-8?B?Q3JrOHZaaDhXZVBCWlptUlFpV29abjk3Q3ZOalZSd1ZZNkswcnlMUlR5amxu?=
 =?utf-8?B?b0tSTWtSVTE4amRtYW9DMDlqY3E3NG1FVUFJVnZTdjdoN2lTOFo2TzhnQlNZ?=
 =?utf-8?B?UmlXZFFNSEQrL242cXhoOTNNKyt2T0dqelR3aGxVN2tBUXVQWFNGYUVIOWJj?=
 =?utf-8?B?SFNZWm1uK0wza0RzSHQxVFdkcnZuQnV0VnYxaDFNTloyQjRMWEM1U1M2Ymxh?=
 =?utf-8?B?Y0dERzBucEFKanY0Q0hJM1g5NmFoWXd3Qkl3QVpSYWJLUDBZS25uQXpoMzEy?=
 =?utf-8?B?MkdvUWc4eXRxZVptY0dIb3VUeU5rZi9NM2lHeHpEaWh2RTZyWlZMSTN6UTVD?=
 =?utf-8?B?RkRQOWpGb2g5YVZCY0J2bUhqRnIyK0F1TWV4VXkvUldjQlZoVTY2WXhYSUln?=
 =?utf-8?B?aUJuTFEvRm8zVGhmQTdFUWNtQVFuNUVuUGxRSEhRSVRXdE5Nc2x4cEs4aGJj?=
 =?utf-8?B?aTZjdERHNmdBeldVNnBMV2ppaVBqcVZMd1FKdHMrNWRCeDlLcGs1eHVVbC9S?=
 =?utf-8?B?RWEvT0lFRFlHNDVmbzVxSU1HWWY4S3ZyT1djOHpybzJ4VC9NUTd0Y3BPeDBL?=
 =?utf-8?B?YnRSeUdyMy83WWpqaGNSUnlUcjNuSjdRaThQcTh5ZlZMa2tjY1FFYkdJaTZ0?=
 =?utf-8?B?dW1pQTFPN2hQRFhFc2sxWllJNEZ6YU5yQmlCWTR2UVQ3YUVNMysxT1FRZldo?=
 =?utf-8?B?RmFabjYrQytSYXFjeThnTllVeUJQOHlCM3F1emNxRzlhN3FLRGJUSGMveXJM?=
 =?utf-8?B?K2MzQmx1Tlo4K2ptOFdCVkFPWjEzdWU1c2pnY09SY0xNVmtKRlpPOFM3bSs3?=
 =?utf-8?B?UlFEZDBrVzFaa0t4V0RVaktxRzB2a3pRaGJXbi9mR0Z6Y0FlcHZ4Tm9SUFcy?=
 =?utf-8?B?NUwxRy82c3hjVHZQN2hrMnFFWmpGbHFxRGRZMHp3VU9oZlJ4WENsUU1iK1JH?=
 =?utf-8?B?RmFNd3ZSY2JHUVI3M2RHb25IVk5wY2VQVnQwc0VXajNmc2ZNTnRQSDJrM2xW?=
 =?utf-8?B?YXZTa0ViZkVFblkwN0tEN09BR2t5N0VRMC8ySTl6S0pLOU9LR3hpTUlhakNj?=
 =?utf-8?B?N2FZODg0YUR4RE1jbFBOK3BZdytwTlhGYlFlZWh2ZllZdlBlbWFXMjViU080?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF2AF8CBD63B0044B4E588C6FBB97BEB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c956f2cf-0bb4-4e5b-46e6-08dbb80b52da
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 05:51:37.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3FvHptF26zBfDtJ9VG1+R2E3E7jlD4AEdYCZXy30z3tHyrGjeZbdJOEVvAOZW5rwuO0BWfV7kgJu/nnf7YWC843F0ozgD6QQrHSucVjZ+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6720
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.889300-8.000000
X-TMASE-MatchedRID: x2HXvaraFomnykMun0J1wpmug812qIbzjLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP2pD1R7N5OROLuqk4cq52pzumw
        aiQr4L/+3iatEqGkBbMeZRK81L4ze3wijxsym1h2d27eF5UDFo/txZhrDMIeDdEZHsoCzSFxm+j
        6YVbX2YPAMlpNjRTDW1S+wyEMlXe8KT+RHLhCkHOKXavbHY/C1O69hrW/YgWFtw+n+iKWyyABqC
        o7Y9xsXnF/drm2N7fwE4nL5h7jyP5e9tqFIZ/dgR+GtoiXVeDENmmuV06qWFv0TP/kikeqn34di
        MYeUVicANWOM4Q1H//9Z+RevK1F4/02XRYC/8esmZusHWPhfCtFqG4/BpDVafUOf4Mp5xtbNOTX
        XqCIFncesmeQEPdL867Tryj0uZPouFOuOD0D2lLar4tnNxmAKbv16+gil4jfxxaAXDrCns0NPdQ
        OE8jaazLaR/NpnmKS1G7TDHd+6r4PkG71n77vIoprTEHvewAAgQCwWYAjSWnaMP8m6qk6SrdLyX
        K1V+LiYGPv1m8ZAtrbS7h/dNTlHr78SC5iivxzSBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq5d
        3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.889300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CC8107D4337C73FFDA9563C572978105527406062DE4C1027DA49DFCCA4EB1F82000:8
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucyAmIE5pY29sYXMsDQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQoNCk9uIFR1ZSwg
MjAyMy0wOS0xMiBhdCAxMTozMCArMDIwMCwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPiAgCSANCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gIEhpLA0KPiANCj4gT24gOS8xMS8yMyAxNzo1NCwgTmljb2xhcyBEdWZyZXNuZSB3cm90
ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBMZSBsdW5kaSAxMSBzZXB0ZW1icmUgMjAyMyDDoCAyMDo1
OSArMDgwMCwgWXVuZmVpIERvbmcgYSDDqWNyaXQgOg0KPiA+PiBTZXR0aW5nIHNlY3VyZSBtb2Rl
IGZsYWcgdG8ga2VybmVsIHdoZW4gdHJ5aW5nIHRvIHBsYXkgc2VjdXJlDQo+IHZpZGVvLA0KPiA+
PiB0aGVuIGRlY29kZXIgZHJpdmVyIHdpbGwgaW5pdGlhbGl6ZSB0ZWUgcmVsYXRlZCBpbnRlcmZh
Y2UgdG8NCj4gc3VwcG9ydA0KPiA+PiBzdnAuDQo+ID4gDQo+ID4gDQo+ID4gVGhpcyBpcyBub3Qg
d2hhdCB0aGUgcGF0Y2ggaXMgZG9pbmcsIHBsZWFzZSByZXdvcmsuIFRoaXMgcGF0Y2ggaXMNCj4g
YW4gdmVuZG9yIEFQSQ0KPiA+IGFkZGl0aW9uIGludHJvZHVjaW5nIFY0TDJfQ0lEX01QRUdfTVRL
X1NFVF9TRUNVUkVfTU9ERS4gSSBzaG91bGQNCj4gbm90IGhhdmUgdG8NCj4gPiByZWFkIHlvdXIg
cGF0Y2ggdG8gdW5kZXJzdGFuZCB0aGlzLg0KPiA+IA0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiA+PiAtLS0NCj4gPj4g
IC4uLi92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19zdGF0ZWxlc3MuYyAgICAgfCAxNQ0K
PiArKysrKysrKysrKysrKy0NCj4gPj4gIGRyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3Ry
bHMtZGVmcy5jICAgICAgICAgfCAgNSArKysrKw0KPiA+PiAgaW5jbHVkZS91YXBpL2xpbnV4L3Y0
bDItY29udHJvbHMuaCAgICAgICAgICAgICAgICB8ICAxICsNCj4gPj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0
DQo+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtf
dmNvZGVjX2RlY19zdGF0ZQ0KPiBsZXNzLmMNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21l
ZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjX3N0YXRlDQo+IGxlc3MuYw0KPiA+
PiBpbmRleCBkMmIwOWNlOWYxY2YuLmE5ODExNzhjMjVkOSAxMDA2NDQNCj4gPj4gLS0tDQo+IGEv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVj
X2RlY19zdGF0ZQ0KPiBsZXNzLmMNCj4gPj4gKysrDQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19zdGF0ZQ0KPiBsZXNzLmMN
Cj4gPj4gQEAgLTUzNSw2ICs1MzUsMTcgQEAgc3RhdGljIGludCBtdGtfdmRlY19zX2N0cmwoc3Ry
dWN0IHY0bDJfY3RybA0KPiAqY3RybCkNCj4gPj4gIGN0cmwtPnZhbCA9IG10a19kbWFfY29udGln
X2dldF9zZWN1cmVfaGFuZGxlKGN0eCwgY3RybC0+dmFsKTsNCj4gPj4gIG10a192NGwyX3ZkZWNf
ZGJnKDMsIGN0eCwgImdldCBzZWN1cmUgaGFuZGxlOiAlZCA9PiAweCV4IiwNCj4gc2VjX2ZkLCBj
dHJsLT52YWwpOw0KPiA+PiAgYnJlYWs7DQo+ID4+ICtjYXNlIFY0TDJfQ0lEX01QRUdfTVRLX1NF
VF9TRUNVUkVfTU9ERToNCj4gPiANCj4gPiBTdGVwcGluZyBiYWNrIGEgbGl0dGxlIGFuZCBmb2N1
c2luZyBvbiB0aGUgQVBJLCB3aGF0IG1ha2VzIHlvdXINCj4gZHJpdmVyIHNvDQo+ID4gc3BlY2lh
bCB0aGF0IGl0IHNob3VsZCBiZSB0aGUgb25seSBvbmUgaGF2aW5nIGEgInNlY3VyZSBtb2RlIiA/
IFdlDQo+IGFyZSB0b3VjaGluZw0KPiA+IGluIGdhcCBpbiB0aGUgbWVkaWEgcGlwZWxpbmUgaW4g
TGludXgsIGFuZCB0aGlzIHNob3VsZCBjb21lIHdpdGgNCj4gY29uc2lkZXJhdGlvbg0KPiA+IG9m
IHRoZSBnbG9iYWwgQVBJLg0KPiA+IA0KPiA+IFdoeSBpcyB0aGlzIEFQSSBiZXR0ZXIgdGhlbiBs
ZXQncyBzYXkgR29vZ2xlIEFuZHJvaWQgb25lLCB3ZXJlIHRoZXkNCj4gZXhwb3NlIDINCj4gPiBk
ZXZpY2Ugbm9kZXMgaW4gdGhlaXIgZm9yayBvZiB0aGUgTUZDIGRyaXZlciAoYSBzZWN1cmUgYW5k
IGEgbm9uDQo+IHNlY3VyZSBvbmUpID8NCj4gDQo+IFBlcmhhcHMgaXQgaXMgYSBnb29kIGlkZWEg
dG8gZmlyc3QgcG9zdCBhbiBSRkMgd2l0aCBhbiB1QVBJIHByb3Bvc2FsDQo+IG9uIGhvdyB0bw0K
PiBoYW5kbGUgc2VjdXJlIHZpZGVvLiBJIHN1c3BlY3QgdGhpcyBpc24ndCBtZWRpYXRlayBzcGVj
aWZpYywgb3RoZXINCj4gU29DcyB3aXRoDQo+IHRlZSBzdXBwb3J0IGNvdWxkIHVzZSB0aGlzIGFz
IHdlbGwuDQo+IA0KPiBBcyBOaWNvbGFzIHNhaWQsIGl0J3MgbG9uZyBrbm93biB0byBiZSBhIGdh
cCBpbiBvdXIgbWVkaWEgc3VwcG9ydCwgc28NCj4gaXQgaXMNCj4gcmVhbGx5IGdyZWF0IHRoYXQg
eW91IHN0YXJ0ZWQgd29yayBvbiB0aGlzLCBidXQgeW91IG5lZWQgdG8gbG9vayBhdA0KPiB0aGlz
IGZyb20NCj4gYSBtb3JlIGdlbmVyaWMgcG9pbnQtb2YtdmlldywgYW5kIG5vdCBtZWRpYXRlay1z
cGVjaWZpYy4NCj4gDQpXaGV0aGVyIHlvdXIgaGF2ZSBhbnkgYWR2aWNlIGFib3V0IGhvdyB0byBk
byBhIG1vcmUgZ2VuZXJpYyBkcml2ZXIgdG8NCmhhbmRsZSBzZWN1cmUgdmlkZW8gcGxheWJhY2s/
DQoNClRoZXJlIGFyZSBzZXZlcmFsIGtpbmQgb2YgYnVmZmVyOiBvdXRwdXQgcXVldWUgYnVmZmVy
L2NhcHR1cmUgcXVldWUNCmJ1ZmZlci93b3JraW5nIGJ1ZmZlci4NCg0Kb3V0cHV0IGFuZCBjYXB0
dXJlIHF1ZXVlIGJ1ZmZlcjogdXNlciBzcGFjZSB3aWxsIGNhbGwgdGVlIHJlbGF0ZWQNCmludGVy
ZmFjZSB0byBhbGxvY2F0ZSBzZWN1cmUgaGFuZGxlLiBXaWxsIGNvbnZlcnQgdG8gc2VjdXJlIGhh
bmRsZSB3aXRoDQp2NGwyIGZyYW1ld29yaywgdGhlbiBzZW5kIHNlY3VyZSBoYW5kbGUgdG8gb3B0
ZWUtb3MuDQoNCndvcmtpbmcgYnVmZmVyOiBjYWxsaW5nIGRtYV9oZWFwIGFuZCBkbWFfYnVmIHRv
IGdldCBzZWN1cmUgbWVtb3J5DQpoYW5kbGUsIHRoZW4gY292ZXJ0IHNlY3VyZSBpb3ZhIGluIG9w
dGVlLW9zLg0KDQpVc2luZyB0aGUgc2FtZSBrZXJuZWwgZHJpdmVyIGZvciBzdnAgYW5kIG5vbi1z
dnAgcGxheWJhY2ssIGp1c3QgdGhlDQpidWZmZXIgdHlwZSBhcmUgZGlmZmVyZW50LiBOb3JtYWwg
aXMgaW92YSBhbmQgc2VjdXJlIGlzIHNlY3VyZSBoYW5kbGUuDQoNClVzZXIgZHJpdmVyIHdpbGwg
dGVsbCB0aGUga2VybmVsIGRyaXZlciB3aXRoIENJRCBjb250cm9sIHdoZXRoZXIgdGhlDQpjdXJy
ZW50IHBsYXliYWNrIGlzIHN2cCBvciBub24tc3ZwLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkg
RG9uZw0KPiBSZWdhcmRzLA0KPiANCj4gSGFucw0KPiANCj4gPiANCj4gPiByZWdhcmRzLA0KPiA+
IE5pY29sYXMNCj4gPiANCj4gPiBwLnMuIHlvdSBmb3Jnb3QgdG8gZG9jdW1lbnQgeW91ciBjb250
cm9sIGluIHRoZSBSU1QgZG9jLCBwbGVhc2UgZG8NCj4gaW4gZm9sbG93aW5nDQo+ID4gcmVsZWFz
ZS4NCj4gPiANCj4gPj4gK2N0eC0+aXNfc3ZwX21vZGUgPSBjdHJsLT52YWw7DQo+ID4+ICsNCj4g
Pj4gK2lmIChjdHgtPmlzX3N2cF9tb2RlKSB7DQo+ID4+ICtyZXQgPSBtdGtfdmNvZGVjX2RlY19v
cHRlZV9vcGVuKGN0eC0+ZGV2LT5vcHRlZV9wcml2YXRlKTsNCj4gPj4gK2lmIChyZXQpDQo+ID4+
ICttdGtfdjRsMl92ZGVjX2VycihjdHgsICJvcGVuIHNlY3VyZSBtb2RlIGZhaWxlZC4iKTsNCj4g
Pj4gK2Vsc2UNCj4gPj4gK210a192NGwyX3ZkZWNfZGJnKDMsIGN0eCwgImRlY29kZXIgaW4gc2Vj
dXJlIG1vZGU6ICVkIiwgY3RybC0NCj4gPnZhbCk7DQo+ID4+ICt9DQo+ID4+ICticmVhazsNCj4g
Pj4gIGRlZmF1bHQ6DQo+ID4+ICBtdGtfdjRsMl92ZGVjX2RiZygzLCBjdHgsICJOb3Qgc3VwcG9y
dGVkIHRvIHNldCBjdHJsIGlkOiAweCV4XG4iLA0KPiBoZHJfY3RybC0+aWQpOw0KPiA+PiAgcmV0
dXJuIHJldDsNCj4gPj4gQEAgLTU3Myw3ICs1ODQsNyBAQCBzdGF0aWMgaW50IG10a192Y29kZWNf
ZGVjX2N0cmxzX3NldHVwKHN0cnVjdA0KPiBtdGtfdmNvZGVjX2RlY19jdHggKmN0eCkNCj4gPj4g
IHVuc2lnbmVkIGludCBpOw0KPiA+PiAgc3RydWN0IHY0bDJfY3RybCAqY3RybDsNCj4gPj4gIA0K
PiA+PiAtdjRsMl9jdHJsX2hhbmRsZXJfaW5pdCgmY3R4LT5jdHJsX2hkbCwgTlVNX0NUUkxTICsg
MSk7DQo+ID4+ICt2NGwyX2N0cmxfaGFuZGxlcl9pbml0KCZjdHgtPmN0cmxfaGRsLCBOVU1fQ1RS
TFMgKyAyKTsNCj4gPj4gIGlmIChjdHgtPmN0cmxfaGRsLmVycm9yKSB7DQo+ID4+ICBtdGtfdjRs
Ml92ZGVjX2VycihjdHgsICJ2NGwyX2N0cmxfaGFuZGxlcl9pbml0IGZhaWxlZFxuIik7DQo+ID4+
ICByZXR1cm4gY3R4LT5jdHJsX2hkbC5lcnJvcjsNCj4gPj4gQEAgLTU5Miw2ICs2MDMsOCBAQCBz
dGF0aWMgaW50IG10a192Y29kZWNfZGVjX2N0cmxzX3NldHVwKHN0cnVjdA0KPiBtdGtfdmNvZGVj
X2RlY19jdHggKmN0eCkNCj4gPj4gIA0KPiA+PiAgY3RybCA9IHY0bDJfY3RybF9uZXdfc3RkKCZj
dHgtPmN0cmxfaGRsLA0KPiAmbXRrX3Zjb2RlY19kZWNfY3RybF9vcHMsDQo+ID4+ICAgVjRMMl9D
SURfTVBFR19NVEtfR0VUX1NFQ1VSRV9IQU5ETEUsIDAsIDY1NTM1LCAxLCAwKTsNCj4gPj4gK2N0
cmwgPSB2NGwyX2N0cmxfbmV3X3N0ZCgmY3R4LT5jdHJsX2hkbCwNCj4gJm10a192Y29kZWNfZGVj
X2N0cmxfb3BzLA0KPiA+PiArIFY0TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9ERSwgMCwg
NjU1MzUsIDEsIDApOw0KPiA+PiAgDQo+ID4+ICB2NGwyX2N0cmxfaGFuZGxlcl9zZXR1cCgmY3R4
LT5jdHJsX2hkbCk7DQo+ID4+ICANCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdjRs
Mi1jb3JlL3Y0bDItY3RybHMtZGVmcy5jDQo+IGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRs
Mi1jdHJscy1kZWZzLmMNCj4gPj4gaW5kZXggZDhjZjAxZjc2YWFiLi5hNTA3MDQ1YTNmMzAgMTAw
NjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3RybHMtZGVmcy5j
DQo+ID4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3RybHMtZGVmcy5jDQo+
ID4+IEBAIC0xMDQyLDYgKzEwNDIsNyBAQCBjb25zdCBjaGFyICp2NGwyX2N0cmxfZ2V0X25hbWUo
dTMyIGlkKQ0KPiA+PiAgY2FzZSBWNEwyX0NJRF9NUEVHX1ZJREVPX1JFRl9OVU1CRVJfRk9SX1BG
UkFNRVM6cmV0dXJuICJSZWZlcmVuY2UNCj4gRnJhbWVzIGZvciBhIFAtRnJhbWUiOw0KPiA+PiAg
Y2FzZSBWNEwyX0NJRF9NUEVHX1ZJREVPX1BSRVBFTkRfU1BTUFBTX1RPX0lEUjpyZXR1cm4gIlBy
ZXBlbmQNCj4gU1BTIGFuZCBQUFMgdG8gSURSIjsNCj4gPj4gIGNhc2UgVjRMMl9DSURfTVBFR19N
VEtfR0VUX1NFQ1VSRV9IQU5ETEU6cmV0dXJuICJNZWRpYVRlayBEZWNvZGVyDQo+IGdldCBzZWN1
cmUgaGFuZGxlIjsNCj4gPj4gK2Nhc2UgVjRMMl9DSURfTVBFR19NVEtfU0VUX1NFQ1VSRV9NT0RF
OnJldHVybiAiTWVkaWFUZWsgRGVjb2Rlcg0KPiBzZXQgc2VjdXJlIG1vZGUiOw0KPiA+PiAgDQo+
ID4+ICAvKiBBVjEgY29udHJvbHMgKi8NCj4gPj4gIGNhc2UgVjRMMl9DSURfTVBFR19WSURFT19B
VjFfUFJPRklMRTpyZXR1cm4gIkFWMSBQcm9maWxlIjsNCj4gPj4gQEAgLTE0NDIsNiArMTQ0Mywx
MCBAQCB2b2lkIHY0bDJfY3RybF9maWxsKHUzMiBpZCwgY29uc3QgY2hhcg0KPiAqKm5hbWUsIGVu
dW0gdjRsMl9jdHJsX3R5cGUgKnR5cGUsDQo+ID4+ICAqdHlwZSA9IFY0TDJfQ1RSTF9UWVBFX0lO
VEVHRVI7DQo+ID4+ICAqZmxhZ3MgfD0gVjRMMl9DVFJMX0ZMQUdfV1JJVEVfT05MWTsNCj4gPj4g
IGJyZWFrOw0KPiA+PiArY2FzZSBWNEwyX0NJRF9NUEVHX01US19TRVRfU0VDVVJFX01PREU6DQo+
ID4+ICsqdHlwZSA9IFY0TDJfQ1RSTF9UWVBFX0lOVEVHRVI7DQo+ID4+ICsqZmxhZ3MgfD0gVjRM
Ml9DVFJMX0ZMQUdfV1JJVEVfT05MWTsNCj4gPj4gK2JyZWFrOw0KPiA+PiAgY2FzZSBWNEwyX0NJ
RF9VU0VSX0NMQVNTOg0KPiA+PiAgY2FzZSBWNEwyX0NJRF9DQU1FUkFfQ0xBU1M6DQo+ID4+ICBj
YXNlIFY0TDJfQ0lEX0NPREVDX0NMQVNTOg0KPiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiBiL2luY2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRy
b2xzLmgNCj4gPj4gaW5kZXggN2IzNjk0OTg1MzY2Li44OGU5MGQ5NDNlMzggMTAwNjQ0DQo+ID4+
IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xzLmgNCj4gPj4gKysrIGIvaW5j
bHVkZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiA+PiBAQCAtOTU3LDYgKzk1Nyw3IEBA
IGVudW0gdjRsMl9tcGVnX21mYzUxX3ZpZGVvX2ZvcmNlX2ZyYW1lX3R5cGUgew0KPiA+PiAgLyog
IE1QRUctY2xhc3MgY29udHJvbCBJRHMgc3BlY2lmaWMgdG8gdGhlIE1lZGlhVGVrIERlY29kZXIN
Cj4gZHJpdmVyIGFzIGRlZmluZWQgYnkgVjRMMiAqLw0KPiA+PiAgI2RlZmluZSBWNEwyX0NJRF9N
UEVHX01US19CQVNFKFY0TDJfQ1RSTF9DTEFTU19DT0RFQyB8IDB4MjAwMCkNCj4gPj4gICNkZWZp
bmUNCj4gVjRMMl9DSURfTVBFR19NVEtfR0VUX1NFQ1VSRV9IQU5ETEUoVjRMMl9DSURfTVBFR19N
VEtfQkFTRSs4KQ0KPiA+PiArI2RlZmluZQ0KPiBWNEwyX0NJRF9NUEVHX01US19TRVRfU0VDVVJF
X01PREUoVjRMMl9DSURfTVBFR19NVEtfQkFTRSs5KQ0KPiA+PiAgDQo+ID4+ICAvKiAgQ2FtZXJh
IGNsYXNzIGNvbnRyb2wgSURzICovDQo+ID4+ICANCj4gPiANCj4gDQo=
