Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E97E52FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjKHKDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHKDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:03:19 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DF6171F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:03:17 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5b383b4184fso80647527b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699437796; x=1700042596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hHQVK2U6/kZAUYO7M6ukUkQi1h7K41srJttLODmFqQ=;
        b=rujnSOcBArl0FiVttRREX0ihVoTFt25sawGwTJlPWseCWecqyHoc07q5ApSSzTveaf
         e/Qo/hBRYGnPz512k0jCPOxPU7DPdSMGydXC7VNPjPqA+NaJ3Z0u/IfSxhLPdos1EInG
         LJLGqsiV0ot+LYcA31EuQvvy0bFn9ASjxfdOqbNIIteIrSLmIQh5z2NmhS1pozq7eNxQ
         RWLeeMHWSQKiQjS3qbiysTQOh5aN7MB5ccnIaFJ5cDvNUEfjvZwVSWpeLIdYJpjW5o6d
         kqqJCxrkmg4wSTZSk+glx+Rj+NMLPKk35L6R2nDA7yyXTUbSngke8Sdlm+lXoBp77Wni
         4vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699437796; x=1700042596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hHQVK2U6/kZAUYO7M6ukUkQi1h7K41srJttLODmFqQ=;
        b=ESW+HtzJaq7tW/8y5VVMB7VKhI8jKjZUwamuP+MnU3JkRBm8F0iyF0wGmaDMVg8dgM
         Ygl0WL+pC1h2D8Wi5/MT8E9uc1PjW5LP2WZoieXNW539+EauK29MHQZYpEATu5gn93h5
         GfVl6hkAKUSvWfLrosWgqVyDkVb+pZx7XaRd3BvGdEP/4/AwDNzyxVTU/S6zv/1W1wY+
         RPI8g4ca34kP5oWXkYj1oKEhxnv9pEASRW3KGTHxKkkez7+2dQ6DmssAQNx0afUYuchW
         LVRZ+A1WzeGq27aYV4IZ47/jXV6ji71Uy0KQL13McTuAyT+UVXYr14XQI7TUStyktkFB
         0VdA==
X-Gm-Message-State: AOJu0YxeXUUkdM+KBe/zN+WBomlAKs03dDSNTJ1JGW0sJmZujhuX7jyY
        MIKvf6TDf4QYB8OqHDw9Jt5G8g==
X-Google-Smtp-Source: AGHT+IFic12v75dCBwbm4Rz+UAC0cBlweltnHJyTInK6P+k7Nbnogudom9am8MvSpwal/ROHctaSsA==
X-Received: by 2002:a81:a549:0:b0:59f:5361:d18c with SMTP id v9-20020a81a549000000b0059f5361d18cmr1415761ywg.41.1699437796322;
        Wed, 08 Nov 2023 02:03:16 -0800 (PST)
Received: from [172.30.205.23] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o16-20020a056214109000b006717ddb4d47sm888826qvr.28.2023.11.08.02.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 02:03:16 -0800 (PST)
Message-ID: <bd268e9f-2e41-443f-ba29-163a552b5b09@linaro.org>
Date:   Wed, 8 Nov 2023 11:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm850-lenovo-yoga: Add
 wakeup-sources
To:     steev@kali.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231107-wakeup-source-v2-1-bf1562ef9367@kali.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231107-wakeup-source-v2-1-bf1562ef9367@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/23 06:17, Steev Klimaszewski via B4 Relay wrote:
> From: Steev Klimaszewski <steev@kali.org>
> 
> The keyboard and touchpad can be used to wake the machine
> up from sleep, so mark them as such in the dts file.
> 
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> ---
> It would be nice to wake up the Lenovo Yoga C630 from suspend by hitting
> the keyboard or touchpad, so this patch enables that
> ability.
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
