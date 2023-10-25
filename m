Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9F7D6361
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJYHgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjJYHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:35:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430C31FCE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:33:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c75ceea588so758793066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219236; x=1698824036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cD2hXX3GzUspC3BzaYEWKh3UNBXjrDSFqzk24IPdeY=;
        b=Lsg+ZYbWKKPq2YjkeFBzwwPgiT+BoqSsApWs9lHv9LxfW6CuivJNEy19HYRCbYs8i+
         hTr/tm+L8fR1YJJ7gc6geoetcMuZDxfK2YIxCKUtHZU0Omg91NihCKM6CzR9HSiU30cG
         8HlVU/BWmZCTYdG/U/2BJQSZRIlj1Le9oQdLnj4kvVmQfXWhA+nB/9bWDn9NclNmoZw1
         ebMmV9DtRdVCDzAkN4BFAlTO+SdEv7y4p7OP2kn2AbpPiwL65I+S7zPaI8dpabDvruQQ
         TmTG9w9nmvCwiX/bcer1L2IzUvIhMALOpOEMHBz9Qtrx+jLEW8ByFH2YvQwARhZ8JLi+
         oNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219236; x=1698824036;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cD2hXX3GzUspC3BzaYEWKh3UNBXjrDSFqzk24IPdeY=;
        b=Vryr7yg14kWB8BJ2WVgHgWJnwrn1MbMEhB22bcWMkoIzRNnl8KrfrI8heq/L2s5g/R
         xy8/6xCZo50ZGCJz3bkdGsU4V3VJBodfm1B6T5y0T4bXBD0S+UVzVzgjQZy3fDtgCvr0
         OrbSfSPAG7K5iYWKQ1VooVZH/x1gKTSaDZ8wIk/L3/q4WJK5+IC0FB0S7ZtH/mCTWPJ2
         lA3HmHVdj3UaHUpv3YuOUMfLgjkRV8KU27uRmCBIzA58tYt03BrtAcfLYhqy+FpY5Vik
         sRXPuPYX4jsG2NEz3mWbWNo1QOTWkOp9CUiwrhzpjo3fwz8esfhxsYx+Z1FZQfx59oxl
         XK6Q==
X-Gm-Message-State: AOJu0YwUltIzk3Xq2oc2vw5SrxXPtoIyjqbCZ5BuVrZEdvtL8+DhbpsT
        XPv1cJdy1N7gApJj2Kh2pJewcw==
X-Google-Smtp-Source: AGHT+IHlWNvHarQlKKwAmXAjYwq5SwbCNmt5BgoWmpiRV9qnVoPrfvPf6oeHI0Pl2Lxx+23bMIQedg==
X-Received: by 2002:a17:907:928c:b0:9be:6050:7f1b with SMTP id bw12-20020a170907928c00b009be60507f1bmr10491010ejc.0.1698219236563;
        Wed, 25 Oct 2023 00:33:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id gy5-20020a0564025bc500b0053d9cb67248sm8846790edb.18.2023.10.25.00.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 00:33:56 -0700 (PDT)
Message-ID: <a6b6567c-a6cc-43e5-8aea-a875e5a918ff@linaro.org>
Date:   Wed, 25 Oct 2023 09:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: dts: cn913x: add device trees for COM
 Express boards
Content-Language: en-US
To:     Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231025073150.2826130-2-enachman@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231025073150.2826130-2-enachman@marvell.com>
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

On 25/10/2023 09:31, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add support for CN9130 and CN9131 COM Express Type 7 CPU
> module boards (SOM boards) by Marvell.
> Define these COM Express CPU modules / SOMs as dtsi, and
> provide a dts file for a carrier board (Marvell AC5X RD
> COM Express type 7 carrier board).
> This Carrier board only utilizes the PCIe link, hence no
> special device / driver support is provided by this dts file.
> 
> These boards differ from the existing CN913x DB boards by the type
> of ethernet connection (RGMII), the type of voltage regulators
> (not i2c expander based) and the USB phy (not UTMI based).
> CN9131 COM Express board is basically CN9130 COM Express board
> with an additional CP115 I/O co-processor, which in this case
> provides an additional USB host controller on the board.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../boot/dts/marvell/ac5x_rd_carrier.dts      |  23 ++++
>  .../dts/marvell/cn9130-db-comexpress.dtsi     | 101 ++++++++++++++++
>  .../dts/marvell/cn9131-db-comexpress.dtsi     | 113 ++++++++++++++++++
>  4 files changed, 238 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/marvell/ac5x_rd_carrier.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 79ac09b58a89..b0a2347200ef 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -26,4 +26,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += ac5x_rd_carrier.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
> diff --git a/arch/arm64/boot/dts/marvell/ac5x_rd_carrier.dts b/arch/arm64/boot/dts/marvell/ac5x_rd_carrier.dts
> new file mode 100644
> index 000000000000..4b2cf417332f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/ac5x_rd_carrier.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 Marvell International Ltd.
> + *
> + * Device tree for the AC5X RD Type 7 Com Express carrier board,
> + * Utilizing the CN913x COM Express SOM board.
> + * This specific board only maintains a PCIe link with the CPU SOM
> + * module, which does not require any special DTS definitions.
> + */
> +
> +#include "cn9131-db-comexpress.dtsi"
> +
> +/ {
> +	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board";
> +	compatible = "marvell,cn9131", "marvell,cn9130",
> +		     "marvell,armada-ap807-quad", "marvell,armada-ap807";

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

I asked to document this in the bindings.

Also, compatibles do not look right. You called the board AC5X RD but
compatible is CN9131.

Best regards,
Krzysztof

