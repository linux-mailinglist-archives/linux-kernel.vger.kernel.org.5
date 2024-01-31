Return-Path: <linux-kernel+bounces-47022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF184481A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88C3286B20
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8903D982;
	Wed, 31 Jan 2024 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="mahihcdM"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A3F9F4;
	Wed, 31 Jan 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729913; cv=none; b=acd/NgPj8OTFVMvSTyhOp2CU/7N7x2mrmM9q4BHyHjkDW1XHVi4RdcSlcamNFu+ThrGmIvrewVeYgGEH9u0IPmTTiu5zP0CrLPUUg65/HE14YOL0hxh4bqRy+JeNnodawCWwQC/UIBl2JD6a8jRT41aM4MnIPXc2HrvASwKzItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729913; c=relaxed/simple;
	bh=P8laWTLf5e5ISzFPNQIXU0y2QnIITlxDXfUO6gtZ+AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu+WIl/cZv4qmBm3Jsj8caMgksiZoXo9sA4Nyp4V8eTHBi84CMwIDbCeuO5TRIzWihMU/kY7uWFeFp3RszmNbOHIrLHGUy2p/pGr253SHYOky04cF8V12ytLcnt+cEkOczV6/hnVfAMQYWa7k2pzeYeyt9SiDwlJd5OHUbDFHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=mahihcdM; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id ED4D422B70;
	Wed, 31 Jan 2024 20:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706729900;
	bh=4KgBcDDcoMs8fG0dEY3Dm7hjBSTlNxIeG1TsDHMcHNo=; h=From:To:Subject;
	b=mahihcdMQv09p0PzYMC4C86uQLxzdZaQyhoo/SUoT4QouurVHH56qFbdhPE00nU0X
	 Qn7admYFCn6kqj2gIcqedBYHuHApbB2St/4ac9UOcuH0FQbdd4RhbXi+MSqRvTXdg2
	 K8hEiqc7ErOucLAJxRo1DpoGmCdY4gCzoZWl6n08/hm8VwzsAK116XOgfJ85HG3Yrr
	 SVDahalzk35FT1v205isoXrhdvXB1DNtsc9Jxrp1HqFo9Jp+x8JaaUxu5BLnEuQqr1
	 2t+IlIgp3oZ4cJ6p1jWld/7BCCtPAaDi4JcC/ymGsZls4TZSxVDE9tYl7z2db3m8yM
	 iVScNMclflLHQ==
Date: Wed, 31 Jan 2024 20:38:14 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: carlos.song@nxp.com
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, linux-imx@nxp.com, benjamin@bigler.one,
	stefanmoring@gmail.com, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: fix the burst length at DMA mode and CPU mode
Message-ID: <20240131193814.GA12870@francesco-nb>
References: <20240131024623.329240-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131024623.329240-1-carlos.song@nxp.com>

On Wed, Jan 31, 2024 at 10:46:23AM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> For DMA mode, the bus width of the DMA is equal to the size of data
> word, so burst length should be configured as bits per word.
> 
> For CPU mode, because of the spi transfer len is in byte, so burst
> length should be configured as bits per byte * spi_imx->count.
> 
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
> Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")

Cc:stable...

> ---
>  drivers/spi/spi-imx.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 546cdce525fc..b4ade2d53fef 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -54,7 +54,7 @@ MODULE_PARM_DESC(polling_limit_us,
>  #define MX51_ECSPI_CTRL_MAX_BURST	512
>  /* The maximum bytes that IMX53_ECSPI can transfer in target mode.*/
>  #define MX53_MAX_TRANSFER_BYTES		512
> -
> +#define BITS_PER_BYTE	8

this is already defined in linux/bits.h, just use it from there.

Francesco


