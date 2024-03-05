Return-Path: <linux-kernel+bounces-92359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16234871F16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C7928519A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916755A7B5;
	Tue,  5 Mar 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nf/DmSCL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gCL/VjHU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83159B5E;
	Tue,  5 Mar 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641528; cv=fail; b=h+zpnEiRe1o/tHaOzOpiexmrKl4LptL+Q7WNbLZHArAdG4GCu7+be3IsM/HGHupPV/hlX5uMXJ+VG1FogKRIiKfnqhCgHH33mAxskIFt0Uz01xdmWUmHwvWOxBM9P7Sq3E9oqNWS6riQ/heSYWFwn+TjVweUktBvdZxt8mTqoQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641528; c=relaxed/simple;
	bh=7iIdsSOoZMxpUtexm/xuAq+gnfuh642xxnlJHB+o4FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+XiQVCU9VPfOc/fNkF4Tih5do77Y+8I3QIcImZ5VQTJFcWpQet1CQJunAUzzt7DegPKhZ2TJI074TUrwx3uDjOdMujmfv/XpxXrg3O7ZHeNwrS1pp1v6IyotgyHaBgmTSkvKG9ae7+PdjUNK5ufLLugi2MZ15jUzqicAN6ZVgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nf/DmSCL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gCL/VjHU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259jUx0013901;
	Tue, 5 Mar 2024 12:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=1V/+6TbOsqTR44lrvZ2byboEZcSMkQx4E88WgOPQ1kQ=;
 b=nf/DmSCLGhSd+If9+Wtz1RBPZP0ijb9IhGbY1EOeWEFnBWjGr3HcFdY/kb6WZ+DWyD7u
 gSrCaaTIQokDeYVa0w6TtMyyP4S+FJA0mJuKCHpJht+e1UABqeu50joe5J2kEujkf3ap
 MJZ+QC2T7DMtiN9u2gHjoihkQKrA1u2PD3X/6DLzqOQIJ/KJ9ZERzNruAQxsjveKbKIz
 4501q2PVYTRMfqvqlD7IfKarj6j7RzgGQFey/vbL8k6sMo3I/BNTvrzUoHfmBMidknVm
 IlX4bpPfYP/YHoqlgqIa2ozhVNsTIQ5F7Rr6FsintF1yl6vdkapQle9uERjKW53t+oi6 LA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnux2j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BWTxM031969;
	Tue, 5 Mar 2024 12:25:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7r6vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkXhT4OM0orfCFrSqxnvaijnUH7GbO63J9b8eqvKtZammrIIHtDvBgsol0kuREvEUUnigm2LAYp8OgMFcTsg61LibRONkMlwvFhq3xvJxRURsw8ssE0N38GfGGmfq5utAdegHpZ95aVCZBBmNjkqUJH82smjpke5qIAU/8m7CPnVhu4c0xmFwxn5BC4iHnEo8NCRNWq4u1RZubFZX4a4ga/1Vv41alN+I9zzqVxCL1+E3iEve1VTbhGqvHy3sxSXWsL8su7xlq4x1gXZM1cJpgvbTq3u2wQev8LksKgcsr99eZWXsGybBH0+dUBBznF+6d0aIiOOO9mJB3Que3zEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V/+6TbOsqTR44lrvZ2byboEZcSMkQx4E88WgOPQ1kQ=;
 b=JZeHolWjvJAX5eZoVESVxj1OmDM61dY+FfyqBjVuf7zaZqKK5iae4QosgLoIBV7HaeHGkphV4AKyZ/iLNfE9VX9/yJYdYasfe0syDsZ4Ry9vXQvkSfNw3pvomgxdEGXOGhvJ+OuQBRvZd58xZILWonjwvszE03i5Mkgs/A8SRA0QoSleU0e4tOa4pIY7xryBk2jDUVve9wGPV/9GPBSWpqxWlpAHVc8F2HuOpj0A9T+MkXljQJMHlUikyXSAUrtznIa/TP7aTOs85cxgjcn1tPDN9etG/BKlBnvi7iGhDBE547mnhBBRW8RLxJU54NeagMe/qkjFWG1pkb1Q9XSm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V/+6TbOsqTR44lrvZ2byboEZcSMkQx4E88WgOPQ1kQ=;
 b=gCL/VjHU84ckG77MyDszPZVGx2GDocr+ZdnFtugduDAVUfpYm/96x9Bn9bKuzZ5EWjRPwudiCHnbhu90j/kYSDNF9wFLJOU+h1ZjZQ6IGPQfIIPVn7HV1TF1cGII5eAsAMilEtBWNTcMWvXTbY3/ekSg0cqdCe1z1HYRMoiaIq0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 12:25:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 12:25:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/6] scsi: libsas: Add LIBSAS_SHT_BASE
