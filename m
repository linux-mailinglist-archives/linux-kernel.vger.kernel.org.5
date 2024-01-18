Return-Path: <linux-kernel+bounces-30412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD1831E59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE66B23657
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D93F2D035;
	Thu, 18 Jan 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yr1I43Cv"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7032D021
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598622; cv=none; b=BBuNb6Vj7AuXyd/8G+jwPIHQ545xJ/3vJTLbq+2bj4tpJ/aY6sZSz04cJVWtu7gSeNnzkD39vRSsOO9ZqIh8K40MEZoaY7bBC0qWPD3mtUbIRDh7uI8OZYzhca0ubUbVpZwvF0zwMo8E2H/5++MfJcZDTPMtuhX86XpD5c11Dm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598622; c=relaxed/simple;
	bh=z4UMkUR+0kYF6k/RuDEpjHgD7lqhsuZoYoYoigAC3lA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=SpizUA3BXO4lLW+2FmhTTF0CBkkWSruUf1hI3goS30IGr1HHJkpwl6VHcU4GcuzXxXf8y88wKIaZLgCX/jC9R6+/xWP/Fyyutu6TcJtuyHpBJi3ShOQ1qPNcvL6oim7/AZUt2lGAhEP3wuGJlmHp963Gw/FuTBedZLy5S941H5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yr1I43Cv; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc25099b084so1095966276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705598620; x=1706203420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UGVxI9DWCyEsv/jp78Pl1awCTbyR92th5Be9fg9uBng=;
        b=yr1I43CvZs3UBwIkcHAeCYPQ4aBej+HrUfyW4GCl6chCoVeQH0nbWeJmD61VV6Cb33
         Ev7K1akJa6OmlFCfAgrjKCqgF76gyylm1fkMDktaOnDgOAQ6wEFmWEM93TVqrornXDsz
         X7NrWQC4gdqshASTd/Buh0CFujvXHjznDn/mBiVbmyZq4m6xGFoiEdX226VNAlVLXXra
         Ep0lFjBGPV8WSN+Ob45YPL+QOvwu+e5VwVt7ISp1pzJKswK/XhvGLUVhWXFp4mXYqdJ4
         CwThkg1FKFY3ZbHSIhmFJfUxsjIeXziKADL7r6MCjhjJWuTJOzsUEx47REhOeU/bQHRb
         oXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705598620; x=1706203420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGVxI9DWCyEsv/jp78Pl1awCTbyR92th5Be9fg9uBng=;
        b=vjSsli20Ny70aaH0ARNrHfeU1ooQ7qIAdtnIS7M7z42o6OdMhOJCl7lkVJkh8GQz/B
         Jd+FSgJsFovBGUX+JDU18KjJOOA72rDFCiHrtvMKPh4gU+GNnr1kjkxeEuLom9BYYM2g
         YNzz66D08RNgQ8dvtPDqqlSZdQ3H/9gwQepwq0j6vJ0UaYH67PVxXwcu6OLV6pZwKSBj
         QUSsiBw1p47xgFpiPNy/lt/PE3OJ7OLE2EEggbh000cWLxIve9KVkImRMZ84CXKsfpoV
         zHMvZ/+acNsiFMIjJoe+NOfgLJPfq7Uttm4D7IuA2s/f0tRdeim3PA73JLlAF2twpzs9
         xz7Q==
X-Gm-Message-State: AOJu0Yxz2ZYgPtCPDftXrnFNR0GtqhH1oLAMAxW1ONoprSDEE1jvzdAQ
	JKf/6PbtZGk878y/0S1brfKo5xs6uUOw6JZ6ym1D8Sx/Hau3JrddBpuhgUVkjQlwB5THeN/XPTZ
	UNaIxfwYVN39ObwtI4oZTm+yv19KHkUOVBZaiPg==
