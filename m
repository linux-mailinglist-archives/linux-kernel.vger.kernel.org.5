Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB21762B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGZGCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGZGCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:02:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE3170D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:02:10 -0700 (PDT)
X-UUID: f2b551c62b7911eeb20a276fd37b9834-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=30kBuPpkHAwWZ6qMzLDSW9a+x9SPvwWuHXWZVgibICE=;
        b=UCCGQrpl7v8WM6+8O9filSlf8Lxv1iPfCIuFfwaZuFpyhmdWt5ZhLMcWIU0P1ebSzalGdrjOfbLFqkcbg8ee+OpjiH/rOS0LDbPdqkSoEnjzUv+d5zhQBa9hGC/ILyrkkplVbUFsH1paPteh/QIQLSbZgGNOtMJ97sXKKoy0GLg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:91647a6c-6085-4c70-bffa-fdbfaa13cd4e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.29,REQID:91647a6c-6085-4c70-bffa-fdbfaa13cd4e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:e7562a7,CLOUDID:030856d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230726135619EW6PJI1L,BulkQuantity:1,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULN
X-UUID: f2b551c62b7911eeb20a276fd37b9834-20230726
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1147076891; Wed, 26 Jul 2023 14:02:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 14:02:04 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 14:02:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=almI4xfGNGfsCcKgqLi8Uc0Y+EnvKlY3RzH4E6/f7r/E6bPyeejHrM/R40UZeAr/VeJuylDkQHMYZ09C0Rv/tUKjhjI4L0hjbHtQbj6YUlyzUvv7OubzKevEhGadLGoqVb1uXLEQcF0w7UBtYlkeHPeaVnMr9D6OWqwqpjUAy9atBbJf913wDi/kf3QuF2AruMcOsO/ZkM3yZUAvf2MvqVY9/cCJ94bMQV/cF8NlfujzhZE1qVSMtuUhUnc5rOig9+FzIb+zliC78veSoZwHA/iwchkxtAAXDu21RZuNU8E0Fo5BFYVRlcIDMeiyWp2E9GA/Nr8KC5YQPSeG0v77aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30kBuPpkHAwWZ6qMzLDSW9a+x9SPvwWuHXWZVgibICE=;
 b=a0HsxhPT5dQDrhedZdOfC6GRiLYh70dVUdn6ms6/Y4Jg/bCVNW8c01Di8VmznfyYjOBVlIvwR0uhog97Z63M/3PmnGIJIkQDslaZ2l1TOb4SOjBSeXkDo2DV1nbEAMBmEPtZYXfMRwvUWaOpNiI2qjrjsdk425y2GnylLZwa5rlt9QAVqZk6CjlHEfD/imESc9CcnkyepLdSjN/ruFGhdBs6TlclbiglGU6NGDqZYh3xA9i5xDd6UZlNd6LNJHFUUp9jK5gJn7J6hXhG9wTxTI9adW9XVQCLEVWM34hEBoq66EtQs7OIfXuycr6XnkpdTipR8HUOOtrVpEI5HS7uKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30kBuPpkHAwWZ6qMzLDSW9a+x9SPvwWuHXWZVgibICE=;
 b=UUI+xgHcQKtmoE4P2Ro6SlGV1DHntH5+LlfYQesykAzqdMwdzMTZd94HVzQEzU+mNr29hpgU3L9JMGv8JNqiBmU0VvMyo15G+MYsMf2oWJI0pdJRUjqohDN3En6xHhryNNzY553VpQHGbs/gk/k2U3G/VTZjXg6Xiu7PVjYvbGg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB6249.apcprd03.prod.outlook.com (2603:1096:301:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 06:02:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Wed, 26 Jul 2023
 06:02:03 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2 6/6] drm/mediatek: mtk_dpi: Compress struct
 of_device_id entries
Thread-Topic: [PATCH v2 6/6] drm/mediatek: mtk_dpi: Compress struct
 of_device_id entries
Thread-Index: AQHZuhXUMopWbCVaOUG1ZPp6Hu0dVq/LmTgA
Date:   Wed, 26 Jul 2023 06:02:02 +0000
Message-ID: <4907bc5e42d3fffa6cb01c25ab3de5a83d82146c.camel@mediatek.com>
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com>
         <20230719075056.72178-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719075056.72178-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB6249:EE_
