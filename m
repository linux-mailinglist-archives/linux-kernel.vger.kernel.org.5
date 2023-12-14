Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488598133FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573618AbjLNPGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573641AbjLNPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:06:30 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC590135
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:06:35 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d8ddcc433fso55176457b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1702566395; x=1703171195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=npg93uDYx/bD+BZoUZMyG3bxC3h5PRKLFHxMDcxK6Ho=;
        b=NVXMQ52J5GENmtZ4r8reQ+qeGoVsvk+CyT+vRSaag+pmhJNXGcFnLeftZEwlmf9CDE
         uIqHwbR8v3Xnq0rcp+nyUHPSAJUVG4j4uWLIdtBj3XoZPXvFxopUJoDAz54JkPaMDzYB
         epItJPFkjJEJ8P3I5ux4kL9rV54tm8OPihyGcUjeptpP83p+SBX+dQ9mbMMAXvEdrMgb
         rAtrQ3nfiRqJ+prcprMuEC4F1sM+zGDtiblYHX816qj4Fyu/c3ZK/g/Nr7OyshNC+L3J
         3eUUXKuyvbfafBHAEaQtcHYHQKPJKV1Fl+YLRcf/6khPGwe1nR2kjphT7Mqtn6WZlwKg
         L5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566395; x=1703171195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npg93uDYx/bD+BZoUZMyG3bxC3h5PRKLFHxMDcxK6Ho=;
        b=pnd7lQZYCQI5bwGAT3dhTl/CCjzGn4Yh69puhBGPcDBkcR3ld/4uYWiBfmLHKHxgwk
         zU0IlAsvnrKHu1x/iVJhSr/MVB8ElSQMk7JKzvvpXW2QOkpqNOGDRtwJ0z8Ebvp6GZ7i
         mSwMiKrOuC27OkdnFFuNAbkejwtKeYSJO7oPwXkV2Gz/YGIoZfAZkwx2kT+3dhXlo/6g
         XBzY9rN3T9CQG2bOuIl9+V9OCWyo/SXGs8Q6jUgqtVhnCubPUTvVt+4IGkio/h4nSAlv
         YINL0L4xRKZKYQoI/I1EFZvC3KYaDpzyHrQ+QRIvzeM2KKRdiQAlXdn9IniwKkjBrTzm
         OmrQ==
X-Gm-Message-State: AOJu0YzMRp3fPK7g7v2y5Uqaqtra60AmqmmKItnWy2MUJO90tgjrNEaW
        Mf4tK844momo/UvzN8ieZxKpCm3O8DvncY6/ucoxig==
X-Google-Smtp-Source: AGHT+IGnE6naN1mhdWSV1fg75N9DXzdEWSGhJAlvXbD2BmKzQQNv98BESuuTbqYXuRTu/1Ez0oSk8lYJUeBxwobAfik=
X-Received: by 2002:a0d:ea90:0:b0:5e3:a1b8:7d02 with SMTP id
 t138-20020a0dea90000000b005e3a1b87d02mr357919ywe.43.1702566394926; Thu, 14
 Dec 2023 07:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org> <20231207-kms-hdmi-connector-state-v5-14-6538e19d634d@kernel.org>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-14-6538e19d634d@kernel.org>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 14 Dec 2023 15:06:18 +0000
