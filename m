Return-Path: <linux-kernel+bounces-85526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A979086B70F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0031C237B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABB40858;
	Wed, 28 Feb 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ca6hMUsR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hZy0HJId"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D04084F;
	Wed, 28 Feb 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144400; cv=fail; b=FMnHwfpna254Lw4YI+4B2wCnVCc6mUKVc2aMABNdDrAgnurNl3kCXkHdLkFKYK77z2Dm+hQCyjhYM64s5R9YNcm9T9EGQRtD8N+yQ+FzvsCrt3e4Uj/Yx7626mxXQKJ1zL5HDF+K9CZ8vb/tJGq1uIrlK2r4I2Gy3WklRwF1cG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144400; c=relaxed/simple;
	bh=xbXOrpQ5o4GwS2X6gUzMk8Hm5kMbWYOHLnwW/QCt7lI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jJvFjvHWoa2QCHfFgKHJPOeSAy2TGRLKld6GeMwo4BY4BtZ2yoqwXl8LckDaI4kOS5rin56oZAlTyM8DxZ+aWRSEGYH9VFFEclJ+7amkh3HI0UC3qvo382kevWNzEblc+pPnNQbHc6G8+AxtnBjzVNx5/THqxNv0MubRkFWK6cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ca6hMUsR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hZy0HJId; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SEVG7J017480;
	Wed, 28 Feb 2024 18:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OhDqoAt2KoN4arOz3fgUvfw8N1jmcOYd4W3ErbsPzZc=;
 b=Ca6hMUsR8I8rPUgzwmGR3aZWcU2h/mlH3Gmp1GyLIusSpHUqPzCEskgfb4xmj8tB+l4m
 oJCtfwsj9r7DuOP0Z17Yeimj+g3adGpYiBU7zDA/k9qpDH9JP0BwQAuCAoXE7C2euGQK
 6RCRe7Q3SipkjUo6MuQsjMLeGl/8gO6Pa22+2FgUvdt+1um1mA+73ifj6Odo281fxOTo
 VgXnxyUnvngOs0qRAkpfR3mQEV7zoGTH+OhvFYkK7GjXxq8D91kzzl2xGBzI+24gZzTm
 m8orP3MfMM+2yv9m+ns79Ye2udcmtf/CR2PGij4emSlPJrPU7yctJ8a3q+ZdJ+SxPdpb Gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7cck2p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:19:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SICj3E022380;
	Wed, 28 Feb 2024 18:19:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9kt9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2oEwgUZypYy+Q+Ipg06dWsEKT6acyYK4YZo6YCE2dDrYMv88T0Nl/5mqvi0pCyTz1pTyEgtipWDwJ6Ir7zlWBG81GqHyA3EO0eLyr6ZYGhLyXIzQWI7uheLLtCfegwQCe1D6DRAhQujfakpDi70X8fKu+JW5I1hMTzdhi39gukAbwZSqyI+k0dkLp21Q6OitFiQdIITiCdvV6xyAA3IKtWolKkxE3O4M3aoVxJQ003wuCRICFG4VAXGxuHMlptW9+/vKvlg2uFpKQFd15egaF6knMUVGV4IYMPeshPVgMVvvZKRJ8zp3RuW82oNbvnGIkscGcGLHnD7vnuhah8IDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhDqoAt2KoN4arOz3fgUvfw8N1jmcOYd4W3ErbsPzZc=;
 b=j2++O4SNiVvVvDG91nopnrPFuvf67UXgx5A+2aHoK4J32jDU9CRpghs8zax5RQ8nEgPFxkGLRJTD5+r8b/tUYcMtGjha6qPtmxbF3licpgpnQARxHZRcgxw3oi7HgfULKwcZRnkwoDlo05JXJO0x2iDePU2Hxy4zqBFEJk+NrpqXTd/SkoFouUVlhnUA9SICODrHtTUhjxt10ByysruGD97TVWlIXeSpeLgdpt/XW7bTCBp0mRPyvIkmlIFzkDeMsF8ZDq8zR3CKPBf6x7U4tYNs7rSs66KH3ntpn+GXFVxLf7IbEI/QmN8kNpKSmdWq62n8PEwJZZ9U5IXn6saXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhDqoAt2KoN4arOz3fgUvfw8N1jmcOYd4W3ErbsPzZc=;
 b=hZy0HJIdbsShWDC+HWZt1Gp9R85dWPEypFAFSTT/F8GcvMF9lRHWKgVch/iU92nfEO1LA+kb6b0kOeCmL8GotoC+NghqDAQhYS43bkb+IL9VicumahsVW6jykTRXGbHIeCj7b/0h6nHeYtPuVrUy4ZRQdW79RNySZDy1ICoHdxc=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:19:22 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 18:19:22 +0000
