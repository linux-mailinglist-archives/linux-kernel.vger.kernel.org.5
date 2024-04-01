Return-Path: <linux-kernel+bounces-126404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8908936DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE28A1F214C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99005138C;
	Mon,  1 Apr 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CfbngzC7"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2100.outbound.protection.outlook.com [40.107.14.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6D4A11;
	Mon,  1 Apr 2024 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711937568; cv=fail; b=Qza5HBapDuDbjeHXt4M+ct8UNZmYrKgdZH1dM/qMxAVhe9ndWkGrpv02eqwxNl1fdyGiPzx2BFWchAsJHGoxGHCqJTisTbcIzUizVfZpGt/Vo6LpLOucAWQUFbOgpfbKIOhavsqLhhg94k3T4wlPuHTN44q3G2S02UvRRh/0p+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711937568; c=relaxed/simple;
	bh=kMv2Fk5pZKfU0iCPRz3U9c39+OEg5VZDjgSPQcgkWMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X5e5mLJTa9PGBAmK8ImOZN3IyQP5zXrtR2MvXZjpxaPiS5fp+5GIn9Nv6UcfAL8QS8eNcRrEANXUbrWjq9jHOm62FJfuzn29PcKuheHEUg7U9U8zBHg9RPIi4/U2lqX4jtx0vrXzQ96tWgX/Y23nfhO2LfzZwsnoYK6jVV0IdD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CfbngzC7; arc=fail smtp.client-ip=40.107.14.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTFnirxij14QgBFwtbaesuIYoDey02g8iH9DG86H0KTXXzhis0q/8tuRuuYOfbADocP8ip6+kFgP/p7mTzJbZUZ8hAIjkxUJ9zdSzBnEMqKQaSDL9I8gTGz0iKHWHvHifqCYSXzyjkosD8oUKEVRiv429Ofkq6STQzCxbfvduoQWphzv4kj/KWeTs+vtqhxKWgyc4QGBy4MwSoNDjGr3hBVWiWh+fUWXyYdj9wuyjOrO4s4cYo4NqstcoY83rZbS5KA0BkEUM3HfbhZdx2T4EI50On6+lzm2SAcSzyMqggjUHamlhYf1jg1BsLiPc9Mrvcq1m2zf3rNoYl7Tvw20lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMv2Fk5pZKfU0iCPRz3U9c39+OEg5VZDjgSPQcgkWMM=;
 b=IDm7/yFIFTJ9sx69KKY4mgs+rnaw3ACMALbb9r8t9UmmMYZFsSf5oH36zOoxqRw/ztR6RMTficfQ28GF3oa4Qtlv3zjil2SrP7rzUt9otiYrK3OZgOFPVv+3ShVtQ0hZd/8RFuwq4+FU1KWnFtgO4Xml6gLsyhoMVZHFbWN03Z39evzp3V4rpZVAjHyz8WKgqqcu3rSe7HSNwdDMKxF58sxpCUGRwgvZ5+9uPNTeJNNc+Jyj22mtohtTU0H93g573QC2DPFzUtBeskk0wlcBEE6sH67qs9O8Nu73VbvzZg4Osnf8NFexQp4Z+/coFvDR/ELrHBmuOrnTYxeRvNsCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMv2Fk5pZKfU0iCPRz3U9c39+OEg5VZDjgSPQcgkWMM=;
 b=CfbngzC7Ja/9bjP9IVDGloT6Vbt0lhNy7gilL0UJUxhp1jVwnkR8RRbtYTF2vCaxgZWE/1qX5BRGKpldn37cBZV/XKoLeJwsfc5WkVJlw+LuckwrX2+V69QzQxwIXe8YbzC/6pxXxakGC79COHUs+DAzrzV7HNWBO0oGRjXRzjI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7414.eurprd04.prod.outlook.com (2603:10a6:10:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 02:12:43 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 02:12:43 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for
 i.MX8Q HSIO SerDes PHY
Thread-Topic: [PATCH v1 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for
 i.MX8Q HSIO SerDes PHY
Thread-Index: AQHagbLZxpky93F2jUaFE7EQfeOGdLFOxUEAgAPfOdA=
Date: Mon, 1 Apr 2024 02:12:43 +0000
Message-ID:
 <AS8PR04MB8676A48001E88D4AFED7C1FF8C3F2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com>
 <1711699790-16494-3-git-send-email-hongxing.zhu@nxp.com>
 <ZgbOTgtdEBJyg/By@lizhi-Precision-Tower-5810>
In-Reply-To: <ZgbOTgtdEBJyg/By@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DBAPR04MB7414:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5QShcA2LybN4o+lRIVNuOEZGg5/BG0Y2tSjc8FQyCR5cRFE3FON3ft7+rqp4QB639XAOkBtnm9RBFzXrCUQIMmU1wgEhQhexWd1R80vi8U+/wSO6Xshb5YFHz3w6zF3+fK7P/Gsb8bxDdfl0yPr+Qb22o/tE9gTPihvryc/v/94jK0po7kAkBG/mrSN5lrE58KdzH8tCaC6BBCACkffV4j0TfiKuVm8USdj9RvsvtOpZyiXNNXbmAISBlHW48N0mlAhLjjGO6nCnvbLcaJduiHWe59cARQCU/1IQkMfM1zijeoK6wHTaSYU7+CCnlJT1JJTdQHmfO4MdPdtVchoDJNQ5WqFb9pWQHAZt+GUWx4Ld+GkmRzOheB2e3ssMMHd1xJ5KMNRUhK6BZeB1MagL1wm4Mt8MD+RZ1RmIrMSk8LJlYclwBRuKqIeVs3b+P60H5ohtBqFjr65eMfMMSCT7ji40e7VvNndIx3PhJ761Cvv/n59M5lTQqYUKiExuR2JqVLhMQxoFoUBY36XkvV6xdmSCtdZgz+XwYf3hQeIQWPJsomjDNErpUiHS71jaB8Pa8Sroewt82jA+SwHMHYPxMWPkVt2kkqU7Vh6wBuSK4Bax83YJEYKcz44mvj6bdUvJYUgIWTFZN0WKdXTFmYIaB7KNB26Q3AF9amxE0oCHc0Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eHpkN3o5bWQvaGdjd3VGQkFnaVFkUXBzaWdSRXlNK3BVVklXN1JZSGdPaTNV?=
 =?gb2312?B?TE02RHVDVGw2azEzcXFTQ1BrU05BUEh0K1h4R0NDbDNwV29rSFdpTy90M2or?=
 =?gb2312?B?OVZocVFjVUk1QTB2WmhnNlpvOFY0UktSSmtLWjZ2RlJYTEJoVEtVM05OOVBZ?=
 =?gb2312?B?U2pUQWtFNHh5cVhTVnVQbzZiNTYvOGZ5eGYvVVpINVkwdm1HekNBYkpNN29C?=
 =?gb2312?B?WWw4TzRISmxPZ2xDb1JMSlV3WmtJMDdyNWFJN1QwZWd1MjVWY0I2TzJPQTdC?=
 =?gb2312?B?bTFlUzl4bUFiTThVUERPL0VQR1RobVZzbFBuNGpoS29nOVNWM2dGMFBrT09R?=
 =?gb2312?B?QmNOY0NsUjBkV0FYQ2M1VFg5bzRaeVJNdDJUYTBnUnd3eUs4TWxXU25XRmtG?=
 =?gb2312?B?bFRLMUVEaWsxNnBiNklTZU1Kakh6V1JPUGVrTVFrYlo5U3hkY2txSU1XdDkx?=
 =?gb2312?B?Z3BWcHpFeTNOakx4eEVhbWZKSHBZZHNFa2NadWFkY2NqNmlJUlFTWWc4MkpV?=
 =?gb2312?B?dzdvWXRxckVxN1RlNStYbUk1azZRTEJpZDQxS2pOa0pyaGhsTjNtdzNUWTZE?=
 =?gb2312?B?Wm9SRUhtczZuTTBmblhiUm1RZlhMaTdBQmVQVHJmMWZJa3FFNUk5cnVUM0dl?=
 =?gb2312?B?WkNpZlhyZFgyUmR2TCtjVmpPbm1RMXRaMjFPQXQ0SlV1QVR6SkV2a2ZpeGNp?=
 =?gb2312?B?UDZVMG9NUnBkOVRISFl1ZCs0QWVDOUxaQlpvdFZRa0pjZERGTHF1a0lCaGdi?=
 =?gb2312?B?YzFyMW1iWXY4V2tRYk03VWhiSTBXRzE5TnFwY3ZmcENiZXhjdm9hdll1VTkv?=
 =?gb2312?B?R2U0bWptTENhMk56MytRQUxVd2lGd1dkYXBmTC9GeFEyNEFrVktyUnJFRG9J?=
 =?gb2312?B?YWVEU1puTnA4V3BrcWptSmd2MXRhaWoycW1QeUFZN1VHemFYUlRFbmJ1cXY2?=
 =?gb2312?B?NC9OQVJrNVE0NHlkTlc1MFlJV3FMenNVbWtIRWdLVjZwYms3WTNBN0Z4VkRD?=
 =?gb2312?B?d3ArZ0d2NzBGRXpYakI2aGw1UVlBVkFHcnpURitIVXhmWmtOMVJYUFlseFlC?=
 =?gb2312?B?VFBUcUdmMnhORGlXNFNldkUyOVAzTG4wZWUxenlCRGIzWUUyeUlRNU1ZUm1Z?=
 =?gb2312?B?U0VkZGdIRU5tcGNKcHlmYXdwMUw3cjFkM0NudmVwRk40WUlEN3ZFSk4wZ1p1?=
 =?gb2312?B?b1p0OElnYWpLcjBkcFFaWFkzQS92M3dIa2t0V0RKZjA5eStnZk9QRENwL0RW?=
 =?gb2312?B?a2E5UlNMZmRZa1FTTWZabGRGWGtnWHVOQzF4NHZrNSs4MlJUQWVkajJTZDFT?=
 =?gb2312?B?SnAxYUFycXNFL292U0t6ZW5VU2JxQXhrdXBibENKZkg1cUY1YlQ1Z1dBK2ZY?=
 =?gb2312?B?N2FPOEZIVHl6SW1hYU1TMWVJWk9TNndoRHh1dHhqYVdISzhlYitPWHBOT2hU?=
 =?gb2312?B?V2wwQTFDSHBkbHUya3FxMDRUa0RWeFJsMk1JbFlieGU4dENXR1BqQXpiejdF?=
 =?gb2312?B?MmM3MldzUE10R0NwaEk4aG42MHA4OWlkODJoaVpnY3NOYlFjd0ZCTkdqempq?=
 =?gb2312?B?cUN5aWRadjB2N1BVMHpvSldVVU9jZGpqOHNUSmhicmQ0eHRDMHZNV3NaZDlB?=
 =?gb2312?B?bmlRUFNFa0lwQTdHMHkwK0Y0MnhicldDVzllV0Q0b1JnTEZqeGgrY3duQ2dS?=
 =?gb2312?B?cEdVSzlkQ2F4WGtGeithQ3pkVTVlcHlGRnV5bGprV2Ftb3gxLzhZbUJiUmlx?=
 =?gb2312?B?NTdXUm54T1V1TWF3eVNObVdpOW8yb0NmNXF1QUxnV2NBUHhCV0MxN0JvSUdp?=
 =?gb2312?B?UXorSm5SSDZ4S2UzWmlzRElQK2pxd1N5SVNQc1lUOFpuUHVEYlhENGU3YndW?=
 =?gb2312?B?bFIvWkEwVzFSTU1EaCt1NlMzblhFMHkxUkwrOUZESFhOa3dzUGdmb1k0Q0RI?=
 =?gb2312?B?YjhuYWt5Y0t1blZ2NkhNSkZYQTlyclJGYzN6cGpIT0Zqa090c3B0dmFPdWww?=
 =?gb2312?B?TGs4aHlrQlA0VU1lN2g4eG03VThGeGpTSXlHZU5BUUhCSXpHSU5YU1JLSkRt?=
 =?gb2312?B?RjltZW9NRjczU3hPVm9uZ1ZNejZrK1dpVWR6cHRVY3QzblVPOUR1djlmNGFy?=
 =?gb2312?Q?Se5lQHnCpkRiLlDM5BTZmDSR9?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd1ef41-858e-4980-80a8-08dc51f1377a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 02:12:43.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDc7OyCMkNCNsiCjU3uUGygFfG1OR+zkNVTymENbyrdfjU7o03AGG3SANxrvDBzzn58YUKF4LYbFeNBtkiEpgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7414

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqM9TCMjnI1SAyMjoyMQ0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHZrb3VsQGtlcm5lbC5vcmc7IGtpc2hvbkBr
ZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRA
bGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gbGludXgtcGh5QGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MSAyLzNdIGR0LWJpbmRpbmdzOiBwaHk6IHBoeS1pbXg4LXBj
aWU6IEFkZCBiaW5kaW5nIGZvcg0KPiBpLk1YOFEgSFNJTyBTZXJEZXMgUEhZDQo+IA0KPiBPbiBG
cmksIE1hciAyOSwgMjAyNCBhdCAwNDowOTo0OVBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToN
Cj4gPiBBZGQgYmluZGluZyBmb3IgY29udHJvbGxlciBJRCBhbmQgSFNJTyBjb25maWd1cmF0aW9u
IHNldHRpbmcgb2YgdGhlDQo+ID4gaS5NWDhRIEhTSU8gU2VyRGVzIFBIWS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9waHkvcGh5LWlteDgtcGNpZS5oIHwgMjYNCj4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRp
b25zKCspDQo+IA0KPiBUaGlzIG9uZSBzaG91bGQgYmUgZmlyc3QgcGF0Y2guICgxLzMpLg0KPiAN
Cj4gQWZ0ZXIgZml4IHNtYWxsIGltcHJvdmUNCj4gDQo+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8
RnJhbmsuTGlAbnhwLmNvbT4NCj4gDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaA0KPiA+
IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9waHkvcGh5LWlteDgtcGNpZS5oDQo+ID4gaW5kZXggOGJi
ZTJkNjUzOGQ4Li41Y2Q1NTgwODc5ZmEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9kdC1iaW5k
aW5ncy9waHkvcGh5LWlteDgtcGNpZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9w
aHkvcGh5LWlteDgtcGNpZS5oDQo+ID4gQEAgLTExLDQgKzExLDMwIEBADQo+ID4gICNkZWZpbmUg
SU1YOF9QQ0lFX1JFRkNMS19QQURfSU5QVVQJMQ0KPiA+ICAjZGVmaW5lIElNWDhfUENJRV9SRUZD
TEtfUEFEX09VVFBVVAkyDQo+ID4NCj4gPiArLyoNCj4gPiArICogaS5NWDhRTSBIU0lPIHN1YnN5
c3RlbSBoYXMgdGhyZWUgbGFuZSBQSFlzIGFuZCB0aHJlZSBjb250cm9sbGVyczoNCj4gPiArICog
UENJRUEoMiBsYW5lcyBjYXBhcGJsZSBQQ0llIGNvbnRyb2xsZXIpLCBQQ0lFQiAob25seSBzdXBw
b3J0IG9uZQ0KPiA+ICsgKiBsYW5lKSBhbmQgU0FUQS4NCj4gDQo+IFN1Z2dlc3QgYWRkIGVtcHR5
IGxpbmUgYmV0d2VlbiBzZWdtZW50Lg0KPiANCk9rYXksIHdvdWxkIGJlIGFkZGVkIGxhdGVyLiBU
aGFua3MuDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+ID4gKyAqIEluIHRoZSBkaWZmZXJl
bnQgdXNlIGNhc2VzLiBQQ0lFQSBjYW4gYmUgYmluZGVkIHRvIFBIWSBsYW5lMCwNCj4gPiArbGFu
ZTENCj4gPiArICogb3IgTGFuZTAgYW5kIGxhbmUxLiBQQ0lFQiBjYW4gYmUgYmluZGVkIHRvIGxh
bmUxIG9yIGxhbmUyIFBIWS4NCj4gPiArU0FUQQ0KPiA+ICsgKiBjYW4gb25seSBiZSBiaW5kZWQg
dG8gbGFzdCBsYW5lMiBQSFkuDQo+ID4gKyAqIERlZmluZSBpLk1YOFEgSFNJTyBjb250cm9sbGVy
IElEIGhlcmUgdG8gc3BlY2lmeSB0aGUgY29udHJvbGxlcg0KPiA+ICsgKiBiaW5kZWQgdG8gdGhl
IFBIWS4NCj4gPiArICogTWVhbndoaWxlLCBpLk1YOFFYUCBIU0lPIHN1YnN5c3RlbSBoYXMgb25l
IGxhbmUgUEhZIGFuZCBQQ0lFQihvbmx5DQo+ID4gKyAqIHN1cHBvcnQgb25lIGxhbmUpIGNvbnRy
b2xsZXIuDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIElNWDhRX0hTSU9fUENJRUFfSUQJMA0KPiA+
ICsjZGVmaW5lIElNWDhRX0hTSU9fUENJRUJfSUQJMQ0KPiA+ICsjZGVmaW5lIElNWDhRX0hTSU9f
U0FUQV9JRAkyDQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBPbiBpLk1YOFFNLCBQQ0lFQSBpcyBt
YW5kYXRvcnkgcmVxdWlyZWQgaWYgdGhlIEhTSU8gaXMgZW5hYmxlZC4NCj4gPiArICogRGVmaW5l
IGNvbmZpZ3VyYXRpb25zIGJlc2lkZSBQQ0lFQSBpcyBlbmFibGVkLg0KPiA+ICsgKiBPbiBpLk1Y
OFFYUCwgSFNJTyBtb2R1bGUgb25seSBoYXMgUENJRUIgYW5kIG9uZSBsYW5lIFBIWS4NCj4gPiAr
ICogVGhlICJJTVg4UV9IU0lPX0NGR19QQ0lFQiIgY2FuIGJlIHVzZWQgb24gaS5NWDhRWFAgcGxh
dGZvcm1zLg0KPiA+ICsgKi8NCj4gPiArI2RlZmluZSBJTVg4UV9IU0lPX0NGR19TQVRBCQkxDQo+
ID4gKyNkZWZpbmUgSU1YOFFfSFNJT19DRkdfUENJRUIJCTINCj4gPiArI2RlZmluZSBJTVg4UV9I
U0lPX0NGR19QQ0lFQlNBVEEJMw0KPiA+ICsNCj4gPiAgI2VuZGlmIC8qIF9EVF9CSU5ESU5HU19J
TVg4X1BDSUVfSCAqLw0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCg==

