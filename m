Return-Path: <linux-kernel+bounces-22993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A809582A628
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5103E2838ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19EECD;
	Thu, 11 Jan 2024 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ogGYVE3U";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BBKXWgFN"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0ACEA3;
	Thu, 11 Jan 2024 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b0c6da78b02b11eea2298b7352fd921d-20240111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RB7CM+px576ASLdrCXUKajG6cjg/xxcCdaMH7UbQMq4=;
	b=ogGYVE3Us6+GD5NnQmeIi1RJA+u6Fewf9Ja0E9r1Dr6cpQR5ninwPFqjtw6+Hgk5cI0ZmCEeHZFHieOTGFPcHzqH6snkb0fFGYySiK5T8lj4/1eCOVyxKHD+4AEjtfgAW6rgCpFkox8uBxTjFFogphXadbaI76b501MDqiQWnt8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1ba34528-3ec3-4549-9a78-c3965b4dd501,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:158e092f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b0c6da78b02b11eea2298b7352fd921d-20240111
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1308697647; Thu, 11 Jan 2024 10:46:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Jan 2024 10:46:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Jan 2024 10:46:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhC/G+EzhO0a+YY/oKdgQp7Pjp/tnkltVbGa0nmQ2ZlZteq0cbugLnhWZoWuQr9aC5rin5JeEZgGZK61rfl22SLua+er93z+aZDpR1+8sXqY8KUfs6+fb/KNz0mHpx9s0riOhRNzRpIpVP3zk0si5hRsFHxYlCdjwomFi2HFAN7xlFBEGZVj91UVFHo/i6zMFvDc/ItmGxQHV1p3vE3srSyZ3xvSzxQiX+2xP0pwbd3tfFK4wpFP4+xaBgrSERogeAPogsrXRzdp5ZWOUYdk7otcUAqXojI/bXvj5ANuJp/S4U42L9KVt0HzkWVCz/VyHEE5Rgsvi4UbTZAH8FxUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB7CM+px576ASLdrCXUKajG6cjg/xxcCdaMH7UbQMq4=;
 b=dAdiY2Nrks40i5tKJQ2M29WApIZ3QIZ8h3NWHQkezfU4V8gTFU/MKGom4rFJbFyQX34t82X1IDHCMC8ijNkcRB0ggjAWDohryKwrtDveGDxsx45drX7M11y23cW7OZAsW+5HYV1zOUOlN0mSt9Jz0TAl7Ui+CP0oU1cisA3GlqklTvXPyJ+3zWeoY9hFXnSVa4QTzgOL5pZXgKkX+AE2+YYaB3m7Is/AiceWG5MtIzcxBnpZMedm/97tHhmATfK3UqYbdv2+7L+ESYHqWxn7eggrHMDjom1c5qna2ld0FD7iaw7E5Md4phKF3SLRPxIcPElhx/KVwOEgww8b+w+9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB7CM+px576ASLdrCXUKajG6cjg/xxcCdaMH7UbQMq4=;
 b=BBKXWgFNAE471NuSt7/c3qQ9fW9buch0qxihf1tiVoBree0z9AWq9zBH4sNl2v2TU3eEAspa+fesL8krZ0QBglZ3n9Oipbzo8yPe6ttt2BUYxNk41ZChD9qSMd0Tf3Hb5aQfj9MklITlc0hxuK6MrN/47n3RiClFqlKnCma1jxE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6458.apcprd03.prod.outlook.com (2603:1096:101:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 02:46:55 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 02:46:55 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jstephan@baylibre.com" <jstephan@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>,
	=?utf-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?= <louis.kuo@mediatek.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "fsylvestre@baylibre.com"
	<fsylvestre@baylibre.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "pnguyen@baylibre.com"
	<pnguyen@baylibre.com>
Subject: Re: [PATCH v4 3/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Thread-Topic: [PATCH v4 3/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Thread-Index: AQHaQ8+FLeNoj2TSiEO6O2ToF6Nq3rDT6T8A
Date: Thu, 11 Jan 2024 02:46:55 +0000
Message-ID: <fae64e22742717398feb96bcde573cd44cca25bf.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-4-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-4-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6458:EE_
x-ms-office365-filtering-correlation-id: f074aa18-bf46-4b8a-bbb6-08dc124f92ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2OIvMVZp6X/xhGNqsfSdKsWlw1BscUTJ2kI8m5i1iJIaFpH5vwjZxj7xbtFo/F9obb78RV92g/Z3B0xqfm+FEr0IoWmIjqRcRgCGw6B1RiPxasUOATLqcJNUiU0YohAiyGtjGPic7JU7S2ZOanW3VocArxHj5wk43GI+/S/y1sYN7l18JYvUDrC6mxwy43B5pF6Q1zoBW+ck/uYCTT/SE0Gl+hGO9w+waAfL79eIVWAHv5bQGts8D1TYyoru6p5RFeRoriqoVK7zmOcLGNK7k5uXifBnE2/9Aiah/KefESWWVPNKFHJ3fr+bnwW4SgMwLqe4rskLbGI6+Ho8cg+88NrAFC006KQ9la3sZzZlTEizIdf29c5+z+oWooXG3pqb5o1VXB56b1bUE08h5ma1ohso4psK4X6r+tYzzVNQt8C2yUOLmUwJFCWyMg1EikiE09y9uShacJinWl2QMGa13Q+HvMV2QrFTK1eiDy9RQZHtstYTOYFOdj1QImkXtZFo81vCMx2TnJwmwxpvC7HN4ix66hvy1kJ8NtCljE3a4SSeJd7mZuHSkXi/M+HJHfvKsuMFJophSjBE3MVMBih2Gjn4gAOASNnSrhCpnD1mQCXbINuaTWUdhIwCL0nFJykXNblc/NHtxFF5FrmBk+JM5/6KBgYz8L1TDWlOaHFm6A3ssbuYO0WdIyV9+ZDVRGXCT+PtQ+NuImpKsFPdg9qiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(1800799012)(451199024)(71200400001)(478600001)(6506007)(6512007)(2616005)(26005)(122000001)(38070700009)(38100700002)(86362001)(36756003)(85182001)(41300700001)(2906002)(76116006)(83380400001)(5660300002)(7416002)(8936002)(8676002)(4326008)(66946007)(6486002)(66446008)(66476007)(54906003)(66556008)(64756008)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWNEanZLdkMyYUNTR0JQMTYrMml5R1pHTWRQQ1BHcThlb3loR3J2azVPVGwy?=
 =?utf-8?B?U3B2a2QrYjk4ZTIxZTZHOE9zN3FPNU9yMmljWVlpaVA3N0FIUGxkN0xyWUk0?=
 =?utf-8?B?ZzI1M1pUN1RWWVZLUzNTTC9wMHdHbVJrQy9kSW5LZEpuVFBON25qUkxXVVlD?=
 =?utf-8?B?UnJqQUdJR0pVUlhpRTNFakZGbVRmLzBtaXRxSU9RTWNCbG5MMmVncUFwT05N?=
 =?utf-8?B?SExYdDFFUnRaTHErcGp3K01BeWlJQTRDUjlxSG5vcFdJZ1dBNW5ZWit5TTFy?=
 =?utf-8?B?SXh0bjRTMmxBaUZzdWk2MDkrUHRaTVVlWEFsRTdRUEMxcHMyWXliaEF5Ly90?=
 =?utf-8?B?eTZDdzFoUUtGWWd6MHNBTkNJSDY3L01IVkY4NFBsbXhweDdISDR1ZG82NFNz?=
 =?utf-8?B?dXoxK051Z0VCZ3VoVVpCK3ZqdWJMRHBmQUhsM0pYSnRSSW0waDBNNGV4SXpB?=
 =?utf-8?B?Qmkwa09kZ2QyMkN0MWNwaGVvVlJXUVRGbDN6eURNaE1MVkIvOGFjeWltcnhE?=
 =?utf-8?B?VFh6d3JSNXJnRXRzZ1lqamxKYVhJaG5pYTdxMEVBYVB4UDBBTmJKdkdKb0py?=
 =?utf-8?B?MCtBYmJmWDdLQkYxZEpUZGorUW42SzVtaDBtTWwzY242QlptVzlHbEl4K1ha?=
 =?utf-8?B?RmVmMENSbGJPK01nd1VWODhoWjh0NVhGOXB6ZW5zcU1QSjZTRWJvOXFjb0Zs?=
 =?utf-8?B?Yi9jZlRKUmFsWGdUSUxiZlcvd0JLUURDeGxEMnRLeDJEeVRGRTA0dlMweXlw?=
 =?utf-8?B?MEVaVzFsVGtuN2hLcmE1blVCOVZSRWlHTmVackwvajY3OTlxWXhkUHc3c0hZ?=
 =?utf-8?B?OTg5aklDeFhYNEtmV0FLeFNhbGorTTJYdFd0VXowc0VDYWU3Q3MvVXgzZXhF?=
 =?utf-8?B?U2tZTW5HUkU3MHBGSmJkMEZESlkycDFUU0ZtdnJDdyszZjBGSkU5VDRCMEVJ?=
 =?utf-8?B?K1B6WFZpU1VPTU1CUG1ieTVpOFMrejlJUm92VGt0R1pOQnN5ODNFLzROOWxs?=
 =?utf-8?B?a293aVZ1U1J5OHRYeHhlSTZrS3lHRyt3VHE2YURudXJTZ1JRaTJHOVVQZlFO?=
 =?utf-8?B?djQ3Vzcza1pOV2hCZ1RHRmtIS1lKQXBGMk1PZTdkOEJ2SGJ2NUo2VmcwdnNz?=
 =?utf-8?B?UXREdDQ5d2xiWFY5Si91VGJYUUpyZjlURVc1d2ZsM1pjQjRZMEViL1J5TGFQ?=
 =?utf-8?B?VFJScFliUkgrNWdQTCtKeWIwNUxwNU8xakgrNUdVTFJNOC9VZUlmMkNMMHpr?=
 =?utf-8?B?c3BSMG01ckVueUFNL2I1OG5qWHRrb1FBTVhtVmduMDJMTjhxSC93WDM3WWp4?=
 =?utf-8?B?eXI1RXM0clVTR3orV2JoQjJWbXRJRTAwOUJHUFN6b3RqYzB6NEdWNVdmTDF4?=
 =?utf-8?B?ZndIejhwWktBRit5b09pK2c5VkhXRlZnOEc2RGN5STZ5TDhvaEszRm0xay9C?=
 =?utf-8?B?a21rcC9kb2UyQTZBd0d0ZU94SWlNbEJwc2RNUWhKcEtPanFCSlM0TUQzOWR4?=
 =?utf-8?B?N2l1dnJMbklndkxOWGk0dG5MUDlDb1l5MmROWkxNbTJhazQ4d0VaK25Bb0pL?=
 =?utf-8?B?b1ZRQ1FoV0dwUGJsUTJBd2pGbjJ0bW8rMVptWnBTUmp5RFNseklqRUZUcVNq?=
 =?utf-8?B?K3Z2SSsza1d4aXE5MXBKMjZYL1hLeHAyME5weHluWlZNaCtrbm05bVFqeVVj?=
 =?utf-8?B?SmtGOGZoaUw1Z0I2ZzBWV3hyTTMzSjZYSjdTcGtzakFLekZJdXZsbWp6aFl6?=
 =?utf-8?B?aG1aQlhSeDVrUkRiNzRJSnFpSVIzTmp5STEzUjEvcFBEN1R0QWNxV1h0cVY4?=
 =?utf-8?B?aldyK1ZIN1VCNGFnUW4waFBHSEV6UUFzUS8ySUZhWE0zUmhSWEYzcTVnd1VD?=
 =?utf-8?B?ZVRDTFU5QUJxdXVuS3Y1SUw1Rko0RmJMM0lFNEFTY0ozSlZhOUhidzFkZ0F3?=
 =?utf-8?B?blBIa0FWRjFmSmVaZmVtTnZNTGEzeGp1V3NxemVGdi82QUN1WE9va1NCMjFC?=
 =?utf-8?B?T3lycFdydXUyeis2WlZLTnVDNFNWTHpIWXd0N1lETjRFSXA1YlhZODhOY083?=
 =?utf-8?B?L3dxeEZYem96R3hGQnA0QStuS1RJSXpHVjYvYlROa0tLb1FMMXBOVDlzTEt6?=
 =?utf-8?Q?SbmzTqgp5voyGs5hllX36T0Zh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAB9050ACD4C494687DBE3250E2A7F22@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f074aa18-bf46-4b8a-bbb6-08dc124f92ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 02:46:55.6283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LB2memu0afVsYVwz2kjIhRFQMTMT67jmwEI+7UsbeJLHsyWjGkJjtZUlk5GgeYDshjzzF7hHkxnD/clabZ8lsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6458
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.782300-8.000000
X-TMASE-MatchedRID: cgbqQT5W8hcOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0qbqzDH9G7eTD1LciJB3541oMfp2vHck9VUazBX+AUFSdMX3aKQxXaBZvo
	+mFW19mCM0+ypVXg5IL85IS9eQZ7lYMkAB7/RF7dCnGIuUMP0VXJrB0Cu3DDnmyiLZetSf8n5kv
	mj69FXvKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7Oey7ImR563FRvEHWySVJUsLwKzqpgAI/fmBw
	Ltao/G0wyZe1PURXBE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.782300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1D840FB2F67E83B4892384812D0E51C24CFD3CD30892392CF1AFD00D4A8D10942000:8

SGksIEp1bGllbjoNCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE1OjE0ICswMTAwLCBKdWxpZW4g
U3RlcGhhbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBMb3VpcyBLdW8gPGxvdWlzLmt1
b0BtZWRpYXRlay5jb20+DQo+IA0KPiBUaGlzIHdpbGwgYWRkIHRoZSBtZWRpYXRlayBJU1AzLjAg
c2VuaW5mIChzZW5zb3IgaW50ZXJmYWNlKSBkcml2ZXINCj4gZm91bmQNCj4gb24gc2V2ZXJhbCBN
ZWRpYXRlayBTb0NzIHN1Y2ggYXMgdGhlIG10ODM2NS4NCj4gDQo+IFRoZW4gc2VuaW5mIG1vZHVs
ZSBoYXMgNCBwaHlzaWNhbCBDU0ktMiBpbnB1dHMuIERlcGVuZGluZyBvbiB0aGUgc29jDQo+IHRo
ZXkNCj4gbWF5IG5vdCBiZSBhbGwgY29ubmVjdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTG91
aXMgS3VvIDxsb3Vpcy5rdW9AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGktYmFu
ZyBOZ3V5ZW4gPHBuZ3V5ZW5AYmF5bGlicmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFu
IFN5bHZlc3RyZSA8ZnN5bHZlc3RyZUBiYXlsaWJyZS5jb20+DQo+IENvLWRldmVsb3BlZC1ieTog
TGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25i
b2FyZC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJh
eWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJh
eWxpYnJlLmNvbT4NCj4gLS0tDQo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAxICsNCj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsv
S2NvbmZpZyAgICAgICB8ICAgIDEgKw0KPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay9NYWtlZmlsZSAgICAgIHwgICAgMSArDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL2lzcC9LY29uZmlnICAgfCAgICAyICsNCj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvaXNwL01ha2VmaWxlICB8ICAgIDMgKw0KPiAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL2lz
cC9pc3BfMzAvS2NvbmZpZyAgICAgIHwgICAxNiArDQo+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsv
aXNwL2lzcF8zMC9NYWtlZmlsZSAgICAgfCAgICAzICsNCj4gIC4uLi9tZWRpYXRlay9pc3AvaXNw
XzMwL3NlbmluZi9NYWtlZmlsZSAgICAgICB8ICAgIDUgKw0KPiAgLi4uL21lZGlhdGVrL2lzcC9p
c3BfMzAvc2VuaW5mL210a19zZW5pbmYuYyAgIHwgMTQ4OCANCj4gKysrKysrKysrKysrKysrKysN
Cj4gIC4uLi9pc3AvaXNwXzMwL3NlbmluZi9tdGtfc2VuaW5mX3JlZy5oICAgICAgICB8ICAxMTIg
KysNCj4gIA0KDQpJIHRoaW5rIHlvdSBjb3VsZCBwdXQgbXRrX3NlbmluZi5jIGFuZCBtdGtfc2Vu
aW5mX3JlZy5oIGluDQpkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL2lzcC4gVGhlIHNl
bmluZiBkcml2ZXIgaGFzIG9ubHkgdHdvDQpmaWxlcywgc28gaXQncyBub3QgbmVjZXNzYXJ5IHRv
IGNyZWF0ZSBhIGZvbGRlciAnc2VuaW5mJyBmb3Igb25seSB0d28NCmZpbGVzLiBBbmQgZm9yIGlz
cF8zMCwgd2UgaGF2ZSBubyBhbnkgaW5mb3JtYXRpb24gaG93IG1hbnkgZGlmZmVyZW5jZQ0Kd2l0
aCBvdGhlciBpc3BfeHgsIGZvciBleGFtcGxlIGlzcF80MCwgaWYgc2VuaW5mIGRyaXZlciBpbiBp
c3BfMzAgYW5kDQppbiBpc3BfNDAgaGFzIG9ubHkgMTAlIGRpZmZlcmVuY2UsIGl0J3Mgbm90IG5l
Y2Vzc2FyeSB0byBkdXBsaWNhdGUgdGhlDQo5MCUgY29tbW9uIGNvZGUgaW4gZGlmZmVyZW50IGZv
bGRlci4gU28gaW5pdGlhbGx5LCBqdXN0IHBsYWNlIHRoZQ0Kc2VuaW5mIGRyaXZlciBpbiBtZWRp
YXRlay9pc3AgZm9sZGVyLiBXaGVuIG90aGVyIFNvQyBzZW5pbmYgZHJpdmVyDQp1cHN0cmVhbSwg
d2Ugd291bGQgaGF2ZSBlbm91Z2ggaW5mb3JtYXRpb24gdG8gZGVjaWRlIHRvIGdlbmVyYXRlIG5l
dw0KZmlsZSBvciBuZXcgZm9sZGVyIGZvciBuZXcgU29DLg0KDQpSZWdhcmRzLA0KQ0sNCg0K

