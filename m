Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7156C7E3344
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjKGCxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKGCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:53:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA511C;
        Mon,  6 Nov 2023 18:53:29 -0800 (PST)
X-UUID: d1c2d3447d1811eea33bb35ae8d461a2-20231107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Svg38VOpeqdBIEUowDxdfAf4rbDa6SErpnzUk0TcEo8=;
        b=myaIY0HdyHOB77F2vJmICj9Yf7tBQiSk8oDC7j03Dj5UBgMXAK7t6yBrJ1b52YribfT/acnnhI2FuOCi1C8Osr/HEzi9lWWxux/cyORH+kn8TCEvK8WtcH0mISIVCIZ+Tyk0bpMQ8hFpy1QLo/AYfazuYF6i/iLUW4kJgxjL8LE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:7b97411b-038a-4cd0-8489-3aa7ca8658b5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:c970c25f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d1c2d3447d1811eea33bb35ae8d461a2-20231107
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 735381976; Tue, 07 Nov 2023 10:53:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Nov 2023 10:53:23 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Nov 2023 10:53:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh6jW8TLkP5RQRIx98tJIZb6xuBW3EtwdLK3Ocu8hVlhLHr0FUBr6GcjTaSMRP0HcIvGa3GbhlYZV6Mp08ZmuykQINveo5zit6xEYSzxfAE4+rMnuPaLtUZOUtBAlwYZr+W1zoEJcL+FI75bR6tBBdMxjcVARqeqUrFd3cPEwjYK8mTa24nfm6cTItLa+Fsg7o0WwUl43EoCCWOQr0KIoPJFW7n+o10ZRkfPwMEvB6glKN9RyDOk6bC5aKjy7PHWhNRwe9vWC//3oWOrhbrHXFWfIrPx7NZ/+3XtRwyQfIrcg4RGHCS2HeG+D0Xd70DCluw23xxfxs8Dn4m8MFO09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svg38VOpeqdBIEUowDxdfAf4rbDa6SErpnzUk0TcEo8=;
 b=oCb00FzF0i6h0GybgZn7UC0/M4KSN/zcchZ3u5BHeOh5JnFD/kHH3rEQ0JqwedxFNU8ha4eqN1+qvRKfMZ9ggNft5GuOBZlpg2lct7ZdV+79UTV6B4Ilg+MTtHLtn4RWT/w0x8uQHodAm2Yapz0gmDBOPd9rldhrpn2WNVu3B5f9WAv6YoRBfWNKnLxmGf0F5v9nX+KUFodlS4DQC8/FRxwlDxnAnu3/518f386CHUXoOooV0c2pQl367VIzYwHXllsMu6KENUf4TcJ0z7P72b4Kwn1CUQIbywtpe391ZIgX1nrHcZk0mTFqF1BWugLYa/zUs44T6m7TPmnfLzKptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svg38VOpeqdBIEUowDxdfAf4rbDa6SErpnzUk0TcEo8=;
 b=btsK7u7lq4LYU54BNGCx10niXrDIlQkMUv3EykD9EiLkHz7M05FaqbUiWr7yqLKnTPL/uilvvoSgDeMty4f+KMjbb1zPglaXChR5BqhS+s16BflzY/JeKBv8P1e+TuWEBNyA8J7NQMHEbJqQGDho1Zk9YKgUbrh5u1HFt3re164=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 SI2PR03MB5626.apcprd03.prod.outlook.com (2603:1096:4:127::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Tue, 7 Nov 2023 02:53:21 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 02:53:20 +0000
From:   =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     =?utf-8?B?V2lsbCBTaGl1ICjoqLHmga3nkZwp?= <Will.Shiu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] block: Check the queue limit before bio submitting
Thread-Topic: [PATCH 1/1] block: Check the queue limit before bio submitting
Thread-Index: AQHaByTnzFC4rhYmWUKg+y7lOe9n1bBkxn0AgAQOpYCAAJQggIAAKqIAgAMAagCAAAHEgIAANgSAgAB1oACAAPsggA==
Date:   Tue, 7 Nov 2023 02:53:20 +0000
Message-ID: <fb568e7a1020ef6d2d22f3f0771034b1dc699fb9.camel@mediatek.com>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
         <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
         <ZUUd48QF/TEGFzPy@fedora>
         <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
         <ZUW96Ha5GoJePD8Y@fedora>
         <2bc847a83849973b7658145f2efdda86cc47e3d5.camel@mediatek.com>
         <5ecedad658bf28abf9bbeeb70dcac09b4b404cf5.camel@mediatek.com>
         <ZUhxS9JMyPK+v6Ec@fedora> <ZUjT11xUNM7u/UjV@fedora>
