Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98497E4A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjKGVVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjKGVVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:21:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF410C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:21:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5094727fa67so8340944e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699392077; x=1699996877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TP91kUeFUdw5BHZzOadp5Ri1kmnZ7KqGB8htiz8sgvM=;
        b=QCcldNw3mN3z0Z8vUZCd5DNeglbPRGEEkhyOXF9Wpo2HF8ts8KxTp2geNmnwtDJszr
         3/juF4/yhivoSZNtL/r0Oe15snGiUrJq+6PcohgCMrhXjEG15ocxHNplTYogBc0qf5kT
         M0ysQKEju8xvbOK+BuaG7lQlljwwVN1yv+NPokJtZLsG3s1pXVtRW0y/QEYke7HT2mvC
         w32bliZ6S3gkqtazxwzuAZ7Tr4ZGPXMO0scVx8Aw1eTrkuWGrSkx2P99yQA+IWQEcm2N
         xd8rvt//zoXivVKs/Z3VjQDGkhN/dKq9t/LR7goPKAtJ7LiLsCOImnkovefWQR1MbFNt
         LRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699392077; x=1699996877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP91kUeFUdw5BHZzOadp5Ri1kmnZ7KqGB8htiz8sgvM=;
        b=gGanVijD3pjtTAq9ttGu3pQMq6OsoId9RBNVNFzcQXeamYg8G+qyHoO+fQvEJOSJFa
         hp7FCJixgK3X595J5yBhADYok+zXZxjp4dyFiLc0ZvPMGWmddz137FT7CKe+9A4QmniF
         6xZl1359zfgZ2nnP569rLPptyaN1IoF3hmB+cSdjK8AeToO1iREp7kq+6BBWZ5pcyoiU
         za3Ni4R5QeDtvOkCX80XqzT1OZwPrKEySPxp8p0/Sm9gN891E/pvQ9c3s0sQB6MCkXat
         KpSFgzgTW3zUylKD+U4ds5/5ARWL8kwwKoV6uqbdPOXUihiXFCtXd7ePh7jZ4wtJAYKd
         ge0Q==
X-Gm-Message-State: AOJu0Ywt95HSYAQ9/dJSMvkczYtm8wof0KwL7o340WrV6+lmSqByzsw7
        hinxkh7bl5JD8f0czMe3UluXtw==
X-Google-Smtp-Source: AGHT+IG28nfpF/t/GwBx+w4KQQPZXMRL2WGhzbKjj0Jgx7Vh3vZ3wycUfSAG8mv+ArdcXqahB4xabQ==
X-Received: by 2002:a05:6512:358e:b0:505:6cc7:e0f7 with SMTP id m14-20020a056512358e00b005056cc7e0f7mr21874519lfr.44.1699392077343;
        Tue, 07 Nov 2023 13:21:17 -0800 (PST)
Received: from [172.30.205.109] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id g33-20020a0565123ba100b00503200ce35bsm461520lfv.136.2023.11.07.13.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:21:16 -0800 (PST)
Message-ID: <82a25b12-7a63-4c75-8a46-624bc35c6752@linaro.org>
Date:   Tue, 7 Nov 2023 22:21:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
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
 <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
 <835a6add-81e9-42e4-abbe-91632aaa6bc9@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <835a6add-81e9-42e4-abbe-91632aaa6bc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/23 14:05, Bryan O'Donoghue wrote:
> On 01/11/2023 09:04, Abel Vesa wrote:
>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>> give consumer drivers more control and switch the GDSC mode as and when
>> required.
>>
>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   drivers/clk/qcom/videocc-sc7180.c | 2 +-
>>   drivers/clk/qcom/videocc-sc7280.c | 2 +-
>>   drivers/clk/qcom/videocc-sdm845.c | 4 ++--
>>   drivers/clk/qcom/videocc-sm8250.c | 4 ++--
>>   drivers/clk/qcom/videocc-sm8550.c | 4 ++--
>>   5 files changed, 8 insertions(+), 8 deletions(-)
> 
> So.
> 
> I'm assuming the rest of this series works however for sc8250 at least this is a NAK, breaks venus on rb5.
Are you saying that applying this patch alone causes the attached crash?

Konrad
