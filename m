Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837187BC5B7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbjJGHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjJGHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:46:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD7BF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:45:55 -0700 (PDT)
X-UUID: 882976b664e511ee8051498923ad61e6-20231007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WuDu8ka8pggsVJIN4b2Nen96b5r/ildUv4PcVbR3Dsg=;
        b=NpTirtm4ANcJbgKkHY0fJxTS/7GEkE2E8TWdFwz0TKJZWeddPWUpmFw4MWS/Xjkd/j3OL/5gOrxyaa9QDE6ibvMTnwo1lB9IW5NTjawRl2s6ZBKLkMvmOy1mHwrMLT0RKbvikYkyVz5skfxYbt1kVFKwDpp4XKCZfnvHEplSymA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:636a19c4-e5f4-4ac3-86c5-a196bd03376b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:f0bac814-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 882976b664e511ee8051498923ad61e6-20231007
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 629439856; Sat, 07 Oct 2023 15:45:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 7 Oct 2023 15:45:47 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 7 Oct 2023 15:45:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgHM2twXJ+3vYA71nB+AfZD28UuFks4e6D4ENQk2angfdaLpgv+N5Jmjwax5kK/+N7HMVLCg1aITCX5kfY7lLC8ej+xSgMBlYLCxOvsGnsfHLtCQLlXUw3MnzqNWqmeH5G/9YTnLl6WxK+pmWPqo0Fg/lvksnFIq+xbXdoZj/+S0v25uhHQa0+jD83xi83khAUGVKOCeoppoEsp/yikMEL6e7jAgupO35FJU3hqrE5MW7kq0rFs8WZudq/5q1/XbXelJzEJxOV8mtZuzWl+TUkpcjbbSs5mL6asBfgYXFgLvPavVf31whaAeTyuRjDZJmthrFPQrqxZl0vsb9PGIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuDu8ka8pggsVJIN4b2Nen96b5r/ildUv4PcVbR3Dsg=;
 b=UnTyge+mWMme5ouH/w5bKKFsaBFiukj2kQmagvS0EGr2ZWc8SOgYebBkLXTGkjCZ6yqbYCCiqmRKgvPf3AHrp/9weGlGKhaWD+sP6IGi5oJoHsutfWwDkkurcmyzu2hUdeLu2QT3G+j50X5me4/gwPwo0au8c83OI7rqikoSLcuItq7FW1/ZbxPtP5EBiXAunMAKs+PYLfW39/oIfKafyxlfeb7Eppk5VYW/E/y0dhYzVrPjt6fL1+pA1vzOXbbH4YurQj/GrCTQLKc5dcwr5EBsP/1LrIMLrPdG0yMXBtFR6gEfYEIGEedH3AsX501RiKKwtC5jmwEAQhQnGhlrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuDu8ka8pggsVJIN4b2Nen96b5r/ildUv4PcVbR3Dsg=;
 b=DaaF32aTO70Kcm2NMOdiHgQOd2YKYWP0/DBMDV/YrIKyrXrMJR/mfapqvpSQP2EKXt9IbZgEC3C56PZQpjivAXX8LUdYq6IRlt6VCeWaJskPWQLabjZ9crNz6QNmSG4WosVSsxDYBpGuQ20HLESTbpppHn/ClraJJHTcNWNlE90=
