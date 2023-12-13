Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD1811D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjLMSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjLMSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:46:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C279182
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:46:04 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50be9e6427dso7763021e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493163; x=1703097963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJcDS6iZliXqjE05cb2uxTI3zvo7+RZD1xOq9aPoV5E=;
        b=xqVyTqdPS6KsQCtisX7nDUNBxnFcmexBecTqq0Ye//WPZrYqDglW80Ubls/pTBlVL0
         fX3xh1oW2lZv81iazuI8Cznkvd6LRgIgT/l8KfSaE4LBedM3N454CMbrA8LSYC3wHqOG
         9tu4D8K2cYr3wuT/2gScyv0lTsCjPGELuhYlOMihdtsDIAVW3Hkyj2rpvY2beOAeEHhl
         onbzEWaPYzRxoudlF7/7CYOEcCqRUIls/jUtS/7yRq0rSrJ2TQptEDPID3GdKwH1LNoB
         rb0uG8/XtCtPzKYB7EMILK4TCtl7xEMeke3u7icT5I0ho5+2uSETI+IKkL2p4Gg/0vQ5
         zD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493163; x=1703097963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJcDS6iZliXqjE05cb2uxTI3zvo7+RZD1xOq9aPoV5E=;
        b=F6XIvKIxUDPPVOrWe/NkvzCBcIEIlLRoDH7kKy891+W6XkHBqHkApMS/8PEWwD4NcA
         bXIkCB7KBv3RYnSTFrkpENQ3lK117iYeRdyMNdE+rJpm9Fd9G0yPOfd1o6r28Vpz0XOA
         jPYXTh1zzpNqDUUUdUdu7ti8UKEhMEbHcvExqIEWPRIcx0USIQB7f2bKWzzwFgoZdjgF
         vyc/Vv/sW7FNCYjqmitOvjj0E0S3M+7PYhiCfl1OXUAoqcWWd15dMeKlCmF940NeEftI
         kR0ZzkhtyL4QIqf/3FmHv8imhnJB3xtJ4gSyMxspPaBTZSEyRFvG4gqZ7cHEjY7r9uEA
         H1Hw==
X-Gm-Message-State: AOJu0YwJo6DTyi7Eh3ZyQbepKezKK7DSl3j9WdvBylQZmHQsQhKpCVLi
        M47TbtkG63WR3g6YzxXA9kkmjw==
X-Google-Smtp-Source: AGHT+IFBTL+kVT6LHa5WVGqE7J+EbBusEZDVnlwohPacKbYoytXAPIlR7IaaWxn2/E6aOtvNjFtb+w==
X-Received: by 2002:a05:6512:39cc:b0:50b:ec63:8cf with SMTP id k12-20020a05651239cc00b0050bec6308cfmr5980794lfu.21.1702493162665;
        Wed, 13 Dec 2023 10:46:02 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f12-20020a19ae0c000000b0050bdf00f688sm1653687lfc.299.2023.12.13.10.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:46:02 -0800 (PST)
Message-ID: <a554ca80-d643-46a8-b15c-8cf9870e04ec@linaro.org>
Date:   Wed, 13 Dec 2023 19:46:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY
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
        Manivannan Sadhasivam <mani@kernel.org>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
 <20231213173131.29436-3-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173131.29436-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 18:31, Johan Hovold wrote:
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
> Fixes: d0ec3c4c11c3 ("ARM: dts: qcom: sdx55: fix USB wakeup interrupt types")
> Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
> Cc: stable@vger.kernel.org	# 5.12
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches the downstream kernel too (as it should!)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
