Return-Path: <linux-kernel+bounces-69351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290F8587C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973741C21A20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA191482E3;
	Fri, 16 Feb 2024 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aHDUZdnZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZSt1CDOS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3F145FF7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118029; cv=fail; b=gZxz7mua90ED6Biki6BOZJLZXcYnxkPqIgcozSL3Mhel5SH33kStQK82pc495NRhVKIIjmY9ch61tQ+q6f7RwJTHOF9PkcvNnTDDnsHKfjRxpLXm/3NDpUIRo/kBaof6/1+oJ3azEygUPmCKJYEriwmR9i37uIX2+UDK2yr5xlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118029; c=relaxed/simple;
	bh=OrX6hVpTArQgUvHv6Df6+VWGIMQBMKZ+dkyXYEpdjuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HBUikbdVcbApN9I7chVr1TyHcMgDG2fRzwSTZZmEjRsJl5W+pgaPsDLa8de84w/0+bdw2iW809NYcTh00AoyiTdWT3T/tnDHDLrI5gQAHxHso+i4aWz5P8Q1DtQh7z4OrPTee/QQkINlxDjZDyAULNjf4WaTv75KpUsDYN9ziJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aHDUZdnZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZSt1CDOS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKDkHZ012166;
	Fri, 16 Feb 2024 21:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=7PLIpgoX0WzBhOeTtr7m+MCiuzEgYeEYqWfbsIroNjY=;
 b=aHDUZdnZJobBzPh1V7T7n+AFkBLm8+vcZLqn2LaeSGekY+I730fw6PzkpzcqlGuOqd3A
 ITq1+0nSRqgxttuaSwrhK1EXnRlQuE9OjOCdS4HTCt73qtD2qpTx2wWnKG7YK9JA4f8R
 av8Zxdhp7nrYNOyA6oVopm4HEEIil4vqZZcAM7zA5pIpHKvAynOllBPyg2eWHBx7pvj6
 qKvsYMwnxIu/awBMVKzug+KJeHmrKEju68H92L61wMcLGs1xTi3Xl+PhfhMjUGWInSIH
 1BqG38aRQPNxrZ5jSQdOcfWtMWIOrPr10LecCrhzsBkACMbdrE869mmV5YxwdYErO9At LA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301p5vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GL4CMN024548;
	Fri, 16 Feb 2024 21:13:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykk0v8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W10E5q2m3YYR595P0iegIR45JHabk1MMGhb+rX9MXLRIEm0CkwRAe38dwm2dkua9ZWhcM2tyBoKRblSwDDbArZiYfivo0l20moSI16FIOm/JZcTW+vgpKXRq89sx7PG420E0YjLGlcM0M1T1F2au9xFP9Jgwn81ftGoYe2WoMhmuM36chDSCtPLkIDaya84OiIzNEHywQRqXRHtBQjcflwbelRSEaTfB5d8zD5u2AFXSWBSnEjVe0RnTFkdp2IXNgknQHyHXWuO1F4tZ9TrpLYheYOSKQxGwIXFV06jYJmulB7HDqX5BLW/zCEw/x05hzuBB+sjAPjmHUV1CcZILTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PLIpgoX0WzBhOeTtr7m+MCiuzEgYeEYqWfbsIroNjY=;
 b=EQuurVbkCsfz/ZBMdvuH773gMWSWT2sIeMp6fmPIZXuGC1Q3hwBddNhgX8cO3WLjJNB8hHaJvHOLtIU3BzCfQ22LF2HhB7lNv1rUkIZD3hgbeKjMOQYvKsjWIVMI9znaf9G93LuxFrBrysslHD5qlxp4GcIklp/JD7K7jZynE4AVZxXJIQadvJBiBKmIOAWAKuoh7IBPBNpEJv4XnZg8SFy0Z4kFILU75Yz612qWN1vGeIJC9+fG40X2lwUYjC08qxxNoS5YrNKB4qrGaIpuKxOtUT+Oe3/Jvq87ow87RbZfJhupfe7wKJE69tMiY5FM1trIE+cyLQYKb6xQr1Oygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PLIpgoX0WzBhOeTtr7m+MCiuzEgYeEYqWfbsIroNjY=;
 b=ZSt1CDOS5DVIRY9LLUz/G2eBEE/31HceQ8D68azkS3PXMmcBJ7vqM/INIuBX8givUAFGz56IezRII56X6XF56+UdhYHQsRgL9t2XK0GZ9U29X70A8DxDHjJfZ2yKyWRUm2SNKqh7vJcTkXwAHl5kWpLNHLWJhV+SpacxzH6h3m4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 21:13:31 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:13:31 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, apopple@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 3/6] mm/migrate_device: further convert migrate_device_finalize() to folios
