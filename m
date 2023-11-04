Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF67E0F48
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjKDMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:01:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA2D49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:00:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso455310766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699099256; x=1699704056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5Yt0+TL7qwu2OzCEiBStN1gkCqYNrb0qxd9SfM0lAY=;
        b=Dc/g4py5zMFuqTYWhkAY16G8xLtp8UYLqZx0vFWpSGc3zOo8MP4xVIv+Ah9rKDY3w1
         EQoE7fZ/j7ZtiKkLrZNCj70ifdzDM0EJpYQJ9PIFrvQim1pcorVxYk63t7/Y5nRhX6Yx
         91faJTa9tNwOCLvCMgb8D/MyVF2lLfnCwejsUk+PaQEtybxKSUoE0ARNDCwhLX7XYyc7
         QDlUf4knDi6W2lx/e20JPgt8PwYg+kGoUsC+YaegvpOcVqvgFOuhXSimdJyh9dd4G2mk
         AHkkjC/yiAyUKyGVAdyrG3mlnKMcB2oWiDeAosTTIMkcQqNw0pj1tD5xsvzMiBM4VRmq
         OCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699099256; x=1699704056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5Yt0+TL7qwu2OzCEiBStN1gkCqYNrb0qxd9SfM0lAY=;
        b=EPhWW1Lq+R5wWaVVCg9UrCGMGLb2SqFHNaxFnq2he7CM1w1zPCUamFl6ZgC4YaVGIV
         91bwWQ+gIcCk/ZT9lTL0uapwMiXdkCNYC6bVMIXg3sxuMUYQNknYsPIrpL+zMbuZ8vs3
         G2VEOLoZrQIlmjDsxdVgKz+ZBHP8n4sCEwpEphwjCQpVEmeYG5a62Q12dFBWHEPK759W
         PEL/ukWR1z3IyCYrD/VfQB8M8flPN7B7BdqP6VTRpljlSnreg1OZlVQaU8LqunUDkOa4
         Q2kViFL/sm8Pk1UkAnLn2GZmTajcj3zQrR6Bs90jygfwp9corCr68KGd/YXNOB0lozEs
         +AiA==
X-Gm-Message-State: AOJu0YxqZV3DZ3FGkT/olZ75gtkAosjD4LUXpQ5xri5kwA9ZiG2JeJjc
        PqQdoNjXg3bW8ZaEAAYIXhFYTA==
X-Google-Smtp-Source: AGHT+IEf2aG1zYzvkplVu8QxKBB5EH4uxsOMWiRATX+cU9J2QXHRp6TCbOa+4AdBleHq3fmacdjruQ==
X-Received: by 2002:a17:907:6d24:b0:9c3:d356:ad0c with SMTP id sa36-20020a1709076d2400b009c3d356ad0cmr8602893ejc.24.1699099256471;
        Sat, 04 Nov 2023 05:00:56 -0700 (PDT)
Received: from [192.168.0.153] (178235177017.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.17])
        by smtp.gmail.com with ESMTPSA id r1-20020a170906a20100b00997d76981e0sm1860925ejy.208.2023.11.04.05.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 05:00:56 -0700 (PDT)
Message-ID: <c1d2ce7b-7467-46b4-9587-cfe3d99a5b79@linaro.org>
Date:   Sat, 4 Nov 2023 13:00:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-5-0740ae6b2b04@linaro.org>
 <fe05a0f5-2f57-4f98-afe6-3b0acbaa96fe@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fe05a0f5-2f57-4f98-afe6-3b0acbaa96fe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/23 11:44, Bryan O'Donoghue wrote:
> On 01/11/2023 09:04, Abel Vesa wrote:
>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>> This change demonstrates the use of dev_pm_genpd_set_hwmode API from
>> video driver to switch the video mvs0 gdsc to SW/HW modes at runtime
>> based on requirement.
>>
>> This change adds a new boolean array member vcodec_pmdomains_hwctrl in
>> venus_resources structure to indicate if GDSC's have HW control support
>> or not. This data is used in vcodec_control_v4() to check if GDSC has
>> support to switch to HW control mode and then call dev_pm_genpd_set_hwmode
>> to switch the GDSC mode.
>>
>> Before the GDSC HWCTL was available to the consumer, the venus driver
>> needed to somehow keep the power from collapsing while under the driver
>> control. The only way to do that was to clear the CORE_PWR_DISABLE bit
>> (in wrapper POWER_CONTROL register) and, respectively, set it back after
>> the driver control was completed.
>>
>> Now, that there is a way to switch the GDSC HW/SW control back and
>> forth, the CORE_PWR_DISABLE toggling can be dropped.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> So I plan to give this a test on rb5 and db410c
> 
> My q here though is - has anybody on the submission list tested this through suspend/resume and vdd min ?
I think that only chromebooks (sc7[12]80) and sc7180-acer-aspire1.dts
are able to hit vddmin upstream as of today

Konrad
