Return-Path: <linux-kernel+bounces-86257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D33F86C2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3128F1C2106F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936F747F79;
	Thu, 29 Feb 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KNC+mZSz"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31025630;
	Thu, 29 Feb 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193701; cv=fail; b=nzlrkdHjQDBBqEFGLoY7Jb4zk6fLULHPgA4YrHfQHFJhbRATbuU1TxQZNPC2O58BjUMv9KY2QKXZ34wFcPGLxvSRU2avNxmwYWJBmScaaqlrHOqrzV+dfIpxuhOAfbi8UAjrcSYN8TI9wjczzsc7Vds4G4MLhZcwe0xiDukw+Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193701; c=relaxed/simple;
	bh=s/V0zNdDEzmDO3dnoNFzJivs7ldfbOMnE1QmjHzEgPE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uhBUqnawFJMAV+wCmjesCNPGh7s6XRdKySqQN34Qzs3iP45zgzrQIS+Gh1XosJW+jxjx5Up0zWByppOErStukciq7MIQ6pQCv/nDwFgOzDndDcK149XkrBJAadtutUCwRzj+ATjEBWy8YDFDz11K66bX9XBtdteR9kz4AhV9fzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KNC+mZSz; arc=fail smtp.client-ip=40.107.6.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAQL6tLa2/bLNNn6yPHBSmHNLivXGsGJKh3tFK1xfayRGjth/hotYZj4Mhf5PChT3lddKN7XAaexdU7/0Tk8WhuuZ4ME62jyjddpzyB53Pm28TgasfaAbCHmM9atvQJaI8OQh7rSbc6WbsJMQDvqtGST0nUgegP+DOORNJj1Cz4vwWBwJU0e0f60PPdeOKh5qr+S0O1Ku6IPXGf0V8rhfdrqKbJEqG+KnZaWRTOFs3YRZrQs/K2Zs1oVZwDtLzaVoklb3ZcFwyh8RsKZJfG2QxdnPbt4WpG3N5qwQZxl/i/HPT7aqLJpGwB2CkkXjFkwJHPLCVXL4XRkxLXStruXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/V0zNdDEzmDO3dnoNFzJivs7ldfbOMnE1QmjHzEgPE=;
 b=jQWCiyGdkqHdAYf4yKye3W4gApTrkwGUiuj2c+OMI0JpAyV5fF3ae6gbEOi67tT5foJu7+8MEl66f47fUQ8i/ITM1KazLlXAwM7RuyVSmmG1QY+cM4gaMZnQJSA6YzMe95Bm4zkcZu6/otWUiWqq/JlCKxBbVXJYeK9pHVc3ijG/2a95g287nKmpMZXp0ES/TLv+Ki6ULwjfWuXPkQmTrS3Qonsmt0ENfTEVIXopAOEIOtY5xhRbhtbdLMzCsq1J4lx+U05uKfPeo7YZIgNHr/Ic9ZjY+ZHgTfommXQ9PVPIkQAechucgGDoOk8yhSCiE5iYeCdFivPUDx//tqKwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/V0zNdDEzmDO3dnoNFzJivs7ldfbOMnE1QmjHzEgPE=;
 b=KNC+mZSz4KiiFDiaiE3dpbsuqNRxuxVd5aVsVqVsfWSGZc+gnE8cX2NRIZjYYUpZXW3w49lX1P1luCzNoRR9EjANaXSwRdDGY0UO9OwPnb0Xk8JkzcAL+Y4GgEO86NN3orrleqnMhLMCL4LHi4Spn9FAOHT0JRjvHTiVLFtEBLA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 08:01:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Thu, 29 Feb 2024
 08:01:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "saravanak@google.com" <saravanak@google.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "pali@kernel.org" <pali@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] of: dynamic: notify before revert
