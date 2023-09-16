Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728CF7A3276
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 22:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbjIPUcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjIPUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 16:32:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5ACCED
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:32:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50079d148aeso5438019e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694896327; x=1695501127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5mjBpKZbelK1K5551Sm8tr2/hAoMs9/xBV0waOZAl0=;
        b=mSr/lQREX05PGvw8g8JsWWUkdIzq7ajY8OEVq5AnYoEwLWylApdryR/jJ9ndZ33CDg
         kAkQ5wBjQPE0DbbotTzWZhse/xLP9apx6gJLB+NRliwVTgK6HDkY3MHZ3pvqVfInRTi7
         MgJvS9VcumuuvAyoXGrBuxNviGVFUSbavF9YYq25kscHQK3MtnvmXIsYhZUdGpz4Uolo
         LZV1tAJR/xdo5L/1W6+XRFStcLm6/AlZiLrqaxrYG/TbVnfUULsQEEKaB0nyqC063Ahj
         liYcEP6mro0uqdmk3lOZw43tT17jn/W3gKDgT/a90tqtvoSG4BCSfB1eq52tqIsJ+ymq
         s0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694896327; x=1695501127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5mjBpKZbelK1K5551Sm8tr2/hAoMs9/xBV0waOZAl0=;
        b=rAEcSOvrnE9qdt8sQiwSylCtCOieJoKfd1x1FVGtvsbVVnC8SlN97CkoniI04Jiri5
         /vkdpxgxsc6Liib6dOZeN1/4AaO/ReCMNe0rJG6tIVloxV1TGpW82J0S+HcED4gqGOMD
         qX4+FYVQaWljKDOJIlDyEUBnOpzx9+GVo5h1B6JmWLMJ3hWkVU6PVetwhiaGbe4ym2hu
         jLFQR9MAFIgW2DwmO9faoWPEyPGIguA3AUID1w5klcDHBOiyps2jxtfn9IZ/32CqVOk8
         GDvc4WcS72BwF8GD/yHwW35f+2ZL6KpRGhBKGMx4dpf6CMZbn382yvI9Djh/bhCMeEXh
         2TUg==
X-Gm-Message-State: AOJu0YwQMEz3jYbb5EULfFpzHaDtUwAuKLEc4G4gLhLZLsJNl1Za3Z3b
        nIOKtt1Rk6TkrJ9/5HeKk4qDMQ==
X-Google-Smtp-Source: AGHT+IFcpcTHStCyOX8YWi1KCGkCbnJakGWklpllFg1hg6VPq8emBGtJKM2mfPoRqWYfL5RLNmYFZQ==
X-Received: by 2002:a05:6512:788:b0:4f8:7772:3dfd with SMTP id x8-20020a056512078800b004f877723dfdmr4411295lfr.11.1694896326389;
        Sat, 16 Sep 2023 13:32:06 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id q5-20020aa7cc05000000b0052a1a623267sm3835534edt.62.2023.09.16.13.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 13:32:05 -0700 (PDT)
Message-ID: <accb4814-4826-ff97-3527-4e3fbadcd4ff@linaro.org>
Date:   Sat, 16 Sep 2023 22:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
 <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
 <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
 <212f9bfa-6d4c-bba2-60d2-272c001a4322@quicinc.com>
 <e30870d5-a0cc-4210-a2b0-c7621ea5ecfa@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e30870d5-a0cc-4210-a2b0-c7621ea5ecfa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2023 17:13, Georgi Djakov wrote:
>
>>
>> Complete list here, and it is inconsistent. Latest 8550 is also =y. Do we document
>> the reasons somewhere on why they are added as =y?
>>
>> CONFIG_INTERCONNECT_QCOM=y
>> CONFIG_INTERCONNECT_QCOM_MSM8916=m
>> CONFIG_INTERCONNECT_QCOM_MSM8996=m
>> CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>> CONFIG_INTERCONNECT_QCOM_QCM2290=m
>> CONFIG_INTERCONNECT_QCOM_QCS404=m
>> CONFIG_INTERCONNECT_QCOM_SA8775P=y
>> CONFIG_INTERCONNECT_QCOM_SC7180=y
>> CONFIG_INTERCONNECT_QCOM_SC7280=y
>> CONFIG_INTERCONNECT_QCOM_SC8180X=y
>> CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>> CONFIG_INTERCONNECT_QCOM_SDM845=y
>> CONFIG_INTERCONNECT_QCOM_SM8150=m
>> CONFIG_INTERCONNECT_QCOM_SM8250=m
>> CONFIG_INTERCONNECT_QCOM_SM8350=m
>> CONFIG_INTERCONNECT_QCOM_SM8450=y
>> CONFIG_INTERCONNECT_QCOM_SM8550=y
> 
> If the device can boot (to console/initramfs) with =m, we go with that.
> But if something critical like the UART depends on the interconnect
> provider, then we make it built-in.
> 
> On SM8550 for example, we have enabled bandwidth scaling support for QUP
> and that's why it needs to be =y.
> 
> It looks like on SM4450 this should be =y too.

I asked why SM4450 has to be =y and there was no answer. The argument
that SM8450 is a module, is not applicable.

Best regards,
Krzysztof

