Return-Path: <linux-kernel+bounces-103443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DC87BF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EE11F21F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD81171735;
	Thu, 14 Mar 2024 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QrDNZ48m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jA/VgFWi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAC6FE10;
	Thu, 14 Mar 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428390; cv=fail; b=R61koulE5OZbS0SqgeezHKxR/dSMEr3AZZbGE0aVeRQcPHAnGCGWTpAfDrDAh4DUZNTKJjEwgtuW7MGQrS1Qq5Ta19HIG2voPYnZS/DMVae5MrTGFcDhtGBWApAAmDA4fhbShfS3rLm+gt9wxWXGEC6dpfI1xMj6kGdxuMHz6zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428390; c=relaxed/simple;
	bh=hks0K+LyUtFnQTEvDQLLaV68CtH7fM//WIqjlD93MKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ms6QdE01ZZVbPMH9uO0ehBxD0WxaYwuTra1HKmH5ERTA53DdiPyptafVSPwX7nrxtOLoTJhT5gurZcHfk+INIMg0yT4LftsXqvYYsxMtm2Pajed+CsKt+OcvscmWUvt7UvBCC8wlIzSVHgitn7+pH5pSoEeiqdRhv83HUX1Mghw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QrDNZ48m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jA/VgFWi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECM0UP009410;
	Thu, 14 Mar 2024 14:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+bQWXoOkmaZv8K3S4/DUYJGm1EHAZCIYMEmZXTlvBaU=;
 b=QrDNZ48mtg0OCFcK7CLZebiERY+c0hK9aV8GQJuRAZ69fcUDLqI4B2vPxPdmIN0Iis2j
 oHbZz7TcuOGFezS2mTuMDpIWLhl+BiEPFhFTspJ7BhE6WSpk8BL0Qzco6y/mmfprm1VN
 OX4Pb4QJRC4Q3qmaywjcUyIKFT9ZZ5TekrMubu/xjphMpvLIXdFvPZeQ0SBoqk2XlDVK
 54XWthwJWVrsVsasO6lwcjwOGBodTpRxFeV8WaX2Z01k6HH3BPqcI/TQJ32KDZjd6Dv9
 wi945RF1SSAdyp5rScvBQ37JJPl4GPMIdIfmVW+jRltKszCT1Tu7w09oLxIbAazslHyj UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0ac0fgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 14:59:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EEImA2028520;
	Thu, 14 Mar 2024 14:59:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7aj193-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 14:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cytKyb3oeJxN3fXzP0op6i4M1DVKPo+oS+dUcudkJGyjQRMU78wUM63wXqrP8fuoiss+60xpJP+OOSQEke5S3X9YTWpyz/Ogu9S3YxWTZB9RQyqbCyYR8fP3CEBDQZ7r53C0w1JBCrphQS88dctRV7iCCMx5w23RevUZIXXkBwZ+jovCXgdIsIjUIlXAmEkMDr9om75Fz6zWCqPYvYM+c+xwkn4/hjwWL1TtvpA1wqiqmRyln3DqPcM6gsTV8Mt1210El4wy6J1FyGCb+VB2qTD+k23a1TZ/M/e5mvmqECxTKCRJAwCEtFdbHqWO+uxI11eeunjmWHOuXqMyJkyKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bQWXoOkmaZv8K3S4/DUYJGm1EHAZCIYMEmZXTlvBaU=;
 b=a/d6rK9E0HG9gmrN8Vwh/xLfyJ2k6I9ST84G+rWULqAcTJVm34wlVMuuLyOdMvBMRrwl6k/PWqtdzJ7TUHbvzbGjM/AOSQs5rUjgMAbsiSZ35n2D+CHfGks+SJ8snZvkviPrDN8wOL19IzsqUNH6OEihhhHJZVQ80XFifYmWkfQOKEm9FpD5nbecXLFZn5PsF9/zxMBMNIvSgRDBpr7YIPZgAzEs3U3f6zoF5kp2xn5wqj3f764RSRQ0KV2pMe0wkneA46CYbJonlq1MHgUWZo2XhMJNcyr0UIDF57S0X0I4TVtpnxcSE//nhhA7bvuHw4IJkStKmbqoI7tQSdsSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bQWXoOkmaZv8K3S4/DUYJGm1EHAZCIYMEmZXTlvBaU=;
 b=jA/VgFWi9leRhcekvLG1FPXVQJPsxeBHwPvR6HA9jmHT1OuJjAIc3Ux5ti2LFiOtiy/ttrnsqixoYriDsFnPxp9JZqkT9x8FnrxAeJfaPU0ml+aR/qk8STr6yfwtWfbAV56jR6YtlhHnMQBQVy2YvZhd2HrRhVdLOeo2+RTE3Fk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ2PR10MB7735.namprd10.prod.outlook.com (2603:10b6:a03:578::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 14:59:20 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 14:59:20 +0000
Message-ID: <58963110-11ef-47c2-8424-19fed50632f4@oracle.com>
Date: Thu, 14 Mar 2024 20:29:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/51] 5.4.272-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240313170212.616443-1-sashal@kernel.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::20) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ2PR10MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: c365b833-83e4-45bd-52b8-08dc443753f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zWIhdxOrMKHcQZ7b5og8r2eXuFNkmTcZUllLUonQYnrwIpWc9u6OiPF7Rou2xX3igEmMLXlSXBEKQxP/dP0WxrUjHvhBaAiuGfYcJWUK/G8D/kGSPzHgTY2mW+S/bMun//SSHe4Lz4PfYiM1bUO/s+/n/63L6QZjD8nHFfYtIWLRFqrzdrXHsaJVx5rfe8t+a5fsvmTI6yBLL51pNDo7+q8+E5mOafRdTlTf+DN7SbJXBCotWdxvra2tcrsG/y5y8VBYH5IWiuJTfxmowyl2Lml37UpCoQQ9pFxH9EYNCgy0vTH0fa7A7cbLZ0Xf0luam93tKDyYAiyX1+v51UWf2N4HvAXc8yd02kdeVK6ydyCl+0JV0GEjqtwNuxCWNCAn5GgVOppeIIRpgaLjdYd0B+4IvYNeKEP5DEBJhcw0Bt3gRKLw/G0ZO6zdWgF/eU6af/rEjv0npo9GGASlsGaTkN0XnoYuoa6cFeCaeBLsb6sH2ZQ9UwrW1lwjhfrkgR3t6wvobND3h8kkwnlz/6+s40A3pHyy5BYMutHwy9+IiAaWN4fnmWHjetgBEXjsfsfhCCJrgSm1EE7jDAwVHEIT/JPYu8r2N5ktgW3mKC6wcRs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QU83eFRLajNMSkMrY0dWeHpoNDRYVG5vZ3NsWWdIaWRrN0x3aHQyaXoxcXNi?=
 =?utf-8?B?cXpZL2svZWxDZ3BydDhjMWo0SFQxVU41LzBYc3g1NWtqTXVkRXpaemkxb2hO?=
 =?utf-8?B?bFg0RjJndDBVUVlnMnN3SzBlQi85YUNNMmNGVXdKSzNIQWowK3dBbUtEbUor?=
 =?utf-8?B?NE1yWUhScG1ML0w5QW5rWTRKTDBuY2lLNDA3eVNaMkg5QU9EaWhoZG1uUWcr?=
 =?utf-8?B?QVdFRUhObkJqQWFqSnM4cVcwd2gzL3g1WjNwOTFqaE5URFROTDg1Q3BCM0NO?=
 =?utf-8?B?emE2R0JoaXhnUC83VDJEMlpjTWlySkhwQXkrNmpFUmsxMDRkSkVlYXZtS1E2?=
 =?utf-8?B?NGJFZXhxaHRrbzBPbTh3aVpERmlZd1ZlRlRJNFdkTXc5cEJHL0FObEhFRThI?=
 =?utf-8?B?elVZd3FBVktHeDNqWlluK1NCQlZpbVIxZnR3NTVlWXh3RVRITHhVdWpKbks5?=
 =?utf-8?B?MGdDYUw3T0lLQzZYWnlsZXMyblFHQmJZRExJd3kzam9VYUdsZXU3Y3JPWUpX?=
 =?utf-8?B?SU8zZS8yUmd1Zm0xUUFZeWFZeGo2L0tkNldWa0VMNGRVL3F6K3JMSXlpMDNm?=
 =?utf-8?B?M1pVY2pudDJrUnJnS2V1VlltbkRNR1ZLU3E0cUZjVm9PdW5veVBydjBIQ1B4?=
 =?utf-8?B?R0R2ODUwZ1RIM05hK01jVDhLMWpnTFpaTVRtZFVkRFlIeDJ4cHZYMTRJanNt?=
 =?utf-8?B?YVQwQjJxdG1yUGFmbDkvclUvWjVVQ1N3TFBRMVpsZTJYd0NQREtQSVMvWlgx?=
 =?utf-8?B?MmJrdnZZTGJjOHJSd3dVMWtIWnlTUlFkcWZGeEMrT3A3ZzNmQ2RCWWhDQWQz?=
 =?utf-8?B?OTh2OXUySkhkRFRwMXBoeTFvY0l5ektNblBaamY5dVNTeFhrcGFySXZCemFT?=
 =?utf-8?B?ZTZZdDZCdEhzTWVIb0lsMDk1ZGEzVTRic1UwZVljZ2Q4ZUVCMFczVlVSYXJG?=
 =?utf-8?B?bHk4eCtpOG9TZmhwUC8rQWhCT0tIUlZxQUM5VnZlVjVzZ3M5aXFFcVM3UXda?=
 =?utf-8?B?T1Z3blRLOTlzQ1JwZVo0YWVBR2hkWVQ1dEQvd2syd1RlczRVblVKbG13Vzgr?=
 =?utf-8?B?MFd1SHp2U1FtSGt3VitwZGgrTXp4bTh4WHNDWlZBZGVOVVB3REhDNkR6b2NE?=
 =?utf-8?B?emlEODJxdnZEMFo4dkM3VXBncVRCenArV0t3MWxMQmNmZ29qbVhzRXNxcU15?=
 =?utf-8?B?Sngvcmttc2NyQWpuVHRPQ2QwTC9QbjU3MUtyYWd0OGp3bkloR2RZbURtQXJD?=
 =?utf-8?B?VzBwRVhScU9RQXMzV3pUcWlMamRVNlNvZGd1NndrbmJ6eStDS25YSDY5Smkx?=
 =?utf-8?B?VmVPUFpJWmZqQTNKY1RqK2ZCZUpnUGhHRkUvdkdFajI3S2UxWWNqVWFESHEz?=
 =?utf-8?B?eTFLUmcwbE9Cd2RWOW5GbFk4OTVUaUdqRG80S2kraS80YWsrbFdKeXF6NFR2?=
 =?utf-8?B?dSs3SFo0d1RXblJkVHBNemFua1RHallyeHY2cUkzWTNRc25lK2FJc3BLc3lo?=
 =?utf-8?B?Sm5lcDNxVDRTQUpLZTVpMnQvZm5ZdnBHTE9Za0FpQ3dOMC9xMG1iWW50aTZY?=
 =?utf-8?B?ZnpJRXV6cm55WmNaNWFkdHBUQlh5MFFudndueVE0NTNXWkdhZThaUzFWTGRw?=
 =?utf-8?B?TmtBRnlxRk5kSDJDY29rNVN2eTUwK3hxc2lEZi9RR0d6UTBJZ0JoQWZMWVBL?=
 =?utf-8?B?dG9JbU5kTUJNQXB4YlUxMXlSMlhCeS9GOUtpKzRkNnlOVjdhNG1SRERzU2RW?=
 =?utf-8?B?eTcxWEVRaHpGam45S3BIWHBDMWRiOC9RNDJMZld0TENKLzU0aDVpNVo4V1hW?=
 =?utf-8?B?RFFLcm1McC9la2V6Q3cxNE5ZNGZYYk1IcnA2OVIxbi9XaFExTXU2MFJQVEtT?=
 =?utf-8?B?c2J1TzhXbk1MUDRoeEtzMEZXcmk5SU1KT2tnN1lrano5T1I2R1ErRG90SFVk?=
 =?utf-8?B?UEVZbkt4cG96bUxnWlJqWHd6eU4yeVpoeDQxZjhMMVI2NXlHZXZ4Y1NtaURT?=
 =?utf-8?B?bDBSMHQyaFNFT25xeEhKNDJJQXh4L3NHTDlMcWxrU2lEQ0FzVVo2RU1jbHQ5?=
 =?utf-8?B?NUFsNzlHMXpyNjROdnJ1T3R5NnMrOElsYVdnalR1NDdCOFNyYXdKclVLWEpQ?=
 =?utf-8?B?VWV2QlBpbTBEc3pCdlB4em1lckNrMXphc0NMbjdlcW85UWRIRGFIZXdSVmc3?=
 =?utf-8?Q?Htd8LgxyzVJw2MmoM6JbepY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mJek5x5isG0QF+3waHc/ixCRGzCe4Thag/y2RTswl2YCrXcn9GZNn8qJHqhkmswSNX2fYtW4txkAS6bDdAOWKfsmq/urxh6N2Tw595zf+THCmlVDE1PO/fzvvOlKa8nMNJxloLBkxfSgykcdIfpw7pmxoYEyOxAmg7KG1NEROAs8r2OB20zcmjz4L91s43JrcG5dYpO/KEjjiOTOE5sGMwjxY1cOwK2BLuTYriFLbKTC5W7nfNN1+RxatTalmn4jBl6qmF3TuaBPzSIm/q/4HhmrVCMNaySAkAghZ/BJENFxKBo56h7FIPtTnq6ua450hgSr3wFh7RfYlxXtZR2qwRIX2D1JBD8tCLzbVLI6mPGcTFwH7q60PSTxZSKlMr0vJ0byt+6fL9io4M86qFCu56hHrltMPpcnRUrDeoHkB4UKpJ4ARROOEvf4HSdyoaugmjeq/lMMTEaun8kKeQgeaxb3f1Pdgy11Bxo3OR7NCQfukY4LmGG+edevh5CrbSoPLwSyEoARQoQY6x7AvRAdbdJmuZSt4us1+gMbVoXDTgcyPKLXM7eV8NMA2Y837IdMWoNGweVBnk3zCPN3tl62mbXP46LKpP2gHF++oBoGFy4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c365b833-83e4-45bd-52b8-08dc443753f7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 14:59:20.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35uJ7l9CvAUwe8UiW5wQC3srPnVdwgS8GGPS4QZlT6fhcvhL4N1eABZuBugbdDt2XZEThZDJZpDVCkxI0ysijdiJb2RG/Hz1xB7HayWLIP1gIJQptXo4aeruICExYdVz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_12,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403140111
X-Proofpoint-GUID: 5QPug83thwhyJIv5HWz6WvOLkAQNRMs_
X-Proofpoint-ORIG-GUID: 5QPug83thwhyJIv5HWz6WvOLkAQNRMs_

Hi Sasha,

On 13/03/24 22:31, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.4.272 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 05:02:10 PM UTC 2024.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.271
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

