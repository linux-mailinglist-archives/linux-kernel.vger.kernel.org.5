Return-Path: <linux-kernel+bounces-76733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6525185FBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8391F25AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3ED148FE0;
	Thu, 22 Feb 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lvZPHHGS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZZ4X2uYX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA917BAA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613917; cv=fail; b=R5ILwzUnxJKjYQRlov7PYzDEXiedqIPmPvo8+XBlH1RvS/PT1wCddCUZZKr4FHr/6D/PSH5TnvKsyzCxk71vkgkvVc2vSMMPPBFrNpoN4ySSXjgNrkbVf2c/2qVaECzNQ1Y3ynKNxTsIhNfUvYYVfa97To8Nyla2lP2NuVs3jy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613917; c=relaxed/simple;
	bh=cQ50wK6D/KIoZam/nLzO3B2Iz6SRq1bsn1KT5zQQPRw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MYDjmbS+jblR2nAJsw1Cd12xp1lYmQl6lJUjXdDqFsGzk6+3zR/Y/rqDLZN2LPR6G8/Ca+swl0hXj4djmR8G7WxVIvD9+WKuckNwcEEsOiXYtDggTVzFRlb5NhSvlttEoFoHxSTvEDHG/Eo4Bt3PwKpXhb3YR4iRlHUeX+n+9Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lvZPHHGS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZZ4X2uYX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MBe2v2018113;
	Thu, 22 Feb 2024 14:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ub0Mpv5cHB6P5XhXuBcDWOOKEggKcKWL4jvtdH/6Fcc=;
 b=lvZPHHGSIybCXDpOuwXj8rNu+iMQSqxM441Z0jvj4GUPsOX0frGx6m7taJe5ctw34Pnq
 7fPScBJziERTBuHObO7SbG65H6o2RXRBeqPL82sfPhyWlePv/YB4j8VOes92wMj79NS/
 yBzzpEP7FrvZAziRzsauUzUbnogrxaypx9F++AVatHRNlI/2iHmFaQlZ8Cecs8ddKzZt
 MU9oj9FD/RJlc/VpMHqO/hOYxJjVYXFqBofF+LmMscgVuqC+MMDx2N3RG8kwHHYoRPk8
 XyPijKSBS7UFDBMNgRZy8zSWLyzKL709OAH4Bwd4yKD4SYd14kGYjl/8aK1iLcIk1KB5 jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqccwtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:58:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MEoj7v024858;
	Thu, 22 Feb 2024 14:58:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8arrva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4CZ32fBxw9m/FTdRwQ5hiS+htqIKNSIt55WzqdRqTcEA1y+H0xxq8/V6E6ZxwIQS5G7/XqSIODhy5rSTxDt7cZ0cw327qpailJlr4P1oRuVUdo29yVG4Z8tBthlyMqCQ5shURQSqBCjXEk+p/CPrcXM5NMWVlrk/tXp2sFqxdV2bMMPWcujJK6wQFzv1NXuxqEN+AsqklqBbxkDkZ+Q9Y0Sz8o1r5kiAHidgzYHSadhrYETJVDjXt0QX3Zau8EniHFjzMyCyZ9SGdVK+RFJ8drtMkA2sUoBYqGpmylxW0x63gfznTPerbBY9eNcUq4blkih3WaExZG8U8zvt6qvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub0Mpv5cHB6P5XhXuBcDWOOKEggKcKWL4jvtdH/6Fcc=;
 b=OVvrkpGC8hHHwPgWBidt8fqPMbJ+SgAcaxi5VpedESBfVfE/2WpUcUDWSltfW2/BjcMf53fN0wF0VBbEyghZK4MmdiGuE/81+Vzdmvoi1mak7bwTXgqVdVOCUKc2+9ovJDNfDInE1pzfNipKyxYmUmLOxKmVBVm1PCvBgAk2ubxd0nGQ/dH9OUuTDxqWbImftgy++zyD65E3jVJzoC/TuaB+EMNhEDVUXq2lGciIglC9/sHg3BdJ+OQwVEzHB7u33wnWueYSb9pxzZ1XqXNZ1Ns3rCIAWgwSOrbdqPA1Gqfmpoz4+w6oYb8ywnRAn6eOUeyJUqIHyTdFaUe1mtSYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub0Mpv5cHB6P5XhXuBcDWOOKEggKcKWL4jvtdH/6Fcc=;
 b=ZZ4X2uYX+7nfve89nNrFIe3eUWYe8X2Vb/GSWXCLbX051wGHjTkua4w6AgawKcEjOC/8kI03V8ymkdSvNHWgmBk7dGs/2g+Ce8sltnUyOvX6f6Opw4gxW6hdZLp2NtAkMADFgHtLRidYWF/syQ3QKMy6Ep288NtwpPeh6uX5PGQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7110.namprd10.prod.outlook.com (2603:10b6:a03:4cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 14:58:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 14:58:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] firmware_loader: Use init_utsname()->release
