Return-Path: <linux-kernel+bounces-117030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596788A651
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0271F2F515
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148A41C68A;
	Mon, 25 Mar 2024 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="XTxu/E//"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AA134A8;
	Mon, 25 Mar 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370700; cv=fail; b=WtanbrUvlLCtQJGMMY49qw3f9nIA/0U6mLg3xtf5c1Yb4zSop3rYaAGVNml3Di8pOgxlTjzOKmEV7A5v+00uNfbEwJhkXgTk2FJGNky82bhQ/Vs6jdOBAP3XUYuQ+tJ0fQjOfjTMtSFcS3YKuJAol+7PWYKzZPv9eF6HFRk77Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370700; c=relaxed/simple;
	bh=mM2jqFPzzVLqCXMdSpX/YoMyaANeZe078MDPCVl3GtY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GVXj/9RM8nN+460rer3LQQx7V926z3uLfW7zrP1c6oWaf2Co9AHFH+0LteQO4fOfUbjcqYHNM7WAvgmwP1SnYdyhE1o+beNry3JdvV6k+EQkxGjTu6GDS9Pckwdql438KLLKPrTPDJbRxO5oaOWo2a5ikbiS7AA41NoyCYBM2VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=XTxu/E//; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PBjrWL001608;
	Mon, 25 Mar 2024 05:44:48 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x38pbr805-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTtEi1zFrxkO3B9eGqMVnIor8c4KMN9qjMqe1Nf2YiRBGB2mCBT5OAtRcQHk7G/BFlokoyGiQ92ZKnoceAeKpbYpfPgC06L+R4b/AOJBCPNI7hjSZhG9p6//6v61xVYCj2aErxBCS//i7Pjsk8kSLy5Eix8L/clncbzN0EaZ4goSPMXENwzFDr98BVO3RfRCgEBXnLa57aO6eD1DSnJtaZoBFduiXYX9MObx949xYSmgIIpULik1zUYZjP+HOCJ2d9xDTDHNvapY8KI9xDlb8oGgmm6vyrVB6DRY4eU0dmGtz5RkXfq7ups7VAfrowr5pmOpiUbu9JYSoPL0n0mZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw4/dt0u5H1qRNWbp7Zi3g+c3c4Ar6HTDjyxK6JFkXs=;
 b=B663aqjquP0t2hCj8Zyr8585Ia5wXkoOM9ESbI/EY4ZZefB741Ga3HM/jArflb58S1Jnnv7PRRBitWo3UiWrQ25lWvXSdF/1qxvt3dvNqNPe3Ou5w1bljzhhrwxQ6T+UlOIzN/gQck0AVewW8Zw5MWltTGPUuc+/u7OwKajHNSiQZ1D0NxY+1AYR9hKh20vnzPvOsT+LaiKtC/CUKCjZsKBBBxouiP0oDXHzG0MpzN/orj56ox3ayPS2d2d/j15m9y9rX5La8b7YKm8rVEaKs8J7hmYhNHzaxcAxc6yBzsCpgxFNFtFn1bOWyMA9ENitLdHnWQPAO2YuPcu0fqLlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw4/dt0u5H1qRNWbp7Zi3g+c3c4Ar6HTDjyxK6JFkXs=;
 b=XTxu/E//C2GSYvrYobfDjsnwDTFplF5T2QP6MyPmYD87ISE9QVyAadIT6LTJgJn2sVgiI+L86R506TuQTBzf2oBM4ThJHk4vQyM10P5KyW6XqIAF2YUMy2CelpIYuNGsgo+g6uQ6G2I2SgHKjAmapv2XBFNa4kpwq5xP8UjKfrY=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by MN0PR18MB6094.namprd18.prod.outlook.com (2603:10b6:208:4a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Mon, 25 Mar
 2024 12:44:44 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef%7]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 12:44:44 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Su Hui <suhui@nfschina.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com"
	<ndesaulniers@google.com>,
        "morbo@google.com" <morbo@google.com>,
        "justinstitt@google.com" <justinstitt@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 2/2] octeontx2-pf: remove unused variables
 req_hdr and rsp_hdr
Thread-Topic: [EXTERNAL] [PATCH 2/2] octeontx2-pf: remove unused variables
 req_hdr and rsp_hdr
Thread-Index: AQHafocf78zPvIoQlUeZgrhxSP5MI7FIZsYg
Date: Mon, 25 Mar 2024 12:44:44 +0000
Message-ID: 
 <CO1PR18MB466675E232FA99415D766F68A1362@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240325073549.823832-1-suhui@nfschina.com>
 <20240325073549.823832-2-suhui@nfschina.com>