Date: Tue,  5 Mar 2024 12:24:47 +0000
Message-Id: <20240305122452.340471-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240305122452.340471-1-john.g.garry@oracle.com>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ca406c-4705-4b18-9bf8-08dc3d0f4b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dnjHGOdd8SrLKBZT3OztSZkExWcOvs5jMfZK/fecFd/Ba08nGPwTG8ooIkBc9ZXLNpWSAdhSuTTfBfGD0sYT/EAn45Ojm/jejz45nsceqX2cXIbGzpq3/rc+T/FWN91FmOn7pi7FDlml5m9mgeQhQiHL7aJ0QEeHamKM/zXTp54NIzOB2U5+XcHxwh2HnvBqqSO4R2F7vSYzMc17MlyOifjECZ3zY8rQOaXvVUbIbTlFCJ1RTyOzl8kUV+j6pbbDgGYgcowcxq+X+JQ6xWcugeUNohCQMgICZTNuScRAkIuiP0l3OJvwlblpPzG4yBtyEG+788GzGmOIIqrcvM48YbUdjvY5rNyhkHFhC48RWdpF22F1k+LrhMzCrGegJAHAZOyk6wkZF+8m86mzA3iTggGkF86OPSUvWuVxMXcnG+oRfkDRmxsHnU/BSu3iJUoCSVR7usr35Y5168yrdpXg+z1c7gmrK/3ocxLS9B9jhia1O6psmKHZon+/GOXLji1QpPvlOPIR8+ON2zwoNIep4luWn9tif9xX7yVNdAWLsRRKDbFg35Jo5P2mC8kPknISCSwkWSauzk9xql+VZaypSBGT1zbwGezQBJmxXWdILnElLMUrS2IQ36tkQk9yF8MwNmejVgz80JJMzy2kOZIFPj8dDzgXp6hTn26T5RcWf5I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SkkvqHkn2nvWg0YMDEI8kxY/EZLmLeWYk8pJdR621r4D8Nf9ACixTCbeDban?=
 =?us-ascii?Q?+MvmjQoD475bT+97gttd6C3wg5V0pmBOJZjKlpoynGh11jMqwijYm1MHmkpb?=
 =?us-ascii?Q?xisaE8e+3mx7+hdOaB3nvnDsOKXuICzY9X028x4lYLXpn4zVWTaUQyupEIBv?=
 =?us-ascii?Q?2APkgvTdRIVbLP9hkLSvzh4/Na3kR4jlgz5kjY4MgIoekfYr3v3oyqk/pGZe?=
 =?us-ascii?Q?Oh/lKcdtrs+tXGoJbd5s9g2ETU42Gptw0nVsDjiYf44Sn2NwZqCkUBqmWjO3?=
 =?us-ascii?Q?Za0DCGLd8GkFjfMbUtZbGoX8xxsvbUjImcVK5FViABaafQNz+MnpE6uonP+q?=
 =?us-ascii?Q?Dl9qHVUWKbliYge0Tr0RWINMQObYpCrqcysLf7hNxjLRMESVYIAWPuyVy3Du?=
 =?us-ascii?Q?/pJzOxhlduM69+fiE5Nt/PmmYqX3nZeq5mxzfxLCC5iYH0raf/n9W1kiHTZO?=
 =?us-ascii?Q?42Q2Akq+zQovSN0c7WDFpAtIa35cz5oamFNXuzL0C1A2GUMVvtJtKWcBaK1N?=
 =?us-ascii?Q?pMrlQY5aSyr2/F8VhVdruZvElVBXoz+9mSDn6Khi4WV2vZIMBV39lodkpBG8?=
 =?us-ascii?Q?fXRLQTm679LYFm+Tjsyz8J5PsVigiBm1MeKsw6I84aoyi5BoA0vKtoTL4Y9J?=
 =?us-ascii?Q?T05p0bJmSFNKHbviKNQ0TgXFea+toLkuUphVjTmD5m/p43ShMiC98K4vYTc+?=
 =?us-ascii?Q?u8495NiCJfPuNEIKeTvRibJsVy97GOaZ4sVpN7oQ8fWludHoCB8IMf3mdEHM?=
 =?us-ascii?Q?TdNviIBcD8SJq7UJ/PRxF4F3fVQ/4cS8V3q0f5uKL7K5yZC0B7PFGZ7BiVyO?=
 =?us-ascii?Q?T4IDkXV/jSljHs4KcIm2mr+WBxnEyu2nx96vdH9MMGC1iJKv0TFO0/t5sAAi?=
 =?us-ascii?Q?l2MwvvFvqyTdjrRNOpCL8y9eZQnVqWJSSU6UwK8iW2gzJUiQ3kxXJoOhDcBK?=
 =?us-ascii?Q?Ix2tRyG11anq10olS1aQgrC6al0LM+OMFJxo2w3Lhy9LqdZTJxtDYR0lVGqH?=
 =?us-ascii?Q?cfkW0QLr/FD2vzmdY/PuRnP2yrEFrZlzMvDgIhUk4ndjmSY84Zh6MVS4O5fw?=
 =?us-ascii?Q?cki4QFgfqYE+KCDPYOAMXP10xnIMnDlw6IUErgtpl/IZwHaecY14uCzZTZMM?=
 =?us-ascii?Q?V6Nm3p/YvAvSJiI8i80I3JP0+YTsgiP6FZASBSgqQNkil+a4up2gxToGxeo6?=
 =?us-ascii?Q?/CkZvPUaN9JekRoMBTLc0UrpCC2ZQXWI8hd7G4IhUP1oRbLJaRiaF9qSmdW6?=
 =?us-ascii?Q?JPR8Me2zbEepFHlGk1R7md+XVUoaAqYCYf9nweVP/+HrCe/hBuBHT9xSASp7?=
 =?us-ascii?Q?wckcBMyl+OP3rjjZvMkEhKGc1uJzOOkY7fMl0//EWdj+MO73/tZX82BghwDs?=
 =?us-ascii?Q?RUShpWvjsyi8wQprz+kkmFX0rt2i3Z+o9NdrFQe8Hb3jrboZ1XJIWcajCIpD?=
 =?us-ascii?Q?4L1hdUe15Ixq/GSJsdMGt/zlOL5Qlrzj6hcRdj07V/Z2p3z7uCsh77mNeX8N?=
 =?us-ascii?Q?v5K7A2JmyFUnXV7zpIp3egphK3bSIewu0jOiKhnQPKSpKitZ/7Dh0tVx2TkM?=
 =?us-ascii?Q?3Y5QBH+U7wQ/TGXbqGHBjDvlciSzpdRmRzRdi1+OmIa3u0iEf2iR3vTel8xk?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	weeV+c61wLWxqyD2XIFLFQCwyyDdab0QQVCLHWWF+S/jYkVUIjSzyRc9IIijrQZ7/P2dAXT+DFQDkzSszMHITdIHy0rWz9FqIKt+sW4uDvyzpX1R95jXa4F/cWWXJXXskAMJ66V8xmNv0d3T7oHGhidixltXFMCt1xAMFz0WWIj50a8RxvBVK0rpslHR4gmQDx0YISC/ygf0Az7q+ej3Mcg/FXEvpa9Kpi1FIjIcdAGhfdpd7+Mk5dpIO05higQBlV5OrAKQLhH76eaR8AAQreCps4ftp7ZiHYOjb7UI1TVJDrnkz/k81+2k3MnbT6hKkdXGgMCBcWNSejGpeeP6KbfXp5uL7A62fSy01FEb1O0nLmojStDlSdYHHooVi0Lx4w/X9FYtnnrDM9eYXzEenvsCIqXpXnsVVQ8+QNiXoCj6wncJsyN4UZfCBJQA6L9/kqudxswN7CiZUgcGFhr8vS5pg2PHtO+XbTnpWjfGv3Ya3QS32niGuhMVT6ubSup11+vUb/6/FpBfUD4tIGlugHjCgENErOIVlS64xTUrCPW6Vp8lKOXx2zpbxiE5eSWotNFPYPig8bp8JtpmvsTTLHGzOsXxNHIMzRiI/70ulAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ca406c-4705-4b18-9bf8-08dc3d0f4b99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 12:25:08.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZMSLIfHtpDFk9735VlzKPt1Mk62/imdqf/lUCnqScc4Lj4P4kXKBap3sTW6bAXjr/pjR5JBPK3lt8N/FCSLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050099
