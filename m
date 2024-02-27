Return-Path: <linux-kernel+bounces-84134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F9786A2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7BE1C2509E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866055794;
	Tue, 27 Feb 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS5JWD5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04854746;
	Tue, 27 Feb 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073570; cv=none; b=FV7/0btiAe5ksgrqGx701Zysqz1h7M1WPtRrhI4KGtRwggHtJJXsQGYN4z/QDiQaaltTPDdbQW9GvWCUbFyyCI6HgI9RfFw2S+8bqoggiXtJTaKjD3jXByd+mtQXPBwHfq81N/PMb3Ax0HNFIq/TqcfsqXw6ve5I46PxtZ5c7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073570; c=relaxed/simple;
	bh=VSsJLgNCXRcSmh0ht0CqUGAtiZOOxIyeddN2UmKKkmY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ie2hnb8PiP9cHG1iKsx1SIW7HX+YgXiTnI0iAhHsClV+MdyhY+9G+S8BwAYKxtJqOEtGlFUYfrHsuXEn0aKDo6OnErTwyUBME/kJRJRaVu1pxUiCYw+6LF8gSHOKdnK3E/PSr+8EgLRbRObd4YCrglfq51YvcXRreSrBWKOIUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS5JWD5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B0FC433F1;
	Tue, 27 Feb 2024 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073570;
	bh=VSsJLgNCXRcSmh0ht0CqUGAtiZOOxIyeddN2UmKKkmY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fS5JWD5JnoKQamXdztCJNqLtdrSbK5enNt7PJm1xeUOvnwVDqvBweMc2PB4CSl6I2
	 U3ZtHeku9kxl8m58sEn2XykI3Zzd9DkAXVY8p7BIt62Rhh81qcoLvI5mOJe6fidNU+
	 t5QyrjP1w6j2DKVBCUV7/BK4IEoOiNQkjb91b6NcsWE7V8lPj8GhPS/Mda2qUl7xer
	 sjN1dGHe8znB08qcdx0i9qOkUTT6I3NRSuXHWp6pzF6Aa8Jt9TsLI+e0DzDkCcZyx2
	 I7zU1RXp4S/R4WmSMrypr3EgvuD5k2IRuAmDSZjGxK8pj15lKdlfZyU2w22YzweIbb
	 gMfuvPt/x0Viw==
Date: Tue, 27 Feb 2024 16:39:28 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20240227-asrc_8qxp-v2-2-521bcc7eb1c0@nxp.com>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-2-521bcc7eb1c0@nxp.com>
Message-Id: <170907356786.667244.11380900266331011977.robh@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers


On Tue, 27 Feb 2024 15:54:10 -0500, Frank Li wrote:
> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> have 1 interrupt.
> 
> Increase max interrupt number to 2 and add restriction for platforms except
> i.MX8QXP and i.MX8QM.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,spdif.yaml          | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb: spdif@2004000: interrupts: [[0, 52, 4]] is too short
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240227-asrc_8qxp-v2-2-521bcc7eb1c0@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


