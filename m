Return-Path: <linux-kernel+bounces-119589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A2988CACA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAE82C6A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE21F93E;
	Tue, 26 Mar 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sksD4wvf"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F41C6A0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474093; cv=none; b=DRbpVp2kKPw/AIykvwH6mIw8GrbXCE67tmbDutZgo0NlFJktS8ATrRS6BBULfn3PMhlxSpqylj5FrgOqQ22lob/jC/VhGJdYM0XIq5aM2on08XUSvVJC2VP/djZfg04+7Iqnq8NAYtmYE7RkTDj5+aZvKLaLTGxoLptOE2FhEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474093; c=relaxed/simple;
	bh=auU9osatJgm+5HtO74Vr7VkY2pMs1J2wxfjD9tBSsps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOoUo/25YqlwQKIlkGnegRj2odQL2GvxYZJwaNM7PyvHP+5K2LWmiecqTxqwtGFyTnIpj/JXtOZynz3I1hOJz1Oe+Q0QdE15+DVtPbX2/dImXrdNxrYwMRdNeU7q78u98KsTI9g476INeZfkIFKWBPkadN5gqEemUFxxD8KDUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sksD4wvf; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-609f3ca61e0so62701737b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711474091; x=1712078891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXBeZKhcT8cc6xEPK8lT0ioRsYyHLX/6E0d+anBqJaU=;
        b=sksD4wvfypo+63ffg6hpdTnNx5e3JV5dtNDFzmAI40TI1MLWpk70IRxqiYi4HT2OAd
         be+TSAyGJn96MjNQjEfQGjviftpQ2B+bAaB7Q42T0EXLdaN2Mxesu51GhzwazsIwdOTh
         J0aF+GeAvTOEYygl6og8z08sVuc6bRmCQGmwv1jZKhZUyeO0vwfFId6zVV4oUKnYB2IT
         1KsGlAmHWvs+tTcKrrZBX/9U43uegRT/OcEU63plAwZZrEPBI6t+ciWPH6yR+cSWVdJZ
         QpALCjTwFfdoXL9C2ZoadjD/G9QVs+COgRL64qOOTD+pDWH1QBqD/qgX5ujbnyhKoCc7
         cI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474091; x=1712078891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXBeZKhcT8cc6xEPK8lT0ioRsYyHLX/6E0d+anBqJaU=;
        b=B7CZKf9fPEM4xj7adn0ORAq3eE+uen8zHPGWwZmYK+w0O7SCmXzFTJHa2kjplWlvBQ
         SYCczjjwAIap0HoeCJXy2JfDNGFnl4XG+7YjRlQ90VWtk0O7d+Ep+9VdUT+RARE0sS+4
         1bF8cqRn+41Uvgt6D2w7nfr++sQjPGbNNSknnxgdRLdMM5MisHOjyxIismDumrXzuoJR
         9xqCKJn8OopDhDlVj8atTLJjIjTAPdH+vPwBsQPehbwdNUiMjbQK0BdVyBjMTkKMZTSG
         7bkyR0PCtW6/5pk513y8S1mA2pN7I3mKzHJapJMK6Du69Hh2gceKyeH5D8ZMqURfE0Na
         xgZg==
X-Forwarded-Encrypted: i=1; AJvYcCWFIU54LSyVjCkWUldv5onDzNxGRg2bRNaaNMIp30XsHOOey6xase4rE0yYFMsXBK0gIlmgA8wUPYHyjMvgFYw/urTi48+YBS0DToB6
X-Gm-Message-State: AOJu0YzWvENCZmkOzBWqH0pyolo+d8TeioFFRj+UNJkmGg7e/6D7BiYn
	hzIII/ZYKyEfjwRnAib2zmIZgSpHtmktTqdbcZ0aKpyh7EJZnh1xeufewZeY2UkwkKUdcKxKL0T
	9iS/9n83zCcn5PYN0sSFF4ZQQTicP4WbsWhudXg==
X-Google-Smtp-Source: AGHT+IF8oCoFpEp71E1giwtUat9k2YbUrYq99NDd4Haoh0o4mELmlRE1suS9PZwgmFksoxYgU2zB/MGudwuTU6Jk6K8=
X-Received: by 2002:a25:6605:0:b0:dcb:fa70:c09 with SMTP id
 a5-20020a256605000000b00dcbfa700c09mr7919663ybc.28.1711474091018; Tue, 26 Mar
 2024 10:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-msm-dp-cleanup-v1-0-e775556ecec0@quicinc.com> <20240326-msm-dp-cleanup-v1-1-e775556ecec0@quicinc.com>