Date: Thu, 22 Feb 2024 14:58:19 +0000
Message-Id: <20240222145819.96646-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0361.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: e28f635e-d8c9-4c2e-dc5f-08dc33b6b878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yVI8Lz9Axc4IMYnwBVSpBW6wadRWAuE+8O+wOmTsxzeI2kuQkx7ZiQvUQkyb+ij9eTfcglR9W0LGNdwkT8fotM3nVyo11iPVGqaYM7iB5AW44RtvqAUMJiAEQCWojPti0hU7Q9EPE0DcoXBqcWavqZtE5+aca/+u4goqVfPWgiOAmCZabakTnFNUOnkZ9xne/EB9TOkUxjk7hXxC4Bj+tGcLOrLYObCOIuY/YQeDq9c0apM+HcF0BGHAmD4bfS33xkUA6MvRUpzjA7dHNO5nVov3//VlF87DswGNaaiODa4RhsE2I3hDPjgqPRezXPxQZgiZv/aWeyNX998geZdoe8AnwrAQeNjNPmkqhLqsnDQvm1G88lqXkb9d7q+ZujloX0sce0c5p/wxtQWBEulJMEZTBuu2csHHBQVKqUqEHA+VT/0rQBYpKlrt+HjhrMvejX0hf4OFsqN1WvZTdeUwJwwk7xcfveWQxPrPivp3ujeE8OA2ghlk3Yn2G7/f503kIPcJNmnkE1VoVy8pY8EYpw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lZjO/Ev8/L412+UXNLk2HNAv6LGSIroLwXokZTKv1fp83B5y5YaaHQ159aq+?=
 =?us-ascii?Q?LOXLcOT0EWCjDfNu2FvHs2fiaLzmsEp3DAWxkVB7VD/8l/i/Ty7oV/4AaKFC?=
 =?us-ascii?Q?sLDy1SMLrPsqKz/VE+WR4ZgOknLhOJ8RHivR7575riv2FiIddLpuJCRqKAtZ?=
 =?us-ascii?Q?YMK3jTWBnSA62G6D/ykejY3vBEw63uv9Q4LUJd7Oepf1jqpjBjHiKgasCKS6?=
 =?us-ascii?Q?B5isj/7IrSBLena3SONLoi7hRjHfNoQtSU2KZPyCRttH9ZiHOZifGQD2Aq01?=
 =?us-ascii?Q?6mknj54e+2ckyW4w4SXz13FtSg/OO3oAyFPmHMnh3vRMRgINr7bJwTYqhZoX?=
 =?us-ascii?Q?iKrBsg1cKDWtaHefFtQVtu/7NOGjhZvW2XEhi9odgnUv34YmDimok/z7z7ee?=
 =?us-ascii?Q?M3P1YDkIij7i6bdtzWXD9S36ONcnDrW356P0LhlmYptlLCSRkLWDk8axDFcP?=
 =?us-ascii?Q?ktYrfAYl9V5tBfDfTLalBX53FmL0D3mQC0BNgNG1d/wk6kjgJQXEvt5HtJBz?=
 =?us-ascii?Q?can225CGam1wYwL3dik1WExeOsktA544NNwcs/5gVgVMlfjMNrcC018URLWk?=
 =?us-ascii?Q?Z8LFg7z6RKHn1a9dGG6R+h0qdfGUeEUiEl7Y3955bnXfxVbFKc2b3KE3qUwZ?=
 =?us-ascii?Q?uyAX1Yj19kOQ6PS3OLJq+crNTjDvr4yVo2MRTTOn3weW/+FO7/6fKKRx1p5y?=
 =?us-ascii?Q?tjTYY0hkHShz0VMKrLZRg9bReUH1JIN7bAp3KDVdo84IZCg9trsAab6VD3hF?=
 =?us-ascii?Q?kbVvxd+7fDg5n/X3JWmVG7U+YAnSrrE0wWkYUAaoqCl7WwyDSxFbLeaBXpKc?=
 =?us-ascii?Q?u8dznp1HqKjkpGeIoDYlBmpuQYAXvSSqSd8EielkJj6Y6WjJ7X65mHwry82A?=
 =?us-ascii?Q?G7RR/et2Rj8uP5eK3lddSDvzVqXnmJERuLdwdHH8GEs8ff9UZ5rgFVFeZ0xr?=
 =?us-ascii?Q?pFOFwq+xPw/0cd+DDsugT5Z1brICJ9UdZWXTn0EUERz6r2cpkdLLwOb3UeuF?=
 =?us-ascii?Q?2kIhcb4QSNGsrHx6dDNvBa6IeDxW++hocT6gveKMCn5xgdzzEwaS5k6rW3HG?=
 =?us-ascii?Q?127buGPjL26y6JlQ2GhtgvCpFpVd8N6jrPMUQ8b3OAJH4RzvtDro0LZK1QPy?=
 =?us-ascii?Q?DhQUineh/oqF4Eu3JLTuqj2+c78lJB/yGMTzyiIkjDA3gU7n5701CAytDQak?=
 =?us-ascii?Q?HhN2vHAKB028ghpgfDKpeIQP336XyBAUYAcX06vY9y9R/iMz7sewfNdwuP/V?=
 =?us-ascii?Q?Qz5F7OxuLjRf3HWyrDrijfimP14GokDE9mMacF/CJU3Q0o0mQCWHgBiOmNbp?=
 =?us-ascii?Q?8Ml3D1zAPC7ElLkKgDiTboT/SQF6uK5+r5tToKNnyfy71AW7b9hOivH/cB1u?=
 =?us-ascii?Q?eodal97kLg9CWHu3rqyrZqP40p//TzcAdB+Uo+Ui6PCjkSvx1h2sCyRttHdw?=
 =?us-ascii?Q?AzzN8mS2c+ISWx1/nYaxf4tsYj6tHz89XUWL/Jj9bJsV1PAkWw7ZgGUltiEs?=
 =?us-ascii?Q?JNz2qBPt8qvvjq8leLXE4lOaHOP0OrZcSMxnNgFvBAtqXVc9Bdr2PPBCOvRB?=
 =?us-ascii?Q?Xot7l/m1CvFVhDSk94wGDWu008tDq9scoQEVDHPJ1HP8DnKyVPxe4JaAAwj3?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ilEmMoiIhwGJ/L4DTkNMtqu9Sj/VmyjtuSA2HPWCp4WhaMqUlIEKgKiitjcZWgXhI9v4dMSJ+PBt4f2IkCqyXGSra/ZX8vSc5pOONhKnsjPM6X+Qv8Jus+UQ9GUwjBTHZXkdNLlYMYF3+zM6MJ/BnVJRIZQj45gFVwpd+9RtH8oHEegglb7iil/KRB//2IWrYdD9zxv+bhRgbqDwoDuFUl05TXdpgLcsKLgiQltWjrPfwKVb1jaKAFVfIq8LHB7HRCjYzR84Za+JrESPMkygXcWPLrYdTM+Z6LnFOvzwcHA8ewxW+PafRtzYBJscBp7OpWoJJI4i359sbdxE1WbMrHuzTp45uesS7VDHofaYePx2/7e/voMw4EU8wXD19lAcWcUOcEhuEFOAsDfqLXeT8eOoWzgid8tkdtM1dHN9tsFhmwWw4A+cyUtvTbLrxlRAzP3ySH8ATpnbNUbGwKf0bPms3Yg4LB4/PGwxcg8+T760Dvf6DmDraSaTwOYFeUGxVPmylxCvVwhx+qCAgS9w+6CzaRk5Q5EnwhlsIf7lW8YFKlOfxERNmyBUJHFx33AAfAbCqBvZkEKtvUzWSjzbs0WK9Tb6KzyXpbbiZZx3fBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28f635e-d8c9-4c2e-dc5f-08dc33b6b878
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 14:58:25.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G8dBjwoP8PJiUuL4ZRUvjHxwUs6Yvp5TEG6gQOMhHBxEnmBq9sg7wKQ/bDZJjBVIUNaBjYvp2CPanQzRYNDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220119
X-Proofpoint-GUID: mxKM1sxXNxJlIbV_vXYwRMunLl_GABYc
X-Proofpoint-ORIG-GUID: mxKM1sxXNxJlIbV_vXYwRMunLl_GABYc

