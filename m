Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F7C7CBF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjJQJkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJQJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:39:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEACE8;
        Tue, 17 Oct 2023 02:39:55 -0700 (PDT)
X-UUID: 1cdf80786cd111ee8051498923ad61e6-20231017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NunfXHox/zpl3ZAkIhdeEDVWeNd6Ao9PjETXCaM9hys=;
        b=MgCYomjpqlFfBg4LlwOuO5v87WKwwspeQPkgUZE4FBO263Z0KfXECefa2YA0Ysw7RnWCbxHtfrOCyoVhKLZqq+apjiTyt+LmcgNjtOTlA2w6LAs9rxzN9o5pP35p3oK2XzQbTI+TPxvR1Q6J5e1PN9SR13iTeRaNXwZ66uJyl/o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:bec5ca93-4391-4c71-89ed-bef1ef3de337,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:7ed207c0-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1cdf80786cd111ee8051498923ad61e6-20231017
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 65772714; Tue, 17 Oct 2023 17:39:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Oct 2023 17:39:47 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Oct 2023 17:39:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRU1J7STEjB4IcheXXHkACw+R7hIQTcu95ix27NNyQiXqXHanUf9jl3HqJvYxY3DnG4zS+2ab5KmJL8XUhZAt3b+z4Ha+jJiBM2rfLpEMyzw2fQxg/SQgIfR+TbnssK4UdGEodsUC38CMg8K1t+wGGG6Tilxr3qkhjTUkPwreoAiY26d4ZRClFhbl44DqdWD0DY60HMGZ2mWwuZ72336IH485HXIL/xnW+iIfmjTZp0ARlVfTHQ+TeKDvV4yOouNBv4m5D9nSZIDTI9AcHN1Dllxb8D2F4wSXr6C5tcG3CmRUOzdQqEmQJGslRFOX3PNKcytCI5a9zNdz3xKCtxKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NunfXHox/zpl3ZAkIhdeEDVWeNd6Ao9PjETXCaM9hys=;
 b=WA1kNL3s0+yyh29fX0WMnVg1uGA3Pft5fPB8cofoM1e6yuGtp+suEuUaD06c+djtfhzXq4KYDjXRSo/xGmO5tRVlY3Fq2MHD2nj9q8WaksN4w2EcJ0iSQm73urM/n5KDkTIKBLMEg+lNJWfJ/ISjtb0SJI0Xxfrb3dIOQ1xX64pEDe1rr5V2RT524mcYFeQA4AmIk3xc6f+MWXfcSaJcAUYwTUj2cngD9FLtcfoQj9bR/YrpvU4hIfYRsaSKbEAfy8Ntm/Mqc/jVq3kDKb4xNksuHBnIa3rrwvpWZxPSU6PGnrTjaA4CAq7HdjLDME53k4dPCbeDvPIuY6Z+WwiXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NunfXHox/zpl3ZAkIhdeEDVWeNd6Ao9PjETXCaM9hys=;
 b=ZG5nMBL214NG4OvnsYBuTjvovt7n9/RDZwuTGgEy2IB2Dq9KyZzZvSUYoif2ZEYdg1zQ7LCA68Jw2QAkbrDsdinZptCACqURyJ8rBcap3AIjXrLcVWTMzTPxR8TRzfKgTcp0cr/cwLzh2n65ziKzY1E/7j00rnyLKvAldhebriE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6383.apcprd03.prod.outlook.com (2603:1096:4:17e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 09:39:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 09:39:44 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v8 18/23] drm/mediatek: Add Padding to OVL adaptor
Thread-Topic: [PATCH v8 18/23] drm/mediatek: Add Padding to OVL adaptor
Thread-Index: AQHaAB1EixObw21Uq0u7w4OT/d59A7BNu30A
Date:   Tue, 17 Oct 2023 09:39:44 +0000
Message-ID: <7f1da971c0b6256326950a4e3b28ed25f93813bb.camel@mediatek.com>
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
         <20231016104010.3270-19-shawn.sung@mediatek.com>
