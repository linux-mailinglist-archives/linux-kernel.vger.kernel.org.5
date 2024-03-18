Return-Path: <linux-kernel+bounces-105788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2D87E479
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A2C1F216F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF224B33;
	Mon, 18 Mar 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aNhOGr8F"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC67241E1;
	Mon, 18 Mar 2024 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748502; cv=fail; b=BQnMc85LvErFbw1WOOO6VTJHiMm10luKuL09yOdmwcWvRDqWm6FrYdMZ+9cK86N4TUDGxYcYasHc1Wpot7CzTC4Lz0LQRIWfIBcH9MYICqEt+aqS1Nbx78xab5rKbCf1EcHf63uXsEjhFRIb8m7DHt+sofwbsJoY4YRC8lzl3UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748502; c=relaxed/simple;
	bh=kY8R8USyPHKmlCAGWCw0iHlR0xyJhiTQXsfH2gdnBDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nJZ1LWfXjat6BNDGdBRTJrcc2vP7ayTzkdTAg1zPz1TW0shYBGP7UW7W9knV3XSIpIdGHrlu02IkvmRz11rO0thnUCy3Z1sCQFb5cwktdxAy7rQcKD+0H1zPknAPSdM7qgiJHVEkerYg6SbMu6zICaJXOiyKkPF8jYC5Hj0Xr8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aNhOGr8F; arc=fail smtp.client-ip=40.107.247.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obXvg0PSRiE2WHqwB+28v4+7XSpEiqNK04CXI3wi39efzwk0crU+DZie0F/j29yypoDs33CX1TUjsCll3ybO+ZaAlA00SKzIQb/cfI0llBy7ekYHhZDwhKmCuF2KqABpdJMifQauUbdm4AuqPAuPsYp67rhwbsmnBCRUdsInRSiNlRNPCOfi2Be9xCaggr0cLB63qT3xxWXZBhZoVsUD0NWkQCH0DJmTA415fHxVTRbrDRZf/CwEKwZw97vM01KJv6/s3/35Qdv6jy/kfje22CyNqs+d8GhYz85336hrEz5EQWP9hTram98Uzn+ZJsXSmkUjLhTaJeTtCk32132DBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY8R8USyPHKmlCAGWCw0iHlR0xyJhiTQXsfH2gdnBDw=;
 b=Rks7X7ta+VQfSMM7oDWn2hf95d522PYtl+kcO7Z5nL5MEmun9M0v2IcxsxxAdU9BNtBTIPqEu/VrcNzSKd1UUZ0NO0N3aUxIyZUbbGmr9IRlomn90O4mkItmAJ00QVhL9jwsKC7z8yQFe4w+XT7XHHWTI52zo45BXrNWD7WVmndpP5A3o0mt9ak1SpUyuRxKLllOAvTNujfmIXWGZn1y5A1DZpK6PHK8CaALyP97y9CLlQ1rjKAUA7IAYDlvSMY5f+3CwdkthPfIoADcYqw4kzItQ57TSEiUPl68R8sN1p8CX8KOyO/+x7S7Qi7ralGoav/7I4EapF0UiST6NjNpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY8R8USyPHKmlCAGWCw0iHlR0xyJhiTQXsfH2gdnBDw=;
 b=aNhOGr8F4307Ydio5OyOgWKActaFzSFLql2QKAFCB50LdfImC8SMnl/6qLlGXVytVNapnYf1Bjgieh4n9rVxBo5h0cmCxlRnXKnIn2RxCy3rO8YTMg9ERaExomiHDI7cI5xB/wpq4dFDIb3aEXcRyJA0U91N23/qkq5yC+INMiA=
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by PAXPR04MB8110.eurprd04.prod.outlook.com (2603:10a6:102:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:54:56 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::7d6a:fec:d2b2:9f48]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::7d6a:fec:d2b2:9f48%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 07:54:56 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Jan Petrous (OSS)"
	<jan.petrous@oss.nxp.com>, Wadim Mueller <wafgo01@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Chester Lin
	<chester62515@gmail.com>, =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?=
	<afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>, dl-S32
	<S32@nxp.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Johannes Zink <j.zink@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [EXT] [PATCH 2/3] net: stmmac: Add NXP S32 SoC family support
