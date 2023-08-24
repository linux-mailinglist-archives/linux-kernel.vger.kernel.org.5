Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F950786816
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbjHXHFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjHXHEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:04:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471E9E4E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:04:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcf2de59cso833212166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692860670; x=1693465470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epDel6TpPlgTi6sKB5gJ0l72hGnrt57/HnyL5WYVXDQ=;
        b=KunHaC32uuSn1ziqE8KkBJSfNk48n7Be1u2t8yEB5C4r7BpE9/tCow/xRQFLAg23Qj
         3b7kuORbbrgXKbEp3/NxQgls1lhJoLTMJJGw2d+A6jWaSDmtXAZjeAoC2IrAUDwIdaP7
         bT9MuOHBlHcWKQAW9sxKJMK7Hj1xw0+adGhJQH19cG/ubssUL2yPV0Kz1MLUOMvH0qvP
         jjQA0UmK8TnGH4whqUywmLDPI5SvJC2J0nvZmS++A0GcxmP9DM5/WYH7/pDAuLkEUs3X
         Ys9/1jvAiN1e5NN+EtU+tiDraomqHeBI0nUnAjJ5Q78PPDDgiJo7thwmKxiZuwXmfkeS
         zO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692860670; x=1693465470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epDel6TpPlgTi6sKB5gJ0l72hGnrt57/HnyL5WYVXDQ=;
        b=A/nG4ams/3/cnhwATb0h5h4zdam4K+DMEVFYQ/qh9uja4VTX+g+v4ZGUAIFEP1SYpo
         8s/vjgn4z5zs5C0KJBMchvGHGQ8NXmf8awxIJXZ2zFgC1NL/5FYqpkAI6OLmev0qYTbC
         wqVW00P4JbiBGSNsimJ2PYWTfkT7E4PdOuFLQ2WhiC8oI2PbkFSLL7446PRM0kKd0Rjm
         A9Ao6deh6ayDOuSjTVBt7dTFFZ7rbPYxvs9Cj6bhJDnTzCoTHvRyN3whqqs1ETR5cyj5
         +cHSd41WhMi5wz2geyrbN34ANKToqcEw5b2WdDAY7XgRRtZzx3hdYjCj7bVAS33PqGqI
         UOHw==
X-Gm-Message-State: AOJu0Ywj80DK5Qqcjes9TXzFuQdaKeI7cuJQCXRPHECAuQy8o4U9KiW2
        idhCgJMMZT7RU0JOJwAHSYrtrA==
X-Google-Smtp-Source: AGHT+IE6R8i7XgIiAOlH2YmrMpDPdKnhhvHKTIFGgOMKQWjbC1Id3mCTDOtL8JrM7L+8mawHUqjSCg==
X-Received: by 2002:a17:906:310d:b0:99b:ed53:5c12 with SMTP id 13-20020a170906310d00b0099bed535c12mr10628973ejx.17.1692860669780;
        Thu, 24 Aug 2023 00:04:29 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id lz16-20020a170906fb1000b0099297782aa9sm10416058ejb.49.2023.08.24.00.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:04:29 -0700 (PDT)
Message-ID: <9edcfc47-ed89-8074-6bde-d747ae73de25@linaro.org>
Date:   Thu, 24 Aug 2023 09:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] clk: twl: add clock driver for TWL6032
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcousson@baylibre.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, tony@atomide.com
References: <20230819134147.456060-1-andreas@kemnade.info>
 <20230819134147.456060-3-andreas@kemnade.info>
 <a65a7d976be4212ef71fe32c4ed2dacb.sboyd@kernel.org>
 <20230823165159.108875d0@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823165159.108875d0@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 16:51, Andreas Kemnade wrote:
> On Tue, 22 Aug 2023 15:34:59 -0700
> Stephen Boyd <sboyd@kernel.org> wrote:
> 
>> Quoting Andreas Kemnade (2023-08-19 06:41:46)
>>> diff --git a/drivers/clk/clk-twl.c b/drivers/clk/clk-twl.c
>>> new file mode 100644
>>> index 0000000000000..deb5742393bac
>>> --- /dev/null
>>> +++ b/drivers/clk/clk-twl.c
> [...]
>>> +
>>> +static struct platform_driver twl_clks_driver = {
>>> +       .driver = {
>>> +               .name = "twl-clk",
>>> +               .of_match_table = twl_clks_of_match,
>>> +       },
>>> +       .probe = twl_clks_probe,
>>> +       .remove_new = twl_clks_remove,
>>> +};
>>> +
>>> +module_platform_driver(twl_clks_driver);
>>> +
>>> +MODULE_DESCRIPTION("Clock driver for TWL Series Devices");
>>> +MODULE_ALIAS("platform:twl-clk");  
>>
>> This alias is unnecessary?
>>
> The question is whether this driver should have a separate dt
> node (and if a separate node, then one per clock as the clk-palmas
> driver) or not. See Rob's review of the binding document.
> So we have basically #clock-cells = <1>; in the twl parent
> and a call to mfd_add_device() there in the former case and I guess
> that alias is needed then.
> 

You should not need the alias in any of these cases. platform alias for
platform driver means you have incomplete tables and use alias instead
of tables. Preference is to use tables.

Best regards,
Krzysztof

