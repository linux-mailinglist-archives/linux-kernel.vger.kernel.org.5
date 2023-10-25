Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1749E7D7097
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbjJYPQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjJYPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:16:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B121412F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:16:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50816562320so1278868e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698246977; x=1698851777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Td1Qp2jEYN6EwIlzvrnD5w5N2Jcs878/iCYHd4DtvAU=;
        b=RYTtR2L4tFlYQ3scGGElZQQQhftT4CE1noUoGJUrjhZ4szOrhlp9n0+lSXolHNH2BK
         SD7cXuZqTDylTuVr4Qk99ZlpELLsOiiLc2XhJ+IqtMG/g/bLFuxklP2KmJkwrQUesMsQ
         PjBWW7ZmKU9oXdGaucYTdXeFUySJp+SxJeOn68Zln4ZILSoGcKVg4JICr5N0AcEKXplG
         T3ZF6zeLfvElI/riSwou5vp8H16BDx44LpSbqoeXLe5YnmCNerwI+b9xi6Jqltn0TKsP
         AvFn9EaOsxaBbsIiuchU+8DOiWFEuEgzPnM+lCNf8htl/g3KTPM2aBC5RWgBpqY6fkoF
         7wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698246977; x=1698851777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Td1Qp2jEYN6EwIlzvrnD5w5N2Jcs878/iCYHd4DtvAU=;
        b=lq/N32xdIyZb7vhhhxZgxT7Qp8BSS4jqhuVIbXTUcX7AThG6ACHV+5SoRhCcsq6j6a
         b2rbd+cSsFx2+jx8kyWqbTUALi8e/zhSrcSi9DUUXAxitQ4m2hiJAnQUYCRk9K+YW/dS
         gH4EKikUkJK2OJg5f6F1Xx7p5BzyA1Q2BM6drUkHmFGURYqpPw6Y6FR9/FCp/2FkXNa+
         wL1ikfGU5dJ2Cxgc1O7xs2syhaObggvQWRCM1HAY84DBefKVAaAhRiVi9YI0sBivswnj
         XN82pUaHltnAcSzyp16EVFjLXTmxLOEzBEwvqFg6nZzfM6RW8F84boPAqFvXmDLX0VsC
         19Zg==
X-Gm-Message-State: AOJu0YwAdnQk9i4dN6R0tJtLmbUSyGrBSga/39A2l3XhCc2OqVM+dUVx
        bprBWuA2lypXGHq5afLm702cnw==
X-Google-Smtp-Source: AGHT+IFU0aD6A6CHpv9y7jOR2dZ44pugJWs69QC07vhVJ3EOmVWLtgzjKARGyA2TIeyVSr1x2sn0Dw==
X-Received: by 2002:a05:6512:71:b0:507:a6b2:c63e with SMTP id i17-20020a056512007100b00507a6b2c63emr9706041lfo.53.1698246976791;
        Wed, 25 Oct 2023 08:16:16 -0700 (PDT)
Received: from [192.168.1.212] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac258fa000000b00507a3b8b008sm2586135lfo.112.2023.10.25.08.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 08:16:16 -0700 (PDT)
Message-ID: <1696f131-83fb-4d0c-b4d7-0bdb61e4ae65@linaro.org>
Date:   Wed, 25 Oct 2023 18:16:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
Content-Language: en-GB
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <20231016165355.1327217-4-dmitry.baryshkov@linaro.org>
 <7e4ak4e77fp5dat2aopyq3g4wnqu3tt7di7ytdr3dvgjviyhrd@vqiqx6iso6vg>
 <CAA8EJpp48AdJmx_U=bEJZUWZgOiT1Ctz6Lpe9QwjLXkMQvsw5w@mail.gmail.com>
 <uj6rtlionmacnwlqxy6ejt5iaczgbbe5z54ipte5ffbixcx3p4@pps7fcr3uqhf>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <uj6rtlionmacnwlqxy6ejt5iaczgbbe5z54ipte5ffbixcx3p4@pps7fcr3uqhf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 15:44, Maxime Ripard wrote:
