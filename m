Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534127BC314
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjJFXs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJFXsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:48:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28D8BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:48:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf55a81eeaso21265975ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696636102; x=1697240902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpXCe1KTyZtGhN1Q9RaSDFPQZzN1jFdhG3uXTsEDJSg=;
        b=FEJ2Y4FVbpM30pGWLLFdiAlLFujnX/rqOWm9nb4MPfwJq+5ijUt42+Mn9i3/kVo2sA
         8BizNmkkoboTUUwm+M3uWQftyNAVUjLnu3qJc7sUmXxeGG/AdblyRYDdhq6CHEPeKkNM
         fdIPereA00+RYiml0xeMgVJqibvAQfm+O0EziueMuTVylY53kgO730Q4EE0jHguoTfw/
         q+bTEkoZuoxiUaye0/sj58gAqbYoCG0+eORlV84tyoK5Oaz/RXExg294pMA0yYYRvp2Z
         O28jvlF/MgljaECKuUn9YQ1p8VfRq3HSoQzdl/8YpcVm0YmjRvOc3/dqu+LxSp+pkhxC
         p+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696636102; x=1697240902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpXCe1KTyZtGhN1Q9RaSDFPQZzN1jFdhG3uXTsEDJSg=;
        b=BbOxUCo+uPvYjfJvs6Fw1x42qefGR6Ij8nZlczckh6ualUx1l/TMlKORnBqJ2h0AKJ
         DVVs3UmH4++iMpuNS5pO3zUtw7i404qUFiDnYIBs38YN3sML0sFGQCjQ8AXFJbdqb7Ei
         L1e1IUa95XGWrjc60o6s9xAmV5th+OvxVuNfQxOKJSQTiTu3zLk6YuAvZjXM1GxQ7eHF
         2k0F2kPqbKEKXDvcbu8VezAkRFOelg45kSUi3aOJzmXTAl//Q3AnyBWWsacLK0CaHS69
         mF19L6EXNssv8jUXZPElWIcNAb3ZbxX6KuiJafIeJ1EFrU8HpXVyGjWg7fp/B/GgZU17
         Xk7g==
X-Gm-Message-State: AOJu0YwEoVDqaSn4La2k6CKrWAgNZmZILWPJd4muWca4n7XcaahWNNWy
        mwIXKZhpmsijUIT+mURsfkuc7jyuA9z6eIaegs0ikg==
X-Google-Smtp-Source: AGHT+IGAYtjgXZCWicZczSjSQcmr679f2uW5wBiJV5TjFWVF22oLZjM3STy9TWsU9P5teHmEdZvwYQ==
X-Received: by 2002:a17:902:e803:b0:1c6:2acc:62ea with SMTP id u3-20020a170902e80300b001c62acc62eamr11191077plg.57.1696636101736;
        Fri, 06 Oct 2023 16:48:21 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902c18300b001a5fccab02dsm4531826pld.177.2023.10.06.16.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 16:48:21 -0700 (PDT)
