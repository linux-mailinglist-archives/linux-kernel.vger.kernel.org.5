Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86B57B0331
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjI0LhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjI0LhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:37:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307C813A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:37:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bff7d81b5eso184319191fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695814632; x=1696419432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynMxhZsb1RwRjxa41UJyZdRgOe/P995qAEy3Dqy5MkY=;
        b=FWwolEjYJfSFICYfpQKXmUHuzrPA9KkMm9FEG9No22+E6uKN6JEI6ZX00WJS4W+VcT
         aXwGO/bOrJ/FbZvsQs0PW8FiWQn4RI9yyumUxJOYBVIazPy+uIyzb7SS6uyCrBuf+L3C
         SWF6E7fo+mmTStkDtj/PVkRgWoTj0Owi/RVtyAh0MrHKdxLkq9hxwqY8jFG/Lfq3mLtX
         oFx5KhtGBUgQ+emTRbrW18rDru+X49IFABdWjoKaBDn3b/3oFl2mDf8waixs/EXseO2j
         OMgOGZFqldPtYfNlkWi6PXxHU9X27/DIPzWk4ctOC7KMioF+dPmS3huVIwRo3MA59Nuq
         +J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695814632; x=1696419432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynMxhZsb1RwRjxa41UJyZdRgOe/P995qAEy3Dqy5MkY=;
        b=OueVpgcljtIw461lXYRB45mXRvigXS8pIV/eVPWwBZh5itfjyFGYXz0oDUv7pdud88
         jmyzDMAs5TBm3NPQa+LOjyMLVO3Xg/aWzmIWxEh2sWdJvyqiFvOHevyPyMQE01a8igM1
         OcI8vvoGoG4FtErSxiaCZ7ByGWipIZZ1jxF1h6icM+tA0/Qigjd36vlZ1avJ6F/DYxJa
         VShHnWo95ndZClWa8DYB9Cd5lfltAN2/g3lp8U0i8fgXmWMPMyVXdcpjdAonHC/4WkNU
         1Iq1A8f16mKOJM2BT1/FFmkJIXCixi0XDsnekj8bFwlCEljHpvQ00toZ92EJ/l35cXV2
         YI8A==
X-Gm-Message-State: AOJu0YxsCPhkBJErb5D1MMogSWLH5lLOUgrD85mC6w/S9DxC2DIPzAlG
        iQv2Ie1BZREZs2RutNR5Al7oGw==
X-Google-Smtp-Source: AGHT+IGX5f/NUoo8Wnq48GpJV1v4/emZ/q+GTGAZ70lhETKv/NS91G/JT0UietmK1rOhk6FJ8mmE+g==
X-Received: by 2002:a2e:9cc2:0:b0:2bd:19c5:3950 with SMTP id g2-20020a2e9cc2000000b002bd19c53950mr1825623ljj.33.1695814632257;
        Wed, 27 Sep 2023 04:37:12 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b009ad8acac02asm9234029ejb.172.2023.09.27.04.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 04:37:11 -0700 (PDT)
Message-ID: <093d1c77-0a76-4f72-80d8-ffb9f9d09cf9@linaro.org>
Date:   Wed, 27 Sep 2023 13:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v3 0/5] PM: domains: Add control for switching back and
 forth to HW control
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
References: <20230923114950.1697701-1-abel.vesa@linaro.org>
 <CAPDyKFrEgZhPJcYXxxZ=o_VwEi3Dav8ZLBk2vHWNuiqQp8hSZQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAPDyKFrEgZhPJcYXxxZ=o_VwEi3Dav8ZLBk2vHWNuiqQp8hSZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.2023 13:32, Ulf Hansson wrote:
> On Sat, 23 Sept 2023 at 13:49, Abel Vesa <abel.vesa@linaro.org> wrote:
>>
>> This is just a resend of v3:
>> https://lore.kernel.org/lkml/20230823114528.3677667-1-abel.vesa@linaro.org/
>>
>> Just added Ulf's R-b tag to the 2nd patch. No other changes.
>>
>> Abel Vesa (1):
>>   PM: domains: Add the domain HW-managed mode to the summary
>>
>> Jagadeesh Kona (3):
>>   clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
>>   clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
>>   venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode
>>
>> Ulf Hansson (1):
>>   PM: domains: Allow devices attached to genpd to be managed by HW
>>
>>  drivers/base/power/domain.c                   | 84 ++++++++++++++++++-
>>  drivers/clk/qcom/gdsc.c                       | 32 +++++++
>>  drivers/clk/qcom/gdsc.h                       |  1 +
>>  drivers/clk/qcom/videocc-sc7180.c             |  2 +-
>>  drivers/clk/qcom/videocc-sc7280.c             |  2 +-
>>  drivers/clk/qcom/videocc-sdm845.c             |  4 +-
>>  drivers/clk/qcom/videocc-sm8250.c             |  4 +-
>>  drivers/clk/qcom/videocc-sm8550.c             |  4 +-
>>  drivers/media/platform/qcom/venus/core.c      |  4 +
>>  drivers/media/platform/qcom/venus/core.h      |  1 +
>>  .../media/platform/qcom/venus/pm_helpers.c    | 47 +++++------
>>  include/linux/pm_domain.h                     | 17 ++++
>>  12 files changed, 165 insertions(+), 37 deletions(-)
>>
> 
> It looks like we need a plan for what tree to route this through. Or
> if we should use more than one tree. Bjorn, Stephen, thoughts?
+CC Vikash, Dikshita, Stan

The venus patch should also be taken with the rest, I guess
taking everything through qcom would make sense

Konrad