Message-ID: <CAPY8ntB9ngzpTm48+gdf_qGVj-ZCZP8=bucjC25--ye-wBY8fw@mail.gmail.com>
Subject: Re: [PATCH v5 14/44] drm/connector: hdmi: Add custom hook to filter
 TMDS character rate
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 15:50, Maxime Ripard <mripard@kernel.org> wrote:
>
> Most of the HDMI controllers have an upper TMDS character rate limit
> they can't exceed. On "embedded"-grade display controllers, it will
> typically be lower than what high-grade monitors can provide these days,
> so drivers will filter the TMDS character rate based on the controller
> capabilities.
>
> To make that easier to handle for drivers, let's provide an optional
> hook to be implemented by drivers so they can tell the HDMI controller
> helpers if a given TMDS character rate is reachable for them or not.
>
> This will then be useful to figure out the best format and bpc count for
> a given mode.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c          |  9 +++
>  drivers/gpu/drm/drm_connector.c                    |  4 ++
>  .../gpu/drm/tests/drm_atomic_state_helper_test.c   | 69 ++++++++++++++++++++++
>  drivers/gpu/drm/tests/drm_connector_test.c         | 15 +++++
>  include/drm/drm_connector.h                        | 30 ++++++++++
>  5 files changed, 127 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 74bc3cc53c2d..a36edda590f8 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -687,11 +687,20 @@ hdmi_clock_valid(const struct drm_connector *connector,
>                  const struct drm_display_mode *mode,
>                  unsigned long long clock)
>  {
> +       const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
>         const struct drm_display_info *info = &connector->display_info;
>
>         if (info->max_tmds_clock && clock > info->max_tmds_clock * 1000)
>                 return MODE_CLOCK_HIGH;
>
> +       if (funcs && funcs->tmds_char_rate_valid) {
> +               enum drm_mode_status status;
> +
> +               status = funcs->tmds_char_rate_valid(connector, mode, clock);
> +               if (status != MODE_OK)
> +                       return status;
> +       }
> +
>         return MODE_OK;
>  }
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 667326b09acc..9f314fee26ce 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -457,6 +457,7 @@ EXPORT_SYMBOL(drmm_connector_init);
>   * @dev: DRM device
>   * @connector: A pointer to the HDMI connector to init
>   * @funcs: callbacks for this connector
> + * @hdmi_funcs: HDMI-related callbacks for this connector
>   * @connector_type: user visible type of the connector
>   * @ddc: optional pointer to the associated ddc adapter
>   * @supported_formats: Bitmask of @hdmi_colorspace listing supported output formats
> @@ -476,6 +477,7 @@ EXPORT_SYMBOL(drmm_connector_init);
>  int drmm_connector_hdmi_init(struct drm_device *dev,
>                              struct drm_connector *connector,
>                              const struct drm_connector_funcs *funcs,
> +                            const struct drm_connector_hdmi_funcs *hdmi_funcs,
>                              int connector_type,
>                              struct i2c_adapter *ddc,
>                              unsigned long supported_formats,
> @@ -512,6 +514,8 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>         if (max_bpc > 8)
>                 drm_connector_attach_hdr_output_metadata_property(connector);
>
> +       connector->hdmi.funcs = hdmi_funcs;
> +
>         return 0;
>  }
>  EXPORT_SYMBOL(drmm_connector_hdmi_init);
> diff --git a/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c b/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
> index d76fafb91025..e7dbdd4a4e7f 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
> @@ -110,6 +110,21 @@ static int set_connector_edid(struct kunit *test, struct drm_connector *connecto
>         return 0;
>  }
>
> +static const struct drm_connector_hdmi_funcs dummy_connector_hdmi_funcs = {
> +};
> +
> +static enum drm_mode_status
> +reject_connector_tmds_char_rate_valid(const struct drm_connector *connector,
> +                                      const struct drm_display_mode *mode,
> +                                      unsigned long long tmds_rate)
> +{
> +       return MODE_BAD;
> +}
> +
> +static const struct drm_connector_hdmi_funcs reject_connector_hdmi_funcs = {
> +       .tmds_char_rate_valid   = reject_connector_tmds_char_rate_valid,
> +};
> +
>  static int dummy_connector_get_modes(struct drm_connector *connector)
>  {
>         struct drm_atomic_helper_connector_hdmi_priv *priv =
> @@ -192,6 +207,7 @@ drm_atomic_helper_connector_hdmi_init(struct kunit *test,
>         conn = &priv->connector;
>         ret = drmm_connector_hdmi_init(drm, conn,
>                                        &dummy_connector_funcs,
> +                                      &dummy_connector_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        NULL,
>                                        formats,
> @@ -956,6 +972,58 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate, preferred->clock * 1500);
>  }
>
> +/*
> + * Test that if we filter a rate through our hook, it's indeed rejected
> + * by the whole atomic_check logic.
> + *
> + * We do so by first doing a commit on the pipeline to make sure that it
> + * works, change the HDMI helpers pointer, and then try the same commit
> + * again to see if it fails as it should.
> + */
> +static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
> +{
> +       struct drm_atomic_helper_connector_hdmi_priv *priv;
> +       struct drm_modeset_acquire_ctx *ctx;
> +       struct drm_atomic_state *state;
> +       struct drm_display_mode *preferred;
> +       struct drm_crtc_state *crtc_state;
> +       struct drm_connector *conn;
> +       struct drm_device *drm;
> +       struct drm_crtc *crtc;
> +       int ret;
> +
> +       priv = drm_atomic_helper_connector_hdmi_init(test,
> +                                                    BIT(HDMI_COLORSPACE_RGB),
> +                                                    8);
> +       KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +       ctx = drm_kunit_helper_acquire_ctx_alloc(test);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +       conn = &priv->connector;
> +       preferred = find_preferred_mode(conn);
> +       KUNIT_ASSERT_NOT_NULL(test, preferred);
> +
> +       drm = &priv->drm;
> +       crtc = priv->crtc;
> +       ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       /* You shouldn't be doing that at home. */
> +       conn->hdmi.funcs = &reject_connector_hdmi_funcs;
> +
> +       state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
> +
> +       crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> +
> +       crtc_state->connectors_changed = true;
> +
> +       ret = drm_atomic_check_only(state);
> +       KUNIT_EXPECT_LT(test, ret, 0);
> +}
> +
>  static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
>         KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode),
>         KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode_vic_1),
> @@ -965,6 +1033,7 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
>         KUNIT_CASE(drm_test_check_broadcast_rgb_limited_cea_mode_vic_1),
>         KUNIT_CASE(drm_test_check_broadcast_rgb_crtc_mode_changed),
>         KUNIT_CASE(drm_test_check_broadcast_rgb_crtc_mode_not_changed),
> +       KUNIT_CASE(drm_test_check_hdmi_funcs_reject_rate),
>         KUNIT_CASE(drm_test_check_output_bpc_crtc_mode_changed),
>         KUNIT_CASE(drm_test_check_output_bpc_crtc_mode_not_changed),
>         KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_8bpc),
> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
> index 0a838924a546..6a3651b08c81 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
> @@ -22,6 +22,9 @@ struct drm_connector_init_priv {
>         struct i2c_adapter ddc;
>  };
>
> +static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs = {
> +};
> +
>  static const struct drm_connector_funcs dummy_funcs = {
>         .atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
>         .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> @@ -187,6 +190,7 @@ static void drm_test_connector_hdmi_init_valid(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -205,6 +209,7 @@ static void drm_test_connector_hdmi_init_null_ddc(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        NULL,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -223,6 +228,7 @@ static void drm_test_connector_hdmi_init_bpc_invalid(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -241,6 +247,7 @@ static void drm_test_connector_hdmi_init_bpc_null(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -263,6 +270,7 @@ static void drm_test_connector_hdmi_init_bpc_8(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -297,6 +305,7 @@ static void drm_test_connector_hdmi_init_bpc_10(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -331,6 +340,7 @@ static void drm_test_connector_hdmi_init_bpc_12(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -361,6 +371,7 @@ static void drm_test_connector_hdmi_init_formats_empty(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        0,
> @@ -379,6 +390,7 @@ static void drm_test_connector_hdmi_init_formats_no_rgb(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_YUV422),
> @@ -398,6 +410,7 @@ static void drm_test_connector_hdmi_init_type_valid(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        connector_type,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -431,6 +444,7 @@ static void drm_test_connector_hdmi_init_type_invalid(struct kunit *test)
>
>         ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        connector_type,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> @@ -695,6 +709,7 @@ static void drm_test_drm_connector_attach_broadcast_rgb_property_hdmi_connector(
>
>         ret = drmm_connector_hdmi_init(&priv->drm, connector,
>                                        &dummy_funcs,
> +                                      &dummy_hdmi_funcs,
>                                        DRM_MODE_CONNECTOR_HDMIA,
>                                        &priv->ddc,
>                                        BIT(HDMI_COLORSPACE_RGB),
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 59016d9c17f5..3eaf4d54364d 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1093,6 +1093,30 @@ struct drm_connector_state {
>         } hdmi;
>  };
>
> +/**
> + * struct drm_connector_hdmi_funcs - drm_hdmi_connector control functions
> + */
> +struct drm_connector_hdmi_funcs {
> +       /**
> +        * @tmds_char_rate_valid:
> +        *
> +        * This callback is invoked at atomic_check time to figure out
> +        * whether a particular TMDS character rate is supported by the
> +        * driver.
> +        *
> +        * The @tmds_char_rate_valid callback is optional.
> +        *
> +        * Returns:
> +        *
> +        * Either &drm_mode_status.MODE_OK or one of the failure reasons
> +        * in &enum drm_mode_status.
> +        */
> +       enum drm_mode_status
> +       (*tmds_char_rate_valid)(const struct drm_connector *connector,
> +                               const struct drm_display_mode *mode,
> +                               unsigned long long tmds_rate);
> +};
> +
>  /**
>   * struct drm_connector_funcs - control connectors on a given device
>   *
> @@ -1967,6 +1991,11 @@ struct drm_connector {
>                  * supported by the controller.
>                  */
>                 unsigned long supported_formats;
> +
> +               /**
> +                * @funcs: HDMI connector Control Functions
> +                */
> +               const struct drm_connector_hdmi_funcs *funcs;
>         } hdmi;
>  };
>
> @@ -1989,6 +2018,7 @@ int drmm_connector_init(struct drm_device *dev,
>  int drmm_connector_hdmi_init(struct drm_device *dev,
>                              struct drm_connector *connector,
>                              const struct drm_connector_funcs *funcs,
> +                            const struct drm_connector_hdmi_funcs *hdmi_funcs,
>                              int connector_type,
>                              struct i2c_adapter *ddc,
>                              unsigned long supported_formats,
>
> --
> 2.43.0
>
