Return-Path: <linux-kernel+bounces-67534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30434856D08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6318D1C21795
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91B1386B3;
	Thu, 15 Feb 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlew/9Ss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD831386AE;
	Thu, 15 Feb 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022778; cv=none; b=PWvioEkvOAP7srhtjigSi2Mq3hjl1qjWjiOVDy2vmzbeGElzASF5Czi/H7Y4kGMK94wyF2AbcmmIIVUyGZTajyYFaTx0sM+m5hF4kAhrkkkYOLTddT0V7sYY1SRe/UxZpCGY+QU2oZC+bh+UC1p2quNeIn4j7Iy6liH+MRSJOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022778; c=relaxed/simple;
	bh=gsqZ97hpL+qwMfZA8WVX81FYsijpd+FqSBNu6MOGT5Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qAJwdq3WQ1WBgriHtOm4eBDb99xMmU/JzijwQROsg4stjJW+EtV1HYhOgwEUjhbPVhsp5gla1lnMajdCkFujINTuos63d9wBcR9N+zjvvu69o/ZG+SstBusYLvp75WsCgjQDjvpUTm2GTXEb6elg/REn4SegOnHVZaYNBLNgiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlew/9Ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D28C433F1;
	Thu, 15 Feb 2024 18:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708022778;
	bh=gsqZ97hpL+qwMfZA8WVX81FYsijpd+FqSBNu6MOGT5Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tlew/9Ss3MNeqTJjIN56A8/T4CV50IX+T+8/QuKNeBr2PrLn/b03nxDIcysewSSUP
	 87YhpUZQLyvyD2TXT4uTypFyRDmBO5POpMKbjd6Imog0bX3VxTf89FWuqkIHeawruf
	 bXcPq0w66y+ixEhBDm9LJmvT16eVIaHMyBAYNBXube5cx+w/b3KwUwuXmVtC20OcAD
	 JF/bWuQlZxMcNeFIUzpVC3ay6Re0pFwTP3gLamR2XrJChchXT2vNed7HMoabh/Z1r1
	 qTRDStwaafgan4QrGrDGyrFKjuFKb4UzknD33Vs1MknEmOelP40bi6+c+DTOu8FwBF
	 pX3mthT+ykz7w==
Date: Thu, 15 Feb 2024 12:46:16 -0600
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
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
 netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dent Project <dentproject@linuxfoundation.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Russ Weight <russ.weight@linux.dev>, Eric Dumazet <edumazet@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
In-Reply-To: <20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
Message-Id: <170802277529.323906.8697693998570251856.robh@kernel.org>
Subject: Re: [PATCH net-next v4 11/17] dt-bindings: net: pse-pd: Add
 another way of describing several PSE PIs


On Thu, 15 Feb 2024 17:02:52 +0100, Kory Maincent wrote:
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
> This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.
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
> ---
>  .../bindings/net/pse-pd/pse-controller.yaml        | 84 +++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:74:19: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:75:19: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:84:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:86:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:87:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:88:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:89:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:90:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:91:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:92:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:93:111: [warning] line too long (111 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml references a file that doesn't exist: Documentation/networking/pse-pd/pse-pi.rst
Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml: Documentation/networking/pse-pd/pse-pi.rst

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


