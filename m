Return-Path: <linux-kernel+bounces-96938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4A876364
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0304F1F21CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4DF55E7E;
	Fri,  8 Mar 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UAut3e9F"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1852F82
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897790; cv=fail; b=ZX+snb9d+oCFpmB/TT9a5x6ejvN7li39STD4swTqoWdZh7e9Xyxve0F4GjhOSbceVdtaGkWEI1o0ljlTOGW2A9hqwPky0vdmb4rPi9RPXhL4e8oLzJSmbSlK+GDhKcH5pPWzGZWChApDrjUcIcb+1TWG2MJvBQ5Uopf1TyKMu1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897790; c=relaxed/simple;
	bh=7KhzqXLlYVYvBQoEnmTeCLBuukc6jid1kK58VpeiuVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dCMSL9wYhSDKnokdVbJjqkybOTZ1K6vVcEYccqlgDyScMr9g1Xv8Iz0NKaJA/UdHD5SRPjOkL1pRq7yY482dlrvbkilcZX07spIV8BnFpjYuPBN8exYbKpZXufN6HGHpT5dUJlL1vSsMgO3FEq7QYl7S9x4Qjx+ZMY1rBWcWQw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UAut3e9F; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428AQvKM001407;
	Fri, 8 Mar 2024 03:36:18 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wr0x005h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 03:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haF5f+9Mkopb+DTQG/TE6L35lPMcmp5L2EAHVnOkJKSgoBWouCcQwusvysXdRiNJZMpa7V8+d/n22qfenDnlYoc/h3oGvTKp3mWQupp2/HBoQn1KRXWDTbApwaAtlhWfNrH942JnvSSbFmcpW1AWbwouRbm/IIxlTJz7hMRglVCVDQ6HaQf9MJR+fonRrrCrqEDn2wIuQ5oZuKk/HXFG41C+cR9cI/CTYeLxEWN6U84WmDVwCcy30whl1qDtWBXmCwfFLY3h8/DsBr6gMqgJZ0+boh7G+O9nNfOg7GaQPRTjzYqtZxEiXGRuFEIql4Mn7TcG6KmnZL1Ho0jK5hZHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xwfUrqRcz7THRIYf08d+xVzSJuYyrCDW5JI3O58XnM=;
 b=apE7ku80FZsppomDrQhV4MbtzmR1ERSWM40WT9kgViofo9LPifS8s2+OjSuaD4M1NdsiEyuzvV8bZIagt14i9Ck1GtD81IxwJCmIGKKGLTjf+jRhADLB6U2gT14NQh0RbCqUKuvYkjsG82dNpEaqtP4owB7E0WLKFCIGVNk/7UFt4NP6hz1bdXLuzxZEpJNMhzgTvu6RYQrN3UGqpcbe3vi0o18edGrVnVfEZ2dMtES/v03imdtL2xHiplNNveHIM3fMbOzOg6u828mgqS8/aGhMlSVij4RYkrPrSd4jmkgaPR5R4RE/pxJQiHicsfg9Dt9Oxme+AwuoY/KQgFKY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xwfUrqRcz7THRIYf08d+xVzSJuYyrCDW5JI3O58XnM=;
 b=UAut3e9FJhSLT6mR5yOOHSVUPYztVatTXdhAgslY7iDH2OFsELLswUREpbz8KwJClgPeZKaJZwCKUyMyEBWdh41kuUAlsGpDmcQAi8Qr0FXcG0Y8/deUp6pRBq88ceTB98VuuJH/pisfZBmaegQ2gRTHtRC1jPf2ZYDt9h4XjMI=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SA0PR18MB3663.namprd18.prod.outlook.com (2603:10b6:806:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:36:16 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::c0e5:b3ee:3e55:c535]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::c0e5:b3ee:3e55:c535%5]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 11:36:16 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHaamYT32kjl02Qd0ixpnLGJOmqtrEs346AgADi1BA=
