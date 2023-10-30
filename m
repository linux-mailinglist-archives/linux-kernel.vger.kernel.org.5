Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E887DC12E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJ3U0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjJ3U0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:26:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B728F7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:26:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso31618135ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698697600; x=1699302400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u379CNnktvWACo/s1StahJ+ZYC1uQssAJnCQgDCpkVM=;
        b=tdJC/IFOScn+Mslr+4BKn9VJa55D3y/FSXmwvmHdZbQNugeBm9iqgKbflLCWfSdC0i
         xDE0qhuSGt2yklhhH8jzeXv3hwottChXjWYFQ7Y+DVV9SgloFYzrw8OVKdBk8cH6/Hnk
         K6iVtSpWEt0fKdVFyUShMiVy1dd5KbjZ8K2u+D/2cb+K9lIhOHZzsY+vs2v9MdXnKFNy
         Oc0OUKf+ZuKTcqsF9ibaXT82hANNgc4r3XAu6GcZFUB1TtwkBtn59j9H2zZU0oaMbwdk
         CGwVytCc0gP/kPz/Z5OCEnF2R15B+M9gDoPV8US3ojbY0BsOU24CN/UQfVzZEfDw5RuY
         E5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697600; x=1699302400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u379CNnktvWACo/s1StahJ+ZYC1uQssAJnCQgDCpkVM=;
        b=g+SdRLZ817Ii7JsWdOLi7zp+hLXPapL4B/w90J9dLuUCVmDyNc+BKK93hV2IW5g85y
         l1UT0RFFFreXsbgj2DLlwvuua4jGIOcqLXAUKpyOFRdKGW4ic7V163V/BuyIAMLGwxrG
         sQVedczvUTqp/m2J8Mmwd/LM7eYi7l9L8Lwu+/zObVwaXk2kxh3RIUGk/jK/ytNj9Fzc
         8vB3z2pdN/4adpT4hjYntFU8yEYXJucZfg9S34BwPO9DcQ27oEcLEAJSjb382FYcAEnb
         MiuuCtO5nHxjLT9UpHNQATGCoT0S9oYcRlWT5mnwS5B5Jyq06EWmvBvdE/vLXhxfgI+i
         kUug==
X-Gm-Message-State: AOJu0Yw71n6YD69ZHHCJ4lVbZfCNWsAqr3RQRCJ/CQxWbC7tBAHFwgtd
        lu1ctvEdiA2cv+QdfMp6So9Ybg==
X-Google-Smtp-Source: AGHT+IGUiB/WLjGhWKHRO7sSwy+UZLvqFCu9y52iYAEz61DVBAkQqxQOVpMpUlcAUFQYrPgF4jbu9A==
X-Received: by 2002:a17:903:2344:b0:1cc:5a74:b1df with SMTP id c4-20020a170903234400b001cc5a74b1dfmr2494224plh.2.1698697599421;
        Mon, 30 Oct 2023 13:26:39 -0700 (PDT)
Received: from [192.168.60.239] (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001cc29ffcd96sm5687846plb.192.2023.10.30.13.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 13:26:38 -0700 (PDT)
Message-ID: <be7c3f52-eb50-4be8-8be5-01e9e0dbd589@google.com>
Date:   Mon, 30 Oct 2023 13:26:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] usb: gadget: uvc: Allocate uvc_requests one at a
 time
Content-Language: en-US
To:     Dan Scally <dan.scally@ideasonboard.com>
Cc:     etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
 <20231027201959.1869181-1-arakesh@google.com>
 <20231027201959.1869181-2-arakesh@google.com>
 <5f21a75f-7b09-4e17-b300-b5fb0ff12807@ideasonboard.com>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <5f21a75f-7b09-4e17-b300-b5fb0ff12807@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/23 13:13, Dan Scally wrote:
