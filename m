Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7354B75EEA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjGXJGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjGXJFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:05:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89331E52
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:05:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991da766865so708503566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690189549; x=1690794349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qBTrjnoLMPhI5YTQA6DVRtgSqXnXbNpJNoKVH85RHE=;
        b=UfKiaBvDzfuRZfFZTzzjwQ3j8D4qXCeEqovTw+BFdwYYQsQ/bSd8SpMCg5KI3NtoHS
         no3tx7bqUwjQ+k4qHHUw/417iFuUB/B+xWSWNVjmbSf86DtlLGazVtPiJMawJFgcp5jV
         +C57nto4QTHFYrfpsHWa3EU5oM9qVMJEl887lRC9fHKW810esRi8c2Yq3CLHVR2Qxd+f
         gScmx6pcJgmHIUw36TFMu3kBRfJ6y6vACqhqeBTi/EHVKce25sACNqBTr7ZEOp/EYn4d
         Ou1Hh2LAzkpZw/Q3pY//h0NzynXaX6ni7zSeX76J7XlRi/r3aIqucul4f4Wufhp9P01N
         obwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189549; x=1690794349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qBTrjnoLMPhI5YTQA6DVRtgSqXnXbNpJNoKVH85RHE=;
        b=jWyoUBkkuR1QN2qJNHwS2EEV21kP0nBJ8wQ5SuRnx8D4QIennHlz2Ih97zN9xuBkRS
         RPsjLgaPULDgMHDvKlKNBEvHk+9baxR5PabPB3IbkUwNQXKweOQXP6dUe+w7xl5s72N7
         YjaV2BliQ3Lp84VQoWdBvKXyWM79zvT1jKp6dI53+vQcyElfdqpZ17pPl0CL5r3/kRr7
         N8xyY1hWO2hrgeV4hj3Hw7iGF37PsydfzebP5DhXBU4nWS8bh75ACFqA9v7PyPrm0mk9
         rcdSN7bn4lwUcatCwu4rdtOO4qD43kTQCN7gPepauOgw62diddFa4kkiAtBPJUV3/YGP
         qLig==
X-Gm-Message-State: ABy/qLYAMc2KBx/GRb0s8xlqrb/nqt33/HJJ83r9KZFuwgO4rG3D7KIG
        G+8z2JJcBAx1QEMmmo9+3VrPdQ==
X-Google-Smtp-Source: APBJJlGEaeQNWfy5PFWso8e07aTFyy4J/IEQjoHP1CCmOgc32EJRFyrwx6VuXaTiMbcq/GqEflFuPQ==
X-Received: by 2002:a17:906:5a4e:b0:99b:4f06:492e with SMTP id my14-20020a1709065a4e00b0099b4f06492emr10205331ejc.64.1690189548870;
        Mon, 24 Jul 2023 02:05:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906038a00b009929ab17bdfsm6406085eja.168.2023.07.24.02.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:05:48 -0700 (PDT)
Message-ID: <c52ee94f-f60b-f8f0-f93c-221beec0224a@linaro.org>
Date:   Mon, 24 Jul 2023 11:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/11] dt-bindings: arm: msm: kpss-acc: Make the optional
 reg truly optional
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 18:24, Konrad Dybcio wrote:
> The description of reg[1] says that register is optional. Adjust
> minItems to make it truly optional.
> 
> Fixes: 12f40018b6a9 ("dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

This patch does not make sense. It wasn't also tested. The code
(minItems) is already there.

Best regards,
Krzysztof

