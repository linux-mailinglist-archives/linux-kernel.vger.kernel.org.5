Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B47D2D23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjJWIso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjJWIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:48:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AFC10C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:48:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso10208075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698050917; x=1698655717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/c4AWX4PPF8QK4ZXhsCeekbNaqDH6QhV4CfciFY+FQ=;
        b=Ns9TRPoaOT+fVmevKBp8AtOU52Sk4w4zQljRt2zZM8PRiBPTeUUkdglIdo/t8JbMyB
         mLts9C1aW2ppL97Ua7thQJ+vcExX/hiuAJpC7MOhxBKZVtDTMjF2IZ5zOUKhAEgX3GgV
         WcimHN2Yj9srbxcxp/aSQ9Ux046hM19Zx0vpTC4ioB5Ospmfahb8qxVx/JhT8Z8gzEKn
         xdFucLMXB4JoRQYa5huZND2FwPI1OZgeAuUR1x1m6ncPDHGOcDFktOvSHKfRFgAyXl+z
         GfNDmVW6l2UTSsfoBhjiqW44a0blbhZ6GHdni5B3wkzgNw/PrFSx4Y/JoqR00gJ3Cnwv
         sXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050917; x=1698655717;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/c4AWX4PPF8QK4ZXhsCeekbNaqDH6QhV4CfciFY+FQ=;
        b=oxGp+S3+qYP+RAtglqD3SzuYxY5UWGSuYArGt0asfEVq0GDeW/SEjBqihK0rbK4XyK
         npXNExC80b+cPjAo7grlH2SupJIXQrdC82UcSry0KeHS6O7nO7iIgV29LxH5TXMW6LPx
         ZMTt02FgLbv+z843l1MUgfLhuxk/mFCFFNFYy71mPihd68iCOvHJFNqfmqiF7bbNI5RX
         9wX8elv7fjFDpnTvYwXrJiKYyADuudEKFA+Z/ir6SctJMLZ6tjT+7S/Q7grK2imewt8S
         BUlsJH6RQjn3PHtDEVKpoN7uNofO3hp/g5bILb5SpSRX9IklNFG1NFpGDHImJzb5uYQp
         mKYQ==
X-Gm-Message-State: AOJu0YzOL1UTgAn6XX1WdoIq7PmNfcCchDYUo+QygqYHexPXL6UB5O5G
        wFid6UdEKuRRZB/cB0MYjqKgO0uXdsQ4w5JehPY=
X-Google-Smtp-Source: AGHT+IHq1HkktGqnWYXJ+QoJTcnLsKU5Zm4C44xQvvnqAdNvHd0f9kdKap0/JyHBH5U2AbpHCB0uUg==
X-Received: by 2002:a05:600c:1d19:b0:401:b2c7:349b with SMTP id l25-20020a05600c1d1900b00401b2c7349bmr6525314wms.7.1698050916778;
        Mon, 23 Oct 2023 01:48:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c488600b004080f0376a0sm8801590wmp.42.2023.10.23.01.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 01:48:36 -0700 (PDT)
Message-ID: <33514b21-25d5-4356-a820-4d2bd11056e9@linaro.org>
Date:   Mon, 23 Oct 2023 10:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] pinctrl: qcom: lpass-lpi: allow slew rate bit in
 main pin config register
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231013145935.220945-1-krzysztof.kozlowski@linaro.org>
 <CACRpkdZUSkr2MLB870Y5O2Qxvbnz++XUKMm+BXG1yx9vrOEvwA@mail.gmail.com>
 <8f608e3c-a282-4df2-abcd-8e38efc35843@linaro.org>
 <CACRpkdYzhEJhN9BFdbZkJ7LurtT+dFMg97SLY-q91SNCZ8bikw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CACRpkdYzhEJhN9BFdbZkJ7LurtT+dFMg97SLY-q91SNCZ8bikw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 10:27, Linus Walleij wrote:
> On Mon, Oct 23, 2023 at 10:22 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 23/10/2023 10:19, Linus Walleij wrote:
>>> On Fri, Oct 13, 2023 at 4:59 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>
>>>> Changes in v2
>>>
>>> I tried to apply this to the pinctrl devel branch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
>>>
>>> It doesn't apply, could you rebase it?
>>
>> The context depends on my previous fix which you applied and sent for
>> v6.6 already:
>> https://lore.kernel.org/linux-arm-msm/CACRpkdaybnYEmkgv7VG4fh5sXQ7uwHm2wH2Khja-P1b6idYr8w@mail.gmail.com/
>>
>> I can rebase, but I am afraid it will cause conflicts. Is it reasonable
>> for you to merge v6.6-rc7 into your devel branch?
> 
> Torvalds is usually not super-happy when we do that, especially
> this late in the development cycle it gets a bit ugly with all
> the stuff that brings in.
> 
> Can we wait with this patch set until the next development
> cycle or is it urgent?

We can wait, no problem with that.

Best regards,
Krzysztof

