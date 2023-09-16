Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5287A2D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbjIPBtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbjIPBtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:49:04 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AEC1BF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:48:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59c0442a359so19339117b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694828938; x=1695433738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JTYH8flv3ccT8c+yWqT7G6+6E5/spC5WmqITXpaM+4=;
        b=KYlFyLGGlp81dhM9+PyMg5wDproSZktdMoVBfTMCm+0A38GhsEX3LqfxVSzRfctrua
         PF0NUCnaK+ynygEodqyqohijAiy6kEQ0wzwWj+BjnP5V9H8FfamXwdfIGNisa+JtdR0n
         yT0M8HhiypbnlgPBaARGNK8o3jefa3CJqJsBTjMNe8gOLQw94eyICLvJUPkQ3RFiNtJf
         crfA7s6YVsCPT9A72ryNFPeCBZuL6Uch/Owu3/enURjysBLF3i8VA51uBdYmJvktqHh5
         hux9ROyw0NjJJQ3OSGY43aZX6pejbPSjI9G92DBQH4pxAxrt4jRo9+8A1to0UbA7nan+
         PJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694828938; x=1695433738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JTYH8flv3ccT8c+yWqT7G6+6E5/spC5WmqITXpaM+4=;
        b=K8PHhNvpTtiqSr6/upBzz6SnMSj3DXBa0P7D+1bcHRASIMqgUgvGFlWHE4Ka0ahVD7
         JtsrBIxmxSbgYvdTNAR+yigw6dufK8MnK+CC28bEhZKclYD92aJe3IDmLGiHk+13GQt7
         eIbL5gn3gAE65C26bY8paZbjgNeSRHb5SfhaTfcuonA51eBKs7pejPCu6huvj5b29jHh
         PaYPdH6rKeUupDX8PBgwa5r+1e1UPgKtQg9MGPJ0K9sPbPuib2xtEfDV2K0GkYOZvL7H
         iCREc/6TlIld92oChCVtydZhEc7YQUQhG1dbp7+odv/Ih9++WCaIs1abx0hRNC5syju9
         YOQg==
X-Gm-Message-State: AOJu0Yw8pWLNTKDMwoE8OXHJ+awLNx2HBBLdn84o1/zUrc3DsGycsMOm
        xQ9VXVGaZC6SRhe+VwdThwPn4dK1+FZ4wM7pqlolChMK6q4/y4WaWOo=
X-Google-Smtp-Source: AGHT+IGRwD+CVCZwzYDp2F79teBO7fCL/jHf+5wWXzV3pA94Oz27NZOScR4iVc75l04OEdB8BVk2xlaaSO+CFmQeENU=
X-Received: by 2002:a81:d551:0:b0:599:241d:3a31 with SMTP id
 l17-20020a81d551000000b00599241d3a31mr3623512ywj.43.1694828937863; Fri, 15
 Sep 2023 18:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com> <1694813901-26952-8-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1694813901-26952-8-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Sep 2023 04:48:46 +0300
