Return-Path: <linux-kernel+bounces-102759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05287B6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3451F21F76
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF25664;
	Thu, 14 Mar 2024 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbiWQZRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F883FE4;
	Thu, 14 Mar 2024 03:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388441; cv=none; b=d2scbxi50WkkobfEsixikx6b5armnANiIrOQNr4sEidINa3Kk6gYjG/MJbtdxFskxK9doInfcQI/R4PMD6PfUVvHeRUR4lFPujd5k5ioT8U4MEbo2O+fXxpOrq0BjDk2jUn9C1siEAnfDrVWzMWOQV/xQ303ASvKcILNmJoY1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388441; c=relaxed/simple;
	bh=rcgMvEmq2ixSXP+IeYxrksDnBiZXb7HZ9xOUnpCsZkE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZK6R22wNQhO2QPSa2viSSvl2Z5LCB56XX4JRYYiSuiyMEerCfoaO54sZRN6CR5YBdqqqRWfyKuxFrNdiTp7MlYabLLClYoF94q9vORUAYDJjgVTjKIPu2YzTk9F+Tut4gKs4d8148GhHmEi+LPrqHAMpe2TjvWc4uMw7PeIxB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbiWQZRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F853C43390;
	Thu, 14 Mar 2024 03:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710388440;
	bh=rcgMvEmq2ixSXP+IeYxrksDnBiZXb7HZ9xOUnpCsZkE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MbiWQZRakVgAofeGA4wacxNF3uc+0FIUDo5NOCA98EEofSdUtDcbQVDP9Ofg52eBt
	 LyPkoLbsru/kJ9DwXlY45Hh+tezGiE9dyOpbgx4JhdqveuDQxINtB7uz3mjSPkqyON
	 jsA1LBYy3dTIgqQZ364sUYFeSJh0VBxUBH4k1tL7fj5f6yLUPnx2Zk1FM9YdIFi5Py
	 QfHDn0UqgaMpcKpJkb3DwcXrutH0q92PL/rcgw6u7hhz/Z83gJveGboK4GSV1UB5IG
	 yRO4xFQGiFAtuSg4aroDJoZOZlYTboM7rjER3Y6Ei8k1qFt6U4eKO3Uz4BDRo9X7rY
	 8h9WH2wKi8q6g==
Date: Wed, 13 Mar 2024 21:53:59 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Conor Dooley <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Michael Walle <mwalle@kernel.org>, devicetree@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240314021754.84557-1-sjg@chromium.org>
References: <20240314021754.84557-1-sjg@chromium.org>
Message-Id: <171038843809.1875072.5117887571496305012.robh@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: mtd: fixed-partition: Add binman
 compatibles


On Thu, 14 Mar 2024 15:17:53 +1300, Simon Glass wrote:
> Add two compatibles for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Note also that, after discussion on v6, we decided to use the same
> 'fixed-partition' schema for the binman features, so this version
> adds a new 'binman.yaml' file providing the new compatibles to the
> existing partition.yaml binding.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v7:
> - Adjust MAINTAINERS entry
> - Put compatible strings into the 'fixed-partition' binding
> 
> Changes in v5:
> - Add mention of why 'binman' is the vendor
> - Drop  'select: false'
> - Tidy up the compatible setings
> - Use 'tfa-bl31' instead of 'atf-bl31'
> 
> Changes in v4:
> - Correct selection of multiple compatible strings
> 
> Changes in v3:
> - Drop fixed-partitions from the example
> - Use compatible instead of label
> 
> Changes in v2:
> - Use plain partition@xxx for the node name
> 
>  .../bindings/mtd/partitions/binman.yaml       | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman.example.dtb: partition@100000: Unevaluated properties are not allowed ('align-end', 'align-size' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman.example.dtb: partition@200000: Unevaluated properties are not allowed ('align' was unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240314021754.84557-1-sjg@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


