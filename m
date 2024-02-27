Return-Path: <linux-kernel+bounces-83345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A688693E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE191F22384
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293FA1420C8;
	Tue, 27 Feb 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ED2Q5vW9"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA66146009
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041648; cv=fail; b=n7pTXqy94OlK/agHd/vLzaIxw4mNO0xUJ+IjPQQkaChyfKoFd9fVBeR+boB1v/yix2WDL/fI9RW5cwkwF2Es/SFteH2ysgXGHAdkbuleZQyeSO1MnF4AWk8kZDCihAGxvsbv96ep/dBkP/7XcM7JCx/FnNvU8lx75xYQ/tNqdfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041648; c=relaxed/simple;
	bh=T168159i/YEF5z88TKc2EkMgiLXM7zihCsgxcU+jbEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvHcTp9h1X9TRsw4cvqBMoA1sOv7tUPfmrRWfXmMEaREsgTpQia+2VhfGholhr66qwF8yfoqjHGT4c3Dlch27d7UEgH5KBQprmQ79LQiHcKn8VqyltruYiDKmNOPNY7uem8sQ1XrikrPT+k1bwjM+QcgRQJV7miR1qvBLikRNhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=ED2Q5vW9; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBIQQC017917;
	Tue, 27 Feb 2024 05:46:54 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wherd0bx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 05:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeIREBaPe2GIIF1leeqav45vLu5Ir8FP/PSggdeqbriD82bGyJWll9p2HWPPn88iGm/4eWQAkkCwuHuXVm3bUIQulb5lodpnF4YDWzZ7yjOT08GRr8la47ZJv2lLqoiPqDtvRV+2knfPtQwusABhdLmQe7lyYix/QFkFjNGOSXhDavBeR9+wqwcWhPGZNQtFt4BCtoS2CEJSZOtY2MQyPEl+yfuRrYvsTeMJpOdCDt6OdbS8dMxDsaf0FdV3p/iF2E63x8e/fvG69fzRBIWYKVVkl0LHvk66DrU6D8t1NkoJWzTfwxNqX8Mo/qsy+sjXtIf2IsC1l1TEQPFGSR2SGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q03dO3W+VFbmb+4+lNcqWowFnP9YVVidYiT7cwaIGsw=;
 b=gvP6CmWMCuexfM22fW3TMkT6eHgDC0VqsaXziFMjpN2kT8QjUEwcbedDhHYJIyZpqdFenOjOQqDeXiUKpzmXlqX/ZwziHCfRdZ1Kf50hmYnKgrNVBow7XHUPCD2K5oFlj1bwMv72b+eIOdbYglKh9qpE3dELiiQlUKapxHDaalohCIaAThXTohYOjCFoOQJbFsZtZFgCyfjg/ECm/ic1LYtM3YBVqSoSAp6jJoy0+dak+w5Q/712J2Tp26SKy7+Ki2KTXjGCmWs+sRtJZnb626227eGTg16khSy/qzQnHwdVmw9+sglE46PHySR1f8IBfLreGs6oNeCtI4f/WgL02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q03dO3W+VFbmb+4+lNcqWowFnP9YVVidYiT7cwaIGsw=;
 b=ED2Q5vW9uXaN/EJJ6PjZ85WVAZHoZUlVh8D5oiQNd2ebcZlsl/qVhlsPWQB9dYEDKytAnqFFxvflPHkOOnAFQ4QGTlxLiW0Xcx8sQRjdbLjCicfNpKnbpI0WRIxVIt+rJDw6FhzcUZ4hA/E6HrdmTG7CVQpxyFvc34xRC4OmqCQ=
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SA1PR18MB5877.namprd18.prod.outlook.com (2603:10b6:806:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Tue, 27 Feb
 2024 13:46:51 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::f9a7:a7a:e168:e7db]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::f9a7:a7a:e168:e7db%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 13:46:51 +0000
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: RE: [EXT] Re: [PATCH v3 1/2] perf/marvell: Odyssey DDR Performance
 monitor support
Thread-Topic: [EXT] Re: [PATCH v3 1/2] perf/marvell: Odyssey DDR Performance
 monitor support
