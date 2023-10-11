Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80B67C4E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbjJKJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjJKJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:14:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61E794
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:14:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405361bba99so60835475e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697015696; x=1697620496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dcsbzf8E/7eeyM/pc2wr1VcgxpBh3MPzSnBM0me6VQ=;
        b=wgUdK2hGmpNfeGpf4cOHi88ZedLhd1HBmJ1wjnV0kPJOCZsyDJ6QIHvtb3Tw0VNswy
         6JZ4tD2/vXfsDD2JIAhH4/F9TQtWaj7TF24vq8ZCPjC6ivi72XohpvYyTEt4G7HAEXCT
         GNJ6UpkTlk6lq8Bc1gWn9sZh4p3Wl0Q4/+Jw0SGYhFFKysLMyQTvYAKBrRtt8nD1BgaE
         bQw5Q1S7NMK8+BpuvUMzsrz9dQW0NCizhEAbYpNEnMu3aD10LUGbXMARzSmJwaocdts3
         o8ow2hsLIXAJgB5ycvIBjMfpHWD7+XvtYTdzxg06UH18jNwdGgC8jUMfFT+fo7s+MVgK
         Je7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015696; x=1697620496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dcsbzf8E/7eeyM/pc2wr1VcgxpBh3MPzSnBM0me6VQ=;
        b=mUOTOiaJd1SK8PAkrlkw7VFYGrHMvSiPxsTlq6RJff6fgvujoBQfyLcugaEYGAdKtL
         3WZ1UbZRkhobMAb0ffh0sSP+w+1wMG6ks6lOJZfXtMFI+onj/eoNLpDb6LRigGYweBL0
         p64C3y5cs2uLP8E0UbLYWNmI9uEclJp4oiXwUS9+U31gFNO6E8uV3C4wwKM6idWyViyJ
         TMShfVHKYo0Qj1Qd7Zkw/1583VNeVEU8BVkXebjDgIIEUJkY1dUapd/NkLQ8m4KisHWz
         V7Z7RIM8az4nmMvAdS14maL+PTeyb5vx0aZzu+9cTN2he2AxVjEKI7KwfL5AB1Tml5c1
         PWbQ==
X-Gm-Message-State: AOJu0Yx/eRqWEn61UF+I6rLvORr0e06nEAdO/q/tujTn/WgD124jecDx
        /eVmepgXB3Ph1Z3sepwv5ZJ36w==
X-Google-Smtp-Source: AGHT+IFiH+YSs/NYge2HLcC7hKWSTqv0Z71LvtzWkhS94lL06dO+Ooh7J+MIlnk7hzzqpwtUN5jE7Q==
X-Received: by 2002:a7b:cbd4:0:b0:401:b76d:3b8b with SMTP id n20-20020a7bcbd4000000b00401b76d3b8bmr18890887wmi.16.1697015696048;
        Wed, 11 Oct 2023 02:14:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de95:eca9:6b1e:b330? ([2a05:6e02:1041:c10:de95:eca9:6b1e:b330])
        by smtp.googlemail.com with ESMTPSA id bg24-20020a05600c3c9800b004063c9f68f2sm13391034wmb.26.2023.10.11.02.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 02:14:55 -0700 (PDT)
Message-ID: <367c01e7-1096-47f2-a0da-920b0ea4b915@linaro.org>
Date:   Wed, 11 Oct 2023 11:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add
 timer_cannot_wakeup_cpu
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-5-sunilvl@ventanamicro.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 19:00, Sunil V L wrote:
> The timer capability to wakeup the cpu irrespective of its idle state is
> provided by the flag in RHCT. Update the timer code to set this flag.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

