Return-Path: <linux-kernel+bounces-77967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74096860D70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957321C22164
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF11B801;
	Fri, 23 Feb 2024 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/Qy1q+8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SawP3nv3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC818E2E;
	Fri, 23 Feb 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678859; cv=fail; b=YO3pLmul+dAuNs5QhO647utt9fzOz6IX2p1g7khfvIC8MPYn0VSpfzdb1gLiuWl3Dl5/OLeZqnIOkqbZNDzCLrllJ+LbJBXYDG0TzitMsVlB1xhHmJrhO7NY8kHRJLysGSsMEr2fve81j3U6Nlau+L+pIjBWvMKAJGF23kKgE9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678859; c=relaxed/simple;
	bh=Mv0WJqjQ4+atYlZ7B+Dly8ParcfkKD5J07itcUYdZkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mS+glhmSRGaXiMLjd8zHhc/n+PziLq/T2FsqnTgnPijHM5NBZRbaMQ7IV+EF/D1UczdPdfUf9FajuGi8apoSQ53BrrZOAHLu/FisH4TTQZ6Chb4u90dq/AszqjTBxatNTjR2LcOfCbZsaQkpRBCYv+TrGpLHWoGRVd+TbM/TSNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G/Qy1q+8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SawP3nv3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N4x5bQ029757;
	Fri, 23 Feb 2024 08:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XGHkZJI6MRzKVi0jhF6fHbDCPDmnkB5qvar13bfXw1k=;
 b=G/Qy1q+8EBUzI4RRIUwdhnQHLdxDWtxSgyp6b7WxdGdaJyXtMhdIo6tEr49wuw/wWtCR
 4VqIahnm8Inj4BVUVrcAYqJ/lFTpT1gXJLAkcxoGu8dDUBIL+XIG6YRgfMIK9+wUjQ+l
 bHm4gLz222AmJEGIOMj4DEzGpfzFMx3NWETCpXqR1Hca6tMumcOX3GofA3O+LT3Vi1OW
 Td5qJAO2mbEFWVOFhWUhbWAS1Yg/T4pScYFLSvE9IRcNfsBbA241n47fjIbO5IxLdQOu
 9dNe3/r3N6mE57amlEBDkN528EjxT0/hrjG5NzZM8HQCk/ZK+xraceKFLqg4qtiwQnuY Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu6tye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 08:53:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41N8RhBe024548;
	Fri, 23 Feb 2024 08:53:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8burbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 08:53:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIwD0PvM9Q4xViDUIP0S3c+JBS+tEorPEfdF5kiDjparg9adKffiCOob0gtayJSwjJabv80LFKyIqaUvxbACTX1EWUkzWI1lxUUdfNN1MkFn+Zx4r+wqk+HbSCxjHSfSdEwxkLBUpQGPU2G6b9QFOfmY97CCawvjoG5rJPH+/KZeYtdo5Pc7DkvDfNF5XOhGpdz/CZpfJBsfgUWDrQ4Bap0DpLDOAZZ1I5c5XWiLW5pqmrifCXj+0LrZTxQ++Wkns33APPra6gIb6kerXXsDXfaIO+q8ibaJr0tdwEASjUfpSJLI7SD83flsqjTpq6dzI0HGSiW9h4dmEQ8a9wmLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGHkZJI6MRzKVi0jhF6fHbDCPDmnkB5qvar13bfXw1k=;
 b=jDzDJXd8Z+cNn2rPppCmGnBKwSjClMHl6CEck+LQE75IODLvpm0OUAp0HmBQeZtC5/LjOIO64fmAJRfWGxu/ZU+d39BpZDaPdhDvfS6BXLNtnjtfo3RHRwn1AHGG8TWWGpbyh0b1e1qDbMVTbhu14/wy7yaBv+4/bT53mUJa0zc5fQ8lXMkC82fgwoR5b3AesMun2iVqqO6JXeUbI+r1Vwaur+cFFKF8TWmvE3uLGMa0UD+d4dseuLBrEYGDK1rdVMWUhLGkaFvDorvTuXVcac+9gpELytRpMQyUx19ImjpZnqdq1LElJy5PmzS5cexgXYeG+JKr970z2JKAfmOkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGHkZJI6MRzKVi0jhF6fHbDCPDmnkB5qvar13bfXw1k=;
 b=SawP3nv3jA3598lTt1b+WVdHeV5WFKK0Y9BerT6hR+nMGxbXJcRJ7loAMMGfsl7kqSeMsa3Ri2EQ0it2a2qsSDpgJKq6T0gbkB6QlOV3DTSmnCWUewm5refwu6qlnREbTECVsEs7KsL2eY0HbTVX0P8TbRbZP/wGG1ZvHPjg3us=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 08:53:31 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 08:53:31 +0000
