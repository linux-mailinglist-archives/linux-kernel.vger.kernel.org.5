Return-Path: <linux-kernel+bounces-112522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E5887B1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EB41F21700
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78D5BADF;
	Sat, 23 Mar 2024 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gh7qhQyh"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41CEECC;
	Sat, 23 Mar 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711237075; cv=none; b=YJREvp7ahfKf0SkjfmHdaN3x2MvqvDeAqygudE4zX37Y8f+v6g3yga+OP2yr451GnnKnnZv9piZrVW4nMR7B0O04VW1stvWqpHiX34zRDWoaTlFP4cMf8BZk+96O5TPqhY7HCejNfnLjozdiUeVZSkZVkLlIDteIfolnNqVwOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711237075; c=relaxed/simple;
	bh=6ljQUXWnYOT6gSYK/RZsytm8Zc8/8u/MMm0rwQMMkXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsXw0ymU4A87rywdhha8yrS5a0vWcYeOMofggfFksh/AA3W00iUnEww9CqM8hcgUGHKWwdQ8LasMxWspuqXEci40Sjf0oiqPKnuBP0LASA+qABQNO7f9PlhUI7e67ZkFQag3TcBmQux6k7xxgTWPC4LehMvxPBdu0SlDrg5mb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gh7qhQyh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23E521BF203;
	Sat, 23 Mar 2024 23:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711237064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stKi4Bkqfr5EzqU694IOdv3g32Vm41AKq7z++NU6pOI=;
	b=gh7qhQyhVJVw9LXRfT6Besv2z0z9uXjECJ5BD7c8RrlHoQ5fiOzv2ZwEd0VHiVIEWDhd+e
	r0IGe+5hLwYhiPl1s5hY3gng13mZpebFUD3oaCn03mVDGOJAk0dymkYfxgKImruWJZcnX3
	O+jfHqZVqFHOWz67PGkJrpcDhdlpO+ALdg5x4N+PfqG0fK+AUmtyDVY5UaI2qYWO59e1bM
	JIzfT/XxTiTkN3JE6gg71WAVvEBqq8h+DAHaV4lBTDoe6yExJYEeufdHkcxIBTm8gkWXWr
	P3rUFQ5DegtIsayEqH8URuggon7lkoHMWvWYTynT81jQmuGlE8X4adsEu4wY8g==
Date: Sun, 24 Mar 2024 00:37:42 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: rtc: armada-380-rtc: convert to dtschema
Message-ID: <20240323233742bfb9ba4a@mail.local>
References: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
 <20240323-rtc-yaml-v1-1-0c5d12b1b89d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-rtc-yaml-v1-1-0c5d12b1b89d@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 23/03/2024 23:46:13+0100, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> This is a direct conversion with no additions.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/armada-380-rtc.txt     | 24 -----------
>  .../bindings/rtc/marvell,armada-380-rtc.yaml       | 48 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> deleted file mode 100644
> index c3c9a1226f9a..000000000000
> --- a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* Real Time Clock of the Armada 38x/7K/8K SoCs
> -
> -RTC controller for the Armada 38x, 7K and 8K SoCs
> -
> -Required properties:
> -- compatible : Should be one of the following:
> -	"marvell,armada-380-rtc" for Armada 38x SoC
> -	"marvell,armada-8k-rtc" for Aramda 7K/8K SoCs
> -- reg: a list of base address and size pairs, one for each entry in
> -  reg-names
> -- reg names: should contain:
> -  * "rtc" for the RTC registers
> -  * "rtc-soc" for the SoC related registers and among them the one
> -    related to the interrupt.
> -- interrupts: IRQ line for the RTC.
> -
> -Example:
> -
> -rtc@a3800 {
> -	compatible = "marvell,armada-380-rtc";
> -	reg = <0xa3800 0x20>, <0x184a0 0x0c>;
> -	reg-names = "rtc", "rtc-soc";
> -	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> -};
> diff --git a/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml b/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml
> new file mode 100644
> index 000000000000..388c7d7a044d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/marvell,armada-380-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RTC controller for the Armada 38x, 7K and 8K SoCs
> +
> +maintainers:
> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - marvell,armada-380-rtc
> +      - marvell,armada-8k-rtc
> +
> +  reg:
> +    items:
> +      - description: RTC base address size
> +      - description: Base address and size of SoC related registers
> +
> +  reg-names:
> +    items:
> +      - const: rtc
> +      - const: rtc-soc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +
> +additionalProperties: false

This is not correct because at least start-year is supported. Please
check for all your other submissions too.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    rtc@a3800 {
> +        compatible = "marvell,armada-380-rtc";
> +        reg = <0xa3800 0x20>, <0x184a0 0x0c>;
> +        reg-names = "rtc", "rtc-soc";
> +        interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> 
> -- 
> 2.40.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