Instead of using UTS_RELEASE, use init_utsname()->release, which means
that we don't need to rebuild the code just for the git head commit
changing.

Since UTS_RELEASE is used for fw_path[] and this points to const data,
append init_utsname()->release dynamically to an intermediate string.

The check for appending uts release is if the string in fw_path[] ends
in '/'. Since fw_path[] may include a path from the kernel command line
in fw_path_para, and it would be valid for this string to end in '/',
check for fw_path_para when appending uts release. 

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Note: As mentioned by Masahiro in [0], when CONFIG_MODVERSIONS=y it
could be possible for a driver to be built as a module with a different
kernel baseline and so use a different UTS_RELEASE from the baseline. So
now using init_utsname()->release could lead to a change in behaviour
in this driver. However, considering the nature of this driver and how it
would not make sense to build as module against a different tree, this
change should be ok.

[0] https://lore.kernel.org/lkml/CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com/

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 3c67f24785fc..9a3671659134 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -38,7 +38,7 @@
 #include <linux/zstd.h>
 #include <linux/xz.h>
 
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 
 #include "../base.h"
 #include "firmware.h"
@@ -471,9 +471,9 @@ static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
 static char fw_path_para[256];
 static const char * const fw_path[] = {
 	fw_path_para,
-	"/lib/firmware/updates/" UTS_RELEASE,
+	"/lib/firmware/updates/", /* UTS_RELEASE is appended later */
 	"/lib/firmware/updates",
-	"/lib/firmware/" UTS_RELEASE,
+	"/lib/firmware/", /* UTS_RELEASE is appended later */
 	"/lib/firmware"
 };
 
