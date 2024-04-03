Return-Path: <linux-kernel+bounces-129053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E798963F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1041E1F22309
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E64654E;
	Wed,  3 Apr 2024 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="q18mTn+4"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50B645
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712121765; cv=fail; b=FsX0u/XZm2M6elMWTNdqR+OW4Jgbxx8Ej6UBclL/TbG86/imMCCy1Ly1fRCcf+caepllhD4aL0oGmEavxehY346rDhe4rJr4omIaSzz6aRL2Cn4gmBaer1aElktMYR4yqA+bPJ0YL2MYqSAc7yGtNa+mW7hz1E5I0de6LAf+Y84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712121765; c=relaxed/simple;
	bh=ktGLojl+T+X5hMYQMUs2+2cuZ4HdF6991O9TkNMCTXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AWm4NLyk1RD/WIxp1G5dRowiD0eOephROgFqCccpKVeX1Uleph1+bdtpggLfsPMs+F8Di0nBVRLLJ/ljjVF706nVxQURLz8FdTqoKPt7SpM/EBMTwkXqWNpyjmkCxmo+3RMxK7hpom8RJhNSJUfb5mXO564TQibz8awNISgtaxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=q18mTn+4; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432K38BS029108;
	Tue, 2 Apr 2024 22:22:29 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x809fxfbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 22:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYCaFryJ/XuZrOxY5vMRNZ+xSZP7bQzgEZmurWQ4qoxkQb11m9+86ZtZywnjBFSgEZkag2+E8pTPDxSCnRaM5C1f+csYjwiPmrDD8OIm6bdnNpw3BdxtbOXlq35cclfX4gP+wPkqzx5JpJJq3g58bQ1JDQz6lNzYiUfMKRwLuTzLV4DrBjb8KX+71SaahRu5+Dx2/+1fiA65zMXwPLFIrLqgdomtj7NbRBS97fw+TABYcMl38mtc3f2ik/FeASnITRWdiSI63XWhy7ix2yXrFBe7rTTaC4+A6hp4yU9tEOsdNHb6L9Zg9MoWECoSLhkmFUZYdjZHy9oUAD0licOZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCCyTa/etB4bpF5VUue6ei0khY20in0yJREX5/dI/fo=;
 b=XpksFZQGZ497NcXxcGz2K1TmNpJxzdYE/Aoh5tFQ8Nkh2ph5iviP9oR3JbINTF2H/g3E+9jATd9BmxHjv9USQeetc14cgXQ3NQ2w0YOa1nV1uwOoi2XuNMjYAEjoSvbJgKeMqF0I+UZM8L8dMBAT49V0z2gpT6VWSNP9LG8FEMIu+qsTsVikPicPie2/6igVYpCvqIvwampj9Zsgt7+fEPPc2uIsVb3q1Ap1yid6OTSW4mWMXF1i5amDnws0/4X2RVCn++lIoP3hCWUpI0SLF2Zehy8zGdazDPaFgDIAmj0uHOcpOGTy44Acgog0/YZ9jyAjpJmPx0EmFSTTh8ISrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCCyTa/etB4bpF5VUue6ei0khY20in0yJREX5/dI/fo=;
 b=q18mTn+4MzO74EVHLdovrD+Zn8snhg58nBDni3stJfgHZr82rB8RhGHwkmEFJvXZjEcEIxqm6EdFOJJgSQXUdaiTpPW7ePOlQ0C9d1WG8a4nQai7BnvE9QUwzqcMSFNMcftF+uEXMpUlwX5JZz8tQGSbSlCiZUPXN8gBUXtXzak=
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by MN2PR18MB3447.namprd18.prod.outlook.com (2603:10b6:208:26d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 05:22:23 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::f9a7:a7a:e168:e7db]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::f9a7:a7a:e168:e7db%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 05:22:23 +0000
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: RE:  [RESEND PATCH v3] perf/marvell: Marvell PEM performance monitor
 support
Thread-Topic: [RESEND PATCH v3] perf/marvell: Marvell PEM performance monitor
 support
