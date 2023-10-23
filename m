Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C17D2894
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjJWCfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjJWCfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:35:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E64D41;
        Sun, 22 Oct 2023 19:35:05 -0700 (PDT)
X-UUID: c38c65c4714c11eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CiYPo2eRD/c0EAfcwIm1PFmRcrlS8951fDGOzzi9qg0=;
        b=FlFRJCsABhMJxe0SOjjmZb5aqbRMEw7pg1l26PsJK/BBNEq2uWuvQTv8mAg87iv3kYVHoYonGrAUXSBLZbHLRml7lzbgfnWZrVWPKp9/tgs4Xjblqsgb3JWwwBM4PriSd5Irq8oJCX+z0LJkUrMbaylLQtmiGXl8aO8UvLVD/kI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0348176d-2f85-487e-abc8-35bc658515fd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:fee1a3fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c38c65c4714c11eea33bb35ae8d461a2-20231023
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 103855035; Mon, 23 Oct 2023 10:35:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 10:34:59 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 10:34:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA53SP52dsxybCL4Yu2hBhH/4XNXdffy53g8BqzGAgM3ev5O5nK1UE2vZaDPN7vTyLbHew88fApJfl7GKRPy3FGlRFtMCQctp2FAu6EURCBmxkKbnvudSeSWt2V8jvu+s1CL8r+oDJ6HaTdi4+zgeYrS84VggYQKP81wtCS3/6fbnYGMMKriJTHylrW+JzmIxfTUSfsto4DjFkh1r7SOGYwjBf3zzmP5wOUpYlboxxadAQINihxvKOCdd4X4qT9fdMcMn9SR0gaB7ZlHLTpNhsf02WRePZ/52TQdDbtRIu5sBeajYq3pnRXZd5DX/gIfszQzgiOfVlxY2qNV9OmORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiYPo2eRD/c0EAfcwIm1PFmRcrlS8951fDGOzzi9qg0=;
 b=MnE/1g0FLrmkY8FfQwC6RZbXHVWYOy2A+h3w/Hkj1FnkcGWUsQ2L8B5fbwshjjUDxasg+glpW5ajSU6LqkrCFLKecKQAI7FrzX11TnxeSMFjBJxoCgWE4cXNUoBXOvGTXGPr4A+Pbe/O278+anLGLjNncP4Yl6qvkEfrC9eO9WBx20Jvp9S1N0iXpARJ1ztwensXnhMtDlLe9txFyoTgH30qliu/snj1mlcEKS6alhBsGtKBN0waR+C+ismyqAWQd184vqWjEnVsnZ2YPhJbutZFnd9xi71BOWi2ZY2FEJWgZJ8QUnzfWsay2q/1pZuZxQlpfM+ZtElBeJvIpBwEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiYPo2eRD/c0EAfcwIm1PFmRcrlS8951fDGOzzi9qg0=;
 b=KcuoF8W//oqZ/2awn1Z+YzFLb6pr6FWYYJjbKgdm9CvBS92Z8DZ1Wgw3vKX2hFysSz+3KXbD0BiqkFppUqernYLuJEDSmtrJP7gXP409ds5+xIUdgTucYuggM2sqKDivxyA5TG8Qo5rDqkTc1DEpDTJemJQDYCUPwNLFQG84mg0=