Received: from KL1PR03MB7648.apcprd03.prod.outlook.com (2603:1096:820:e1::7)
 by SI2PR03MB6566.apcprd03.prod.outlook.com (2603:1096:4:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Sat, 7 Oct
 2023 07:45:45 +0000
Received: from KL1PR03MB7648.apcprd03.prod.outlook.com
 ([fe80::c243:5f15:7d59:d6eb]) by KL1PR03MB7648.apcprd03.prod.outlook.com
 ([fe80::c243:5f15:7d59:d6eb%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 07:45:45 +0000
From:   =?utf-8?B?TWFyay1QSyBUc2FpICjolKHmspvliZsp?= 
        <Mark-PK.Tsai@mediatek.com>
To:     "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] zsmalloc: use copy_page for full page copy
Thread-Topic: [PATCH] zsmalloc: use copy_page for full page copy
Thread-Index: AQHZ+Bq/Dwb+aPmQKEKpfJWKtIVmWbA8m5EAgAFYxwA=
Date:   Sat, 7 Oct 2023 07:45:45 +0000
Message-ID: <dd0fad41f5289e51efb342c1355551de782379ea.camel@mediatek.com>
References: <20231006060245.7411-1-mark-pk.tsai@mediatek.com>
         <20231006111144.GB17924@google.com>
In-Reply-To: <20231006111144.GB17924@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7648:EE_|SI2PR03MB6566:EE_
x-ms-office365-filtering-correlation-id: 4fc2d145-c979-4ec1-da72-08dbc7096a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: poB2qAPGAXAp9hjdGL/9Za7UcyPmS40vr0NIZdevLv3lg1fDlaenNSWQYPln081m5yTmBpcu/RcBPgtA1D0VrHsxU6W1WSd3c/1hB1O4U+NAulPA3ipNfJEOlCnDpaLFUYD1rQYFafz+mYGx/ZMxJ4+5hzMOCZp4eoBpipfJMYwHOglZ7/kn96JZet0JC7a34+a2chj0xcASmpr39xt/OmCaxyeemhm7+3dEEYs25nGYNSo/DpxUlFhgxlWuUvC7mKtb8G55e63Asv46w53CpI+EAgcLbyPuBoaf6Si74097AoZniIO6Z0ixvL7P7cuWQNOjmaIxqTEIzJpDVjx/oBQdsuDYi1qIDTcfYPsedibgp6ebZgFiqU3GCn2sD44BFD9yRQUwPwEGZnpaXMWzCF1GTKsat3nvRuTvyyq5i982opy1sfSMWj+6Ro192E2JinTuTLZGnOoW2NRFDzk4Rg0IslCrDIQZAYMLFbCQOiXAS0uwSQmgZl72nmkxMbGob6rA5RHi5R1Ix3+C8vjxMKXaysZjT6okTPj3mVtV1QP5bhbdECjL8Jrinp+4v1fE3fZ5o61YmJpmBGhQp44+7gy1rrjNzs91nZP5HfVFoM8HSxV89+rCf5s7urRikEFohUQl2Izb/Zlli/Gl6q/icM+McaKuE3NrLnJMvl1LwVQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7648.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(83380400001)(122000001)(66556008)(38070700005)(38100700002)(6916009)(316002)(66446008)(66476007)(76116006)(66946007)(91956017)(54906003)(85182001)(71200400001)(36756003)(2616005)(6506007)(6512007)(64756008)(6486002)(966005)(478600001)(26005)(86362001)(2906002)(8676002)(8936002)(5660300002)(4326008)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzI5eHVUaGV0ZlJMdEJaMWpFOXZsYUVHS2IzMWoyMlBuUHdiMmdWTmR2dVBk?=
 =?utf-8?B?YkRsa3g0clpkMVF0ZCs2aFA0aVJPYSt4dFJ4blhlRkE3ZW1VWmhOQlFoOFIz?=
 =?utf-8?B?UHI5b3ptWkw3U29aQzB4MHlpS2EvclJWbXdWSDhXM3MvaGVQVzVMd2pzbFI2?=
 =?utf-8?B?T2VDb2ErS2o3NUxaZGhScTdOWllJSFVySFVqd1ZOQUVoK0JsNDdsbHVscmRP?=
 =?utf-8?B?YmRoWldUMW9ZS1oxaGdndHVpMGl0bElNbWNKSWgxaHM1Y016YzFYbFNvYW5a?=
 =?utf-8?B?UVFyU0pzcU1VcDIrek94aVJmMVp0b3o5R1RhajYvK0ZyQWt0N2NOR29HTUlu?=
 =?utf-8?B?TEovWElJWXZQTHFFcG9oUm5QUmViZUxvZmhPZDdiRE5McGFzMEpGSW84SnY3?=
 =?utf-8?B?eitTcDV2YTNDd2x6V29kRXJReVA1TDRJU1V1ZFVUK3BVUE9LK3gvRFVsL2Ev?=
 =?utf-8?B?ZXVBdVloRlh0bVNzTjRKdTg0Sk51cGdaa1Y0d0tSTjhJdDhCczNVbCtvM2Qw?=
 =?utf-8?B?MEJKa1FUQmtBMDBPT3BhL3hqeSt0U3hsM0s4ZnJoSnBvZ2dBSlhYMDRLM3JO?=
 =?utf-8?B?b1QxOVlPNFIwcFc1cDd5T2tTQ2ZtWTF2K2pWY2pIcTY2S3FCTzNybU5qaG1H?=
 =?utf-8?B?ZWlFODJwSlhsZll4VWNneUVtTTBjenVMaUJGTndmTHREcVZrdE1mZVNhNm9U?=
 =?utf-8?B?bXJvTXZQdjQ0VHpkYlIrZkV1UFNUMFY5QTJLNXZrdEt1Y2FndDlZOTlQRWlz?=
 =?utf-8?B?aUhiNWMwcFFva3lLeWxobjlxd1NuVS9LWklYNGpLNStCRDVFV25hakJvR0lN?=
 =?utf-8?B?VE0wV0xYbCsvMlE1Nm5GaTRsNFZOMjQvQUlJeitPM0ordm1VRUJuRmd6MWl6?=
 =?utf-8?B?TWRlSTV1a3RkTWN2V3M4b083QWhndXRNMGt6M3JoL0ZxTmVHc0hFZDdkQkla?=
 =?utf-8?B?V3R3VGpEcWozUzI2OEpHWHM4WGdZN0VQWmVIejJ5bXpYNVcrN08zZndBcWZF?=
 =?utf-8?B?Mjl1WTJidHZpS2N1U1BPS1BBMjNqNVljbkRxaGh6UXFSQS9nYVdqeVNmeTFh?=
 =?utf-8?B?cktTVG5tTEErNEsyc0hmNzdKQ3pqY3pzRHYwTTBNNytoR1hEeWJUK2RjOHY1?=
 =?utf-8?B?c3dSYTh4Yi80WmY5Um9sUVZPR0ZyY3lvRDJUYXFCNW13dUFrWXNzckZVQWd3?=
 =?utf-8?B?OWVYVEgwQ0UreWMwUUFCS0pXYmRxZStNMXdXK2ZYcGgrRzRJK0dpdTlWZnFU?=
 =?utf-8?B?bmUxeTM3dlFOWHdFNklVNVcyS3NCTW5mVW96TkFDTGNoYmtIbnRxc3pUVnBz?=
 =?utf-8?B?TjU5M0FLTzdlZU1MNXFQWGRXL1RtNmpoeWxjcENubGtoelZDakh1VEtsSFB5?=
 =?utf-8?B?YVFpVElnTkZYRGFKeEphQUdDYjJ2U3g0MDBkVHNST2lzNHhPUCsrZEtnWGVm?=
 =?utf-8?B?MzdHZmZHRnhoR2tFVnFQWW51TEpFeVlVMzg4dXZyOWpNVDdyZXJtakhaNUxv?=
 =?utf-8?B?M3VGWHdBQ3RZZE5VNEVONHlrSzlPc241RXNaUXFjSjMwNWlIUFNlYnc3S3F5?=
 =?utf-8?B?QnNkVE9UUU9NSjVIZWtxQlBFSFJwN21NLzU1dTNqSGRaOGpabnFNdUFOVTdt?=
 =?utf-8?B?NkZydWpxNUhzWDFjZDJGWGl4cHVMVGRHU0xWNG0yN1ZVS1lSRy8xS3FzeTJE?=
 =?utf-8?B?ejljcjhJYjdib2hjNnY4MWRyWG5Qb1AvQnJ4WVdGNzlWYWNLbUtKbW1KOGJJ?=
 =?utf-8?B?RHZ5QTVZVXZMaWx0Tkg2aVBzaFBZbTMxNW44MmRMMnhpSk80a2o0VmZuVXhY?=
 =?utf-8?B?OXBEZTJaSHAzbGR2TGk4c0o3akVXdUo4U3cyL1NDa2FVRTJKYTM5QXlZbURB?=
 =?utf-8?B?WDhDM1lBTnBQSG1TT0VlVzFPeGQ4VW9lekVVUWlCbXR1ZHVwTlBmMDIyekE0?=
 =?utf-8?B?QkppRnBXVG5rb3Y2cnhoMUxFRXRxL2J6QW53aEZHUmtXRVZQTEYzUHZvVGFz?=
 =?utf-8?B?R3hXQjBLSDcyaWt2NmhWUXl6OE5XN2NDNndJVTlwK2lsZXNRQVo4c2lYSzNI?=
 =?utf-8?B?cW5lZTFOQ1pXcFUyV212YkhTK2hBZGJDdmwvZU5KR3A4UU4zZzJreUxqSlpv?=
 =?utf-8?B?elJhaVJsRC9ieEdudVYwS2YwZDBONHgzUFJENEtLUjJsSlIyTkwzSHNvK1cv?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A8729ACB9274945B9E1A34ECACB0C81@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7648.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc2d145-c979-4ec1-da72-08dbc7096a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 07:45:45.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MC9LmUEaUmShQ953d0+7JGPDdMFZuuXrZ7ueJRdTrAKHUaRbhzb9M0hcCWL2TYqWLJtjAi3cXddUFL1athKTR6IIOV7Y5yL6fYD8oFRtLIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6566
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDIwOjExICswOTAwLCBTZXJnZXkgU2Vub3poYXRza3kgd3Jv
dGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiAgDQo+IE9uICgyMy8xMC8wNiAxNDowMiksIE1hcmstUEsgVHNh
aSB3cm90ZToNCj4gPiBTb21lIGFyY2hpdGVjdHVyZXMgaGF2ZSBpbXBsZW1lbnRlZCBvcHRpbWl6
ZWQNCj4gPiBjb3B5X3BhZ2UgZm9yIGZ1bGwgcGFnZSBjb3B5aW5nLCBzdWNoIGFzIGFybS4NCj4g
PiANCj4gPiBPbiBteSBhcm0gcGxhdGZvcm0sIHVzZSB0aGUgY29weV9wYWdlIGhlbHBlcg0KPiA+
IGZvciBzaW5nbGUgcGFnZSBjb3B5aW5nIGlzIGFib3V0IDEwIHBlcmNlbnQgZmFzdGVyDQo+ID4g
dGhhbiBtZW1jcHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyay1QSyBUc2FpIDxtYXJr
LXBrLnRzYWlAbWVkaWF0ZWsuY29tPg0KPiANCj4gVElMDQo+IA0KPiBJJ3ZlIG5ldmVyIGhlYXJk
IG9mIGFybSdzIGNvcHlfcGFnZSgpIGJlZm9yZS4gSXMgaXQgcmVhbGx5IG11Y2gNCj4gZmFzdGVy
IHRoYW4gbWVtY3B5KCk/DQoNCkJhc2VkIG9uIG15IGVhcmxpZXIgdGVzdHMsIGl0IHNlZW1zIGJl
dHRlciB0aGFuIG1lbWNweQ0KZm9yIGZ1bGwgcGFnZSBjb3B5aW5nLg0KVGhlIHRlc3QgY29kZSBp
cyBqdXN0IG1lYXN1cmVzIHRoZSBjb3B5aW5nIHRpbWUgd2l0aA0KaXJxIGRpc2FibGVkLg0KDQo+
IA0KPiBSZXZpZXdlZC1ieTogU2VyZ2V5IFNlbm96aGF0c2t5IDxzZW5vemhhdHNreUBjaHJvbWl1
bS5vcmc+DQo+IA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0venNtYWxsb2MuYyBiL21tL3pzbWFs
bG9jLmMNCj4gPiBpbmRleCBjNzQzY2U3YTVmNDkuLmIxYzBkYWQ3ZjRjZiAxMDA2NDQNCj4gPiAt
LS0gYS9tbS96c21hbGxvYy5jDQo+ID4gKysrIGIvbW0venNtYWxsb2MuYw0KPiA+IEBAIC0xODM5
LDcgKzE4MzksNyBAQCBzdGF0aWMgaW50IHpzX3BhZ2VfbWlncmF0ZShzdHJ1Y3QgcGFnZQ0KPiAq
bmV3cGFnZSwgc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ID4gICAqIEhlcmUsIGFueSB1c2VyIGNhbm5v
dCBhY2Nlc3MgYWxsIG9iamVjdHMgaW4gdGhlIHpzcGFnZSBzbyBsZXQncw0KPiBtb3ZlLg0KPiA+
ICAgKi8NCj4gPiAgZF9hZGRyID0ga21hcF9hdG9taWMobmV3cGFnZSk7DQo+ID4gLW1lbWNweShk
X2FkZHIsIHNfYWRkciwgUEFHRV9TSVpFKTsNCj4gPiArY29weV9wYWdlKGRfYWRkciwgc19hZGRy
KTsNCj4gDQo+IEkgZ3Vlc3MgeW91IGNhbiBhbHNvIGxvb2sgaW50byBwYXRjaGluZyB6cmFtX2Ry
di5jLCB3aGljaCBzZWVtIHRvDQo+IGhhdmUNCj4gYXQgbGVhc3Qgb25lIFBBR0VfU0laRSBtZW1j
cHkoKS4NCg0KVGhhbmsuIEkndmUganVzdCBwb3N0IGFub3RoZXIgcGF0Y2ggZm9yIHpyYW1fZHJ2
LmMgYXMgYmVsb3cgbGluay4NCg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMx
MDA3MDcwNTU0Ljg2NTctMS1tYXJrLXBrLnRzYWlAbWVkaWF0ZWsuY29tLw0K