Thread-Topic: [EXT] [PATCH 2/3] net: stmmac: Add NXP S32 SoC family support
Thread-Index: AQHadygmpZcxt3cMdEis10A9c180DLE8QIdAgAAITgCAANsRIA==
Date: Mon, 18 Mar 2024 07:54:56 +0000
Message-ID:
 <AM9PR04MB85061D806B61A9C299E4E026E22D2@AM9PR04MB8506.eurprd04.prod.outlook.com>
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-3-wafgo01@gmail.com>
 <AM9PR04MB8506244076FBC931101B2205E22E2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <3ce9cf8e-f8d0-4de5-b5b7-1060f77321eb@linaro.org>
In-Reply-To: <3ce9cf8e-f8d0-4de5-b5b7-1060f77321eb@linaro.org>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|PAXPR04MB8110:EE_
x-ms-office365-filtering-correlation-id: e778d7ec-c2c5-4593-1c6b-08dc4720b426
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 on2brxUAM19oYhRGWhlH+n9wRAccqK/FqTlblooN0p+gES2DiCbgHzazfiMKOz+GYBPeaFFoabYSUuY2iNwrV7fLb9SFZF+NQjw5yOwDDy1iU7Ob2JLymEhUUyrzpW65TxXLhe3/K9L+9vnWNfIaUhb4ftPDbpdOfx4NzP9YNHwiVihJkQYZJq0urZwyuh8FCLMQ+O/M52VW6it1AkrgqeuGMal2I3i2lfi6Mp3dKL8UlFUPD2lBcI6MHCT64Fpg0gQVYE8mzYaAR7fbMZ828CdUHWESl8+0JIYWWjz7UtudXcaJvhAwxGp1FaWpGnovWdPnvbggakk7MP6kUMc3l/N30fQXorjNu7dlolqN5+9wB6nRjXo308yihdClHoKHslojkc7vaOLHnCgo526fGXYWOOuSgbpW85UlHAUUq1lwruKZpeY1YrhR8hYRBvqlx8gLRq4NmgKobAGmi1p/Bc0q/fK8mGSenPhff+M8fj4+WV232vNbiSWsiPatOaiKqtv6LhT186sjUUEZPkEW0HkL49XNvYm3giWzXhjqO1+7PdRwc43dW9+G5H22bzrGgz56Hn0+vyL4On6L/25KQTWRqkno6AYCHKeMx/RYpU8v+NeO+fj5gLAbmw9Z0sjPhZLC/HHltj2SmnW3co/13tamBNwctSicNkGhq+6sszQPShOZIWCbnGBSM348p7HZe6Os3td51qqMhfXt7MbNFQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGg1VTZNd3NYZEVrTnZFajcwNy9STE9qZkU1UTNEcFIvNElYT1BWeFVyazZr?=
 =?utf-8?B?U29NWmIvS2l4WTVVQ0dsUUlDUTVpVCtsamxOdU0vTGR4Nko3TkpONWV1WUho?=
 =?utf-8?B?S0xCQVVpYTQ5NGJCWGdta1NjSkg3MmZlNWVFcWdxWEdnQUVYanB5OVFyWFEx?=
 =?utf-8?B?NmNibitaZXBXKzhsdnM3WlEraVB6alpxNGhZdm9WZ1h0L082aHljdXpIK0xh?=
 =?utf-8?B?MFI5Nktld2ZZM21BQnJMb1BKdzhXR0VqRlpLU01mUlRNYndpT0ltQ1F6dEhT?=
 =?utf-8?B?SW02ODJXbTdYdUpaNEs2dTg5SzBVNzA3cklUaHY3NW5lQ1k2YktDNzMyMG9T?=
 =?utf-8?B?WE9pWDY5YXZ5d1lnWUs2RmMxdC8rcHlQUEszVm9FUWI1VmVVc1JCN1dXbk5i?=
 =?utf-8?B?L0w3elh0K2VCMkZ1QWxKQXlhbDVmOS9BRS8xM0JHRGh6QlluTWpadWI1TXNV?=
 =?utf-8?B?aHpReWNEM1dVZWU0cVFISXRTZGVxdE54VDhQMjl1M0hTWE0wRFNNZUg2dWlN?=
 =?utf-8?B?eDkwdm0zYnNLRXl3Ukw1U1pwVElTN2NzVlZHUVg1anB0cWxTRlRWeDlrQk02?=
 =?utf-8?B?eGZ1UGxENWVhajBGcUdFcFo0Q1gvWnkvbnZId0RHTjVyZ3JLdnhTMzIrT2tL?=
 =?utf-8?B?TkF2cHNGcHJ0Z2xhWm9BWkE2MlE2bzh2Mkdnby8vSnQ5bnpkWG83UGc2NytD?=
 =?utf-8?B?VGJUSVF6aUVkakpDdnJKNk9yNDF6bjVVTms5Q1hEMmg2SFNyUjZwUHpoTEZI?=
 =?utf-8?B?YmpUQ2ZPcGFtenpmUE16cWVmWThkbXRmbkxPWDdHMGxERjBPekRwVkdPZHda?=
 =?utf-8?B?VmFKMisvSElrN3VQVHdsQXhCV0NZd0dSWERFY1pOR3BXamttd2h4VkdvM000?=
 =?utf-8?B?U1Z3ZlFiaEREUXNaVGcvaXRhNVovdnNDQUFSWlVBQ0V2RXdtTmp6aEsvQTQw?=
 =?utf-8?B?UTBnVlBlRlpTUW5jaGJTZlgzVnlQRUdZQUF3VEdkYXptS2tYRzlMdGlRTENu?=
 =?utf-8?B?VkR1Q2RQZlJSbWV4N0RoVHNRTW1XSnlRTThsckJFMDA0VUxHYWhGbXEwdklK?=
 =?utf-8?B?c2hpZkZtcHkrai9vNXBZUmZlMnlZTDlsTDd6MG54RUFUQWNaakhLa25CRnJ6?=
 =?utf-8?B?R1Q1dHVwcUpHKzZpdi9MbUVCRGN5dGtpV2hDU0JTYjlvOGRjMW9YVEphYkM1?=
 =?utf-8?B?U2pnQUxzcmtEdTE5THM4eWR5cHpjZ1JNejFNeUdUM0djZUUxT0VuZWF2YTBv?=
 =?utf-8?B?VkU4V1pUbUNNV0dIL0I0dy9kVUVrZzltNEVxSzlKNUZaU0VTMUg0Q2dHMllE?=
 =?utf-8?B?OS9hOFlTekhXRzRrUzNOV2tBbU1NRzA5d290Mjk4Z1ZSTFRlL2dEbHJUUG5L?=
 =?utf-8?B?dk01NmFYZlVNSUM0ckduVlpqdXk1N3J3Um54RUNrK3VWSldvNjBpdklldklZ?=
 =?utf-8?B?cHhGVklEanRwdHc4Nmh3WEF6ZERiNHBaZk9vKy9aRGkyVUhBSXdMWHBib2E2?=
 =?utf-8?B?N3pxRTM4bHk1Vm5UTms0OEZSaHBmb0M3YUtTdGJualc2RW9VR3ExdkF4cEcy?=
 =?utf-8?B?YWhBcHU4RExkVnFvdTFBcCsreWRWTEx2TkhVYml3YXZQRUhEV2JoWnZqMWlU?=
 =?utf-8?B?VlhuQmhuM2c4Z1lPZSs4dXZLTHpJemFGRVF5MThxSkN5TFVkZzJBV1BlazBJ?=
 =?utf-8?B?UEFtN3M1eXFTeXNLM1dFSUo4NDV3Vmx2TkEwUXFBN24xa2wycWR0c0FXM3dG?=
 =?utf-8?B?SGh3ZlFybll0ZWhBS3BnTUVTbHNocy9IcWlGcHorQjlDMytsL0VoWkt0WHRK?=
 =?utf-8?B?bjBON25sRWZ3VWlIRGUwOUsrRHNhQlY2TE5DcU9ISjRVeGJ3NHRaMDBWMDlU?=
 =?utf-8?B?dkZZOEROSXdobVFTQUpaSHMzVmxUZ3NpNjJkdTM3MEFnQys0QXJ0WjF3d2sz?=
 =?utf-8?B?a3gxcFU5OTR3T1VXRHBFWlYydkpWS1U2NE43RUw3bXJFZzBKVzNBM0RjOFZh?=
 =?utf-8?B?eng5TzliZndJS0MrWUNRTmFZbXlKTmhqU2RCYlQwdTRjR3VXaERMQXlKNHN2?=
 =?utf-8?B?VEpxMGZpczVSWTdLcHdsU2Z0WXFOOGJxT3pKWksyTEcySTlUNU5xK2U0dTZV?=
 =?utf-8?Q?W8L59scuSyORwwUdry3mVe79d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e778d7ec-c2c5-4593-1c6b-08dc4720b426
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 07:54:56.6368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/9/QcHVffES3UgttBmwTwFrHGsJnSC8VI/nVykHDVKYrDe46cvFl19x7DOPOokful5lzisy/auDtMFSBFzSMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110

