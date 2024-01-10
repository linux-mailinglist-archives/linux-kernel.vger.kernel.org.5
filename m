Return-Path: <linux-kernel+bounces-22815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90AB82A343
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518682877AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3B4F8A7;
	Wed, 10 Jan 2024 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV/+YMoO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250D4F890;
	Wed, 10 Jan 2024 21:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01ECC43390;
	Wed, 10 Jan 2024 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704921934;
	bh=Ax58DmDjPNW74NGwRvhHHGsYqpwIGIZxv4FkZoGcxV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WV/+YMoOvCEyWpaRpYZfa87kc6mbQ0JnVBbDnIG5yf/huJPTEyQwx8cXxan8KxinN
	 6sNBXfQFoVBxzqwDGumSVysnHcLmYq9nvcNjV5hKJ7VVI/muQ0GlHvgx+x3+niVmq9
	 RuxS7Zd6MOXiXUhr0aTG2YCs+G4j0caWW01HTd+aL1Hy5Lw/lJ9cj/lZOsySBKvQWB
	 er+OO8VqSbL3cviSAhyf8p2dZWVLVPhS4OLTE6iChmLPRf4MhEPa0XRlj+JhQFQ55u
	 m/xZtqRUdeC3VwXCXxl9xZQ9TjdHsXZYksEUz4gTQpIoWVCmyU/4A+oymlcDeOrDbP
	 DQq9jAA3AdwNQ==
Received: (nullmailer pid 2648568 invoked by uid 1000);
	Wed, 10 Jan 2024 21:25:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: kernel@salutedevices.com, herbert@gondor.apana.org.au, davem@davemloft.net, neil.armstrong@linaro.org, linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, khilman@baylibre.com, robh+dt@kernel.org, linux-amlogic@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, narmstrong@baylibre.com, clabbe@baylibre.com, jbrunet@baylibre.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, artin.blumenstingl@googlemail.com
In-Reply-To: <20240110201216.18016-17-avromanov@salutedevices.com>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
 <20240110201216.18016-17-avromanov@salutedevices.com>
Message-Id: <170492192887.2648505.6187306596898979418.robh@kernel.org>
Subject: Re: [PATCH v1 16/24] dt-bindings: crypto: meson: add new
 compatibles
Date: Wed, 10 Jan 2024 15:25:28 -0600


On Wed, 10 Jan 2024 23:11:32 +0300, Alexey Romanov wrote:
> Now we can use crypto driver at G12A/G12B/S4/A1/SM1/AXG.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  .../devicetree/bindings/crypto/amlogic,gxl-crypto.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.example.dtb: crypto-engine@c883e000: compatible: ['amlogic,gxl-crypto'] is too short
	from schema $id: http://devicetree.org/schemas/crypto/amlogic,gxl-crypto.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240110201216.18016-17-avromanov@salutedevices.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


