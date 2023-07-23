Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AED75E0F3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGWJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGWJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:34:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28176E67
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:34:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso30902515e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690104838; x=1690709638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OC0hL4ajjQBun5KqVFTzcpsSj0OMP1ItjYDfFgKDcog=;
        b=kp6dRrQUevs9NleJDIlPEeph5mcu+PXMAQug5ZzzeW6rl+pj4grKrkWk4egllNaPqg
         7ffRnavd40Fg4Q2eOFptOwQ0B0F50hw9pyeiYksz/SKYqFG5PYtp6W5BYLJweDRxNram
         YadqiUP3b+NTPMMzg/VM4/eoe+Y8jlmEGBU/89rrn45bFJpv2122TQ2YFHmVH6x2hKzX
         In6erAig/Oq5d8kxUycrrr377AjnvL0JViXl8gUEoKsiRWUEEXRqL0VHcPkXkAyPkdg9
         zP6eFmHtILztNQtEoNPMmQC26L1fdLqalNw7siSnstdYIdDNejNGhWV8H4vhA531pyVU
         g6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690104838; x=1690709638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OC0hL4ajjQBun5KqVFTzcpsSj0OMP1ItjYDfFgKDcog=;
        b=PJA7qOSUqPW9hlHwOjmHXxkGP1J2J4P+eGSyS69za/Rhsu/mYJkNdQyS9hEcFBoOvT
         SFzvkr9B1C/rT4mvysW2waW7fnBDm3DhQw0xm023/AimZEyi6XGfbCnuOA6SOpeiflvv
         Gy24n7gXeHhGRIRwXc4Ce8J2zCXl9imtN7dFQNgg/zy5tqIhQZYbRriTD23QUuPqz8Ji
         /EzmitR4Mo6SjLy4WyZTdd8IUe0CqXbE7AoTSd0ByD/pP1/GAvC7c0JpA7L+GMg++qeH
         rfAQSVUJDNfzTpN2mzhSfuQGy2km/vi6KROFT4/wziHiRnHxEL9GntnJeVpsFJDhpAoA
         zkTg==
X-Gm-Message-State: ABy/qLZ/Xg14nM0U+paGRz5DHOI18ah8gXvBhqEbfLtRLXXh69eTVtmR
        5nFUOzoyanh5ge5DX0j360Tyew==
X-Google-Smtp-Source: APBJJlGQYnTIzlGqoT+dviUAIa3bhjXpw2+p9F3nFx1r9W62L0Gpb/iIAmd6BIQ4N1VtH/tpbeCfgQ==
X-Received: by 2002:a7b:c30e:0:b0:3f9:871:c2da with SMTP id k14-20020a7bc30e000000b003f90871c2damr4859726wmj.40.1690104838588;
        Sun, 23 Jul 2023 02:33:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003fc17e8a1efsm9791468wmg.45.2023.07.23.02.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 02:33:58 -0700 (PDT)
Message-ID: <3c0f0a26-ea9a-faa6-9fe1-ffcf242b6200@linaro.org>
Date:   Sun, 23 Jul 2023 11:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/11] dt-bindings: remoteproc: qcom,adsp: Remove AGGRE2
 clock
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v1-6-cf6cd5c621d5@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v1-6-cf6cd5c621d5@linaro.org>
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

On 21/07/2023 17:36, Konrad Dybcio wrote:
> The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
> within the interconnect driver. Attaching it to SLPI was a total hack.
> Get rid of it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> index a2b0079de039..af78f76734db 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> @@ -91,11 +91,9 @@ allOf:
>          clocks:
>            items:
>              - description: XO clock
> -            - description: AGGRE2 clock

I think this entry can be squashed now with previous if:then:.

Best regards,
Krzysztof

