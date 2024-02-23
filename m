Return-Path: <linux-kernel+bounces-77875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82118860B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ECB286FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9314A93;
	Fri, 23 Feb 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z1nSfYN2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PS99zJsx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDE134D1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673801; cv=fail; b=YKLPljWAEMWATbnywoj+1EatHiu/lEUwnE94iLn0tJ+wUgJUFBt7BJRkHnQap+jfjRRF826jwig1fW41UAyghO5G76MOb3nVg/vUTfU9dcd8cZpsPMqogoyf5vBMCNOfe04UZwwmaBdh6xtp5jeAb1ebDUcd5CfmSXwbKaKhn0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673801; c=relaxed/simple;
	bh=cI0U/7rFYfNz51EcVL6JgvelmdrmkI6q/ASY/oviYt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pup8MT+9xUO4mv9SuzE08/UBgyHHsOYSjwqqlKpMqNKeTZ/Gtc5WSB7dw6CeUeO2rmD0MTuFE7mVKKIkFqgc23/kQORoxbHwDJxqNh+SVswmMFnKj0LUfG0rgdkUDlPcut1sFslPEACTZ6Gon1y20b4XgAZgin97ihAsdY7UjmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z1nSfYN2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PS99zJsx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N4xA7u021276;
	Fri, 23 Feb 2024 07:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BSRQUjlDikAnDWqeBzXTBsZiItRqc+UJozBsosT5yWo=;
 b=Z1nSfYN2CwDG2CInl63IaggL8v7x7wT5grEvDHLfqlQdrXCIpu99Dpo29RitHGqKJmtC
 8jhKAOjgTnEho6kfz095232bfQuy/9+xW6QnsnIcCWPDt9cFCrjENBOgCfygFvZhva+4
 FZSbwPmSuWik/VNPmUuErXrHmCxbF44G+JoPLg3LJfYgAN6PZZw54AXFQis+xUvSr0La
 +QzBqXfFka2DSUSDqsmkX1f2usHbuU6SiYSXjr62SQ5eXK5n15u7yR8AqeU+P82Ql4Zv
 kcvw7u04OYxYq+DvcHPIdmlaSoVLN4dPUWkh7Elum64HV2U+XC2f7RHnsMH9smSI+uDd LA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvpsac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 07:36:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41N6oZbi022315;
	Fri, 23 Feb 2024 07:36:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8byhtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 07:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm309vKZ6WfYkG72ZJLu4Ms5fjm/f/5yCV6gyBXJHfHerj+PEjUy/3IqPhLTjvoSL9sd+ubyWq9qd69GFKScTc7VnO8C1a9uTicF92zqC8gEI8ZADUkmNg32pQHA2iPHdZ82n2rTbYn13f0FYKEKYxD25W9OnvsqQ2s2C/BwV/Kut8xMyb0y2g4fg064/YwR9OJAcW9zfP2cLks7woU24tsV8cPb9+O+wsCDneRxeVg3JG7oLyAvxsGCzWSjD7Q+nrS8lYklIadKWkHmUJ6rqDeFF0iSxQTWMC74fMHzSOmmYSNDPqLC9eZjTnuost9JpPFWpnsHFdTuqbzWqtI8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSRQUjlDikAnDWqeBzXTBsZiItRqc+UJozBsosT5yWo=;
 b=oaz/kvgP84MeLJFqPiqV9wWwU9O9M+TR7VnWLfbFJO5q0ZS3dbXhOrwnN1DiH9cY1UhVGT4ZoXnfgaQlS56+GLHPetpZdGnW4AkyQPYRrKnl715i/tx2/9XC5t+An93PbdQQ8uBGOINLx1LpNE/FaFbOYBUWVrhLFH4b/a13ZWIgcFt3LErchdw6RDDr4z9qdR4Ynt8iRdIN/Ug02sm11DzxyABLV2KPmg0oqBR5K2lS3nloVYV+pk7Gqs6slm9PgtzP2MkQwagTBbKaUyG/6CusBcFAhCtR6e617HjiPSUDgOVueXeQhfMpW/+8FA/rKaGgm61SBY7npPQioNP/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSRQUjlDikAnDWqeBzXTBsZiItRqc+UJozBsosT5yWo=;
 b=PS99zJsxuHPQQ9ezdYmr77CJswx8E613Atna3npN1YR3+rLGaOb+7S+Uhh0AQzVtZ3TtPBp2coBgoF3Ui/cDDtpY65771b03KPwaqsRQGRDB8HWUHcAKZ84Dub+dwY4ONPzTgzirEC7NM1c0zQFfJ09bfpCwqQePiuHq4ifmq7o=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 07:36:03 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::f954:65c6:3511:49c4]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::f954:65c6:3511:49c4%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 07:36:03 +0000
