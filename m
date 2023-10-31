Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB987DC597
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjJaFBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJaFBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:01:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E5D8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:01:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f9675c6so7964547e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698728465; x=1699333265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0vSRGp3bpuT2D6maQLqwqNz6fES5NPFKKKSnA8K6yxw=;
        b=xlUnVLJQFhu+PlTin0eHstC3cIXCZGpZuKRYjeuSWwBi+D9k/zXuqt7o0gr8JVJRF6
         A/1S+kK/Hz7qfAeuez8tIgkMyKojoXubopEBP7Q0aOIFmaORJ7qk0P/AjLK1pghdiRHm
         KUMTMdAHjQGR5oRibmN5KN6sBPDm9hXr3dWERkJbve7M9Ohvwfu8HERS48lFhNNX+UaE
         6iTx8ETeenHSciWXM03xg7YZwXDAozneZ9z6PJe7NboepUjaeQEjtdHz4u24bDhPYMQW
         jGr3ATQRwihayUPVCJ9K9r5bQnk1PiyaZ0fCQY+Guy9IZYcF+Q49JcnUrod0MSdJSN9D
         te3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728465; x=1699333265;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vSRGp3bpuT2D6maQLqwqNz6fES5NPFKKKSnA8K6yxw=;
        b=f+3qwBGkuguT5yuxUWky6mO3zjS156bQwXl1MNZJkISAgcRxAqOH2M46O0EOcw/uOD
         6kM3YQ/4pvIynTtr0DDNQbcEw29nl8ey5Cn5dDP+FW+jYXChNmy/M33kkdx6o3Xqxi9Z
         /CvxxvEq01Ubi1KdEC8wTFjlg0/457Ne7v5lhqEb0bbCBwZDgisPaUKjm9fy5P2gQ8Qu
         iXhXVejobAv1/JaQJDeQjhpKQaDIKPR+zr84F8ZfNYVuIcV+FYqRj/aInZSSUWEUkM/4
         kmdREkgO+f6C2FKQOcI0x/ak3rgsf0uWc/Q77RbPo3Hey/BOg3DLAxyMxDNqECkLyInc
         QBDQ==
X-Gm-Message-State: AOJu0YyR/OW9TUSHAJ+CvZ2sXYNJGmeiPbFj1FbLnSoIPWCydHMx1M04
        W31ew5H5cPluM55kTdkKLmzoYQ==
X-Google-Smtp-Source: AGHT+IEF4WUHV6cbboqBhIbWpaxOcMcieHBy8PMxY6CmxF8crZuio6gENreTF3gHZ0uRaMYrjGp38Q==
X-Received: by 2002:ac2:44da:0:b0:507:9740:b6db with SMTP id d26-20020ac244da000000b005079740b6dbmr7384721lfm.67.1698728465059;
        Mon, 30 Oct 2023 22:01:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id j2-20020a170906830200b009a1a5a7ebacsm299859ejx.201.2023.10.30.22.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 22:01:04 -0700 (PDT)
Message-ID: <9a003bb8-f4da-4ae5-9597-647474f05ad2@linaro.org>
Date:   Tue, 31 Oct 2023 06:01:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4][3/4] mmc: Add dw mobile mmc cmdq rtk driver
To:     =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
References: <20231030062749.2840-1-jyanchou@realtek.com>
 <20231030062749.2840-4-jyanchou@realtek.com>
 <ebbbed14-ad93-4981-96f9-8cc344b63448@linaro.org>
 <225b6e3c21774f59a70c8a84378eded9@realtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <225b6e3c21774f59a70c8a84378eded9@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 04:47, Jyan Chou [周芷安] wrote:
> Hi Krzysztof,
> 
> Thanks for you to review our code and give some advices. We will check carefully and fix coding style of all,
> also, we will drop useless function and message in our next push.
> Since some advice we were not sure, we would like to discuss first and modified correctly in our next version.  
> 
>>> +     priv = devm_kzalloc(host->dev, sizeof(struct 
>>> + dw_mci_rtkemmc_host), GFP_KERNEL);
> 
>> sizeof(*)
> 
> Thanks. I will correct it in our next version.
> 
>>> +     priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
>>> +                                               PINCTRL_STATE_DEFAULT);
>>> +     if (IS_ERR(priv->pins_default))
>>> +             dev_warn(host->dev, "could not get default state\n");
>>> +
> 
>> So this is required by the driver but not by the bindings.
> 
> Since our pinctrl driver supports different driver's usage, we may use bindings to get the correct pinctrl setting, so we add
> different pinctrl-names in our bindings. It is correct, or am I misunderstand what you say?

Printing warning means this is required. If driver requires it, so
should bindings.

> 
>> dev_err_probe. Everywhere where applicable.
> 
> Thanks. I will correct it in our next version.
> 
>> Read Linux coding style. Multiple times if needed.
> 
> Thanks. I will correct it in our next version.
> 
>>> +     host->dev = &pdev->dev;
>>> +     host->irq_flags = 0;
>>> +     host->pdata = pdev->dev.platform_data;
>>> +
>>> +     regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +     host->regs = devm_ioremap_resource(&pdev->dev, regs);
> 
>> Use helper for this.
> 
>> Open existing, recent drivers and use the them as template or some set of patterns. Sorry, but upstreaming your vendor code will be painful, because you started from some old, buggier version.
> 
> Sorry for asking, but I would like to know what is the meaning of "Use helper for this." ? Does it mean we need to get rid of our code above or something else? Thanks a lot.  

There is a helper combining two calls above.



Best regards,
Krzysztof

