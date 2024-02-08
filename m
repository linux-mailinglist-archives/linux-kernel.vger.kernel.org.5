Return-Path: <linux-kernel+bounces-58309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54C84E463
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BF28CF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095367CF15;
	Thu,  8 Feb 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpd1me20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA087E790;
	Thu,  8 Feb 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407501; cv=none; b=kVJI2GG781IhAfONIsyALLBbRCxjqcWNtHdwiCDWnpImCPorJm/xakgqx57IyQYdXgMyT+0USnteBYpXO6DBn0TeMrh6dz+EFX893PD9diXVOSiTRV5AvH9P0rQ/FMY0WuAN5JglO4EGPPHTq2GySmgzuHHPNT/XlCbF55WAkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407501; c=relaxed/simple;
	bh=glVWPrc4H/fedcK1utRRiP7/IuLh5y/v7uMa4OTzCKE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GxoxuHnhsf+2wOsVSQp6PMehc4QpRw3I62vhr/vCTJAsz8jUqt3sahbYu2DhaNVSzI8TUvzGsh/TRd5A8LFG4knL1+Ytim5kiaO+Ew+UQFL9taZaYKz8OYP6um5FUA5LxZN2n0fVWq2n8soCeAVP+BHvX6gpZoaoaS0R2jpl+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpd1me20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A713C433C7;
	Thu,  8 Feb 2024 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707407500;
	bh=glVWPrc4H/fedcK1utRRiP7/IuLh5y/v7uMa4OTzCKE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Gpd1me20Iw8N06pVHItea4tJjFzSR7QkqYT5aAAWeGeuwZJLovFNumYHIXC81fzV1
	 DLNQkdcuF7CLdyGabQSlADCXQ50jyrvLJBotb44UUiWRBkkELBM850L5boGWXhiDEU
	 dWrAI72YOYDzpeRNzhZc6Bd2CsONpNAH+9YlZVkvQK9f9gJdxScsZrphA6NNl2axKH
	 Abmmz6Yuk90Pq/6CHpdVJiDRdSn91zQhqL+LkKHSPypUD9kEgGYk1N/i+VV/8rKvx0
	 HnMDBGwXB3QhWnNKDoHzhf8OhbfyUXnLLwQ5UVdD3j3TP26qQ5grqyea8oBDvxC+TG
	 R/Djc9bM9z1/w==
Date: Thu, 08 Feb 2024 15:51:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Russ Weight <russ.weight@linux.dev>, Rob Herring <robh+dt@kernel.org>, 
 Dent Project <dentproject@linuxfoundation.org>, 
 Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org, 
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20240208-feature_poe-v3-16-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-16-531d2674469e@bootlin.com>
Message-Id: <170740749070.3230526.7237351565020544351.robh@kernel.org>
Subject: Re: [PATCH net-next v3 16/17] dt-bindings: net: pse-pd: Add
 bindings for TPS23881 PSE controller


On Thu, 08 Feb 2024 14:08:53 +0100, Kory Maincent wrote:
> Add the TPS23881 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> ---
> Change in v3:
> - New patch.
> ---
>  .../bindings/net/pse-pd/ti,tps2388x.yaml           | 112 +++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/pse-pd/ti,tps2388x.example.dtb: /example-0/i2c/ethernet-pse@20: failed to match any schema with compatible: ['ti,tps2388x']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240208-feature_poe-v3-16-531d2674469e@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


