Return-Path: <linux-kernel+bounces-117894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363D288B5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A84DB29873
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F646444;
	Mon, 25 Mar 2024 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OL+Xsrz+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b+5AWLc1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5234502E;
	Mon, 25 Mar 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397488; cv=fail; b=rOkx4I+qusDKvvR/boI1aehQLMg01qAfu7XWhDNyacT8m7pZE7N5OIlxq9lAuWIYFzp1CtSvR+qS9HHqX56IjOLWPxfG39uQug3o37MfDbNZaotR2VrMAbHKUTnwL2mV3cyDjxKBjTAjtrUl+FxA9RYsxukBTcy0CA9FjzFyu88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397488; c=relaxed/simple;
	bh=5QeedN3wRpjf3ssOYuA4M3wKrg0waFSFNsU8/G+tsDg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=QGMGVuBvIjJwv0EBx2nEWuL2lzdrhjnwmA16oFWuXy4zZjhWHNxhcYKovva/1i6bPBzWk1WcPJXDcaPm2LMLeN7y+wWFDzkVv0uetzeqQO6tjxRi7EN0VH2Xr73SLMSXF8cWrXDr69eQSMebraEH/nyXmLioCE2RseVJ4Wzvv/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OL+Xsrz+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b+5AWLc1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PHUBLp020652;
	Mon, 25 Mar 2024 20:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=7Wijj3/oMDpjb3ULMx+Lr2e+fLtArmFW8/WtNxwzpOI=;
 b=OL+Xsrz+wCbsE4gVSteh66WWfN9QGj39FITkV7smoUhhIn2a4ZqpRagJWqvoxMTHRvU9
 1RLVp3qWvClXSXf9SvNfMX78TdyTM4br1DgT/eFPn5pPTgkvSmoG/Ruh0HRPd+ntFGnR
 ka1OKeEyOEDpXN55mhiGj9h3BZ4A+JbLXI6u0s56bAEXSAOfugDMkfL2brOPsBWYgVKn
 hrAi4djgvCtmcdF5dMO+G9dl+zv8sqPyISMqy+GrN5Gn9J6/2xgyFykzP00BRsJMJMx1
 +xgBCcoIdoQLZquEd6P8PetdZC5sGaFpS5wdIEFPqx0Owtl2T4umFrkBKDX7U/EyOVfx hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1ppukkd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:11:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PJhJ0u011051;
	Mon, 25 Mar 2024 20:11:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh65t38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX3zjBDX7RG3MM3Eu1PDUnzdOlpupUMyjW8tzXpDPrjiBZhooZxjzOk+EaNcxQaf33Eq2cO8RGdSMeBhNMmSLVZhx+aFdS6LeuRIR4WO7ntDBOmJPv0z5+juPViq1nGzBprfMGgFCxaoT5XsYWXrZbqIt2WnYvy0tyPBYdGoEc8wFO0LUaSR4qEeQrcU0t72SJiQYG2Mxy8mGC62G4flsuCHr9ew/PLh7irI5/BSkTgehdSyDP5Fh5b04t7hOOpdbRGsmSbA93woSl01m12YmLSEFUwcjiaNKLfoFsPOXiLittpPESC1ATYZ92Ygvy0KSQt2ih96tZtnqrJPVJDcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Wijj3/oMDpjb3ULMx+Lr2e+fLtArmFW8/WtNxwzpOI=;
 b=UP0dRM4lvY+GzDMYZtsgQzuzmtZMLP1Fjpv057EJjEQ64A8VOqbK1NCm2KEvmAVXncpx6UI8sI6Y5s209zF/7NKXRcrDWRW5h/UvEhJ94DOncz0bokevRPkDvzc9/kNkvegMOD0rKstOzcDGc+LvG3XztZjlgq7KysuitdAF6DJhBmb8qIORn4hXpviWG03m8XfEdQG6c5OSbMUTM3jLaVkxrzgak3GbrfXfy+do36w+trOhCj7CBDIUyLr9xiV37U9JjPleAcRQRPdqs0RvNECo4lVk4fqDmyWlqdv2750cKyHuK80JzEbyNMpsQnllKMkmR74iM4qrLm0RODqcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Wijj3/oMDpjb3ULMx+Lr2e+fLtArmFW8/WtNxwzpOI=;
 b=b+5AWLc1Sh/8lCP6Z9XTcXtcMQNGQRccZYCmlj28atF+5RHoLOAxcB45BltlxNTZAF1X2FzhYae5DKWNQRMYoNV3F0yotkzjkwd8CjYfuKKYExEMeaPiNcEVc9IY9pRbIgKjTkQNB55NZwT5Mc+MfKA03t+d0IqVW/9mQ7BgGag=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4124.namprd10.prod.outlook.com (2603:10b6:5:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 20:11:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 20:11:07 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com,
        cassel@kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add LIBSAS_SHT_BASE for libsas
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240308114339.1340549-1-john.g.garry@oracle.com> (John Garry's
	message of "Fri, 8 Mar 2024 11:43:33 +0000")
Organization: Oracle Corporation
Message-ID: <yq1wmpq9ink.fsf@ca-mkp.ca.oracle.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
Date: Mon, 25 Mar 2024 16:11:05 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iVp3EBzsR82YpY8+vR5aGGyQbL24QA4s6Utge8At17cftTbSzfGArDL37aiuZxMn6zrlgq6qbjr5KlMzj2BsyWUTfMwlDtLM+9B/wiZpRA0Uu4CIQ+tDa6RKc2QCT/1FP+NijVArT0QlpQ2lucAbM8wUiv0V9aWsdIBbsBBL7cul29ydSBBId4rpzJJHbjDKtYUSwixTZMIJ9N0VG2CLXi4GTg+s4fnQ0VqsmWMoXK3CQcVegkMViAdf82mO0os+0Akgm6ME/N3pRAOZGKuSgMBu0fG7u+73OVCWPp434eCGJEl0hdOWnHKE4t3DzoriMk3ugd+bbp0SDCsNT7CrUIcvRgCGqhcuTTVmDJhlut49Ley+TimMA8qiUqA6Lg89rmyaxPPr7OvKg3Gn+EjvTpZcrp1xoVstRcP7Q2x+M4cnGZdKgTtaYONFpFSZRThu7/gJR5aSIAeJC7Hlh4TIHBXK0vI9iqcUISPg5u8cS/civmd2ElhzJuvq/l8t8tO1uP7Wc+tsLNKCI+m2ld5sJrf5hqb21+imRlBI4B3wVe+AvV96wT5de+F3c5fZZTUiYETQ88byz8K/WlaPug1orImmZ/Kz2/SSaCBCUVylmFTEEx9jFEQeUcfOO5bFthg5tbgoB9Cut8zRRKqJFWwmrEtIUdC0U/24e2i7FfZpKmY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G4VcB9Eua8qxSK9HKdKE6p+ZTUpVh86FYkCf2aIaf7xRlAoXJf9YBX0dIerw?=
 =?us-ascii?Q?ZxmIDnifTy2mSs7qP4EGiTOF91y3r8a9Vp/LFgugb8TGc+/orK4YQ2kFzSaz?=
 =?us-ascii?Q?5iWzFfRADYUHKRjbUfgo6ORF3axniyew/lg0W4Ac4nAcI01i2wkvV25BrZK+?=
 =?us-ascii?Q?WTXQEirmgvh74UHqTZitsIlWvFh0X95e3iYWm3W/C2fCU8bxDmP0VR1jr2yk?=
 =?us-ascii?Q?+uBFOXzLAy7qeaF4Ku+PTjUcea+CgGa1mcOdBxtRjgaYoONwXbfC2HIBtL0X?=
 =?us-ascii?Q?w//HFUWamG6s0riBcfL0o6H74IUSHUI4VfukbmfHO8ofH48KjfOCamG8+McN?=
 =?us-ascii?Q?eo/VOBx7XlBnliKgiPKAYQIGncGHlGKX4o6995v7G/AsNBRsiSNbK/5x9LMO?=
 =?us-ascii?Q?lMe9AadCWoQ/Y2f7CPOPNV+xmw/bszRYMjHiMq2KIWwbI59TPUzGj9RkNVd5?=
 =?us-ascii?Q?lH3RDk2MJGLdOVtAU0/zDwFAemF10qVp6lw3GLW8FjYKP4XGWTrgmP20x4Ym?=
 =?us-ascii?Q?QOOMj3lSLdCF0lBfbb1xYKkAZzojHFG60l6bWTMoSBLuji+HlyXIBWLFwPnl?=
 =?us-ascii?Q?U6QayErLl305XSCrAt/Gq92erxBBWfWuoOy6b76BvCMLlz/qsmyUr43CzpXz?=
 =?us-ascii?Q?GKStPRocd15ztBpmVGfcbkQUwTC0x584MZ6kEBHcQpCOyfNHomaV+j4NPY4G?=
 =?us-ascii?Q?48ehveiC0HTjwmTDu8Pdc5wtfei1cUM32H4cy1618nQk3MSfemqSqvP6owPp?=
 =?us-ascii?Q?sZYFcJd+G2+OXJwVQvTaN6HqPY5/Iljg2McenEhruN2/Lk56Ww2zkZMbx8QD?=
 =?us-ascii?Q?nc4VOny/jB84oNQ02k5ZKD8hFLWG1bcJ9BjoRQfZ/PVnkLAnA+MTRs+RTsXS?=
 =?us-ascii?Q?tmLFGrCkP57xttE0AMTVcV1UvGy+XZqArV4i3dzE4ayNVAtEQv9vJBUohUNX?=
 =?us-ascii?Q?UusqxOaKgi0YQJXJrsy9b54/SD/CzQXW1+VuQSkJESZUQJ7Em81vPRckLyKz?=
 =?us-ascii?Q?VzgcljKGA3Z7/wwnP8pbJziGfSrMAlvC7j273ci16NtaRxt4zp3MieMXyC16?=
 =?us-ascii?Q?NgPz9tmoWp7XUAa4cNO2KszZk75vNVXwvFz6Pa1ihj9yxCQYA2BGv1tADnYn?=
 =?us-ascii?Q?p4a1s9+T0yOj0z0cGAwuG8JkvC8XGLcT/q4WdFXKSwYFVpCKOyAjApwWAX+g?=
 =?us-ascii?Q?6RWgvW4as3qw0+eauqF8uOw/nhJgYPDP7rA3XDsWLlJg/tpgJdRF873OKsNw?=
 =?us-ascii?Q?WDmCKzn2kExMZB4MOLkxPRJEan3P/A6Y52Ps2x4qyqeqHUYwJA1Ri7cn1v67?=
 =?us-ascii?Q?e8sa6MKaJt1Fyg5KK+SV3q3n3DTILfA0Afs9M8tCz4xESTk2kICy/fbkUQPE?=
 =?us-ascii?Q?WaOElPEy0yu0dPE+tJ0e/9U6+7DqIj4achDza/clY6bpsbB5JNkBka3M5ViE?=
 =?us-ascii?Q?ZiNDVg/U5CwzXXJJOUWi4OKN8mM47TlgzAr0qStRBS8s1xRmvk1m25+JXFWV?=
 =?us-ascii?Q?FoYngEBmgCeF5jTXseuI38bGegx305UgAwslD7Ph4PfXO8TP2EbD/Zkmf4TB?=
 =?us-ascii?Q?TZTX+R0CryEKTDl5fBvEM0VYDQrWKOZuGtdo32UkKKXwmXCL+LdOk9x3ua1i?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eRuIO57a2q3QrCsT182AK//Gwa6PHdth/S00SQF+dmt+6Sn/cHZYTB5en5xKYcuw3+joSMEgwMx3ZmHlwLtUejC6Zb0lVRKIPjswkqrUVq2mEpG3S+RQqOot9hBmNWiXJW5/c1iKVw0AzVUaT1iMgYmyTD1ZZlmCyIz+QsA2zmYqBwEj+M8ZmzCmZgHFxYGnoM+cB9067Y6p0acNQBIVKryt8A1QGuBVQmp2sHt5gZZc9k7PufQMpLSr7M+rVLsiOwY3QkxxjMAUGsVl9bEsLADdDrxtGWy6PwqyqqiDQBwJf0NGVwyvO0bMi7sAiQknB9eggQ8Kkr/xgzfzblNpWzWqRELeW6u64LM1IFOAZ7w1KPqeIKZ3B8MR98mNQwBTXStKHbFNyBHa9E1HVcFJcqVw8r1a9kKSp1Rmv0peK2pqkJ0PerLAlX9XQ+9GXUg8M09Ylxr0MBNlWTtOZ+4yLdM5l6vtxFfy2yIH0NMTdQmYWvjlTe8YXGw9mP+YayLY2C99dsDmWwr7NeqniR6t/GIkkFGZWihHjRF1n8LGn4IkuzniDtsvl4sFGFFKOjgnMZlx0lP+erK96HE5wfiHnY7q6Os0AehwP3v1ex0/4Gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3206648f-939c-4a20-1db1-08dc4d07b4a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 20:11:07.2290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3YeB27aSymSgwq87z2iGog3ukEWnHqJ7NjsO4STIT/WlkI4CP7KiBzNMbH/zTp4E2yGlw96XRbr7Y2b9wDSiMD8YCqglLZQ16r8Z7khxb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_19,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=912 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250123
X-Proofpoint-ORIG-GUID: jJH6Guae0zHdvGx-PBhxQfyX_U9nOyg5
X-Proofpoint-GUID: jJH6Guae0zHdvGx-PBhxQfyX_U9nOyg5


John,

> There is much duplication in the scsi_host_template structure for the
> drivers which use libsas.
>
> Similar to how a standard template is used in libata with
> __ATA_BASE_SHT, create a standard template in LIBSAS_SHT_BASE.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

