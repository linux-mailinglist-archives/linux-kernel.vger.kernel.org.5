Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA675EB75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjGXGY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjGXGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:24:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03FCB8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:24:48 -0700 (PDT)
X-UUID: c5000ad629ea11eeb20a276fd37b9834-20230724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jXsFr3WSNh12uHrXx8CDrluQGk3CM7Zn6j45QIxKYqw=;
        b=md4+V3XRsTd8XVa+qr+l775GH/Tis+vVJeLMNCJaQmek2DxJwgVoOq0h1s70VydDjtit8E8wLSglOO4u3I1M99Q3HezVxxRXIQ+qisUgBAWVB119ajSCrn++Cr0IVECHNGSkuCbELaRF9eh4xDeOp9mfjJhl31kBH4zpgA4b20Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:61e4aac4-46e5-4063-adc6-09a9b2be0a15,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:699bf0dc-dc79-4898-9235-1134b97257a8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c5000ad629ea11eeb20a276fd37b9834-20230724
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 318079550; Mon, 24 Jul 2023 14:24:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jul 2023 14:24:38 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Jul 2023 14:24:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmKXel3oZHYU0FIzxYqwY9n9EdKHALs4HpvPw3VgzMhwTZgJQCCXTYSmXTph+rpwMJs9IyS0GUZMSc4C7+12lWfQMnGOABZUOVMmMuVxndfyKC0/G3btOJsONNM8qtgKuU8njU7B9ToAfj0AiYx2HyLVwD7osPpebiSwneY27VzwRCC5wZ1u6ZUiv3gsad6rpYrb7TcW1Db/4tJ/U6tYePD3xJcQMxilP1jpgxfdPqDhZYPA+7So5OeFqf+Ftb+JgREcV/qXC9C5l/iB6Adwf7iTkohr63IJ3ewiuj/R/x3kjNNCn0SHE+WuiRoONfMoVgD5HoZaveXQxTRM2/bc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXsFr3WSNh12uHrXx8CDrluQGk3CM7Zn6j45QIxKYqw=;
 b=bDbxpk1+qIz1/vovZYAj3BDOcGa0EL3+vLXhT8JVH1YkjvZme08Ke56UFvuvgy7ozQ3a0jaUGK7ph8JmUuqDl0xB1cBYIwNQ5ctejtLzxj0ASxaP9uKSKJmSiNSz5oUhvwiOSql2DpcgpKYYzXRhrFLCG1rDw7LAyZsH7SAzI7RVzOwuO1RDukRZx7QZpk+CU9LBZiPs4hNF8oIPIWmtFzlc/FYa555eHGxFubJhmQgxTCUheFr+alZskfgHdq/ps78F9bf0NCABFWJHuPgU+Ics2uC50tiBoXYuwyXtKDH1nji525Mzp+g9jCTJjalQ2O+DjG9mo15ji4uMIHFiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXsFr3WSNh12uHrXx8CDrluQGk3CM7Zn6j45QIxKYqw=;
 b=dhzVZyxFXfnMryzAKVh9kim05BgOcNoA2dHE0+0wl4D7MEEkxmpMggglSk9zzA+Hjqfi/so4EbPhfjn47o+iqv8Mlq5gdNaBm7uP3NETTdiGmKLHy+HL9Vwt5ivhkMkZTghkGq0d86fgkOJweY/v4JQqOttvTDrWSpgtLFEi64M=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7386.apcprd03.prod.outlook.com (2603:1096:400:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:24:36 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 06:24:35 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v6 09/11] drm/mediatek: dp: Add support for embedded
 DisplayPort aux-bus
Thread-Topic: [PATCH v6 09/11] drm/mediatek: dp: Add support for embedded
 DisplayPort aux-bus
Thread-Index: AQHZuLk0z4TRpMzGpkCGY12CBWb5Xa/IfZWA
Date:   Mon, 24 Jul 2023 06:24:35 +0000
Message-ID: <fcb07edb3cbebe8b9bbdd8882e2086d202c1c0bb.camel@mediatek.com>
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
         <20230717141438.274419-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717141438.274419-10-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7386:EE_
