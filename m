Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F193B7BC103
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjJFVPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjJFVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:15:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13FFBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:15:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b2cee55056so481489866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696626942; x=1697231742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pguxjsrE6r696sdJh+EBa8vjPrUgEjJuICEkTOaYc5c=;
        b=BlFg37eXaJ4W3JAHhpCGjwGrbrwoLLDh9/StfM/F3xTopS/wFXVjsKk1JDuwVzh4EX
         GDViO64VGtVvq0LJK3619+U8gybsdmAu/z3whOb42AP3o6IQNYpyn65ZWkcherpRCUrK
         FtZkrkajJeVOQsgjr5HDecIALplDklYgWyQLE9xJo8Q6fyw+xpXuSoArz6dgG97bk9KH
         HRfMgDByyJ2Lg8YxceACQMDM2KtW06kEnYcdNKIb9WO4YfN1kirPIbJt4yDRR/mNiuHZ
         24YNEgHcsnIxm6+WuABoH3X/22GFk+O9BxfQ61mI3G6FT8fTdq2dJ6nTayD2qQHhfk/8
         2LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696626942; x=1697231742;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pguxjsrE6r696sdJh+EBa8vjPrUgEjJuICEkTOaYc5c=;
        b=W/Sy1jhSs/WagcKtj2t4gfRwTfeeHhQbYfIrXwcyXE3s4pmxrYxdKQoJu+QhQBqPE3
         FD+5Me3vWv8amSVW+D+ogQeweubZD2xVXJ6m3imXZcmpHc8rOWfKQ640TFxkwv3ORK1Z
         7JPdFUGScpPT5Nn5XMm4KuKNY+EGPMzrKX2xWmT7kEhiUtfcQGVj5vPA1MbNN6o3xpDX
         6Ebtve/0pI7LhIV+r2LoXaHUD+5y5TRa+GX89CUO8et4lP1bpJnFZsI6NWtynhorHKoJ
         y/jURrZm8xBB0NKYV5zI9nNPHK1TVMSMj3D/vy+gRWIF7zvUD9EV533JTNtDmwUBTiEK
         dZzw==
X-Gm-Message-State: AOJu0YzZkc/A0tjbHg4Ca4YbtuOcScU9qRoYgIqsxdmSFdlAqc8htXVA
        d076EtCJ4AsUtPnkw5nBnu+SRpIZH2G6vQJRNdU=
X-Google-Smtp-Source: AGHT+IHUo9wMeHL6vBi7PW9BifONMemPhh1IyuNZLiN170MfDjC4smWxHLZyGtiOcXlO6nb1TCoNFw==
X-Received: by 2002:a17:906:73d8:b0:9ae:53af:c57f with SMTP id n24-20020a17090673d800b009ae53afc57fmr9471702ejl.65.1696626942359;
        Fri, 06 Oct 2023 14:15:42 -0700 (PDT)
Received: from [192.168.200.140] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id ca9-20020a170906a3c900b009ae587ce128sm3414983ejb.216.2023.10.06.14.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:15:41 -0700 (PDT)
Message-ID: <9b7744bf-d42c-4922-85e8-ca4777f313a7@linaro.org>
Date:   Fri, 6 Oct 2023 23:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] regulator: qcom_smd: Disable unused regulators
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-2-5d682493d555@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231004-reg-smd-unused-v1-2-5d682493d555@kernkonzept.com>
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

On 4.10.2023 16:17, Stephan Gerhold wrote:
> The RPM firmware on Qualcomm platforms does not provide a way to check
> if a regulator is on during boot using the SMD interface. If the
> regulators are already on during boot and Linux does not make use of
> them they will currently stay enabled forever. The regulator core does
> not know these regulators are on and cannot clean them up together with
> the other unused regulators.
> 
> Fix this by setting the initial enable state to -EINVAL similar to
> qcom-rpmh-regulator.c. The regulator core will then also explicitly
> disable all unused regulators with unknown status.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
> NOTE: This has a slight potential of breaking boards that rely on having
> unused regulators permanently enabled (without regulator-always-on).
> However, this is always a mistake in the device tree so it's probably
> better to risk some breakage now, add the missing regulators and avoid
> this problem for all future boards.
> ---
>  drivers/regulator/qcom_smd-regulator.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index f53ada076252..0bbfba2e17ff 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -53,14 +53,14 @@ static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
>  		reqlen++;
>  	}
>  
> -	if (vreg->uv_updated && vreg->is_enabled) {
> +	if (vreg->uv_updated && vreg->is_enabled > 0) {
At a quick glance, are there any states for this value, other
than 0 and 1? This is not the regulator_ops->is_enabled, but
qcom_rpm_reg->is_enabled.

Konrad
