Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB457CE833
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjJRTxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjJRTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:53:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA13120
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:53:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so4104618b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697658783; x=1698263583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhPjYIM8H5qvEYPlYZEBXrx9Vt3xsE9FG+Ow/kWUXwo=;
        b=SqWRFDjfvQKJQK3yOZQVdCpCm5SqMeouHfhNuycb76ax1+4UweERnjbTFQXEfKoi/V
         fph+qrNWvkU2vLlMgNtDj8c528Vy6ewG/hYo9GNtam6RNqB+MuAybMhBuVDNso1E3VM9
         kU7HmOhOc/y/4ohdj1s9jLcsQjU/Wwn9mjNvZ3Nv5WfWE/Sg9fezU/NTPso39JGzkOCZ
         CAL/u+TieKKMbDPZizGvuA/PmN5nZq2biM6R9qfF9dSH7XNk/eUE8v3b8YkJ6lIpzpR7
         s366GxBNxx3n95aaoP10f7IkXHbexxqP7SjK4WWC/4IWzJ5IfOemMYwQqAayOYuG8CoI
         ffAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658783; x=1698263583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhPjYIM8H5qvEYPlYZEBXrx9Vt3xsE9FG+Ow/kWUXwo=;
        b=bbq/qqnwBVzdzymIN+6jxbe8uIpC89Tda2fcmEtbx+x8UkRO4FkOeZKNgjJzcECV5y
         58PPTUJwUpm5RvBht14QLwTMSr2khYKNrPDFvcXk5xrlv385AtnGNsZMReHxI9L9jD7q
         mlx2UAz35nOGBWir1xInP4/xLWYIZr929aCe1lnKG45fny9br1b9zCrSJeOQg8YsHs5u
         YdM0gvN3xupXUyqNRUZyDK46+lZ5ThSQD/FXd44I6A3KYMxaKup8Y9Y4u30CAdQ6QRDO
         1waZV/GVo8UoPOtczQA9P5pFtkleSNqVcv0xbql+8RZ2EX6Y/EU+IiV12HjVi8fHLydw
         /yDg==
X-Gm-Message-State: AOJu0YzIEoMRWHm6yi00ZnxPwT3FksfLLpI+goA8auU/5Z6TTLpDJeHa
        1TW27+KsQ4LlEkQJN6x5tB7xkg==
X-Google-Smtp-Source: AGHT+IEZDQQEu1s1N6RQnGEjs+T8AyfSPGxR6PSMDC9cwRc+b3s8mJdC0m9BpQfz/Zjsi0SMo+CnOg==
X-Received: by 2002:a05:6a21:71c7:b0:17a:f1eb:e143 with SMTP id ay7-20020a056a2171c700b0017af1ebe143mr159582pzc.26.1697658783320;
        Wed, 18 Oct 2023 12:53:03 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902c95000b001ca86a9caccsm308796pla.228.2023.10.18.12.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:53:02 -0700 (PDT)
Message-ID: <69f5791c-d428-494e-a944-824898e02801@google.com>
Date:   Wed, 18 Oct 2023 12:53:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] usb: gadget: uvc: Allocate uvc_requests one at a
 time
Content-Language: en-US
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230930184821.310143-1-arakesh@google.com>
 <20231012002451.254737-1-arakesh@google.com>
 <20231012002451.254737-2-arakesh@google.com>
 <ZS/XhFNvnevol9MP@pengutronix.de>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <ZS/XhFNvnevol9MP@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 06:03, Michael Grzeschik wrote:
> A short second review.

Thank you for the review. Sent out a v5 with the comments 
addressed!

> 
> On Wed, Oct 11, 2023 at 05:24:50PM -0700, Avichal Rakesh wrote:
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
>> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Signed-off-by: Avichal Rakesh <arakesh@google.com>
>> ---
>> v1 -> v2: Rebased to ToT
>> v2 -> v3: Fix email threading goof-up
>> v3 -> v4: Address review comments & re-rebase to ToT
>>
>> drivers/usb/gadget/function/uvc.h       |  3 +-
>> drivers/usb/gadget/function/uvc_video.c | 87 ++++++++++++++-----------
>> 2 files changed, 50 insertions(+), 40 deletions(-)
>> -        if (video->ureq[i].req_buffer == NULL)
>> +        ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
>> +        if (ureq->req_buffer == NULL)
> You could also use if (!ureq->req_buffer)

Keeping this as is because I prefer `== NULL` check for readability.
Didn't find any specific rules in the kernel codestyle, so sticking
with the more readable option (in my opinion).

> 
>>             goto error;
>>
>> -        video->ureq[i].req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
>> -        if (video->ureq[i].req == NULL)
>> +        ureq->req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
>> +        if (ureq->req == NULL)
>>             goto error;
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
>>         /* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
>> -        sg_alloc_table(&video->ureq[i].sgt,
>> +        sg_alloc_table(&ureq->sgt,
>>                    DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
>>                         PAGE_SIZE) + 2, GFP_KERNEL);
>>     }
>> @@ -489,8 +496,8 @@ static void uvcg_video_pump(struct work_struct *work)
>>  */
>> int uvcg_video_enable(struct uvc_video *video, int enable)
>> {
>> -    unsigned int i;
>>     int ret;
>> +    struct uvc_request *ureq;
>>
>>     if (video->ep == NULL) {
>>         uvcg_info(&video->uvc->func,
>> @@ -502,9 +509,10 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
>>         cancel_work_sync(&video->pump);
>>         uvcg_queue_cancel(&video->queue, 0);
>>
>> -        for (i = 0; i < video->uvc_num_requests; ++i)
>> -            if (video->ureq && video->ureq[i].req)
>> -                usb_ep_dequeue(video->ep, video->ureq[i].req);
>> +        list_for_each_entry(ureq, &video->ureqs, list) {
>> +            if (ureq->req)
>> +                usb_ep_dequeue(video->ep, ureq->req);
>> +        }
>>
>>         uvc_video_free_requests(video);
>>         uvcg_queue_enable(&video->queue, 0);
>> @@ -536,6 +544,7 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
>>  */
>> int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>> {
>> +    INIT_LIST_HEAD(&video->ureqs);
>>     INIT_LIST_HEAD(&video->req_free);
>>     spin_lock_init(&video->req_lock);
>>     INIT_WORK(&video->pump, uvcg_video_pump);
>> -- 
>> 2.42.0.609.gbb76f46606-goog
>>
>>
> 
