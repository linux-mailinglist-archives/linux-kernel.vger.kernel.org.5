Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C375318A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjGNFxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjGNFwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:52:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCB26BC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:52:49 -0700 (PDT)
X-UUID: a764fba4220a11ee9cb5633481061a41-20230714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AF8hG/8jHO4q2t04xn9MD9CJ7Ewis1nocf/JG/7Dqo8=;
        b=Wnort+9CYWrjy1dH3WIuM+Jn+3svxan2tcLtxlrLyNg536B1ixmqFI9+xELXEbz/I5hWejVBfosmK6GlVVIbDFijkY7kGH9rAgS7gFs2b1rLB0Zzd7Tf2cd+AanpJ0+ffuxo+pDzbU0TnFk6qQXNdgntvZk17Z6sqo8dpIHutLA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:915fcea7-8408-40a4-8dc7-25a7b59095be,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:5026a78e-7caa-48c2-8dbb-206f0389473c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a764fba4220a11ee9cb5633481061a41-20230714
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1978343393; Fri, 14 Jul 2023 13:52:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jul 2023 13:52:43 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jul 2023 13:52:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf5tL6BAup88UDUVINB3XzegoH3f4yKW2gyLu4G5MaPyJDzwxxRxry8d1HW0MB+u7xDWk8+ezIuKeKw1MusnQPHOBITA5g01U2Gpwjugi8AgpHteogTuT0V7o1lFKDq99RYpmWIV2F0epdO1gYhjPLpB3R2GZ0ntc6JGZ7ltFDp7dQnWrqwDGwHWPmgq17rgyiVhlgxvLh+GY/rHkWOuFbNCreUnNjokCqTJPPW+Vh8LMx4Qd6Wt045g2J4RTnpCtj3vENkccgmz4Lpv+MC0ZjvmMB/SKJE/K2UEnzCtrwDAUn/bUyYg5SFeCAJDyjHOjD4gJEL+idaqSpVI1LwLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF8hG/8jHO4q2t04xn9MD9CJ7Ewis1nocf/JG/7Dqo8=;
 b=F/jlQqxuvzkUdVN3kZ1SJlUZW+KP7770Asva3YiTPCc26qxTndytvFXI3b9/LQNO6+1olP0sg27fBn04+XkINU50+9GOcDXYHQzCZcXOazQJOX9RvF4dPF09roH377mauEBGB0NSVzyuvPRe5Q+APyP6cMJ/X2NIH6nk4enf686ZXa12BgSPB2rJf0KMEk5bJSotgbzZZUw8qeaEyGaQ/o5meyoyFGStQjT/WlM/Bbj+mVSBLP5/m0tb/cnU4ugQ9mSLOgIau1Y3mfSND5sR96Dxfest6LqhQBAZ+YQEiasGs7ST/FTzhMtoXiCvKVtKAj0Wq6h0kozEvV7UgV09mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF8hG/8jHO4q2t04xn9MD9CJ7Ewis1nocf/JG/7Dqo8=;
 b=XUv/1Wp7FOckl4Whw+AKafg8yh22yJOf9wVtktC9MbRurKbJpOdnM0/4fVy0rr4Xn9wHSmTlRI69kNRN+B6/Oz7pyCesv+N12Oa1Mr94YX69uGaWojWCYeKsH9zTjj3B1gfWhbKlXyk1lC29+ZUPqjr2kmIzmSEPXujxPUfMZ0U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5600.apcprd03.prod.outlook.com (2603:1096:400:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 05:52:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6588.022; Fri, 14 Jul 2023
 05:52:41 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 4/4] drm/mediatek: Fix dereference before null check
Thread-Topic: [PATCH v3 4/4] drm/mediatek: Fix dereference before null check
Thread-Index: AQHZpCqH0IDRjwYU8EGMkGs+jz9xXK+45ncA
Date:   Fri, 14 Jul 2023 05:52:41 +0000
Message-ID: <c5f996adc124497e7ca9541ca6e1cafe72b49f3a.camel@mediatek.com>
References: <20230621102247.10116-1-jason-jh.lin@mediatek.com>
         <20230621102247.10116-5-jason-jh.lin@mediatek.com>
