Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67ED7CD218
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjJRCDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJRCC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:02:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46342C6;
        Tue, 17 Oct 2023 19:02:52 -0700 (PDT)
X-UUID: 6a5fa4d46d5a11ee8051498923ad61e6-20231018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4HJpeMDyDrkf6WwGcCL7T9cnC7FhKrBv9gfRAVssPSs=;
        b=hoJQ02U5puiN3Pwer7cg5JJW7xIEkZ7LiqBJpVyDL4NCXDmxDJL0wZuf0TUBpn0pKMvlS8n7eNe2cQz8vZGWZqKQHg3Ub2cdECcFasPe2J1h5GKxjznLt6x6E043s6rsVc9Zn+k0eP0+SoQwuCnmfaKHnb8U+LNHlAKNy5IH8h0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:148a8fec-7f7e-452e-bd8a-da3be7ff83c1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:6c81eaf0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6a5fa4d46d5a11ee8051498923ad61e6-20231018
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 662195706; Wed, 18 Oct 2023 10:02:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 18 Oct 2023 10:02:38 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 18 Oct 2023 10:02:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNaN9C1MmNr58cNojeWEItufzcCdu4sWcu+dE6wbXFMSKt14L2CMheXIoFgYozaQagJ/xAusK/3M4CUEEN4f1SvLQGPoMOkHjzu7bGFMnsweB5XUXYlRQipDZubCjsr80ul5Xio7i0g40g5GOTnN6JZBdHB5ycaKWIC0zjjUpRwpwDVDA6ctZQCJwV7j183SZFDd5nVoV7mMN9mY4ExN4b2ML38jbHf0EnKvcN8Iu8CJY1oHaJg/4QZ9jbdbqGNyfO002id0enoWcDo0t/ktmwEi+VnHUGqoRS2rMEcZeGk0rTlL0cCU9MHqip8CtxgzaP/Ol328WsFBIhPpzRZ1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HJpeMDyDrkf6WwGcCL7T9cnC7FhKrBv9gfRAVssPSs=;
 b=OxI0VZf9NNL/NYAmpDLZI+VN6+35UIFYtbM71+o/TTCVuaSoE5eBX1lPphjaVVf5HZLpRqPoV0x/cMKzFfOieSbkrVCbFg8gO0AjHMcbm9/165v687odJyeuSy/NEy2kcsfanmTM6W02245BNDR0iSrf39AEK3iOdqwWbc+lzIp4Feub1SAqih9paaQehBNjFiQzd+U0fc6M++0ygal82dg89AECDlKsmf1hSaG7NGm0PI/lsItpYY+esJ7YKT8oE45VxkA3zoDfQV4bBBFPMgN0WCLdGSMm0ARL8swqfUJsMbyzlINE5EO/9KXi76SnaJOCbngJwhvfxzW/Jhap8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HJpeMDyDrkf6WwGcCL7T9cnC7FhKrBv9gfRAVssPSs=;
 b=ALdI6BdGo0x8TMQBCtswvtF8P7GHMQsfFsxXqf3uSrnUmLS0rKIa3HRuqOFTRATcwbsAfDDQw1FiW52bFRwEzalrXmUz7ImwJ6hVCfeNvkmdtwhPBJgppISXtmcDdcoqxNv1/CBUm+mprDzVZXVk/TqqOCNxeScWBshcmzHpM+c=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6056.apcprd03.prod.outlook.com (2603:1096:4:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 02:02:35 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 02:02:35 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v8 22/23] drm/mediatek: Power on devices in OVL adaptor
 when atomic enable
Thread-Topic: [PATCH v8 22/23] drm/mediatek: Power on devices in OVL adaptor
 when atomic enable
Thread-Index: AQHaAB1HhjBBScvygEyk2ZfOYTkEOrBOzhIA
Date:   Wed, 18 Oct 2023 02:02:35 +0000
Message-ID: <c8e94835fcba4692d34eb002ef4c14f554c50b0b.camel@mediatek.com>
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
         <20231016104010.3270-23-shawn.sung@mediatek.com>
