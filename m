Return-Path: <linux-kernel+bounces-167689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26448BAD76
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C811B1C220C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D3154420;
	Fri,  3 May 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mbnuzj+F"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA1153826
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742128; cv=none; b=SoiQUl/djjMVfIcRPvmnMNVDT8SdRBp2ASnjHb71JkEzXBfWiKDY73Lz0hsh0cjjcE5gOakTRxsp8GgFXeBf+2+6tOgiP1+AsuKHPsUMAUdlmoUFch7Urd7wEsDf/VEaqZ944syYnL+qolKyceT9siYgy+tmpozPxWi+njosx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742128; c=relaxed/simple;
	bh=xrqzZwgdph5DRS4i3SCKXCa1JY0Gomt5Ypf74Pq1OsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6hK8IsduxLYsMlnpH2ms8Kk/DUydHYs59UkXcG4LzBFCYLWMcdRQbglPD1+JGLzUiPxloE9v5qgerzbLggDOAzPz4vI/DtjK66ISw21s3Uf1FPLBeEEdseEWTyXHmHALJlo+v4Wa7W1yEoEcPtBMoNW7+DbCzF1OXUE4zscUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mbnuzj+F; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso2650709276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714742126; x=1715346926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRI9l6TRFX4cl/D/dHvxIPz5B9asZPit4lxB7Ww5SAs=;
        b=Mbnuzj+F1O2ftcNQQa2gjKwnUIEzNWptcRetBceho0Y5Aa8AJhE/TqlCMOjfFt/M06
         LZ4McigjWo0z4CA2xJGkMjOGRNpBJ2+h53A2VJAJpsKsqyC6Ktn0LzTOYk/SXmEsBmgs
         v0XPoc+nMYnPxKy1KT77c5XS9JwIITbHaby7NRXwSdubet8A+jjQ8tiEb8BNkSwTVgpd
         +CiquOg/lyTUnwkHHDdwj8lqAJCZ8DL/exZO3hqVIN1Zc6yablOs35WHNXnU1ZJmTyo1
         xQ4iVz4vjrfdD3HXBMZTrdF2Tc3RHFv93D3EkvxgxMW2EPHkzYVy+tKgfgSmHMbk7pCe
         vHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714742126; x=1715346926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRI9l6TRFX4cl/D/dHvxIPz5B9asZPit4lxB7Ww5SAs=;
        b=m8fW6lWg23iOFMQS/yAB3cst1BpjRkQ71+uKnkpx7I0BOZwzOhBkXA3odVRQ+LE/IE
         n/rQmH7x89sZM/J9JtVZD0U4BeHX3OI6Hngde2sDi1u3BL8jTCfNMJUbMA4kRSR3uqGK
         HqV40GMvwoKt9fHAuiPQhACtNvKqADstGpF2TxFOAE7Y2AjPi/Ie++7THPgJd4pvcip4
         kdKH1yPJeu30PRZonraH4xT8kpIF+DjBItqfKekVi7tFDs+FH26Hkrc/irpLS1+JVwHC
         /gcHwBEz5JRytfevrEdnN6bpQbF954wcTh9dM/2CDVbVb2JJE7GqtvUwyFteqFl2V03s
         O6bw==
X-Forwarded-Encrypted: i=1; AJvYcCXBNShrFB+V6b4sedfAzKTuk58rxxfZBfu78+REvbjrxZymsaSne9kdK52/1xVx1zsFhu09lAnBQaxU0ZNwH1EwOU/2N6uGq7luF8RX
X-Gm-Message-State: AOJu0YwkLdyAc9kKMxw4T1OGItoK3oSpfLzLhkyhcQsY/PqOkfiXbxG2
	VmhK0kQhnH3cHdfCW7ms/1crAA0oTrJm0OxbGPEFwFHXBvUmbLNrB9Ms18XkMepLDejwSl88s9W
	PNgvRptsnkKkRSv6xmp8OoD3EPnBcgdZ5WkzsOg==
X-Google-Smtp-Source: AGHT+IHAuATqJlUN1KaAG6j30rTHBUQbuirlBENRxW4a0MCgvAe9RQrcnJ1n9j7vzbMqMlM2SL8OuwZJN888gEQV8HM=
X-Received: by 2002:a25:aacb:0:b0:de8:a500:ffdb with SMTP id
 t69-20020a25aacb000000b00de8a500ffdbmr1856096ybi.26.1714742125931; Fri, 03
 May 2024 06:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 3 May 2024 15:14:50 +0200
Message-ID: <CAPDyKFrPZ5XF93MD+g03UQP1d4WSPoop=VyAhzwLu9KV436KkA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Set the SDBUF after reset
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 11:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> For development purpose, renesas_sdhi_probe() could be called w/
> dma_ops = NULL to force the usage of PIO mode. In this case the
> renesas_sdhi_enable_dma() will not be called before transferring data.
>
> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
> call from renesas_sdhi_probe() will configure SDBUF by calling the
> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>
> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
>
> Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - shortened the comment introduced in renesas_sdhi_reset()
>
> Changes in v2:
> - fixed typos in commit description
> - limit the comment lines to 80 chars
>
>  drivers/mmc/host/renesas_sdhi_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index f84f60139bcf..d9503f9f6e96 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -589,6 +589,9 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
>                         sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
>                         priv->needs_adjust_hs400 = false;
>                         renesas_sdhi_set_clock(host, host->clk_cache);
> +
> +                       /* Ensure default value for this driver. */
> +                       renesas_sdhi_sdbuf_width(host, 16);
>                 } else if (priv->scc_ctl) {
>                         renesas_sdhi_scc_reset(host, priv);
>                 }
> --
> 2.39.2
>

