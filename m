Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30207B433A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjI3TQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjI3TQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 15:16:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F8C6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 12:16:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdf4752c3cso110752575ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696101398; x=1696706198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27rEL8ffBLkGXPTJMuvmpCcAKo0agRIbH/GCs7U29Js=;
        b=leBRkDZ9I3FA1lDd+NCxZzUhhBhDe9nw0H0xk+OuEX41DvcZuxDoMXUvQrlTV+bu9k
         Qn12wwvqd2PNDpgOaUA7NOr0M/AdAmKbShaV8q6lTmv6qgQrvI+bpfOSvSeKr/Vqh7uW
         w66g+nLqjbi7PDFWyGdHzmIEJ+fZ7GkNy3/gsZw542Oy2MqsRdGLXqOjrQef17xsZ2Ax
         zp6jp0q9POfr6xlhpwCP5NxqDMzuLSxK7rm0ifob7Kz8sGyF37ttiPraVp7C93ux8Dp5
         QKKXZOK1hbV9grbKBHgflG9bqzpi73YEHhckz7bonPLnWTCpL6sOK1/W4mfC0JJzqf+w
         KLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696101398; x=1696706198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27rEL8ffBLkGXPTJMuvmpCcAKo0agRIbH/GCs7U29Js=;
        b=UapsVBfwRdg+uiNNDY//G29Ld74i/QZGIpCipsujVnTeBnjkZE2VD3WjJYIP8F0GnU
         vRmT6AGJ63BszI7tO784oUqA0cGoBs70Fz6KaYtLgLv1Zjmw5sb9csj+ddocHom47lJ6
         wPSIJeJ34bfhACHbv8/P4QY7pcM2usTczsUCFDPkJQkaRJX1Nhya6MOwczy+CgIUcz6E
         M5hhM862fgFEwDrp0aLdPL5CsPkvATAQ6hHd1xkFgnqUgFaZHBBb9I1iRCzZSKdfeNMG
         t/JAsI9CP2ntSl7Jn01ERa23EuMn2hvFSpZR9pRSXFthBMfSVd6XuebuiE19Yr7Stps9
         QH3A==
X-Gm-Message-State: AOJu0YxfKDddabchBSMQlyy7YQNyUx2h2Pj/XDG6ZqT+6ZKlLAdoYhDP
        pj3FiN6AAlEq7rgGfSJTOcjGTQ==
X-Google-Smtp-Source: AGHT+IFrr2TZ2P57TzALGutRG3xlhru7E56k3miikt8tJ7TG26dIrRrwg4H4kUsXR5o27hC6BcrsCg==
X-Received: by 2002:a17:90a:ab84:b0:274:abbc:4ef2 with SMTP id n4-20020a17090aab8400b00274abbc4ef2mr6293253pjq.30.1696101398395;
        Sat, 30 Sep 2023 12:16:38 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090a5d8900b002630c9d78aasm3434720pji.5.2023.09.30.12.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 12:16:37 -0700 (PDT)
Message-ID: <40294463-3f96-41c2-83db-99691c015b5e@google.com>
Date:   Sat, 30 Sep 2023 12:16:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] usb: gadget: uvc: prevent de-allocating inflight
 usb_requests
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     dan.scally@ideasonboard.com, etalvala@google.com,
        gregkh@linuxfoundation.org, jchowdhary@google.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230920200335.63709-1-arakesh@google.com>
 <20230928201904.454229-1-arakesh@google.com>
 <ZRXqT/pIPwCxrk2+@pengutronix.de>
Content-Language: en-US
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <ZRXqT/pIPwCxrk2+@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the review, Michael!

Moved the split up patches to 
https://lore.kernel.org/20230930184821.310143-1-arakesh@google.com/.
Please continue the test/review there!

