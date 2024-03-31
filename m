Return-Path: <linux-kernel+bounces-125989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15623892EFC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB0428218E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025608F6F;
	Sun, 31 Mar 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NR+oPERH"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD379F9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711873490; cv=none; b=FSv/s3b2QSmkX8aR5K8/zK5AcQdBYqqZJSPiRTcp47r8pVTKNgx9neQZqvq182zx1dT8OjRpZxZLu4VKQz9f/TCZZrIzYvWNToha9KaauNtm8kuBjti+ift5cDTTInVJobU9kpwb4TUVJrDyhMboC6xr3cihko/AQ9qsuR31dl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711873490; c=relaxed/simple;
	bh=ziwebkwhSCnxIB1C4DLxVo0orZIpQnMbJGWI148niXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b52HHbSy722eUjwzu+qWSG6V1HiiF2499omDnGYpgkhgawj7L9Abs8LnFaF53IaFR8KK2D2DOOuCicKNsFq+R6HslBjIDkYms8r1dIJLKlSGydWQ0tBbpE2E3aQJSx5DKrQ/Gm2LRufEvYbRhnFHF14d0RKuoxdUGuUSyNutoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NR+oPERH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33edbc5932bso2386925f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711873487; x=1712478287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LfF2AWzOpcaxDOJ1YdJ2lEu+CGC5rZNnn1Szy1XXYow=;
        b=NR+oPERH/IS4ptIg5o9MMR2zoRGwN9XamID5bHSJQ2kdkdxqtzaqVVkcQk04W0STe5
         Ki2iHVitemADVImM4Ld0DBA4ZPw2VIG+oI6voAVa8rHOfnD31sInqFMD4mO2j7c1qe+d
         CHRnzpyMJfaMbO4PbIKf3QJE9FCx//d2sOMwx2IuA19nF/cSh68WgfrfGHcNj/tSoHMs
         hFoelwCNJvizO4+sjhozdBWcp8vkac5AjiDpLsuKnNz14n586/eohKFI7hl5An9BKl2K
         0ipyuCnsMRM6+SPgzgsKgytof/8rY4U2PpbquGH2L33d/SDBkhVMXMf0hLkEPBDLc61Q
         Wg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711873487; x=1712478287;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfF2AWzOpcaxDOJ1YdJ2lEu+CGC5rZNnn1Szy1XXYow=;
        b=XRU16/4jG9/OylnDUgen8F1Ww3wvPV6vN8g/3S3ezh8t+ic26E5ajEmcMymaSLnM3d
         MWjdOynHsQBvj4R/wGJal/iVeBo5OtoVRpbIi5+jN77S1wjs5xBL+mKCxwxw2bKhC4lq
         D/tZP6h/mZ9DHjdFnou++PMz6lANbi7G42C80aG9pTCEGOis4+1US+vwQ4yIZL8BPKE4
         ObN2rlMQECv9t8FxzRxhA3Swtqy6HlbO/VhF+kXV+8XD47kCMp6mrASopM/jwl320UcX
         y1otvLGJFQENmwc7o/w+RQRskLEbrNWIBIn/MQj0xRE4QZrm+G6TUSZQ7s0fJZi/XAkh
         VW6A==
X-Forwarded-Encrypted: i=1; AJvYcCUr7kRRwuxcuiz6Zzb/uofPp6uRQC8Ve9+j3yQe/428mxdvbU/S3JyRDfo7MGWaq3mKmNCZvIBOIWiIMXZgRTNL6O070bJqcdiA1Kwl
X-Gm-Message-State: AOJu0YyL1W1EIPLsrflBNtA684SumIZaA9HCULQMygyGJjeFY5JfIFp2
	M48GE1v5z/xVJJyvTUTjgMPASvy6nIEbksT7lV1UblO5D49XVk4nlWZSC0+ZQUI=
X-Google-Smtp-Source: AGHT+IFouvjoeAD0x5HdsoICIKkc9ag1AyS8bP3QuqxCXXa5StSTtO/IFAjAFyL2wYCLYNDuygKz0Q==
X-Received: by 2002:a05:6000:1ac7:b0:341:cf94:3fce with SMTP id i7-20020a0560001ac700b00341cf943fcemr4588572wry.10.1711873486942;
        Sun, 31 Mar 2024 01:24:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h18-20020adff192000000b00341c6778171sm8343195wro.83.2024.03.31.01.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 01:24:46 -0700 (PDT)
