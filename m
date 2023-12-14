Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB58125BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjLNDFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjLNDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:05:05 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA55E8;
        Wed, 13 Dec 2023 19:05:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATumBCnFeDFOJ3n5FEmcYyG/Let0mRqWL1gg7xr81ZhqH6ilOKE45HBsTxBnx93GF/xZpAnlLuMzae455yKL1TjRo4+dFrDkqjF/G9ziOydAW3C3usNgPeZgDAiu0ogzJy5PrSx9o3hHNp5U8JzCFDsgDKFHipyAF+UUQEIXBqL+S+0Wg2NO5vjCtzL+v/rbTO23846osEiOEiYPrE3wyV7ha0Gm2qzZsQqGKyIaQDy9N3j7FBhdnzk8jf7+acPCA2c6CGKZtZGt8ll73FtS2FacxHctQx8kW59gY+zUGA0kQAitVh2Cn8PTaHbU7QnATTnHxU7uhvKm9OQpO0ctnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgdaCQ7EKTOvAUq7gimLcK2ftH/Xn7Bv3xJ74fCGlUs=;
 b=ebjt2f7Y5ZWBSr06P40qfCTyq7kMnah2ZPHpvF8qUZ1p0WW4jIewPd6tKnyc6uaamZnCAlTbzPcnPXWjF0UjsaqjGZE9IR79ffgcAvsb6iWsc+1vH6kotN60G+R1m1bUbuorpezQaHBeYsfw+vLQ9LPrRinTTueWUWbKrE38BwfwIZcd5rrsN7D1bH6D0lhA0Cse9iy0ayloPijsmH9bTSfZUVEBzaMD4F6LEbw9oI/5ALC8MwnDLCvYi7fWEHk21Qa2aDMcF0RLe3uODxeGKuCjj3zGrThK6KHt2Ch79qDMYtmjPfpBNlmSGr8Y3B3h+U1WEEPljB1pa4slQEchrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgdaCQ7EKTOvAUq7gimLcK2ftH/Xn7Bv3xJ74fCGlUs=;
 b=FIUlvtU+/Cn/71/+j90xRL+FMuyNvThG/orLcc8+CrYlkyjhsRYIywtBL9QZ/krkQaYS0sO8Ikogt4Of1Df67FiLp+BKddqKaOs7UTXlvdSpu6nX9t8E0lMAQflXW25/tPU4MZWzjRlDtvgdBPfWqXhyjr7cSUXZxUh5m0aWvefDuHY+I9S2maXQNeLoDMcrg5W37nJ7xy8RLFdmCqnCHszjLkoc7mKdt3eYEbQ7FcWAvjpyeUpFwyYj/iqBjH6XmN49k7w8siZ09WXRuzhp4RULhlG8c6t7Y5oUBIQrIJNZXVzkRT5pJ0AA96AznK206b1mpFbFfOc7jV4cn16CyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYSPR06MB6608.apcprd06.prod.outlook.com (2603:1096:400:477::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.27; Thu, 14 Dec
 2023 03:05:05 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%7]) with mapi id 15.20.7091.022; Thu, 14 Dec 2023
 03:05:04 +0000
Message-ID: <024c755b-2957-40eb-b8aa-a69236ef512f@vivo.com>
Date:   Thu, 14 Dec 2023 11:05:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 2/2] mm: vmscan: add new event to trace shrink
 lru
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mm-commits@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc:     opensource.kernel@vivo.com, cuibixuan@vivo.com
References: <20231214013450.5734-1-cuibixuan@vivo.com>
 <20231214013450.5734-3-cuibixuan@vivo.com>
