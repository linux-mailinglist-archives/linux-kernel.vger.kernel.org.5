Return-Path: <linux-kernel+bounces-142472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C8A8A2C00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B821C23584
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99C553802;
	Fri, 12 Apr 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F9RZn6BX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hxyZlG/X"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952453384;
	Fri, 12 Apr 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916658; cv=fail; b=LaMLv80PGA3zneXxZlAiKdX4xgdTCU+JAjMbXcBqI8BualY1Xb1gc/a3lzcl5k4pzWBGHwmmKq817oRXsjNsaTO5z9hhDgcX5xGgeq56z4p16curHgqUbhstElf2UjIYUwaLNqrcQwOJMs50TI+NfCstlV52V4ksj4N7c/wEX2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916658; c=relaxed/simple;
	bh=W4f6Bz7E6dyM1ViwruF4qYKhY0y9xQk58sr33lrec2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BjWkTzdWM51SDr7I+dXSe7ZriGhZNf0tyyIFPOpH9uGQ5zb6RZPYfMY+5hhPUuA9Fn6fWlmPqrUB9l79HHpzJ1KxpJnyiwqALJPUeU9ATXvLB29VaTTojj2dxGxKxsVYR7jwYwIWEeZxvltXuIQV5Fx/M1wpIU0h6gbxCZdJKII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F9RZn6BX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hxyZlG/X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C94NCE026619;
	Fri, 12 Apr 2024 10:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Nx/LcmHUQjKpjyhgNouGWOzotuHZItlpdKR3cm+0opI=;
 b=F9RZn6BXYsMfXQXOLEn9uk6SPynUHrRekhTnj9XlrmyKJGeMrQuNpGN/1HFlJnn29WPh
 u7diJrMkMAHniDoFQsSjtY/bW5R1iaNaUpurty4KC//LvFja1O/eEg51uUG7jj6F4MBD
 31BnHcPbGI0x+2lMGm0VuFSIpqFuO+6Ct+4jHvZBbVSBwYPA7ETfhi4vM0qLZ7n0DnYI
 PjZkhdxnSTWktH2inHEnQDQFwPEf6fpeddT/xiLhIKXINf9h29tJ4v+RXivOap+2YIDe
 mUiH3mUC05GxRa5RE7TyEbu4Lc4/sIqHRGFMR574eejkBJTmhxJlNaUm89bOLkuUm9rg bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedumsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:10:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C96GIi007861;
	Fri, 12 Apr 2024 10:10:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuasft0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:10:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0LkOPkTq1qw/WhpmjRCKOYXVYu9yiXicVa20aQGSddpwzpZ3daE+eULMut9mAy5lOsPw31Ym/RUx5Q0M/jDho+M1UFqm9DIUuvezMogw1eBMEnaowIKKUROLgeIDY4EaVfUlFpSA1r59gEB365ovqVkV9dI51BziUCFZuqLS+uYEPCEiM2gJDjI8MBdj6/DHlh7sDxhV32pXcql1cG9ulhJsV7+SIZOCLYr1BeEv6kTaueZLa20R88wtDHumgXeIvREJDKJFfoA1fgm54hBpiXWFht3XnOLFAJLhiDWseb3qW3hV/K9CSWTI+MGbKbirx4/JD3pmPZZy+cme9HqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx/LcmHUQjKpjyhgNouGWOzotuHZItlpdKR3cm+0opI=;
 b=Yc/S7fq2zJCuvc+0P3pxi1xExWxJx5zXWNIVM0VzlSUi+xfL3wA7J6X24WUINdYjPudIiJJj5xc2oxBKoQAJ4amkr2xXMwfU4Q75ZuSc7Q0topbeFUksT2zPrwv92tYb8DaaYV9iWyqTnHgCDZU+eGFLBUBK3RwwAxR+wvgD2NQjBXSWt1C+bHD8GgKe6f2sB2b4R3igX3xRrd8YDkYWnqJhqddGpET36APCny++BcxHmrO2qiRXu8RjJ2aiE1bprYci+moHZ7M9fSHaRa3s9Wlh52YrJTE7Oabb9cszrxOfw47dHK/TkkOrLa66XLg466aLd1Zq2P2flkmBNx1/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx/LcmHUQjKpjyhgNouGWOzotuHZItlpdKR3cm+0opI=;
 b=hxyZlG/X9ZQfyyM/hY/QWKkUbewkQP+oM1zWrrubGH//69Anc8EOzsZm5vncb9A89CqRdfgCVdAxuwzE+ZXujYhg7agknIMqB9sT1Cr6L/qcfkgCNWXLXbJ5KFruVX4SjuCg8lzDjTEdFKerfxSErvaTiFWtYI90Nx4MYCmIyQA=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:10:25 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:10:25 +0000
