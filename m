Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9356B768A75
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGaDwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGaDwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:52:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC05E7F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 20:52:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso6406266e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690775540; x=1691380340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bg6pPDD7D9Uau9cvtSERX8kub5e1y1Iop71YmJr52mE=;
        b=fcpK32Vw4M/g85/TRturThxXpLIIXoyoHnhV/UDSbmdZ69VaDyJPwm4dy8A+XXhgIP
         /omtP3zw5o3UTEQJs017wcphcO4jx3meEYtY/1AuQW+Q9oXkJmkMWcSUThEriWiB/+16
         1O2wEf832CONvwkzmj9Y+hAmnOg0mpY0FTCGp3G3HMPb0t4Pq6fnV3hnydMI9lvzgsT3
         6MhiNRkaNm4zvRHUwvQNsMMIN+Kkao+5FZdq4N3cS9jXixytN1dpc4+VfXf209QrT/F4
         XBBkkLIhmqlYNXa3/Jzs/kcgNZluWmm6jMWGBh4MtxdeqtpiHU9N4qekjmFsZcp3Eswt
         WwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690775540; x=1691380340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bg6pPDD7D9Uau9cvtSERX8kub5e1y1Iop71YmJr52mE=;
        b=gAsHltfOIf0x2u3+MDRfOfW41F3qtGW1KuRHs4ya9pjV6Bp8dhN5WmAPIvGh1cNX55
         cwNmbXZxo94aJ6voGMMvSMeILn+ozHjsp+H5w+tcnHf3oVMqqbqbFdX50e38S34tcj1G
         VC4ZLspCtJkNEg83gZhMA2EJnTZ9GYHgvoS0ReokLY5mEBrclL08ZADqvFksQfXH18lF
         MIxF9mf6g7upxM3wYfeUR9o3eWpbayeUHequ87/QhTThUydNpzORRcuVT1KgVYXE/WJa
         dLxBw3z8UpkZSCXHjHUH68ezHXY2vg3tSNUje0oUWqpIsn/wM+Bx5n9OlNkgMmhbS2v3
         wPng==
X-Gm-Message-State: ABy/qLbk9fF23bPyf+EC+W9pt4O1nyqKqXKn4g1mkyVJlcxLrg5+nvGZ
        QnTZYzHhC92REumB1lOEEBtKmA==
X-Google-Smtp-Source: APBJJlGfM1/1VlzDywOVjeNKJ+hEnS5T/exeZtOlifNZHG2W38TLm/a3R3xMtsWj5R9H7RZ7QHuWEQ==
X-Received: by 2002:a05:6512:ad5:b0:4fd:c923:db5e with SMTP id n21-20020a0565120ad500b004fdc923db5emr6020928lfu.21.1690775540485;
        Sun, 30 Jul 2023 20:52:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f4-20020ac251a4000000b004eb0c51780bsm1901005lfk.29.2023.07.30.20.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 20:52:20 -0700 (PDT)
Message-ID: <77538959-595b-508d-0144-35d56ab5c7d8@linaro.org>
Date:   Mon, 31 Jul 2023 06:52:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: Use labels with generic node
 names for ADC channels
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230730-generic-adc-channels-v5-0-e6c69bda8034@somainline.org>
 <20230730-generic-adc-channels-v5-2-e6c69bda8034@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230730-generic-adc-channels-v5-2-e6c69bda8034@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 30/07/2023 23:31, Marijn Suijten wrote:
> As discussed in [1] it is more convenient to use a generic `channel`
> node name for ADC channels while storing a friendly - board-specific
> instead of PMIC-specific - name in the label, if/when desired to
> overwrite the channel description already contained (but previously
> unused) in the driver [2].  Follow up on the dt-bindings' `channel` node
> name requirement, and instead provide this (sometimes per-board) channel
> description through a label property.
> 
> Also remove all the unused label references (not to be confused with
> label properties) from pm660, pmp8074 and pms405.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> 
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   arch/arm64/boot/dts/qcom/pm6125.dtsi               | 18 ++++++----
>   arch/arm64/boot/dts/qcom/pm6150.dtsi               |  2 +-
>   arch/arm64/boot/dts/qcom/pm6150l.dtsi              |  8 ++---
>   arch/arm64/boot/dts/qcom/pm660.dtsi                | 33 ++++++++++++------
>   arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 24 ++++++-------
>   arch/arm64/boot/dts/qcom/pm8150.dtsi               |  6 ++--
>   arch/arm64/boot/dts/qcom/pm8150b.dtsi              |  8 ++---
>   arch/arm64/boot/dts/qcom/pm8150l.dtsi              |  6 ++--
>   arch/arm64/boot/dts/qcom/pm8916.dtsi               | 14 ++++----
>   arch/arm64/boot/dts/qcom/pm8950.dtsi               | 39 ++++++++++++++--------
>   arch/arm64/boot/dts/qcom/pm8953.dtsi               | 12 +++----
>   arch/arm64/boot/dts/qcom/pm8994.dtsi               | 12 +++----
>   arch/arm64/boot/dts/qcom/pm8998.dtsi               |  2 +-
>   arch/arm64/boot/dts/qcom/pmi8950.dtsi              | 12 +++----
>   arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi          |  6 ++--
>   arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi          |  6 ++--
>   arch/arm64/boot/dts/qcom/pmp8074.dtsi              | 27 ++++++++++-----
>   arch/arm64/boot/dts/qcom/pms405.dtsi               | 21 ++++++++----
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           | 15 ++++++---
>   .../boot/dts/qcom/sc7180-trogdor-coachz-r1.dts     |  4 +--
>   .../arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |  3 +-
>   .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 +-
>   arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi |  2 +-
>   .../boot/dts/qcom/sc7180-trogdor-pompom-r1.dts     |  2 +-
>   .../boot/dts/qcom/sc7180-trogdor-pompom-r2.dts     |  2 +-
>   .../arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |  3 +-
>   .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 +-
>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  3 +-
>   arch/arm64/boot/dts/qcom/sc7280-idp.dts            |  2 +-
>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  2 +-
>   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |  4 +--
>   .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 26 +++++++--------
>   arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         | 10 +++---
>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 12 +++----
>   .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   | 15 ++++++---
>   arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |  6 ++--
>   arch/arm64/boot/dts/qcom/sm8250-mtp.dts            | 21 ++++++++----
>   37 files changed, 231 insertions(+), 163 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

