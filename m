Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4037A79B8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245148AbjIKVIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbjIKQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:05:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1661B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:05:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b393df02so54241985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694448339; x=1695053139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBVJ2wHJ2/UKLMCz0YHp9T+QNyQaVPOEmzHr3wHgHAg=;
        b=iirHIJlj/Q1ROqFAMDiIEBdBoauZRMnmRnc0msgGDaO9EZZmBmn7Cn8dQiejSkxgkl
         SZ9JPgsKdOXkTdAAs2S7UEldKGnXJ9/ZkaRMc+wWG1VvhrY6I/AoZc5AG3h/P6jjDkew
         J5WewO4CHKoEHL1E9jttRTqwo877Qj6S7BLSguonSMvbhto+YRaAs/foKBq5Bh+v7RrS
         wuqoQot43wlKYK9H+9s9GUIBdER6EJVcd4rp0oiR/w+IeYwn73/SLAaiWOUGVzHVMv11
         i4Zlmy6lA5S/gOOaT8GgxefdUKiyAQPc/wOQVILBKLVfPQlfGN2O1B4vo8OfuAsabtE1
         J9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448339; x=1695053139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBVJ2wHJ2/UKLMCz0YHp9T+QNyQaVPOEmzHr3wHgHAg=;
        b=DZ67T0ODyOvIgdZ9vr2gGc/bXTmSYGoP6fw89VjRyp+5IU730Zbjfc5X94EB3nIJAl
         05lpmdwV3lcKxSln6TMZW5ifwrAM3t3TpNI9SWwA2JbcJWwduE7pg9swXabdfpwwJYjt
         CHl8b7Hlu6Z4y6/H4M9LDn8UR5R5A5KCK2XTDcg1eUtaOlf+/yoe6+eOFdJ4srT1J0gE
         NIyspvQJBo/cFVpQ7iPUKyNYRvbWBKGBUp7ndXJtx4wwG2P8qOfi/Iik2ES8O1hymO8P
         JaDkc3/ILLFNQBCglGGieR6i8Qpkl8zGw9XXm04u+x9WJx5wOmsAiTh1WrkJHXuwT+ta
         fudA==
X-Gm-Message-State: AOJu0Yw6+C/WUjW7BvjgeTN0dJqh16/kSVgiFxZlu1J6+6eTVk+E9fuo
        bnLFIcxrocqjpxoUAsFCpIK9xw==
X-Google-Smtp-Source: AGHT+IGyuy2+dN6nVi/A8nEkH5DvEYQPGPUixpXjx1K6xC3tj2xMB32WaeVax7THWg5xlQU35kx7hg==
X-Received: by 2002:a05:600c:2116:b0:401:c8b9:4b8a with SMTP id u22-20020a05600c211600b00401c8b94b8amr9091672wml.29.1694448339176;
        Mon, 11 Sep 2023 09:05:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003fee6e170f9sm10490902wmk.45.2023.09.11.09.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 09:05:38 -0700 (PDT)
Message-ID: <5f1791b4-78d8-9895-e639-238411b60f00@linaro.org>
Date:   Mon, 11 Sep 2023 18:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/11] thermal: exynos: remove fine-grained clk management
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mateusz Majewski <m.majewski2@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <20230829091853.626011-1-m.majewski2@samsung.com>
 <CGME20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6@eucas1p2.samsung.com>
 <20230829091853.626011-5-m.majewski2@samsung.com>
 <a3b9ff0f-fff9-9439-5ec9-95a4de9bdfaa@linaro.org>
 <afbdce92-beb9-cb7f-305f-968c71dde838@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <afbdce92-beb9-cb7f-305f-968c71dde838@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 10:40, Marek Szyprowski wrote:
> On 29.08.2023 11:56, Krzysztof Kozlowski wrote:
>> On 29/08/2023 11:18, Mateusz Majewski wrote:
>>> This clock only controls the register operations. The gain in power
>>> efficiency is therefore quite dubious, while there is price of added
>>> complexity that is important to get right (as a register operation might
>>> outright hang the CPU if the clock is not enabled).
>> So once it is done right, this stops being argument. The benefit is to
>> keep this clock disabled most of the time, which now we lost.
>>
>> I don't find this patch correct approach.
> 
> I've suggested this change while playing with this driver.
> 
> For me turning AHB clock on/off during normal driver operation seems to 
> be over-engineering and really gives no real power saving benefits, 
> especially if thermal driver is the only one that does such fine-grained 
> clock management (none of the Exynos supported in mainline does that). 
> Removing it simplifies code and makes it easier to understand or read, 
> as the current code already was somehow problematic to understand and 
> unintuitive:
> 
> https://lore.kernel.org/all/c3258cb2-9a56-d048-5738-1132331a157d@linaro.org/
> 
> Taking into account that the driver is not really maintained, making it 
> simpler without noticeable feature loss counts as a benefit for me.

Hm, ok, let it be, although I bet once someone will come and start
adding runtime PM for clock handling...

Best regards,
Krzysztof

