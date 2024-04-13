Return-Path: <linux-kernel+bounces-143697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E19878A3C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DDFB21E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795993F9CB;
	Sat, 13 Apr 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ouVDhIpm"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44543EA97
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005927; cv=fail; b=lp0Hvwp8pRGVmrms0B9B2RYoWvrVuLNW92uMD/jGxBwi3SEQKBAB1it3ZE/dprQd1FtFP++PsyATQbUD/q8FNuQg6Ng1FO8RaAjPjNN3VL7gjn70NwnGwv9fAx/9Ctm1ZzTc72MNftIjzLTFTjhuxSZHkcFp/yayDS8ljSTX1uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005927; c=relaxed/simple;
	bh=7CdQivUFcKMeWV4rqFnxjeIF5v3Z7tC5bHFIpPCv75w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OuW5jqTeJbGSNIuyIt06b9bJod1WJJ3L1rBtDWZ4F8PLZuP4blOvd54KGP7lojqxXw8NH3wtNJ5UsvhlD0pKBdHpC7/QwNORmB0Xsui873VyOIwPlmGNCVOjYhiluyJaT0UO+MN6kOUJTMjgZaOSXJRpsgEIPIZxjXVWCzpdZ78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ouVDhIpm; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43D9jjPK024035;
	Sat, 13 Apr 2024 03:58:41 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xfqdkg3qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 03:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrh4dybHs6j4kTbcoJ2/5WSKvzUFQens6IJVH8Ax6x49YtVZPQCWeZgoMNLUCrU14wns+i8uiLC97E/whoiXO1o5acxcmqucJm+j8kd+oGa/Y94RdzuiJ3kZ/AghfAzrNJG5iGkkVcST0cCaIN4S6Czay3wSfs8S4V2TdreTTvryajcA9kBw6JWIXrSej4iAtQ+OEefeq61AJp4HW6gfwsW2Vp/9ZVPXIwElKK+chTuaarT5qJHblA4rh7XDV7tTyvyOB3WEYwob15TXMvn0FFjjVoiTTc+AiBwqSK49I5B3a5GupKL+X4XPrNPkiCu4biYAt9/1fImN4Rsa5lh2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YLeR2IJ+8Zy0mrEiQyHSeSu97jJvM0+hu+qA1KtdeM=;
 b=BVDjOX//Cn+v/6yRxKCS8q4ielD3Rvyvg75trU2XBEJNIrQ8+LSBy0gseUgxnhaYIWj/LyPtWgCctncA4CQRGLlMxvw+qxIt2EWqz2UpaFSf9xkf+Y4W2wIkINcQ7Oehdxl5BR/toNmTfBOn6RJzzSBxSu7z4V1YK/Py9SvTkUfVVsPNIQNwjaE+P6FIJ+zWmtM6yWygQmyewjzv20vd20uhS/h5OTnCNCaSFQdKHrq+4T2nnRSa0oJm1Bi/gaLSUZ8QluJKarUVX8NK/DshhlNjXKnYgEGMEGC9GvzEhVzicARp+Jr5KN19uFpmkc42nNxq0S/Z7/qbk+6F9S/D+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YLeR2IJ+8Zy0mrEiQyHSeSu97jJvM0+hu+qA1KtdeM=;
 b=ouVDhIpmOE9CpIONiZGKx+V2DQ9B7eoaKA4fbUpTvgKaIYv9aUwT9kmep7GVItl9hZy/97pbkOju+pXYXPrHJDVwUPgyeyEMEi4biRItvWj3rLWeF8Ps4FKJVR43YRn3mM/da57chQUy7R/YdpzlS3UF9NV6FXYrSZMLW692Qvc=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by MW3PR18MB3612.namprd18.prod.outlook.com (2603:10b6:303:2f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Sat, 13 Apr
 2024 10:58:37 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7452.041; Sat, 13 Apr 2024
 10:58:37 +0000
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
Thread-Index: 
 AQHajNJlUzRgj48oqke7eNtbl1jogrFkj7+AgAAOmwCAACXXAIAAAZzAgADsugCAAFXs8A==
Date: Sat, 13 Apr 2024 10:58:37 +0000
Message-ID: 
 <MW4PR18MB52449EBFE3862D7C3065D22AA60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041258-reminder-widely-00c0@gregkh>
 <MW4PR18MB52447D1E7F0CD0D1CA6BAACCA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041351-endowment-underrate-4b8d@gregkh>
In-Reply-To: <2024041351-endowment-underrate-4b8d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|MW3PR18MB3612:EE_
x-ms-office365-filtering-correlation-id: f99f559d-3275-4f3d-f4e8-08dc5ba8abdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IpgrjjhNRqZEx+rQilPlK3lz7xJAGUkMWWF4VrWq3a/0Ktbtr/s56PTiRjMADZ5XHnQvD5hE1XoUD9VCNG8VvU96MbI3nz6bqDUvDzVsS4w17EFTZcpTEgZMS9pHsin6t3HQ4LGFdmZt1VjlXiMmOkM2rkn+kixm34kJkShAvlwccQCn8Q34iZ7XesDvJfkvm6gFydgw10OI6VW+JkO8gFjVanDZnLFgRL6GkDPdOBZquxepkkmhQq5xl4K4rP1sbbUqnfQvernXsgehAgYQRKJsDCjKJh4RJA0FpSlwIwJG1Vg0tCP+d3u+FZdLMcqsG/bp6FORefx+tHNaIJTEmdcCvYHD4r+/KcD9jBqlt5QQ9P5OpqjhvnJDprMHW6lw3vdZxhl/g5Ubj1v9RsERQumkMaOD+60qiYGAYUe+vyy6b+0wmn+jZyiE97xCiUnIiqmycYWOagsUjo1LdD8vNAGPtlRLAy240iUeaYn3WDJ+NSJowcxtOERU/qzWMcr10kW6LB8QQSRnxHcVG7WjkoHWE+4lyEMMBUHyTO2Et+GwjYlK759umX+41zlhiBoqiXRLRdJz3w7r+rWgRKBWmlsuUjcfa7EpOzzmLzBI7gA5XdQp5IHeReQuca3y/fqXntpUSMZBrXNRrhPmaEM3MWoh0CSaFNsf46z7yS8ywLA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?POE07l9gx+RnNtSPVF/o1MdV+LyOBIZ5/y/yspc1ctmDB96Q7bfn+s5RqSjB?=
 =?us-ascii?Q?FXpOPv32q9afjafYGmtwGLSJUB9cLto0CwIVdHQYhFkZXxI5nK6m3tsAXcn6?=
 =?us-ascii?Q?Muj7Efd7TZAP+3K8vhugusQXWfv5N0INjUyj/qkRdkAiX6rL2uFt4UBS43DD?=
 =?us-ascii?Q?xfwzwTramG1tqMpWdf+UerKhi7+xx+K7Is2BBijT6hxX/6nTAXsfeYJ/uaWh?=
 =?us-ascii?Q?5MsX9cKWCEXf2gn144Mnba1/zNK1XmowtctFVTC/5/Bw16wM2RO3xYxzO0w5?=
 =?us-ascii?Q?O85uF7+uHEdx1/vUp2Usxj8GN3/GrEu/XhZifv1yZGhUMYhKofd5NPnQAXfx?=
 =?us-ascii?Q?xvDvVtPZ+DsSL7DIKb39rPU4o5ipY/0OVJPK5WnVZqdEno4AjX6ktAMdWWUb?=
 =?us-ascii?Q?jjoX4zGzV2xdnA31NGoOO+N7hb7o7F2qFbbjqnGaUtUDOn2zG8+yOdXf0T/z?=
 =?us-ascii?Q?CAwUn8OKk45CKROoXOlGtBogW910sElagxMBo0S38l/FrMLng8YnjyUIdlBy?=
 =?us-ascii?Q?QdexRWX7AId+wJP5Tg3ytrKdjC0LMGwvp4rPpj3AAqzVHZa71BDrWm8TnW0y?=
 =?us-ascii?Q?idx5VwymzWx4LvVCYYOznJB6UFy3/vfjawH3xyTJ6ncABYElJyVfVpF/Ruif?=
 =?us-ascii?Q?zeSmmyU1cphkTEdsVmQmdWNugzJvrD3d5EzuS2FpquX5IxulOIChSCNCUxcH?=
 =?us-ascii?Q?THSvwa1zHU8dwWGqbAVIDGx4tD7rPwzGleAg1G3LKCcBmsfTlnZb9lJFThbw?=
 =?us-ascii?Q?5Y2Ue2Sd9k5ZN7sWctmg6iEsAwnp0l8ANfbfW1EyAZPUoscOTw0KF17qQMNs?=
 =?us-ascii?Q?+PZG8cyj1uOcJRKANbChaGVUMu2iEbflC4mIRnBoBju4WiWQpbjUjhNhH/ai?=
 =?us-ascii?Q?YyYRd54sGB/Ce5YnOrIw5gnPmSyI5okvjAVHM2qrXg5nDGD9qKk4lz9HGvpe?=
 =?us-ascii?Q?LPFvKyHNBexawYmgYspKHofbVxrXKixFpq6aRK1CWKlYmNbU3Sarq00VZx2g?=
 =?us-ascii?Q?isDuWVH0oKfFwTX5Z7z0/gqYaWLpfCirRCSY4dVOVjw2R6lzIVn38edWm8+h?=
 =?us-ascii?Q?3SgbmxcUd4f6kPX8/dXRJ74gm98GIA3MznMvwrvEG/F4y6JJtE988cH/Dxso?=
 =?us-ascii?Q?KN6nglztwxPNFCqSNyRaX4yB1UteL7D+svo8Ni30DmxjBOrXjya4yrJzx50k?=
 =?us-ascii?Q?3T8mL1vErwlxyUVlvCGiXM/FJByesmS+k4zmw//BAg6MTKBN4kH/Gj0BPFfm?=
 =?us-ascii?Q?OxrjwvDbhEEUexC2mkkK3XZs8C9HnRmhQE4nvzQMYmiXhVsBBFHj7NLsvN+Q?=
 =?us-ascii?Q?r1YoQD4QL3jENQLe8DNBGyYoOSjSA3RH8fxXX3cciBREQtaiFFFolg+5Er58?=
 =?us-ascii?Q?+orsXpohSWLMxn0cR/eZJiO5GUWwS+HTySlpsFjocjuTUW5LverMAovAz2te?=
 =?us-ascii?Q?X7WY1rbt8CFHQSzN48Bjt3beBsTUxETceNjeuwR7T7J/Mbuvs/nrJeL22SHE?=
 =?us-ascii?Q?W7sCCbY6BMAWRmG5VL/vGrx5ZUF9JAMKoPWxPgQ2znCeYOGVc+n5i58DGW5L?=
 =?us-ascii?Q?r3CLyK83plSWLEfrSmORS5Tnl2edQlD3oHQ+60y+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f99f559d-3275-4f3d-f4e8-08dc5ba8abdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2024 10:58:37.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHDZHv9hHPGWtI4s85pNrCBPWrZNMu0srAqd1gEz/1NiwfHBn5hoY+TMkH5SjnQ4LuAu+qfN1tr4hsmktRLFXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3612
X-Proofpoint-ORIG-GUID: P85UyrpDS8OKgA7Pqu3yLkm6NmaJTKNP
X-Proofpoint-GUID: P85UyrpDS8OKgA7Pqu3yLkm6NmaJTKNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_02,2024-04-09_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, April 13, 2024 11:18 AM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org; Jerin Jacob
> <jerinj@marvell.com>
> Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> Octeon CN10K DPI administrative driver
>=20
> On Fri, Apr 12, 2024 at 04:19:58PM +0000, Vamsi Krishna Attunuru wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Friday, April 12, 2024 9:05 PM
> > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > > Octeon CN10K DPI administrative driver
> > >
> > > On Fri, Apr 12, 2024 at 01:56:36PM +0000, Vamsi Krishna Attunuru wrot=
e:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > Sent: Friday, April 12, 2024 5:57 PM
> > > > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > > > Subject: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > > > > Octeon CN10K DPI administrative driver
> > > > >
> > > > > Prioritize security for external emails: Confirm sender and
> > > > > content safety before clicking links or opening attachments
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > ----
> > > > > -- On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru wrote=
:
> > > > > > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's
> > > > > > physical function which initializes DPI DMA hardware's global
> > > > > > configuration and enables hardware mailbox channels between
> > > > > > physical function (PF) and it's virtual functions (VF). VF
> > > > > > device drivers (User space drivers) use this hw mailbox to
> > > > > > communicate any required device configuration on it's respectiv=
e
> VF device.
> > > > > > Accordingly, this DPI PF driver provisions the VF device resour=
ces.
> > > > > >
> > > > > > At the hardware level, the DPI physical function (PF) acts as
> > > > > > a management interface to setup the VF device resources, VF
> > > > > > devices are only provisioned to handle or control the actual
> > > > > > DMA Engine's data transfer
> > > > > capabilities.
> > > > >
> > > > > No pointer to the userspace code that uses this?  Why not?  How
> > > > > are we supposed to be able to review this?
> > > >
> > > > Userspace code will use two functionalities (mailbox & ioctl) from
> > > > this driver. DPDK DMA driver uses the mailbox and the dpdk
> > > > application uses the ioctl to setup the device attributes. We are
> > > > waiting for this kernel driver get merged  to update the
> > > > corresponding support in DPDK
> > > driver and applications. I will provide the pointers to both the use
> > > cases in userspace code.
> > > > Meanwhile below is the current dpdk dma driver that uses sysfs
> > > > based scheme to convey mbox requests to the kernel DPI driver
> > > > which gets
> > > replaced with hardware mailbox scheme once mrvl-cn10k-dpi kernel
> > > driver is merged.
> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > > 3A__github.com_DPDK_d
> > > > pdk_blob_main_drivers_common_cnxk_roc-
> > > 5Fdpi.c&d=3DDwIBAg&c=3DnKjWec2b6R0mO
> > > >
> > >
> yPaz7xtfQ&r=3DWllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m=3Do3EhoL
> > > s7dsod
> > > > -YHS438Wl2Pf_MKMBYegGSKteoX3qFTB0HV897ykpCVbTp-
> > > nmj4e&s=3DA6TJDFUtPm3ksJh
> > > > qop89CL8GgKj4sjkJIVi1-RdnUr8&e=3D
> > >
> > > So this is a DPDK thing?  Ugh, do the networking people know about th=
is?
> > > If not, why aren't they reviewing this?
> >
> > Actually, It's not networking related. Like the Linux kernel, DPDK
> > also supports multiple subsystems like network, scheduler, DMA,
> > mempool etc. Regarding the usecases, the DPDK Marvell DMA/DPI VF
> > driver interacts(over hardware mailbox) with the mrvl-cn10k-dpi misc
> kernel driver(administrative driver) for setting up the VF device resourc=
es.
>=20
> So this is something that the PCI core should be concerned about then?

No, it's a normal PCIe sriov capability implemented in all sriov capable PC=
Ie devices.
Our PF device aka this driver in kernel space service mailbox requests from=
 userspace
applications via VF devices. For instance, DPI VF device from user space wr=
ites into
mailbox registers and the DPI hardware triggers an interrupt to DPI PF devi=
ce.
Upon PF interrupt, this driver services the mailbox requests.

>=20
> > DPDK is one example that uses this driver, there can be other
> > userspace generic frameworks/applications where the virtual functions
> > are binded to userspace drivers and interact with physical/administrati=
ve
> function driver running in the kernel.
>=20
> Are there other devices/drivers that do this today in Linux?  Why make a
> device-specific api for this common functionality?

The apis defined in this driver are specific to Marvell DPI hardware. For i=
nstance,
the variables molr(max outstanding load requests), fifo_max, ebus_port are
DPI hardware specific. Generally, drivers use driver-specific api to config=
ure
any device-specific configuration which does not fit in common functionalit=
y right.

Mailbox operations like dpi_queue_open & close are requests sent from VF de=
vice
to PF device for setting up the VF queue resources.

>=20
> thanks,
>=20
> greg k-h

