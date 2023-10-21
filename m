Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C62C7D1E7D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjJURFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjJURFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:05:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F64F114
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:04:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c1807f3400so21697911fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697907896; x=1698512696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tg4luee61pXuzS4dMkxS68wnrt5RPD0pUcOefOjPqD4=;
        b=lZIxQYL1LHJs/RMSwUhIABrphKMegscdSmFHaMCoAsYJzsdtIVUl/x2fPA+yzSWh8n
         a9iM0koIpnAp+e6s+Z5AYL2joos/wUyl1xaTny/YLN5DAsPd44IlIpa78ANT7FoiAfQN
         Fgvl686eyT+LjbYc/jwoKBk6Lbdjy8sKIuAzLDTLcyPkWTv3GAPiIWrRDsypw7EzIq4k
         oLzE0RAGKJuR6lep+bd6apRu8CI++QOaw4AaF3o5dTmN3wxo1GGEMpJ4QG4tcVZqb5jT
         QZybYZgM5663Ibgvzewc+aWZXRrzU+ahyVfzEY1zeb+paENmdm7Oph5y2pqT2jJiboI2
         Ud0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697907896; x=1698512696;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg4luee61pXuzS4dMkxS68wnrt5RPD0pUcOefOjPqD4=;
        b=hz+6nNzUTWP93WlSxvThy86A5AicNuK07g+4ixhhFxfYQaQFac6c8Brce4LQSA+ite
         IcqcXGqx+9bWbABLdB3+DtAuzUM+fmyAK3kyWuV2kkMqmsxotEWOq3AAnHdRpmBdbGdi
         ArqO0JiCedHcfG3TTOpzQzbatdNXUrxBoG7Gi5psaY5fKbvpvcBKWUloQm9qKuP71Ybq
         qE1/mTiWtqTijr45JnsxYVnP0YoE2j/RNLLs8fcMOiR6L2UELxXfkFkoTKx6O8aLmzLr
         OpiVzeCxh8OQsgy9ysKUwGjBOb23Q4QuC4ejn3pzW34BjOW1QTXsfEFzGGiY1be4+fk3
         VChA==
X-Gm-Message-State: AOJu0YxjGygyAk9dloOY89dC/+cLEgXw5Et6fcQavVSisYmQ31e8KFZj
        vJXDP0CRy2ZBofrBAvjSgmppWA==
X-Google-Smtp-Source: AGHT+IHgb0LvlG1YXi/MM11Ad8QU0L/952pLT3/KLCvu3nTVbTbnlMPKmQdSgo0bqvEZkUHUVqMQaA==
X-Received: by 2002:a05:651c:1509:b0:2bf:f90c:4029 with SMTP id e9-20020a05651c150900b002bff90c4029mr1971419ljf.10.1697907896597;
        Sat, 21 Oct 2023 10:04:56 -0700 (PDT)
Received: from [192.168.1.116] (abyl4.neoplus.adsl.tpnet.pl. [83.9.31.4])
        by smtp.gmail.com with ESMTPSA id x22-20020a05651c105600b002b9e5fe86dasm875896ljm.81.2023.10.21.10.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:04:56 -0700 (PDT)
Message-ID: <b5033b2b-a39a-41d4-b47d-f120743a79bd@linaro.org>
Date:   Sat, 21 Oct 2023 19:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] clk: qcom: apss-ipq6018: ipq5332: add safe source
 switch for a53pll
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, ilia.lin@kernel.org,
        sivaprak@codeaurora.org, quic_kathirav@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <cover.1697781921.git.quic_varada@quicinc.com>
 <49422d258d67d33a2547fbb7f4f6e72d489c2301.1697781921.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <49422d258d67d33a2547fbb7f4f6e72d489c2301.1697781921.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/23 08:19, Varadarajan Narayanan wrote:
> Stromer Plus PLL found on IPQ53xx doesn't support dynamic
> frequency scaling. To achieve the same, we need to park the APPS
> PLL source to GPLL0, re configure the PLL and then switch the
> source to APSS_PLL_EARLY.
> 
> To support this, register a clock notifier to get the PRE_RATE
> and POST_RATE notification. Change the APSS PLL source to GPLL0
> when PRE_RATE notification is received, then configure the PLL
> and then change back the source to APSS_PLL_EARLY.
> 
> Additionally, not all SKUs of IPQ53xx support scaling. Hence,
> do the above to the SKUs that support scaling.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
This looks good, however I'm not sure if registering the callback
only on SoCs that are supposed to rate-change isn't
overly-defensive. That said, I'm not particularly against it.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
