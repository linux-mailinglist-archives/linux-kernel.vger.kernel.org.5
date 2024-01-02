Return-Path: <linux-kernel+bounces-14066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F2B821787
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198AB2811D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FBD15D0;
	Tue,  2 Jan 2024 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VdkzDmET";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="b+WUycUE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9E15BD;
	Tue,  2 Jan 2024 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 66380094a93311ee9e680517dc993faa-20240102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Mw6m3a18+2d2ka1BMXSWvvrL+q75JR8+ejkOWTONKdU=;
	b=VdkzDmETuoRA8B9SY0AQViKklr68uZ2eAznFfQKCrfZE+Hog4IlN3+JJsQaUSBz8+/5mne4kylbeHbNo8DYT1jkQ3kMZCyOOUYKyHLAsGMmFcfl9k+W35yUZZGd0ZaE/U25XC2ybO5qJjt0G/UtkTHtRT2Dx+Q2c5D/yJEqBxvo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:03fc3e87-85a7-4631-a62d-a789c7849bbd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:6935b52e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 66380094a93311ee9e680517dc993faa-20240102
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1272589656; Tue, 02 Jan 2024 13:54:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jan 2024 13:54:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jan 2024 13:54:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlJtMnHs71hOy77NAh+WR7CSpmOy0IKklP4K6VYpLv0It+4QeZkr+FemhsVr5RTdbyKTJoTyo7HSNg6M2V3e/JwauwGJiDRg9ZrzwcHBGmtAu0LUdJK4+MjZ40xH0AorU4IiIKCgv8LJLr5o21dWpzK4SpP4lFpPat5AKQKF0EWi4IonDX4lhMkxXhmlqlkmxbxZGOUq8JjnzMJYQ1crc+xqvPy8ydTjcvsUkRHcHnF+8n0hm4YQVcNoEuTAPXMiSuhF7x2ldMWkkUsMkVsdbxl/b3emfU2S5VMvaV+dnsAu3mFQ7XXLrQqis2ZNuczMYgPoaWMLnsHnZ59w63phcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw6m3a18+2d2ka1BMXSWvvrL+q75JR8+ejkOWTONKdU=;
 b=OyA+2wWvkeMAUEAnyx+YEXh6DP48PLzjAhQ0rTcIerz98cWKdsDJ5DQRdjFZtvKSPetljuz/rYpHmNM5epnvDkk66Rwc0CpqXuTbnnOaCF2Ib9tjxMTfg3qlcwSS3EUiSVrMfC/1h8J7fWS3udIdiz0Z4mtivMEEMRlyDehQB0SN2mexGbPwbFTkJ4aMRPy50C16DfaRzx2GXqjvcDFgc76lJt/o54S7Vg9CXi4E6TtYBLI4fUDuhkvZ2m83cmjmlxy4dN9AN+8hUzoRtDbQWxcI2TIp0XQpyo9MsCtJ6eY4KhWoJbfZQWVIdwIYg3Yi6uakhZyyNTjOjXOHqMOMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw6m3a18+2d2ka1BMXSWvvrL+q75JR8+ejkOWTONKdU=;
 b=b+WUycUEss1TeQ3/Nt3rmEZRE6sYoCBBswA4esi2kTahWD/pDaw0VdzKFwJaKzpWb2o1BhJqW3iphZUQRc1j+EkIqKLrEVRbOXYG1d9m/TtHy087geWagMt6bQlUEDo+mR1yVCHEGGE5VN1tI3FR9Z4Q7n8OqXoOHOx1pIHQCKc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB7044.apcprd03.prod.outlook.com (2603:1096:301:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 05:54:28 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:54:28 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "fshao@chromium.org"
	<fshao@chromium.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 07/17] drm/mediatek: Support alpha blending in Mixer
Thread-Topic: [PATCH v4 07/17] drm/mediatek: Support alpha blending in Mixer
Thread-Index: AQHaLPWYkhIJC4S2PEKigSfpYC5DJbDGJl6A
Date: Tue, 2 Jan 2024 05:54:28 +0000
Message-ID: <798cd6955390140cff2ae24ec9cae11cc7ae6a44.camel@mediatek.com>
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
	 <20231212121957.19231-8-shawn.sung@mediatek.com>
