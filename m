Return-Path: <linux-kernel+bounces-41517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E03883F395
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEE81F22707
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1987E3FEC;
	Sun, 28 Jan 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhKyo9ey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D2184E;
	Sun, 28 Jan 2024 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706411412; cv=none; b=PaGqd9Ic29nO0sHAz3PJ7wOJUB7ISNKrTImUDUQURNFzmZPW+Cwp+ZMFKM+kbg4dsiFLVDUB0ltelD4cxFeowFZAvOCYkI7nOnOO0vyqPyo2BN8hYrWfxx7DeTMHfCyA0CwdymfIpiwXmrrhbErRO5UC8u5GEauCsrIG38aj6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706411412; c=relaxed/simple;
	bh=lZ1liFir3gGA6qym7RTTve5VZosP9tUOA/xKqvBePHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDUIf+H4jjWOzrFOh3K1R7Mge8NHATxFBsIjmRwnmcCW086HgulAwrB1PsF2rCZ/qS04sTlIqq8InoZ6Dt78qBd5mBdVYjrJPO4Vl8Bbd/LY3xlBIpx+DwP/kT6rQRMl9V/0OWAQjQAiQCppIl4H5/IZxavJtGAG7VbUfa+H/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhKyo9ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25BCC433F1;
	Sun, 28 Jan 2024 03:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706411411;
	bh=lZ1liFir3gGA6qym7RTTve5VZosP9tUOA/xKqvBePHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rhKyo9eyuKqMAgPrBLE/xhDRZNC2VnI9KOcRvXQXtKN69wNt1wSXKV9VAlhp1s3Np
	 MBKOeCzyjxYaNr9rSPqbBCwgA8Z6R71VY6QIpRTM6EuZi7RAbBstf76u1tdaL29slt
	 x0bnRL/v1t1CYcId+UvfmxsZTCR3/xydD3GUAMCjZ+WrWbHehPSTRMiVTo8KF0rf5T
	 nCc14LNN2cstiiTHk0FHV3CLU3kGVbFdjaf1JHEjth+rxBM+P/FSxZD+un+nem5N7E
	 qnPBCtK4HivrK4ZgGZ4yuZFNYLs+fvIuLoQy7tmNkEZ2+eTNRrt/4CXqv+Z/7bDEoJ
	 D8I23lrQKx6oQ==
Date: Sat, 27 Jan 2024 21:10:08 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: Add M_TX_FIFO_NOT_EMPTY bit
 definition
Message-ID: <jrdc5uhwu2tqud5bqu2r7mfnbh2mdbqtgs56h65xv5t4lvwvhm@f7rhtbpxxcwi>
References: <20240112150307.1.I7dc0993c1e758a1efedd651e7e1670deb1b430fb@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112150307.1.I7dc0993c1e758a1efedd651e7e1670deb1b430fb@changeid>

On Fri, Jan 12, 2024 at 03:03:07PM -0800, Douglas Anderson wrote:
> According to the docs I have, bit 21 of the status register is
> asserted when the FIFO is _not_ empty. Add the definition.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> 
>  include/linux/soc/qcom/geni-se.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
> index 29e06905bc1f..0f038a1a0330 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -178,6 +178,7 @@ struct geni_se {
>  #define M_GP_IRQ_3_EN			BIT(12)
>  #define M_GP_IRQ_4_EN			BIT(13)
>  #define M_GP_IRQ_5_EN			BIT(14)
> +#define M_TX_FIFO_NOT_EMPTY_EN		BIT(21)
>  #define M_IO_DATA_DEASSERT_EN		BIT(22)
>  #define M_IO_DATA_ASSERT_EN		BIT(23)
>  #define M_RX_FIFO_RD_ERR_EN		BIT(24)
> -- 
> 2.43.0.275.g3460e3d667-goog
> 

