Return-Path: <linux-kernel+bounces-75912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD27F85F091
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4848D284C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7D4C7E;
	Thu, 22 Feb 2024 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEeoHAkj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EB1877;
	Thu, 22 Feb 2024 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577758; cv=none; b=n9s1bze6pKH5bqvxmtJlIp5wHQyw/MHfOiu6ChjiUci7sTxKO54uON3o90n/gCNpM1xrL8kLUc9iZzLWiGtbw74MpOp4+nNcgM+aROnjWblHr+WZwPsb4wPZtVWE8cSmOTpYerT9qHavU3JcOVl8r6Qnrvt/5cm31M6WurPDJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577758; c=relaxed/simple;
	bh=h1t4l94yELDYZR6iDnJqPGq5TXMg7b84277zgKd4BYY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Z62G/hhn9aIt8l9Z7ZKagP4orRsAlya6ATpEzQnH6YiHImQLm9GN61+gT8SYW+eXrkLb0D2ZXk9giqvjRBItkOQUIZZ90iNRs5GrpEYBj8UbbOUcSuUZvemON5e7rIf8EHvcDjrRFO9h/FsFTRQdAJLAp6uXA89rY/LWrL74lRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEeoHAkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E99FC43390;
	Thu, 22 Feb 2024 04:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708577758;
	bh=h1t4l94yELDYZR6iDnJqPGq5TXMg7b84277zgKd4BYY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CEeoHAkjGC3ivSS8PwlK54FmSb1FUb2WpLTX41AbIgtFsP5HBKEyqCeRjjfVvHE13
	 gFbNCUczcDeVPHpc9JVHMS6AvgjLYQVjJT8je61Zqg6MPrHNmv3Ol+l4jPeyusZ3ox
	 rWv2h0JkCmMSfff1TWv78hSXV48wjXHPyaeM1WEwFPo92v/tMl+O88GJNT8iqL1gzI
	 /yf/3b+Qm0mqrXlfjtEbtxRjb4dRM/oj6lLGRQjgAd+J4CsrNP3H9DPl0LKtbBWLF4
	 Mn0qjRD4tYKDh2ojHeoXBweJme4/F1YRmndWYFTTRITqMW96Y/PkRB0+7L+vHoel+7
	 u/ovmx4j634SA==
Message-ID: <f91b8141d7edab4d6cbd3cb464ccf3d7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fc157139e6b7f8dfb6430ac7191ba754027705e8.1708221995.git.daniel@makrotopia.org>
References: <fc157139e6b7f8dfb6430ac7191ba754027705e8.1708221995.git.daniel@makrotopia.org>
Subject: Re: [PATCH] clk: mediatek: mt7981-topckgen: flag SGM_REG_SEL as critical
From: Stephen Boyd <sboyd@kernel.org>
Cc: John Crispin <john@phrozen.org>, Steven Liu <steven.liu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Daniel Golle <daniel@makrotopia.org>, Jianhui Zhao <zhaojh329@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Wed, 21 Feb 2024 20:55:55 -0800
User-Agent: alot/0.10

Quoting Daniel Golle (2024-02-17 19:11:15)
> Without the SGM_REG_SEL clock enabled the cpu freezes if trying to
> access registers used by MT7981 clock drivers itself.
> Mark SGM_REG_SEL as critical to make sure it is always enabled to
> prevent freezes on boot even if the Ethernet driver which prepares
> and enables the clock is not loaded or probed at a later point.
>=20
> Fixes: 813c3b53b55b ("clk: mediatek: add MT7981 clock support")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next

