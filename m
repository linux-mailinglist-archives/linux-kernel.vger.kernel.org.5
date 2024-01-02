Return-Path: <linux-kernel+bounces-14077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1BC8217A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E30EB21655
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963771858;
	Tue,  2 Jan 2024 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aCAavia0";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cz3j+HU7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635915A1;
	Tue,  2 Jan 2024 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 05570b0aa93611eea2298b7352fd921d-20240102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=O4s3m93yiGHDTN63zIaPe5M1ZkIo08X3ZN4YoBZYphs=;
	b=aCAavia0uhdcln0vUgsRiJe1Xi+DhmxEiwYlUj0Nfc5C72aWf5kEthqZH+PLakZ6Y2PzPqXXHvou5deA8wbaHW7VpJEpL0Ui6iJ8rbk7Ju086lWeOmUiLoPU2VRAhYusun54Z45r5iqvtjx7uGpwX1BhA0X/cHqG1c0M0oxMh1g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e724aa01-b3ea-40a3-b90b-88d02404acd7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:0f2a6482-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 05570b0aa93611eea2298b7352fd921d-20240102
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1716244224; Tue, 02 Jan 2024 14:13:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jan 2024 14:13:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jan 2024 14:13:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mStvK5yybKcf6CXSjoN8dvplZSY1Sjbx9uyRM/IXZVQq2TcxKiwD8OjrjlWAi0VzSRHbV+uglyCZzEqa2KYViN0k5lIZVeiH1Hr3y+z3vgCK6lGYinUKkBBpiYaUw5jMpV6pb93bCPSuEqMv+LWHikGwDiREfQt9SUVyOXlgnJ7LJOIdO3IDO4Xcu9vFOsL4am3U2jfyQyfhL0GNuy2/py2f2SCpQxGqaVlI3eexldfE9e06ctJ0lOlsK0t75alxGcA6HrffWkA2cgAMobFmIdhRd1Zwm4pVKTZ8xaKJ9BI48UM4+TCugziIV/l/DvsAIulBaCtp61BvU9A7fzEF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4s3m93yiGHDTN63zIaPe5M1ZkIo08X3ZN4YoBZYphs=;
 b=JjOQFaLDcIRmLdf8jTh2IoG6s2hTNSmPSuV7f3fhoxyJXHIPyc2emSxV/y/588ukDgZMQJzfDeunFMoPQ48EO4FKA5mFtjbNcffoTcP9wpWMG37DS94IsBLYoOifyooYnIKVRRs8xV5GzJSBxak1qsopXhFWyMKumIu+4gY5jkTuLCSDPBtKcs1L47HZEme/Gz0Jx97q/wRJuhGp6AOplM4fBSkqKiNchEnKXHrh9DhD4vNXBqDhEFF9HaIWBkc7NwVSwDh82DWX0S7V+FgWRp5CdEDNiLy9CV8nI1DfQ30p9a0SlEmUtSxr/kcMw9kGOP4Awr0qNii57BhbQcjL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4s3m93yiGHDTN63zIaPe5M1ZkIo08X3ZN4YoBZYphs=;
 b=cz3j+HU7usX5sO9FCJOSMrpIFphMcnb9vJF5TCwFYN/SAUkOBNzgARWc4WG5SGhLyHVHG2DOu5R/K7hTFnAmPmjb4F/dgJPRe63yU2bdOITsD5RnR1QsLYwfIUNmEwxXzWW3nD3iAB9cMaEtMfa6A0zKQjU8WNW2nwXZyFcdLV0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB7044.apcprd03.prod.outlook.com (2603:1096:301:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 06:13:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 06:13:12 +0000
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
Subject: Re: [PATCH v4 08/17] drm/mediatek: Support alpha blending in display
 driver
Thread-Topic: [PATCH v4 08/17] drm/mediatek: Support alpha blending in display
 driver
Thread-Index: AQHaLPWa6N55KhGZh0qGR9cV5awFLbDGK5qA
Date: Tue, 2 Jan 2024 06:13:12 +0000
Message-ID: <f53e0738de630c196e4cf37e18cbd3ef2c3aac26.camel@mediatek.com>
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
	 <20231212121957.19231-9-shawn.sung@mediatek.com>
In-Reply-To: <20231212121957.19231-9-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB7044:EE_
x-ms-office365-filtering-correlation-id: 59fedd8d-fbb0-4369-c367-08dc0b59e627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/HTkeo0dqmUHyNRrCRaZrg5/l4lZHNHke88cEKg1SnIAOtADCAh+7SjbLsKknE5DxgS8ixj0GgvZiyuziWuNSOLhmbPMVOhhOS/z4frtKHOH/12rwhmgx1SL+HoWrdvBWDXo7Snj7RCY1svhiLZecrejzcVPA3YLJ3Zdl82kxR0bOx+wkLddl50UO93ysMApKnLZ6PkaOU7MP6vIKs/oEHDLhMkMfFPKl5hFKUREG9y4SNt5Q1H8SNOu+u/IO11g5CWwJsNj+2mX0PggE22h4ouzMMGEZDkVKgV8VU2DnJgH3JMYgXIXqHBcgIbq/ideWwSStjtPpiNzQxiGoKilxUhDYgRK+Y4RoI9CFbaecxnrUpqls8tpOvzA9ZBpdFCkulWCS+1grRPXgLIUMqXimVwW9Hp37gwgYrVPMapOPczmWmCSH0LnpXS/wQRu60F0nJYtGK2gUqC4NWHDWz6VMZBzU3HaBdvEo2jhbCWKMUrjVP5SwOov5gJPSMqw9hllfxGLylCYYuhFX/dAfE47+WbbtQXw/ol2GaeukQqkVOCXCg6wfOv+ddAiwYgLqh4UhQIBYHucTZUjIB6S/m2HCxhD7vYUsR0dUyrCWAJhKKk+uwsNzy01mKjfjrf0vMeSELwWY6JIfxOIOjB5PctUlrFPSY8zNc/tBf3QATKttU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66946007)(76116006)(4326008)(66556008)(66476007)(64756008)(66446008)(478600001)(6486002)(110136005)(8936002)(316002)(54906003)(8676002)(71200400001)(6506007)(6512007)(2616005)(26005)(5660300002)(4001150100001)(2906002)(7416002)(41300700001)(38070700009)(85182001)(36756003)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0tVc1VKeUdENDNrZVlwbnZjaUoweUhRb0gxNUxCQ0FHa2NES0xOMzMzblkv?=
 =?utf-8?B?TFFLOUJUT005dmR3TGFrNHNpYThwdXV6WVVJdkZ3N1hHcXQvWk5QWTJlTTZX?=
 =?utf-8?B?RjdRR0FTM3hEVmtLRGtwTXIzZ293cS9pWTUyOVhpc0NsQXgrRUtXeTBIbHl6?=
 =?utf-8?B?a0FHMDVyZGVrTFZBc3ExS2thUEUxS3pKRG9qR3J2azZIZG9nSXdEU09hbkFw?=
 =?utf-8?B?OS9FbkExcXI2SHFDZ1N6L0FMWlhwS3VwcjNSVXpWOFhzenN2L1BqWVB6dCtM?=
 =?utf-8?B?c1VHbkptU2NEK0ZWNi83Wi82YnlFSHN2QVBOSytEMUhybks0c2M0WUtFQ29I?=
 =?utf-8?B?SSt1aFVJSEdsUUdsZGJPeDZDQTVGYVRCWnFERTVnc1dUdDNHMmR1NUZISnJr?=
 =?utf-8?B?cTFqZDFyVWE1N0h2TDlvaWVBY0NhbG5VaTRsS1J6VnVxMkZXZmVzZ2VsT0R5?=
 =?utf-8?B?bDhzVXQxMUJvM1pZNUdLMk1uMkJqN29aSXc1T2V5MjlkeFFTR2x5SFV0MXNk?=
 =?utf-8?B?L0ZsUFFGV1RLRVVYcWFKa0QrQ2dpazVuemV1ZjNuYjBIZ1llNi9XVVpUZzUw?=
 =?utf-8?B?TENoZk4xOVdEQW5PZzIyQXU2ZUdJTkl0UW5WVndMR3F1aGtpY3hDR1lVQk5L?=
 =?utf-8?B?STVUN0tITk1wYXE0eXAxeEFxdk9GMmE0cDlibEQ0RmxkK0tpK3R6T1FRT0dI?=
 =?utf-8?B?TmhhWmxMUC9IcVc2LzFqTVdiWU9zSmU1Z05zbXZKWGdKSUtIdVpoeG9uTUJy?=
 =?utf-8?B?cFYvYnJqbEczWlg0SnZQcVF6V1M1VlM4KzJnaExlb0xOR1JkQ0JYYmtDc3F0?=
 =?utf-8?B?Z1k5TU51MUQ0U0swOXVHdk5ON1R4cEpaWkJqa05VWWY4b3JIQkNVVmNTaW1M?=
 =?utf-8?B?VVBlVHJUbzlXbXhXUGduYXJ5bW84MWxVYnBjVmJnVHNuaFN6MkJIWk1FcHlS?=
 =?utf-8?B?RHhaR3NzYW9LbmR3WnU3WFdHNG15MUNNaVA5SjRjN09kRGw1SVBOY3pkRFR4?=
 =?utf-8?B?cWU4Q2dSdmlhdVE2U2tKUG9NSDl5WTlHUEpJK2ZXL0t4SitzWmR6dkYzclpn?=
 =?utf-8?B?N3BzU2VaUC9USzc1Vm5OdUg4ZStTU2xOSEJHOGpxZVhLM0wxaWZOajMydENi?=
 =?utf-8?B?WUE0d0NQYmw4K2dTWG1YWUo4Sm55SFoycUdaaS94UHBTT0RRcFZXR2ZPYTMy?=
 =?utf-8?B?T3lxQmwrdzJsWVhGZjFhaXMrRHdJSzhiWXJqcXBza3dqOFMvY04wZzZxQUho?=
 =?utf-8?B?cUtpWlF2NUFseGp2SW9xeU1sRjR0YUZEMVMySGVuUWdNMkhtNHRzY1FPUFJP?=
 =?utf-8?B?SjZ1ZE11L3VTWGJPYjloVnkzcmt2QmxEU0JXdnp1UXpyZ2huYktnVUxCMFFX?=
 =?utf-8?B?emVyVjZ5eURDeTE1ZGgvc2xHYmZzOUF4WWFkSURtQ3RmUHY4ZzVUYXczTkVV?=
 =?utf-8?B?UnRuMlZ4dkQ2ZENoaTFjc3poREZUbFpUR2thN3RZa2lhOWgwTzhVaWdXWFRG?=
 =?utf-8?B?TlZtdmZMQkwxOUgwaXdmM09OY1hvL0IvNXozTXRDWEl6Rk9oYUpUdFRDWERJ?=
 =?utf-8?B?azE1YWFVVHl5TU5DMnp1WHFRMUdTSmtlSlhHYXFkd3Zpb0ZyRXhSWHIwdkF2?=
 =?utf-8?B?QVN2TWtKQkcyNVFxWDQwU2ZYQ2xMTjRwS2g5aDlGNyt0WDFVaU95RjVWTkl3?=
 =?utf-8?B?Z1lHMk9DWFJwMUg1Y0wvc3JiUjA1YndGOFZhbmZyNTlHeXFlUTcrbTN5Y1Y0?=
 =?utf-8?B?QUdUOEhKTjJtQ0JkVkRKd1lNYWM5ZHRGOTk1KzF1WTRBSlhSNlhnT1lRclor?=
 =?utf-8?B?ZUt6R1VYT3EzZTl6T3R3a2tkdDdBSlVxSGI5WitvcHUwcWIwMjZyeWp0RmtR?=
 =?utf-8?B?aHpreG9NU21BYnNTa2YzU1dIZTliYzJHYStTWElmUUEwVFl0OVlOZGxVeFdP?=
 =?utf-8?B?WXFYRXpPR1hiSGd3TG9GVUZUUTBBeklkYmZlOWltVkJ2SEltb0hLK0FaME83?=
 =?utf-8?B?ekRTN0QxYVBubnVkK3R6bDlCQWovc3pMMFZHMmcrajZRVDBHcUFaUU4za2d3?=
 =?utf-8?B?dG1LMnN6VVQ1QXlRK1ZtbFVNRGdBSm9jOUJ6ZDVZeUZ2M2Z1bDBsbCtzOW41?=
 =?utf-8?Q?NeC8+ppajuea4wyopHMy52EvR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DD3A1774C8BA44DA659A5AF8484958D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fedd8d-fbb0-4369-c367-08dc0b59e627
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 06:13:12.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPZcSU388pKGPxlgBDuxEBYwhExJ9Abuvb0ebOJgkz7GC/6AF4FWk47SG0oqMkMnZzyK7cuke5VGpvwYlufr1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7044
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.521300-8.000000
X-TMASE-MatchedRID: wQVy7q402w0/XHdICuW5rya1MaKuob8PC/ExpXrHizwE6M1YtcX6vHkX
	3+3gSeXPKsiucgwl76qyXQ+vh/zqYiUtdpGicV4RA9lly13c/gEK3n1SHen81RL6MU7t349bKBD
	u9B2tQknG/k2zFq8ZNJGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPIfiAqrjYtFiR8I2
	h9HpBHLTPPZtPs1KMGb2DRDMWOr5W3xEN9Ocrpdn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.521300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4D011D4F0F17E3B7FC171FDCB1A6A10497A75C0059D80A154BDBAAF4E5811F8C2000:8

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUdWUsIDIwMjMtMTItMTIgYXQgMjA6MTkgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFN1cHBvcnQgYWxwaGEgYmxlbmRpbmcgYnkgYWRkaW5n
IGNvcnJlY3QgYmxlbmQgbW9kZSBhbmQNCj4gYWxwaGEgcHJvcGVydHkgaW4gcGxhbmUgaW5pdGlh
bGl6YXRpb24uDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVr
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5j
IHwgMTEgKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gaW5kZXgg
OTIwOGYwM2IzZjhjLi5kZmQ4MTE3MmE5NDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fcGxhbmUuYw0KPiBAQCAtMzQ5LDYgKzM0OSwxNyBAQCBpbnQgbXRrX3BsYW5l
X2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gc3RydWN0IGRybV9wbGFuZSAqcGxhbmUs
DQo+ICAJCQlEUk1fSU5GTygiQ3JlYXRlIHJvdGF0aW9uIHByb3BlcnR5IGZhaWxlZFxuIik7DQo+
ICAJfQ0KPiAgDQo+ICsJZXJyID0gZHJtX3BsYW5lX2NyZWF0ZV9hbHBoYV9wcm9wZXJ0eShwbGFu
ZSk7DQo+ICsJaWYgKGVycikNCj4gKwkJRFJNX0VSUk9SKCJmYWlsZWQgdG8gY3JlYXRlIHByb3Bl
cnR5OiBhbHBoYVxuIik7DQo+ICsNCj4gKwllcnIgPSBkcm1fcGxhbmVfY3JlYXRlX2JsZW5kX21v
ZGVfcHJvcGVydHkocGxhbmUsDQo+ICsJCQkJCQkgICBCSVQoRFJNX01PREVfQkxFTkRfUA0KPiBS
RU1VTFRJKSB8DQo+ICsJCQkJCQkgICBCSVQoRFJNX01PREVfQkxFTkRfQw0KPiBPVkVSQUdFKSB8
DQo+ICsJCQkJCQkgICBCSVQoRFJNX01PREVfQkxFTkRfUA0KPiBJWEVMX05PTkUpKTsNCj4gKwlp
ZiAoZXJyKQ0KPiArCQlEUk1fRVJST1IoImZhaWxlZCB0byBjcmVhdGUgcHJvcGVydHk6IGJsZW5k
X21vZGVcbiIpOw0KPiArDQo+ICAJZHJtX3BsYW5lX2hlbHBlcl9hZGQocGxhbmUsICZtdGtfcGxh
bmVfaGVscGVyX2Z1bmNzKTsNCj4gIA0KPiAgCXJldHVybiAwOw0K

