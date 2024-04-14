Return-Path: <linux-kernel+bounces-144138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC738A424B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A7F1F2177B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D21DFED;
	Sun, 14 Apr 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="DG6FxUK0"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E982903
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713097947; cv=fail; b=Gsr2EV3lznN93ZtWEESGQorrLfvhiQjzkBjQ7rE255BJDJsNLSsKLh0BojOaSGpASMqH4neyNkvBn1UkiSpv08tbVb1mgxiYVDXn0zdjBHP+7VDUQdWZEKmyQTRculUup0Mo0s+WFeJ2Ex6SZdb6d749cLnOicgTWosdQUM8wGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713097947; c=relaxed/simple;
	bh=0tBCV34YpAVVU/ENej1yqvvjejS8wdV4+C9DAJAWozk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aX+emEJvskluhoGw0HDqknEjZ1LSIYdx5COs17gWf1FbklUF7bIXVGt4PpWdRCA83UfK5/5cpFcFmNvM96Ns4yx0SETiDjurmbdDM/jUkIe/5/u4sx141u4rAFRetV28iEwvpwQJ67MP3iov7srgNutIVHjIrVKvCYDCnGtISmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=DG6FxUK0; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EBhsx9014793;
	Sun, 14 Apr 2024 05:32:21 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xfsjg1x38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 05:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN3rPE3W+w8pv3BxF8k1tHbxBhk1K47TG5Fe9RYdiX8N2d6rvvzkRFPY0DBIsIyb1vGpccHB56r0+v9pNTNmulnW26QNS8EkRzzgstoiaVkWGZ6nf8w2TX3fbizXYZ2pWRWEOuKxnK9GEAXh7neGRH3Xd+4Yz4jWx0pq2YedDWevYS1SKPcb45fl5rV6IF/WbV8Ksx1145tmlLidK2DHZL0DJAWNk3hzeldDOgSuUjeCrY86U71wtOHpCSBTos8W4SuZl5016nAmtFHbOUfzMBuu6JW56JfaFjnGprQALs/qqWlKVdWnyjDkQD8+UiEBoKlndCXqMZHjdXfhaNSDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wfu3OyofDdzrj/Mu3CUHaQ4BjEHZ6MsPlnxoph3sats=;
 b=EHgtV+8oXWWvckMFPhFOnEM2q+ueiSmSXLdBbSFoL2Od/FOSom77kW3QDOffaZ9b0xFBlzkZRi++O5lofTjg0PjKkqzNBYXVMhDcH/K7rJaAHW23PLIzmxlOFIS0bm7GbwDNnzqblRaMq9cMvwtvJmqhyowz2HEutxL6/lXAhIYJHEHERoTlA3jqlNLr7U+kn+ys4vwZ4iHNFHxhq/brkB6SBWXz4/GHE2D80L1aaS0Z1U/7nwCY2nbIiB8UjlmZBf5PIbdg9qinE2RM0oyeEY11r9E4ES/2V+J0snzR9DpAV0V5SQa8tTPmIC0BPfyRZNUBR9eMNBMzjlcaboPvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfu3OyofDdzrj/Mu3CUHaQ4BjEHZ6MsPlnxoph3sats=;
 b=DG6FxUK0/3/Os8lE+3kPnMtCNStd6QiW7O1HKtVFb8JvTO5a9FFV/xoxnU1oXQ9+6YOR/QiFcNBvxCM3DLcxdOOBvwsVphHA0CPMLYgP7g7bDGPMks8NxLRO5cZKN+pDwY+gvKNgDZ5jWvNERbGPWaMTKus5HOpui6LCSoEe6EU=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by BN9PR18MB4155.namprd18.prod.outlook.com (2603:10b6:408:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Sun, 14 Apr
 2024 12:32:18 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7452.041; Sun, 14 Apr 2024
 12:32:18 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: 
 AQHajNJlUzRgj48oqke7eNtbl1jogrFkj7+AgAAOmwCAACXXAIAAAZzAgADsugCAAFXs8IAACFkAgABEXHCAAD3qAIAA7f3AgAAGhoCAACgGIA==
Date: Sun, 14 Apr 2024 12:32:18 +0000
Message-ID: 
 <MW4PR18MB524447305F8F49847D88A6E2A60A2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041258-reminder-widely-00c0@gregkh>
 <MW4PR18MB52447D1E7F0CD0D1CA6BAACCA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041351-endowment-underrate-4b8d@gregkh>
 <MW4PR18MB52449EBFE3862D7C3065D22AA60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041310-bundle-patio-8a22@gregkh>
 <MW4PR18MB5244807D8DE91CA01EEB91B5A60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <b5d400e6-9e4a-4f5d-b48f-a75c65ec1ae8@app.fastmail.com>
 <MW4PR18MB52449BD843670B347C0383EDA60A2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041458-directory-image-6a0c@gregkh>
In-Reply-To: <2024041458-directory-image-6a0c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|BN9PR18MB4155:EE_
x-ms-office365-filtering-correlation-id: 4f3b7fe7-80a4-449c-cbbe-08dc5c7eec69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mY0lBkqI+w/U2SzHOjbt6VL+csFMe+Tibts8qQ2lMgAohjqbPto2rWL5pS0hy0K2xAZNPs2U2ocZit1fivNNpGAnr8/byUvdXyXvUt4ffYYBl7XnCVG67qsarTAJ7vcLkYRtlStgfg8aJgf14GK5D6/2fFJrP10A9t1fiFiLa5haIj/ks+0tr5rnF+wEtqk5iH9m0ExWkLn35cLW1GRAaDYF/kwV//YasBc+Px9WwWN75M8M2k8MSV1usprm6u3Sk50L5DFmDyzs15m14rAccSYpwsr8RCvWfW7Kz2qwjLfN5zmrQVMo2h+muMJ9Sj1vLggZU3Bttu4mWxR/+No87u/wMcvBH1G5wGwo2SUXTo7RojYF6iysRCvwiKjNDZSrZqR5J7zfnBntLvvSzO7tz5oO48Ql8dYFxpp9scLslsPPp2Pzv3lth9tP8KkyaSldw7RCcacxDJG4NxGMVOijFZzcT4RhRHpuWY8+jyRXVI8dVEsd3f53UOdqCMy/WFiWgRX2kPgKOwlJpWRyfv8QTOIATc/vPIX12ue/zFX8qb+BiYJsGi2BR54YUQhjQlRpu5ljt9zrnWfpJFOVSGfziVC6QsA5sciWM2zFjPVBHBFSDpQr5Ibh5WoUBx46WTKvbf9ZPrqpkl+bWI9ObVIZwQFjhCN3AYwHM6RegFgkAzerZlvjSJjT4UhS6wheHP4KqBtvrlnD9XGaoWh7uIA7xR/70SIQu0B7TJUGrteDt5U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SVdTnGHvMBv17s4nL8JkBUnRwfzduHjWT9FFrJtwX+wnPfaq/YYbaotWNEvg?=
 =?us-ascii?Q?ypwHtF95FsxiIoCG7aLgzX/evmaMZwxBSfw2p+65geW+++xwUpU29oCfmk/n?=
 =?us-ascii?Q?UfJI9hAooNzyWqmkPVlraEp6JweCB+M2DMYjqaJZd+/btsyUkqZQinvC7Dko?=
 =?us-ascii?Q?np2h37I5xJS/Xg4M5kfs67wcqMIpmjioa9XApOzQDUT89adetyV4cjwc0UwB?=
 =?us-ascii?Q?cuITb63vJSZ5fNZbkmcX6NBpptACVVTrvl8EKoAoLHRr5vC/WXE8lOe5IOGt?=
 =?us-ascii?Q?PSfbDsVKWDukjWGWayyQMDkqujPFWc5PtGnMfHTVaVdrDntQLmtYd5Aj9dVO?=
 =?us-ascii?Q?dcF+PcGnL9M4AyTYjf4WQl1aq7UdwzdqaGMfl40D8sI20SZ3O9+GS/vHsIPD?=
 =?us-ascii?Q?ccQwLjr9eT0iU8KTH3MpUrrIcSAMOeCCW4OuomxGAEMlXtmUhVJIhABfiPvb?=
 =?us-ascii?Q?rtfP+QdFmtZF9kQVqQC4MdCUtxjkx3ZfRxcLQYwLDe/v92nQ9EqB2EI/9k0R?=
 =?us-ascii?Q?GUGbJcCXhiERyqRPNTvTtYLgeNH/IWMuAP0pfd6iKvaqGDZUe0zMg+eFnRBU?=
 =?us-ascii?Q?9OEq40tNOC+tNMcvW4JtG6xT61k41H2FjZJ1MJvND4vG68iqef2ygM+J0JGw?=
 =?us-ascii?Q?FEqAUMWtt4GaCBD1O9sOtxJrSNaXxjNHUPwyYzPe2lTDOaDuD07EQtMlPJRZ?=
 =?us-ascii?Q?m28Ad79MnKgAEd9yBEqxYtAT30zsoWpaXlmBdXXrAVsxiGMcULImkzoEI8gj?=
 =?us-ascii?Q?fvq14RkvwLJD7N1QU1lOTnWXcjflBq+0QRzAHPrZbKWI6jpufGmtBcce/A2P?=
 =?us-ascii?Q?SYkXAQ5LlaCYbGmP2oUc7AgEGKz8rg3E8vI6N3CZ+i5Zg4Qmh0nGus8mnNYM?=
 =?us-ascii?Q?/T/+RsHdUcjVK19FYJSRdjqFE6TbQtuvXDSK+qXxMtWXSEBZaeZjl/EG603x?=
 =?us-ascii?Q?y2fywJPo8HSoDaDo/AgkrgAoUMaxlJReR2LanjKiuoZ4cfnDQ7KeR5Te60hS?=
 =?us-ascii?Q?9y53nAf3/8Nhd1k+L6/Ys9SGjYRy+CJ3Fs1H+/ubcobYZVIlPUjK4oqp812G?=
 =?us-ascii?Q?uadqLyFmCIkbpTTS2mrqfSbBzjR+f/VkUiF7+PPh0IuDRhUkHNedPVZJgkvv?=
 =?us-ascii?Q?jSG31Kkv8D18UW/BYRgjnqpJrbXEihtj5jrXP5SnRgRrkdFtag6Pe8/tLGuM?=
 =?us-ascii?Q?Ky4m5NZKdoiF9tOPlMzQ46NqAIJDJMc+YVJSjUbbMWRgDSADDKE3RgfFHfwb?=
 =?us-ascii?Q?8XZZh6b47mtAZqn6Hgzgn0sFAHIKQn8Y1OLEtIMmFFS1HiAKfkIjKEFrm4zq?=
 =?us-ascii?Q?BiuomkfG4zV9H6lM02M8tSlPSlBI8Xa3iJBUcCjqilndNfPPY8Ab8PUEHF3+?=
 =?us-ascii?Q?58XJHqvqhSnKPF78fPL6CPLF0LFBBQFO70a8ovUaP/k/Ixztkixvl1XURb8Y?=
 =?us-ascii?Q?WIUMd3ryWqVJakEgmqzeZ2hII2AZdCCZmlX9V1N7URLRbu66Knv8tsC7EnQL?=
 =?us-ascii?Q?XK0lg7JnNp29VaHWP77+fMyiDZQwJkLzW+oRMcg8F0dnLUllt+E8d4jNiFOs?=
 =?us-ascii?Q?oGXKmCmfPBWrIdit+v20cpvbUtRO59j63ts60c1q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3b7fe7-80a4-449c-cbbe-08dc5c7eec69
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 12:32:18.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJmKMhtGFvNBUYSFblIhfcIcC+oKCIi9ZqmRKPpL88EnO+HIgZ8V7gX+bq7l0CzCFbwYQ3v6cLGpC4UKOA/8LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4155
X-Proofpoint-GUID: BCIrAFVwTmKVd8xrpwh_drS--PH5ZprT
X-Proofpoint-ORIG-GUID: BCIrAFVwTmKVd8xrpwh_drS--PH5ZprT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_02,2024-04-09_01,2023-05-22_02



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Sunday, April 14, 2024 3:16 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel@vger.kernel.org; Jerin
> Jacob <jerinj@marvell.com>
> Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> Octeon CN10K DPI administrative driver
>=20
> On Sun, Apr 14, 2024 at 09:33:37AM +0000, Vamsi Krishna Attunuru wrote:
> >
> >
> > > -----Original Message-----
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > Sent: Sunday, April 14, 2024 12:41 AM
> > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg
> > > Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-kernel@vger.kernel.org; Jerin Jacob <jerinj@marvell.com>
> > > Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > > Octeon CN10K DPI administrative driver
> > >
> > > On Sat, Apr 13, 2024, at 18:17, Vamsi Krishna Attunuru wrote:
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > >> On Sat, Apr 13, 2024 at 10:58:37AM +0000, Vamsi Krishna Attunuru
> wrote:
> > > >> > From: Greg KH <gregkh@linuxfoundation.org>
> > > >> >
> > > >> > No, it's a normal PCIe sriov capability implemented in all
> > > >> > sriov capable PCIe
> > > >> devices.
> > > >> > Our PF device aka this driver in kernel space service mailbox
> > > >> > requests from userspace applications via VF devices. For
> > > >> > instance, DPI VF device from user space writes into mailbox
> > > >> > registers and the DPI hardware
> > > >> triggers an interrupt to DPI PF device.
> > > >> > Upon PF interrupt, this driver services the mailbox requests.
> > > >>
> > > >> Isn't that a "normal" PCI thing?  How is this different from
> > > >> other devices that have VF?
> > > >
> > > > Looks like there is a lot of confusion for this device. Let me
> > > > explain There are two aspects for this DPI PF device.
> > > > a) It's a PCIe device so it is "using" some of the PCI services
> > > > provided PCIe HW or PCI subsystem
> > > > b) It is "providing" non PCIe service(DPI HW administrative
> > > > function) by using (a) Let me enumerate PF device operations with
> above aspects.
> > > > 1) Means to create VF(s) from PF. It's category (a) service and
> > > > driver uses API (pci_sriov_configure_simple()) from PCI subsystem
> > > > to implement it.
> > > > 2) Means to get the interrupt(mailbox or any device specific
> > > > interrupt). It's category (a) service and driver uses API
> > > > (pci_alloc_irq_vectors()) from PCI subsystem to implement it.
> > > > 3) Means to get the mailbox content from VF by using (2). It's
> > > > category
> > > > (b) service. This service is not part of PCI specification.
> > > > DPI PF device has the mailbox registers(DPI_MBOX_PF_VF_DATA
> > > registers)
> > > > in its PCIe BAR space which are device specific.
> > > > 4) Upon receiving DPI HW administrative function mailbox request,
> > > > service it. Its category (b) service. This service is not part of
> > > > PCI specification.
> > > > For instance, dpi_queue_open & close are requests sent from DPI VF
> > > > device to DPI PF device for setting up the DPI VF queue resources.
> > > > Once its setup by DPI PF, then DPI VF device can use these queues.
> > > > These queues are not part of PCIe specification. These queues are
> > > > used for making DMA by DPI VF device/driver.
> > >
> > > It's not directly my area either, but as far as I can tell from
> > > reading the competing sr-iov based device drivers, these seem to
> > > handle all of the above in the network driver that owns the PF
> > > rather than a separate driver, e.g. for the first point:
> > >
> > > $ git grep -w sriov_configure.=3D drivers/net/
> > > drivers/net/ethernet/amazon/ena/ena_netdev.c:   .sriov_configure =3D
> > > pci_sriov_configure_simple,
> > > drivers/net/ethernet/amd/pds_core/main.c:       .sriov_configure =3D
> > > pdsc_sriov_configure,
> > > drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:
> .sriov_configure =3D
> > > bnx2x_sriov_configure,
> > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:      .sriov_configure =3D
> > > bnxt_sriov_configure,
> > > drivers/net/ethernet/cavium/liquidio/lio_main.c:        .sriov_config=
ure =3D
> > > liquidio_enable_sriov,
> > > drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:        .sriov_config=
ure =3D
> > > cxgb4_iov_configure,
> > > drivers/net/ethernet/emulex/benet/be_main.c:    .sriov_configure =3D
> > > be_pci_sriov_configure,
> > > drivers/net/ethernet/freescale/enetc/enetc_pf.c:        .sriov_config=
ure =3D
> > > enetc_sriov_configure,
> > > drivers/net/ethernet/fungible/funeth/funeth_main.c:     .sriov_config=
ure
> =3D
> > > funeth_sriov_configure,
> > > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:        .sriov_config=
ure =3D
> > > hns3_pci_sriov_configure,
> > > drivers/net/ethernet/huawei/hinic/hinic_main.c: .sriov_configure =3D
> > > hinic_pci_sriov_configure,
> > > drivers/net/ethernet/intel/fm10k/fm10k_pci.c:   .sriov_configure     =
   =3D
