Return-Path: <linux-kernel+bounces-25658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B482D432
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6F228156E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DE257A;
	Mon, 15 Jan 2024 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JUxlR4F+"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514A23C5;
	Mon, 15 Jan 2024 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTe1WnNTkJwt9Kr7JRJT+CtEWqPpQ0/EQNooPhyCVN9WadCS0ApsdhxvQpCjhuJYQ7+HWMo3RnMTdj4FuBCHLunV//AG5609lxrmFSGK/2aWXFMLJPBvuwtS8vXATRQ/8G+nI2JRdW6p2zgawbRkrZdwIr1u/SgxgG1Ehmzq8p2TQPQdmivopwG3XqkoXJlwKw70NmuaPEj194TWOE1L6tuQOSZh8BOTXip0DMMmtSlrWMn8nKPRYDBBTW0bV1Klvvo3vxLbgOgy6nts7WP61Ko/tZj9IzWDxfBvjECNQ1vAkFl29EgNP1MgK99HBQg+6RVaWfeLBpDQlc4ZBI1v1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUpaom51hJXjSvVhih0g0QjTelFX9vmGOrUDtVibyCc=;
 b=Ro7ieo86sYiYcLbf1RXUgM4h/GirzqGVpf7LJiRuMpeNxsEnffiQ5wzIpbEE7Vyvuxl6E5/5VfEXLgLUnSHoPOxbSfCY9XsHczRnPlHBGygjcQRx+nwnZ04FGfseJLzI5e/H9QOzV5M6b2XT0rojdpL7R0JaEMq5tqDQCak64j93xCLwZZ8/zBBOFcZCTiiJffNTGcTOf7HuaK0F8P9SA+nYlwe706zV/UsxMJhKX0ju4/buxG3O5iWer/oxqxRVJlz7xek41dhwYChgOTJZDjM749H25R5wF9s9ZEgRLJwi3DeZeivTqf6KEfze5Pn7ddP5+tx5h87phJe+BmWcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUpaom51hJXjSvVhih0g0QjTelFX9vmGOrUDtVibyCc=;
 b=JUxlR4F+Af04eIgrqFDSf63MqAwuHbJ6HpAHWIAnM8BmuddJiXU1be3QTfX3pZgmhv0+8rUhrjW9LDW0Wu03+XngoJU3JFkvdduvRWSNMn0FaOiN6+Sp6T3dqWS5HORIRe+a6We9vD2V3ogz6kycEQW6N3oMXsgO7RvlALOevJBX/w52eK/1MmB6jxRXdDt87byxSxGdRNfK4XJNUBsdDjD5l/che6kBz7ebRzld7ItkTGBW1GJe5k3MrQgpxzOJcuBEBH3rgZM575jcwu/UjGS36mhFaMMz0B5Azxvsf/Z69XckD9WXe1Dr9IHTy5KJUXYKF40FMJffFEo4PtHTlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by PSAPR06MB3990.apcprd06.prod.outlook.com (2603:1096:301:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 06:27:05 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 06:27:05 +0000
Message-ID: <fb00ee99-ab5e-4274-af9d-cf4eca509d7d@vivo.com>
Date: Mon, 15 Jan 2024 14:27:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v6 0/2] Make memory reclamation measurable
To: akpm@linux-foundation.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20240105013607.2868-1-cuibixuan@vivo.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <20240105013607.2868-1-cuibixuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|PSAPR06MB3990:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a87f56-712f-427d-fd24-08dc1592fe57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XN4963a4Tq1l4viaukY6uysiyKp8jVlHjmIWh6GEBIRtArK+bDwSGU9/Tp/K/6fzM2c4O9RO18Mfmaz/LD/y2PK3SGKbIC+UjOhIA1jlE7Z8oCPNNHHENQNEfcLs7A0ofsK4nyGpGflLmzJpRJ9Ln9HOVX/jOSyCZHNVnFhIZ3utdFMIPBVBuRAy1yrSCk3jNzb33mYP5rdWL7AUVE8WEokrC4HzDBVUc2yOm4MoTnf3bpa6Z1scmHWPBjehriGHVnW6+Ie2fg3FpyQ8mF1p5xlrm4gNEfvEsgvpTgHgWN65x76yDsYASyIaNWmQ1ok09zI9TVRAc15ZavxJ9NDbUMOwfFEqexuOQz4KdmI37W0zPXPqPB/gR+9zpjyb452S58ut6F9Klpi6gZFDc6afUBfp2cNn0iDOPsq9LEEjifCguEEtEV/srF5XzfXZZ9E7g6+H9XbPBzrMry3lbT9gYTZVl+YM7xc1ptv0xbBBQ3mRSnPuCwmZ6/O4IAkYrpFmFwJ2fDGSSLMTDSgO8GceGtmSGxNT0hOEzBlkFu+B8YJUO7PZ1Cgs/aVu2vPfgVVObvSaiAhMRP5l3l5pps16TOUP9k1SAuPlamZ42uHdxhAztDv8C9XC20qzd2YUSPf6/Wha53ps/Ef9M5FaxkSQs8s2Y1f5TX+NUVg554/QKxwDiZXpfxW0p7uWP9qXUbVp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39850400004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(52116002)(6506007)(6512007)(6486002)(6666004)(478600001)(26005)(2616005)(107886003)(83380400001)(2906002)(41300700001)(5660300002)(66556008)(66476007)(316002)(8936002)(8676002)(4326008)(38350700005)(66946007)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdEZlhWeGRYbllHc0x6MkUvZTl3alpoODN4V01TTkNHWE84NDNuRktBL2NV?=
 =?utf-8?B?SVFpT3VXVHZFM25sOVBTa1lCR2ZNa0wvVVZLTjBDYVhPV3F3MXd6Mm9QeWJG?=
 =?utf-8?B?Y2d5RCthU2FZazdiVWwxOC91Rnc0RUsxOUlJSHR3MnJFVDJkUnp3TldBWkY1?=
 =?utf-8?B?M2hNMitPWEdORFRYR2lhYng4Y0dyK2VReE5YN0lVUjhVd1VJc245d3NXaFRa?=
 =?utf-8?B?QzJ6Nm5sVWwzL0s0aFRsS1hnSzdBSnExbWU1WFlFSzRrT2ZnRjYzUEJXUm5i?=
 =?utf-8?B?WU5TaFNuSERVdmVsZzFkUDFoWXpuOUlRZFdIaHdjWEE0UTJLWFJ0NURUcXRG?=
 =?utf-8?B?NnlCekoxVURNVzdoQmZTcmdJcTAzbm5Mb2lPcWpqRitlVSs4ZFc5U1ZWTmpw?=
 =?utf-8?B?V2N5MW9kcVpmVjNDRlMwU0lQSmtWUHVzL3NCbWU3M3dtMjIyWEo4c3pmOFpo?=
 =?utf-8?B?Njd4K0NqMlBXSHNpRXdxUkFBWjZVUSsxS3pmN2loS3NURlVKOTVwZFBIUXAx?=
 =?utf-8?B?TTF1d0VRUXV6dERmMmsyTTRCSlhNWGVrczlUc25MbTJHQTRIQllRVzZFTStS?=
 =?utf-8?B?OGxwRlJ1MEpsTmt0WlhkMXArWWNZQ3pZQWdrZkFhbUZuVmdOUVYxQ0MweGVq?=
 =?utf-8?B?OGxhSDJvY2JtUWJhN0lpVUFzbGFXMUpEd1Bmck9keG9hbnhFQVE0NGJvYUlH?=
 =?utf-8?B?TXJ2OWZLK00yV3R3dzQrZE5nRGhBSEd2TkhBVU8yc1diYmtNQ0pHOUw1ODMw?=
 =?utf-8?B?YkVKS1ZKSWk4V0hPajlidFM1SFVXNnBCUXRPbXJ4dWdqRlhmODd5OXNXcDVw?=
 =?utf-8?B?dEhBNVp2UkphOWdZS0crZ29STDN1Z3Fub2t0RlhING9CNFFRTE1mNXI3NlJM?=
 =?utf-8?B?RnI1elFyNDkxN2F0UXZPUS9xSmZFajlsR2NYSGJWSjVPeXRuRlYydzNpMjQx?=
 =?utf-8?B?TlNvVzdrdDdoaGNTdUkrYXFndFRyTUhOMEx5ZEViQmFaOW40RG5YekVabFVW?=
 =?utf-8?B?bVZVb0dNV2lCa3RDR2NwcnViL3JkOXB4RGh6K255TTdqL0t4TnFNRlFjVlYr?=
 =?utf-8?B?YVZueW5TR1hqOHpQNk5qR1BIbHZLNFlNTnhnMzk0U2NRUlV6UERsV0o5OXhF?=
 =?utf-8?B?d044bHFqczhJUVI4TmZZekJVOUdkYks2RzArYmJncGNqYWZwaGJxNnNTZ0tS?=
 =?utf-8?B?ZHdXWnhQbnhMUkdFL0NobmV3Z0ZZMm9aSk5aWUI3UE9uUG90dXdjSlpYU3BS?=
 =?utf-8?B?LzlhZDIyTU5nellhRUYrckt0ZGpaZjFZUkwwOVNrVDNXQW02NWxTREJBdXhY?=
 =?utf-8?B?UzJBYVJSTUw2NThaMm5qdTBuQVJGQkJSa2tIb0lkZS9hbUE1Umpzbm5lUDJB?=
 =?utf-8?B?REJ2MmZYMi9SUkVoODNhRm5zb1pGT3ZJNW9BUXdUc09YYjRGRVZSdWo5REpa?=
 =?utf-8?B?eml4ejRWeEZ4bDlBVDA0Y1ZVdDRRZC9CczRreFl2N0ZlQlNIZkdPbXV0YzVR?=
 =?utf-8?B?cnNsYVJpZmpYczUvaHlNVlhESGhvelVVR2xZU1hHazRzMHdWSFlkaDYrZGI4?=
 =?utf-8?B?MXhTVU9vWkpZVjA5S0NWMGYrMXJ5VHNPZTdTMVJpcEQ1S0FBUTd1UTl3ODJs?=
 =?utf-8?B?U0pFVFI3N0ZKV21FMWZka0NCeit0TExyQVdZRHpkRWZTR3p6ZEpnbXprVFhl?=
 =?utf-8?B?aHV0WkZFM1dFSFpWNklEUTVnN0l4ZnpheWpwcDgwR25Fci92cHNnUXdGOS9Y?=
 =?utf-8?B?L0JyZnk5dlplQkw0R2plSXFvV0l5QlZWUUFTMkFaV0VnLy9qaEZ5bW1sYjVI?=
 =?utf-8?B?Rzl5ZmtWK3Nsd2JSd3E1WGNiK2VLVnVqei9GandoVkUyZndrUlJlblM4L0d4?=
 =?utf-8?B?dENRSlB3K2J6K3g3b3p6aFRuYnJ4ZEtqd3A0TmIxWGtpaXBOUHRaeG8zZTBi?=
 =?utf-8?B?ZEVNKzBpbjRQbU4zakVwc0ZGZk9wMHNSc0FOSjYyU0dhdDIzNThXQjUvN1FL?=
 =?utf-8?B?T1gwVG5WdElCV0pqR1FzUERVeHV5OFptRjByclgxZ3NCNml0NTZsRFp0ZmJi?=
 =?utf-8?B?b2xxZVROZC9oVzlFZVV6WmUzVWZCMVo2azU2cDZEZDkzdGdGOEkwSkRvZ3RK?=
 =?utf-8?Q?uei7XnnuItCxg3Ar+Q5xJQGoI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a87f56-712f-427d-fd24-08dc1592fe57
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 06:27:05.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IkNl3J6ActN+8av6+FFrul+Ucsalhzfp/Ou4lU+R7lUe/lsYRAK6yn47myJ/hkwu32QhvG5PRx56xH3PpIX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3990

