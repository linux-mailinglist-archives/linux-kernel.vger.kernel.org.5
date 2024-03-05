Return-Path: <linux-kernel+bounces-92361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F33871F18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23AF28568C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398B5B21D;
	Tue,  5 Mar 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DrMR8nCr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r3WUYiA4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCB5A4C8;
	Tue,  5 Mar 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641529; cv=fail; b=srJEaXmoUTbFaFC/jyDwp13gpnWEcQVbwIuSteZsJlAFlOdaLjodC3ODYib8Ex3R0wG/oqXmsVEkyIF2h98oCOxQbcNjlEV9OyJkdWIGIkYhmRHVjb1hiZvKPjg00iJY2sMfXNQjuzG8xgWZJD4Rvu/NrUcacAJDUpQGyOrfIdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641529; c=relaxed/simple;
	bh=vNqd+bjMiJ2WCkNE9isBfRItPa9mZecsN4F5gRWVu48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTJmrBaNZgZVYWKL+YCtDtl80jra+eFTjgUsz6GQkfIriFMCl0W7EBTRspXYRvb/4lY1WA2l0XYriYmop8V29GLsTCBs0rAIlGXWF2vzRlD/+0kyBUftcgKCJgMb0fVKN6FJi0lurNb1lCkhMlsdOC7kuKx2j4lhYUAmPNbLoGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DrMR8nCr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r3WUYiA4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259jRxp024627;
	Tue, 5 Mar 2024 12:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=l8RU4Na8lBBWN8JNbUugbRRKD7vvJG9EfLByvE/hrGc=;
 b=DrMR8nCr3m0oapr4IQg75SCHkd8rrGV5joWME3RvkUFjQtx1vL+Ccz/yGUPrmYW9fuQF
 i+y4a9YuImAYp/flGuv7N61G99ph3XNcgLBVXwNp8fRRui4uG2kaRAXCMVFgWOHMzF/F
 lrrhcns8UF0U7aCRrKibXaXXnBFoKd+zOAdFeHzuOOAl4YJ2pV/XlH2luCKpEteYlHe2
 g/O0Yuq0oXeDqxwjRF5iZwv4Lbe2+c52ozxCUFi4bKQqusJBMAbr5bedIIkh5tsz00ua
 lmJ8Qa+ImXaOY63S8AWoawMEKvAXKhnLKUDwCkvz03c4wLNOHcRz004s2aon3JZFHLZO EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1ce40c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BWS7s031907;
	Tue, 5 Mar 2024 12:25:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7r6yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfzAj4dFuA9yBumWtfRnnkYqOFwQU7IaZpuo49R2LCZpAi6PYq+rrPT9TNvo68DrXF5ZI7JLIjb9DM1knDsy4ue7y3vP/30N4kNfGE0h3s7wQlfpBCkbtCbxEzlC6lBD1Sq+QZKuMmj/3dQ+SacHJLYVu4EkVLptEisHb3/teqd2LaVLvxeRmzAWwTvyicvlA5aBlLdhHEz6f+fs+5uBKEqAHL8/fOPts4EUlLd03gVEdvl6bjuX23bdT3sbJwIjK7P/1P/l0Bn1bDEsUD+LYih5uD8+x4zKBYvSc7VKHSUUs12EFHEuR5Vn3GMqUXUKQR3jZWrfzW0GAjK7r3VyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8RU4Na8lBBWN8JNbUugbRRKD7vvJG9EfLByvE/hrGc=;
 b=dU1N/oCMOeZgULkaYujEy5BSsaP4xsmEvRlickXgvnaZ6qGGe0SN1IsPwapRzSzKflVlU5bGC+GPit8BhMfUFQGRicYb/aD3McJNuOMbxmLwarafn4Ua8CBZ2extEo2xMMwTtsaHuJYCmcUNh/a3s/ZvMbN02B86crOBFwqNek7gLKHDFzZIJsmcaRL56BVu/Dp5bNDroCbAcJ9vr7HQ7XF+8HUqA7FD1+Trq0B7xfdnjdjeeK0i1ZWOfklFcBYIlm2popwN676Twv9iUfJJ8pv8/TwwuPh/wlimc/LtuwNOfvKz1hAOwKeEW+4YmA4i5eZjZyUS0s2DAoPXpTkUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8RU4Na8lBBWN8JNbUugbRRKD7vvJG9EfLByvE/hrGc=;
 b=r3WUYiA4r3o/zqU0M3SEWxCGQMBGNn83INYopwBDYd4lI9gNstDrsjbxsdC5DKC+YjeONkaK2TFrzBDtSqWzD0fM5rzm3Ju9lCBlOQQYz9sssGAC1JCmnRwGXYwboPmbDol7jrVLJIiB1pYS7HxKaJqY/ek5DJBfU7uPx8zeTzg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 12:25:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 12:25:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/6] scsi: pm8001: Use LIBSAS_SHT_BASE