In-Reply-To: <20240325073549.823832-2-suhui@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|MN0PR18MB6094:EE_
x-ms-office365-filtering-correlation-id: c40ca516-c6da-4b72-913a-08dc4cc958cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8WK896y5K7OwLc9ywROB95bFX2InDZc4K1O8IWjo+ugSao99GMAgyWTLe/7eAQXNaJ911Sis+uqjuEDtBCBcl887fgXDVpJXgdYPp3TBD5wPPaXuRjND+MpZMlFKYvb5JKEjrrsGiu3ZbW11PMtpVkD8fWW0+uNpTtLpzr4pmZTxxYOBDEQcnrzPg0ce4XhuX4FFvqiQjDT430wN1MqLT9mx13sJZ6K2rJY43UmnHiBb3rCpUltIbrTWXCKP3yCdaddKPlN7U13EeE8Xc81zSEB2G6wICBEuwyF/TkJpv9zf6kFoisZ6vaO4fLaKwwgMYKYgtQLJRGGPgDnhd5lVfsLk5pczCkBDzF5o9XXb3qGA6q5syXLS0b62eepijlTJM1ximW4uV7gUII7ex/tAAZHbmq6/E3Y//raPuvP3b0gbR7KJhU6aAVGX1Ie7zrwGUzCLeYfrEWmfq2+GKIxckNsYP4flPFdzrdCqbyEtZElmtsRibsNQXNEJrcLx981ThcTfM3eEHZEwkhWgsj3bYKEWdWFa3Tt4mYGQNtZ9ZNDxAoBO/Q02itjSQJ4Xwg9N1zQcYPMnmJsGv3EmjNbspgIzR/NZ6gbJvpHwG3T74a4ljAyRIjMOk1k7qs5E283XCbW+uJEKO7gIIdkSsm44cZOsR0sJck+QcBIgTDLtuCXu7H5m0x13266f509BSu5y6rAZALPwR3TDkcMNcAn/ePyMXJJpp5+SZsrX8v7jrXw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?I6SekxjjCyfpSx9/L1CZMNb11pj4fUKTT+/IkIubtA/QP01Gb1qSIH7UY2pW?=
 =?us-ascii?Q?Jvn6JuofNnNe1hmQo5dCJo3nOIrpdF4pu6uO235Llm5qKdCwYXJ6bknqqA0O?=
 =?us-ascii?Q?xhid/ZepJLKjK45gja0c9dIW+B6EyOIYT0rgRX72qJfFzfDMHnYjBi++KIEv?=
 =?us-ascii?Q?wY/brkOVnzACFV3iPNZkVcEA31LA4YGWQOtRUGWrnO1LFRBj82CHJgZcD/Ec?=
 =?us-ascii?Q?b4tNfEU/LD+7FqfdAqxe9hEoUG6XUyxfYZ+ruD5++/SeL11ZrYMLrpDBagWY?=
 =?us-ascii?Q?IO3lqQs3dESk60ETGJFVIoDO5bYi5rr50uYQ20Pa72qcrMPkz5gZSVcf5GOt?=
 =?us-ascii?Q?1YhPWCjF7tkvJKoKTRILc4zjcM1KEeKziYYGrfK6ASgJTG1sJe+45H1R4yZW?=
 =?us-ascii?Q?hN1G7m2hKI/pi4UwOWRrTJZ92ApFafg1StvN26Cgbj5Ks0C8M+Ul/nNhm+sM?=
 =?us-ascii?Q?1bcXG/esscefyeeKwgHzwMRTKDy36baOZkgOtMIvFFzA68LMFq/qWgagR70T?=
 =?us-ascii?Q?tM49hpR0H7Umdx2n0VH3wsBI+PHqalblfJWC6mCi4AktigFUUAJ6M0JyMz5q?=
 =?us-ascii?Q?vX3FIZ6xr88SzVJm4tZpHhCR+xwCtk8aNh0qkz3SWHuq0mnc0v2CcUdt2lfW?=
 =?us-ascii?Q?GeUboI/QR3lzr2Nny7lv+OZM2BoFAAw3vgoc4iRqiYNZTWv9lcowyPPdert6?=
 =?us-ascii?Q?qE7QgohJ3aPUH3RUzfaMMFbHdopO8GKb0SmUk5QCcyalOUOpg/Y9bc1FZ7on?=
 =?us-ascii?Q?JUPt0Chs5qZLY7FI5MHAjRD9WBCJYy1fPFecKOn/WDZdT5/YbgWN39BP61GC?=
 =?us-ascii?Q?Iv1T9slm1+mDiMo1SGglpW7HKQ6lZ08m5bZvkvDxYM1APwP9nb+A/EQYYkYu?=
 =?us-ascii?Q?7NVOO8muE9yySyoZMLtS/lojVloaD3TF/fdaUBshdA8nrjtFSVTa0x7LlNyn?=
 =?us-ascii?Q?J/MxRVm4/UB1IyONHi0mymtdUOvZwIZScPWqeXoJcvWNmZdmndTh+4UOlMSg?=
 =?us-ascii?Q?fQxp42qkqvRDfTDhYkBRzPUuTi/mSEwliK+EqQmQbxbadqhYXL2Nf7eWwPXS?=
 =?us-ascii?Q?K7PFvzmeftD3oi4rd0Ub87c6FRcL0BrSon1PKpYc/D4aIGWrTgAfT9fEGGUH?=
 =?us-ascii?Q?8amiyZplKir7CYXh9VxyNPrk+M6SfxP9XCNdoRsW1uKis267xAp8+iC+XE+O?=
 =?us-ascii?Q?Zn2Fb139KyapiL0PeDRk18lL+sbjPdQiIUp37EJnDpfxoC7suKPXcK65lB08?=
 =?us-ascii?Q?UZ00MWaLp1/+17S8i3n0Ift2iT3ECT9iE9B25gNaDCP1zMUDGQeh53HEB1nf?=
 =?us-ascii?Q?REIroaDCGSeREqmTtVMs/+3gC3Ll9kru1seQ2V2RwEQs4jmJN6+mQ4NyIOjS?=
 =?us-ascii?Q?xiZHudfxdSr7Qgnoyf/7BCiimjtd/unXu9kpGDbmgXx05uy4NMX1TlrXVR4K?=
 =?us-ascii?Q?XqtQKDxKdEZvyq96yjkXmolyMsgb1VqOVBdfodXAE4pTUn13XwXP6fRgDRSm?=
 =?us-ascii?Q?biAXDRFeB6K3qjh+mswE94Q0y4xTbkcyO2+phtyKK3HnSHnwHR2Ies9VvA?=
 =?us-ascii?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40ca516-c6da-4b72-913a-08dc4cc958cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 12:44:44.1300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ExFDZN/crwUVsOVhjcXPUxWWiDpitW8l+URUosXJFidjZ81It27Nuv1uWXeQcAi9UqRD4GRqPSIKrujLJLQjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB6094