From:   Huan Yang <11133793@vivo.com>
In-Reply-To: <20231214013450.5734-3-cuibixuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYSPR06MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: a03678ab-b94d-4a79-62d0-08dbfc517855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RV/leL+gN/uI6bV89HL7PS5IEzoWlswDCMuVcrWRKnXrUdSk4U67SToY6Q+ZefaQHgi8BmsoN1Rv28t0ffpyuMsu+wKDiprOEBjdTTuJfEz8m9+om/Tka7ORL/I6TtALMqT5iEiFSeUx/YkBuu/BqP78Dibi6d25btGCoZ7344XduEg2Rzf1N472WPgXOSej9ay9Wqt4Q4aSC0/ohE40Tc1euTh8S1gXZ+QDmgkseeMnpUEAjZaBb7Bq/36QXvQUsZm9KN4YIVBqg3aVNR6hRJNicI0ijDC4rOXtM5kk4Qbp9k2Pm/qTykk8wmoFcLvmeOUEIJmttoay8gf8DwGreaDLzjZ9b+e/OT3qay2Pa8klk1Nqfmnfp5nw903CZQEUkSqJqyNXoTDZVSiMsbhc2nsHDfGhUMZdpCpqXvPQGWVmTcrB0wm0L0P3QASaQa8ImEjMdFCZdZCoMbNoNfiTAFPEwRIXp8AECqXH8788rR0n1mm9E2EUMZBwGGFm+wAu4KForUB0gRMOTqmj6DDTxYc4d3RSMahwp0QbX53ZyhCCSMuNhV3F1j66wBJsAWG+y8NP1e7iy6NRAbeYDq1z0T4bZdLDdRP7iaUmKDvoKI4VH0cdXu4st9dVJhq9ztfUlvgh+YVYBuN5I56RnUVpbNICPSEdh9gQjwBfEi1B5/vTGm3gxpgfgHpE1fSCIIETyLB66adng0PGfHnC/4j4H4RibVa8/B5uHTmQON/UHjn2ffQZxlnC7pstuVD98zfx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66476007)(66946007)(66556008)(38350700005)(36756003)(40140700001)(31696002)(38100700002)(83380400001)(107886003)(4326008)(26005)(6512007)(2616005)(52116002)(6506007)(6486002)(966005)(2906002)(316002)(6666004)(478600001)(5660300002)(8676002)(41300700001)(8936002)(81742002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzNyUVluNUJKUWxkOVQ5VDhSZUlqeWRibk1uZ0grbXpPbWR0U1lNS1RkY2hN?=
 =?utf-8?B?ZUI0cFhQT2lLZU5idWtjbWUxL0NBQjUxK1FjSEhwWlI0bjkzZ01naElzZkJu?=
 =?utf-8?B?MWd4bWJVZ3dGQzlWajlIVnZyYkdtTmxzYVE3Q2xQQ0xScWFya3A0RkF4RmhP?=
 =?utf-8?B?R1J2elVJYXNnYXJnNnBuVFRVNjZpenlxRkxqTEM5YUo3aUFrR1Nhblh0cjN2?=
 =?utf-8?B?cVJDL0thSXNQOE50TTFkMFd6MWtkWmVrbmhxNHhHRkVxUnYvdDZoanhLNVB5?=
 =?utf-8?B?UHlpUVJUclJLbjB5RkUwc3BpNERRRSs5cnlFa3AyekNQWURWc0R2RmNPVldo?=
 =?utf-8?B?L0R5N2hEVWRXZmVlZHFkcGlldjlWdjdWbG5wcWU0aDlaRE1YcGJHQ3UxY2hk?=
 =?utf-8?B?NStpRGg2YXdGWmxIT2c5QWxUNzdrNHBsS0M0eURhaEpIeDhWemhVdGkvTm8w?=
 =?utf-8?B?ZXNWc2tpQ0pUM2luVk1zVW81RlZ2TmJPSjFpSHNaOHY1SW8xTWJ4K3grOHZr?=
 =?utf-8?B?dWpkSlJQTHYzODQ0R2Z1VzdzeDhJQlM5SXJ6QnpqTzlVWURyclZGcTdhdFJ2?=
 =?utf-8?B?VXVmUWRIT0RPdDdKem0rNE4vaFdzY1hYV3JUdTZ2UDlFb0MyNXJqUmVETE5k?=
 =?utf-8?B?cWFOVXdaODFhalNISWdYcDNNdy9BWjJyeUlRRTFZeUNhSGpqMW1JQVQxbEpx?=
 =?utf-8?B?YTJ4Z0RNYms0bHRFaDZiNXl2WUZna3BqeFVBRWg0TFVuMUtkaGt4RXdQSVFy?=
 =?utf-8?B?eTA4WE9mdXNnRnhtT2tkOHhGMVNCYmFHWVFudG9GeDdzRlhFUE9Ka3F6amFP?=
 =?utf-8?B?azRJaGZ5WC8rTEFwOHlDTXh2QXcraktCaFhNRWxzOE9iRGtybnRzYmxWSlNp?=
 =?utf-8?B?NEJZVkFFczRQalRnSkp5T1ZhcXZUa2VCTlg1eG5CZkkzMmxkVWR6YnVzQXVw?=
 =?utf-8?B?V2c4RWJpZ2lldTdLWTFlaytyWkFNdDVBVzQ4QUJxR0cvUVBsOVFMRUVrRFMv?=
 =?utf-8?B?ckZ6WUlqUmwwZmZSNkVRTzdvZzV1VThwMVkxcjNVYVpYa1lYS004SkRhaHds?=
 =?utf-8?B?OWRhNnh1Y2JLQlR0bkFmS2NUVWE4eXRadjNPSlArL0l6WHBEMkNxM244OXA4?=
 =?utf-8?B?YTFrZ0FQRjdjcjZITm5OTG0xVUt4VFRZZHdhV25udGFqSjFkY0dMK3VwUVpZ?=
 =?utf-8?B?QjQ3c1JVQm9pNEhHbDBQQWN0MmVVRW1MT0srR0xTZVBwWWwrWDNjRjFRTkNJ?=
 =?utf-8?B?R1NZQ3I2YzE2dlJ4azNJYzF0eVBmSHAxZ2FRWWR6R2huOTc5dWtLREVjQ05t?=
 =?utf-8?B?dDdCT2MzUHBYOVE1MTdydnFMT0pxRDgvWGpNV3hQUU5haG1lME9uWVFUM3pK?=
 =?utf-8?B?bktQeXBvYlFwaGRUbGlIS29pbW5iTGZOTmhPYjJxSHdNUkVEb2tWS2pPUDlO?=
 =?utf-8?B?S1grV01VaGQ0NXpjNTRqOStLZGFrRExDaW1xeEttclNhVThZYWhVbDJiUktE?=
 =?utf-8?B?VlhXWi9HRndWKzJEZ2x6cThYaFg3Z3BnclEvVUh3UHpzNXNUTzAvSzRjVWVB?=
 =?utf-8?B?alJ2a1F5dzFTdnZBZmJoK3VxUEVPY1ZROE1ibmc0SUNUVDNMWGNRbzQzN2J4?=
 =?utf-8?B?cGpaYnZIR1gzUjB4WUNNMlcwVENGV091MFFjRm5vL0hBT1A5RkRyZktxL3h5?=
 =?utf-8?B?NFd5bVhWYUVTNVJ4ZjhqUTBQTGFSd3RPbXh2cXJON3pmT01mVlU0WklXcm5q?=
 =?utf-8?B?cGRwVlhmSmhCejkwVSt5UGJwb1JtZHdNMXg3MVJPck1aM2RWMEtjZ0xaVzRw?=
 =?utf-8?B?bm1HQjNTQmZXWnMyVHZYQXRidFp6RmFKSXp0K0xFMW9sRE9ZTjFITGI5d0pX?=
 =?utf-8?B?UE5HMFVJUys2czNOS0xyTGw5VEFyblM0Q3JiOExoWXZvS2tadEJ0ZHZYV1dh?=
 =?utf-8?B?alZvMVlCR1R0bnNPL1JZZzR6RnA4VW9ON2dQUWhjc0ZSak0zcm5QR0lLSUNl?=
 =?utf-8?B?ZVJZMmd0S1I1TU5YdDkrYW14U1FxdEV5djNqNmovQUErWUdvOVJXd3ozeXdL?=
 =?utf-8?B?R3ZRcGE4cVF4ZW9ySEpGeUFVc0x2cXNrVWNydlJGcm5KTEZScU8rbjF0aXpK?=
 =?utf-8?Q?veO5VhBxKsh/6Kmi3kYjTWdmt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03678ab-b94d-4a79-62d0-08dbfc517855
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 03:05:04.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smmQVK5szfG/dl4SP0uL4FrKatEm2jx4ZZdS1N1k0EiJBkDM/PnXDAZ3VYfFk3Z1QPM05e8vUR4TgKQkqmGQzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/12/14 9:34, Bixuan Cui 写道:
> [Some people who received this message don't often get email from cuibixuan@vivo.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: cuibixuan <cuibixuan@vivo.com>
>
> Add a new event to calculate the shrink_inactive_list()/shrink_active_list()
> execution time.
>
> Example of output:
>           kswapd0-103     [007] .....  1098.353020: mm_vmscan_lru_shrink_active_start: nid=0
>           kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_active_end: nid=0 nr_taken=32 nr_active=0 nr_deactivated=32 nr_referenced=0 priority=6 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>           kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_inactive_start: nid=0
>           kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_inactive_end: nid=0 nr_scanned=32 nr_reclaimed=0 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=32 nr_unmap_fail=0 priority=6 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
>           kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_inactive_start: nid=0
>           kswapd0-103     [007] .....  1098.353162: mm_vmscan_lru_shrink_inactive_end: nid=0 nr_scanned=32 nr_reclaimed=21 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=11 nr_unmap_fail=0 priority=6 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>
> Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
> ---
>   include/trace/events/vmscan.h | 38 +++++++++++++++++++++++++++++++++--
>   mm/vmscan.c                   | 11 +++++++---
>   2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index b99cd28c9815..02868bdc5999 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -395,7 +395,24 @@ TRACE_EVENT(mm_vmscan_write_folio,
>                  show_reclaim_flags(__entry->reclaim_flags))
>   );
>
> -TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
> +TRACE_EVENT(mm_vmscan_lru_shrink_inactive_start,
> +
> +       TP_PROTO(int nid),
> +
> +       TP_ARGS(nid),
> +
> +       TP_STRUCT__entry(
> +               __field(int, nid)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->nid = nid;
> +       ),
> +
> +       TP_printk("nid=%d", __entry->nid)
> +);
> +
> +TRACE_EVENT(mm_vmscan_lru_shrink_inactive_end,
>
>          TP_PROTO(int nid,
>                  unsigned long nr_scanned, unsigned long nr_reclaimed,
> @@ -446,7 +463,24 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>                  show_reclaim_flags(__entry->reclaim_flags))
>   );
>
> -TRACE_EVENT(mm_vmscan_lru_shrink_active,
> +TRACE_EVENT(mm_vmscan_lru_shrink_active_start,
> +
> +       TP_PROTO(int nid),
> +
> +       TP_ARGS(nid),
> +
> +       TP_STRUCT__entry(
> +               __field(int, nid)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->nid = nid;
> +       ),
> +
> +       TP_printk("nid=%d", __entry->nid)
> +);
> +
> +TRACE_EVENT(mm_vmscan_lru_shrink_active_end,
>
>          TP_PROTO(int nid, unsigned long nr_taken,
>                  unsigned long nr_active, unsigned long nr_deactivated,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4e3b835c6b4a..a44d9624d60f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1906,6 +1906,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>          struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>          bool stalled = false;
>
> +       trace_mm_vmscan_lru_shrink_inactive_start(pgdat->node_id);

Can here add memcg id into shrink trace?

If so, we can attach this trace and collect shrink info into both NODE 
and each MEMCG.

> +
>          while (unlikely(too_many_isolated(pgdat, file, sc))) {
>                  if (stalled)
>                          return 0;
> @@ -1990,7 +1992,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>          if (file)
>                  sc->nr.file_taken += nr_taken;
>
> -       trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
> +       trace_mm_vmscan_lru_shrink_inactive_end(pgdat->node_id,
>                          nr_scanned, nr_reclaimed, &stat, sc->priority, file);
>          return nr_reclaimed;
>   }
> @@ -2028,6 +2030,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
>          int file = is_file_lru(lru);
>          struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>
> +       trace_mm_vmscan_lru_shrink_active_start(pgdat->node_id);
> +
>          lru_add_drain();
>
>          spin_lock_irq(&lruvec->lru_lock);
> @@ -2107,7 +2111,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>                  lru_note_cost(lruvec, file, 0, nr_rotated);
>          mem_cgroup_uncharge_list(&l_active);
>          free_unref_page_list(&l_active);
> -       trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
> +       trace_mm_vmscan_lru_shrink_active_end(pgdat->node_id, nr_taken, nr_activate,
>                          nr_deactivate, nr_rotated, sc->priority, file);
>   }
>
> @@ -4524,9 +4528,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>          if (list_empty(&list))
>                  return scanned;
>   retry:
> +       trace_mm_vmscan_lru_shrink_inactive_start(pgdat->node_id);
>          reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
>          sc->nr_reclaimed += reclaimed;
> -       trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
> +       trace_mm_vmscan_lru_shrink_inactive_end(pgdat->node_id,
>                          scanned, reclaimed, &stat, sc->priority,
>                          type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
>
> --
> 2.17.1
>
