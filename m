Return-Path: <linux-kernel+bounces-4368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9A817C23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0111C21BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791473469;
	Mon, 18 Dec 2023 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9hhpH2c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5451DA29;
	Mon, 18 Dec 2023 20:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77750C433C7;
	Mon, 18 Dec 2023 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702932392;
	bh=jvF0gWTII0ANTiYstuCAWUHP0Uf1jJzBvMRjSrV6Tzk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h9hhpH2cglsJpEFN63IIJFQdN3w+pru0ewtIJY3eUwOC60XDhS54gCHzdvz6thtH4
	 OuleOPVYGVlMzoQ/jI8CNORXglPHae8OqgBG085KTgNw5D/a+UcQUMct3zWVdNUwzB
	 YOw4vJQZLqpf+D+RUTG/JhsnZyqX8d9vsfVbXIFSsTfZVBYmTrt953VoyX3btnFk6R
	 7ECdrf2EwBFkI89vtgnCMB6Awr8zQyOVeG+ykvOgqwy2CH7Yh2Qxz3tj+RbfOZjaWx
	 doiQXxKdfo973nGRbdMUfPikHZaVmult6HBfr9EL4uiFhAPo1Buo6UWs1dWlTxaz6u
	 UcReUYBavoIXg==
Received: (nullmailer pid 58052 invoked by uid 1000);
	Mon, 18 Dec 2023 20:46:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
In-Reply-To: <20231020-topic-chipcap2-v4-4-7940cfa7613a@gmail.com>
References: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
 <20231020-topic-chipcap2-v4-4-7940cfa7613a@gmail.com>
Message-Id: <170293238435.57999.10131351062410349908.robh@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: hwmon: Add Amphenol ChipCap 2
Date: Mon, 18 Dec 2023 14:46:24 -0600


On Mon, 18 Dec 2023 20:10:32 +0100, Javier Carrasco wrote:
> Add device tree bindings and an example for the ChipCap 2 humidity
> and temperature sensor.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../bindings/hwmon/amphenol,chipcap2.yaml          | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.example.dtb: humidity@28: compatible: 'oneOf' conditional failed, one must be fixed:
	['amphenol,cc2d23s'] is too short
	'amphenol,cc2d23' was expected
	from schema $id: http://devicetree.org/schemas/hwmon/amphenol,chipcap2.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231020-topic-chipcap2-v4-4-7940cfa7613a@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