Date: Fri, 8 Mar 2024 11:36:16 +0000
Message-ID: 
 <MW4PR18MB5244191AE625EE04141DAE2BA6272@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024021913-aftermost-footnote-cd6e@gregkh>
 <20240228162141.1413171-1-vattunuru@marvell.com>
 <2024030747-stove-helpful-33c1@gregkh>
In-Reply-To: <2024030747-stove-helpful-33c1@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SA0PR18MB3663:EE_
x-ms-office365-filtering-correlation-id: ca456f00-e44d-494c-a897-08dc3f63f73b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1h4MSkwiYKkF4vYlHwm8Qv8My0bokNwhq7pjOnuvEW0ZM3q5r6F48YLrXiwKyk7WGobk9lUm8sTx/bFLXwZZDdKQ4w7wls2U5zElrJ0qqVBRktfdN2spze+Ff2d56HQ6hWj+HPkSHUlN8p/kmMwuilVUh6RDOc9qMr/4qaxQVGRx6cvWlbsOx1ZsSvuZtY6fXuxW7mHVPOQXbXdmJ0IU50morZNmE5/PdRVdBPxxwp+4qupyyZ0orno5YL2NRORD0aKtHP53zefSDcMrZPXey2IZjpzgIebqVldEqiIJCGmNB1mybExeTtrsD2f6kr1R2AcxnAFdxxt3NzxSIwK5LdUDV8dIfqehh44BJsfqMfvnNIr1C0oTH0cT+bc+UYsV8Q908x80sjesvEFgA5EGcWq6jMaZObDeHse6Z4S8yAFnj4M8LLixtJQ5XNAxEuBFB95QZXv4O5XYd5t5zk+BTdqKumNbuDmfJt3gGmT5ee2sGP9ybL1to6gWnTJYqZDWzr08skT1Pg9bpWtMgn6RPpPfXdQM70j4309q5OqdlJCB9lokTCNIWw+XwCJotnapVW/uO0pqA8M5GVo8vweC/Tt3j3/L64LCHSrYtejhlNKN8BCHZk14+X5CqPZcmspwzohYAgNBJxTjMUB+zO+hCk1nrr6f0KHJU4UW5FuTr14j+Ze1bQ3oblD3haZ75mFjk6nIuxIktnKFxVi4na8hW4mJ2mrcc1LcWiS9LWuA6W0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?AqkAgbAWsxSI7LGG7C+w5NnLfOV4iOuy7f1J1y4WRMRqCwF52ur/AkUNEhkp?=
 =?us-ascii?Q?Ut2SMndpTGoBp4CSuCFW02IFY+SUetE/ph0UGqVhgG5/Cex04opDZbCEtVkP?=
 =?us-ascii?Q?VM/gea4H/LBV0uobBlDwbXbq1L9WG8NhjP3XoXq3Id4pJa8EZbJS1eaZEQbT?=
 =?us-ascii?Q?qgK4ocWNxsfnaI3aEMGORA+MBLOpHCVZJT51nzStP5ycVsf6a8kBSAMZ4f83?=
 =?us-ascii?Q?EZo1KoHHit8bXp27vFfau8If+/skzLtM05HnU1M63t3WPqj0JW/sPNkGLss1?=
 =?us-ascii?Q?tWa1nvG83D74qxeP6NV2zvwqXco0kt6NlM5/P9CWExShxIXCT1v4XxJDgHqA?=
 =?us-ascii?Q?HgsVKPXH0Nt/nvUCptT1JKidMOdrHlO6NK4+Mt9ZrnJBvnI7Yf8GHrhZ5/4o?=
 =?us-ascii?Q?tn2HEFSZUgI1wz7Iji3CNr3ZafKMU3C9B3oW9Y6PN5O5bg7mob+8t3urgA8y?=
 =?us-ascii?Q?Whqm3jhZ/FR6T14ne4+EpPhompwJGNxzCI9nVyykfEnSdqkblw4DEAJ44h5l?=
 =?us-ascii?Q?fJolZMGqq8A/wvHgVzxaMiOParEQUq+mM/yHpJ0buU2CuBGNkAsxOH6BozLP?=
 =?us-ascii?Q?tH2krEA9+rXjl4nypqAjf4Gio0fhfjYSLLPUOOoV+/1L5MkTrmob6R+CiX2n?=
 =?us-ascii?Q?3ipw/xqhFI0ILD5N8SLbZe6CCijuwOMFCieS3y5D9yWhltS27PIHJq1eW4u7?=
 =?us-ascii?Q?8HsGSOkvXBeoUXhTfxzpjPBichuw3dn/Iv19UTjPEsjSm53Y93W9WoYoIJz4?=
 =?us-ascii?Q?f5mtqJ+sVkmsPDY44pYHIx00tczQZNJmpsXn9qwWBFDBPVe5pea90ZUxgln6?=
 =?us-ascii?Q?FDh9iYOAHI4Zuya/qKae2xEheHPsCWFQfVbaIoYwcrI4zLy4InsPdkaCy1kM?=
 =?us-ascii?Q?bC7RgKOLYugC/c2Ya6bSViabRBXMIhCocBL/Q886tiw20mxqsbRqDJzQKBx2?=
 =?us-ascii?Q?3QuJusSbJIhNTVM0YucunkPzl5OMKFtKKpm1/+/Jcj1X6LK9YmrQgC0IPwj6?=
 =?us-ascii?Q?4uPZZWYC9zddiNVvZJEn90v8x28EHUOxgBh8UNrliZgMDOHZX4EWUdfhyJy4?=
 =?us-ascii?Q?1mVEAE5DNgORcfZFR6YgbTT7ZT4bUm2l+8xPx8R7c8jU2L265j7nbTIvhoqe?=
 =?us-ascii?Q?uAmbGBzUDzZ8kzI8zpuHY8kSkWoWfViAmDYIQ/BhF5O4JX1xKGpORRxsgPqD?=
 =?us-ascii?Q?b2QNDI/Syph01A9yJb2VpKhudGx8l8MoRdpE0XN7HAOj1eR+a2cRbcbfDWxr?=
 =?us-ascii?Q?pKIUcNXaYCbgTiFlsCEaII2QzR+wSGpNyG4Ug1LpHJ8l5aJTVwJR/W4pccW3?=
 =?us-ascii?Q?3ZNnwkxjvDfspvhkmAzNv7MgbleOQeK3ONmSs4PZ3EYddy8wcE5HhAq4tKBX?=
 =?us-ascii?Q?ODcIoHfGJa3w4o19boMiKDLFTnYT+5ia4mygWuKdx4/xrDiM5Y++O1hbIIHY?=
 =?us-ascii?Q?wH8vhKuAQJjGHhLsVNnAshpT75/whtJ+VxG74YcOHU8Ze/DkCMqW2zEM28Z+?=
 =?us-ascii?Q?K2l1o1dnl26T+L+7GqA3YYvneO43y8sMWOVEi425Yp9bCxQEq7E6x/aMRpKY?=
 =?us-ascii?Q?pqbqW/NqNmqBS//MiRpcgH/dwR2/GhfXVSQInf+h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca456f00-e44d-494c-a897-08dc3f63f73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 11:36:16.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dyaQ9xUijoW4KC0FZZxF8OOlP1WuxavFk0CbpZRW4cQjwDpUiIYUkBrB21uyVU7GMUTo71auV78nAMrRNEgnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3663
