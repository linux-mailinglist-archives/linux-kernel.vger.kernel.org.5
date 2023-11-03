Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8017E00E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346847AbjKCJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjKCJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:05:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D561BC;
        Fri,  3 Nov 2023 02:05:25 -0700 (PDT)
X-UUID: 1c7d7f407a2811eea33bb35ae8d461a2-20231103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YZtW8I7dY4J+lOp8NLTk0/GtHTbB+EBhcj40okPjXNs=;
        b=brvAjT76DY6EJE+BZUck6nj8IQlvSHQOn3kmoU+aWmOQGdWag8qhZqoYdTyGXcLBVYur33AIgTS6vsh2x0tPgcnOYjoKqU5DvQ7S3Jxlab+9LjB/u2j9WxhhbHbhEKgNBIP2OlDqrHFKKFYlkkzbGBLTPprfHZzgEPZ9MfaCT0M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:56376090-3871-43a0-812f-e18853ca64a4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:9cdda45f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1c7d7f407a2811eea33bb35ae8d461a2-20231103
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1368836772; Fri, 03 Nov 2023 17:05:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Nov 2023 17:05:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Nov 2023 17:05:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDJvQnTLB7zrOmcbpQ7WXQ6In86RTSSAYPhjQlgD5JcWsbokfC9mNVGpH40EX314f3cGUhEgEJTHQVz0kECDgW/SJrpfPAXLvgyd7Ai5p3hjzQXDNcUUEqiTOAH9f4BF0H3Nl82/HSiB6Q6GG8rOKceHFiXSaTm8vE674xGu527wm9/S9Rdpw+JhockL/G921FmNCwrgi3ivXrb7p6kz7dm2OLZNrTy/SxYbBHEY1oYS7LiRHHCRk8VBguhnYeV307TvEg41uU0GsagiKDc+/H6ymtCnOot1GA9P5kgYjoIGSa6YqJMQlx7sZ8jYvO9CTLAVnm2h6es+KX/6Stxczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZtW8I7dY4J+lOp8NLTk0/GtHTbB+EBhcj40okPjXNs=;
 b=V7bNs5jOfUFwOvaRuSeRqR4lKZNo8Yo10SQl2+iv+M8/OxpkHnUoah1c07LirlaLEmyC6yHyCSoe4hlktnuH5PSLH/ss2ON1vts/EjqxMCtjb8sFGI0XD/IMscWwqh2vtX+pw0AvHj8xO1FeK2gLwTm2pnB7ycKR9uhSm/IukPotIeo1mCxEcCW5jlQv9YK679mCYC45XmvMsIuMQ9FHGgSZq2RBiZsVcWzIG+PrTCqXDYcnsbg0z0HVVuSDcd51TuwGkqcEXaVmJ+VCakXkWsAlJgLnKdkuzaFCklddHMHhE8zcMibr7mNV/oUDGvfpgoZWnL4U+nvyyoHFj2BnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZtW8I7dY4J+lOp8NLTk0/GtHTbB+EBhcj40okPjXNs=;
 b=J4RZIITTmdr4cp/KZF1LHhc+kdCIhl97+vJe42jrTJ8f2RRof2WodQCfPtqSjerRJGBY7ruH8PuJ/MbjxKcJpMU6MloVboZ8lCBtUohKq0rfsufvvEkOKSe+tXSG0Lk7H//T4+y1VqC9Pef3dInHZ1Y6+UwfcXPhthkxCap5dW0=
