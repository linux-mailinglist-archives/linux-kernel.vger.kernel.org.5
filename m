Return-Path: <linux-kernel+bounces-144076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B68A418A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 589AAB21433
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675222F17;
	Sun, 14 Apr 2024 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="dJz+sC6j"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C417736
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713087228; cv=fail; b=WazWneB8KYtqHqojPgDt3aZaBxN5Ogqwvp8jE63EBjSTmuIepigNc/I1bulwLQwicCTZzC1H2f6z3fzvqShqePQxCVUZRDXjyMTrE4s34/V2w+yyHjkVsNyO8tEwYICPIVZT8sOeyQDhxSNx6BVmWf79I8ZCPksKT6dyRUmIL9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713087228; c=relaxed/simple;
	bh=vK2Ub+IyPqaSr9JUZmG0JkCuczreA1v3+HU2ziCoB2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qda4LGnDh9YXb6OIKpJRHuiT0E/YJtNhlP++/IHRaiHQKSx4Bi+XiKarXLMzqtPfP+7/w56pEzcoi3+sETYhuhQXAO6RNjAtvgYo5KsuyQcDZPdHK0XT9FWU8dipAxfX1kF3lIGrw073EHsh4YhJDqIzvHFY6LCJ3akCtuo/Vpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=dJz+sC6j; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43E8FhYq007833;
	Sun, 14 Apr 2024 02:33:43 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xfsjg1q4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 02:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8x0hv5JvAcQyTrbYvpuZjdqkcLx0v7poZVVxNCdm5OkmyOXXzbRdXbhnOocrGJ2/bOWGO4TVr2KnrxhPN3X1eJkldusLU+v6bcRbijQBjNyVwPR20qdlqojDTBgOoUK8EGFUyVWSvCe8UdJpbpVNB6h1cd/+vCrQhEP+nWCWHOIBUuZst10EtHyfQav3ugcbLHGTvH526pEeZrRmF9m0H5vIyffjJ0Ant6X3I400ctI0Mle4GK0xvrLJuut1J3t1bgyqdl08/COAbit3iF6KSoSFnCo8Y/WxgS5rgJnh3xW6tmVPTpB7sLXhTf23HYgFJBbnYKJ08m3a0fVK43zNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4xZu8jC1cXNnK0DPPVt37CcVccf2dsqKO8CJ5vA68k=;
 b=RyTskmIGF8ZHqw6vcMkpcQmv10WliS6/jPtDo7lj3yx4CIUBVJ1H/xHn9/asNzjbfIqUkKhOdF78Vt6AwjeT2c0teXju03u1ZYPGbb+Lc42D4tp/ZwnkiTfa7VF/xZTmMKn60OJNx/vBO6qxaAqU7wJ6dV2JVj11PledcaDOOlslIwOiTf9xUxaVMNb36VCQIYmKTxrrYqlVOLoMP53WJ9dbVU5QZeVJSRmgPQgF1r5Lx5aSbpCz+2e25yBg7WRQNaaCRzvSzZo9O3LPB+XxiEHHhtpWHuKj6h4umQBxf6hCCLsDQFK+xsX+74e8U4lg9RFKsTq4yzrMNijVKcndAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4xZu8jC1cXNnK0DPPVt37CcVccf2dsqKO8CJ5vA68k=;
 b=dJz+sC6jREQLqDz6tXRZ0ydIyd68jL70Xiar51IGbdgVgfRWo527qhd+IX1OuEKgzh5mOfpnQPpUjX6rTvTUgB+fMcweQZiLBvYqve3BcRlIRpBVPEtpXIxW8TormvT4fT0IeomfHAyQd84VkcPm1GQ5wt/jYEl8Nn/3aUFq44Y=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by DM4PR18MB5218.namprd18.prod.outlook.com (2603:10b6:8:51::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.49; Sun, 14 Apr 2024 09:33:37 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7452.041; Sun, 14 Apr 2024
 09:33:37 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerin Jacob
	<jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: 
 AQHajNJlUzRgj48oqke7eNtbl1jogrFkj7+AgAAOmwCAACXXAIAAAZzAgADsugCAAFXs8IAACFkAgABEXHCAAD3qAIAA7f3A
Date: Sun, 14 Apr 2024 09:33:37 +0000
Message-ID: 
 <MW4PR18MB52449BD843670B347C0383EDA60A2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041258-reminder-widely-00c0@gregkh>
 <MW4PR18MB52447D1E7F0CD0D1CA6BAACCA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041351-endowment-underrate-4b8d@gregkh>
 <MW4PR18MB52449EBFE3862D7C3065D22AA60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041310-bundle-patio-8a22@gregkh>
 <MW4PR18MB5244807D8DE91CA01EEB91B5A60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <b5d400e6-9e4a-4f5d-b48f-a75c65ec1ae8@app.fastmail.com>
In-Reply-To: <b5d400e6-9e4a-4f5d-b48f-a75c65ec1ae8@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|DM4PR18MB5218:EE_
x-ms-office365-filtering-correlation-id: e89c78dd-2083-43dc-2300-08dc5c65f650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jEiUY78DXE687ZaEWm9zUbUpwjgonH5Gxmn6Y/A3iaaqXz/8sjBpQHfNQ0fdU/GyvNCxDNpmQFaq/5EOdBuJwMYxlcr9/zr/wdp4+VKW4o7CcO8InNhRf9Vz5qM6fU28z2PwFvZlge3+xHWNsjDhJKmJFUfK40HYxHh96+g89z42C3n2XCa9fIJdtMrzmzkSnRLENFIuUohu0wPp1woURlWIufk8ZyQDu9OJCsLCSueDhllW8KPQTYGtDXwOY87jzDabwozxUSZMNGdVl9WgOoqpUKKq6/EO4F14L1cLki9ktyzEjBlZ40pz/OXWwwtUlSVkuxoNuNWfoSLJ5CgxnLPH2SZOM7nxerwJFUHmNakIZCRar3hPtOr5u+m5g3SvN3dc1oIxwEYQ5IRV6r0fCjWRlUq1CUBWXBjjovuPHp2NNbBqX6FIYr6ZyNwUbOVPwUk3cClKO4/IPJ1hW6+idn1dqtAKcNxXpramiBbC4thcag9gYDrXj5+vDt/ddp2p+NMbT8s+kzDR6pMz/qSPKNmTtegjME6T3fW6BIKKbgge9yGVgtKXaMRSjcm+bZt1fgwojgBC8CpfgCuxg3sgrkKU/VRF8/Lpx1Uw99yY3RudfOIe9Js35+EntJAiwr/YwK4oqHvF9LqTQrQhCe7GzjAGiizTI9zDdzEvMybPLx5TXXKU/+r8GP1B5p3UB113YrLAn0wOAfKdoFO8X62qWXDqRaDTHy+VBn/dApXj2BQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?xWD30PFludCr/T+zWqh9lkYC5hK7+svi7t+nLCVVKCtYpGW4T3YeblEn2Uw2?=
 =?us-ascii?Q?Y2WGaMxKIQ+Rm03RRTo81CmdXzTN5vfK+soeNbXRLlNY61hAur4zGtT/yenP?=
 =?us-ascii?Q?cNZ71geakPli8FCB5rxAAMzhN7jOBcVqbwOShMfY0wxWY3Jk1+b5rNJRCGdi?=
 =?us-ascii?Q?N+QKaVd9EPQQkLSi9o5hTR83Z7hBJKPLKvf0rP33eJerl6pyGI5NTX+AmP+0?=
 =?us-ascii?Q?dvGFB7JdxM+BilzQYfqiDr97ijR1LufFPQDnVLgoI69MTgg6FVSY33PzavIl?=
 =?us-ascii?Q?mz5bE6Pd8nmPbt881D8cVwv3pBenaE9pvaEezs5fD/ArwoMRiQKTNUE8QmTy?=
 =?us-ascii?Q?PUvlnRAkjg3f904wZSRr3cVvq3i2MHz9Atl86zGwzRpM+q13G3eGdfTfuf+9?=
 =?us-ascii?Q?V7vYva2GoANvstEdbEGF+ZS9zjdyCczbu6krkHUeB08FP/hApaGAqXG/vIff?=
 =?us-ascii?Q?uB5AXEnDk2SLzCY35If4wGxxTZ9r2BWuf7ScZ8BB+hNC/gs5tzGkgoM4wZ9w?=
 =?us-ascii?Q?V223APWpyBMB0X/GO4WGAS2OYmom76fKsGsQFRuYeXanjan6I1kVj2F0S+GK?=
 =?us-ascii?Q?jDha72/84XMPycZpTUkJ1Z0YDuQm2uSXLKZ2LfM1qzBV2C9OANyecLn6ehKB?=
 =?us-ascii?Q?ZXHsyNwsFl2x0Rj/F7ynOsHatwpddgB1oywXNKPJbMs8FqFX3hKeZjbB7RXD?=
 =?us-ascii?Q?o9TXKaM7g1BsnOUFVeGYDYsLAah0RLpcf+WY3eCQoXM5ZH+sg2sLVQDjrmgE?=
 =?us-ascii?Q?oD0Sy66KB91q27HuOXI/YdApyXZqhuo5Uvwgtg40jw3gZuITartcOLWXmRds?=
 =?us-ascii?Q?nE+EUktmcEbfakAytDaDNtGc2V7PVobfZfkhYKEZmmvqaEJLx+wOu2y2P1W1?=
 =?us-ascii?Q?eQ4fE4YGpe9uGmjKwdRJbDBXlvuQ8Jyf7s+u4xlNBmmDCS3ikLKnuzKingJO?=
 =?us-ascii?Q?lauF9ElvXlfSMdixGdJdLB+NwFtR/rrNkB9oLTu4QCtIMO8hVocJx2XtkWee?=
 =?us-ascii?Q?m8zEnw2168b1DDfBncj/XZbLpfXl//twXypW5Hd/nOdpAxfWqF8SbbraKY+N?=
 =?us-ascii?Q?nfYzEkddgPsNPZvx2fB8PCapAoSv4HGMAntahgq0O3AI90eqh+wgMTZdr2TF?=
 =?us-ascii?Q?6yNTvFfUnuhhQOBNuD43uq5lFAxejbmaK1Eyr+dK5nEYBTErY81r+jrQKsSU?=
 =?us-ascii?Q?Zq5y+ethOJo8qHsy4K0LZ8ZaweA5HS9b+c3vB56gqFF8ICSJmeIUf2LmyPph?=
 =?us-ascii?Q?mVkDs788VphEHI6sDxN9gVB9ZkifBkI5miNwBJJc7ZjhqVIguLwjPGJqoJqZ?=
 =?us-ascii?Q?+fslWn3Dbqo3Y2IzRk2Wfarn5KwxgGQbiYtQ4cqXiMuwgfvlPiJ+ZLdtVYGL?=
 =?us-ascii?Q?D5G0CqQrNyLLrsB75E3jYc+XqMKMcf5iNPb85QJTQIlr1yC9ppGd2SvNxl9p?=
 =?us-ascii?Q?hK/OautD9PSceDE0NIB0tYydK5Nfk8ksm7TMGmA/FerT1/YWdznMICW3ZFaL?=
 =?us-ascii?Q?QYN3H8Sgp5AHsiwx84fbfC/7hFLPFsboNUmvP28zCtfgld99IK1dR5pqSAZr?=
 =?us-ascii?Q?HxmwRjAHERIgCEE6S7LrkW6vuRaoea8iLiwnrZyj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e89c78dd-2083-43dc-2300-08dc5c65f650
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 09:33:37.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0atdbwAITd41I8PPkRebuIAuADPWm5Sv6ETjsONiuTZu8++5p8wL26SB2Cdv8iBH8Os51mGD5V9wqAXAFUUoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5218
X-Proofpoint-GUID: F7Ye7emXqAJQorch-QcjwL7JzLiR0qM5
X-Proofpoint-ORIG-GUID: F7Ye7emXqAJQorch-QcjwL7JzLiR0qM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_11,2024-04-09_01,2023-05-22_02



> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Sunday, April 14, 2024 12:41 AM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org; Jerin Jacob <jerinj@marvell.com>
> Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> Octeon CN10K DPI administrative driver
>=20
> On Sat, Apr 13, 2024, at 18:17, Vamsi Krishna Attunuru wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> >> On Sat, Apr 13, 2024 at 10:58:37AM +0000, Vamsi Krishna Attunuru wrote=
:
> >> > From: Greg KH <gregkh@linuxfoundation.org>
> >> >
> >> > No, it's a normal PCIe sriov capability implemented in all sriov
> >> > capable PCIe
> >> devices.
> >> > Our PF device aka this driver in kernel space service mailbox
> >> > requests from userspace applications via VF devices. For instance,
> >> > DPI VF device from user space writes into mailbox registers and the
> >> > DPI hardware
> >> triggers an interrupt to DPI PF device.
> >> > Upon PF interrupt, this driver services the mailbox requests.
> >>
> >> Isn't that a "normal" PCI thing?  How is this different from other
> >> devices that have VF?
> >
> > Looks like there is a lot of confusion for this device. Let me explain
> > There are two aspects for this DPI PF device.
> > a) It's a PCIe device so it is "using" some of the PCI services
> > provided PCIe HW or PCI subsystem
> > b) It is "providing" non PCIe service(DPI HW administrative function)
> > by using (a) Let me enumerate PF device operations with above aspects.
> > 1) Means to create VF(s) from PF. It's category (a) service and driver
> > uses API (pci_sriov_configure_simple()) from PCI subsystem to
> > implement it.
> > 2) Means to get the interrupt(mailbox or any device specific
> > interrupt). It's category (a) service and driver uses API
> > (pci_alloc_irq_vectors()) from PCI subsystem to implement it.
> > 3) Means to get the mailbox content from VF by using (2). It's
> > category
> > (b) service. This service is not part of PCI specification.
> > DPI PF device has the mailbox registers(DPI_MBOX_PF_VF_DATA
> registers)
> > in its PCIe BAR space which are device specific.
> > 4) Upon receiving DPI HW administrative function mailbox request,
> > service it. Its category (b) service. This service is not part of PCI
> > specification.
> > For instance, dpi_queue_open & close are requests sent from DPI VF
> > device to DPI PF device for setting up the DPI VF queue resources.
> > Once its setup by DPI PF, then DPI VF device can use these queues.
> > These queues are not part of PCIe specification. These queues are used
> > for making DMA by DPI VF device/driver.
>=20
> It's not directly my area either, but as far as I can tell from reading t=
he
> competing sr-iov based device drivers, these seem to handle all of the ab=
ove
> in the network driver that owns the PF rather than a separate driver, e.g=
 for