In-Reply-To: <20230621102247.10116-5-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5600:EE_
x-ms-office365-filtering-correlation-id: b3222660-d841-440d-c4a4-08db842e89b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hgZwrrDaDDee8mIdCCkv98PWF2rWIZbfVHkSS5LxyvGE9dEhhTSbutjRFzk+F538/xw3SYv94OqvsSN69jk5OXFFJ3BuxCtwEjQuGcj2flaYYHA6fN85lNwsdSH+CGgrege9k6vTWb21ax5fdzC96fMmrFF5e2xPYvgZiZdIK1mgxkDJz1rjVbumHBINvtypMQTH8/OR7r0pXi0mYAAY7+86kbVoFH0QtQJrWYBujNK6CY+EEVHeUMsnjPdQXc5LqMzNpc36ldHnI6ptCmicqPj1HNhM9H86ibs4dVTsK44QYrTf3kTGVjsgsNFRxBQ1pKXMiFMsDysQIdBJtvDqP7xomwOm4nbvy5sFh2Ev5yJ2Zg8vr+Q8qNfLq9UuLKOeA5nbqv7DiIGTRzHz3CuP4AfUgCdZ+yPvBrvkpLU6lb+0BqIsgfr2Oj6HMv8rv/tQybgSutBrVU0kBFPUy0as8WxB+AncPAASnhIChZhBJLpLkNCEnGazTa4XdrvoPOmDMi8pijrQsR4augNeYsJgmxNSwk9ewutc7Z8Y/UuwwAPA/0vrOnd13SbkaHl8pJbtjQQIxwCQpMyRSN5tp0VEUMLjsFRdRCPOSKZepaaGiMDEy7cj6/cyKRb72XgHGSo3bjoPnqZ3TP3sEk1W/aOUBa7EsqgR4Sg38vgt9ju/ekI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(2906002)(478600001)(54906003)(6486002)(71200400001)(110136005)(85182001)(36756003)(8676002)(8936002)(66946007)(66446008)(76116006)(41300700001)(4326008)(66556008)(66476007)(64756008)(316002)(6512007)(83380400001)(38100700002)(122000001)(6506007)(5660300002)(86362001)(38070700005)(26005)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTZQei9NTGVnRGpoTjM5TnlGMHpNeU9WM3huaWtsRFNwcHJ0VWhPMWgzZUVp?=
 =?utf-8?B?alFYa3NNNW1MSjJTYjRRTnNCVW5lc1A0eVZsbXg0TmFPWFV6SlRjWWNyLzBX?=
 =?utf-8?B?SVozK2RZYlVyeWR3YUc4SDFRT1UvK0xpQ3JVbmZ5TWJIbWRzTmU5SmIrWHdR?=
 =?utf-8?B?VXMrME9CUmorOVJqS1gyaWRzOVhDV3M1Q1FMTHp2YU5Hd25UZ2ZWWW1vcExN?=
 =?utf-8?B?QUlCYTBRcit4bllESTNZaWVCYytJTnZHTE81aXM3OWFuQU9ZaDNPR3A1ZVow?=
 =?utf-8?B?ZVBnL3BkQm0vYTBNNEIxNDlwbFNSWUJOTEpZN1pSZXJEUTFJaWxzeWlRZm95?=
 =?utf-8?B?NWI0SFVxK2VNZytRKzVPbnA4Tk1BSWVYR0RxekJRV2k3MnRkUDRJVUlPZnJv?=
 =?utf-8?B?WCtKMXphWlVvcXhSb2RJWWZaMXcxWHVKcjVFVXVIUFJkeHhmSXVSUFJJdmJu?=
 =?utf-8?B?S2owazVrTFhWc21mRTJleGQ2c0FWeGkwcVNBZGdMMXBNRkw5cksrZ09Oak90?=
 =?utf-8?B?S3dVc0dheDFhMzAvbjNLN3c2dEZGaVUyTDIwN3JvTDFidFhlUVZoYW5ZeG9m?=
 =?utf-8?B?YjFjVWFmZkYrYUxRSjd6YWl3bFZLN2lJNDU2ejVqVTE2ekRBdXNldGlVbjJM?=
 =?utf-8?B?RWYyUEt2dUc0MEhvajlOajR2dkthU25NTXdIdm9Mcy9TV3ArSVkwZU5DbU5K?=
 =?utf-8?B?OWJUbTdVcklDQlFmdk4rYkJvN1FHdlQrN0x5VW1rc2xPQUoxQko3aHhwTXRy?=
 =?utf-8?B?cUhtMjJNNDBQclpmSmh0TXk5Vlh5MGlGbmJsMGt0NC9CSU9JWmxrUGQxT1FY?=
 =?utf-8?B?cWRVM2RBODZ4anpDVXZGeEdmZ0R4UFBuVGRBMGhoNHJwOUE3L3cyQy9rcnhX?=
 =?utf-8?B?NjVGWmkzM2NqSlZYMUY2cVBTdTVzSkMrTmtHZTdTcHU1WnJCd3NNd3IwYkxW?=
 =?utf-8?B?VkYwTzNINjR5NVZhK0x2SFVhQ2o1NktlUTJZUDFmYklyTDFBR2t1cTgwUkRk?=
 =?utf-8?B?ZVBmeTJvQkZFOXB3L091eU9PSGk1Z1F6WmlTdURYa2hJWkNDYXJoU3IvS3pM?=
 =?utf-8?B?cmxYVEtVWXRrd3BnbDZrUWJlM2E2TkhhTnZ2RXQreVNiRTYzSEZ0d3hRc3I0?=
 =?utf-8?B?MSsxR0hvMEdaUWM5K2E1dHJUUnNYNlRtQzBGSjc1UUxGTmpGZGRGZ21ETTRR?=
 =?utf-8?B?RTRyWU0xcUlNajZxMVMza0hFcHBtZmNaSTNKRlpuMzV5UGd0UDBhWG5VQmdQ?=
 =?utf-8?B?QTJ1SHEwQW40NFRyNXIraXR6MFdwek5pSkdtblJhVkJBZThxam5sQURwYncx?=
 =?utf-8?B?TW1EY0g5bEt3c2Jweld2elBIZndwc3E2WWN3N0x2TGdkWnRNc3cwTUI2eXh1?=
 =?utf-8?B?U09WS05Qb3kwYlVodkdWSHJMZHNNMXFzQVEzd2FPMEpMNnYza3dQckJ4TWs2?=
 =?utf-8?B?R3dYRjhYU1FxMTRTVXFHWE5RRTNWUDIyRnFITXlDeHArRE92RVZ4a0FJeWhr?=
 =?utf-8?B?OWhVUFB5N2VtczN6a0xkeXVTZXRWcEk5cFlYbGhkRnFMTGR2b2tCeG10cHFQ?=
 =?utf-8?B?cmQrb3hvVGQ2QThGai9UTUYyNDBJVUxYTmJ2T04wdGljSjdscU1kNENnT2Jj?=
 =?utf-8?B?STNlVzV3UzR1Q3NEb1VKQ1k1d092eFp5VmVNUElSc1hpUG5yWXZ2bk1IWmVj?=
 =?utf-8?B?NmxVeFF6WE1jb05na28vQWlQeHNIR2VGQ2gwT1ozOTRNRHBXRkliUWs4cld5?=
 =?utf-8?B?MzJNekRBUXdOejhwY1ZHY1IyTUJKQ1ZUUDVHcExaZDRDM3ZWTnpyNnhZWTc3?=
 =?utf-8?B?V2tUaEsrejVnY2ZRQ3VQWENub3ZRSjZxM0RORWNoMk4yMVA1cmNxcGpwaWhP?=
 =?utf-8?B?L1AwR29wajVXeGVuWGNHQjdRcXk0NlpmNktkQ29nN2MzNm83VEk4aUdibUdB?=
 =?utf-8?B?Y2dKQ2d2S1FXSkVmb3VqOXYwb2M4bmZmOXRrMk5nMk5NM21lczhUS0RqYkE2?=
 =?utf-8?B?bzNYdWNqYVorZEM0a050Z3d3TXIxYWxCbkRHQXUrbUUwNFhEekhtUDZSWGNh?=
 =?utf-8?B?ZWduNGJobTZpU0ZqMW9vZGp6RTVQMitPZ0theVZQU2VEZWQySXhjVFFjdFpl?=
 =?utf-8?Q?ID5CocOjc+tOmJOkhNGV85579?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8C306D8A4DC564F87BD3E0B6CC37711@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3222660-d841-440d-c4a4-08db842e89b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 05:52:41.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdU/i7d8d9FTlDlf/Q2tYNPftYnZ93RJAADNUkU8IfM4gl9X9+YrcIBbVJyPwO3khSLm0hpCoq7bMC6zk6n3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjMtMDYtMjEgYXQgMTg6MjIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gTnVsbC1jaGVja2luZyBzdGF0ZSBzdWdnZXN0cyB0aGF0IGl0IG1heSBi