X-Proofpoint-ORIG-GUID: 9aH9hmdqXJ9JbuOHDPzLvyzAFVCnN9eU
X-Proofpoint-GUID: 9aH9hmdqXJ9JbuOHDPzLvyzAFVCnN9eU

There is much duplication in the scsi_host_template structure for the
drivers which use libsas.

Similar to how a standard template is used in libata with __ATA_BASE_SHT,
create a standard template in LIBSAS_SHT_BASE.

Don't set a default for max_sectors at SCSI_DEFAULT_MAX_SECTORS, as
scsi_host_alloc() will default to this value automatically.

Even though some drivers don't set proc_name, it won't make much difference
to set as DRV_NAME.

Also add LIBSAS_SHT_BASE_NO_SLAVE_INIT for the hisi_sas drivers which have
custom .slave_alloc and .slave_configure methods.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/scsi/libsas.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index f5257103fdb6..484cab72e711 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -726,4 +726,34 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 			   gfp_t gfp_flags);
 
+#define __LIBSAS_SHT_BASE						\
+	.module				= THIS_MODULE,			\
+	.name				= DRV_NAME,			\
+	.proc_name			= DRV_NAME,			\
+	.queuecommand			= sas_queuecommand,		\
+	.dma_need_drain			= ata_scsi_dma_need_drain,	\
+	.target_alloc			= sas_target_alloc,		\
+	.change_queue_depth		= sas_change_queue_depth,	\
+	.bios_param			= sas_bios_param,		\
+	.this_id			= -1,				\
+	.eh_abort_handler		= sas_eh_abort_handler,		\
+	.eh_device_reset_handler	= sas_eh_device_reset_handler, 	\
+	.eh_target_reset_handler	= sas_eh_target_reset_handler,	\
+	.target_destroy			= sas_target_destroy,		\
+	.ioctl				= sas_ioctl,			\
+
+#ifdef CONFIG_COMPAT
+#define  _LIBSAS_SHT_BASE		__LIBSAS_SHT_BASE		\
+	.compat_ioctl			= sas_ioctl,
+#else
+#define  _LIBSAS_SHT_BASE		__LIBSAS_SHT_BASE
+#endif
+
+#define LIBSAS_SHT_BASE			_LIBSAS_SHT_BASE		\
+	.slave_configure		= sas_slave_configure,		\
+	.slave_alloc			= sas_slave_alloc,		\
+
+#define LIBSAS_SHT_BASE_NO_SLAVE_INIT	_LIBSAS_SHT_BASE
+
+
 #endif /* _SASLIB_H_ */
-- 
2.31.1


