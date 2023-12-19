Return-Path: <linux-kernel+bounces-4726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B73818137
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0421C21608
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F2746C;
	Tue, 19 Dec 2023 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OA66RjMt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XC8hxfcx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A6883B;
	Tue, 19 Dec 2023 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0JLu3022648;
	Tue, 19 Dec 2023 05:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Xa7U3xekaz85c6S/LpjLQWuaQrKH8WNdROwG2c8BvB4=;
 b=OA66RjMt3GsVzXoQYYQuliqxIy2Aa/5fgWNWdxnugNcL8vRVKUpjUNCls4dHzG84P6tE
 Qu1xjUK+xbXkpvZzx6aj+/Dfd6mX5PNh+uUewC1Yi+lB/6USHuWmhfw49ijXK0tmQ8kO
 ywFzhglYt65PVg2OlXXLLRQTUxqaJ4rD7ImaX6K883kVkau3QlJM2/8CN313iztT1Rvi
 z/GdyMh5hx7e4MI23w2PdMbOop7i6NoN6MTRGjVWF2jSIgY7FyHTGhGd/FuyXilWbRG1
 GcTCPpj22A/fOviYfBFgDv0rrZ0E4cLudl6hRLif11sGownirtQZ9NtGi6r0/Is/bsnx Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13sb4wkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 05:54:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ4snAK028240;
	Tue, 19 Dec 2023 05:54:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bcbah7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 05:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSQ8/LPuQ+HF71ylassPsvLIdoHbC25TnWOdcO5Q2IfsmSc7APD5JWw5ThPQKOsaijXDzMyPWfUy9tc4kQ3gyr6zF/MWD5D0oqx+N+9D+pvwzkEXcBnQ9KvnUWWF0gjNMzXsdcMsil9tSuydtcIXCOinkV5Q98kIAH/BC8bY11f74U0yhcCqU5D1i6p1D+gA4aQrbD7V6TEzlmTyI75IQQZVM9pi3DNORRqIDVLJdJY1d1CtVAo1G/txgJi3xBigxDW7KTf+5sEVV6yNgS/SIZD5ATVjsT8jMURpzs3V07yckQVdei0yYF3dEk7n7a4y/S2ypCUsAWPqHR2mLUrrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa7U3xekaz85c6S/LpjLQWuaQrKH8WNdROwG2c8BvB4=;
 b=PQFzwr4rhmpTLJaZKIIKOFLXSxEKBigIsiaTf16xxvpYEV6mD3eV0dA95/2cqZZsUEubokG+Ut3kA5eWak5rZGTF/t0W1Q51UJkYyjWIsZXZJClpXeKvsTSJ2L7Zboxu1q9sogzdKk+1wn6XIqlDQmCqu/Ksjq8ay1/rVN30wxRv69C0PbA3RRg8Fgu7ouDjokisBSb3DoIhgVDXnl/1GanwmhmaLKM+bH+gK7aVsJEXoinW1H19lZarG62Wr06mfH4DwcVta0jQBGNyxeNpkJl9OhTH6BHa83UYNCgx2s9kLWrS2b6pwL6sW2zxPmfOGdTAD3b2FJwWCzVswwEXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa7U3xekaz85c6S/LpjLQWuaQrKH8WNdROwG2c8BvB4=;
 b=XC8hxfcxrgpvKQOrEybyvFmsfTKKh3YFNuSXabQ4pvt4BO3xUfCTeKRctS+jNm9X1T7ms3bePqxfs5WUa6pf2kvZZzWriF6m2RTuITYbVhhkHmnXZc7xgMcbXGijZjaheoj8XCgOxftIEishIPNOdd407GbNsBBJ2XFgsHOA0jU=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB6430.namprd10.prod.outlook.com (2603:10b6:a03:486::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 05:53:58 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 05:53:58 +0000
Message-ID: <f4987195-97ed-4ad3-8bdd-dbf3fb590e79@oracle.com>
Date: Tue, 19 Dec 2023 11:23:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/36] 4.19.303-rc1 review
Content-Language: en-US
To: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231218135041.876499958@linuxfoundation.org>
 <cf94f746-55d7-4f22-bb53-b5c1be843354@linaro.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <cf94f746-55d7-4f22-bb53-b5c1be843354@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0027.apcprd06.prod.outlook.com
 (2603:1096:404:2e::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: a61193cf-b90c-4140-94fb-08dc0056e43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	L6evDGlErXg+apqNxdoWteMgwJB/FaPfti+pvZZB4kT2gSIguUspXUNDiVj1AxomWaOlwYtVaZzAlMkRGzo4eKe2YecXEiET4ypsEOa/n61NCK2Khoy0hXElW5xwDS16tpF2g+rFm9+hEZzApVeE5mYlGTPQ26q1ZyaArw/XV6DIF2Z0uG3zUbGJSOnp5oUNUEDAa2nZtby6ftQOX4nhKhYTMIpRXah3ekWOC6s/KtyfCRHqfHlkqoghhj8+2tZcyuHYbwQbP5H7+7Ec8/OblDm34eEmzRwuFaKI0qa86UNazQducHBr5OMPuaPV6BuYPm3u/1HeHLvCF2VWimvlqv58vB+3vWKQE8YWRaeM8M6omcSFq9EWKVsKhAXSfBtJbV3orDIp0k9ywUMrztgjJbj4IIqk08b7MQ19RyXlCeEbXtPOOHPNK/E6QFVjxewQ4xn1Nvn2qjf+b9ofKsfC0VwJVvZ4Z1/6lGmNnWCQ+RDHyjHTNoLz+Q5VeSwQegat/fDuLmkfFO4v3by4XMeZQ2YoPUZGxGHzGZCsJNZyWMvwp/E3zRrhaaUu71BP5/THncxxUFm4thD5JT/FQHUyrZ09tVx0+TEhYOlJCMnDgjU+578pOw/ph/cTf9nKg9FyS8fHHoDJQqX3RZE3AvVv++7soepAbi2/Ec30tXO3rlEcMaWHlc/imf12ZTbA9e8C
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2616005)(107886003)(66574015)(53546011)(6486002)(478600001)(26005)(38100700002)(8936002)(4326008)(8676002)(7416002)(41300700001)(2906002)(316002)(66946007)(66476007)(6512007)(66556008)(5660300002)(54906003)(6506007)(6666004)(110136005)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dTVZYUFNWXlkejl4YmlzVWhhZ2ZSc3BPUGxRdzVnVUxiT1I1a3FQdldXNmhW?=
 =?utf-8?B?TzZGTC8xMTNKR0JqOGVkbUNKU0lpck9oVFFRL01FcnBueDJoVDdXQlo1V2VS?=
 =?utf-8?B?d1FpVEhpemoxN3lKellwRDl5WUtiVXlLWXVBWUtvN1pVak1xYkQxaU5VVG53?=
 =?utf-8?B?aEg1eVZ5NVpMYzJFNWlTTklCb1JXQis5ejZwTnE1U3haZFBiTGR4dUJQMTVj?=
 =?utf-8?B?WWpKVkZ5cFRQNTRDMzdxWTVvM3MvR0JHMjhXWXVXODY3TVY5VkxoVkVhKzQ2?=
 =?utf-8?B?bHhCOGtEeStkMW94bCtoZzdmazFqQUkwWVhLWGxCNFJCaFdNOVNablhvZStp?=
 =?utf-8?B?VTRMOWh4OHpvU3h3WklBWGR0bGxxb08zRHlXQW5Makl2SkVDMjEzZHZMUnYw?=
 =?utf-8?B?cjhYVTZ6SU00WlNLZTZrN3BDemxlRXFhQ09VTzVuY29kU0EzVW1SeCs5UG1s?=
 =?utf-8?B?eXRZZGs2OFNpdVg0SlRTcXBjRTVjZU5vU0x3Ti9yMkVwUnk0dUlXTExqbG9F?=
 =?utf-8?B?SW1vQXZLS0pzR0E4ZjJzcnJmSHplNUZvWWJDWXo0bnM5bkVOS2pKREhNNXo5?=
 =?utf-8?B?bkhOaURqQ3VQd2dDejVNdGNsN2x4cEJ3QndoVGRyQnVja2ZFRFhmaGhqKzRD?=
 =?utf-8?B?b2V0eC9UOWw4cFlUUHR2Si9mYVVCc1BoaS9uOHB0eVl3d0o4ZEtrMWpMdWhy?=
 =?utf-8?B?RTB6M2s0KzBkdjZpM2kwY2hqQ055cUdyMUdUQ0VSUjBWbWpQbkxVcDYwVUxK?=
 =?utf-8?B?M1grZzZvWUZmNjVPUXZieEgrajcxb2gxRzZ0NUlGK0tTV3k0c0E1eXBQQVNU?=
 =?utf-8?B?ak5Pd2pJSzlrWi83OVExMkpnaVhFa3NISEo5aSsxWVgxZFAxQ3lvUVFManNQ?=
 =?utf-8?B?WmhyYWl1ZGQ5THN2TjRTbXEzZTBhSmlSRDJ5cHFJN3Z3UVpaR2RTSVovT3hY?=
 =?utf-8?B?MXRKb1lkRWQ2WnpLT1gweC9SNGhxOFltOUltQjFDV2FGY3FRblJNQ3FCL3R3?=
 =?utf-8?B?bTJOR2EwUlJ4R3JTb1V5TUJ3eEVvV1J5V3VoYVhhMlVWaHA4d0prUkdUTE5k?=
 =?utf-8?B?bHJDdDZvd2NxYlJDK25TRU5tQktlVDUzVDNwOVlVR0xuTlNRa0pxdGZxYktS?=
 =?utf-8?B?WFNYWFpZbjVucWhDWFlvclFkTVhBYVlzQnpJam1vRWoxWmhXTWczczVPcXhE?=
 =?utf-8?B?dmwwTlhxaE5SNWt2aEg0ZXJYRUhpbk55ZnpLdmV0eW1WZmdEUFlwcC82dEI2?=
 =?utf-8?B?Rk9hL0VkMTh5cVlSeENYRXdPRFZLaDYrbHlMSHNTNm1MVkVtQVpPOTlHNGpL?=
 =?utf-8?B?eUZaTmVrN0E0YXg4RmlRZHFBd0dZWml4SUw1V2NmMFJidXUrVG42MTl1UnNY?=
 =?utf-8?B?aWIrTXMyT3Ezd09IWUlLSDF1MmtKdEQ5aEpDemhOckJaeUhFcjdVVjFEWlhG?=
 =?utf-8?B?ekRuS2pTNDc1dlBNV0o1a1VNbE5XdlFKMk9zYWs5NGNDZzh2ZDlkNWhCSzBj?=
 =?utf-8?B?RllWNUdIUk9aU3JtVnBPT1pCeW5aT043M3VmbDRkVmZ6bHF1MFRUcjY5UFIx?=
 =?utf-8?B?Q3hnUXNFbDdoc0NVVlNjbmo3bGxPMDQyb0JwOU5QdWd1a0dOY0x4cW83U3Zk?=
 =?utf-8?B?bTNjSWZTSmovZDBmRHN0SG1UV0x1NmdVRHQyQUs2RGJGUFpzNUwvSkNkSkk5?=
 =?utf-8?B?cVdPR3QvcHFsZnY0bkxwUjdOYVhIRDhTSm9YakFabStnWGE2QlVtdlYraTdI?=
 =?utf-8?B?RHlrcFRlMENPSkVUeTJDNHc0TDh0eVEzYmJQckJMRG5wRG0waGtuT045VkFm?=
 =?utf-8?B?dU02UFBBSk1HWitFbFJSYk5BY1RBNWFCbkxBLytGbllmRDhwWXJKNWVhZzdE?=
 =?utf-8?B?NTZOY3d2RnFpUndWaWYwamVOVHRVaXlLcyttUW1zQmk4bk9JK3VaYnQ3YWor?=
 =?utf-8?B?dTFqazRLekhJTmlnOFlnQW50czdvVHJnNitXUDU3Qmt2akJ1cWowV1M5YzU1?=
 =?utf-8?B?bk5XVW50b1hIZ0hSMVNBL1gwWm5VNVFNanRpeVJMYUs3SUp5N0dVMGtmcm10?=
 =?utf-8?B?YUFmUGx6RzlUdEdkQXJ2VmU1TkpGNnlwSWVBUis1U051NU5ING1OQklQT0Jp?=
 =?utf-8?B?Rm8zbWNwMG5PZGpRY2gvRUxCTmQ0TXRkWGFCK1drOEpGUVNKRldKRVVZdGF0?=
 =?utf-8?Q?zMaBzXRNR4zDhPQASyTZj6w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KwmeNd8kx8MtZn3y2DgOF0Ql7bpBWOhXaKPnP1D0wIgnAYUmA2AwxhBOBgxf+K95BhZHsfa5W2YYTndXV1xul8zQ5VYcBUbYCFwF1IEn/j80lMR8dg9MEoRfmVqBrMcXsot1iDwSQHpMIWhskyH5AT4IQkIMQiapFCXTO7XbNb2Md0U9eRgWcPTltE4AnaHrA0HCIs3OSJTDiLBFA8BeJ0kHlYLhquoQZJ1NqWfOW25f7ARVM5c1ZJWO3rOYvWHCiTSxT/JtvuCIalEr2jU8VaMThdTMh2ynv/H3Sv+FrglG+SWiappHIrRLAJlGjz4sYMrJPrBqWwKHO89q+A0kLq9nTqqAt8eL0J6aogArxA/lFMUrl52f4bk0pP3qKT+AADGwiS1Narz4T8YwvaC7wFP40BVffSMAjBFmpAtwYMsFPmC9q2gCzcKlJPTjMHFCWEvMmGKjQa/YprC2XE4IjIiMP3++IuuHkvjhI736WyOGbzVvwEH3Qtl8vAVcs14Gla0Wr9HboGIsnaueXYmDkz4NYHvNorq5iZD/2MbWpydywipNk7Uhu8EuIBvb4jvgB7GxjD6pQ62oPLb1+2oGDF5cy0xMMc6TS5zIN//W+cE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61193cf-b90c-4140-94fb-08dc0056e43f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 05:53:57.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvYUrzJc9ODGbLtf1EIFRZeZVJXPTyxAE9H6vPWNy3tcYH2JFYShTN4XdICIbED6bMdz7T5nYPQ21l4MHGf7zJALb0W0enSo3iBFtddZaQt1LEZEoC7N5VSbhR/vbC/0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=884 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190041
