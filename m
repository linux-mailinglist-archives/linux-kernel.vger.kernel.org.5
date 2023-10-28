Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734437DA77E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjJ1OJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1OJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 10:09:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D6F0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 07:09:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7789aed0e46so224435985a.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698502161; x=1699106961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L7rpUCYcNsJk00A3QFyNPiwTqn3W74KW0t1ePj7vug=;
        b=3+nm+CoKsHY8GIiGZ+OYDMO+IDJSnAGD0MIAmrpN6guB+F9V0F0RpvYGkNhsthxTe3
         i+OGF4PQlcP0trtyminiTC7cw7EYHnOwnA1Zl7f9aD7kkI9dEUKP2EU6auLH+G9w9gdG
         6r8GP3ETBH5E57Pey2Pn3x/HMAaGoxbLLgdWRSBpyTZEiER/Ml6NK4/9mo+LwpHK5dqF
         wH7cDW8ORgz51C0zgC7pHOb5F+9m1Jd2rK8mBgdrBGxd+1jMl31asTKoDm2kBXe+bfSZ
         tLBL+1IbzNVJtUyyTE6RTkNfLkbPe0Mj7FyDxeSHp5Okjoww0ZBDP3fIK72k2///gkXc
         FbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698502161; x=1699106961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6L7rpUCYcNsJk00A3QFyNPiwTqn3W74KW0t1ePj7vug=;
        b=CxOd3Xddadx3tXQovG67tAd45nEaSdJrukYzKgAnO8lWmGp0RveF07fYwhaPGNDuiV
         G5JE/3CExOWYSm6GETS13rLUfxo7BA+uNcvL7qG48edq2JiehBH9icnzi6lApCbFpp07
         KjKygM0zFo1P8vCG2dTJz8o5h5w4AkeUH0W6BLgE20JNLBA8di3fCc2tRrJVCvHqLUXj
         8EUYTbpXuBXhhMj3F45c0l1z6OHVbkXYiNwNVFVH/8PSVyle3fjJynF5gdYMsCHspvzw
         GMbEzK6QdzOfKhB97CkV6puXfP1bfAefeOrAztAhYs0WBZ/NqtyFYvPUElZ8ugi80jHs
         ES9w==
X-Gm-Message-State: AOJu0Yz+FSvTinue+0R5gYyNkq0IN9Vw2f0OXY0Qo+gsMAQZrdD2jMc5
        BwfM1YZPwM+BDcz2i7SwpS9yKQ==
X-Google-Smtp-Source: AGHT+IFxJ/FDoJS68PD7qMrzmAsk3DKalsqtux142SuGdn1QnmuPxpI7se/KZBd8AMH4GvgqbFrxFA==
X-Received: by 2002:a05:6214:2a8b:b0:64c:9d23:8f55 with SMTP id jr11-20020a0562142a8b00b0064c9d238f55mr6487367qvb.58.1698502160486;
        Sat, 28 Oct 2023 07:09:20 -0700 (PDT)
Received: from [192.168.7.192] (d14-69-93-221.try.wideopenwest.com. [69.14.221.93])
        by smtp.gmail.com with ESMTPSA id t7-20020a0cde07000000b0064f53943626sm1636205qvk.89.2023.10.28.07.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 07:09:20 -0700 (PDT)
Message-ID: <5fd7d151-cf60-48e1-8eae-fe39039a5acb@google.com>
Date:   Sat, 28 Oct 2023 07:09:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb:gadget:uvc Do not use worker thread to pump usb
 requests
Content-Language: en-US
To:     Michael Grzeschik <mgr@pengutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <ZToOJhyOFeGCGUFj@pengutronix.de>
 <20231026215635.2478767-1-jchowdhary@google.com>
 <20231027075117.GJ26306@pendragon.ideasonboard.com>
 <ZTuanepgXLXRoSMW@pengutronix.de>
 <20231027114752.GB12144@pendragon.ideasonboard.com>
 <ZTu9oEw1QEOxbHCf@pengutronix.de>
 <7c30f943-aaad-47dd-9ae3-02f1ca57e49b@rowland.harvard.edu>
 <ZTzsJo1/NPVTLCnY@pengutronix.de>