Received: from PSAPR03MB5544.apcprd03.prod.outlook.com (2603:1096:301:62::6)
 by JH0PR03MB8187.apcprd03.prod.outlook.com (2603:1096:990:48::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 09:05:16 +0000
Received: from PSAPR03MB5544.apcprd03.prod.outlook.com
 ([fe80::a1dc:ca23:9aba:7e97]) by PSAPR03MB5544.apcprd03.prod.outlook.com
 ([fe80::a1dc:ca23:9aba:7e97%3]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 09:05:16 +0000
From:   =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     =?utf-8?B?V2lsbCBTaGl1ICjoqLHmga3nkZwp?= <Will.Shiu@mediatek.com>,
        =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
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
Thread-Index: AQHaByTnzFC4rhYmWUKg+y7lOe9n1bBkxn0AgAOHDoCAAA3igA==
Date:   Fri, 3 Nov 2023 09:05:16 +0000
Message-ID: <3f30258d7f728757892b21637b7f8ba686269917.camel@mediatek.com>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
         <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
         <ZUSsJbcSPSR52J2l@infradead.org>
In-Reply-To: <ZUSsJbcSPSR52J2l@infradead.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5544:EE_|JH0PR03MB8187:EE_
x-ms-office365-filtering-correlation-id: 35ff0361-0aa2-4633-d637-08dbdc4bff34
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVxaPH0KML632YNp+PSpFJMRt83ErZC6UGj5Z4fzJ4XjIJqGao/HNntvfiHy73X88gw28s2Ff+K9YDl+maoKPSEAxA3If356WFNlCH4qHcVfQ+yPgxmSWsXnEBT27CLsLcwEv0FGDz3KAey/KZCkORQTK7OnsU65Q/zhlotq2znvcGmj3uDsRK7N8BPr/nerEQMX8r0av9xZgadmID6pf4xEopyFIrDVeybmqfaToLk0DJ30hEOGLfIYk0PYfjwass2SMmOdLBTWeeBrzOeyWCErWv2BUjTT8BB/DjAS2PQ7EW1vOvFYywG1oMlnl8FlxMXdnRW3x08pn7hBqQf3knia17Pv4g0CPCtUmGSIqq4ABGl+WP0zjijaomw36k6IpqSxjvyVbTQC6kj81ma+MYteFQiXZfu2nlW4MEwmR6u3/7zZ1ItmBMDMbincc3l+4BRa098FNqFRNJw8LzklV7iD1KCzFAQqoOBzM+1jQ+TntdQ8MebEtmI6eARemcxv6vLG/ak2NSeouZOrJmmg7fOek6um5WeHhDdZanpV4bPXtUvK29zl4LoHQI252Y8CquhY/16zrYXR6vh+iCIv5ml1HXjlJMau0qHldufi7f751UNgp7ptUIPSsx8YfbCGfoAAjtUqawBfI1kG6Ne2qDH3UToyU2XlJFiKSWZQiHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5544.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(86362001)(8676002)(316002)(8936002)(6916009)(6506007)(6512007)(66446008)(54906003)(64756008)(66476007)(66556008)(66946007)(91956017)(76116006)(83380400001)(38100700002)(122000001)(36756003)(5660300002)(71200400001)(478600001)(85182001)(38070700009)(26005)(2616005)(4744005)(2906002)(6486002)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHVvVXF0WitVN2ovbG43ejU0U2RWUnRUNmlCaHZOTEdwN2lhb3lMbTZZQUx3?=
 =?utf-8?B?RUg3NkFKTjVwTjBkdVRaY0R6RXZtRVBITUgrby8xNE1wcVc0UEljeWY3aE9J?=
 =?utf-8?B?K1Z1bWowYTlaa3lRQlI1RzlES1B3TTZCaGU4WE9XaHRKVTRxWWhSbGJXWXdJ?=
 =?utf-8?B?THYrelh6SzB3YjAwZmZhRmpIYXRRNTN2eEtGb0Zpb3dzbjByMnloQ0FzVHlS?=
 =?utf-8?B?Q1pwRGxzbktSaFRyRXRNbDNFQ2hRZFRHOG5kaHBETHBLQVVzYlpaQndDWHlW?=
 =?utf-8?B?RjVkU0xiV1k1bEdmbVFSYWIrMFowVTBvS2dOekpLcE5kWW1XOTh3TXhacUZC?=
 =?utf-8?B?K0lueVlPamQ1KytKbWpSVldUcWp5ak0wTU9paFhWelFSWkh5RjNVdy9RNzVE?=
 =?utf-8?B?c3A1RlE1U3RGU3R0V1BYOFI2b0o0SktoVGtvZUZTVGpHNHZ6Y2dpVWt5OVR5?=
 =?utf-8?B?OG1WMnBpNUVEOGJGd2RJcEVvalAzYlc3TXozV1puM2NIYjhDZDdxMVZNU1pn?=
 =?utf-8?B?bkJzcXNVTFB5MklBRHFWVEs5UkRnWmQxQjlFa3RIUDljN0NrNm1aV0J2ZUQr?=
 =?utf-8?B?MVlqNGpoU3I2UVFmM2lmRmRFbUFUWmI5TmhObDdSS2VrSmRIUTUzKzV2NnlE?=
 =?utf-8?B?ZUgxWnhkNXorWHhEejdCK1FhVEZLMUExVHFUczlSR3BHVHB2a2laeHBOWWdW?=
 =?utf-8?B?MWpkNWpybE12MUxFVGVmTGdxQWNTZnhhcGJhQ1pwN2w2bVJFNzdhMXFUSTRI?=
 =?utf-8?B?UzNWdk8vMzlTMnlWaFBMaElIQVljRXpBZTVldW5ZNDhNODQxL1VVank0ZjR5?=
 =?utf-8?B?VTdGaEE1aHJZY3R5eWprZll5aUNzREZYdnFGbVd2RHVaK0ErT2lkVmQ3dXBJ?=
 =?utf-8?B?eGdESGZYSndaMGZobHNRZENuaEs4UWRZUk4rSVdWM3cyU3hEU00xU3lDMjll?=
 =?utf-8?B?VkRDenBabjVoV29NalZlQkZUb1BhTjRyWVZJcGFNQlpwaXREK1RxeWlXRGp1?=
 =?utf-8?B?UXc4dVMwaDhwMHpKVVRpZXhmZDdEVGZXcDRYTjN3OXJnZVozN1NOcjlxVTFP?=
 =?utf-8?B?K0ltTlg5NnVDL1h6Y1hwQkdnYmRVbTQwMm9pU2x4S3I4WHBzMjBLZnBId1dF?=
 =?utf-8?B?d2hGTGhRaHpGOTBKV1orWG1NaERSdXZzdHptQTdMN01FQk0xVkhSSGREbXpq?=
 =?utf-8?B?c3J5WmxoU1VHY2JMWWE5eHdtV3FFUFp6OXNqVHFKenpNRlNzcEtoTlIxWG1k?=
 =?utf-8?B?clJpS2NkKzhCNmJkWTNYU1pUK09SS2JHSjIwdDZMeWRhaGREQjVaZ0tqTmcv?=
 =?utf-8?B?SFZCZ25icU9tSFFaNC9lS05DRGNDbTMrenRiY3FUNlRrS2o1b3pySWh5NEVx?=
 =?utf-8?B?cytoZkN5d0pKWTcyWUVqK1duelVnb0dmTGswYk05NXd4Tjc3eVdtdmFqY29i?=
 =?utf-8?B?SGpDbTk2VnByN2VuWjZjb3ZmdGZMNE5sWFZqdU83Y0pxMDRSaXFSVXZFMzNF?=
 =?utf-8?B?SmRiY3BuT2ZwaDVtQ0ZLWEZXL0poYm85SGxSQzhWTEp3T1pqM2dpbi9jMnV3?=
 =?utf-8?B?K1BJYUF5ZWdQYi9ibC84bSt0ZytGYys3L3dOM3RzSmdOOVBsNmYvRVg0YW1M?=
 =?utf-8?B?OGdVN09SQ05HbVJmTWIzUk83YkZGRDlhK1N5ZnBvclduK1kzTFpBdVQ3Wmtv?=
 =?utf-8?B?NkQyNGJnSlROWHFtY0x6aCtkYWZPWG1tbVZPc21ReEhIQkxVVERhTW9selhI?=
 =?utf-8?B?TjMyRGJPQjBMcW80VWVKM3luM0F5bzhtTDg3allCaUhraVhQVkUyTzJrcUU5?=
 =?utf-8?B?YmtiaXFXNEl1akVEY1dOMUFyRk4yMUNac3Z3WXRRRlIxMnRwdTV3MmY0cXRT?=
 =?utf-8?B?N2oyWDBja0lxQkFWNE9TUnNiWkx2aFpqVTR4NUpTQ0thcUM3b3E5czdDazVK?=
 =?utf-8?B?NHhkWkF3MXlOUTJqZ2tvN3ZubFVLYUN6TWh6dHREY0VRNU1zVW5wSUt0WGpX?=
 =?utf-8?B?dUNTYWRJamNGd1o2MDB3Slp1RitKMGtERWoxOTB3VDErdzRzRTRMVzJQdHpZ?=
 =?utf-8?B?dlpOWTJ5RVVHZGpLY3pTU3VYek84Y1ZtTE9VWWpYc2lDSThJL3Z2dGlVRXh5?=
 =?utf-8?B?amRsZGk2K0pla0hEelREM2RhM25HL1pObm9EeEw4UE5LN3IvSzQ0Qng1UmNJ?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5098811FCBEB0F41B25D32EE8764E0EF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5544.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ff0361-0aa2-4633-d637-08dbdc4bff34
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 09:05:16.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hG2h934XnhNsH8Ysq16KM8THuvJc8v9NkNeMvEchKXS5EihGSIVoAjsP+2PGJq9uw8Jr1Lg3uk+NB73/QZyxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTExLTAzIGF0IDAxOjE1IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gWW91IG5lZWQgdG8gbG9vayBpbnRvIHRoZSBzcGxpdHRpbmcgY29kZSB0byBzZWUgd2h5
IHRoZSBzcGxpdHMgYXJlDQo+IHN1Ym9wdGltYWwgZm9yIHlvdXIgZGV2aWNlLiAgV2UgY2FuJ3Qg
bGltaXQgdGhlIHVwcGVyIGJpbyBzaXplIGFzDQo+IHdlIGhhdmUgY29kZSByZWx5aW5nIG9uIGl0
IG5vdCBoYXZpbmcgYXJiaXRyYXJ5IGxpbWl0cy4NCj4gDQoNClRoZSBzcGxpdHRpbmcgY29kZSBp
cyB3b3JraW5nIGNvcnJlY3RseSBiYXNlZCBvbiB0aGUgcXVldWUgbGltaXQuDQpIb3dldmVyLCBz
aW5jZSA1LjEsIGZ1bGwgYmlvcyBhcmUgbm8gbG9uZ2VyIGEgZml4ZWQgc2l6ZSBhbmQgb2Z0ZW4g
ZG8NCm5vdCBhbGlnbiB3aXRoIHRoZSBxdWV1ZSBsaW1pdC4gVGhpcyByZXN1bHRzIGluIHRoZSBi
bG9jayBsYXllcg0Kc3BsaXR0aW5nIHNvbWUgc21hbGwgZnJhZ21lbnRzIHdoZW4gc3VibWl0dGlu
ZyBjb25zZWN1dGl2ZSBmdWxsIGJpb3MuIEkNCmRvbid0IHRoaW5rIHRoaXMgaXMgc3BlY2lmaWMg
dG8gYSBwYXJ0aWN1bGFyIGRldmljZS4NCg0KV2hpbGUgSSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQg
YWJvdXQgbm90IGxpbWl0aW5nIHRoZSBiaW8gc2l6ZSwgaW4gdGhlDQpwYXN0LCB0aGUgMU1CIGxp
bWl0IHByZXZlbnRlZCB0aGUgZ2VuZXJhdGlvbiBvZiBmcmFnbWVudGVkIGJpb3MgZHVyaW5nDQp0
aGUgc3BsaXR0aW5nLg0K