In-Reply-To: <20240326-msm-dp-cleanup-v1-1-e775556ecec0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 19:28:00 +0200
Message-ID: <CAA8EJpqfYTCwubTXF9PROwH-621u32sJ-=_Dr5z77dcHwKtQDA@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/msm/dp: Drop unused dp_debug struct
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 17:06, Bjorn Andersson <andersson@kernel.org> wrote:
>
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> The members of struct dp_debug are no longer used, so the only purpose
> of this struct is as a type of the return value of dp_debug_get(), to
> signal success/error.
>
> Drop the struct in favor of signalling the result of initialization
> using an int.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_debug.c   | 38 ++++++++++---------------------------
>  drivers/gpu/drm/msm/dp/dp_debug.h   | 38 +++++++++++--------------------------
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 ++--------
>  3 files changed, 23 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
> index eca5a02f9003..a631cbe0e599 100644
> --- a/drivers/gpu/drm/msm/dp/dp_debug.c
> +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
> @@ -21,8 +21,6 @@ struct dp_debug_private {
>         struct dp_link *link;
>         struct dp_panel *panel;
>         struct drm_connector *connector;
> -
> -       struct dp_debug dp_debug;
>  };
>
>  static int dp_debug_show(struct seq_file *seq, void *p)
> @@ -199,11 +197,8 @@ static const struct file_operations test_active_fops = {
>         .write = dp_test_active_write
>  };
>
> -static void dp_debug_init(struct dp_debug *dp_debug, struct dentry *root, bool is_edp)
> +static void dp_debug_init(struct dp_debug_private *debug, struct dentry *root, bool is_edp)
>  {
> -       struct dp_debug_private *debug = container_of(dp_debug,
> -                       struct dp_debug_private, dp_debug);
> -
>         debugfs_create_file("dp_debug", 0444, root,
>                         debug, &dp_debug_fops);
>
> @@ -222,39 +217,26 @@ static void dp_debug_init(struct dp_debug *dp_debug, struct dentry *root, bool i
>         }
>  }
>
> -struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
> -               struct dp_link *link,
> -               struct drm_connector *connector,
> -               struct dentry *root, bool is_edp)
> +int dp_debug_get(struct device *dev, struct dp_panel *panel,
> +                struct dp_link *link,
> +                struct drm_connector *connector,
> +                struct dentry *root, bool is_edp)
>  {
>         struct dp_debug_private *debug;
> -       struct dp_debug *dp_debug;
> -       int rc;
>
>         if (!dev || !panel || !link) {
>                 DRM_ERROR("invalid input\n");
> -               rc = -EINVAL;
> -               goto error;
> +               return -EINVAL;
>         }
>
>         debug = devm_kzalloc(dev, sizeof(*debug), GFP_KERNEL);
> -       if (!debug) {
> -               rc = -ENOMEM;
> -               goto error;
> -       }
> +       if (!debug)
> +               return -ENOMEM;
>
> -       debug->dp_debug.debug_en = false;
>         debug->link = link;
>         debug->panel = panel;
>
> -       dp_debug = &debug->dp_debug;
> -       dp_debug->vdisplay = 0;
> -       dp_debug->hdisplay = 0;
> -       dp_debug->vrefresh = 0;
> -
> -       dp_debug_init(dp_debug, root, is_edp);
> +       dp_debug_init(debug, root, is_edp);
>
> -       return dp_debug;
> - error:
> -       return ERR_PTR(rc);
> +       return 0;

Since there is nothing more to get, could you please move the
devm_kzalloc to dp_debug_init and call it directly from dp_display.c?

>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_debug.h b/drivers/gpu/drm/msm/dp/dp_debug.h
> index 9b3b2e702f65..c57200751c9f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_debug.h
> +++ b/drivers/gpu/drm/msm/dp/dp_debug.h
> @@ -9,22 +9,6 @@
>  #include "dp_panel.h"
>  #include "dp_link.h"
>
> -/**
> - * struct dp_debug
> - * @debug_en: specifies whether debug mode enabled
> - * @vdisplay: used to filter out vdisplay value
> - * @hdisplay: used to filter out hdisplay value
> - * @vrefresh: used to filter out vrefresh value
> - * @tpg_state: specifies whether tpg feature is enabled
> - */
> -struct dp_debug {
> -       bool debug_en;
> -       int aspect_ratio;
> -       int vdisplay;
> -       int hdisplay;
> -       int vrefresh;
> -};
> -
>  #if defined(CONFIG_DEBUG_FS)
>
>  /**
> @@ -41,22 +25,22 @@ struct dp_debug {
>   * This function sets up the debug module and provides a way
>   * for debugfs input to be communicated with existing modules
>   */
> -struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
> -               struct dp_link *link,
> -               struct drm_connector *connector,
> -               struct dentry *root,
> -               bool is_edp);
> +int dp_debug_get(struct device *dev, struct dp_panel *panel,
> +                struct dp_link *link,
> +                struct drm_connector *connector,
> +                struct dentry *root,
> +                bool is_edp);
>
>  #else
>
>  static inline
> -struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
> -               struct dp_link *link,
> -               struct drm_connector *connector,
> -               struct dentry *root,
> -               bool is_edp)
> +int dp_debug_get(struct device *dev, struct dp_panel *panel,
> +                struct dp_link *link,
> +                struct drm_connector *connector,
> +                struct dentry *root,
> +                bool is_edp)
>  {
> -       return ERR_PTR(-EINVAL);
> +       return -EINVAL;
>  }
>
>  #endif /* defined(CONFIG_DEBUG_FS) */
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c4cb82af5c2f..a9187be95166 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -93,7 +93,6 @@ struct dp_display_private {
>         struct dp_link    *link;
>         struct dp_panel   *panel;
>         struct dp_ctrl    *ctrl;
> -       struct dp_debug   *debug;
>
>         struct dp_display_mode dp_mode;
>         struct msm_dp dp_display;
> @@ -1431,14 +1430,9 @@ void dp_display_debugfs_init(struct msm_dp *dp_display, struct dentry *root, boo
>         dp = container_of(dp_display, struct dp_display_private, dp_display);
>         dev = &dp->dp_display.pdev->dev;
>
> -       dp->debug = dp_debug_get(dev, dp->panel,
> -                                       dp->link, dp->dp_display.connector,
> -                                       root, is_edp);
> -       if (IS_ERR(dp->debug)) {
> -               rc = PTR_ERR(dp->debug);
> +       rc = dp_debug_get(dev, dp->panel, dp->link, dp->dp_display.connector, root, is_edp);
> +       if (rc)
>                 DRM_ERROR("failed to initialize debug, rc = %d\n", rc);
> -               dp->debug = NULL;
> -       }
>  }
>
>  int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

