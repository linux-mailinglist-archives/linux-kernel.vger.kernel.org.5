Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE25F7BF683
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjJJIwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJJIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:52:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CAEC6;
        Tue, 10 Oct 2023 01:52:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c008042211so65470261fa.2;
        Tue, 10 Oct 2023 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696927950; x=1697532750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeEaic7DEAY9zd0WyuqM/4JYbRdrtkfWh/cZqj1+uHU=;
        b=NvikLWBBYBXGNzOZWvhhwrwfiW0JOpSCaPjmSJGCOdN3ybiGq9SmTi4b2w6DK6s/md
         VayrGSrom8RctkAPXOC63W/VEqIGyAYlAoDlbSy350hxFvLTpMS3w3L7k/TQ4a0M1igO
         wUorzM8pSh3PHyhZ1tLLjkJmA28jtjv+LI+9pmCmcuL4THPvkCDT4lWMu9TQtmQ8lvov
         c7x60rtJWN4x3o+fCBnbAMb9tq1i4gZ5UJEjkR3DIPbb8Ard3+wm/fpRo/oqjRrXOOMh
         CUOdbvvSht15Rf1UqcW/qmud7sXupjwV+V1Ck7wSUgcQnb8BF0DU9SeYNPbHPPGlb0Wm
         9XZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696927950; x=1697532750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeEaic7DEAY9zd0WyuqM/4JYbRdrtkfWh/cZqj1+uHU=;
        b=Dhq2Jz/kKfyXvUDEhKBslwbNKI50qMCn9NIeFOc5cBl7Yc40jQvR7Cp9XdFc98IGQ8
         9QjD+6sPfM5SScr789boVqQRwWeBGLGHmc1vUM+j/YxDpNiAsB6U2RcQe6z6WQ25CqGu
         9MVTpSyDPpcjTpYpBxloyiqVV+IOMVApHGipVNhK2P9oq1CnxNzVVImOnCgutX3nDWIh
         05thSEBYFMNDTiqgWnmrUdHbWOWbDm5HrN2X2QMsOK/V63ef/hanjksVo7dNUbCq2WQB
         UB9OvgaciZdcrvUMENcXOQzaBLdFFDqRuQWyLAaNQWjMuIJa5RNkrZoh48tEOa0r/OqJ
         6wTw==
X-Gm-Message-State: AOJu0YyXrPNOL/aGr/t2BTgmqkoRRjQS8GuHmv2WjG5ftV3zaW4CJi3T
        Pioovtd4/5PY1+JQp/6lV8o=
X-Google-Smtp-Source: AGHT+IFRDeEjYXjaBWFWXr0sryFJAu3lGH0OBSOOIm/FGuRn05jaZpgsOGgCZmg/jBQkRmA66inhew==
X-Received: by 2002:a2e:870f:0:b0:2b6:da1e:d063 with SMTP id m15-20020a2e870f000000b002b6da1ed063mr14278324lji.45.1696927950311;
        Tue, 10 Oct 2023 01:52:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id r25-20020a2e9959000000b002bfba0d26bcsm2368605ljj.8.2023.10.10.01.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 01:52:29 -0700 (PDT)
Message-ID: <2c6ff28f-9031-beb2-f8d0-e7f12b0a07b4@gmail.com>
Date:   Tue, 10 Oct 2023 11:52:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US, en-GB
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/23 18:48, Subhajit Ghosh wrote:
> Add devicetree bindings for Avago APDS9306 Ambient Light Sensor.
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
>   .../bindings/iio/light/avago,apds9306.yaml    | 49 +++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> new file mode 100644
> index 000000000000..e8bb897782fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/avago,apds9306.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Avago APDS9306 Ambient Light Sensor
> +
> +maintainers:
> +  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> +
> +description:
> +  Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> +
> +properties:
> +  compatible:
> +    const: avago,apds9306

I see the driver supports two different variants of this IC, 
differentiated by the part-ID register. Variants are named as apds9306 
and apds9306-065. I wonder if we could/should have different compatibles 
for them?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

