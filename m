Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD07D073D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346936AbjJTD7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjJTD7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:59:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C9C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs/eGZ4j5ldMlvC9M1J1374aKqzVMFSHBRBe/mQ55YHMgh4LHV0qb96UyvFnJN4I+TVy8W1J8mwmg8FVZNsIvWHufMrKZeeL7Q3wfwEVcR8uCD6I3LGoyBfMlkWAcBBtwo7Snev9lFaqjXbHz+qhp/c8fqOiKFk9WVR4hkLsEuC8VjgrpRK5GBgei5gpBwoNYZxjMYH/E9S/vn/3tafwQAd2XyFZMM9TBHIeVVD6ec3Hx07hIPnu+ICiN8VQZz9e2k3AGq81PAdjXaKUE+MWlOivswfBwsoG1hcWy1FLCeTLNtXtPNtOhvIFpj7MIXBjqPvVcwO4KwDhtFNCziWxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knv0zgJrQHVyN6U3U3Lx7RLB5vc8k26pzyFhy2ge0Pc=;
 b=a78d/IpNGyASL+cQM4oNDLN/10RKc7pHjNv7GyyjAfGmSBgdXNgbuTiy4NcRkOBPxUNxA3BQY5YsjsxrdVbUxWlHPWQCNG0UABuBCjyczVkmJ4vTpVU73GgU26+apa6TjoiHPyRgFh0/iZKI3L80vV05s0qyXC1/Blz9BQ3UONtC0T2XFtTM4/HjK/hEPWq1qpq0mr6fBizlvVMtfwTSGR2H5gQ3U1UpMGwo+XwcqjmwzBOTq9tBtV0Vc/twZgHsaeGcJs1RYXbrfuRLyRxsirsAHf/vrmhX2AW1AfIhsUnXksrZumckdGGXBE0t2p0zLJZEAYI57A6I0U0sXsM/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knv0zgJrQHVyN6U3U3Lx7RLB5vc8k26pzyFhy2ge0Pc=;
 b=XO/B3FgtVh7rvNttyDi7swuN/k31jJ3vvlYV+82Fc/gVWRrKwq9ZQpxTGa75/clnE2GqWKWGxxNdt/rsq+KELwjXSf5Azk05fIsMANqP0plwmwPLQGbVRLY8kbG2Mg3O53NzhprzyU39vtjCrUDe8vHw5BjMRdmZyvAevqYHukwFAv0mfMau8iL3iSuNwLBdO1fNfhtjstcCRqUH74YBTGW4vEMNy67CYzHBEB6+cwzlbvZmdXaMJKgiSEa8zPDKR1EfKVJApJQ0SoJcVIoyDvHI2+VA5CKnoEspYEl5QT8o23q7g1KMWTGn2jjT0Xg0ARqcAxMD8/1dgmniWCcscQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI2PR06MB4539.apcprd06.prod.outlook.com (2603:1096:4:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 03:59:36 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 03:59:36 +0000
Message-ID: <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
Date:   Fri, 20 Oct 2023 11:59:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
 <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI2PR06MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa45300-fa7e-41b0-8bd5-08dbd120f987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYkSXRZklUpfrM9fvoUyHQ1OdWISysEgrSDvXBwUqV3Py5lkrqVD8/kSjL9/RsmeNC5gyZ8HqFAuJybS5xBVzH0jdG9NCE30bWoVzV+98TYaTRr/hBUO6bSmN0BSiyvWf9bb28wX70kH656B95AFi46D83FGKzfE1iXpEJFbmiDmzcbMxHseHIJ9K6djc6zOL2HLJvbI1HF30QScjNkFjr6iiqNr2tp0Zo8Af/h/17NHdjF1RaPscz+Yk2T3Uog+WqVzZSiym93+4lGTG2GbEYpo8c1CfT0XeB6+jIk6TwGm24PdHCSTYF1axzRd0v7Ou2eM+56AH3VDXk20xiyzT7dStERZZA09WsYOaavVzuiPD1WVOxYUz5ctfaE0DeNilNizVoH/64nuhjiH6lIKrgWiKEcVO3vWeSz2WufzlqsxYZ7nXLmJmJ3NQMr9RyTWmL0jXEbGnD6FcxMxyriYWnCCiIG8vGJOk4kCrc6KQkb0VipP0vk+80q7fZw7WclpD8YuBEGNwcbh9pndu1e3MZMhM17CQnyK6SGZT7Vy41aVqyKPNPuDoUeh4/fU9LH8TQBKhv87UlIVDt8eUhiTXGSxTq142ICxLfLfLmcyPyHOqlmoE+lSQwFyxfVzCN3366t7jrVIsEj/0J1chmuG0XpcbFS64tc+ezz8tPfNljbdahK7pI8lKLEiMj3hqNBLBapc1Gucr4FT+5lg1HTRNR3+pKgGli85Y15Jn6M+4Xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(110136005)(316002)(66946007)(66556008)(478600001)(6666004)(6486002)(66476007)(8676002)(966005)(8936002)(36756003)(41300700001)(5660300002)(31696002)(4326008)(38100700002)(6506007)(2616005)(107886003)(53546011)(86362001)(52116002)(6512007)(83380400001)(2906002)(26005)(38350700005)(31686004)(43062005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJHSHp4NDJ5U3ZkTEE4K0lzOGhsV0QwNy9uQzRxdWQ1eFd1L3JGVVhXODhI?=
 =?utf-8?B?NEE4a2duWEV1akIrZ0dJVWVlMWROdmZKRVhISVovb2VzelFzczVmcEt6QTQ0?=
 =?utf-8?B?dUZhejM5MHRIZUcvcnRxbzVLTERZckFIV0V0NlNXRHhWL1hNUUJRQzJmQU5n?=
 =?utf-8?B?aE9TQ2wwR2d3NXBLSWxKUWNMQ05oQXNIY2pWaS9GUXRLTGtVMHRxUjVYR0pk?=
 =?utf-8?B?Z2lKV3BtNjFhQ0wweXJjUzVSaWJnemdrTkNpYjErWnQ1a3ljRU5TZldlcDJq?=
 =?utf-8?B?L1FrRWJqSGxmZEF4NDNueityQ3dsRHpUOVRZRXJab21EbHErdUoxUXQrMVhs?=
 =?utf-8?B?azB3SVFudzRIclBNVVNER2VwMUQ2YjdXdmRBL0t4SitNRjh1ZlIvOFpnRDE4?=
 =?utf-8?B?TExMMFJHMTQ4R1RQbkpEMERPZFhaTlAzeHlObzBMMFJVMUV3aTdQZ3lyWEp2?=
 =?utf-8?B?NXJwNU9BMlpsekNqeTRPT05GUVFHczBrR0RWcm81M0MrT0QwTUdyK25VMFNP?=
 =?utf-8?B?ZlhNTWRVQXJkMlVFekJqTnVUZnlzdGY1VENXK2JIVDFwNnZLKzF5QlRBRGVR?=
 =?utf-8?B?YjRhYTlKY2ZtUnlSM2hTRjdkZUxLUXFSQmhZRnhJMEdVQTlDbE1YeEJvVm1n?=
 =?utf-8?B?T01ZUDJPd0xXSEVoSVJ5MHJUNlBuWk9lSndLYkoxcHh0UlhnZGd1QSt3b21C?=
 =?utf-8?B?RVFHaXQ0K2pYaHRpa3o2bHdLVDBBMkNweGRLRlFMRjNGamRwd203KzFyNjhY?=
 =?utf-8?B?aDhIQzMvb1FzbFVOS1N2aXdhbDhxYXRXcnRrbWlOVHdPT2ttbmZEVWRaN2xh?=
 =?utf-8?B?MHdPbkZvM002VW5NNG9GSmtYR25BdU45U1A1LytMNXN2c0o2RnN2Wkw0TmhR?=
 =?utf-8?B?dzdoN1pxOXk4eW4ybWlKMXBGTWsza2hFcWp1QUpGWGFFRmhVTXY2SlpwMmxr?=
 =?utf-8?B?OG5RQlZ1SGtSV2ZYaFVBL3duR21jMlkzS2NXUm4yNUZQVkdybWFhNVZoa1JV?=
 =?utf-8?B?TmFPNVVQZ1hESHZCK3p1Tmp1S0FMUUxFOFNqWFZJM0ZWTDVVeHU2NjFLU21i?=
 =?utf-8?B?cnlNbDAyYjJ5c0d1ZzRabXEvTnJBSGhUNWN0NDBDNHY5ZndCYVU4MllDQS9a?=
 =?utf-8?B?b0pQZ29YY1hOMWp6MEJ5RlI4T0NPcVhZenZtTjJuUlBKV1Vpb0NnbXhaeXY4?=
 =?utf-8?B?QWM0SzdJc0x1dkloK3pmSmdJc1pCb2RuNUZDdDMwbjhJY3ZTQi9DUllYR0pJ?=
 =?utf-8?B?djI5YU93WFB3QmthWjBqZnFSK2JKOGF5dEJPT3JTbVQzWTJMMU0wRjRWS0Zj?=
 =?utf-8?B?UGlSOE5Pbk5zWlZiV0Z0MlovTHFQcUZxRjhpOTJCbjlMc3YveWJJOVBhSGl2?=
 =?utf-8?B?cnFNeWtJakxwQjVkQ2dXdDNkeEdmWmhiYmIvdzVmU1hwTWN4ZmNyK01KTG9o?=
 =?utf-8?B?aVBvZllRMzgydmw2cVUzbzlDenJIdit5ZWpVQ3BKOG11MjQwUGxSMzgzZllq?=
 =?utf-8?B?VXVaRTdvY0V4TStBSm90TFVPQkllZmZYaTdOM29GV3pUSTRXbDEvTzlJTDNU?=
 =?utf-8?B?UTJhVXd6YjVvVWtySTlZTDdoRjhESFcrTTFadzRoZExiS2FZaklQMUN1eFlW?=
 =?utf-8?B?bURUOWdTdmNZamtCdVpwTldJaUtITWM1SlZBT2FMRDFLcDF6Ry9oSWdIaVBm?=
 =?utf-8?B?cUpyalNrd1JRTldsWGJERnZZM0JMU2xIWTJqVWVuQmdXbkQ2NUtkTWJva0Nl?=
 =?utf-8?B?OUkraWtqTFVxM0pNa2xpSDJVUnR2RFFvZHgzMzl2MFJzMktZR3VVVllDNGhr?=
 =?utf-8?B?ZXpnQlFTNkNmMDUzejFiZm9ERU9YYnNzNkc5bnBaOXlsRjZCVzAyT1ZMOEVP?=
 =?utf-8?B?YUdRaGlMaVZuK1FpQUFTZnE2ekRWZVBrU1VvWVQ0M0tDdG5Jc2NLN2prblpM?=
 =?utf-8?B?bGZSRFNiV1dkU2dlTjEzaVlhZk5jS1NXVjkxVXZVNnhRQjY0b0J1Nms5VGtx?=
 =?utf-8?B?U0krM2tkaUNneXBiV2FTMStDQXJVcEY1NStXUkxuVnNReHR3VUZWT3FpL0RO?=
 =?utf-8?B?VC90akFRVTdMUzJKT2ZFQncyU1hobG9KTXZTWWJGd2VmbTRCRHJMaWFzeEVN?=
 =?utf-8?Q?JcgDLFmYApXRYf+GJBpzF0pnP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa45300-fa7e-41b0-8bd5-08dbd120f987
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:59:35.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEaYVVhJGSoFrvpebzOmnLQ6RxrsjnlTLwXt8YnAWhUd61DkzoLY5NS/egxrwWiz6l3n1+hkLoEmq/DsrlDkSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/19 22:15, David Hildenbrand 写道:
> [你通常不会收到来自 david@redhat.com 的电子邮件。请访问 
> https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>
> On 19.10.23 15:14, Zhiguo Jiang wrote:
>> In the shrink_folio_list() the sources of the file dirty folio include
>> two ways below:
>> 1. The dirty folio is from the incoming parameter folio_list,
>>     which is the inactive file lru.
>> 2. The dirty folio is from the PTE dirty bit transferred by
>>     the try_to_unmap().
>>
>> For the first source of the dirty folio, if the dirty folio does not
>> support pageout, the dirty folio can skip unmap in advance to reduce
>> recyling time.
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>
>> Changelog:
>> v1->v2:
>> 1. Keep the original judgment flow.
>> 2. Add the interface of folio_check_pageout().
>> 3. The dirty folio which does not support pageout in inactive file lru
>>     skip unmap in advance.
>>
>>   mm/vmscan.c | 103 +++++++++++++++++++++++++++++++++-------------------
>>   1 file changed, 66 insertions(+), 37 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index a68d01fcc307..e067269275a5 100755
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -925,6 +925,44 @@ static void folio_check_dirty_writeback(struct 
>> folio *folio,
>>               mapping->a_ops->is_dirty_writeback(folio, dirty, 
>> writeback);
>>   }
>>
>> +/* Check if a dirty folio can support pageout in the recyling process*/
>> +static bool folio_check_pageout(struct folio *folio,
>> +                                             struct pglist_data *pgdat)
>> +{
>> +     int ret = true;
>> +
>> +     /*
>> +      * Anonymous folios are not handled by flushers and must be 
>> written
>> +      * from reclaim context. Do not stall reclaim based on them.
>> +      * MADV_FREE anonymous folios are put into inactive file list too.
>> +      * They could be mistakenly treated as file lru. So further anon
>> +      * test is needed.
>> +      */
>> +     if (!folio_is_file_lru(folio) ||
>> +             (folio_test_anon(folio) && !folio_test_swapbacked(folio)))
>> +             goto out;
>> +
>> +     if (folio_test_dirty(folio) &&
>> +             (!current_is_kswapd() ||
>> +              !folio_test_reclaim(folio) ||
>> +              !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
>> +             /*
>> +              * Immediately reclaim when written back.
>> +              * Similar in principle to folio_deactivate()
>> +              * except we already have the folio isolated
>> +              * and know it's dirty
>> +              */
>> +             node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
>> +                     folio_nr_pages(folio));
>> +             folio_set_reclaim(folio);
>> +
>> +             ret = false;
>> +     }
>> +
>> +out:
>> +     return ret;
>> +}
>> +
>>   static struct folio *alloc_demote_folio(struct folio *src,
>>               unsigned long private)
>>   {
>> @@ -1078,6 +1116,12 @@ static unsigned int shrink_folio_list(struct 
>> list_head *folio_list,
>>               if (dirty && !writeback)
>>                       stat->nr_unqueued_dirty += nr_pages;
>>
>> +             /* If the dirty folio dose not support pageout,
>> +              * the dirty folio can skip this recycling.
>> +              */
>> +             if (!folio_check_pageout(folio, pgdat))
>> +                     goto activate_locked;
>> +
>>               /*
>>                * Treat this folio as congested if folios are cycling
>>                * through the LRU so quickly that the folios marked
>> @@ -1261,43 +1305,6 @@ static unsigned int shrink_folio_list(struct 
>> list_head *folio_list,
>>                       enum ttu_flags flags = TTU_BATCH_FLUSH;
>>                       bool was_swapbacked = 
>> folio_test_swapbacked(folio);
>>
>> -                     if (folio_test_dirty(folio)) {
>> -                             /*
>> -                              * Only kswapd can writeback filesystem 
>> folios
>> -                              * to avoid risk of stack overflow. But 
>> avoid
>> -                              * injecting inefficient single-folio 
>> I/O into
>> -                              * flusher writeback as much as 
>> possible: only
>> -                              * write folios when we've encountered 
>> many
>> -                              * dirty folios, and when we've already 
>> scanned
>> -                              * the rest of the LRU for clean folios 
>> and see
>> -                              * the same dirty folios again (with 
>> the reclaim
>> -                              * flag set).
>> -                              */
>> -                             if (folio_is_file_lru(folio) &&
>> -                                     (!current_is_kswapd() ||
>> - !folio_test_reclaim(folio) ||
>> -                                      !test_bit(PGDAT_DIRTY, 
>> &pgdat->flags))) {
>> -                                     /*
>> -                                      * Immediately reclaim when 
>> written back.
>> -                                      * Similar in principle to 
>> folio_deactivate()
>> -                                      * except we already have the 
>> folio isolated
>> -                                      * and know it's dirty
>> -                                      */
>> -                                     node_stat_mod_folio(folio, 
>> NR_VMSCAN_IMMEDIATE,
>> -                                                     nr_pages);
>> -                                     folio_set_reclaim(folio);
>> -
>> -                                     goto activate_locked;
>> -                             }
>> -
>> -                             if (references == FOLIOREF_RECLAIM_CLEAN)
>> -                                     goto keep_locked;
>> -                             if (!may_enter_fs(folio, sc->gfp_mask))
>> -                                     goto keep_locked;
>> -                             if (!sc->may_writepage)
>> -                                     goto keep_locked;
>> -                     }
>> -
>>                       if (folio_test_pmd_mappable(folio))
>>                               flags |= TTU_SPLIT_HUGE_PMD;
>>
>> @@ -1323,6 +1330,28 @@ static unsigned int shrink_folio_list(struct 
>> list_head *folio_list,
>>
>>               mapping = folio_mapping(folio);
>>               if (folio_test_dirty(folio)) {
>> +                     /*
>> +                      * Only kswapd can writeback filesystem folios
>> +                      * to avoid risk of stack overflow. But avoid
>> +                      * injecting inefficient single-folio I/O into
>> +                      * flusher writeback as much as possible: only
>> +                      * write folios when we've encountered many
>> +                      * dirty folios, and when we've already scanned
>> +                      * the rest of the LRU for clean folios and see
>> +                      * the same dirty folios again (with the reclaim
>> +                      * flag set).
>> +                      */
>> +                     if (folio_is_file_lru(folio) &&
>> +                             !folio_check_pageout(folio, pgdat))
>> +                             goto activate_locked;
>> +
>> +                     if (references == FOLIOREF_RECLAIM_CLEAN)
>> +                             goto keep_locked;
>> +                     if (!may_enter_fs(folio, sc->gfp_mask))
>> +                             goto keep_locked;
>> +                     if (!sc->may_writepage)
>> +                             goto keep_locked;
>> +
>>                       /*
>>                        * Folio is dirty. Flush the TLB if a writable 
>> entry
>>                        * potentially exists to avoid CPU writes after 
>> I/O
>
> I'm confused. Did you apply this on top of v1 by accident?
Hi,
According to my modified mm_vmscan_lru_shrink_inactive test tracelog, in 
the 32 scanned inactive file pages, 20 were dirty, and the 20 dirty 
pages were not reclamed, but they took 20us to perform try_to_unmap.

I think unreclaimed dirty folio in inactive file lru can skip to perform 
try_to_unmap. Please help to continue review. Thanks.

kswapd0-99      (     99) [005] .....   687.793724: 
mm_vmscan_lru_shrink_inactive: [Justin] nid 0 scan=32 isolate=32 
reclamed=12 nr_dirty=20 nr_unqueued_dirty=20 nr_writeback=0 
nr_congested=0 nr_immediate=0 nr_activate[0]=0 nr_activate[1]=20 
nr_ref_keep=0 nr_unmap_fail=0 priority=2 
file=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC total=39 exe=0 reference_cost=5 
reference_exe=0 unmap_cost=21 unmap_exe=0 dirty_unmap_cost=20 
dirty_unmap_exe=0 pageout_cost=0 pageout_exe=0
>
> -- 
> Cheers,
>
> David / dhildenb
>

