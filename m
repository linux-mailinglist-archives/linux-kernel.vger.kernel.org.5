Return-Path: <linux-kernel+bounces-95071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526C18748EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB18A28280F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688FB63113;
	Thu,  7 Mar 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ty+OPoJe"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF110629EE;
	Thu,  7 Mar 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797264; cv=fail; b=Hu5ujmckVn156Eq99peYHMAQ1cqroF4bF6dfLDaZDw82qE/xqR2F9E+s1V9ia4gCZBLQCwoxD5dfPZhdnMc0g5JjG3QRpuN74jWJmtl0aCbMq6PjgBsAxhItoZ1m2YCk3XaTHWW+589wSbudAt7xXWw8CvJwsjDjBchoRpOFBlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797264; c=relaxed/simple;
	bh=4gKjjFSeaqv7CGLwTErgKgOi6WzyhKLxq0/xePGUgCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtXQgHdXN1NlsNHyHIsUXtwmWlzFm+D963+qxv5KJTTM8AFQy3UFIzaRAOJ3sS78uKPB9TnDTHo2TK3ltcM/gKwZza/3b2kboiWClld4T/fQPkUxlkjbfzxz1gYI6LGs3G/1bAlMNBqMGrtlubNj38aOS40AO8Sqvw2Q+PeFv64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ty+OPoJe; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDIw5SqX2aMHFRIsknKsAwj3LBaP2ZU8fNWtfMV1zOq5Rvvte1BKlxgasg1MoKx+rJBh52ntIRQg8ty5FrrOhJIwzovNcWRswCFYnOjsLdOD/LfqJNjof217N8tKKUM91/V//OPjSayCDU8kF63zOi8vhv11C/ZGxIXGsQtJWK+Kz2ucmwgQiQzQQ9zmf5Hn7AwIovKGZXynvj+7kesFslVYOv0F656al8qs+MRXbv/kSFoF/HduAwYK8GQQUhY0HBWIbLcDAjPp0ECztOR3zOAApj791YooPUTyxABItUNezGXkRZiN+yXFMKhaXRwG+6IFnRfJrIfoNseGgQeCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+33F0XBm3gGmiz5l6LMLlgOL4HM4LAPhvTid4jKMUc8=;
 b=Y9S5f3xx+SFgoZlO0kfS3OOowpUaCXqtMrCX/DEjqDfnhnJsfvYVK1q15/x3PuHGM8IZ5JdbrdtgZBE6OUfdgrylXfKKsWT9MXdHUrHryAKF5Yw85M8Pl4Z+ujp9YLtIESJN3p9shMVPa7a1STp9g5ucmeHa30KCrUoEVDrvDkx2tAaAxt8Ki9FC/wxmNshZsbFlte/1huKtXPOUDPaAiZN8WjD0BWWWJOVzMtjRJfMWBoA4+JrueudUvq04/orrrlc/7yazfA/XmlUm1D8ua6hDqawMKt1MKkzVPdTmWgB9c3YJEhDBe2a8dI9EA6y9yTxlkOkfQ1HGrtctG/86nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+33F0XBm3gGmiz5l6LMLlgOL4HM4LAPhvTid4jKMUc8=;
 b=Ty+OPoJevHkH/v9vaQAEHbsU9NS125PDBfvRVSqluiEXElYoCdyBSbs83fH2MigVHI4TvwGw617g80fJ94UcgrxdGNgHtkqdzCLfP6poyAk7BK1Hsrww6fpPXc2A8HrfU5sKwLElKwGi+GYfUI5bX0g6CidUh7XFdHyUNns3HQWcfELd2QzV8ruLsEdPR+JJbjDWCZOhymCQ/PqHVHyTHA1CjyzTLqMq20MtWbNRi2BNWgLVr+VsUvZx+a+HjmVi/5wgUcq2knCVRODxb8DgbRlB5KhQRfpLB4BP8OfifGiG1QtNsbBD0qpAKISK1KQlp40Dk93wi7vs3mAmCgJL7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEYPR06MB5962.apcprd06.prod.outlook.com (2603:1096:101:d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Thu, 7 Mar
 2024 07:40:58 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::2c2e:81cd:24b0:bc35]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::2c2e:81cd:24b0:bc35%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 07:40:57 +0000
