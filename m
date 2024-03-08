Return-Path: <linux-kernel+bounces-96952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD7876387
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B82BB226C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DC57887;
	Fri,  8 Mar 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aRXYSUsm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pn9Pi0PY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659E5645F;
	Fri,  8 Mar 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898266; cv=fail; b=P3to5CONayNVGEwNaNi7RsnR+U/d+xL+7TvrOsdn6QQ8nnwQvz9o0RN1PM0aiy31TDl0Rpbck0Ry+AWY+EnPpV4GRQFU2eX4gfPI6FO7zreDzuykszTQZVAVN9U9Kq+mRTpfhLFJN39vHEIXJJr8xP0sHcCl5os8BF0Sx8praUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898266; c=relaxed/simple;
	bh=Mn7haAzKKfAZjIPTHEo0EIkRvdrVspd3rsTOIH6gMl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEgOXz2/YBV+da0mceuk8iq/frgQByVOQz+6eI4uxx/19f5od+Xk+BbwO/JpOwGz4vqQXfU3fSIpEA+HbAnvU4NnFqkuKMwiQNAsYY0Cx7d/v3ogK0+aay+7MWIKMSrEmsAbMjKA/Ci6kBe8+SKyXVYVSphCkAobc96THY879K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aRXYSUsm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pn9Pi0PY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Ai6tP004106;
	Fri, 8 Mar 2024 11:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=zCB9SnIPFqlFB8gn9sUu/crftB8liZFJpGp0S4c0LU8=;
 b=aRXYSUsmRTflG18+ECSsWGNdAtSsy3nqAdzZO3ZIAhheQUGGFdR3L4zsjjSmkWzxoy1y
 ZuaxcT9mppz6Gr+Qg9bRihTo8dj9cgGOXRBAqK9I7+qtg7wQwz+GrqSY97hjCvxl2CrJ
 uzAwlRdD3jLUPTdZ6AJEoaYRi34rWeOrzOhbiiuD62eduOKIrBUJxCzlekg5GrgAFAaL
 gF1RmlyHi+G0mOX6aYwvIC3Sviqu/1UCJKPmf/JJN+BfDTnnA0rbaP284eYQO8TTO/Wi
 VSubGZnrjU/k/0s059m2XP0VHiuVxeQDKJfoZ0gB73aADmqVX7UV2G1ZzvzlmJ+Gx+sc mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthepkpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:44:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428BXYui005323;
	Fri, 8 Mar 2024 11:43:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7nv71s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMVM4oiYNulAu64C6KMjEpJEoD5PsOBHER3YhMfrmqXkP38+trhY1md0hHQ6rxiR/RzD/4wcDApoS8gVYyv4hVAtmBBFHHEYT2euCBaeg4CaLJGb1MuxvlK7k7VSyvKRBG/MjyVyRSM4VVU1x3ksTN635Kttdqv3bVKhEr7LTn5c/LMPQQdpyJ+FyVaZcgbhLfk4MBGo0SMBAKg+F1BSkhBqcH31ZHSbsLY0/FanzRktUPPZmEESbR/p5eqC+y+3ijsRKOd20hR/V8IhgLx9tBJyV9/HFjVxLuSsf1JNqOtrGYtVRYzenbw1Vk9r9MMdHQa8hilGepmrwP9cxbAiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCB9SnIPFqlFB8gn9sUu/crftB8liZFJpGp0S4c0LU8=;
 b=V/sIOZlqmZ6JmZezFGqi7siFdW1ZaRhStiHZ/rwEH2q0XcfZ+BnRi7B5jTOhBCk5pLz8vkomHcHQkLxNKdldQyXB9r2S30kWLXv1zBK8Czsvqpln5C+zKQIpKHHs7z8uUEu1eIbON9nd+QSjXas1PJcjMFO/UTXL1jjV+/JJ95/RTQFdssDuekGeLZltB1sCQzXH8Gq6hWKUC+kvfb7t2cJMMkHwuSFm9T49/2aStHp2R+jn6Eqt+TcRFCr+k6TFHU7IY6fAYyUzUew17OzQwwcFyQ9nm+MFvRR7aZta6A8L8DYLUGrInDIboo63/30gSWhzfhxYj8fBiUlV5ZZ8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCB9SnIPFqlFB8gn9sUu/crftB8liZFJpGp0S4c0LU8=;
 b=pn9Pi0PY0F8gUlQZ8dFnPgYoXuAEAr+2LwcG37/Yn4NQkHbVdmBhgfVQRSvs4DOSE8mK1hvcfOkZVXVnRwz5L3r5pto6u1k5xn6tqFvdEUH+U9/GkLbhXmw+OAcwGIeRC2B/g00F5wXu6+fy/1dEVwgaxq1huBnZXkdmtQzkqR8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:43:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 11:43:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com,
        cassel@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 2/6] scsi: pm8001: Use LIBSAS_SHT_BASE