On 9/28/23 14:04, Michael Grzeschik wrote:
> Hi Avichal
> 
> Thanks for the patch!
> 
> On Thu, Sep 28, 2023 at 01:19:04PM -0700, Avichal Rakesh wrote:
>> Currently, when stopping the stream, uvcg_video_enable immediately
>> deallocates the usb_requests after calling usb_ep_dequeue. However,
>> usb_ep_dequeue is asynchronous and it is possible that it a request
>> that is still in use by the controller. This can lead to some hard
>> to reproduce crashes with double frees and general memory
>> inconsistencies.
>>
>> This patch sets up some stronger guarantees around when a request should
>> be deallocated. To that extent, this patch does the following:
>> 1. When stream is stopped only the currently owned uvc_requests are freed
>>   and all in-flight uvc_requests are marked 'abandoned'
>> 2. uvc_video_complete callback is made responsible for freeing up the
>>   abandoned requests. No uvc specific logic is triggered when handling
>>   abandoned requests.
>>
>> This ensures that the ownership of uvc_request (and its corresponding
>> usb_request) is never ambiguous, and uvc_requests are always freed
>> regardless of when the requests are returned to the gadget driver.
>>
>> Other changes in the patch are required to decouple the allocated
>> uvc_requests from uvc_video that allocated them.
> 
> 
> Unfortunatly the format of this patch is relly heavy to review. You are
> changing to much at once. Could you please finegrain your changes in
> smaller overall topics.
> 
> Starting with the transition from the one big kcalloc to the chaned
> list. This patch will be easy to review.
> 
> After that you could address this issue you are refering to.
> 
> This will help the review alot. I already saw some changes that are
> probably even completely unrelated.

That is fair, sent out 
https://lore.kernel.org/20230930184821.310143-1-arakesh@google.com/ to split 
up patches as a separate thread, because the chains here are already getting 
difficult to follow.
> 
> 
>> <snip>
>> -    if (ureq->last_buf) {
>> -        uvcg_complete_buffer(&video->queue, ureq->last_buf);
>> -        ureq->last_buf = NULL;
>> +    if (last_buf) {
>> +        spin_lock_irqsave(&video->queue.irqlock, flags);
>> +        uvcg_complete_buffer(&video->queue, last_buf);
>> +        spin_unlock_irqrestore(&video->queue.irqlock, flags);
>>     }
> 
> This change seems unrelated to the rest of the patch.
Oh, yeah I suppose this is not strictly related. Considering how this patch
tightens up the threading guarantees, it seemed fair to add the locks for a 
function that said " called with &queue_irqlock held.. " as its singular 
comment. Okay to remove it though.

> 
>>
>> +    /*
>> +     * request might have been abandoned while being processed.
>> +     * do a last minute check before queueing the request back.
>> +     */
>>     spin_lock_irqsave(&video->req_lock, flags);
>> -    list_add_tail(&req->list, &video->req_free);
>> +    is_abandoned = ureq->is_abandoned;
>> +    if (!is_abandoned)
>> +        list_add_tail(&req->list, &video->req_free);
>>     spin_unlock_irqrestore(&video->req_lock, flags);
>>
>> +    if (is_abandoned) {
>> +        uvc_video_free_request(ureq, ep);
>> +        return;
>> +    }
>> +
> 
> This whole check of is_abondoned is really hard to read and understand.
> Could it be somehow simplified?

Let me know if the split up patches are any easier to parse. We need this 
because we aren't synchronizing the whole complete callback, and we can't 
rely on the old state of is_abandoned flag to queue the request back up.
So we need to get the current value of is_abandoned, and queue the request
back iff the request isn't currently abandoned (and we can guaratee that it
won't be abandoned while we're queueing it back up).

