Return-Path: <linux-kernel+bounces-82587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3AE8686C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018FC286D61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4386C11CBA;
	Tue, 27 Feb 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k2ITMw9G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SocKFCns"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D171096F;
	Tue, 27 Feb 2024 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000379; cv=fail; b=aOE+QCh66PlKZDft9y3mRNWRUil5wCc9ChOPAFORSSP//uii+SzF/BvEkE2qZc3KlJW0jBBbHYi8J+E8LFT1V5VCXEmiG1q4qn3gEX9qhsTRhA3UAsZvuNVzf35H0wT9qW4gNx9toggT4f9kYTMWg1z11GPxBq6vJuKv8Tc+9fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000379; c=relaxed/simple;
	bh=JbahsUD6yEmNYJsTDMjfcusRgX3eTjWUuHApZJ9iJrg=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=irZR/P1fWytg+JwgAulUEuhPLAl5+KxUE/jahXasUvgx7G1D1CohsCOKFDOq71nWGJSOEyWk3sIM+UF94FaqBY2Wnp1MbYwd2jOv7vY3gYGZv++aPvu4NSOAHRE6KlDziXVepOBglRzocNzHgpzaWivHQWiFWefQhIremq/eHSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k2ITMw9G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SocKFCns; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1EZPJ011156;
	Tue, 27 Feb 2024 02:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XPGs3Sn1qiwZcAyoi84X3udHTxbHRx8K0M/0ye6exjw=;
 b=k2ITMw9GIP3E/j1YeiaI1yKBh4OJ8n/C7FXlo2aL4QMrZ1XoShqLyuDPMIGBMGgQbMRU
 qv3imhkyyJvGuNuABLvu/1cjOKG39k/JHsGF/aB6KpNQ6FVXKp3TYeunxHfYG8IWu4n4
 YjJAhRcWX+zLTgN7k49xqRMr7WhIGHgJWeXOJtdH8m5silfpdsZJyA2MoYyjHER+41v9
 Ca6mLYlHHERLEzaPmlLTWBjy9Qy6gpKC02TDTBDy/lhpgIa8UVjc9/J34kvPbGWFVTao
 PkiL+uu88477SsUZk0ukvK1enJAJbsEpSN5th1wbChEhr1irPH4v1uiRwVvLJ6zrFQYo Ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gde5bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:19:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0OGSj015456;
	Tue, 27 Feb 2024 02:19:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w6qfjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMa1ZLWiD73isLsZKgg2mRyORo52iL+w6C/T8mAj0PXu3CADPAZj5BksvzQFLTu+h4WCI34PdUcEhqL0KGli5mxpzvfbver/FhlVp41sq6qT/n8UFQEnaxk33Pn+QAMkr1Reb38oCxuEZIPD15r1i5USpiR0VALwQgZ3M7jJeH94ixUpcKjm0+KKBC+K8B9vLHu4CkWnNHFVhJ9KBEXsSY7uLBpA9MiXgAlcZpYCkmia13YL4QZairwjbIwudl/VZ1hVXBHcTF4QO5xLcMioFWGgahWCQvVwgb8mjpciUQbaKlxz4HAiEX43JLxxbfd+PuUP9cKKq2Rm0wyrL2RIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPGs3Sn1qiwZcAyoi84X3udHTxbHRx8K0M/0ye6exjw=;
 b=MCA2yK5/8kfU3NHx/HzYpiUhM+qfloO+noK3vThLqZu4QkNufC5aRjWNYat3CoYM26gZyZbqNDs/Jdrwe1WUYxLt6Dw06bT7NV9HyzZ7WXRnoJgbvl0ZH9QScXqzH3P9NaIM/v7fgLYD8ZYrH68sV65jACZ2ndFPT/3msk11g6etl12dYL1tIJ3vFuGIsmU7/QqbhwB/MVmC4nUbjpKKJgAGp7ry+ngJsDhqB+dmiU35rzbdegnqzK0eib97/zO6949XFP35iJ0EutOe6tKiDZOVyg5JoPTXkTm/YnTUQ/xCEh/DGZtJ/voI5rgxFg5RTuGdOMYMyHre4YKUl6EoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPGs3Sn1qiwZcAyoi84X3udHTxbHRx8K0M/0ye6exjw=;
 b=SocKFCnsFChC0rAnm0dyMnjV2f80tBepUM53DwsAP0pmNXZpgqzEEi8T23HAa/kxGGYU/qIisSnCU14goonw2bnGO3CHNreESryKW0shckBITVvmm2928E5CrqssKMAH9pOHly5lWiaYT1q8c7Ey4ZKYpz5YKa1qv7Cso+xIlF0=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 02:19:28 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 02:19:28 +0000
