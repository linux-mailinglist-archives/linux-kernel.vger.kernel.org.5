Return-Path: <linux-kernel+bounces-157700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4458B14BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA0F1C22D99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8516F26E;
	Wed, 24 Apr 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmnTXxNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23115697C;
	Wed, 24 Apr 2024 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991001; cv=none; b=TGkHmVNbpqCY9iaSqR23OECTk1RCBD8aQnRKyptPe4jF2Wi0ix5P8QhXLxudQMy0CRwfBlziY2azqDGDorcUXak0zLY+Tu3/9OXSce2GKWf6f2JS24IehaUKvIfCvgSY/utL5fkZUKEGo7OerG2TyyHFAOT1LPKks4E5VIeVC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991001; c=relaxed/simple;
	bh=UEgXZYAvAoXydEPAsKWLpvLdEps8+VNW/bTxW6GL48Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=F2gZuuVJ5ewvMZSRnzn662aH02psKA7vku3NLSMsAyrcPfT3+r947VEReSomlah6ALyox4w1X5DSUW+CtjNf2sN+VoLAf8c93PXH35+3kQL1XsAzmej4SGnDdP6dQ/KMtzGH4J4mFQ92uX3+JzNdWpJBYG6uxu6fAUNnsXnulUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmnTXxNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79479C2BD11;
	Wed, 24 Apr 2024 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713991000;
	bh=UEgXZYAvAoXydEPAsKWLpvLdEps8+VNW/bTxW6GL48Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VmnTXxNbqN8kryduvL4VwlkwONiI33c3dkmk3fq69bO/O4Wo6P3yC8OwE6d+lcA/r
	 UHz8wdD8gvoIk2EefN5xKUtZERsYZr03gutChcHXVRIE3YznyepTqY7bhT2Bmvr/xB
	 xdh2cU7+xGMiIep3JrOrvWABxaLmeaZZPrKtNfRfqQmqZCmjkfFkTEt1CZLYrSenT2
	 sZr5RfS3uKdTLD5lxekFbIhNoGm2aQPmj7LeR1Z8+s1IHTto8k+lgSgAJVZHZnN5Mu
	 kxDZC+Qi+70sN2x5exaHfQnmFPkPzu8frFTGaq75d01E+pMetSgSo2ehK1MfMT2TVT
	 9+Vt1zYmkD3xA==
Date: Wed, 24 Apr 2024 15:36:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Bjorn Andersson <andersson@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Hari Nagalla <hnagalla@ti.com>, 
 linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-remoteproc@vger.kernel.org, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-arm-kernel@lists.infradead.org, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
In-Reply-To: <20240424190612.17349-2-afd@ti.com>
References: <20240424190612.17349-1-afd@ti.com>
 <20240424190612.17349-2-afd@ti.com>
Message-Id: <171399099843.670532.4326365049493230346.robh@kernel.org>
Subject: Re: [PATCH v8 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x
 SoCs


On Wed, 24 Apr 2024 14:06:09 -0500, Andrew Davis wrote:
> From: Hari Nagalla <hnagalla@ti.com>
> 
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml: Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240424190612.17349-2-afd@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


