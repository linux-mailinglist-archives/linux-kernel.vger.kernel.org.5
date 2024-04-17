Return-Path: <linux-kernel+bounces-148719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B358A8695
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C551C20A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96302146D4B;
	Wed, 17 Apr 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbUSBk6Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEBC1448CB;
	Wed, 17 Apr 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365161; cv=none; b=Wvds1jz7CqBpwjw2zfVoCXpt3kplwCTwoy1GfOMm73pvM5nOKTd4RlCD+mNo5smsxYTnq6KqEX2TSzphFYNnWqpT3D8ZSrQ7PyHvkeoPEncT1oxfLMTV92FDa4sw0bx27FtpmkhGM4uVOTi7QKeBaqqJDRcKNF9C8tAQPxuQz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365161; c=relaxed/simple;
	bh=ZQvye4lH9STIxQEy+fEJCBvieMZben0M75cWxAuq1j4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=OFiAAnkTxkuF/wAPDyEr407UvE3sJu0vF+9uzDZPzHFBK/xyLdyEu/SNAw3kvd82/iam+gx7RRnIvh3p4ErcyFqKF8OrLY4VEQ1hjbnn0puRYmqaMXo0KvJVQuujv3Y+VgjB4waz0kq8oek6NDeOCToRV4gfeY7C+tbRSWEmNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbUSBk6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA90C2BD11;
	Wed, 17 Apr 2024 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365161;
	bh=ZQvye4lH9STIxQEy+fEJCBvieMZben0M75cWxAuq1j4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SbUSBk6QbYGJuhVO8IOS8J++ios5qIsqlUVbf/3SCArnZ0ChScc3bpnDB6mtXgFxy
	 UMuKBrwMRnP9yI57eQKCftRjolZEEaTzUBB9+WLyJ6joVX5tYyLJLNpdvwcuAanh5+
	 yPt4/H6JceEFkIjBeiKQGtw+1h7gk7ntSCgGIed87Sku3OGCceRVK13JENAS7VbAiv
	 rjEKiqzbfZZ8z8gJMsVuhj777DCWeMlw1nkuy1lxNkfJt1ewky7Bj4GgsxpKpR+qxd
	 ilAEQTDfa864m4M/ViKaeG9msS6+8vPBgu8cePwDm/nhyqvijYIPsrW+Y5rB7SCqGf
	 QkPwF3n0tLPIA==
Date: Wed, 17 Apr 2024 09:46:00 -0500
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
Cc: henryc.chen@mediatek.com, wenst@chromium.org, keescook@chromium.org, 
 gustavoars@kernel.org, linux-mediatek@lists.infradead.org, 
 amergnat@baylibre.com, broonie@kernel.org, devicetree@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, djakov@kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, 
 kernel@collabora.com
In-Reply-To: <20240417091442.170505-2-angelogioacchino.delregno@collabora.com>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
 <20240417091442.170505-2-angelogioacchino.delregno@collabora.com>
Message-Id: <171336511790.2347768.12360106374334104584.robh@kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: regulator: Add bindings for
 MediaTek DVFSRC Regulators


On Wed, 17 Apr 2024 11:14:36 +0200, AngeloGioacchino Del Regno wrote:
> The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
> are controlled with votes to the DVFSRC hardware.
> 
> This adds support for the regulators found in MT6873, MT8183, MT8192
> and MT8195 SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek,mt6873-dvfsrc-regulator.yaml     | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.example.dtb: /example-0/soc/system-controller@10012000: failed to match any schema with compatible: ['mediatek,mt8195-dvfsrc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240417091442.170505-2-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