Message-ID: <654826d6-5fd8-4876-a0a5-8738e14eb06e@linaro.org>
Date: Sun, 31 Mar 2024 10:24:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dt-bindings: clock: rockchip: Add support for clk
 input / output switch
To: Sugar Zhang <sugar.zhang@rock-chips.com>, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1711340191-69588-1-git-send-email-sugar.zhang@rock-chips.com>
 <1711340191-69588-2-git-send-email-sugar.zhang@rock-chips.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1711340191-69588-2-git-send-email-sugar.zhang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 05:16, Sugar Zhang wrote:
> This patch add support switch for clk-bidirection which located

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> at GRF, such as SAIx_MCLK_{IN OUT} which share the same pin.
> and these config maybe located in many pieces of GRF,
> which hard to addressed in one single clk driver. so, we add
> this simple helper driver to address this situation.
> 
> In order to simplify implement and usage, and also for safety
> clk usage (avoid high freq glitch), we set all clk out as disabled
> (which means Input default for clk-bidrection) in the pre-stage,
> such boot-loader or init by HW default. And then set a safety freq
> before enable clk-out, such as "assign-clock-rates" or clk_set_rate
> in drivers.
> 
> e.g.
> 
> 1. mclk{out,in}_sai0 define:
> 
>   mclkin_sai0: mclkin-sai0 {
>       compatible = "fixed-clock";
>       #clock-cells = <0>;
>       clock-frequency = <12288000>;
>       clock-output-names = "mclk_sai0_from_io";
>   };
> 
>   mclkout_sai0: mclkout-sai0@ff040070 {
>       compatible = "rockchip,clk-out";
>       reg = <0 0xff040070 0 0x4>;
>       clocks = <&cru MCLK_SAI0_OUT2IO>;
>       #clock-cells = <0>;
>       clock-output-names = "mclk_sai0_to_io";
>       rockchip,bit-shift = <4>;
>       //example with PD if reg access needed
>       power-domains = <&power RK3562_PD_VO>;
>   };
> 
> Note:
> 
> clock-output-names of mclkin_sai0 should equal to strings in drivers. such as:
> 
> drivers/clk/rockchip/clk-rk3562.c:
> PNAME(clk_sai0_p) = { "clk_sai0_src", "clk_sai0_frac", "xin_osc0_half", "mclk_sai0_from_io" };
> 
> 2. mclkout_sai0 usage:
> 
>   &ext_codec {
>       clocks = <&mclkout_sai0>;
>       clock-names = "mclk";
>       assigned-clocks = <&mclkout_sai0>;
>       assigned-clock-rates = <12288000>;
>       pinctrl-names = "default";
>       pinctrl-0 = <&i2s0m0_mclk>;
>   };
> 
>   clk_summary on sai0 work:
> 
>   cat /sys/kernel/debug/clk/clk_summary | egrep "pll|sai0"
> 
>   clk_sai0_src                1        1        0  1188000000          0     0  50000
>     clk_sai0_frac             1        1        0    12288000          0     0  50000
>       clk_sai0                1        1        0    12288000          0     0  50000
>         mclk_sai0             1        1        0    12288000          0     0  50000
>           mclk_sai0_out2io    1        1        0    12288000          0     0  50000
>             mclk_sai0_to_io   1        1        0    12288000          0     0  50000
> 
>   example with PD if reg access needed:
> 
>   * PD status when mclk_sai0_to_io on:
> 
>   cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> 
>   domain                          status          children
>     /device                                                runtime status
>   ----------------------------------------------------------------------
>   ...
> 
>   vo                              on
>     /devices/platform/clocks/ff040070.mclkout-sai0         active
>   ...
> 
>   * PD status when mclk_sai0_to_io off:
> 
>   cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> 
>   domain                          status          children
>     /device                                                runtime status
>   ----------------------------------------------------------------------
>   ...
> 
>   vo                              off-0
>     /devices/platform/clocks/ff040070.mclkout-sai0         suspended
>   ...
> 
> 3. mclkin_sai0 usage:
> 
>   please override freq of mclkin as the real external clkin, such as:
> 
>   &mclkin_sai0 {
>       clock-frequency = <24576000>;
>   }
> 
>   &ext_codec {
>       clocks = <&mclkin_sai0>;
>       clock-names = "mclk";
>       assigned-clocks = <&cru CLK_SAI0>;
>       assigned-clock-parents = <&mclkin_sai0>;
>       pinctrl-names = "default";
>       pinctrl-0 = <&i2s0m0_mclk>;
>   };
> 
>   clk_summary on sai0 work:
> 
>   cat /sys/kernel/debug/clk/clk_summary | egrep "pll|sai0"
> 
>   mclk_sai0_from_io          1        1        0    12288000          0     0  50000
>     clk_sai0                 1        1        0    12288000          0     0  50000
>       mclk_sai0              1        1        0    12288000          0     0  50000
>         mclk_sai0_out2io     0        0        0    12288000          0     0  50000
>           mclk_sai0_to_io    0        0        0    12288000          0     0  50000

