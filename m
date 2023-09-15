Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE87A18B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjIOI0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjIOI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:26:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C130E9;
        Fri, 15 Sep 2023 01:25:14 -0700 (PDT)
X-UUID: 62ced9a653a111eea33bb35ae8d461a2-20230915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mPC8uPqzhHqKNep5hSuGwN31uuXJpXkMUZRAlfHwIjE=;
        b=AklkU9KrCRQe51jRyD4XDBRE8DiRYSF2Fjz6WUAMRon7WXKqq/3eEVBCyNIlRBTDickcZrxeSEPdAKmK/V65KveoSuAgpn1kGiJWJbcvV85382XM06zNR/WMPR3+qx0XlllmUNfVOEdibjzuIWtn3N1JbhqVvnbtjoYvCig9z0k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:a664cc15-2da8-4df4-9811-1ea14ad9590f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:6a8f10c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 62ced9a653a111eea33bb35ae8d461a2-20230915
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 925441512; Fri, 15 Sep 2023 16:25:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Sep 2023 16:25:09 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Sep 2023 16:25:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGuO/2uokdnJAor70lAHnUmgUOtzSemEF2jke1oQ/IA9BciDo0G2SQgqkiCoMAzIE+lfmKo4lIlZYx+e4KSjBlqP5wuYHI1RRZsJEjkX7a1PratZZGu2SxEDy2fbJCtXUh96si4ekUE89ubnhBIwCZFH9IbCLtOhjl38Comd7AiY49Uk/vEdNPVdHFE43N/5f263syV7H7Ug+R3EFxSzWRcwJEAlLYGDGgMf2dlT1DdPk3fBT82ZiKx9T0/zSrtWLDl6ssBu8nUz8hJKz8jV1XkqGJ9RcHRUFoTWDdgJea5dq1YihfR/pN7hsq4/ovZtu480uolIb7Isomlat7XSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPC8uPqzhHqKNep5hSuGwN31uuXJpXkMUZRAlfHwIjE=;
 b=dz3ZmkJ6FRZRewW9iuogqN4vhudecG5VksSmHCuSTZoXNPZMyTjp6Y8XlHBUkTryisyByCrR42Js+QHk6o84ptffc6nbtrhS9iRN3B91s5ja+DjGpGqRpP6U2mqAWsETeE6eLJJ+1vOfgAQWammTQ+nPoB1e/f/f5s9W3PAtRSOqGWeeNZ6fQl+MlWMXgdtxO2+dotqHNV0irjb5E6Hb/uabAzWuq3qLB/HpCg9CfLGfZHDtKpBhO+dS1Z0OMBZkFDXFfpsSqkGkH2riU23M181tjS5x/tzqddw1fG4r6+VJJUfHw112Lz78lmMGoDI0LSTMndHw3Mi3CtyY51SAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPC8uPqzhHqKNep5hSuGwN31uuXJpXkMUZRAlfHwIjE=;
 b=vSd+HfgUjR3kCHLtKu0bEZF1dwkPJN0RPGOfGsVHoDUde9BchSThILy0xWhB2MELPlpz8OU0xTaLUf5gAHKFNkDKINS4JVpRsLZYcoKBu050ZOPjv3uSbJav4ssKXC9pTgZPoud/aw8InorNiwLBBOZNhi9TDf8x665UBwgDA3M=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SI2PR03MB6082.apcprd03.prod.outlook.com (2603:1096:4:14c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 08:25:07 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::34d1:7152:7f28:8af8]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::34d1:7152:7f28:8af8%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 08:25:06 +0000
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
Thread-Index: AQHZ5K/xmXjsPSANs0u2pLMArEpvXrAVxwwAgAEnPICABKSZAA==
Date:   Fri, 15 Sep 2023 08:25:06 +0000
Message-ID: <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
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
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SI2PR03MB6082:EE_
x-ms-office365-filtering-correlation-id: edf4269f-77be-4cb0-7a06-08dbb5c54456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/MO8W5x392XGXRwyP0dmMHOUPJdBpzeLdCfDU0VfmrGG3Sk4EVDH0nRoEYNh5VzUbDYO7Nq0blBpECG8FsgE1lm3hKpCHANxKKzvwl/gs2VRSGwg5KjRlxUgofgxcryzyOScKt32a3zIB0DX+X2TgzNQT/Lbf89hmmy4H4lFkxZZ9ioBaC5stT3q5onL9ZXsrwByphet0DDu+kEbNDZHypQcb1GhvLEuwlyh1nJ8jT+1x6dWW4w749Dster3Vn3S7/YGjwdCb2xHibYyjXktcfrKXbEpNNSqeQcyOfFE7NihGZ5S4QpwKCRlpBoQRYZKRU1+Hzw0WdEKosVxG/pLMHyFsfp9+fTHgyrfArr9DrirdvLpbNF6hov9DjYJBQrN+bvy7rE8ZK5MREi/RrkekGeuL6Z3S9kUV06O7Eom3fp+YvkJd3LbSgzV/kUaqg3ZEyeeyiYO7Fv1q5kxv+jaeKQBhlP/yfW6lLG1P8eofgwOKQ8gtzYNINfoVStVWFC8jVMhgLtFdXGgLB2ELNhd+XE83E39GqoY/dXlyOp7aCueEKhK0VoTbPyRQqY7JIr/2qws1W/AzQLlKNcAFFrgr1wXCkCitYoBzL+iYb9wWnF/ag2X5N4YRJQkPIKGdw2hfoXzueqIfZS43xEUDOlYLsn9JCqxaDmc4BwrfPEvyZVFqb3Ip6a0DqfKtVayXqg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199024)(186009)(1800799009)(478600001)(66574015)(6486002)(6506007)(86362001)(2616005)(122000001)(38100700002)(38070700005)(6512007)(26005)(71200400001)(53546011)(83380400001)(91956017)(110136005)(316002)(41300700001)(54906003)(5660300002)(66556008)(76116006)(66476007)(64756008)(66446008)(66946007)(7416002)(2906002)(85182001)(36756003)(4326008)(8676002)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0tTalNINWh0VUJCTC9iYjVzWlUweURsazMyU3V2TThUUWJIQlVWeFd5NG0v?=
 =?utf-8?B?dlltMWR3UzJEdkNGZ1RsbURNblhmL2JyTHg5T0JjZm1TSkZ6a3h1bStyR1hh?=
 =?utf-8?B?YktjUzBtTnZTQm1xV0R2eEhueWFEVGloeFNlWklBclh2bmdBSGlhTjVDSW9C?=
 =?utf-8?B?SXpQV2ZrL0tkYUZPdDhadmlSY0FscTZuNzVJcXYrdEIyZjVsUkk4bGFXZ1l2?=
 =?utf-8?B?c1daZ0RiM3pFWGNhS3JDWEhBRWZkaWlnZHdjbkNMSW5RL3Rrb082NEF3R3U3?=
 =?utf-8?B?RW1URlg0eklHenU4K0o1M2w1ZmRwR2s1RXpZbEh3c3M0M2R6SmROaDF6Ylky?=
 =?utf-8?B?QXk1dE54bklKSTFpbU9UVXNNSEk1ckJjOHhBWC9jOUxMd2hDa3hLNzMwWlJC?=
 =?utf-8?B?NUxMaVhaYS9zSno0VDl4N09rVGtkTGd6d1kzc1NOUjh5NHlvc0VzYnA4S21l?=
 =?utf-8?B?cHVhZGVWbTdzU3lqamM1OFJBNEpaQ1B0RCt1WlZrTVhLMzZVZU5YSWFMTVBY?=
 =?utf-8?B?Tk9URzBib3lDdEorMXh0YjAxSFFCaUc2WFpqZFZrYm1ZaXc3U2s0bmlwN0lR?=
 =?utf-8?B?QkVNUzYvd0ZRTDdHVUtxNTdUakFEMFdiWHd3SWVMM2ZEZmtrU0k1K3lNVity?=
 =?utf-8?B?K0JleGR1MlJwRGMwbWJTMTlVS0pFODJkU054NnFUY0toL1I0bXB4WEdYVWpo?=
 =?utf-8?B?OVBtQWMzaFBGamJPbGNqUXUzWE1jZktIS1NxS1hrMlRiWENnTUdlbjYzN1V2?=
 =?utf-8?B?RzVYM1pWOTJwbUdzZzhQQk5DSFBndndFK0M4MXl5NzJoRk5IbHhReUl4aEJ3?=
 =?utf-8?B?VVJyWVpKWnNna0cwY2hVeGlkaU90bVRQamVhc3FHWFArNXVHUVpibzkwRnZ1?=
 =?utf-8?B?WlV6MDBWeDJYRDB2eTFJTUtPdTJwRHA3byt1T2FNcXNjcW9PZHdQL3lRS1J0?=
 =?utf-8?B?ZDFpOUVmT1JUK3BjUzFqaC9UanY5bkF0eW1OcTFsZUQ0bWhFRy9JMi96bmlD?=
 =?utf-8?B?c0ZBMTVLeTRHazVFaXBjNTRiKzdQbGpHeklHa2pjQlQxYnpoS0FlNXlEdnVP?=
 =?utf-8?B?Rkx0RG1GV3BUK01IRUhzY0Y5Z0dYQXErOFV3MDMvMVFMNHpBenAxVFlYUkZl?=
 =?utf-8?B?bGI1elV5NC9FMzZSMDVNenpad2VtUEFRK0dnb25LbFk5ckErZVpLOUJmYitL?=
 =?utf-8?B?U1d3RVhuakVwOXRTZnNUZ3VBTkdETDg5T3BDdEhMQ1A2L2IwLzFPSEtPVHR1?=
 =?utf-8?B?anYzSHl2WFlJZ3htMFlhRDI0c042SkJhMW9sTm5nYWtVNGlLWnBLLzZ3S1NL?=
 =?utf-8?B?OHpCQVR5ekh5SXl3aFZpWjFvcU10M3NkaTkvNkZUcEtwdUFLRTMyL1VvL3Vi?=
 =?utf-8?B?LzB4SEFWMS8wVjQvYmd0KzBTdXZGYm16U1ZPeUUxTFlGc0JnMDN0Ykp5Vjl0?=
 =?utf-8?B?Y3p2MGFKb0JkRC9IaCtzRllaRzM1MW1XdjI4NTZ6dHdERXA0czZLK1Y0bEdl?=
 =?utf-8?B?ZGgwK09mOVlYVUpxMkRpWkVQOEVtNkNPc2IrUnV0R0NZc0xTRE02VDZhNWMv?=
 =?utf-8?B?OWI5RlY3T1Rsd0RGbFZ6Z1BCMTZmQ0J6dXF3NlNwdDR3b05qU2pvMjY1ekRE?=
 =?utf-8?B?MnRSWnYySUxyUTRIR2VrSHkraWNTUGhFanRxbjZzdHRJaHBoU2FPUlJaR0lZ?=
 =?utf-8?B?MXFFcitsQU1VTENSaDZhdHNKU1dHYmF3Nk9CME9MSjBqN1BkcDFtYldJV0l1?=
 =?utf-8?B?NS9DdTR5VzZzN0lQY3AyZ1FobUs5K0oxdDBEOVM0bTBGT2QwanZIaVc0RklM?=
 =?utf-8?B?QVBybXlPYjB1N3VVTjA0Uzkzakw2cVdIek5DNEQyOWdxRWRmYlJ5Zm1TODJJ?=
 =?utf-8?B?MGdWRzNhUGl1cExqUkRFdTRZVkwxV3R5VUpDV24xWExuUDFlYTdYV2ZIMkVp?=
 =?utf-8?B?NEVEZ0xNcFppNVVyNDVLTmRIRkY2TXJwbmJWZDlHM3Zad3FrVk9TbEdtZDNZ?=
 =?utf-8?B?VFBneWJpN1hWRGZUWGNPN2FsSmtveXE2N0JOSWVFQU5lTWxVVWxpUW90VllP?=
 =?utf-8?B?UWpQY1RTbmJJZm8xcGdTeVdoekFEYnBGdWo0cG9IME9MSW5aVEpyTnZ2dzlw?=
 =?utf-8?B?eGROVUFWeGFjQWkzTWdCYTJJNERiV0UxYWFJZ3hTVk9ESmt5M2hjaG1JTFVI?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AED5485B382EAF478485AA2366E4B7A2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf4269f-77be-4cb0-7a06-08dbb5c54456
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 08:25:06.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVKzYLMSnVvnkMEZ0AZ82mmjqfAeEZ7DiJkeHNX+vs7pdJ5KglvofVdWpUVNht9e/1Xo4uYO2n46qEjWX0IkbIH8li45lilaTP7JImFoEok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6082
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
X-TM-SNTS-SMTP: 81875663DBF465382D6FB38F97A867682AB51F21BB98A802CE2E2895631F1C552000:8
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
OSArMDgwMCwgWXVuZmVpIERvbmcgYSDDqWNyaXQgOg0KPiA+ID4gU2V0dGluZyBzZWN1cmUgbW9k
ZSBmbGFnIHRvIGtlcm5lbCB3aGVuIHRyeWluZyB0byBwbGF5IHNlY3VyZQ0KPiANCj4gdmlkZW8s
DQo+ID4gPiB0aGVuIGRlY29kZXIgZHJpdmVyIHdpbGwgaW5pdGlhbGl6ZSB0ZWUgcmVsYXRlZCBp
bnRlcmZhY2UgdG8NCj4gDQo+IHN1cHBvcnQNCj4gPiA+IHN2cC4NCj4gPiANCj4gPiANCj4gPiBU
aGlzIGlzIG5vdCB3aGF0IHRoZSBwYXRjaCBpcyBkb2luZywgcGxlYXNlIHJld29yay4gVGhpcyBw
YXRjaCBpcw0KPiANCj4gYW4gdmVuZG9yIEFQSQ0KPiA+IGFkZGl0aW9uIGludHJvZHVjaW5nIFY0
TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9ERS4gSSBzaG91bGQNCj4gDQo+IG5vdCBoYXZl
IHRvDQo+ID4gcmVhZCB5b3VyIHBhdGNoIHRvIHVuZGVyc3RhbmQgdGhpcy4NCj4gPiANCj4gPiA+
IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVr
LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2Rl
Y19zdGF0ZWxlc3MuYyAgICAgfCAxNQ0KPiANCj4gKysrKysrKysrKysrKystDQo+ID4gPiAgZHJp
dmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy1kZWZzLmMgICAgICAgICB8ICA1ICsrKysr
DQo+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaCAgICAgICAgICAgICAg
ICB8ICAxICsNCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdA0KPiANCj4gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjX3N0YXRlDQo+
IGxlc3MuYw0KPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29k
ZXIvbXRrX3Zjb2RlY19kZWNfc3RhdGUNCj4gbGVzcy5jDQo+ID4gPiBpbmRleCBkMmIwOWNlOWYx
Y2YuLmE5ODExNzhjMjVkOSAxMDA2NDQNCj4gPiA+IC0tLQ0KPiANCj4gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjX3N0YXRlDQo+
IGxlc3MuYw0KPiA+ID4gKysrDQo+IA0KPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfc3RhdGUNCj4gbGVzcy5jDQo+ID4gPiBA
QCAtNTM1LDYgKzUzNSwxNyBAQCBzdGF0aWMgaW50IG10a192ZGVjX3NfY3RybChzdHJ1Y3QgdjRs
Ml9jdHJsDQo+IA0KPiAqY3RybCkNCj4gPiA+ICBjdHJsLT52YWwgPSBtdGtfZG1hX2NvbnRpZ19n
ZXRfc2VjdXJlX2hhbmRsZShjdHgsIGN0cmwtPnZhbCk7DQo+ID4gPiAgbXRrX3Y0bDJfdmRlY19k
YmcoMywgY3R4LCAiZ2V0IHNlY3VyZSBoYW5kbGU6ICVkID0+IDB4JXgiLA0KPiANCj4gc2VjX2Zk
LCBjdHJsLT52YWwpOw0KPiA+ID4gIGJyZWFrOw0KPiA+ID4gK2Nhc2UgVjRMMl9DSURfTVBFR19N
VEtfU0VUX1NFQ1VSRV9NT0RFOg0KPiA+IA0KPiA+IFN0ZXBwaW5nIGJhY2sgYSBsaXR0bGUgYW5k
IGZvY3VzaW5nIG9uIHRoZSBBUEksIHdoYXQgbWFrZXMgeW91cg0KPiANCj4gZHJpdmVyIHNvDQo+
ID4gc3BlY2lhbCB0aGF0IGl0IHNob3VsZCBiZSB0aGUgb25seSBvbmUgaGF2aW5nIGEgInNlY3Vy
ZSBtb2RlIiA/IFdlDQo+IA0KPiBhcmUgdG91Y2hpbmcNCj4gPiBpbiBnYXAgaW4gdGhlIG1lZGlh
IHBpcGVsaW5lIGluIExpbnV4LCBhbmQgdGhpcyBzaG91bGQgY29tZSB3aXRoDQo+IA0KPiBjb25z
aWRlcmF0aW9uDQo+ID4gb2YgdGhlIGdsb2JhbCBBUEkuDQo+ID4gDQo+ID4gV2h5IGlzIHRoaXMg
QVBJIGJldHRlciB0aGVuIGxldCdzIHNheSBHb29nbGUgQW5kcm9pZCBvbmUsIHdlcmUgdGhleQ0K
PiANCj4gZXhwb3NlIDINCj4gPiBkZXZpY2Ugbm9kZXMgaW4gdGhlaXIgZm9yayBvZiB0aGUgTUZD
IGRyaXZlciAoYSBzZWN1cmUgYW5kIGEgbm9uDQo+IA0KPiBzZWN1cmUgb25lKSA/DQo+IA0KPiBQ
ZXJoYXBzIGl0IGlzIGEgZ29vZCBpZGVhIHRvIGZpcnN0IHBvc3QgYW4gUkZDIHdpdGggYW4gdUFQ
SSBwcm9wb3NhbA0KPiBvbiBob3cgdG8NCj4gaGFuZGxlIHNlY3VyZSB2aWRlby4gSSBzdXNwZWN0
IHRoaXMgaXNuJ3QgbWVkaWF0ZWsgc3BlY2lmaWMsIG90aGVyDQo+IFNvQ3Mgd2l0aA0KPiB0ZWUg
c3VwcG9ydCBjb3VsZCB1c2UgdGhpcyBhcyB3ZWxsLg0KPiANCj4gQXMgTmljb2xhcyBzYWlkLCBp
dCdzIGxvbmcga25vd24gdG8gYmUgYSBnYXAgaW4gb3VyIG1lZGlhIHN1cHBvcnQsIHNvDQo+IGl0
IGlzDQo+IHJlYWxseSBncmVhdCB0aGF0IHlvdSBzdGFydGVkIHdvcmsgb24gdGhpcywgYnV0IHlv
dSBuZWVkIHRvIGxvb2sgYXQNCj4gdGhpcyBmcm9tDQo+IGEgbW9yZSBnZW5lcmljIHBvaW50LW9m
LXZpZXcsIGFuZCBub3QgbWVkaWF0ZWstc3BlY2lmaWMuDQo+IA0KDQpXaGV0aGVyIHlvdXIgaGF2
ZSBhbnkgYWR2aWNlIGFib3V0IGhvdyB0byBkbyBhIG1vcmUgZ2VuZXJpYyBkcml2ZXIgdG8NCmhh
bmRsZSBzZWN1cmUgdmlkZW8gcGxheWJhY2s/DQoNClRoZXJlIGFyZSBzZXZlcmFsIGtpbmQgb2Yg
YnVmZmVyOiBvdXRwdXQgcXVldWUgYnVmZmVyL2NhcHR1cmUgcXVldWUNCmJ1ZmZlci93b3JraW5n
IGJ1ZmZlci4NCg0Kb3V0cHV0IGFuZCBjYXB0dXJlIHF1ZXVlIGJ1ZmZlcjogdXNlciBzcGFjZSB3
aWxsIGNhbGwgdGVlIHJlbGF0ZWQNCmludGVyZmFjZSB0byBhbGxvY2F0ZSBzZWN1cmUgaGFuZGxl
LiBXaWxsIGNvbnZlcnQgdG8gc2VjdXJlIGhhbmRsZSB3aXRoDQp2NGwyIGZyYW1ld29yaywgdGhl
biBzZW5kIHNlY3VyZSBoYW5kbGUgdG8gb3B0ZWUtb3MuDQoNCndvcmtpbmcgYnVmZmVyOiBjYWxs
aW5nIGRtYV9oZWFwIGFuZCBkbWFfYnVmIHRvIGdldCBzZWN1cmUgbWVtb3J5DQpoYW5kbGUsIHRo
ZW4gY292ZXJ0IHNlY3VyZSBpb3ZhIGluIG9wdGVlLW9zLg0KDQpVc2luZyB0aGUgc2FtZSBrZXJu
ZWwgZHJpdmVyIGZvciBzdnAgYW5kIG5vbi1zdnAgcGxheWJhY2ssIGp1c3QgdGhlDQpidWZmZXIg
dHlwZSBhcmUgZGlmZmVyZW50LiBOb3JtYWwgaXMgaW92YSBhbmQgc2VjdXJlIGlzIHNlY3VyZSBo
YW5kbGUuDQoNClVzZXIgZHJpdmVyIHdpbGwgdGVsbCB0aGUga2VybmVsIGRyaXZlciB3aXRoIENJ
RCBjb250cm9sIHdoZXRoZXIgdGhlDQpjdXJyZW50IHBsYXliYWNrIGlzIHN2cCBvciBub24tc3Zw
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KPiBSZWdhcmRzLA0KPiANCj4gSGFucw0K
PiANCj4gPiANCj4gPiByZWdhcmRzLA0KPiA+IE5pY29sYXMNCj4gPiANCj4gPiBwLnMuIHlvdSBm
b3Jnb3QgdG8gZG9jdW1lbnQgeW91ciBjb250cm9sIGluIHRoZSBSU1QgZG9jLCBwbGVhc2UgZG8N
Cj4gDQo+IGluIGZvbGxvd2luZw0KPiA+IHJlbGVhc2UuDQo+ID4gDQo+ID4gPiArY3R4LT5pc19z
dnBfbW9kZSA9IGN0cmwtPnZhbDsNCj4gPiA+ICsNCj4gPiA+ICtpZiAoY3R4LT5pc19zdnBfbW9k
ZSkgew0KPiA+ID4gK3JldCA9IG10a192Y29kZWNfZGVjX29wdGVlX29wZW4oY3R4LT5kZXYtPm9w
dGVlX3ByaXZhdGUpOw0KPiA+ID4gK2lmIChyZXQpDQo+ID4gPiArbXRrX3Y0bDJfdmRlY19lcnIo
Y3R4LCAib3BlbiBzZWN1cmUgbW9kZSBmYWlsZWQuIik7DQo+ID4gPiArZWxzZQ0KPiA+ID4gK210
a192NGwyX3ZkZWNfZGJnKDMsIGN0eCwgImRlY29kZXIgaW4gc2VjdXJlIG1vZGU6ICVkIiwgY3Ry
bC0NCj4gPiANCj4gPiB2YWwpOw0KPiA+ID4gK30NCj4gPiA+ICticmVhazsNCj4gPiA+ICBkZWZh
dWx0Og0KPiA+ID4gIG10a192NGwyX3ZkZWNfZGJnKDMsIGN0eCwgIk5vdCBzdXBwb3J0ZWQgdG8g
c2V0IGN0cmwgaWQ6DQo+ID4gPiAweCV4XG4iLA0KPiANCj4gaGRyX2N0cmwtPmlkKTsNCj4gPiA+
ICByZXR1cm4gcmV0Ow0KPiA+ID4gQEAgLTU3Myw3ICs1ODQsNyBAQCBzdGF0aWMgaW50IG10a192
Y29kZWNfZGVjX2N0cmxzX3NldHVwKHN0cnVjdA0KPiANCj4gbXRrX3Zjb2RlY19kZWNfY3R4ICpj
dHgpDQo+ID4gPiAgdW5zaWduZWQgaW50IGk7DQo+ID4gPiAgc3RydWN0IHY0bDJfY3RybCAqY3Ry
bDsNCj4gPiA+ICANCj4gPiA+IC12NGwyX2N0cmxfaGFuZGxlcl9pbml0KCZjdHgtPmN0cmxfaGRs
LCBOVU1fQ1RSTFMgKyAxKTsNCj4gPiA+ICt2NGwyX2N0cmxfaGFuZGxlcl9pbml0KCZjdHgtPmN0
cmxfaGRsLCBOVU1fQ1RSTFMgKyAyKTsNCj4gPiA+ICBpZiAoY3R4LT5jdHJsX2hkbC5lcnJvcikg
ew0KPiA+ID4gIG10a192NGwyX3ZkZWNfZXJyKGN0eCwgInY0bDJfY3RybF9oYW5kbGVyX2luaXQg
ZmFpbGVkXG4iKTsNCj4gPiA+ICByZXR1cm4gY3R4LT5jdHJsX2hkbC5lcnJvcjsNCj4gPiA+IEBA
IC01OTIsNiArNjAzLDggQEAgc3RhdGljIGludCBtdGtfdmNvZGVjX2RlY19jdHJsc19zZXR1cChz
dHJ1Y3QNCj4gDQo+IG10a192Y29kZWNfZGVjX2N0eCAqY3R4KQ0KPiA+ID4gIA0KPiA+ID4gIGN0
cmwgPSB2NGwyX2N0cmxfbmV3X3N0ZCgmY3R4LT5jdHJsX2hkbCwNCj4gDQo+ICZtdGtfdmNvZGVj
X2RlY19jdHJsX29wcywNCj4gPiA+ICAgVjRMMl9DSURfTVBFR19NVEtfR0VUX1NFQ1VSRV9IQU5E
TEUsIDAsIDY1NTM1LCAxLCAwKTsNCj4gPiA+ICtjdHJsID0gdjRsMl9jdHJsX25ld19zdGQoJmN0
eC0+Y3RybF9oZGwsDQo+IA0KPiAmbXRrX3Zjb2RlY19kZWNfY3RybF9vcHMsDQo+ID4gPiArIFY0
TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9ERSwgMCwgNjU1MzUsIDEsIDApOw0KPiA+ID4g
IA0KPiA+ID4gIHY0bDJfY3RybF9oYW5kbGVyX3NldHVwKCZjdHgtPmN0cmxfaGRsKTsNCj4gPiA+
ICANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWN0cmxz
LWRlZnMuYw0KPiANCj4gYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWN0cmxzLWRlZnMu
Yw0KPiA+ID4gaW5kZXggZDhjZjAxZjc2YWFiLi5hNTA3MDQ1YTNmMzAgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWN0cmxzLWRlZnMuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy1kZWZzLmMNCj4gPiA+IEBAIC0x
MDQyLDYgKzEwNDIsNyBAQCBjb25zdCBjaGFyICp2NGwyX2N0cmxfZ2V0X25hbWUodTMyIGlkKQ0K
PiA+ID4gIGNhc2UgVjRMMl9DSURfTVBFR19WSURFT19SRUZfTlVNQkVSX0ZPUl9QRlJBTUVTOnJl
dHVybg0KPiA+ID4gIlJlZmVyZW5jZQ0KPiANCj4gRnJhbWVzIGZvciBhIFAtRnJhbWUiOw0KPiA+
ID4gIGNhc2UgVjRMMl9DSURfTVBFR19WSURFT19QUkVQRU5EX1NQU1BQU19UT19JRFI6cmV0dXJu
ICJQcmVwZW5kDQo+IA0KPiBTUFMgYW5kIFBQUyB0byBJRFIiOw0KPiA+ID4gIGNhc2UgVjRMMl9D
SURfTVBFR19NVEtfR0VUX1NFQ1VSRV9IQU5ETEU6cmV0dXJuICJNZWRpYVRlaw0KPiA+ID4gRGVj
b2Rlcg0KPiANCj4gZ2V0IHNlY3VyZSBoYW5kbGUiOw0KPiA+ID4gK2Nhc2UgVjRMMl9DSURfTVBF
R19NVEtfU0VUX1NFQ1VSRV9NT0RFOnJldHVybiAiTWVkaWFUZWsgRGVjb2Rlcg0KPiANCj4gc2V0
IHNlY3VyZSBtb2RlIjsNCj4gPiA+ICANCj4gPiA+ICAvKiBBVjEgY29udHJvbHMgKi8NCj4gPiA+
ICBjYXNlIFY0TDJfQ0lEX01QRUdfVklERU9fQVYxX1BST0ZJTEU6cmV0dXJuICJBVjEgUHJvZmls
ZSI7DQo+ID4gPiBAQCAtMTQ0Miw2ICsxNDQzLDEwIEBAIHZvaWQgdjRsMl9jdHJsX2ZpbGwodTMy
IGlkLCBjb25zdCBjaGFyDQo+IA0KPiAqKm5hbWUsIGVudW0gdjRsMl9jdHJsX3R5cGUgKnR5cGUs
DQo+ID4gPiAgKnR5cGUgPSBWNEwyX0NUUkxfVFlQRV9JTlRFR0VSOw0KPiA+ID4gICpmbGFncyB8
PSBWNEwyX0NUUkxfRkxBR19XUklURV9PTkxZOw0KPiA+ID4gIGJyZWFrOw0KPiA+ID4gK2Nhc2Ug
VjRMMl9DSURfTVBFR19NVEtfU0VUX1NFQ1VSRV9NT0RFOg0KPiA+ID4gKyp0eXBlID0gVjRMMl9D
VFJMX1RZUEVfSU5URUdFUjsNCj4gPiA+ICsqZmxhZ3MgfD0gVjRMMl9DVFJMX0ZMQUdfV1JJVEVf
T05MWTsNCj4gPiA+ICticmVhazsNCj4gPiA+ICBjYXNlIFY0TDJfQ0lEX1VTRVJfQ0xBU1M6DQo+
ID4gPiAgY2FzZSBWNEwyX0NJRF9DQU1FUkFfQ0xBU1M6DQo+ID4gPiAgY2FzZSBWNEwyX0NJRF9D
T0RFQ19DTEFTUzoNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdjRsMi1j
b250cm9scy5oDQo+IA0KPiBiL2luY2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xzLmgNCj4g
PiA+IGluZGV4IDdiMzY5NDk4NTM2Ni4uODhlOTBkOTQzZTM4IDEwMDY0NA0KPiA+ID4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS91
YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiA+ID4gQEAgLTk1Nyw2ICs5NTcsNyBAQCBlbnVt
IHY0bDJfbXBlZ19tZmM1MV92aWRlb19mb3JjZV9mcmFtZV90eXBlIHsNCj4gPiA+ICAvKiAgTVBF
Ry1jbGFzcyBjb250cm9sIElEcyBzcGVjaWZpYyB0byB0aGUgTWVkaWFUZWsgRGVjb2Rlcg0KPiAN
Cj4gZHJpdmVyIGFzIGRlZmluZWQgYnkgVjRMMiAqLw0KPiA+ID4gICNkZWZpbmUgVjRMMl9DSURf
TVBFR19NVEtfQkFTRShWNEwyX0NUUkxfQ0xBU1NfQ09ERUMgfCAweDIwMDApDQo+ID4gPiAgI2Rl
ZmluZQ0KPiANCj4gVjRMMl9DSURfTVBFR19NVEtfR0VUX1NFQ1VSRV9IQU5ETEUoVjRMMl9DSURf
TVBFR19NVEtfQkFTRSs4KQ0KPiA+ID4gKyNkZWZpbmUNCj4gDQo+IFY0TDJfQ0lEX01QRUdfTVRL
X1NFVF9TRUNVUkVfTU9ERShWNEwyX0NJRF9NUEVHX01US19CQVNFKzkpDQo+ID4gPiAgDQo+ID4g
PiAgLyogIENhbWVyYSBjbGFzcyBjb250cm9sIElEcyAqLw0KPiA+ID4gIA0K
