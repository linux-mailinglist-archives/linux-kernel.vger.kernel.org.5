Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B8768C48
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGaGut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGaGur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:50:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75A9D;
        Sun, 30 Jul 2023 23:50:45 -0700 (PDT)
X-UUID: 90d4650c2f6e11ee9cb5633481061a41-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=4GjKUABzK/6hcfZqnsOdLIp6ZAHG2kn0F5MSbS+0rYo=;
        b=Rl+QzTWqulpJzXqGoVlsgYanHyhKFpp7KjGgYDE1RRNv7ZwcjCH0eNnWdoVEAyhheupHdE5FDuRlrSzBrhfiC+LqDc8XOLkyed29gZDEgOWSBo3yp3qesKreRhtziWRI9E5sXHXASeVhHpIONyfIeDQdVsV+NCvbQYXWtwufG/w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:1fe6252f-1ee3-4c27-ad2f-9977a18b0f66,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:caafa242-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 90d4650c2f6e11ee9cb5633481061a41-20230731
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1494822762; Mon, 31 Jul 2023 14:50:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 14:50:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 14:50:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oejfbewVid7d+RxEoVDuyWyxnKTqvqkLMZCg8QfsFtM1O+JJzLDfY7WRHTqOg5uMavYHDw4m3PwmrtyR/GqSBayFdYW2Mz6uThCtvu3WmXKDRmH6KR664S1UOA+zNpbGG+bo7qcdokG8gpB1eVyIEXvt4mnbhlSA02y1Sqn1gUz17Q+TifW3qz/RvgPx8/MTaI0xTEudQYG8bFxKqV+kFYIZAZne4VO6guaplllRcYiN+nalE9Mi7dTlI5CJ58uOlVsPOK3eOpL3yLbCc2DsSHU/e2X5SEfPo3ROQFOTLCefkAgUqI5BKvCRHVvNR/Wrpkid4sM1TiLymN4u3i1x6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GjKUABzK/6hcfZqnsOdLIp6ZAHG2kn0F5MSbS+0rYo=;
 b=a3ZmBPAPYSwj2xWqwDGxmuXwuSpTfZ2nIpCRENCpa1RSEaxAONPu1BFKKz0oG/ey5PwbAHaymbdjNlNPoGinJRdjkSTxeyzvbf+wvT5nplrGaXEnKmvoNYdKNhTtX4Gphh+zViPLFrM7PlQXqXXn/c3uxcOzWSNJ+DCiuAkjGjmBTkucs2Z0h2p7b/eFkWjhf8woZ7d2hLGK7Z2XV65OfLKV8j3++TogWELnDYNjPVlKxd4+4w+eV4Ep/BYiJEH8wf9YmEfkyTfkx9k+LnXSz9lj0bfQSefENpE5iy6TM9AdG6ylntJHT9x+Eax+gC/Vmn+GTbFu5V5NOt5SNW0AbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GjKUABzK/6hcfZqnsOdLIp6ZAHG2kn0F5MSbS+0rYo=;
 b=Vo3c3d65Ar1KeWm6RfasFGJQZJ94cqSS6uCAIeF1bNiwiiqQDmlKl/sg5E6pAySgVun8TlbgEHaRatBokGqb1RPWpEnUWUjh3OYoJWbQgIAyOS81VDwhvuN1xFRbfxojn+hHy681JabGOpZ8MXYCUly3KaG0X8aoVUs3pro1Xsc=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB5629.apcprd03.prod.outlook.com (2603:1096:400:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 06:50:38 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 06:50:38 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 4/6] ASoC: mediatek: mt7986: add machine driver with
 wm8960
Thread-Topic: [PATCH v3 4/6] ASoC: mediatek: mt7986: add machine driver with
 wm8960
Thread-Index: AQHZwTM5By6/XLRLKEmjswmau/Jp+a/O7zwAgAAA5oCABIQVAA==
Date:   Mon, 31 Jul 2023 06:50:37 +0000
Message-ID: <fe11acb200695cb6049371899d00de37c18772c3.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-5-maso.huang@mediatek.com>
         <bab11add-b56f-59d3-f4fc-ad248ebe9b99@collabora.com>
         <3cd43731-a49e-e751-2839-84708333a0e2@collabora.com>
