Return-Path: <linux-kernel+bounces-4651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F30818048
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B73D1C22C84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D6882F;
	Tue, 19 Dec 2023 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pjGyrr7a";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZFrkS6aL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3768820
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 183c13349e2111eea5db2bebc7c28f94-20231219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GRjnHmw05ZagBoIeZ+hn4Xrn4fXu4rtTTZtwl69iArg=;
	b=pjGyrr7aCXtHnu9QKDNHmRXpMaZRhDCSxCppkMB4CtB5fSGnXz4nHv6fIhuwFauwBBdyEHD7laKF3SCxMd5XfTaV1wtCk11I0MR0pwAqPhBly67EWo6vJiQkxs97YEJKwgMLwT2PMlAkAzASPQuJYuyVFjBhm9YgSs8TYwmzApA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:7a593799-40de-45b4-888d-145fc86d61b4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:84aad3fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 183c13349e2111eea5db2bebc7c28f94-20231219
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 710092383; Tue, 19 Dec 2023 11:45:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Dec 2023 11:45:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Dec 2023 11:45:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfYyJeNPLL7cCGadTRUZjLZ8zDLkCH7bq5c6X5rO6cnTusxa5Jq+OAwlIlU4bQ7ZxPLH6FZfdSYuBBOa6DslZ/dsKCv978kqerZi52fANlSR1cWC8GJbydtnCIkcy1x43eXEwZEzulbg9BDj3by+Cpql5e6N/mGMdKbcGVfsYs475l0Mj2k1/X0BISDoHFvjNslOgEHH/d9aLlk9+EcrdiQDs9gFOtWx3Pa7gy8p0p/zgPThoU9gpPIgiCGfbsP23mG4QPnnNOQ9LtW3hKXLqLZgvemQzkqWLkl/9cFj9WQc36Uwuljb324y+m6IcWyA38Sf8U9+Cs/t1/IGekB4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRjnHmw05ZagBoIeZ+hn4Xrn4fXu4rtTTZtwl69iArg=;
 b=fkzxx4aHKfcfKY/WAdJCnAy8i6qbkRzhORNyhMe327ChONHnc+EB/KocnzNJY/oxjncf1Md3NtUlUhNC+n9DzJvyuag2Q0FyE23ms3/OjOupsWyR1lV1lo784HxfS1h1Uck+gmK7Su9oXYgHbkSIDb11FGFq0+lDDn0oITWe5TQSKxLdk2r3F9GrWFECWszO+vqkoqNlTx6JJEBuZhtWYZ0KYkT+QRyXbARwLMX+oSE/Wd2z0048gXcZ33vEQ8QgjIQi+2c7ig0e662w/Hj86UEC8MafdmA4W6bV0zjYCw4VpK1/TWNZ/xyiEKfJTb5IMzAfUyQxwKcshgifmenY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRjnHmw05ZagBoIeZ+hn4Xrn4fXu4rtTTZtwl69iArg=;
 b=ZFrkS6aLUD4kr1h1iMnRg1Pe5HgN7qhqqB9+xb/PqJAu7fxOIapIHJ3IIcfelIJYY7x4/YOwdOZGWNqvQOWOPUDRRaAj53q5mXWr7qVczdEPp09usNbkDAHKxspuxagoc2FhbWs/Qi3EIN9w3f/rNKizXUpeyWmrx567pT3OBOE=