> Hi Avichal
> 
> On 27/10/2023 21:19, Avichal Rakesh wrote:
>> Currently, the uvc gadget driver allocates all uvc_requests as one array
>> and deallocates them all when the video stream stops. This includes
>> de-allocating all the usb_requests associated with those uvc_requests.
>> This can lead to use-after-free issues if any of those de-allocated
>> usb_requests were still owned by the usb controller.
>>
>> This patch is 1 of 2 patches addressing the use-after-free issue.
>> Instead of bulk allocating all uvc_requests as an array, this patch
>> allocates uvc_requests one at a time, which should allows for similar
>> granularity when deallocating the uvc_requests. This patch has no
>> functional changes other than allocating each uvc_request separately,
>> and similarly freeing each of them separately.
>>
>> Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
>> Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> 
> 
> Sorry - I was unclear in my response to the first patch on v8. I meant my R-b to apply to the first patch only rather than to all of them. For this one I understand now the use of the conditional in uvc_video_free_request(), so that point is fine. I agree with Greg that the BUG_ON() shouldn't stand though.

Ah, didn't realize BUG_ON is discouraged. Removed BUG_ON. 
It was supposed to be a defensive bit of code anyway, 
so removing the check entirely. If the state is 
inconsistent, we'd see other errors, so the BUG_ON 
wasn't providing value anyway.

Also removed your Reviewed-by, my apologies.

