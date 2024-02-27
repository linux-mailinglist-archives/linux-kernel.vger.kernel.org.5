Return-Path: <linux-kernel+bounces-82671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E23086880E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B0E1F229DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824AC4D10A;
	Tue, 27 Feb 2024 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnKwf/MG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE1EAD7;
	Tue, 27 Feb 2024 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005812; cv=none; b=ldDLzQtwmvabnYNZxq4IW6QWCJT4RAR2DUPdeZZXBH+yzY1LfTKz6MdZT3077fEXZ/vrmD1X2hdqLfx5E31nvmF+goDNuFAqKFQ1DoeNPzvGCcvY+XRrA+jpxjVnUOUcvppRI0jtSgig8EnCHemB9tTYiDpxtYPONQiRzd8IIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005812; c=relaxed/simple;
	bh=hOMeGK3M1MNEfZ1lZ/JwrqcEakbzHAYTL05Yftym9lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyiq+DD96/RCof/24ExELc9pEMVKwjSNwOAYrAMS8v6QYCtRjkv5lO1Tt6IGiZ0KONTWt7uc0WaKAM8lP74O7oQmvBymsdMXWv5/NrcU5Y1hCKfH0QNtGvfttnHdReM4BCAZxLaTRmhH8YyqX/SuQlYJyrnRwQaDt9AIlFNv03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnKwf/MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A341C433F1;
	Tue, 27 Feb 2024 03:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709005812;
	bh=hOMeGK3M1MNEfZ1lZ/JwrqcEakbzHAYTL05Yftym9lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnKwf/MGF396PEh1KPYyWEmNmIaAFk0e2kERcHFD98DCp2imkkPC2epPI0F92BQn2
	 gQXk1Dw4rhrsz5oNN7A7prp6ddNokkg++RRTZNrlpw02oW4A2GhM1g7tjA5ind6xM+
	 VHkAlQehrKEXOPb/xQEuMcX3qJ0rd4Q5SoBPeloeZIrSSR+fNFf+vJq/utbaZwl7ev
	 cUIbVG0TYjB3Sj95bRA5OHWtJ9lcOdjTiQKN6TyNjqVCc5v23BM9MdSCO3r0BYiIwF
	 eTPhNN+rzH5FJmqbmz/jK2GO9DomFe3JH32SXGQ9MOvgyCuQEobh2Bm1QCK+kLC3IE
	 RiPByKZfP8CuA==
Date: Mon, 26 Feb 2024 21:50:10 -0600
From: Rob Herring <robh@kernel.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: input: allwinner,sun4i-a10-lrad: drop
 redundant type from label
Message-ID: <20240227035010.GA2663086-robh@kernel.org>
References: <20240226122934.89257-1-krzysztof.kozlowski@linaro.org>
 <3207352.5fSG56mABF@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3207352.5fSG56mABF@jernej-laptop>

On Mon, Feb 26, 2024 at 06:31:38PM +0100, Jernej Škrabec wrote:
> Dne ponedeljek, 26. februar 2024 ob 13:29:34 CET je Krzysztof Kozlowski napisal(a):
> > dtschema defines label as string, so $ref in other bindings is
> > redundant.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> I already send PR for 6.9. Do you mind if it waits on next cycle?

This should go via input tree, not allwinner.

Acked-by: Rob Herring <robh@kernel.org>

