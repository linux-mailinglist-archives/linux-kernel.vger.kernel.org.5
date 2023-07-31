Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4A769702
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjGaNBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjGaNBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:01:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB91710
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:01:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso5986685a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690808493; x=1691413293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gHj3euc6IvaK2yxym4XFdLcoLwgJrcjksU1YEUljLA=;
        b=fC80ReJK3iWMlaL+BbSA0nCiL93bEX6P7tRt7ANtyVDgcScDhV+o3sOQoy97CaO4Fc
         tEL/xlWU0W0zhd1/GwwwfMA5AWJ1HFiLG1ILv44KuhGNkLxL0geNm6hFfep1aInXufV3
         138c9aHzw6SZ4hEp3lRsfcdYOL1ek71Xh1vgWdZSFwfyn0IjCYRHNVDg1TowaF4vxIby
         lShV/V8NVkLgnHdR1yV9dY0AReAgr7d/ExE/Mr8OFKXkLr/B0HczfGsEHpyXE4iTVlf+
         1y3p4DoYLUKZ74N85qMABPpsvNuABVHgZsj006Rx4ELfASa3hz7++2+jlUYJAlliXf/l
         mTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690808493; x=1691413293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gHj3euc6IvaK2yxym4XFdLcoLwgJrcjksU1YEUljLA=;
        b=h9OThlOJeq+m7WbyD22hRb8+eMbOv0BQVmZe3hRImvUEOVXmsQD1RdFfNBvuv/uEWJ
         xaTYdmROv6X0DAI8vuV3WnMIY3+FNoeUbWH15WRXQLbDBG9F4ZpueTk+e2rnfUadGQBV
         4bgpCBx5+IyYKTiPzYQYIIKn0X6RUg5cqbGk31LG5wgxdK6+jw1BZpK1Rj7+ue4HlGFp
         3anDzpFf1nf9WYlksE9vgVlUP0KLdRDGC2UtbUUw5GOCTm9CHrBoC3F7csNppXMs+L6O
         l2zWRok3nq4FGJGf1PbW5C8jnlk6O/OLAEUcrjYXKjIC+M6dXnxxjE8w5Tg4kOuoej9a
         F+gg==
X-Gm-Message-State: ABy/qLbE/0VgOih1Q3bC7jV+nL983+vvTBW05DvRJu8kdHpC0gVQcQeH
        rA5Kutx/xIlIH1TmU27A8UQPFA==
X-Google-Smtp-Source: APBJJlE+ddWgOsEvgPYwNxVC0LAn5r9swW2mMYAuK5RtUFhMlMdwzlsTYxQuUFXrZJsb+tcQd4wSZA==
X-Received: by 2002:a17:906:3011:b0:99c:20f0:deaf with SMTP id 17-20020a170906301100b0099c20f0deafmr815244ejz.77.1690808493404;
        Mon, 31 Jul 2023 06:01:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z7-20020a170906074700b0099293cdbc98sm6207575ejb.145.2023.07.31.06.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 06:01:32 -0700 (PDT)
Message-ID: <75cbeeed-84c9-7637-b2a7-b37d87f5872e@linaro.org>
Date:   Mon, 31 Jul 2023 15:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/2] dt-bindings: clock: intel,cgu-lgm: add
 mxl,control-gate option
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, yzhu@maxlinear.com,
        rtanwar@maxlinear.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Eckert.Florian@googlemail.com
References: <20230731100349.184553-1-fe@dev.tdt.de>
 <20230731100349.184553-3-fe@dev.tdt.de>
 <780aa090-3a97-abab-271f-59790df29cc4@linaro.org>
 <11386dd27487075a9a0b1a2aa7794951@dev.tdt.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <11386dd27487075a9a0b1a2aa7794951@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 14:59, Florian Eckert wrote:
> Thanks for your reply,
> 
>> You described the desired Linux feature or behavior, not the actual
>> hardware. The bindings are about the latter, so instead you need to
>> rephrase the property and its description to match actual hardware
>> capabilities/features/configuration etc.
> 
> You have correctly identified that this is not a hardware configuration,
> but a driver configuration. Currently, the driver is configured so that
> the gates cannot be switched via the clk subsystem callbacks. When
> registering the data structures from the driver, I have to pass a flag
> GATE_CLK_HW so that the gate is managed by the driver.
> 
> I didn't want to always change the source of the driver when it has to 
> take
> care of the GATE, so I wanted to map this via the dts.
> 
> I have a board support package from Maxlinear for the Lightning Mountain 
> Soc
> with other drivers that are not upstream now. Some of them use the
> clock framework some of them does not.
> 
> Due to missing documents it is not possible to send these drivers 
> upstream.

So when you upstream them, the binding becomes wrong or not needed?
Sorry, bindings are entirely independent of OS, so using this as an
argument is clear no-go.

> Strictly speaking, this is about the gptc and the watchdog.
> 
> Since it is a buildin_platform driver, it can also not work via
> module parameters.

None of this explains any hardware related part of this binding. You
created now policy for one specific OS. Devicetree, which is OS
independent, is not for such purposes.

Best regards,
Krzysztof

