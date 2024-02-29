Return-Path: <linux-kernel+bounces-86855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FBD86CBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36CC1C21B98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954B137747;
	Thu, 29 Feb 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WMLcA6+d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iad6YVfS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2C13D31D;
	Thu, 29 Feb 2024 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217590; cv=fail; b=stVn+Y3FDc0VQsx3kOJ1pzlCSjpSYq94S54UbZ50bsdzk/jxMddlk1JO/Iki85+qC+/Z2f5x39U59zkrnFkEllbJIgSHhJXw8p/ljm4IGPGAwasQRryceJ9YB9DVAM7rCoPjj1Z+8AOgSHfDsvh8Y0n+9ooRE3i3jBhmbgMr4PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217590; c=relaxed/simple;
	bh=s7nIArq9DmElwVoQ8v9Hoiwmid5b1I1KB7RNj5vVKgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WRAqAiiG0W2Z/BXHuowBSTPsmX3prn7z8TJrSbuoEa8uUccpkAkRClRLLLLagZ0Z0TrynBXaQAgYcq4VI1EICzovlRxIyJZju2DH4/TwKivhcVnQMlRa62X0fjOSxZ7xFKPDQhp28J8WpcLNux1PdKJL18HwMcCsAf4Yh+9C+Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WMLcA6+d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iad6YVfS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T9MBaA017435;
	Thu, 29 Feb 2024 14:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YE6Y8QnSyx+UffWXCgprem9SBgTN9oQK6PGtSyelKcQ=;
 b=WMLcA6+dRKtWRrqcwuFh24+tPGsHr6eB3osx8bkbsWKSZTbExGK0CYRfaZUGxYY8vs/U
 t+xgGIMiTNudqI8ImFvSIdpsNfUyJG3M1gcuj+Bx9CSDNRxNxIsGIk3puNSILogGn7kB
 RQtp8qaVW7NlLpjqBu6Pa8kp1tAQsJCitE8Y+f72pg3ongKSXq/MOSJO47NL9lk7C7RW
 CdDOGFDijuXln24mnOF1q6VfMrbA1+HeFG+SK5uiXZtafhao6uknAo7D8GBoOEIgPtvx
 bJLPEth05BCD1wl+zJ4lZJq8mM1t4QZY98wwhSA6kTXCgnvQs4sV2CjRFNjErzFAzrhh qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccntaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 14:39:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TDrAMx010002;
	Thu, 29 Feb 2024 14:39:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wajg99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 14:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdItFQA9nSRa+HQ4EF4Zo6zXzM5RUMzTi0dzcWzpaThkLUQjNkJ4ko+p1CISTcZl7mEA9UKeCzVvIGNEZdKKqS0hRbcK9LD9Umbnd+LcT4WuHSUR39X2b5yjGGxP7NUI0fK7dlCPQge5HLWY0JnFDeZe/8SHZwGkWNOGrKSSvIeGhqkiJLtmY6EePGbKoycrto3yVVFNXaFv66cbyw5XDgIzQEgtBFKnBs8BJqEcGIkvhK4U8hhUJNnNw5AVC5EBlGbgGqLAXs8N0M3M9wdU1nGatkFWmSyuxrXR9iPEijTwgUSyoBPK7MUtldfi1uZOV1Rt81g5RKJvsTPw2Atc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE6Y8QnSyx+UffWXCgprem9SBgTN9oQK6PGtSyelKcQ=;
 b=W8Tj3aDLS6rNTCESzLKfN9NV2CbAr9unizv18318/f/nLXtUiXGq643w4KLIuwF9yFRoCIkkuAX2BRZzDxAst5tdftlp3m52aNoGGlbrCXPF2pGJ38L6OtARmi/bPj8914PcnYA7K5eqQpRC0fA4NdzOtUWOsFsRLen5g4a9jphb1wARibFNRvWZg0NC/pq/izUt/aJimjOXc7qGnLxzuWRz+GKvW8rdy1lMsqtx2w7zJOM59elLKSOvSa6jYdFnsMDIxIMrpnS815k0KZ1s8+ogmt0pzyA1+p8DVKHbQT2X6IUbMGLpybm5XmvpLMyCHhsLT1oy0tlP3RMvQTn1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE6Y8QnSyx+UffWXCgprem9SBgTN9oQK6PGtSyelKcQ=;
 b=iad6YVfS5XDaBUVeEqCCpEuVJgWcXpvkDjT2b6uyL/kfS4chQmjtdw/zRJxWabJi/gM7QTRvgY/Sukkd6zo3L75atbTd78M78y1f+/oKoOL5xRg6wQk/fSOJnVr6FVnKmG31NYd/gRzRw3YmBD4rk7kK7ZiF90MlRaa4XV9Pyuk=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 14:39:37 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:39:36 +0000
