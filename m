Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473E0754F99
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGPQKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 12:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGPQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 12:10:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EFFE64
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 09:10:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so5237446a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689523832; x=1692115832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nunAbpgCigSo1UVgqQbYQX6rYQ6VpmSoXPi9uXeul5Y=;
        b=y2xuaNJvhTccxmfME73dUThdAMdNSHSc5U+0lgVAL7vIM0EF2D/6bsFtNWat7FEDGU
         h2TUbwy0IFacHqIdb0oaRB5J481WrwhffhNfdn0efsHtyYK4dE0slDPp4M5axdOo61fp
         fq0+thbO8VUWFUAGklS0q8c6AKp+CHAtNaBSX76ynbaQw9pSby2VaTqlXPusM5WW+sF2
         fFkCZHqO6WABZFnlGHFmKCGADv8NquI9gKc5m1xqi2wTu9SSi2dybFfZAW4LVxpHDOtn
         NP1tOrE2puHNNIe0IBk+hICffWdjYtzvDtqkNLc4+qJDjyxjgrsoKLWmscps/Ov2ZHsC
         A6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689523832; x=1692115832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nunAbpgCigSo1UVgqQbYQX6rYQ6VpmSoXPi9uXeul5Y=;
        b=cBvtJVs6py//7EJ78vJZudl7hWCK9VWs8oyqnYreZgPgi635M/a3bfnVIQEA4KVF5m
         Q9hG1buhKXmCclxyETwnKD8vtrKD4zqclhkZQkDeafuOQPG8ISkl8bzesTbSO1vqEjTQ
         LAY4FLLFO/pFFWdtNAehyFIYnnUsBaCeVoso4tB+vQLHzDzYqL7cIumbSRyiHCRWc8Ji
         shByRjZLKFYSOjRQyefhtrJwBNPWDWbLmQpcqT1AjQoIGuJI4BvtFhenCcOAAcACwPnx
         9wDDCcrokdH4kmHUvg4Tu+4DU7/4xvvDQZB9aFPl7xprkVsW4nyiuVwfxQ6sV0KzRA4V
         auPg==
X-Gm-Message-State: ABy/qLbRLwsUOprtDbfU2qPsdVqq27BVFT0J+y1dXrC7iioS5UhtmTHs
        eNHcMqBK8YAscrq6husoGduBDQ==
X-Google-Smtp-Source: APBJJlFZE6rc3YYDZaQSlbMBjCQrik0Gl8GkW7cit2/0wyKB/2+MlCfv6DNZXkuiK47emzXn16C42w==
X-Received: by 2002:a05:6402:3445:b0:51b:f669:9df3 with SMTP id l5-20020a056402344500b0051bf6699df3mr9387480edc.4.1689523832553;
        Sun, 16 Jul 2023 09:10:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640206d000b0051e0bf5807bsm8561066edy.49.2023.07.16.09.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 09:10:32 -0700 (PDT)
Message-ID: <ece51c2c-68a0-174e-f454-d44929181ac7@linaro.org>
Date:   Sun, 16 Jul 2023 18:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-e2015: Add
 accelerometer (v2)
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230715210515.13783-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230715210515.13783-1-linmengbo0689@protonmail.com>
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

On 15/07/2023 23:05, Lin, Meng-Bo wrote:
> v2: fix interrupt-parent = <&msmgpio>;

Changelog goes under ---


> 
> E5, E7 and Grand Max have ST LIS2HH12 accelerometer.
> Add support for it.

Your subject has weird addon: " (v2)"


> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  .../qcom/msm8916-samsung-e2015-common.dtsi    | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)


Best regards,
Krzysztof

