Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB87643AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjG0CGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjG0CGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:06:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2611BDA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:06:10 -0700 (PDT)
X-UUID: 25836aa42c2211ee9cb5633481061a41-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=55sfvHSXVqHYjeM2i9W8sHK0GSiNLTT31GteKVKgKbk=;
        b=iOs95OOwhA2ulRX/w10P3Mo8k93ROkcfa9DUMY2EMiuAGacGWm6f95zL9xEwd9FBLX2EyXBjhkSv4+OAkqxiBHnLhvmfxZgh04ZFkLZb6eNaQKmfIL3GiIfVfy5kDfFmb+tz5UNdG7qUOqZPCqD/lTHQffCmktwT5Rw9n6sIwAY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:3b483c85-2f37-431f-9748-71a6eecf4ee5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:83e77f42-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 25836aa42c2211ee9cb5633481061a41-20230727
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 547937177; Thu, 27 Jul 2023 10:06:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 10:06:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 10:06:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifrVIdM9ah59k2zokzdODoxLdOCyuIyjL0vJHWDfjhbr8nfyuLC0GBhhlfLg0HtdGkshfrY50wg855pbAyv3IZlyPvwkzUyNMxeItDE3AVfaQ80Kok40TypA/9ji88vmh8A+0swCu55gWBsOezg0FADSHt4l14hDJyTA6E/ww1esnf2bxzJsvgh8z1xVojH4dv3bm4nSuwOkmehSzEb44ZM19KKuKGW5HTdpLlOonT1inCVeRFx2FwaIM86RAneatB25tSQ67DQO1pSG9pvOvaYOEq0xQAufA3a7Wtk1usa8BIKjoz10fpL5DROKiwU6hobMJgrhlCB6asfuvm9dfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55sfvHSXVqHYjeM2i9W8sHK0GSiNLTT31GteKVKgKbk=;
 b=Ibftq+jey3TeUCgQg/fe/SRmDG9S52hXaMHj8siB+lICJlupQeH4uvAJAcgLQ8FGN8zoUapaq9nGRB78+kfcs9aj/qRJeTYcsnFbdM0nQ2kiYXsVy0ShKidl6R2vnWjoBhQwgyGkvSOTDbIaUb67CMYLSoBhtkkSO5DrwSBhnUuoVHWOCifyxgSp131ckWfO/wDkBdF/YlbQZtpH62wNdcqlzyD7+qkBl4ZsUSVwYTy6grEfjl2wCOPDRTUZ2T8t7LXHM1Ss38Xf5EfBfpKuVGuuBRYyyr7tDQywV1zh35sbnD6vEG+DHAxT/BWl6I0tDICHcWQ9jA8DzdAfmPt0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55sfvHSXVqHYjeM2i9W8sHK0GSiNLTT31GteKVKgKbk=;
 b=c+KI4hsdh7WSxqbiQO5OMILRsbAn4CDNjWLUUWyfFfcSTokVdyvrkjHhibocG/ZfEELheoisHEqV9dwImfg1mw6VUpN/xBFBi/ZBTbe/MUaLAL6c6YqsbY4Ug0Sn5Qr2PXE3SydgaCueg2wdI9g8BcJaeawuQ6yqK4uu6iHb2fU=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SI2PR03MB6195.apcprd03.prod.outlook.com (2603:1096:4:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 02:03:01 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:03:01 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
Thread-Topic: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
Thread-Index: AQHZvquHbd20P9+WpES+HRrZk+KuQK/KD8AAgAFCEICAAEnvAIAAUdWAgAAE8ICAAO0TgA==
Date:   Thu, 27 Jul 2023 02:03:01 +0000
Message-ID: <72868ec18a5b97f62c70dddb1ea8b529c8dcd087.camel@mediatek.com>
References: <20230725035304.2864-1-trevor.wu@mediatek.com>
         <20230725035304.2864-2-trevor.wu@mediatek.com>
         <5314542c-9a99-fad1-93f6-4f72c8698715@collabora.com>
         <69690b530fb46d6adad1732d570c8cfad9c0f23c.camel@mediatek.com>
         <320ab7cc-32dd-79dd-b2ae-96d3608aeb9c@collabora.com>
         <b9e49c0a16bb59ed803fbb6102269b948be95ecc.camel@mediatek.com>
         <82fb1e56-b271-0ba9-c23d-0c066dc51ef6@collabora.com>
In-Reply-To: <82fb1e56-b271-0ba9-c23d-0c066dc51ef6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SI2PR03MB6195:EE_
x-ms-office365-filtering-correlation-id: adb17aa7-ec6f-45a4-391f-08db8e459b58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnShvHytvTrTkQwiL8RNow0zp96cghwTYUcDqfXz5esainH5UVKoI8du46XLq32EdPiH26ajm1MhaAGa2w0+r0PIWf/nYBX3AjPkfvHRHfpaEVZhaYKg8RjqC4vF3XVRgJIcKa9V5nXC73rAnq7zyyt0IqsykUp47H0B5ffl/+sQKwe3rzPlHI3TBGp2t0pV1xdQ1NlmNTvNh0oSbdcMpPY2pyrJV8i0PM5vghiPU07t3rYA+8V24y6WdCXbj7Qh7BQP3Q5O0EMrVhV6XuSIPdInWJN82PbMIqqVt6W/Qvt0zHmj/IHaHIP6sCmoNMpIzDQt9YMWgmvPqlpi822xvEoLfzOEESasC55cN/JyxGTJWFGBts1kp0Pl7iye6JqxDL4fB3btIjFzjQCNelwiCxrBgc+w72i+wSgKGmi6CujPvL5HwsCB7o4AT2KjI1NO7TLbPBeH9GwFNnwMSnow40xdvAhot0ytdDIi4ytCGVOr1iGmuaD+4pp38K9udVvcYAOdWVKH0eCFvTZwpOJkHWYT/Vn8IfpU5yUhxJD47abGUUB7finpNDun6dPKC/AURljhCkQRdkuDpkP6tDu5/my+Fq6wblmUig3rD8z/GtPRXM1PqSWZGvPxgVFfAYr5gMjKpuxp2NCWKS0P/bK9EzuCxvfNSBMrDHUn0u79jyNu9Fg19zRH7/uCTdZnVRnQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(54906003)(478600001)(71200400001)(41300700001)(38070700005)(8936002)(8676002)(85182001)(66556008)(122000001)(66946007)(76116006)(66476007)(6486002)(91956017)(110136005)(64756008)(66446008)(4326008)(2616005)(86362001)(2906002)(6512007)(83380400001)(966005)(38100700002)(316002)(7416002)(36756003)(6506007)(26005)(5660300002)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXVYTnlHSUhxZUV5b1JjVkgxYVpOZ3FhYjlUT0gxejNMV09tbm5aYnVHOXZE?=
 =?utf-8?B?NWVuZTR4ZlU0UlFpTEk0aGVTSmRqK0xyc2F3WFRGT0ZzUUppVTBxUDJvNkEx?=
 =?utf-8?B?cm9SYW5GNEtqdkJxRHhRY1Y2SnNYdzhDdWcySm5hZlVSUEd5bnRyS24xamli?=
 =?utf-8?B?RnVVcklVd1lJT2NSRW9IU3VDME0rTzg3SG5SV29tK2ZSQ1RFREt6Sm9melhH?=
 =?utf-8?B?eW1VMnc1dUdiTmFyaWJtSVVhZVZqc25zaFlmRS9JZm52ektUZ2RQTVVwbU9T?=
 =?utf-8?B?SFU1NnlPamtBbGJiUHpRTC9MOUcyRklKcUdtbG9Ob1BiN1pKdDIweUpiR05z?=
 =?utf-8?B?QTBocTBQM1c0eHZiUmFCc2NoQnRETUhwenZ4VzUvYkl3alJsdm00SWg2S2xy?=
 =?utf-8?B?eGVWTVd2dkxDb3F5QXpxNkIvTHRHZkV3OUFHR1BabEw1a0M5d0RrK2FlRmZI?=
 =?utf-8?B?Z3YwR2sxTUdFbnh3ZWJ6ZTJtOEJDWlBRS1JTaTZNRlpySGE4MGViRlo3WDVB?=
 =?utf-8?B?cnNyaFZJTW4zUXl4dFQwTnczd24wSjAvOTEwSFpLRmdyZmpHNWh4RjVIQkVQ?=
 =?utf-8?B?bHZtMk5VMEozTnpydzRRc09lU1NuSnptUmNIV1hneXkwMmJoLyt3Q1lkYmE3?=
 =?utf-8?B?WE9mNWN3NGpVeUI5Y0dBUDZvbklnbThrWG81ODNUTUFKYjQzcWtlbnlxL2dN?=
 =?utf-8?B?Z1lud2RIT3dwMERGWTZkQlNNOVVKWm5RaVRIUzBmTm9KVFNoR2toZk9sVUNx?=
 =?utf-8?B?ZlhZNEh2T1dxRWdJUWpJcE55SXNwQ1dBQ1pJSmMrT3ZnWG5xcnNwWkxXVXNO?=
 =?utf-8?B?TkJvVENNMkN1cGVNQTdJZExZa0ZyZ2FDOTc2UFJ3OTZGWTk4QnJZOWZKblcw?=
 =?utf-8?B?d0RyUXVidVh2RjhEaGVCTFBjV3cxcERseENmQkJjN3VOTlZsaDg5OWVRaEd1?=
 =?utf-8?B?cHB6Z2pZTURPUVRPZSs4R3QrNFZwa0xNYlJvMzVKOWQzVzVDR2Z1emdIYTc4?=
 =?utf-8?B?VzJFNThiUVJjeEVxYkY0UHNieUwwL1V5RUZKdTRsaGt2YWlwaGVobmZMSXVS?=
 =?utf-8?B?bFk1VzJMOFphRVhmS1ltUXRtalo0ZEJpOVRrUC9ObHQxM00vUzdKbFlza0JW?=
 =?utf-8?B?ekdMb01GNWNobXpqR3FCOGNyZ2h5V1hucng4VEM2elhQeU5EVVlHR1VpK2dl?=
 =?utf-8?B?RzRnRzB3MHhOdzlwaDVZTHUza25FY1YxYlluZGk5YnE1MERBR3IweWVkMUlr?=
 =?utf-8?B?bFYzK2pFbXhsdXM1WUFQTC9xZWh4cHJINWJ4dldsRyt1MVAwOHJaWXNYS1Bz?=
 =?utf-8?B?SEJzUDNmWnZlckxROG52RXorQVIyS2ZKZVgwR0xJZVZtZlh2WlZneks3d0Yw?=
 =?utf-8?B?cEpkWDcvUjFwcVBmR24zZ1lMc0xQWWtKeVpuVmJEdG0zb3hZYU1PbGxpODRF?=
 =?utf-8?B?OENwRWxGejVNMWFpUjl2YnorY2ZIaFM1cVAyLzVGaURkeW9jV2RIYk1obmR6?=
 =?utf-8?B?a0ZXOERwazFhL3FmZytKMzZTaVlEemdIOFBXTm42dStjZlNDS0Y0ZnFBbGhV?=
 =?utf-8?B?UURrT0hrR0lkS280U2lsamR6UVZ4TGFHeWgzUi91TTZ4ZEU0Wm1VRnFoREJJ?=
 =?utf-8?B?TlduSGRERXdNTHJsQnl3TTQybkdoMjNzVUlsRk5WRENpYmVYV3FlT3FCdi9S?=
 =?utf-8?B?cHZBT0hrVnpwME1YaEg0K3h5SHlkY2RQNTMxdE91alRSYXBUNnBGWG5Xd0Vi?=
 =?utf-8?B?c1NtSXB1L3AwUEZta0VkR1pwSFhBS3lnQXZOTFNhNDBYVGppVFFPMzZXejBy?=
 =?utf-8?B?QWR5bEIxUXNuUEhSWnRHR0VIUWF6Q3F2T21FYk41dzNlN2hHQ25TblJIYVAv?=
 =?utf-8?B?ZCtGdk1Lc0Fya3RldHA0SW1tenVtY2x0M3k5bnZoejlkS0UzTDlnb0RvUG1X?=
 =?utf-8?B?aSt1L1RwRndCSmt3allIU3NiVkFsMVh0M203cjBuUk9VKzE2Z2s1Nzl5Smxl?=
 =?utf-8?B?d1JiYWZlWDloVEtGZXNyWUtXdGF2SVI5YTRlSERLdktsQlJFMStoTmxpWUNX?=
 =?utf-8?B?Y1MxWXZLb0RzcG8wcVd1UTk1dWhlZDFLU3JEbzc3Z1p3RlhMZWcvYzhtKzZI?=
 =?utf-8?B?dzF2Znlic1FEOWxza0hZMTFyZnluTjhBREJGVHNOdStzOG01ZGhMYi9vdDFG?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF26122DA363464298248BC197D9A833@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb17aa7-ec6f-45a4-391f-08db8e459b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 02:03:01.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kS1T8/UwxBQcIcnaBnhWIwglp/OmP72gU/3Oljh2bgtNlQogxBsTzzjZzBQHg1+5arA3D0pU3xdb8ZLg5Hd5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6195
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTI2IGF0IDEzOjU0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCg0KLi5zbmlwLi4NCg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBAQCAt
MzA2LDYgKzMxMiwxOCBAQCBzdGF0aWMgaW50DQo+ID4gPiA+ID4gPiBtdDgxODhfbXQ2MzU5X210
a2FpZl9jYWxpYnJhdGlvbihzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZQ0KPiA+ID4gPiA+ID4g
KnJ0ZCkNCj4gPiA+ID4gPiA+ICAgICAJCXJldHVybiAwOw0KPiA+ID4gPiA+ID4gICAgIAl9DQo+
ID4gPiA+ID4gPiAgICAgDQo+ID4gPiA+ID4gPiArCWZvcl9lYWNoX2NhcmRfd2lkZ2V0cyhydGQt
PmNhcmQsIHcpIHsNCj4gPiA+ID4gPiA+ICsJCWlmICghc3RyY21wKHctPm5hbWUsICJNVEtBSUZf
UElOIikpIHsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBpZiAoc3RybmNtcCh3LT5uYW1lLCAiTVRL
QUlGX1BJTiIsIHN0cmxlbih3LT5uYW1lKSA9PSAwKSB7DQo+ID4gPiA+ID4gCXBpbl93ID0gdzsN
Cj4gPiA+ID4gPiAJYnJlYWs7DQo+ID4gPiA+ID4gfQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRo
YXQncyBzYWZlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IElmIHctPm5hbWUgaXMg
TVRLQUlGLCB0aGUgc3RybmNtcCBleHByZXNzaW9uIHdpbGwgcmV0dXJuIDAuDQo+ID4gPiA+IEhv
d2V2ZXIsDQo+ID4gPiA+IHRoZSByZXN1bHQgaXMgbm90IGV4cGVjdGVkLiBJIHByZWZlciB0byBr
ZWVwIHN0cmNtcCBoZXJlLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gWW91IGNvdWxkIGFsc28g
ZG8sIGluc3RlYWQNCj4gPiA+IA0KPiA+ID4gaWYgKHN0cm5jbXAody0+bmFtZSwgIk1US0FJRl9Q
SU4iLCBzdHJsZW4oIk1US0FJRl9QSU4iKSA9PSAwKSkNCj4gPiA+IA0KPiA+ID4gLi4uc29sdmlu
ZyB5b3VyIGNvbmNlcm4uDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+ICBGcm9tIG15IHVuZGVy
c3RhbmRpbmcsIHN0cm5jbXAgaXMgdXRpbGl6ZWQgdG8gZGV0ZXJtaW5lIGEgc3RyaW5nDQo+ID4g
YmVnaW5zDQo+ID4gd2l0aCBhIHBhcnRpY3VsYXIgcHJlZml4IHdoaWxlIHN0cmNtcCBpcyB1c2Vk
IHRvIGNvbXBhcmUgYSB3aG9sZQ0KPiA+IHN0cmluZy4gSW4gdGhpcyBzY2VuYXJpbywgSSB3aXNo
IHRvIHZlcmlmeSBpZiB0aGUgd2lkZ2V0IG5hbWUgaXMNCj4gPiBleGFjdGx5ICdNVEtBSUZfUElO
Jywgc28gSSBiZWxpZXZlIHVzaW5nIHN0cmNtcCB3b3VsZCBiZSBtb3JlDQo+ID4gYXBwcm9wcmlh
dGUuDQo+ID4gDQo+ID4gVXNpbmcgZWl0aGVyIHN0cmxlbih3LT5uYW1lKSBvciBzdHJsZW4oIk1U
S0FJRl9QSU4iKSBtYXkgbGVhZCB0bw0KPiA+IGluY29ycmVjdCByZXN1bHRzIHdoZW4gdy0+bmFt
ZSBpcyBlaXRoZXIgTVRLQUlGIG9yIE1US0FJRl9QSU4xLg0KPiA+IA0KPiA+IFRoYW5rcywNCj4g
PiBUcmV2b3INCj4gDQo+IHN0cmNtcCgpIGFuZCBzdHJuY21wKCkgYXJlIHRoZSBzYW1lOyBleGNl
cHQgc3RybmNtcCgpIGNvbXBhcmVzICphdA0KPiBtb3N0KiBgbmAgYnl0ZXMsDQo+IHdoZXJlIGBu
YCBpcyBteSBgc3RybGVuKCJNVEtBSUZfUElOIilgLg0KPiANCj4gIEZyb20gTGludXggbWFuIHBh
Z2VzLi4uLg0KPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5tYW43
Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuMy9zdHJjbXAuMy5odG1sX187ISFDVFJOS0E5d01nMEFS
Ynchbi1YLWNrYmtWWXY0Y2JyaHB3YjJmN05INnNRa3h4MWN6bUNVMi1xNUJ0U09oUVUwQzY4d2o5
Sk5jdTQ3WWZiWWVUcFZFempZUVZYR3VRYjV1bHBlV3dLam5WTWRacGckwqANCj4gIA0KPiANCj4g
DQoNCkhpIEFuZ2VsbywNCg0KTXkgY29uY2VybiBpcyB0aGF0IHN0cm5jbXAoKSBjb21wYXJlcyBh
dCBtb3N0IGBuYCBieXRlcywgd2hlcmUgYG5gIGlzDQp0aGUgbGVuZ3RoIG9mIHRoZSBzdHJpbmcg
J01US0FJRl9QSU4nLiBGb3IgaW5zdGFuY2UsIGlmIGJvdGgNCidNVEtBSUZfUElOJyBhbmQgJ01U
S0FJRl9QSU5NVVgnIGV4aXN0IGluIHRoZSB3aWRnZXQgbGlzdCwgdGhleSB3aWxsDQpib3RoIGVu
dGVyIGV4ZWN1dGVfc29tZXRoaW5nKCkgZnVuY3Rpb24gYmVsb3cgd2hlbiBleGVjdXRpbmcgdGhp
cyBjb2RlOg0KIA0KaWYgKHN0cm5jbXAody0+bmFtZSwgIk1US0FJRl9QSU4iLCBzdHJsZW4oIk1U
S0FJRl9QSU4iKSkgPT0gMCkgeyAJDQogZXhlY3V0ZV9zb21ldGhpbmcoKTsgDQp9LiANCg0KVGhp
cyBpcyBub3QgbXkgZXhwZWN0ZWQgc2NlbmFyaW8uIFRvIHByZXZlbnQgdGhpcyBwcm9ibGVtLCB3
ZSBjYW4gdXNlDQpzdHJjbXAoKSBpbnN0ZWFkIG9mIHN0cm5jbXAoKS4gc3RyY21wKCkgY29tcGFy
ZXMgdHdvIHN0cmluZ3MgdW50aWwgaXQNCmZpbmRzIGEgZGlmZmVyZW5jZSBvciByZWFjaGVzIHRo
ZSBlbmQgb2Ygb25lIG9mIHRoZW0uIFRoZXJlZm9yZSwgaXQNCndpbGwgY29tcGFyZSB0aGUgZW50
aXJlIHN0cmluZyAnTVRLQUlGX1BJTicgd2l0aCB3LT5uYW1lIGFuZCBtYWtlIHN1cmUNCnRoYXQg
b25seSBkbyBleGVjdXRlX3NvbWV0aGluZygpIHdoZW4gdy0+bmFtZXMgaXMgdGhlIHNhbWUgYXMN
CidNVEtBSUZfUElOJy4NCg0KVGhhbmtzLA0KVHJldm9yDQoNCg==