> the first point:
>=20
> $ git grep -w sriov_configure.=3D drivers/net/
> drivers/net/ethernet/amazon/ena/ena_netdev.c:   .sriov_configure =3D
> pci_sriov_configure_simple,
> drivers/net/ethernet/amd/pds_core/main.c:       .sriov_configure =3D
> pdsc_sriov_configure,
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:       .sriov_configure =
=3D
> bnx2x_sriov_configure,
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:      .sriov_configure =3D
> bnxt_sriov_configure,
> drivers/net/ethernet/cavium/liquidio/lio_main.c:        .sriov_configure =
=3D
> liquidio_enable_sriov,
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:        .sriov_configure =
=3D
> cxgb4_iov_configure,
> drivers/net/ethernet/emulex/benet/be_main.c:    .sriov_configure =3D
> be_pci_sriov_configure,
> drivers/net/ethernet/freescale/enetc/enetc_pf.c:        .sriov_configure =
=3D
> enetc_sriov_configure,
> drivers/net/ethernet/fungible/funeth/funeth_main.c:     .sriov_configure =
=3D
> funeth_sriov_configure,
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:        .sriov_configure =
=3D
> hns3_pci_sriov_configure,
> drivers/net/ethernet/huawei/hinic/hinic_main.c: .sriov_configure =3D
> hinic_pci_sriov_configure,
> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:   .sriov_configure        =
=3D
> fm10k_iov_configure,
> drivers/net/ethernet/intel/i40e/i40e_main.c:    .sriov_configure =3D
> i40e_pci_sriov_configure,
> drivers/net/ethernet/intel/ice/ice_main.c:      .sriov_configure =3D
> ice_sriov_configure,
> drivers/net/ethernet/intel/idpf/idpf_main.c:    .sriov_configure        =
=3D
> idpf_sriov_configure,
> drivers/net/ethernet/intel/igb/igb_main.c:      .sriov_configure =3D
> igb_pci_sriov_configure,
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:  .sriov_configure =3D
> ixgbe_pci_sriov_configure,
> drivers/net/ethernet/marvell/octeon_ep/octep_main.c:    .sriov_configure =
=3D
> octep_sriov_configure,
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:   .sriov_configure =
=3D
> otx2_sriov_configure
> drivers/net/ethernet/netronome/nfp/nfp_main.c:  .sriov_configure        =
=3D
> nfp_pcie_sriov_configure,
> drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c:    .sriov_configure =
=3D
> ionic_sriov_configure,
> drivers/net/ethernet/qlogic/qede/qede_main.c:   .sriov_configure =3D
> qede_sriov_configure,
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:       .sriov_configure =
=3D
> qlcnic_pci_sriov_configure,
> drivers/net/ethernet/sfc/ef10.c:        .sriov_configure =3D
> efx_ef10_sriov_configure,
> drivers/net/ethernet/sfc/ef100.c:       .sriov_configure =3D
> ef100_pci_sriov_configure,
> drivers/net/ethernet/sfc/ef100_nic.c:   .sriov_configure =3D
> IS_ENABLED(CONFIG_SFC_SRIOV) ?
> drivers/net/ethernet/sfc/efx.c: .sriov_configure =3D efx_pci_sriov_config=
ure,
> drivers/net/ethernet/sfc/siena/efx.c:   .sriov_configure =3D
> efx_pci_sriov_configure,
> drivers/net/ethernet/sfc/siena/siena.c: .sriov_configure =3D
> efx_siena_sriov_configure,
>=20
> In what way is your hardware different from all the others?

All of above devices are network devices which implements struct net_device=
_ops.
i.e Those PCI devices are networking devices which are capable of sending/r=
eceiving network packets.
This device doesn't have networking functionality to implement struct net_d=
evice_ops, It's a simple PCIe PF
device enables it's VFs and services any mailbox requests.

 Couple of misc pcie drivers that enable its VFs are

UPSTREAM/linux# grep -nr "sriov_configure" drivers/misc/
drivers/misc/genwqe/card_base.c:1327:static int genwqe_sriov_configure(stru=
ct pci_dev *dev, int numvfs)
drivers/misc/genwqe/card_base.c:1358:   .sriov_configure =3D genwqe_sriov_c=
onfigure,
drivers/misc/pci_endpoint_test.c:1011:  .sriov_configure =3D pci_sriov_conf=
igure_simple,

>=20
>      Arnd