Date: Fri,  8 Mar 2024 11:43:35 +0000
Message-Id: <20240308114339.1340549-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240308114339.1340549-1-john.g.garry@oracle.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: a965f940-1eda-4169-9093-08dc3f6503c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OwdgNa7TAMeCk5odQvpNP38ULBiGYAEDeFoDK1L7ABb3SnqAxO5Vm90A1TP9u8lIHJdDk/tG3nnOqxANe2UAJa8HhKkvynlV3kSACryJT/A2XvqrvIeEHqDkVw78WEpR/O/dgKXVc4+/0iEvNQeRp701/Nch6s3t5wzTNP4FP93flxhy/d+TMX4SvwbXK8Ft9DV78nBVJHiEp6kzOu2hbK7b+CkCNvivHY22L4c324NvDtbNKdjrJm/ffG/Hk08JZ8nUQh5QOSd4XAd95po/eTS7q7UKq45v9E/lB6fLLYjYjb6YGcNpNw32OzF2Eijuv221bMpe/ehAy1xkRgI5ytiG1Dis4HIle6VB4TaWv5zs1R0WRTQZR7RapRIevlTqg3AvXuY8hJuHMvEL3tC/3d4MuCOGpni2+ypV1L505rY2c58Zcw/ZSrEIMD3SDithJuiSfkf/7bvjoeC1JBpjYogBBYvr60HxNhg5FGVlGYWgtL8/HagfOMMEoYfs4N+RiZYCKnIF/RmlqT/uGnfbKsZwDrXS72aJQfrZM3DApRDSgW0oTaHDuOGsD8JIuCt23QJ2doRjZCXtf7et5HJLGHAYM27w4JmqCkEIwrXMUb1fQds7gVmjjEmU+fF7d6FQgq0Y/SIFJQRKWnX4GsFA/WSjSyqVvy/EpJK2SwujJeY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cAZPqdlBrEbE0Gz5tnfC01+w6SMWVl0fzVc1jlfFo0KnykFdo0Tt21t3w2E7?=
 =?us-ascii?Q?k2SC0bWp/YXahiz2i+5jKYmPmNQYEHdw9TQ4mYoDMiRv0z1IOhGT1FwgY3CG?=
 =?us-ascii?Q?Ry2RGJj1khx/E79wwoRxDtbSuRrZ6cdgsLh7XfFFhNHvpLCz9yScj0j76yEh?=
 =?us-ascii?Q?REqL4FEIGytGrZjlZPXP5c7KOIUrISsnaqT4QRT6qN3jkGe2ezO9WqM+uGGc?=
 =?us-ascii?Q?9WA2jZ8/7WnOMGqcWB9jAm3yzl4YM67oFEqCbXAUyNC/+NtKuPEjxetCVFyp?=
 =?us-ascii?Q?0FCkNExigdjKwX9nmxViC3Xj8V9Q+I0y3HTU1TbGrwM3ceAvquFUhLb/F2nW?=
 =?us-ascii?Q?xjLkHmvDdWBqm+AHjX3IrVzWNJzd5WL2r1Tn7BFmSSqv/ACLFr94RJGE3gcf?=
 =?us-ascii?Q?31MBz0+adYugU8aysJfLjel2nfMRBV2xak46l92grAFZDL6APGsGLBs0w9nX?=
 =?us-ascii?Q?+UqECEmpW7jg7J6NYo0IynP6mnvhxuUPS+4plQn8lnP+BmpnSfHPcJBbeP8R?=
 =?us-ascii?Q?Z8rxStpnx+KaGHMsdjAakbPGTAoDmG9RnbaK6i/15MU6o791Yk9R3liUwAG4?=
 =?us-ascii?Q?UfTaw4lcQxppTfqFMDagLybfI9VG1ve4TRWGPDdSPHuEk6aj/K+gqDWJy73Z?=
 =?us-ascii?Q?iUY3GFt+dbneFkFPTJvrbQ51o7KZmPC8F4TbqTt+Z17/SJ9hSchScJevLQPP?=
 =?us-ascii?Q?MJYiCD3D9T5+tYhkCnlxnbQlXsO27JwHQAaBlw+WKePbO7D0+3Y+p1R5yc80?=
 =?us-ascii?Q?RmdCumpWAL3kz/kIXwm8DzJRaXWdbf1I/CAnjkIHZsEBpn5Sb0/B+u39mmQ+?=
 =?us-ascii?Q?fHCYulg7KEWGVisoWrkSY2pGl4GT1CV+Nh1ylQpvvS1YqRjcaDtJ/qef49qb?=
 =?us-ascii?Q?9mlAK/F64e/xuqu34D0xb50F9IQsaFciEVdgrYB8JEwUFlZyjJ1SHYE8briT?=
 =?us-ascii?Q?V2nXqEXFCMtyobISb522ptX3WXfj4P+Mwd8vEo6IN+EGpQ8+5ce4phwjoZm3?=
 =?us-ascii?Q?afmzjGeBl7D6N8gc3CtJKy+B37/L/kL+1ANuwIFEjQJH+u/NDwUUSs8ughGZ?=
 =?us-ascii?Q?T7z6AB4jBuJpRK0xjMbGCzm/Hx2wZeD8ksPw+WtKO0IhZEgKiZd1kNzWJ3gi?=
 =?us-ascii?Q?5ylITey4aOlmRxsXJpqMwc92yLlxHMhEZA1qYYqUakOjfzpJAYBHnpAt3Nz2?=
 =?us-ascii?Q?UD9pcqEDgfh+/UiKhWISO80xNvd0fO1Y249/PVA/e87BvAnl9LSzmPlts+d+?=
 =?us-ascii?Q?Sx0YWZrFfR0XY0Ubkz92mdV8EEq2UaoUJIpfRZiM9eJPq+eVqWPJmVIAarBh?=
 =?us-ascii?Q?g1/i1lstz1mQoY51Jaooe10VBvAAC5qSuBSlMgZaFi+NJOVPgYuPfSW4wEg2?=
 =?us-ascii?Q?+OfnsSoRA88HTr2WM4oHJRXm1eu5G5Oxzno4scySl2h2NasA/ypJaDVHcmBf?=
 =?us-ascii?Q?vnidjvIlUB2ap41seSJx4bNlbeizjpQ/1cLg+543o9g2Bkp9acLVmfV37z0U?=
 =?us-ascii?Q?BViv6o7Tm5zJ6EpHdWuN14Duu625WWnUU9phKIzUdMGteGS1v1RTLFXJYsgE?=
 =?us-ascii?Q?l4g954G9c55yKMq0l77xpzFxOi62KikC+QtU5xPkpBco+Hr6NphHA4+bZEuB?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kfWIs8CTA2zzQ3bzMRXtNTJa+MweDieoQ8wABYImbZeBYrBdQyqzQ1RCGGqwTlMXb8WVj/DWbLfb30G+BfPadZbgy8GkorhOogArCoOQAMNJtdz1KiTLSVnj8IfJ0QJxGi79eFzwzJOmW4zmJG/+mfs260+pZsNyrsOF7DYzT0d+mL9eBben17Ugr2Wnq7h9x06L+1EoBuPTKXCYM0NKciJciwjw5Uz+DNrE/WTcHJKrUadtWFGx95HHZYQIQ6nLC2IlQQlRNSJe6PWI5jJ4V1+tkYrNTjKuKM73RrYSMR3DmEmCoH1m0j3O1Tm5tIw45HY+wM4NyZDr6KRcT/W7LnEaBrmyYn2im7OOgwdV3iFqHnWRA2BscXO0MYBiYdDwEliuY7qCqXBVVuOVZYo1Spgo3HPbNJXNKT5lxmHRDKgah6JI2x2KeJs/jiNn9YIsIdNp9NNXRIwNr5myBCPJuooE5sdQGf8JsIOE9JrwmOFYqsz/hb76nbCNGCsFqdrYaYUru5SyDy8HnF8AT8X0oHmJDVSoJQEglfTrI7f1Iqlt1H0leEfXwQma+r/zZUP8wyJNzjvkHBEFu39hl8JhNguRneukcFsleWrDAEmQI2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a965f940-1eda-4169-9093-08dc3f6503c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:43:46.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YblnZNqNolpVufhT6M0rZmA2Ik5rlzppZFphbSq6ZDMII3vLayqqHgT9KsM2GoQTRT/3pa2FPEqLLrIAXkI8Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080093
X-Proofpoint-ORIG-GUID: k75YAIM2QrPUAuoNA04Rv57wIcRTmfgH
X-Proofpoint-GUID: k75YAIM2QrPUAuoNA04Rv57wIcRTmfgH

Use standard template for scsi_host_template structure to reduce
duplication.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index ed6b7d954dda..2ba320ff0d50 100644
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
 	.track_queue_depth	= 1,
 	.cmd_per_lun		= 32,
-- 
2.31.1


