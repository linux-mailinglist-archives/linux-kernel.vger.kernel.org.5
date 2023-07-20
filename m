Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E575AA68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGTJOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjGTJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:06:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C75C44AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:57:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so7213961fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689843419; x=1692435419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuBtnBic7enS4cLJ/qv3iEzDo3EKyWHxfta/cthROig=;
        b=O1xSm+jWlv79kxy7XJWRWxGA/a0JrBbFOIigfcQnue0j3dBrF9jCxC05ekbDXDY5u7
         1qstxE2gzeqTZdnc5U4BMGltOzul/qQdfOL2apdmEKuQVulrjoAyBVBfwurrC8GHeFPx
         wSu3TIrBZFhgLdwmONT1rOL+wE4uDDha2LCybiHjvo3ifc7z99Qr8QNvgjZTqxnpYNr9
         0jo5lMejdXZ6UMF0MeurfBH/O9PIwhUpsXO+wIIAdOQ0ZLefAayn54B/BzDVOq9v7n9e
         0f3nqUkO8z4oXGCVs6AhDOyiiN/Kyere4cPhpBQ8vQgvmuMdMRBOPxhaQ9w3EPGCSKUh
         wGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843419; x=1692435419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuBtnBic7enS4cLJ/qv3iEzDo3EKyWHxfta/cthROig=;
        b=B/43KlGaV3lf8DKvy8rNW1THpJWTPWI5JP/XdNXWUjVrPQ+ucm/zGFH5sVuagiFIDQ
         NMu3LgctgfQ6xstoEsGipq4AZU1kzyQdcMY42Re6ISbkM5P6H5jIA2ex38mhnS7BGDTw
         k1BKxjtAhlICQDH3Ga2pFQN89SwSGxgqk8/ahqozzzBwRihA08vPk1FwOawfA5vyn/OQ
         8CbI3G8nB0YDRrTuglHtqk5q42SkH+wVEXcsMO4ojlXt23Dghm96Qb0gXQ4JvSUF6EoQ
         MORCzNVIKLILJmWT6IilglIoFUSbXyd/Pfm/oCIdMYRjFZax722RjRsKQqBTymdwGJGl
         xP6Q==
X-Gm-Message-State: ABy/qLbC4D+xMykxL2kmh0XCOHNcE7reM1Ux13gqE4pbed+oI/hZkV3/
        hZUe5P21+WW2861ORWG4tcLsRg==
X-Google-Smtp-Source: APBJJlGXW5kVbKoCJ8kQrakz+RYqHiDbkxdql8z6yYJGcvbpP1eL1k2a5ki+JQQgjhbyf+aVm6oF2A==
X-Received: by 2002:a2e:9316:0:b0:2b9:55c9:c228 with SMTP id e22-20020a2e9316000000b002b955c9c228mr1325317ljh.27.1689843418974;
        Thu, 20 Jul 2023 01:56:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003fc0505be19sm638037wmc.37.2023.07.20.01.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:56:58 -0700 (PDT)
Message-ID: <af890343-824c-7b68-ba27-dbaa4fa5b863@linaro.org>
Date:   Thu, 20 Jul 2023 10:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: add support for the RDP415
 variant
Content-Language: en-US
To:     Hariharan K <quic_harihk@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230720074846.20350-1-quic_harihk@quicinc.com>
 <20230720074846.20350-3-quic_harihk@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720074846.20350-3-quic_harihk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 09:48, Hariharan K wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 415 based on IPQ5018 family of SoC. This patch
> carries the support for Console UART and eMMC.
> 
> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |  1 +
>  arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts | 49 +++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 6334e552b7c1..53df7f24488a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp415.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts
> new file mode 100644
> index 000000000000..5c4b43f76a48
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * IPQ5018 MP03.3-C2 board device tree source
> + * Copyright (c) 2023, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5018-rdp-common.dtsi"

I don't understand this. You just added in in the same moment in
different patchset, so why creating this fake dependency?

It makes review difficult, applying even more.

Please organize your patches in some logical work.

Best regards,
Krzysztof