In-Reply-To: <20231212121957.19231-8-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB7044:EE_
x-ms-office365-filtering-correlation-id: e81b86d6-d2ec-4aac-badb-08dc0b57485b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PM8Ujn5VCWT/Y+VWT9u5POqmSk1od4MkwlHK/kseraAkJKEzc4t+lQxCJKW0dH+w1yeghvBCpM95qsdM2bQaTc1aCx+XP2hhn0CBTevEbXFQCRtBuzybWeS0WHKuCMd5fv0Qlw2xaKr0FM1n5+TjOOAeAXGKXscIO9x5GfMIyD9AquPRwTJSAi3omJG1z5P4NrlprfA3VFEbqJLMi0agf99GV1ncsJxdQRhODlYEMnCqUiQyOM5fC7iAYKPFVKfwPGbljydgqLTGByw6oYUzkT2KU4cAA4CLoOh0GLuqK+KY1ZteYt3GpGzUyO2hcX5JWfuT1xfvVXOXbfOaGsGoAASB47KK3TK7ZqermNQosDqM/q9U0pe5TCQHlBxEVbLHzQN4SbbirSUZjFWY+CByZc9T2HfIH82YHcdES9ImdS7qM8ChA+RgI7UongR2HzxsO43bpTHWz839qaKZtexkxCs9k0b/g0RX3UpZtQy6fmTTJnfWPOPcUF42ctu3S00QOfnTMco0Sryd3/iglecnqmLtkpLcFLLfkTWHYrclnz+Ac+0fABBXHJJZug21Dy4kFdWFhGysbhprfOLZZDOnTPbwvZqgsSHomyTnJQ4SUrcyDJ7bU4QpaCyRF4ZqmTJOt7Ysv6z78VyAp498ziVpI70EoXwQc1m3f3jrZPcu/Nw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(122000001)(38070700009)(85182001)(36756003)(86362001)(26005)(2616005)(6512007)(6506007)(71200400001)(64756008)(66446008)(478600001)(316002)(8676002)(54906003)(6486002)(8936002)(110136005)(76116006)(66946007)(66556008)(66476007)(4326008)(83380400001)(41300700001)(5660300002)(7416002)(2906002)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDhHc2FTYWV3V0lkeW1kVzJUbkpNQjJNdUcvZmtneEc0clV1VUdYR2FQbHZq?=
 =?utf-8?B?UUkyR0k5OUp6eGJidWQ0TGdIUWxBUWYzNnJSTkJBREgxbGJYUHcyMDUwWHVW?=
 =?utf-8?B?eGhlZmJjRUpMYnBFT3VhV3pwSkl2a2Y4Nnd2OG1hN28wSDl3NEVwRDlVN21Q?=
 =?utf-8?B?cjNTWU1mYTY5d2I3aGxwQkVIZ3ViUkNmTytRMWtWSlRpdndFY292Z0VwWnFj?=
 =?utf-8?B?cHJXMHFzUUpzbkd3b1didTE1cGhrc0wwNUthUW9MV0NHSllJcFM0NTZvN21R?=
 =?utf-8?B?QTVxK1VveTQ3Y2Jaall5QkxuRFMvK25NQ2Vxd2xKSWhRR2xLejZSVlM5TTNH?=
 =?utf-8?B?SjVkZU91bzRKa0pwRmw1UTc3bHNESE1WZjY4YW9CMnhnY1JYT204ZURyL3JS?=
 =?utf-8?B?YW1JN3lBVXdqMkdiTHdyS1ExOUFCdXk5bW5nRWo0TlNrNnhuNDRRTTRJRk5U?=
 =?utf-8?B?Q3V6NW42eEU5V001azhVNzM0T3lUN0hpVm1CSTJrMy9XdzJBRmNtd25iTGlt?=
 =?utf-8?B?QUh1Rmt1eVJ1Z0ZOZHZkTzZrTmNTYTkwUlJpSitCQzVhbUZlR2J5dkZUZ3hO?=
 =?utf-8?B?emRkYlI3VXpaWDhoWXFXV0RRSFg1VVVhTmZBYzExRCtYVTdPREpPRS8remtv?=
 =?utf-8?B?bDVvLzVRdG9SbXFFZVJuRTR5MnhOR2J5VlYrVzhoaXlBU09XMXIyQnZBVStU?=
 =?utf-8?B?QmlXSWdkNUhwdmNhWUJIeWorMVRMWUd0eEhuQnpkNHNBUm5PVUh2ZXlRNGZh?=
 =?utf-8?B?MklZUERaT2ZOcXBoRVUxdHd1aExydEdjQjR5Slk5blRacTEwbks0STd6Q0J1?=
 =?utf-8?B?d0RJYTVyWUc0QWJnVXlkZDI2Um1pdzFPYkwxMUF2a3ZJL1RQQ0pRWi9GNGxw?=
 =?utf-8?B?Y1gyKzJaaEhBRC92MnEvYkxBdnBsT3gyL0I1TjdOd21kczFmamdIUkpFSTcr?=
 =?utf-8?B?UDFMbjdCd3dwWlEyY1dwL3RqNmxmS081MTJPWDdEcDRqR0lENGhVSThnQktx?=
 =?utf-8?B?ZU1JMUNBUHZiMndVRXNNeU8wL2d6bWJ3OThDd01mdGNsc0swSEN5UkIrc3Vi?=
 =?utf-8?B?RGxwbUNWN2hHSEtvamVSSXMxTnRUV0tYOTNBYlVkQXVXUHkrUnN2YTcrcjdH?=
 =?utf-8?B?MWtSTlI0MW1jN2kraXhONFNydzZEKzZ4dWt5NHUzRjZCdHN3U2JVOTM2RDJF?=
 =?utf-8?B?L1ZENlAvb3ZPalY2WW9UdThZTE5xTklwaC9oazNEc0dCc0ljV29xaEZncGUx?=
 =?utf-8?B?anVsZnc2Y2dPK0RWQk41TS9HZHIrdzYycnlWait3T0JhUGNFZ0dldnNmS2FD?=
 =?utf-8?B?UldpaSsxT1BMN3JxakJ3OVhJMFYyb1NwR2hkOGhSYTVBemdUY292dmxCRDhq?=
 =?utf-8?B?OHNlK2tFcnprV1l2TlpLZ08xOEpjalcyb0NhRkcrOHM2c3FwT2t1VzJRNU5F?=
 =?utf-8?B?SkwyS3VRQldJazBlZHNjYndQTDY5bnNYSlYvRXp3cDdCTXFFeHV6U0JVWmFU?=
 =?utf-8?B?ZVNsMC9pMWhCMGlTOFB0b1BZQ0xDd0svbU1tTUNNVlUycXRheXJYVUZMZlYw?=
 =?utf-8?B?cU5nTWxhZCt6b0gzVE1iYy9ENktkR2I0RitBLzI0NnJ0OFg1TVdUT0FZcTYy?=
 =?utf-8?B?dmR6MHhVUkZ6Qk1xRjNyUXJGdExLVGFjMjBRdkIrcnY4RUJhUXJQSGxKYTZo?=
 =?utf-8?B?Tk9OSyt6Tk9Ib0Y5Y0xQemhyeTVqeGYyb2hFa21TaUptaXV5Y3pwSS9ZdFlh?=
 =?utf-8?B?eUtMd1BpNmRsRk1EWHF5dDk3UzM2OFRjUXNBY0ROTUM5bVNXZE9oRHgwNXRX?=
 =?utf-8?B?eWFuM1dRWXVpZjA1Y3NQaWRBWE5EbVdmVDdnL29ZdzcydWw5YXZhb3RhNHVx?=
 =?utf-8?B?czNyN3JNNWZoWm1LOWlxZFArRUZ2SXpXYTJHWGY4amYxc2pIMjdJTWFpeUFt?=
 =?utf-8?B?V1pTQzNQU2wzQTErN0g0KytmR0NYWFpxNWVRdWp4YUpBOGczNGZWWkxUSEtZ?=
 =?utf-8?B?MkdTUjRKSGM0S0x5ajUrTW5uMFU3c251MFBxalU5dUtaMG5IbTBCVzRHUnJJ?=
 =?utf-8?B?V1VhUGQ1Zk1uQmNMNDlQbFVweWl4VHFRTXJYT3htU3VXdnM2MTR2bXA1MSt3?=
 =?utf-8?Q?yp8eiXFejFbJ5TUiso1tNfIg5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35D112C445A9A74EBF93EBA403B9887E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81b86d6-d2ec-4aac-badb-08dc0b57485b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 05:54:28.3460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksBgNU1tvs3ThZhco4hWjkL/YH2GeR4eBomJtWnflOqnnmVEULxy8Cs+/jWf8b06hvOF3r587JYVHcHvjZRTQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7044

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUdWUsIDIwMjMtMTItMTIgYXQgMjA6MTkgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFN1cHBvcnQgcHJlbXVsdGlwbHkgYW5kIGNvdmVyYWdl
IGFscGhhIGJsZW5kaW5nIGluDQo+IE1peGVyLg0KDQpEZXNjcmliZSB3aGF0IGtpbmQgb2YgYWxw
aGEgYmxlbmRpbmcgYWxyZWFkeSBzdXBwb3J0IGZvciBjdXJzb3IgcGxhbmUuDQpBbmQgc2VwYXJh
dGUgcHJlbXVsdGlwbHkgYWxwaGEgYW5kIGNvdmVyYWdlIGFscGhhIHRvIHR3byBwYXRjaGVzLg0K
DQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8
c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19ldGhkci5jIHwgMjYgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiBpbmRleCA3M2RjNGRhM2JhM2IuLjczYzll
M2RhNTZhNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhk
ci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiBAQCAt
NSw2ICs1LDcgQEANCj4gIA0KPiAgI2luY2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+ICAjaW5j
bHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiArI2luY2x1ZGUgPGRybS9kcm1fYmxlbmQu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jb21wb25l
bnQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gQEAgLTM1LDYgKzM2LDcg
QEANCj4gICNkZWZpbmUgTUlYX1NSQ19MMF9FTgkJCQlCSVQoMCkNCj4gICNkZWZpbmUgTUlYX0xf
U1JDX0NPTihuKQkJKDB4MjggKyAweDE4ICogKG4pKQ0KPiAgI2RlZmluZSBOT05fUFJFTVVMVElf
U09VUkNFCQkJKDIgPDwgMTIpDQo+ICsjZGVmaW5lIFBSRU1VTFRJX1NPVVJDRQkJCQkoMyA8PCAx
MikNCj4gICNkZWZpbmUgTUlYX0xfU1JDX1NJWkUobikJCSgweDMwICsgMHgxOCAqIChuKSkNCj4g
ICNkZWZpbmUgTUlYX0xfU1JDX09GRlNFVChuKQkJKDB4MzQgKyAweDE4ICogKG4pKQ0KPiAgI2Rl
ZmluZSBNSVhfRlVOQ19EQ00wCQkJMHgxMjANCj4gQEAgLTE1Myw3ICsxNTUsOCBAQCB2b2lkIG10
a19ldGhkcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQg
aWR4LA0KPiAgCXN0cnVjdCBtdGtfcGxhbmVfcGVuZGluZ19zdGF0ZSAqcGVuZGluZyA9ICZzdGF0
ZS0+cGVuZGluZzsNCj4gIAl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gKHBlbmRpbmctPnggJiAxKSA8
PCAzMSB8IHBlbmRpbmctPnkgPDwgMTYNCj4gfCBwZW5kaW5nLT54Ow0KPiAgCXVuc2lnbmVkIGlu
dCBhbGlnbl93aWR0aCA9IEFMSUdOX0RPV04ocGVuZGluZy0+d2lkdGgsIDIpOw0KPiAtCXVuc2ln
bmVkIGludCBhbHBoYV9jb24gPSAwOw0KPiArCXVuc2lnbmVkIGludCBtaXhfY29uID0gTk9OX1BS
RU1VTFRJX1NPVVJDRTsNCj4gKwlib29sIHJlcGxhY2Vfc3JjX2EgPSBmYWxzZTsNCj4gIA0KPiAg
CWRldl9kYmcoZGV2LCAiJXMrIGlkeDolZCIsIF9fZnVuY19fLCBpZHgpOw0KPiAgDQo+IEBAIC0x
NjUsMTkgKzE2OCwyOCBAQCB2b2lkIG10a19ldGhkcl9sYXllcl9jb25maWcoc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+
IC0JaWYgKHN0YXRlLT5iYXNlLmZiICYmIHN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBo
YSkNCj4gLQkJYWxwaGFfY29uID0gTUlYRVJfQUxQSEFfQUVOIHwgTUlYRVJfQUxQSEE7DQo+ICsJ
bWl4X2NvbiB8PSBNSVhFUl9BTFBIQV9BRU4gfCAoc3RhdGUtPmJhc2UuYWxwaGEgJiBNSVhFUl9B
TFBIQSk7DQo+ICANCj4gLQltdGtfbW1zeXNfbWl4ZXJfaW5fY29uZmlnKHByaXYtPm1tc3lzX2Rl
diwgaWR4ICsgMSwgYWxwaGFfY29uID8NCj4gZmFsc2UgOiB0cnVlLA0KPiAtCQkJCSAgREVGQVVM
VF85QklUX0FMUEhBLA0KPiArCWlmIChzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9tb2RlICE9IERS
TV9NT0RFX0JMRU5EX0NPVkVSQUdFKQ0KPiArCQltaXhfY29uIHw9IFBSRU1VTFRJX1NPVVJDRTsN
Cj4gKw0KPiArCWlmIChzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9tb2RlID09IERSTV9NT0RFX0JM
RU5EX1BJWEVMX05PTkUNCj4gfHwNCj4gKwkgICAgKHN0YXRlLT5iYXNlLmZiICYmICFzdGF0ZS0+
YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpKSB7DQo+ICsJCS8qDQo+ICsJCSAqIE1peGVyIGRv
ZXNuJ3Qgc3VwcG9ydCBDT05TVF9CTEQgbW9kZSwNCj4gKwkJICogdXNlIGEgdHJpY2sgdG8gbWFr
ZSB0aGUgb3V0cHV0IGVxdWl2YWxlbnQNCj4gKwkJICovDQo+ICsJCXJlcGxhY2Vfc3JjX2EgPSB0
cnVlOw0KPiArCX0NCj4gKw0KPiArCW10a19tbXN5c19taXhlcl9pbl9jb25maWcocHJpdi0+bW1z
eXNfZGV2LCBpZHggKyAxLA0KPiByZXBsYWNlX3NyY19hLCBNSVhFUl9BTFBIQSwNCj4gIAkJCQkg
IHBlbmRpbmctPnggJiAxID8NCj4gTUlYRVJfSU5YX01PREVfRVZFTl9FWFRFTkQgOg0KPiAgCQkJ
CSAgTUlYRVJfSU5YX01PREVfQllQQVNTLCBhbGlnbl93aWR0aCAvDQo+IDIgLSAxLCBjbWRxX3Br
dCk7DQo+ICANCj4gIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBwZW5kaW5nLT5oZWlnaHQgPDwg
MTYgfCBhbGlnbl93aWR0aCwNCj4gJm1peGVyLT5jbWRxX2Jhc2UsDQo+ICAJCSAgICAgIG1peGVy
LT5yZWdzLCBNSVhfTF9TUkNfU0laRShpZHgpKTsNCj4gIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0
LCBvZmZzZXQsICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0+cmVncywgDQo+IE1JWF9MX1NSQ19P
RkZTRVQoaWR4KSk7DQo+IC0JbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBhbHBoYV9jb24s
ICZtaXhlci0+Y21kcV9iYXNlLA0KPiBtaXhlci0+cmVncywgTUlYX0xfU1JDX0NPTihpZHgpLA0K
PiAtCQkJICAgMHgxZmYpOw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIG1peF9jb24sICZt
aXhlci0+Y21kcV9iYXNlLCBtaXhlci0NCj4gPnJlZ3MsIE1JWF9MX1NSQ19DT04oaWR4KSk7DQo+
ICAJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBCSVQoaWR4KSwgJm1peGVyLT5jbWRxX2Jh
c2UsDQo+IG1peGVyLT5yZWdzLCBNSVhfU1JDX0NPTiwNCj4gIAkJCSAgIEJJVChpZHgpKTsNCj4g
IH0NCg==

