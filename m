Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9997D2C38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjJWIHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWIHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:07:43 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527F1A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlagHsxHv+D+uHdCQy0MwIcvmOfG10lcF+Py5X1d3PDop1JhlUsfWlnBO5U2VE9XnkQctW3+b39JOnFg8l0y4LvWD9bFTvWC8aKB5h0rpBs8hn6BTcnWUpe7B1tJCkYLttTsurQmAKPchmrlzUyizo8pOfdDn0Lata0tF5bXll0QwTCVL9K3/W5CYSY7qP5u0OFpONp2Acy1QcxymkMrrwsTYWw+/wvx3M+1I24A514X6OotvXoHExYBlMkv7BaWg4K5jxQWcZM+LWtN6oEMGmGGwbiTar9DDdd5vkLixpf13tCajgU98+L073caFf8nNYaUblonJIUIN9HuzewKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ3EAELJiImhJ8u2uNfGXsyF+SVXq55guOItwIhX44A=;
 b=CREIyP/+fdSsJJCqp/iIqSdvBHkOsjoCkR6jkwA4/WhNMlNS7CuSTvlUVlGbRyN0HAN8/dgbyqL6tVQyHk5q6zhmh4XiEnxavX1xvLzOpVxxbUMt4dG/vZCDnk81V5R8niqrHmcN529yIAPwxQ0BK1iaIE2nchoTZl3cHei5vOYydfgK+W4JmHusB71IBYZ5NfeN0MOiLOmy2d1atLcx/lyAPZow/Nde4FKLBxqhAARNaIdtG3Y8EOpImdZxm/e+Fl0tkcj+JYmuu5Ppf4QdsyM4UjJ5bf9ylZJh7YAVoKVEddcTLSDk/oYhyayRHRWFkheSfGavZYn4wwVvj5upHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ3EAELJiImhJ8u2uNfGXsyF+SVXq55guOItwIhX44A=;
 b=C/1D0twSSJtOVtGb96bO05968FgmXKFwlnthhuekZcMpR5EcDnLZ2p9KhGTesIyqTr1wrivQFcMQHVsSg4em9rV/keV4jp77QYdPqrNysNlHia6o5jzob6d6kRHu4ekcx5xVhmYCc0iSi8VXlJYostTEv+zPTCbjZV8+6YtmHN9oeqxqGo6K8Yh7nouILKTFb6a7xahfqQnoXWec77QSHI9khQqu0REQo0ZJ3UpIHsnhWQV0hzXGV8kyTVpSxUsIFabshItGe2Om51OrwCZBZZBZ6e/ZrAXypcQebCsWBQ6JGAqqPdlzalZPXYKwXX/UVRgcaaHgC/QTpdLXUZTc3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6555.apcprd06.prod.outlook.com (2603:1096:820:f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 08:07:33 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::b44b:d090:c97a:eb20]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::b44b:d090:c97a:eb20%6]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 08:07:33 +0000
