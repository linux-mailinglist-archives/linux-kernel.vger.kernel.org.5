Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF5D7AF344
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjIZSti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjIZStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:49:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102A126
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:49:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so148754191fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695754166; x=1696358966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQEYrcp4hCId8DFy/OWciQ71/q8cTnKBaLY4kmvMAVA=;
        b=jsBQ7Pw+xhQZ9FRVLqYyoYvGVr1Uo8LpwC5WRPya/T59AcwcjOfs87wCNwJkl93vIj
         d5rYsW33y9vAo619S1Hurn8VlKf8B2kAWX/QnnTFcc1W7GYjaMwIyQClLUQV+m0S+Nk5
         u/usKqtHj6G0adbFEjKFBE7zFYnCTBMMZE2vdmlmgazbHzZsz0xJ9IdLi+WLhRup/Rl9
         64vhlABKrTnji0UZZfvrm7gZZYegk68Q1zsXvE2owcCOxoO80d9RXA7QAXwsLtXpbTKM
         KJFAaXsPFZjq0OOV2YY67/B/rftrH/kYMC0gteklwmpX1nU62Vv65XSWVXT28n5Nsf4Q
         c1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695754166; x=1696358966;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQEYrcp4hCId8DFy/OWciQ71/q8cTnKBaLY4kmvMAVA=;
        b=OYzqHpLDmY8axOosfqejKYH7MoXyqviXyIix9QCdW69kvN7/wWZtaBoByZXnNhKDP3
         PSQj72YDCcR1mKcgSl9bu6zP6Id6EF6cvVlvzDN6Hme7wwavnFDeYJ6Hqg94azFBSDe4
         oYlicQpCR+Cg85R6QgZrMhJqRjwfHJONGVHGMlywD/hmJfZUhLz4prnsWPjkb/RAhhPq
         qlXLCT4lsvgttt4quQjAGxpxCWgRzdcKRsUnkTJgVmHvj7ho61rEgynKOL2FkWXbYs6n
         5lPH4mWyrNidfRpA/vWCx+fj4Yr2dBsJp4Pvs9S9CT4Atd3QDIIxR7ebvIj1AR+t1iYR
         vEEg==
X-Gm-Message-State: AOJu0Yz1bD2gwMdXw0dbnwDCUHzUU+dvA2SsojZAJVy95YyfHT/T/lSD
        jK+8E95IiCcVlOJRFlTXGS8g9A==
X-Google-Smtp-Source: AGHT+IFHuUE/ejWsm/2gcvHsHlH8Oap8j5q7xrRfq5jU5rji7grAclPVJ2wHv6eoHUAAVtXsFEuVww==
X-Received: by 2002:a2e:87c8:0:b0:2bc:c21d:311f with SMTP id v8-20020a2e87c8000000b002bcc21d311fmr8723515ljj.52.1695754166496;
        Tue, 26 Sep 2023 11:49:26 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b009ad89697c86sm8184915ejb.144.2023.09.26.11.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 11:49:26 -0700 (PDT)
Message-ID: <45665b43-3be9-4f27-aa88-12cdef56346d@linaro.org>
Date:   Tue, 26 Sep 2023 20:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] arm64: dts: qcom: msm8916: Add common
 msm8916-modem-qdsp6.dtsi
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-3-398eec74bac9@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230926-msm8916-modem-v1-3-398eec74bac9@gerhold.net>
Content-Type: text/plain; charset=UTF-8
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

On 26.09.2023 18:51, Stephan Gerhold wrote:
> Most MSM8916/MSM8939 devices use very similar setups for the modem,
> because most of the device-specific details are abstracted by the modem
> firmware. There are several definitions (status switches, DAI links
> etc) that will be exactly the same for every board.
> 
> Introduce a common msm8916-modem-qdsp6.dtsi include that can be used to
> simplify enabling the modem for such devices. By default the
> digital/analog codec in the SoC/PMIC is used, but boards can define
> additional codecs using the templates for Secondary and Quaternary
> MI2S.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
I'd rather see at least one usage so that you aren't introducing
effectively non-compiled code..

>  arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi | 163 ++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi b/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi
> new file mode 100644
> index 000000000000..ddd74d428406
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * msm8916-modem-qdsp6.dtsi describes the typical modem setup on MSM8916 devices
> + * (or similar SoCs) with audio routed via the QDSP6 services provided by the
> + * modem firmware. The digital/analog codec in the SoC/PMIC is used by default,
> + * but boards can define additional codecs using the templates for Secondary and
> + * Quaternary MI2S.
> + */
> +
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +
> +&apr {
> +	status = "okay";
> +};
> +
> +&bam_dmux {
> +	status = "okay";
> +};
> +
> +&bam_dmux_dma {
> +	status = "okay";
> +};
> +
> +&lpass {
> +	status = "reserved"; /* Controlled by QDSP6 */
> +};
> +
> +&lpass_codec {
> +	status = "okay";
> +};
Any reason for it to stay disabled?

> +
> +&mba_mem {
> +	status = "okay";
> +};
> +
> +&mpss {
> +	status = "okay";
> +};
> +
> +&mpss_mem {
> +	status = "okay";
> +};
> +
> +&pm8916_codec {
> +	status = "okay";
> +};
Ditto

[...]

> +	multimedia1-dai-link {
> +		link-name = "MultiMedia1";
Newline before last property and subnodes, please

[...]

> +	sound_dai_secondary: mi2s-secondary-dai-link {
> +		link-name = "Secondary MI2S";
> +		status = "disabled"; /* Needs extra codec configuration */
Hmm.. Potential good user of /omit-if-no-ref/?

Konrad
