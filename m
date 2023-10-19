Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B467CF3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbjJSJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJSJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:20:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EBC98;
        Thu, 19 Oct 2023 02:20:32 -0700 (PDT)
X-UUID: bd3389f86e6011eea33bb35ae8d461a2-20231019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+TjosOBSSZGg5AO0HMIpZ5VIMtzN34COkARDMguF//Q=;
        b=HkLMG8ns1QDllg0MmZ2pOMZQ0eUG1nLl1gTUKqQzQ9NzCTPpbh4F+r/X0G/1HBqe4FxfsUlchACo7gLFvmm0neCc1wUFOAp7vIbCjkk9QY9XHh9mge1iID0CIw8nTioUKPJnMgVW7XfqEyijOHP92EJ9Sh5DT6KVLu7X/YMbitU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:fb047467-f04b-463a-b1f5-6d45d9662d9d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:59e41ec0-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bd3389f86e6011eea33bb35ae8d461a2-20231019
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1476254810; Thu, 19 Oct 2023 17:20:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Oct 2023 17:20:24 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Oct 2023 17:20:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbvRBNiyyqCHxbndCdaD918g/9rmHT24Y9gDcs5PZtfWkvt7yltTTMMJaxhiH57gMU981MhaDJaK1uB+W7fLMKyyyTnBeUL1WNKbFWYtR0Gt5xUAmXmtEDdkb2mxCRo0Hc0iUwWvA1OYOvDOQYfShpItrQ6nqeZoZOk67fTpy4s3OTZ407ONXz1/Uqw6nvyJpTUfobXvmTLia4toAYgH9xImcJmedrc9NzAxJfsn2lKfW07PKN0l7g0PtDGxiS7fkwvMQ7nKgHFKqRWmp/8QuXdXJNmY7sJzhANjANcJSRZRTpRiiasOucUPJ93GGpREGUMEtq0K9lkvLpfSO0DEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TjosOBSSZGg5AO0HMIpZ5VIMtzN34COkARDMguF//Q=;
 b=ocZ+slsq2CH2I3V3BasEZsSDDlfXfmp34ZwAoJ7Zx+c7ENtKtXVqSr7cLZesNHzTVwS13yLfN4NS4T05eZ98Ph9+WM3mtodus/PDdJAZrKCBmcYwQUczRSlVEeaTbnInoB1RYbh/38YaC78zsttZRfv6r/VDnmZ/Pz2gf9G31ORDXETG7fC/Ek/O7HEfZp1i2CfYGmevRPsht2UqXSJV/0WrV8+JUpmUbnqJPvkx8aKwxrBeVkBhr2pzJeYlfoEX1yl6TO79rFz7of2xSgiIAfE511x7slTIfn3zP5ylTwtNmelGOAY4sDEUF7i2Ruci7Qfb36BixPB3TtkxgP9q+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TjosOBSSZGg5AO0HMIpZ5VIMtzN34COkARDMguF//Q=;
 b=McUlW7h4tBJZYrWUHidIYTf1nNjLlJ0Yg0rbZpY1fzrTEDlLD64SFB7XgITqFX2Ig2CjVt7qevQi3Y5P1ZHxQsS8CwIlmSU9P9/IvS3/XIhMBrcsNQ5CLvuRdMxVXqMs2Q+Hk2Z0pBLn2C2f+VhKLm9M2F9tAkb0KJMN9pIFoiQ=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by PSAPR03MB5270.apcprd03.prod.outlook.com (2603:1096:301:47::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 09:20:22 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:20:22 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v10 20/24] drm/mediatek: Add Padding to OVL adaptor
Thread-Topic: [PATCH v10 20/24] drm/mediatek: Add Padding to OVL adaptor
Thread-Index: AQHaAlEpIYYc1XC6tkSPO2BtlpGtkLBQ03mAgAAC24A=
Date:   Thu, 19 Oct 2023 09:20:22 +0000
Message-ID: <9939f8f5fbc2fcc469db212cf53fd3be0231384f.camel@mediatek.com>
References: <20231019055619.19358-1-shawn.sung@mediatek.com>
         <20231019055619.19358-21-shawn.sung@mediatek.com>
         <0a3b0755-73e3-4698-9a3a-be38578ceb3f@collabora.com>
