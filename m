Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E67D646B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjJYID6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjJYIDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:03:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967143854
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:38:48 -0700 (PDT)
X-UUID: 736c357e730911eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZOk9xvLNdkEhSM52pBk2N9v4a+7ipDifb4tia8LxTqM=;
        b=eksKWMHA836B0bM8rT6bqsXNQuUeOKbLCkqTYk9QM8Z6ysUVDeiziHJMWnLEWDa2zIMRUtVDVxmA43HKKWmpiFKwTH9HoiHYIIQsueczCotUkGg5F8ODv7wcJeFFQlBEW3dbhO2kpu4so/+j32uQw48nKT+yuKp4EBbk4lOsHgQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ea56850e-c348-4b21-84c9-7d307cdce5a8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:99f14bd7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 736c357e730911eea33bb35ae8d461a2-20231025
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 62147893; Wed, 25 Oct 2023 15:38:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 15:38:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 15:38:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSdDgPx1+jwKaPQrqxAEeNNHy7NnfMRRVp/DvJp3TyLUzOkSCZkvlsN1MTRQ86wocIt6PtV9SoQfQ0LHHo1d/2+7UXUoiP03KdSAmsNdwyyS9IYsDAGK9wISI0QgWbVZ2HwafdwuAiKHAWFMmu79AF9onKEol916cvVwAFog7YAD8Pya1KyIn3G93ZetJXaTQEX0GGDi0tJMZ2BwLBrJ7wbE0OCaSatp+KBj8L/yvKoYB446FX7Dy/CCTbh8bj5TWWFtyYgHSjZOIsleSN9r0gSKX8aqV0gKfv+rBgUxyWIma6QuPpsmRYyWVO3BfUsJLX9EKND7Cxjm/nR0WuEjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOk9xvLNdkEhSM52pBk2N9v4a+7ipDifb4tia8LxTqM=;
 b=bnmUSMl0IwIQGjwcFNWDlnI2a6wlR5vIOGBoup6I9kVirvsr/7+vnkLt5f45JRv2WSMo9WmAwYc3+he5sLntGziHNZ0TyO0JlxJkNI0AsApsbakWq+XunopPkTi5FHP7MYC7XHsvl8I2EkgYjVWvX7kuLA+TzxwRiF76ps69GBSEjpwLsdeWmOn5jou5rWdthmrBwIXBBE03gLqFqr6N1pEDceqoNgH3bV+Y/NmzYRX35C2uguR4HBdAGC0C/+V8Qv59+QL4oBhqRDQHeNxDS33cG7cjLOLTxIFPV8+/YZFhQp2pEp6HJj3eAzNf1Hb3A23GZB9f5JUfTjPCDCz3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOk9xvLNdkEhSM52pBk2N9v4a+7ipDifb4tia8LxTqM=;
 b=SWgZ+0zve/CxBnSDYB42ktS0MoXz9zEs6Svnu6shnScC1ZDEr3lVkhUm2v9LmMGqQJAmu8UdWZbxiez4veP3CBGMMZA3RSUohdXeySkmTtfDywevDbQvvvTo0PD89/eUCj9BVb1EwORzF6BhlVUSsc7+LlKPg4bn6tIOKqczBro=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7389.apcprd03.prod.outlook.com (2603:1096:820:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:36:08 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 07:36:08 +0000
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
Thread-Index: AQHaBYUzQpra4sLuvU2qkG87EeylgLBaDWSAgAAKLoCAAAk3AA==
Date:   Wed, 25 Oct 2023 07:36:07 +0000
Message-ID: <e7747d50ca81ea636a45d354a8d4128731888964.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-2-jason-jh.lin@mediatek.com>
         <d93ff8f4-984a-4a20-9b81-5c088baf12e8@linaro.org>
         <53d8f44f485cbcd45a1910418dc0049909371682.camel@mediatek.com>
         <1ecf2bb2-6f3e-41e1-b01d-988f0a9f2846@linaro.org>
In-Reply-To: <1ecf2bb2-6f3e-41e1-b01d-988f0a9f2846@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7389:EE_
x-ms-office365-filtering-correlation-id: 0b66949a-9d3c-4d35-4e0e-08dbd52d0d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFx6B/Kl39q5XNSayF67R64PHijmExlqSXa2UokxH0Ek0IHPqeVqKdASzod+Pfh1BlObHoSne5IcgnKHPPqy4I4Tg0nanouxZxD9tR3acdGnz0YSQ1Fz6gnIgJmQ5erLmIzEyBLPUDazoc7ixYJAyuiXC2g9zIUuMptpBPjEcduERY9prSE33t+iNc/9p2W0GBRps+EHvDsIs6Y8OH1bJOqwQaVn1JHTWgZ7oA8QcsG0GDp/xNYpZmINd6kVlAD5NC5r+1ZmjHyKoB9V2FvMYl8RMc0QEclamKCf+BNVLaX0uoPfeVaJP50Ggg2GnKa8N+EEbQhtnXfaGihXVHscBdwzGGGbhpkeX/tMYP5x8KGq5qUxv2JS3SqFAxePkVbFfB9Qodq+0sJt+h0hO5HyijjZ06NVBu2tKbvs/92iIWLlzeJkAOwAQ/yr1xP57A+Mk2nwE3wUOwMzeBXPAc8o9RIJjpyIZBnxUAOh1adVW452/OtuhHiQ4F6WyrgTUXE3NxH+c0bKAS6P89xlh2hfHGfLk7ueL33sbPNk5W83rFr5YGStsP4obplgK2julqV+OSh8pV5E6Co49nhXnrNVb+SdDCRMvxHEvy7jTNT6QKeLyhiAMw/K3dWQcmaOw8SZNVZn4qwhMuH0Cp2JkfEl5DJ+2dAttImQo9kDVgKczQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(38070700009)(4001150100001)(38100700002)(2906002)(41300700001)(86362001)(5660300002)(36756003)(85182001)(8936002)(8676002)(4326008)(7416002)(54906003)(71200400001)(64756008)(6506007)(478600001)(76116006)(110136005)(122000001)(91956017)(66946007)(66556008)(316002)(66446008)(66476007)(6486002)(83380400001)(6512007)(53546011)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z242djdxd2NVVzQzTlphUDZIcmtVQnJCaS9jQUtwbE5wcVdXR1lkbzN4M0to?=
 =?utf-8?B?dmd3QWVmL0FEOU0velR5VkdHUG1FVm1RM0h2OWpTYkhnSFZPLzlKMkJEUTdE?=
 =?utf-8?B?WVo3djJiYy9zNDB3RnBOdytUbjFiYWFvOWpnL0ZTd1kwMlhSYmtqOXo3cUpP?=
 =?utf-8?B?QzNSQjNIWWxaMFJmRVFoYnN4ZVR4dkFHVmFnOG52dUhqS1pFUXh0STRDVlpT?=
 =?utf-8?B?UHpTWnAzc3MyVFpHb0pmZWNRQTFGSFd5RnNVUmhFeWtkRHJnaVYxeDBvS0FM?=
 =?utf-8?B?K3M0Mm5UL3FVWWhwcHZyc0Vkd0R4VkdXWDlOblE5TEQzN0x6NHUzMmpOZXBl?=
 =?utf-8?B?M28vdFZZZmhESzQwaThwR09GU0VIU2dkb0haTmo2SGhDc1pmVkkweThXS1Bu?=
 =?utf-8?B?QUJ0b05uTVBxc2hqWnFVMW11MGhxUXBsRFZITEczaUhtTnZpbFp3dGx2eFR1?=
 =?utf-8?B?aTVuUGREVUhLeGs0QTFvMWFZVzM0anJVVWhyMSs2MGpvUWErRFpOdlozZHB0?=
 =?utf-8?B?Y08zY29KUTRTTkZxUmZRRXFuQk01MFhuQ0lBM1FSM0p1WGpXcEVrektQVndl?=
 =?utf-8?B?enhKOUZEcm41VzdmY21zM3hLaDhISkUxcHBueG91VUxvekQ4dndSYUxRbW04?=
 =?utf-8?B?WUQrMHVqQVliVUZIc3h5QnE2blRmaElRSitIT3YxdDBtWklJK3owTmNncDho?=
 =?utf-8?B?MTlKRFZ2aGlwNEVGRWZvenFkYU5LaWI3NXNWQWdnYS9BalpTSDdiT2dnTldt?=
 =?utf-8?B?Zk1sTE5xTkFoOU1KY1BZaUpoT3c3VEpXT2dsTFk1V0pzeFJWS1FXTTRQYnhq?=
 =?utf-8?B?dkg0T2taZ2c4WktlY1h2MWI0MmlZeVlFRjJKd1Arbi9nZHJEUFd0a3c2ZktL?=
 =?utf-8?B?WE94dDNtd0tWVVhMM2IxSExHWkRxOGdjaGtJWjJKY2NlTXVXdzI1M0Z0KzRk?=
 =?utf-8?B?SVp5dUZaMFVkSUk4YW9aeU1sVGVFU2JQS2xueW9XNG9GdE5QWnZIMUJZaktG?=
 =?utf-8?B?S2hnN3RpZS9ZMWJFK3d3cFZCTGxBellJMmdBaUcvVVQ2cllDMGVxRUFwbTZ2?=
 =?utf-8?B?SFoyZ1RXU0t3cEtudXZ4OFZUc3hMa2tGbTVmSXRXT1VkSVZQTlNmTFgzV2NQ?=
 =?utf-8?B?RjBIZmg1SUNEVmtaOENJa3BuRk9XczhVUURpWVNtN0dieHg4d2xEcFlSc2xV?=
 =?utf-8?B?YjhwdnVQSStKSnNrUkdocGpNR0c0ZU56VUJ2NHpvRzgxbkVudHFQVU4xVUFF?=
 =?utf-8?B?elZLdzFDaWJHWmk4NlMxSjRRM21GVFpNRUpvSVJadk9kQjVaVHF1cndlVFQw?=
 =?utf-8?B?MGlqMUt6Q2VzbTU2M2ZIZndZYUlJNkZ6dkV3eGJLdzhzSkg0M0lzOWd2dDFT?=
 =?utf-8?B?S1ZRWFF2cnFySTNLWEdmVERCenNaREpDQjN2d3ZsRjd6ZnNtZHJUTHlhZTRj?=
 =?utf-8?B?eGZ5V2s4S2dnL1BSMys1VXRwcm4reno5RWRkNjRsa3BvWmJPdENBVHBuZmlW?=
 =?utf-8?B?Ly9Jdk13M3A2bDE1UHNpc25WZENrb244ZnhWTVllekFYRkpCa2lQZEpOcVBV?=
 =?utf-8?B?dVNYWHVQVUdyNnV3QzhQa25zZEJnbmVGSlo4Wnk0M1dSUDFDdXFvYklwSGty?=
 =?utf-8?B?eW5jL2M4VXEzV1hTS0JkTmdiN0ZKdlg3VXc1UlNOd1JhNTFtc2RvU2NXdXZ4?=
 =?utf-8?B?dkY2d3VDZW9yV2VHOFdiakFtVEhqM1N3T1U2U2ROTjhud2xWVS8xQ3FyRnF5?=
 =?utf-8?B?Q1ZRQytiNUJ2aENsZDlVd2hNQWZ0SCtCODdONStUaFIybFhvenJJaDJQSCtK?=
 =?utf-8?B?eEFGeDBsdmNpY3poYzZ4VGEyRzhRbU9VUFVJclVoR2FMSEZnelVLdjBrWFA3?=
 =?utf-8?B?TTBZNmdvVEsxZVRkb0ROaGFrNXFOMnN1UkU5TlRteld1ZWNXK2x2NTNrV0lk?=
 =?utf-8?B?L0hrWGpCakg0dG5paDVtdFdjeHhaR1NQZUVqUkVSSlhET3EyRmF1RExCNHdX?=
 =?utf-8?B?ZUFlYklPRFJKS1k0Z1BWZWx3WWk1SGFUQ1JRSEYzQzJUaWNqenFNU01NeVo0?=
 =?utf-8?B?TDlPUXJNZjBlem55cWxjWG5IRGtKTXQwVC91dzIyL0dpWHVaN05kclU1VXB1?=
 =?utf-8?B?NkRBb044WDByNXlRdjZaMUVGTE1PVDVjaTFlS2RHeWlLOWhVS0o5ZjlxWUZW?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E362CE9F10C3104BB5686B7BF30643C9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b66949a-9d3c-4d35-4e0e-08dbd52d0d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 07:36:07.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMWSEjY5kwpMEfq+f0OQYgQ/o4+P/QoPU0raS0NhWvaW9B2GXHJXn7dHEtMZHwGzTdKmxMHs+c98QlTseBRx2lja0s2D1i2Foy7/LYgmxtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7389
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.586800-8.000000
X-TMASE-MatchedRID: 8+bhjh9TQnEOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
        qIY+/skQkABPgKBt/0rbaVyalxbpdBgZ7Tcj60QbaNnyr85zWcAZmNqpqQL8xtSVUkz9BPXexhL
        t/2rTcUnLPjVydrOOXnfm2qkN6lKnZPJiiebq1E9CCMcA2lOZq0Crr/LkAQ46o0y/q6CYk4Jm+j
        6YVbX2YHdvCV/NEMY7XEHGVOkRwUrau9iF5mAFe7MjW/sniEQKjI6qXkf2FQ1jPrlNB+gMqzg8t
        PCpA9Rvilo5L1ykPxMuNg7WvdFakNYfe9ARablSydRP56yRRA/cVi8qZmJWc4KwF4K/wIz9wtU3
        Gd/uR9Xi8zVgXoAltj2Xsf5MVCB1t7DW3B48kkHdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.586800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9157DC1976FD116E797B543775322CFE18C71224E41D6B1733E73502F408F3012000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDA5OjAzICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI1LzEwLzIwMjMgMDg6MjYsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YsDQo+ID4gDQo+ID4gVGhhbmtzIGZv
ciB0aGUgcmV2aWV3cy4NCj4gPiANCj4gPiBPbiBNb24sIDIwMjMtMTAtMjMgYXQgMDk6NDcgKzAy
MDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+ICAgDQo+ID4+IEV4dGVybmFsIGVt
YWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+IHVu
dGlsDQo+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
ID4+ICBPbiAyMy8xMC8yMDIzIDA2OjM3LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4+PiBDTURR
X1NZTkNfVE9LRU5fU0VDVVJFX1RIUl9FT0YgaXMgdXNlZCBhcyBzZWN1cmUgaXJxIHRvIG5vdGlm
eQ0KPiBDTURRDQo+ID4+PiBkcml2ZXIgaW4gdGhlIG5vcm1hbCB3b3JsZCB0aGF0IEdDRSBzZWN1
cmUgdGhyZWFkIGhhcyBjb21wbGV0ZWQgYQ0KPiA+PiB0YXNrDQo+ID4+PiBpbiB0aGVlIHNlY3Vy
ZSB3b3JsZC4NCj4gPj4NCj4gPj4gcy90aGVlL3RoZS8NCj4gPj4NCj4gPj4+DQo+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4+
PiAtLS0NCj4gPj4NCj4gPj4gVGhpcyBpcyBhIG5ldyBwYXRjaCwgc28geW91IG11c3QgbWVudGlv
biBpdCBpbiB0aGUgY2hhbmdlbG9nLg0KPiBUaGVyZQ0KPiA+PiBpcw0KPiA+PiBub3RoaW5nIGlu
IHRoZSBjaGFuZ2Vsb2cgc2F5aW5nIGFib3V0IHRoaXMgbmV3IHBhdGNoLg0KPiA+Pg0KPiA+Pg0K
PiA+Pj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlL210ODE5NS1nY2UuaCB8IDYgKysrKysrDQo+
ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2djZS9tdDgxOTUtZ2NlLmggYi9pbmNsdWRlL2R0
LQ0KPiA+PiBiaW5kaW5ncy9nY2UvbXQ4MTk1LWdjZS5oDQo+ID4+PiBpbmRleCBkY2ZiMzAyYjhh
NWIuLjlmOTlkYTMzNjNiOSAxMDA2NDQNCj4gPj4+IC0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3Mv
Z2NlL210ODE5NS1nY2UuaA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ4
MTk1LWdjZS5oDQo+ID4+PiBAQCAtODA5LDQgKzgwOSwxMCBAQA0KPiA+Pj4gIC8qIGVuZCBvZiBo
dyBldmVudCAqLw0KPiA+Pj4gICNkZWZpbmUgQ01EUV9NQVhfSFdfRVZFTlQxMDE5DQo+ID4+PiAg
DQo+ID4+PiArLyoNCj4gPj4+ICsgKiBOb3RpZnkgbm9ybWFsIENNRFEgdGhlcmUgYXJlIHNvbWUg
c2VjdXJlIHRhc2sgZG9uZSwNCj4gPj4+ICsgKiB0aGlzIHRva2VuIHN5bmMgd2l0aCBzZWN1cmUg
d29ybGQuDQo+ID4+PiArICovDQo+ID4+PiArI2RlZmluZSBDTURRX1NZTkNfVE9LRU5fU0VDVVJF
X1RIUl9FT0Y5ODANCj4gPj4NCj4gPj4gV2h5IGlzIHRoaXMgYmVsb3cgMTAxOT8gWW91ciBkcml2
ZXIgY2FsbHMgaXQgYWxzbyBldmVuLCBzbyBpcyB0aGlzDQo+IGFuDQo+ID4+IGV2ZW50IG9yIG5v
dD8NCj4gPj4NCj4gPj4gWW91ciBkcml2ZXIgZG9lcyBub3QgdXNlIHRoaXMgdmFsdWUsIHNvIGRv
ZXMgaXQgbWVhbiBGVyB1c2VzIGl0Pw0KPiA+IA0KPiA+IEkganVzdCB3YW50IHRvIHNlcGFyYXRl
IHRoaXMga2luZCBvZiBldmVudCAoc3cgdG9rZW4pIGZyb20gdGhlIEhXDQo+ID4gZXZlbnQuIFNv
IEkgZGVmaW5lIGl0IGFmdGVyIENNRFFfTUFYX0hXX0VWRU5ULg0KPiANCj4gU1cgZXZlbnQ/IFRo
ZW4gd2h5IGlzIGl0IGluIHRoZSBiaW5kaW5ncz8NCj4gDQoNClNvcnJ5LCBJIGRpZG4ndCBleHBs
YWluIGl0IGNsZWFybHkuDQoNClRoZXJlIGFyZSAyIGtpbmQgb2YgR0NFIGV2ZW50IHNpZ25hbDoN
Ci0gVGhlIFNXIHRva2VuIG1lYW5zOiBhIEdDRSBIVyBldmVudCBzaWduYWwgdHJpZ2dlcmVkIGJ5
IFNXIGRyaXZlcnMuDQplLmcuIFNXIGRyaXZlciBhcHBlbmQgYSBHQ0UgY21kIHRvIHNldCBhIEdD
RSBIVyBldmVudCBhZnRlciBhIHNwZWNpZmljDQpHQ0UgY21kLiBPciBTVyBkcml2ZXIgdXNlIENQ
VSB0byB3cml0ZSBhIGV2ZW50IGlkIHRvIEdDRSByZWdpc3RlciB0bw0KdHJpZ2dlciB0aGUgR0NF
IEhXIGV2ZW50IGNvcnJlc3BvbmRpbmcgdG8gdGhhdCBldmVudCBpZC4NCg0KLSBUaGUgSFcgZXZl
bnQgbWVhbnM6IGEgR0NFIEhXIGV2ZW50IHNpZ25hbCB0cmlnZ2VyZWQgYnkgSFcgZW5naW5lcy4N
CmUuZy4gV2hlbiBIVyBPVkwgZmV0Y2hlcyBhbGwgdGhlIGRhdGEgaW4gZnJhbWUgYnVmZmVyLCBI
VyBPVkwgd2lsbCBzZW5kDQphIGZyYW1lIGRvbmUgaXJxIGFuZCBhIGZyYW1lIGRvbmUgR0NFIEhX
IGV2ZW50KHZpYSBIVyBidXMgZGlyZWN0bHkpIGluDQp0aGUgc2FtZSB0aW1lLg0KDQpSZWdhcmRz
LA0KSmFzb24tSkguTGluDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo+IA0K
