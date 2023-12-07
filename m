Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD58091E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjLGTsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjLGTse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:48:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042CA5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:48:40 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so1349001e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701978519; x=1702583319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhvAcona8JE9mqSkyUEEifprTp821EbSPpKf2QS4sas=;
        b=qq/jp4K7FJfea1xWaARo38MG9sUZU/uAAm8AKrkjxkXf93WIsiI0oFhQ2Qi/ucpS6q
         teo8qy4x7OL51Do099gKlFMHh1IL322kVU0xeZ/b4wwSnzmeouQd93fDox0cOpOOKUoT
         3ykavSn/rftmjsBhF9xI6krR1X0Fdoo+7gUh5ZOSfomAoqA7i1gu3UDsI7jHDb7yHPZU
         q3kqs/xMK/h5iqHE1s9a3urF79fjj8FdpVRqtg2sHO9Bl+KvYRznvIxKSkbYORWPRkEk
         Xtih3wIB2NggOwTQ5lsOjCbJCmFQxRIViawuGu+G4m7WAvVwwiXcW3mL5W5jRfGLxppH
         OSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978519; x=1702583319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhvAcona8JE9mqSkyUEEifprTp821EbSPpKf2QS4sas=;
        b=qXwtkcsjrZRJRDg4y6/NJtIyBO0+2MAMx4AmXZOoHL3T12gE1qEBbfhwv6zwE207Yc
         WsyNB7jH8PKSH9muJ8AZx9/iZH2GCmY3znQKrw+WPq+uj/O4Y+4eRN42K2doauBTNy1j
         MKmuSP4vpb6pbZouxWtbYuP60rma//C7x3YFuF9zl6rWw2qRfSMJDyC/0rr37dUD6s8w
         DZgmMVt8hl3xWz1Kj9JDfWte3zK2HTxj0n/BfQtS5MTCQtsrFI2oTzI+hcI0WGRAJ/qU
         y4f8sIbJHN4nML2MGwHk5ymI+c52RV8aMIa48cCXOx2ECl3+oUYvtvFIawi0EMq9V8En
         dSSg==
X-Gm-Message-State: AOJu0Yy+xv8LBOarLPO0YhK/ENUiMULRK4MGpD+00tZNLfrQOgGuuIUK
        M3P5wmuDmeiZRPjr3Z1v01F3mg==
X-Google-Smtp-Source: AGHT+IFljctdvuyZS7CVZkeukvmHRNSLUGo+jsvHFsItAp5VfL6Nc6kSd4dOhvsJ3yfP3i4ct2webg==
X-Received: by 2002:a05:6512:4cf:b0:50b:ee7f:a0be with SMTP id w15-20020a05651204cf00b0050bee7fa0bemr1615515lfq.5.1701978519021;
        Thu, 07 Dec 2023 11:48:39 -0800 (PST)
Received: from [172.30.205.181] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i38-20020a0565123e2600b0050bf789f501sm29324lfv.11.2023.12.07.11.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:48:38 -0800 (PST)
Message-ID: <d830f067-7037-4303-aad7-82b9a1cc660e@linaro.org>
Date:   Thu, 7 Dec 2023 20:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/msm/adreno: Add support for SM7150 SoC machine
Content-Language: en-US
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Danila Tikhonov <danila@jiaxyga.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        johan+linaro@kernel.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230926174243.161422-1-danila@jiaxyga.com>
 <20230926174243.161422-2-danila@jiaxyga.com>
 <42a1d0ab-4e8d-461d-bb2c-977a793e52b2@linaro.org>
 <1695755445.902336096@f165.i.mail.ru>
 <84e63b82-4fef-416b-8dbe-3838ad788824@linaro.org>
 <c684d0a7-3336-48e3-9d2b-5c92f9132550@linaro.org>
 <f76637f9-8242-4258-932e-b879145a5cfd@linaro.org>
 <99ffd03f-b888-4222-939b-603c10f2307b@jiaxyga.com>
 <n3y5vfgznufdzdkyv6ygtohkepat5ayrpklearjw6jin57ussu@6uds6wtgaeaq>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <n3y5vfgznufdzdkyv6ygtohkepat5ayrpklearjw6jin57ussu@6uds6wtgaeaq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/23 20:46, Akhil P Oommen wrote:
> On Thu, Nov 23, 2023 at 12:03:56AM +0300, Danila Tikhonov wrote:
>>
>> sc7180/sm7125 (atoll) expects speedbins from atoll.dtsi:
>> And has a parameter: /delete-property/ qcom,gpu-speed-bin;
>> 107 for 504Mhz max freq, pwrlevel 4
>> 130 for 610Mhz max freq, pwrlevel 3
>> 159 for 750Mhz max freq, pwrlevel 5
>> 169 for 800Mhz max freq, pwrlevel 2
>> 174 for 825Mhz max freq, pwrlevel 1 (Downstream says 172, but thats probably
>> typo)
> A bit confused. where do you see 172 in downstream code? It is 174 in the downstream
> code when I checked.
>> For rest of the speed bins, speed-bin value is calulated as
>> FMAX/4.8MHz + 2 round up to zero decimal places.
>>
>> sm7150 (sdmmagpie) expects speedbins from sdmmagpie-gpu.dtsi:
>> 128 for 610Mhz max freq, pwrlevel 3
>> 146 for 700Mhz max freq, pwrlevel 2
>> 167 for 800Mhz max freq, pwrlevel 4
>> 172 for 504Mhz max freq, pwrlevel 1
>> For rest of the speed bins, speed-bin value is calulated as
>> FMAX/4.8 MHz round up to zero decimal places.
>>
>> Creating a new entry does not make much sense.
>> I can suggest expanding the standard entry:
>>
>> .speedbins = ADRENO_SPEEDBINS(
>>      { 0, 0 },
>>      /* sc7180/sm7125 */
>>      { 107, 3 },
>>      { 130, 4 },
>>      { 159, 5 },
>>      { 168, 1 }, has already
>>      { 174, 2 }, has already
>>      /* sm7150 */
>>      { 128, 1 },
>>      { 146, 2 },
>>      { 167, 3 },
>>      { 172, 4 }, ),
>>
> 
> A difference I see between atoll and sdmmagpie is that the former
> doesn't support 180Mhz. If you want to do the same, then you need to use
> a new bit in the supported-hw bitfield instead of reusing an existing one.
> Generally it is better to stick to exactly what downstream does.
OK I take my doubts back, let's go with adding a new one.

Konrad
