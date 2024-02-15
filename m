Return-Path: <linux-kernel+bounces-67142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038858566F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91CC1F24390
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC71332AC;
	Thu, 15 Feb 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDsd+9yt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD6132C12;
	Thu, 15 Feb 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009758; cv=none; b=UurAUn4w2RGX+5zXidRINfYJhhjWQCemlDCWoKaApRgWVFSx0flxkBknIf1oZaG40M9COM010Wcv7hYn8o0WHzeHppj8e5qgb2+SnIrUbuy1WSYadqlP0aQMYRmVd2fxJnigeEzRhdKZFYdVHaA0FSZHBCYTRKVqRlVrQAS+m7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009758; c=relaxed/simple;
	bh=UmSuqy1e0KO55/hZOC+tsKy7sIDZ/d3eWv4j//O/vCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2qGsGGgapmP7qPq+0J2rR8EWyYgxRW/sJAGoWAV5HM7EjVgV8Ka/dP/+zLQeQ7x7c4VLOc8Wcpom6hse9w+OiSldZKR/kdBOxYhLQy4QM0P8u5dfD3sgKtp8u7QrXeqS1r1Une09amgSpqvgbLSreaUcA/t0V7u82cN8H8Be/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDsd+9yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65A5C433C7;
	Thu, 15 Feb 2024 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708009758;
	bh=UmSuqy1e0KO55/hZOC+tsKy7sIDZ/d3eWv4j//O/vCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDsd+9ytV2t0oeK9R4hYEdsx/hmlcomT2jY59gJpUmDpc60AbobevxuClshAPLyvT
	 tELy6AjllNsZhEC68tNhjuFUc4XLMs59lveBLL2RTsAanxA5YyE5E2iHHzla/4Pvl/
	 HqbjmReVWf8pCaqV7V3oNGaW58rIx2pOU6g3YgzI10c81H2ixm87461zanqunnwmo3
	 Gvo1PhOY9adhiNvBmQcNNXS54C8wpq0eSuoCVvz01Dg+RWuaV3XYxorDQqnyNXBMk8
	 Lgkk+JoE/Jde48PFX1xeg3YazCDfS/8JU+zvu6prGGClRKKkwX1W07hFh6rDyETk94
	 k/8lU7NvR9jZA==
Date: Thu, 15 Feb 2024 09:09:15 -0600
From: Rob Herring <robh@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Tianling Shen <cnsztl@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
	linux-rockchip@lists.infradead.org, Jagan Teki <jagan@edgeble.ai>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: rockchip: Correct vendor for
 Orange Pi RK3399 board
Message-ID: <170800975373.77965.10834715351049347685.robh@kernel.org>
References: <20240214040731.3069111-1-tim@feathertop.org>
 <20240214040731.3069111-2-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214040731.3069111-2-tim@feathertop.org>


On Wed, 14 Feb 2024 15:07:28 +1100, Tim Lunn wrote:
> The vendor for this board was incorrectly listed as Rockchip. Fix this
> now while they are not used anywhere, in the future they may be used by
> bootloader to select dts.
> 
> Update the vendor to Xunlong.
> 
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


