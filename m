Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4777B1288
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjI1GR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjI1GRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:17:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3085B99;
        Wed, 27 Sep 2023 23:17:47 -0700 (PDT)
X-UUID: bb32bca05dc611ee8051498923ad61e6-20230928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6E2iJ+7L+GPE3mSI0eyLGr2AH4mg5ow+XSVRKgwnkNE=;
        b=gmWl9Clcpnlxb3bm1FdhfBvwYze5ykKgnW7Jkk2YnSoilqU8L83I0jhIWbdpCX7DlBbhDWP02/YKNGu//1vk6ilJLaBy+8eVTD1Bbvr4ksr74tudlkdPd3JX7oPx7PtMWdG8QASvFkF54Xxos2ZbTfnTQ0qMCuu/Ksf4rgq3/r0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3cbf10d3-03ee-4aaf-9c2a-eadf2d5a95b3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:19395ebf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: bb32bca05dc611ee8051498923ad61e6-20230928
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1144242582; Thu, 28 Sep 2023 14:17:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Sep 2023 14:17:40 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Sep 2023 14:17:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlQLBnZj9m52yV2lMpd+nI7p/40TIYPJ5cFeFplz5TDv4C5JeEpNT0QNQS33NrI8e/xF4s+qIyz9BW2fx8HGPlGfcR0vcU1XClDwlPBFIsjnqFEeIxHEStURvDm6AUm9P9zShhI+ZzetcO9VXGfXmrB92wa+GhI2atRX+LBDi+wuHn7k89HN8JHqIv4/VuijuaQL400aGaputyGfgbdk2p+/cM3kR5ka4sIj//psou2CIFSgfYoZbZXus/k/iLmfj/rHwRIyJUrSn1w7dNbnc77PunOLRF32xrlu7GAeiQ1UAyzR5kgZiRZJe65OxQUTofB0x9G5mxjuvvTlonKpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E2iJ+7L+GPE3mSI0eyLGr2AH4mg5ow+XSVRKgwnkNE=;
 b=FDe6AwLNrU92cyTIb3h6L/3ntSGQakwnnmp1Xa0FcMaeo3lHt07wwE8ufcDF4nmjQgd/PZe/R4GV1d3faN+XBtJIrVvss5/mMau8K/pghsfOKGCZEOmKvgVjiUrt215wP8fLKVSyFToTECqkNprmT9NLG7Zx1cpjSV9GxIjaAIaWRZTaafRXVYxKgyYWaroPTD7etORZVLLVLJSeoJcUeNQAgPZs4pUOZKyR7ri6sMEeltTHngnn4U9/UGdK1F7WZuGFkcqd1O7hsHa9DxANBr3zhKdiMQFKPnb5AftbodQoZNFP+6dIipAmU/EcGS1QLmC9UYqLaMJm2jvcDxX/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E2iJ+7L+GPE3mSI0eyLGr2AH4mg5ow+XSVRKgwnkNE=;
 b=bU9jpep0/CP1/w2NzL8f2vYdKwlEdGdWfNtrCkQeACSf5iRdy5TNSoV2BGZifKn+7q+5xeSEpQda+ktJSk57qsMVj1na5pEsfrCXwkONMbPoqp11p6JjFfB0pwUwmg04VvbVbKaPYWZQkHpPgbt6RWr7c3N1g95HsMCT1s6HAME=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6469.apcprd03.prod.outlook.com (2603:1096:400:1cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 06:17:39 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Thu, 28 Sep 2023
 06:17:38 +0000
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND PATCH v6 18/20] drm/mediatek: Add Padding to OVL adaptor
Thread-Topic: [RESEND PATCH v6 18/20] drm/mediatek: Add Padding to OVL adaptor
Thread-Index: AQHZ5IOuUIixMWVJzEmUcBfn3Npp5LAv3eyA
Date:   Thu, 28 Sep 2023 06:17:38 +0000
Message-ID: <0440120a83f6e5c7f99c0627e3e149f75c01f975.camel@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
         <20230911074233.31556-19-shawn.sung@mediatek.com>