To: Justin Stitt <justinstitt@google.com>
Cc: James Smart <james.smart@broadcom.com>,
        Dick Kennedy
 <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: lpfc: replace deprecated strncpy with strscpy
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15xya644v.fsf@ca-mkp.ca.oracle.com>
References: <20240226-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v2-1-2df2e46569b9@google.com>
Date: Mon, 26 Feb 2024 21:19:26 -0500
In-Reply-To: <20240226-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v2-1-2df2e46569b9@google.com>
	(Justin Stitt's message of "Mon, 26 Feb 2024 23:53:44 +0000")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:208:e8::47) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|BY5PR10MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 713743f1-0e19-4d53-8dd9-08dc373a8660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2MDzKcRLL8eerWDl6CYXAOlb7bY+qcnVa3UrpYf7r6XvyRLw3kKNkGC+ahk8bsNT3Ryijaj6f1pw9hI0dwIoFLMGmrNhLx4CohFVOH9Ot6JpY5L1eDk0eYINLsnnCVrsjtLvQJgPlsGl0AsirQYM8adBNOnPbH7Bcw2WR34wWj6fyp0SlOtJk8xCZn45iyFzdOEvmZMbClHLTw/dW73J7VaWB3Y3TH4texJLjLDvy06fp+yESXGxbEZXjvU/K8KTqnG6xvH3G5t8oMCQUoNChm63X7verfFomU4Khhl8YwYsP6yP+2LyVxqVcuOHDffTJ54AeDI8mK+mcXeyoeSQB3C1ARsiUgFsUZwCIO/9NNBt5bmBHvFjV/5JG39i/amkra/IAPV7luyKuU2i53T5QGq6khLHKsc0UJU5ELw9U4ghEFHd4DBdQ7cSrGnLXWCUf3GqqRhY/6NDzSaPQEX0u3Je9+iuXyOl8fHTshEBznOYyWO8LPFcAdvh17Suj7s9CFhF/HT6p/lD6p5dcfGUX8FT8FgtR9SZausxjl38Of6KEg4jwjgy7bIE5gtQUNmjMv4mjUdicH9AJI6G+1N4YWhTfdVH4ttb7HIVl0zo1H1n4CQtKwG/Edx1WSLVo+URTxapN6a0Xf2Uqh6oKfuEGw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QvVCG90bakqiB2+N6pn33FDmkja1XAojR85i+5tff1U6OJ04wItKpel2J5zi?=
 =?us-ascii?Q?yyxnFdpG2pT92iivDaV/XP0Vb3D5sq1dFVKkaixnkAhuK2HfN6NY7rytQ/QY?=
 =?us-ascii?Q?gpfcz+1N1qyTjuQ06yCXtcffR/b6i+FBDpc3OxZ/bsWcFMGFUTIxVUQAMzFg?=
 =?us-ascii?Q?jZkZAQJteOwWJru7G2Gt+LC2es0zv4r6aVW5wHibQHraDtinpenShOzCZQhe?=
 =?us-ascii?Q?v19qp3A2G/xdZ8tdYYc+mSEmTZvxRS31RESxP6YrpcTWnhMmt+53i+lolYkM?=
 =?us-ascii?Q?JSyVZ6OlL+Mmam/UzlvpFzDXi0EpxSEszIA0+4L9b20g7bhEjpC2jAA/a+LI?=
 =?us-ascii?Q?Me0GCXv5QH91lKa6y2vvrQRr9+iHVGJ7ljexqeEx9YvYKbbOr+gks5NQD0tS?=
 =?us-ascii?Q?I8YARVXwhuMY/Mn3AkyYsT4uuHNn3Rp9bf2qg4Sy9HKR1GglJb/UU8G4cT1N?=
 =?us-ascii?Q?/8BmFvLkViskUirzeXJkJZqf4Nt+8uWfsVZ9re8ZZr/YmJ4i5r2K21gQVT3b?=
 =?us-ascii?Q?Nu+OKDucjSAZCFNrA+ihgvaRKTg5MFa02zW87eDi2PXmORspLpB8PHdxoEyW?=
 =?us-ascii?Q?O4Oj6wYEwAYuqCKr8Zud1JjC2lfiDAlsFbLpu15sPckw+cnIGa84efehE3Cz?=
 =?us-ascii?Q?nk2D5CL5oc3CN0cnCd6OHPa1LLIOhiKizsfE9I9bsHoaIGX3lXBhK1+VmKAY?=
 =?us-ascii?Q?wVLi5YNF41TXuR3/5bc0ZelwdalMq2qPD0DM+8SYAv/F26SoxaQan++fpLA4?=
 =?us-ascii?Q?/cCP8QzQB/WbNQQ0P0tIy9Tm0duV/E939fSAH9MFFQHmpgc1K5+1nJrJ5cJ9?=
 =?us-ascii?Q?60F8P0GI2iTUC/ySZc7wCIAY2Hc4emOM1q8IoQ/DjoMhg/7f2c8ePT8qGE8K?=
 =?us-ascii?Q?LnzaRVssKqenhkRHQHsvYal+ye9hJem0j54PBgukGT8joyovOAFxKOFRw9ZC?=
 =?us-ascii?Q?2Rr7MoIQWg4Q1cNm87cKbko+jrfqeMmRMt4wba93I2uU6coGxt81wN4kA3rC?=
 =?us-ascii?Q?W4ERs9cJ7zKnAc/XhTxxrgxfYdGeCaMRzh2IyMOP1Q7vlpFxT8uim/F8yn/v?=
 =?us-ascii?Q?Y05l33Yl4Gjqa1GkbiBPsrDgYWsTMfWeaicVvGHRT75Mp23pA0IlOAWRmrpz?=
 =?us-ascii?Q?F+j/MTTzR7aN5oqNA7th57FXEtPNdAY9hqc45Hn6YHsPgiB1107t73VRqbcp?=
 =?us-ascii?Q?hUbtLp2l0l4B6WMZXfD0KoseRkVH+DstbI/cGH74DOKGq/gJgEh9eed3RvZO?=
 =?us-ascii?Q?3hfwJZBqS6zUMSU6Yz3f8dlhV+SOcUPq9ZbozwqC4zNVXS5AbOCup0Te4Lj5?=
 =?us-ascii?Q?a8XXis4FJ9UBtkdKb9kVxQbeMyhu+26U9GIlBghz9ZZzNIssNNP98h80NhU0?=
 =?us-ascii?Q?yWOgnAe56j2OFKJENJD8SGo0/2dxkyBifRvyZSseeWz6ySa4+3K32BoSmSnz?=
 =?us-ascii?Q?CcetfCzk/7Yju54E9llIxEGGMyykqUh/15waDAcWJ/bW/N7b+kLo9oiaQdOj?=
 =?us-ascii?Q?qRP1DAYMSBKpmV2NrXDaF+joKxR5knNdXKqJMKs2Z56h8fdw9f8SnccUtETD?=
 =?us-ascii?Q?1HigVDuFLNpGWusUAV/zSbqCVevFB4pKqM1uP763wexqpcMGwRPn5E4WkgZa?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	I+fRjcPKvBXus/lrJRtCInTxAakm+q5bQbeqtjmi3fcrJCC5Bn9Bk9cLKIrXPhOHYMlFBjqjx1aILUYi2To8KfbH9b+VaB6kV9UoL5KaVQMY9P97ig8Wo3Tt7fTXmQwHR9neTOZoRwxE2bA+CIc7DcN2O818+fD9XRZAe8YM0bvpmIie1/5wePyfoXPBer1IVRARhsqY+AhKb+gommeznh2I2HxbgJOIeN79rWJwQgrT+CBj5mU3OumF7jZgG1hAb1LApdovg+UYWKo7IZuw7x6pUFGwYe/7e47wbJf1yEyU9Jl9yxCXroMO6a2DqpjqtwI1SkGMmygk6T4iShQjeWsJpD/XHEI46YwanyRRRaILJJfhOB/Y8MiCHz8s1xoz1L0jyM2ZJ13FRj505jVJcTiVR14L46+PHF4zFyARhxokkMHqNOHtvGPjAvA26BlmP5WmQUDbVj6l50FKbVLvrAEX2XWO+oqasDNoNP7eFsHSVmfrJS8suFrU+KpB7ti151Q4O5ZinNBp/G4skwZ1sHK6KvXmfWC3oXS49KTtw0cbENW3NkVF6N/VlAZzxzLGH1PpBG9ygueLb1huWb9ZAm50RVbrc0ZQ4GXlPFrtf64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713743f1-0e19-4d53-8dd9-08dc373a8660
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 02:19:28.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKzjSHGoeHFgNlSoqq7JDcbHNOUdw4YUnnwWzYOqYxlbydZJrWw9lPGyhTHLAWU6rRebDFRxp3eNqXOguVvKiiY5TVn13WpC8OMQvE4Lch4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=934 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270017
X-Proofpoint-ORIG-GUID: DECzT5IznMmxT8kdBOpRIPjcD-MqzFIn
X-Proofpoint-GUID: DECzT5IznMmxT8kdBOpRIPjcD-MqzFIn


Justin,

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

