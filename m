Return-Path: <linux-kernel+bounces-11655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A781E975
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D80282FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BC14C97;
	Tue, 26 Dec 2023 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFu/e+JW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36146442E;
	Tue, 26 Dec 2023 19:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4920C433C8;
	Tue, 26 Dec 2023 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703619607;
	bh=VdzXZVqMOKGhvwNwMXvswZIyJ8DA6T8nwMQ7xFwsHv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RFu/e+JWiObWOJx9KIZT9o9FClFdgV0+lxK7WI5/6askgSyKlVXfPq82Z+l0qVBla
	 Dt9YcYriIiinnT8WZ/fzus6zssV4lOTy5/ZLJYRdmcq2GxE0yPBFylpTWrRyM8UBiX
	 Hu1DEtkzxta7nQP0bytHqipuOb+T1nP9cMS7kCLzz08uWYjGAkhlWDCkzAnc+AIQl2
	 J2YIER106f4hyLrKHm8off+pz1t8FVQJbUXTs+9dQ9burMY2G2A21sssz94b7StHne
	 avXwDiRFLJcdm9vbmcdLPK4NVN/Ez2DwNSKBf4AD/wDOMqGNpTMPN/5OHoY0Q2pvJf
	 RCNanfgfvF+vw==
Received: (nullmailer pid 2887138 invoked by uid 1000);
	Tue, 26 Dec 2023 19:40:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>, devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20231226-support-clearfog-gtr-l8-sfp-v3-3-fd1ac2d6bf2e@solid-run.com>
References: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
 <20231226-support-clearfog-gtr-l8-sfp-v3-3-fd1ac2d6bf2e@solid-run.com>
Message-Id: <170361960357.2887119.16192958166206698998.robh@kernel.org>
Subject: Re: [PATCH v3 3/8] dt-bindings: marvell: a38x: add solidrun armada
 388 clearfog boards
Date: Tue, 26 Dec 2023 13:40:03 -0600


On Tue, 26 Dec 2023 19:11:34 +0100, Josua Mayer wrote:
> Add DT compatible for SolidRun Armada-388 based Clearfog Base and Pro
> boards, which are already in place in-tree.
> 
> There are already 3 distinct dts in tree for these *two* boards,
> declaring particular compatible strings:
> - armada-388-clearfog.dts:
>   compatible = "solidrun,clearfog-a1", "marvell,armada388",
>                "marvell,armada385, "marvell,armada380";
> - armada-388-clearfog-base.dts:
>   compatible = "solidrun,clearfog-base-a1", "solidrun,clearfog-a1",
>                "marvell,armada388", "marvell,armada385,
>                "marvell,armada380";
> - armada-388-clearfog-pro.dts:
>   compatible = "solidrun,clearfog-base-a1", "solidrun,clearfog-a1",
>                "marvell,armada388", "marvell,armada385,
>                "marvell,armada380";
> 
> This has historic reasons, the first entry is a legacy name for the
> "pro" version, old versions of u-boot built when only one variant
> existed explicitly boot by this name.
> 
> Note that both compatibles and model field include the string "A1".
> At least up to revision 2.0 of the board, this had been printed
> on the pcb. However in marketing material and conversations it is
> usually omitted. "Clearfog Pro" and "Clearfog Pro A1" always mean
> exactly the same product.
> 
> Technically Base and Pro variants are similar enough that they can
> successfully boot with each other's dts. Hence it makes (some)
> sense for them to share the "clearfog-a1" compatible.
> 
> Add bindings for the explicit variants including base / pro suffix.
> The legacy "armada-388-clearfog.dts" is not supported by these
> bindings" as it does not make sense having two bindings for one board.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../devicetree/bindings/arm/marvell/armada-38x.yaml          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml:46:14: [warning] wrong indentation: expected 14 but found 13 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231226-support-clearfog-gtr-l8-sfp-v3-3-fd1ac2d6bf2e@solid-run.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


