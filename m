Return-Path: <linux-kernel+bounces-142463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCFC8A2BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733531C2199E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654B53E2C;
	Fri, 12 Apr 2024 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xyz5AtDI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X8VfB0FR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95A53814;
	Fri, 12 Apr 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916304; cv=fail; b=NYvIdNGctECXJoPXvEsQ6zU1qASMgH7WEOM6Yic/J/rlhPjOStojpRFalfqzQ1vZ0XFMD61Uv5znrMt97ibHhLiYkvhHjebgTH9Z2CaeIXpTc5q61EBadnhCnsXOFSyw+9wSCvD7c0m40Dl7AotGzI9rWeHMbzEIpYddvGp/4LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916304; c=relaxed/simple;
	bh=olqhe2iIgOOX6t0fVvJ+a+mEk/+LFI0Y79bjdKOW80s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UVQG+hQxVFuWVdJfPVJeFjkc2onKpOJxXTa2SQ6941bqd40qzlRlOmLAQ4pez6z3YMGTW/M3XT3K96Q25fXPoYyl5oiprDp5Vh6GjJA7GPinJ2m3Tzazka8aAUhxxNU/r0omeGubfa7ldaCU59+09x1IDa3Z98yIioR+gAPsCfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xyz5AtDI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X8VfB0FR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C97Ei8010385;
	Fri, 12 Apr 2024 10:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SH40VXZCcQqpdWCf7Kt3B6mVuuzknTQNupX1DNglSuE=;
 b=Xyz5AtDIczQT1wBdQU+TxQDb+kVNQ1Tw1l0B3oIF42DhvpjN0V5zT7bL2byWe7mV1kt1
 sx75YjYbut/qmyTX+8GuEjUf/vdilYTIKRSPMN84na35aAKOrg2hz4y7t5++gpY6SuZk
 qTQj9/BbH9MmlRtdt/UcK7J3opRwBh0AAIAaisRY3FRblU/cCojd3ZRq+lsptw9Vujsa
 TTc8xK7A2FmA5g7UmP3g/vfy/YhyyBvjOISbXo3Uz7q/E3ycDEexcdX1Wk0hQYoqzApd
 u661J5RvOFP9dsTGbQwd/NseakKnLwXLb9VH3ualQUHfmp4SXIyPF4rHqfbKv6In/LrH Ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacuh2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:04:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C9b0aC026501;
	Fri, 12 Apr 2024 10:04:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrstvdw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:04:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cC6kTLGQ7SaxFYMkBhAFNnn0XOkHmCrG8NB6AtpA793x5LELY6ZPEzM81m0DMI+ss+TqdoUz2egtWDPvrABbm3tleJ2p8Dy0CmDEHxZYtuVIKO2jf/xE98sboncgJhZlDQ05b2YlghrmZnkk0gUOHz2X4in0eR+oJc8nQmfh7SFRe/tre5zQDcRwnYCFTwQrFzdrK4x24gjSF9ZGiUT3UJEYts9QYedBucmqs+Qt+TFtnyawK2rn+cZf4X5qLEzcWTrOuu6wd0H1YotflUt7nJ9z1qRrAw86hVnEx74B40Kfmur8LhFWZKNsrmnxuR8TldeC6fjhuzc8Y7TIrv6cBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH40VXZCcQqpdWCf7Kt3B6mVuuzknTQNupX1DNglSuE=;
 b=hhyjOsk5tnoB1mwesqKGrWGJZdaXLuR22vAbE1P7BMAQ4g6KoqGYBJBNlXUvukXzmQFT7Rhl5ojLdvvElHiNF8TWAPOfdWTcOzGceJ43tepCWgwPGuJWJdnlR+L1nr9kNwHWg/vSU9NV0oBdmOy7HAIFz4xDe9GKStsr8FRgg4Of60ys4KFhf99LP9jDA/mRcXSlIJhV5YGPsXpKkF2JHAhgINEw8oIc0Sej9H4uamkWWryz3JFD/g4WcziXq5vZ+149L3OzVv6PIM16YLMOiuQqyVUqWBT388N9S8jTJqv7gaveQX+9xFW/To166+dtYxua7jFGMklq/lmAQ6ASFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH40VXZCcQqpdWCf7Kt3B6mVuuzknTQNupX1DNglSuE=;
 b=X8VfB0FRTEJqddsO75bhyXVuG86tN3SN1urGUr/pkyK8Fig8MB+YepCm01OYYiNPxJU31Cryte1a+iwtI5Ufj/p/Fe81Bd6dwZA4tdeMpirpDDARt6KVQs/5sL/J0+n5Wdzsr4Fz5xTmVGttSK+ygTxf2Y7wgThB8HlnZSJhIBA=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:04:20 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:04:20 +0000
