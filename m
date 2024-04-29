Return-Path: <linux-kernel+bounces-162692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C928B5F23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F092A1F21178
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108785C6F;
	Mon, 29 Apr 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFFWZzQG"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB41DA23
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408557; cv=none; b=ceNFM1dRQ+VB5pooSgLZMfOnqJ8lNp8AMj0uBfNXHDJTNVFSfibhu4TMTmwXUPlQ9fP1YVJcAFWIt8p68vXfKIcwXdmjkeqndZWQVyyXVtzgVcRadaIU075yPIGvvRr56MZvwbPcWbfTiUGf/c/N7ERiV8VIcTSEiADktf1TEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408557; c=relaxed/simple;
	bh=RrdAgFpxvfICpslsME+uAzTz5L+5aHCg8asgXZuWRvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5cV+uKEi7rTgdwmpeCXQDCED0jsFsowny7T5j+I9Te8QwMoZCbUUKE1YFkQYyTZnWTm43qNVUqbZr6U8SmiVa1+HkWBdeulr3bD0Vyxt+mUJTWZZg44aYiXAqo2s2xcfGPKfw4zmIWXJ/h1rp1BlQuvZ3gAz64v0y6iHipIHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MFFWZzQG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dd64d6fe94so53153731fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714408554; x=1715013354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=adQzda6pc9co5++PgQWHY34hjE2pAbP51bI2S0NH5CU=;
        b=MFFWZzQGvMB3sZPd7XGWhailnvzkrtm3LS/5aEEtyLszFr305CoNZzQwetIzKdG7/v
         ppNVrhDPBsItfOIPyWvor6oT11Jjk6mVGchfxMhRjuDCjbkVL/DmfhNLgbIltuT2fgeM
         pGNTnWeB5O81XQ4n32AOYx+kQkSPsx3rHm/jgC5eq21ZqeL2Sd2isEwjKL7oYrLqSiDO
         IOKBfV20JxAKY1Zjv0EV+HJqLauTtUdig6HO8cXmw3ERzbt0qQsHtgyLappOse6OVJ5h
         wApSzD29UhSl+x7i0a5pzqXhu6uB6cYRG3KuhVDJw6j4tpMkbtbwVzqoia2uzwzValg8
         OOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408554; x=1715013354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adQzda6pc9co5++PgQWHY34hjE2pAbP51bI2S0NH5CU=;
        b=PxZkWeaaWQ1neX87Th3AjlCz6doWOpobrMhrSEfJR600uV+DDjBzNUAZgMRhNSd4Rz
         s3aaYZPD+/EqfOVb8c9fwp9bVfkyF1j8eJex84P5Tf76GS3X9Mt2hxZf+PXxxyV1N5mR
         iDnEPrN0uL1my6F6k2mDrLaYtOCAtBnrygBBGSHupfuTWb9sulpFgjGaD3CCd0uzqRBH
         r1A9L57Ka1rKGeMGQbc5I8+n4zl5tGUrwXYAR7L+juZBefrhILqYEJy7RuMEE45mSWCa
         HMScCs1DJpe2LSIjogUAez85ZxaQD6E0JzVmvtIVnG+gP9Acu1nSX+5iNtIx4DoNPmrL
         O3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5qDQVY5G1mBFJI6H0rBfhT7F6E0h9vpKX20m9bGdyA4YkLnR+Dp/r40OQWe+iSHfpmEseTNkY/LH40MHaXu2f5vjHdo+GkPx6Bojr
X-Gm-Message-State: AOJu0Yz6HqgA0rx1t4gm+sYO1xdwBjE7dtFYnj9kSFbyz4nfabFmH5B5
	QWBJWaI37DtphOTMPBNbPGM0hS2ZumeK3Bc6n6utX/t+DpZscWZSJ0fEzh2bDCc=
X-Google-Smtp-Source: AGHT+IGDTwVSx+nyBEEqecLTAG5SWZdeSLzhvyNBENyKS37lohDmf4DELco9ZuvEF8Rv1oK17n9Kaw==
X-Received: by 2002:a2e:7c0f:0:b0:2e0:aaaa:e550 with SMTP id x15-20020a2e7c0f000000b002e0aaaae550mr1329798ljc.23.1714408554585;
        Mon, 29 Apr 2024 09:35:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id l9-20020a05651c10c900b002de553e0a7esm1874471ljn.102.2024.04.29.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:35:54 -0700 (PDT)
Date: Mon, 29 Apr 2024 19:35:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] usb: typec: tipd: rely on i2c_get_match_data()
Message-ID: <3xo5l7b5ushwkpq7tfmic7eurg624sd6f47v7fobmawtq4ai4w@qnbrumzv5nha>
References: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
 <20240429-tps6598x_fix_event_handling-v3-3-4e8e58dce489@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-tps6598x_fix_event_handling-v3-3-4e8e58dce489@wolfvision.net>

On Mon, Apr 29, 2024 at 03:35:59PM +0200, Javier Carrasco wrote:
> The first thing i2c_get_match_data() does is calling
> device_get_match_data(), which already checks if there is a fwnode.
> 
> Remove explicit usage of device_get_match_data() as it is already
> included in i2c_get_match_data().
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/typec/tipd/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