Message-ID: <93497e03-1acf-483e-8695-e103fd1bc044@oracle.com>
Date: Thu, 22 Feb 2024 23:36:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
To: "Christoph Lameter (Ampere)" <cl@linux.com>,
        Chengming Zhou <chengming.zhou@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
 <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
 <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|SJ0PR10MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 452c081b-b5e8-44ca-23a6-08dc3442169b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O/FaY64jgeTnTnMEwAXDM+PaU6kdYlF3Mj3HoDP9u9TvELMPXsRWa0L8riPic1wmMjmNIhDkmeF2uPzB+AawTod9cu+L+9UY3fKYNQcQI6m+KowOnDUSoqNwG5WG3u3t8AFkh9HNu8qKaZiUW/5XSE1FdQ0rWO9WhW3Nu6SNOjo+bJH6lJV271ab6INN9xqxS7scEr58GGh1QpJgkn9z3X5d/OdyjBYH0RKUJntLgFVNBzf3LCVWpdg3h9stqAZOxQMM+UbWhnxK4L6MQy9sUV5hQG5Yr68xbPp3RNBiiW7VF/9TgUPKeUkflCr6MNs6d6Y1pZSOGJv7Mp36gKF8jD/ElISwl+tbl787CpZwX6MHN8kWut/aZkfi3C/0h2l2jVHjIAqyuZoUIZ7eoZDKjhGmiICmsJeQ/cQMSJJXG0Z+nqrwygnPNrDs53o7ssL3+3R5Z/eKEPf67rMwgUG4cgvDyQAUUyGkaeh1Pi1zT48eAEBQMoZOwjAHyJY62RyFdZor7pUDMeeJ/w2REVtgGAVItdMVxar2fFs0BdZuTQs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N29UQnBVdUU3RmNadDN6L3gvdnk2enZ4RHl1RklFTHRva0c1d2ZQVzlleUdp?=
 =?utf-8?B?WGkzREJ0VWpkd2tlQWl5M2hPWTNGSmNQV01ESG1ET2NEK2Q0QVFhZVdjaCtN?=
 =?utf-8?B?d09mSFhEVzdOMld5aXRFSG5MRjlhMUZVc1lPTGdCT1g5REkvY0tOdURUNGVk?=
 =?utf-8?B?aXNIekpPRFNsUWhETHBxb251Z1Z5WHRYbnRsdkdaSnJKeTdLUC9FWjFJK3Ro?=
 =?utf-8?B?MzJlOHB2RTk5cnNoak1hUnlRYW5LRkdaNitkV1lmenJoakZSUTNVUXB4a3RW?=
 =?utf-8?B?UDNnYUlrR1J3NjlncDVYbGRwcENLMGl6M2lCVzljMkZoUkx4bXFqYkkzRUZS?=
 =?utf-8?B?U2pkd2VqcDJkVVpXOHlrUTBoTUF3VkhCMXBVc0ZBZDNtaCtqNHlLRUFSZFlv?=
 =?utf-8?B?YU5kNTEyTTd4MXBqaTljZTVvMHVZSmF5dGRhWGlReGFpNXZiREV6aFlKR21Z?=
 =?utf-8?B?WnNrKzhqejhvQXB4TllEQVVONEw5WmdTcVZTbHJqbk1jMUZ0YnVBV2dMaVhQ?=
 =?utf-8?B?OStEOU1iRFc1UUdNRU5Xc0dYeWJpbDBEaVBueFcvb2RHN0t3aSt5ejliU3Bl?=
 =?utf-8?B?TjAra0paMEZYUmpWOUNLcGNyNVYxUHJJQkZMc2RtVDZ6RGlLR09jZUlEZU1L?=
 =?utf-8?B?OVBqVmc2T0RxL0ZlTXNneE1CYUtYcmg0eGNhUVZtSGdzbzNUcXhPbkp5TDFE?=
 =?utf-8?B?QlhQU21BVkxlOVZXME41ZkQzVm9RZU9aK1VZMFlZMjl5RFFuU2FkN1FIN01R?=
 =?utf-8?B?L0Rzc2wvaHpJRzE3MlJaZWFYWU0ybkVGYUtMbFRKLzJDMVRvZ0lpQkZFeE42?=
 =?utf-8?B?M2VSdVFna1VXOVZBTWFZNlg1c1NtK0J2OUpDRllRMUZITUlSWTNCdGltcWRL?=
 =?utf-8?B?MHRUakRIWnFTYnZ2NEVZL2FsdEpLQkxpbENXUTJ3WGxsNjJaUjVtaE5QelBS?=
 =?utf-8?B?MkcwQXZrdGxqZ2Rpc0RGWVluaGxjZkVseTNuM0lMcDNnSFdNRXBjRHVPVlA0?=
 =?utf-8?B?UDExcFdKOENaMmxHdkM4UkZpTEw5TnhKdS9EckdEb293M25WRmhvb2I0dDJ6?=
 =?utf-8?B?Mit3UFhHL002Ky9pMkJ6M2o3ZEo0RUkxNzRHdVc0UmVhZENSQmNKNVRIRWN2?=
 =?utf-8?B?M3ltamNjWXdDNFdHUzBDb0RnNWROSGxkWjk4RjNoQWE4ZVU2ZlkydDAxTVQr?=
 =?utf-8?B?clJNd2wxbUdRbnBsK2tPMWNsUTkxK0hPU1ptK3pQTTdWaWxFdGRML0hoTzZZ?=
 =?utf-8?B?RVhmL1FvT2Q3TjJ6UDdVQVVFT0VlUkYzU1l4d1BqMk1EY0dJTVdnSUxLMFNv?=
 =?utf-8?B?a3paV24wdVczd2wwRDAwN2IyZHd4cmFkWURmb3J2bDh3cENjbnE1ODlEaWV3?=
 =?utf-8?B?N21hd1dIeUtsZmtEeW9wZ3VVU1l4LzNPd1BiMkN4c2RXSzdLT2tiZEk4RzNr?=
 =?utf-8?B?VmE0cWNSSVFXSW5GMUtwZ2FmTU5FNkUxY3dUSHFlck5RdzJiK0VlK2kvRFZ3?=
 =?utf-8?B?d1RLTkRlTGpNSDhGaUlNWkRzSlBzV3VyZDJaMS9KZGdZSzRxVkcwSy9PQVFB?=
 =?utf-8?B?aEhwKzgzMlhUWTh3RDBDSGo2eFZIYnJBRWNHNUhTcHB6eGZYR1poWklSMlFO?=
 =?utf-8?B?Y0xhemRTMzl3UWRsVmlaNkJRRkFGN3d6dFVERnl5Nm9ya1VZVjJtZS95dlFu?=
 =?utf-8?B?OVExWkd3SDhEYTZXQjYzN3B0bUo0WG9oam5BVnYyL0l6U3lQbHdrbTZjbzVK?=
 =?utf-8?B?QUw1bklZb25LTnpkWkdqZEJJcXVCNFVNTFFvMndEU3JhRlRaZGFtc3I3NHZO?=
 =?utf-8?B?OHJadWUzeVN5OVAza3ZQVUZnRVFySVkzWnk0UkhwVzE0V21yVjY5cmdyTGtn?=
 =?utf-8?B?emVrNTg5eFAyTmFiMjJ4VUpxVlVzN3ZLUVpmVFp5WnVyOFFjelF4OFQxS3A5?=
 =?utf-8?B?L0Rxa1FZQWoyRTNlMFpnckx3ajlMTUw5WnBqS1hlNHlKRWltd25nRFNjVTls?=
 =?utf-8?B?SmVhRTVZbVFtTHFkTUtZSUJZSDR5L2x4dTAzYkhKZ096am85eG9XaExnd01j?=
 =?utf-8?B?VnRHVTd2UEw2QnVVU01yL1o0Sk1IbWw1OEx5YnJpdTIwTE5BYVdoZVErdUlX?=
 =?utf-8?B?MEl0M1VtNklWS24zZjIyeFEwaXJhN24rbzFhWjRxamJSQlMzVFhHbStoTENk?=
 =?utf-8?B?ZkNDZnZ5NjRicFZGZERvVkFsem01QVZVTU1PRElRcXpleWF5ek1EYTQyWFNB?=
 =?utf-8?B?UG90Y1BVaE1obldETURZUncycUd3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bt+V07CgMPSCxcb0caCQYvgTCtZKZLPVlc+eKGVxryUwGTMl2L3INqBy4Ircyg9LOlLreH3KgcKy1kRj52MpA5kqiq3pMV4NMq/4M0FsvBIokWZ7KGw9MrwKdH98scLqxAmUCAgsakIfCOH9BmMj5VcUvkqF1OgiXJPHp9UpABUVhsQsH+iCCtIedk60ffizPzQy0koppX4AegJIypw0HrR1YnqYsC3WH5PD7EJPlsD0ft1zoNEI41UnkaQYcN/Eve2fTtUIKJY43/6I4lGVxCb3semIyxyY1xIBdAo21M0f4YmcPNImXau+6urezhP66JyYfMhgb32c4VrRDrUS+oDVOJbEYZPwZi4j47tO/3bQHoNRmHq7NJ2afkFkzXdCuoYQGYY5LhGf+AVNYqopmOyEiresbKMIAVjaju8yfd/uZEZ3KNCYsZyG5Sof0eP+r9O/evdzznuAYN705tc3iKtz8DWzm4m7ovauBqbsGJ7jQCOYRQ/XSViDNsYsYasopsmkcuADWFPgm5IAy4McvVwBzOmGOqrmlBT+m4+bW1NYvf9Kx/8v2BBOOFTvonNTk9QvoYU27Bl0r3rrNGZ0nIrJcTfTdYDpCsCg5xm76/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452c081b-b5e8-44ca-23a6-08dc3442169b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 07:36:03.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IZv8A21FbAVMHMOesk/8zmOWYrRl0RgcBF7mmCHDun9pY2zZMwuES/lXgZNX+Xw1A34wtQG2Xyg7qLgOehIpObnOevLCJ+FMdgpWnI+qqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230051
