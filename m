Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66A78989D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjHZSKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHZSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:10:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D0810FF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:10:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-523b066d7ceso2696342a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693073420; x=1693678220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QiagJfRx5PmjGMtP0dUi7DvNIVha/t7dHrhZvI83zo=;
        b=WsSgNBrqrlOgtnKRSmIfPV2pbGKqfKX1GCK0whPtAztjTVsT9PPs8OSoQxSvtsQJdF
         D5Ndk9sTCcE4q9tyc77eUdIr2fBshZGlNcx2yrwpIRoSa5lIcr5zPKfu4Y1JzN+ViqUZ
         1u359VPuql8fwxk3ebKBBU0lbyZ9VGWRruygvtu68RJjPWwa1MsUGw8XAGe5Ldpqdnss
         9Ji0wJJhYWa+b91DpYAPLpnJO4GvlfTzPA7vBd3t9DJBizJqxuqR6WweN51WddUOEmGC
         4Dm69tTgQpazyJ4CZNrryqIoUL0JIA0f8z+Acnw5snEqsp2PD/+IascZAwPD50xwewTz
         pndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693073420; x=1693678220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QiagJfRx5PmjGMtP0dUi7DvNIVha/t7dHrhZvI83zo=;
        b=GhFrr8EcDlzTOJNKveqTWi8c37PqV3zhkP7vWJb6rpOf+eEKJSZYWO5lHVRaWLgyDS
         UYGa0Of1Kb0itzh9M3dZ6W9EJLGdSvN/gJObZRWOc3+c03iANxBYFj5IcH7qEp+1JK5v
         eNSgHBjF3ZNRdk0sdBZjYJ7fNr/ry5IkBTc4qpyaILWTe/aNL+cetiwLeOefNhf7qy5w
         gPwFzs58XZzjFRMeU6wRnFD8lupKb8OTxejuwgtbc+ixiEKlWhx0+24SJ/Hz8EA1DHcb
         L2OkS3EnnLyZ2x8vZjf5ka2V1+mpIGl/0glVUw4+FXU7R/cW904aU5uGh6Bi4MJAAZhn
         Yq8A==
X-Gm-Message-State: AOJu0Yyrd4oG4T4DrgZAGxGYoKHT2W4+lPSL+HHhEny7jX9A5Iu9bYfW
        k6uOcJVV7FjP9UesRLVTzO4ZBw==
X-Google-Smtp-Source: AGHT+IEFWoVX8d9z28lL17g6Z+qe5o8zR28N7GoXPVvbRQc4gaGzV9XT5uFIFnm8ML7Ge9ve5Sb9tQ==
X-Received: by 2002:a17:906:1090:b0:99b:c8db:d92f with SMTP id u16-20020a170906109000b0099bc8dbd92fmr17059997eju.69.1693073420226;
        Sat, 26 Aug 2023 11:10:20 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906361600b00982cfe1fe5dsm2452697ejb.65.2023.08.26.11.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 11:10:19 -0700 (PDT)
Message-ID: <6fd3a9ab-667d-934b-f1c2-03776be93d4d@linaro.org>
Date:   Sat, 26 Aug 2023 20:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/2] arm64: dts: exynos: Enable USB for E850-96 board
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825215445.28309-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825215445.28309-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 23:54, Sam Protsenko wrote:
> This patch series enables USB gadget, USB host and Ethernet support for
> E850-96 board. The most major change was done in USB PHY driver, as the
> register layout of PHY block in Exynos850 is very different from
> Exynos5 one.
> 
> Changes in v2:

Thank you for the patch. Looks good.
It is too late in the cycle for me to pick it up. I will take it after
the merge window.

Best regards,
Krzysztof

