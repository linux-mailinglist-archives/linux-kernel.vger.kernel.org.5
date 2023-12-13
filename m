Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13791811D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379130AbjLMSrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjLMSq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:46:58 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C9FF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:47:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bce78f145so8455715e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493222; x=1703098022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9pRN652Qjyr+bUpPGngJiTKRnZ3pLNOirbLUeYcKaE=;
        b=Vebi432vX0Le/x7Us8oanXhjU9Ua4FaNL0hDw0WBJ/PHuVqOr05mCJRNjQAstuN9k3
         4JuHcHTYkK55eDFYxo4DP2XGohm7BgoS2OJW2Sf5ad/Y+F5f6vFghid7dAzcw3DJDC01
         ww3VI8XIPuR/VEFkeRqh6Pa16dOmmDM/2dMM1+nglvk/13yq/5SLBcftCJlEbjWOnxBe
         3BgWK8XM/EZY9cWCeajfRdFlJruaC1qX+dIpdkTiu9quIdQe22dJ2DEq6qTaXEj3zvBE
         6M1m0eWhh1Pfdyhwqaf0lVQ1LAIFJvnEHLlgZ2j0tJ65kcyAoyHl1jn2Ht06nhixBAWJ
         XTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493222; x=1703098022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9pRN652Qjyr+bUpPGngJiTKRnZ3pLNOirbLUeYcKaE=;
        b=YaEbNa/fojqo5RBraFfc7Mkv26Y346XmxKlwVdBJCvmB3nB5r21whJq+7x/VGBEetd
         Fvoe9xgHWr+MhBSDLVOwPPIxO0Zv3iplA+hFrecxwlXl/81WAmRWfZJoRnCk3qnYDuGk
         IcL3oxz4Fn4ulUrklmHn6LKLF23YI1DTzzattdZw2Z0O8BGPUxPBthuwvPNen7YhhH4U
         w+ey4oqi4yLKFDXg+xF/K5YRW7vHIi3dp/xBNO+LulhR033P0fDGKoDA5vYwykUYV9YC
         BGJZbwU+YT45btQQG5hOYlFu4KBXWUhxdYXP0CwXbLRxuq/ydL6Vw0oAXvMycDxCAdhz
         dTXQ==
X-Gm-Message-State: AOJu0YzUTfY2OOtPvNq0rykhlUti9gxOfZ+dYAp+qEtRn07xYhj3MtkM
        gvVbMVE080DJenV2bhpyydj3Yw==
X-Google-Smtp-Source: AGHT+IGdLUVASkIbLTRMFB5Hpp0dA3qXNw+0b/Naa+lZJ8p5ZeeCweWZkm2OE49WwXdI3JyMdWp0rQ==
X-Received: by 2002:ac2:4a6e:0:b0:50b:f06b:7aff with SMTP id q14-20020ac24a6e000000b0050bf06b7affmr1685913lfp.233.1702493222048;
        Wed, 13 Dec 2023 10:47:02 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f12-20020a19ae0c000000b0050bdf00f688sm1653687lfc.299.2023.12.13.10.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:47:01 -0800 (PST)
Message-ID: <b319bae5-1253-471f-a022-4d1d2425e213@linaro.org>
Date:   Wed, 13 Dec 2023 19:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: qcom: sdx55: fix USB SS wakeup
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
 <20231213173131.29436-4-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173131.29436-4-johan+linaro@kernel.org>
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
> The USB SS PHY interrupt needs to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
> Cc: stable@vger.kernel.org	# 5.12
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches the downstream kernel too (as it should!)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
