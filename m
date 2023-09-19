Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4977A6AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjISSYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjISSYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:24:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A5990
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:24:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf5c314a57so44408725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695147853; x=1695752653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyKX4subIj0JkQ7g2giJmckhlLZeGnr5STAEUNtozbA=;
        b=I3MKiEmuoy0BM/xSot67SQRJfGGype0bOqJq/GfbILtWDwdlU1/MN4742JGOSDNKlH
         d5Iz7id+P0CUQgC09PhDSn9naBbtxcz14F53mEJxgQ0P9MmTW77egn0lKIUFqIm39gdd
         nOqmdV8x4LYdHHEvUN6CbQi5b6XCLeHJYjdWMfBwddE8NpxPL6HnSzWEFN80BF7HDOdp
         wfCUpXTYHUGi4YJ4pfxos9J3nyVW80FbV0lscedPFzRaZ/jBjwqxHPGRRigoQTaT8TA0
         yiAvBsfo+hehjyd/mT1JBPNWFDGHhYd6qDi/i4lE20kDJOFW41WHnFkQvFLbCn496QLU
         Vzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695147853; x=1695752653;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyKX4subIj0JkQ7g2giJmckhlLZeGnr5STAEUNtozbA=;
        b=XbtNH7H4CwawhQS9gmYxIOFw1m7KCs30PNbY0leKxofql9HI7rhwyG2yJe4SxFxSyn
         8v7O9BZFPfwJXEIpM7N6q20b6bvloAyfChAenSHP3Ufb1vlyWthvnBCky7a0pibNXkNN
         h+knsybTjyh4rmCHwg4l/ZNvWzG0JZN8cQCKaq59htSR11R+fZGeMmeWauZaJ/DdV8fy
         Wsu+Lh1S0IZGeEAKbC63jKcoTWkBKUIuVZEBlcpRkQcLso0DZektBrYijuDLpe9OFO5p
         stvIVSCWYKc8/VMEUNwSK5K7Scl7Puam8vxUU6h0oexb9rnrNeFfxU+Vk0GLz2QYQydu
         S51A==
X-Gm-Message-State: AOJu0YwyVwSiuhvuQI+1HDsdC/Ii5gbomy4KbIwD2klJtl/jWx3chgkp
        RJNa9wEYdgTqnd2Gr2h4Dvf6ZA==
X-Google-Smtp-Source: AGHT+IE27KRQhOubzB8PC5Zccus8ZJKuZManrWZg9CaeBwXNqT905JsXH0aHcrsHBnwgGkuFKkdAog==
X-Received: by 2002:a17:902:e851:b0:1c4:50fd:7cd1 with SMTP id t17-20020a170902e85100b001c450fd7cd1mr240232plg.11.1695147852966;
        Tue, 19 Sep 2023 11:24:12 -0700 (PDT)
Received: from [192.168.60.239] (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b001bba669a7eesm10284870plg.52.2023.09.19.11.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 11:24:12 -0700 (PDT)
Message-ID: <bb962593-9665-4bb1-be14-c56ce17b9073@google.com>
Date:   Tue, 19 Sep 2023 11:24:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] usb: gadget: uvc: stability fixes when stopping
 streams
Content-Language: en-US
From:   Avichal Rakesh <arakesh@google.com>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230912041910.726442-1-arakesh@google.com>
 <CAMHf4WLeSC9m05XOU54yL=2xUcSqbWP0f7evM0rZRsJ=J-btWw@mail.gmail.com>
 <ZQTlz9Koe2CQIsrC@pengutronix.de>
 <af3c1637-ff43-4346-8cfb-db836d6de3f0@google.com>
In-Reply-To: <af3c1637-ff43-4346-8cfb-db836d6de3f0@google.com>
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



