Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912777AA74F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 05:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjIVD2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 23:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVD2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 23:28:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B13102;
        Thu, 21 Sep 2023 20:28:25 -0700 (PDT)
X-UUID: 1448e9dc58f811eea33bb35ae8d461a2-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=H/E1n2JELdBV97AGNBfXa+/GxJzlbEhue77xf7n8sYg=;
        b=uIMIYVyb69nJcdZzebinADx7pipUSsoj8xS5emAgRoqaXUCBiD2KG43GoLKlzAx+rfy8qdMKhkD2mz1VqA9UyQpFemY6I9pgYa4uWczaPm5vhKd2Ok6GRj+mrUZKEkQIi/HZFUFRJ8Uj2kuq8pzoq2oQs1PdLPp0xO1QM/pUoRo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:910c59a1-aa62-4ee5-95e4-17d334c0d80a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:2d7c52c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1448e9dc58f811eea33bb35ae8d461a2-20230922
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 312334647; Fri, 22 Sep 2023 11:28:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 11:28:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 11:28:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWGg4v4XfYhiU/c9l1Pr0Wms7Bm/vjOP3qaVvrfTmHK3tcPUDst0nhWiPwENR1lIsv18LRUFDhWoXbjTeYtL5zQNvs9KoSN7A5pK5keuYLr8RMUGhvvv+XUfszBT8M/dh3nT8e3KYoIX2tZ6tvJV9F5f2AoZn9Tscu5zfsdUZN0MH/ctWfjuAfD/NhofVYB4rp4UAH0O3XRLd/3SA//zHkdhPUQ1O4faetQkdZTMLWFwrHSx8xpKotfQkyJYhBfLKqkM42W70MGJwi3UM/brUpzE4cjQ8pelz/kQknXmfKkVscTP4eijGe8q7CxT7sP3E+Y9ld7wPUvJOPZg9cbpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/E1n2JELdBV97AGNBfXa+/GxJzlbEhue77xf7n8sYg=;
 b=D0iX5OmxgGz1OBaTt9ELHcN9Fm4iS4XXVSasrHtr/uEXXv8Kh5Wa1Gdk5SUKkDyzwmuekGgd9ABPE5vMGWxS5DuscdvvDtMius/YIyPV5rHoLgW5pyZm/8olERXfBs7zli4tUh1kMUGllCH/sSo5MM/jRAuHiXX+PabJ/rAw1YPT5FEyyoFPae0MbaYu5f5219eXW7yqlgwXClAo/BvWvQLp1pbMy8WCm0b7KY5sbCszxBVXkoYJHcWhKr7pLHUQ+jdIflM7SjQAGV1Iq8r7m793A4ts9lNYe0KvWMA+bQVoWPDNNyKwJJFBmzpIKvBQPsBXHZAhfdLrSDlR52rb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/E1n2JELdBV97AGNBfXa+/GxJzlbEhue77xf7n8sYg=;
 b=W4Zgc+NM0bC+64wnLuQAnk4BJ/NW229SXsHE8HzWMnNoG93n5WgY91u7rsmujunOjey8n7n9XuRKiA0bXZF63W/kNspBj/9fUIwmsGPODM+Hrp5lcy+ux8ZnS3G1pVpkr/ipe4bSDyrhlHacvCxQbJxj2JAwa2c8ISDhdhyWzrs=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by KL1PR03MB5618.apcprd03.prod.outlook.com (2603:1096:820:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 03:28:17 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::d451:c5cd:4a93:2a62]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::d451:c5cd:4a93:2a62%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 03:28:16 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "jkardatzke@google.com" <jkardatzke@google.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder
 driver
Thread-Topic: [PATCH 12/14] media: medkatek: vcodec: set secure mode to
 decoder driver
Thread-Index: AQHZ5K/xmXjsPSANs0u2pLMArEpvXrAVxwwAgAEnPICABKSZAIAACFCAgAWA4QCAAMgiAIAApxOAgADRTwCAAuOtAA==
Date:   Fri, 22 Sep 2023 03:28:15 +0000
Message-ID: <00302ac675af858eb11d8398f100921af806bc30.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-13-yunfei.dong@mediatek.com>
         <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
         <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
         <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
         <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
         <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
         <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl>
         <b7d661637eacbda3e83d192b1126fc3970c4f50d.camel@collabora.com>
         <c3d14f64-bf04-46b9-ac7b-af7ef9014335@xs4all.nl>