X-Proofpoint-GUID: qcN6x61j4SekXdjO-AfvbLUS4zgtGHiI
X-Proofpoint-ORIG-GUID: qcN6x61j4SekXdjO-AfvbLUS4zgtGHiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02

Hi,

>-----Original Message-----
>From: Su Hui <suhui@nfschina.com>
>Sent: Monday, March 25, 2024 1:06 PM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>nathan@kernel.org; ndesaulniers@google.com; morbo@google.com;
>justinstitt@google.com
>Cc: Su Hui <suhui@nfschina.com>; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; llvm@lists.linux.dev; kernel-janitors@vger.kernel.=
org
>Subject: [PATCH 2/2] octeontx2-pf: remove unused variables
>req_hdr and rsp_hdr
>
>Clang static checker(scan-buid):
>drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:503:2: warning:
>Value stored to 'rsp_hdr' is never read [deadcode.DeadStores]
>
Consider this also as a fix and add Fixes tag. Also please add "net" in sub=
ject to
easily identify whether this patch as net or net-next material.

Thanks,
Sundeep

>Remove these unused variables to save some space.
>
>Signed-off-by: Su Hui <suhui@nfschina.com>
>---
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>index 3f46d5e0fb2e..637b05c79c42 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>@@ -450,7 +450,6 @@ static void otx2_pfvf_mbox_handler(struct
>work_struct *work)
> 	struct mbox_msghdr *msg =3D NULL;
> 	int offset, vf_idx, id, err;
> 	struct otx2_mbox_dev *mdev;
>-	struct mbox_hdr *req_hdr;
> 	struct otx2_mbox *mbox;
> 	struct mbox *vf_mbox;
> 	struct otx2_nic *pf;
>@@ -461,9 +460,8 @@ static void otx2_pfvf_mbox_handler(struct
>work_struct *work)
>
> 	mbox =3D &pf->mbox_pfvf[0].mbox;
> 	mdev =3D &mbox->dev[vf_idx];
>-	req_hdr =3D (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
>
>-	offset =3D ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
>+	offset =3D ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
>
> 	for (id =3D 0; id < vf_mbox->num_msgs; id++) {
> 		msg =3D (struct mbox_msghdr *)(mdev->mbase + mbox->rx_start
>+
>@@ -494,7 +492,6 @@ static void otx2_pfvf_mbox_up_handler(struct
>work_struct *work)
> 	struct otx2_nic *pf =3D vf_mbox->pfvf;
> 	struct otx2_mbox_dev *mdev;
> 	int offset, id, vf_idx =3D 0;
>-	struct mbox_hdr *rsp_hdr;
> 	struct mbox_msghdr *msg;
> 	struct otx2_mbox *mbox;
>
>@@ -502,8 +499,7 @@ static void otx2_pfvf_mbox_up_handler(struct
>work_struct *work)
> 	mbox =3D &pf->mbox_pfvf[0].mbox_up;
> 	mdev =3D &mbox->dev[vf_idx];
>
>-	rsp_hdr =3D (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
>-	offset =3D mbox->rx_start + ALIGN(sizeof(*rsp_hdr),
>MBOX_MSG_ALIGN);
>+	offset =3D mbox->rx_start + ALIGN(sizeof(struct mbox_hdr),
>MBOX_MSG_ALIGN);
>
> 	for (id =3D 0; id < vf_mbox->up_num_msgs; id++) {
> 		msg =3D mdev->mbase + offset;
>--
>2.30.2


