Return-Path: <linux-kernel+bounces-120587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1547488D9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D981C25CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF3836AFC;
	Wed, 27 Mar 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VlS8gMuw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mg9bIThO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42A1C11;
	Wed, 27 Mar 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530224; cv=fail; b=LPd/I0Wvayr+d0a65eD6XDYGgJPVbSv+OJ7woIY6InSFHltV5aNi8iFp7DMTbjIa2zycjmQMB2rcbXhoeEgpl+WvzBzq7ndi2pdlEcr0JpKUFlAWC/W/DR0kUQaUJFvoTpHU9TfjzScd+fXSN1HBNGLQ33kgj7DB0VdAHXolWRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530224; c=relaxed/simple;
	bh=IaY6RzhJXy64qME5J3SCf2wa9O3RWkqLr2z6Jl/Kk28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evqpETcTlu2ouSycuZivXvgXNe3uWwHnxqFVCy4gkPVFzNl/9p3MlAxei336VVQuZY/v7oruZ0zeAzlbnqvAEcut/PUADWaqzKi6LScguFHJjLMDg2Un1ZVWIJSFoErsmbad917Id0Df1dHXR+Yyba5MjWB/0Q4zY0Ls5CJyAlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VlS8gMuw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mg9bIThO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R87KF4004512;
	Wed, 27 Mar 2024 09:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=MltTStEYbGsigRhCBY0TFzVaVTwRz7XkDahyrS+kTmI=;
 b=VlS8gMuwK1NgK4b54nkgkuoLHcH6IIbhMNAG4RAfgBpZmoTw6aDGPcl9Vaau2w9i2YM5
 96KoQrnKQu5Qc/ri4LuQ5aYmuCBU9CESBTgSwE6hE1sei94mFzNsO+pZMgip038mQTb2
 o0Iih+lvWvEIcHhmZyLbDQd6z6LaToWvvh1Tj/LcxEtHVq/tDIOPWFATIOguKPxrFtYm
 7tdcNsjpVcCt2M3HRmvEEsx+gVjk94tqoGfMC5MtePW8HfPJPnEnFN/mk9aiwgk7neaV
 r0OY4dXFVLCqcXd0awMTPLHDUc4+l0xNbcyU++2cb53ajEdNsdXWbV752tuFsWe/aXP1 KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1nv46wnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:03:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42R7mcME020706;
	Wed, 27 Mar 2024 09:03:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhefx0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIj0Xw7i8jQseYGlLWwk/KpSuaofbUnUSV1KxGsmG4CCMK+NTL5qcIOK+jmeBxNc891HU494pFkSWNyLOnWhRH/L6MP02RGGRYRomhwUR5Kkx6zQLJcz2K4QVKCTSTBR6eJvcyLRvKg3mIFxX5KttlF6puFMUpsjl0XKTeBGBnKfZwcG4k9Ish62cite5B2RoRuiryy6UUYe5hAbEFQCdSuH/a0qlthqDUM+/sremxH4s/LtUEoJXMk//rqnFGo7ZNnLWVeqrVMy/ap/51pBdV/oF9CdWFJCLOmhemdCVOHxsuEvdPy5Y2+BN7saLlM7t7UIv7dXGw/RoRP59T57jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MltTStEYbGsigRhCBY0TFzVaVTwRz7XkDahyrS+kTmI=;
 b=KXSW7A68Wrp2w4PD4pmtcaTQjZRPUK/4Ms3zhkRNcFLVGklVSIGUwIQGaySyaKmF9m2ZN+ZA0u9Qgs8v/Mrzfsf7GlrYTOJb5t3QHKy3j57T4vfSpRem1kXUqRXUqR9ipCBeFd11XB0JO8+Q3rEfP1mENvtr9rhIDY/cu4WbNHX6K0JVuvmj6llzKcfwdxp4nT0FYQ7RQ22yKXF+IjXt/JFHcBf7q0DSx4WSS3YMfvPk4GOdXAPFjKm4vF3acIX+mO8yklkxO+O+OjsVW3Fl8pItf6adgTboeWc3mT3OaHGMQ9ZHE+/1U3WxTddIY4SCZBpkJZoDmhO9OmK0fPcY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MltTStEYbGsigRhCBY0TFzVaVTwRz7XkDahyrS+kTmI=;
 b=mg9bIThOvp1+AJSGba0c7tE0Mw/XdrVb1wjF8WS1iqSlYH6z27I83eXjFo6QFjnTiAInzkYTh9k3fKR7kGN7M4ZG0pDNVw+6kSYHr6H2M7iMK8/8AvpMATetXJvQuoyHPc0e9ixlItHdLE0cf9df+Yjq0bUkMFOACrhDtUfQZ9U=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB7556.namprd10.prod.outlook.com (2603:10b6:806:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 09:03:18 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 09:03:18 +0000
Message-ID: <e6e6e26e-53cd-449b-9e12-5a13b077a275@oracle.com>
Date: Wed, 27 Mar 2024 14:33:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
        pavel@denx.de, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240325115951.1766937-1-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ac6cdf-0f08-4c6c-d1b2-08dc4e3cbe79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/ygNCF9LFlMV182GGd6LxYQmqGw1rQ472dwZ0RPEdeDxrurSAWXgm+6QDS5rFnfycTMiMYBZ7837pRi2nXBbGu/mExovY5TXodSOTFpJc7BMKxhBeDEFaTHw7r9Ik0tvMquO6/IH9+h0RIF0DbVPaMzeJgiu4Jc+SQSKTveSUPZk0kiNELKY1KoOlyRMHy2BDdV+aBBon3Cd420ninhJuStNQWP6Tyj0fqI7fqD2+KiSU6fEYuI2Z/SYL+fSj4gB0ed1TDHAOXUgixUE4vIb58uqNeRLgYhMhSHaI0UmooKvxYzNjrAwg3RNL9/ZTaUykMGz0zzNo9UDUNydQoLIjD7z2XYSAV7j/b/oiZtEX/AyF8JYOJ51xUed3yq/8deuKw/STDQH0tqloxYWEIPhGj1hCX00zhp9gPwXacQnpxZwHeiw5QzQUtk0umdJO4Ecm37f64Tuo8IiXufkMzLX2B/UbIzQ8rTNjuf6gDDL1vNE0I8SvBJjxblacPJiAURCeeJQGV3sLO665KvcbJbIq0TjfRQk22Hjlonml4wo9wniJyBbngdABeORM5Q0y8Tnb+Pwt1AaP48NVtPZszJYZxT5wgmzmA72WfA3E1hB3l4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEFadzdyYm94RW9FVnFqN213QlVTK2MzVE5Mc2k2Ky9xU1d0cDlDZzhlM2hp?=
 =?utf-8?B?ZDhHczAyYll4b3VDWmV4aFcya2VYUFFLZ05LRFU5TWVXU1RyT0dZUExLeGsv?=
 =?utf-8?B?ekJEb2lON3ZuR2NySVM3N3NSMGFXSngvd29BK3VEUC8wZmMxTzdWMUhBMjZ0?=
 =?utf-8?B?SHpycmMxUENvSTZscmJ5dFVpLzZtcG5MbHZqUVlZL09vTmtJN0lXMzRYb3Iz?=
 =?utf-8?B?Z0dGUVh3c2ZxUXJUbGhuZW1pQW51V2RLNXc2VFgvekZRTmg1SldCbjRRRUlp?=
 =?utf-8?B?bjFGem9KNXNUY2pjSVdWOGo0bVNENHBKbzlaRElMSDNNdGNLTXVvQ2VRV3pi?=
 =?utf-8?B?ZVFBcU42em82ZGdIZklyOFFGZ1RzTmVpbFQ2NGwzZGo2MHFrN3RnejUrc1d0?=
 =?utf-8?B?SzV0em9QYWlvYVhUa0U5R3NsNGhoZG1icTRObWFwd1QyTmM1bm5OcER4alFM?=
 =?utf-8?B?dEw2RmpzQURiYys5b2ZyM3pnTzA2TW5lZGpZZElWVnUxcTc4dDQ2RzR5QWZY?=
 =?utf-8?B?SE1yK0lVSXVlamFHV2JoNVB3djduNi9FbThQQ21NRVh2dGxlb1dkSzRQaUVX?=
 =?utf-8?B?Uys4aU5COWZ1WjFGRm9pY1BoYmVrc3FJUFp4UlQzYTZjLzRBeURUb20yN1NF?=
 =?utf-8?B?RU5vMDk0UitiZCtYdGlvaFFadlZPVG1PR09QM0IxcUxMRFBjTWxySTN3cFN4?=
 =?utf-8?B?NVhOOXo3YUJFb01vUHpzQVV3YWFvQXR5SXFydHp5UmdjUXFXNWc5MjdNSVlI?=
 =?utf-8?B?dFhTWVRXbDBDVWFab1Z0enpGTnJpU29HRXRDZFVsa09UMWp3YkFOTEFzTzR5?=
 =?utf-8?B?UEhzdXN6d25GdUNwREp5OHRUK1dQeVpNOHUxWW5JMnB0L0F1c0FsTDByZW9J?=
 =?utf-8?B?VFdDd2RwWEZkOTJSVWNYeUNFVFpzUEhWV2NFZmsxcUlHS3REam5YN1dvREk3?=
 =?utf-8?B?OWllWVhQTC9Jb2dzcTIrK3grUWxha3N0d2ZjRm1JcTJnbVFzMklSNThyMys1?=
 =?utf-8?B?TG9WZFZVOVIxaW1pVytjczlqUnMxSEZreEV1MTB5SVQ4bExBdzZrUGd3QTlr?=
 =?utf-8?B?QVk1dmhkYnVKbEc1eGtmb2w5UVdISk5yNEw5VG5Zb2VEZVdtMEw5TkpkRjBs?=
 =?utf-8?B?a2tzRXN0dU5sV3MybW95WWxOY3dEYUZUSSsyYzd6ZUlEaDdnRHNJNHBJMGJP?=
 =?utf-8?B?bFQydHBBU0Z4cFgxV2R4NlB4cmx6MG4wejlVMXpMc3R3QXhoNDVqSzJURUhJ?=
 =?utf-8?B?MXZPS0E2MHl1RWtHVURyU3g2U1RYa3A3dllOUU8vd2VKTHhJRmxXNlZLYjlp?=
 =?utf-8?B?bUt1aDRMajhvcmI4YWhtdnUrb1FWWlRLOVlNWHk5cmc1UW41QjYzWnNGU0do?=
 =?utf-8?B?WmZkdDkrSFcrSTRjeWFwVTBHS1V1UWVFQmlCUndjaEZXODNXVnphK3VQeG83?=
 =?utf-8?B?anArc3hDV3hLaFNNM0hFbm9hQktEdGVXcCsvT1BzQ3laNkNhaHZxWjJ3Y1NW?=
 =?utf-8?B?UmhkL080Q0dydlppc0RPbWtxb0pTdW9QNmNkZjNXSzcxQVpQZWg2VW41RVdE?=
 =?utf-8?B?NlBXaDNFY1NEd0w3NkNXL280R2pQNHR1VGJ1dFRhYXFTalBmR1JZaFNoOGYy?=
 =?utf-8?B?djdQU0Y2QmREV3pUZUwvdFdYaUgvZW5XbmV0T2t6YlR4SHg4dlRPWUIxT0xm?=
 =?utf-8?B?U3dYQ0gwbkFoekJRU216UytPai9PZjcxdkM1Y2MwV3RUWXh1RUpDTFBpL2Zp?=
 =?utf-8?B?aXdLdUgwZlFvaG9pK0V4TGhIbU9hbkJFVU5vQ2RkVTM1R0Z1bmhMTkp0NGVM?=
 =?utf-8?B?ZkdITHlCMlRvZDRBUEJqLzBzNkxwcnJXam12K3RCOTlPR3BPRGJzeHc3eGNK?=
 =?utf-8?B?QXpSTGd6dittQmdIaWw4dWRFVVdjZHo2eDcvQUpvdE9vTWxKMzFBdlM1MGdD?=
 =?utf-8?B?WTYrUEpwTXZNMmZXR24xU3ZzRy80WGZzQ1g2ZG5SUUJlN3ZCNndLYi9PVUxa?=
 =?utf-8?B?eCtQU1FjRTZjZVZDcHQ5MnROVlJ1bGIrTDdrakRlN3BTOS9oMURIMk0wbyti?=
 =?utf-8?B?WWJMZEpubHRJcjJBY1I5Ri9oYTluQTdCWVY3TDg3VkliUWtXYWNvYWdhZDBS?=
 =?utf-8?B?L2J4c1pTSzA2N0JwZytmMndEN0JLYlVjVUhZd0xoRHJhQVUrZTFzOG1VL0p1?=
 =?utf-8?Q?nq0v485BiTKVAlkP3HLT0Lc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DPDGu4zRP8/rzSP3PUMNWgu2cuR9pC6M2jSilnvjmOhsMnCgIaYL9VdJJfu5D6XWNWtkU9dOnCvj5DkPoJZSNySsLJk3/JrT2Oe1XlxLDXnTcUUI2IW48gpvD2jh2Leu4mG1yCCtp6keHNkKF7usLfUjABq3Ytj35gLFIjyewPKKwBiUkKctd1yj7qBMlp8pzJkYS25fpokt449mk2Cax74w5DWUSpJbs7yAsLN88ytg2c/Kzz+wnByNz/Y30rzhwQOnAltFk/NRltv7IC/vwx6rK3FISC08IMWW9O8sPQuAtGkSqI0RqIyT+95GJyNSRfnx4VlQHqsUrVBAvq2qNrVC3rmc9c7ABxlKRshb3foxlhgFLc1S5jqu7m+Xr9ih2H9z0JNaeTCWfThsF3ob5vpg8GsQ+vATjPOxlL9JulDsjKyT9u44gbWnq+GsYTllHE7R2GTYBSGT8PW9RgQy206puuVeNxKbqnnJKql8SyuCm50ttGzLTm3daXbDyDNIYMheSlWskZdFVlUS+h/Exsy60euyXPUSsN8xEIuqe1HOmbHiuIhMY+c4HzuN8Ty+wTxyhN7r+G/EaRBzNEZ28Nb4Fbm4M0BqisHwZcA+u0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ac6cdf-0f08-4c6c-d1b2-08dc4e3cbe79
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 09:03:18.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPBM5x573LCElvIPPPNB+CXJ4J1qaONfP/o2tKQbPcuq8a3ky8n7bneanlP+TlBcsH07HR98DS9RROmfVuoud+2S5cpWKBsEBLItFadRnUowSfQookfbr+fRN62ceJAs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403270061
X-Proofpoint-ORIG-GUID: qLNzA7WUL2I7TGia_yYBtfywMnvZQxIg
X-Proofpoint-GUID: qLNzA7WUL2I7TGia_yYBtfywMnvZQxIg

Hi Sasha,

On 25/03/24 17:29, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:50 AM UTC 2024.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.22
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

