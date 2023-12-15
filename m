Return-Path: <linux-kernel+bounces-305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09828813EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA1D28352E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A02574;
	Fri, 15 Dec 2023 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mmpV/YHF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594723C8;
	Fri, 15 Dec 2023 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN2MuLUbTpgKX2APw0SvzD+tAcxY99otGGpjuAgd0N+U0VJoGC9/x8130pkqICuzhphMVrQy2ZrAieiU50QiDh5b2+e8Sv1voIa8u3l2zRDnsorbLC8BeaaN+yg+f/S50kZ8nRRtbPGS6bjZDvfJffJ2gGirL0jIb3/lXStnLisre8dPlzv59ujRVAPRqNtYMMmv47tZlP/FgfS09spmEOYFE/fch/DGpcdGTFfFAjKkut48XHsPE8irr4Sm2gHTyyqStTf4rs5F2auuqfbQ5kgLDW9/SqC4L8eJoLXg9Zqyycq+Hdi3HeahGvQznoMdHJzlG+9E5cAeEjPwlsggsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gmM6+v950jpmuPBvHMdT6x5oBVNbU04d9a0JnadkLI=;
 b=K3J2SIbtM5RW3D/kcvf26XX67n6HM+XCzBQReyyL/y40wbNkMrItGSjjiQ8ZXQgT/2KQfamcQLQAzCZveqzIsp3aSHz5VGpEwo/hrMjnt7u7MRpP4ubEPDDzOATppW+k+trQdtuZzynFdHKjGFtTa0PaSheEdAW+rKipAYRNUW2DkwlXmcPFqtfWIBVcvWdXN+VZRzsB0vLplMni0hxx2Ct5kCdtSUCHW83d2x+dM0370bnU2xSPkgv7fEA0bTY/EJChTnoCShnvhkCaRQCkjC2cMGQRT8WGzsa01PpZRoMTCQ7Pc9sGCN1v7bbwaeD6Zt6L/4D5UESbEoN5mNTpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gmM6+v950jpmuPBvHMdT6x5oBVNbU04d9a0JnadkLI=;
 b=mmpV/YHFYUJ7P8ijr4IRk1wtE5xPDVGbzoFVdTVI5+Ri6uWgPFwx4N1cujrbtMpOAIpS4maRiRu6uJRdqlVp5FGwhMVpoWmu1ca+xUakD/MyIFhOJSunVFtaL5cMcYQSDGJv9ZQVfXJmRFdViizLEp8OEMIDuE57Om/mPL2V6Gmy2IhcczteBCedXuY67TCvaORREt1FCGR6HpXcIbkKaOwLnHaghi1mqORd7JduXBfuUqhoNNgrrpEOlgJ4qSBZJIoyoUBzqYStwsvzMP5Jhku4AxjHqQCoNVqPv4Lg5OQEWU6MpEw86iZex2YQjOFdGrXWhC7SE7pGHKFVZ3unew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by OS8PR06MB7440.apcprd06.prod.outlook.com (2603:1096:604:288::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 01:06:09 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 01:06:09 +0000
Message-ID: <87132478-5dfd-4cde-820d-83427c18f4d1@vivo.com>
Date: Fri, 15 Dec 2023 09:06:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 2/2] mm: vmscan: add new event to trace shrink
 lru
