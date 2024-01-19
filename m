Return-Path: <linux-kernel+bounces-31275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AA832BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C21E28720B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53E54BC7;
	Fri, 19 Jan 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqIYDbdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE654770;
	Fri, 19 Jan 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675858; cv=none; b=XIPk00nPCGyJK/jNhvh/iXyFcs1g+sVH9KMZ80V5aXULitgFWx7s+03W7iVPmCdVG+bdkM7v+Ot3dWLuyMAeX5ebM8M5dzfmKhm7Qy77um+RS8uhBjTpLcDUcvxbJ3K1Bx+aBvYDG7MZ/nJGb7ZHHgWFD/ilzL4qHayHedcbZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675858; c=relaxed/simple;
	bh=fIf/QmB4/ZHrU+Xkylg228wL8h0iiEv1xx/gOxuxHm0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FilzBx/zu0Hd9/87p9857gXUSmBAxY/0fKpBzepdDuxIaIstJ83UCvZ/TqF4cA/yrUJH453JMyRZpKEIWKawh9WZYpsnkTnoo4St6Nd5AXqRigzyqEltfOP+vj03yeraTxRlFMCzIR3HPnaDfobrRk9KesAYNKRZpGnkbOZ3YlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqIYDbdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DADC43399;
	Fri, 19 Jan 2024 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705675857;
	bh=fIf/QmB4/ZHrU+Xkylg228wL8h0iiEv1xx/gOxuxHm0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VqIYDbdvCrKoCXIz6+bB2jES+W6EmKcKkGPAabLaTw0t9k9ojhLQRJV9QqRJSjBuW
	 vT5D8N0jxgip8asRQfBhJVhTm++4bZ9GMHLN2WitB1O7jj4wikYAeUVVlb5WvezLhq
	 yyYbbNyKGrkrY4gadPrVEL+0IgtyfU0JSsz7y1glcS92vscZ46JUvInQvJ/HrT1Z34
	 7pqFz1hHZKqrCVkoBU5N85dFMrmVKTw6i1EZFcab3xuuMbrEMJWHHstUf4mXdjpFSV
	 AI3YXyvt9GrSQdIjQUUpEx4y5vuHMvIIeowI6lPUAjo8DBweNcBPDXIldP3LOrf2Ab
	 QLmlc8nFFAwvg==
Date: Fri, 19 Jan 2024 08:50:55 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, 
 "Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org, 
 =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
 Conor Dooley <conor+dt@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
 linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Zhang Rui <rui.zhang@intel.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240119132521.3609945-4-o.rempel@pengutronix.de>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
 <20240119132521.3609945-4-o.rempel@pengutronix.de>
Message-Id: <170567585226.287205.10607278595799788227.robh@kernel.org>
Subject: Re: [RFC PATCH v1 3/7] dt-bindings: power: reset: add bindings for
 NVMEM hardware storing PSCR Data


On Fri, 19 Jan 2024 14:25:17 +0100, Oleksij Rempel wrote:
> Add device tree bindings that describe hardware implementations of
> Non-Volatile Memory (NVMEM) used for storing Power State Change Reasons (PSCR).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/power/reset/pscr-nvmem.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml:32:16: [error] empty value in block mapping (empty-values)
/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml:33:22: [error] empty value in block mapping (empty-values)
/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml:34:21: [error] empty value in block mapping (empty-values)
/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml:35:25: [error] empty value in block mapping (empty-values)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: properties:pscr-unknown: None is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: properties:pscr-over-current: None is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: properties:pscr-under-voltage: None is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: properties:pscr-over-temperature: None is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: properties:pscr-unknown: None is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: properties:pscr-over-current: None is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: properties:pscr-under-voltage: None is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: properties:pscr-over-temperature: None is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/power/state-change/pscr-nvmem.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml: ignoring, error in schema: properties: pscr-under-voltage
Documentation/devicetree/bindings/power/reset/pscr-nvmem.example.dtb: /example-0/power-state-change-reason: failed to match any schema with compatible: ['pscr-nvmem']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240119132521.3609945-4-o.rempel@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


