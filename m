Return-Path: <linux-kernel+bounces-153442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083278ACE25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37411F21CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAFE14F9DE;
	Mon, 22 Apr 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD3T44zq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3514F13E;
	Mon, 22 Apr 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792441; cv=none; b=B/s9QIRWi/mRliBpb7ayzSPJekQ94jI0Zol9PCWlftDVMk+jEdDoaK8opYC01PTuhjy+G/noRdgKM1vFvEpavXPQlmUEQTvubfodR/lGKzzAkNPCXCkq08d/YrfpJhQu0oPy2TWYeIxQMiS02phQIYituu7rp/OS6cuPD8MKRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792441; c=relaxed/simple;
	bh=H1irkZGAWDGw5VgXFMcSc9/h4VYnX/SA9x7f6oCAJHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toTuk3mUvZxILU8/OwoCRmURyQWLfJ2Jz4IGm8jmFPBzmyRRd3WL9oGm4wWXfy4AW5pawB4cyH4SocsVatSOluIBmAHjWrp9TWva7UxsWKeFLICLDYeMsphlSERl32YHfXqh4GcYVYCT37LL96RffryStPBQUgSPPjX3QC0Uk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD3T44zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F3C113CC;
	Mon, 22 Apr 2024 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713792441;
	bh=H1irkZGAWDGw5VgXFMcSc9/h4VYnX/SA9x7f6oCAJHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XD3T44zqo7lkJUIG5AKmE/ZColS0jrrrLLSrn57pDMg/VjWid2KoOsWDf402WBEO7
	 UglCDO0cKpc+fv4PiHxs8gJzUTZ0re6hCCpVbYt8Iv8RvnMnkJqIyZR1z0N6Bpnmov
	 RbU6F+Olqgykq2KwJZAftLAm4dk5Dn4RpMM1wsGzOWsrNHZ5okSwxmyAPa6xT+UHH+
	 uT/ZJGVw0AghZ6aLkdiQmWEa4pzW1rqF6ye6Kp+PzLxH/nu10Zt5CJvv4VrzfJfnLR
	 vvs1Ja56OUscELNYHziALrk/bU4z9yuIx/Sq0jd98WaRYxTY1S8yKvQmsqj9yJYdZt
	 v7tk6625G0HGw==
Date: Mon, 22 Apr 2024 08:27:19 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	broonie@kernel.org, linux-mediatek@lists.infradead.org,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, amergnat@baylibre.com,
	linux-kernel@vger.kernel.org, gustavoars@kernel.org,
	keescook@chromium.org, henryc.chen@mediatek.com, wenst@chromium.org,
	matthias.bgg@gmail.com, djakov@kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/7] dt-bindings: regulator: Add bindings for MediaTek
 DVFSRC Regulators
Message-ID: <171379234629.1115290.1388746342600815292.robh@kernel.org>
References: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
 <20240418094134.203330-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418094134.203330-2-angelogioacchino.delregno@collabora.com>


On Thu, 18 Apr 2024 11:41:28 +0200, AngeloGioacchino Del Regno wrote:
> The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
> are controlled with votes to the DVFSRC hardware.
> 
> This adds support for the regulators found in MT6873, MT8183, MT8192
> and MT8195 SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek,mt6873-dvfsrc-regulator.yaml     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


