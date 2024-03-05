Return-Path: <linux-kernel+bounces-92362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A27871F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A78B241C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670B5BAE7;
	Tue,  5 Mar 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uc5lk9GL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mwrAZ+9j"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D925B685;
	Tue,  5 Mar 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641534; cv=fail; b=ETlWpA+pFGIJ30wHOAdv1qumE7IOVAE6nvG/FjSFwWEJu7j4dse9Rzl1rQ36z2oMieeePYIj7YPdAy8YbioGKdKzmk6k8NYGghNxldAVbR7QY+N/IfYsqG5ni4FAAjZgFWLm0WGeq3jjrGH/UJdK2nFfYPB2nj8YjOx7EH9cf1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641534; c=relaxed/simple;
	bh=oZ/cykRJ3Hly/QV6bi2WNl3jxVCztA1z1EGYhTefx14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tVexaBa6Z5yr/27Wg5lInDMkNKXYqnBLf3104GFxNlwSSSRkDblNqtClzC5GXCGDOF6YjxSmIS5Tu4Z+vNv3FHiqSfuBDUCr3yVziE41UlavXd7s3dsV2uv+oXZoIexu7XGCs3ZRjOXeexBtcljhcgQDhMxPUro/em13lwicqf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uc5lk9GL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mwrAZ+9j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259hoRn008892;
	Tue, 5 Mar 2024 12:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=W6EBPqEftPR9DbU0+roOgyUYY3hUDOoU2mBkNWKb6o8=;
 b=Uc5lk9GLttwOQonXItfUsuo2NAOnz9I/+HGKt52X/D4gbpIC27r+/6MvriQkGQnYUk4P
 f81YICx1RiAY0QapBMuEr/IyL1sGOkPEMA9t6lkfT4Ixue8yze8NcCUhu1WUJ0ZWE6sq
 VCw18SuHiUjrhz2eQaUBB6yu4IesS7hP3E9EW1GL/cBKEQEWjLYSNdr9XV/3DqLahXqI
 RpoMpYOEIUjqS1O+BddunF5hi4rkYJSItWCn8/1a5BSiKKmu48KfMSFE/Oe0ef47RIvt
 ChEZJ/aLPLW6GyyxT+qHRBBNsO9QoC5S0wwYK8PlJpgZMR+OMBIF4/g7LqmfDACT1CWp Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw46083-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BXZnw012375;
	Tue, 5 Mar 2024 12:25:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7frwy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxnZxzijFHVmOBQ1HjlMzzF9ZvNbBg+0bgf5cTVUZQCVbW3wmmHv//j8O8ycc5/OUQC5Yis9L1pyaU9qcfeZQiazFp3cLjO+apMd6cxTHW565qI7/E+AAVjZ0e1oL4PHrxNpHEKym2vNvnFWDUM0Zg8hbx0juEZYdAvnARqAZ7oO2bBH6PzqbWDxGx2QeOIRDV9anAN8JY6bQQ6bpFi+bOcg0fPjWQxplabfgnb4M9QqnZwoTb/jh937d8bBwQtK8leME+Gb9Pt3zzuH61/udL88/FSs4MO1GzLpJYlypbtVz+HXoG5jtJOaFCPysQbODe/dBGUIBoYEM8ZXkjXWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6EBPqEftPR9DbU0+roOgyUYY3hUDOoU2mBkNWKb6o8=;
 b=BK0lDebR8Ht4saounH3NeXA/vtvhclTbpMYM9vqkD9gUMTaTh8CR/e6pPa6HdxMU5KrD2RMVPEHJF3DEBL+qeDE86jDP3k3TiAQ7jptlS8tAvq89oosYkYdFTVyvZ7RoKTwhBmewKnJ2zGVkx/XHmrmx09eC/yVD8DdvmBZ+Xz1OivZFHswJSpBMcYLHoZCOaph7k7ueLXyIHc25slxyq1AhiLML4vh2SwPIqtyPiAQE8stiOLw/c17v2TC1bDpGmG0BDQ3OjWaVOeMFnzTeUNo5zrnHQlCypQPpWvJjcdFHGZ2P51AuPti8eRMIr5hHBT9y6YFjM9Bs0e6ib29/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6EBPqEftPR9DbU0+roOgyUYY3hUDOoU2mBkNWKb6o8=;
 b=mwrAZ+9jN67HoDAg2zPtccvCg9UiiwKAcX1sV6E7TnSAHu99rgERDjs+CWoq728bulnBKXJbYcQc22avQksL4msKriBUOQg5irEr/rwP+Ngyxd3kLlnDIz+ZVg/5UaI1F87ZgucdwhrL6ru9UgXsW0j+MI3MX2JmXXSeCahoKc0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 12:25:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 12:25:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/6] scsi: aic94xx: Use LIBSAS_SHT_BASE
