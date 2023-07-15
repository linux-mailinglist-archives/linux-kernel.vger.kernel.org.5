Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0512754975
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGOOpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGOOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:45:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FAC358E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:45:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so4788368e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689432337; x=1692024337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FOfYfbk/qCVZ1VkYMAOOPhuGDuRElAU4iZk4P8UMU4=;
        b=hfxyt90aNzh5YJs97WBl4S5IeN1gI13sI0+HBFTi9VuMHUW53kWRJSsJ1Jhlffp2e0
         YvZDMNUY0iGu6RhJ3OzXvzONYP5Ll6a/jxtVocrXhZmz9iAwwQ2XzG2jVFpV+BfWS7dp
         pNmEUl0VKLodPQjvXtV7yD5XDVuo33BAEJtpxJEYXYbTfXLtPWpiE7aTc4jF5Ul/dc4y
         8f1//okI0DrY+mtf/dWUnMYMrt2+L6zpFSBp+JuQ4xUePf81DuBkwg+03mmoqeHTaG+0
         bCt2FQCszVmwkDyLDoJt0aRwlz9rJoT5InQxR+qCW6xXfiriF6iuR9gYsEogs/ZZddR5
         rt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689432337; x=1692024337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FOfYfbk/qCVZ1VkYMAOOPhuGDuRElAU4iZk4P8UMU4=;
        b=OWxlor3TAtNIlLwuKo+5lnn3/dXEUcG4ZQMzOtrEwTLzuRzxkjtzULzYsDhqXnmQBX
         WjD+tmIdeQMIAQNKd+SPaY/eNtpe5+ztBqSLuekZFBTfmxQH7vuOYXhVe8jYS36y/u81
         y1i3diwrBsj1u34T57Lfn7pQ124lQdaO86OOBjQasntYOlNeKAww3/Otzs5vENhBDniI
         +WU4gkVC6FzfcM1tYoB3KvzO5n8NkS1YybTIbylbCbglkU30ffRp+V53BscdoDTnBf3I
         JOGkKXrshNscvAoK5cJfaJUGLR1/v5AADd8CUxvFMhGqmPcJR6bnvbVN+qUmYKEmJmN5
         wd5w==
X-Gm-Message-State: ABy/qLZweoRN9LnTpWJnMUi5fAD1CM48d0L2yuu/AcEksvLuS8J2MT8L
        Kqlg8hH3+ZkOlP+HmuaR9ZDjow==
X-Google-Smtp-Source: APBJJlGH9cnNjxjpGcB/dmGHalBMUDGR+m4U7zCJwJh+COL7emmPjB+fHPrNEytb21ccw9ywsbZ0xw==
X-Received: by 2002:a19:430e:0:b0:4f8:7503:2041 with SMTP id q14-20020a19430e000000b004f875032041mr4951712lfa.37.1689432337173;
        Sat, 15 Jul 2023 07:45:37 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id c5-20020ac244a5000000b004fbafd20b6dsm1896166lfm.225.2023.07.15.07.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:45:36 -0700 (PDT)
Message-ID: <4459e6b7-510a-0a41-2e94-6aee945aa0fa@linaro.org>
Date:   Sat, 15 Jul 2023 16:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 6/7] arm64: dts: qcom: Add SM7125 device tree
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
References: <20230715091932.161507-1-davidwronek@gmail.com>
 <20230715091932.161507-7-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230715091932.161507-7-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2023 11:16, David Wronek wrote:
> The Snapdragon 720G (sm7125) is software-wise very similar to the
> Snapdragon 7c with minor differences in clock speeds and as added here,
> it uses the Kryo 465 instead of Kryo 468.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm7125.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/qcom/sm7125.dtsi
> new file mode 100644
> index 000000000000..12dd72859a43
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include "sc7180.dtsi"
> +
> +/* SM7125 uses Kryo 465 instead of Kryo 468 */
> +&CPU0 { compatible = "qcom,kryo465"; };
> +&CPU1 { compatible = "qcom,kryo465"; };
> +&CPU2 { compatible = "qcom,kryo465"; };
> +&CPU3 { compatible = "qcom,kryo465"; };
> +&CPU4 { compatible = "qcom,kryo465"; };
> +&CPU5 { compatible = "qcom,kryo465"; };
> +&CPU6 { compatible = "qcom,kryo465"; };
> +&CPU7 { compatible = "qcom,kryo465"; };
