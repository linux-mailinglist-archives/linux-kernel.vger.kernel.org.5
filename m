Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A017E186F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjKFCBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFCA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:00:58 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50AE1;
        Sun,  5 Nov 2023 18:00:53 -0800 (PST)
X-UUID: 4dc2758e7c4811ee8051498923ad61e6-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zXHHs05dsecqvKv7QS4xKP700rCrULP7x7o3dYLurXc=;
        b=fw3CKhZ8TRtYf8xENjhQse2QswsO5mLjipfrDsxg1UPQ1X57hwR04UkJUnJhdJu2eef6JndT28hD+6o+n1pFzoQ/UhKzjviUduXe6A7eF0pD1TXZMBE61HNPHKGnKjSkWuDkNBuEVYXgZUfC4nfsjhXWygg38rQRIcWpSytSpx4=;
X-CID-CACHE: Type:Local,Time:202311060937+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:0ff6b3e7-422f-4ed9-9aa8-6cdfe993d613,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:a4b9b55f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 4dc2758e7c4811ee8051498923ad61e6-20231106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 72288306; Mon, 06 Nov 2023 10:00:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 10:00:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 10:00:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X26E6wNLXTAhGg/YvoeihpAwChJr905LMTp6UY6am5SPnL/82hYkDNLCXbhoMcd2kZNlUe/pAP7shaY8hLJjvZ+SOi3PbqK2DxSOJMGsTR35cwVsBxWPsY7urNnPSPW8/a1Lwo6SstA0q7iKHQqqF6k27dWLD2jxj0Z05aPL+snFmYyuGxT7tFZOa7iwvsXRXecmY1/gW3Q8HnspKF2zqv5RFJI9LakDmn/XneOY2aTPAA5ZJSSB5qlgPRmXSFc9QluLjgoOKhnYF13qRYryAiqo+XfAE7TM9Hq9H4VE1NaseWPrcGEgevzXyX6pcmNZOf6ANbnibvYLhsSQ/eL6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXHHs05dsecqvKv7QS4xKP700rCrULP7x7o3dYLurXc=;
 b=UC3jzyaa/2wxR++EPa1pY7Yjo+ZB0DH94ejHyYsQhZWwwIyrmin/i+67QaikMaI5JBXIKgRay2nYlc+NMqEn6e/JFaqpiOYzZa0owGzERZrOq9lb/kRqFtv6k8wp2w3KjStJRBdoR+uF8zGfx8U33xwoIToA3pOvQOfcDCohYsPIhFs8TKuSE1u5g8dBAU5bUcefBql97OG8DNdkfLC15TLd/AqSRK/bCa7iJQ1+FeCfoF2jy2CzME+z+YanCKdIoMJ3a2nbkyQtib9ICkjH5R2ZFroa/UGmyvOIAsVnIUV7V3rBAnnmLaX7URaY6xOCEOUkRBHYZzL/bplsSXy3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXHHs05dsecqvKv7QS4xKP700rCrULP7x7o3dYLurXc=;
 b=WTd7y/S6cJv+j5cvr+wDGApFmqjmYsuMVuwFLzapk+ODN3vNnoKRiJVGcw8qhZSADKBsmlV0ma7Sfw5YdcjT9eZNUTnmqEZxe4Dhij8F4FP5n5ycPvn/lyerhucFCkT/x9S/Y5ZY+PJcphllcQ7Ct7EUpyGgtMs3Jyun7ecOn5w=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 02:00:44 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.6954.025; Mon, 6 Nov 2023
 02:00:44 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/11] Add mediate-drm secure flow for SVP
Thread-Topic: [PATCH v2 00/11] Add mediate-drm secure flow for SVP
Thread-Index: AQHaBWvmI0D7juVVnkOavIrmWYW347BjNIKAgAidGoCAAMcHAIAABp6A
Date:   Mon, 6 Nov 2023 02:00:43 +0000
Message-ID: <c068e07c7851e436f02d91a74ca556920dd20a0c.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <83ab8f76b48b27a5406a03c50467c968598b23db.camel@mediatek.com>
         <45eaa8a62bdb4a17b443c0ed8b3210a4b3b4a670.camel@mediatek.com>
         <aff783bfe5996ba322fce8a07daa07c92c80f83d.camel@mediatek.com>
