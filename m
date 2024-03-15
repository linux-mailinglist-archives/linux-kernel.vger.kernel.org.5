Return-Path: <linux-kernel+bounces-104441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1012A87CDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344751C20C12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953EC28DB5;
	Fri, 15 Mar 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P2HOXc57"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB72562F;
	Fri, 15 Mar 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508423; cv=fail; b=IwvDhH8AgPT4Fuy9IBWQwau9N8suPWwMVQQmynT2hIl7ry9T956OvtdTCxlQe+H2GIXBMayuRDF0kM+PXUFCoi6tRFHoD86uTYSVoTj+ahYJGH4mp0a3DDJC0d/fGJD8m65kjL/9+STYEXx5fYkAeWiBdYcBID93NHT4qkajEyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508423; c=relaxed/simple;
	bh=dCDT9hFUrQK7vSMwHYHiwsr8a6b+f91Klm/rSmEN2Jk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lOXpE8ZbWlaQmPujbx8bNO/28i6QuTYG/MwRn2/u+3cOfT+ou9kDHVlCjSqXRw3r13h6DSRc/BI5M8q9+0GSwTfPh6BPvrryQI2Y42B8Xj4G0dhz/2g6XhQcPmPXES6kdq6rdtd1RpG5+GbFz6CmPk06WUssJiHy7Ih+AZSvS4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P2HOXc57; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM0SLeVgX1l+BOJQ5X4tC3AF2XkOAoitHihZ6X0LmUbBtR3KOs0IZYExJjuYqNzH/pXODoRLeXyjY693ymwhGkt7kBEVospgaXT98NNxAe2/EUZJC609CYlDCd+V9GwSlkOH0TCtBBtCPc7v+cRQqih+lB166sp3vYRxX7OvWPslHEferhsOJqzbP5xAC8H0AC5TXe0SfIdPg2apeXIw8F5OTsuIsGr97Ca8aglK/8tOv7psIuln7D3mCEascBi6FybWAis6qs6BqTi2A0HnerVxI9ba8TUSauZh/W1IuOUiD0O9XrPeWghnPtTDgL6Rs4nuDAFGL3sAtLc2OXEd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCDT9hFUrQK7vSMwHYHiwsr8a6b+f91Klm/rSmEN2Jk=;
 b=cnxloyGk/lgDHXzxVtmxjdXybJurgzUj6u+tu7Fo32pvLq21feWOr6ewPcTMgTmIWRNw1eD8csOnCGV/eO+oFJ5IN6IJG5S63XSqAkFhF1fKotC4+8LdUZxW5pxDrrabc0piAZQXfpQfVz05jhtiWb37vGWMpnY/YJYZ/nlkqLNDMsW0ymuL2vSlm9aTJhcPMfgHbpfkO80wBpOdeLkwv/A953ZwQeZaTjpcOP9JbLxjR8SXmzP0CBvi11uaNxTLSzGC1oj7VBvzdrUxMLUfUbShBHmWj/SFDcBBDGL0kYDtJgqJccYZ977W3CUe/zQ7HiOseAv5TTOa3HhsRgphYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCDT9hFUrQK7vSMwHYHiwsr8a6b+f91Klm/rSmEN2Jk=;
 b=P2HOXc571M/gx2vUzD5JNqshueyPz00J/I7aln/Iyo1fPsUR84zcZEOMduc9MyZf1DIorcu+D1RoPPbDdgdt4e/mwF6cgI5u6+R7kbuITG2JaekQlQs3C/EKEJ0pjBd09FBcdchNw/YllPcG6yk6Wo4ilD5+7ALxxev4rks2AhA=
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by VI1PR04MB10075.eurprd04.prod.outlook.com (2603:10a6:800:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 13:13:37 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::286f:8b1:d00d:4e0d]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::286f:8b1:d00d:4e0d%3]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 13:13:36 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>, Rohit Fule <rohit.fule@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, Geetu Naagar <geetu.kumari@nxp.com>
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on
 startup
Thread-Topic: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on
 startup
