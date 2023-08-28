Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF178B827
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjH1TWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjH1TWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:22:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F651B6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:21:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so54804651fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693250489; x=1693855289;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZzbv65zk0nJCI2wEgZQMIkT4Jk+tWW8fdhjQacF/i8=;
        b=ezyYLtjiV6IB77dzakcg8zUem0UnLV8+p6yflQ1dWBwM0QGJfT14u+/bvfas0Qiz15
         ATTRZfn5Pf6Qy/i9mpn/sRKQZr3MvMMk/F7flVpGEr/WEbnMIHJsw7Q2U3tUFMvPcvwk
         P3iULzgydfBkPxsLAo4332As2hYvacog3Om0Q+A8sjv0wqewl2jjLmn5IVNRaXO5ji27
         GslxdByLbeUMAb4QExu1bukqAdRkHLIvzN+/DiT6vltntKLF+4RHLwG3ITMKs73RMaCw
         xbtQQyWSK4VV54RWpl7rpTqRM50q24b1Xg36IsxefJEDN5q8tAeC6weW+8XfminDeA07
         UDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250489; x=1693855289;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZzbv65zk0nJCI2wEgZQMIkT4Jk+tWW8fdhjQacF/i8=;
        b=He3T8znpCOQED+nYaF9x4nnlUPtv2escV7hxnX7et4D3lntUeuZTIyA0g4SfDzPyJW
         k42q7t3MWq80l5VND5aW3Ssvo8WGG8J5tojW2tSzEBRjUiwvNStoO462WfIqirHBFzYT
         p44Pu8cU06qxRyCBUjVxUZA5BfjwZrYImKaUhnkFjvxy/AXUlp23nlL2bFER0yw2p56h
         Zha7m6G1CkZfAFN85ZT46hd37st0I6NNSjKbGTefb/0FzckJFJB4R37NKsSOS+nWtjSy
         KdtB6zcWUUUcu1kQhzde1PT0yLUwA1EWDPnssgp2rKEREO81Ab/hRGakGLIuDD9sNlKn
         WJ8A==
X-Gm-Message-State: AOJu0YzaJcAxKtzraLI5rRy89nYsCm5uJqnBKFdDhY699iKbrnKOE0mk
        LhftVMmggR2gXwxilI5l8L5gkQ==
X-Google-Smtp-Source: AGHT+IFaNP+eheNOvTuZqaTRs6ZAxbf1C2zhXDPAqLf7L9co6sWkAkdgnxraz376IEYl3ILwU1pQmg==
X-Received: by 2002:a2e:b5b9:0:b0:2bc:fa8f:83c4 with SMTP id f25-20020a2eb5b9000000b002bcfa8f83c4mr4908008ljn.39.1693250489124;
        Mon, 28 Aug 2023 12:21:29 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id oy25-20020a170907105900b0099364d9f0e6sm4964417ejb.117.2023.08.28.12.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:21:28 -0700 (PDT)
Message-ID: <97501b4f-614c-b3a3-c17f-5699b21e101f@linaro.org>
Date:   Mon, 28 Aug 2023 21:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/7] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-2-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693250307-8910-2-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 27e9e16e6455..2309bb6dce1b 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -42,6 +42,7 @@ properties:
>                - qcom,msm8956-tsens
>                - qcom,msm8976-tsens
>                - qcom,qcs404-tsens
> +              - qcom,ipq5018-tsens

This does not look like placed in alphanumeric order.

>            - const: qcom,tsens-v1
>  
>        - description: v2 of TSENS
> @@ -409,4 +410,22 @@ examples:
>             #qcom,sensors = <16>;
>             #thermal-sensor-cells = <1>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    // Example 5 (for any IPQ5018 based SoC-s):

No need for new example for a difference in compatible. Drop it.
Best regards,
Krzysztof

