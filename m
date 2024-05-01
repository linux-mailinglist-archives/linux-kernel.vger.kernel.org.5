Return-Path: <linux-kernel+bounces-165632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D756C8B8EDE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61DCB20DD2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4785E18637;
	Wed,  1 May 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gSI9979Z"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D746DDAB;
	Wed,  1 May 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583698; cv=fail; b=njKsXn0M/sKwEiH11s0y2VBcUJpd3pP2uYKikJJyzzDEDxPTjwxJGhqXzLBFpbz8kAPiCSpADU7mfb8pj39GDum9XpanTVTNPa/+egjONRmsrj3/E64AoeDm84P43wlOp23+Uc1zb4R6Ab17q6F+Xa7UJy0gFw98xOr0lSi/o+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583698; c=relaxed/simple;
	bh=ifNHDdJte4is/fwgTU2ezcgLSsEUQPywaJpg9cGGAak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5f01+pjBQ2ru2fPkQHq7SJWtIeKnUS4u2f20iChA0g5HZNQUV/m6Jxo7qlW4PQBUpNoV7yCdauaFQsvmcRkbBfkoDEAcoNcW9d8ajyjrL5k1SPVt3ixNEbbJ/zh/IMHzR0Ptpc6R0M/s5Jr6cVfIa90s+YY4SZQcD1zdZWSn1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gSI9979Z; arc=fail smtp.client-ip=40.107.92.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBFcxRGYDLPjffpDgGzVtsNUVjOw/jNYDLM1z6vZvniffPg83hSH+xYEuNlbaj3i0sRwA04Eqi1wZG9gtFjH4BobCv6zENUDa0JSb9zJKdW5dDV5jkmd1VANgFg0GmUf6a9CfcOtevZ0i42sfxUAUglI4jdBZB2cV6QxOgMbxeKSN2EQrbnP8H7d9FBNDpZ20ekb2OBCOGWl0Pr7/fcYkjiRjYmrsz5HxPVNzgyVIzDH+ETAmrlhPEbOzLV8MDsr4GCaV8McIWnYKMkYkRZL2yx6pE3W7OYzW1asS+6QFLIjvRDjnm0mvSNs1YUYIsP4X3R1ywu/Cv9EGM284g6HTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWySMUrDa2ig3bdpGOoghdVl2emU5aqqVsyPzuaQTeY=;
 b=Jgb/jfsvfAx290clfjRdeQY94uP9PGk90ozctghfUiBq8CBEzbz8F+NLQxYOBJi2M1YwFxw9daYlHH7hTdPl0swm/hvlJF0qZjiINoDfBMmxpJuJiEGv5TGYug3205z2vbIq80V/t34n9Ib3khOXGsJLDOkHc0D7vbkyljNMaEb8oSsdPxoaD4El18VDmWwV6yKT+48uphIYVCwVlBw5b9VculcuV4b9yKriw9HWspIO+pQwCPxh/KhzizDG9FYqDVFh+Tr7awXlaLX6o6ZSa+icUGSOsn+/bzzIFfaMOrXuKxP5UPTTr36QFv0xdOPrU280PD69nfBAOND4vdqvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWySMUrDa2ig3bdpGOoghdVl2emU5aqqVsyPzuaQTeY=;
 b=gSI9979ZpfmfH8c6K+loANGqgeyRkcFE8u1uoP2KXUAuylJQNKT73VSCsk2hIZ1fjJxo/dqK3ol6uZD7lMHpG4x+TXZBCUC5QXkWLt/qkljfjFs24JaTOfzZk8jPNpHU3McDQCJOTTkU8iTqrcvovfnWW5Vcymrpyr7eKXHiRDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) by
 PH0PR01MB7285.prod.exchangelabs.com (2603:10b6:510:107::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Wed, 1 May 2024 17:14:51 +0000
Received: from SJ0PR01MB6509.prod.exchangelabs.com
 ([fe80::b0b8:2e9:4460:ad30]) by SJ0PR01MB6509.prod.exchangelabs.com
 ([fe80::b0b8:2e9:4460:ad30%7]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 17:14:51 +0000
Date: Wed, 1 May 2024 10:14:47 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: liwei <liwei728@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Beata Michalska <beata.michalska@arm.com>, rafael@kernel.org, al.stone@linaro.org, 
	ashwin.chaugule@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf
 in cppc_cpufreq_cpu_init()
Message-ID: <4rgiylbhgl7ds3fzjhpn7miund5c7dd6wi2mxdepbuub7atvpl@mchme5ccs62x>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240429104945.esdukn6ayudgyumc@vireshk-i7>
X-ClientProxiedBy: CH2PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:610:50::32) To SJ0PR01MB6509.prod.exchangelabs.com
 (2603:10b6:a03:294::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6509:EE_|PH0PR01MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c502487-5bab-4a20-fb03-08dc6a023647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Goqg0Ww6mhwitZAfJASAyg/53zbVCc035ikr8EDvTyNMEPYTrxvxKVbumyRO?=
 =?us-ascii?Q?kaNheG0lGNGtiPqsbn6IiDFZtTo1M+RA/EU1tOu4scC6QIr/k2sN/uIXz96e?=
 =?us-ascii?Q?uxRLFahi/yrpkmD2Lc56jObmFLoxO/u5jE18wW0PsmD/nn44qUUa2Qf3jzyS?=
 =?us-ascii?Q?gKm883376ilvpVyK7vAER7SYcsPV/D+yPAD+mtCGVYYmM+JUTRcvd7a8aUcA?=
 =?us-ascii?Q?YuMJIfNicnoHYqO9xq6+olL60utO7Y5nosQjLPbDu5BDty4Gwnvg5HECSzr7?=
 =?us-ascii?Q?hLMYikl2Fjd52Jz8MBn+9kuY18I9DFhQxsW/qzSZYKZtDoZNS8MFw0xUman0?=
 =?us-ascii?Q?bzlP/mfzEbOqNY/22CJ0smM2B+TXioZYcfCGxc1Vbk1ugO5cRRAxEgIrsHPb?=
 =?us-ascii?Q?kQtATaHZ66cU7b6REMG5p8uYpGC/UDPFxGeHPk1swGE9nVFilnuEvgsLwBxn?=
 =?us-ascii?Q?AUz9SmAvfjCrsZ+U0J9VZWqiM/BInAjJMSDZiiS7+cw2On/30oCtoar3yyLL?=
 =?us-ascii?Q?aFWQQGeaOBGW7xPuXSgn9lnhUwZ+wgcpPfbgxonzXGSEzyZVAsc+/S1ya+3M?=
 =?us-ascii?Q?tu5V6j3mnjMAVzGkEuxjS/ZTdxP/aoJ3eNVYDjWPfJEmqS4T2u3s5rsai9Ed?=
 =?us-ascii?Q?7zYC8tP/1haPVfEeHCHAiLA3gzJ88jBPFUrlO+oXWEVhS7kXUrPd992G/S0m?=
 =?us-ascii?Q?mB+oJ9bbFx61n3rq69i9VChIdTAD57TTCjKgVXhh01XCA+D1RRpZ8Zk5+Wey?=
 =?us-ascii?Q?MJywMXPeId/6Y5cqrAK3Z1ZfHk4L8XjFHTqrJZ5N1/lsG+GHrxWOMRhb0XI2?=
 =?us-ascii?Q?XPwbanrz4NvtACZ35fjG0hq/0b4E/Zt0UPDCE1PNMyhvWuq3qWupbOndHXx+?=
 =?us-ascii?Q?bsmy/00okGBi4XG57GDW/qcUdblT0jXw69mwgpDjPmPYOPLSyV7B+w6e6uXg?=
 =?us-ascii?Q?veHu/UaGk9MAlvzZ8XforfiammtsB3YVEAu++gytC8D1m/pFAfLJ3mjwF6pW?=
 =?us-ascii?Q?9dWjF4mIxxmAf3rpB0vMBaL04NTa8FA9YwOPH9t61sFzfxzxuFwOMBTxRfEr?=
 =?us-ascii?Q?M2YC1j6j/kCnEx0FROvKwwl9rcn9ky4Ypm3oukiFu3E84tUnHHFPWNmpXlBO?=
 =?us-ascii?Q?uLNRcM/gBSkcJGNihdY7fcLWIDNLjAWcSJ9F42C0LdH/P1VKMEzs9SoPUAjX?=
 =?us-ascii?Q?CNUOSERn7IMkrKg3eeQoKZ+ybJ0IuTdxJyU26qIdXXqdiAgRARFmjskhxVgV?=
 =?us-ascii?Q?tluAc/Pq37f99qVOOzcupsKPDtA0n+2DNNzgjCg5Wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6509.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rlma5LPqO7CNd0zQaPl1VXhVEQ08XMSMO+d9Ckc1KjfLvZq3FdgfSywuVqyA?=
 =?us-ascii?Q?yOZgV5u5BI2qkA62nffurgcEIVusSECAye68y5YrMkko1X3BbYoZH5TX9vh2?=
 =?us-ascii?Q?S0h5FcCbU6BTQkff1MiQYBja5WdG/wbVY6/iFLeU4zIGPH/M2DEI0qviB1NE?=
 =?us-ascii?Q?7dVhc5s57f0B93x02rgR1G9dP5Oq/9c38eimMRNoVzSNgBQclKkAmJ/krGFh?=
 =?us-ascii?Q?z8U6D+ELyv4Pm7R4G3+awrLgzzsth7KWSN7LiprYeZubRL9K2wAa4/Vzhq7U?=
 =?us-ascii?Q?puSKNlMV790IG23gLsyyF9qaad6RBUgp9B8N+kxhxYI/J4/BprGnQws+7n49?=
 =?us-ascii?Q?i0/rI2y9sXd78vIHJUb0HLYp1pbsuCF0opzTVAzlKsXCxgirZ+WqDKmwksLg?=
 =?us-ascii?Q?XgqoCbCucCVGkYpyIv4q9UrtoP/UBNBhd1PLY+huCySK1QYR+l0eQGAyvm/7?=
 =?us-ascii?Q?qYZLYwTCulsjbEDqrZUqLXoYamruiiDhMHc7muOTDkMvQ97G2ED6TA/w0a5H?=
 =?us-ascii?Q?0jZZSwPRTDRypVTSck0qvF4L3B5kiW7HHBqqCvrPk1nOhwwhlDcu48Y24y7e?=
 =?us-ascii?Q?hKIFPf45SVKECcjgSSlRy5DZwTb5N0D6c1qsr5x5CYNYb7SqtsDp50/Biaal?=
 =?us-ascii?Q?uhdXP8FRz++WNCiNPlbSdhwUtJX0peQmg+ZRSaaU3IW6dEeyRkhcIe0a12ok?=
 =?us-ascii?Q?wjLAgEmCjn4CQfM/sFx400GNp9HRHP8CavryhVbvso0vRD3RvhTTTSyMSFEH?=
 =?us-ascii?Q?rnBRjCqBuQFvfA+g8noip4wpYN9RuN6uaLV3jjD/rAjgS8t6jiAB/25dAsgF?=
 =?us-ascii?Q?RQ3Q9GGYllr8xX//WTsCJzWAmfGFDQeAfMgnHSXzpzC5bPVmttYO0L7Gh656?=
 =?us-ascii?Q?0xjgWwUs+xfwPAfbpxq/tJaYjld2NXP9WBd16cPW/3tRKnKwJwjq3n1IwYPI?=
 =?us-ascii?Q?TnRns0+bI4VxPhmntzVWrQ0QMdCtcIzrWXdIIxED60bNtxpQwoj9Faxco2pG?=
 =?us-ascii?Q?hCmEIRXTUvGBzXKhi6+yn5Bb1zFTC4pq+Gqq3m03rRWUKRPl544q4W581EYx?=
 =?us-ascii?Q?4MDo8uUZMabXMiS/7Y44x8YBnX/EdA4HQwt8dby374XXe8LBg1TREkb+SJgA?=
 =?us-ascii?Q?nNbFDmAXaOGTS5cRe1LbAnmiWDIhVsar/FNISzxhdX4Yb26DjeRBkJkKbI0N?=
 =?us-ascii?Q?CtwRuIICXz3zE6GwJyZuRM8MjKUp2VrAI/iKzR4umPD7OtSqsj91AF2huguE?=
 =?us-ascii?Q?/zx+ffwAVjTjC8x32N/Ohj8IPIBkgFyJIZozm6dvd0+1y9L8utK0juLOj2k+?=
 =?us-ascii?Q?vSIub2LCTKZoWLCBGHvxzCuMjZUFoKPtjkUkdZqvbyG8qXAi5KfuWUxNO1Up?=
 =?us-ascii?Q?U69DcFAu1xvM1s5eEcWm11zw9+1lDd7xwNWzE1F5/pQHUaY0fgauN5YlvBm0?=
 =?us-ascii?Q?3Jd9ax5xm5B61B6xah3J9OJMaM5qmxC83LWlwYjDLHR/GEgXJt74nVc3e6Kc?=
 =?us-ascii?Q?N5XYKiD0w+n6eMv2F8p+7vyA4D/71vLFPd4sNHotdDUV3nt7kDrbfee+8Ooa?=
 =?us-ascii?Q?NrmtsRMEBh+X6QueHX0RSqJ3BilTq6Qez1lnCjTnL9HG19z7P6+JGp+7nM8k?=
 =?us-ascii?Q?u++MjHSbeVjyF0NHoyziiTeWSB8eYlF2HIVzKCgWjmlt?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c502487-5bab-4a20-fb03-08dc6a023647
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6509.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:14:51.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0slJUE2BoTka1SkWwq6eOg7xVdDClcvAiaPKQrq9YYNgDlABlNjlmCC55TLiBvmBoFmk0vl8Qi1FBcP7id5L++W+pKVfC1mFERxvgSDNnHADoGsdc4pgF0clngxIC38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7285

On Mon, Apr 29, 2024 at 04:19:45PM +0530, Viresh Kumar wrote:
>CC'ing few folks who are working with the driver.
>
>On 28-04-24, 17:28, liwei wrote:
>> When turning on turbo, if frequency configuration takes effect slowly,
>> the updated policy->cur may be equal to the frequency configured in
>> governor->limits(), performance governor will not adjust the frequency,
>> configured frequency will remain at turbo-freq.
>>
>> Simplified call stack looks as follows:
>> cpufreq_register_driver(&cppc_cpufreq_driver)
>> 	...
>> 	cppc_cpufreq_cpu_init()
>> 		cppc_get_perf_caps()
>> 		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
>> 			cppc_set_perf(highest_perf) // set highest_perf
>> 			policy->cur = cpufreq_driver->get() // if cur == policy->max
>> 	cpufreq_init_policy()
>> 		...
>> 		cpufreq_start_governor() // governor: performance
>> 			new_freq = cpufreq_driver->get() // if new_freq == policy->max
>> 			if (policy->cur != new_freq)
>> 			cpufreq_out_of_sync(policy, new_freq)
>> 				...
>> 				policy->cur = new_freq
>> 			...
>> 			policy->governor->limits()
>> 				__cpufreq_driver_target(policy->max)
>> 					if (policy->cur==target)
>> 					// generate error, keep set highest_perf
>> 						ret
>> 					cppc_set_perf(target)
>>
>> Fix this by changing highest_perf to nominal_perf in cppc_cpufreq_cpu_init().
>>
>> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
>> Signed-off-by: liwei <liwei728@huawei.com>
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 64420d9cfd1e..db04a82b8a97 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -669,14 +669,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>  	if (caps->highest_perf > caps->nominal_perf)
>>  		boost_supported = true;
>>
>> -	/* Set policy->cur to max now. The governors will adjust later. */
>> -	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>> -	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>> +	/* Set policy->cur to norm now. */
>> +	policy->cur = cppc_perf_to_khz(caps, caps->nominal_perf);
>> +	cpu_data->perf_ctrls.desired_perf =  caps->nominal_perf;
>>

This seems like the safer thing to do.

Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>

>>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>  	if (ret) {
>>  		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> -			 caps->highest_perf, cpu, ret);
>> +			 caps->nominal_perf, cpu, ret);
>>  		goto out;
>>  	}
>>
>> --
>> 2.25.1
>
>-- 
>viresh

