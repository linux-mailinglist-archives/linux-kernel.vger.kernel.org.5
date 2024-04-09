Return-Path: <linux-kernel+bounces-136228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA40A89D17F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE5A1C2484C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EC0129E7D;
	Tue,  9 Apr 2024 04:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="r4J9mUZR"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95A83CB0;
	Tue,  9 Apr 2024 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636641; cv=fail; b=H4JzSNSY/K9R01bJg7j0yj8UI4x0UvTRPgYksNBKI5KSOQcon5IhxCjyMcQnbIzbyQO4fHZBAmWdLNseus6rSFeBOWekKGHRut0YhmVd2RKUPrtu11XBQ9inQnlNU/RME3oikolL+r7Rfqo5cOKlhXB9/TJPoUMas6YlutVjrtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636641; c=relaxed/simple;
	bh=F0B1qdd1IJ+nDImhjzYP4U65RGrUP4JnhQ7f9WfUElY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J97qKqHRui156APrXewbMovfdaoH2NFOoWeMVX4/ywW6lhwmdaoz3G5VxDPO5bjdjbTh/OF+rbOKzcbdKopqMmYhcLvDxWSjXVvFOz7G2eyPFdH+nzusOomma0rjkRsxLuzZooouy5y0b6rM1vHTGyn9TgkPPaamdRWL+3+nq3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=r4J9mUZR; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438Nf70B019993;
	Mon, 8 Apr 2024 21:23:20 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xb5wgevew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 21:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG397IC5GWa2dHhLpk8B3nODRr/3AAOuP+6WTOBeMZkBUc/N+Og9mqsCwnEcWyee+fCh7GHJ0H6APXx46ArW38gbJsGoOy4NLOlFIEeHxPKWojbS/uPq+VO1DaUJZ1VuZvN9puIxNVlTD0GgiFR5W+eXmOP7r3MQxsYe7cAUbpOnuyaLsktn8VNZ1V7qWvBq8V0nNn/DTcJcQ3na3S6uzhGwXnwPe/zLWn9nqvhm5J1sK991+c5zVJEsJ8rSZZQ/wdbR4E81+M3/UMwXLEUCSvLRIG3YFEA9THHq+2AeLU4YYPAl0Xo5ixOhgQ6rPrHcFUHPnKT/8HAQY3/g2R0gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1bNaAMdCBmz9m4zrU3Xex975PEeAjT0d6gvrjPIYY4=;
 b=eppiN0Pc3qS0pAb+LRW7TBeRBSeQwYQl1wyixral/UuyXVZ5LVdBU5MMo/oHnFzA5GGAVwKwDhLrO7QU1FQmIBjSN/fXZPFfBbFxJisbUK0UDt2LKRT8HElS/1Lrn3hjK/ArDXWx/gc15PHTs4zspP4w7zoZyZJBCJmthu/XrdKLJzsYREbyh0ci6FdWdPIdI95d+42yqo/rW+/FodT7LxnCfyMbLM5CblunkmQI2mr862I5kL7osGBhkOIAr9RkTZK6bB1XVAC9IUbWR0z+R7rD4rRsSitlv+prqoWiuZpL9PXNeDFy5TR34ZrzyGPLDpsXOl4qCs1r4AsODHBX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1bNaAMdCBmz9m4zrU3Xex975PEeAjT0d6gvrjPIYY4=;
 b=r4J9mUZRTQ2Y7ow9RnGAnPgwXwlQvaPbV8/LT/vIhf47HCRu0DKGCbLYEMPXZAROW2HfvgjW6zlUJy1/Y6qZeAhRnsq9EjbZKGdXsO2eXm2nR3THUBs9tnwdX3UKjtKhIXjG1Yf95qgyUtPRLekwgZOilIM3xes9TCD+se+RUEE=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by PH0PR18MB4637.namprd18.prod.outlook.com (2603:10b6:510:c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 04:23:17 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 04:23:17 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Chen Ni <nichen@iscas.ac.cn>,
        "bbrezillon@kernel.org"
	<bbrezillon@kernel.org>,
        "arno@natisbad.org" <arno@natisbad.org>,
        Srujana
 Challa <schalla@marvell.com>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] crypto: octeontx2 - add missing check for
 dma_map_single
Thread-Topic: [EXTERNAL] [PATCH] crypto: octeontx2 - add missing check for
 dma_map_single
