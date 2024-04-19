Return-Path: <linux-kernel+bounces-150905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A88AA68F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E36B20B71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD74436;
	Fri, 19 Apr 2024 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVZOdrFY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dc5BwxHU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE495110A;
	Fri, 19 Apr 2024 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713490550; cv=fail; b=E500CH8rWi/fZOlQyDq+VkjpBDJeK7eLi2CgOBedvef8ILj60S8iikGLF+BnYHzAb5FDXXONjATdPYhzE28KrmWmbNzUjBT4Cd/dg741DH3v8iigQan0QXkKevSDrgxLc6qAXhre4D09BRKKmbf2ITSuoaYNdYFux/Uz77eCLbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713490550; c=relaxed/simple;
	bh=2ydGI6kMVG6Es5hoLKKfT0AJpchP9YN+wQlkGqdSHPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eoos/PI5MEvNpPFArr7S6NKP4WStCqyOfGqcTk8Yk1qyITS87FtEf5PqZit4PmTsWdrdAhBE7zD6GBWa0k2VCn6rMFZFISvZVH5yA0VSeM4usY/p/H3SLNlt5iBQeOtJRr0ybQ0E2M+aUBRsNyKaKr2a4nZAAQBFkErYeqEofFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVZOdrFY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dc5BwxHU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J1JOBi029636;
	Fri, 19 Apr 2024 01:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=CUGjSa2xzNv/8G23c8Yd9TaHBAkDKBCR95HWZZHmguM=;
 b=RVZOdrFYBsUg5phu9jqG5QpsII5YMs8voz5/AuBvZoBJ3fkiEjx199Y9GpTjYgiiTsnW
 nRY3OWBTorOzBlzci2cRr1vAkW4HEBBqiNbo6YDPbBsob3Ng4NVfZQmhscXQi6RioiBt
 9E2kXoWoI8GqMuEBrPG7d49zZyASpm4givdi5kh6ulIBKpvG2jGqDSvEyAFn8AoINhdV
 6TzBhHeONI11OccKUUI154AF/kqMmy7B5Rq+sCXK2Cv1SDGih5lW0QFgyay8lNAd4WPx
 hKPU8unyHar+0y7pzfoBea5z+RdMfn2rGvFnyTaziOlv9PbiQjGHvCcXvU06cWtptKQQ 4A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffkugw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 01:35:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43J0capm016803;
	Fri, 19 Apr 2024 01:35:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkbjbe7pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 01:35:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju7AzIKaNLULtoZ9a4zjYLTnoNNHnBxDD6dw9+a4fdgQ9Vn2NQ+ORM2U93eAqDVmlGUmARG5ZVZrn2cu3I0P3vUg4nFvqUzMsOB1xNqm+U/6GJGDzqK04wGfAFSLwwpBntrScyfYPerL2sb5n43uqjHabwy+rvOlg4a3HMizsBRUPkJBF3r/Io2OHwf3OYXr9SFjPVeY6ZZj+RV5w+jODOMaP26hZDws5thqs0mqlEgQ74nllOpFgaAa1ogjXA/1ai18xvH8Zcxw+aJfYCDDqySDOs7mUMLlZOgP+fJmgVoMR1HCfhGJbkZMbD0UJCLKDFbp/HWdcHXyOP+qmvjzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUGjSa2xzNv/8G23c8Yd9TaHBAkDKBCR95HWZZHmguM=;
 b=i/+cHruDFwV3ksloDdkPAyzKin2PCnsEomuQ0b1CNQhHuOiyiAnEOkaNeWDBGYfTPfYT+x5QFd+Bblh2hAZp9No2BL2UC98n1qDfmb9f4LpNJFnKp/HXiymLKVo/Q0yIkG8J4JiwmEPR83dX654Xjlb7p3yvOv1C8xU+/7xUqk/66iPvLpziBN2BHfNWp037LH+15BqhcXtlC+twHW1mvkAV9Cj8/lc9cWQShrq0BG6XuQmMrzph+UN9h2T1DJVy296ksg9W9YONHbv7+orFLJSVq0aIXAgbi0yy89yzLh9t7fKPhmmnepJGyog41XOo83qE9MfTxAhTKtd0Pjluvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUGjSa2xzNv/8G23c8Yd9TaHBAkDKBCR95HWZZHmguM=;
 b=Dc5BwxHU+0A+0U/OXRFCXZJxLhFYnpcMo2T0JYsroQaCd/sVqXhx/V72JfbWf02syCpv0G1BHHHlbwftppsYUpZ5dBE35B7odCQvyLpzKy8Wfw4oISql+boIR/zoDZ8msB5QYUwoM9iOzpFXiXBEmLFeTc9ZjIAUwEQ441c2zAw=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.55; Fri, 19 Apr
 2024 01:35:37 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 01:35:37 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev, tglx@linutronix.de, joe.jin@oracle.com
