Return-Path: <linux-kernel+bounces-29423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50C830E06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54E91C2163E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A2286BD;
	Wed, 17 Jan 2024 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YYrXUhg3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nrra2rpK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9825636
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523512; cv=fail; b=l3t5cOAfJ5S0RRnIEURt66OFs2H5XSz1vCz+P4Gh2j4f56jnfp/MUd9X5yOH8AqVRG8ivS4IWPPcBLqIgu/UEdWWkUw8+PwITDhOTijD9FqQEZKGmo0a+IRqMqUJvBt6mWfo6TEJ4zeT1WF/ZuREzh+ecGofg+Y4+zzmQWCX3J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523512; c=relaxed/simple;
	bh=kP6ynY/2c4k8TxkLwfBz/BpkEGAJO5AEZDU0YOcABMM=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=LK5X0y7ltWdIlzWEcoA8B8YWN3j2Pr5Kznpa+ePRfq7YTi33Qc5mcYeCH0icDQDYagtNPHWlIYjTKufEZzrRLxqq715JhhxEXj0F6i4oFxigzAExGp6chz6Hy3FKfLretz2qBO5SAdQF+vQW4XprZ3wQb1O/766N7jZOHNnqjO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YYrXUhg3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nrra2rpK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJdKJd023672;
	Wed, 17 Jan 2024 20:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hw6mkFrlYDrwrCKBBHWlgkFBCuHlwxfnZTyFpQCKCEc=;
 b=YYrXUhg3vVSwAU8xM2shKS1bjLYIAWCz6+oDrt/meklJ50OR8QbgJ5PIg2euuk7iXAx/
 D18JKHvwbCn5JcUxL3I543DI4DCDUiov74fcr8UFDf83vECzLht8l2/aAg4F+zOvQxXS
 BNG+q5CBVOLSjMlZUtFhbXIYd0P/Io2DoWLJcXOcGgWfmctVhqrKuu8wMm2a4MBEhpiu
 HPe7jRbYk+Sz4X7gW8PMGtsfwaq2EoSO+LeAFhMzTZXTZfZTqNI7srJAWYu5SG3zRK54
 IBobeVwgrwbiLPy9/o6kCbE18FF9vPh9fKGyIrzonP4VPwUGU0QNfsEp2jOcf6D4LHAL 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3h0p03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:31:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJeWUe009544;
	Wed, 17 Jan 2024 20:31:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb2dxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECtZUiHsi8VaUtLFX7rzlZtCMNNfY66gQXoybS1fJ4bzFrqh63/L3N6LSA53ZtjW85sChnwdmLlta+4seMJnqKa2rKCurWOGS/ZpweyR5oWq124sbgsKOJ1nv29kVN5JGJu27oRaZZLe0aN8ow1/5s65X3lEK1xTNx8ue7d0dqM3CuMjNC+VbgbB2maVU+4lpW/nS1BN4hl+EKxVAlohsRxb94qPgFKohPfcInCEqjkmv50TxopoTUh80XlUqEHyGsnKKyPcrmozxpRDB1tIkLPVFhkh8AEIzsMB82Ko/wu6SSU+y9ksVGTVQVkj6RzBDieR1aHWP+hOpZmng2XNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw6mkFrlYDrwrCKBBHWlgkFBCuHlwxfnZTyFpQCKCEc=;
 b=ib82QIu4WIXqnOSo9Jl/WzeuChnKzAffgrV2rLE1zi44CzpAiUAoncefCKahHVGgonPGLeeHvNZSxM6PvWW8XH6SODeuPFO0jun0NMfTuAN6kvN+xvumR2cd2G3wBYdgjCVzcVbRixXUZZ2lY7zF0KmHMZPJMEqPBREYemA5XVwmALqj5V11XJCjm/kfcyYEj0jbMsvRyywEYXHJBL5rwGVew4xswy0weIRZB8moiBz67pVzIo+qyhB+y6Y8DmYNqR9TD3smTkxE4EQZVsRE+CLDS3cL9/P0eaRFpK99hwdblvaDHvZ8i8O4h53P23IRHsYQfI9XpnewlOO/h8KNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw6mkFrlYDrwrCKBBHWlgkFBCuHlwxfnZTyFpQCKCEc=;
 b=nrra2rpK9vFK8YOhehxrP/5bpv18p2WC3qQisXJ7sbwwgdRgsLazXavtrUbt4BeQ5tJNoPfPm2RID94zTDvCLb8u4jXLwnhIOpYR75SPJuN176PxVwyuW7tR0mVcYKBN1tgKlKW3D3XXNDCwbTh7EOk1k10SuNCsXF/cVBhbKNE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 20:31:32 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 20:31:30 +0000