Thread-Index: AQHaTTF7xHRDxtzu6EGBNA+u92UBJrDwvEQAgC2t9XA=
Date: Tue, 27 Feb 2024 13:46:51 +0000
Message-ID: 
 <SN1PR18MB2126E6148F38D7CA17701956DB592@SN1PR18MB2126.namprd18.prod.outlook.com>
References: <20240122124933.1311925-1-gthiagarajan@marvell.com>
	<20240122124933.1311925-2-gthiagarajan@marvell.com>
 <20240129120436.00000f18@Huawei.com>
In-Reply-To: <20240129120436.00000f18@Huawei.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR18MB2126:EE_|SA1PR18MB5877:EE_
x-ms-office365-filtering-correlation-id: dcdad5bf-861b-4d51-4eda-08dc379a8d3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xIejxLpHJt3Puw5YS13wosc/fncwupyFFVQ1ATGlJlB9F1lQ/+j044Nzpe0Vz6qyoOHpMx6WQPsvr94AdAsTzzvb7MvdxWklJykdbIYBcORgJQwrCnPRQaNtLDK4U6+AVev5FW1PmTL1nGNbanfWiOnZ7uHl5/K0bzCeVUeN3I+cSa5F/XT3qTkUnJnCV6mQsdSY8oEPUHf3E+CT1R7Xd3K/SgpyOzMGIBQNrmkvUoBhssT6opdOP5KQkmqYOR3Ttzae2EBX5WQnf5Q4DFWLbo3CiMftI6KZ6+glsEgM1QhXtjeeOaRexTAMG82FjSBfwefdP8TYoUbrwYAURd1PJetvzt8XvUp+zojzJued531+IejDJektdhYkB0dd/MuAu3eGT9vrqdAbMfX1c1cZbQ2Roz45EZCS7w2syvjk/SPmOlJ5ks4tIqSrnnQfrFJ/VzTdc+QqXg8S7dR9uHLYZkr6AAUfba9f/I6qf2lzWLDKBWKS1Ur+i756pLXbOmr7q9iq289E375feQsxDWoLI4DIWKPKJbgkThrQbelaL88XgaiT0hqrH6UuB7SHpPXVjGge8lXdF9CU//arlB7P1BZyQ1ZKAzPW97R+46+FsRSo+L8s6SxqYEVsO2eQPrzZTmjZ9nUyWyh1h+uyS+qF0wp0+PLQJVhLQ815vhx167sGs3icoM/ClHLSaZw7K4zAJ/5CMRGpCc6wQ9Ed1n8IJ5+ummGj+xX5J3LKKd7jf8Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR18MB2126.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?fx+jUrgYGVGIWhQ5xJ1zgsG0qXUayaDycHxrUYqpjD19rB/hZbVzvz6AZahN?=
 =?us-ascii?Q?V97n7VIEbx4DOhfblSXTF7wn7mCDroMcN8ijKEMoMCsjGw4veQCCyBUSYqux?=
 =?us-ascii?Q?KeaEEh5Z+6yzRqmRzAU2LsZfNoK5xNNCXWMIXvQsI/cDhCuronIL/jEKeemP?=
 =?us-ascii?Q?TpHW7KDq0oTKwoPCzB8JfHWbAXUK7aoY2L+TEiYuoi4b4ETg2DTCz/zl3E0P?=
 =?us-ascii?Q?pEiRrbC3TJJvy++WvasXOwRw1uHVgJ/kN7XkUGHUQb5NhsADt1JpbSWK/Er6?=
 =?us-ascii?Q?+IuAfbO3HwM2OcaRUKLy7gLV54GjQW6mYesMq6bQQrsr7VjzXRmY9Z2+RXFT?=
 =?us-ascii?Q?9qfZLddfP9mFf5s3Or7G5pMj/V3T+x1B2zVjd+BHhGz8V7M8T0Yf3SJHjtld?=
 =?us-ascii?Q?nxO68rUIXWBfq+Il9Y/1W0yTJUShJBV9VlbnJugT+Yj4OL6z+tWTQ/XPbxPo?=
 =?us-ascii?Q?WxwPDDmyh4O5eqFCA1J+oGq9MYycru3wmRYwaLTZN11eVjAh1WoOIa64nEbs?=
 =?us-ascii?Q?3QGclbiEbXmGz1iSuVBkZdFebefBuiIvN2PsD3zHJXM4QMfDQIq5fCWiv0qW?=
 =?us-ascii?Q?5jzr4VfnBSp+0YozbZU1OJynON4PAtoJMwuyiXeQlCLRrwGkrEOhj5/41xL4?=
 =?us-ascii?Q?MN0VwcuWOQqBBqk75PtnNsOvzbpa9Rs9e/fg8C6cjABhgM5HKW9auMoMtJYW?=
 =?us-ascii?Q?dVedHjOChy0yiZAFcjZuT36NtQzuw3qj+Ye1uRx/IiYr+3B0HeB7ikZNjraP?=
 =?us-ascii?Q?fTNdAPT6uXJmibPdMGdtAV9k8SD2yag9w8xIZMBVXamn29WZm7CH9DMU0oTZ?=
 =?us-ascii?Q?N/jDlogH1ZHo8LFbmQ+nqcyHLzzf7G9N0n/C+uYhiCOe78jwNYXKX7YrM4z1?=
 =?us-ascii?Q?n14Utf8vLG5HcuH5Eyz55OC4T/oUZJkVtAyH1O4yRQKXLPROjqWdYaprdlPQ?=
 =?us-ascii?Q?a7iPs57PaUCliyAtI6kQoJs1ETK72OiY+J/d+l7AQosAYoBaY5RHQPm1ask1?=
 =?us-ascii?Q?plqeK87bY4tyDtKfiWD68EDb67ctLeUtZg18ugY+CaEHLWAXq/rqjy44o6U5?=
 =?us-ascii?Q?Tzk9C/RoVtrpOE9DC4IgfQ7q+spxBKLMyBwrskaxPKE+neKoVriPWdKqKSc2?=
 =?us-ascii?Q?erhY/ifnN06eNHDzFr8702q6kCPSmZbp30xw9vT/SUD3BpPks51gQWLgQDSM?=
 =?us-ascii?Q?+VZ20Xo8nWn4bUN/7+dgDmieGvPtu9HOeWO6N0MP4zDlM1x0rerhtlbKYuI7?=
 =?us-ascii?Q?JFb1pnbuBIqJTduNImcnhwJS3CTugoUNUzceTsF3ShftQ163shxdi5HtH4qp?=
 =?us-ascii?Q?blA50ch3CYiHIDmilxr9n6eCVhpWG64CyCjgVdlBgnHlfO6QaKtjIeUfrp0q?=
 =?us-ascii?Q?OUhthNCRZ3am4FivkwnxZFkziXgdsbgtdiNb+8sbTa5CcuR75iDJj/FNeTPP?=
 =?us-ascii?Q?yfb5EWuX3QCXb+YDhM9GbtOvWg29wzxASHRS7b/Mep0baMP2sFZ1y9rBbFgh?=
 =?us-ascii?Q?VzpeaOWWfuHV09xckEF40wurCXku5H4UEManG12TvTJOzE70kM9ANMSWQxFD?=
 =?us-ascii?Q?UMAc84dZUECr4v6ltXF2uFkZGeDBAkfbTtafb84s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdad5bf-861b-4d51-4eda-08dc379a8d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 13:46:51.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvfizPGzSl4BO9S9bt3OGcEVDZZ8EiD7rzSq9DRAZu01olIDiQhyGIQiJUyosGaJAEy/Uy0E2f+r3rW+OMiuvUDxR3Q+WpVAIBXgd8O5EIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5877