In-Reply-To: <c3d14f64-bf04-46b9-ac7b-af7ef9014335@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|KL1PR03MB5618:EE_
x-ms-office365-filtering-correlation-id: 010525cb-2352-45f1-c87b-08dbbb1bf577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hu1kOr49PnGBMk56qSccdFeopWO9pReRWY9PsHm1SC/E761brxYvrOpdjVLYS2NqeC1rF0KDU0n0weVV5U9kRlFWtwByUF5hX6TCGPC+FROkeoQEF2MuRhxwNMotkyD8OIs7Ew0A4psWGCiiIo3x6QYDEmHms1btSgaCxIA91F56vCvt5iVEyVgm045QK9MI0Jx32FlO0bAa/sppHLFeW2bU/DlM+qS1P7FWJNq0QIMb2/Az/3VN53QEOIHeewxmP2DnuJPdVexDM2eVSnZ38R3BeNZslJqM+IuXITHaRt/2tchZuY/Os0mNbkrFyxGGwclsWwkRcY6z4Kd2ANpdfqhBs3WBswxXA2SrSsbx4XfcU2CWuDYIzG84lnu7QOQLnmNje9TUcrYYNqHgoS/LDlaNP1oGr6nIvjhjYceI9y9NN7pcQC/evzWG9p6KNt62btDST0oQe1tAUG7eFgQcb6HvQ+kr6xfS6GXv16RYlcRgfnefjB8bntupEkJSr32z59+dgMSwehp0ydfksT/lXqosuQBsgDp5HYk3nY50dLTRc+Zo+CF9qtWGD1UyYVIV3yjrocz1GQtn+iN7G3gi62CHrWtZaiVFH5yPs2ahlL/3y0lHpbjmMh3bqAL5vs31a6UHXEb/qocsZWakbYB6Sb/AM7PttyQZBA1cCk7Tz+WoAtZMwSYZcLtF+iRPnwHr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199024)(1800799009)(186009)(2906002)(5660300002)(26005)(7416002)(41300700001)(66446008)(316002)(54906003)(64756008)(66476007)(66946007)(76116006)(66556008)(91956017)(110136005)(8936002)(8676002)(4326008)(478600001)(966005)(71200400001)(66899024)(6506007)(6486002)(6512007)(2616005)(36756003)(85182001)(122000001)(86362001)(38070700005)(38100700002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YldPR0dyWnhTdFVzV0hJNWFCNXR2WnBmVS9OSHhSNUl6QlIyUUtEWnlmMTZu?=
 =?utf-8?B?RGJjOVB0eDJIRG9KNkQ1cTk5a21tUnBYNDU3RWJYUzNRczhTUHVlSjAxbFY5?=
 =?utf-8?B?UW5VV1pGK0tkYjBuM29uT1hHNEtDRU5DV3RyTlhjZlNJQ3pGRHIxZDRIb1VH?=
 =?utf-8?B?RThmMHVTSVFYU0ZUbmowR0pENTFBZFJKbHV0a09VRHMweElmb1Q2UHY0Rm4r?=
 =?utf-8?B?b0svUXFiT0Y5MkZrcUVkVEpBRUMwUDVVSnR1aGJ4NCswZUtaRXVoSVJ3Z21v?=
 =?utf-8?B?b3VWc2ZWZjU0Z3A0em5lS2ZJY0Y5R1hzMTFOUG9rZzMvZzdWSG5Pb1c0aVRP?=
 =?utf-8?B?OXAzQ0ZiS3ZFSkpmQWhtRGM1dm5BMXQrb3VCdXlzUzRrUEt4MzJWOVdEVWNH?=
 =?utf-8?B?YkVyNThPTmtNc3ZXYndlYkcwK2JSTWNJU1F0cXdraURRSEJMdDlPMkF2VVhK?=
 =?utf-8?B?eVh2OXovOEdZTVF5QXZyU0VZSFAwb2hBWDFVMzZhRDE1YmtYMkJJM3IvWWVa?=
 =?utf-8?B?cEZ0WTQ1eW1Lc2hoTWlpaGVFeThsSnJqVGwyelJhQVhXSVlqMm1TWm9GSWdT?=
 =?utf-8?B?MTdjTFhScWpTYjhmQ3RWbmFmZEVlRnhpNjJtMmlXbXpHSFg1NFBKeit5OVFG?=
 =?utf-8?B?WHFVK0FVRVhBbDRtaWtKTE5qY1VEa29wZWp5dE1EL1JWSkxnRi9NTzBNSWd1?=
 =?utf-8?B?RzYyY3V1ZHVrTDZWY3RTRDU1aUtGbjA5SFNGczBKSzBsZ2RyOWg3T0tCQjlv?=
 =?utf-8?B?cFdMb0pxMkdiSi9Wb1JHVUF4czUrSlVQd1FyZGp6NUhWdU9hN3AwRjVrUWo1?=
 =?utf-8?B?MUlRRTdRamdaNmZUQWpLSWNNT01jRmRlK1NtZlNxTVpRVHRqNDgrQ1N3bitq?=
 =?utf-8?B?NXhDOVliL1p4emZpeXFqd0FLNE9NZTVuRjBYVnRIeDJCWVhwcWVVem5xcmZW?=
 =?utf-8?B?Y0xkT2VNMGNiZ3NZaFE1eW9zeEtzMWdnUWVYaXZQODNkbGZDYWhHY0tCQjlt?=
 =?utf-8?B?OGs2OTgwRTIySE4wWDVVR0d1SUp5S2JnRmlKQytHR01OU0xKZ0FHQVc0VkJ2?=
 =?utf-8?B?OFpLOUljazNLZWVXd3NDclhjV0NmUWhaUnpRTFg5a1ZoRUw1dld2T1dBZmVx?=
 =?utf-8?B?ckZhVm1aUHZnanJaeWpTTXhUSFBVLzFxVyszTmVjaHFjL2lSZUtWNUh6dzhK?=
 =?utf-8?B?K0xGZUFjSGlQeFBSbTRFOVRqYjk2cUxxU3FmT3pKQWhmcm1tN25lSCtyZFF0?=
 =?utf-8?B?VGU4dHVxVzBjNThreEIwRy9tZlZuY0FTOEpTWUJjOXBJQ3JHV1ZGaGxoZDZ4?=
 =?utf-8?B?VUJBWVY3citHL3FxTUNiQ3JVRjdSR3A1QmJwOFRXWWdXblFNVVRGTUdpQVZw?=
 =?utf-8?B?UUx3ek9oRitwcHhtTXVwQ002b3VBZmUvWU0vNDlFTklqcURPRGVYam1ORHBL?=
 =?utf-8?B?Ui9jZ3Z5K296ajIzL3BacThId3dmanBGdlcwWkFZZlplYm92RXQrMStGbHFl?=
 =?utf-8?B?d2UwQ1JsNlRZek9qdnI2bHNIYXBYNjVCdEQ5c3BsSzFEbHUrblFJUjAwSGxq?=
 =?utf-8?B?RW41L0VPYXVCL2s2UFBPeml0cmhabjZ5VEFxS0UwdHFSV2pjZE82QW4vTlhX?=
 =?utf-8?B?MkxGbEZLbXRMYU4wUVA2cTJ2R2I1a09QVVBUa2VETzRKcnl4Mzk2QlF0MW5P?=
 =?utf-8?B?amdERTlrckdWQXZFYU9CZkwyWi9odzFobXA4N0xaRG9IdGNDR2tKQjRkMTZs?=
 =?utf-8?B?a3JlM1Qvay9IRjVHR3kzTzIzNlJKM3htWDFqa1pPZkhtd1U5NXUyR2M3TlFW?=
 =?utf-8?B?c3d0dmphN1N2UkczalNnQmcrWHVRVEdNTTdSKzFvUDVDZklaemdmeDFjMlQw?=
 =?utf-8?B?N1pPeXNqcFZoS0x3VWV5dWlUekNkV1JjUGlURVZhTkJjUUxNaWFNNXBvcmhV?=
 =?utf-8?B?andJZUJwVUpPMWpzV2lqdGsrVmNMeGZDOGxiaGFITW12NmRSODZ1MXdFczhu?=
 =?utf-8?B?VEhQdC9iS3A0Yzc5T01ZdEluQWtZUlM5emc3ayt5MjNLNlZjRzE4WG9VcDV2?=
 =?utf-8?B?ODV2NWZvOE5pOHFRRzdoOVJnVWtnUERNOENvdUxiemlkQkJSR2FNNHhFczF1?=
 =?utf-8?B?VEk2REtKMkN5YVVFSlpVUmhmb21CVEF0R1pVb094RXhrOXBOemhOWmh3Slha?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81F8F944D3CE7B45943C66A2B7957733@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010525cb-2352-45f1-c87b-08dbbb1bf577
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 03:28:15.9520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFHfkfJYOG9WwkuScRGJHn6P9Gh5JebfxdXLBbApGsSmtUcwI3e9zYOK72rOb0wVsM+2y85fjbpc3tkxnhpjFPBH0GcxLPVbfbVBi/x6MhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5618
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KVGhhbmtzIGZvciB5b3VyIGhlbHAgdG8gZ2l2ZSBzb21lIGdvb2QgYWR2aWNl
Lg0KT24gV2VkLCAyMDIzLTA5LTIwIGF0IDA5OjIwICswMjAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6
DQo+ICAJIA0KPiA+Pj4+IEluIGFueSBjYXNlLCB1c2luZyBhIGNvbnRyb2wgdG8gc3dpdGNoIHRv
IHNlY3VyZSBtb2RlIGFuZCB1c2luZw0KPiBhIGNvbnRyb2wNCj4gPj4+PiB0byBjb252ZXJ0IGEg
ZG1hYnVmIGZkIHRvIGEgc2VjdXJlIGhhbmRsZSBzZWVtcyBhIHBvb3IgY2hvaWNlIHRvDQo+IG1l
Lg0KPiA+Pj4+DQo+ID4+Pj4gSSB3YXMgd29uZGVyaW5nIGlmIGl0IHdvdWxkbid0IGJlIGJldHRl
ciB0byBjcmVhdGUgYSBuZXcNCj4gVjRMMl9NRU1PUllfIHR5cGUsDQo+ID4+Pj4gZS5nLiBWNEwy
X01FTU9SWV9ETUFCVUZfU0VDVVJFIChvciBwZXJoYXBzIF9ETUFCVUZfT1BURUUpLiBUaGF0DQo+
IGVuc3VyZXMgdGhhdA0KPiA+Pj4+IG9uY2UgeW91IGNyZWF0ZSBidWZmZXJzIGZvciB0aGUgZmly
c3QgdGltZSwgdGhlIGRyaXZlciBjYW4NCj4gc3dpdGNoIGludG8gc2VjdXJlDQo+ID4+Pj4gbW9k
ZSwgYW5kIHVudGlsIGFsbCBidWZmZXJzIGFyZSByZWxlYXNlZCBhZ2FpbiB5b3Uga25vdyB0aGF0
IHRoZQ0KPiBkcml2ZXIgd2lsbA0KPiA+Pj4+IHN0YXkgaW4gc2VjdXJlIG1vZGUuDQo+ID4+Pg0K
PiA+Pj4gV2h5IGRvIHlvdSB0aGluayB0aGUgY29udHJvbCBmb3Igc2V0dGluZyBzZWN1cmUgbW9k
ZSBpcyBhIHBvb3INCj4gY2hvaWNlPw0KPiA+Pj4gVGhlcmUncyB2YXJpb3VzIHBsYWNlcyBpbiB0
aGUgZHJpdmVyIGNvZGUgd2hlcmUgZnVuY3Rpb25hbGl0eQ0KPiBjaGFuZ2VzDQo+ID4+PiBiYXNl
ZCBvbiBiZWluZyBzZWN1cmUvbm9uLXNlY3VyZSBtb2RlLCBzbyB0aGlzIGlzIHZlcnkgbXVjaCBh
DQo+ICdnbG9iYWwnDQo+ID4+PiBzZXR0aW5nIGZvciB0aGUgZHJpdmVyLiBJdCBjb3VsZCBiZSBp
bmZlcnJlZCBiYXNlZCBvZmYgYSBuZXcNCj4gbWVtb3J5DQo+ID4+PiB0eXBlIGZvciB0aGUgcXVl
dWVzLi4ud2hpY2ggdGhlbiBzZXRzIHRoYXQgZmxhZyBpbiB0aGUgZHJpdmVyOw0KPiBidXQNCj4g
Pj4+IHRoYXQgc2VlbXMgbGlrZSBpdCB3b3VsZCBiZSBtb3JlIGZyYWdpbGUgYW5kIHdvdWxkIHJl
cXVpcmUNCj4gY2hlY2tpbmcNCj4gPj4+IGZvciBpbmNvbXBhdGlibGUgb3V0cHV0L2NhcHR1cmUg
bWVtb3J5IHR5cGVzLiBJJ20gbm90IGFnYWluc3QNCj4gYW5vdGhlcg0KPiA+Pj4gd2F5IG9mIGRv
aW5nIHRoaXM7IGJ1dCBkaWRuJ3Qgc2VlIHdoeSB5b3UgdGhpbmsgdGhlIHByb3Bvc2VkDQo+IG1l
dGhvZCBpcw0KPiA+Pj4gYSBwb29yIGNob2ljZS4NCj4gPj4NCj4gPj4gSSBhc3N1bWUgeW91IGFy
ZSBlaXRoZXIgZGVjb2RpbmcgdG8gc2VjdXJlIG1lbW9yeSBhbGwgdGhlIHRpbWUsIG9yDQo+IG5v
dA0KPiA+PiBhdCBhbGwuIFRoYXQncyBzb21ldGhpbmcgeW91IHdvdWxkIHdhbnQgdG8gc2VsZWN0
IHRoZSBtb21lbnQgeW91DQo+IGFsbG9jYXRlDQo+ID4+IHRoZSBmaXJzdCBidWZmZXIuIFVzaW5n
IHRoZSBWNEwyX01FTU9SWV8gdmFsdWUgd291bGQgYmUgdGhlDQo+IG5hdHVyYWwgcGxhY2UNCj4g
Pj4gZm9yIHRoYXQuIEEgY29udHJvbCBjYW4gdHlwaWNhbGx5IGJlIHRvZ2dsZWQgYXQgYW55IHRp
bWUsIGFuZCBpdA0KPiBtYWtlcw0KPiA+PiBubyBzZW5zZSB0byBkbyB0aGF0IGZvciBzZWN1cmUg
c3RyZWFtaW5nLg0KPiA+Pg0KPiA+PiBSZWxhdGVkIHRvIHRoYXQ6IGlmIHlvdSBwYXNzIGEgZG1h
YnVmIGZkIHlvdSB3aWxsIG5lZWQgdG8gY2hlY2sNCj4gc29tZXdoZXJlDQo+ID4+IGlmIHRoZSBm
ZCBwb2ludHMgdG8gc2VjdXJlIG1lbW9yeSBvciBub3QuIFlvdSBkb24ndCB3YW50IHRvIG1peA0K
PiB0aGUgdHdvDQo+ID4+IGJ1dCB5b3Ugd2FudCB0byBjaGVjayB0aGF0IGF0IFZJRElPQ19RQlVG
IHRpbWUuDQo+ID4+DQo+ID4+IE5vdGUgdGhhdCB0aGUgVjRMMl9NRU1PUllfIHZhbHVlIGlzIGFs
cmVhZHkgY2hlY2tlZCBpbiB0aGUgdjRsMg0KPiBjb3JlLA0KPiA+PiBkcml2ZXJzIGRvIG5vdCBu
ZWVkIHRvIGRvIHRoYXQuDQo+ID4gDQo+ID4gSnVzdCB0byBjbGFyaWZ5IGEgYml0LCBhbmQgbWFr
ZSBzdXJlIEkgdW5kZXJzdGFuZCB0aGlzIHRvby4gWW91IGFyZQ0KPiBwcm9wb3NpbmcgdG8NCj4g
PiBpbnRyb2R1Y2Ugc29tZXRoaW5nIGxpa2U6DQo+ID4gDQo+ID4gICAgVjRMMl9NRU1PUllfU0VD
VVJFX0RNQUJVRg0KPiA+IA0KPiA+IFdoaWNoIGxpa2UgVjRMMl9NRU1PUllfRE1BQlVGIGlzIG1l
YW50IHRvIGltcG9ydCBkbWFidWYsIHdoaWxlDQo+IHRlbGxpbmcgdGhlDQo+ID4gZHJpdmVyIHRo
YXQgdGhlIG1lbW9yeSBpcyBzZWN1cmUgYWNjb3JkaW5nIHRvIHRoZSBkZWZpbml0aW9uIG9mDQo+
ICJzZWN1cmUiIGZvciB0aGUNCj4gPiBwbGF0Zm9ybSBpdHMgcnVubmluZyBvbi4NCj4gPiANCj4g
PiBUaGlzIGRyaXZlcnMgYWxzbyBhbGxvY2F0ZSBzZWN1cmUgU0hNIChhIHN0YW5kYXJkIHRlZSBj
b25jZXB0KSBhbmQNCj4gaGF2ZSBpbnRlcm5hbA0KPiA+IGFsbG9jYXRpb24gZm9yIHJlY29uc3Ry
dWN0aW9uIGJ1ZmZlciBhbmQgc29tZSBodyBzcGVjaWZpYyByZWZlcmVuY2UNCj4gbWV0YWRhdGEu
IFNvDQo+ID4gdGhlIGlkZWEgd291bGQgYmUgdGhhdCBpdCB3b3VsZCBrZWVwIGFsbG9jYXRpb24g
dXNpbmcgdGhlIGRtYWJ1Zg0KPiBoZWFwIGludGVybmFsDQo+ID4gQVBJcyA/IEFuZCBkZWNpZGUg
d2hpY2ggdHlwZSBvZiBtZW1vcnkgYmFzZWQgb24gdGhlIG1lbW9yeSB0eXBlDQo+IGZvdW5kIGlu
IHRoZQ0KPiA+IHF1ZXVlPw0KPiANCj4gWWVzLiBPbmNlIHlvdSByZXF1ZXN0IHRoZSBmaXJzdCBi
dWZmZXIgeW91IGJhc2ljYWxseSB0ZWxsIHRoZSBkcml2ZXINCj4gd2hldGhlciBpdA0KPiB3aWxs
IG9wZXJhdGUgaW4gc2VjdXJlIG9yIG5vbi1zZWN1cmUgbW9kZSwgYW5kIHRoYXQgc3RheXMgdGhh
dCB3YXkNCj4gdW50aWwgYWxsDQo+IGJ1ZmZlcnMgYXJlIGZyZWVkLiBJIHRoaW5rIHRoYXQgbWFr
ZXMgc2Vuc2UuDQo+IA0KDQpBY2NvcmRpbmcgdG8gaW9tbXUncyBpbmZvcm1hdGlvbiwgdGhlIGRt
YSBvcGVyYXRpb24gZm9yIHNlY3VyZSBhbmQgbm9uLQ0Kc2VjdXJlIGFyZSB0aGUgc2FtZSwgd2hl
dGhlciBqdXN0IG5lZWQgdG8gYWRkIG9uZSBtZW1vcnkgdHlwZSBpbiB2NGwyDQpmcmFtZXdvcmsg
dGhlIHNhbWUgYXMgVjRMMl9NRU1PUllfRE1BQlVGPyBUaGUgZG1hIG9wZXJhdGlvbiBpbg0Kdmlk
ZW9idWYyLWRtYS1jb250aWcuYyBjYW4gdXNlIHRoZSBzYW1lIGZ1bmN0aW9ucy4NCg0KQmVzdCBS
ZWdhcmRzLA0KWXVuZmVpIERvbmcNCg0KPiBJZiB0aGVyZSBpcyBhIG5lZWQgaW4gdGhlIGZ1dHVy
ZSB0byBoYXZlIFY0TDIgYWxsb2NhdGUgdGhlIHNlY3VyZQ0KPiBidWZmZXJzLCB0aGVuDQo+IGEg
c2ltaWxhciBWNEwyX01FTU9SWV9NTUFQX1NFQ1VSRSB0eXBlIGNhbiBiZSBhZGRlZC4gSSB0aGlu
ayB1c2luZw0KPiB2NGwyX21lbW9yeQ0KPiB0byBzZWxlY3Qgc2VjdXJlIG9yIG5vbi1zZWN1cmUg
bW9kZSBpcyBsb2dpY2FsIGFuZCBmaXRzIHdlbGwgd2l0aCB0aGUNCj4gVjRMMiBBUEkuDQo+ID4g
U3RlcHBpbmcgYmFjayBhIGxpdHRsZSwgd2h5IGNhbid0IHdlIGhhdmUgYSB3YXkgZm9yIGRyaXZl
cnMgdG8NCj4gZGV0ZWN0IHRoYXQNCj4gPiBkbWFidWYgYXJlIHNlY3VyZSA/IEknbSB3b25kZXJp
bmcgaWYgaXRzIGFjdHVhbGx5IHVzZWZ1bCB0byBpbXBvc2UNCj4gdG8gYWxsDQo+ID4gdXNlcnNw
YWNlIGNvbXBvbmVudCB0byBrbm93IHRoYXQgYSBkbWFidWYgaXMgc2VjdXJlID8NCj4gDQo+IEkg
d2FzIHdvbmRlcmluZyB0aGUgc2FtZSB0aGluZzogdGhlcmUgc2hvdWxkIGJlIGEgc2ltcGxlIHdh
eSBmb3INCj4gZHJpdmVycyBhbmQNCj4gdXNlcnNwYWNlIHRvIGNoZWNrIGlmIGEgZG1hYnVmIGZk
IGlzIHNlY3VyZSBvciBub3QuIFRoYXQgd2lsbA0KPiBjZXJ0YWlubHkgaGVscA0KPiB0aGUgdmIy
IGZyYW1ld29yayB2ZXJpZnkgdGhhdCB5b3UgZG9uJ3QgbWl4IHNlY3VyZSBhbmQgbm9uLXNlY3Vy
ZQ0KPiBkbWFidWYgZmRzLg0KPiANCj4gPiANCj4gPiBBbHNvLCByZWdhcmRpbmcgTVRLLCB0aGVz
ZSBhcmUgc3RhdGVsZXNzIGRlY29kZXJzLiBJIHRoaW5rIGl0IHdvdWxkDQo+IGJlIG5pY2UgdG8N
Cj4gPiBzaG93IHVzZSBleGFtcGxlIGNvZGUgdGhhdCBjYW4gcHJvcGVybHkgcGFyc2UgdGhlIHVu
LWVuY3J5cHRlZA0KPiBoZWFkZXIsIHBhc3MgdGhlDQo+ID4gZGF0YSB0byB0aGUgZGVjcnlwdG9y
IGFuZCBkZWNvZGUuIFRoZXJlIGlzIGEgYml0IG9mIG1lY2hhbmljIGluDQo+IHRoZXJlIHRoYXQg
bGFja3MNCj4gPiBjbGFyaWZpY2F0aW9uLCBhIHJlZmVyZW5jZSBpbXBsZW1lbnRhdGlvbiB3b3Vs
ZCBjbGVhcmx5IGhlbHAuDQo+IEZpbmFsbHksIGRvZXMgdGhpcw0KPiA+IHBsYXRmb3JtIG9mZmVy
cyBzb21lIGNsZWFya2V5IGltcGxlbWVudGF0aW9uIChvciBvdGhlciBhbHRlcm5hdGl2ZSkNCj4g
c28gd2UgY2FuIGRvDQo+ID4gdmFsaWRhdGlvbiBhbmQgcmVncmVzc2lvbiB0ZXN0aW5nPyBJdCB3
b3VsZCBiZSB2ZXJ5IHVuZm9ydHVuYXRlIHRvDQo+IGFkZCBmZWF0dXJlDQo+ID4gdXBzdHJlYW0g
dGhhdCBjYW4gb25seSBiZSB0ZXN0ZWQgYnkgcHJvcHJpZXRhcnkgQ0RNIHNvZnR3YXJlLg0KPiAN
Cj4gR29vZCBwb2ludHMuDQo+IA0KPiBIYW5zDQo+IA0KPiA+IA0KPiA+IE5pY29sYXMNCj4gPiAN
Cj4gPj4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBGb3IgY29udmVydGluZyB0aGUgZG1hYnVmIGZk
IGludG8gYSBzZWN1cmUgaGFuZGxlOiBhIG5ldyBpb2N0bA0KPiBzaW1pbGFyIHRvDQo+ID4+Pj4g
VklESU9DX0VYUEJVRiBtaWdodCBiZSBtb3JlIHN1aXRlZCBmb3IgdGhhdC4NCj4gPj4+DQo+ID4+
PiBJIGFjdHVhbGx5IHRoaW5rIHRoZSBiZXN0IHdheSBmb3IgY29udmVydGluZyB0aGUgZG1hYnVm
IGZkIGludG8gYQ0KPiA+Pj4gc2VjdXJlIGhhbmRsZSB3b3VsZCBiZSBhbm90aGVyIGlvY3RsIGlu
IHRoZSBkbWEtaGVhcA0KPiBkcml2ZXIuLi5zaW5jZQ0KPiA+Pj4gdGhhdCdzIHdoZXJlIHRoZSBt
ZW1vcnkgaXMgYWN0dWFsbHkgYWxsb2NhdGVkIGZyb20uIEJ1dCB0aGlzDQo+IHJlYWxseQ0KPiA+
Pj4gZGVwZW5kcyBvbiB1cHN0cmVhbSBtYWludGFpbmVycyBhbmQgd2hhdCB0aGV5IGFyZSBjb21m
b3J0YWJsZQ0KPiB3aXRoLg0KPiA+Pg0KPiA+PiBUaGF0IGZlZWxzIGxpa2UgYSBtb3JlIG5hdHVy
YWwgcGxhY2Ugb2YgZG9pbmcgdGhpcy4NCj4gPj4NCj4gPj4gUmVnYXJkcywNCj4gPj4NCj4gPj4g
SGFucw0KPiA+Pg0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IE5vdGUgdGhhdCBJIGFtIHRoZSBmaXJz
dCB0byBhZG1pdCB0aGF0IEkgaGF2ZSBubyBleHBlcmllbmNlIHdpdGgNCj4gc2VjdXJlDQo+ID4+
Pj4gdmlkZW8gcGlwZWxpbmVzIG9yIG9wdGVlLW9zLCBzbyBJIGFtIGxvb2tpbmcgYXQgdGhpcyBw
dXJlbHkgZnJvbQ0KPiBhbiB1QVBJDQo+ID4+Pj4gcGVyc3BlY3RpdmUuDQo+ID4+Pj4NCj4gPj4+
PiBSZWdhcmRzLA0KPiA+Pj4+DQo+ID4+Pj4gICAgICAgICBIYW5zDQo+ID4+Pj4NCj4gPj4+Pj4N
Cj4gPj4+Pj4gQmVzdCBSZWdhcmRzLA0KPiA+Pj4+PiBZdW5mZWkgRG9uZw0KPiA+Pj4+Pj4gUmVn
YXJkcywNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBIYW5zDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4+DQo+ID4+
Pj4+Pj4gcmVnYXJkcywNCj4gPj4+Pj4+PiBOaWNvbGFzDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBw
LnMuIHlvdSBmb3Jnb3QgdG8gZG9jdW1lbnQgeW91ciBjb250cm9sIGluIHRoZSBSU1QgZG9jLA0K
PiBwbGVhc2UgZG8NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBpbiBmb2xsb3dpbmcNCj4gPj4+Pj4+PiBy
ZWxlYXNlLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4+ICtjdHgtPmlzX3N2cF9tb2RlID0gY3RybC0+
dmFsOw0KPiA+Pj4+Pj4+PiArDQo+ID4+Pj4+Pj4+ICtpZiAoY3R4LT5pc19zdnBfbW9kZSkgew0K
PiA+Pj4+Pj4+PiArcmV0ID0gbXRrX3Zjb2RlY19kZWNfb3B0ZWVfb3BlbihjdHgtPmRldi0+b3B0
ZWVfcHJpdmF0ZSk7DQo+ID4+Pj4+Pj4+ICtpZiAocmV0KQ0KPiA+Pj4+Pj4+PiArbXRrX3Y0bDJf
dmRlY19lcnIoY3R4LCAib3BlbiBzZWN1cmUgbW9kZSBmYWlsZWQuIik7DQo+ID4+Pj4+Pj4+ICtl
bHNlDQo+ID4+Pj4+Pj4+ICttdGtfdjRsMl92ZGVjX2RiZygzLCBjdHgsICJkZWNvZGVyIGluIHNl
Y3VyZSBtb2RlOiAlZCIsDQo+IGN0cmwtDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiB2YWwpOw0KPiA+
Pj4+Pj4+PiArfQ0KPiA+Pj4+Pj4+PiArYnJlYWs7DQo+ID4+Pj4+Pj4+ICBkZWZhdWx0Og0KPiA+
Pj4+Pj4+PiAgbXRrX3Y0bDJfdmRlY19kYmcoMywgY3R4LCAiTm90IHN1cHBvcnRlZCB0byBzZXQg
Y3RybCBpZDoNCj4gPj4+Pj4+Pj4gMHgleFxuIiwNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBoZHJfY3Ry
bC0+aWQpOw0KPiA+Pj4+Pj4+PiAgcmV0dXJuIHJldDsNCj4gPj4+Pj4+Pj4gQEAgLTU3Myw3ICs1
ODQsNyBAQCBzdGF0aWMgaW50DQo+IG10a192Y29kZWNfZGVjX2N0cmxzX3NldHVwKHN0cnVjdA0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IG10a192Y29kZWNfZGVjX2N0eCAqY3R4KQ0KPiA+Pj4+Pj4+PiAg
dW5zaWduZWQgaW50IGk7DQo+ID4+Pj4+Pj4+ICBzdHJ1Y3QgdjRsMl9jdHJsICpjdHJsOw0KPiA+
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiAtdjRsMl9jdHJsX2hhbmRsZXJfaW5pdCgmY3R4LT5jdHJsX2hk
bCwgTlVNX0NUUkxTICsgMSk7DQo+ID4+Pj4+Pj4+ICt2NGwyX2N0cmxfaGFuZGxlcl9pbml0KCZj
dHgtPmN0cmxfaGRsLCBOVU1fQ1RSTFMgKyAyKTsNCj4gPj4+Pj4+Pj4gIGlmIChjdHgtPmN0cmxf
aGRsLmVycm9yKSB7DQo+ID4+Pj4+Pj4+ICBtdGtfdjRsMl92ZGVjX2VycihjdHgsICJ2NGwyX2N0
cmxfaGFuZGxlcl9pbml0IGZhaWxlZFxuIik7DQo+ID4+Pj4+Pj4+ICByZXR1cm4gY3R4LT5jdHJs
X2hkbC5lcnJvcjsNCj4gPj4+Pj4+Pj4gQEAgLTU5Miw2ICs2MDMsOCBAQCBzdGF0aWMgaW50DQo+
IG10a192Y29kZWNfZGVjX2N0cmxzX3NldHVwKHN0cnVjdA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IG10
a192Y29kZWNfZGVjX2N0eCAqY3R4KQ0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiAgY3RybCA9IHY0
bDJfY3RybF9uZXdfc3RkKCZjdHgtPmN0cmxfaGRsLA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICZtdGtf
dmNvZGVjX2RlY19jdHJsX29wcywNCj4gPj4+Pj4+Pj4gICBWNEwyX0NJRF9NUEVHX01US19HRVRf
U0VDVVJFX0hBTkRMRSwgMCwgNjU1MzUsIDEsIDApOw0KPiA+Pj4+Pj4+PiArY3RybCA9IHY0bDJf
Y3RybF9uZXdfc3RkKCZjdHgtPmN0cmxfaGRsLA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICZtdGtfdmNv
ZGVjX2RlY19jdHJsX29wcywNCj4gPj4+Pj4+Pj4gKyBWNEwyX0NJRF9NUEVHX01US19TRVRfU0VD
VVJFX01PREUsIDAsIDY1NTM1LCAxLCAwKTsNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gIHY0bDJf
Y3RybF9oYW5kbGVyX3NldHVwKCZjdHgtPmN0cmxfaGRsKTsNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3RybHMtZGVmcy5j
DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWN0cmxz
LWRlZnMuYw0KPiA+Pj4+Pj4+PiBpbmRleCBkOGNmMDFmNzZhYWIuLmE1MDcwNDVhM2YzMCAxMDA2
NDQNCj4gPj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy1k
ZWZzLmMNCj4gPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJs
cy1kZWZzLmMNCj4gPj4+Pj4+Pj4gQEAgLTEwNDIsNiArMTA0Miw3IEBAIGNvbnN0IGNoYXIgKnY0
bDJfY3RybF9nZXRfbmFtZSh1MzIgaWQpDQo+ID4+Pj4+Pj4+ICBjYXNlIFY0TDJfQ0lEX01QRUdf
VklERU9fUkVGX05VTUJFUl9GT1JfUEZSQU1FUzpyZXR1cm4NCj4gPj4+Pj4+Pj4gIlJlZmVyZW5j
ZQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEZyYW1lcyBmb3IgYSBQLUZyYW1lIjsNCj4gPj4+Pj4+Pj4g
IGNhc2UgVjRMMl9DSURfTVBFR19WSURFT19QUkVQRU5EX1NQU1BQU19UT19JRFI6cmV0dXJuDQo+
ICJQcmVwZW5kDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gU1BTIGFuZCBQUFMgdG8gSURSIjsNCj4gPj4+
Pj4+Pj4gIGNhc2UgVjRMMl9DSURfTVBFR19NVEtfR0VUX1NFQ1VSRV9IQU5ETEU6cmV0dXJuICJN
ZWRpYVRlaw0KPiA+Pj4+Pj4+PiBEZWNvZGVyDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gZ2V0IHNlY3Vy
ZSBoYW5kbGUiOw0KPiA+Pj4+Pj4+PiArY2FzZSBWNEwyX0NJRF9NUEVHX01US19TRVRfU0VDVVJF
X01PREU6cmV0dXJuICJNZWRpYVRlaw0KPiBEZWNvZGVyDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gc2V0
IHNlY3VyZSBtb2RlIjsNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gIC8qIEFWMSBjb250cm9scyAq
Lw0KPiA+Pj4+Pj4+PiAgY2FzZSBWNEwyX0NJRF9NUEVHX1ZJREVPX0FWMV9QUk9GSUxFOnJldHVy
biAiQVYxIFByb2ZpbGUiOw0KPiA+Pj4+Pj4+PiBAQCAtMTQ0Miw2ICsxNDQzLDEwIEBAIHZvaWQg
djRsMl9jdHJsX2ZpbGwodTMyIGlkLCBjb25zdA0KPiBjaGFyDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4g
KipuYW1lLCBlbnVtIHY0bDJfY3RybF90eXBlICp0eXBlLA0KPiA+Pj4+Pj4+PiAgKnR5cGUgPSBW
NEwyX0NUUkxfVFlQRV9JTlRFR0VSOw0KPiA+Pj4+Pj4+PiAgKmZsYWdzIHw9IFY0TDJfQ1RSTF9G
TEFHX1dSSVRFX09OTFk7DQo+ID4+Pj4+Pj4+ICBicmVhazsNCj4gPj4+Pj4+Pj4gK2Nhc2UgVjRM
Ml9DSURfTVBFR19NVEtfU0VUX1NFQ1VSRV9NT0RFOg0KPiA+Pj4+Pj4+PiArKnR5cGUgPSBWNEwy
X0NUUkxfVFlQRV9JTlRFR0VSOw0KPiA+Pj4+Pj4+PiArKmZsYWdzIHw9IFY0TDJfQ1RSTF9GTEFH
X1dSSVRFX09OTFk7DQo+ID4+Pj4+Pj4+ICticmVhazsNCj4gPj4+Pj4+Pj4gIGNhc2UgVjRMMl9D
SURfVVNFUl9DTEFTUzoNCj4gPj4+Pj4+Pj4gIGNhc2UgVjRMMl9DSURfQ0FNRVJBX0NMQVNTOg0K
PiA+Pj4+Pj4+PiAgY2FzZSBWNEwyX0NJRF9DT0RFQ19DTEFTUzoNCj4gPj4+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xzLmgNCj4gPj4+Pj4+DQo+ID4+
Pj4+PiBiL2luY2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xzLmgNCj4gPj4+Pj4+Pj4gaW5k
ZXggN2IzNjk0OTg1MzY2Li44OGU5MGQ5NDNlMzggMTAwNjQ0DQo+ID4+Pj4+Pj4+IC0tLSBhL2lu
Y2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xzLmgNCj4gPj4+Pj4+Pj4gKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiA+Pj4+Pj4+PiBAQCAtOTU3LDYgKzk1Nyw3
IEBAIGVudW0NCj4gdjRsMl9tcGVnX21mYzUxX3ZpZGVvX2ZvcmNlX2ZyYW1lX3R5cGUgew0KPiA+
Pj4+Pj4+PiAgLyogIE1QRUctY2xhc3MgY29udHJvbCBJRHMgc3BlY2lmaWMgdG8gdGhlIE1lZGlh
VGVrIERlY29kZXINCj4gPj4+Pj4+DQo+ID4+Pj4+PiBkcml2ZXIgYXMgZGVmaW5lZCBieSBWNEwy
ICovDQo+ID4+Pj4+Pj4+ICAjZGVmaW5lIFY0TDJfQ0lEX01QRUdfTVRLX0JBU0UoVjRMMl9DVFJM
X0NMQVNTX0NPREVDIHwNCj4gMHgyMDAwKQ0KPiA+Pj4+Pj4+PiAgI2RlZmluZQ0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+IFY0TDJfQ0lEX01QRUdfTVRLX0dFVF9TRUNVUkVfSEFORExFKFY0TDJfQ0lEX01Q
RUdfTVRLX0JBU0UrOCkNCj4gPj4+Pj4+Pj4gKyNkZWZpbmUNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBW
NEwyX0NJRF9NUEVHX01US19TRVRfU0VDVVJFX01PREUoVjRMMl9DSURfTVBFR19NVEtfQkFTRSs5
KQ0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiAgLyogIENhbWVyYSBjbGFzcyBjb250cm9sIElEcyAq
Lw0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+Pj4+IGxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0DQo+ID4+Pj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
ID4+Pj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsDQo+ID4+DQo+ID4gDQo+IA0K
