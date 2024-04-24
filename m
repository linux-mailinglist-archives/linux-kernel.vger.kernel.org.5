Return-Path: <linux-kernel+bounces-157632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C5C8B13D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E880E2843C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550913BAEE;
	Wed, 24 Apr 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL7kPjKK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309921848;
	Wed, 24 Apr 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988550; cv=none; b=afYOH8iejnNY+uSDBdaO+AWEWRpFkMBZcuVSjjODyZtluKvy5P8XjHF92bYsJBs//nxRJSg1RIED4Zre/AuJuk9c+FnUKwGAlA3iXc0UBK0QDthcDmbdx2OgBH7qQ010i5t8Bqb6B16vyEPqqqVu7hai6wAA6xnsuuPwipMDo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988550; c=relaxed/simple;
	bh=7Ssf2orQYEw+x3rhVIDHWJRkaQA6YEMP4bdtPWzo4yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0QO4bO74IBn+Q1R3YzTL+QwyYFOLchQq/3C7Sb9rvYvo4PYjYc/l9cI5KfyaIyDfRoG6e+xcBL3yD48RFbBbFrlbus1rviWpDPqEzRNj85VjOQVFEBp8jWUMcIX1sZysmQ3b+imyr3AM63SBBmDhnUUvYDcPaGKKtlCxyVOXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL7kPjKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62145C113CD;
	Wed, 24 Apr 2024 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713988549;
	bh=7Ssf2orQYEw+x3rhVIDHWJRkaQA6YEMP4bdtPWzo4yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fL7kPjKKJC8Gq9feBsmWL7LlQprwEbDpeEUaqHNugNcCw2wlfgM2r2WF3mkZ418WV
	 Vt3DSfx27bPY8xYYhOThxm2o3tKmybOreCqqjOq2D/LVpnpgT7ihzdfVhFTjIxMWKj
	 1txXvxJUrDsKDo2iaxllEVv6viVQu3Q/hlG/Qd9SA6Exh44CqqN7P3UX6D8QivaNlF
	 +Gi+EdFQ/ybXlhm5AHsi7OiTXvkUvqQkjZ9cutzWbg4dyppbIvD56xlgqQdB+Yz1sz
	 GGrW/Rm2z9sfi9S5Ej6qG4HPGCzEIn63tamHhhl1fKiaMLApJz5HsuS2NF9jXAJTmp
	 k8qfDwq2x2mgA==
Date: Wed, 24 Apr 2024 14:55:47 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <mripard@kernel.org>, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: allwinner,sun6i-a31-prcm: Use hyphens
 in node names
Message-ID: <171398853223.372037.811685185869412352.robh@kernel.org>
References: <20240424045521.31857-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424045521.31857-1-krzysztof.kozlowski@linaro.org>


On Wed, 24 Apr 2024 06:55:21 +0200, Krzysztof Kozlowski wrote:
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.  This should have no impact on
> known users: Linux MFD driver does not care about children node names.
> DTS was already adjusted in commit 0f47ef3ff1bd ("arm: dts: allwinner: drop
> underscore in node names"), so without this change, we observe
> dtbs_check warnings:
> 
>   sun6i-a31s-colorfly-e708-q1.dtb: prcm@1f01400: 'ahb0-clk', 'apb0-clk', 'apb0-gates-clk', 'apb0-rst', 'ar100-clk', 'ir-clk' do not match any of the regexes: '^.*_(clk|rst)$', 'pinctrl-[0-9]+'
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/all/CAL_JsqJfT-jui5P56CO4Fr37kr5iNN8dpxt8ecKeFmdVGnRYbA@mail.gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mfd/allwinner,sun6i-a31-prcm.yaml     | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


