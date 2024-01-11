Return-Path: <linux-kernel+bounces-23702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA582B070
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AAF1F2438E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911053C48D;
	Thu, 11 Jan 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PZKd2KNu"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899903A8D9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO0FMdx3foiczNOOo2f7tEaK8c6LtmrTdI0xTCv25j79RKSHCKGokVc73qjfu0sL2lVYBG9xC6k+FXxKGvOJokZDrS96i3CILtUfALe4p+urgD+VTCUOgmyqHNu823ynkXrjTyx4h6MveI9aZKvoy5HfXocPjSdLKTpyZQwNrxPpaXDXd4o7a7fu/aK5BvwjUTgBv5rSZpaKoHL3Ro5vFCFhriS8RfzA1gnNO4JwJpoq2ni/iKKsVXFYihyl1d4VYsbiIA4ZuCZ2BYJfPAce2PRMbCmSRUHh+sRtPZGUAIpDQDv0IPedI5ovszHJHFfG3KNb5Jt2RDDjO8Xdzj/Fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXgLa/mCKBW3m5B6Z2xAev1bRqKfyxGPfu0r38CJCTA=;
 b=ekKixkKB9pLLnFbQaiaSKKzPT/tr/0uLiL3dWb/ErYXPXCCnUXaj1qivn3CPXwmauQtKV1/3TVZcmRHeu3Jbr0kmUl96F1j9Oeaxe8PDcp8PjLgpJKqj8Omzu2SgortX8qb+0AbREC7O0zJLChCDfy+b8PVXiqSvnlKPfYduKfQ2+JCwOsELvPhzv+9qS4lIutzkwVLIhqkaWBB48PVI32/3d9Mo7emf4ja1AUt1n8cofpaXpBK0OMwvMUsGlUOLsNyNarF+hCTK0IavR4KmuxWVIOuOnRj6Vg7J/sQiXmBk14qFfR2qbN37pjAFyZBDqRhUk5RrJDJRNeeNLMRMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXgLa/mCKBW3m5B6Z2xAev1bRqKfyxGPfu0r38CJCTA=;
 b=PZKd2KNuwsglg/QCta/QnWSF14vm4zv1jWz8AuIT/IXzovcBvpTihSmvks5xY1zw4KdNetE/VrHfotNLxcynCxp/jUKnnv+nPNGRNzEwlWgTWoZ3E46/QqFEry677MziTkAXYz7XoyczZie4SAbAIJjZWi8zopW4Sep9u91GjKOoEkwvHhpSiMrRV7k3DHwruYhhrvkznypUStN1Zd/1JlkfTwFgdZUVf7SXo9OAb2F9fgSqhhK/sEJSHdAQpIAsWcPP3yQT07qm6pJDUh5YyT/UB1OB/Nlp1HReG+LPivRZgEHKi0FHxavQOVouOZsQPNUxK7TMm1rPpXyl8DbAhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI2PR06MB4476.apcprd06.prod.outlook.com (2603:1096:4:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 11 Jan
 2024 14:15:55 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 14:15:55 +0000
Message-ID: <d3ad9479-f92a-4f79-b97c-0bb17ab0e7b4@vivo.com>
Date: Thu, 11 Jan 2024 22:15:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm:vmscan: fix workingset eviction memcg issue
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Dan Schatzberg <schatzberg.dan@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, Yue Zhao <findns94@gmail.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20240111122451.682-1-justinjiang@vivo.com>
 <20240111122451.682-2-justinjiang@vivo.com>
 <20240111134125.GA390292@cmpxchg.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <20240111134125.GA390292@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI2PR06MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 358943b8-44f5-4050-9818-08dc12afd351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M6MnAUVt6xuVDzR89Hfy6I+dMW2xTzCLOcmGDJQvGzEgHMfdgQI/R1b0kdJNZCjsIikIApYQzI9L0IAU3y7mGSMHbCGldIXQWcexqYyL0Ef2XMzQXunbS8p8xLzIVdw2ahZwQmsjr74SmjIIATwwHkH3xWtY8dP2TZKeUqxas8aqcxn25HPy0ZzYqPf7CTg2ab8QOgrQtLR1I94imyl0UIjCVPgHMwX05M4fi2le6EZLes1HZoV3/eKBZc6WvJOXsTiFmLXa18UXGrSTlZpcXIh5/x8wi3PAsiWLTtH56txVHTdxXrkZfHuWD1Nw9ez4P33mYR2jYy2gypNZ5oWtJYdP281dVdMTeV+9ohOXO6ykf4pvT/rGtNc7LnHxNip+rU1Je/os9cQUQ7ZCV7STZbrDwh3YFrQz9VaKcwETqOVTmo609iSc5zOil0pz50XJtwoaDeKrCxe80AE0asS9btzVbpADMYkvazHGPDojPryy6XZKxeYQNi8xN6CN7Y9gKJhTJiZOL1lxXDqaiVonsHpl164p/DHrKyys6k9WUc66azoGxVWMIWjN9HRGkcx9wQKxpXkspqOgL7r8r/yHjl/hlNlpyL1IbFZUirEJThSz2YtzGGHeMtWIn4BBIqkgSC6nOUGQzUK9pbkxrKW1/N7bLYrgiZ30xF6vDFY3KBntXXtrZvV+tF2z+/sXGcbLopcqvO16+j98IrzuDXN6CQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66946007)(36756003)(316002)(6916009)(54906003)(66476007)(66556008)(52116002)(6506007)(6512007)(478600001)(6486002)(41300700001)(38350700005)(8676002)(8936002)(4326008)(2906002)(7416002)(5660300002)(38100700002)(83380400001)(26005)(31686004)(107886003)(31696002)(86362001)(2616005)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEpKeGEybjZodFQ0K050V0FnSm45OENJdGRWdnhiNTdTTFlWVDZCTTdaZmlK?=
 =?utf-8?B?dzJsSEdkZklyMEhlUUN6eFNpcjRoZlpRTlVmMTRZdGF6TnNEd3JVTlhsSW5l?=
 =?utf-8?B?OHBXSGUyUlpqcEhPamVWMzVzV3BJVWxISVo1QmNZSkg5Z2gvMy9LeXk1cFJK?=
 =?utf-8?B?bWp1WE9qbVpnaWZ4RnBtREtIQ2RXSzE1YUgyKzh1VVdNdVNSWHBsK3NVZjZB?=
 =?utf-8?B?YzlJNXlsUEEvdkwvTzlIU1IvL1ZhbVVHWSt2TkNpZE9VMitMYS8yNTl2b1dk?=
 =?utf-8?B?YUFWTVJaRjBzc2NWcGRDN2NnS3VoYlgvS3JPM0J5L0xRTWNIcEh3QVRlRUhH?=
 =?utf-8?B?a2RXT0FjTjMzakcwS2gxalI0Z0dyUzR0OHozYm9GalhidlJTeDI4aTNrRzJP?=
 =?utf-8?B?OXpXMDlrV01nQlVHNjBOd1AwRithTGxaNSt5TW01MWQzRXZUQzg4YjNwajBu?=
 =?utf-8?B?WHg3NlN2Zm9BOS9oalRRcE5Mc3ZrUGtkNVEza3hEclh4dHRqVkFHZ2s2U0RM?=
 =?utf-8?B?a2MxY21ZN1h5U1FyRXhaL1JNakd3Rk9qVDNpNTh2ditFZHZNY3BuU09hNndI?=
 =?utf-8?B?S1ppSWFtTGN3UlpHY09vcVlySityZldUMVdoUVB2L0JSNlhrUXNJWWdyU2xs?=
 =?utf-8?B?NWo1WFE2MHA2UWk2bllnTHJqamRTTG1OdDU1cWVHM28wVE9DU0ZhTGFKVkhO?=
 =?utf-8?B?WXhGUHlLdlFzV1ZYcmZpY0pOUWJ4Y1dWN3BxaEU0cE9vZWRnSmthcmhmRkhQ?=
 =?utf-8?B?U3NjWnhvNk1qdXM1VWhwbUlwbUNhUFZDTldGVndPVmxFQlNUa3JYNlZBa2Zt?=
 =?utf-8?B?OWNxMStUOFgzWG1kb1FkNnBjYm9iOHVKRUdqU20vaGdSRmIwZEJCTnhaQ0Ux?=
 =?utf-8?B?MWNlekhTam03aFg3T1JzaVRvd2luSmZ4aHBRNk1nR2N0cHNxUFhZYVBxVGJv?=
 =?utf-8?B?L1hFbVhpVTZBblRFZnpHRi9rd0Q1MjBiaEl1bkcyRGNoS3dCMGlTbTBidEk4?=
 =?utf-8?B?eXRyNjU1OHcrRmZVeENNN2dCUHdobk9OTWZsc2tsMksxQU4weFJKcnJ4Y0g5?=
 =?utf-8?B?M2pIYlRGOFkrYkhITlhRTzBDbEVUeFZzLytIaVRBWmY2TTkxSVMzYWp0alFq?=
 =?utf-8?B?TmF5SUNaamhTcEZaYk9PWHZCUWpQeUZVa1RhTG13VGJlbEI3cThLenM1aURN?=
 =?utf-8?B?R2FvNDQxYm82Ty9GcWwrNDRCTWVneVFKWXpUS3hFTldnc3FObjg3WlFnV252?=
 =?utf-8?B?UUtVdzg1U01KR1pLd3ZFQWVBSWhFUVh4dVhQdWwxNnlGeml3QlljNCtUMGtz?=
 =?utf-8?B?bkFoV0s1RnBVL2VwTHRPYWRRWW5XbGdaVTVjRzdCNytlQ2FIbGdhODA1SFBD?=
 =?utf-8?B?dEowcTRhTFRpYjg1MHZJaHhLU29rREhMVWhKYnNhSC9iSUZWVTRzQzhYcGhj?=
 =?utf-8?B?SGJWcFNXVHA5NXk0THpVRUc5OVZHK01BbmU0VVpBUUZGVkIrckRXcm52UG9y?=
 =?utf-8?B?Nk11ODFQMkxaTXVoZGJYZXVNeURFR2tBcmxlR0dEa000K2FiWWJLRDVHU3l5?=
 =?utf-8?B?ejZjVlV3SmxWSEgydzZGblQvM2tvdGJQL0grbG1PY08vSWZzN3RGVmRIYi85?=
 =?utf-8?B?WVFXMUIzL0hNbTRHN0t4VFRyYzFBT2ZKanIrY3JXcGhIWlhUdE5kakdHL3g3?=
 =?utf-8?B?VnRHYWdkbXFsRWVYcHBXNnVuVEUxdXJCaTRqWm1uaHZOeXhKSmZkbjJsODNn?=
 =?utf-8?B?YmhFY09wRElMUlVBZmI5VkZtcVVudHUyTndWTUxKWCtabmdGaHpEQm92Y0dp?=
 =?utf-8?B?UHJQTk1JREllWlBTZlRlWE9qa080dkkvUWlhQkQ3WXdTMkQvU3prMjBtNkRE?=
 =?utf-8?B?cTJYRlVGVlE2UlZoRUU3TWZrNzZWSWRUUEg3TGllU1h6RENYaHZpWG42d084?=
 =?utf-8?B?SkcxSWdla2lpeENwQ25mbU1GckNQSmJCY2dCZ01tV2tsMjFiVUE2UmR4OVA5?=
 =?utf-8?B?UXJVYzM3Mk56VVg4b2NCcnY1Z0sxcHFCZWJhOVdNRVh1WTBJbVl4T3RvRXQ5?=
 =?utf-8?B?b0pFREsxY0w5U3hHeXRsalAyWmFUMzkzTm5EMmlqTnpwaFYvRnlPMEZEWGFn?=
 =?utf-8?Q?GPAT4VkOnX822MQ5RjZ510y4u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358943b8-44f5-4050-9818-08dc12afd351
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 14:15:55.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7FLqZLxDqouc+JDEhCtgX2r2uP4uy1+kS33YJqQ6GeOLbIJd5X+TgV2+C2siT9ApKWNCElm6E9lk8IuMRwJog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4476



