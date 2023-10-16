Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9C7D651B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjJYIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjJYIa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:30:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE34129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:30:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507ac66a969so7174350e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698222654; x=1698827454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFHQb/vO+uSnfk86NSCkjoMtagDBPY4Ko8t4pWiqci0=;
        b=RFWnSC2IsVDcjJzJQQcuXHV6slIbQDl1Yr2kzTouKundmbUKWkDbwAQv3JjPH/2Zma
         cF3bJCM1WEkI1ocanOhJCowmam8UhddHfxVC01Rf95ZCulBDen/NXPtnCshYctkMCzL+
         N5AXionTymJugudCZAgyBQkLybAYlGQkzUap/Ih56HqguEq3eBAVsN/rXbNjyQeuwkH4
         9j/6bOdt5+eHT96gy50teFb8mwdA8o8smdlDS13ERGQIVapZYnq5OG0o3FXG7/VAqnrg
         AyrxN/AqP0/5hS1wUPr4k+/e6P8eeJz7MrBhRS+VI36HcyalLa514Jq8sKqndqyO6rE0
         tsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222654; x=1698827454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFHQb/vO+uSnfk86NSCkjoMtagDBPY4Ko8t4pWiqci0=;
        b=ehAzKbHrjfBEjtnuyUw19dT9OXLH4WllgUFLHG9rOrowDX5rMDw6s0Y3C11AcMGFHw
         MJ5Ob4DWHuGBLkRH7hFDxA4iJTSE4vmhPYZftKVmRALBuL3x62DeVSOPALzOufgVEm7K
         scOdLXQJBLaLSKse+78wISQ+6ztSPdbD1ULhI+yDZicjC+LIB90DQfEYBzWUMDv3cLU9
         HJlDhdXUaj5CuXmyikPKhsy5cqOyDGTqhdCgaoTMEP/tjGnGVaKarQEN1lU4wV7Yl6sV
         b7amnxZyG1Rz7+puHzf9HGyakH7kQ8h1juiBdLJRyCt5yR50CnjG+DkqUODqC749MoFI
         y0pw==
X-Gm-Message-State: AOJu0YySerWvPM+cK1AANfHagH1mNLOzsc2BAexfcR+3CPn+e/SMc7l2
        ecGARbeXnDauN11sYOv5YdHxZQ==
X-Google-Smtp-Source: AGHT+IH4jA9MCNcOKVtzPMubXUdbJFA/DuGa9mz9xaE04M4QtDGfGSTgvirxZ5ubWqj/xiqYu4PdEQ==
X-Received: by 2002:ac2:47fc:0:b0:503:3654:37bd with SMTP id b28-20020ac247fc000000b00503365437bdmr9776195lfp.45.1698222654398;
        Wed, 25 Oct 2023 01:30:54 -0700 (PDT)
Received: from [192.168.1.212] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n17-20020a05651203f100b00500829f7b2bsm2450039lfq.250.2023.10.25.01.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:30:24 -0700 (PDT)
Message-ID: <c684d0a7-3336-48e3-9d2b-5c92f9132550@linaro.org>
Date:   Mon, 16 Oct 2023 17:32:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/msm/adreno: Add support for SM7150 SoC machine
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Danila Tikhonov <danila@jiaxyga.com>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        johan+linaro@kernel.org, andersson@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230926174243.161422-1-danila@jiaxyga.com>
 <20230926174243.161422-2-danila@jiaxyga.com>
 <42a1d0ab-4e8d-461d-bb2c-977a793e52b2@linaro.org>
 <1695755445.902336096@f165.i.mail.ru>
 <84e63b82-4fef-416b-8dbe-3838ad788824@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <84e63b82-4fef-416b-8dbe-3838ad788824@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 23:03, Konrad Dybcio wrote:
> On 26.09.2023 21:10, Danila Tikhonov wrote:
>>
>> I think you mean by name downstream dt - sdmmagpie-gpu.dtsi
>>
>> You can see the forked version of the mainline here:
>> https://github.com/sm7150-mainline/linux/blob/next/arch/arm64/boot/dts/qcom/sm7150.dtsi
>>
>> All fdt that we got here, if it is useful for you:
>> https://github.com/sm7150-mainline/downstream-fdt
>>
>> Best wishes, Danila
> Taking a look at downstream, atoll.dtsi (SC7180) includes
> sdmmagpie-gpu.dtsi.
> 
> Bottom line is, they share the speed bins, so it should be
> fine to just extend the existing entry.

But then atoll.dtsi rewrites speed bins and pwrlevel bins. So they are 
not shared.

-- 
With best wishes
Dmitry