In-Reply-To: <20230911074233.31556-19-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6469:EE_
x-ms-office365-filtering-correlation-id: 65b0d238-44d6-4960-2630-08dbbfea9d6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZN8k9s9nkLJDNifAS0NXectK2gCsqCyqZg7xbOO7J5rU9T0nzoj1ZwD+hwEU7syGao/4J1F9DN9TqY4yIWin9HYPj4Xf+2y+wm0ls+2sL/bMm9fydVtfiNzETZK/tZsShlc2oh9SyWGAExhinpu5PRWt5f/LErRbRxYAL8RWOtPdXdJ7QCJvoY/fhWw9Riiicdd5d3f4/sILDpKkKbIZwisp6nt0XL56VVIS3weNSOYHPT78AJfS4V+/DJTXaQ/E3caxLfiCg9gn17aXvd73IxGhc8ZqW6kk/TkXuuVvW1cYkkV1ICF1aI0hc7Ew6tO6geaZKDaeeOHyBgmrwYjIF7CyD2yMZW2ZgOM2L2Rqy3jQZzDAi28wdJexRdQIfiB7UaITd6O3P/KnV/u7wvjSw+OCjZeRLXkVZa/qwUss3LRrjIXOPQbHWaw5u4V0c0zUUf5hKHYgS3+8iwrSLHBFYXklxOIKWukZzfM0XALJdr786fPjwfV4weLYRFJIk7X8hKmtM7lqb6L6p3x24ieIJD1cmN0GVI/DFOknP7VZgjfAwfff7EqjcP3XFU8l/RiV2RdvFtuigCBsTJkvYkJ8MwXF3omJ5IShsRjRr+gYk2ulbw9CDlqD1MRqtXQYRW64EQNLlyHy2f7kR2e+VeGvEiJKt4QqXvqL4dctav4QEw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(26005)(6512007)(38100700002)(86362001)(38070700005)(122000001)(36756003)(85182001)(6506007)(76116006)(110136005)(66946007)(7416002)(4326008)(2906002)(66476007)(41300700001)(8676002)(66556008)(66446008)(54906003)(64756008)(8936002)(316002)(5660300002)(71200400001)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEU2RkMraVdpL3FLMklNZzNkeEM2dGRDcHA5TjRsME9lUTZuRGorT25FaS9M?=
 =?utf-8?B?MzgvTks5bnB4aXdmRDVmTXI4anZWcStYaEVTTnFWRlZjRDNpOFYwUyszN3pI?=
 =?utf-8?B?SUVza1prMXhEUkhYdnF5Tm9sZEw2SUtFYjhwMVVPc2hycEZtMzNZUTQySklu?=
 =?utf-8?B?U2dvRDlCcC9pZklpTmZWWmJTTVF6RzZnYVRYeEFlV01BQnkzcklRZXF2NUFm?=
 =?utf-8?B?amgrL2xMcHJCWXZ0ay9MQUtJajlqaE9rNG5NZnRBZjBOUG5qeitQdjVERGx2?=
 =?utf-8?B?Nk4ybU5URmoydWkyNjBET0dJMTg2VWVaOUxCTCt6TDdFOGcwZHZJR0h4cGdX?=
 =?utf-8?B?bnBrOUdzTkhJMVdTVkpHY05lWVlRaEVrSFBlRWhoVkFtdEhtMitVU1JMdy81?=
 =?utf-8?B?dXU4QlZJeGZvaTRFL1hsbU52RzlZNzNnM2RDV0VuMmJhVlJqK3JhNGRldzZp?=
 =?utf-8?B?WExQUTQ3b3RtQmo0eVhKSWhTb2FDZHRWc01NOEl5TXRncW1iVmNMR0MzeVJ6?=
 =?utf-8?B?K2w5RlVzaEovV1RGdjlCNXlCYzBmTFo1VjQ1QmxoM25MenA0b213Nyt1V25F?=
 =?utf-8?B?WS9RcUY3MUdpNWc1bWd4UjBoS1VrVzRIUnltSkpJUU5nQ2pJVlpLRmEzdjkw?=
 =?utf-8?B?akJ3dzBTemhkYkRWL2FPak1ScGdzQ1VieVpPSVVQZzdBSDg2MXE1VEkveFU0?=
 =?utf-8?B?WkRnQVNIUCtvdVVpa2pkYStTZ2YvS0I0ZCtDTFlEWVlaZ2lpS1J0VC8zTnZm?=
 =?utf-8?B?N0Frc3ltSEFmVU5GYkFsS2lhQUdSR0JTdGc5WVBXK2p6ZkhMMDNaUWtxN3A0?=
 =?utf-8?B?VGdaUmNVM1ZZZnRHZXdZeE5DUGtLVE1jL0JXemV0cCs1bHpXTXRVVDBnRmxL?=
 =?utf-8?B?ang5VU4xOEJOTW5LWC9IOXhtSTdUWDc0ZlFvdHQwcXV5VVVJS0pCaEFoNy9R?=
 =?utf-8?B?bE56NlIxTWJMWXFvMDhsTDNTcmFjbzNqbHIwWGF1UEpMM3praXBqU1Y1Skl2?=
 =?utf-8?B?R2VQSjd5OGVtcGRGZE15bm1ZKzUwMmdyLzVyNzkyY2ttSEphSG55cG1ab2Jo?=
 =?utf-8?B?bVlINUJRYjJCSG0vWlBEWDhPcmRDaWNhN3pHTnJlY1pTbjRKbC9FTWtYa1Ro?=
 =?utf-8?B?eTJ4M2VSVEt1R1pkMW9rWmdGdkxzNHlBSUJXZE96WTRMWjF5SVltTjljOEtZ?=
 =?utf-8?B?bEVCbnpRSWczQ2c2bmlBcUpLVjNOcHBydk55TjhITUdmUW9jV0g2Ry91cTUv?=
 =?utf-8?B?bTg0Z0NJSTZsQmlQVXhkQTdpSWVEVlQ1UUVCYUFMdDQvbW55dklKN2lja28x?=
 =?utf-8?B?eGVvMHY5VkxlSnkzRnE5eWQxTUZmVXRNMGZBMVd0SFNIMGUvc3NzOG8za0li?=
 =?utf-8?B?RXBBVnNTMWliSzZ4RGNXaGcwR2JVMXV3Q3FEb2hkZlZDNC85WHJsaUFUcnNa?=
 =?utf-8?B?TDBnbldSSzgxUmg2cU0yZjNDVlVxam9kdHlQVkVvRkl3bHhkZno5S0diWXJF?=
 =?utf-8?B?eGdEaHJoWjMwakFjOVhrVDVwdDBkajBjMzJVak4rL052TS9DVERkS1c1bFpR?=
 =?utf-8?B?S2t2N1JkMnNSVkl0SXU1eWRJM05nOHVqSkYrZHNzck15bHdXd1M4WC9PRDdj?=
 =?utf-8?B?VGJxTUJ6a3JPemNFeWk5RzlRSDhnOFdZQkZ1dFdLVkxLNE85VmJINU9xNTRV?=
 =?utf-8?B?c3JUdWNLTnd6NmZkcjhGTVIwd1dzVlVpdERmVHE0N3pWSFoxWS9zRTN0ME5G?=
 =?utf-8?B?OUhWZ3BhZUlUekwrT3FUREcxN01lbVVzc0VvbmJ0ZXhCQ3hnM3N5elVoQW5R?=
 =?utf-8?B?NjlkbVVnaFM0RWJaeUxaSWtvTXVNZkc0WjZ6a09MZmliRDFyTEZ0SWlUTFp3?=
 =?utf-8?B?S05UYWh4ZXA3aWorWmt5R01oZHpGSWR1MUdrRE5iTEdkV25MaytWU0hhbTVm?=
 =?utf-8?B?ellTVWQ2eWUxUE5QK3l4c3hzNUxJYjBzbks0NkxsV2gwS0ZPcWxKY0RVRmc3?=
 =?utf-8?B?cFRFY2JEL1ZMSjhWTUMzMk9BVEhaQlNSNURXNktGZ1N6eEFuc2ltMHhYSFcy?=
 =?utf-8?B?Uk9aYVhvTGFXUnlQbnIzRzNZQXN4Tjh5VnBOeDVnMk1BbDZaZmYvOHJNQTNr?=
 =?utf-8?Q?UePbC9wtkQrw/41u93CnqpZGd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49FCCC3C99C1B340BB54C87A031E6F3C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b0d238-44d6-4960-2630-08dbbfea9d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 06:17:38.7157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RN6vomUw1UiS7Gs3NEc3Rk3vgUL7Xtc0frMOVtEBPppRr3aL13AGg9nZ+JOJmKWlYzE2wJIm8HfKXsshA0Dqng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6469
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTEgYXQgMTU6NDIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEFkZCBNVDgxODggUGFkZGluZyB0byBPVkwgYWRhcHRv
ciB0byBwcm9iZSB0aGUgZHJpdmVyLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlh
dGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24u
c3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgLi4uL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsX2FkYXB0b3IuYyAgIHwgMzMNCj4gKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGluZGV4IDg0MTMzMzAzYTZlYy4u
MjE3YzM5YWYyN2JkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBAQCAtMzAsNiArMzAsNyBAQCBlbnVtIG10a19vdmxfYWRh
cHRvcl9jb21wX3R5cGUgew0KPiAgCU9WTF9BREFQVE9SX1RZUEVfRVRIRFIsDQo+ICAJT1ZMX0FE
QVBUT1JfVFlQRV9NRFBfUkRNQSwNCj4gIAlPVkxfQURBUFRPUl9UWVBFX01FUkdFLA0KPiArCU9W
TF9BREFQVE9SX1RZUEVfUEFERElORywNCj4gIAlPVkxfQURBUFRPUl9UWVBFX05VTSwNCj4gIH07
DQo+IA0KPiBAQCAtNDcsNiArNDgsMTQgQEAgZW51bSBtdGtfb3ZsX2FkYXB0b3JfY29tcF9pZCB7
DQo+ICAJT1ZMX0FEQVBUT1JfTUVSR0UxLA0KPiAgCU9WTF9BREFQVE9SX01FUkdFMiwNCj4gIAlP
VkxfQURBUFRPUl9NRVJHRTMsDQo+ICsJT1ZMX0FEQVBUT1JfUEFERElORzAsDQo+ICsJT1ZMX0FE
QVBUT1JfUEFERElORzEsDQo+ICsJT1ZMX0FEQVBUT1JfUEFERElORzIsDQo+ICsJT1ZMX0FEQVBU
T1JfUEFERElORzMsDQo+ICsJT1ZMX0FEQVBUT1JfUEFERElORzQsDQo+ICsJT1ZMX0FEQVBUT1Jf
UEFERElORzUsDQo+ICsJT1ZMX0FEQVBUT1JfUEFERElORzYsDQo+ICsJT1ZMX0FEQVBUT1JfUEFE
RElORzcsDQo+ICAJT1ZMX0FEQVBUT1JfSURfTUFYDQo+ICB9Ow0KPiANCj4gQEAgLTY3LDYgKzc2
LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdA0KPiBwcml2YXRlX2NvbXBfc3RlbVtPVkxf
QURBUFRPUl9UWVBFX05VTV0gPSB7DQo+ICAJW09WTF9BREFQVE9SX1RZUEVfRVRIRFJdCT0gImV0
aGRyIiwNCj4gIAlbT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQV0JPSAidmRvMS1yZG1hIiwNCj4g
IAlbT1ZMX0FEQVBUT1JfVFlQRV9NRVJHRV0JPSAibWVyZ2UiLA0KPiArCVtPVkxfQURBUFRPUl9U
WVBFX1BBRERJTkddCT0gInBhZGRpbmciLA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG10a19kZHBfY29tcF9mdW5jcyBfZXRoZHIgPSB7DQo+IEBAIC03OSw2ICs4OSwxMSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBfbWVyZ2UgPSB7DQo+ICAJLmNs
a19kaXNhYmxlID0gbXRrX21lcmdlX2Nsa19kaXNhYmxlLA0KPiAgfTsNCj4gDQo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBfcGFkZGluZyA9IHsNCj4gKwkuY2xrX2Vu
YWJsZSA9IG10a19wYWRkaW5nX2Nsa19lbmFibGUsDQo+ICsJLmNsa19kaXNhYmxlID0gbXRrX3Bh
ZGRpbmdfY2xrX2Rpc2FibGUsDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kZHBfY29tcF9mdW5jcyBfcmRtYSA9IHsNCj4gIAkuY2xrX2VuYWJsZSA9IG10a19tZHBfcmRt
YV9jbGtfZW5hYmxlLA0KPiAgCS5jbGtfZGlzYWJsZSA9IG10a19tZHBfcmRtYV9jbGtfZGlzYWJs
ZSwNCj4gQEAgLTk4LDYgKzExMywxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG92bF9hZGFwdG9y
X2NvbXBfbWF0Y2gNCj4gY29tcF9tYXRjaGVzW09WTF9BREFQVE9SX0lEX01BWF0gPSB7DQo+ICAJ
W09WTF9BREFQVE9SX01FUkdFMV0gPSB7IE9WTF9BREFQVE9SX1RZUEVfTUVSR0UsDQo+IEREUF9D
T01QT05FTlRfTUVSR0UyLCAyLCAmX21lcmdlIH0sDQo+ICAJW09WTF9BREFQVE9SX01FUkdFMl0g
PSB7IE9WTF9BREFQVE9SX1RZUEVfTUVSR0UsDQo+IEREUF9DT01QT05FTlRfTUVSR0UzLCAzLCAm
X21lcmdlIH0sDQo+ICAJW09WTF9BREFQVE9SX01FUkdFM10gPSB7IE9WTF9BREFQVE9SX1RZUEVf
TUVSR0UsDQo+IEREUF9DT01QT05FTlRfTUVSR0U0LCA0LCAmX21lcmdlIH0sDQo+ICsJW09WTF9B
REFQVE9SX1BBRERJTkcwXSA9IHsgT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HLA0KPiBERFBfQ09N
UE9ORU5UX1BBRERJTkcwLCAwLCAmX3BhZGRpbmcgfSwNCj4gKwlbT1ZMX0FEQVBUT1JfUEFERElO
RzFdID0geyBPVkxfQURBUFRPUl9UWVBFX1BBRERJTkcsDQo+IEREUF9DT01QT05FTlRfUEFERElO
RzEsIDEsICZfcGFkZGluZyB9LA0KPiArCVtPVkxfQURBUFRPUl9QQURESU5HMl0gPSB7IE9WTF9B
REFQVE9SX1RZUEVfUEFERElORywNCj4gRERQX0NPTVBPTkVOVF9QQURESU5HMiwgMiwgJl9wYWRk
aW5nIH0sDQo+ICsJW09WTF9BREFQVE9SX1BBRERJTkczXSA9IHsgT1ZMX0FEQVBUT1JfVFlQRV9Q
QURESU5HLA0KPiBERFBfQ09NUE9ORU5UX1BBRERJTkczLCAzLCAmX3BhZGRpbmcgfSwNCj4gKwlb
T1ZMX0FEQVBUT1JfUEFERElORzRdID0geyBPVkxfQURBUFRPUl9UWVBFX1BBRERJTkcsDQo+IERE
UF9DT01QT05FTlRfUEFERElORzQsIDQsICZfcGFkZGluZyB9LA0KPiArCVtPVkxfQURBUFRPUl9Q
QURESU5HNV0gPSB7IE9WTF9BREFQVE9SX1RZUEVfUEFERElORywNCj4gRERQX0NPTVBPTkVOVF9Q
QURESU5HNSwgNSwgJl9wYWRkaW5nIH0sDQo+ICsJW09WTF9BREFQVE9SX1BBRERJTkc2XSA9IHsg
T1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HLA0KPiBERFBfQ09NUE9ORU5UX1BBRERJTkc2LCA2LCAm
X3BhZGRpbmcgfSwNCj4gKwlbT1ZMX0FEQVBUT1JfUEFERElORzddID0geyBPVkxfQURBUFRPUl9U
WVBFX1BBRERJTkcsDQo+IEREUF9DT01QT05FTlRfUEFERElORzcsIDcsICZfcGFkZGluZyB9LA0K
PiAgfTsNCj4gDQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXllcl9jb25maWcoc3RydWN0IGRl
dmljZSAqZGV2LCB1bnNpZ25lZCBpbnQNCj4gaWR4LA0KPiBAQCAtMTA5LDYgKzEzMiw4IEBAIHZv
aWQgbXRrX292bF9hZGFwdG9yX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYsIHVu
c2lnbmVkIGludCBpZHgsDQo+ICAJc3RydWN0IG10a19tZHBfcmRtYV9jZmcgcmRtYV9jb25maWcg
PSB7MH07DQo+ICAJc3RydWN0IGRldmljZSAqcmRtYV9sOw0KPiAgCXN0cnVjdCBkZXZpY2UgKnJk
bWFfcjsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpwYWRkaW5nX2w7DQo+ICsJc3RydWN0IGRldmljZSAq
cGFkZGluZ19yOw0KPiAgCXN0cnVjdCBkZXZpY2UgKm1lcmdlOw0KPiAgCXN0cnVjdCBkZXZpY2Ug
KmV0aGRyOw0KPiAgCWNvbnN0IHN0cnVjdCBkcm1fZm9ybWF0X2luZm8gKmZtdF9pbmZvID0NCj4g
ZHJtX2Zvcm1hdF9pbmZvKHBlbmRpbmctPmZvcm1hdCk7DQo+IEBAIC0xMjUsNiArMTUwLDggQEAg
dm9pZCBtdGtfb3ZsX2FkYXB0b3JfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwg
dW5zaWduZWQgaW50IGlkeCwNCj4gDQo+ICAJcmRtYV9sID0gb3ZsX2FkYXB0b3ItPm92bF9hZGFw
dG9yX2NvbXBbT1ZMX0FEQVBUT1JfTURQX1JETUEwICsNCj4gMiAqIGlkeF07DQo+ICAJcmRtYV9y
ID0gb3ZsX2FkYXB0b3ItPm92bF9hZGFwdG9yX2NvbXBbT1ZMX0FEQVBUT1JfTURQX1JETUEwICsN
Cj4gMiAqIGlkeCArIDFdOw0KPiArCXBhZGRpbmdfbCA9IG92bF9hZGFwdG9yLT5vdmxfYWRhcHRv
cl9jb21wW09WTF9BREFQVE9SX1BBRERJTkcwDQo+ICsgMiAqIGlkeF07DQo+ICsJcGFkZGluZ19y
ID0gb3ZsX2FkYXB0b3ItPm92bF9hZGFwdG9yX2NvbXBbT1ZMX0FEQVBUT1JfUEFERElORzANCj4g
KyAyICogaWR4ICsgMV07DQo+ICAJbWVyZ2UgPSBvdmxfYWRhcHRvci0+b3ZsX2FkYXB0b3JfY29t
cFtPVkxfQURBUFRPUl9NRVJHRTAgKw0KPiBpZHhdOw0KPiAgCWV0aGRyID0gb3ZsX2FkYXB0b3It
Pm92bF9hZGFwdG9yX2NvbXBbT1ZMX0FEQVBUT1JfRVRIRFIwXTsNCj4gDQo+IEBAIC0xNjAsMTAg
KzE4NywxNSBAQCB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXllcl9jb25maWcoc3RydWN0IGRldmlj
ZQ0KPiAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCXJkbWFfY29uZmlnLmNvbG9yX2VuY29k
aW5nID0gcGVuZGluZy0+Y29sb3JfZW5jb2Rpbmc7DQo+ICAJbXRrX21kcF9yZG1hX2NvbmZpZyhy
ZG1hX2wsICZyZG1hX2NvbmZpZywgY21kcV9wa3QpOw0KPiANCj4gKwlpZiAocGFkZGluZ19sKQ0K
PiArCQltdGtfcGFkZGluZ19jb25maWcocGFkZGluZ19sLCBjbWRxX3BrdCk7DQo+ICsNCj4gIAlp
ZiAodXNlX2R1YWxfcGlwZSkgew0KPiAgCQlyZG1hX2NvbmZpZy54X2xlZnQgPSBsX3c7DQo+ICAJ
CXJkbWFfY29uZmlnLndpZHRoID0gcl93Ow0KPiAgCQltdGtfbWRwX3JkbWFfY29uZmlnKHJkbWFf
ciwgJnJkbWFfY29uZmlnLCBjbWRxX3BrdCk7DQo+ICsJCWlmIChwYWRkaW5nX3IpDQo+ICsJCQlt
dGtfcGFkZGluZ19jb25maWcocGFkZGluZ19yLCBjbWRxX3BrdCk7DQo+ICAJfQ0KPiANCj4gIAlt
dGtfbWVyZ2Vfc3RhcnRfY21kcShtZXJnZSwgY21kcV9wa3QpOw0KPiBAQCAtMzU0LDYgKzM4Niw3
IEBAIHN0YXRpYyBpbnQgb3ZsX2FkYXB0b3JfY29tcF9nZXRfaWQoc3RydWN0IGRldmljZQ0KPiAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsDQo+ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX292bF9hZGFwdG9yX2NvbXBfZHRfaWRzW10gPSB7DQo+
ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtcGFkZGluZyIsIC5kYXRhID0gKHZv
aWQNCj4gKilPVkxfQURBUFRPUl9UWVBFX1BBRERJTkcgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5NS1kaXNwLWV0aGRyIiwgLmRhdGEgPSAodm9pZA0KPiAqKU9WTF9BREFQ
VE9SX1RZUEVfRVRIRFIgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1k
aXNwLW1lcmdlIiwgLmRhdGEgPSAodm9pZA0KPiAqKU9WTF9BREFQVE9SX1RZUEVfTUVSR0UgfSwN
Cj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS12ZG8xLXJkbWEiLCAuZGF0YSA9
ICh2b2lkDQo+ICopT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQSB9LA0KPiAtLQ0KPiAyLjE4LjAN
Cj4gDQo=
