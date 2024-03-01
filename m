Return-Path: <linux-kernel+bounces-87960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CA86DB81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56142288936
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA567E74;
	Fri,  1 Mar 2024 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlHp8fvq"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF877657C8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274805; cv=none; b=SBArXL4+wV1b33elCr57KK9C/z6TMf3cTWtB4Q6p0TI5OaGJ/QxmADqb02PXY4OpIabw6b5K4Hx7T62yQMKmm1ZxMasszGshRZ/I8u3DkAT/ioQWhhpNkGAyUUnlP1xWtdMjUhd/cHG0oDs59yxA++fB9QehiCrn2oYQK8RwXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274805; c=relaxed/simple;
	bh=nDOja5tFv2kw4myGXPIMJqbuRiw4W1oOPbG/TQFLCSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjwmY5E3MSOMwiSxWgSsQV0/6lpH9VfcKS6EfU8SMP8IVux/YhVCP9rfB3bmxYFnY9ZYnVJD9HG95wbK4DW2RPZ4MlshG/bQ/eizA+1GKIPlY949vr8gcd1DLx6P7yUpO2jekYQTa07MJzNkEcdFARh+ku4gbm/uyE8OUjsT5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RlHp8fvq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5132cf9167fso647184e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709274802; x=1709879602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I4AvLK/FjCNfuk8kByJg2sRy0XAPgz7MRQQYrJtxRXE=;
        b=RlHp8fvq1+dHuszktO9r9Ybyukn+PpTZ7g8MLtu+uNeNtSWOkWUpZz08I2qBOj1ubq
         azRpt4ykhUPACOH0al4g+cfG6Enb1El3beJ8vj0fLmcpBGLevZQ0MWSOhj0ZrxYY3orB
         qO9zU2qY8zKxrI6BsnfNk1IgLeYbu6LmUilxjK04cY3G8IYi6dbx24ksnsAcdV9jZNqU
         5O1P9TqRWrRcbRrJA8vcpxF/vlnZ8MJ5jNOLwOL7p6nOAxd2FiFdLUO5fEPIvsCJVXeD
         PANb6XrCshizD32ALET4uuQIRCNKq7E5rTiQEtjDnz78jQMH5JEINXs1LYCPoLihVAWC
         027A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709274802; x=1709879602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4AvLK/FjCNfuk8kByJg2sRy0XAPgz7MRQQYrJtxRXE=;
        b=Soh4JAFXCAwm64tHUBk9bB46BliZnYFz+XkB9D/XRMpJwo8omw39KMc4qvpGdjSle5
         AP76d761HBz+OrizzLNRh7BofRxfyXlfj9SyoyRs7MdxZB7yRzFfVAkwQ2hn2uY6RwYk
         Q47x7+HC3f3GQQmcSKgMiPJi5wMnZzdIYFlNQB3sWg3xnOw2vGH8iTab3C0c/NNOzt5Z
         KS75wjHb/+bxhnIT7864vHzqLAsi8aiJI/fbXJ/TSDGQf1zOpDIhVoETgSZc7bV0QRGN
         Jl3oGLCE9CjuTfzupxsumpPVyRMVoefMt8zG2uFftI+oB30ZWR/xupRGrlNt261seMb6
         lOxA==
X-Forwarded-Encrypted: i=1; AJvYcCWBEzjQeY/iA+StRL3GhAm61x0FXYoa0uMmZVz30nk/rENYPzIvFocz2TK6mFr2ysWh3QU3/ZfhfXn0G3dR+HERMHUS4AKPXNqIROFM
X-Gm-Message-State: AOJu0YwM0jhm/zMgED0eUKKq4xrFYHpMIzJ5wTFeCgROm38qwpBnLZKt
	BSDd+5f6h/nUYPsFPq67tLMhWEZoidoKpDSmmsXSLcHz2kp4ScyjcIFEYeJ3FoduAWY7iuZ9wDh
	9vGY6PkrLLRJsSV3hhhzxXlZDoCDItqdn0BOI5A==
X-Google-Smtp-Source: AGHT+IF53t416hDTlEtbXDXQmjAY2eCQAvbfGdjlHpLL4jfA6RJI4WdAuRVR4lP0YB8xoY72Ina08cBomwWxYjV/f70=
X-Received: by 2002:a05:6512:200b:b0:512:ee1f:b5af with SMTP id
 a11-20020a056512200b00b00512ee1fb5afmr453495lfb.41.1709274802001; Thu, 29 Feb
 2024 22:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301063214.2310855-1-kojima.masahisa@socionext.com>
In-Reply-To: <20240301063214.2310855-1-kojima.masahisa@socionext.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Mar 2024 08:32:45 +0200
Message-ID: <CAC_iWjLtDjHUd-eD-xDaV-mw4e_bzAPcO9+XXPOSDZ62E8x_oA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: net: netsec: add myself as co-maintainer
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: jaswinder.singh@linaro.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 08:32, Masahisa Kojima
<kojima.masahisa@socionext.com> wrote:
>
> Add myself as co-maintainer for Socionext netsec driver.
> This commit also removes Jassi from maintainer since he
> no longer has a Developerbox.
>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ecaaec6a6bf..494e08683b64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20214,8 +20214,8 @@ F:      Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
>  F:     drivers/net/ethernet/socionext/sni_ave.c
>
>  SOCIONEXT (SNI) NETSEC NETWORK DRIVER
> -M:     Jassi Brar <jaswinder.singh@linaro.org>
>  M:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
> +M:     Masahisa Kojima <kojima.masahisa@socionext.com>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/net/socionext,synquacer-netsec.yaml
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

