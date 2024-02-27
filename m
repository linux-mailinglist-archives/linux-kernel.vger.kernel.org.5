Return-Path: <linux-kernel+bounces-82486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D11868538
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D08F285BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA094C7D;
	Tue, 27 Feb 2024 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jr3yGvQG"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DF3D71;
	Tue, 27 Feb 2024 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995120; cv=fail; b=SM+Z9/rL5w84KqTG72CkMRudSFZY5fWybUjDwcK9poMsunnQl1SEBcUEN88MLJiZoXcGa21a9dLGRUHG4M8daOlmJZ0wx9hE/f/siMGaN2bG3+bIpddsCcGYLk3zHfppzayJftbWPSM8TLM278FFvstq23I3nNJ9moRgB+/HbsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995120; c=relaxed/simple;
	bh=X8vYQrm4uIiA8pNpCPMvu8MjvXY6i1v1nDOFc+vivb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rDTTwfofLD8J1eND7FQw9fJ8XvCQ+plQTsgfBKeU0HUWmjxFEKw4gYPrX0h0UpESYJ530syz47+F/JGfOksYA5sWDVuAxqOTDoPtKl2SLveuc9UJFQf/fNmnQp1vNQoXT1n2JIZ4h+x0LNaYCYn927HWTd7J7R+XpoG2E/n3xwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jr3yGvQG; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYO3t6K8ZAl7T9EmSg2/MrMZIDafug3a3n96XZ6Upq0N0I2gyQ8H1dkP3pz/9BpP7NnBKRWgXKiigqqIT9W/efqD/5C2ZTEoIQr4SpgU3GjpUzS1vhV8CM/JEN8mgSJa8WtyUC6em52+t018oVJl4ZCqHKTQJSiALKWkkKmoG4MFrS8E2+nDJkaPUBIBs5hC4pMvqX0cI+Xu11IxZltv1Nt+mCl3wi/DnbuU0eu4t/aVV2B5ttfd10GLFu+AcR2f+tXqpL4UWMDGTLHCjeqekVx810zik5yM2kyWHlMG6ty0iQ5AL6sX8XsahCtB0h0JT7eEEub/RAxEhlhBnlCa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8vYQrm4uIiA8pNpCPMvu8MjvXY6i1v1nDOFc+vivb0=;
 b=fBZFxSdWVSwYunMQ3IHxu3l0llnvnNEuMzSa3O/ZNAE3nL3i7zjfyJZRUG7T5v6VoRbwvFoaMtAZaVV3RdcafArFypGnCZXtjohiC2CY97YfBWdKE9hmWroLl5s+Aribt8KyLqNk7qHFqBZGn8oCuc+x1Xz+ZeiYZ26fp77G59ge1kt0JMwNzouHDP1Zdl4z8WSlXBPByHuAr77kDemSpt0UR4XPa6VLHxoyXyk6PI40Bekndgfvc67/5niYoaffhRXSRDnGagq1MYZpUoVjnS7AVK+XFyN3y9PbysKZ3Dsw844nJXg2DdPuTJSNjQv4qJ088lH+nXXGpG+eP0Hf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8vYQrm4uIiA8pNpCPMvu8MjvXY6i1v1nDOFc+vivb0=;
 b=jr3yGvQGl+xAYXVQUZcUVQaYMJzACOb2TjRlRZB8bIKpV4qUTh2KHZqKiwMXSCKseRXivKy6CLixv3Go74TicQTwchBeAqCt0cRBBPg2EQqQDv0p8nJs28dJpe3TmNYDONgNluM4wi+n6COGWBAa2hUQ2xYx4mqF3YG9YcsB6hI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 00:51:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 00:51:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Nitin Garg
	<nitin.garg_3@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type
Thread-Topic: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type
Thread-Index: AQHaZicCkH+tvBnis0Gt2w9aePsLUbEcn84wgAAhnQCAAJ84oA==
Date: Tue, 27 Feb 2024 00:51:56 +0000
Message-ID:
 <DU0PR04MB9417CA7FA1A3161314FFA4FA88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240223071557.2681316-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94172086AB4EF0389B78CA6A885A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZdyrdOmtYH0paGIh@pluto>