Date: Tue,  5 Mar 2024 12:24:50 +0000
Message-Id: <20240305122452.340471-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240305122452.340471-1-john.g.garry@oracle.com>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:208:d4::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: e76edef1-4a62-4bc5-8368-08dc3d0f502e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Kdd1jgmVMhsnp5K5AsgUcwOJ6NqfOkdvt8x65eD5n1leeOxqG4wNYULdpb5J/kM30wgc2GkT5VeINkVvX/KJjGUF/DmrRKvw4CNWKI9h4s4dqtBsKbB0P2SurrGjr3O5ThFE1hIytdBPmMs6sBpPSxT1e7vH+CuHeIhY6dukwZ6+u5W/+pZWTgiE3JQXKjYapqu3Cp5pYNMHeILauU9SZSBVEAhOo6rMRq8KPZlsTPfJzdaDWnhQCoQJ6iByciFSVNGmPMVyoxLtvLTUaaffu/iToEK6dW5bh0ue3nO/K7SmmCUXL3Rs8cmi7mZWXqZgzwWDmTzcXgDL5Wt7RmHMfj6iN/1eGRVxN+FunLDKEcz1tIFjdMMyODiAcBWACZPqoVcxvRbAgfJbHiNhaEQFBlh4gSHxrF4UoYbsr94EEFxrvMQbkMYF53I4C+/LBWQGQim7xRcHu/lADcTbSbpKkztwUqnBY2YKMgm3h1hunmeHGCDXO2pYiJPRsq03fNhXnEaiyRh/P8j08QhuDB15a9wPbxbb4XtQxaCsvjjf7jdDMBgyYdELKpmdh9RLMu/r0gikcvC0CpMbjgobAFUdGRBJCRTpqGAuWmhUELEKpppQZI6I6n/vIx/qJAreD9264qJ4+aRn5Yd1qZaB7F4pQ3uN2mr+I9mvGZFxcqoTaag=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kT3EP5Mv9mYmXs/P8pL6uSeIOlAPQo/whv6yVcBIDUqVzf09/rTvsVBAMhHK?=
 =?us-ascii?Q?RfDpFjhrIiwkGEaHbJI2Mtbrk5qf3xGHD8c8RYNZrxzPjooP3F6L0e0b2FNJ?=
 =?us-ascii?Q?VuzmljthI1vLxMq67XoFfk5d+LskdzIoF4INR2+pHg8wrfQsG9ZdMplCulTS?=
 =?us-ascii?Q?GaZ9gHPVqVfDzZ0q7NgjXeSzq6GndoDsnZPM0b6GCb8XKKSh52YMwsLMJK+E?=
 =?us-ascii?Q?d+Rgi34KSaUZROS5bxiumkH5f7a+OMmluXP5uGwow+4EBYRooQXCAcO9dFa0?=
 =?us-ascii?Q?652TNq0eGdd4q07KthmfeX5gQf0Mm/idrJS+w8S2UlSMr9WhNgRUdgjeoy2B?=
 =?us-ascii?Q?lH8sKEfhhEYT57p6Avcvo7/j+PebMKkq8xV50geM9zHxFi3lGTAzy938VDmk?=
 =?us-ascii?Q?ThXnW7CY6jTlSrpcSJd21W/HoGWhs50s/06t2f3bj7tqgbeXLs9MXH9lBf4V?=
 =?us-ascii?Q?v9i4ZBajXIMKVFp0H9xqGjtKy7ohaIqkXVfupDkDsyY2PH4ztb71KC4d+0/o?=
 =?us-ascii?Q?Ke8glBKdRuDbWBb6Nd+AMbnCyv6YhJbMUntDKZNTZo3+zk8uMBEHQp0FKQvs?=
 =?us-ascii?Q?gHt8PkcB8eXPjqrDiNqO0f4u4Scr54Nydo0KS6n4jEslTYhlprlHTG2KA7U3?=
 =?us-ascii?Q?5iBT6DCin64G2e9Dso3mcHjGH79v5/ATTBzuu3XXyXNjoROLogrPI3OYWvXu?=
 =?us-ascii?Q?Z3Ay7dUTHK7gw6qNb+kScmsmGXGpt6j0Jh8fcINk1e1l+blkz7MDHi1lScpB?=
 =?us-ascii?Q?HeSytrYhNhjcMMM2qtWLFcvd5LpBLvLiPa/5qc+QyjlqevOOiRwGseQAmZWW?=
 =?us-ascii?Q?d811Ilkr4tPKXLliTelTa3lMaMy7FLRVgROTzIcMJRszmTzCVRoSrLye5epD?=
 =?us-ascii?Q?Ntx9LPHuf6VfLweoG2ooGkgybALVspocwzpCmxHhE3VoCD8KFZDHNfFgcHyn?=
 =?us-ascii?Q?vnhiMfHk0c8EdH9iMOr7iT9SoAph3IRwKqabexvvqhN5W6DiVddmDeMeWDL+?=
 =?us-ascii?Q?xR3etadp4U6Pz44+XwAWNSXKiL7XYFlt8vz3k1d/I9LdCPgKnjHDYKljXlO+?=
 =?us-ascii?Q?g2esgo674/nLv1B6EqZIi2rHIgCjDIzzwVihhNabCapm0OICcYbCyeS/pP5L?=
 =?us-ascii?Q?20QEwto8ukBO72/FXQkDcykpCrzeS69PHca4RPMCpy8MkxScVZA0UDG5Imuf?=
 =?us-ascii?Q?LXioKm03IJv4L+DOPtMp8Cvo3azhRdFVVOcQ807kFdpJ6/GFfDnsP9OA17pE?=
 =?us-ascii?Q?HhwhSHA5DhJL1E0mQ3n6R7UkMIhjWaGlI2W3Ea16HtE8LAQLqqJ1PKqoBy2f?=
 =?us-ascii?Q?SZ3lQtE8lXC2RXLu0J2Ylh0s11tpu5iHRjlffoTlcaGOBrJLm3+ucWmbj+ec?=
 =?us-ascii?Q?b2ekfXOH7cdvuLkOFaqV9iEHSiq06fDf5VsZoiQwvernKffOoPqBSwf68wRG?=
 =?us-ascii?Q?re8+FjD/HJyg/4ZwnXzk3zdd1iuIgI3wlwrjOpD1r2eg67Ui8Xs5v36wq7dN?=
 =?us-ascii?Q?6CZff7KGeIsv1+RqmRLw1odYbY2vrLuNi+ATNInnpH6J99VjmxLB8FyoF62x?=
 =?us-ascii?Q?C3GbMPqlNZvyMOlsWM7sb+O3vGlaG5vZWLG7YFVuWP58D0oez6ivCD4+LmKw?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JDOdC0KU04DTb8TbDJBCfodhc6W4oX+pME+sXTsWDB7D0CJHzVQpOocCs+p6s3xHV7+EAecjqBdJ5NMs3R+1A/fZVXQZRAxLYZpgLfAnu1DRoDtpn/qyFA5+czLsDrow/6qAw+E8GkoJDlCwyzOtGFjz3wznH/eEQIboeHGmcvXnEIuNxGcHatdnkK0A1vMksyvxPNREL0V5xlkNMCw8ZgmAcwiNF4X9Iya1bt29dqc04QnT7cz86KJy1p0IpWdpan+EFGlWWuBrI6H7Mr88QBChx5259p8F0ycpNsHmr9i91cPLCUWBfHdaYLSblZP4jUA0Y7QcknWJp4GYu3hHtTGyZKhtYdFF84jmJ6ZC+NiJ3nF3TbJ1VBRqFHIIccrVzFcDkPZ46CEfQ9wK7skri6zZE3IcF+nvfNCB7OX8zVPaNr/dOfCMQS52EAPUikShvO0g3dPT6u75iaA5mn70MrSFP1wRtSOpm4+fzCul2NhpWhzRDJFCaALoazxuQ/Buqs5yiua6GSqeTDth4oNMSnJ62Z2V1bRYyxdD7BG4KReWKWwlwYOk1olDC89Rdxew8RrFvWMEeid1XhU9/fOpV9WR/9fUX/IagMQiF/VUPCI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76edef1-4a62-4bc5-8368-08dc3d0f502e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 12:25:15.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PpgN7JiuBJbKlkAE3TWheqlmnxzNROqagzF97AmcGvGGiS1UxH4yuGdYCeYqVLp8v4pPmb+F9tvmwA3HJPpRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050099