Thread-Index: AQHahYboW5jwuJDJu0OjQI64yZRErg==
Date: Wed, 3 Apr 2024 05:22:22 +0000
Message-ID: 
 <SN1PR18MB21264C51D689240C495322FCDB3D2@SN1PR18MB2126.namprd18.prod.outlook.com>
References: <20240327072117.1556653-1-gthiagarajan@marvell.com>
 <695199ba-c71d-43ec-8305-8f52488b8c5d@lunn.ch>
In-Reply-To: <695199ba-c71d-43ec-8305-8f52488b8c5d@lunn.ch>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR18MB2126:EE_|MN2PR18MB3447:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 O3UUNONbE1SUmRpgXyIawEwJcdrrezLuWP7FyasLoZyAzD+MXlvrRCNAUFaKqdI6A7cFWbcP+Z5AEVl3xBJ6OB0hWqEaZQUFDZUapHJW0DWXqUM44AuhfuCm+QP/JeGmpkth6QRggNda1k9+6Hb0RF7DpuUdV850LRJW8/Q14pfVLDEQS+I+g+fLgU4fujCDOtIbTmw5H1peWrB0ctqr3AYwFWc3eEw6zQl9yresC/h5Us/DivoYRPlbgxbcxJ+YE3Yd2AvNLIhPqBX1Cv4U+CjzOz3GxM7z4Ygv+VxLZY0lkrZVvDSzIDrdnGgAdh9xV2BAjP82oAPNQvH500SCP6A54D25ya7XY8B1+nRv4v9zsWkXVV8JP/rKwwh6M+eyXjFrcMrKD9+0OrkHPJ2xcKbCl30n6bFmPLzHoNXk7//E3HTWKVThKF1OU2Jzd2cwcgKis1nbLYiPPoc3qGpUe9b3Bz+dj5ZAYuR5ZPt+cd2OdrHi8ZOmGTcVxspE+p4XE7DU52fAF/1+qWcZ3hAZ3sqII965+Pbg4I6U2dHCfoTl5gJ4JDBGkhBqK3hTsVTn4L37DHylWxkU8zoDEwFyZjGVYiaJcRUaBwoY2FOQ3e9HQDgDBSTdiYxz+sRSjEgh00p1zzqBmbhnlUEvW7526OiKCbR9JDZcCDIiwfgigxw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR18MB2126.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qLkUuy+2Pe66aggB3PLT2J1O11PLZWpRpVIUCHgiVYR1bL1sdL8gcdfg9CKQ?=
 =?us-ascii?Q?0NzJY7a3ECGoBZtYVhUTJqZHHY1/TxfDymuYpg1C7+GmVUhaI/vBR+ftQLMw?=
 =?us-ascii?Q?2BLlM4Qf/t3PahKMBdA/7Tf80/HmAHKIuv2VmKdod68IFluWYeUz2rszO4lO?=
 =?us-ascii?Q?BfDB535Rhv1tMi3mOGL2CrZi6+ha57zIDbnUBWTOLaccsm7g0/4pZp55GQK4?=
 =?us-ascii?Q?NzNejLYUpilMngwev8XFXq9CldSSNTPlGjQAmhlu8o2wjsvlvh6xq42R80hC?=
 =?us-ascii?Q?wMx3u29jj0iSV1XOcGO8C8RpfUmYBSiYH9C3iIT+ymdhRUZyiap8Awo9JFzL?=
 =?us-ascii?Q?Alup82vJJIHNxQEe4DBn5kDwIO++d45TXzMHheeyM83kuW6/pnXGdOXJQoUX?=
 =?us-ascii?Q?KEtISvZ33LxGpvrxJgP8trqHsveJqW/fQs6VyQ4BrIOEh8GHKJHji/mIXik7?=
 =?us-ascii?Q?SdkTJDbDFD9qbTOj9m7tuaJbdEzpR9KEQPct2BpaqZgYWw+DzWLEpJ7sNVLC?=
 =?us-ascii?Q?1WHVJ3/M/EV9TglEtFk8PuX8T4gkoJL29upzK+4pIXzhdzxO9LpNvG1Img0e?=
 =?us-ascii?Q?pFRt5kK9mUQbnTDh5EPm5voQNabqxZ5Y6sT1hEG/VR1aO1Oew/jP3LqU9bPS?=
 =?us-ascii?Q?KTtOmvj0/Q/yTAc49hYtfyTrYaePDB6ZB4UhG0o5b+kXR7xfjaCqx68gZU9x?=
 =?us-ascii?Q?RZyuTD7yM6ZZ/WXxmOpnLIhBEo7ThNuu63vkFFoWZtasV9k0q1C108ilo0Jj?=
 =?us-ascii?Q?Z2W2QWU8X4Y5/kQw7qpe/jNquup5zq7nRBe8kXGS46BBmPbCyjf0/Hsh0WHB?=
 =?us-ascii?Q?c49FgrpHv1vaBUTyYY7gkDBNP5d42UJLG3t5NdCGpE951NA1g/XSM/cuWLQz?=
 =?us-ascii?Q?jlvZfEZq8uk2tQpYGFiePrqJBvaCMoTR264l+jQGXKz02sdl4Z0aFSapiGdg?=
 =?us-ascii?Q?2L7yECxMVK1BSZlq7zwNpS9LSn5PODjakF7RNJHkiAAqYvQF2M43GhikE8xD?=
 =?us-ascii?Q?/EBXzifQT/x6u4TgvYN3s8uK7UorPoqfReKXJkpbro0zvJRZpv0xnRcQnuom?=
 =?us-ascii?Q?99U0rRGxw+YDSvYZuzXKwM9xcGKsis9KHcA9759ftP2+uEea0rCd6tG96ERP?=
 =?us-ascii?Q?/bHDOVITxQiFn2GifFK8+rOWcuOKc0lNHpQXA8EIVlLwKVH8LznqFlRwmV4Z?=
 =?us-ascii?Q?24TuRDiwVw/k1Gfdx3rZH/9TNS/t8P98rh+XKSuFoPWz7XP/gVyqqQY71LBT?=
 =?us-ascii?Q?S/eR9egZdmscB0bPuBLWC2WIlWFADvF0xEveL3JW4DJOEy4qQT7TP/dNESEl?=
 =?us-ascii?Q?3HUStnYROzUE9g8sX+y+Cmfjywac7wKsctjFrlp9P85Ii+URSsniYZ72X3Dq?=
 =?us-ascii?Q?yBgHbCdONgt/WtZubvqmWIHvTBGfUUIGQcLPuKcZXW7+9FrZVyPg592i1nNH?=
 =?us-ascii?Q?XGKyb0k6mHKYa7cgqSVaS/Pwkr9cSgOHBaKCVgsEUOEyQXiEZ6neodh9EULd?=
 =?us-ascii?Q?PbBB/t2PesUuVZLPglltEAeXdkRfWOO2YcJSWdq+p8aXjcbz5ek6mZ7FNOCI?=
 =?us-ascii?Q?5CD9InXdxP1xhm+0iR9+tGa+W+L77M7fIZ8GIjhi?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN1PR18MB2126.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f6baa9-b1d9-4bf5-4e8f-08dc539e0aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 05:22:22.9061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47DZsTglweNXCqVAOJS0lAr/bwaG/fwJo+Pe+5AvfKB1A6RMnK8BrESq2PC2wUPS066fdfGt1eJVRsMnxO/5EfPKnAmQcJEnQm6cCkkU01Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3447
