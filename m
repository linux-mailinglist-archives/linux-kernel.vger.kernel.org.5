Return-Path: <linux-kernel+bounces-153931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40788AD50A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E5F284885
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710F15534E;
	Mon, 22 Apr 2024 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdJ0YiW2"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74576155345
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815065; cv=none; b=A3H3pLjiwUymGykhx/6UFmra+vqEXOGzcMyF+H6l80zJW7Lf0idSGtUhL7beWKcmJiFoR5gb18T1eSnw94yt/mbUTI98rNvYCWjk1RGvU+n3qp8rgURGaB0kifE55VLtEPE/bwN06D5j9YindAXsB9FCjfDehovuPSARpx8WeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815065; c=relaxed/simple;
	bh=teUOH+Iz6NWDZL8ij++AYo7mAAoW9rkXT9ZCcHSMccA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daAmyEyYHl5Dz67TN703ELrJT6YH+bfwRk7Hyjlff4b+na83idGlRxa+PYW7WQHC6LLaFUKFeEOvsfLgF7olewgdbaUR8uNEpCKZ2J+3Cn4zEdvSqsz/xD6oqOR1VvxEhRmQwfJOKWUYcr26yrWviY+fwamnY4lHwT1kORRa8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tdJ0YiW2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so64964091fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713815062; x=1714419862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNSqhnViCny5sGqp7Qjs50p3XAx1lbvYw/hoV+0zczM=;
        b=tdJ0YiW2jWV6Mq6f3ZFlutq1o/NxdmwFFDUfbSY7aFHcJ/movQY+tarSUpIhYUlboE
         tUPhSIHDCgnxRBlmtkTS3hsCxqi/nxeLLciEOKT71Ten9paF6ml5F64F59kJV0pUph1A
         SlCnUvf25MEI5mM+9I/pgq0j8A6Cc6TPfnIoYEpZjdkj9qw7stVXoKCSzg/IjcENNSY0
         ml3o/h8NKvjMdKwrmPTtszXnPjh0O3pdDGYo2axwUXr/lqoDAlGRr8DmLDrc3zeWP9ds
         krzm0hLVXA86ZIs23FUePjGJ6E+UoMaCoLv+GrJywSCghEafPzGhmSQZGe3xPO7ByXzr
         FXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815062; x=1714419862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNSqhnViCny5sGqp7Qjs50p3XAx1lbvYw/hoV+0zczM=;
        b=GeFIK3xqSuaKnV5qJK4Wrb6e0t9cdzsBDsV9N+xBAjoIHcvjdM9IHMVI7SbnkgKVTs
         tSwphJ+lt247sQdiZTwa/6k0X6BllcSfimpm1f7YdBc6KYwRvM2QjkuPcxL8p9NbU2kL
         /9/UOg614OZwSjv9WH1ND0HcoXAayD/N6ftszzUNO+HxtcmM0UZx2waae99NgnRhBu/y
         KCYSi/RtdcO/RJPOkyapm6VTUvFWOCrvMCZArko0Wgo+hf8xaUN42lI5vr6ir7XBhCWg
         tVMVRcO3/d81ZYtK4V74S3jyvGleMpalg/sHCIjfBt7Er1z3gjdrr4rBR68segHbnGod
         KdFw==
X-Forwarded-Encrypted: i=1; AJvYcCXB1gthP8uQqNKeZqW+hucBoh5xvBSHsSWYbk9Y++ThW7hk1KHrS60bTKjSWyaCBFTAu2QrLSYFN9RVFlP59Kk7d4SNui8TxgTwuzPF
X-Gm-Message-State: AOJu0Yz3ZGXOLI53yW1uLK6tqj9JPoIUY4TH2dXNn0ZYl8ozEPKANjsa
	+FNiYhMhGs1D1tC8CkVu5sm7UkU+RwhoB7EhxPm1ZcdoX5Vb6vk4Wwp0Y8S6HpM=
X-Google-Smtp-Source: AGHT+IFB4vlO61dRgJLfBsF513ju46qQFEo5RGhENHLFJUifWdD3Ld8YIEwoMTEdpoaSF4uOjBiDJA==
X-Received: by 2002:a05:651c:2102:b0:2dc:f188:a073 with SMTP id a2-20020a05651c210200b002dcf188a073mr7128155ljq.35.1713815061649;
        Mon, 22 Apr 2024 12:44:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id l3-20020a2e9083000000b002da6fb7ce36sm1533716ljg.135.2024.04.22.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:44:21 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:44:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/msm: don't clean up priv->kms prematurely
Message-ID: <pirzyu6ki7hfrax2uo3qlg7fdzlvzpg7vfgfqawogtybdd6e3c@zvgh3n4o67zi>
References: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
 <20240420-mdp4-fixes-v1-1-96a70f64fa85@linaro.org>
 <67fbd629-3e80-b706-83a3-7baff3efd6c1@quicinc.com>
 <n7eet54g72usmuh4hdz6yce3i4ieweu4orgd7gewu7y53ejucc@dzmq2a2wdxkc>
 <7daeeaba-a33d-bf05-1371-d9b5fa0bf0a5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7daeeaba-a33d-bf05-1371-d9b5fa0bf0a5@quicinc.com>

On Mon, Apr 22, 2024 at 10:23:18AM -0700, Abhinav Kumar wrote:
> 
> 
> On 4/21/2024 3:35 PM, Dmitry Baryshkov wrote:
> > On Sat, Apr 20, 2024 at 04:02:00PM -0700, Abhinav Kumar wrote:
> > > 
> > > 
> > > On 4/19/2024 7:33 PM, Dmitry Baryshkov wrote:
> > > > MSM display drivers provide kms structure allocated during probe().
> > > > Don't clean up priv->kms field in case of an error. Otherwise probe
> > > > functions might fail after KMS probe deferral.
> > > > 
> > > 
> > > So just to understand this more, this will happen when master component
> > > probe (dpu) succeeded but other sub-component probe (dsi) deferred?
> > > 
> > > Because if master component probe itself deferred it will allocate priv->kms
> > > again isnt it and we will not even hit here.
> > 
> > Master probing succeeds (so priv->kms is set), then kms_init fails at
> > runtime, during binding of the master device. This results in probe
> > deferral from the last component's component_add() function and reprobe
> > attempt when possible (once the next device is added or probed). However
> > as priv->kms is NULL, probe crashes.
> > 
> > > 
> > > > Fixes: a2ab5d5bb6b1 ("drm/msm: allow passing struct msm_kms to msm_drv_probe()")
> 
> Actually, Is this Fixes tag correct?
> 
> OR is this one better
> 
> Fixes: 506efcba3129 ("drm/msm: carve out KMS code from msm_drv.c")

No. The issue existed even before the carve-out.

> 
> 
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >    drivers/gpu/drm/msm/msm_kms.c | 1 -
> > > >    1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> > > > index af6a6fcb1173..6749f0fbca96 100644
> > > > --- a/drivers/gpu/drm/msm/msm_kms.c
> > > > +++ b/drivers/gpu/drm/msm/msm_kms.c
> > > > @@ -244,7 +244,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
> > > >    	ret = priv->kms_init(ddev);
> > > >    	if (ret) {
> > > >    		DRM_DEV_ERROR(dev, "failed to load kms\n");
> > > > -		priv->kms = NULL;
> > > >    		return ret;
> > > >    	}
> > > > 
> > 

-- 
With best wishes
Dmitry

