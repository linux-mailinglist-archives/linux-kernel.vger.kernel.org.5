Return-Path: <linux-kernel+bounces-144854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C0C8A4BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88641284E99
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC72E4CE1B;
	Mon, 15 Apr 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLM/wjQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442A481D8;
	Mon, 15 Apr 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174443; cv=none; b=ayysjmiB4P2EgzqRwL8wdo79NLP/3CLCXpea376mq+9a9Ul9EW+mFkUTl5mLeU/lJdgjc7xBrppxNT0W/5kXC/X5evDuyqifCrvJYdjqhym7Hhf9C6XgpMsSsXuapmdv4kVqyMZMqXtzw9/I6smM62pNBb0ExrhSvd5m8blmsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174443; c=relaxed/simple;
	bh=b0FQxsbCgCzCZdXSzRBeyPJvArlWcYQJsyXBEM3fAlA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qP4ap2tUv/RJ9vKwgzpMWlGAFu7sw5PAiPx2dG3qOch53iNni7Aih+RTducc6Q6c64n3Ji0BIoDd91U3nyP8kKr4xfjOh9e8C0dr7KxrEBn+khOJ5KRR5xNVQ6EmoU3FFVidU5KHeD6lUMEK9I0XsHNQN5Zhsyf4OYuo5TgDGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLM/wjQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41666C113CC;
	Mon, 15 Apr 2024 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174442;
	bh=b0FQxsbCgCzCZdXSzRBeyPJvArlWcYQJsyXBEM3fAlA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SLM/wjQII2paCS4pC4cBhfQNGEVDFdfURyHeUayFWaiE2+D6NvavEMcojDphgrkHn
	 E6Fez1ZR68P+OBVzgULD1VJ+aNw5xV36f4N/ZZsY/b3WYEJM7j2gGpz6ejb8QBROqv
	 D+KpKj1Rew3XOWNWVjpBKYN5xtYYqQqWC1BQV/S0w5Sdna3qNc9h2RMaJVtBkMBVwC
	 RVkUWQoVKLWxW0OhMoKsOJ8JeRKgA35eMYNbRpVV9KCSiKqRwuesFRTP/cpTlSr5HP
	 6kBkoAN15EAb/nigY/CUAWWBHsSSUIdolmjdL91diuZLeJ1EAEfKkIZVYobV50NkA/
	 WLmT/Z5lrDejQ==
Date: Mon, 15 Apr 2024 04:47:21 -0500
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
Cc: matthias.bgg@gmail.com, broonie@kernel.org, 
 linux-mediatek@lists.infradead.org, jejb@linux.ibm.com, 
 linux-arm-kernel@lists.infradead.org, alim.akhtar@samsung.com, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, peter.wang@mediatek.com, lgirdwood@gmail.com, 
 bvanassche@acm.org, Conor Dooley <conor.dooley@microchip.com>, 
 martin.petersen@oracle.com, avri.altman@wdc.com, stanley.chu@mediatek.com, 
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chu.stanley@gmail.com
In-Reply-To: <20240415075406.47543-7-angelogioacchino.delregno@collabora.com>
References: <20240415075406.47543-1-angelogioacchino.delregno@collabora.com>
 <20240415075406.47543-7-angelogioacchino.delregno@collabora.com>
Message-Id: <171317443759.1944979.15878384209932309700.robh@kernel.org>
Subject: Re: [PATCH v3 6/8] dt-bindings: ufs: mediatek,ufs: Document MT8195
 compatible


On Mon, 15 Apr 2024 09:54:04 +0200, AngeloGioacchino Del Regno wrote:
> Add the new mediatek,mt8195-ufshci string.
> This SoC's UFSHCI controller is compatible with MT8183.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/mediatek,ufs.example.dtb: ufs@ff3c0000: compatible:0: 'mediatek,mt8183-ufshci' is not one of ['mediatek,mt8192-ufshci', 'mediatek,mt8195-ufshci']
	from schema $id: http://devicetree.org/schemas/ufs/mediatek,ufs.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240415075406.47543-7-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


