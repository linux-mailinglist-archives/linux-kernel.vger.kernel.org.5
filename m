Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E675F8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjGXNyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGXNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:54:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18A526AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:51:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98377c5d53eso710789566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690206681; x=1690811481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxYYSDYA0vOcxcUc1Cpos3Fbh+vKP5JOxboFjD2CYgg=;
        b=U+5grAlrNRzLmXTMqLK58S+q+vBaXcfwn1UohyTGtGsImDgEr8NBdytq6UwtzYFhug
         l1G6t30Q9kQMQ839v/om1TyYgWH4HYxlzV8DHJqdA/SXzYmZhgwfnKqrFT4tWuloLAi7
         Bd/VZ/RG9pL6k1JKaeQQSF9tWr3Fvk1cAL+5HQKzmDhuM17DrdCdpASlJP5q//95UgD3
         OAeg5AFcM0DByEBjIUk0yX3m+QLGDSmuR1tn1bAMHDGD5D3C5+hF1jfeAMuR2skH0XbC
         T50ihDwcyo9g6Fow1oGwfi+TvUXtKc2PP5lITLdYOPfXMd7dpOXILNrGrd2eSCwS4aEh
         bihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206681; x=1690811481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxYYSDYA0vOcxcUc1Cpos3Fbh+vKP5JOxboFjD2CYgg=;
        b=XNG+V+tTL7SNFcB+DTGYkGkVZsp2mtyVSyoL8Qo2HUDcxFwoiDcN6j/SKXLv7zD2mA
         iJH5GYpYaOG+MB+hvl6MbzNd1UPbe1c+isWMFv12ZFaOlxlYAeJifu00RwbdqxQ36/8E
         5mH2e029SQsT0ebzPx4+sRSaA9RAzZzWvc2RwbGXVbl/6uNQTzlFssTsyELgiCvHQdhV
         yunZe1mzDcVmuR6/d+i3XilrneEQfElsHE25T0gD1Wt99MSNgiyJkZSRZAbKaa5820eC
         hr/CjKpcVflsO6ztRIZckn2M//M8SwL3rXF501IRuiz3cLnr9u9TAnLRp2ca6+5tw2SR
         u7wg==
X-Gm-Message-State: ABy/qLagwBNGTFC4xRZyJE6lehkkt6zo02I5js54Xvc1UVBUhli9TLA3
        I1c0kqYpng+ufEqIOMcSKDphMYJvT43OFvh3oWKxAA==
X-Google-Smtp-Source: APBJJlFM/ecxyFQrohbIrR+Dt9S5DHA2ojaLExYPV7SY/3iPoEct/sihiV43gXZNoES9ffmbM2smaA==
X-Received: by 2002:aa7:d411:0:b0:522:21eb:fee5 with SMTP id z17-20020aa7d411000000b0052221ebfee5mr3789938edq.40.1690205828031;
        Mon, 24 Jul 2023 06:37:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q2-20020a056402032200b0051d9de03516sm6245505edw.52.2023.07.24.06.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 06:37:07 -0700 (PDT)
Message-ID: <e3771434-7429-7a18-ece7-8fa07fc78aed@linaro.org>
Date:   Mon, 24 Jul 2023 15:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add
 SM6115 LPASS TLMM
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
References: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org>
 <20230722-topic-6115_lpasstlmm-v2-1-d4883831a858@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v2-1-d4883831a858@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 13:39, Konrad Dybcio wrote:
> Add bindings for pin controller in SM6115 Low Power Audio SubSystem
> LPASS).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml     | 135 +++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