In-Reply-To: <0a3b0755-73e3-4698-9a3a-be38578ceb3f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|PSAPR03MB5270:EE_
x-ms-office365-filtering-correlation-id: bc57b62e-7831-4da0-d23e-08dbd0849ecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJuoF9gCu3WJ+okJRJwz840LrXaQHzg/+nKJ3xC9VSDSYlxHZSyUPAwRH+SxpEe8QF2YJEZB1FU5mh0yCSlrxCM0FXEPYvd0ClxPScSuGN0VodGol/OqIcXMo+9P/hHkBy+1HKTUBR7Wxw1nSGkqsDmIpo7h7uTtKGs8Zq26Re+2FxMZ15WXqcHf0JponSsRnwyXRQli0+xCvn/KPRXQI28Tp5LoEiokYwCV4LTS7PzwsIZeRhAcDSuRXg/CP/jigYBWMKAjcRRGpDQVcOaeckqXcC35BE117zvbe+BV3Ea17TR1qyFEAI1HWRcv6ffDUju3e+Tz60RhOTgHpvPYlO/3+Ol+A7j7pQsfSlyEDtmCYVmj8AHlJFcgG7dJjcio0TJ60GYRU9EU6jk4kuTo8bhVcg7LN5x2IOexr7pO6qi9IWZTfo8DoRoYfPb1ALV2+Siq8ehLup/F/eBOHd/5gaqjfjDyvmxujS40M/SqKa6Qh2KoZjFeNyI/IsCy//vpvjCB2nfW+yElgSIhKw9BakDfHtWfkPfjt5CI/D57n8+ZBMUhf3OUrzJQ6hhmF+sCeP8yHorMgGUNM4euDNcF4vQD0dNU/vKJRz3XBOMOqWrZF8FY1+pSCmLNEtHDL4yUOgVLooEHZl5acE7DxnE9filyHzFU98hA0ZEQ3kvdNi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2616005)(7416002)(6512007)(6506007)(2906002)(4001150100001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(64756008)(54906003)(66446008)(66556008)(66476007)(66946007)(76116006)(110136005)(316002)(6486002)(478600001)(36756003)(71200400001)(38100700002)(83380400001)(26005)(85182001)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUJucTUwSWwxWkNOdk5uaFYwUUdkaUhoQy9UZE1mR3UybW92MWI4REhVOXJH?=
 =?utf-8?B?WVZNZkxLQWtuUjVsMHlWanU4MENXMi8zQnRDNC83VDRjWnl0VmhXQkxwc1N3?=
 =?utf-8?B?S0ZtVzhBMnJsMW5xY0Q1dDUrMlcrTUFVTExJaWNRVm9FaUNzcmQya3NualBp?=
 =?utf-8?B?U1QxNmhVZWpFcVBjUFFSeHU5MlBnclVwQ2w5V0Jra0lSWFpuelE0WittWHQ3?=
 =?utf-8?B?THNQamRtS2hUWkxBZVJzemdtNkN6eTc0bml6K05CVVJNbkFKcmRFQ1g5NzFS?=
 =?utf-8?B?d3FLSXFDVmpDbzl1UkZid2h2eG90R25QYmdtMExlTDAwaGMvcnpwZW5Ub25z?=
 =?utf-8?B?SjlHNHhlTDMzSFZoRjdFYjBVSWExbk93Lys1ajJOK1FranBDWVhkZnJKc09n?=
 =?utf-8?B?NUtoWlk5dUJFNE5PaTJwMlZBNHg5RDBwT3Q5NVY3NmROYWp4TGpLb0xKc2Q0?=
 =?utf-8?B?bjlEY1NQMm1iNlBwTTNDWjB3SklMOGFkYjdUNE5BV3lnTnpxaTE5alpkbzhT?=
 =?utf-8?B?MDlBVUMvb2dNMCtycGIreFRTS2dSUjhKVXBjaXZRQlZwaGl4eGpzUFYyWVFH?=
 =?utf-8?B?eHk4a2YrK0taRHNqSFZROS9BTmtGbnd3UnRIczRvQlhTVkNVT2NsS2pLU2RP?=
 =?utf-8?B?RHdHbVgvWXVnLzdTK2hacGRkMzF0YmwyV2J3VzM0MHowWUsvWGZsTDFRVjUr?=
 =?utf-8?B?M2dSWm1LL2tBWmJpc1V4N1Rkb2VOTFREUnVBTmdkU3dxV0FWSjJzOVlDVHlF?=
 =?utf-8?B?TTJUWTlSWE5SQ1hMZmRuVHNaT2tUU21mM25LSUd4cG0zSjMvOG9MVWhuOXFh?=
 =?utf-8?B?WmoweFowUDgzT1RWYzBITG1IQXNlVHc2U0hpenBzNm00Sm9zYW9nR1RyQTI4?=
 =?utf-8?B?dFpXU3h2dFJjWHVtdzhtUEIrMWFGa3J5WFErM0x3aTR2S2ZCTTQ0R2ZhWlV3?=
 =?utf-8?B?TG92VURBTHdaOEJYeFQ3NzVVaEgzZkZuejk5dytuR3V0d2Jhd3NUZXp6UllD?=
 =?utf-8?B?UE5DemloaGJwWHpQOCtwRFdtdk16aHBsakFocDJoWjAyZlFJS3NiZ0M4amdq?=
 =?utf-8?B?WjErUzdhcDNrWU9RYmtlWDVldFE1M0syRis1Q1RsMTgwK1F3SXM2TGhMaVF1?=
 =?utf-8?B?WkVzWW5wRTlDQ1RCZEsvL1JWSGFrZUlySnhocnc5NXRDdnVCOHg3bU1PYi9j?=
 =?utf-8?B?VFFEQTVNZHlCNjJUMzRXZi9FbTVJNzNDMzZQRnVaOVU1UXp3NTNWdkRlRWNm?=
 =?utf-8?B?c29VZ2IydnExY1dhcWZXN0xVQjRaSkFFOWhuMTVBeFVHNnZlUlpQSmErVUh1?=
 =?utf-8?B?V2ZPb0k4TzlyWmM5N0R5V2pIU3doVml2VkdrbmNTbW9mUjZjMVJEODN4TFow?=
 =?utf-8?B?aEFkcm1tKzgvdDNUZGFjZEU4bmtSakx6RUl4ajlYMnplVlNBS0VqS21mTk9C?=
 =?utf-8?B?TEdiVHZnbXJkbW9WL0xSMEZIc2F5OXkrUlcyOVk0Q01XQlZzTFlFeWZ6dnhk?=
 =?utf-8?B?Y0RUT1NvMitUdUNCT05vekdiN2VlYUZ3QWRsSVRCM0lodkdjY0tDZm1kcGNH?=
 =?utf-8?B?NWw5TmIrdlRIY1JYYmwyeTBFd3FtdWd6Mzd6YUZuSmQ1MWYxbmliVU1qNE91?=
 =?utf-8?B?RkdRL09SVjBsdmhOQVc0anlSeFpMM2VtK243dS95OUlUaU5oWlg0SFA4YXNp?=
 =?utf-8?B?NGc1K0NNRW41MHdIbTRXYllwZ282VUp5Rkd5YWladVIwTXFxcVpYRHRtaWFr?=
 =?utf-8?B?WkNZWDhPbGJvQ2RNUzQrNGdHTGVXMndzMjlaaEJqN081YzV3OFJLWVBWbHRh?=
 =?utf-8?B?eVdQOFl3Y2pzQk5MZlpUNGhOWnQzNitSTXhxOEE5SCtLZ1dWWXNKanBsWDA3?=
 =?utf-8?B?ZGtRRGZCMUxWcy9iNE1IbEZwOVp6RFhnUUU5V2Z5QkUranpqbFJwb2J2ZlB2?=
 =?utf-8?B?N1YzMUF0WlBOcGNEb2sxS3FmV285VWkzdHJXc0p2R2lXVVllTHJ5akJZemVa?=
 =?utf-8?B?ZjNKV0lZY24wZXlVTjEwcU5waVdJKzZsVGZZQ2NQNzVLUTVNU3NvdXVUUW9U?=
 =?utf-8?B?WC9iYkdtaUY1TUZ3MjhIQWNTbnVTRDhvTk80c1Z4bEhEbzFyMkxnZ3JRUjBa?=
 =?utf-8?B?WVl4d0c2V1hYVUNEK3J6OFR0STlhc1g2SVl4cWNBZHExZWhOOGNBVUQ1MnB2?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90CF03D4C1B8E44BAE5D88C6BE3AB540@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc57b62e-7831-4da0-d23e-08dbd0849ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 09:20:22.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaSgmIn85g3QXj5Jn8jAy6j5LVFlOvujlyqoMjnTKCnfzWMIpY8AWMhAoopqKANjagXcyRUl/b6R4QIUhtFPXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5270
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.751500-8.000000
X-TMASE-MatchedRID: qEAy/z09Hq3UL3YCMmnG4kD6z8N1m1ALjLOy13Cgb4+e9toQ6h6LE5Jo
        t8xOxyL5rh+zMWslzRSx2JNhrMY3WxFLmwxEoXDzF6z9HGHKwNu1k3bRIdXVNNE7QwDOCDQvOl8
        PxvMm3b4G/oMJcCA8UsryHmYBFZ7RXSTr2nYJDfiJLx4p0P/u5Li8G4TZfQeVoN1ZeaPfSbijxY
        yRBa/qJRVHsNBZf9aRPcCXjNqUmkUgBwKKRHe+r4wbE57JZoxs4vlJr9MKHDnAh3fIqP1G0Bi4L
        mclravfqzl5+FSlsxk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.751500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 57E8F2D930F84FD925F3FDE7E48405F6CEA74278777AD3D44056CEC6DA88E9D52000:8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjMtMTAtMTkgYXQgMTE6MTAgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOiAgDQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBtdGtfb3ZsX2FkYXB0b3JfY29tcF9kdF9pZHNbXSA9DQo+ID4gew0KPiA+ICsJ
eyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtcGFkZGluZyIsIC5kYXRhID0gKHZvaWQN
Cj4gPiAqKU9WTF9BREFQVE9SX1RZUEVfUEFERElORyB9LA0KPiANCj4gVWhtLCBmb3IgY29uc2lz
dGVuY3kgSSdkIGNhbGwgdGhpcyAibWVkaWF0ZWssbXQ4MTg4LWRpc3AtcGFkZGluZyINCj4gKHlv
dSBkb24ndCBoYXZlDQo+IHRvIGRyb3AgUmV2aWV3ZWQtYnkgdGFncyBmb3Igc3VjaCBhIGNoYW5n
ZSwgbm90IGhlcmUgYW5kIG5vdCBpbiB0aGUNCj4geWFtbCBjb21taXQpLA0KPiBidXQgaXQncyBm
aW5lIGlmIHlvdSBoYXZlIHJlYXNvbnMgYWdhaW5zdCB0aGF0Lg0KPiANCj4gU28sIHJlZ2FyZGxl
c3Mgb2YgdGhpcyBiZWluZyBjaGFuZ2VkIG9yIG5vdA0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiANCj4gPiAgIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1k
aXNwLWV0aGRyIiwgLmRhdGEgPSAodm9pZA0KPiA+ICopT1ZMX0FEQVBUT1JfVFlQRV9FVEhEUiB9
LA0KPiA+ICAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWRpc3AtbWVyZ2UiLCAu
ZGF0YSA9ICh2b2lkDQo+ID4gKilPVkxfQURBUFRPUl9UWVBFX01FUkdFIH0sDQo+ID4gICAJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtdmRvMS1yZG1hIiwgLmRhdGEgPSAodm9pZA0K
PiA+ICopT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQSB9LA0KPiANCg0KVGhhbmtzIGZvciBwb2lu
dGluZyB0aGlzIG91dC4gSGFkIGNoYW5nZWQgUGFkZGluZyBkcml2ZXIncyBuYW1lIHRvDQoibXRr
LWRpc3AtcGFkZGluZyIsIGJ1dCBJIGp1c3Qgbm90aWNlIHRoYXQgUGFkZGluZyB3aWxsIGFsc28g
YmUgdXNlZCBieQ0KTURQIGFuZCB0aGV5IHdpbGwgc2hhcmUgdGhlIHNhbWUgZHJpdmVyIHdpdGgg
ZGlzcGxheS4gU2hvdWxkIHdlIGNoYW5nZQ0KdGhlIG5hbWUgYWdhaW4gb3IgaXMgaXQganVzdCBm
aW5lIHRvIHVzZSAibXRrLWRpc3AtcGFkZGluZyI/DQoNClRoYW5rcywNClNoYXduDQo=
