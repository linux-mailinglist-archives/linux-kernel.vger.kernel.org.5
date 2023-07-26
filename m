Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C391763275
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGZJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjGZJhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:37:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1308E2737
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:37:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9891c73e0fbso169767766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690364247; x=1690969047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUdFsL7Rj7TOV3TMa/RIiUuM3Ig3WitH5zKl3a6zj7U=;
        b=Yqeibz8Pw2C5YNjJ0AuM22nL0Sp6k5H8d9dIRNXCzP7danQnPgEFyI6KLsunRzDqLy
         UEtoYBuNV6w6FvpPiqzVHPz/h2PzwWFYA3gRW9/zkD36tKMxFYaFQDLkC89tmN3fH6HG
         0RMPWE5M7Txi1uqg+CwDyvoaum51xECSn77EqV4jphCfci2WHFfSNpjCnYd/sSOsZh9J
         H+OVM5W1Qil609a8WNDzDbXsjxzhvD9neldH7sUlsdWR37ZiWGf6KpyWnRXoBGzr/j+2
         QTJjWzOprLsE5FitgynFWdOkuNPHXihPEfwQxU2yZjPFWNexwx4Z5WG5qWJMweaq5VVm
         q/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690364247; x=1690969047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUdFsL7Rj7TOV3TMa/RIiUuM3Ig3WitH5zKl3a6zj7U=;
        b=R4ugfCToEIwPQ4K146JYsaR3zrNq+lHwvCVIqnwy4oZzuyOaXah4W5Mz1pmOWlVgPO
         8cpzIZHH+Tw8E+18J8aO9Qv0/ETWOBqtwzkZKMj4DwhuNs49IuNPALMCY2ppcMEvdWKh
         6Wjekj9R9V3GIAdAWXhz4XB2soyGW8jOnQ6sZI7fuAJoWnJBPqZcq9ymMA9dKbKypn0B
         fCQW28KCcU3sz3Y6hEwpPleehFWjHwd94nD+AC3JJndTYZmz0TblCgtLK6Ou5UlKqR74
         1XEXdYqPHmxZ8IeCa3QHKWnbKYj0THFsEEVsZDUJvK6vy+R0dKSV0oFdIhpqQvojNRI6
         NT8A==
X-Gm-Message-State: ABy/qLbcXPBfF1uML4n8KZ2B1zHK+nEB7qePXyTY9On4zMQrCByMn3XP
        tjAmbnIQngJqvLTIpGlsDhhQpw==
X-Google-Smtp-Source: APBJJlGyMOlgcRnfytdUMxZAaSNwN60cSkk/EeAYqYSWHODAAc3zU54oBjgkiPE02PuuQim25n4HvQ==
X-Received: by 2002:a17:906:64c6:b0:99b:c2ce:501c with SMTP id p6-20020a17090664c600b0099bc2ce501cmr1394736ejn.19.1690364247517;
        Wed, 26 Jul 2023 02:37:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906240f00b0098921e1b064sm9306439eja.181.2023.07.26.02.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:37:27 -0700 (PDT)
Message-ID: <fc55d5eb-1bc6-84b5-b9f2-daf24817b8b6@linaro.org>
Date:   Wed, 26 Jul 2023 11:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS
 TLMM
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org>
 <20230719192058.433517-2-krzysztof.kozlowski@linaro.org>
 <CACRpkdbK7gU36nVOm0J+HbLk5JRKki+30=UaJ6hZjF1DiB4bBw@mail.gmail.com>
 <34be3638-ed14-bb0b-eb2e-c44f43c582f2@linaro.org>
 <CACRpkdY=WYZEfHuYsJe3kxk4-E3r4wp-Ln=GyvSY2m=+-Ow47A@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdY=WYZEfHuYsJe3kxk4-E3r4wp-Ln=GyvSY2m=+-Ow47A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 20:18, Linus Walleij wrote:
> On Mon, Jul 24, 2023 at 9:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 24/07/2023 20:09, Linus Walleij wrote:
>>> On Wed, Jul 19, 2023 at 9:21 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> Add driver for pin controller in Low Power Audio SubSystem (LPASS).  The
>>>> driver is similar to SM8250 LPASS pin controller, with difference in one
>>>> new pin (gpio14) belonging to swr_tx_data.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> This sure looks good to me.
>>>
>>> Krzystof, can you collect a branch with pin control changes for
>>> Qualcomm chips that I can pull? If it's OK with Bjorn that is.
>>
>> Sure, I can go through the lore search results and grab recent submissions.
> 
> Thanks, I think you know better than me what is the stuff that is reviewed
> and ready for merge.
> 
> I have this on my devel branch so far:
> 59d612a3215c dt-bindings: pinctrl: qcom: lpass-lpi: Remove qcom,adsp-bypass-mode
> abf02e132cb6 pinctrl: qcom: lpass-lpi: Make the clocks optional, always
> 1e46c7430af7 pinctrl: qcom-pmic-gpio: Add support for pmx75
> 8fff6514ff0a pinctrl: qcom-pmic-gpio: Add support for pm7550ba
> 75ec058db332 dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx75 support
> 4bbee99da13a dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
> 
> Anything else is in some inbetween state and I'm not sure of the status
> so it would really offload me if you could get it in order!

It seems only my patchset, SM6115 LPASS pinctrl and one my binding
change were missing, so I took these.

Best regards,
Krzysztof

