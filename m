Return-Path: <linux-kernel+bounces-139882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207F78A08D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B2B1F28369
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636813D89C;
	Thu, 11 Apr 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfDR7fCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64263D3BE;
	Thu, 11 Apr 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818346; cv=none; b=orHLXQWZ6AlMkvpEewpCzCj2tFEvggSMkEszcEhJScTccVyeSDXJtfOFXC+iNsYTi1lr5zb5Hj90nfbS+Yex3+TYWP76EKd1q9NBgdiCLBUgCJeNnbqPJ0qEf00pA0SCGiCvUi3XIVcI2c74MsxLaMX2Xfu6R5MOH+NmT7N8zM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818346; c=relaxed/simple;
	bh=Jhc5zOL68UNuOFKNtfOyHBGkwAo9oulUs+xmQbNxyS8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=aRUOqj9Ei46bl7ZMY0tBv8kKvT4V2LAbnjddIbkGvvAE8lAB/O38IH2Ll3ipoDdnMhIXMuMMHUi7AQ9R/aeQlAHrfsVCoA1Y/hnKDZuSkdUjAyadenw//gXRf6qz1yPITBOX975WHNzqzknQ312fEWGPCRFKOBgNz7Y0uRtGkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfDR7fCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75006C433F1;
	Thu, 11 Apr 2024 06:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818346;
	bh=Jhc5zOL68UNuOFKNtfOyHBGkwAo9oulUs+xmQbNxyS8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qfDR7fCdOzhwg/APRiNDKg96+cS8EL7FUloE597dQSIsQWJFq03XPg4djIgc7I3iM
	 YeCrmt3YZkEjDePgL7eag/IPoQNCeveZ/lmWDTUr4wFcUma6Nxc71zB/bnHP5rQPOi
	 +QnH4dKOcPpFMTJvYQ7DWW4sWfqyBJUeyND+5m4IpYIGJQ7HiUvlbkc4Lv9aJgDia+
	 IHf1gF85hIH+faAOWErMw9lChzNHpv3voCLz9HbKGurplt60QmW+nkNgqNH6xPCImK
	 swZinvhi1ArL3iNssPtupYc7jNND+uclgM8UmGKwwXKyfJt9IpWhfttaWjnGJtcjew
	 t4WQfJQu3nSwQ==
Message-ID: <d8dc639c2c6d188d2ce3728573d9a53d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240225-pll-v1-1-fad6511479c6@outlook.com>
References: <20240225-pll-v1-0-fad6511479c6@outlook.com> <20240225-pll-v1-1-fad6511479c6@outlook.com>
Subject: Re: [PATCH RFC 1/2] clk: hisilicon: rename hi3519 PLL registration function
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>, forbidden405@outlook.com
Date: Wed, 10 Apr 2024 23:52:24 -0700
User-Agent: alot/0.10

Quoting Yang Xiwen via B4 Relay (2024-02-24 08:56:09)
> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/=
clk-hi3559a.c
> index ff4ca0edce06..77fa4203a428 100644
> --- a/drivers/clk/hisilicon/clk-hi3559a.c
> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> @@ -452,7 +452,7 @@ static const struct clk_ops hisi_clk_pll_ops =3D {
>         .recalc_rate =3D clk_pll_recalc_rate,
>  };
> =20
> -static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
> +static void _hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,

Prefix it with hi3559a then to be SoC specific please. But this is also
static so I'm not sure why this patch is needed at all.