Date: Fri, 16 Feb 2024 13:13:17 -0800
Message-ID: <20240216211320.222431-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcebfd6-7eaa-4fbd-b4e2-08dc2f342077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lfqLIFDNVPj+uzcbTmB2YAVc9oK9qNIGME0HSGInSSogPKauTFxpUDSAghbPzOXkR04FAtzDGCLI2zi0xU9PPIWYTHdfZL5FgqC2CJKNNyZtRuSBtY/O8RT5HIUknp6Vq55rkAvNh4MVebpGbcojYwoyXfcpMrjNOBD4hibNc43AzTKNJXlc2t+hPWhKZBv60R3mkdr1CKuWS6sTfKW6vOMXJhAKDEOED9Rs1eGK9a/DAq25ZrmHbz0u6F7VjVGeRe+4ndX0jweRmIL/U04uMJ+b+el7R/fZD9po1M0YzkN1RJTOQkvrp9pljrfAr3Ul+LnRVME9OZRuPjusccUnSnHDF2/pXEutF+vAOIiNOuf4PVilP13CzfUmw8TVxOOpA8zYerFgBBy/S1Gqym54QRqwIVJ+cWY90U/f5bRdMSZcein9x3rY9emhF4QChzigvuz4TWzP1ii8VedmtmJvKwVP2ihobWlcLlbpMclfg4V28Dxs4En2NV/XxKZq+dvfeZZcIaQp1q6hn77Bw+8Hc1VMvHQvioM11gC5ytjcb3qVkmFtuBvFlXLTrC5IHayc
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(36756003)(38100700002)(6486002)(41300700001)(6506007)(316002)(6666004)(478600001)(6512007)(83380400001)(2616005)(107886003)(1076003)(4326008)(5660300002)(8676002)(8936002)(2906002)(66476007)(66946007)(44832011)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FfnJ180e9hl9+U5Nniqp9BQUXr7/vo0H0b79EnaNTvdM52S6UVpXYPX7gHs2?=
 =?us-ascii?Q?8Vi8HpkPPOPHuPHaM/Qz3DMtSblnB+qpORhUM40xZuvkiwZKDOZOk/rFbQuC?=
 =?us-ascii?Q?kKn4CdszU9sJ7yb2vLbM2ao92ib2HquQlgTCau/PG8kBsf1qR6iMjEsc818g?=
 =?us-ascii?Q?F4grIQaMLo4qrHv517fqgQVYnN3GfFIFx+UfsgxEJ+LSYArRv9G3+uS3vq47?=
 =?us-ascii?Q?N7pZdFqugbP+J2ND4dRCWIaOyKId89zJFpqMQZSjWzN4Nr5EvMMBm2Vdcsj1?=
 =?us-ascii?Q?2vhfkC7Vki8hh9unbA9/CAGUYAmmC7Tdd+i+GVm67cge4AcPJMLAmNHLrpOj?=
 =?us-ascii?Q?7sPQgvYPx2JkRRUcZA5oS+Vn2qA8oBLjex1EE5vWxI5vwx3v+9r1Xh4a34z6?=
 =?us-ascii?Q?TfWssOoAQThTM5BK2en/r2mBQDeLPSsEl90oLNxOnPYxFcQ7htPn4Om5iY/C?=
 =?us-ascii?Q?w7LAlm9xAjP960DaSscdLgPoom/d9QKocBvxIrrrJqYOrKAIhhEwYsRveEQJ?=
 =?us-ascii?Q?9v+AxId4psAGMMOgWCnGyk7em/kMbmepqWZiQrLCrw7I1Ln90euZMFIyY0+e?=
 =?us-ascii?Q?yVHm8xhXICmundL8A1gR6w9vCRDR/R1oi/xbsv8tS7AUvvtK+NnjowWnlpnC?=
 =?us-ascii?Q?iKtErG/9S44XUZ0V0abY5kGhgjYLCtf5OGPykKxMTANo7TOxjNMA42XjdPBr?=
 =?us-ascii?Q?iCU0neX0Xn/+R7o27Riz3sQNjW2Rb0M0z/7BIME90gsqVhcPm8LAF7LPShfl?=
 =?us-ascii?Q?MLFMkvDTYusEpFU4SDnSC1AzeT/wh1kEduGnp9N7hEt/4i1wC7KP6Wu471Ug?=
 =?us-ascii?Q?oSsWhKqU7v2+235woz4YB/Z8ru5B59Olpwndbi54p77BPtuS+/PqKZcBy0Ia?=
 =?us-ascii?Q?QYFOrZfe0DKn6LBfXsl3GmUahF2WacnCN9mdrhoCFKMV/BznEOIPABqFJvtQ?=
 =?us-ascii?Q?yXKKKPaCFytBScplODbqXmm7GyCa1vcmq4YNAWVmuMWVi6JK2M09gJaRd6By?=
 =?us-ascii?Q?Nkw12hHT+qkTqEmxilnKEj2LuE97WMWXYDG1bg/F2YMq/oeTqPVo87YEiH/x?=
 =?us-ascii?Q?o3N/GrqaqJHw9pIuINZJO2eK1FzybHpXIQu7e+08vcWe1UUxI2WAod9lJOTD?=
 =?us-ascii?Q?P9mvyo0s4L+5VmOEvBdco34sJIoZBVSAcPX8hFHiw/je/Q391eG/l/l79QSh?=
 =?us-ascii?Q?uT9pE9yM/tntX05FBddBTbuJvSFKXuJ+pialtAb29iGMzQGvyzGefhREdbGY?=
 =?us-ascii?Q?WZr/F/05O/PS8lstej1cb7E1oENUmP8fBW5RzeBg0nCrEvdUir9sNe+mVR0K?=
 =?us-ascii?Q?b/WcKJi73hbZ8KF3y/m3nUpyJ09tK8XGEUnDPgPRzgrndud4w7n0pDh6sur5?=
 =?us-ascii?Q?hY9mqSU2VnoeWTrLKZGgGNnkwP268oxRWiFdflC3b2GTusH2eXLNznCrkCbz?=
 =?us-ascii?Q?16aYfEBeriQIoQKwWkhpY0WMJvOi9/9EGYQTrlcgnfYFxcNiIJfXAqbQGwgZ?=
 =?us-ascii?Q?rw6ARNMHYyMt0G7z6QMqbzYikYFrAQ7TLzil0EON+qQqVnYdzFkbz1WYUBRz?=
 =?us-ascii?Q?AXCY4HGrb/Iby+YCqEBfvMxHD6Z6DdrxjWCSw/9c3Hyh2N3rrO382u7kPxlZ?=
 =?us-ascii?Q?7q37GzN+q9YReEfIwKCkWPQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ySCrPWNqdKv4yuYPD2j+K0DXBCHwFA/b2GrwnQX+cjyRl0uJD7YQ4is+rE8Rra/0RtUHdJiVxCSNn4mmfAxXiIZPkDVMnA+Fn8WcSrglbiggYti3w2LWEfzGmwpvSTD92wxJJKOfdWX1Fh9KpEwqH5uofYmmXNyT2ZPo4aS+MjtGnN84yv6Efmes66nvbXXnhTLBxIqHFvNLjCreDLqijSaGu2UZjgRLqFfTHZm4DqhNcfkD592MofRBJALGkWuHIFhHK9k0I31q1h71TkXiK/aaY0KdIwIFFzQY9V2MagZDxeG86cwer7kCndBZ+doqC/sKj2pJrwvmUOHpWfaygTrtztHllZxEMsffDqBXnEuQ3At7/N3hAL3+qqW4DEFGoIeFfPEAwZO8PKoaFbvT0NBjm/6kvJLCs3PbtcxO2Egi+KxGGh5eQ8NO+FuVckwPOzXZdRfi6cqOMk3zJEFy3UKCjGLHOV4ApmcErjX6bAMjScFDTJIVCmumpgJqjIa2SDvOYX9zWmFTkHQiNqOgC3fPxY0a2ipafrkVjNwgDafCsW1fq/emSFpgVgMTZYUs3Hk79owFdQR5P7dHf3hruJqzyMKMvHmepktmh0Nq5D4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcebfd6-7eaa-4fbd-b4e2-08dc2f342077
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:13:31.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EF5CK+6GeeD06MXZ4JTW4g3vl6p1x8akwnJYrFxoGr+C7PA8N9+VTKLrZODlGWWhpaJNxvTyHDBlJEm1CQtJbgUgSulQihInhsD06k7N9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160167
X-Proofpoint-GUID: 0UPkmgna_Gs66oS7LDBjgOmhB_m-hQWb
X-Proofpoint-ORIG-GUID: 0UPkmgna_Gs66oS7LDBjgOmhB_m-hQWb

