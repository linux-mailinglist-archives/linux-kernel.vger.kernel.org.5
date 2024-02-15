Return-Path: <linux-kernel+bounces-67047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287F85654C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1FE295400
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B01131E32;
	Thu, 15 Feb 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMgmeOrM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13B12D74D;
	Thu, 15 Feb 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006003; cv=none; b=WSro7qFAGcfB18IUDAuFCeomLFDoT/OCoWy259qhKYQJk4XVhK2SglN5hl3u/mJSybIkHVoC8HYyVXRsTorKvjZhAb+NQndXvZgW4EGTM3/E7DFFkXWSnsZTxo5Iuk0BmRsuTloQA/PTdET2ABSoLwjS5li7rJI6xZhbIJ2GeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006003; c=relaxed/simple;
	bh=Wz68I4JN+sBrvrmI2vCBMnMFZ1gd2Eau+yuFoH6X428=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbbyuK8sMD4hzhcxb4QUSaPh8f6Ws2eWXwaLKmX6Eb1g6fql/2tPv9dOM2WEIjK1rdHALm3nqG8ZZoogD8oe9hvVWZYjJYpyyYvEWn3seaaWLPBfc79azRWQLpOcT0iuAbH656ezFwExSgdAA9yNYBb9DPcXFJqX8Gtl2Tprhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMgmeOrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DB1C433F1;
	Thu, 15 Feb 2024 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006002;
	bh=Wz68I4JN+sBrvrmI2vCBMnMFZ1gd2Eau+yuFoH6X428=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMgmeOrMASsuoPOGWdDmOZjU31bUgDKOPpJz0A/Dm/x4FwRKVwENjDuHV8xzH1FTa
	 3BcN32aTmFt8lPQwoLRmMDpZnyZwgWdChXBxXTq064aTSG82rSeD2A0cbVCl/Snt9j
	 ba/nx/RoNTlR99nlMMO930YzkrQJ7L8LpelVhMPCUNZb/nayqx8KG+6fxpLCR6ib5j
	 lq7QCVk+4xCl8VMZ7DoZEZ1hUe5gcI8H68XMwHF+3hKheuHav4/LZonH9lkgdLlGYT
	 cGALzI3+Ubh4ejfteUw/cY8wOmV1p63NpFdHbrcKdUnmoU3ZbLRtTreE5hk5qKk7iB
	 /rqZRNN70+fHA==
Date: Thu, 15 Feb 2024 08:06:38 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 01/22] dt-bindings: gpio: Add binding for ChromeOS EC
 GPIO controller
Message-ID: <20240215140638.GA4162082-robh@kernel.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
 <20240210070934.2549994-2-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210070934.2549994-2-swboyd@chromium.org>

On Fri, Feb 09, 2024 at 11:09:12PM -0800, Stephen Boyd wrote:
> The ChromeOS embedded controller (EC) supports setting the state of
> GPIOs when the system is unlocked, and getting the state of GPIOs in all
> cases. The GPIOs are on the EC itself, so the EC acts similar to a GPIO
> expander. Add a binding to describe these GPIOs in DT so that other
> devices described in DT can read the GPIOs on the EC.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <linux-gpio@vger.kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/gpio/google,cros-ec-gpio.yaml    | 49 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  3 ++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/google,cros-ec-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/google,cros-ec-gpio.yaml b/Documentation/devicetree/bindings/gpio/google,cros-ec-gpio.yaml
> new file mode 100644
> index 000000000000..a9f1d7784070
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/google,cros-ec-gpio.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/google,cros-ec-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIOs controlled by ChromeOS EC
> +
> +maintainers:
> +  - Stephen Boyd <swboyd@chromium.org>
> +
> +description:
> +  Google's ChromeOS EC has a gpio controller inside the Embedded Controller
> +  (EC) and controlled via a host-command interface. The node for this
> +  device should be under a cros-ec node like google,cros-ec-spi.

Why do we need a child node here? 

Rob

