Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AEC7F41B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjKVJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKVJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:31:28 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2091.outbound.protection.outlook.com [40.92.57.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E89D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:31:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEQqjBNwXXNk8cH9xEXrxxRWWAI3rxzi/XcLe+EzUIWBxuE3AF49xLz3Gs0X3NHYssje17diUSgYC50jLfpthE6FN8MUP99rtYFJCMwY+oqcPN2fFe++fFd33tLZz0UCorkMyQ5mtvd3o7LY6rzSrCwBPscTbjtfa9fPLA9FpSVJ50V/fAbsgmphMRnrrD5lv/+hyCXUT6W9kpTtFjoNu+AwwYfIE6AjOZgGVBg42gGUAvMTOuCk+Zo73kC5OOQ/jt2SaTPOU0b9N1hnfR32G2tNNPMeWbt4YjRY9L/QIfBs7XBW14AYBgxbCqzYgJSNmc/BBSG8IQPQh1sLIwrUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPIXkEm/xEsL/EC11qE51rwRVlS83/az6sa636j1GNM=;
 b=d8PqnLIMu5/U1EnensTO4OJdCrlloK0ZgdPYA0L16BvdtkICsOgbddfaAeVyd4mrv3bItXQsgJLolasWEwrPTV6u0GjYmWPYKWaAQC+xENaNG6Vii3XfcVSYzylrwhVR6U8tuYV7DR5b1U7RUoH2ffv2nfz4WvlacElMUntIqx6PxNkHWu32H87DP0dZusI5FtSHtImwm9RuGFUXl5D8VnTakRgyO6Sh63KqMTKA3SyisaEcR8c4V6Pktl1H6vAHZe8hoWW3l5sjXNXevQCI5KikD204cagONn0sp2AIqcxnSz/cKo/TfnTEcAkhFMFbXxBOlXBsiQKDacXC4LPA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPIXkEm/xEsL/EC11qE51rwRVlS83/az6sa636j1GNM=;
 b=em30HzhqmHvluPvYRF99mGyJD6XRzBNWHrHy7MsekajWGpw9np9mEBDN4vjr9sZBxxb+XJJt3TusBT93Jn8vJdbARPO5Wah/gpsFzqGTjf3yeyI/K09hKdJhi+t10/7ATNpXcslfuejDL2lp2kBdvlmUfwPVCl81B+BjLs3lCoIXpxoDwRN865QELhA8R6zjM62WsmBa1M/hbV7+Tjun7RvKXXjhE/3WPFw6NnaThXxYVBSuyMx0ewcNFa4Au5PieyHMVbwBz94kYDMVcJzyevH7CaVPFgDyjsGjslbLEYbkztrinRkcVzOnP79lEtPFH6SOA8+oQI5bLyqEnOhI+g==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by GV1P193MB2406.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:1e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 09:31:20 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 09:31:20 +0000
Message-ID: <VI1P193MB0752C8CE08222B9EA4D744F399BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Wed, 22 Nov 2023 17:31:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: Improve free meta storage in Generic KASAN
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <VI1P193MB0752C0ADCF4F90AE8368C0B399BBA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CA+fCnZfBM=UU0AyArERNMxBMeaPvbV-e6uyQDpwgqA5c6_f_DQ@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CA+fCnZfBM=UU0AyArERNMxBMeaPvbV-e6uyQDpwgqA5c6_f_DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [844qAesJ/jBR/CvE/c8M7SmratwBpcuW]
X-ClientProxiedBy: LNXP265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::34) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <63744528-8fc5-4986-b74d-070297b1e6d1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|GV1P193MB2406:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a11d2a1-5303-459c-428d-08dbeb3dc8dd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xGYvrNnRYLRQZ8Cy3YybntJqRVSQSEt7ju4AFjBwvCW0cgwMHhGcsdlK0Dvu7csLsEM2H1zD+pfk3dwWAHOGVQC7Er+npznRRV48l4d0PjRj/WngNwzWW6WKHqs7144HNxbiJqB+v8XHbeJvv9f1cOjq6jsm6zjvQhY5ul9q3TLpgKQMrb3vPnkpjGz8YDjQ7cIWAcPMuLBBay6NbDP4efo1aZ8Hm7XTsH6HdabbDogkZna/NPGkvZHKrGAjJjhVnEqX9l4xPw60ZAe9MCBcEwTCtkvJNsjD0A3Kp8wz3CE+FM/+ctejUeMWYKF1sD2NcT8Sm7ICKyovRGlTADztv9yqQq8WQRXdhvjyOb04mKctZa69FOz7sCYSSgpam67OcsQu1Wc++9c52k3VSB87gYvbhVtjIaHEN5AwWTLqqciOBo829WawseUBHbL1+7ODvqW5pZoyEhwuhdPMHboOo9biVUXiSW/yaUYXiTwqwgFRShRvzaaB/bIj3WRzTPmwePBA98IJI1yXkr3SAJQsUHuBfFVZ/tbTqaslh3L+5/diF/WsQ1nhm5bHhy5Kj8D
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3g1enY3cUdHR2xiMDBWd3dXaUxKTW4xejlISlpSVjVETk0yL2pYbDdiNWps?=
 =?utf-8?B?eUJXaXpEdWJZVUJhYTdncXhzeEZOWVFIaDkrWlMwcVljT1lMNWFUb3lFVjZk?=
 =?utf-8?B?dlBIT0ViWDh6UlJSUlZIMWIrVnpqSkxXZzhFSnR4OWpITExML2pvbXJPd3Rz?=
 =?utf-8?B?djV0UW52Z2FxbExUNVVHWUxSS3ZJcEVWT1ZSQ0Q2aVBENnVlZ0NWZG00MGlm?=
 =?utf-8?B?ZVk5OE9sSHJKd2Q2TkRGYlJIbXk4dS8rY2pDRlRzck5NaVMzbDhDZWs3M2ty?=
 =?utf-8?B?MGN0dDFET3RRNllFZUlvS1dnTGJzWnQ5SHNLN1lRUnVKa1RsTmRFNVpaS2kr?=
 =?utf-8?B?RHBVV284NUxzZlpqRHZibWVNbHlJYzNVRitZbDN4QTVNQkJpVFBValJwS1FO?=
 =?utf-8?B?TGJaUEhyd3Q4OXJhUUh0c2dJMnpCOWZ0a280akV3NmczSHk3UlliTFBPbHVz?=
 =?utf-8?B?KzR1YjVZNkJkTWlRS0IwRy9KK2ttQS9aZThtZVBBWWdSL1JvcmRIU2FNODlV?=
 =?utf-8?B?amhlV2M2dm5zaXh1VGpRVzVEOWJpV3A2UExpR05uN2J6c0xDc0NxSDlZdW5O?=
 =?utf-8?B?dXYxNXZwcFkvUmJwanJReHJrTDZCOG9RbGVDQjNXa2YrNUE4Tjl1K3NsVFNV?=
 =?utf-8?B?QnVqaXVpaFdacmtjZWoxd0phQUxWWHh6SWNrRXpnMWZGLzdtRy92aEMweXoy?=
 =?utf-8?B?aDlkMFBjakh0a1R1bXA2amxjWFM5d1Bna2M2dVkvdGIvTklUSkVucHhHd0kw?=
 =?utf-8?B?dElrbDRONUhCSkZtYU9vaWJVRzNTenN4aW5UN2hPKzVYVk5wT2NCVGNIN21J?=
 =?utf-8?B?ZFBBM09GZVpDT2lwWnE5ekJTdmdLdjFQU1EySmtiYlFTcEIycEFKZFMrbUs2?=
 =?utf-8?B?RmFyVFQ2clBVSEtBdWpTUnduaGJseE9xQ3pFSEpMWFZrZjQ1aHlwZkZQTFNK?=
 =?utf-8?B?ZHFMNTg1bGIvN0hPYkoxb2lMNk9DUWFSTko0NU9mZzdMOFRvVXJoUXQwZC8w?=
 =?utf-8?B?dk80ZkowTDVmUDdCQ3d1djh2L3RWL0loZUhLMjBSdlA4ZmpQODNTMGEwcnpl?=
 =?utf-8?B?cTVyWjdRUllGYlNabHpvL2hJNnZJRmV0SWRhZy9HRWdEQmRncWQ1R01LV3Bk?=
 =?utf-8?B?Z0JYZVhPZzNsTlN5cEdtY0RTUFQ0a0FFSkF4NDMzVWQ5Q28ycmcrRGl2cFdr?=
 =?utf-8?B?N1BLcllVelNSSytkYzNJc3V2Nlc1VnJ3SFNnbjhVWU14TDUreW1oSTA3bWVU?=
 =?utf-8?B?OWlMVFoweGp6OXJGRGdlM3lhNkFlK3pnWDZFQ00rK3pXQlBtN3NsMnRBbDdl?=
 =?utf-8?B?cUJPUHZCU0c4cUlXODU5aGVXbkxqWXgwcmpmODYzRlV3OGhPT2JkemtpZkJ2?=
 =?utf-8?B?bEQ2bU9yZzRTZi9qTUJtSlViRERjbnptRk5yUzFKejZvbTI0NTdtR3gvZTUv?=
 =?utf-8?B?bURJWUJJK0RVZjlZR0hPbE1kMkNJZFlMdmJXOGRmRkUxU1JmU01wVHJxNzdW?=
 =?utf-8?B?b09SeG4yOVBycWRxajhpWXJ4U09nckhkMXBxL2dBSWlTQjg3R0IzVHdKYy9C?=
 =?utf-8?B?b1M4RFZGekJ0bVlLUWlWcDM5YmNWb2RKTUlwWjJnemxRWGNvM1B2ak04NWxM?=
 =?utf-8?Q?tdANndwOI6dSfmdu9BBJbehA2xgif2b9EeC+6qIruuV4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a11d2a1-5303-459c-428d-08dbeb3dc8dd
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:31:20.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2406
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/22 10:27, Andrey Konovalov wrote:
> On Tue, Nov 21, 2023 at 10:42 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> Currently free meta can only be stored in object if the object is
>> not smaller than free meta.
>>
>> After the improvement, even when the object is smaller than free meta,
>> it is still possible to store part of the free meta in the object,
>> reducing the increased size of the redzone.
>>
>> Example:
>>
>> free meta size: 16 bytes
>> alloc meta size: 16 bytes
>> object size: 8 bytes
>> optimal redzone size (object_size <= 64): 16 bytes
>>
>> Before improvement:
>> actual redzone size = alloc meta size + free meta size = 32 bytes
>>
>> After improvement:
>> actual redzone size = alloc meta size + (free meta size - object size)
>>                      = 24 bytes
>>
>> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> 
> I think this change as is does not work well with slub_debug.
> 
> slub_debug puts its metadata (redzone, tracks, and orig_size) right
> after the object (see calculate_sizes and the comment before
> check_pad_bytes). With the current code, KASAN's free meta either fits
> within the object or is placed after the slub_debug metadata and
> everything works well. With this change, KASAN's free meta tail goes
> right past object_size, overlaps with the slub_debug metadata, and
> thus can corrupt it.
> 
> Thus, to make this patch work properly, we need to carefully think
> about all metadatas layout and teach slub_debug that KASAN's free meta
> can go past object_size. Possibly, adjusting s->inuse by the size of
> KASAN's metas (along with moving kasan_cache_create and fixing up
> set_orig_size) would be enough. But I'm not familiar with the
> slub_debug code enough to be sure.
> 
> If you decide to proceed with improving this change, I've left some
> comments for the current code below.
> 
> Thank you!
> 


