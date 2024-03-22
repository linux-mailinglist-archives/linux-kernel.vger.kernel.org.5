Return-Path: <linux-kernel+bounces-111556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E08886DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09F6B275D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829A760271;
	Fri, 22 Mar 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVbYWOiQ"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B2482D1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114698; cv=none; b=ZMjdRxwbxe659L3p+1tRQCJ/fxQbz/ssLSJiu+eqT9xKM/CsjIO/mlscOuZM/Jq5LHj++eIqUVONz8rWYG9i/Vp8sIJrJ60Ae7DAi6G86TUkSpup6vHospn6w0AGf5kvprYpZylGFqdraLapTPY6XjtM/k7dj9xiEqqBT/uSCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114698; c=relaxed/simple;
	bh=KowDJLlEkfi/aydE2rcjItRSORmHokir7LGxDFTw0+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BG1bWhJHQiWbNmnzJRZfyQSJ70nvPj8nDgy4wUqfycr2TTSCqxO0LiwaRdb3gP6guSIIHh7z3ztd0galB2t4/tGgUtjtY8xZQ3QFLZU1x5IHg4inEuXSjnXiTqfRniifKtNYdUJgnEW7o4pGLIgrKoozCoo3Z2hjvB8wPYX+55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVbYWOiQ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2232691276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711114695; x=1711719495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rm06Pm0qxCAJG4WaEyynyhO+EGvdCO+QoEXFmaLzGV8=;
        b=hVbYWOiQPeQqePavX4DO/9xF+6KwCYjAGJ0jyIw9D68o4ZfDI9im/igWzt+RHkIP6C
         U4ZyUCBD1irVW7+MOtkehG620qnTEBHMjZD5jCZcf6nrhBcMk50YwVMZelh89MTTyemG
         vMrEhTwKj1I+LpCiEv9/rLqnjWpPzQ0iRxBIXps2cTwrzjZBY/nbR4ON5Fn4m+T4Mafz
         bPQs/5fWCcIOtDupyuNzCVPxAMdWT7hURgH31ZrBGMU6tUJoqXPVLeACttFaWj8iLgUT
         FketKyNd7b3avsJPk0l2TJPmsOpegVFHhMDit2ocmclSchM0Hm9ZyVXAUiyqW9r/HMnz
         2Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711114695; x=1711719495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm06Pm0qxCAJG4WaEyynyhO+EGvdCO+QoEXFmaLzGV8=;
        b=ZIE7kDb18JLmCumpa9LtHA4Rz5bwDaDcDbR0/2QJFCA9yZznc71A2XKXjAvjBrReKK
         sqnYcPsDr8Ooln1CyDfGR7GHc4FP+5Qocw6CJQ0c9t/XH3x0yYzyZ+zcYWF1X+nfQ1Lp
         pi8+PQB9rs/r/vRKB2KzYslbmX6AdFubsMDBzSTZ1pL2AN72KgApX5qCLciNODi8uHLt
         YmuO4+nCPITaJhmYgZWPacVWu3+0lSqnOGX2GjSns0QtgEH7/djs3YAdeGHP6y4CpJh3
         hj9217IBjMlv0JXxbpeih0wdWU6BjKO9GWDl8mzhiF0kgHnOsWk01v6bGEVUS2dkeTGh
         kVNA==
X-Forwarded-Encrypted: i=1; AJvYcCUunW8tX7KCBhqT7urkvYH0FCC+SxiuEnS5oU01WTSagiwK6AUjlYAZyq4l4y0i5I44ovzCRh4gqbovaSLbo++W7s7Z7XJBMZPcwFNv
X-Gm-Message-State: AOJu0Ywx9dtxi339VxWI30PohsmsjJ4puqi+haPIeEU+h4/c+P+JOpYz
	5DtFBb8BsEdg2oDdSfI8mFZ3TNwyMLo97DBoZsDYdsNsc4po1sh8WkqFJDSAi16CCWw6ARlrR2s
	4Jp5pNtgY2EnBCSVt+Htjn/O/GCik668XC3t3sw==
X-Google-Smtp-Source: AGHT+IEkmHjU0hm7QDKg5iiD/rL1+CfoGmxy3DO50mPYMlb1WNPLGwILi3SX+SAGciMY2+MIq+t9wX021nQx5hltJ4Q=
X-Received: by 2002:a5b:911:0:b0:dcf:3ef2:6182 with SMTP id
 a17-20020a5b0911000000b00dcf3ef26182mr2103274ybq.0.1711114694919; Fri, 22 Mar
 2024 06:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-x1e80100-display-refactor-connector-v3-0-af14c29af665@linaro.org>
 <20240322-x1e80100-display-refactor-connector-v3-1-af14c29af665@linaro.org>
 <CAA8EJpp6V5qVzbYtnU=JjO8FX45fcxBvWsD3PWQ5bu5wuv-T=g@mail.gmail.com> <Zf2JYmm3DEaR8vB5@linaro.org>