Thread-Topic: [PATCH] of: dynamic: notify before revert
Thread-Index: AQHaag0+AypznpRalEW8qnCECxwD0bEfv9QAgAEz1RA=
Date: Thu, 29 Feb 2024 08:01:36 +0000
Message-ID:
 <DU0PR04MB94177FFE211711E9DE4E9E51885F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240228062138.1275542-1-peng.fan@oss.nxp.com>
 <CAL_JsqJktYv+sSfwtT6ExsES5+HqB2BStnEMMRKVqTO3dFJm2Q@mail.gmail.com>
In-Reply-To:
 <CAL_JsqJktYv+sSfwtT6ExsES5+HqB2BStnEMMRKVqTO3dFJm2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DUZPR04MB9784:EE_
x-ms-office365-filtering-correlation-id: d20f8a97-d402-4948-6458-08dc38fca738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e/tYZEBrrzkiu3eGq3B15mkBZxySNVsy06gxTYhO31teDZ0GMqleFKk/FymZgv4r+Uo8oSfgNe4m5a13Wg2Q3UmcwTITvgmaJXnwVTpOvedusTthPAGarQHIhk9LDiu0bAFYxq0SxSPxRC4JQvoH+MUpwT6CEjGAiIxgO0cZhZLuqo3lfsk+J7mZU3Jgh/Xy3FYMTO9l2Ige1zbLUegpm8Quph2PJd3OamZqVimJNk8KzanewpEpniAUtTggK2JAOhd3I82uhgAuEhMMmcbOM0574iD3R8GsVtbGwpCPP/P9a9k7uAsrsk806XmcWmH/04SBF0MwPqhEgwl1B4sBvCfcW/vqfm6Lf4BB9oKGM8TFTN/myHSSD5Olkq8CRwZ1wrFdJinwvSLPkQKGCLSBoKT7FBsqzC084bUtU1hS5Cz1iqhZyS9KuZuhR3rOtDoMXWBwtdIaD7Q/P7p42WLFJecIZ1QFCvYUX5l4bTwlboCH0V6SehTMqmkfITgGvHxvXyW37kG3zz3fang047lTowlca8AXCLQombcDlK7F7LrUtmAi5ZFoNNQr+8tJx+1CZtDpLP4WCAeC2fjhBuI6YPnBy5Vo54KJSzT6yH2Y6WyAPiD/324ReQntHmzGbqjxXFEcUmrJgOjUALgcexNBH6nDEp1mUedO8T/AU2ejbs6jTdEgFUNGIQomV2AyOEfb74mBGogAXR1BwZtXAsHGHifwCMmqGkXNfsWf1KFVTUo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTgwVHNwM3ZWd3VXRVpUMnMyWnR5ZENmYmVTNTZXRkJJeWpNOWsvSnNzNUt4?=
 =?utf-8?B?eUJRZlB4SVY2dVhra2trSTFOOGl2b0tQNGVKZDlsdW5Oekk1cE0zdzB2TzRY?=
 =?utf-8?B?R0t1NlV1c3VROTFIUW5rODBMQVpFZWlMcVhtU3ZGdzFwMng2cjFTNTNGS3JM?=
 =?utf-8?B?UHFvNlVjM2h5WG1Vek8xbFg4QksvWUhqR25FM1M1MkJFYzYybjlZbGFBOU9Q?=
 =?utf-8?B?dEcwL2t6MU8xTTNRV0dvM0lQblZJVkdDcXdacEpWK2J2ZWRUaDlaNmtVdnYw?=
 =?utf-8?B?eU1HSFB0SjMzbzFsei92YjR1cE44Vm1INDlQSUl0RHZDYlRMUTdNYzczRWRy?=
 =?utf-8?B?SlpKajlhUW5hcGFhT29kSWI1emV6a3UybUtyamVRN0tqUXlCeG5sQVB4UW8z?=
 =?utf-8?B?MldjUFl1TTdjT1lRK2tIanMvOXJiYmZWQjFIWWxWLzhIbGRoMDBtNm5SN25v?=
 =?utf-8?B?UlltL0l4TEVzYzdwZWJzaCt2ZHV4M213bFprTWxhbmpkazl4UzFHQlYrK0la?=
 =?utf-8?B?ZUptUG5QYWMrcm9nbm5qc0VralFQc2VEWmE2cDlDc2orblZzMnZwQjdybllF?=
 =?utf-8?B?OXo3M0RQVkU5ZDJuVGdhTVY3amRrakwrMFdPVzdqeXdUU0xpblZ5WEk4OFVS?=
 =?utf-8?B?WWdseVFTeHoxWlJKUXdxTW9uMHQ3UmNVcVNVcjFnaXNYVlhBWG15NUNLYVQv?=
 =?utf-8?B?WE5XY2VndzBHQTQ5aURYNjFtNVZvdkZvc3JZcEdtOWQ1TnNheWQ3aXVUYmJ1?=
 =?utf-8?B?dzBUTlRxci8rQlhIWmE2cGZRaXVDVTlTazdkbW1CQzRWb3hBRmovbWJYK08z?=
 =?utf-8?B?UmV3T3gvaGhaWHdlaVZncDRJV3lKNk5RMDFURlBxNys4TUdOT1BmTlc2MWcz?=
 =?utf-8?B?OTI2aStsMFdReS91ejY2U0pPMzRlLzFjMmNFYTZqcHdJVFo2ZmRQWGZPNVFG?=
 =?utf-8?B?RmY4bGJZdkFaMllnZDdxKzN4dmh2bERLbGJ0MUdoblFJVndGV1hRUnZGek5R?=
 =?utf-8?B?T2J6ZzhmY1RPci85cjNxemhIWEoxM0ZIUmFTY0hjVHI3Y3UzcHRSblJBV05R?=
 =?utf-8?B?eTZBaWZQZFREeEkyWmk0eDNCQUpJeTJIWW05akhMWjk3NytndEwwU0haR0VN?=
 =?utf-8?B?TWcxQ1NDM1p4WTk3dUFqRnlPa0t2NHIvazJHVUNrUnZaZzQzaUpob1hTclVZ?=
 =?utf-8?B?bUlkR1NBYTR0bGdFRnhGSmxkTENxMzNVZHgvMEZ4MHd3dk45UTFLTVpselNX?=
 =?utf-8?B?bjg1ZUY3dlFZNFJuSm1SY2lnUlB3QjlQckNoM0FIdFNzMGV2SituWFNobG05?=
 =?utf-8?B?NXlsR08zcHBUTGU0UnJ5bVl5djdTQkRYbHRKWWE5c3ZzNGVCZytKbGcrLzBE?=
 =?utf-8?B?bi9qQjNsZy9iaWw5dFQ5clB3Kyt1QTkrUS9TU0RZZFM3ZXI0U3FBTlhzTTZI?=
 =?utf-8?B?ZmROeVU1SGRrSWlFdzN1dHJwSHJpcXR3UXRraTh6YngvRWdRVjh6MVVRM2Iz?=
 =?utf-8?B?UUszV3JYaHFrOUc2KzZWNTJDRldlWHRaaWFlb0xGWGhZVWxiR2JMY1doamFv?=
 =?utf-8?B?WHVZZVUwcWdoeVJuQmhqMllXZUw2QTZ6UUcvVGsrSXpRU3ZYd0xOTDdQYmNY?=
 =?utf-8?B?L2VMSzRZWU1WNnNDeXUycHMrY1djVmlOVjgvZVM2dGpFMnM3OUVyV3NLa1Q1?=
 =?utf-8?B?UUJsb3N2SnhRb2ZmcHRBaUhtcDZaNGhVLzdVdFVaeU9SV01PN0dtL2szVXpk?=
 =?utf-8?B?VlBnTkYxdHloS1VpeTlueWF0cWdENFkwMnhpZEJHTk5pY1lGRk4wMmE4aVRK?=
 =?utf-8?B?UkNIT1JxUkZxYnlRSkNSQThZNFppZyt2bUU4aWJNUmhSSlVOS1k2Rk5vYjRV?=
 =?utf-8?B?eDR1TXBqNFpraXlKK24vWm5vNjFFZWl6cHFlVUJyWmhqREFaNURtYlQzNS91?=
 =?utf-8?B?MlUzWjVDNjBNdkZIQzFPRGhKWUpJNDZVOWNDT3dadEVMMFdjc0o0d3VLYXg2?=
 =?utf-8?B?Zk5oTys2Z0VaVFcxdTBIU1RVai9lYmx0ZC9XKzFUd0dRSmt4UndsR3Q1YU1x?=
 =?utf-8?B?d1NNcjlma25uMWV4VThqYnlJNWNOSVRWdTQ1NDJ3L3ZYbFVuc1c5eEFiMG5h?=
 =?utf-8?Q?mUno=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20f8a97-d402-4948-6458-08dc38fca738
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 08:01:36.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0Q7B9sA2uxzKqxWkq8pVlze19jzo4T+79Kn0aCtB2WS26xPRe3g/1mLAflEkds25jPFvxHW97d6jGxl7MTNeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBvZjogZHluYW1pYzogbm90aWZ5IGJlZm9yZSByZXZlcnQN
Cj4gDQo+IE9uIFdlZCwgRmViIDI4LCAyMDI0IGF0IDEyOjEz4oCvQU0gUGVuZyBGYW4gKE9TUykg
PHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gV2hlbiBQQ0kgbm9kZSB3YXMgY3JlYXRlZCB1
c2luZyBhbiBvdmVybGF5IGFuZCB0aGUgb3ZlcmxheSBpcw0KPiA+IHJldmVydGVkL2Rlc3Ryb3ll
ZCwgdGhlICJsaW51eCxwY2ktZG9tYWluIiBwcm9wZXJ0eSBubyBsb25nZXIgZXhpc3RzLA0KPiA+
IHNvIG9mX2dldF9wY2lfZG9tYWluX25yIHdpbGwgcmV0dXJuIGZhaWx1cmUuIFRoZW4NCj4gPiBv
Zl9wY2lfYnVzX3JlbGVhc2VfZG9tYWluX25yIHdpbGwgYWN0dWFsbHkgdXNlIHRoZSBkeW5hbWlj
IElEQSwgZXZlbg0KPiA+IGlmIHRoZSBJREEgd2FzIGFsbG9jYXRlZCBpbiBzdGF0aWMgSURBLg0K
PiANCj4gVGhhdCB1c2FnZSBpcyBicm9rZW4gdG8gYmVnaW4gd2l0aCB1bmxlc3MgdGhlcmUgaXMg
YSBndWFyYW50ZWUgdGhhdCBzdGF0aWMgYW5kDQo+IGR5bmFtaWMgZG9tYWluIG51bWJlcnMgZG9u
J3Qgb3ZlcmxhcC4gRm9yIGV4YW1wbGUsIGEgZHluYW1pYyBudW1iZXIgaXMNCj4gYXNzaWduZWQg
YW5kIHRoZW4geW91IGxvYWQgYW4gb3ZlcmxheSB3aXRoIHRoZSBzYW1lIG51bWJlciBkZWZpbmVk
IGluIGl0Lg0KDQpJIG1heSBub3QgZGVzY3JpYmUgaXQgY2xlYXIsIHRoZSBjb2RlIGlzIGhlcmUs
IGJlY2F1c2Ugb3ZlcmxheSBwcm9wZXJ0eQ0KcmVtb3ZlZCwgb2ZfZ2V0X3BjaV9kb21haW5fbnIg
d2lsbCByZXR1cm4gZmFpbHVyZSwgc28gdGhlIGNvZGUgcGF0aA0Kd2lsbCBnb2VzdCBpbnRvIGZy
ZWUgYSBkeW5hbWljIGlkYS4gQnV0IGFjdHVhbGx5IHRoZXJlIGlzIG5vIHN1Y2ggZHluYW1pYw0K
aWRhLCBzbyBkdW1wLg0KDQpTbyB0aGUgcHJvYmxlbSBpcyBvdmVybGF5IHdhcyByZW1vdmVkLCBi
dXQgdGhlIG5vdGlmeSBjYWxsYmFjayBtYXkNCnN0aWxsIHVzZSB0aGUgcHJvcGVydHkgdG8gZG8g
c29tZSB3b3JrLg0KDQpzdGF0aWMgdm9pZCBvZl9wY2lfYnVzX3JlbGVhc2VfZG9tYWluX25yKHN0
cnVjdCBwY2lfYnVzICpidXMsIHN0cnVjdCBkZXZpY2UgKnBhcmVudCkgICAgICAgICAgICAgICAg
ICAgIA0KeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAg
ICAgICAgaWYgKGJ1cy0+ZG9tYWluX25yIDwgMCkgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAg
ICAgICAgcmV0dXJuOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgLyogUmVsZWFzZSBkb21haW4g
ZnJvbSBJREEgd2hlcmUgaXQgd2FzIGFsbG9jYXRlZC4gKi8gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgIGlmIChvZl9nZXRfcGNpX2RvbWFpbl9ucihw
YXJlbnQtPm9mX25vZGUpID09IGJ1cy0+ZG9tYWluX25yKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgIGlkYV9mcmVlKCZwY2lfZG9tYWluX25yX3N0
YXRpY19pZGEsIGJ1cy0+ZG9tYWluX25yKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCiAgICAgICAgZWxzZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQog
ICAgICAgICAgICAgICAgaWRhX2ZyZWUoJnBjaV9kb21haW5fbnJfZHluYW1pY19pZGEsIGJ1cy0+
ZG9tYWluX25yKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KfQ0KPiANCj4g
PiBTbyBtb3ZlIHRoZSBub3RpZnkgYmVmb3JlIHJldmVydCB0byBmaXggdGhlIGlzc3VlLg0KPiAN
Cj4gWW91IGNhbid0IGp1c3QgY2hhbmdlIHRoZSB0aW1pbmcuIFNvbWV0aGluZyBtaWdodCByZXF1
aXJlIG5vdGlmeSB0byBiZSBhZnRlcg0KPiB0aGUgcmV2ZXJ0Lg0KPiANCj4gPiBGaXhlczogYzE0
ZjdjY2M5ZjVkICgiUENJOiBBc3NpZ24gUENJIGRvbWFpbiBJRHMgYnkgaWRhX2FsbG9jKCkiKQ0K
PiANCj4gSSBkb24ndCBzZWUgd2hlcmUgdGhlIG5vdGlmaWVyIGlzIGV2ZW4gdXNlZC4NCg0KVGhl
IHN0YWNrIGlzIGFzIGJlbG93Og0KDQogWyAgNTk1LjE1MDUyOV0gQ1BVOiAxIFBJRDogNTgyIENv
bW06IGphaWxob3VzZSBUYWludGVkOiBHICAgICAgICAgICBPICAgICAgIDYuNS4wLXJjNC1uZXh0
LTIwMjMwODA0LTA1MDIxLWczZDRjYzE0YjQyZWYtZGlydHkgIzM1NQ0KIFsgIDU5NS4xNjE5OThd
IEhhcmR3YXJlIG5hbWU6IE5YUCBpLk1YOTMgMTFYMTEgRVZLIGJvYXJkIChEVCkNCiBbICA1OTUu
MTY3NDc1XSBDYWxsIHRyYWNlOg0KIFsgIDU5NS4xNjk5MDhdICBkdW1wX2JhY2t0cmFjZSsweDk0
LzB4ZWMNCiBbICA1OTUuMTczNTczXSAgc2hvd19zdGFjaysweDE4LzB4MjQNCiBbICA1OTUuMTc2
ODg0XSAgZHVtcF9zdGFja19sdmwrMHg0OC8weDYwDQogWyAgNTk1LjE4MDU0MV0gIGR1bXBfc3Rh
Y2srMHgxOC8weDI0DQogWyAgNTk1LjE4Mzg0M10gIHBjaV9idXNfcmVsZWFzZV9kb21haW5fbnIr
MHgzNC8weDg0DQogWyAgNTk1LjE4ODQ1M10gIHBjaV9yZW1vdmVfcm9vdF9idXMrMHhhMC8weGE0
DQogWyAgNTk1LjE5MjU0NF0gIHBjaV9ob3N0X2NvbW1vbl9yZW1vdmUrMHgyOC8weDQwDQogWyAg
NTk1LjE5Njg5NV0gIHBsYXRmb3JtX3JlbW92ZSsweDU0LzB4NmMNCiBbICA1OTUuMjAwNjQxXSAg
ZGV2aWNlX3JlbW92ZSsweDRjLzB4ODANCiBbICA1OTUuMjA0MjA5XSAgZGV2aWNlX3JlbGVhc2Vf
ZHJpdmVyX2ludGVybmFsKzB4MWQ0LzB4MjMwDQogWyAgNTk1LjIwOTQzMF0gIGRldmljZV9yZWxl
YXNlX2RyaXZlcisweDE4LzB4MjQNCiBbICA1OTUuMjEzNjkxXSAgYnVzX3JlbW92ZV9kZXZpY2Ur
MHhjYy8weDEwYw0KIFsgIDU5NS4yMTc2ODZdICBkZXZpY2VfZGVsKzB4MTVjLzB4NDFjDQogWyAg
NTk1LjIyMTE3MF0gIHBsYXRmb3JtX2RldmljZV9kZWwucGFydC4wKzB4MWMvMHg4OA0KIFsgIDU5
NS4yMjU4NjFdICBwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcisweDI0LzB4NDANCiBbICA1OTUu
MjMwNTU3XSAgb2ZfcGxhdGZvcm1fZGV2aWNlX2Rlc3Ryb3krMHhmYy8weDEwYw0KIFsgIDU5NS4y
MzUzNDRdICBvZl9wbGF0Zm9ybV9ub3RpZnkrMHgxM2MvMHgxNzgNCiBbICA1OTUuMjM5NTE4XSAg
YmxvY2tpbmdfbm90aWZpZXJfY2FsbF9jaGFpbisweDZjLzB4YTANCiBbICA1OTUuMjQ0Mzg5XSAg
X19vZl9jaGFuZ2VzZXRfZW50cnlfbm90aWZ5KzB4MTQ4LzB4MTZjDQogWyAgNTk1LjI0OTM0Nl0g
IG9mX2NoYW5nZXNldF9yZXZlcnQrMHhhOC8weGNjDQogWyAgNTk1LjI1MzQzN10gIGphaWxob3Vz
ZV9wY2lfdmlydHVhbF9yb290X2RldmljZXNfcmVtb3ZlKzB4NTAvMHg3NCBbamFpbGhvdXNlXQ0K
IFsgIDU5NS4yNjA0ODRdICBqYWlsaG91c2VfY21kX2Rpc2FibGUrMHg3MC8weDFhYyBbamFpbGhv
dXNlXQ0KIFsgIDU5NS4yNjU4ODNdICBqYWlsaG91c2VfaW9jdGwrMHg2MC8weGYwIFtqYWlsaG91
c2VdDQogWyAgNTk1LjI3MDY3NF0gIF9fYXJtNjRfc3lzX2lvY3RsKzB4YWMvMHhmMA0KIFsgIDU5
NS4yNzQ1OTVdICBpbnZva2Vfc3lzY2FsbCsweDQ4LzB4MTE0DQpbICA1OTUuMjc4MzM2XSAgZWww
X3N2Y19jb21tb24uY29uc3Rwcm9wLjArMHhjNC8weGU0DQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+
IA0KPiBSb2INCg==