X-Proofpoint-GUID: JnKgLSNZpmmzp9_uAos9OAoyOXR3pGr8
X-Proofpoint-ORIG-GUID: JnKgLSNZpmmzp9_uAos9OAoyOXR3pGr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_04,2024-04-01_01,2023-05-22_02

Hi Andrew,

Please find the responses inline.

Thanks,
Gowthami

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, March 27, 2024 6:41 PM
> To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Cc: will@kernel.org; mark.rutland@arm.com; linux-arm-kernel@lists.infrade=
ad.org; linux-
> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geo=
rge Cherian
> <gcherian@marvell.com>; Linu Cherian <lcherian@marvell.com>
> Subject: [EXTERNAL] Re: [RESEND PATCH v3] perf/marvell: Marvell PEM perfo=
rmance monitor support
>=20
> On Wed, Mar 27, 2024 at 12:51:17PM +0530, Gowthami Thiagarajan wrote:
> > PCI Express Interface PMU includes various performance counters
> > to monitor the data that is transmitted over the PCIe link. The
> > counters track various inbound and outbound transactions which
> > includes separate counters for posted/non-posted/completion TLPs.
> > Also, inbound and outbound memory read requests along with their
> > latencies can also be monitored. Address Translation Services(ATS)event=
s
> > such as ATS Translation, ATS Page Request, ATS Invalidation along with
> > their corresponding latencies are also supported.
> >
> > The performance counters are 64 bits wide.
> >
> > For instance,
> > perf stat -e ib_tlp_pr <workload>
> > tracks the inbound posted TLPs for the workload.
> >
> > Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> > ---
> > v2->v3 changes:
> > - Dropped device tree support as the acpi table based probing is used.
>=20
> So people using DT cannot use this driver? Can they use the PCIe
> interface?
>=20
> There does not appear to be any ACPI binding, it is not reading any
> properties from ACPI tables etc. So the DT binding should be
> trivial...

