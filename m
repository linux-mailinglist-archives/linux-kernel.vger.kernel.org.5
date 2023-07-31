Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C29768C25
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGaGmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGaGmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:42:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F060110CF;
        Sun, 30 Jul 2023 23:42:18 -0700 (PDT)
X-UUID: 617599302f6d11ee9cb5633481061a41-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=/gv27jedKu9kEwUa/9ZBRMYFDqYxWd7gcWSWwyGXtIk=;
        b=O2yfR8H5NqHKPeiA0JSiWa1luIfvyYKpvVhP812VtF27T3RkOz7pD3y3C9oAa+vqUu3OtgK87mCHLIinlrf3HIwf2c/IwIYPQ/77lhCkb9zTMKRPbb2cDmiHNQG8EmZtiFNirpP33V6GpaGVIpMRyJ+dEn7c0sCRC/6+GLMOoZM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:fd2580ca-eed3-41d7-9096-978ea1cc77a9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:4d1cb6a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 617599302f6d11ee9cb5633481061a41-20230731
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 497932381; Mon, 31 Jul 2023 14:42:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 14:42:12 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 14:42:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTMQ0kmHYGqt5///isdLHp/7hIJylgWQoTtg+csrGy+2fCtj2LtEcIFcGA5uk7I0J1MriNXrGHD1m3zF4wL2Vhz0H53Qz6vKnUPUF21DVfv+9cL7tr8mzucShF5c3Elv1v3Q46zMKLVFugkzltilDamtcDRTdTdp7Ten7dD0Ttb6jQmLsCnfvrF4MXr8IYU7AyJJFxRafP7am6g0kx4ais8Ra/5qsZz1o9NvhbqQjU1kenKzjzFMRhkb/wXzwnCZrOZsUbvaTsBHXQG5TrEEcpJmuXUTle64uXxWPWv9lQ8UvgvCRV0mIhW7GaOxazlDrXxfznRxNTlt6Rnt1hs18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gv27jedKu9kEwUa/9ZBRMYFDqYxWd7gcWSWwyGXtIk=;
 b=ocxoTSfsZaoAm7PI4QLaL5p6oViX+CNRb1hzbaDNc696uaNkwaE5Msol5MVmDxM9gpe+086yWioB94mp3w77eXZm2Af0/ar6PUxLHBKmu2G4hV/LfyoQzRJjCDoglLR+y2fGk5ljxsBKA4YZDYQVcNeMas+UNwP6cRUy/7G8odxh5cPAScgmIM/fp1+nuIxj/NaCJ2TQJnji6LuYjrDCwnvjvQbcQZkCyy4sLh+wRVyHataO20mJr25ImQJKPE9F/jIJtUnxISCNjqxbzusad/iwbD5tM4V8pQJbktSusMDlNUg1SVeuyPofd36/Ff0Owf7cJdqHsWKeIJaChidqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gv27jedKu9kEwUa/9ZBRMYFDqYxWd7gcWSWwyGXtIk=;
 b=ShXaTJ+A0ZCH7qm6t8dI20SguYG4UcE/EKvp6YLojnzp+NEMC2HCykmlT56PHynkzlBod06LVS9K5xWfO7A6k7gdMrZ9M34zmNBRTrMkXVjseULtXVRClUsXrUuqPSLn0+Ab+TPZ1FP6s2uFzXeAuZUT0WzUiAfT5B7Iztj4/3M=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 06:42:09 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 06:42:09 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Topic: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Index: AQHZwTM9qZx2VdeqykKSfnhu9XP0Bq/O8P2AgAAFtwCABHskgA==
Date:   Mon, 31 Jul 2023 06:42:09 +0000
Message-ID: <4aa7dd33239d568cfdf46f1e403bdeeef947726a.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-6-maso.huang@mediatek.com>
         <8e207baf-4a85-71f1-8ea3-08eab438b7cd@collabora.com>
         <ebfc016f57ec50ea8026efdce575813a75676b5c.camel@mediatek.com>
