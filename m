Return-Path: <linux-kernel+bounces-148720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C498A8699
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2431F211C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9431448CB;
	Wed, 17 Apr 2024 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNiKY2ln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA4146D78;
	Wed, 17 Apr 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365164; cv=none; b=CA2Dt/qkS6SU/MkAfMp57rYXXOqLDxwxsp1JkobRfwEaVAJGOqtcvfPD4qZjK7y93q7/vC6TK/Ndm3bjtlj1CkrKnEnQcZGFNG6PBbpH+WKBkMfXH3LWpqtXl8Bu6mgFc8/cUKgOwc+7+aG0JfBPm6I8O1fcTW1u9jmE2PCuWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365164; c=relaxed/simple;
	bh=prPpqIgiR4oXSxGZdm2JqXUifFqx02INBPy2HFhAkmQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SYWvI/PLpFP5q8mUERkYJBm+uhj0Q1N9Wq/F0hItaVZRYndR4gAA4aicb2/drJt0/X3HmxgotaegaqOdT2Qm0dtaYwutCs9JQWtKFTWe0FQQaOnXZK11akr+NNfrEuXGCLinUgps/U4426/rjfKBjHWW0kNJlAx27wYSN2+4qSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNiKY2ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F455C072AA;
	Wed, 17 Apr 2024 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365163;
	bh=prPpqIgiR4oXSxGZdm2JqXUifFqx02INBPy2HFhAkmQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eNiKY2lnozJF11dncEK2YbaJceSMgiwx58CzqwYYQEB5wKVOJZmLgtgTQqOqm8j8j
	 F9tQ9uB9D8bFmgcCHTKgp6fkrJdhNhBrdNkmkYe8bV5NPzotpwPvjDeVhDeURVWgIc
	 DgNqBDo1j+7HH4+/KXpdKBrvCm0b0DkpomHDCvsKe382SCerBfbUKy1KiuLqC8SE5v
	 06YBGe8EikMoM5t2caquC6eV1rT/XaeQmYaRtmmERF5+w4JlKLmQDYsgbx5DXXbPdF
	 CnM7JPxLhD0RaBu4JbIsGzFrZ38N7KViL0Mtba9puEh8hxaM0p62uki5t94C1lEOL8
	 nBZBFIh8FIYkw==
Date: Wed, 17 Apr 2024 09:46:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: broonie@kernel.org, henryc.chen@mediatek.com, 
 linux-kernel@vger.kernel.org, keescook@chromium.org, djakov@kernel.org, 
 amergnat@baylibre.com, krzysztof.kozlowski+dt@linaro.org, 
 matthias.bgg@gmail.com, linux-pm@vger.kernel.org, lgirdwood@gmail.com, 
 devicetree@vger.kernel.org, gustavoars@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, conor+dt@kernel.org, wenst@chromium.org
In-Reply-To: <20240417091442.170505-3-angelogioacchino.delregno@collabora.com>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
 <20240417091442.170505-3-angelogioacchino.delregno@collabora.com>
Message-Id: <171336511841.2347811.4883072068871368220.robh@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: interconnect: Add MediaTek EMI
 Interconnect bindings


On Wed, 17 Apr 2024 11:14:37 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek External Memory Interface Interconnect,
> which providers support system bandwidth requirements through Dynamic
> Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.
> 
> This adds bindings for MediaTek MT8183 and MT8195 SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../interconnect/mediatek,mt8183-emi.yaml     | 76 +++++++++++++++++++
>  .../interconnect/mediatek,mt8183.h            | 23 ++++++
>  .../interconnect/mediatek,mt8195.h            | 44 +++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
>  create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
>  create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.example.dtb: /example-0/soc/system-controller@10012000: failed to match any schema with compatible: ['mediatek,mt8195-dvfsrc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240417091442.170505-3-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


