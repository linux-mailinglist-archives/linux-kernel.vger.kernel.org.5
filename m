Return-Path: <linux-kernel+bounces-77007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50FD85FFF7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9085E28C824
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00285156971;
	Thu, 22 Feb 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtdcaR1Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A65156964;
	Thu, 22 Feb 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623906; cv=none; b=N1jZ8TsT0rzvZpfznKPDj4lyhZPvBC6EmVmuWbaLfmFPfRhx2CsYwW15TW0mFvw7l9uS7HjTnywDvLAePM0DVLgs1ok5xv94Sr9lNduub5t4xyunJazH8icHGBIag20f6b0a3f5eV6vuBAm5zjrUFVp2y87X2VVldtYw4LR1wcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623906; c=relaxed/simple;
	bh=EQbxLM18rqvFJ3PNdnsPoefgm4fMY+dLn4MXH2fDWiI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KzCD3opTQjRT04d3xYeSFTlOmhEAhkmYmqAqbXFHkbb7cwj94fFE0U5zEdXLZYMBeEO4qulNh20P30ox8d/wah4ajtNig6DXDwzsN2p6FZZD6oJ33GMJWKzLCLGIvGrKRisXT4JEAoZQG6c0A9Lw/bHOzzb/0pLisqC2h4eeVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtdcaR1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAE7C433C7;
	Thu, 22 Feb 2024 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708623905;
	bh=EQbxLM18rqvFJ3PNdnsPoefgm4fMY+dLn4MXH2fDWiI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gtdcaR1Q2g0YXGy0sPQncYYJ3Be9Tm8RHIAXk6rsXbZY40yrDsudXOWL6MRKCwRVh
	 g0wyjZPZkS4snwhh8tBtic/hfNUOMvCR1pHkOgy3mAmn669r9NiJer9EBd94+vqlKm
	 BzknA1r+mW03i38tWvyGQClbofq9yZBgbgkt6BIMlZFPS5weftZtZFFICbokGhsAbA
	 glwC+5Dh+afE5NevfqKaCE33b2HMfylHDSs3pQU/JmN3mXUliXa7y9MDtN2pxL+2a8
	 EniCu5qXPw4L0NH+YZ2LTUHW37PW4wHQbayNhzOPIUpgN5IptdN1KIjXiGR1jrfhPm
	 3MogsVx0tTgmQ==
Date: Thu, 22 Feb 2024 10:45:02 -0700
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: marius.cristea@microchip.com
Cc: linux-hwmon@vger.kernel.org, lars@metafoo.de, jic23@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org, 
 robh+dt@kernel.org, devicetree@vger.kernel.org, jdelvare@suse.com, 
 linux@roeck-us.net, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222164206.65700-2-marius.cristea@microchip.com>
References: <20240222164206.65700-1-marius.cristea@microchip.com>
 <20240222164206.65700-2-marius.cristea@microchip.com>
Message-Id: <170862389650.3483951.10645767474712290486.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: adding support for
 PAC193X


On Thu, 22 Feb 2024 18:42:05 +0200, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the device tree schema for iio driver for
> Microchip PAC193X series of Power Monitors with Accumulator.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1934.yaml   | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml:51:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240222164206.65700-2-marius.cristea@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


