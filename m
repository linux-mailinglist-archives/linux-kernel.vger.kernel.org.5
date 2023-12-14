Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05A7813358
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573529AbjLNOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573497AbjLNOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:40:02 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947410E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:40:08 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db4422fff15so6909310276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1702564808; x=1703169608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CVbbR720mxFQWZWSF5/+frzTWN+zosuo0CwTK2ojkMc=;
        b=e89WRZiqS/mxnnSFPbD1PbJq+rKp5JIFJEtgfw2p3Mgne+dA8Pxk8up9WpX/ESAczr
         kjOnObY0FYsI/ws7inCt+/wBO+07+hzG4gY+XgbYup/ctlY9Fz2JfnkiygvNkE4VuSss
         dTCQQ/zYpZ3vpj1ijBYyRuVbEjBXeusZkMBaB/NJHKRGGqDCqo8XCPX1thkRS/owESzx
         hqMcVN0BqBKIr9WfezWyYrr9zFN/7maPA+mtYQZtFfO+9mQPTouwPjUazoQw8JmgCcmj
         AQX31tu7XGhgf2JKQcKGsOqS823yOPwULq/Yb/Ba5PX4/YsykgTIFJhcFatr2Ubm4Zr2
         LpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564808; x=1703169608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVbbR720mxFQWZWSF5/+frzTWN+zosuo0CwTK2ojkMc=;
        b=G/GmtHKj3CiyFSeG2dL8ntEKG1F/EgUANQOfdcDItPvFYwgKYpuKZBxFTFuoWuuUzC
         14thRW2VxhZ9Qao8JxFmpyKg0iEpZ4kpKK/k29bUlj6LDbLIH+rqW9Yq7ttXAVoPYPCh
         xbRoyFUxUjpDuMGZZL0aruFqGvXm3TtJvbABkIKD/zQXbb6UtgnxiN+3RJh9Grc95Csv
         J6YzMgDI+GFv0+3KPpMgSHH3+1K3/MX7vDnhPyzN0P5bHOFbi11ZN1GyUB5pRs3f/nAu
         dL/lUeS8Hxa3wb39/w2HpuBzACcT4qWpnnENol05oWVwsahIsqJKR/WwkRTKPpjbfUI+
         yEfA==
X-Gm-Message-State: AOJu0YwI+CN/TuIc8RYy6jZH9e8X3LkZKKLEhmm2q4osSyOYXvYklIl3
        9evYEuGuI0jdi1Qyb5UecQXHLKShPH3V+DGn/Z0kqQ==
X-Google-Smtp-Source: AGHT+IE2fGQgctDfqw+SdyQcQrVtSDwfkDhdhufA57h07Dfv7cH935CDl5idwK5f/LKOwnfwTJf5aUvfXaezh/MpzdQ=
X-Received: by 2002:a05:6902:cc2:b0:da3:b466:1f73 with SMTP id
 cq2-20020a0569020cc200b00da3b4661f73mr7064045ybb.24.1702564807819; Thu, 14
 Dec 2023 06:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org> <20231207-kms-hdmi-connector-state-v5-6-6538e19d634d@kernel.org>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-6-6538e19d634d@kernel.org>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 14 Dec 2023 14:39:51 +0000
Message-ID: <CAPY8ntCzdxJ5zyk4eeWV8D+WBdfri61ttoNxVtJUZSAKHoMpGQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/44] drm/connector: Introduce an HDMI connector
 initialization function
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

As requested, I'm just going through patches 6-16.
I will say that I've been less thorough in checking the kunit test
code in this series than the core code changes, and I'm trusting that
all the unit tests pass.

I get a build failure on the complete series for arm64 with the
standard defconfig
depmod: ERROR: Cycle detected: drm_display_helper -> drm_kms_helper ->
drm_display_helper
depmod: ERROR: Cycle detected: drm
depmod: ERROR: Found 2 modules in dependency cycles!

I haven't followed it through as to the reason, but obviously that
will need to be addressed.

  Dave

