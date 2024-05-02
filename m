Return-Path: <linux-kernel+bounces-166120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D78B9681
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4E8B2248C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2445BFD;
	Thu,  2 May 2024 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lnlwmy/G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BMdukQo6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908A1527A6;
	Thu,  2 May 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638734; cv=fail; b=LWn4SE60FmRMJD+gWyvilarI0q6SQdzopK+89KT3rMuqN0QM/aPADoVNzCeLCYEnes8w6jpyRgCw0Zz/2ZSv19istQXiNtDRnzu0AB0/cOxPvVey2ulZU6meRlgYstkdtwPCRJnVgUgiqQ57xgUb0x1MUzPinkAQiFHT5xc27Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638734; c=relaxed/simple;
	bh=5XVDECzqv0VIza0W8Mj5ltDNDlTVa2mY0d+XePd2zeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OjyXrEYYfvwu6CbOvzvcTt2JR+3Zo7X7Gunuu57dxw9i+Kf3gWJRNH8T/kNKXa/swaJozMtn53l/M0oq0dssSmdJ4XAHxb3yzD2llMyICflHpIkZS5tHXrH0ewtlv+o0ET4uDb43HTghzzv+tp+HcW672FjkjDq8RhjRqRd9lYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lnlwmy/G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BMdukQo6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44283wLC026431;
	Thu, 2 May 2024 08:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EsypJ2YltgW9HmE/73RNRlSfI/ncdcy7f8ZNvdXlIJI=;
 b=Lnlwmy/GfsnfSIXSpdDdEcxl2lwtmoh0MbczEg6LKhpEUz+C9xeib7DWVth0+TMfHwjV
 6RqhPykgXevWT/u5q+kvC4eZ9fGKRVwNVAVdjsLdXgujPoJoC5xLh2xf9SjSN9Ws3FBH
 B2KGvJGqQ8mSyTxFRs7PKEcuUHTF7gdD/yPkUdh0VR2if5KuIFoBibtQxM4sGZV3nISo
 ZqKkenYwG5WA82h9O2pvPrmofTLw/caS1/gUL4Mc/4HSyp6cvcV80wmnafd3pkU78d2K
 QZrar8brUqLz6A6xIFdDOXPP7s+pJhitAX2+xytxQMRCjSLH84oh8hxpW+vF93MYZNRL mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf51pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 08:31:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4427BiOq033161;
	Thu, 2 May 2024 08:31:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtabyxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 08:31:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtRRhmTMqFMGJg3V1qcLLEnLAXjLkCp55lBAova1nWgQtlKVzhlCWU8vMX+fPDy0TvF4PwbpM3NKm9f7+gF8jluB4lls9kOtuw73/fz2y9tQWzyy4a2/laeDmY0qrsTZYqTtp0uL2W43b/WwP9YLQqr2OH/aomZXrsfzcsNthYhtM/+3B+SyaqPaq5K9hSjWQP1xYCozeNfIkqBg1foQACXYv/qlNNB6zoZchSu53BiBqQkJU8ADur3m+ZfVy0ydiTYLHMzxMpwBigbP8FrbsZnSKzREl8HRUuHsQxCpvl8BbH2N1ISaY+7lbqUbwVk2SrshwsdqGsZ196zEhe00oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsypJ2YltgW9HmE/73RNRlSfI/ncdcy7f8ZNvdXlIJI=;
 b=iz8aPlWqO0Z6oPRMRLyrCBVe3iWYLbATIL1GZjmAKJD1CXoo+Uef7h8Ge3RdyE4jQj3wfCkdmooGg0/JhG4rBg7MDKcPKWH3K7u/Q+CwMLFS6H9UYiVtZezNBD2lDU6jV3z+GrcGs1BZpJNHJ1+ukQF32R6OPXuG62jU6eZqFNty2QPOEIUsxFx+0hDQU9ne9K1+phb51RZpGu0ss9Qbkg9YwfN6MYuFNeg3iC2t0GHXLbyQUkb2w7P7AGz4Q6bRPsKc2ktWyIKJNWoBRFH7bQuZuRoiNbZ4GSexcbF5dFMvcZeXtGDM3xcr5iuFj+E2nziMcEs7lPvTUNl3T+n3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsypJ2YltgW9HmE/73RNRlSfI/ncdcy7f8ZNvdXlIJI=;
 b=BMdukQo6CJYoEDMGhV8uTBRb6EXScMR48mCMt25r/rYLIFKDIwLpg/vC8uHO/4WM3t+kIIK+ZX43y+XI1J34OLHukjkY+nR8Q+Zd7b1OXSDdIOUa0RnagRVEdTLPt17F4fOWQIUJLN/BcMDtMxmMxZVZxuR05l0uPBWmRKuaFUs=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS0PR10MB7049.namprd10.prod.outlook.com (2603:10b6:8:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 08:31:29 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 08:31:28 +0000
Message-ID: <5a804e60-d311-4b82-b93e-bc5cc4b13edd@oracle.com>
Date: Thu, 2 May 2024 14:01:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/77] 4.19.313-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240430103041.111219002@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS0PR10MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ed4bd0-f7bd-48fb-8f17-08dc6a82433e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QmNPbDlxL1RSUHpnT2k5dU1GdDFHcS8vbHBUemk2YXQxS2hYSnNaTmVKd2RH?=
 =?utf-8?B?SjNoLzdrZ05FM25pbWxMSUN3L0ZsaW9wdDY1U1VxcXREMGVobkJoYm9senRs?=
 =?utf-8?B?ait4eWZHb2YvV0t2b0Z2dllZTjJqL2NGTlhCUUgvTURXTlloRDZ2YnZCU2RO?=
 =?utf-8?B?VE1JT2RKZktpWmV5bjRDSXl4bTVtOUdQNXdBS3NFTkswWnJjaW92Kzk4L1pB?=
 =?utf-8?B?eUp0eExtUWpONW85ZjQ4RExaaVllazVML01pOGhtNDlYU3VoeHRqM1JmZ0p2?=
 =?utf-8?B?b3k4czRlS29xYVQzeXVWdWIvR3ZWZXl2aFk3SDJFSXNndVFuVEVtdCswcFlC?=
 =?utf-8?B?dzZ0TnNVQ1VUUmd6M2hKUGRHZ2Z0NEpuRkdvSHpQSkIySjR4VkJmSzNlQmMw?=
 =?utf-8?B?OTZURzlJSnVSVWh0WkZ0TE5qVEhQbUthYUxzQlptNU9GQkV4WCtFYkdVTlJm?=
 =?utf-8?B?dU51ckV0N3VZMk5qS0gyOGNUSURQQWJLMTBLYXVwY1V2a1RFTWF4Z2doQkxx?=
 =?utf-8?B?SUlKd1hzUEIxUFVkZ1U2NitHOVB5L09PWlJoQm0rZkdOZWlmRWZQOTRPYW9o?=
 =?utf-8?B?MFVpNDJhRFlLcmZqWFpUN2s5ck1weDBIb1FEend5OVN4ZlpCMlhFM0hQWm82?=
 =?utf-8?B?Z0F3Tk9RY3RvSWlES0lyWm52LzdvdHJmSFY2cmczSk9xYUY3Y1VNWnNyOEt2?=
 =?utf-8?B?L00yaHhJYzBrZllqYnFMSjkrQjVhWW96aTdkSFMydm8vN1RSNytqaldWVTVu?=
 =?utf-8?B?U01zd0o0cVVDMllSdkNWVVMvRHV5RVdxOWcrR0RpVlpUb3gzMXYrMHpacmdo?=
 =?utf-8?B?a3BlMnZSR0g1eFhUc2NjNVhOdnZPa3MvTWdxSTVrMkc3S29SbTlybUhDa2pD?=
 =?utf-8?B?eXJVaUVMY0dNNkVlZ014Vm9NbTc0NTZXSENnRUpiTmtYOVNWTE1uaW5jLzR0?=
 =?utf-8?B?ckJ2VUVEdzg3WW5DR2J3T3Y0VlRVMTEweGd0R3A5ZmoyWmloaEJ5aWMycEVh?=
 =?utf-8?B?WStUbGxpSjk4anJ1eXo5R3hRV3p4dG5aN3habWZZM2VRSEhtRDdPRXRwdlFO?=
 =?utf-8?B?MEtULzJjMVhxMysyWU5GVitPTEREUURoVzRmQ3U3RkRNM1V6MjdiQ3ptVXZS?=
 =?utf-8?B?WEcvcElhVHNhQVdoOVFoUE9zQ2JhRDZaR3liN1Zreng1Y04zTnczRi9KdmtN?=
 =?utf-8?B?c1BmajJxREZOTWtJMy9ITDlaZHNVUXJRMzRkSjNCSFBDVmo3TlNycFFKeVcy?=
 =?utf-8?B?ejQ4RUpsbUx5eUJ0bDRUcFBnejVha2VHZTk3Z3g4cTdYcjRoeG9aY2VadEJY?=
 =?utf-8?B?Y1VNaytwdFVzUXhoQWNzOWN6cFkrSHQ1KzdnbHR3eVRxaG1ldFpCSDUxWUgx?=
 =?utf-8?B?SWUrVFA4eDZuVHd6QUN4MDdGVXdBOGR1YStQRUtDUjFHbTJEdkRtcHJBS1NK?=
 =?utf-8?B?MVR5aVo4dXJJS1FCb3VDeUJhZmZJUE1Za3ZYd01SenZjRVRUdDBaVlUzWlJi?=
 =?utf-8?B?UHdtdm1uOUZpQVY3MUVIU2lKVFBqZlR2MHpncUNZd1drN2hKWmtPSms4b0Ur?=
 =?utf-8?B?NkNzUXB2VlZWYXFoWkJkZUhZY3ZjSldERmMwc3dSeTJSTmJvZFV2NWpmcGw2?=
 =?utf-8?B?b09wVUpJMXcwVkFkUUE2azluMVBHTkpwY1NVVXQvODI0Q3BiV1kzQXdjcksx?=
 =?utf-8?B?Y3FRbHZKNjZoSUlQMzU0UmZhWE14cmRhSHg1SkNLZDVGL0kza24wY0d3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXlZSHJUUmZOWU1qd1E4bFNIVFVTa2ZCZDZ0SWRmVjNuQWlBZU1iWEFHLzBT?=
 =?utf-8?B?YUVVdWJFV0w5NEUwUld3OWdJb3ZqeHg5Z2JnT0JrZFErQ0tnUkFSQWh3QUNM?=
 =?utf-8?B?ampmN3BtbGJvdlFoMGdZaUxlczlXUXhLOWlUQTgxMjZVLzVzUzdqYjZFdzB3?=
 =?utf-8?B?OVJOdTB5VGtOdVBNNUJ4aUNTRnhQbkJuM3BoRU02aGUwdHc0aXJnOFloS2F3?=
 =?utf-8?B?eHhsR1ZyU0dBdzBDVWlDYWpxR1MyY3R1SXI3emY5ZzRxazE2YVdZTCtIMEJJ?=
 =?utf-8?B?aGNwbG9DVTRiZGx2OS84VmVWb2daNHZuMHZJZm1BOU43NXZJQ3dFdEpacUs3?=
 =?utf-8?B?OEdsZ1dQR3NyOTBpUjJVRW1SM2dkZXhCRDI1ODV4Q0kreUdlTlQwTWcwWFZN?=
 =?utf-8?B?NWdNeElJVkxqdHFmblMrWE83NUVPb01pMWNtT21mMWFDdGh6cXR1SUN1S1Ux?=
 =?utf-8?B?cnpmYzlWMTF6M2hUSHh3N0d1bGNQaHVJWjkydzRIQ2JFZFN2bld2cmRQWGlj?=
 =?utf-8?B?TjJTMHFSTVpRSVp6Nllla3puTlUvNkluaUJvU2RWRk1sa0t3SGY2UHc1OXBr?=
 =?utf-8?B?SEYySWgvdS8xZkhtVlc0VnB3a1hvUHNnUGhwM01NTWNJRVVkakcwQ000UU0v?=
 =?utf-8?B?eHN0T2pPa21uWnU5bjJNNzdCcXNBTG8rbGplYjBFb1I0Ny8rS3NJNWxVbE5n?=
 =?utf-8?B?d01FR3RjeUMxODUwc09BZjhweGFnWXJpNkZMMmVVK2Y3clNZeWJNdWRONzI3?=
 =?utf-8?B?cGFIVm4zUHFjbGxNbXJhb0xlbFRDbEtoVGQwRmxoK2dFaWhZZmR0aEZDYm56?=
 =?utf-8?B?YlBJMGtUUFhZalZPK2JERTBLSUhydFA0aXpNMEpnK2xpeGptK0gzZ1MzVXhq?=
 =?utf-8?B?QUZkQTRpQkZYMjFBaUdFOHBCR1puYm5rMFZkakdsVGxPdkx3UjFTRHhaZXRo?=
 =?utf-8?B?cFUzaWZOK0tiNnpJY1Y0L291bTVHQ0hiZThINjEwV2ZuM01lMVpqOTRRbXhz?=
 =?utf-8?B?dlVXclhTSmVFMDRxR2JZNDA5YzFmWm9IeTRaRjhiRUY2OW9FV0orVFpITGh5?=
 =?utf-8?B?L29nNlV3ZURFQ0tUQzVMY0JmQ1JoL3REWWY3S0RzRTFsNnFEMEZTYkhzUmFM?=
 =?utf-8?B?ejVDcG5YZVFRR25oVDhWampRV3RtdGVrekpSN3VxdnBQbWpxYS8xemp6blVB?=
 =?utf-8?B?SUNKL1J4SHhXVjY0MUpqZk83Ulh4S3pSbzBaU1lZZTVzdWFLaCtyZmhCVU9n?=
 =?utf-8?B?RHBNM1ZxUmJtQlRBeU5QNVcvOUFveDd0dW1xSWovbzROam1CSFJlNml5QUpT?=
 =?utf-8?B?Q2ZVUWgxTTlmWkpYMEthTDlFM1ZXNEI3SmJOcXVyTmVURlNOWEkyTGc1TnNZ?=
 =?utf-8?B?b1dEOXJ2VFZWOVlzc0NPL3laaUlySFNxRmpqM0h0OXZScGNEdU8wdUxmUzB1?=
 =?utf-8?B?ZFpDbmV2YXJ5UjlTYzd6SXdObEkxUnhHT2RtNlM2S2JzVktOWkJQSkpxVGxn?=
 =?utf-8?B?QlJjaEtSL0d4QVQzV3h6T25LeHp5Zis1VEcrN242TVRMb3gzenQ1VlRXcDMv?=
 =?utf-8?B?Ym92TmVsWnZ5bStqYSsrMm9LckdxazBlZnd6K1lDRXJ3Z2RZcUNRcHZidzRU?=
 =?utf-8?B?WWlObW1aSUZJTmVkdnBFdHNPaFVsLzE4ZEpCN2NSbEp1alhTUTE4KzloTzBQ?=
 =?utf-8?B?c3lNYVB3QjE0RllacTJqYnlLdTNiWkRBTUNlZGIralVjL1k4QTFUbk5KYktx?=
 =?utf-8?B?SGVTYUJ4YnVKZEtWUVhCQWxSWkc2bk1wRHVscWdNeGx2Y2JadFlKOGFaMWF4?=
 =?utf-8?B?OTFBc2JIblA2TERTV0RyeFd3QWJmbDB2TWliQVJxUFFDRVMxUkZhOUhsRno0?=
 =?utf-8?B?dk5PZVg1dFBCeWdVWEFoeTdwT3hKdE9SVXhZSVN2c2puTjZjUUN3VDZZeXhl?=
 =?utf-8?B?SXNRUmt5OEVGQ3JDb0hhbnU1NVRiUHMvMzg5RjdPazJXWitycUJlT2wxbllm?=
 =?utf-8?B?N1pCdnRwSkNRM0Q5NldKQWxtTEZZa21SdkhQSGhHYjJwUG9yKzBmcis5RWtC?=
 =?utf-8?B?VFdTZ3pvMnFqYWRUVHFQRHVWMFFoMkxRREhXcDE3bzdmeUJka05nZGh3Y0I0?=
 =?utf-8?B?ZlMxYUZJK3ZrSjRQRHRLcjFIdFk4NUpockkzQ0xZdjBoQTFEby8vSGx4cHZG?=
 =?utf-8?Q?8pGccq5kLuIpxkYlxWGub2w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AWEiVpp1T/2bK9vIdMbYUX+HK1Tu52U6iXHEUDN+hZ562NjWi4LlkzyM5K0d7cOabSF+sw6aZd79lYYEio4vlZej4/TgJ6R8tGplEgNg1ZaPI3e/RqAbXpNooUFBlfKOiYsvBzakBktVwHLKjrHICsDxhEyzk1c4qoXl1BQgBYl5o7SRjJGMlmW1e/oS8sOgR3IgLQ3foVXXVwPPl6szJLcCooZJNhSQpmpWcyDQzLM5uplfzuRs3BaP7kcAWTPuubJNh0TkROVc5MFN3wBuJdTE5KlX2sy5Zf45geAduMSfmQeS2OcfEPoPP59Pxyb+6jfdUAkpksmhSCIKEvK3Nllbnke5aYxJEhkkm5o73kNr+PL9l4WSUJIeyqN9bs/+rzzh2aGviOBd1nDcWSKR1v0cLeQ/3BqrFUwVVsRG7Cy3f3+qKoSdXr0pLXoTXLR/7NaZGG9lW7ZfUkHMx9aB6hY4l2UtBtrM5lwrYBF2J50xewydYiw1dPm0p3Ia537n5gWj7qjShWyM9j3myD6NwbR0rSN9j0sAbh2LUMQVmaQK20Ode8rc5K967822zQW2ojMkv+6fejs/AK/11hZztJ2YW1Wg2p8wxPbKOs4bG/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ed4bd0-f7bd-48fb-8f17-08dc6a82433e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 08:31:28.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di7+o7isj7Pjdgipxp0B6FCvG37cw0yEoVPXrZ7+X8JTFdAwN6HAqgt1klH8JYTl+x1SiFhs0pkFezFNB7JNpFCi6eOXPsL+oUnfWWho5w2OHagu1X3jjK1SooOm5T9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020050
X-Proofpoint-ORIG-GUID: WZCe3eqICEH7TWwcjHaOsefaWlQizoU9
X-Proofpoint-GUID: WZCe3eqICEH7TWwcjHaOsefaWlQizoU9

Hi Greg,

On 30/04/24 16:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.313 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.313-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