> > > fm10k_iov_configure,
> > > drivers/net/ethernet/intel/i40e/i40e_main.c:    .sriov_configure =3D
> > > i40e_pci_sriov_configure,
> > > drivers/net/ethernet/intel/ice/ice_main.c:      .sriov_configure =3D
> > > ice_sriov_configure,
> > > drivers/net/ethernet/intel/idpf/idpf_main.c:    .sriov_configure     =
   =3D
> > > idpf_sriov_configure,
> > > drivers/net/ethernet/intel/igb/igb_main.c:      .sriov_configure =3D
> > > igb_pci_sriov_configure,
> > > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:  .sriov_configure =3D
> > > ixgbe_pci_sriov_configure,
> > > drivers/net/ethernet/marvell/octeon_ep/octep_main.c:
> .sriov_configure =3D
> > > octep_sriov_configure,
> > > drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:   .sriov_config=
ure
> =3D
> > > otx2_sriov_configure
> > > drivers/net/ethernet/netronome/nfp/nfp_main.c:  .sriov_configure
> =3D
> > > nfp_pcie_sriov_configure,
> > > drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c:    .sriov_config=
ure
> =3D
> > > ionic_sriov_configure,
> > > drivers/net/ethernet/qlogic/qede/qede_main.c:   .sriov_configure =3D
> > > qede_sriov_configure,
> > > drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:       .sriov_config=
ure =3D
> > > qlcnic_pci_sriov_configure,
> > > drivers/net/ethernet/sfc/ef10.c:        .sriov_configure =3D
> > > efx_ef10_sriov_configure,
> > > drivers/net/ethernet/sfc/ef100.c:       .sriov_configure =3D
> > > ef100_pci_sriov_configure,
> > > drivers/net/ethernet/sfc/ef100_nic.c:   .sriov_configure =3D
> > > IS_ENABLED(CONFIG_SFC_SRIOV) ?
> > > drivers/net/ethernet/sfc/efx.c: .sriov_configure =3D
> efx_pci_sriov_configure,
> > > drivers/net/ethernet/sfc/siena/efx.c:   .sriov_configure =3D
> > > efx_pci_sriov_configure,
> > > drivers/net/ethernet/sfc/siena/siena.c: .sriov_configure =3D
> > > efx_siena_sriov_configure,
> > >
> > > In what way is your hardware different from all the others?
> >
> > All of above devices are network devices which implements struct
> net_device_ops.
> > i.e Those PCI devices are networking devices which are capable of
> sending/receiving network packets.
> > This device doesn't have networking functionality to implement struct
> > net_device_ops, It's a simple PCIe PF device enables it's VFs and servi=
ces
> any mailbox requests.
>=20
> What driver handles the "mailbox requests"?  What are these requests for?

