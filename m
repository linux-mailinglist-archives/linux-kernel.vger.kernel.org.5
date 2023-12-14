Return-Path: <linux-kernel+bounces-96-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC31813C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7F01C21C01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A656E2BC;
	Thu, 14 Dec 2023 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVIUb8wb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5FA6DD03;
	Thu, 14 Dec 2023 20:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436A7C433C8;
	Thu, 14 Dec 2023 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587291;
	bh=+4O4GG6elA8eO2phXE+p0A0W/mFHtXinP+K70ChxXUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVIUb8wbmg8reSfjuVpNaYpEV5XS0RcafT9N1Wo95TirPT6xMGS4PGHeaXvDqezvm
	 YGRDPrewcOmGBIn2IqJSnNg2WkCMKcmo474igUPrbq4N0BW8IoBK0zEuTwX7CUl5jd
	 6SUKDT6xpMtoPwWMfZALITEW5Yl9fOvCpQG5rN855ZgQGP1aZt+n+KsBVNZdsjyvJF
	 AI6WJjeIdxDDU4IHkpzT0wEyuFMg6pTm7r/IjwE3UCNqTqvjP7+5mRHg1GtbZWgHLV
	 m976ZpnKjeYtPB9nLQJYM1PvcR4NYlvwzyXHr9pgbl45zmbS2Ekit4F/Mzw7EWAVEl
	 CneEnQXD3tTZQ==
Date: Thu, 14 Dec 2023 21:54:49 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: rcar: add FastMode+ support for Gen4
Message-ID: <20231214205449.x7bbu7i7m52ihibz@zenone.zhora.eu>
References: <20231214074358.8711-1-wsa+renesas@sang-engineering.com>
 <20231214074358.8711-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214074358.8711-3-wsa+renesas@sang-engineering.com>

Hi Wolfram,

[...]

> -		dev_dbg(dev, "clk %u/%u(%lu), round %u, CDF: %u SCHD %u SCLD %u\n",
> -			scl, t.bus_freq_hz, rate, round, cdf, priv->schd, priv->scld);
> +		dev_dbg(dev, "clk %u/%u(%lu), round %u, CDF: %u SCHD %u SCLD %u SMD %u\n",
> +			scl, t.bus_freq_hz, rate, round, cdf, priv->schd, priv->scld, priv->smd);

as we were here we could have written the register values as
0x%x, but it's also OK to keep the change with a minimal impact.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

