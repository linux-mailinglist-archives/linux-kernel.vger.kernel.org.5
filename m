Return-Path: <linux-kernel+bounces-67798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A355E857134
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ABD1C21A12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7814535A;
	Thu, 15 Feb 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKWARMnY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F77255E7F;
	Thu, 15 Feb 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038735; cv=none; b=mPSb9K99t1xp3iGtr7uTiz/JQTq7DqFeIFS0UziTYoSihtzU10B1ucdUmW8HiPdWqUpqPsycrekKuW2OJHPnPz5EtPWcUnWbCGXiJwhGLhcIEzhIbkikenpCMK3o2L9ZQ/hnPfTyExsjXKdFJMmnHFHqY8PNzzpAun8SoSHkMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038735; c=relaxed/simple;
	bh=Eb/9YuG1ExOw9aKA1oqZbr3X02sG3sH9UxVJp/eMEdU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=A8/faeqstJc8uDPzLCJjE0eIfFPv5WdkhucizwpZgZSvofJ6mI3VeCM3wdu9dh8fOwi0LwcP/KEGmIs7wIC62nb3FxCehe6XlIY0YdgvBBsNcyPm90MA8msb6P5EhXkB8Fz0hTtF48K/5+eIlpLA4oi99v0j8VTngGgx9uV+UmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKWARMnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FE2C433C7;
	Thu, 15 Feb 2024 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708038734;
	bh=Eb/9YuG1ExOw9aKA1oqZbr3X02sG3sH9UxVJp/eMEdU=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=VKWARMnYNviJPXiOtKuoccPiteYKCHSVFRLfobnKgCAmFe3rC2z0Wd3jsy6VvnDNO
	 LU9halfyBb8j8Gtgt3x3Yl2qjLDsAaN4XWZY7vP2J42INqR9FJQbRW1OHvIkeGQQFp
	 uBCYksmhH7HE6OaG4D9ym/b893RmduQl4SpP0JiZwyMF3BNC3fvmpvB1RmIpvsXepi
	 DfFkHY0/gR6aJRNCjSdzlugiIA0yQlY7txVukxSAYJg5oBs5tW432Y/k7zJ3C35m36
	 +j4EikR/4v5vFeyHEmEG7BhaHzvhhTsPRPWFIm8wrAx8nLp781+VxGDyfk8VT7NiAg
	 cIy678urUpZjg==
Message-ID: <38e7e80f61f7c67c984735cf55c3dfb3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
References: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] clk: constify the of_phandle_args argument of of_clk_provider
From: Stephen Boyd <sboyd@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Jonathan Hunter <jonathanh@nvidia.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Turquette <mturquette@baylibre.com>, NXP Linux Team <linux-imx@nxp.com>, Nishanth Menon <nm@ti.com>, Peng Fan <peng.fan@nxp.com>, Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
Date: Thu, 15 Feb 2024 15:12:12 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-02-08 08:37:10)
> None of the implementations of the get() and get_hw() callbacks of
> "struct of_clk_provider" modify the contents of received of_phandle_args
> pointer.  They treat it as read-only variable used to find the clock to
> return.  Make obvious that implementations are not supposed to modify
> the of_phandle_args, by making it a pointer to const.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

This will almost certainly break the build once it is merged to
linux-next. What's your plan to merge this?

