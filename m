Return-Path: <linux-kernel+bounces-65153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE22D85489D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8611C22890
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87D1AAD8;
	Wed, 14 Feb 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="NNbMu5Dr"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86A1A58E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910866; cv=fail; b=lhrSK7OKsQ5W4/qR3FHDdw7to3lhZmOnXbGERoRvv9NvJoe6Ud4N7gamsgceKzLgEMNIXcjK7bPrcmdwCeTUep9DeoiJIVyFmDItn6Y4gCTgKuH7PZj5Jye2ZA6qgcX3LHcu2itO0v2ZlS8tIB6dQk3gtKN0NQd2ctDbdAjnUuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910866; c=relaxed/simple;
	bh=L9mVT2Uhcd1EwK9KjG9xnwnOaEbbtH0AYIVnjR/UgHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRgusDJdRbS3Ny2cohANzC8X4MQEWuoROZOLTsj9t6A3zjdoEC4vOfyNxz4A7FNV74nFC7en4XwHSShxVpthmNRfTyjao32vZQkZoKTWdBGKDDXVTg3bkNaoj6f3X5i3eKXgbLAPVqr6nCVw9bOBzuH5Gh8eUmZsL1JQ5l6zMKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=NNbMu5Dr; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EB7RhG013343;
	Wed, 14 Feb 2024 03:40:54 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w8vc982n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 03:40:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VosY4TuPrZccXFcPAK9dCjeRfqnNZvL4Nr5Eg6Sod0kQ0i+L9TTV/YpLWPchAqVhSMSOiK9pz4bznAvRltkmk7RBFBK9MoXD/zCLgqBidv9VpUuqA2zHv8lRR2ISYMA/HBItO2KiRIav4OEHEK3FoCN1CoRfhxh7Lz93SFJhRJ9ofEn/KGIIkS/J6rUwd7HnPoVVa9oFWxTYL1jjlqkhB8+/26bXDCFxHaxCeIbpWnc7i3qNXe8WUp3HDz5s2ClSMI8U1u4PvsqmtqRs/kTyzHg++0H1huBovZUvvR97/eOGkRKLUKx9FCH2ZSEQeUDqlT84ay65mCund3f+yLb0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qWnawUZQgYwC80WmOrjE9UoJGkzDpuWq833rQxd6Ew=;
 b=WcLqbCoFQzBrE9wdXYYRivcemRcxhMz9L/FbI0z0j1hJrVAw3laRrvmIsFf9lYN4GDU/oqid0ntaDjtYv58PXyf1kZyQBQhe/e8e9u/RXPbK+Iq0RJmvSwLJ4VMUqAYRfpivN3zfy2mzhPpjl1ER99s0dAdnRPTohDZmnj9bziNFf6pe9/SGPDqJ+tjVly4HHtpP5ULWzgj1geJs7+pZ/5UTWlyvUN7Hjj10I+ouM6+G3V4mbrozhZDPYX+xEU2wd79mv+15+YAos+v6JijcdRnsh29679ZxTn8q9DtaBaIduYkEPkcO1F7IZYHaLXDB2iebBXGrQUCRqcaC+iK7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qWnawUZQgYwC80WmOrjE9UoJGkzDpuWq833rQxd6Ew=;
 b=NNbMu5DrgVstJHpWenBi90rOI2X11KzejpKRPhTeRV8HGJFx+enK2LqbrIAvo0s4m74VGSlXukwESYqll033PJatzZlHLtYV1dMEszLG/j/aHyC+JIoRaZPOSD19MlrfTCsC2/LTWlJ2CT0ajC8sSLx4B9Ru3go2R97ePamz5uI=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by MN0PR18MB5941.namprd18.prod.outlook.com (2603:10b6:208:4bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Wed, 14 Feb
 2024 11:40:51 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::fcd8:46e5:65cd:339]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::fcd8:46e5:65cd:339%5]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 11:40:50 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver
Thread-Topic: [EXT] Re: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver
Thread-Index: AQHaXvm6poyZcGYhI0K74/kDjlABlbEJqW2AgAAEdeA=
Date: Wed, 14 Feb 2024 11:40:50 +0000
Message-ID: 
 <MW4PR18MB5244078101B9FE7BAFB6CC0BA64E2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20240214035524.1245615-1-vattunuru@marvell.com>
 <2024021435-stray-cried-9737@gregkh>
