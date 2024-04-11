Return-Path: <linux-kernel+bounces-141351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED458A1E49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C44B2E9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCE1CAE7B;
	Thu, 11 Apr 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gbPQ6J0x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="igGfgZjm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A01CAE72
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854119; cv=fail; b=pV+dXwDmOKF0yj2/CDOZV2/svUJwoJDk+IwhUeEAMQcuWHxNhSlqRPPNV2d3yNc5nx2bLgovbGzb4hC5mYj9ltF/jZqjH9tyRb2xIbeEMzDXrLZvy74IqMBNqw0Jjv7y4uWodn9G817jhg4FWwicQ4cMhLjS8M4aGv62Sssu61o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854119; c=relaxed/simple;
	bh=+Jt+RToABQ4tNGtIJ3Ii9UcgGFDOtiMOOquyPMT8jjo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p0ocRUGDjRhSNIEXZiwXCy6I6fv+PJAir7mFPe68i5ffS0kiWEwURGTVAzmvebVdIBmu3g4FjA0ZjZdyBPHWF5aR3WRWZ1aaca3nPICMYs3j+EG+grdCi0EWWOblnovIIwCrV7C2BWsHekWvxnsrB5l7TcZcEbldkTdudaX3JMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gbPQ6J0x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=igGfgZjm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BGYdf2017899;
	Thu, 11 Apr 2024 16:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=f8sFCY5eMzQx1lPLAsWTqrbAVgNkmlOdQ7rrLKpK2HA=;
 b=gbPQ6J0xgXKCA5OZijsfQeSYQx+QegNRna/ntMVcKZcVXUsXmSCNtL4uY5wISc41Czc0
 JojtetCuIZjbZM3PbKuwvl32o/MIjKdfzPqExyKT+l2a6N6VsnlVcsZ3jtfek6+mdHF6
 js+YgMtuRp87Mf4kXrzjRfPy8Fx/8xgPAUJg1Se5DPxqZhSEBj/jjUHxzGYHzzlQVc+7
 Pd9SY/H0KCdNp6d/C1VJ1q8fzjhwW0UucWsSoDAFIUQdSdmn6/r0wj9bHyhCqYeQ3mAg
 Ln6UqtdZksVELEIxapSzGZVuOzNkVtVc109OOYxhJb/6D/HQDAFFdLiGav0kkiptn/NX Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0ut30j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 16:48:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BG7g5T010830;
	Thu, 11 Apr 2024 16:48:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu9su2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 16:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+7vDySWAGQBjZTvH7YCF4Zcj7I0J7HA+N6ffx6HvSN8UFVbizjCg6VcuBhJCiBzss9fvx6r2+SK715kN/BjXSjbJJyHA2Ifuk7+zscv7eamsLYIbOLvBv0+lbGSA61Bjha/55YVASdsIDuh6nhPZE8NamwgIBQGuOpUyJ9ejS4X8r5NkKAYnrdiqDXKMow4DG8Qj1ljmoSmB5QxcIeW1QgGav1NalbrOgBbsyBcwEFj7jBufACqtQXpbwlVbmE4jhAdm11K7YWc1SYDaxNtBgPKEZUrvqhKqrZ90sh//cJogVEZqLbv0WtpHZPgtqDvs6cp/MHGXbutVs2rVG5c7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8sFCY5eMzQx1lPLAsWTqrbAVgNkmlOdQ7rrLKpK2HA=;
 b=RQkCobPpNBKIUSxn8z1tBlD9kzfZk2en+tan9yDhuLgSW/OlevfM40Etf+OD+TnbECpNDrGiPnePfFBvqeJ9MmFS263esr2qROzAJTqlTfgAc+aerMQrGmMlyuOlHH/c+nEec8n+uaiAwcjobi4COBK+f2rbPZ8eVkJEGBTz297eY7Xy39UwCOb8Pqyk/700pgDs0Yonz1sy3MgZhbNKEbihPCVP9a+YnFgAP/17F+yM6/KngXgv3xK/22BCLhP5KWukk0jLEhaIRdTCYGc0zO6+p9wv9BX79fx/MvQc6RJzCzha8t5OrkeowNoZfni70BXzHd6OxufKUG3OJ/2+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8sFCY5eMzQx1lPLAsWTqrbAVgNkmlOdQ7rrLKpK2HA=;
 b=igGfgZjmqRIHZUn4An51ViAU6kYKhzpQiY1NpuhqKS/TiiaVYn0XHnWWylWv0el7y2WbgAqSdFCbNRlel2nOvtg4yAswpm68nvLt+1LmBcEsTGogooo9rS+JayKYlPfAiuj0EgOmQl15wXIgkV6up83fOUpGuAb1cKa3vFvB0yE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6827.namprd10.prod.outlook.com (2603:10b6:930:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:48:01 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68%5]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 16:48:01 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, linmiaohe@huawei.com,
        jane.chu@oracle.com, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/hugetlb: convert dissolve_free_huge_pages() to folios
