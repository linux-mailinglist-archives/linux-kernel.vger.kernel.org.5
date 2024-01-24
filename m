Return-Path: <linux-kernel+bounces-36572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E383A339
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11221C228B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50051773D;
	Wed, 24 Jan 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHLsnCQ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3081773A;
	Wed, 24 Jan 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081987; cv=none; b=G1CR/TgwSzMwRqC3VkGYVGj8X1Ryw/RzfLIc10CawPoMkG5mq5yzyLIo6Rpkxt8U2MTw6vGMsmqXRB3izKV52UxXIgEkA3nrU9ehqkhfp7O69C2F42/ZuL2T3v5BvjVC1Ar+IpLh2s5CdLjqwf0lpbAGKEtQWckeTpdzBYl8Z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081987; c=relaxed/simple;
	bh=91grIYIx9OkFtRlDhcvytYmNOKGOQX3yknnlFt+vEew=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=YJBZidezx7f9X/AX91UgQZjIkEC7qa9xdORSu6jnLjYVvrIoLxVfqj+SCPeGXFnkV2310ylYIZ8hWX2abLDJES5mzWUTm3OZwIZsG0fYz2HMqWSP42UpUMxEn531Lue8fSv9KhQ32SelzTo06A0R9weV7VKjG8uxMfBRgkRpNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHLsnCQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3E6C433F1;
	Wed, 24 Jan 2024 07:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706081986;
	bh=91grIYIx9OkFtRlDhcvytYmNOKGOQX3yknnlFt+vEew=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UHLsnCQ1dUShb1uVeOf7TkGdla3aigkHLEvLXzWs42kwKOTgVFt2D1NWvBsm4WO3X
	 H5k/EQg5Px4owCmhHLRBNGwlw4mmPQ+XdwWow9DNqNBijEnlCvhuVWxViCyAvDUdl6
	 TfScqKcste9zFamQJs0/AV0Yv4acCb7nNWvakLWgjKcQas/vzZ/INICfFG97v+htT5
	 cmAIu4A2ApnTcoREmT+wAy1VgsHIHCWVTKoknVHXvVgNkYju1K+TgWsqFikALl0301
	 MpkcmybZR9mY4KlUuPprphfjD2HbEiPWmQJpkkbBk10qXOqFOvhXj0O3Q+d0qsI5MO
	 mYGQi0CH3g03Q==
Date: Wed, 24 Jan 2024 01:39:45 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, naresh.solanki@9elements.com, 
 linux@roeck-us.net, p.zabel@pengutronix.de, 
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
 BMC-SW@aspeedtech.com, patrick@stwcx.xyz, conor+dt@kernel.org, 
 corbet@lwn.net, linux-aspeed@lists.ozlabs.org, 
 u.kleine-koenig@pengutronix.de, jdelvare@suse.com, joel@jms.id.au, 
 andrew@codeconstruct.com.au, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20240124060705.1342461-3-billy_tsai@aspeedtech.com>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
 <20240124060705.1342461-3-billy_tsai@aspeedtech.com>
Message-Id: <170608198415.3412038.3874422575074669118.robh@kernel.org>
Subject: Re: [PATCH v13 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control


On Wed, 24 Jan 2024 14:07:04 +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support up to 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb: pwm-tach-controller@1e610000: fan-0: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb: pwm-tach-controller@1e610000: fan-1: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb: fan-0: 'tach-ch' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/pwm-fan.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb: fan-1: 'tach-ch' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/pwm-fan.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240124060705.1342461-3-billy_tsai@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