In-Reply-To: <ZdyrdOmtYH0paGIh@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB9644:EE_
x-ms-office365-filtering-correlation-id: ea237d9e-b5b2-4b62-4fec-08dc372e4be5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vxGStPdOHH7SP5SKU5Yni9bJhBuYKZlEtK2HopuVV+FsyW9IUz1qioGjdCIzLgUoEeL+bMoyeCABpaFgBwxW9HkbxDEw84WUlrnz4juqSqXvYMLRJlyK3ynYSNP/IR/EyyKlchmP8igTcu01DH47T/dhAeHd++xJC7Mt7JRrsfCJ9eA3ISb80tS2NyOQckRSVRM/uUNsTiYYvqpTY4rlPvD0u1Ekw8ly2Rf2LKe7AlhtSJQ4L2JfwiezRrKUyanSLnF2JYRmwRv6vr8XtbMDm2CfgJEoehe9U6NtN2Pfe/GP27Y67RGQhGPH13KUDBudCJBmrUjylAcGEMcCX2J4KyIU7CxuYaFQX7stVwXl5DHHsLquq6oIonMLM8k+dh+X15e/DdCZjXrzRSKUwaIEgUQ1YIKaPxJ2u51ZokB8PcC/R8876dIoyV9ou5nAhGT7xpCL7ynhTH8mylQS9DPju7xKr0ZvytyA5W2/1WqAHYwLKrDY3wbo/Nd4PJn5Cn7raNgobcWUfGnTGYPqQvmoMEYJKcbaKSad2qkIqn+lNrDPqUcCC1rjQ/J3AKXhgsy3pHBVrO7XySA7d4f5PVIAkHQypThvK/LAOdeVn1G+W4mCWCYdCSRT7918cw3Fx+yD9CN8kBCjQ4XAbXm3MFYIW6sQPmsLhtftGOWD0Z+vE8MAAHTHxIUzbp9aJV8omi77Jpz4uItUrtq046ozSi/tlmc7iLia761IKdoPuawuFkE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gUhoMLqIP/TKM9IL4BYKyOJOPzv11dwOnQ3hqEQidQnTeqEoEWx1NMHTLrnr?=
 =?us-ascii?Q?aPHht0m0lbbf1fuQVxbjvTgD0Mc604i0V+LTi6G16ZVc0lmtpqlRvZPyjs2s?=
 =?us-ascii?Q?gadwx/GX80bVOMVbxPcnO2bOjLxR/M7kMjIlaPmw3ULf6zPim40rdlSZI9Et?=
 =?us-ascii?Q?9Ti+px5QfjbttzVZZj8OBdc77OXno0tGF/MOfPsm/2VZmIjO9pTBGwbDQPRG?=
 =?us-ascii?Q?kIy/5tz6FHMKWntAgQbiAwOk6ycfKZRk0cLfzdZGh63c9QrxrnA/thtaVxhE?=
 =?us-ascii?Q?yG0KQGtVj1+uVscdD3OrVDHe4r5GLgk/cUBe0deyRHwuA92jPX9P7dqSTS/K?=
 =?us-ascii?Q?AI9SP39u2K/bFAiwUb3gK3JZKH+KKCUQYi+041YJcYTSa6PedovjQ1SCHpAa?=
 =?us-ascii?Q?MgveM7W1KKbJ95WOmMeKY6rkOd4eHZx3hSycrAujlhdyUNaIoVuFgEIxF1+Q?=
 =?us-ascii?Q?88JGpGOjWucR1AyRDgAfd3atqFv/o/ZArdp+LcVZ+KIDeqLb7ALADkaMsOnB?=
 =?us-ascii?Q?L6wIJyX8VUOhLvgn9OXk5rngVBlNdnmpmDUEM8p1f1E2QgiJZ0tlVcV8QUYf?=
 =?us-ascii?Q?4w17bh1osmjT5AVONC3Qbhln/l7CwPEyoDIl/MP3SkaYle3MjDZMz5rGY1zA?=
 =?us-ascii?Q?VJhxq0xWUxOuodVqs/O6Os1wfKM29tEfyyNL9k6SRoz5O75M1nksbzAqCAZb?=
 =?us-ascii?Q?+po40F86Zp0DzbvaGyE1orQBFzmXXJSR9n8Gn5VibnaZV7+nFFLSfg0zT3Qm?=
 =?us-ascii?Q?8t0zGYo0TZRlbbDmvARJASb/G768gMDc5q0B09cpjY5a4oTJN8HNFGx2IUEd?=
 =?us-ascii?Q?e+PwYjsALL6bSfMkjG3Sn003q0DDgbQCHSSgHpK07da3Rnqy4pQPqV9khZ5F?=
 =?us-ascii?Q?t4fbPVM5dPaZ2aL2LFDXPJJo2TwJkAUeMvTYFal7FReHHMU37MC3/3tEcpm9?=
 =?us-ascii?Q?Ipe7c0AH91yITVxngofi1CcThR8XwTQ81koVQHOc9XmFX4EXbSXJoBKINFHs?=
 =?us-ascii?Q?4GZKjwjx5fZjPOHNki2998+hbNy568c/RdQ19rpbpdQ/kFeeeiEI+Q3/Zelo?=
 =?us-ascii?Q?uBJzramgVEMwB38EXZv7VhCHOz7VPMm/I3sxqOMBLPSIRty4rJPhNEdub+7h?=
 =?us-ascii?Q?beq9KfYCXDeSuQv6CPO1o3oRi1qeVBn5nxlcNKQwS4mSyPQrMOKfhU5dFRh6?=
 =?us-ascii?Q?NHk4jcLp19Ynt1G64EvR4jL+ZoezkHQBY9p8DVKkXyFpKsRpOdszVBn2yceX?=
 =?us-ascii?Q?IYw4bDyI/m0+5g/zZ04qXMEwrxJInWE5U4hsMkamKclseoibgbMWyLAMx3Nv?=
 =?us-ascii?Q?HkpJflCTJhXKC50F0XhTmuWnFjJ4hrdhUpyRViMlVu9rlIdle3fYWf50oGL6?=
 =?us-ascii?Q?u1lvcfY2hJZ1X3EyhQDCUAamij4KW0wmVJdJkidjkJpRqYUIi3GiYB+7HiFo?=
 =?us-ascii?Q?hAcYqerLsMDEonA1yuelLpvgyp7wMEAWEUMuSep2qeIpK8yYvZWehuk1lPs9?=
 =?us-ascii?Q?PoPQ1cZfjmxvjMP3EJufbRr1A6L+KMy6K8i+F/1bYJ/ZamqDsNY7xo+1qxQw?=
 =?us-ascii?Q?tJgGsF5u0m4wysJAAag=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea237d9e-b5b2-4b62-4fec-08dc372e4be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 00:51:56.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtyFQDBNdmcRxo8EFa3z5sSWBfPpKEAJBqBXRvvkFai0uMBk/mw3D7+eHiMdP2rNlGtI1a3ckG0JcYGwxf6GWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9644

> Subject: Re: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration ty=
pe
>=20
> On Mon, Feb 26, 2024 at 01:16:51PM +0000, Peng Fan wrote:
> > Hi Linus, Sudeep, Cristian,
> >
> > > Subject: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration
> > > type
> >
> > Sorry to ping early, but this impacts the design and i.MX95 SoC
> > upstream( although I removed pinctrl to let uboot init pinmux as of
> > now), so I would like see whether are you ok with the approach or not.
> > This is the best as of now I could think out to not adding more size
> > to firmware and make the dts format similar as previous i.MX.
> >
>=20
> I'll let Linus and Sudeep argument better, but, for my understanding, doe=
s
> this solve all the issue with supporting custom iMX DT pinctrl bindings o=
n top
> of the current SCMI pinctrl generic driver without the need of your last =
2
> downstream patches, or I am missing somethimg?

No need the last 2 downstream patches, the custom OEM params could
make it work, I just need to convert the imx95-pinfunc.h header file
to new format.

We might be able to only keep imx,pin-conf in future after some firmware
work.
=20
Thanks,
Peng.

>=20
> Thanks,
> Cristian