> On Thu, Oct 19, 2023 at 02:19:51PM +0300, Dmitry Baryshkov wrote:
>> On Thu, 19 Oct 2023 at 12:26, Maxime Ripard <mripard@kernel.org> wrote:
>>>
>>> On Mon, Oct 16, 2023 at 07:53:48PM +0300, Dmitry Baryshkov wrote:
>>>> The MIPI DSI links do not fully fall into the DRM callbacks model.
>>>
>>> Explaining why would help
>>
>> A kind of explanation comes afterwards, but probably I should change
>> the order of the phrases and expand it:
>>
>> The atomic_pre_enable / atomic_enable and correspondingly
>> atomic_disable / atomic_post_disable expect that the bridge links
>> follow a simple paradigm: either it is off, or it is on and streaming
>> video. Thus, it is fine to just enable the link at the enable time,
>> doing some preparations during the pre_enable.
>>
>> But then it causes several issues with DSI. First, some of the DSI
>> bridges and most of the DSI panels would like to send commands over
>> the DSI link to setup the device.
> 
> What prevent them from doing it in enable when the link is enabled?
> 
>> Next, some of the DSI hosts have limitations on sending the commands.
>> The proverbial sunxi DSI host can not send DSI commands after the
>> video stream has started. Thus most of the panels have opted to send
>> all DSI commands from pre_enable (or prepare) callback (before the
>> video stream has started).
> 
> I'm not sure we should account for a single driver when designing a
> framework. We should focus on designing something sound, and then making
> that driver work with whatever we designed, but not the other way
> around. And if we can't, we should get rid of that driver because it's
> de-facto unmaintainable. And I'm saying that as the author of that
> driver.

That's not the only driver with strange peculiarities. For example, see 
commit 8a4b2fc9c91a ("drm/bridge: tc358762: Split register programming 
from pre-enable to enable"), which was one of the issues that actually 
prompted me to send this this patchset (after my previous version of 
this patch being rejected because of sunxi).

> 
>> However this leaves no good place for the DSI host to power up the DSI
>> link. By default the host's pre_enable callback is called after the
>> DSI bridge's pre_enable. For quite some time we were powering up the
>> DSI link from mode_set. This doesn't look fully correct.
> 
> Yeah, it's not.
> 
>> And also we got into the issue with ps8640 bridge, which requires for
>> the DSI link to be quiet / unpowered at the bridge's reset time.
>>
>> Dave has come with the idea of pre_enable_prev_first /
>> prepare_prev_first flags, which attempt to solve the issue by
>> reversing the order of pre_enable callbacks. This mostly solves the
>> issue. However during this cycle it became obvious that this approach
>> is not ideal too. There is no way for the DSI host to know whether the
>> DSI panel / bridge has been updated to use this flag or not, see the
>> discussion at [1].
> 
> Yeah. Well, that happens. I kind of disagree with Neil here though when
> he says that "A panel driver should not depend on features of a DSI
> controller". Panels definitely rely on particular features, like the
> number of lanes, the modes supported, etc.

In the mentioned discussion it was more about 'DSI host should not 
assume panel driver features', like the panel sending commands in 
pre_enable or not, or having pre_enable_prev_first.

So the pre_enable_prev_first clearly lacks feature negotiation.


> 
> Panels shouldn't depend on a particular driver *behaviour*. But the
> features are fine.
> 
> For our particular discussion, I think that that kind of discussion is a
> dead-end, and we just shouldn't worry about it. Yes, some panels have
> not yet been updated to take the new flags into account. However, the
> proper thing to do is to update them if we see a problem with that (and
> thus move forward to the ideal solution), not revert the beginning of
> that feature enablement (thus moving away from where we want to end up
> in).
> 
>> Thus comes this proposal. It allows for the panels to explicitly bring
>> the link up and down at the correct time, it supports automatic use
>> case, where no special handling is required. And last, but not least,
>> it allows the DSI host to note that the bridge / panel were not
>> updated to follow new protocol and thus the link should be powered on
>> at the mode_set time. This leaves us with the possibility of dropping
>> support for this workaround once all in-kernel drivers are updated.
> 
> I'm kind of skeptical for these kind of claims that everything will be
> automatic and will be handled fine. What if we have conflicting
> requirements, for example two bridges drivers that would request the
> power up at different times?

Well, we do not support DSI sublinks, do we?

> 
> Also, we would still need to update every single panel driver, which is
> going to create a lot of boilerplate that people might get wrong.

Yes, quite unfortunately. Another approach that I have in mind is to add 
two callbacks to mipi_dsi_device. This way the DSI host will call into 
the device to initialise it once the link has been powered up and just 
before tearing it down. We solve a lot of problems this way, no 
boilerplate and the panel / bridge are in control of the initialisation 
procedure. WDYT?

> I have the feeling that we should lay out the problem without talking
> about any existing code base first. So, what does the MIPI-DSI spec
> requires and what does panels and bridges expect?

There is not that much in the DSI spec (or maybe I do not understand the 
question). The spec is more about the power states and the commands. Our 
problem is that this doesn't fully match kernel expectations.

-- 
With best wishes
Dmitry

