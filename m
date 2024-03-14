Return-Path: <linux-kernel+bounces-103451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38187BF81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF831C20FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A271741;
	Thu, 14 Mar 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJSKQCCH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f+alh3c/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347E71739;
	Thu, 14 Mar 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428575; cv=fail; b=sFFwj8DlYydltzo/Gbu0an17bET5J30mugnWsaazUXmDKtvZfKxvbOkaznnDP2oIqTB1arRFDSPAUU12sm4eeGq41t1JhWZLyioC0TZG3/MuaLiyskNSPTUvlVBIU4O8g7ioQPzLQNXv0yj9YaeXmNKajxiFvCFDdR0at/3Hc+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428575; c=relaxed/simple;
	bh=UcXzzwwEJDrFJgA9C3ZOm/LL9YgNxT/exgicTl+uP1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YYMsz2VhVCmx68Rozs8eI83pwVtaZz+O87wn6bgq29ooB75w61+tKLK5SXlinR97jcVzYt0HagRIhl3KQ0kxWNPi06/QYmwL7URz1wjkd6dpNZxzGza7xzsEcG99rG7icTbSRu0bTuumliXee9RV6KIhOrIG7HEJPR4w/AxzJ20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YJSKQCCH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f+alh3c/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECMAQ8028678;
	Thu, 14 Mar 2024 15:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0DuXA7UjQxcIM2hgLpHfFsx4rhBRHZ3AmRICMQnHYQs=;
 b=YJSKQCCHPcdzivXZMxKSGYi3XOdWUJ4lKBbArsKcGUyeECrhX5ZhlHm422mfC5Cnw9aY
 v+O0S/xcwhQD5h+1GX3WPCOF5r32X31KvBte34nO2q1HMgXXNniC83fgUJ+ApM+UCaKs
 TnVYGcSI1dHD2P1XY8gyUvlSCR2umWs//tFczfk7L4mJBF0XDSy2GG3q20w57cNYUqWF
 CRMDSkHk8jv36myBDNyHfgBfztBQIKP8C6AnYBOfIUwWUqDjlVvF5Q/sV6N9P7T98pB0
 IaNPyQ5+eAlDFwh8zKG02v5IulBI2c7ud86nGOoIss7QEQHVhTrO6PnFDQK7HmwPW/aR tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0ad8ffu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 15:02:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EDmpDI019665;
	Thu, 14 Mar 2024 15:02:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7ag6ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 15:02:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+HRmuVub9Lfo2dxvOHvlwbIxXwa1ZAdmit5l69+EHIT2gO0zC6TMWV67Lz+wAH1g1Zk0uJpXBlHK8gKoVysPXb93BgAcbGSRPFPAYqZg7rOCDyvYgzMzo4F09GQNtAhzqwZsAsuk9ID/jsgHAEqiY+4Vg4vz7+ViGKvMJXVBa20YaYNG+q5fk+sqOLDp+WEHl/AfuuiZdr197yvMHWk2E3E+bdV+aTVGeZMWKKujp82OgnnIm/OipzNvCDtXNGkQ2VaOibw6AVv573QcwcbnMRd4L7f4FyOcGf2qqEoShBnipUuTS7toe40atQb5/87FFZLcXJzdcmUb3UcTIniaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DuXA7UjQxcIM2hgLpHfFsx4rhBRHZ3AmRICMQnHYQs=;
 b=nUWnUqHjw0b3p5M4q9Yapq/nzE0U/gfrxVeWVjPqs/ea3ZI9f6WXUBkypjSk9MOmUmoYLIwbrFx0QtGSY72HAHot1eciGEeO1YZ7z4YIiXCMHsZ1MvgY5AHaIfFUh8FgX6bSGu3V1CVsTOjwONp1UeCNsdipVO58n7yWqy6797rSB+UEdVVPBHBiKjh3gmMiTqSl29euyNUZCUpkDVflKDTFjVKqHmMNXA1Btvo0rGnw9QK4ekoXszMvfiuK2nSJmn67QrtZToIPkRgjl4kV3GPF3h92m9zJCTAPAVgs6XMdTpfLNgaSO4BtsBgcnpG57Z4CyfG7oWyWUrc+qB2viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DuXA7UjQxcIM2hgLpHfFsx4rhBRHZ3AmRICMQnHYQs=;
 b=f+alh3c/RG4P//ZXGQebELqnZncvI3/+w3C9P0rjQMTi76nA531Uq7+FLsdoKYxAm65AXYCZNMYkiaB+yucBByWWnkyyaKUjsUg7WBeqLTrlTGYGOfLKqUm+Jx/ltj7CcSaoCIe1qqb0w76vwaPknhlET3gIm6IPF6gPcpqwUfM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 15:02:10 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 15:02:10 +0000
