Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C191762F07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjGZIBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGZIBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845E3A81
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bc0da5684so69880566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357986; x=1690962786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usiVN6w6Ebhu1ynu6vwx4lPog2bSjYwM+8IhkVyHz/4=;
        b=IB94gmojOu/wEItAP2pf6CLaskyxBrYWjvz/t9mGWLIIXMKUG8b3Rll/DamQ/Bd+46
         CfBBHWyMsYA0tmkM2EgAFaixvwFoIAPlfRVc9SrmriuNn858n1Xmxniu3miTz3Yowpw7
         5f83J214px60uGasJY8IL0c7uVvV+n99FVy7MfZEHnR9dvmBUuLP5s/IICwRkjQ2G8CU
         hF1icMgjEoutXdcZnLHx870RtBMZbfOTka6XoKUbrawUgtnuoff8sri9d93a/IlaMxdu
         npZiBpPnRFaGBZTKyZdLmg0gVvxdTnZQwBoACg7ZLiKrhMtek923smUzUDi4ks5+oEXs
         wOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357986; x=1690962786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usiVN6w6Ebhu1ynu6vwx4lPog2bSjYwM+8IhkVyHz/4=;
        b=hW+QX5l7vQJdd3yvxA+TPA17dCnL/snXNISUZInw5AqRm18hUh8z232/uLZvYI3M73
         whcYxZvxGxcS1QPORku231oxS8emHpAyP0csGL6rW9ppcF0stR+7ogcxnqS9BeuDtZd1
         r0DesD6aDKPzpOWy3ElcBJAEqjxFEIRodNmUlBIxfFnXT49kOh7LSK+KynwJVCg39Rt7
         EvEz0eTNxLq94arwAipesAcDjOmG/GbeKzIJWztvWKrz7GTXprXhH0ks9VU8ZsORqly/
         6LqoDpKUVxcTDrWuyuOJF342dKNWeE/OYbrG3JZGMum9ZwBDzAmP47If3xqJzBwcrzXI
         UL/A==
X-Gm-Message-State: ABy/qLZN3Onckm9f0O94iLovUDo1hqZkjz5CjUCKFiizSo9y01ZFUObF
        ln91ItCPylnI015YMfnI53wofw==
X-Google-Smtp-Source: APBJJlEhYcqRUbuL+GvFQoytCEAXK4VcxpKrPGWPy6VNJz3mGQDEfO2phn/9t3hy5LvKTm4ApRNzjg==
X-Received: by 2002:a17:906:5a4e:b0:99b:ce19:b697 with SMTP id my14-20020a1709065a4e00b0099bce19b697mr13485ejc.73.1690357986117;
        Wed, 26 Jul 2023 00:53:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906814600b00993cc1242d4sm9228092ejw.151.2023.07.26.00.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:53:05 -0700 (PDT)
Message-ID: <367ea415-6b33-248d-6725-de7330b3984b@linaro.org>
Date:   Wed, 26 Jul 2023 09:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     luca.weiss@fairphone.com, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
 <20230725193423.25047-2-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725193423.25047-2-quic_amelende@quicinc.com>
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

On 25/07/2023 21:34, Anjelique Melendez wrote:
> Add binding for the Qualcomm Programmable Boot Sequencer device.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/soc/qcom/qcom-pbs.yaml           | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml


Again not tested.

Also, you missed comments. :(

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

