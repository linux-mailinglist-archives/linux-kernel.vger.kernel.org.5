Return-Path: <linux-kernel+bounces-162020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77EC8B54C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE271C21875
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783E02C68F;
	Mon, 29 Apr 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlCTKDyQ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658C2837E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385460; cv=none; b=GpPeIxtH4/k1laK/d20OAe3uPgtt2UCIxwItrc8NcU2gtOclxGhxj8ZHsotNGTIyrly4BQNr8IaPgx9f94CNjNJlAO+ytEjNswFrAQz6CjV8UVfMhyDHAaoxvQd4Kwp/yhzBs2XHG+RYX9TRs7tpaABQYjriiqwlbt9xtw6ew0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385460; c=relaxed/simple;
	bh=IB3WDRseCNNFk+ZLUA4mJOTocyqDl/4oNjU+KW5uDdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDxCBDNTdwyMiN5OB8ouN0U+ZM/2FGl2jUKm95tKWqgmi81x5dcf9iVdoBBSTRFYUVI7GoCUUTj8WfpZ2JjqgfBWolP3jILbWINlpasJwaEirRIc/ds6cvWO6Xe/63H5dDI+eFMQM1Lm2ftm7MINmo4IkT2C4pkfUMSYteGSZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RlCTKDyQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51bafbe7509so5996521e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714385457; x=1714990257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CR0pHPWzPBFaYe8dJRUx8ICX7XCqG6Lpiz571IjYo0=;
        b=RlCTKDyQqcpdysvi/YfxGc1bxyTZQVQoNNIVPRfkcpI+VjhOQoGZgRQ5oh8rXiitn6
         CyY8IG7iC00xXRMLQCS4ySifLxmZsnijFwitg9h5TWgu2DJJhTWp5rlL9yVuR8ZRp6iY
         StPVeRH6LbXPjzqlhH5sFOblnWHNGTLcJvdpmWKHC8pm8bD2lWHaSJEJHZEUFC/MN9DM
         O0M1ZafkX+DnPDzZBgctuC47xYZapw3To9imGqaweuLl54jDG8hc8/2UWKbj9BraKxGg
         thD/h1PlEGPK6nVx3rkYjtI790K+4I1FE5BkGNC9HvBI/LvOeriyileKPlWaBL8d0reY
         M0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385457; x=1714990257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CR0pHPWzPBFaYe8dJRUx8ICX7XCqG6Lpiz571IjYo0=;
        b=bt/JMy+88i7gkLgNSPDrDnuswYVnqNWsM/Bd66rxV6Q6izWo02PVJRw/RuyknYM2dw
         0JL9F7aTt1G4X+rdogm0fMSLP/v9hUFXRVKqS1YFeGL4qiOtaI5xLRh10Sw9o7EKvB+R
         IUyYw2kRa8uuCfILdP/WuhPr2l9bbuXAWWfHG8uY+8XvzYSuVcZYeVqZZDzV4sP0W18d
         eL1/yVNMU4BON4bdDnv0JC38+kW2JEx6xUqqjYQX4X7U//uuMz1jYhClupTbYue0Vzoa
         x8G6/pk5IeICOxz68B3fsbwr0YxHumXl4p+HRPLsDeyvElfNO3GV8N5tO79QV9SkxCwc
         RVgg==
X-Forwarded-Encrypted: i=1; AJvYcCX3ouFogbPm8gOTNdTcTjHGQG4XZAI9awcUUp3zSL1TKfCOwc6etom6E+rPfQd3SKqkpkDXj8XUIT8VND8JF04cXND21CVKw6KfCcks
X-Gm-Message-State: AOJu0Yy8zjuuHEddNZNrLJfwWnNMWWcPIyclRjTUPpd+mseN36xfPX6u
	BjMwwXy0tSrDcyEHHzB6VpDhA/wfXshF7NVWUotw5jzkL3EbP5ptuRQC1FPWMno=
X-Google-Smtp-Source: AGHT+IEfFTRJBtx+AD3BYhZiiOh4/CgFQB8s2EzkQ3cx72Ldl4o7nIvpLbncl1nhIUX9SjbrtIZiLQ==
X-Received: by 2002:a05:6512:2346:b0:51d:9808:6645 with SMTP id p6-20020a056512234600b0051d98086645mr2585735lfu.50.1714385456458;
        Mon, 29 Apr 2024 03:10:56 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id x21-20020a170906299500b00a5875dd74c2sm7883217eje.131.2024.04.29.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:10:56 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:10:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Message-ID: <18a295a2-b734-45dd-9c95-660a9e1f58e4@moroto.mountain>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429013154.368118-1-lizhijian@fujitsu.com>

On Mon, Apr 29, 2024 at 09:31:53AM +0800, Li Zhijian wrote:
> construct_region() could return a PTR_ERR() which cannot be derefernced.
> Moving the dereference behind the error checking to make sure the
> pointer is valid.
> 

No, this patch is unnecessary.

drivers/cxl/core/region.c
  3080          /*
  3081           * Ensure that if multiple threads race to construct_region() for @hpa
  3082           * one does the construction and the others add to that.
  3083           */
  3084          mutex_lock(&cxlrd->range_lock);
  3085          region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
  3086                                         match_region_by_range);
  3087          if (!region_dev) {
  3088                  cxlr = construct_region(cxlrd, cxled);
  3089                  region_dev = &cxlr->dev;
                                     ^^^^^^^^^^^
This is not a dereference, it's just pointer math.  In in this case it's
the same as saying:

		region_dev = (void *)cxlr;

  3090          } else
  3091                  cxlr = to_cxl_region(region_dev);
  3092          mutex_unlock(&cxlrd->range_lock);
  3093  
  3094          rc = PTR_ERR_OR_ZERO(cxlr);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
This check means that if cxlr is an error pointer then we will clean up
and return an error.

regards,
dan carpenter

  3095          if (rc)
  3096                  goto out;
  3097  
  3098          attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
  3099  
  3100          down_read(&cxl_region_rwsem);
  3101          p = &cxlr->params;
  3102          attach = p->state == CXL_CONFIG_COMMIT;
  3103          up_read(&cxl_region_rwsem);
  3104  
  3105          if (attach) {
  3106                  /*
  3107                   * If device_attach() fails the range may still be active via
  3108                   * the platform-firmware memory map, otherwise the driver for
  3109                   * regions is local to this file, so driver matching can't fail.
  3110                   */
  3111                  if (device_attach(&cxlr->dev) < 0)
  3112                          dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
  3113                                  p->res);
  3114          }
  3115  
  3116          put_device(region_dev);
  3117  out:
  3118          put_device(cxlrd_dev);
  3119          return rc;
  3120  }



