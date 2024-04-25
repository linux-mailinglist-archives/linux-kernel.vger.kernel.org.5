Return-Path: <linux-kernel+bounces-158030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE47A8B1A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B51B2213C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98AA3C47C;
	Thu, 25 Apr 2024 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jgP1giLK"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531E2940B;
	Thu, 25 Apr 2024 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023989; cv=fail; b=dQXF0LQx+eqcKsPGe7JFIqPSBPg8Kesdw6WSzrjO/VsSDj6q4XjQJGz7rhQIAGDmtdWuYAsj/CgXkBxIHVM3PR8Gcl1BJRet4zcgRd8ZZfcr9fjL6nXkbbhWxSP4kGpDPWcd0drSjtcRpAQ2AHD37nT0V/FNotBVp/xTxQGvPbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023989; c=relaxed/simple;
	bh=U8ckorjeDQDddvw1C+rNVsJPDYzlORg934+XX8mVpgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DRZtQhtIkVKPV0eKIkGvFScprR6OCNsOcWHa7XYoN1xoUj2LSQzLnrIeB9oSOoXCHCEwDcHHKYcA8cky4hAWI7QU+8vByVKH59uQieXdjdW3uEe1oo06L2NWevA98nul3LzDSavqT6yuK4bpfLvq3ZWhh2RrjgEmf3EFxYSBd2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jgP1giLK; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P1hkgT031580;
	Wed, 24 Apr 2024 22:46:20 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xq284be1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwN66VKewViW51D4IDC296Mas3B3pGUT/o0DnO2lKLkeCYaVLaet8fo1NCJ2Ccr8vATKPVQQqQQvaFSVF5D0lwbRVuPpk++FRIRkbQn58jVZBpWXzqrRy07e32+7/BB+6Qq9UekbNtx8lKiV6iyyB139p9IiIIdSJLXwG8VXR/xlIsnk6gAqFzRTWZv1h4NYQU1/Nw0Iffy/pwavjVYtERys9ayvbmpCuHRGyK8JqldnoK3Fib1xsEMXxEybe6sGs8rLzMRpWEWF2mh15lPckVZIpZm+X+N0+7eyhmCeodI2n0f+eqhd5TFDDyskVp1VbWmgSpDTqU4IfZQqTa+NdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q1CcTWhjgPvmiflzUuYIQ7TXFF4/OutBYgaKKyU430=;
 b=eNsTlagMqn6lyjABMSnVUc0HBx520lxzk+7+MvZReIsLveXeK3F1kj7gsKWXKG94g+WeMYKG+xJAuxLVMXychTp8Z89y9tRHNE2L3tE8P3vmvjKXS259IxRk6QhbfVeClO9qT1ej7PDpWpEBNe8ymMxDdFDz5TijuhSfnJtDliTN6nP67kRMt6wYVKnAD2/Zu1fhCpLyMKn1fpThepBX7IH+X4izCV4mAjr5rYZkPQG+pRSyPxy86A4xiBMjiiiaBwlJBkUI7PKDw9xCEp33MlCeMM/Q6hYMTwXLOWEHATdq/+pn15e9rbSri5yAxr5LD4qrFWVHJhYwb9YhEhJg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q1CcTWhjgPvmiflzUuYIQ7TXFF4/OutBYgaKKyU430=;
 b=jgP1giLKwHQqPqyqegGVCTrGxXOYtHx55a+HAKs+8Qbtz0xPj2iocfrof94yBuw/+tCzBb2CwkjDI6oIr9IqzAMCNUY7d2TfqYDIV3/OV1eD6/qECIave66e2QuineVoEs0Ds6H9kgQuC8jeIbqhPfjcEaz6Z1B3AxCF2bWiiP0=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by MN2PR18MB3687.namprd18.prod.outlook.com (2603:10b6:208:261::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 05:46:04 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 05:46:04 +0000
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
Subject: RE: [EXTERNAL] [PATCH 5/7] cbd: introuce cbd_backend
Thread-Topic: [EXTERNAL] [PATCH 5/7] cbd: introuce cbd_backend
Thread-Index: AQHalIZXtg7sP9JDg0iSsOxLAWLmYLF4eY5w
Date: Thu, 25 Apr 2024 05:46:04 +0000
Message-ID: 
 <SN7PR18MB5314F2FED0DBCD7EDC80872DE3172@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-6-dongsheng.yang@easystack.cn>
In-Reply-To: <20240422071606.52637-6-dongsheng.yang@easystack.cn>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|MN2PR18MB3687:EE_
x-ms-office365-filtering-correlation-id: dad42cc8-c1e3-400b-e97c-08dc64eaff3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?lSsfVv2YsPYyjrMpb42bgWZA4gcl3gYWeCfWB+bGu7mg6nLJc7rG8NeDzbR4?=
 =?us-ascii?Q?ca8HFrHWbtgDCJ3LmLB42wujVRuMGQq+cxaXv80uKoCyEe8MzHOZjiTzawj+?=
 =?us-ascii?Q?kTUddxPUH3FbBCpOekxOV0H/oQQr5GWLdnh1zil+oxtbSI4KLgGEgCMGR70R?=
 =?us-ascii?Q?a1W/4FcPiX0+JlfbppfG5loVT87/QScF1r966egxvrPf4KkBTejYBl5T2Hc5?=
 =?us-ascii?Q?QuOqAPfK4LsM9nu1Y4FdaScZxESd8QvcB22oK8ero3Lafyg5dIVjmuviiCQI?=
 =?us-ascii?Q?NgHN+PECebwtfTRV8XSm48SnvWiEtgmeu4w9Yu48cVH9Q2ZJRMo5WkcdzidH?=
 =?us-ascii?Q?nfxnWxbH0C1Bg9XWD1Wkt7vRSipnVCJG3iZhS6U+KiLBTcpcfgU/nqp4lhRh?=
 =?us-ascii?Q?CyuA1W+l5vSZP4yw4b3Z8y3ug0Ucbkr380yTdE9jouuheJwIR0rjpEK8bh0O?=
 =?us-ascii?Q?hE/SWxKVnpioMd7w46VB95F+jbBv2GpNfl6eq6YanSraP0noUpQdNH9kCjfN?=
 =?us-ascii?Q?JkXnRf3jJqYwFUwg0H8m6yyLvD7erFYxsPVdrFSL50GBTQHaGda8kror8NiR?=
 =?us-ascii?Q?sYYAPwR4MGaWXhNYD6M0Zqm0LTHCMoeK42b64pllXQE3T3sJMTqEtfOonvel?=
 =?us-ascii?Q?fEtWJf5tGhVlzof5xcSlfz/RP784aflUJUCdA7Z28K6/YZ+Tr/VcG4bFFsCm?=
 =?us-ascii?Q?JIXwtxwkYsXUcVPdce/bxlUFd5FmBIE1ZHKH8GKACeWbuoqaSyvhXjB9sXVE?=
 =?us-ascii?Q?dkRN8TbNazPL8MfWEK21gwVLx7L/7FZQN9/AB4XjtQOQtIDtUpM2WdiBC0cf?=
 =?us-ascii?Q?dd9YZ/LkH9TRxAc3IoUM9Iq2kidDiIDZxLUnmPmTkdUPBkL42nJUYMUk4dWx?=
 =?us-ascii?Q?e2xcBMdR40++uVQ94Jfjehh298PfzWOS+/9wVIxwDI2PlRzYPVV59D0lXhRG?=
 =?us-ascii?Q?pFSQzrafY0oYLPB/ot9g2pMK8wOUCY8MoVFWl3EkO4eZPnb1mkis35ZfiPLF?=
 =?us-ascii?Q?/fedSYpZICEDK6u4xrszCRc56D1KMIQdXG757ahUC/JPnANEaMXLkFZMb6db?=
 =?us-ascii?Q?f4ACjdqt+wDR9EIEcD/lxnuy+aWuvrqS2I9B7ebulH0CeYfA22nTnzKFdNCI?=
 =?us-ascii?Q?ZJSdt4maHOQ5itLCPIXZmOVAssCRd5e2rkYtbVrXPkI9iPbu8bMAiVchjUGb?=
 =?us-ascii?Q?8yaxSISZN5Vwpn7/mv+Y8WXbX09Ki2npkap7rtrDJXu8tr6W3w8sSy8nbXzB?=
 =?us-ascii?Q?SfnsZK4k6yUYFWVdywXGIX2fiCQQaoOXfmKcNVLx28ct4yukzbUccKC1XYej?=
 =?us-ascii?Q?iEVZtejcj+r/Dlirk+lF0A+FpaT+pd+bpXV2LfGXQ0thFg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pvIOgiSVfPtehnOXlGG8zK+72PRI1ot04IpxHP73dYrCRzJ0AYkOq4T/A6Ou?=
 =?us-ascii?Q?avTiB9SiRdlr/B5Ly+Ep9aK6dPnU6j/T0fDKQZ9tCt+ll62Rn2inBJWHdHNq?=
 =?us-ascii?Q?pda3o2qFbsocYZD9o7nnlHLL298cZl0Q4+8+LxELDpRXJqQp+UBPrcs4WmKT?=
 =?us-ascii?Q?JFsW7bzEhikymx4JWR6rZdi3jb4Z26NrzD9IfQfHIk58511vaJXHfB02Cquq?=
 =?us-ascii?Q?gkL1IzG+azAOfMu3wVe19ceiv5BhKdw+ypy9/ubiYWxepl94P7wtochOx1dy?=
 =?us-ascii?Q?hiehaMk1rWaJplTzzjc8lKURAL0KBvyyl3moY5Zb5J0Sn7lPS+rStEjOpZgR?=
 =?us-ascii?Q?mWz9+pfdj73VrdukjGlHalikBxohdt6NtEpzLHsGTvZFoI8YwbKCZzpWm5G/?=
 =?us-ascii?Q?nfKqhbcT6kY1fScGI2FDx6TCkoiVyxY8DxN0N18JS/nTZJnyCs9m2c2F7e22?=
 =?us-ascii?Q?CVuMekqXLDk6AeNxWGDwFfwLR/v+ssVDMrR5GrBKB0Sqao1SOHAw4Kzcx+VR?=
 =?us-ascii?Q?P8G4nLgxhx5y7DwPDAw06yS0g1rVhW/SWvFsXmig66nOSCkKDDQEtO1CoXqv?=
 =?us-ascii?Q?T8AcPpNkIByJyxNFeaa639yqNfFnW+8zG8ewn24jkrK0e9M7U2jowoxn63Mt?=
 =?us-ascii?Q?OpmRDvsyYqo8NNe1l+jgYBujL11R4NC0P7115t1m/XqgCj/Vr8fgzWOC01uT?=
 =?us-ascii?Q?5L8WGAKZ4lLqiXbB0tEPUSNX8Qbrg6QUr5K+3maPvqqiJ94WZk+mxiG1DI0p?=
 =?us-ascii?Q?ErfyT42AjOPIBLiHH64anMiD9RDd2gthQOeIJk8iBp8S0FCk4eAu8HUIg2ee?=
 =?us-ascii?Q?39mz4PU0FHa8IDQuER760kLzaC04Fb2w3ALny6YR6K1SK0QxNWKUBWv631Az?=
 =?us-ascii?Q?QHSaEytuU1KxwBlbivsd1jSA8JWJOITMl0C+OPREdLnBgjPAdOwIbmTEIKqN?=
 =?us-ascii?Q?TN7fUBuvS68f1XQkLyE6WsXsz2Iir0y3L6hXPw+3oz1ADSrNOjZfuMGi9wBL?=
 =?us-ascii?Q?/jvaZe0t/g5U002j41R455cKK+vFNmq7w6yo2z8fgtyVkGLtedSpXvbOo1YV?=
 =?us-ascii?Q?ZPKdhVyq2LK3dyhl/WI3ADG0Mrk57wrYa0/Jm8lZ1vcpPabRWO+wOcL5P24x?=
 =?us-ascii?Q?kftiC6AnMNVf9f9REewiOQpySS228usY+YOYhE+vX8P3Q5twtzEb1tfpSaGU?=
 =?us-ascii?Q?ZzeXQA/iUdo191rNWuD8EKXJwpYT5zwbcFZbFQNf7tchGzZ/jABO+rC5S6g8?=
 =?us-ascii?Q?s+DwuX+8eXshBzDH+1xcKury/o590YcNrl87X3ikB6isLdwiCu7MsosuglfT?=
 =?us-ascii?Q?3l+kII05/300ybXqoPRi9jSFf9Ne1PVFC5MWTEe1RKP5cM8C9ucNflM0edsO?=
 =?us-ascii?Q?lT+gDE+KuSCeUP1pd8pXhkOcnjMN7gXoMAe1OVqaeqop+GuMYu9z9FsgXsyw?=
 =?us-ascii?Q?ag7bU3mcDEqgCk+iD//x1FC8dXfAeGWuGDLhhA2ghJuHw+1EVd+bkWtnP+Sz?=
 =?us-ascii?Q?nMxH4rh7XfdeYZ3dDvJ+bTUb609dlRExAcfkCxoDz2NFNRNlz99PEzwnGEEY?=
 =?us-ascii?Q?fSfTQ/YZ6n+6gyo4SsJwhrj0czJnkVyUmvv0TL8l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dad42cc8-c1e3-400b-e97c-08dc64eaff3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 05:46:04.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzQzsrpBsAZfsPdmOyAmu0BaypdJ9BxQhA1G8H5+Ysa5lZQtGUlodtfQr0Tl6dx/kfUsj63LR/jzcRWv54o2/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3687
X-Proofpoint-GUID: MjX264OBaWlpVLFkMRDcQO7i-rcHoaYL
X-Proofpoint-ORIG-GUID: MjX264OBaWlpVLFkMRDcQO7i-rcHoaYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-25_01,2023-05-22_02



> -----Original Message-----
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
> Sent: Monday, April 22, 2024 12:46 PM
> To: dan.j.williams@intel.com; axboe@kernel.dk
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> cxl@vger.kernel.org; Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> Subject: [EXTERNAL] [PATCH 5/7] cbd: introuce cbd_backend
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
>=20
> The "cbd_backend" is responsible for exposing a local block device (such =
as
> "/dev/sda") through the "cbd_transport" to other hosts.
>=20
> Any host that registers this transport can map this backend to a local "c=
bd
> device"(such as "/dev/cbd0"). All reads and writes to "cbd0" are transmit=
ted
> through the channel inside the transport to the backend. The handler insi=
de
> the backend is responsible for processing these read and write requests,
> converting them into read and write requests corresponding to "sda".
>=20
> Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> ---
>  drivers/block/cbd/Makefile        |   2 +-
>  drivers/block/cbd/cbd_backend.c   | 254
> +++++++++++++++++++++++++++++
>  drivers/block/cbd/cbd_handler.c   | 261
> ++++++++++++++++++++++++++++++
>  drivers/block/cbd/cbd_transport.c |   6 +
>  4 files changed, 522 insertions(+), 1 deletion(-)  create mode 100644
> drivers/block/cbd/cbd_backend.c  create mode 100644
> drivers/block/cbd/cbd_handler.c
>=20
> diff --git a/drivers/block/cbd/Makefile b/drivers/block/cbd/Makefile inde=
x
> 2389a738b12b..b47f1e584946 100644
> --- a/drivers/block/cbd/Makefile
> +++ b/drivers/block/cbd/Makefile
> @@ -1,3 +1,3 @@
> -cbd-y :=3D cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o
> +cbd-y :=3D cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o
> +cbd_backend.o cbd_handler.o
>=20
>  obj-$(CONFIG_BLK_DEV_CBD) +=3D cbd.o
> diff --git a/drivers/block/cbd/cbd_backend.c
> b/drivers/block/cbd/cbd_backend.c new file mode 100644 index
> 000000000000..a06f319e62c4
> --- /dev/null
> +++ b/drivers/block/cbd/cbd_backend.c
> @@ -0,0 +1,254 @@
> +#include "cbd_internal.h"
> +
> +static ssize_t backend_host_id_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cbd_backend_device *backend;
> +	struct cbd_backend_info *backend_info;
> +
> +	backend =3D container_of(dev, struct cbd_backend_device, dev);
> +	backend_info =3D backend->backend_info;
> +
> +	cbdt_flush_range(backend->cbdt, backend_info,
> sizeof(*backend_info));
> +
> +	if (backend_info->state =3D=3D cbd_backend_state_none)
> +		return 0;
> +
> +	return sprintf(buf, "%u\n", backend_info->host_id); }
> +
> +static DEVICE_ATTR(host_id, 0400, backend_host_id_show, NULL);
> +
> +static ssize_t backend_path_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cbd_backend_device *backend;
> +	struct cbd_backend_info *backend_info;
> +
> +	backend =3D container_of(dev, struct cbd_backend_device, dev);
> +	backend_info =3D backend->backend_info;
> +
> +	cbdt_flush_range(backend->cbdt, backend_info,
> sizeof(*backend_info));
> +
> +	if (backend_info->state =3D=3D cbd_backend_state_none)
> +		return 0;
> +
> +	if (strlen(backend_info->path) =3D=3D 0)