None of this long commit msg is a description of hardware. Please remove
all unnecessary information and instead describe the problem you are
solving or the hardware.

> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  .../bindings/clock/rockchip,clk-out.yaml           | 107 +++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml b/Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml
> new file mode 100644
> index 0000000..6582605
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,clk-out.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Clock Out Control Module Binding

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> +
> +maintainers:
> +  - Sugar Zhang <sugar.zhang@rock-chips.com>
> +
> +description: |
> +  This add support switch for clk-bidirection which located

No, "this does not add". This is description of hardware, thus describe
hardware.

> +  at GRF, such as SAIx_MCLK_{IN OUT} which share the same pin.
> +  and these config maybe located in many pieces of GRF,
> +  which hard to addressed in one single clk driver. so, we add
> +  this simple helper driver to address this situation.

Bindings are for hardware, not drivers. Rephrase EVERYTHING to focus on
hardware, not driver. Otherwise it looks like you wrote it for drivers,
which is a NAK.

> +
> +  In order to simplify implement and usage, and also for safety
> +  clk usage (avoid high freq glitch), we set all clk out as disabled
> +  (which means Input default for clk-bidrection) in the pre-stage,
> +  such boot-loader or init by HW default. And then set a safety freq
> +  before enable clk-out, such as "assign-clock-rates" or clk_set_rate
> +  in drivers.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,clk-out

Missing SoC compatible. See writing bindings.


> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: parent clocks.

Drop useless description.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  rockchip,bit-shift:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Defines the bit shift of clk out enable.

No, this is deduced from compatible.

> +
> +  rockchip,bit-set-to-disable:
> +    type: boolean
> +    description: |
> +      By default this clock sets the bit at bit-shift to enable the clock.
> +      Setting this property does the opposite: setting the bit disable
> +      the clock and clearing it enables the clock.

No, this is deduced from compatible.

Binding looks really poor, like written for some debug driver.


> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#clock-cells"
> +  - clock-output-names
> +  - rockchip,bit-shift
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock Provider node:
> +  - |
> +    mclkin_sai0: mclkin-sai0 {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <12288000>;
> +        clock-output-names = "mclk_sai0_from_io";
> +    };

Drop, unrelated.

> +
> +    mclkout_sai0: mclkout-sai0@ff040070 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +        compatible = "rockchip,clk-out";
> +        reg = <0 0xff040070 0 0x4>;
> +        clocks = <&cru MCLK_SAI0_OUT2IO>;
> +        #clock-cells = <0>;
> +        clock-output-names = "mclk_sai0_to_io";
> +        rockchip,bit-shift = <4>;
> +    };
> +
> +  # Clock mclkout Consumer node:
> +  - |
> +    ext_codec {

Drop, not related, incorrect name.

> +        clocks = <&mclkout_sai0>;
> +        clock-names = "mclk";
> +        assigned-clocks = <&mclkout_sai0>;
> +        assigned-clock-rates = <12288000>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&i2s0m0_mclk>;
> +    };
> +
> +  # Clock mclkin Consumer node:
> +  - |
> +    ext_codec {

Drop.

Don't upstream poor quality downstream code, but fix it first to match
upstream style. Read carefully writing bindings and DTS coding style.



Best regards,
Krzysztof