Message-ID: <a32030f0-b6f6-4bd6-8284-bb762ccf9205@vivo.com>
Date: Thu, 7 Mar 2024 15:40:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v6 0/2] Make memory reclamation measurable
To: Michal Hocko <mhocko@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20240105013607.2868-1-cuibixuan@vivo.com>
 <fac8d079-100e-4b8d-9a35-db8219b28b51@vivo.com>
 <20240220212202.59ddc123@gandalf.local.home>
 <3d4f44ee-f533-446f-a9e6-7f58afc78d65@vivo.com> <ZdWpyN_8Z6dvDQ48@tiehlicka>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <ZdWpyN_8Z6dvDQ48@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|SEYPR06MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1451c9-5162-4d39-5ae0-08dc3e79ed74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kuZpcfyNeaM0/kAW8DweV2PnnTAJPaXRn2HTpkscx0fOtWLgREzlUMibGWV3nxSJlwIiqDBsTXS2FkCbtaUsiCCgaDgQ3pBKnxWbQXmhrZFPNKB1XC1ffaAqZjAELM5CSxB2m9DidfhYiErwVFhowPzn019TF+WCL/B7TsiJavdau+pyihLzRaGPV1nV1+iGZZYiO+VdFe69NFGuPYkeEIoaJOAf7CPW7u3aC/J30PwRj2+UQ5jHK4d9bw4rP3EIkfiJqvkOO1kJ4qq45gjopkXcg4zJxeLIhDpQKnkgR50rw936Ubyfz1Nyc9FpU9OYQVDGx94xdSmfHnFuHqv0qzjXfyhvQonN1Ap+rMBHBaMpYumj5odMgo8P7MDOI/eHmkJafdeiqKBanhRFUfXU8eQdZj1uMJ+VGITRxyEhp6f12FklQd2DDLWgcBAzf6rHYVq991htHJRBtLnOawGepH+i08f043zv40L/JsnwIpQuyn4PwgJ+/3S7Py44Fwbyk6VW4vKFnPNxcFUd0/1Fhug7hEZW/ogpj6Uzn79Q7id/jrbZbSFyA+h+Cr2vjPEtLPVpJczdEoA9BzFfLGyiluHukijhFHW9JxmWWbGAetHgiYi0x6lpjgpMwEtpVcfo4/HaFvDLrzCTytA4PoUGpCARSy0wuEm99Hiptx1rue8+s/WUE0XsAhoec3kgCLYbP97yZ96KvHCV9fYDA50tj498kdGukrETLdR3OFm6HqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWxYMU1taTc5VGdEOTV5dmRqTGMyMFZ0bUUwM3NIRUF1NjcwOGhRc2I1S2FM?=
 =?utf-8?B?NldXMXU5dnJHcTQ5ckpZUzhIUWdyeEY3L0VRL1A1Y3VnRlkyaXcvYjVCazVi?=
 =?utf-8?B?TzN1bzhvSVp0OVc3VnhGdXowNFhKd0xSTFZQU1ZVdUhhZS9lSmh5ZTdIbi94?=
 =?utf-8?B?cHMyYllZV2U4RkxmeHVOOHNaamFuOXkxclpkVDVDdm1mdVJqVVZJNWZVTWN2?=
 =?utf-8?B?YjNjOWFrNW9qdjhUa3ZBL0MzQ1FiYXdYMjhGNmZ6WEpSWm8zMWVyQmpKVS9B?=
 =?utf-8?B?NlpleEsvVVVpc3pJTDUxOVFBb050ZkhoWGdlSElYTnpEdkZlYUxNaCtkMVll?=
 =?utf-8?B?QVFLSStyampPK2oxNlZPSTBXS1c3eUM2OWpEdXFqZWNTN28vVzZ4QSs0WDNL?=
 =?utf-8?B?QS9OTDdVTTl3bk8yOW5SdTVXL2MwQzBXN3Z0V0gxQ1VSYUJOL2kxQmxZNmtG?=
 =?utf-8?B?dTRjdEpRLytQYnJXVVBPM3B1TXBqTENvdUxyUFNQR2xUMUhPTlhuV1NsYWlJ?=
 =?utf-8?B?V1krYmhKR1NURHhLRnlTUTFlU3VLamh4Qk9FYlZBNGJPYVZZV0QrbnkxaG5N?=
 =?utf-8?B?eUpnSDdpcVppTjF1bTljYjZLYlJXZXVFTVJxSzdLVXNHN3A0K2Z6ZzIyak0v?=
 =?utf-8?B?cWNmd21Tdk8wMGphSjFEajczSGkzcDNrTnNaQit3aTJLUE5TNlQvLzFtWWh4?=
 =?utf-8?B?ZnNQMkZQblpER0U4WW04Y2RlS1dnSFRLUHpkTVZwdTBIN0Y1TXpYdkZJc05o?=
 =?utf-8?B?eDI3NXEvcWFsd1prdnBGSjVoaGx5a0VmcytzbGJBbm8rejNxRnRkeVVLMWl0?=
 =?utf-8?B?TW5jNFZ5dlErOEk5WS9jV3J1VXgrcnpqV1Y5ZHJqYUJtanBHM3VXanFSQnVC?=
 =?utf-8?B?ekR0ZjhNZFpCbXcxR2wrbkRHY3hwTjA5a1hlUDJXRVRzN0hOcml5MmF6SUlJ?=
 =?utf-8?B?bmNMTTN1UmNZbkhnY2lES0Npb1NOZjZ3WHJFMEcvWStxNDBmVUQrVndPZEJG?=
 =?utf-8?B?VjFsOVJZem1TUzdOelVWUy9NWjliUDdtdklHZTFySTRwY0FMejV1dDc3UVQy?=
 =?utf-8?B?dXNiUG5kck8xNXlRM212c3hWYUptcVhidjgvS1ZkeUQ3eWdZM3ROKzdsWUtw?=
 =?utf-8?B?MlcyeUVqVk1NQStvWEo4V09LV2Zaa1FURHBXUUt0WW44SitINTFPa1NOR0hp?=
 =?utf-8?B?M2J5emRUcWpvRGI4WjhpemlrQ1VtNTRoL0lKdWpSK29UUXByTUdOZHdFUnBp?=
 =?utf-8?B?d1JvZGludnIycll6V09EMmVQQjh0MkUyZ3R2aVd0MUR2aWZpOXdMNTZTNktz?=
 =?utf-8?B?clFPZkxhUnI3bWdLOStEdWlNcEw5WURaNkMwdEpaeENFR0I3eXUwMlJwZnBv?=
 =?utf-8?B?WW5NSlN0VlYxUk1wc2p6V1VzSWJ0QU8zSXZ4dUJqUEpSNVpxWjVJMzhFRHdt?=
 =?utf-8?B?TEdFSmlhM2hyNVRENzhFQVJZVWY5ZEZET215UGttREN4M1Q3bEJlQkV5MlRk?=
 =?utf-8?B?WkhQc2VFSmEvVngvZlhmT0dzMjIzbStmR3JJbmZ5NVQvYk9hNlJRcTYzbm1W?=
 =?utf-8?B?SW1EVm9DaWJEUG1DSUZzcEJSYy9ZczJPcm95V0VBNVVwdE5RbFZpK3N3K0tF?=
 =?utf-8?B?dEJoSzNYZUdVTS9OdlJuZmRGa3B6bUZISW5YS1VpaWtibk93Q2NFOEZtOVFK?=
 =?utf-8?B?dGpwUmh3RkduMmNqN3VYZWR0MmVsejgyUVNrZ25zNXNmNlJYdDdnbHhQbmRF?=
 =?utf-8?B?Nks0WkhCZnRLbkQ5eEYyUTc3eGhEUnRqL01MMThnZFNvQ3Y4OEhuRHBTNzA0?=
 =?utf-8?B?M3ZOMTVRS3hRajJveHBLaTBGY256elJzdUg1ZEtlTk5RVkx6WFVMV05YTU54?=
 =?utf-8?B?UlpYUWpyWnd1KzBGTjhZMUsxenpHd3MvR2xmcFhTZjJQS3djdUNrcG5XUTFZ?=
 =?utf-8?B?WTZQcVF6VkxuZ1VkelJDUkE4RjlZYUk2R2JxcVo3eEV5bkJjbVhlS2FVOEhF?=
 =?utf-8?B?Z3lJczFRenVUa0pCTkhlTWZUVmN6dEpLSHVJdEQrbkZTeUI0Y3NJYzMycGdP?=
 =?utf-8?B?Umw3c1N6b1RQbW84eitDcENleFdhNDFvbU54NkhZQUl6SlB3UTRwZ0VCUzg0?=
 =?utf-8?Q?jx/fxTz5+z8mRZYNA5WvnIX7j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1451c9-5162-4d39-5ae0-08dc3e79ed74
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 07:40:57.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYGC6LZ6KH4ZWTYJ3qtKZBC0wI5ex7h3fEUPqexFbGQXXRmZZyBipwunnBXkQjTwFcsTxjNnKT887LUMGmV/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5962