Message-ID: <b14b296f-2e08-4edf-aeea-1c5b621e2d0c@google.com>
Date:   Fri, 6 Oct 2023 16:48:19 -0700
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
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <ZSCP0clqb1Nn/Ft3@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 15:53, Michael Grzeschik wrote:
> On Fri, Oct 06, 2023 at 10:00:11AM -0700, Avichal Rakesh wrote:
>>
>>
>> On 10/5/23 15:05, Michael Grzeschik wrote:
>>> Hi Avichal,
>>>
>>> On Thu, Oct 05, 2023 at 11:30:32AM -0700, Avichal Rakesh wrote:
>>>> On 10/5/23 03:14, Michael Grzeschik wrote:
>>>>> On Thu, Oct 05, 2023 at 11:23:27AM +0300, Laurent Pinchart wrote:
>>>>>> On Tue, Oct 03, 2023 at 01:09:06PM +0200, Michael Grzeschik wrote:
>>>>>>> On Sat, Sep 30, 2023 at 11:48:18AM -0700, Avichal Rakesh wrote:
>>>>>>> > We have been seeing two main stability issues that uvc gadget driver
>>>>>>> > runs into when stopping streams:
>>>>>>> >  1. Attempting to queue usb_requests to a disabled usb_ep
>>>>>>> >  2. use-after-free issue for inflight usb_requests
>>>>>>> >
>>>>>>> > The three patches below fix the two issues above. Patch 1/3 fixes the
>>>>>>> > first issue, and Patch 2/3 and 3/3 fix the second issue.
>>>>>>> >
>>>>>>> > Avichal Rakesh (3):
>>>>>>> >   usb: gadget: uvc: prevent use of disabled endpoint
>>>>>>> >   usb: gadget: uvc: Allocate uvc_requests one at a time
>>>>>>> >   usb: gadget: uvc: Fix use-after-free for inflight usb_requests
>>>>>>> >
>>>>>>> > drivers/usb/gadget/function/f_uvc.c     |  11 +-
>>>>>>> > drivers/usb/gadget/function/f_uvc.h     |   2 +-
>>>>>>> > drivers/usb/gadget/function/uvc.h       |   6 +-
>>>>>>> > drivers/usb/gadget/function/uvc_v4l2.c  |  21 ++-
>>>>>>> > drivers/usb/gadget/function/uvc_video.c | 189 +++++++++++++++++-------
>>>>>>> > 5 files changed, 164 insertions(+), 65 deletions(-)
>>>>>>>
>>>>>>> These patches are not applying on gregkh/usb-testing since
>>>>>>> Greg did take my patches first. I have already rebased them.
>>>>>>
>>>>>> I think they got merged too soon :-( We could fix things on top, but
>>>>>> there's very little time to do so for v6.7.
>>>>>
>>>>> Agreed. I was jumping from one workaround to another one, since this
>>>>> is not easy to fix in a proper way. And still after this long discussion
>>>>> with Avichal I don't think we are there yet.
>>>>>
>>>>>
>>>>> So far the first two patches from Avichal look legit. But the overall
>>>>> Use-After-Free fix is yet to be done properly.
>>>>>
>>>>> The "abondoned" method he suggested is really bad to follow and will
>>>>> add too much complexity and will be hard to debug.
>>>>>
>>>>> IMHO it should be possible to introduce two cleanup pathes.
>>>>>
>>>>> One path would be in the uvc_cleanup_requests that will cleanup the
>>>>> requests that are actually not used in the controller and are registered
>>>>> in the req_free list.
>>>>>
>>>>> The second path would be the complete functions that are being run
>>>>> from the controller and will ensure that the cleanup will really free
>>>>> the requests from the controller after they were consumed.
>>>>>
>>>>> What do you think?
>>>>
>>>> I am not sure I follow. Patch 3/3 does exactly what you say here.
>>>
>>> Yes, it was just to summ up what the latest state of the idea was,
>>> so Laurent does not read the whole thread in detail. Sorry for not
>>> being clear enough about that.
>>
>> Whoops! Sorry about the misunderstanding!
>>
>>>
>>>> There are two cleanup paths:
>>>>  1. uvcg_video_disable cleans up only the requests in req_free, and
>>>>  2. complete handler cleans up the in-flight requests.
>>>>
>>>> The "abandoned" flag is simply to let the completion handler know
>>>> which requests to clean up and which ones to re-queue back to
>>>> the gadget driver.
>>>
>>> What I don't get is, why in the case of shutdown there needs to
>>> be something re-queued back to the gadget driver. There should not
>>> need to be any sort of barrier flag for the requests. Just the
>>> complete handler running past a barrier where it knows that the
>>> whole device is stopped. So every call on complete should then clean
>>> that exact request it is touching currently.
>>>
>>> I don't know where the extra complexity comes from.
>>
>> A lot of this complexity comes from assuming a back to back
>> STREAMOFF -> STREAMON sequence is possible where the gadget driver
>> doesn't have the time to clean up all in-flight usb_requests.
>> However, looking through the usb gadget APIs again, and it
>> looks like  usb_ep_disable enforces that all requests will
>> be sent back to the gadget driver before it returns.
> 
> Great!

Uhh...apologies, I will have to take this back. I've been
trying to use uvc->state as the condition for when completion
handler should clean up usb_requests, and I cannot figure 
out a way to do so cleanly.

The fundamental problem with using uvc->state is that it is
not protected by any locks. So there is no real way to
assert that its value has not changed between reading
uvc->state and acting on it.

Naively we can write something like the following in the 
completion handler:

void uvc_video_complete(...) {
    if (uvc->state != UVC_EVENT_STREAMING) {
        usb_ep_free_request(....);
    } else { 
        // handle usb_request normally
    }
}

But without any locks, there are no guarantees that 
uvc->state didn't mutate immediately after the if 
condition was checked, and the complete handler is 
handling a request that it should've freed instead
or vice-versa. This argument would hold for any logic 
we guard with uvc->state, making uvc->state effectively 
useless as a check for freeing memory.

We can work around it by either
1. Locking uvc->state with some driver level lock
   to ensure that we can trust the value of uvc->state
   at least for a little while, or
2. Using some other barrier condition that is protected by 
   another lock

If we go with (1), we'd have to add a lock around every
and every write to uvc->state, which isn't terrible, but
would require more testing to ensure that it doesn't
create any new deadlocks.

For (2), with the realization that usb_ep_disable flushes 
all requests, we can add a barrier in uvc_video, protected by 
req_lock. That should simplify the logic a little bit and 
will hopefully be easier to reason about.

I could of course be missing a simpler solution here,
and am happy to be wrong. So please let me know if you 
have any other ideas on how to guarantee such a check. 


> 
>> So you're right:
>> With Patch 1/3 in place, I think we can just guard on uvc->state
>> alone, because control requests are blocked until usb_ep_disable
>> is finished anyway. I'll upload v4 with the "is_abandoned"
>> flag removed and the checks simplified once I've verified the
>> fix locally.
>>
>> That should also remove any bookkeeping issues that may have
>> triggered the stack below.
> 
> I am currious if we should handle -ECONNRESET and -ESHUTDOWN in more
> detail in the completion handler and make sure that the request will not
> be added into the req_free list from there.
> 
> Will review your v4 then.

Appreciate the reviews, thank you!

> 
>>>> The other "complications" are around making sure we can trust
>>>> the values in an inherently racey situation. The reasoning
>>>> can admittedly be difficult to follow at a glance, which incidentally
>>>> is why I went with a simple to prove timed wait in the past
>>>> (https://lore.kernel.org/20230912041910.726442-3-arakesh@google.com).
>>>>
>>>> I am not suggesting we go back to a timed wait, but please do look
>>>> at the patch and let me know which parts don't make sense, or are
>>>> difficult to understand. We can add more documentation about our
>>>> assumptions there, or if you have a way to do this that you
>>>> think is simpler to reason about, then please let me know and I'll
>>>> be more than happy to use that!
>>>
>>> I really try to spin my head around the idea of the is_abondoned flag
>>> you are using. Unfortunatly for now I am out to debug the issues I see
>>> with your series.
>>>
>>> So I did try these patches you send. Yes the deadlock error is gone with
>>> v3. But the linked list is still running into cases where
>>> dwc3_gadget_giveback(complete) is touching requests that are already
>>> freed.
>>>
>>> [   61.408715] ------------[ cut here ]------------
>>> [   61.413897] kernel BUG at lib/list_debug.c:56!
>>> ...
>>> [   61.590762] Call trace:
>>> [   61.596890]  __list_del_entry_valid+0xb8/0xe8
>>> [   61.603408]  dwc3_gadget_giveback+0x3c/0x1b0
>>> [   61.607594]  dwc3_remove_requests.part.0+0xcc/0x100
>>> [   61.612948]  __dwc3_gadget_ep_disable+0xbc/0x1b8
>>> [   61.621019]  dwc3_gadget_ep_disable+0x48/0x100
>>> [   61.627925]  usb_ep_disable+0x3c/0x138
>>> [   61.638230]  uvc_function_setup_continue+0x3c/0x60
>>> [   61.645040]  uvc_v4l2_streamoff+0x5c/0x80
>>> [   61.659812]  v4l_streamoff+0x40/0x60
>>> [   61.668950]  __video_do_ioctl+0x344/0x420
>>> [   61.679548]  video_usercopy+0x1d0/0x788
>>> [   61.685677]  video_ioctl2+0x40/0x70
>>> [   61.697439]  v4l2_ioctl+0x68/0xa0
>>> [   61.709200]  __arm64_sys_ioctl+0x304/0xda0
>>> [   61.720768]  invoke_syscall.constprop.0+0x70/0x130

Just to confirm: this stack was with all 3 patches applied? 
Want to make sure this won't happen with v4.



Regards,
Avi.