Message-ID: <380bc753-5ee7-4bc7-a76e-a804d5179d87@vivo.com>
Date:   Mon, 23 Oct 2023 16:07:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
 <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
 <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
 <ZTH+7ZJyPnyZOe7V@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZTH+7ZJyPnyZOe7V@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:4:7c::25) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f52a2d-34e8-49a2-f27c-08dbd39f1b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZdqisZspWqphLGCCjNCN130EiHuqdh0Kqz5onlMJr6JICDm+QF3Har0l6h1i+Ln9NaKMcjsWLH+pUfCvmjFiV+Gvbtz88pd5OTMKWleo01tk/nDPrLeB5vuf7cKEC39d6I45IQWtNwO7PCIr8FszxUH7zMJdPH8/AoV7uvk6OaOJZTJZwbArwnrFYe/JsDRSj/V76HKhpSundMSbM+uN0gp6uKDLXmsX8IsMuV/gnAnE0JSJjb+yDFVMhz6VkuXoBx030EO4YfQtoS8m9DXeA8x6yFNQgVzmSHWTqpPaEQ3umcZyVdUEPcvQ4v6XEhR6Aumu2+6m7yX47bw4M4ZCGjC4P+0d5lk6PAbfi1iDX8BKgVcdSafG7bhgApkcJH1LBmAEErI1L9bqJaqXDBu1DGYUGBTr14D6KyZTjbljBOlNHc5hSBPcWQZd3UMxemeqQmtWlpQXysIMpCP/djBNnWF0JGHYDIcea6wPtS6eDU9Z1KxWWCR/XvpB3cPN2P41xi5VbLPuSvXba7iaGvamC2QltMuK94wclyNKhM8/YkKOArb8eYoMcn3u21AiCWcB61HqXmtNGD7dfU5FAPn4WtKAMDzoh/ztYkDcqSP/H1sHxbigpw+lwBEJ1Hd8pc/xvY586ua/mki64qjtCwKw4msffIZmqpZNK1p/Y90B9ZckqqL5V2r6yKcXlFL6pliPS9gAgJ46IzNyhtPfdZ2/8cKYR71VIi+s3vf6A+kICc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(6916009)(316002)(66476007)(66946007)(38100700002)(66556008)(54906003)(2616005)(107886003)(478600001)(6506007)(6666004)(52116002)(6512007)(6486002)(83380400001)(41300700001)(5660300002)(36756003)(31696002)(86362001)(4326008)(8936002)(8676002)(38350700005)(26005)(31686004)(43062005)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5uU2t3Q1VsbnRVOEp3STI1Tnhnd2tZa0hIaklpa2h3aCszMndyVG03VGlr?=
 =?utf-8?B?NTQxNlI5NWtqVE92N0FkbXE0MnZZNEwzZGkrQ0Zsendxa0s0NHp2dFpFTXg2?=
 =?utf-8?B?NzFKS2cvY3dPQnNKUmxBaU1UY2MrQU1ZSit1TDU5NytKdU82Y1hEaTdzc040?=
 =?utf-8?B?VUFpMG4zOXI2R2poQnpYM0dBRzd6b0QyMmVGYVl0K0l6Y0RuUUJRMnJRUmR0?=
 =?utf-8?B?WkwrVzRnVm0vU0pqNUg5clRZSldHWFQxdS81czRxZHVkK1FlUHRFK2ZvZG54?=
 =?utf-8?B?cnB3T2tOU1k0dkxoa0E2S3lJMUZZenRvTkRmTGVuNnF1UWtTSjc1RVBxREFv?=
 =?utf-8?B?c3lYYzdpcmQzMEIxeC9HWE8wYW5JaDd0R3huK0x0dkJoaFNsOHNiNVZ2SjVz?=
 =?utf-8?B?bXVzWVkzamV2eVIzR2RJQ0hldU5oM3hYcXFBYklzbEpVTmVlR1NTZnllSHc2?=
 =?utf-8?B?a3JGWHVTeThBYkhTS2owRjVIMVFGNEZEQithY3lXTXBUWXdZSHU1Rk9hS2FS?=
 =?utf-8?B?dUdhRnhXaEVGYzR1QXk2NCtkM3MyaWttb1JVR2JiNVA1UXZtSFpRdzNwSWd4?=
 =?utf-8?B?TTFibk44aUtXUmlFY2RPL216VDRyQ0RxUmlSY2RrbEQ1SFR3aDZDLzhIMmhl?=
 =?utf-8?B?ODFZSkJVeEJYMnY5NGlRYlNLeGh4TktJM2ErajJYTGpvMUs1U0ZHd2hnOHJN?=
 =?utf-8?B?Y3g3MzZDMEJESkpHSmJIUVhQK2JaaGZKeEFGTDIyaUczV1RQL0VOaWFJbm05?=
 =?utf-8?B?OWxlT1VieW04L1BERGYzMHBKTlNGaWtDTnU1K3hsdHk5OWlsRnl0amNnVmVm?=
 =?utf-8?B?eUU4VmFiK3dCSTNrQ0hUbWNySzA4Vk9XQzBDZlRDZzdVZU9lR3ZMUEF1TGMr?=
 =?utf-8?B?L2l1VHdBbm0rSzRhdnNkUDZoYmtpdFNhRXAxWGtreVE5TUhuMlpTVWhpSlhk?=
 =?utf-8?B?a2lhSFdBaEtwK08xYlVSbVp3TVRKSmhSWDRnd25qR09tMm9YbE5pQTFFL0Ir?=
 =?utf-8?B?SVcxZkpLRnpRcEZKVWlrS0RtRTRiNHQ5L09XeFliTVg4NDBMOUlrbFZXdWh0?=
 =?utf-8?B?MEZRNXZkVnN1SGV6N3R2ZDcwQm55WHRYMG5YSzFNbmh1VUlSZzI2Q2svbTZx?=
 =?utf-8?B?UmJmdmdmbmhEcGs2ajBLQWhuUGZuRVY2bUZOc0VEQzdqN3lwM2FPaW4vZkpr?=
 =?utf-8?B?bUhYVW1mZG1pZSs0MXBFb0pad1JnRU1UUlBMOEs4NHlFMHJsSm83c29hakdL?=
 =?utf-8?B?cVBYMmIwUk04b0ZBU1RmVFhxZUJhTU5VeWl2cnlldXJTVjlmYlVjWm1hcVo3?=
 =?utf-8?B?VUJwMXkzaCtsT2V4SkJYWmhmek9TOEF5YmszOHhTSXQzMTVneWxVQm9hYlRr?=
 =?utf-8?B?bHRYTUVnZHBqa3FPejhocGFZOG5vQnhuRzZ2M2t4NG1GV3JzWkt6YmdUSWhv?=
 =?utf-8?B?K3pZQ0tBZHl2YTJYdXdndHBNbjhWRThGaG9NSXVQRTJ2LzZjaVUreWFseEVH?=
 =?utf-8?B?bXJLSzVKdERxQkxDbWIydENJa0YyeHo5WXptdERQZE1qNnE1dm9EelY2Mm15?=
 =?utf-8?B?ak1BcndjQ3F4Uk90SlBqVFAyejNuWFlNclcyRG50ZTQyTVdPVmhta2hBMTZP?=
 =?utf-8?B?MzRhODlIVXZTbWN1cFMzMjBBN1V1SklIczBtZlVDSG01YXZMMFFXOEdrU1Fy?=
 =?utf-8?B?SzI2aWRvZXZaQS9BMS9yelNCZUxDWUtsbk1DbTNobEtsL2NJNWJFL082Rzhw?=
 =?utf-8?B?aXlFTktONTNoQmpzckZIc1o0WnMwVnRCQjc2KzJ6OUdRclV6OWVtM2t4SVh2?=
 =?utf-8?B?eWIwNlB2VjNMeVVjZ3VpUEpiM0VmaTVuTk5ua2tib0JsNHZDNDhDZ3ZPT21Y?=
 =?utf-8?B?V1N2YzhtL1dDSzNoaHAxZnBkK3pYQnBqOVg4VFhONUJ0UFFxWmxlRVdhTTRn?=
 =?utf-8?B?blExc2FLbS9VMFhwVjhSeEVHejNmSmFibDlnUVA5emJVa2dwWUI5MzFrZTkx?=
 =?utf-8?B?NGhFcFdTOUdEZTRYdk9YR3QzKytTalRhaHJzakJhL2NUalVIRGhDNWUxSzdM?=
 =?utf-8?B?cXdsWDFKUk5xblBzNk5ZdjkzSUY5alN4T0ZkYUtGSVpJdVUrc0k4VEFQcFFz?=
 =?utf-8?Q?4NXy7Bp45HM8sEGBSb1M0K/0T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f52a2d-34e8-49a2-f27c-08dbd39f1b98
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 08:07:32.5848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JlPutzyRnEjiTEuF7rDf4GXGf9tsZ5qezcZY5AKVROEL4jBUPKuskz8uu3PGZbcGF3vSwPFka8/58djb1KdWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6555
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/20 12:15, Matthew Wilcox 写道:
> On Fri, Oct 20, 2023 at 11:59:33AM +0800, zhiguojiang wrote:
>>>> @@ -1261,43 +1305,6 @@ static unsigned int shrink_folio_list(struct
>>>> list_head *folio_list,
>>>>                        enum ttu_flags flags = TTU_BATCH_FLUSH;
>>>>                        bool was_swapbacked =
>>>> folio_test_swapbacked(folio);
>>>>
>>>> -                     if (folio_test_dirty(folio)) {
>>>> -                             /*
>>>> -                              * Only kswapd can writeback
>>>> filesystem folios
>>>> -                              * to avoid risk of stack overflow.
>>>> But avoid
>>>> -                              * injecting inefficient single-folio
>>>> I/O into
>>>> -                              * flusher writeback as much as
>>>> possible: only
>>>> -                              * write folios when we've encountered
>>>> many
>>>> -                              * dirty folios, and when we've
>>>> already scanned
>>>> -                              * the rest of the LRU for clean
>>>> folios and see
>>>> -                              * the same dirty folios again (with
>>>> the reclaim
>>>> -                              * flag set).
>>>> -                              */
>>>> -                             if (folio_is_file_lru(folio) &&
>>>> -                                     (!current_is_kswapd() ||
>>>> - !folio_test_reclaim(folio) ||
>>>> -                                      !test_bit(PGDAT_DIRTY,
>>>> &pgdat->flags))) {
>>>> -                                     /*
>>>> -                                      * Immediately reclaim when
>>>> written back.
>>>> -                                      * Similar in principle to
>>>> folio_deactivate()
>>>> -                                      * except we already have the
>>>> folio isolated
>>>> -                                      * and know it's dirty
>>>> -                                      */
>>>> -                                     node_stat_mod_folio(folio,
>>>> NR_VMSCAN_IMMEDIATE,
>>>> -                                                     nr_pages);
>>>> -                                     folio_set_reclaim(folio);
>>>> -
>>>> -                                     goto activate_locked;
>>>> -                             }
>>>> -
>>>> -                             if (references == FOLIOREF_RECLAIM_CLEAN)
>>>> -                                     goto keep_locked;
>>>> -                             if (!may_enter_fs(folio, sc->gfp_mask))
>>>> -                                     goto keep_locked;
>>>> -                             if (!sc->may_writepage)
>>>> -                                     goto keep_locked;
>>>> -                     }
>>>> -
>>>>                        if (folio_test_pmd_mappable(folio))
>>>>                                flags |= TTU_SPLIT_HUGE_PMD;
>>>>
>>> I'm confused. Did you apply this on top of v1 by accident?
>> Hi,
>> According to my modified mm_vmscan_lru_shrink_inactive test tracelog, in the
> You're missing David's point.  You've generated this patch against ...
> something ... that isn't upstream.  Probably against v1 of your
> patch.  Please check your git tree.
>
>> 32 scanned inactive file pages, 20 were dirty, and the 20 dirty pages were
>> not reclamed, but they took 20us to perform try_to_unmap.
>>
>> I think unreclaimed dirty folio in inactive file lru can skip to perform
>> try_to_unmap. Please help to continue review. Thanks.
>>
>> kswapd0-99      (     99) [005] .....   687.793724:
>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 scan=32 isolate=32 reclamed=12
>> nr_dirty=20 nr_unqueued_dirty=20 nr_writeback=0 nr_congested=0
>> nr_immediate=0 nr_activate[0]=0 nr_activate[1]=20 nr_ref_keep=0
>> nr_unmap_fail=0 priority=2 file=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC total=39
>> exe=0 reference_cost=5 reference_exe=0 unmap_cost=21 unmap_exe=0
>> dirty_unmap_cost=20 dirty_unmap_exe=0 pageout_cost=0 pageout_exe=0
> Are you seeing measurable changes for any workloads?  It certainly seems
> like you should, but it would help if you chose a test from mmtests and
> showed how performance changed on your system.
In one mmtest, the max times for a invalid recyling of a folio_list 
dirty folio that does not support pageout and has been activated in 
shrink_folio_list() are: cost=51us, exe=2365us.

Calculate according to this formula: dirty_cost / total_cost * 100%, the 
recyling efficiency of dirty folios can be improved 53.13%、82.95%.

So this patch can optimize shrink efficiency and reduce the workload of 
kswapd to a certain extent.

kswapd0-96      (     96) [005] .....   387.218548: 
mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32 
nr_reclaimed 31 nr_dirty  1 nr_unqueued_dirty  1 nr_writeback 0 
nr_activate[1]  1 nr_ref_keep  0 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC 
total_cost 96 total_exe 2365 dirty_cost 51 total_exe 2365

kswapd0-96      (     96) [006] .....   412.822532: 
mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32 
nr_reclaimed  0 nr_dirty 32 nr_unqueued_dirty 32 nr_writeback 0 
nr_activate[1] 19 nr_ref_keep 13 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC 
total_cost 88 total_exe 605  dirty_cost 73 total_exe 605


