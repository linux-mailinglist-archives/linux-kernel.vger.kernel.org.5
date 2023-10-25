Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F027D6468
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJYIDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJYIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:03:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4F137;
        Wed, 25 Oct 2023 01:03:10 -0700 (PDT)
X-UUID: edb1fa50730c11ee8051498923ad61e6-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HISMdSCG9zqD2U1j8vGPJjh+4j+XWuZv8dTE6IxmwGs=;
        b=aJmeElCpFjgbxA0YZG8D4IvDYdLpo/lt+ii2gjvdbElsKhW8GdcOTzYNYpSLAdF+Epn/CefyfvE7y737iDdMVvwuBfO61AqRiOe5FHsJ0BNeDi5k/RLlnsI7UPWOlqzj+soTTVqG/usCGys4R+8S5HqygcPk3bupaEMm8kQrwGE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8ab976b2-1758-4213-b5cf-f847667ff6f2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ab1ae428-cb22-4fa7-8134-287af20ad1fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: edb1fa50730c11ee8051498923ad61e6-20231025
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 850952751; Wed, 25 Oct 2023 16:03:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 16:03:04 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 16:03:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoKj0oxL9sxOzDVC8eG8UiQYObEMlVTUWubFl2Wkl6pCc0k9lsDnzQm9ql6+nD3uUbxPbWLHequOJ/9o1cVlWOdZtZexVO+rbQXbxR4ZLs1hWFWyTPpOvfWmftjzYPHjhC6T0bf3bPQK+7CnHSVaOovWv6eafkxYxrXr4r/sJvAOMATa9o13qs2rED28tPsrj+JZeYqB62Q6NnTr9Kr/0E0LPDQqJpLhneHL64RcPNvIpPufhjnY7sMQkdmLG+NwQVhI6TNm87Q4W2tnrY0+Rimlp9OjiI7lYL2/ufulYYXvmZufLYhdgdzhMAfNpaqSLL5JehGx5UA+4IKRTOKZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HISMdSCG9zqD2U1j8vGPJjh+4j+XWuZv8dTE6IxmwGs=;
 b=HAISvkb9PfI6SHV7/Xyer6CfSgXgz1pP1Ko+GegDCgi/0DkbF9A+/7BLXI9ykir6BenQnmhTW57sUL40oVwF/oKtYfUluMVNhl/fNF3fd8K0t4Ah1P75BbBrsFoZ+khaui/pHsUyRxxdbG5uTA23Cgn6YmAt5YcK/f3EbfphrQztV81VHhkSi8IjT0SOA68XhPAnbLTlJs4AfK4GMEvFiak6yNDmX6+XEuY/lmMyj7VXPXFfSvgXB2iHNgmb0XV1UzeSCstMsKYnFRcf0UkXaaek1Br3tEMOXS3kvay7rwo2DR5uF8vXCp3rF6Kbh2mlSFqMxp+z+K6ZpiU28coGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HISMdSCG9zqD2U1j8vGPJjh+4j+XWuZv8dTE6IxmwGs=;
 b=ldnegJ6CBRs9tKCh5L2DcIwRcArHBho8CQqDAyzTPiZcmmvQf1taI+HmbrerkMfoiAYX/1EbPIfNVz1jF6s1Oaj88BsG32A5K9PU3PaxJ2yd+O1DljWgcS7uQT92UefTTl1j3qL6tgtwRDLAV/xYr9qIZ0osmikVgolQMXxtbog=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5389.apcprd03.prod.outlook.com (2603:1096:400:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:03:02 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 08:03:02 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
Subject: Re: [PATCH v2 08/11] drm/mediatek: Add secure layer config support
 for ovl_adaptor
Thread-Topic: [PATCH v2 08/11] drm/mediatek: Add secure layer config support
 for ovl_adaptor
Thread-Index: AQHaBWvxvNlMHpHXCEGSC/fQRZyPcrBYn9uAgAGIpoA=
Date:   Wed, 25 Oct 2023 08:03:02 +0000
Message-ID: <5d970102fde31ee188ddc0bbc2f5e591f8597238.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-9-jason-jh.lin@mediatek.com>
         <2c757018-f643-4d47-a24c-d0326633a7b4@collabora.com>
In-Reply-To: <2c757018-f643-4d47-a24c-d0326633a7b4@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5389:EE_
x-ms-office365-filtering-correlation-id: a21079e2-81c4-419e-303a-08dbd530cff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +et3yxcrP+polNXuUyBvlBKpW25eQKQLNmulf6bNNnewUbTZEubSFQuSjfBlJFBCaFlOotUpNIXDMMDZuNpRbKXDPoe7HtA1puXRkh9noM8b71/cPVE2lwk1V+09NjIOsW/I4pP1AsPjH9x1dz6tBeZgsO9HIY0qQZXrK6T0Cr74FA2sZiuW7uRIyhRBTCWG7Th/jhrMyfF+BTGBDDmmMVCinaPuiAWhXTtJoaqODxW8IC/RKZH2I52+3UZzcxAfpZ2Lvkexd1HvyKu+ApFpUoglHJ5CmY0F1/x/R+fQesohdGXX07UiqEibGPXOICgzcz7ArIXyuSKPh1qVQ+Ly2UufTjXHpafkjVRg3TIyyRk9zp/qLrOvpXPQX4otHMJcLsvOOVBlqxozXazjNIuJaoocuayddUu944ZxMozbQcqKbRza2FXURe2NzmCZQdFeniUemvn02UHO8GQyq5iVs+j+CjqD8uGO8KR/iAc1ycI3jFOyPbJbF/6RG1OL1s5E6eJ48OhS9tHzNW+x2Iiu9ak6ZGDhiz2a12LdNI6jx1Ncz6NQ+o+awzUQIhG82btUwhDa6gdgDAEGwqFVyMrKLU/alBZtZ574W0SE5sSoxIVWVWJ5NV98GJCh2UAguqe7SFlGqUvZyi13qCBW3FI1RCrOzaiO7+JWiEdzaernJgc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(36756003)(85182001)(86362001)(2906002)(7416002)(4001150100001)(26005)(66556008)(110136005)(66946007)(91956017)(76116006)(2616005)(66446008)(66476007)(64756008)(54906003)(316002)(5660300002)(41300700001)(83380400001)(8676002)(4326008)(8936002)(478600001)(122000001)(6506007)(6486002)(71200400001)(38070700009)(6512007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHgxazd4OW9Lamc4K1ZoNXBiK1Z3Y0hKRmYyYmdYOXpGNnZTWUNMRGNiMzh4?=
 =?utf-8?B?MXc0NmVQVU5yQ2FPaVN5aEphZXFoNURFZEcwZ3kvdzA4aW1BNFFZcGhxWk5Z?=
 =?utf-8?B?UFg2cWxZTVl1RmJFYjk0c2ZNMGVTYnV2RERDV29GSWRwbE5qbmJQbVRGaWF6?=
 =?utf-8?B?WGJlSHZETCtyUWhMUTJNK2IzOGtyQWQycGZ1bU1PSTlhdExCM3JNQ2FNUDNU?=
 =?utf-8?B?a3NzdmNRRjgzZzFUU1RvSVBtMmdtVWpXcTRvVFlOdEF4ZFN3MlE1YTdQY21a?=
 =?utf-8?B?T2NoSHpNTDd0blBCaC9HcW45VThNVkd6ckVYa1ltRDA2d1RSQXNFREJkQWJH?=
 =?utf-8?B?RHpuS2E0ZThMZWpQZ3F4VzlsS3lFcTFoOU54a0FoTHRBM3BBdlFxRldNQm90?=
 =?utf-8?B?MG9BOGZmL1Jpby95N0x1cndsUlU4bU1IbDdXUDBRbnh6ZStNMlh2QzZ4Y2N4?=
 =?utf-8?B?NXB5OGR6d1pCWmF3cWtXeHZ1YTRrOExIajZQREhvSDN0Wmw2a2Q5K1pTUnM0?=
 =?utf-8?B?Sm9hTzFrZUhqMHN0dElJbWRWLzRCUi9HQ0tQVU1FRElEckcrT0RKRkpNL3Ux?=
 =?utf-8?B?ellXSlYwTEFQZnJrcVlDNWdxeVFFNmdETm5xQk5KZk03bkIxeHI4Z3FETGlQ?=
 =?utf-8?B?Nml1N2xWdDNkeWFGWjRYdGZab3hRNHAvak1ScnZyNUFmcjkzNmxXU05aZDdS?=
 =?utf-8?B?L2NZTGNzOGFGOGNkb01yQ3BNMmdkOWh4ek5MZm1LTWNsL0NUcmV3c3dwK1NB?=
 =?utf-8?B?bFdEVjJGZHFxRWZrRCtMR3FNL3F2VkNZUG96SWFsb3ZuMW5IRExDeHBNSHgr?=
 =?utf-8?B?cHZMTXNxV29KNG8rcGtFREE3VDNPdHhGUi9kd3IrV3pjQzVRY3Q0cy8xdXVT?=
 =?utf-8?B?dFh2a0FtZUJnaUdKQkV1cndEU2xlQndIa2pFV1ZGeEVFUGlUTjVrMUhIc3B0?=
 =?utf-8?B?ZlB1T2k5MVVZRXR2cEtUdWZGNnRiT0hRUFVHVEN5Tm5QMmhqWE81UEg5NnNH?=
 =?utf-8?B?WXlMSWVxamF1NXk1L2FJQkVXbmhZSWFqdHNEMXNZa0VQdTVaUnE1SHpJRFN0?=
 =?utf-8?B?bnJPS2lEMWtzWVRhcWVlVGZxaWJpVmJTYnYwTzlLUEJpU3JycHNmOGJST2tQ?=
 =?utf-8?B?L1pSc05sZC9PYXdHZENEQVQySURDUmdUQTE3M2l1U0lEeld4eEUxOEgvdWJU?=
 =?utf-8?B?VHhGQUFXOU5VMHNaaXNzZVliemFObWZ2RW5tbjh3cE85Y09DTkttK25wUnN4?=
 =?utf-8?B?bHhlN0hnSmgwY0FzaFFxVTNsanJ1VHRYeUI3dlYxZUl3ZHBINEJhM3FhWkhw?=
 =?utf-8?B?UTNvMFhCRjZEdUxhYVpBT1FLYlpzTGpQY3VrLzBqSlh5YkJyQnpoUXAxNXlF?=
 =?utf-8?B?L2JNQVNoQ05oelVaTlVuM2sxejZ6b09SVDV2Y0twdXJuMlpRWEJPTGhKcFJD?=
 =?utf-8?B?SUdvQTB3aEFMRDJ2Q0lBai80UkdXakFwMDUraFJuWDRwcTE2NTgrNFdSbkJm?=
 =?utf-8?B?MnBqYXBvMHpKMXY0elVScmFhRXF2K3RCOGZySTNybWtRWVJ1bTc3T2hOaUF1?=
 =?utf-8?B?aXlCMjBIdVcxdS9OUWN6RUl5QlJvTHdsTHFPV1UwYU5RbjBKOGVyVFNOY0Uy?=
 =?utf-8?B?ZENWUzRvQnhkK2tsT0VvaXg4QWowQlMxU3VUOWZjT3ZQOXhJdHpyRmNNd2Z5?=
 =?utf-8?B?bkdoT1dEdEM1WVVVcU1pbEowYTN2OUdnRFlBL2NMa0VxMWUrdHFpKzRzaWU0?=
 =?utf-8?B?UndLNnQyRWNnUjU5WitBVmJFNUJlMGNFMnRrem1RWUNIWUVLUkpYWFp0Rll2?=
 =?utf-8?B?bk9TcE5QZ2RPNDNxWDhUVy90TVJBTzhTRDh6eExheVNPRXNPOCs4YWtvRnJS?=
 =?utf-8?B?UFQ4cWZlR2lTaE1XRkdGQ2dpQjQ0eENhSFhCN1UrRnZLeVV2V2FhSzJ2VGtl?=
 =?utf-8?B?Z1p0SVFYT081Y3RmRWk0MlRoZzRFUmRWYW9tYjF5WVUreFcrTWRUNUYxdXpw?=
 =?utf-8?B?M0VLS1BLa3BpSzFyVml3b0s3TFhGYUVmYTlaZ1VmYm9EUEl5eVQ5NEhlNHM1?=
 =?utf-8?B?cUF3cE5VSmJYK3BXVUd6c0ZUaU84UlBJbW9JbHF4UXZZa1crQjJRclpWdVA2?=
 =?utf-8?B?MDJraVc1NndwdEVEdlVSRlRIaHdPWEZPWGRpenZhbmhKM1dSNXpMTmVKdnRX?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9DC646C6160E349B1D8EFB291777F0B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21079e2-81c4-419e-303a-08dbd530cff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 08:03:02.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpBEWUAUbnhxRZAKFgjhxRHyKbfl597LOBpgRv/iCZMbCp65DeXJSjVnnauy7RMBxHskVSeZqa+eT6J/IYyjvHpNojICZaBnGULjRnUGafk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5389
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBUdWUsIDIwMjMtMTAt
MjQgYXQgMTA6MzcgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAyMy8xMC8yMyAwNjo0NSwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gQWRkIHNlY3Vy
ZSBsYXllciBjb25maWcgc3VwcG9ydCBmb3Igb3ZsX2FkYXB0b3IgYW5kIHN1YiBkcml2ZXINCj4g
PiBtZHBfcmRtYS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29u
LWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyB8ICAzICsrKw0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5jICAgICAgICAgfCAxMSArKysrKysrKy0tLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5oICAgICAgICAgfCAgMiAr
Kw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsX2FkYXB0b3IuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X292bF9hZGFwdG9yLmMNCj4gPiBpbmRleCAyOGEwYmNjZmIwYjkuLjI3NDk2MTIyMjY3MiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0
b3IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRh
cHRvci5jDQo+ID4gQEAgLTE1Myw2ICsxNTMsOSBAQCB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXll
cl9jb25maWcoc3RydWN0IGRldmljZQ0KPiA+ICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ID4g
ICAJcmRtYV9jb25maWcucGl0Y2ggPSBwZW5kaW5nLT5waXRjaDsNCj4gPiAgIAlyZG1hX2NvbmZp
Zy5mbXQgPSBwZW5kaW5nLT5mb3JtYXQ7DQo+ID4gICAJcmRtYV9jb25maWcuY29sb3JfZW5jb2Rp
bmcgPSBwZW5kaW5nLT5jb2xvcl9lbmNvZGluZzsNCj4gPiArCXJkbWFfY29uZmlnLnNvdXJjZV9z
aXplID0gKHBlbmRpbmctPmhlaWdodCAtIDEpICogcGVuZGluZy0NCj4gPiA+cGl0Y2ggKw0KPiA+
ICsJCQkJICBwZW5kaW5nLT53aWR0aCAqIGZtdF9pbmZvLT5jcHBbMF07DQo+ID4gKwlyZG1hX2Nv
bmZpZy5pc19zZWMgPSBzdGF0ZS0+cGVuZGluZy5pc19zZWM7DQo+ID4gICAJbXRrX21kcF9yZG1h
X2NvbmZpZyhyZG1hX2wsICZyZG1hX2NvbmZpZywgY21kcV9wa3QpOw0KPiA+ICAgDQo+ID4gICAJ
aWYgKHVzZV9kdWFsX3BpcGUpIHsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19tZHBfcmRtYS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X21kcF9yZG1hLmMNCj4gPiBpbmRleCBjM2FkYWVlZmQ1NTEuLjFjNDc5OGUzYmJjMyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMNCj4gPiBAQCAtOTQs
NiArOTQsNyBAQCBzdHJ1Y3QgbXRrX21kcF9yZG1hIHsNCj4gPiAgIAl2b2lkIF9faW9tZW0JCSpy
ZWdzOw0KPiA+ICAgCXN0cnVjdCBjbGsJCSpjbGs7DQo+ID4gICAJc3RydWN0IGNtZHFfY2xpZW50
X3JlZwljbWRxX3JlZzsNCj4gPiArCXJlc291cmNlX3NpemVfdAkJcmVnc19wYTsNCj4gPiAgIH07
DQo+ID4gICANCj4gPiAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgcmRtYV9mbXRfY29udmVydCh1bnNp
Z25lZCBpbnQgZm10KQ0KPiA+IEBAIC0xOTgsOSArMTk5LDEyIEBAIHZvaWQgbXRrX21kcF9yZG1h
X2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gc3RydWN0IG10a19tZHBfcmRtYV9jZmcg
KmNmZywNCj4gPiAgIAllbHNlDQo+ID4gICAJCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwg
MCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LQ0KPiA+ID5yZWdzLA0KPiA+ICAgCQkJCSAgIE1EUF9S
RE1BX1NSQ19DT04sIEZMRF9PVVRQVVRfQVJHQik7DQo+ID4gLQ0KPiA+IC0JbXRrX2RkcF93cml0
ZV9tYXNrKGNtZHFfcGt0LCBjZmctPmFkZHIwLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtDQo+ID4g
PnJlZ3MsDQo+ID4gLQkJCSAgIE1EUF9SRE1BX1NSQ19CQVNFXzAsIEZMRF9TUkNfQkFTRV8wKTsN
Cj4gPiArCWlmIChjZmctPmlzX3NlYykNCj4gPiArCQltdGtfZGRwX3NlY193cml0ZShjbWRxX3Br
dCwgcHJpdi0+cmVnc19wYSArDQo+ID4gTURQX1JETUFfU1JDX0JBU0VfMCwNCj4gPiArCQkJCSAg
Y2ZnLT5hZGRyMCwgQ01EUV9JV0NfSF8yX01WQSwgMCwgY2ZnLQ0KPiA+ID5zb3VyY2Vfc2l6ZSwg
MCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBjZmct
PmFkZHIwLCAmcHJpdi0NCj4gPiA+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ID4gKwkJCQkgICBN
RFBfUkRNQV9TUkNfQkFTRV8wLA0KPiA+IEZMRF9TUkNfQkFTRV8wKTsNCj4gPiAgIA0KPiA+ICAg
CW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgc3JjX3BpdGNoX3ksICZwcml2LT5jbWRxX3Jl
ZywNCj4gPiBwcml2LT5yZWdzLA0KPiA+ICAgCQkJICAgTURQX1JETUFfTUZfQktHRF9TSVpFX0lO
X0JZVEUsDQo+ID4gRkxEX01GX0JLR0RfV0IpOw0KPiA+IEBAIC0yODUsNiArMjg5LDcgQEAgc3Rh
dGljIGludCBtdGtfbWRwX3JkbWFfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgIA0KPiA+ICAgCXJlcyA9IHBsYXRm
b3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gKwlwcml2LT5y
ZWdzX3BhID0gcmVzLT5zdGFydDsNCj4gPiAgIAlwcml2LT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jl
c291cmNlKGRldiwgcmVzKTsNCj4gPiAgIAlpZiAoSVNfRVJSKHByaXYtPnJlZ3MpKSB7DQo+ID4g
ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGlvcmVtYXAgcmRtYVxuIik7DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuaA0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5oDQo+ID4gaW5kZXggOTk0M2VlM2Fh
YzMxLi45YWRkMThlOTYzMTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19tZHBfcmRtYS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19tZHBfcmRtYS5oDQo+ID4gQEAgLTE1LDYgKzE1LDggQEAgc3RydWN0IG10a19tZHBfcmRtYV9j
Zmcgew0KPiA+ICAgCXVuc2lnbmVkIGludAl5X3RvcDsNCj4gPiAgIAlpbnQJCWZtdDsNCj4gPiAg
IAlpbnQJCWNvbG9yX2VuY29kaW5nOw0KPiA+ICsJdW5zaWduZWQgaW50CXNvdXJjZV9zaXplOw0K
PiA+ICsJdW5zaWduZWQgaW50CWlzX3NlYzsNCj4gDQo+IGlzX3NlY3VyZSBsb29rcyBiZXR0ZXIu
DQo+IA0KDQpPSywgSSdsbCBjaGFuZ2UgaXQuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0K
PiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gICAjZW5kaWYg
Ly8gX19NVEtfTURQX1JETUFfSF9fDQo+IA0KPiANCg==
