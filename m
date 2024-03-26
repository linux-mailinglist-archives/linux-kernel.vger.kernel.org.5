Return-Path: <linux-kernel+bounces-119347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC6A88C75F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B947B27591
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCC313CF87;
	Tue, 26 Mar 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="vN+LTLzs"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F913CC68;
	Tue, 26 Mar 2024 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467344; cv=fail; b=TEu0rRKiUEFF6UIbRkB0Shgpj7qPlFybD8wg9IZOdA9pZU8yidDst5IqS8XDZ/8QMpbYx2mLMBvYwGTcaWAz2WO3ZO2KymyvOfjKOzejFf7T0h0ex0qhrt3Jv16pYJuIQ+JLIc+5sPFHsHEnVoWybEoKW/AR9r8ZTRPN2qjNlSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467344; c=relaxed/simple;
	bh=obLbECKuKYx51Td43NPT0bVNLJOv5B9VH3ePmobZZI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mozz+35oo+Fpb5/0PB7/VI6GOUDR90MP7RXlksXSJA7whFP7sMAp3vK+pJa4wPyk6h1xB412B32yU1EVeRkTjTRV2IzB6Ywl4axT2825/i12TvGb3CWId41jzGL7457QUTtdQmQgYRPvPJqt8zXcOdTL1bv56evZhJ2RyjdbzHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=vN+LTLzs; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QCsXKT012773;
	Tue, 26 Mar 2024 14:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=o8HLQd/4kiBd/x627Cj8bLPO8RIOWxWw0tHgNF/mI3I=; b=v
	N+LTLzsXfGi8N7cqlSw4WPK27UPapKiwRTR41ZDXrxYAyusIrtm7ACWibPjxUBb6
	3uC/PuDmj6gw3wb4jXRwG/vAKS/ZWNgkyD7B+/CLHD6B/c5/R5eSZ2IwdvuoZoRo
	+7zFqU2mgcgytfC1cnvRt1iGd9OQcV1IXhCjPOc5mJLW2lz0zakuJEJYJ5n+UxFl
	jRsl4DlJBixo1yEea766PW5whCzfoN7n4NjeX2muRwexrCfjmvgsZJiEhGiBPoma
	6Q7zOAfRjr6o3UYFmrZ8qCIwB0W+9ff+m4eyUrEav9KQX98Aeu5kwwtXMy+CiR3u
	At5Ptkx7HsC7cCrLQBSnA==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3x3nf39hug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:27:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLohjlEFdF7s5rP+tAgy2SFPDUKhVtUSgeLev6xiIKzL0yghIorLZ1twz1Lrp8/QYcgwkYcPTfln8aD1bgd5zLoNERboHFwQShqroBf6XO9HBoSm3ScVea3Iyt2X2yJHUWyCJMTPv7jjM1wylyroUs2DcYZKOE2QeJW3aA041eu5ZDn4S1SHwRbFgqQ+fLJs9SL2kaqGaUE6p2plTiFcivMQf+KM+WHycYQIrGnXlOGvdR2yl6Oie6a1DYtPFJ6LzC4SZ9vhSg4YNwBjrwA6KgDUQarupsyJV59pbN2yQ1U1J9RyYzeYvl+Mnn48+5BDISPsl/Wk183DqUPHqOrOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8HLQd/4kiBd/x627Cj8bLPO8RIOWxWw0tHgNF/mI3I=;
 b=ImjpZcTfweH0I9LCojTKjKShLJtseb3FqV9gWLmzOXMUSfHQAFBu3zH1WF+MZY6ZLEcrOGYlWesjMVF2YG2qS0xg2fEjsKI+ysTqyQ6Rq6P+XJoYAEk1OlFlYJ36CW0o/PEb2lbyf7ipnFADZz2+a1LoCeBqvIdaoAruMe8ZrEmzqrx5MuRLbJHveulhQWyQTNqWaBZki0wRhACr90tmWQFLuXX3gn8LAwJsCfRNywCoF7eLaBAK6MOVYPzn04dUFsqxq6bWqzNqywurBvZlATv5iNk8Sdanb6FpSN5Ay/ZOtXo5qrAQ3Qsq6tqr5a7HD2d0yfDw4WaYLpJYHOAhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB7192.apcprd03.prod.outlook.com (2603:1096:101:d5::9)
 by KL1PR03MB7767.apcprd03.prod.outlook.com (2603:1096:820:e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 14:27:25 +0000
Received: from SEYPR03MB7192.apcprd03.prod.outlook.com
 ([fe80::1498:a87b:1715:b6a7]) by SEYPR03MB7192.apcprd03.prod.outlook.com
 ([fe80::1498:a87b:1715:b6a7%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 14:27:25 +0000
From: David Ober <dober@lenovo.com>
To: Andy Shevchenko <andy@black.fi.intel.com>,
        David Ober
	<dober6023@gmail.com>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net"
	<linux@roeck-us.net>,
        "corbet@lwn.net" <corbet@lwn.net>, Mark Pearson
	<mpearson@lenovo.com>
Subject: RE: [External] Re: [PATCH v4] hwmon:Add EC Chip driver for Lenovo
 ThinkStation motherboards
Thread-Topic: [External] Re: [PATCH v4] hwmon:Add EC Chip driver for Lenovo
 ThinkStation motherboards
Thread-Index: AQHafrAdxMzRGX9SSk+tSlgoSxw247FKFUfg
Date: Tue, 26 Mar 2024 14:27:25 +0000
Message-ID: 
 <SEYPR03MB719281B54C0FA4E36E0DA2EDDA352@SEYPR03MB7192.apcprd03.prod.outlook.com>
References: <20240315115810.15816-1-dober6023@gmail.com>
 <ZgFuLbBe4y1OiRqY@black.fi.intel.com>
In-Reply-To: <ZgFuLbBe4y1OiRqY@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7192:EE_|KL1PR03MB7767:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 VHXnM6q8ef567dnSkGBvOMVWcbcQ2WL0nzRfH1tqyPfKcjOrcum8VRh7rcrlJUj6TVEWBzPicm+LU2H+T7D7Pc3pxb+uVnb/LhCIYnU9KRv9Qpc8D38oeRJsTDzhPRghpT3zrdvYX4qthxciDO894VBpPwbwkWbLomFuNxD7jiTKyv2ciR6E8Kz6OOgo5lfjyOgqAWGpT3AxTJicZQ/VLm5QOh4XoyZOKQv8+EA61J1RpS4GQBB2Wq8N2vLo5mfr3dSsG8AKk9RHoYxJCdDppfq03zU7OqiP1qUVCmL2Vdf6ec0sFeHNVpmvQGnsoVXRDmdFjgBcscJQeWYBtDLQQCd/csBTJnn0KeRS+7cICxDjht5jsloxI56G9UBiOdIkcOSebiSO2b2NAmsoUJ5UA09T71tmniHLJWltviVInaV+Mhf26bfQEwjdwy9eAihVHc5wiykuJJM/T+UypWg6sV/e6hVDbFAzGexLS20iNlgmrWO2NmtansOmBT5Vb0jrquiuy8eQqshzmua3E1NfLhyHSglZGrRnkgWToZHT2+OsT07UqHZWc2b8wScJ2PndHFOxWxZR4OcOnyt36xYbVyJUD7VU59ZRMsajcg6YccT0g1Rg2OtsFpari44FsmKOyBegOZ4qNKC1Yq9ZOEiXksNbaUv78y8I1xTd9GKA9WQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7192.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?a/N/9ofJvNkNCcVKGURoD4FVJDX16gXIYUVM4rUv+e9aG3UZVOHwpKbNhVmf?=
 =?us-ascii?Q?zJXduBWjgSWj0AcEOlCW4RsoFSjdYs6ivS4V0drAkA5/WOAInpIbB9Zz3F56?=
 =?us-ascii?Q?CU4nqy73I98XxktPk7anHetSufZKBjbH9wt2N5tZAX8NqYJx9gegpduVx9y/?=
 =?us-ascii?Q?lC4acO3m165+/VHBZIEsC9n/n2RRnjH2OwWMxaYKTzEAygOXh+2dWa/EWOCd?=
 =?us-ascii?Q?ya6Ai/eNsNsYQzyO0bWwW1aWRvV/gT8tSSEh74mWMtLFIwB51Ge7ir/eFyuS?=
 =?us-ascii?Q?Bfh3zsdreY4DMCwC5djh9IpQ3wdZ0YNvILGbA1XHA7huQ3MTXz6jzoPxG3P2?=
 =?us-ascii?Q?i3sUWenk6esg2A4CO6AzAQRyYo8Cafxd7XRnrJEOj7LCELVxX263bR60dIYS?=
 =?us-ascii?Q?kOZgcXEzBKbPFZIpIU51oVLDffokPAlzggi8bTLWaPosNzu3b8wA630BgdCB?=
 =?us-ascii?Q?Fx2dzl05EpqVaH8oxU9Qd/mCxzQcOw/8+32CPB3iVS6WRiQsEzsSVVRUEav3?=
 =?us-ascii?Q?NAnwjxhgGceAzs1hBp0pxNjQypryJ28fcGFUZr272ikSY6T8YYB/gRDKccWX?=
 =?us-ascii?Q?IBoAaKFEvnzrirp8aifWy5QqoFP1KmfNmfzwUZqnjkGTtwEkqIdFlNHth6JH?=
 =?us-ascii?Q?BJa9Io1ELPo2Od+OXnMUZkKeKY31X5u8XCg7CElOpxa9W96AJAbAoKMDU8CO?=
 =?us-ascii?Q?nC4KssODfuXNjGc5QdtJBsXDuz5lQFqJlyX7Rugl5Cewh9iUgrAROHCZG/iV?=
 =?us-ascii?Q?YT92rvCbRchnf4BRYlbQplDEUzR0D8GnXCHGI01oWkzylL/oLHHwXHTSH5ZE?=
 =?us-ascii?Q?p8e0w82A3glWAu9CKm01MsphMwWEVPdjPAWWpHY2DuefhchBUr/Hb2Kg5/Yb?=
 =?us-ascii?Q?y0X+T1+eDnQWUC1W77rsLZJNjJWDF6+LzxjGWYnFeqrcHEY8XEfPgybrMJRq?=
 =?us-ascii?Q?ftEZFO4P5bPO2teNck0Lg4YrYjFDgI79JJsnSY6SsC/E1sTK+2sDLbFfZqvY?=
 =?us-ascii?Q?IcAequojKnv2alZuoCEvss+/xltMfSSYUQaLSatFGcDSxCNfpodplN4ba4aP?=
 =?us-ascii?Q?eXRVEt5OvzRa5LP6pxsFlqgAueRwVW9nbd2NqfX7U/BhV3iPVKP03x9B+GB6?=
 =?us-ascii?Q?vbqzHdLM8kc37NpILujuttWqtF6cc3U5SWgiZHS24QX3tYjrk8XAm7aSkShI?=
 =?us-ascii?Q?9KaSggqsqIgvskWsg2xBbs4KUQsA8tKCU9a7I2vqXVMRKcYgnGsd1+1CwKlj?=
 =?us-ascii?Q?zMFlxes6tquBIvjY40tX0VY60MF3MY6Gb2kzTh8FCk2EF1+WDP1IClmFGmoX?=
 =?us-ascii?Q?XIIvGePIpe9d4ZTCrS/UdmxS0QjtUBC0RkoQa6eplPQeg03Vh9Ma96lgAhxW?=
 =?us-ascii?Q?W97o01QdytAq0H1i6bsqZHod4NdHs1qT80Leq9hyTSrvY6bF0plO33vaUzxR?=
 =?us-ascii?Q?24KnfIR7YoJOnjq5eM2sXRiUfB0wRkaMnO8Mj0gdfev70WaXfdxEmOzXp5Zn?=
 =?us-ascii?Q?PzKneLTpYCGySoALkGSOrsUxHjNq4UZa/jUlwV5EjzljV0kplynyb+pMADzj?=
 =?us-ascii?Q?PIc897+NZGayHn2fFyNVGjZTNrqhBSIDzuSHOSLtDdjrtlWGN44jj7K2833o?=
 =?us-ascii?Q?zqpomkGmiIoUlIRmaDBpnHc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7192.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00f1f72-a224-47a1-3702-08dc4da0dbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 14:27:25.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5mle4SgeG8mymL2eM9tTcCIQkZlcTIBZfiP6xElkdbxPxK9KVImvfnkDxmrQCdoZi8tTHbHeUu5KXyglHVyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7767
X-Proofpoint-ORIG-GUID: FasVBCVzTIcnvXf0FgN07LMY4c7fcu40
X-Proofpoint-GUID: FasVBCVzTIcnvXf0FgN07LMY4c7fcu40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=801
 clxscore=1011 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=-20 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403260100

Andy

  Sorry about the compile break comma got changed to period when I was addi=
ng in the spaces checkpatch forced me to put in between the values and sinc=
e I was only adding spaces did not think to check compile
 Thanks for the comments I will fix these and resubmit soon.

David

-----Original Message-----
From: Andy Shevchenko <andy@black.fi.intel.com>=20
Sent: Monday, March 25, 2024 8:30 AM
To: David Ober <dober6023@gmail.com>
Cc: linux-hwmon@vger.kernel.org; linux-doc@vger.kernel.org; linux-kernel@vg=
er.kernel.org; jdelvare@suse.com; linux@roeck-us.net; corbet@lwn.net; David=
 Ober <dober@lenovo.com>; Mark Pearson <mpearson@lenovo.com>
Subject: [External] Re: [PATCH v4] hwmon:Add EC Chip driver for Lenovo Thin=
kStation motherboards

On Fri, Mar 15, 2024 at 07:58:10AM -0400, David Ober wrote:
> This addition adds in the ability for the system to scan the EC chip=20
> in the Lenovo ThinkStation systems to get the current fan RPM speeds=20
> the Maximum speed value for each fan also provides the CPU, DIMM other=20
> thermal statuses

Besides the compilation error, see other remarks below.

..

> Signed-off-by: David Ober <dober@lenovo.com>
> Signed-off-by: David Ober <dober6023@gmail.com>

Can you leave only one of these?

> +config SENSORS_LENOVO_EC
> +        tristate "Sensor reader for Lenovo ThinkStations"
> +        depends on X86
> +        help
> +          If you say yes here you get support for LENOVO
> +          EC Sensor data on newer ThinkStation systems
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called lenovo_ec_sensors.

..

> + * Copyright (C) 2023 David Ober (Lenovo) <dober@lenovo.com>

2024?

..


Use IWYU principle (include what you use). See below what I have noticed (m=
ay not be the full list of missing inclusions).

> +#include <linux/acpi.h>
> +#include <linux/delay.h>

+ device.h

> +#include <linux/dmi.h>

+ err.h

> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>

> +#include <linux/kernel.h>

How is this one being used, please?

> +#include <linux/module.h>

+ mutex.h

> +#include <linux/platform_device.h>

+ types.h

> +#include <linux/units.h>

..

> +#define io_write8(a, b)	outb_p(b, a)
> +#define io_read8(a)	inb_p(a)

First of all, these are too generic, second, what's the point? If you wish =
to make useful macros, put a pointer to the private data, for example, from=
 which you can get the address.

..

> +static inline uint8_t

uint8_t...

> +get_ec_reg(unsigned char page, unsigned char index) {
> +	u8 onebyte;

u8... Just in a few closer lines :-(

Can you be consistent with a kernel types?

> +	unsigned short m_index;
> +	unsigned short phy_index =3D page * 256 + index;
> +
> +	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);
> +
> +	m_index =3D phy_index & 0x7FFC;

GENMASK() (you will need bits.h for this)

> +	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, m_index);
> +	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, m_index >> 8);

Can the 16-bit write suffice?

> +	onebyte =3D io_read8(MCHP_EMI0_EC_DATA_BYTE0 + (phy_index & 3));

GENMASK()

> +	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write 0x01 again to clea=
n */
> +	return onebyte;
> +}

..

> +struct ec_sensors_data {
> +	struct mutex mec_mutex; /* lock for sensor data access */
> +	/*int platform_id;*/

Huh?! Please remove, if no use for it.

> +	const char *const *fan_labels;
> +	const char *const *temp_labels;
> +	const int *fan_map;
> +	const int *temp_map;
> +};

..

> +static int
> +lenovo_ec_do_read_fan(struct ec_sensors_data *data, u32 attr, int=20
> +channel, long *val) {
> +	u8 lsb, msb;
> +
> +	channel *=3D 2;
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		mutex_lock(&data->mec_mutex);
> +		lsb =3D get_ec_reg(4, 0x20 + channel);
> +		msb =3D get_ec_reg(4, 0x21 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		*val =3D (msb << 8) + lsb;
> +		return 0;
> +	case hwmon_fan_max:
> +		mutex_lock(&data->mec_mutex);
> +		lsb =3D get_ec_reg(4, 0x40 + channel);
> +		msb =3D get_ec_reg(4, 0x41 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		*val =3D (msb << 8) + lsb;
> +		return 0;
> +	case hwmon_fan_min:
> +	case hwmon_fan_div:
> +	case hwmon_fan_alarm:
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;

Combine with the above and return only once this from the default case.

> +}

..

> +static int
> +lenovo_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types =
type,
> +			    u32 attr, int channel, const char **str) {
> +	struct ec_sensors_data *state =3D dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		*str =3D state->temp_labels[channel];
> +		break;

In the other function you returned directly. Keep the style consistent, ple=
ase.

> +	case hwmon_fan:
> +		*str =3D state->fan_labels[channel];
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}

..

> +static int
> +lenovo_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +		     u32 attr, int channel, long *val) {
> +	struct ec_sensors_data *data =3D dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return lenovo_ec_do_read_temp(data, attr, data->temp_map[channel], val=
);
> +	case hwmon_fan:
> +		return lenovo_ec_do_read_fan(data, attr, data->fan_map[channel], val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}

> +	return 0;

Dead code.

> +}

..

> +static umode_t
> +lenovo_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types typ=
e,
> +			   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		if (attr =3D=3D hwmon_temp_input || attr =3D=3D hwmon_temp_label)
> +			return 0444;
> +		break;
> +	case hwmon_fan:
> +		if (attr =3D=3D hwmon_fan_input || attr =3D=3D hwmon_fan_max || attr =
=3D=3D hwmon_fan_label)
> +			return 0444;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 0;

Same comment about the style.

> +}