Message-ID: <CAA8EJpo7tM+DHWhWD8o2oXU+Htosqv5q6JfzK3hrNi-h8fwRFg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sept 2023 at 00:39, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Currently eDP population is done at msm_dp_modeset_init() which happen
> at binding time. Move eDP population to be done at display probe time
> so that probe deferral cases can be handled effectively.
> wait_for_hpd_asserted callback is added during drm_dp_aux_init()
> to ensure eDP's HPD is up before proceeding eDP population.
>
> Changes in v3:
> -- add done_probing callback into devm_of_dp_aux_populate_bus()
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c     | 25 ++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.c | 79 ++++++++++++++++++-------------------
>  2 files changed, 64 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 8fa93c5..79f0c6e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -507,6 +507,21 @@ void dp_aux_unregister(struct drm_dp_aux *dp_aux)
>         drm_dp_aux_unregister(dp_aux);
>  }
>
> +static int dp_wait_hpd_asserted(struct drm_dp_aux *dp_aux,
> +                                unsigned long wait_us)
> +{
> +       int ret;
> +       struct dp_aux_private *aux;
> +
> +       aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
> +
> +       pm_runtime_get_sync(aux->dev);
> +       ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);
> +       pm_runtime_put_sync(aux->dev);
> +
> +       return ret;
> +}
> +
>  struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
>                               bool is_edp)
>  {
> @@ -530,6 +545,16 @@ struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
>         aux->catalog = catalog;
>         aux->retry_cnt = 0;
>
> +       /*
> +        * Use the drm_dp_aux_init() to use the aux adapter
> +        * before registering aux with the DRM device.
> +        */

Usual comment: this describes what, but should be documenting why.

> +       aux->dp_aux.name = "dpu_dp_aux";
> +       aux->dp_aux.dev = dev;
> +       aux->dp_aux.transfer = dp_aux_transfer;
> +       aux->dp_aux.wait_hpd_asserted = dp_wait_hpd_asserted;

Then the relevant code should be removed before a call to drm_dp_aux_register().

> +       drm_dp_aux_init(&aux->dp_aux);
> +
>         return &aux->dp_aux;
>  }
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index b58cb02..886fae5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -310,8 +310,6 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>
>         kthread_stop(dp->ev_tsk);
>
> -       of_dp_aux_depopulate_bus(dp->aux);
> -
>         dp_power_client_deinit(dp->power);
>         dp_unregister_audio_driver(dev, dp->audio);
>         dp_aux_unregister(dp->aux);
> @@ -1217,6 +1215,31 @@ static const struct msm_dp_desc *dp_display_get_desc(struct platform_device *pde
>         return NULL;
>  }
>
> +static int dp_auxbus_done_probe(struct drm_dp_aux *aux)
> +{
> +       int rc;
> +
> +       rc = component_add(aux->dev, &dp_display_comp_ops);
> +       if (rc)
> +               DRM_ERROR("eDP component add failed, rc=%d\n", rc);
> +
> +       return rc;
> +}
> +
> +static int dp_display_auxbus_population(struct dp_display_private *dp)
> +{
> +       struct device *dev = &dp->pdev->dev;
> +       struct device_node *aux_bus;
> +       int ret = 0;
> +
> +       aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");

device_node refcount leak.

But I think that the aux-bus existence check is incorrect here.
of_dp_aux_populate_bus() will check and return -ENODEV if there is no
aux-bus subnode.

And once you have dropped the aux_bus check, you can safely inline
this function.

> +
> +       if (aux_bus)
> +               ret = devm_of_dp_aux_populate_bus(dp->aux, dp_auxbus_done_probe);
> +
> +       return ret;
> +}
> +
>  static int dp_display_probe(struct platform_device *pdev)
>  {
>         int rc = 0;
> @@ -1282,10 +1305,16 @@ static int dp_display_probe(struct platform_device *pdev)
>         if (rc)
>                 return rc;
>
> -       rc = component_add(&pdev->dev, &dp_display_comp_ops);
> -       if (rc) {
> -               DRM_ERROR("component add failed, rc=%d\n", rc);
> -               dp_display_deinit_sub_modules(dp);
> +       if (dp->dp_display.is_edp) {
> +               rc = dp_display_auxbus_population(dp);
> +               if (rc)
> +                       DRM_ERROR("eDP auxbus population failed, rc=%d\n", rc);
> +       } else {
> +               rc = component_add(&pdev->dev, &dp_display_comp_ops);
> +               if (rc) {
> +                       DRM_ERROR("component add failed, rc=%d\n", rc);
> +                       dp_display_deinit_sub_modules(dp);
> +               }
>         }
>
>         return rc;
> @@ -1296,14 +1325,13 @@ static int dp_display_remove(struct platform_device *pdev)
>         struct dp_display_private *dp = dev_get_dp_display_private(&pdev->dev);
>
>         component_del(&pdev->dev, &dp_display_comp_ops);
> -       dp_display_deinit_sub_modules(dp);
> -
>         platform_set_drvdata(pdev, NULL);
>
> -       pm_runtime_put_sync_suspend(&pdev->dev);
>         pm_runtime_dont_use_autosuspend(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>
> +       dp_display_deinit_sub_modules(dp);

These changes should be reasoned.

> +
>         return 0;
>  }
>
> @@ -1432,31 +1460,10 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
>
>  static int dp_display_get_next_bridge(struct msm_dp *dp)
>  {
> -       int rc;
> +       int rc = 0;

Is there a need to set it to 0?


>         struct dp_display_private *dp_priv;
> -       struct device_node *aux_bus;
> -       struct device *dev;
>
>         dp_priv = container_of(dp, struct dp_display_private, dp_display);
> -       dev = &dp_priv->pdev->dev;
> -       aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
> -
> -       if (aux_bus && dp->is_edp) {
> -               /*
> -                * The code below assumes that the panel will finish probing
> -                * by the time devm_of_dp_aux_populate_ep_devices() returns.
> -                * This isn't a great assumption since it will fail if the
> -                * panel driver is probed asynchronously but is the best we
> -                * can do without a bigger driver reorganization.
> -                */
> -               rc = of_dp_aux_populate_bus(dp_priv->aux, NULL);
> -               of_node_put(aux_bus);
> -               if (rc)
> -                       goto error;
> -       } else if (dp->is_edp) {
> -               DRM_ERROR("eDP aux_bus not found\n");
> -               return -ENODEV;
> -       }
>
>         /*
>          * External bridges are mandatory for eDP interfaces: one has to
> @@ -1469,17 +1476,9 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>         if (!dp->is_edp && rc == -ENODEV)
>                 return 0;
>
> -       if (!rc) {
> +       if (!rc)
>                 dp->next_bridge = dp_priv->parser->next_bridge;
> -               return 0;
> -       }
>
> -error:
> -       if (dp->is_edp) {
> -               of_dp_aux_depopulate_bus(dp_priv->aux);
> -               dp_display_host_phy_exit(dp_priv);
> -               dp_display_host_deinit(dp_priv);
> -       }
>         return rc;
>  }
>
> --
> 2.7.4
>


--
With best wishes
Dmitry