Message-ID: <da3ceba2-f653-4169-912e-f9c065cf5fae@oracle.com>
Date: Wed, 28 Feb 2024 23:49:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240227131615.098467438@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: b92e6e2e-fe0b-4ca2-9205-08dc3889c995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1AJsC6cmctQXmg9BdRMFgx4/ZY2AmcdmDSwBkTc4rKphPP1L7e/WhuLX8tCWq+t/8YEzt7Mk6a3d6KBJK8U+zqLAGKeRGd3YRvrbyALJv8lkhEnEvqTLgSkBN1STfG+hzF+ioG4RMIS2bKEUOye8C386UU9hoTKFHWwQz83sfBAvLd8GCevndg4ThinCM75l3Jie/51K0JzIsxnGuLVDuRlgdif0xE7VByAZXu1mjbnWiK80AuuUTRQ/FHsQ0Xn+RAMByQoiq9ru1YnsiQs7nOzNMYYSDS4Z2rbujKnn72oVs5ctSgegHkSioWhe/SzoKwI1WntCnT7E2UfYu905bxbjXY22iIourp0QSrZs3AOq0pUkOXaqc1Nw5EHevQIOHfZNADdRqw0/hAp499IV5o1zH1SUemjaauF6xxh3yo1vfbKY9MY96tR6FXdky9fAXlH4goEEkfc3yQ0wFdp15Oe3KVoka//2+I60CSJCbZulHZuxRJntaVbPto/Z17JcsMdqQeav+n2ZxLoueHK4fSuAY6Q9sFEK/xiGBRhf8mw1IKqZKbOiovJBsBVlwibDMHA7iSPOEi0HJy6iRFy3Dbn33oJWFbQEw6eIsO2w3j6UtlKIkhIDXm2q7JQ1SHrU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTFlb3g5a1BNUnluWEFvSnVXSFVzZVltNzdHNVRBd0UwTCt1RGVWa2lUWWRt?=
 =?utf-8?B?dTFkSER6UklKdnlyTi8ydmhwbHJmSllvUmNNTGhCUjh3cTlZMjRZSmdGNnFQ?=
 =?utf-8?B?QVhDUTM0VUNIdGRHK2ttblNpT0hyMXR0UFRpQkdIa3J6Ymp2YWN5aENjVE9u?=
 =?utf-8?B?Vi85MG5VS0RQSkNxOUpVaXpHeGNKb0hmMkJyRmFqUFBZVTgrcjJSM1pwRjhi?=
 =?utf-8?B?NVZ0emIreWJJcHNlbVFaZHBGWTNKd0x6MGxFbklCbmZWaTVJZHQrLzdhbDZN?=
 =?utf-8?B?WEsrV1NBcTFrT2p5dThGZ0lLQTFTMnZqeVlYRzRMVjlNSjdJRmtyN0RNUWhn?=
 =?utf-8?B?czZLSzZkaDJ2NVZ0Z2N5QTZ6YnBuVlpPMnpkN21mSzNaTkM5VUxJM3RiazZS?=
 =?utf-8?B?M2IyU0RveDBUNzdtcXdsTWJ1bE14cVpRanJBSVExdnBwcmRLTWdqYllTRnEy?=
 =?utf-8?B?Z2pWYWdJNUo4WnBERWljeFR4QnlFWDBjRXJpd1dSc0g1NzZ4QVV4NzBqUkRp?=
 =?utf-8?B?QTZudmNUYlJKTjlZSnlLR1phYXdtRTBXTFl2V0VFZzlEZzFiSUxNRjhKam4x?=
 =?utf-8?B?U3BBZ2h5Wm0yV0VpQ0FhbmF4alBrQU53czBiZnU1OWprSk1IWkVQbDFESUJr?=
 =?utf-8?B?Vzd3WmxIWTFxZUdTWGc1NHdzRTlXdU9rL1ZKSUZ6U2ZUM09LQ0pJT0RDRGRJ?=
 =?utf-8?B?dXNjZkgyQjZWdkNQNEtGSHNUMnVrSmRVV3NxN0t6MkRRaE9hUkYrSEVGTitK?=
 =?utf-8?B?WkNRNXdqek1NSmRNdTRGODcvdWRpMUZaMkdzamI0SjdFbjR3Z01pZVBLbGh5?=
 =?utf-8?B?V2J2ai9pYWJHMjRxYlBBeE1WYmtaNXEveEJlTEM3aWhyOTMyNWN2Tm9EcWpq?=
 =?utf-8?B?dGtKTElOSjY1azRNVW80M1R5OHRDVVYzMXN5eUY0NS9SWnNFWUZRMk81SVYx?=
 =?utf-8?B?WlZXSXVDTXZQck1PY01CZTArL01JZklnb0ZJakpYQzBabUwyWlFwdHZPNVlQ?=
 =?utf-8?B?bEVoRFlOUXc0T3dWR1hZRTl0emloZmRxTUVPNE14d1RQTHdnK1kxMHJSZ2M0?=
 =?utf-8?B?WWFhdnIzWVJGeWpxZkV4NE1QenhZd1lEZmZob21FY3Z1RXBLOEJPS0xYYmhZ?=
 =?utf-8?B?eldEeVRCdmZxOThHS21HU3dtVksxa3RSblB4aXI3NnZOcmE4aXgzeG1uQnBJ?=
 =?utf-8?B?SkhMWnVMNkJYS21DdXNydXhzMnd5bXAzVlBHd0V3SStjaytqUE8zZFpCNHRj?=
 =?utf-8?B?NkpTcTlWMmU0UVY3bjBZYkdOREpLcGRYcUxUOTNaWDh5ZkptZTNSb1k5VEpl?=
 =?utf-8?B?N2N5QWtsc1E4RnJzY2FoNTd2UGJUOGFKN3U4U0l3cWNmTkZQVWlKaDh6UWti?=
 =?utf-8?B?cUJISFdoMGNEdjFIbUFZRWtWVlUxbG1BQzd2d3pyT0hIUVhnL2gxclg5ZVNS?=
 =?utf-8?B?N3liUUM4Q3VKWVJlUkVwYzNJeUxrbVcrMC9ZZGg3c2t0c2s3aGRLSXVqS0VV?=
 =?utf-8?B?cVZheXB2aW1rbDBSemtUUXNvVVp0ZzZqaXcrSERUMFVETW50ckQ5V2RVWkxv?=
 =?utf-8?B?Z1lyOTllWEFiSTMzeDF2cm1kL0dJTCs1WTdHd1QrQ0RMYnF3cHN6dTlvQlo1?=
 =?utf-8?B?Qy94VEJEYURib2dNa2hkUUthRy8rb3Y5UWhOV1FvOEVPYVJNT3Jld2JaT0Fn?=
 =?utf-8?B?L0hRMERMMGkrZXhpU2FreFlHdE5aRGZURjZTcUIyUFU4V0hFRGlLajUyL21L?=
 =?utf-8?B?UGFENFBRQ2VmOWVyenlHMGQvcGlzM0F0OVZRV3d5dExsSkY5aXRaaHdhTFl1?=
 =?utf-8?B?WGJzKzlzZkVqV3hUOE82ZnNNeGpheUxDeUpFWkJ4Sy9nakZCMks5Zk5MSHJQ?=
 =?utf-8?B?cHNuZXVqdmJoNDhESVptb0xsM1dSVCtNU1ZnUzMyNHdMRnY4dXl6TGJWaWNJ?=
 =?utf-8?B?WmI2SDF2WVhTdHYveHhVSzlocFY1Y1lOaGJnalBya0FJZFMyd09TWmR2QlZQ?=
 =?utf-8?B?NmhzOUVzMDdORVc3TEZQUlV5ZVNWUXJCeHpuVGtScWlGSFJaWHFBa0hYNGlo?=
 =?utf-8?B?cmhIK2U3SHRnTnJGYnR6c1VGMmY1MjVqZzJTbVBzL01QekFEQ05CRzNKMFpB?=
 =?utf-8?B?cmYyZUtlam9lOC9OSVpTSis2MEllSFhkc0VmazRldFhWNVNka2RrM05TNFp3?=
 =?utf-8?Q?nN7+A86de/eZ5fUtD89ogkI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UNMtA1Jpp6Q5F1XGlZN9Bau1cVV0ugf1z7D5u0Mo3Iupa8PVpWf9g+l/V+9B7b2vPGT6PsvmUqj1fYD2GSCTlA/qV+eAh00j3CB9jq7Sv8EcwqhwWiukUXvul82fTFb144liGD6KO0J3hpZnc4ssL+oYoYMfJaNE7bNTz8PRVAOjvnHf2mEqu4Y/0JTUMcJqikHeRskM+udFnc35aSjzJD5/NxZsxd8M0G5TL78ThKDOkhA//HeFC3439xbdD4E3O5sjFF0ueOWEXIvHiNQpMVCAaDOlzLNx4upmkflh9qpUHshY79aZKjwFDkbdinynF1QZXv6PV/+6rornPe2q+A7hY1QknuY78NXT+VdRJIizjDrCjtwI5rsx1iCIrOOmPWisnLK5TNDtMAimIMy+awvgQIccoOQCekToJvMRZeu+VQgP/Hzl91s5NHQDoOkB4di9EdmN1xevPunuFIn1tLHLAki2wqE46gJgrOwJH1hy+NCMY7sVVm9++CsUI30yxtuxcTuy2ddlc0PcTiBqKPBJvyvH7d+tfZqS2ioupYgBt00CLtsQFwznxCcIK8uNLzoE/85Baihsbb0+j6nWQTbGXbkEOZ98hHc5054liW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92e6e2e-fe0b-4ca2-9205-08dc3889c995
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:19:22.6585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jls7gEyQd9lJF/O3JLve3BBiMkxjHmfTdlyModHLa1irgJRVCv3RHCzLRQCG0ebpm3owW4g+S4HGv0Sfvxq0XTWUeOoHtUYgZlO6YkzzIU8tY6hK74ke+zaL5+fz+teO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280145
X-Proofpoint-ORIG-GUID: AuYhfajADXRawMrd8VHhw-K2jIB3uIkU
X-Proofpoint-GUID: AuYhfajADXRawMrd8VHhw-K2jIB3uIkU

Hi Greg,


On 27/02/24 18:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

