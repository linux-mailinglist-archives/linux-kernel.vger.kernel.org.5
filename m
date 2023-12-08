Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74172809908
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572980AbjLHCK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHCKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:10:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E574D53;
        Thu,  7 Dec 2023 18:10:23 -0800 (PST)
X-UUID: ef2792c6956e11eea5db2bebc7c28f94-20231208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PXSCtpKl1ZTM4Ovy3wSv44onk/HQRdRMK/MBdjljVvM=;
        b=p33n2z+97ow6CT05lJd3/H2z+nVxZ1iTmT6NRFgjJW8ctyQa6ZfLiJqR6VIxBC+MfepZLBiyy34uRva2QXE0pwiFsw0D+pjDhq6XWTlZ1JwxZqNWq+iANEi8cLpOaLtJYB3+VM4Nj/tsWP8+dKtG/EMncbHvJb0Ewm/Y/9qBZfU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9b7e1e92-7424-4a63-a329-189efd8860db,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:12fd6bfd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: ef2792c6956e11eea5db2bebc7c28f94-20231208
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <zhi.mao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 879257279; Fri, 08 Dec 2023 10:10:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Dec 2023 10:10:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Dec 2023 10:10:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeOOq9RfTQh+vsvnUIC5DcB2uhb12KyPE6g7bc8ng1rV8oR3NnQgh7Tya/3q88pjQvLlGOk+mHTJR31BcZyVCrgSM3sF8Zq8iEadnrdicEkWeFuVQHhJM1ZH918O2D0GTwtlG5cmKXZzQPYK8RtqtQ6UsMONiBKivkRWkyfLQ2C+onlccwnTgoffGMHSxUe70IowDvvSqlQ+Dm3tLOEMPDWJWz5tiSgpMrN99m9r/zLP8cVZdSH08HvKNXd1wTZH5L4+/xswgZrwLrpGUdhBwiKS6hCmEMU6sxDwqiBrMPt/uAim9eQ7PVj9ynMb3PROyvjz0eyL5976+MGOZV7F+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXSCtpKl1ZTM4Ovy3wSv44onk/HQRdRMK/MBdjljVvM=;
 b=dEyuxEiafCaTCzu5FvlB4huGA3zomDlwB2jj+34T76bPXNna6fMsVqdRmQjBOMrn+gfRsshOteosEGyixWxQ2afQhF/qZK5/2eFgcORccU2O8zlXP91AQ0P+esPjVWvvZi0xAfQmgNDfIJkM0iBRuNUUD365BYXqcotGucwCeW+7i/4NesVGMFKGP4ZRh1b3vOUgJV7G1jRY6hqW4q/q7TUILMKGZSoj7mt+XKB9qE77l8Z2v+27Glk14V+PNGryDiEjSlVpU2pdjcB0LAauBl11pz84KhQkTBHAX77nJQAkejPDaWsJ+dHTswXbecrd0rjqtPTQhSl+2g7BC8ogEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXSCtpKl1ZTM4Ovy3wSv44onk/HQRdRMK/MBdjljVvM=;
 b=sWLJvIDY3ygg2YgWvYhyLybLKTl7Rh/KyCxfnXm7u3Hs9/CK4Yd5eYXgao8l5oKYhQvzdbWo1D86GR8GR+JQOswmq0re5Gtn1Jk/Mz28W+17IRD/ky1mo5PAZlMRgMmTpN9Dpv4ancpdiqA9pL0a3H6X/+enJFqrVOyVG0ODMyY=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by SI2PR03MB6639.apcprd03.prod.outlook.com (2603:1096:4:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Fri, 8 Dec
 2023 02:07:37 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ccc5:b092:efbe:6134]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ccc5:b092:efbe:6134%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 02:07:36 +0000
From:   =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To:     "conor@kernel.org" <conor@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "heiko@sntech.de" <heiko@sntech.de>,
        "tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yunkec@chromium.org" <yunkec@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
        "gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
        =?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?= 
        <shengnan.wang@mediatek.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        =?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= 
        <Yaya.Chang@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "bingbu.cao@intel.com" <bingbu.cao@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "10572168@qq.com" <10572168@qq.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaKM07MRhkqnzY9kyFxe9G5PmOILCdsPSAgAAPy4CAAFe4AIAAjIwA