在 2024/1/11 21:41, Johannes Weiner 写道:
> On Thu, Jan 11, 2024 at 08:24:50PM +0800, Zhiguo Jiang wrote:
>> The parameter of target_memcg is NULL in workingset_eviction(), and
>> the lruvec obtained by mem_cgroup_lruvec(target_memcg, pgdat) is always
>> root_mem_cgroup->lruvec, rather than the lruvec of mem_cgroup where
>> folio is actually located.
> WTF? No!
>
> 	/*
> 	 * The memory cgroup that hit its limit and as a result is the
> 	 * primary target of this reclaim invocation.
> 	 */
> 	struct mem_cgroup *target_mem_cgroup;
>
> The cgroup that is stored in the eviction cookie is the one whose
> limit triggered the reclaim cycle. This is often several levels above
> the cgroups that own the pages. Subsequent refaults need to be
> evaluated at the eviction level:
>
> 	/*
> 	 * The activation decision for this folio is made at the level
> 	 * where the eviction occurred, as that is where the LRU order
> 	 * during folio reclaim is being determined.
> 	 *
> 	 * However, the cgroup that will own the folio is the one that
> 	 * is actually experiencing the refault event.
> 	 */
May I ask three questions: 1.I don't understand the meaning of this 
paragraph. Can you explain it in detail ? 2.What are the characteristics 
of folios managed by the root_mem_cgroup differring from other memcgs? 
3.If shrink flow uses target_lruvec->anon_cost/file_cost, what is the 
purposr of calculating the actual memcg's lruvec->anon_cost/file_cost in 
lru_note_cost(), and the actual memcg's lruvec->anon_cost/file_cost 
values are unused in shrink flow ? Thanks
>> Fix target_memcg to the memcg obtained by folio_memcg(folio).
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Please take more time to read into the code you're proposing to
> change. You made it sound like a trivial simplification, but this
> totally screws up aging and pressure detection in containers.