In-Reply-To: <3cd43731-a49e-e751-2839-84708333a0e2@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB5629:EE_
x-ms-office365-filtering-correlation-id: af224bbe-4a03-45dd-5ef6-08db919272ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUPpfaK5QPWn0Jusat0bRqORMqvXZSdc1O/g1PSzRYE8Dq4NqDAXPgEU7w5knyTRpUZf35/AIlTTQ5c03pzaYWnvU8kO7OhF4zNOEfT7SXnVcoWIbnrN77/3Mqq6/cbSQ5KQVau+gQMCj1yqCEUqibRqI80UHQPZ5SeDfY+muK+uVI4/g7SH/J4FIQBwNXVyl+xgf3J02EJxLd8KMPoQ8ExUssESgSBnM+0tCM3fpIu6SibM+Xr925wullOhIvFFlid8mMWD98N4M6M1P8RZNTK4IavbXA4JQlk/hlnThsP4oLBnqZu3XGtlvf2fnI3lktEJyVkSs3DmNDV35nimNjF2st/E76CTGL1e/TbPYVFU8P+8ZLTiRkziKZYM8tOT55R/BkqM51Zr7CKJP04xmg1kt12PMcGBH300WYOdwmPv6k6LL0YxOJ3qIAfmFAO7jbbmg+3XcgeXuv2xgQ0Zc5by0b11KM1CY6HYm2BRV1aGY0MSAHGxVpry2HsXUrjTNhmNsrE7BOXKeCUm4u7lWf04enELaaA+nlj+DRvTr0QF4m3A1L98rPc/BFTmfM9p+mStENJHbEXL/QmQFzHXovj4nSBg+Ir+MU8LItJg8Z2TkxhkRT+I+hI5at3D+lSNwF2agjObUzgh0WJmNqatOfnUjmcXNt/plCSGHI61cKvRuk+IdJbdmXiUP5q5frpV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(6512007)(71200400001)(6486002)(186003)(83380400001)(2616005)(36756003)(85182001)(86362001)(38070700005)(122000001)(38100700002)(921005)(26005)(6506007)(64756008)(66446008)(66476007)(66556008)(2906002)(66946007)(76116006)(91956017)(316002)(5660300002)(7416002)(41300700001)(8936002)(8676002)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1dEUlc5VVJxTWl6L2MvbVFKdlFxTnFjWXBCb2xuaVF2RlV2bk5yaVNlQity?=
 =?utf-8?B?TXZUUWZnSmkxQUNNK2hoVVhpRC9UQS9HMno0OUFvYjhDMThWUzVwMmVsQ1lw?=
 =?utf-8?B?Rm9wQTF3empLZkJCdXBFSzltQnZMUmVQenZTODNxZUpzQVB4aS9aaFdFQWh5?=
 =?utf-8?B?OE5QYUh0K1l0QWJHZWFGa3dpaktaQmlMbG1FUFNGMzl1eUxlcEtMU0M2c2VP?=
 =?utf-8?B?U1ZabVlRT3ZNTkcwL0FrWnBYOG5WQktEd1B2c24zU3pMQUNpeTU3WW5aNjhl?=
 =?utf-8?B?RkcxZ1A2eHcvd0UzR0xRVFdSd25GU1A0R1ZpaHc0ZFFsOCsrVWpUYUUxaFdu?=
 =?utf-8?B?WUwzeDR1N1NSMnNsQ0Q3WkNzZXhZeGdmSUEreDRhL1Nkdk53QmdwcU9lVG1h?=
 =?utf-8?B?YVFpQ0JXSC9oWlQwSnBMbHNaOExTWS9HQ21YOENXZDR4ZHF3a0dCNHRSOWF3?=
 =?utf-8?B?RSs2TDkxTHZlOXY1SngvQWx2QzFKZWpFb2Y3Y3FzV1F3dGRzTHMvRkdJdzZB?=
 =?utf-8?B?OC9wK1lBY1ZEbks1YytOUmprV21vQi9TZzJyalF4WFYwUXZBY0NPNng2Rzhz?=
 =?utf-8?B?ZHdsRHVUc3JSUVU5UGRVWkhLU0tTMHhlTzN1Z2hoQ2F0VHk1Wjk2NjdEQ1JW?=
 =?utf-8?B?eU5QNHRYZThtbmgrT3EyQUdaZFp0Z2psUTlITmxIOVB4c3NXMW1xeTE3K1Rn?=
 =?utf-8?B?RlZZYkpWOTJSalVGMmhTa1JXdG5DRlRaM1R0YUtjbFhYQVBjZE9LKzVvWHFG?=
 =?utf-8?B?WWV2MEhXdEROV0lUSmtLVDdhbGpjNFNSamZPWjZaUGg4QmNaRXdBbW5LZ1gw?=
 =?utf-8?B?SEVOMS90QUhXK1pNT3d6d1drLzYvZ0FPS1JJZW9mSEZCZUpTV20zS043cm9t?=
 =?utf-8?B?dEUyMkxDZ0N2a2djRnhFbytmQWs4MFl1NXQwRklnUTZoSkJzM1dUV2JqQ2VZ?=
 =?utf-8?B?S0gxUjBxUW90OWY1bXIvRm1LVWY5Si9nKzhXLzQ5K3I1dStqdnNEWHNzWkpX?=
 =?utf-8?B?TUoraW8rWks4M0lrRFFUMHVTM2pFeDdxWmZxOGlabkJteDRiQkxvVVY3Nisr?=
 =?utf-8?B?Q21XU0g1K0pyV2FDMWk2alFhbGllLy8xWnVIYnJnV1QxS0gxY2V1Uk5HUVNB?=
 =?utf-8?B?OXJpaHdyUnpwelphZE5zY0ZKaDY2WnZ0MktIKzlpZVVON1AvUWp1aEZrWGdB?=
 =?utf-8?B?WVYrYzkwcWZ1UEc4UW81RUhYRG0wMEs2dzVubU9kMFR3R2ljcjI5bnVLWmV0?=
 =?utf-8?B?SnZmV3FSYSt4dVBCRTJxQ3RjOFI1RkQyVlZ0aW9PNGYwZW85TFR2L2ZkOGJL?=
 =?utf-8?B?d2VTN2JiU21HOTJCQW9kNlBYSnd1VXhvZExVa2hLb1J6aEhhNE1Gc201SjU2?=
 =?utf-8?B?TXZJZGc4SHBqRGswbCt3MDY1bzIreTUzdG5laVF2aVQ3VCtyeVM4blE0akhZ?=
 =?utf-8?B?cnNRd2xNMng5OERyUVpKbThsY2xZblorVk12UnFYWXRpQ2JNNnYrZXA2SjVZ?=
 =?utf-8?B?Q0xReFFBQ2RPSmJJMFcraTA4c0kwbnZidVd2QW9rL0dqZkVJbkNBZjRHYkUr?=
 =?utf-8?B?MUdmRkpIT2QzUGE4VnM3SjYxVDkzdkQ2U2czUDVuQVp4bUQwU3M3dVNGSll4?=
 =?utf-8?B?TGEwQXpmMUVubFVVUnd0R21CNWdjNzFwMnZQYVpLY0ttbWYwZHhtQUpsZ2px?=
 =?utf-8?B?Rm9rdmt3eEthUmNhL0x3TEZwRU5IVXlpcTV4eFFOZ2V2ajN4Q1k4d3Fxbzl2?=
 =?utf-8?B?N3pNZGdHZUVZanhrRG1Sa0JqQ3o3dEVNR1pIaGQ4VFpwYVpvcFV4aVVhRVJS?=
 =?utf-8?B?MzhRbDI2cmlwVGVxOUJ6djJYRUFFZ2s5MWZrUnhlSFpTL0Z5ek1ZdE5NR3RK?=
 =?utf-8?B?S1QwMzd1QXptZUtwbHVhVkxDL0ZXT05ocUVsOTVmWkRlZ21OYnFxbGpyNUpU?=
 =?utf-8?B?TnZHWU0wYng1bGxsOFhEdXh0emhRVXZ1TlJPbFNpQ2E2VlJabElYUWFKOTBl?=
 =?utf-8?B?MmpzNmlUVVUrWWtYME1VNC9sVjhnK0xwdlNrTDFmQkZVODYwSzFOQlFrbjk1?=
 =?utf-8?B?Zk5JZVIzdzE1S29iUTBFZEFGOGk0VmxrN3cxVEVIYzZlS3lmR0d1TWJHV3VO?=
 =?utf-8?B?bWdDWkgzWExOdGFJdDdHcVJOSWtCb3hZbDB2STROWDN4cUU1cEJtZEtyQVFl?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30578D57816BB843AFB36EC70B4963EF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af224bbe-4a03-45dd-5ef6-08db919272ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 06:50:37.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrzrYEKxx9Mlp5A1FNaFL/RUxm8NoBhFxoQS0P9/Z5Vjn5EZGbeSECHInY7hWpYE4m1mSCagrIFfjBoYwbDalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5629
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTI4IGF0IDExOjUyICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMDcvMjMgMTE6NDksIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIGhhIHNjcml0dG86DQo+ID4gSWwgMjgvMDcvMjMgMTE6MDgsIE1hc28gSHVhbmcgaGEgc2Ny
aXR0bzoNCj4gPiA+IEFkZCBzdXBwb3J0IGZvciBtdDc5ODYgYm9hcmQgd2l0aCB3bTg5NjAuDQo+
ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0
ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIHNvdW5kL3NvYy9tZWRpYXRlay9LY29uZmlnICAg
ICAgICAgICAgICAgIHwgIDEwICsrDQo+ID4gPiAgIHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYv
TWFrZWZpbGUgICAgICAgIHwgICAxICsNCj4gPiA+ICAgc291bmQvc29jL21lZGlhdGVrL210Nzk4
Ni9tdDc5ODYtd204OTYwLmMgfCAxODQNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysNCj4g
PiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOTUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtd204OTYwLmMNCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRlay9LY29uZmlnDQo+ID4g
PiBiL3NvdW5kL3NvYy9tZWRpYXRlay9LY29uZmlnDQo+ID4gPiBpbmRleCA1NTg4Mjc3NTVhOGQu
LjhkMWJjODgxNDQ4NiAxMDA2NDQNCj4gPiA+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9LY29u
ZmlnDQo+ID4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvS2NvbmZpZw0KPiA+ID4gQEAgLTY0
LDYgKzY0LDE2IEBAIGNvbmZpZyBTTkRfU09DX01UNzk4Ng0KPiA+ID4gICAgICAgICBTZWxlY3Qg
WSBpZiB5b3UgaGF2ZSBzdWNoIGRldmljZS4NCj4gPiA+ICAgICAgICAgSWYgdW5zdXJlIHNlbGVj
dCAiTiIuDQo+ID4gPiArY29uZmlnIFNORF9TT0NfTVQ3OTg2X1dNODk2MA0KPiA+ID4gKyAgICB0
cmlzdGF0ZSAiQVNvYyBBdWRpbyBkcml2ZXIgZm9yIE1UNzk4NiB3aXRoIFdNODk2MCBjb2RlYyIN
Cj4gPiA+ICsgICAgZGVwZW5kcyBvbiBTTkRfU09DX01UNzk4NiAmJiBJMkMNCj4gPiA+ICsgICAg
c2VsZWN0IFNORF9TT0NfV004OTYwDQo+ID4gPiArICAgIGhlbHANCj4gPiA+ICsgICAgICBUaGlz
IGFkZHMgc3VwcG9ydCBmb3IgQVNvQyBtYWNoaW5lIGRyaXZlciBmb3IgTWVkaWFUZWsNCj4gPiA+
IE1UNzk4Ng0KPiA+ID4gKyAgICAgIGJvYXJkcyB3aXRoIHRoZSBXTTg5NjAgY29kZWNzLg0KPiA+
ID4gKyAgICAgIFNlbGVjdCBZIGlmIHlvdSBoYXZlIHN1Y2ggZGV2aWNlLg0KPiA+ID4gKyAgICAg
IElmIHVuc3VyZSBzZWxlY3QgIk4iLg0KPiA+ID4gKw0KPiA+ID4gICBjb25maWcgU05EX1NPQ19N
VDgxNzMNCj4gPiA+ICAgICAgIHRyaXN0YXRlICJBU29DIHN1cHBvcnQgZm9yIE1lZGlhdGVrIE1U
ODE3MyBjaGlwIg0KPiA+ID4gICAgICAgZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9NYWtlZmlsZQ0KPiA+ID4gYi9z
b3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L01ha2VmaWxlDQo+ID4gPiBpbmRleCBkZTA3NDJhNjdj
YWUuLmZjNGM4MjU1OWIyOSAxMDA2NDQNCj4gPiA+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9t
dDc5ODYvTWFrZWZpbGUNCj4gPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvTWFr
ZWZpbGUNCj4gPiA+IEBAIC02LDMgKzYsNCBAQCBzbmQtc29jLW10Nzk4Ni1hZmUtb2JqcyA6PSBc
DQo+ID4gPiAgICAgICBtdDc5ODYtZGFpLWV0ZG0ubw0KPiA+ID4gICBvYmotJChDT05GSUdfU05E
X1NPQ19NVDc5ODYpICs9IHNuZC1zb2MtbXQ3OTg2LWFmZS5vDQo+ID4gPiArb2JqLSQoQ09ORklH
X1NORF9TT0NfTVQ3OTg2X1dNODk2MCkgKz0gbXQ3OTg2LXdtODk2MC5vDQo+ID4gPiBkaWZmIC0t
Z2l0IGEvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtd204OTYwLmMgDQo+ID4gPiBi
L3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LXdtODk2MC5jDQo+ID4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hODgwZmNiODY2MmUNCj4g
PiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYv
bXQ3OTg2LXdtODk2MC5jDQo+ID4gDQo+ID4gLi5zbmlwLi4NCj4gPiANCj4gPiA+ICtzdGF0aWMg
aW50IG10Nzk4Nl93bTg5NjBfbWFjaGluZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+
ID4gPiAqcGRldikNCj4gPiA+ICt7DQo+ID4gPiArICAgIHN0cnVjdCBzbmRfc29jX2NhcmQgKmNh
cmQgPSAmbXQ3OTg2X3dtODk2MF9jYXJkOw0KPiA+ID4gKyAgICBzdHJ1Y3Qgc25kX3NvY19kYWlf
bGluayAqZGFpX2xpbms7DQo+ID4gPiArICAgIHN0cnVjdCBtdDc5ODZfd204OTYwX3ByaXYgKnBy
aXY7DQo+ID4gPiArICAgIGludCByZXQsIGk7DQo+ID4gPiArDQo+ID4gPiArICAgIHByaXYgPSBk
ZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7DQo+ID4g
PiArICAgIGlmICghcHJpdikNCj4gPiA+ICsgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ID4g
Kw0KPiA+ID4gKyAgICBwcml2LT5wbGF0Zm9ybV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShwZGV2
LT5kZXYub2Zfbm9kZSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAibWVkaWF0
ZWsscGxhdGZvcm0iLCAwKTsNCj4gPiA+ICsgICAgaWYgKCFwcml2LT5wbGF0Zm9ybV9ub2RlKSB7
DQo+ID4gPiArICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJQcm9wZXJ0eSAncGxhdGZvcm0n
IG1pc3Npbmcgb3INCj4gPiA+IGludmFsaWRcbiIpOw0KPiA+ID4gKyAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+ID4gPiArICAgIH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgZm9yX2VhY2hfY2FyZF9w
cmVsaW5rcyhjYXJkLCBpLCBkYWlfbGluaykgew0KPiA+ID4gKyAgICAgICAgaWYgKGRhaV9saW5r
LT5wbGF0Zm9ybXMtPm5hbWUpDQo+ID4gPiArICAgICAgICAgICAgY29udGludWU7DQo+ID4gPiAr
ICAgICAgICBkYWlfbGluay0+cGxhdGZvcm1zLT5vZl9ub2RlID0gcHJpdi0+cGxhdGZvcm1fbm9k
ZTsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICBjYXJkLT5kZXYgPSAmcGRldi0+
ZGV2Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICBwcml2LT5jb2RlY19ub2RlID0gb2ZfcGFyc2VfcGhh
bmRsZShwZGV2LT5kZXYub2Zfbm9kZSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAi
bWVkaWF0ZWssYXVkaW8tY29kZWMiLCAwKTsNCj4gPiA+ICsgICAgaWYgKCFwcml2LT5jb2RlY19u
b2RlKSB7DQo+ID4gPiArICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsDQo+ID4gPiArICAgICAg
ICAgICAgIlByb3BlcnR5ICdhdWRpby1jb2RlYycgbWlzc2luZyBvciBpbnZhbGlkXG4iKTsNCj4g
PiA+ICsgICAgICAgIG9mX25vZGVfcHV0KHByaXYtPnBsYXRmb3JtX25vZGUpOw0KPiA+ID4gKyAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArICAgIH0NCj4gPiA+ICsNCj4gPiA+ICsgICAg
Zm9yX2VhY2hfY2FyZF9wcmVsaW5rcyhjYXJkLCBpLCBkYWlfbGluaykgew0KPiA+ID4gKyAgICAg
ICAgaWYgKGRhaV9saW5rLT5jb2RlY3MtPm5hbWUpDQo+ID4gPiArICAgICAgICAgICAgY29udGlu
dWU7DQo+ID4gPiArICAgICAgICBkYWlfbGluay0+Y29kZWNzLT5vZl9ub2RlID0gcHJpdi0+Y29k
ZWNfbm9kZTsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICByZXQgPSBzbmRfc29j
X29mX3BhcnNlX2F1ZGlvX3JvdXRpbmcoY2FyZCwgImF1ZGlvLXJvdXRpbmciKTsNCj4gPiA+ICsg
ICAgaWYgKHJldCkgew0KPiA+ID4gKyAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVk
IHRvIHBhcnNlIGF1ZGlvLXJvdXRpbmc6DQo+ID4gPiAlZFxuIiwgcmV0KTsNCj4gPiA+ICsgICAg
ICAgIGdvdG8gZXJyX29mX25vZGVfcHV0Ow0KPiA+ID4gKyAgICB9DQo+ID4gPiArDQo+ID4gPiAr
ICAgIHJldCA9IGRldm1fc25kX3NvY19yZWdpc3Rlcl9jYXJkKCZwZGV2LT5kZXYsIGNhcmQpOw0K
PiA+ID4gKyAgICBpZiAocmV0KSB7DQo+ID4gPiArICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYs
ICIlcyBzbmRfc29jX3JlZ2lzdGVyX2NhcmQgZmFpbA0KPiA+ID4gJWRcbiIsDQo+ID4gPiArICAg
ICAgICAgICAgX19mdW5jX18sIHJldCk7DQo+ID4gPiArICAgICAgICBnb3RvIGVycl9vZl9ub2Rl
X3B1dDsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gK2Vycl9vZl9ub2RlX3B1dDoNCj4g
PiA+ICsgICAgb2Zfbm9kZV9wdXQocHJpdi0+Y29kZWNfbm9kZSk7DQo+ID4gPiArICAgIG9mX25v
ZGVfcHV0KHByaXYtPnBsYXRmb3JtX25vZGUpOw0KPiA+ID4gKyAgICByZXR1cm4gcmV0Ow0KPiA+
ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgdm9pZCBtdDc5ODZfd204OTYwX21hY2hpbmVf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPiA+ICpwZGV2KQ0KPiA+ID4gK3sNCj4g
PiA+ICsgICAgc3RydWN0IHNuZF9zb2NfY2FyZCAqY2FyZCA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOw0KPiA+ID4gKyAgICBzdHJ1Y3QgbXQ3OTg2X3dtODk2MF9wcml2ICpwcml2ID0NCj4g
PiA+IHNuZF9zb2NfY2FyZF9nZXRfZHJ2ZGF0YShjYXJkKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAg
b2Zfbm9kZV9wdXQocHJpdi0+Y29kZWNfbm9kZSk7DQo+ID4gPiArICAgIG9mX25vZGVfcHV0KHBy
aXYtPnBsYXRmb3JtX25vZGUpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICsjaWZkZWYgQ09O
RklHX09GDQo+ID4gDQo+ID4gWW91ciBwcm9iZSBmdW5jdGlvbiAqcmVsaWVzIG9uKiBkZXZpY2V0
cmVlLCBhbmQgeW91J3JlIGFkZGluZyBhbg0KPiA+IGlmZGVmIGZvcg0KPiA+IENPTkZJR19PRj8g
VGhhdCB3b3VsZG4ndCBtYWtlIHNlbnNlLCB3b3VsZCBpdD8gOy0pDQo+ID4gDQoNCkhpIEFuZ2Vs
bywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KSXQgc2VlbXMgd2UgZG9uJ3QgbmVlZCBD
T05GSUdfT0YgaGVyZSwgc28gSSdsbCByZW1vdmUgaXQgaW4gdjQgcGF0Y2guDQoNCg0KPiA+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gPiBtdDc5ODZfd204OTYwX21h
Y2hpbmVfZHRfbWF0Y2hbXSA9IHsNCj4gPiA+ICsgICAgey5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10Nzk4Ni13bTg5NjAtbWFjaGluZSIsfSwNCj4gPiANCj4gPiBwbGVhc2UuLi4NCj4gPiANCj4g
PiB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Nzk4Ni13bTg5NjAtbWFjaGluZSIgfSwNCj4g
DQo+IEFjdHVhbGx5LCBJIG5vdGljZWQgdGhhdCBqdXN0IGFmdGVyIHNlbmRpbmcgdGhlIHJldmll
dy4NCj4gDQo+IENhbiB5b3UgYWxzbyBwbGVhc2UgY2hhbmdlIHRoZSBjb21wYXRpYmxlLCBhcyAi
bWFjaGluZSIgZG9lc24ndA0KPiByZWFsbHkNCj4gbWVhbiAic291bmQiPyA6LSkNCj4gDQo+IC5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10Nzk4Ni13bTg5NjAtc291bmQiDQo+IA0KPiBUaGFua3Mh
DQo+IA0KDQpGb3IgY29tcGF0aWJsZSBzdWZmaXgsIEknbGwgZGlzY3VzcyB3aXRoIHlvdSBpbiBQ
QVRDSCB2M1s1LzZdIG1haWwsIGFuZA0Kd2lsbCByZWZpbmUgdGhpcyB3aXRoIFs1LzZdIG1haWwg
Y29uY2x1c2lvbiA6KQ0KDQoNCj4gPiANCj4gPiA+ICsgICAgeyAvKiBzZW50aW5lbCAqLyB9DQo+
ID4gPiArfTsNCj4gPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdDc5ODZfd204OTYwX21h
Y2hpbmVfZHRfbWF0Y2gpOw0KPiA+ID4gKyNlbmRpZg0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10Nzk4Nl93bTg5NjBfbWFjaGluZSA9IHsNCj4gPiA+ICsg
ICAgLmRyaXZlciA9IHsNCj4gPiA+ICsgICAgICAgIC5uYW1lID0gIm10Nzk4Ni13bTg5NjAiLA0K
PiA+ID4gKyNpZmRlZiBDT05GSUdfT0YNCj4gPiANCj4gPiBDaGVjayBgc3RydWN0IGRldmljZV9k
cml2ZXJgOiBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gKm9mX21hdGNoX3RhYmxlIGlz
DQo+ID4gYWx3YXlzIHByZXNlbnQsIHRoZXJlJ3Mgbm8gaWZkZWYuLi4uIGFuZCB0aGF0J3MgZG9u
ZSBpbiBvcmRlciB0bw0KPiA+IGF2b2lkIHNlZWluZw0KPiA+IGEgYnVuY2ggb2YgaWZkZWZzIGlu
IGRyaXZlcnMuLi4NCj4gPiANCj4gPiAuLi5zbywgd2h5IGlzIHRoaXMgY2FsbGJhY2sgZW5jbG9z
ZWQgaW4gYW4gaWZkZWY/DQo+ID4gDQo+ID4gUGxlYXNlIGRyb3AgYWxsIHRob3NlIGlmZGVmcy4N
Cj4gPiANCj4gPiANCj4gPiBBZnRlciBhZGRyZXNzaW5nIHRob3NlIGxhc3QgY29tbWVudHMsIHlv
dSBjYW4gZ2V0IG15DQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBBbmdlbG8NCj4gDQo+IA0KDQpObyBtb3JlIG5lZWRlZCBm
b3IgdGhlIGlmZGVmLCBzbyBJJ2xsIGRyb3AgdGhlbSBpbiB2NCBwYXRjaCA6KQ0KDQpCZXN0IHJl
Z2FyZHMsDQpNYXNvDQoNCg0K