Message-ID: <9e397d26-4ade-4416-8b8e-dbfa99368241@oracle.com>
Date: Fri, 12 Apr 2024 15:40:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240411095424.875421572@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0174.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 2535998d-460d-45f9-2a92-08dc5ad8c560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lhYerhY4xN8Qik7qW9Lsd0NOkphSi5Bguawrj7VK1KDr3GvOMHeUxvbeKJ6/rb2eZL3lb7dgowkPyWII53tfQaeJmOdykVOmk4u05zDk4xkMip13tfQ0CDtlQE9cVIO+1L/IG/4Bcf984Ru0A9r1+SC0UtVi56M1er41lI9FLPuCka58kEqbhY1gh35Cyrf8AnHCCgJCmXmT32VkxtQE0guwYFciNQAiY1CLprzs5gHGceu3Aqbz780SpReu2Og9dbdRiUG1ZljGsDnoXJfoJqMq4A/V4xuGKBAlywcXXOA18eqDingErJs/wdKDELSDiJCCKfM8mES0SSa2c7fibuFUeef3sg9c51qEoGqTkOcxor/5TZ0eHgO7S1TsYu0yebs7qsbQHjQsrC4ZizmYbK5IFiUCKoWqs9Nn4UljvWYklGm5GufdDuLElrEyoUl4ibZcMZ2iLW9J2/bgvsEak5zc1dU5vjkZaZWM7XoDawFW7p/IJRQtT2HeS7dQnKPxj17xCAxlPBZJtw08LgZW+talpT5uS3VoPELuCqcIGaP91GfAVky7/dRGfMzVCyD3/TY7OjYmfeiQvobtDq6Vnu57VWe0MhJywM4I4lDGKE1ADB8huPSYhBmRvWD1VOM1a819DscL3/53rE+2tV7uw888h7AK+0VWP/dSYnv2cjE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2pESUZud2ZhRTBvb2lsOVAreTZOMUQzQjNqNmF3K2hXdlphc3FJRFEwcS9t?=
 =?utf-8?B?L05JcE0wcGN1ZWtTcnM0NW45VmRpOGQ2cDMxTDlWbFFPRExIM2hiZU8yOEpm?=
 =?utf-8?B?Z3ZKbjlWVy8zUEFWYnRRdTZvY2JNSTQwVWRyMjhjSmJYaGV3U0xMVXhyMDlN?=
 =?utf-8?B?UDV1Tno4SStHWWNpczQzUmJnUm5iSHltcTVyS3pGVmZpM3hJbzBXTFNCR0ow?=
 =?utf-8?B?VlA2NmswWm9URWVwWDAxODgvSTZkQWtneEt3aGwxSGI5NmdOMVRUZXkzdE5O?=
 =?utf-8?B?YzEzZHJucjBPUDB3UjJKNlkvSy9ZRURCQUNiV1RDVFgzUW9DaHVlUzFWTmhw?=
 =?utf-8?B?Y1RlNFpWMW1hODNvNEdWMStOdmVuNmF1Rkw2aWtsemNqOS9pb08rM3RJMWRZ?=
 =?utf-8?B?eGpMWG5NSjhRSU5pMlUvd2RHVHlnL0QzSWRnOWN1MVFvb0RsaEp5RFJTMGR5?=
 =?utf-8?B?czRHODdSOGJBcGFIa3NIWS9hTTUwVFFFVFd5RjBDcXNEY3R5STlMcndxM0lC?=
 =?utf-8?B?RkJUdkpPS3p3VyszR0F0TEF2TkRPcFNmaHlJYWc5MnNLRFY0RVk0SjR5TkNJ?=
 =?utf-8?B?RVJIVnozMmVRSDVzb0Z4bUVsMG9WeWxSUjBpR2hReWlVOWVGeUpzVzlDQis2?=
 =?utf-8?B?T09vQ0xVVmNPbExUdDRVbkpmU1JUSkY4ZjgrNVF4UUZwYmtSWFF5WnNCeFNC?=
 =?utf-8?B?a2dPM3k2N1NHL1UwV1RRcUExMzIxT3MrN0c0aVVycEJiUjlOMDlEczlHV0dy?=
 =?utf-8?B?dllFKysyTnRkV0tLQmQzREVsYnY0bWZ4TGJIcXcwb1dkU1FySG9heDQyeERw?=
 =?utf-8?B?NU5OZzI2bDJRZmR3UVhKWVlQZm5WTExBRGk4bmZqRlBHOHVISkRzejNWa2Ju?=
 =?utf-8?B?MEtRdElRai9JWVM0K0xRNlk4RkQ1YWpOTzBwU0ptZkhQUmZLUmpRNWlWcy8w?=
 =?utf-8?B?YVRXMDE0RG9lZXhwdzhIYWtqQ0g3Q2ZLelpDNlkyV3VrN2paR3ljcHRxWHR6?=
 =?utf-8?B?WTE5cTdoWVN5S0JNOUF1aUhpN2gvZitwcWJtenYxTS9LTE5QTlhZME9ldExp?=
 =?utf-8?B?TjNsUHR5cWNwUVhobFlqUXNvVmRSaysvZjR6VFVralREOHd4aEFic0Rlbkty?=
 =?utf-8?B?b3I3bzRGTlo3dlZDTm5OZXptOGZyUVZPaHd3ODB6eWdETGdndDk2dmkxZHhY?=
 =?utf-8?B?SWRoODFTRXFpVDZPL0RzbjJZeEJiOHh4TG9kTjZlNWxmMy8wZkdHSElaV29i?=
 =?utf-8?B?YW1KYW1XZ1F4THZ3WldrVWFXNGJnbG5EdDQvQnRtZldzVHlrbTRYd0lvYk1o?=
 =?utf-8?B?NVlTRDNVVkp5VEhtSk9oTU1IN2t1TFZxNHlzbUxPWXZhU0k5dFFLajNMQjZo?=
 =?utf-8?B?akVKbHIxb0JIMURtRHZWUFZYbTZZOXJzNmpUUjIzZGhONjlMRmFFbTRBVWxm?=
 =?utf-8?B?bVQ5Z3NsRDNRNGRkeHQ2eGNQZGoreTlPQ3FuTFdNWkIyYUtmemtpZDJyakpv?=
 =?utf-8?B?T29aVDJiVkFmRFBsR2VGdjZiaDErdWpkejBweGNGamJqUVlEYkF1SHZ2WG04?=
 =?utf-8?B?NFUzRlR3dVY1NkFpVFh2bk5GVFFHTWxHVC8vMEgwREhYUGZaZUhEemhYc3hB?=
 =?utf-8?B?QjRXNVl3YjFoZ2lVMXdsZkVJTW80OFVBT0F0UHUzemdnWWFDaXg2OHNnT0Ry?=
 =?utf-8?B?clhhRHBYSnJ6b0RIR0pURG9vMFlOeUdTaXNPazE2VkFlZGdrMm9rWWRYUk1R?=
 =?utf-8?B?WmQ0WWUrbEE1UzNGTE5UVEZDaTNzcmswYkt6cHUrRmlPeGZia0N4TGhMTVpl?=
 =?utf-8?B?cTUxUlFKLzhWUlNZamlVRmM3UVBRQTkyUkJQbzVkdlN4ME1tQ3FQOU9IS0s4?=
 =?utf-8?B?N2x0Q2FqRnpDVmcxdkJqaEV0b1Z1TWxJRUs1VklaRkhJSUJHcEg4WU9uMHRH?=
 =?utf-8?B?ZGJ4ZUZhZndXSFpSaGthSmFGVmtuMFlUYVVKUDVMNXdEaWZNMEx1d09tZERv?=
 =?utf-8?B?OHM5Ym53UW54QWttaW12aXBiT2RMZUE1OHl3ZDAxTGg3TlNxYS9nZ1o3cmYy?=
 =?utf-8?B?VE1vTmxFVUYzR2ZlSEE2a3AvQW5qSXNES1ZUS3ZmMGNtWGlXSG1RRk5naGda?=
 =?utf-8?B?Rm0vT1gySk1NUVJHbSsxajBUUzRjS2J6bzNnVm56RE1XS01FdnAyYzIwcnJI?=
 =?utf-8?Q?mYB7TSTPxzy6vwwBvLTl4Cc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WpTREH/rHGwU6d6fBON6co9PlMhlLG1AxAm8fuvamM06lT83OTGda9iHQJRySDMpCZjjAtcl0txBc+2spZViTmlWFXqLQ4KJI1GUaEXC4y8M1wBU4etRoXKUP7SQ1RmWJvD1xNxzPUEt9bnEZZD01biHy27POBmhiEJ6gyGADJ3YdEO6yEh6KQdIU9drLkstNyAUWLMsQNhlp4rJyaqO927JCC3ObKKJd2MoYZ8BiQoDlycJEs6+ehU15aVSDBRqrpTpE+yXpMBJvYP2N87ydUjuIVzsYHlicGjxk8gcRW+0DfHvdITykFWiSi3NdZjTDxbLKBvn29H0PU3AZNB57Q6EsurZGvOwLzdrQTQW2Wc6uEggpnko8gVHf4W483xGzIrXpRWj8dR6jKWQ7Yr3a8IrjNjsdXUP/CBaHxEnEeYzd5/0PJ0Y8r42MGkgYhgqV685kqcJ9tJN+O9FMxDD7ZyIbPgN1U2HnXT4A6UNgAKgH9Pg939bU1GrZa2U3jS1Ke/1aQJetQHd6QUsmIWmbKHIsnSXv0MfEiisMrkBtZv6iG7tfvyEQE3a1zttae4Mn68MusbUxg839lKGj+7FVYc48MMrP6Q16sAv4KnrdZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2535998d-460d-45f9-2a92-08dc5ad8c560
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:10:25.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfJEAMRDT94J4mLnVLvtVbW68F+zb+x8tkVg1P3Xl504tsFeh8n6uvs1UWbeR+IhbbmjffDxPzvcvArlTLgzqmLZtpCUP3/cCaIW7NJ9n2x/26vXxHHtpbhTNK1LJJN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120073
X-Proofpoint-GUID: a0drlmpCStHVKU4JvKuTS7qstmpdKGoE
X-Proofpoint-ORIG-GUID: a0drlmpCStHVKU4JvKuTS7qstmpdKGoE

Hi Greg,

On 11/04/24 15:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.274 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.274-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

