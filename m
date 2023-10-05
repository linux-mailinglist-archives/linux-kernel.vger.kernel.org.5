Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8AF7B9E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjJEN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjJENzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:55:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9097ECE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:49:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405524e6769so3786215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696492194; x=1697096994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1NOdFyfTDWT19pGgL/7nWtNoIouROD8I3TubykHDAg=;
        b=pd1YD+XUIGUQA5ikV5Te2UpnU3KaDXf/zBb1ucJt0Qw8p40DuoBtlPBiS0Z7+pr2z5
         WpjVp9/acAvl634rnHJwvF0/kq0bqaR7agG7BYypdI/0R1frdXtgpgMf1rH1FgfFgZ2Y
         gRbHSaZZGOQ9pyMsiPRxnImHYFI0Cp/jtoGbnBWc2JWdLK84fiR3T3/lZJyRI2sCG6Fo
         mBQ1OKbvMZy1kvDkwbePEJl4enmLszsvGxtcAgRmdjuZbV/WnuPmyznmVnSeH3lbltJV
         C2JGSo09ExCTJyeIDxQg86Jwd6qnr5o8bYqtIPShMHb6MyNa7FdCBZMdHC73jvEjAEuA
         dQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492194; x=1697096994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1NOdFyfTDWT19pGgL/7nWtNoIouROD8I3TubykHDAg=;
        b=w4w/N2xKBWAk2OuYrximmZ5bSjWJew2HaMoOAvgsIcH4qess43Vn5ZprpEW4z+LmpL
         nBdZ42S9DivctrZARjykpmPH8bfuJdEV0ywkx8XxQk6eP8NQb3BELBnOT3CLWdEpQIvg
         n2WEU3weizFJKoRW1ovB/FW+w/9dDBaj0gyeYXnQAcZoNIgf4AZ6jCjm2TtAkK3hh4wT
         gk7YU9pAUpc+zM7GTmoYPhCt3zybTwvRmnv/YCIGMFojOKvDGPaiaK1QuR8M57fGPugS
         9cFoPx0AfRWqQZ20/EGgkjndRsyD6zo/k4t6rxvin8unI8q8YFTriT4mEJJInYyOy7kI
         q3uQ==
X-Gm-Message-State: AOJu0YyoWTCMelN9ANaRN06XbIlzNiVDFlu/ya8fTstkZHbCxLXbr9Dm
        QF3r4/yS67sInyd2/9cQae3NuQ==
X-Google-Smtp-Source: AGHT+IGYuxtTRWkB/Y54kFzlZYW3pbxyL5CkaiAKCSBy04uW+zdBmhozBAmbNOhR9oD2CwrIt2THgw==
X-Received: by 2002:a05:600c:3795:b0:401:b92f:eec5 with SMTP id o21-20020a05600c379500b00401b92feec5mr516323wmr.9.1696492194555;
        Thu, 05 Oct 2023 00:49:54 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id n24-20020a1c7218000000b004065e235417sm3135585wmc.21.2023.10.05.00.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 00:49:53 -0700 (PDT)
Message-ID: <6ee9597d-9f7e-14ca-428d-8237f7075c66@baylibre.com>
Date:   Thu, 5 Oct 2023 09:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195-topckgen: Refactor parents for
 top_dp/edp muxes
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com, msp@baylibre.com,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230713072138.84117-1-angelogioacchino.delregno@collabora.com>
 <20230713072138.84117-3-angelogioacchino.delregno@collabora.com>
 <9a0817c2-4101-5c21-977d-77ac0d83a067@baylibre.com>
 <CAGXv+5E7YYdkG7GtxG90KzdAG8Kke+74Amtbw4mmyVNZgDZHRA@mail.gmail.com>
 <jv6daj2w3pwjtde3m3m26yg4wyxbbio4zqra5yqc4gb32ri5ub@noinbbkjovwm>
 <25724ee3-858a-01eb-352b-3edbfad31c8e@collabora.com>
 <jxgy2pvns4ri2aj5nmdhb4zbluseuzdejbplh2avwz63df2cfx@grrrdm6ujzi4>
 <24d17b07-1e8d-05f6-46b7-9da1ff1bed7a@collabora.com>
 <hd2ydj33vp3dsri4czx6frxxvir6vxnovc27n6rrgs4qqbtrjz@whhyt2iinq5k>
 <d88b72f1-6a60-dc7d-6922-1dde278a61db@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <d88b72f1-6a60-dc7d-6922-1dde278a61db@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2023 18:29, AngeloGioacchino Del Regno wrote:
