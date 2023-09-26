Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208EE7AED8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjIZNB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjIZNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:01:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B73101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:01:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40535597f01so87327925e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695733277; x=1696338077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MS7T5qNcaaAtsXyLYljAh+1Xxln9bcBRkmzw4oED08Y=;
        b=M8L9LXTkDz+7332Nfeu+v1GxqrkptjhEGYXwCpVTXVZhfgf/Pb9rEcIb8u/7B+n9fY
         h8/9Tda3aP0Hp0QRA+OA4d9sa2P9XuDRCUWcu+iEOWUK93JOHoFpkpRE/EcwbYeOYPAx
         B6XUdlK8GoFDCXTvJTQ5iyCiJjDgcCcLPaEVdRLywhW1N2FGOkC+5xYIrIRgwY7/2hal
         Ork/wpFt/OPksXcVETJb4fv3FjEq8LYlBBcTuaEHnZ4qBgomyJ1mfCiexrxF4atXfb6i
         o1pDOumELs5vTzhFO+7YKV8GGOgdZ5Q7rSPbQH5xh7IAXyIXBBdGKu4D9zGDzKuVlJ5c
         WhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733277; x=1696338077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS7T5qNcaaAtsXyLYljAh+1Xxln9bcBRkmzw4oED08Y=;
        b=l8INH6mEpn2andfzFIoXbwul1/iG3KnnKdNMnrK8Dqta98aXh1C8utNm5pXKABEEY8
         RkUr6uJlCbcp4QfhlEz+sGatKfmLULUMMWscQZJ3nW2zjJRdMAh72gHJJ7+vkPfbQ2NZ
         Ac/IbIuySumuL9ZA1cIdNiOJVZuepsLwW990K+IjitJhBubeYgSbBvhf+L4B/8wBeOwU
         HMtpT0U7QXIbiK/o+0v2UWqXgkrYT07rnIKAaiEiWrMQJTl5i/dE/va5sejGh2raqzsC
         t+WEAlFjLCjBBex1UNzVAZVZjKhfJbWjpPe8G4a7oUInhOZ5UtHKu9ZJgZMis+fVEAPM
         8NVA==
X-Gm-Message-State: AOJu0Yw9YCqBo8I2qS/2WEMRZoieaRBC49czz3LGFbHfREpnYCjpwNRA
        1iKIpVx9PX1OGVf0poEfHIXn4g==
X-Google-Smtp-Source: AGHT+IHQuRtjXPocWtmNLqUsEHc9Fm36NC/aEQcNjyXW9d+4nNeVH9BfrSCCtcERycCPCpPfFQ8z1Q==
X-Received: by 2002:a05:600c:3658:b0:3f6:9634:c8d6 with SMTP id y24-20020a05600c365800b003f69634c8d6mr8513184wmq.18.1695733276393;
        Tue, 26 Sep 2023 06:01:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm693730wrn.114.2023.09.26.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:01:15 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:01:13 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: Add MPS MP3309C
Message-ID: <20230926130113.GB4356@aspen.lan>
References: <20230925122609.78849-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925122609.78849-1-f.suligoi@asem.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 02:26:08PM +0200, Flavio Suligoi wrote:
> The Monolithic Power (MPS) MP3309C is a WLED step-up converter, featuring a
> programmable switching frequency to optimize efficiency.
> The brightness can be controlled either by I2C commands (called "analog"
> mode) or by a PWM input signal (PWM mode).
> This driver supports both modes.
>
> For device driver details, please refer to:
> - drivers/video/backlight/mp3309c_bl.c
>
> The datasheet is available at:
> - https://www.monolithicpower.com/en/mp3309c.html
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>
> v3:
>  - add default value for mps,overvoltage-protection-microvolt property
>  - fix the example, changing from "mps,mp3309c-backlight" to "mps,mp3309c" in
>    compatible property
> v2:
>  - remove useless properties (dimming-mode, pinctrl-names, pinctrl-0,
>    switch-on-delay-ms, switch-off-delay-ms, reset-gpios, reset-on-delay-ms,
>    reset-on-length-ms)
>  - add common.yaml#
>  - remove already included properties (default-brightness, max-brightness)
>  - substitute three boolean properties, used for the overvoltage-protection
>    values, with a single enum property
>  - remove some conditional definitions
>  - remove the 2nd example
> v1:
>  - first version
>
>  .../bindings/leds/backlight/mps,mp3309c.yaml  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
> new file mode 100644
> index 000000000000..4191e33626f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/mps,mp3309c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MPS MP3309C backlight
> +
> +maintainers:
> +  - Flavio Suligoi <f.suligoi@asem.it>
> +
> +description: |
> +  The Monolithic Power (MPS) MP3309C is a WLED step-up converter, featuring a
> +  programmable switching frequency to optimize efficiency.
> +  It supports two different dimming modes:
> +
> +  - analog mode, via I2C commands (default)
> +  - PWM controlled mode.
> +
> +  The datasheet is available at:
> +  https://www.monolithicpower.com/en/mp3309c.html
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: mps,mp3309c
> +
> +  reg:
> +    maxItems: 1
> +
> +  pwms:
> +    description: if present, the backlight is controlled in PWM mode.
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: GPIO used to enable the backlight in "analog-i2c" dimming mode.
> +    maxItems: 1
> +
> +  mps,overvoltage-protection-microvolt:
> +    description: Overvoltage protection (13.5V, 24V or 35.5V).
> +    enum: [ 13500000, 24000000, 35500000 ]
> +    default: 35500000
> +
> +  mps,no-sync-mode:
> +    description: disable synchronous rectification mode
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - max-brightness

Why is this mandatory?

There's no point in setting max-brightness when running in I2C mode
(max-brightness should default to 31 in that case).


> +  - default-brightness

Again. I'm not clear why this needs to be mandatory.


Daniel.
