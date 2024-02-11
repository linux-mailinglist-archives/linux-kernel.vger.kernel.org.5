Return-Path: <linux-kernel+bounces-60971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB5850BC9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C0B1F22071
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD59125CA;
	Sun, 11 Feb 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns/TWa43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0CFBF0;
	Sun, 11 Feb 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707690761; cv=none; b=TjxBU/eqUCKfQAH3B78il4lyJxaM1zuk0fhZehLOhE6teBSkUj2jApSeSCeDuDl9E4CDuve7ERf9QAvx/7JKiKB0JIIWjrjJJizj5JtPNGBT3r4i1NruQCbJ/slS/2zvRHxndp1caq4dF6dy70f67v4K70DJvA6wbBTOfC3sdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707690761; c=relaxed/simple;
	bh=zoK4wRIH61AhhcB8eZbYlC0YkWtpVzhdV4ljtB0iK8M=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=j5GCD53aHStiVcPKpPJt9JLzVru0Lt5Fzyefgj4li1I67MPaohNMWXfePeuLfgxPBOX4a8Dj7YfChMfQyWcDbr4DEyPS6WGRxnXJQThKLp12hPBrXE/IjKd4txxIL2Y3FFwU4Jo+Qc+ewuTbX03E2ypk137MDtx0GiW8SZKU5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns/TWa43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588D0C433C7;
	Sun, 11 Feb 2024 22:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707690760;
	bh=zoK4wRIH61AhhcB8eZbYlC0YkWtpVzhdV4ljtB0iK8M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ns/TWa43D572D5Gz+6TXJU0hnE4dvh2+d2PNNtTp7tg3iW3MeDIR+FjOr1toHiP0j
	 nUUx4Xd/4yxdZC7d2lhyy0FF86MDCXYbns9kroHbN62rSpNvwxhNeXlmJXZ5QDrCR+
	 e9OkXP9VzuzkQFvmEolUESwbUqi5H57fWS1aO86Kga6Cd0r8ctOJbzzt/jZ+UAhWpF
	 XlOiCyAHU1XDst0yhI/W0+6opwpykLYRIdUNwZHF3IaS/TZRSD9/ney6A7p59xOzE5
	 L96PaVHA2wzkH5cMh16zYNzSvYF+bM+WxEaLkGsTgR+jXK/8v39lxkHKVL/nRUGk5z
	 YGauiH3bIS0dQ==
Date: Sun, 11 Feb 2024 16:32:39 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc: linux-iio@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>, 
 devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240211205211.2890931-3-megi@xff.cz>
References: <20240211205211.2890931-1-megi@xff.cz>
 <20240211205211.2890931-3-megi@xff.cz>
Message-Id: <170769075818.2433614.5244889858722764083.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for
 Voltafield AF8133J


On Sun, 11 Feb 2024 21:51:58 +0100, Ondřej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Voltafield AF8133J is a simple magnetometer sensor produced by Voltafield
> Technology Corp, with dual power supplies (one for core and one for I/O)
> and active-low reset pin.
> 
> The sensor has configurable range 1.2 - 2.2 mT and a software controlled
> standby mode.
> 
> Add a device tree binding for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondřej Jirman <megi@xff.cz>
> ---
>  .../iio/magnetometer/voltafield,af8133j.yaml  | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml: properties:compatible: ['voltafield,af8133j'] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml: properties:compatible: ['voltafield,af8133j'] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.example.dtb: /example-0/i2c/magnetometer@1c: failed to match any schema with compatible: ['voltafield,af8133j']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240211205211.2890931-3-megi@xff.cz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


