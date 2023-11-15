Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B88C7EC14A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjKOLdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKOLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:33:02 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0693109
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:32:58 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso92838091fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700047977; x=1700652777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiBw5jMG8U1ulMqGVWIaLS7ahy5r63yHp8YN9d29sao=;
        b=Tn6ClLaWdtI9Zoq4FUEJFNvp0PoIwuo46k5KCl+BFHeV/E0eC+RlLJSBAseuYx1RFk
         YmH3BFT+j70Q9z65Gb+rO48AU5sZ/nmyYMtptbru3FnuHUrjfE8/51W3TObq1wcoaosr
         3Bw23I2IXgq7j4vvOOGKwH2QMfdw70g17AVLw7LVecepS41iBAnQn+oVWJv87HbdYuoP
         6yW8ML7/Yh6sjljLegvTymZrP4ytnj+Btk36zdktq84dbh0yfWVR+KSqxS1X8SLBFl5r
         mVdSw3d4xuekIarZadbSlURgvySXeLVCRQubiU/p7WF7ozaV7GMd87kJ+aLZNdiYxsS5
         oL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700047977; x=1700652777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiBw5jMG8U1ulMqGVWIaLS7ahy5r63yHp8YN9d29sao=;
        b=embs9Lu5kad6eky+U/kzVAANgugtKgBZJj+LdOmN0Iln1V8TXu3mjiRDetgynw4PnS
         58ThnbGMEcG/8mFBleIHPIxotzGhdosqit/mnrI6ckfZdi0ncPF/TGOAxMnHF27D1DdW
         iCuvV+omN2IeqHLVcy1oJIHIkp3KM/kCMWh9HhHLw/TY1/CCA03RABnN3bdzKmGaHhVu
         5VwrdoNbSjSx7ABpfuGoMNIthNwVxbf2ZhHqyuawLCswd+bTUhYzEib6fx+V88/LvMhG
         inFsy2MCq371RlPtBeF8XrNQzwP17Ge6gGeIvUT4m7fa4Xn878Xhr6kdcYBr3kpLcMVZ
         FAXw==
X-Gm-Message-State: AOJu0YxVjjJq95ui8Mns7ykD6IXQY7uGUVVIM0bpc1fR5pXd2NPCxq0K
        n3XuMgungsgPK3LsHyh4x4pqZA==
X-Google-Smtp-Source: AGHT+IE0T3C1HyGXfX4+RejyzsU3q7ZVO8/zOHxu8BPFG40RyApPXuNL0DTaN2SAH+B1aLohPZycNA==
X-Received: by 2002:a05:651c:b2c:b0:2c6:ee73:a20e with SMTP id b44-20020a05651c0b2c00b002c6ee73a20emr4759513ljr.33.1700047976849;
        Wed, 15 Nov 2023 03:32:56 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d4b43000000b0032cc35c2ef7sm10311329wrs.29.2023.11.15.03.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 03:32:56 -0800 (PST)
Message-ID: <a3e35d3b-906a-4540-924c-0103cf32efa4@linaro.org>
Date:   Wed, 15 Nov 2023 11:32:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add QUP5 I2C node
To:     Legale Legale <legale.legale@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CACDmYyf4hxbuw+cpKqEDnqmHpS9yPXuE5MPD5_XZ3hjmYuViUQ@mail.gmail.com>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CACDmYyf4hxbuw+cpKqEDnqmHpS9yPXuE5MPD5_XZ3hjmYuViUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 09:55, Legale Legale wrote:
> Add node to support this bus inside of IPQ6018.
> For example, this bus is used to work with the
> voltage regulator (mp5496) on the Yuncore AX840 wireless AP.
> 
> Signed-off-by: Isaev Ruslan <legale.legale@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index e59b9df96c7e..745bfc6e2907 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -507,6 +507,21 @@ blsp1_i2c3: i2c@78b7000 {
>                          status = "disabled";
>                  };
> 
> +               blsp1_i2c6: i2c@78ba000 {
> +                       compatible = "qcom,i2c-qup-v2.2.1";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x078ba000 0x600>;

reg = <0x0 0x078ba000 0x0 0x600>;
like the other regs here

> +                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
> +                                <&gcc GCC_BLSP1_AHB_CLK>;
> +                       clock-names = "core", "iface";
> +                       clock-frequency = <100000>;

Why not <400000>; as with other nodes ?

> +                       dmas = <&blsp_dma 22>, <&blsp_dma 23>;
> +                       dma-names = "tx", "rx";
> +                       status = "disabled";
> +               };
> +
>                  qpic_bam: dma-controller@7984000 {
>                          compatible = "qcom,bam-v1.7.0";
>                          reg = <0x0 0x07984000 0x0 0x1a000>;
> --
> 2.42.0
> 

What tree does this apply to ?

git checkout -b linux-next-6.7-rc1 v6.7-rc1
Switched to a new branch 'linux-next-6.7-rc1'

deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ b4 shazam 
CACDmYyf4hxbuw+cpKqEDnqmHpS9yPXuE5MPD5_XZ3hjmYuViUQ@mail.gmail.com

Grabbing thread from 
lore.kernel.org/all/CACDmYyf4hxbuw%2BcpKqEDnqmHpS9yPXuE5MPD5_XZ3hjmYuViUQ@mail.gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
   [PATCH] arm64: dts: qcom: ipq6018: add QUP5 I2C node
   ---
   NOTE: install dkimpy for DKIM signature verification
---
Total patches: 1
---
Applying: arm64: dts: qcom: ipq6018: add QUP5 I2C node
Patch failed at 0001 arm64: dts: qcom: ipq6018: add QUP5 I2C node
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: git diff header lacks filename information when removing 1 
leading pathname component (line 6)
hint: Use 'git am --show-current-patch=diff' to see the failed patch

---
bod
