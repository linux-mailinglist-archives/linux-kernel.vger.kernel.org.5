Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13147E01F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbjKCKob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377832AbjKCKo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:44:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A73D57
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:44:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5094cb3a036so1908681e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699008257; x=1699613057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5nLolPwuJpq0W0yvjQJguc5sT9X9KBoVJr/KRt6GGU=;
        b=uqChyuT+DOS51LiRh9a/iv3r0te8urzMp7RKtCJhnVyGS5tbXaeisW1dFJss0KqNNj
         gus+iv2Y5VRO36R6caxwLwT+r4xolyunvj298sRcTylpyd9AM8AJ3MZdv6a2O65oee8X
         7ivWEAihTmKkMWiFpkwcwcBJPsQ1/ez01z+USF8PgjLr2mIQeFgmF0RGs+vDhOpD2Y9c
         Dy4oIJpR9UTkt25cyQEpq0jJ2iSe+Q/MV2IGp5D/DRov5Sie2+9GowUMj+VqoQfGnwm+
         6bUpIEPDxX7k0VqUpJrhMkmyZfygjRUwX5sSIMshZx6b6f7oSyCGaRwmO/QiWKH86e+B
         5scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699008257; x=1699613057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5nLolPwuJpq0W0yvjQJguc5sT9X9KBoVJr/KRt6GGU=;
        b=duSwljPWl0g0UY/mdFLjJBLDbFRba8a1Vgjr+JIkh/VgawO++SXGHqW+Z5r5iOOKj3
         nckTJ8y1sNr7913Kgs/Fnmq3IqlDejKS8Ua1NiFbBjl3U3wUETGCD50WUlWLLLuRBo2O
         iDfF8lYZgsuDpmvm6Mij23SjxMqXMcDhAelRBEGZGLt8BiN2+roj4xI8ClGyIoVV0n/Y
         DcbyqI0pj7uw6LGtUuXDgfqpxX3oaTS6IdsJDB3uHVVbGvRp4+QtHZwTMIeIE4+ur9EV
         4gN5FfuIW2A0KIOSDiWaUSsgQA4fbF9epAH2dK7XYlvnIpiu4+zPSMlnxxs4GGlXsELn
         8ffA==
X-Gm-Message-State: AOJu0YyKn7J+uQ8X9Am4J/X/DsE6fHNoDgbwl2sUqyr6jq36v2iuK1P4
        bTTjCQMvtHbtBD8ru3vCRfHnBg==
X-Google-Smtp-Source: AGHT+IGWyRsXFk6LHw2H/ZIpZhZ8RL6RZVkgocUX8w24VSIFhdIXzdR+tNgUainvl9TtQl7/CIm11Q==
X-Received: by 2002:a19:2d0a:0:b0:507:c7cc:12d7 with SMTP id k10-20020a192d0a000000b00507c7cc12d7mr14426147lfj.4.1699008257167;
        Fri, 03 Nov 2023 03:44:17 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d5686000000b0032f7eaa6e43sm1526650wrv.79.2023.11.03.03.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 03:44:16 -0700 (PDT)
Message-ID: <fe05a0f5-2f57-4f98-afe6-3b0acbaa96fe@linaro.org>
Date:   Fri, 3 Nov 2023 10:44:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-5-0740ae6b2b04@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-5-0740ae6b2b04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 09:04, Abel Vesa wrote:
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> This change demonstrates the use of dev_pm_genpd_set_hwmode API from
> video driver to switch the video mvs0 gdsc to SW/HW modes at runtime
> based on requirement.
> 
> This change adds a new boolean array member vcodec_pmdomains_hwctrl in
> venus_resources structure to indicate if GDSC's have HW control support
> or not. This data is used in vcodec_control_v4() to check if GDSC has
> support to switch to HW control mode and then call dev_pm_genpd_set_hwmode
> to switch the GDSC mode.
> 
> Before the GDSC HWCTL was available to the consumer, the venus driver
> needed to somehow keep the power from collapsing while under the driver
> control. The only way to do that was to clear the CORE_PWR_DISABLE bit
> (in wrapper POWER_CONTROL register) and, respectively, set it back after
> the driver control was completed.
> 
> Now, that there is a way to switch the GDSC HW/SW control back and
> forth, the CORE_PWR_DISABLE toggling can be dropped.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

So I plan to give this a test on rb5 and db410c

My q here though is - has anybody on the submission list tested this 
through suspend/resume and vdd min ?

---
bod

