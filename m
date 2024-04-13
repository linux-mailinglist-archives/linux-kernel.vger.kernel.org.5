Return-Path: <linux-kernel+bounces-143591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0CF8A3B32
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6511C2211D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32E1CD16;
	Sat, 13 Apr 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KblqiJp4"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804B19470;
	Sat, 13 Apr 2024 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712987807; cv=fail; b=ecxxRbDKSKNodumtBeyFBFkW6Poi1x/7ryoR5rYkqS1tr2OHgnTJsX9yVAXgtJd1xck+UWz4sG4XO+UBHC8Hlf2UYrvRRcZFNvhUG6czWb+0vWZ3IA/FlKAqvOtpadcV+g9mCi4NgaUT3mpI8gUlMtKcPx6zcxJaX94+6umWRjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712987807; c=relaxed/simple;
	bh=lk9/Ci1BMpcOc1emPWURPcleLYxWbDXIXWID5nRKWcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N82Wm/5zd4WQRdgkL97sbG/n63cwtCsaQclL9VcBwPTBGZJm2a9/sfastc4Tb2BVlju6azZw6TNADPtcwsStrjHoeGHvKJ09lwiCRHYO2WIJsLQNfsMuyS7PnO/wD7ntbndet2By98uAZTRQ1rgBFZvl++m5jnqhju5t/wppgvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KblqiJp4; arc=fail smtp.client-ip=40.107.104.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP50utX7u/3lxd8ryS1QV+jS4us9ek+By5ewxvMq50rPPCzH0MVzXXJRXrFG+ifNlJ/1gU4KBujT3s262fxOEQ9poC/Fv565qwjyD5fSqb1RbKm1qxjFkpML7e2dzC+AOsdKS0HiiGV1jBLzRq2m29ycZZtjo5PhcN2wzm9F5jHUMxhSPWt5/owuTCuDGgsGZfODiMDYQbedxFMoSxveNvrL7tvf71o9DfBN4uPqEuRvXo5MCqN45287RWRiLv/eXRXd7vfNjdDV6MiWqGQgTlz9I+jJuKOYVtb8hf784W6nerrt+p3BIEvgXe2Q1f1XAGmzxI9BgyjOeK4dFuQxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk9/Ci1BMpcOc1emPWURPcleLYxWbDXIXWID5nRKWcY=;
 b=Hg1am+xsMe6F9D0SqPuJEjGabc0qBo813Uvd/DFVJ9xeJ55j3pjXqC3IsV2PlyPJW1/CyvsX5r1v0d+Pp9UWw7yUy0f64XeDLy96zVQWqzFZ+Mm+Q+T8sOSoIwOJDtYLVLojnTir+2ael1f6C769zuWoK7dZXN303fTCDQX0jLv1qv7ozSrf6XWBznSTQRHCq9RTyGSzMdOflMsgsIoRSbuX3jgYaeEGQ1zlTf4jCXvMnvnGMCQV1DorPLxMxlptkuqeChvWI6vNViA0CZq/+RR3iM/lc0zyvACztenx1CRT7IyIy3kcLKQZrF5W5YAczyL9SuOs/QNLLMoMEZDKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk9/Ci1BMpcOc1emPWURPcleLYxWbDXIXWID5nRKWcY=;
 b=KblqiJp4syfSA70MUu+9WgzvduBnJVZHcOY3WWjShYRZwaK2Dd3CoJq1l2eBw4PzH/i3nsogmoMi9Uny52E01wLc1hXmDeSEranbq2/mZl6v12hPWhn2laNSTgdaphwicQcvo0NMFZeSnnu1KIesBecIZUB2jWk5BMPfrVUll9Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9095.eurprd04.prod.outlook.com (2603:10a6:20b:446::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 05:56:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sat, 13 Apr 2024
 05:56:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Peng Fan <peng.fan@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: pinctrl: support i.MX95 SCMI pinctrl
Thread-Topic: [PATCH 1/3] dt-bindings: pinctrl: support i.MX95 SCMI pinctrl
Thread-Index: AQHajG9cdUkQ2lgZgUStYTjvuii937FkvlsAgAD3U1A=
Date: Sat, 13 Apr 2024 05:56:41 +0000
Message-ID:
 <DU0PR04MB94173208D86117ADA0BB28F5880B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-1-704f242544c1@nxp.com>
 <ZhlO/oT8BXupXyKP@lizhi-Precision-Tower-5810>
In-Reply-To: <ZhlO/oT8BXupXyKP@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB9095:EE_
x-ms-office365-filtering-correlation-id: efe4bf6c-7c4b-4b76-ada1-08dc5b7e7db4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aJwLl6jDUM7+nGsK7d1SDPGW4g3cBLdSB2+z+y98cFo5B/70+SIUn+5l7bPZgQfdA/C4EvuHNCVVMHwGepR76JhlCOrYS0RFGsdeFNliZ/lpP5onrtXPzdEtz/oWpGwVbRoMi+mmekPo+QC5Ry+B0uXQxtGnokpdcfoFnnRDiKTvMkP+hepFYGFd6c1G/xrT4Ck1YYwWAQSpPj3HtDh0LuvhHmFtLKh8iq/fpA94gPWet7ayL6VwKC1ySDmx5q7bZmGwjR+G/d2suGME8g53z1a1TwCL2wJUDVdR/KHVE4mJnaqxrb1ZJfBvYZbxPBCBK/IfC9DTd15Jt8IR1AgpYJUJuf+OEETk1SxwtCI6RR4NeQpM/wGWyKG8EPajQ1hbGByqiXpofWX3afRcxWM/+f1GKCuAOiCn5mxL8YenEEwq6iLB9B8NaBst0I7erpE9xlqBrmeER4Qvt5QzzdV38/bX5K5/dqPZMYr7FF1i7zR1FDWV8QawfqEkxGjqzQuSjISpyDp4bzORU7yBezNJHUnLsL19wQ8pQfnxWonEPVIlIUofyPwW2mNMFM/gxwT5d/CZWrOWUh1HslhJSylt7ev2A+HMOVOHDFnMvrEh9mAansmNnvwRQRV8L7tZdRNuOHf5NBmMoxxKr6c8pKVceKJhG5Le45NZUwsMPNWU6Z7mZqWvbWOA7vL3eN5GEBAT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXgyZnozQ1RZTkkyc2I0OGhxR01DV1p0U2R0cEQzZ2NmVlBNenVKVjJnSUhl?=
 =?utf-8?B?b3NIVzdHZkY2VGFEZDRIOHpTRFlwWmp3STRpclJnZzVnbnNUdGZnRWpCQ3ZX?=
 =?utf-8?B?Yk5rRWdhVVNyTWMyWTEwdXVhVFppdmpDQ0krdytMQnB1NytDTS9vc3E0Q3d4?=
 =?utf-8?B?cFNuMnlmVURwdjMxTUh6YXR2N2svWVQ4YkhaV0h2em9ON3NCWnNpb2VFTVVu?=
 =?utf-8?B?QitOS096WERVcGJqbFRzdDdUdjFBTzZydEV2V0lDb2ltTlJGcDlzVzVPdUtk?=
 =?utf-8?B?bVNVcHMrZWNFRTdNTmU3cEsrOEIyNjgxQ1VaUEVKRUFXSWhYT1dWeE5WeUZH?=
 =?utf-8?B?UUlPM1NRNlRUeWszbHptUjI2NWVkSmgwb3F6YjB5cGRJcGozTnJnMTZCVW5Y?=
 =?utf-8?B?SEtubFI3WlhtZEE3TktGYzF5TWdIWVhxWW41dmdpZDN2YTkxSFdkMkMzWjZQ?=
 =?utf-8?B?QkQySGg3Nkw3bjRzbko0MHU4RUM4OUVpcjFHNnRpYTlwdmVZVGI4VGNkQ2ls?=
 =?utf-8?B?Umtqak54ZGtNemRDR3p3UFhiMmxES2F5dTZmT0prRE1DQWcrR3RjWnBlZjlm?=
 =?utf-8?B?dnFLYzE4MWNVYzVIdUFkd0VseC83WFNKTWZxbkZsaUYrOU04UXQ3VldWajhE?=
 =?utf-8?B?Njh3b3RIU1g4MVF2NTBUU3AzNi9iWXZralNJZEFiVUM4MjJXM3lLTk1RZE5l?=
 =?utf-8?B?QUU3emtwK1F1ck9CcHdhSklzT0NxK2NYOU1oWXYvSUgrZkw5U3ZRWkZVZzFq?=
 =?utf-8?B?UkprT0RiOXJCTTVRVEluV1lhVUQvT1FsVnpPLzZVYU5HWVZHbzVuam5jNFoz?=
 =?utf-8?B?Q3lVdE5xeWxDRmNjYm9WYVNQUU9MdTVKVjFqK21yaHJENnJIVzR3aWFnb1k5?=
 =?utf-8?B?eUE2NnBRbG9NUHVKM3JWVUhDMnBYUUthVG1ZR2w1c3FoVVdmUm85dFE2L29O?=
 =?utf-8?B?dFIvNXFBNlhoaHdGQm1INHNiVWU0b2hSa1NQSTdRR1AvZ3diZVdicmVocmhu?=
 =?utf-8?B?ZDM1dEJ4NWZ5L2dFQXJBWVl5V1BwRERpTTgxckhKcFVuUDY0RlZaU1NzUmJh?=
 =?utf-8?B?VW8zc1NiYmUybnpoaE9qclF6ZU9uVXZtaHJQTy9WcElEV09EbUd3dDUwWUQ1?=
 =?utf-8?B?T1N6S1NEY1M2OHU5ZklMb3UzMEQ4TG5YR3NUTndEMHhSdXZHc1FhSmFaNHdP?=
 =?utf-8?B?MkFZV3RqUk5KSlNQS0lQYk1FQlFiY005WEZJdjRhNnE4MVA5RGZlbENJRzBo?=
 =?utf-8?B?QUdDVGtCeHVpS2x1ZHpQa3dBcldTTVY3dS83eUcwblVVRHZMNzdoTnJiVCtH?=
 =?utf-8?B?NkZJWXowejR4c1poMFh0WDduNG56VlpIdk1mUEh5QXBvYWpEK29tSHZ5L2lP?=
 =?utf-8?B?RFd0TnVQUUt4bWw1K0tqUVRUTHdBbEVEVHBPd05UVXVjRjdXSXBTM2hLOXFB?=
 =?utf-8?B?ZWc4NXJUNE5rZlBuWkpiZVUxV2t4SU1CUGpGbVc5T01qMnJxYzF6bW1tZnFp?=
 =?utf-8?B?QVBCcFM3cmRkOFhIM1FLUS82cUdsWVVZcmxFWCtEd1NNMjl3SWt1dm4vQjNC?=
 =?utf-8?B?cjVZQTlzZ1QxZ2NzSlRFM3pWQW02OGJVeXJJTVBDcTFMTVlRWXJ1QTNNTWhL?=
 =?utf-8?B?QzYvMGFPZ1NsNVRrRUJ6cU1VQ3VrU3F4bUQ2UFJaMHk5UGMwdUh2dzBJY2FD?=
 =?utf-8?B?TXUzNTZ0ZU1PczNka2o3cmZqdzczNGxlVFc3OGZtZDh1T25TTStWT1lENlQv?=
 =?utf-8?B?NU5jbXZRci9rTDVuelluUDNlWFc2YTVBT0ZYTWFCcEc5aktaZ0hXeSt6WHps?=
 =?utf-8?B?R1laTEsyUmxQU3FBU2tlSC9OdGk3b2pTb3lsMHNZcS9WYzN1cTZiODNIL3VQ?=
 =?utf-8?B?VjcwZ0k1T0NrUXp2RCs3NFRoL04rOHdia2xvVkFGcy9BVFcvVlo4TlMyNENk?=
 =?utf-8?B?dzEzcTVROVR1QWZZWks2aEhTbmloZmlkdlZUYUdoSUtNK2pYQ3RoS2E3cmNw?=
 =?utf-8?B?OW11M1diK1dWclpIME0zMUJqTkJmNXZVWjZnYVhMSytzVWd1dmlCNEc2aDZN?=
 =?utf-8?B?alJsOXN2V1d3bDR0eWtDNThQSUpEaUJGbEpUOVJDYWhraUJaaVZid3JTQ3Z6?=
 =?utf-8?Q?w4wA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efe4bf6c-7c4b-4b76-ada1-08dc5b7e7db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2024 05:56:41.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QOQjzhd0SNOWaXYSOpZY/anKEN8WLERQ+qUjO0UxqjuyTvNAitm/FsHARjwJ5i37updOo7EU/Hr0Y7PR7HCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9095

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IHBpbmN0cmw6IHN1cHBvcnQg
aS5NWDk1IFNDTUkgcGluY3RybA0KPiANCj4gT24gRnJpLCBBcHIgMTIsIDIwMjQgYXQgMDg6Mjk6
MjVBTSArMDgwMCwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOTUgUGluY3RybCBpcyBtYW5hZ2VkIGJ5IFND
TUkgZmlybXdhcmUgdXNpbmcgT0VNIGV4dGVuc2lvbnMuIFRoaXMNCj4gPiBwYXRjaCBpcyB0byBh
ZGQgaS5NWDk1IFBpbmN0cmwgT0VNIGV4dGVuc2lvbnMgcHJvcGVydGllcy4NCj4gDQo+IA0KPiBE
ZXNjcmliZSB5b3VyIGNoYW5nZXMgaW4gaW1wZXJhdGl2ZSBtb29kLCBlLmcuIOKAnG1ha2UgeHl6
enkgZG8gZnJvdHrigJ0gLi4uDQo+IA0KPiAiQWRkIHByb3BlcnRpZXMgZm9yIGkuTVg5NSBQaW5j
dHJsIE9FTSBleHRlbnNpb25zLiINCg0Kb2suIEkgd2lsbCB1cGRhdGUgaW4gdjIuDQoNClJlZ2Fy
ZHMsDQpQZW5nLg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9waW5jdHJsL254cCxpbXg5
NS1waW5jdHJsLnlhbWwgICAgICAgIHwgNDQNCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0K
PiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbnhwLGlteDk1
LXBpbmN0cmwueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bp
bmN0cmwvbnhwLGlteDk1LXBpbmN0cmwueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMDAwMDAwLi40YmY3YTYxOTI4MTMNCj4gPiAtLS0gL2Rldi9udWxsDQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbnhwLGlt
eDk1LXBpbmN0cmwueWFtbA0KPiA+IEBAIC0wLDAgKzEsNDQgQEANCj4gPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKSAjIENvcHlyaWdodCAyMDI0
DQo+ID4gK05YUCAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvcGluY3RybC9ueHAsaW14OTUtcGluY3RybC55YW1sIw0KPiA+ICskc2No
ZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiAr
DQo+ID4gK3RpdGxlOiBpLk1YIFN5c3RlbSBDb250cm9sIGFuZCBNYW5hZ2VtZW50IEludGVyZmFj
ZSAoU0NNSSkgUGluY3RybA0KPiA+ICtQcm90b2NvbA0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6
DQo+ID4gKyAgLSBQZW5nIEZhbiA8cGVuZy5mYW5AYXJtLmNvbT4NCj4gPiArDQo+ID4gK3BhdHRl
cm5Qcm9wZXJ0aWVzOg0KPiA+ICsgICctcGlucyQnOiBmYWxzZQ0KPiA+ICsgICdncnAkJzoNCj4g
PiArICAgIHR5cGU6IG9iamVjdA0KPiA+ICsNCj4gPiArICAgIHByb3BlcnRpZXM6DQo+ID4gKyAg
ICAgICRub2RlbmFtZToNCj4gPiArICAgICAgICBwYXR0ZXJuOiAiXlswLTlhLWZdKyQiDQo+ID4g
Kw0KPiA+ICsgICAgICBwaW5zOg0KPiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL3N0cmluZw0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBuYW1lIG9m
IHRoZSBwaW4NCj4gPiArDQo+ID4gKyAgICAgIG54cCxmdW5jLWlkOg0KPiA+ICsgICAgICAgICRy
ZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgICAg
IGRlc2NyaXB0aW9uOiBoaWdoIGltcGVkYW5jZSBtb2RlICgidGhpcmQtc3RhdGUiLCAiZmxvYXRp
bmciKQ0KPiA+ICsNCj4gPiArICAgICAgbnhwLHBpbi1jb25mOg0KPiA+ICsgICAgICAgICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgICAgIGRl
c2NyaXB0aW9uOiBsYXRjaCB3ZWFrbHkNCj4gPiArDQo+ID4gKyAgICAgIG54cCxkYWlzeS1pZDoN
Cj4gPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzINCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogcHVsbCB1cCB0aGUgcGluLiBUYWtlcyBhcyBv
cHRpb25hbCBhcmd1bWVudCBvbiBoYXJkd2FyZQ0KPiA+ICsgICAgICAgICAgc3VwcG9ydGluZyBp
dCB0aGUgcHVsbCBzdHJlbmd0aCBpbiBPaG0uDQo+ID4gKw0KPiA+ICsgICAgICBueHAsZGFpc3kt
Y29uZjoNCj4gPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogcHVsbCBkb3duIHRoZSBwaW4uIFRh
a2VzIGFzIG9wdGlvbmFsIGFyZ3VtZW50IG9uDQo+IGhhcmR3YXJlDQo+ID4gKyAgICAgICAgICBz
dXBwb3J0aW5nIGl0IHRoZSBwdWxsIHN0cmVuZ3RoIGluIE9obS4NCj4gPiArDQo+ID4gK2FkZGl0
aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo=

