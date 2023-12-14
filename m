Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23B6813948
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444088AbjLNR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjLNR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:59:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0912D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:00:01 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf898c43cso8237140e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702576799; x=1703181599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNzrB1u5cdRIIUK1CjwOMqB3675QEed56fbMDtEebUE=;
        b=XGKsI3FT7JIi0JWcFzEFUbQPJvzz75eMCPzpKa4UvycGG277rzUtsMeK3PzZjkWbiE
         j1WiH5j5/s2RpnqoHg0jOQREJpZOH4iEL/kD3S4OM3P6CnwJbGqzLTZDJhv0TK5ra19E
         ccIkwNspOxm16VzP8blEk+7ISvIacIeUiTrxE0sy01+kgXxFXntIa1QSgkMeVemHEMgi
         ms3vnywwHktq/9EJnC99pZ1zfpFfJbXQ15qPy7CLVEPC9vHyJm1omMn35nzquNKQRySL
         NJDxhWGOsucxXZyYOxXuwrYloKgr5XDmwtZn42weLqpp3WFYCGgoMg4Qe3YwSSy9uPdS
         vdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576799; x=1703181599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNzrB1u5cdRIIUK1CjwOMqB3675QEed56fbMDtEebUE=;
        b=J9sqV0hKNZ2qKplcRX6yvMlVLpzaKIqEEkdJM6yZ4tdXh2jNqkkmnymzgMbUW9T5f4
         /FhepFoB7/ZcVC9nbjezCev9sf2V8cW1vdX9yGf1iEAP9xZXxgmPKgo21x4PdSfiPSNy
         2djLgpohnwOzjEv+GvTpr8EahGK4fNZ9UDnsHaHRUHm7Y7qfkIGi7Y2i534MkoR6C4L6
         l7mtm9GFuA2Utnj0GwNsfxjaA6Y+jaodnNgrrW3QZfB3F/Qx1vLjp01Na/BGAs+JFtj5
         7jh+Wcpjr2S988MC3pz4yR9H/vnaVEl0Rvl4sM9e+t+8zSotoKQgojxm5JWj79JDQ6ip
         vbbA==
X-Gm-Message-State: AOJu0Yw8MCKO6kfOT93evLiCjm7sRrFnS+5kElNWq2emKGRd+x723akE
        xI0G3wWJj2E84PV5pXEqNX/wEQ==
X-Google-Smtp-Source: AGHT+IHR/BseF81sooOcwETh42XcEmC8wRC2CR5cbiuzH8kZrhbG0bSYS5JqYImuWrYkNYE76VTFMg==
X-Received: by 2002:a05:6512:3d9e:b0:50b:f269:64df with SMTP id k30-20020a0565123d9e00b0050bf26964dfmr4185701lfv.105.1702576799237;
        Thu, 14 Dec 2023 09:59:59 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k13-20020ac257cd000000b0050bff2648b9sm1919173lfo.203.2023.12.14.09.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 09:59:58 -0800 (PST)
Message-ID: <bba0160e-e495-45a3-8958-fba380e5a98c@linaro.org>
Date:   Thu, 14 Dec 2023 18:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sc8180x: fix USB DP/DM HS PHY
 interrupts
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-2-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 18:33, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> Fixes: 0dc0f6da3d43 ("arm64: dts: qcom: sc8180x: fix USB wakeup interrupt types")
> Fixes: b080f53a8f44 ("arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Vinod Koul <vkoul@kernel.org>
> Reported-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
