Return-Path: <linux-kernel+bounces-153960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB08AD553
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312BB1C20FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ECC155399;
	Mon, 22 Apr 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce1AW8py"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9C155335;
	Mon, 22 Apr 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815876; cv=none; b=DCNquyufkN132oc0OclxSBfj6T1CzT7SHafhSHQk61yCEOQsPeltbHZIcDWP33AnS0AJIA9VAemcE90lykcDkr8ACT40FfaVu5fDvvYtqLIfFRWzJgaFNSgqCC262cSkGf9xeQUTVggSX7uOxIGAFg8wVvT5PfVeY6i7RY9pGgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815876; c=relaxed/simple;
	bh=BqexFMnj6FKBjoiD6ebLJAr7HwI2T8jGP8Fq/J0QtZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO9U2qplV7OrVgvQaxt28jm9YUC5xB1RBeSdCm+EetQMN1kwa9iM1dxO3Mgz1EAZXZwDJXKicxtgwigMn8IB7x+bEegOs+Okioq6mOvpewa4SvLIKpVs2ysNvvC6FuVquB2DvpVk+PAdsKwqcxEALuIWlzw6Z4n02TpLuJeSYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce1AW8py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEFFC113CC;
	Mon, 22 Apr 2024 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713815876;
	bh=BqexFMnj6FKBjoiD6ebLJAr7HwI2T8jGP8Fq/J0QtZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ce1AW8pypiK3pIaFn7SUT8wJ6RCXQwE6G+XTSKxu/aTq5K16IOSSm2bomH/rmE3jQ
	 QMOpLRIv52oQn1vZu3IDM+PVjX7kkPBxjuWrzakOoXSmzj9vOEkWs7qJ2VrTKnWvGY
	 LqccbCzSd6rB1ccTp/ifLSYMJibLh8sJcPoyIc2tnQmvGIPSwF/0vUMIq1vvnOiSnu
	 j+wnBhLtT3HBw7ZLN2uvXR03OVg8e18k57m76LH1K6Q6aMEoBHAwynm9EUSbIHdp0M
	 0DvXRuoxARuYtHXLQfXlNVDEH0IN+M+YtUhfUnRC1HLgG08N3fwP8T+7lbaW0rB5fn
	 IRtwThwzUJ6uQ==
Date: Mon, 22 Apr 2024 14:57:53 -0500
From: Rob Herring <robh@kernel.org>
To: Kartik Agarwala <agarwala.kartik@gmail.com>
Cc: linux-kernel@vger.kernel.org, angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org, matthias.bgg@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-mediatek@lists.infradead.org, broonie@kernel.org,
	linux-sound@vger.kernel.org, conor+dt@kernel.org,
	lgirdwood@gmail.com
Subject: Re: [PATCH v2] ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema
Message-ID: <171379813505.1260837.7563285425147959657.robh@kernel.org>
References: <20240421033129.13076-1-agarwala.kartik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421033129.13076-1-agarwala.kartik@gmail.com>


On Sun, 21 Apr 2024 09:01:31 +0530, Kartik Agarwala wrote:
> Convert mt2701-wm890 bindings from text to dtschema. This is used by
> MediaTek mt7623a/n SoC.
> 
> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
> ---
> Changes for v2:
> - Do not define pinctrl properties as they are implicitly supported.
> 
> Previous versions:
> v1: https://lore.kernel.org/all/20240401043505.40972-1-agarwala.kartik@gmail.com/
> ---
>  .../sound/mediatek,mt2701-wm8960.yaml         | 54 +++++++++++++++++++
>  .../bindings/sound/mt2701-wm8960.txt          | 24 ---------
>  2 files changed, 54 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


