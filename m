Return-Path: <linux-kernel+bounces-142044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9824F8A26AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7341C239E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE846426;
	Fri, 12 Apr 2024 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="BpYCc61r"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711345BF0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903661; cv=fail; b=ZXOFwKZCA1S0tDlPRXgoNyGNtN0/sbHnXgQHOfV0WK2cPGwUg3rIwkSGHl8SuYcedoKKerL21pK8aY00t+c+saeso+jq8n1y1cLvIm4+zL0FV1lzkrcd1Z06Y2IEUSNG3p6LnWcsd1JhDgPZNDBGQKIHAZLWi4DIz6ZdOcy9UPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903661; c=relaxed/simple;
	bh=Ba4lwzGuOYe8KKKsv+5GjNHhI2y3NEw5p6QsFXEDo5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NEME4buZwWSQRI32uz2/XqsggEXaUasvqLSNLwh/s74xP+Ycz9fsXKyjQrvgA+Tk4jcjsbhAl6Qyv+6xZ9LzbRJXYyndn6TtM8y59wrjEWGy9ab6KR5oD6fOomusBc97lEQ83MOVAT8XOFskok2k7oJXVZf+9Qr2oSeqxsjUHSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=BpYCc61r; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4AFxI009090;
	Thu, 11 Apr 2024 23:34:16 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xewph0bnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChI53I0viZTdrX7DVRbU6KApEEYItQo0oA2uR55Qichpn+RLUddUfQukgmJBpuPfRvBIrH3chD0VlJ+8p6Ykf5mTPL3KXi6au6KJo81tSfq6MQHop904ec11EmtCtiSrR966YQ5I/HaqC7n0iMtJxOMeZMmx+q4kZeMQTwhHf4MlYreD1ttOsucdfwZwBjJm6MOemKX/r+tkspeldgDhxXvzYCjmOQ1GHPx/iLu7bvJVp0rdZddrIfKgBaIWSTsTfM8SAhls7AuSQa7FBaPWhKZeAJpq+5ZwkhUHpn6LqumW0g0SBASC0gOht/rhFNr3CFjhFwSHuzn+6FlOSkma3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oodyLpG3FxIS+tA72+/LunHSwctqj/9m6OnW40QShzg=;
 b=la3FnUHCe2soug7EJCPjeV4iKksCpvAUobZoNQB0U6zhDgOqjy1qHJJ9RTaGSIHJQ0zs2jdIr9L3j72jMtqFj0ScYkNyIQxfu5aQSbwuZDmVZnBDcibcD7NtzBqvknLb0LRrSKwlkA/GTzQwqkSXt4uvlMwZbEgXfLTEhTWhaT5OmKmAKGZqp8u+/rsUut6Rd9d9oP6tMLq2HARs7jEooaV5wy1wdus4Wpz6tO5OBuDrC6G2iI/D3YyEKkEM9zX230bfR+0LcRjDSZviSw461gz6CDGCjodsUCSlRw33evLIqcxRud0tidxdFLtenof0sM78gg8oAu4JSdg5qcFOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oodyLpG3FxIS+tA72+/LunHSwctqj/9m6OnW40QShzg=;
 b=BpYCc61rQJKtp7ibv5+4mmCa2raTtztgrk76iTHax/XbqUmhFQRTI9O/b8rltuU5bQxEbpgSIGKfykCMz++xxySbRm+c9+HZI/LuH4JgVrZ2zdyMK/zwfLbum8+rIuX4GBGwOOG9MIFRuh5GBb9LYLgP6xcVI90nQdew38tm/Hg=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by IA1PR18MB5447.namprd18.prod.outlook.com (2603:10b6:208:455::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 06:34:10 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 06:34:10 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHadGwMkJgd71lr6EOhyDALmTU76rFjOCSAgAEjI/A=
Date: Fri, 12 Apr 2024 06:34:10 +0000
Message-ID: 
 <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244191AE625EE04141DAE2BA6272@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240312105657.1589333-1-vattunuru@marvell.com>
 <2024041152-symphony-strained-8370@gregkh>
In-Reply-To: <2024041152-symphony-strained-8370@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|IA1PR18MB5447:EE_
x-ms-office365-filtering-correlation-id: 7b48b021-a48f-485f-0367-08dc5aba8fb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 51Y7lP1rzLzo/GMy8w2KObrxPZqmWE4TWOxi1vuOWua843USAADWWnv6tyDTYA097NHXJy2nOstF8zJSbKp0E+7QAXldV4iP5yE8B8ZTtdbnxP/1QcAlFRwOb+PMVlhqbqK+DG60t4Zkzkm9QU0JeJsU3kdz+rDNNwn4e/57bOrHZGxaKH6TAxo/OAs1siSHAyojs12i4wEN3Fqddys9H+LcW7Ed7j8ZEHNener87CnjftL7Fw2XApIGGF7njoW3JtiyYSLNdXHY7ZE7d/F4O5cO+Pxf50TEZXxIJZUF0bc5jpNZ//Sb69mOr7Ty/uo9XvQmanvnblm2X3wYjal4JeWVKgzazOSWd7ITW9G5ELtN+YNjwjSpvjhr7pynfE/2g8lJ7yShwD90rfPSA6LLwZ/9v78FIjy7G7xoGE0D200D4UK8VHU37ESCsvDRyiT1fCKL/Rn1JZ+O/ouDqqq8cU0fDIFDGG/r4lykMfKg++eWbpVDrjVow0HVH28QD7XiKzzP1xlHyWimm7rUC3Q10N+mjEtBfsj+6PGkzLh1n3I1bCiDe+pdo3fAV6HqUkgOROxdAvwqSNVz7RwAmVlGqd4vCgPn3UrNFUs66jyDAyA8O8HkXBf/6yzFQF6R1qshVKo1s+NfwJZ54ePWiTvrgkK8/0ObCL+be8fs0nKdy86sV0J/WaY2+2+FTL0mG+zAVh10/KSxXqWXkdGQU5cfu9qIux4qn3Yz7w23LexyW/A=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3UAwvx4SmPWZeyiTA4Az5/BO7jr1KReHOu2BxIoUE5OyGoPhOZr3Qn5KcG47?=
 =?us-ascii?Q?ekAbQi9cyBD7Xg0WV8YIafddWuyuBQ6S39wbTxj8lbwOqFoTTfzKqlhoFcDH?=
 =?us-ascii?Q?D+K+fcTYCAW/Pvj2YcZf49M0CWMYQzFfO8ECm9mBXk7yTVerwDVsNxBlnuUZ?=
 =?us-ascii?Q?oalDX6xf7LJhjXSubAVGf9xA2VkLTOf7oBfuX+WlUa6uDOYRHL4JMY7RFqnn?=
 =?us-ascii?Q?4Rsz7RK328P9Nr3k/yAyBL1Vj+O42dMf/cDsiaVmoYsDbB0PKXSgvLok7q9w?=
 =?us-ascii?Q?1WTYG2Eykrccx6+3+CtCffbnE3o3PURKLMJRBUCTCFvM9BB6d9uo+8n7c4ex?=
 =?us-ascii?Q?O46/smuMNTESfPl2ziL0rnoiJ58cRPynRpD4FHVlrFZahKPSm1J6ia2XPTLZ?=
 =?us-ascii?Q?OkouXYKVGSmX/Xnjwyk13rFdAdQFDvOOc1jld9X01z66+p8yg++KPgRzwcgC?=
 =?us-ascii?Q?HIGS5h1tYTU812HN7MuZux30mCvtjgCHmrEn3csgELWdptIwLD4Z8UElu6j5?=
 =?us-ascii?Q?R/OId4blZV1ivAxhmSZYsSbqaw0sAGiXA3/Q/O9vyLJvw2jrKCEb8588dl9g?=
 =?us-ascii?Q?0OQ+hqxblS6NTDmqPyd+ZhTlXN/7uB7RCTplud9yChoMmNhpE+PGKSRkaJU3?=
 =?us-ascii?Q?9d4lTSUJcwzNEKHBUsr2p1Kwp9S6wmy33kuC5WInfDjVej6cKGOvPBQ+JoOj?=
 =?us-ascii?Q?0SWMbNLtZOoc6QhxJHDCRJlG+TqUTLWUHZrGsuLTuIl3ASh9t1Ka+5Gnw8jG?=
 =?us-ascii?Q?A4eIjhGHRqa4NYCb4mALVojHlDSplYUZ49iBYKTmEDz2De5mFf1+q+oYJWtf?=
 =?us-ascii?Q?3VR6pXFO8uQfLd754va/1dk1LFW80f88YD+ikTMzODYxzHNJ1BmfN+6G8kbj?=
 =?us-ascii?Q?M5ke+O1ISKLuodyCWeIR0OYUuFMIG88wUb99YlQ+5IVUy11w+MXevckJ8H4G?=
 =?us-ascii?Q?gB7GTXlv+G1UrOMmEsT3f2ADD4wKwvZVnKV1EQCEIa8oUK3UuzdaH0VzCjbY?=
 =?us-ascii?Q?etXZWnxCMLQr9f6cZKNUd51JXp9CjyReSJuiShvlUCJcfuq7EoeBSGlXTeuB?=
 =?us-ascii?Q?mnPrYxobCNt0g0gJasdSXGLK7cp9sS3VwvaMJhVQfLR2HdsbY8KxHkfc1o44?=
 =?us-ascii?Q?aGbn7rXD+FQcBg0+lG7g1oNvzLzuFYI0i+Li95bBsJ7r036SMcpndUfQuXCx?=
 =?us-ascii?Q?bP3OPArdY4SrwnMUJKJm7DbFBKmltsvrwVGe0TO7gt1IG+LMDf82jEJ6870G?=
 =?us-ascii?Q?CyDA0fBU9R7Qv4h7B+/OE+KiAtDAdQODTgqjdHkZ6A1QttzcqoacQqhL8UxP?=
 =?us-ascii?Q?EHfMfoi1qY8Fmo+/WoHjT+FDt4I3/KGmWYYyyQwMw+T7iGoZwkIYxw8mjsN1?=
 =?us-ascii?Q?LkkMvPM3FVjDG3mz7tYLU3rP/B/bo5WHP4kcKuvrRaUNqotgV2jqHQTropLk?=
 =?us-ascii?Q?zKmt5nAiV2xAh8ZzB2/4DtDIHtJYMhyCGQTUwZA5fkuTDexGssiJ7zhMEFv2?=
 =?us-ascii?Q?nAN+Uk4ndT7lwF2KOzPtFemGThTpDj9X12EydFlVoVW/oqjWvBnc7fjQ3wnP?=
 =?us-ascii?Q?188TDilTRAKeOqRtrYt0sN/ZyT+bmFMe0UwA07xm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b48b021-a48f-485f-0367-08dc5aba8fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 06:34:10.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7HOPCZymkQvuaGM6ok8+sf3iYibNqcndOt3wsAoxUGZ1hO1Aia7AVab74z8nb/AVKM0UJ/iyTaHBlX3priCPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5447
X-Proofpoint-GUID: FY9jAZVSvgt9TLI6P32WtbXn_x5aTQmr
X-Proofpoint-ORIG-GUID: FY9jAZVSvgt9TLI6P32WtbXn_x5aTQmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_03,2024-04-09_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, April 11, 2024 6:32 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v4 1/1] misc: mrvl-cn10k-dpi: add Octeon
> CN10K DPI administrative driver
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Tue, Mar 12, 2024 at 03:56:57AM -0700, Vamsi Attunuru wrote:
> > --- /dev/null
> > +++ b/include/uapi/misc/mrvl_cn10k_dpi.h
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: GPL-2.0
>=20
> Wrong license for a uapi file, right?  Please work with your lawyers to f=
igure
> out the correct one if you have any questions.
>=20

No concerns in using general licensing for uapi file, will fix in next vers=
ion.

> > +/* Marvell Octeon CN10K DPI driver
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
> > +	u64 mrrs; /* Max read request size */
> > +	u64 mps;  /* Max packet size */
> > +	u64 port; /* Ebus port */
> > +};
> > +
> > +struct dpi_engine_cfg {
> > +	u64 fifo_mask; /* FIFO size mask in KBytes */
> > +	u64 molr[DPI_MAX_ENGINES];
> > +	u64 update_molr; /* '1' to update engine MOLR */
>=20
> This is not how you create an ioctl, please read the kernel documentation=
 for
> how to do it properly please.  (hint, wrong data
> types.)
Sure, will send next version with the fixes( u64 --> __u64). Thanks.

>=20
> Also, a pointer to the userspace code that is going to use this new api y=
ou are
> creating would be apprecaited.
>=20
> thanks,
>=20
> greg k-h

