Return-Path: <linux-kernel+bounces-47178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A01844A28
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEFE1F2334F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337739AEE;
	Wed, 31 Jan 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YteWpJAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F639AD0;
	Wed, 31 Jan 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737047; cv=none; b=H7KzhbaH/SExzoa4OOdSMfey+NA+ApD4jPXv9uBNW9k7WlzUftN4BuAfYYEgMtCuqnxROPuSGEqB4sF29etSPVj32XX+KpnenMLNPenX7xJg5AkXG/sR1olGLd+NApIfEB/ChJujQKjJBOH8nNLDDRhB20ysMs0MH1snMmGiW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737047; c=relaxed/simple;
	bh=QHYllCIGxd1fjN/1dMkGWsl3/gWwu0OX4RZLlXlxc7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbOEvoVyCGyoAg76A8hMyH10yR5GJv1bfQglI+a1XD67IvVYNHPN6zbRzm7+wHxz6C05L+Wt72UV5IBa+GXKy+aTgY35ROTvDUrBrnfIHet+VmZqxIuw3qBB23g2YXsKfh7JGWVHqRxWjToXL6tBf96TKdMt9V6AjAn7jFuZ1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YteWpJAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97085C43390;
	Wed, 31 Jan 2024 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737046;
	bh=QHYllCIGxd1fjN/1dMkGWsl3/gWwu0OX4RZLlXlxc7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YteWpJARLEUBMao0ZpwP3Ffr9YUO9eD4UBe+MMrzEgKMZ/wifiivArxXcgh08eoym
	 JU5G6ptyI3kkUiaK8W5yhUFmq28v8y/ilJAw6e7grquE+ykKxp4HOq4cKvmcAf6qKo
	 zSQaDfGmtwBH2kNgWis+59bVGSzp17AuHsu/KblzOFXlxX9i+4jOQVka915iKKpOZD
	 CRVuMgfkXPEi87H56y7avZWVKdZFxgZ20+OwDeayiuO6r1lJ+I07wqxR+v1SrCWxoO
	 hYry8yiWxnN2xplwgIXToM3oVkh545jkLagxOM2pAu264XigQ0N1R25/decthPdh7y
	 VDHOrXY7Q0AYQ==
Date: Wed, 31 Jan 2024 15:37:24 -0600
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Message-ID: <20240131213724.GA2334002-robh@kernel.org>
References: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
 <20240130-onboard_xvf3500-v1-1-51b5398406cb@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-onboard_xvf3500-v1-1-51b5398406cb@wolfvision.net>

On Tue, Jan 30, 2024 at 01:26:56PM +0100, Javier Carrasco wrote:
> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
> multicore controller for voice processing.
> 
> Add new bindings to define the device properties.
> 
> [1] https://www.xmos.com/xvf3500/
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
> new file mode 100644
> index 000000000000..d7d5bda23b1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xmos,xvf3500.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: XMOS XVF3500 VocalFusion Voice Processor
> +
> +maintainers:
> +  - Javier Carrasco <javier.carrasco@wolfvision.net>
> +
> +description:
> +  The XMOS XVF3500 VocalFusion Voice Processor is a low-latency, 32-bit
> +  multicore controller for voice processing.
> +  https://www.xmos.com/xvf3500/
> +
> +properties:
> +  compatible:
> +    const: usb20b1,0013
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the 1V0 supply.
> +
> +  vdd2-supply:
> +    description:
> +      Regulator for the 3V3 supply.
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - vdd-supply
> +  - vdd2-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    xvf3500 {
> +      compatible = "usb20b1,0013";
> +      reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
> +      vdd-supply = <&vcc1v0>;
> +      vdd2-supply = <&vcc3v3>;
> +    };

A USB device should hang off a USB hub (or root hub). Looks like you 
just have a random node here. You should also have a $ref to 
usb-device.yaml. You'll see you need a reg property for example.

Rob

