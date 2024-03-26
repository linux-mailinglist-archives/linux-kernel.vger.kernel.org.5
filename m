Return-Path: <linux-kernel+bounces-119354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076288C791
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F3E1F80CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61D13C9D0;
	Tue, 26 Mar 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K784zjZM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0113C811;
	Tue, 26 Mar 2024 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467570; cv=none; b=NJEZKcOXEcaDAeo8ii3NKjTGKW1LqngaGlrxBIgn8L2Qj3p4uHVxkTX4lOEdbRSvTtMocrkYymNjqguBRfC3pG/HwKFtyK94Yl44gn2uk+VR3jiQnV1HyQGsOSkRU55H8dijHFzazozQ9YKM5jIaTDdMN8jJV88iUYC/jbP/Jp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467570; c=relaxed/simple;
	bh=9rqG/D6nJZt9xV642EDHpT17xx73w2B042VnTlDF79Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=EKfAZLmZ9mbE8fhVoHs/YTv0/yP4Fdg1m9o8K+LJ+dXILTVyh49CHjXc8rAxxePg6q8gGPIV+eb8FuuGd/vIMm1REnKPuYHTAcVpO+zKQ2SgXe66ACgS11FrPPUE9tDe+89DcNzgu6KGnQ7eXKv5VUU3BT6d9o7MFYPy2TnvabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K784zjZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A5FC433F1;
	Tue, 26 Mar 2024 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467569;
	bh=9rqG/D6nJZt9xV642EDHpT17xx73w2B042VnTlDF79Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=K784zjZMCJ6ZkKOl/E9Uu9VbJN9Yh6iAbY5bErnZlt5SdvFlaG5ouyiBfeR4p0MCw
	 Fr0oWD41SDT96GwQBnNXPifTtQsjMOOZ2TwtzYkdaO9EIBM2EQIMfifwueBXexvscX
	 5RxRpdGjmo82Jp3DTAVyjd6QOaO3sqcsiWMB8FkmNdTToa6eek5XwoOfB20m/N6yKT
	 JAPUnGYCto3cUrhUXFUEVsAP3tEnvKNhqfff5yXwZVjQxQjyQOOklVyfwwP57FjC6v
	 quQCD9xj+Z3SKpdVJVYsQ5KoNOA53+wQZ2nM5E0XA+fKqsyYNbQPt0srQwIL7+cn46
	 AXSV/7rLpi9Qw==
Date: Tue, 26 Mar 2024 10:39:28 -0500
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
Cc: devicetree@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Dent Project <dentproject@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Russell King <linux@armlinux.org.uk>, Conor Dooley <conor+dt@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Russ Weight <russ.weight@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
 Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
Message-Id: <171146756753.2253156.218733720090104400.robh@kernel.org>
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add
 another way of describing several PSE PIs


On Tue, 26 Mar 2024 15:04:48 +0100, Kory Maincent wrote:
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
> ---
>  .../bindings/net/pse-pd/pse-controller.yaml        | 102 ++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml references a file that doesn't exist: Documentation/networking/pse-pd/pse-pi.rst
Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml: Documentation/networking/pse-pd/pse-pi.rst

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


