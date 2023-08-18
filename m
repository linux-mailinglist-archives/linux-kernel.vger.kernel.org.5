Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F667809DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358973AbjHRKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358994AbjHRKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:16:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA8F35AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:16:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so7371235e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692353796; x=1692958596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xT8+MKFYhwDGJJlvX0Cp1TcbV86ZhXMTlJomaVEwgGY=;
        b=CVCeFW1qwsF/npfnesl3FuRhg/tLHCGeEsh7UHYtvOin94xpV0qjyDRJ70BuD4hpu6
         8uaRoXU6nNs4wv/xIFx7ARm7/OquG4tpPMvSLc12D/Sjsa7pWGcMr1d0AEwSvJSPv4EG
         DP+Pgyr70BPTX2TQGqU4EEKjCgPtpPjLOSvgYjRsGjPvvohyPJ4roWTZMdDLTHzDC8Dy
         ZFLHp8y55aVZJDc482avoRIKuQmu/x8ZZu/ZhA9lGCSwTg7AIb7ZrH4phwlEKYlgleVt
         93oBV+sGftUwtYUOq4Kdj48/FR+KJvttlCUfkTa2R0PJBIGBnf+eMMF6vT/g04b4rOdI
         Jngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692353796; x=1692958596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xT8+MKFYhwDGJJlvX0Cp1TcbV86ZhXMTlJomaVEwgGY=;
        b=GuiSnm5BjME2nSXELCugY9x73hc1tgNDhv+5HYg2e+NG1PcZqyK9upFjQf3icndCn1
         M/Ri5McaibwvSHZ36QnlZDv71hIV8dxp2JjNBSUX4wxaLpZpzqHqicDcTd5L/OCiddqq
         0tChgd9FUrH2Ka15ODOBekM1LIlCu3BAZMTzfRRmJODEN/K+6LKWJtr6dVCo2EH+kamt
         rcg5Osnip1K5WZ6J4Lcc0mYKiq4+YZ9JCrmuogDLTPWOz4hpSXBAsAKn5xujrnLOnOyg
         rwVtumZbrDgWMb7iHLQH2GsemNj+BTxW1A3RT4RdxbC4JxGL+TSm5ynmepE+N19zVzRg
         NIdA==
X-Gm-Message-State: AOJu0YzJ5eYiieR96hQKVdX2k3iLGCWxbhRYs6ybcnceM2wiaa6w0aka
        6a40lq1ysVnz1Sgl9KwxuazdmA==
X-Google-Smtp-Source: AGHT+IFcQ2qlK0GQP8GEXTsQak2+MXePR53tGpyJ3N820c/YZeJJd+vKtxglC7xqvrCg8cA86IPp4g==
X-Received: by 2002:a1c:7206:0:b0:3fb:e58c:7758 with SMTP id n6-20020a1c7206000000b003fbe58c7758mr1825096wmc.3.1692353796543;
        Fri, 18 Aug 2023 03:16:36 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o10-20020a1c750a000000b003fed78b03b4sm416800wmc.20.2023.08.18.03.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 03:16:36 -0700 (PDT)
Message-ID: <e2bb53eb-70ef-23e0-53ae-6dbfcb54639d@linaro.org>
Date:   Fri, 18 Aug 2023 12:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] clocksource: sun5i: clean up and convert to platform
 driver
Content-Language: en-US
To:     Mans Rullgard <mans@mansr.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20230630201800.16501-1-mans@mansr.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230630201800.16501-1-mans@mansr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 22:01, Mans Rullgard wrote:
> The first two of these patches remove a bunch of duplicated code/data in
> the sun5i hstimer driver.  To keep the diff clearer, the first patch
> introduces an otherwise pointless struct which is then removed in the
> second.
> 
> The third patch converts the driver to a platform_device driver.  This
> is to make it work again on A20 and A31 (I think) where it broke when
> the ccu driver was changed to a platform driver.
> 
> I have only tested this on an A20 where the hstimer is registered as
> expected and can be selected through sysfs.  I hope it doesn't break
> something else.
> 
> Some additional discussion here:
> https://lore.kernel.org/linux-clk/20211119033338.25486-4-samuel@sholland.org/
> 
> Mans Rullgard (3):
>    clocksource: sun5i: remove duplication of code and data
>    clocksource: sun5i: remove pointless struct
>    clocksource: sun5i: convert to platform device driver
> 
>   drivers/clocksource/timer-sun5i.c | 288 +++++++++++++-----------------
>   1 file changed, 123 insertions(+), 165 deletions(-)

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

