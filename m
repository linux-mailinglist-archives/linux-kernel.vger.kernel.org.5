Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD675AA84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGTJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGTJVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:21:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E817D89
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:01:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso720018a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689843623; x=1692435623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bn/gEmgkElav34nZl6GYTgEjfOrI0ANk937SmLwLQ4U=;
        b=UT21AB3KgYKCJbqB02xu+tn7xccRbOiK+9QRqaE1brgHSKVRZCIAADtv4IuAoDzx1y
         oPohGrH1z73O+YEhiEJlepluATAu6Fume7OjCXmmq8Wqf4FmJfFHag4qjuTkF7aYvSiF
         KadOmk/wW+4nnoNv068G4w43RVGQ0Ws9Yb+V48CRx2oEmXPGguN4DYZTLBcMJTue6mX+
         Iyw03wDrF+zxxBDxIxZibWO5qtxBVFd2kQKE/1r4M6wlpb+THeKIMwQ+FTnh6acPrpuB
         fpCBvmdoFAL2dSUULApdGbPWyL+zVeriKVz2ZC/ytSiY9+NmFLbhIYDXPzuFzYJoSuAJ
         OjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843623; x=1692435623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bn/gEmgkElav34nZl6GYTgEjfOrI0ANk937SmLwLQ4U=;
        b=XPZu0gJ+EsOwmqMXTgbCojPJ+e5UY0C0+qCXBid2lmSYnIDn7+TY5PhDzvSS4dkUNX
         +f5/pko9UK2NHYLgZVVWc3hzjUUG+h6sbW8Y/h+Gije2BGuTC6NAii7MoX0PscO07xg5
         ZltoXVzlTq7s0jTaEdirdbSCgedwyKLPQBQBEvFioS4HBZ3ukaFLGQe6fjNlamP37QyW
         fEAIfgz9FLqk8FtMwUzfbVG4uc4guMwI9q1U0o1iTaqwqaTwUW/8TU/fegxdVlunoRw3
         1tc5qWMxYocIYzazPuLhqST9EzJjs+3MZX6NtMt2qhLplPKQlQ9vTJ1pc5YE3Aws+9Yr
         /SGg==
X-Gm-Message-State: ABy/qLYo307O8QMEAk+6h0PGmESSndwp6hrZYnZjLv+2o+HJ0gO+QsoR
        dFdaaflBJWQn6FhBJPwtwUKSzw==
X-Google-Smtp-Source: APBJJlGQGyDb61qsT9vogQ5Ypq5JFWG3JHR5xF35fNkPaFBokYgbAJBkI65o6eXG4YCr9Sb84ptrgA==
X-Received: by 2002:aa7:d80f:0:b0:51e:cb4:2b40 with SMTP id v15-20020aa7d80f000000b0051e0cb42b40mr1504913edq.6.1689843623277;
        Thu, 20 Jul 2023 02:00:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c2-20020aa7d602000000b0051de52f8adesm453867edr.32.2023.07.20.02.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 02:00:22 -0700 (PDT)
Message-ID: <ebdcd477-5f15-cc05-ec67-42369b23f5f1@linaro.org>
Date:   Thu, 20 Jul 2023 11:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document MP03.6-C2 board
 based on IPQ5018 family
Content-Language: en-US
To:     Hariharan K <quic_harihk@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230720075731.20816-1-quic_harihk@quicinc.com>
 <20230720075731.20816-2-quic_harihk@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720075731.20816-2-quic_harihk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 09:57, Hariharan K wrote:
> Document the MP03.6-C2 (Reference Design Platform 434) board
> based on IPQ5018 family of SoCs.
> 
> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 922feb912594..2a18bb881624 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -98,6 +98,7 @@ description: |
>          ap-mi01.6
>          ap-mi01.9
>          ap-mp03.5-c2
> +        ap-mp03.6-c2
>          cdp
>          cp01-c1
>          dragonboard
> @@ -344,6 +345,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,ipq5018-ap-mp03.5-c2
> +              - qcom,ipq5018-ap-mp03.6-c2

Really, how do you see it being applied? You sent multiple conflicting
patches. Now, clone the kernel tree and use b4 to apply one patchset.
Then apply next one. Then next and next.

Did it succeed?

Best regards,
Krzysztof

