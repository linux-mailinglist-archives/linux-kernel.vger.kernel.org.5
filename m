Return-Path: <linux-kernel+bounces-149327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336568A8FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6461E1C20EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133112F59A;
	Wed, 17 Apr 2024 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duWLWHNC"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0686158
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397468; cv=none; b=o2ce12Cv/0m/aGywCf6oPnP6juCZZqrfj3Yhi1IP0A/F/ulH+Iw8jK2RwVHn7jkUG6/z/uMeBcq6tcumThFRbUyOexGT1Vz45o6v4szg5KXV47F7CXGTOUKV1ZCayDYnh2ovpS2hlhjRJoTDdHjPf1akY+gCn1IrssfIZ4f+mFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397468; c=relaxed/simple;
	bh=TGvAHkA7J8vQWaG9HblmH7jzH4i/rzj9f66RDD2tQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/WzIJCES4EHQfowvoIm6Y4jLRvJtiRpqI5xD43ABzipUq2ba9lxJrwxlndBSPhCsgwMuE0lE5Kq+ubNWCPcprHehdBKaJI3RWmXpOqYChLKOiDNxrZeZ604QxeI2SpIoFQ9jqRmUzUTZVTtRygVBTyhGJ4aqLjw/V5PJ7zbJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duWLWHNC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518bad5f598so254818e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713397464; x=1714002264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgjvMPd11QKFNd88E1N26rp+tffDbeQ3uZCnSiUqKR0=;
        b=duWLWHNCYI8NjMNjdU0FQtWzeewwK1DiodA+kH4TvTaWIfcFOI+4m+P6xGWoXwyLRn
         OuarASleYXfexzgjqI2xCmuytHAh1F0rTVF5D6Lrn9gj3jm8jqpq1J/qSYhkWXFk6lxP
         MH5h7eQhOuL4gXIn6XVfGdRRCqFn2gAJnlxfNj4wStKMEKn4pGPnWBiuOg3CQP8YuTA+
         hNf7EoS7WDZmt/4nHfl+KSDkTux7JPAvSoRG31qTGsIkvHGotNNUbtj7WSaMMAIEnGRi
         oQXGEM0qpmznGXTR+joiNyYxo6z+hu38jwlGrRgRYubbmLA8mef6Wx4sft0ty64u3Xbi
         zRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713397464; x=1714002264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgjvMPd11QKFNd88E1N26rp+tffDbeQ3uZCnSiUqKR0=;
        b=ZDtdfCrXY6UXUyq7vfb84V86TwZMYEOqNPLTim6Nws/lyFgK3a95aBeMtfbgvDnexE
         pZTaa564GBIfuo/4b8BqSHojSKgdDOCPQuhtPUvFox5muB0mUnWn1wF6j1JTNny3JeD4
         S3Jy8tDz8IXlG72GZE9J/gT7NuZofvVRi72Xz0PGah2+nY03LBpJheENt9fR1sJducks
         a3abrqm3OKUzpVUJXwJqEq9AOuWAa87nqAOyEKakCv8yv3gGcRZpuvRRyNJGoPOO3ZHa
         5eM2bNKudpnwSb1hZSJ8xlUOlik1p3F1RgBZEWdTnBfqu9WGYpPaCgw+OFfFNC3ax+S8
         FDOA==
X-Forwarded-Encrypted: i=1; AJvYcCW0ygOsIIVpI5aVkrEofgSm8RhGjq3yNwwFGwAOnAqTF3IB6G8peTDTdF/VPYEscE/cj8qy6JRl+0CxfonterGbmgjA3nCjcdhPZ7AP
X-Gm-Message-State: AOJu0YxWw2HV5zCyJhjrnsPjWHaLrq09t3rfRQKGHgmmDPsTuViVpXq0
	BZHDI5lGEmIoZVfcWshLas/LS0flVNom4G0zaNTaxiJSu+BF75fa2V7ZoX9liR0=
X-Google-Smtp-Source: AGHT+IE8QqXZo1zRChGmPJCaEjk6MKC6Yazzz1JhVm+k0MzRJJYbY0hPM0PvHSQBF3FoHVjciaXnXw==
X-Received: by 2002:ac2:5395:0:b0:518:9da1:7afd with SMTP id g21-20020ac25395000000b005189da17afdmr386771lfh.4.1713397464535;
        Wed, 17 Apr 2024 16:44:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id z5-20020ac25de5000000b005192a02c638sm36366lfq.132.2024.04.17.16.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:44:24 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:44:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 5/7] drm/msm/adreno: Define A530 speed bins explicitly
Message-ID: <4m53lev4flu5x7tmw3ygmyvfx6ls5zzmadrzuncbjcnvadoays@b3es63of6ujs>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-5-c84f820b7e5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-topic-smem_speedbin-v2-5-c84f820b7e5b@linaro.org>

On Wed, Apr 17, 2024 at 10:02:57PM +0200, Konrad Dybcio wrote:
> In preparation for commonizing the speedbin handling code.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

