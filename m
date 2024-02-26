Return-Path: <linux-kernel+bounces-82259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8317F86814C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADE6B219A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0611912FF8E;
	Mon, 26 Feb 2024 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlBdfLyX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328412FB3F;
	Mon, 26 Feb 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976587; cv=none; b=PTryE7sUob7NWq7u0E2bqVSqEBxlaWu6h/YWYn8ox/KSf+O/HbtV9ltStn5FJ/V3sG8jXhLr3149sFkJ4bFap9hbdJHWS1tl7//2Bsoz5kxQhCwow3bMbwD35tSIM6P/EJE9s7rvsE4btbG+x74APEiu0ucMuZ3ylSt94jfnKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976587; c=relaxed/simple;
	bh=OiifFeXVLc0gFMbi2NyoH9bj+M34nXoSgxAmdur1hkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiYxK5fza309rk683jChp/olgc/lKVRbOlh8cUjRgNW/lt7OaKiFu8gohgeGTq5ls7FMUES0bUx2I2B1JWvG96UGJws3i33TPVxxNgbWvEc9PLIjHNLVxVk3exOHN7TC/tYqyuxyLZgdO6tdbgotf1umgwBzcmBV3tJnAkf6DRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlBdfLyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA819C433C7;
	Mon, 26 Feb 2024 19:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708976586;
	bh=OiifFeXVLc0gFMbi2NyoH9bj+M34nXoSgxAmdur1hkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlBdfLyXS5GF/6m3GG/4yRjHwy2GXLraaTn1QNYoMjD99MWj8ntxPBJUAKWmFoVGU
	 Gezotf2GjFNmumg1pAZv01dT8vFvsMbfIY7r89HAanSz0EggEu+qwazPnoshYNXxiM
	 2BzsOCG5slBxboTOaoxmMxe+nJScEsj3nIKi36qUtUXb/jMOcdvlLFCIh7AfmZBT/D
	 ccb0jixgR4R7ZXIrROuU3L1v5zOQNQvnqJRm9c+aM6TiXSbDcYv95PBGqzRo0R2SpM
	 lfbPbNcFAm5kQPzYOVjQM7sMx3WeO1fl8p9ox2ttwYErIs3155sb8XrLUHzdyJmf7v
	 TpPVb9GvpMRQg==
Date: Mon, 26 Feb 2024 13:43:03 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: remove unstable remark
Message-ID: <170897658316.1317027.14455000806423484648.robh@kernel.org>
References: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org>


On Sat, 24 Feb 2024 09:40:29 +0100, Krzysztof Kozlowski wrote:
> Amlogic bindings were marked as work-in-progress / unstable in 2017 in
> commit 7e8634e821e1 ("dt-bindings: amlogic: add unstable statement").
> Almost seven years is enough, so drop the "unstable" remark and expect
> usual ABI rules.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 11 -----------
>  1 file changed, 11 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