X-Proofpoint-GUID: dV28LG1pDdsfc3cKt3gBq6ogjvzdd119
X-Proofpoint-ORIG-GUID: dV28LG1pDdsfc3cKt3gBq6ogjvzdd119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02

Hi Jonathan,

Please find the response inline.

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, January 29, 2024 5:35 PM
> To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Cc: will@kernel.org; mark.rutland@arm.com; linux-arm-kernel@lists.infrade=
ad.org; linux-
> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>; Bha=
rat Bhushan
> <bbhushan2@marvell.com>; George Cherian <gcherian@marvell.com>
> Subject: [EXT] Re: [PATCH v3 1/2] perf/marvell: Odyssey DDR Performance m=
onitor support
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Mon, 22 Jan 2024 18:19:32 +0530
> Gowthami Thiagarajan <gthiagarajan@marvell.com> wrote:
>=20
> > Odyssey DRAM Subsystem supports eight counters for monitoring performan=
ce
> > and software can program those counters to monitor any of the defined
> > performance events. Supported performance events include those counted
> > at the interface between the DDR controller and the PHY, interface betw=
een
> > the DDR Controller and the CHI interconnect, or within the DDR Controll=
er.
> >
> > Additionally DSS also supports two fixed performance event counters, on=
e
> > for ddr reads and the other for ddr writes.
> >
> > Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Hi Gowthami,
>=20
> A quick drive by review.
> Questions like whether this patch should be split are down to the perf ma=
intainers.
> I would ask for it, but not my area of the kernel ;)
>=20
> Jonathan
>=20
>=20
> > +#define VERSION_V1				1
> > +#define VERSION_V2				2
>=20
> Prefix these defines + perhaps make them an enum?
[Gowthami] Ack.
>=20
> > +
> >  struct cn10k_ddr_pmu {
> >  	struct pmu pmu;
> >  	void __iomem *base;
> > +	struct ddr_pmu_platform_data *p_data;
>=20
> const both because it should be and to avoid casting away the const.
[Gowthami] Ack.=20
>=20
>=20
> > +	int version;
> >  	unsigned int cpu;
> >  	struct	device *dev;
> >  	int active_events;
> > @@ -134,6 +160,54 @@ struct cn10k_ddr_pmu {
> >
> >  #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
> >
> > +struct ddr_pmu_platform_data {
> > +	u64 counter_overflow_val;
> > +	u64 counter_max_val;
> > +	u64 ddrc_perf_cnt_base;
> > +	u64 ddrc_perf_cfg_base;
> > +	u64 ddrc_perf_cnt_op_mode_ctrl;
>=20
> Good to name these in a fashion that makes it clear what they are.
> Some are values, some are register address offsets I think?
>=20
> Shy is ddrc_perf prefix useful in here?
[Gowthami] Yes. Some are values and most of them point to register offsets.
Just to match with the register defined values named it so.
>=20
>=20
> > +	u64 ddrc_perf_cnt_start_op_ctrl;
> > +	u64 ddrc_perf_cnt_end_op_ctrl;
> > +	u64 ddrc_perf_cnt_end_status;
> > +	u64 ddrc_perf_cnt_freerun_en;
> > +	u64 ddrc_perf_cnt_freerun_ctrl;
> > +	u64 ddrc_perf_cnt_freerun_clr;
> > +	u64 ddrc_perf_cnt_value_wr_op;
> > +	u64 ddrc_perf_cnt_value_rd_op;
> > +};
> > +
> > +static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata =3D {
> > +	.counter_overflow_val =3D  BIT_ULL(48),
> > +	.counter_max_val =3D GENMASK_ULL(48, 0),
> > +	.ddrc_perf_cnt_base =3D CN10K_DDRC_PERF_CNT_VALUE_BASE,
> > +	.ddrc_perf_cfg_base =3D CN10K_DDRC_PERF_CFG_BASE,
> > +	.ddrc_perf_cnt_op_mode_ctrl =3D CN10K_DDRC_PERF_CNT_OP_MODE_CTRL,
> > +	.ddrc_perf_cnt_start_op_ctrl =3D CN10K_DDRC_PERF_CNT_START_OP_CTRL,
> > +	.ddrc_perf_cnt_end_op_ctrl =3D CN10K_DDRC_PERF_CNT_END_OP_CTRL,
> > +	.ddrc_perf_cnt_end_status =3D CN10K_DDRC_PERF_CNT_END_STATUS,
> > +	.ddrc_perf_cnt_freerun_en =3D CN10K_DDRC_PERF_CNT_FREERUN_EN,
> > +	.ddrc_perf_cnt_freerun_ctrl =3D CN10K_DDRC_PERF_CNT_FREERUN_CTRL,
> > +	.ddrc_perf_cnt_freerun_clr =3D 0,
> > +	.ddrc_perf_cnt_value_wr_op =3D CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
> > +	.ddrc_perf_cnt_value_rd_op =3D CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
> > +};
> > +
> > +static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata =3D {
> > +	.counter_overflow_val =3D 0,
> > +	.counter_max_val =3D GENMASK_ULL(63, 0),
> > +	.ddrc_perf_cnt_base =3D ODY_DDRC_PERF_CNT_VALUE_BASE,
> > +	.ddrc_perf_cfg_base =3D ODY_DDRC_PERF_CFG_BASE,
> > +	.ddrc_perf_cnt_op_mode_ctrl =3D ODY_DDRC_PERF_CNT_OP_MODE_CTRL,
> > +	.ddrc_perf_cnt_start_op_ctrl =3D ODY_DDRC_PERF_CNT_START_OP_CTRL,
> > +	.ddrc_perf_cnt_end_op_ctrl =3D ODY_DDRC_PERF_CNT_END_OP_CTRL,
> > +	.ddrc_perf_cnt_end_status =3D ODY_DDRC_PERF_CNT_END_STATUS,
> > +	.ddrc_perf_cnt_freerun_en =3D 0,
> > +	.ddrc_perf_cnt_freerun_ctrl =3D ODY_DDRC_PERF_CNT_FREERUN_CTRL,
> > +	.ddrc_perf_cnt_freerun_clr =3D ODY_DDRC_PERF_CNT_FREERUN_CLR,
> > +	.ddrc_perf_cnt_value_wr_op =3D ODY_DDRC_PERF_CNT_VALUE_WR_OP,
> > +	.ddrc_perf_cnt_value_rd_op =3D ODY_DDRC_PERF_CNT_VALUE_RD_OP,
> > +};
>=20
>=20
> ...
>=20
> > -static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
> > +static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
> > +				     struct cn10k_ddr_pmu *ddr_pmu)
> >  {
> > +	int ret =3D 0;
> > +
> >  	switch (eventid) {
> >  	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
> >  	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
> >  		*event_bitmap =3D (1ULL << (eventid - 1));
> >  		break;
> > +	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
> > +		if (ddr_pmu->version =3D=3D VERSION_V2) {
> > +			*event_bitmap =3D (1ULL << (eventid - 1));
> > +		} else {
> > +			pr_err("%s Invalid eventid %d\n", __func__, eventid);
> > +			ret =3D -EINVAL;
> > +		}
> > +		break;
> >  	case EVENT_OP_IS_ENTER_SELFREF:
> >  	case EVENT_OP_IS_ENTER_POWERDOWN:
> >  	case EVENT_OP_IS_ENTER_MPSM:
> > @@ -280,10 +451,10 @@ static int ddr_perf_get_event_bitmap(int eventid,=
 u64 *event_bitmap)
> >  		break;
> >  	default:
> >  		pr_err("%s Invalid eventid %d\n", __func__, eventid);
> > -		return -EINVAL;
> > +		ret =3D -EINVAL;
> >  	}
> >
> > -	return 0;
> > +	return ret;
> Why?  Just return in the various paths above.
>=20
> Direct returns make for easier to review code as you can follow a particu=
lar path through
> more quickly.
[Gowthami] Ack.=20
>=20
> >  }
>=20
> >  static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
> >  {
> >  	struct cn10k_ddr_pmu *ddr_pmu =3D to_cn10k_ddr_pmu(pmu);
> > +	struct ddr_pmu_platform_data *p_data =3D ddr_pmu->p_data;
> >
> >  	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
> > -		       DDRC_PERF_CNT_END_OP_CTRL);
> > +		       p_data->ddrc_perf_cnt_end_op_ctrl);
> >  }
> >
> >  static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
> > @@ -549,6 +778,7 @@ static void cn10k_ddr_perf_event_update_all(struct =
cn10k_ddr_pmu *pmu)
> >
> >  static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu=
 *pmu)
