Return-Path: <linux-kernel+bounces-148835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578928A87EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DC01C21BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF48148FFE;
	Wed, 17 Apr 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HT7MuNfq"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4621487F3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368335; cv=none; b=SRKr+OGyae9wep01qIbQRQ3FqaZP/r8roL4+vfoHYHCT9U1j1ClPfjNdF3KnufKTHbQqbIY6NU0pxvq4kwwjoKSpEQ1X9rMrXb7flEz2rvVcwJl9S7QCfChyfIIqIRixuJ8OFftSbL4naRXizkeItH6PyR7dZ9IahnGwUKoJcLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368335; c=relaxed/simple;
	bh=m7Jg/vL/xKOfRHStwyCzgv3f4ySN7DR3F489MW4STus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B20UnYNe93J6++T+P/C+m4QM9Wz3vXkP66r+jECkaWeAjZGqX3Hxiee2Ae3tk5tYex9sk2xWnI3Nu3stP6beMo+EhPxJE2GGSFqCdlqtp2wNsmGXsGH770rnwuMF8AWr49BKrsk28I97Zco7phFp3eCokxTMAP4YA2do2fuMCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HT7MuNfq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57013379e17so4297744a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713368331; x=1713973131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2pX2HX1tz4L2xSO2Zk+2hCUXSnn6DNlfR6Exc5bCT0=;
        b=HT7MuNfq4lG20KJ0mD0MJJdqhtp6n2dz+Gr4e+WR8/aYSlJ5u7u9M8vGJp7doMdJWK
         1fbbkmuYsZFr1+T+TbXB0EsPYIP7I9bhSo1w77zYBJ4UCdx4OdeO0cD2RIHD5siKyRlp
         ubLuhU9tp+pT451CTb65nmo74orPc+yQKV6NO2CZKUINCUD7SBViJurqwAPuv5tvniO/
         vl9LFlJEotivVta4EL+O3lDojiUY/3RblKA2fjCwf0M9rjNQa8OibBPmud5JrjCZjW+F
         3AomIEzrDkV1fKJnMuVlyXYnWSJMrqZMu5zO89jdBhDCBKzM1yrw2fH5B8dfYSqROVUg
         PsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713368331; x=1713973131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2pX2HX1tz4L2xSO2Zk+2hCUXSnn6DNlfR6Exc5bCT0=;
        b=DXELDw4thFZauQXNq9QrJlDqiF0Yqw0xVMmXTKJXMfuYLg25OtfnaLmNMl/VeapCaZ
         CgnLmYuazgnChNLwiXlE9pKitMM6k3c6frN3F1Eu6reENxxAHp/ATukRsP5ClBBTynvh
         YoH9q1xwsF8Ii9b0uaO5Q8vRnaQARZX1iaOzF/64eecdxPTRY07v0ozKUfhDlEyfROpR
         NBdjbdgrBPMhIuXWlLilQj+X69YRWz5VVTHvnvJWiUrL6jF06bWDFl0YnRUIyGXbY5yG
         Xczl8jH0E1UeerrHQyZHScBN5/sZz4BcvnsVgmdRRnej2yEHAaEIHySBUAPynmKyA3Lz
         b8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoyppWJAPNX88jkL9/JX0S4ZZ/JiTdPF0h8JssHUxFJgbUIwZ8TT7eCYfJhWqJuoZWklkcbrLRYwjpdCYx60StwMuj7CzANfPAesog
X-Gm-Message-State: AOJu0YyM+o0uzELOUaRBgQLOFd/QcvyttEgV14E4RskvyAdgw6Fg4+It
	LSqYXkEzwNbT2ZMnsDL/tBHyaqHLPZzxda0mk2eY96y+K0vLnxZLj/6tO1KjX/g=
X-Google-Smtp-Source: AGHT+IGlfGw+4FpskCxgZJHJHpEBj4/cFequxAP7fu3wNXs185hTt2/Ula2a2m4jtIdBx0Xh5KXoOw==
X-Received: by 2002:a50:cd5d:0:b0:56e:2abd:d00f with SMTP id d29-20020a50cd5d000000b0056e2abdd00fmr12943233edj.18.1713368331309;
        Wed, 17 Apr 2024 08:38:51 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ev27-20020a056402541b00b0056b8dcdaca5sm7427656edb.73.2024.04.17.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 08:38:50 -0700 (PDT)
Date: Wed, 17 Apr 2024 18:38:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Zeng Heng <zengheng4@huawei.com>, linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org, xiexiuqi@huawei.com,
	linux-gpio@vger.kernel.org, weiyongjun1@huawei.com,
	liwei391@huawei.com
Subject: Re: [PATCH] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Message-ID: <d80e09d8-5f35-4865-9fe8-195b86527972@moroto.mountain>
References: <20240415105328.3651441-1-zengheng4@huawei.com>
 <Zh_rM04PspfXxlv_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh_rM04PspfXxlv_@smile.fi.intel.com>

On Wed, Apr 17, 2024 at 06:30:59PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 15, 2024 at 06:53:28PM +0800, Zeng Heng wrote:
> > If we fail to allocate propname buffer, we need to drop the reference
> > count we just took. Because the pinctrl_dt_free_maps() includes the
> > droping operation, here we call it directly.
> 
> ...
> 
> >  	for (state = 0; ; state++) {
> >  		/* Retrieve the pinctrl-* property */
> >  		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
> > -		if (!propname)
> > -			return -ENOMEM;
> > +		if (!propname) {
> > +			ret = -ENOMEM;
> > +			goto err;
> > +		}
> >  		prop = of_find_property(np, propname, &size);
> >  		kfree(propname);
> >  		if (!prop) {
> >  			if (state == 0) {
> > -				of_node_put(np);
> > -				return -ENODEV;
> > +				ret = -ENODEV;
> > +				goto err;
> 
> Has it been tested? How on earth is this a correct change?
> 
> We iterate over state numbers until we have properties available. This chunk is
> _successful_ exit path, we may not free parsed maps! Am I wrong?

In this path state == 0 so we haven't had a successful iteration yet.

regards,
dan carpenter