To: Yu Zhao <yuzhao@google.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 opensource.kernel@vivo.com, Linux-MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <20231214013450.5734-1-cuibixuan@vivo.com>
 <20231214013450.5734-3-cuibixuan@vivo.com>
 <CAOUHufZXX9M=sTkqxy=Pf2c298w7ha-SzF+1g9_HWcNkLVM9oA@mail.gmail.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <CAOUHufZXX9M=sTkqxy=Pf2c298w7ha-SzF+1g9_HWcNkLVM9oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:404:56::22) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|OS8PR06MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4cac6e-0124-452a-1bc4-08dbfd0a05ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R305V7QqNDMYzI05Mtpg7HHXfpRZ8rYA1DAdZ0SpUlkVQXjIWF1prztl/2dg7bPxNrFwmgQVaGlD+NEPpjk0Q/rAc31c329kdHTnSHhKTMWCxniyuezw9MNBGAEUGfRpjJBeG8AvukGJBV6SqarOAHJ7m1TaYIpz/8CyaAgY7kFMkY6Zf1F7WaqX27ENd7BzUL62Zponad4XSHwsxZGJ+k5cslV3Auu9bZ06mJtv02Ze2+pDOu96QC2Ypfzw9MnXwDHDrl2TD7TlXehGdWKg0DnHufyPeQbjuPkHJQJKpHfAZMtzFpLAherP+r8B7KzY3HoxWEcowRcORMGLuOHRpsKNX/AaZ7uFG5nP5JEIvFoa/imskGPG5f7gsE4M96mDlqNxuC11/86m4qTy5sDHh7ALqup5N45I1eNZ+B0WTXo2PuAV7JisTXVGzVGXuSktGWYEO+IdhvQy5x2Hs6voxz0xU/xr/fHbRdYvJH1ObCYzwCTX8J3FFhAWFA987waJcmvAWhC7l9L8gel9KLnVqjh1/WUiXqRfrO2t1SSLyVG0rhG9GnGG3z1trrlP2ti+8rB+jUafFvXASVSdqmnfAVpx1bsHZibcHdoHt7gRQjdFd08UB30bJOR2Jl1uRMbGfS1YWlkh/nB5iZPTxrDW1QdbBCa3XdJcAXY3Xt+3I44qWSScdhZrRxKAjF2b2Tec
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66476007)(66946007)(66556008)(6916009)(478600001)(316002)(31686004)(86362001)(31696002)(5660300002)(4326008)(40140700001)(6486002)(8936002)(8676002)(38100700002)(2906002)(52116002)(6506007)(6512007)(2616005)(36756003)(83380400001)(38350700005)(41300700001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpRTGI3SjhaYzFUVkZtcVJWNEpFMThkaVQreWRLK2NQenFBekd0dUU5RlBM?=
 =?utf-8?B?RnlQcHZQVHZJQWRIeGFtTFJmSWZ0V3k0MmYxK3d4bDd6S3hDdE5meDYyNElj?=
 =?utf-8?B?dVNqNUVmUHJRNi9GT0RlQTV5Rm5sRklGQzlYT1RoNnk3bHFoK2lpUFpPdjJS?=
 =?utf-8?B?VkRFVjZEU3dFU2QxMEU1YW8rbzhHb0RGWU41RUdscjR4VTZrdE83aEs3NTBp?=
 =?utf-8?B?M1Y5UHFSSU9sY1AzeW51MHRyeis5elEvWXN3U3EyMlNCZEhhaVN0Y0pMbVFq?=
 =?utf-8?B?b0JQczZ6aFFpYzJKNXlKd1NiL041S1dhRWxOUjhFd1pHU3laVFl0NnkvWnYv?=
 =?utf-8?B?cmJLcjhpOS9pc2FTRThmemIyOHFjd0FhMnZFS2NBRVZnTTdMUlUzQ1I1cUpR?=
 =?utf-8?B?QlRvUVkwQk9tRmY1cXExbnhLK0o2RDdQNE55R0pJWHplWlM0V0tFVHFUKy80?=
 =?utf-8?B?QTEwUjFOSUNuNDc1cWxBZ0lKQ2ZZTHZPc3JWaUU4b3ZpRkNmbjNLMTFMbXpZ?=
 =?utf-8?B?Qmdkb2wzZTVnbHQwbUJqWGFiOUhwcTNqZHJYU2NSemJiZjNvWGJRV3VMN3l0?=
 =?utf-8?B?MnhwOURQeWFtNFlIVG9kZ2F6SXZHVmNnNXJPbm9uamNKVEE2U1Zna3FDNWcv?=
 =?utf-8?B?THMyUWF5d2FHNVlVSFRmdThHWjN2a2ZFVVR2VUhyQzQwKzVrMTVocVNmUnhs?=
 =?utf-8?B?V0RIN01nT2hVcXZiV3Y3MGpZNnFVZ254V1lMcnFEUFMvQkxNeEVoWnFEN3Rn?=
 =?utf-8?B?b1pGU2U4d3gxRyt5YWNwYmZPdmdFVVJWdmcvUjZjcWxjYXZIcmlHb0tXeG14?=
 =?utf-8?B?aXJiYmM0dDZiaWthclp6QlJxeHJUT3dnc2VGUGJGc1lrcytYYXZJcUYwbUhx?=
 =?utf-8?B?T1lKdlV1c1ZwY3ltSUNpb1hIandTRE1PTmVpQU9IVCtLMllNZS82K0NhOFht?=
 =?utf-8?B?OVI1Y0dRcTdJN1Qzcll6WDVvZlZKRzZGMFlJUTFNOEtrczZnMHVhSmtxY2xZ?=
 =?utf-8?B?RnJCcjZVK292UkhCVlJQM3N5WmJxMnJKd0orQ3VzQlRHM1Q3OE1tamljbWxE?=
 =?utf-8?B?TWFhWUdPVVNTckZCTUdKeTBRQjRJWUNUenVVNk5ZN3BFd0tqRE5uUFZUUGJW?=
 =?utf-8?B?QUMzUGJGUUNGU2tEQjdEZVRxa1FhRHk4OUFJK0tlS0Y0RlFlQU5xc0NWRnd2?=
 =?utf-8?B?YzhLL016SmZDenBxaTFKZmttZm5iL0pWNGlyTFpTL3ZzVmRVMmxKb0kxSkVs?=
 =?utf-8?B?eXZid2NReFJtNDFqNlpJYTBzNmQzZUtzZmRuWHZNZGhvZHRlRE1FY0RzNGtP?=
 =?utf-8?B?Q2RYU3NPMUd4ek0xRGxBQkg2cS8vOU5oRVhLMWFKM0plSitRQ0l6bm9vYVJI?=
 =?utf-8?B?b2xQNUM0QzJkZU90Q0tDbHY0Z2VBZVFwVUJGdEhJcGJUQXBCZmZaSnBESy8v?=
 =?utf-8?B?N0pCRG92UGZkOXdtTSt1dU41SHdQUHUvUEc5TEx5Z21ab2hvM3lYYWFvTkVI?=
 =?utf-8?B?Y3R5MlVGaFAwNktSQkMzSzNVSy9tcVFyVThpbmZ3ZktTMi9ydVgvR1ZvYmNk?=
 =?utf-8?B?MGk1QWRPd2F5MWJXN1hBYk45VnZCVHdhclFya2hYbHI5cWtyaUJSZW1xTUg0?=
 =?utf-8?B?eTIzMkJzclVySi9aSExJeWFRWEd5K2I0Z1l4M0xLcVFyeFdTYjRhcnZuck9L?=
 =?utf-8?B?NERUS1BLQWNSeVZRd3hNRHloR3NQRjh0OWdIVU5ocmxxa3FFV3V1SHVzTHBF?=
 =?utf-8?B?c2ZxVUEzemtYeUREeU1tb0Z0Qk1vQ2ZYV3p5azB0bDVOZG5ZM2FrYXFXYmZT?=
 =?utf-8?B?T3pjSWNtOTVzUDA3VEhFaFpKeWJUS2QrTndHOXgrV2crYXpWTytuY1JRSGhV?=
 =?utf-8?B?RElVVUVFUDJZWXJaWlVJK1dDeVdZanhGbU5EbWc5OUwzSWlzM1VyWU00U2tR?=
 =?utf-8?B?QmRoSk1yb2NCM0pEeHFOWWF5eHJWbEJHS01Jc205YXY4eEkvRFg4bmFaMW4y?=
 =?utf-8?B?NEhHQmhac3UyczBidkVQUDh2N0Y5Q2pjL1dUbEZKclZZbnR2VDR5NzV0V1dh?=
 =?utf-8?B?YVRKZWJSU0Z5R20wcHhpbmJLTk1ZOWdrMUZ3akJQdFUzNXBML2xOU2xJOWJX?=
 =?utf-8?Q?Y/BckxBCjoZ7JIubDsLiLny2j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4cac6e-0124-452a-1bc4-08dbfd0a05ed
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 01:06:09.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBLnkO6vdb29CY/U9ndKXsrH3cyTSmvO5m8FGix6U62herjmDMuUTrl1oiAJiFfvKF9L4rotGxVRzsVfF9t3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7440



在 2023/12/14 11:59, Yu Zhao 写道:
>> Example of output:
>>           kswapd0-103     [007] .....  1098.353020: mm_vmscan_lru_shrink_active_start: nid=0
>>           kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_active_end: nid=0 nr_taken=32 nr_active=0 nr_deactivated=32 nr_referenced=0 priority=6 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>           kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_inactive_start: nid=0
>>           kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_inactive_end: nid=0 nr_scanned=32 nr_reclaimed=0 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=32 nr_unmap_fail=0 priority=6 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
>>           kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_inactive_start: nid=0
>>           kswapd0-103     [007] .....  1098.353162: mm_vmscan_lru_shrink_inactive_end: nid=0 nr_scanned=32 nr_reclaimed=21 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=11 nr_unmap_fail=0 priority=6 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>
>> Signed-off-by: Bixuan Cui<cuibixuan@vivo.com>
> NAK.
> 
> A _start should always be paired with an _end unless there is a good
> reason not to.
Yes, I want to get the duration of shrink lru and slab (including 
shrink_active_list()/shrink_inactive_list()/shrinker->count_objects()/shrinker->scan_objects()),and 
then calculate the memory recycling rate.

> 
> mm-commits@ is the wrong mailing list to submit MM patches.
Thanks for reminding.

> 
> Is the build error Andrew pointed out earlier fixed? If so, where is
> it credited to him?
Build error has been fixed in v2 patch, changes log:
v3: Swap the positions of 'nid' and 'freeable' to prevent the hole in 
the trace event.
v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at 
the same time.

Thanks
Bixuan Cui