X-Proofpoint-GUID: ajffRUG7DHUBeVlpWQfCkcAd4EJoBZQY
X-Proofpoint-ORIG-GUID: ajffRUG7DHUBeVlpWQfCkcAd4EJoBZQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, March 8, 2024 3:26 AM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v3 1/1] misc: mrvl-cn10k-dpi: add Octeon
> CN10K DPI administrative driver
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Wed, Feb 28, 2024 at 08:21:41AM -0800, Vamsi Attunuru wrote:
> > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
> > function which initializes DPI DMA hardware's global configuration and
> > enables hardware mailbox channels between physical function (PF) and
> > it's virtual functions (VF). VF device drivers (User space drivers)
> > use this hw mailbox to communicate any required device configuration
> > on it's respective VF device. Accordingly, this DPI PF driver
> > provisions the VF device resources.
> >
> > At the hardware level, the DPI physical function (PF) acts as a
> > management interface to setup the VF device resources, VF devices are
> > only provisioned to handle or control the actual DMA Engine's data tran=
sfer
> capabilities.
> >
> > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > ---
> > Changes V2 -> V3:
> > - Added ioctl operation to the fops
> > - Used managed version of kzalloc & request_irq
> > - Addressed miscellaneous comments
> >
> > Changes V1 -> V2:
> > - Fixed return values and busy-wait loops
> > - Merged .h file into .c file
> > - Fixed directory structure
> > - Removed module params
> > - Registered the device as misc device
> >
> >  MAINTAINERS                   |   5 +
> >  drivers/misc/Kconfig          |  12 +
> >  drivers/misc/Makefile         |   1 +
> >  drivers/misc/mrvl_cn10k_dpi.c | 717
> > ++++++++++++++++++++++++++++++++++
> >  4 files changed, 735 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 960512bec428..ab77232d583e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13104,6 +13104,11 @@ S:	Supported
> >  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-
> sdhci.yaml
> >  F:	drivers/mmc/host/sdhci-xenon*
> >
> > +MARVELL OCTEON CN10K DPI DRIVER
> > +M:	Vamsi Attunuru <vattunuru@marvell.com>
> > +S:	Maintained
> > +F:	drivers/misc/mrvl_cn10k_dpi.c
> > +
> >  MATROX FRAMEBUFFER DRIVER
> >  L:	linux-fbdev@vger.kernel.org
> >  S:	Orphan
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > 4fb291f0bf7c..58de5844ecef 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -574,6 +574,18 @@ config NSM
> >  	  To compile this driver as a module, choose M here.
> >  	  The module will be called nsm.
> >
> > +config MARVELL_CN10K_DPI
> > +	tristate "Octeon CN10K DPI driver"
> > +	depends on ARM64 && PCI
> > +	help
> > +	  Enables Octeon CN10K DPI driver which intializes DPI PF device's
> global configuration
> > +	  and its VFs resource configuration to enable DMA transfers. DPI PF
> device
> > +	  does not have any data movement functionality, it only serves VF's
> resource
> > +	  configuration requests.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called mrvl_cn10k_dpi.
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> > ea6ea5bbbc9c..8fa2fbf8670f 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+=3D xilinx_tmr_inject.o
> >  obj-$(CONFIG_TPS6594_ESM)	+=3D tps6594-esm.o
> >  obj-$(CONFIG_TPS6594_PFSM)	+=3D tps6594-pfsm.o
> >  obj-$(CONFIG_NSM)		+=3D nsm.o
> > +obj-$(CONFIG_MARVELL_CN10K_DPI)	+=3D mrvl_cn10k_dpi.o
> > diff --git a/drivers/misc/mrvl_cn10k_dpi.c
> > b/drivers/misc/mrvl_cn10k_dpi.c new file mode 100644 index
> > 000000000000..3d33395feaa3
> > --- /dev/null
> > +++ b/drivers/misc/mrvl_cn10k_dpi.c
> > @@ -0,0 +1,717 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Marvell Octeon CN10K DPI driver
> > + *
> > + * Copyright (C) 2024 Marvell.
> > + *
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +
> > +#define DPI_DRV_NAME	"mrvl-cn10k-dpi"
> > +
> > +/* PCI device IDs */
> > +#define PCI_DEVID_MRVL_CN10K_DPI_PF	0xA080
> > +#define PCI_SUBDEVID_MRVL_CN10K_DPI_PF	0xBA00
> > +
> > +/* PCI BAR nos */
> > +#define PCI_DPI_CFG_BAR	0
> > +
> > +/* MSI-X interrupts */
> > +#define DPI_MAX_REQQ_INT 32
> > +#define DPI_MAX_CC_INT   64
> > +
> > +/* MBOX MSI-X interrupt vector index */ #define
> > +DPI_MBOX_PF_VF_INT_IDX 0x75
> > +
> > +#define DPI_MAX_IRQS (DPI_MBOX_PF_VF_INT_IDX + 1)
> > +
> > +#define DPI_MAX_ENGINES 6
> > +#define DPI_MAX_VFS	32
> > +
> > +#define DPI_ENGINE_MASK GENMASK(2, 0)
> > +
> > +#define DPI_DMA_IDS_DMA_NPA_PF_FUNC(x)		((u64)((x) &
> GENMASK(15, 0)) << 16)
> > +#define DPI_DMA_IDS_INST_STRM(x)		((u64)((x) &
> GENMASK(7, 0)) << 40)
> > +#define DPI_DMA_IDS_DMA_STRM(x)			((u64)((x) &
> GENMASK(7, 0)) << 32)
> > +#define DPI_DMA_ENG_EN_MOLR(x)			((u64)((x) &
> GENMASK(9, 0)) << 32)
> > +#define DPI_EBUS_PORTX_CFG_MPS(x)		((x) & GENMASK(2, 0)
> << 4)
> > +#define DPI_DMA_IDS_DMA_SSO_PF_FUNC(x)		((x) &
> GENMASK(15, 0))
> > +#define DPI_DMA_IDS2_INST_AURA(x)		((x) & GENMASK(19,
> 0))
> > +#define DPI_DMA_IBUFF_CSIZE_CSIZE(x)		((x) & GENMASK(13,
> 0))
> > +#define DPI_EBUS_PORTX_CFG_MRRS(x)		((x) & GENMASK(2,
> 0))
> > +#define DPI_ENG_BUF_BLKS(x)			((x) & GENMASK(5,
> 0))
> > +#define DPI_DMA_CONTROL_DMA_ENB
> 	GENMASK_ULL(53, 48)
> > +
> > +#define DPI_DMA_CONTROL_O_MODE			BIT_ULL(14)
> > +#define DPI_DMA_CONTROL_LDWB			BIT_ULL(32)
> > +#define DPI_DMA_CONTROL_WQECSMODE1		BIT_ULL(37)
> > +#define DPI_DMA_CONTROL_ZBWCSEN			BIT_ULL(39)
> > +#define DPI_DMA_CONTROL_WQECSOFF(offset)	(((u64)offset) << 40)
> > +#define DPI_DMA_CONTROL_WQECSDIS		BIT_ULL(47)
> > +#define DPI_DMA_CONTROL_PKT_EN			BIT_ULL(56)
> > +#define DPI_DMA_IBUFF_CSIZE_NPA_FREE		BIT(16)
> > +
> > +#define DPI_CTL_EN				BIT_ULL(0)
> > +#define DPI_DMA_CC_INT				BIT_ULL(0)
> > +#define DPI_DMA_QRST				BIT_ULL(0)
> > +
> > +#define DPI_REQQ_INT_INSTRFLT			BIT_ULL(0)
> > +#define DPI_REQQ_INT_RDFLT			BIT_ULL(1)
> > +#define DPI_REQQ_INT_WRFLT			BIT_ULL(2)
> > +#define DPI_REQQ_INT_CSFLT			BIT_ULL(3)
> > +#define DPI_REQQ_INT_INST_DBO			BIT_ULL(4)
> > +#define DPI_REQQ_INT_INST_ADDR_NULL		BIT_ULL(5)
> > +#define DPI_REQQ_INT_INST_FILL_INVAL		BIT_ULL(6)
> > +#define DPI_REQQ_INT_INSTR_PSN			BIT_ULL(7)
> > +
> > +#define DPI_REQQ_INT \
> > +	(DPI_REQQ_INT_INSTRFLT		| \
> > +	DPI_REQQ_INT_RDFLT		| \
> > +	DPI_REQQ_INT_WRFLT		| \
> > +	DPI_REQQ_INT_CSFLT		| \
> > +	DPI_REQQ_INT_INST_DBO		| \
> > +	DPI_REQQ_INT_INST_ADDR_NULL	| \
> > +	DPI_REQQ_INT_INST_FILL_INVAL	| \
> > +	DPI_REQQ_INT_INSTR_PSN)
> > +
> > +#define DPI_PF_RAS_EBI_DAT_PSN	BIT_ULL(0)
> > +#define DPI_PF_RAS_NCB_DAT_PSN	BIT_ULL(1)
> > +#define DPI_PF_RAS_NCB_CMD_PSN	BIT_ULL(2)
> > +
> > +#define DPI_PF_RAS_INT \
> > +	(DPI_PF_RAS_EBI_DAT_PSN  | \
> > +	 DPI_PF_RAS_NCB_DAT_PSN  | \
> > +	 DPI_PF_RAS_NCB_CMD_PSN)
> > +
> > +#define DPI_DMAX_IBUFF_CSIZE(x)	(0x0ULL | ((x) << 11))
> > +#define DPI_DMAX_IDS(x)		(0x18ULL | ((x) << 11))
> > +#define DPI_DMAX_IDS2(x)	(0x20ULL | ((x) << 11))
> > +#define DPI_DMAX_QRST(x)	(0x30ULL | ((x) << 11))
> > +
> > +#define DPI_CTL		0x10010ULL
> > +#define DPI_DMA_CONTROL 0x10018ULL
> > +#define DPI_DMA_ENGX_EN(x) (0x10040ULL | ((x) << 3))
> > +#define DPI_ENGX_BUF(x)	(0x100C0ULL | ((x) << 3))
> > +
> > +#define DPI_EBUS_PORTX_CFG(x) (0x10100ULL | ((x) << 3))
> > +
> > +#define DPI_PF_RAS 0x10308ULL
> > +#define DPI_PF_RAS_ENA_W1C 0x10318ULL
> > +
> > +#define DPI_DMA_CCX_INT(x) (0x11000ULL | ((x) << 3)) #define
> > +DPI_DMA_CCX_INT_ENA_W1C(x) (0x11800ULL | ((x) << 3))
> > +
> > +#define DPI_REQQX_INT(x) (0x12C00ULL | ((x) << 5)) #define
> > +DPI_REQQX_INT_ENA_W1C(x) (0x13800ULL | ((x) << 5))
> > +
> > +#define DPI_MBOX_PF_VF_DATA0(x) (0x16000ULL | ((x) << 4)) #define
> > +DPI_MBOX_PF_VF_DATA1(x) (0x16008ULL | ((x) << 4))
> > +
> > +#define DPI_MBOX_VF_PF_INT 0x16300ULL #define
> DPI_MBOX_VF_PF_INT_W1S
> > +0x16308ULL #define DPI_MBOX_VF_PF_INT_ENA_W1C 0x16310ULL
> #define
> > +DPI_MBOX_VF_PF_INT_ENA_W1S 0x16318ULL
> > +
> > +#define DPI_WCTL_FIF_THR 0x17008ULL
> > +
> > +#define DPI_EBUS_MAX_PORTS 2
> > +
> > +#define DPI_EBUS_MRRS_MIN 128
> > +#define DPI_EBUS_MRRS_MAX 1024
> > +#define DPI_EBUS_MPS_MIN  128
> > +#define DPI_EBUS_MPS_MAX  1024
> > +
> > +#define DPI_QUEUE_OPEN  0x1
> > +#define DPI_QUEUE_CLOSE 0x2
> > +#define DPI_REG_DUMP    0x3
> > +#define DPI_GET_REG_CFG 0x4
> > +#define DPI_QUEUE_OPEN_V2 0x5
> > +
> > +#define DPI_MAGIC_NUM	0xf
> > +
> > +struct dpi_mps_mrrs_cfg {
> > +	u16 mrrs; /* Max read request size */
> > +	u16 mps;  /* Max packet size */
> > +	u8 port;  /* Ebus port */
> > +};
> > +
> > +struct dpi_engine_cfg {
> > +	u64 fifo_mask; /* FIFO size mask in KBytes */
> > +	u16 molr[DPI_MAX_ENGINES];
> > +	u8 update_molr; /* '1' to update engine MOLR */ };
> > +
> > +enum dpi_mbox_rsp_type {
> > +	DPI_MBOX_TYPE_CMD,
> > +	DPI_MBOX_TYPE_RSP_ACK,
> > +	DPI_MBOX_TYPE_RSP_NACK,
> > +};
> > +
> > +struct dpivf_config {
> > +	u16 csize;
> > +	u32 aura;
> > +	u16 sso_pf_func;
> > +	u16 npa_pf_func;
> > +};
> > +
> > +struct dpipf_vf {
> > +	u8 this_vfid;
> > +	bool setup_done;
> > +	struct dpivf_config vf_config;
> > +};
> > +
> > +/* DPI device mailbox */
> > +struct dpi_mbox {
> > +	struct work_struct work;
> > +	/* lock to serialize mbox requests */
> > +	struct mutex lock;
> > +	struct dpipf *pf;
> > +	u8 __iomem *pf_vf_data_reg;
> > +	u8 __iomem *vf_pf_data_reg;
> > +};
> > +
> > +struct dpipf {
> > +	struct miscdevice miscdev;
> > +	void __iomem *reg_base;
> > +	struct pci_dev *pdev;
> > +	struct dpipf_vf vf[DPI_MAX_VFS];
> > +	/* Mailbox to talk to VFs */
> > +	struct dpi_mbox *mbox[DPI_MAX_VFS];
> > +};
> > +
> > +union dpi_mbox_message_t {
> > +	u64 u[2];
> > +	struct dpi_mbox_message_s {
> > +		/* VF ID to configure */
> > +		u64 vfid           :8;
> > +		/* Command code */
> > +		u64 cmd            :4;
> > +		/* Command buffer size in 8-byte words */
> > +		u64 csize          :14;
> > +		/* aura of the command buffer */
> > +		u64 aura           :20;
> > +		/* SSO PF function */
> > +		u64 sso_pf_func    :16;
> > +		/* NPA PF function */
> > +		u64 npa_pf_func    :16;
> > +		/* Work queue completion status enable */
> > +		u64 wqecs	:1;
> > +		/* Work queue completion status byte offset */
> > +		u64 wqecsoff	:7;
> > +		/* Reserved */
> > +		u64 rsvd	:42;
> > +	} s __packed;
> > +};
> > +
> > +/* Set MPS & MRRS parameters */
> > +#define DPI_MPS_MRRS_CFG _IOW(DPI_MAGIC_NUM, 0, struct
> > +dpi_mps_mrrs_cfg)
> > +
> > +/* Set Engine FIFO configuration */
> > +#define DPI_ENGINE_CFG   _IOW(DPI_MAGIC_NUM, 1, struct
> dpi_engine_cfg)
>=20
> How is an ioctl description living in a .c file?  This obviously isn't te=
sted and will
> not work :(
>=20
Thanks for the comments.
It did work in my environment that had limited configs enabled. I will move=
 it to include/uapi/misc/*.h file and correct the ioctls as per documentati=
on in next version.

> And those structures will also not work properly as an ioctl, please read=
 the
> kernel documentation for how to do this correctly.
>=20



> thanks,
>=20
> greg k-h

