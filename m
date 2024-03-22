Return-Path: <linux-kernel+bounces-111650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F003886F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F06281B27
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD29495F0;
	Fri, 22 Mar 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vllKlS3/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78A487BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119042; cv=none; b=PgyKET1+OC3YOHHAdiO+91qKn/sZnJZ+AeCM3pLknm6ZE5PVzZuMFyaUbOZ6xNmD2kqJf0OqOq8dOZ2A7R+1ZQ/cJpOiulAEWE9SIc+4mRqfF+8pKGUUVGxqMpRdGmKF6eWmyqChTUanwTAMyZ6qAqngYTlp9o32jaLPsPVbNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119042; c=relaxed/simple;
	bh=JeKVlRNsd5JdTk2RGk+ZVjcfLwsCqMGanl0BnUS12TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJoidHZ8AjW9QS6nvSVXArvnqgjAo/wZpnd+xYRF/EjGCIZpEmn7DjchyaxU3meOpu/7c5qTWTxl8coHc3KYtoc2YFA8K/a4OYhgWvyTmZG56P4M5ynjfWDI3uEEbBvniTwXc8dmdMQkLNjtT1O6Ny1mvmR8evskHqCHE25b2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vllKlS3/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56be32b9775so961758a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711119039; x=1711723839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOjzipgBiJTcHiIGzKfcwrF5y6PFP6qN/2US1X8P970=;
        b=vllKlS3/328EZs/VD2+WyKzDcZQ/ZY+9RxQDam4Vjw9e4PNgwnxLmCDG8zeosnw/Yp
         5Q3hU3hC8KP36chFklf7dNXbnGIYXYhUIYDK+Raxg5NDGUKNXuZ7OtXMOKZ8X83cJdz3
         pF9BrMgdNhG9JtS57InCvYF2i3Ab+KGw0SCB8obzS2LpBksLwgamQDxAUJ2OCh8dwC2A
         JNKOITLshjAFGgU+oE58wy08rFaAt1u9Bf2Mmj6z/3SEgro2hz7lhB5/qtvPMCxxYkoj
         xTGxLhVo8wf4rWeUCVXI/4P9SWvHr2SUv0zdeFOwBMJDpTUfvkPSAPeosv/bbAl6OnU7
         +HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119039; x=1711723839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOjzipgBiJTcHiIGzKfcwrF5y6PFP6qN/2US1X8P970=;
        b=SiO2zFOYmfdrnypx7jNqxyCVae5vu4Mg03eBRnDtFBDXG1HV7dGTZiS/eg6RRoqEc7
         rEtAzG7EUfBcbY5EVOH8wpWyXcRaWza6l+AQ69qBQs0RyT0LWFh/1ZWAxjQwJ1QpOlpU
         VVmDCvhsxMwIgmyzzHIfr8daBa0iuOPWlfGLBCkQ2SS+83dx0vfuJeC7/rMXICZb06G0
         9TFQ3Gqgxk4QaXYoZ4ev3es5D0ojN3emSF64S9TUFeWG8ftwi7ABtLNBKJC2REDUlgPK
         tRBxDSAsWEzctCqk3a5uKQABwA6TlCP+fEEMH04911fsai0J/YQBpaNzpHcAGc+8Ovpe
         5ajQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9PI1TCpbOVj8jDWTkU6bT4w5ZYiXgUcqNI3A9hKKgmwdbxSvButFp5NawGBtIRTr2ZVjjsXDwLHVnAJSutG6GOefnkfierqgkFqvd
X-Gm-Message-State: AOJu0YybQVJwheanj2WwakGM1S4iVM8GpyCT36AkhXyk6dzd13LkfmeR
	Ua1MNkvM+W1futfcrOWpog16lqmbLcOy+9V6lpzLJHzEIhPkFKanGmYu747D4DI=
X-Google-Smtp-Source: AGHT+IF0HioBkcx0RhcpYoG/a1F7FbRdbMY7MPRn/gIVOPLaRv1wB6X2Y/xGwx0pbAGbGK2283U30g==
X-Received: by 2002:a17:907:119b:b0:a47:935:f9c6 with SMTP id uz27-20020a170907119b00b00a470935f9c6mr1637941ejb.22.1711119038485;
        Fri, 22 Mar 2024 07:50:38 -0700 (PDT)
Received: from linaro.org ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id oz27-20020a170906cd1b00b00a473490aae8sm522081ejb.24.2024.03.22.07.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:50:38 -0700 (PDT)
Date: Fri, 22 Mar 2024 16:50:36 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/msm/dp: Add support for determining the
 eDP/DP mode from DT
Message-ID: <Zf2avBOq5hM13nQy@linaro.org>
References: <20240322-x1e80100-display-refactor-connector-v3-0-af14c29af665@linaro.org>
 <20240322-x1e80100-display-refactor-connector-v3-1-af14c29af665@linaro.org>
 <fcfd7gu2wv2cejwmhcw237xoj2l7xpjxa5hnqrqy7mhkdr4kf4@yoq6dyc6tz27>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcfd7gu2wv2cejwmhcw237xoj2l7xpjxa5hnqrqy7mhkdr4kf4@yoq6dyc6tz27>

