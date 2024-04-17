Return-Path: <linux-kernel+bounces-148812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A998A87B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C921C21F20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F087147C9D;
	Wed, 17 Apr 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4T6AISh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C113C3EF;
	Wed, 17 Apr 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368068; cv=none; b=ARFys+a6ITm7aw+zHvcO88YYbb08f5aTUGdKeCPLJxtxGyPkcmIZa+EdWnkQRZYinsYKRO8JJYRq+InxkAqmFoY0VOmOkEOwhY+SJeFGNIQ2Rls1zKLrDEvEviKS+Ai2mzgxuuzdBjMiEVAa70W/sToC2wenLEKW7uEDUv/+1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368068; c=relaxed/simple;
	bh=IaRbObB5dEEIBtmpY4TQrQpfkbKo3yd2zwxXbfaJry0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jcS+eTpuaZWeVijKeU8wGzXirr/TzjuVnRf6vuvOTyySPhANT2/7qE9a31rq7CyYoztjjdnMseZOteXJdOG1qYreKfY7aiP+GkMOiscNyQfi7nc/4sIZQY0gdmz8z1SYJ+E23pEMu5YeqVZGk3SpxauCsLDcSvGR5NbgiHuQ+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4T6AISh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB6DC072AA;
	Wed, 17 Apr 2024 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368068;
	bh=IaRbObB5dEEIBtmpY4TQrQpfkbKo3yd2zwxXbfaJry0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=i4T6AIShq8iv6NzCQXuiVcBRjXys+gIu07VpRelIM/4VXfkxa3i1aKygFMcqTfTIP
	 AxI1eScM8ogH6mCi0qFjCiT8MznN+YC6bE97ooKRydobQsZBEBBPl14dFQ/xJn7HcJ
	 WhAUpXTxxQ+2Ln9OGR3rqkl/aitwNGoa5G5ULy5RqNdc8NReBC8F7Aw/raXUAR5Vla
	 sVdUqc4laN664krEG2iJfuh8vTv5eP5X/Cd5kMpYf6dUmdG1Ce3KMwmHj+zgdDoFUO
	 jLR33YbSwCQZlA1pjaR0uIv/IyOSNecht8uQWZ1RfasrybthQd67T+YCEJKhb1akT9
	 aqEUnB1f0DATQ==
Date: Wed, 17 Apr 2024 10:34:26 -0500
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
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
 Dent Project <dentproject@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 kernel@pengutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>, 
 linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, Russ Weight <russ.weight@linux.dev>, 
 Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Frank Rowand <frowand.list@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240417-feature_poe-v9-8-242293fd1900@bootlin.com>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
 <20240417-feature_poe-v9-8-242293fd1900@bootlin.com>
Message-Id: <171336806575.2618779.157615998420721814.robh@kernel.org>
Subject: Re: [PATCH net-next v9 08/14] dt-bindings: net: pse-pd: Add
 another way of describing several PSE PIs


On Wed, 17 Apr 2024 16:39:56 +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> PSE PI setup may encompass multiple PSE controllers or auxiliary circuits
> that collectively manage power delivery to one Ethernet port.
> Such configurations might support a range of PoE standards and require
> the capability to dynamically configure power delivery based on the
> operational mode (e.g., PoE2 versus PoE4) or specific requirements of
> connected devices. In these instances, a dedicated PSE PI node becomes
> essential for accurately documenting the system architecture. This node
> would serve to detail the interactions between different PSE controllers,
> the support for various PoE modes, and any additional logic required to
> coordinate power delivery across the network infrastructure.
> 
> The old usage of "#pse-cells" is unsuficient as it carries only the PSE PI
> index information.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - New patch
> 
> Changes in v4:
> - Remove $def
> - Fix pairset-names item list
> - Upgrade few properties description
> - Update the commit message
> 
> Changes in v5:
> - Fix yamllint error.
> - Replace underscore by dash in properties names.
> - Add polarity-supported property.
> 
> Changes in v6:
> - Reorder the pairset pinout table documentation to shrink the lines size.
> - Remove pairset and polarity as required fields.
> - Add vpwr-supply regulator supply.
> 
> Changes in v7:
> - Fix weird characters issue.
> - Fix documentation nit.
> ---
>  .../bindings/net/pse-pd/pse-controller.yaml        | 101 ++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml references a file that doesn't exist: Documentation/networking/pse-pd/pse-pi.rst
Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml: Documentation/networking/pse-pd/pse-pi.rst

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240417-feature_poe-v9-8-242293fd1900@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


