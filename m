Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FC37E6B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjKINbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjKINbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:31:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F730CF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:31:05 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40790b0a224so5882305e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699536663; x=1700141463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7wSwsJDVC+WFzVhVIJKKG6kw5XK1WEXSl+1a+Sx190=;
        b=pQJSCPKsdvs+fLj7nRr1UkQOIaMhVssnuKSJi/Gm/m38ytCDaHkHBmZTSzDeFGI8g5
         92M+nD2/sj/EYcdinYTquRW5PoRE+Jpn/b37VSTPhNgyF52rMGwKNucz20UBV6xlYPGb
         2uePFK1hf75Qu8wxhrwCJNLAKamS2ExLA9PaDTh61iLLDneFaws3dmaYmspiSu8lFyl3
         tLq8XIdoZVDyBcUvj1mikkUMi4DJ/vhCv8oy8rtx6wrIbX+WXj8bhrEgAJN2yzmiXZE/
         gpCd9nG33VfBP4w47+022ZmwgnmFLA2gk4JJ1XVKVqbmKAOcIDvfoCBop9KNdFaDeEp3
         gr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699536663; x=1700141463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7wSwsJDVC+WFzVhVIJKKG6kw5XK1WEXSl+1a+Sx190=;
        b=s9hChMoByaze/4FzxJB7ikCZBRWjYWBpIAIpJFbO5tJdcGXfQae/xATBmVVVozTYn8
         K4I6m1h5lKRDnSlSNfhHvsWU3+mu/RLVJbTRLn7T9BFUhINbyYxUTK/v4rufiuaRrvHX
         xry+p6lqlz1D/ePNtjONF8lp0EybWgBZxyD5vk6KkOBaHwUIqD1R7H2RBVhTWp00akF5
         o+Ez6QhcHIhjYyBFVURLNxo0Ghuf5vH/O6MipNsFOvKcqd53V9LKYhsn28NoKAVpzW1J
         C0JKV57eWVQYBU6GDvPhwNoYdOyfvSI1Dm0EhJ6uFKNZ7XZFhkiwQoMWmFLhe2/vQxaV
         QZVA==
X-Gm-Message-State: AOJu0YyN7NofcI7tYnirZ9A5g3LLJAzk+PEfuvn9hQ/Lig92ZUgDnXuS
        OUs9zkx1Qi5E3cM2bFoSun0guA==
X-Google-Smtp-Source: AGHT+IGlzYfCp7R2ALAusnJakOcIsFFY60CLzrvOpftGcSSMR7es7S+xeCW6gPM1nWx4ps1AB5k1BQ==
X-Received: by 2002:a05:6000:1842:b0:32f:7ebe:3e5a with SMTP id c2-20020a056000184200b0032f7ebe3e5amr5224216wri.50.1699536663530;
        Thu, 09 Nov 2023 05:31:03 -0800 (PST)
Received: from [10.66.66.2] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d640d000000b0032d96dd703bsm7425418wru.70.2023.11.09.05.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 05:31:03 -0800 (PST)
Message-ID: <038711cb-321d-47f0-82ad-44965116a4a9@linaro.org>
Date:   Thu, 9 Nov 2023 14:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sm8250: Add wakeup-source to usb_1
 and usb_2
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, dmitry.baryshkov@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231109004311.2449566-1-bryan.odonoghue@linaro.org>
 <20231109004311.2449566-2-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231109004311.2449566-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 01:43, Bryan O'Donoghue wrote:
> To test out a different GDSC change I wanted to have a USB keypress resume
> a system in suspend.
> 
> Adding wakeup-source to usb_1 and usb_2 "just works" for me on rb5.
> Consistent with qcm2290 and sa8775p add wakeup-source to the dtsi for the
> SoC.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Maybe we could make it the default in qcom glue somehow..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