> 
>> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Signed-off-by: Avichal Rakesh <arakesh@google.com>
>> ---
>> v1 -> v2: Rebased to ToT
>> v2 -> v3: Fix email threading goof-up
>> v3 -> v4: Address review comments & re-rebase to ToT
>> v4 -> v5: Address more review comments. Add Reviewed-by & Tested-by.
>> v5 -> v6: No change
>> v6 -> v7: No change
>> v7 -> v8: No change. Getting back in review queue
>> v8 -> v9: Address review comments.
>>
>>   drivers/usb/gadget/function/uvc.h       |  3 +-
>>   drivers/usb/gadget/function/uvc_video.c | 89 ++++++++++++++-----------
>>   2 files changed, 52 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
>> index 989bc6b4e93d..993694da0bbc 100644
>> --- a/drivers/usb/gadget/function/uvc.h
>> +++ b/drivers/usb/gadget/function/uvc.h
>> @@ -81,6 +81,7 @@ struct uvc_request {
>>       struct sg_table sgt;
>>       u8 header[UVCG_REQUEST_HEADER_LEN];
>>       struct uvc_buffer *last_buf;
>> +    struct list_head list;
>>   };
>>
>>   struct uvc_video {
>> @@ -102,7 +103,7 @@ struct uvc_video {
>>
>>       /* Requests */
>>       unsigned int req_size;
>> -    struct uvc_request *ureq;
>> +    struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
>>       struct list_head req_free;
>>       spinlock_t req_lock;
>>
>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
>> index c334802ac0a4..f8f9209fee50 100644
>> --- a/drivers/usb/gadget/function/uvc_video.c
>> +++ b/drivers/usb/gadget/function/uvc_video.c
>> @@ -227,6 +227,24 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
>>    * Request handling
>>    */
>>
>> +static void
>> +uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
>> +{
>> +    sg_free_table(&ureq->sgt);
>> +    if (ureq->req && ep) {
>> +        usb_ep_free_request(ep, ureq->req);
>> +        ureq->req = NULL;
>> +    }
>> +
>> +    kfree(ureq->req_buffer);
>> +    ureq->req_buffer = NULL;
>> +
>> +    if (!list_empty(&ureq->list))
>> +        list_del_init(&ureq->list);
>> +
>> +    kfree(ureq);
>> +}
>> +
>>   static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
>>   {
>>       int ret;
>> @@ -293,27 +311,12 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>   static int
>>   uvc_video_free_requests(struct uvc_video *video)
>>   {
>> -    unsigned int i;
>> -
>> -    if (video->ureq) {
>> -        for (i = 0; i < video->uvc_num_requests; ++i) {
>> -            sg_free_table(&video->ureq[i].sgt);
>> +    struct uvc_request *ureq, *temp;
>>
>> -            if (video->ureq[i].req) {
>> -                usb_ep_free_request(video->ep, video->ureq[i].req);
>> -                video->ureq[i].req = NULL;
>> -            }
>> -
>> -            if (video->ureq[i].req_buffer) {
>> -                kfree(video->ureq[i].req_buffer);
>> -                video->ureq[i].req_buffer = NULL;
>> -            }
>> -        }
>> -
>> -        kfree(video->ureq);
>> -        video->ureq = NULL;
>> -    }
>> +    list_for_each_entry_safe(ureq, temp, &video->ureqs, list)
>> +        uvc_video_free_request(ureq, video->ep);
>>
>> +    INIT_LIST_HEAD(&video->ureqs);
>>       INIT_LIST_HEAD(&video->req_free);
>>       video->req_size = 0;
>>       return 0;
>> @@ -322,39 +325,45 @@ uvc_video_free_requests(struct uvc_video *video)
>>   static int
>>   uvc_video_alloc_requests(struct uvc_video *video)
>>   {
>> +    struct uvc_request *ureq;
>>       unsigned int req_size;
>>       unsigned int i;
>>       int ret = -ENOMEM;
>>
>>       BUG_ON(video->req_size);
>> +    BUG_ON(!list_empty(&video->ureqs));
>>
>>       req_size = video->ep->maxpacket
>>            * max_t(unsigned int, video->ep->maxburst, 1)
>>            * (video->ep->mult);
>>
>> -    video->ureq = kcalloc(video->uvc_num_requests, sizeof(struct uvc_request), GFP_KERNEL);
>> -    if (video->ureq == NULL)
>> -        return -ENOMEM;
>> +    for (i = 0; i < video->uvc_num_requests; i++) {
>> +        ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
>> +        if (ureq == NULL)
>> +            goto error;
>> +
>> +        INIT_LIST_HEAD(&ureq->list);
>> +
>> +        list_add_tail(&ureq->list, &video->ureqs);
>>
>> -    for (i = 0; i < video->uvc_num_requests; ++i) {
>> -        video->ureq[i].req_buffer = kmalloc(req_size, GFP_KERNEL);
>> -        if (video->ureq[i].req_buffer == NULL)
>> +        ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
>> +        if (ureq->req_buffer == NULL)
>>               goto error;
>>
>> -        video->ureq[i].req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
>> -        if (video->ureq[i].req == NULL)
>> +        ureq->req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
>> +        if (ureq->req == NULL)
>>               goto error;
>>
>> -        video->ureq[i].req->buf = video->ureq[i].req_buffer;
>> -        video->ureq[i].req->length = 0;
>> -        video->ureq[i].req->complete = uvc_video_complete;
>> -        video->ureq[i].req->context = &video->ureq[i];
>> -        video->ureq[i].video = video;
>> -        video->ureq[i].last_buf = NULL;
>> +        ureq->req->buf = ureq->req_buffer;
>> +        ureq->req->length = 0;
>> +        ureq->req->complete = uvc_video_complete;
>> +        ureq->req->context = ureq;
>> +        ureq->video = video;
>> +        ureq->last_buf = NULL;
>>
>> -        list_add_tail(&video->ureq[i].req->list, &video->req_free);
>> +        list_add_tail(&ureq->req->list, &video->req_free);
>>           /* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
>> -        sg_alloc_table(&video->ureq[i].sgt,
>> +        sg_alloc_table(&ureq->sgt,
>>                      DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
>>                           PAGE_SIZE) + 2, GFP_KERNEL);
>>       }
>> @@ -489,8 +498,8 @@ static void uvcg_video_pump(struct work_struct *work)
>>    */
>>   int uvcg_video_enable(struct uvc_video *video, int enable)
>>   {
>> -    unsigned int i;
>>       int ret;
>> +    struct uvc_request *ureq;
>>
>>       if (video->ep == NULL) {
>>           uvcg_info(&video->uvc->func,
>> @@ -502,9 +511,10 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
>>           cancel_work_sync(&video->pump);
>>           uvcg_queue_cancel(&video->queue, 0);
>>
>> -        for (i = 0; i < video->uvc_num_requests; ++i)
>> -            if (video->ureq && video->ureq[i].req)
>> -                usb_ep_dequeue(video->ep, video->ureq[i].req);
>> +        list_for_each_entry(ureq, &video->ureqs, list) {
>> +            if (ureq->req)
>> +                usb_ep_dequeue(video->ep, ureq->req);
>> +        }
>>
>>           uvc_video_free_requests(video);
>>           uvcg_queue_enable(&video->queue, 0);
>> @@ -536,6 +546,7 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
>>    */
>>   int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>>   {
>> +    INIT_LIST_HEAD(&video->ureqs);
>>       INIT_LIST_HEAD(&video->req_free);
>>       spin_lock_init(&video->req_lock);
>>       INIT_WORK(&video->pump, uvcg_video_pump);
>> -- 
>> 2.42.0.820.g83a721a137-goog
