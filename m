Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B8758E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjGSHPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGSHPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54BB1997
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:15:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso60464965e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689750925; x=1692342925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSD4oXj3W1W0X/B1/8C0SFn8Fii6AalniSnEduWk8+g=;
        b=yIkfceGwlwS3yN9Ff2oFuf5xonxPLex7zBXLi1+VIz58aPaajU1E6YKGU3Xkwu38v3
         7kQhAdbvS7CIRtco4PZ6Ks7svZ4Bcb5swf6+eQd0WNB4L1lhPruoVFSXsYf3IdCG6RQS
         aiOKexeiYQSw9yZcqW9VzRS4k6EIAycSv4vPkr+XBVqbb+wdbZ661f2gUi3VYye5H1Jp
         4Uz0pJzX3r5VL5gePO1OnzQ6wYgEPZjp6/TUdd+JKh6F9ntM9ftFkgiyYGsWdx+RirZ1
         bydlFnSHJmWy23p1EV/SvOZoT7SqQGnvqyG95wRwl6Q6oeZN4bx7k7ajXPb2rHFMmxEK
         iKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689750925; x=1692342925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSD4oXj3W1W0X/B1/8C0SFn8Fii6AalniSnEduWk8+g=;
        b=AslmbBy2qyWhPFsht/glr3+gKlQhUm04eamSZZvEUja+DSVL4blZfdfud168qaL+WY
         9agzaxFdSKY5optV77ie4MFtWzcKFfMT+YqsbACjNROON0lQpNnL+FFOvDDrwb3THnFc
         J2FJ5o8NIHZTZqItFMqnl12XL67ye7cdpI9xj2PacXnkNGWkgO7leUjLgqrerMT1zkLh
         Wx7UfW4rUsAnGJvoV/3FbE93oDUtOJ8w+fWOWKhKZCel9MJwaDvmYvROGgP4t3Q/OhYa
         96oiTeOs1+ekK1K86Bd3PmW7fdYgEuHEgq2Nnyw4Mnj0Nssc1xwjHWa8JC0h7jbRsVi+
         7bwg==
X-Gm-Message-State: ABy/qLaGm9vD/lfxoOB+5eW/jR4ZajN3OW6SqOVL+DfwOaPtwt6GErrn
        cXqumkJev9OXGWW0S+e8irR9H9iEpboAQS86LXxisw==
X-Google-Smtp-Source: APBJJlH7+EEhGrtoo4pHXOdKSytcZJ94BuO2zI4aOFPiixCW4Uf/FcIG6QYPrIznlzhS2dH0SiaUeA==
X-Received: by 2002:a17:906:10cf:b0:993:f83b:43d2 with SMTP id v15-20020a17090610cf00b00993f83b43d2mr1594487ejv.24.1689750904563;
        Wed, 19 Jul 2023 00:15:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c9-20020a170906d18900b009929ab17bdfsm1901790ejz.168.2023.07.19.00.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:15:04 -0700 (PDT)
Message-ID: <499d1134-869a-050f-c18d-9e7460d87989@linaro.org>
Date:   Wed, 19 Jul 2023 09:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [V3,03/11] dt-bindings: clock: qcom: gcc-ipq5332: remove q6 bring
 up clock macros
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_eberman@quicinc.com, kvalo@kernel.org,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
References: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
 <20230718120501.3205661-4-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718120501.3205661-4-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 14:04, Manikanta Mylavarapu wrote:
> In multipd model Q6 firmware takes care of bringup clocks,
> so remove them.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  include/dt-bindings/clock/qcom,ipq5332-gcc.h | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/qcom,ipq5332-gcc.h b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
> index 8a405a0a96d0..da9b507c30bf 100644
> --- a/include/dt-bindings/clock/qcom,ipq5332-gcc.h
> +++ b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
> @@ -96,15 +96,7 @@
>  #define GCC_PCNOC_BFDCD_CLK_SRC				87
>  #define GCC_PCNOC_LPASS_CLK				88
>  #define GCC_PRNG_AHB_CLK				89
> -#define GCC_Q6_AHB_CLK					90

This does not compile, does it?

Best regards,
Krzysztof

