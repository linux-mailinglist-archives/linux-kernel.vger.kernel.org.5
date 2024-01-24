Return-Path: <linux-kernel+bounces-37425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD883AFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AD8283BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B89129A84;
	Wed, 24 Jan 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDV3VfTQ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD355129A66
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117113; cv=none; b=MO0yKgajtc0NmOAuIwVHDi/OyUAL3DtmdGk724flFxaogCV29NWq4OjKT3soNPfCqoqDRuFy7R1v6BqSwihEMsfVfxiwbBFY65R7SVxiHjfiFTT3WWER4yDUP79/lMRU3PK0MjMOdVfbbBM5m4IrlfMM3SU8ThNphwc2wngMxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117113; c=relaxed/simple;
	bh=fQP8/M1QomdvhevshrbbyC+G3774Cm3toGMmsbZ5S08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX/QidxeGXY49ZVMb1eJU6Te/p8d28iAo1E+Vk+z19rRggLN1oq/4evagyzO7d1QB9kyCwEa6qNcgWqpep+S/wK1JzDwI1PvuKjllAUHv2xIJVUMVjza0o+TVzyKRGJJ17VzUpTauT7d4H+d479DytOX5tYCn4OdrBNnPOi15F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tDV3VfTQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e775695c6so55775435e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706117110; x=1706721910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQP8/M1QomdvhevshrbbyC+G3774Cm3toGMmsbZ5S08=;
        b=tDV3VfTQGdHxj52YrYBAslccY5mFWvnpoB4Q7nePNtX0TVq/1W/oVVM//AoHQSjhnS
         bEo/ja2Via7LQEVi3qjTrJXHY3sqooJr8JodFFMBxnWchgtZpSeU7J5Y+Q4f/LBxlPNS
         Slf96OL70rJcwk2oP8O4k6SlKfv1LWIRSYwWCdeAZ7TCTbIvg8xJOwjcfOk0Q7rFTKsD
         zpZrs1zcSVyDG18K4IIF9X/ajLuwt6/mDfu+AzWPbSXswMILMdzH46bs+U2jdVWQo8i2
         xc1HVKgrQhtSV1AYpeFzCvXqHROoPMRnniBAVIQtYvr3yCxzFPZoZ5LsnzmJJwAFx4Hx
         tGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117110; x=1706721910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQP8/M1QomdvhevshrbbyC+G3774Cm3toGMmsbZ5S08=;
        b=O6EQgBkSRqHYokRvXPd33nW+TP4r1yoIuUzm4NKqyc0kBGtNeNOBHgNm7I7JnuzFXq
         d9MeXR3M5iXxdU5MUqXcY0wj/DtPkonqlODtueYTrIVzSTmYJvkv3p/qe8JKR91n+BCI
         jc1TSlY1JnXEI1cppo+n2DbOSV8jCnlrZMC7HBnSg3vCGKNiM2VnRmE+piKDRnEhh2K7
         BpOIPBHbysBr34wcx70u9PN8re3OQGTVBRCiMDWleKjeYzjZr+H+VL3qAqlMGqmJENyh
         Ml8ovS8L+jBh4mfn4Jir+O4z7QteekzQyfSLIcJ2FfsBF4pXsDH6jqU394ViRKGoQ2K4
         nvBA==
X-Gm-Message-State: AOJu0YypSkJ71zyd/bEXrFcoC/hM73BfRPpe8qf1ySKVL9jvqFACsKgb
	pZ/nhVnWl+WzUzPbxayWrNbe+A3hQz1FpdxMTSb67ofD+HNp0mru0nc9aRs8BiQSl0HKoyat1nF
	okyA=
X-Google-Smtp-Source: AGHT+IHtZmUsImHUN6vx4IajyMpk1NjS/10baW8IunEC4zx4kdLeWpbSforzB18JvfYxa35SxlP9Hw==
X-Received: by 2002:a05:600c:470a:b0:40e:7516:2c7b with SMTP id v10-20020a05600c470a00b0040e75162c7bmr1904703wmo.38.1706117109977;
        Wed, 24 Jan 2024 09:25:09 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05600c524600b0040d53588d94sm285281wmb.46.2024.01.24.09.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:25:09 -0800 (PST)
Date: Wed, 24 Jan 2024 17:25:07 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 4/4] backlight: hx8357: Utilise temporary variable for
 struct device
Message-ID: <20240124172507.GA16024@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114152759.1040563-5-andriy.shevchenko@linux.intel.com>

On Sun, Jan 14, 2024 at 05:25:11PM +0200, Andy Shevchenko wrote:
> We have a temporary variable to keep pointer to struct device.
> Utilise it inside the ->probe() implementation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