Subject: [PATCH 1/1] genirq/cpuhotplug: retry with online CPUs on irq_do_set_affinity failure
Date: Thu, 18 Apr 2024 18:33:22 -0700
Message-Id: <20240419013322.58500-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419013322.58500-1-dongli.zhang@oracle.com>
References: <20240419013322.58500-1-dongli.zhang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c7f895-8b7f-4a7a-43eb-08dc60110378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1gHnbyqzE/KJF3XlYmaoSd3XkWhtUIn9EpjAuoZz8Ci0mP8KPVTxfrtERH9S8IZgoXlCxqPRSE8b5C1+jzx/VqhPyQDlAcA/Ohs8gnZbcYOcmKu+yJt1fOjbFb4zrIkhVyatl3WqFcYFudU6H0G4zX5rZ60lvLpjDwIAbYJECrAhBh3zwTvMQhRZPvS1V69hATAStmWl2xBNR+H4wdSY2TOQmCmhTgjL5clXeqO53R9McVTcAJzYSjVePYvn69MGW0Oq0zrsi4AiU7gjFxEYuWxHw3btQ/8ITQ112H+Bm6IMvPpmGDpXGe/h9haMr9XzoUBpCmI961WvW8sWu7seggqc2RfF11cO4z9sxGFsTaABq73jRBDT8kGIePOiZn0fXl0eG5vvlKoFLBnOv/+TP9TwPxx01+dQ9/gQfPDn992fN7joKq0jgLN2y/SNulDqSmZNYoA+rKZIhlwUKeMU3xVVWcL5pc9HTmaugCcO1r7vMpZR5MkE/eRP4WpmFf792OW+DwodWDU78dZ+TuPTz1TT+9rAmM5hKib93ChtuT9jkKHEt+QQ/5+957RDkL2cyMo+gJtVw4k0AerhfrmHpNyf66MjMBEAg0vxLYEvxUpBXiHJINQ9eJ2JkdOQlg0bDzn4cbQaTKHPyv1URJF0o6gbXsSwbNmp59HWog+PUZ4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y3HbnoAFWkbbbDei3NbftVj3OhDzSR//NwZxSrmK9ZrPqRtRiRPPiDv5hN9F?=
 =?us-ascii?Q?H8g2zrhcwgk7a7G792ougzKbiwzKeh1PCjS8NNDUPVu5jGgtkZyD4dhIBuBh?=
 =?us-ascii?Q?xAZP9otCUQW4dIlvz+AYWTrJBXE9PN9N1bJfvf4z/5qLQjkVEMzysr8tf8ri?=
 =?us-ascii?Q?FZO91noJCEq9Al0zMfkRPcjzDcAbboqkF2IEfPiUKO3mP6OP3lBi+t9CgO0S?=
 =?us-ascii?Q?cOwMsleemi9K5mRDmlKkd3EnqQ0gh95ltHX8UkDQgt858w1nAqOiMAeHULRa?=
 =?us-ascii?Q?H5Mb9Rhwcdzn935IOO3rQlo+3IhCINwbhaRM1TOyY3drHNJTWSwizSQJyjKp?=
 =?us-ascii?Q?NWM4BQWyj2ZgDxaawLaLCNjmab9sI8js3nOZAICwbct4SxMTmd+GVqbBbZus?=
 =?us-ascii?Q?3Crpqw9sAEV/ZoNGxc6R1jYwQvsuPj8PmKMmiZGeEVr+k+qAd2fmm9KVULfw?=
 =?us-ascii?Q?6ubbtueEv6pkysK4rqOFeCOuFJLwnOZrf6oXnEJ5od4PC3G6+r+1G5ecPuMK?=
 =?us-ascii?Q?nikOxl6kl2HxtNV/mv4FUSxRHSX6nEIRu5PgMclOaSm9TMzrx5Klp/M8t2mR?=
 =?us-ascii?Q?GU7OL3iXV+G0oWqUvIDt/BGiVe4o7+yEhwP/mRpgXsAC4Lr4yxVOGvvinU3f?=
 =?us-ascii?Q?WH41FAn4r9TfleFT98Wo9KMBBR6w4rlpzDjNxVOZiLJxzPn/ikaTYU1Ius2m?=
 =?us-ascii?Q?KP0TnOvoHdEJZm0scgvk7tF+jKfX18j6FXzQuZH0Y12ZwpOeTSks0BnuggC9?=
 =?us-ascii?Q?8XqCeSqv4P+HWg9zDE6R5r4sOAWmIl5QgYXRKjsptENtahYw/fpP727h1kOa?=
 =?us-ascii?Q?cOLkvKjmJHs8UFhbHstMhtsYF8f0rf32iQ1h3nVklDbRj1QM/f/jCUFzMvJX?=
 =?us-ascii?Q?WpvUdaNmbFnLkG8scPoCPMZz1PX21oNnDIc6Rcdx2jqTAel99l+aSFQ9fTxn?=
 =?us-ascii?Q?ZehLLdq+xO6PP9jv88+fXTVXhnaICN2xy/GXZx+YSF71nPqkxEk1cHlqWNre?=
 =?us-ascii?Q?2iotWucMSnfO2GxRMoXkwG2SqEooFbUKqvv6I+Opct0rpGnrGu+G03h29qqO?=
 =?us-ascii?Q?fLmlvuiiHzftzZknqGb11LO6TQKma6hzxDmJiY65DQDSNuKKEu9iZ2ood2cQ?=
 =?us-ascii?Q?QIAVKQaptVQfnO7TBlHlwe3ugecnCXbpybE97wbxglArsIC+OeVVXfIgOugd?=
 =?us-ascii?Q?NZG60rXzKKLQBrHvq6bnGFA0l+oVV+C51VmjqJCi7CEzJCaZafykmyt2HxRR?=
 =?us-ascii?Q?Vd29z/ycRRCXQwD/f2BBd5q3A7B8lRpmRkq8xVNCpcvvnJg0+LGRcNy8T2Ur?=
 =?us-ascii?Q?rDb7DCCVksfcUKbhiX4FLqiBNgBMwlsw96nBnbNJNtlS/xAVHhnyPIFNgAeJ?=
 =?us-ascii?Q?/ns34H1D2UmcjO7sIefdY8qJ/MSJ3R27ZvG4jBbBsPNeJAStboapcIwTi0Yd?=
 =?us-ascii?Q?htOhBA9KjY1Hp4dcwUSpFqhxZ9YJxXr3fk1cDA/kfmpSwtHi6K+CLcAmWla4?=
 =?us-ascii?Q?VmpUGA/5VfX8yyJqeNdAAw3VFH1QyUhuE4gc4KQS+j8QRKr0L76Fpo2CEkUN?=
 =?us-ascii?Q?O2q60caUOdrHjluMJ/g5ABwuFeE+d+Ouf1PQIGuI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	k/QpTmCU/G521f5yHGu+ZUMM9PhcHfF7oykafMQ1r/tCkZMfPmWsWcvxj/5URw6K3MID6L36/sKuOrqSIwz3OqqgKzAjmkYgvVajb3MInFWpj9L+O1YORDXjNESoiL7QAFEPuWu0SCDPDEDSiWFHzSTU+H4G/Pusd94kswaFWl5/g3tZFdNlnFGcBEzzd93N77QWUXvrtmg/ZLd3wBYMnXguUhA6sF0nEDEtXCiJ+CmojqN+Mek1hZkKkwOQzGjf1pk3PXO+wi7FhzKDWo3OqLsp3PJNNyb865vwlGUfeYxX/JJRnnlKrGHmtdVRrzxRasSSOH0VlxJa7paIW/NbiUCsn/oxbSu/r2UFObmQJ9N1PDsXtK8v7heT7UHIiPaEsmkwQToSkIH/eSqbnICoYc7URf0zkcX8cvM4F/pfHleZFVSSBxSWe2btwdrKc3s8CZBSQc05UzwDyZgfF5JonkPDQKX6/vLm3pyXLWX2kW554KZAMsaRASsBZTUzbBDlAZON32xZcyIxH5YCG/ON9KgGEmhDQeDh90ll4Np4JYRz1I65VNpLB7BjRXugr9Z+CygxS8Dj2qfadh7O/dVH/HuDgDUsmEKgCs0j1xbxdFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c7f895-8b7f-4a7a-43eb-08dc60110378
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:35:36.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQDNxMJUB9QACDoEdOkhHNcbqvYks6BzIUsk5/aPuT0krQ0RV1OVhDKRF1l6w4c+LAXszwL/b9OUYeaMLZzuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_22,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190010
X-Proofpoint-ORIG-GUID: HGu7v6CxpHZ9N4m8LjAdOz-7BkTp0y73
X-Proofpoint-GUID: HGu7v6CxpHZ9N4m8LjAdOz-7BkTp0y73

