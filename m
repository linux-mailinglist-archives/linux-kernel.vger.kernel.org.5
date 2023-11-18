Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394A77EFD0A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjKRBww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:52:51 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28804D7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:52:47 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-407da05f05aso552425e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700272365; x=1700877165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beQAaUooTYtJIw7OKCSz0TPZiTblJ6rroskHEToeWdg=;
        b=FzeQoJ3i/UcpE4ovQKbx7nR1OS6WMsQz4ZZ+j415Dm10OACrho7YPOIf4WvTgP7QrD
         /ZmmkVLcGhA1OYkypcnNnLjOSDj3J2lZSb5NI0CpBVg5YCrhQvX9p4EBD8p/NL2DX4i+
         sX0Fl8iTBjV1Hs8QDkIqiIHb9s8fGDG9OanaUs5TFjl7IGM4FHa8dGy1U2FfVY4awM6k
         lY/kQT+/BTUDADxP8kfbsy9PT1ypKdCXkQmGVI9GuuwyXAAu2kh42d17xR4iuCX5Mkmo
         SnOk9lpJmbeneJ71+4UTuFp5+t9axzAtQ15kH56AA8gWYPdmuQr3755q5+vvCuvmIkyQ
         +0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700272365; x=1700877165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beQAaUooTYtJIw7OKCSz0TPZiTblJ6rroskHEToeWdg=;
        b=VmEo/xnunSTO5q5WBvX0z3CNCY92iitPnWa8N5F3soVG71TeH1MSRYmaw2VPjXnlwe
         0a2wY64JqtY3QahOaotSqnKHTA03xg6ihrB3OyUyVsEup+IdrG4S1uR7jcanXy8KNDyq
         diBqQAUZjVntRls4Pt40lREkfFN27jRLonb31msOZn33tZEyFm4r2CNwS35AjKeiroIJ
         IoUwyk0QZKGFdKi2b9z2VHhg5pUaeCpkWzMb1fL5rz3TMXyRcWUMAP2cRrdOGIS+KoYP
         tWV60DxKIvO6Jn6+cZ4cZANWp8rWnCGwVopzqEYxWx7TzygwubmLItz+Zj0ZR42a1eij
         nvSA==
X-Gm-Message-State: AOJu0YxE3v5gm4RJbX1/ITfq6a/J7PiwYhD47NRFhmtTiq3nFj+Y+avz
        adMJOaFmCS08FJh4z/ryp51I7A==
X-Google-Smtp-Source: AGHT+IE2hLmsmCPrJJeC6nk/f6XEjguRcjWsG0tCK9xcAuWJh+kn1SuzhRE/UKucZPoHo/JnvZOQzA==
X-Received: by 2002:a05:600c:354a:b0:401:c338:ab94 with SMTP id i10-20020a05600c354a00b00401c338ab94mr727705wmq.29.1700272365546;
        Fri, 17 Nov 2023 17:52:45 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id y14-20020a05600c2b0e00b0040644e699a0sm8836386wme.45.2023.11.17.17.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 17:52:44 -0800 (PST)
Message-ID: <c8cf229b-4d15-4eca-bc4b-61dc67d63e91@linaro.org>
Date:   Sat, 18 Nov 2023 01:52:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] clk: qcom: Add Global Clock controller (GCC)
 driver for X1E80100
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231117092737.28362-1-quic_sibis@quicinc.com>
 <20231117092737.28362-3-quic_sibis@quicinc.com>
 <ec9d03f7-7158-4309-9a04-b08c69b89f39@linaro.org>
 <2e0d2c55-fb2f-4903-a555-f51019942c6e@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <2e0d2c55-fb2f-4903-a555-f51019942c6e@linaro.org>
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

On 18/11/2023 00:06, Konrad Dybcio wrote:
> On 17.11.2023 21:50, Bryan O'Donoghue wrote:
>> On 17/11/2023 09:27, Sibi Sankar wrote:
>>> * Use shared ops in the x1e80100 gcc driver [Bryan].
>>
>> This looks better to me now / more consistent with what we have in sc8280xp - where we do try to hit suspend and => retention/parking matters.
> Parking the clock is separate from putting the system to sleep.

Yes but several of our clocks want to be parked, not switched off.. 
which obviously does matter in suspend.

> IIUC we usually use shared ops on clocks that may have different users
> (e.g. not only controlled by Linux) and/or that are crucial to the
> functioning of hardware (like AXI clocks, which if gated would make
> the system crash on any access attempt, from any subsystem, unless
> turned on beforehand)

My question here for Sibi, is why sdcc2_apss_clk_src differs here from 
sc8280xp?

Is it wrong on sc8280xp or if correct sc8280xp then why is it not 
replicated here ?

https://lore.kernel.org/linux-arm-msm/e857c853-51ef-8314-2a21-fa6fd25162ca@quicinc.com/

Also @Sibi I realise alot of this code is autogenerated - it would be 
worthwhile finding/fixing the script that does the generation to plug in 
shared_ops instead of floor_ops if the input material has the necessary 
flags.

---
bod
