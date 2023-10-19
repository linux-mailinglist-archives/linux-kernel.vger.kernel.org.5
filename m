Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109417CFAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbjJSNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbjJSNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:23:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53A8124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGfAdatN32wFdu7Dlcs3KKF8CmHhnWooly1i7YnWSU2h80Y8+BVJm6uGsIDsQxBCMKejuOlOobuDmNR3pynmCCt9HwaFSY/2+WWjtz0MpA9wH92C9bPg2p9NaSrCSRaRtKj18muRBQV/jZTvKjf9R4rRwxA/yNZk5fJysEgeLZ8K9zUipTBrbYEyOBpT9OSwS40KglRClDU3SQF4I+L9w2oGZFptcMdfQL8LilUGdBBioXFOqXSy0j3b07QvsLcahfSogeUKNrGRBbw7+WUmY2x4h7d5URcS1p9ekbcP+n15oay+XYg0Q31sSwkk6OzNp6+dVBr4SR1NydWaBWcBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DaMFSJLrfLkt2whKvzER7BY/zwpdxhZiA5Shplk+9s=;
 b=iSRs/Mh+5s/M7iQixto/VLHtSUnLk0VVCWsn6GtibsmeP4sj5I8RlQXd+jGGKg2rEzsZlwitunashSDIz17wCFUNLYXPNKOGsfMB/lU03b/K/zjOMdXrE5ER+tfDzsePeCR0+tmkOMujY74bSUb8qM3RgPNpWeO+lrg+cVAdizJxYFeX+4Siych9owWPmBVCbUJHBsTnUcFP1TT7cpUvzWnuMdl9ctDQburgFQ9hqVGH8vdME4DHUMnJmSUftFAKqJzxLoWPtwN8h6Y/DrIkHE59Oakxw1OSPMVc1zw76CKj/P4C4T8g/DaeB/+BhuEQi8VmglMCcwLVAQCLn8Aruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DaMFSJLrfLkt2whKvzER7BY/zwpdxhZiA5Shplk+9s=;
 b=UjiziuoEi/6MHp25jUVce4O/BA4/5eFu3mqhZZ0fRfBg7OJDG95y/BI6ATgUmx0CqZaK4MkiwB906jQobYXRek6o0EIrfYBgw+irdWzFzEKZa5MUabDaP1bT0nY2jOqi3w12eG8SyCsWiPeFeb396AYlEYsMzXpdHC/vPWqV91XqX1EX54U+KBRK0l8vKVJP9dXy2KDngTPoFH+G5cT5u0DSt+VWXUoDYkYUV76NsJ7baxWu5LJ2RrCx01CKgLBVenRkuLlleVjLgZG6mCXACcwVuQ15xtnHWcjMNA434j6xAzf5iN6Js2Br0/QoG2CwT251IIVW0y9ZRglE66u2VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6446.apcprd06.prod.outlook.com (2603:1096:820:f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:23:24 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 13:23:24 +0000
Message-ID: <faf55047-f16b-47df-92be-8b712465a5a6@vivo.com>
Date:   Thu, 19 Oct 2023 21:23:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vmscan: the dirty folio unmap redundantly
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231018013004.1569-1-justinjiang@vivo.com>
 <904094ce-e340-4bb7-b50d-6aedd816e569@redhat.com>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <904094ce-e340-4bb7-b50d-6aedd816e569@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: be97ab93-650e-4b37-754d-08dbd0a69272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRAmFMqxxYYQ5dSCOiOfAuxd2sqPbb68VIZQ4/2T90g1xuWk7uyb0oBgI3WK1F9gKBJsF2YZo4uJPAXs6gmFAgrH7yJchB9fUGpRD1uxjUiPv93/bgCBwSTxZ4vKtTGPcOL0yn+WWawW1QwGcyHNl2eTGFMm8DZFwADYwE5BwM80mxUk9qpGoYwVcOh0EBlVIVh/H6O4W4eDLYB2oPYWkfgSxVMhX1Ryr14Rx5Cq18C7ajX5XPwMHHixm29aUbI78ANpuLgDu2nIfYazdu6hBVaSlbarfqPGaftapFBrefTEWkYthIEY81pysuCCsG54AqSSEH2k2cldDmCfBNXY1JEoKnouovBB7D3gPtEwnt0z1/RCtGoAMygbkz4qkDpd3IGWRDO4qBDs0vPaYS97k26vLqyujAXSCA6pK0yBwsFSTbDuMG4aAJN714FVcegFnkqW77LKMTUVX5lOKq8Zu3M7LVzEaRYAAoNYWb5Aex/UE6twS6xDUoosxMbbfY5OtcjbtplijVs65fXYGVz9Zdp90QBUe61XIzGVbfbSrauZmtqwHQivW1UuHyywo/2I2kKMRrDEfJeE1bnwE/QsSouWTPVkbqLSHRSeasOxFCa4RRstVBCUlPhrc05JYsnO5lTUR50mJBqitQV+qlAcFgW6ub+SYM/OL5hwdkeav67e6Ns+rLut5awv4IK/HVqAGRdEe3BaZ0rt8laRQBNwSzsdWjqPkoDs4HHMhRgjsIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(107886003)(2616005)(26005)(6506007)(6666004)(6512007)(52116002)(53546011)(83380400001)(41300700001)(4326008)(8676002)(5660300002)(8936002)(2906002)(478600001)(966005)(6486002)(110136005)(66946007)(316002)(66476007)(66556008)(31696002)(86362001)(38100700002)(36756003)(38350700005)(31686004)(43062005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdFTlFvb09EZUNsVlovUXZuQ3R1ejVVUFZtcUsrMlVJTzdBMlpmWjBmVWx6?=
 =?utf-8?B?dmJrQVhjSk9aUkZIVFAzOGpJRmQzSzFiU3p1VzhCSnhOOTZ2MUVoejF4VkJI?=
 =?utf-8?B?NkxZMElLa2ViWkVyTHlRMmZ1L2ViUjBCQzFtZHozQnpiT2s5cVJPYjZaa0xx?=
 =?utf-8?B?M0tHL1RRVnR1YjVnM3VyNndidEg1ODVTVXpWbzkwRVRnbTRDd1k3bkptS3dO?=
 =?utf-8?B?RU43cGh5K1UyQkZKY0JNNUp3NXhUa2ZLVGQzOTFlRUdDL29JYUtJcC83VHhS?=
 =?utf-8?B?RU8vcGhPQ0Z0SHlVbVoxK1dtYUlTUnNXb1JhcDZxci85Mi9yZXE0S2ZtN3or?=
 =?utf-8?B?eEtZb1ZEZDNETVVoMS9iRVFiMkpMOXZNQmZDa3dXcTkwaGlpU05lc3k2Tkdj?=
 =?utf-8?B?Z3JESEtlTHVyQU5WS056ayt1NHRkQ2NKWDVvRTFLTEE2V1U5M0NxYXQ1OWRo?=
 =?utf-8?B?NmtMcG9adGIrSisrdnFFa3hpdk5wekd4dXVhSlppelkwK01lOVZGcno2anU0?=
 =?utf-8?B?cEpSR2ZUb0tueGhVZlVSbEF0eC9jOVpuN0hBSkZObkdlcVZjMlFKREg2UE40?=
 =?utf-8?B?UElTMU5FeWNJcHRrSDM0dG9ZZmttQStGQjlhYTQxT2lhRWU0ZXRzSG8yZUx3?=
 =?utf-8?B?NHhnd0p6enl6WVFCbVVEUWJsWUpJUi93cVUrRk9HbVpocnlXWnRudmlwMnVJ?=
 =?utf-8?B?TnRWeWRXcjJYb1kxbXpwS285UUtuSHN4dmkwOTljdWo0T3hGRnYzSUpRanBZ?=
 =?utf-8?B?UHczMzVjU2xvS1c2OWFjUS9Jajd2UWtVaFZVNTBQM2FKSCtCczlMdWJQUjhR?=
 =?utf-8?B?ZlFNb0FzMGFJS0svLzJFUE9vR1RjZWZVdFVjOEZPVXlCMGlMekdjVVk2OGlK?=
 =?utf-8?B?Y3JEUkNtZTJ6UHZ6dDlPWE11MjdaQUlkMnBha1JYbTVVWlVaKzlVeHNtaW9t?=
 =?utf-8?B?bGowNnNlQWdrcWpITGo1WTgxUnk0UVdHTHIwenZGV2hTVmE0Tnp6M25sVURy?=
 =?utf-8?B?UHQyeW05Rnl3Zyt4Y3ZlUGYrd3ZlQTdOdkErRWRqdytRS3V2QllqTVRENk5u?=
 =?utf-8?B?bGFCRVRNdS9FQ1dLSGZJTHNydTU1TkpoUGVuam4rMWR6ZnNOa1B5cmVOcGdG?=
 =?utf-8?B?dzllQ3Y4NExpRnNRempiQVJJTmNzTGJ5eVJEUFpCYkRjanZEcFJ0MUU5Z1Jl?=
 =?utf-8?B?eC94eGNZaExOc29Lc2dLa1FLK0lDRmlxWmNxS3drT1pOdmptcTRud1liTS9Y?=
 =?utf-8?B?OVZoSzZzM0VVODc3Qmc4bzJEd2lXM3liODQ0Z0owdVBhMnpUNE5KaVVNSlJG?=
 =?utf-8?B?QkRBVzhjeUZHQ0o1ZjlQcFIwdEpqeEZSajRGNW5jallJZiswN3BFZmlKTUFW?=
 =?utf-8?B?cXNFVVIvM0RaWFI0WUlYSVR6YXk3WUVXL1lpeTl5ZllhNEE1cVZmcHdnNFdU?=
 =?utf-8?B?dUdiMFNkMmR2RzY3NnF3Q3RUbGFDcStncWFwTkZIM0lYSU5hNW1pNnNCb1pJ?=
 =?utf-8?B?TERGeGdnUi9PK1Y2bGV3ODFxVm5KUzlNNTBKZGl2THFTTEwrKytpekdCUjgy?=
 =?utf-8?B?YndSZlJSSFJDOTdseVRFdmxsM09uVzdHQjFBMHF6TVZSY09nOERMYjRFaVZO?=
 =?utf-8?B?V29Vd3Z0bUhic0xlNmtyMHdtbzA5S1pLaUNybmxZMDUrbUovOE5BaWJjclIx?=
 =?utf-8?B?ektEc0dneFJIS2NxSUt3QitZL1h5M05GaDdHYytKeHFGSmJzWEJQNjRlRHJU?=
 =?utf-8?B?WG42OGJIUXZuN2hjcDJqY09yNEFHRDZFNnR0c05ieXpoemt2WUU3MnJtbml2?=
 =?utf-8?B?c3FLZzdXRDdNYVRrWVFVaEF5K0pTT2VBclc3YWlFbWhYaGhIRks1Z3g4SWZ2?=
 =?utf-8?B?MzNrU1psNXdQcEg3R0l0UEU1Vi90WUdUWXZGd0xFWmRIUDBPekFxMGYvWStE?=
 =?utf-8?B?VnRrdUpHaGF3YkFGRUNva2E1bXBzS2h2aGFKa3J2OFVqOWlJL1NQRnJYTW5i?=
 =?utf-8?B?eXM2ZXUvdm1hVEpYaVpBNEsyUGZnS1AvS3B1dCtveXNvRXFFZnFTWjEyVkx5?=
 =?utf-8?B?Y2Y5Tzh6OEJlamh2Mkt2VGpOaFgxYWpRUklqN2pjR1l6K1NjNWh1eFZkUSti?=
 =?utf-8?Q?Ggilm4J/rZAsWa2y7VIMg2gLt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be97ab93-650e-4b37-754d-08dbd0a69272
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:23:24.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcYUNryTMj047qc3nSuFInVTWQvPjMLiLe3/qUDCZciJZYsmvM+DKsoeeAZnYf6PkoPuUycennmHpZvxmduPdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/19 21:03, David Hildenbrand 写道:
> [你通常不会收到来自 david@redhat.com 的电子邮件。请访问 
> https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>
> On 18.10.23 03:30, Zhiguo Jiang wrote:
>> If the dirty folio is not reclaimed in the shrink process, it do
>> not need to unmap, which can save shrinking time during traversaling
>> the dirty folio.
>
> Hi,
>
> I really cannot understand what you mean with "the dirty folio unmap
> redundantly". No clue what this patch is supposed to tackle by staring
> at the patch subject.
>
>
> This patch is supposed to improve performance. Can you provide some
> proof that it does and that we should even care about this change?

Hi，
What I understand is that in the shrink_folio_list() the sources of the file
dirty folio include two ways below:
1. The dirty folio is from the incoming parameter folio_list,
    which is the inactive file lru.
2. The dirty folio is from the PTE dirty bit transferred by
    the try_to_unmap().

Currently, both sources of dirty pages are determined after unmap
to determine whether they support pageout and recyling.

For the first source of the dirty folio, if the dirty folio does not
support pageout, the dirty folio can skip unmap in advance to reduce
recyling time.

This patch is not well considered.
The v2 new patch will be submitted later, Please help to continue review.

Thanks

Jiang Zhiguo
>
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>   mm/vmscan.c | 72 +++++++++++++++++++++++++++--------------------------
>>   1 file changed, 37 insertions(+), 35 deletions(-)
>>   mode change 100644 => 100755 mm/vmscan.c
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 2cc0cb41fb32..cf555cdfcefc
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1261,6 +1261,43 @@ static unsigned int shrink_folio_list(struct 
>> list_head *folio_list,
>>                       enum ttu_flags flags = TTU_BATCH_FLUSH;
>>                       bool was_swapbacked = 
>> folio_test_swapbacked(folio);
>>
>> +                     if (folio_test_dirty(folio)) {
>> +                             /*
>> +                              * Only kswapd can writeback filesystem 
>> folios
>> +                              * to avoid risk of stack overflow. But 
>> avoid
>> +                              * injecting inefficient single-folio 
>> I/O into
>> +                              * flusher writeback as much as 
>> possible: only
>> +                              * write folios when we've encountered 
>> many
>> +                              * dirty folios, and when we've already 
>> scanned
>> +                              * the rest of the LRU for clean folios 
>> and see
>> +                              * the same dirty folios again (with 
>> the reclaim
>> +                              * flag set).
>> +                              */
>> +                             if (folio_is_file_lru(folio) &&
>> +                                     (!current_is_kswapd() ||
>> + !folio_test_reclaim(folio) ||
>> +                                      !test_bit(PGDAT_DIRTY, 
>> &pgdat->flags))) {
>> +                                     /*
>> +                                      * Immediately reclaim when 
>> written back.
>> +                                      * Similar in principle to 
>> folio_deactivate()
>> +                                      * except we already have the 
>> folio isolated
>> +                                      * and know it's dirty
>> +                                      */
>> +                                     node_stat_mod_folio(folio, 
>> NR_VMSCAN_IMMEDIATE,
>> +                                                     nr_pages);
>> +                                     folio_set_reclaim(folio);
>> +
>> +                                     goto activate_locked;
>> +                             }
>> +
>> +                             if (references == FOLIOREF_RECLAIM_CLEAN)
>> +                                     goto keep_locked;
>> +                             if (!may_enter_fs(folio, sc->gfp_mask))
>> +                                     goto keep_locked;
>> +                             if (!sc->may_writepage)
>> +                                     goto keep_locked;
>> +                     }
>> +
>>                       if (folio_test_pmd_mappable(folio))
>>                               flags |= TTU_SPLIT_HUGE_PMD;
>>
>> @@ -1286,41 +1323,6 @@ static unsigned int shrink_folio_list(struct 
>> list_head *folio_list,
>>
>>               mapping = folio_mapping(folio);
>>               if (folio_test_dirty(folio)) {
>
> Can you elaborate why we want to remove below code? It would have made
> sense to me to duplicate the code in an early check before unmap, if the
> folio is already dirty before checking all PTEs. But why can we remove
> that post-unmap code?
>
> -- 
> Cheers,
>
> David / dhildenb
>