When a CPU is offline, its IRQs may migrate to other CPUs. For managed
IRQs, they are migrated, or shutdown (if all CPUs of the managed IRQ
affinity are offline). For regular IRQs, there will only be a migration.

The migrate_one_irq() first uses pending_mask or affinity_mask of the IRQ.

104         if (irq_fixup_move_pending(desc, true))
105                 affinity = irq_desc_get_pending_mask(desc);
106         else
107                 affinity = irq_data_get_affinity_mask(d);

The migrate_one_irq() may use all online CPUs, if all CPUs in
pending_mask/affinity_mask are already offline.

113         if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
114                 /*
115                  * If the interrupt is managed, then shut it down and leave
116                  * the affinity untouched.
117                  */
118                 if (irqd_affinity_is_managed(d)) {
119                         irqd_set_managed_shutdown(d);
120                         irq_shutdown_and_deactivate(desc);
121                         return false;
122                 }
123                 affinity = cpu_online_mask;
124                 brokeaff = true;
125         }

However, there is a corner case. Although some CPUs in
pending_mask/affinity_mask are still online, they are lack of available
vectors. If the kernel continues calling irq_do_set_affinity() with those CPUs,
there will be -ENOSPC error.

This is not reasonable as other online CPUs still have many available vectors.

name:   VECTOR
 size:   0
 mapped: 529
 flags:  0x00000103