Thread-Index: AQHaiVh2tQ/R/jxRl0KfSN0JAGF1VbFfV/OQ
Date: Tue, 9 Apr 2024 04:23:17 +0000
Message-ID: 
 <SN7PR18MB531447D46F3AE83AA06BE1B8E3072@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240408015914.101442-1-nichen@iscas.ac.cn>
In-Reply-To: <20240408015914.101442-1-nichen@iscas.ac.cn>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|PH0PR18MB4637:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ddB2CcmWDgndv06yHQOeNr2BlcCZEsbPd/N16TRVqUmHLYuqnkS4PvgWl9cCJONcciJtxI/zN2KdHyuiI3W+im66+LDRRsnht08CwJqoU2+z4A/sKK/FNp9euxrJ1MZyolN2KYAKi64NAK38bak5okGzTtKxrnNVZglVTgoY3DKrHkvi8zBebP5xLDpNoCMb+r6BZLsRl0UmlarWdhwQPR3Tic5GQABdzQISsyo+5ZulvKMjuTkHfoVVCnZvtSAqq0G6PdqqSKuu6B+SlbcmlqaYDNvNoeDRxR2czm1W1uIZoxLARuZ6l3tEhELQE9n0u0/dRNLB3pROFDmGtbOv8UV1Kw2HyqA7Ag1LTZ7xsyQ9kZhovCo6QVdj0XCyQ8j9o0wjp0cQnsFdktdXdDa57Y1HgSF11LI0xMKECVUWFbXypoyvcFwZVyg2t4InGBjd6rCQeMylNLbFF7yIzd76CTEdskj85uDNx3ZD9VkZ2oocOdkOo7y72XORFNnuwDWhCEO/YKJJLZebF+sZhv2fKYd+3UtYz7IY6PHA4kcD0g6bqfSsGRL9tUb/nlIb5k4eb8vsbojzae7umdjZlYzJNyFT6VcJQBH8TqUM3NKUJXtciybn5AlKNVnJRgCvcI1OY7DXfP5l7FdKbd8qSsSgIP4g/3CMm6ROf5vGtXy892I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ZQ5lPOPzhuY2hfNSXZEevaSeFuBol61ENKhB9eOcppL0UKiikhctBl95hbbD?=
 =?us-ascii?Q?hHtrgRT+DL7bzvzRCT9T6iktqd/DKBALUPTIQJzrwOcjdK/ej/u8WOQTtmRw?=
 =?us-ascii?Q?CaoX911Q+/Gd+BfU+Egdc4d8omClAQ0nIaO1MyX0LWiLdUy/JUopjCUpA7Ol?=
 =?us-ascii?Q?d/R/+Kkt1fX0Skpsa/gzjDVeUE4s1WGY3gFQABeGnaAXXKNsIY7Ud30TX700?=
 =?us-ascii?Q?nFc13zoFGKzLul7LxTDk8nTQVC6J2Gj1tA+STdFxy1HABnKAG7jmsbYHR1sD?=
 =?us-ascii?Q?XswoIR1w/BNzfITh0fYQ+J+jNege8MC8A7bdewmrtr9bRAaXdu5BIbwxBKxU?=
 =?us-ascii?Q?NF8KD9fRCtAOG02Pk6n5sa9Ym2QbZ48HHfhi+6+aSGrQSZoQc541lILQ3D5y?=
 =?us-ascii?Q?8BhAzywR24wYGfj9Tb/cJ7tdfgo8bL8/okku3vF202VRLPy5/fHSlGaLmRgH?=
 =?us-ascii?Q?iGc4wY1jiW7cap+ODxmoHpf4laVUQcZrbVzSNS3gUtkMivLmDNgVdPhM2OWX?=
 =?us-ascii?Q?+GZ6DPk5cHzDceeUwivP5L5suzqqlxWzsctvso9+X9YpoolrYACeoqDPkyvL?=
 =?us-ascii?Q?Bc4OWqKx8d0Wv4fLx5+4FE9/EoD6ceoOIQQwSX4iP7NnC9lTQX9Jil5FsUuj?=
 =?us-ascii?Q?IWR8npXAdsDT1L6sQBrPJHVlwzMJRvqsZE+20OglJYHCQx6T76PvzE+k/MAZ?=
 =?us-ascii?Q?ADL20diAPY9ZITmx3ZBs3Oz1Qe1qqJMnXw1PHUTbipcLoVasEmHHRi+ReCfv?=
 =?us-ascii?Q?OPpI35LVFAXzg/fiMzYAAefNllqAiu8fKfuwPoil+EKIkIHaJIrygzPXuS0U?=
 =?us-ascii?Q?Pm5N8G78eUnZjC/vcVxXHnbaw6oWw4cjrhzZzy2K3YZTwVtBzIsBo6Tk7844?=
 =?us-ascii?Q?UoLt1QQr4zG9aJ9TvpVxxMq0OoB5DGaUEqmzzEkIXOsJDJHkpEDx/B0xqOwG?=
 =?us-ascii?Q?robGwnjmtgszMbrNv+NYt/iZu+4kPwgk566dW5y646G1J8vXYhNtq9aCX3Qq?=
 =?us-ascii?Q?5TPLNHw+nYkpczc3zmZ26/8ILC7ciDKA4KnZ/fqvuOFZzuT5DVMUBA9A5/08?=
 =?us-ascii?Q?/rS6Ij6GcjcUBz0J+scgME/Ky1C4no8outif3H1CLAgv10AEJLEVpuXGV10H?=
 =?us-ascii?Q?j1WfXlJkF5esTXoNpL4O0RWgeBnUtmOUKHjAj6GFs71EC3LHueHhmtrQEi+9?=
 =?us-ascii?Q?U5ILwHwYJWO0dqxNYsogxVJ6pKWkVXOpKj5kBd8cDj8olBZweM1SEuVtWjNe?=
 =?us-ascii?Q?kIcp9Za7QIZdV1RC9pQRu6YpkIGTS03H51CaaOoupDFKi3My6FXTlGoZzq58?=
 =?us-ascii?Q?lhfeAEuzbqKrJdh86metpJQHSjI2wBmOD6vdKNC+X24QKix/fMd+Bj98DDgV?=
 =?us-ascii?Q?Ze4oZqkx4Vul8cWblZzlBTkjnt5j8ZmCdfUlYFB7G2gu8wsjIox7Rxeejujs?=
 =?us-ascii?Q?zXyg7NXSRnDn9JTuN8TcpJeCR8lYGro1cTGSKQOMDcI8//8YL1SEHb3/gPda?=
 =?us-ascii?Q?VRWsyHT6OsazrGMj5yWXUfnBFeM9nr63q1LtQn5aa4vpHw1C50QUIUSRCj9w?=
 =?us-ascii?Q?KcdbYGdEsNsCLxmJ7xs/ooqU2pzy9tfEouPpHAxR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef35d12a-d839-4c4f-4c6b-08dc584cc82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 04:23:17.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kd76CAVJ9ihFaa9vZWvwKMRs1TGgcdWxNIc00FHRtD/7DFh23nEToXne7d5jPNKJgs+sM3OLU/aBBRMD5D8qIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4637
