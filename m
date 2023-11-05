Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062207E137F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjKENFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 08:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKENFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 08:05:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F8E1;
        Sun,  5 Nov 2023 05:05:04 -0800 (PST)
X-UUID: ea4e5c6e7bdb11ee8051498923ad61e6-20231105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=D5plXieyNoEjszwuAAdUu3b03YRtcM9ijscAqr/z4v4=;
        b=N7Lm9jCXQQYfFRmYnAcP2Z7XHp0BQuFMN+LA/uiIyK8tlEfpjMe0x44q0+VoH1c4wb3KIjY7i6v2szW9hPcwWSUoqB/AvJyCp+8A6ZgDPZiT096LEk6p8cIcIDJaSTe6KNliDOU+LUcDlG9RE8ufQWit1YQ34M8q7m7BnShRQs8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c9090c82-26ea-4ead-b220-b2edd7bf574e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:33b94972-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ea4e5c6e7bdb11ee8051498923ad61e6-20231105
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 576686572; Sun, 05 Nov 2023 21:04:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 5 Nov 2023 21:04:54 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 5 Nov 2023 21:04:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKmfTLd8QdyTkoYXIgMqpCoFGt84m5h1pgtY5UqSbFprAOl/xdSNu2D+kmm9av6MJ7qGRoqA+qUIK/WVkMI9b/nkdI4wbTviCftmHviQg7RdmtRPAAFgG0Zfnvq01HqF8YNcYi1OmVJ7K27flhW7uVyaxenStLzd8S5kOjHhwWifVkOO27kF5KtRzYem3pnLjZ3x+hZ8ipijplRMMS71xzGHcYfNUWja9HeobPu4Mghm9MxCwCMtLGxMvGYi775GK45tBYAdbmeuSY9VucFWMyv5Kt6U01cqJ0XDwAKwqDiLNdabgunYHOU/0BawWuyMe14Ni8pniSoDXzdGvzs/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5plXieyNoEjszwuAAdUu3b03YRtcM9ijscAqr/z4v4=;
 b=aciTbFsIbgdZk4pROLxxCCezi86dumT4OztYtVaikZpNKscEUmt1QROMGsBEkaxRefeIRovibiqxIKOe9e+YmWzEuH0vVqaTW7BUy7P3dFPItRFYlUy1t4vK5X3wVIygvtTLewe0cZGAPfouGxzUmTGkPWy27T4h17wQMw4wKpvJ7s/UFWu9qtgaCDFBCsZsdvzBspQnQYIJ8X1k03SgunQUwoUWQqENsIppexS/Us2YqEfEYkCcqCBvHovfNI5dtghDXWYbQWq4gy1mTCrXgEaiSoFb+2JckRJ11AstRXnat7d/D2IP260Ij/lymJ1vF7+45YCuFEzh+GmMbFtavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5plXieyNoEjszwuAAdUu3b03YRtcM9ijscAqr/z4v4=;
 b=gMKue6Ne1jJoSM43OdfQ4Cv25kbUkjw3b9w/DVFjvONTdEjMfjdZ7iak7C5wA4ilxWJFPWvUGEE2zjZfaHuI4CouoPBkJRB+sbox9Jjl3BmedXh0/mCBA60Zb1fy9mA6JIv1mzmgXMblf9gDySOTTHnXfyPAYFS3hQFN1m5YWM8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7432.apcprd03.prod.outlook.com (2603:1096:820:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sun, 5 Nov
 2023 13:04:51 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.6954.025; Sun, 5 Nov 2023
 13:04:51 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Subject: Re: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Topic: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Index: AQHaBWvxkYcM1loCq06xiO/urU0GrLBjdJyAgAhR3IA=
Date:   Sun, 5 Nov 2023 13:04:51 +0000
Message-ID: <c0b47da99e0a43e867a3fb27efc36786d4315aea.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-10-jason-jh.lin@mediatek.com>
         <02187af1e98093d20a170d0ce4b2b428c7eee37d.camel@mediatek.com>
In-Reply-To: <02187af1e98093d20a170d0ce4b2b428c7eee37d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7432:EE_
x-ms-office365-filtering-correlation-id: 7c820410-c087-48cb-137a-08dbddffcc21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71UltO9GBBIoXrvNTqRpb2I2KED7eyxFNMnzMOneF832PCGTmFeAgLzf2VmR9ggnvYk4Xzd6pn+MhEYqmudPN8CSARPsloaKVb2ppZp2P1rv7samIskPLCWr9/VcEFcn/XyskrltxiTCPvEOmCpkYZrmXsKCmebmJ9pcMpZw1Um2/y+RF9swKocdjCrCju4LJDaHW7HEnS2D3q5i88PclyszH0nPPGOv1t2bpSDTGFcpXxW6DneaaeX3GTzcC7InxwP4bd3dOGpSEiGyxgb1Ihz5TXYObEmQwBKZLXM0UNOSh+YnHmxVc/itiO1zl61wPHxlrXKydkn3sR2OXWdaQlfjtfHCy0vmuaF3yAqqvOtGJbu07vv7PfKfdeZK22zKALDCcMs3dk0xFb7Bxwb9g7Y+rpvC9aJHdqFj163tGolC5IItmwgMIPqfCRzwrvzr8+oVAT00I+13deqJVCSJO4BVkCuI0CVxQeKtpm6hNW2EIrMmTcgYR1jsTzChaA4ZZ/7t3exXvpRLXRI13X3ALtdYVeJKdEYglE/eVUAhjfS88fcWTa68PXomPnp7F1HQmj9NbMMObDDWaO1NH4huZkRszKOYlaathSr5ianiKbPTr9ZqGlcZXKB4jKAr+N1hC3PIqhKrhV+7jg/bL+IYI5iA8dknMiwhelaE/F7/Hbo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(41300700001)(4001150100001)(2906002)(7416002)(5660300002)(4326008)(38070700009)(66556008)(76116006)(85182001)(36756003)(8936002)(8676002)(316002)(54906003)(66946007)(66446008)(91956017)(86362001)(64756008)(122000001)(66476007)(110136005)(6512007)(38100700002)(26005)(6506007)(6486002)(71200400001)(2616005)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWxkOUg0T0FSSWlIYlJxa2RtdWRSa3hSZGV3YVdlVUN3bWxtUTVjcmRJZ0ds?=
 =?utf-8?B?VVk1N2FSc2UzeElRdmoyVTVFRER6aWxVUGVJTXlPcDNUWVQ4d0RURyt0ZmZH?=
 =?utf-8?B?Uyt4Wmd3d0c1Q0NDcVdyZmlucDdraGRDcVJrNHFaSFZhN0ticWU1WDRiRU1m?=
 =?utf-8?B?NU94Tk55cXE0MHAxelJhSjB6SEI3R29KNEF2V0ovdDhBcktnNlZxdFNSZkZL?=
 =?utf-8?B?eVp5Kzl5Z3F3RjV2MzJyWUswUENIYW01d1ArU0pOa1cwbDdNVXdKZ25oRTFB?=
 =?utf-8?B?d0REV2VNNHJkM0RSMCt0MnNEb0Nha21JNHkyeUprbzJnbHp3ZVh2dDRXTllK?=
 =?utf-8?B?ZkVlQk4rdU4vMytiYTFyT1RoaWI1czl6Z2djc2plbFNwQnlFdW1QUTZSQzBh?=
 =?utf-8?B?cjBXb0VuKzlIM3Z6NDUvSDVyOWdKYjJzWSt6TjFSa01xSFJubmVPaVVFcjFU?=
 =?utf-8?B?YW03TGdmMzRWNFZhWUdOVjBhNHRkVWJhZitHSU5rRG9YSURIUWdzZlBZTVJT?=
 =?utf-8?B?TUJ1eXllaXRjWk9aL1YvRXVKa1R3M3ZEcCtLT1N5cGd6MWJGOU42bWxlNVFN?=
 =?utf-8?B?anpDUUF4YzQ4ZHZ0TEVTdTY3eno0R1NtbjZISGM2YVBEOG90TUNhYUJLWUt5?=
 =?utf-8?B?YXNkeTZTZGVGVjlQaW9pbDBNTklrdVRXeVdpTHNXK29zOHc4SDNyMFBvYXU0?=
 =?utf-8?B?SnhIWHEyaGFJb1R0STdCaDVsbmVsTGFZNUlOek12Nld1bE1aOVROamxSam9N?=
 =?utf-8?B?bDdIbUoxUWJZTHNQb2lmcE40NmJCanQ2SFZOK3VHdDcwWTVadjRXTXpzQ1hG?=
 =?utf-8?B?b1FHdlhwMmI5THM0N1BnamV3NFRYZTI1bERFUEpjd0VUL2xtNUN5WXRhOFFy?=
 =?utf-8?B?b2xtcEJjUWVMSTE4ODJ1NzhrODJBcDhXYjJQQm9VYy9QbmNFQUI3TEFqME0v?=
 =?utf-8?B?THJhSGhpakxDNnF2UW83a3hFclowbGsyTVc2VmhJVEgxdzNXOWZVeUtKcUZp?=
 =?utf-8?B?N1BBNjFlN2FuVFZ3b21zRHUwMWgxdndOd1dYdmprdUVlZ3F0RnVqOWJLUWVE?=
 =?utf-8?B?VXR4V1ErUDhUZUhkT0ltNDlRcXlOalBqWXh1SGJuSXNEVDhSKzVwdWpYRW5E?=
 =?utf-8?B?RkJ2VGJpU29ydnJ4cmtEL0N5blJnVXBEV0daUVc4Z2hEMEUyanR0b09CODJ5?=
 =?utf-8?B?aURrZG5RakxEZHIxQlRnU29KemY1cldCcFpyVlBMNmZjckc1REc5bjFwN0lK?=
 =?utf-8?B?ckdFcUdnY0RvSHVqMjludC9oOHpYZWNzODRHN1N3VmtVVk9HcWFKb0paV2M4?=
 =?utf-8?B?STJTaDBiK1NJdGNvVFF5d3RKTEU1OFk4N2pqQjNPOGdydEVIamorNC9hVHVW?=
 =?utf-8?B?dEFwcW4yN2psZ09POWRHelB4SFBUZmt2emt4VEFhMDc4ZlBVeFcra0F3Q3F5?=
 =?utf-8?B?UEszeGxkY1d4a20ySEtWQVZGdVFteWtscTJ3QU9KNzI4Qkl5dlZMeVVzOU91?=
 =?utf-8?B?OW5ZalNPRWMrVXFXd2pPQXUvYUhpMHV2dWY2dE5UL0VrZEIrNm9GQUF5blc0?=
 =?utf-8?B?bHZjN1ZLSHVRSU4rQUZ1ZkpNc2pLS05UN3FnRlpoNE1KUDNZbjdKaFdNYXEz?=
 =?utf-8?B?OHNnZWdYZDVFQWVwMWFLQ1o3UzZtWTVzSGRLaDRkY0hNZlg5YmVXbldYb0tr?=
 =?utf-8?B?NTRWVFFNWkM1QlN5SFo5NVFaZmVhbnY4Q0xGRUk2YUxGbUVHNFBwWTlLWWNJ?=
 =?utf-8?B?RklLUm53bnhTekhWZndEaldkYktIdWxYQUlEd0VhK2Vqd0FjNE1lSVhlTDVI?=
 =?utf-8?B?dHZXZkg5bGhrOEpnbUR6c0JWTTBKRUZqdXNKY0lGZXlldHF0ZHBsNS8yZERq?=
 =?utf-8?B?SFdtNVNHaExNSGs4ak9UeXdtdXEwSEF5Rks0ZlRMTlUxTVVtUWM5QXJQamp4?=
 =?utf-8?B?OVVsT1l2SDRIK1V5bGtlY0pBamN2dVVHNGQ4cGpWUWJ0d1hLVVl5dTJoeFJ5?=
 =?utf-8?B?ajhOSmN5S09Mdy9OTGIwMTd3UFR4R0hMdm1qYnhWWGJYSXFUVWtIVFBUWUlz?=
 =?utf-8?B?dXBWYjBtQlMvNTJ1cEV1R3M5VHdTWnJYNjVQNXVGUmxiMlRRd2hRMVBKdUtl?=
 =?utf-8?B?SnFDbThEL214UGx2UlVPaHppQXUzVGVHejR5azBjWFRXS3JmeXY4ZGxiak5U?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6042DA1510A9FC4D83A3850535DDC17C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c820410-c087-48cb-137a-08dbddffcc21
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2023 13:04:51.3710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+LfWMGn7Op/b6PDghBMJ2QPQe0Y3ObTyXGUFWHic3SmFHpoTGHmhKjErH7VteCHE+gRY6XzEQ8Z96zFYpFWkt+OS0dTpyLW/rJiZ4xY6dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7432
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTMxIGF0IDA2OjAxICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gTW9uLCAyMDIzLTEwLTIzIGF0IDEyOjQ1ICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gVG8gYWRkIHNlY3VyZSBmbG93IHN1cHBvcnQgZm9y
IG1lZGlhdGVrLWRybSwgZWFjaCBjcnRjIGhhdmUgdG8NCj4gPiBjcmVhdGUgYSBzZWN1cmUgY21k
cSBtYWlsYm94IGNoYW5uZWwuIFRoZW4gY21kcSBwYWNrZXRzIHdpdGgNCj4gPiBkaXNwbGF5IEhX
IGNvbmZpZ3VyYXRpb24gd2lsbCBiZSBzZW50IHRvIHNlY3VyZSBjbWRxIG1haWxib3gNCj4gPiBj
aGFubmVsDQo+ID4gYW5kIGNvbmZpZ3VyZWQgaW4gdGhlIHNlY3VyZSB3b3JsZC4NCj4gPiANCj4g
PiBFYWNoIGNydGMgaGF2ZSB0byB1c2Ugc2VjdXJlIGNtZHEgaW50ZXJmYWNlIHRvIGNvbmZpZ3Vy
ZSBzb21lDQo+ID4gc2VjdXJlDQo+ID4gc2V0dGluZ3MgZm9yIGRpc3BsYXkgSFcgYmVmb3JlIHNl
bmRpbmcgY21kcSBwYWNrZXRzIHRvIHNlY3VyZSBjbWRxDQo+ID4gbWFpbGJveCBjaGFubmVsLg0K
PiA+IA0KPiA+IElmIGFueSBvZiBmYiBnZXQgZnJvbSBjdXJyZW50IGRybV9hdG9taWNfc3RhdGUg
aXMgc2VjdXJlLCB0aGVuIGNydGMNCj4gPiB3aWxsIHN3aXRjaCB0byB0aGUgc2VjdXJlIGZsb3cg
dG8gY29uZmlndXJlIGRpc3BsYXkgSFcuDQo+ID4gSWYgYWxsIGZicyBhcmUgbm90IHNlY3VyZSBp
biBjdXJyZW50IGRybV9hdG9taWNfc3RhdGUsIHRoZW4gY3J0Yw0KPiA+IHdpbGwNCj4gPiBzd2l0
Y2ggdG8gdGhlIG5vcm1hbCBmbG93Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpI
LkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICB8IDI3Mg0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKystDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaCAg
fCAgIDEgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jIHwg
ICA3ICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNjkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2NydGMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+ID4gaW5kZXggYjZmYTRhZDJmOTRkLi42YzJjZjMzOWI5MjMgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gQEAgLTU2LDYgKzU2LDEx
IEBAIHN0cnVjdCBtdGtfZHJtX2NydGMgew0KPiA+ICAJdTMyCQkJCWNtZHFfZXZlbnQ7DQo+ID4g
IAl1MzIJCQkJY21kcV92YmxhbmtfY250Ow0KPiA+ICAJd2FpdF9xdWV1ZV9oZWFkX3QJCWNiX2Js
b2NraW5nX3F1ZXVlOw0KPiA+ICsNCj4gPiArCXN0cnVjdCBjbWRxX2NsaWVudAkJc2VjX2NtZHFf
Y2xpZW50Ow0KPiA+ICsJc3RydWN0IGNtZHFfcGt0CQkJc2VjX2NtZHFfaGFuZGxlOw0KPiA+ICsJ
Ym9vbAkJCQlzZWNfY21kcV93b3JraW5nOw0KPiA+ICsJd2FpdF9xdWV1ZV9oZWFkX3QJCXNlY19j
Yl9ibG9ja2luZ19xdWV1ZTsNCj4gPiAgI2VuZGlmDQo+ID4gIA0KPiA+ICAJc3RydWN0IGRldmlj
ZQkJCSptbXN5c19kZXY7DQo+ID4gQEAgLTY3LDYgKzcyLDcgQEAgc3RydWN0IG10a19kcm1fY3J0
YyB7DQo+ID4gIAkvKiBsb2NrIGZvciBkaXNwbGF5IGhhcmR3YXJlIGFjY2VzcyAqLw0KPiA+ICAJ
c3RydWN0IG11dGV4CQkJaHdfbG9jazsNCj4gPiAgCWJvb2wJCQkJY29uZmlnX3VwZGF0aW5nOw0K
PiA+ICsJYm9vbAkJCQlzZWNfb247DQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdHJ1Y3QgbXRrX2Ny
dGNfc3RhdGUgew0KPiA+IEBAIC0xMDksNiArMTE1LDE1NCBAQCBzdGF0aWMgdm9pZCBtdGtfZHJt
X2ZpbmlzaF9wYWdlX2ZsaXAoc3RydWN0DQo+ID4gbXRrX2RybV9jcnRjICptdGtfY3J0YykNCj4g
PiAgCX0NCj4gPiAgfQ0KPiA+ICANCj4gPiArdm9pZCBtdGtfY3J0Y19kaXNhYmxlX3NlY3VyZV9z
dGF0ZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMpDQo+ID4gK3sNCj4gPiArI2lmIElTX1JFQUNIQUJM
RShDT05GSUdfTVRLX0NNRFEpDQo+ID4gKwllbnVtIGNtZHFfc2VjX3NjZW5hcmlvIHNlY19zY24g
PSBDTURRX01BWF9TRUNfQ09VTlQ7DQo+ID4gKwlpbnQgaTsNCj4gPiArCXN0cnVjdCBtdGtfZGRw
X2NvbXAgKmRkcF9maXJzdF9jb21wOw0KPiA+ICsJc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2Ny
dGMgPSB0b19tdGtfY3J0YyhjcnRjKTsNCj4gPiArCXU2NCBzZWNfZW5naW5lID0gMDsgLyogZm9y
IGh3IGVuZ2luZSB3cml0ZSBvdXRwdXQgc2VjdXJlIGZiICovDQo+ID4gKwl1NjQgc2VjX3BvcnQg
PSAwOyAvKiBmb3IgbGFyYiBwb3J0IHJlYWQgaW5wdXQgc2VjdXJlIGZiICovDQo+ID4gKw0KPiA+
ICsJbXV0ZXhfbG9jaygmbXRrX2NydGMtPmh3X2xvY2spOw0KPiA+ICsNCj4gPiArCWlmICghbXRr
X2NydGMtPnNlY19jbWRxX2NsaWVudC5jaGFuKSB7DQo+ID4gKwkJcHJfZXJyKCJjcnRjLSVkIHNl
Y3VyZSBtYm94IGNoYW5uZWwgaXMgTlVMTFxuIiwNCj4gPiBkcm1fY3J0Y19pbmRleChjcnRjKSk7
DQo+ID4gKwkJZ290byBlcnI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKCFtdGtfY3J0Yy0+
c2VjX29uKSB7DQo+ID4gKwkJcHJfZGVidWcoImNydGMtJWQgaXMgYWxyZWFkeSBkaXNhYmxlZCFc
biIsDQo+ID4gZHJtX2NydGNfaW5kZXgoY3J0YykpOw0KPiA+ICsJCWdvdG8gZXJyOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCW1ib3hfZmx1c2gobXRrX2NydGMtPnNlY19jbWRxX2NsaWVudC5jaGFu
LCAwKTsNCj4gPiArCW10a19jcnRjLT5zZWNfY21kcV9oYW5kbGUuY21kX2J1Zl9zaXplID0gMDsN
Cj4gPiArDQo+ID4gKwlpZiAobXRrX2NydGMtPnNlY19jbWRxX2hhbmRsZS5zZWNfZGF0YSkgew0K
PiA+ICsJCXN0cnVjdCBjbWRxX3NlY19kYXRhICpzZWNfZGF0YTsNCj4gPiArDQo+ID4gKwkJc2Vj
X2RhdGEgPSBtdGtfY3J0Yy0+c2VjX2NtZHFfaGFuZGxlLnNlY19kYXRhOw0KPiA+ICsJCXNlY19k
YXRhLT5hZGRyTWV0YWRhdGFDb3VudCA9IDA7DQo+ID4gKwkJc2VjX2RhdGEtPmFkZHJNZXRhZGF0
YXMgPSAodWludHB0cl90KU5VTEw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAq
IFNlY3VyZSBwYXRoIG9ubHkgc3VwcG9ydCBETCBtb2RlLCBzbyB3ZSBqdXN0IHdhaXQNCj4gPiAr
CSAqIHRoZSBmaXJzdCBwYXRoIGZyYW1lIGRvbmUgaGVyZQ0KPiA+ICsJICovDQo+ID4gKwljbWRx
X3BrdF93ZmUoJm10a19jcnRjLT5zZWNfY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50
LA0KPiA+IGZhbHNlKTsNCj4gPiArDQo+ID4gKwlkZHBfZmlyc3RfY29tcCA9IG10a19jcnRjLT5k
ZHBfY29tcFswXTsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+bGF5ZXJfbnI7IGkr
Kykgew0KPiA+ICsJCXN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lID0gJm10a19jcnRjLT5wbGFuZXNb
aV07DQo+ID4gKw0KPiA+ICsJCXNlY19wb3J0IHw9DQo+ID4gbXRrX2RkcF9jb21wX2xheWVyX2dl
dF9zZWNfcG9ydChkZHBfZmlyc3RfY29tcCwgaSk7DQo+IA0KPiBzZWNfcG9ydCBpcyB1c2VsZXNz
LCBzbyByZW1vdmUgaXQuDQo+IA0KPiA+ICsNCj4gPiArCQkvKiBtYWtlIHN1cmUgc2VjdXJlIGxh
eWVyIG9mZiBiZWZvcmUgc3dpdGNoaW5nIHNlY3VyZQ0KPiA+IHN0YXRlICovDQo+ID4gKwkJaWYg
KCFtdGtfcGxhbmVfZmJfaXNfc2VjdXJlKHBsYW5lLT5zdGF0ZS0+ZmIpKSB7DQo+ID4gKwkJCXN0
cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnBsYW5lX3N0YXRlID0NCj4gPiB0b19tdGtfcGxhbmVfc3Rh
dGUocGxhbmUtPnN0YXRlKTsNCj4gPiArDQo+ID4gKwkJCXBsYW5lX3N0YXRlLT5wZW5kaW5nLmVu
YWJsZSA9IGZhbHNlOw0KPiA+ICsJCQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmlnKGRkcF9maXJz
dF9jb21wLCBpLA0KPiA+IHBsYW5lX3N0YXRlLA0KPiA+ICsJCQkJCQkgICZtdGtfY3J0Yy0NCj4g
PiA+IHNlY19jbWRxX2hhbmRsZSk7DQo+ID4gDQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiArCS8qIERpc2FibGUgc2VjdXJlIHBhdGggKi8NCj4gPiArCWlmIChkcm1fY3J0Y19pbmRleChj
cnRjKSA9PSAwKQ0KPiA+ICsJCXNlY19zY24gPSBDTURRX1NFQ19QUklNQVJZX0RJU1BfRElTQUJM
RTsNCj4gPiArCWVsc2UgaWYgKGRybV9jcnRjX2luZGV4KGNydGMpID09IDEpDQo+ID4gKwkJc2Vj
X3NjbiA9IENNRFFfU0VDX1NVQl9ESVNQX0RJU0FCTEU7DQo+ID4gKw0KPiA+ICsJY21kcV9zZWNf
cGt0X3NldF9kYXRhKCZtdGtfY3J0Yy0+c2VjX2NtZHFfaGFuZGxlLCBzZWNfZW5naW5lLA0KPiA+
IHNlY19lbmdpbmUsIHNlY19zY24pOw0KPiA+ICsNCj4gPiArCWNtZHFfcGt0X2ZpbmFsaXplKCZt
dGtfY3J0Yy0+c2VjX2NtZHFfaGFuZGxlKTsNCj4gPiArCWRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2
aWNlKG10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2hhbi0NCj4gPiA+IG1ib3gtPmRldiwNCj4g
PiANCj4gPiArCQkJCSAgIG10a19jcnRjLT5zZWNfY21kcV9oYW5kbGUucGFfYmFzZSwNCj4gPiAr
CQkJCSAgIG10a19jcnRjLQ0KPiA+ID4gc2VjX2NtZHFfaGFuZGxlLmNtZF9idWZfc2l6ZSwNCj4g
PiANCj4gPiArCQkJCSAgIERNQV9UT19ERVZJQ0UpOw0KPiA+ICsNCj4gPiArCW10a19jcnRjLT5z
ZWNfY21kcV93b3JraW5nID0gdHJ1ZTsNCj4gPiArCW1ib3hfc2VuZF9tZXNzYWdlKG10a19jcnRj
LT5zZWNfY21kcV9jbGllbnQuY2hhbiwgJm10a19jcnRjLQ0KPiA+ID4gc2VjX2NtZHFfaGFuZGxl
KTsNCj4gPiANCj4gPiArCW1ib3hfY2xpZW50X3R4ZG9uZShtdGtfY3J0Yy0+c2VjX2NtZHFfY2xp
ZW50LmNoYW4sIDApOw0KPiA+ICsNCj4gPiArCS8vIFdhaXQgZm9yIHNlYyBzdGF0ZSB0byBiZSBk
aXNhYmxlZCBieSBjbWRxDQo+ID4gKwl3YWl0X2V2ZW50X3RpbWVvdXQobXRrX2NydGMtPnNlY19j
Yl9ibG9ja2luZ19xdWV1ZSwNCj4gPiArCQkJICAgIW10a19jcnRjLT5zZWNfY21kcV93b3JraW5n
LA0KPiA+ICsJCQkgICBtc2Vjc190b19qaWZmaWVzKDUwMCkpOw0KPiA+ICsNCj4gPiArCW10a19j
cnRjLT5zZWNfb24gPSBmYWxzZTsNCj4gPiArCXByX2RlYnVnKCJjcnRjLSVkIGRpc2FibGUgc2Vj
dXJlIHBsYW5lIVxuIiwNCj4gPiBkcm1fY3J0Y19pbmRleChjcnRjKSk7DQo+ID4gKw0KPiA+ICtl
cnI6DQo+ID4gKwltdXRleF91bmxvY2soJm10a19jcnRjLT5od19sb2NrKTsNCj4gPiArI2VuZGlm
DQo+ID4gK30NCj4gPiArDQo+ID4gKyNpZiBJU19SRUFDSEFCTEUoQ09ORklHX01US19DTURRKQ0K
PiA+ICtzdGF0aWMgdm9pZCBtdGtfY3J0Y19lbmFibGVfc2VjdXJlX3N0YXRlKHN0cnVjdCBkcm1f
Y3J0YyAqY3J0YykNCj4gPiArew0KPiA+ICsJZW51bSBjbWRxX3NlY19zY2VuYXJpbyBzZWNfc2Nu
ID0gQ01EUV9NQVhfU0VDX0NPVU5UOw0KPiA+ICsJaW50IGk7DQo+ID4gKwlzdHJ1Y3QgbXRrX2Rk
cF9jb21wICpkZHBfZmlyc3RfY29tcDsNCj4gPiArCXN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19j
cnRjID0gdG9fbXRrX2NydGMoY3J0Yyk7DQo+ID4gKwl1NjQgc2VjX2VuZ2luZSA9IDA7IC8qIGZv
ciBodyBlbmdpbmUgd3JpdGUgb3V0cHV0IHNlY3VyZSBmYiAqLw0KPiA+ICsJdTY0IHNlY19wb3J0
ID0gMDsgLyogZm9yIGxhcmIgcG9ydCByZWFkIGlucHV0IHNlY3VyZSBmYiAqLw0KPiA+ICsNCj4g
PiArCWNtZHFfcGt0X3dmZSgmbXRrX2NydGMtPnNlY19jbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNt
ZHFfZXZlbnQsDQo+ID4gZmFsc2UpOw0KPiA+ICsNCj4gPiArCWRkcF9maXJzdF9jb21wID0gbXRr
X2NydGMtPmRkcF9jb21wWzBdOw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IG10a19jcnRjLT5sYXll
cl9ucjsgaSsrKQ0KPiA+ICsJCWlmIChtdGtfY3J0Yy0+cGxhbmVzW2ldLnR5cGUgPT0gRFJNX1BM
QU5FX1RZUEVfQ1VSU09SKQ0KPiA+ICsJCQlzZWNfcG9ydCB8PQ0KPiA+IG10a19kZHBfY29tcF9s
YXllcl9nZXRfc2VjX3BvcnQoZGRwX2ZpcnN0X2NvbXAsIGkpOw0KPiA+ICsNCj4gPiArCWlmIChk
cm1fY3J0Y19pbmRleChjcnRjKSA9PSAwKQ0KPiA+ICsJCXNlY19zY24gPSBDTURRX1NFQ19QUklN
QVJZX0RJU1A7DQo+ID4gKwllbHNlIGlmIChkcm1fY3J0Y19pbmRleChjcnRjKSA9PSAxKQ0KPiA+
ICsJCXNlY19zY24gPSBDTURRX1NFQ19TVUJfRElTUDsNCj4gPiArDQo+ID4gKwljbWRxX3NlY19w
a3Rfc2V0X2RhdGEoJm10a19jcnRjLT5zZWNfY21kcV9oYW5kbGUsIHNlY19lbmdpbmUsDQo+ID4g
c2VjX3BvcnQsIHNlY19zY24pOw0KPiANCj4gSW4gY21kcSBkcml2ZXIsIHNlY19lbmdpbmUgbWVh
bnMgZW5naW5lIHdoaWNoIG5lZWQgZGFwYy4gWW91IHNldCAwIHRvDQo+IHNlY19lbmdpbmUsIGRv
ZXMgaXQgbWVhbiB0aGF0IG5vIGVuZ2luZSBpcyBwcm90ZWN0ZWQgYnkgZGFwYz8gSWYgT1ZMDQo+
IGlzDQo+IG5vdCBwcm90ZWN0ZWQgYnkgZGFwYywgSSB0aGluayB3ZSBjb3VsZCB1c2UgY21kcSBu
b3JtYWwgdGhyZWFkIHRvDQo+IHdyaXRlDQo+IE9WTCByZWdpc3RlciBpbnN0ZWFkIG9mIGNtZHEg
c2VjdXJlIHRocmVhZC4NCj4gDQoNCldlIGVuYWJsZSBEUEFDIHByb3RlY3Rpb24gZm9yIHRoZSBl
bmdpbmUgdGhhdCBpcyBhYmxlIHRvIHdyaXRlIGRhdGEgdG8NCnRoZSBEUkFNIGFkZHJlc3Mgc2V0
IG9uIHRoZWlyIHJlZ2lzdGVyLCBzdWNoIGFzIFdETUEgYW5kIFdST1QsIHRvIGF2b2lkDQp0aGVp
ciByZWdpc3RlciBiZWluZyBzZXQgdG8gdGhlIG5vcm1hbCBEUkFNIGFkZHJlc3MuDQoNCldlIGVu
YWJsZSBsYXJiIHBvcnQgcHJvdGVjdGlvbiBmb3IgdGhlIGVuZ2luZSB0aGF0IGlzIGFibGUgdG8g
cmVhZCBkYXRhDQpmcm9tIHRoZSBEUkFNIGFkZHJlc3MsIHN1Y2ggYXMgT1ZMLCBSRE1BIGFuZCBN
RFBfUkRNQSwgdG8gYXZvaWQgc2VjdXJlDQpEUkFNIGJlaW5nIHJlYWQgYnkgdGhlIG5vbi1zZWN1
cmUgbGFyYiBwb3J0LiBTbyB3ZSBkb24ndCBuZWVkIHRvZW5hYmxlDQpEQVBDIGZvciB0aGVzZSBl
bmdpbmVzLg0KDQpObyBtYXRlciBEQVBDIHByb3RlY3Rpb24gb3IgbGFyYiBwb3J0IHByb3RlY3Rp
b24sIHRoZXkgYm90aCBuZWVkIHRvIHVzZQ0Kc2VjX2VuZ2luZSB0byB0ZWxsIFRFRSB3aGljaCBl
bmdpbmVzIG5lZWQgdG8gYmUgcHJvdGVjdGVkLg0KDQpCdXQgT1ZMIGlzIGEgc3BlY2lhbCBIVyBl
bmdpbmUsIGl0IGNhbiBvbmx5IHNldCBpdHMgRElTUF9SRUdfT1ZMX1NFQ1VSRQ0KcmVnaXN0ZXIg
aW4gW1BBVENIIHYyIDA3LzExXSB0byBlbmFibGUgaXRzIGxhcmIgcG9ydCBwcm90ZWN0aW9uLCBz
byBPVkwNCm5vIG5lZWQgdG8gc2V0IHRoZSBzZWNfZW5naW5lLiBCdXQgd2UnbGwgbW92ZSB0aGF0
IHBhcnQgdG8gdGhlIFRFRQ0Kc2VjdXJlIHdvcmxkLCBzbyB0aGF0IG1lYW5zIE9WTCBzZWNfZW5n
aW5lIHdpbGwgYmUgc2V0IGhlcmUgaW4gdGhlIG5leHQNCnZlcnNpb24uDQoNCj4gSXQncyB3ZWly
ZCB0aGF0IG5vcm1hbCB3b3JsZCBjb3VsZCBkZWNpZGUgd2hpY2ggZW5naW5lIGlzIHByb3RlY3Rl
ZA0KPiBieQ0KPiBkYXBjLiBJZiBoYWNrZXIgc2V0IDAgZm9yIG91dHB1dCBlbmdpbmUsIHRoZW4g
b3V0b3V0IGVuZ2luZSB3b3VsZCBub3QNCj4gYmUgcHJvdGVjdGVkPw0KPiANCklmIGhhY2tlciBz
ZXQgMCBmb3Igb3V0cHV0IGVuZ2luZSwgVEVFIHdvcmxkIHdpbGwgY2hlY2sgdGhhdCBvdXRwdXQN
CmVuZ2luZSBkaWRuJ3Qgc2V0IHNlY19lbmdpbmUgZnJvbSBub3JtYWwgd29ybGQgYnkgdmVyaWZ5
aW5nIGluc3RydWN0aW9uDQp3aGVyZSB0aGUgb3V0cHV0IGVuZ2luZSBpbnN0cnVjdGlvbiBzZXQg
dGhlIHNlY3VyZSBoYW5kbGUuDQoNCldlIHN0aWxsIG5lZWQgdG8gc2V0IHNlY19lbmdpbmUgdG8g
Y2hlY2sgdGhhdCBhbGwgdGhlIHNlY19lbmdpbmUgZmFncw0KYXJlIG1hdGNoZWQgdG8gdGhlIHNj
ZW5hcmlvIGFuZCBpbnN0cnVjdGlvbiB2ZXJpZmljYXRpb24gaW4gdGhlIHNlY3VyZQ0Kd29ybGQu
DQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiAr
DQo+ID4gKwlwcl9kZWJ1ZygiY3J0Yy0lZCBlbmFibGUgc2VjdXJlIHBsYW5lIVxuIiwNCj4gPiBk
cm1fY3J0Y19pbmRleChjcnRjKSk7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gDQo=
