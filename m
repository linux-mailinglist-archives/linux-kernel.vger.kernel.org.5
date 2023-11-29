Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A083D7FD257
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjK2JW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2JWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:22:24 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C319B6;
        Wed, 29 Nov 2023 01:22:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8ZXOgZhFqm0HJOHiWF2PzwDSfqbNjh7Qkx/G15/xSh/i2MrDz8RpcLmc53DtHxyxWHF/JSo9B6hGjmCMUfn0czqGUc/sTfWAW6pkAkxWGCOeEq6zfDrgQJZfJpvrNKVwI2a25HfhPq0qRyatKCH1Yy6amRLCQjedeaU8aCfoa+KPt24wxt3oY6rwu8Qf7U+nMw9W5X1P8U+SfJ5K+bBTcWCLXIoSuelYE/gjpKv0MuDEQxqVfwhWMbhLT5CK3e2aPOfr+ONCw6XCmX7P6nvwmm8bMcH6fNySO247o5acZe5ilBWyFESqoSrHqAfG51u75l2ooBsX/w8+f55xiTSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RPbuiEIS+3q0KHipXHbgz2K7RFcq9LHLjm0S4XRiSQ=;
 b=gA0jM0VEdzfIjfRKjoMTIKQj0xPRtASTY0hHDfH9SzuA7frekIrEV+CEwMKfB3bE1fWuvGYTNJAP1M1UIXlUf6WP5rp33hDEa7mJ2Dvna6F0iXZywqaX8bU6q7OXiDfp9jdGWSxkIs7/tkXHjjdyydXn6Z4SmScrhoGrfMRjNwoHgwiD0dE3T1jU7z1mmVJWSgFYrGaGdnBNEhOLSfbw0aolzXQw248XK8elSJfGrCukuzonEzXqflEmEPiIkOrttrsoYwuvQw4ElfIlOPUk/Hlr8z8O9NcMSMJB7vjJ6hXC+vkRhHXTBPe31pK+dCjRZTQgCvtWiwCetC8SeycY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RPbuiEIS+3q0KHipXHbgz2K7RFcq9LHLjm0S4XRiSQ=;
 b=YHzSHfIn5qna7Ic1nLY7njORTSEvieFRHlNixGN7rvYsl4yofpt/SONg+tULjmVY8lLVF2hrlvjjxD4ciW7LAL1PmT57iriuPC5Z0coQOtG52EYGOhWsvAAJOYWNHJqpARZE19IDdXJr5KaoW28FiCcDDdKorCF6s0xWGc94okFjc7tpE4b6kCQ3QBmRk2gF9xpam8SFWckt38KwiAnK5xfSbP8FoKTJvoFnOYDimQ9K3l3uPg8QArXHIxRXVQVp/3ZK6iwQUYfw9YAlUlnB9ypavU/RQeLt4vjZKuKJLfQh14+MLLnECzU73XIQ4Camaus7PlIq+l9lgtsohMZSBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AS8PR04MB8707.eurprd04.prod.outlook.com
 (2603:10a6:20b:42a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 09:22:25 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14c8:fc35:a9ae:9c9d]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14c8:fc35:a9ae:9c9d%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 09:22:25 +0000
