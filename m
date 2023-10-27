Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92EA7DA1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346467AbjJ0Ubf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjJ0Ubb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:31:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1FE1B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:31:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso1756475a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698438688; x=1699043488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCIU9ORg/nTCKd2EQWEkquVrxpIR07c21YhTjQSP+0s=;
        b=T1y5CWZm1t/tz8OVb/ZTazF7LmXcKTwfgO0mSd9xYgoErgrIAm1D83ht3DU50KZJDh
         LD7FQ9K4HZhJEdaSvUDWdyE9ERuhNiLU96i1cOv2Hss70xvY8pSYZacZU2lZ7MYHG760
         G2G86xPG7WDOipN29AfHeQLMFcuzYAAW2OmXGJqHRmrVaYjUoRvAb9l2zhWLt0OQt3yl
         +nMpxLp2FiPZTZjp7xoi4R5Hp+89ydnMuIpRdQGdDC5J7DyeVAge5PjAvvlDZrT6REv/
         KltZ3B+GCPJbcMIxOYcdwGOEFYevRc0ay6WIXECI+M5Uw+4ojbwoKym5p7F0c6cWbjZQ
         /4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438688; x=1699043488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCIU9ORg/nTCKd2EQWEkquVrxpIR07c21YhTjQSP+0s=;
        b=lTIjSfyKcTM0qxT28MHU7/Ff5NLXPTqT+FSsnBRypaO3VHQlg6JPwREmSJZsCMnVwa
         Fo18EZC4YAmxR1CZY+H/+stFwgJZ8VghjCf4SLVKM8BsynjlTkdtGPhFHX5cwvXT62AW
         eTsog9PbsGYolJq3eHmKy4quQ4zOMe1G5LZXNB/6DQOcgGcfSKLRvkdG9NDB2Dgk1Wpo
         dKIwd7sJX2Im/U+FVKxT4wVtiIn+EaO83GDLdvPvQgApQiffu99EiZJup/5AwkGDO3pd
         LpwvZbNiKUNvpwi34xwIi4rplkVH0c4ygv7Jpb8MLeEVS64QM3LFSKdguxW3TFBxVYVk
         xV+A==
X-Gm-Message-State: AOJu0YyvkpRAih2rCbfW/RHhky/K0JUio2+XxkD4uaeEieUd0E/nm7jC
        +gNIFG6YlbKaB48+ZSgbiEDvZg==
X-Google-Smtp-Source: AGHT+IGdS/nGHoauxLpdK4pOHUXQ0d/MOf0euxn0ULXmidHE8fDhBei/GpzafAwPu4EllfZOyK7QfQ==
X-Received: by 2002:a17:902:f542:b0:1c3:83e2:d0a9 with SMTP id h2-20020a170902f54200b001c383e2d0a9mr4604736plf.58.1698438688455;
        Fri, 27 Oct 2023 13:31:28 -0700 (PDT)
Received: from [192.168.60.239] (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001c9ba6c7287sm1963989plb.143.2023.10.27.13.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 13:31:27 -0700 (PDT)
Message-ID: <1d3777ec-ac12-4a9a-a19c-fb7d5013a0a6@google.com>
Date:   Fri, 27 Oct 2023 13:31:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] usb: gadget: uvc: Allocate uvc_requests one at a
 time
Content-Language: en-US
To:     Dan Scally <dan.scally@ideasonboard.com>,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de
References: <20231019185319.2714000-1-arakesh@google.com>
 <20231024183605.908253-1-arakesh@google.com>
 <20231024183605.908253-2-arakesh@google.com>
 <421d1996-8544-45ac-9f31-551ef597546c@ideasonboard.com>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <421d1996-8544-45ac-9f31-551ef597546c@ideasonboard.com>
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

Thank you for the reviews, Dan!

Uploaded v9 with the comments addressed.

On 10/27/23 05:57, Dan Scally wrote:
> Hi Avichal - thanks for the patch
> 
> On 24/10/2023 19:36, Avichal Rakesh wrote:
>> Currently, the uvc gadget driver allocates all uvc_requests as one array
>> and deallocates them all when the video stream stops. This includes
>> de-allocating all the usb_requests associated with those uvc_requests.
>> This can lead to use-after-free issues if any of those de-allocated
>> usb_requests were still owned by the usb controller.
>>
>> <snip>
>>
>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
>> index c334802ac0a4..c180866c8e34 100644
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
> 
> 
> Is this conditional needed? You can only get here through the list_for_each_entry_safe()

Strictly speaking, we don't need this check right now. As you said, we currently
only get to this from within a list_for_each_entry_safe block. However, we end up
needing the check in the very next patch. Considering this is a function
with no real control over who might call it, it seemed reasonable to write 
this a little defensively in case of a partial revert of the patchset.

> 
>> +        list_del_init(&ureq->list);
>> +
>> +    kfree(ureq);
>> +}
>> +
>>  <snip>
>> @@ -322,6 +325,7 @@ uvc_video_free_requests(struct uvc_video *video)
>>   static int
>>   uvc_video_alloc_requests(struct uvc_video *video)
>>   {
>> +    struct uvc_request *ureq;
>>       unsigned int req_size;
>>       unsigned int i;
>>       int ret = -ENOMEM;
>> @@ -332,29 +336,34 @@ uvc_video_alloc_requests(struct uvc_video *video)
>>            * max_t(unsigned int, video->ep->maxburst, 1)
>>            * (video->ep->mult);
>>
>> -    video->ureq = kcalloc(video->uvc_num_requests, sizeof(struct uvc_request), GFP_KERNEL);
>> -    if (video->ureq == NULL)
>> -        return -ENOMEM;
>> +    INIT_LIST_HEAD(&video->ureqs);
> 
> 
> Probably unecessary here; it's done in uvc_video_free_requests() and uvcg_video_init() already

Ah, that is fair. Added a BUG_ON instead, like we do for video->req_size
so we still catch cases where the state might be inconsistent.

> 
>> +    for (i = 0; i < video->uvc_num_requests; i++) {
>> +        ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
>> +        if (ureq == NULL)
>> +            goto error;
>> +
>> +        INIT_LIST_HEAD(&ureq->list);
>> +
>> +        list_add_tail(&ureq->list, &video->ureqs);
>>
>> <snip>

Regards,
Avi.
