Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966CA7F3DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjKVFua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVFu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:50:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B712A;
        Tue, 21 Nov 2023 21:50:23 -0800 (PST)
X-UUID: 054728ee88fb11eea33bb35ae8d461a2-20231122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RO0aDpGzNAf9orIS/Y3LndcCXpWZLLu4MQL6eXPLExQ=;
        b=QE08oIsuJdI5+ZtVGZ93XCQBoxbV2X3Dlx7dXeldw6+m2s46tOJT7P9hzEog5dxfbQ7rn6HtpeyKDNjrXD9vA3MpXzSgM5Ij5339UtLshMpeBfvpFJmZ1RG4xs7eCTaqyiMEXCGG5MuB2z0XSb809ngbTZxmQsAkFf+ghg0luds=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:dd5decdc-a48e-4da7-8c37-b5a7616f2f17,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:0ed9cffc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 054728ee88fb11eea33bb35ae8d461a2-20231122
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 463966180; Wed, 22 Nov 2023 13:50:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 22 Nov 2023 13:50:19 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 22 Nov 2023 13:50:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3fs++JtQeeUIkSgXUm0GlwO64aWacThNMbzyCcbnYMokWFHYT67/gCR8/fQA59eKo2ifeBJS/2Dq3iv7UsGwlEQ66JRAvD03Pq/skolOqMc8RF7WjYsWsh6H7gceFLGU3llhUp5aOGFXqzDESP25g090Us8E7l8Oc+Hy4SP+O9y3qQoyBYahr6Nl1nQyo+N8MBJ/nL8igAB93HwEwSzbmeWkB5iAs4IwknUIHwZ09s9VmmpFIM9Jqd3MhBtw7ib1ETPh503bWl8grTZJY7rp3sxuuQOTJByrIXYLKQjE2GXn1Vm/7EeA1CrsgqHjbnlownKWgOE5pnpNViJt/HkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO0aDpGzNAf9orIS/Y3LndcCXpWZLLu4MQL6eXPLExQ=;
 b=Mz3xloEZ2JLBi6GQUOk4wg02HYcIYPpiCRF7+ZLhagyJRRSAO6IIeTGMffTk68fiUr5q38NEjm3n2SOuzCaw56EUbAyeIsZE0kvwxPGl2HdO4B1A4RriQhnLyFWDKaMh+vOUlUSYMvHlUhwUCpuKRaYIEY+nQXMkEvqwpqZzIcAcKHr1AhAC7DBzWEIrhzqya60V3CwuNYHFGSCaO+84r9+1yI6cX4x197MoGaZzF8hSM1QheSIYZZtivHAVDRehA6a9ohp87XZuKTEjZUqjJOqE9/msjpaN9218oFCZb9WoZJxxJ0qCBIsW7OV6Kp+9XwZ/9YM4PfjatafGlkm70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO0aDpGzNAf9orIS/Y3LndcCXpWZLLu4MQL6eXPLExQ=;
 b=uyGsQMkUUr3lvJsL0pkxyviOVlM7bNk8DsJKDeHFxh2dhwQYCf4xfoa9YohsmnR5kNjGJvA6ZFgpRlGpm/DUDOV+sHpBEeAYKKKTykUE3SLRJkve4hM1j6K3Nwwwa8LKMxB4lnxF1X3pTMN5bnJwGbdOjWidNjglGxvyeGQ1Uq0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5804.apcprd03.prod.outlook.com (2603:1096:4:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 05:50:17 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 05:50:16 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 05/11] drm/mediatek: Set DRM mode configs accordingly
Thread-Topic: [PATCH v3 05/11] drm/mediatek: Set DRM mode configs accordingly
Thread-Index: AQHaAMXdweqFjhc7MkiSaLGk2rGLbLCGDf0A
Date:   Wed, 22 Nov 2023 05:50:16 +0000
Message-ID: <000271355d337cd4961ccf7da2ad7371fb371f55.camel@mediatek.com>
References: <20231017064717.21616-1-shawn.sung@mediatek.com>
         <20231017064717.21616-6-shawn.sung@mediatek.com>
