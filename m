Return-Path: <linux-kernel+bounces-31128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B7283295F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4C71F24E92
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5934F1F7;
	Fri, 19 Jan 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="EkRWo1hQ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13904EB5B;
	Fri, 19 Jan 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705666085; cv=fail; b=RtYztz9lhqmjj6+UvJGIh4DaI+Kq8c5NPD927wI8YW0n6owEDnhlUhBw0DlbK7RGPHXjTd6W+2jmVyCZOJgbnjw8r1Zlou1MVO3MYMBNhg3Wab3bWeAoLq/PiAgvACInEWyRzBPVoPbkdSfvZW6575KQygMwRkUdQDE64/gonVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705666085; c=relaxed/simple;
	bh=89TvvE6I2/M5poS1jDIiWm1sIfVzMhDeukhfiqrulEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=meabLpSp5Eq1pmNeiku1KGHzqBHa5E+4D86LVW1mQDfWlcvyySpmGaP1xnp2i4Xw6nuHBZezcOo59qQQXCSFCmbCE58c+mAUFYTEO/E1m2CsF+ebRsIQANfnd++QAV4u9s5xuEyHhB2F80uWuoi8xm3VU0Vm37GX2U7vYelWDCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=EkRWo1hQ; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU6VY2m7/U6V/aSHiRTwftMEZL88OAjI+yUatLF5H1oAw9INSxqIddnzm0VaBVgGz7oqfcc8GJqEOvwka3Rcx5Y+Y+RSYIDQlL6mmliB2aDR5NE+uhNIV8OqQbY5vptuItAKLy5BREYr3w7HzTPpMOxU7lc6FiwuiaendIvQ68vbnTDdzEyjyJVHT3URloPYk8gMfIIeyTJLEL/jj8OtxQjRkjHZLdS5HUNqa5T7UaRkoWXiPZYj5Z61KdtyK0n74xUjjwJ8lDiDzceAdW/LAGGVNyqtygILp+6qfmz+tOZAxzVb+Vh46iGDkdDXQUQqPNJiS9fwOV5BqKAyoPXcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89TvvE6I2/M5poS1jDIiWm1sIfVzMhDeukhfiqrulEo=;
 b=gr2WxBVr05/omi2FYT+cNoQmd6vi655BocR0kg1/1hK4B4WGN3jnasIziQC4dIS9OzGVRw9ymtt0pGbuFfiEiyXi0q/FGM9PXuxAZku2ga/PAtNbeY4TYGoArBZoAxMGHbqvK77/EbJMe0lBNrcRlv97FXiybha9TuuBuKiRtbvWyTh3ToZMn561or7sP4fSMpEEvWVajJL/BupGoRIyXg3TvrniQCg9HwELqIQQan/y3r2k4tY0Iq69dpEMNJd6E1XRwG7A4eHgNbk8+HpgX/GQYYq8Yubm96miyWLsKvRcS/HtftcTCMFcped/c+oWU91eb7cmLc9PEc3eDfcZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89TvvE6I2/M5poS1jDIiWm1sIfVzMhDeukhfiqrulEo=;
 b=EkRWo1hQrx95//BSqVpvwPVZzGnhGEWfLT4jc4oagoD0GC9mER7Z/LyCcC/fLE0NIC/pWLOBS//NFLuDSOhaAtlAwAVQ/FShaKn6wA6K2cUwQzVeENbE5QzVAtZz+ePf+3iPmGogvgZN3EvkYSjiQgTuPAvjrhhbg+Ea+f+EjIA=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 12:08:00 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::1ca2:718f:8566:763e]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::1ca2:718f:8566:763e%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 12:08:00 +0000
From: Josua Mayer <josua@solid-run.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1 aliases
 to fix hctosys
Thread-Topic: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1
 aliases to fix hctosys
Thread-Index: AQHaSh83Bz2MXkS5bUKUDFs8xYpYK7DfvIwAgAFPfoA=
Date: Fri, 19 Jan 2024 12:08:00 +0000
Message-ID: <79f9bd25-a05f-43b2-8d93-5d51adae1824@solid-run.com>
References: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
 <ZalMsJZKrpwncEDp@shell.armlinux.org.uk>
