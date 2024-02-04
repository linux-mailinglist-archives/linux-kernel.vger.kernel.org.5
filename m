Return-Path: <linux-kernel+bounces-51921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7538490ED
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0704F283467
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363712C696;
	Sun,  4 Feb 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhEirLtN"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECF33990;
	Sun,  4 Feb 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707083867; cv=none; b=G9GCx+oIs20Ngx26b7LA5WbGXFLevVsOD1+OiiikOb769WvzP+HBcQ9eBsPKsOWC5ZlIOj4Uo0V71OXkg5TtbpgnU+hm84RQutPJ/eekX0IcHq0/bYBCBXS8LAFZHPHi1moEusS5NHIAqnbImZk1XQYXWcpUwplicosd1rWZ4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707083867; c=relaxed/simple;
	bh=UZa7O+Vt6YTPtFIw0/mltBs3mvjXdlM94ZR4FrqYCOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPIoO14PupIr8ixYUG2GESUtS4pBkVQYiG0TOpXFoiqaPq4rKziw5v1tmjECp8H7emBkYWyEocsCrbOaJWgW0XVBO8F15DWXgT18z2QX6v6cUVnjFdv7J4IKaj/dganRzwE5/cydjZ5Wi9dt6qScN3+38tMzVcRHRLfYqPqvH0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhEirLtN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5101cd91017so4850488e87.2;
        Sun, 04 Feb 2024 13:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707083864; x=1707688664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5AR9vZ9MNs+fUVCcwKiCmTaAON91kqW+QM/Uqs1wyI=;
        b=nhEirLtNbEFRMnDXHnHsByj06wfcztVesvF9MIvcfl58Vs5AGwnwz4aw/OcY/wb/oa
         HqUhkhpQ4othyx4d80o+gU9BrKkDESYsFTMqduX6GMRBwyZnKElYrCr6fLND/yoKdt8I
         RxeOdAm8Dhyx/48PPavQT5tZo5BC8QtunIUiDaxHtALI8M+nu84i46YEplZD0SPBI//n
         41BRoAcrcvxuilc43oMbQXxOdEGgO732EXC75klEb3VcGJcaSAUFk0xVNZ3YyGNQ6iI9
         xostAgGSJSGGFLyUMDo1PqY2r/LJ7CLXR/usoUH5rai0vqRMv9h0eotnr+QgkDGYqIHj
         Ak4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707083864; x=1707688664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5AR9vZ9MNs+fUVCcwKiCmTaAON91kqW+QM/Uqs1wyI=;
        b=V2UCJzPFJDJb9podwBaF3v4mOiXEq31d4G5oyqUTB5aIMlo5SjXO9uEMi8rp9OZZuT
         dK+4bUFdbiugmikr8tjN4QY0CVsp7mR7Yhn89fuxJHSdn21rp7PNL4J1DExiz7I2tQqT
         GFn61Pdc11hB/lgLseoBwQlTdY/yt4nBsymySOjQaYPniZ5ChgHrkh5RDXB/cLcsu04P
         e+/yRoHZZoCkkV3zOpQMbCHiQqeGIw2nu174bZIRfl2I8TfYVBkpIsiKjDiXP0iSfihG
         7LUHxStvDTgkPJIK0gNongzFgk9nTRDl3Bc/U3LLGEzMUwKb36TriMYM2AoUr1b4nJyx
         8NLA==
X-Gm-Message-State: AOJu0YzogAcrEcZuIvqgP85vgHyyG4Zv9d+iwiC/MYKjkKM5BwIXCJlJ
	KKxiEaZLZGuu4ao5oWDl5jyBg4eJWrSwTGu5CRW1eU9oWtMGanKV
X-Google-Smtp-Source: AGHT+IETZ7jN127ObYbIgf7nygTHNXYqmVviqVN77J5FewbxLp37fo7umIa/AsR6j+qONg2QDFmXGw==
X-Received: by 2002:a05:6512:3494:b0:511:530b:6026 with SMTP id v20-20020a056512349400b00511530b6026mr21364lfr.27.1707083863667;
        Sun, 04 Feb 2024 13:57:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXBRAtN9GSeiBDQckUnGphVGWvCn2l9Y9cKU+i4cnBbRcfs8HCncIbZSWOmYnImQ7pSB29f2oA48BH8GVntfdsyCRYR8SEJ8GlQIkv5pLqST3yKGe/qK/76ABvwi5Gq2W0I47N77fE5uWPpfown4t1uWOFTUV+GjXbyzX4W8/9TFYiBdbLUDnpUUWsfMTbQZc8reC4eqamuJ9YdMcFS81CxFHJkX/ABnNWaXFPuLzZTlmfBmgUQFDhz9dt7HLElAc7Pl9CWUO/MOWS+SlNdN1IouxfBvv8swQcKJ0ltOIzfeE2I5zNt2PXjLX+nRn6WKFnnMCLtDG6x45VVMcCgEoxpFdiFplUasQhf/3FErMdYWsbVQJ/fZP+xocijIF2TRJk8k5dDqZGV5ZCHKU/H2lY9tm7sJV/fdpkijmHIMwnmpOnJ8Gae2JdlLrVZtVdg1H5SpCQUB6NSGi6srFR0e8yDWlv6+Ayb6oUXAi741i8byTtMXTynhjnpBRB7t+rs3hi6qV8tng==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id w9-20020a19c509000000b0051134d5e187sm973863lfe.249.2024.02.04.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:57:43 -0800 (PST)
Date: Mon, 5 Feb 2024 00:57:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix a typo of register name in
 DPP safety handling
Message-ID: <pn2xm3hecdo3vts7zfrpnd6xh4st6acobwlk6mzj4vvqeivcsl@5q6mrvgrmtti>
References: <20240203053133.1129236-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203053133.1129236-1-0x1207@gmail.com>

On Sat, Feb 03, 2024 at 01:31:33PM +0800, Furong Xu wrote:
> DDPP is copied from Synopsys Data book:
> 
> DDPP: Disable Data path Parity Protection.
>     When it is 0x0, Data path Parity Protection is enabled.
>     When it is 0x1, Data path Parity Protection is disabled.
> 
> The macro name should be XGMAC_DPP_DISABLE.

Thanks!

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Fixes: 46eba193d04f ("net: stmmac: xgmac: fix handling of DPP safety error for DMA channels")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 5c67a3f89f08..6a2c7d22df1e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -304,7 +304,7 @@
>  #define XGMAC_TXCEIE			BIT(0)
>  #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
>  #define XGMAC_MTL_DPP_CONTROL		0x000010e0
> -#define XGMAC_DDPP_DISABLE		BIT(0)
> +#define XGMAC_DPP_DISABLE		BIT(0)
>  #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
>  #define XGMAC_TQS			GENMASK(25, 16)
>  #define XGMAC_TQS_SHIFT			16
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 04d7c4dc2e35..323c57f03c93 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -928,7 +928,7 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
>  	/* 5. Enable Data Path Parity Protection */
>  	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
>  	/* already enabled by default, explicit enable it again */
> -	value &= ~XGMAC_DDPP_DISABLE;
> +	value &= ~XGMAC_DPP_DISABLE;
>  	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
>  
>  	return 0;
> -- 
> 2.34.1
> 

