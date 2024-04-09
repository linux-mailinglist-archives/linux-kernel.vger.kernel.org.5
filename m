Return-Path: <linux-kernel+bounces-137368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D120789E11B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B7D1F22D72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D4D1553BF;
	Tue,  9 Apr 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT4sStbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39570153BDD;
	Tue,  9 Apr 2024 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682510; cv=none; b=Awjq/n3vLI9vyYUooCIWqspWa1ZHX7qa0XT08Ppk2fLnisWsiVPY6bnjww2ZqABxBkGmCalO8hbEh4vPZhGFd9r3NGKB2sg+rj23d5Mxg65eAEaKa34P1wOXajPqSKSTWTkCQvX6HKP6035ryTAR+oMHHBKBXZmR5SUSFtIgKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682510; c=relaxed/simple;
	bh=IBrPy/VRgkXjAmLoTcbWD/V6xOFypit8UNvaKEHXqFw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BFzBej03pZ4Xo3PlBQfGIF1FXtc+Z3lb32vrX8sbnxj3Kz5ujFKTPZotc31meYQrWd0gKf/VUqLJlUNHbOuPAYDW/kMXFQYuAmxIOks3bQn7/xvJJjG1qtBTGQzb6Jqt81thx7V58mY5RdsUtHn01VvogWoTlUImA7eAcQ08rOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT4sStbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD91C433F1;
	Tue,  9 Apr 2024 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712682509;
	bh=IBrPy/VRgkXjAmLoTcbWD/V6xOFypit8UNvaKEHXqFw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BT4sStbqjxoS8PnAW8QDGHqTvZD0JLUbhpBgG9q7zyB0gi8UlPqxXgdZIXWaPup0/
	 wbPgK4m8I7MR4mQpnMuUT8pJz/V82v7apLtsRNF3GavKlbFSRlIFXgvOoQ6SntWzz3
	 vhOPbD0iFOX+CNlBg83vgQn5d3ffnSrBwgqfMrkDKqULvWIi6qVfoQLIBzcGgzOE40
	 9f9qDblCbN720+m0V2A36hUWwiUZaEpA3IrjvJasdToCiZifSw4kJTYonSNCpQUYin
	 MZs30ZqFTn1gVeZVyV4ikOy4lJzXGrXCCFFe/yA7+fEb/mC85+hQed0eaSbljF7T2m
	 Qx4qF1QUtA77A==
Date: Tue, 09 Apr 2024 12:08:28 -0500
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
Cc: Frank Rowand <frowand.list@gmail.com>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 linux-doc@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, 
 Russ Weight <russ.weight@linux.dev>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240409-feature_poe-v7-11-11e38efd4dee@bootlin.com>
References: <20240409-feature_poe-v7-0-11e38efd4dee@bootlin.com>
 <20240409-feature_poe-v7-11-11e38efd4dee@bootlin.com>
Message-Id: <171268250759.1417949.4847589611667849571.robh@kernel.org>
Subject: Re: [PATCH net-next v7 11/17] dt-bindings: net: pse-pd: Add
 another way of describing several PSE PIs


On Tue, 09 Apr 2024 17:04:01 +0200, Kory Maincent wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240409-feature_poe-v7-11-11e38efd4dee@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


