Return-Path: <linux-kernel+bounces-76526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7372E85F86D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C81282DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5212EBD4;
	Thu, 22 Feb 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+3Fu8tM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pu0k5kAn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEC12E1CD;
	Thu, 22 Feb 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605710; cv=fail; b=bKyt2JjqUOttDF64eLJdtLFPGtU8sGZQKFERUvOlcI3MybREYt0XEuRCuLEUw/2kuURdOSe8ndBfmbr7ibK6du1EGFdgpfpOi6GK1bGM+y2oHp2Evxn0H9w3Dp9VAA88JTwUhKuGspMSDOMYOxC09PK7i8fUmHcWcNMCGgvBMBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605710; c=relaxed/simple;
	bh=tLTYL1Qvofyo61nlWnzU/7C0XYYEpPQ7mF23uhcKdgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cRbcsV9VL4qQp6TAjK6zcpc6lWGZ7qfGUJqy7Xq0fG9FbbbZRV6tonXAEeH8c4sN4hq6ZvBO8vmKcLo1uT/cmaEyRv5uLfqFHuiCqPYYezbzpELQvvvz2IHuqH1XIl3wlTyjmT1d7g2Xv2kJatxVL6CtOnaXp6AHdXp7kL4rwCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T+3Fu8tM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pu0k5kAn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MBowBR029148;
	Thu, 22 Feb 2024 12:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mt7evFhgJjYfZ7KIYilCRV1fZKGiYmHSToToM/z+h5E=;
 b=T+3Fu8tM39mGDwmntDCuJ4X5jE2stu3K75PhInVsCttKLoEaoJWISmR0IVduJH2rLd7S
 YHuXDwmoZbBxnW+1kXHdAZ0kO9fKoG+LAxBHe/2Ve9mD69zSiXpUKtvEB5zwfoPGmXny
 dZYCLci8GBJfzKSV5h2lBmj48ZgydHn4lhMPWFgNTv5owKzhuXI7ocSCFDl6PNHEHcKE
 e8eOrcAUZhgakchIRkkLfVd4g/XvpeMj0ZzqVxgYF9ZdeTeVx/bDUNRqB/JfArBtQfC7
 LI8f589RN8sbdnEqeapqeszdJd2XXNLOmigPj9lnXnSi0dq22IcIkevdPSctqP7DVGWB cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk44m4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 12:41:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MB6XmO012786;
	Thu, 22 Feb 2024 12:41:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8ayjfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 12:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiZl/z8lBqrPlEBgMp1g9pLM5nwV2USRgUTzgi1/SA6SqQ/5IogVl7nHmZHY+d/YnIWaA0j8idjowpr5Wx+VVNhIPjAt+Rp9BAg/0YH9gTgM2rzRLB7BBOUgq6tl6sA7Rm6xQPsuPbqPnTRMwJCpgoPrZEOAjv6HApPoa2MWPZqP4EYFhksd1kj/Q8jJWyZQEfZvPMbbxSs8IRDMMe5JMR9/v/zzRxV/QqBd+QZaadG3Q8e5YXXPWLIjky7RqW7jVYS2gEh8fJ+ib1jUiKGelvk1prMi7IV7L+YP/puicrizmYXyN52fJpJoYVokbSNbHSsH8hDCFy3dshGaKP9OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt7evFhgJjYfZ7KIYilCRV1fZKGiYmHSToToM/z+h5E=;
 b=fttyRlfSleCqe2oVhteVP98ef9dEryjZRgqZwUF9XHXKH9HUvEz4CAUp7Ncnwe1Zu4iHNbpp/Dl0m9EWiI8YfLcSPSruTipWlbyxuYk7dEjA8EXUrHTc11bOAHtuD9vIvaknFYjRFvYeVyCMNrLp15x+6h6WAeaahxYW+TtlzCcT3rwDwnsgTQEjRwgPwYL/8NuiZWywUYWSUTQz/zkSU53FI5mc6b8ubQfuVrqW5wySZ37WlFK02pCu8AQF5rRA0N71DsgbP5Af6ubZ1P7sEeh877HY/22ug9X88BLTZFO4V7Zk8hDPedtVQcvEw6rQVt9pBmGyCX17qFdsGYKjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt7evFhgJjYfZ7KIYilCRV1fZKGiYmHSToToM/z+h5E=;
 b=Pu0k5kAnLOkbvHQ8ytl2YK7coazAJmwQH8Ssoj8VgbMb3ScLm17CxNgSZ2yUPDmLZMQJsxFSmXWwy2IwTGJ855prZminNWP+pG5QALRkL0hbCZ52MBRM+W9Wu9JPIuil/eufMKmRfror5Lc7FS2guhyNHPrCgReAUi+dvvM++DQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7344.namprd10.prod.outlook.com (2603:10b6:8:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 12:41:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 12:41:19 +0000
Message-ID: <d765d2c5-3451-4519-a5e1-9e8f28dcd6b3@oracle.com>
Date: Thu, 22 Feb 2024 12:41:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
To: Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240221073159.29408-1-yangxingui@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240221073159.29408-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: d08f0169-ac98-4e76-69dd-08dc33a39181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YO7o7x/TuoOO5KIZ6lG3MjRVTWBJGjZFdMX3b8RSuDkzyJBqjYxd0rowFXJZPYPCdUTzfyfXOHZeO4maK1zfSzkeEIvDp6dcQr6vZpFLtDqf3nhLEkyhaNdCExkUZS7tAOhHSuf3smpTqhOxSbBUCYBK5c8/c9jLetkcPxuwy3VW42EmE+74YaFCIIY/ubO3f/sKCXpFc+JHgfMJT3ssL5IG/Uyjm3cIYIojNTrRIOyskNkClsHCTvncY1N/87WMIQ/12g/Fhyl4tJjOlSakFEX6DLhqJwrtxi2ENZeNeaxxpOfj+8hDRhxoM2EAZNiJOQZbINr6eHqDlzRcFsJEBjOK4K0lTAtbhm9eSWqc6PJc/AWB3nuSO8bQ0pjZ2Wk+VZgmdozwR9tw6ZIw/jygYjCY0VRyal8UWS82C95KBfqWqoAxjVbboJKxYgOBypu82czZb7gVCsyDEDC0VAQ25QMILhoQx4zIboKzOh1Qw6GevNq61wt7PFpr0ERr7/THSNcXs96D2rhbECfqdpR5QOlsRw+8e/njqLE7lWSAoGo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjFwQ05jKzRmRmRKNmVMa3hrVVBhWXp1K05pYkc3WlozMjFiR2xWV1lJTFBa?=
 =?utf-8?B?eFRHYlZWanJ2cGlWQjVwdExiNUg4TVZRQlBBUDR3SW1vT3QvU2xVRlYzUVdl?=
 =?utf-8?B?S3BoOS9Ka1VGY2JCVWdQUDNyOGNpdzQyZTdJcGxPRXlHTS80MUx6eGpRRXJ1?=
 =?utf-8?B?bXgzazI3TnEvZ01xZFlpNStqRGNRYUZsYjlTcEoreXE5YXd6K29qNHJoOU9t?=
 =?utf-8?B?SDN0U0U1S2hCRnRyNzJJWVNPT2lLaTlRRXJ0dDdUcjdxZ2Z0OFI5UDlxQUJh?=
 =?utf-8?B?ejBMUkYwemlLejZyNWtZOFp0TTEzYytuNnkzUDMvOHMxZVU4STg0VWJyQWVh?=
 =?utf-8?B?U3VYSm5PdUlyL3VqU0lPTlRta3dKVkcrTkJNU0ZpR3FwVno0ekxEa3FOcU9s?=
 =?utf-8?B?YVdoSUV5cE0xRmZYUlNuMmZxcitHQVFyZStkMnNZTXZvd3Arb1dqTXpHRUNa?=
 =?utf-8?B?REtGK212clBNaXR6cmJENXNSWmlSalFIckd4UGhseGdrdGRsMVJ6andlRjhy?=
 =?utf-8?B?RUUvQzRKYldWb2VUcmhCMW1EMS9wZFJHMkZJSUpCdDNzUzFiaUozdysrZUhw?=
 =?utf-8?B?dDB0LzV0YWRUN052RGJ5VW1qRmZRMmlhRWJtVDl2eC9vbkdVWk9LNHBTSXF6?=
 =?utf-8?B?cVdwc0djWldQdENSb04rZEkzbG5JYlg1YWNDc0hGKzNpdUljNE85bnYvQ0hR?=
 =?utf-8?B?L3NIdnRuaGhGNGhqYmtaVjVxSWhKR2hZcHdKNWc2UFlUUjVrVUFYbEtzMits?=
 =?utf-8?B?alNMN3NDdmRSZm5Ncy9UTHdtSkhrSlo2QjYxeExUdnh3NlNyR2FCMHNxWHRv?=
 =?utf-8?B?Q1FJM0VpM253WGtOMkFKaEMvMWxJUWlrY0pSQUFCRnpjVitUbGE5cys2RjJK?=
 =?utf-8?B?aU1iaGF5dFFTREl0ZFVJcURFY1E2QmcvTnlWSFh0QkNIRGYvaWpYQllCREwv?=
 =?utf-8?B?UWtwc2h4TndBVG9zNlExN2ZWOVRJdFhubFJNaVpjaUNLam95bFFwUnNuTVhm?=
 =?utf-8?B?cVJQc3ZVUU93b1VGRkcvNDlMNDZ3azdzMFYrUUx2TGFNMnR3Y29Jcm9SWjBs?=
 =?utf-8?B?TFVSQzg2NTFWMmRNSEdhR3A3bEhLc1FvUDd3dlJrYUxCNFMwbzRjWVdrdnB3?=
 =?utf-8?B?cHkrZVp5NUNsQ1p4VkJGL1NsNkpFQXJQM0FNSjUvcGozNlJXWGhDeGxvaWs2?=
 =?utf-8?B?L1JZajZYR1YveXBFclJEQzhIWkxHalJtTWF3bm9ic0ZnamZveHBUQUppWWlI?=
 =?utf-8?B?SDVGNW9iNGNpeXBDS3VHVnhpU1RjVS84MVFRUE5WSHRIdlZQTWJvUWZtYzFJ?=
 =?utf-8?B?U0ppenVMK0ZRZXhvMkxpVHhPWGRBNExSQWZTKzBFM1FhZDh3ZUxNbTNYNnEz?=
 =?utf-8?B?eVlGcUwrM2tkckVmNS9SUlZVcFZjeno1K1VxOGRzWHB5VG91MS9INHIzNmtq?=
 =?utf-8?B?NWZHclh4WFpHODZtMVVNZWpFN0c0a0FudHZuS2tNMUFoN2VZV2J6SGVBODRG?=
 =?utf-8?B?VlM5TkRUcDdmV1pjTzlEMk1NQ20wRnpjcmhlK3Q2aGI1OExOaUFOYUhOOEpB?=
 =?utf-8?B?dDJFMmt4WUxlQmJ3SWpVMTBGeXZFdVJweVdLNk8xSkFROGxuUEdGc0NWN1Y3?=
 =?utf-8?B?L0gzQmp2VEZkeGxOSkpjaDNXYlVFY0ZCTng5bTVuWXlIMm9qbjdBai8zakNm?=
 =?utf-8?B?ZkpQUG05R1BESFJKRE5reC9VeDRjejZnRHh2bDVjckhYL2RsM2psTjRCeUhq?=
 =?utf-8?B?TUwrLzl5Y1pQbHJXWDlhMk42QmNQbmJ6bGtEaEFyZG40dzQyK2NhQ2s0dzF3?=
 =?utf-8?B?eU1OMCs0MlRqRk8wT2dRRWlyQVBVbGVHazhkZHpLelBDVkdPZ2ZGazhoWUlR?=
 =?utf-8?B?QnM4NE4rbGRUcGp3SU44UGNOQ0JseC9VUks2QmNUcnVvUk5tSGRheCs2TXFG?=
 =?utf-8?B?bTR4NHFQTHdMV1JXMFFkOU94eHdzaEt5aks2U3ZncVdIRUpYUFFzTjNKUUFW?=
 =?utf-8?B?bW80QTVYTytYTkxrcmpiRWNNbWI4Ujk2L0FJSHN3NjhCbk11c0FiV2EvMUY0?=
 =?utf-8?B?Zjk3aGpleFZGQWl2VmFqazUvbExqSndJOCtiWXJUUnBWQTIyZjhXK1JqTm1T?=
 =?utf-8?Q?ZoUnS0zgS0FBh68IpHSHqi3V2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iq35pUpsk0fu54JfHrpd4mzA504/yd4JAuboj5jMHonPlTag3f8HzYx7HyQNVcOsV0zn7u/yb6H/Ei4/g8C0WIUPehuTS1K+xR3u8o7pk6zOYdbqK4V3nexIpKZ8r/Y/A8BSRLFaRsaljC08o453fYKN8q/x4Z6DVvLlTbp2c5fi0026kscPPGdStkszxd0/LfPuk6sLC9pZuibIqcW4V5t3ZG9S38bv6rtalkdpSWL0YwSg5zIbuIvTg4MxfraC+BKL4sJ4nC3CEiKiAEaRsi9z1urX1iesX+Zx/HIrB+F3vdPQi7dZKmknzp2hVrKRkFUs7mEDp+gEVlR/ef2Wp8sNYG6O+DgGutoTqVsiMs8SbHtFVj6jSBLAuSnAuz9CAK9joYOzuJwoPCDxranUfKlp4gcf+HhVUXjykUzNpVNBoQsv0Efs1QCZFe65PSL3bSOjMzACQARdqSlD6GOnrcuVQEg7QaYMM8jcWJNJ7KU+PPYBuWL1ISq7IaXOZdPMCEJwCu6Br64vFiLVZgPg6C0MONQKUb9rB1KwQYTSrKONlJB3No0L2zIrczRQjLrVCBWCKYyXslKwO2At56qipMDmGRA3gXZjMeBxI19w5hQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08f0169-ac98-4e76-69dd-08dc33a39181
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 12:41:19.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRKSxLYJd3rQ39XjMZLelrL7c5S2CCPqY4OrnoL0fOQkEtawJl7AkHC/O2kbgO3Ykr2ZBQEfFfhUrdsBuXwtZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220101
X-Proofpoint-ORIG-GUID: -OdW4M-JGrMw5vIY_J4GceUX2PoLRhe-
X-Proofpoint-GUID: -OdW4M-JGrMw5vIY_J4GceUX2PoLRhe-

On 21/02/2024 07:31, Xingui Yang wrote:
> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
> update PHY info"), do discovery will send a new SMP_DISCOVER and update
> phy->phy_change_count. We found that if the disk is reconnected and phy
> change_count changes at this time, the disk scanning process will not be
> triggered.
> 
> So update the PHY info with the last query results.
> 
> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>   drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..9563f5589948 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
>   		if (*type == 0)
>   			memset(sas_addr, 0, SAS_ADDR_SIZE);
>   	}
> +
> +	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))
> +		sas_set_ex_phy(dev, phy_id, disc_resp);
> +
>   	kfree(disc_resp);
>   	return res;
>   }
> @@ -1972,11 +1976,6 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
>   	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
>   		phy->phy_state = PHY_EMPTY;
>   		sas_unregister_devs_sas_addr(dev, phy_id, last);
> -		/*
> -		 * Even though the PHY is empty, for convenience we discover
> -		 * the PHY to update the PHY info, like negotiated linkrate.
> -		 */
> -		sas_ex_phy_discover(dev, phy_id);

It would be nice to be able to call sas_set_ex_phy() here (instead of 
sas_get_phy_attached_dev()), but I assume that you can't do that as the 
disc_resp memory is not available.

If we were to manually set the PHY info here instead, how would that look?

Thanks,
John


>   		return res;
>   	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
>   		   dev_type_flutter(type, phy->attached_dev_type)) {