Message-ID: <4dea23ae-0251-4ba1-a24c-bb5865a7c27f@oracle.com>
Date: Fri, 12 Apr 2024 15:34:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/114] 6.6.27-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240411095416.853744210@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0342.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::8) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: b45c6573-ea66-477a-1913-08dc5ad7ec2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AfDd5SVuEQ/FzgWRFwHldnmyCweC/1VLYqPbLyCxaKCE043FLvYQsn2eSgFyAr+ptpz7j/9wvEVE2Y0dLgm1m9CGXum8C7B0dzD1VkkWxcPpTpxlxvx1zgly8aKAPhYLA2htlBpjJ+/5/D7+Zav93VKyWHNnI2jjfkIKK25beAv/Z7jWTt/+a+9SSwnt4fPHNrqNKq836bR8Tg0atgKOi2lMeVRdTU6qtXUJVyyd1MLDVq6ZGHxhUivbuNSCkzF7NQKlXRtVT+1GTZukfDKMtNPZntUir9ltwRDvSNp1EWDQ7V82CFALEUhKPwnXp33BKyAXNOpZi8HGqbQ+yOfgF5mxJ/6/t+wM3QvNDaHIvxjS4VTldaJMhh9/P8sDIer4WSvA26hedLrWLRxaXHIaVpImN4rXCx7MNAKEZFvHWLHRxqSrJoGcaRJISNoiUtuXpavkynfbt8HlkPktzfWqheSDyDpzoknuLsJzCOn0Speh8D/CYS+KswbzSv9YxzcIjYfsGm0FyBWQkz8iC915tFKliPXQNMgFznf28Vr+r0g5003R89vMex5qti9Kuc8hDRW83RVuK1ihf0L4Vlnw6UZ7bUyz4vFasFihA62yCktsGsuxnUWaFO2SA0yprd9U/GjTZh156jIoIsEJmFHMi69Bruwn79oWIockWexuluo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzJCWnNYaFlidjBWR0tQZGJWZWZlTTNKbk9PSjJHdTcyREVoWG1nM2I0NW1x?=
 =?utf-8?B?UVUvOHIzTjljbVdkbzdCc2VOdFNYNEo3RUpUQ001NzMxcTJaamNqa0NUK1VX?=
 =?utf-8?B?UEZCamZFZjU1c1kveFhLVEMrWDNEWDcvc1ptUDJJVElySzRFMCt6TnZtSHUr?=
 =?utf-8?B?dDB0WFhQT25OYjc2eVY4NDZld3dBVk15MDJrcnZ1b0phRFJwWmdwNHkxTTNy?=
 =?utf-8?B?V2hTM2EyTjI5TGpjZlJJaHJNUVp0QWJQSVUwNFQwdnhGbHhjYnhHa2lGRWdq?=
 =?utf-8?B?a0gwRnFzaVk1STlrVmRHNUtjN0MwUTNzZjExcjJXODRoS2pvWW12ZXdrNXBy?=
 =?utf-8?B?UmVoeXJLWCtsYkNyWjFsWmNLSEw0RGtlNG9jdTJQdmJMdTBSeWN4Wlo0OXpZ?=
 =?utf-8?B?bTdqbUtGSExxWUYvQUhIZkwyZXhDZHVWOXYrVHBIcXpFVXVselJXL0Z3dlRT?=
 =?utf-8?B?SUhWTkRkTm9JeW9VdUFiNTArVkhzd0xqR3J6UW9VWXJLVDArOGtkOS9VZGJW?=
 =?utf-8?B?aXdnTTNEVzgwaUpNeThRemE5YXpiUGsrSUtsS3B6NU9PZ0RzZEdKVmpERHNr?=
 =?utf-8?B?dFNVQ1BOb1hJRFNWRGQ3NVNMYjZtV3RXTUtGZ3pBelIwV2h4Qk44YXJCZTBC?=
 =?utf-8?B?Sk9qVjBVRU0zY01pcnRyYUJtMExWdkRoTWNkTEFQTXVsWFc2M041SjgrV2lI?=
 =?utf-8?B?MGRuTWRzd0lucElVU0NvV3NQcWZ5TzRnWXVoSkNoR29nd3loc0piK2ttOXVM?=
 =?utf-8?B?clNFeDgrbndmSzJTNlF6WUhHbll5TS9nQUFZRGFaY2ZoUFRUNXVxK1pBTnky?=
 =?utf-8?B?YXNWdnk1cTl0M1c3by9TcytyWjVpYU9wRXhmUGo3SU5TTU51dXBDbE1PRTdK?=
 =?utf-8?B?K1I5REZpUGF0TDBYMkZUa2Vjb0UwblhVNUIxTjEvTFF5WWNjS2pWSzNkTWhH?=
 =?utf-8?B?NEFSYTduQThBRGRmajAxeU5PSEpHcytscGowYkhUSWVRUk55TTB5L0libEl6?=
 =?utf-8?B?MHpDd2VTZlkzK0FTMUd2SmFLZU5iNHNFeXVaVHI3VmVxYWp0elRWci8wQ2Nj?=
 =?utf-8?B?ekh1eXNQbnFsdDE1bU10ejNFc3FacDIxN3JLODRWMVIxUXZVQjJqRkFralNF?=
 =?utf-8?B?MVhMdVNFWitVd1ZvQVJDR0tNSGtGL2pHVFJoSFdLREQ2aXlxSHVWYzVxSHhk?=
 =?utf-8?B?RGlDVGU5OURYb1ZTd0NWQ3JRRlFJV094WjFtNzBMWGp4Z3NJa01YOFMwT1ZR?=
 =?utf-8?B?N3UxRnV0QkR6dnViNk5SMm5SRHBRRmEya0FUaU1YdmFKSVJVdEZyS2pLQjFW?=
 =?utf-8?B?SFRXZEt0RVBSNUpDcEhlLzdZRG1Vcm9jUWFxSHdGTmZHZ1JycURRaWM3MW9K?=
 =?utf-8?B?WE1uL1IvWnczSHB6RGFaTWJJMFJlTGFRaGx1WmZtY0pKN1RqVXJkZzVKcUNi?=
 =?utf-8?B?ZDhncHhVeS9HelljTmpxMUJUM0w4TmFIR3RKbTBZbG1CcUw4L3cwQU5ZSk9x?=
 =?utf-8?B?ZXFwYVM5U3NHakF0VTQvQ0ViTVZIcnljM3ZnM3FrOUhvZ3g1cC9uRXJWQ0Ju?=
 =?utf-8?B?bDQ2cDJPdElqSUp6V2JmYXFmMC9zRFZuOS9NNUhMbzA4TjlpL0FrNlFPVm16?=
 =?utf-8?B?cWZBanVORmkzZTBidEpGT0NhRWIyeWVZWVgzZWFTQktFdUJEN2lSdm1aZUlT?=
 =?utf-8?B?dkZlckd3d1NGd1F1bFFxZC9NRDFCWkVxWE56QnJUTmxjb2FwbHdDTzR3S0c1?=
 =?utf-8?B?OXZySkc2b0VzYzVzR2R5MDB2UE5ZR2RBRzRCUUpRUCtvcmZNSG51STFLcVV6?=
 =?utf-8?B?QWt6b1BUTlNwSlFDTU9UMnd0MXo3aEFiVUJDWHZ3OHlnZmJKVW1Ra1dZQUY5?=
 =?utf-8?B?WnNncWFaTmZWMldzaHhJS1dCRjhnaGVVZVBucXo2dGpsZFYzZDJTdzJpQW1t?=
 =?utf-8?B?TWxROFhmcnJXOExpVHB0ZTFkMDh0RXFKUUVmR1AyOEZqYi9NRjliUUFjWHQr?=
 =?utf-8?B?Z1dyR3NMR3VXaHc2QjFLTEhPZUFQNjNhMWRhNzEzZzczVjRBMHpJWGlKNnJx?=
 =?utf-8?B?T1FRNW53TjVHZlZuYkgvWkRCdkh5TmpSdjFabmhCa3ZSbXgwUmZqeE9JYXN0?=
 =?utf-8?B?b2k4dzhZaXFBVDhDOFNMU2xnTGNqUTQxNWJGME14d1NES3NZZk1rZkN4dEVP?=
 =?utf-8?Q?QBEcFGcKzIzxLuaUlbwZ+20=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eJ+Mp2sD29jj9Gr0/k3fiz+BGjeumgJcZN+A4NIxSKol/feAu683yZoiMb7JX4JtKRiVE3DImr0m+RiGnEr4VK2PY5GgTeKDTKfl4X7mCPKOl1BhpWtGhO1AIgphVtmlYJXwE5LsRDz2mQjRIymAb1DwhcUu8DeMmwNkiyXg4CNoejHpYrbwRAVc55cli77wMLHed7k+qHPLKWQWAfkbaNRcMbRNGw46irSHoAaO1BN5uEYCT16laxdn8N+6Pq7duirUJLKwPegsRRWOIyJymTnhyWpWm13lfRJM7oZlXVrMxVdp12urpgje7unE+o1av7cXygM32pro0TwIZD27ezzKp5S5pcW7qyGKFXerbBD79JdHAQf9lhBNT1ykH5GMaSf8wh/5hip02kHFiyOx9InP012rDuh4S3d/ueFLvNWspiC7yWjOXkNTIni4q+tSafE5Cz/kVBv9TLf/G2LRwpTrXqE70ipx14L102JjUuXzu6FghER/lYt+KBX79XDoQ8Xt08JhbaQWJghuHJkHCYPSJl2+KJYo3LgtSnuj7NiSPkiGd8B2nm16YUXniPeHA6sLrWCvXcwTJG+OoqoMXV283ZGKRUembhC1NwquwKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45c6573-ea66-477a-1913-08dc5ad7ec2b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:04:20.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wm7iuCvTU2QVss/wM7aAGdwmrSszGrvlGwO9mXV1ym0UibVf+Ol360dHALvSyMj0g69psMvuRr+NATvncjDsoqlGkcS3gR1NX53n4Oygv3FHMFloyr8a4wxz7xGthvW4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120072
X-Proofpoint-GUID: XPMvAnrs9Pd2dF-cqoJNS_yRH1VK5CUL
X-Proofpoint-ORIG-GUID: XPMvAnrs9Pd2dF-cqoJNS_yRH1VK5CUL

Hi Greg,

On 11/04/24 15:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.27 release.
> There are 114 patches in this series, all will be posted as a response
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
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.27-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