在 2024/2/21 15:44, Michal Hocko 写道:
> It would be really helpful to have more details on why we need those 
> trace points. It is my understanding that you would like to have a more 
> fine grained numbers for the time duration of different parts of the 
> reclaim process. I can imagine this could be useful in some cases but is 
> it useful enough and for a wider variety of workloads? Is that worth a 
> dedicated static tracepoints? Why an add-hoc dynamic tracepoints or BPF 
> for a very special situation is not sufficient? In other words, tell us 
> more about the usecases and why is this generally useful.
Thank you for your reply, I'm sorry that I forgot to describe the 
detailed reason.

Memory reclamation usually occurs when there is high memory pressure (or 
low memory) and is performed by Kswapd. In embedded systems, CPU 
resources are limited, and it is common for kswapd and critical 
processes (which typically require a large amount of memory and trigger 
memory reclamation) to compete for CPU resources. which in turn affects 
the execution of this key process, causing the execution time to 
increase and causing lags,such as dropped frames or slower startup times 
in mobile games.
Currently, with the help of kernel trace events or tools like Perfetto, 
we can only see that kswapd is competing for CPU and the frequency of 
memory reclamation triggers, but we do not have detailed information or 
metrics about memory reclamation, such as the duration and amount of 
each reclamation, or who is releasing memory (super_cache, f2fs, ext4), 
etc. This makes it impossible to locate the above problems.

Currently this patch helps us solve 2 actual performance problems 
(kswapd preempts the CPU causing game delay)
1. The increased memory allocation in the game (across different 
versions) has led to the degradation of kswapd.
     This is found by calculating the total amount of Reclaim(page) 
during the game startup phase.

2. The adoption of a different file system in the new system version has 
resulted in a slower reclamation rate.
     This is discovered through the OBJ_NAME change. For example, 
OBJ_NAME changes from super_cache_scan to ext4_es_scan.

Subsequently, it is also possible to calculate the memory reclamation 
rate to evaluate the memory performance of different versions.



The main reasons for adding static tracepoints are:
1. To subdivide the time spent in the shrinker->count_objects() and 
shrinker->scan_objects() functions within the do_shrink_slab function. 
Using BPF kprobe, we can only track the time spent in the do_shrink_slab 
function.
2. When tracing frequently called functions, static tracepoints (BPF 
tp/tracepoint) have lower performance impact compared to dynamic 
tracepoints (BPF kprobe).

Thanks
Bixuan Cui

