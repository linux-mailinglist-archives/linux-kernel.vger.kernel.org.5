Return-Path: <linux-kernel+bounces-112099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7465A8875C2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EBF1C22533
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE67982C7E;
	Fri, 22 Mar 2024 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHkhM23K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D21CD00;
	Fri, 22 Mar 2024 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150121; cv=none; b=L2KHDehsU26iY6EX7rWvmza2DGaOHd3dIXP3bken7wbxJ7iTmnfRX62ngYW/lWli6NmKNE4snuk+WsTLxCWuPxUkAXzR9EyZVut5Z8MFRaW3JnL9RCZBq23rbWrOxQlVGThD8S2Dtv/w0M15KcYz9jcVwq0OOSXCThjd8VvKGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150121; c=relaxed/simple;
	bh=YFtHhfLzz8/7v1vBubH8h8uEuI/BziV8a0nXHGeydRI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UqippLzjQC1lwM5anVE1rrs/DKBOBi+A5LF3UBalgJ1RZiU1NQ30vE9z+yXnF7OG5ojrA/VpDqGyv9eYP6TADoPQSFV6fXPFW7wgEBolxBzJP4EZByJHD382IyusHPXm6lm6MsoRtL/pV1IbEOsiiK3DzEFZOWmbO+wst8p5Me0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHkhM23K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55671C433F1;
	Fri, 22 Mar 2024 23:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711150120;
	bh=YFtHhfLzz8/7v1vBubH8h8uEuI/BziV8a0nXHGeydRI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HHkhM23KGT5NLvz8CwrOm8UxPYtJv5Dcx0ZjeZFnZjeP1U6/LpfShNLtBwkQtvNd5
	 MYUluD1pAyBycVi+4mBai/H6Hxy537sTei0Kd1GIcYqSLVDpj1RhkC0GYJupg7Rh77
	 06TVErmWbvluefyR0tziVRzGG8LbqcSOVXYe9Nf6PU07bgnafkt3ZUiujEdCH2rUQi
	 dfvbFCEOa/1j5VBUJd5crAGmRiUuL8j0NgBzAyoc5QJWkPjjWtMJ/mYNIejDyRyd0E
	 5YncAZSITZQbc9lk3USR/2RUlVIZHTb439LRgGb2opN02T8mm0j0/feYVcW8f+V0KC
	 4g7ssUfhrvL3A==
Date: Fri, 22 Mar 2024 18:28:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 marcelo.schmitt1@gmail.com, robh+dt@kernel.org, devicetree@vger.kernel.org, 
 lars@metafoo.de, linux-iio@vger.kernel.org, jic23@kernel.org, 
 Michael.Hennerich@analog.com, linux-kernel@vger.kernel.org
In-Reply-To: <81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
 <81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
Message-Id: <171115011818.1710405.2845384923597786826.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add AD4000


On Fri, 22 Mar 2024 19:05:08 -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4000 series of ADC devices.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Pasting relevant comment from cover letter here to aid reviewers.
> 
> These devices have the same SPI (Strange Peripheral Interface) as AD7944
> devices, which has been documented in ad7944.rst [1].
> The device tree description for SPI connections and mode can be the same as of
> ad7944 adi,spi-mode [2].
> Because ad4000 driver does not currently support daisy-chain mode, I simplified
> things a little bit. If having a more complete doc is preferred, I'm fine
> changing to that.
> 
> [1]: https://lore.kernel.org/linux-iio/20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com/
> [2]: https://lore.kernel.org/linux-iio/20240304-ad7944-mainline-v5-1-f0a38cea8901@baylibre.com/
> 
>  .../bindings/iio/adc/adi,ad4000.yaml          | 151 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4000.example.dtb: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4000.example.dtb: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