In-Reply-To: <ZalMsJZKrpwncEDp@shell.armlinux.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AM9PR04MB8472:EE_
x-ms-office365-filtering-correlation-id: dbdb4655-519e-4ce5-78a3-08dc18e747da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uJm92S8mbZL9HHiu1I/g31yAHq5N08/PcvOeNN/U57awB8mxYatsunB33uMAdeZgXrMy4SG4tIrPmHj9e1JqaZjEDPNqYZ9Qx5+Oe/B87sEKMuvUTOTfOPQ6WjJwTFhvVv14jeF2lhcSvMQc4vJzWuDUGAwlHEySxO6rwxFJyU2QDlnyN0yp5fOPYxhSTYR5iJhhSPzTSLMNhyhpcB0tuP+a6P4cSCAdxxZ0UlWDuANyON96EZzXiVVvdePg2ZiwcFesP2iBzgOReJlIiv6pxpQPEJ5J1Nxe9FZnp8yl12y7u4QWS5m5NXlJovBUykJGkaPsx85sqidRm/i+b2tJPWWW6YgxS4jk472DpyMhaZ+G+tskcI0o9btmvMtcJSfUasC0JNxRrRx7YyFVqRzWQlU5HWHWkIJ8S3YrUrcJHm9Y2iR8U994MnBrA8w1NgJKaYuydWV86SZhLKkWG8pyQ9UROqeEuQdj7LXkEj47U9lRj8nGMjHuTGrnGOcPcSbaejc9HyDHUQg9RrGlqsNjvb0ZcQOZa6yQZhUXvCZY7dV34pMVvD07ofikaj1vQw0jv7rjLuo2M61jBPLnL8JS2mKTD+22RKCl/GfogEMEBFV8sjujssWcjn3b4pnuALD8pUGyzViiQIZtTMWQ28kF7FAGwjenG522GthRcJZf8f0yd6P/TVVDiPWE9EZUjqIIYqPRbc8QzoV90/Qf9+CpAA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39840400004)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(31686004)(83380400001)(86362001)(36756003)(38070700009)(31696002)(122000001)(66476007)(66946007)(8936002)(54906003)(4326008)(8676002)(6486002)(38100700002)(2616005)(26005)(41300700001)(91956017)(66446008)(66556008)(76116006)(64756008)(6916009)(316002)(6506007)(478600001)(7416002)(2906002)(6512007)(71200400001)(5660300002)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkM0SHVBWGtKMnJSUmptemM1NDg4ZlFqRVdoSk5jM20yZXdmRnRsbzdZdU9t?=
 =?utf-8?B?cFhET3FKK1JQaExRckc1SkRvOHFsczF0Q1UzK0xxVFIra2xMWER2VWw4M2FU?=
 =?utf-8?B?U3hBTHN0VEZRRVRlSTdZb2ZKc0pHdkorQ29nRXZpbXVxS3RNVCt0aE9OTHJE?=
 =?utf-8?B?cklHRW9lbUdYTy9XWlZXVFBrNk96MWRkNEJKbkVPb0ttRjlNdHF2R0ZRWFQr?=
 =?utf-8?B?V3dFbnR1cFFPQmVxTEdFMWJLR2xTNms3RU50aThNU1U5TnF6bHVxQVRTZWlr?=
 =?utf-8?B?UUtyYjF2M0x0NkZrcDRJUDU3NVVDK3NyWVlYQUM0WkRkRTRjYWVVTCtkTmNq?=
 =?utf-8?B?clR1eldkcE1GVllOZDhMUXhHcDNIUi9GUCtHZlFuQlV2QzdQWEk0VEZGdjFi?=
 =?utf-8?B?eis1SStTek9ZcFcxdm40ZnZEV1B6VFNaZjMxck9ta0VhNlphbXNubVlQY3No?=
 =?utf-8?B?emdmWG5HSGtOWWxiT0R4YUt1ZHdqU3k0Y1FPNFZmY3lBd2ZiR08yclRVbG1V?=
 =?utf-8?B?bkw5eUdSa2RKU291TTRWMEJiT0tSR04yOXF3MjBtaEFnVG1OYnBhUSt1Mk5F?=
 =?utf-8?B?b0FmTDN2TElmdklkR21Cc3VjRzJpNVh3dllMZkVIcWtKaWxLMUcyaFR1RGE1?=
 =?utf-8?B?UUx2MDFzYXQ1WGdlU1B4SjdYTVlGb01sbGd5SzZ3Tm54SGRnR2krM0hJNHFs?=
 =?utf-8?B?TzNQNzN2SnJ3ZUNVWTYxWWNub01KR1B2RzRtUW1VMDY3RVVjL2trWlJrdStN?=
 =?utf-8?B?NlhpVEFCNHVvSzh1V2VzZjlqcno3SEdmMTlhTGkxZWtJL1FBSXNobm1KQmR5?=
 =?utf-8?B?MjBlUytzL3l5UlpFZ3F4Zlh4L2FQbmVic2QyaEU4NWJiMUtUNlkyTW1aYk1l?=
 =?utf-8?B?SUVTU24zaGlMS0N3cmpHZEpySlZuT0k3dGlWQ3BYSDBIUFJ5dUlTcHFFKzdZ?=
 =?utf-8?B?L0p6R09HbUQvRHhSdGJGdXpIQXVvY0QxSWh2VjBhME1pMW0xaFRHVStOblIx?=
 =?utf-8?B?b3NNVnB5a2VkRERNUHRRWGVhNllXWSsrODhLNjJtQnd1MWFadUt3emRxR05T?=
 =?utf-8?B?YnAvS09LQ3l0WHB4RHo1dktDdmtjR2s3LytZemtqSjBUcnFZZzBjTHZMSTlH?=
 =?utf-8?B?Y1FxYmZ6eDRzR3lIRElCWjNobVpVcGVqTHZ6cTVtaWZiRmZGNEtLUUNrWnZB?=
 =?utf-8?B?MlJkdEpGL3JoeFNuQzdKbnljLyt1a0xQc2o1OVdoSFlwZlZDZWl3TW9UckYw?=
 =?utf-8?B?czY4MkZvVnpJL3hwd29Gd3QyRjkrOHc1NEtDZnZ1QTlwbUhpendrZE1rYWpB?=
 =?utf-8?B?bzM5dFZpQjh5OGtCWjFHMWt5dFdsSlRweHluamE5S0VUYm5oRHFmUXFkTVh2?=
 =?utf-8?B?MGE5UGhCVkhYQUY2cXRTam1nK0t5cFA5akZBSlJYeXBqNFRBOG4zeWVuQ29W?=
 =?utf-8?B?M3FlNjN5dkRxQytiN3VDTHpzaVNPZXY4cGNxYmpPeHNETG90VlI4VWt4VFBI?=
 =?utf-8?B?ME5BTW52ZTFlLzBRc1JMc3NkL0E0VjRIL1M4ODM3NFpjakUzWkx2U3VYWjBS?=
 =?utf-8?B?aE4vSUc2UnNuaUFUQXVIRmNIeVkxM29SMlJwL1FnUG1ZZytUaWNzV3NxZTN1?=
 =?utf-8?B?UDlKZk9LbnRxV2pBN1IwUVBzdEpBUG52a01nZ2hXU294aWdWMjlWMkhMZE5x?=
 =?utf-8?B?OTloenIvVy90TllBcmJ3elZpUG9WcENhMlJEYW9mcXF5S3Y0bkNYd1g0YWM4?=
 =?utf-8?B?SHUxbDFHbVI0eHVDT0d6Rmc2YnZIcTErVHVHVUFsMXlCai8yQUdrRzUzeTRi?=
 =?utf-8?B?YlVoL0Q3TzhJV1lxaGlyUmhkMUVncnZ3QUlZOUdyNmM5ZWZJR0NmV0ltOUtw?=
 =?utf-8?B?SCtHdHdqUUg4TFFHdmlNcnZXVXNTLzNxVXU2bkVkVGFtblpvVlFzSG5qRkRi?=
 =?utf-8?B?L3hFaGNwWXB2VWpaSE1pbFFxaGhEWVhKMnB5ZDU0RGJ3Sy9jK2taUXVkZGIr?=
 =?utf-8?B?SFRNMzJHN0JGZWE4OVRjS0tEemdqamlsYzR2c1pYam1jV1VacGNjZTNGdko3?=
 =?utf-8?B?SnRlL1NoSStsSmF6NUl3YlJYLzEyeFAvMndGTkNXYUoxYm9GK2xhTkF5d0Fa?=
 =?utf-8?Q?w6+39NFP4iJV4EPliUcNilJBp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C5A38E676022F479147981B7868E1EC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdb4655-519e-4ce5-78a3-08dc18e747da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 12:08:00.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gB9RBDtgM+Ql1EXNpzuJwLYxwp7j2sTl8hf1mYZhh1J31PKfdDbbOaWbzOQjDYRFZP0/Wf/nMwM2tMkufjalVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8472