> 
>>     if (uvc->state == UVC_STATE_STREAMING)
>>         queue_work(video->async_wq, &video->pump);
>> }
>> @@ -293,25 +336,10 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>> static int
>> uvc_video_free_requests(struct uvc_video *video)
>> {
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
>> +    list_for_each_entry_safe(ureq, temp, &video->ureqs, list) {
>> +        uvc_video_free_request(ureq, video->ep);
> 
> I thought we wanted to iterate over the req_free list in this function?

Not here. This function frees all the requests owned by uvc gadget driver, which is
held in ureqs. We abandon the inflight requests, and removed them from ureqs before 
cleaning up.

> 
>>     }
>>
>>     INIT_LIST_HEAD(&video->req_free);
>> @@ -322,6 +350,7 @@ uvc_video_free_requests(struct uvc_video *video)
>> static int
>> uvc_video_alloc_requests(struct uvc_video *video)
>> {
>> +    struct uvc_request *ureq;
>>     unsigned int req_size;
>>     unsigned int i;
>>     int ret = -ENOMEM;
>> @@ -332,35 +361,36 @@ uvc_video_alloc_requests(struct uvc_video *video)
>>          * max_t(unsigned int, video->ep->maxburst, 1)
>>          * (video->ep->mult);
>>
>> -    video->ureq = kcalloc(video->uvc_num_requests, sizeof(struct uvc_request), GFP_KERNEL);
>> -    if (video->ureq == NULL)
>> -        return -ENOMEM;
>> -
>> -    for (i = 0; i < video->uvc_num_requests; ++i) {
>> -        video->ureq[i].req_buffer = kmalloc(req_size, GFP_KERNEL);
>> -        if (video->ureq[i].req_buffer == NULL)
>> +    INIT_LIST_HEAD(&video->ureqs);
>> +    for (i = 0; i < video->uvc_num_requests; i++) {
>> +        ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
>> +        if (ureq == NULL)
>>             goto error;
>> +        INIT_LIST_HEAD(&ureq->list);
>> +        list_add_tail(&ureq->list, &video->ureqs);
>> +    }
>>
>> -        video->ureq[i].req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
>> -        if (video->ureq[i].req == NULL)
>> +    list_for_each_entry(ureq, &video->ureqs, list) {
>> +        ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
>> +        if (ureq->req_buffer == NULL)
>>             goto error;
>> -
>> -        video->ureq[i].req->buf = video->ureq[i].req_buffer;
>> -        video->ureq[i].req->length = 0;
>> -        video->ureq[i].req->complete = uvc_video_complete;
>> -        video->ureq[i].req->context = &video->ureq[i];
>> -        video->ureq[i].video = video;
>> -        video->ureq[i].last_buf = NULL;
>> -
>> -        list_add_tail(&video->ureq[i].req->list, &video->req_free);
>> +        ureq->req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
>> +        if (ureq->req == NULL)
>> +            goto error;
>> +        ureq->req->buf = ureq->req_buffer;
>> +        ureq->req->length = 0;
>> +        ureq->req->complete = uvc_video_complete;
>> +        ureq->req->context = ureq;
>> +        ureq->video = video;
>> +        ureq->last_buf = NULL;
>> +        list_add_tail(&ureq->req->list, &video->req_free);
>>         /* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
>> -        sg_alloc_table(&video->ureq[i].sgt,
>> +        sg_alloc_table(&ureq->sgt,
>>                    DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
>>                         PAGE_SIZE) + 2, GFP_KERNEL);
>>     }
> 
> Please move these changes to an separate patch.
Yep, done!
>>
>>     video->req_size = req_size;
>> -
>>     return 0;
>>
>> error:
>> @@ -484,12 +514,68 @@ static void uvcg_video_pump(struct work_struct *work)
>>     return;
>> }
>>
>> +/*
>> + * Disable video stream. This ensures that any inflight usb requests are marked
>> + * for clean up and video buffers are dropped up before returning.
>> + */
>> +static void uvcg_video_disable(struct uvc_video *video)
>> +{
>> +    struct uvc_buffer *buf, *tmp_buf;
>> +    struct uvc_request *ureq, *temp;
>> +    struct list_head buf_list; /* track in-flight video buffers */
>> +    struct usb_request *req;
>> +    unsigned long flags;
>> +
>> +    cancel_work_sync(&video->pump);
>> +    uvcg_queue_cancel(&video->queue, 0);
>> +
>> +    INIT_LIST_HEAD(&buf_list);
>> +    spin_lock_irqsave(&video->req_lock, flags);
>> +    /* abandon all usb requests */
>> +    list_for_each_entry_safe(ureq, temp, &video->ureqs, list) {
>> +        ureq->is_abandoned = true;
>> +        if (ureq->last_buf) {
>> +            list_add(&ureq->last_buf->queue, &buf_list);
>> +            ureq->last_buf = NULL;
>> +        }
>> +        list_del_init(&ureq->list);
>> +        if (ureq->req)
>> +            usb_ep_dequeue(video->ep, ureq->req);
>> +    }
>> +    /*
>> +     * re-add uvc_requests currently owned by the gadget to
>> +     * video->ureqs to be deallocated
>> +     */
>> +    list_for_each_entry(req, &video->req_free, list) {
>> +        ureq = req->context;
>> +        list_add_tail(&ureq->list, &video->ureqs);
>> +    }
> So what you actually do is moving the requests from the free list
> to the ureqs list. Would it not be possible to separate the cleanup
> on two locations instead?

Rather than thinking of it as "moving the requests from req_free to 
ureqs", it might be easier to reason it as: removing all uvc_requests from 
ureqs that are associated with inflight usb_requests. We remove those 
uvc_requests by using req_free but we could've done that
in some other way (happy to take recommendations if there is a simpler
way of doing so).

> 
>> +    spin_unlock_irqrestore(&video->req_lock, flags);
>> +
>> +    /*


Regards,
Avi.