Online bitmaps:        7
Global available:    884
Global reserved:       6
Total allocated:     539
System: 36: 0-19,21,50,128,236,243-244,246-255
 | CPU | avl | man | mac | act | vectors
     0   147     0     0   55  32-49,51-87
     1   147     0     0   55  32-49,51-87
     2     0     0     0  202  32-49,51-127,129-235
     4   147     0     0   55  32-49,51-87
     5   147     0     0   55  32-49,51-87
     6   148     0     0   54  32-49,51-86
     7   148     0     0   54  32-49,51-86

This issue should not happen for managed IRQs because the vectors are already
reserved before CPU hotplug. For regular IRQs, do a re-try with all online
CPUs if the prior irq_do_set_affinity() is failed with -ENOSPC.

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/irq/cpuhotplug.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..d1666a6b73f4 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -130,6 +130,19 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * CPU.
 	 */
 	err = irq_do_set_affinity(d, affinity, false);
+
+	if (err == -ENOSPC &&
+	    !irqd_affinity_is_managed(d) &&
+	    affinity != cpu_online_mask) {
+		affinity = cpu_online_mask;
+		brokeaff = true;
+
+		pr_debug("IRQ%u: set affinity failed for %*pbl, re-try with all online CPUs\n",
+			 d->irq, cpumask_pr_args(affinity));
+
+		err = irq_do_set_affinity(d, affinity, false);
+	}
+
 	if (err) {
 		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
 				    d->irq, err);
-- 
2.34.1


