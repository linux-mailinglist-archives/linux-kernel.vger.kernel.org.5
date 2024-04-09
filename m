Return-Path: <linux-kernel+bounces-136075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1D89CFCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCD6285931
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDCB2030B;
	Tue,  9 Apr 2024 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWNQ+o8E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35035E566;
	Tue,  9 Apr 2024 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626147; cv=none; b=HPl1Nuou8QmwjadwchexwmRlFO+oiB07rkxC2x4NNSiyxPePAPXI0VD3gILFSpEmHqDIh4d77LEw9FfYsAyrMpeg5Skkf13SesB2tLk69yV8htpi6TOR8Qu0JIJzZH4l5Ieem4pVhKkJObWUpwr6tfS/ihU9zZUm7HvbSLaPf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626147; c=relaxed/simple;
	bh=05Yu1Hwdufax+g3FUQAUbIZECXJPsnkFawR16oZeuXg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UQJ9ssgzLkTg8Xti2/yYsSJ9nlPsy+n46Cr2f3gz2tEOnZwzsEGA7iYfWjcRzJ2yrX32OZ8AkWH75e88l62KBN/uePEfxAp8apxdNskpENM8mO1Q4bbbrHPF3UI+qzyZxtDqnxZucuvvtoaufJrE3PayM09pCEmTgNdxdXUUpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWNQ+o8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0F4C433C7;
	Tue,  9 Apr 2024 01:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712626146;
	bh=05Yu1Hwdufax+g3FUQAUbIZECXJPsnkFawR16oZeuXg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BWNQ+o8EKBDZ+M+YSjkCOzd2WzzmFR2Ni7Je2bm0Sle4oubjVJElKU227lBPd+Cbm
	 zuFEkyZiT5mE6d/NL7mxsTQHWDlJhk69ZA+kAxCm3UUmz8MdM1OwOy5pEJW5J9uVNW
	 4i6jOIqJn0ipfU7G4d9fCr1rXYjelUTUFC83R+ccyONfpLvTjxJtYa++aIMzXpH7hF
	 O+tYYejMkPh6wP6K5zVffDrHX1XqTUQrnkbuQVRsSByOrOe2y6bKELPkTDEAel4DQJ
	 p3HLnP84vjWddfxGSE85TJRMdosF2MPA4FE8ePgLnI51TgfOelEpr2sIvf3s40G5mj
	 xOjvs7OFIuosw==
Date: Mon, 08 Apr 2024 20:29:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kernel@sberdevices.ru, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>, 
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
 Vignesh Raghavendra <vigneshr@ti.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20240408085931.456337-2-avkrasnov@salutedevices.com>
References: <20240408085931.456337-1-avkrasnov@salutedevices.com>
 <20240408085931.456337-2-avkrasnov@salutedevices.com>
Message-Id: <171262614183.5405.15027515085421244232.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code


On Mon, 08 Apr 2024 11:59:30 +0300, Arseniy Krasnov wrote:
> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages located with the specified interval
> within specified offset. Both interval and offset are located in the
> device tree and used by driver if 'nand-is-boot-medium' is set for
> NAND chip.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml:84:61: [warning] too few spaces after comma (commas)
/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml:85:61: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240408085931.456337-2-avkrasnov@salutedevices.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