In-Reply-To: <aff783bfe5996ba322fce8a07daa07c92c80f83d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5566:EE_
x-ms-office365-filtering-correlation-id: 16178ebe-c454-4625-166b-08dbde6c2fa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZO0PknIkZ4FwjxiPvdOwLp+gSys1OqUlX7zfDO8iqNZibpWcRFto2ktcCwZal/2MZsDVC6NMXf6aI/MpR7Pi3EiXhwv7aECBZYnJAFqapoAW68+w09mnNk9TqLSNN8O7fIh6vS3mf8VKLCjRHI/UDLypAb3hk/t7oq4SLG9UqLo6PRV0Ynlz+JCBiSOilhdNH4BECFKscO4trcTEe2PJ42tG1lvBzCBReJpyC0nrxfP3GnssNNogP6JvXbn4mWW1S6RI3qhVLOSnvp8PbN3nHVgOSfjfOa/jWN+flPwfuBQXg3DsAE/IsFPz1ZM241rTT/UAlaOwtJOLyLmqtmzY4LsDLSAVfOuCtuX8uvM1O0f2RD2C6A/R4rBcVJfb7HDhQQZe9iAl71M7wHSwFZPH1yoLYgmbGi8Dk0cKbe1u3ttUZzO5I8NSSJr+agwKUg5oZYT9IoOml9KuonZZwaz5YbJIgcJ8Fwei4r9yqxCVVtLhM/qvk8SKIs2YNcK/cPQoiw60n44yYrGSOV8fC1F9gqpeqNAcPWXoJPT5OZT6erbf8KnRMrrByd1t+ELjpxF98A+kUOgYNIMVqRM9QxbzuLQ69ubwRIXXCo7eXPoeqKNhihG3mRnnno1QkLIKug/sfJFqie6vEy9h5OtsC9BgTcGLkAp5lBPZrlMVUiJ2XAXu88n2n/c51D0J208ZBuKV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(316002)(38100700002)(122000001)(6506007)(71200400001)(6486002)(478600001)(110136005)(91956017)(966005)(66476007)(66556008)(54906003)(64756008)(66446008)(2616005)(26005)(6512007)(66946007)(76116006)(7416002)(4001150100001)(2906002)(41300700001)(5660300002)(85182001)(36756003)(4326008)(86362001)(8676002)(8936002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1FXYzB5WFYrUVpyWVZSbnF3T1dHK3dSTlVsNW9SYkkzNWJQaWd1NXVtbG1Q?=
 =?utf-8?B?Vy96NU9aL1JVK0Y4ZFJWeWU0QUdyUkxrVEY3T0llOWdJTVU1VUFIdEhrOXFr?=
 =?utf-8?B?TXoyNWNkNHR0Ni8zTGNCc2F0dzZlWnR2SDZnM2tMSDR0ZHNUWXpSRXB2RDZi?=
 =?utf-8?B?MnBFUFUxaTl5ekhwbEZQa05RL1p2WFlQZlRYQUsveWtMbUlmY3R1RWx5bFFr?=
 =?utf-8?B?Q0dmUDZYNUZYMksyM0tjQmd4SEw3ekszTjhYcjQyRUorcXJBNStxdS9MQzBs?=
 =?utf-8?B?UDAwdTRaMmZQeHRzamI2dk5XWm51cUZpVExRTFRENy9FUUJkQmJWQnNrVHdO?=
 =?utf-8?B?K3VtcEV1U2FlaXBKMzNyOXNnWTBYTFZZSzBUTG5wSnRWcnhQOUp4ZkdmMXNm?=
 =?utf-8?B?bExiREhoRVQxdHJicU9jdWNzTytuM0l0WDJTOWRpdXZ5QTduTFRHaEpieEZx?=
 =?utf-8?B?N3NFdUxMVU8xdzQ2YWdHc3RDUm9URFpDZnZuZ1VpWEE4MTd0d2ZaVm1xbWhj?=
 =?utf-8?B?L1kxQk1VRDRlalIzaU80L2ZWUGxkL2hZS2d5M2dtNEQ5dzFCelNuM0llWHZY?=
 =?utf-8?B?aHlXNSt3MzNmSVcvT1VZRkxOUHRWZHVBaVlpSlN2c1l0akVnek5YRWJwRVAv?=
 =?utf-8?B?bGRLMGRZblhRd2lRSDl4Wnprejc2a3pMSU1PNmNTNytkWnBFN0dndG52WThW?=
 =?utf-8?B?ZTJlVXVNNDBVRUFDaEhoblVPTlo0VlVUT1hya3M2Nmk4S2JnWDFaQ1loOW5q?=
 =?utf-8?B?TnJBWklDY3drU2tiTnRGdk0zeHk3QysxYk92bGtXYzR1Yng1dEdWL2FzN09F?=
 =?utf-8?B?SStlN040M0J0QnhQSnAxRXRMVElhVTJsSjdRalAxRzJ0TlVHSnBkUFJLYVZI?=
 =?utf-8?B?eWFlMm5EcUJQWUFrOGN3YmtjZ2U3dk1QcDNENGtqME5wRGVyc2VUTEZyczQr?=
 =?utf-8?B?S3luZ1dYSHEwSnNKMUFyN1pRbDNnNXhkcnJDeG5NbHkxQ1pOS3J6bEx6ZnJB?=
 =?utf-8?B?Y05YeWdHZlAvVWhHM2NPM295alJtRGhkU1d6cVg5Rk1PM3dRcCt0VDJjY05l?=
 =?utf-8?B?a0piYjk4NGp0d1dTQ2VTL205MFVLblhYK0FVaWE0WktGTkZReUNsdWZ4SW9H?=
 =?utf-8?B?N3ZqVEtkUG5sdHl5ckYwZEZDVnQrVjJEblUwU0o4VDJCRXFUeUtzQ05OcGp6?=
 =?utf-8?B?M0g2S0ZBMjVnR29GZHJOUzVSV3U4Tmg2VlJNS1RINGp0UEpzRzBob1dFbm9a?=
 =?utf-8?B?NHg3aW42bk16TkVNVVFUUzZvZDFVaVhYNmljdm9jcUk1WTlFRlRJbmYxZTdU?=
 =?utf-8?B?QmVhTGtqbytBRGdxWU5odDh2RUZNVDVyMHI5TE5FNHZKWDQxTVZCTzJHZzZD?=
 =?utf-8?B?SWNiY0tmRjJJUFh5WnZkYUJXYzgra1JSMGZKQ3lZcm1uVzh5ekZnc1Q3OFYv?=
 =?utf-8?B?dkI5bkVPajhBVm1IYjhIcnUyaFZVRGxiTjQ2eDdkNEl0ckxwbkdNQzh5V255?=
 =?utf-8?B?U05iQ25sVlZPQWlrWnk2MHdMZHA4TVdsY0ZYcW1kNTRZS2ppSVBBbzBsUTVM?=
 =?utf-8?B?OExTQm5WNmZoQktkOW1JdG5PQm94U0J0YzF4UzNFWVlQVEtkMVQzSmRacnNx?=
 =?utf-8?B?QmYwNGRuQ2JxUGZoWWF5YUtpWFltWitISnVxN0Y5VlA0VkpxRVMvSmdEdG5D?=
 =?utf-8?B?cEFiWVQrMWpKRjZRTGsyaFp0bzI4YkZNRWltdTJMY01UWmQwVmFOTXBMSS9S?=
 =?utf-8?B?b3p6RWhFc0xNY3RUQTg0VUc5bmZ0SXk1V0F1RnI4dTVEQUxwcHU0RUpzRWRU?=
 =?utf-8?B?SFpOV01sclNqeWNhS2h6RzZjQmp0VnZ5Nm45K1c4L3k0VGpmMHJtTnF2bUVR?=
 =?utf-8?B?UUh5bWFMK3ZhcTVCU01Ccm9PUDVqVGVNbnM0Q2kzNFNDeTNIZHg3ZXo0ODF5?=
 =?utf-8?B?cEJPTXM5cEUzeGFRb1JaVzVlYVFuWmJscHZ6MkdQbmlUZ1IvbXFXemYybGVW?=
 =?utf-8?B?TXJZMTVwc2tjbGMvOGswdFdnN0d3ZEdLd0RpSUdsMndWTVBpUWd2cHlIT3ZT?=
 =?utf-8?B?OVNwN2UrUkdJOTkwWTJ5UXUrejBrY3U0NEZJZFBrMjg1b1lzb2x2TTB4aFBT?=
 =?utf-8?B?YU9BdE1rd0FWN1R5eEVqM0F6Um11MmRrNStDVHRLZzNFc24xdHdRTE5TdWhK?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F508B390B00FB74C8B61431E15C43CB1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16178ebe-c454-4625-166b-08dbde6c2fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 02:00:43.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFMohIH+1cXUSvNRjLLDvAFyG28QyYmfglEVQEoyL4JdURSp3QbwcerNM8BxTeDtZltz8brnas6QDKQTRKSaMUuszh1lPCLfNw8oByItg00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5566
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.102400-8.000000
X-TMASE-MatchedRID: WMT2WRIkHPP4OiVTWoD8RCa1MaKuob8Pt3aeg7g/usCe9toQ6h6LE6gF
        8LHYfOYG2D7e38gex/CXQZXhovdntv/Js/ghYmSKhK8o4aoss8ooUVkB7ifJnjDJ9a3KikGoSuc
        qLHu3mZMk7FhZLnoFU/5FiV4N3Tf6fnx66e7JyubXIwmz2YEJxQd1gf75ubQYT7S4ZU4XTxCooO
        hgfg51ELGFv5k4++vVwTzZE6vGH1zU4D7YCSb+lFz+axQLnAVBZG3SCLP7QtIR34ro7k23naw3j
        KXVjW6NRw3fpQHgw3tMmA9tcmg664oNrmb7m9Z4TSPNp9e/u1Or/2i5iG4MZGv8A7jMYNJSee+p
        suSMY7rgp89BUpiL3P1/2RbvJIzKV4+WzoF/Pj+L9v4vFTanjhG8SlV3e9LV31GU/N5W5BAwrAJ
        nuG4aIS/rjK1CMnpukZOl7WKIImrS77Co4bNJXW/eovpfoe4KDV9TWrbbQmsqtq5d3cxkNZqglP
        QlvqtAsBp8T4KL5w5gt70ZmypXSzuQDegk66eBuM96w6r52rk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.102400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FD5D612A65713D86EDF28E3A417547496EF6535C5E2605A03069C988147003DB2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTA2IGF0IDAxOjM3ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gU3VuLCAyMDIzLTExLTA1IGF0IDEzOjQ0ICswMDAwLCBKYXNvbi1KSCBMaW4gKOae
l+edv+elpSkgd3JvdGU6DQo+ID4gSGkgQ0ssDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2
aWV3cy4NCj4gPiANCj4gPiBPbiBUdWUsIDIwMjMtMTAtMzEgYXQgMDI6MTIgKzAwMDAsIENLIEh1
ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+ID4gSGksIEphc29uOg0KPiA+ID4gDQo+ID4gPiBPbiBN
b24sIDIwMjMtMTAtMjMgYXQgMTI6NDUgKzA4MDAsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiA+
ID4gVGhlIHBhdGNoIHNlcmllcyBwcm92aWRlcyBkcm0gZHJpdmVyIHN1cHBvcnQgZm9yIGVuYWJs
aW5nDQo+ID4gPiA+IHNlY3VyZQ0KPiA+ID4gPiB2aWRlbw0KPiA+ID4gPiBwYXRoIChTVlApIHBs
YXliYWNrIG9uIE1lZGlhaVRlayBoYXJkd2FyZSBpbiB0aGUgTGludXgga2VybmVsLg0KPiA+ID4g
PiANCj4gPiA+ID4gTWVtb3J5IERlZmluaXRpb25zOg0KPiA+ID4gPiBzZWN1cmUgbWVtb3J5IC0g
TWVtb3J5IGFsbG9jYXRlZCBpbiB0aGUgVEVFIChUcnVzdGVkIEV4ZWN1dGlvbg0KPiA+ID4gPiBF
bnZpcm9ubWVudCkgd2hpY2ggaXMgaW5hY2Nlc3NpYmxlIGluIHRoZSBSRUUgKFJpY2ggRXhlY3V0
aW9uDQo+ID4gPiA+IEVudmlyb25tZW50LCBpLmUuIGxpbnV4IGtlcm5lbC91c2Vyc3BhY2UpLg0K
PiA+ID4gPiBzZWN1cmUgaGFuZGxlIC0gSW50ZWdlciB2YWx1ZSB3aGljaCBhY3RzIGFzIHJlZmVy
ZW5jZSB0bw0KPiA+ID4gPiAnc2VjdXJlDQo+ID4gPiA+IG1lbW9yeScuIFVzZWQgaW4gY29tbXVu
aWNhdGlvbiBiZXR3ZWVuIFRFRSBhbmQgUkVFIHRvIHJlZmVyZW5jZQ0KPiA+ID4gPiAnc2VjdXJl
IG1lbW9yeScuDQo+ID4gPiA+IHNlY3VyZSBidWZmZXIgLSAnc2VjdXJlIG1lbW9yeScgdGhhdCBp
cyB1c2VkIHRvIHN0b3JlDQo+ID4gPiA+IGRlY3J5cHRlZCwNCj4gPiA+ID4gY29tcHJlc3NlZCB2
aWRlbyBvciBmb3Igb3RoZXIgZ2VuZXJhbCBwdXJwb3NlcyBpbiB0aGUgVEVFLg0KPiA+ID4gPiBz
ZWN1cmUgc3VyZmFjZSAtICdzZWN1cmUgbWVtb3J5JyB0aGF0IGlzIHVzZWQgdG8gc3RvcmUgZ3Jh
cGhpYw0KPiA+ID4gPiBidWZmZXJzLg0KPiA+ID4gPiANCj4gPiA+ID4gTWVtb3J5IFVzYWdlIGlu
IFNWUDoNCj4gPiA+ID4gVGhlIG92ZXJhbGwgZmxvdyBvZiBTVlAgc3RhcnRzIHdpdGggZW5jcnlw
dGVkIHZpZGVvIGNvbWluZyBpbg0KPiA+ID4gPiBmcm9tDQo+ID4gPiA+IGFuDQo+ID4gPiA+IG91
dHNpZGUgc291cmNlIGludG8gdGhlIFJFRS4gVGhlIFJFRSB3aWxsIHRoZW4gYWxsb2NhdGUgYQ0K
PiA+ID4gPiAnc2VjdXJlDQo+ID4gPiA+IGJ1ZmZlcicgYW5kIHNlbmQgdGhlIGNvcnJlc3BvbmRp
bmcgJ3NlY3VyZSBoYW5kbGUnIGFsb25nIHdpdGgNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGVuY3J5
cHRlZCwgY29tcHJlc3NlZCB2aWRlbyBkYXRhIHRvIHRoZSBURUUuIFRoZSBURUUgd2lsbCB0aGVu
DQo+ID4gPiA+IGRlY3J5cHQNCj4gPiA+ID4gdGhlIHZpZGVvIGFuZCBzdG9yZSB0aGUgcmVzdWx0
IGluIHRoZSAnc2VjdXJlIGJ1ZmZlcicuIFRoZSBSRUUNCj4gPiA+ID4gd2lsbA0KPiA+ID4gPiB0
aGVuIGFsbG9jYXRlIGEgJ3NlY3VyZSBzdXJmYWNlJy4gVGhlIFJFRSB3aWxsIHBhc3MgdGhlICdz
ZWN1cmUNCj4gPiA+ID4gaGFuZGxlcycgZm9yIGJvdGggdGhlICdzZWN1cmUgYnVmZmVyJyBhbmQg
J3NlY3VyZSBzdXJmYWNlJyBpbnRvDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBURUUgZm9yIHZpZGVv
IGRlY29kaW5nLiBUaGUgdmlkZW8gZGVjb2RlciBIVyB3aWxsIHRoZW4gZGVjb2RlDQo+ID4gPiA+
IHRoZQ0KPiA+ID4gPiBjb250ZW50cyBvZiB0aGUgJ3NlY3VyZSBidWZmZXInIGFuZCBwbGFjZSB0
aGUgcmVzdWx0IGluIHRoZQ0KPiA+ID4gPiAnc2VjdXJlDQo+ID4gPiA+IHN1cmZhY2UnLiBUaGUg
UkVFIHdpbGwgdGhlbiBhdHRhY2ggdGhlICdzZWN1cmUgc3VyZmFjZScgdG8gdGhlDQo+ID4gPiA+
IG92ZXJsYXkNCj4gPiA+ID4gcGxhbmUgZm9yIHJlbmRlcmluZyBvZiB0aGUgdmlkZW8uDQo+ID4g
PiA+IA0KPiA+ID4gPiBFdmVyeXRoaW5nIHJlbGF0aW5nIHRvIGVuc3VyaW5nIHNlY3VyaXR5IG9m
IHRoZSBhY3R1YWwgY29udGVudHMNCj4gPiA+ID4gb2YNCj4gPiA+ID4gdGhlDQo+ID4gPiA+ICdz
ZWN1cmUgYnVmZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpcyBvdXQgb2Ygc2NvcGUgZm9yIHRo
ZQ0KPiA+ID4gPiBSRUUNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IGlzIHRoZSByZXNwb25zaWJpbGl0
eSBvZiB0aGUgVEVFLg0KPiA+ID4gPiANCj4gPiA+ID4gRFJNIGRyaXZlciBoYW5kbGVzIGFsbG9j
YXRpb24gb2YgZ2VtIG9iamVjdHMgdGhhdCBhcmUgYmFja2VkIGJ5DQo+ID4gPiA+IGENCj4gPiA+
ID4gJ3NlY3VyZQ0KPiA+ID4gPiBzdXJmYWNlJyBhbmQgZm9yIGRpc3BsYXlpbmcgYSAnc2VjdXJl
IHN1cmZhY2UnIG9uIHRoZSBvdmVybGF5DQo+ID4gPiA+IHBsYW5lLg0KPiA+ID4gPiBUaGlzIGlu
dHJvZHVjZXMgYSBuZXcgZmxhZyBmb3Igb2JqZWN0IGNyZWF0aW9uIGNhbGxlZA0KPiA+ID4gPiBE
Uk1fTVRLX0dFTV9DUkVBVEVfRU5DUllQVEVEIHdoaWNoIGluZGljYXRlcyBpdCBzaG91bGQgYmUg
YQ0KPiA+ID4gPiAnc2VjdXJlDQo+ID4gPiA+IHN1cmZhY2UnLiBBbGwgY2hhbmdlcyBoZXJlIGFy
ZSBpbiBNZWRpYVRlayBzcGVjaWZpYyBjb2RlLg0KPiA+ID4gPiANCj4gPiA+ID4gLS0tDQo+ID4g
PiA+IEJhc2VkIG9uIDMgc2VyaWVzIGFuZCAxIHBhdGNoOg0KPiA+ID4gPiBbMV0gZG1hLWJ1Zjog
aGVhcHM6IEFkZCBNZWRpYVRlayBzZWN1cmUgaGVhcA0KPiA+ID4gPiAtIA0KPiA+ID4gPiANCj4g
PiANCj4gPiANCj4gDQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9Nzgy
Nzc2X187ISFDVFJOS0E5d01nMEFSYnchbUZLeEdmcFhMRUY4LUF6aGxqR0dfTjEyYmstaDdXMC1K
WmVUWlprcXhKZ0I1V0ZiTVR4ZUVqYWxyc2xMckFKM2l3WUY2LWsyNzNqZ3pYS1NRWGNiZ1BVJA0K
PiA+ID4gPiAgDQo+ID4gPiA+IA0KPiA+ID4gPiBbMl0gYWRkIGRyaXZlciB0byBzdXBwb3J0IHNl
Y3VyZSB2aWRlbyBkZWNvZGVyDQo+ID4gPiA+IC0gDQo+ID4gPiA+IA0KPiA+IA0KPiA+IA0KPiAN
Cj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz03ODI5MjJfXzshIUNUUk5L
QTl3TWcwQVJidyFtRkt4R2ZwWExFRjgtQXpobGpHR19OMTJiay1oN1cwLUpaZVRaWmtxeEpnQjVX
RmJNVHhlRWphbHJzbExyQUozaXdZRjYtazI3M2pnelhLU0lQeUNReEkkDQo+ID4gPiA+ICANCj4g
PiA+ID4gDQo+ID4gPiA+IFszXSBzb2M6IG1lZGlhdGVrOiBBZGQgcmVnaXN0ZXIgZGVmaW5pdGlv
bnMgZm9yIEdDRQ0KPiA+ID4gPiAtIA0KPiA+ID4gPiANCj4gPiANCj4gPiANCj4gDQo+IA0KaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIzMTAxNzA2NDcxNy4yMTYxNi0yLXNoYXduLnN1
bmdAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IW1GS3hHZnBYTEVGOC1BemhsakdH
X04xMmJrLWg3VzAtSlplVFpaa3F4SmdCNVdGYk1UeGVFamFscnNsTHJBSjNpd1lGNi1rMjczamd6
WEtTck84Z21iSSQNCj4gPiA+ID4gIA0KPiA+ID4gPiANCj4gPiA+ID4gWzRdIEFkZCBDTURRIHNl
Y3VyZSBkcml2ZXIgZm9yIFNWUA0KPiA+ID4gPiAtIA0KPiA+ID4gPiANCj4gPiANCj4gPiANCj4g
DQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9Nzk1NTAyX187ISFDVFJO
S0E5d01nMEFSYnchbUZLeEdmcFhMRUY4LUF6aGxqR0dfTjEyYmstaDdXMC1KWmVUWlprcXhKZ0I1
V0ZiTVR4ZUVqYWxyc2xMckFKM2l3WUY2LWsyNzNqZ3pYS1Nwb3NEMlJrJA0KPiA+ID4gPiAgDQo+
ID4gPiANCj4gPiA+IFNlY3VyZSBkaXNwbGF5IGRlcGVuZCBvbiBzZWN1cmUgbW1zeXMuIFJvdXRp
bmcgY29udHJvbCBzaG91bGQgYmUNCj4gPiA+IHNlY3VyZQ0KPiA+ID4gc28gbW1zeXMgZHJpdmVy
IHNob3VsZCBoYXZlIHNvbWUgbW9kaWZpY2F0aW9uIHRoYXQgY2FsbCBpbnRvDQo+ID4gPiBzZWN1
cmUNCj4gPiA+IHdvcmxkIHRvIGNoYW5nZSByb3V0aW5nLiBBZGQgbW1zeXMgc2VyaWVzIGluIHRo
aXMgZGVwZW5kZW5jeQ0KPiA+ID4gbGlzdC4NCj4gPiANCj4gPiBZZXMsIEknbGwgbW92ZSB0aGUg
cm91dGUgc2V0dGluZ3MgdG8gdGhlIHNlY3VyZSB3b3JsZCBmb3IgdGhvc2UgU1ZQDQo+ID4gc3Vw
cG9ydGVkIFNvQy4gVGhlIG1tc3lzIG1vZGlmaWNhdGlvbnMgYXJlIHN0aWxsIGluIHByb2dyZXNz
LiBJdA0KPiA+IHdpbGwNCj4gPiBiZSBzZW5kIGFmdGVyIGEgZmV3IHZlcnNpb24uDQo+IA0KPiBB
ZGQgVE9ETyBpbmZvcm1hdGlvbiBzbyB0aGF0IHdlIHdvdWxkIG5vdCBmb3JnZXQgdGhpcy4NCj4g
DQpPSywgSSdsbCBhZGQgVE9ETyB0byB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClJlZ2FyZHMsDQpK
YXNvbi1KSC5MaW4NCg0KPiA+IA0KPiA+IFJlZ2FyZHMNCj4gPiBKYXNvbi1KSC5MaW4NCj4gPiAN
Cj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IENLDQo+ID4gPiANCj4gPiA+ID4gLS0tDQo+
ID4gPiA+IENoYW5nZSBpbiB2MjoNCj4gPiA+ID4gDQo+ID4gPiA+IDEuIHJlbW92ZSB0aGUgRFJJ
VkVSX1JETkRFUiBmbGFnIGZvciBtdGtfZHJtX2lvY3RsDQo+ID4gPiA+IDIuIG1vdmUgY21kcV9p
bnNlcnRfYmFja3VwX2Nvb2tpZSBpbnRvIGNsaWVudCBkcml2ZXINCj4gPiA+ID4gMy4gbW92ZSBz
ZWN1cmUgZ2NlIG5vZGUgZGVmaW5lIGZyb20gbXQ4MTk1LWNoZXJyeS5kdHNpIHRvDQo+ID4gPiA+
IG10ODE5NS5kdHNpDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiANCj4gPiA+ID4gQ0sgSHUgKDEpOg0K
PiA+ID4gPiAgIGRybS9tZWRpYXRlazogQWRkIGludGVyZmFjZSB0byBhbGxvY2F0ZSBNZWRpYVRl
ayBHRU0gYnVmZmVyLg0KPiA+ID4gPiANCj4gPiA+ID4gSmFzb24tSkguTGluICgxMCk6DQo+ID4g
PiA+ICAgZHJtL21lZGlhdGVrL3VhcGk6IEFkZCBEUk1fTVRLX0dFTV9DUkVBVEVEX0VOQ1JZUFRU
RUQgZmxhZw0KPiA+ID4gPiAgIGRybS9tZWRpYXRlazogQWRkIHNlY3VyZSBidWZmZXIgY29udHJv
bCBmbG93IHRvIG10a19kcm1fZ2VtDQo+ID4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJl
IGlkZW50aWZ5IGZsYWcgYW5kIGZ1bmN1dGlvbiB0bw0KPiA+ID4gPiBtdGtfZHJtX3BsYW5lDQo+
ID4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgbXRrX2RkcF9zZWNfd3JpdGUgdG8gY29uZmlnIHNl
Y3VyZSBidWZmZXINCj4gPiA+ID4gaW5mbw0KPiA+ID4gPiAgIGRybS9tZWRpYXRlazogQWRkIGdl
dF9zZWNfcG9ydCBpbnRlcmZhY2UgdG8gbXRrX2RkcF9jb21wDQo+ID4gPiA+ICAgZHJtL21lZGlh
dGVrOiBBZGQgc2VjdXJlIGxheWVyIGNvbmZpZyBzdXBwb3J0IGZvciBvdmwNCj4gPiA+ID4gICBk
cm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1cHBvcnQgZm9yIG92bF9hZGFw
dG9yDQo+ID4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGZsb3cgc3VwcG9ydCB0byBt
ZWRpYXRlay1kcm0NCj4gPiA+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBjbWRxX2luc2VydF9iYWNr
dXBfY29va2llIGJlZm9yZSBzZWN1cmUgcGt0DQo+ID4gPiA+IGZpbmFsaXplDQo+ID4gPiA+ICAg
YXJtNjQ6IGR0czogbXQ4MTk1OiBBZGQgc2VjdXJlIG1ib3ggc2V0dGluZ3MgZm9yIHZkb3N5cw0K
PiA+ID4gPiANCj4gPiA+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0
c2kgICAgICB8ICAgNiArLQ0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2Rydi5oICAgICAgIHwgICAzICsNCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYyAgICAgICB8ICAzMSArLQ0KPiA+ID4gPiAgLi4uL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgIHwgIDE1ICsNCj4gPiA+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgICAgICB8IDI3NA0KPiA+ID4gPiArKysr
KysrKysrKysrKysrKy0NCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuaCAgICAgICB8ICAgMSArDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jICAgfCAgMTQgKw0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCAgIHwgIDEzICsNCj4gPiA+ID4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICAgICAgICB8ICAxMyArDQo+ID4gPiA+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYyAgICAgICAgfCAxMjEgKysrKysrKysN
Cj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5oICAgICAgICB8
ICAxNiArDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5j
ICAgICAgfCAgIDcgKw0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
cGxhbmUuaCAgICAgIHwgICAyICsNCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfbWRwX3JkbWEuYyAgICAgICB8ICAxMSArLQ0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19tZHBfcmRtYS5oICAgICAgIHwgICAyICsNCj4gPiA+ID4gIGluY2x1ZGUvdWFw
aS9kcm0vbWVkaWF0ZWtfZHJtLmggICAgICAgICAgICAgICB8ICA1OSArKysrDQo+ID4gPiA+ICAx
NiBmaWxlcyBjaGFuZ2VkLCA1NzAgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+ID4g
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBpL2RybS9tZWRpYXRla19kcm0uaA0K
PiA+ID4gPiANCg==