Message-ID: <24d85cc0-2bc1-49ed-a470-a2b51ab1fe8e@oracle.com>
Date: Thu, 14 Mar 2024 20:32:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.152-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240313164223.615640-1-sashal@kernel.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cf9d8e-3662-4af6-9ef8-08dc4437b8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SXkLo+blgmJsESG1N6B17qzKVjPKVCxFjKi9UKAwen4sA0wx2pcL+J/dWW0aX6jWTSnnyCGJEoLdDcZgJrbiTn87fRtr8h8ilnBkRr3qKwH5Rv63NYijXr+VV9hL+A5x1as8px3moBDcxllReALdxAQzsq/5PE3YsURiJwiCpyfUp/b5JIHVcgPxl61TkHBJezYcNDk7ssgS7oww3BN4lXRHnnGz2bT6Dg2ogCs7UKZgAZzzbeseYV1ah3hrvO8CTIBcTzsJugGd/DYlkD1FT6dq7M+auRCueNNxtqWNYHp2U1jpz6Nfh0Uhd+Ph4dvc15kiqA7rQuzk+2V9amUAGehhLTcbDinSVb6sF7+/i82KHK6uTVahdFb0C5B4Qia+RtCiWOFcDmvf7Sh7xf4o34MvCUqlI9iBLCCWqtHyrH6SWYIsJfWW7ll7pJhXYUiqA/oahPjDYHCP3E0JtNa1Ffm9hh7Q+pBET7ouJv6328u4FKtcd/w0TYrXfGLkJHkqMVQvVsMaMqusIU6nF7F5P8MQYYmpHsLNbN+ot7QkYcyefKXa6yjziMIfidpezsz9FYgg8srhnY5nmgau2oGzyzkXS/y8FIes+Z3AwakQWis=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEdEMDM1VkxNZjVjZnJjV2h4NDFmSk9BbTNlUk1kUGd6V0JrR3IwOTNON1FW?=
 =?utf-8?B?Q1R2eEw2RS9SZG1JL2lIKysxaW8vVlFBeWhiaTB4SHpGYUEweXc5ZnpHbFlH?=
 =?utf-8?B?RDJxaDZkTm9QUWozcW9DSmQ4OG5MSEpyK2hGMG9wUk43MkJjeTljQTNHVFlE?=
 =?utf-8?B?K2VZUHZzQnVXa0tGQzN2L1JIeEs4ZDM5M0JkZThxOG5KdlR1QnF3ZDNjZmNW?=
 =?utf-8?B?UHlyRUFPaERWQ3VmZURScjU0aTlwZlNZNnI3SjU4ejNXWlA5eDJHcVE3aytT?=
 =?utf-8?B?a0QzZmQ1cnF2UzQ5WGhhWUF2blZ6MVlkVVVPQTVpZ3pyRXJZdHJ1TCtHVnBS?=
 =?utf-8?B?bHhhejVzZG10RnZyUk1jcFNhNE05YzhBVTRaeGRTbkpDTmI0UjcyVmppa0ox?=
 =?utf-8?B?R1VkUTJlam9MN1poUjhmOHVGN2d4YTQvS1Y5UldyS1MvYzZsWUpDQ2JWWnU0?=
 =?utf-8?B?SXY5R1A3NWh0MlI3Q2duMEYvelN1NWk0c0pLajZ2TG1EWExqRFFJNm1TM3FU?=
 =?utf-8?B?K1BwZmcyRXAwbGJjYXV4QkpDT3prUmEyZFZmNjU1WjZ2Y2t3RW5Kb0tNTllV?=
 =?utf-8?B?ejlNSmFsSUZKYzh1SUJ4VGdyMTJGcjlaK2Q4T1hYcmx6SzhwN3YwcC80aE16?=
 =?utf-8?B?VVVPSkh4UklIbzFnNFJ3R1BCZWhmSjVzN1c1NC83WWRkeUFoUy9nYUFiUnkr?=
 =?utf-8?B?OUJRR2FCOHM3WFJSSmFMck1BOXhPbWFCMm84Q0hPUHhnZFU3TklLZXR5WFhH?=
 =?utf-8?B?YVBhT2M5dkVvMzF2dis0bVduYURpYUxJK0h3WFIrRms5UytlaUlwZW5UZDAv?=
 =?utf-8?B?b3BuRmNQSEZ2S3llckdIeFNoMnVZK01Pd1UxZmVKL3hadTNLZUxrbEtETG1C?=
 =?utf-8?B?YzZFY0M5YjhheEdvVlVlUEhqRjhvR1NHWTRPemsrU2FUUWZXYTMwNkw5LytH?=
 =?utf-8?B?alpCTU5OZGdCTGNOUm1mNTNTVEpnZGlsNGM3T0RsTzQyZWxKMlF6azVmUDJk?=
 =?utf-8?B?eEZ0T0xrVkpLdDlTMDFYeTV1Ny8wdWwvUHFCK3YwZVZRNnN2MmRNcERTL3Va?=
 =?utf-8?B?RmNCWDNEZUVQeWl2Z2NpMnlZWHZoNjFQUjZtZkhSVndsZk15K0NScitKNk9r?=
 =?utf-8?B?a3lxR0l6K3Ric0I0LzBTOURHV2lPV1dUNWZ0RDRoQXVhZ2VuK2YvdU0rMmwz?=
 =?utf-8?B?TDQ2aDBWSWlGdkpXaXg5bWJ3cFEwdld2Mk0wVXhvaXgralVWRERlTzFPRHhs?=
 =?utf-8?B?K0xjZnYxWVVKbFh0eGdtUm0vNkhNZlJLZSt4NmM1V3JyY2cwczhPcFVTQjZB?=
 =?utf-8?B?VSsybEtVTG5qTXk4MGpHeXZJbUd3UmEwYU9veFZ2UE41S3BjV2ZXWitsMTNZ?=
 =?utf-8?B?VFk0VCtsWklob0g0RFRYa2NLMjBVd2dJZk81YysxWnRNcnlLWDlLdlFtd0JW?=
 =?utf-8?B?SjNNOFI3bUdvb3VwaWtKWXZQVnVxWDhVVFVGa29tOTV5MklSY2JyZ1oycTkv?=
 =?utf-8?B?WWsvU242c2J2NVB3LzFrNFQ3SERRQ3FNUTRlUlhpQm91UjFraVk2NzBkdnht?=
 =?utf-8?B?MUlrUWpGVldRc0p0UWdxSFBZUGllbi9seHBmMnhWZVFiMGNvdkRtdWJ4WW5p?=
 =?utf-8?B?WXpiaEswNSttWXgzRmlkcDM0bzJDWkxyNTZLM2xJOEJ3eEszVjNCYUMzcVk5?=
 =?utf-8?B?S0h2cjFPUTNHa2pVQXg4bzRwcEJzL3lrSXE0NWIydmJjMUR4OU9oaWZWd1Vo?=
 =?utf-8?B?dVZuUHA3cFl6aUhTTExLNXM5RXphamxMdGE1OGM3a0NlYWJBaVFLeWVLa1l1?=
 =?utf-8?B?RDBmTFpvRmtVQUtWVEZwT3BUUDFuWW1kZVlleFRsUW8vaWwzNk05bEV3b3J6?=
 =?utf-8?B?d0lNUEtjQjVjbmpzQmtCSWhtUmxUR0tEOVoyQVoxTm5NczhZUWVmSFdkUWxH?=
 =?utf-8?B?THc3bTB6cDlQZzh5bS84WXlsQWlxZndLdkswNkk0Z0V1SjNkMC9mMi9JRHIw?=
 =?utf-8?B?YzgrT2pPVmlLeDlVazA2R3pFQXVmNEVDQ3lNWDk3N1BkOW1tYnRtUE00QzNG?=
 =?utf-8?B?QTdBdVgxSjMvWG1RNDZ0cTBHSmJVdlpEUnRxZU9oVzVhelRuUmt1NDU0ekRC?=
 =?utf-8?B?V2RYM09UZnVFeEx0V0JRalIvMTQrQXdPU3V4NU9lMVBRUGhJaUptM1FqN2E0?=
 =?utf-8?Q?nwJMEs3LnRCc1hApFCocNIA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Gi744fjdesvaWGa9uNYquNoS3Y6cVwmL3N/zZIqCoHSRLgnzuehjEg/u8w5ZwDXQoGt45x+xixEe64YL+0T4XEmujEYJtjlv+sIGWVF8k4xavH4+k4V/w35NESwpxrpmpM0D2pLka8ihAurE67aLjqJrS/O9xQH1OzZIlnaDkZB5MOMJszGd4f5UKTCkkuhFvUKrHtbnjrWo36n1wjO70aQKq0ENtWvBRkmlvF5o8bY8Tuks4TzC5Bz21O+OAXPP/+5UlWnRD1j86WKA4HSmDvg/8v90YKfeAI/OgUmSCfHaHqNjkEVdTAM3x3Tz3+QZJ4owFbfz1uxf59Gxxl98l0ULGf6XcmxUrq0IWQDYXiO5l8L34/gWosdUN6U9K+MOOorBZpJTvAVKXolsjuNsH45abU0uFtgc0Jfu/udePuDldT/wQpMGvigIGWr8bfjyhT8twW0A+E0IZGEZZaPXPd0XeWpJ5vo/ohfMoGELhlyMifIwVzOeE+gJneSs0zRQCJIRJc6qOJmpeAuLQvhvaQkAJK8TugJGHjoRGlzprHWXMHQAovYRlOXaxu2YWkTBDPQ3iqmJSmBV/MUrRwnKIx3j/zUwdHJ8FBv5o9vEw94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cf9d8e-3662-4af6-9ef8-08dc4437b8ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 15:02:09.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yONrWbjXa6iXP/2y8xwpgBI5OsFocdZSJ+lQffDFg70qPUs3A5UAdnqPn6rofj4wrCAY/LsNCNUCyPZEGwo4ZicMxJqOwXI/tWXOTJlW7PvixKrHs3VaCBemGpsv1UW1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_12,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403140111
X-Proofpoint-ORIG-GUID: _RjR2lZ1k4PxadUlbwD72zAzq1byI6Rt
X-Proofpoint-GUID: _RjR2lZ1k4PxadUlbwD72zAzq1byI6Rt

Hi Sasha,

On 13/03/24 22:11, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.152 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:42:22 PM UTC 2024.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.151
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

