Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D657D0748
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376277AbjJTEKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbjJTEKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:10:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B687C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKHimK0OJRbb9nmk0IcvO5iJ2SBUhG42HZ2RNTBc3ljddEx0HDXZGyy3c5wMTDgaas86r9gk6H4UjAFC7ZrDP8KEuqZzkdVzuj3k7HLuNZ8lO8epzqBZrBZTzLl19XB2rlvxu6ltpPS4sOR68KD83kjbaWvWxCHhFSs4Xl1SKPHFSLQZQoIEPdu6+e+9sH79iJzB6S5cThcBGhqb8GXpRv5+PXfP95TxWy/XKLt8RhWrJsq5Bme+IiVqSEeVF6/Y86rqxsdYvhMS8+dQILRisJZXulmLT8HPJwFqhRjqxUHcBnCIpxvBo1SvR97cxjRsEJhxhUDZWitPV/mdfpFtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MNFzWx0kscNqlPpvKzYO1wNRYeVClRraPihFI9itGk=;
 b=afbAi5aN6lqqP48zdNmmrdXH6bS/izxztcHCm47H5B02DY1V5sG07ro5E1AEaEGlwsN192xagckTEhaD8ri3gEUaHCTUVvOdsbja5R1hztqZQ/Yq4hJmmgwYQGR0z22eBS+P0bXMwEbY+UELuMxcitW26hj1axIxrWfrdLJ0gpnHGr4mbq8v7sFEzV/FINRWI109joqemq+zZmNFw0VCTyBPAxbGTCyCM6stMLyKDfVfTyFD1pZ0ShkUCP/vp1Ida7qTkqB70mNAT7v858KfGdYQqB13gOxOfWwgAFjrc0VPy2tdDqnhFYsTqyPZTQkw2dcT1tk6pCt8habgM4BIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MNFzWx0kscNqlPpvKzYO1wNRYeVClRraPihFI9itGk=;
 b=emqTOb0BPy/pGIqcMo0TfuFc2o9ipkbZ102FjNKEgjl4yJ3VX5dsi2m32p8tUtAXC8Y9+wjb3WOAyiuqUEM34uSJsL7GzM/ToRgTMH2Zdq25WWQkMfcHiNPnHVPdGBImuchnC8wAq8gl/ZwaxRbVnb5tFapV1JrSwtHJ79qhF9Mgie+F3WLAO9mNWk1VVmF2ghS4w1alH1eBiNG0HAQCPsmw1nmkz7aXcM3oGWh99wV9BV8lQ2YXlJVSvItg6wN+4Ev6T7VrJ7Xk1MFGtjLAkY+/WGv2gz46cFKv/556hrOoBDlWxarIqxJc/ecZ4aAHw6MvAZKW95VIG4GAhZam4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6037.apcprd06.prod.outlook.com (2603:1096:101:ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 04:09:51 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 04:09:51 +0000
Message-ID: <b1d05ce2-1625-490f-ac5a-c88d3468385f@vivo.com>
Date:   Fri, 20 Oct 2023 12:09:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
From:   zhiguojiang <justinjiang@vivo.com>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
 <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
 <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
In-Reply-To: <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 37464ef1-6591-4ac9-988a-08dbd12267d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmuDy+Kw4bvz+dTA+QR/6j7YgABKvOJOJmJdf3mOiB6Fggvmm74pUz7oa7ras0qqhXTp8FAD6VPdhVYgMM57qqYW1U8tM9xmeiev/2Z4h7ogiuPfR3kOpSve3DGGzkzuJwaXB3q2pY8JD4S17IivHm4jf9AD0szlacOjVhz6QMuVQbztNScUKGtR2TT/EOJnlf7pgRMUH0zGc8NDEllnVYSZelJp7OzLzVajnrXVq+8N7RS4x2YG9f7bmeK6bg1VBJwABvdNEdO4gBX79H/HBqgtFzAQP49LlGPH7o+dbNJ1WtO28L8DtCg4C5CzHUMAPvnbkvr3jYU6fmGJ06QHsi6rv5PdClNAZ7qFWKvPRo8qnwSjwZCYBRZzw9NiFfzhuWMKYMZChDL9YoaZQeuxlLY/0NR4WRj5nAL8faTEKUx4h6w1vbHpROde09bnkB7nZRsK6y9gdWOGVgNemd7PkeEDTdAkXumiwBr5nkFv9oe/s3vKcDeZBBXoXgzD/YdW0uHI0oRpkGUqnG2GSGgnB8dMFuCzQDb0gvUQdgR18gL4d3u9QZ9NkY3YmfqhlXVPoyKcb4krWb73AyIa1D25s7nuRFrr4X9R4Q57NDnpZbeKtusTqgPTNCbYV5KXnLuB8E8ZDgeIQyDNXZxtZ+R3QY0wYtNOKik/mFO5SDc+CFPRqTK/6AW3Xx6QgwCxrBmZIfFZa8hUFM4gUQxePj1KDkLcEkJBn5TqekzNIM5yxzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31686004)(38350700005)(2906002)(38100700002)(6506007)(41300700001)(36756003)(31696002)(5660300002)(4326008)(6512007)(83380400001)(26005)(52116002)(86362001)(107886003)(53546011)(2616005)(478600001)(6486002)(6666004)(966005)(8936002)(8676002)(66946007)(66476007)(110136005)(316002)(66556008)(43062005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWs4NkVNTFBkMmRMa0pEZ2d1UnZ0akpJVVNSaWx3MkkwRnVLNzVPZUt4T2sv?=
 =?utf-8?B?a09YbHhuU3E0Y1NwdXZpSHBrNjZObEp5VDFkOXlFOGo2VXl1eGlwdU5Lc0kv?=
 =?utf-8?B?RDI1dVgzQ0tLS0VPNDZEVWkyZmcwejRybUNOQjBqVE1ndFpvUGgvTkpLKzBm?=
 =?utf-8?B?RENQdnl2NktYaTZkblY1UkQrMWh4am9UYzRoTUJQSjBuMFRUTUVHM3FEVEtL?=
 =?utf-8?B?d0JlUURieXN3aGRIV2o5V1NpQUVxSnk1d2VVdjlHRWR4WFduUDF6R0FvOEFW?=
 =?utf-8?B?UElnV3BRaE9VRzl4L0g2eEY0Z0o2KzJNbDI1aUpMWnl1SFROUHJUMTNIbCtR?=
 =?utf-8?B?WjIrOTlFTzBZUDRKU3JsckhOR295WWZXRnpCWG1wVmxVcmlHU2FDREpkdzdm?=
 =?utf-8?B?Zkp4Y0FiSXBBWEIvUFpkM0NaWE92V2MwTU45b0FHUFpJb005WnB6cXNjZllo?=
 =?utf-8?B?SmdSZXVUbEsxOFE4Y0pWSldyQllGL294MWxRcWNrbjZnZ0o5b2tZRnlhQ0Vh?=
 =?utf-8?B?b0p2dmhVVmZZWnJRSUNZcllwdzRRQkdYaU15VTZMamlKMzAxK3NBMis5TVN6?=
 =?utf-8?B?UGNKU0haV25FaG1GQmFkeGU0UDYwdklxMzBpZEJ5bFhkQTZUbnZ0MVdEN3Q2?=
 =?utf-8?B?Sm0yL3BwZHdXV3VlTXFUYlNwSXVSb0RiR2pLSUFIUWMvTjk2alZGa3diNS8w?=
 =?utf-8?B?R2lmSlVqME1EMG5LdDhPcHFXSjRHemNlb0hOV1NXK2tMWE5YM2dnb3lGRmMw?=
 =?utf-8?B?NGdiQ3NLdUdvT21oejEwcmtYVlIwWm5nL0xiS2FPVWFVQVVHQTA3SUFhWjBs?=
 =?utf-8?B?OVFPZzNRV3ZzTzlSdHNHUm1objNOWVhwMVhuN1JFYnhNTDNFODRMYXg3YlNi?=
 =?utf-8?B?eUJrMHB2V2ZKWUJFelprQnFmVDN6a2ZsbEY1QWQwVFpndFZrNStZYlNqa2JI?=
 =?utf-8?B?dStENDYzTHdIVUZQQm9LeE9mZjlvSmlFdnhydXZuT212aGRsMERLSTR5ekkx?=
 =?utf-8?B?QXlmT3hxZ054dFRkWmpKOWV4bHdkeHVDRk10TzNPcFJ5MWl6SXVPOTJEb29C?=
 =?utf-8?B?cFFuU2l3VUdYanZrbktHQnpzTWtUbGJ3K21aRjVMZUVxV2FFcXZ6UWkyNWIy?=
 =?utf-8?B?ZndNVTJWYzZsL203RzNwc29Zb0s3VWlBRDFoWFJILzZCV1A4YXZrMnhqUnpS?=
 =?utf-8?B?VXR1VEkvM01BNnhRR2Eyb280Njk5NWg0Nmh3VXpxNG9YRm1KS0ZQWjZiVFJu?=
 =?utf-8?B?MWlDT2U5bzRvNWRYanNiZ01TVzAzTDF6NFFnRll5cCs4WjRzRkJWMmtoa0VC?=
 =?utf-8?B?djhjdTlwWnlBTkRDUWloVElNUmZ6VEtjZVpCSk1Zc0V5a1dyZktnL0VtRkhl?=
 =?utf-8?B?TkxFamFiUlYyYi9xZ2tVcndCRUV6anFvSzlIajI4R1pnU0tyNFI1RzAxUXRN?=
 =?utf-8?B?SDNYL2NpMVBOcVMzUld5Q2RyeVVTVEJqRkNGeFNKRHlJNUsxTWtwMi9TVEQ4?=
 =?utf-8?B?REZXQjhRUjNLdnQycDkzYnhzUGUzaGIyS3NmazJQUmtpMGtXOGI0Nkozb1My?=
 =?utf-8?B?QlM4NVBGR1I1R2xDS2kwdkM4MmM3SUpKVDUrUFBBd3EyeVV1d2kvVGpuQ0Jp?=
 =?utf-8?B?VnlrRGk4cWluVHJ0VWl1Z3h1bi80MFEwd1Q4ZGF0TlZ2a1BOZi9RdVFSUDlq?=
 =?utf-8?B?NDNGWEVqZmFLTGdTVitmR0MyekxOYVUvVkhEbnhGenlIRThuN1hsTGpQOUd4?=
 =?utf-8?B?aVRlN2VNWFFjQUxVdUdQSHpxbUlkL0JjVzcvZm9VTXhzVUNuODVVMzRBWkRT?=
 =?utf-8?B?aGo4c0dZTnZlSlBpQjBocWhLcEl3T0lDclAwbHBXR2RZcjlZc2w1UjNPajR4?=
 =?utf-8?B?MkQ4Rnhqc3lqbUV0czRoWmRZaWw0cUhMb0E0WFF0aUlZQiszY1N2YnBZTjFs?=
 =?utf-8?B?ekR3VnBTWnRQMnRVcmV3dHQ5eE41dS80ZlJHVEo4UkFsV0dJbU5OZDJxa2di?=
 =?utf-8?B?VE5rejdRdSs3U2ZTcFVkMFBYZStSMkZBdU4xeW1SMXJFVzQwV2loZ1ByTHk5?=
 =?utf-8?B?WU5Fa0U1YjBSc0FMU1pRN09BSlQ2clU3dHMyR3llOE1oNnZqdk9XWkd3OE1j?=
 =?utf-8?Q?BC1fGj9SZ35q93FhiSVel6mK/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37464ef1-6591-4ac9-988a-08dbd12267d8
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 04:09:50.7596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAO2+0GdYGSiwRMPaPwzlya3fYJRcmFyQvgRreyAIAQ2rFD1TUlRM+K4T330GOzWxuUEdrECgksVrVmyy3e6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/20 11:59, zhiguojiang 写道:
>
>
> 在 2023/10/19 22:15, David Hildenbrand 写道:
>> [你通常不会收到来自 david@redhat.com 的电子邮件。请访问 
>> https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>
>> On 19.10.23 15:14, Zhiguo Jiang wrote:
>>> In the shrink_folio_list() the sources of the file dirty folio include
>>> two ways below:
>>> 1. The dirty folio is from the incoming parameter folio_list,
>>>     which is the inactive file lru.
>>> 2. The dirty folio is from the PTE dirty bit transferred by
>>>     the try_to_unmap().
>>>
>>> For the first source of the dirty folio, if the dirty folio does not
>>> support pageout, the dirty folio can skip unmap in advance to reduce
>>> recyling time.
>>>
>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>> ---
>>>
>>> Changelog:
>>> v1->v2:
>>> 1. Keep the original judgment flow.
>>> 2. Add the interface of folio_check_pageout().
>>> 3. The dirty folio which does not support pageout in inactive file lru
>>>     skip unmap in advance.
>>>
>>>   mm/vmscan.c | 103 
>>> +++++++++++++++++++++++++++++++++-------------------
>>>   1 file changed, 66 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index a68d01fcc307..e067269275a5 100755
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -925,6 +925,44 @@ static void folio_check_dirty_writeback(struct 
>>> folio *folio,
>>>               mapping->a_ops->is_dirty_writeback(folio, dirty, 
>>> writeback);
>>>   }
>>>
>>> +/* Check if a dirty folio can support pageout in the recyling 
>>> process*/
>>> +static bool folio_check_pageout(struct folio *folio,
>>> +                                             struct pglist_data 
>>> *pgdat)
>>> +{
>>> +     int ret = true;
>>> +
>>> +     /*
>>> +      * Anonymous folios are not handled by flushers and must be 
>>> written
>>> +      * from reclaim context. Do not stall reclaim based on them.
>>> +      * MADV_FREE anonymous folios are put into inactive file list 
>>> too.
>>> +      * They could be mistakenly treated as file lru. So further anon
>>> +      * test is needed.
>>> +      */
>>> +     if (!folio_is_file_lru(folio) ||
>>> +             (folio_test_anon(folio) && 
>>> !folio_test_swapbacked(folio)))
>>> +             goto out;
>>> +
>>> +     if (folio_test_dirty(folio) &&
>>> +             (!current_is_kswapd() ||
>>> +              !folio_test_reclaim(folio) ||
>>> +              !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
>>> +             /*
>>> +              * Immediately reclaim when written back.
>>> +              * Similar in principle to folio_deactivate()
>>> +              * except we already have the folio isolated
>>> +              * and know it's dirty
>>> +              */
>>> +             node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
>>> +                     folio_nr_pages(folio));
>>> +             folio_set_reclaim(folio);
>>> +
>>> +             ret = false;
>>> +     }
>>> +
>>> +out:
>>> +     return ret;
>>> +}
>>> +
>>>   static struct folio *alloc_demote_folio(struct folio *src,
>>>               unsigned long private)
>>>   {
>>> @@ -1078,6 +1116,12 @@ static unsigned int shrink_folio_list(struct 
>>> list_head *folio_list,
>>>               if (dirty && !writeback)
>>>                       stat->nr_unqueued_dirty += nr_pages;
>>>
>>> +             /* If the dirty folio dose not support pageout,
>>> +              * the dirty folio can skip this recycling.
>>> +              */
>>> +             if (!folio_check_pageout(folio, pgdat))
>>> +                     goto activate_locked;
>>> +
>>>               /*
>>>                * Treat this folio as congested if folios are cycling
>>>                * through the LRU so quickly that the folios marked
>>> @@ -1261,43 +1305,6 @@ static unsigned int shrink_folio_list(struct 
>>> list_head *folio_list,
>>>                       enum ttu_flags flags = TTU_BATCH_FLUSH;
>>>                       bool was_swapbacked = 
>>> folio_test_swapbacked(folio);
>>>
>>> -                     if (folio_test_dirty(folio)) {
>>> -                             /*
>>> -                              * Only kswapd can writeback 
>>> filesystem folios
>>> -                              * to avoid risk of stack overflow. 
>>> But avoid
>>> -                              * injecting inefficient single-folio 
>>> I/O into
>>> -                              * flusher writeback as much as 
>>> possible: only
>>> -                              * write folios when we've encountered 
>>> many
>>> -                              * dirty folios, and when we've 
>>> already scanned
>>> -                              * the rest of the LRU for clean 
>>> folios and see
>>> -                              * the same dirty folios again (with 
>>> the reclaim
>>> -                              * flag set).
>>> -                              */
>>> -                             if (folio_is_file_lru(folio) &&
>>> -                                     (!current_is_kswapd() ||
>>> - !folio_test_reclaim(folio) ||
>>> -                                      !test_bit(PGDAT_DIRTY, 
>>> &pgdat->flags))) {
>>> -                                     /*
>>> -                                      * Immediately reclaim when 
>>> written back.
>>> -                                      * Similar in principle to 
>>> folio_deactivate()
>>> -                                      * except we already have the 
>>> folio isolated
>>> -                                      * and know it's dirty
>>> -                                      */
>>> - node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
>>> - nr_pages);
>>> - folio_set_reclaim(folio);
>>> -
>>> -                                     goto activate_locked;
>>> -                             }
>>> -
>>> -                             if (references == FOLIOREF_RECLAIM_CLEAN)
>>> -                                     goto keep_locked;
>>> -                             if (!may_enter_fs(folio, sc->gfp_mask))
>>> -                                     goto keep_locked;
>>> -                             if (!sc->may_writepage)
>>> -                                     goto keep_locked;
>>> -                     }
>>> -
>>>                       if (folio_test_pmd_mappable(folio))
>>>                               flags |= TTU_SPLIT_HUGE_PMD;
>>>
>>> @@ -1323,6 +1330,28 @@ static unsigned int shrink_folio_list(struct 
>>> list_head *folio_list,
>>>
>>>               mapping = folio_mapping(folio);
>>>               if (folio_test_dirty(folio)) {
>>> +                     /*
>>> +                      * Only kswapd can writeback filesystem folios
>>> +                      * to avoid risk of stack overflow. But avoid
>>> +                      * injecting inefficient single-folio I/O into
>>> +                      * flusher writeback as much as possible: only
>>> +                      * write folios when we've encountered many
>>> +                      * dirty folios, and when we've already scanned
>>> +                      * the rest of the LRU for clean folios and see
>>> +                      * the same dirty folios again (with the reclaim
>>> +                      * flag set).
>>> +                      */
>>> +                     if (folio_is_file_lru(folio) &&
>>> +                             !folio_check_pageout(folio, pgdat))
>>> +                             goto activate_locked;
>>> +
>>> +                     if (references == FOLIOREF_RECLAIM_CLEAN)
>>> +                             goto keep_locked;
>>> +                     if (!may_enter_fs(folio, sc->gfp_mask))
>>> +                             goto keep_locked;
>>> +                     if (!sc->may_writepage)
>>> +                             goto keep_locked;
>>> +
>>>                       /*
>>>                        * Folio is dirty. Flush the TLB if a writable 
>>> entry
>>>                        * potentially exists to avoid CPU writes 
>>> after I/O
>>
>> I'm confused. Did you apply this on top of v1 by accident?
> Hi,
> According to my modified mm_vmscan_lru_shrink_inactive test tracelog, 
> in the 32 scanned inactive file pages, 20 were dirty, and the 20 dirty 
> pages were not reclamed, but they took 20us to perform try_to_unmap.
>
> I think unreclaimed dirty folio in inactive file lru can skip to 
> perform try_to_unmap. Please help to continue review. Thanks.
>
> kswapd0-99      (     99) [005] .....   687.793724: 
> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 scan=32 isolate=32 
> reclamed=12 nr_dirty=20 nr_unqueued_dirty=20 nr_writeback=0 
> nr_congested=0 nr_immediate=0 nr_activate[0]=0 nr_activate[1]=20 
> nr_ref_keep=0 nr_unmap_fail=0 priority=2 
> file=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC total=39 exe=0 reference_cost=5 
> reference_exe=0 unmap_cost=21 unmap_exe=0 dirty_unmap_cost=20 
> dirty_unmap_exe=0 pageout_cost=0 pageout_exe=0
>
To supplement, I think the unreclaimed dirty folio of the inactive file 
lru in shrink_folio_list() can exit the recyling flow in advance and 
avoid to execute some time-consuming interfaces, such as 
folio_check_references() and try_to_unmap().
>> -- 
>> Cheers,
>>
>> David / dhildenb
>>
>

