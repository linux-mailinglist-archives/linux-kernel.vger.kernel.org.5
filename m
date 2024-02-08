Return-Path: <linux-kernel+bounces-58308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C83F84E45F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C3028F2EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823CF7E116;
	Thu,  8 Feb 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAjaHjvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42117D3EF;
	Thu,  8 Feb 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407497; cv=none; b=Mh4qSkxqz+jVVpDqgf557UHp8L4vNAqpR4okaSENyhXoPX24PPh6IIi3ar3cqD6jQxkbYN4VtWaGacye//itkorCWTt81BNGt0yzLo7fVaNVRDqryET0Gl21+Q9EW4doM+8YRla8BuVNsFQkjLHIJlgrLki6RDIUzkEh0wdssEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407497; c=relaxed/simple;
	bh=pZfXrBkwGay5L9BMtIlCVo0mfp2MwiUrwSuB47mE3nw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jonjDM4WB6BRNPKpn0N+T/D/QWO3/6bPaVO70/IQdJmjx5J3gC7BdWi1uEw7YYJYmDMe36j/5Eh+j7he9qFLkSqKenE0YonCbUV8E8KgkDBUPUsSNpnVwfhFcDQYd6Qoitt1adQsLPkMiziTIPpvXGR8UTEvot3HtRkghpq6q8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAjaHjvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4177C433F1;
	Thu,  8 Feb 2024 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707407497;
	bh=pZfXrBkwGay5L9BMtIlCVo0mfp2MwiUrwSuB47mE3nw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mAjaHjvERjl4qwIpijalwfrTU7vg66Vk6ElIpkZ5fqnM0e3gFhG/OTwtpp1GM/T53
	 o945l9J7uXnt6sg2wUkv7DT/x80n2QWnlt4sAzb0469yjdhuOuf3ikkbTWnhzXjhs+
	 QpkLOsp05LvLG2L0z3ixQDe8fck1buWnV1U9/BL3WTbhWS1ZbhIH3NnsOqi+R3kcPF
	 GKTgEKNQi1IUr3un61uaseuqU0LV1elp1pd/ihVo8R5RlUd4Z79NOjoEIWe4cDJvrk
	 V8bLMhSEa1GBDMjZKoVMOqESYLhX5D5DkFpZAI7o8qwdc18fINO1wcX7mykrwxwJTd
	 MMu4TlI0bBEQA==
Date: Thu, 08 Feb 2024 15:51:35 +0000
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
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dent Project <dentproject@linuxfoundation.org>, 
 Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Russ Weight <russ.weight@linux.dev>, linux-doc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
Message-Id: <170740748991.3230450.367502029480356760.robh@kernel.org>
Subject: Re: [PATCH net-next v3 10/17] dt-bindings: net: pse-pd: Add
 another way of describing several PSE PIs


On Thu, 08 Feb 2024 14:08:47 +0100, Kory Maincent wrote:
> Before hand we set "#pse-cell" to 1 to define a PSE controller with
> several PIs (Power Interface). The drawback of this was that we could not
> have any information on the PI except its number.
> Add support for pse_pis and pse_pi node to be able to have more information
> on the PI like the number of pairset used and the pairset pinout.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - New patch
> ---
>  .../bindings/net/pse-pd/pse-controller.yaml        | 101 ++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:80:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:80:15: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:81:15: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml: $defs:pse_pi:properties:pairset-names: {'description': 'Names of the pairsets as per IEEE 802.3-2022, Section 145.2.4. Valid values are "alternative-a" and "alternative-b". Each name should correspond to a phandle in the \'pairset\' property pointing to the power supply for that pairset.', '$ref': '/schemas/types.yaml#/definitions/string-array', 'minItems': 1, 'maxItems': 2, 'items': [{'enum': ['alternative-a', 'alternative-b']}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml: $defs:pse_pi:properties:pairset-names: 'oneOf' conditional failed, one must be fixed:
	[{'enum': ['alternative-a', 'alternative-b']}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240208-feature_poe-v3-10-531d2674469e@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


