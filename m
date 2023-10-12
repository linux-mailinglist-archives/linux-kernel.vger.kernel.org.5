Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25CD7C61DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376637AbjJLAdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjJLAdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:33:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241190
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:33:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690d8c05784so336610b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697070829; x=1697675629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYFcbGbMzUUClTf9x+vWugaH7nLZZyyxs+6xS78to48=;
        b=IlQSPaMwUq/ozv5kCtaCuHoF3Sd9en1lIKok5yH5KHWgh1DznK1nTrVda1qG/zXhKQ
         lEaT/5Idwv5o4CIbz8RuSCiafKAFcldEUAc1hXgBRSCBfmLBbHgv5BkQY3DN+ZINNby7
         o2f+y6BSNYvzIlx8Ap/kcnaQzuKcr0HWlXrDU6L7TdgzRmdOqBBRf1Az4TutlON0zofx
         21Xt6ZCcAlMBRM+7cmtonBtxT7tYDXm6NSPGeKjS8YmshkoJ4ekPAfSmX/iis5rWYM4m
         VNAzI+5aT7gZqCS/hY4AMAxcZCtWOUGcGw2oZSrAeDFEMubiOVg4sDjoqcTQucM71IHd
         /sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070829; x=1697675629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYFcbGbMzUUClTf9x+vWugaH7nLZZyyxs+6xS78to48=;
        b=wj8MRYs4/hJOyfgABfI+DDVyeu0WmoHCIQ+WdZCg0IIEWBDMfQIBnqxr3DNEjV9WHH
         TU3XgyMEUmMQ74z755AS98EOyzHWuyCsaCWirS/Hv5NDs9bFr0Y4Y8fE5H7ykO70a3g3
         +rzCrNwS/NSdYmXCx/AxKuGH+2FGNU0+CR/M7QyK2kTyrl3TDnOqxZ2SDxAs/InN59YM
         KU9c/w/PTH5V0eJlykN/9VYjrS1+I6zhw1yRNL5pQ1yv2k6hyVf2yaeRBh/2/MAEG0Sq
         KnllNAwd3JWzubWY9Uba4IptJpy+4trjR21gc1atDkAxLaUeW3s29AqYfQmc2VKAXgCK
         I0Zw==
X-Gm-Message-State: AOJu0YylDXpYKZ61fU4dOimyd8WAqq//5xoxeO/LEgkbHFiOrY8mUFSB
        pFyCFRqLdStANqzyrbi2VQfkUxHiXhkM7xKNJPMbFA==
X-Google-Smtp-Source: AGHT+IFvkJV4nzq2xa7UQL26ABJWbAlIX1fa7B96CIxtNcwVe7sRQRxgtDkj3EzUYUHUQlJgfOdzTg==
X-Received: by 2002:a05:6a00:24c4:b0:68e:3eab:9e1b with SMTP id d4-20020a056a0024c400b0068e3eab9e1bmr24713809pfv.22.1697070828800;
        Wed, 11 Oct 2023 17:33:48 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id x3-20020aa793a3000000b0068a54866ca8sm10644925pff.134.2023.10.11.17.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 17:33:48 -0700 (PDT)
Message-ID: <26747e41-6848-493d-a442-abedea09b751@google.com>
Date:   Wed, 11 Oct 2023 17:33:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] usb: gadget: uvc: stability fixes on STREAMOFF.
Content-Language: en-US
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jchowdhary@google.com, etalvala@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230930184821.310143-1-arakesh@google.com>
 <ZRv2UnKztgyqk2pt@pengutronix.de>
 <20231005082327.GC13853@pendragon.ideasonboard.com>
 <ZR6Me5WsAbjvc2hk@pengutronix.de>
 <53300d24-b558-428d-b52f-316b2e456313@google.com>
 <ZR8zKHQv1dkyLosv@pengutronix.de>
 <50f92131-3e41-49a8-834d-8ae3ae36f565@google.com>
 <ZSCP0clqb1Nn/Ft3@pengutronix.de>
 <b14b296f-2e08-4edf-aeea-1c5b621e2d0c@google.com>
 <ZSMHeH6jNtXMRR2K@pengutronix.de>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <ZSMHeH6jNtXMRR2K@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/23 12:48, Michael Grzeschik wrote:
