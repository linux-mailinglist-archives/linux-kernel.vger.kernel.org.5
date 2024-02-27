Return-Path: <linux-kernel+bounces-82599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2978686DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9AF1C2531D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555FD4EB3B;
	Tue, 27 Feb 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U/DBeq3a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mjpk+Jqo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9574EB4D;
	Tue, 27 Feb 2024 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000512; cv=fail; b=sW2BZykLyOFxBCldvqLiC5tO25huN+qcFWrR6O/uyleNFkfHdzbKXI1veG9kIe2A13RCKgFB7x8RWHmTK8MlvpRTv5l24bNwss6Z57CyekS/Od9qehO1NndbM6z8JNMKi2cwtPzphIbdHp4WNKS45pmSUhBlOdHwAZrJhCdLzB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000512; c=relaxed/simple;
	bh=HH2l50jkiaNvhpjxwmsGswV1LLCp489UeGddV2sahJU=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=gMWaxlDzH+cLLDqElmsXtky7S5n5O4rsPBzpzn+fRM3EGWT62ZQGCAJ/WILKtU0X2qkUAhLBixqo8toSnkuYB/RHB4LT0fOgg4kEbHRkslyfFRDFZUaX42mbBZud3F+JyPjtKSKglIy1Qprc+APBwPYCgdTpzg2lhrB96V43cwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U/DBeq3a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mjpk+Jqo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1E015023354;
	Tue, 27 Feb 2024 02:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=we106Q+dW9ZGtqXEnkMYNRE0UVvWUsBKd+1lXjRHbsk=;
 b=U/DBeq3as6Q0gNxZCSnDM06MJUn+ww2J2gyFU2FQRSX209Wkie/gMjyALQpSRBVFBXMR
 kDWOUg+1wlwQPmzxZus97uXdq0RVje1k0zCoyc1ia3+zFmuCEC+j65DvR3h4csrYsD+K
 uoPIwdIn+PoDnmhjiXx1ZrUfUlfr/Iu+LtcpqEVf2UTf08zY0sCRILx5+s+wJkDoez1F
 YpR4uKu+adH170HIbzuLJv9pyuW0SrAEN4BGnx4vsfLGRAAhu2cuZm2lMxKX0wa1rfXV
 LQ7+tWXQB6jRaRG3vT2BtzBOSvLE9dAd8smXlwJFP4BXyhXaE3oU+3rJ9yuh3rIasXVn RA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784e5qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:21:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0MqII025534;
	Tue, 27 Feb 2024 02:21:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wd00y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQNeNO7mGgKYa47zSFlfFh3uJV/vYi6VGeUSu2iC22Ckj8KcVhjbMUzoxrH/v6GxrWIXSy7qv/OA88oomYihIKuoPALK4NLuaHJvvgxlaztKARUeKklTilykEL5+V75IeI1yR4QzqIAVkoZaE/EJHQRJCp7dN+ShmhzaaVyBisA2f6xVqVDs9ghOW0SdVcI6SR2ex43hu06HkvIeAza6mExIaufKgkl6qr7FtIdzNtWwUK3OwdN43JtejOrFRT/AqjTe99OnxkksVwFKDrIiHHZlzvM2Ug9GayPWvvfhqIVr1C7AhMLrsr2E8QGtI4qHWxkr500ZaCVfj5z5vKmbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we106Q+dW9ZGtqXEnkMYNRE0UVvWUsBKd+1lXjRHbsk=;
 b=Pm/1I/fVSFi4fSlrbRN1ERbPLEsAzrNQbwqhD4IQA56mVF5T3E24aJtaV2pVQt0GPHhGT6TIsb/yH7XWdxgHw9+wy0yDGHe/MuMBNuQYwgZu6O8SvFVACA5ZlYJDUpjmpQ0Z1uRl9JRsnGQ9hGy6OHLAqDg1nex8gV8SV0k7HmixiaKXnHdXXeJ5f+X6QzN2779nYqLXsmCx/UCu9sCo9287cIdbGfqN+ac+Zmf61Uportebh1Cl8RUki8850kXOY3vPqhvpzlfaaxLNzBkzN1AomL6tBONIoVkHsD3O2cGRB4Yww5f6G0qJ897nZo/BrKzPkxMKL50UG7ScreWE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we106Q+dW9ZGtqXEnkMYNRE0UVvWUsBKd+1lXjRHbsk=;
 b=mjpk+JqoHXgwe0Re6Z31phR4ypFW4ngDWcUI5a9jmkHROrQVTssZG3r86KiQKTWSPF8hoMgFoUOyJWFSZFSmiu70vjblMj73J2KfaQa1CyVn6sA5n2mhTLQgTu5QpEBEQ9TEn7ELAxD12G4kQMKj/sdNNowdVNm9oo6bkc4/I6w=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 02:21:42 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 02:21:41 +0000