Message-ID: <bb6c9771-1a7c-4367-bb14-63524d9c560a@suse.com>
Date:   Wed, 29 Nov 2023 10:22:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tracing: Simplify and fix "buffered event"
 synchronization
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127151248.7232-1-petr.pavlu@suse.com>
 <20231127151248.7232-2-petr.pavlu@suse.com>
 <20231127124130.1041ffd4@gandalf.local.home>
 <77037ca1-8116-4bc6-b286-67059db0848e@suse.com>
 <20231128102748.23328618@gandalf.local.home>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20231128102748.23328618@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0063.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::16) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fb19be-14de-4fcf-f9e0-08dbf0bcb2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5wRcmiUxDcZ8mnG79DFHwEjK+g3oM0UIYggzeh7QgE4rdEpB+6E6JgdXjKMovdFwwE5zeD3mTuESvcaHDtRUB4kmRYVccW2tU4b9UEivfoBglFBwdPl9W5hX9NL5W+RPQUrDOeIk577a4sPeMTi4OU00cd0qmFAUPRbGV4yv16P+KkCevXGHdbgxAggBdXx5MQNtfaUn1SBlLaYW7AlAZ9W1P2kBQ/hzHm3F3oYuB7DVhLwyc/tHmsFCHJL7ugtkezauGJqSFtStL7RsCtR4MEjdy6jgJpQH3cMgG9LHjBMkFcH2tuirXCXQN9C++qj8oSJrahBNv7dTnYHjllIMZPGNOotSnLpWBwB+kfTeOkSTLlKkWKfeJOXrZrfMV9Ib2T7nSpZGsuKpvQKqukspFYdGBq2wA8WpyN+0s6OsNRtn8y331nLOHN+sp662OZqXJDFrAtb8lf0UVsksDHqAG72bOYomvWWeBMxn5p++z1uLlrhfxD6UT6beVLmPWTgEGftx8ln9HdRIIey6UfLM5nOZl4dx4XXXJIShxFVxag3E+rwLXenbwrFtpol9Efn2C9W+w71zUxXdkEWDC7dP/PTTFY6mmqCyhpdNujtcHI9KU9JXv7iFxaFUZU+kttN9c8kCwdiklgFRmDBirBEBQ7aCC+7ei1vXtNFzKKy628=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(38100700002)(31696002)(86362001)(41300700001)(4326008)(66556008)(6916009)(316002)(66476007)(8936002)(5660300002)(8676002)(66946007)(2906002)(478600001)(30864003)(6512007)(2616005)(55236004)(44832011)(966005)(6506007)(53546011)(6486002)(26005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTRLaTNCZC9ERy95My9SdG5wajlPTWZGU0xVUXpDNmx3RlU1V01ZVXcwYk9M?=
 =?utf-8?B?UmdNdVc4dWVKcnJZUjRBeWtlcEdCbEROQXZ6ODUxZjUrUzYrRENDM0xRem5l?=
 =?utf-8?B?MU1RUWdTZnhSeGVodDFNekllNitwcnpTa3BRbkFZa1hZRXBsRnRWb2RnRzRZ?=
 =?utf-8?B?dW9SaVowdFFON1hQRVE2dHE1Y0k4NmF4ZDF6NjhCSy8zbEZ4ZFdQTVUwR092?=
 =?utf-8?B?WWhPRDJGaEhiRnoxZGw3TCsyc2JsRHhQQlRsdDBHRUFpODAwK2dwMVF6ek8y?=
 =?utf-8?B?UExPenJTU2s5ZGxVdGZFa1J2SXhBZWF0eXRlb3BiVi9tVVVHcXZuZnZNQi9O?=
 =?utf-8?B?YytMb3pzSWJaWUt4aVltQlVqNjNvMm9Lc1E0K1c5Rm4vYTFVcmpWQTNwNHNI?=
 =?utf-8?B?UUd0amJEZk50cTZKRVU3ekxNVGdGTGxOa2tVSmpGSzNmYWJnM3krSmJoSGpu?=
 =?utf-8?B?WW1lWFY5YTBSekpraEtoaVcvbkFHc3hucVlEWlRQUXUweFF3dVFWeVd3R2hX?=
 =?utf-8?B?NkhqM3U1dlJrT3A3ektxUkl4ZXNzSVRJWU1ZcFJkUDAyYjlJaTVva1BpYSs4?=
 =?utf-8?B?S0JxVld0OHpDSlBLQWRadTBxa0pmM09JQ2YvV0prMmEvWWtsZkJMMEJRM3l2?=
 =?utf-8?B?eXI5V05BaW9Ib2pveUtNYzR1eHdMR1NuQVo4TXp2b1Z1K1pFREorM0wzQ0ZR?=
 =?utf-8?B?eC9XVDZHTENIeld0M0dnQm9nMzJFSlcwczhKV0NCTzJGck9HeEhPdjlVSGNq?=
 =?utf-8?B?aHJOUTEwK1BxbXlmbTBpWEFYQ2FVdVJlU0l3cFBPYUQ4TklaNzZaaVlxbG5M?=
 =?utf-8?B?MjBXWDVhQTdOOWFLdUR4SSsvcUVOMlhnTTkxYWpEaGtFVXJGbVorUE5HZmFJ?=
 =?utf-8?B?enhvd2hjdXlVZXRVY3JhS0ZmaGVOK05icnNmdzRUUWxSYXNsMGh6cHUyR0Q0?=
 =?utf-8?B?K0QyMjBVQlB1dTdUdE50LzZ5bUUwMEdwZS8wc1lqMEFBSFhZTmdWeEZDem1R?=
 =?utf-8?B?OWNscEltUkFML3pycHl5eDNZSk5NcjNyU2tQb3NjNk9DdlRlaDVoUlo4TlZL?=
 =?utf-8?B?aFFhZTBNZC9ZVUJHdUlxNlRXekx3bm5IZ1kybmxOSW5ZMnVBL2RoaGUxc2VT?=
 =?utf-8?B?bXdBSEowTDFmNUhvSDM1U3JXQzFLVDNrZ0ZYQ2NZZys3ZXdLOWJyRFFWcHY4?=
 =?utf-8?B?TFJzTHczMmk3OE56YTVSbkhqNSthTnVJZnRSSVpqMGpZdkk5WTc4ZDVqeGh0?=
 =?utf-8?B?cXAyLzYrUUhmTTNXSDA0SDhIenhhQ2VRT21wUzhjNkdrQmZ3RXRmdktmMnNO?=
 =?utf-8?B?eDZMNS80TTFJeDJuSVQ4UUxqdExRRXRibUV1a2hZN0pCc1FzOS9OeGFqNXBi?=
 =?utf-8?B?NXk2Q3NJdkExdHRYSUsrRnJPZWl4SjJxYU1OYVBQY2tqNFRoMHZJS1ZzS2FB?=
 =?utf-8?B?NVFOQWRwUEZ5NlZ4SEVsUkhkWS9TRmhzSVBOWDJpUHdtbW5jK3pOVEM1ZVFY?=
 =?utf-8?B?TGV6TkJwZWpsTXpZeXQ4U09RK3hsUi9NQy92NXJ0RGg5NWV0dXZHeFpzU0t3?=
 =?utf-8?B?TzFXNnFESXR3UXNvSFd5RHhPVm9HY2QxdThVcjVSMkczV2JiQzMxUk8wM3E4?=
 =?utf-8?B?RnJTQ09HcHROUjYydXFuUS83SXBUdDk3RlJ3c0ZoUWwzNzJqOWFOTU45Q1Zv?=
 =?utf-8?B?NGtYSjJVVi9RL3lXTHplVXg2VzRtUEc3bVQxWlQ2VW9ESUZsQTNFMmxtTm9V?=
 =?utf-8?B?QVc2eWhuU2VUOVZxekN3VTN3cmxjQ0U2NTY5OFRCNlRxMHcxT1VmdHdCMGtn?=
 =?utf-8?B?UWRxRGdyUXVMcGFZZHVkVEsrN1F0bVRnYWJVczdrVlh1SjlOWFhtM3oraTJ3?=
 =?utf-8?B?MDdXU1NtYW1GbWhULzVVK25XRmV5Yk1yaVVUaklMRG83bExEZmVVSUZET2lu?=
 =?utf-8?B?UFlJa2dpYzQ3WEhNcTR1ekxsQXh6VzB3Mm12VnNhdWdJc01Id2FobXZxV0V6?=
 =?utf-8?B?VXFNY0U3MER3b3h4c1M2T3BGODVKR3NCVTdHSFFLY1l0WlFJRWdBdmVaZkVW?=
 =?utf-8?B?c1h6RnNRRWJPUmtENFp4aG9qelRVdFo5aisxN2c4Rk8wNHZIekRhQ1lXMVpL?=
 =?utf-8?Q?TPaUPmsKXds62Zbacyzyrz0Sq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fb19be-14de-4fcf-f9e0-08dbf0bcb2bb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:22:25.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7FTHzk3MNR5jAsgEb2cTDEyisPRkHugQYGk4ic8W62WAOcV5HZBawbB1cocg/Kjl5OZJGrnvdeZtPE6mISRJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 16:27, Steven Rostedt wrote:
> On Tue, 28 Nov 2023 16:05:00 +0100
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> On 11/27/23 18:41, Steven Rostedt wrote:
>>> On Mon, 27 Nov 2023 16:12:47 +0100
>>> Petr Pavlu <petr.pavlu@suse.com> wrote:
>>>   
>>>> The following warning appears when using buffered events:
>>>> [  203.556451] WARNING: CPU: 53 PID: 10220 at kernel/trace/ring_buffer.c:3912 ring_buffer_discard_commit+0x2eb/0x420  
>>>
>>> Hmm, I don't have a waring on line 3912, do you have extra code (debugging)
>>> in your version?  
>>
>> The series is based on 2cc14f52aeb7 (tag: v6.7-rc3). It is the following
>> code and RB_WARN_ON():
> 
> Interesting.
> 
>>   3895  void ring_buffer_discard_commit(struct trace_buffer *buffer,
>>   3896                                  struct ring_buffer_event *event)
>>   3897  {
>> [...]
>>   3908           * This must only be called if the event has not been
>>   3909           * committed yet. Thus we can assume that preemption
>>   3910           * is still disabled.
>>   3911           */
>>   3912          RB_WARN_ON(buffer, !local_read(&cpu_buffer->committing));
>>   3913  
>>   3914          rb_decrement_entry(cpu_buffer, event);
>>   3915          if (rb_try_to_discard(cpu_buffer, event))
>>   3916                  goto out;
>>
>> https://github.com/torvalds/linux/blob/2cc14f52aeb78ce3f29677c2de1f06c0e91471ab/kernel/trace/ring_buffer.c#L3912
>>
>>>> [...]
>>>> [  203.670690] CPU: 53 PID: 10220 Comm: stress-ng-sysin Tainted: G            E      6.7.0-rc2-default #4 56e6d0fcf5581e6e51eaaecbdaec2a2338c80f3a
> 
> I was looking at the above 6.7.0-rc2-default, which made me somewhat confused.
> 
> 
>>>> [  203.670704] Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS GVPRCRB1.86B.0016.D04.1705030402 05/03/2017
>>>> [  203.670709] RIP: 0010:ring_buffer_discard_commit+0x2eb/0x420
>>>> [  203.735721] Code: 4c 8b 4a 50 48 8b 42 48 49 39 c1 0f 84 b3 00 00 00 49 83 e8 01 75 b1 48 8b 42 10 f0 ff 40 08 0f 0b e9 fc fe ff ff f0 ff 47 08 <0f> 0b e9 77 
> 
>>>> * Function trace_buffered_event_enable() initializes memory of each
>>>>   allocated trace_buffered_event to zero but no memory barrier is
>>>>   present to ensure this operation is completed before publishing its
>>>>   pointer for use in trace_event_buffer_lock_reserve().  
>>>
>>> Yes, a wmb() may be helpful, but as the reader will see either the
>>> allocated page or NULL, and can handle both cases. I decided not to add it
>>> because it really doesn't matter if we do.  
>>
>> My concern is about the earlier call "memset(event, 0, sizeof(*event));"
>> in trace_buffered_event_enable() which writes the obtained event page
>> prior to publishing it via "per_cpu(trace_buffered_event, cpu) = event;".
>> I think another CPU running trace_event_buffer_lock_reserve() could see
>> already the valid event pointer, write to the event page and only then
>> the memory could see the memset() write coming from
>> trace_buffered_event_enable(). The event data would then become
>> corrupted.
> 
> OK, I'll buy that. Feel free to send an patch that adds that wmb with a
> comment explaining the above.

Sure, I can do that. A nice thing about my proposed patch is that it
requires only one smp_wmb() in this case, while the current code will
require adding this barrier in the allocation loop prior to writing
trace_buffered_event.

>>>   
>>>> * Calling function trace_buffered_event_enable() normally requires
>>>>   pairing it with trace_buffered_event_disable(). However, the function
>>>>   has no error return code and in case of a failure decrements back
>>>>   trace_buffered_event_ref. This results in underflow of the counter
>>>>   when trace_buffered_event_disable() gets called later.  
>>>
>>> Not an issue.
>>>
>>> Even on failure the ref count will be greater than zero, where 
>>> trace_buffered_event_disable() handles it properly, and the freeing can
>>> handle no pages being allocated.
>>>
>>> That is:
>>>
>>> 	free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
>>>
>>> would be the same as: free_page((unsigned long)NULL);
>>>
>>> Which is perfectly fine to do.  
>>
>> The situation that I have on my mind is the following:
>> * The counter trace_buffered_event_ref is at 0.
>> * The soft mode gets enabled for some event and
>>   trace_buffered_event_enable() is called. The function increments
>>   trace_buffered_event_ref to 1 and starts allocating event pages.
>> * The allocation fails for some page and trace_buffered_event_disable()
>>   is called for cleanup.
>> * Function trace_buffered_event_disable() decrements
>>   trace_buffered_event_ref back to 0, recognizes that it was the last
>>   use of buffered events and frees all allocated pages.
>> * The control goes back to trace_buffered_event_enable() which returns.
>>   The caller of trace_buffered_event_enable() has no information that
>>   the function actually failed.
>> * Some time later, the soft mode is disabled for the same event.
>>   Function trace_buffered_event_disable() is called. It warns on
>>   "WARN_ON_ONCE(!trace_buffered_event_ref)" and returns.
>>
>> The end result is only an ugly warning but I think it is still good to
>> fix.
> 
> Ah, I missed the call to trace_buffered_event_disable() in the failure
> path. Actually, since the trace_buffered_event is only an optimization, I
> think the best thing to do is to just return without the clean up,
> expecting that the other caller will do the clean up. We could even not
> even stop the loop!
> 
> That is, just have:
> 
> void trace_buffered_event_enable(void)
> {
> 	struct ring_buffer_event *event;
> 	struct page *page;
> 	int cpu;
> 
> 	WARN_ON_ONCE(!mutex_is_locked(&event_mutex));
> 
> 	if (trace_buffered_event_ref++)
> 		return;
> 
> 	for_each_tracing_cpu(cpu) {
> 		page = alloc_pages_node(cpu_to_node(cpu),
> 					GFP_KERNEL | __GFP_NORETRY, 0);
> 
> 		/* This is just an optimization and can handle failures */
> 		if (!page) {
> 			pr_err("Failed to create event buffer\n");
> 			break;
> 		}
> 
> 		event = page_address(page);
> 		memset(event, 0, sizeof(*event));
> 
> 		per_cpu(trace_buffered_event, cpu) = event;
> 
> 		preempt_disable();
> 		if (cpu == smp_processor_id() &&
> 		    __this_cpu_read(trace_buffered_event) !=
> 		    per_cpu(trace_buffered_event, cpu))
> 			WARN_ON_ONCE(1);
> 		preempt_enable();
> 	}
> }

The current behavior is that if the allocation in one call to
trace_buffered_event_enable() fails then another call to the same
function results in a new attempt to allocate the event pages.

The code above changes it. As long trace_buffered_event_ref doesn't go
back to 0 and then 1 again, no new allocation attempt is made. It means
that trace_buffered_event can be left in this "half-initialized" state
for a while.

This is possibly ok, it is an unlikely corner case anyway. My patch
nonetheless preserves the current behavior of retrying the allocation.

> 
>>>
>>> Now, the reason you found the crash was from the first issue you mentioned.
>>> That is, we didn't disable the current CPU and if we migrated, things would
>>> get really messed up. The only fix here is to make sure all CPUs have their
>>> trace_buffered_event_cnt get incremented.  
>>
>> The potential race that I see is the following:
>> * Function trace_buffered_event_disable() is called on CPU 0. It
>>   increments trace_buffered_event_cnt on each CPU and waits via
>>   synchronize_rcu() for each user of trace_buffered_event to complete.
> 
>> * After synchronize_rcu() is already finished, the situation is that all
>>   counters trace_buffered_event_cnt are at 1 and all pointers
>>   trace_buffered_event are still valid.
> 
>> * At this point, on a different CPU 1, the execution reaches
>>   trace_event_buffer_lock_reserve(). The function calls
>>   preempt_disable_notrace() and enters an RCU read-side critical section
>>   but that is not important because all RCU stuff is already performed
>>   and completed in trace_buffered_event_disable(). The function proceeds
>>   and reads a still valid pointer from trace_buffered_event[CPU1] into
>>   the local variable "entry". However, it doesn't yet read
>>   trace_buffered_event_cnt[CPU1] which happens later.
> 
>> * Function trace_buffered_event_disable() continues. It frees
>>   trace_buffered_event[CPU1] and decrements
>>   trace_buffered_event_cnt[CPU1] back to 0.
> 
>> * Function trace_event_buffer_lock_reserve() continues. It reads and
>>   increments trace_buffered_event_cnt[CPU1] from 0 to 1. This makes it
>>   believe that it can use the "entry" that it already obtained but the
>>   pointer is now invalid and any access results in a use-after-free.
> 
> OK, so you are saying we need another synchronize_rcu() after we set the
> trace_buffered_event to NULL?
> 
> 
> void trace_buffered_event_disable(void)
> {
> 	int cpu;
> 
> 	WARN_ON_ONCE(!mutex_is_locked(&event_mutex));
> 
> 	if (WARN_ON_ONCE(!trace_buffered_event_ref))
> 		return;
> 
> 	if (--trace_buffered_event_ref)
> 		return;
> 
> 	preempt_disable();
> 	/* For each CPU, set the buffer as used. */
> 	smp_call_function_many(tracing_buffer_mask,
> 			       disable_trace_buffered_event, NULL, 1);
> 	preempt_enable();
> 
> 	/* Wait for all current users to finish */
> 	synchronize_rcu();
> 
> 	for_each_tracing_cpu(cpu) {
> 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
> 		per_cpu(trace_buffered_event, cpu) = NULL;
> 	}
> 	/*
> 	 * Make sure trace_buffered_event is NULL before clearing
> 	 * trace_buffered_event_cnt.
> 	 */
> -	smp_wmb();
> +	synchronize_rcu();
> 
> 	preempt_disable();
> 	/* Do the work on each cpu */
> 	smp_call_function_many(tracing_buffer_mask,
> 			       enable_trace_buffered_event, NULL, 1);
> 	preempt_enable();
> }
> 
> I agree with that.

Yes, I believe this should address this potential race condition.

An alternative would be instead to update
trace_event_buffer_lock_reserve() as follows:

	if (this_cpu_inc_return(trace_buffered_event_cnt) == 1) {
		smp_rmb();
		if ((entry = __this_cpu_read(trace_buffered_event))) {
			[...]

That saves the synchronize_rcu() call but additionally modifies
trace_buffered_event_cnt even if trace_buffered_event is currently NULL.

Another alternative is the approach taken by my patch which avoids more
RCU work and unnecessary memory modifications.

I'd be interested if you could have a look again at what I'm proposing
in my patch. I think it simplifies the code while addressing these
problems as well. However, if you have reservations about that approach
then it is ok, I can fix the found problems individually as discussed.

Thanks,
Petr