x-ms-office365-filtering-correlation-id: 65a53bf5-1a75-4ca3-f172-08db8d9dd53f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Jw8zK4q03mV5y6loUUJjldgjmmKUoXKvL5KoKzkXuaDDMHRAw3eV5StB2TZbclsl8KimC514DIMwOMBwEg9QL6nD1Knt9570wHhmN8tYIlsei9aOHzLHwf3iGb4A/teoKYg0SAtM4WXqm2sp5BA4KhSEioAK1LXVDlxXnCWlOxXmWeJjsFG3MbBCUCz/QU1NOzl3NsJslXxTpTLq4BQv+biFIPuSgTMhjBb6dY3VQiJLYjgXYc1fm+AFtj7k0zFVbngEz6sUTrA6Omm2x1BsTjP7o10g6xMKmCX4KTPLiSomS0+rwLGcLOZ0RpMk5N4JZ4Jorj9xiXxZP8Lisp5d7KXyCoiYLd33vuBPBCWxIXWR9S2uadWffD+hxfhrnPxT7T2EAHCUDmottpQKwTxIw4hY4dM01dtOsthkOLtdNQb0PhY3gExlys+fxKZP/BwtGhlPnNiEI7DXRIt4SGr5FILzS7vY0J4l/EenEbo48znLY+nv2QAZnWfcn5zPgbnwZfiEpWaZWevkafGwQeqgPFY7MMcGL7WEkM3LzuyK5g4I48O9UK1fR2mUCQlroiYAQfyAv3Vavld511XSiTjp6xkdlH+rNZuHnnjYKVVVMpOv8wwt8D62WdRVV430bXTuwLyMachRqhI1mg8GyFBIm8X5Spk/RjrxfsYX0Ob52o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(36756003)(85182001)(86362001)(2906002)(38070700005)(83380400001)(186003)(6506007)(26005)(122000001)(6512007)(6486002)(38100700002)(54906003)(478600001)(110136005)(76116006)(4326008)(8676002)(71200400001)(66556008)(66946007)(66476007)(66446008)(64756008)(8936002)(316002)(41300700001)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUg3ZTQwbEZmWTI0NENBTGw0RHgwQVZQR0hRVnpOS2ErYkVjUk5NY0FmU3JB?=
 =?utf-8?B?MkgzTTNGUzFKU2lSRER4UCtFMkliZitSM1Z3VkJkK0ZjVHhmUks1d1JUdzRD?=
 =?utf-8?B?TEltaEFjaGJjZUVEWDhLMzQyYzlkd3ZnS1RrZ0xFcjk5am16ekpPUkcvQTdr?=
 =?utf-8?B?NjF3bkw1QnVuU1h4Q05PVUx5UUlYVy91enZWN093ajRQbmNWVGpLdnVYMkZH?=
 =?utf-8?B?aDVkUFEwMnE4SFkrdXEzdVk0VHU5YXltSm1qQmF6eGxLQk9NZHlSMFk1ejRv?=
 =?utf-8?B?dVJzZ3QzM0JEN2xXNUY4cWpMRkR3ZUlsTmo1UFkrMlp4eEUwNlN1UURPa1Fp?=
 =?utf-8?B?K09sQm5tbVdHQU9IN21vNVhqdUtFOFUvZmRDSFU3QXEyaWJoRHM3WmVRNUpK?=
 =?utf-8?B?RHRIVnUyRTRIZzNENUNnbFl1QXdoQS8rZ0twTEE1NzgrQ1VNM21PUi83d1M5?=
 =?utf-8?B?MzRwVytRakN6bjBlOEVxQ1ZYS0hMSlhlWnBEZzNKRklCdjQ5cTM0a2pzdkpL?=
 =?utf-8?B?eStZaUQ2SWVIOVNYVzFqb2xzcHE3NlFxbmVHRkFFQk5XMHE5Y3B2bGJYRUVH?=
 =?utf-8?B?RFdoVHZzK2wwZlg2dDZiQi9sbUV4L1ovUzQzbm5GVDlYeDJtSU8xMXQ1dWVs?=
 =?utf-8?B?QVNQZWg3bi9uTTRzUERyNmxxanUrd2JsZ2NMQS92N0Fhb2RCLzBrTlNWZU5t?=
 =?utf-8?B?ZkZ5LzNQOXNUYjFjaW1tRWphVU9Md244Zm5LanBTVnJ2VUt1NlVaTnR2NVlp?=
 =?utf-8?B?LzY5bHpGNlJNL2tSSGc1aUVlRnhpNnNSOHZ2SEQvbWFwYUh6WVRYQU5lZ1l4?=
 =?utf-8?B?NTB0MldVdzF6YnZTZVBDR2ZJZUNWL0RVY1MvMWpFd1ZET3NpbDNPOGdRQXBV?=
 =?utf-8?B?MnN2a21ObW1DZE9RSjZzU0tuYzBiMC9EOERGYjVzM09jbGw0RXY3azJJaDM4?=
 =?utf-8?B?cEVCaEhFTVg0bll3MlhOMkpsVDFBQ3lOZWpZTnBOK3RnRDg4QkMxaUpWMTV0?=
 =?utf-8?B?a0Q4bjY0V0psZXM1clg3U3hETFYyTGtzcWJ4c1RYL3k5OEI1ODlxMGkvOW55?=
 =?utf-8?B?RFZwemNhK3Q2aWdCTGdSRG9OM0FRRi9VOUhlMWhHL3FBTW9oMHhIcnA2cTVZ?=
 =?utf-8?B?TGNIaFIrcDVNVFFrMUxZWWljTnM1Y3FkbVJJZ1ZhWVNkb05PUDRIMTFFcm1R?=
 =?utf-8?B?U3I5K1E0ZWdPRW5jb1NEOVdHMEpnRk1VTXRxNTRQTWdIQmdNN3RIMTBJbEpq?=
 =?utf-8?B?UmxWUDhMd0hwaSt1a1IvR1hQeUwxQi96QkI4UWt5Q2tyTW02TXBFODhHY21L?=
 =?utf-8?B?c1pDUmhCYVBGLzdPcjQvcURXSEZwQ0dRTGRBTWgvMUZRM0wyR2FwWHVJZ04r?=
 =?utf-8?B?d0haK2xrV0NRK2piOEdUd1hXSVZ3RzREZnNrclkzWFdreWt1alBxNHYrdGE2?=
 =?utf-8?B?b1lGeFJoaDRaajFIaXRCMldTa2M0dk9uUmUrdWNsa3NvbHhpTmNGYjBqSVh1?=
 =?utf-8?B?eDVhUlpHUzVaczRqVUVyTSt1ZWxSRWkwZ1c3bnFUNUZKci8yYlpldE9PTFJo?=
 =?utf-8?B?L1I0ZmFveU0vTlI5UWNxM1FzTSthejNyVG1mdlhPRUduVk1zQ0FZbE4vWTdW?=
 =?utf-8?B?eHMva0lNcytMV3ZJTVFaaXk5clVGcjBRMkorZUZHVzlIVkhpb0VheTExeXND?=
 =?utf-8?B?NVlMRTlUN1lwQ3VYbGJDVFRFQTcxbEw5bGMzdjJ5S1dkYi84bGFQUFltMzBO?=
 =?utf-8?B?OUN0eTJES2NnbFNYTHFKRzNwWnZ6UWUreWlDMFM4dlBsZEs1bUdqSXZzQlgz?=
 =?utf-8?B?dnd3TEt6WXkzV05JZGh6bE5IM25iQmc0Zk5CRzRjRThRQjJQZlNVcEw2cEV3?=
 =?utf-8?B?azRsRUtadklmSVVSS1VKMFoza3ZHSUxtK293dXNUbEpKVHZOV1oyVDdMYVUr?=
 =?utf-8?B?cDdwcHpSd2QwZjkydkUvaGRSWHg5OGQzMVZzQy9ndDRicjN5MUlCVlQrOWpu?=
 =?utf-8?B?NUQ1LzhzSVM3eDcwc0xnTisyL0QvYTRnMTVlZ3hsOUIxdThzMUxYRWVIRUN5?=
 =?utf-8?B?TnlLOXA3b3o0enJkd285M1dQK2pqVzhyMDZGSlRaRXZ4VlBHWVJOaE1kaXZU?=
 =?utf-8?Q?w04K/a/7F+aEUkP/I1sH7jAGJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6D3587100D1B044BABA9B6B48999D52@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a53bf5-1a75-4ca3-f172-08db8d9dd53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 06:02:02.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5yc3FFI0FArs5VZGVuRdWfEfWILnBb2Vyp2c+L7Q0vgDOzLAisYFGQLBxDoflUET56kmzRJxbe46bX5Vap83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDIzLTA3LTE5IGF0IDA5OjUwICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gUmVkdWNlIGxpbmUgY291bnQgYnkgY29tcHJl