I think, I have already mentioned this in the previous reply. Copying the s=
ame here. Please see (4) in [1].
The DPI PF driver(this driver) handles the mailbox request from DPI VF (a u=
serspace driver implemented using vfio uapis).

DPI PF driver(this driver) does not fit to any of the device class(ethernet=
, crypto, dma..) in linux kernel hence making it=20
as misc device driver. Standard device class always will have standard devi=
ce function. For example,
ethernet device to send/receive ethernet frames, crypto device to enable cr=
ypto transformations,
dma device to enable copying data from source to destination memory.

Now, Why HW designers choose to have DPI(DMA Engine) PF device in first pla=
ce?

a) DPI VF(not DPI PF) device has capability to do the DMA (copying data fro=
m source to destination memory).
b) In order to do DMA, DPI VF device needs a DPI queue.=20
c) Now here is the catch, when VF device starts, it does not have its queue=
s configured. So, DPI VF device/driver
asks(via mailbox) DPI PF(this driver) for the queue setup with required con=
figuration. dpi_queue_open() does the same.
d) Now you may ask, why VF device does NOT configure its queues on its own.=
 That is HW resources
provision optimization(introduced by HW designers), where DMA engines are p=
rovisioned across the VF device queues.
So, PF (administrative)  arbitrates the request from different VF devices v=
ia mailbox and allow to configure _global_ resources
which does not belong to VF.

