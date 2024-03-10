Return-Path: <linux-kernel+bounces-98336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82909877891
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FE62818D3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4C3A8C3;
	Sun, 10 Mar 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PK6uFGEl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LTISx1Fw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333D1170B;
	Sun, 10 Mar 2024 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710105168; cv=fail; b=oabh+rS4ppVW50fF9gYQE0RPDZtQDeN0Gt4dDjLsQ8neIZwc7IO/PtekECcoeTQn/yM2/4PS/SG9jnEp8LgGUg7xCMjVDeRV2TNR3DFO+AkOu9R6IYMuezrITgg9L+vKZrJc7Y17phfuwgZwlDIC26lBRqKvwVk50yvKMksmrmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710105168; c=relaxed/simple;
	bh=tQjIAAHMoxnFh6Dl437XOVkjkvrJxlZwrD9T+0USVoM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=T/3G8xktU1v6uoMN7+PHUPvV7hSW91OlY7GxQiHEczh71CwyvWKjAtIf4jpWgoUqPcgo2nclJ86XJA5eQXwIU02uEIkvwuciW/3/q5iKz1cDZMktlCTSkSiXLdI0/SrwYDo+P6Lz1z8F5K67IWegvvB8ItBLx4ArziRONlt+NPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PK6uFGEl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LTISx1Fw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42AL1Pm2030905;
	Sun, 10 Mar 2024 21:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=+wNrBZbCP9lhh9HVXbBJJwRCYk4+sSNOt0wZpiHvMtE=;
 b=PK6uFGElePv+Y0iTLfRQn0bMGMoxA/uPBRshzjI4NBxjES0PRf1YepkuDpXxF6Frk8vw
 dkOY/jqwZYXbQCf8cOMPuSPrFvvndxREXZpYZFIxETnC3ApTxjP86AyNONrWKpv2JnGM
 GaJGzrX6doFcC80sKOUBW+czkhKiJ/hDPyEXO/m1zl5F9pc7A+dmiMBvb8+lB9Iv9znm
 +420gQtKOtHxdeObvXII1NhVDnDSzQM7+LAGrMuTAW0sA6RZvxJ77aaVWmPzWETX+Rax
 EFxJhecklRWqN7vziuYXTeGeYGn6I8grJG9H3LieR57UjNiCx08WOf4Sw1yaj7+XBHrS 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgauhqc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 21:12:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AKw0Bj037444;
	Sun, 10 Mar 2024 21:12:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7b67b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 21:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQUrR6nt5gZoaEMzclPlC+vm/gI/N07AgtqmhUGQbRfROQNzxOgaPxt6j1/rMEnjmgNy5Iz5gm/sPh3od6r3HVt4YOPJf0ipI6fXqdSb225GBKhKwHH5dRh22aa9pvpeRrV68OgjBru0ktKOxU/1Qsem77Sx76HkaGCD/vEdAtueJvSeJzZo/rZmwyz9J+526WHqElg6OVQuyO4pHNiOg4G0onCV1iTffh5nQr5RXNu1lQB6rLOlwNJLVWLbNR8V5KNoXmpprvu3o0YN3safZo7TnNkh20K1WiR0W5mj6QSH0yHmU3BP/3FNg3GgNZHRtnXIjPDYSqzj3UlxlnnjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wNrBZbCP9lhh9HVXbBJJwRCYk4+sSNOt0wZpiHvMtE=;
 b=eX/p8WrYQiYZ/aJyfm+haVT0MqjzVmy8cQe/wtldPQ4z9KArIfGD4EGplHt90+gxQLBLQCddyy1lRBiu85KkW5gqTZctkH+rYs1ougRgUyyhHG3MsG+n9cTvAQC8ulymezjYlXiorD5/XsXpgqquVUweM8HvZlaCaONiawHyw37JAdjd05Xe0BAr1blwMlOgBQzpLqQvhYN50uJu2t39H43x8yxY6B18QowiidGEiCF/K5/G6/yj4AUi7oaT9d7nSTbwr1JKOBw3MldM8efVTGQhLVw9ECCJAIIxcxGjx2RtIjrUkq1c7tMGW8SXOR8vxRoUY3jquJUjqMbfbDwe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wNrBZbCP9lhh9HVXbBJJwRCYk4+sSNOt0wZpiHvMtE=;
 b=LTISx1FwGZAfupfV9ORq0pI199MO8mZGaQJ1YALf1yPllkz3xFZRXIy6DmnqVyunrbtYvvNYRSv7QkRLzhbQAC/GXwmzRjO36oEMvJxKuyQCP4OpwRmV6ISXQsest07N2HHjG2vd0i1SzZ4EpOKMx6AKfalloTWpBrvtbqmdofg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4640.namprd10.prod.outlook.com (2603:10b6:a03:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Sun, 10 Mar
 2024 21:12:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 21:12:31 +0000
To: Rohit Ner <rohitner@google.com>
Cc: Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Bart
 Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Bao D.
 Nguyen" <quic_nguyenb@quicinc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Fix mcq mac configuration
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240220095637.2900067-1-rohitner@google.com> (Rohit Ner's
	message of "Tue, 20 Feb 2024 01:56:37 -0800")
Organization: Oracle Corporation
Message-ID: <yq1o7bleqq2.fsf@ca-mkp.ca.oracle.com>
References: <20240220095637.2900067-1-rohitner@google.com>
Date: Sun, 10 Mar 2024 17:12:29 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:a03:54::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: 8592864c-21aa-4ac8-dad2-08dc4146cc78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PawhYn1W3x5LM/2bjc6pOlO4HWqA6o7cozpOuBPkcXcvJICounGdrPpnOLX3h7rA2curl/uX2srGPMBozjKk+ABsU675L6LUxYhUx1NQKiqDlJo8N5CykAKHemo4UqRKnVDpv43gh5tvI/M/Z4hhIUKx8RRgVj5fUitKEDDSUGMieOG51oXRdoHWDz1Wa5h3JrVYBbjLaB/9LA06QIq2oNbK+cFyH0OKRXZCD7i4vSAt9IuknOX5zHi5Xvyos4lpKFtX1DdsHLQdxbiFxYiNGo9P9D0r9ZHpQ2KRmycGpt1Atsv8iV6aeVZu1iFuW1wPwR2xvdcBC1QrllAeR/4kSKTxmdG3/4Jj75dV+YoqvRbE8Jzi9AUoZQQQlMWEXJmEpTOZ162dXojNmpuTqgGBkGwOFSonWeJ70ZNVB0Yv9N65B/CRrpD/8p6847btFR4pbMfcxN6Ys3kA2LHqg24vfDfFdrsJjDdzz/JoqCyXcrOQ45kb4grqmKFLVgfjadufW9FsWLxhIDNz8j2SiXE7u1H/KvB8MJrJ9Av+xRKa00wL+PbxdpA+AYDomYnZ7NjKomj4uT8ZGJXgqBzsWPtEof2Q87zum91/hiRCVUqy8K4qlz1MiuGzfF+M/xYyvLiuAPlG8NMBZcB6ylwfLuSQS9Vvch0QLTAOFeS/Sn4xSXk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QPpgPSynpo4PA8vF6jPZXL809Y1+K+0ysLHjPUDDw9N3fcIuo5P/5Qi/zdFf?=
 =?us-ascii?Q?hAcsUjaWI6sM+Pe4TjHxI87UuHhc7z8msNvwZuwKVdUb4jFTIPa2kMMRE8sU?=
 =?us-ascii?Q?BKTZz+rqsHZ6fSmyxqrsJ8T2n7YcnVM1Oou1pqdMiruzmkqdGz3oAg38edUD?=
 =?us-ascii?Q?Je7nOqxEsscg/ql5JDmAU38/weFw2gusN8Q3nwjiTwMXJOZry3M8dK9fs/9b?=
 =?us-ascii?Q?8/2u7b4/dSfrOlLeJ1Fn1WzPaTB4nBnM3Jlt6tF30YPnCOth4HbSb7+puUZV?=
 =?us-ascii?Q?ba9lldJoCoxlDRGMPD/ku63O+Htfs+8pU7I58LBR48Mh52EnJPzHw1BNEWdH?=
 =?us-ascii?Q?zJdhHI1Wkh9gumPvYtT4J1c8GRt/IsgIS+yPFu5vyoPz5Dgq8mhOzkk/a0fU?=
 =?us-ascii?Q?EcI7rI/G8z/CHC5YStxFi2Wwzoaw4Lqc1bzx2uH4/hSVyu8fYpvzOEyG14R9?=
 =?us-ascii?Q?f1Adwl/EqJXL/PYHmESNXd1rWhmRbrTRBA88x2IhML9pAq9a0dmRelJ/sMco?=
 =?us-ascii?Q?Q0R6Jy5E1kFxcKr59Cq6hE7pPeegQ0Ui5HeJSsYguegZUkQ0km/l8zDjF0rV?=
 =?us-ascii?Q?69IQ1EOLpNZw4CXyoZU+Fw5ZnlmkaUwqBsB7WLoj5SYTtqUGOJ5PkBGk0oCS?=
 =?us-ascii?Q?hTCvP3+AMWx/XOCOPG9gAL/pcP1a//u3m5f0sfQjHnBwl35PR3PG0wWUhc1+?=
 =?us-ascii?Q?I4FHof8oDQQAozsHNkYFzdy22m2TcqprR7XzY8kyspuZbbo9w6J9RLg/gP8+?=
 =?us-ascii?Q?RNihZEg66UEoGl7B7L/SQMsZxOP+vu0hkuPFxz8V4RkXzsxIlbYNLkrsOO1h?=
 =?us-ascii?Q?xnEJIsnl5Mdl/sR04TW7P+c3C2dCcj5TMNzILqX4DYD9kQvAyvTvoHKD4KSc?=
 =?us-ascii?Q?QJ/ikF10RlHQohN9mNjc+8+SJXORCJP2tBG2MhosiMecYJCiwgtj7TuQgUuQ?=
 =?us-ascii?Q?Tl78cTmUAyLYB1vSZqrBA4IEQyBBLkug1ylCILnGpw+x0d0IxxWHKqjdZ3Vr?=
 =?us-ascii?Q?WgU3Yrdn54myORof7Zc9wTTD4u++xPoEvdMS/NwFKw6XcEeV25X33ICrBJSJ?=
 =?us-ascii?Q?6eypWw8q8CFutNa0BOnhBaZGe8fEBz/HxPMYQq4XC2SVlLuzDOGSdJNxpndg?=
 =?us-ascii?Q?fCQfH0FlU9BDlDMppdhYKXMmIa5+0jRFGGAfQMx4R7xBAxkmc737Bdg4D2pP?=
 =?us-ascii?Q?f46THfl/2Pcw7EmzcDuSzMXfJ7bj77GT6vr920PBr3WOxMIci49QXYt0pE86?=
 =?us-ascii?Q?aQqVlFFViU9g+74IO6qPdWvKw9SSkcIXrOWLj35pKZPdl463U8QCOM/O9aKl?=
 =?us-ascii?Q?iC6gB9jRFhhrqjrouhqZwJy2m3srjDrR1CwhkLCZ8MqYAGlP71KUxC0F4qYU?=
 =?us-ascii?Q?McxeTQHIf/ZgZbvSrtfOWjsKu8C+oUEylR4J9zowSXdtb2rwt7f3U/9YxCS9?=
 =?us-ascii?Q?xNAiJa8FbDsl5OjhG65uUE8HPa6ajjO3nCLecOrgUIh3DOa6iMpucFTUMu4O?=
 =?us-ascii?Q?n2GkR+nG4r89/Tr82w1yK333cM42m36+eP0/jWWwD6Z6XeGfjuIQtyHlCoY4?=
 =?us-ascii?Q?gomzZ7ILlEWV6BpanL0cOVAPwuBnRlsTmLny2aJaLRIvizNnWJ5cTW++rWUs?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ia80DVgVfegoO787k3djSZ7FL30rqghhiF3qpXJT1xf62CcbNiVGHHm2KSSvYcMbm1lyOE+hRyc/6baQ5kMfTxzEZg7dIGRN1SZVRzXpBiyYTw+6yKeNPvUj4ATxESnV9Te69KxAMTG6MBGvNeNO9MzoNV6mv3p+iJ20JeCHGsjArQ2G4A/OSZxLbIyJQYvv87UNKdaLh3t4rNTxLCh5CIDgmpx87ll5ltd7OhpusnAa0RVbPeh5m4SgKYliF93xRhIP2BHNnpFUe3HFGi3/0/GPmW6Yr1H7rCAmiEKDtYspWeA8UuM+0a68H82pz3PIV226HqKIjfRc8cMrGlxnCcAsIlGJHRfSyLf5SfqPWsn3FjOaxyXEwGUpO5XuxjgYiVLHGnLgyx+1L/OyL5Tfs/uAw0BfMf6fOD2tKnqp7te8MRGa4svDEw9o51BD99qs+IHLoOOdgtCrVfPBpDiwldW98fI3xV+skIA+Kz8uQZ3GSMrkaoYSpmvyPkXabc/TENToRpl7UwVXkRAaXSs2ztuhEJAI0UZpuulcgFlQzQriqT5IQV/i6/jHPDX+yLkUrYtkJwQ84kT27VIAHZjECzCUX9D7h4Or+prJmJq3K50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8592864c-21aa-4ac8-dad2-08dc4146cc78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 21:12:31.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDQxNvt0yVzcpDf7f5H+YYSnPN+eSASjc64FAcBaAjuqReTxPlHfD81RdclZ7NMkacNmerV/GR1qf20K9i6nHGldAdMuMNefhC1dIlg6wMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_13,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=860 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403100172
X-Proofpoint-GUID: FZNcVSJKyx8kfCQODl0H2XPpX6m93MqO
X-Proofpoint-ORIG-GUID: FZNcVSJKyx8kfCQODl0H2XPpX6m93MqO


Rohit,

> As per JEDEC Standard No. 223E Section 5.9.2, the max # active
> commands value programmed by the host sw in MCQConfig.MAC should be
> one less than the actual value.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

