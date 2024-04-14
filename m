Return-Path: <linux-kernel+bounces-144262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79348A43C4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DABAB22495
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF79E1350C8;
	Sun, 14 Apr 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0vEoJyE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDDC205E10;
	Sun, 14 Apr 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713111862; cv=none; b=ZszyvygFECvo3czHxOfPw7zLcl9Pxtg+2xCmNEbqMWXMFCQH+EISoCNSfWSu4XUhEkRDLo7Mtjd0e4Z/4rCQfQZRM4ly5QA4W9cgQDv08EB0q+sFZI2HgC5rqUB+LdvsKBh+GnKbIIYIf1E7mSvNDdbZizZ9m8Wh0ZjiSXW6scA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713111862; c=relaxed/simple;
	bh=G46pg95W1dlx7SuuXRCLo5zO3XYaAuSy35HXNo01Wko=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=J7ykCSWlLyPEzPGzy3iIaR4B0Jk/2nA87NI2U7WQ3IJqLarRPmz2rgVy1Vr+K+O0a6lgfJAoRN9/JYRTpoHMHW38HYf5rP2N3XPrPy62+fAliom5ohWxpGNJWHSodVqW+vCuB3r4B+G3qeIDQ1JtzExIBV+i71R8g+vxONOZJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0vEoJyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A14C072AA;
	Sun, 14 Apr 2024 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713111861;
	bh=G46pg95W1dlx7SuuXRCLo5zO3XYaAuSy35HXNo01Wko=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=N0vEoJyEo/ulaSAr9h23Z4mw2ANW3ARtvL93yhWTqUSJaTYNYd3eTLPuF9Lyk6jH2
	 SfHeFcEMUwgbwY2S7P95JPyt60NT/NzYoTSy6rdF4D1RryoPxFDAocT3O75L+qvV2z
	 gT6OxsYnLIepW50/pbaaLKCdp2WgGEKhzh+iJBAkcv/0VnPcUFNICUeRGzYEJJzYOI
	 PqJLUQ8xXrGIkn9H/pfH0zJxaVetUbRdm3YXwv4x1pBCsglEfED8249VWdyPvbncUk
	 94laYcj+phYkDh/JGUQF65cYd9inrMjWkUvN0BD8gARsRv5SojOS7+iQkpzjRvwVqm
	 h+jbpPKcHVrBQ==
Date: Sun, 14 Apr 2024 11:24:20 -0500
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
Cc: Rob Herring <robh+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dent Project <dentproject@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-doc@vger.kernel.org, 
 Frank Rowand <frowand.list@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 Luis Chamberlain <mcgrof@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russ Weight <russ.weight@linux.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20240414-feature_poe-v8-11-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
 <20240414-feature_poe-v8-11-e4bf1e860da5@bootlin.com>
Message-Id: <171311185847.3846221.15793333674043121859.robh@kernel.org>
Subject: Re: [PATCH net-next v8 11/17] dt-bindings: net: pse-pd: Add
 another way of describing several PSE PIs


On Sun, 14 Apr 2024 16:22:00 +0200, Kory Maincent wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240414-feature_poe-v8-11-e4bf1e860da5@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


