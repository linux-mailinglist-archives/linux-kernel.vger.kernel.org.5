Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12E75DB40
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGVJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGVJQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:16:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C842719
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:16:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso21544175e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690017395; x=1690622195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjLPvi1FspgtsU+iRqfW4DGJ0DYZN+h3ZxYcSap6Nog=;
        b=itJk4pYPMHFQaEIPQXNM5luzjbo4CeRBS1QoNluu3F10GqozIHymBxmYUFwhANRSAO
         8YskKYPXXOOFFxWpahl/W8yzA2dAWea8pM5qguel27MZAx08NscwAFygly3MaIQTUoTd
         m08X96v/dS2VLS+22Bql8kA9kLpQ1QSFR5Egz8OWqxxjFA98DNpxJH7jA2PE3kCDbIgq
         oIQgKLVQA62KoY6OlqZCGQsk0F3NSNPuiECYJmJQRsK3H5M2fqYK2iiV46OkibwYK7jQ
         nUgvpVaHktI08tLJMy4LnI4SHhmYHmW5Uqfui4NFZRFva1GRiEopKY5fvn7vbfIkCAzp
         0fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690017395; x=1690622195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjLPvi1FspgtsU+iRqfW4DGJ0DYZN+h3ZxYcSap6Nog=;
        b=lI9/QmzMK4qLVgHNNUT6JDfF/s2WgFd7fr1ZGAtgtq2bfcJNrAT4DW0Wf1CFiHvrqz
         mcwlOn9vYzn1P+tTn4v/TsYMl+sN0OAOm6uemK++5+bMiYfJtGjKQbgYpuYN7Yi+esBQ
         xIGm8NucQ3YEoGjBCywlPXGLexaRXbtDZT983kx7Lvc/IMwUFP99Z/7BDZEORFg2dzIk
         E/b2YYzDxbkwJGfeRKAbr2fPrkjBq0HoppSmqGkLOTE7aVM6Cz3ESsssYmEAqDGzF3s4
         aWPUtYJvxUA4OR6ZXfmMpRvLlKNB1E/Sd56D9a4FAWFggPjHINzmIXWvrTjTDNof/n5B
         TvGw==
X-Gm-Message-State: ABy/qLaExKCx23U6vM/Xp6dlCahaI4Ns5kxa9QMWz3dALe7xEArxMsiL
        ra8KBA8kB4HSgoSX0611di7qKg==
X-Google-Smtp-Source: APBJJlFXH3iIQRwLN+hhKyH3mIGrTzqjtsR4q0X49L1Dn/4pdyQyURArDG7sFY43dL3Rez4xOUKN/w==
X-Received: by 2002:a1c:f201:0:b0:3fb:ac9c:e6f with SMTP id s1-20020a1cf201000000b003fbac9c0e6fmr2914656wmc.38.1690017395287;
        Sat, 22 Jul 2023 02:16:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003fa8158135esm7748044wmk.11.2023.07.22.02.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:16:34 -0700 (PDT)
Message-ID: <689eebd9-8a74-9374-ef32-da71fc03851c@linaro.org>
Date:   Sat, 22 Jul 2023 11:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] pinctrl: qcom: Introduce SM6115 LPI pinctrl driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230722-topic-6115_lpasstlmm-v1-0-32d1643d8774@linaro.org>
 <20230722-topic-6115_lpasstlmm-v1-2-32d1643d8774@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v1-2-32d1643d8774@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2023 10:52, Konrad Dybcio wrote:
> Add support for the pin controller block on SM6115's Low Power Island.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