Message-ID: <700fc2e5-445d-46c4-bdde-0dd29bcdb2bc@oracle.com>
Date: Wed, 17 Jan 2024 15:31:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 05/13] vhost-vdpa: VHOST_IOTLB_REMAP
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea
 <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEsCzLNdRXu25tzhrnTVatM6pHwVXVUn7kE=3erVWQUL4g@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsCzLNdRXu25tzhrnTVatM6pHwVXVUn7kE=3erVWQUL4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: b9460590-e483-4a3f-063f-08dc179b498c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X0yee7sFURF/wQhJGd/eul1DB7SWw+wX/Lqq8cHuM3Gj6uCh3Hcv4TfAqFhPkO2e4WUddUKgs4cTmz2phZuig4F71TM8gyH8Pwc9Zk65DrW0O71SywBnlAuxBVHkfuL/tBPOR7TZKYbROvNei1W+AzEkrk+oPlmBe/QeHEYlR5kXwfbPNCbuX/wZIENlY2m+h4xN/wzf5GLdhomX+dO1ctpJxFbG8bIicPnnHx7u/TSbH2DhQCjfaXhk01edcJMykvbqaP5g31cWoAl0kz7E1sAqw/IjUkLTFetbZAfhClyWLhynlkMvv0638lNpUunP5qXXg0ZmGVCXppakIozp/rrEge+8TunJh19syRrVHSqhAdOUKZG/dB2Y8/uyqdWS7ixyKYce2kij2U1DJiHla0QdYqrohHxRCCT7o/kgPwqXlRZoBu/zgsDvkUp9I4yadZecimWp/AkN674DlKaH20tMvoF9Hog0b9q4Jelo26KEXTEMPI3D4VlXq1f/oZhPuNZrsVXyGQfCwZecOeN59srOwEeWq8KBcAF3wWYZGuwvS5Cc7KBwj1pDb18ndMkcQnDc07hh1q9OyJtctZVtI8bwy+VFpt3eeVj6+1YP8zK+ITcU4G+wfb7EiBSlvNdveuU6381durwh+2hmXjk0mg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(8936002)(4326008)(31696002)(5660300002)(8676002)(316002)(6916009)(86362001)(6486002)(66946007)(66476007)(66556008)(36756003)(478600001)(26005)(6666004)(53546011)(6512007)(54906003)(2906002)(36916002)(2616005)(6506007)(83380400001)(38100700002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SW9nWjB1RHhneWNoWlRpc1ZheHYxSzJsT2FxTmtia0dvRVFPbU9jUnlESnZB?=
 =?utf-8?B?cUs2TXI3NGRvd09SajYyM2txV1ZldzNKY1dvSDF6RW00eTZ2ZjJiTEt2V21I?=
 =?utf-8?B?a0dzeHp3OUVkbHAreWlQNUo3OCtpajh2SE5GWnRyNkFZeTdGVHVXR1g0Z2I4?=
 =?utf-8?B?emw3dE1PNFhZYlJXSjFUQzZnaDZzaitZUENiUFlIS2Rnam5xaGc0ZmVIak9z?=
 =?utf-8?B?KzZGOFl1d1ZoNWYzdjBwZWhaQlVvaTN4d25wNHNUT1pZVUxXU0xpdEI2NDlp?=
 =?utf-8?B?OStES1l0MVQ4eDZUYlJkekpyUGgwenVDa1AwKzBXVjE0L0ZxbTFDWnV0OTA4?=
 =?utf-8?B?bDUxN05Gb0dEbklUK1dGTFlBdjJBTkwzbldwditNdXI3UW95Y2pRSHZDL3p0?=
 =?utf-8?B?MEpVZGs2dEJNdlNhZGVPUlFFWDdONVRkNEtLNitjTnJuT1hHT1ptbkxNRFJj?=
 =?utf-8?B?NFJRTGVGU1FJSGhCNnVKYkp2Misvbk8wK3ZpY2NXRDgvS0hRWUpyeC83ZU9r?=
 =?utf-8?B?eGdlUDZYRmhMT3lpMVRZaDVCK0hvNi9nbEtuQzI2SHZVSjRIN3ZDb042Zyty?=
 =?utf-8?B?bjJ2clo0NTJURjJqWlQwWUZqd3FhaFlLYWlrN3FKYVVJTmEzVUN1YkJUbzVD?=
 =?utf-8?B?Y3pudkJWTGprcU5KYUNQaG55ZnhzUFFCVmYvcnlEQVRkNkcrRkdsaW5wQXV2?=
 =?utf-8?B?eVdzcS9rbENiem1hT1pPTklxcy9Va3p0R1BOaXZXZlp6aWd5OUR4NUdFa1lq?=
 =?utf-8?B?a2FRaWh3UFdkb0syOFZrajIyMGhDSFRLOHhwYzVPcGdzUi9id2g1TG9qN3BJ?=
 =?utf-8?B?ajIzVFZ5cjkxTGpnWHlvWUhCMm5FMFArME9uTWd0K3oxbm96c1hOWHlvZ0VB?=
 =?utf-8?B?V3pIQmRRQzZDS1VHWk03Yk9ONGN5cXMwMzh4RURHY09wUFpyNXdob3YvS0h5?=
 =?utf-8?B?aFEvTGJKRVZrNmVhRXhya1JZbGxzUkYvZzBKYmFGb0MrNXl1N3l1eC9CVWVy?=
 =?utf-8?B?Ty9EY0pHMjAxeW9KeWV6T2VCcXlPM3RnZXNVRVhEZm4rYk5CVTdURWlqUHMv?=
 =?utf-8?B?NGthTHVyTDl2NXF0NEhoMyt1azkvYkUzeE14eGhlVkxJd3dZSjB2RVhlNlJi?=
 =?utf-8?B?Tk1XOGRVQzRUUDhiUkNpa0EwbklyZ3lkQnp5RGF6QTBmSVE0SU9BeEFZcE1F?=
 =?utf-8?B?V3kwWUYwcmNxdHlydTJHUmVrTUJDZVlvUlhyZlROZTd3UzJkU0lBdDdBaWZZ?=
 =?utf-8?B?NzVkZW5TZSs2bHNwLzRlakZIbFl2RVZqYlpVbG9rNmNZTzB6emlBY0dBK0s5?=
 =?utf-8?B?Y2I4Z3UzR1dBZEtRQ2Zzb2dBY01kNmJaZldaZ1orVVNtbTl2SS9vZ2o3VHZj?=
 =?utf-8?B?MXlkYk1CZjM1SERZRFhDdDEzckdRYzJYbGpWQnZ1TFNEdzlXYWpRcGJ3Nmtk?=
 =?utf-8?B?TkZUc3pMa3RrM3Z3ZkpOM1ZvV3IwZE1vR2JTbUdLSGp6cnpVeldkcFRCSE4v?=
 =?utf-8?B?d1RTcjBZQkM2ajk5STh5VGpYV2FMeHd3bzYrK3FVM20rdzJTQmNUSHczbEVq?=
 =?utf-8?B?YlJtTkZYUzhsdE9OSzZTbklEOVQ0KzFsNzJTMVlPaSs1T0owR2N3cThaS2lM?=
 =?utf-8?B?djZZZzYxQld0ekxpNnNLWUpUWEtiaHVjT2o0bmh3OC9NZm5xQWFFYzV5Tkdu?=
 =?utf-8?B?SWQ0WVBtSWdTQ1pQYllLMVJKdnBiVFJLYk9JYjN6bDBoQ1M4ZnFKSTdiTkxK?=
 =?utf-8?B?bllROG5MTzZEOTc1ZTBUcVl3LzRDYzhEWlF1UldsdGNNamY0Q0FnT1k4NmFa?=
 =?utf-8?B?SUxOUmh6cmZiT2JJZTNZcjJTRDBid3dzc254WTRmOWFkaG10WXdoL1g5TW40?=
 =?utf-8?B?cnVBKzJxUnBCVG5yd2FnNlByMzEyam5WaURKSHJDS2pFVjBhYS9uUmYvZHJa?=
 =?utf-8?B?c3liNG9hMnd5Znl6bXdQeUw4R2VLZHB5WUpPUlA3ZjFaOE9mcHlubmlRcHJZ?=
 =?utf-8?B?WStzcXJxSGc4bGtEUEZCN1VKSEdBMEt3TlZDKzFHZ0tRV2JleUlablNQYkJG?=
 =?utf-8?B?ZHV3MFFyeWpjMzhyemUvVldjQnNjSU5TWGFuKzBhMlo2Vk1DdTBpZS9Qcktk?=
 =?utf-8?B?cE5xdEpocXMwQUxSa3UwNklXUUxxSXVRWXQrS0x5aStMclJzNE5za2szVm1V?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n4pEOXEifLiLzyAQV3DAFNDhr4wd3pE0FXkPrWsfzLqGfvKwsaKlZMFxQSyg7DkpBojNZ7QeKBt0Mszn0TMOgca1YvjiXeYpvDYPw4X2V9UX8bGeUmpO2B2TPrw2wtabvK6eFY6KwrrKgpdnQGIdfMWMaXY7lwO6lJ7KIHMwTLwbmZptPtPUzfsnPLU/np9xn6LlHUw8qK2t8y11zOwpa+XTndGobR87EgZfluVx9kEMnFBm7lhJr6n1w0H7IhNxoM4lt50vRS/koAkqJanEbNp5gyTE3264a5TD6rqhnkp0EgjT6ASTAtMjQvXYhHE4A5Utf3pWtcDQb13g+VOH79qzTFr5SYUElfKiq76ATGvdJ7YmbvhNkgopkeS20EuSm7uRof5d9SEwHyu1FRLWRjM8h/PGmykJBM06HrBiHKnzKTyXPtKa17O593zrHSR85FdEbgdKnhbLnZ8A6ytQF5NpFX4rq+2/trSocFtCIaJ2YmbgvBxHwEQWXMJeCC/L6neucD8xmBrJsbLmpXXY4vs9bhzhhnXPSo/t6YyplsKErQQSJBlPsFBz4a4VtVJy97a1FkTDc3uRt3+yTxwqAL3tq6RhwbG+ZyNG2vJrn+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9460590-e483-4a3f-063f-08dc179b498c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:31:30.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd/CABBRf0fR9ah4DeEkF9BMnLPbAUn8RpUracBOI5PEogGDpnmhRyrS9nUtx3r/aOOlm1iAJy5n1hLvz0S0eUhuVn7RPaCOnRBG3Kgsnvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170150
X-Proofpoint-GUID: bEEYHprD-IlZaPn3vq3boXnEvlyONS5F
X-Proofpoint-ORIG-GUID: bEEYHprD-IlZaPn3vq3boXnEvlyONS5F

On 1/10/2024 10:08 PM, Jason Wang wrote:
> On Thu, Jan 11, 2024 at 4:40 AM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> When device ownership is passed to a new process via VHOST_NEW_OWNER,
>> some devices need to know the new userland addresses of the dma mappings.
>> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
>> of a mapping.  The new uaddr must address the same memory object as
>> originally mapped.
>>
>> The user must suspend the device before the old address is invalidated,
>> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
>> requirement is not enforced by the API.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  drivers/vhost/vdpa.c             | 34 ++++++++++++++++++++++++++++++++
>>  include/uapi/linux/vhost_types.h | 11 ++++++++++-
>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index faed6471934a..ec5ca20bd47d 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -1219,6 +1219,37 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>>
>>  }
>>
>> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
>> +                                         struct vhost_iotlb *iotlb,
>> +                                         struct vhost_iotlb_msg *msg)
>> +{
>> +       struct vdpa_device *vdpa = v->vdpa;
>> +       const struct vdpa_config_ops *ops = vdpa->config;
>> +       u32 asid = iotlb_to_asid(iotlb);
>> +       u64 start = msg->iova;
>> +       u64 last = start + msg->size - 1;
>> +       struct vhost_iotlb_map *map;
>> +       int r = 0;
>> +
>> +       if (msg->perm || !msg->size)
>> +               return -EINVAL;
>> +
>> +       map = vhost_iotlb_itree_first(iotlb, start, last);
>> +       if (!map)
>> +               return -ENOENT;
>> +
>> +       if (map->start != start || map->last != last)
>> +               return -EINVAL;
>> +
>> +       /* batch will finish with remap.  non-batch must do it now. */
>> +       if (!v->in_batch)
>> +               r = ops->set_map(vdpa, asid, iotlb);
>> +       if (!r)
>> +               map->addr = msg->uaddr;
> 
> I may miss something, for example for PA mapping,
> 
> 1) need to convert uaddr into phys addr
> 2) need to check whether the uaddr is backed by the same page or not?

