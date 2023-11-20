Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98D7F0BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 07:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjKTGa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 01:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTGa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 01:30:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CE8E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 22:30:51 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bd85b1939aso2117532a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 22:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700461851; x=1701066651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgbYm7C9NcGHbE7dhV4gaQ9NcBAFiICH/NxULjDdXk8=;
        b=CODOTiwOOwYQf27PHjLW8zyxeenPlKqkeFbF3rfQOJ3ZAMbV8Hm6Kl2GMX1PHPZW4Q
         JomM4beA1tXADw0EYSGK0yqVuv8TL3gqv5J87NtKUkyJuEZAUwG4uODw1UrlBttrL2ES
         +MZzjJIZCiLGyY0Rv364PEf4MznAV9nHjJCWSZOzxKS4fyNtlRqlh8zYXQxx982OoWIc
         CnBZeFPA4WhXJAIBqcT87mIhbHExhn2pWPTSW+P8koAsjvF0IIEqgoNgeSMx8OWjGRky
         Qc4d2HgJ3TNzm8Q3U/FWo1o89SUbqvtf64cxsnJbV92hdBppST263zGQ6kg7h/ncBxap
         JaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700461851; x=1701066651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgbYm7C9NcGHbE7dhV4gaQ9NcBAFiICH/NxULjDdXk8=;
        b=UrmEp9nXzFsaeudnsg3CQ/R4UgwVbl09fE08ZkxFWdyVGN9Je9gmDd8ECgFetx/vah
         7MQTKhWz3Bezy79s50b+4VSkOzCr0KUNZJuuHH2iNCNaZANjQAEMU8qzvqsHsnUhgBxl
         3vOwyU2tADbQTicvzCemHLfZzrCeZlTMnX5kg5f1ucnygZiSAiWkUFjpJRGSliEHtO0t
         /Zx4yN1kNnvhUxyC5hbEil2W8roqsa76G+athPROR8bG/lIOCfG6QYcshNchB965KrIP
         Slit5mKlcZi//TrZj/S4rvbtvlWKNCt4HjAYeGSGYaoCE+3V+aVnTXp7r/yc77G29EWT
         4SzQ==
X-Gm-Message-State: AOJu0YztMrQx7XrPgJGqGbRb2INU74pghEnODf5LKdBiqk+0XIwMjdji
        Jt4TB8vx7wQnoNprGIw7HzxdCA==
X-Google-Smtp-Source: AGHT+IG3Ak00lhnbQquEjERb4Bfi1zvmaHLO7+reUa4dZ874WCHSQOj/qZ1aD5sBgLqGW6kH3PT0Ig==
X-Received: by 2002:a05:6a20:6a10:b0:187:f152:3dfe with SMTP id p16-20020a056a206a1000b00187f1523dfemr4665615pzk.44.1700461850504;
        Sun, 19 Nov 2023 22:30:50 -0800 (PST)
Received: from ?IPV6:2601:645:8100:1350:19c1:be6c:b339:6609? ([2601:645:8100:1350:19c1:be6c:b339:6609])
        by smtp.gmail.com with ESMTPSA id ei5-20020a056a0080c500b006cb9e60704esm975346pfb.166.2023.11.19.22.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 22:30:50 -0800 (PST)
Message-ID: <e304ccd9-67a2-43ff-b2aa-dd3d3587d805@google.com>
Date:   Sun, 19 Nov 2023 22:30:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] usb:gadget:uvc Do not use worker thread to pump isoc
 usb requests
Content-Language: en-US
To:     Dan Scally <dan.scally@ideasonboard.com>,
        stern@rowland.harvard.edu, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org
Cc:     Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20231109021251.542558-1-jchowdhary@google.com>
 <20231109073453.751860-1-jchowdhary@google.com>
 <908009f0-e2b5-4330-a9f7-48b13f6ed528@ideasonboard.com>
From:   Jayant Chowdhary <jchowdhary@google.com>
In-Reply-To: <908009f0-e2b5-4330-a9f7-48b13f6ed528@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,
Thanks for the comments. I've uploaded a new patch at https://lore.kernel.org/linux-usb/20231120062026.3759463-1-jchowdhary@google.com/T/#u.

