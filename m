Return-Path: <linux-kernel+bounces-70740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF61859BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DEE282798
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC71F958;
	Mon, 19 Feb 2024 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4vojcHJ"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17D33C0;
	Mon, 19 Feb 2024 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708321291; cv=none; b=XEr9AkYIcOvTR8ppD/pzlh6sczH2WBouRpwaZXSywqcsQpAHKAdmk9XohczP0w9eIVVDCsM8OfV0UUFPliDcRdhDcg/pjBb0F7uU2EWPLydbcViboDemTYPMliCrzxwSxvK4lH4TUQROZ2W+DQLxJMsEF/PufkARUSJOwdtGp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708321291; c=relaxed/simple;
	bh=8mEJQgrUvxiuH5nR2L9KBll39m4IslQHc7+DMvdhRgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZPHgQ690gpS7sS7Q33PybAdJLF4823LkacsKi/vLHS9D3/49tU2G/bD/Vq6E49X79I2BtJzS8iaOX7azclolIeqzg7SCTMXr+ixlSuOvkNbP5gGnSKauUxrwbYp+5Ky0cKMRMxhtA2I/eSezD4tsaBk1PQMm3n4xWuCcTgHr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4vojcHJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c135913200so1787268b6e.1;
        Sun, 18 Feb 2024 21:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708321289; x=1708926089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dINrekbO9OyEoiamG9kRG6vqUkZ7GX4ftWbHSVqA3UE=;
        b=E4vojcHJZ5PqM1yqD1gV4IEfBX/D1V1bATJ6P/MCdAZAG+8jjy6gDmzo+kX4SZWkNg
         A/aSQzKrsdTpFHp6m1rH7shfPa3V4DAFu5tNnjcosKUGW5aftBQNMbfRNg5eqwfKJTG9
         0jqK2OwLoAt5G2B/e9AKEpvlLE+gomaiGJyndUgVxkWjVD8ajhou1X4vMT8vwGAeqPvt
         QCNo/K958qRVgp0sU9VhMX4qmRKDOsrTy7gg+FJ7rQ+fElHlMTpLZGL2cJxkYhx0XlX5
         cL03IBSmhuNibSruZRZSd2oqQ3BxSTqP/p2flHzvCJyk0y/7eCUWef9yZExP1fxhOubm
         RrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708321289; x=1708926089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dINrekbO9OyEoiamG9kRG6vqUkZ7GX4ftWbHSVqA3UE=;
        b=Q4z0rRbeMX/nundMSoeekWw/Zs8Vpq6A76oDVtd0U1T2O1zExefPaWNkWYUYJ4Xte5
         jXZckCPraAgHI0iBSGvB/eUDNMni0pmgzujlQ0KNNh5j2zh/oQL4Ioht7Y4aGJxsu1Hw
         Vi222RnvTGFuORYFDoEV98UiAAFVf6gN5dcglICY05FbWQuPc9DDUMnDAExT2IXX/wWY
         UCZ+yy+Ze5JxzftPgUSV9Rrxe6FNxqRGrMyOreSdcKDNE1hmtPparTMD/mnK6Zxv+E0J
         qoQPS4bnFBBUsW/ksEczx64lfTkFs2qENCrxwpdoNxltfGx2YCzPmvWS3HxBobzobqw0
         KgAg==
X-Forwarded-Encrypted: i=1; AJvYcCUPu/c27LsKiHmviFkI90ZAqAMIfuxEYNVXPvom5nb9FfX9+1OizGInEmEX6z+lytLI/iNVr6u9haxwXsOVMxy4/IOXbms9BxOmF/LkiCtBO5SgxH1E6fa4azEeoV28mGrgRcZFk9ApDvbf75DPQMScQD7Gphjv9kx3/eGBOoiB6tQPlsKGL1Ok
X-Gm-Message-State: AOJu0Yz7F3BdlmvBDJigaFXSigz7opWcWGbQj+cV3q2sNIGktzY4hJ3t
	SrgytYZsmvbuWxNXmfr30nQFAlZvBeL2Da8pJnxxf+r0kZhzYVCWJ/JoWdhJ5lrS1angLcPKOzd
	RaAZM3cyuDoZF6UoRwhJQBYz3zEc=
X-Google-Smtp-Source: AGHT+IH240GseuofeGUUGoETnTg17gf1crOfxs6ekv2X5XnZiWsZ5Hl1SqxYsjbhiiDRX63D86bTP4RysYJCr6YOiQI=
X-Received: by 2002:a05:6870:f154:b0:21e:9c76:9578 with SMTP id
 l20-20020a056870f15400b0021e9c769578mr5200551oac.21.1708321288855; Sun, 18
 Feb 2024 21:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdDUlGdqH7Qv3SDu@standask-GA-A55M-S2HP>
In-Reply-To: <ZdDUlGdqH7Qv3SDu@standask-GA-A55M-S2HP>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 19 Feb 2024 13:40:52 +0800
Message-ID: <CAAfSe-sTARE6pr3g-vQ2MuaSLhWg8_bNhMcfosYjFxrAikwHHg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: sprd,sp9860-wdt: convert to YAML
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang7@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 23:45, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
>
> Convert Spreadtrum SP9860 watchdog timer bindings to DT schema.
> Adjust file name to match compatible.
>
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Thanks for the patch.

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  .../bindings/watchdog/sprd,sp9860-wdt.yaml    | 64 +++++++++++++++++++
>  .../devicetree/bindings/watchdog/sprd-wdt.txt | 19 ------
>  2 files changed, 64 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml b/Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml
> new file mode 100644
> index 000000000000..730d9a3a3cc5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/sprd,sp9860-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum SP9860 watchdog timer
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    const: sprd,sp9860-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: enable
> +      - const: rtc_enable
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - timeout-sec
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sprd,sc9860-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        watchdog@40310000 {
> +            compatible = "sprd,sp9860-wdt";
> +            reg = <0 0x40310000 0 0x1000>;
> +            interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&aon_gate CLK_APCPU_WDG_EB>, <&aon_gate CLK_AP_WDG_RTC_EB>;
> +            clock-names = "enable", "rtc_enable";
> +            timeout-sec = <12>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt b/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
> deleted file mode 100644
> index aeaf3e0caf47..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Spreadtrum SoCs Watchdog timer
> -
> -Required properties:
> -- compatible : Should be "sprd,sp9860-wdt".
> -- reg : Specifies base physical address and size of the registers.
> -- interrupts : Exactly one interrupt specifier.
> -- timeout-sec : Contain the default watchdog timeout in seconds.
> -- clock-names : Contain the input clock names.
> -- clocks : Phandles to input clocks.
> -
> -Example:
> -       watchdog: watchdog@40310000 {
> -               compatible = "sprd,sp9860-wdt";
> -               reg = <0 0x40310000 0 0x1000>;
> -               interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> -               timeout-sec = <12>;
> -               clock-names = "enable", "rtc_enable";
> -               clocks = <&clk_aon_apb_gates1 8>, <&clk_aon_apb_rtc_gates 9>;
> -       };
> --
> 2.34.1
>

