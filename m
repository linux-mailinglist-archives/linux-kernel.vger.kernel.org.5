Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5037C66BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbjJLHw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbjJLHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:52:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732AC90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:52:49 -0700 (PDT)
X-UUID: 53a4058a68d411eea33bb35ae8d461a2-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/1sxqNsHvaBxmFJBTSlG2JpRiKhxWzKaR2eV9kEOiD8=;
        b=tySGO6kUz4scPiLQ7CZxBO/ACtJKYcIj863dIaVqFvBvP9Q8wu+J63pV1jYcYf3GiKbEcvoDYwouEfydWOYshyCrHa53E2MmsFAp9Ge5y/n9XrDR5URqoAoeHSYs6ub/lQf9OZOBIcyGYGs7M3hlbgqvHRYdchvgJCZUWhNPBXI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:930575fd-244c-4694-9e5d-6e8a5fa7f91c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:29adb4f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 53a4058a68d411eea33bb35ae8d461a2-20231012
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1069357285; Thu, 12 Oct 2023 15:52:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 15:52:42 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 15:52:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpEKbo9QNRq4HRVhpi7LLCU6mdzzKWNsTnj1lw6IdUbcd05dDz18UOK5AhwyIOHEygRhZRpQSUnyXykhh70dJhvLVGvZZAiupDDSrno1StAHLEBlstr8XuM7B8jSIwNEu7u9PosN/X03hgVDxOO0Qqqsnur5Oy66IOfaMEL/Yr3zZyoii5M/O/RHQF4OqlSJuaZEJo/WGECzupFmrQ95lElzjQD/ism7aOIqEzx1aE/v1ST7VbD43x7DvTfXjmGwHouQGsStS7FKJXhVwqYx3haa4UfIvviJek/HI2/RJDVweIi7mGE16qehowZsBQtO+imX+jWB7UEQszipAGDf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1sxqNsHvaBxmFJBTSlG2JpRiKhxWzKaR2eV9kEOiD8=;
 b=B1ah6yRTO/b/IZL+sgv3qjEC+3qAWpE4ghbJEc0q95nRb9XuDwwUIkqyfmoNwTgCi31020ddLC2Yrwpc8g9vQsyPONQeh0lntJ2eOKTLjK1gRIFQHZNBXoC/kfrGHCQLxVFvHR1t+ADW3HwS5cmCLLDyJxMNGxOqNFuNOUKypdChO7UvksReO9uka5arP4m7ndWPF3kpl51weOgddswwjUqtRRrKL2HjBlyD+n9H1XC+Xz/1h0clHbIsfUffu1CcVDp0G8f8PBvekIgCIZzi18duP3iu4/+8rrtd0v1rJAMqeY6nWCtv+qmz7dwIaa0Fz9Qx1RLCY30a8FkfbHXdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1sxqNsHvaBxmFJBTSlG2JpRiKhxWzKaR2eV9kEOiD8=;
 b=GW0zpETuV7OXIBi0czbCWSGHYUYl6pQs2JsZEl/o/JPWRk1vYLjbnB8MJQMbM8jMfsM3O3G5Pc5KLeFQ06n90z8t91y7Jmv2NLcs3dg5Y7VBysMitR/2H//uL+7CN0MV4xjPOQRW7afEiJyznQ5+9ozOwc3qMLG5ckcwD7oZ76s=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR0302MB5250.apcprd03.prod.outlook.com (2603:1096:820:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 07:51:40 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 07:51:40 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>
Subject: Re: [PATCH v10 01/16] drm/mediatek: gamma: Adjust
 mtk_drm_gamma_set_common parameters
Thread-Topic: [PATCH v10 01/16] drm/mediatek: gamma: Adjust
 mtk_drm_gamma_set_common parameters
