Return-Path: <linux-kernel+bounces-143052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4A8A33A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A99B24091
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B953149E06;
	Fri, 12 Apr 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FRscpGc6"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749B148311
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938813; cv=fail; b=msNYg2/rYDP76uXheWtIpuYOBTwW9CWxanlbng//P858vsX/bhjaDYPodJ0X2tHAQ4XeoyFPLL37eyZzOKbxNGgBg5L5OhDine0F2x+x4yHImfXTrTmAZCzqZNiYBjbSVN9U2lCap9GPPi1JYPNn2zbNYSydNtICUnJKgVoN1mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938813; c=relaxed/simple;
	bh=yqKLK+EI6/kbqXkiJDI5sx3sSmS2UOrEoUvHk7fPucY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YILdihE3YSFU8NEOQJffKeuK7IJVqLtncvBvnKdsM4urcSLnFluYwQc1sZwYm8M6dSmubzat9Lqm8omrQO/LABgzIQgWU6dg3T4GOdf4eS8WbLxGPGeldfQVTbp3p1pNtIJrKVQ3f0f8NBIW6aEY83m+3IbskN4aoQTcU73PiqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FRscpGc6; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CF2ZPq030580;
	Fri, 12 Apr 2024 09:20:02 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xexsahx2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 09:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpQWiJpD8AxpD4xYsvLXhCNjkgaveDgTpzFUarAzKUAzBanMdDUPRv5uYRsSJen+r+TlsDQbnrey0lLTRu2a1RQj2p73QsWFdZSv/YmMW3NhPmAr3fnIT0cPOAG863A8yR5E3Vmh76vKUoQtieHPsxLhcNUofO9NC0bUIRAR1kW2nzblnFsU6PCbVQrPU2nW6J5BSk/z/ZBv7zDZb6T003+Ct2zy3eTPwZfyaycRBo+hVTrWS2uDSRresA7rZR6VxNony7EJsu18Oy/byuCSN49Zk0WoG3rdCy7+sdUyRt3HDA9py2pVSDvsPjufIQTB3YAEoSVfffjOkuKQNVP55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nRElcxwy+9EBTNkmJFFq1zGVDd5V4FEYIHXzUH5IdA=;
 b=Oyqx3t897CokU05cp21LzKHwx1iVOABCCsG+sg4EyMxGBZc08w/XAx/GUlcfQLk/yHWjwqxUxhDDtiXpV7Saw//MsUF3mFeS+3WchswqWCAnrw4Vvjp3Kgp9/EhUucrx7vHfsS2ygVrH7usgl1RHoFGw4ITHMz3FvMHeCkhWXTJUh66C6eWLUo2rZ7lBFaiPfVz0nICCCWBZ2LOntwDXA9KumRawLATKcPt9lsdUy9GwG7LBciCdtVXCE6DVZ7d+jwSTM2MxnCgCQhJtRJLUqpAo4vo0v8LpmnLnNMZjV7mMNOzii+AErMmfYkZppbACRpW4uv0bC0XDC3yfExafEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nRElcxwy+9EBTNkmJFFq1zGVDd5V4FEYIHXzUH5IdA=;
 b=FRscpGc6VvPnMZsorjJjMh4FsPH5/3FVaaasTESmwtzpanJ4BETJj3n6YNK82+n6XPSUrtye8mXBBGn2xkRhRtqCmrez9pN5nGZYdgV91iMZzjV0ruY/Zd5r/x8lh+LGlsFAOG4kSpSUPfHcB/KlTsysjwHGO8NGMDo6uPEP9GM=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by IA2PR18MB6012.namprd18.prod.outlook.com (2603:10b6:208:4b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 16:19:59 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 16:19:59 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHajNJlUzRgj48oqke7eNtbl1jogrFkj7+AgAAOmwCAACXXAIAAAZzA
Date: Fri, 12 Apr 2024 16:19:58 +0000
Message-ID: 
 <MW4PR18MB52447D1E7F0CD0D1CA6BAACCA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041258-reminder-widely-00c0@gregkh>
In-Reply-To: <2024041258-reminder-widely-00c0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|IA2PR18MB6012:EE_
x-ms-office365-filtering-correlation-id: 9760a585-c4b4-4d1f-b481-08dc5b0c660f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Nm7LUDtj+KL5zeGRdawAxqeKkMke9oKAQuxqxk2TB0jaVJyD4JuCXCcfMFOlyVQ77Dgsd6pD1huWHap1HtEi8bPE4Ae0//PXcmWTWO6epdJ9YycauqWLEhBhD+bGsACop3igvxUKIznb82ZpgZBnFuUxrv+HPTFUCZ09a9mLdNwZGKs8/X3oxuPIFgJsOyPmEbCQLzeE/dhFLRsHYaojCrvHOP2aVWpbpwKwRJg1m3YTHCHsq+eHpY/xka3NAPUef5hSf0J3eyIfbP34e/DqT8BxkVEDFrdWIRrmqsHvj/8o5LjgrbJU+Qy2rGJCG155ngefcbGn4Cg6uDUoaQ+S6twMAa539thbZc5rs7tMGNDY5uzmIhsgNyulkAV/u9VM2k78nWwPsEaaK8YUsZfAiXgISvp9QoYVjMX2YlSR5Yt5gZIXYnlg/5b61YoWOWA0MOXtEe5WV2rpXfycISMTKyNCJeXSHO0ttWJ7u0jwZ1oi8JsehW+LPLBMxlcLVFbrjThPEfca5nw3Ho7zatF94ZAL9E6peCt/Hrrcp06G0z0bdpjuEktIvl8jjxrAGnUcppm6y38ktoxGOgCAsQOyrWXJye4x2RVilKjHol+EKk8m1I6qgTQTPAE0j3pEhrWVc1cZjERDJgrgd2+ROzZ1RAk1NSj0HSRrH6r46ygjBMg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kR3yQTe3l1xleIrJr57MW5mzV3qbjkc+3tZluOl0vdMHKshoRlDXh6QchSvy?=
 =?us-ascii?Q?XD0ElAB3aen9sBxE/dhtCuwZJ4/CHHY9DeBDuNiYWs9PGbMlUQOA04ZiFEJD?=
 =?us-ascii?Q?XNqR2O6eBgoKDCX6qo9thlAuBixXi0d5WtSWZ/zrn6N2QZzyr69n+x4LwZ4L?=
 =?us-ascii?Q?fpMECHIsxA56aYea0VJvWMN9FJ7PImJ3460WRm/h2bBdfGdoni1W1PD2k5MQ?=
 =?us-ascii?Q?oIsjskoxDCKcy5r/fSxkfMOMeGc+BINCrkF/bnd5Sx2hcjHRBHMxE8559Cyx?=
 =?us-ascii?Q?7hkdGCvxUosBOAzX/GFzVX91p2Bt3kNjUYcvnDCmvPrk2uS16B0Y6RjvzPX1?=
 =?us-ascii?Q?xAXP42QmspuSIq+2VaHS3HpCvPfJ6FULI61VxtjCjLpjx47U1En1L6qxuVNg?=
 =?us-ascii?Q?4FpLkdjluluYbzmfKsL88ClA7kZRz/bPhLul121QjQmfEy2ObhNPUjDiFyt/?=
 =?us-ascii?Q?KP0Bw9iqWST1TAkfnP5NjJs0VKUZ43CnKsENGxl6idEsG/DimMi4BBE1rbdl?=
 =?us-ascii?Q?iNUjy1p/XGOu8g7fP+eovguP/enQ5G9DiuDWIJGgvST9sxk6nbcFGKiPQ8lz?=
 =?us-ascii?Q?/uz5LpKjsDXxpUc69smtadYs61KVD8ds4Tn10kSAB72KaGERLOuBjDD64zyO?=
 =?us-ascii?Q?LMPR4V0eYXx/HQQODoSbQAEDmxOoinhvSl8DNwBNi1FIa2H6UCza2WET7MyW?=
 =?us-ascii?Q?m1+DFis4872V1cHrdPAxUke92OEE2IiByUXX+9CzK2+N23JXBzHArI6APZ7y?=
 =?us-ascii?Q?kzYrprG+2isc5MQTb6qYQbgl1GwdkXO1htu5r7F0fNuz698yxql1wZLF0+ty?=
 =?us-ascii?Q?Hy5W+EMdk2sC8oSQQOLHPg/mLWn1EodTIMzKWINknAngksFoXhU/JyV/OcrC?=
 =?us-ascii?Q?7izfR/5RrrEKfX8vhEW/zI8nS2zOVrxNvnmCEf7/GKXVEz9kV6y9WLTgo/s5?=
 =?us-ascii?Q?5pox5IGrz1N0VL6sI14uwQOzbUtx3wunifAetmTBNwC9btczxR/HBnV8Pq0T?=
 =?us-ascii?Q?tscehKLi54P/lysNHik/z6nzEiyc8bcEYSA/GnyeSh4BRFCvjCq2sm1PzXQh?=
 =?us-ascii?Q?P89Zfd2xzODKLI+jUXXqxbIMnK7LgaF5roARojuS6Bsby2UDksmfGqu/PLy9?=
 =?us-ascii?Q?7C9zq2YexFZpxzPS3qLaAmgGgno7M/9qMORGytLeIDqwvZD7i0fyLg9N+FWt?=
 =?us-ascii?Q?rzixzfZj6A0S9FYgeOsMNy6QCTKGpgbFb9jZwZDeHpkwic7OxMruVZpco5la?=
 =?us-ascii?Q?UW7GRLV8n8VyTGPlsHJeP6OeFzgSE40zKKiML2ytVktYnGnhixZDbkFxZG/Y?=
 =?us-ascii?Q?w5ardL8lg8ffg+eTpAyGP8av+t8/684DvZZ68Uzk3d071RkToY2hQ0sdUuM/?=
 =?us-ascii?Q?z5E1puYbFuVcVsrBKfYSMFDdAc9Q8xoCfjbFzp7gKRAdum5SGYLAWmiRMZWI?=
 =?us-ascii?Q?8r/4wZUz9rRUYz6aqrcJf32dO/gslBCnuj7eyqB84wMS2ih7a0DY1T417FBl?=
 =?us-ascii?Q?L78mUsmoAPwKUQylywWOsDVlR2S7kp/fMEI64WwqlLmpkfweKE2V37OISn+I?=
 =?us-ascii?Q?gXTkY82jiGGfid0gsTk5aE6aXtCeeuqPizp7/VlV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9760a585-c4b4-4d1f-b481-08dc5b0c660f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 16:19:58.9356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNAKePyV36p3Xm5rKJ9O9VkRAHParyJR+hHXJDqn2JggLMR5oQMP6CIzztKlhGho8LANR9gYufrOT/cP0pa62w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB6012
X-Proofpoint-GUID: Yz07NHXv1T9sN_K6-YS-cYG2Z9poWCkV
X-Proofpoint-ORIG-GUID: Yz07NHXv1T9sN_K6-YS-cYG2Z9poWCkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, April 12, 2024 9:05 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> Octeon CN10K DPI administrative driver
>=20
> On Fri, Apr 12, 2024 at 01:56:36PM +0000, Vamsi Krishna Attunuru wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Friday, April 12, 2024 5:57 PM
> > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > Subject: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > > Octeon CN10K DPI administrative driver
> > >
> > > Prioritize security for external emails: Confirm sender and content
> > > safety before clicking links or opening attachments
> > >
> > > --------------------------------------------------------------------
> > > -- On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru wrote:
> > > > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's
> > > > physical function which initializes DPI DMA hardware's global
> > > > configuration and enables hardware mailbox channels between
> > > > physical function (PF) and it's virtual functions (VF). VF device
> > > > drivers (User space drivers) use this hw mailbox to communicate
> > > > any required device configuration on it's respective VF device.
> > > > Accordingly, this DPI PF driver provisions the VF device resources.
> > > >
> > > > At the hardware level, the DPI physical function (PF) acts as a
> > > > management interface to setup the VF device resources, VF devices
> > > > are only provisioned to handle or control the actual DMA Engine's
> > > > data transfer
> > > capabilities.
> > >
> > > No pointer to the userspace code that uses this?  Why not?  How are
> > > we supposed to be able to review this?
> >
> > Userspace code will use two functionalities (mailbox & ioctl) from
> > this driver. DPDK DMA driver uses the mailbox and the dpdk application
> > uses the ioctl to setup the device attributes. We are waiting for this
> > kernel driver get merged  to update the corresponding support in DPDK
> driver and applications. I will provide the pointers to both the use case=
s in
> userspace code.
> > Meanwhile below is the current dpdk dma driver that uses sysfs based
> > scheme to convey mbox requests to the kernel DPI driver which gets
> replaced with hardware mailbox scheme once mrvl-cn10k-dpi kernel driver i=
s
> merged.
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_DPDK_d
> > pdk_blob_main_drivers_common_cnxk_roc-
> 5Fdpi.c&d=3DDwIBAg&c=3DnKjWec2b6R0mO
> >
> yPaz7xtfQ&r=3DWllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m=3Do3EhoL
> s7dsod
> > -YHS438Wl2Pf_MKMBYegGSKteoX3qFTB0HV897ykpCVbTp-
> nmj4e&s=3DA6TJDFUtPm3ksJh
> > qop89CL8GgKj4sjkJIVi1-RdnUr8&e=3D
>=20
> So this is a DPDK thing?  Ugh, do the networking people know about this?
> If not, why aren't they reviewing this?

Actually, It's not networking related. Like the Linux kernel, DPDK also sup=
ports multiple subsystems like
network, scheduler, DMA, mempool etc. Regarding the usecases, the DPDK Marv=
ell DMA/DPI VF driver
interacts(over hardware mailbox) with the mrvl-cn10k-dpi misc kernel driver=
(administrative driver) for setting
up the VF device resources.

DPDK is one example that uses this driver, there can be other userspace gen=
eric frameworks/applications
where the virtual functions are binded to userspace drivers and interact wi=
th physical/administrative function
driver running in the kernel.

>=20
> > > > +	__u64 update_molr; /* '1' to update engine MOLR */
> > >
> > > You "burn" a whole 64 for 1 bit?  That feels wrong, who on your end
> > > reviewed this api to be correct?
> >
> > Just for the explicit alignment, defined all variables as __u64. I
> > will shrink it to minimal sizes considering any reserved fields if requ=
ired.
>=20
> The alignment is fine, but wasting 63 bits feels odd, make it a bit field=
 at worst
> case, or just make it __u8 if you don't want a bitfield.

ack
>=20
> thanks,
>=20
> greg k-h

