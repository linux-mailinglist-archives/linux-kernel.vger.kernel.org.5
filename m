Return-Path: <linux-kernel+bounces-6830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E34E819E31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2821C22790
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B9219F3;
	Wed, 20 Dec 2023 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdjayqzo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123AF1DFCD;
	Wed, 20 Dec 2023 11:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F361C433C7;
	Wed, 20 Dec 2023 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703072118;
	bh=PHkfCp3oC8pPkUYFX8Y6+a9T7xcJVv4YXf/9Z1sW2MU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MdjayqzoDkTVdbWKsCf0+4AH/vH3UNC6y3wtsfHZs73HLrMWwuxKpSfYwn55l6R9o
	 00lvlyY1NQNMT8je88ASM0Jfj2FS5RHAsJ1OieDSE+PG2TBkDRSiCjNBxr7GxMmxmp
	 Dbr5gpB6uyhkafDLByVT5mRCQ+C3lvgwVrxwDMfq+JtWNegKmd1WuplJV+9hrgvFxM
	 eKMfJa5ogIluMq0Sk/yyKpojDKudBwaz48Au/ymGnxgfj4CFp8LwwFFVKiT3C6c16Z
	 eenM6Ef6s06GYpx2TFSkAW4zao0QidqN+jhB9RsqER9UXYozw5uVASAma/ZFJTY9mi
	 YKgAkhteAMxZQ==
Received: (nullmailer pid 3474589 invoked by uid 1000);
	Wed, 20 Dec 2023 11:35:16 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, monstr@monstr.eu, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, git@xilinx.com, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <26aa3459310ba4624ccb5865ca32017357591e4d.1703066422.git.michal.simek@amd.com>
References: <cover.1703066422.git.michal.simek@amd.com>
 <26aa3459310ba4624ccb5865ca32017357591e4d.1703066422.git.michal.simek@amd.com>
Message-Id: <170307211630.3474502.10317980096869391404.robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: xilinx: Rename node
 names in examples
Date: Wed, 20 Dec 2023 05:35:16 -0600


On Wed, 20 Dec 2023 11:00:29 +0100, Michal Simek wrote:
> Rename zynqmp-power node name to power-controller which is more aligned
> with generic node name recommendation.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - New patch is series
> 
>  .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.example.dtb: power-controller: '#power-domain-cells' is a required property
	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.example.dtb: power-controller: '#power-domain-cells' is a required property
	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/26aa3459310ba4624ccb5865ca32017357591e4d.1703066422.git.michal.simek@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


