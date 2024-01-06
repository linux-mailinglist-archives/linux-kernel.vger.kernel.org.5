Return-Path: <linux-kernel+bounces-18436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0B825D69
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D044B22F78
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E803C0E;
	Sat,  6 Jan 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRJXwrrv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFB33E7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so128946276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 16:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704501548; x=1705106348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CWItgsviLevELUTQOy8l4EFaye3LXQAVmYfKWfZE4dg=;
        b=cRJXwrrvzfoQSIVoDoO9eaWRXf5v3av1Lonxx9Koywhr65fO9CHKjURRDUyxqOAWk0
         F2NeJdeHmMbFblx5f1MK3/rWgojPts/7KwWvtkxg92cly2O+Juf7aVHKVXSjO0y3NltH
         odTNnt67s6BX5+zikAQ/+KQ9Yg755I1BSQhBMDE/0eYytxWvvWUTrEWa3NVZbreRdAlY
         3twhmuYHyjB18LTCkdtrZa69x32oN4UvWYRbR63IuRXPq4X/rIFlzMhHYTrq/p9Y3VaW
         TLjgASPu2mNSw22QNIa1L48wQfqZt+2h4DD5NA1FcpgrotX4zia5OlkfGOVMaa4ObnRT
         Q5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704501548; x=1705106348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWItgsviLevELUTQOy8l4EFaye3LXQAVmYfKWfZE4dg=;
        b=Xiu8ohfdAby+y7nY9ZlIVQ5V4K1+BLg3mjDGRW4nC69AoK3P6bnBZqy2KuUDiMglqJ
         IyTFFmAZ0TriNBZCWVcILcLc3aV6orxuLjcIgB2nvO8vh10uHWDvuiyw1cBH9nmgE2WU
         DH6qfCjoDkd5oCkB6eWNFuTqUtWcnm+Z1i0V9SQ50ZEmmATAjh7YmRUYKWaALxL7fEdh
         I/5gsrfFGSvh36QxewFBFlg83Ay5Za/XwkJTShIEP98CcbCNlBHXMZ3ssKtW4VXiZDMA
         ZAodhIBaHoLR52M+utoey5ht2PE5YtunN3l9gPRze4GCM+7t7tJq+clmykppOBw5+XR8
         1t/A==
X-Gm-Message-State: AOJu0Yx2r9uYUtMzYinhc8tO2VDePnlkX+oBPQ26tk2khWlphV+8FR6r
	OgjmIZRbGU7fOnmfuiEUhQ6EmLoK/31wRdgqIs0VFJniUGUvdQ==
X-Google-Smtp-Source: AGHT+IGnvK2SJ9w6gTmUsRLVRNS3RTVaJ8/Pp4IUrvSHuf9v1HiVqYLlHIA28KAi30M1XBd80naFcN+Tklt5i2+a/aU=
X-Received: by 2002:a25:f624:0:b0:dbe:3500:a42b with SMTP id
 t36-20020a25f624000000b00dbe3500a42bmr135029ybd.42.1704501548600; Fri, 05 Jan
 2024 16:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
 <20240106-fd-migrate-mdp5-v3-3-3d2750378063@linaro.org> <c8d6769b-eb28-337c-fa55-4dae86611da5@quicinc.com>
In-Reply-To: <c8d6769b-eb28-337c-fa55-4dae86611da5@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 6 Jan 2024 02:38:57 +0200
Message-ID: <CAA8EJpoF3uKobGzjHbLMKYvcQbdqYzur7Mn1cNDPyc+wiiZ+SQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/msm: add a kernel param to select between MDP5
 and DPU drivers
