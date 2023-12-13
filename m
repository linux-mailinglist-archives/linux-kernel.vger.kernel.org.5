Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE5811DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjLMTA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379245AbjLMTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:00:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC69E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:00:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf32c0140so8299586e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702494028; x=1703098828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qK7Oyh72XFSFSL4xPkFqcCR8+DGBFGrbcMmMNxvkKPw=;
        b=ECfmI8sUg78xe6FINCnL/QtG2lG6omV10LmYW2AOdb01km5aL+xebUanY2y5xzjI56
         bRaX4LL8L/xGfobK+iZ96GwAodYZ++l5APN4+4JMHGmQLJJA1Fc/dpUl220CUnjvogRa
         mdjDzx5r3ltvrRju/GhW9l9+rEOl8xlicUOHPkoL/0+cuZk+zKm9TIMjsRk7PACBFxVq
         fnA1MSpaElJYs1MmOagrzs6oPizj2r7BJzoitUMS4dHb1GJTPALlNlxaeTHO6e+5Aizj
         po3T+QLiq5kIYkL7vWHgpRwlv8TswqK3vc2wBBbr8vZIE3d4OSfuB6i08aPozw/YCG3h
         affw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494028; x=1703098828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qK7Oyh72XFSFSL4xPkFqcCR8+DGBFGrbcMmMNxvkKPw=;
        b=DGsXZW8ucFtH6GZVSAZV7E6DuYoF0Y1gBNdlVj5MoUIEugGeroF7KhmhtinU/5xW+8
         lND0IVyzoOT7fqFLSO5Yn3F0mMG066/vCi/cUqU+E5FIxwY2nTTfU1vGFIbtNo5+ToQr
         OvsMPZK4B+w9ozpwYp0yPd976/vp4caCfReU78SLZJ1PPUhfZtJIstXU3rVJ3hQBdBC/
         ZJbs5fIKTjSgvWwB0gwOv8nkNLF3koZ4QjUOWb1huJt+F4CYY8GWt1XBeTXM+MqEa0GA
         LB+tUkdilh8+GJVzXjUWmP3qbu71i2KaxJYLcmCd4n9QbDSE+tk3pXziv7GCHBOdeYx9
         521A==
X-Gm-Message-State: AOJu0Yxhpi+4QeH1fyaGS3OiwR3Vy/PZKR7wpnGTgbBTGuS/eU5e8HRJ
        fiACFS9ZcGYIsRoCpC2HzCTeZQ==
X-Google-Smtp-Source: AGHT+IEjXurmiqb7G4f2AEjbM9CKTFKc2qPOfSmJeViFUwTe2NCpCJa8AveSRgjNSxmd4lBdmfAQEg==
X-Received: by 2002:ac2:597a:0:b0:50c:125:c6c3 with SMTP id h26-20020ac2597a000000b0050c0125c6c3mr3803080lfp.128.1702494028402;
        Wed, 13 Dec 2023 11:00:28 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651206c400b005009c4ba3f0sm1680336lff.72.2023.12.13.11.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 11:00:28 -0800 (PST)
Message-ID: <4ee3e8eb-de4f-4dba-8e66-966ba7692d83@linaro.org>
Date:   Wed, 13 Dec 2023 20:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8150: fix USB SS wakeup
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jack Pham <quic_jackp@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-6-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-6-johan+linaro@kernel.org>
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
> The USB SS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
> Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Jack Pham <quic_jackp@quicinc.com>
> Cc: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches ds

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