Message-ID: <87d89b4b-463a-42de-a361-bc138d3543a6@oracle.com>
Date: Fri, 23 Feb 2024 08:53:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] scsi: mpi3mr: reduce stack usage in
 mpi3mr_refresh_sas_ports()
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Arnd Bergmann
 <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240123130754.2011469-1-arnd@kernel.org>
 <96bb914c-79be-4867-b59d-62f80dbcdace@oracle.com>
 <yq1bk887zg8.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <yq1bk887zg8.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0642.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::11) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MN2PR10MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5eb356-dcfe-487d-fa26-08dc344ce927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GZNJss/LNXKQ1EgujQH04Kc6nPrgT5gLBA7PWgADx3ObT6mzgKMyTMYeMjPrAPoNefn+jCwa4FvDQLWPhLIQGjhF0mMaI+ErTwaB8F7nSowfB699usb6TMGFTtLEWBx/iaHu5tXgvXqlD7Tyckizvmv1RvDveTEJ2pWJWVE5C8TPbNF2bnWdw2jfzeAuOwUvUcDmRi1ThT1xH4OHb+/yYDvjuwb/DcLkJ32i6K3QcGA4MgRWNY7K278tyNgCQEcKyhz9fuivrEaZO5h9oXJDIbWaFOMhzQZ1yCd8HBekrxDagu5R9DDWlqn68vyUT6uUnZmORiKzNnTY3mmY3LbhVujEmbm9U5E1nF+1IDypKq44jBMXMReUBE3kZbSUVmeklZ2juT45gb0DAcpPQHg+qJqWI251//D0iUeCu7eRl4w+ZuTqXZxfTVeVn9gbRz8F7/Q/dRbeZ+n8TOidKWwBIghmPqom/uxHuMiu+lQeZOIilIzyGU8wlLCPf9oMPmqiaRXoz9FrH5HxTksCAjpxANbmce/63+c07B21b3dm9rw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTNrU0F4Qzh4cVNGYklpWXlUY0FpVm11TTVzNW1LVUtMMFRjMzhnYVQraFAz?=
 =?utf-8?B?eE5WaEVTSEFPZXd1dlNtbzNCb3M2cVZzNEo4aHlOWVp0SGdJWVRtdEw5eTB2?=
 =?utf-8?B?MGRvVUV3RlpOMmZqbDQvQUFOWVpYc2Q0OEtlR3c2WklZWWMvYXAxd2N0SEZJ?=
 =?utf-8?B?Tm9WYUNrbit3U2lIWW5wMEk2azF5K21qQjV0aFcwOEFGem81VDlqMjg0SDkw?=
 =?utf-8?B?OHZmdUhKTHpmU3lmaUhlcUZPa2ViRG0wR01IRHBpL3dVRzRYSjYzRGVQOThE?=
 =?utf-8?B?REd3LzBBWHBwQjhqWDlQdU02MUR4OFNJZS9aTVRMMzRvZUY1cjExWGs3a09F?=
 =?utf-8?B?WTNSaW9ZYStpN1ZBaHBSRWg5NVY0aTRxdDVYd3VFTjI0SDE5WlBWbzBmRERF?=
 =?utf-8?B?c3F1QTF1Wkg1azJ2b1JmQ2R4TUE1YTZpMmlSemlBR0VGT2dsVjZCZjRwMk5G?=
 =?utf-8?B?TG1JNlZ4Q1N3Y3N5SW42T1BCdUsxRjhaVmJUYXdSTGhSQWR5Tk5Qa1R2eHVh?=
 =?utf-8?B?Mk5yWDRmQVBPZ1NoSE40RHlHWmdlVHJiZitnK2ZVOWc2RkZMRlM0aHZPVDdl?=
 =?utf-8?B?S2JXakpNRExxKzFRZmdZME45WnRhVmI3amhDblpVL1U1MXc3R2JlRjQwTERq?=
 =?utf-8?B?eE4wUkxGNUMrQTl4SmY5WTFpalJLNjBWNDF1MTg1NjVFNXdhQ1JidHdlV1Ax?=
 =?utf-8?B?UjhjNEcvd1ZaTmJ5bm1KK1Y4cWg3eHc4WUtXUjlLYzRseG9odDJOOXByaGNR?=
 =?utf-8?B?MmhWcmJDT1hIQ2J1SzNHZ1lYS0JrdnNIbklrZk4wNWErVGJlbE5oZW41bjR0?=
 =?utf-8?B?ZFZoTVlUS0UvTUt5MVl3SDg0OVp0bzVxclNDSWcwZjJvanlDZzExTFVXZlJs?=
 =?utf-8?B?MUE2dkFHbmhEdStUQWNqZDZCbndwMnpuZnpTOXZ6MWMzZ1hBMURtYzlReGpt?=
 =?utf-8?B?S1ZOZEV1R25jQ0N5bmlrbTlNWjltQVA2bCs0aCszTGVIZVRvMmJVS0h6b0Jz?=
 =?utf-8?B?MDBuN0pXTFYwVUJhYzBXZ2FucmJrdVluRnFTRURxRTRJVlArV2pBUGZOaGwy?=
 =?utf-8?B?ZlRub3JWbDVGWDQzRXF0ZDB6UmQ3YkFLeW40L0w3dXNicHQ0UDMvdWMvajhS?=
 =?utf-8?B?WHd4UWhIY0VaZzVDZTVWZGltSnZIKyt3NHhTSWxaVzdBTTlBbFRIbjEyYnhn?=
 =?utf-8?B?aktYVWNrRVVWVlpUS3VNeDcrUFI2NytvL3UvVG5CL2FQNkRWdlc3anluN2tO?=
 =?utf-8?B?bCtRaElxYVNiRWphVHl5dEphU0NaRmkvYnlNMWhtZWFPVklteW8zQ0o1STN3?=
 =?utf-8?B?cVFhRWY1cUt1UlhlNytMUG5HQmpLZHJOekNycnBzcXp4ZWMyOEtUejVWME9O?=
 =?utf-8?B?RHcxenRneEROQnMyMHlVSnkxNzJVREQ4cTQ1akhNYVZPcUJGQTRpNTd1M09k?=
 =?utf-8?B?dWZHdk1ONmY0RFp0ejgxZlR3N2JHQmV6M3Bna25rWmJ5WU1mNnNrbGlhQTQ3?=
 =?utf-8?B?OFpUTE1xYW5Cc1dyL3dFZ2c4c29EMGUrQS9CR01rQU5lVlkxVjBXVjdhaWZT?=
 =?utf-8?B?a2tacTlQSGtqWVkxNnFtVlRINFRndGVPY2szcGI5d2xxVllqWmNHVmRKdnAr?=
 =?utf-8?B?UEtSWktRcnRZR2dLdmZFMjdoQVc5YzZWWjJIYjBUOGoxendBclNWdVRIWnhT?=
 =?utf-8?B?K2dodklvQ0h2NmdrejhySU4rZ3hTbVY1d09DMkcxUXladDdhQ0lyc28rWnd0?=
 =?utf-8?B?UHZUYVVwZ0wwSUV3MDhZSGpRczBkTGxBUFNBbEIxTFkyTVAwNjU5VlorRGxn?=
 =?utf-8?B?VFY5NXFsYkNnUTdhdUZXd0hHbW9hSVN1UEl5eGZ6NkpjcVJBUEk3QU5RaWRH?=
 =?utf-8?B?U3pDMVM2czJpZExGWTlOS1Q5NVVGRUtXczVOdjAvUTRpaHRMSVI1UCs3SjZG?=
 =?utf-8?B?TmwyTnFYbVJzM01WZk84NVkzcWhLaUtIKzRkU2p1M2NCZWVuWjdLbC8zSW9y?=
 =?utf-8?B?c3A5elJlRG1uWVlIdzBrRlRzbGxRWE8xZURnNUYxV3cyV3hMdi9BRUZBUTNP?=
 =?utf-8?B?VkpFSVRDdkxDSTRvSGx1aVpmaHIvNXFocnNRT3BEOEgrZm9KODlvM1AxbXA4?=
 =?utf-8?B?cXJuUFpOQ1NSeDZiaVVvQ291OG1lSi9IdzBkYko2bFFkQmtkUVczVzVWWHVR?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LHWkEqQMsuUToV0/CQODw84gZYHG2MCmG+fU+mp+AzNO/dAfVAe8/YwvfzS0fa+3rocRO7rTUmUBxUkG+hnTxbw1khWnpLthdyjDBIQo1vHRn+1wR8WBn8vaNKRT1o998HX+hvnNBg/5yZzPLMgKqvD6cC+feuJ+pw83s386ckIX5Hs9I6WngDZuHfAHcwKYnFT0JpsmsOWCYBJR1dKxA4EvhxT5zMks/xO//eiVsd+7BTCmZW6RDfSCHaNm4UJAXFXu1UIUivlk+A3hHsrwIevuLUKXqyyXQP70yIbV1WYHYhFcv5ZCnZP4ICNEyC2OAyDkVH1DuyGd1dj4GSSzLJliefydw0vIWGRI/GGJ4vjqC/4tKnLIkr/bK4XPwHR0d0twvjChy89bUPIvYddz1RYI3D0Psp+BVnQziI5qQ4G4wAEu9GuAv01FyEg9aFsxfvCGXUawyF2H9+QfyIN9Z7y0aZ8LnBL4MzOp/eEQ2WKPQ1i4w+s88eK3NRtD6nQ6m5cwhEvANq1DzFZvczf7g7GdVCNcFpcfckfzge4IxENOblKS1c3SzLOfzkKC86z8zDlGjERASBkMX+TKGbYr+k37/7fxGhWrMZ/AhsZ1F9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5eb356-dcfe-487d-fa26-08dc344ce927
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:53:31.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mBVn5EmOadilSzsBEFuWX7XzmMELQuexzzbpkTEYFglfqO1kbNv+Yu5W39KFb/Xua8rwl290L4cME80hwomUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230062
X-Proofpoint-GUID: 9ETWKiE1mo31QaLlVbxIJ6cpT2sqtqTL
X-Proofpoint-ORIG-GUID: 9ETWKiE1mo31QaLlVbxIJ6cpT2sqtqTL

On 23/02/2024 01:16, Martin K. Petersen wrote:
> 
> John,
> 
>> Has this patch been missed?
>>
>> I have this same build issue for i386 allmodconfig on v6.8-rc5 and earlier
>>
>> Tested-by: John Garry <john.g.garry@oracle.com> #build only
> 
> Broadcom requested changes and I haven't seen a v3.

 From checking the history, changes were requested for the v1, and Arnd 
addressed them in this v2. Since then, there has been no activity.

Thanks,
John

