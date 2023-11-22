Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B899D7F5115
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344365AbjKVUF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjKVUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:05:53 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4C1B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:05:48 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-359c22c44d6so557245ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700683548; x=1701288348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrlbMrkwsXYB4FXj2gcBQ1hP13CJwFlH1qETDwr8Bbw=;
        b=dxOmw9u5WK8n4MdTYxiJCIz7ke3nBxIrUgzTIYKHqpM7tbFDeJjxJbYS7E3ZbIqnlk
         u6xKT+l8vP/GrdeEe6sVP+yqxHUy13gU8hcuqVdqaCwWpcSRjB7nNgVgfs8uTwZw0PK5
         zRfNsrCJ/DxNO878+WeD2ZdOHHdgMTHEzArDDRnKY6T30Y3XMt/pVooGzYsFHARqgMcS
         WuhU5zEnxqi7JgGSpLW4aFg6pIAQgdV3IUUQzwM/agAtCz8TQDHZ4I+FS9jkgizif6bR
         9ubutd1rt4fKTzjMavoYLL7G9yNcu9tJOLNBTmfxi6S784QoEE5kkn4Y5LZtEGqHEv7C
         hlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683548; x=1701288348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrlbMrkwsXYB4FXj2gcBQ1hP13CJwFlH1qETDwr8Bbw=;
        b=M4qQXlp6kT7BpBzdgEsbarsPyp15DJq4njmkqhdCrI9dKnt6UXb97C0UTYu3cJdfZe
         oHHmPtKUE4Euv6ugB3ACK3Z446Wrqy7/rnHoPngCU9iNNe/qbisoZoyPbO69XwSiQnJp
         /SdbAuioiZ7YnAX4lrFywQ+a80jFI3kISwDv3alVpnRdYDHpsHvG08dxJxLm+2tMRq/z
         jzf1dEb8kWsGbM4CxtfPxou3LIdDfnKtpFnixfdm7qsmI5IQTRhbXp9TIlLQemX/mU7N
         vymb8zKF85rm0EiV37pyFlUjXtsPrm5AacIrYtseGtyUxGUtKYJObA6DPR32NMIph0BU
         RJIQ==
X-Gm-Message-State: AOJu0YxdtFQizjtYHmh5x4ezksLM6/2r5QuO7ir822lvGJZ0ukY9d1+a
        Hrd1pkoSMo/OvUf29t5t3Op+og==
X-Google-Smtp-Source: AGHT+IHnt1n8lKdOoy/IQ7zxz3tfAa5Q5pJfyX8St73RZdlSFGXq1ufTDSL1DA4xJt2sjOxhqX4opA==
X-Received: by 2002:a05:6e02:11a1:b0:35a:ff35:b471 with SMTP id 1-20020a056e0211a100b0035aff35b471mr2869112ilj.14.1700683547904;
        Wed, 22 Nov 2023 12:05:47 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id f14-20020a02cace000000b004665ce094c4sm31227jap.161.2023.11.22.12.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:05:47 -0800 (PST)
Message-ID: <a46a6eaa-a11e-4b78-80be-23ff90349dd7@sifive.com>
Date:   Wed, 22 Nov 2023 14:05:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] riscv: Switch over to GENERIC_CPU_DEVICES
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R4G-00Ct0M-PS@rmk-PC.armlinux.org.uk>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <E1r5R4G-00Ct0M-PS@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 7:45 AM, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> overridden by the arch code, switch over to this to allow common code
> to choose when the register_cpu() call is made.
> 
> This allows topology_init() to be removed.
> 
> This is an intermediate step to the logic being moved to drivers/acpi,
> where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.
> 
> This patch also has the effect of moving the registration of CPUs from
> subsys to driver core initialisation, prior to any initcalls running.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>  * Add note about initialisation order change.
> ---
>  arch/riscv/Kconfig        |  1 +
>  arch/riscv/kernel/setup.c | 19 ++++---------------
>  2 files changed, 5 insertions(+), 15 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

