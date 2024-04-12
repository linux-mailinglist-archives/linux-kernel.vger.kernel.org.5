Return-Path: <linux-kernel+bounces-141791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25A8A2378
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0220F2880B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFF712E6A;
	Fri, 12 Apr 2024 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DwRm2YBX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Voy1Qv/g"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8045311185;
	Fri, 12 Apr 2024 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886896; cv=fail; b=E2HQguuA0itNqIsVphAqOlHphyAHSrjZNPcTq5nq5f6vOxtN/JG2h3WKYExpVkG4Ucdilbnijx6MagIKZ1/up8xClQF9Dk5mHCeYtmNs0fqZposqsLUf53xBAFqnMKRnjLGyRl2vtpwTN4fi/jBZ3sStt5/ULHTTqZQaU5fG08o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886896; c=relaxed/simple;
	bh=fKoBRRkJjNm6/GVP6pg4XNQwgATt3Q5JqHCd1tdz2MM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=UwTAbrsazuvypoRwIAo98RIIlg60D2FRsZycBghnyHFGNs9QUX/kPn3tc8JmeC+j67Meyw2wTjL7LpAvHS6xoyN2sC5xmScs3gIAaLEdBU23hKWOi8OloxcK3PPgEuFryC3OeJW/R7a+1vCr3oT4CueU/B0VGGX5VB+vB43wvpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DwRm2YBX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Voy1Qv/g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BNrAoQ028268;
	Fri, 12 Apr 2024 01:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=JnflJtug22rOYjMkkzP22UKiRS6iWdqbkr9el1ecQPs=;
 b=DwRm2YBXXVDnfAoQgJGGOEFAb+qe9yWXXlQRHYWWa4dWHG+PRy//LUefnR0Tri4snfdr
 tG4DXdb4qAhoZQso41TDlQOPZMwamVeOp+RD9xLYdXVvidkQhzFurrNsV98oUgPB+AEx
 NE87Iac5BCdzNfaIPBGNvW3XbsPw2r7KnyV0w5yutBWbgq04frF2O9TZ8nskGL7XZDZr
 bay5bNaLY0HIdXneOtJyPNvJtD5pNxDfW+E7SJIC3mYHtSvwU5LlQ7dOPNWxp+N9mx2d
 8ZAmsnUqS09OsThFHxxC3y+UbEutFFlx+hSuICEvc07bvNitV8KJsSiDFSKdj67CcRzS bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0utvss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 01:54:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C0rdDR040075;
	Fri, 12 Apr 2024 01:54:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavugm3kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 01:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1yMp1UIxcpDP4zKfd+jrUThE5Yo3eAQRRl+DW+GmUwXJ90FduyQtGVCLZXSIyyeMfl62bvBU/ncoerTR0+4gp+RjL44rpWGdcefG2DkTiI3rWWz+eUI0eWrlmilJNSTjyxzuMjQFjOZCa6QWXdbF69XbPxuCap5LzguNqEe+e5XLzJMyJeLibrFdNfQ7G9Bz9CpQVh8y22Sd9VC759tv6x4bH0vVq+NxjktOKXwmitz1cunkV3iqSFIS7rhJCdyPbCNRWhTCf0wp6IMyUEQf1rkt5gGGnCRSdFJnVrEzDG9iAyNig6GFGhIF4XRuO8Bd6bs+qyZj8z0SsNNDa5EnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnflJtug22rOYjMkkzP22UKiRS6iWdqbkr9el1ecQPs=;
 b=cZGETJi/1viLwCPrredlrsm6sOi41FA2J7+hMXvkSnb2V2wxUo4bazdAICXdqQFAqZ0ya6F2CBybqsP0nCkEhKlUnqXI4drMO0czbvTHP2x2OPQXP1U3CG5s9gGKOI4JmfQj9FAkf4nCED3I6ik2IqJe3tdCp4fhBJXOUQmMqoa8CPv8V64AyYu43n2WQHjTHHSP62KH1s6mr7mau2wZ+VTZoD/fYxtW499GRI7xogWEHxHhRL9wsGOraeW5PUcfyeRc/+PkFw44H5EbAnYGZLVsQupe++VaT7LgbDQlCATIBHQPyy/rOuqAJK8WgnFlSecb2akwT70WK5snzxqPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnflJtug22rOYjMkkzP22UKiRS6iWdqbkr9el1ecQPs=;
 b=Voy1Qv/gFrINZHHttP0i60WAN9fv+AZfO1sRHjFmQCStpszhwVZoHIpLLFU3D31uWm7TLp5Lkc8km2z11fMcSC4lfr0Ybyg3iDzLOcA9ofatyvdVGnHVsu+eGUBVNUBc+egmHBgJiqjm1qAgd9Wz+tOIIzCAAa/HY/2GvqgnGmA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 01:54:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 01:54:40 +0000
