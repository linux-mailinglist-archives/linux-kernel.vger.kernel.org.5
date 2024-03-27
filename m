Return-Path: <linux-kernel+bounces-120555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3788D94B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EB1B23B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9943613D;
	Wed, 27 Mar 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TLtwaZfp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i165RYah"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB67200C1;
	Wed, 27 Mar 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528808; cv=fail; b=ICJFKFYhgMH0UeeVX0Ol7ylXab4CdFvv1WlxrAtLEjM5fo6gAiVwR6dHmtlSeGrsSTD2IjYNk01wMQxB6DlQjXDdGm1HpziljMOMu/i2qn5WPJsYMfEDvsp/OLxStv6lztOD0PwcsbTK0aQMi1FCEZc8LXpwFAkoGOxXEAm069k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528808; c=relaxed/simple;
	bh=ork9S8aYojobPXj/PE3lHEQe6GVXsm48ekxth2RDqfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VUb8i6dXh3MEB40IOvMg7UhFf6w+MFKpNjdiOUKYYWwHZGpo2iVURiURlZ0kGcRPdFSybsg/ON0YlqJ2cX+uNRR7OhHRAcGx/POut1ihfD2G/44RZ6xGyqJ97DfhY4ZPHiHx+4dXdOtHrO8R70Tu6wIGRqzezS8I31GrJAnAHqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TLtwaZfp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i165RYah; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R87FsC009187;
	Wed, 27 Mar 2024 08:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TuICpek+DdM1oHQJpMyz6akryP9rQMge9qbE6IB4m7E=;
 b=TLtwaZfpNzpSiHa1F0cMIQoJCwDRbX+bdp83KxzfTz9Dw2MYhWeyb/U55wNR69mVkM9o
 36zk9H9+EbkY8SmmRqd3dO+MO+qXTfJm9Yd28vS7TvROeYWJem3JBRhxAE2D8dVeLw5m
 yhnSabcUnqT8uv6Q2DUQldxgiAVbWFotKCddNZ9FLmpxiTBKiNuFBy6sRuhz8d4RPH11
 E/5Dpge22IKF5DfPQ4Ri4234dcK7SMUlr3o5OJXXGSy/8pRv8Nqm918eReGe4l9H9zNF
 A0eyL3SlIooW2X6wD9BTn19G+HTXiZUjut171B7Cd/tdXAC0yqM5Esbh6gjc0g9LucQN Og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x4cxy0a0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 08:39:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42R7WukP019741;
	Wed, 27 Mar 2024 08:39:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh85x05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 08:39:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QozSDJgnyNnWBTo246PcuJK8X6NR/2ohad2ROVkrxlWLvC42p5YgY6OeA86FVJM+5M1x3NyjttiW2La9bfgmpgJdE9/Cy65EGgMJItE2oATTYEQWy1fwhckS2+UUXr8SZhF25NTlcIXYCkD7TSftDrmsCu0xu5wBsOoxsX/e8mH+k3GgZWUz4A+ktUQJ25hNr0zvWfZqCkLTzNP6YuuEH3/ae0ph5KVBXq9S6jw3HQlfRhq8XokRc2MOTVN3/VrwWnpN0W0/48BXJwl1MfwR4W0j1Yv9CRFgvermher0dCJNCmweBM3Pe08LEck7ezGOaY+6MkZ8Pa/WsjHgYek7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuICpek+DdM1oHQJpMyz6akryP9rQMge9qbE6IB4m7E=;
 b=oPwmolSZgce+sJI2SDUQR/8iiWE8fqmw8HIFrUQvx0cBmILzNttJFl81u/0E/DT/3BvyuSV+rUCZLiHQ2DHYuEzGbcyM1obkH9/AJjPixLiksb5WQKIGUV4CzSMpbc0lNR1e+mCBNb5Vi7rQnC80VdM2gIKLevUjHjynDYg6AqKxYaBYd2W7+PnK+d9/DdwwJ1ffzMx2sXPgq9rqjwvbDj8GZYwjxSOaXCGvQp91F+1qHfJIVzEF1TIJn/gZGNaPkx2p4AUQJ8z3srUo6cy0WaD+su2E8TOnvWXmbEzaOc0Kxi5FLUbeWx0dbjVQIqNWsc4ju9TiNleAI5WXzL79Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuICpek+DdM1oHQJpMyz6akryP9rQMge9qbE6IB4m7E=;
 b=i165RYahtryvBglhcc2Txmnb9eZBi8IRbkDABbhR/D8KPNa5GH8iM7i20wFXN0qqBL765IjWpmQiZdvkgpC33JLjIPS0VktR82nZYTOW+t1hJ2kcgF+HkLbfRhpvCMc5+ioOGu+pL38JAp5S5QmllsTU5nknpgMp5yaIu5mrnks=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5203.namprd10.prod.outlook.com (2603:10b6:208:30d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 08:39:41 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 08:39:41 +0000
Message-ID: <e114d9e5-26af-42be-9baa-72c3a6ec8fe5@oracle.com>
Date: Wed, 27 Mar 2024 14:09:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
        pavel@denx.de, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240325115928.1765766-1-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: e07feb4d-d851-4eb7-caa9-08dc4e3971a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qn2kVyTBksSZ8DuF6x/5F2Z/TejWRX5pdOqgP2H4ecHDMh6WP1ujCr5wW71OynbkiHnShysJ9bRWMsR6PjIKLmoEl0oAn9qV73WypFK5ToOtwK/pqOA5Ivl5cjbeZpebVWSKJhFTEALgmw24oTE4AVxn+JyMIvyqqadqwpARhz0TyoDQB1a5GOJSaO6QjwAlvN6l83UWM0rh5cv6bxPJYdcAOMOQvYBd5vQxgHzsxrWHHH/JAsjw9T0R9tP/mDw2ENyMabt2GqlrbKjXgdJNxnvAAF0PNZlcn/H77LHBH+dLpRI/uEfnxIoSqCCT5ZDv6cLXW3aD+c5B7mZtHeeHPW1BN2ALLLVme9t3w7EiN+G63UEHqRQMx92uzDehTnoxXKNAomMk8IIlsYtasVWVitJ3iqtO66LJSdRvYUH2sqGwMoxuWYDSG3pUhRTHDZ4GkouJ8koHncu1Qc6F17bOjzsgbc0aHe9lrgZ8nUPgA0/wll77ybINHNy+/jmGG2OQTodXnLMNPHLXrnSLhZJXB6vdmFkpP+p5XT3dJXcpEutGc+ZxLJwqID0KInmM1FxtBtXEm+abseQ7I/WyMBY7FTEPTwXWc0rPPXGzeRjvXF1j3cXsrvlD2i+Wisfd29ht
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0Y2OC81eUpYUm5qZlpnY1ZQQy94ZDdOTmhCM1BKRHVLazJMTEhqY05TOEhk?=
 =?utf-8?B?RC9HZ1M1b08vTlAxZjBVMEp5WU1nKzlxYXZFOE9qMTZycmVPamN5UzF4T2JY?=
 =?utf-8?B?WFFZdVZpa1J1VTZFVlRHYStaVzdiMVBBRnZvNER6cDRLMFliMUNDbzY1a1ZZ?=
 =?utf-8?B?RUg0emJTUTU0Vk13S1JzMUtBQ25QRW1PSVA2U3JuTlF4aXI5UzRHYXoxZldr?=
 =?utf-8?B?NEE4K3k0dTlFb3lNSHEycGliM0o1VGt2MjB1djFiZ2RaalB0UmhYd2xOMHE2?=
 =?utf-8?B?b3h4YzQyeXJSVm9qVytzdFNiZ1VlZk91Mmh3c2dRWk5wTVdrYmJvbGpJRTVq?=
 =?utf-8?B?OGQ5SWpKMHkrai9SZkRqYnJMeVk3ZlNVOHYvWms4bWxXMVdzdEFDRW91WC9L?=
 =?utf-8?B?VFJVN0FYcmFHTS9hNlJla2FRNzhFVmZqellBejdCZm1WWXVLR3MyMVZEOFI0?=
 =?utf-8?B?TTVlT1N0aGRyOVVRVlFXNTg1ZmRKSDRRQ1hiR1hOT2k2OVVBbE1XUkFrWHNC?=
 =?utf-8?B?VkZaeVdzbTRDcXZWRUJ4eE8ybDkrRjlGU0MxSEZXT2s0aElRcklTQnNEaS9M?=
 =?utf-8?B?enpNOEZtOGZrdjRxTWYyQVg3RHVpazB6L044MWFLemE5OGs3dFNnck1SWTlD?=
 =?utf-8?B?WW9meUc0ZXJ3alJYZnF5WXhscjhNbEphWlBSS1MzTGhHRnZISVJlNWJHNlFz?=
 =?utf-8?B?NmFmWnkwT1dLTkVNTUhVc3k5TEEyZXlKd21RUmttNXc1OXZJbE92RzFRaVZx?=
 =?utf-8?B?aStKanJodWJKcTJobFlzQUg0S2JTaWNydVpVYXFRZnZMUzMzS0FodDgyUHVC?=
 =?utf-8?B?dlNwd1E4aWl5aW1aSFoyU3VucFFPTEZVdVJPcExoYTZQTkwrb1BwYUlEMmRM?=
 =?utf-8?B?U1dWZkhlOE8yZnRMN0UxeE1CZS80bnVYSDJUOCtrTlg4VFJjNnhRWk02Z1RL?=
 =?utf-8?B?UWROLzBVTnZRT0N0OGd2RHR2ZDlSOFVWOEg0bjc1Vy9xNXNXekhFZG8vNVNN?=
 =?utf-8?B?VExDbFJOaG5rVnJxcktWaXc4STh6QjRDcHF5UWt1OFR5WEZnRHcwL3hXeXBO?=
 =?utf-8?B?ZHBYN2FqTE1DUXRlb1pUSExnRC83Nnovd2s5LzRWUkN0WkdXMjVHaUZhT09Q?=
 =?utf-8?B?bVl5ei91cnhuZHFFemphOSsxSDdHQ3cvb1p4UnFGNWpaR2dRRklYc2JYS2ox?=
 =?utf-8?B?MFZORnNjaGFBYUZhOXF0STlNSlJUMFA4N2sza2pURmphQnVrNUs3bWZoTmJh?=
 =?utf-8?B?MlphMzF1VUw5dWVMMlNsTnk0Z3g3a0s1V09KVmVNc3FkL1hLZXBtNElXRjds?=
 =?utf-8?B?SWZIeGVRelJQNjhIRk4xd29ZcHRNZVdFeE5jUGJFWWM4YTcxYy8wRHpicXRO?=
 =?utf-8?B?eEpsWFhZVUxSNHo4c1pzSzRNdGNYRnFVQlI4SXRsVDlhRUh6RnltQlFvbUdO?=
 =?utf-8?B?dWh4NloyRWFYUkwvaS8walpDYjh5N1RMYVQ1b1k0TEt6K0tTY29GYVhENnFt?=
 =?utf-8?B?aGY4OHVEeUQ5OE5URU1CMDAyL2NibGEvZXBHMkM0SVBDcTBod3gvVU15eENP?=
 =?utf-8?B?N3ByQWhGdXpHVmlic1cvU3BrdkNWOWpJZFp0dWlDTCt0R29xSVNybGNrenJl?=
 =?utf-8?B?ajdMQVlSeTJpR1lwWktOVG16ZXpBVlhnR25qelZUWnF1b1VnVWoxdWNWcTNk?=
 =?utf-8?B?bzhkL3ppS05mRFBtVjhXMGQwQUI0VmpSRHlqcHN0aEpnaTJDU2ZBMDNXVkVy?=
 =?utf-8?B?L1M5bXhFSytiOEViZ29DdVFvSDdaYmJQbWlWRXUrbitEanM3ZENkTlBiL2Jz?=
 =?utf-8?B?SFJEVW9GS2Uvcno4ckFZWkowUkpTOE5Zb2ZRTVJKWTVLRXJ6dlZvcDQxTWs1?=
 =?utf-8?B?V2Y2NDRJZFNsdmpYOTN2Mkw1eGJVQ0RINS9ETFdHbTlFUFlJYlZSdGozbEdD?=
 =?utf-8?B?cmgzK3ZraE95WU9Xd2RScWZTYUMxcTNONEM5RmhEMWRabklQeXFEZS9jOGpp?=
 =?utf-8?B?ckxtSlRJamFZWHpzVXlEZ3ZZdUNsRFhGYzhnMjNLTGRxeEdlcTNqb0ZhaU5H?=
 =?utf-8?B?VDBLbUR2NjYvV0IvYzJLWDB5RmFTWE9obGQrbXFiZWlSbC9wbVNMaWtOVXNW?=
 =?utf-8?B?ZzFZeHBWdndkemovUjlLSlpqSXZOOEhERmkrU3hxMC9QenJCWkpBaTZPbk1w?=
 =?utf-8?Q?mpNRvF939hSCvidtQAOVCr8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wd5W50Gdzove4r0iDErV3xWZTkNyRkQx2azkZG8g4DzyobGpEXldZ63AS0aJdcDijucxsX5nBmbcqGDaiLAB63os60S1KbnwOuqDCmuOSJ6N673a+oVvC2WECS/G18jNEk+7U/ik769iFYfFLFIpiEaoKzaflxPY37HnqZkSVt0J3Ii5Zk9+FB06PDYfmzi0B449nD//TJSDi0H94O7DT79vX41B4Qwa38cpNEILuMGB1VkfffFLYfXku4YnRRZUHSqn/ChFRDoDuEgbEEVkifzIOv/oxJJDIe+DmwrRkT4i+jRig4v6AXgSoh5zhA/puEC0BrgF5g348ygCqDU0Vv45XIbIw65cxraiKqX/905wjEoprvCEk8Muot/tZFXNMgp8bPlEYEVrtyizBfS5R9D8ZJGBE6i9PEXot7nqhZpfbf1XkUJin3SHQC8xMXmbJo6aLAptlBbx/Vu492zpOa4B4ag5e5yxoUr7Vxgp6AVvA4JRwM0bVevAxgLK6u5ZJqL1hr9BpFbeXIxeT//S7O0Xglp7hSDfE2rzh6pYd1F8WND04N/VC3m4godSsy4h3gj+tjPYDTKh8AUxFlKi3QPYbTqshuhCsWQJ/g6tAdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07feb4d-d851-4eb7-caa9-08dc4e3971a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 08:39:40.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sae/xiqw+DRTnfov9/6gIm1wlmgDN+aB1vtD8oDPQEzuR/A8xPjS/F4lOGTpcJ6+sj7KAGtw0okeEJhwrtMp+84xiXa3Q+MfcKo1dV6g1eO2o6moXobEGczvt3PLWy+h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270058
X-Proofpoint-ORIG-GUID: BmUG7-k-JdqBomjM1CzkTYTPtF3aBWwJ
X-Proofpoint-GUID: BmUG7-k-JdqBomjM1CzkTYTPtF3aBWwJ

Hi Sasha,

On 25/03/24 17:29, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
> 

We still see this: Same as what Daniel reported at [1]

drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
drivers/cpufreq/brcmstb-avs-cpufreq.c:486:9: error: ISO C90 forbids 
mixed declarations and code [-Werror=declaration-after-statement]
   486 |         struct private_data *priv = policy->driver_data;
       |         ^~~~~~
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:289: 
drivers/cpufreq/brcmstb-avs-cpufreq.o] Error 1
make[1]: *** [scripts/Makefile.build:552: drivers/cpufreq] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1907: drivers] Error 2

[1] 
https://lore.kernel.org/stable/20240327015023.GC7502@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/T/#m15bff0fe96986ef780e848b4fff362bf8ea03f08


Looks like, 5.15.153 is released, so we need to work on fixing this.


Thanks,
Harshit
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