ping~

在 2024/1/5 9:36, Bixuan Cui 写道:
> When the system memory is low, kswapd reclaims the memory. The key steps
> of memory reclamation include
> 1.shrink_lruvec
>    * shrink_active_list, moves folios from the active LRU to the inactive LRU
>    * shrink_inactive_list, shrink lru from inactive LRU list
> 2.shrink_slab
>    * shrinker->count_objects(), calculates the freeable memory
>    * shrinker->scan_objects(), reclaims the slab memory
> 
> The existing tracers in the vmscan are as follows:
> 
> --do_try_to_free_pages
> --shrink_zones
> --trace_mm_vmscan_node_reclaim_begin (tracer)
> --shrink_node
> --shrink_node_memcgs
>    --trace_mm_vmscan_memcg_shrink_begin (tracer)
>    --shrink_lruvec
>      --shrink_list
>        --shrink_active_list
> 	  --trace_mm_vmscan_lru_shrink_active (tracer)
>        --shrink_inactive_list
> 	  --trace_mm_vmscan_lru_shrink_inactive (tracer)
>      --shrink_active_list
>    --shrink_slab
>      --do_shrink_slab
>      --shrinker->count_objects()
>      --trace_mm_shrink_slab_start (tracer)
>      --shrinker->scan_objects()
>      --trace_mm_shrink_slab_end (tracer)
>    --trace_mm_vmscan_memcg_shrink_end (tracer)
> --trace_mm_vmscan_node_reclaim_end (tracer)
> 
> If we get the duration and quantity of shrink lru and slab,
> then we can measure the memory recycling, as follows
> 
> Measuring memory reclamation with bpf:
>    LRU FILE:
> 	CPU COMM 	ShrinkActive(us) ShrinkInactive(us)  Reclaim(page)
> 	7   kswapd0	 	26		51		32
> 	7   kswapd0		52		47		13
>    SLAB:
> 	CPU COMM 		OBJ_NAME		Count_Dur(us) Freeable(page) Scan_Dur(us) Reclaim(page)
> 	 1  kswapd0		super_cache_scan.cfi_jt     2		    341		   3225		128
> 	 7  kswapd0		super_cache_scan.cfi_jt     0		    2247	   8524		1024
> 	 7  kswapd0	        super_cache_scan.cfi_jt     2367	    0		   0		0
> 
> For this, add the new tracer to shrink_active_list/shrink_inactive_list
> and shrinker->count_objects().
> 
> Changes:
> v6: * Add Reviewed-by from Steven Rostedt.
> v5: * Use 'DECLARE_EVENT_CLASS(mm_vmscan_lru_shrink_start_template' to
> replace 'RACE_EVENT(mm_vmscan_lru_shrink_inactive/active_start'
>      * Add the explanation for adding new shrink lru events into 'mm: vmscan: add new event to trace shrink lru'
> v4: Add Reviewed-by and Changlog to every patch.
> v3: Swap the positions of 'nid' and 'freeable' to prevent the hole in the trace event.
> v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the same time to fix build error.
> 
> cuibixuan (2):
>    mm: shrinker: add new event to trace shrink count
>    mm: vmscan: add new event to trace shrink lru
> 
>   include/trace/events/vmscan.h | 80 ++++++++++++++++++++++++++++++++++-
>   mm/shrinker.c                 |  4 ++
>   mm/vmscan.c                   | 11 +++--
>   3 files changed, 90 insertions(+), 5 deletions(-)
> 

