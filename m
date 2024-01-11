Return-Path: <linux-kernel+bounces-23570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998882AE82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509D41C22EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD62156F4;
	Thu, 11 Jan 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XX6Xq46l"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD7156C7;
	Thu, 11 Jan 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og5vCA0rU3bgQGqQsDHBr3TF0j+drUtcsn0WbtJvCLZejdogMVEaATOEYznkTagdytyiIklh0XG7tzDm/D7f6flY3UOKfd4+x6iZs2JqsOUdVpXEeaYpfu5IG0ZxcpBl0Hjg1frzsS87HnEQ3VU/GkQxKM4eWhu1cfx1NVLQu9qCWh40smQSYz8xsC6z9N9VRP7pmJVJ+5Q50rX12X/McY9QZu9KAH5/Bpiewo/g1HIW5/Qn4pxBPniA/tYL8One8yywUc1tIr9cNukoxi5hkNe/044DON2r8sKzdvdg+zzDwF6Nap/FpyrQQbIjqgongTauvuKRpmAB5UV7f7Fgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpN23qiDCmVlyYJc3KGsS3fKJiwIjKloYDnYUpvAIqc=;
 b=XeNWcq/YCgytEcxxOAfL5CmlGN2s/ij4J1kpP4gfPiR64CHDwwaSJHNZ5Ag1XINgDsUGzmH0+eU/cvzctr+yqmqoTJ4FDjfOlS+/DEfbV3xl+3FNBEvqpELfgZ33qfku2oZAf+ibjOnAHDFp9pnXA0N4TS2UDlhQ2wZ46k1Yl4ndmHJOqiDXFJNFi7Np05ctucmJ7c+BKuMe12yfPqtzCo11kl2C9uXPdeSyQOnUE8P5wYxM8z01gYaYcVXmcpdAWQRjNt1AXVtnuzi0fiQTs20CVl5qbup7e7tNHSFB0ok/0KI9S5S01Z0eaz8znqvjLqo7cOFTG2Vxtz9aY5DL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpN23qiDCmVlyYJc3KGsS3fKJiwIjKloYDnYUpvAIqc=;
 b=XX6Xq46lj6+JMZhj6js+g5PDfCkrYBVq7zvkxDeScOkEnIYiCdAOFTEzxofC8sfV09JtM6gBvifuWH99YX4L24HFN8GL5386EDGyJpmnP+G9TkuK/HxjCe9Pe/TVV5v6JgMUTCFwU0IeP/ivXFWEw3uA1rXIIt9DOMj68KiQRnw=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 12:13:13 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::b46:e1e6:ac2a:4386]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::b46:e1e6:ac2a:4386%7]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 12:13:13 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "mdf@kernel.org" <mdf@kernel.org>, "hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>, "trix@redhat.com"
	<trix@redhat.com>, "peter.colberg@intel.com" <peter.colberg@intel.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"v.georgiev@metrotek.ru" <v.georgiev@metrotek.ru>, "Simek, Michal"
	<michal.simek@amd.com>, Marco Pagani <marpagan@redhat.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC] FPGA Subsystem User Space Interface Proposal
Thread-Topic: [RFC] FPGA Subsystem User Space Interface Proposal
Thread-Index: Ado+yABjPiRB0KySRY6DC56HOLfe9ADNGpkAAKKugUA=
Date: Thu, 11 Jan 2024 12:13:12 +0000
Message-ID:
 <DM6PR12MB39935C794D7A14E800F433E6CD682@DM6PR12MB3993.namprd12.prod.outlook.com>
References:
 <DM6PR12MB3993D5ECA50B27682AEBE19FCD67A@DM6PR12MB3993.namprd12.prod.outlook.com>
 <ZZuW7rQv22xEreu0@yilunxu-OptiPlex-7050>