In-Reply-To: <2024021435-stray-cried-9737@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|MN0PR18MB5941:EE_
x-ms-office365-filtering-correlation-id: 3adef5f9-f2ca-4db8-d98b-08dc2d51cb67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0gNPGqmOt4oxuhC9/5ZQOZyUgDrbKeNLbV9GgdzseR2h+NpQn+juAO9bntVDyzFiNkYMKftWBoRl7krag7oVjecXWspG8s3KIeOxkarDdqA1zKoYhSLu+dib4TMBeISgIzUCWnWMAkiBfp68hRkyuWTG6L2cevBYEQTdXC9SbzLYdwvuceTcdzx3oFnFNd62ufn4hranjfaMF+NmMtrtMrFY/wfMtUuAJdVkAh+TTvSUZDFUwbJfMpWz0bAgnL3VOquuB6OiJ/XacAUngL49UoWSmp6iZNDm0h27XXInxjdqpgM58HX3RfA09kH7Qw8Vp9i9KbIYkxsro2snWJUPHfni3D82tLjfblg2lR2F3tfBleL1K9TBSkymoBZfvCHNrPN8RjZQyLYjTk7Nnoia28LqJgXYYlmE335+9Zzw0wN1h5u0AWkkAO36hslu4sWzHtCaXdVv5zFscYiGSgZ12Nle7Hb2YVuquT7sm6sQobIrwgY5H7Gy5MiA9GyFF0WUHSFfioOvbPmJoSJ2evY7fF13/NAescYTWT9hOx3VcoOc/EmRjvxq5RofyPHLABSuAo424u4G0WkK/7wsCTE/EFd9x0YK7LmlMjbE2yrNdJSyFyLuVFnWMqr4TWM4QO/c
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(55016003)(316002)(2906002)(5660300002)(38100700002)(66556008)(33656002)(8936002)(8676002)(66446008)(76116006)(6916009)(54906003)(122000001)(4326008)(66946007)(64756008)(71200400001)(66476007)(83380400001)(9686003)(38070700009)(7696005)(53546011)(41300700001)(478600001)(52536014)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?y4uSxS3SCB4DCWj/kvfA072+FnnoYiX5Z7y2fkTuChygWPL23gvFJNX1jYc7?=
 =?us-ascii?Q?pu5EUi/q+BdfSPjfd1KrotWu0YHaj5/LqrcDJwONy5mwaj3RSrtFC9RAZC4h?=
 =?us-ascii?Q?ETdTjuxQNrLxVWDaaIy7RCBpqAuk3QucB2mjeBkTIIDsDeyv9fKLk28M6Ffg?=
 =?us-ascii?Q?ysIOwcxzxj51a3zKqiqZ7WVUgi8mwum2Cp6AANCu+rctEa2pZvPK1gBg+vxg?=
 =?us-ascii?Q?gJADP7oLKFEZ3kbSJ2fF0kl217MknybD7m5hIrE3OFuVpQzOyVVVVboDeaWi?=
 =?us-ascii?Q?u6GpWnbvj8u7T5tA6p5VZSenZ5Rod6y4HC7iPupvpteBsY84VmsDiYlnUyLs?=
 =?us-ascii?Q?m5vrMT8/IPp9YWWEmEzKsTSgCOKmyqli3CkVNyU/xrjzo0oXBPQhN6VrYayd?=
 =?us-ascii?Q?lxZVyaTdzC4DNABfkqNovCGYA/jRWOAvdpxWl1Lc1I47xa6yXbU8nKCcMJG/?=
 =?us-ascii?Q?JETSCmuXHmE3CdNbxDq6+gDFrPgqgHxFSXNIPAA/2iSWmbFM1g7x271d2GP2?=
 =?us-ascii?Q?c3X0UZ1HGEifsuFFG0gJFjK5YH12CDi5OeWgw8eUcyNV+opyCr/gfSQS3AFz?=
 =?us-ascii?Q?2L+hxB5SiVdNO2H45dxdlVfR5o756T3zTXgxgxOXt9JaeUM2ok4+qU31KXJh?=
 =?us-ascii?Q?QJkksQsrvl+36IguNpxA85g3wObkYYri1yKggZ7X8lMX7fOPSfrpHBXkPRq5?=
 =?us-ascii?Q?iarGKfrxv0ZOIET4TmFFgPkdqBNKSiWbq/lnkrP7vdOGNzu4uopvemN7CnZ2?=
 =?us-ascii?Q?icBJ3LpY5voWaFIAPT6sKK9Z46C7CF1wY6NcZt3QzKHvX041z4KrvDyxvCtV?=
 =?us-ascii?Q?IwBtFfFMCiyMctuiost84C/uBRjp/jy9DND0OGIhpgy0PsOt4P94uZJl9wRM?=
 =?us-ascii?Q?8TIRBub3ixR6yvse1IsvFVP+L1RH2kSnm2vi4x78t7B4ZBpLXilgF2BZlcCC?=
 =?us-ascii?Q?p9QsYTusDgTIyoIbWWvwk9336oWh3CJE7TUiTzOOX6FJBw/XQDqJzYMjKNev?=
 =?us-ascii?Q?mKAAy3tjVlThPSrT9ZQ+SgkkMPOmJDdUZmabfdQEu8Vldj67N7oWrEr9DBqL?=
 =?us-ascii?Q?Y7H7k1fXztSRdlPyOI1F6nRoIy/9dI2cvJcFFyY3mcw9v6bgB4lz9N4dIwmq?=
 =?us-ascii?Q?Hvp9ZpIzRVytixTAtH7pcC6pnzx/f21QnQEvCyqzW9d0uKIUr6whAlqYR4Lc?=
 =?us-ascii?Q?hOXY/3YoNGQMuEU74Otcnk/gL6K5EYQKWVYxK73mMbX/jDQa2p+lrbZK52yi?=
 =?us-ascii?Q?JKkx5ou9bttkNb8WeuNa0i9IUQvfFLjfc090Js6s0cwfD2AmfKyCzxHOsQZC?=
 =?us-ascii?Q?hq+q9RrElcqNZaXcHktg4sx8sltm1P/CwTroEYr1B87tMx9faQjjd0LLVksY?=
 =?us-ascii?Q?hk3A4nUxHf8Zizs6DVjoiidjSQmTJ3zFHIMMu6KzVmb9okuzMR/pQ2JmB22s?=
 =?us-ascii?Q?k+O7gYGL3hvyByv4Q9DkPUczRyVCLh6VPw2bzibbyDXVLL4OxAokRcbp4/3e?=
 =?us-ascii?Q?8ieK7NDFnug3ZBt0CY+ucVP7iL8gH3z9vS2tumz2e76aCqayFwXXvom+H39W?=
 =?us-ascii?Q?ee1a0E0YTGEIcMR7O+SjbEH/5gfr2V8f3GAfcDpDrSS4w20mIoFe9L3tGndd?=
 =?us-ascii?Q?Enb8+DqUsZyo2zlhAMzb474sFipm4wn6bTru64Ok7wEl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adef5f9-f2ca-4db8-d98b-08dc2d51cb67
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 11:40:50.7566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41gTfHZ7yC3wa3T5QraNi0LkMIJTdmYQuovdyMhKp95cNkJAo+A7saC+g6pkQUcTIqYTIw6+Klzmr5B57TsEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5941
X-Proofpoint-GUID: -SBICj4ddphDPk7l74GB6l2tq23xCr0J
X-Proofpoint-ORIG-GUID: -SBICj4ddphDPk7l74GB6l2tq23xCr0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02