Cosmetic comment, maybe we can use=20
	if (!strlen(backend_info->path))

> +		return 0;
> +
> +	return sprintf(buf, "%s\n", backend_info->path); }

Sprintf is safe to provide zero length source buffer. Maybe above zero leng=
th check can be removed.


> +
> +static DEVICE_ATTR(path, 0400, backend_path_show, NULL);
> +
> +CBD_OBJ_HEARTBEAT(backend);
> +
> +static struct attribute *cbd_backend_attrs[] =3D {
> +	&dev_attr_path.attr,
> +	&dev_attr_host_id.attr,
> +	&dev_attr_alive.attr,
> +	NULL
> +};
> +
> +static struct attribute_group cbd_backend_attr_group =3D {
> +	.attrs =3D cbd_backend_attrs,
> +};
> +
> +static const struct attribute_group *cbd_backend_attr_groups[] =3D {
> +	&cbd_backend_attr_group,
> +	NULL
> +};
> +
> +static void cbd_backend_release(struct device *dev) { }
> +
> +struct device_type cbd_backend_type =3D {
> +	.name		=3D "cbd_backend",
> +	.groups		=3D cbd_backend_attr_groups,
> +	.release	=3D cbd_backend_release,
> +};
> +
> +struct device_type cbd_backends_type =3D {
> +	.name		=3D "cbd_backends",
> +	.release	=3D cbd_backend_release,
> +};
> +
> +void cbdb_add_handler(struct cbd_backend *cbdb, struct cbd_handler
> +*handler) {
> +	mutex_lock(&cbdb->lock);
> +	list_add(&handler->handlers_node, &cbdb->handlers);
> +	mutex_unlock(&cbdb->lock);
> +}
> +
> +void cbdb_del_handler(struct cbd_backend *cbdb, struct cbd_handler
> +*handler) {
> +	mutex_lock(&cbdb->lock);
> +	list_del_init(&handler->handlers_node);
> +	mutex_unlock(&cbdb->lock);
> +}
> +
> +static struct cbd_handler *cbdb_get_handler(struct cbd_backend *cbdb,
> +u32 channel_id) {
> +	struct cbd_handler *handler, *handler_next;
> +	bool found =3D false;
> +
> +	mutex_lock(&cbdb->lock);
> +	list_for_each_entry_safe(handler, handler_next, &cbdb->handlers,
> handlers_node) {
> +		if (handler->channel.channel_id =3D=3D channel_id) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cbdb->lock);
> +
> +	if (!found) {
> +		return ERR_PTR(-ENOENT);
> +	}

Do not need "{ }" with single line.

Looks like these braces are used in this series at multiple places, please =
remove

> +
> +	return handler;
> +}
> +
> +static void state_work_fn(struct work_struct *work) {
> +	struct cbd_backend *cbdb =3D container_of(work, struct cbd_backend,
> state_work.work);
> +	struct cbd_transport *cbdt =3D cbdb->cbdt;
> +	struct cbd_channel_info *channel_info;
> +	u32 blkdev_state, backend_state, backend_id;
> +	int i;
> +
> +	for (i =3D 0; i < cbdt->transport_info->channel_num; i++) {
> +		channel_info =3D cbdt_get_channel_info(cbdt, i);
> +
> +		cbdt_flush_range(cbdt, channel_info, sizeof(*channel_info));
> +		blkdev_state =3D channel_info->blkdev_state;
> +		backend_state =3D channel_info->backend_state;
> +		backend_id =3D channel_info->backend_id;
> +
> +		if (blkdev_state =3D=3D cbdc_blkdev_state_running &&
> +				backend_state =3D=3D cbdc_backend_state_none
> &&
> +				backend_id =3D=3D cbdb->backend_id) {
> +
> +			cbd_handler_create(cbdb, i);
> +		}
> +
> +		if (blkdev_state =3D=3D cbdc_blkdev_state_none &&
> +				backend_state =3D=3D
> cbdc_backend_state_running &&
> +				backend_id =3D=3D cbdb->backend_id) {
> +			struct cbd_handler *handler;
> +
> +			handler =3D cbdb_get_handler(cbdb, i);
> +			cbd_handler_destroy(handler);
> +		}
> +	}
> +
> +	queue_delayed_work(cbd_wq, &cbdb->state_work, 1 * HZ); }
> +
> +static int cbd_backend_init(struct cbd_backend *cbdb) {
> +	struct cbd_backend_info *b_info;
> +	struct cbd_transport *cbdt =3D cbdb->cbdt;
> +
> +	b_info =3D cbdt_get_backend_info(cbdt, cbdb->backend_id);
> +	cbdb->backend_info =3D b_info;
> +
> +	b_info->host_id =3D cbdb->cbdt->host->host_id;
> +
> +	cbdb->bdev_handle =3D bdev_open_by_path(cbdb->path,
> BLK_OPEN_READ | BLK_OPEN_WRITE, cbdb, NULL);
> +	if (IS_ERR(cbdb->bdev_handle)) {
> +		cbdt_err(cbdt, "failed to open bdev: %d", (int)PTR_ERR(cbdb-
> >bdev_handle));
> +		return PTR_ERR(cbdb->bdev_handle);
> +	}
> +	cbdb->bdev =3D cbdb->bdev_handle->bdev;
> +	b_info->dev_size =3D bdev_nr_sectors(cbdb->bdev);
> +
> +	INIT_DELAYED_WORK(&cbdb->state_work, state_work_fn);
> +	INIT_DELAYED_WORK(&cbdb->hb_work, backend_hb_workfn);
> +	INIT_LIST_HEAD(&cbdb->handlers);
> +	cbdb->backend_device =3D
> +&cbdt->cbd_backends_dev->backend_devs[cbdb->backend_id];
> +
> +	mutex_init(&cbdb->lock);
> +
> +	queue_delayed_work(cbd_wq, &cbdb->state_work, 0);
> +	queue_delayed_work(cbd_wq, &cbdb->hb_work, 0);
> +
> +	return 0;
> +}
> +
> +int cbd_backend_start(struct cbd_transport *cbdt, char *path) {
> +	struct cbd_backend *backend;
> +	struct cbd_backend_info *backend_info;
> +	u32 backend_id;
> +	int ret;
> +
> +	ret =3D cbdt_get_empty_backend_id(cbdt, &backend_id);
> +	if (ret) {
> +		return ret;
> +	}

Same comment as above

> +
> +	backend_info =3D cbdt_get_backend_info(cbdt, backend_id);
> +
> +	backend =3D kzalloc(sizeof(struct cbd_backend), GFP_KERNEL);
> +	if (!backend) {
> +		return -ENOMEM;
> +	}

Same comment as above

> +
> +	strscpy(backend->path, path, CBD_PATH_LEN);
> +	memcpy(backend_info->path, backend->path, CBD_PATH_LEN);
> +	INIT_LIST_HEAD(&backend->node);
> +	backend->backend_id =3D backend_id;
> +	backend->cbdt =3D cbdt;
> +
> +	ret =3D cbd_backend_init(backend);
> +	if (ret) {
> +		goto backend_free;
> +	}
> +
> +	backend_info->state =3D cbd_backend_state_running;
> +	cbdt_flush_range(cbdt, backend_info, sizeof(*backend_info));
> +
> +	cbdt_add_backend(cbdt, backend);
> +
> +	return 0;
> +
> +backend_free:
> +	kfree(backend);
> +
> +	return ret;
> +}
> +
> +int cbd_backend_stop(struct cbd_transport *cbdt, u32 backend_id) {
> +	struct cbd_backend *cbdb;
> +	struct cbd_backend_info *backend_info;
> +
> +	cbdb =3D cbdt_get_backend(cbdt, backend_id);
> +	if (!cbdb) {
> +		return -ENOENT;
> +	}
> +
> +	mutex_lock(&cbdb->lock);
> +	if (!list_empty(&cbdb->handlers)) {
> +		mutex_unlock(&cbdb->lock);
> +		return -EBUSY;
> +	}
> +
> +	cbdt_del_backend(cbdt, cbdb);
> +
> +	cancel_delayed_work_sync(&cbdb->hb_work);
> +	cancel_delayed_work_sync(&cbdb->state_work);
> +
> +	backend_info =3D cbdt_get_backend_info(cbdt, cbdb->backend_id);
> +	backend_info->state =3D cbd_backend_state_none;
> +	cbdt_flush_range(cbdt, backend_info, sizeof(*backend_info));
> +	mutex_unlock(&cbdb->lock);
> +
> +	bdev_release(cbdb->bdev_handle);
> +	kfree(cbdb);
> +
> +	return 0;
> +}
> diff --git a/drivers/block/cbd/cbd_handler.c
> b/drivers/block/cbd/cbd_handler.c new file mode 100644 index
> 000000000000..0fbfc225ea29
> --- /dev/null
> +++ b/drivers/block/cbd/cbd_handler.c
> @@ -0,0 +1,261 @@
> +#include "cbd_internal.h"
> +
> +static inline struct cbd_se *get_se_head(struct cbd_handler *handler) {
> +	return (struct cbd_se *)(handler->channel.cmdr +
> +handler->channel_info->cmd_head); }
> +
> +static inline struct cbd_se *get_se_to_handle(struct cbd_handler
> +*handler) {
> +	return (struct cbd_se *)(handler->channel.cmdr +
> +handler->se_to_handle); }
> +
> +static inline struct cbd_ce *get_compr_head(struct cbd_handler
> +*handler) {
> +	return (struct cbd_ce *)(handler->channel.compr +
> +handler->channel_info->compr_head);
> +}
> +
> +struct cbd_backend_io {
> +	struct cbd_se		*se;
> +	u64			off;
> +	u32			len;
> +	struct bio		*bio;
> +	struct cbd_handler	*handler;
> +};
> +
> +static inline void complete_cmd(struct cbd_handler *handler, u64
> +priv_data, int ret) {
> +	struct cbd_ce *ce =3D get_compr_head(handler);
> +
> +	memset(ce, 0, sizeof(*ce));
> +	ce->priv_data =3D priv_data;
> +	ce->result =3D ret;
> +	CBDC_UPDATE_COMPR_HEAD(handler->channel_info->compr_head,
> +			       sizeof(struct cbd_ce),
> +			       handler->channel_info->compr_size);
> +
> +	cbdc_flush_ctrl(&handler->channel);
> +
> +	return;
> +}
> +
> +static void backend_bio_end(struct bio *bio) {
> +	struct cbd_backend_io *backend_io =3D bio->bi_private;
> +	struct cbd_se *se =3D backend_io->se;
> +	struct cbd_handler *handler =3D backend_io->handler;
> +
> +	if (bio->bi_status =3D=3D 0 &&
> +	    cbd_se_hdr_get_op(se->header.len_op) =3D=3D CBD_OP_READ) {
> +		cbdc_copy_from_bio(&handler->channel, se->data_off, se-
> >data_len, bio);
> +	}
> +
> +	complete_cmd(handler, se->priv_data, bio->bi_status);
> +
> +	bio_free_pages(bio);
> +	bio_put(bio);
> +	kfree(backend_io);
> +}
> +
> +static int cbd_bio_alloc_pages(struct bio *bio, size_t size, gfp_t
> +gfp_mask) {
> +	int ret =3D 0;
> +
> +        while (size) {
> +                struct page *page =3D alloc_pages(gfp_mask, 0);
> +                unsigned len =3D min_t(size_t, PAGE_SIZE, size);
> +
> +                if (!page) {
> +			pr_err("failed to alloc page");
> +			ret =3D -ENOMEM;
> +			break;
> +		}
> +
> +		ret =3D bio_add_page(bio, page, len, 0);
> +                if (unlikely(ret !=3D len)) {
> +                        __free_page(page);
> +			pr_err("failed to add page");
> +                        break;
> +                }
> +
> +                size -=3D len;
> +        }
> +
> +	if (size)
> +		bio_free_pages(bio);
> +	else
> +		ret =3D 0;
> +
> +        return ret;
> +}
> +
> +static struct cbd_backend_io *backend_prepare_io(struct cbd_handler
> +*handler, struct cbd_se *se, blk_opf_t opf) {
> +	struct cbd_backend_io *backend_io;
> +	struct cbd_backend *cbdb =3D handler->cbdb;
> +
> +	backend_io =3D kzalloc(sizeof(struct cbd_backend_io), GFP_KERNEL);
> +	backend_io->se =3D se;
> +
> +	backend_io->handler =3D handler;
> +	backend_io->bio =3D bio_alloc_bioset(cbdb->bdev, roundup(se->len,
> 4096)
> +/ 4096, opf, GFP_KERNEL, &handler->bioset);
> +
> +	backend_io->bio->bi_iter.bi_sector =3D se->offset >> SECTOR_SHIFT;
> +	backend_io->bio->bi_iter.bi_size =3D 0;
> +	backend_io->bio->bi_private =3D backend_io;
> +	backend_io->bio->bi_end_io =3D backend_bio_end;
> +
> +	return backend_io;
> +}
> +
> +static int handle_backend_cmd(struct cbd_handler *handler, struct
> +cbd_se *se) {
> +	struct cbd_backend *cbdb =3D handler->cbdb;
> +	u32 len =3D se->len;
> +	struct cbd_backend_io *backend_io =3D NULL;
> +	int ret;
> +
> +	if (cbd_se_hdr_flags_test(se, CBD_SE_HDR_DONE)) {
> +		return 0 ;
> +	}
> +
> +	switch (cbd_se_hdr_get_op(se->header.len_op)) {
> +	case CBD_OP_PAD:
> +		cbd_se_hdr_flags_set(se, CBD_SE_HDR_DONE);
> +		return 0;
> +	case CBD_OP_READ:
> +		backend_io =3D backend_prepare_io(handler, se,
> REQ_OP_READ);
> +		break;
> +	case CBD_OP_WRITE:
> +		backend_io =3D backend_prepare_io(handler, se,
> REQ_OP_WRITE);
> +		break;
> +	case CBD_OP_DISCARD:
> +		ret =3D blkdev_issue_discard(cbdb->bdev, se->offset >>
> SECTOR_SHIFT,
> +				se->len, GFP_NOIO);
> +		goto complete_cmd;
> +	case CBD_OP_WRITE_ZEROS:
> +		ret =3D blkdev_issue_zeroout(cbdb->bdev, se->offset >>
> SECTOR_SHIFT,
> +				se->len, GFP_NOIO, 0);
> +		goto complete_cmd;
> +	case CBD_OP_FLUSH:
> +		ret =3D blkdev_issue_flush(cbdb->bdev);
> +		goto complete_cmd;
> +	default:
> +		pr_err("unrecognized op: %x", cbd_se_hdr_get_op(se-
> >header.len_op));
> +		ret =3D -EIO;
> +		goto complete_cmd;
> +	}
> +
> +	if (!backend_io)
> +		return -ENOMEM;
> +
> +	ret =3D cbd_bio_alloc_pages(backend_io->bio, len, GFP_NOIO);
> +	if (ret) {
> +		kfree(backend_io);
> +		return ret;
> +	}
> +
> +	if (cbd_se_hdr_get_op(se->header.len_op) =3D=3D CBD_OP_WRITE) {
> +		cbdc_copy_to_bio(&handler->channel, se->data_off, se-
> >data_len, backend_io->bio);
> +	}
> +
> +	submit_bio(backend_io->bio);
> +
> +	return 0;
> +
> +complete_cmd:
> +	complete_cmd(handler, se->priv_data, ret);
> +	return 0;
> +}
> +
> +static void handle_work_fn(struct work_struct *work) {
> +	struct cbd_handler *handler =3D container_of(work, struct cbd_handler,
> handle_work.work);
> +	struct cbd_se *se;
> +	int ret;
> +again:
> +	/* channel ctrl would be updated by blkdev queue */
> +	cbdc_flush_ctrl(&handler->channel);
> +	se =3D get_se_to_handle(handler);
> +	if (se =3D=3D get_se_head(handler)) {
> +		if (cbdwc_need_retry(&handler->handle_worker_cfg)) {
> +			goto again;
> +		}
> +
> +		cbdwc_miss(&handler->handle_worker_cfg);
> +
> +		queue_delayed_work(handler->handle_wq, &handler-
> >handle_work, usecs_to_jiffies(0));
> +		return;
> +	}
> +
> +	cbdwc_hit(&handler->handle_worker_cfg);
> +	cbdt_flush_range(handler->cbdb->cbdt, se, sizeof(*se));
> +	ret =3D handle_backend_cmd(handler, se);
> +	if (!ret) {
> +		/* this se is handled */
> +		handler->se_to_handle =3D (handler->se_to_handle +
> cbd_se_hdr_get_len(se->header.len_op)) % handler->channel_info-
> >cmdr_size;
> +	}
> +
> +	goto again;
> +}
> +
> +int cbd_handler_create(struct cbd_backend *cbdb, u32 channel_id) {
> +	struct cbd_transport *cbdt =3D cbdb->cbdt;
> +	struct cbd_handler *handler;
> +	int ret;
> +
> +	handler =3D kzalloc(sizeof(struct cbd_handler), GFP_KERNEL);
> +	if (!handler) {
> +		return -ENOMEM;
> +	}
> +
> +	handler->cbdb =3D cbdb;
> +	cbd_channel_init(&handler->channel, cbdt, channel_id);
> +	handler->channel_info =3D handler->channel.channel_info;
> +
> +	handler->handle_wq =3D alloc_workqueue("cbdt%u-handler%u",
> +					     WQ_UNBOUND |
> WQ_MEM_RECLAIM,
> +					     0, cbdt->id, channel_id);
> +	if (!handler->handle_wq) {
> +		ret =3D -ENOMEM;
> +		goto free_handler;
> +	}
> +
> +	handler->se_to_handle =3D handler->channel_info->cmd_tail;
> +
> +	INIT_DELAYED_WORK(&handler->handle_work, handle_work_fn);
> +	INIT_LIST_HEAD(&handler->handlers_node);
> +
> +	bioset_init(&handler->bioset, 128, 0, BIOSET_NEED_BVECS);
> +	cbdwc_init(&handler->handle_worker_cfg);
> +
> +	cbdb_add_handler(cbdb, handler);
> +	handler->channel_info->backend_state =3D
> cbdc_backend_state_running;
> +
> +	cbdt_flush_range(cbdt, handler->channel_info,
> +sizeof(*handler->channel_info));
> +
> +	queue_delayed_work(handler->handle_wq, &handler->handle_work,
> 0);
> +
> +	return 0;
> +
> +free_handler:
> +	kfree(handler);
> +	return ret;
> +};
> +
> +void cbd_handler_destroy(struct cbd_handler *handler) {
> +	cbdb_del_handler(handler->cbdb, handler);
> +
> +	cancel_delayed_work_sync(&handler->handle_work);
> +	drain_workqueue(handler->handle_wq);
> +	destroy_workqueue(handler->handle_wq);
> +
> +	handler->channel_info->backend_state =3D cbdc_backend_state_none;
> +	handler->channel_info->state =3D cbd_channel_state_none;
> +	cbdt_flush_range(handler->cbdb->cbdt, handler->channel_info,
> +sizeof(*handler->channel_info));
> +
> +	bioset_exit(&handler->bioset);
> +	kfree(handler);
> +}
> diff --git a/drivers/block/cbd/cbd_transport.c
> b/drivers/block/cbd/cbd_transport.c
> index 682d0f45ce9e..4dd9bf1b5fd5 100644
> --- a/drivers/block/cbd/cbd_transport.c
> +++ b/drivers/block/cbd/cbd_transport.c
> @@ -303,8 +303,14 @@ static ssize_t cbd_adm_store(struct device *dev,
>=20
>  	switch (opts.op) {
>  	case CBDT_ADM_OP_B_START:
> +		ret =3D cbd_backend_start(cbdt, opts.backend.path);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	case CBDT_ADM_OP_B_STOP:
> +		ret =3D cbd_backend_stop(cbdt, opts.backend_id);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	case CBDT_ADM_OP_B_CLEAR:
>  		break;
> --
> 2.34.1
>=20


