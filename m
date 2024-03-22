Return-Path: <linux-kernel+bounces-111613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47590886E91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A801F23712
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50C481CD;
	Fri, 22 Mar 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyQypFJh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BA47F59;
	Fri, 22 Mar 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117825; cv=none; b=RZEe1+Z7SLfH8blw4a7N8DL3fUPg9QXav23h3D2hP3DaGLlw1BIBdUKveDDv4ZJlZHOXQ6jVwn0bxUhUHgVlLJsJ8qc1FvGgdyb8t9WfkYiyTm6sX6+4hbi/Y/Im929uOI7nZLW1HKUNd9evE47Bz2xttqPUkeCNyM0kdmdIlqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117825; c=relaxed/simple;
	bh=Wg8lQMO0LpajNk89XjJGacGwVbfkVCAW5DBZvv2tpa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGyvMkPrMT5PHJGk36LU6tbCLsBGJN7qzxEfgxXG/Vswe+o5fzK7mVxf5pYWnpbbUE32iyJbTR3tISle3wFUMYKgZ38G46Mk8/wizfbnT1FitNKj1/A8skEMBDVN9RhQemJFUKsi25GMjOYUFR84kEZv9d1s7OtE/9QkPSZLgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyQypFJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C314C433C7;
	Fri, 22 Mar 2024 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117824;
	bh=Wg8lQMO0LpajNk89XjJGacGwVbfkVCAW5DBZvv2tpa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyQypFJhWx6AZhAEb+B2uxHEKamm1/hTOFQ+YCQKYosWSWqlorokb4mOSuTLh+tXl
	 ZC92CJK1awMoMG+w5B+fueP6YGdMcLU+tbC+dIZczBVvfXHQ2I1+6rNA/NZ+QNkMdr
	 dZGXHphfRlowo1GdV8fwbkB2XAcw9aGda8+SsyZqhwbIZ3DNBll7LvlqhAlmf4/gHP
	 g1qFh/G9NaD4u6trVEfMePbf0wtAgF+qX2gM8GplxmSWUF90Kh7LKvqrzeOmpblim5
	 3bOmI1rRy6/YWr9AImgqRe/tq+AJcYICTGNSGGFvBTKOiEpAxlvZFbktPV1xGsMQ1D
	 rawaSIYwBafJA==
Date: Fri, 22 Mar 2024 09:30:21 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/msm/dp: Add support for determining the
 eDP/DP mode from DT
Message-ID: <fcfd7gu2wv2cejwmhcw237xoj2l7xpjxa5hnqrqy7mhkdr4kf4@yoq6dyc6tz27>
References: <20240322-x1e80100-display-refactor-connector-v3-0-af14c29af665@linaro.org>
 <20240322-x1e80100-display-refactor-connector-v3-1-af14c29af665@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-x1e80100-display-refactor-connector-v3-1-af14c29af665@linaro.org>

On Fri, Mar 22, 2024 at 03:22:22PM +0200, Abel Vesa wrote:
> Instead of relying on different compatibles for eDP and DP, lookup
> the panel node in devicetree to figure out the connector type and
> then pass on that information to the PHY. External DP is not described
> in DT, therefore, assume it's eDP if panel node is present.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 43 +++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c4cb82af5c2f..c9763f77c832 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -726,6 +726,14 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
>  	if (IS_ERR(phy))
>  		return PTR_ERR(phy);
>  
> +	rc = phy_set_mode_ext(phy, PHY_MODE_DP,
> +			      dp->dp_display.is_edp ? PHY_SUBMODE_EDP : PHY_SUBMODE_DP);
> +	if (rc) {
> +		DRM_ERROR("failed to set phy submode, rc = %d\n", rc);
> +		dp->catalog = NULL;
> +		goto error;
> +	}
> +
>  	dp->catalog = dp_catalog_get(dev);
>  	if (IS_ERR(dp->catalog)) {
>  		rc = PTR_ERR(dp->catalog);
> @@ -734,9 +742,7 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
>  		goto error;
>  	}
>  
> -	dp->aux = dp_aux_get(dev, dp->catalog,
> -			     phy,
> -			     dp->dp_display.is_edp);
> +	dp->aux = dp_aux_get(dev, dp->catalog, phy, dp->dp_display.is_edp);
>  	if (IS_ERR(dp->aux)) {
>  		rc = PTR_ERR(dp->aux);
>  		DRM_ERROR("failed to initialize aux, rc = %d\n", rc);
> @@ -1241,6 +1247,35 @@ static int dp_auxbus_done_probe(struct drm_dp_aux *aux)
>  	return dp_display_probe_tail(aux->dev);
>  }
>  
> +static int dp_display_get_connector_type(struct platform_device *pdev,
> +					 const struct msm_dp_desc *desc)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *aux_bus;
> +	struct device_node *panel;
> +	int ret = DRM_MODE_CONNECTOR_DisplayPort;
> +
> +	/* legacy platforms specify connector type in match data */
> +	if (desc->connector_type == DRM_MODE_CONNECTOR_eDP ||
> +		desc->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
> +		return desc->connector_type;
> +
> +	aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
> +	if (!aux_bus)
> +		goto out;

My compiler warns that if we take this code path, then you will
of_node_put(<uninitialized panel>) below.

> +
> +	panel = of_get_child_by_name(aux_bus, "panel");
> +	if (!panel)
> +		goto out;
> +
> +	ret = DRM_MODE_CONNECTOR_eDP;

My brain read this function as:
check something
if (error)
  bailout!

check something
if (error)
  bailout!

ret should be edp

I then have to scan the code again to figure out what ret is otherwise,
and convince myself that the error path is never an error, but a totally
normal case.


If you instead rely on the fact that both of_get_child_by_name() and
of_node_put() can be passed NULL, you can write this as:

static int fn(..) {
  aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
  panel = of_get_child_by_name(aux_bus, "panel");

  if (panel)
    connector_type = DRM_MODE_CONNECTOR_eDP;
  else
    connector_type = DRM_MODE_CONNECTOR_DisplayPort;

  of_node_put(panel);
  of_node_put(aux_bus);

  return connector_type;
}

Much easier to read, and you don't even have to zero-initialize panel to
avoid that compiler warning.

Regards,
Bjorn

> +
> +out:
> +	of_node_put(panel);
> +	of_node_put(aux_bus);
> +	return ret;
> +}
> +
>  static int dp_display_probe(struct platform_device *pdev)
>  {
>  	int rc = 0;
> @@ -1263,7 +1298,7 @@ static int dp_display_probe(struct platform_device *pdev)
>  	dp->dp_display.pdev = pdev;
>  	dp->name = "drm_dp";
>  	dp->id = desc->id;
> -	dp->dp_display.connector_type = desc->connector_type;
> +	dp->dp_display.connector_type = dp_display_get_connector_type(pdev, desc);
>  	dp->wide_bus_supported = desc->wide_bus_supported;
>  	dp->dp_display.is_edp =
>  		(dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
> 
> -- 
> 2.34.1
> 

