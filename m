Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046507E6FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjKIQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjKIQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:47:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1F1FD6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:47:02 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so892156a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699548422; x=1700153222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFEYzf0bj7ciKv8BP9ybJSLaBDaWIMdV0O6fJdozic0=;
        b=vlSSsaqkUPAwzgwvWxnlDNy4a6HNW3zQovvd1Yxbun2jhBH1uG6CWv9FwCDpq9e8wY
         R2E1M1IE1YJclcj8aB8N4FGQ0Ns+xyHFpVo0YihjdbIGuR9TGUX16pk5EznnX/kk4cyY
         t+eMliop/i/VtqagKzyXFSyF7YewrQ9emSE0uQJunQD3bGdnltoh1jP8iOUUJnNZBu4/
         mfpVRrqXfjvfTHTDSrMLvaqbatts3MMX4sXTAwfyhroMHkF+0lgM2LVDAL/q4TkCExCF
         Dg0Aqa1gbMISDAeSI6fYripPOEfE4gZmKMxwhqwP7UMPLAT55q1nVDw/yRE3ecwjELlH
         wFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699548422; x=1700153222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFEYzf0bj7ciKv8BP9ybJSLaBDaWIMdV0O6fJdozic0=;
        b=hQSRteR8bu6Sxat+5qBOb1K2LEJb9SFky5t+wVnYxZY7GhW0MfWpUoFY2t5mfGtwt3
         1qPslOekC/RM6kr41mZgaHUFTmmd1sQmTp9U7tQb8jtvOJZ796V8yPd4iepPJL8uDIbf
         TZrVxFjvN58hntTYpMC6ys1O3DXoyoYB0hkscbDisEkDQRWTSs573Bi258ImTKazZBFI
         5e0FY5vNCxeX7rqpuUnqifkOewH/+1KZ8xxp010Hc0TLHkJLTHgzZ1x4dYo1phrr+A1E
         ey0Zga/pAPXlvW2SG6lTlXpPH07/o1Iwo7XiuU1xRpDQJcSfE1Ikrp2FQGVBz6pThQ8w
         UaaA==
X-Gm-Message-State: AOJu0Yy8s9zZ/u48CxT/tCk9ftjORJjwLHE5g0kmsik56BYeSsq0ggWK
        iRot39RAA1V2oY5Q8KFfw1YVmA==
X-Google-Smtp-Source: AGHT+IE+hP8IdIpVlUKjnOWrU1AELw/IX8/mfl+V0YAW1swkpXDv2+GRhrbtvzyfk6PdfS+3sdXg0g==
X-Received: by 2002:a05:6a21:339b:b0:16b:d137:de59 with SMTP id yy27-20020a056a21339b00b0016bd137de59mr6430468pzb.28.1699548421216;
        Thu, 09 Nov 2023 08:47:01 -0800 (PST)
Received: from [192.168.88.158] (48.109.197.35.bc.googleusercontent.com. [35.197.109.48])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001b890009634sm3755690plg.139.2023.11.09.08.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:47:00 -0800 (PST)
Message-ID: <a5da9b9b-1821-41dc-880c-d5f591c6a96c@google.com>
Date:   Thu, 9 Nov 2023 08:46:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb:gadget:uvc Do not use worker thread to queue isoc
 usb requests
Content-Language: en-US
To:     Dan Scally <dan.scally@ideasonboard.com>,
        stern@rowland.harvard.edu, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org
Cc:     Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20231026215635.2478767-1-jchowdhary@google.com>
 <20231102060120.1159112-1-jchowdhary@google.com>
 <915ef27a-11c8-49ba-8f8a-b4524b85c75a@ideasonboard.com>
 <b6732f9f-f77f-449a-8934-f23a7f5b3177@google.com>
 <ed364330-edb4-4cfa-b3aa-95c2b10948ef@ideasonboard.com>
From:   Jayant Chowdhary <jchowdhary@google.com>
In-Reply-To: <ed364330-edb4-4cfa-b3aa-95c2b10948ef@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,
Thanks for the comments.
I sent out v6 here https://lore.kernel.org/linux-usb/20231109073453.751860-1-jchowdhary@google.com/T/#u

