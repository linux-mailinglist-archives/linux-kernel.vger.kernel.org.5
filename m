Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4EE7A3FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjIRDoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbjIRDnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:43:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFA3120;
        Sun, 17 Sep 2023 20:43:25 -0700 (PDT)
X-UUID: 82e1adf055d511eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BG/U1VJoexKyaTTJGmFRvpaTOmi3NyP/2ftE4BJaPhs=;
        b=FzX5MbCwCYWmZq9sfX+6QdRNoFUTa32oN7QDZrs4g5bMYU5LIDcYMuLWktpE5srZRRIcimR53FPFZpUSrlKOj3gRTpBhB6FDeFri4e7poPDVxMl56+SBPX0wzSXcvMI8sTL3U4OFpwo3X+yy5WvE35aHwsbKCC7f66qVfQuY39c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:3db6d439-f6e4-429f-9181-e7243b4d6209,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:3390cfef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 82e1adf055d511eea33bb35ae8d461a2-20230918
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 172478044; Mon, 18 Sep 2023 11:43:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 11:43:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 11:43:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6DsiEATGrARLfph9wOHoPmwNARC/Ud7x5YvD/Kt3dd/nd7bK2bcPA2AIFRtnFiBtCQFZ/ojVX2Ei01Gyokhs0KEeWRiIRzJidZqigXEtgkRzWw+pBeJWME2l5NJwRV9Y1y5TWqHoSi9gegsz41FEGyCM+D5xDKCsTaYIWCjUyRSmFq6J8O7yo9cy/7E37wDtA1rvCjkv7nDVQ/YVjGWM6X87aNZi3esm4GbFn3CsZBsoFzs45RZrOHIKer4RLXAIuQflGxDpcnXOwLGaHlBrh54fwzTfG9rAWDNjAyGk7Vukd2moDYS+kVff5wWBwKGs9CB8ogEqTfIphwQHoUOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG/U1VJoexKyaTTJGmFRvpaTOmi3NyP/2ftE4BJaPhs=;
 b=POd7l9eTi/JIZz8k8nZedq6iEG2QeMehpyzJQ23zgTzeRIDFqpM7147OUE1POX2XdgPqx4doDEMl27Qh/iEUDw3k0TFOyNlVNIauIKJTslCVrGLzJSS6YEGdFiA515+EoswtSl1/BY/Ae6t1vxI0vUgQJr75nmkjFXWf5GAlJykR7llRx9kHB+CIayexpXDLYyRtxyH9jCEx7SX5r2lQiZ1aEtQDKgeR3qfc6bACwQaWmgDHspgcw/ad92N1ALNjwZAn2wCrBff6x6BrLckyjJkRvBO5UlYCJGlj9kk7sFyywqAaRUzHy+Wijzm55vyxFUNvYB0UlGkZLAuFQrwT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG/U1VJoexKyaTTJGmFRvpaTOmi3NyP/2ftE4BJaPhs=;
 b=ERl+AS3S5StCeooY8Y+i6baPfiLjkkKqpEpGy7bTv5TrNJEGIoYz20AOPQCf9tgRjhus4049nsgyMsKf+e53crsyGdz+6VcYFl61dELn9pnF4GX096SgI0pPnHA/6dg16RZRxSRrOrF3V2WqWCaP5W4kWNaRkfLmn95MD0/WTVE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6822.apcprd03.prod.outlook.com (2603:1096:400:217::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 03:43:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 03:43:16 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v6,3/4] drm/mediatek: dp: Add the audio divider to
 mtk_dp_data struct
Thread-Topic: [PATCH v6,3/4] drm/mediatek: dp: Add the audio divider to
 mtk_dp_data struct
Thread-Index: AQHZ1KJW51wsI3YwFEGoSiIqHM/67rAgGz2A
Date:   Mon, 18 Sep 2023 03:43:16 +0000
Message-ID: <9460ad6663bc8a76d9d47d22d7d93c5031777eb2.camel@mediatek.com>
References: <20230822024155.26670-1-shuijing.li@mediatek.com>
         <20230822024155.26670-4-shuijing.li@mediatek.com>
