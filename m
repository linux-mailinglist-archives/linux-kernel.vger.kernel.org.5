Return-Path: <linux-kernel+bounces-152646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EBE8AC1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFBA1C20991
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24526AF6;
	Sun, 21 Apr 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEFObCcY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E924437
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738909; cv=none; b=tv5p8m1AfEMHUFMzbfUxl353woLpGQ10CSIjvlhIjO0SQ5S4/JKfFzhLC1jAMkunxHSP/MY/NKvJuOXaGJLms9/JIb3Io8H/DIMio+8L44AhYqWikWU1zHjITbnUfouq7iMlK0Gk3Pz/7FwSq8SBR0ox1Bz9TNz45YeA9G46uiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738909; c=relaxed/simple;
	bh=qb9KZrNjv3KJHdQgXErZFHSs9C9IWBLPfq0Gihr0OCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhxV8K+L0sLNKgG+cBibq21U60nHome0sHjPtXQ36vB9G8pzdslJg2uc6EHu0NvwTBlcOI1LWavbYf/7djAZ5H7K7ywvLM6T4awPo7+Qz5ep+Py2b1H44j/EB59+kuOd5wxqMqMkYnr+EEEsE1ygpwc37EEHTWHpjxk3lo3D0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TEFObCcY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so1777292e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713738906; x=1714343706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bRTN9Ob4QM4MboZv5j+iipkeqQdN46sghn8IdzK36Q=;
        b=TEFObCcYL9Su6wcxZ8tldc685c1Js1oeKoPcD7oClmVfXLpmkNxfO6fnOivfC3g2DH
         DHvP1k5J2WqcSlyieHG+fKUQr/NQXIaf/QcBpgCePVBoCP8McA/1b2JgOjV1I04s8J/a
         XQrwPDqPwyp3qkfsy77aW4i0gC960c2kK/ASTeU3G0WQZewjENXnQw6XfPpqRCMLcx/+
         pZhXIIhsITRP65z64MPhTKpi6hTMoh1IDZ5qhN82SkF19WMN5V6JZmY2G9J4+v9GD+qm
         60AWdGS/5bWlQ5Dl2sc7XCjj9BY3DCfxR2JNxhuK7F0NbA6udPK5l+juuTCMcXT6VCKn
         EKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713738906; x=1714343706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bRTN9Ob4QM4MboZv5j+iipkeqQdN46sghn8IdzK36Q=;
        b=hoDQMHFHN09NIdO8N5MQDxYUfkUmPFnv2tyv6YeY2B7Da6q7W9jx87h+vhTLw5H3Lp
         mbZG1f6bsNKr3Adwp3ahLB+4ACr0p98Z7/AosbrfgU3Mdv8fWQFq0BCOicKt0F2Bg41p
         NN8AeRRgrF+DEIVbfVkZ+pEO8L3CJW/QewthiVzS+ZC+LbfBU6JXdRfXllaPhSZOr6q/
         I/ow8vtAGCtL0D0/ueeaU+xdqIziqatmyVgFo1U/MD+m12bElzrNPZU3szG6eazBqOWh
         9mGkJ9tvXTdUjhOeZHHCaxhKbmTL0G2Wlwc1dN3vtADS7x+cRidDSdSrZxThu5fWLV7V
         RnNg==
X-Forwarded-Encrypted: i=1; AJvYcCURVr6BogSBD8CyuTz+tYJI8LcH97ZGemi9kX2NOk1MAb7STnhd35lRDkC6VstVfvBDVtZQNBsrf5zQKnsxuWZ3eMM+6pmVRHlhNpp7
X-Gm-Message-State: AOJu0Yzpt0/3IpBEdisYmJ/QkZ+sXz0SI+zQ0ZMWi9uYhAbWEyTSusYM
	EumgIp/Eyqhzo64QGTHJNbc53ytzJpDNAXi3ljMgp61rAmQcqpnxHsuK8DE8Muw=
X-Google-Smtp-Source: AGHT+IHLjZAuG9ugDalv8mPVHpO3RxdThgs11PfJ94yvOVMbJYooEIDDJ73Y6EPItQfYa7v0M9uNww==
X-Received: by 2002:a05:6512:7a:b0:519:1eba:6381 with SMTP id i26-20020a056512007a00b005191eba6381mr4931611lfo.49.1713738905670;
        Sun, 21 Apr 2024 15:35:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id w17-20020a05651203d100b00515b62690a6sm1572911lfp.32.2024.04.21.15.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 15:35:05 -0700 (PDT)
Date: Mon, 22 Apr 2024 01:35:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/msm: don't clean up priv->kms prematurely
Message-ID: <n7eet54g72usmuh4hdz6yce3i4ieweu4orgd7gewu7y53ejucc@dzmq2a2wdxkc>
References: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
 <20240420-mdp4-fixes-v1-1-96a70f64fa85@linaro.org>
 <67fbd629-3e80-b706-83a3-7baff3efd6c1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fbd629-3e80-b706-83a3-7baff3efd6c1@quicinc.com>

On Sat, Apr 20, 2024 at 04:02:00PM -0700, Abhinav Kumar wrote:
> 
> 
> On 4/19/2024 7:33 PM, Dmitry Baryshkov wrote:
> > MSM display drivers provide kms structure allocated during probe().
> > Don't clean up priv->kms field in case of an error. Otherwise probe
> > functions might fail after KMS probe deferral.
> > 
> 
> So just to understand this more, this will happen when master component
> probe (dpu) succeeded but other sub-component probe (dsi) deferred?
> 
> Because if master component probe itself deferred it will allocate priv->kms
> again isnt it and we will not even hit here.

Master probing succeeds (so priv->kms is set), then kms_init fails at
runtime, during binding of the master device. This results in probe
deferral from the last component's component_add() function and reprobe
attempt when possible (once the next device is added or probed). However
as priv->kms is NULL, probe crashes.

> 
> > Fixes: a2ab5d5bb6b1 ("drm/msm: allow passing struct msm_kms to msm_drv_probe()")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/msm_kms.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> > index af6a6fcb1173..6749f0fbca96 100644
> > --- a/drivers/gpu/drm/msm/msm_kms.c
> > +++ b/drivers/gpu/drm/msm/msm_kms.c
> > @@ -244,7 +244,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
> >   	ret = priv->kms_init(ddev);
> >   	if (ret) {
> >   		DRM_DEV_ERROR(dev, "failed to load kms\n");
> > -		priv->kms = NULL;
> >   		return ret;
> >   	}
> > 

-- 
With best wishes
Dmitry

