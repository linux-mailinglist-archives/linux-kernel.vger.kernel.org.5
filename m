Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D357D075D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjJTEhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJTEhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:37:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8FF1AE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9gzX5o2V/BU7/1p1PLv6zR0FmBeZQX0knAF27G1PoL7le7X4OG89wNC6pAj8ZgXrf8XBGcVNugxeDhDKs0u3/hdGwIY0enzbrTmoRFgwEI0ZaWN3o19Y109vWsNrKZ3f0SEQ/346pquXcNDZRJ7TfvtfU2lq4SghPaKzlEcd4IVPQylJniODiLmeVA5ou3wlVgNt6s30vmBiKbz7GRIGSmoVLsWY61DLUhoSlqGC9Aju5/ctVgmxQ/Fj5dxSm18o1AFohLnJ/b31I8ULYzDWIpAGzQwKgRtw9auQCzz1cVuo1hkF8DiE7knbBSF+igqfIs7T/etmKh07yaY+aWvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTagxbnPa4CNfZzkbF8JHdFDRX+Vmxuc/e9xq21pQ0A=;
 b=eqkSdPO58UYJnUIazFXHVVmGTtWb5sV5GSp7oi66+VrZTpB8cjVsVClI/Um7eAI9z17R6eQf5rxgaQUb2EAj4KS9+eG+SiuaDSVOgYcw/IpHhDVYkU6StLxLo3IG/zYwPfRRBk0cVRs3sQHaaZR1H8Le0OSrJTBbo9GsQAY0WBEywCzZMlTdJzVTmkI4m0zfAcO6VT0IpmWm7RSupQT8in1CT4z6/xif0Y9J5v30j09TdSP/AAa0Tpt6GEQkevyxyukklixIGCbAiCptL+yCAiV5LB+XhZgi6BalATSB/0Bryd6d9xppGWDPRpB709ArCVI8MoGI8uoNklc4D3awSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTagxbnPa4CNfZzkbF8JHdFDRX+Vmxuc/e9xq21pQ0A=;
 b=Fu7tAe+hQAbzq7mECXehtiGdlnZKtzDDcgFud6H8nJVwLMXNZuxnr4qLyEm7VS1/84C8GpXNjnI9OXdfDZ6RrS01Are4+phP7dlmf04szzMrET2tM06bDUWEtpn5aul2fYX0SEExUT1lRJKMoaKoPb0kMTeYGx8ueKEB9h26tDNxQxAZsOZ8qw87Rnw/92hyonqQIe+gOT9fiEQYvZbfo/2QS4mXpGaMmL17J8X2D75KOCfc5XyN3zDcfyVETllwtSsvMXfdZt9xEEuj6Fxk/L44Eyajr7W/P7o5qNDqoQ2UMN8iUCQDVf5OEKLLR3cYeuJchihhF06UeVkaEg5+iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB5583.apcprd06.prod.outlook.com (2603:1096:820:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 04:36:51 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 04:36:51 +0000
Message-ID: <7005b574-c9c4-4e74-ad81-ac1a1163c269@vivo.com>
Date:   Fri, 20 Oct 2023 12:36:46 +0800
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
X-ClientProxiedBy: TYCPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::16) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e54fdc9-88dc-42c2-c8de-08dbd1262d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tL1ORD2YgzylwCTfz1szdWLaBZUCw08lZNm/PH+jw93JdY1lEh4ipMMhkNyagwmk8U/gaPFUJcz30fC/HUYTYXTKymkRiy81ZFT1mDqzuxNnvpUv0koXwOBQPN8Bd15UY8PeWdNsYgRo1N0pc7mHnXUjloQtNoT7kMeziVX8YBono+wgmXz8+cplP+vLq0iMyCi5WWDXQjDe5wTyILTjFGqNOaKM2GALNScbI+4RL0RuXfMfB6AyrUx8jPHR0Jq28zF0v8f++2UEBz1oWnlnyx23ukIMMDs6tywLQmScEaiXrAZB/vXwT15Yuss96Yce7ZGfrhH8kU+ae03lyJmtUwjW91rHBJvL/VMhIBmanqsKyizcX+Ky3cukvInwKGwGZt07jczMiYgxQ2GiPpWro25dBJLZDGST2CrbTaY23IvzXWAC55Q/3exe3Mm22vqpAnzPNzh/enXaSBrojuX1/EOWJoQJGM3MzH/vTiOtS8pOCPDOD8obqLvOGNTx3URAswUgKbi5sGhUASFKVXr2U6t2TVhMsgUmInWLPsBR7ZwZW4DVUvnfvbSy21M3sSXjQmIExCoaeNvY3TuNiXai9NWhiuyktjLO7FZfGZdxUnlXlNj+J2MN7DXnS5yobd2A8WVFB6UgLfMBTzebmEtP7ax39wqtzK4eYqNHFQ2ZKltOqNYIP6+dKj+9VPzTcbczXNxMVMNtr/HCzo/Ogs1sq2q/KFLThIfEG0J4LtDEh1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(8936002)(8676002)(2906002)(4326008)(2616005)(26005)(107886003)(5660300002)(38350700005)(36756003)(41300700001)(316002)(31696002)(6916009)(54906003)(86362001)(6486002)(478600001)(83380400001)(6666004)(38100700002)(66476007)(66946007)(52116002)(6512007)(6506007)(66556008)(43062005)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NQZEVFaVk3YlBxVG05WjZXby9hTU4rTDQ4Wks4TVIvbGJuRWVhbGVIZUJs?=
 =?utf-8?B?d291OTA2QVY3QnlIbTZhcUFEYm8xYVJwcGpjYVRCT2xLUC9oblBsUWxGUkdL?=
 =?utf-8?B?amNSRTNvU1ZxZzVPNkRLVy9sWHFOMGh6cEh2VnhqUE1FTy9OcWtleDdQVzl3?=
 =?utf-8?B?QTR5V0JjQU9MUnh1ZnJDVFJDZk5FRTJ4U3JRY3hEejBoWjNwVU1YUGxYS1Q1?=
 =?utf-8?B?U2paaTZHeDFTYlIxclMzOU1jZTdQL1lCQUxNci9qaFdXYWJUcE9rMWdrODVW?=
 =?utf-8?B?NEJDUndxRittbEFNQWtLTjk0aWRUaU9vS0lsSzBSUDRnNFRwQmE2dW0ra1R1?=
 =?utf-8?B?dllGNlJ3bWRrbmVCdWlMb1RwL0tpMWpaSXJQQzVVeHAzMGpoSXR3bG9NZ1Jy?=
 =?utf-8?B?U053MkdsRmlzRGFXMHJHZm9Hb1EvYXJCVVR6Y3h1RjFqNTFjLzJaR2ZKTFdJ?=
 =?utf-8?B?UnlkU1YrSzJ4UVhLN1R5OE1CaTJDdnRjMFZySG1SM3hJbHR2ZUFTWEE0eGp0?=
 =?utf-8?B?bERzNW8wSVIvTUFYR3IzWXF3SUtkckU0Wm1LUUM0bXk5VDE0V2Irdkt2N2dv?=
 =?utf-8?B?WDhWNllIc1Njanpmdm1RTEttMTZ1cXpTYVlOdVhZQTFET0c4TjBFMURCNndV?=
 =?utf-8?B?UTl1NXh4eWwzc0w3b2psRlFmei9waE0xa0pJbjFSc0ZyUm10cHh5Yy9lVWRs?=
 =?utf-8?B?SmZDaXE2NjVnZmhIY0RYU1pBVHhpZWFTUi9rZitBZ2lwcmExVnBTY2lzY2l2?=
 =?utf-8?B?L044WXVFS0dGVWoxclVaY1dTcFpGaENPVXNJNEdDRXRoWjF0N3k2VDIyRHhj?=
 =?utf-8?B?M2dtMGNEVnJPN0piSkxNMXBQOER5SDVINE81K0g2Qy83eU00QzF6Q1pDVG5F?=
 =?utf-8?B?N1Juay9ZZ2FVRDA1ZE0xdHF6TTdLQmtjN25hMWRKWkhpUGRKQ2p4am1TdXoz?=
 =?utf-8?B?Nm9TRnVCMkc5eSthWFY1cjFFUTJVNDFrRkNGNHlITE92RTBleTlRRE1DNFhq?=
 =?utf-8?B?UzB1b0hVbXU0V1plYzFaSEZUYVlJUFJKYmtZMVhVZi95dkl0VUZLcHlWWDM5?=
 =?utf-8?B?K0x5QUdGaUFzcVNnc2NPYUhlcjNyOTQ5M21FcHpGdXl6YUJmREFzekc4VUJS?=
 =?utf-8?B?NDRHdnRXOEpRVnNIT00wQ08valZnaGlxbzdhRFk3OWtOU1dhVUE5Nk55LzVL?=
 =?utf-8?B?eGhFUUlFRnh5UTl6dVlUMUJtTGtDeWNyR092bDlxQ0tYYkFwYTB0Q3JPaUtJ?=
 =?utf-8?B?YjNFTDJUVWc5alZpYmh1NzRUWENqNDRRVGtybnRsWTZucEYzUE5RLy84TXl4?=
 =?utf-8?B?UnZIc3FxWHNDV3JQRmt1Z2tGZE1HbnFGS29NV0dVdGx3QURTSjJoSmpQRDdF?=
 =?utf-8?B?U3FIcDFhREE5VS9KTlhsbHRLbGE4a3JOUHRETDRMUzF3Vng2ajQ0dkhXaEtH?=
 =?utf-8?B?cXdtbFZMTUx4RWhaZVlyOEgzd0N5M21nN280bCt1MVlHdkhFNUtPaFBUSHIr?=
 =?utf-8?B?aERlaUFGT0VxeHBxRFVnMlZQdU5UbXNBVVRPcVlVT3JLbWZ4Z0ZRSFFueWR0?=
 =?utf-8?B?NWdWVWJzNFJWRmJCS0NtdGFCUGY5djhqUkI0R01ZOEphYXltaDdpRFJ4Vk5n?=
 =?utf-8?B?bVgvd2ZabGsyaEFCZlBSTkJvRUVSRXE0UnZqNkpZa2k2TEg0TFY1dlhBdzRU?=
 =?utf-8?B?STFMb2ZQdWdWS0FqTDFHcTkzT2JiSGJzRzM3NDliUkZZYzU1VXpPTWhHWTR4?=
 =?utf-8?B?OE5MalVmUXM4aWlYeG1MN0lESFFFVFNtcVpZU0dRZFgrRGltLzZuYnZPczhV?=
 =?utf-8?B?Y2Nyc2JLS2NtQjVmRXZZNDRNODdxaWN1NkNYSXo1bzB1SjErZFB6Y0s4VFc4?=
 =?utf-8?B?MmhrejV3dFF1Z0R0eGp2bUhmT2VmK1F0TGc2emlSWlBJeFdVbnNOaFRMbkdi?=
 =?utf-8?B?VGFRekdpSVFTRzY2MWZVeS9KNXRWbGx6cENmNzk0L3VnRTlaV25JVnFUNkRw?=
 =?utf-8?B?eDBrMVh6SnpkVE9DODlNT0dFdDAyb3ZPMDRuRWJ0Q1FpMm13NzZLMEpKSEtS?=
 =?utf-8?B?S1pqNlFTREp6K0x3ZG5HTVMwRG9scUJsUjZ6YzhnQzZMTHpiTFBBS1I4cE1I?=
 =?utf-8?Q?cu6nATgJtiWrb7b6Ru59/8Yl/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e54fdc9-88dc-42c2-c8de-08dbd1262d18
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 04:36:50.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mg89WnnWtgHIrMs6qWNFFpmqu/Rg77SV39P3hHnk/U97U2AgIsv2xdqCBEVeDNA8Qn7LJUau00RgZRLAQyBcYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Yes, [PATCH v2 1/2] is against my patch v1 index 2cc0cb41fb32..cf555cdfcefc.
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