From:   Jayant Chowdhary <jchowdhary@google.com>
In-Reply-To: <ZTzsJo1/NPVTLCnY@pengutronix.de>
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

Hi,

On 10/28/23 04:10, Michael Grzeschik wrote:
> On Fri, Oct 27, 2023 at 10:58:11AM -0400, Alan Stern wrote:
>> On Fri, Oct 27, 2023 at 03:39:44PM +0200, Michael Grzeschik wrote:
>>> On Fri, Oct 27, 2023 at 02:47:52PM +0300, Laurent Pinchart wrote:
>>> > On Fri, Oct 27, 2023 at 01:10:21PM +0200, Michael Grzeschik wrote:
>>> > > On Fri, Oct 27, 2023 at 10:51:17AM +0300, Laurent Pinchart wrote:
>>> > > > On Thu, Oct 26, 2023 at 09:56:35PM +0000, Jayant Chowdhary wrote:
>>> > > >> This patch is based on top of
>>> > > >> https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
>>> > > >>
>>> > > >> When we use an async work queue to perform the function of pumping
>>> > > >> usb requests to the usb controller, it is possible that thread scheduling
>>> > > >> affects at what cadence we're able to pump requests. This could mean usb
>>> > > >> requests miss their uframes - resulting in video stream flickers on the host
>>> > > >> device.
>>> > > >>
>>> > > >> In this patch, we move the pumping of usb requests to
>>> > > >> 1) uvcg_video_complete() complete handler for both isoc + bulk
>>> > > >>    endpoints. We still send 0 length requests when there is no uvc buffer
>>> > > >>    available to encode.
>>> > > >
>>> > > > This means you will end up copying large amounts of data in interrupt
>>> > > > context. The work queue was there to avoid exactly that, as it will
>>> > > > introduce delays that can affect other parts of the system. I think this
>>> > > > is a problem.
>>> > >
>>> > > Regarding Thin's argument about possible scheduling latency that is already
>>> > > introducing real errors, this seemed like a good solution.
>>> > >
>>> > > But sure, this potential latency introduced in the interrupt context can
>>> > > trigger other side effects.
>>> > >
>>> > > However I think we need some compromise since both arguments are very valid.
>>> >
>>> > Agreed.
>>> >
>>> > > Any ideas, how to solve this?
>>> >
>>> > I'm afraid not.
>>>
>>> We discussed this and came to the conclusion that we could make use of
>>> kthread_create and sched_setattr with an attr->sched_policy = SCHED_DEADLINE
>>> here instead of the workqueue. This way we would ensure that the worker
>>> would be triggered with hard definitions.
>>>
>>> Since the SG case is not that heavy on the completion handler, we could
>>> also make this kthread conditionaly to the memcpy case.
>>
>> If you don't mind a naive suggestion from someone who knows nothing
>> about the driver...
>>
>> An attractive possibility is to have the work queue (or kthread) do the
>> time-consuming copying, but leave the submission up to the completion
>> handler.  If the data isn't ready (or there's no data to send) when the
>> handler runs, then queue a 0-length request.
>>
>> That will give you the best of both worlds: low latency while in
>> interrupt context and a steady, constant flow of USB transfers at all
>> times.  The question of how to schedule the work queue or kthread is a
>> separate matter, not directly relevant to this design decision.
>
> That's it. This is probably the best way to tackle the overall problem.
>
> So we leave the call of the encode callback to the worker, that will
> probably still can be a workqueue. The complete callback is calling
> the explicit uvcg_video_ep_queue when prepared requests are available
> and if there is nothing pending it will just enqueue zero requests.
>
> Thank you Alan, this makes so much sense!
>
> Jayant, Laurent: Do you agree?
> If yes, Jayant will you change the patch accordingly?
>
>
Thanks for all the discussion Greg, Michael, Laurent and Alan.
Apologies for not responding earlier since I am OOO.

While I  haven't tried this out this does seem like a very good idea.
Thank you Alan! I will aim to make changes and post a patch on Monday night PST.

Jayant

