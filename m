Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC83C7D6631
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjJYJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjJYJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:03:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3218C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:03:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a3b8b113so8096814e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698224629; x=1698829429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZpee9VfxFygXieiTrRxGKcCY4Qdy7akaIdL1nDHV4s=;
        b=NFH7AoDd13vu7lbvHt6FwUd6bs2paTFs3Nqw4jMqKtPdAjxEna4MsqbiB0gjPJxVqd
         eBce594IcPt5Ot5FJV9mzS0B4LDfzU9SUKmTbb5wSeJr9QG4uGZmdcUu3zRo604qsJJs
         5ymmv8wU9SX+jupV39M4+9fXpdZtvXS84/4qkK5dR97WWukSiommaUFxp0XjOD8KragU
         ej/WAJNhxVukNRHM2YmGpmj+/+L2DODD3DfmrNipKVzr1xzvw76DpBzDYu3xQ4VjkI8u
         8ZxG1HGb1ciUdq+qG/m8v6hj9Ps7X35Nm4F8gRbrXRQAKLRQrsJNnQkzUEC2jPH80F6D
         1gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224629; x=1698829429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZpee9VfxFygXieiTrRxGKcCY4Qdy7akaIdL1nDHV4s=;
        b=w+M4oK0eZEgW7dnFWNNGOPgxdFgBJzRit1uRC/Zrv0r3c0QC7WYL2kD7NvmY2yOSpb
         8/MCHLarFvkj0Kn6H66Dh8BxTz6T2BM7+XuH/DPsADGc+MyX0Khjc5imUlSMFSpKYgN0
         dv1FGU82mqTKMLZupD2RoiSVeMyzqBTPUo3OOuJcz/obE1VsI0z5neYKjdOqfZl9t4Cm
         JQPfXTPI7SbimQPYCBtbgjbEGJdCcIZ2v6PFJrzyH+73a+mSFKgMsmNNjdFj1DG27nS3
         xCYklbO7rZ5riNtNudrdxKvrNl+dB8Lw+sXlDy9a0GY1rd96ehZbwawy6tEQpn54UG5z
         DR3g==
X-Gm-Message-State: AOJu0YzvgwGtznasToWJH4PDvzG0XyOXo9hjNgterZIYVNDIFo+knwf2
        /wJtekqC0qVvKF7bszjMB/Uf4w==
X-Google-Smtp-Source: AGHT+IGhJNzRWN1tVv70tX0xY2HM1uNCTRLdIW3bYkvAmk1QADY4iqMKu7jd0F0f01uyUgeyB8vHWA==
X-Received: by 2002:ac2:4988:0:b0:502:fdca:2eaa with SMTP id f8-20020ac24988000000b00502fdca2eaamr10324020lfl.52.1698224628835;
        Wed, 25 Oct 2023 02:03:48 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k10-20020ac257ca000000b005079ab8ab19sm2458305lfo.150.2023.10.25.02.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 02:03:48 -0700 (PDT)
Message-ID: <22f173a0-b9a0-4749-b4d7-b5d0f6043a6c@linaro.org>
Date:   Wed, 25 Oct 2023 11:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/8] arm64: dts: qcom: sm8650: add initial SM8650 QRD
 dts
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
 <20231025-topic-sm8650-upstream-dt-v1-5-a821712af62f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-dt-v1-5-a821712af62f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:47, Neil Armstrong wrote:
> Add initial QRD (Qualcomm Reference Device) DT, it supports
> boot to shell with buttons, leds and USB peripheral.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
