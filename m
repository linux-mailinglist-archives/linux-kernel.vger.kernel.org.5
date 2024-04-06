Return-Path: <linux-kernel+bounces-133753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600E089A81F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105D61F24024
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340D611CAF;
	Sat,  6 Apr 2024 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GB1c5XcM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fNbwdwwj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD681C8E1;
	Sat,  6 Apr 2024 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365977; cv=fail; b=ZxczqSHHouQ/Pb/RcNnRUo6mu8GnhmtkTiwbLvHRRY3swLnkdgYe3qdHCtdYb2fC4/3elvtzrbC36UOPK26Zx7myZob7w9h9gN7BYIT7rcYBxLA11vS9kj41HZyFJZn6huJW3R1csvlemRfuLkehUWRjCUulrz0dpb1qWHezMUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365977; c=relaxed/simple;
	bh=5ueVw5AMPMiIvonGj3FAhnS3yH/6MIgCrnaiT2yoIPs=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=NBWSdS3vdYDZW5AbuFNOVQJYr+mcJ1QJncLLTP32nl2EsHz/PMSxHGjUrDyzfVd7Xn2Ci1g4+I8nOnS2enmcmcr5Rrl7c3/pdjMMhWrjaR54Xmsl/7iytxLPGclieogp2HtvUGxczlR3ae6EnANCgbxzeTOvYyjFosfqCOpmZZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GB1c5XcM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fNbwdwwj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4360iFeZ018643;
	Sat, 6 Apr 2024 01:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Ch6003nqV0kJ+tvIKl3FPSFiNOGasTOmqMiaBXhJfSI=;
 b=GB1c5XcMT2VopOQA29QGdIP1c6E1FC/LJxokvrZbqCZNzymIQpDsHicXTXUeMeNYPs6c
 h400bihktsigMcEdKbwHmRLoAIDPxHNI+g8Jref4Z2Sj0MXYF1HF/6nJYUjzXKadNkt7
 T/11SDmmsF3zM82fvTUdziEHIX4kPzah53dy0djKOdlg0bQMfJ6sc/0VCxK0HgjHynsQ
 5d3blK3ae5wNULt+aPRD1Kaed1mYwgf0lYlO7t2n79sX/EIDP7CGNKQ3tc31lWZs98tA
 jlHZA5YAIBg+HF5cSkv508+2PXmmZN+2jQEtCrnhpG8OtN42HV3t9YD+TV+t7I6D4e8b dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9evyvm6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:12:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43609lqr026906;
	Sat, 6 Apr 2024 01:12:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emppbgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyqsTsHBwV0vsTwp2l0RuriXWVMybGFPLq7ELG9pNPVDbUpgBB2SC36e7Em9/1yT7H+LJu6xllOLLBKJMq4D1TqZE4/6aUjAbVVW3of0qHCxoKMLBUqdt/RbMX2i/Cs6NGYqMpsKxhoIlmPZaBrj55xADE278O7zarit0WkskHjbXP5MkUwZz/v+M6pIUWxqLeSvArlMSGs5MBqcqqs/h7g8NIktNm1SPE8WruQutSebj5iFA+5TSAZedjMU1XesetVIWw534lzzo1ZlbkO+ts9KJN+tW8INVP8syn7l1UcV1bIbcku4+VaJkMYaZ41XJsoD2+tDARVD1Y5girQUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch6003nqV0kJ+tvIKl3FPSFiNOGasTOmqMiaBXhJfSI=;
 b=NLdPRcYizIZIbtXcppfPW9by6gCASEGjHfbsP20w95aYLh5jR43fZWpXhYKHL6PTugv8d5rzYSWcCzJ98mW5rkdLbMDpJOahJNcpf3froV7DXPbq0LUoRk00lzxPkINW0+UOJPHSc7ujii1Wq85/XtLHSjfixCreLrfGs/YEm82L8awIypfrdBgVppKwz99ZsR814glAaNI+lSQZbYAezD9ESo7z/Ub3ZaWEbT0uOuEGmpJ/DFCefp8Tqs1jn9KeQirKwg4PP80KBUU6enSCR57+chnRnRSRE8L67oLdwAuAcI8TJOwVoWi68aAF+j/hIKK1Ozi32f3eIR7JAQ1v+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch6003nqV0kJ+tvIKl3FPSFiNOGasTOmqMiaBXhJfSI=;
 b=fNbwdwwjuLsH+2OkW0ANa6tB2DEkklZGrn0mHR65/bXQorZRjRIawt9rjRihRii7LZrEVmpMj0XZKHgURIL8BnPdDSVfJaFSVBLVIUK9b+fdL1re0t63rL8m0fS2NqmX5/ivE5K9THr7HehJEtwUEFJZJCCCYTzWspdtMqNqxdk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB7514.namprd10.prod.outlook.com (2603:10b6:208:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 01:12:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 01:12:41 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/4] scsi: Prevent several section mismatch warnings
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <cover.1711746359.git.u.kleine-koenig@pengutronix.de> ("Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Fri, 29 Mar 2024 22:11:40
 +0100")
Organization: Oracle Corporation
Message-ID: <yq1zfu7qop0.fsf@ca-mkp.ca.oracle.com>
References: <cover.1711746359.git.u.kleine-koenig@pengutronix.de>
Date: Fri, 05 Apr 2024 21:12:39 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB7514:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f/uFMxVHKraMf3VXI5XT0PmHxW/qJEAmB1cyGZcenm0GKlNAg5VXiWDKZA4GBnGJ7xsrdWTlvMZUOFTt9y9hG1fHIWXk5068D4qZ8v8dAy5DbiXOFNc2Yx0WCqe9jimq2lEcW9zIwsjMMq2LMiRqmgIBHLGaZLEHfQVSUhinF4pd71zS+duVvtSgM2bhG9YBTT1wFcdTPA3E8/4SCaNzkHcjOlPi24+DvmiLZvkraOmuEU4f6D7rnKVI8/STBqUGU3SEk/n5zENjVAqQSsib9s+pevqojsuf5ve/Dy1Y1w8XGqphjL0qIjR2xUTJ38+oFyDyHTwUKa4Uxpq2PAQuAsA0VN1VPtNXTu9Y4A7L/+OB3QUKx3MKLWm8FB2N0rK/pWa6ysd/8PAXy10NStKZoinYSi18Cwy5c+LKeWwxL0gut+BuW+BlJI/Ah7WvPF1pC4VLwIjhfKXKyye8vj1nmRnbKdSE4xubYNiI9UJikbPcqpt6npVdLOjyPFlv/kXmlCquKuR0j//BR9TO4eIwmUpYkC5SSCQoWqQEP403XSBp9aMtVUq6VBCIQn7KGkO+QCSeamlGXanqOhDCsBUAdZTw1/9BDS6oa9RRo/oQO+8YPBbBan2A82rT1RaUtblircC3ejS4E2XDhXv93Xe1/DaTiGhdWJxG9JqZbc5LsSw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1DClXWCaLBpJyQuhSsX5cm1kjzkasdsFB/j0bsQ+lEZ8yi1tmEhLIUDQEpHN?=
 =?us-ascii?Q?2JnSTskA9sZrIfW14rWSy1VQ5AGJqpcrAtfX2dgCVm8AsWOii7kJfNwfj8L3?=
 =?us-ascii?Q?/dWkqkODnMhB/1NTceVAAcNeizNiC1f+Fv/OpELROayT7w2QjbwHXlxgyQ5s?=
 =?us-ascii?Q?LIUZ3H8tyY//8BOHi4ZkOI1Yxj2N/QpWhNy4jHKSpHLML8UMbcHow8vaoTeh?=
 =?us-ascii?Q?F8eKf25cg/umkH9+48JF6nLEWsjTOqM/svTsej3bclqadjeg4Xpuj2PX6wMv?=
 =?us-ascii?Q?gPRl/LUlJ9pXuymO5yS2cIh8CyWPzIW7pJGp7114h9DqMeXwGh84hb8eUwDU?=
 =?us-ascii?Q?0+VBE6PUYsK5g73T1/JjSMj09rUo5GAMO1qGqFuEh182xpxz6iJSJ3WF49jv?=
 =?us-ascii?Q?jOxmhINiJN41jQt762JScZ8DCujSSY8MyebwusFHMW3ShRLHwR4UDagRa76e?=
 =?us-ascii?Q?he4z/hBGd3PjacW+OIY7K5iiLm3CDeFwZECvPpeQTQwE8moKPAveaYybbCNf?=
 =?us-ascii?Q?eh2rOSbPWDFqAqFg+V/sa2yEkEtE3Tt5lherO1/eag2pFT0zC9VnRsGWzQd+?=
 =?us-ascii?Q?V8rh19vRFoKOaya9upJfpY2MIO9QmiI+x5+57PVzBfPvJy9KUTR1qxbaWDuP?=
 =?us-ascii?Q?fSMeiJM2rTjugVyNMKeYISzw90EwS8qTDaKW5FV6LhZFOWbN6LC+70VPDVua?=
 =?us-ascii?Q?046w5gIpfmoa/eMsSk/0RiLy62QokJrScGbK0sN0jo/RmAnliT2k+kbcsflI?=
 =?us-ascii?Q?BYrebs4HVvmL73dWDQPVuvGhB3ytx9sK7Sqz/XHQEwdM0ONmyudgi9l2xFwN?=
 =?us-ascii?Q?q8hBVboW/oY5ObTa9lk96QD+44hmoL8fhxoXGbqNkzxCzJMx8Lh2zN3hV4NA?=
 =?us-ascii?Q?XnpPgXORnY4wGSXOe1NXXzFmjW6yVLUfPssLcKcL7VDAXTXVAkac+xmrdJqE?=
 =?us-ascii?Q?LMsnMeZbmUfdk1yJmkXEPc1m/50kWbXO+7XEaae7MUV3nCW8VLImhCNz7njR?=
 =?us-ascii?Q?qW2dSXU2Lb1CpAjkZoHEV3954HlpbMJ4fJAH/wdSbEU8LZk3oF7grdFMv6Nj?=
 =?us-ascii?Q?E1wTSweFRkK1H/nB7gTnEngn4+rY9xZ+PfWTli9c7e8meeigtz82awYb574b?=
 =?us-ascii?Q?x3w+bOSuUvxUezFTER5dC4OHEnpVf9MBE3ns+jxJ7BISellOEe0nKw2iXrPd?=
 =?us-ascii?Q?Cg4mx1FJ01jvDgmRET1YxMOVe5aZbKCu/6Hf97k3deAIZvdf5wDe3DYGXq4M?=
 =?us-ascii?Q?AwF/bV3jT3I5J8Y0F6q3gFR1vBTMcITBbFzzfRuhdR7iOdw0vtbsxqdfF2ng?=
 =?us-ascii?Q?rITd0/JwzuNtV7kcf6XbwT811dXwTPpTjmLEKZ6HneTuclJeu5/DAG6RZ2HB?=
 =?us-ascii?Q?PLwb9QOH4vGdR95kbvD3ecJJfOt30KQPZKzF35MEXvTQajn0CV6dGCq4IlGT?=
 =?us-ascii?Q?gFdUO8xDqVR8/4B8tdXUGQP9afWNtj0/IIf0hb1KrgNXYF7F8Z6rNpm9AG6P?=
 =?us-ascii?Q?ggxlOZpmIY/fWhKEaClkH77qA4Jw1C665P1xiAz0ZaTlXAQVJNTEnsBBreCN?=
 =?us-ascii?Q?2CI1y8dgkll4xuO08tOwM/fiio3Bd/IN+w/AQyFvFsD/jGMxbY11sF6UILAm?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MWOQqsGWkyhtowcdYybLNYgxEgYt11QmnTxvhBDQ8E1SATHVnJc6G8W9hqK7Cn7RrqU/L/4cORCHOh7RQD8NHCsAiHoRB/1jvcZW7vcd2Q/XZeaLajtu2JN8wddSCdzLvfuDPVimycTJroxZUo9AWmB+b5swm+gPxJ6SSBVC+RkMWq7PJIbqBMQKUdFlt3RS1lnNlXegjer1nlVuAk/CPn2/P1AMuASu5xMSxv0V6k3eVKwHP6O4vXtJw23C1wnfKO8Odc2Lj+YMk9QpZ23vE7f00UOlOQjjRytJN7bf8oRRs27At5ajB6DTgvm1jjcjGfRQQ8UNIqKbOGexXsIHv+MavDaoiVnNcc+VQqwzpyXV2NI3yW9EuMPaxHPY3/jYigjSYd/TUVjYyeo3Ymppl4W87ZSqzR2hX3blbNfEIE1lMgrcw9/BbRleLWIM/oBiHAiCAFpTjPlrnAkc9NkB2ASbErneQuvBHNpe3manhDuskgfyo8HtNSWiXj1lfjp+r6A8Fg9Mgn4ACXSS/ZCFX801rtmoFHyFgqWwdbyWuwBdPfyyq/4R8nTYBoFKHUduOfnNuZOQ90tq+Klk9xWM7pTN8wc1fEFzE0OWnAwjr7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd363e5-f546-4288-c5da-08dc55d6a878
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 01:12:41.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKRjVu49yncOjhzDTAvpY7CBhCgKPysb1vQFe6nO+HjFbnbHlsUxxXU5N+gqs1lbGrhcT6rm/IL9kec0lK9G/ho42wxjSSrwEBlA5buuQyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=986 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404060007
X-Proofpoint-GUID: a526McH-xPivpDYYjEQzgcL1ywGKoz2S
X-Proofpoint-ORIG-GUID: a526McH-xPivpDYYjEQzgcL1ywGKoz2S


Uwe,

> this series fixes the same issue in four drivers. The warning is a
> false positive and to suppress it the driver structs are marked with
> __refdata and a comment is added to describe the (non-trivial)
> situation.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

