Return-Path: <linux-kernel+bounces-59092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E484F118
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1F72866F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D5657CA;
	Fri,  9 Feb 2024 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0zDJKeh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5AD657C7;
	Fri,  9 Feb 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465327; cv=none; b=hUBJdOGa3kNBhu4Pok8OLzX1v56kXMXpsF0ZTyrdwJzdVjmprfZFBFA5mQdlCi4AASfoCrqD0w1Bt3miLy23qj1wibyvfgbmIIzV7ctHYaVAnsknVzpAWxpDOpTBhDq00VK+yYFHjNAY4U7m4VoEi8/50Jz3wZUg9FFYaBZ4W/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465327; c=relaxed/simple;
	bh=JaN00YYTZkjnv8yR6D0TxbBtIsqtD3ap6jbs4zxv0i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fspqm6gVnbfhO+YD9c53P17YsCBGn5zpvoCm90mUbXnaXehjpjRl5W2FSOCwZypY1Agheo2keJ8G1vcbwUWFPRlTia+GKnxl1GA1L7PA9NPIRp4uDwjz6b/h6umbuaW1Oqweg1XpL46fuHDp7QKIeqsvjjm/rvEiQkR4ZJxYgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0zDJKeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4498C433C7;
	Fri,  9 Feb 2024 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707465326;
	bh=JaN00YYTZkjnv8yR6D0TxbBtIsqtD3ap6jbs4zxv0i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0zDJKehJBJa1O/i0liwK1HlghNtzEzisb6P7VJ+qnGaEqdbCrRoDwX+n2/hGAWmO
	 08MEz1Tenvu56r7RDZ2p9OHq8cP8efSwcGwsHVOQ1peUmTjWF4DXIrNV2TRF9Mkn1K
	 mF/1ud9zET6WFZ31tnhsIRod//i/IlkI/1CeHWGzIRRjjBMs0jm3T14tQHvKThve7b
	 8nNJWWcxNwGp2TdbE1w/hpKCdvPb5CQ0yyH651pp+8ULRwIKuf4QDqslQldYD4y+kE
	 s4f+vhjR9zZXSdGf3g1Xuz82bPMf/vhuwVmMfXlnKBXm/eoSt0d5VuYDhzkkPJ+Yb0
	 FkBpnDLDyE32g==
Date: Fri, 9 Feb 2024 07:55:22 +0000
From: Lee Jones <lee@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] mfd: tmio: update include files
Message-ID: <20240209075522.GE689448@google.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <20240209015817.14627-12-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209015817.14627-12-wsa+renesas@sang-engineering.com>

On Fri, 09 Feb 2024, Wolfram Sang wrote:

> Remove meanwhile unneeded includes, only add types.h for dma_addr_t.
> Also, remove an obsolete forward declaration while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/linux/mfd/tmio.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 4223315d2b2a..f71d4e507dcb 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -2,13 +2,8 @@
>  #ifndef MFD_TMIO_H
>  #define MFD_TMIO_H
>  
> -#include <linux/device.h>
> -#include <linux/fb.h>
> -#include <linux/io.h>
> -#include <linux/jiffies.h>
> -#include <linux/mmc/card.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_runtime.h>
> +#include <linux/types.h>
>  
>  /* tmio MMC platform flags */
>  /*
> @@ -59,8 +54,6 @@
>  /* Some controllers have a CBSY bit */
>  #define TMIO_MMC_HAVE_CBSY		BIT(11)
>  
> -struct dma_chan;
> -
>  /*
>   * data for the MMC controller
>   */
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

