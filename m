Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE47FA831
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjK0Rgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjK0Rgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:36:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2017.outbound.protection.outlook.com [40.92.89.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A74B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:36:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekNi5v4fKa5poQXatde8b2z2eUDAQEhlWhtnpac+KUcAtVM8VvfiAOIIQ2daSa7dJ1RuipYClVBwOwN9ymV/+bMegjTdIfpkCNRVT4p7xjXJlpWBaMIpgibhQnPKAG4r6+4ebZP+RM4CFRrLo46IpDfcvGg3Hu8C2vujRbgpAkalnQ0RuPLwfwp0UZJ8s1LxWJfd1hOtDPaTrOW2DMXQ3Li5bO8SwZQY0vjhcmOzbStCvgDFqUAr8gn2uoNW2O07I0Dn7x9r2gPv/3aiyLbiv8iHoOhDSm2GCfxhp4JGhe0oVVty/2cUoUpcCzug0baxMdklpDCdbqE0WWOxKSbdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKhQnC4FfGM11h1OfvjDehUSpO6gPJ4z7NsVFLHDQG8=;
 b=VB31Fzr5y3ztLWXSTdBKxGR5s/Ry+PsWCFdJm8mo3JLm44JTNMEB1ywC8/p5Ao/cXmtuTiDdBBcmBQZ0x1+JBWHWGADDcqYQfJMxg2KDv9CdmSapbsqHGVHCrDHgSWl/CYAA+DNCjPMZqei8neJFujc1JMye4I64fNEZmG++8qP1oEywdCOVHiRp0Z2nc+Cchl4lO/xRaUrttASzLNN+JHL6BTcZxdwebWVNi8R4HcmUnuPW4cIs/LiMxg1aZ0+qAunwZBVHfPwtyFB7gkFKibzjBzL9kWeH7ezthHerAeen3CFhuHLrodg6PT6KWd3xpWLrqNP2EQTj1DVJZ2XGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKhQnC4FfGM11h1OfvjDehUSpO6gPJ4z7NsVFLHDQG8=;
 b=DdzbBpVozZ526wCA3M1BmqW9nOvMKx78/pXOU8YrjugyNT1K7XMRGGUg+n7jptmq+ebGhL/hWs6Wem5SVlVDUlNStZRblv5842sj2KIAgkJDVeEMw7eCIZ4fWikHxxU9tqgks5cEzdR7y2cDtqn66FUHlPewBTGBzaBLgaDPNMDd1R4y7+8DifxG9sNzd2BGnOocpX8To6Nw/JF7O5/ykAmQv1UoZK40WklHAR2SlBYUqMTxwrqBa6urK0MedU8EdqYbssWFn7m17Iq/+vLPDA3w9s/yhU0rWag0U4hkfk/9LWfZ9IgsHMM54wkavBy+87zPNAoZVYRBqlvOpaZmMA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PAXP193MB1389.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 17:36:55 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:36:55 +0000
Message-ID: <VI1P193MB0752B1A233DACC44EEC7FB8199BDA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Tue, 28 Nov 2023 01:36:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: Record and report more information
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <VI1P193MB07529BC28E5B333A8526BEBD99BEA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+aVjKTxTamnybC9gS7uvSodYjvHst9obo=GjJ_km-_pdw@mail.gmail.com>
 <VI1P193MB0752C5B781EC2A351EDF62CC99BDA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+YDnXD3SeordJ8X6tQO+7nr5VuWVrJ-DUi3BXac0zdVxw@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CACT4Y+YDnXD3SeordJ8X6tQO+7nr5VuWVrJ-DUi3BXac0zdVxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [ChjgQRLRLD84fLTyN4mpH6+bc1bxKGRB]
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <b764f1d2-1546-4e36-8061-5b6c3987ae50@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PAXP193MB1389:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7d07af-8826-4b03-fb5f-08dbef6f72fe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmXJgjGakWI9rfg30GvarQspeDZ9TATdhXW+1u4Q5B38E8hPUdSHmmQLI/vlKYBMT9aszxmegAgujlp4+qFOVieEDkGl3LbcDQZECGDQnGeWyuz4uFp431GMMAA5zJp+qcdmYLWAF+N60PRZ8blkQiFH/5cNF8P7153148cIJAXUP6CcACY25sC1zXczTYnz1vkWu94CF69av77dXFV6MJcIcReAY6xzv9h6r1MiaFviqMtpYPOrRxmxX6P8K94/CxXSh418UutdhHQqGRqzeZ7R9kVq2UjwyR079w1foFx8tM0BMwC6b+EX8uihHNNAkiV4l5R+8sajmqsn3v6Fz/AtRt4e9kGXOZ+sOJ1b3Yx2y2iClcsiMdNM62lfO5Y70FDGZVXwUDEQDd0ju6LbAjCQQM2leP+GSUBm21oTBXIuPhzc+kfvyNwFJag5gJDg22/DB18w9/8qxyYMafb52aED/ry0/Niu6im2cMp7698G+7nsTRn5rr26pJLbm7VSZq97k192b2EdsAQvuR900bcuJWhKcnYLFBAC1CIIzWjMOUPQRYRd8FFuL345joEF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHk2VzRaMklLTGpJeFV5aEx6cmc1Z1ErOUVWdkp4VWl6UFZJWVhWVDhyU1Bq?=
 =?utf-8?B?Z2ZiRUozdGlVZ1luOEFUaUdJc1JJbzlDMW5vQkQrb24yMEFnVVY1ZkRiRnA4?=
 =?utf-8?B?Z2xxK2pST1l1TW9ndzZ2OHV5bGJ6dExjTUZ2TFdwN1dkWTR6TmJOTjJSbTZh?=
 =?utf-8?B?bDhDK1ZOdEdZQ3Q3MWxFclJhWDFtT2V4bzRuQmZpc3JwVm13cHl2RHIvUTVT?=
 =?utf-8?B?SUVnR1BPV2JYb1RURkhwS0N6TXdud0o1YVNHUzJpaTZndEFhSVcwQiszNFJ6?=
 =?utf-8?B?U3FpNE5ya2RacWhjQ0srdFAza2Qvei9ENTgzaXdyM0RXeHkwb1kyUjgrcTBj?=
 =?utf-8?B?NnE3S1RqK0dGWHp3Qkg4bWVmNEpJcFFrbllOb3E3UklyZTg4dDZtdmRFVncx?=
 =?utf-8?B?Tm1kUDQrcHZqQ3F0WTFQaklEM2JUdG5KQ2owYVRDYVUyNkovWG9SNGJpNVpD?=
 =?utf-8?B?Z0xzaHBZZDhraTRrYTJ3NmRUM0l1UUJ3Z0tUaTJ5emo1NG9OUXdzMmJzZVlL?=
 =?utf-8?B?dFZMbS9MeEhiT2dSUmt3WC9jbXljSUowRnZlQ1Zsdkc2R2l1SHdWWHNPS3Rt?=
 =?utf-8?B?c0c4ZHdSczR6eEtmS2pjUHc1dVUzVmFLRkwybmlxa0ZBOVI2S3BmOUYxeFIx?=
 =?utf-8?B?WHV3d3ZRVENlcG8wME43L0ExN1VPdnhMRVZQQll5akc0c09KOGt2ckZibmpn?=
 =?utf-8?B?L2ZXUytMdU8wWGlDYXlnSkJxdnZtMFBnQjhZc1VIR2hHZkJFR3dkdFVGbjRw?=
 =?utf-8?B?Yk10RlpsVWF6MnRNdFBOaU5pdjVHVlZpc1hBaEIxY1MwcHVGaldJUm03Q0JK?=
 =?utf-8?B?MGtGcjkzM3ZLQ1NNaHlycTBtK3VoSmxSQ01zY2p5TXlkWDJLdEtOMS9XMEl6?=
 =?utf-8?B?bXBhQkFVL1h0cVFDUUZoU1hqTS9TaVBRRXJCR1VtLy9NYnJJYnFNdVFZVFcz?=
 =?utf-8?B?U0cySDNtc2h3RXQyNjBRUi93ZGdINXQ0Q2hmVzk0dFBjKzcyZm56eDN0YU4x?=
 =?utf-8?B?bjZjSnNBbnlCb1Ric3hvV3ZIR3Joand1RzBTNm14TktMZWxNNll2L3JZTGJE?=
 =?utf-8?B?c3RqajArdW91MVRLVmM1VnNrT1A1WjZCN21qNVJMc2tERWJJOG9OeFArUWRw?=
 =?utf-8?B?UCtpek5NdXpBU2pjYmgxVEhyVGkyeXdzZXdXL0hBbDUvSHRGaXBEK3EzT2tX?=
 =?utf-8?B?ZW5yUHNEWHJJcjh2U0FtQ3ZpNXU2WG5yTGowK0xFVytpRDVibkxNMklnWmph?=
 =?utf-8?B?TEhxYnQ1aTZYSEVzaE5sVjMzTDYyWjY1Yy9Yd3g5c090Z2pXMXhpL0ZIazZ5?=
 =?utf-8?B?N3k2Zkw4cUZPRmhLRGVnZk1VSE90SVZUUlQ1WVdsQ2JWeTk3RHNWbHlWNEFl?=
 =?utf-8?B?Rk5aeHhkWnZQUlM4cVVZOWlHRTNOaG5aSnhubDNNL1JqRCswcXlYMi94V0Zu?=
 =?utf-8?B?SGoyNVN0SGI2TFhhUGROZ2czMEtJMzJoNTlFL2R2Q29IZVdsZGVod25wdWVj?=
 =?utf-8?B?S1lCOW82M25Nb0MwQVlEOGhnbjR1ZFJsaVJYRjBzNlBzbUpyNjUxZis3WlRG?=
 =?utf-8?B?NVpiK2xFTVltdVNtaGdxckg3Y1VXSW5GN2h3QmtKN1l6K0ZqSmUwVXMvZVI0?=
 =?utf-8?Q?BRjb1K9GT6p3jnzR0451gpvTWyT76G4BlwtYzz9tsjT4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7d07af-8826-4b03-fb5f-08dbef6f72fe
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:36:55.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1389
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/27 17:38, Dmitry Vyukov wrote:
> On Mon, 27 Nov 2023 at 10:35, Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2023/11/27 12:34, Dmitry Vyukov wrote:
>>> On Sun, 26 Nov 2023 at 23:25, Juntong Deng <juntong.deng@outlook.com> wrote:
>>>>
>>>> Record and report more information to help us find the cause of the
>>>> bug and to help us correlate the error with other system events.
>>>>
>>>> This patch adds recording and showing CPU number and timestamp at
>>>> allocation and free (controlled by CONFIG_KASAN_EXTRA_INFO). The
>>>> timestamps in the report use the same format and source as printk.
>>>>
>>>> Error occurrence timestamp is already implicit in the printk log,
>>>> and CPU number is already shown by dump_stack_lvl, so there is no
>>>> need to add it.
>>>>
>>>> In order to record CPU number and timestamp at allocation and free,
>>>> corresponding members need to be added to the relevant data structures,
>>>> which will lead to increased memory consumption.
>>>>
>>>> In Generic KASAN, members are added to struct kasan_track. Since in
>>>> most cases, alloc meta is stored in the redzone and free meta is
>>>> stored in the object or the redzone, memory consumption will not
>>>> increase much.
>>>>
>>>> In SW_TAGS KASAN and HW_TAGS KASAN, members are added to
>>>> struct kasan_stack_ring_entry. Memory consumption increases as the
>>>> size of struct kasan_stack_ring_entry increases (this part of the
>>>> memory is allocated by memblock), but since this is configurable,
>>>> it is up to the user to choose.
>>>>
>>>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>>>> ---
>>>> V1 -> V2: Use bit field to reduce memory consumption. Add more detailed
>>>> config help. Cancel printing of redundant error occurrence timestamp.
>>>>
>>>>    lib/Kconfig.kasan      | 21 +++++++++++++++++++++
>>>>    mm/kasan/common.c      | 10 ++++++++++
>>>>    mm/kasan/kasan.h       | 10 ++++++++++
>>>>    mm/kasan/report.c      |  6 ++++++
>>>>    mm/kasan/report_tags.c | 16 ++++++++++++++++
>>>>    mm/kasan/tags.c        | 17 +++++++++++++++++
>>>>    6 files changed, 80 insertions(+)
>>>>
>>>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>>>> index 935eda08b1e1..8653f5c38be7 100644
>>>> --- a/lib/Kconfig.kasan
>>>> +++ b/lib/Kconfig.kasan
>>>> @@ -207,4 +207,25 @@ config KASAN_MODULE_TEST
>>>>             A part of the KASAN test suite that is not integrated with KUnit.
>>>>             Incompatible with Hardware Tag-Based KASAN.
>>>>
>>>> +config KASAN_EXTRA_INFO
>>>> +       bool "Record and report more information"
>>>> +       depends on KASAN
>>>> +       help
>>>> +         Record and report more information to help us find the cause of the
>>>> +         bug and to help us correlate the error with other system events.
>>>> +
>>>> +         Currently, the CPU number and timestamp are additionally
>>>> +         recorded for each heap block at allocation and free time, and
>>>> +         8 bytes will be added to each metadata structure that records
>>>> +         allocation or free information.
>>>> +
>>>> +         In Generic KASAN, each kmalloc-8 and kmalloc-16 object will add
>>>> +         16 bytes of additional memory consumption, and each kmalloc-32
>>>> +         object will add 8 bytes of additional memory consumption, not
>>>> +         affecting other larger objects.
>>>> +
>>>> +         In SW_TAGS KASAN and HW_TAGS KASAN, depending on the stack_ring_size
>>>> +         boot parameter, it will add 8 * stack_ring_size bytes of additional
>>>> +         memory consumption.
>>>> +
>>>>    endif # KASAN
>>>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>>>> index b5d8bd26fced..2f0884c762b7 100644
>>>> --- a/mm/kasan/common.c
>>>> +++ b/mm/kasan/common.c
>>>> @@ -20,6 +20,7 @@
>>>>    #include <linux/module.h>
>>>>    #include <linux/printk.h>
>>>>    #include <linux/sched.h>
>>>> +#include <linux/sched/clock.h>
>>>>    #include <linux/sched/task_stack.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/stackdepot.h>
>>>> @@ -49,6 +50,15 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
>>>>
>>>>    void kasan_set_track(struct kasan_track *track, gfp_t flags)
>>>>    {
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       u32 cpu = raw_smp_processor_id();
>>>> +       u64 ts_nsec = local_clock();
>>>> +       unsigned long rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
>>>> +
>>>> +       track->cpu = cpu;
>>>> +       track->ts_sec = ts_nsec;
>>>> +       track->ts_usec = rem_usec;
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>           track->pid = current->pid;
>>>>           track->stack = kasan_save_stack(flags,
>>>>                           STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
>>>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>>>> index b29d46b83d1f..2a37baa4ce2f 100644
>>>> --- a/mm/kasan/kasan.h
>>>> +++ b/mm/kasan/kasan.h
>>>> @@ -187,6 +187,11 @@ static inline bool kasan_requires_meta(void)
>>>>    struct kasan_track {
>>>>           u32 pid;
>>>>           depot_stack_handle_t stack;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       u64 cpu:20;
>>>> +       u64 ts_sec:22;
>>>> +       u64 ts_usec:22;
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>    };
>>>>
>>>>    enum kasan_report_type {
>>>> @@ -278,6 +283,11 @@ struct kasan_stack_ring_entry {
>>>>           u32 pid;
>>>>           depot_stack_handle_t stack;
>>>>           bool is_free;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       u64 cpu:20;
>>>> +       u64 ts_sec:22;
>>>> +       u64 ts_usec:22;
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>    };
>>>>
>>>>    struct kasan_stack_ring {
>>>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>>>> index e77facb62900..8cd8f6e5cf24 100644
>>>> --- a/mm/kasan/report.c
>>>> +++ b/mm/kasan/report.c
>>>> @@ -262,7 +262,13 @@ static void print_error_description(struct kasan_report_info *info)
>>>>
>>>>    static void print_track(struct kasan_track *track, const char *prefix)
>>>>    {
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       pr_err("%s by task %u on cpu %d at %u.%06us:\n",
>>>> +                       prefix, track->pid, track->cpu,
>>>> +                       track->ts_sec, track->ts_usec);
>>>> +#else
>>>>           pr_err("%s by task %u:\n", prefix, track->pid);
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>           if (track->stack)
>>>>                   stack_depot_print(track->stack);
>>>>           else
>>>> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
>>>> index 55154743f915..bf895b1d2dc2 100644
>>>> --- a/mm/kasan/report_tags.c
>>>> +++ b/mm/kasan/report_tags.c
>>>> @@ -27,6 +27,16 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
>>>>           return "invalid-access";
>>>>    }
>>>>
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +static void kasan_complete_extra_report_info(struct kasan_track *track,
>>>> +                                        struct kasan_stack_ring_entry *entry)
>>>> +{
>>>> +       track->cpu = entry->cpu;
>>>> +       track->ts_sec = entry->ts_sec;
>>>> +       track->ts_usec = entry->ts_usec;
>>>> +}
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>> +
>>>>    void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>>>    {
>>>>           unsigned long flags;
>>>> @@ -73,6 +83,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>>>
>>>>                           info->free_track.pid = entry->pid;
>>>>                           info->free_track.stack = entry->stack;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +                       kasan_complete_extra_report_info(&info->free_track, entry);
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>                           free_found = true;
>>>>
>>>>                           /*
>>>> @@ -88,6 +101,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>>>
>>>>                           info->alloc_track.pid = entry->pid;
>>>>                           info->alloc_track.stack = entry->stack;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +                       kasan_complete_extra_report_info(&info->alloc_track, entry);
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>                           alloc_found = true;
>>>>
>>>>                           /*
>>>> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
>>>> index 739ae997463d..c172e115b9bb 100644
>>>> --- a/mm/kasan/tags.c
>>>> +++ b/mm/kasan/tags.c
>>>> @@ -13,6 +13,7 @@
>>>>    #include <linux/memblock.h>
>>>>    #include <linux/memory.h>
>>>>    #include <linux/mm.h>
>>>> +#include <linux/sched/clock.h>
>>>>    #include <linux/stackdepot.h>
>>>>    #include <linux/static_key.h>
>>>>    #include <linux/string.h>
>>>> @@ -93,6 +94,19 @@ void __init kasan_init_tags(void)
>>>>           }
>>>>    }
>>>>
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +static void save_extra_info(struct kasan_stack_ring_entry *entry)
>>>> +{
>>>> +       u32 cpu = raw_smp_processor_id();
>>>> +       u64 ts_nsec = local_clock();
>>>> +       unsigned long rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
>>>> +
>>>> +       entry->cpu = cpu;
>>>> +       entry->ts_sec = ts_nsec;
>>>> +       entry->ts_usec = rem_usec;
>>>
>>> I would timestamp as a single field in all structs and convert it to
>>> sec/usec only when we print it. It would make all initialization and
>>> copying shorter. E.g. this function can be just:
>>>
>>>          entry->cpu = raw_smp_processor_id();
>>>          entry->timestamp = local_clock() / 1024;
>>>
>>> Dividing by 1024 is much faster and gives roughly the same precision.
>>> This can be unscaled during reporting:
>>>
>>>          u64 sec = entry->timestamp * 1024;
>>>          unsigned long usec = do_div(sec, NSEC_PER_SEC) / 1000;
>>>
>>> But otherwise the patch looks good to me.
>>>
>>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>>>
>>
>>
>> I think it would be better to use left shift and right shift because
>> dropping the last 3 bits would not affect the microsecond part and
>> would not affect the precision at all.
>>
>> In addition, 44 bits are enough to store the maximum value of the
>> displayable time 99999.999999 (5-bit seconds + 6-bit microseconds).
>>
>> 010110101111001100010000011110100011111111111111 (99999.999999) >> 3
>> = 10110101111001100010000011110100011111111111 (44 bits)
>>
>> I will send the V3 patch.
> 
> Agree.
> Modern compilers are smart enough to turn division/multiplication by
> pow-2 const into necessary shift, so we may not obfuscate the code.
> 


In my actual tests, right/left shifting by 3 bits gives a different
result than dividing/multiplying by 1024.

Right/left shifting by 3 bits did not cause loss of precision,
but dividing/multiplying by 1024 did.

I think the compiler did not convert that part of the code very well.

I think using bit shift would be a better option.


> 
>>>> +}
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>> +
>>>>    static void save_stack_info(struct kmem_cache *cache, void *object,
>>>>                           gfp_t gfp_flags, bool is_free)
>>>>    {
>>>> @@ -128,6 +142,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>>>>           entry->pid = current->pid;
>>>>           entry->stack = stack;
>>>>           entry->is_free = is_free;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       save_extra_info(entry);
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>
>>>>           entry->ptr = object;
>>>>
>>>> --
>>>> 2.39.2
>>>>
>>

