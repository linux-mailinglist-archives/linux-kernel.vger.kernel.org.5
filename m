Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244F07BA91D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjJESaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJESah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:30:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38797E7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:30:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso1050675b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696530634; x=1697135434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWSplB9/HpxGUJT8jmcoIb39SQzJ2r1OV48rOIhYqsY=;
        b=nMsd1j6ZNRx0GPqJQMzWkVqYfEHGGizZzNGo1JxLR2mEmCyUAvuIV4us9z0S6BG7sU
         CnTtZZsopsORa/Zzgna+NVp+ziI6PiJftoohyKFD2AMz+IVQyOw36jkEsWulOJm3GU2L
         FA/iUAy57ASrqzNUi64vXc6L8e2HGRbhuRaO2SPK+jGmQEWSHlI7KTQzm1YFWb5e5A4G
         frEyHuNS99EoNFXJ4kWhASkH/GV5tJ+gZxN0Ged8yU1XP4+UWOw0PnBSa4Ea7HwmyP/C
         u7LXaiUqQMUC+1MLVo9zSTaYJOtuqGROX0HS2OyhQfCjk6SD3mcFAEyZgMOKuowrFq+k
         P9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530634; x=1697135434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWSplB9/HpxGUJT8jmcoIb39SQzJ2r1OV48rOIhYqsY=;
        b=Z+oCAbl44KD0r7yav9cb2QNwmRnr8VdvtnmU0E9rW+i0eaO721cyz+LnTTayA5UzBu
         UdOsaqzcZhvz1m4lvd3h7I5i2Cbi6IKOS9Kn6rSFPaUovCDG8Fl1FOqBBTDfuey+jlcn
         biBLkLY3gbyOrKZDXgjlF1RZ+4Unu9I16Yb+4Z8ILgOjWvyhxSvDNkErvFCnGM/Kjoyc
         /ja9J5In5nqPwxfCj+UIYnFDeDIm3ZKfECE9jsG1nrWNCJ07bwCz97Cxh/N5GrxgQ6OV
         mZH3h4Xml1CRh+aHkUWnVfggAb5tcqZwPZ1aUcn6+sxSDQ6+W8rxVfTdlvstcpvHD8/V
         uLvA==
X-Gm-Message-State: AOJu0YxWlBmF7atLhWrTyHwHjBcMRrUAWNMZpnNMN0QusGTgsRxYdMTl
        RhRKXoCIIXu7OM3IOxgHFn8prgedDrrAM/gOIHQKAw==
X-Google-Smtp-Source: AGHT+IFZAdO23qkLv6AEdri90UITYy2nvBOlpKF2ig2rQddLOyydUFmD9dKbRXxI5sF1qC1/9fzKag==
X-Received: by 2002:a05:6a00:1685:b0:68f:b015:ea99 with SMTP id k5-20020a056a00168500b0068fb015ea99mr5382388pfc.10.1696530634333;
        Thu, 05 Oct 2023 11:30:34 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id j1-20020a62b601000000b0069028bdd24dsm1713926pff.34.2023.10.05.11.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:30:33 -0700 (PDT)
Message-ID: <53300d24-b558-428d-b52f-316b2e456313@google.com>
Date:   Thu, 5 Oct 2023 11:30:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] usb: gadget: uvc: stability fixes on STREAMOFF.
Content-Language: en-US
To:     Michael Grzeschik <mgr@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jchowdhary@google.com, etalvala@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230930184821.310143-1-arakesh@google.com>
 <ZRv2UnKztgyqk2pt@pengutronix.de>
 <20231005082327.GC13853@pendragon.ideasonboard.com>
 <ZR6Me5WsAbjvc2hk@pengutronix.de>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <ZR6Me5WsAbjvc2hk@pengutronix.de>
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



On 10/5/23 03:14, Michael Grzeschik wrote:
> Hi Laurent
> 
> On Thu, Oct 05, 2023 at 11:23:27AM +0300, Laurent Pinchart wrote:
>> On Tue, Oct 03, 2023 at 01:09:06PM +0200, Michael Grzeschik wrote:
>>> On Sat, Sep 30, 2023 at 11:48:18AM -0700, Avichal Rakesh wrote:
>>> > We have been seeing two main stability issues that uvc gadget driver
>>> > runs into when stopping streams:
>>> >  1. Attempting to queue usb_requests to a disabled usb_ep
>>> >  2. use-after-free issue for inflight usb_requests
>>> >
>>> > The three patches below fix the two issues above. Patch 1/3 fixes the
>>> > first issue, and Patch 2/3 and 3/3 fix the second issue.
>>> >
>>> > Avichal Rakesh (3):
>>> >   usb: gadget: uvc: prevent use of disabled endpoint
>>> >   usb: gadget: uvc: Allocate uvc_requests one at a time
>>> >   usb: gadget: uvc: Fix use-after-free for inflight usb_requests
>>> >
>>> > drivers/usb/gadget/function/f_uvc.c     |  11 +-
>>> > drivers/usb/gadget/function/f_uvc.h     |   2 +-
>>> > drivers/usb/gadget/function/uvc.h       |   6 +-
>>> > drivers/usb/gadget/function/uvc_v4l2.c  |  21 ++-
>>> > drivers/usb/gadget/function/uvc_video.c | 189 +++++++++++++++++-------
>>> > 5 files changed, 164 insertions(+), 65 deletions(-)
>>>
>>> These patches are not applying on gregkh/usb-testing since
>>> Greg did take my patches first. I have already rebased them.
>>
>> I think they got merged too soon :-( We could fix things on top, but
>> there's very little time to do so for v6.7.
> 
> Agreed. I was jumping from one workaround to another one, since this
> is not easy to fix in a proper way. And still after this long discussion
> with Avichal I don't think we are there yet.
> 
> 
> So far the first two patches from Avichal look legit. But the overall
> Use-After-Free fix is yet to be done properly.
> 
> The "abondoned" method he suggested is really bad to follow and will
> add too much complexity and will be hard to debug.
> 
> IMHO it should be possible to introduce two cleanup pathes.
> 
> One path would be in the uvc_cleanup_requests that will cleanup the
> requests that are actually not used in the controller and are registered
> in the req_free list.
> 
> The second path would be the complete functions that are being run
> from the controller and will ensure that the cleanup will really free
> the requests from the controller after they were consumed.
> 
> What do you think?

I am not sure I follow. Patch 3/3 does exactly what you say here.
There are two cleanup paths:
  1. uvcg_video_disable cleans up only the requests in req_free, and
  2. complete handler cleans up the in-flight requests.

The "abandoned" flag is simply to let the completion handler know
which requests to clean up and which ones to re-queue back to
the gadget driver.

The other "complications" are around making sure we can trust
the values in an inherently racey situation. The reasoning
can admittedly be difficult to follow at a glance, which incidentally
is why I went with a simple to prove timed wait in the past 
(https://lore.kernel.org/20230912041910.726442-3-arakesh@google.com).

I am not suggesting we go back to a timed wait, but please do look
at the patch and let me know which parts don't make sense, or are
difficult to understand. We can add more documentation about our
assumptions there, or if you have a way to do this that you
think is simpler to reason about, then please let me know and I'll
be more than happy to use that!

Regards,
Avi.
