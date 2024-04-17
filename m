Return-Path: <linux-kernel+bounces-148311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE88B8A80C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D48AB23551
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6EE13C668;
	Wed, 17 Apr 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nr3mPg5X"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9F13B295
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349213; cv=none; b=tnp71dW0+VSexk0K1oykuwHofzk/mdhblY1gnRaoRalVBshQxylTmJEGF0bsAuyp8BmkoMvFwmQpqoEC7VYsPknnsrslohrDRL/M+5iIQwE8wXHJBcPN8O3gaROWEHl4nJjJn8aLBPcQG1bYSOPYC9jP/Fu9z02FHN96F/gyl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349213; c=relaxed/simple;
	bh=dDjG6YB8WcpgRH4sCEbHA+wVKctkcmxmzME/qEIroiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw58oN0E/m2p3UFUBy+3FpDrM2shoR5fU7wEk/qF7NG+6V4rF5tKyjJ6eT6r43YxEsZVgYoqikPLO7adNVUGtgsYSnNKB/867JuQnrAnXAF2VEgLWiBB1oWavCHUF6By+mNj5Q+b7a16LX/AJg5QDh3FTeiKLBxsKi+zFT+aejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nr3mPg5X; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so6948669e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713349209; x=1713954009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrs6iAAO4SVBswghNTTZW+QUAJVqns3ugAjr/mrsbC8=;
        b=nr3mPg5X1MMEh9dvZRrrD1XDqRHCySxUpmuQTN3fFndrRQCnyXfz3ZyYGqVAnXF9Fn
         OEuRGI8Q54G8G5mwBHtnI/4tsgcE9soWdXpMSNdIMyvI5GOFOqpsRJf4vF6Xeur4zYG7
         7O9RApRL+d2lGKrCdmn5ngkFdsQrGkunxFTBkNV/Dw2zhbnKj1i9G5jXPQz+n78Ni8F5
         QKJ8pcwE0NJTYMHJbF5gkggJb+Cl0YXvaflwV9+69in7MkCYxsG6DWx0sA8WYMqrpCT+
         yLcXXUg2s3INznva5yqq1t0Tyfdghx+S5nml6EsNL5KkyozkxBPsd8Hy/KEJtN8jCxxB
         blmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713349209; x=1713954009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrs6iAAO4SVBswghNTTZW+QUAJVqns3ugAjr/mrsbC8=;
        b=whSdNXZmtatcASn1Md+Tt38wdS+TzSbs3ookPgUYIBbAj7N/LdBnqzuYJDVxa0pY8Z
         eoCqNcDLwZeLVKCruusPDPgjWQwdEFD7a1OxtHi65t4SIdRGenwBfAQw1JUINtAusdjJ
         DwzMfO97az+xe13oUr+1gveh/nb/K4y2H81OJEWijErrBQYJpczDkP6GazpRn1YwDVuM
         0xjsVil4/e9+J8nDTR8wx5fUdmzh5bUPxo4PtgRtSJuJ9I50063TWCjB5FxAqFe8mnFD
         S21fLkmLJPb7AMtCUjNJdZVEEHQCYO61jqIJZvAYQq8KWHe6JxlAZY7MiBRvWqXWfK1f
         1FXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd+oCIQc5z2kxLbnnuv64pVqB/GM7jP9NjAhp2Ljxf87ykkDLNIW8Tf2QdKEL7miKG+F37/4uW/b1iUVTh66/rpGlAwfcGw4XXDDS7
X-Gm-Message-State: AOJu0YxCB3347xDrrd/g22hV4Xsxdd6DkyOtXRB/Nq4aI5D5dljQTJ0L
	pdcVRx/iL409+pXK3u2/sYQob4mz29JCsu7Tbj3xlp9Qgz2jIojEs5Xn4xS4KKw=
X-Google-Smtp-Source: AGHT+IEOahWQed32kV3EmBcZ13tNLL9ukzZ1h1XrxShRCPrrH1eKgqV1FmVUa9zexHbub5gfEuA/6g==
X-Received: by 2002:a05:6512:a88:b0:515:a8e0:bf3c with SMTP id m8-20020a0565120a8800b00515a8e0bf3cmr14614083lfu.32.1713349209568;
        Wed, 17 Apr 2024 03:20:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id w12-20020ac2598c000000b00516c403d243sm1901592lfn.60.2024.04.17.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 03:20:09 -0700 (PDT)
Date: Wed, 17 Apr 2024 13:20:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] component: Support masters with no subcomponents
Message-ID: <h47tqpveo7iitrz2luqifb7fidrhfv4o4rsivvb7bacbhj4qcg@xmamgxyfk3qr>
References: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>

On Wed, Apr 17, 2024 at 11:12:09AM +0200, Herman van Hazendonk wrote:
> This happens in the MSM DRM driver when it is used
> without any subcomponents, which is a special corner
> case.
> 
> If the MDP4 is used with nothing but the LVDS display,
> we get this problem that no components are found since
> the LVDS is part of the MDP4 itself.
> 
> We cannot use a NULL match, so create a dummy match
> with no components for this case so the driver will
> still probe nicely without adding a secondary
> complicated probe() path to the MSM DRM driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
> This happens in the MSM DRM driver when it is used
> without any subcomponents, which is a special corner
> case.
> 
> If the MDP4 is used with nothing but the LVDS display,
> we get this problem that no components are found since
> the LVDS is part of the MDP4 itself.
> 
> We cannot use a NULL match, so create a dummy match
> with no components for this case so the driver will
> still probe nicely without adding a secondary
> complicated probe() path to the MSM DRM driver.
> ---
>  drivers/base/component.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index 741497324d78..bb79e7a77bb0 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -497,6 +497,10 @@ static void free_aggregate_device(struct aggregate_device *adev)
>  	kfree(adev);
>  }
>  
> +static struct component_match dummy_match = {
> +	.num = 0,
> +};

I think it's better to handle this in the MDP4 driver code.

Also note that LVDS / LCDC support should be fixed anyway. The DT needs
to pass LCDC clock (which it doesn't). apq8064 uses DSI2 clock after
reparenting it onto the LVDS clock generated by MDP4. Previous
generations should have a separate LCDC clock coming from MMCC.

> +
>  /**
>   * component_master_add_with_match - register an aggregate driver
>   * @parent: parent device of the aggregate driver
> @@ -516,6 +520,9 @@ int component_master_add_with_match(struct device *parent,
>  	struct aggregate_device *adev;
>  	int ret;
>  
> +	if (!match)
> +		match = &dummy_match;
> +
>  	/* Reallocate the match array for its true size */
>  	ret = component_match_realloc(match, match->num);
>  	if (ret)
> 
> ---
> base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
> change-id: 20240417-component-dummy-a9aae5ac7234
> 
> Best regards,
> -- 
> Herman van Hazendonk <github.com@herrie.org>
> 

-- 
With best wishes
Dmitry