On 24-03-22 09:30:21, Bjorn Andersson wrote:
> On Fri, Mar 22, 2024 at 03:22:22PM +0200, Abel Vesa wrote:
> > Instead of relying on different compatibles for eDP and DP, lookup
> > the panel node in devicetree to figure out the connector type and
> > then pass on that information to the PHY. External DP is not described
> > in DT, therefore, assume it's eDP if panel node is present.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 43 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 39 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index c4cb82af5c2f..c9763f77c832 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -726,6 +726,14 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
> >  	if (IS_ERR(phy))
> >  		return PTR_ERR(phy);
> >  
> > +	rc = phy_set_mode_ext(phy, PHY_MODE_DP,
> > +			      dp->dp_display.is_edp ? PHY_SUBMODE_EDP : PHY_SUBMODE_DP);
> > +	if (rc) {
> > +		DRM_ERROR("failed to set phy submode, rc = %d\n", rc);
> > +		dp->catalog = NULL;
> > +		goto error;
> > +	}
> > +
> >  	dp->catalog = dp_catalog_get(dev);
> >  	if (IS_ERR(dp->catalog)) {
> >  		rc = PTR_ERR(dp->catalog);
> > @@ -734,9 +742,7 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
> >  		goto error;
> >  	}
> >  
> > -	dp->aux = dp_aux_get(dev, dp->catalog,
> > -			     phy,
> > -			     dp->dp_display.is_edp);
> > +	dp->aux = dp_aux_get(dev, dp->catalog, phy, dp->dp_display.is_edp);
> >  	if (IS_ERR(dp->aux)) {
> >  		rc = PTR_ERR(dp->aux);
> >  		DRM_ERROR("failed to initialize aux, rc = %d\n", rc);
> > @@ -1241,6 +1247,35 @@ static int dp_auxbus_done_probe(struct drm_dp_aux *aux)
> >  	return dp_display_probe_tail(aux->dev);
> >  }
> >  
> > +static int dp_display_get_connector_type(struct platform_device *pdev,
> > +					 const struct msm_dp_desc *desc)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *aux_bus;
> > +	struct device_node *panel;
> > +	int ret = DRM_MODE_CONNECTOR_DisplayPort;
> > +
> > +	/* legacy platforms specify connector type in match data */
> > +	if (desc->connector_type == DRM_MODE_CONNECTOR_eDP ||
> > +		desc->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
> > +		return desc->connector_type;
> > +
> > +	aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
> > +	if (!aux_bus)
> > +		goto out;
> 
> My compiler warns that if we take this code path, then you will
> of_node_put(<uninitialized panel>) below.
> 
> > +
> > +	panel = of_get_child_by_name(aux_bus, "panel");
> > +	if (!panel)
> > +		goto out;
> > +
> > +	ret = DRM_MODE_CONNECTOR_eDP;
> 
> My brain read this function as:
> check something
> if (error)
>   bailout!
> 
> check something
> if (error)
>   bailout!
> 
> ret should be edp
> 
> I then have to scan the code again to figure out what ret is otherwise,
> and convince myself that the error path is never an error, but a totally
> normal case.
> 
> 
> If you instead rely on the fact that both of_get_child_by_name() and
> of_node_put() can be passed NULL, you can write this as:
> 
> static int fn(..) {
>   aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
>   panel = of_get_child_by_name(aux_bus, "panel");
> 
>   if (panel)
>     connector_type = DRM_MODE_CONNECTOR_eDP;
>   else
>     connector_type = DRM_MODE_CONNECTOR_DisplayPort;
> 
>   of_node_put(panel);
>   of_node_put(aux_bus);
> 
>   return connector_type;
> }
> 
> Much easier to read, and you don't even have to zero-initialize panel to
> avoid that compiler warning.
> 

Fair enough, will do that instead.

> Regards,
> Bjorn
> 
> > +
> > +out:
> > +	of_node_put(panel);
> > +	of_node_put(aux_bus);
> > +	return ret;
> > +}
> > +
> >  static int dp_display_probe(struct platform_device *pdev)
> >  {
> >  	int rc = 0;
> > @@ -1263,7 +1298,7 @@ static int dp_display_probe(struct platform_device *pdev)
> >  	dp->dp_display.pdev = pdev;
> >  	dp->name = "drm_dp";
> >  	dp->id = desc->id;
> > -	dp->dp_display.connector_type = desc->connector_type;
> > +	dp->dp_display.connector_type = dp_display_get_connector_type(pdev, desc);
> >  	dp->wide_bus_supported = desc->wide_bus_supported;
> >  	dp->dp_display.is_edp =
> >  		(dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
> > 
> > -- 
> > 2.34.1
> > 