To: Carl Vanderlip <quic_carlv@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jan 2024 at 02:04, Carl Vanderlip <quic_carlv@quicinc.com> wrote:
>
>
> On 1/5/2024 3:34 PM, Dmitry Baryshkov wrote:
> > For some of the platforms (e.g. SDM660, SDM630, MSM8996, etc.) it is
> > possible to support this platform via the DPU driver (e.g. to provide
> > support for DP, multirect, etc). Add a modparam to be able to switch
> > between these two drivers.
> >
> > All platforms supported by both drivers are by default handled by the
> > MDP5 driver. To let them be handled by the DPU driver pass the
> > `msm.prefer_mdp5=false` kernel param.
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  3 +++
> >   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  3 +++
> >   drivers/gpu/drm/msm/msm_drv.c            | 31 +++++++++++++++++++++++++++++++
> >   drivers/gpu/drm/msm/msm_drv.h            |  1 +
> >   4 files changed, 38 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > index aa9e0ad33ebb..8f11a98491a1 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > @@ -1276,6 +1276,9 @@ static int dpu_dev_probe(struct platform_device *pdev)
> >       int irq;
> >       int ret = 0;
> >
> > +     if (!msm_disp_drv_should_bind(&pdev->dev, true))
> > +             return -ENODEV;
> > +
> >       dpu_kms = devm_kzalloc(dev, sizeof(*dpu_kms), GFP_KERNEL);
> >       if (!dpu_kms)
> >               return -ENOMEM;
> > diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> > index 0827634664ae..43d05851c54d 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> > @@ -866,6 +866,9 @@ static int mdp5_dev_probe(struct platform_device *pdev)
> >
> >       DBG("");
> >
> > +     if (!msm_disp_drv_should_bind(&pdev->dev, false))
> > +             return -ENODEV;
> > +
> >       mdp5_kms = devm_kzalloc(&pdev->dev, sizeof(*mdp5_kms), GFP_KERNEL);
> >       if (!mdp5_kms)
> >               return -ENOMEM;
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index 50b65ffc24b1..ef57586fbeca 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -969,6 +969,37 @@ static int add_components_mdp(struct device *master_dev,
> >       return 0;
> >   }
> >
> > +#if !IS_REACHABLE(CONFIG_DRM_MSM_MDP5) || !IS_REACHABLE(CONFIG_DRM_MSM_DPU)
> > +bool msm_disp_drv_should_bind(struct device *dev, bool mdp5_driver)
>
> s/mdp5_driver/dpu_driver/

Well, ignored_driver, but your suggestion is better.

>
> > +{
> > +     /* If just a single driver is enabled, use it no matter what */
> > +     return true;
> > +}
>
> This will cause both MDP/DPU probes to return -ENODEV, rather than
> select the enabled one.

No. The code (e.g. for DPU) is:

       if (!msm_disp_drv_should_bind(&pdev->dev, true))
                return -ENODEV;

So the driver returns -ENODEV if msm_disp_drv_should_bind() returns
false. Which is logical from the function name point of view.

>
> > +#else
> > +
> > +static bool prefer_mdp5 = true;
> > +MODULE_PARM_DESC(prefer_mdp5, "Select whether MDP5 or DPU driver should be preferred");
> > +module_param(prefer_mdp5, bool, 0444);
> > +
> > +/* list all platforms supported by both mdp5 and dpu drivers */
> > +static const char *const msm_mdp5_dpu_migration[] = {
> > +     NULL,
> > +};
> > +
> > +bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver)
> > +{
> > +     /* If it is not an MDP5 device, do not try MDP5 driver */
> > +     if (!of_device_is_compatible(dev->of_node, "qcom,mdp5"))
> > +             return dpu_driver;
> > +
> > +     /* If it is not in the migration list, use MDP5 */
> > +     if (!of_device_compatible_match(dev->of_node, msm_mdp5_dpu_migration))
> > +             return !dpu_driver;
> > +
> > +     return prefer_mdp5 ? !dpu_driver : dpu_driver;
> > +}
> > +#endif
> > +
> >   /*
> >    * We don't know what's the best binding to link the gpu with the drm device.
> >    * Fow now, we just hunt for all the possible gpus that we support, and add them
> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> > index 01e783130054..762e13e2df74 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.h
> > +++ b/drivers/gpu/drm/msm/msm_drv.h
> > @@ -563,5 +563,6 @@ int msm_drv_probe(struct device *dev,
> >       struct msm_kms *kms);
> >   void msm_kms_shutdown(struct platform_device *pdev);
> >
> > +bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
> >
> >   #endif /* __MSM_DRV_H__ */
> >



-- 
With best wishes
Dmitry