On 9/15/23 18:35, Avichal Rakesh wrote:
> 
> 
> On 9/15/23 16:16, Michael Grzeschik wrote:
>> Hi Avichal
>>
>> On Thu, Sep 14, 2023 at 04:05:36PM -0700, Avichal Rakesh wrote:
>>> On Mon, Sep 11, 2023 at 9:19 PM Avichal Rakesh <arakesh@google.com> wrote:
>>>>
>>>> We have been seeing two main bugs when stopping stream:
>>>> 1. attempting to queue usb_requests on a disabled usb endpoint, and
>>>> 2. use-after-free problems for inflight requests
>>>>
>>>> Avichal Rakesh (2):
>>>>   usb: gadget: uvc: prevent use of disabled endpoint
>>>>   usb: gadget: uvc: prevent de-allocating inflight usb_requests
>>>>
>>>>  drivers/usb/gadget/function/f_uvc.c     | 11 ++++----
>>>>  drivers/usb/gadget/function/f_uvc.h     |  2 +-
>>>>  drivers/usb/gadget/function/uvc.h       |  5 +++-
>>>>  drivers/usb/gadget/function/uvc_v4l2.c  | 21 ++++++++++++---
>>>>  drivers/usb/gadget/function/uvc_video.c | 34 +++++++++++++++++++++++--
>>>>  5 files changed, 60 insertions(+), 13 deletions(-)
>>>>
>>>
>>> Bumping this thread up. Laurent, Dan, and Michael could you take a look?
>>
>> I tested the patches against my setup and it did not help.
> 
> Thank you for testing the patch, I really appreciate your help in testing the 
> patches!
> 
>>
>> In fact I saw two different issues when calling the streamoff event.
>>
>> One issue was a stalled pipeline after the streamoff from the host came in.
>> The streaming application did not handle any events anymore.
> 
> This sounds like uvc_function_setup_continue was never called, so no more control
> events were queued for the userspace to handle. This is a little bit of a shot in
> the dark: if you are not using the Laurent's uvc-gadget
> (https://git.ideasonboard.org/uvc-gadget.git) on the gadget, could you check that 
> your userspace application (on the gadget side) calls VIDIOC_STREAMOFF when 
> handling UVC_EVENT_STREAMOFF? 
> 
> This is similar to how it should called VIDIOC_STREAMON when handling 
> UVC_EVENT_STREAMON. Before my patch, I think UVC gadget driver is functionally fine
> with userspace application not calling VIDIOC_STREAMOFF. However, my patch prevents
> the host from making any more control requests until the gadget's userspace
> application calls VIDIOC_STREAMOFF, which looks like a stalled control ep.
> 
>>
>> The second issue was when the streamoff event is triggered sometimes the
>> following trace is shown, even with your patches applied.
>>
>>
>> [  104.202689] Unable to handle kernel paging request at virtual address 005bf43a692a5fd5
>> [  104.235122] Mem abort info:
>> [  104.238257]   ESR = 0x0000000096000004
>> [  104.242449]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  104.248391]   SET = 0, FnV = 0
>> [  104.251803]   EA = 0, S1PTW = 0
>> [  104.255313]   FSC = 0x04: level 0 translation fault
>> [  104.260765] Data abort info:
>> [  104.263982]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>> [  104.270114]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [  104.275760]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [  104.281698] [005bf43a692a5fd5] address between user and kernel address ranges
>> [  104.290042] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>> [  104.297060] Dumping ftrace buffer:
>> [  104.300869]    (ftrace buffer empty)
>> [  104.304862] Modules linked in: st1232 hantro_vpu v4l2_vp9 v4l2_h264 uio_pdrv_genirq fuse [last unloaded: rockchip_vpu(C)]
>> [  104.312080] panfrost fde60000.gpu: Panfrost Dump: BO has no sgt, cannot dump
>> [  104.317137] CPU: 0 PID: 465 Comm: irq/46-dwc3 Tainted: G         C         6.5.0-20230831-2+ #5
>> [  104.317144] Hardware name: WolfVision PF5 (DT)
>> [  104.317148] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  104.317154] pc : __list_del_entry_valid+0x48/0xe8
>> [  104.352728] lr : dwc3_gadget_giveback+0x3c/0x1b0
>> [  104.357893] sp : ffffffc08381bc60
>> [  104.361593] x29: ffffffc08381bc60 x28: ffffff80047d4000 x27: ffffff80047de440
>> [  104.369576] x26: 0000000000000000 x25: ffffffc08135b2d0 x24: ffffffc08381bd00
>> [  104.377559] x23: 00000000ffffff98 x22: ffffff8004204880 x21: ffffff80047d4000
>> [  104.385541] x20: ffffff800718dea0 x19: ffffff800718dea0 x18: 0000000000000000
>> [  104.393523] x17: 7461747320687469 x16: 7720646574656c70 x15: 6d6f632074736575
>> [  104.401504] x14: 716572205356203a x13: 2e3430312d207375 x12: 7461747320687469
>> [  104.409486] x11: ffffffc0815c98f0 x10: 0000000000000000 x9 : ffffffc0808f4fa0
>> [  104.417468] x8 : ffffffc082415000 x7 : ffffffc0808f4e2c x6 : ffffffc0823d0928
>> [  104.425450] x5 : 0000000000000282 x4 : 0000000000000201 x3 : d85bf43a692a5fcd
>> [  104.433431] x2 : ffffff80047d4048 x1 : ffffff800718dea0 x0 : dead000000000122
>> [  104.441413] Call trace:
>> [  104.444142]  __list_del_entry_valid+0x48/0xe8
>> [  104.449013]  dwc3_gadget_giveback+0x3c/0x1b0
>> [  104.453786]  dwc3_gadget_ep_cleanup_cancelled_requests+0xe0/0x170
>> [  104.460599]  dwc3_process_event_buf+0x2a8/0xbb0
>> [  104.465662]  dwc3_thread_interrupt+0x4c/0x90
>> [  104.470435]  irq_thread_fn+0x34/0xb8
>> [  104.474431]  irq_thread+0x1a0/0x290
>> [  104.478327]  kthread+0x10c/0x120
>> [  104.481933]  ret_from_fork+0x10/0x20
>>
>> The error path triggering these list errors are usually in the
>> dwc3 driver handling the cancelled or completed list.
> 
> It looks like we're still freeing un-returned requests :(. If you still have
> the setup can you pull the uvc logs to see if waiting for requests to be returned timed 
> out? I wonder if dwc3's interrupt handler is being scheduled too late. 500ms seemed
> like a reasonable time out to me, but this seems to prove otherwise.
> 


Hey Michael, were you able to look into the comments from the previous
email? 

Avi.