X-Proofpoint-ORIG-GUID: r_kyL_Bg5-1_B6Bh45ZgAMSi5PT6CAJ3
X-Proofpoint-GUID: r_kyL_Bg5-1_B6Bh45ZgAMSi5PT6CAJ3

Hello Greg,

On 19/12/23 10:57 am, Daniel Díaz wrote:
> Hello!
> 

> 
> -----8<-----
>    In file included from /builds/linux/include/linux/list.h:9,
>                     from /builds/linux/include/linux/module.h:9,
>                     from /builds/linux/net/core/skbuff.c:41:
>    /builds/linux/net/core/skbuff.c: In function 'skb_segment':
>    /builds/linux/include/linux/kernel.h:847:43: warning: comparison of 
> distinct pointer types lacks a cast
>      847 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>          |                                           ^~
>    /builds/linux/include/linux/kernel.h:861:18: note: in expansion of 
> macro '__typecheck'
>      861 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>          |                  ^~~~~~~~~~~
>    /builds/linux/include/linux/kernel.h:871:31: note: in expansion of 
> macro '__safe_cmp'
>      871 |         __builtin_choose_expr(__safe_cmp(x, y), \
>          |                               ^~~~~~~~~~
>    /builds/linux/include/linux/kernel.h:880:25: note: in expansion of 
> macro '__careful_cmp'
>      880 | #define min(x, y)       __careful_cmp(x, y, <)
>          |                         ^~~~~~~~~~~~~
>    /builds/linux/net/core/skbuff.c:3630:32: note: in expansion of macro 
> 'min'
>     3630 |                 partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
>          |                                ^~~
> ----->8-----
> 

Note:

Caused by this commit:
98c6fb04f83b net: prevent mss overflow in skb_segment()

I don't see this commit being queued in other stable branches yet, 
5.4.y, 5.10.y, 5.15.y, 6.1.y, 6.6.y but only 4.19.y

Thanks,
Harshit

> Greetings!
> 
> Daniel Díaz
> daniel.diaz@linaro.org
> 
> 


