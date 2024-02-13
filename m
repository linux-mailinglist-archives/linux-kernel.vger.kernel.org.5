Return-Path: <linux-kernel+bounces-62869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5E852711
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6031F23EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93932572;
	Tue, 13 Feb 2024 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kCU4LGwA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bH+48gdy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DE3224;
	Tue, 13 Feb 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788880; cv=fail; b=SWXJKwqNNLhuf26ArAyjpzz3dnj5v8fiGFXfTRaJWUYWbGN6iFtnv01jx5rjCmm+zUyYDshciWwueB4AihDSF96G28uTQNxvpAULgYyx2A7jdD77XbQ7U76swbwqRR4fdx7DZak9/TZ9QcG3kC7KtGtM6lP7vJoXZorRVyrf3zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788880; c=relaxed/simple;
	bh=k/O5mVKG6HTNhiLKE0mKfqcSXFPVn+sq83o7jH6UnPk=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=oi4h5EHBQCIwRUl03XaCNZbnd4lmB+tBndh2Nx9KpNhvK3UuDbq6AsTT8QQXZh6CZTJ9rnMkMVpGdEGj1U4smLonSRJNrImEXD8GKQ036TF8ubN3RZaTL7Jnh1nvrvfv8X2iI5KuQVCdPausf+O09eaJNNotA2aVSx57EHZZN8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kCU4LGwA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bH+48gdy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1hkhA012614;
	Tue, 13 Feb 2024 01:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=p7jMRYeKlh5ZAAe7w7rdKtiFgSGhpf6NiYVeLQj1jfk=;
 b=kCU4LGwAMJK8qrSeqwBiY5r3gigpQDHAMbvGwb6EmHT+wAICq/a7Z64Mk6QawbtjrP7T
 K9l8fFw82Q1PeyIA7qRKeTwKDFveDNHcOaODYeZZ6+jMobTHXy4NGouyRrFg3CF90/3J
 /6X8aHaZOa4EhPDRENwTkaJLTQqB3kSeJtavddB9UglXRSFSaM1Sd+Evfl/Rnq3Zkzpd
 Hcqvz88HLO5I+d22eMiCv4ndRsgsyj/QaaC6o2JqtBETIhpIrybKb+Y0VrvoPAQ7lPLz
 UdmaDuovHQ4qNcpqOKXZPcHK+t3zDsz8xnQBkguNNOsCbSZOOWsZw8NXsiTXwxjeXLVE nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7xysg078-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:47:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1Ypnh000604;
	Tue, 13 Feb 2024 01:47:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6mj3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOFugUWBJYPrC+AImFZGSGbmLp+vnnVm1XHIv8Vgxq2s7EiS9/RdilhZF45SJwa6RrjHmTkjybvEGROg2DywaoQjSnAxaHHmBCc6yG7FZUBJbLb6Bbtle04TiNMDN6Yc+NPm//eYu9IhajKZsp3tkln/FNz0mzjmjZYw+AuveLtJz0Xu7TVsZ02gxFyr7cg+N0y5V6j6PXM+TOyo9LgKCQLgI02jiXfj3Q1R6bdrV2RgmB1g81v7JYfZK5EoDqXCN+BdjvbKMuyMb0ki43yg2XCBk+HU+LDu6VzkMLXD9sjY5MOhvEe4s4haIgGiBQ3ZMMdUuyKeI0Fnlvw5fhc2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7jMRYeKlh5ZAAe7w7rdKtiFgSGhpf6NiYVeLQj1jfk=;
 b=QSShBsNVW5WjHlOo2fFIlimvWpIbzFO7UaTQ/pF3CyHyXJFfxcU1rUc3VhjmLgABA/IY4QcmIwHnbjvkVbpdvOoA/kAmHOpVAth5wXXQyNryUDIf1Qb7LK7lW/zALAPoHURA57QE/7m53zHoJiXmFyyeysl5RY+Ae5MBOMHS1px2AmLf6A/hMJfDwSnY3tIn6dFubdOLs2ILw6yxq52LexrTGVJ6y0I/iPKJqA2VUmpeQfrtMYvGuwWxsgS7RBbw3Ya/zIW/c3rxaJ+3LjG4qJAWEkj2Z2zFgyNlHFmlrKzvRQlJDBTOlQo3E3soAQByOUlXX72mM9dVoqjwjiQa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7jMRYeKlh5ZAAe7w7rdKtiFgSGhpf6NiYVeLQj1jfk=;
 b=bH+48gdy6T6wdTSDPEKUS5c27BXud3voCdskD6sM1cizLS2Zl5z8AwmVH+06R6QyFEO1t5ueRQduVyKjxDJHy4dLEqq0+SaNdnnK88DI/bb5RH6F1K+RvSPdxaXYkw3FE0zk6HyboqQkdcOIziFdR2zJ8Khlral1pJoOc3OmYRk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5176.namprd10.prod.outlook.com (2603:10b6:408:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 01:47:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 01:47:43 +0000
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] scsi: Make scsi_bus_type const
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mss5kudl.fsf@ca-mkp.ca.oracle.com>
References: <20240212-bus_cleanup-scsi2-v2-1-65004493ff09@marliere.net>
Date: Mon, 12 Feb 2024 20:47:41 -0500
In-Reply-To: <20240212-bus_cleanup-scsi2-v2-1-65004493ff09@marliere.net>
	(Ricardo B. Marliere's message of "Mon, 12 Feb 2024 15:38:37 -0300")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: cb40cdd2-f322-41da-9ca0-08dc2c35c54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	syNnHHgRUoUDVd0TMvt7mTQ0ePPiW9hI2hrr3kw2OTNoyadt1Ke6JHbbHBQUHuDiMqhXT/f1W4Q92Ve1auFnzGURi/25y+sqCYdYhQtXq+pR9WBIRXXehfiWvyoFS5ku/6uN4hhe5WD2kbBKl2UbOEVisn8RTnchnoYFgcGpkRgeSqJ5WjZojOustELcjW6SLew9Z7Gy2zVrAvSxu2aU6GcZ8mCl9Hw0ThxcK9bRfCW+L0T1ageB6awb6Ey3eDrHvMb+9c6LeK71mny+KSJGPgMAFdxG743bmEIV+3hY3wxFKaizgzOX3hO5PHUCxfNLV8gXBnP1VZGw5wnQE6gYYY2+X3KCIjk2/OmAJIx3gTKOWWu3s1LrOC1PrGtDCzUmKLi6wucy5OvG9wxO3ue//QFvhs5r1P+Z1XG+cNj/jJnHE0eyXSW03bjboc07cEVw7AtKmotpZ+8m856WyhBQEHrV2ezgBKZsAdT+sqbceXToT11QheCuhMGT1jY3wlDezcz5sVtPdkP2QpIqK0G0WOQVIMxPZFM9oDBKyvtgTPLskuSSRzNJ509JBovqQtHN
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(478600001)(26005)(66946007)(5660300002)(66476007)(66556008)(4326008)(6916009)(8676002)(8936002)(6512007)(36916002)(6506007)(6486002)(54906003)(316002)(86362001)(38100700002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DzBYbiy3OTbCn/WK3HdrDZ7nLOe13j1aPmtUYdQ+5TEXoK6GtgoYYZAH3d2n?=
 =?us-ascii?Q?5AlsVTL+FXM9AuTdiwIyt4TA1x4iBpf2joh8U1LItvNOrsaCvB9CD+wtYNMf?=
 =?us-ascii?Q?A//s9pVxnA/6wFyDS8bkBu0pbn/2J+onDkIDtoCebm5rovJ12Y/bVQxyXkON?=
 =?us-ascii?Q?M5s7uVc5Vo8eDBXBFzZvxacKj89W1YFUKErY7XwLtgW0UW59bPOpltwkN9yq?=
 =?us-ascii?Q?almKWl22tPAAXaju+yYQCc2pJVEKa7f/5kynvP9hEDWPWSEue7e135MxOqf7?=
 =?us-ascii?Q?S4qnUg6bMYp8xHEpQ8EN8bxmdXS1wlzvvvTc7tas5re+fvvdtWINAMber8cW?=
 =?us-ascii?Q?gO9xydWgLjaZ6fguc2+9ZB/kpQ+hW3qzaSSWDLro/0Pk031fKJpkDQq+2mV8?=
 =?us-ascii?Q?PKa7zgxmuIfpJsbzMgVqmFNAwW1Lz62m9E95czqXcq9VKzOONc8Rcv2JVyXX?=
 =?us-ascii?Q?RvSpBJvTouLw12VPMvnliuhILQ0Lm7VMdcvaW/AREiceRCPqSwG0s7DhLBiD?=
 =?us-ascii?Q?8zXq8vBBdFnAisUfwNRbDWwGJJSCUVj/C8xTyLcxiJcDFA73/XoTMfmytrYI?=
 =?us-ascii?Q?JTmg1C52sO9aXkhQ4l8bkyjYGi4+wqblVZ9zgEdN1YpFiRnSkANiRT8Bie42?=
 =?us-ascii?Q?FuPq6mBXzaMHzuIzLyOuabA1urLByNWqspULxQthYVR0XTKUrZsogzJ3jJO5?=
 =?us-ascii?Q?WNc6aEveQkjB5ARzg0vYJNM8H+KIi6xWWp+yx2dY2g0qg6VJW5aWwKGI2B8C?=
 =?us-ascii?Q?T20QELZeGCCbpTwTjo4HMzAAji3poVANhoqd9IjORXMZCLWrmIYHlM1+mhYg?=
 =?us-ascii?Q?8g+E/aBOsttfoQNCVdUZHHO5GHtH8n4uoakrv/U0KKyvQyKboIkLDdGw94d0?=
 =?us-ascii?Q?NwO0Nfwbbo+KgrPX8Dx962TNfO0tZdNRhhEvjPCtJ6DWAOhEZt5Lqv1J1psM?=
 =?us-ascii?Q?TOF4GAPmJ6QqUsJPqwesTSxMGE/s5VxvvN8A4Q88rTSjC6baWQebExo+y9Qu?=
 =?us-ascii?Q?5/oTBMm4fGkXnyr+7rEn6JZgbVpQm1WFVPFDXeS/v04owQmY2kCz/KzfqC/L?=
 =?us-ascii?Q?1JCwYCwnL86h3JMQ5ZW0hbjkE46FuGZaqhRNOWxG024BiPvQpV8Q9957MKPW?=
 =?us-ascii?Q?Vmle+GOOZKPwmHpfpUluP2y4WssQcjggptWvx6sf1ggZ+0JvDUvQsVdVnQks?=
 =?us-ascii?Q?E5Wm5p2Ucp5uB3x6Im7znghEdHdTLPtKR9nhTVwjVXUGGF5O/RxsZkH1yu5d?=
 =?us-ascii?Q?p8WSCiUqj7lW2mSx8Dq3XZ7mwKif06pkkyI+9fwPIHtHO2W7PHYoIiMM1Daa?=
 =?us-ascii?Q?lm9vNkEXaGyZBsmdi96toM284coTOqt9B25SiQ95WVtLrWZfPKZaBY4GJLJm?=
 =?us-ascii?Q?64nQgYNGYMgGdY55v1BdntVyeNAzYAwR1pOFKwqOH+AOMWNjyxj8RWKjlwX2?=
 =?us-ascii?Q?yJy5w+4ELT63UKmox+p8ZxNmsjz8gEvSlLXKBUqpmpn7wizUsTkR8JMu16Jr?=
 =?us-ascii?Q?Sg0VZVSdqX7uEw/VniVxeQ1hPIoHfPVVbkKseogoxqj/pT73f197RFx4LD/5?=
 =?us-ascii?Q?gPWqrwHxTwIM2f+BxrP5HjiL+//RnYtXiflOg4d+4nRxoMY7aJLLL4q5q8s3?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2EFDwsUv5hpy6U9ByEQW8d0cRcueUcW22PBrvwXqNvpqLGC1pK0evQ9AcatCvbvmX8sF6nItGQ5W2eH1K8GbHMTCPh8TiKxGLqtzwkNyVBGYQBC8K7wErW9E390nwhgZyxZmetJoZ94EBvOh1HIrIvyO9B570PRWs+AiaVYdJO058Dl3jfaAOh5SahAQ8UziCnj+hf2FS3+WcglxkLrXBRbf2es8B5voGtHKU25R2qpYimxj1FheSmRkoLA0ovP4lCypsbwehf0acv+6EjEP35EqeplQNPUKFFwlxSxuZMeXe+nWgY+zx75ZZeUrml/YlAs24iCo1Kevy15PmBosclIfKCOWCzQfZUGj3+HvWqr2vFjSegngm/r6rqQXK6Kdh5Y1xFRy9ZN3CfASgXcd6lMA0A0dlGqIxlqslixXVgkf4aTs7QE39xLqu9imLdDar/6eT8QFchYgfN2Y/TYli+2Q5Xsd4cjjrMCNtyY3WJa/ES18YeNCAVFEcQ4ffyLPbjKArySKG6IRp0taV9UIGGVqg9rU0kc3pL6oJR+ptpQvFOd4phNpLspXNUw1NqkFuiZiDeu8+2XHPU8buVbdVLR8P17zIT+1ViA+X+J07Y0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb40cdd2-f322-41da-9ca0-08dc2c35c54a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 01:47:43.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJ0UaUTaf+gtvf4BWOuNHvm/VTWE/Lz535TCex253Hbt7Vpcz7jolQ26eCttJVenL24Ehh+sCHxWrGe6W9KmTPaw8ohA5im+f9Qn9BvsOIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130010
X-Proofpoint-GUID: ubB-34p7_MF-0gWDiTkBIhMIqtZg1TM3
X-Proofpoint-ORIG-GUID: ubB-34p7_MF-0gWDiTkBIhMIqtZg1TM3


Ricardo,

> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the scsi_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