-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Wednesday, February 14, 2024 4:21 PM
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
Subject: [EXT] Re: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver

External Email

----------------------------------------------------------------------
On Tue, Feb 13, 2024 at 07:55:24PM -0800, Vamsi Attunuru wrote:
> Adds PCIe PF driver for OcteonTx3 DPI PF device which initializes DPI

What is a "PF"?

PF refers to physical function

WHat is "DPI"?

DPI means DMA offload unit

> DMA hardware's global configuration and enables PF-VF mbox channels

What is "PF-VF"?

It's a mailbox communication hardware between PF & VF

> which can be used by it's VF devices. This DPI PF driver handles only

What is "VF"?

VF refers to virtual function

> the resource configuration requests from VFs and it does not have any=20
> data movement functionality.

What do you mean by "data movement functionality"?

DPI HW has DMA offload engines which can be used from VFs for data transfer=
 functionality.
PF function is just a management interface which mainly does global registe=
r configuration
and any per VF specific register configuration.

Please provide a bit more dummed down description please, for those of us w=
ho don't understand any of this.

Sure, I will add more description. sorry for the poor documentation.

And if this is a pci driver, why is it in misc?

DPI HW device is probed as a PCIe device, and it's PF device is more of man=
agement interface for it's VFs. It only does required hardware registration=
 configurations and more suitable as misc device/driver. I will register it=
 as miscdev and add required ops in next version.=20

