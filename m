Return-Path: <linux-kernel+bounces-92308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3801C871E32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B979E1F22D56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C075917F;
	Tue,  5 Mar 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UAFpZ4wK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LNWXZnpS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE25822E;
	Tue,  5 Mar 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639148; cv=fail; b=MZHCyQbDkgcZkNVFRBXpllHxh5bPq0Kra9O4/YX18MwsCXvDjAY9hjdcNMd4zOGJw4//x45j6b+kHbPGOxWF4tSPb5jw2zkS2EyoAYZGIgEomaDI9tTsCTzPO2c8AtcTAJ3gD342IftXwyHPgEJYybylqdup+ZOCAw8s8CMKGnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639148; c=relaxed/simple;
	bh=cWC/PE2apHOPNfurkY50x5ItKKnxAXXF+7fp2F/wbiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OcQNj4/Bx7oco6IP26ML8S8+Q7lPKPxAQrsye0pdi1Mn9N0UzpQ3XeS26i8HnsdUPVTU7z7wPv3bb/v+G+64BRnfCVVD82SJy+hJ1psoqeogSFDkLkt1vvNT0Y2NXZzHA7XNKVPwDo5D/s2kjQ62zCI2c+mKLPiZhCLKjTIdzmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UAFpZ4wK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LNWXZnpS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259jYxv019744;
	Tue, 5 Mar 2024 11:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4kk5qrhlenSAer7ATwUU6HvFf8myz1jzZZz/sOYArXg=;
 b=UAFpZ4wKM1tTkAGRuwRbrNcb1JsO/Y+9l8j+tB13YmUi6qlQFZgfeUj2r3emW19yss8l
 6nLYfI1Qtv766gwgdTo80zat0uQrJY25WLA5zmXx7KKZBvKdZMX89+SF3vWzO9NvdeAq
 zK2lb/hbNvhGYNV4RbVpYQi6yuAkxpeSUby5hC7URNkgdE8XLI+8k2CkNjXB+V3fhbtF
 2O8J1pdb1fjtdmjpa0/Hbh0aqaW3OzLUy0XChqNuW9keSfCDXFv06BwENvcMQnCypf2c
 VDDv8/iIS3hS+qZYspADHwQDacZnw/s1fxclaLSnQaHpyFl/Zz/YUwzRuQ3qxkSqiYcJ OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq260fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 11:45:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BWTxA031964;
	Tue, 5 Mar 2024 11:45:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7pfns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 11:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2tsKV0/A1OXK4M40YDOD3EodzapiJZ/PKbgUCYuKVwpvhE1AKxNrrmJR+SSICWd94nHxoONfdyM0DvhhH/GPJ2IrNaWGxE310gn7Ka/4y5Z1NHVU1fdtXtJn67U/6C/UH7RLVwDIpnzMgNi4Z79S169l2ohss+xgYUy3z6yg/tkCvDDD4fEDcun3F8xwF8DAIHdensRE+MQOxN8BdABhm9PLOdKj0YEySyZiC/MRVnq5GJxxlo+zRAAZdk3meczWTthsuxnAlGdrzCfNXcPsHAG89H2Dz6gkTONSM2Bmf/KfgJ+DZH75rwRK9tg4fR+Q8+LttPuYHReo+iXw1IX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kk5qrhlenSAer7ATwUU6HvFf8myz1jzZZz/sOYArXg=;
 b=E9kFvyV+wP1FmrI/5fXoahvXZXTdl3S3tN29YkeRB5nEAsv9cprp989mtGTr6EmErxU6X1rOpZ0f3C/q2gIhDUyYUPMdyfmvyt/4d9Iu3aJBUUnP2Zux3016rMchEgWWqZjYxgrIijPR110ky7aB65DhUa1VKRcf5suP4iNGLFAegqgIcKbF8wnPonlmbKJYVV2OLjxhM8F71mW7ntmreXRzlFXluAzX4f/EmRv1++WNtyM2Mn03XQW1Gqmg4O5b/Z8DkPcLwEB4XhfYyemdHQDAXdMToHgfXjH1+tx/u+O7/396pd2IROCbD61G+WMVXDd9jHCwaVKgZDKMlI1p1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kk5qrhlenSAer7ATwUU6HvFf8myz1jzZZz/sOYArXg=;
 b=LNWXZnpSGQBbeWRueN+cjZBgzZONyEwDzMRIX7naSLQzgqXRRSHZNJwsZqpYNg+cSI5bLkFCsFtwOe7gqXVAy5Rsa4IVltiIuEnwbH0lFMIvLu4dQGCAcUkG208ZM+WOvHP6xyShJ5kQBpZC6kDt3rj9+buj51dhXE3Oa8wEzHk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM3PR10MB7926.namprd10.prod.outlook.com (2603:10b6:0:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 11:45:11 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 11:45:11 +0000
Message-ID: <3558364c-fc4d-4fc0-aa47-6eaedb90e653@oracle.com>
Date: Tue, 5 Mar 2024 17:14:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240304211549.876981797@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM3PR10MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: ace2a72f-d8be-4017-3092-08dc3d09b6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Mr0ApfcTn3WvmJX2+FXHlnsO95XrIeaYkr82V3UjRJ8ZZGcNwCxiIJKjDKf3N3FFVfkteim33Q7UVh1aeR7lRJHXlRhq53ni4fvY/rKpoymWpSu3pwxu/DANJJGQvJc8jL/WOd660oCLfKAMKb9ZA+XuyET3Kh0GVntSSD5oLzJtZsXInPf33MNFEUtzL5yHwtj95Len4zM9PytPWqqYvbO4d6KwCfEx0AVJTvP6cQKidIxWKs+LgXBeucylauSi4wuDqgTHsfYAaUOYUxoj5tZTlKOna+HvAisGGhj4z4nLX2YpXGHMsn/u9M4HlMP9QQaprg9dYUuspeo5L1gbeuZObbfLgsdK+dfHO38MAQYFiRhECspmhaAUd5f1rsPTTgmbF3GHHUguJeu2SgcY58WbMZ5m47kGBRgMkwpEwgo4cM6T6dR8kBZnQHZG8L8plZlkSVRa1Q8osBjDOyDW2vWmRDni9/TDu2K9h0DIhANWfoPSOYjqf9MXSIvCfz1sa8D9d3YJADbVWzLEAD5sFqRi6bTqEcoRtYLYoYxi9Ra3zD3FAJzGfi8Li8oEoEzOnUS14AcG7Twtn6zG0AeKkjstjQVAe9njKX+hdm+5u4Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1pZWmtwSzc4SEFWQmI5d0JYZHNiN3dPcFppWU93NXc1YVM1QjdYcTdNckJX?=
 =?utf-8?B?TU5GQldFRnEwK0dNZ2dxZS9hbGcreVd2OTUrWHR4SkYvb3hjaVFLYmFORnBj?=
 =?utf-8?B?VkFTVnB2elRIVERyb0ZFYjFiakRaU3NabEdsdndKYUF2cUZLQ1loREhBVDFp?=
 =?utf-8?B?UE4reCtLZHdiNm1CekhPTzlSWFhaTnp5ZHZTSnhuczhZVmVGODQzbG82Mmhk?=
 =?utf-8?B?WVZ6VHpOeHd6RkxFRFE3VktSWWxoVnVpdXVYWmxUVnBFcE1lSjlWeHd2QnJY?=
 =?utf-8?B?ODhtTFhqSjMyR0JaY2hPc1pNUWI1N3FQSnRQUmxIbFM2c2cvRXNnOGhmZVIw?=
 =?utf-8?B?aSswckduTmhiRXRQOUZaa3VVb05KbVNoUTlJYTAwMkExR3hvWktINjBOSCtL?=
 =?utf-8?B?S1JpQ3pvZTBQK01qVXY2TFRtWkU0M3E1cUE0aUc0dExSTHpQM29TbWEzT290?=
 =?utf-8?B?bUl2NkhqL2lEdktLRkxIdWpFdDlscTdwRzRpSm1KUTUrN01zWGNVcmQ3TUU5?=
 =?utf-8?B?Wndvemtya2toTTgrMGQyMzU2WUxFbHRMVHVURWJ3K0pYTFRGZVpHWmxxWmo1?=
 =?utf-8?B?V0JhM1plTC9yMXhRbnB4MURGOXhodkZIdGhOTW9aZ2ZnMmZHaGN5SWtPdWdW?=
 =?utf-8?B?NERqN0l5d1UxQ3ozcWxuTm9tVmlUL0ZMQ1lKb21ncncwSWhUQ3FpL0l4V0FV?=
 =?utf-8?B?UFJLOXFjZzZteHlTYzNoZlVlbW51dTUrK3lIUzBrdjdrYXpCVmJDS1Zvc1d5?=
 =?utf-8?B?Zy9nMHp2K1V1T2tjT3hzNFdmL014QVpLNXFTSmlEUWRHYzFBaTlSM1l2TkZT?=
 =?utf-8?B?ZFlWSHljNVJDMDhlR0hsdmNId2dXVXdybUxybW1HdGtLc1JXQlIxUjBjMHNl?=
 =?utf-8?B?cmVFLzFDd29XMEVXT2NtcElWL2ppN1p3QVV3cjdtWXpwOUMwaWlWSUFkMjdY?=
 =?utf-8?B?WXp5NFFOd1g0UENsY3B2UFQ1Y1RROGN0MGRaTURGZUtaTDJxV2liNlpwV2Vp?=
 =?utf-8?B?MlJTZ1FVeHowcjREVjk3UG12eldjRzF5QVF3N2Jld2lPY0dWVWNyWE1kYnBp?=
 =?utf-8?B?K1NWZ25UWDRWZzZsK2hwaWdUdnAyRy9lMCtydFd5OVpUaWVCdkhoM3VqZUhR?=
 =?utf-8?B?OW4vYlNZKzZzaGtOVGVvbnN0VzJoN0hIdnJSeGpEd0lSWTlBLzRGTmlRUGV3?=
 =?utf-8?B?cjZKaE1yS2ZSYlNrcVV6eTdzZWdMY0dDeks1Vy9NZCt3akZwMkp1dEZvaVFr?=
 =?utf-8?B?eVI3Y2xlZ0ZJZC9CNEJLMHg4Ry9aeFZmSHdGT0p2cFBnbDZhT1R1MG9BVjhF?=
 =?utf-8?B?OFF6MVB4Um54RGYrUXh1ekZhUW5aaW94dmJlZjZOdXBxbGhQK3VJVjBHSkZF?=
 =?utf-8?B?UHd0a1h4ekZtWFVFQzZUcnFid0k1Z3lyNGJPY1E4K3NiY1hyKzNkVDdNc3l2?=
 =?utf-8?B?SDZIT0orK253R09ZRVY1cnU4R3JBMzJmNVE2OUFQY2FYMllwSXZKYW1WV1NV?=
 =?utf-8?B?UzZGenYzK242ek1jbzAxUEZsdjVRcUY1SlVQRTlKak0yU25sUWY4M1FCbitY?=
 =?utf-8?B?UjQwZlBKdDhUNitnZXRtYlVzQlVLYjh5NHUwM21ZcTRWWHdQSThaQkNHN2xn?=
 =?utf-8?B?WjRwemlwbTYxR0FiUytHRVBaVjl0TnVRL243RUNnbkxGNTByQmFyd3RIVktq?=
 =?utf-8?B?MFdJNEV2VHM3VCtOWnNnMXVXVS9DQjlZMDhDNVNURkhIeXk4dUVOSjcxVklZ?=
 =?utf-8?B?Kzc2dFZvS3c1MFZINkJadU44UHRyeWNldlpvUkpCamFwMU1zK3Nvek5keGx1?=
 =?utf-8?B?M3FXTVJIdGtpOFgzM0JzSlMvNGZyT0prY0VxOE8vQmdtcFBjbXFYZlpIbzYz?=
 =?utf-8?B?Uk8wUk1YUFZqWGcwYzg3ekJxTDkzMTJMOFhabUdnU0dUTUpKZGZjdEVxY0M3?=
 =?utf-8?B?dkhQUXF3SVNVSDQxRGJlUHFDTWZkbDFZZHBJZ2RZSmlkUWJWb2NtQXBZa2tR?=
 =?utf-8?B?czFsNnltN2JTem9BOUp2aTFMM04ycE42eEhHZ0dwbUo3N2lhNG54QnBKSmRq?=
 =?utf-8?B?Tktpb1ozb0E5ZnhqMWoyZE1qbTJhd0ZJOWJTNi82RmFpRDZrOWg3UDc2Tkxx?=
 =?utf-8?B?RkZDWlBPYzdFZ2NUNkhjNVpTL25WZEYxYTQvMThyeHhtK01sdUtWc0JKclpt?=
 =?utf-8?Q?bziHGSqvfLMrK56kXiC5Pu8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xtA+fBZUayY9j084rJ2D9pf9LSK2xbWbX6t+5iRFVGBY42CkK+LsoKuiBQVFPYhTQzbQTCrv2+dZxb34ExY9gSgWZ5BAgTpW6zhX9KhFE7uZw+80qaoh1npZtQjp5EAO7Fh2kX/oVSHZceg2PN49syO+cbNPcK6XcAV90eeiALHKMZKe1Dag/BSXbgpvJwLUAPkitDTA/RVeTjkbt5PY10aG71ZYGInqkWzwcDBDPlJG/lWaOWWsDgjYUwB+innNT/Mtxw/LEJsb8RhIWZoWxQYAeNcANaOWc0Vq/QJMqOEK5QnLk+ehtF+/ok+qys7UZbGgFKgOvlkmiwILC+QsqzLKtOKo5pHMQISxEqYB00zDPsaQ1hA8+pd6K/wF5DtrmIfSCTGL183xAjLv5HC2r2ALxNaHuQTZV5u9obGivCmlt4HaHY8ioxV/lJ9vZPTeXFpuugZm4KOUCQxnBiH2Wy1B94Lpn7rpD7DS4xpx6+qltwdICNzetUKNdmSZ6ElxSQT5UxYHvPuvCO5SodAdsSjFVtgWRUBzKgUC8lMXNYSfYh59dYALvDscW/DExOZ1KUHWkLz10m1grT24kiEbTF281VpSeu9FUF5Cqr9J0vA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace2a72f-d8be-4017-3092-08dc3d09b6b3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 11:45:11.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiW9qSjq1X2HkIuN65i0WCbP0ioMcdEA9BP73W3kXBdNmmPJJujiQG9eggUTIpnRf9UW/6rEqLOprXdfi+b8BrT7Ms1QKSG/OXWGQOkD7jH5Rxsm34Y5IdY8hVNgXJhw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050094
X-Proofpoint-GUID: CWlIrh805D5m8vipFw9bgnRl6xJYAxiX
X-Proofpoint-ORIG-GUID: CWlIrh805D5m8vipFw9bgnRl6xJYAxiX

Hi Greg,


On 05/03/24 02:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.21-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