PiBPbiAxNy8wMy8yMDI0IDE5OjI2LCBKYW4gUGV0cm91cyAoT1NTKSB3cm90ZToNCj4gPj4gQWRk
IHN1cHBvcnQgZm9yIE5YUCBTMzIgU29DIGZhbWlseSdzIEdNQUMgdG8gdGhlIHN0bW1hYyBuZXR3
b3JrIGRyaXZlci4NCj4gPj4gVGhpcyBkcml2ZXIgaW1wbGVtZW50YXRpb24gaXMgYmFzZWQgb24g
dGhlIHBhdGNoc2V0IG9yaWdpbmFsbHkgY29udHJpYnV0ZWQNCj4gYnkNCj4gPj4gQ2hlc3RlciBM
aW4gWzFdLCB3aGljaCBpdHNlbGYgZHJhd3MgaGVhdmlseSBmcm9tIE5YUCdzIGRvd25zdHJlYW0N
Cj4gPj4gaW1wbGVtZW50YXRpb24gWzJdLiBUaGUgcGF0Y2hzZXQgd2FzIG5ldmVyIG1lcmdlZC4N
Cj4gPj4NCj4gPg0KPiA+IEhpIFdhZGltLA0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHVw
c3RyZWFtaW5nIGFjdGl2aXRpZXMsIGJ1dCBJIHdvdWxkIGxpa2UgdG8gbm90ZSB0aGF0DQo+ID4g
dGhlIG9sZCBOWFAgUzMyQ0MgIHN0bW1hYyBnbHVlIHdhcyByZXdyaXR0ZW4gbGF0ZWx5IGFuZCB3
aWxsIGJlIHBhcnQgb2YgbmV4dA0KPiA+IE5YUCBCU1AgTGludXggcmVsZWFzZSBwbGFubmVkIGZv
ciBBcHJpbC4NCj4gPg0KPiA+IFRoZSByZXdvcmsgd2FzIGRvbmUgbWFpbmx5IHRvIGFsbG93IHNp
bXBsZXIgdXBzdHJlYW1pbmcgcHJvY2Vzcywgc28gSQ0KPiB3b3VsZCByZWNvbW1lbmQNCj4gPiB0
byBwb3N0cG9uZSB5b3VyIGN1cnJlbnQgd29yay4NCj4gDQo+IEkgc3VnZ2VzdCB5b3Ugd29ya2lu
ZyB3aXRoIHVwc3RyZWFtIGZpcnN0IGluc3RlYWQgb2YgY2xhaW1pbmcgdGhhdA0KPiB1cHN0cmVh
bSBjb250cmlidXRpb25zIHNob3VsZCBhbGlnbiB3aXRoIHlvdXIgZG93bnN0cmVhbSB3b3JrLiBU
byBiZQ0KPiBjbGVhcjogeW91ciBkb3duc3RyZWFtIE5YUCBCU1AgZG9lcyBub3QgbWF0dGVyLg0K
DQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBNeSBpbnRlbnRpb24gd2FzIG5vdCB0byBvZmZl
bmQgc29tZWJvZHkNCm9yIGJyZWFrIGFueSB1cHN0cmVhbWluZyB3b3JrLCBzb3JyeSBpZiBpdCBj
b3VsZCBzb3VuZCBsaWtlIHRoaXMuIA0KDQo+IA0KPiBJZiB5b3UgdGhpbmsgdGhpcyBzdWJtaXNz
aW9uIG5lZWRzIGFueSBwYXJ0aWN1bGFyIGNoYW5nZXMsIHRoZW4gcGxlYXNlDQo+IGNvbW1lbnQg
b24gc3BlY2lmaWNzLCBidXQgc3VjaCBicm9hZCBzdGF0ZW1lbnQgdGhhdCBjb21tdW5pdHkgc2hv
dWxkDQo+IHdhaXQgdGlsbCBOWFAgd2lsbCBiZSBzbyBraW5kIHRvIGFsbG93IHVwc3RyZWFtIHdv
cmsgaXMganVzdCBub3QgYWNjZXB0YWJsZS4NCj4gDQoNCk9rLCBJIHdpbGwgY29udGFjdCBXYWRp
bSBkaXJlY3RseS4NCg0KQlIuDQovSmFuDQoNCg==