Use folio api functions from the already defined src and dst folio
variables.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

	v1 -> v2:
		use migrate_pfn_to_folio() to directly work with a folio
		per Alistair Popple.

 mm/migrate_device.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 3d3c2593b5b64..81623f2d72c2b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -814,42 +814,39 @@ void migrate_device_finalize(unsigned long *src_pfns,
 	unsigned long i;
 
 	for (i = 0; i < npages; i++) {
-		struct folio *dst, *src;
-		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
-		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct folio *dst = migrate_pfn_to_folio(dst_pfns[i]);
+		struct folio *src = migrate_pfn_to_folio(src_pfns[i]);
 
-		if (!page) {
-			if (newpage) {
-				unlock_page(newpage);
-				put_page(newpage);
+		if (!src) {
+			if (dst) {
+				folio_unlock(dst);
+				folio_put(dst);
 			}
 			continue;
 		}
 
-		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) || !newpage) {
-			if (newpage) {
-				unlock_page(newpage);
-				put_page(newpage);
+		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) || !dst) {
+			if (dst) {
+				folio_unlock(dst);
+				folio_put(dst);
 			}
-			newpage = page;
+			dst = src;
 		}
 
-		src = page_folio(page);
-		dst = page_folio(newpage);
 		remove_migration_ptes(src, dst, false);
 		folio_unlock(src);
 
-		if (is_zone_device_page(page))
-			put_page(page);
+		if (folio_is_zone_device(src))
+			folio_put(src);
 		else
-			putback_lru_page(page);
+			folio_putback_lru(src);
 
-		if (newpage != page) {
-			unlock_page(newpage);
-			if (is_zone_device_page(newpage))
-				put_page(newpage);
+		if (dst != src) {
+			folio_unlock(dst);
+			if (folio_is_zone_device(dst))
+				folio_put(dst);
 			else
-				putback_lru_page(newpage);
+				folio_putback_lru(dst);
 		}
 	}
 }
-- 
2.42.0


