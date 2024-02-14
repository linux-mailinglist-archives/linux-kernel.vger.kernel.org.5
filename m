Return-Path: <linux-kernel+bounces-65282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F2D854A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF928EBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD655473F;
	Wed, 14 Feb 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="S4nzJga6"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911C52F90
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917621; cv=fail; b=p7WNDlPaD8qA8mY+hps/2R4WKSLPvMenG/tzPMyjQoYoAp/nICf3VyJityZnpPhxZq8qLCWfDtT+m7lv6p/MFEDeckcWijEJ3GQs+X6bT+KmeeABeP2ZYy8Dh4f309oxtcRvwOsSNQiDtaUxCVlHrHZzlwOlS5EuuR5BIbjOtF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917621; c=relaxed/simple;
	bh=/oGZrt5dMBTNUZmpq+90rXsDgWZCf1SGQl5MN7nNZ5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bz8ZNRNXPOCrdSWoABxd+S9BTYTc6xGyDhzlHNzGmK6rzHNcQ+y/egpUSQ69+oRqZ7GhVydwNysSS3IC2kYAf9u6TNCeuQpWw+i1jeBd8mvVcEDz1KTR7PrGO9kXYnGrOGZ8EY/alCjkN/Or67fExZg4497ur27cM7e7OPfj+qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=S4nzJga6; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EB7Rnx013343;
	Wed, 14 Feb 2024 05:33:37 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w8vc98bth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 05:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGuNMytWnKxhSMQtU+Pkidq1g8K5BLCdN7jkBWGtQhqezs+hhHJ1IX2MgBBUn+BAIiWCFpK9hUzPRp2hcm/ZpoHxPlgyOrTBYsPpSJTRVcVFi8/42xqR4UvpE+UH7NDa+Cx1MISNgFwZmS9p4oD/Q4pqomUMlhfc329Nc9ffBbDHd8BECHJoBAWi6HCeRHb1g4ptldVjTkmuo/6FvT8bOn5yEkuz9PBUeVYFSEVhQPv/nUOijd4+zuplH+kn3a2P0RoFkR363Qc7lK9EwN81jOuqzZfkoPqCS+l2ly7IBURsDNmt6ww5tA2IxL9O7htz63XXiHv9wJhaItwA7U5Uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noWYL/AHqpeaaPEt89BD6lpz5rPIsoGXpgCm24CqJno=;
 b=gem4ezPFRHgykr3wPzOp851D29MyiAYxOI8dKL85DVpNxAg0DIV3Q1eB4pduI3UM3oxS5zgzwbd5T09Me5AzbISemQvuikcv4jX/T/7av012a9uB5KaMMUwaakRrP9K1n2YTWMWe0o8K8HdAAfwiL1XWvfh4l1WxxNNnEYNSD7AmQakLGwyZsUqU//yXHdyrjS0iza9gKXQ3Od72eRXBOJ8s7nq8VfV4OkZYOYJEfnBjJfl6nVdGTAYeDkUYYuE21HLdGzdll8gYVtp9LYcpA3gysD8XmAgatypXXkvswkbhwiOsaZV+T1UxehhpkTtU47RI0sNz9xYxQiXKyp6w0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noWYL/AHqpeaaPEt89BD6lpz5rPIsoGXpgCm24CqJno=;
 b=S4nzJga6eMK/9mqR2Bb5x4w7LlEM4e2fhSBXmpBiQDpkLdtKLFbQvBhGngnEytYshROPF6WdObGQielHWshYzvEGCGLn5rD6F+7tgsuW3DA6oDWgKfd5sB38oOxEkC96L4RrEGDkgmJeoycqsP2R8+hd2NDgZrmHMM3+/GVVFGU=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by CO6PR18MB4033.namprd18.prod.outlook.com (2603:10b6:5:34d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 14 Feb
 2024 13:33:34 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::fcd8:46e5:65cd:339]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::fcd8:46e5:65cd:339%5]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 13:33:34 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver
Thread-Topic: [EXT] Re: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver
Thread-Index: AQHaXvm6poyZcGYhI0K74/kDjlABlbEJslmAgAAQdhA=
Date: Wed, 14 Feb 2024 13:33:34 +0000
Message-ID: 
 <MW4PR18MB5244844411A57790287068E5A64E2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20240214035524.1245615-1-vattunuru@marvell.com>
 <165cec24-680e-4d3e-883e-56fccbb4d7d9@app.fastmail.com>
