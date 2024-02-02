Return-Path: <linux-kernel+bounces-50444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44378847901
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F282D295502
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5F483A13;
	Fri,  2 Feb 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISGsmjgW"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBB80626
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899543; cv=none; b=IFOVcDcSIX7W3GySbathdwPCda492Y8cBWy2LTmJ+yB0cWRI+7a5v9pHXzrWlUDCxhJ+QBukQttfm3w5QLxxtSRd+3wtDs55tQBIgmEKoElEDHX2a9vQw00kEgUGp0kN8GwPqkFFPGb6eiC3SoO4y97p0/kEnZWi+Lxy3U/8N7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899543; c=relaxed/simple;
	bh=rBKu9aWpLQfoD/Jg07Ku9jg2NAxJPGNWxzDssmImpfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1zWopc/qB/CQX6/tbE/XGUP1w9WhUh2cK1jKI7IpJYBwxcbAthIYC4KQoSVO7vBvCgpOu5dfVTsY/LLkrliiHDTeEnM1N9SiIX4k0X01iamd4EmTNweWMtOwew6OI+JR0c2oZ/08n5/OgvjT84RN790vy1LsyCs8lzk+LsAGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ISGsmjgW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a34c5ca2537so346545166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706899540; x=1707504340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwHFsR9igFcIPXKmJqsnMgVGlLrMRqn2qb3tuCliBlY=;
        b=ISGsmjgWprSELr38UOGnFI1OzG5Fz7omJ7mJ7iMWd53PO3NIYgmbOIooFBwLVlldou
         fIaGGx6WU02MC4eGG8XaaYscP2HORX55sw9nYQ8Pnd5C5RBrqsO8Fz6ZJNfMfR587EbS
         xdpPxwwsBBxnzxR543AWL1/cxwZQ29aB0I8hWzR02y8Z+4vnG95hj+0CDEDpCyRLxFMP
         +3LDBCDoizjaZNekzUwyI5ixnrr4ultT1lECU57EVrMzHufV4L+IksOLgwmmFuF++MIh
         beaWDdcbeBDX0kgBIlaGddDA9jPyF/513R/IT3nw4B985nOoY+LYG0tRNpYYIXI7GMnY
         Lgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706899540; x=1707504340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwHFsR9igFcIPXKmJqsnMgVGlLrMRqn2qb3tuCliBlY=;
        b=w2EhQdKWkU0YpdVtiWwIAFs7MmbNdSJ1SGqIt/Ar/DgCG17XOFqwp8Z5354Z2BuNAJ
         SRB7nEK3hVAT8LO+YOZGtBFIHZZX1TIHe8mq7+cVxqd3lqkaUFg9VqYh9r47vyZMjx7s
         4wy4wpykQYeogGvwOkXwOu+zgbq2J0smfvAsqq86wUG6Wt1nmV8AsaOrMGjkN1SnRHrH
         C3BfEAHiZajcA0O4kxZE8mqPNInAA37YG+iKp0+TEX7M004g3Nj3mj12vNAjbfay95hj
         avmrRCnK04kygNkexN+VYPKysXLmZ8SVryXvyc8B3ojiy0yRQPZWkLTR1ZxjR6hvIc0H
         +D8g==
X-Gm-Message-State: AOJu0YyuSlqM/Q1CB9wjHZjXwz93VR1QOkcqg9KxpF9n/85PhiIbCc2K
	b2+qe+K2PCwYiiZNuC6lEiAI5TXq8gtzzim3+96GXHoe2LyVNEjkEPujfdWkb8I=
X-Google-Smtp-Source: AGHT+IF3ZEMkBuRtWy4yUKvX193x9ver9yfqW2Q9J6ERjJ+Xn8n7NDdLvoTbsxNNGbSYTVR2xHaaUQ==
X-Received: by 2002:a17:906:7013:b0:a36:239:77a with SMTP id n19-20020a170906701300b00a360239077amr2129511ejj.23.1706899539714;
        Fri, 02 Feb 2024 10:45:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVc+L5266YrE7frcSaUyADns1YP9/8S/1kIzTLfB2FVrqjxF5mLD04WRC2ct+m4lRmhFNW4PaZClk3nwee9wQMLbq0nRUsScGtXq3QW0mrygn8hZi09VVgNwHoN6ZnLcELqRRyR0KRbovVUxB5BM4SFjz/5nFW21umrOEJQyO6lZ4wsIZE+8ANxNr66/z4dpwNv2SEJDxm88A34o3sDDbbqoJ53lOgQ5gP+EnQWjG0usBM1YJol0yEwYz3j2UzYb7WfnHM2/ghCUTaf4luIfV8Ha88n2e7yfur4kaWf8n+gKm3YeN911L043elkGKqAQLsCE9arnqVWjwHA7ZC0qOwj1mTYpxVB2/SDV4FA7+22Eg9rcH0UPrqnnhhJXPUwFyBVTZ2Uo7dSbFiFqAjOkh9qWSXvjTvsseytu8u6ZUK9V0t8n0EJLNjjNvt9i1Ay1EErCpPN0pJA85cX
Received: from linaro.org ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id mm15-20020a1709077a8f00b00a37319aadb0sm240100ejc.15.2024.02.02.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:45:39 -0800 (PST)
Date: Fri, 2 Feb 2024 20:45:37 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	kernel@pengutronix.de, linux-imx@nxp.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] clk: imx: scu: Use common error handling code in
 __imx_clk_gpr_scu()
Message-ID: <Zb04UUeE/cU9HtKZ@linaro.org>
References: <20231210171907.3410922-1-visitorckw@gmail.com>
 <0e906ec6-fe73-4dbd-b555-a2c03b6e1030@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e906ec6-fe73-4dbd-b555-a2c03b6e1030@web.de>

On 23-12-22 10:23:13, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 22 Dec 2023 10:05:32 +0100
> 
> Use another label so that a bit of exception handling can be better reused
> at the end of this function.

Please don't send patches as reply to other(s) patches.

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/clk/imx/clk-scu.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index e48a904c0013..4ca9dccf3d3b 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -882,19 +882,19 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, const char * const *parent_na
>  		return ERR_PTR(-ENOMEM);
> 
>  	if (!imx_scu_clk_is_valid(rsrc_id)) {
> -		kfree(clk_node);
> -		return ERR_PTR(-EINVAL);
> +		ret = -EINVAL;
> +		goto free_clk_node;
>  	}
> 
>  	if (!imx_clk_is_resource_owned(rsrc_id)) {
> -		kfree(clk_node);
> -		return NULL;
> +		ret = 0;
> +		goto free_clk_node;
>  	}
> 
>  	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
>  	if (!clk) {
> -		kfree(clk_node);
> -		return ERR_PTR(-ENOMEM);
> +		ret = -ENOMEM;
> +		goto free_clk_node;
>  	}
> 
>  	clk->rsrc_id = rsrc_id;
> @@ -922,6 +922,7 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, const char * const *parent_na
>  	ret = clk_hw_register(NULL, hw);
>  	if (ret) {
>  		kfree(clk);
> +free_clk_node:
>  		kfree(clk_node);
>  		hw = ERR_PTR(ret);
>  	} else {
> --
> 2.43.0
> 