Message-ID: <e6441dc1-6821-4514-b285-ebc24114aece@oracle.com>
Date: Thu, 29 Feb 2024 15:39:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: drop the version constraints for sphinx and
 dependencies
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula
 <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240227131410.35269-1-lukas.bulwahn@gmail.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240227131410.35269-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::20) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 0464b722-3752-47ec-80f2-08dc3934409a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0whMC8gPuD3xxyN6GgxJ5mQ2LYu1FQCMslD7gBdELakWAW44LwAnHHyPsS9XG3pSD9JbkID10kNiGeaYBFPsnPq0asGUBhFHOGkk+GomjZKPGeReNEcReqklO9qSn/U42mQO3UVk9fyzFX6DKEqdjD0LKzDd/3Hf7W7iR+f3mSOMk9KsjyBZdFDmet1hnD09odLWRzTU0L33UHxoRB7Mdh9zWG61q1/XksPdXnAxAIfvLM6jKkROVUy8BXzdtJJ46D4jYM6rZbtLakx5Wx6jaJVPwFqzbXvHneJI5PKH/YJSh9KSeouxgskniKZ9gsPq9qW9XXd2dOioXZHezxIeNYM8Jfc2pgt+lUAxc2+ZFwcANu6NzekDGbo8wfUheE/zeZXNn5uT/pMh9cE5vJhSj9COSSwdxYkrVtmjdHaAW51rvBBH430pGhoRy9B3HyJHMVEwcfsSL2dPFoqDtPvCMgaiHAYbOUuom5SmTp2NX+F66MEfKkyLkYY/ttcqVbpq2BM+qbXfOhUv6XN/rVyLG7K5P3PlTrHl6HLuZ+t/AftjHLLX9AOca6u9f+G8y/ah0LQB2Oaiy+FKy4SaO56A35LXbfNAmFQrqTojgiItq6rvtW1KUd73QprgdsrSaRgY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T09mZS9hSU5iKzk5Q0FoQmlSTkgzNEhUQ21ZektaL1hpaDF3Z3NHcm42NGNM?=
 =?utf-8?B?MDkrU1BQaW9ucTNNbU91ckllYk5XTXZaNTlHQjJrK1YzZFFPMnMyb0IybHZv?=
 =?utf-8?B?UFNsQU8vWUJTTTNpdDArYnhNQ3AyUWI2a1BwQlhrU1lMcWlMOHlMRHpvQ0RZ?=
 =?utf-8?B?Y3VDbFRMYThJNTJ6YXBxaEEvRFZreDM5V1VJVGdGWU5WZGpSS2ZHcGNUSkhW?=
 =?utf-8?B?T1JsOGI1d0trcjJQVXh0d3pBZXVxaS95WVUxWFFHMER5V28xcW9oNnlUVk5T?=
 =?utf-8?B?VEFGMWpCVkd6Vk1TakdpMk9kc1FYZEh6MENXTUYwUFZYYkIzTE5DV3lzai9W?=
 =?utf-8?B?MjJsVkQ1ME1HaitXOHBPNm5xN2libHRKVElOSzBaZERUSTRBTlB4TUIrNGN4?=
 =?utf-8?B?VjZYUFFYeWVhK3ZBTTgyZWtWUDZiUmtPb3FQVFBJcklTekJLSzB6Q1VYSHo2?=
 =?utf-8?B?NHRnK1dNSGM1NGZqdEcrMGZCOGUyeUlUQlcvT3RSZGR1cldQSFkxM1plL0xp?=
 =?utf-8?B?Q2Q5aUtGdmYySkVwRlJYTDRUdXlaejJXK3RxQzl4bVBON0tId1FHTEJSeGRZ?=
 =?utf-8?B?L01qMWRQajVpYytDSVpsUHZZZFdlRFZORVZOcmxackhORXc3TUx6T1ZGNUhi?=
 =?utf-8?B?aWxDbzlSdmFxYWI4bE5sMThta3RiZWdUaVcrVTU5ZWJiOFJ0YTQyT056dTZZ?=
 =?utf-8?B?VEhTODBQNnI2aGdZaFBzWjBpNkdUQWxmengrMmRIaE1WM2lROFJuTUdzWXdB?=
 =?utf-8?B?RVVhL2NPM0JsSWUrbUlELzI5Q3l6a3VUVENMWFRlb01xUmNVM0Z6cmdkRytH?=
 =?utf-8?B?QXhRWWtVZnBQZVJOeEhOOGI1V2JlYXdwYVpUcmNKemlWNXNoeXoyN1BNVGRt?=
 =?utf-8?B?dCtkcFNQcHJDZGx2UjIyU2R0OXB4VHVRVDkzUGhubmlGTjB5MDZJT3p6bngy?=
 =?utf-8?B?OXZSOFZrcmZxbnJlYzVmaGhaNnJKOUlBVmdQem41ck9IZysxUlE4c0lrckFH?=
 =?utf-8?B?d0QycnNQTnlRbUFGUHV5dUtiejBqQ3VSWjlscU9FUGtpMkJMVDBLSkxscHo3?=
 =?utf-8?B?cFcrbEVOVHhyeWNFS2tRNEM0MStmTmp2cWdrZmVHMDBvdmIzTm5TTzVHTnRI?=
 =?utf-8?B?MHUxcWlRRVVTVjRFWkx5OStUSThFQmp0bVRKSEQxNmdUdVpWTEV6TGtReElr?=
 =?utf-8?B?dVR6Y3hFSXZSNklmckVGWHg0aXowU0FJeitUTHRIUm8vQS9YSFBqcEpNM1Az?=
 =?utf-8?B?aGpLOFRKTk5EUkZ0eDNKemFNblFrNzV1dldXVk5Bb1IzZlpEWDhFMytZdFQv?=
 =?utf-8?B?OERObkF0QjVzcmNNYzJBZ3B1MVdWVVhnUGdWWVYvL3BHTmhiR2pZMm1Fa0hC?=
 =?utf-8?B?SlVFaTk1QytUdHQzQ3JaR2c2VWpXcllkME9jQzZxZHdaQitIRGlqaHgvYUY2?=
 =?utf-8?B?WW5BM243blM5RFhLTnR5L2loNGlSZzZqQm12b01mZ3ZXVHAxTEgvbGFaZm92?=
 =?utf-8?B?TTVCalNaYlR6enNxcFBUVmlpL1YzNXRrUk5CWUc0MHJEUUZoaVRnZzBmN3B4?=
 =?utf-8?B?NzZiOTZsSW9FVkk3NGxpaklUNS9WMGM0aFpsY2oydjVaZGUyODJpSElpU3BQ?=
 =?utf-8?B?cnVoTWtPbWpsQ2kxN2M3RjVCeFpadXVJQnJiZWh0blRGTHBTNW5BOEZtVGdx?=
 =?utf-8?B?eGJRRExTZVY3RUdZdzdJTys0Q0FyV2xQbW5BV0dSU084TEp6WnQ5UGpIMk1q?=
 =?utf-8?B?ZHFxVUhON0F2K2RaZE11NFBGZEdiVTd1akNjNWZnOU9sTFlIRWoyMHh3Ukpj?=
 =?utf-8?B?UmNlemd0MSsxNlJPL0NoeUFJcmVQMnhXWkVBK01DOEpuR1JmaHlGUFIrMkU3?=
 =?utf-8?B?VEVPeTJIVkpPbXNyRVJONU02NnBINHE1dzVOQmNkMTAwNi8wcUsxcWJDTkpv?=
 =?utf-8?B?Nythd29UeUtmWFhyZXJIZnpDNDNlaCtMb1ZXd2hmcTFmelE4U2FpS1FXVGJE?=
 =?utf-8?B?KzBLT3FMR0pFcTdEM3RoWHRCbDcwM09zKzAxVGl5dU5ad2YyMk1IL1BlUk1O?=
 =?utf-8?B?eWxkVlpFQklIYWkyNFprcndYbks5Q3g0aUs5T05udkxxU1BGTGM5ZTVWSjNH?=
 =?utf-8?B?M0ZHUDBNYVBpdnBSRHg3U2MzSDQvc1RtOW1reDc1ZTU3TS9RYkxyVkY0MjZX?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oK+Aa5FsSB6cwy8H+dhaKgEx2BLmBy18LroNWb2f53UnFDcnKKxcwpXiA9TuYlWmM7R19k2MQBH6xlRLX1xTYAS3Tkuh+CXKhmMa0bHdm9tOruvIwsXAWvRmSzAU1PlMnrLqGXQZ3KrIO7mOHFeJYl2snM5QDBOnxtfZC4zYJJriBvA8yr3RKThgcTqZrn8YsvqTStjk9KtvC77rm3PnLbh+xx6NEbW1YVVxdyhyA9PaEOXoXOzqEytKbyfDZmsKcxq7ZG5zx0RXndPeEktsdtJoydJGM+GEOW/UmSdL9hzLs9LriRBXeVXWgigKXwd0u5fF5vsyHokpMnH7PRO3RTCOxvRwerD9lcVNuRk3Ar5042L9VpEuV4wFK3yXYYnqhcjkg/kf3fNpdFem7claGn7gkYU6plU7ZaJDel3A+Ans+kt2B9fwhwd2nWdVV1SP3OTHBWxQtHBdmK+fMxgJ2R8Rg1JA+8+MbXCsAY3v6nLGJNOjUkU5c3rPXwJ5i5sS/iGuJ67EYN0ozS91p0q19aU2pdOyRhYqKz8p0FugOGUZq1fec7nf5FRS7n6mCWW2B+X/VaIxl1OSI1/jqB1VfjkNycVP+W64xvQw0ZDg6R0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0464b722-3752-47ec-80f2-08dc3934409a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 14:39:36.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIC1gztSNDGj3Ca20D4Y+lxRg7ciq6mtdtD2qkuxpgQhBzJwqfzvm+0QzfPXyWBbuI8CuKQB4z1O9+SfVO7Yb82CnY2G/xmm4Ig7c4Smqc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290113