x-ms-office365-filtering-correlation-id: cc29acc3-4620-4239-3968-08db8c0ea6a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hakkARNVuoHjDaXQote9UswSt4yywNL0vZymwGmE2TKTkfvHOkFCAchXJ7umqPElLlZIgqyox0RjIhLCfGmMSvV06TZSzL/P8jT2cGKZgTtCYnZA24sheNrziHRy9qglWJ014dtfYtmYP7tgsiaOq3gBA5PvaBQYM3tLfOiuP4RYbnLTB5IhIqvN3dUTdqwwGG3XygMdKXfF5WS5eLepsoz8IHyNTBPJFAFlksrRPiJtTAjPdIaYpUt8rrEhtzxDClEroXnt4lA+f/mp2O+elqq1CBaa4D917k+k/nrqLjPJdhHdnBELtCCwqY4Ibzsq6o5j2IXlf824MI5ic6OxbmMIV1zpOLu0WfXUo0mYZkL4kbdL8C5ERqIglDevo092crv6aeK0LN8YmBPhnKQyFnPOj8BfnIqTy796MQkkwK6E66XL+BDxm6bkU+E2Q5WDFRL/U+bR5BmtAh8jxEuz3HAsyS5EWPl5IT7Sijmh20REY8yPJIR5KFDUUZUau0OU04VE2HP5ZSyIRuCsLf2dU03nYRGYi0VIHq6wPexxK81QlNGaTTT/o5Q876iwLDNSTQs56clgmlFmcOXJp1FXHTS5HrzM8zKx4WQgQhle14q6B9Xlg7vgpp3EDc//7Rg604h7Br53gdvMYfL6D8bbzM9NwrWoyerG+KOjq5wk+Eg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(6512007)(6486002)(71200400001)(54906003)(110136005)(478600001)(83380400001)(86362001)(38070700005)(2906002)(2616005)(186003)(6506007)(26005)(76116006)(122000001)(38100700002)(36756003)(85182001)(66946007)(66476007)(66446008)(4326008)(316002)(41300700001)(8676002)(8936002)(64756008)(66556008)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1JXMHF5QUxRNEdMUjRqcGFaT3NtN0VleDFMbVJQZng3ajR0Ukdrbm9WVG1F?=
 =?utf-8?B?M3hxOHlKUGpUK0M0Y3hNOHRFMDMyR3IxajgvQzkzT2w1R3ZBRC9KVnNDSWpw?=
 =?utf-8?B?WnhaMk9pUXlCQTQ2TmQwVGpaY2dMb0tTaDd6Y1B2dUs0ckxkd2pJWHp1RU54?=
 =?utf-8?B?ZUtNekkwemJEYjBHRnhZbVFVajMwREFnWm5mNU0xZCtWM3BQU21lalVzekVY?=
 =?utf-8?B?UFRzeVdxSzBWbWdRMy9kc3NYS2pJcFpHMWx0RkZtTFEzWmgyWVh6WXdtYm9k?=
 =?utf-8?B?dFYwaXFHN0hab2FXK1lBNlJ1QmlIaDNQRTU3ODR6bHdEaWRFY3pSeEVOeUI5?=
 =?utf-8?B?UW01MHU4bnhVZGw2Zy92TnB4RFFQb01RSmh4WU5JYlRzVHZEekRjR2ZSOXRV?=
 =?utf-8?B?NEtlL0FPRkNUV2FNaUw3c0pUSGZJNnQyVVBnc2Z6eUQrV2ZIL25hMTZiM1U2?=
 =?utf-8?B?WFFLcEJnQkFCUnZJNTFaQ3lRVS8zZUhFRmZUWlpmaVV3M2l4U0E5Zi9rRlBP?=
 =?utf-8?B?ZFQvQWVLNDFuZHp5U3VRdWlnaHNCVVIxazNvTHBxcEErN0QwM1lScml3dElM?=
 =?utf-8?B?RWdzb1FUbWFXWmFUOXAybHZmR0IramRPRGRjdG9PV3lFbmgzRmJxVDRLNEk5?=
 =?utf-8?B?eXRTcmh2U1VhNlQxM3E1WDNFODhDbzlIWjBrM0x3Q0FtMGRyMEczSWxrMkM1?=
 =?utf-8?B?TUZKSTljZVQvTUdzK3B3R3FJMVd1QUJpZHk5S3FGU0RTdHBIZEUvN0F0WUs3?=
 =?utf-8?B?MVZLZHA2NVV1RE41M0tWOENzUUY0NkN2YkU0TWY4SVluT0RoMUdhdUlJTktD?=
 =?utf-8?B?M283azMrY2NBUnliK3o1N2g5SVpLSmQwMUdOUnpoaFUvZGJiTkRBdFMyck1X?=
 =?utf-8?B?ai9VL3c1S1I0ZW5DSEhDa0pxVTI5Rm5Qb3lROXkxbWVJUkd1bTNOQ1RNSy9t?=
 =?utf-8?B?YlVBMnpDcGY3V0ZIaDgvVjRQQ09YWGZ6S3VVbXZHcTVyaTZyRy9oUjFNRGdK?=
 =?utf-8?B?czczUEViRzIvdjFWY1JLNVVNQ3VQc3pQUVlZZTNyd0JwSVlPd1d4Vk9FVWEz?=
 =?utf-8?B?ZEh5eVJMbTQyVEdncDVYbW40Z1BYSGlneVZXMHgrdnlBOC93bHRFU1l2MWg1?=
 =?utf-8?B?K0ZKU3FDUm1YRzY3OHk5UEZ3b2lsMFVOcWRGZE9DdmRhSkgwaDZpWlFaZWlP?=
 =?utf-8?B?WlY5S2RmTitQdHRLREhoZmRZc3VvRUM5RkNFQ05ERTYyTHlHU3MyYlBWZi9n?=
 =?utf-8?B?andYNDdPdndEZVFiY1ljMGtNNWNVZ0kzZlJNUHZOMGViSzczbjQ3STJJbzB4?=
 =?utf-8?B?ZEFTcE0xVTdnOXJrdFAzcGxqS25FT09ZRTZGNzJvS2pXMWRaWXZVTy81N0xZ?=
 =?utf-8?B?WjIrajJLK01WejRlYU43Tm5HVTJaUkZBbmFpbUhFWlBEWGFXQjlOejFMMExR?=
 =?utf-8?B?cUFqYTBicnAyWEVyeHE3alhTeWo0QktuYWpNanZ3K3Rka0tlUjVkYjFaT250?=
 =?utf-8?B?RzZJUWd3RW81NjVHSFF0MXg1NFVHWUdRZldhOHV5aHRZSE5WRHYyQVM3Rk80?=
 =?utf-8?B?N21tNkZIZmNMWnFoYkI5OWpHRGNmWURKWXJqN1NqUFlJLzdGWGFFQ3pvVnk4?=
 =?utf-8?B?TXRXNThlaGtUcmR2QnIvaml6bDU5V0tvQ3BWNjM3dFluMDdzbmFwWkhtV20v?=
 =?utf-8?B?aFB2Q0xEeTltMW11ZXRPb2xBZmFFeEtGTVpiWjRxd0ZwVXlRSmlTOHdjRTdQ?=
 =?utf-8?B?YklIUGRiZmQxZ2toRStUeWswb0tJYlhvQVArNUNOZTd3ZzJLY0VjdG8xWE82?=
 =?utf-8?B?M0hVNVRVekduYjVvaHlHQ3B3SmREMHg3WGRyVUlTbjAway9mUXdUdzA1MERK?=
 =?utf-8?B?MExtTS92NlFTZ0pSNDFnNFFORFdvVm5CYVNDMU4xK0xwZHpCRmF3eHBHS3V0?=
 =?utf-8?B?ZWc0WVlUTzRnakl0TDBhU3NzTkUxdDdabDVyekVsV2JXRi9sRHY0L05oYTJ4?=
 =?utf-8?B?MklWT1E3M3AvRHA5NmtwTkkxbkwzNkViY1FlNi9pSm95MVpJQk4vbkIvWE9T?=
 =?utf-8?B?eVptOWdnUFU4d3VaVXdPNmg3MWVtTmJ4ak9mQmpRejJGWnRDOTlaNTRCeElT?=
 =?utf-8?Q?jJCx5u10NugeUzpbS92Cu/cBS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46DDE03805247B43ADF55824C8A48832@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc29acc3-4620-4239-3968-08db8c0ea6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:24:35.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCRSm+snX2IWJ22kMqw6OAQNwPrAJ0IRmcyA4vFq+gV21HS7TiRvw3OvQu9azfCPVUFhTngokPxbrCmizhiDRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7386
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDIzLTA3LTE3IGF0IDE2OjE0ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGb3IgdGhlIGVEUCBj
YXNlIHdlIGNhbiBzdXBwb3J0IHVzaW5nIGF1eC1idXMgb24gTWVkaWFUZWsgRFA6IHRoaXMNCj4g
Z2l2ZXMgdXMgdGhlIHBvc3NpYmlsaXR5IHRvIGRlY2xhcmUgb3VyIHBhbmVsIGFzIGdlbmVyaWMg
InBhbmVsLWVkcCINCj4gd2hpY2ggd2lsbCBhdXRvbWF0aWNhbGx5IGNvbmZpZ3VyZSB0aGUgdGlt
aW5ncyBhbmQgYXZhaWxhYmxlIG1vZGVzDQo+IHZpYSB0aGUgRURJRCB0aGF0IHdlIHJlYWQgZnJv
bSBpdC4NCj4gDQo+IFRvIGRvIHRoaXMsIG1vdmUgdGhlIHBhbmVsIHBhcnNpbmcgYXQgdGhlIGVu
ZCBvZiB0aGUgcHJvYmUgZnVuY3Rpb24NCj4gc28gdGhhdCB0aGUgaGFyZHdhcmUgaXMgaW5pdGlh
bGl6ZWQgYmVmb3JlaGFuZCBhbmQgYWxzbyBpbml0aWFsaXplDQo+IHRoZSBEUFRYIEFVWCBibG9j
ayBhbmQgcG93ZXIgYm90aCBvbiBhcywgd2hlbiB3ZSBwb3B1bGF0ZSB0aGUNCj4gYXV4LWJ1cywg
dGhlIHBhbmVsIGRyaXZlciB3aWxsIHRyaWdnZXIgYW4gRURJRCByZWFkIHRvIHBlcmZvcm0NCj4g
cGFuZWwgZGV0ZWN0aW9uLg0KPiANCj4gTGFzdCBidXQgbm90IGxlYXN0LCBzaW5jZSBub3cgdGhl
IEFVWCB0cmFuc2ZlcnMgY2FuIGhhcHBlbiBpbiB0aGUNCj4gc2VwYXJhdGVkIGF1eC1idXMsIGl0
IHdhcyBuZWNlc3NhcnkgdG8gYWRkIGFuIGV4Y2x1c2lvbiBmb3IgdGhlDQo+IGNhYmxlX3BsdWdn
ZWRfaW4gY2hlY2sgaW4gYG10a19kcF9hdXhfdHJhbnNmZXIoKWAgYW5kIHRoZSBlYXNpZXN0DQo+
IHdheSB0byBkbyB0aGlzIGlzIHRvIHNpbXBseSBpZ25vcmUgY2hlY2tpbmcgdGhhdCB3aGVuIHRo
ZSBicmlkZ2UNCj4gdHlwZSBpcyBlRFAuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVk
aWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvS2NvbmZpZyAgfCAgMSArDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgfCA4NCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPiAtLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3OSBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9LY29u
ZmlnDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL0tjb25maWcNCj4gaW5kZXggYjQ1MWRl
ZTY0ZDM0Li43NmNhYjI4ZTAxMGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9LY29uZmlnDQo+
IEBAIC0yNiw2ICsyNiw3IEBAIGNvbmZpZyBEUk1fTUVESUFURUtfRFANCj4gIAlzZWxlY3QgUEhZ
X01US19EUA0KPiAgCXNlbGVjdCBEUk1fRElTUExBWV9IRUxQRVINCj4gIAlzZWxlY3QgRFJNX0RJ
U1BMQVlfRFBfSEVMUEVSDQo+ICsJc2VsZWN0IERSTV9EUF9BVVhfQlVTDQo+ICAJaGVscA0KPiAg
CSAgRFJNL0tNUyBEaXNwbGF5IFBvcnQgZHJpdmVyIGZvciBNZWRpYVRlayBTb0NzLg0KPiAgDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggMWI0MjE5ZTZhMDBiLi5hY2Rk
NDU3YjU0NDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAgLTQsNiAr
NCw3IEBADQo+ICAgKiBDb3B5cmlnaHQgKGMpIDIwMjIgQmF5TGlicmUNCj4gICAqLw0KPiAgDQo+
ICsjaW5jbHVkZSA8ZHJtL2Rpc3BsYXkvZHJtX2RwX2F1eF9idXMuaD4NCj4gICNpbmNsdWRlIDxk
cm0vZGlzcGxheS9kcm1fZHAuaD4NCj4gICNpbmNsdWRlIDxkcm0vZGlzcGxheS9kcm1fZHBfaGVs
cGVyLmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9hdG9taWNfaGVscGVyLmg+DQo+IEBAIC0xMzEz
LDkgKzEzMTQsMTEgQEAgc3RhdGljIHZvaWQgbXRrX2RwX3Bvd2VyX2Rpc2FibGUoc3RydWN0IG10
a19kcA0KPiAqbXRrX2RwKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHBfaW5pdGlhbGl6ZV9w
cml2X2RhdGEoc3RydWN0IG10a19kcCAqbXRrX2RwKQ0KPiAgew0KPiArCWJvb2wgcGx1Z2dlZF9p
biA9IChtdGtfZHAtPmJyaWRnZS50eXBlID09DQo+IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApOw0K
PiArDQo+ICAJbXRrX2RwLT50cmFpbl9pbmZvLmxpbmtfcmF0ZSA9IERQX0xJTktfQldfNV80Ow0K
PiAgCW10a19kcC0+dHJhaW5faW5mby5sYW5lX2NvdW50ID0gbXRrX2RwLT5tYXhfbGFuZXM7DQo+
IC0JbXRrX2RwLT50cmFpbl9pbmZvLmNhYmxlX3BsdWdnZWRfaW4gPSBmYWxzZTsNCj4gKwltdGtf
ZHAtPnRyYWluX2luZm8uY2FibGVfcGx1Z2dlZF9pbiA9IHBsdWdnZWRfaW47DQo+ICANCj4gIAlt
dGtfZHAtPmluZm8uZm9ybWF0ID0gRFBfUElYRUxGT1JNQVRfUkdCOw0KPiAgCW1lbXNldCgmbXRr
X2RwLT5pbmZvLnZtLCAwLCBzaXplb2Yoc3RydWN0IHZpZGVvbW9kZSkpOw0KPiBAQCAtMTYxNyw2
ICsxNjIwLDE2IEBAIHN0YXRpYyBpbnQgbXRrX2RwX3BhcnNlX2NhcGFiaWxpdGllcyhzdHJ1Y3QN
Cj4gbXRrX2RwICptdGtfZHApDQo+ICAJdTggdmFsOw0KPiAgCXNzaXplX3QgcmV0Ow0KPiAgDQo+
ICsJLyoNCj4gKwkgKiBJZiB3ZSdyZSBlRFAgYW5kIGNhcGFiaWxpdGllcyB3ZXJlIGFscmVhZHkg
cGFyc2VkIHdlIGNhbg0KPiBza2lwDQo+ICsJICogcmVhZGluZyBhZ2FpbiBiZWNhdXNlIGVEUCBw
YW5lbHMgYXJlbid0IGhvdHBsdWdnYWJsZSBoZW5jZQ0KPiB0aGUNCj4gKwkgKiBjYXBzIGFuZCB0
cmFpbmluZyBpbmZvcm1hdGlvbiB3b24ndCBldmVyIGNoYW5nZSBpbiBhIGJvb3QNCj4gbGlmZQ0K
PiArCSAqLw0KPiArCWlmIChtdGtfZHAtPmJyaWRnZS50eXBlID09IERSTV9NT0RFX0NPTk5FQ1RP
Ul9lRFAgJiYNCj4gKwkgICAgbXRrX2RwLT5yeF9jYXBbRFBfTUFYX0xJTktfUkFURV0gJiYNCj4g
KwkgICAgbXRrX2RwLT50cmFpbl9pbmZvLnNpbmtfc3NjKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0K
PiAgCXJldCA9IGRybV9kcF9yZWFkX2RwY2RfY2FwcygmbXRrX2RwLT5hdXgsIG10a19kcC0+cnhf
Y2FwKTsNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gQEAgLTIwMzAsMTUg
KzIwNDMsMTQgQEAgc3RhdGljIHN0cnVjdCBlZGlkICptdGtfZHBfZ2V0X2VkaWQoc3RydWN0DQo+
IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gIHN0YXRpYyBzc2l6ZV90IG10a19kcF9hdXhfdHJhbnNm
ZXIoc3RydWN0IGRybV9kcF9hdXggKm10a19hdXgsDQo+ICAJCQkJICAgc3RydWN0IGRybV9kcF9h
dXhfbXNnICptc2cpDQo+ICB7DQo+IC0Jc3RydWN0IG10a19kcCAqbXRrX2RwOw0KPiArCXN0cnVj
dCBtdGtfZHAgKm10a19kcCA9IGNvbnRhaW5lcl9vZihtdGtfYXV4LCBzdHJ1Y3QgbXRrX2RwLA0K
PiBhdXgpOw0KPiAgCWJvb2wgaXNfcmVhZDsNCj4gIAl1OCByZXF1ZXN0Ow0KPiAgCXNpemVfdCBh
Y2Nlc3NlZF9ieXRlcyA9IDA7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAtCW10a19kcCA9IGNvbnRh
aW5lcl9vZihtdGtfYXV4LCBzdHJ1Y3QgbXRrX2RwLCBhdXgpOw0KPiAtDQo+IC0JaWYgKCFtdGtf
ZHAtPnRyYWluX2luZm8uY2FibGVfcGx1Z2dlZF9pbikgew0KPiArCWlmIChtdGtfZHAtPmJyaWRn
ZS50eXBlICE9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFAgJiYNCj4gKwkgICAgIW10a19kcC0+dHJh
aW5faW5mby5jYWJsZV9wbHVnZ2VkX2luKSB7DQo+ICAJCXJldCA9IC1FQUdBSU47DQo+ICAJCWdv
dG8gZXJyOw0KPiAgCX0NCj4gQEAgLTI1MDEsNiArMjUxMywyOCBAQCBzdGF0aWMgaW50IG10a19k
cF9yZWdpc3Rlcl9waHkoc3RydWN0IG10a19kcA0KPiAqbXRrX2RwKQ0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50IG10a19kcF9lZHBfbGlua19wYW5lbChzdHJ1Y3QgZHJt
X2RwX2F1eCAqbXRrX2F1eCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2RwICptdGtfZHAgPSBjb250
YWluZXJfb2YobXRrX2F1eCwgc3RydWN0IG10a19kcCwNCj4gYXV4KTsNCj4gKwlzdHJ1Y3QgZGV2
aWNlICpkZXYgPSBtdGtfYXV4LT5kZXY7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCW10a19kcC0+
bmV4dF9icmlkZ2UgPSBkZXZtX2RybV9vZl9nZXRfYnJpZGdlKGRldiwgZGV2LT5vZl9ub2RlLCAN
Cj4gMSwgMCk7DQo+ICsNCj4gKwkvKiBQb3dlciBvZmYgdGhlIERQIGFuZCBBVVg6IGVpdGhlciBk
ZXRlY3Rpb24gaXMgZG9uZSwgb3Igbm8NCj4gcGFuZWwgcHJlc2VudCAqLw0KPiArCW10a19kcF91
cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9UT1BfUFdSX1NUQVRFLA0KPiArCQkJICAgRFBfUFdS
X1NUQVRFX0JBTkRHQVBfVFBMTCwNCj4gKwkJCSAgIERQX1BXUl9TVEFURV9NQVNLKTsNCj4gKwlt
dGtfZHBfcG93ZXJfZGlzYWJsZShtdGtfZHApOw0KPiArDQo+ICsJaWYgKElTX0VSUihtdGtfZHAt
Pm5leHRfYnJpZGdlKSkgew0KPiArCQlyZXQgPSBQVFJfRVJSKG10a19kcC0+bmV4dF9icmlkZ2Up
Ow0KPiArCQltdGtfZHAtPm5leHRfYnJpZGdlID0gTlVMTDsNCj4gKwkJcmV0dXJuIHJldDsNCj4g
Kwl9DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgbXRrX2RwX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG10a19kcCAq
bXRrX2RwOw0KPiBAQCAtMjUzMSw5ICsyNTY1LDEwIEBAIHN0YXRpYyBpbnQgbXRrX2RwX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0
dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8gcGFyc2UgZHRcbiIpOw0KPiAg
DQo+IC0JZHJtX2RwX2F1eF9pbml0KCZtdGtfZHAtPmF1eCk7DQo+ICAJbXRrX2RwLT5hdXgubmFt
ZSA9ICJhdXhfbXRrX2RwIjsNCj4gKwltdGtfZHAtPmF1eC5kZXYgPSBkZXY7DQo+ICAJbXRrX2Rw
LT5hdXgudHJhbnNmZXIgPSBtdGtfZHBfYXV4X3RyYW5zZmVyOw0KPiArCWRybV9kcF9hdXhfaW5p
dCgmbXRrX2RwLT5hdXgpOw0KPiAgDQo+ICAJc3Bpbl9sb2NrX2luaXQoJm10a19kcC0+aXJxX3Ro
cmVhZF9sb2NrKTsNCj4gIA0KPiBAQCAtMjU3Nyw2ICsyNjEyLDQzIEBAIHN0YXRpYyBpbnQgbXRr
X2RwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJbXRrX2RwLT5u
ZWVkX2RlYm91bmNlID0gdHJ1ZTsNCj4gIAl0aW1lcl9zZXR1cCgmbXRrX2RwLT5kZWJvdW5jZV90
aW1lciwgbXRrX2RwX2RlYm91bmNlX3RpbWVyLCAwKTsNCj4gIA0KPiArCWlmIChtdGtfZHAtPmJy
aWRnZS50eXBlID09IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApIHsNCj4gKwkJLyoNCj4gKwkJICog
U2V0IHRoZSBkYXRhIGxhbmVzIHRvIGlkbGUgaW4gY2FzZSB0aGUgYm9vdGxvYWRlcg0KPiBkaWRu
J3QNCj4gKwkJICogcHJvcGVybHkgY2xvc2UgdGhlIGVEUCBwb3J0IHRvIGF2b2lkIHN0YWxscyBh
bmQgdGhlbg0KPiArCQkgKiByZWluaXRpYWxpemUsIHJlc2V0IGFuZCBwb3dlciBvbiB0aGUgQVVY
IGJsb2NrLg0KPiArCQkgKi8NCj4gKwkJbXRrX2RwX3NldF9pZGxlX3BhdHRlcm4obXRrX2RwLCB0
cnVlKTsNCj4gKwkJbXRrX2RwX2luaXRpYWxpemVfYXV4X3NldHRpbmdzKG10a19kcCk7DQo+ICsJ
CW10a19kcF9wb3dlcl9lbmFibGUobXRrX2RwKTsNCj4gKw0KPiArCQkvKg0KPiArCQkgKiBQb3dl
ciBvbiB0aGUgQVVYIHRvIGFsbG93IHJlYWRpbmcgdGhlIEVESUQgZnJvbSBhdXgtDQo+IGJ1czoN
Cj4gKwkJICogcGxlYXNlIG5vdGUgdGhhdCBpdCBpcyBuZWNlc3NhcnkgdG8gY2FsbCBwb3dlciBv
ZmYNCj4gaW4gdGhlDQo+ICsJCSAqIC5kb25lX3Byb2JpbmcoKSBjYWxsYmFjayAobXRrX2RwX2Vk
cF9saW5rX3BhbmVsKSwgYXMNCj4gb25seQ0KPiArCQkgKiB0aGVyZSB3ZSBjYW4gc2FmZWx5IGFz
c3VtZSB0aGF0IHdlIGZpbmlzaGVkIHJlYWRpbmcNCj4gRURJRC4NCj4gKwkJICovDQo+ICsJCW10
a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9UT1BfUFdSX1NUQVRFLA0KPiArCQkJCSAg
IERQX1BXUl9TVEFURV9CQU5ER0FQX1RQTExfTEFORSwNCj4gKwkJCQkgICBEUF9QV1JfU1RBVEVf
TUFTSyk7DQo+ICsNCj4gKwkJcmV0ID0gZGV2bV9vZl9kcF9hdXhfcG9wdWxhdGVfYnVzKCZtdGtf
ZHAtPmF1eCwNCj4gbXRrX2RwX2VkcF9saW5rX3BhbmVsKTsNCj4gKwkJaWYgKHJldCkgew0KPiAr
CQkJLyogLUVOT0RFViB0aGlzIG1lYW5zIHRoYXQgdGhlIHBhbmVsIGlzIG5vdCBvbg0KPiB0aGUg
YXV4LWJ1cyAqLw0KPiArCQkJaWYgKHJldCA9PSAtRU5PREVWKSB7DQo+ICsJCQkJcmV0ID0gbXRr
X2RwX2VkcF9saW5rX3BhbmVsKCZtdGtfZHAtDQo+ID5hdXgpOw0KPiArCQkJCWlmIChyZXQpDQo+
ICsJCQkJCXJldHVybiByZXQ7DQo+ICsJCQl9IGVsc2Ugew0KPiArCQkJCW10a19kcF91cGRhdGVf
Yml0cyhtdGtfZHAsDQo+IE1US19EUF9UT1BfUFdSX1NUQVRFLA0KPiArCQkJCQkJICAgRFBfUFdS
X1NUQVRFX0JBTkRHQVANCj4gX1RQTEwsDQo+ICsJCQkJCQkgICBEUF9QV1JfU1RBVEVfTUFTSyk7
DQo+ICsJCQkJbXRrX2RwX3Bvd2VyX2Rpc2FibGUobXRrX2RwKTsNCj4gKwkJCQlyZXR1cm4gcmV0
Ow0KPiArCQkJfQ0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICAJcG1fcnVudGltZV9lbmFibGUoZGV2
KTsNCj4gIAlwbV9ydW50aW1lX2dldF9zeW5jKGRldik7DQo+ICANCj4gLS0gDQo+IDIuNDAuMQ0K