Hope it clarifies.

[1]
------------------------------
Looks like there is a lot of confusion for this device. Let me explain

There are two aspects for this DPI PF device.

a) It's a PCIe device so it is "using" some of the PCI services provided PC=
Ie HW or PCI subsystem
b) It is "providing" non PCIe service(DPI HW administrative function) by us=
ing (a)

Let me enumerate PF device operations with above aspects.

1) Means to create VF(s) from PF. It's category (a) service and driver uses=
 API (pci_sriov_configure_simple()) from PCI subsystem to implement it.
2) Means to get the interrupt(mailbox or any device specific interrupt). It=
's category (a) service and driver uses API (pci_alloc_irq_vectors()) from =
PCI subsystem to implement it.
3) Means to get the mailbox content from VF by using (2). It's category (b)=
 service. This service is not part of PCI specification.
DPI PF device has the mailbox registers(DPI_MBOX_PF_VF_DATA registers) in i=
ts PCIe BAR space which are device specific.
4) Upon receiving DPI HW administrative function mailbox request, service i=
t. Its category (b) service. This service is not part of PCI specification.
For instance, dpi_queue_open & close are requests sent from DPI VF device t=
o DPI PF device for setting up the DPI VF queue resources. Once its setup b=
y DPI PF,
then DPI VF device can use these queues. These queues are not part of PCIe =
specification. These queues are used for making DMA by DPI VF device/driver=
.

-------------------------------
>=20
> thanks,
>=20
> greg k-h

