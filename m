Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA857819E3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjHSOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHSOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:09:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAB422A1C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:04:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bccc9ec02so240735666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692453888; x=1693058688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFGcTo/69F+GnI13HvFYoEP0tlC7G+vSEOvYbpRTTDg=;
        b=R11HmsJto61+cA7c8ZX362Clf9rXrN6ubHAN/7X/QDfE/CdQ9u/6U6tMlulDvUMkQD
         imAFZ7pk4rT5FSW6kPgl6jmWcRATT/ssIgHS25mUqYjWfsH6or8cOK4iJxftCyxxMY52
         L+wD6xVgCV3vQBzXzoFkVjuI0q5lOiX3ji+M9rBuiXKhQIMlkgAnsdQNcephN3W/pEZw
         mV1jWR5mNidHLgtGE57wqK+MZu2r8NOfvMjgVXsmYOhJt3hVXHP/utDuEs9A+6pWnbSm
         0MbDZGLM+CXYUZaI6m6cD4QZSd6Wrxa0VUmD+71TKJf+OBmtEuvgkAwi5hqTKyvWsAqL
         0s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692453888; x=1693058688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFGcTo/69F+GnI13HvFYoEP0tlC7G+vSEOvYbpRTTDg=;
        b=OpAfEHLg2tOCo9fDM/kd6AWLCeTs7Ax2vasJpoZxkFh08Rv4X2Df5tquJ+QgC2xmi7
         q4jNzQ5Xbl02VKmXIbSY+AFpF9faRsTLy4bqZqAhxA7dxF+869HZuv4CAuZK5twRF04C
         HCsDHLPRqjMtOUtlKfvUX3NdMi4ERvPHQgLMx/kcNAB4C/HJpwqZ3rFG/xfSnUqrhY4T
         Td+Dbmt0IMzAROSuB/HIV0zFETkNs/oFAZRnu8k3JB+FKqhJX62eAte1PfaUwtiVfK31
         5uqNLFIF/yBiM2+kz/EC5iZICIFZLiSmKsw0RKSd8nfDOgW14fzdyiihAMS3/vsNFiw9
         OFLA==
X-Gm-Message-State: AOJu0Yyo5PRSLOr9EDrr1i3gt20C5G28sbGZg6WBR7QoddbZjXAzGUsT
        fVqrZCtDo+YKEcWoS5QZBPuieQ==
X-Google-Smtp-Source: AGHT+IH774MdAzqu1AOpOnyKt0gINRap/AtrmZOEDybP816BA8hblfQ4bI9Zts4RyG3vdf9GqAMN9Q==
X-Received: by 2002:a17:906:3152:b0:99b:d549:834f with SMTP id e18-20020a170906315200b0099bd549834fmr1610184eje.68.1692453888648;
        Sat, 19 Aug 2023 07:04:48 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906158e00b0099cb1a2cab0sm2783754ejd.28.2023.08.19.07.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 07:04:48 -0700 (PDT)
Message-ID: <a7862558-c6ea-4e4a-8d14-9aaf5c671ab7@linaro.org>
Date:   Sat, 19 Aug 2023 16:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: qcom,scm: support
 indicating SDI default state
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mojha@quicinc.com
Cc:     computersforpeace@gmail.com
References: <20230816164641.3371878-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816164641.3371878-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 18:45, Robert Marko wrote:
> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> means that WDT being asserted or just trying to reboot will hang the board
> in the debug mode and only pulling the power and repowering will help.
> Some IPQ4019 boards like Google WiFI have it enabled as well.
> 
> So, lets add a boolean property to indicate that SDI is enabled by default
> and thus needs to be disabled by the kernel.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