Date: Thu, 11 Apr 2024 09:47:56 -0700
Message-ID: <20240411164756.261178-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:610:50::24) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 59857892-9d1c-42cb-0886-08dc5a47265b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z2GJRAGN3p5LPCiQ0t9jPGxyKM99Q9Ld6UnEC64tSHYrlZL8SUriqMm7jgJAyCboQalOcRvXQ2dgEIXyMZ5+oqpY9D5Ayi0gLMEQPSQyinMGL4qZlCNEd0QUFJAF92CB9H4pRHLVN04iDTFYJKGFi2qnToWez64Bh/T/V4T9edriII93jyFAUvX6ycYB6ZtEnrbRFQdqlE89BYCueFKo4gijIpYQc3uDCRY5CbeOTjU+rffm/JqWW4Ud7fytufzmynywDBPa+T0qPysUpe5VqmTjMUK9sndHE81VYywIX0Iw0ax2QqOR9wOZyojNQQoOLTZfnV4qPe0hd85YGB8M6xe35vt6ev//DB4ahwORqwUo9v8yM1cbVfsdsafXnwIBojEf5OuFt37MhCw72MXmL8LSa6DBG6PhWHJ0hRsG9jZlyQ1kDKh/OtfdIBn9tv8eBCze1AT8fNpSnE/OL2yqpVoP34/L6bcjplXiLDaTRhJRMpQ7r050Qj1VieVby2RVaIBhV6vw+WRxJPd8sTezR4myHnTL8RuD18XHb/OFwRz4NhQkR/PUs1BVaP9Lpc/jWTWo+iZtK8PLDTXUeFBvtKnzSZUAuX3MZNhHrzilqgJLWpufbhR4LHd0DD4bAKQl9tAaC4VkMmCrpEwfahC/HNs7RKm0N7Y2aTPpD4Wlvpk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P04x3QLP+1zFZdEgozQoounLRwK/4qgKAdS3+T/1kmWDA+Gc2Vo/Z1CJ+C8F?=
 =?us-ascii?Q?XwMK4P8vi4rdCiOBvyoEIhAMK5+3gYwxsa7PpktSSKfWEo1AIBi0Inun24IV?=
 =?us-ascii?Q?w4iA6fvVMvhaJ+pXkqIwXZs1TEK8AbPfMKWATcsDX9jN2yE4/xu1687qyv39?=
 =?us-ascii?Q?+M49cn2g2t1A0rUEnrsnyk+YZyroKPHbb9aSVHJKWMS+LANNVcTcq5KdG8EE?=
 =?us-ascii?Q?UnxqPj2lq6kyEErIR09RJFZUi+7A8fFGQFIQEWC3JvJmt4VjcjDOYOT6qjVs?=
 =?us-ascii?Q?N5ad90/Pf+WE877aluY+crmriMOHEGK3MX4o7fSzZbzRXAubzjtZzd7uav0X?=
 =?us-ascii?Q?yHvcGAAafuxMAsbJg0ixtHhk9HpWPvFQBM6/TzWhdYFnrWfYQpFvViSzfSbE?=
 =?us-ascii?Q?fQCk3IdJn4xaCzni/PRTxA+hZJrMGeZIdAwikhhjEEoksuW1e29fFFB1j+ko?=
 =?us-ascii?Q?pgcOXWtWOrkjCVR0HgATIoeNTs7OWJkGtd9H0OblvuJUBiXnXCw4tXVp4Y2Z?=
 =?us-ascii?Q?flEKxgf4sODYMnuJW3u8FyBTT9bgbUnfOkE5vgLPkrs0ITKJrDePqOSkQeCc?=
 =?us-ascii?Q?qzlxiy3TUImsKMcwRlr8l3mHO2zCPb036R8NoRxDhddzY6i/nfQyruWHle1V?=
 =?us-ascii?Q?JvvZcu7Me8BXVcY+hOEzNQUK8aQp1pxil7ZW/8KrCsk1ivFXBRvLUNzWpctM?=
 =?us-ascii?Q?PWmXbzFK4PrDU9wYqexuoEGNXTIPxUdGrf1nu7td2ejhx869HzD0DbcjgolP?=
 =?us-ascii?Q?4RWzIEzRfnzCytSch/Vxu9A82t1gN9qpH3e8jSMkyt1gQbeEdbe01loQuUVt?=
 =?us-ascii?Q?qPOEf7sfmkq/s5kjkVTVKfIR/yfbgDXFQqiTtIhh9y02RrrMmeqKxxvFxZg7?=
 =?us-ascii?Q?CMPTIohmJzzACLVj6DUXfucEC6mX1Ap/f1l5QVyT8ANCoL5cwDDGAClGZKtr?=
 =?us-ascii?Q?pydzc3L6hSHXktn+u9qmk3HVdX1Fnc0bA2/qBoHjLtu6xqxbZqFHIqAE/4gR?=
 =?us-ascii?Q?Mh2eUrrliK5JpnOseXzh/haqmBCfGcby10X39Ft5ujJOJ+tOHDkX874H9mMb?=
 =?us-ascii?Q?ZWtPJWfT/aC1nldim/Oa6m4Kry+VVDtQg8nTiNvyohel6k5rAPpbT8mXVtaQ?=
 =?us-ascii?Q?itlPcFOJ8TV1N4lD4CmkWokYTkwUEit5bzDf4nNCVC8UXz/Y4W12f40zaAcP?=
 =?us-ascii?Q?CeB5Noe3HSJJbHrqSKNod7YxjFTU1SAdbjwOaNSaL0ATbncNoU0cSzrHb3wY?=
 =?us-ascii?Q?8BLWykBkW6gDVyD1Q+7JAPYY4VbOLDo5vjFeJnLHd2Qb7ZWivsheYqdI+5+W?=
 =?us-ascii?Q?xLxLB0mEu059dH1Ta25VQ0A4pVi7j4euph9Xhp+EZaPqw7+lINv74eIaVXmN?=
 =?us-ascii?Q?YViTTzLnwHVlJAo2cyxNK37rWpGYDnfoacSx3g81es0F8ls8nh3tOttTjQXG?=
 =?us-ascii?Q?+0z0ImeXmTyTNHwC3aN7cuJ1hAEdDBoJxGRT91bvUOLbN9hMHjBNbxuatQO6?=
 =?us-ascii?Q?gAaFbcsrVnBfV96OxcE1ptU2M6XlCRePLxgjg3QMgZW4JC8eeR4zBlPWK5Uo?=
 =?us-ascii?Q?VzHM8Qq/+viF4froSg0acVFmQsJ5f4UATVWUA4aIUSDUKxpVoRHqjGc11YOQ?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PE0dEeh07O1bsjUt+8ZWnySmS8Z5+a3neHQGCPYFYBLf2VZ2zzO/Y48bakyRxilPxunJrZPfLG4c8JP5J0oMmldLyV57iFc1bsdJXnzO0eV1Vi52SZMTn8VKNfEjCm26OAdV8WQItVf4eIPFvWch8BKzyU1PDbNkwPQhFDLuFLFGxHzC6xAHg5gM3Q8/gd7qy8gXxDAlJ5Z3SPyPaWeXOWq/B8B0zLlXFqoytA7fWGuo8QleFhqWy4xLiEZaCndwaSdp8AUavoq4DOuP5nbUnwIdVxLzHretKJhOTp57F1D0hsIMu0K8up1aS47LKuAGtOF3DqX//iE0ak3uKCzhgRnrzIeYy8MLcNkNISVvlXQClCxxHsaMxv76Ib4CGDnEaKi3XLY5AkwX33s9hZ1zDkykWPYzBGFhy7hAABKPxhpgyAh562Fn9jEDZZzjpyF9TNaDxRw47uzSjMN9ak0Iv9/aqXOzrXiIhjMackM8j9ztVbx7zTTxF8OFz53Nyf3FrU5mUv2rNTaBG1ttUjcplp0btcvb7ALlwFufonkf0JYjPnLiNp6Gs6EHwUi7kvW1PrsbWdYiwhe+bKsBw5K4f4iynd+JHfy9JdrORGX+sfY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59857892-9d1c-42cb-0886-08dc5a47265b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:48:01.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNq/IPiGcHW34CtlhoEjBY0L/wBgipMsabBGgId1IgY8gE0xYf5zMLPI8IRL7N5YunJ2i8oPBigSnlt9IV6kQe8hK1CB7QAep+/gJVPaXCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_09,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=974 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110122