In-Reply-To: <Zf2JYmm3DEaR8vB5@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Mar 2024 15:38:03 +0200
Message-ID: <CAA8EJppT2VAXMxAbMztbi=-QZj8nP++_Zy4RQHkY-DrO5W_3EQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/msm/dp: Add support for determining the eDP/DP
 mode from DT
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 15:36, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 24-03-22 15:30:54, Dmitry Baryshkov wrote:
> > On Fri, 22 Mar 2024 at 15:22, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > Instead of relying on different compatibles for eDP and DP, lookup
> > > the panel node in devicetree to figure out the connector type and
> > > then pass on that information to the PHY. External DP is not described
> >
> > Nit: External DP doesn't have a panel described in DT...
> >
>
> Will fix.
>
> > > in DT, therefore, assume it's eDP if panel node is present.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/dp/dp_display.c | 43 +++++++++++++++++++++++++++++++++----
> > >  1 file changed, 39 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index c4cb82af5c2f..c9763f77c832 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -726,6 +726,14 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
> > >         if (IS_ERR(phy))
> > >                 return PTR_ERR(phy);
> > >
> > > +       rc = phy_set_mode_ext(phy, PHY_MODE_DP,
> > > +                             dp->dp_display.is_edp ? PHY_SUBMODE_EDP : PHY_SUBMODE_DP);
> > > +       if (rc) {
> > > +               DRM_ERROR("failed to set phy submode, rc = %d\n", rc);
> > > +               dp->catalog = NULL;
> > > +               goto error;
> > > +       }
> > > +
> > >         dp->catalog = dp_catalog_get(dev);
> > >         if (IS_ERR(dp->catalog)) {
> > >                 rc = PTR_ERR(dp->catalog);
> > > @@ -734,9 +742,7 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
> > >                 goto error;
> > >         }
> > >
> > > -       dp->aux = dp_aux_get(dev, dp->catalog,
> > > -                            phy,
> > > -                            dp->dp_display.is_edp);
> > > +       dp->aux = dp_aux_get(dev, dp->catalog, phy, dp->dp_display.is_edp);
> >
> > Unrelated
> >
>
> Yep, will drop the change.
>
> > >         if (IS_ERR(dp->aux)) {
> > >                 rc = PTR_ERR(dp->aux);
> > >                 DRM_ERROR("failed to initialize aux, rc = %d\n", rc);
> > > @@ -1241,6 +1247,35 @@ static int dp_auxbus_done_probe(struct drm_dp_aux *aux)
> > >         return dp_display_probe_tail(aux->dev);
> > >  }
> > >
> > > +static int dp_display_get_connector_type(struct platform_device *pdev,
> > > +                                        const struct msm_dp_desc *desc)
> > > +{
> > > +       struct device *dev = &pdev->dev;
> > > +       struct device_node *aux_bus;
> > > +       struct device_node *panel;
> > > +       int ret = DRM_MODE_CONNECTOR_DisplayPort;
> > > +
> > > +       /* legacy platforms specify connector type in match data */
> > > +       if (desc->connector_type == DRM_MODE_CONNECTOR_eDP ||
> > > +               desc->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
> >
> > misaligned
> >
>
> Sure, will fix.
>
> > > +               return desc->connector_type;
> >
> > Can we drop this part completely?
> >
>
> You mean the whole if clause? How should we handle the legacy approach
> then?

Legacy platforms still have the aux-bus/panel. so they should be
handled by the check below.

>
> > > +
> > > +       aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
> > > +       if (!aux_bus)
> > > +               goto out;
> > > +
> > > +       panel = of_get_child_by_name(aux_bus, "panel");
> > > +       if (!panel)
> > > +               goto out;
> > > +
> > > +       ret = DRM_MODE_CONNECTOR_eDP;
> > > +
> > > +out:
> > > +       of_node_put(panel);
> > > +       of_node_put(aux_bus);
> > > +       return ret;
> > > +}
> > > +
> > >  static int dp_display_probe(struct platform_device *pdev)
> > >  {
> > >         int rc = 0;
> > > @@ -1263,7 +1298,7 @@ static int dp_display_probe(struct platform_device *pdev)
> > >         dp->dp_display.pdev = pdev;
> > >         dp->name = "drm_dp";
> > >         dp->id = desc->id;
> > > -       dp->dp_display.connector_type = desc->connector_type;
> > > +       dp->dp_display.connector_type = dp_display_get_connector_type(pdev, desc);
> > >         dp->wide_bus_supported = desc->wide_bus_supported;
> > >         dp->dp_display.is_edp =
> > >                 (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
> > >
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

