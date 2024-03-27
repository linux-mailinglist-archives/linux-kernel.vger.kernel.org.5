Return-Path: <linux-kernel+bounces-120365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191288D654
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D201F29F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C201DA5F;
	Wed, 27 Mar 2024 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2LdcKbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D11CA87;
	Wed, 27 Mar 2024 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520486; cv=none; b=t992qUxcDnTwoA2HlWy4jzOWJdLCsoPgQ/4aHoJG6JKUKd04omq0DM7CZJCylU856l2EOH5bPgqe5s6BdnWKvjvSsGxE36OX+D5zeFgjoEDEDG7+ZDYo5CdRHG3JQJv2yO86sPE26nE+wjZMQs5zapdEVNYUinK3IA/qS0i8uHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520486; c=relaxed/simple;
	bh=Q6c9wsY1u6FOsRL7X5jbUPnPFupmDKYBAc9xSo3Qfss=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XbZH5J+UXbCVMsMHdZTUurHYWZomAxp361AL3BegwbY8in7wduvkrcgzMeRubRdVJOY6obWFvVdnhkIXnNpDnMnem7jg+d7twRRnmdIGDSWCadXFCLR4bXFQ3F/5/P6P1hrOrlqKZaLCoLhFlTsIv7yDlVy9FTEKrnWeYQlop7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2LdcKbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24E2C43390;
	Wed, 27 Mar 2024 06:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711520485;
	bh=Q6c9wsY1u6FOsRL7X5jbUPnPFupmDKYBAc9xSo3Qfss=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=G2LdcKbbWzlXrdk59OdDLGGF5ts9yKVVZp7OO3HjTjzRgbIeaLbw58leN3Decp/Iw
	 ZKnOxfxm5yQWxwLcs05Ui3q5U3jV0uYuZZGbqZWdQMCafSicNEVNLownxcd3HOULz8
	 hUvGwzBKM4invS+r1Bilb69Elcq7qWyBteRYnQNCpsqpAVXLRFbvRzQhhtVfhiTxJv
	 UxdAU0cI/NUWwSMpDooc6yK8VlHT1IcwQwZTJQhvmLgzzzk4uSk79yuQ4pOB9tamnJ
	 FotDQDuvPwPr5cB6D5FB3UrG6WoE8GfDwYMIDye6AyBpc6x/Zu+peY6Obj58QhOEYx
	 Ose4qIIUaGRuQ==
Date: Wed, 27 Mar 2024 01:21:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240327054014.36864-1-animeshagarwal28@gmail.com>
References: <20240327054014.36864-1-animeshagarwal28@gmail.com>
Message-Id: <171152048362.993925.5771433856261368802.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: ata: ahci-da850: Convert to dtschema


On Wed, 27 Mar 2024 11:10:10 +0530, Animesh Agarwal wrote:
> Convert the ahci-da850 bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> 
> ---
> Changes in v2:
> - Added description for reg property items.
> ---
>  .../devicetree/bindings/ata/ahci-da850.txt    | 18 ---------
>  .../bindings/ata/ti,da850-ahci.yaml           | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml:20:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml:22:3: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/ata/ti,da850-ahci.example.dts'
Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml:22:3: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/ata/ti,da850-ahci.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml:22:3: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240327054014.36864-1-animeshagarwal28@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