Received: from SEYPR03MB6627.apcprd03.prod.outlook.com (2603:1096:101:82::5)
 by PSAPR03MB5608.apcprd03.prod.outlook.com (2603:1096:301:65::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 03:45:43 +0000
Received: from SEYPR03MB6627.apcprd03.prod.outlook.com
 ([fe80::a7a3:8cf9:5fb:e553]) by SEYPR03MB6627.apcprd03.prod.outlook.com
 ([fe80::a7a3:8cf9:5fb:e553%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 03:45:43 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "seanpaul@chromium.org" <seanpaul@chromium.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH v4 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Index: AQHaHr0gb/AOKZLcLU62t+Yy81eGg7CwCqWAgAATd4A=
Date: Tue, 19 Dec 2023 03:45:43 +0000
Message-ID: <23567207c3b28cb3298f85ac9be827e0ba09d278.camel@mediatek.com>
References: <20231124100052.18599-1-shawn.sung@mediatek.com>
	 <20231124100052.18599-2-shawn.sung@mediatek.com>
	 <0eb813192c02ac6f8d05fe9f4fc805517f5cb97b.camel@mediatek.com>
In-Reply-To: <0eb813192c02ac6f8d05fe9f4fc805517f5cb97b.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6627:EE_|PSAPR03MB5608:EE_
x-ms-office365-filtering-correlation-id: 4f56165e-bc2f-416f-abd1-08dc0044fa3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZCnMEj8RbUlcAGUocSsz8o5jIAU0KctRwmkUeOsRy8irA/FTeKSlC4kwfTf2fTZuY3wv3aaLLG07rJzGU+qzqM+gUx59xi4enX/OT6jfaPCBJwIJyf78xh7mPWjo7buNrDFjJWBP72jPLJ+RGvPkVTZDmsnjmmKQNrMi7Mn6vaIlCHyokWBEBaQeuwEyL5FKDWknAqxK1mU4zI8PwqJ+qlooYGrf3qkPC/lQvpkPfsrxmn1o4SCjM+A6rSrOGWwOR+LKF+0nINbvbhCnY+hulY5Lmf1XIANLziW2ifOfmoG+DpasgUNbqR3so75thg6HYN1a30ufRa1dvGTsx6JSkOXK4b1gID/+yTFW/fcd2GY2LwiCt3CE4TiD7Ecq76sLmmBrJbZn/EACLEekNLsrp4XCn/nsKmAP5A3l8clVTRNX62jvgQUlytYcNT5b/iUgkLsy7ge2Dxj30Y1hKXhQlV0XHi2Puw2uyUBcDlFvI1dqfxTROI2Ejhb5TN+qqm8UtN78tbOjqWY0NkD5JmG25GLUOOEVbDsseKLQymW4LWulygtgXlxltODZhOwE8G4rkTelLVZ84bcwvYP0ERiUcb/HJp1ZxvRy6lF5vy2AQSG6O95yVXPhERpb+O5jTKMO3vUFh9WDb17CiynS0ap1dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6627.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(64756008)(66446008)(54906003)(110136005)(91956017)(66946007)(76116006)(66476007)(66556008)(316002)(5660300002)(4326008)(8676002)(8936002)(7416002)(6486002)(478600001)(966005)(6506007)(4001150100001)(83380400001)(86362001)(122000001)(71200400001)(2906002)(26005)(6512007)(36756003)(85182001)(2616005)(38070700009)(41300700001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2lMTSszMS9xUlVZeXBCZUZqaEowb0w4T2RrUExjNzRrSDNuVnNCUk1IbnN3?=
 =?utf-8?B?a2tIWUNoeVdoK1g2RjdsSXBKWi9tNGtlUnRkVUdnMXg2YkZDL2ZNaDA2Zmhw?=
 =?utf-8?B?c2JOZ1FyRWgwMmQwWUs0U0FGZ3FvVkMvcHpNYnR1UFgwNEZGNEJRZXpMbW5B?=
 =?utf-8?B?OUM2d0NLdnZHZDM2dThkb2ZQclg3NmxOekVZVDBEREtyUG1XNElxaGF3ZGgx?=
 =?utf-8?B?RkpXQ2ZFTEZCWjl6YkwzQVNVNHd5amprdHlIRHRzZVRXSXJKdlRTZ0k1MUpH?=
 =?utf-8?B?S2p6ZjV4ZXhTY0ZYaW5KNzdHa0lPV3p4eWpLWUlRWGo3bG9DMzVFOUN4YVcx?=
 =?utf-8?B?VlVhOUlJWGtYeGlGNmRtbnFFQVVYNFlFQ1dUeUZuY29KVTdsZVVOTXFPYUFF?=
 =?utf-8?B?QzFGNE1GL0NUT0JCcWhEWTByWFhjeWhhQXI3L2ZHcTVGeHZzcVd4WEtMZGI5?=
 =?utf-8?B?K2l2TVNYNG4rRitWbWpxYXYvb1piZ0JFNWJJbis0akxWWHdOZUNKZVdnQkFh?=
 =?utf-8?B?M21TQzUxN3IzSHUxQVdHdmdzV2hIeCtTaktodUdIcHFUbGpPNVRTei9oZGYr?=
 =?utf-8?B?eXVEOTFPNnl4M1hlQ3VuSjJ1K05qbzlTWDNlSHVNemtjK2Q1MStkWFc4cFBk?=
 =?utf-8?B?MC82aERLUXVHT3FIRHRDaE9acmc0VEdBeE1BWFVGUUpQYmsyYWNoelhMTTZo?=
 =?utf-8?B?MHlYM05iZ0gyeGh6M2VkMk5HQXRNbVBTTEVON1FXZVpTSCtiWldHTGdaazFM?=
 =?utf-8?B?M0xWcHpsZzVJeVBpTU5JSnlUWjJaMXI2b1hvZ0MvOXBDazBHOE9mOFdvdHVs?=
 =?utf-8?B?Z3Fva1hMRkd4czFNb0MxcGVMV1hvdUFqZi8zeCtWRE0vSWllNER1dSt3N0Zk?=
 =?utf-8?B?Qk5nNE1YUXl0djVEMGlORERzRnlQekhYZXQxc2hFT2VPaGZJL1FjUFdRNU9i?=
 =?utf-8?B?K0hiUkRVK3ZFOGY0WWw1Rnc3MTB2SmZWVUFhMEZBeEFORk56eG9CN2E2WW1x?=
 =?utf-8?B?WTJKM09iNEhDVkQxRGZGbExwNFl3L1lQY2Y3QkVRYlUyc3pTbVNQZEJQRFJX?=
 =?utf-8?B?emo3bTUzaDk0eXdqVVBPM002a2VSYnJFOUJPdnp1WTB1aUdBU0lHWGsrYWoy?=
 =?utf-8?B?TnVTcURqNzJ0RytVdHlrcFhYSVJNTCtPZSttRGlwbTlwWlRRbzRCbEprQUtP?=
 =?utf-8?B?OHNITEVpcW9aL1RPaVM3akFLOS9DRG9rcG5sQVg1Mm1EamVBTEJPU2lRVW1R?=
 =?utf-8?B?ZktFbDNPU0crSXA2d3pVWHVlcVZHYVViSkxVdHY5Ti9sN2dNby9UaHdIajFE?=
 =?utf-8?B?YXdaZzBnUUFhbGlrOHFDY2RzQ0o4LzF4bnpmWERrY1FRZ1V2VVdBaVRNNEFH?=
 =?utf-8?B?YUZXL2JWVjZ4ZUdHL2lQbURoY1NlRE5TOTNCQlZJelBsT3ZYaFdKeDhKNXM4?=
 =?utf-8?B?SER4R2k1eXptU2J4OG5jeExRYVdLd0VqeWdpNHZSNG5ibXAvT2FrN1RJckpD?=
 =?utf-8?B?R1djTUpHM3JUcGpkemdQR0JFV2FhK3c3WmZqVmk1d2ZHVmdzTmxzVUNmb2w0?=
 =?utf-8?B?MjNPR1NUY3FuRGZtTElyUTFTbmEvUTVsLzdJZlkvWmFwQmMwSk8xd2YzYjZT?=
 =?utf-8?B?L1lGRG9rUno3TUs1dDJ5UVNaRmFlSU5SQ3ZPOHZIMnl1SWJ4VDFDTVF3aXd2?=
 =?utf-8?B?T21zdmF5aUhqZDlnZlplZzhWdFVSZmdMRnVvdlZ5dkppR3JQUlI2RzQyTnZI?=
 =?utf-8?B?Mm4vT1RlV1FSSGJvS09TYkZqeHNGQ3hKa3gzL0tiSG9UazlacDhvanMrREd1?=
 =?utf-8?B?cXhiRHRTYlExZUZ5ajhhYXZvTnJsYnA2MHVvS1k3YlNQaVZ6eWY3TUVCL3ln?=
 =?utf-8?B?c0EvQXJkby9WTUFGTEZQenNMaVErU1RHVDUrNkx2b0dRcWZpZVlCYzYyM1NP?=
 =?utf-8?B?c002TE9MSWorVktucmViUWpFNHA1Y0J2UjIyL2VsOEUrUGVUNXJSNXVWc0Rs?=
 =?utf-8?B?cG0rR0g2QVBhbkdWRm5VVkhnN1YxRjJnMVkycEZ6MGZZakRtZGdJY0JXZmFu?=
 =?utf-8?B?aEd4OGtma01GRzBGbyt1MEJOUU5qUndUR1NqT0phcXBpQklsTGVORU5KTWFK?=
 =?utf-8?B?QmZiQkl3OExqazNuRGQxRUxUWVNwNzdvZWZQazgrZUtFNHM3YjM3MUIzVlhw?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C300D95E6F1CB45AE678FD1A8BF0FB4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6627.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f56165e-bc2f-416f-abd1-08dc0044fa3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 03:45:43.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqpvhaJgFpoE3MymIjXZj3PbOqB2CqaSiZ607o0UgepJRfjI5P5pEcBlnVGo4/oAS9y9VECBJ+VK01X4j4i/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5608

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAyMy0xMi0xOSBhdCAwMjozNSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBIc2lhby1jaGllbjoNCj4gDQo+IE9uIEZyaSwgMjAyMy0xMS0y
NCBhdCAxODowMCArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gPiBDcmVhdGUgcm90
YXRpb24gcHJvcGVydHkgYWNjb3JkaW5nIHRvIHRoZSBoYXJkd2FyZSBjYXBhYmlsaXR5Lg0KPiA+
IFNpbmNlIGN1cnJlbnRseSBPVkwgb2YgYWxsIGNoaXBzIHN1cHBvcnQgc2FtZSByb3RhdGlvbiwN
Cj4gPiBubyBuZWVkIHRvIGRlZmluZSBpdCBpbiB0aGUgZHJpdmVyIGRhdGEuDQo+ID4gDQo+ID4g
Rml4ZXM6IDg0ZDgwNTc1Mzk4MyAoImRybS9tZWRpYXRlazogU3VwcG9ydCByZWZsZWN0LXkgcGxh
bmUNCj4gPiByb3RhdGlvbiIpDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hp
bm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9kcnYuaCAgICAgICAgfCAgMSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmwuYyAgICAgICAgfCAxOCArKysrKystLS0tLS0tLQ0KPiA+IC0tLS0NCj4gPiAgLi4u
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgICB8ICA5ICsrKysrKysr
Kw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgIHwg
IDEgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jICAgICAg
IHwgIDIgKy0NCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMyBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX2Rydi5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
ZHJ2LmgNCj4gPiBpbmRleCA0ZDZlOGI2NjdiYzMuLmM1YWZlYjdjNTUyNyAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBAQCAtMTI3LDYgKzEy
Nyw3IEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX3JlZ2lzdGVyX3ZibGFua19jYihzdHJ1Y3QNCj4g
PiBkZXZpY2UgKmRldiwgdm9pZCAoKnZibGFua19jYikodm8NCj4gPiAgdm9pZCBtdGtfb3ZsX2Fk
YXB0b3JfdW5yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgdm9p
ZCBtdGtfb3ZsX2FkYXB0b3JfZW5hYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+
ICB2b2lkIG10a19vdmxfYWRhcHRvcl9kaXNhYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYp
Ow0KPiA+ICt1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX3N1cHBvcnRlZF9yb3RhdGlvbnMo
c3RydWN0IGRldmljZQ0KPiA+ICpkZXYpOw0KPiA+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdGFy
dChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdG9wKHN0
cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gIHVuc2lnbmVkIGludCBtdGtfb3ZsX2FkYXB0b3JfbGF5
ZXJfbnIoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBpbmRleCBlY2MzODkzMmZkNDQuLjMxOWJiZmRlNWNmOSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBA
QCAtNDE1LDYgKzQxNSwxMCBAQCB1bnNpZ25lZCBpbnQgbXRrX292bF9sYXllcl9ucihzdHJ1Y3Qg
ZGV2aWNlDQo+ID4gKmRldikNCj4gPiANCj4gPiAgdW5zaWduZWQgaW50IG10a19vdmxfc3VwcG9y
dGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiArCS8qDQo+ID4g
KwkgKiBhbHRob3VnaCBjdXJyZW50bHkgT1ZMIGNhbiBvbmx5IGRvIHJlZmxlY3Rpb24sDQo+ID4g
KwkgKiByZWZsZWN0IHggKyByZWZsZWN0IHkgPSByb3RhdGUgMTgwDQo+ID4gKwkgKi8NCj4gPiAg
CXJldHVybiBEUk1fTU9ERV9ST1RBVEVfMCB8IERSTV9NT0RFX1JPVEFURV8xODAgfA0KPiA+ICAJ
ICAgICAgIERSTV9NT0RFX1JFRkxFQ1RfWCB8IERSTV9NT0RFX1JFRkxFQ1RfWTsNCj4gPiAgfQ0K
PiA+IEBAIC00MjMsMjcgKzQyNywxNyBAQCBpbnQgbXRrX292bF9sYXllcl9jaGVjayhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IGlkeCwNCj4gPiAgCQkJc3RydWN0IG10a19w
bGFuZV9zdGF0ZSAqbXRrX3N0YXRlKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZHJtX3BsYW5lX3N0
YXRlICpzdGF0ZSA9ICZtdGtfc3RhdGUtPmJhc2U7DQo+ID4gLQl1bnNpZ25lZCBpbnQgcm90YXRp
b24gPSAwOw0KPiA+IA0KPiA+IC0Jcm90YXRpb24gPSBkcm1fcm90YXRpb25fc2ltcGxpZnkoc3Rh
dGUtPnJvdGF0aW9uLA0KPiA+IC0JCQkJCSBEUk1fTU9ERV9ST1RBVEVfMCB8DQo+ID4gLQkJCQkJ
IERSTV9NT0RFX1JFRkxFQ1RfWCB8DQo+ID4gLQkJCQkJIERSTV9NT0RFX1JFRkxFQ1RfWSk7DQo+
ID4gLQlyb3RhdGlvbiAmPSB+RFJNX01PREVfUk9UQVRFXzA7DQo+ID4gLQ0KPiA+IC0JLyogV2Ug
Y2FuIG9ubHkgZG8gcmVmbGVjdGlvbiwgbm90IHJvdGF0aW9uICovDQo+ID4gLQlpZiAoKHJvdGF0
aW9uICYgRFJNX01PREVfUk9UQVRFX01BU0spICE9IDApDQo+ID4gKwlpZiAoc3RhdGUtPnJvdGF0
aW9uICYgfm10a19vdmxfc3VwcG9ydGVkX3JvdGF0aW9ucyhkZXYpKQ0KPiA+ICAJCXJldHVybiAt
RUlOVkFMOw0KPiANCj4gVGhlIGNvbW1pdCBtZXNzYWdlIG9mIHRoaXMgcGF0Y2ggaXMgIkNyZWF0
ZSByb3RhdGlvbiBwcm9wZXJ0eQ0KPiBhY2NvcmRpbmcNCj4gdG8gdGhlIGhhcmR3YXJlIGNhcGFi
aWxpdHkiLiBJIHRoaW5rIHRoaXMgbW9kaWZpY2F0aW9uIGlzIG5vdCByZWxhdGVkDQo+IHRvIGNy
ZWF0ZSBwcm9wZXJ0eSwgc28gc2VwYXJhdGUgdGhpcyB0byBhbm90aGVyIHBhdGNoLg0KDQpTaW5j
ZSB0aGVzZSBtb2RpZmljYXRpb25zIGFyZSBhbGwgcmVsYXRlZCB0byByb3RhdGlvbiBwcm9wZXJ0
eSwgb3INCnNob3VsZCBJIGNoYW5nZSB0aGUgdGl0bGUgYW5kIGNvbW1pdCBtZXNzYWdlIHRvICJN
b2RpZnkgcm9hdGlvbg0KcHJvcGVydHkgZm9yIHBhc3NpbmcgSUdUIj8NCg0KPiANCj4gPiANCj4g
PiAgCS8qDQo+ID4gIAkgKiBUT0RPOiBSb3RhdGluZy9yZWZsZWN0aW5nIFlVViBidWZmZXJzIGlz
IG5vdCBzdXBwb3J0ZWQgYXQNCj4gPiB0aGlzIHRpbWUuDQo+ID4gIAkgKgkgT25seSBSR0JbQVhd
IHZhcmlhbnRzIGFyZSBzdXBwb3J0ZWQuDQo+ID4gIAkgKi8NCj4gPiAtCWlmIChzdGF0ZS0+ZmIt
PmZvcm1hdC0+aXNfeXV2ICYmIHJvdGF0aW9uICE9IDApDQo+ID4gKwlpZiAoc3RhdGUtPmZiLT5m
b3JtYXQtPmlzX3l1diAmJiAoc3RhdGUtPnJvdGF0aW9uICYNCj4gPiB+RFJNX01PREVfUk9UQVRF
XzApKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+IA0KPiA+IC0Jc3RhdGUtPnJvdGF0aW9u
ID0gcm90YXRpb247DQo+ID4gLQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9y
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5j
DQo+ID4gaW5kZXggNDM5OGRiOWE2Mjc2Li4yNzNjNzlkMzdiZWYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiA+IEBA
IC0zODMsNiArMzgzLDE1IEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX3JlZ2lzdGVyX3ZibGFua19j
YihzdHJ1Y3QNCj4gPiBkZXZpY2UgKmRldiwgdm9pZCAoKnZibGFua19jYikodm8NCj4gPiAgCQkJ
CSAgICAgdmJsYW5rX2NiLCB2YmxhbmtfY2JfZGF0YSk7DQo+ID4gIH0NCj4gPiANCj4gPiArdW5z
aWduZWQgaW50IG10a19vdmxfYWRhcHRvcl9zdXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBkZXZp
Y2UNCj4gPiAqZGV2KQ0KPiA+ICt7DQo+ID4gKwkvKg0KPiA+ICsJICogc2hvdWxkIHN0aWxsIHJl
dHVybiBEUk1fTU9ERV9ST1RBVEVfMCBpZiByb3RhdGlvbiBpcyBub3QNCj4gPiBzdXBwb3J0ZWQs
DQo+ID4gKwkgKiBvciBJR1Qgd2lsbCBmYWlsLg0KPiA+ICsJICovDQo+ID4gKwlyZXR1cm4gRFJN
X01PREVfUk9UQVRFXzA7DQo+ID4gK30NCj4gPiArDQo+ID4gIHZvaWQgbXRrX292bF9hZGFwdG9y
X3VucmVnaXN0ZXJfdmJsYW5rX2NiKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgew0KPiA+ICAJ
c3RydWN0IG10a19kaXNwX292bF9hZGFwdG9yICpvdmxfYWRhcHRvciA9DQo+ID4gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmMNCj4gPiBpbmRleCBmZmE0ODY4YjEyMjIuLjIwNmRkNmY2Zjk5ZSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+
IEBAIC00MjIsNiArNDIyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVu
Y3MNCj4gPiBkZHBfb3ZsX2FkYXB0b3IgPSB7DQo+ID4gIAkucmVtb3ZlID0gbXRrX292bF9hZGFw
dG9yX3JlbW92ZV9jb21wLA0KPiA+ICAJLmdldF9mb3JtYXRzID0gbXRrX292bF9hZGFwdG9yX2dl
dF9mb3JtYXRzLA0KPiA+ICAJLmdldF9udW1fZm9ybWF0cyA9IG10a19vdmxfYWRhcHRvcl9nZXRf
bnVtX2Zvcm1hdHMsDQo+ID4gKwkuc3VwcG9ydGVkX3JvdGF0aW9ucyA9IG10a19vdmxfYWRhcHRv
cl9zdXBwb3J0ZWRfcm90YXRpb25zLA0KPiA+ICB9Ow0KPiA+IA0KPiA+ICBzdGF0aWMgY29uc3Qg
Y2hhciAqIGNvbnN0IG10a19kZHBfY29tcF9zdGVtW01US19ERFBfQ09NUF9UWVBFX01BWF0NCj4g
PiA9DQo+ID4gew0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9wbGFuZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFu
ZS5jDQo+ID4gaW5kZXggZTJlYzYxYjY5NjE4Li44OTRjMzlhMzhhNTggMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gPiBAQCAtMzQ0LDcgKzM0
NCw3IEBAIGludCBtdGtfcGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiA+IHN0
cnVjdA0KPiA+IGRybV9wbGFuZSAqcGxhbmUsDQo+ID4gIAkJcmV0dXJuIGVycjsNCj4gPiAgCX0N
Cj4gPiANCj4gPiAtCWlmIChzdXBwb3J0ZWRfcm90YXRpb25zICYgfkRSTV9NT0RFX1JPVEFURV8w
KSB7DQo+ID4gKwlpZiAoc3VwcG9ydGVkX3JvdGF0aW9ucykgew0KPiANCj4gV2h5IG5lZWQgdGhp
cyBtb2RpZmljYXRpb24/DQo+IEJlZm9yZSBTZWFuJ3MgcGF0Y2ggWzFdLCBvbmx5IHN1cHBvcnQg
cm90YXRlIDAgYW5kIGRvZXMgbm90IGNyZWF0ZQ0KPiBwcm9wZXJ0eSBhbmQgaXQgd29ya3MuIFdo
eSBkb2VzIGl0IG11c3QgY3JlYXRlIHByb3BlcnR5IGZvciBvbmx5DQo+IHN1cHBvcnQgcm90YXRl
IDA/DQoNClllcywgYXMgbG9uZyBhcyB0aGUgdXNlciBkb2Vzbid0IGNoZWNrIHJvdGF0aW9uIHBy
b3BlcnRpZXMgYmVmb3JlDQpjb21taXRpbmcgdGhlIHBpdHVyZXMsIHRoZXJlIHdpbGwgYmUgbm8g
cHJvYmxlbS4gQnV0IElHVCBzb21laG93DQpjaGVja2VkIHRoaXMgRFJNX01PREVfUk9UQVRFXzAg
ZmxhZyBiZWZvcmUgZXhlY3V0aW5nIHRoZSB0ZXN0cyAobm90IGFsbA0Kb2YgdGhlbSksIGFuZCBs
ZWFkcyB0byBmYWlsdXJlcyBpbiB0aGVzZSB0ZXN0IGl0bWVzLg0KDQo+IA0KPiANCj4gWzFdIA0K
PiANCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC9jb21taXQvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxh
bmUuYz9oPXY2LjctcmM2JmlkPWVmODdkM2UyZGQyNTEzNzRjNWM5ZmEzYjY1MDJhZWZmOGZlMjlk
YTkNCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiA+ICAJCWVyciA9IGRybV9wbGFuZV9jcmVh
dGVfcm90YXRpb25fcHJvcGVydHkocGxhbmUsDQo+ID4gIAkJCQkJCQkgRFJNX01PREVfUk9UQVQN
Cj4gPiBFXzAsDQo+ID4gIAkJCQkJCQkgc3VwcG9ydGVkX3JvdGENCj4gPiB0aW9ucyk7DQo+ID4g
LS0NCj4gPiAyLjM5LjINCj4gPiANCg0KVGhhbmtzLA0KU2hhd24NCg==