X-Proofpoint-ORIG-GUID: RYeoyrUh_PwjvzDI_6-r6I71y_ikIUgL
X-Proofpoint-GUID: RYeoyrUh_PwjvzDI_6-r6I71y_ikIUgL

Use standard template for scsi_host_template structure to reduce
duplication.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index ccccd0eb6275..538a5867e8ab 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -25,6 +25,7 @@
 
 /* The format is "version.release.patchlevel" */
 #define ASD_DRIVER_VERSION "1.0.3"
+#define DRV_NAME "aic94xx"
 
 static int use_msi = 0;
 module_param_named(use_msi, use_msi, int, S_IRUGO);
@@ -38,29 +39,11 @@ static void asd_scan_start(struct Scsi_Host *);
 static const struct attribute_group *asd_sdev_groups[];
 
 static const struct scsi_host_template aic94xx_sht = {
-	.module			= THIS_MODULE,
-	/* .name is initialized */
-	.name			= "aic94xx",
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
-	.slave_configure	= sas_slave_configure,
+	LIBSAS_SHT_BASE
 	.scan_finished		= asd_scan_finished,
 	.scan_start		= asd_scan_start,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
 	.can_queue		= 1,
-	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler	= sas_eh_device_reset_handler,
-	.eh_target_reset_handler	= sas_eh_target_reset_handler,
-	.slave_alloc		= sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.track_queue_depth	= 1,
 	.sdev_groups		= asd_sdev_groups,
 };
-- 
2.31.1