Thread-Index: AQHZxqVwKeU5sncNQkC/ux94xaNo7LBGNJKA
Date:   Thu, 12 Oct 2023 07:51:40 +0000
Message-ID: <2ca106886fb0c990dd398bfa95012492dc3f6c13.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-2-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR0302MB5250:EE_
x-ms-office365-filtering-correlation-id: e3e148bf-db8c-4034-8cf0-08dbcaf811c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r6WhXMykylDpUDCd1A/XcXVKEwvANY9awXgLyWuhK1gX54Jqfa5uCRYs0p4fwrLKYM/NU1Z1s2qdaavQx26vqvDUW2SjWPiIvXcGzGGxMuU9EONzzNefnoTkuu/Fn/8y7aa7mHvitQeHIGw7Mrl+tOFPeQ7wRMzkUybxTdMyrrIQlwACvT8WVBm9TkZWFT/NGN5Mkz2hQPqFbNONxJbZP3rYcLQ6UJvQlMUlTsr2y6tIGDlmTky77ZB7zqOGu6UGBL0i/o0k0Nb1RWqp6zhE7056YlnPvtuc0jvFb3Dx1XI6/rYo7rCCh7rBS1a02JyXstxtv4tJbHmdB4dA7PmRB7+nnur/V8dxg2IfnACRab5wyiKmxSf5TnKpKR2bgQcwnxgaS9XCnRwjCh5fiPN4jA/3BMDjkcT3ES4BKu/4BZgPtHjCokCcywj0HsS4DMX3nIICqAjutuaqTSsPCh34SoVtUlPHbeqIwfSe2bUZ7dBnf6BzQmo1mGW+uGvnsxITDD53SxaeOXzvzmjj/NISocg6RbcReU2kic/U99xczLCIeB8mC6qegNatZB72h8EY+U82mLZIUezfHs1A7omvrftTgFr+h0PBcWGaAyFIO5043HKvTpDRwXdEyWxPU/wdPzdJzpYSwvJh46PDyW7rY/3ZLuCD4TmPWye89eKDJvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(64756008)(85182001)(66946007)(66556008)(76116006)(66476007)(66446008)(54906003)(316002)(110136005)(4326008)(8936002)(41300700001)(36756003)(8676002)(38070700005)(38100700002)(5660300002)(122000001)(7416002)(6512007)(2906002)(6486002)(26005)(2616005)(478600001)(71200400001)(83380400001)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3N3NnR4dnJ1Y0sxaU9tWS9RS2ZmWVYzZmRFM3l3U1NqY0pSUk81R2FYWmdU?=
 =?utf-8?B?bjlqczUrYTArQTZhMG5PaVJrMllNUFVZdlZ5TXRrT2QvMks4S2w0ZXJWQkhP?=
 =?utf-8?B?NGNTVEo2b0tGNWFpTmxvb0lIc1NuZS9kSHpvRHowNE9QRjZlZ2R4aWpONjRC?=
 =?utf-8?B?OWJDZFk4TGRVR040SkZHT0txRGZuSW1qTUJSdkZzNDFtaHhrejZzT1JwWFdH?=
 =?utf-8?B?d29EeXM5Z3NwOG1zZTV0akxtelMwM2VXVnlXeVlPK1hUdE1LN3NkcmZsYmJC?=
 =?utf-8?B?K2ZIVHRhNlExMmtXb0c0aUhYYVdwVS9oQWM4MFV2UjI2RnlreFVFbjNHa09P?=
 =?utf-8?B?MlpDbkY5dUtkdENQL29kekVQM2Ftb2RoRHE2Qy90OEFyVjNqY3hNRUloaGta?=
 =?utf-8?B?NjNGSHZrVnZ6ZG5zNHZzQm9TWUtDM0d2a0h4NjkzOElvSFl2amk1b1RVeUtj?=
 =?utf-8?B?bmpJK1dSMFFLcXdzOEI1aXpITEdIR2xOc3dFY0ZOYlQzYWJVK3Fibkk3cWhL?=
 =?utf-8?B?Q0taYS85bXlLazR0elhPYXNyVUp6YXVPZFlrNUxrUlRhOVpiQ0Y4bFIxUFR4?=
 =?utf-8?B?cWFpamp5RDhOS3F2eW1vdDIrMTl5b1BWQlVvb21ZZDFReGlFMC9jZGtaUFla?=
 =?utf-8?B?d2RZRjc5QS8vQThQZU90cloxQkJjR0pBYURrUnNqRXVGZ3kzZi9KTDg5eHFx?=
 =?utf-8?B?anQ3czRNVHZxanZkT09RaTlLdjhMVjh3bmQ5SVRBM3ZhS3pOQVhFOGNHOTVE?=
 =?utf-8?B?Vmd0T3JMZUVpU3NVQjBjNldhSUZrOWlUMXFod3hjUHc5b0Q1bWZBSWhrMi9t?=
 =?utf-8?B?bWIxWWN1bXJJYVU3b2hKeDRVaEcwK3ZwVElTaEpwR0lEMlUzY3owemVPRFpl?=
 =?utf-8?B?OXA1WlEydGNpbXU4aUdPZU9FaDJMU2pQTHh0NFRoS0JIczVOTWpDSGovZzF5?=
 =?utf-8?B?bDViL2V6U3l3NUxyaFR1QVpwYjF4YjJYZ3RPelFZWnVPcndTYXFRUXZ5c21D?=
 =?utf-8?B?bGZTYzZYcmRoOFhsRDBiLzJPdm9TVEJVWUtxWkw3bDZrcVRRR2RZalRGY01T?=
 =?utf-8?B?aFVYM3QrOWllNzQvNXU5SENzYjlFTllidng4UENYNDY3cnMya2dwTS9jUUJp?=
 =?utf-8?B?Z2ZQd2N2Sm11dzBEZitUWmdvTzRKbmVzZ1p5cWk3SVF4cW84RGRDYU9qT1lu?=
 =?utf-8?B?MUoyMjlldVhCSGtkUUhHN1lQKy94eFN5UHZCNEdDcjNUY0Zra2MvQS9rbkFt?=
 =?utf-8?B?VGlCYWROanZ5SmQvMjhrMCs1c21lUlIrcDZGMFo0cjJmdmNmMTNyR0pXcEd4?=
 =?utf-8?B?MmNhUlhPMExWMERzYUVKMnB3Wlk4d3g1THk0VUxNdk5uVlYvQ1EvWkVxT2t6?=
 =?utf-8?B?cnFNRkJwMkJNc3IxamZYbjVXdk5kTm9GQWk5Wnc5UXhjUDZiUEMwelJtakVv?=
 =?utf-8?B?cFNIcFdwWEJPYTRkTXBEeWtuMzdZbTgvaEpCR3RPa3lpMXVSbjRQUHlYQ3hH?=
 =?utf-8?B?OGpGZjB1b0xsbTV2SC9hYWpvZEVndHc3ZEVkTVh6OHdkMnFOUlMzTEEzTHFz?=
 =?utf-8?B?aDlxeVlGQmdqYUFvdXVaMk1OS3VJTmdMem1LQjNPU08yNzBKTTRueWVqaFRn?=
 =?utf-8?B?Y1hQUEJjbWpRZW1NcmZuSlRyMG9rZEJrUWZUT2liMWU1ZWRWRXlEMTJVVFVs?=
 =?utf-8?B?YldzZDcrRkc3dGdUbzFJR3ZUZWliWmVUOGxZOE9oVDA2a3dCeVAwT1JGNVV3?=
 =?utf-8?B?eGl2RDJTSGV0cWJyR1Z2Q3VML3RpOTFqUEJwSTNkNnBoZlYrWnVIa2ZBeEpu?=
 =?utf-8?B?aW56blhaTmlWNVBQZUxmNEF3NW9tY0NkMkRLelkxREgyOXlDVDlNbURYQWQx?=
 =?utf-8?B?aFJybHp6UEVhclY1QVhhbGhBTHZ6RTVVNWhaOWNPaU5ZRThzS1F0YVo4R2FK?=
 =?utf-8?B?bTJ4c01TN0M4emxMcnhJTWx6bGFJNTVBQ2NndC85Q3BvRnE1UjZYSGtBcEZN?=
 =?utf-8?B?anE2a0U2Wmh4amk5dTBFOUE5WFkxTjM2eGxyeWtSay9SZUZsNE5HTnZkcWJ2?=
 =?utf-8?B?UGNUSzZ3OFMwa1NHUUdKaDV0MXJQSHJNSGp5cWRBeUF0d3dwakNiSHNMSXpM?=
 =?utf-8?B?bHBKQzFVRFNSRC9YaWhOd2thc1hsdjVHWlh5WVB5V0FOVXphV0NEbjV5UXJD?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF8F1BDEC7222847B4E8AA46358E60C7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e148bf-db8c-4034-8cf0-08dbcaf811c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 07:51:40.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFUlYFqJunQ81AqhLM5bRzdYu8kINtC9ntpBJhcdZcNvSn+CqxAO3bQlGKLj8p67oEoz9m3sjQ8e6q0ubtY4Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5250
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRnJvbTogIkphc29uLUpILkxpbiIgPGphc29u
LWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IA0KPiBBZGp1c3QgdGhlIHBhcmFtZXRlcnMgaW4gbXRr
X2RybV9nYW1tYV9zZXRfY29tbW9uKCkNCj4gICAtIGFkZCAoc3RydWN0IGRldmljZSAqZGV2KSB0
byBnZXQgbHV0X2RpZmYgZnJvbSBnYW1tYSdzIGRyaXZlciBkYXRhDQo+ICAgLSByZW1vdmUgKGJv
b2wgbHV0X2RpZmYpIGFuZCB1c2UgZmFsc2UgYXMgZGVmYXVsdCB2YWx1ZSBpbiB0aGUNCj4gZnVu
Y3Rpb24NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9n
aW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFJldmlld2VkLWJ5OiBBbGV4YW5k
cmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9hYWwuYyAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jIHwgMTggKysrKysrKysrKysrLS0tLS0tDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IGluZGV4IGNkYmVjNzk0NzRk
MS4uMmY2MDJmMWYxYzQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfYWFsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2FhbC5jDQo+IEBAIC02Niw3ICs2Niw3IEBAIHZvaWQgbXRrX2FhbF9nYW1tYV9zZXQoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiAgCXN0cnVj
dCBtdGtfZGlzcF9hYWwgKmFhbCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgDQo+ICAJaWYg
KGFhbC0+ZGF0YSAmJiBhYWwtPmRhdGEtPmhhc19nYW1tYSkNCj4gLQkJbXRrX2dhbW1hX3NldF9j
b21tb24oYWFsLT5yZWdzLCBzdGF0ZSwgZmFsc2UpOw0KPiArCQltdGtfZ2FtbWFfc2V0X2NvbW1v
bihOVUxMLCBhYWwtPnJlZ3MsIHN0YXRlKTsNCj4gIH0NCj4gIA0KPiAgdm9pZCBtdGtfYWFsX3N0
YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9kcnYuaA0KPiBpbmRleCAyMjU0MDM4NTE5ZTEuLjc1MDQ1OTMyMzUzZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBAQCAtNTQsNyArNTQsNyBA
QCB2b2lkIG10a19nYW1tYV9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZA0KPiBp
bnQgdywNCj4gIAkJICAgICAgdW5zaWduZWQgaW50IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwN
Cj4gIAkJICAgICAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCk7
DQo+ICB2b2lkIG10a19nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2Ny
dGNfc3RhdGUNCj4gKnN0YXRlKTsNCj4gLXZvaWQgbXRrX2dhbW1hX3NldF9jb21tb24odm9pZCBf
X2lvbWVtICpyZWdzLCBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUNCj4gKnN0YXRlLCBib29sIGx1dF9k
aWZmKTsNCj4gK3ZvaWQgbXRrX2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LCB2
b2lkIF9faW9tZW0gKnJlZ3MsDQo+IHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpOw0KPiAg
dm9pZCBtdGtfZ2FtbWFfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2dh
bW1hX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiBpbmRleCA3NzQ2ZGNlYWRiMjAuLmQ0MmNjMDY5
OGQ4MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dh
bW1hLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMN
Cj4gQEAgLTU0LDE0ICs1NCwyNCBAQCB2b2lkIG10a19nYW1tYV9jbGtfZGlzYWJsZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGdhbW1hLT5jbGspOw0KPiAg
fQ0KPiAgDQo+IC12b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHZvaWQgX19pb21lbSAqcmVncywg
c3RydWN0IGRybV9jcnRjX3N0YXRlDQo+ICpzdGF0ZSwgYm9vbCBsdXRfZGlmZikNCj4gK3ZvaWQg
bXRrX2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0gKnJl
Z3MsDQo+IHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICB7DQo+ICsJc3RydWN0IG10
a19kaXNwX2dhbW1hICpnYW1tYTsNCj4gIAl1bnNpZ25lZCBpbnQgaSwgcmVnOw0KPiAgCXN0cnVj
dCBkcm1fY29sb3JfbHV0ICpsdXQ7DQo+ICAJdm9pZCBfX2lvbWVtICpsdXRfYmFzZTsNCj4gKwli
b29sIGx1dF9kaWZmOw0KPiAgCXUzMiB3b3JkOw0KPiAgCXUzMiBkaWZmWzNdID0gezB9Ow0KPiAg
DQo+ICsJLyogSWYgd2UncmUgY2FsbGVkIGZyb20gQUFMLCBkZXYgaXMgTlVMTCAqLw0KPiArCWdh
bW1hID0gZGV2ID8gZGV2X2dldF9kcnZkYXRhKGRldikgOiBOVUxMOw0KPiArDQo+ICsJaWYgKGdh
bW1hICYmIGdhbW1hLT5kYXRhKQ0KPiArCQlsdXRfZGlmZiA9IGdhbW1hLT5kYXRhLT5sdXRfZGlm
ZjsNCj4gKwllbHNlDQo+ICsJCWx1dF9kaWZmID0gZmFsc2U7DQo+ICsNCj4gIAlpZiAoc3RhdGUt
PmdhbW1hX2x1dCkgew0KPiAgCQlyZWcgPSByZWFkbChyZWdzICsgRElTUF9HQU1NQV9DRkcpOw0K
PiAgCQlyZWcgPSByZWcgfCBHQU1NQV9MVVRfRU47DQo+IEBAIC05MSwxMiArMTAxLDggQEAgdm9p
ZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbih2b2lkIF9faW9tZW0gKnJlZ3MsDQo+IHN0cnVjdCBkcm1f
Y3J0Y19zdGF0ZSAqc3RhdGUsIGJvb2wNCj4gIHZvaWQgbXRrX2dhbW1hX3NldChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICB7DQo+ICAJc3RydWN0
IG10a19kaXNwX2dhbW1hICpnYW1tYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAtCWJvb2wg
bHV0X2RpZmYgPSBmYWxzZTsNCj4gLQ0KPiAtCWlmIChnYW1tYS0+ZGF0YSkNCj4gLQkJbHV0X2Rp
ZmYgPSBnYW1tYS0+ZGF0YS0+bHV0X2RpZmY7DQo+ICANCj4gLQltdGtfZ2FtbWFfc2V0X2NvbW1v
bihnYW1tYS0+cmVncywgc3RhdGUsIGx1dF9kaWZmKTsNCj4gKwltdGtfZ2FtbWFfc2V0X2NvbW1v
bihkZXYsIGdhbW1hLT5yZWdzLCBzdGF0ZSk7DQo+ICB9DQo+ICANCj4gIHZvaWQgbXRrX2dhbW1h
X2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0K
