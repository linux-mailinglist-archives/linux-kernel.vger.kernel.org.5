Return-Path: <linux-kernel+bounces-31274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CA832BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B641C23F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEA5467A;
	Fri, 19 Jan 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il73LRCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A4537EA;
	Fri, 19 Jan 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675855; cv=none; b=Kj/fO/YGYU3ZyY6OR5CNAM/TQtVwBl78msGOc2gE/VOl/NCgUrIW5s406C5p3J2Ct5EFgsUSgxI1Et7CcL1pSwaSzV+EavedHf1dZWOcM4ChUsgehc9Y6V0gzPNHcaVz1AEvtqfutbu4HZi5WnEOte+VUXTgWGtuz6BcJpEJDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675855; c=relaxed/simple;
	bh=wus+JdBy39/TlYRdizuSbTymPeGMbWWwjq3GLgCebHQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BLH3PNwIxMsShqaIGNnCwf6odaxf2Z9qqS5ZrfqI7P/jOH13JmIYAmOo0GLkQKU6MZsCpVah2eDGxHQc8Tfj171pr+Au272GckVFVpdiiOId4oai7lpwe8b5mx3vIL1ByZw34/4O8RZCsxQPtfIN5Nc3Q9BNpzoHF9ZnrKCm+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il73LRCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED75C433C7;
	Fri, 19 Jan 2024 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705675854;
	bh=wus+JdBy39/TlYRdizuSbTymPeGMbWWwjq3GLgCebHQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Il73LRCTISeRJlSA4o3Od+Qsfli5PDKExos/nWrry1y8Hr5/FjoR3dkVioJozDkED
	 F78w3UX/XfSm61Rz1uad9l3fn92ne1vsGKgnG91+2nVs9FOO9vpg8ABxyG2DGJXHLX
	 2PWHyStAkTkru9BOxSvcr1igrvFdfVnkufRHZIFaoazSC4b7eBrakNo1WgE2cb38ea
	 9VjtfhUaE/IR+lMKJEoJ6sd3MVMWEUF6eLoK9AJ9EeNpi7I87Yh+uF2CjeEJJaF57e
	 roFkkjzMsG5xwCoBlxAg7DiTS57w5QyjIBLKaRYdXXfM0AZgVA3IvXDU7lp/Cc9Fkt
	 PzWjqOMFUYFwg==
Date: Fri, 19 Jan 2024 08:50:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: devicetree@vger.kernel.org, kernel@pengutronix.de, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
 Sebastian Reichel <sre@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, 
 Lukasz Luba <lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240119132521.3609945-2-o.rempel@pengutronix.de>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
 <20240119132521.3609945-2-o.rempel@pengutronix.de>
Message-Id: <170567585145.286939.12867599377741148021.robh@kernel.org>
Subject: Re: [RFC PATCH v1 1/7] dt-bindings: power: reset: add generic PSCR
 binding trackers


On Fri, 19 Jan 2024 14:25:15 +0100, Oleksij Rempel wrote:
> Add binding for Power State Change Reason (PSCR) subsystem
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/power/reset/pscr.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/pscr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/power/state-change/pscr.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240119132521.3609945-2-o.rempel@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