Thanks, Greg, for the review comments, I will address all the below review =
comments in next version.

>=20
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  MAINTAINERS                    |   5 +
>  drivers/misc/Kconfig           |  10 +
>  drivers/misc/Makefile          |   1 +
>  drivers/misc/mrvl-dpi/Makefile |   9 +
>  drivers/misc/mrvl-dpi/dpi.c    | 559 +++++++++++++++++++++++++++++++++
>  drivers/misc/mrvl-dpi/dpi.h    | 232 ++++++++++++++
>  6 files changed, 816 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS index=20
> 960512bec428..73029199716d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13104,6 +13104,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>  F:	drivers/mmc/host/sdhci-xenon*
> =20
> +MARVELL OCTEONTX3 DPI DRIVER
> +M:	Vamsi Attunuru <vattunuru@marvell.com>
> +S:	Maintained
> +F:	drivers/misc/mrvl-dpi
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index=20
> 4fb291f0bf7c..3142fdb1b4c0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -574,6 +574,16 @@ config NSM
>  	  To compile this driver as a module, choose M here.
>  	  The module will be called nsm.
> =20
> +config MARVELL_OCTEONTX3_DPI
> +	tristate "OcteonTX3 DPI driver"
> +	depends on ARM64 && PCI
> +	default m

Don't set a default unless you can not boot the box without it.

> +	help
> +	  Enables OCTEONTX3 DPI driver which intializes DPI PF device's global =
configuration
> +	  and it's VFs resource configuration to enable DMA transfers. DPI PF d=
evice
> +	  does not have any data movement functionality, it only serves VF's re=
source
> +	  configuration requests.

module name?


> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index=20
> ea6ea5bbbc9c..86229072166c 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+=3D xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+=3D tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+=3D tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+=3D nsm.o
> +obj-$(CONFIG_MARVELL_OCTEONTX3_DPI)	+=3D mrvl-dpi/
> diff --git a/drivers/misc/mrvl-dpi/Makefile=20
> b/drivers/misc/mrvl-dpi/Makefile new file mode 100644 index=20
> 000000000000..c938ea459483
> --- /dev/null
> +++ b/drivers/misc/mrvl-dpi/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for Marvell's OcteonTX3 DPI driver #
> +
> +obj-$(CONFIG_MARVELL_OCTEONTX3_DPI) +=3D octeontx3_dpi.o
> +
> +octeontx3_dpi-y :=3D dpi.o

Why the two steps?  Why not just name the file the module name?

And because of that, why do you need a subdirectory?

And if you do have a subdirectory, why not move the Kconfig entry into it? =
 You can't have it both ways here, sorry.


> +
> diff --git a/drivers/misc/mrvl-dpi/dpi.c b/drivers/misc/mrvl-dpi/dpi.c=20
> new file mode 100644 index 000000000000..fe0b3ee469c8
> --- /dev/null
> +++ b/drivers/misc/mrvl-dpi/dpi.c
> @@ -0,0 +1,559 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell OcteonTx3 DPI driver
> + *
> + * Copyright (C) 2024 Marvell International Ltd.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +
> +#include "dpi.h"

Why do you need a .h file for a single .c file?

> +
> +#define DPI_DRV_NAME	"OcteonTx3-dpi"
> +#define DPI_DRV_STRING  "Marvell OcteonTx3 DPI Driver"
> +#define DPI_DRV_VERSION	"1.0"

Driver versions do not make sense once they are in the kernel tree, please =
remove.

