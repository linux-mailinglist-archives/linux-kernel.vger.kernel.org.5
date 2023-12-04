Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44F803C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjLDR4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjLDRkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:40:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8AA135
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:40:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c039e9719so26397185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701711650; x=1702316450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xx5w7dKe4Dl4/rl9aREFhjhd8NHzESAxh2sc4w+mk34=;
        b=ch8CM5MLWkYEY83+cSazHF+5jrvBUOiLNBanUyeGdaiqIEaY7iYASzic9JAOxjRGOW
         K39OukWZ/hsFKy4wtdkVuJdoxssiV3hR/2Ov1wU0mY6vDx3XJbEINR+PTdjSQatbHgoN
         8SekNWYB3JhCcvIewdcujr8qqHDWHMQCxdhmoNDqhvYqo0JkL6CdIHkI/NyfPP0r7y3/
         uGhOrvhdwZnx4DZIQaXYaY3+5zXqTP9Ds5bnZMNf5jZbCmZ4Z/dT5Ju/PQ6v3aeoBSaR
         ok9fq2Pg1VGxQnMWLZ9ZuhnEubjI1Hv2cuaeI4XnU0McjgWRlAKuJ4YMywu6W/nJiV3E
         gkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711650; x=1702316450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xx5w7dKe4Dl4/rl9aREFhjhd8NHzESAxh2sc4w+mk34=;
        b=Fsb5c9ZzmqgBxeA1W0TX7ttoFCDAF2ssaf7X+3wmd8GeCa/fgye0eDymlPNCRlFdt5
         HRgWoAYMvHycuwAHp8Q1MBp+qReMwdcea7d/yfc37mpu2AzM1UwxjEhw+pw7uFKNhnPm
         8ShlJ1c3Z9xSd55wfhjL1dHe3dlXCQcTdu77zft4lBVoBSJ5DiTV0c+6ldkplpD41cFm
         UymUuO0NnYJPCdROaivVjoZDa88H2eRvaRIwvCyZ3FQ3rcFcg9Q+KBDvVmsQNoW5sSUJ
         8dg+vZELuUndPwUvzu7ZsQTrfiPmNtKtfDAJDUF+mupedwH+uxIPJdjn/80DDJcDdodi
         D25Q==
X-Gm-Message-State: AOJu0Yz6KKzJ7t51dbD3T2gfglSvwi49gzcoX6tv7RdqpjjvtkTID72z
        Ij4jQtIwvMIoRJtkficD0L7Row==
X-Google-Smtp-Source: AGHT+IG0WXXG+zp6A6LukU/gkAs779X82pYay35m7VtKikn6802WqVsaPGijGytYDXlL6Dip+Z4eNw==
X-Received: by 2002:a05:600c:1f91:b0:40b:5e21:ec26 with SMTP id je17-20020a05600c1f9100b0040b5e21ec26mr2866881wmb.88.1701711650095;
        Mon, 04 Dec 2023 09:40:50 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c831:1e47:2:5b96? ([2a05:6e02:1041:c10:c831:1e47:2:5b96])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm19415061wmq.18.2023.12.04.09.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:40:49 -0800 (PST)
Message-ID: <c6353566-5bb9-4af0-9d4a-8efab5afc86d@linaro.org>
Date:   Mon, 4 Dec 2023 18:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] clocksource/timer-riscv: Add riscv_clock_shutdown
 callback
Content-Language: en-US
To:     Joshua Yeong <joshua.yeong@starfivetech.com>, tglx@linutronix.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     leyfoon.tan@starfivetech.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20231116105312.4800-1-joshua.yeong@starfivetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231116105312.4800-1-joshua.yeong@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 11:53, Joshua Yeong wrote:
> Add clocksource detach/shutdown callback to disable RISC-V timer interrupt when
> switching out riscv timer as clock source
> 
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

