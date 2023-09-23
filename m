Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1689C7AC153
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjIWLoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIWLoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:44:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158C19C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:44:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so1390859a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695469444; x=1696074244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vla4OZsvqD5RmSyqkNtWVp3bfdJ5jFtYYQ5MrELcXSM=;
        b=nDbEAVteD7aGdLtChPEt/+FkeMGFRMhA1Nd/qCP6CxF202JZWaq+YPyIYDUT0GzGFW
         HLB3R5r/nn6/j/FJi7p6T9ALwPRXEeJOrYRywbYT8RKeO9prvdHu/7QcwPd+ZmqSYwTt
         huVEP4SFaDkhQPZtyqFlsTfJx4qENLp1XbNhFxj5ChEEclciuqR56QcKzRP1i9hISX+h
         3uRJx1VqodiWx+C+Yc3cN//klaJ+7mZDXvIX9hH8ZMaukf/clQue/1KVjo9ecFKdNYSF
         DLZoNiiGaqTjfHDxqTiKOw+QXkjkEG1OGgk4aL63DfnSIT5k1zaOH+hLqiUa/Da0hKH7
         1DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695469444; x=1696074244;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vla4OZsvqD5RmSyqkNtWVp3bfdJ5jFtYYQ5MrELcXSM=;
        b=ILXj+Nhi6bmXol6w0PPcFRKMv4XEGuTuzvxqDQ8vKsmXmiULViBQMLPecElpPCjbwt
         Bx7rWoHwKVrudVs5S2VyVNEHR9kGRk45GKWmlgWmkjzGYUeJS8xkXSdOfMX3ZoUMRVlf
         In74oRMQ1WP0m0I/k2mBLIxCYi2sHTzo9qxhE9LsxQUze5tnAqnN9xSv1NmcPPUlkrW7
         QDNcekcfvEIsxQ8zxchN1ZszPNoMTc0kh3IegJI9RM2OKlCip3bwnnfLN4yPvaSbaDdz
         743U5Iz317LLa0FWzgudsFhqzpsfz5YAhDNLyEfKpRqrg5iSFO08q11Liq+sz/G2Dits
         r90g==
X-Gm-Message-State: AOJu0YzZNVxs0pVP5rfTHHnK0fShFV4TJ7092LUeKWpvGFDcWE91QR9C
        9Os2MUDVEZHvdxUQFeNMEJjfOw==
X-Google-Smtp-Source: AGHT+IH6goftz+deG7oSTeTuzwqyw9P8c6mgIH9qR63I1IV/ch6sI7RIzn2uujDg7rQtq/HyjVsX6g==
X-Received: by 2002:aa7:c158:0:b0:52a:38c3:1b4b with SMTP id r24-20020aa7c158000000b0052a38c31b4bmr3444238edp.15.1695469444353;
        Sat, 23 Sep 2023 04:44:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id s3-20020aa7d783000000b0053116e45317sm3274449edq.44.2023.09.23.04.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 04:44:03 -0700 (PDT)
Message-ID: <f4fa94ab-78fb-d01b-7188-c498ec3053ff@linaro.org>
Date:   Sat, 23 Sep 2023 13:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Content-Language: en-US
To:     Sricharan R <srichara@win-platform-upstream01.qualcomm.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-2-srichara@win-platform-upstream01.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230922115116.2748804-2-srichara@win-platform-upstream01.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 13:51, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.

Then why do you allow two interrupts?

> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Added the tsens-ipq5018 as  new binding without rpm
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 27e9e16e6455..a02829deeb24 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -44,6 +44,10 @@ properties:
>                - qcom,qcs404-tsens
>            - const: qcom,tsens-v1
>  
> +      - description: v1 of TSENS without rpm
> +        enum:
> +          - qcom,ipq5018-tsens

You miss now description of interrupts, like the other variants have.

Best regards,
Krzysztof