On Thu, 7 Dec 2023 at 15:49, Maxime Ripard <mripard@kernel.org> wrote:
>
> A lot of the various HDMI drivers duplicate some logic that depends on
> the HDMI spec itself and not really a particular hardware
> implementation.
>
> Output BPC or format selection, infoframe generation are good examples
> of such areas.
>
> This creates a lot of boilerplate, with a lot of variations, which makes
> it hard for userspace to rely on, and makes it difficult to get it right
> for drivers.
>
> In the next patches, we'll add a lot of infrastructure around the
> drm_connector and drm_connector_state structures, which will allow to
> abstract away the duplicated logic. This infrastructure comes with a few
> requirements though, and thus we need a new initialization function.
>
> Hopefully, this will make drivers simpler to handle, and their behaviour
> more consistent.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/drm_connector.c            |  39 +++++++++
>  drivers/gpu/drm/tests/drm_connector_test.c | 123 +++++++++++++++++++++++++++++
>  include/drm/drm_connector.h                |   5 ++
>  3 files changed, 167 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index b0516505f7ae..d9961cce8245 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -452,6 +452,45 @@ int drmm_connector_init(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drmm_connector_init);
>
> +/**
> + * drmm_connector_hdmi_init - Init a preallocated HDMI connector
> + * @dev: DRM device
> + * @connector: A pointer to the HDMI connector to init
> + * @funcs: callbacks for this connector
> + * @connector_type: user visible type of the connector
> + * @ddc: optional pointer to the associated ddc adapter
> + *
> + * Initialises a preallocated HDMI connector. Connectors can be
> + * subclassed as part of driver connector objects.
> + *
> + * Cleanup is automatically handled with a call to
> + * drm_connector_cleanup() in a DRM-managed action.
> + *
> + * The connector structure should be allocated with drmm_kzalloc().
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + */
> +int drmm_connector_hdmi_init(struct drm_device *dev,
> +                            struct drm_connector *connector,
> +                            const struct drm_connector_funcs *funcs,
> +                            int connector_type,
> +                            struct i2c_adapter *ddc)
> +{
> +       int ret;
> +
> +       if (!(connector_type == DRM_MODE_CONNECTOR_HDMIA ||
> +             connector_type == DRM_MODE_CONNECTOR_HDMIB))
> +               return -EINVAL;
> +
> +       ret = drmm_connector_init(dev, connector, funcs, connector_type, ddc);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(drmm_connector_hdmi_init);
> +
>  /**
>   * drm_connector_attach_edid_property - attach edid property.
>   * @connector: the connector
> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
> index a268847be8d1..8f070cacab3b 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
> @@ -172,6 +172,128 @@ static struct kunit_suite drmm_connector_init_test_suite = {
>         .test_cases = drmm_connector_init_tests,
>  };
>
> +/*
> + * Test that the registration of a bog standard connector works as
> + * expected and doesn't report any error.
> + */
> +static void drm_test_connector_hdmi_init_valid(struct kunit *test)
> +{
> +       struct drm_connector_init_priv *priv = test->priv;
> +       int ret;
> +
> +       ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
> +                                      &dummy_funcs,
> +                                      DRM_MODE_CONNECTOR_HDMIA,
> +                                      &priv->ddc);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +/*
> + * Test that the registration of a connector without a DDC adapter
> + * doesn't report any error.
> + */
> +static void drm_test_connector_hdmi_init_null_ddc(struct kunit *test)
> +{
> +       struct drm_connector_init_priv *priv = test->priv;
> +       int ret;
> +
> +       ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
> +                                      &dummy_funcs,
> +                                      DRM_MODE_CONNECTOR_HDMIA,
> +                                      NULL);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +/*
> + * Test that the registration of an HDMI connector with an HDMI
> + * connector type succeeds.
> + */
> +static void drm_test_connector_hdmi_init_type_valid(struct kunit *test)
> +{
> +       struct drm_connector_init_priv *priv = test->priv;
> +       unsigned int connector_type = *(unsigned int *)test->param_value;
> +       int ret;
> +
> +       ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
> +                                      &dummy_funcs,
> +                                      connector_type,
> +                                      &priv->ddc);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static const unsigned int drm_connector_hdmi_init_type_valid_tests[] = {
> +       DRM_MODE_CONNECTOR_HDMIA,
> +       DRM_MODE_CONNECTOR_HDMIB,
> +};
> +
> +static void drm_connector_hdmi_init_type_desc(const unsigned int *type, char *desc)
> +{
> +       sprintf(desc, "%s", drm_get_connector_type_name(*type));
> +}
> +
> +KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_type_valid,
> +                 drm_connector_hdmi_init_type_valid_tests,
> +                 drm_connector_hdmi_init_type_desc);
> +
> +/*
> + * Test that the registration of an HDMI connector with an !HDMI
> + * connector type fails.
> + */
> +static void drm_test_connector_hdmi_init_type_invalid(struct kunit *test)
> +{
> +       struct drm_connector_init_priv *priv = test->priv;
> +       unsigned int connector_type = *(unsigned int *)test->param_value;
> +       int ret;
> +
> +       ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
> +                                      &dummy_funcs,
> +                                      connector_type,
> +                                      &priv->ddc);
> +       KUNIT_EXPECT_LT(test, ret, 0);
> +}
> +
> +static const unsigned int drm_connector_hdmi_init_type_invalid_tests[] = {
> +       DRM_MODE_CONNECTOR_Unknown,
> +       DRM_MODE_CONNECTOR_VGA,
> +       DRM_MODE_CONNECTOR_DVII,
> +       DRM_MODE_CONNECTOR_DVID,
> +       DRM_MODE_CONNECTOR_DVIA,
> +       DRM_MODE_CONNECTOR_Composite,
> +       DRM_MODE_CONNECTOR_SVIDEO,
> +       DRM_MODE_CONNECTOR_LVDS,
> +       DRM_MODE_CONNECTOR_Component,
> +       DRM_MODE_CONNECTOR_9PinDIN,
> +       DRM_MODE_CONNECTOR_DisplayPort,
> +       DRM_MODE_CONNECTOR_TV,
> +       DRM_MODE_CONNECTOR_eDP,
> +       DRM_MODE_CONNECTOR_VIRTUAL,
> +       DRM_MODE_CONNECTOR_DSI,
> +       DRM_MODE_CONNECTOR_DPI,
> +       DRM_MODE_CONNECTOR_WRITEBACK,
> +       DRM_MODE_CONNECTOR_SPI,
> +       DRM_MODE_CONNECTOR_USB,
> +};
> +
> +KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_type_invalid,
> +                 drm_connector_hdmi_init_type_invalid_tests,
> +                 drm_connector_hdmi_init_type_desc);
> +
> +static struct kunit_case drmm_connector_hdmi_init_tests[] = {
> +       KUNIT_CASE(drm_test_connector_hdmi_init_valid),
> +       KUNIT_CASE(drm_test_connector_hdmi_init_null_ddc),
> +       KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_valid,
> +                        drm_connector_hdmi_init_type_valid_gen_params),
> +       KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_invalid,
> +                        drm_connector_hdmi_init_type_invalid_gen_params),
> +       { }
> +};
> +
> +static struct kunit_suite drmm_connector_hdmi_init_test_suite = {
> +       .name = "drmm_connector_hdmi_init",
> +       .init = drm_test_connector_init,
> +       .test_cases = drmm_connector_hdmi_init_tests,
> +};
> +
>  struct drm_get_tv_mode_from_name_test {
>         const char *name;
>         enum drm_connector_tv_mode expected_mode;
> @@ -236,6 +358,7 @@ static struct kunit_suite drm_get_tv_mode_from_name_test_suite = {
>  };
>
>  kunit_test_suites(
> +       &drmm_connector_hdmi_init_test_suite,
>         &drmm_connector_init_test_suite,
>         &drm_get_tv_mode_from_name_test_suite
>  );
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index fe88d7fc6b8f..4491c4c2fb6e 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1904,6 +1904,11 @@ int drmm_connector_init(struct drm_device *dev,
>                         const struct drm_connector_funcs *funcs,
>                         int connector_type,
>                         struct i2c_adapter *ddc);
> +int drmm_connector_hdmi_init(struct drm_device *dev,
> +                            struct drm_connector *connector,
> +                            const struct drm_connector_funcs *funcs,
> +                            int connector_type,
> +                            struct i2c_adapter *ddc);
>  void drm_connector_attach_edid_property(struct drm_connector *connector);
>  int drm_connector_register(struct drm_connector *connector);
>  void drm_connector_unregister(struct drm_connector *connector);
>
> --
> 2.43.0
>