X-Proofpoint-GUID: S_uo9poq4ENa_vc1CDUEbZLqesVZtJWi
X-Proofpoint-ORIG-GUID: S_uo9poq4ENa_vc1CDUEbZLqesVZtJWi


On 2/22/24 7:02 PM, Christoph Lameter (Ampere) wrote:
> On Thu, 22 Feb 2024, Chengming Zhou wrote:
> 
>> Anyway, I put the code below for discussion...
> 
> Can we guestimate the free objects based on the number of partial slabs. That number is available.
> 

Yes.
I've thought about calculating the average number of free objects in a
partial slab (through sampling) and then estimating the total number of
free objects as (avg * n->nr_partial).

See the following.

---
 mm/slub.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..13385761049c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2963,6 +2963,8 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
+#define MAX_PARTIAL_TO_SCAN 10000
+
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct slab *))
 {
@@ -2971,8 +2973,22 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 	struct slab *slab;
 
 	spin_lock_irqsave(&n->list_lock, flags);
-	list_for_each_entry(slab, &n->partial, slab_list)
-		x += get_count(slab);
+	if (n->nr_partial > MAX_PARTIAL_TO_SCAN) {
+		/* Estimate total count of objects via sampling */
+		unsigned long sample_rate = n->nr_partial / MAX_PARTIAL_TO_SCAN;
+		unsigned long scanned = 0;
+		unsigned long counted = 0;
+		list_for_each_entry(slab, &n->partial, slab_list) {
+			if (++scanned % sample_rate == 0) {
+				x += get_count(slab);
+				counted++;
+			}
+		}
+		x = mult_frac(x, n->nr_partial, counted);
+	} else {
+		list_for_each_entry(slab, &n->partial, slab_list)
+			x += get_count(slab);
+	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
 }
-- 

> How accurate need the accounting be? We also have fuzzy accounting in the VM counters.
Based on my experience, for a |kmem_cache|, the total number of objects can tell
whether the |kmem_cache| has been heavily used by a workload. When the total
number is large: if the number of free objects is small, then either these objects
are really in-use or there is *memory leak* going on (which then must be further
diagnosed). However, if the number of free objects is large, we can only know
the slab memory fragmentation happens.

So, I think the object accounting needn't be accurate. We only have to tell
whether a large percentage of slab objects is free or not. The above code is a
sampling, which should do the job if we take enough samples.

