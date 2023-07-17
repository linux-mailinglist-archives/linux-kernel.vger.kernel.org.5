Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC1756734
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGQPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGQPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:10:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5798710D9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:10:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9923833737eso559173966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689606602; x=1692198602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QA5RqmiVdq9ytXPcXzIE1eDmERmeAj1yVlVq+29cak=;
        b=NuXak2it5+OvgxyxGFQ+9iRpkh1horeYhUC/wdQedmHfHg/3yY6Xh4VLBP1JCQXapC
         8Ccl2xFSqu1J5FyLrEHRJuKTynWfVViteN3zpakLNfc5ExsglOr+2S17zzUCwVMnWUpP
         NEcdQXu6+M6o32GBJxOzUy5rAajZHVvAXDTGCruAcmMmONxnldvueAHycFkg1iXABtRq
         K/kLwENns0VXO66ozC33hL1JnR+KEpsyFDaMIQ9I1ypjgDhQLg97euF+yUKoi4uSlstz
         pACMqfuqb+XuME8Ay3wCEkfKBEC8OQcKpqQ7Tm/WWQlXqcx+yFScZKY+hKKU0HqGNcPn
         vrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689606602; x=1692198602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QA5RqmiVdq9ytXPcXzIE1eDmERmeAj1yVlVq+29cak=;
        b=i+bUr1r3dAXUav81TXgBdIdJsZJpU7SuY8GlbgemExFWUqof2YPw+dCpw/44UvOugV
         QdO00Pz8b3oFef9ojtXDJP0akXdkLJc0M7dvKNNjzGMUfJoYwVXOPcaE2DOfZIyVjBu1
         ugZ4dlW6Q32iRuuQTDNcBAYxtfZeVWfKj2GeuMhEYZhfbnAjfy7ZnwGUGWv6wURXfsGg
         z384fcMsUZ5z/q9OMDVhylEtqP9uctuf95+xIH8011c+Y3Z9e1gqEKaUCuQnvoaVGJEc
         R7WiIOkrgIdNiqTOmq4t+xag8XZ0IvzCkDAlifYt3PCZaqhHmqX9i571GawClm7Izzsj
         saqw==
X-Gm-Message-State: ABy/qLbBuyz8kC4n+lh3knv+UCk2teH7UXb/m0brsZsJ6oip50Wjp49C
        viGtt/jEQ+ymshfrFaR/N1gGlQ==
X-Google-Smtp-Source: APBJJlFZWucYJH85n4jsJ42GxhVYcW8vMf3uChkJVcrGjKy3sX2RQAf0T4BKbSW1Z/ebPIkAVIKfug==
X-Received: by 2002:a17:906:13:b0:993:e752:1a6f with SMTP id 19-20020a170906001300b00993e7521a6fmr13589495eja.6.1689606601763;
        Mon, 17 Jul 2023 08:10:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id bi3-20020a170906a24300b0098d2f703408sm9295246ejb.118.2023.07.17.08.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 08:10:00 -0700 (PDT)
Message-ID: <5bb3e8fe-c947-352c-732b-11a5a1b36d04@linaro.org>
Date:   Mon, 17 Jul 2023 17:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org>
 <20230328-topic-msgram_mpm-v3-1-2c72f27b4706@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v3-1-2c72f27b4706@linaro.org>
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

On 15/07/2023 16:37, Konrad Dybcio wrote:
> -                           <91 260>;
> +
> +    remoteproc-rpm {
> +      compatible = "qcom,msm8998-rpm-proc", "qcom,rpm-proc";
> +
> +        mpm: interrupt-controller {

Messed indentation.

> +            compatible = "qcom,mpm";
> +            qcom,rpm-msg-ram = <&apss_mpm>;
> +            interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
> +            mboxes = <&apcs_glb 1>;
> +            interrupt-controller;


Best regards,
Krzysztof