Date:   Fri, 8 Dec 2023 02:07:36 +0000
Message-ID: <0580bc5be77c5e293770f42b661a41c80e1986dd.camel@mediatek.com>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
         <20231207052016.25954-2-zhi.mao@mediatek.com>
         <ZXGtqwjYruBQVaUr@kekkonen.localdomain>
         <129e3a8b-5e91-424a-8ff8-b015d5175f1a@linaro.org>
         <20231207-outcome-acclaim-d179c8c07fff@spud>
In-Reply-To: <20231207-outcome-acclaim-d179c8c07fff@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|SI2PR03MB6639:EE_
x-ms-office365-filtering-correlation-id: 61a0fa76-5f55-41c0-dae4-08dbf79272f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDYT5dvl++t4mEmzcPfO1a6XtO9jITXCRjJlm1lPnAeh6d5F2SbrUqsNq3/y16v20FPBtjnhWNyy17skNp7LmeZuTbQXkj58BPqN1qS8vLbvItUw3GtmX2LQN9IZDvzJLp5jXs4Jzj+e5w1lKbrklSW32B0lW3EO41r8jdy4d6D6W918UbuokYachjltAkBY++qIxJMlcLJpiRqfYvXSpcvGFr5rRRX2gMExXWW2a/jn8r/58q0hh2w+0L28fUvy7xuNzsOxATHemuWq8qUwtab3IsoYtS0nTGjDzKuYZOX76o2071S7Tv4sKBIW7qBBseVQIrdDuZvaiiV94l1PzdyF4ifq/g6sPeBjLqGu2rLHM+8ksKbczzA7tWU/1fAvbDBpe7cV5aLvTEjDT/oRIZYNbt1ZkRQ9d1vlIdv0KOLVJ+fBVkB/vy0FkmtcK6wMofjLpoNSqG2BXdcE0kIG/K8oQxJBr23b+okrNzPsi+zvCWCBenMlkGUFzBdhOoIhqS0VNIERUol48QIgeQ8eaUx/w7vsSwjM3F/W8gI27lHuHDUH9r3PJa44A+mh0kBfGI+0yfUagj+AHx5UilUCmHnYVsXl08iFKSi8tbwsOzKgrhv4phLwuBDuFFxA3S1jAXS32vB//yCj80C//Q9qNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(122000001)(38100700002)(36756003)(86362001)(38070700009)(85182001)(66446008)(8936002)(66556008)(66476007)(110136005)(76116006)(64756008)(316002)(54906003)(91956017)(4326008)(5660300002)(7416002)(2906002)(966005)(66946007)(2616005)(6506007)(6512007)(26005)(53546011)(8676002)(71200400001)(41300700001)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGtkankweHA4SUdtZFF6dEI4RE1vSEJYUFVsVFdHZjVEQXR1ZndObmpCbSth?=
 =?utf-8?B?aE9haEs2L09NVXN1dnpRdjN1WDJZMTdFTmlCejRrTnc5b1d2MmV4NTUyRVMr?=
 =?utf-8?B?M2VqdDdOM1BaY1dLZVZUTlNLV1RXSndlTHphSUwrbFNkL051akh5S2x2Ujc5?=
 =?utf-8?B?UUp5ZHkvK0RyTkZUekI5ZnRJWmppbVhIZnRWeVpZSkNmRHhiZ3hzNS9BQUJ2?=
 =?utf-8?B?RzI1cFBLZmZpREJSaDk4R2xVQmhZMEhYS1pLbmY4NWZCVXpMMGxtR3B2Mitl?=
 =?utf-8?B?VGJWRGU2TVlQQnJ4V3BCZkt3OVFtNlIyYkxJTXhIcjVrSGpDekE5d2V4M1Zo?=
 =?utf-8?B?THFXTEo2RWRhTXpQdG1KYmVRdndpUC9lRVpaNUJhYlRHNTUxWWMvbGxoMDZH?=
 =?utf-8?B?bC9pS2tweCtad213QUhMQjgxVTBBM01SNnIxcEF2SVhGZkE2TzlTcjNUSjhv?=
 =?utf-8?B?dVptdloxM1BxWk5rSnNnK3RVTlBCRENSeHFnZnY1SGZPSC85VzZrM0VWRmR4?=
 =?utf-8?B?Q2tCNTBUYWpKRVBiMXN1eVpQeFF4Mlp5S0FCQTRjUlF3MXk3bXlVQlNFWndQ?=
 =?utf-8?B?a2hmdDVGUXJLNld4Yy81L0o3MFRRZHVrOXZ2WXo0NEVXV3RPY2dGVURSaGdm?=
 =?utf-8?B?WG4yY2NGaG5RalorQzZ2K0lMZDR3UnIvRUQrQVJXdzQ3YWZSRHpoTDZ1eDlS?=
 =?utf-8?B?bkJwa2FUd1Y2SUl5QVpBcG53Y1VKTmh0VXVTdzA4WG9Pb243Y1daZzJwUko5?=
 =?utf-8?B?Ull2RjhCS2RhalNibklKMFVVaXEwR2lZK2NjSFFYUE1ZNVdjTUhZWjVHWFhI?=
 =?utf-8?B?VGhsOThhVXZ3WTUxTW9rclFmUG03NGJ5aGEvUi9Ca2NwYjNCWWEwYUd4eVh6?=
 =?utf-8?B?eXBxc0ozMkhrMnpnYnowV1phQmp3aDlDRjg0Z0lhL2MxZHJPMDk4alk2WVJK?=
 =?utf-8?B?aFJ5dC9TZ3U4b2dPVTgrc3FqVXR1MEtCdll3V3Y4L011QzVSZ3lRSUhWSmhZ?=
 =?utf-8?B?dDVXcXRjQnhhSlJLb3l3bjRTd04ydkNQWVFzQW05TVJUL3pXR3JxTHNFcXNT?=
 =?utf-8?B?aithenEyS0NXenM3NG4yc2QwTlFmSnF5TmZMS1FHNkVkM2srMVU0WlRHelk4?=
 =?utf-8?B?TG9HQk1haC9QZUh1YWIrWGxNWW90Qmlrb3E2ZlgzdTNVYUVoOEhTc2NzNklV?=
 =?utf-8?B?Nzl3aEpuTzZmYXhGSm54WHoxYlY5c0k0enhpT0Z0Y2pZNUhzb2h1Q3NSNDAw?=
 =?utf-8?B?VnR1aTVVMEVnMk9CUit0MVI0cFZQS3h2WnVISmxONVg3SVFKK3Z1c00zQ2tV?=
 =?utf-8?B?VjZZc3NaQkc1OXNPUGV6VWdPUkJxL0k0bGF6TUhBV1k0NWtLdXp3dnVBUGhO?=
 =?utf-8?B?T05IY1RWa3BVRXlkcEJLT3k2THFFc1NQUURTVTBDaHZScGxvS3JoR2NodnFG?=
 =?utf-8?B?eU96eFZRSk5FSm5tU0tmY1oxTWVyTmN2T2RiOTQrajRIRCtvQVlhNDMxeUtF?=
 =?utf-8?B?d3dwT001MjZzSzBvSnVnSEcvUVdvN2l3UFNnWXVPR1hsM2crWXRtZStlTHJx?=
 =?utf-8?B?VGh5TEZ5NElZc3hiRVlSVFo1Z1FVeHNCQmF6UElKMzRsSW5JaEdsTHA4c0x6?=
 =?utf-8?B?TDgyWkhJZUI1MUh3TFJIaE95aldVdzJOc2NGN1RMa2JEOGZqV2VsN01FU2Rs?=
 =?utf-8?B?UGJaQWRtaFFPL3hkd1I4b1I0MC9CNHJicUI4UHE4bE9aSFhHSEJpcnVhSmZo?=
 =?utf-8?B?NHB1VEpCbTFISFAzTy9teStuajU3MC82MEVpTFdzTXJDWEN6bEsxc0w4YXI4?=
 =?utf-8?B?TkZyV2RNM3h0SUs3d1N2bGoySDRCdUhaY0dMRUp2dnJ1cFNGQno1Y3RJNXZX?=
 =?utf-8?B?bnpBV0xCUk9pN0RVaWJRVDlYQjVLeExXd0QrTVV5WTVOUElzQm81YUNYT2R3?=
 =?utf-8?B?K2U0djREK3lMU2V2YWE2azJhVkR0ZTkzUzYrUUJWZFFMSTlUVzdxK0lGWmJB?=
 =?utf-8?B?RzZUTzhERSt6amRNSXBOM3FKdXVyZHVFNWJHOUI0NHNYTlozT2FCR0FTc1Vz?=
 =?utf-8?B?SERMa0RwNitZL2NVcnNtTzhQVFRreDRSMWUyRCt5RkJWbE0ySWc3b2JrSjFi?=
 =?utf-8?B?MkIxU3pxTE1CaDhZWUlnSEg0VGdxenNVMWtJRXFuZVNwZ1VCTDU1dzYxWW4y?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58E9CCA80E09694095081CE335F8091D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a0fa76-5f55-41c0-dae4-08dbf79272f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 02:07:36.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoZx0MqIRrYEplQbCvgP0rw4fMZxo2jBYzd4LAhf12g9hzMLSTlcGvymhCUMUwnxNuFLb7S+fS/6D9blgmYmuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6639
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDE3OjQ0ICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFRodSwgRGVjIDA3LCAyMDIzIGF0IDAxOjMwOjM1UE0gKzAxMDAsIEtyenlzenRvZiBLb3ps
b3dza2kgd3JvdGU6DQo+ID4gT24gMDcvMTIvMjAyMyAxMjozNCwgU2FrYXJpIEFpbHVzIHdyb3Rl
Og0KPiA+ID4gPiArCXJldCA9IGdjMDhhM19wYXJzZV9md25vZGUoZGV2KTsNCj4gPiA+ID4gKwlp
ZiAocmV0KQ0KPiA+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJZ2Mw
OGEzID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpnYzA4YTMpLA0KPiA+ID4gPiBHRlBfS0VS
TkVMKTsNCj4gPiA+ID4gKwlpZiAoIWdjMDhhMykNCj4gPiA+ID4gKwkJcmV0dXJuIC1FTk9NRU07
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlnYzA4YTMtPmRldiA9IGRldjsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArCWdjMDhhMy0+eGNsayA9IGRldm1fY2xrX2dldChkZXYsIE5VTEwpOw0KPiA+ID4gPiAr
CWlmIChJU19FUlIoZ2MwOGEzLT54Y2xrKSkNCj4gPiA+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCBQVFJfRVJSKGdjMDhhMy0NCj4gPiA+ID4gPnhjbGspLA0KPiA+ID4gPiArCQkJCQkg
ImZhaWxlZCB0byBnZXQNCj4gPiA+ID4geGNsa1xuIik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwly
ZXQgPSBjbGtfc2V0X3JhdGUoZ2MwOGEzLT54Y2xrLA0KPiA+ID4gPiBHQzA4QTNfREVGQVVMVF9D
TEtfRlJFUSk7DQo+ID4gPiANCj4gPiA+IFBsZWFzZSBzZWU6DQo+ID4gPiA8VVJMOg0KPiA+ID4g
aHR0cHM6Ly9odmVya3VpbC5ob21lLnhzNGFsbC5ubC9zcGVjL2RyaXZlci1hcGkvY2FtZXJhLXNl
bnNvci5odG1sI2RldmljZXRyZWU+DQo+ID4gPiA7Lg0KPiA+IA0KPiA+IA0KPiA+IE9oLCB0aGF0
J3MgY29vbCBpdCB3YXMgZG9jdW1lbnRlZCENCj4gPiANCj4gPiBUaGUgY2Fub25pY2FsIGxpbmsg
d291bGQgYmU6DQo+ID4gDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9k
cml2ZXItYXBpL21lZGlhL2NhbWVyYS1zZW5zb3IuaHRtbCNkZXZpY2V0cmVlDQo+IA0KPiBJIGJl
bGlldmUgdGhpcyBpcyB0aGF0IGFuc3dlciB0byB0aGUgIndoeSBhcmUgdGhlc2UgbmVlZGVkIiB0
aGF0IEkNCj4gYXNrZWQNCj4gb24gdGhlIHByZXZpb3VzIHZlcnNpb24gYW5kIG5ldmVyIGdvdCBh
IHJlc3BvbnNlIHRvLiBJbnN0ZWFkLCB0aGV5DQo+IHdlcmUNCj4ganVzdCByZW1vdmVkIGZyb20g
dGhlIGJpbmRpbmcgZXRjLg0KDQpBYm91dCAiYXNzaWduZWQtY2xvY2tzIiAmICJhc3NpZ25lZC1j
bG9jay1yYXRlcyIgaW4gdjEgcGF0Y2gsIGFzIHRoZXkNCmFyZSBub3QgdXNlZCBpbiBzZW5zb3Ig
ZHJpdmVyLCBJIGhhdmUgcmVtb3ZlZCB0aGVtIGluIHNlbnNvciBkdHMtDQpiaW5kaW5kIGZpbGUu
IEFuZCAiY2xvY2stbmFtZXMiICYgImNsb2NrLWZyZXF1ZW5jeSIgYXJlIGFsc28gdGhlIHNhbWUs
DQp0aGV5IHdpbGwgYmUgcmVtb3ZlZCBpbiBuZXh0IHZlcnNpb24uDQoNCg==
