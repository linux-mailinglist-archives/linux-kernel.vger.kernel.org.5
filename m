Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3B7D61A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjJYG07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjJYG0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:26:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28866137
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:26:52 -0700 (PDT)
X-UUID: 78c1aab872ff11eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=d/eKuEJqm64wmtbZZQLLa1UkbuxAvlUJq8XraR52kqU=;
        b=ckBlNXtj6xfk5FeiF8C6GrzbdEH7TqwaVugOoTpez2s2YxsqIqw9j9+1Bnp+f1MmzcCC9xSx9EEqunAARjUr8eG0021PB3aeffplPGULFSeDxxmrh6AEfBSCozFOPvEmyjwwr7RNkBJ0mBG955k95k28EVbu+8xXczHq1P2lG8Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ec99f0e7-a435-4743-a455-a5a146507b56,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:a2e7e228-cb22-4fa7-8134-287af20ad1fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 78c1aab872ff11eea33bb35ae8d461a2-20231025
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 536047979; Wed, 25 Oct 2023 14:26:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 14:26:45 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 14:26:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEsOGzq6HUVhMsJvk0s9qVWDb6MNX5UY8jMtc3gqjgTpIfpU4b7Q/ATBLRUMgNl22ZNnmAOTge+BoSYVr3dRwiwDbFVGvY1J/PcT2n1C+T2Vx4B2SDNu/PRzngWxoXfJJOot/vsnZa5sVvUq5L7epHn8wQI59mQnOAHKnPiYPAcDAnd+SF6T+QlZfz7fvoskAOR21q1/LPY5QZ96tmJ8gL+OmcHennl7b7LyeTOacNpoAzH+T/HIbHHCDYHoMxOjeluSVMlIgojH3lsalrHcbo15MvXGdnsJAT8dcIEoipqs4ySJu+iZ0ZW1/Pf/4A9he8T/yHNiuqaS2j8VeMMUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/eKuEJqm64wmtbZZQLLa1UkbuxAvlUJq8XraR52kqU=;
 b=e3IdOmo2dxLQ5cl5jVtbxTZ+Oj1hvVpmqCLVeT9JZxtimnWI3APerAPjldxwc7dkC9OjPqSEO75DRv0Axo/K3soKyC+arxwLg7uv5/zaU9WOKhyC/GA3F2cCp7G0/mxbjH/TTg3ls7cEjwYEcoDdIK9yv1UedUCX39+iHHr/17ACVj6y6StqzM3AOS95vfKC/oL79b8tcaeDXL+zR2g0INv69RgWJ6yGRnzicU/e+yFbW6TcQ2FktLPmPXmAAWd8vYKtg1SFSxOKYTXZqEf6Zp2w3XNr4TKcRfl0dHr8+XWy3gOiYPU2O1wzg15Q1+aIU4k1N7De3tqgorqGt330oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/eKuEJqm64wmtbZZQLLa1UkbuxAvlUJq8XraR52kqU=;
 b=nKaD+r2tSYMfMYNE7trm9fgB+PbNQmeNadBAG8M+iVo+vcrlH79XpulTeXF2b5TjCJfFoi1PMkrc09XBP4A15xN0ao4IzwvDkOfikvL2IDYPh/Z87e/om22/V503nGHmfAlz7yJh+3DL0lVtY5pBgSfY2AMvp8OUeguN7fFNdvg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7885.apcprd03.prod.outlook.com (2603:1096:400:482::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 06:26:42 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 06:26:42 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
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
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Thread-Topic: [PATCH v2 1/9] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Thread-Index: AQHaBYUzQpra4sLuvU2qkG87EeylgLBaDWSA
Date:   Wed, 25 Oct 2023 06:26:42 +0000
Message-ID: <53d8f44f485cbcd45a1910418dc0049909371682.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-2-jason-jh.lin@mediatek.com>
         <d93ff8f4-984a-4a20-9b81-5c088baf12e8@linaro.org>
In-Reply-To: <d93ff8f4-984a-4a20-9b81-5c088baf12e8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7885:EE_
x-ms-office365-filtering-correlation-id: 5fbfaa03-e0bf-4e35-2d5f-08dbd5235a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpXYiWNS4ik5Igm8etfpScXuVtWEoZkMcv6096x/bMv+vpAginGVeF0eFz3vJa1Md5G5K2Bn9W+HsgYMLXuBD8BkEEuDF/m//JJy1jU90Gl7umBeUMYRP3WckT/u/OhHChHKUBVsPRlJDAHDSfuFQMgoirs9wqj253e42t7RwJRgQUbXA9d0jC3KuzsNbgFzl+QABz2/K14VWJ1Evl0it28uWcLbMxxNjb7J+PLW9f6Iu3hxNc2JcojEo1Ta9hZ99lSkvXgGDTuAQ8O9e7DKF13BYpScMAg8yeSjOLtAogHD2odBC1Reak3QBjDJoJainQgk4knzlF0epHuVE76X2o7dgt+VcfQq9xU3MoKJObwUnVmmYPfY2DkkDdCe0RdN3w6QNA+y/LDWzqhxRul+vjI9BBFgktoiD26JAgxEE55CzTTrhTee2RACtkzUbQBRKxrqop5v4A2cmAg1x3W/Fmc793XT1zkPZY8X7HC1nOgJKbb6vW2CuFfohOm518aUI/qw+eCDbcDrOIWvhxLBaCN8iC3PP42423byQmVH8uyAudO/IuBFI2uGArWVtEb9NJTqdwEXfQBPUwkiNyc4Xnuy44H0QAf+hCXk8Zl+R+vk0anrYdrINuabhiMV2WRo37KcMzd2W1/xjkMS4KKxohtsmU872zV4jtWPR5C0K6Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7416002)(83380400001)(71200400001)(5660300002)(64756008)(66556008)(76116006)(41300700001)(86362001)(110136005)(66946007)(66476007)(478600001)(91956017)(6506007)(54906003)(6512007)(6486002)(66446008)(316002)(85182001)(2906002)(4326008)(36756003)(122000001)(38100700002)(8936002)(8676002)(53546011)(2616005)(4001150100001)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2U3SkxJdGpJYitVdWJWT0M4Nm5CbTlCdUkrL3VWRHBLVHRqL0tlRzBVbnUw?=
 =?utf-8?B?MkdBVXBCVFQ5Ym5nNk90R0xCeHVHM1BRVHlTYUpzTVNzT0F2d1ZUc21qMlM1?=
 =?utf-8?B?Z3NPUlFSc0VwbEVKbS9OUXBVQURrNEpSeEhSbXB5dmFWVXNCU1ZiZkQ2Mloy?=
 =?utf-8?B?c2ZTZDh1L3lTU2MrMkJ1czBCaXNMU3p5QmUrWkxwMVRIZytoY2F2QzJBbnc3?=
 =?utf-8?B?SGlkclBJa09VQUgvUlRVbzF4K2cxY0tiSkY5azlBajRxb0FHSEVKd1NmbzBt?=
 =?utf-8?B?QkJjRVhyQlg4MmNmTlZyQlVOTHZJYjRWZ01ZY1VWRlN6blhmYXZzOTA0WE1t?=
 =?utf-8?B?ZkJ5K2F0dHdlTHpiWjB3VUZzVDJRVGRJdWR4UUlUUVBTbFdyc0U1TkNiRDFk?=
 =?utf-8?B?NElYMzdZejVzUWN0eVRVYVpHeHdZV2FmajJObXZ2Y3hTbkQxUUJxT0NjMkdx?=
 =?utf-8?B?a3VSZ3RETnFoYTZKcDhvRndpZ1hnaDczeTl6YXpCQWJRQnhRMFNRZEYxSmY3?=
 =?utf-8?B?Uld1NVp4eEVZSjVZWDZUbTVNaWUzMGoyWHR3M3hMZnVTN0hkMi95L0duRjhQ?=
 =?utf-8?B?dnRiazlZSWszbXV5ZmtrOEtkNGV6dURHOFpqVmd3Z2VKM2tHM1F2cDMzVEhl?=
 =?utf-8?B?d1Jrenl0NDMyeFF3TU9jR1NpYzlJMTYxcWNZaDNtQ25LVmlJbTQwZitMWUZW?=
 =?utf-8?B?Z2xGL29ONHFIYVFlWHBzeGFIZmhJUlpVTFJUa09ZVWRxMmUxQjdXejQwTzV5?=
 =?utf-8?B?cDBjVENSa3FYcjhYQjl3UXdXMzdySDhBZnhkVU04NkN4VnBtZ0pXZVlXTFFy?=
 =?utf-8?B?Y3JSQ3JDQktaeGJsREpaNU91akwvZUg4c0F1U1dDcUxqcGx3K0crcy9HRHA1?=
 =?utf-8?B?QS9hWVMydFdYVk5zWnEvZjJrQU4yUGU1VW5zeVdjajcrRGpUZFNYbkMxTlhL?=
 =?utf-8?B?SFdTTXArL0lVVWZNNWZ4dm9teTJWUmd1Qjhic2YwdFAzTE91ck9EUGI2c3Nu?=
 =?utf-8?B?cTlxSlJrVE1zRnJETTdMNnpyTHFaM05idFN3WkI2MzU0VkZVVmduU3Vnc1d2?=
 =?utf-8?B?M0VPRjBDdnJtd0tTS0NHNHBTQVp0VzJhdDZKdThOTEVja0NSai9YK1luUng3?=
 =?utf-8?B?QSs5ZEFmVlpnQkFMVk5xRENtQkN6a3BybVJNeVdwei9rMUhWUzRXZE9JRWdH?=
 =?utf-8?B?d0pUNXZNZm9nK3ZUV3hTWDVCU0U3NHVtd2tjWElwTmcyYjFUSFZ3NWJCa29Q?=
 =?utf-8?B?WmlHbkk5Z3VXSk9saXBGTE5iTXhZKys1cW1RMTFVNXJrN3ZiZmIzbUowc1pi?=
 =?utf-8?B?ckFqdU5rYkJGaERRWlNoYUFUL3gyakt3cTBGMTlkRE5ZeUJiS05rbHVBdjBj?=
 =?utf-8?B?MER0Uml3ejNnSk1KQVNpTlBoSXQzZTdudUF1SDIyZ0k0aFcvQWh3WmVBa1RN?=
 =?utf-8?B?MlF1amxVUDJqTmhTSjBSWW14VjNublBkcC9hdFNiU3Z6WWlYSTJlcVN1b2xQ?=
 =?utf-8?B?cnpFRFBXZVdwM0ZoekRFVXRacFhQTmJjOXBNRkptak1wSXB3YUl2VzFTcXJs?=
 =?utf-8?B?WUQ5SFUyWnZodER5dEVZbkdTbVlJd2JSL1dYdEF6UHNibURNYlJRZWwzVXVH?=
 =?utf-8?B?SVRWVzBEZmVGNVRHV2FaV25RclV4Y2VnY294YUx5KzU3b21RVlVoQ1FQNVZG?=
 =?utf-8?B?b2VOWndySFVTdGVHSG4vUXpoWjZSMEIrZm1OOXllaUJzcnJnekgreGxtejNI?=
 =?utf-8?B?UXRwdXRjMVdVbmE0bkVoeGRQUUQvOFhaTklzU21xeGRNdVEzSkNSV2tlaUhP?=
 =?utf-8?B?SG0rZUxidm52TG82bFVqNWl0VjhlTnhhSGE1OTlIT0x3c2h1a2xsT0Y5dzdw?=
 =?utf-8?B?dElJTm9md1BnVXFqOUZsTjl4YksyMnQ5NWpRK0d6VUZaOVVmWkRiSGtXN0hW?=
 =?utf-8?B?amhhSHdxeUczRGFGWllraFF5MTlIQVpwRTQ2Q3JPQk5qVlh0Vjd5RUpDU05Y?=
 =?utf-8?B?eTQyc21laVlpNEpDU3daSEV2dVJrYVBlWjNWdWRDZnlQeTN3VHd2MVVCL2I4?=
 =?utf-8?B?a0ROSklnRjQyZFpkVHBNemQrMHB2dkUrYzROU3Z6WTNidW94ckppWFhhRnl5?=
 =?utf-8?B?UW1pZlMyYUorNmYrRlhkUkc4anNtZnFKMk1hdkVNRXdWWGY2SG4rL2RVVXZq?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2733CE32D0E2CF40BADB3D39636187A1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbfaa03-e0bf-4e35-2d5f-08dbd5235a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 06:26:42.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOm5xxsrIWIHChwOuBAx6euMaOX49G8sdQdooKJau+xEVWMaEsH+1Icn/tuziWAVZcwVk0k5sQoZGiOZLsQLPuTywIfuBXnR60SjUqNBw1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7885
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.791200-8.000000
X-TMASE-MatchedRID: QW5G6BKkLTqnykMun0J1wmjZ8q/Oc1nA+WzVGPiSY8gNcckEPxfz2DEU
        xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CydpfncOF/0WdSVUkz9BPXexhL
        t/2rTcUnLPjVydrOOXnfm2qkN6lKnZPJiiebq1E9CCMcA2lOZq0Crr/LkAQ46o0y/q6CYk4Jm+j
        6YVbX2YHdvCV/NEMY7XEHGVOkRwUrau9iF5mAFe7MjW/sniEQKjI6qXkf2FQ3FHcwKL6UE/zG1K
        s84Hh014vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.791200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9865DE7AD7DCCA461CB5240C0F25731DE1ABDA9F552A7E7140E9F8F2D02BE55E2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjMt
MTAtMjMgYXQgMDk6NDcgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMjMvMTAvMjAyMyAwNjozNywgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IENN
RFFfU1lOQ19UT0tFTl9TRUNVUkVfVEhSX0VPRiBpcyB1c2VkIGFzIHNlY3VyZSBpcnEgdG8gbm90
aWZ5IENNRFENCj4gPiBkcml2ZXIgaW4gdGhlIG5vcm1hbCB3b3JsZCB0aGF0IEdDRSBzZWN1cmUg
dGhyZWFkIGhhcyBjb21wbGV0ZWQgYQ0KPiB0YXNrDQo+ID4gaW4gdGhlZSBzZWN1cmUgd29ybGQu
DQo+IA0KPiBzL3RoZWUvdGhlLw0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1K
SC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiBUaGlzIGlz
IGEgbmV3IHBhdGNoLCBzbyB5b3UgbXVzdCBtZW50aW9uIGl0IGluIHRoZSBjaGFuZ2Vsb2cuIFRo
ZXJlDQo+IGlzDQo+IG5vdGhpbmcgaW4gdGhlIGNoYW5nZWxvZyBzYXlpbmcgYWJvdXQgdGhpcyBu
ZXcgcGF0Y2guDQo+IA0KPiANCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ4MTk1LWdj
ZS5oIHwgNiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2djZS9tdDgxOTUtZ2NlLmgg
Yi9pbmNsdWRlL2R0LQ0KPiBiaW5kaW5ncy9nY2UvbXQ4MTk1LWdjZS5oDQo+ID4gaW5kZXggZGNm
YjMwMmI4YTViLi45Zjk5ZGEzMzYzYjkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9kdC1iaW5k
aW5ncy9nY2UvbXQ4MTk1LWdjZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2Uv
bXQ4MTk1LWdjZS5oDQo+ID4gQEAgLTgwOSw0ICs4MDksMTAgQEANCj4gPiAgLyogZW5kIG9mIGh3
IGV2ZW50ICovDQo+ID4gICNkZWZpbmUgQ01EUV9NQVhfSFdfRVZFTlQxMDE5DQo+ID4gIA0KPiA+
ICsvKg0KPiA+ICsgKiBOb3RpZnkgbm9ybWFsIENNRFEgdGhlcmUgYXJlIHNvbWUgc2VjdXJlIHRh
c2sgZG9uZSwNCj4gPiArICogdGhpcyB0b2tlbiBzeW5jIHdpdGggc2VjdXJlIHdvcmxkLg0KPiA+
ICsgKi8NCj4gPiArI2RlZmluZSBDTURRX1NZTkNfVE9LRU5fU0VDVVJFX1RIUl9FT0Y5ODANCj4g
DQo+IFdoeSBpcyB0aGlzIGJlbG93IDEwMTk/IFlvdXIgZHJpdmVyIGNhbGxzIGl0IGFsc28gZXZl
biwgc28gaXMgdGhpcyBhbg0KPiBldmVudCBvciBub3Q/DQo+IA0KPiBZb3VyIGRyaXZlciBkb2Vz
IG5vdCB1c2UgdGhpcyB2YWx1ZSwgc28gZG9lcyBpdCBtZWFuIEZXIHVzZXMgaXQ/DQoNCkkganVz
dCB3YW50IHRvIHNlcGFyYXRlIHRoaXMga2luZCBvZiBldmVudCAoc3cgdG9rZW4pIGZyb20gdGhl
IEhXDQpldmVudC4gU28gSSBkZWZpbmUgaXQgYWZ0ZXIgQ01EUV9NQVhfSFdfRVZFTlQuDQoNCkJ1
dCBmcm9tIHRoZSBwZXJzcGVjdGl2ZSBvZiBHQ0UgZXZlbnQgc2lnbmFsLCB0aGVyZSBpcyBubyBk
aWZmZXJlbmNlLg0KU28gSSdsbCBtb3ZlIGl0IHRvIHRoZSBjb3JyZWN0IHBvc2l0aW9uLg0KDQpS
ZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQo+IA0K