The ACPI bindings are present in the driver. Have the ACPI ID MRVL000E tied=
 here
and the resources are fetched from the ACPI table.

static const struct acpi_device_id pem_pmu_acpi_match[] =3D {
	{"MRVL000E", 0},
	{},
};
MODULE_DEVICE_TABLE(acpi, pem_pmu_acpi_match);

base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);

>=20
> > index 000000000000..d4175483b982
> > --- /dev/null
> > +++ b/drivers/perf/marvell_pem_pmu.c
> > @@ -0,0 +1,428 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Marvell PEM(PCIe RC) Performance Monitor Driver
> > + *
> > + * Copyright (C) 2024 Marvell.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
>=20
> Why do you need these header files? I don't see any calls to of_
> functions.
>=20
 These header files are not needed. I will remove them in the next version.

> > +static int pem_perf_probe(struct platform_device *pdev)
> > +{
> > +	struct pem_pmu *pem_pmu;
> > +	struct resource *res;
> > +	void __iomem *base;
> > +	char *name;
> > +	int ret;
> > +
> > +	pem_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*pem_pmu), GFP_KERNEL);
> > +	if (!pem_pmu)
> > +		return -ENOMEM;
> > +
> > +	pem_pmu->dev =3D &pdev->dev;
> > +	platform_set_drvdata(pdev, pem_pmu);
> > +
> > +	base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	pem_pmu->base =3D base;
> > +
> > +	pem_pmu->pmu =3D (struct pmu) {
> > +		.module	      =3D THIS_MODULE,
> > +		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
> > +		.task_ctx_nr =3D perf_invalid_context,
> > +		.attr_groups =3D pem_perf_attr_groups,
> > +		.event_init  =3D pem_perf_event_init,
> > +		.add	     =3D pem_perf_event_add,
> > +		.del	     =3D pem_perf_event_del,
> > +		.start	     =3D pem_perf_event_start,
> > +		.stop	     =3D pem_perf_event_stop,
> > +		.read	     =3D pem_perf_event_update,
> > +	};
> > +
> > +	/* Choose this cpu to collect perf data */
> > +	pem_pmu->cpu =3D raw_smp_processor_id();
> > +
> > +	name =3D devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%=
llx",
> > +			      res->start);
> > +	if (!name)
> > +		return -ENOMEM;
> > +
> > +	cpuhp_state_add_instance_nocalls
> > +			(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
> > +			 &pem_pmu->node);
> > +
> > +	ret =3D perf_pmu_register(&pem_pmu->pmu, name, -1);
> > +	if (ret)
> > +		goto error;
> > +
> > +	pr_info("Marvell PEM(PCIe RC) PMU Driver for pem@%llx\n", res->start)=
;
>=20
> Please don't spam the kernel log like this.

Will get this message removed.
>=20
>        Andrew

