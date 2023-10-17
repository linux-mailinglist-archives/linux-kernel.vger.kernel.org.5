Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037317CC959
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbjJQRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQRB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:01:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6225BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:01:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b9faf05f51so912187066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697562085; x=1698166885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dCbFI8/hJKUj+ad2n9M8RPpYFsoFt09ySpeSzWAUjg=;
        b=vgEag2u+VomgOjH9f1YSAWkbK4eFTBWIljpfhioKLhd6rLT+vLVDTZCu6B8tc32+Jt
         wsfJKE0bw//uwSwrRfpetWio2GFPBT9VSKPM2UrLoNVRVbvM3DkVd8RuwMRaGBhTMVRd
         rBwtgk4N03WonU8FClGbF4ADUdju7enqvaDGtOiLFUGhhmkwQ1f3FSxxmwKMGfzkE9OD
         xHl96eSoLks5TECDZHKmPu5ERBZ9E6pfJjrfZj8z7ekVzwCHGwmpTFhQ9DEOVjJzB6zC
         7dm99kwG55Kj8pruzTTgb4K/fnTPP8ofOV4jNLCHciLq83yM+flFW5JkOFrS6vMJBocS
         fOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562085; x=1698166885;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dCbFI8/hJKUj+ad2n9M8RPpYFsoFt09ySpeSzWAUjg=;
        b=E+9u5e8Rgi3/mMmQlaWen+4K7nOVcfC6wihWPs8K9bIbL1LkqFv+z9nbnP44NfsdTk
         Z0jTJShZzD++weBEy+wiR1Hh4Ad/U0Ar8+vIGQKGpq7tCiMg23MQ/6LKUY+hncas7Kaq
         AP9eWQCciQFNM9qaBiydFHVtuqBPaPvQjfRMDTAm8eOR2GUBrICbRCiIFOqSmb8hojVL
         WuT/OT+DEk24gIHl4WVbP1S7YQNf4Sn1R3KoYbc0tr3czKBjNLYw3fo7xy7r1lI+d8mh
         D7BGX/u156dguSzIElbI8miAjrnr756Sz4X0W0yoFnP3QMiMQTSjqy9veF5BCgcO2Uqi
         mLFg==
X-Gm-Message-State: AOJu0YwPpcN8tgMVsiHNjjirbgtgPYHDRS1YDLFeK2Wn+RUCrlg839Px
        PaUwIOL3GaJ8wL5v4TVhaQXbTg==
X-Google-Smtp-Source: AGHT+IEuVqprcZXsUObhszNBpu2NWjMMxUwaYaLozqOLmhg8gXaL7IZfxXuMhDsuSDXCdO8QPV9ACA==
X-Received: by 2002:a17:907:268c:b0:9ba:65e:750e with SMTP id bn12-20020a170907268c00b009ba065e750emr1968560ejc.32.1697562085211;
        Tue, 17 Oct 2023 10:01:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090624d200b009adc77fe165sm128227ejb.118.2023.10.17.10.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:01:24 -0700 (PDT)
Message-ID: <dd47ff4f-bea8-4091-b572-5bef4aa187d3@linaro.org>
Date:   Tue, 17 Oct 2023 19:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] HID: touchscreen: Add initial support for Himax
 HID-over-SPI
Content-Language: en-US
To:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
 <20231017091900.801989-3-tylor_yang@himax.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231017091900.801989-3-tylor_yang@himax.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 11:18, Tylor Yang wrote:
> The hx83102j is a TDDI IC (Touch with Display Driver). The
> IC using SPI to transferring HID packet to host CPU. The IC also
> report HID report descriptor for driver to register HID device.
> The driver is designed as a framework for future expansion and
> hx83102j is the first case. Each hx_spi_hid_hx8xxxxx modules are
> mutual exclusive, it should be initiate one at a time.
> 
> This driver takes a position similar to i2c-hid, it initialize
> and control the touch IC below and register HID to upper hid-core.
> When touch ic report an interrupt, it receive the data from IC
> and report as HID input to hid-core. Let hid-core dispatch input
> to registered hid-protocol and report to related input sub-system.
> 
> This driver also provide advanced functions by hidraw interface:
> - runtime firmware update
> - debug functions, such as reg r/w
> - self test for touch panel
> 
> Due to patch size is too big, separate into 3 part. This is part 1.
> 
> Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> ---
>  MAINTAINERS                       |    1 +
>  drivers/hid/hx-hid/hx_acpi.c      |   81 ++
>  drivers/hid/hx-hid/hx_core.c      | 1605 +++++++++++++++++++++++++++++
>  drivers/hid/hx-hid/hx_core.h      |  489 +++++++++
>  drivers/hid/hx-hid/hx_hid.c       |  753 ++++++++++++++
>  drivers/hid/hx-hid/hx_hid.h       |   96 ++
>  drivers/hid/hx-hid/hx_ic_83102j.c |  340 ++++++
>  drivers/hid/hx-hid/hx_ic_83102j.h |   42 +
>  8 files changed, 3407 insertions(+)
>  create mode 100644 drivers/hid/hx-hid/hx_acpi.c
>  create mode 100644 drivers/hid/hx-hid/hx_core.c
>  create mode 100644 drivers/hid/hx-hid/hx_core.h
>  create mode 100644 drivers/hid/hx-hid/hx_hid.c
>  create mode 100644 drivers/hid/hx-hid/hx_hid.h
>  create mode 100644 drivers/hid/hx-hid/hx_ic_83102j.c
>  create mode 100644 drivers/hid/hx-hid/hx_ic_83102j.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 883870ab316f..95ea8159eced 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9345,6 +9345,7 @@ M:	Tylor Yang <tylor_yang@himax.corp-partner.google.com>
>  L:	linux-input@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/input/himax,hid.yaml
> +F:	drivers/hid/hx-hid/
>  
>  HIMAX HX83112B TOUCHSCREEN SUPPORT
>  M:	Job Noorman <job@noorman.info>
> diff --git a/drivers/hid/hx-hid/hx_acpi.c b/drivers/hid/hx-hid/hx_acpi.c
> new file mode 100644
> index 000000000000..2dc7c611a61a
> --- /dev/null
> +++ b/drivers/hid/hx-hid/hx_acpi.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  Himax Driver Code for Common IC to simulate HID
> + *
> + *  Copyright (C) 2023 Himax Corporation.
> + *
> + *  This software is licensed under the terms of the GNU General Public
> + *  License version 2,  as published by the Free Software Foundation,  and
> + *  may be copied,  distributed,  and modified under those terms.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.

Drop boiler plate. It's gone since some years. Having it here suggests
you just push downstream crappy code. Please don't. Start from scratch
taking existing driver.

> + */
> +
> +#include "hx_core.h"
> +
> +int himax_parse_acpi(struct device *dev,
> +		     struct himax_platform_data *pdata)
> +{
> +	int ret = 0;
> +	struct gpio_desc *desc;
> +	const u32 interrupt_pin_idx = 0;
> +	// const u32 reset_pin_idx = 1;
> +	const char *interrupt_pin_dsd_name = "irq"; // to name "irq-gpios"
> +	const char *reset_pin_dsd_name = "reset"; // to name "reset-gpios"

This style, dead code, comments is not a Linux coding style.

> +
> +	D("Entered");

OK, I'll finish review. A lot further looks even worse. This is not code
suitable for inclusion in mainline. Please start from scratch from
existing code and customize it per your needs. This way you will keep
Linux coding style instead introducing some totally different coding
style from downstream, terrible quality driver.

Best regards,
Krzysztof

