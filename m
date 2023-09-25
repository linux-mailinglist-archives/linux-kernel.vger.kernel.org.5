Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1737AD418
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjIYJDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjIYJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:03:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C6DA;
        Mon, 25 Sep 2023 02:03:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D32FC433BA;
        Mon, 25 Sep 2023 09:03:11 +0000 (UTC)
Message-ID: <f4162357-ee91-49ab-8627-2d18ca0eee50@xs4all.nl>
Date:   Mon, 25 Sep 2023 11:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/7] media: v4l2: Add ignore_streaming flag
Content-Language: en-US, nl
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Tomasz Figa <tfiga@chromium.org>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
 <20230915-wave5_v12_on_media_master-v12-1-92fc66cd685d@collabora.com>
 <a3c61e5a-e5cb-43d5-a3dc-80806f8da672@xs4all.nl>
 <179e88f04257f21b6b723e935231de70415b3301.camel@collabora.com>
 <f50a8fe3-b42f-41a9-918d-825e1110a5ac@xs4all.nl>
 <522e5f3bd4f43a5718ae88133b8d5d187c470f74.camel@collabora.com>
 <2ada3256-2aa0-41e0-bac6-989a20131309@xs4all.nl>
 <27bcd2cf21688b1120fcc75c38981f8585e8f9bd.camel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <27bcd2cf21688b1120fcc75c38981f8585e8f9bd.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 22:20, Nicolas Dufresne wrote:
