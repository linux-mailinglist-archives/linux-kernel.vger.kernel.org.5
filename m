Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63279CC98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjILJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjILJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:59:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E136E64
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:59:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso6939810a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694512791; x=1695117591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9db736AwIc3y5X7aRFDi4+AudPpdl9kT0DNyx9Wiwg=;
        b=A6ModrhEWfafo5DnMczP2FII0DhFw2MR32t3ya4igDZ/KiZzro5Kh5DVxaybESMSy5
         78bk8rFv8RnQZNVpS+767mztVi1AUVQC55AAuThYd96MXxElzUhTXUi/Dd2tHH3oBe6X
         PHHOuFqbCRWjzRRvZC9O2oB4tSQauidh5OmmYOt1+VrR0B/qGzly06L6ftraFfObwPqv
         9YzNgm/O9OnQi7yvcxwF9+VKBIOIqMsOQOglB1WAbyNXN1x0hyGXqJCUWgpj6siCN0Sc
         A1oWU6g0PQsTnXnuhZo4GbGp84bXzyN/HJD4tJd7KB/Kk/L/3QlSzfKgDXdIM32rIOKK
         cy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694512791; x=1695117591;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9db736AwIc3y5X7aRFDi4+AudPpdl9kT0DNyx9Wiwg=;
        b=e6kX2Q7O5p2OFvxYehrW+9kdrJyqNnWz/6nZ6IKPSyTKrW3XZtxXxtfo+iHAuju9mG
         QKrVS/fNyY8uCDSAJMVT3nc+CFF2mpVE1UttG8iIg0Yyw0zkFXOsLOw5F2xq3ZX19eL4
         jcyoo7bS4ecvf3dTCCiACbWqYgTztynDsL5rrlkOXMLCo2bp1gig/y6jb5kj1nILZqHI
         /yhRs7drAeGhFKmd93MuXoifTJbbZjktHAwzDooJneitzGqyB36uwI2UUEPrLCPN8UH7
         4wqnqFoJpD+OMztKDRm8kNGEQ322hWbAtp9q8WJR8rNN9yTeP/6clQrshkAkgS5kgXQj
         7zLQ==
X-Gm-Message-State: AOJu0YwRdIDykVk++xSdlyQGHFE0Iz7QnLCEZxJp0aAVxUw2FZ8MDHmk
        q8KCejjeJxTfdNHrGXj6To48dQ==
X-Google-Smtp-Source: AGHT+IF1W1mCbeEdB/+oIAsQVpIU5kfWK9oL9G463Pg4CGhj38vxyHBcc5tm+FG6RDVWRKQ+DuRINA==
X-Received: by 2002:a05:6402:2cb:b0:52e:5f85:b692 with SMTP id b11-20020a05640202cb00b0052e5f85b692mr7948124edx.42.1694512790724;
        Tue, 12 Sep 2023 02:59:50 -0700 (PDT)
Received: from [192.168.37.85] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id w15-20020a50fa8f000000b005272523b162sm5680498edr.69.2023.09.12.02.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 02:59:50 -0700 (PDT)
Message-ID: <5336dac4-af3f-46f7-bcf9-40314f744c8c@linaro.org>
Date:   Tue, 12 Sep 2023 11:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: Add MSM8909
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-4-767ce66b544b@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230912-msm8909-cpufreq-v1-4-767ce66b544b@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.2023 11:40, Stephan Gerhold wrote:
> When the MSM8909 SoC is used together with the PM8909 PMIC the primary
> power supply for the CPU (VDD_APC) is shared with other components to
> the SoC, namely the VDD_CX power domain typically supplied by the PM8909
> S1 regulator. This means that all votes for necessary performance states
> go via the RPM firmware which collects the requirements from all the
> processors in the SoC. The RPM firmware then chooses the actual voltage
> based on the performance states ("corners"), depending on calibration
> values in the NVMEM and other factors.
> 
> The MSM8909 SoC is also sometimes used with the PM8916 or PM660 PMIC.
> In that case there is a dedicated regulator connected to VDD_APC and
> Linux is responsible to do adaptive voltage scaling using CPR (similar
> to the existing code for QCS404).
> 
> This difference can be described in the device tree, by either assigning
> the CPU a power domain from RPMPD or from the CPR driver.
> 
> To describe this in a more generic way, use "apc" as power domain name
> instead of "cpr". From the Linux point of view there is no CPR involved
> when MSM8909 is used together with PM8909.
Without checking, I have a vague recollection of CPR output also
being called VDD_APCx, so it's a-ok

> 
> Also add a simple function that reads the speedbin from a NVMEM cell
> and sets it as-is for opp-supported-hw. The actual bit position can be
> described in the device tree without additional driver changes.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

One nit below:

[...]

>  static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
> +	{ .compatible = "qcom,msm8909", .data = &match_data_msm8909 },
>  	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
msm8909 should come after apq8096 (even if adding apq and not msm was
a mistake)

Konrad
