Return-Path: <linux-kernel+bounces-2628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF16815FAE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6E11C20D65
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055045BE9;
	Sun, 17 Dec 2023 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqzVdyF2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A545957;
	Sun, 17 Dec 2023 14:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD6EC433C7;
	Sun, 17 Dec 2023 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702823089;
	bh=iZ7GtTTkDKgZv+f2+dAAD9uum4soymgyti+OqdtevNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fqzVdyF229vhYJqvkuotK/yeL5d3GnXBRroR8wz0X+bG6CQGJRH/457fHTjhoAnv1
	 tHQSAbYmVbNhlQ61OgqZ3O+zdg+aAWrBWcMIlv22R46yYCQpOqMj6UZ9tVjik+MVEa
	 QKQU7WzbTluTCLJ+Ju8YjGukuXiIbdiEjasASkyXrnpta+Nv7LgXVAG4CBGv+W+6Du
	 arv6jpPBA6u3+qhDBnQc4zJ0DO9tzofMq8s66+IpLPs0Ezk0/cYKsae1JO/FrGLY5I
	 xvaTsnyq9gE16n7E0IUCE1Ue2JznqiuvbGyXvJu8Fg1H45KygnDJZGwkhiLAecEzKT
	 +xvzAzLna75DA==
Received: (nullmailer pid 876443 invoked by uid 1000);
	Sun, 17 Dec 2023 14:24:42 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20231217-tps65132-v1-1-73c69a960d28@apitzsch.eu>
References: <20231217-tps65132-v1-1-73c69a960d28@apitzsch.eu>
Message-Id: <170282308261.876422.2237767392476986368.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: regulator: Convert ti,tps65133 to YAML
Date: Sun, 17 Dec 2023 08:24:42 -0600


On Sun, 17 Dec 2023 14:21:39 +0100, André Apitzsch wrote:
> Convert TI TPS65132 bindings from .txt to .yaml format.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
> Note, we still have to find a person willing to be listed as maintainer.
> Suggestions are welcome.
> ---
>  .../devicetree/bindings/regulator/ti,tps65132.yaml | 81 ++++++++++++++++++++++
>  .../bindings/regulator/tps65132-regulator.txt      | 46 ------------
>  2 files changed, 81 insertions(+), 46 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231217-tps65132-v1-1-73c69a960d28@apitzsch.eu

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