In-Reply-To: <20231017064717.21616-6-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5804:EE_
x-ms-office365-filtering-correlation-id: c2ed4b63-097b-4c7b-5283-08dbeb1ee78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8kK6d+Tp6p9fFUR8O2eAvzhHFHxDvJf4reSuzXVH1akcGfUf4PkYZKQwrvbXy4Z+TAuxCqNGrj/UShyCGZL2vdUlifjQCs6m2CHXB8lGb5JbyuT0rRchapUSajyCOnRrXnku9/Z1K6hJi5ruvNcmZ1GjNYuTgBNA8J5Nonbh4OGwlNA7pdozIIxjNucjXhOirkoWOFsG8f7Q99JnStWLdyG7hXhPQ2VqeT7qAwopZktazO4ZJVUta3AZXKilFG7RJotKx22tGleQssCJj2ntaK+pHxVlPSwYybJ8Nv310f8gbDXXci7kpZzOBuyJPErBeRNwZLxZVg6Crx7R6pCrzw4g3Ukh8R1AV5vceOBVACiEDQPI0IYG0eO76l6YXmDhdiFj0nj8l4hwV8mnv88HFNYAqa9yKkOLjB4FwBO93LSHrVyjqRMYD7vKS5O+2/4GwU3b8+n2LJPJOguMnbJVaCNhvrL9KwDaQoHq66ZDdkXeNmYBmBKI+wavbmvPSgUnSDvKsMQuafYOsn7ks2w0w1HCioAfcDwTPTwWooGkmuEMYf2gZ37lV2m9snX4PZmWZKb4BUvnvpI9lx6lHQdtUIdc9nR+dVna6hbkEJC4rEGebg6gxHg3JyeLeo+Dg1dPrm/qvNpwGcIvDMGi9vBIAAgl0mbZcknmVjskvEU5UvDn9lAbRjbeEyWX+8NqUV2WZG/+FKuSHml2ZKiBUevnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(26005)(86362001)(83380400001)(41300700001)(122000001)(6512007)(38070700009)(4001150100001)(38100700002)(2616005)(36756003)(85182001)(6506007)(2906002)(71200400001)(5660300002)(7416002)(66556008)(64756008)(316002)(110136005)(91956017)(76116006)(66446008)(66946007)(54906003)(66476007)(8676002)(4326008)(8936002)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGtIampvZWREVWt1Ky83dmFFc0F2QmRVM3E1clZiNDV4THQycTU3aUhHWGVa?=
 =?utf-8?B?VE1Od3dXOXcwR05kcUtOQzh1WFVvQUMzYmR6Z2lDSnNsaHlQd0dBNFFlVzRJ?=
 =?utf-8?B?ZmZqY3UxbjFhbnZTYktzVmpRWG5kNGNtMUZoQ2ErOXltbERKQzhjZHdFajhC?=
 =?utf-8?B?T2xmQyswMXo3a3loM3RCUkI3OHFwcG5PWTlSUGVYSGNiN1JHdE9KeHpZdW1s?=
 =?utf-8?B?YXZSNHpjVmxIeFlQMUd6OHQ4SEc1d2FuRVN6THFmcWNvb2E4Wm5BVVVnREJH?=
 =?utf-8?B?UHJyNUdZcnd0Y3RTU2pLWFNWcy9SWjl6bTdoeVdjQ1hJZnVzYW96M05jVmdQ?=
 =?utf-8?B?Qll3djZQZ1Jmb3pTeHBkQzEvQlp4RW5wZ1RhN1VKR3lpWFJOWE9iU3ZFMHdN?=
 =?utf-8?B?VGxpMVMrazJxd2RmeEYvMHRZaUlpVG9EQlp1UUFST1N6NFB4d1RnV08ybWly?=
 =?utf-8?B?dUZ2aDJIYm9tdHhPa0Rma1p3TXg5eW1zZFhvenlTOHVKU0VEbWQ4cFd5T2NZ?=
 =?utf-8?B?MTVVQVNodFUzS24yUjZZQ2FOck9lWmdaZUZFNDJSekpHSzdMY0w3Qm8xcDNq?=
 =?utf-8?B?S2dTNGpNeFNMQjZnK0prTkpOdE5YSDA4V1p4dGVlcTJ2V1JTVzR6TGVoVk5G?=
 =?utf-8?B?V2FObFlFQ3diMW1XcmNvZ3pTWmEyTmJQc0hDcVBnODJQQWRWTjB1RlZpWFlW?=
 =?utf-8?B?M0Z3Z0NzbGttVGxPb0FNTXBoUk9DQTlDTkpnalY5T245L3EwUXU0blBxN2Qw?=
 =?utf-8?B?TzlVaHBTcHF1bWwrY3MzbGwwcjBxaTNjL1RMZDB3ZmpxVEhKbGlNUk9sZ0cx?=
 =?utf-8?B?MFl1ZGFiY1VvV1c4Z1R0YzdwV1VCeU1haXlMMFp5dk1jakd1TDZIUEpNeUFu?=
 =?utf-8?B?UXdscmlQdGxSdjB2QTdmZkVmWEJMRzFpTm5jNVRtS1N5Nk1ZUmloMVh2QzF5?=
 =?utf-8?B?ck1SUlczOXpKNnBqTEZCazFQb04zTFc2SmFtSEJqM2JNeDdjVW5hVmovU2Qw?=
 =?utf-8?B?ODcybGlhbzlQZXpuMEVvcG10RVdibmJtV1hPN1NoeC9mdDRWS2hTYys1SEVX?=
 =?utf-8?B?Sm1BanBCU0FjTmlhZnBYS3poQWVnMGsxZVJFbjlVdEE1aWxIOHZoMW9FSVh3?=
 =?utf-8?B?ckk5VXc0dEhDQzRjbTArbTJNaUxWZEVvd2hoWlpCdTBNWFdsRmloNkRJMXpE?=
 =?utf-8?B?WTQ4K1BCY2JsQmFMZnQ0V01DS2xqS2FqLys0TFdEYWUxU0kwV3VKQnZ4aVNS?=
 =?utf-8?B?U0RKTVlOVWJGVmxwVzlqNXJ3aUtCMlArQlQ1eTcxMlJ0dGhJbW0zcGxVc3h6?=
 =?utf-8?B?V1RpMXh4Z0ZISGM4ekVTSlZzSlNHRXdSdkNpbEpieG5zSFBub3dCZkFLUndh?=
 =?utf-8?B?dTdCQzBWZkdmUUZtdGtjM2tISFBXRnlBSHpJM2QzVzN0RnJrcEhJNVRFa1Nm?=
 =?utf-8?B?Z0IrN05DUWZiNXF2R1hFekkwYXE3NjI3OWcyc29lcWdWVktBREZTK2xHd2F4?=
 =?utf-8?B?NndkWkxhbit6MENVRW1LalJjcFhpUFJZeERuejlBd3ZKVVgyVEx4ZUt6Mzh2?=
 =?utf-8?B?YzR2V0xOUnp0YUNJTEhMYjdDMnR0elBLUDVvYkdoR0h5V2lzTTkrenJ1RnN0?=
 =?utf-8?B?eG1MV2tuaEpKSDk4VTB3dlJCZ09jK0FxMTQwc2ZIZ1YyMlplNVFVa2RWVXhu?=
 =?utf-8?B?bkRFY053U0RFeGsxWVdrMjZvYXFLcHUrdjJZSi9IUmpncnRya3FXeGJ1SDFY?=
 =?utf-8?B?YllWVHZJWHYzNUVVc2hXVmJDM2hZa04rQXNUQTJvbGhwUkNkNmE5NGRBV2Nu?=
 =?utf-8?B?U1YrWFFxa3NzWVNLMGRxRm8vSU5xU1RsWExPSlZZN0xWc2lkclV1eWR5L3Nv?=
 =?utf-8?B?eDFiei9WenNXWUJyc05rOHZPdHRPRDV0TW1wNmRJanFvVDdKazlHejYzSnho?=
 =?utf-8?B?cmVob2hCZ08zNmRZUWltU1M1M3RUcnkrT3VzRjhEbEhjMURZZis1UzhzVGdr?=
 =?utf-8?B?OFNXL0EvdGp4U2c0LzF4SFgyN0dCaURkSjJiWG9vdHVIM0Fsbm1kSXllRyta?=
 =?utf-8?B?RHlCc1JTSDZmeWk3MVpIVXFXR2l0YWNONVhsTXdJTG9pWXpBNHVSRU10N2Jp?=
 =?utf-8?Q?kMf3xBuZzoKnNqh7syxjmey/E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <971F5A113F9C1A41B03296715C018C57@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ed4b63-097b-4c7b-5283-08dbeb1ee78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 05:50:16.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjjKPCZq88md4S1h5qlqQM49LV+RB4MImVW96Y0jHHso3Bx831OdUKlx623KSd5q+xLXi4qRTx4zrMb6HvgnDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUdWUsIDIwMjMtMTAtMTcgYXQgMTQ6NDcgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFNldCBEUk0gbW9kZSBjb25maWdzIGxpbWl0YXRpb24g