Date: Tue,  5 Mar 2024 12:24:48 +0000
Message-Id: <20240305122452.340471-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240305122452.340471-1-john.g.garry@oracle.com>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0500.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 882b2c1f-b2e4-4c23-5b3a-08dc3d0f4d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yv/4DScXgK+tLdnATnROPlkDaDnSJ3ALoHB/Xe0Rj0uWh0ZdyQ1iwbS+Q8Ev23u2z8nAwQGW0GEuB7nsUoPIYSJN/2h8CbkhRv04sVBo3l4xSFvKYxSBcyCYCH+P0T5hCw1zRYHyd8Eg+1Pb6xOiaxPzjSrVTGXBzBBrkbVUgDpiOBFf53pJJ4awZoQXAROR9CjvVCxA3nbU4eI6xYzOHSaGRw9WaNI2BTmZDLYzTIYOKTClBMbe6rOQApVpgezCwEYPN9I6jqGZYpzn/80S2pp89vfO4iS+ZCCIH8TNCRR2RHN70+PGhOEFVqWlljSc+K+OgCmI2+YpEpo8U7iZPk//ZgCNuzWlLni6Or7skRk6qmngySUYoEOMEG/AnGBcBvNPT57pr1AJYiwqVX+MTPCAykeTQxlotV3H9FO0uR9f31c+jO9xsftiqyuuhknw9QfjF+M3x88s84MjR+SG2fqT29xSdxShTyL0CE+MFI02QAWtmYe+LEu31c9F2hQlhU7kYgn2KsduYdXuOLc6bpW7+79NqETGqi/HYgalYDslqGMiXMiDiYCDiLbHY4R65GNHzYWHvay7hgmcXxcO1bNJQ9SR75M2Jb86sMypAIxpqILiA1Bs/rJYJOR8DYQ9lO543v1sQJA2IHOyp8893sHlr7I0rfZyYovUUYgpD1Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mn3Js3irJz/cso4FhPRasDxod7v/07SIfWXBuxKU5YrERHPYJWCgMavuWzX+?=
 =?us-ascii?Q?c6+gWFVAIebLAEm3s35nTJRpcWqh41Eh60zsmsvjf97wxMxkOfVtMUGYb3Tz?=
 =?us-ascii?Q?rRIrwyrEmoRsiKR3tubr0Ql+UOUqf+HMBXlB7CvCfaEvcuvxD0u12nnIEWZv?=
 =?us-ascii?Q?4mT1P26TTHVB8E7iB6dGgsb8k82zl2ZBJHfIFO1qES+vjXRuEuIqbc5TcV3N?=
 =?us-ascii?Q?BgWTvPMZaRQwoWvuKxaTh9K0d/K0COnSSyVvDA/vUIGnfmYlccB2xMrFq1kI?=
 =?us-ascii?Q?+7LfTqHWvrb2EQj7m/tH4MgpniW48cEtdzfLBfnjopRYHg6x2xoTvDkUZI0U?=
 =?us-ascii?Q?Hg0fBn0tbvie3GQkm/mllqTyLKzsUV+E8mT0rMvz5nALjW+NSHG+FI7iZfTU?=
 =?us-ascii?Q?d51WdXb0Rfu+manSMsmHxpHLDkqAJbjuUlvn6KxmMI0cwnm8PIVSa1irxC+l?=
 =?us-ascii?Q?hkFsybWXxcI70My8+I8XECFdqQGg1TFWRpfKV6N0cniadH4KH1l1vQIt08jM?=
 =?us-ascii?Q?QV8kDfA2ThimN3qj0l6oYrqlYgtMuOVZtUtmenaLuzkB59wEmZPgWAgOZ+uM?=
 =?us-ascii?Q?mauR8CbYc1E6v/uHEv5Mifsl899XrrKNQ01k4Ofd7kW/qodof/cOArpzuLm9?=
 =?us-ascii?Q?2lrDK91dSEny6nkXW9iEgy9macgqnSUKgyc7nKyoEno6WTf7ajhQ70XdUMPO?=
 =?us-ascii?Q?dALSTZyB50D1cUnbrmddp5+JD2zxV3qlE+87L8NTVYwiISHro0SjuJH6zw67?=
 =?us-ascii?Q?7KNkGb+k193aYlR2R/s/wZl76hiLPkceKzYws1tE3i1NRnYKVZQT39hW3fon?=
 =?us-ascii?Q?DTZuYexhjPqHY0YSZ7szNfiZ0A8ZmMdYzw1QpHUDb5FRbvF3D4VALJFOMhNz?=
 =?us-ascii?Q?AwDBV6h7qHiQ/nkTiPKTz8UcYVzbkj3o+QZBArOQT4CzZ38HaPMy0tn1TcK7?=
 =?us-ascii?Q?UAlt2rKdOpFgMy2lSY9cNc6p2AYiW4FMBNbbr6DQGSKqQLdA4S75j9GnqI9V?=
 =?us-ascii?Q?aDMZprbOLsY7habbzgu14IcMXUk0S6O/pgvNzYby8gAgP9ViBDqiNj/AJhCW?=
 =?us-ascii?Q?PDpFT+/fAZzuURdQLhATWdPqvL1Wyd0cP5y3zCvqQe7xwt2Pgc20t/w+OlrS?=
 =?us-ascii?Q?zAcgkiBJJHIAKk2DQCTIQEwinefZuoz3CPhNOMDtVVUPW/zn+FVfC7qd8crY?=
 =?us-ascii?Q?fuozjE66rWbFSUbO58lqmHTQNwn2YXN+vHqGy7vU2oho/E98Z6RMT7fEQu9S?=
 =?us-ascii?Q?EzgX2gwpv7FE6ViR7jqCfAre+IylLmfvJ1wwG4iPLdAGh0jpnc3lhypMAI5I?=
 =?us-ascii?Q?/NyBaQOI9UJ5FTiu5HDIsazawBt4t7TO2U2O+KrNS7gpCV4SPXm39YqElhg6?=
 =?us-ascii?Q?J+EgEHY/3T9SEmIwym/73d/P61nU0ag+KtM5tePsSHF1UKbkTIN6GUeZf5Pi?=
 =?us-ascii?Q?Kpq86WSw0sREIZXN1YcJiNFszmzWqq2Osjqrpfnv2TWRdXrnUDqWBzRie/fp?=
 =?us-ascii?Q?79AxBXVRAmZnc/yBFx1XLGULwsUeW/2zLbZzaqC80MdgF+4p4Y3T/uO514e0?=
 =?us-ascii?Q?6FcCn/mO382cHgjrIlfnQ+seBoNgX0qtkMdjepSLdK4p5RF/2YO7dcD53fFA?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RbGtAoPNS6u/EmhygYBE63XFzbP7mjMSAe30Dd/ht+j+chnOMXmMWZiYEh/jT99lyivGpiow0MRE2zerZ7LJSSFmMr+Z4fTxBqzCFk1SginBAW5dSqK/jMd+5M5wDXQB60HDqNmcRUfyRMabTucrH7ZUnVPKAF2CD7/9ulKXA5JKzR+y1+dzEv3rVPuxL06hnuXKSp+osePHrMqqxpz7caMn23gIzsfQEU7D5pkgIA0nu/cactOTP1jwgtJL5lUTgzhiIpF0EUIgQfXeVGIZ+LbuGigIPV+9+FuHaKIgu4J81rEK+sQhZqkRwgN7HuENekZA9jxRzaDu5h55xayUH6/KFq4t9W9o0Bnbe4U2jn97CpOSdawbDi0uhi82DXYrfoNpjgd4QBZ3Qv39sUu/erw6goiqTj5keT+fj/N9ko0PCr7aKA3aYS0z/b65YnI1GjJ54XAQYH+Qc4MhOYf8etAOWj9gGLGQ4Q/YcNMhRdVEQ8YfgXSfUouw9y23udaYEGVvQIzbbA+wY9CTOg94cLexLkBNnQ0KH4f4yYkVnWHojaXmn8c3EpLlHMwRzGqnAHT1weWns1FV192QHaRkjElfv7zW3kSbiBfFkAdjG7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882b2c1f-b2e4-4c23-5b3a-08dc3d0f4d72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 12:25:11.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOjbYALkJrO43inARfIGPd1/z9EnZ0vydyd8aBUNLs3dw8u7BiUbGclEXTZpnC+UfcwxMaCxsUm8mphbsjUhEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050099
X-Proofpoint-ORIG-GUID: Uoy858zjlH4yF3Ib7t1Es0VfOpATfg1m
X-Proofpoint-GUID: Uoy858zjlH4yF3Ib7t1Es0VfOpATfg1m

Use standard template for scsi_host_template structure to reduce
duplication.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index e6b1108f6117..1e63cb6cd8e3 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -110,29 +110,11 @@ static void pm8001_map_queues(struct Scsi_Host *shost)
  * The main structure which LLDD must register for scsi core.
  */
 static const struct scsi_host_template pm8001_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.proc_name		= DRV_NAME,
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
-	.slave_configure	= sas_slave_configure,
+	LIBSAS_SHT_BASE
 	.scan_finished		= pm8001_scan_finished,
 	.scan_start		= pm8001_scan_start,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
 	.can_queue		= 1,
-	.this_id		= -1,
 	.sg_tablesize		= PM8001_MAX_DMA_SG,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler = sas_eh_device_reset_handler,
-	.eh_target_reset_handler = sas_eh_target_reset_handler,
-	.slave_alloc		= sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.shost_groups		= pm8001_host_groups,
 	.sdev_groups		= pm8001_sdev_groups,
 	.track_queue_depth	= 1,
-- 
2.31.1


