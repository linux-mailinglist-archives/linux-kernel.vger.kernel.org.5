Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFAE7F52B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjKVVgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjKVVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:36:16 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2065.outbound.protection.outlook.com [40.92.50.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E028D42
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMtbjaaU9gJXbHUlxBzoNrHU+4xL9zEMSW9HTzVcrTJLNvY6KZWmnP7M+gkjrZx64pC/ZoalkLIn69VwF5xvdGbcZwxiIlCQoqR0K6fSzuYFDAMWsYSRCA7plpiDby4cnVcIKMRuLgXxaD3RPgpxNXM3MRlgPGcIhfPx9N+ys/J1vy2mCbsnEvWKUoeVhFoEjYi8d+n6l+FxUvH1f6YriEEivir5CVrFDpOX7Sl4nuRDmoSFGm2pwpkW161wuWzY8ppaaEBjbScI+JbkV2cHTnmyOMkbVOizIRjRrW4t9gwbPNk743ZG23PWH1fcK2CB8JJrwocubGxugur2KofzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSqcW9CLX5X/DMZdqxALz09AR/LoG2nzJ0XH/yk6QwU=;
 b=eRsxFHV9oVsAy0GlJYXINc9HQgE4/L6m7SBuGePpeeqS9LQv1l3plISoenvF/efW58ZE6yRUFgNnvftCFIJtdw2VMkkCMAooyGVA+dOewimMoDmhxP94iXsNs9lFdww2JMnvqEa2A7R4Z3JKP9jkh/snsEhbEyUR8yUYJ7LSRPId3ANYPcbsa9PS4Fxycx8iuW35T2fDEmP3nQYrluL9fdSpYm6H+oXHo4I4v9+C1sKiWuKLKosgk4AC1/OyOQzSzlDe1m0GebKWosK4upSOewqJOGUFqiA6NC0l+GxouVi50ldpe7F+JYdwZTrxeWxW3h18BScrSuGhNJSl6PhUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSqcW9CLX5X/DMZdqxALz09AR/LoG2nzJ0XH/yk6QwU=;
 b=t4hJeKLH87rahXjf8IQgV+sh+75EXG8a2rdKE/hvMZ4FeKS2IMWaH8RayOAlNLqigt3dt/wtF24k4ylPgY4+mitcwRwlaTVyU2djtmY/NX16dK/x8AHRzfy6zyyHkzAvKzjNzwEI0K0uP7jHi/FBmVjLncUKkHgj0HPwF8GQtyW+IYCueNDyaHf2xyxqP7vXqiwgQ1tVPbich4feZRMybruZENYEdapsnEPzHabEQ1KrEfgazCbWXUQDaNV8Nkr7A2XFRSOqJKhI9wJ4U3fSfwdB11mejixaX29CNImHWgcbPQ1v728s5u5k54UtUPKbLmQt2X3B6cgZr/6iyoEmfA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AM8P193MB1041.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Wed, 22 Nov
 2023 21:36:09 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%5]) with mapi id 15.20.7025.020; Wed, 22 Nov 2023
 21:36:09 +0000