@@ -496,7 +496,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	size_t size;
 	int i, len, maxlen = 0;
 	int rc = -ENOENT;
-	char *path, *nt = NULL;
+	char *path, *fw_path_string, *nt = NULL;
 	size_t msize = INT_MAX;
 	void *buffer = NULL;
 	dev_err(device, "%s suffix=%s\n", __func__, suffix);
@@ -511,6 +511,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	if (!path)
 		return -ENOMEM;
 
+	fw_path_string = __getname();
+	if (!fw_path_string) {
+		__putname(path);
+		return -ENOMEM;
+	}
+
 	wait_for_initramfs();
 	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
 		size_t file_size = 0;
@@ -521,16 +527,32 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		if (!fw_path[i][0])
 			continue;
 
+		len = snprintf(fw_path_string, PATH_MAX, "%s", fw_path[i]);
+		if (len >= PATH_MAX) {
+			rc = -ENAMETOOLONG;
+			break;
+		}
+
+		/* Special handling to append UTS_RELEASE */
+		if ((fw_path[i] != fw_path_para) && (fw_path[i][len - 1] == '/')) {
+			len = snprintf(fw_path_string, PATH_MAX, "%s%s",
+					fw_path[i], init_utsname()->release);
+			if (len >= PATH_MAX) {
+				rc = -ENAMETOOLONG;
+				break;
+			}
+		}
+
 		/* strip off \n from customized path */
-		maxlen = strlen(fw_path[i]);
+		maxlen = strlen(fw_path_string);
 		if (i == 0) {
-			nt = strchr(fw_path[i], '\n');
+			nt = strchr(fw_path_string, '\n');
 			if (nt)
-				maxlen = nt - fw_path[i];
+				maxlen = nt - fw_path_string;
 		}
 
 		len = snprintf(path, PATH_MAX, "%.*s/%s%s",
-			       maxlen, fw_path[i],
+			       maxlen, fw_path_string,
 			       fw_priv->fw_name, suffix);
 		if (len >= PATH_MAX) {
 			rc = -ENAMETOOLONG;
@@ -588,6 +610,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		break;
 	}
 	__putname(path);
+	__putname(fw_path_string);
 
 	return rc;
 }
-- 
2.31.1