I delved into the memory layout of SLUB_DEBUG today.

I think a better option would be to let the free meta not pass through
the object when SLUB_DEBUG is enabled.

In other words, the free meta continues to be stored according to the
previous method when SLUB_DEBUG is enabled.

Even if we teach SLUB_DEBUG that KASAN's free meta may pass through the
object and move SLUB_DEBUG's metadata backward, it still destroys the
original design intent of SLUB_DEBUG.

Because SLUB_DEBUG checks for out-of-bounds by filling the redzones
on both sides of the object with magic number, if SLUB_DEBUG's redzones
move backward, leaving a gap, that will break the out-of-bounds
checking.

I will send patch V3 to fix this issue.


>> ---
>> V1 -> V2: Make kasan_metadata_size() adapt to the improved
>> free meta storage
>>
>>   mm/kasan/generic.c | 50 +++++++++++++++++++++++++++++++---------------
>>   1 file changed, 34 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
>> index 4d837ab83f08..802c738738d7 100644
>> --- a/mm/kasan/generic.c
>> +++ b/mm/kasan/generic.c
>> @@ -361,6 +361,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>>   {
>>          unsigned int ok_size;
>>          unsigned int optimal_size;
>> +       unsigned int rem_free_meta_size;
>> +       unsigned int orig_alloc_meta_offset;
>>
>>          if (!kasan_requires_meta())
>>                  return;
>> @@ -394,6 +396,9 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>>                  /* Continue, since free meta might still fit. */
>>          }
>>
>> +       ok_size = *size;
>> +       orig_alloc_meta_offset = cache->kasan_info.alloc_meta_offset;
>> +
>>          /*
>>           * Add free meta into redzone when it's not possible to store
>>           * it in the object. This is the case when:
>> @@ -401,21 +406,26 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>>           *    be touched after it was freed, or
>>           * 2. Object has a constructor, which means it's expected to
>>           *    retain its content until the next allocation, or
> 
> Please drop "or" on the line above.
> 
>> -        * 3. Object is too small.
>>           * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
>> +        * Even if the object is smaller than free meta, it is still
>> +        * possible to store part of the free meta in the object.
>>           */
>> -       if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
>> -           cache->object_size < sizeof(struct kasan_free_meta)) {
>> -               ok_size = *size;
>> -
>> +       if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
>>                  cache->kasan_info.free_meta_offset = *size;
>>                  *size += sizeof(struct kasan_free_meta);
>> +       } else if (cache->object_size < sizeof(struct kasan_free_meta)) {
>> +               rem_free_meta_size = sizeof(struct kasan_free_meta) -
>> +                                                               cache->object_size;
>> +               *size += rem_free_meta_size;
>> +               if (cache->kasan_info.alloc_meta_offset != 0)
>> +                       cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
>> +       }
>>
>> -               /* If free meta doesn't fit, don't add it. */
>> -               if (*size > KMALLOC_MAX_SIZE) {
>> -                       cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
>> -                       *size = ok_size;
>> -               }
>> +       /* If free meta doesn't fit, don't add it. */
>> +       if (*size > KMALLOC_MAX_SIZE) {
>> +               cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
>> +               cache->kasan_info.alloc_meta_offset = orig_alloc_meta_offset;
>> +               *size = ok_size;
>>          }
>>
>>          /* Calculate size with optimal redzone. */
>> @@ -464,12 +474,20 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
>>          if (in_object)
>>                  return (info->free_meta_offset ?
>>                          0 : sizeof(struct kasan_free_meta));
> 
> This needs to be changed as well to something like min(cache->object,
> sizeof(struct kasan_free_meta)). However, with the slub_debug
> conflicts I mentioned above, we might need to change this to something
> else.
> 
> 
> 
>> -       else
>> -               return (info->alloc_meta_offset ?
>> -                       sizeof(struct kasan_alloc_meta) : 0) +
>> -                       ((info->free_meta_offset &&
>> -                       info->free_meta_offset != KASAN_NO_FREE_META) ?
>> -                       sizeof(struct kasan_free_meta) : 0);
>> +       else {
>> +               size_t alloc_meta_size = info->alloc_meta_offset ?
>> +                                                               sizeof(struct kasan_alloc_meta) : 0;
>> +               size_t free_meta_size = 0;
>> +
>> +               if (info->free_meta_offset != KASAN_NO_FREE_META) {
>> +                       if (info->free_meta_offset)
>> +                               free_meta_size = sizeof(struct kasan_free_meta);
>> +                       else if (cache->object_size < sizeof(struct kasan_free_meta))
>> +                               free_meta_size = sizeof(struct kasan_free_meta) -
>> +                                                                       cache->object_size;
>> +               }
>> +               return alloc_meta_size + free_meta_size;
>> +       }
>>   }
>>
>>   static void __kasan_record_aux_stack(void *addr, bool can_alloc)
>> --
>> 2.39.2

