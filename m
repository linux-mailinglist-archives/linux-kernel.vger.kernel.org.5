Return-Path: <linux-kernel+bounces-166119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B108B967B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758541C21E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7246522;
	Thu,  2 May 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EGtPHus2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RjgoMaUr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0B6FCC;
	Thu,  2 May 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638655; cv=fail; b=pNcs0eiVorVwxjLfpmeC20yYyclzh9RNjB135drysw3BayMUiFGcicNcJiV0GPfJXekmIDSWOvMIg15b+JvizORO0YXo2rTP7FVapmydzWa9cgJi18uJtLOtJkXy3jz9BRujYua2nEBz7UiGk1fb3TInkuAnfjKiHjTtH0pvsBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638655; c=relaxed/simple;
	bh=QbWaz+HENoC4zDbWQLBTlCnM08EyMuMBjhoLsUq1XuI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P6znpUI1I5R9LCRwKRQPY7GxJxd/Zihz/0+XwcZ34UJ1PldojJWZkVHQpz5ikdQ67G1HHy7iAjK7vNkmPJecMqlr3tLEYTFK+gxvWOTrRdD0ySU66NdDepAgiEV6/o5iJyTg4LAE63hXajMVwEvF0lWHFIDcPQMuu7YsCHAD27g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EGtPHus2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RjgoMaUr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44284JCH027490;
	Thu, 2 May 2024 08:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TFqnN+hbNwiPso1hnkcMY9g01kbDLSuhlSpYo1rXrrY=;
 b=EGtPHus290+LU60uxMk/Sfvnoh83Ld6cVGnXwG703CQRU3vvaPaU9HwKSn7vt+8CBU25
 I/4iDhqyawsnfchVbFfYYwuwdxs8DecMlRVnUgXvLLOg3nTo6zXa2Kaxt9J8ph8Vhe9N
 z2x8GrFXXMtvoGge9vO7QOBGnudDLK3LRrABdXTigAGDfkuSKYtxb2LxSyJ4Epl3y/kL
 JzlXgzl78mUxOZvvZ04xIijju7ElSmLNiGyiopIs8TjJl193b1FvQG+MHaPSQ5Mul8xG
 KYG9m2FWe1phidADoEP6IqJtIOdl2+mpgzYBmNzq4M5W2TtL/dBah9A02QJT9T+KqBmQ nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy35pak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 08:30:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4426pqKP016783;
	Thu, 2 May 2024 08:30:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtgkb84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 08:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeqhiJsfHbIZn67yHbMcLDSym18YaGEdfUN1o7B5P/KbMGISJIEwxMzVLTnV1suRHlqn94fhmpFS+XO8LmhooBpsv/9qiuEAFS481fXbXFSwfnc4EFMPT7D1qkzNJLO8//XL4cn2rMu7vKFlNC6WMJPwJ+fqrSUf2gZlucCaJua90rsuFEhl6ROiGTTKD08PpqHu+uCE01BmwV1TegjO+T9RvP1o1qf5oUHkdpvQ+0LGbzPHWg3Z06aksS8SOH21JjBGO5mNfMkKYCDmSOjgfiH2h3YTZlfr8v7Ciuda3hLyhz/WrztXa1E+u6iWnPKlQjYuX8Bkz+aqN8x4gjPdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFqnN+hbNwiPso1hnkcMY9g01kbDLSuhlSpYo1rXrrY=;
 b=A+FjpIaS3D0198XmDbIUfSflULDpV5jIUBk3ffOjMIFtaEzWPdODE3aPzTVM7huTdkLKn3WxMcdBR6hEF0A/nXeE2k9NXCHEJrmzV7yAZvTy/Hp10zHEvp8oV69bNeznyHxIacR6erNKNuEBytJumB9QSc6WpGeDueajVZWFAJrllLNQYIXqpbsnZxFG5UvvbKqPiz1x6bvRycv/ijLIRknF5LIWTeSO38I3MlLTr6OCarAbeJcTqDSYwgWzfbvS7TCVjdD+//ZqHcxUEA1sGoqqC8RC7s4qlWMb6gQffW/4lsxDec+R/s81fVQo+jZc8AaTA5JB3x0jpeL5tR0eKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFqnN+hbNwiPso1hnkcMY9g01kbDLSuhlSpYo1rXrrY=;
 b=RjgoMaUrHL/n2O/NwogO1cEVZbp99bgkjZMgiR2GUKSDrYE7x1kLyxb541albNNLyVc0MsQOXQKoiXUF0nbnCW1S93W6QE8ypVtItRX0hKPUi/Yc4/9CVTlq0hBNUuOaxPfP6ucHMaYor2Z1AgHnpIVGmJQi88et6mVzCFDFS9w=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS0PR10MB7049.namprd10.prod.outlook.com (2603:10b6:8:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 08:30:16 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 08:30:16 +0000
Message-ID: <5a934683-4fc1-4015-a903-429bf48231c0@oracle.com>
Date: Thu, 2 May 2024 14:00:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/106] 5.4.275-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240430134021.555330198@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240430134021.555330198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS0PR10MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4c040d-18de-45ba-19a4-08dc6a82182e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ODd6VTdWKzErQy9HMGJWMzNqYlJBMnlJRXhVaUFTZ0hYNERnalVrdzdrVVZn?=
 =?utf-8?B?TVpwekw0L2ducERCNzU1bnY5N0t5NXZBNGNqR29NQ2cySHJKUndJeXpiaEs5?=
 =?utf-8?B?SDBhdWhrUGJuSHhqU0U4cjZjaEFOK2FkMEQvNGJIU255M3labFdFSVdwWDk3?=
 =?utf-8?B?RHZwUlI4d2RGdXA3aUFqVmpmUFd3R2pZNFlLSCtsRHhFb1dmcXhzMTVIaVVy?=
 =?utf-8?B?ZldsNzE1NHE2NGVNWjZCK2Z2M0RjS0RhQjE4NEVpY2lvZ2ZyM2dZWk95WTlk?=
 =?utf-8?B?T1ZGRU1Ra0JmNi9ZblZVRkpmV3JxTnpwT25zOWo1ZHlqakVkMTg2b0VGakVr?=
 =?utf-8?B?THVsRGJxVmRVSFlZUCt1cDVydFNVUUVKcTFOWUdmSDFqaGhUWThvMWpYTFd5?=
 =?utf-8?B?NEtZSVBaWGtrcHVhdE5BWlZYTk5Yc00xbVZ5UGJWQ0hjZ3h2ZUNwVkFPSDlR?=
 =?utf-8?B?dzBGbFhTeGM2TGJzTTZWRGV6Mjk3eHp6WlJHcXdHdk92emdMWXBmbEVyai92?=
 =?utf-8?B?Uk1aMWpQSXM0anBHdWc3a2ZGUllaMEVHZVVEUUxJRnZ4M1FMV0FTR1B1NHZR?=
 =?utf-8?B?dUNGbFJKNFhFcHMvTFQyTTVaZWhVZ05wbnFMeTB0TXBYRWNuSWwrdG0xeG5a?=
 =?utf-8?B?K2V6U1NtcGRnUktaeFM2RURIQnhqZmwvdGh0aGxxUkV1Y1hPTnNZdmNJUGJY?=
 =?utf-8?B?YVFCMXQvYmFKV1NPYVFBS1h4bjhDMlNIdGFvN0hkcURZS1hwNGwzMENBak50?=
 =?utf-8?B?YWxFaE1nNWtGSVk0dG1LamJHcVNlZjlwbUpxa3doMlZjc0toWUVLUkVST1Yw?=
 =?utf-8?B?dDhYWjZxc2JOU3dFTUY5cVVyVEFORlpYVEFSa0VZUXBndHEwam5FRFY3RlRW?=
 =?utf-8?B?alJRSmd0TEJMQVVxZHBMVnh4RSszN3dNdVNJWmdhTURYT1FFQS82cU5KR2xF?=
 =?utf-8?B?YjIxUTRXdkxqSWw4dTE5VXZQNUVOM1hhT3JFOVVTaUNJN3pBQUpZVTU2b3FM?=
 =?utf-8?B?TDdwY1d2alBPSWliMjV3M1hvSmZpZGRWb0VzVWY4ZHhRaTZucDBhSDhqVld6?=
 =?utf-8?B?eE80dGcxb0RXaWJ1ajV5NjhHMFNBbEM4M25PaXZnV0NmS3hVelM1UFVXbzc3?=
 =?utf-8?B?a05ZWGFWZ01oU1hWUXNablBhL1BRQm1sVWpCZ0xOVVhQaXo4blp4NjdvMTFx?=
 =?utf-8?B?bU5JSDd1czR0YmVmc2FJM0l5V2RmZnR6T01udlI3NU4xQXh5ZElPRnBVWDFw?=
 =?utf-8?B?S1czUWhVL2NUT0NTSlQzOGlaaDRTWFNhazliSG1ET0VJUE16b2VXU3lOUkdH?=
 =?utf-8?B?S2JGckR1aEY0enQ3NEswb0xDRTVEL3IzMGVGNytWb1libHJSVXU2SlZ3Z1k2?=
 =?utf-8?B?ck5abTZSZnZoTDU2bFVSTi82VEhqVlVQcm83SFBWdDVaRFhkYlJLY2NlNENs?=
 =?utf-8?B?MENIbE5PYVVSTUZ1R3l1Z3JZMUgxNXFNcDBKY3R0MmlVVU4wcGhyUFV1MW5L?=
 =?utf-8?B?UGpwdFo4N0dvN2RZV1pyMmw4a3dnTDZheTFwMGZSWmVYZXVvVFpML1FITXlJ?=
 =?utf-8?B?QnlZaFBzbW9ZdGFZaHBueTFpRGJwb0tJeEh6VG9iVHV5a3NPdTY2Yk1DUTN6?=
 =?utf-8?B?cXVxeUV0UWlUaS84bERGd1BkZTR3R0lIRkRZbFdxYmVrdVY2T3QzRE9tYSt1?=
 =?utf-8?B?c3dTdlVLbnFuWGR1WVRtOEVMUUVrcDhaZGlxU0gvcmJzYjVRK1BveWhRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmRCaTdId2paRERpamdmb3dOam9ESVRGaWJPWXEzZnJLR0pXMGtPSFFUdVJI?=
 =?utf-8?B?YUd2R2tNVGdPWk43bTJwT2JxS0FVQUZ3M0w4UThRYWpGck04c3QvOGlycU1Z?=
 =?utf-8?B?azgvZnQ1elU3L0w2bGRhRmtIVTRwQ3UxUHF3OG5FeFV0TWVOdTNCU0pSdGVI?=
 =?utf-8?B?K2hFcTdwb1hwZ3MzOFFXeWhneWhyMFlaSm5LMXNIemZ2NzREQVJuU1l1c25E?=
 =?utf-8?B?dGxnMjlOelVYYUhaT1hKRFVBZlFTd2JHcEtIMk9NcXN6UDYvWE5HQXRUb3E1?=
 =?utf-8?B?M0JSZVVTb3VRUEp1S25aYmFCYnBFMk1TZnV1QlNiS0JIcS81R3B6R1pzVjZv?=
 =?utf-8?B?NlllMGxwUWxXeGxubzdPVFZOdHF5THNJNmJ6cG9xd3dvanE1V1JCaGNZVTVX?=
 =?utf-8?B?MVdDYk9tbm8wSmdnbklEdFI3NDBmM1ErMzVmT3NtTzJBSHVUOW9JVnpwREZN?=
 =?utf-8?B?L0x2TS9nUFh4REU0ZTFvTk5mQUVkWkJrMkR4ZzBtQmVmSUdSZmhvMXlpMXBM?=
 =?utf-8?B?d1dHUkU3citmaWpVU1FEbGxxTCtFcmhCbW5FUTZvamxMZmRmZzNpcyt3eWhU?=
 =?utf-8?B?VGFVMlZUNnZRWlFoc3UrdDFqaEdHbitoK25LdHozV2pDTmdabXRMQm56MGZO?=
 =?utf-8?B?WVBFNThBRTBmTTBmWWYzYzcvd0xnRGpVS1RyaWhNc3JWMkJoK3hWWTRmWVpC?=
 =?utf-8?B?NG14NC9nMnJVNlV2UkdoZm9CKzgzZUxIOFNKdUVsZGNETlNwNndPOFBTdlh2?=
 =?utf-8?B?ZVFlbk5lUWFoMDkzRWRKYkxTTWVwbCtWWUU0dFFOZENtMlZaekF0SnNYdGlI?=
 =?utf-8?B?emc5WUVHN0FYUnJuU01xb1VRczc4NEUramk2dHVSdWtZcmZpcEhGTmFvd3JJ?=
 =?utf-8?B?cmlmTkhxYUMvVHhFU0Q0OEdXQ3BEZldaOEZ6Vm94QkxVOVQrVnNQZ2VBR2V1?=
 =?utf-8?B?RW1NeUVYdis3N1ZJUjFxcUE1SUZ6aHlLVnpVcE9jSEdYcUhkelRta1UycFdC?=
 =?utf-8?B?UzNDYk1HQjZ1UVVibUJldjA0eTVtWVVuZDVTTjBzblVjUnJpOWVmM2VoYzAw?=
 =?utf-8?B?QXI0QmlObFhuaG0ya0VoaGRDeW1jc1JtbTFBQ3BndFhkNnFFQUlzUjBIdm9o?=
 =?utf-8?B?NDBsM2wrSitTcTRlbTNTSS9MVTRwdmxpOUxhNzhpVFpDNE5KbGxRaWJ2eSt4?=
 =?utf-8?B?NmE3WXVTU0NSSmh2QTYxVDE0YUt1MmpMWStNM2RRUkttZ0ZwZFBvSnhVK3I5?=
 =?utf-8?B?U05lUDBYQ29vV01CZjB2Y0JDTTBHN2RIbklHaGpPWEQ4cEUxTGNxWEZCV21F?=
 =?utf-8?B?Y2hqMCtFZGVLTnZjaUk4MUxCc3VkYVFkZm12MEh4R2NTU3ZybjhhMXZVSjVs?=
 =?utf-8?B?eml3bUNONWNNUUpIV0RvMXZKVGt3UEx6QUVWT25KYTE1enllNVNkODBiWVZG?=
 =?utf-8?B?LzZQQkQybkgxWXJLc2VlMmZjaUVjN2FjLzZZMmVidjVzb24yM3krMjZiakdi?=
 =?utf-8?B?MFlEazVMODY5OFppQ0dQRHA2NWFDZldOQjd0OUpMOFBXYjB1aTU1bWtlcS8v?=
 =?utf-8?B?MHQ4Tk1CZDVkVy8vSVQrV05yb013M1BnUVhpbDltQUZCeFJidXR0SkY5eEZj?=
 =?utf-8?B?UXJnemNncUw1UTRUbTJRMmcwSnM5a2lTdHNndC8xUUg0eWNQMXR0NnlEc2Fw?=
 =?utf-8?B?eW1RWURtakpxNi82aFRseHduakQ1S1RucXFreGFVaG9qVHV3UjdEdEhMTGtq?=
 =?utf-8?B?akNLNkVzRHpjd2xDakdVL0luWmd0YUpmSWV5d1drT3hPMTJ0Vk9CRzlyYTRt?=
 =?utf-8?B?Mk9hQ2tmb2NnaUszQVRScFdBbkYweHpnNUVnRy95RXl4MWxDQWJadDFiYmMv?=
 =?utf-8?B?TXFweE9mVHBaN2lBcHZ1ODRrL25hNVlDUkJwRlV5UVBPTk5IWjZ1OWpHdXhu?=
 =?utf-8?B?NkdpMFRLdkU4WU9GRFRQazFHQXBVTDlJSVNhL28zZVJkLzRZV05RL2FpU3g0?=
 =?utf-8?B?VFJnTklrOTQ3U1RVZGVhb2gzV3k2cmZzOFRQRnBtZVB6VTJyaktZYng2dy9a?=
 =?utf-8?B?MWgrMHZ1a3J0TU5JTlE0VHpTSHJydU9icFY0MGVVTUg4OTBOVnhpRzlXTC9n?=
 =?utf-8?B?VHFQQWNVaHNMSFo4aWVjQXh3dGcyMVRHZjREb29rb0d2bXRxUmcxZGhUZURj?=
 =?utf-8?Q?vAubBAQssCFpVhoGAmSs75Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	S/5ngoFdZoc1YWZ5NohfxXMIrvvgixUTtX/pRWpohV9yW/24XapeXaI54+MOBZNoIx5f5Fza5M/92BCkAfmsr+sWcJg3cmr+T7fByQpxTWCsI7XCVYkdTBiVKuuuUhcNhMLivdu0rTRvDjRI99yhdVGgtI0h1YlpZ24s3XSrVWwgWErK07uCT7X/UBFN5vtvgzEqe+2+nchgL1MvxNLay4Pb3DwLxE4PoeVQI3Naz6hD6NSVrFgE3NhbQzYG0Ypjqz83Ukc4ztQrBUEZwD+b2ytsxzHoc8aC7k1EqeHv/2kxYl2pnJMz5KcuhwUlwU9szRi4/NtQcmnyKgRzGAUgP5uaNV+BCdE9HDeds1pNWN355dDvmSBRUL0ViyvoX0+ITcK3jTvdh3H8H9UDPmTKPVAXXO3z12MaLufxmO1WWhlXKn4NhNZq6lnRJ8APD347JHBua8zjs6WE/n8j4DJVOOC0N1DIGMWi/QD6lG5oy7CM4dq52wpOaMt8RTHC2WT/7Zz/cFl7zbmsZR+TN19mNG83Cn7gmnr+G340c7mqvRbgZh3Lxy6JnRKE1HC59QvZfxfJtsxeSfhhlnAdaEW2jO+/BeEfjjdNTikFAuGc/Jk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4c040d-18de-45ba-19a4-08dc6a82182e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 08:30:16.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkEr8ZyjJIB1U1sUAbvZ8ive62sVFB9vvYj1dTgAJ7OLBrF+rW97vziaAwyGqSRilvdPREZMJQ540Y+pRhu8F/9HhC9qbpYEBd2pkavKo0dW9h2680Rr+zdxqfNmroq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020050
X-Proofpoint-ORIG-GUID: pjHVVkk7SyRyNV342UsWUhxhTYX4KskF
X-Proofpoint-GUID: pjHVVkk7SyRyNV342UsWUhxhTYX4KskF

Hi Greg,

On 30/04/24 19:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.275 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> Responses should be made by Thu, 02 May 2024 13:40:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