To: SEO HOYOUNG <hy50.seo@samsung.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, h10.kim@samsung.com
Subject: Re: [PATCH v3] scsi: ufs: core: changing the status to check inflight
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240411071444.51873-1-hy50.seo@samsung.com> (SEO HOYOUNG's
	message of "Thu, 11 Apr 2024 16:14:44 +0900")
Organization: Oracle Corporation
Message-ID: <yq11q7bl50u.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240411071042epcas2p4b2e6937a952e6dfa879db166983b1c54@epcas2p4.samsung.com>
	<20240411071444.51873-1-hy50.seo@samsung.com>
Date: Thu, 11 Apr 2024 21:54:35 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0660.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcf5158-931b-460b-5aaf-08dc5a9383eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4E3KPcV7Es4kEal4IlqbMBzH1QAAC/BXNAoUICGx3UJXQlo8KzRUF5S3224O0pV2w7kBY5sgr8LwlUbHSgyf7ZwnikfZEVG2a/KLqnHCRW3BjDopnljeA2Z3hYgqOKKO7xpjUgcMNc+g1XwXiNf/RfnGuis5CpDZKLkRzaQZkkrD5cmvy1A0GyWDQIaEbATQi3T0waWPDNXru+qd2t4JU1OZb/DHs/d4RCZssBs62Nl/iEK2oaa3HSWKJaeaktNpdyLU5B5kDjTWRNzqHospLDzszmszWBS1ylsq6RASQXrOx2ctwmtoJQGqprPGacbdJZsGPdQFmbV6Nvu5VFZLERpIoDs6ZP6H6dRYjL5wTluCfoumqR5qg6zpGhL8va2mGMcngjFBmch6Vy2opCJaSlp9BItEjHG4SSv2CcOpzkwaQ01LhHDp602CKE/u0AWr9++6aErReZnUGestMRyHXufDfBqhQLuRwpoPdDoDhd1vfREIxGyZcR0itr63fdEV022T5AqHo5VRf5kbMi+s7ZyLkg7o25RegiX8Z7TTQcPd9O7PkYGm0Q5R4DZw+3rvK5kj0p6C6MOcK3XMbCrff53tWEVZCdjPVB+K+Ibp13PkRZj3xMmxz4kG1s/615YNADuq/+QbfiwS//SMxI8mExkSHSq9rlZrIv9pDhZhugo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E15tc4pLoeLmAGk1wz/DsDgL3UZccby7CSgKA2hYRSWIUoHhxfVbnhKIlxgH?=
 =?us-ascii?Q?GrWM3yyrZfjF5OpKDBBrMXPZszhF85sI0F05tz7HowHQfoKDeanuMW3zEL/z?=
 =?us-ascii?Q?v+LUhr+Z0dYbifAsDWMVXeMxqwX9Qmr37BTV+Ir4zzTJE95CRRLtdmspULvx?=
 =?us-ascii?Q?ebhkVEbhxn+ixGVHKzvs9gcKyB2Tqe0sA/vAwhv0TMarscqGrEzSY5mLALpf?=
 =?us-ascii?Q?VgpJX00wwK6ioZ0PfB34S5F4edvm46LxlSHgEwKV8F8cJYhHU+hwx6SH7MGO?=
 =?us-ascii?Q?R1sZEKLrB828qSZn2oMd1gcIaXwmEoQxSd1pKus/z1Tk7E4F77idKGGZJugz?=
 =?us-ascii?Q?SpL1Y+1ikReXRpGHDL3dwGBAQn6bHvbJTdHoWyZiVYsFuZnjAYnKA39WY5+S?=
 =?us-ascii?Q?J/tFt8mF1SWBmVp5ymB0CbFBgjrEmokRtC4BTe7Yp0OCr7mzy6kLn4WhZC9t?=
 =?us-ascii?Q?ni7/SKEO5+RY/gVG16wXR4ge69w01HEhnW8eieHKW1brljfn1ZXxrGn0Lygq?=
 =?us-ascii?Q?hzSU7CPKCQeA5v/i7HHLdFj5b9HX3qpCxQRDCXY7s8ZbSSkkKgOIIiovjdzC?=
 =?us-ascii?Q?uYoPRbBz+mLDfl2AJlo+PLhv7dAmfz36Vv6OtHioy6p7BUXBbk6eUjEbmWUs?=
 =?us-ascii?Q?dQRhQ1AkBjGnenFAmbm0Z5ZWadZUyAdmZ5t3KZkseJKP7HcAkroRWnkejihc?=
 =?us-ascii?Q?JB6VzONM3VUUwIn6TZFuIeJEup02pLJb3FsEFgj7JtjhYJMg+P2Dg+/R29in?=
 =?us-ascii?Q?dqZb/ECMWLa1TC2CC/k/J0N+4J2hCbC0KgSj7hKBgf8KPG8VhHsQdxnWKqoq?=
 =?us-ascii?Q?Rcrc8bPvtjlA80nuCwqXlnFW81+T9NpOsOZWQcqbQ5Tqn4enjoIXJlY45TmS?=
 =?us-ascii?Q?7Lj7O+xcjPMJbSZNK1AXavF32aBqKAoNcomLkQ8imgophGf1+9+7JWAPh71r?=
 =?us-ascii?Q?4AA6TRs3E0G7y+j3oEJtGqt89jAjpwN1dOeqkp8mJgq1cbDuCIZo24Vr10MJ?=
 =?us-ascii?Q?fg9NG2u7hJgMR+84zGqduuJ5co9Cwtah0HhM9sI6etVmjwUjUA/x38nZPstw?=
 =?us-ascii?Q?hgSskt0BydwbDeiiFn91ELOUXVwCMgR0XzBzVhdsAnOUl6a1AvH0t1h4FGg+?=
 =?us-ascii?Q?7TFw1bZ84BWbcPQHD1vb5F/47+yYwBEl4xEI5j6ilf4DUSG0ocIftRX2G9/Z?=
 =?us-ascii?Q?javpmN2foeYbIYM//+g7J12G8uE+ry7id2egxb5eYY2LcjAjkwdcqHC5TLAL?=
 =?us-ascii?Q?W9wn7tYgRh0b3O9tOxzxX7BpS7gNqK90pJp8pDbTRSYif/b5D0q8mu63doDL?=
 =?us-ascii?Q?mAia+3zXSIxO7iK6JMyNit63/wgQRgvKAlvDI6yp4alZsga1WB0YUGMTlS3l?=
 =?us-ascii?Q?qygRVgLUe7Fkuy83SVl9Uu3m23x9AYS+2GigPWNWWc4p7cwyXgKm7UyWWYoy?=
 =?us-ascii?Q?G1PrfZwowQGL79Ywu3UQrES7zJGlnxlWNGLyyVQBVjXBOi/T2HyLVxFoK7QV?=
 =?us-ascii?Q?BeFdvVgSp4dX0S0uzdRh3g1S+8vNSt0CNuqOmcybHGs88LIuwPvVEyrXk6Ym?=
 =?us-ascii?Q?cntyDzM+BL1yfU28olsL0c4711kRgYTupos0G7GFsGHpRkDlu1sFLICaKXxD?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ifVYFtz5ZDjuXXasFJ9KVY39V4kc/q77HVrqAzU1dAsOH6aJ9ow0bp2RAntfLXJOOcLfXnutxN4ABkkUCzadRLF6pReHqxuPcAZlzaLKvb/AQDWHB1z3z7b+d829/ombKPA9+Jv1J0jiFhYLZZhg3xbK4fRoFapsbhbTUrdvTSmjeh5QJmNMz+Z3wK9aAOGj1sy26V9+JrWKJR5Bmu7prXka7y3iAGcBt7qsuASbSBuTCZz0hDA7KiWZYLb9GCQJ/IgM9pvEvvpYzPMtATX50ELjZmyN7nIwt3fFKdqvhZrd+oS12nvrnW1AulktvtmQN/WmJ1OFHsJgEzqWZ6HyWBdK/0GAKJ7okep2iPFxWvnL0M1n+uZvkkb8PGNJj+e01j16uyOoeCY+lh7s2PmLoJAxUpek8VVUaihlayvvb72pafS33jIYLuHjeV4f/xueBWaLZeN7CEGPkQqKRZbIHzDU5QgywSurw0ggzpGmtPcZnMD9QksYVl9a/GEtUxKDucF6El/FmKqE/erb/D053PNNDSz+oNSBmEP3lx0LwdM/R5ZPKW0lzP4Hw5LQrKrIOgDOuEmxIaLzUIJugtey5gapbgqLp3Fp34SPv10ghOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcf5158-931b-460b-5aaf-08dc5a9383eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 01:54:40.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heA9bgEA+OVTyC5rHc0RPNH/EkM+RPOlbOiqf+Zoc52Jy+/fJmaBw7StOENaWLZc7tXgYgQHxTYZNnr27xaY8fz2wmgmKsm+p5FpbGEnZyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120012
X-Proofpoint-GUID: ciYgpKiBo_aDrgtErTljwt01XAXFAD9M
X-Proofpoint-ORIG-GUID: ciYgpKiBo_aDrgtErTljwt01XAXFAD9M


> ufshcd_cmd_inflight() is used to check whether or not a command is in
> progress. Make it skip commands that have already completed by
> changing the !blk_mq_request_started(rq) check into
> blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT. We cannot rely on lrbp->cmd
> since lrbp->cmd is not cleared when a command completes.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

