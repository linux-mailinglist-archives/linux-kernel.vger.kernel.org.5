Return-Path: <linux-kernel+bounces-18514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50730825E76
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FD51F260CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D4C6ABD;
	Sat,  6 Jan 2024 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hN73SrOs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F7J/359D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491E5CA1;
	Sat,  6 Jan 2024 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4065V62s030562;
	Sat, 6 Jan 2024 05:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=KnjQYkz1LBfjghYd8V613LIoZRod3E3G46SfSjRfO5Y=;
 b=hN73SrOs42SGQuBPdPmSmrIXm9Jcr1d91WxoW2QwDM4faj3uPomERSk4EuZitwWn4x/5
 LRdfgTaJLeSxEcADshQWxrP9Tw65uEi2IewL3slEyfGkx7sePANRp8HmfSvU4h4213n6
 q7D/7YR05B2+QZU0i4+r7J6NH0sUOWA23f64euGCGEP23CqIX+TcxJrmVfBt2NcBhJqS
 2QQmFxnXuWQeyv4uovyHrUV4w7TgXN4R89EfCJjYbQh6eIIRWSP7QBjH4TFfOdwoL+ha
 GjURvjyuBV79P3qCbBzYlxhBVHQprVIOghseSDbZMoDVm8oGI2bYOfQcjzWFZEbRSlrE 3Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vf0d1g1yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 05:57:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4064coBu002792;
	Sat, 6 Jan 2024 05:57:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vewa370s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 05:57:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQF8BE5cNwBriAVBEUpdINgsArUw6TgWeLe7fjyyXF0YqjJqmdZ+S1N+d2nCLAY3cuHpmczvev+ii4vdTPv6Wz2R7AAPvkjW1/4NImrtSF0hjbBS8Z7pamr+rJb4GX2Mt/ntdwFysU14uZK6gX6L/OxAid/ltCWc87iWc+2gwvUHbUkQbSIFMJvtGO7/EHRL5wWpEzWQi63n67409FVVGJOn+20206Cpino3F37nk9mhxzmDO8+h8z6t9+tl/mckr0tf4ORNFEuGhy+3rWOrzOnt88c/M7lHGaLr6xjVv1lqnx66R7Gn4/iHjF2zV0Dg1fkuAQNkf1N37XamiwIkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnjQYkz1LBfjghYd8V613LIoZRod3E3G46SfSjRfO5Y=;
 b=HYlLcPpNrP/WXuLeCtrIwHasS74iKUCx4gour1IFlAtQhSO4tzFgQa6X7FcQTlDplHGhjuzia1n10L5FHH+1EZMm5D1F6eD1MbN8aFy2vdJfDcd1XCeskDgEBevcq+wGsrdH1dwLpUHEOvZ2wF1pk24q/Js+1UNZD2PHC3u8J0YYUhIr3gF7xxUgtEkbIQ39ccF6x3Uw/P+X58UCkjav2hxRuS26pBkx1cRiMOVW7RI3obepRyXRvjLW2yYlFfTtxQ55BNSmYpK9r1AslroYThBcGdNGeUG6Ia8KLQZfjYH8dK0iLCqcqHZH9uNHRJBzRQWUg5RR6zsV18VuGCNYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnjQYkz1LBfjghYd8V613LIoZRod3E3G46SfSjRfO5Y=;
 b=F7J/359DzuQo5hjunhxxGgFA29yxJC669nBZs2NBWkyxDddxL0mKx8PmGrZR4KKKcwEpWGiXsPA0u/Orf5ME7e5f8v23+SRqlfzmlLuRuMHzjLncbGd6gDwo2CdfAkw2l/LnbqPnO+qbjTWNDV97UzliZreSfTWBgxL3O8iWIPQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB7193.namprd10.prod.outlook.com (2603:10b6:930:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 05:57:42 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 05:57:42 +0000
Message-ID: <40217619-5bb7-4261-a89c-9459af90bab4@oracle.com>
Date: Sat, 6 Jan 2024 11:27:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/47] 5.4.266-rc1 review
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
References: <20240105143815.541462991@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240105143815.541462991@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 23519a5b-fc3c-47c2-73ff-08dc0e7c6585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iOd1aZvTktN/MY5hqOhYsxQ2XwlDZuitin7D6VKEwhuZgNiUza8E1+sebyIdrLWoFCHioxhLDovzKX/qwSQ7jav/tVzLzt9hRe9zYjlFgSusXFudfYABe1uIh2jx24HyYf0Ek/hb8tEbkCBWGKJXt2W+Ca43ailOedjnW9+0LU9TjztmHgHRlMhO+cncrLc/bzfvbUxUbTpcJz/Wmh94O9oZkzpPQCcrmNXsoLLnK0JIvCX3aB7zJB+vZ7SEtmw1g/fx6Q/tRM/DcPRYRR51tMu6LEXp6hAg9l2Bg8u5fJUfEb+Sz/H2RQ5ONnBTlmou2oQdTyJ+lHiPSGN4ZqnKYeT3TjyqMfBoIldPW/phLOuDcbLrwuVz/iyoSmZ4Xa+lq9xx9r1wjtDluIC+UkbZNTtBQKOYQVJosjca2aM8EhLl0PgjsKMIlJ56uCO5eNYF7/P/p5dCAPRY2tUJiSHELgWv8grXad7rjSO4IVLrkN6PeJ7PtCoEghNaniJ0XU/ruDZ2y8Rsu4/FsFBtfVn0rkpHF1jbl45pt5IBoIpm+bcl6l3X5fVvz0vC1NQ7RcOuymC2/LObBDL7rYjNRgbqJTpO/cVEpPttSAOz30WP+8Cma7SBYvIVfU2v6fnGGXzLwSQEoJ2Vio4vGI5Gh9mHyg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(2616005)(53546011)(6666004)(6512007)(6506007)(478600001)(6486002)(966005)(38100700002)(86362001)(36756003)(31696002)(5660300002)(2906002)(7416002)(4744005)(41300700001)(107886003)(66946007)(66556008)(66476007)(316002)(54906003)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zmh6NkNGWW5vSVFUY0g4bW5uS0xTSTMvWnN6NHNZTS85VnQ5Z2ZCZ0hRWFlF?=
 =?utf-8?B?K0lRRTl6M1AvSVltN2liME94SnRFNGxVa3dvMGV3cTlQNUpKYyt4eERieHM0?=
 =?utf-8?B?ZDN6OFRlZm9kZGUwdS9XOUM5ZmRGOEVLN3FwS1pQZzN5Mi9iRms1RFhzVHJZ?=
 =?utf-8?B?cjBtMklzRElOclg4MENDTlgyTTBBWHl5VHprcWtXa3NTeUE0S0pvMzhFbnJh?=
 =?utf-8?B?Z2xGdHBnNTJqYUp2TW5FQ0E1TnR0cmw3cDNVUFpubkhJUHV6UGpEUVBvUlRv?=
 =?utf-8?B?czN6aklSbU45Z2FtMzF5a25tRnJpS2xpTmZjUTE3WGhFMXVZNjRGYXI5a1U0?=
 =?utf-8?B?bUpnOXB0Q0pRdWx4VzNhaTVNVldPU0FQYUZiR015bkkxK2MxRGxpdGowR1pt?=
 =?utf-8?B?Y00wZFdrN214WG50dnJvT2w1YUVqUjlLY1NaQXVPT1h0N3o0OXFiNTd0Y0lT?=
 =?utf-8?B?YnVXOGI0MDlHUTducittYkxYeWRkeEtrTWRNakFPTFZLNGRTZDFWcVBGMXNR?=
 =?utf-8?B?WDJBdjBUZytpbTNRelhubzZtYjlBcTZLS3NLek00ekpraU95UVZUYUpCeDIr?=
 =?utf-8?B?eTNtRjlrdWNhTTh0NTN1UDEyczFjTlFvRDdSdkR1WnJHeitZSVVteVhnOFJv?=
 =?utf-8?B?aXRDRWZjM0pEbFFtQjlNeUFCSkNDeTBVMzl6SjJ4UHFpTVh0QklTVVhzblhB?=
 =?utf-8?B?RWlhTkx6SUpSMUpjak81Tk9UU29GSW85QVgvRGhlSGZuR3ZpNnhLOE01WHo1?=
 =?utf-8?B?ZXgvWjI4Si85SHJXTVY5SEg1cDJsZWNhVUtXTlc1bmZHTjVEWUFSYVBPNzcr?=
 =?utf-8?B?YzdqRWFnNkRTeWJ4NW85SXM5RU9YV2FZeTZGVFR2ejVvZjJoakJocXYwWjNk?=
 =?utf-8?B?ajZOcXMrTGRTYm93alpZWmdxRnNOMnQrbEo3eG5ScWVwenVEdEdDOWlnS0RY?=
 =?utf-8?B?bEc0U05hNG5wc0Yxb3NVUHIyOFV1SHA2QUVLSUpVRmM5RldHTnZMbjViVDN1?=
 =?utf-8?B?bWxxRFgzM3dJMlhZWkVvU2xLUzkwSVQreUJDWFE0TmxRdWlmMTZIT3p3ODQ5?=
 =?utf-8?B?RVJ2NE9IYVg5THBXa0VMM1FSSmFFTDdzRmtWNzJZRTFuU21aaTM0Nk84ZU10?=
 =?utf-8?B?Uy9QOEFXVUJZejFzN3pjTUxORmdMNWJvYUQ5VEJRdmhkTFpPVWVUeFAwUGp5?=
 =?utf-8?B?aGgwR2RPaGc3NlBtc3RkWUlxdWlFckZYcHd1SVNtcGhibEE2VU5UQzFUdURI?=
 =?utf-8?B?a0RCMGNSRlBKMEtEZHdPdUw2YWlwYTluVWdUMFdlUjFjaGxSRU1rU3k4V2lt?=
 =?utf-8?B?ajdKaFFJcHBmeVcvbS9TNkpMMHpEMDRtTW4xY0pDNUJGUHpHYXhhVnVwVzIx?=
 =?utf-8?B?cUdoQUJXanBQSWdoNlhKSFIzWHBTY29CZ0JSaElPRnRlT1QxdzJJLy9xMWNJ?=
 =?utf-8?B?a2tDV3R2L3N4dVcwUmxOU0FOTU1QYStUdzY3WFhGb2NjZVZYbDdsK1I1YkVt?=
 =?utf-8?B?YnRUVHVyQU9oVzB2Q1YvRDB3cXlySjVxSEdoMndmNEU0emF5eTBEaXpDTHRl?=
 =?utf-8?B?RDYvMTl6K0hNK3F3S2tWbldRcng2d1ZqNlJMKzJBMldFZW5WU1dXL0NEdXpO?=
 =?utf-8?B?amJUZXlKVGwydXhhaEZGRUY4eXFvelRqWi9JMDRBN0JJOEJKWHlaMFBvQmdX?=
 =?utf-8?B?d0ZYOC91RWFhSnl5eHZYaGt4eTdjZzlEOGpudmpyWkhtTzNPaE8xOENvQXcy?=
 =?utf-8?B?aXBZTll2SHVDcjJTb3QzbkZ0dllmcGdtTXRCdExCUnZ6cTdSYVlDMVhmbmRa?=
 =?utf-8?B?eUxwVmIza3hpZWh5VkJ1UU9UT3EvalltNWx2TXdjRmNDRGJMVEJIL1pzamx5?=
 =?utf-8?B?MkRZRHY2c0RRUEwyZTdHVmFPR3BJWnQ1dmYyUlpSY1lNRXZXZmVJVEpvN1ll?=
 =?utf-8?B?MHc4YnBBYXFIRE9LelB6eTF5VnJ5UGJwTy9ONnFna0F2aURIVTB4Y2NyMEFu?=
 =?utf-8?B?NnBkN285b2duUjVhYXhGc083RzEwSS9XQWV3ajZxTy9saEs0aXJZRnFxSGdR?=
 =?utf-8?B?clRMUDhZbjNzMlByUHFMMXBvMWZBRE5JWHFKUUhvYzM3emRYcDUzNm56K0Rl?=
 =?utf-8?B?TUhjcG1yQjNUZFZLN1lFbHFsTmE5TGxOd0lvQ1orYlJnb2dPL2hPUkxhKytT?=
 =?utf-8?Q?EJ3x0SYVMypp9/vynPrkI3Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/g3H3efBLuFAo1/3K5hQklgV+9Wq98JtZEkZwUXw3VEIjNMRD5YxJNURUeEdOpob3BgvksDSkeWRM7RkKTjQ1ciu6S4s5zC3jefY92NZnx3E7ZhhapG1rWgGTOIBb6/WZNKL59Jyk624ADbwdKyMGF6t5QGPJl0VOozCcoWwyS6h0laNTzh50JIo7bglLZ/Y9rJQ8z/zFdw9uX2HWdE3LWmtvxhEMflpFD+Y5ZfOr1MLVNPmAIROIddwsjsjhjmhvwExBjS9cv50H+e+vzTrYJmOdVAZ8D3mIQNl4az7sYMqvotj/K6G+HPGIgVfbQAQh07lMOclKGLDNRrm8Rz6d06RQP8TZ4OWyFVPCitoiWKr/+b+/BxN276wpV+rSKK1vvDUemN86a+h2QVKp839qp4dsDFV25mNzrdriYRtZJrB8+Oq/oOc8lyF1oKo4jterq2iHD/Lz3txNsYG7PTMwcn5HFAEH2al8hUIJ1vcrOzfWuj+TiEQL/ZwVxLf2acDJm2LOXibXGJc+kcz5+z/Iaj+HruxQjz3M8vEbzSg6Qn/7HQlR4ynMsq2KuOIa3ulsUlN7nxiTI31sSkF2hJ0gIrir609zMNxnEnZKMGfh74=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23519a5b-fc3c-47c2-73ff-08dc0e7c6585
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 05:57:42.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJMMvo6S7DLtbYnE3hTipiADU/UVyUmAUBT4miHOsoUpHOVatLXxlER6299pwzg90Q4InsWzUuYgDDVCmzHMfWZ2wqQzi72yxxJlkmBIToMCFyUz6pCF1+BOM/DondX9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401060039
X-Proofpoint-ORIG-GUID: rw_UM6Bo85s2fFcu3Ec3zUpDMb60sutQ
X-Proofpoint-GUID: rw_UM6Bo85s2fFcu3Ec3zUpDMb60sutQ

Hi Greg,


On 05/01/24 8:08 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.266 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.266-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

