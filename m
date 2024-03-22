Return-Path: <linux-kernel+bounces-111359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F921886B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618611C22059
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8693EA9C;
	Fri, 22 Mar 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjHVqQAE"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440E20DC5;
	Fri, 22 Mar 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106323; cv=none; b=CRJg2a5kvpu0o/+0kai3/pIcNHHkYshNDQqbLZMzhQ6NJXbLVH7/fvjGhlbwn3YF467F+BND8gFmS/SLfuBokQCOUFIO8yPpWA3AVzgljf2Y04CQ1vJdxiJnzDI8yZlXpvWR9wLjoeBCJtLbWjfdluVrXqvfkN3mziE65YeLaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106323; c=relaxed/simple;
	bh=MFvINfn5vumvepkoPTdM2FbWdWBkIsMV0xzgDvstI14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC7sqRKNGnJM9HpHRVAG/0ue2D6XdAsQoD1H1haiTzdmOcuqb36tiI5/+yEqS/I2TwhBe6T45GH//lWnZoWd9+Ist/CaTW3JvYMjfzns3GpUwBS918qN+9VsOfBlUBj6jhzWJKRjEFnXtbgCIbOKZPhzXPfaqBzVt217yTdFbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjHVqQAE; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1381320a12.1;
        Fri, 22 Mar 2024 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711106322; x=1711711122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzMeF+sVtP3tFHQX9ucDEOR6oj0iwNtMEiHNl4LGR5E=;
        b=DjHVqQAERAtIGl8LvNPrP2ebuvgtcBtPrrs2LrAItCxueD5nPBQ/rIco8Yx5/4rL0e
         f4Das8RiYUh+F45l+P5QTadotEvp6NwKKWFpT4RtzDaNPvUwZB3RupySUVSLo4Cj+U6i
         Lwtk7K2uh3Lf31JlhaBac0ls5ZVl4kGPUEcxVE22xDu8EinC7opXclZHizuUrV2vOARJ
         W+eeGgrb5k32Eu68aHpMXR392L5+JozL9MoHrIlUJmSwlzKMNVA3e9O9w6GJ60/xMDRH
         yvXKbjpBZYlU8LqLLSEvSDGAzWPWAYH5TZ8zp7/o8bL13Frolq19cz+tJP2Iv6kFauSE
         mDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711106322; x=1711711122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzMeF+sVtP3tFHQX9ucDEOR6oj0iwNtMEiHNl4LGR5E=;
        b=rIchO2XurKKac/Sa+zT5lQP/Xu+joY39SAaKxmC72KhsR8Z9c9a0Nyi9mJDAQYLG6M
         zbyxQEI4VyXC6Rb/HNdZolbVsk+Ub6x6NCorwt+WWYXH2LmI2gUboliCPOmH+14fPijQ
         bMx/Na51zYc4vA7RehBTVjITNPP7h+bbVUb7RqvIqAFnf1X70LUlmHWbm0wDrkKHP4p5
         eR4kYi68zsS5IAqxkFwDgcY7kCpSkAdZHfTjZzlwle5OizS9xeMspdi6M7lNRMTDESsC
         n7+kIzkfawkwSa992fJM/uqaFK8Xxlx4vG2BVabr/OI/i1zvRXPTb9XN4d7KONtjBWyD
         dpBw==
X-Forwarded-Encrypted: i=1; AJvYcCXjj05Z3zy1QzMowbNrmXdYOcZ3B9EXOUFyLJfFypTy/4Gvh73yxYksGR78xeIeVRXTh6l50AbAlcQC+BcMvfDFmKFoIYCDe+7YTT2LkDM/q8uIyR52rXwEWZn91OX1N79LrBNAv9vsnoyRFf4iKeCqEpBDloDl+1m0eXxe37j52g==
X-Gm-Message-State: AOJu0YzbYd95dgQ/dqjvJOlfkEn0ibXC5aMlLj3mLTt0v5bjLHUe49UA
	rw1xpYLxzxNavKSKNU2IVE95KwEa8Cn6rt5NAfttqA9QNg5/G1LT
X-Google-Smtp-Source: AGHT+IGSmSngE9Cy/E/c/MFNCQX+hYIsufmB4ZwEAJR25mnh8Z66mbkdBiB9zPT0wfXskLrfQuBNJg==
X-Received: by 2002:a17:90b:688:b0:29b:c4b7:3300 with SMTP id m8-20020a17090b068800b0029bc4b73300mr1955206pjz.44.1711106321743;
        Fri, 22 Mar 2024 04:18:41 -0700 (PDT)
Received: from rigel (110-175-159-48.tpgi.com.au. [110.175.159.48])
        by smtp.gmail.com with ESMTPSA id nb8-20020a17090b35c800b002a039de455bsm1244149pjb.1.2024.03.22.04.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:18:41 -0700 (PDT)
Date: Fri, 22 Mar 2024 19:18:35 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: cdev: sanitize the label before requesting the
 interrupt
Message-ID: <20240322111835.GA24228@rigel>
References: <20240322090209.13384-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322090209.13384-1-brgl@bgdev.pl>

On Fri, Mar 22, 2024 at 10:02:08AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> @@ -2198,12 +2216,18 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	if (ret)
>  		goto out_free_le;
>
> +	label = make_irq_label(le->label);
> +	if (!label) {
> +		ret = -ENOMEM;
> +		goto out_free_le;
> +	}
> +
>  	/* Request a thread to read the events */
>  	ret = request_threaded_irq(irq,
>  				   lineevent_irq_handler,
>  				   lineevent_irq_thread,
>  				   irqflags,
> -				   le->label,
> +				   label,
>  				   le);
>  	if (ret)
>  		goto out_free_le;

Leaks label if the request_threaded_irq() fails.

Cheers,
Kent.