X-Proofpoint-ORIG-GUID: 1LX2Le3dd6Om1YlGChCy-KQvUhYxECsg
X-Proofpoint-GUID: 1LX2Le3dd6Om1YlGChCy-KQvUhYxECsg


On 27/02/2024 14:14, Lukas Bulwahn wrote:
> As discussed (see Links), there is some inertia to move to the recent
> Sphinx versions for the doc build environment.

[...]

> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
> index 5d47ed443949..1f3b98eee2c9 100644
> --- a/Documentation/sphinx/requirements.txt
> +++ b/Documentation/sphinx/requirements.txt
> @@ -1,6 +1,4 @@
> -# jinja2>=3.1 is not compatible with Sphinx<4.0
> -jinja2<3.1
> -# alabaster>=0.7.14 is not compatible with Sphinx<=3.3
> -alabaster<0.7.14
> -Sphinx==2.4.4
> +jinja2
> +alabaster
> +Sphinx
>   pyyaml

I know you wrote this as well, but just for the record I tried dropping
jinja2 from this list and it still pulled it in automatically:

Collecting Jinja2>=3.0
   Using cached Jinja2-3.1.3-py3-none-any.whl (133 kB)

> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index de0de5dd676e..4c781617ffe6 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -280,8 +280,6 @@ sub get_sphinx_version($)
>   
>   sub check_sphinx()
>   {
> -	my $default_version;
> -
>   	open IN, $conf or die "Can't open $conf";
>   	while (<IN>) {
>   		if (m/^\s*needs_sphinx\s*=\s*[\'\"]([\d\.]+)[\'\"]/) {
> @@ -293,18 +291,7 @@ sub check_sphinx()
>   
>   	die "Can't get needs_sphinx version from $conf" if (!$min_version);
>   
> -	open IN, $requirement_file or die "Can't open $requirement_file";
> -	while (<IN>) {
> -		if (m/^\s*Sphinx\s*==\s*([\d\.]+)$/) {
> -			$default_version=$1;
> -			last;
> -		}
> -	}
> -	close IN;
> -
> -	die "Can't get default sphinx version from $requirement_file" if (!$default_version);
> -
> -	$virtenv_dir = $virtenv_prefix . $default_version;
> +	$virtenv_dir = $virtenv_prefix . "latest";
>   
>   	my $sphinx = get_sphinx_fname();
>   	if ($sphinx eq "") {
> @@ -318,8 +305,8 @@ sub check_sphinx()
>   	die "$sphinx didn't return its version" if (!$cur_version);
>   
>   	if ($cur_version lt $min_version) {
> -		printf "ERROR: Sphinx version is %s. It should be >= %s (recommended >= %s)\n",
> -		       $cur_version, $min_version, $default_version;
> +		printf "ERROR: Sphinx version is %s. It should be >= %s\n",
> +		       $cur_version, $min_version;
>   		$need_sphinx = 1;
>   		return;
>   	}

Tried with a few different versions:

$ (. sphinx-2.4.4/bin/activate && scripts/sphinx-pre-install)
Detected OS: Ubuntu 22.04.3 LTS.
Sphinx version: 2.4.4


You may also use the newer Sphinx version 7.2.6 with:
         . /home/vegard/linux/sphinx_latest/bin/activate
[...]

$ (. sphinx-2.0/bin/activate && scripts/sphinx-pre-install)
ERROR: Sphinx version is 2.0.0. It should be >= 2.4.4
Detected OS: Ubuntu 22.04.3 LTS.
Sphinx version: 2.0.0


Need to activate Sphinx (version 7.2.6) on virtualenv with:
         . /home/vegard/linux/sphinx_latest/bin/activate
[...]

$ scripts/sphinx-pre-install
Detected OS: Ubuntu 22.04.3 LTS.
Sphinx version: 4.3.2


All optional dependencies are met.
Needed package dependencies are met.


One remark I have is that it didn't encourage me to upgrade to 7.2.6 in
the last one (using the system Sphinx 4.3.2) although it did for the
2.4.4 virtualenv. Maybe that's expected. I didn't look into it. Anyway,
FWIW:

Tested-by: Vegard Nossum <vegard.nossum@oracle.com>


Vegard