Message-ID: <VI1P193MB0752E3CA6B2660860BD3923D99BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Thu, 23 Nov 2023 05:36:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kfence: Replace local_clock() with
 ktime_get_boot_fast_ns()
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <VI1P193MB0752A2F21C050D701945B62799BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CANpmjNPvDhyEcc0DdxrL8hVd0rZ-J4k95R5M5AwoeSotg-HCVg@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CANpmjNPvDhyEcc0DdxrL8hVd0rZ-J4k95R5M5AwoeSotg-HCVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [ARpD+7jaLWsVwXQ6CNIBsaM+1KFXvjcn]
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <db5cd581-d646-4a01-8aff-a166e9bed259@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AM8P193MB1041:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cf1ad8-294e-48dd-42db-08dbeba30a65
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSOu6HuNHaUdDZ78UidPyHkGa76MJPWXToqWn+ul60UQO3Foa4OJzLNUv6Ge6F03/J5enoKoXSvhh4XQfKZsTCWhxmU184lX4rUDKWaBaIH56yxwuZm+3BwHkym9XnxidS3KOUEETK1YNTKyt9JOuPPU4Orn+ZDdJSn9V4XNATDD8F70KWFxsZcXCB0goGl4KaPX+s+uYnwXoScw9VLze8YyojweqLC7drOV04u6w/8itmvevidayUljMA/AzNi0Mjh+igB/D2ID2v0utv6iyBMZ+CC1th+jTEsPFzpTK2wqp2KZ6tS5aW5GnoBGO8fnGPF62xxSnLLLpAxhkdcXaAYc2q2sbhiObG9WCvWwBYYgRITSGe1kG6tEIuACFG5lIuyLpF/0Yq2w1dEvKUulsZuHTKlBwcf5LXKGwCR7Zlx/FSbapfOGx9bKm4oXBM+n9YgfSDKzQFIfo4jYpJDQeSaxcg6cDKFaGMnDgzPTVKYRF59tZGfKoo32pXmT2e6EsVvlVOurqYcBXSCOlHjPJubAev3ZVV6TXXPtqSk4OyzOXaplpKdrdfsqzFTciKSu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE00ajQ3Z01sanB5U0pWWnRUY3FpcG42aHJwYzFBMWxUaXNhTXpWbXNZZzR2?=
 =?utf-8?B?RTRZTDMrYXZiTitXa0ovR1FDUWI4SUZrTVUvd1RiTFN3MklNenFSUTJkQ01H?=
 =?utf-8?B?MzJHaXBGY08vbVh2MTdDdmFma2FKZTVBTCtRWEdlcXFDQkZ4QWlOSjVNUVBm?=
 =?utf-8?B?V1kzWFNwSlJnczBkcUxFTHVraTk4WENhWFgzVXBtS0ptUzJWd0NuN0FwUG9x?=
 =?utf-8?B?V29pSFlIajNiVGNZL2Rjbk0zVUJXaXFvWnprbXAvTkFPZFlNeVBvN05Sc1Y3?=
 =?utf-8?B?WUZzMmZuRStDeHRUcUlPTWVOdzJ0K04rVHF3azNyem5BdlNkaWtaSU5uYVB4?=
 =?utf-8?B?bCtRYUt3SGZZWmdHWGFtZ0lndG51QmZ0SmVRNkpSazJQMjJUb0IvTFhod2lT?=
 =?utf-8?B?cUV4ZmlJRmlWNzBBWFk0L1JQZDB2TVlVU3d1RjNIYmgvNjZnRUJNMWF5LzVs?=
 =?utf-8?B?Y0VDZXRvSy9POTF6U0hzZWh6T3kzS3Y2SlZ4UGVSVEFrRmNIbFhxQjVldFRn?=
 =?utf-8?B?ell1d1VXUGIzTFdrTUhXWHdjdktjcnBzcko3TGFhMkp5dHdQTUxVRDg1Tnp4?=
 =?utf-8?B?TExsUFhTNzNDaW5sNFdsZGk2UFV0emhGOTRjUXo2dDhMTDQwUk9ReDR6dTA5?=
 =?utf-8?B?eVBtZkVTMXJLbHd3dVRMRVFjM1FVODhLYWE3TzR6aGJMd2hTWGRUb0VvSEcy?=
 =?utf-8?B?b1piYnJxOXBzbENrSkFxc3YwQkRFbitNS0dYRUcwYlZuNHRSWWlVNTFiTU03?=
 =?utf-8?B?RFdyaTdUc0ozTzkzcHNUdU5VbnpWdFZxNFduQkFzOXcyT2Z5WFIwbllTTFdq?=
 =?utf-8?B?Q2FVTldZTGQ0OTVybUhVaHVrc0dROVEwa0RONTZWemwydXZQWGx4QjdqRmJL?=
 =?utf-8?B?NE9mU3hLZ0g4bWpaNW1weUJoWmVzUGFWaXR1c25peUc2TmNVTFFpVDhoVzF3?=
 =?utf-8?B?aGZIVlV4WDhyZ3JjcEtjOXg1NjREb3JVSmZOZ3FlcVg4RXBXcld3djBwVlFh?=
 =?utf-8?B?VEgyWXNia0d3b1cwd29wMk9vZWJHS1BxeEZNNmFMRlEwRmVGajdyeUkrOWdo?=
 =?utf-8?B?Q1FxVG91N2FlRWZYTU9iY2FHczloN3dqZnlVVVpNZFFremEwdVZqVnBZaFdK?=
 =?utf-8?B?N0Q1VGQxM1lyMllxc1lyL3ZlRXRWdHVlbTVwUmNQaXRsRnpWZ1RNSEUxc0Vr?=
 =?utf-8?B?aWQySUpwdElKbHVOR0hHeStvNlRoUHdMdDJYVVRuUVdKSGY4NFA4dFkyQjMy?=
 =?utf-8?B?Y2wvL2hnbWNEVndSMWZGemNNWHBIOGgyQm5YMklBUTlJK0o4cy80bTAwaTVO?=
 =?utf-8?B?a1UyOHNqeS9idEtvb2pjanU0VXVzdE8ybm55SnFVY3V2T2x2STBWdFNKcTM5?=
 =?utf-8?B?UVJadjI2UndPVHBUM1ZwVXJ5ZWVpSzJFa2lrWThZY2V5N1pWeVpFd2NwSGkx?=
 =?utf-8?B?TmFtdkVvdnZlazZlZi9IQUFNM1pCRGdsdjI0M21OeEkyVmZvZkRaU2xlUXJy?=
 =?utf-8?B?Wmx2RmNEUzlIUjltQ2NJWmRvQWxHL0lmWlBCeTV5RHBLYkE1eTc0LzJjMGtp?=
 =?utf-8?B?Rlp0Q2REbzA1dVFEOTM4ZmFSMHRsWUVlaTkzUFV3bFN1K01JT0NIYWt0SkFF?=
 =?utf-8?Q?HyDoPnyDFSv5BveIzkwx9Q+bujTAthngLbDKvcsL80oc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cf1ad8-294e-48dd-42db-08dbeba30a65
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:36:09.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1041
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