> Le vendredi 22 septembre 2023 à 10:28 +0200, Hans Verkuil a écrit :
>> On 21/09/2023 20:39, Nicolas Dufresne wrote:
>>> Le mercredi 20 septembre 2023 à 16:49 +0200, Hans Verkuil a écrit :
>>>> On 20/09/2023 16:08, Nicolas Dufresne wrote:
>>>>> cc Tomasz Figa
>>>>>
>>>>> Le mercredi 20 septembre 2023 à 14:59 +0200, Hans Verkuil a écrit :
>>>>>> On 15/09/2023 23:11, Sebastian Fricke wrote:
>>>>>>> Add a new flag to the `struct v4l2_m2m_dev` to toggle whether a queue
>>>>>>> must be streaming in order to allow queuing jobs to the ready queue.
>>>>>>> Currently, both queues (CAPTURE & OUTPUT) must be streaming in order to
>>>>>>> allow adding new jobs. This behavior limits the usability of M2M for
>>>>>>> some drivers, as these have to be able, to perform analysis of the
>>>>>>
>>>>>> able, to -> able to
>>>>>>
>>>>>>> sequence to ensure, that userspace prepares the CAPTURE queue correctly.
>>>>>>
>>>>>> ensure, that -> ensure that
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>>>>>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>>>>>> ---
>>>>>>>  include/media/v4l2-mem2mem.h | 17 +++++++++++++++++
>>>>>>>  1 file changed, 17 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
>>>>>>> index d6c8eb2b5201..97a48e61e358 100644
>>>>>>> --- a/include/media/v4l2-mem2mem.h
>>>>>>> +++ b/include/media/v4l2-mem2mem.h
>>>>>>> @@ -57,6 +57,16 @@ struct v4l2_m2m_dev;
>>>>>>>   * @rdy_spinlock: spin lock to protect the struct usage
>>>>>>>   * @num_rdy:	number of buffers ready to be processed
>>>>>>>   * @buffered:	is the queue buffered?
>>>>>>> + * @ignore_streaming: Dictates whether the queue must be streaming for a job to
>>>>>>> + *		      be queued.
>>>>>>> + *		      This is useful, for example, when the driver requires to
>>>>>>> + *		      initialize the sequence with a firmware, where only a
>>>>>>> + *		      queued OUTPUT queue buffer and STREAMON on the OUTPUT
>>>>>>> + *		      queue is required to perform the anlysis of the bitstream
>>>>>>> + *		      header.
>>>>>>> + *		      This means the driver is responsible for implementing the
>>>>>>> + *		      job_ready callback correctly to make sure that requirements
>>>>>>> + *		      for actual decoding are met.
>>>>>>
>>>>>> This is a bad description and field name.
>>>>>
>>>>> I wonder what's your opinion about the buffered one then :-D
>>>>
>>>> Even worse :-)
>>>>
>>>> I still don't really understand what that does. Patches welcome.
>>>>
>>>>>
>>>>>>
>>>>>> Basically what this field does is that, if true, the streaming state of the
>>>>>> capture queue is ignored. So just call it that: ignore_cap_streaming.
>>>>>>
>>>>>> And explain that, if true, job_ready() will be called even if the capture
>>>>>> queue is not streaming, and that that can be used to allow hardware to
>>>>>> analyze the bitstream header that arrives on the OUTPUT queue.
>>>>>
>>>>> Ack.
>>>>>
>>>>>>
>>>>>> Also, doesn't this field belong to struct v4l2_m2m_ctx? It makes no sense
>>>>>> for the output queue, this is really a configuration for the m2m context as
>>>>>> a whole.
>>>>>
>>>>> Unless we come up with a completely new type of M2M that can behave like a gap
>>>>> filler (like a video rate m2m), it indeed makes no sense for output. I'm just
>>>>> illustrating that this is true "now" but someone can come up with valid
>>>>> expectation. So I agree with you, we can move it up in the hierarchy.
>>>>>
>>>>> Recently over IRC and other threads, Tomasz raised a concern that CODECs where
>>>>> introducing too much complexity into M2M. And I believe buffered (which is
>>>>> barely documented) and this mechanism was being pointed.
>>>>>
>>>>> My take on that is that adding boolean configuration is what introduce
>>>>> complexity, and we can fix it by doing less in the m2m. After this discussion, I
>>>>> came with the idea that we should remove buffered and ignore_streaming. For
>>>>> drivers that don't implement job_ready, this logic would be moved inside the
>>>>> default implementation. We can then add a helper to check the common conditions.
>>>>>
>>>>> The alternative suggested by Tomasz, was to layer two ops. We'd have a
>>>>> device_ready() ops and its default implementation would include the check we
>>>>> have and would call job_ready(). Personally, I'd rather remove then add, but I
>>>>> understadt the reasoning and would be fine committing to that instead.
>>>>>
>>>>> I'd like your feedback on this proposal. If this is something we want, I'll do
>>>>> this prior to V13, otherwise we will address your comments and fix the added
>>>>> mechanism. I think though that we agree that for decoders, this is nice addition
>>>>> to not have to trigger work manually from vb2 ops.
>>>>
>>>> It comes down to a matter of taste, I guess. I personally think that using bools
>>>> to tweak the behavior of a framework does not necessarily increase complexity,
>>>> provided it is clearly documented what it does and why it is needed.
>>>>
>>>> I think an ignore_cap_streaming bool is pretty straightforward and has minimal
>>>> impact in the code. As long as there are good comments.
>>>
>>> So for wave5 we will opt for this and apply your suggested changes. And I may
>>> come back later on the subject.
>>>
>>>>
>>>> The 'buffered' flag is were this clearly failed completely, since I couldn't figure
>>>> out what it is supposed to do. But that is not because it makes the code more
>>>> complex, it is just because of shoddy documentation and naming.
>>>>
>>>> Quite often implementing tweaks like that are quite easy in a framework, since
>>>> you have all the information readily available. In a driver it can quickly become
>>>> messy.
>>>
>>> In this case, "buffered" is used to disable the checks for having at least one
>>> buffer in the ready queues. In most cases, if you don't have at least 1 pending
>>> capture and 1 pending output buffer, there is no point in calling device_run.
>>
>> So it is really similar to ignore_cap_streaming: that relaxes the streaming test,
>> and 'buffered' relaxes the 'must have at least one capture and output buffer ready'
>> test.
>>
>> So this should be renamed to: allow_empty_queues
>>
>> Although I would prefer to split this into two bools: allow_empty_capture_queue and
>> allow_empty_output_queue. It is more flexible that way and I actually think it is
>> easier to understand.
> 
> Its on the queue ctx, so it does not have to be typed. It would have to be typed
> if moved to m2m ctx.

Oops, I missed that. I'm not actually sure that's where it should be. If you
support flags that tweak the behavior, then put them together in a single place,
and not all over.

Regards,

	Hans