X-Google-Smtp-Source: AGHT+IFZPZOmSLr8sYUtidrkYXHY+9dCrNdQTcg7gKBq5xIpeY/291djYf1UNIJxnMWWNtfravK1x5+1u8Q9awT4Wj0=
X-Received: by 2002:a25:1846:0:b0:dc2:209d:bc1 with SMTP id
 67-20020a251846000000b00dc2209d0bc1mr1041475yby.9.1705598619558; Thu, 18 Jan
 2024 09:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com> <20240116-jz-test-sim-panel-v1-4-f9511f46c9c7@quicinc.com>
In-Reply-To: <20240116-jz-test-sim-panel-v1-4-f9511f46c9c7@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 18 Jan 2024 19:23:27 +0200
Message-ID: <CAA8EJpoa5hrN4x9sUSXPj1UpFa_BKorRj1Kf9d2SE3OZcpvrPw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] drm/msm/dsi: Add simulated panel support
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	quic_abhinavk@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 00:22, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> Introduce the sim_panel_enabled module parameter.
>
> When set, this parameter will force DSI to select the simulated panel
> instead of the physical panel.
>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.c         | 4 ++++
>  drivers/gpu/drm/msm/dsi/dsi_host.c    | 9 ++++++++-
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 8 +++++++-
>  3 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index c6bd7bf15605c..daea84f5e3c0c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -5,6 +5,10 @@
>
>  #include "dsi.h"
>
> +bool sim_panel_enabled;
> +MODULE_PARM_DESC(sim_panel_enabled, "Use simulated panel");
> +module_param(sim_panel_enabled, bool, 0444);
> +
>  bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
>  {
>         unsigned long host_flags = msm_dsi_host_get_mode_flags(msm_dsi->host);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index deeecdfd6c4e4..fa0cab09fff71 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -35,6 +35,8 @@
>
>  #define DSI_RESET_TOGGLE_DELAY_MS 20
>
> +extern bool sim_panel_enabled;
> +
>  static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct drm_dsc_config *dsc);
>
>  static int dsi_get_version(const void __iomem *base, u32 *major, u32 *minor)
> @@ -2009,7 +2011,12 @@ int msm_dsi_host_register(struct mipi_dsi_host *host)
>         if (!msm_host->registered) {
>                 host->dev = &msm_host->pdev->dev;
>                 host->ops = &dsi_host_ops;
> -               ret = mipi_dsi_host_register(host);
> +
> +               if (sim_panel_enabled)
> +                       ret = mipi_dsi_host_register_sim_panel(host);
> +               else
> +                       ret = mipi_dsi_host_register(host);
> +
>                 if (ret)
>                         return ret;
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 896f369fdd535..e33e6be7309f2 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -30,6 +30,8 @@ struct msm_dsi_manager {
>
>  static struct msm_dsi_manager msm_dsim_glb;
>
> +extern bool sim_panel_enabled;
> +
>  #define IS_BONDED_DSI()                (msm_dsim_glb.is_bonded_dsi)
>  #define IS_SYNC_NEEDED()       (msm_dsim_glb.is_sync_needed)
>  #define IS_MASTER_DSI_LINK(id) (msm_dsim_glb.master_dsi_link_id == id)
> @@ -507,7 +509,11 @@ int msm_dsi_manager_ext_bridge_init(u8 id)
>         int ret;
>
>         int_bridge = msm_dsi->bridge;
> -       ext_bridge = devm_drm_of_get_bridge(&msm_dsi->pdev->dev,
> +
> +       if (sim_panel_enabled)
> +               ext_bridge = drm_get_sim_panel_bridge(&msm_dsi->pdev->dev);
> +       else
> +               ext_bridge = devm_drm_of_get_bridge(&msm_dsi->pdev->dev,
>                                             msm_dsi->pdev->dev.of_node, 1, 0);

I think that this is definitely an imperfect way to go. We should not
be modifying the DSI host drivers to be able to use the simulation
panel.
Could you please push this to drm_of_find_panel_or_bridge() ?

>         if (IS_ERR(ext_bridge))
>                 return PTR_ERR(ext_bridge);
>
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