On 2023/11/23 4:35, Marco Elver wrote:
> On Wed, 22 Nov 2023 at 21:01, Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> The time obtained by local_clock() is the local CPU time, which may
>> drift between CPUs and is not suitable for comparison across CPUs.
>>
>> It is possible for allocation and free to occur on different CPUs,
>> and using local_clock() to record timestamps may cause confusion.
> 
> The same problem exists with printk logging.
> 
>> ktime_get_boot_fast_ns() is based on clock sources and can be used
>> reliably and accurately for comparison across CPUs.
> 
> You may be right here, however, the choice of local_clock() was
> deliberate: it's the same timestamp source that printk uses.
> 
> Also, on systems where there is drift, the arch selects
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK (like on x86) and the drift is
> generally bounded.
> 
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   mm/kfence/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>> index 3872528d0963..041c03394193 100644
>> --- a/mm/kfence/core.c
>> +++ b/mm/kfence/core.c
>> @@ -295,7 +295,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
>>          track->num_stack_entries = num_stack_entries;
>>          track->pid = task_pid_nr(current);
>>          track->cpu = raw_smp_processor_id();
>> -       track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
>> +       track->ts_nsec = ktime_get_boot_fast_ns();
> 
> You have ignored the comment placed here - now it's no longer the same
> source as printk timestamps. I think not being able to correlate
> information from KFENCE reports with timestamps in lines from printk
> is worse.
> 
> For now, I have to Nack: Unless you can prove that
> ktime_get_boot_fast_ns() can still be correlated with timestamps from
> printk timestamps, I think this change only trades one problem for
> another.
> 
> Thanks,
> -- Marco

Honestly, the possibility of accurately matching a message in the printk
log by the timestamp in the kfence report is very low, since allocation
and free do not directly correspond to a certain event.

Since time drifts across CPUs, timestamps may be different even if
allocation and free can correspond to a certain event.

If we really need to find the relevant printk logs by the timestamps in
the kfence report, all we can do is to look for messages that are within
a certain time range.

If we are looking for messages in a certain time range, there is not
much difference between local_clock() and ktime_get_boot_fast_ns().

Also, this patch is in preparation for my next patch.

My next patch is to show the PID, CPU number, and timestamp when the
error occurred, in this case time drift from different CPUs can
cause confusion.

For example, use-after-free caused by a subtle race condition, in which
the time between the free and the error occur will be very close.

Time drift from different CPUs may cause it to appear in the report that
the error timestamp precedes the free timestamp.