Thread-Index: AQHadtqWzE/qRAPwnECM2f3GC2+Jzw==
Date: Fri, 15 Mar 2024 13:13:36 +0000
Message-ID:
 <PA4PR04MB96874E4B23D6C225AE1367F4E7282@PA4PR04MB9687.eurprd04.prod.outlook.com>
References: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>
 <20240304192952.GA17410@francesco-nb>
In-Reply-To: <20240304192952.GA17410@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9687:EE_|VI1PR04MB10075:EE_
x-ms-office365-filtering-correlation-id: 8eefe2d8-9e6c-4be3-e01d-08dc44f1b940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cc5u7LZyiW3D6IsMZujyd4sUvCUF8PnEh9/KAyVIcizrCe4a4sSG9ow/HsmZTkdprrW7SnmTpM/LnxwGDR1eR/0SuIb3ov7jXV2bGooqDYBxcAzA5fhGNqHpvCd56cpCz9kjTBZLKz19QT0fOYTsFmf93pGuvhmNeBlWynIUw+wT5xtyZCBzXNdin9W6c/bDdiYvwqQEGinbvZaLlfIBM9uj8h8vKzJpOKysT72Ao0tUxzVHDd587tLqOrGoPi/vim7IO3on7P/NMS5x7GqFd+P070i5dv/KcXR7V8BLNrzF6HOBAj/dtOrsLHTEAq58Uv0tYt1OX3eV31oOlcZX+HAiuzScbf4u9m8NJiyxsixUKKv+zsTp453yv8AgHXFQ8ELwxlajh3ph7CRLZNYlgQWveEEXrSrnGFufDWOHLCHp4oL9hlebT/uZUVWcC8QiRpQeJbdnq9hqDKl0tjzPCmPlbV6QOXP8FxgL3tu9GAyD4GUuuDheaJyde7UYbIoOQRxv2h9iQaayJsmIkkAtMqLXs4a4Cytiua3/bHSuTxmp2MmA2d9KXOtj1X1t+0F7pq1PbD7GD9q5qQYc33ufl8wBtSlX3TAl/5RBiqa+Kn66rfS9nSAPAGwHG3moAy7SNatD+tpe0IlRhELYsfVyBrTE/uzbmQmf8XX3oeXaOSRHm8UtGuVn7lbwVf+0l8V7DjGuNBD57B1wFLrMnN5Vjr8A1cIidmiBl+uZe/eTXmU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+jtX/6BFKhemDtWiNtq7OmuQD6NqlavOGL6YRhbl0T/gPiMkfXOUJjIKZYgK?=
 =?us-ascii?Q?vzF+rgSiNvQ5SWF7vCi3Egytdg9sJpDlBNn7NBVAuxZUiqLA60F2CFMdMppb?=
 =?us-ascii?Q?SrSC8ipTWO5+lr1+r/VP2dp3mduZnEm6cYaEdTjPrkv4TBZO5wdNjheu0oMA?=
 =?us-ascii?Q?2g0i//vnWZRm6/+P0fFaKZlNpLVE6hIpAYyrMAQ4m0+apWvY7x9NIlMEpXho?=
 =?us-ascii?Q?op0xFUPqUbG/RxgICnu9uBdbjoBv7qbX/v8PGAfFKJ6ZMTRZ95BSPH+ybcBf?=
 =?us-ascii?Q?uvNevuWjY3S9g+Igny/QcqvCXPlQrbwu5J0sT545Xbo6afnVLg1HB6Z37Jtt?=
 =?us-ascii?Q?KIExzZ2qP+wCasjd0tAnvAjp6zlyoOLQoN2SJutl1EpKZN5/4e6seLA5JO7u?=
 =?us-ascii?Q?Pd1J6wxgDRtOpTFIY4Pmsp5wtcTTIzFRoVWDVRpksj6hMwwAlIJtgRmMiTS0?=
 =?us-ascii?Q?p/ClKIrKL7NJvSzN6UXMXuUx0DzV7pOmtCTC3wqclZMIwBEfr+S5lPZGlLKS?=
 =?us-ascii?Q?Pi1jh6TFsYSSk9Au60J6ectQHMDh6cWZEzUlCZ8rcdQpZAzec1L3zJaz0oG2?=
 =?us-ascii?Q?fkeGL3hAoyK/dKS7m5P98LR1i/ujSJZbFx7CdAIPR846o2Yiv8+8tZloCbCP?=
 =?us-ascii?Q?ZZOxq/hwccbtOgbIFR6MghI63mqotWt5NkMLK8/LYyd3+HjKX0ncxPsyg2XG?=
 =?us-ascii?Q?8jWCP6mASNA2GWf4/SEaZu4SeY3Y0LJaYkKktHrSjblQEkTg1PJxP/ZzGyoj?=
 =?us-ascii?Q?m40dBpHMLiRHpmmAtDWat8ZB++RtNZllge9uN2qALOwoeCPORJpxv5lDN4BZ?=
 =?us-ascii?Q?5X43Gb+lDbf//tpI6C7bopiINrY0iBA5xe6GFCrsawsjmLEwS0pzxmyKtk2C?=
 =?us-ascii?Q?zmor/y7vVWieRku913sx5aJraPS3vKkolYofnHeZrfzdMEqCSP/hffkp6VE4?=
 =?us-ascii?Q?o6uhsgfDYN58Pl91zg2JNKo3gGo2vkKInGSpAlAPmiTMOUZJHaaiL5ghCS29?=
 =?us-ascii?Q?ypdpT334KjWt8DOPPZOXE2mV4TYZA++UmPhmhrq0xFmz6S8JjfeMQS8krouv?=
 =?us-ascii?Q?3TTdGRdKqvG3HbtfAzaApmjkYwN37kyNXz1cxeExgAxUyn0Gw1gfZfZbQVKr?=
 =?us-ascii?Q?AJpPMQgxXfXTa0fSdDAJWSP+Qu6pyIODJPjGm1p5COyNU/mfMRwZ+Cy2hKZ1?=
 =?us-ascii?Q?KLRjVphLw9aSUXNVaK56P/sNWhE28/jRrNE17gQQI4q4JpJUwbRc5Te+rDPt?=
 =?us-ascii?Q?1WyNT/70fchnxQm+Gys2wdsQ83Zxhsu7PZav3BEuF4ZfLpuTus5mR9NUPG4g?=
 =?us-ascii?Q?ARrCmGMJ18JtPe9CwnyJQPCL0Ng5c8L61LLIlfLva/+QQaQcJVNOeLLs6JMQ?=
 =?us-ascii?Q?QC8l+cs0sDNYy/A6argUpO3r9bkoLQQtowCZoGAkDi+mteypykXwbuFV8O5n?=
 =?us-ascii?Q?24rZOiOLj9umSDDv1Iorhn0pvQaSt/2Ci5MQ0xYZpdCh1tiu3Nl544kC/6AT?=
 =?us-ascii?Q?jG6acFlJpqDKp+Nh+c/SxJxIjuEq4K3l0encpNcrOakPSwSWlidNsl/mCH9I?=
 =?us-ascii?Q?xFEjEhMwhUN6H3hJOX9c1uId0CuC2xfe9mJtV2Ca?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eefe2d8-9e6c-4be3-e01d-08dc44f1b940
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 13:13:36.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olwbtCQwmajGuOQekZ3GHFtCT3qG9zbyMzhYmTEq8UTG6voDNoaPw+RNzVOoMs03jSeWnedYIH2C+ZezEEeHpFW4n62O5IYtpMGfPHWs3w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10075

Hi Francesco,

>=20
> On Mon, Mar 04, 2024 at 10:37:53PM +0530, Neeraj Sanjay Kale wrote:
> > This sets the default power save mode setting to enabled.
> >
> > The power save feature is now stable and stress test issues, such as
> > the TX timeout error, have been resolved.
>=20
> I assume that the stability issue has been fixed in firmware, correct?
> What's going to happen if running the updated driver with old firmware?
> What about combo Wi-Fi/BT firmware files, were those updated? I'm
> currently using this driver with this firmware [1]

There were some stability issues in the driver, that are fixed in previous =
patches.

As for FW, I have checked internally and there were no power save related i=
ssues reported for any combo FWs.

I had requested our QA team to perform basic sanity tests for WLAN and BT u=
sing the exact FW version you are using, and there were no power save issue=
s reported.

Thanks,
Neeraj


