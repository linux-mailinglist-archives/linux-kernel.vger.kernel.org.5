Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CCA762AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjGZF4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZF4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:56:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78361995
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:56:08 -0700 (PDT)
X-UUID: 19a515382b7911eeb20a276fd37b9834-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=c/e5hd3laZjjl7RGO2CsvrcTG6GtwVCDdHuO8Ch7xvE=;
        b=sKK9LEEyKWmjFNbSqyoGt0jN0SE95RsijQmKWc1DwNXJdOAFUjl/z5uGZKfXN4Mp7NnAo1Bg/xlwHV0PA7xfPcZd1sONmJ8bm5M92XCMWxoN0QLUPcgMIwvSl19fQ6vce1Z95ISUaVhQGO1QDS/LZdYsOt+udbldy8j9G68XN0A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:7c7ea6ef-27a8-4180-b86b-c75b5fda4e96,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:9d6d8aa0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 19a515382b7911eeb20a276fd37b9834-20230726
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1641883486; Wed, 26 Jul 2023 13:56:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 13:56:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 13:56:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGW/UHTaxd+mAqWCvafOYi3FHecKhlXjQ1iGnMfDulOoJjZF0VQmhm+23QwomHXb0SMu0OgJ/iBZZAEhmClEfG/u8YtkEcdQVywfE4FLfzpDOQu+JZIPO4Ogt6M579tYPRQ3gSrqlqrUyUeKayft8A1pbIDQh6TTs4nam05rO+3mF+56IL/gcrZV2M0MG4LBz+L0IFOBzJmmPp4iJUruOuE56/lyKLB23uMqZQimHKdU4gIq2f6itZ1IrEU94RXiiTVEQT3hTyjbgn65AJS6cG6A86OYjrjqL1fgCmRx6LT/30GJpuZp32ov7uUK/x82sv3hqNQX29bNjAYtM+8LPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/e5hd3laZjjl7RGO2CsvrcTG6GtwVCDdHuO8Ch7xvE=;
 b=AVBe6r09CW2Np8qlEtbUllN5+3RUMkE4NcNd4xlLkDhaF2lbo5N19R8/+k1HhczLKVNpwUh8fr7MNg+SfOSI41vGAVhjzPZq64oJdfnBB4yhOlrl3ouHWT+8RXQqYgn/EIbxGYbOLhtreDTc/vr5Rbf09u2zuac8AFASuNp0o5pvJxOGUdGnUFBty2PDNcwK5fsEVJpDHu/9n3OzS+4ZNwBChKhaQNIKuBO4VPoxezCAl4EcCdOaeYCQ/Y8ICFFys1ggZAAmwQhHKPlHycZGSXnf9DY1fDOW3StcbXdb8M7QrWuQRAYWNO/lijgwc12P2flJFQ7B9H5hqePCaVYXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/e5hd3laZjjl7RGO2CsvrcTG6GtwVCDdHuO8Ch7xvE=;
 b=oRF9fTFfWQEDk49Hb5OvbHQm2gOlah06NAvz6d7V4WWCzpFe1xheeKvdXU0mTLe3Lw8I5CFpTU8VGV8nW9+5vYCLg5U2nX9dss1HoYvd8pOdACzTqDgtdtY2wrB0k87mUM1OOXHltTTcTtMPyhVpKDKPXNz5LEo4WD8s8Hx/9SQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5536.apcprd03.prod.outlook.com (2603:1096:400:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 05:55:58 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Wed, 26 Jul 2023
 05:55:58 +0000
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
Subject: Re: [PATCH v2 5/6] drm/mediatek: mtk_dpi: Use
 devm_platform_ioremap_resource()
Thread-Topic: [PATCH v2 5/6] drm/mediatek: mtk_dpi: Use
 devm_platform_ioremap_resource()
Thread-Index: AQHZuhXZ99c3CUfYskOgAiIThPj2vq/Ll4YA
Date:   Wed, 26 Jul 2023 05:55:58 +0000
Message-ID: <7111a02d63503c231670abd68627654586461883.camel@mediatek.com>
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com>
         <20230719075056.72178-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719075056.72178-6-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5536:EE_
x-ms-office365-filtering-correlation-id: 6fdb29a5-8fb7-4159-2ce2-08db8d9cfc1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MErAWcX4nFHYXCgOL48ZGiFlF0kdYesE1HW/Lte8jwunUq4WMhmg61rFE1VH+hio+Agl0g/c18Rm9xEDAFVUG4eyIX07ExuuOlu0B3fHwUGQWG6pbH3RvGdyEKnSQknS6z5pxrjiBI4+w7di3EeNACKaBvgF+RRPhOUGVtNoI5OR0ouVVEf/KvRp8LHDTJKtzyTq3GAHK8DJpEnKlR+YG+DYJRN+I50UTbdWi5d40Y2aKA5jnjraiiapjiPI5MzTTkbw68gVnQTjovxsWRBMrSz26wSPEE4Du+jC8sLCxkM3E/xIVsupThKvxBrIdwOhpJs1LYbmQNn8EOpnQ6vpg99v0ZQtgQ/PpYvAbr7hcu+n+tKXEaa7haEbW72uhS+aXjKzWCZfwt1iSXon9woOARYQCW+2JJZRz973D9ZKBD5fDkTnuDCFXVSOzrE+Xfy+DrsuSakr9pMO1Wv9QXImAeJwiriyZTk+78V0fZ9MbdU+BvZWzdlgwf9Plr0BLS4qosl4nPAiF1P01f0NLSlB0F11MQQ1A/fc3y56rlkU4IC5p/HpOsJPMrGI5ulv6/n2wrhgv3Zfq1XavCtldaG3a22/F/NnWYK7ximrxA8H+4m664yShq2kaQ3BpnujVY33Wr15UM/fVYPxgg+EE6IOas5HvqMMpv/vAn+4QQ2fplA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(54906003)(71200400001)(110136005)(6512007)(26005)(6506007)(478600001)(2616005)(122000001)(38100700002)(83380400001)(36756003)(85182001)(6486002)(66476007)(86362001)(41300700001)(66946007)(66556008)(4326008)(64756008)(66446008)(76116006)(186003)(316002)(5660300002)(8676002)(8936002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHhpZ0dzTTNicEFsUGxrcmxoUHJxSE9SejVrQU8yd3BET3Q0N3RXMEdEK1pF?=
 =?utf-8?B?VmFnckRkeWdXRC9QQkhLWDB1YXJ4alJIT2pSQ1lJcE9HUjdGK3ByY2lJU1Ay?=
 =?utf-8?B?dDJWMkxlTmlyMUtiUVhhQ1RwZ1E5bk1jZW9tV1FpQ3pKdjJPUFBTSnJhYmY2?=
 =?utf-8?B?TnRRdTFrUEdMa0F1MmZ2UjhyWmMyVGpsZFI1Zm0rS3JzT2c0cW1TNUhMdFhL?=
 =?utf-8?B?U0tnYzdsQk1jamRuQkdwK3pySU1pWTFyYnBSMUpYMEtUd2Ftd0xHL01yV1Bp?=
 =?utf-8?B?Nk1qREhkdThSVkU3YlMvZmxtd1liSDkvWTdqMmpKbzYxZi9wdXF5dVM0QkNa?=
 =?utf-8?B?NlRYcTdTbDVIVEQ2ZkNOS0YvUWs2YkN4QktINWNwVDJ1YkdXSmJVaGFCSkRO?=
 =?utf-8?B?WHgrMnpDQndJM3UxWi9kdzMzRHV3eUJHSUtJQ0gxUkYreWUwaFpUSGcyWUFZ?=
 =?utf-8?B?ajJBbHpvVGwxejA4LzFpcDhwOGZzZlFmRjA3N1ZKN0hObFozWm84TW8xUGE1?=
 =?utf-8?B?YlBSZGxabzEzRjhvcmlXeGxtdThOTW8veElVTUdHeHQvUnpmMWpDVEJ5TlBV?=
 =?utf-8?B?NGc0OFFPeWxMd3o5R2x6M1JOc1BVdUhLUHpUa1ExZFQrQTF1a1k4U25SS2U5?=
 =?utf-8?B?OGJTT2tvUXRCR0VkK0pla2xaNnhPYng1M2NEbkFlUmhwYmhaTGJuMG1ad05x?=
 =?utf-8?B?VTZyanN0RkFlSU1HcXZGcXlRUnhlVUJOTHRkdDdaTGNXRkFiTTRjdnI0WnA0?=
 =?utf-8?B?YjE4Q3FpRlQ5Z0JDdktGLzNXTzhaZFpweCtvb0VBYUF1aytoTG9xMFgrYnQr?=
 =?utf-8?B?M29hZTN1VnhxODNiUlZ4K1RQcGJSc3B4T1VvOWFLSjZVTENvZE5lZUw1aGhL?=
 =?utf-8?B?SDYrRm5ZczlqdG5qNWp5dm9NOXUrTzZ3U3Zsd2xZSDBxYW1lVUZFbWpjSGp3?=
 =?utf-8?B?VnhiVXR5cU91T0dHQlN2ZkhMREJkTHpKQUE1UjhHdVZVU0VDcXhsOVg2dVVj?=
 =?utf-8?B?dG5LdHBhcDdVWDJLOE5FRlhJRFk3TU0vc2dSOG5SSzQycCs2MzFCMHhITDI1?=
 =?utf-8?B?WXQvNi8wak1lSTVvZHZBVlByOE1YZzFGeHRHRDNSRkFwTXJqS3ZwMjgreDRY?=
 =?utf-8?B?NXg4Z2dLeXRvY1VLaXVXNFBNTnZFdDNLVGRnUStCUzNrVVR6eWJxUU9Jc0xm?=
 =?utf-8?B?Q0h2R2pDdWRqdklBdHJpUGJNdklxTVdJb0dTNTJpNFJUSWp1MDU3WDU3a1li?=
 =?utf-8?B?RHdrTkttRlJhQUh2N0F4N3d6b3EwZW9aQnFSTnlHcGFHV0Vmb1NPeE51amVu?=
 =?utf-8?B?WXZ2SHBGeG81RGltTGlWZmlrUWZwSWh0TkxJMjVhdXYxSUV0RmJ0aXVZM2w2?=
 =?utf-8?B?TXV5TEgyVXJXKzRuaUtpKzFHSndHM3dRMXltTlpOUmRHMFI3Mnk4cElNcTg5?=
 =?utf-8?B?MFpVUGxDQUxVTk9YZzR0dGlrbDR1THV4emlNcE1DbmdERjhyTEcvT2tqL2Vo?=
 =?utf-8?B?M2RiZ1J6eDRuSVNSV2JrbEN2L2pzTk51dENDazk1NFBFTkJlbHY4K0RtRWho?=
 =?utf-8?B?Tjg1Ly9ZdjR1ZmIzU0xjd0ovaXdjR202MWh6a0pWWXZQODgvZ0V4RUZyQ3JU?=
 =?utf-8?B?UUU5bmJWRlFWM2Ura28yczdaUHZqY0VRbHNoRkYrdmJBZDR0UG91d3U5cFlO?=
 =?utf-8?B?NEQ5T3F4WUFoM1ByK05QeWNCQUNLUHEzZi9tSXlLWExFWmp0ZXFrWFBFTWJW?=
 =?utf-8?B?L0hyK3hFRXJuRkI2MzY5YjF0akZmdlJkYUNRN00rUzV0Y3RzVXJ6NDFZazdW?=
 =?utf-8?B?eWE0VWlwZUUrOHF6ZTlpNVpUeGtWWCtWRE5hZ3lzbjVYcTFwQkFQdnZsMDNv?=
 =?utf-8?B?ckFWQ3IrMDNhclFiSGxjOVVVYzdDUUZhelFkaHBTc2dzYlFxbkNHeEFsT0RL?=
 =?utf-8?B?ZDFFNnd3ZGJ2MHJPWDdKMWdIYVJzUmdQMlg1YmJnb1ZhaVkrQk02cTdWNHll?=
 =?utf-8?B?RUZYSXBoNnFFWE11emFVbkl1MEV6Q3FPS2VvbW5RVVE4QStvTXNIenRMZzB5?=
 =?utf-8?B?L1czNy9JbmllblhxRWRCMEVzdmJYNkRickx5THg0dENqdS9zNEE5TEJ5QWJa?=
 =?utf-8?Q?phlywZC5h48nmBpM+TMDuQnwH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E11805DF9AF3B94A993CCCDA9E813D3D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdb29a5-8fb7-4159-2ce2-08db8d9cfc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 05:55:58.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jd3ICj2KplOCtHv3vYxC/lP4vugQ0UE9BVToaFqxMhMOtIS7bzfmsdr5YwXycygybncgKn8FF0vJ9rxJ64FIWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5536
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
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSW5zdGVhZCBvZiB0aGUgb3Blbi1jb2RlZCBw
bGF0Zm9ybV9nZXRfcmVzb3VyY2UsDQo+IGRldm1faW9yZW1hcF9yZXNvdXJjZQ0KPiBzd2l0Y2gg
dG8gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCksIGFsc28gZHJvcHBpbmcgdGhlIHVz
ZWxlc3MNCj4gc3RydWN0IHJlc291cmNlIHBvaW50ZXIsIHdoaWNoIGJlY29tZXMgdW51c2VkLg0K
DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcGkuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+
IGluZGV4IDNhMTQwNDk4Yzk4YS4uMjQ0MzQwZGY3NDY4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMNCj4gQEAgLTEwMDcsNyArMTAwNyw2IEBAIHN0YXRpYyBpbnQgbXRrX2Rw
aV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAJc3RydWN0IG10a19kcGkgKmRwaTsNCj4g
LQlzdHJ1Y3QgcmVzb3VyY2UgKm1lbTsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICAJZHBpID0gZGV2
bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkcGkpLCBHRlBfS0VSTkVMKTsNCj4gQEAgLTEwMzgsOCAr
MTAzNyw3IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpwZGV2KQ0KPiAgCQkJZGV2X2RiZygmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgcGluY3Ry
bA0KPiBhY3RpdmUhXG4iKTsNCj4gIAkJfQ0KPiAgCX0NCj4gLQltZW0gPSBwbGF0Zm9ybV9nZXRf
cmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAtCWRwaS0+cmVncyA9IGRldm1f
aW9yZW1hcF9yZXNvdXJjZShkZXYsIG1lbSk7DQo+ICsJZHBpLT5yZWdzID0gZGV2bV9wbGF0Zm9y
bV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiAgCWlmIChJU19FUlIoZHBpLT5yZWdzKSkN
Cj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGRwaS0+cmVncyksDQo+ICAJ
CQkJICAgICAiRmFpbGVkIHRvIGlvcmVtYXAgbWVtDQo+IHJlc291cmNlXG4iKTsNCg==