In-Reply-To: <ZUjT11xUNM7u/UjV@fedora>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|SI2PR03MB5626:EE_
x-ms-office365-filtering-correlation-id: 5da3e5c9-dd0a-4805-0138-08dbdf3cb3a8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SnAWHYFxfEvNoBWSgL6ZpiUSW0+Q5maNw7eSNzrEjV8XEwMAbEZzZ2S9TY7Sedz9qWq5GRCvMQZOppD3FhPDy/cTS2VGpA5iTp/iNdSY1VmoxUuRdNju23NCzECjyEoFMTV7L5WKXNymQ6L5jJyiZoSzvo6fxTZIHyIgv9sENK8CZdjFLbK08u4MicTuBEcL92t6insdTT7csXS1IQO25GmnhJ2T2s+7zCKxOuoh9ENBlq3xeFDLFPdbxiL2bzOrIOL86NVJBHPkJA2RMcDnEOl3BJOFtR18cozFvn6OsyQeI4Q6MGXCLoGTp/WNWkjTIDVVVWVJC9aFlDH1q6U1gHwqQS5/uqQDUyvpUEweao2nZwbflOKsMDyxqW3osZY8IRL+qZCSkbuNRKZTtH/tHYk2x6S2R+Ti1cMXbqkKC/3hz0nyTHZMWEnLDV3f4OmlQgQhsmTVSPMS4he03i3A/S8nvd7NvTZHAsQx9nQBSTDJnod6EkmiQkM+ZvQtUzDC2Zp2K9xjBUX0BH1LGOAtdnxTheVcoI7cRwt+oGUdeoc0AuVKmoMM0DfP9T/HyzrPBrUiVNTrS/lpDHTRdor8ChcUGa9U7SalTK4V7sc2wyz55nx0YhdN59CQyUIYcx8UZWtmn1bgI7svdeG3J6j7aLuLrZR+6SM7ItmKaqqfvRg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(54906003)(316002)(64756008)(5660300002)(6916009)(4326008)(8936002)(6486002)(2906002)(478600001)(8676002)(76116006)(91956017)(66946007)(66556008)(71200400001)(66446008)(66476007)(6506007)(6512007)(26005)(2616005)(83380400001)(38100700002)(38070700009)(122000001)(36756003)(85182001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVQrRnNHSEl3a2t1ZEtEbDIzNFFkcXc5QTJYc3FHS0VBR0orWmY2WGI4R01k?=
 =?utf-8?B?Vld1YjduaUJhSzFiMkxMWUg5NnN0Z0JEOGRXZ0NPZHdMUVZKeGhzYlY4VHRl?=
 =?utf-8?B?V3dMbVpLdWM4MFF5anJNeEE3ditQVjkrU2hoT004WHJpZ3hKTmZRRDhaUFpI?=
 =?utf-8?B?YWpxc2ZiVngxbG5qcFhnMi9wa3YvN0Zqa3ZNcFV1Mzd6Ri8vd2U2NzZYa0d3?=
 =?utf-8?B?S1hwR1VyU1lHQWQ3L3JLZnhmM1ovcHdJL040Q3F3UWNKNUcvTkx6RTVpZGor?=
 =?utf-8?B?eTd6NDZJelVPR2NFVC94dVdDckxGbWtuVytBUGlGaHpnUU1lbTJOUG9VTHVt?=
 =?utf-8?B?cVY0KzB3cFVOODJ0VzVwbkhzL0pFSXFsMm9vQXVyT3FYTERQYzRJVi83dWRZ?=
 =?utf-8?B?UlNCUGpIYmgwK0o1SlR3WDkwdnNDSFZFV09NdVRTMDBXeWNxeWVTM3o1bFRT?=
 =?utf-8?B?aDYzSEZMNE0wZngyYzMycURKaEFCMVBmTldvWFp2WitkdzJCbHlTN3p1ek9t?=
 =?utf-8?B?ZTdLVjhtbFlXZnhmRDJEa3NJSmhNbDdyM2ZpUXlPQTJqVFlIRnI4T0NaTmZD?=
 =?utf-8?B?YW5qb2RPTCsyaXFKZ0RZbVNJNjRPQXRSOXJBc3U5NnByejhRS2xvWFNNMnkr?=
 =?utf-8?B?azgweklKODBLT1ZIYUFrWkZRSUNFdDNLTTFycmJvTU80dXpiV3VEekNsTzJQ?=
 =?utf-8?B?aXNzMmlxVUhlRWJjcEpPekJsdnRWU3NuT1o2Yk9LVml1NTNaYWJGZ3Eya1FQ?=
 =?utf-8?B?bFJ1RHFMSGZLZVdsYldia1FoblBuVk9NV0RUOURiUFJ1bU10RVhUamg2S01z?=
 =?utf-8?B?amkvOHVibTU2VlM3NnNVR1JOT2dZMzNqYUhTR1NsK2VQVkorMEVOcDczRDNU?=
 =?utf-8?B?cHVVWXFhQWZUZ3A4VHNJcWErZTJxeG5RZlZqbmw3em5nS1Y1cDNEdlhqamhy?=
 =?utf-8?B?TVlpZU1tdmtwRXlyUmQwOXlBT2c5ZnVCUGdkK1U5b0s0dkVwd0tQQVU1aU5F?=
 =?utf-8?B?RlBPQzFjWStxbTAybUNKVVNvdkwvWW13NEFLaThtQld2MFJSV1JQSG5JOVhC?=
 =?utf-8?B?SitoWStMWjhldkVIUnFxZlhkOG91Tk13b2pQK1BDcllrakxYYjYvL1VwVjRS?=
 =?utf-8?B?bWxNTWdrWllhdkE4WmpJTkN2VVgxUjFGRE10MkNyUUhkMzBKaHh5TjlCNnhs?=
 =?utf-8?B?ZnluSnNyQnBwVXpFTGNFQnJwK0J4SzB4dTdRUmpOTlBzOU11VDBzK1I0bnJo?=
 =?utf-8?B?MFkzWlAxbFFGYTNJdVp4ODNHcGxGUklPUmczSWVhNmd0SnBZeWZIbVVLc1d1?=
 =?utf-8?B?b1Y0QUNRKy9HS2FVd2hteEs5UGRDQ0ppUDZmbDA0YkZiWjRkdVNtVnNOT00y?=
 =?utf-8?B?NnhFZCthUUt1ZERKdEZTKzZvc3Qxckd3ZUhLTmNkZytWZzZmWGUrZkxjSnk0?=
 =?utf-8?B?RGY1QW1peFdvUVExdnlMbDJXdFErbGcvUDl1WFVjM0FXNGZEQ3l6QXhCOFEz?=
 =?utf-8?B?cFo1a2JobGVvbGRSNXhFY0ZuNWtvNi9DOFBqTHUrZFJvN1kwczVzUnM1Q2hz?=
 =?utf-8?B?Q0ZYNHFWUjR2MTBMTlVqeUhFZGlQM0NvR1B2Syt6aHZFelN6TVZSZlc3TFly?=
 =?utf-8?B?MjJYUTVKL25xWGNxcWJNak1XVFpyVnZuVitvcVMzNitob2I5ODlQa01HYndY?=
 =?utf-8?B?MmhhbGNEY2NicHBtaXNDenZhNVdKNW9HYzNIS1FRYjFIc0tiSGtUVXE2SVR0?=
 =?utf-8?B?WW52ODIrYXBxbHJsWjBCaE9vdk1Rd1I0VlpCcVA1ZVhKR29HSFRIWCt4MW5y?=
 =?utf-8?B?c3dyYndLQnRncndWeDU2TG5RQjlLV1BESnlNMnlnYWkvRE9SZXNFcWZXVUpR?=
 =?utf-8?B?cmtJbWtZVm9GUWs5NFZBb3pJcXRyR2NUOEpueTAxc0p2TGozMU1OQTZSSEpz?=
 =?utf-8?B?V1JEYWtYWEdyL1FqSHNPc3ZiaUticVZuRnVRZUJ0VUFlQUNPRGMrOWMwOUJW?=
 =?utf-8?B?MG8xM25pQi9kZXAwYWpwYm5YbnpGMld2dHNsQTJwSFp1ZmJSZ2xGRHJOYjBx?=
 =?utf-8?B?U05pK0h1RnlIWGM1LzdPajl4a2dQdHJYS09nbVloRk5jcDU0cnpEUGprUlA1?=
 =?utf-8?B?dTN6cnhUdldPR1V0Qm5WS29jcm5lYTdNeDhnbFNBTHJyM09hd0drNVVZRXJw?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22C004596A222D4F8031467C3E7438C7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da3e5c9-dd0a-4805-0138-08dbdf3cb3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 02:53:20.8085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9VDzx4QIQWBJW6ih9uNoyi66/ERE7vi3XcQ5W2BpDe0w/9qzUCuDk5tRsSCeUhKmWlTivWK9XwgMm3cZAORcNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTA2IGF0IDE5OjU0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gIE9u
IE1vbiwgTm92IDA2LCAyMDIzIGF0IDEyOjUzOjMxUE0gKzA4MDAsIE1pbmcgTGVpIHdyb3RlOg0K
PiA+IE9uIE1vbiwgTm92IDA2LCAyMDIzIGF0IDAxOjQwOjEyQU0gKzAwMDAsIEVkIFRzYWkgKOiU
oeWul+i7kikgd3JvdGU6DQo+ID4gPiBPbiBNb24sIDIwMjMtMTEtMDYgYXQgMDk6MzMgKzA4MDAs
IEVkIFRzYWkgd3JvdGU6DQo+ID4gPiA+IE9uIFNhdCwgMjAyMy0xMS0wNCBhdCAxMTo0MyArMDgw
MCwgTWluZyBMZWkgd3JvdGU6DQo+ID4gDQo+ID4gLi4uDQo+ID4gDQo+ID4gPiBTb3JyeSBmb3Ig
bWlzc2luZyBvdXQgb24gbXkgZGQgY29tbWFuZC4gSGVyZSBpdCBpczoNCj4gPiA+IGRkIGlmPS9k
YXRhL3Rlc3RfZmlsZSBvZj0vZGV2L251bGwgYnM9NjRtIGNvdW50PTEgaWZsYWc9ZGlyZWN0DQo+
ID4gDQo+ID4gT0ssIHRoYW5rcyBmb3IgdGhlIHNoYXJpbmcuDQo+ID4gDQo+ID4gSSB1bmRlcnN0
YW5kIHRoZSBpc3N1ZSBub3csIGJ1dCBub3Qgc3VyZSBpZiBpdCBpcyBvbmUgZ29vZCBpZGVhIHRv
DQo+IGNoZWNrDQo+ID4gcXVldWUgbGltaXQgaW4gX19iaW9faW92X2l0ZXJfZ2V0X3BhZ2VzKCk6
DQo+ID4gDQo+ID4gMSkgYmlvLT5iaV9iZGV2IG1heSBub3QgYmUgc2V0DQo+ID4gDQo+ID4gMikg
d2hhdCBtYXR0ZXJzIGlzIGFjdHVhbGx5IGJpbydzIGFsaWdubWVudCwgYW5kIGJpbyBzaXplIHN0
aWxsIGNhbg0KPiA+IGJlIGJpZyBlbm91Z2gNCj4gPiANCj4gPiBTbyBJIGNvb2tlZCBvbmUgcGF0
Y2gsIGFuZCBpdCBzaG91bGQgYWRkcmVzcyB5b3VyIGlzc3VlOg0KPiANCj4gVGhlIGZvbGxvd2lu
ZyBvbmUgZml4ZXMgc2V2ZXJhbCBidWdzLCBhbmQgaXMgdmVyaWZpZWQgdG8gYmUgY2FwYWJsZQ0K
PiBvZg0KPiBtYWtpbmcgYmlnICYgYWxpZ25lZCBiaW9zLCBmZWVsIGZyZWUgdG8gcnVuIHlvdXIg
dGVzdCBhZ2FpbnN0IHRoaXMNCj4gb25lOg0KPiANCj4gIGJsb2NrL2Jpby5jIHwgMjggKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9iaW8uYyBiL2Jsb2Nr
L2Jpby5jDQo+IGluZGV4IDgxNmQ0MTJjMDZlOS4uODBiMzZjZTU3NTEwIDEwMDY0NA0KPiAtLS0g
YS9ibG9jay9iaW8uYw0KPiArKysgYi9ibG9jay9iaW8uYw0KPiBAQCAtMTIxMSw2ICsxMjExLDcg
QEAgc3RhdGljIGludCBiaW9faW92X2FkZF96b25lX2FwcGVuZF9wYWdlKHN0cnVjdA0KPiBiaW8g
KmJpbywgc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ICB9DQo+ICANCj4gICNkZWZpbmUgUEFHRV9QVFJT
X1BFUl9CVkVDICAgICAoc2l6ZW9mKHN0cnVjdCBiaW9fdmVjKSAvDQo+IHNpemVvZihzdHJ1Y3Qg
cGFnZSAqKSkNCj4gKyNkZWZpbmUgQklPX0NIVU5LX1NJWkUoMjU2VSA8PCAxMCkNCj4gIA0KPiAg
LyoqDQo+ICAgKiBfX2Jpb19pb3ZfaXRlcl9nZXRfcGFnZXMgLSBwaW4gdXNlciBvciBrZXJuZWwg
cGFnZXMgYW5kIGFkZCB0aGVtDQo+IHRvIGEgYmlvDQo+IEBAIC0xMjY2LDYgKzEyNjcsMzEgQEAg
c3RhdGljIGludCBfX2Jpb19pb3ZfaXRlcl9nZXRfcGFnZXMoc3RydWN0IGJpbw0KPiAqYmlvLCBz
dHJ1Y3QgaW92X2l0ZXIgKml0ZXIpDQo+ICBzaXplIC09IHRyaW07DQo+ICB9DQo+ICANCj4gKy8q
DQo+ICsgKiBUcnkgdG8gbWFrZSBiaW8gYWxpZ25lZCB3aXRoIDEyOEtCIGlmIGl0IGlzbid0IHRo
ZSBsYXN0IG9uZSwgc28NCj4gKyAqIHdlIGNhbiBhdm9pZCBzbWFsbCBiaW8gaW4gY2FzZSBvZiBi
aWcgY2h1bmsgc2VxdWVudGlhbCBJTyBiZWNhdXNlDQo+ICsgKiBvZiBiaW8gc3BsaXQgYW5kIG11
bHRpcGFnZSBidmVjLg0KPiArICoNCj4gKyAqIElmIG5vdGhpbmcgaXMgYWRkZWQgdG8gdGhpcyBi
aW8sIHNpbXBseSBhbGxvdyB1bmFsaWduZWQgc2luY2Ugd2UNCj4gKyAqIGhhdmUgY2hhbmNlIHRv
IGFkZCBtb3JlIGJ5dGVzDQo+ICsgKi8NCj4gK2lmIChpb3ZfaXRlcl9jb3VudChpdGVyKSAmJiBi
aW8tPmJpX2l0ZXIuYmlfc2l6ZSkgew0KPiArdW5zaWduZWQgaW50IGFsaWduZWRfc2l6ZSA9IChi
aW8tPmJpX2l0ZXIuYmlfc2l6ZSArIHNpemUpICYNCj4gK34oQklPX0NIVU5LX1NJWkUgLSAxKTsN
Cj4gKw0KPiAraWYgKGFsaWduZWRfc2l6ZSA8PSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZSkgew0KPiAr
Lyogc3RvcCB0byBhZGQgcGFnZSBpZiB0aGlzIGJpbyBjYW4ndCBrZWVwIGFsaWduZWQgKi8NCj4g
K2lmICghKGJpby0+YmlfaXRlci5iaV9zaXplICYgKEJJT19DSFVOS19TSVpFIC0gMSkpKSB7DQo+
ICtyZXQgPSBsZWZ0ID0gc2l6ZTsNCj4gK2dvdG8gcmV2ZXJ0Ow0KPiArfQ0KPiArfSBlbHNlIHsN
Cj4gK2FsaWduZWRfc2l6ZSAtPSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZTsNCj4gK2lvdl9pdGVyX3Jl
dmVydChpdGVyLCBzaXplIC0gYWxpZ25lZF9zaXplKTsNCj4gK3NpemUgPSBhbGlnbmVkX3NpemU7
DQo+ICt9DQo+ICt9DQo+ICsNCj4gIGlmICh1bmxpa2VseSghc2l6ZSkpIHsNCj4gIHJldCA9IC1F
RkFVTFQ7DQo+ICBnb3RvIG91dDsNCj4gQEAgLTEyODUsNyArMTMxMSw3IEBAIHN0YXRpYyBpbnQg
X19iaW9faW92X2l0ZXJfZ2V0X3BhZ2VzKHN0cnVjdCBiaW8NCj4gKmJpbywgc3RydWN0IGlvdl9p
dGVyICppdGVyKQ0KPiAgDQo+ICBvZmZzZXQgPSAwOw0KPiAgfQ0KPiAtDQo+ICtyZXZlcnQ6DQo+
ICBpb3ZfaXRlcl9yZXZlcnQoaXRlciwgbGVmdCk7DQo+ICBvdXQ6DQo+ICB3aGlsZSAoaSA8IG5y
X3BhZ2VzKQ0KPiAtLSANCj4gMi40MS4wDQo+IA0KPiANCj4gDQo+IFRoYW5rcywgDQo+IE1pbmcN
Cj4gDQoNClRoZSBsYXRlc3QgcGF0Y2ggeW91IHByb3ZpZGVkIHdpdGggMjU2IGFsaWdubWVudCBk
b2VzIGhlbHAgYWxsZXZpYXRlDQp0aGUgc2V2ZXJpdHkgb2YgZnJhZ21lbnRhdGlvbi4gSG93ZXZl
ciwgdGhlIGFjdHVhbCBhbGlnbmVkIHNpemUgbWF5DQp2YXJ5IGRlcGVuZGluZyBvbiB0aGUgZGV2
aWNlLiBVc2luZyBhIGZpeGVkIGFuZCB1bml2ZXJzYWwgc2l6ZSBvZiAxMjgNCm9yIDI1NktCIG9u
bHkgcHJvdmlkZXMgcGFydGlhbCByZWxpZWYgZnJvbSBmcmFnbWVudGF0aW9uLg0KDQpJIHBlcmZv
cm1lZCBhIGRkIGRpcmVjdCBJL08gcmVhZCBvZiA2NE1CIHdpdGggeW91ciBwYXRjaCwgYW5kIGFs
dGhvdWdoDQptb3N0IG9mIHRoZSBiaW9zIHdlcmUgYWxpZ25lZCwgdGhlcmUgd2VyZSBzdGlsbCBj
YXNlcyBvZiBtaXNzYWxpZ25tZW50DQp0byB0aGUgZGV2aWNlIGxpbWl0IChlLmcuLCA1MTJNQiBm
b3IgbXkgZGV2aWNlKSwgYXMgc2hvd24gYmVsb3c6DQoNCmRkIFswMDBdIC4uLi4uIDM5Mi45NzY4
MzA6IGJsb2NrX2Jpb19xdWV1ZTogMjU0LDUyIFIgMjk5Nzc2MCArIDM1ODQNCmRkIFswMDBdIC4u
Li4uIDM5Mi45Nzk5NDA6IGJsb2NrX2Jpb19xdWV1ZTogMjU0LDUyIFIgMzAwMTM0NCArIDM1ODQN
CmRkIFswMDBdIC4uLi4uIDM5Mi45ODMyMzU6IGJsb2NrX2Jpb19xdWV1ZTogMjU0LDUyIFIgMzAw
NDkyOCArIDM1ODQNCmRkIFswMDBdIC4uLi4uIDM5Mi45ODY0Njg6IGJsb2NrX2Jpb19xdWV1ZTog
MjU0LDUyIFIgMzAwODUxMiArIDM1ODQNCg0KQ29tcGFyaW5nIHRoZSByZXN1bHRzIG9mIHRoZSBB
bnR1dHUgU2VxdWVudGlhbCB0ZXN0IHRvIHRoZSBwcmV2aW91cw0KZGF0YSwgaXQgaXMgaW5kZWVk
IGFuIGltcHJvdmVtZW50LCBidXQgc3RpbGwgYSBzbGlnaHQgZGlmZmVyZW5jZSB3aXRoDQpsaW1p
dGluZyB0aGUgYmlvIHNpemUgdG8gbWF4X3NlY3RvcnM6DQoNClNlcXVlbnRpYWwgUmVhZCAoYXZl
cmFnZSBvZiA1IHJvdW5kcyk6DQpPcmlnaW5hbDogMzAzMy43IE1CL3NlYw0KTGltaXRlZCB0byBt
YXhfc2VjdG9yczogMzUyMC45IE1CL3NlYw0KQWxpZ25lZCAyNTZLQjogMzQ3MS41IE1CL3NlYw0K
DQpTZXF1ZW50aWFsIFdyaXRlIChhdmVyYWdlIG9mIDUgcm91bmRzKToNCk9yaWdpbmFsOiAyMjI1
LjQgTUIvc2VjDQpMaW1pdGVkIHRvIG1heF9zZWN0b3JzOiAyODAwLjMgTUIvc2VjDQpBbGlnbmVk
IDI1NktCOiAyNjE4LjEgTUIvc2VjDQoNCldoYXQgaWYgd2UgbGltaXQgdGhlIGJpbyBzaXplIG9u
bHkgZm9yIHRob3NlIHdobyBoYXZlIHNldCB0aGUNCm1heF9zZWN0b3JzPw0KDQpCZXN0LA0KRWQN
Cg==
