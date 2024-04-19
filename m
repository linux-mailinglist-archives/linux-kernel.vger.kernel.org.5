Return-Path: <linux-kernel+bounces-151546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B08AB053
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC3C1F234CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D712FB15;
	Fri, 19 Apr 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYqlq4Z7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67E12D1F9;
	Fri, 19 Apr 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535583; cv=none; b=jaxeA4UF1I3flLLZ0YlJ4mi3kPX5MOWBXLVAUJy2deGdKtd96teR2oLBlOwrINTP0VCS2ETyTeOKGdCd0qe0vr2HXxoaWkgkvppvEXaj3Ulx4pZCGn+qJqhe0Gud1OYIruSo7SCQmpGE1ohfR2lq+E3HRzoEN+ybIVNKHny8qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535583; c=relaxed/simple;
	bh=4UGNFSgesygAGdY3+MGHMKJc99PPaLznLJdQZQ/rwtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cVAbkAtUe+02uFLfnSBhSA9wPIkJIXAdO0lLktO4QnILuOJ2K6IhN3bZSNq8CnNijHnGwr0lrZ8UC16vcDPtT1qyvXwdW3HoBY11KqVsmQIET1dML3ewS7vGEsoNsFEdTAZrqQk0qIN9o4+hkyn1BxfaCn6hx4iQZqXd2NlOZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYqlq4Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F94C072AA;
	Fri, 19 Apr 2024 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713535583;
	bh=4UGNFSgesygAGdY3+MGHMKJc99PPaLznLJdQZQ/rwtE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZYqlq4Z74AjyMmlDE49kSVz2iBj4zc10qPrwK1niIt1XzFW9efJG5QID/x9MmV/fQ
	 1H1hSWoRVpAmxbtOjlN+Gq5Lw0opN0UePuVWeI8wKOdXzndVs3oB1VM1OgCsiIGzm+
	 MFyt6NDNXY1TTCbecb0yhNyp8/tQw4l7rapi9xH0nav5Wqp0eDHmWrMJvAS88jbzce
	 U77U+IIWp49aSViR8mtCju3xYcBsItij8R9HAHSlTbPaRDQhMhurAGaZfFYIjG/IKM
	 R02ux3aoppqb0odbH9kGMXrC14zMuni5NffggDIKFu9THKWoZz/ME1eBLOKL45e+Rh
	 El/wI83RyLjOw==
Message-ID: <07b1ca57-49a0-4151-99bf-caac053eaa01@kernel.org>
Date: Fri, 19 Apr 2024 16:06:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/6] dt-bindings: clock: meson: document A1 SoC
 audio clock controller driver
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jiucheng Xu
 <jiucheng.xu@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
 <20240419125812.983409-5-jan.dakinevich@salutedevices.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240419125812.983409-5-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 14:58, Jan Dakinevich wrote:
> Add device tree bindings for A1 SoC audio clock and reset controllers.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>

This is still RFC, so not ready.

Limited, incomplete review follows. Full review will be provided when
the work is ready.

Drop "driver" references, e.g. from subject. Bindings are about hardware.


...

> +
> +  clocks:
> +    maxItems: 26
> +    items:
> +      - description: input main peripheral bus clock
> +      - description: input dds_in
> +      - description: input fixed pll div2
> +      - description: input fixed pll div3
> +      - description: input hifi_pll
> +      - description: input oscillator (usually at 24MHz)
> +    additionalItems:
> +      oneOf:
> +        - description: slv_sclk[0-9] - slave bit clocks provided by external components
> +        - description: slv_lrclk[0-9]- slave sample clocks provided by external components

What does it mean the clocks are optional? Pins could be not routed?
It's really rare case that clocks within the SoC are optional, so every
such case is questionable.


> +
> +  clock-names:
> +    maxItems: 26
> +    items:
> +      - const: pclk
> +      - const: dds_in
> +      - const: fclk_div2
> +      - const: fclk_div3
> +      - const: hifi_pll
> +      - const: xtal
> +    additionalItems:
> +      oneOf:
> +        - pattern: "^slv_sclk[0-9]$"
> +        - pattern: "^slv_lrclk[0-9]$"
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,a1-audio-clkc
> +    then:
> +      required:
> +        - '#reset-cells'
> +    else:
> +      properties:
> +        '#reset-cells': false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> +    #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
> +    #include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
> +    audio {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clkc_audio: clock-controller@fe050000 {
> +                compatible = "amlogic,a1-audio-clkc";
> +                reg = <0x0 0xfe050000 0x0 0xb0>;
> +                #clock-cells = <1>;
> +                #reset-cells = <1>;
> +                clocks = <&clkc_audio_vad AUD_CLKID_VAD_AUDIOTOP>,
> +                         <&clkc_periphs CLKID_DDS_IN>,
> +                         <&clkc_pll CLKID_FCLK_DIV2>,
> +                         <&clkc_pll CLKID_FCLK_DIV3>,
> +                         <&clkc_pll CLKID_HIFI_PLL>,
> +                         <&xtal>;
> +                clock-names = "pclk",
> +                              "dds_in",
> +                              "fclk_div2",
> +                              "fclk_div3",
> +                              "hifi_pll",
> +                              "xtal";

Make it complete - list all clocks.

> +        };
> +
> +        clkc_audio_vad: clock-controller@fe054800 {

Just keep one example. It's basically almost the same.



Best regards,
Krzysztof


