Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BD17576B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGRIhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGRIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:37:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E868115
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:37:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso53948425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689669438; x=1692261438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6bRLOVfSwW0qn3SMzPfFP/67dSzOtG9jDmNa7DKFhQ=;
        b=sSX6dRkYE95JM6tA4E+4JXuPwzYm/8iu/2yxvLVU+PoHPAhUq36r+qNyoqcryZUF6s
         9QI2OR2B2GTBPE9LPS6ISOc+UnvJHIqWKepy4sB7QUHYfUIbRSqtAy6crsi0r1PLrrSQ
         zxU9CqmorIZX6iVyoMKwrv/YRa+rA596+MeaLCtsMX+qB1BPAKA4fni4E1XBo5Mkv5Ri
         IS2A81ThAQwHFbmppOgki2wF7933Oa6eXp/3eZ9GW1t7CNANosZinxJg9rh6XtdUXDwa
         CqK/V2IoknmmVBp52EUbuC8kp6TgrlOIS7mW/A+g27VtDnfeMH8CX29545o3Z+exdRYn
         oCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669438; x=1692261438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6bRLOVfSwW0qn3SMzPfFP/67dSzOtG9jDmNa7DKFhQ=;
        b=SSVRh0NkIgyXswf2/3dWBNuOECzWHbp4xetipsCToTTmqpFXBSj5fdkkL9zQQetAun
         iIKA7id0ql+TQjXMH/HB+A23XQyL1OBWZ54veNz/OpK+wtKL0ePRSc3lgQkI2sqmaJr/
         TutDi74KLmjlsYMeRcT7ZzTnhFCLkVr8PIZ+gnUA2CWkIltg1vs9RpwNdEOl0a6EHgUH
         9Y12ReAVDutCezP2a2YUfGBLiul24uMDAExNHaNnb1VmKAIM9L+Yy+cTXA1JC8fINwKB
         rNgtucuuemenBMUVUuqh0RMUDOMJRdxV8ldZtGqGBrqsoRJg7nQ0kCSRaWs8Zy1kGqQJ
         g4qA==
X-Gm-Message-State: ABy/qLazz/Y/3pmO80URZ9Y9GsHTpcucMnog7b3tVruXq97oxKpHuf8a
        qMOgWHjpf3ud3ohOY/79XKs7Tw==
X-Google-Smtp-Source: APBJJlEooqOWwehp95jYwVjhyi4es64yaNnAecI+7w58zjvmoB3sjpzHREGowtUoSx5lAf04Ecvhdg==
X-Received: by 2002:a7b:cd0a:0:b0:3fb:a1d9:ede8 with SMTP id f10-20020a7bcd0a000000b003fba1d9ede8mr1172225wmj.10.1689669437674;
        Tue, 18 Jul 2023 01:37:17 -0700 (PDT)
Received: from [10.101.1.6] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p1-20020adff201000000b003141f3843e6sm1677348wro.90.2023.07.18.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:37:17 -0700 (PDT)
Message-ID: <59a88e00-0758-32b8-7ce4-8dea84a9b0f7@baylibre.com>
Date:   Tue, 18 Jul 2023 10:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195-topckgen: Refactor parents for
 top_dp/edp muxes
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
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <24d17b07-1e8d-05f6-46b7-9da1ff1bed7a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/2023 16:30, AngeloGioacchino Del Regno wrote:
>>>>> However I'm not sure if that works for parents. It should, given the
>>>>> original use case was for the sunxi platforms, which like the MediaTek
>>>>> platform here has 2 PLLs for video related consumers, but I couldn't
>>>>> find code verifying it.
>>>>
>>>> If you want to prevent clocks from ever being reparented, you can use
>>>> the new clk_hw_determine_rate_no_reparent() determine_rate
>>>> implementation.
>>>>
>>>
>>> We want the clocks to be reparented, as we need them to switch 
>>> parents as
>>> explained before... that's more or less how the tree looks:
>>>
>>> TVDPLL(x) -> PLL Divider (fixed) -> MUX -> Gate -> Controller
>>>
>>> Besides, I think that forcing *one* parent to the dp/edp mux would 
>>> produce a
>>> loss of the flexibility that the clock framework provides.
>>>
>>> I again want to emphasize on the fact that TVDPLL1 and TVDPLL2 are 
>>> *identical*
>>> in specs, and on that there will never be a MT8195 SoC that has only 
>>> one of
>>> the two PLLs, for obvious reasons...
>>>
>>> P.S.: If you need more context, I'll be glad to answer to any other 
>>> question!
>>
>> Then I have no idea what the question is :)
>>
>> What are you trying to achieve / fix, and how can I help you ? :)
>>
> 
> Chen-Yu, Alexandre had/have questions about if there was any other 
> solution instead
> of using the solution of *this* commit, so, if there's any other better 
> solution
> than the one that I've sent as this commit.
> 
> I'm the one saying that this commit is the best solution :-P

Hi Angelo,

My solution is based on PLL static allocation, because I missed it could 
be reparented actually. I think I've a better understanding of this 
commit now, thanks to your explanations. Looks fine for me.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
