Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE83D789674
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjHZMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjHZMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:03:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B532C3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:03:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff93a7f230so2097276e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693051423; x=1693656223;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SG+FRA6Jdj7lloQ4CW4VDp8In+rYXljtoh+/xtNc81Q=;
        b=AQjawv90XA6JscmYjGQ/4tY5fCDVRZdeTNh/TCIRnz/SMgswAbboswgnPhjXOvG1Au
         mZUUf19xCG/1sL76eWHX7H4MUsI3KGYz7IwEIQNN7eP2vb3KHivEQh9JVU4hNpnvwDMV
         Pft/TwotggUNwbMpPPkB8EDPwmuBc6Y/sXtLX6DOxuJPyxP0Y6e2TJpdw53GxFWy+y45
         Egxa8Phc32xAJM5m8zSTqzHlAYw4vseLbMlTG60U8Yt+VqegzyEEyqYj1OA00Hnjnmy+
         9xwOnb21zBfGemIbtRw/HZgBjweZq61JjNicpGQlgrwSxpG9km2a/dyVa2aUTlCgmmpY
         /0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693051423; x=1693656223;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SG+FRA6Jdj7lloQ4CW4VDp8In+rYXljtoh+/xtNc81Q=;
        b=Xoa1NaK4vBvvh7VFC4BhIO/iLh791YSC6lXXJIkULcJeC97JJREzb/pAR2vdGga5Cz
         hMmZeCMIDKdYm4K+gPQuwilOUXoMzx1vMT0ZhoeZQkkqJcif0hdNDG0MyJAi0oiagxq/
         EoKo2+n4Ft8K4ZhtrZ5yAvWmu83peMCShbWmIYy2ZGIBZ2jSOZerpvigCFOLHt5McxiH
         PdISXGAyEOOgcUkUEsl+Fv1TE6c8RtOuintP+VErn03sPW9qLz+qOY2mIvt8ROmW8K3O
         vgjSZ2CbNaI1AL9Fh2olAqbMe0EKeFaCK77njSGAsQ8FQxwP2AtpEwMubkAwQs3nvaer
         MGLg==
X-Gm-Message-State: AOJu0Yx8C/mLOirqy2e8qNB56Ghn898bPb/VpvQ+uRxZ5Ova94IfiHio
        OWRJ2Td66gr4vcSv7busgQ2BLg==
X-Google-Smtp-Source: AGHT+IFpvXi4fjnNXJ2u7zaCwDs8iSYEeMB5aZQE3cjcHpzGBtrCL/j3jjyZohowM9qd1n8rJPG8YA==
X-Received: by 2002:a05:6512:6cb:b0:4f8:4b19:9533 with SMTP id u11-20020a05651206cb00b004f84b199533mr8533138lff.19.1693051423583;
        Sat, 26 Aug 2023 05:03:43 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id f17-20020ac25331000000b00500a2091e2bsm689347lfh.99.2023.08.26.05.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 05:03:43 -0700 (PDT)
Message-ID: <024ded8e-d6b9-45dd-9633-03daa403f125@linaro.org>
Date:   Sat, 26 Aug 2023 14:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: dts: qcom-msm8916-samsung-fortuna: Include
 dts from arm64
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Gareth Peoples <mail@gpeopl.es>
References: <20230801111745.4629-1-linmengbo0689@protonmail.com>
 <20230801112134.4689-1-linmengbo0689@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230801112134.4689-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.08.2023 13:22, Lin, Meng-Bo wrote:
> After adding all necessary support for MSM8916 SMP/cpuidle without PSCI
> on ARM32, build fortunaltezt and heatqlte device trees from the arm64
> tree together with the ARM32 include to allow booting this device on ARM32.
> 
> The approach to include device tree files from other architectures is
> inspired from e.g. the Raspberry Pi (bcm2711-rpi-4-b.dts) where this is
> used to build the device tree for both ARM32 and ARM64.
> 
> [Add workaround to TSENS problem]
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> [Add heatqlte]
> Co-developed-by: Gareth Peoples <mail@gpeopl.es>
> Signed-off-by: Gareth Peoples <mail@gpeopl.es>
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts | 8 ++++++++
>  arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts     | 8 ++++++++
>  arch/arm/boot/dts/qcom/Makefile                         | 2 ++
>  3 files changed, 18 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
>  create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts b/arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
> new file mode 100644
> index 000000000000..b9704fea7029
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "arm64/qcom/msm8916-samsung-fortunaltezt.dts"
> +#include "qcom-msm8916-smp.dtsi"
> +
> +&tsens {
> +	/* FIXME: The device crashes when accessing the SROT region for some reason */
> +	status = "disabled";
All of SROT, or just e.g. TSENS_EN?

If only the headswitch is inaccessible, you may still reach
the hardware if it's been turned on from bl

Konrad