> 
>>
>> I see also see in the v4l2-mem2mem.c source that the debug messages are very poorly
>> worded:
>> 	src = v4l2_m2m_next_src_buf(m2m_ctx);
>>
>>         if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>                 dprintk("No input buffers available\n");
>>                 goto job_unlock;
>>         }
>>
>> This should be either "source buffers" or "output buffers", but definitely not
>> "input buffers".
>>
>> Ditto for the dst part.
> 
> Indeed, I'll store this node somewhere for future work on the framework, this is
> not strictly related to wave5 anymore.
> 
>>
>>>
>>> In reality, drivers will add use case specific checks in their job_ready()
>>> implementation. For decoders, the cases I can think of are:
>>>
>>> - On capture if you haven't parsed the stream header
>>> - On capture if the driver removes them from ready queue as a way to track which
>>> one are considered free and may be used at any time by the firmware
>>> - On output queue, if you need device_run() to be called to complete the drain
>>> the reorder queue
>>>
>>> Yet, you want this check after stream headers are parsed, or whenever a new
>>> bitstream decode operation is to be queued in the firmware. So this check gets
>>> re-implemented, but dynamically, in all decoders.
>>>
>>> Deinterlacers may needs this too with some algorithms (the one that introduce
>>> delays at least). Its not clear to me why it was called buffered,
>>> ignore_rdy_queue might have been an option, though I'm not fully confident. Note
>>> that M2M can be confusing, since whenever you ask for last something, its always
>>> relative to the ready queue, and may not make a lot of sense in the context it
>>> is used.
>>>
>>>>
>>>> For codec support there are a number of issues that increase complexity:
>>>> implementing support for the LAST flag and events, and supporting buffers
>>>> that can be held. Especially since driver implementations tend to vary.
>>>>
>>>> I've been experimenting with some cleanups and changes in v4l2-mem2mem.c
>>>> (https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=enc-dec-cmd), mainly
>>>> surrounding the handling of the LAST flag. Note: this is failing the compliance
>>>> tests, I haven't had the time to pursue this further.
>>>>
>>>> I'm not sure whether the best approach is to move things out of the m2m framework,
>>>> or move things into the m2m framework, or add a more codec-specific layer on top
>>>> of the m2m framework, or a combination of all of these.
>>>>
>>>> It is something that needs experimentation, just see what works.
>>>
>>> I can see you have omitted mark_stopped() calles when refactoring, which makes
>>> these patches change the behaviour. Could be related.
>>
>> Could be. I hope to be able to spend a bit of time on this today.
>>
>>>
>>> This is no longer strictly related to this patch, but I think cmd_stop()
>>> implementation (even after your changes) are miss-fit for driver that speaks to
>>> firmware. As the firmware is being made aware of the free buffers, you can't
>>> just cherry-pick from the capture queue, you have to synchronise your state with
>>> the firmware while draining. The helper should be split in two parts I suppose,
>>> but cutting the line isn't easy.
>>>
>>> Thread safe usage of the numerous boolean implicated in the draining state is
>>> also difficult. There is no other option then introduce a mutex or spinlock (if
>>> the state is needed in job_ready() implementation) to make this thread safe and
>>> reliable.
>>
>> Regards,
>>
>> 	Hans
>>
>>>
>>>>
>>>> But for this specific flag: I think it is fine to put that in the m2m framework,
>>>> just document and name it well.
>>>
>>> Ack.
>>>
>>>>
>>>> Regards,
>>>>
>>>> 	Hans
>>>>
>>>>>
>>>>> regards,
>>>>> Nicolas
>>>>>
>>>>>>
>>>>>>>   *
>>>>>>>   * Queue for buffers ready to be processed as soon as this
>>>>>>>   * instance receives access to the device.
>>>>>>> @@ -69,6 +79,7 @@ struct v4l2_m2m_queue_ctx {
>>>>>>>  	spinlock_t		rdy_spinlock;
>>>>>>>  	u8			num_rdy;
>>>>>>>  	bool			buffered;
>>>>>>> +	bool			ignore_streaming;
>>>>>>>  };
>>>>>>>  
>>>>>>>  /**
>>>>>>> @@ -564,6 +575,12 @@ static inline void v4l2_m2m_set_dst_buffered(struct v4l2_m2m_ctx *m2m_ctx,
>>>>>>>  	m2m_ctx->cap_q_ctx.buffered = buffered;
>>>>>>>  }
>>>>>>>  
>>>>>>> +static inline void v4l2_m2m_set_dst_ignore_streaming(struct v4l2_m2m_ctx *m2m_ctx,
>>>>>>> +						     bool ignore_streaming)
>>>>>>> +{
>>>>>>> +	m2m_ctx->cap_q_ctx.ignore_streaming = ignore_streaming;
>>>>>>> +}
>>>>>>> +
>>>>>>
>>>>>> I think this is overkill, esp. when the field is moved to m2m_ctx. Just clearly
>>>>>> document that drivers can set this.
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> 	Hans
>>>>>>
>>>>>>>  /**
>>>>>>>   * v4l2_m2m_ctx_release() - release m2m context
>>>>>>>   *
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