..

> +static int lenovo_ec_probe(struct platform_device *pdev) {
> +	struct device *hwdev;
> +	struct ec_sensors_data *ec_data;
> +	const struct hwmon_chip_info *chip_info;
> +	struct device *dev =3D &pdev->dev;
> +	const struct dmi_system_id *dmi_id;
> +	int app_id;
> +
> +	ec_data =3D devm_kzalloc(dev, sizeof(struct ec_sensors_data), GFP_KERNE=
L);
> +	if (!ec_data) {

> +		release_region(IO_REGION_START, IO_REGION_LENGTH);

This is weird. Please, either move request region to the probe, or drop the=
se calls here. Obviously you haven't checked the bind-unbind-bind cycle wit=
h error injection.

> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(dev, ec_data);
> +
> +	chip_info =3D &lenovo_ec_chip_info;
> +
> +	mutex_init(&ec_data->mec_mutex);
> +
> +	mutex_lock(&ec_data->mec_mutex);
> +	app_id =3D io_read8(MCHP_EMI0_APPLICATION_ID);
> +	if (app_id) /* check EMI Application ID Value */
> +		io_write8(MCHP_EMI0_APPLICATION_ID, app_id); /* set EMI Application ID=
 to 0 */
> +	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
> +	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);
> +	mutex_unlock(&ec_data->mec_mutex);
> +
> +	if ((io_read8(MCHP_EMI0_EC_DATA_BYTE0) !=3D 'M') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE1) !=3D 'C') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE2) !=3D 'H') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE3) !=3D 'P')) {
> +		release_region(IO_REGION_START, IO_REGION_LENGTH);
> +		return -ENODEV;
> +	}
> +
> +	dmi_id =3D dmi_first_match(thinkstation_dmi_table);
> +
> +	switch ((long)dmi_id->driver_data) {
> +	case 0:
> +		ec_data->fan_labels =3D px_ec_fan_label;
> +		ec_data->temp_labels =3D lenovo_px_ec_temp_label;
> +		ec_data->fan_map =3D px_fan_map;
> +		ec_data->temp_map =3D px_temp_map;
> +		lenovo_ec_chip_info.info =3D lenovo_ec_hwmon_info_px;
> +		break;
> +	case 1:
> +		ec_data->fan_labels =3D p7_ec_fan_label;
> +		ec_data->temp_labels =3D lenovo_gen_ec_temp_label;
> +		ec_data->fan_map =3D p7_fan_map;
> +		ec_data->temp_map =3D gen_temp_map;
> +		lenovo_ec_chip_info.info =3D lenovo_ec_hwmon_info_p7;
> +		break;
> +	case 2:
> +		ec_data->fan_labels =3D p5_ec_fan_label;
> +		ec_data->temp_labels =3D lenovo_gen_ec_temp_label;
> +		ec_data->fan_map =3D p5_fan_map;
> +		ec_data->temp_map =3D gen_temp_map;
> +		lenovo_ec_chip_info.info =3D lenovo_ec_hwmon_info_p5;
> +		break;
> +	case 3:
> +		ec_data->fan_labels =3D p8_ec_fan_label;
> +		ec_data->temp_labels =3D lenovo_gen_ec_temp_label;
> +		ec_data->fan_map =3D p8_fan_map;
> +		ec_data->temp_map =3D gen_temp_map;
> +		lenovo_ec_chip_info.info =3D lenovo_ec_hwmon_info_p8;
> +		break;
> +	default:
> +		release_region(IO_REGION_START, IO_REGION_LENGTH);
> +		return -ENODEV;
> +	}
> +
> +	hwdev =3D devm_hwmon_device_register_with_info(dev, "lenovo_ec",
> +						     ec_data,
> +						     chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}

..

> +	if (!request_region(IO_REGION_START, IO_REGION_LENGTH, "LNV-WKS")) {
> +		pr_err(":request fail\n");

I haven't noticed pr_fmt(). How can the user distinguish this from somethin=
g similar from another place?

> +		return -EIO;
> +	}

..

> +static void __exit lenovo_ec_exit(void) {
> +	release_region(IO_REGION_START, IO_REGION_LENGTH);
> +	platform_device_unregister(lenovo_ec_sensors_platform_device);
> +	platform_driver_unregister(&lenovo_ec_sensors_platform_driver);
> +}

> +

Unneeded blank line (see also below).

> +module_init(lenovo_ec_init);
> +module_exit(lenovo_ec_exit);

Move each of them closer to the respective callback implementation.

--
With Best Regards,
Andy Shevchenko



