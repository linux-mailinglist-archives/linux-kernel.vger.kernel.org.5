Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502CE79740C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbjIGPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343744AbjIGPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E4E66
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:30:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a9cd066db5so138353066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100591; x=1694705391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGhxv+wLkUlJTnXgtlH4J46AYd9o45ySTLmRTKlekWI=;
        b=WOypJBbYcVWZcA2MEj6tW8cTk9OudIr8Sa7PQN5B8ou7qmA/2pEUrrPCxuLsfkbLOS
         beQqmrbORt4oXv+YfOO+9DFzQuW2IOxcVoTU3N73FI0gGovXjduEYU6hSgiytIZnumSo
         P4LYm0U4p/a5ZJuqlsNoKIPYK3nC8JNJvhMxYRadbLAgb2heJHX+xSRC+i0dK1f5jUe3
         yoH1JhPToTwuK2nzjriiUWZLm4Hyr/owwk7ic/MzdRqiV5ti0ScKgi4JFW8ugXz8drZN
         kMQqT8J/Cespf2aAFjlMn9+3ABEpRxSpTKE3UIvc+pMrZlab2S/lX1iP2Zs8cJT9eYur
         ur8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100591; x=1694705391;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGhxv+wLkUlJTnXgtlH4J46AYd9o45ySTLmRTKlekWI=;
        b=j2q1Yt3V3+zpFpfRBrRwZncdrtgWvZfAHUQlYeJBU6DuWFFYJqtd1C4tvaA8zOxRcL
         Jm25To6/Agswrom0tJHKiFScXMzAK8+HKqZNxBxqLSGTIXU7OQBLT2MC1FIYv2tZCqWH
         nBkF9V/EOpJUZOmmQ60sWzfSpqKidzMX5zdpJdJMwq90ZSani29BgpXvpxMveNAGImgm
         nDdnUhgiQNDvMLBpYK0RJ7FYACQVuTD90J67eVZsk1iuGr3jF7XzhHVxafeQBc3xSBUm
         3P92AR1+levtYl4a7RWhcQ43lOMvAwhTDaNuFZ/YanJtiZ03J3muUqTdH6QOzyAGnLNG
         Bk4A==
X-Gm-Message-State: AOJu0YxRLx0eSyoNsOJm8FlHq8czp2cn8abvhhCG+vEZMdEHMGuX42EQ
        RBspSoKej1rR0SEHE3egffPvPGRc/VA2FFXj76s=
X-Google-Smtp-Source: AGHT+IHgZdZSiR//XinTA9Y8E8bS2xBu6CE90k9cVQP1rRMZIv9GSOKD+LJS0NcyLh090bkwtAQy+Q==
X-Received: by 2002:a17:906:19:b0:9a1:ec3d:8ffe with SMTP id 25-20020a170906001900b009a1ec3d8ffemr4567309eja.18.1694066647510;
        Wed, 06 Sep 2023 23:04:07 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id qx12-20020a170906fccc00b0099bd86f9248sm9922585ejb.63.2023.09.06.23.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:04:07 -0700 (PDT)
Message-ID: <2de8953c-f1c5-3c17-5c95-973ef550bc32@linaro.org>
Date:   Thu, 7 Sep 2023 08:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 08/10] dt-bindings: cpufreq: qcom-cpufreq-nvmem:
 document IPQ9574
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <e0f54a4b249f24b10d3dc21a0224718e46ebd158.1693996662.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e0f54a4b249f24b10d3dc21a0224718e46ebd158.1693996662.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 07:21, Varadarajan Narayanan wrote:
> Document IPQ9574 compatible for Qcom NVMEM CPUFreq driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