To: Justin Stitt <justinstitt@google.com>
Cc: Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: libfc: replace deprecated strncpy with memcpy
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zfvm4pg6.fsf@ca-mkp.ca.oracle.com>
References: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>
Date: Mon, 26 Feb 2024 21:21:39 -0500
In-Reply-To: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>
	(Justin Stitt's message of "Wed, 21 Feb 2024 23:50:26 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:a03:100::31) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|BY5PR10MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f1285f-89bb-41f4-c67b-08dc373ad609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4ZlWM+wQxpD1jkRQTWif96P+yFps+b1Qrhd0OHAfN8IQDr81DlnYogPcPESqAVfeGWdJCm/P2jOwkg9ep0n0022KwCenMRXoUTkM577Bn0Mt9OermcVYW8EgWc6sOPvTMaiso8BR0aF1U7ef5YUaXYBJ5i3+X3NeCOdM09y/udAaWIDwiCYdH0q9bLBJiH3/Eo3Yesve80f/EY67aib3YzuaE8KH/V+tlwA/ekgUyftRzIp3jsbVSgusBSu2QTL3TkRXAZ3bt1xBAcwrHvDVCHX3nwQEBWAwjbwVlBPnfNuXLiJzAKlzdGZil7EIc/hThwChkyQIzFtq8GXl84DHW1AFvNprGJSBQa2AVpE7xOBDKijayUk8kdWex4HZQL7uPO62XHVUaoLaJANAknP+KQ4ncF4jVUzK5s43ESjQuoAdP9lxQZAc2imvKnqXjC90HNuH0Uw4UpSflKhBwahE0lc/3Ag8ncXcJfTc0ZhdmUbpMDIj1shMHXfaLo/faedQgKgYtzasKVonx19Ilhp++naCmlH/1ErfvzNRsVo3JpzeVnNuvBMW4TMkSu0n3u8GMufMSks6D11Im197UnfJorv1wTKsP3xihe8EyAMcHb59BeRYwdimmGiO1yy8/dfk5tAvjIk9bBDmIdzBEJBTpw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q4oFS73aQvSJ4ZdAAQUEkkjBt845d6JirDlrzyNdIEnV27jbiMaKuz++B3hd?=
 =?us-ascii?Q?U95QGyfsq5oxTXu6sl0B+rI6SQPgmxWWxQ926y1PAm6Z69cVBnKk+Keve1S4?=
 =?us-ascii?Q?D7x8k7F2lNO6yPFknCMBI20G5zeH4RxJjCa4prs9SUkO3pmrgAgVLDKKU6gU?=
 =?us-ascii?Q?Xg1qUUf8KzgLPsLiGpnk9GuCXrYG5NO/T5yvwGh3F3DmQw3dI8PVtTKZJQSV?=
 =?us-ascii?Q?eY7gGNyWZAkz9Wzxcw7UDNpkMEq6RfGVg4CzogpP3zAHTV7N1zzRdyOavycE?=
 =?us-ascii?Q?80OkOHot/7SR2NfIb1VSV6eqx8FSmBWJn5Lh/I8AOqJyZQCbV2vKJCm2yGl3?=
 =?us-ascii?Q?kfApC+vmH0KPvtsNXKQALGIyn9brAQsYu+xD/WuSARLaEKlSdxS1VawL5Nqc?=
 =?us-ascii?Q?MsHcmcI/f2K+KuncUAEYdPiCmS3n87zOvSkZ9RPYKuhxv8WOVV7wgSYFEKvg?=
 =?us-ascii?Q?TxOjnIrumcd5+wroXRU6bKmEXnegMmOjgMLOl6QFF9BTw9HKFBqAi5LhmhXe?=
 =?us-ascii?Q?x/4bBEka7C4MFALjXQuNYGQwrgkVV6OJ2T0xjHck44FjAs02ALB4cDLJqPlr?=
 =?us-ascii?Q?mnr0pDcnFya8PlrZCNwUPRDszmGDtXyNL7R/aDdlIhz4/mn12/RMKchuunZS?=
 =?us-ascii?Q?ElR1Y/joJF1hFMUSdjYLMl2sRQR+b3OO9SWH13NeNRSmvRtupNbsazkMIyV9?=
 =?us-ascii?Q?M7GYKw2H30ILlUyMqT8Qm4WBlI+5VDaowowdlL4vd18VSMdM/6u9DfVG4qbg?=
 =?us-ascii?Q?9b7GTE8+ZCkB3jk20FdxG+PQQ4SGup4SQZivQlqUoSJx3sdwlF5Fdci4+Zer?=
 =?us-ascii?Q?iS3eOF/Ipr1JcpznyBOisX/64Bj1xQL/JZo+Z32xShLiuCATIaMcXRk8IBCX?=
 =?us-ascii?Q?t2Oro0pGUL2Hc+u/CRi0LKwWh74fOZZ2lkevml23p0tTKlk2OXkSQdG5F4rv?=
 =?us-ascii?Q?a5R7clbbfG4SInImcUar6Pr7buhYQ0NHIP1V/DF0hCR9N2fbAvMErlLKXyQZ?=
 =?us-ascii?Q?OkR7sXt0i64lA+oQEdrJyHfsFq1bHTeuaB021BdJyBsl1TDN7KzRkDFvvENV?=
 =?us-ascii?Q?HCNOG/puZnE9y76+7TiZZf3rp0yWRYQ0foho96UxQsaTdby4Xe7DnxuJRZE8?=
 =?us-ascii?Q?XlxGrjqFOYWwfYof6poT+GAZr6uQmU969JJunfjtBgc+gwEEy9tOn91VeOad?=
 =?us-ascii?Q?XVMF50SdI+DkcJ0IArAwTp7SlxBd/4i0FFolzUJUlFKEQEBFuv504DkDarqy?=
 =?us-ascii?Q?LTUzzkPDqESdcoJnD0rXPHtl6mLTx5JVlyf7alWDFUIh9t4kX2uLbVBdkTfX?=
 =?us-ascii?Q?GWMzphRnFwAJ+E4moixBPIIScv/OM+OU/UnXPNHqRcl8wA6LC6Nzu08TVroI?=
 =?us-ascii?Q?RbLjXwD0/LojtfuODcWQDkVJW4GTIChVivkT4THVFXmH2ShXmfa+QKn2FnF8?=
 =?us-ascii?Q?bBqGFWZDKJ8B5IP75xcRRM4ZpgdHwuDDYuGXB0f5cATg28uVRT7C0V3anR1p?=
 =?us-ascii?Q?ZRdabAwIYVS5IoX8CJz+2BcwpKp2kKOcWMg0h+B312xOR0K/YbQbxZv9PTCY?=
 =?us-ascii?Q?L2yb1xeTpL2aO7u8rsQrG7s++w7KGyFz4wbki2CkLNogglVa1jWb4myAp1ub?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3MwrUYTzyZwpHDUWF5VdWSoXlazRYSmEqDmQ6M2NX9pTJEe3vrPjyJQA16I9hFeNvF0ZgEqsQQXXXYX4EpfrBs/fsxCjowQFUq67Kxl4fkjZ5dkMfskEI+7UX7fcItMXWM8lCzbNOuQKpjFAsePYPSo4wD6VdxMDRsGKIkIliBnOemxvK2gtj1s+coiqr4fyXMx8dHQOuFKZyeRMXuXcq+nediFWrzXt+tYGvXCfiLq69aJSyIqzGs4487O7w/WRSV1tfWi28jKd7h5h5MbR8FtZyBcbxXVdjCmso9JFNcqMBEhg/tjxiIrhuZKgA8KyoMoW2PWcDA8S4hG/JdjbfPUgHO4jKW4HF315/ZTcCsc4DhQWNFmDWj+aCuwwWShj3ZsGOgonXNYgws3R63Xn9bOdQQi8vn0eyyqBOMQl7Lonqg8tisKIFaoym9usEd1g0tbTHuesUpPREM0cSA25IS4hXuBfLglSjU1fEO0z46wIj5pPYF/807Mv14Q0uhccjeser+ByiCtCj5mjzLMrVOJHtsNXBLnxuh6XlZgDoZfMe8yBc89YtYbRSt7hxgqbYMDD816tnGgTM9WDDshaZ98RNXyWI0egQQCwbCjDgKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f1285f-89bb-41f4-c67b-08dc373ad609
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 02:21:41.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdYAPMS4z45OMPCtkWX/yT5pe98IaIRlIawn+z8xZqCxJVxgSPG7CQMsgJ7xR+rHbVA7/Da/hDaBaoCu7RJeu1kHWMpfQSQMQzZS/XIh2+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=748 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270017
X-Proofpoint-GUID: ICyF3VvM2DI7G7vKwbhCU2XvJdawVGzh
X-Proofpoint-ORIG-GUID: ICyF3VvM2DI7G7vKwbhCU2XvJdawVGzh


Justin,

> strncpy() is deprecated [1] and as such we should use different apis to
> copy string data.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