> +static int mps =3D 128;
> +module_param(mps, int, 0644);
> +MODULE_PARM_DESC(mps, "Maximum payload size, Supported sizes are 128,=20
> +256, 512 and 1024 bytes");
> +
> +static int mrrs =3D 128;
> +module_param(mrrs, int, 0644);
> +MODULE_PARM_DESC(mrrs, "Maximum read request size, Supported sizes=20
> +are 128, 256, 512 and 1024 bytes");
> +
> +static unsigned long eng_fifo_buf =3D 0x101008080808;=20
> +module_param(eng_fifo_buf, ulong, 0644);=20
> +MODULE_PARM_DESC(eng_fifo_buf, "Per engine buffer size. Each byte=20
> +corresponds to engine number");

This is not the 1990's, no module parameters should be needed, and they don=
't work at all when you have multiple devices.  Please make this "just work=
" and if you have to tune it, make them proper dynamic options at runtime.

> +	while (cnt) {
> +		reg =3D dpi_reg_read(dpi, DPI_DMAX_QRST(queue));
> +		--cnt;
> +		if (!(reg & 0x1))
> +			break;
> +	}

That's a long busy-wait loop, one that will take a variable amount of time =
given different processor speeds.  Shouldn't you be using a real timeout in=
stead?

> +
> +	if (reg & 0x1)
> +		dev_err(&dpi->pdev->dev, "Queue reset failed\n");

What can userspace do with this message?  And why not return an error if an=
 error happened?  Why are you ignoring it here?

> +
> +	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), 0ULL);
> +	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), 0ULL);
> +
> +	reg =3D DPI_DMA_IBUFF_CSIZE_CSIZE(csize) | DPI_DMA_IBUFF_CSIZE_NPA_FREE=
;
> +	dpi_reg_write(dpi, DPI_DMAX_IBUFF_CSIZE(queue), reg);
> +
> +	reg =3D dpi_reg_read(dpi, DPI_DMAX_IDS2(queue));
> +	reg |=3D DPI_DMA_IDS2_INST_AURA(aura);
> +	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), reg);
> +
> +	reg =3D dpi_reg_read(dpi, DPI_DMAX_IDS(queue));
> +	reg |=3D DPI_DMA_IDS_DMA_NPA_PF_FUNC(npa_pf_func);
> +	reg |=3D DPI_DMA_IDS_DMA_SSO_PF_FUNC(sso_pf_func);
> +	reg |=3D DPI_DMA_IDS_DMA_STRM(vf + 1);
> +	reg |=3D DPI_DMA_IDS_INST_STRM(vf + 1);
> +	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), reg);
> +
> +	spin_unlock(&dpi->vf_lock);
> +
> +	return 0;

Shouldn't you have returned an error if one happened?

> +static int queue_config(struct dpipf *dpi, struct dpipf_vf *dpivf,=20
> +union dpi_mbox_message_t *msg) {
> +	switch (msg->s.cmd) {
> +	case DPI_QUEUE_OPEN:
> +		dpivf->vf_config.aura =3D msg->s.aura;
> +		dpivf->vf_config.csize =3D msg->s.csize / 8;
> +		dpivf->vf_config.sso_pf_func =3D msg->s.sso_pf_func;
> +		dpivf->vf_config.npa_pf_func =3D msg->s.npa_pf_func;
> +		dpi_queue_init(dpi, dpivf, msg->s.vfid);
> +		if (msg->s.wqecs)
> +			dpi_wqe_cs_offset(dpi, msg->s.wqecsoff);
> +		dpivf->setup_done =3D true;
> +		break;
> +	case DPI_QUEUE_OPEN_V2:
> +		dpivf->vf_config.aura =3D msg->s.aura;
> +		dpivf->vf_config.csize =3D msg->s.csize;
> +		dpivf->vf_config.sso_pf_func =3D msg->s.sso_pf_func;
> +		dpivf->vf_config.npa_pf_func =3D msg->s.npa_pf_func;
> +		dpi_queue_init(dpi, dpivf, msg->s.vfid);
> +		if (msg->s.wqecs)
> +			dpi_wqe_cs_offset(dpi, msg->s.wqecsoff);
> +		dpivf->setup_done =3D true;
> +		break;
> +	case DPI_QUEUE_CLOSE:
> +		dpivf->vf_config.aura =3D 0;
> +		dpivf->vf_config.csize =3D 0;
> +		dpivf->vf_config.sso_pf_func =3D 0;
> +		dpivf->vf_config.npa_pf_func =3D 0;
> +		dpi_queue_fini(dpi, dpivf, msg->s.vfid);
> +		dpivf->setup_done =3D false;
> +		break;
> +	default:
> +		return -1;

That is not a valid error number :(


> +static int __init dpi_init_module(void) {
> +	pr_info("%s: %s\n", DPI_DRV_NAME, DPI_DRV_STRING);

When drivers work properly, they are quiet.  No need for this.


> +
> +	return pci_register_driver(&dpi_driver); }
> +
> +static void __exit dpi_cleanup_module(void) {
> +	pci_unregister_driver(&dpi_driver);
> +}
> +
> +module_init(dpi_init_module);
> +module_exit(dpi_cleanup_module);

module_pci_driver() instead?  That will automatically get rid of the
pr_info() spam above :)

thanks,

greg k-h