X-Proofpoint-ORIG-GUID: tmxbZN6ultQzJws8J0P-N0xqNkpwCwo5
X-Proofpoint-GUID: tmxbZN6ultQzJws8J0P-N0xqNkpwCwo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_01,2024-04-05_02,2023-05-22_02



> -----Original Message-----
> From: Chen Ni <nichen@iscas.ac.cn>
> Sent: Monday, April 8, 2024 7:29 AM
> To: bbrezillon@kernel.org; arno@natisbad.org; Srujana Challa
> <schalla@marvell.com>; herbert@gondor.apana.org.au;
> davem@davemloft.net
> Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Chen Ni
> <nichen@iscas.ac.cn>
> Subject: [EXTERNAL] [PATCH] crypto: octeontx2 - add missing check for
> dma_map_single
>=20
> ----------------------------------------------------------------------
> Add check for dma_map_single() and return error if it fails in order to a=
void
> invalid dma address.
>=20
> Fixes: e92971117c2c ("crypto: octeontx2 - add ctx_val workaround")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/crypto/marvell/octeontx2/cn10k_cpt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
> b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
> index 79b4e74804f6..6bfc59e67747 100644
> --- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
> +++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
> @@ -138,6 +138,10 @@ int cn10k_cpt_hw_ctx_init(struct pci_dev *pdev,
>  		return -ENOMEM;
>  	cptr_dma =3D dma_map_single(&pdev->dev, hctx,
> CN10K_CPT_HW_CTX_SIZE,
>  				  DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(&pdev->dev, cptr_dma)) {
> +		kfree(hctx);
> +		return -ENOMEM;
> +	}

Thanks for fixing,
Reviewed-by: Bharat Bhushan <bbhushan2@marvell.com>

>=20
>  	cn10k_cpt_hw_ctx_set(hctx, 1);
>  	er_ctx->hw_ctx =3D hctx;
> --
> 2.25.1
>=20


