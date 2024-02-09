Return-Path: <linux-kernel+bounces-59093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC0684F11A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE582286B56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223E65BBA;
	Fri,  9 Feb 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUdgIiQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED565BA9;
	Fri,  9 Feb 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465367; cv=none; b=l+TmaoIgfcjlym+bf2J2sqpNkFM+FwAkXsz6G7G82dW86arWloqVQTqjDe5/NDwaYUpP5vdfgBEFFZHzoUeTVWG9OYWgO2LRnnL8bNBaAW8rwOQesVgMZ5iLO9AHzu2gPvWK+udbgrra8kr3mx5Ni4+V+scBBEXpFYqxJeKuiaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465367; c=relaxed/simple;
	bh=P7wTmGQFUl7vaSSnPn07uUNCGATkO7+DCnHXiKXmmbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEyAvrprW96f3UehCIwpGorSzpBd5jfvs/fwK1+tLhORZtA7so+kSVVklEcJuaGacq+eFQYybtXBO/t1yhipp4CqNZvJWIyYRUE9sM6SRA6jpsavvr51NdS9/SCTbjTKo8eXd/jm1p+IYfo8V60aKKTCU2YGANoQlU0hn2uNw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUdgIiQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6346FC43390;
	Fri,  9 Feb 2024 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707465367;
	bh=P7wTmGQFUl7vaSSnPn07uUNCGATkO7+DCnHXiKXmmbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUdgIiQLbYmJhxQBJxMHHtPK6ibm1jgOpkOR6KNj2tcn962+ZsNNKxgYnoW6SapZP
	 UbxsdPviDOpkNUSHX+Ywe4C7y7A5ySPYVnL6LBBe/51UXOzjMcdjC1F5ov7NeJPH/v
	 +SZ4S/C1n0MmWhL9eJCHMvL8wHmsIehUzmWQjICsPkIFrrm8moDhikgCL70XoneAHT
	 H3buc0n2S/fey2t37Wx/XuUTGHlaRnC6rLL0medJRxVDeXXQecEk5tkaPdl6dChL6J
	 X6o+ytlpdYkP+rZqd8m1QzrnPV9hkQ0Qaqgh/yYVhdqgi6mQ/099zFB83/Wpt3nXlW
	 RNeCh8AkIgujw==
Date: Fri, 9 Feb 2024 07:56:03 +0000
From: Lee Jones <lee@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mfd: tmio: sanitize comments
Message-ID: <20240209075603.GF689448@google.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <20240209015817.14627-13-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209015817.14627-13-wsa+renesas@sang-engineering.com>

On Fri, 09 Feb 2024, Wolfram Sang wrote:

> Reformat the comments to utilize the maximum line length and use single
> line comments where appropriate. Remove superfluous comments, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/linux/mfd/tmio.h | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index f71d4e507dcb..1cf418643da9 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -5,23 +5,23 @@
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  
> -/* tmio MMC platform flags */
> +/* TMIO MMC platform flags */
> +
>  /*
> - * Some controllers can support a 2-byte block size when the bus width
> - * is configured in 4-bit mode.
> + * Some controllers can support a 2-byte block size when the bus width is
> + * configured in 4-bit mode.
>   */
>  #define TMIO_MMC_BLKSZ_2BYTES		BIT(1)
> -/*
> - * Some controllers can support SDIO IRQ signalling.
> - */
> +
> +/* Some controllers can support SDIO IRQ signalling */
>  #define TMIO_MMC_SDIO_IRQ		BIT(2)
>  
>  /* Some features are only available or tested on R-Car Gen2 or later */
>  #define TMIO_MMC_MIN_RCAR2		BIT(3)
>  
>  /*
> - * Some controllers require waiting for the SD bus to become
> - * idle before writing to some registers.
> + * Some controllers require waiting for the SD bus to become idle before
> + * writing to some registers.
>   */
>  #define TMIO_MMC_HAS_IDLE_WAIT		BIT(4)
>  
> @@ -32,31 +32,21 @@
>   */
>  #define TMIO_MMC_USE_BUSY_TIMEOUT	BIT(5)
>  
> -/*
> - * Some controllers have CMD12 automatically
> - * issue/non-issue register
> - */
> +/* Some controllers have CMD12 automatically issue/non-issue register */
>  #define TMIO_MMC_HAVE_CMD12_CTRL	BIT(7)
>  
>  /* Controller has some SDIO status bits which must be 1 */
>  #define TMIO_MMC_SDIO_STATUS_SETBITS	BIT(8)
>  
> -/*
> - * Some controllers have a 32-bit wide data port register
> - */
> +/* Some controllers have a 32-bit wide data port register */
>  #define TMIO_MMC_32BIT_DATA_PORT	BIT(9)
>  
> -/*
> - * Some controllers allows to set SDx actual clock
> - */
> +/* Some controllers allows to set SDx actual clock */
>  #define TMIO_MMC_CLK_ACTUAL		BIT(10)
>  
>  /* Some controllers have a CBSY bit */
>  #define TMIO_MMC_HAVE_CBSY		BIT(11)
>  
> -/*
> - * data for the MMC controller
> - */
>  struct tmio_mmc_data {
>  	void				*chan_priv_tx;
>  	void				*chan_priv_rx;
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