In-Reply-To: <ebfc016f57ec50ea8026efdce575813a75676b5c.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|JH0PR03MB7384:EE_
x-ms-office365-filtering-correlation-id: f9a4f409-1838-442d-93df-08db91914388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mXWDRfzNtdTVSK/ONblcwat647+DrDYEbNZ1KfvRDEzSzDU4w6HlxvDYwNGnGxxlxNI/jCFzefZhn/mUGVck64vdZSI6ba99u4KBWp9OnxebAJevwe0hAJeF7HgOS39v5q/9NK6MLadK2k0TubOzs6zJYBBGhEJrTZBwI8rj8Tw5SnJn5ZMaLiHSxc8P0q21UXRdnJa54y+aFWMBKIbqj1QEOV0oYsc3ebLLIUEqsbiUbXE8tb+X4HiJAfCIgwT/TuJbfgUrHtQ+4WOVeVYmYl3yemNoPt/PN0eUmnLnmNrQ5qLSn9/vAwLg3Wc8TQlgiEuLiEh+TMoB4Pthyt+Anrkc5KQO19NO824f00UpJnseN9VzrylCD2tDJBqHGS3AtSAcEIQoDEFlFQF+BfLfgrkbJWD8RNn1H9WBxGqRn0+1JONDr1b64IILF0EutDPztm1pJQyHcSjC3Eh7hQEU/I8bpPXAx9E2H1/lDKs41AUlOddH5imMo1xXm91aYQ7Y9HpZPSyiUeJugGbibYGLxpD6VNvLoaKwY40CquTan6NyW0tH5fIQC1tTnmkS5lG2eDjaqdbQ0jU/vGUbrZiffDJeDMBCPXqUF5xFD0mChPim8iJacfvdQvgeHleLBJvsv5o9rWaYFmFdma76eWPuqjiLRg3TyA5QG7PKR93hiWf2gYqsQp4+yr03WKDjtNW05mgmhzrVnxtidAkduStCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(966005)(6486002)(71200400001)(6512007)(478600001)(110136005)(186003)(2616005)(6506007)(26005)(2906002)(91956017)(316002)(66946007)(66556008)(66476007)(41300700001)(66446008)(64756008)(76116006)(5660300002)(8936002)(8676002)(7416002)(122000001)(921005)(38100700002)(36756003)(85182001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amVJOXQ2R202SG1HVHM5c3llT3NzZ1ViNDRITTBYb05RQTF2Q0xYcUl2SFRG?=
 =?utf-8?B?ZFB3RjhRK2MrVWx4bTdPSzVWOEpjWEg0V0JEVHNjQnBVdzdoelNhQmg1RWZV?=
 =?utf-8?B?VHkvd3dvYk5ubnh3RlJCek9IeU9DMWZJV0NVcXhoTGRnQnVxMXhJSUZtOXFF?=
 =?utf-8?B?ektSOXc2YTdiSXB4UktLTm5UL3lITkZrZW9TSVFmNFlLWTVqRGRDNXB3NGRS?=
 =?utf-8?B?OFZaOUdCcDRkMzhVRkZHcE15bGJXMWpNZEFlSTcvL0NRTlpqWlFKQVo4YnpO?=
 =?utf-8?B?ZjhJZFNZTEo1T3ZoVTZzYmlXV0tGMGV0R2ErTk9EZDBHT1YxNElGTlJjZGdF?=
 =?utf-8?B?d0pQOGRMa0xUNVlJMTJxZDhZckFwQW1sVFdpVXpTcnE1R1BiS1VBU0sxd0lR?=
 =?utf-8?B?eHBiWjhSNGd0R1Y4TVNURUxCWS9nbWwvQXZ6ZXg5NWJNdCtRWVdxTnRrL2xY?=
 =?utf-8?B?bk85KzVObEphUm5oM3Jld0s4bCt2T1FxbVNkcjdCS3lTdWM5bUgrMFJyU253?=
 =?utf-8?B?OVhURllzczRzdjZaM3BUeDlyOC8rNEpSR1VOcmVkdWV5ZjNtNmRSM1JMVzF0?=
 =?utf-8?B?Q3FFUjZoSXRXMEdrSDRVYmV6MU9xMWcwUXp3ZXpvOTExMUFYelBlZG9WMVJY?=
 =?utf-8?B?NUxhMVEvaVArSGw0NG9yTTY3bGtQWVRZdEF4bVpOdlV5S3FGSWIwV3BBaUcy?=
 =?utf-8?B?ZU9MYldnM0F6YnhiNklWT0tWSi9mVE5HM0JVN05Qa2h2b0taODlWMEtGQThO?=
 =?utf-8?B?ckdIY3B2YXVFZHNFQXJXZXB1TEhVcjZvNEdsRm8wTmNsczNEUFQ1K2t3ZFZW?=
 =?utf-8?B?SVphV0ZydVlFdlVncHJodGFrV3VpeW5NZUFKMFNTaXpEL2M2ZHZOdTEwZXdN?=
 =?utf-8?B?Z05za1FsdzcxNHRQeER3QmhtYlhWaXZXUGx2dHIxY3k1OVU3Zk1RL3ZUa2RU?=
 =?utf-8?B?ckhabTdkbkNheVVET1ptWUl2TEcyRnVlV0lyTkJwSE9SZTNwamVNVVIrQTI5?=
 =?utf-8?B?U01KaW9obHFVNEJLek5mVStoN1VrQ3g0YUtVejFkbllJczhqeVZJckY4YVZL?=
 =?utf-8?B?Yjlub3dHVnJVSlBmM2NoYk1hMEd5ZEZqSTlrYmw0M0wzQ1VEMXlZMi9QT2pH?=
 =?utf-8?B?dWUzYlUrQ2NRQ0RCaXlsTE92aGVmY0cwSTQrZ0VydXkreGVYTDJ5ZC9xajA1?=
 =?utf-8?B?dkRxTkFPNURDeSs5amtrTnV3NXUrdWovbThBSlBlZG5XSUd2bEZSN01NdEVn?=
 =?utf-8?B?WXd3Mzk1THE0WFlIMHlSVTQydHplZlErcGJRK0lUandqeThlQ3dQSW12anJB?=
 =?utf-8?B?SEJuQ1lLeEZJaXlwZVlXMGNOVzE5T210a0trcGJSYXBOdDBQc0pGMytJZlJB?=
 =?utf-8?B?elpWV0R6QzNZVlpySnZnemdlTVUzUVEwYXFLVzNDZUp2b2dORGwza3ZSaWhV?=
 =?utf-8?B?OTB6TnBRY1pHNjZVWU9rTUNQbEt6R3dFMlZrOUtEbFhReE1hTVFoelhaeTJS?=
 =?utf-8?B?b3Y2ek9tYnhmU1hWM2xMM1lIdkJiQ29Za1YxeWRpZkYxQ0UwT1o5eXFnMFNM?=
 =?utf-8?B?MzRYREJiSEt3TWszeDBmTFFxMjUzb2IwajRtaWFhWWtsZENVd01YU0pYV2pV?=
 =?utf-8?B?ZFdxU21DdThMbnMzZXV6eFI5QVBYRVJ4V3BXYklJQnhwbFpWKzZWY2YyMUNE?=
 =?utf-8?B?WkZPZnBSTmt4bjhXNWFHSmpKMWtpb3BsZ0hnN1dIdlZNNTdyUlI3WWNZdVNi?=
 =?utf-8?B?cXE3RWs2Zmx3QitrQllRMVdFMkt3NXE0VDJEVkYzTGNkR0NNb2VPc3lsdVgw?=
 =?utf-8?B?aHVyZ2Q0TjVWQmpwOTdmZVNHSkgzMEtocHJ1a0pTcXBuUVNUUUU2QXlmTkJX?=
 =?utf-8?B?d2YrT0tRMzFhY253STBNT0dxSngvTnBQRlFIdG0yZzJtNmkrWU4rTFYrYTBx?=
 =?utf-8?B?UGJyVU1UaDJaSXhwbDdHM0hPN1ZMRzhsWEFyU3YyWHNPR3B0dkl2ZlRuRjVP?=
 =?utf-8?B?Rnpab2dBblpzWXROWkdadm54Q09zK3lEM0pJTUZrQUpvbmsxcVEzVmk3N3ZN?=
 =?utf-8?B?RGptRzk4cUltK2tic205STJIVUxvb1pjUjI3clNIUFhXbUQxZ2FzZ295dzhK?=
 =?utf-8?B?Q2pqTWt5a3ZJVXpyQkd4S0QzLzBHWGdZcEJQbXE2Qk9vdDlJbjg5WDFHMXlr?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3A39E841F79CC4F9AB6354B25882F33@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a4f409-1838-442d-93df-08db91914388
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 06:42:09.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VHeV1fhOjz717ulJ8ZIZJ9DViDwGi3vIGMdFVqCWy9NWtF93jLBllBDzTFNYUOSvzzkSJVO8zZYkWi2I4oYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTI4IGF0IDE4OjE2ICswODAwLCBNYXNvIEh1YW5nIHdyb3RlOg0KPiBP
biBGcmksIDIwMjMtMDctMjggYXQgMTE6NTUgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIHdyb3RlOg0KPiA+IElsIDI4LzA3LzIzIDExOjA4LCBNYXNvIEh1YW5nIGhhIHNjcml0dG86
DQo+ID4gPiBBZGQgZG9jdW1lbnQgZm9yIG10Nzk4NiBib2FyZCB3aXRoIHdtODk2MC4NCj4gPiA+
IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5j
b20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgLi4uL3NvdW5kL21lZGlhdGVrLG10Nzk4Ni13bTg5NjAu
eWFtbCAgICAgICAgIHwgNTMNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykNCj4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
DQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWss
bXQ3OTg2LQ0KPiA+ID4gd204OTYwLnlhbWwNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdA0KPiA+
ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3
OTg2LQ0KPiA+ID4gd204OTYwLnlhbWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10Nzk4Ni0NCj4gPiA+IHdtODk2MC55YW1sDQo+ID4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi43NjM5NGY3
ZTU1MDINCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtDQo+ID4gPiB3bTg5NjAueWFt
bA0KPiA+ID4gQEAgLTAsMCArMSw1MyBAQA0KPiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ID4gKyVZQU1MIDEuMg0KPiA+
ID4gKy0tLQ0KPiA+ID4gKyRpZDogDQo+ID4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtd204
OTYwLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFsdTRaNnBKZVJpTDctOGw0VDNwdHFVQ001
NEZuSFRCaXloNUtXQk5xU2psNm1PT0k3V216SHBXRWQtWlNaLTJOSjRDczlQUGFBRl83NXl3bzJT
S1cxNk1QUFJhUk90MCQNCj4gPiA+ICANCj4gPiA+ICANCj4gPiA+ICskc2NoZW1hOiANCj4gPiA+
IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbHU0WjZwSmVSaUw3LThs
NFQzcHRxVUNNNTRGbkhUQml5aDVLV0JOcVNqbDZtT09JN1dtekhwV0VkLVpTWi0yTko0Q3M5UFBh
QUZfNzV5d28yU0tXMTZNUHR0WklMQW8kDQo+ID4gPiAgDQo+ID4gPiAgDQo+ID4gPiArDQo+ID4g
PiArdGl0bGU6IE1lZGlhVGVrIE1UNzk4NiBzb3VuZCBjYXJkIHdpdGggV004OTYwIGNvZGVjDQo+
ID4gPiArDQo+ID4gPiArbWFpbnRhaW5lcnM6DQo+ID4gPiArICAtIE1hc28gSHVhbmcgPG1hc28u
aHVhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gKw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiAr
ICBjb21wYXRpYmxlOg0KPiA+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssbXQ3OTg2LXdtODk2MC1t
YWNoaW5lDQo+ID4gDQo+ID4gbWVkaWF0ZWssbXQ3OTg2LXdtODk2MC1zb3VuZCBsb29rcyBiZXR0
ZXIuDQo+ID4gDQo+ID4gQWZ0ZXIgd2hpY2gsDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNv
bGxhYm9yYS5jb20+DQo+ID4gDQo+ID4gDQo+IA0KPiBIaSBBbmdlbG8sDQo+IA0KPiBUaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3Lg0KPiBJJ2xsIGNoYW5nZSB0aGUgY29tcGF0aWJsZSB0byAibWVkaWF0
ZWssbXQ3OTg2LXdtODk2MC1zb3VuZCIgaW4gdjQNCj4gcGF0Y2guDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IE1hc28NCj4gDQoNCkhpIEFuZ2VsbywNCg0KT25lIG1vcmUgcXVlc3Rpb24gZm9yIHRo
aXMgY29tcGF0aWJsZS4gDQoNClRoZSBzdWZmaXggIm1hY2hpbmUiIG1lYW5zIGFsc2EgbWFjaGlu
ZSBkcml2ZXIgZm9yIG10Nzk4Ni13bTg5NjAuIEl0DQptaWdodCBiZSBiZXR0ZXIgdG8gdXNlICJt
YWNoaW5lIiBoZXJlLg0KDQpPciB5b3UgcHJlZmVyICJzb3VuZCIgdGhhbiAibWFjaGluZSI/DQoN
CkJlc3QgcmVnYXJkcywNCk1hc28NCg==