QW0gMTguMDEuMjQgdW0gMTc6MDcgc2NocmllYiBSdXNzZWxsIEtpbmcgKE9yYWNsZSk6DQo+IE9u
IFRodSwgSmFuIDE4LCAyMDI0IGF0IDA0OjAxOjEwUE0gKzAxMDAsIEpvc3VhIE1heWVyIHdyb3Rl
Og0KPj4gSHVtbWluZ0JvYXJkIGhhcyB0d28gUlRDcywgZmlyc3QgaW50ZWdyYXRlZCB3aXRoaW4g
U29DIHRoYXQgY2FuIGJlIHVzZWQgdG8NCj4+IHdha2UgdXAgZnJvbSBzbGVlcCAtIGFuZCBhIHNl
Y29uZCBvbiB0aGUgY2FycmllciBib2FyZCBpbmNsdWRpbmcgYmFjay11cA0KPj4gYmF0dGVyeSB3
aGljaCBpcyBpbnRlbmRlZCBmb3Iga2VlcGluZyB0aW1lIGR1cmluZyBwb3dlci1vZmYuDQo+Pg0K
Pj4gQWRkIGFsaWFzZXMgZm9yIGJvdGgsIGVuc3VyaW5nIHRoYXQgdGhlIGJhdHRlcnktYmFja2Vk
IGNsb2NrIGlzIHByaW1hcnkNCj4+IHJ0YyBhbmQgdXNlZCBieSBkZWZhdWx0IGR1cmluZyBib290
IGZvciByZXN0b3Jpbmcgc3lzdGVtIHRpbWUuDQo+IEdpdmVuIHRoYXQgdGhlIHNudnMgUlRDIGlz
bid0IGJhdHRlcnkgYmFja2VkLCBzaG91bGQgd2UgZXZlbiBiZSBlbmFibGluZw0KPiB0aGF0IGlu
IERUPw0KSW4gaW14NnFkbC5kdHNpIGl0IGlzIG5vdCBkaXNhYmxlZC4NCkFjY29yZGluZyB0byBK
b24gaXQgaXMgdXNlZnVsIGJlY2F1c2UgaXQgY2FuIHdha2UgdXAgdGhlIHNvYyBmcm9tIHNsZWVw
LA0Kd2hlcmVhcyB0aGUgZXh0ZXJuYWwgcnRjIGNhbid0Lg0KPg0KPiBBbHNvLCBoYXZlIHlvdSBz
ZWVuIGFueSBpc3N1ZXMgc3VjaCBhczoNCj4NCj4gWyAgICAwLjkzMzI0OV0gcnRjLXBjZjg1MjMg
MC0wMDY4OiBmYWlsZWQgdG8gc2V0IHh0YWwgbG9hZCBjYXBhY2l0YW5jZTogLTExDQo+IFsgICAg
MC45MzM1MDVdIHJ0Yy1wY2Y4NTIzOiBwcm9iZSBvZiAwLTAwNjggZmFpbGVkIHdpdGggZXJyb3Ig
LTExDQo+DQo+IHdoaWNoIHNlZW1zIHRvIGJlIGV4aGliaXRpbmcgaXRzZWxmIG9uIG15IFNvbGlk
U2Vuc2UgYm9hcmQ/DQpOb3Qgb24gbXkgSHVtbWluZ0JvYXJkIEdhdGUgUmV2LiAxLjQuLCBidXQg
aW5kZWVkIG9uIG15IHNvbGlkc2Vuc2UNCnVuaXQgdG9vLCB3aGljaCBpcyBwcm9iYWJseSBzYW1l
IGFnZSBhcyB5b3Vycy4NCk9ubHkgdGVzdGVkwqBpbXg2ZGwtaHVtbWluZ2JvYXJkMi1lbW1jLXNv
bS12MTUuZHRiLA0KYnV0IHNvbGlkc2Vuc2Ugb25lIHNob3VsZCBtYWtlIG5vIGRpZmZlcmVuY2Uu
DQo=

