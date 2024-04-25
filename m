Return-Path: <linux-kernel+bounces-158022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA678B1A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E1D1F22E99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F23B791;
	Thu, 25 Apr 2024 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UULiWnmk"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7710D23CE;
	Thu, 25 Apr 2024 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022700; cv=fail; b=rmZjPx0sALWl+2JSQS/FQ7aMs9NelDumI/cdqd53WAi6iWomLz2R6F2d39GtroD0ba4ML/zFB69U80i4ELBWMndpTWfBxiuxUv1iNmgNRXzqXNNakqnSh+8uYjimJ4qa71I1hkleunmVCfPej9EQrLKlnns0QBjBSJUrcWJWwQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022700; c=relaxed/simple;
	bh=bb3cSF1jlNzysRRSdOU90gy11K5fC9rLL5PX91gbCW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OaYP8sRGGLyGfEfWgnt0vJAaTZmAXpLV8F1FAfQFEkP8EshFmh8VYo3Utsj+7LIZVQyNOk7JFSLG2HTkkgQmMH0TxK+a4VoVxYvL1EhbAlaz0g7xIyZASx6ipnvx5bCnRNoXuMxHpSRLcczZOBIL3UCrFIKz68yfQ77qsi6Hm4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UULiWnmk; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P3kP4o002258;
	Wed, 24 Apr 2024 22:24:49 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn1bwan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ0X/omLht1Z04sOfoJMolYLyB+PpiGfFZPWYf/Ra5iaw6xdLh1Yqw8fNALrFmFI81sA25yRJWg3ysFYTufNz0dONn49JA7Ixphk2ojdYHfcvvfASX2QkZvuOn1x0RDkiFRLeHKPA2Dcd9WuPhGjlGJlVbCblNP320098hHHz7RV4eZe6ZUmdokUQoQzyg6YERnS03YuCxFA6Y6yrZQChHFiyrnTadUabBJsJ9/vbQqTEn7FYAmG8RmFDR5lJ+ijuY+FTaor0j4Y+/ABxXzQd9wWEmjjESKLd7KSA6y6qnGo7lu2s+uuMQhAsZnbyNBoEdpDhFms7fXWvCHAqPfjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCgL8Ko/NCOkAiffQNML48C84YJtMz7pZo3L7gtsBWo=;
 b=k2VI4GnU3MCGoZlC61QFdW/MtL7dle+C/zcJoc1z9j28RLnzvW1XUK1gFyYM2q1obxm170eKzMu3Xx8+hfyuyPI62+uVq8evQFPVfLWIiTIerhI4vta4/FKxBKK54xutKuGLcJtMDTdGhZqciIyI52hKOxFtLz9Ol3mhoqOQS24xDreibzDOad8GrQofM3c1RoLnHH9WoR4aFMsJma/G01jNEANKQz8phkraKHw/tzD4gDgWO0xMQQQuufkbxJwPPPM//EhMCQTmQR6T0YPVy97+HGPF3BQSKH41DH2mVvD3mlNinWZYiufiM0Z2LwRG4hLRNMSA4aRCzpiz/ACWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCgL8Ko/NCOkAiffQNML48C84YJtMz7pZo3L7gtsBWo=;
 b=UULiWnmkRiRiYtSITlHeqrHeWS/3rJNpLnhKjdSQFKgi/og6R6VuG3PotBo4lWfGSvOjA2tUm50M6QsiB4A9gM0loQ98BuhsCXRjrbG/sQhke0uYA20ZqxCoxquWSBWj43Bpv94YxhLbd2+iKOUw5psJPmq8NdIgAguimI+Jl3A=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by CH3PR18MB5857.namprd18.prod.outlook.com (2603:10b6:610:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 05:24:47 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 05:24:47 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>,
        "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dongsheng Yang
	<dongsheng.yang.linux@gmail.com>
Subject: RE: [EXTERNAL] [PATCH 7/7] cbd: add related sysfs files in transport
 register
Thread-Topic: [EXTERNAL] [PATCH 7/7] cbd: add related sysfs files in transport
 register
Thread-Index: AQHalIXaD9AgiEKpPUChgALPnXDFErF4d/KA
Date: Thu, 25 Apr 2024 05:24:46 +0000
Message-ID: 
 <SN7PR18MB5314D1E502937E34BC5AC823E3172@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-8-dongsheng.yang@easystack.cn>
In-Reply-To: <20240422071606.52637-8-dongsheng.yang@easystack.cn>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|CH3PR18MB5857:EE_
x-ms-office365-filtering-correlation-id: c0855d36-d10c-4846-fcfb-08dc64e805ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?3UT1VCg3cMKJZWI50Q21thyV+HK1/9jc5vUbQNUmWeIKatzdmXkG6xnOeitQ?=
 =?us-ascii?Q?vJKX1ZUTjwyJW4J6890cHxS8sHzQ7cu9Xs0Z7KxnbrulsgE4J+O41rIxUqSp?=
 =?us-ascii?Q?+x47xjmzbeq0LYeuvp+MpXUygUKkHpzeb68/0rns7KWfQ0rbAzRGY6uPJBRt?=
 =?us-ascii?Q?nQzfQroygf1uEuQvJXQaxESN6lHkEs0O/J6Rsf3aKtT64mdT0fmsvmEoNinV?=
 =?us-ascii?Q?f6sk3g5CQ/KWQzHwG4ALm5XOPbAvXb0pMe/k9cJwohr7p442iEcbH+McYRIq?=
 =?us-ascii?Q?eBM8FNWxp/IQON6vHm7bXQ4886dOYKeeBr2sjKy0SpbVnC2LU1wQb7pRwB+a?=
 =?us-ascii?Q?nHC8CpnKUSawKxq4x2m/RVsJHUCf0HgzfNuRWLgl93tA1HCBrTfm1hOrSpoi?=
 =?us-ascii?Q?InkedMV/RTM/mEmzPBC5uDeHaov8fN8TunVX9p5GHb1zQwtM6i3Pp7M3ljaU?=
 =?us-ascii?Q?Nfkwe3JKHXkU02LRtJw04SR3Z01+i/cIU6LofYkDFy045Y+moCFEnSN18C4Z?=
 =?us-ascii?Q?TVEyl4pjk2MNr77vNqyVKYJoOerS6eHdjC0SRxfYbl8VGeUFw5jf2HI/4XlP?=
 =?us-ascii?Q?9JuWZ/Nq2EFksLB4D69fbJ7C9/6b97igeUx8SXnjgixCkYq3e37WCrdN0ZPu?=
 =?us-ascii?Q?6f4nfcrD6bubYUqFrCTrmGduV9pUXD4JGzmlffVJZAy7gsZ2/F2sDO5OqNrQ?=
 =?us-ascii?Q?OU0A33P/Q2bRBW0uxpM9aovY+3x5cJYnE9Lc1MIZZKz+1Sn0iU7CQvy6fVSN?=
 =?us-ascii?Q?a0VUb+B34qMPUFN23ewLm+VJL4kGARtsEbYkXre19IwwGaNv5LKgp2+x5KBb?=
 =?us-ascii?Q?2rOTAHZcqCXYKUGB9BBTQz/YtyP5+1MIR+M0O1VAEuAsr152Gw6e1K0/XDoV?=
 =?us-ascii?Q?xldFpD3cJnGC3pItinaDiTuyZODCZ8UOm+QBkoBlu1MHtx3MPmId7XEl0Ax2?=
 =?us-ascii?Q?7fQohDyvxjm7FDw765ejG7ysJg6t2Jgk9Nx9pbk47m7UxcgwS+saTMyVU4Gv?=
 =?us-ascii?Q?XLb2wLlnuy14jyno/vDcv8wVAiiGMsUPUY7k7y8bTt+iFI4OAQ3LV5MCwquB?=
 =?us-ascii?Q?htoxqOEu3f8IwDtOD1RysuOE+Elx+erm+noVUukSOY1KnCXK/3IqrZgWaOdZ?=
 =?us-ascii?Q?GUrdy+42DYZSI+2mOnnEEcaRAdXB0fO6TfSadJdCPFuWl3p9dpWCGoeJccrC?=
 =?us-ascii?Q?DSzrn5VdKLOEDdOhQtm/yDkYV+/8nsdI55DZkXhVCmcSUgadrmDvdHSk5JcE?=
 =?us-ascii?Q?n/FLVOdtJ3DyoAQxutLMgBErsgnANJnjzP8lThBPT2kDKPNC4om2YofEmaJ+?=
 =?us-ascii?Q?4MqRkz+IWRHq1G+pejR0TaXkOQobLmmXEs7uspyxKLI+pg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cOCuokxpRnwjieVrLZUTWeiZf1IP15z2XnCTF9cUopliGqL2H5DPuNWmzeeh?=
 =?us-ascii?Q?UegtPJ9jwCPO3KUZ9xuDmlSa/kZXDb/DmnChUbp5OThq2VlPWLHXc67JZJP9?=
 =?us-ascii?Q?1c4Hl28JQMCv9MrfV8xOQ/rbXkvaq+YvFLMuea12VkOJVRgsptc3XeMLvNJA?=
 =?us-ascii?Q?tAedj+qaDk1JYks8C1TTfWKoiS29tKa3iu/vjmEMXJUNs91KMxw5uIJstIc5?=
 =?us-ascii?Q?uM5dBOy8Kk9yjJKbHs0KtyQ/mUUpMMtIpyCVqQnAt3u1s/729AspNFr65/vr?=
 =?us-ascii?Q?IifMIW2JhrGRVUZigIp7pHfCW5YtBLgAi3zWB5LyVmp1cXTktCqFkkkFl0Br?=
 =?us-ascii?Q?He1idQw3+GZVvExMAORZyhaFFHJwnNefHMXUoB95y3XWF8YAMtKsKhXRkt9z?=
 =?us-ascii?Q?Y6cPuK53hyTwhQRnpbzzRQJC6eaBRFccZlDtbTrtnUAIp7Vr1pXMx5OTe5Lu?=
 =?us-ascii?Q?sRhv6gKUY4E3//z57yWePgpgi3d9zvwfey6C0CpXnSfw/uqkN/rw1dzuESzu?=
 =?us-ascii?Q?zcAM9cdd5+emlKZjDrTeSJL8faCpkvZGjRzoDyQUUXgK2FHyaKi4saDJt1SD?=
 =?us-ascii?Q?cjo57JhVC+jnuffNot40OrVuIOHFE2fyekvKoxx4ROmSs0PfxjlMsy+l33a8?=
 =?us-ascii?Q?j12BMI5cwN76l91G8kdzOoh830SEU1du8gc00+/dtPsLNVrxE6LxmNKSzA+1?=
 =?us-ascii?Q?L89Da+bbWMTmfhsUKj6lOKnzA0BsZpJ+5ehsbEGjubxhudVBwiFk/JDhGqcJ?=
 =?us-ascii?Q?7f4h5gnCyMRvD76Icc2ZCdQONfNx94dG3bq5fucMED3tGjYNmCFJkBB8sdLh?=
 =?us-ascii?Q?IqRsjY6s27Ir0p21MqaCfhH3l8PDocAyV3nPge0l7fOan/5AzmfGnvQEaaTN?=
 =?us-ascii?Q?bNjHXfAlICORkV0C8Dk9qQvI4SUIMhghTgmwSG6eMTEmTKAZzkkK14EjS9lY?=
 =?us-ascii?Q?k5DJEikb3W21P2klkBNttA5oVofpoF2997izxl5PLP9XevfhP/nPjs41GbCn?=
 =?us-ascii?Q?B/YSsNV5M/0lIqrwSOIFazHYDVVAdvQpEwI8H0MSq4zVQkAuxxcF0P4JSKgn?=
 =?us-ascii?Q?fGOdKUMq1tncN9j02EfpA2LGW8U0EZBVR72CZgzNvOdqMHTiLgiKkQrAq+56?=
 =?us-ascii?Q?hW80hRlJgGjIF0cQCQd9NiSPEsJJ9jg9zfcgqKK0oIYi2/btl9j8xxSBtUCc?=
 =?us-ascii?Q?H+UAEB5nw0fAy3OtRmaggYXPLRZmuTHq1o4HSXzsn+xz6nLm3rOdELV6HfMZ?=
 =?us-ascii?Q?gYeRFAz8fuWey3Qg9ItBO5lDxNC92EYUMlD6Y0xXK0n9irwCnjxFTktLIelJ?=
 =?us-ascii?Q?/eRRSajUJFhUbsvOTq/u1g+jvvQdV8NroU+UJw9pQUu6JP/z+qsQGTu7mXmc?=
 =?us-ascii?Q?h6kk/Pt2vfxg2tQcziH+92lGZoiSZcc2gq9dKseAhTFAlbLXtBeZoJEqsSd/?=
 =?us-ascii?Q?J/6XNucBQ/vXcX+6+SGIDHYa9MPGqH7+QacsiZFKvmUk5aqYjLDFRSj8kSra?=
 =?us-ascii?Q?NKLalcvAFQ/KGl78smenjf7NmwZvbrF1/zKoJu0AYmCtAlx8AJ9eKS5ZcMHF?=
 =?us-ascii?Q?x/SKiu6W+ptkjJuaH+HadixZ0Ulbwnsdj4a46x8m?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0855d36-d10c-4846-fcfb-08dc64e805ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 05:24:46.9706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2Ok8mEQwTHfeWqamMuG/mqODrbsxlzYMUIT+0pOR6bhUGejJmqwThqXZ9CIHKDSUqNDgM0QMinzBSJCJ6YV0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5857
X-Proofpoint-GUID: W7NYICw2eyEoaU4zDAobUrIiu8WQxo0Q
X-Proofpoint-ORIG-GUID: W7NYICw2eyEoaU4zDAobUrIiu8WQxo0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-24_01,2023-05-22_02



> -----Original Message-----
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
> Sent: Monday, April 22, 2024 12:46 PM
> To: dan.j.williams@intel.com; axboe@kernel.dk
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> cxl@vger.kernel.org; Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> Subject: [EXTERNAL] [PATCH 7/7] cbd: add related sysfs files in transport
> register
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
>=20
> When a transport is registered, a corresponding file is created for each
> area within the transport in the sysfs, including "cbd_hosts",
> "cbd_backends", "cbd_blkdevs", and "cbd_channels".
>=20
> Through these sysfs files, we can examine the information of each entity
> and thereby understand the relationships between them. This allows us to
> further understand the current operational status of the transport.
>=20
> For example, by examining "cbd_hosts", we can find all the hosts
> currently using the transport. We can also determine which host each
> backend is running on by looking at the "host_id" in "cbd_backends".
> Similarly, by examining "cbd_blkdevs", we can determine which host each
> blkdev is running on, and through the "mapped_id", we can know the name
> of the cbd device to which the blkdev is mapped. Additionally, by
> looking at "cbd_channels", we can determine which blkdev and backend are
> connected through each channel by examining the "blkdev_id" and
> "backend_id".
>=20
> Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> ---
>  drivers/block/cbd/cbd_transport.c | 101
> +++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/cbd/cbd_transport.c
> b/drivers/block/cbd/cbd_transport.c
> index 75b9d34218fc..0e917d72b209 100644
> --- a/drivers/block/cbd/cbd_transport.c
> +++ b/drivers/block/cbd/cbd_transport.c
> @@ -1,8 +1,91 @@
>  #include <linux/pfn_t.h>
> -
>  #include "cbd_internal.h"
>=20
>  #define CBDT_OBJ(OBJ, OBJ_SIZE)
> 		\
> +extern struct device_type cbd_##OBJ##_type;
> 	\
> +extern struct device_type cbd_##OBJ##s_type;
> 	\
> +
> 	\
> +static int cbd_##OBJ##s_init(struct cbd_transport *cbdt)
> 	\
> +{
> 	\
> +	struct cbd_##OBJ##s_device *devs;
> 	\
> +	struct cbd_##OBJ##_device *cbd_dev;
> 	\
> +	struct device *dev;
> 	\
> +	int i;
> 	\
> +	int ret;								\
> +
> 	\
> +	u32 memsize =3D struct_size(devs, OBJ##_devs,
> 	\
> +			cbdt->transport_info->OBJ##_num);
> 	\
> +	devs =3D kzalloc(memsize, GFP_KERNEL);
> 	\
> +	if (!devs) {
> 	\
> +	    return -ENOMEM;
> 	\
> +	}

Do not need "{ } " here=20

> 	\
> +
> 	\
> +	dev =3D &devs->OBJ##s_dev;
> 	\
> +	device_initialize(dev);
> 	\
> +	device_set_pm_not_required(dev);
> 	\
> +	dev_set_name(dev, "cbd_" #OBJ "s");
> 	\
> +	dev->parent =3D &cbdt->device;
> 	\
> +	dev->type =3D &cbd_##OBJ##s_type;
> 		\
> +	ret =3D device_add(dev);
> 	\
> +	if (ret) {								\
> +		goto devs_free;
> 	\
> +	}

Do not need "{ } " here

Thanks
-Bharat

> 	\
> +
> 	\
> +	for (i =3D 0; i < cbdt->transport_info->OBJ##_num; i++) {
> 	\
> +		cbd_dev =3D &devs->OBJ##_devs[i];
> 		\
> +		dev =3D &cbd_dev->dev;
> 	\
> +
> 	\
> +		cbd_dev->cbdt =3D cbdt;
> 	\
> +		cbd_dev->OBJ##_info =3D cbdt_get_##OBJ##_info(cbdt, i);
> 		\
> +		device_initialize(dev);
> 	\
> +		device_set_pm_not_required(dev);
> 	\
> +		dev_set_name(dev, #OBJ "%u", i);
> 	\
> +		dev->parent =3D &devs->OBJ##s_dev;
> 	\
> +		dev->type =3D &cbd_##OBJ##_type;
> 		\
> +
> 	\
> +		ret =3D device_add(dev);
> 	\
> +		if (ret) {							\
> +			i--;
> 	\
> +			goto del_device;
> 	\
> +		}
> 	\
> +	}
> 	\
> +	cbdt->cbd_##OBJ##s_dev =3D devs;
> 		\
> +
> 	\
> +    	return 0;
> 	\
> +del_device:
> 	\
> +	for (; i >=3D 0; i--) {
> 	\
> +		cbd_dev =3D &devs->OBJ##_devs[i];
> 		\
> +		dev =3D &cbd_dev->dev;
> 	\
> +		device_del(dev);
> 	\
> +	}
> 	\
> +devs_free:
> 	\
> +	kfree(devs);
> 	\
> +	return ret;
> 	\
> +}
> 	\
> +
> 	\
> +static void cbd_##OBJ##s_exit(struct cbd_transport *cbdt)
> 	\
> +{
> 	\
> +	struct cbd_##OBJ##s_device *devs =3D cbdt->cbd_##OBJ##s_dev;
> 	\
> +	struct device *dev;
> 	\
> +	int i;
> 	\
> +
> 	\
> +	if (!devs)
> 	\
> +		return;
> 	\
> +
> 	\
> +	for (i =3D 0; i < cbdt->transport_info->OBJ##_num; i++) {
> 	\
> +		struct cbd_##OBJ##_device *cbd_dev =3D &devs-
> >OBJ##_devs[i];	\
> +		dev =3D &cbd_dev->dev;
> 	\
> +
> 	\
> +		device_del(dev);
> 	\
> +	}
> 	\
> +
> 	\
> +	device_del(&devs->OBJ##s_dev);
> 		\
> +
> 	\
> +	kfree(devs);
> 	\
> +	cbdt->cbd_##OBJ##s_dev =3D NULL;
> 		\
> +
> 	\
> +	return;
> 	\
> +}
> 	\
>=20
> 	\
>  static inline struct cbd_##OBJ##_info
> 	\
>  *__get_##OBJ##_info(struct cbd_transport *cbdt, u32 id)
> 		\
> @@ -588,6 +671,11 @@ int cbdt_unregister(u32 tid)
>  	}
>  	mutex_unlock(&cbdt->lock);
>=20
> +	cbd_blkdevs_exit(cbdt);
> +	cbd_channels_exit(cbdt);
> +	cbd_backends_exit(cbdt);
> +	cbd_hosts_exit(cbdt);
> +
>  	cbd_host_unregister(cbdt);
>  	device_unregister(&cbdt->device);
>  	cbdt_dax_release(cbdt);
> @@ -647,9 +735,20 @@ int cbdt_register(struct cbdt_register_options
> *opts)
>  		goto dev_unregister;
>  	}
>=20
> +	if (cbd_hosts_init(cbdt) || cbd_backends_init(cbdt) ||
> +	    cbd_channels_init(cbdt) || cbd_blkdevs_init(cbdt)) {
> +		ret =3D -ENOMEM;
> +		goto devs_exit;
> +	}
> +
>  	return 0;
>=20
>  devs_exit:
> +	cbd_blkdevs_exit(cbdt);
> +	cbd_channels_exit(cbdt);
> +	cbd_backends_exit(cbdt);
> +	cbd_hosts_exit(cbdt);
> +
>  	cbd_host_unregister(cbdt);
>  dev_unregister:
>  	device_unregister(&cbdt->device);
> --
> 2.34.1
>=20