YWNjcm9kaW5nIHRvIHRoZQ0KPiBoYXJkd2FyZSBjYXBhYmlsaXRpZXMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8IDI4ICsrKysrKysr
KysrKysrKysrKy0tLS0NCj4gLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmggfCAxNyArKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM3IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYw0KPiBpbmRleCA1ZDU1MWJmZjZiM2YuLmE0Yjc0MDQyMGViYiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gQEAgLTMwNCw2ICsz
MDQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YQ0KPiBtdDgx
ODhfdmRvc3lzMF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuY29ubl9yb3V0ZXMgPSBtdDgxODhfbXRr
X2RkcF9tYWluX3JvdXRlcywNCj4gIAkuY29ubl9yb3V0ZXNfbnVtID0gQVJSQVlfU0laRShtdDgx
ODhfbXRrX2RkcF9tYWluX3JvdXRlcyksDQo+ICAJLm1tc3lzX2Rldl9udW0gPSAyLA0KPiArCS5t
YXhfcGl0Y2ggPSBHRU5NQVNLKDE1LCAwKSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX21tc3lzX2RyaXZlcl9kYXRhIG10ODE5Ml9tbXN5c19kcml2ZXJfZGF0YSA9DQo+
IHsNCj4gQEAgLTMxOCw2ICszMTksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19k
cml2ZXJfZGF0YQ0KPiBtdDgxOTVfdmRvc3lzMF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkubWFpbl9w
YXRoID0gbXQ4MTk1X210a19kZHBfbWFpbiwNCj4gIAkubWFpbl9sZW4gPSBBUlJBWV9TSVpFKG10
ODE5NV9tdGtfZGRwX21haW4pLA0KPiAgCS5tbXN5c19kZXZfbnVtID0gMiwNCj4gKwkubWF4X3Bp
dGNoID0gR0VOTUFTSygxNSwgMCksDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19tbXN5c19kcml2ZXJfZGF0YSBtdDgxOTVfdmRvc3lzMV9kcml2ZXJfZGF0YQ0KPiA9IHsN
Cj4gQEAgLTMyNSw2ICszMjcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2
ZXJfZGF0YQ0KPiBtdDgxOTVfdmRvc3lzMV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuZXh0X2xlbiA9
IEFSUkFZX1NJWkUobXQ4MTk1X210a19kZHBfZXh0KSwNCj4gIAkubW1zeXNfaWQgPSAxLA0KPiAg
CS5tbXN5c19kZXZfbnVtID0gMiwNCj4gKwkubWF4X3BpdGNoID0gR0VOTUFTSygxNSwgMCksDQo+
ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHJtX29m
X2lkc1tdID0gew0KPiBAQCAtNDYzLDE2ICs0NjYsMTYgQEAgc3RhdGljIGludCBtdGtfZHJtX2tt
c19pbml0KHN0cnVjdCBkcm1fZGV2aWNlDQo+ICpkcm0pDQo+ICAJaWYgKHJldCkNCj4gIAkJZ290
byBwdXRfbXV0ZXhfZGV2Ow0KPiAgDQo+IC0JZHJtLT5tb2RlX2NvbmZpZy5taW5fd2lkdGggPSA2
NDsNCj4gLQlkcm0tPm1vZGVfY29uZmlnLm1pbl9oZWlnaHQgPSA2NDsNCj4gLQ0KPiAgCS8qDQo+
IC0JICogc2V0IG1heCB3aWR0aCBhbmQgaGVpZ2h0IGFzIGRlZmF1bHQgdmFsdWUoNDA5Nng0MDk2
KS4NCj4gLQkgKiB0aGlzIHZhbHVlIHdvdWxkIGJlIHVzZWQgdG8gY2hlY2sgZnJhbWVidWZmZXIg
c2l6ZQ0KPiBsaW1pdGF0aW9uDQo+IC0JICogYXQgZHJtX21vZGVfYWRkZmIoKS4NCj4gKwkgKiBT
ZXQgZGVmYXVsdCB2YWx1ZXMgZm9yIGRybSBtb2RlIGNvbmZpZw0KPiArCSAqIHRoZXNlIHZhbHVl
cyB3aWxsIGJlIHJlZmVyZW5jZWQgYnkgZHJtX21vZGVfYWRkZmIoKSBhcw0KPiArCSAqIGZyYW1l
IGJ1ZmZlciBzaXplIGxpbWl0YXRpb24uDQo+ICAJICovDQo+IC0JZHJtLT5tb2RlX2NvbmZpZy5t
YXhfd2lkdGggPSA0MDk2Ow0KPiAtCWRybS0+bW9kZV9jb25maWcubWF4X2hlaWdodCA9IDQwOTY7
DQo+ICsJZHJtLT5tb2RlX2NvbmZpZy5taW5fd2lkdGggPSAxOw0KPiArCWRybS0+bW9kZV9jb25m
aWcubWluX2hlaWdodCA9IDE7DQo+ICsJZHJtLT5tb2RlX2NvbmZpZy5jdXJzb3Jfd2lkdGggPSA1
MTI7DQo+ICsJZHJtLT5tb2RlX2NvbmZpZy5jdXJzb3JfaGVpZ2h0ID0gNTEyOw0KDQpZb3UgY2hh
bmdlIHRoaXMgZm9yIG10ODE3MyBhbmQgbXQ4MTgzLiBBcmUgeW91IHN1cmUgdGhpcyBpcyBjb3Jy
ZWN0Pw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICAJZHJtLT5tb2RlX2NvbmZpZy5mdW5jcyA9
ICZtdGtfZHJtX21vZGVfY29uZmlnX2Z1bmNzOw0KPiAgCWRybS0+bW9kZV9jb25maWcuaGVscGVy
X3ByaXZhdGUgPSAmbXRrX2RybV9tb2RlX2NvbmZpZ19oZWxwZXJzOw0KPiAgDQo+IEBAIC01MDIs
NiArNTA1LDE1IEBAIHN0YXRpYyBpbnQgbXRrX2RybV9rbXNfaW5pdChzdHJ1Y3QgZHJtX2Rldmlj
ZQ0KPiAqZHJtKQ0KPiAgCQlmb3IgKGogPSAwOyBqIDwgcHJpdmF0ZS0+ZGF0YS0+bW1zeXNfZGV2
X251bTsgaisrKSB7DQo+ICAJCQlwcml2X24gPSBwcml2YXRlLT5hbGxfZHJtX3ByaXZhdGVbal07
DQo+ICANCj4gKwkJCWlmIChwcml2X24tPmRhdGEtPm1heF9waXRjaCkgew0KPiArCQkJCS8qIFNh
dmUgNCBieXRlcyBmb3IgdGhlIGNvbG9yIGRlcHRoDQo+IChwaXRjaCA9IHdpZHRoIHggYnBwKSAq
Lw0KPiArCQkJCWRybS0+bW9kZV9jb25maWcubWF4X3dpZHRoICA9IHByaXZfbi0NCj4gPmRhdGEt
Pm1heF9waXRjaCA+PiAyOw0KPiArCQkJCWRybS0+bW9kZV9jb25maWcubWF4X2hlaWdodCA9IHBy
aXZfbi0NCj4gPmRhdGEtPm1heF9waXRjaCA+PiAyOw0KPiArCQkJfSBlbHNlIHsNCj4gKwkJCQlk
cm0tPm1vZGVfY29uZmlnLm1heF93aWR0aCA9IDQwOTY7DQo+ICsJCQkJZHJtLT5tb2RlX2NvbmZp
Zy5tYXhfaGVpZ2h0ID0gNDA5NjsNCj4gKwkJCX0NCj4gKw0KPiAgCQkJaWYgKGkgPT0gMCAmJiBw
cml2X24tPmRhdGEtPm1haW5fbGVuKSB7DQo+ICAJCQkJcmV0ID0gbXRrX2RybV9jcnRjX2NyZWF0
ZShkcm0sIHByaXZfbi0NCj4gPmRhdGEtPm1haW5fcGF0aCwNCj4gIAkJCQkJCQkgIHByaXZfbi0+
ZGF0YS0NCj4gPm1haW5fbGVuLCBqLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kcnYuaA0KPiBpbmRleCBkMmVmZDcxNTY5OWYuLjgzM2VjZWU4NTViYiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmgNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmgNCj4gQEAgLTI4LDYgKzI4LDIxIEBAIHN0
cnVjdCBtdGtfZHJtX3JvdXRlIHsNCj4gIAljb25zdCB1bnNpZ25lZCBpbnQgKnJvdXRlX2RkcDsN
Cj4gIH07DQo+ICANCj4gKy8qKg0KPiArICogc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YSAt
IGNhcGFiaWxpdGllcyBmb3IgdGhlIG1tc3lzDQo+ICsgKiBAbWFpbl9wYXRoOiBwYXRoIG9mIHRo
ZSBtYWluIGRpc3BsYXkNCj4gKyAqIEBtYWluX2xlbjogbGVuZ3RoIG9mIHRoZSBtYWluIGRpc3Bs
YXkgcGF0aA0KPiArICogQGV4dF9wYXRoOiBwYXRoIG9mIHRoZSBleHRlcm5hbCBkaXNwbGF5DQo+
ICsgKiBAZXh0X2xlbjogbGVuZ3RoIG9mIHRoZSBleHRlcm5hbCBkaXNwbGF5IHBhdGgNCj4gKyAq
IEB0aGlyZF9wYXRoOiBwYXRoIG9mIHRoZSB0aGlyZCBkaXNwbGF5DQo+ICsgKiBAdGhpcmRfbGVu
OiBsZW5ndGggb2YgdGhlIHRoaXJkIGRpc3BsYXkgcGF0aA0KPiArICogQGNvbm5fcm91dGVzOiBy
b3V0aW5nIHRhYmxlIG9mIGFsbCB0aGUgcG9zc2libGUgY29ubmVjdG9ycw0KPiArICogQGNvbm5f
cm91dGVzX251bTogbnVtYmVyIG9mIHRoZSByb3V0aW5nIHRhYmxlIGZvciB0aGUgY29ubmVjdG9y
cw0KPiArICogQHNoYWRvd19yZWdpc3Rlcjogd2hldGhlciBvciBub3Qgc2hhZG93IHJlZ2lzdGVy
IGlzIGVuYWJsZWQNCj4gKyAqIEBtbXN5c19pZDogbXVsdGktbWVkaWEgc3lzdGVtIElEDQo+ICsg
KiBAbW1zeXNfZGV2X251bTogbnVtYmVyIG9mIGRldmljZXMgZm9yIGluIHRoZSBtbXN5cyBhcyBh
IHdob2xlDQo+ICsgKiBAbWF4X3BpdGNoOiBtYXhpbXVtIHBpdGNoIGluIGJ5dGVzIHRoYXQgdGhl
IG1tc3lzIHN1cHBvcnRzDQo+ICsgKi8NCj4gIHN0cnVjdCBtdGtfbW1zeXNfZHJpdmVyX2RhdGEg
ew0KPiAgCWNvbnN0IHVuc2lnbmVkIGludCAqbWFpbl9wYXRoOw0KPiAgCXVuc2lnbmVkIGludCBt
YWluX2xlbjsNCj4gQEAgLTQxLDYgKzU2LDggQEAgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0
YSB7DQo+ICAJYm9vbCBzaGFkb3dfcmVnaXN0ZXI7DQo+ICAJdW5zaWduZWQgaW50IG1tc3lzX2lk
Ow0KPiAgCXVuc2lnbmVkIGludCBtbXN5c19kZXZfbnVtOw0KPiArDQo+ICsJdTMyIG1heF9waXRj
aDsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgew0K