Received: from SI2PR03MB5659.apcprd03.prod.outlook.com (2603:1096:4:15e::12)
 by PSAPR03MB5350.apcprd03.prod.outlook.com (2603:1096:301:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 02:34:57 +0000
Received: from SI2PR03MB5659.apcprd03.prod.outlook.com
 ([fe80::cd53:54df:cc65:c2d2]) by SI2PR03MB5659.apcprd03.prod.outlook.com
 ([fe80::cd53:54df:cc65:c2d2%7]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 02:34:57 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= 
        <bear.wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Thread-Topic: [PATCH v5 4/4] arm64: dts: Add MediaTek MT8188 dts and
 evaluation board and Makefile
Thread-Index: AQHaAmGsypK4CbzUPUij/D6QZCSzWrBQ3dmAgAF+tYCAACTNAIAELOYA
Date:   Mon, 23 Oct 2023 02:34:57 +0000
Message-ID: <0a6089d652f62519b80364520bf0dba1dcaf4db3.camel@mediatek.com>
References: <20231019075458.28290-1-jason-ch.chen@mediatek.com>
         <20231019075458.28290-5-jason-ch.chen@mediatek.com>
         <69a0bd5c-58ef-4fb2-a8c8-35f6e277f76b@collabora.com>
         <27917c82b6e2c9541e185e49c8b403ba65b31ef9.camel@mediatek.com>
         <704fbd2c-620e-cc62-319e-45c536149cfd@mediatek.com>
In-Reply-To: <704fbd2c-620e-cc62-319e-45c536149cfd@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5659:EE_|PSAPR03MB5350:EE_
x-ms-office365-filtering-correlation-id: 27ad9e63-d786-49ad-9929-08dbd370a593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSPVJlRRQg8ZemGjcMGUk+Ygp3mSb7XZI0IIlvdrPDf8UrnQPYEfgYFaywhGFhXiQY3m2Yp+SJ66x1zURTMMQUXunO3j3C5WKnvf+IH/X9DNRH6SECyA4ikBaBgspALBisNgx5zf6WQnJhlogkp4G+p0BIj33PnA3m15Zsq4sHIlI6hFWwLER3LE455McQQlEPozc8HQePjHrCu21jxbvnKcvPhfTYQqsEV4tVoqHATYJ7mPVuj4387olxwPKNr9ReUIqQ6UAfjQk29R+HnM4rnvjjQxqd87pUF5a+izEPJXdZLaNs7MvGnN8bXyFqxkzcfGFL5KE4SyQ69yvDsKdVAt02glebXxNwiGYT5WdiD/VwFt4glcjzoaE6vWQiy3eYNVc1SXzJuhq0GoCx+BKmRLOSfOx7OkPe69VPActN126R6K6qvdBLqixxZRve/fgOK7uiZFT0ql04+H5Lz/JRKgb0BQgfa/ZtZ1dJIQl6DZ+5x51hei3G16wVzYyJZJcO5+08ocz7/SNvtkSPSubprhiECaJ31cu3LDjmUa2YjopnM6zY2bBsRnwMVZZW5m+7B9Wcx+WhGM8PI7W7OV4120LAsO3Dn0iJZfganiiNl/4DmwPcWUN8fMESG6PI92m1qwtJmfgvTXiUT2DD2LYvm6bN1naHKsFPxLsi1E6XCwwU7U+8CUhBo5FrJvq8Av
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5659.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(921008)(4001150100001)(26005)(38100700002)(2906002)(4744005)(41300700001)(86362001)(5660300002)(7416002)(36756003)(85182001)(8676002)(8936002)(4326008)(6506007)(71200400001)(478600001)(91956017)(110136005)(122000001)(2616005)(66476007)(66946007)(316002)(76116006)(64756008)(66446008)(66556008)(54906003)(83380400001)(6486002)(53546011)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0tBVkVEVGUwd3pDb0toVXV5ZUxBS0NJZ0Q3d0hlaTZCNVZyN0RVMGlEK0Rl?=
 =?utf-8?B?YllGOU1oNnNheVBha3JKMXRGR2tNQmQwWGQ1cWFpeGFEY0xWWWM2YTlPbjJP?=
 =?utf-8?B?cGxMWThnajcxd1R5ZTB4c2NodUc0L2pWRFhETUpzcmowNGROS202UFNyNkdZ?=
 =?utf-8?B?RDlUYW9PZEFtMXlBNkgxN1pQQzgxNGtXV2o3VGI1dk16VGIraWFkbjhBU0hN?=
 =?utf-8?B?RUxGOEVsQVFXbFZyM1VOZGJxOVduSU5CeGZ3U3lhZGxVUWxYWFprSHo4SnB4?=
 =?utf-8?B?VUJVU21US3RPZlFxMU9DWXM4Qmtnb1RCRWxWQ2dwZFQ2ZnhDVWxnSXNCMk45?=
 =?utf-8?B?RWliTmo2TFJqVU1iZUhTUm1tNVFuQ0ovM0FsZFF0R3A2NW5pWFh0RUNZN0dF?=
 =?utf-8?B?SWNieEMzY1VFOEJpRFcyNXpya0Qxb1hvT09LdHpCdVIrUjc1T2dOT1I1T2Q1?=
 =?utf-8?B?YlpLTndQb1c5dWJaRCtTY2dPVGtIUTkyK2puaHlZVWhwZTFsZ0ZLaHZIQ1pP?=
 =?utf-8?B?U3BjSk5GeFVjSEVENGV6eTcyNnZweXhDVXpGcTRJdGZZTDkxKzFEaDdscURM?=
 =?utf-8?B?UG52cEpMZnFuSWNGVlFrUjlVaVRuNnFweERzT0w1NldZZFpoVUxMcGxZWUlv?=
 =?utf-8?B?MnNNVHRWeHl4ZzNESnJVMHpsTjZ3dWIwdkNQM3h6Rk4zRGVKVVR4SHprc1ZK?=
 =?utf-8?B?VmpsV2RNbStGbG1WU2xaMENxQkdVR0lMMWcxa2JBMVlsMVlwM1dSNHlIRU1K?=
 =?utf-8?B?RGI5ZUVrQ2E2L1hzWnl1L3ZVQjVjQ0ZScEtXbWhiY3BpV3Fyem5xdW1hTmo5?=
 =?utf-8?B?SVg1VVRjekFmWC9RcE9SL05TRXNwTCtGMnpiZjhyK0RwanRpZUVOUFlpUzV3?=
 =?utf-8?B?YXcwQ0dOa1BRb1UxakFMSVBWNGUzR285Si8vUDJYU0lHNmY3Ylc3eGluN0Qz?=
 =?utf-8?B?VGJRWU1Ed0xUc3FOcVdEMnE1WkFrcFpuWHhBcG1OMmdQVWFMandrWXE5VlJS?=
 =?utf-8?B?LzZTQnZTMStBTVFjZE5MZ3RPaUwrcW9ybXRuc1BRUWtkaldZTHVwVUpkTUhV?=
 =?utf-8?B?SmhaTWYvbmxaOVFCb242Q3hFUkVMOHB4UTVwcTN6dU83N1g3WWVQYkVDNjFL?=
 =?utf-8?B?VWcyUXBtOWc1bE02MjBLZzhVekRQU1laa2RjYmpSajY1cFh0STRnMThjMVY2?=
 =?utf-8?B?d3kzMDkzMUJRdzJSTU1IS253ME02UEdlNW1wS3JkUHVtWlJMSHkrWU8xY0Fk?=
 =?utf-8?B?M3hvZGtMbHozNEdXVFBBTzBzbEdRN0pKMisxZC8xeXVKUW9xaGJIS0d2eVFH?=
 =?utf-8?B?eVVKY2h4UmJRVEp5VzNRV0tHemVqUkZaTXhnMTJpUmtkbm1zMFJNVlAvU3Fv?=
 =?utf-8?B?WXh0TVlYTkc5QUUyQkZjOVF1YUFpcXJ6RTAzeUhxSGpqaTVBVGJlNEV5TkVy?=
 =?utf-8?B?d2M3a2EyR3MyQjhrL0Zab3NJSzVZUStDK3lLdlFWbUgvZUpWamsrYmVjMmhw?=
 =?utf-8?B?THYxNFlRS1ExWnl1R0RCTFFnRGVHOHNkanJXdVE1M0FtbjNDZFEzbG1lR1RZ?=
 =?utf-8?B?S0xWMjV2NXg3UFcyQjlCbUlyT0g0cldEaHUrUkx6ZkRnbnhWRStSWDd1NHZo?=
 =?utf-8?B?cDh1bnNpQ2t4bEZwdGt2Uys3VkhjNTV0N2t3azV4eXI3cUZFT2QycEFvZG50?=
 =?utf-8?B?WHlvOEd3dFNEeHB6c3pTeEtQNHVYWnJCeUZ3bkZQOG9YcUZodGZDa1dKc0Nx?=
 =?utf-8?B?VkhydzdTVHdTNERTa0hXQVU3SlpBQXROQWFDdkRSZ2pjdkloRHNCNDdFY0hz?=
 =?utf-8?B?ekdONS8yNlJ3SGtSZFdSUU9MaXNKdFBrcUNtRStWZ0NKQVltT1Z1YW1TTFIy?=
 =?utf-8?B?bE85WDVyVkgwQWdKb2tubTh5SmhYRXd5SEpKR3l5L0ZCWmlwRmM0Y2x3WG03?=
 =?utf-8?B?UlNEdy9kRUNJV3ZwYXlOdUJCVXQybFpHaWdFNGJHb0dHRXNsNGVQYXRFakRC?=
 =?utf-8?B?eHNGWnRxQ0Q5Z3ZhQ1RTR0Zua0dEL3l1Tjc0aUVSVE9pRy9GbkFuV1ZGZHV2?=
 =?utf-8?B?NkFGT1ExTER0Z0RPNkxiMGtVL1NpV0d2ZE11Si9IRUJad2xoYWlURHNhRkhH?=
 =?utf-8?B?Skk4VzRWVmVjelRxQ0JHbDVuWHNVZzkxM3Mvb3hkV1lkb1F4cjhvVUhwd2Rs?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FA32DC2E3DE844B8D913D7839BCB127@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5659.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ad9e63-d786-49ad-9929-08dbd370a593
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 02:34:57.0640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swA9/L25uF+Msx16LD4ZtoJSi32WthjuqcUeUxJmXncNpiaXgnwzp4V9UTvk/bwPQ8GVXnJaMwTzAFF0IZjr9hS/S+ke0DczlsEoewcYNWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5350
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.295700-8.000000
X-TMASE-MatchedRID: TDQWNTPftUDUL3YCMmnG4ia1MaKuob8PC/ExpXrHizy1fO8rPrdn2s70
        UEqqb9cF1rH4Rg0AOT1fxT5mB+NEEjL3OBQt7DBmjNvYZHpO13cml5KsEUs2IbkiJ/BgvX6ruz8
        f+DV2f+WwcAEDBvD9WjHZUGdVrRs/7jRSF7j2Bw6ZroPNdqiG88UO3Y+aw/kbmyiLZetSf8n5kv
        mj69FXvAOkBnb8H8GWDV8DVAd6AO/dB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.295700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B3E0A61AC5ACC8C701AACA1C3E7D78C068F9BFA7B0C50AA447172E8AA598348F2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFjcGF1bCwNCg0KT24gRnJpLCAyMDIzLTEwLTIwIGF0IDE4OjQ5ICswODAwLCBNYWNwYXVs
IExpbiB3cm90ZToNCj4gT24gMTAvMjAvMjMgMTY6MzcsIEphc29uLWNoIENoZW4gKOmZs+W7uuix
qikgd3JvdGU6DQo+ID4gSGkgQW5nZWxvLA0KPiA+IA0KPiA+IA0KDQouLnNuaXAuLg0KDQo+IA0K
PiBUaGVyZSdzIGFuIGFub3RoZXIgaXNzdWUuDQo+IA0KPiBDb3VsZCB5b3UgaGVscCB0byB1cHN0
cmVhbSBVU0IgcG9ydCB3aXRoIG10dTMgZW5hYmxlZC4NCj4gSSd2ZSBoZWFyZCB0aGF0IHRoZSBs
aW1pdGF0aW9uIGZvciBtdHUzIGFuZCB4aGNpIHBvcnQgaGFzIGJlDQo+IHJlc29sdmVkIA0KPiBm
b3IgTVQ4MTg4LiBJZiB5b3UgY291bGQgdXBzdHJlYW0gbXR1MyBub2RlcyBpbiBNVDgxODguZHRz
aSB0aGF0DQo+IHdpbGwgDQo+IGhlbHAgZm9yIHRlc3RpbmcgbXR1MyBvbiBhbGwgQ2hyb21lYm9v
ayBwbGF0Zm9ybXMuIE90aGVyd2lzZQ0KPiBNZWRpYVRlayANCj4gSU9UIHdpbGwgbmVlZCB0byB1
cHN0cmVhbSBtdHUzIG5vZGVzIHRvIE1UODE4OC5kdHNpIGxhdGVyIGJ1dCB3ZSBoYXZlDQo+IG5v
IA0KPiBDaHJvbWVib29rIHBsYXRmb3JtcyB0byB0ZXN0Lg0KPiANCj4gVGhhbmtzDQo+IE1hY3Bh
dWwgTGluDQoNClRoZSBtYWluIG9iamVjdGl2ZSBvZiB0aGlzIHNlcmllcyBpcyB0byBzdWJtaXQg
YmFzaWMgRFRTLiBUaGVyZSB3aWxsIGJlDQpvdGhlciBmZWF0dXJlcyB0aGF0IHdpbGwgYmUgZGV2
ZWxvcGVkIGFuZCBpbnRlZ3JhdGVkIGJhc2VkIG9uIHRoaXMgRFRTDQphZnRlciBpdCBpcyB1cHN0
cmVhbWVkLiBZb3VyIHJlcXVpcmVtZW50IGNhbiBiZSBhZGRyZXNzZWQgaW4gZnV0dXJlDQpzZXJp
ZXMuDQoNClRoYW5rcywNCkphc29uDQo=
