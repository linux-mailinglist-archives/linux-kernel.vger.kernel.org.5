Return-Path: <linux-kernel+bounces-120588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D288D9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD21C227C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FC36B0A;
	Wed, 27 Mar 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hJb8H/fT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YXywH678"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F291C11;
	Wed, 27 Mar 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530276; cv=fail; b=UcYLEOK2mTnVH+b5v12Ggv27wuzOZM7CEhdq+5a5r+UNhwWbTQ6xQa9dVe1/5HAiDsqd1ZiXhgd2wsAiOqm6KrW+eCH9bnv9XqoioP+DA/tPI6qAcO8zSzofpaLx3vnIjQx+6mj9veaoES/dEbUQaX/f+t2YJhGnI+ZH/kHrRDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530276; c=relaxed/simple;
	bh=n4DVXB4vW5RLzEoYzoTbuGb6HZ5I/4kExKSkGK/JAA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FmFZsVZSu9YTsXlmdWQtHHloa9HzDBGPvbk02zOj6G6QPvCxX/JqPe35lOLFslttTZRGn8ARzmn5xM6hOomfXdJ+C2zhTP3sJIICQeM+IaHbXO7rd18YdfqAhuPsQyND+P3Osviu8Oyu8KdL2obVugiVl12onaeFNG+OwmFZVlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hJb8H/fT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YXywH678; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R87KFE004512;
	Wed, 27 Mar 2024 09:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5cJiYrORnv0WJTCju/v6VlTCnIkssz4Aol5x3ysgRf0=;
 b=hJb8H/fT4Q4HyOgHmhdYI79Kaj1QLYKPCtD7mLl6Qs2lpYBd2Y4mN8sMFyND68tB2fjf
 tIMhxeBjTOt/j4Kfg/aVO77A6mAFpuXvUFvmdIxqHv/ouI5kB4uqeyFDtEeL8SoiiaHU
 4SYMrnJamXkKS0dEcKwJngOfZa1hGXNi8Wf2vfNgYgmMtfBMaOPpQQ7kuLF3f6wob9q8
 6QQsrEXWskVI/xe2vAykeGEuwTqwEJz3MDDoRAXe5FRE14jPA9TnOy1blAF3JQlWNz78
 fD8zyH8c6+uNJxjAcuscNZBp0LRJlmmZBNtap2HXNgJuWJkRq9drRyal2Nvy1YyOqs1p 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1nv46ws1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:04:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42R7dDkQ019857;
	Wed, 27 Mar 2024 09:04:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh86qpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWCpzap1raxpt3Xp1a2ObyYEwEwjSO/zmqz++oB3LKXigDMxom/jrdcqUEJTUBnW9alu/yIuP/uwaSdwvQ15XlbfaGp0X3Wa8esHUtAN+bgSkF7S8z906fUGnX0O6MSXwmLJet8GfXkxEGAGQkq4e8tED7H1HU3EOH8w21VN01nTBUZSvyQNs9qRkjtNp7+IdpSoh1pzIh8qy1KkwAEuQIXxca1LXeM0BSFF+4c7SWWYq4jewCkaAN4KH0c7cIVaZaVqIvPuBZsYWa6BHNOBftRpHjk3wu/2HVmxYaPMVM6vXnT7sSQkxiHA+nP4xST9qx5Fao+HsARjmbM600VveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cJiYrORnv0WJTCju/v6VlTCnIkssz4Aol5x3ysgRf0=;
 b=O3n1YOy4OrclXCSw36yfYXe5JscZB/nz9Sc2zKf6PmZvW4HD/hD94Pr4u2hWJp2SWrTx/4793LCFbCAHfBQMFqEesY3BDy//4w/WF2Vufl7jLMhVUGONAqvREnc1rc3+xrDHINnRCdqnNiA04xEouKuTBKo4ZO1UPEURJZCh2sSv39vsnypHjT85z/iBfRtqk9UtCrDdDH38uQsQltPliOj7dLLuDVwUF+Dk2/klwbnOrwMORmNaW0KMJBL7xiM0L/rcMcP255aM8b8BV3U/ldL0/LYSRQ58f3jwK0D1BEAFA1RAR96BAvfeH4/LJWKpCTXfY1p2pWSU86pSdZanEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cJiYrORnv0WJTCju/v6VlTCnIkssz4Aol5x3ysgRf0=;
 b=YXywH678d9DVjrO1n+wDYBxOpU6cR44qLxgrvggvzBYFGEA7oS84yQ9NGf42AQK1hGGPAdb4noZ9/HAHQYnbJ6HmFAygLmWy4sDIRmV+dmbiQGO+ZLRzzjmScFi49K2ZMVQTLd4db0wIMNj4slgW7aUofqe+VZUV4/LWnT3g254=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB7556.namprd10.prod.outlook.com (2603:10b6:806:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 09:04:14 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 09:04:13 +0000
Message-ID: <eae68d5d-e079-4aee-9454-a7a79fbf815e@oracle.com>
Date: Wed, 27 Mar 2024 14:34:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/147] 4.19.311-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
        pavel@denx.de, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240325115854.1764898-1-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240325115854.1764898-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: f3071c8a-2174-457d-ce32-08dc4e3cdf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KoPRYL535BiZt56XvLLsg/z6sHyWcI7nU/BsWueepnsbOcf4iJQbsFKDGySqHBjmLzqoHbsSaU87uLwmY8bQ2rQHajyCIwaeP5lnAe2kzrDNe98aBIECfZCMKWOBGRB24fP04e7Ntsf5BPZuxuP7CfsNc5auEqJXx4jxQ5T4uTsH429FFhvwOjsjUNQKHIPHD3S9fssax+WDt5ykubpgfnOFDf0xb3gcoQrzpq1I1uGzoxLgw/4AFXkpB1+7wgUefU1lmfG375W7bRhoo034MUjxgfHe0DUcZ4BynR0/lrp45PYUXrWyERmt11FexAlxVyGcNmrX+Mn7taqZf3wEYs+4iKcAdVNV929DO286DQfKQHHZD2OisrEeoGl3yeASsW2JT8xwVzY7qsTK2tXAGJMEDMrfhVlIknd/Ive4t8n96DuxY+Dp6bFy5BPeTqGpT1ytuixCvTjrPgOrlrZrH2542WlVO4Pprqn70B+IkUgvaZIBVNJImR6LJY2sUAPvg0h2Qtk4uGQ7u4qTAF28TcFR79W5w0+AvS7CI0pbK0GYdWsydtYVs/hpvasUwsl2bJCOws4cDnfLEm6d7FdVaoU5iFSi5NZd6Jnpq8c7V/8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVVGbm96NTZBNkZndlFJekk3NTMrSW9TVkkwQ3o4M0ZnNUZtamhmY05lNGg3?=
 =?utf-8?B?czF4WG9xaCtjNmk3akEzQVZNTGNablFCMmZYbkQ4K1Fua2VYbHZ2eHRzdGw3?=
 =?utf-8?B?WS9jeVZRK0RGb1d0YlFpRnhxaEMvcm9oaVRSdFFHQVh5T2w1SlJiMWJ0cGhD?=
 =?utf-8?B?YjFwRWMvV3BGMy82QnFKOS90cTlJRkhuc0QzS0t1bGdKY29sSmF6MFh6RG5G?=
 =?utf-8?B?TUxEN2toYmpSVHhXUkd6QWI0WGpRZ2RvSUV0aFU0SFpLbjlhZXZFWHdWaFB2?=
 =?utf-8?B?MStuVGRRRk40R3dRM3Y4TXFoRFhnMkhvS21GblU1WG5aaGk3UDQ5SnlnRHdj?=
 =?utf-8?B?SnJvRFl5aWVmbU1USHhsZCtyUFhQMEkrMkllaHhFcDRYOVJWeWlLKzc2SzBP?=
 =?utf-8?B?dlBLeXpIYmxWa0ZmcmcvanJJQjVLbHdxbUVNUUdkY2pTTk9DaUVJY1RBRSsr?=
 =?utf-8?B?ZS9KOUQyL0ltOU9QOXRlT3hhQ0NqYjRMWXAzUXVXbER4Ni9ieW8zUXA1YTJu?=
 =?utf-8?B?NkhQclduRzF2OE9jWlVWbndKS0tncnp4WmIwa290b3dhZEs3M2tCbndMdENy?=
 =?utf-8?B?U3MxUkQxeHpacWo3bkgyWGh5OWpVQ2dJV2FxTDBIWG9IdThrNWFaMnBsU1U5?=
 =?utf-8?B?VkdIMlJUaStTMUM3VitKZEVKZzVidHFyUEYvOWVZdEFPUFhHa1I3TWRWcEZv?=
 =?utf-8?B?cVhmL3RHdzMwOHlrUlJMR3N6YUczTFpUY1lDdHk5NldTbmQvWkhwdllZSmJF?=
 =?utf-8?B?clhqZi9XV3Vaem1teUZGenpsbWdSb1NKMktCaGxPcnRNeEpzTlNydXFJbmpo?=
 =?utf-8?B?S2MwVWxpenhRbmVVbWt1UngrL0hUb2xWNy92dCtGU2RzeUFvYmF4akNLbEJ2?=
 =?utf-8?B?WVNXNWJPNW5qNUx0azg3QTdDNkdldWpKWmpsMWk0ZkVHcGpCb0VYYmtheG1M?=
 =?utf-8?B?QWw4ZVJOeTR4NEtzOXhqL1dpQSt1UDg3ZjdoMHZQR3MvLzVhV0hvb0Z0YTY0?=
 =?utf-8?B?TGxaWFdxS2YvRm9KeGwvdVlQTXVVOEw2dnFoZUZiUzZ3QnZVK1VsWUYvMWVX?=
 =?utf-8?B?Njc1UFB6N2dJWU9tOG5jWXIrOHJZaW93eEcraG8zYmRBck9qdWgwNkZibEdy?=
 =?utf-8?B?UzJ6QkxXV2NjZGs0dXRrWEZTVWFDNEhXYTk2dEVMRDJUWE9FTm1mdFNsSWRZ?=
 =?utf-8?B?cXNQYmRiaHRsL3FVWHJzVzVjdWhjdmdNb2hQZ1V5ckdack5MaVR5czUvWTZ5?=
 =?utf-8?B?aUNTVi9TV0RnVkkwTm9GWWRGVEF1dkNUM1FiWDB4RTVUbzRmckhMZDBtK1E4?=
 =?utf-8?B?WWpVZ2pTR2V0NTRZbFFOcTZnWE1vK0lzQ1VRWFRrOVRKa3RhdzZaTWxYbnRx?=
 =?utf-8?B?a2ptSlRCNUV2bWYwV0ZlM2U0S0ZDM2FYZXBzVVpxdmdhWlVvTWQ3Q3R4MGw5?=
 =?utf-8?B?YjR4cFlDemp4UW9zUFlyaUFCK2IzZ01PeEgxd0tlNjhQVUhFNU1HY21QdmQ5?=
 =?utf-8?B?ZE1wa0kzem5UYnBhS1FWZlFFT0xMN0ZBdllwVUtIMnY5LzhzZ3BVUnpGemdP?=
 =?utf-8?B?UGdEZ2RrTG9WeEVBelcreERvM3F6N002Nno4THFwVWU3RHluZE5YKzEzRUIw?=
 =?utf-8?B?L1FBUWdZWEpaeEo4c2FyU2NyWnJmWkdReTZJblNuV3VqUmtRWUdyMHNzdWFC?=
 =?utf-8?B?Z0c3U1BEQzIrWExkSkJoQi9VSkVpMlJYUHY0bUU0czJ0RFlMR1ljMy9yTlM2?=
 =?utf-8?B?ay9tV25RdTBFdGhJNEpVTDFjdjlhdnd6U2luZnVpbXA4UWxLZUhuOEtuVnJR?=
 =?utf-8?B?emZqa3ByMHROcUdTK3dGZTRVYjhwMTRBaDFwaFlYSk1vZFlmcjBvUnJRMFNO?=
 =?utf-8?B?K3VXdzdkRDB2QzMvNVM0YXlrM001TWhvQTBzTWVWeitDKzAvbXc2WldRbmNT?=
 =?utf-8?B?R1lva3B5U2VVY2UwMnVwTDZtQmlWbUdvQkJtdTdYeUxJc3prY0pBUWU3MTJE?=
 =?utf-8?B?STl3SjU0dmZyRXM3WWQzQ0dHLzhnK3R3aG00a0c1eUt0VThPNm1SR25EdVlT?=
 =?utf-8?B?c2VLR3pDUk5lQVJiT09OTnhyK1AxMTR4QXBLSE4yQ1NtSSs1a3NVZWk2V0xt?=
 =?utf-8?B?Lzc4WVNEVW1aM0xud0hneW14VnpMSUYvYU1XeEVack15WDYzQ2xkN2RZaUdP?=
 =?utf-8?Q?mxZe3Y1asty285cO9fPccGw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q6RdRNRTkriizIeEHId5z7mEDitVo+qHjxgGCxdN+rgMj4XvSw9mnSzwX+SjbfVap0aVxtG/chq7Q+s6Vnp6txpbcmCfnlomQyEnxPYiBE6nMjtIOmnezlMLq8ZiitCMGOkZYPX0n9O6rCiAFRtd7ZuSzV32bbFyDXpTkciQXm7krhESsc51EPmP7IeUKiOFgMIXaMMWFCOJYeXFK9EcjvLNUDPKZ14r3JXXHfyrG0OXt0NgBaq+/BGKVn9FFLEv06A2258q+5n+6mPyAZN/6Njm9Joxe172XFM2832e8sV4koThk4mfufEH2pH09Sy/GIjH349UssGbiY47csCasqePUgr+iAAnH3zYNGb3z9l+T3saP17n7zZAAuXz9fatsEOVBHVFTIcWAWa35kLMRN8JHbmp3tp4Juc0+SfkroGRLNpzWdUG1mThROtcL1aOjbkjP3luz3FTNq0E0AjVrUWkhRS15H3a8k6DF69WS3fZ+XTEz4VHMFR5swo0/bTgLgiq46LiJSi9RBnijyBsshn+qGz8d21Xd6ncZYyeOhO3K2iheEhYSB7rWEAy97eEtfTP988ekG6kM4/i3BwJ3L+P2g5hl2dhkkwM4Kqyvpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3071c8a-2174-457d-ce32-08dc4e3cdf9a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 09:04:13.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Er+5FaEGiJu0JlArSTKl37cTrjzKHBaOXZf0kENBqa15G+yvNB4o8Awi8w7H0bm4EQRzPr1WiaduMxV/p7/ysSE67tP30bk3OzUAgEbhf0qHU8hFnQpd5uJrvyPGZiH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270061
X-Proofpoint-ORIG-GUID: y7FYB93f2kEEtrChVKqoKRb4_-l5-OF8
X-Proofpoint-GUID: y7FYB93f2kEEtrChVKqoKRb4_-l5-OF8

Hi Sasha,


On 25/03/24 17:28, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 4.19.311 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:58:33 AM UTC 2024.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.310
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