> Il 18/07/23 11:03, Maxime Ripard ha scritto:
>> On Mon, Jul 17, 2023 at 04:30:48PM +0200, AngeloGioacchino Del Regno 
>> wrote:
>>>>>>> AFAIK the recommended way to deal with this is to use
>>>>>>> clk_set_rate_exclusive() and co. in whatever consumer driver that
>>>>>>> needs exclusive control on the clock rate.
>>>>>>
>>>>>> I guess it works, but it looks to me like the issue here is that the
>>>>>> provider should disable it entirely? My expectation for
>>>>>> clk_set_rate_exclusive() is that one user needs to lock the clock 
>>>>>> rate
>>>>>> to operate properly.
>>>>>>
>>>>>> If the provider expectation is that the rate or parent should never
>>>>>> changed, then that needs to be dealt with at the provider level, ie
>>>>>> through the clk_ops.
>>>>>>
>>>>>>> However I'm not sure if that works for parents. It should, given the
>>>>>>> original use case was for the sunxi platforms, which like the 
>>>>>>> MediaTek
>>>>>>> platform here has 2 PLLs for video related consumers, but I couldn't
>>>>>>> find code verifying it.
>>>>>>
>>>>>> If you want to prevent clocks from ever being reparented, you can use
>>>>>> the new clk_hw_determine_rate_no_reparent() determine_rate
>>>>>> implementation.
>>>>>>
>>>>>
>>>>> We want the clocks to be reparented, as we need them to switch 
>>>>> parents as
>>>>> explained before... that's more or less how the tree looks:
>>>>>
>>>>> TVDPLL(x) -> PLL Divider (fixed) -> MUX -> Gate -> Controller
>>>>>
>>>>> Besides, I think that forcing *one* parent to the dp/edp mux would 
>>>>> produce a
>>>>> loss of the flexibility that the clock framework provides.
>>>>>
>>>>> I again want to emphasize on the fact that TVDPLL1 and TVDPLL2 are 
>>>>> *identical*
>>>>> in specs, and on that there will never be a MT8195 SoC that has 
>>>>> only one of
>>>>> the two PLLs, for obvious reasons...
>>>>>
>>>>> P.S.: If you need more context, I'll be glad to answer to any other 
>>>>> question!
>>>>
>>>> Then I have no idea what the question is :)
>>>>
>>>> What are you trying to achieve / fix, and how can I help you ? :)
>>>
>>> Chen-Yu, Alexandre had/have questions about if there was any other 
>>> solution instead
>>> of using the solution of *this* commit, so, if there's any other 
>>> better solution
>>> than the one that I've sent as this commit.
>>>
>>> I'm the one saying that this commit is the best solution :-P
>>
>> I went back to the original patch, and my understanding is that, when
>> running two output in parallel, the modeset of one can affect the second
>> one, and that's bad, right?
>>
>> If so, then you usually have multiple ways to fix this:
>>
>>   - This patch
>>   - Using clk_set_rate_exclusive like Chen-Yu suggested
>>   - Using a notifier to react to a rate change and adjust
>>
>> I'm not aware of any "official" guidelines at the clock framework level
>> regarding which to pick and all are fine.
>>
>> My opinion though would be to use clk_set_rate_exclusive(), for multiple
>> reasons.
>>
>> The first one is that it models correctly what you consumer expects:
>> that the rate is left untouched. This can happen in virtually any
>> situation where you have one clock in the same subtree changing rate,
>> while the patch above will only fix that particular interference.
>>
>> The second one is that, especially with DP, you only have a handful of
>> rates you'll need to reach. 148MHz, 297MHz, 594MHz, and possibly a bunch
>> of others for eDP panels. It's thus likely to have both controllers
>> having the same frequency requirement, and thus it makes it possible to
>> run from only one PLL and shut the other down.
>>
>> This patch will introduce orphan clocks issues that are always a bit
>> bothersome. A notifier would be troublesome to use and will probably
>> introduce glitches plus some weird interaction with scrambling if you
>> ever support it.
>>
>> So, yeah, using clk_set_rate_exclusive() seems like the best option to 
>> me :)
>>
>> Maxime
> 
> Sorry for resurrecting a very old thread, I was able to come back to 
> this issue
> right now: there's an issue that I can't really think about how to solve 
> with
> just the usage of clk_set_rate_exclusive().
> 
> Remembering that the clock tree is as following:
> TVDPLL(x) -> PLL Divider (fixed) ->
> -> MUX (can choose any of TVDPLL(1/2)_d(2/4/6/8/16)) -> Gate -> Controller
> 
> The DPI driver is doing:
> 1. Check the best factor for setting rate of a TVDPLL
> 2. Set rate of one TVDPLL (specified in DT): clk_set_rate(dpi->tvd_clk, 
> rate);
>     2a. Read the rate of that PLL again to know the precise clock output
> 3. Set rate on the Gate clock (forwards to MUX, selecting TVDPLL(x)_d(y)):
>     clk_set_rate(dpi->pixel_clk, rate);
> 
> 
> Now, the issue is: if I change the final pixel_clk rate setting to 
> _exclusive(),
> nothing still guarantees that we will be selecting the TVDPLL that we have
> manipulated in step 2, look at the following example.
> 
> tvd_clk == TVDPLL1
> pixel_clk == TOP_DP (can be muxed to any tvdpll1/2 dividers!)
> 
> clk_set_rate(tvdpll1, something); new_rate = clk_get_rate(tvdpll1)
> 
> ...calculations... new_rate = pixclk * factor;
> ...more calculations....
> 
> clk_set_rate(pixel_clk, calculated_something)
>         ^^^^^^
> 
> There is still no guarantee that pixel_clk is getting parented to one of 
> the
> TVDPLL1 dividers, as it could still get parented to a TVDPLL2 divider 
> instead
> if the other controller has set TVDPLL2 to "an acceptable rate": it's 
> true that
> this would work - yes but suboptimally! - because we want to set a specific
> factor to reduce jitter on the final pixel clock.
> 
> 
> ....And I came back to this commit being again the best solution for me 
> because....
> 
> 1. You also seem to agree with me that a notifier would be troublesome 
> and would
>     probably introduce glitches; and
> 2. clk_set_rate_exclusive() doesn't give me any guarantee about 
> selecting the same
>     PLL that the driver was manipulating before.
> 
> 
> Am I underestimating and/or ignoring anything else in all of that?

Thanks for the detailed explanation. I've no solution for you.
You still have my ReviewBy.

-- 
Regards,
Alexandre