In-Reply-To: <20231016104010.3270-19-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6383:EE_
x-ms-office365-filtering-correlation-id: c453ef5d-30af-406b-e8f8-08dbcef4fef7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6J4/WO/2z6X6q5c816d4UHa9BqSaxRUM2lBrP2Q9vCwTIrj7r19jwCDDDRGvlcF9prHWtLsg2J19min2xjf8VJNzkWtG0Hu7xwYxIulrySGEdsoaheX8dpnO5WEEMxipNsnEJg6I9tzZYoC1fnpCeIjEsBxCmfvgj7yPxNsrHV4yifvwORujTvPcn6tCnajmHJq0ilsjA+WBSoReexM7EgzJrC+TDSm/Vty1hhMUbamIWSt4IVQzKOcSA988XUl9tTxEVkQx7aUsaMCdlSy5tXYEaEBjH7XLzGVA5zmJFE+PsbWoFNIOdKuGZdib/H/wlXw3FVSIzXpA2j0sxJg50yTlQJRGOOFBD3m39I+7YkyU7FhZm2lfq1gy238CWj47gNx7LBLqirfnZRsXbrDV5oRTu95UVPDDLJo4ayWkRLiD04yGyFfHVsbUdBMB4fQx3o/z1cfUCWSJLTrEyuV2Le5R1MqTGZR75anMwyCVq+B+tRHg0ISf69GxvQStiMVbmwVfPO6/l8UdomoCTU7XVlFyhk2P1CIAjwa5lyBpf3TBQPqF+KtAJkFuUmtax/UoppE1gzP2olG+yjUYfyUrx7uw+uIESK1RCDnpDlx5vygLPmCYs8blW414zXBlG8ZWjZlFtDFz+pRxVS3iP0y/OTxhpWW4OQZpyhW5jMUU2A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(478600001)(76116006)(2616005)(66446008)(66476007)(54906003)(316002)(110136005)(66946007)(66556008)(6512007)(26005)(64756008)(6506007)(2906002)(8936002)(5660300002)(8676002)(4326008)(4001150100001)(7416002)(41300700001)(71200400001)(86362001)(36756003)(38070700005)(85182001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3ZSOGViZTNadXVjcFFEK2NFbFQwaUV5YWJ5MzJucXBIWSs0YklXZUNwbGlZ?=
 =?utf-8?B?RCs5Y1llWGprRTczR1RjY2gyeThreUlxSmluTDNONlFURlpLTm0vRzk5WmlG?=
 =?utf-8?B?YnNNOVM5L2tUZXNqbmhwc3ZEK0JrWVNtSGpEUEtrRDl0ZXBNVi9PS2lFV3ph?=
 =?utf-8?B?NkhUa2pNY2Ywb0tCdERrWGRpaDlqdG5mSFQySEY5bk8rc0pTdUg5MTJ5MDVU?=
 =?utf-8?B?S0tMZ3ZFSzN2OThHanE3eW1xdlp5akJuVXg2ek9NMlM0KzQ3MXRBcE1ZNWdL?=
 =?utf-8?B?L3lUZkVRclVBSGVkOFBIWVozc2xNWG9hbzMrWU5YL3BEcFRNWTZEQXVWT3lp?=
 =?utf-8?B?T01hVm5ZU3pHb3dpWjFSRlFWeldBVnVrSXhnL09Ma0JHOXNLV3ZuZ05xY3Vu?=
 =?utf-8?B?RzhFbjJ6NVNDRHlWam1vb0JHWWFmOXl0SFN0V3lxUTNpMURibWpsdVJMMkFO?=
 =?utf-8?B?MW9GV3owOHZkWDVQQlArZlpEQVdlYWpZOHIxZGE0dGI5eFd0YzNPYVRnTEdJ?=
 =?utf-8?B?cGpMUHlzVEVFdnppSmdLbk4wKzhlWVlqRHF6cm1ocVNlRzJndmdKVVNJUCtC?=
 =?utf-8?B?eEl0RVdxWG54Q0FzanE1SjZGN1ZPTnRyVG5QZmdxYlkzUWhmbU1WYjRGQTlM?=
 =?utf-8?B?T0RHc3ZYbHlaVUxrYUZlS09VclZOaHZpR1Q0WGNUdGZGZ04vUE9rc1hxOWFq?=
 =?utf-8?B?a0phb2srV1UwL1NYajJDRU1kMUpJdFM0bnlZWXJmdVhrNkoxWUxDR1IrMXdz?=
 =?utf-8?B?ZFJTbkNiRlk1NEJoY0E3Z292NFAxR1REYlBaclVkL1E4SVlObHJGSlprcUVp?=
 =?utf-8?B?K0NqenBES3ZkVTdkU1VTNkwrd0JiUnJxRGxoQllzQVlHeCs2MXVGM2d1ZnJn?=
 =?utf-8?B?NlJUNkgvYmRUNGpBUDcrN3FqdTd5V2UxbFR1VW9jbyszNWYyK2tvaEI2a2pV?=
 =?utf-8?B?ZElFbEZ3Uk56Y3NYTE00Tmw5eTZCV2Z1MFBjWSthb1ZhNWZnb0laQVRsZkRL?=
 =?utf-8?B?TGdWSG1SSFVla2hIRTloRk1sT09LR1YzRFowWCtKb0RGd0lyenF0SW1ESUl2?=
 =?utf-8?B?T2xRdDIrR1RNMHEzcko4VndBWHJVbGpyM3lmUTZYVGpERnZwZE1lSDNSMlZp?=
 =?utf-8?B?eEJYTThWSlNPbEJpeTdkNVJKMXo2YlhNRDduQ3U5T1RXZ3dBTTljZjUzT3V4?=
 =?utf-8?B?VzRNUmZXUUdVK0dEZXNyMW9jaFRyZDdmUi9rWFRWRUpVVmhoTDBzR1Rxcm5v?=
 =?utf-8?B?WmNuRTdCbGJwZWdua3hQUVhYeHVTVSt5WTVreklnQzFRdms4dmdaUnpuRE5o?=
 =?utf-8?B?UzYwVEMxUDNDamQ3aFVtc1BtbSszaC9XRWF1cmwrVzI0M0xhOGVvc24zK2hi?=
 =?utf-8?B?djNWVzBhUFJpa1hOS1RkWWJiV1IxaURYaVRlR3BkMGhxckhCdlIrNmRnOHZm?=
 =?utf-8?B?WFJxWVZsQ0tVbXhQQVltMUYxQVNJL2JjSmlwYi9zejkrZDR2NFJQZzBxTk1W?=
 =?utf-8?B?amZYdzI2S3RheEc0a1V1R3VyZllIcmlzZ0REMXgrZm9pVXZXWU8vditvVTJO?=
 =?utf-8?B?bUdab3NlRGo5MjFsUnVvMUhsWVpWK2JhQWNQbXNBNjZnQldEbG4vZnh6MGZ2?=
 =?utf-8?B?SHZod1l0YzQvVExWUTgvWjA0cmcwazVEc0NFT1ZRQ09iaVhxYmFob1JzS2xC?=
 =?utf-8?B?TFYwMGdmKy9XODlsSStXbktDWVhIR3haRnZuUTFweHNuU1ZMMlB0SUJkNEth?=
 =?utf-8?B?cmoxVCtNZUQ4dTVKOWhKNHVpZjRvMDlrTDNxSVFJUEh1QXE1YUdPMU00TXU1?=
 =?utf-8?B?L3BJZzAyOU9RNXhoWTFwWkhHLzEvNmhWd0U2SGpYdURpTEJncDF6My9qaTRy?=
 =?utf-8?B?eTNFQklpUjA2WTdROHpsOVEwQ3RnekpxZFFDRzBnR0NYUS9ZZnE3SzFrbVNz?=
 =?utf-8?B?bEsyYXJsK0dQeVliYVZ5SkdiSDFVOXFZbi9peUo5M29DdTZmams4NkFUeXZR?=
 =?utf-8?B?aDZkdklKREQxNVZNbWdaTzZXcERvNFhRRXR3WEllOFg4MFp6TDBBQ3JKY0pF?=
 =?utf-8?B?eG1DY2d3TjQzcS85UUdPOEovUkNaWWFleGsvN2UxR25YYjRTU1hWVkZLbXIx?=
 =?utf-8?Q?JFB5e0w1ikJDv00ulRMZSYNm5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5678A3D28F7EFD49AF60B4463CB20F99@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c453ef5d-30af-406b-e8f8-08dbcef4fef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 09:39:44.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NvvDkNr8ullcQZVPncm6z2WBDx4Y3mk/Jdpc6Vfq62cR0ICQWUPodMCLBcrc0X4GgTpAxp9uqxs04DnAp+zUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6383
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMTAtMTYgYXQgMTg6NDAgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEFkZCBNVDgxODggUGFkZGluZyB0byBPVkwgYWRhcHRv
ciB0byBwcm9iZSB0aGUgZHJpdmVyLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlh
dGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24u
c3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgLi4uL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsX2FkYXB0b3IuYyAgIHwgMjYNCj4gKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGluZGV4IDM1NGJhNjE4NjE2Ni4u
YjgwNDI1MzYwZTc2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBAQCAtMjksNiArMjksNyBAQCBlbnVtIG10a19vdmxfYWRh
cHRvcl9jb21wX3R5cGUgew0KPiAgCU9WTF9BREFQVE9SX1RZUEVfRVRIRFIsDQo+ICAJT1ZMX0FE
QVBUT1JfVFlQRV9NRFBfUkRNQSwNCj4gIAlPVkxfQURBUFRPUl9UWVBFX01FUkdFLA0KPiArCU9W
TF9BREFQVE9SX1RZUEVfUEFERElORywNCj4gIAlPVkxfQURBUFRPUl9UWVBFX05VTSwNCj4gIH07
DQo+ICANCj4gQEAgLTQ2LDYgKzQ3LDE0IEBAIGVudW0gbXRrX292bF9hZGFwdG9yX2NvbXBfaWQg
ew0KPiAgCU9WTF9BREFQVE9SX01FUkdFMSwNCj4gIAlPVkxfQURBUFRPUl9NRVJHRTIsDQo+ICAJ
T1ZMX0FEQVBUT1JfTUVSR0UzLA0KPiArCU9WTF9BREFQVE9SX1BBRERJTkcwLA0KPiArCU9WTF9B
REFQVE9SX1BBRERJTkcxLA0KPiArCU9WTF9BREFQVE9SX1BBRERJTkcyLA0KPiArCU9WTF9BREFQ
VE9SX1BBRERJTkczLA0KPiArCU9WTF9BREFQVE9SX1BBRERJTkc0LA0KPiArCU9WTF9BREFQVE9S
X1BBRERJTkc1LA0KPiArCU9WTF9BREFQVE9SX1BBRERJTkc2LA0KPiArCU9WTF9BREFQVE9SX1BB
RERJTkc3LA0KPiAgCU9WTF9BREFQVE9SX0lEX01BWA0KPiAgfTsNCj4gIA0KPiBAQCAtNjYsNiAr
NzUsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0DQo+IHByaXZhdGVfY29tcF9zdGVtW09W
TF9BREFQVE9SX1RZUEVfTlVNXSA9IHsNCj4gIAlbT1ZMX0FEQVBUT1JfVFlQRV9FVEhEUl0JPSAi
ZXRoZHIiLA0KPiAgCVtPVkxfQURBUFRPUl9UWVBFX01EUF9SRE1BXQk9ICJ2ZG8xLXJkbWEiLA0K
PiAgCVtPVkxfQURBUFRPUl9UWVBFX01FUkdFXQk9ICJtZXJnZSIsDQo+ICsJW09WTF9BREFQVE9S
X1RZUEVfUEFERElOR10JPSAicGFkZGluZyIsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBfZXRoZHIgPSB7DQo+IEBAIC04MCw2ICs5MCwxMyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBfbWVyZ2UgPSB7DQo+ICAJ
LmNsa19kaXNhYmxlID0gbXRrX21lcmdlX2Nsa19kaXNhYmxlLA0KPiAgfTsNCj4gIA0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgX3BhZGRpbmcgPSB7DQo+ICsJLmNs
a19lbmFibGUgPSBtdGtfcGFkZGluZ19jbGtfZW5hYmxlLA0KPiArCS5jbGtfZGlzYWJsZSA9IG10
a19wYWRkaW5nX2Nsa19kaXNhYmxlLA0KPiArCS5zdGFydCA9IG10a19wYWRkaW5nX3N0YXJ0LA0K
PiArCS5zdG9wID0gbXRrX3BhZGRpbmdfc3RvcCwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIF9yZG1hID0gew0KPiAgCS5jbGtfZW5hYmxlID0g
bXRrX21kcF9yZG1hX2Nsa19lbmFibGUsDQo+ICAJLmNsa19kaXNhYmxlID0gbXRrX21kcF9yZG1h
X2Nsa19kaXNhYmxlLA0KPiBAQCAtOTksNiArMTE2LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b3ZsX2FkYXB0b3JfY29tcF9tYXRjaA0KPiBjb21wX21hdGNoZXNbT1ZMX0FEQVBUT1JfSURfTUFY
XSA9IHsNCj4gIAlbT1ZMX0FEQVBUT1JfTUVSR0UxXSA9IHsgT1ZMX0FEQVBUT1JfVFlQRV9NRVJH
RSwNCj4gRERQX0NPTVBPTkVOVF9NRVJHRTIsIDIsICZfbWVyZ2UgfSwNCj4gIAlbT1ZMX0FEQVBU
T1JfTUVSR0UyXSA9IHsgT1ZMX0FEQVBUT1JfVFlQRV9NRVJHRSwNCj4gRERQX0NPTVBPTkVOVF9N
RVJHRTMsIDMsICZfbWVyZ2UgfSwNCj4gIAlbT1ZMX0FEQVBUT1JfTUVSR0UzXSA9IHsgT1ZMX0FE
QVBUT1JfVFlQRV9NRVJHRSwNCj4gRERQX0NPTVBPTkVOVF9NRVJHRTQsIDQsICZfbWVyZ2UgfSwN
Cj4gKwlbT1ZMX0FEQVBUT1JfUEFERElORzBdID0geyBPVkxfQURBUFRPUl9UWVBFX1BBRERJTkcs
DQo+IEREUF9DT01QT05FTlRfUEFERElORzAsIDAsICZfcGFkZGluZyB9LA0KPiArCVtPVkxfQURB
UFRPUl9QQURESU5HMV0gPSB7IE9WTF9BREFQVE9SX1RZUEVfUEFERElORywNCj4gRERQX0NPTVBP
TkVOVF9QQURESU5HMSwgMSwgJl9wYWRkaW5nIH0sDQo+ICsJW09WTF9BREFQVE9SX1BBRERJTkcy
XSA9IHsgT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HLA0KPiBERFBfQ09NUE9ORU5UX1BBRERJTkcy
LCAyLCAmX3BhZGRpbmcgfSwNCj4gKwlbT1ZMX0FEQVBUT1JfUEFERElORzNdID0geyBPVkxfQURB
UFRPUl9UWVBFX1BBRERJTkcsDQo+IEREUF9DT01QT05FTlRfUEFERElORzMsIDMsICZfcGFkZGlu
ZyB9LA0KPiArCVtPVkxfQURBUFRPUl9QQURESU5HNF0gPSB7IE9WTF9BREFQVE9SX1RZUEVfUEFE
RElORywNCj4gRERQX0NPTVBPTkVOVF9QQURESU5HNCwgNCwgJl9wYWRkaW5nIH0sDQo+ICsJW09W
TF9BREFQVE9SX1BBRERJTkc1XSA9IHsgT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HLA0KPiBERFBf
Q09NUE9ORU5UX1BBRERJTkc1LCA1LCAmX3BhZGRpbmcgfSwNCj4gKwlbT1ZMX0FEQVBUT1JfUEFE
RElORzZdID0geyBPVkxfQURBUFRPUl9UWVBFX1BBRERJTkcsDQo+IEREUF9DT01QT05FTlRfUEFE
RElORzYsIDYsICZfcGFkZGluZyB9LA0KPiArCVtPVkxfQURBUFRPUl9QQURESU5HN10gPSB7IE9W
TF9BREFQVE9SX1RZUEVfUEFERElORywNCj4gRERQX0NPTVBPTkVOVF9QQURESU5HNywgNywgJl9w
YWRkaW5nIH0sDQo+ICB9Ow0KPiAgDQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXllcl9jb25m
aWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQNCj4gaWR4LA0KPiBAQCAtMzY5LDYg
KzM5NCw3IEBAIHN0YXRpYyBpbnQgb3ZsX2FkYXB0b3JfY29tcF9nZXRfaWQoc3RydWN0IGRldmlj
ZQ0KPiAqZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsDQo+ICB9DQo+ICANCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19vdmxfYWRhcHRvcl9jb21wX2R0X2lkc1td
ID0gew0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXBhZGRpbmciLCAuZGF0
YSA9ICh2b2lkDQo+ICopT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HIH0sDQo+ICAJeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtZGlzcC1ldGhkciIsIC5kYXRhID0gKHZvaWQNCj4gKilP
VkxfQURBUFRPUl9UWVBFX0VUSERSIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxOTUtZGlzcC1tZXJnZSIsIC5kYXRhID0gKHZvaWQNCj4gKilPVkxfQURBUFRPUl9UWVBFX01F
UkdFIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtdmRvMS1yZG1hIiwg
LmRhdGEgPSAodm9pZA0KPiAqKU9WTF9BREFQVE9SX1RZUEVfTURQX1JETUEgfSwNCg==
