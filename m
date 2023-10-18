Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA77CD6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjJRImo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjJRImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:42:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580910C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:42:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5079f6efd64so5652922e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697618553; x=1698223353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10OPZdJIcf5hY7AybgtKFxG5/1fKjVZqhVfHIM6Owj0=;
        b=G3dIm7GgQe3RDGlGZV2uC3gzmTzERaGJWJbaudmttFWgEZXAFmjNkSelTEgesRMqui
         FI0JPsBYqCl41STWrarBOQQCLpUHS/ft3nmXZphTjICGoX7Ex2AyOaiV3zx8OAOaBL+0
         6buI6Kul9ZJaeWMAQElU5dODdLpnWfnZyohElywlvLLhT51RsQ3RSSPWRi8/MYDpRgoc
         7eENPYu/b+WwJuobCPO763YaeotoTW4sOgFbeiVT0J8UQtmlNio6qkVuq1zjxmIV5Z5p
         vaVyOF8dDRoh5P74shcbmwHUX7nK/kNyHXj4JEQqRWrXCHInpFmqhQw2mOvHcUSssypW
         50dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618553; x=1698223353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10OPZdJIcf5hY7AybgtKFxG5/1fKjVZqhVfHIM6Owj0=;
        b=kSzjFTzSWZHqDySvDE83TJOq8SY49EadOkn/Wr65afJC11xY7Vh7h10iytrqiVzJjX
         loHm+ClLgdFATIaMGxi0IyfAL5CgQF3+GjFqppPv0D/XGlGB99i8jUMFE+cjHvlHgUwp
         UgcdDV7grZOqa+yAYIq8YqvDFRFdRxW3U5ch7CsrVL8XbNkMpcWHLmybNppH4beaKBYm
         fEuwmGW1gsefn2A1gcKIu8/nM88aBuINJn/XBVRfm4hYmO0HkJj65fjk0j3ukkm5AA6g
         wgAuoBnLV3F4+bzoxrzkV+x+HLXpuun5NO6BdQdP77BbbzqU82D2s968tx/rmh4XDWXx
         Hm7w==
X-Gm-Message-State: AOJu0YwpzfrpdakBpWWTefVfBM7QD+8VYv5TSAWJaMz9aWp6CMYp7E66
        7DY0OyAhEJhkEoLx8Ip8WaypTQ==
X-Google-Smtp-Source: AGHT+IEUfEjyjF0/7VMofGB08Y2b4pWlSpDzjdx6yvCvv2fAVYgWc5f8uuUJWLrh1OSXFGQKd0Bb3w==
X-Received: by 2002:ac2:4da3:0:b0:503:3816:c42c with SMTP id h3-20020ac24da3000000b005033816c42cmr3050148lfe.41.1697618552939;
        Wed, 18 Oct 2023 01:42:32 -0700 (PDT)
Received: from [172.30.204.55] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i5-20020ac25225000000b005007da9f823sm602353lfl.168.2023.10.18.01.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 01:42:32 -0700 (PDT)
Message-ID: <ceed957c-0d87-4d42-aa09-d068ef97c9b6@linaro.org>
Date:   Wed, 18 Oct 2023 10:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: Add MSM8909
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
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-3-0962df95f654@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231018-msm8909-cpufreq-v2-3-0962df95f654@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 10:06, Stephan Gerhold wrote:
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
> Describe this using "perf" as generic power domain name, which is also
> used already for SCMI based platforms.
> 
> Also add a simple function that reads the speedbin from a NVMEM cell
> and sets it as-is for opp-supported-hw. The actual bit position can be
> described in the device tree without additional driver changes.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
