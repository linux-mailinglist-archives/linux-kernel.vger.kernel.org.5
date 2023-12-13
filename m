Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB4811DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjLMS6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMS6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:58:04 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B190B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:58:10 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so8294778e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493889; x=1703098689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZUzcUAYKJKCVreBhAC/gAbdLaRwduwq5l8nhnkZ9Qs=;
        b=MqlHrheVo9reLIuB53KYt/C67JY7p5R4tsLLEyLS1iESkdNLof7/zHDTMhIWR21pQd
         Q7UH1e53vDmGErH61ukGKlioXgHWHwjMey8TGprz+CfSa2zBvr+4FJgXazuYLHz/j1jo
         wODcGqIefGT2t1uCsIxanE0GZM/YHIEFA+hYN9X+27/r18IkI4XBYJ1dIe5E+MKlytmZ
         1RkzVGnjrprwaQ2FFDT3+rKDklbFP3+b5l1cxw6c3ZTQjqeBeGsBFbwFGC8IBq8VQiOJ
         8gysB0vh5GFxE7Fr6A0ZKTd+fwAHMXETgeFvCF+0UOLX480xj/oVP4ulVsDpNdXS8f/h
         D+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493889; x=1703098689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZUzcUAYKJKCVreBhAC/gAbdLaRwduwq5l8nhnkZ9Qs=;
        b=BTBci8mT1tkE4aSRK4bryQf43m8zCkKBj2QvaD78zFRWjYhx1DLkusrc6tlrBUw32i
         QtnAcpCz8FM9V/FyQWsmNRYawQGCQ9QsWakGePPHlr40D+xjyPpI+k5kCGBisJzRiEan
         trTNfujiyLHcZ4umuEq2BxA+tURbLXXoNUXyYRJ6XvwKRSSnq/vdlFgA2zp6GPOmXQup
         A664Q3mufffjJ9yUD/D5kUpTs3DM8DOU5ea+aAAh8ugfz4HolDvsEiMnuU/yE1vRrMLc
         E8dxkpmwoFu8SmN3TYWM8DpypEjvxDqiT52I7RSw1I5FC7WiMsVskEjfujwG7sL+05ka
         WYAg==
X-Gm-Message-State: AOJu0YwLq7i5CRF0FUys8kOvSPXFnSgfB4tbv97fDVJmPv67ffJVj5Yd
        wSYAKNmhh/xiTiRw2rG7kq1vlw==
X-Google-Smtp-Source: AGHT+IFyyAwZxWhcdxaTGwmrqPBk0gEDkvIOCe1nLi88UcVTZe5H3wQnyG/s2PV/+lx0LJVv+t4q8w==
X-Received: by 2002:a05:6512:3608:b0:50d:12b4:e01e with SMTP id f8-20020a056512360800b0050d12b4e01emr3575281lfs.104.1702493888765;
        Wed, 13 Dec 2023 10:58:08 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651206c400b005009c4ba3f0sm1680336lff.72.2023.12.13.10.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:58:08 -0800 (PST)
Message-ID: <ac04f771-2cfd-461d-ba37-7348a62b92ba@linaro.org>
Date:   Wed, 13 Dec 2023 19:58:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY
 interrupts
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-3-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-3-johan+linaro@kernel.org>
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



On 12/13/23 18:34, Johan Hovold wrote:
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
> Fixes: 84ad9ac8d9ca ("arm64: dts: qcom: sdm845: fix USB wakeup interrupt types")
> Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
> Cc: stable@vger.kernel.org      # 4.20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches ds

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