ZSBudWxsLCBidXQgaXQgaGFzIGFscmVhZHkNCj4gYmVlbiBkZXJlZmVyZW5jZWQgb24gZHJtX2F0
b21pY19nZXRfbmV3X3BsYW5lX3N0YXRlKHN0YXRlLCBwbGFuZSkuDQo+IA0KPiBUaGUgcGFyYW1l
dGVyIHN0YXRlIHdpbGwgbmV2ZXIgYmUgTlVMTCBjdXJyZW50bHksIHNvIGp1c3QgcmVtb3ZlIHRo
ZQ0KPiBzdGF0ZSBpcyBOVUxMIGZsb3cgaW4gdGhpcyBmdW5jdGlvbi4NCg0KUmV2aWV3ZWQtYnk6
IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCg0KPiANCj4gRml4ZXM6IDVkZGIwYmQ0ZGRj
MyAoImRybS9hdG9taWM6IFBhc3MgdGhlIGZ1bGwgc3RhdGUgdG8gcGxhbmVzIGFzeW5jDQo+IGF0
b21pYyBjaGVjayBhbmQgdXBkYXRlIikNCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxq
YXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlu
byBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyB8IDYg
Ky0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxh
bmUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gaW5k
ZXggMWNkNDE0NTRkNTQ1Li40ODI4ZmZhNzU0NjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBAQCAtMTIyLDExICsxMjIsNyBAQCBzdGF0aWMgaW50
IG10a19wbGFuZV9hdG9taWNfYXN5bmNfY2hlY2soc3RydWN0DQo+IGRybV9wbGFuZSAqcGxhbmUs
DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCWlmIChzdGF0ZSkNCj4g
LQkJY3J0Y19zdGF0ZSA9IGRybV9hdG9taWNfZ2V0X2V4aXN0aW5nX2NydGNfc3RhdGUoc3RhdGUs
DQo+IC0JCQkJCQkJCW5ld19wbGENCj4gbmVfc3RhdGUtPmNydGMpOw0KPiAtCWVsc2UgLyogU3Bl
Y2lhbCBjYXNlIGZvciBhc3luY2hyb25vdXMgY3Vyc29yIHVwZGF0ZXMuICovDQo+IC0JCWNydGNf
c3RhdGUgPSBuZXdfcGxhbmVfc3RhdGUtPmNydGMtPnN0YXRlOw0KPiArCWNydGNfc3RhdGUgPSBk
cm1fYXRvbWljX2dldF9leGlzdGluZ19jcnRjX3N0YXRlKHN0YXRlLA0KPiBuZXdfcGxhbmVfc3Rh
dGUtPmNydGMpOw0KPiAgDQo+ICAJcmV0dXJuIGRybV9hdG9taWNfaGVscGVyX2NoZWNrX3BsYW5l
X3N0YXRlKHBsYW5lLT5zdGF0ZSwNCj4gY3J0Y19zdGF0ZSwNCj4gIAkJCQkJCSAgIERSTV9QTEFO
RV9OT19TQ0FMSU5HDQo+ICwNCg==
