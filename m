Return-Path: <linux-kernel+bounces-167282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277CA8BA6FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF201F220E4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363B213A414;
	Fri,  3 May 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="n/cyHSrc"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6413A27D;
	Fri,  3 May 2024 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717694; cv=fail; b=hgynz7EWssxV3aY0aY744y7UeOvJHDIhM8uJS+tmpBkoARXjYVfw64gIhCfJFr/hKjPNnUKJyUkPy680B5nr3qmoje+YOtLjBmpcKFJX61U1ie0zSylfiTNBH+8d3YOM+5uY6ngdp6c0e0a7Bkpqd4SZ0sqFtLdYhN88ucG/rEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717694; c=relaxed/simple;
	bh=uHHI/Co9VSu7AHyfntVKWHTviJgAUXNLqwcQhUgYvkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+oXrG7jEuRDUTY1y+RQsuavMki7s9ZTEulGtoNMhOhbL+zJhZLaCdBD5zB7Y9LVOCLasZEHcMaFrrLcIccm1CwcFftv7GHlYBoERdPr5SdHKKxqRLfHl53/LnD8GcYGWugfQe4z2U8jsNrQQQUZEDCPcEK/FQlH3Nb+I2CPiAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=n/cyHSrc; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4432aN5C000848;
	Thu, 2 May 2024 23:27:53 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xvgsej17k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 23:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj8KK7k4W4lF8AABR5NhzhObkLnxsqtfGnH8B3FIUxE60Kxf0k51tNxRb4gRMHor8FmLPC9n5JwcjUeatABX5NmNf9aPwEJldUBLZfijwAHTexor/OcGazAtWMmkDjqb5a8BccwdMIq7f1juO7h3eLdiMdR/d8c5rW+du+V+AHlBESVx/Mr4kZS93ab/YyOrJZncAKTzvQnEMtiT2PtAIwZjz03Q7N0PRP3mR/ytSUqFjXYrawN9u11cFDSE+AGIeW6Hz+Qo1SkwuWDOjrsWz2q0q70J0V4F7etrLhDuO4bU3VGXjM1s1qcU76jmym+5EjNI8MDEVcYztPYDhrqkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuStAyg4g9ZSBDRujsS8Q4etabe0bHbRNcYKgac6QLM=;
 b=f1Xv5pBUyZQzMCVHzue8t+B6OQ1opZoMjuOcDWbXl4v+CVTfKjbnUUyRIinGZncKPBL/jS6DCo4NmSXA+RLIYqJu966qsyrDq0BF8COynHnaWRgfZMPbdbH/xQmtgi30c7haeejdASMM9Ic4Lf4cdkSqs9YeDJHvZBYIz57C/zJ/Ue2J5NvhORjXTTqZvPSMzh6jm9V92w6acrrKADVFtkM6soiEcyW95GOxiLO+mux6sVKonYBy2cCyNTVxM00JQrm7yrZm9L9u5PIzQd2ZqaYRyrnivT2lOtNLFMJTFcbLNKXF8Z8llv+rpRzlSbDc9zEPonzzpEMarOaaNg078g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuStAyg4g9ZSBDRujsS8Q4etabe0bHbRNcYKgac6QLM=;
 b=n/cyHSrcfuJDsH0Yv0yXImq/Ed+59iAUFY9awefeyQWEH/i/IvT/BSU3XP/BLQEtWdZZ4q8EfQe5AKUOBGF5aFZqia8kgKGUrj6ZALaswLP3DamdU8nvDelgJ1MvfCfapui5f05T0e7DSo8tJzDG2D7CWziVT5iNPA6O0tCyxBw=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by DM4PR18MB5025.namprd18.prod.outlook.com (2603:10b6:8:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.40; Fri, 3 May
 2024 06:27:48 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 06:27:48 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
 representor netdev
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
 representor netdev
Thread-Index: AQHamVpOk4r/tpYYKkK9e3oUMm7yXbGCsf8AgAJhACA=
Date: Fri, 3 May 2024 06:27:48 +0000
Message-ID: 
 <CH0PR18MB43399144F70EE124F891AA34CD1F2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com>
 <20240501180656.GX2575892@kernel.org>
In-Reply-To: <20240501180656.GX2575892@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|DM4PR18MB5025:EE_
x-ms-office365-filtering-correlation-id: 294c8844-42c7-448e-5375-08dc6b3a26e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?xGWtck8RewzSau2U49d8GbCyGXf/3dsZKcNDQzYn4+PXS+hwkyKZGVnhbJEu?=
 =?us-ascii?Q?LK3M7DJurrZ5ynyrW4jLNQn4ZIk8nxb80jGUY1qD8BtEXfYUucjNQpk+RbPS?=
 =?us-ascii?Q?nYf9HomYDO4/A00kh6s0l6pB6CGvVy+5a+0sUbCFoPFFTT5cvx53EQoxNphP?=
 =?us-ascii?Q?/yVmUd9NGSOJM+piYvV6/Fw+dR4JjPEzNnHPqH2GrcXpWHmQfHHuQjqidRVB?=
 =?us-ascii?Q?xgiUtBhqYNjJBZWqbSMKM4Mf0iKjCZqS9zLowHtR48mMAq5skzDegXuGna00?=
 =?us-ascii?Q?9IEZwWCMWsMykE/byUJNi9nshe/EPwhtNX29jBgth0CQiIepgfSuRuYAU3hS?=
 =?us-ascii?Q?XqdNisI7o3UMRUMP5OhZAbH8h0PSkzTOuBvV0OfOFEsRNdRgVnxcZtRIAogD?=
 =?us-ascii?Q?ow//OEJ/m7wZBYkkXYZRf0rpHf3W88Tj4Ug9PMKtC5oFkBkIzZ1Hb6lb5huj?=
 =?us-ascii?Q?sViyKSbnDVlcUycSIzU8faBgZVShIhwELZILotV3/D4N0+pTiNFjOBCChR/n?=
 =?us-ascii?Q?n9HigSXTMY/U9/cb91hyahd+85i9ty92uAXinvfFcaSJ4UFLD5tZhCUaV0jn?=
 =?us-ascii?Q?b06Z9ucHO4WNzWzeaG31sVYNpmCMKX/zSTKf6sxOxxQzQEndCfnZUnxgQoU2?=
 =?us-ascii?Q?XYU4CZRjPPw9SPS16ZlkqhN2ji07kd6kBhVcRN+TgxeQLZ9rcMH2ppoJrc2u?=
 =?us-ascii?Q?yMRe/8bH3kYSf6SXr+Hxi7nxc0nUux2cC7PSQQumvWJdqS1k9TsLuDcp3cGo?=
 =?us-ascii?Q?B1cuO0Xya5nI9ZsI2skBF6W6Id94JNelGg+vYrlLlT6n30HLbZZUhsK3nz9K?=
 =?us-ascii?Q?iMUTrvQTnNzoURcwbX9VEauhU476PtLlkP8Pe1aCzq7YMpVzsrI4Y908M5u8?=
 =?us-ascii?Q?s1fjlBcHbHEO4gp2pHvgv63iLHwKQyvwR2IpyK86RBAyOSx4BSNbbFE4kYcp?=
 =?us-ascii?Q?X53hvikM8N68bl6NjTyibwIj5IkqpDdvJ8hxaocOKsXcDRzup1zgqqFuAlug?=
 =?us-ascii?Q?zV06Hux8STpSBKs08f3T+7coUzqS9YZQ/JUg1/lTyGLHZuvx1Vy4aap2f8as?=
 =?us-ascii?Q?ekJZHqlutTUKb11rKnQXOZxpxcpKrhZWSo9VeP3UquWFkfqf7XbTed3RKK4r?=
 =?us-ascii?Q?Ud+lVXiJVBy2lOaVSE0uvTD90V1mf3fAXnK5JWDwATmXvkmAMRfNtVeS569B?=
 =?us-ascii?Q?xZldiJdqcMIHg58ltGkU6LgP/s0XYpDRkTrNQfhRXXXJKpDj0HJjKA3/AXzJ?=
 =?us-ascii?Q?ZsGjYGXXeKV7XO0SR/G6sMY1h8CX5KwYHpRrNHLML7INg1inNEbvmBWcdRrO?=
 =?us-ascii?Q?4so+VbHiwn/ANZcEM6ctbtg/hi+bOkcvJ3joY/6JZU9c/A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vCzrdfQD1NbmrHEsln9FEqvlZpXCdwV5wBhNUV3ZHPRne0bXihaczMv9ARX8?=
 =?us-ascii?Q?jXReFz3tUC7S6zZx+gJROfebEjBqzL8gfNkogSudLG2X4pS3z/Mtjxs6R/wW?=
 =?us-ascii?Q?7EQwXt4SL5Q/d4CqH7LuNuIahcuTW8Xh0kMPpCXZEJqgzZDql9cJgGhrfUhb?=
 =?us-ascii?Q?53UZZK5SG/AWJ4uUtF7t9RK4L0wFdB0LyEV7RfR9/nJs+Jkj2LXo9duwRV2E?=
 =?us-ascii?Q?TunQTJAIFGf0O9ukpADWtvfSlQKDj39caZBh+leeAl8V7wGhcWl97uB69D5u?=
 =?us-ascii?Q?w6sgbkWYKLRldfMeRtBSuQe4XPEzaXvuzzDDqpe1fp/R0rDuNpqz6T0ZU4+I?=
 =?us-ascii?Q?SRGwrjn576uePi3EiqoSJfKuTJbg5LsN1mzr8H76g/p/B4O9Z6W6uJQIb3+6?=
 =?us-ascii?Q?Oac6GxLYtYTm9L2trku7sFDC7+6/LM17lxxmjWwuhyj8LUHA7np4BFmt04M4?=
 =?us-ascii?Q?d2Ajwu7jKeqbOvjdG20b45wNhsitaUs+zP4Ddvpp3HLwavJzfVc7iNKPm7y3?=
 =?us-ascii?Q?ZmtJ0lQLx8WQ6mqbpreVbqzhn3J/0m8zLohPauM/gGEdb9jXumCPJeSI8BLg?=
 =?us-ascii?Q?iq283Rdq8C80G7g/XrxGqDK+NVUgB7p1aPJbwfkYPCV5r5hEnsa/meNN5jXL?=
 =?us-ascii?Q?Esz3XL6UQfJAyAaCtWIdCvwIm1XyRFLdEaEIXwItLgXLnP835qj95S6LN5ZI?=
 =?us-ascii?Q?AJ/Zo+PCCmeBCvyzBcFXYkabo2uL/DHHDu8LAeac7iyT7S+MsoE9TUJFKq2N?=
 =?us-ascii?Q?KPaPx2XV1JEoOAL7qsXrxnhZvz0gkS/cZgmWi6ZjwHtZ9z90AA7+CFSNcVaJ?=
 =?us-ascii?Q?c+cfhOmDpMpIz+3m5me7d02geV9y0FKvEyGxfLLDpiuzkzK2MVC+J5iZW+dt?=
 =?us-ascii?Q?marlrOvlB9qUmvArK524DHrAxEBoqcXGQ3WxtSaAYB1DYdy/xj52VVRiPSpS?=
 =?us-ascii?Q?pMzsODuIRO1l+O4I/uv7OCZoGbTX7YF6MpLwlMIYDmWaiXZ+QgPWj8Es08Zp?=
 =?us-ascii?Q?rLzFp+pQg/wLs4xFPI1Ph/CorfUOgc5VSlP+hKBv/Y4/ZHNBA8uYdZJrLfn4?=
 =?us-ascii?Q?eJNKmTpwViBj18DRXA2V/QKZrL03HPlz+ak0onbAnVENH7cEAnXg3jvXIjmb?=
 =?us-ascii?Q?WqPILMRXPiVWWFuz5L4fN3sJk7vG8TWibmgAJr03p33YpRhpZ8gs1ViB2NDS?=
 =?us-ascii?Q?ZSIfyJAg3gH5Hzi0UfFMzacHHVxfeYmRnsHaoQ5Oxwz8IIAEARrAfnfI9gYV?=
 =?us-ascii?Q?mYeeAhduT8ECWl76EUS//nxmsiLOATXrhO10J9FpC6HgwgIZp2QGt1XhAVXS?=
 =?us-ascii?Q?dNdz0+Jwy+ZEBY20SJ5O/+vJVLAFyOT1UkqIlaYl20FmxxchYirqWERP5Uzl?=
 =?us-ascii?Q?w9G7g0drUylkWpj8YB52T9DjAtJ6FzXZ7XMHE5EpWs2X55pu58GeRUlWea5X?=
 =?us-ascii?Q?rtWDjtEYQT7/t9/VdpPv4nphb6RAkZdDKsKBHcAuPJSdgMY0szisBiQ8hAmd?=
 =?us-ascii?Q?Wby5G58hkipgeSqBRkr8lkTYM6da9sjOLhxiFZhPHGj93iT0tjnqgeBnRgN2?=
 =?us-ascii?Q?F4a5AhD+t4qWt6jQH4s=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294c8844-42c7-448e-5375-08dc6b3a26e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 06:27:48.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnCBj+vSYdpa5eH48Q7Y6bCjtzN7m/Cu4/grRVJqQLw5OU5p3DdMnlJjEaCeAGPC58FTttGKJZbvu79o4BQJqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5025
X-Proofpoint-GUID: 5iYlxl8ll2iZFfdQrO_EosAZz70wmjaM
X-Proofpoint-ORIG-GUID: 5iYlxl8ll2iZFfdQrO_EosAZz70wmjaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_03,2024-05-03_01,2023-05-22_02



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Wednesday, May 1, 2024 11:37 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Dan
> Carpenter <dan.carpenter@linaro.org>
> Subject: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
> representor netdev
>=20
> ----------------------------------------------------------------------
> + Dan Carpenter
>=20
> On Sun, Apr 28, 2024 at 04:23:06PM +0530, Geetha sowjanya wrote:
> > Adds initial devlink support to set/get the switchdev mode.
> > Representor netdevs are created for each rvu devices when the switch
> > mode is set to 'switchdev'. These netdevs are be used to control and
> > configure VFs.
> >
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>=20
> Hi Geetha,
>=20
> Some minor feedback from my side.
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>=20
> ...
>=20
> > +int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack
> > +*extack) {
> > +	int rep_cnt =3D priv->rep_cnt;
> > +	struct net_device *ndev;
> > +	struct rep_dev *rep;
> > +	int rep_id, err;
> > +	u16 pcifunc;
> > +
> > +	priv->reps =3D devm_kcalloc(priv->dev, rep_cnt, sizeof(struct
> > +rep_dev), GFP_KERNEL);
>=20
> It looks like the size argument should be sizeof(struct rep_dev *) or
> sizeof(*priv->reps).
>=20
> Flagged by Coccinelle.
>=20
> Please consider limiting lines in Networking code to 80 columns wide wher=
e it
> can be achieved without too much bother.
Ack. Will fix it in next version.
>=20
> > +	if (!priv->reps)
> > +		return -ENOMEM;
> > +
> > +	for (rep_id =3D 0; rep_id < rep_cnt; rep_id++) {
> > +		ndev =3D alloc_etherdev(sizeof(*rep));
> > +		if (!ndev) {
> > +			NL_SET_ERR_MSG_FMT_MOD(extack, "PFVF
> representor:%d creation failed\n",
> > +					       rep_id);
> > +			err =3D -ENOMEM;
> > +			goto exit;
> > +		}
> > +
> > +		rep =3D netdev_priv(ndev);
> > +		priv->reps[rep_id] =3D rep;
> > +		rep->mdev =3D priv;
> > +		rep->netdev =3D ndev;
> > +		rep->rep_id =3D rep_id;
> > +
> > +		ndev->min_mtu =3D OTX2_MIN_MTU;
> > +		ndev->max_mtu =3D priv->hw.max_mtu;
> > +		pcifunc =3D priv->rep_pf_map[rep_id];
> > +		rep->pcifunc =3D pcifunc;
> > +
> > +		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
> > +			 rvu_get_pf(pcifunc));
> > +
> > +		eth_hw_addr_random(ndev);
> > +		err =3D register_netdev(ndev);
> > +		if (err) {
> > +			NL_SET_ERR_MSG_MOD(extack, "PFVF reprentator
> registration
> > +failed\n");
>=20
> I don't think the string passed to NL_SET_ERR_MSG_MOD needs a trailing
> '\n'.
> I'm unsure if this also applies to NL_SET_ERR_MSG_FMT_MOD or not.
Ack.
>=20
> Flagged by Coccinelle.
>=20
>=20
> The current ndev appears to be leaked here, as it does not appear to be
> covered by the unwind loop below.
>=20
> I think this can be resolved using:
>=20
> 			free_netdev(ndev);
>=20
> > +			goto exit;
> > +		}
> > +	}
> > +	err =3D rvu_rep_napi_init(priv, extack);
> > +	if (err)
> > +		goto exit;
>=20
> Even with the above fixed, Smatch complains that:
>=20
> .../rep.c:180 rvu_rep_create() warn: 'ndev' from alloc_etherdev_mqs() not
> released on lines: 180.
> .../rep.c:180 rvu_rep_create() warn: 'ndev' from register_netdev() not
> released on lines: 180.
>=20
> Where line 180 is the very last line of the funciton: return err;
>=20
> I think this is triggered by the error handling above.
> However, I also think it is a false positive.
> I've CCed Dan Carpenter as I'd value a second opinion on this one.
>=20
> > +
> > +	return 0;
> > +exit:
> > +	while (--rep_id >=3D 0) {
> > +		rep =3D priv->reps[rep_id];
> > +		unregister_netdev(rep->netdev);
> > +		free_netdev(rep->netdev);
> > +	}
> > +	return err;
> > +}
>=20
> ...