On 11/7/23 09:01, Dan Scally wrote:
> Hi Jayant
>
> On 03/11/2023 07:28, Jayant Chowdhary wrote:
>> Hi Dan,
>> Thank you for the comments.
>> I uploaded a new patch at https://lore.kernel.org/linux-usb/20231103071353.1577383-1-jchowdhary@google.com/T/#u.
>>
>> On 11/2/23 09:07, Dan Scally wrote:
>>> Hi Jayant - thanks for the patch
>>>
>>> On 02/11/2023 06:01, Jayant Chowdhary wrote:
>>>> When we use an async work queue to perform the function of pumping
>>>> usb requests to the usb controller, it is possible that amongst other
>>>> factors, thread scheduling affects at what cadence we're able to pump
>>>> requests. This could mean isoc usb requests miss their uframes - resulting
>>>> in video stream flickers on the host device.
>>>>
>>>> To avoid this, we make the async_wq thread only produce isoc usb_requests
>>>> with uvc buffers encoded into them. The process of queueing to the
>>>> endpoint is done by the uvc_video_complete() handler. In case no
>>>> usb_requests are ready with encoded information, we just queue a zero
>>>> length request to the endpoint from the complete handler.
>>>>
>>>> For bulk endpoints the async_wq thread still queues usb requests to the
>>>> endpoint.
>>>>
>>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
>>>> Suggested-by: Avichal Rakesh <arakesh@google.com>
>>>> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>>>> ---
>>>>    Based on top of
>>>>    https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
>>>>    v1->v2: Added self Signed-Off-by and addressed review comments
>>>>    v2->v3: Encode to usb requests in async_wq; queue to ep in complete handler
>>>>       for isoc transfers.
>>>>
>>>>    drivers/usb/gadget/function/uvc.h       |   8 +
>>>>    drivers/usb/gadget/function/uvc_video.c | 187 +++++++++++++++++++-----
>>>>    2 files changed, 156 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
>>>> index e8d4c87f1e09..82c783410554 100644
>>>> --- a/drivers/usb/gadget/function/uvc.h
>>>> +++ b/drivers/usb/gadget/function/uvc.h
>>>> @@ -105,7 +105,15 @@ struct uvc_video {
>>>>        bool is_enabled; /* tracks whether video stream is enabled */
>>>>        unsigned int req_size;
>>>>        struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
>>>> +
>>>> +    /* USB requests video pump thread can encode into*/
>>> "USB requests that the video pump thread can encode into", and a space before the closing */ please (and the same a few more times below).
>> Done.
>>
>>>>        struct list_head req_free;
>>>> +
>>>> +    /*
>>>> +     * USB requests video pump thread has already encoded into. These are
>>>> +     * ready to be queued to the endpoint.
>>>> +     */
>>>> +    struct list_head req_ready;
>>>>        spinlock_t req_lock;
>>>>          unsigned int req_int_count;
>>>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
>>>> index 53feb790a4c3..c84183e9afcc 100644
>>>> --- a/drivers/usb/gadget/function/uvc_video.c
>>>> +++ b/drivers/usb/gadget/function/uvc_video.c
>>>> @@ -268,6 +268,98 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
>>>>        return ret;
>>>>    }
>>>>    +/* This function must be called with video->req_lock held*/
>>>> +static int uvcg_video_usb_req_queue(struct uvc_video *video,
>>>> +    struct usb_request *req, bool queue_to_ep) {
>>> Brace on a new line please - same a few more times below
>> Done.
>>
>>>> +    bool is_bulk = video->max_payload_size;
>>> empty line here
>>>> +    if (!video->is_enabled) {
>>>> +        uvc_video_free_request(req->context, video->ep);
>>>> +        return -ENODEV;
>>>> +    }
>>>> +    if (queue_to_ep) {
>>>> +        struct uvc_request *ureq = req->context;
>>>> +        /*
>>>> +         * With USB3 handling more requests at a higher speed, we can't
>>>> +         * afford to generate an interrupt for every request. Decide to
>>>> +         * interrupt:
>>>> +         *
>>>> +         * - When no more requests are available in the free queue, as
>>>> +         *   this may be our last chance to refill the endpoint's
>>>> +         *   request queue.
>>>> +         *
>>>> +         * - When this is request is the last request for the video
>>>> +         *   buffer, as we want to start sending the next video buffer
>>>> +         *   ASAP in case it doesn't get started already in the next
>>>> +         *   iteration of this loop.
>>>> +         *
>>>> +         * - Four times over the length of the requests queue (as
>>>> +         *   indicated by video->uvc_num_requests), as a trade-off
>>>> +         *   between latency and interrupt load.
>>>> +        */
>>>> +        if (list_empty(&video->req_free) || ureq->last_buf ||
>>>> +            !(video->req_int_count %
>>>> +            DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>>>> +            video->req_int_count = 0;
>>>> +            req->no_interrupt = 0;
>>>> +        } else {
>>>> +            req->no_interrupt = 1;
>>>> +        }
>>>> +        video->req_int_count++;
>>>> +        return uvcg_video_ep_queue(video, req);
>>>> +    } else {
>>>> +        /*
>>>> +        * If we're not queing to the ep, for isoc we're queing
>>>> +        * to the req_ready list, otherwise req_free.
>>>> +        */
>>>> +        struct list_head *list =
>>>> +            is_bulk ? &video->req_free : &video->req_ready;
>>>> +        list_add_tail(&req->list, list);
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvcg_video_ep_queue_zero_length(struct usb_request *req,
>>>> +    struct uvc_video *video) {
>>>> +    req->length = 0;
>>>> +    return uvcg_video_ep_queue(video, req);
>>>> +}
>>> Not sure this is worth its own function
>> Removed the function.
>>
>>>> +
>>>> +/* Must only be called from uvcg_video_enable - since after that we only want to
>>>> + * queue requests to the endpoint from the uvc_video_complete complete handler.
>>>> + * This function is needed in order to 'kick start' the flow of requests from
>>>> + * gadget driver to the usb controller.
>>>> + */
>>>> +static void uvc_video_ep_queue_initial_requests(struct uvc_video *video) {
>>>> +    struct usb_request *req = NULL;
>>>> +    unsigned long flags = 0;
>>>> +    unsigned int count = 0;
>>>> +    int ret = 0;
>>>> +    /* We only queue half of the free list since we still want to have
>>>> +     * some free usb_requests in the free list for the video_pump async_wq
>>>> +     * thread to encode uvc buffers into. Otherwise we could get into a
>>>> +     * situation where the free list does not have any usb requests to
>>>> +     * encode into - we always end up queueing 0 length requests to the
>>>> +     * end point.
>>>> +     */
>>>> +    unsigned half_list_size = video->uvc_num_requests / 2;
>>>> +    spin_lock_irqsave(&video->req_lock, flags);
>>>> +    /* Take these requests off the free list and queue them all to the
>>>> +     * endpoint. Since we queue the requests with the req_lock held,
>>>> +     */
>>> This comment seems to be incomplete? You also want an opening /* on its own line:
>> Apologies I think I missed out completing this comment I will send out another patch later.
>>
>>>
>>> /*
>>>   * Multi line comments
>>>   * look like this
>>>   */
>>>
>> Done.
>>
>>>> +    while (count < half_list_size) {
>>>> +        req = list_first_entry(&video->req_free, struct usb_request,
>>>> +                    list);
>>>> +        list_del(&req->list);
>>>> +        ret = uvcg_video_ep_queue_zero_length(req, video);
>>>> +        if (ret < 0) {
>>>> +            uvcg_queue_cancel(&video->queue, /*disconnect*/0);
>>>> +            break;
>>>> +        }
>>>> +        count++;
>>>> +    }
>>>> +    spin_unlock_irqrestore(&video->req_lock, flags);
>>>> +}
>>>> +
>>> So if I'm understanding the new starting sequence right for an isoc endpoint there's an initial flight of half the requests (between 2 and 32) that are queued as zero length - the very first one to .complete() being re-queued as a zero length request before the workqueue is started and encodes data into the _other_ half of the requests which were left in req_free and putting them into req_ready. At that point the .complete()s being run start to pick requests off req_ready instead and they get sent out with data...does that sound right?
>>>
>>>
>> That is correct - the first half of number of usb requests allocated (2, 32) are queued at zero length initially. We’ll have half of the requests being sent to the ep in flight and half in the free list yes.
>> queue_work will actually start with either uvc_v4l2_qbuf (uvc_v4l2.c) or at a zero length request being completed - whichever comes first.
>>
>>> What are the implications of those initial 3-33 zero length requests? What kind of latency can that introduce to the start of the video stream?
>> At the worst, we’ll have  a 32 x 125us(uframe period) = 4ms  delay for the first frame of the uvc buffer stream being sent out to the usb controller.
>> After that, since uvc buffers are typically queued at a much lower rate than usb requests being sent to the endpoint, we should be fine ?
>
>
> I think that the 'ongoing' stream should be fine using this method yes, though if possible I'd like to avoid introducing the delay to the first frame. Do you know if there's a simple way to remove it? I recognise the delay is small so I don't think it's necessarily a dealbreaker but it would be nice if we could avoid it.

We could introduce a flag and have the async_wq thread queue requests to the ep for the first uvc buffer. However, what that would do is it would possibly add a skew between the first and second frames. 
Let's say we send out frame 1 at t = 0ms. It is possible that by the time frame 2 comes around, we have 32 0 length usb requests queued up in the usb controller. As a result the time distance
between frame 1's start and frame 2's start would be 33ms + 4ms = 37ms (instead of 4ms and 37ms). So its a tradeoff between skew vs 4ms delay in starting the stream. The current logic avoids the
skew at the expense of the delay in the first frame - and its simpler to follow in code. Happy to hear your and others' thoughts on this as well.


>
>> In my local testing, I don't see any delay observable to the naked eye.
>>
>>>>    static void
>>>>    uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>>>    {
>>>> @@ -276,6 +368,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>>>        struct uvc_video_queue *queue = &video->queue;
>>>>        struct uvc_buffer *last_buf = NULL;
>>>>        unsigned long flags;
>>>> +    bool is_bulk = video->max_payload_size;
>>>> +    int ret = 0;
>>>>          spin_lock_irqsave(&video->req_lock, flags);
>>>>        if (!video->is_enabled) {
>>>> @@ -329,7 +423,38 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>>>         * back to req_free
>>>>         */
>>>>        if (video->is_enabled) {
>>>> -        list_add_tail(&req->list, &video->req_free);
>>>> +        /*
>>>> +         * Here we check whether any request is available in the ready
>>>> +         * list. If it is, queue it to the ep and add the current
>>>> +         * usb_request to the req_free list - for video_pump to fill in.
>>>> +         * Otherwise, just use the current usb_request to queue a 0
>>>> +         * length request to the ep. Since we always add to the req_free
>>>> +         * list if we dequeue from the ready list, there will never
>>>> +         * be a situation where the req_free list is completely out of
>>>> +         * requests and cannot recover.
>>>> +         */
>>>> +        struct usb_request *to_queue = req;
>>>> +        to_queue->length = 0;
>>>> +        if (!list_empty(&video->req_ready)) {
>>>> +            to_queue = list_first_entry(&video->req_ready,
>>>> +                struct usb_request, list);
>>>> +            list_del(&to_queue->list);
>>>> +            /* Add it to the free list. */
>>>> +            list_add_tail(&req->list, &video->req_free);
>>>> +        }
>>>> +        /*
>>>> +         * Queue to the endpoint. The actual queueing to ep will
>>>> +         * only happen on one thread - the async_wq for bulk endpoints
>>>> +         * and this thread for isoc endpoints.
>>>> +         */
>>>> +        ret = uvcg_video_usb_req_queue(video, to_queue,
>>>> +                           /*queue_to_ep*/!is_bulk);
>>>
>>> In principle in-line comments are fine, but I don't think the parameter name is worth a comment
>> Done.
>>
>>>> +        if(ret < 0) {
>>>> +            uvcg_queue_cancel(queue, 0);
>>>> +        }
>>>> +        /* Queue work to the wq as well since its possible that a buffer
>>>> +         * may not have been completed.
>>>> +         */
>>>
>>> The phrasing of this implies this is a bit of defensive programming, but if we don't queue to the wq here then doesn't that mean it'll never run?
>>
>> I've updated the comment here - it is possible that we hit a situation where the in-flight usb requests may not be enough to completely
>> encode a uvc buffer. In that case if we don't call queue_work, we'll never get the buffer marked as 'completed' and the buffer won't be
>> returned to user-space. That'll prevent the dequeue->queue->dequeue loop and flow of buffers.

I added this queue_work call to the if statement which checks if the ready list has any requests. If it doesn't, there's no point
in queuing any work - since we wouldn't be giving back to the req_free list.

Thank you

>>
>>>>            queue_work(video->async_wq, &video->pump);
>>>>        } else {
>>>>            uvc_video_free_request(ureq, ep);
>>>> @@ -347,6 +472,7 @@ uvc_video_free_requests(struct uvc_video *video)
>>>>          INIT_LIST_HEAD(&video->ureqs);
>>>>        INIT_LIST_HEAD(&video->req_free);
>>>> +    INIT_LIST_HEAD(&video->req_ready);
>>>>        video->req_size = 0;
>>>>        return 0;
>>>>    }
>>>> @@ -424,8 +550,7 @@ static void uvcg_video_pump(struct work_struct *work)
>>>>        struct usb_request *req = NULL;
>>>>        struct uvc_buffer *buf;
>>>>        unsigned long flags;
>>>> -    bool buf_done;
>>>> -    int ret;
>>>> +    int ret = 0;
>>>>          while (true) {
>>>>            if (!video->ep->enabled)
>>>> @@ -454,7 +579,6 @@ static void uvcg_video_pump(struct work_struct *work)
>>>>              if (buf != NULL) {
>>>>                video->encode(req, video, buf);
>>>> -            buf_done = buf->state == UVC_BUF_STATE_DONE;
>>>>            } else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
>>>>                /*
>>>>                 * No video buffer available; the queue is still connected and
>>>> @@ -462,7 +586,6 @@ static void uvcg_video_pump(struct work_struct *work)
>>>>                 * prevent missed ISOC transfers.
>>>>                 */
>>>>                req->length = 0;
>>>> -            buf_done = false;
>>>>            } else {
>>>>                /*
>>>>                 * Either the queue has been disconnected or no video buffer
>>>> @@ -473,45 +596,26 @@ static void uvcg_video_pump(struct work_struct *work)
>>>>                break;
>>>>            }
>>>>    -        /*
>>>> -         * With USB3 handling more requests at a higher speed, we can't
>>>> -         * afford to generate an interrupt for every request. Decide to
>>>> -         * interrupt:
>>>> -         *
>>>> -         * - When no more requests are available in the free queue, as
>>>> -         *   this may be our last chance to refill the endpoint's
>>>> -         *   request queue.
>>>> -         *
>>>> -         * - When this is request is the last request for the video
>>>> -         *   buffer, as we want to start sending the next video buffer
>>>> -         *   ASAP in case it doesn't get started already in the next
>>>> -         *   iteration of this loop.
>>>> -         *
>>>> -         * - Four times over the length of the requests queue (as
>>>> -         *   indicated by video->uvc_num_requests), as a trade-off
>>>> -         *   between latency and interrupt load.
>>>> -         */
>>>> -        if (list_empty(&video->req_free) || buf_done ||
>>>> -            !(video->req_int_count %
>>>> -               DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>>>> -            video->req_int_count = 0;
>>>> -            req->no_interrupt = 0;
>>>> -        } else {
>>>> -            req->no_interrupt = 1;
>>>> -        }
>>>> -
>>>> -        /* Queue the USB request */
>>>> -        ret = uvcg_video_ep_queue(video, req);
>>>>            spin_unlock_irqrestore(&queue->irqlock, flags);
>>>>    +        /* Queue the USB request.*/
>>> I think just drop this - it was always superfluous.
>> The uvcg_video_usb_req_queue function mentions that req_lock must be held while calling
>> it - since its possible we might add to the req_ready list. We could say the function
>> should hold req_lock only when the queue_to_ep parameter is false - but that doesn't
>> seem as clean ?
>
>
> Sorry - I wasn't clear here. I meant that the comment "Queue the USB request" was superfluous rather than the spin_lock_irqsave()

Removed.

>
>>
>>>> +        spin_lock_irqsave(&video->req_lock, flags);
>>>> +        /* For bulk end points we queue from the worker thread
>>>> +         * since we would preferably not want to wait on requests
>>>> +         * to be ready, in the uvcg_video_complete() handler.
>>>> +         * For isoc endpoints we add the request to the ready list
>>>> +         * and only queue it to the endpoint from the complete handler.
>>>> +         */
>>>> +        ret = uvcg_video_usb_req_queue(video, req, is_bulk);
>>>> +        spin_unlock_irqrestore(&video->req_lock, flags);
>>>> +
>>>>            if (ret < 0) {
>>>>                uvcg_queue_cancel(queue, 0);
>>>>                break;
>>>>            }
>>>>    -        /* Endpoint now owns the request */
>>>> +        /* The request is owned by  the endpoint / ready list*/
>>>>            req = NULL;
>>>> -        video->req_int_count++;
>>>>        }
>>>>          if (!req)
>>>> @@ -567,7 +671,7 @@ uvcg_video_disable(struct uvc_video *video)
>>>>          spin_lock_irqsave(&video->req_lock, flags);
>>>>        /*
>>>> -     * Remove all uvc_reqeusts from ureqs with list_del_init
>>>> +     * Remove all uvc_requests from ureqs with list_del_init
>>> This should get fixed in the earlier series.
>>>>         * This lets uvc_video_free_request correctly identify
>>>>         * if the uvc_request is attached to a list or not when freeing
>>>>         * memory.
>>>> @@ -579,9 +683,13 @@ uvcg_video_disable(struct uvc_video *video)
>>>>            list_del(&req->list);
>>>>            uvc_video_free_request(req->context, video->ep);
>>>>        }
>>>> -
>>> keep the empty line please
>> Done.
>>
>>>> +    list_for_each_entry_safe(req, temp, &video->req_ready, list) {
>>>> +        list_del(&req->list);
>>>> +        uvc_video_free_request(req->context, video->ep);
>>>> +    }
>>> and one here too.
>> Done.
>>
>> Thanks!
>>
>>>>        INIT_LIST_HEAD(&video->ureqs);
>>>>        INIT_LIST_HEAD(&video->req_free);
>>>> +    INIT_LIST_HEAD(&video->req_ready);
>>>>        video->req_size = 0;
>>>>        spin_unlock_irqrestore(&video->req_lock, flags);
>>>>    @@ -635,7 +743,7 @@ int uvcg_video_enable(struct uvc_video *video)
>>>>          video->req_int_count = 0;
>>>>    -    queue_work(video->async_wq, &video->pump);
>>>> +    uvc_video_ep_queue_initial_requests(video);
>>>>          return ret;
>>>>    }
>>>> @@ -648,6 +756,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>>>>        video->is_enabled = false;
>>>>        INIT_LIST_HEAD(&video->ureqs);
>>>>        INIT_LIST_HEAD(&video->req_free);
>>>> +    INIT_LIST_HEAD(&video->req_ready);
>>>>        spin_lock_init(&video->req_lock);
>>>>        INIT_WORK(&video->pump, uvcg_video_pump);
>>>>    
