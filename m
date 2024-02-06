Return-Path: <linux-kernel+bounces-55453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484B684BCDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7F7B23B07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A412134BD;
	Tue,  6 Feb 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJPpe0Lq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6F13FF2;
	Tue,  6 Feb 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243827; cv=none; b=kHc1MUQXOKXSn2x2Zi3g+vBjpoae7a2cAH8YaAXPVf4oGauG0toaibOrFdUPZe+avahs0KKBnPH/BJMGHWLuxs6QcURWOn1yWfQX9Ad7mULwkVTXPaq/5xASq7FDJFbODlQak56yxp4LMC4eGj8fAIIgvAStG3oOQf3pfYiiaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243827; c=relaxed/simple;
	bh=P4tdr7VlNtzN9kXz294+TUo4fwBUFBllYS4JLqJJo8Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Gr+5zIbAE0wF8cC54vU0DgEyJqPl88zBbv1RJvz4rQWMLjO0UoGgCCS5FbxVZz6Nf3y8SpLSVGEd2B+AuV5rZdUqRqCK3fJo+lQht/fYDzlMTwfQk0+Yqmj25c/XXTD2g7NmVk3Pxi/DXSgJzLbGULV6DvWmebuuERrGVMthmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJPpe0Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC91C433F1;
	Tue,  6 Feb 2024 18:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707243827;
	bh=P4tdr7VlNtzN9kXz294+TUo4fwBUFBllYS4JLqJJo8Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RJPpe0LqxliRr6FhlR6esMqeAmntIRf4UHBU+ygAKeT1t9Jl8jp118/4LHp/6uSdF
	 Y+wdixThS1ivhd2TrkAZEe6jFfWK8bzphRUJsB2J/t/JhxbGaa7hWo2fimaJr9cldA
	 l392tFzWJh1M7g0//CaHUIiyB7wHWDCCBeJiTKOkP68ZJFoG7Okf6CFQiS3rBHBSUB
	 u+/WQSqbL2gHn1fcoxKyiGGWucG5jfc3NVWoIt4rtxBhJ8F3yp7EVe09MiTwAKpYP7
	 MnyNs9/KfjGDud7LBemXUH7E4UANFGocoO8RwDmRbyP2A8f6X5L4Bf+D9Xe++/qsG+
	 P94XU6SYvx9Yg==
Date: Tue, 06 Feb 2024 18:23:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>, Andrew Davis <afd@ti.com>, 
 linux-arm-kernel@lists.infradead.org, Tero Kristo <kristo@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240206143711.2410135-3-msp@baylibre.com>
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-3-msp@baylibre.com>
Message-Id: <170724381132.1723363.3827684466667274405.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add
 nvmem-cells


On Tue, 06 Feb 2024 15:37:09 +0100, Markus Schneider-Pargmann wrote:
> The information k3-socinfo requires is stored in an efuse area. This
> area is required by other devices/drivers as well, so using nvmem-cells
> can be a cleaner way to describe which information are used.
> 
> If nvmem-cells are supplied, the address range is not required.
> Cells chipvariant, chippartno and chipmanufacturer are introduced to
> cover all required information.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.example.dts:39.27-43.11: Warning (unit_address_vs_reg): /example-1/chipid@14: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240206143711.2410135-3-msp@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