c3NpbmcgdGhlIGVudHJpZXMgb2Ygc3RydWN0IG9mX2RldmljZV9pZDsNCj4gd2hpbGUgYXQgaXQs
IGFsc28gYWRkIHRoZSB1c3VhbCAvKiBzZW50aW5lbCAqLyBjb21tZW50IHRvIHRoZSBsYXN0DQo+
IGVudHJ5Lg0KPiANCj4gVGhpcyBjb21taXQgYnJpbmdzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4N
Cg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGlu
by5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMgfCAzMCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBpbmRleCAyNDQzNDBkZjc0NjguLmFk
MWJlNGY5MTUwYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IEBAIC0x
MDkxLDI4ICsxMDkxLDE0IEBAIHN0YXRpYyB2b2lkIG10a19kcGlfcmVtb3ZlKHN0cnVjdA0KPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIG10a19kcGlfb2ZfaWRzW10gPSB7DQo+IC0JeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDI3MDEtZHBpIiwNCj4gLQkgIC5kYXRhID0gJm10MjcwMV9jb25mLA0KPiAtCX0s
DQo+IC0JeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZHBpIiwNCj4gLQkgIC5kYXRh
ID0gJm10ODE3M19jb25mLA0KPiAtCX0sDQo+IC0JeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxODMtZHBpIiwNCj4gLQkgIC5kYXRhID0gJm10ODE4M19jb25mLA0KPiAtCX0sDQo+IC0JeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtZHBpIiwNCj4gLQkgIC5kYXRhID0gJm10ODE4
Nl9jb25mLA0KPiAtCX0sDQo+IC0JeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtZHAt
aW50ZiIsDQo+IC0JICAuZGF0YSA9ICZtdDgxODhfZHBpbnRmX2NvbmYsDQo+IC0JfSwNCj4gLQl7
IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1kcGkiLA0KPiAtCSAgLmRhdGEgPSAmbXQ4
MTkyX2NvbmYsDQo+IC0JfSwNCj4gLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1k
cC1pbnRmIiwNCj4gLQkgIC5kYXRhID0gJm10ODE5NV9kcGludGZfY29uZiwNCj4gLQl9LA0KPiAt
CXsgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS1kcGkiLCAuZGF0YSA9
ICZtdDI3MDFfY29uZiB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRw
aSIsIC5kYXRhID0gJm10ODE3M19jb25mIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODMtZHBpIiwgLmRhdGEgPSAmbXQ4MTgzX2NvbmYgfSwNCj4gKwl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4Ni1kcGkiLCAuZGF0YSA9ICZtdDgxODZfY29uZiB9LA0KPiArCXsg
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWRwLWludGYiLCAuZGF0YSA9DQo+ICZtdDgx
ODhfZHBpbnRmX2NvbmYgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1k
cGkiLCAuZGF0YSA9ICZtdDgxOTJfY29uZiB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTk1LWRwLWludGYiLCAuZGF0YSA9DQo+ICZtdDgxOTVfZHBpbnRmX2NvbmYgfSwNCj4g
Kwl7IC8qIHNlbnRpbmVsICovIH0sDQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwg
bXRrX2RwaV9vZl9pZHMpOw0KPiAgDQo=
