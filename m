Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92903771233
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjHEUwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHEUw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:52:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D983272A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 13:52:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso5614025e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691268746; x=1691873546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMZ57FK/F5HfkVLTGQC4S3eZbwmC8Kg8tkKbLHOwgJU=;
        b=fQ7k4sBnsoIVWX6Rccv2pmzsDjUrD/hEX4hi511Qfd3ayuvEJSt89N1Cx89fNbVVIP
         yswyuL/YaHHd+5EHc7en9iiCw4R863j9HG3ZwIp0vRJTgdr0RzeoS7Fg890uvNHJjWHl
         G7Y84XNGZymtnnJcnUqWYYCgVcjcGnQOqQJ8WBkFcenFclZ7AxkEZjMvoFYLXO3BX4XH
         1rlSUhq+PNdVtF0LcmqlnsfeDU2GgwEodBbsT00V9yNcNjMcfgjbt1QAqMEOJ8Q8r5Mp
         GknRHJlbEAZOh4DzXjyo95/PqocXP0v4EkrYDjPP2Rm5vcpEmhPR+ibwzGbdN8KNeQBE
         4zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691268746; x=1691873546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMZ57FK/F5HfkVLTGQC4S3eZbwmC8Kg8tkKbLHOwgJU=;
        b=YvF4pfz1BfsLpmt0GBC40eTogvoA9B/bNhjQZWQ7qw8FDuWfayHyP4fJob5jwFm9Qt
         n2rpzhmQ38iigOIwhGaWIUdQzxi/GvdfZHD5H4Wn7zRY2XYrSDar3phvTtPc23pwQ6V5
         qgwEvIvzLO4hJJzaF9iV9uxeoAeUtNqG6JKZDOy5J0SD+e3w/deR9MitBs7RhZRxgRsK
         WXdFRyu3AvLq1ew2NNyvKlCPiOPefVZifSnMjPEa0P8CWJDvuNLWklmEX41gNlxHwukx
         iRP9RZzumZAVLkWOvlpJBa/a7R/ZmcrLPHVV0qj2Q/dt8u5ytlJu9FSbGk5we87DWtRb
         24Kw==
X-Gm-Message-State: AOJu0Yz2m6m7N6hgkLjbhNYQPasaFQPasPwsMZIfI3uO1SpNhI3aqzJv
        nHw8HERMzbMle6AF1PBNAzd6y+PaJRbsw1s5PeI=
X-Google-Smtp-Source: AGHT+IGlrHt+sxR7RnSvkI2RJnZZ+LB3aM9gw03DbVGz3kyVX5ECy+z4K5V6A9++7KFbnt6QeCDAsA==
X-Received: by 2002:a05:600c:3794:b0:3fe:2102:8085 with SMTP id o20-20020a05600c379400b003fe21028085mr3690414wmr.8.1691268745782;
        Sat, 05 Aug 2023 13:52:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id l12-20020adff48c000000b0030ada01ca78sm5946071wro.10.2023.08.05.13.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 13:52:25 -0700 (PDT)
Message-ID: <609d5c1d-4ef7-22d5-d951-f32dbe410906@linaro.org>
Date:   Sat, 5 Aug 2023 22:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje.mihanovic@skole.hr>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
References: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
 <20230804-pxa1908-lkml-v3-3-8e48fca37099@skole.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230804-pxa1908-lkml-v3-3-8e48fca37099@skole.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 15:32, Duje Mihanović wrote:
> Add dt bindings and documentation for the Marvell PXA1908 clock
> controller.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>


> +++ b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2

...

> +examples:
> +  # APMU block:
> +  - |
> +    clock-controller@d4282800 {
> +      compatible = "marvell,pxa1908-apmu";
> +      reg = <0xd4282800 0x400>;
> +      #clock-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/marvell,pxa1908.h b/include/dt-bindings/clock/marvell,pxa1908.h
> new file mode 100644
> index 000000000000..1fff3bcefd21
> --- /dev/null
> +++ b/include/dt-bindings/clock/marvell,pxa1908.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */

Any particular reason to use different BSD-3 than bindings? Not easy to
spot this difference...

Best regards,
Krzysztof