> >  {
> > +	struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> >  	struct perf_event *event;
> >  	struct hw_perf_event *hwc;
> >  	u64 prev_count, new_count;
> > @@ -561,7 +791,8 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(s=
truct cn10k_ddr_pmu *pmu)
> >  		prev_count =3D local64_read(&hwc->prev_count);
> >  		new_count =3D cn10k_ddr_perf_read_counter(pmu, hwc->idx);
> >
> > -		/* Overflow condition is when new count less than
> > +		/*
> > +		 * Overflow condition is when new count less than
> >  		 * previous count
> >  		 */
> >  		if (new_count < prev_count)
> > @@ -574,7 +805,8 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(s=
truct cn10k_ddr_pmu *pmu)
> >  		prev_count =3D local64_read(&hwc->prev_count);
> >  		new_count =3D cn10k_ddr_perf_read_counter(pmu, hwc->idx);
> >
> > -		/* Overflow condition is when new count less than
> > +		/*
> > +		 * Overflow condition is when new count less than
>=20
> Good to fix this, but not in a patch doing anything meaningful. If you wa=
nt
> to make comment syntax changes - separate patch.
[Gowthami] Ack.
>=20
> >  		 * previous count
> >  		 */
> >  		if (new_count < prev_count)
> > @@ -586,11 +818,23 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler=
(struct cn10k_ddr_pmu *pmu)
> >  			continue;
> >
> >  		value =3D cn10k_ddr_perf_read_counter(pmu, i);
> > -		if (value =3D=3D DDRC_PERF_CNT_MAX_VALUE) {
> > +		if (value =3D=3D p_data->counter_max_val) {
> >  			pr_info("Counter-(%d) reached max value\n", i);
> > -			cn10k_ddr_perf_event_update_all(pmu);
> > -			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
> > -			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
> > +			/*
> > +			 * As separate control register is added for each
> > +			 * counter in odyssey, no need to update all
> > +			 * the events
> > +			 */
> > +			if (pmu->version =3D=3D VERSION_V2) {
>=20
> This sort of version difference is often better handled via a callback
> in the your pdata structure.  Makes it easy to add a new one for v3 :)
>=20
[Gowthami] Agree. Will make the change in the next version.=20
> > +				cn10k_ddr_perf_event_update(pmu->events[i]);
> > +				cn10k_ddr_perf_counter_stop(pmu, i);
> > +				cn10k_ddr_perf_counter_start(pmu, i);
> > +
> > +			} else {
> > +				cn10k_ddr_perf_event_update_all(pmu);
> > +				cn10k_ddr_perf_pmu_disable(&pmu->pmu);
> > +				cn10k_ddr_perf_pmu_enable(&pmu->pmu);
> > +			}
> >  		}
> >  	}
> >
> > @@ -631,7 +875,10 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int =
cpu, struct hlist_node *node)
> >
> >  static int cn10k_ddr_perf_probe(struct platform_device *pdev)
> >  {
> > +	struct ddr_pmu_platform_data *pltfm_data;
> > +	struct device *dev =3D &pdev->dev;
> >  	struct cn10k_ddr_pmu *ddr_pmu;
> > +	const char  *compatible;
> >  	struct resource *res;
> >  	void __iomem *base;
> >  	char *name;
> > @@ -642,6 +889,14 @@ static int cn10k_ddr_perf_probe(struct platform_de=
vice *pdev)
> >  		return -ENOMEM;
> >
> >  	ddr_pmu->dev =3D &pdev->dev;
> > +
> > +	pltfm_data =3D (struct ddr_pmu_platform_data *)
> > +		      device_get_match_data(&pdev->dev);
>=20
> Shouldn't need the cast as it's a const void *
> and you should not need to modify it in here (so make your
> data types
> const struct ddr_pmu_platform *
>=20
[Gowthami] Ack=20
>=20
>=20
> > +	if (!pltfm_data) {
> > +		dev_err(&pdev->dev, "Error: No device match data found\n");
> > +		return -ENODEV;
> > +	}
> > +	ddr_pmu->p_data =3D pltfm_data;
> >  	platform_set_drvdata(pdev, ddr_pmu);
> >
> >  	base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> > @@ -650,25 +905,59 @@ static int cn10k_ddr_perf_probe(struct platform_d=
evice *pdev)
> >
> >  	ddr_pmu->base =3D base;
> >
> > -	/* Setup the PMU counter to work in manual mode */
> > -	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
> > -		       DDRC_PERF_CNT_OP_MODE_CTRL);
> > -
> > -	ddr_pmu->pmu =3D (struct pmu) {
> > -		.module	      =3D THIS_MODULE,
> > -		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
> > -		.task_ctx_nr =3D perf_invalid_context,
> > -		.attr_groups =3D cn10k_attr_groups,
> > -		.event_init  =3D cn10k_ddr_perf_event_init,
> > -		.add	     =3D cn10k_ddr_perf_event_add,
> > -		.del	     =3D cn10k_ddr_perf_event_del,
> > -		.start	     =3D cn10k_ddr_perf_event_start,
> > -		.stop	     =3D cn10k_ddr_perf_event_stop,
> > -		.read	     =3D cn10k_ddr_perf_event_update,
> > -		.pmu_enable  =3D cn10k_ddr_perf_pmu_enable,
> > -		.pmu_disable =3D cn10k_ddr_perf_pmu_disable,
> > -	};
> > +	ret =3D device_property_read_string(dev, "compatible", &compatible);
> > +	if (ret) {
> > +		pr_err("compatible property not found\n");
> > +		return ret;
> > +	}
> >
> > +	if ((strncmp("marvell,cn10k-ddr-pmu", compatible,
> > +		     strlen(compatible)) =3D=3D 0))
>=20
> Why not just embed this in your pdata structure?
> Even better would be add data to reflect the actual differences
> rather than relying on a 'version' number.  It tends to be more
> extensible as new implementations surface to encode each difference
> as data in such a structure.  Otherwise, in the long run you
> end up with big switch statements for the many different versions
> which just provide some per version constants.  That's messy.
[Gowthami] Ack.
>=20
>=20
> > +		ddr_pmu->version =3D VERSION_V1;
> > +	else
> > +		ddr_pmu->version =3D VERSION_V2;
> > +
> > +	if (ddr_pmu->version =3D=3D VERSION_V1) {
> > +		ddr_pmu->pmu =3D (struct pmu) {
> > +			.module	      =3D THIS_MODULE,
> > +			.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
> > +			.task_ctx_nr =3D perf_invalid_context,
> > +			.attr_groups =3D cn10k_attr_groups,
> > +			.event_init  =3D cn10k_ddr_perf_event_init,
> > +			.add	     =3D cn10k_ddr_perf_event_add,
> > +			.del	     =3D cn10k_ddr_perf_event_del,
> > +			.start	     =3D cn10k_ddr_perf_event_start,
> > +			.stop	     =3D cn10k_ddr_perf_event_stop,
> > +			.read	     =3D cn10k_ddr_perf_event_update,
> > +			.pmu_enable  =3D cn10k_ddr_perf_pmu_enable,
> > +			.pmu_disable =3D cn10k_ddr_perf_pmu_disable,
> > +		};
> > +
> > +	/*
> > +	 * As we have separate control registers for each counter in Odyssey,
> > +	 * setting up the mode will be done when we enable each counter
> > +	 *
>=20
> Trivial: Odd formatting. I'd drop the blank commented line and add a full=
 stop.
[Gowthami] Ack
>=20
> > +	 */
> > +
> > +	/* Setup the PMU counter to work in manual mode */
> > +		writeq(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
> > +		      (ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl));
> > +	} else {
> > +		ddr_pmu->pmu =3D (struct pmu) {
> > +			.module       =3D THIS_MODULE,
> > +			.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
> > +			.task_ctx_nr =3D perf_invalid_context,
> > +			.attr_groups =3D odyssey_attr_groups,
> > +			.event_init  =3D cn10k_ddr_perf_event_init,
> > +			.add         =3D cn10k_ddr_perf_event_add,
> > +			.del         =3D cn10k_ddr_perf_event_del,
> > +			.start       =3D cn10k_ddr_perf_event_start,
> > +			.stop        =3D cn10k_ddr_perf_event_stop,
> > +			.read        =3D cn10k_ddr_perf_event_update,
> > +			.pmu_enable  =3D NULL,
> > +			.pmu_disable =3D NULL,
>=20
> No need to set these to NULL.  Not providing them has same result and
> I don't think there is any particular value wrt to 'documentation' of
> setting them explicitly.  If there is a reason this needs calling out
> I'd expect a comment explaining why.
[Gowthami] There is no specific reason. Will remove it in the next version.
>=20
> Ideal patch series structure for changes like this patch makes would be:
> 1) Refactor to pull out the pdata - no functional change.
> 2) Patch adding the support for the new device.
>=20
> Result is easier to review than the combination of the two changes.
[Gowthami] Agree. Will split the patch as suggested.

Thanks,
Gowthami
>=20
>=20
> > +		};
> > +	}