> On Fri, Oct 06, 2023 at 04:48:19PM -0700, Avichal Rakesh wrote:
>> On 10/6/23 15:53, Michael Grzeschik wrote:
>>> On Fri, Oct 06, 2023 at 10:00:11AM -0700, Avichal Rakesh wrote:
>>>>
>>>>
>>>> On 10/5/23 15:05, Michael Grzeschik wrote:
>>>>> Hi Avichal,
>>>>>
>>>>> On Thu, Oct 05, 2023 at 11:30:32AM -0700, Avichal Rakesh wrote:
>>>>>> On 10/5/23 03:14, Michael Grzeschik wrote:
>>>>> <snip>
>>>>> I don't know where the extra complexity comes from.
>>>>
>>>> A lot of this complexity comes from assuming a back to back
>>>> STREAMOFF -> STREAMON sequence is possible where the gadget driver
>>>> doesn't have the time to clean up all in-flight usb_requests.
>>>> However, looking through the usb gadget APIs again, and it
>>>> looks like  usb_ep_disable enforces that all requests will
>>>> be sent back to the gadget driver before it returns.
>>>
>>> Great!
>>
>> Uhh...apologies, I will have to take this back. I've been
>> trying to use uvc->state as the condition for when completion
>> handler should clean up usb_requests, and I cannot figure
>> out a way to do so cleanly.
>>
>> The fundamental problem with using uvc->state is that it is
>> not protected by any locks. So there is no real way to
>> assert that its value has not changed between reading
>> uvc->state and acting on it.
>>
>> Naively we can write something like the following in the
>> completion handler:
>>
>> void uvc_video_complete(...) {
>>    if (uvc->state != UVC_EVENT_STREAMING) {
>>        usb_ep_free_request(....);
>>    } else {
>>        // handle usb_request normally
>>    }
>> }
>>
>> But without any locks, there are no guarantees that
>> uvc->state didn't mutate immediately after the if
>> condition was checked, and the complete handler is
>> handling a request that it should've freed instead
>> or vice-versa. This argument would hold for any logic
>> we guard with uvc->state, making uvc->state effectively
>> useless as a check for freeing memory.
> 
> Yes, this makes total sense. Since the above condition was also part of
> the wait_event patch you created in the first place, I bet this issue
> was there aswell and was probably causing the issues I saw while testing
> it> 
> 
>> We can work around it by either
>> 1. Locking uvc->state with some driver level lock
>>   to ensure that we can trust the value of uvc->state
>>   at least for a little while, or
>> 2. Using some other barrier condition that is protected by
>>   another lock
>>
>> If we go with (1), we'd have to add a lock around every
>> and every write to uvc->state, which isn't terrible, but
>> would require more testing to ensure that it doesn't
>> create any new deadlocks.
>>
>> For (2), with the realization that usb_ep_disable flushes
>> all requests, we can add a barrier in uvc_video, protected by
>> req_lock. That should simplify the logic a little bit and
>> will hopefully be easier to reason about.
>>
>> I could of course be missing a simpler solution here,
>> and am happy to be wrong. So please let me know if you
>> have any other ideas on how to guarantee such a check.
> 
> For now, I have no better Idea. Idea (2) sounds like
> a good compromise. But I will have to review that code
> to really judge.
> 

Sent out v4 patches with option (2). It simplifies the logic 
decently because we no longer have to reason about per-request
consistency. uvc_video now tracks its own state of whether
requests should be flowing or not based on calls to
uvcg_video_enable. This state is protected, and is the source
of truth for queueing usb_requests.

The last bit of complexity left is around returning in-flight
video buffers. AFAICT it should now be protected, and in my 
local testing I didn't notice any un-returned buffers, but 
please to take a look and let me know if your testing 
uncovers anything.

Thanks,
Avi.
 
