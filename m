Return-Path: <linux-kernel+bounces-136350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5289D2FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE728423B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76267C089;
	Tue,  9 Apr 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ewcjglWh"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91C7BAF0;
	Tue,  9 Apr 2024 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647560; cv=none; b=sjlsxEfePr4crQYOO300uB+2VRHnLMMF9hCZLndo4J1agFgtWFpfog6ZtUcSZiiaA9nCbJfM2L578Tp2DXfDsA0Vqrtq9wDirk0vPnSdqMdevNqDp9R7TX0R49MwJDMPui2hqJd2ukyljhoJhGGuxI7B1CHCb4uDeDNdPKvO61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647560; c=relaxed/simple;
	bh=Y2AC2x3B3acM2GKI9v5Q0mM7BmOAM7VvJtxbHJ4uqiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQtFBeT3JTfRN/rSKu/5gIPBikgVsXpOOunIZZWExeAUZCSLZ9dfR1SyrYkFgvEnLOSStI0mKKzdLSR9/bSSdwGHkMM96ytHA0I9f0OjAc8mg4xWKQr/wAnkLzzDstvXqnaM9UBMDerp7UpZvzxG6wNxB8cXzHReB+sKHshSPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ewcjglWh; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 77FE51FA5F;
	Tue,  9 Apr 2024 09:25:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712647552;
	bh=mrd0uFGErzOXz5bsvyPtG3fOYke9LnEn0N06A5zqcbY=; h=From:To:Subject;
	b=ewcjglWh41Jhrs9fWPK1ibYrQTxhbWdEEAtu8LWN6rSM9+qYYXbNhx9WNpE+TwGDZ
	 cpyxSuZyioerBltCTj8uuEhFBFBPE2X2GtlotyUqBUGVcJzxAfFham5pY0gaAsxUnI
	 hIK8XodAodywIlggyjNJqMuztih9oYsTpZj/ylpoq5mJ7h5RUrxU+aC5F2gP56FsuL
	 5NKM81OMuJjDnGkS2zmCNW+xorUfAcP+5XHYRF6R5F1SLAz055+szZj+QWaXqtdPlv
	 ZRFXwH70K2jn5y+816p1sbZNSfB6IgfYmKVKciacBYiJqLqEcmP9yBIPe70g3bBTt6
	 LSrYCHDL8Cf0g==
Date: Tue, 9 Apr 2024 09:25:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Horia =?iso-8859-1?Q?Geant=C4?= <horia.geanta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH] caam: init-clk based on caam-page0-access
Message-ID: <20240409072548.GA6629@francesco-nb>
References: <20230710053418.2406915-1-pankaj.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710053418.2406915-1-pankaj.gupta@nxp.com>

Hello,

On Mon, Jul 10, 2023 at 11:04:18AM +0530, Pankaj Gupta wrote:
> CAAM clock initialization to be done based on, soc specific
> info stored in struct caam_imx_data:
> - caam-page0-access flag
> - num_clks
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
> index ff9ddbbca377..74d0b7541d54 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c

[...]

>  static const struct soc_device_attribute caam_imx_soc_table[] = {
>  	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
>  	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
>  	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
>  	{ .soc_id = "i.MX8M*", .data = &caam_imx7_data },
> +	{ .soc_id = "i.MX8ULP", .data = &caam_imx8ulp_data },

This change seems unrelated to the change described in the commit message.
Should it be a separate patch?

Francesco


