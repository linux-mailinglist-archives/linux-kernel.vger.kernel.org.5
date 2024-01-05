Return-Path: <linux-kernel+bounces-17392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E2824C9B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFBB1C2206C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671B346B8;
	Fri,  5 Jan 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="n4td7H2Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E14410;
	Fri,  5 Jan 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKGSKaTzJQ7UaK+C4+SQ/dvyubegaZ1eZlQzLwbTZOsNHp5aXnChenMIFR0Hnjy1wZbC00GLVU5kdWKrY0GqqC167VzJGZImI/DSsPdeX0Q5QnIEubAJOG+lfXVKk0SlwmIm1eswe5kxvQWT2J+ryFsKxPwMNG+3VKb35RB/zJWvwySaKwL/hv3gKk9zaZYG6zBZ2QdFcSI/AnJnti9gjRmxZgO1WMdwlVB+x7jX3N212WwdQMm8e7LWD/MwIqvAszURDyvUXXKemK8afuk47jVfI/BpdDn3CQlgHjGgILpSoplDNXVmOgqd4HZwZn2uPf08T01CvcqLPnQ48dvSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv17LkrivSbMKVXvFYW7632InhHiYYKYFcGfDylGxBg=;
 b=hh+UABoMpkdxUtH5SR+MqOm+p/IUV1X65s6r2c52Ht9w8BQNLYZLumTgXP+i+O3juRkUubiLuBoU62RMX5tGthaqIT1pX2Tg1X2ZZomW/ygVNnxP2ttvlNKv6YsE8sN7qljy63SWhjcexSsELyLFBckkZDv8Na/phWXOcVyqbsdukBtCxQe4k6hopYL1Sd1End9VYksRuZ3WCg2VnBo0r3Nv7ZbQ+dD/vXCvk8W1NZ/Lg3agaGsGKXfwWYY8Ok1Y6mtAsahwQnm6J/DA5hE8CSwG+6sE7V9XjsAlqYg8dIMUgduQ71HX5AX/BSFCueFig1qQ2qJWQmxjLRyHpMQILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv17LkrivSbMKVXvFYW7632InhHiYYKYFcGfDylGxBg=;
 b=n4td7H2QtBtMLjRvFfPbVdO9b/3V9FilDiyrOYoLA4CMo9P0SGedqJ/5bpmiljnM9Cc85M9kaveHYXiz+Qn+Tilx6MaH/glnMvdI57ZS49fi3UdtxX0Gw4mPp9OyqCmv1ILki4f+npj3axMMVP1O3wZkH3ea9d6IurHm5poSygineLM2+dHJIJkYraVZI/3gcxbH6b6WCoAbyLP6G6Ryv8kKxsMl0hc4i6b6ByMOryqP1hQuhv7V+JwI5NqB/YHjAAoBbKHQ4gz7Az0cOz7cJUx8p8gHJ5qRkhMqq8MSfbjP5/Om2PWqDkTTIF0UiysuJ3ZhvYzVP6OzS09iSars8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by PSAPR06MB4488.apcprd06.prod.outlook.com (2603:1096:301:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 01:36:38 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 01:36:38 +0000
From: Bixuan Cui <cuibixuan@vivo.com>
To: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	opensource.kernel@vivo.com,
	cuibixuan@vivo.com
Subject: [PATCH -next v6 0/2] Make memory reclamation measurable
Date: Thu,  4 Jan 2024 17:36:05 -0800
Message-Id: <20240105013607.2868-1-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|PSAPR06MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dd43a1-8446-4bf8-12b9-08dc0d8ec296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S2G7T5/hzmF6Its9uwFFmtN4eF99mgqFqFOknE+FKev1SUQNhrY6BZi+YLKTDtfuWCvPy2v8RQbhRo+z1E8kccc6NTC/6GIYZbTG/NgVvc1I4sQTzT2/HW1uj+LDuqxNt3/pBOOtPmXdaLzZbsUFRdoJyeVHmGap2aNWR4YwZIfKLKPzYo/NEFYhF0lhu6Ckmaty3xgILglbjn2GvyiCKj41eB3TWNtYl4aJ6AxqAw0eUwbPvOgkjwGmEmIqtpbHyvn9djXyRMYb7DXDFFCA6emsvifaSm8I6emCkOEpZpYwgUXbVF+B4qjXi6Pv+YNUKBg2FpjXgvl1Q6WOlewQnXtcs8ELAy47V0AGxMuZNIHycDvqv7eC5e8I7aghP3xk9IG6Zx3km77OIhPl84T46N1iQ4OBo91AoP4aibWeRHwLbE8LyvjszpRqcsZC+iC/KngUc7pJHDs4u79QtKlaWexpk3A/pA/CanpxxpY6OKu1VqTcgBDEMiyyv6TswMaqghcqh+V8jvrtxgsSOwGkDh1+dOm6cEPsNrfg149eMk3SCuDTD5oOZai+pyDw/uc75c4a4FzVxrwmjxn3UshInOLZDJ7CfEQ9bup9I8COTwZqy0eHwpAzEglJW8zbYqrr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39850400004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(26005)(1076003)(6666004)(6486002)(478600001)(6512007)(6506007)(2616005)(83380400001)(107886003)(5660300002)(2906002)(41300700001)(66556008)(316002)(8676002)(8936002)(66476007)(4326008)(38350700005)(66946007)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xw+T4+Hn89dqWfIVB9lUf2hVB/UbQGbWjBsyApU4SoTCwWZP0Kz6nSVO1oSn?=
 =?us-ascii?Q?iTEE0/x3IIqPKXtOcd7mv0afCjO6bZlfA8ROaPXVNmZMREEgtgIRYJ1YmVyT?=
 =?us-ascii?Q?UuXxWpovsx4X8p4WkxNPBvv+QtEl190Y1jyKfQVL65iMMLzw62z23VJxwp0V?=
 =?us-ascii?Q?tsHWgcydbCJbqMxDd5rKyOMGTX6F5FHK/EwFygWzX7PM5uZsbRGb7eecbSJD?=
 =?us-ascii?Q?vo8dpQHpSDqq37QBrcWWli6ito4vE4trAlZJqfh5Q822zNoN4lPdIiuEk9N3?=
 =?us-ascii?Q?LOZLmeV53nymQcRTTqfFf9xeaEHAOiMNqnQYXWZlxSJki9Zi7CNHS9LHc4p1?=
 =?us-ascii?Q?g/g3YSd1tFgVYdT2r3THG5nHIJ9/uc+K24AkOEYwCBMqjiBbaXqArmRNrshu?=
 =?us-ascii?Q?s0vEqmWYn3xIpOlqtCsen2KKS3w+Dbf/9ypsl/bssh7dezbC/EiMyAKZD7Xn?=
 =?us-ascii?Q?m/w20AAEE0teApxclcfSwNHWoDMij/YNgcBKwTUofCsD4yivZbAJyRi0rCI9?=
 =?us-ascii?Q?JuswVTcN5NBcWLH5+ykMmha6CLUglyul+cnqHdiFd9DipKKHkH+Tt9tlvEsC?=
 =?us-ascii?Q?mCgFPxxeYu8+ahwfYnfY9YoIgVcq5vWoqmtQ6cIzkEgn+nY8X9imGJx5io0Y?=
 =?us-ascii?Q?mGk9ZLl5vCtPzQomRH84AFUmeLiMHSvF+f1LMOhBhMNJR0XUjD/g6Tm3jAGg?=
 =?us-ascii?Q?UUZ/jkCHH/HXzOVs8ATIVUPaqUqoeQtNcMlpgskvdkrcd63yCtygBss3exon?=
 =?us-ascii?Q?sxJnkzTDU1GKTYZmvfgBcx14RACeSoZZWQA9sY3Q/JLq1oNR674W/0K1gVTl?=
 =?us-ascii?Q?S2QMMEGN6uRBgxAzv9Kmy0H2tK4in5MWmkmNCCaWMks6Q+SgmCEU40x6DG59?=
 =?us-ascii?Q?yslstJKfqpRS+BGkCA33HoiY2JUSFBux7z5jvF2qpw25FC9oYC3wXVYDAJ4N?=
 =?us-ascii?Q?SmPuHvka3v8aenMfE/RItmcWKZfHBrYjNVWw3bK2g4Uv08XSk2+LppTXw7gF?=
 =?us-ascii?Q?bkX70uoWFHTRBOqPok0M2OjUsxqTqKeWfTyPSkAch+fEyVYBU3bLsCZBRNHA?=
 =?us-ascii?Q?miKwNl2SCPYsRYpUqUuxjTbA0B7M9fJogLGio+YicGR/qtkTC//AFfnXzFmj?=
 =?us-ascii?Q?UFqosq3ZTcGMchf4tvQcKfVAT9sSweyqk0BYmTOycMx192qyZ7XZd0+5xojj?=
 =?us-ascii?Q?IAumHiENRcYD87pfDtJxQgVj+fn3gOeb09IySFHBARtIfGq72liKsmEtvtsS?=
 =?us-ascii?Q?tY+NHDZ90yF1/iWvha+zlckr5rGH3C2E6ozjcyO1+lklhn1eRBDVB3CkoYAx?=
 =?us-ascii?Q?yj6vT15BJGG2Z3pALgvsixzhGsw6sq4QFRtg77QDft5QNrzIFQ81hVoaOiJW?=
 =?us-ascii?Q?ZH/frAf0He8RFEnravDTjOWPZRzoagCUJFTSsHtCEFbeqTtzgXFqbr4wysxz?=
 =?us-ascii?Q?gQrXpgJnz5p/4VW8zhwrYvtLU6Bi/BXQBYZSSGFJkUhShKB81BnU6yhRC9vh?=
 =?us-ascii?Q?rS2xWK5m4fKB4xCkrIwMoUDLRJzG9KyKi/zUPGh66DlxVZlxozrx/IMY5fsZ?=
 =?us-ascii?Q?7LRx/rqDktTQ2c02F7npGsFIyBnedr3m2wN6w5HW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dd43a1-8446-4bf8-12b9-08dc0d8ec296
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 01:36:38.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR38NH3sxgiXuFqPCwNLnW2QP6xQ2QiKFZOd56lBDimiCEzNGox5nj+CPZt4tuoC9geS7A8ers0PM6NMYgabtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4488

When the system memory is low, kswapd reclaims the memory. The key steps
of memory reclamation include
1.shrink_lruvec
  * shrink_active_list, moves folios from the active LRU to the inactive LRU
  * shrink_inactive_list, shrink lru from inactive LRU list
2.shrink_slab
  * shrinker->count_objects(), calculates the freeable memory
  * shrinker->scan_objects(), reclaims the slab memory

The existing tracers in the vmscan are as follows:

--do_try_to_free_pages
--shrink_zones
--trace_mm_vmscan_node_reclaim_begin (tracer)
--shrink_node
--shrink_node_memcgs
  --trace_mm_vmscan_memcg_shrink_begin (tracer)
  --shrink_lruvec
    --shrink_list
      --shrink_active_list
	  --trace_mm_vmscan_lru_shrink_active (tracer)
      --shrink_inactive_list
	  --trace_mm_vmscan_lru_shrink_inactive (tracer)
    --shrink_active_list
  --shrink_slab
    --do_shrink_slab
    --shrinker->count_objects()
    --trace_mm_shrink_slab_start (tracer)
    --shrinker->scan_objects()
    --trace_mm_shrink_slab_end (tracer)
  --trace_mm_vmscan_memcg_shrink_end (tracer)
--trace_mm_vmscan_node_reclaim_end (tracer)

If we get the duration and quantity of shrink lru and slab,
then we can measure the memory recycling, as follows

Measuring memory reclamation with bpf:
  LRU FILE:
	CPU COMM 	ShrinkActive(us) ShrinkInactive(us)  Reclaim(page)
	7   kswapd0	 	26		51		32
	7   kswapd0		52		47		13
  SLAB:
	CPU COMM 		OBJ_NAME		Count_Dur(us) Freeable(page) Scan_Dur(us) Reclaim(page)
	 1  kswapd0		super_cache_scan.cfi_jt     2		    341		   3225		128
	 7  kswapd0		super_cache_scan.cfi_jt     0		    2247	   8524		1024
	 7  kswapd0	        super_cache_scan.cfi_jt     2367	    0		   0		0

For this, add the new tracer to shrink_active_list/shrink_inactive_list
and shrinker->count_objects().

Changes:
v6: * Add Reviewed-by from Steven Rostedt.
v5: * Use 'DECLARE_EVENT_CLASS(mm_vmscan_lru_shrink_start_template' to
replace 'RACE_EVENT(mm_vmscan_lru_shrink_inactive/active_start'
    * Add the explanation for adding new shrink lru events into 'mm: vmscan: add new event to trace shrink lru'
v4: Add Reviewed-by and Changlog to every patch.
v3: Swap the positions of 'nid' and 'freeable' to prevent the hole in the trace event.
v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the same time to fix build error.

cuibixuan (2):
  mm: shrinker: add new event to trace shrink count
  mm: vmscan: add new event to trace shrink lru

 include/trace/events/vmscan.h | 80 ++++++++++++++++++++++++++++++++++-
 mm/shrinker.c                 |  4 ++
 mm/vmscan.c                   | 11 +++--
 3 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.17.1