In-Reply-To: <165cec24-680e-4d3e-883e-56fccbb4d7d9@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|CO6PR18MB4033:EE_
x-ms-office365-filtering-correlation-id: e0d7131d-4c15-458f-d762-08dc2d618ade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BITp6wmAb+hDq14fxhsI50ARE+mkzmMPjGTHQL6JacMYKh7wE/E0htFjhbnNwEGO0QmY8mJxhr8VqLdCK/xIS8i/EThQDhLnPg1AVJPxcLJye+aVA4f+mVpSMyqpjviSsEfvFXsD8VgjYH7EjC/FBEb/TCFrjhLQyoYyi9nlRjLb0HGxOGcMQlRoeaUHX5wn03Df8cK1/sJ/Bo4TqAxtxCw3yRDnjynIjqcCzIVIlri5FjVHskcHWdiWHe7IJ7VFb/3TOfQa1CLuqBORwMmZDRW8P60uW8wASWgW3YwGdSYkbh/+/rMHRdvBvp5Tn4xKhqOubZCHsu41+fpX5VJeMMDahZnMNgtzEqIWG/1RsQ89bhTbechmflLxtlWZ3gNJ79/3gMbmZi2sFOhsGEJDvq8gH41xJaZ+p3OcVHU45w3bj5BHe6R8O0AklzCAR2nds8gjVBdBuTiwkBldf8sIsG3f21AKjYRs10r/WklTN1WDGdSz29HAXCacMAoRWxmqXIDej7AC8hKQCinPh7lpuG2r/TrQ7jWEv89gxVLpSUDeNVJb0vuUCl4R33IcNXpBv1vSj26erwzZKkpnmwcjJlnT3HkQZmBphu3to6Mrld8vfU8/AP2dyYGzQk/7HZvU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39850400004)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(71200400001)(478600001)(41300700001)(55016003)(9686003)(8676002)(8936002)(4326008)(52536014)(2906002)(5660300002)(7696005)(6506007)(66446008)(64756008)(66476007)(66556008)(53546011)(110136005)(66946007)(316002)(76116006)(83380400001)(122000001)(86362001)(38070700009)(33656002)(38100700002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?h2FyzaxJJkw5dOlYelnyHWiHGsN3c3b2810bPekozBheYpiaYnxGV2BxI9Wa?=
 =?us-ascii?Q?aUglGpfAHjUKFLe6wQk95189TiEtuiZDJB8uLeWMw79oLavawCzJzkuhgwYc?=
 =?us-ascii?Q?kxKgY+TXRSaVTZYzFrzw9fDlcRfKsj+h6AD71P9EH53jnHYDZnKVMn1V24Fq?=
 =?us-ascii?Q?N8+PU4AYc770s1CAKA4z1s6ia42GiigqGJspOFVoIp0Nqj59qadG46Wx8T88?=
 =?us-ascii?Q?hpMbqJ3Jf7pngJb4XUeIgTuc+pNT5hf2rqKY18E/10IJyTBvBexSBzctna1s?=
 =?us-ascii?Q?OqVd3+YSbTNYQC8qfqTEljznblGP6OFze/qEx/OF0V0ALIj61iZDqMQ8QqdS?=
 =?us-ascii?Q?UWpXbL0TjM60MJXumz7hWiJIp7vaxPV6zuOzW8L4VfXfkVyLannnsmUgyH/s?=
 =?us-ascii?Q?og5LFMMv5Ew7eFBQnx9YgQZHpHoWvrKuPHf/uJ7s4mL30a5UjFbXbf+cupIS?=
 =?us-ascii?Q?islT1VsY7KFQcRJ9Nnmwq0fupWNhwHn4BavfrmaD0fA3cMe1s+nGjaFV6QaY?=
 =?us-ascii?Q?bOT96v/t3mgII6MqZmp4WdV05eW1Omk4qAc/Lvo6hZpbcwvDqLXtWYRytPvQ?=
 =?us-ascii?Q?VJC64t0HeH1XsXJybda10kGFIS7ACXHkrDHSzeyzlZfKpP+YWi3S2xSBc+Rc?=
 =?us-ascii?Q?VuCngqEke5iBOhmZ3Z6i3sXsD2LrHk8+vgbD3GscDfcgaOi6FaLmEBK6gR+e?=
 =?us-ascii?Q?C+Q6XlXHfa78KADZ1b41WTrPX2qf5FqZ9CL8hQMyfojmCjgsfBlS2DIWE4uC?=
 =?us-ascii?Q?9TF4ExNvGrE+L8Q0pus7K/37Am7lqliCyZYpGwpEXbJP50m+xRbq8yo6zZOG?=
 =?us-ascii?Q?wanxIzar/0CuY53frL3RBtFrO4hR1Tsw3/oNc02PXn17BljbKr/GTShzqr0o?=
 =?us-ascii?Q?7nT3DUk7yEtiaDjLzSu1emnmRkQN7pKUMhoFkuqSUFm8Ly2t/sZaLFJ2uDpX?=
 =?us-ascii?Q?6XHf6L8Up5Ps4pwAKV8U9S0RDFK4BfbPZd35muDGunLUN3eKrh0vkDeEuMeO?=
 =?us-ascii?Q?45ui+iNrCCtnKyDsqK37UFUvGdV8Z0aS27ZJGEtejOZnlcdZRKy2DMvZGazc?=
 =?us-ascii?Q?jeKHmOpDanLh+wXFuPo1jqU07aQVNifa1ohST8tlw45pg8ThilvtGDGl1Vtd?=
 =?us-ascii?Q?8t2KXsqDvsE0iaNJ8/fl1E7cNXxqAp4XV62BpZd38baASXt9uZ9Lf513Odhj?=
 =?us-ascii?Q?yQFbaqReyZktlRC8usFI7HqU9Ec91P8MOwunyhAQ7jniVuZLfMgauST6mZ/p?=
 =?us-ascii?Q?pbtF7QRrOqhcQSQwwBGJjKNxukFF36zpeKKssG7UTS33B4SuS2QSk7dTdtCH?=
 =?us-ascii?Q?v041WR4F5IE84i3GnoM8C7YBx0PxgkxpwSBPMxwfSntyfSO1PnBYTn8CxtVt?=
 =?us-ascii?Q?UGTQTlrZHsSJFgszzhJmet1J0lUQjGsJ+cF0F3fQDUj3fBz5jyPz0XpXGIpq?=
 =?us-ascii?Q?Y8NT7dgYV14stpoLo31+iDrLvH6or5pKOmmJd5bs8ap7WtmJF4HfXBj5ToSZ?=
 =?us-ascii?Q?fuM6+jpPacL3PMvm7Qyp5/LlcFRXpMOdZaEgOq2OtJkXO/Ie69Q6Jr0B0a0c?=
 =?us-ascii?Q?P2aKM6IjY08oR9hFRL5HJt64LiKSZBeXVJRWZVpD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d7131d-4c15-458f-d762-08dc2d618ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 13:33:34.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKjPfqpdfQaU94NfIGG8vCpn/2ZgWJK5dKoirbsjmlu7Sfam3m40RQD3iIIpE0mUC1IVVCTo54z2/cWyD+dbWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4033
X-Proofpoint-GUID: JFnV_n-jBYyiNOgWcPycw72NMCmC3mDa
X-Proofpoint-ORIG-GUID: JFnV_n-jBYyiNOgWcPycw72NMCmC3mDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_06,2024-02-14_01,2023-05-22_02



> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, February 14, 2024 4:53 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Feb 14, 2024, at 04:55, Vamsi Attunuru wrote:
> > Adds PCIe PF driver for OcteonTx3 DPI PF device which initializes DPI
> > DMA hardware's global configuration and enables PF-VF mbox channels
> > which can be used by it's VF devices. This DPI PF driver handles only
> > the resource configuration requests from VFs and it does not have any
> > data movement functionality.
> >
> > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>=20
> This looks incomplete, as there is no apparent interface to actually use =
the
> driver from either userspace or kernel. I understand that you want to mer=
ge
> this one step at a time, but please try to at least point out how this is
> intended to be used, or post it together with an (in-kernel) user if you =
plan to
> upstream that.
>=20

Sure, I will address this in next version. Thanks for the feedback.

> Is this used for anything other than networking? If not, maybe it should =
be
> part of drivers/net/ instead of drivers/misc.
>=20

It's DMA offload hardware, not used for networking. The DPI PF function is =
a simple management interface for global & per VF configurations.

> A few more things that Greg hasn't already commented on:
>=20
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > 4fb291f0bf7c..3142fdb1b4c0 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -574,6 +574,16 @@ config NSM
> >  	  To compile this driver as a module, choose M here.
> >  	  The module will be called nsm.
> >
> > +config MARVELL_OCTEONTX3_DPI
> > +	tristate "OcteonTX3 DPI driver"
>=20
> Is OcteonTX3 an actual product name? I thought the follow-up to OcteonTX2
> (cn9[268]xx) was the OCTEON 10 line. Or is this a follow-up to the Marvel=
l
> Armada (cn91xx) line?
>=20
Yes, it's OCTEON10/OcteonTX3.=20

> > +static void dpi_poll_pfvf_mbox(struct dpipf *dpi) {
> > +	u64 reg;
> > +	u32 vf;
> > +
> > +	reg =3D dpi_reg_read(dpi, DPI_MBOX_VF_PF_INT);
> > +	if (reg) {
> > +		for (vf =3D 0; vf < DPI_MAX_VFS; vf++) {
> > +			if (!(reg & (0x1UL << vf)))
> > +				continue;
> > +
> > +			if (!dpi->mbox[vf]) {
> > +				dev_err(&dpi->pdev->dev, "bad mbox vf
> %d\n", vf);
> > +				continue;
> > +			}
> > +
> > +			schedule_work(&dpi->mbox[vf]->wk.work);
> > +		}
> > +
> > +		if (reg)
> > +			dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT, reg);
> > +	}
> > +}
> > +
> > +static irqreturn_t dpi_mbox_intr_handler(int irq, void *data) {
> > +	struct dpipf *dpi =3D data;
> > +
> > +	dpi_poll_pfvf_mbox(dpi);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> Have you considered using the drivers/mailbox framework for the mailbox
> portion?
>=20

DPI HW mailbox might not fit fully into the drivers/mailbox framework. I wi=
ll double check once.

>=20
> > +static void dpi_pfvf_mbox_work(struct work_struct *work) {
> > +	struct dpi_pfvf_mbox_wk *wk =3D container_of(work, struct
> > dpi_pfvf_mbox_wk, work);
> > +	union dpi_mbox_message_t msg =3D { 0 };
> > +	struct dpi_mbox *mbox =3D NULL;
> > +	struct dpipf_vf *dpivf;
> > +	struct dpipf *dpi;
> > +	int vf_id;
> > +
> > +	mbox =3D (struct dpi_mbox *)wk->ctxptr;
> > +	dpi =3D (struct dpipf *)mbox->pf;
>=20
> Can these pointers be strictly typed instead of casting from a void*?
>=20
Yes

> > +static int dpi_pfvf_mbox_setup(struct dpipf *dpi) {
> > +	int vf;
> > +
> > +	for (vf =3D 0; vf < DPI_MAX_VFS; vf++) {
> > +		dpi->mbox[vf] =3D vzalloc(sizeof(*dpi->mbox[vf]));
> > +
>=20
> dpi->mbox[vf] does not look excessively large, so I think
> kzalloc() is better than vzalloc() here.
>=20
ack
> > +module_init(dpi_init_module);
> > +module_exit(dpi_cleanup_module);
> > +MODULE_DEVICE_TABLE(pci, dpi_id_table); MODULE_AUTHOR("Marvell
> > +International Ltd."); MODULE_DESCRIPTION(DPI_DRV_STRING);
> > +MODULE_LICENSE("GPL");
> > +MODULE_VERSION(DPI_DRV_VERSION);
>=20
> Please remove the DPI_DRV_STRING and DPI_DRV_VERSION macros, they
> prevent grepping for the strings.
>=20
ack
> > diff --git a/drivers/misc/mrvl-dpi/dpi.h b/drivers/misc/mrvl-dpi/dpi.h
> > new file mode 100644 index 000000000000..99ebe6bbe577
> > --- /dev/null
> > +++ b/drivers/misc/mrvl-dpi/dpi.h
> > @@ -0,0 +1,232 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Marvell OcteonTx3 DPI driver
> > + *
> > + * Copyright (C) 2024 Marvell International Ltd.
> > + */
> > +
> > +#ifndef __DPI_H__
> > +#define __DPI_H__
>=20
> I see no need for a separate header file if there is no other driver incl=
uding it,
> so just merge this all into the .c file.
>=20
Sure, will merge into .c file.

> > +union dpi_mbox_message_t {
> > +	uint64_t u[2];
> > +	struct dpi_mbox_message_s {
> > +		/* VF ID to configure */
> > +		uint64_t vfid           :8;
> > +		/* Command code */
> > +		uint64_t cmd            :4;
> > +		/* Command buffer size in 8-byte words */
> > +		uint64_t csize          :14;
> > +		/* aura of the command buffer */
> > +		uint64_t aura           :20;
> > +		/* SSO PF function */
> > +		uint64_t sso_pf_func    :16;
> > +		/* NPA PF function */
> > +		uint64_t npa_pf_func    :16;
> > +		/* Work queue completion status enable */
> > +		uint64_t wqecs		:1;
> > +		/* Work queue completion status byte offset */
> > +		uint64_t wqecsoff	:7;
> > +	} s __packed;
> > +};
>=20
> Is this a hardware structure? If it is, you probably don't want to use bi=
t fields
> here, even in the best case that is a bug that prevents you from using th=
e
> driver in big-endian mode.
>=20
> I also see that there are only 86 bits defined, and one field crosses a 6=
4-bit
> boundary, which feels odd.

It's a software structure only, will fix the bugs.

Thanks Arnd for the review comments.
>=20
>     Arnd