X-Proofpoint-GUID: 54AU2YM8KA7ayH64Unh4fpYlW0RcSmIs
X-Proofpoint-ORIG-GUID: 54AU2YM8KA7ayH64Unh4fpYlW0RcSmIs

Allows us to rename dissolve_free_huge_pages() to
dissolve_free_hugetlb_folio(). Convert one caller to pass in a folio
directly and use page_folio() to convert the caller in mm/memory-failure.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 15 +++++++--------
 mm/memory-failure.c     |  4 ++--
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3f3e628802792..f4191b10345d6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -861,7 +861,7 @@ static inline int hstate_index(struct hstate *h)
 	return h - hstates;
 }
 
-extern int dissolve_free_huge_page(struct page *page);
+extern int dissolve_free_hugetlb_folio(struct folio *folio);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
 
@@ -1148,7 +1148,7 @@ static inline int hstate_index(struct hstate *h)
 	return 0;
 }
 
-static inline int dissolve_free_huge_page(struct page *page)
+static inline int dissolve_free_hugetlb_folio(struct folio *folio)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 454900c84b303..617f8bec6eb42 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2377,8 +2377,8 @@ static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
 }
 
 /*
- * Dissolve a given free hugepage into free buddy pages. This function does
- * nothing for in-use hugepages and non-hugepages.
+ * Dissolve a given free hugetlb folio into free buddy pages. This function
+ * does nothing for in-use hugepages and non-hugepages.
  * This function returns values like below:
  *
  *  -ENOMEM: failed to allocate vmemmap pages to free the freed hugepages
@@ -2390,10 +2390,9 @@ static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
  *       0:  successfully dissolved free hugepages or the page is not a
  *           hugepage (considered as already dissolved)
  */
