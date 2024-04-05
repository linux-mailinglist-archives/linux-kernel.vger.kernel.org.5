Return-Path: <linux-kernel+bounces-133361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1052289A2D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420571C2275A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C6E171061;
	Fri,  5 Apr 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhtYn1HP"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4817108E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335621; cv=none; b=Ctqnb1lL1qC/3Mx3WmoAaMIUVRlztxgZ3+lX3AIF1+IXgAaAZ7FrEIr+peVUX8VePX0Uw6Li8AE5JF3w8Ig/cTKFCEFDJuhzmpCC38xtxF606fiiVJC2FFUzNoCqFbCYALRIfxeY4qz8nLPoUX8H0W/nwmtk8nbtg8w1CUlkn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335621; c=relaxed/simple;
	bh=KsPF6po0f631j8NvbzhzHLnGhKfPZwZJTUHih5WzFXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/0pqGzvcDPgtxQwxtkvubEG3rLvMYVGhlHbkjCyhXLYAzPUwGxyaQvT5uWB30yE0Oa8v2XSbZosldC9md8fx653P0ovnslNwVIkT3EFYvwWxkxKkCr8Iicpen4vA08orHKLLjKHc76joNQb/jnJan8CzB5IyFkLQzJ0yh6rmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HhtYn1HP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so1997653e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712335618; x=1712940418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjZDXXK2zwXeuxbCY+k8mNYZHEoQ+bEUvt9cCenwnEg=;
        b=HhtYn1HPAxnw8gcUfekGwloyZyzjCIMJb92tIA+8wOI5XGreRXiXhhQqcQ52YrtjBB
         LLGgJJLTUNhxIPAplxSPFLvSipb89u+Wg8xPXNDQLfkUGMYIgifqw8dPNkoXmJViJmd4
         f30Wd9YRMqD0b0oKoihhtl1C8M3icfzggfHQHXn8TTxq6mHmURyn/+DyhkPmsSVV8D8I
         OozbhYDhOzgdFELNdFBGSICGtTEA9nk+5l12ov07QlEg1qjQToTzM6j7nJNj4UNFzDas
         T21qkmnB2OFsjX6fcFsrEqvG00q7IAEqJ6Gm3zY38bLjYaiU0BR/58YNHTGlUbuHj+73
         YQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335618; x=1712940418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjZDXXK2zwXeuxbCY+k8mNYZHEoQ+bEUvt9cCenwnEg=;
        b=QtbtUS+whRH2+o4JDuKWUbuZU7672qZt5USZVu5W1AJoLhONXfSDmpBEFf9ye6I3Jl
         62cZDEMF9TBBPTpnz4+ay983F7kUXsciK9o0lr8YYpvU/X5jkUrEZEtxZkybne98jfnD
         aPo00X74bCpd8wxrr3sxgErOUZ+qiDZ5FD2NjWgUHIA27frmqVzizWTDPf7Jc8cRWGHw
         UqYqjVTQpTsTJZ7ASAU1R/pWjB2SQTCLT8bh42jJWXomKh1EVVQJB5B4kAmnUFCrH0jL
         ArDFQUNlE7hRicyKI3ZFCJAm27kduCZciytvALAaASqLdybYXyqiyWMNjfi/YrGInA8A
         X0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV99VcfWCi4sX5tOAvmk6wdBmr/8sFqeoUHQWElI1qAv9YR88T/yGq5a+T28oKPJ+sxPEK5CxOEJ/FhKbdFg94uuAWgGJUqnXmuRyor
X-Gm-Message-State: AOJu0Yx19SbkgPkj/YqzZcMmEjS5vN+XPGQpBN3QSlHziuG4VJCQqTw6
	VLrdf3gAZseeKbgytBBWt1iAK0q0gjAisqolaZnvgdcWC85AvnY9cyz2OzchaXI1LRfXAJ8F1/b
	D
X-Google-Smtp-Source: AGHT+IFufXZNeav0WseEY6nRjlxRZCZWJPm4KsDfy/VrMhHziMpaWAR1CqPIEOMNojFKUGoxkwK9tw==
X-Received: by 2002:a05:6512:224d:b0:515:ab92:6a82 with SMTP id i13-20020a056512224d00b00515ab926a82mr1791982lfu.17.1712335618108;
        Fri, 05 Apr 2024 09:46:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id r14-20020ac25f8e000000b00515c8ff6f52sm231480lfe.229.2024.04.05.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:46:57 -0700 (PDT)
Date: Fri, 5 Apr 2024 19:46:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Helen Koike <helen.koike@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: ci: fix the xfails for apq8016
Message-ID: <oakh6gccuho2zq6aaaydq4hucz2ueuayo6qpq73uaw7ljt4gu7@haz3kdjjy7hp>
References: <20240401204859.24223-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401204859.24223-1-quic_abhinavk@quicinc.com>

On Mon, Apr 01, 2024 at 01:48:58PM -0700, Abhinav Kumar wrote:
> After IGT migrating to dynamic sub-tests, the pipe prefixes
> in the expected fails list are incorrect. Lets drop those
> to accurately match the expected fails.
> 
> In addition, update the xfails list to match the current passing
> list. This should have ideally failed in the CI run because some
> tests were marked as fail even though they passed but due to the
> mismatch in test names, the matching didn't correctly work and was
> resulting in those failures not being seen.
> 
> Here is the passing pipeline for apq8016 with this change:
> 
> https://gitlab.freedesktop.org/drm/msm/-/jobs/57050562
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

