Return-Path: <linux-kernel+bounces-142778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9CD8A2FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799E31F23394
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480458593C;
	Fri, 12 Apr 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FcgYWgc0"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D28626E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930211; cv=fail; b=VGFSQhE3+blVFC+ek+2urlFjvi0OYZgBLmhxJ1WNSIlKHYIRhUJIBgZxv1BeD9O8RP3ZE44WktlKZydGq4rpVKXz+lwnPXOePPnK9EU18+VIp/G0uWWH5nqolzWwXzFuyKOcuTk1je4Q0u8TXCgf7N7aAR7M6Eb9aUvDzynhJzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930211; c=relaxed/simple;
	bh=HhyS9PvzO4DbvooBxoCA7PX9QPgdSvm3578B9erTRNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7GyzHXeI3AColfrDNLVD30b6Uz3PbR1Y2M9YM2v6+ad0qx3VArv0RZqVbXQJPGhBeQmYjYke7FI7jRx3HHOK17ojLBU/qw6vaTc0IRwtiLeNs7UkMFAE+Hl6RNp9R/1cSO48TrA6t926TI72/TxEpj6m4fyOiumw0Rve5wYa5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FcgYWgc0; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4AFgA009090;
	Fri, 12 Apr 2024 06:56:39 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xewph1qqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXB2WiCiDwWkmxxOy+/yQWIAb2jJzeeeD4OQy/eb558RtFAQtM35KF61f3Jhn35i4CJvVBH9QzFnXzhbAA3d7w+uiXXp4fAr+AJv9MMqXo3Hi3C+Dc8SptLNtJwJsqJb5YELFISyRpW6nfWi0i+qi2IAfLh5F08rQCTOD4qatnWCBxWeRFYNtZwLaBys4Bhqr4w7mo1zqROHOMTxxKvSsxc39vxRb2K0skzE/cIdV1uWuta3/VwuRO8FYm3YLpB9EOKdZ1/WRJz2wyQSuxxxwi7X3t05QFD01TPJRwwXPB7FoywZJg4ULjw4Y943m9fw4UM1k06w5FSCONnQVnPPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUrCYDmqkPzyfe8yMxDptwQAyX0c5X04ggUh8pODXbE=;
 b=hasWcf+U9Of+RNUGRT0YHHy78RQ+tJ629oZMmQcTxrMTykaKPMcgvimtaRi/frYLUfw87uBHFamEr32XgBHHpdzsBn7UDsJszOmz6JDXqUVfPQTQutOktCc/bz4ZLtY3t66x0VtLM8RORM3+QlBxCXOCL4kQsL41sIrlsC8pVWOqcQSTIpmuDbR2u3NdxWoUDukCLxDOtQ1d6rU6MnTvIyjlAwsCbh7SlghLJxGuGFZ72hD1ItvFRBeablF2kPKiw7WoGFh13ek2JiRM15LcWUggg8CWSCqZX0Ho0RSeAzH8PcNaymNJpiYj2rYxZlSu0nw5RJBwwEh8BWnQERbkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUrCYDmqkPzyfe8yMxDptwQAyX0c5X04ggUh8pODXbE=;
 b=FcgYWgc0ht1pE0Fjh0WgFHKuAje3dnO8D+bT4F3Y+jSh0xOkAAKJB4ItgehKmIxan658LI9DWp9QcUitmTw2GHOmCCLb9H+RaWWKi3g9X2Dd68M0UJ1ebkxAolr159FRTjYIDOxTa7np7zndG7AMa1PD76DG2tmCtZ8Kui/TSxg=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SN7PR18MB4094.namprd18.prod.outlook.com (2603:10b6:806:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:56:36 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 13:56:36 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHajNJlUzRgj48oqke7eNtbl1jogrFkj7+AgAAOmwA=
Date: Fri, 12 Apr 2024 13:56:36 +0000
Message-ID: 
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
In-Reply-To: <2024041250-nursing-tidy-db7e@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SN7PR18MB4094:EE_
x-ms-office365-filtering-correlation-id: 40fecf88-450a-4a79-0a09-08dc5af85e89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jLksAnD0LwuHxqPERYmBD7agIbUGvhQ2N0eOmqDLpLS2U+MLwv0xdGhKs8L8ufNYuJ3liI0w375N6jEZfxl9dWYavlK53rVXBYddC829PjAxtkuCb3zvMgzL7i0ITiZMa87+oCWR5dD2bw6MZK7GMNBwFE5uSSa/+KFfJMGV6EggVRXvNm86GKeybougxWn4L7irXis/AaMxPg2PixR49bqwti9ST8XvhoSKEdmseVbLrjIJdejqYvcYl57urcFXjdNZsJzpNPlfnuIGRnapKgbZ6wZ65WTBtmvBVpIR1WrvDp5zESoq7HPfJrYAYKDsyAelRkWFuzcwIWHz72ArJzyhb3Qn0fFlFzbbQWdTpS4jOqGh8fYmB2n+PyCAHqWSpfUUkGqaJ2+qYqFjfwc+t6c+X2OaJd2xmfS51+Z/oNC7GnnbUtPXhnu0tNirY1sGhBaNeUy0HQjRcDIsWOB+u0BiEuTEjZjcKFcoTnWovlVpYkalTCLhcp146f+YkBgA7KFSoqKi4cq5Hh6XrJvVUAUyndtJDD3UrQ1fyXzJT6D40qJCd+NvFpf6Z4o+3zpqoXDRaYaC0M3vON02ojzkjJrKFmgjbAx53WHC2TlXp+B6vwvyW91zueed2Yx30Im1d/MZn4n7YUd/dFtPStbN5ubppiGQXcw/f5IfGG3VeOLCRsA7ygO+QbmVkdlnG0SJCypMWdcknJuhkEZ68g7l+7PUNf1kPHEaf51H2Y8u9Ug=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5szOMqm6jczXwNwSY9DdZsr74I6cZcmnfPUS2HzWKH3V1Q5xfzfCd6pEeYLD?=
 =?us-ascii?Q?NOWYRuzmf4s+nFBGcfk6qa25lI9vU5VSnzCnB9/oKhauDnh80xillnxkU7CH?=
 =?us-ascii?Q?WchmFS513SOr/uagwGH7MVQW6s9/FXAqCY0m/r66FEHHPYF7tRplzEiey3V6?=
 =?us-ascii?Q?46iZNMpjnQYCqWsQ7Y4FGfEvC5wdsvNkf70nElyd5dbmyQ8JvcJwirD6P8hG?=
 =?us-ascii?Q?Vl3CHhmv8SPO2zondAt25GLIn02eEXVTvwZ53VYHGjyoGSsFgRe9UZvaTbQA?=
 =?us-ascii?Q?WQ85kT12WwkJfOU7Knk3tDfdaw00yQLKmZNhzJxhAN9ZQMTb/g6Sq+1XNLJv?=
 =?us-ascii?Q?cBZ0WRp+GaT/yvsYusuhj1f0xUezmO2TKJq8qgRs0QwZwuKE6kG3n0eYxPUe?=
 =?us-ascii?Q?dz09Gl4oUWE9I7OJRONe+0Ly3AlGWF9K7yxrkaMuGdMEUsEW/0b+tcqVbgDo?=
 =?us-ascii?Q?X99jAB2l9zgwpFMO1zQePcsACyQVykPJ9VqFmb0XLXOHBf9qX9mkJUUubwZJ?=
 =?us-ascii?Q?HcjwKu85/WavVfmvRqhAfePCkycFRe+/c/eNDLBLZjFmviECboBVIdiyaBqy?=
 =?us-ascii?Q?Uv9p28HLAw2vI4aoUuUO5CZ7nNCom8/I0B1TFdWjKRUqUejH8zyErV3rWulg?=
 =?us-ascii?Q?pwChEAghYDBeq1wH2eAp9TUV4k0hQ0lknxGb81JV72M94MVdrrw/4v/E04Fy?=
 =?us-ascii?Q?9xAB3Up9yRE+vU1eOchxKNq6tP7xsYUi2XB0Frc1f8so9PvWTeWjg5vE9ZAK?=
 =?us-ascii?Q?Dal/MIC4+VtVPhXfjFJy5UYofu+nWb2ZfbvyGHq7WJPkhON6N40DSqDIGI3J?=
 =?us-ascii?Q?NIp5VPKomuo/qh1xSBq+rzYbqOiKMvNJXmg4c0T9M3+ZPmchrwSZTAh+IzXY?=
 =?us-ascii?Q?ZNPPcpVCDnvoi9gAOw68NO+n2K0E6LYf5jm2JTtcBHutD4195I2BfGLGF9pn?=
 =?us-ascii?Q?7ZlJbIwK/if7simAyGzK1kybNWBkrx2tLfYrbdhoA6kAtzV2kDHiW7GAYT7w?=
 =?us-ascii?Q?5Tt1Osmru1ZtBuDi0dhb05EgAq11ostOZLyniCFVg0h7nvuRaXCEfqMA6a6x?=
 =?us-ascii?Q?pm+1FueuaSpfVYb22+9nt+4T1Cm0UKL0rBCKePDrtxbOWVOi2/tuRmbm5Y4R?=
 =?us-ascii?Q?WAetWI1SRguOHYcgRTqj31H54z6RCXBg6g93tPuy+QWe7aoMAPjr49ZJnnsg?=
 =?us-ascii?Q?LR2GtgJqAqbzTklXPIedQr5IEeQ8pVzom8D6ymAND2mvHLcxABtr2pciLzMJ?=
 =?us-ascii?Q?zbyggDCfyc/BViayq1S+R9AR7XyP9Kyjdfve2OZDQQSAHluGrF/rXhk29aZL?=
 =?us-ascii?Q?8bRcpal+GKo9RV4ulauQT751DAfBvZaPlL0y8+PLfeULTH3rgHGC5/xgo5Mk?=
 =?us-ascii?Q?N+nKu3V57vz2HaX6arl1Af110ElDUTJ+2d6Lkk+MQSMg5KcXizQRFg1nNIH4?=
 =?us-ascii?Q?U5Yx/YXzKPMb/W9efQtKFSq9LL6LXUlsJkrt72QiJzT3w7TA5r9Hjiw5zRKE?=
 =?us-ascii?Q?Uq2/OsEPfPTjdqlisYxbWSnZcfgQZs7euKjEFgOSUkQa1s5TcuK31CVUEOhr?=
 =?us-ascii?Q?LIgyVL3P9Vc1RConpta3KNOcDwH+afk3fU5dIKZy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fecf88-450a-4a79-0a09-08dc5af85e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 13:56:36.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImqBTntfrxNBZ9I+4T4shBWV2+Z+8ldWd/zkXsIYS/KlxJgkuKXlOjNs+Nqxrld6+PL8u4cdnEXJ1ycVwPqLAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4094
X-Proofpoint-GUID: T63In0Ehf8gEc9I6U88aKRWTlhKKY32L
X-Proofpoint-ORIG-GUID: T63In0Ehf8gEc9I6U88aKRWTlhKKY32L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_10,2024-04-09_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, April 12, 2024 5:57 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
> CN10K DPI administrative driver
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru wrote:
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
>=20
> No pointer to the userspace code that uses this?  Why not?  How are we
> supposed to be able to review this?

Userspace code will use two functionalities (mailbox & ioctl) from this dri=
ver. DPDK DMA driver uses the mailbox and
the dpdk application uses the ioctl to setup the device attributes. We are =
waiting for this kernel driver get merged
 to update the corresponding support in DPDK driver and applications. I wil=
l provide the pointers to both the use
cases in userspace code.=20
Meanwhile below is the current dpdk dma driver that uses sysfs based scheme=
 to convey mbox requests to
the kernel DPI driver which gets replaced with hardware mailbox scheme once=
 mrvl-cn10k-dpi kernel driver is merged.
https://github.com/DPDK/dpdk/blob/main/drivers/common/cnxk/roc_dpi.c


>=20
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
>=20
> Did this pass checkpatch?  Please wrap your help text at the proper bound=
ry.

Yes, I did not find any failure, will double check and wrap the text as sug=
gested.
>=20
> And what is "DPI"?  What is "PF"?  What is "VF"?  These are all terms tha=
t
> need to be documented somewhere, right?

Yes, I will describe in full form or document it somewhere.

>=20
> > --- /dev/null
> > +++ b/include/uapi/misc/mrvl_cn10k_dpi.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * Marvell Octeon CN10K DPI driver
> > + *
> > + * Copyright (C) 2024 Marvell.
> > + *
> > + */
> > +
> > +#ifndef __MRVL_CN10K_DPI_H__
> > +#define __MRVL_CN10K_DPI_H__
> > +
> > +#include <linux/types.h>
> > +
> > +#define DPI_MAX_ENGINES 6
> > +
> > +struct dpi_mps_mrrs_cfg {
> > +	__u64 mrrs; /* Max read request size */
> > +	__u64 mps;  /* Max packet size */
>=20
> You can spell out variables with more characters :)
ack
>=20
> > +	__u64 port; /* Ebus port */
> > +};
> > +
> > +struct dpi_engine_cfg {
> > +	__u64 fifo_mask; /* FIFO size mask in KBytes */
> > +	__u64 molr[DPI_MAX_ENGINES];
>=20
> What is a "molr"?
Sorry, I will add required full forms. It's maximum outstanding load reques=
ts.
>=20
> > +	__u64 update_molr; /* '1' to update engine MOLR */
>=20
> You "burn" a whole 64 for 1 bit?  That feels wrong, who on your end
> reviewed this api to be correct?

Just for the explicit alignment, defined all variables as __u64. I will shr=
ink it to minimal sizes
considering any reserved fields if required.

>=20
> > +#define DPI_MAGIC_NUM	0xB8
>=20
> Did you document this api somewhere?

No, I followed as other MAGIC NUM api definations, will document it as requ=
ired.
>=20
> > +
> > +/* Set MPS & MRRS parameters */
> > +#define DPI_MPS_MRRS_CFG _IOW(DPI_MAGIC_NUM, 1, struct
> > +dpi_mps_mrrs_cfg)
> > +
> > +/* Set Engine FIFO configuration */
> > +#define DPI_ENGINE_CFG   _IOW(DPI_MAGIC_NUM, 2, struct
> dpi_engine_cfg)
> > +
> > +#endif /* __MRVL_CN10K_DPI_H__ */
> > --
> > 2.25.1
> >

