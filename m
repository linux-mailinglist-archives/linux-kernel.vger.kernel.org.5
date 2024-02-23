Return-Path: <linux-kernel+bounces-79216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4790B861F13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77CEDB23A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393914C5AA;
	Fri, 23 Feb 2024 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ger20FJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8E3149388;
	Fri, 23 Feb 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723852; cv=none; b=Sa3yS0bG2oOAEJTOmZ7MljiONIYH8VHBD5w1F12VoDY1wlA9fTIEQX/OeusC9Dch3I8n6cfE5c4HGzP0EA0QJDql0caKxD2pcbuXV4ZQ0/gWWrDAoRSw9TOCklG05BXDGj3NerMx0W2r5HMIh7LXmM+/mdEaoPV/ictEW4Aat2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723852; c=relaxed/simple;
	bh=sfcwH5sN+SrxnyVjSE5DI8NCCDVtVWK2Te2B9pfPfxM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MxHwEs1lvXEu7yTQm2XFUVQPxvQMmc+XEBijKwi12Z9+RrzDQ9jA4n7YIyL35L0tDe8Mt3eJWSoNzl3/+df2NrA+PqiPf+3L079o9p3At96BSxcAeoiBqx+cW2vQxyFbWuoMbGZlSV6zp88zJXNjdYit4a4/d1JI3yb7ObUcn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ger20FJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D1CC433C7;
	Fri, 23 Feb 2024 21:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708723851;
	bh=sfcwH5sN+SrxnyVjSE5DI8NCCDVtVWK2Te2B9pfPfxM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ger20FJEYVzroSPks6ThGRlupVxZvVrbImq3SbmeFnwGnUfxYhWq1MRdi2ZasDUpo
	 NLCAYfyYLa1289Ptq3MqfszbUhtbxAX2yQmLNlfnWvUUifZHjeOIqgrW0ii4+xnGNW
	 2K+d5x909zgVTiPWI3LMD/kSptmhcqOopb5yG3bFakcVLCpR+uWzAUjQ4Tace765Ms
	 UmFmzzZox6zaNfWOJcHO+z2TLShFQhx5AlV3+EOTXxDumlFWLY6i7GPioapHEkMBjK
	 h/ZL5ld4wAdurp0cXrIYA4xeq9anjUpm+xprI+SNfypA4DJbk6+5bN1oyz+HiM9f9b
	 UXYLmm7KELNNA==
Date: Fri, 23 Feb 2024 14:30:47 -0700
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@foxmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
In-Reply-To: <20240224-dwc3-v1-1-7ffb2e2baa73@outlook.com>
References: <20240224-dwc3-v1-0-7ffb2e2baa73@outlook.com>
 <20240224-dwc3-v1-1-7ffb2e2baa73@outlook.com>
Message-Id: <170872384596.3677869.9541717798741821865.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: add hisilicon,hi3798mv200-dwc3


On Sat, 24 Feb 2024 01:17:49 +0800, Yang Xiwen wrote:
> Document the DWC3 controller used by Hi3798MV200.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.example.dts:34.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240224-dwc3-v1-1-7ffb2e2baa73@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