This code does not verify that the new size@uaddr points to the same physical
pages as the old size@uaddr.  If the app screws up and they differ, then the app
may corrupt its own memory, but no-one else's.

It would be expensive for large memories to verify page by page, O(npages), and such
verification lies on the critical path for virtual machine downtime during live update.
I could compare the properties of the vma(s) for the old size@uaddr vs the vma for the 
new, but that is more complicated and would be a maintenance headache.  When I submitted
such code to Alex W when writing the equivalent patches for vfio, he said don't check,
correctness is the user's responsibility.

- Steve

>> +
>> +       return r;
>> +}
>> +
>>  static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>                                            struct vhost_iotlb *iotlb,
>>                                            struct vhost_iotlb_msg *msg)
>> @@ -1298,6 +1329,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>>                         ops->set_map(vdpa, asid, iotlb);
>>                 v->in_batch = false;
>>                 break;
>> +       case VHOST_IOTLB_REMAP:
>> +               r = vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
>> +               break;
>>         default:
>>                 r = -EINVAL;
>>                 break;
>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>> index 9177843951e9..35908315ff55 100644
>> --- a/include/uapi/linux/vhost_types.h
>> +++ b/include/uapi/linux/vhost_types.h
>> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
>>  /*
>>   * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
>>   * multiple mappings in one go: beginning with
>> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
>> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP or
>>   * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
>>   * When one of these two values is used as the message type, the rest
>>   * of the fields in the message are ignored. There's no guarantee that
>> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
>>   */
>>  #define VHOST_IOTLB_BATCH_BEGIN    5
>>  #define VHOST_IOTLB_BATCH_END      6
>> +
>> +/*
>> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at iova.
>> + * The new uaddr must address the same memory object as originally mapped.
>> + * Failure to do so will result in user memory corruption and/or device
>> + * misbehavior.  iova and size must match the arguments used to create the
>> + * an existing mapping.  Protection is not changed, and perm must be 0.
>> + */
>> +#define VHOST_IOTLB_REMAP          7
>>         __u8 type;
>>  };
>>
>> --
>> 2.39.3
>>
> 

