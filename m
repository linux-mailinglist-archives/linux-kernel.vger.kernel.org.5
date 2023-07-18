Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38DE7573F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGRGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGRGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:20:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A5FA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:20:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992dcae74e0so731412766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689661227; x=1692253227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qE7RBDA3NZlKcVon5Sn7qs3jAcqHXcGJIQX6fRCgOgI=;
        b=gkrb8IIGLOZ1trSAa2rM8I8kNug2D1AVRXcrF7/tzm1zR2Vh5psn+spJ1DDYYX8n/Y
         k5T/lmfLW4EsVuC3yDF29+dwYyDiwsGKjFvRDWz/6U6igBkxL+WbEhBhRV6Oy+omdjMC
         Xzzf7o/xNN/qXVtzN7WTQn0kX2DAX5tPkzWOjTFk4wevOJO3cGVYuq/whAyXQq+Op95L
         XrhCkDkMl6NrBUQA5sO/zBlQh+0J0LcrB7Kr9QYUW3jl4RIsqknD/y4vAjGuB6x8mGR8
         oefz/2PC0x8gdbORo+AIifMgeae0C3+h0yy6bMOHTgwcnmNn5nKIWaPybz09QGcff5ff
         a6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689661227; x=1692253227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qE7RBDA3NZlKcVon5Sn7qs3jAcqHXcGJIQX6fRCgOgI=;
        b=cqamy4PxE84JOJ3xFj/biqdABz/ZNsms5eI3bDBEDAN5+2pAb129sqbCkhv8ES35iH
         XRPVtKdjiNk/+wEu+5SSuyaV1oSAMoEdDM8eYYhPDb/INxbv7J78W4c7YsuIm8bQSMdm
         ht2qEgF4buRM7iikdZtaVuh2cAWp7fg+faDwPYf82RSZuK36SvJG33gtYE1iEjHt/knK
         JjOKSUxnFnO9lW9ppbT/hX7C8J2zT7VIyTUx1aY05IvfvQL0DzC43uo7mo/cnLfBzfc9
         s9e+63SGqPeCDV+quxUB2c8zka1eV7iNjHaX4e0caYN+8JSURQ6d8yNP1Mz5sMKUjdCx
         GpPw==
X-Gm-Message-State: ABy/qLYEVlw0oRhwGZOrR+I+evaubgn7nYGbZ/19+gsEcndRZGWjMIMf
        ja+XP7ZyGxzn7UEzk/acFezFNvMCj1rZAnlgEWjbgA==
X-Google-Smtp-Source: APBJJlGcenjxAZECSDTM/FLaAFXuUpTIeakpBcDdR2YZf3kd0vIS9N3EFca1GYo0tw57yfilQ1aEMg==
X-Received: by 2002:a17:906:924b:b0:965:9602:1f07 with SMTP id c11-20020a170906924b00b0096596021f07mr1174056ejx.39.1689661227205;
        Mon, 17 Jul 2023 23:20:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m11-20020a1709062b8b00b00991bba473e1sm593563ejg.3.2023.07.17.23.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:20:26 -0700 (PDT)
Message-ID: <01f0cf88-4e85-0c92-9723-eb9198782d0d@linaro.org>
Date:   Tue, 18 Jul 2023 08:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/17] dt-bindings: gpu: Add Imagination Technologies
 PowerVR GPU
Content-Language: en-US
To:     Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org
Cc:     matthew.brost@intel.com, luben.tuikov@amd.com, conor+dt@kernel.org,
        tzimmermann@suse.de, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, afd@ti.com, robh+dt@kernel.org,
        boris.brezillon@collabora.com, dakr@redhat.com,
        donald.robson@imgtec.com, hns@goldelico.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
References: <20230714142526.111569-1-sarah.walker@imgtec.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714142526.111569-1-sarah.walker@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 16:25, Sarah Walker wrote:
> Add the device tree binding documentation for the Series AXE GPU used in
> TI AM62 SoCs.
> 

...

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpu: gpu@fd00000 {
> +        compatible = "ti,am62-gpu", "img,powervr-seriesaxe";
> +        reg = <0x0fd00000 0x20000>;
> +        power-domains = <&some_pds 187>;
> +        clocks = <&k3_clks 187 0>;
> +        clock-names = "core";
> +        interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "gpu";

Why does it differ from your DTS?

Best regards,
Krzysztof

