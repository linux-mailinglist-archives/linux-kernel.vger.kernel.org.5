Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791937FD17B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjK2I57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjK2I56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:57:58 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4882512C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:58:03 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bbb4de875so2178279e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701248281; x=1701853081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHnCYf5RXf0vnemvHjAASp0ZNFRzPFmZNLDDXI6AIJ8=;
        b=u0S8fDdVide38v749X9Zj9CS1gtV4O0Kg5PrATlOhU8GiYznZyl41KL/doRsfGoGBT
         /C7KbB+E8jHtxVEDLSqLG7nw1pvghBioGVIbS50yGDtfts9UfnQntTN4eoXinkKy9IW8
         bdJwNMelkXJpxyxCTBn+YElSnx60jRD+8KMZlOH5q0U0WaZ3itx82/XRBIwoMtIcaGI9
         ocFOgboqfFezwXWqmhpgYcHi4ttlpO1GH1ZBLY3ZLDlbEU7YOwvGQ+OLiHM5K/G9wVi/
         nVCZvXDgpV+lsXs0Snpgtvc+WcsojrMKzdSxYSeza5aG8LRYvpg59NRA4ZlbBnJ995D5
         0m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248281; x=1701853081;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GHnCYf5RXf0vnemvHjAASp0ZNFRzPFmZNLDDXI6AIJ8=;
        b=ekXxCR5kxyjsbprYnobUax/7yn2GeJKsOPEpgOHxyFHQD1wPEzDDJPQfHS9ZMBrXuo
         cIUU+EmoQaMS5eQQEbBZ9ePyqxRr6Y4oo1bDXJsKe/utqv65h1a/NDD5A06l7Mc8bhAD
         edWkGLUahHZsgROPAQ/0nWa2mAa1Js9oIsLQe0osx2CkPIy7/L5CQlPsSIi5cswVAkGq
         2HkHqX5csmYnWiJg6TRXw1O6NVEHL5e1HjxihIxE/RPBKL9UfQbhCUup4wsNiUWpVhLi
         gvnHU1KCj2sI9DQrUSpu8dtVHUbdTl/eXN4q1CqDspX2T7To8f0aPPJFIesadpzIEHTW
         6U2w==
X-Gm-Message-State: AOJu0YylqCnJlcy1+WUIIqKs3sDrUOsIcsv23uG+JrlnupzGkJTXB0Em
        I8aPoiOIujuSdtqe6aJFMP5vhw==
X-Google-Smtp-Source: AGHT+IEpFy4SsBbo+NV+dsYz0ZIdoJ4/9PFs472GQ0RzOrjG0O3I1kYCYGngfcJXScDbD5z0yA1Zpg==
X-Received: by 2002:a05:6512:33cd:b0:50b:bc9a:b8b with SMTP id d13-20020a05651233cd00b0050bbc9a0b8bmr3673264lfg.28.1701248281399;
        Wed, 29 Nov 2023 00:58:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c? ([2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c139300b0040b540ff0a5sm1058902wmf.19.2023.11.29.00.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:58:00 -0800 (PST)
Message-ID: <63cc17a9-d28d-43e3-9e04-249534a96d38@linaro.org>
Date:   Wed, 29 Nov 2023 09:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
Content-Language: en-US, fr
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
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
References: <CAA8EJpp48AdJmx_U=bEJZUWZgOiT1Ctz6Lpe9QwjLXkMQvsw5w@mail.gmail.com>
 <uj6rtlionmacnwlqxy6ejt5iaczgbbe5z54ipte5ffbixcx3p4@pps7fcr3uqhf>
 <1696f131-83fb-4d0c-b4d7-0bdb61e4ae65@linaro.org>
 <mxtb6vymowutj7whbrygwlcupbdnfqxjralc3nwwapsbvrcmbm@sewxtdslfoen>
 <CAA8EJpozZkEswnioKjRCqBg4fcjVHFwGivoFNTNHVwyocKprQw@mail.gmail.com>
 <2z3yvvtd6ttsd7qw43sl5svtfijxevdr6omxxmws64k6l5qv55@5nnh2b32h2ep>
 <2023110704-playback-grit-7a27@gregkh>
 <hkzoi4sazufi5xdgr6hacuzk72cnbtmm6dwm2bzfgwh5yij6wj@2g4eb6ea4dgd>
 <2023110704-deem-jigsaw-0bbf@gregkh>
 <kuzbg4a52onojyfh2cc7h7c4iruzfbbbo2lm2jve72rnrpfk6f@2hars5pwujg3>
 <20231108155836.GB21616@pendragon.ideasonboard.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231108155836.GB21616@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 16:58, Laurent Pinchart wrote:
> On Wed, Nov 08, 2023 at 04:34:39PM +0100, Maxime Ripard wrote:
>> On Tue, Nov 07, 2023 at 04:26:34PM +0100, Greg Kroah-Hartman wrote:
>>> On Tue, Nov 07, 2023 at 01:18:14PM +0100, Maxime Ripard wrote:
>>>> On Tue, Nov 07, 2023 at 12:22:21PM +0100, Greg Kroah-Hartman wrote:
>>>>> On Tue, Nov 07, 2023 at 11:57:49AM +0100, Maxime Ripard wrote:
>>>>>> +GKH
>>>>>
>>>>> Why?  I don't see a question for me here, sorry.
>>>>
>>>> I guess the question is: we have a bus with various power states
>>>> (powered off, low power, high speed)
>>>
>>> Great, have fun!  And is this per-device or per-bus-instance?
>>
>> Per bus instance
> 
> To be precise, those power states are link states. They don't
> necessarily translate directly to device power states, and they're not
> so much about power management than speed (and bus turn-around for
> reads) management.

So the DSI core should support handling and tracking the current DSI
link state, and DSI devices should be able to request for a particular
link state.

> 
> Also, while DSI allows for multiple peripherals on a bus, the link is
> point-to-point, with the peripherals being all behind a single DSI RX. >
>>>> low power is typically used to send commands to a device, high speed to
>>>> transmit pixels, but still allows to send commands.
> 
> Low power (LP) is a link state where commands can be transmitted at a
> low speed, as opposed to the high speed (HS) link state that is used to
> transmit both video data and commands at high speed. Any device-to-host
> data transfer (in response to read commands) occurs exclusively in LP
> mode (at least with DSI v1.3, I don't have acces to newer
> specifications).
> 
>>>> Depending on the devices, there's different requirements about the state
>>>> devices expect the bus to be in to send commands. Some will need to send
>>>> all the commands in the low power state, some don't care, etc. See
>>>> the mail I was replying too for more details.
>>>>
>>>> We've tried so far to model that in KMS itself, so the framework the
>>>> drivers would register too, but we're kind of reaching the limits of
>>>> what we can do there. It also feels to me that "the driver can't access
>>>> its device" is more of a problem for the bus to solve rather than the
>>>> framework.
>>>
>>> This is up to the specific bus to resolve, there's nothing special
>>> needed in the driver core for it, right?
>>
>> Yeah, we weren't really looking to handle this into the driver core, but
>> rather if there was a set of guidelines or feedback on implementing
>> those kind of features for a bus.
>>
>>>> Do you agree? Are you aware of any other bus in Linux with similar
>>>> requirements we could look at? Or any suggestion on how to solve it?
>>>
>>> There might be others, yes, look at how the dynamic power management
>>> works for different devices on most busses, that might help you out
>>> here.
>>
>> Thanks for the pointers, we'll have a look
> 

