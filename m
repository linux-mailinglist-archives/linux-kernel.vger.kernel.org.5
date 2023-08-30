Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF08A78DE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbjH3TBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242998AbjH3KD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:03:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2E61B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:03:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50087d47d4dso8587209e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693389832; x=1693994632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aA2Dayv4Oe/O8G7/FYwi9OP3/w4lpPEhlrM3LEd7RiU=;
        b=DFZUkBlgMqHRmPlXC83xk7jbbdMkdRkXVZkJpxfjq/CLbcWtwknl2dZM6aerZ7MMW4
         +vP2y2qni+baNx6Ab8Alu14IolWnxzIJKf4auunWfL4rhTWdKu9vALfIj39irIx8F3la
         pRZeBEnTLFbX1tPD390apIR9sKETm4MR1eBAuhTtdaSCSLNxL+7iGddEdazmpsyZhU+S
         a9Fm28LAvciFn9rl+ChWsrxOcsP3Xlk+hn4l1HUr97YpcHF26TBDxv5fvsT+vKeWc8L2
         sZ2t+Xw84f6oiZlXq/wtOnwLzY2E2zhXx6ogdOwi92UAcSvaRGNotwFF1UJjYPVgIyru
         1cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389832; x=1693994632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aA2Dayv4Oe/O8G7/FYwi9OP3/w4lpPEhlrM3LEd7RiU=;
        b=iZxmBnW4SxAIu8ME5rb5b1gm609fXdVf3bnvdqaswwFPCNV/WWMyIgCxELO/pFo5Dn
         n/DcAscypE58uNsRMEAEzgy5KAt4WAwqiZAus+wnNuW5ryDvU3cOiKDl78CrwuROugWR
         Tu64Nw+DOlhTGNQp2SiMv+IPT2jzbvxDQTH/7cdLLrmimzzxOXvIgf73nTfgsZf3fBTC
         8bNGXa79DrXE9Bv8Hy2nEFS50fR3z7o9Y/uwZvIsfdLqOjVta4a0LgPsUcreo4rngk6P
         rrI16+Qc6e7NAdfz54NF/LFGKkoQzhwsRcgc5/X+2MT5MLYX6zmX1uMxjtCIxARsXCGT
         iNoQ==
X-Gm-Message-State: AOJu0YyOtLI4bZzTnaiWLK7UFo6OXSm0DzcyqSZyh0cYKacZP+p36O27
        0eSCZK+ZU/bj+dLwXm8/x0AVBw==
X-Google-Smtp-Source: AGHT+IE3zXCljvqDSTqW4Fk1MJeyD7qTPp19ksqtWCrPK6ziygOgdXiN7RSHG5AANWY2Zv7kF+XIdw==
X-Received: by 2002:a05:6512:2302:b0:4fb:8f79:631 with SMTP id o2-20020a056512230200b004fb8f790631mr1222638lfu.46.1693389832021;
        Wed, 30 Aug 2023 03:03:52 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7c69a000000b0052567e6586bsm6661378edq.38.2023.08.30.03.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 03:03:51 -0700 (PDT)
Message-ID: <eed9ddbb-08ac-238c-82b8-a575076c5d71@linaro.org>
Date:   Wed, 30 Aug 2023 12:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 11:58, Luca Weiss wrote:
> On some platforms like sc7280 on non-ChromeOS devices the core clock
> cannot be touched by Linux so we cannot provide it. Mark it as optional
> as accessing qfprom works without it.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/nvmem/qfprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This should not be between DTS patches. DTS goes different tree than
other driver changes. Please split your patchset and do not mix drivers
and DTS.

Best regards,
Krzysztof