In-Reply-To: <20231016104010.3270-23-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6056:EE_
x-ms-office365-filtering-correlation-id: f5c48ea3-e31c-4931-9e3d-08dbcf7e4c66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ex/WnK78ecgaakYGjOf/QACnzQNoHiYd/Jtgt4IXbKsfH8TyCHXfOYpn8UQ3Ie4sYg9OXwb90komkyMvcarJc12jSctRVWTyPvqI0Sxsw5nVj84cw4sU31nxBe8++Rrm9HlQbPnIqOetK1ZOHAxsbyWZ7oZUOq//aeFgYvyMkrlR/oitJXhGoY8ZtgTN+N/xKgi8xm4brkiIQH+MNVz+XmFWi32iMTP+tQIhYsONYn2NaUPUT92kzIRH8dh0imK5bDafeuGkXKq/HCGDtCHPg9H7SpUOJmOwXSL40fYuGwcoUM3zz6mHGBInhQrPPEJfRtMUOgHr9IzKDc6Rby8W2fSu+Zb6CATjcH6aIUjcn6lOU/KkVAmChxBcb2Zh13BGap4n29NWJPt470KDDIEkj1aJyyECxx2sslzHOQmkP8InwGJvLhHVwJ6S11HzXWMhZAS012MK1aDjfIagAx6wTpx6kXgr3uVlzR9LyOLN7SMgQMNhIAn+bXe/64pxdrNPQvLrGTocYskKuxyKmY7ESyaOElYTJgW5Cvr/zFPaBC2y7URCF7BJzQUcUgDdmkn8uZmRyYPtX53Uz9O22lEI6YaF+4zr34Q8CWvl6AqUNMAVvNmp9rvgsR71oaeA0ggk0RZrrs9FPqblxIZPCVibgHnOtt6yw9VefYHmcpBV4Jc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(71200400001)(26005)(6506007)(2616005)(508600001)(6486002)(83380400001)(5660300002)(7416002)(41300700001)(4326008)(4001150100001)(8936002)(8676002)(2906002)(30864003)(76116006)(316002)(110136005)(66946007)(66476007)(64756008)(66446008)(66556008)(54906003)(38070700005)(122000001)(38100700002)(86362001)(36756003)(6512007)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWNRMk03UnR5NklKZ2UxWW5nVUU5SUUwcHVST2tzak5kZ0pON1ltOVBoTWNs?=
 =?utf-8?B?aENnUGRFVUhwMVpFRVNuS3NnTmZiNmI5TVIvVnk5TisrU3Bsc05CZEQyWXl2?=
 =?utf-8?B?bFRBb1lMTDY3K1psaVcvQW1mc1pFYWRNenM5b1ZDaWVVSkg5T3VHcDJ3ZDNO?=
 =?utf-8?B?cC9ra0k5WGdmeFlJSTU4cDBrQ1J1MFFvbW1aUExiSUZuVjI3c0VGc2FVOWtk?=
 =?utf-8?B?WFUrVTFMVGw0WmhES24xM2lXOFp4M1h5d2RHS3hqVUxYYk9wYW1yamZDbXR5?=
 =?utf-8?B?V2hYM1FldDhLb3NpWmplTHYyUkIxUGlKTkx0N29LMzVVa2RCTS9tTlYya2tq?=
 =?utf-8?B?a3JaOGwvVERjT0dyRWxTM0JYSS9PY3VQbkxOOVZwWExjc1ZOY1VKd1kwOVNi?=
 =?utf-8?B?SEJDQ2FhTHRnMlNpczVHNHE4L1BlNGl4d3BVVDZ2SFRmby92azNTcklXVmNx?=
 =?utf-8?B?YkwrZ05tekZ0ZExEbEcreEtMQ1VYTWptazVtVTdTeTdiYnFXYTY3WSs2NzRT?=
 =?utf-8?B?b3RRS1E2a2xnU3NuMHlYUC96TGFFOVhxZ01QQ3EwZkRKVW9WUEhGaHpqT2Yv?=
 =?utf-8?B?aDRGVWJ2WHZib3NUZlRmTERjd3JKbkZhMmwrY3RPai9DSDUxQUFiOHhhWEV3?=
 =?utf-8?B?UEhkY01WN1BJNkF4QWJDYVI3NzN4SXY3YlN2bm1KQVFIUVNFTHE4R096bnlx?=
 =?utf-8?B?V245bWxoQUlHYXJ4MVJYREtjZUs3OU1KTnBrOFE5NkRYS0dKZ1RZSWw5ZXNK?=
 =?utf-8?B?VldrRzI0a1lCaHB2UElZZitjTHYzZGRMQVM2MVpZTCtzU3hUOTJEd0xLSHZO?=
 =?utf-8?B?WXhXWTl6WmUvL1hLeTRac0tqU2l5TFZsSlQ0dVRYNkdBVWN1SmtrZkI5MCtV?=
 =?utf-8?B?YmRHVUZlSlpWajY5SmRVK01jU1grM1JwRnVJNzRKbUtIaWZuaUFjMmJxZGZi?=
 =?utf-8?B?cUlTRlRBcDlWV3dNS1BsbS9zbGNQc1MrdmY0ZmxmWFBLUjV5NGVmUHRxVFVV?=
 =?utf-8?B?OEVSdjRhOU02WlNPMC9Zblk3UFhMWEFzQUZnUDhOaWlKK29GVVRxdGEvQ1Zr?=
 =?utf-8?B?RDQyWXVhaEpzRDBDay9kdm5LVTJlTmE4SlBRRU9yQkplaVdNOUpXcFh1czhq?=
 =?utf-8?B?eXVUOGRwNWVybU8zTTRyd0dGaVZ3U3l5S2NZWnVpaGM4aTZxeGV5dng2UjIv?=
 =?utf-8?B?ZEhHSXhYVnhtOGw5QjBVZnBzVDVnSktQbGhBQnlCS0Y1cUVrV2xOb1poeVd4?=
 =?utf-8?B?VGtZTnpTcmxMUTM2L05ydmJhOUlvVFRBcUg5cUwrNVcrRUorcWdaelk2OENX?=
 =?utf-8?B?RWIySU9WYzRDRlFBY0lUdVpUcVlnU3BGVjdFaGgrSDNQTTNSZ3E1K1FBZTZG?=
 =?utf-8?B?aUxKV0NWN3dLZXdoellROCtGOUh0Wi9DZnBZamtreEdiRWJKSXhRVjhYQmNR?=
 =?utf-8?B?QlBkT2ZFNWxsbEJoTE44ZlFSNHFyZ21US1NrdE5pTW1JZjFKM01XWUJuQjl0?=
 =?utf-8?B?TE5MSG1od1FpWGoxbm1xejI2NFBWa1JTR2cyZGRuTGFVMmxoZDZUSXFBNjhZ?=
 =?utf-8?B?cUlJYUhBbEllZFhvcmZFUFAxWWJHbWx1STNaVCtycTRISkg3blJ3ODc1SVVB?=
 =?utf-8?B?c1NPcUoxaHplbS9qaHI1ejVvSE4xemJJNDNtS2ZxakR2NDExd2ZUR3d2NVov?=
 =?utf-8?B?VUtaTlpSOEoxVk1pdEZxMnpJZVpkRnJtZi95VjRwZVczZkJNWm4yS0p4ZnI3?=
 =?utf-8?B?Rkt0a3VyNjBhbGd4RE43UDRHekFGTVJHZGZCMVVLQkRTVUtMbDUxWEM1TXJn?=
 =?utf-8?B?cVJabTlWYk1ncERJZWxHbU9GNzN3N2FnQy9oWVVIdGNtR2h2aGpGSEkrR3My?=
 =?utf-8?B?Z1VkcnhXQVkvamZHUEF4WGFQbVQwcWhuZDErQi9sY01ubThqY1BKUGpkMDFl?=
 =?utf-8?B?KzlKRm1sZkRuWm00d2h2aG5RcDlHbU9Xc0pXbFhZNGJoMW9sOXNlUTExNkFJ?=
 =?utf-8?B?SnRVd2tLUWR0WGpzNHBOMlJpY0VPdE9CS2FMSjRxNWVCYnY1dWtDWWFiWDRQ?=
 =?utf-8?B?c0MrYS8wRm1QVFp6ZXhSeHZ6amw4ZjF6b1NQRzhKbnJlclRSZXhkU2lsNk1M?=
 =?utf-8?Q?DtEcIznEfmln+3Fdi08NvREtQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66243EA7F2EF59439A098EADFD2D6633@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c48ea3-e31c-4931-9e3d-08dbcf7e4c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 02:02:35.7515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wu2NruoyeCrDsgSSMJfj5s7p7m3SJzjm9i1gs2XhXoU294gGf8MwLTI06CR9rI14vKZAT+O5suJIOI4HVsCO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6056
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMTAtMTYgYXQgMTg6NDAgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IERpZmZlcmVudCBmcm9tIE9WTCwgT1ZMIGFkYXB0b3Ig
aXMgYSBwc2V1ZG8gZGV2aWNlIHNvIHdlIGRpZG4ndA0KPiBkZWZpbmUgaXQgaW4gdGhlIGRldmlj
ZSB0cmVlLCBjb25zZXF1ZW50bHksDQo+IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKQ0KPiBj
YWxsZWQgYnkgLmF0b21pY19lbmFibGUoKSBwb3dlcnMgb24gbm8gZGV2aWNlIGluIE9WTCBhZGFw
dG9yIGFuZA0KPiBsZWFkcyB0byBwb3dlciBvdXRhZ2UgaW4gdGhlIGNvcnJlc3BvbmRpbmcgSU9N
TVUuDQo+IA0KPiBUbyByZXNvbHZlIHRoZSBpc3N1ZSwgd2UgaW1wbGVtZW50IGEgZnVuY3Rpb24g
dG8gcG93ZXIgb24gdGhlIFJETUFzDQo+IGluIE9WTCBhZGFwdG9yLCBhbmQgdGhlIHN5c3RlbSB3
aWxsIG1ha2Ugc3VyZSB0aGUgSU9NTVUgaXMgcG93ZXJlZCBvbg0KPiBhcyB3ZWxsIGJlY2F1c2Ug
b2YgdGhlIGRldmljZSBsaW5rIChpb21tdXMpIGluIHRoZSBSRE1BIG5vZGVzIGluIERUUy4NCj4g
DQo+IEZpeGVzOiA1ZGIxMmY1ZDg0M2IgKCJtZWRpYTogZHJtL21lZGlhdGVrOiBBZGQgcG0gcnVu
dGltZSBzdXBwb3J0IGZvcg0KPiBvdmwgYW5kIHJkbWEiKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgIHwgIDQgKysNCj4gIC4u
Li9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgICB8IDYyDQo+ICsrKysr
KysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMu
YyAgICAgICB8IDI4ICsrKy0tLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwX2NvbXAuYyAgIHwgIDIgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwX2NvbXAuaCAgIHwgMjAgKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX21kcF9yZG1hLmMgICAgICAgfCAxNiArKysrKw0KPiAgNiBmaWxlcyBjaGFuZ2VkLCAxMTEg
aW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGluZGV4IGUyYjYwMjAzN2FjMy4uYzQ0ZjViMzFiYWI1
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0x
MDksNiArMTA5LDggQEAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY29ubmVjdChzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+IHN0cnVjdCBkZXZpY2UgKm1tc3lzX2RldiwNCj4gIAkJCSAgICAgdW5zaWduZWQg
aW50IG5leHQpOw0KPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfZGlzY29ubmVjdChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UNCj4gKm1tc3lzX2RldiwNCj4gIAkJCQl1bnNpZ25lZCBp
bnQgbmV4dCk7DQo+ICtpbnQgbXRrX292bF9hZGFwdG9yX3Bvd2VyX29uKHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ICt2b2lkIG10a19vdmxfYWRhcHRvcl9wb3dlcl9vZmYoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gIGludCBtdGtfb3ZsX2FkYXB0b3JfY2xrX2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpOw0KPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYs
IHVuc2lnbmVkIGludCB3LA0KPiBAQCAtMTUwLDYgKzE1Miw4IEBAIHZvaWQgbXRrX3JkbWFfZGlz
YWJsZV92Ymxhbmsoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIGNvbnN0IHUzMiAqbXRrX3JkbWFf
Z2V0X2Zvcm1hdHMoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHNpemVfdCBtdGtfcmRtYV9nZXRf
bnVtX2Zvcm1hdHMoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIA0KPiAraW50IG10a19tZHBfcmRt
YV9wb3dlcl9vbihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiArdm9pZCBtdGtfbWRwX3JkbWFfcG93
ZXJfb2ZmKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICBpbnQgbXRrX21kcF9yZG1hX2Nsa19lbmFi
bGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX21kcF9yZG1hX2Nsa19kaXNhYmxl
KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19tZHBfcmRtYV9zdGFydChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBjbWRxX3BrdA0KPiAqY21kcV9wa3QpOw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBpbmRleCBi
ODA0MjUzNjBlNzYuLjhkZTU3YTVmNTUxOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gQEAgLTk4LDYgKzk4LDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgX3BhZGRpbmcgPSB7DQo+ICB9Ow0K
PiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBfcmRtYSA9IHsN
Cj4gKwkucG93ZXJfb24gPSBtdGtfbWRwX3JkbWFfcG93ZXJfb24sDQo+ICsJLnBvd2VyX29mZiA9
IG10a19tZHBfcmRtYV9wb3dlcl9vZmYsDQo+ICAJLmNsa19lbmFibGUgPSBtdGtfbWRwX3JkbWFf
Y2xrX2VuYWJsZSwNCj4gIAkuY2xrX2Rpc2FibGUgPSBtdGtfbWRwX3JkbWFfY2xrX2Rpc2FibGUs
DQo+ICB9Ow0KPiBAQCAtMjQxLDYgKzI0Myw2NiBAQCB2b2lkIG10a19vdmxfYWRhcHRvcl9zdG9w
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAl9DQo+ICB9DQo+ICANCj4gKy8qKg0KPiArICogbXRr
X292bF9hZGFwdG9yX3Bvd2VyX29uIC0gUG93ZXIgb24gZGV2aWNlcyBpbiBPVkwgYWRhcHRvcg0K
PiArICogQGRldjogZGV2aWNlIHRvIGJlIHBvd2VyZWQgb24NCj4gKyAqDQo+ICsgKiBEaWZmZXJl
bnQgZnJvbSBPVkwsIE9WTCBhZGFwdG9yIGlzIGEgcHNldWRvIGRldmljZSBzbw0KPiArICogd2Ug
ZGlkbid0IGRlZmluZSBpdCBpbiB0aGUgZGV2aWNlIHRyZWUsDQo+IHBtX3J1bnRpbWVfcmVzdW1l
X2FuZF9nZXQoKQ0KPiArICogY2FsbGVkIGJ5IC5hdG9taWNfZW5hYmxlKCkgcG93ZXIgb24gbm8g
ZGV2aWNlIGluIE9WTCBhZGFwdG9yLA0KPiArICogd2UgaGF2ZSB0byBpbXBsZW1lbnQgYSBmdW5j
dGlvbiB0byBkbyB0aGUgam9iIGluc3RlYWQuDQo+ICsgKg0KPiArICogcmV0dXJuczoNCj4gKyAq
IHplcm8gb24gc3VjY2VzcywgZXJybm8gb24gZmFpbHVyZXMuDQo+ICsgKi8NCj4gK2ludCBtdGtf
b3ZsX2FkYXB0b3JfcG93ZXJfb24oc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCWludCBp
LCByZXQ7DQo+ICsJc3RydWN0IG10a19kaXNwX292bF9hZGFwdG9yICpvdmxfYWRhcHRvciA9DQo+
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IE9WTF9BREFQ
VE9SX0lEX01BWDsgaSsrKSB7DQo+ICsJCWlmICghb3ZsX2FkYXB0b3ItPm92bF9hZGFwdG9yX2Nv
bXBbaV0gfHwNCj4gKwkJICAgICFjb21wX21hdGNoZXNbaV0uZnVuY3MtPnBvd2VyX29uKQ0KPiAr
CQkJY29udGludWU7DQoNClRvIHNpbXBsaWZ5IHRoZSBjb2RlLCB5b3UgY291bGQgY2FsbCBtdGtf
ZGRwX2NvbXBfcG93ZXJfb24oKSBmb3IgYWxsDQpzdWIgZGV2aWNlLCBhbmQgZHJvcCBwb3dlcl9v
bigpL3Bvd2VyX29mZigpIG9mIG1kcF9yZG1hLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICsJ
CS8qDQo+ICsJCSAqIGRvIG5vdCBwb3dlciBvbiB0aGUgZGV2aWNlcyB0aGF0IGRvbid0IGRlZmlu
ZQ0KPiArCQkgKiAucG93ZXJfb2ZmKCkgZnVuY3Rpb24NCj4gKwkJICovDQo+ICsJCWlmICghY29t
cF9tYXRjaGVzW2ldLmZ1bmNzLT5wb3dlcl9vZmYpIHsNCj4gKwkJCWRldl93YXJuKGRldiwgIi5w
b3dlcl9vZmYoKSBpcyB1bmRlZmluZWRcbiIpOw0KPiArCQkJY29udGludWU7DQo+ICsJCX0NCj4g
Kw0KPiArCQlyZXQgPSBjb21wX21hdGNoZXNbaV0uZnVuY3MtPnBvd2VyX29uKG92bF9hZGFwdG9y
LQ0KPiA+b3ZsX2FkYXB0b3JfY29tcFtpXSk7DQo+ICsJCWlmIChyZXQgPCAwKSB7DQo+ICsJCQlt
dGtfb3ZsX2FkYXB0b3JfcG93ZXJfb2ZmKGRldik7DQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCQl9
DQo+ICsJfQ0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICsvKioNCj4gKyAqIG10a19vdmxf
YWRhcHRvcl9wb3dlcl9vZmYgLSBQb3dlciBvZmYgZGV2aWNlcyBpbiBPVkwgYWRhcHRvcg0KPiAr
ICogQGRldjogZGV2aWNlIHRvIGJlIHBvd2VyZWQgb2ZmDQo+ICsgKg0KPiArICogY2FsbCAucG93
ZXJfb2ZmKCkgZnVuY3Rpb24gaWYgZGVmaW5lZA0KPiArICovDQo+ICt2b2lkIG10a19vdmxfYWRh
cHRvcl9wb3dlcl9vZmYoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCWludCBpOw0KPiAr
CXN0cnVjdCBtdGtfZGlzcF9vdmxfYWRhcHRvciAqb3ZsX2FkYXB0b3IgPQ0KPiBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBPVkxfQURBUFRPUl9JRF9NQVg7
IGkrKykgew0KPiArCQlpZiAoIW92bF9hZGFwdG9yLT5vdmxfYWRhcHRvcl9jb21wW2ldIHx8DQo+
ICsJCSAgICAhY29tcF9tYXRjaGVzW2ldLmZ1bmNzLT5wb3dlcl9vZmYpDQo+ICsJCQljb250aW51
ZTsNCj4gKw0KPiArCQljb21wX21hdGNoZXNbaV0uZnVuY3MtPnBvd2VyX29mZihvdmxfYWRhcHRv
ci0NCj4gPm92bF9hZGFwdG9yX2NvbXBbaV0pOw0KPiArCX0NCj4gK30NCj4gKw0KPiAgaW50IG10
a19vdmxfYWRhcHRvcl9jbGtfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlp
bnQgaTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBpbmRl
eCBhMGIyYmEzY2JjZGIuLmM3ZWRkODBiZTQyOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuYw0KPiBAQCAtNiw3ICs2LDYgQEANCj4gICNpbmNsdWRlIDxsaW51
eC9jbGsuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L21haWxib3hfY29udHJvbGxlci5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRp
bWUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvc29jL21lZGlhdGVrL210ay1tdXRleC5oPg0KPiBAQCAtMzYyLDIyICszNjEsMTYgQEAgc3Rh
dGljIGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QNCj4gbXRrX2RybV9jcnRjICptdGtf
Y3J0Yywgc3RydWN0IGRybV9hdG9taWMNCj4gIAkJZHJtX2Nvbm5lY3Rvcl9saXN0X2l0ZXJfZW5k
KCZjb25uX2l0ZXIpOw0KPiAgCX0NCj4gIA0KPiAtCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2Fu
ZF9nZXQoY3J0Yy0+ZGV2LT5kZXYpOw0KPiAtCWlmIChyZXQgPCAwKSB7DQo+IC0JCURSTV9FUlJP
UigiRmFpbGVkIHRvIGVuYWJsZSBwb3dlciBkb21haW46ICVkXG4iLCByZXQpOw0KPiAtCQlyZXR1
cm4gcmV0Ow0KPiAtCX0NCj4gLQ0KPiAgCXJldCA9IG10a19tdXRleF9wcmVwYXJlKG10a19jcnRj
LT5tdXRleCk7DQo+ICAJaWYgKHJldCA8IDApIHsNCj4gIAkJRFJNX0VSUk9SKCJGYWlsZWQgdG8g
ZW5hYmxlIG11dGV4IGNsb2NrOiAlZFxuIiwgcmV0KTsNCj4gLQkJZ290byBlcnJfcG1fcnVudGlt
ZV9wdXQ7DQo+ICsJCWdvdG8gZXJyb3I7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0ID0gbXRrX2NydGNf
ZGRwX2Nsa19lbmFibGUobXRrX2NydGMpOw0KPiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCURSTV9F
UlJPUigiRmFpbGVkIHRvIGVuYWJsZSBjb21wb25lbnQgY2xvY2tzOiAlZFxuIiwNCj4gcmV0KTsN
Cj4gLQkJZ290byBlcnJfbXV0ZXhfdW5wcmVwYXJlOw0KPiArCQlnb3RvIGVycm9yOw0KPiAgCX0N
Cj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+ZGRwX2NvbXBfbnIgLSAxOyBpKysp
IHsNCj4gQEAgLTQyNiwxNiArNDE5LDEzIEBAIHN0YXRpYyBpbnQgbXRrX2NydGNfZGRwX2h3X2lu
aXQoc3RydWN0DQo+IG10a19kcm1fY3J0YyAqbXRrX2NydGMsIHN0cnVjdCBkcm1fYXRvbWljDQo+
ICANCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiAtZXJyX211dGV4X3VucHJlcGFyZToNCj4gK2Vycm9y
Og0KPiAgCW10a19tdXRleF91bnByZXBhcmUobXRrX2NydGMtPm11dGV4KTsNCj4gLWVycl9wbV9y
dW50aW1lX3B1dDoNCj4gLQlwbV9ydW50aW1lX3B1dChjcnRjLT5kZXYtPmRldik7DQo+ICAJcmV0
dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGRwX2h3X2Zpbmko
c3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ICB7DQo+IC0Jc3RydWN0IGRybV9kZXZp
Y2UgKmRybSA9IG10a19jcnRjLT5iYXNlLmRldjsNCj4gIAlzdHJ1Y3QgZHJtX2NydGMgKmNydGMg
PSAmbXRrX2NydGMtPmJhc2U7DQo+ICAJaW50IGk7DQo+ICANCj4gQEAgLTQ2NSw4ICs0NTUsNiBA
QCBzdGF0aWMgdm9pZCBtdGtfY3J0Y19kZHBfaHdfZmluaShzdHJ1Y3QNCj4gbXRrX2RybV9jcnRj
ICptdGtfY3J0YykNCj4gIAltdGtfY3J0Y19kZHBfY2xrX2Rpc2FibGUobXRrX2NydGMpOw0KPiAg
CW10a19tdXRleF91bnByZXBhcmUobXRrX2NydGMtPm11dGV4KTsNCj4gIA0KPiAtCXBtX3J1bnRp
bWVfcHV0KGRybS0+ZGV2KTsNCj4gLQ0KPiAgCWlmIChjcnRjLT5zdGF0ZS0+ZXZlbnQgJiYgIWNy
dGMtPnN0YXRlLT5hY3RpdmUpIHsNCj4gIAkJc3Bpbl9sb2NrX2lycSgmY3J0Yy0+ZGV2LT5ldmVu
dF9sb2NrKTsNCj4gIAkJZHJtX2NydGNfc2VuZF92YmxhbmtfZXZlbnQoY3J0YywgY3J0Yy0+c3Rh
dGUtPmV2ZW50KTsNCj4gQEAgLTc3NCw3ICs3NjIsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2Ny
dGNfYXRvbWljX2VuYWJsZShzdHJ1Y3QNCj4gZHJtX2NydGMgKmNydGMsDQo+ICAJCXJldHVybjsN
Cj4gIAl9DQo+ICANCj4gLQlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGNvbXAtPmRl
dik7DQo+ICsJcmV0ID0gbXRrX2RkcF9jb21wX3Bvd2VyX29uKGNvbXApOw0KPiAgCWlmIChyZXQg
PCAwKSB7DQo+ICAJCURSTV9ERVZfRVJST1IoY29tcC0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBw
b3dlcg0KPiBkb21haW46ICVkXG4iLCByZXQpOw0KPiAgCQlyZXR1cm47DQo+IEBAIC03ODIsNyAr
NzcwLDcgQEAgc3RhdGljIHZvaWQgbXRrX2RybV9jcnRjX2F0b21pY19lbmFibGUoc3RydWN0DQo+
IGRybV9jcnRjICpjcnRjLA0KPiAgDQo+ICAJcmV0ID0gbXRrX2NydGNfZGRwX2h3X2luaXQobXRr
X2NydGMsIHN0YXRlKTsNCj4gIAlpZiAocmV0KSB7DQo+IC0JCXBtX3J1bnRpbWVfcHV0KGNvbXAt
PmRldik7DQo+ICsJCW10a19kZHBfY29tcF9wb3dlcl9vZmYoY29tcCk7DQo+ICAJCXJldHVybjsN
Cj4gIAl9DQo+ICANCj4gQEAgLTc5NSw3ICs3ODMsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2Ny
dGNfYXRvbWljX2Rpc2FibGUoc3RydWN0DQo+IGRybV9jcnRjICpjcnRjLA0KPiAgew0KPiAgCXN0
cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjID0gdG9fbXRrX2NydGMoY3J0Yyk7DQo+ICAJc3Ry
dWN0IG10a19kZHBfY29tcCAqY29tcCA9IG10a19jcnRjLT5kZHBfY29tcFswXTsNCj4gLQlpbnQg
aSwgcmV0Ow0KPiArCWludCBpOw0KPiAgDQo+ICAJRFJNX0RFQlVHX0RSSVZFUigiJXMgJWRcbiIs
IF9fZnVuY19fLCBjcnRjLT5iYXNlLmlkKTsNCj4gIAlpZiAoIW10a19jcnRjLT5lbmFibGVkKQ0K
PiBAQCAtODI1LDkgKzgxMyw3IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19hdG9taWNfZGlz
YWJsZShzdHJ1Y3QNCj4gZHJtX2NydGMgKmNydGMsDQo+ICANCj4gIAlkcm1fY3J0Y192Ymxhbmtf
b2ZmKGNydGMpOw0KPiAgCW10a19jcnRjX2RkcF9od19maW5pKG10a19jcnRjKTsNCj4gLQlyZXQg
PSBwbV9ydW50aW1lX3B1dChjb21wLT5kZXYpOw0KPiAtCWlmIChyZXQgPCAwKQ0KPiAtCQlEUk1f
REVWX0VSUk9SKGNvbXAtPmRldiwgIkZhaWxlZCB0byBkaXNhYmxlIHBvd2VyDQo+IGRvbWFpbjog
JWRcbiIsIHJldCk7DQo+ICsJbXRrX2RkcF9jb21wX3Bvd2VyX29mZihjb21wKTsNCj4gIA0KPiAg
CW10a19jcnRjLT5lbmFibGVkID0gZmFsc2U7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBpbmRleCAxMDQwMmUwN2E0YTcuLjk5NDA5
MDljNzQzNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jDQo+IEBAIC0zOTYsNiArMzk2LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRw
X2NvbXBfZnVuY3MgZGRwX3Vmb2UgPQ0KPiB7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfb3ZsX2FkYXB0b3IgPSB7DQo+ICsJLnBvd2Vy
X29uID0gbXRrX292bF9hZGFwdG9yX3Bvd2VyX29uLA0KPiArCS5wb3dlcl9vZmYgPSBtdGtfb3Zs
X2FkYXB0b3JfcG93ZXJfb2ZmLA0KPiAgCS5jbGtfZW5hYmxlID0gbXRrX292bF9hZGFwdG9yX2Ns
a19lbmFibGUsDQo+ICAJLmNsa19kaXNhYmxlID0gbXRrX292bF9hZGFwdG9yX2Nsa19kaXNhYmxl
LA0KPiAgCS5jb25maWcgPSBtdGtfb3ZsX2FkYXB0b3JfY29uZmlnLA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gaW5kZXggMWMxZDY3MGNmZTQx
Li4yNTk3ZGQ3YWMwZDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwX2NvbXAuaA0KPiBAQCAtNyw2ICs3LDcgQEANCj4gICNkZWZpbmUgTVRLX0RSTV9ERFBf
Q09NUF9IDQo+ICANCj4gICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L3BtX3J1bnRpbWUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tdXRleC5oPg0KPiBAQCAtNDYsNiArNDcsOCBA
QCBlbnVtIG10a19kZHBfY29tcF90eXBlIHsNCj4gIHN0cnVjdCBtdGtfZGRwX2NvbXA7DQo+ICBz
dHJ1Y3QgY21kcV9wa3Q7DQo+ICBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIHsNCj4gKwlpbnQg
KCpwb3dlcl9vbikoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gKwl2b2lkICgqcG93ZXJfb2ZmKShz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgCWludCAoKmNsa19lbmFibGUpKHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ICAJdm9pZCAoKmNsa19kaXNhYmxlKShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAg
CXZvaWQgKCpjb25maWcpKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+IEBA
IC05MSw2ICs5NCwyMyBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21wIHsNCj4gIAlpbnQgZW5jb2Rlcl9p
bmRleDsNCj4gIH07DQo+ICANCj4gK3N0YXRpYyBpbmxpbmUgaW50IG10a19kZHBfY29tcF9wb3dl
cl9vbihzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wKQ0KPiArew0KPiArCWlmIChjb21wLT5mdW5j
cyAmJiBjb21wLT5mdW5jcy0+cG93ZXJfb24pDQo+ICsJCXJldHVybiBjb21wLT5mdW5jcy0+cG93
ZXJfb24oY29tcC0+ZGV2KTsNCj4gKwllbHNlDQo+ICsJCXJldHVybiBwbV9ydW50aW1lX3Jlc3Vt
ZV9hbmRfZ2V0KGNvbXAtPmRldik7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBpbmxpbmUgdm9pZCBtdGtfZGRwX2NvbXBfcG93ZXJfb2ZmKHN0cnVjdCBtdGtfZGRwX2NvbXAg
KmNvbXApDQo+ICt7DQo+ICsJaWYgKGNvbXAtPmZ1bmNzICYmIGNvbXAtPmZ1bmNzLT5wb3dlcl9v
ZmYpDQo+ICsJCWNvbXAtPmZ1bmNzLT5wb3dlcl9vZmYoY29tcC0+ZGV2KTsNCj4gKwllbHNlDQo+
ICsJCXBtX3J1bnRpbWVfcHV0KGNvbXAtPmRldik7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbmxp
bmUgaW50IG10a19kZHBfY29tcF9jbGtfZW5hYmxlKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAp
DQo+ICB7DQo+ICAJaWYgKGNvbXAtPmZ1bmNzICYmIGNvbXAtPmZ1bmNzLT5jbGtfZW5hYmxlKQ0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5jDQo+IGluZGV4IGNiMzZh
OTYxNzg2Zi4uOGZlZWI2ZGNlMjE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX21kcF9yZG1hLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19tZHBfcmRtYS5jDQo+IEBAIC0yNDMsNiArMjQzLDIyIEBAIHNpemVfdCBtdGtfbWRwX3JkbWFf
Z2V0X251bV9mb3JtYXRzKHN0cnVjdA0KPiBkZXZpY2UgKmRldikNCj4gIAlyZXR1cm4gQVJSQVlf
U0laRShmb3JtYXRzKTsNCj4gIH0NCj4gIA0KPiAraW50IG10a19tZHBfcmRtYV9wb3dlcl9vbihz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJaW50IHJldCA9IHBtX3J1bnRpbWVfcmVzdW1l
X2FuZF9nZXQoZGV2KTsNCj4gKw0KPiArCWlmIChyZXQgPCAwKSB7DQo+ICsJCWRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIHBvd2VyIG9uOiAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0dXJuIHJldDsNCj4g
Kwl9DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3ZvaWQgbXRrX21kcF9yZG1hX3Bvd2Vy
X29mZihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJcG1fcnVudGltZV9wdXQoZGV2KTsN
Cj4gK30NCj4gKw0KPiAgaW50IG10a19tZHBfcmRtYV9jbGtfZW5hYmxlKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX21kcF9yZG1hICpyZG1hID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo=
