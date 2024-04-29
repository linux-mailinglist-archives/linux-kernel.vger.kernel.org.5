Return-Path: <linux-kernel+bounces-162031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7568B54E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5604C1F22368
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB83987C;
	Mon, 29 Apr 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7Y79DO+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A882375B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385830; cv=none; b=RWjFYKmgbZUdxkJJHGpQQ2JQ+h+BSlT7xe0F3OUjbuQulWjpQ/ZJERPet9fX0Wdkg4ecZvfAX/crmueYzplnCo6cYCwdnPGcfuCt8YXFuywEs6kPFogaLvBmskF/2BihCCjVELENKWZJLPdQCHeA/DDBrM+XO+SMSFidnP688TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385830; c=relaxed/simple;
	bh=4KpWDp/ggmypimTE6T18g796fcHjpwkrxeAMIurVybU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITaq7BRrXchL8Fp6F6t2XBqbthTijDs2p271Gj2n5OiGVVrm2E25XXu1p5lw9XJ2pHLq7NyHH6Bx6pQP3Iycqo1BVEeH5dR4Lvhmshh0n3ZKzg8mYhBf0gNAlpvFZCImh4TS5DspTvFihn+1fS8Igs1c/EXv8X8OHzvyRuBC+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z7Y79DO+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a55b3d57277so506661166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714385827; x=1714990627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fofl3LzEvE8q/ASOSi96klFOouBEcTKVbuEZewBxf/8=;
        b=z7Y79DO+oh5o0bA0diC2rGDI9UbOED+mGSpD+wzokl/iUgYXUz5OipEDFoyuPExRPH
         +9jolccnltB+2VlIZWJz5HAZXkdgrwn23xlc8lgoMvhBXrdrJLaq1CxDZbCr4bf4zZed
         k2OYSCBwt3e9cqxXYDpPJIV29YXZFW0DyVCBoOyfOCRtIPq4Wb+41uz2dl2k3K3V08ys
         UW86waiBSi5Zemwk41Cj6NULideVkpzCxYu90oNGeoS0aOutktnQSJcWQq+c62emMwya
         NBHXcyHy6XQy7fA97fn/L8tFIligc3eg/UnYDMywj17nXdRCkKzZCWqST4NCL9LKqkvY
         nKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385827; x=1714990627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fofl3LzEvE8q/ASOSi96klFOouBEcTKVbuEZewBxf/8=;
        b=fzMFa7L7gLpeeVSGLMaihZRlMZ/nBDATDbepgHBq87XnRXXBsWjR9K9SL2rUMPgoFL
         wnRJfD6GvNX92BtJHjIdrcbPUrdHuCowBAfVcBWYLedB+OnkinbwaLdOlpr1eCsoHRiU
         VS22BeMooK9gvPISVL0sN0b1wfIyDI2vh+S65LplgNzsa1s0Mdlm39beDtcDAFQsuttk
         P+Bn7Ey2QXmscXewWst36LJ9PSunFXE2Fadjf27CgNN4jE2tirkvFkuT4rlHC9i6yC5H
         e3PtSBV0mKlBHVwkSqOxCG3X85eQdz4IdVtdkRdHBAD80+K5vJDX5gqWRejxciZ8Z9E7
         4Y/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUz3hYKhfBhm0Duein3/cDpGnIAGZD8IxOSheJDM8/Symin3H2vzwb9ufR2QOhzPcS2gn4uci5llL39RCqEyQl/ZmERGe2FUDQBEbbn
X-Gm-Message-State: AOJu0Yxt+NQvRooxNslhe+NapTR13U65KklxxCpna69ObKCHOIVD8+E+
	sXEJNodG0XmKdPz1SmAUsI2zr9zEnaRHDPxuKaD+51N14kwox0cPo7RC8OcQfks=
X-Google-Smtp-Source: AGHT+IEWlTg//1dz7XVrhN72Eg50eh0II6OHEcXZIT+FuzHD7l60wumCOVr3LGegnHG3pS4I72RQeA==
X-Received: by 2002:a17:906:787:b0:a55:a895:46ae with SMTP id l7-20020a170906078700b00a55a89546aemr6183479ejc.63.1714385827285;
        Mon, 29 Apr 2024 03:17:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170907360200b00a55a8ec5879sm10141651ejc.116.2024.04.29.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:17:07 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:17:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Message-ID: <df5830dd-d822-4c11-9cce-3775dff0113b@moroto.mountain>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <20240429013154.368118-2-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429013154.368118-2-lizhijian@fujitsu.com>

On Mon, Apr 29, 2024 at 09:31:54AM +0800, Li Zhijian wrote:
> >         mutex_lock(&cxlrd->range_lock);
> >         region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> >                                        match_region_by_range);
> >         if (!region_dev)
> >                 cxlr = construct_region(cxlrd, cxled);
> >         else
> >                 cxlr = to_cxl_region(region_dev);
> >         mutex_unlock(&cxlrd->range_lock);
> >
> >         rc = PTR_ERR_OR_ZERO(cxlr);
> >         if (rc)
> >                 goto out;
> >
> >         if (!region_dev)
> >                 region_dev = &cxlr->dev;
> 
> When to_cxl_region(region_dev) fails,
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
to_cxl_region() will return NULL if "region_dev" is not a region device.

  2215  static struct cxl_region *to_cxl_region(struct device *dev)
  2216  {
  2217          if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
  2218                            "not a cxl_region device\n"))
  2219                  return NULL;
  2220  
  2221          return container_of(dev, struct cxl_region, dev);
  2222  }

It won't fail.

If it does fail, we're already in bad shape and it's not worth worrying
about resource leaks at that point.

regards,
dan carpenter