In-Reply-To: <ZZuW7rQv22xEreu0@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|IA0PR12MB7530:EE_
x-ms-office365-filtering-correlation-id: a7411a3d-9f7b-464d-5e60-08dc129eaf06
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Wsh4qOo9r5/L5ZqLZh5oxuyuWx95jlsosjGMZfx2oL/IhtT3rVHyB7W2gD6vPrFv1SXQ49LFhQ9ou4LGuSkH5tdJ+utYJriBFFCbEkFW9G5KprTDrPhXb216Y8UXmFf/rMJEBmHpgbIwLnCOqtKL3v5+vdm/swFJ3kHldsTF8ACdICi62XDzus4VBEqQh0MSuN8Rdnoan66nwWoShnm+dKcuSE/yPcEvGpIdrOgKwnBc0xbrOHkpOsg/WjjZV7kczk5cm7Uc/vT5f0+PzgYGlH1XBGFQwNJqgW6bATDVWKd9iyqnzBmHhI3LFg4OIR/Q6fW7swHg5Y45Gjw4yviRfv1fULPfMkI/P88aRRhC9n6ZyrBWed2M+p99DCMbqTVf/pOeRYVP+Hgamc737pHpxcIFjdvVlYoPYqE0Nfk4nIqeHx54bD3rY4epAY0gdetlS2lN4nrxYnXIw7fLeOAsp8T4gCPw+oElJFWbYK5hdDV3Asd0D074bjOGMvLNS/UO++KiJhlrBx9f/I+10nws39XzSRGHXXhbmbPKgbrVX01APHo5BgVobwnSVRhsKgBIzhH81mMvmzqB5ifsl7ydVaVCzTBq06500wwk79wLGc03tUXjg83Avck3e40Xo+RZOxGycSnWvm7v4AsmpAZnXg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(83380400001)(66946007)(76116006)(316002)(33656002)(86362001)(41300700001)(3613699003)(38070700009)(66556008)(122000001)(2906002)(38100700002)(66446008)(26005)(9686003)(966005)(53546011)(66476007)(6916009)(5660300002)(64756008)(71200400001)(54906003)(7696005)(4326008)(8676002)(52536014)(478600001)(8936002)(7416002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iwrkkqoRxssLz70QWQ/rAAIi9JPW6dGBeAl53BQCkt6+9te2ZtimOaLit0X4?=
 =?us-ascii?Q?DtQaz9+sSIXaHvSu7sWZzpc5o/4XNf7LW0DNwDSktyozfMaD5g0c8lAVhPyc?=
 =?us-ascii?Q?YncwnZ5IVtX5tJ8vXsn3QQ9EWBgJ9nWo7cLaXMHSZQP/0ZUvI9VQDeAjNLoq?=
 =?us-ascii?Q?ZijgUp3GL9RhjR5Pc4OtqMVuqoXKQ4mKovsFNzXee24+x78RfJVj0cQ3CfAx?=
 =?us-ascii?Q?L00YY+A4jb5fpHuVAvoQ0g044/azykHO0zqgeG4gnAOoL91PUPtK+tU5TBIC?=
 =?us-ascii?Q?amSITTvxel7nG4YPPWt7hcxuJ5wIyoZ0YzgseLlQy4QFWhsk34X7yPhwFkHB?=
 =?us-ascii?Q?Y1o1AZrxhojR6bZWFWR2ePqG2sUf8lnsNiOukrNkD3LheHMvGhJQUm+x8MRo?=
 =?us-ascii?Q?whlymgIZkdZRjpbZjWeaRsP5Z2cB/yOoHQOMR5SnTj7+LqLfPTB+/nuJyVL0?=
 =?us-ascii?Q?FhuZOraHlMiSa+Yoad9W9XJIavmxvGlVD48kmecmk7C1AXDJ0d5mGhT9IOL1?=
 =?us-ascii?Q?e1kb9ufdJRTb1hivAT1j9xd/5sDmX6UAkP4/4iT2yO/WdkU9MMbYAtX/4RY/?=
 =?us-ascii?Q?EdzlnSEtcDG8uvrL400Nz8hIDZ87crd8VTwQewqsWv2U4ZOhiijV8T9dhXv2?=
 =?us-ascii?Q?hRQ073xOwAK1t37QqfX72ZZGWspBW72a3tbVNOsK/GNM0Tz7AWgbihFMni+B?=
 =?us-ascii?Q?ep83R7/0OpMTsBypNfRmwHcYlmmayHMppQUmdiSkBZhikJeAj7Ik6EHVTmp3?=
 =?us-ascii?Q?UpqtIs6iMMvl3pMlYCIi8hD9Zkmt29v+qI+cyUasQ4ZoWW0M2+DWIZPJ39w9?=
 =?us-ascii?Q?TzP4jI0197fgZ4ENW/ipH27K2ZY7mwXBNOHSNG5g1bLsULIGdv+uzN/SgHd3?=
 =?us-ascii?Q?PvlxUU5D0VAHvTraUXJYeswaWt9IyRsc1iM0euXZdVGQe1IqhGZsrbc0V8xp?=
 =?us-ascii?Q?LCQuI5MYMldE/QNMPEJ8uaYoa4MBY6cQMYRvlskwN0frpyKLl/NwXZvHapLy?=
 =?us-ascii?Q?j0mNzeApircjZFqv3vsfPb3V7I3OJRuTn8fzUeD5ifJXgyzePDbadCTrb9o0?=
 =?us-ascii?Q?yQvyGAWCMmUyLCMMkfza8hKEgExKpWMp+UcxmqnAhOglLaJlWCvPQrH7vzHS?=
 =?us-ascii?Q?WHf0VRfB8elgAc39GWE7q7bObpRv59O8NH909CuFFrQjYK1A5S/MqD3Yd5JX?=
 =?us-ascii?Q?86ANBfVBWXSS/J4YnMqNC8VQKC6INuin1XyMeSS7tA2JvNfyUcW4io//g6nh?=
 =?us-ascii?Q?ynELGgC3xHpn9FEZ39qUM75uWaKrxEOw9OYK2jPSRxBjccSEGf7W8HT1RPTE?=
 =?us-ascii?Q?QXDzj/irO/R5tURQXP3owOEVSLo+VYyCbaZwnlszxFZTg/eoZp6JSH60Vqj7?=
 =?us-ascii?Q?vKSjqIRCMNTJrbqCFTC0kQc7V9Avuc9sarr3mJS12/8AdEl8t0HDvtpPDv83?=
 =?us-ascii?Q?MoFX2Tz/Qb1zZD6EOZR41xiSUlq72QUrHgYZTBc7LKHW5dfzxIzJoR0R2Fuu?=
 =?us-ascii?Q?USHXttZOPuskHfa5IobI6FCqx2roasCm6+lYkpNSWWUs/MLJqmbyvU5uGr4v?=
 =?us-ascii?Q?r37XnX+QBWd9p/gQ6A8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7411a3d-9f7b-464d-5e60-08dc129eaf06
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 12:13:12.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPxorPavcv6SM0GFPPA65FUfavzR7XVkGH2BuZTq3Zr1b2JPI7RHqnN9GGKRQc9d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530

Hi Yilun,

	Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Monday, January 8, 2024 12:02 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> trix@redhat.com; peter.colberg@intel.com; conor.dooley@microchip.com;
> v.georgiev@metrotek.ru; Simek, Michal <michal.simek@amd.com>; Marco
> Pagani <marpagan@redhat.com>; gregkh@linuxfoundation.org;
> ruanjinjie@huawei.com; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git (AMD-Xi=
linx)
> <git@amd.com>
> Subject: Re: [RFC] FPGA Subsystem User Space Interface Proposal
>=20
> On Thu, Jan 04, 2024 at 04:52:15AM +0000, Manne, Nava kishore wrote:
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D
> > =3D
> > | Introduction                                                        |
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D
> > =3D This document provides a detailed overview of the proposed Kernel
> > feature for FPGA Manager subsystem user interface.
> > It describes the problem statement behind the proposal, the problem to =
be
> solved, a top-level solution design.
> >
> > Table of Contents:
> > ------------------
> > A. Problem Statement and Background
> > B. Scope and Out of scope of the proposal
> >      B.1 Scope
> >      B.2 Out of scope
> > C. Proposed Solution
> > D. Proposed User Interface Details
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D
> > =3D
> > | A. Problem Statement and Background                                  =
      |
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D
> > =3D The existing FPGA manager subsystem didn't have any user space
> > interface (other than the status/state in sysfs) in Kernel.
> > Basically, FPGAs are semiconductor devices that can be reprogrammed for
> desired hardware functionality.
> > FPGAs can be reprogrammed at runtime with different types of logic and =
IPs
> as per user need and hence there is a need to use device tree overlays fo=
r
> removing/updating/adding the devices at runtime for the IPs/controllers t=
hat
> are present in FPGA.
> > But we don't have any user interface in kernel for updating the device =
tree
> at runtime.
> >
> > Sometime back there was a series sent by Pantelis Antoniou
> (https://lore.kernel.org/lkml/1414528565-10907-4-git-send-email-
> pantelis.antoniou@konsulko.com/).
> > This patch introduced a user interface configfs for Device Tree overlay=
s, a
> method of dynamically altering the kernel's live Device Tree. However,  t=
his
> patch series was not accepted in mainline due to various concerns.
> > For more details refer to this link:
> >
> https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts#issues_and_what
> > _needs_to_be_completed_--_Not_an_exhaustive_list
> >
> > One of the major valid concerns that were raised with this configfs int=
erface
> was security as it opens up the interface to users for modifying the live=
 device
> tree.
> >
> > So, in order to configure/program the FPGA devices, All the major
> > vendors of FPGA are using this configfs series as out-of-tree patch for
> configuring the FPGAs and there was never an attempt to introduce a gener=
ic
> interface to configure/program the FPGA in upstream and hence upstream
> kernel ended up in not having proper support for FPGAs.
> >
> > The proposal below tries to address this gap of FPGA programmability by
> providing an interface to the user.
> >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D
> > =3D
> > | B. Proposed Solution                                                |
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D
> > =3D The proposed interface adds a new sysfs interface (of-fpga-region.c=
)
> > as part of the fpga subsystem and it is responsible for supporting the =
below
> functionalities.
>=20
> Why only for of-fpga-region? There are also FPGA regions that don't rely =
on
> OF. My quick idea is that an interface for /sys/class/fpga-region/ and OF=
 could
> be one of the implementation.
>=20
I agree, few devices(Like - dfl-fme-region.c) are rely only on FPGA region =
and they are not using OF. Thanks for pointing out this case.
I will look at the possibility of having a generic interface for both Fpga =
region and OF and I will get back to you soon.

Regards,
Navakishore.

