Return-Path: <linux-kernel+bounces-51844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474A2848FEB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839C02826A8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C00224A1D;
	Sun,  4 Feb 2024 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8eQWfLA"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F8249FA;
	Sun,  4 Feb 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707071496; cv=none; b=diaQSRZup54906OQvIvG2uipJOdzSVQwGPQtHdpetc3Rv+vNEfUjAK3fnCcHcKs7yZiqDL8wszaRWgVaflVXVpUN5c/LATrehJgyb8Ee5Ap/rB0/5/qql3fCv+vTUNl4wz29lcRqcMvveb6Vp29mawD4lTWb1MvbzhSNy5vO56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707071496; c=relaxed/simple;
	bh=4/zweJK3l2MophoR5XK/zjQFPg5ZOJTbzTv7AZs30G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roAn+BmmNu4WEEUjPSkICoSJl2+xyPEREkF2XC9yUPqrsw1ckI2ArYvvi8HJ1X8kOK3QC+f4JSoGB8odwT2I2dlsq3TDS5fQzd8orSRRpD4rdMtEF48Pmw2jqFKfut7L4aFEb+VCdNLhs8qpwi9da2VoBjdXt/zQQJp/gZraoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8eQWfLA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so368692a12.0;
        Sun, 04 Feb 2024 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707071493; x=1707676293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OR7Z+vfwu+f+wtch2qJcVrMl8oJ/UAVkpOXmCdedmXg=;
        b=Q8eQWfLA2ZymJ60Bc9wXtBhJKFcQCW5ahWo9OSAX77qIvnnU1uycEYomNsHQ/WZbm+
         w2ovt/yGLtuNZOM+8eHkDzP95Jd3JpsXz04IePVB9/tJajH4pWauvWLLcpFnf4WwP/pZ
         0lviMw7ocUlQKafqmx5ZRUa/AKe2omn8Rsrk/YqZP40iybdM3D0oAckcKlJgnFW5ENYW
         9rqgwA4VpbNiNaC0wKoC6l3omj+U7E6CXkEQd2DpkwWy+pBMVPljwR49TuEgdBiJNFr5
         UDiKZHp13u1K/F/2mxYYVxwdSCwu5qRhtTl2qq7Wqsf7iZ5EbVnS5WwPaV8//pRjmLSq
         aC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707071493; x=1707676293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR7Z+vfwu+f+wtch2qJcVrMl8oJ/UAVkpOXmCdedmXg=;
        b=RKMsKLsVit9q2HJIphJJ4mNAwhrIBPkMqGtDmeHyu5SqIH8D73XNDjlQdhWnICahjA
         da3GGIdUnaZy9Zba5BVEo7IIqa6X6VJD3Un7YMbQoyL6bwQsMoBk/OZyCVlXu5LMKTOd
         +PKAmSs+L5cg31BIPeBcNIOZCUZELOV2CwhfZzdpmME8y7koXf35/pXED0+sa86aVKpz
         HOSVcilIbd3reH36rLBNP5ew+eJg4G2yuU7iRcu9D5kpp4U1sJnz42S9J4IKs0nrt/AK
         u8LBSjAZlyf3Lz12PkDcG455OHZXrt1FKSDAAh5NBKDmMcxRp1+wvdIUmE5523dNQyFS
         b5LA==
X-Gm-Message-State: AOJu0YxCwJxbOY9OkGCxlSyGRzAm3IH1SmB9Dr4nkJJt7eVvXhC2/8Wo
	7/iN0Gy6oy//1nUBNt0g1qWvt/ip0+0cADtu32mQWzJ5vBOSBqHBVlG7jGHZJtY=
X-Google-Smtp-Source: AGHT+IEmnpLmx42yFpTjYGwbeA7UrEzydpZOXisejzfIw4qDifJfuyYmHILXajqlMRURq/enQApp5g==
X-Received: by 2002:aa7:d804:0:b0:55f:fba9:dd17 with SMTP id v4-20020aa7d804000000b0055ffba9dd17mr3421024edq.9.1707071492770;
        Sun, 04 Feb 2024 10:31:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqLxSmnWmfcyPQAXKucL304mYbNVD+kKThiwlKxQ6mFQ7BP7ZzFdhYxHVSPs1aToKOGcf43e8BhaUC7kGdAwsSNAteOehs5Li0aairWjmKfyflmWKR4OaVaV85guxZlHE/qL6vXuvrfwjjHk/hlc90gBjYEczjXgwp9w==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id ch17-20020a0564021bd100b0055c8a30152bsm2915511edb.83.2024.02.04.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 10:31:32 -0800 (PST)
Date: Sun, 4 Feb 2024 20:31:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: andy.shevchenko@gmail.com
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v1 1/1] spi: fsl-dspi: Unify error messaging in
 dspi_request_dma()
Message-ID: <20240204183130.r4rdggcqx6czuzoc@skbuf>
References: <20240204162106.1179621-1-andy.shevchenko@gmail.com>
 <20240204182417.jnw4iuqgghxynq3v@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204182417.jnw4iuqgghxynq3v@skbuf>

On Sun, Feb 04, 2024 at 08:24:17PM +0200, Vladimir Oltean wrote:
> > @@ -541,16 +538,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
> >  	cfg.direction = DMA_DEV_TO_MEM;
> >  	ret = dmaengine_slave_config(dma->chan_rx, &cfg);
> >  	if (ret) {
> > -		dev_err(dev, "can't configure rx dma channel\n");
> > -		ret = -EINVAL;
> > +		ret = dev_err_probe(dev, -EINVAL, "can't configure rx dma channel\n");
> 
> Passing -EINVAL to dev_err_probe() here doesn't work. It overwrites the "ret"
> from dmaengine_slave_config().
> 
> int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
> {
> 	struct va_format vaf;
> 	va_list args;
> 
> 	va_start(args, fmt);
> 	vaf.fmt = fmt;
> 	vaf.va = &args;
> 
> 	if (err != -EPROBE_DEFER) { // <-------- always true
> 		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
> 	} else {
> 		device_set_deferred_probe_reason(dev, &vaf);
> 		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
> 	}
> 
> 	va_end(args);
> 
> 	return err;
> }

Ah, the original code also ignores the dmaengine_slave_config() return
code and replaces it with -EINVAL? I wonder why that is... It doesn't
appear to be a widespread pattern. Pretty arbitrary. Could you please
make 2 patches, one which preserves the original return code and another
which uses dev_err_probe()?

