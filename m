Return-Path: <linux-kernel+bounces-144987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81B48A4DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90623283AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC95FB93;
	Mon, 15 Apr 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW1+ShCg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877D5D49F;
	Mon, 15 Apr 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180463; cv=none; b=QvU4v3OCKW3FKcRAhQgSMorWv9CfKqJbJmGhQ6/AFyCzH2rMKeDEJZOsqhn6G5h/NE9Vdf/1BAxx3LaLiKrOxNjO5dCpovxU/y2dVafDsvGmeyGDd/tEp+Z9x2fWRG12e8DvTrfzeawOUrdW9xu0+x/JVQLoIQxHpdVq6qgcorQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180463; c=relaxed/simple;
	bh=FE+i4A70L7DRRL+U0mi5Ziz97jbyagDFCw1I4beVKMw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=uV+gGDeiM8TZ0TTQviuUEUalhziUSpZ8V/RuABVgnV21qnj6kKNUZvsLp5FsgwkMCzAYNQRfa3cXfOVu6mWSt29AblaGXnTXyJUGIqzrtHn/TCds/UZQyUSvOmWiDEf3kasTEzE6DRo/qkwfBwB/f3br2XOBARvFTLSZlw4jWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW1+ShCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E5BC113CC;
	Mon, 15 Apr 2024 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713180463;
	bh=FE+i4A70L7DRRL+U0mi5Ziz97jbyagDFCw1I4beVKMw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BW1+ShCg1VAfxs+Ck7wYiiXN6PpqtM4LfVjrdNe7ZlzBLK3/Lru9zS8Zmunvqy+nc
	 ocmPHWfwSV8WfTfqDubrINXno/VHb1hHmEdU61UGVJi6TJIn7bW5sqT9yxUoIqaRAX
	 Mx3mfu6KLLWgL03nRZ0vjY/rgb7+irhRvnrbmg79/LIGyqazxpt/huyctxeVWKhHKt
	 nelcLknBE4GJZBjzS2IQGJEh5EydRwP/t3j7hb60yasMJeMWi9RiYkjYtHJjpTPGg1
	 6a0sQv7d/+ip2nn+Ny1oUPEgXU7b+5m+OpdpVgaE299epp2eGgKmRE2trbOOgD4oYC
	 yp0oRgveyVNRg==
Date: Mon, 15 Apr 2024 06:27:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Mighty <bavishimithil@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 alsa-devel@alsa-project.org
In-Reply-To: <20240415103523.139-1-bavishimithil@gmail.com>
References: <20240415103523.139-1-bavishimithil@gmail.com>
Message-Id: <171318046103.2331667.2375787628199943181.robh@kernel.org>
Subject: Re: [PATCH v3] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema


On Mon, 15 Apr 2024 16:05:23 +0530, Mighty wrote:
> From: Mithil Bavishi <bavishimithil@gmail.com>
> 
> Convert the OMAP4+ McPDM bindings to DT schema.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
>  .../bindings/sound/ti,omap4-mcpdm.yaml        | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/sound/ti,omap-mcpdm.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240415103523.139-1-bavishimithil@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