In-Reply-To: <20230822024155.26670-4-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6822:EE_
x-ms-office365-filtering-correlation-id: 0d8d9c2a-6237-407e-e679-08dbb7f96467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6c0+TrbIjoolmOzUgJUswtikoazAr13yb2GWdL+38HSim4Qe72VaznC3WnbffxIw59d5hNSEXgzLzUZ5HBRlBzSWSfin7JVSwJiioBEQMcIkIyG4zl0wst45Dk2UedE6PZHt8SUIYWi8u3a3X/FWOHzHjubIoiNgANUzGaeTkc7nw3ithhXmDMDsRjYm4vv89j1kpaE0v+ej/tejMxPvey1V1AAm+49RJqbCkBU9evSqwh73USrLhaMPDTDt567epp+jOF1EuWprfihIeQdD1SqLjvblWIHe2NqbsVprevfOnHgG4/f8C8Daie3R3yn9LDR48wTohnTg65+qYIgB7uk9032fZzrCbROMWBfEQR7vlf1ineZc3xt92uHiLD6lqi7+vZQlSvAn9UCA0YF5NNGsN0Z0VR5ZDafSrivhHkkp1aWQElWDpz3aPX8mNWP4+mAA+E7ur1T3fvCp/f5LnLvO6kzkBzjNQwbaLVNBMPuhAw6ah4RfCqCJncNCZRFjqeUReVsBC3xD+VRKIyj0Ep2kkdXzWNJM/8IWwKpy+aBFIKXoGrrznN2c8Qz4oMTE2CXCgQXFao4yoIMkNplI74cYu4i40dutWH08EuOmUxn8FjkWxD/eJQqTMveOeVdwTNQYVBfo/p8m4GdKQGLoub1e4F4HkfsjhwKUeN+1oATYaxaE3WSeiORHTWiWW1UnlUk7Rjzws90ZSyQdtGQx7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(921005)(478600001)(316002)(71200400001)(41300700001)(64756008)(54906003)(66446008)(966005)(110136005)(38070700005)(76116006)(66946007)(66476007)(66556008)(38100700002)(122000001)(7416002)(2906002)(36756003)(85182001)(86362001)(83380400001)(5660300002)(8936002)(4326008)(8676002)(26005)(6512007)(107886003)(2616005)(6506007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGM5andZNi90bnF3Q01iM1dLVEo2dmZTc2FjK1FIU3JvWjlqUDhVcmtaWm81?=
 =?utf-8?B?SFA2Q2pwUk1SY24wTHBrWDVtZllxbXBqSHhjMEMrbzBtM25meUswemwrR2xX?=
 =?utf-8?B?eEdxK3d2ZkdTTWNJdWZ6TWkrNml6UzJ0NzRpVmRaM1o1KzErOHk2bXhUaDg2?=
 =?utf-8?B?bndDVnowQVZsT0VUdzNXSk03K1NsYnF5UllBb1VnMUM4ZEJia2drTGRyUHZw?=
 =?utf-8?B?MVpqb3hFM21JZFNZM3lOZ2FvWEVaUktCZkpXL2kvTlZrU3MxQUtwU2NnTmtk?=
 =?utf-8?B?d2VGS1l5V01uODBvVWYvdC9vOFBZZmYxT2NkcEdBQWVCczR3YWhIZkVwNHMr?=
 =?utf-8?B?eUFCbGFSKytldzU1OVF3cmRmVjd6dHM2QW13R25VdWM4aTRJYXZKQkFQSVBK?=
 =?utf-8?B?VUtEUGJTUXpiS3J3Z2lQd2tWb2N4L2FuK0VvUWlWMzhQb0tDemRSWW1WVTF3?=
 =?utf-8?B?RlRsVDBrNWtzRGlzZjRUMmtCM1IvTTNMNysvcWdPd3h2TFJBVXB2aVpCYm51?=
 =?utf-8?B?eDVnU0ZRRVhOV3RZMkZ5TjhHdDlLdUt0NlpPUFFUNS85LzdjaVk3Q1g0QTJx?=
 =?utf-8?B?Q2E3bXBWVnJGOHFiWHhQQUVBUEtjODNGTGl0RzhUMDFwZy94cWd5dEt2ZFFN?=
 =?utf-8?B?QmwzemM5TlhUeHlSdDNwYkJ1dFpCTzNMNjh6UGtlYWYwSGYvaGl5bVZjR1Jo?=
 =?utf-8?B?QkF6aERhd3pnL2NteVhQdWh6czErbWRYQlpwbjAxTVhxVDNSaytybzlaR3BL?=
 =?utf-8?B?cWxsSHBmS1FuOHFvbVlrbE5pcytZdnZsa0VoWno0a1RBcXFqclhaQWtSbWp2?=
 =?utf-8?B?MjgxSXVxem1IS0xWNHhTVVJFeWZNeW4xUGtCYkdTM2VOdjhmbTdqbDBOMmZ3?=
 =?utf-8?B?UW10RDlmckxUeWlDbGRsN0M3bC83azNnYUVLTzRUb0swSk9oMkxPNlNKQURB?=
 =?utf-8?B?WGJ1NGtiRVNubnIzam9MVzZCTlF3U1ozcEhraVdDYXVDRzZ1a0hBQzNiaFB2?=
 =?utf-8?B?bUsxcEY3a2dPdnJTcG52TnFORkxwWDgvTU1ucXh2a2Z4Z2VUWmNmcFpNWm9a?=
 =?utf-8?B?OCtrVTQxZzNnQVZtaXlmWWU1eEI3ZUE5Mk9xRTFIb044OUVEZTQ5ZS82Z2tR?=
 =?utf-8?B?cFUxOXVEMU1vTk85V09lSVBVRFlrK3FldjEzdGlPWW1OZVBGU2pRWW0vN0Q1?=
 =?utf-8?B?ZmZYbnR2b2RWcjBzREM2MVlpYmFHR3ZjN0RJMmV5V1E4R0NONG50TDZQckF5?=
 =?utf-8?B?b3VYZ1VTRWFKVVZwN2ZGRkZsaFN0SUdhblBMWVMxSS94MmRHcGJqM09YQVUv?=
 =?utf-8?B?M25BMS90ZW01ZXZWYUZUMzQ0YVRIZEVmbThLWjlCb1RoZ2p5R3FvQUNMWXUw?=
 =?utf-8?B?TWMrbkVnTGZIb3ZtWVhUVG5JbXRhbFNUS041RUszdkpLZjg2dEtOanVYWHMw?=
 =?utf-8?B?OVZ0UjgySXo3ZjR5N3JGUGNXa3Q5M2h5amtsZkUzSmdITjVQcXNCU2paZXND?=
 =?utf-8?B?cFNZYk4ySkpLMzBwWkcrcGNWVHFndTRFYzZHVHZVNzZzRmdQM3ExTHRORTcw?=
 =?utf-8?B?djZiSFpEZmZvcVp5WU9pZkhXU1VVOWxYTzN1bVYvZlg3bXI0VDFWSGFqblA2?=
 =?utf-8?B?ZmtTb0d5RU4zb3NkditPYnRtcGF4bkhackx0czExZFNrcnZkVEdqZmUwdDk0?=
 =?utf-8?B?eFA0TFNqWlo2UDI2SVlhMGxick1GMjRkOU5FeDF1VXhKYWk0MktZWXJUWEkz?=
 =?utf-8?B?dmxiTFlzM1J2NmlRRmtmUGMrdXhCSytSc0UrU3cwVW81MG95ODBtSUhYb1Nl?=
 =?utf-8?B?d0JDUnNib2pqd3V5aUxRaklVcGQ3K0w5MzgxaG9uaHNvU3RzNjBZL2VMQ2wy?=
 =?utf-8?B?cmRpVmdmTlZQUkJVd2N5eU01WWthQTVWTFJYenpUZG1wMzVlMllUanNTV3FE?=
 =?utf-8?B?OWlEZktLRGQ2UFR4cWNYbFFtYmptUzBCamRvZnBmRmJvUSt6QzZCNGhGdWpq?=
 =?utf-8?B?ZXNzbEdoczNkemltY2hpS0d0d2RaSCthWjZrKzdpT01xU0JLc3llRWJ2VVB5?=
 =?utf-8?B?bXlEZUgrcWFzNk9OK1VxZ2xBbFFzRk1Yb2Nuc0tJWlRsTlpiWEVzUnc0amhL?=
 =?utf-8?Q?Iw6IvcVMiww2orI2KKjpJ0AqB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71D26CDA2DB394439B57230996825E69@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d9c2a-6237-407e-e679-08dbb7f96467
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 03:43:16.1770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34Xywmb5jg1N3QjnzLp20NPEts3Y7Lw405W3nXUMfaVbkHpz1n3BvUlBEkjKZZDtu1ELCHV8wrphzV4/b5QkWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6822
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.519500-8.000000
X-TMASE-MatchedRID: scwq2vQP8OEOwH4pD14DsPHkpkyUphL9YKeVO7aMEHNo5YsPsbyLXZof
        RcYVW70w0JzyTF9R6+aXYp1n4P1o0IvCAkDuom8U/O70vD0Lt8Acg65CMI4oW99zZd3pUn7KEEv
        wKkGJs6sZB0R4cFpbTeKOmN63egZIkKjL2IOi2LBGPG93E0tHjMt3zHe6QppenQqircTOm4eozw
        9gka4disiWynuM+ENvuC2c3pw4Rj9C/bXMk2XQLIMbH85DUZXyTDXDVo1TfPjUZxEAlFPo846HM
        5rqDwqtyWKCHxu+1xGh7w0ma3cRreu64tOX2bJ9QNpqMCrp1lZOlJjeMvS14g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.519500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B2C73F1E2EB6EA8D21EFCBD38FD5022C55D498B7236204175F0FE33305DA927F2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBUdWUsIDIwMjMtMDgtMjIgYXQgMTA6NDEgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBEdWUgdG8gdGhlIGRpZmZlcmVuY2Ugb2YgSFcsIGRpZmZlcmVudCBk
aXZpZGVycyBuZWVkIHRvIGJlIHNldC4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRp
YXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNodWlqaW5nIExpIDxzaHVpamluZy5s
aUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY2Og0KPiBNb3ZlIE1UODE4OCBk
ZWZpbnRpb24gdG8gcGF0Y2hbNC80XS4NCj4gcGVyIHN1Z2dlc3Rpb24gZnJvbSB0aGUgcHJldmlv
dXMgdGhyZWFkOg0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC82MGJhMWFiNDBmYzk0
M2YxYWJmM2U3OGIwYjMyMjIzYmU0MDIzMDJjLmNhbWVsQG1lZGlhdGVrLmNvbS8NCj4gQ2hhbmdl
cyBpbiB2NDoNCj4gbGlzdCBhbGwgY29uZmlndXJhdGlvbiBmb3IgTVQ4MTg4IGFuZCBNVDgxOTUu
DQo+IHBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvYTlkMWI5YjdlZjQ3ODBmNTE1NzRkMGJiYmUyOGY2ZGQxMDlh
NmFiOC5jYW1lbEBtZWRpYXRlay5jb20vDQo+IENoYW5nZXMgaW4gdjM6DQo+IFNlcGFyYXRlIHRo
ZXNlIHR3byB0aGluZ3MgaW50byB0d28gZGlmZmVyZW50IHBhdGNoZXMuDQo+IHBlciBzdWdnZXN0
aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sL2UyYWQyMmJjYmEzMTc5N2YzOGExMmE0ODhkNDI0NmEwMWJmMGNiMmUuY2FtZWxAbWVk
aWF0ZWsuY29tLw0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGNoYW5nZSB0aGUgdmFyaWFibGVzJyBu
YW1lIHRvIGJlIG1vcmUgZGVzY3JpcHRpdmUNCj4gLSBhZGQgYSBjb21tZW50IHRoYXQgZGVzY3Jp
YmVzIHRoZSBmdW5jdGlvbiBvZg0KPiBtdGtfZHBfYXVkaW9fc2FtcGxlX2FycmFuZ2UNCj4gLSBy
ZWR1Y2UgaW5kZW50YXRpb24gYnkgZG9pbmcgdGhlIGludmVyc2UgY2hlY2sNCj4gLSBhZGQgYSBk
ZWZpbml0aW9uIG9mIHNvbWUgYml0cw0KPiAtIGFkZCBzdXBwb3J0IGZvciBtZWRpYXRlaywgbXQ4
MTg4LWVkcC10eA0KPiBwZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+
IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9hYzBmY2VjOS1hMmZlLTA2Y2MtYzcyNy0x
ODllZjdiYWJlOWNAY29sbGFib3JhLmNvbS8NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwLmMgICAgIHwgIDUgKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBfcmVnLmggfCAxMiArKysrKystLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwLmMNCj4gaW5kZXggYmFkYjIwNWZmZmYyLi4wYmE5YTRmZGY4MzkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAgLTE0MCw2ICsxNDAsNyBAQCBzdHJ1Y3QgbXRr
X2RwX2RhdGEgew0KPiAgCWNvbnN0IHN0cnVjdCBtdGtfZHBfZWZ1c2VfZm10ICplZnVzZV9mbXQ7
DQo+ICAJYm9vbCBhdWRpb19zdXBwb3J0ZWQ7DQo+ICAJYm9vbCBhdWRpb19wa3RfaW5faGJsYW5r
X2FyZWE7DQo+ICsJdTE2IGF1ZGlvX21fZGl2Ml9iaXQ7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19kcF9lZnVzZV9mbXQNCj4gbXQ4MTk1X2VkcF9lZnVzZV9mbXRbTVRL
X0RQX0NBTF9NQVhdID0gew0KPiBAQCAtNjQ4LDcgKzY0OSw3IEBAIHN0YXRpYyB2b2lkDQo+IG10
a19kcF9hdWRpb19zZHBfYXNwX3NldF9jaGFubmVscyhzdHJ1Y3QgbXRrX2RwICptdGtfZHAsDQo+
ICBzdGF0aWMgdm9pZCBtdGtfZHBfYXVkaW9fc2V0X2RpdmlkZXIoc3RydWN0IG10a19kcCAqbXRr
X2RwKQ0KPiAgew0KPiAgCW10a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9FTkMwX1Aw
XzMwQkMsDQo+IC0JCQkgICBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElW
XzIsDQo+ICsJCQkgICBtdGtfZHAtPmRhdGEtPmF1ZGlvX21fZGl2Ml9iaXQsDQo+ICAJCQkgICBB
VURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfTUFTSyk7DQo+ICB9DQo+ICANCj4g
QEAgLTI2MzUsNiArMjYzNiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4
MTk1X2VkcF9kYXRhDQo+ID0gew0KPiAgCS5zbWNfY21kID0gTVRLX0RQX1NJUF9BVEZfRURQX1ZJ
REVPX1VOTVVURSwNCj4gIAkuZWZ1c2VfZm10ID0gbXQ4MTk1X2VkcF9lZnVzZV9mbXQsDQo+ICAJ
LmF1ZGlvX3N1cHBvcnRlZCA9IGZhbHNlLA0KPiArCS5hdWRpb19tX2RpdjJfYml0ID0NCj4gTVQ4
MTk1X0FVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMiwNCj4gIH07DQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTk1X2RwX2RhdGEgPSB7
DQo+IEBAIC0yNjQyLDYgKzI2NDQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9kYXRh
IG10ODE5NV9kcF9kYXRhDQo+ID0gew0KPiAgCS5zbWNfY21kID0gTVRLX0RQX1NJUF9BVEZfVklE
RU9fVU5NVVRFLA0KPiAgCS5lZnVzZV9mbXQgPSBtdDgxOTVfZHBfZWZ1c2VfZm10LA0KPiAgCS5h
dWRpb19zdXBwb3J0ZWQgPSB0cnVlLA0KPiArCS5hdWRpb19tX2RpdjJfYml0ID0NCj4gTVQ4MTk1
X0FVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMiwNCj4gIH07DQo+ICAN
Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcF9vZl9tYXRjaFtdID0g
ew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gaW5kZXggZjM4ZDZm
ZjEyYWZlLi5iOTg1OWVmMDY3Y2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBfcmVnLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cF9yZWcuaA0KPiBAQCAtMTU5LDEyICsxNTksMTIgQEANCj4gICNkZWZpbmUgTVRLX0RQX0VOQzBf
UDBfMzBCQwkJCTB4MzBiYw0KPiAgI2RlZmluZSBJU1JDX0NPTlRfRFBfRU5DMF9QMAkJCQlCSVQo
MCkNCj4gICNkZWZpbmUgQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX01BU0sJ
R0VOTUFTSygxMCwgOCkNCj4gLSNkZWZpbmUgQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9F
TkMwX1AwX01VTF8yCSgxIDw8IDgpDQo+IC0jZGVmaW5lIEFVRElPX01fQ09ERV9NVUxUX0RJVl9T
RUxfRFBfRU5DMF9QMF9NVUxfNAkoMiA8PCA4KQ0KPiAtI2RlZmluZSBBVURJT19NX0NPREVfTVVM
VF9ESVZfU0VMX0RQX0VOQzBfUDBfTVVMXzgJKDMgPDwgOCkNCj4gLSNkZWZpbmUgQVVESU9fTV9D
T0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl8yCSg1IDw8IDgpDQo+IC0jZGVmaW5lIEFV
RElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfNAkoNiA8PCA4KQ0KPiAtI2Rl
ZmluZSBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzgJKDcgPDwgOCkN
Cj4gKyNkZWZpbmUgTVQ4MTk1X0FVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9N
VUxfMgkoMSA8PA0KPiA4KQ0KPiArI2RlZmluZSBNVDgxOTVfQVVESU9fTV9DT0RFX01VTFRfRElW
X1NFTF9EUF9FTkMwX1AwX01VTF80CSgyIDw8DQo+IDgpDQo+ICsjZGVmaW5lIE1UODE5NV9BVURJ
T19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfTVVMXzgJKDMgPDwNCj4gOCkNCj4gKyNk
ZWZpbmUgTVQ4MTk1X0FVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMgko
NSA8PA0KPiA4KQ0KPiArI2RlZmluZSBNVDgxOTVfQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9E
UF9FTkMwX1AwX0RJVl80CSg2IDw8DQo+IDgpDQo+ICsjZGVmaW5lIE1UODE5NV9BVURJT19NX0NP
REVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzgJKDcgPDwNCj4gOCkNCj4gICNkZWZpbmUg
TVRLX0RQX0VOQzBfUDBfMzBEOAkJCTB4MzBkOA0KPiAgI2RlZmluZSBNVEtfRFBfRU5DMF9QMF8z
MTJDCQkJMHgzMTJjDQo+ICAjZGVmaW5lIEFTUF9IQjJfRFBfRU5DMF9QMF9NQVNLCQkJCUdFTk1B
U0sNCj4gKDcsIDApDQo=