On 11/16/23 02:09, Dan Scally wrote:
> Hi Jayant, thanks for the update. I just have a couple of styling comments.
>
> On 09/11/2023 07:34, Jayant Chowdhary wrote:
>> When we use an async work queue to perform the function of pumping
>> usb requests to the usb controller, it is possible that amongst other
>> factors, thread scheduling affects at what cadence we're able to pump
>> requests. This could mean isoc usb requests miss their uframes - resulting
>> in video stream flickers on the host device.
>>
>> To avoid this, we make the async_wq thread only produce isoc usb_requests
>> with uvc buffers encoded into them. The process of queueing to the
>> endpoint is done by the uvc_video_complete() handler. In case no
>> usb_requests are ready with encoded information, we just queue a zero
>> length request to the endpoint from the complete handler.
>>
>> For bulk endpoints the async_wq thread still queues usb requests to the
>> endpoint.
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
>> Suggested-by: Avichal Rakesh <arakesh@google.com>
>> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>> ---
>>   Based on top of
>>   https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
>>   v1->v2: Added self Signed-Off-by and addressed review comments
>>   v2->v3: Encode to usb requests in async_wq; queue to ep in complete handler
>>      for isoc transfers.
>>   v3->v4: Address review comments around code style.
>>   v4->v5: Update comments. Remove 0 length request queueing from async_wq
>>      thread since it is already done by the complete handler.
>>   v5->v6: Fix checkpatch.pl suggestions.
>>
>>   drivers/usb/gadget/function/uvc.h       |   8 +
>>   drivers/usb/gadget/function/uvc_video.c | 204 ++++++++++++++++++------
>>   2 files changed, 166 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
>> index e8d4c87f1e09..5ff454528bd8 100644
>> --- a/drivers/usb/gadget/function/uvc.h
>> +++ b/drivers/usb/gadget/function/uvc.h
>> @@ -105,7 +105,15 @@ struct uvc_video {
>>       bool is_enabled; /* tracks whether video stream is enabled */
>>       unsigned int req_size;
>>       struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
>> +
>> +    /* USB requests that the video pump thread can encode into */
>>       struct list_head req_free;
>> +
>> +    /*
>> +     * USB requests video pump thread has already encoded into. These are
>> +     * ready to be queued to the endpoint.
>> +     */
>> +    struct list_head req_ready;
>>       spinlock_t req_lock;
>>         unsigned int req_int_count;
>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
>> index 53feb790a4c3..d5311456fa8a 100644
>> --- a/drivers/usb/gadget/function/uvc_video.c
>> +++ b/drivers/usb/gadget/function/uvc_video.c
>> @@ -268,6 +268,100 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
>>       return ret;
>>   }
>>   +/* This function must be called with video->req_lock held. */
>> +static int uvcg_video_usb_req_queue(struct uvc_video *video,
>> +    struct usb_request *req, bool queue_to_ep)
>> +{
>> +    bool is_bulk = video->max_payload_size;
>> +    struct list_head *list = NULL;
>> +
>> +    if (!video->is_enabled) {
>> +        uvc_video_free_request(req->context, video->ep);
>> +        return -ENODEV;
>> +    }
>> +    if (queue_to_ep) {
>> +        struct uvc_request *ureq = req->context;
>> +        /*
>> +         * With USB3 handling more requests at a higher speed, we can't
>> +         * afford to generate an interrupt for every request. Decide to
>> +         * interrupt:
>> +         *
>> +         * - When no more requests are available in the free queue, as
>> +         *   this may be our last chance to refill the endpoint's
>> +         *   request queue.
>> +         *
>> +         * - When this is request is the last request for the video
>> +         *   buffer, as we want to start sending the next video buffer
>> +         *   ASAP in case it doesn't get started already in the next
>> +         *   iteration of this loop.
>> +         *
>> +         * - Four times over the length of the requests queue (as
>> +         *   indicated by video->uvc_num_requests), as a trade-off
>> +         *   between latency and interrupt load.
>> +         */
>> +        if (list_empty(&video->req_free) || ureq->last_buf ||
>> +            !(video->req_int_count %
>> +            DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>> +            video->req_int_count = 0;
>> +            req->no_interrupt = 0;
>> +        } else {
>> +            req->no_interrupt = 1;
>> +        }
>> +        video->req_int_count++;
>> +        return uvcg_video_ep_queue(video, req);
>> +    }
>> +    /*
>> +     * If we're not queuing to the ep, for isoc we're queuing
>> +     * to the req_ready list, otherwise req_free.
>> +     */
>> +    list = is_bulk ? &video->req_free : &video->req_ready;
>> +    list_add_tail(&req->list, list);
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Must only be called from uvcg_video_enable - since after that we only want to
>> + * queue requests to the endpoint from the uvc_video_complete complete handler.
>> + * This function is needed in order to 'kick start' the flow of requests from
>> + * gadget driver to the usb controller.
>> + */
>> +static void uvc_video_ep_queue_initial_requests(struct uvc_video *video)
>> +{
>> +    struct usb_request *req = NULL;
>> +    unsigned long flags = 0;
>> +    unsigned int count = 0;
>> +    int ret = 0;
> Add an empty line here please

Done.

>> +    /*
>> +     * We only queue half of the free list since we still want to have
>> +     * some free usb_requests in the free list for the video_pump async_wq
>> +     * thread to encode uvc buffers into. Otherwise we could get into a
>> +     * situation where the free list does not have any usb requests to
>> +     * encode into - we always end up queueing 0 length requests to the
>> +     * end point.
>> +     */
>> +    unsigned int half_list_size = video->uvc_num_requests / 2;
>> +
>> +    spin_lock_irqsave(&video->req_lock, flags);
>> +    /*
>> +     * Take these requests off the free list and queue them all to the
>> +     * endpoint. Since we queue 0 length requests with the req_lock held,
>> +     * there isn't any 'data' race involved here with the complete handler.
>> +     */
>> +    while (count < half_list_size) {
>> +        req = list_first_entry(&video->req_free, struct usb_request,
>> +                    list);
>> +        list_del(&req->list);
>> +        req->length = 0;
>> +        ret = uvcg_video_ep_queue(video, req);
>> +        if (ret < 0) {
>> +            uvcg_queue_cancel(&video->queue, /*disconnect*/0);
>
>
> Drop the /*disconnect*/ comment please

Done.

>
>> +            break;
>> +        }
>> +        count++;
>> +    }
>> +    spin_unlock_irqrestore(&video->req_lock, flags);
>> +}
>> +
>>   static void
>>   uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>   {
>> @@ -276,6 +370,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>       struct uvc_video_queue *queue = &video->queue;
>>       struct uvc_buffer *last_buf = NULL;
>>       unsigned long flags;
>> +    bool is_bulk = video->max_payload_size;
>> +    int ret = 0;
>>         spin_lock_irqsave(&video->req_lock, flags);
>>       if (!video->is_enabled) {
>> @@ -329,8 +425,46 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>        * back to req_free
>>        */
>>       if (video->is_enabled) {
>> -        list_add_tail(&req->list, &video->req_free);
>> -        queue_work(video->async_wq, &video->pump);
>> +        /*
>> +         * Here we check whether any request is available in the ready
>> +         * list. If it is, queue it to the ep and add the current
>> +         * usb_request to the req_free list - for video_pump to fill in.
>> +         * Otherwise, just use the current usb_request to queue a 0
>> +         * length request to the ep. Since we always add to the req_free
>> +         * list if we dequeue from the ready list, there will never
>> +         * be a situation where the req_free list is completely out of
>> +         * requests and cannot recover.
>> +         */
>> +        struct usb_request *to_queue = req;
>> +
>> +        to_queue->length = 0;
>> +        if (!list_empty(&video->req_ready)) {
>> +            to_queue = list_first_entry(&video->req_ready,
>> +                struct usb_request, list);
>> +            list_del(&to_queue->list);
>> +            /* Add it to the free list. */
> I would drop the "Add it to the free list" comment; the code is clear already.

Done.

>> +            list_add_tail(&req->list, &video->req_free);
>> +            /*
>> +             * Queue work to the wq as well since it is possible that a
>> +             * buffer may not have been completely encoded with the set of
>> +             * in-flight usb requests for whih the complete callbacks are
>> +             * firing.
>> +             * In that case, if we do not queue work to the worker thread,
>> +             * the buffer will never be marked as complete - and therefore
>> +             * not be returned to userpsace. As a result,
>> +             * dequeue -> queue -> dequeue flow of uvc buffers will not
>> +             * happen.
>> +             */
>> +            queue_work(video->async_wq, &video->pump);
>> +        }
>> +        /*
>> +         * Queue to the endpoint. The actual queueing to ep will
>> +         * only happen on one thread - the async_wq for bulk endpoints
>> +         * and this thread for isoc endpoints.
>> +         */
>> +        ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
>> +        if (ret < 0)
>> +            uvcg_queue_cancel(queue, 0);
>>       } else {
>>           uvc_video_free_request(ureq, ep);
>>       }
>> @@ -347,6 +481,7 @@ uvc_video_free_requests(struct uvc_video *video)
>>         INIT_LIST_HEAD(&video->ureqs);
>>       INIT_LIST_HEAD(&video->req_free);
>> +    INIT_LIST_HEAD(&video->req_ready);
>>       video->req_size = 0;
>>       return 0;
>>   }
>> @@ -424,8 +559,7 @@ static void uvcg_video_pump(struct work_struct *work)
>>       struct usb_request *req = NULL;
>>       struct uvc_buffer *buf;
>>       unsigned long flags;
>> -    bool buf_done;
>> -    int ret;
>> +    int ret = 0;
>>         while (true) {
>>           if (!video->ep->enabled)
>> @@ -454,15 +588,6 @@ static void uvcg_video_pump(struct work_struct *work)
>>             if (buf != NULL) {
>>               video->encode(req, video, buf);
>> -            buf_done = buf->state == UVC_BUF_STATE_DONE;
>> -        } else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
>> -            /*
>> -             * No video buffer available; the queue is still connected and
>> -             * we're transferring over ISOC. Queue a 0 length request to
>> -             * prevent missed ISOC transfers.
>> -             */
>> -            req->length = 0;
>> -            buf_done = false;
>>           } else {
>>               /*
>>                * Either the queue has been disconnected or no video buffer
>> @@ -473,45 +598,25 @@ static void uvcg_video_pump(struct work_struct *work)
>>               break;
>>           }
>>   -        /*
>> -         * With USB3 handling more requests at a higher speed, we can't
>> -         * afford to generate an interrupt for every request. Decide to
>> -         * interrupt:
>> -         *
>> -         * - When no more requests are available in the free queue, as
>> -         *   this may be our last chance to refill the endpoint's
>> -         *   request queue.
>> -         *
>> -         * - When this is request is the last request for the video
>> -         *   buffer, as we want to start sending the next video buffer
>> -         *   ASAP in case it doesn't get started already in the next
>> -         *   iteration of this loop.
>> -         *
>> -         * - Four times over the length of the requests queue (as
>> -         *   indicated by video->uvc_num_requests), as a trade-off
>> -         *   between latency and interrupt load.
>> -         */
>> -        if (list_empty(&video->req_free) || buf_done ||
>> -            !(video->req_int_count %
>> -               DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>> -            video->req_int_count = 0;
>> -            req->no_interrupt = 0;
>> -        } else {
>> -            req->no_interrupt = 1;
>> -        }
>> -
>> -        /* Queue the USB request */
>> -        ret = uvcg_video_ep_queue(video, req);
>>           spin_unlock_irqrestore(&queue->irqlock, flags);
>>   +        spin_lock_irqsave(&video->req_lock, flags);
>> +        /* For bulk end points we queue from the worker thread
>> +         * since we would preferably not want to wait on requests
>> +         * to be ready, in the uvcg_video_complete() handler.
>> +         * For isoc endpoints we add the request to the ready list
>> +         * and only queue it to the endpoint from the complete handler.
>> +         */
>> +        ret = uvcg_video_usb_req_queue(video, req, is_bulk);
>> +        spin_unlock_irqrestore(&video->req_lock, flags);
>> +
>>           if (ret < 0) {
>>               uvcg_queue_cancel(queue, 0);
>>               break;
>>           }
>>   -        /* Endpoint now owns the request */
>> +        /* The request is owned by  the endpoint / ready list. */
>>           req = NULL;
>> -        video->req_int_count++;
>>       }
>>         if (!req)
>> @@ -567,7 +672,7 @@ uvcg_video_disable(struct uvc_video *video)
>>         spin_lock_irqsave(&video->req_lock, flags);
>>       /*
>> -     * Remove all uvc_reqeusts from ureqs with list_del_init
>> +    * Remove all uvc_requests from ureqs with list_del_init
>
> Did the alignment of the * get messed up here as well as the typo fix or is it just my mail client being weird?
>

I think the alignment did indeed get messed up. Fixed.

Thank you,

Jayant