-int dissolve_free_huge_page(struct page *page)
+int dissolve_free_hugetlb_folio(struct folio *folio)
 {
 	int rc = -EBUSY;
-	struct folio *folio = page_folio(page);
 
 retry:
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
@@ -2470,13 +2469,13 @@ int dissolve_free_huge_page(struct page *page)
  * make specified memory blocks removable from the system.
  * Note that this will dissolve a free gigantic hugepage completely, if any
  * part of it lies within the given range.
- * Also note that if dissolve_free_huge_page() returns with an error, all
+ * Also note that if dissolve_free_hugetlb_folio() returns with an error, all
  * free hugepages that were dissolved before that error are lost.
  */
 int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
-	struct page *page;
+	struct folio *folio;
 	int rc = 0;
 	unsigned int order;
 	struct hstate *h;
@@ -2489,8 +2488,8 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 		order = min(order, huge_page_order(h));
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << order) {
-		page = pfn_to_page(pfn);
-		rc = dissolve_free_huge_page(page);
+		folio = pfn_folio(pfn);
+		rc = dissolve_free_hugetlb_folio(folio);
 		if (rc)
 			break;
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 88359a185c5f9..5a6062b61c44d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -155,11 +155,11 @@ static int __page_handle_poison(struct page *page)
 
 	/*
 	 * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
-	 * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
+	 * dissolve_free_hugetlb_folio() might hold cpu_hotplug_lock via static_key_slow_dec()
 	 * when hugetlb vmemmap optimization is enabled. This will break current lock
 	 * dependency chain and leads to deadlock.
 	 */
-	ret = dissolve_free_huge_page(page);
+	ret = dissolve_free_hugetlb_folio(page_folio(page));
 	if (!ret) {
 		drain_all_pages(page_zone(page));
 		ret = take_page_off_buddy(page);
-- 
2.44.0


