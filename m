Return-Path: <linux-kernel+bounces-31424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAB9832E25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD69B21E34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B855E70;
	Fri, 19 Jan 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGVPO4Qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6A54F9B;
	Fri, 19 Jan 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685321; cv=none; b=bYseRPpLCQ4B8cixNtvHt3P6RzEIxpi7YEsNEL8awyUryw8gHoWtHr6A0i7VllxEIbPxw7w/D2Hxj/MHrAJJZklwzb03xdlDSK/++5h+tPqF1Y1/mzgQ8U1XIXUXWhykTiuH8DwYs6MFXwRbfttQOO4sDWQoWBC6dCWHWJ4QJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685321; c=relaxed/simple;
	bh=GQWTWoBKpbNB7G5ergb/SE1apkAwlCoyhbciiQBtTM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx4vUbNZiV6QQMZQfqR6Q39vy1Fn0Z1aXi4wQpHBXyPG960FBQ6idsdhqIkx3HHCE45hILrCSu38PcLCKEI5oBaS6jUnzESJ8l935//pxACdYkDOzvtuBAn5ewDDxx4htv53AMuP87PiARYrWT7rmRMHYoThmc5+vP4ShfisBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGVPO4Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C6FC433C7;
	Fri, 19 Jan 2024 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705685320;
	bh=GQWTWoBKpbNB7G5ergb/SE1apkAwlCoyhbciiQBtTM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGVPO4QohMMi/GdXUPeCxL0gOWkmV4hXLQHUVzUDP7NoETtmUpr2vhg4XeVJvsADF
	 afXMVdGusiFhV3wd53hIuoqeHdsX0Z8L8qsL7OSFIIjZ7xy9lkWWBHNfl+q/u7yevD
	 W4VNGadiwuBykwAwydjc86Ypa/EVkaJ59VeSPGk8iHOB5/zsSM297y4/gtc4U0LTPO
	 NhkLAni4miUC7/nKrvOd9pnHmM6QasYvcklWwak/Iyrey1Th3bEwZtHS25yAxzzwAU
	 /MlSKNio1inEo/FCcQ46Qb9idoMb6Uwq1yXnAa33qRUnQfHUsNVSlpzBM2yb7b/yBa
	 gAoIxEa2rRwgw==
Date: Fri, 19 Jan 2024 11:28:38 -0600
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [RFC PATCH v1 1/7] dt-bindings: power: reset: add generic PSCR
 binding trackers
Message-ID: <20240119172838.GA460212-robh@kernel.org>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
 <20240119132521.3609945-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119132521.3609945-2-o.rempel@pengutronix.de>

On Fri, Jan 19, 2024 at 02:25:15PM +0100, Oleksij Rempel wrote:
> Add binding for Power State Change Reason (PSCR) subsystem

Why? 

How is this different from the reboot reason binding?

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/power/reset/pscr.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/pscr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/pscr.yaml b/Documentation/devicetree/bindings/power/reset/pscr.yaml
> new file mode 100644
> index 000000000000..1ce973f3473c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/pscr.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/state-change/pscr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Power State Change Reason (PSCR)
> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description: Binding for devices responsable to store reasons for power state

responsible

> +  changes such as reboot and power-off. Reasons like unknown, under voltage,
> +  and over temperature are captured for diagnostic or automatic recovery
> +  purposes.
> +
> +properties:
> +  $nodename:
> +    pattern: "^pscr(@.*|-([0-9]|[1-9][0-9]+))?$"

Drop. This could be used in any random device.

> +
> +  pscr-unknown:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Value to indicate an unknown reason for the power state change.

What's an undocumented value? It would be unknown too, so just drop this 
property.

> +
> +  pscr-under-voltage:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Value to indicate an under-voltage condition of a system critical
> +      regulator as the reason for the power state change.
> +
> +  pscr-over-current:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Value to indicate an over-current condition of a system ctitical regulator
> +      as the reason for the power state change.
> +
> +  pscr-regulator-failure:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Value to indicate an unknow, system ctitical regulator related failure
> +      as the reason for the power state change.
> +
> +  pscr-over-temperature:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Value to indicate a system critical over-temperature condition as the
> +      reason for the power state change.
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.39.2
> 

