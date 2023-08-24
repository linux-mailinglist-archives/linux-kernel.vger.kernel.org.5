Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD578680C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbjHXHEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjHXHDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:03:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775071728
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:03:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcc0adab4so831151366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692860588; x=1693465388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P45nAftBMkI9aO/uXRibti5ezjszBIQ2T+bQqiHAg7Y=;
        b=J/3793hrGTYLIQrFLs/3h4rLwByn+HYPUKOvdOVBZlRd49ONEBMKcLI2nh5WpE7pOo
         UsO/Bvg2lPXd1bP9iKhA5AWiUX6XfhUQ9I7QIgiG0uwfzuW8NctmXlwOh/F8qgAiJyKH
         nQpgGOy6tYTYHe06Z8P5v1zwdNuegaggmRC4G0ZkHv8NM7TXLgDRQzWq1L81IEoj6HgL
         p8VZmyGRCuFgu7t3pVqyL6T8NSQ95KBB+hbbbBjBHx2wMwnztJGjGSXdwmyfvG7r9p7E
         d2nJS14n/zfM5s3aoHnG3GMK8MrT1Gfh+3NFsWKnF7uuIFix3AXhtQkqZPYGyZN571kZ
         ZrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692860588; x=1693465388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P45nAftBMkI9aO/uXRibti5ezjszBIQ2T+bQqiHAg7Y=;
        b=ROIR77JdGlnBiDKQi9oe18ZRhdAqepkx3ZCzxSMBIt34vEYST8CFrntW1RKXU0wnu7
         KxwSvTtsTjtzRYZE3a2xi0TQ8k21fkFRfIDGjfopZymqz71oLchSvptl9n9vS90nAGQr
         LIEx3zR5+t5Lh1Fszq+4qXez/Jo7UuWLvlikw7XzK23KkpxtD3nTOvI86mzQSZVyL/lF
         kZwyQ1UlHMnzaU9QwZugoOjqkGJIH9GleJzwvuejm+hYDGP90vk3vIbE/NKPQo5bE/it
         rVJTC/CHlwNrlYiKN62zlXa7nciinl/AG13PoWTt04PXRJIXzv6h1zLCR4MnQ8wmndGo
         icFw==
X-Gm-Message-State: AOJu0Ywu7zsyNPLKQArc2Ykg5ImvvpblnFzlAMX9ndTwAfactNIXLHLR
        0wwwhziuB/9DIoIAITelXem0Yg==
X-Google-Smtp-Source: AGHT+IG9k8iOK1esFA6zAJ01EbUnrxPhvANPyRf1UsmBAx7WseNQfibQsTJkl94LBBFoLMX8n0VUjQ==
X-Received: by 2002:a17:907:2c54:b0:9a2:1e03:1572 with SMTP id hf20-20020a1709072c5400b009a21e031572mr305572ejc.19.1692860587958;
        Thu, 24 Aug 2023 00:03:07 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906528800b009887f4e0291sm10559750ejm.27.2023.08.24.00.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:03:07 -0700 (PDT)
Message-ID: <413bb886-a734-e607-8dd3-79ee501416b2@linaro.org>
Date:   Thu, 24 Aug 2023 09:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/5] ASoC: dt-bindings: Add schema for
 "allwinner,sun20i-d1-codec-analog"
Content-Language: en-US
To:     Maxim Kiselev <bigunclemax@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
References: <20230805180506.718364-1-bigunclemax@gmail.com>
 <20230805180506.718364-3-bigunclemax@gmail.com>
 <20230821154739.GA1720453-robh@kernel.org>
 <CALHCpMjoxV+sUh6KSVXfEcWgc_ETBHWo2a7xHMT-nKS2xBYOvQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CALHCpMjoxV+sUh6KSVXfEcWgc_ETBHWo2a7xHMT-nKS2xBYOvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 18:13, Maxim Kiselev wrote:
> пн, 21 авг. 2023 г. в 19:47, Rob Herring <robh@kernel.org>:
>>
>> On Sat, Aug 05, 2023 at 09:05:02PM +0300, Maksim Kiselev wrote:
>>> Add a DT schema to describe the analog part of the Allwinner D1/T113s
>>> internal audio codec.
>>>
>>> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
>>> ---
>>>  .../allwinner,sun20i-d1-codec-analog.yaml     | 33 +++++++++++++++++++
>>>  1 file changed, 33 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun20i-d1-codec-analog.yaml
>>
>> Looks the same as allwinner,sun8i-a23-codec-analog.yaml. Why can't you
>> use that?
>>
> Hmm. You're right. But let me explain my decision :)
> When I added a new file, I assumed that since this is a separate driver,
> then the binding should be in a separate file.

Driver architecture of one give OS does not matter for the bindings.

Best regards,
Krzysztof

