Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A851581335F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjLNOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjLNOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:41:04 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB83D116
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:41:08 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ba1be5ad0aso2368320b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1702564868; x=1703169668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JznIu9lNlIeiTo8wKTcxQuhhJ2zgIwL8Q7gBCogBxvY=;
        b=mah02CWFDHeTmiEaZX6G5xe/jDGu/dsI/U6/A/xk/U36+pHEnHJrq/yhw989lBYSPl
         RkE+ESJTpVpO2bz/X5Bjal+8ng2BhIO66S7B0msbnamgmJtPZDE4Tkvx7+E/AnrvnCGD
         Z2l+DX+xC3zOYP1VMoDjWUVPlmNuVrqlzT1bCvOj6YiS87OV3WpZIHJ+s1hCNEMLjT9j
         bBYRzKDsnZBjPUaegfekdAi3A9kqXzDon7+67x0rLmMWMxt5G/HCD/If6rQFz/+ZsSkh
         RhcW2ZeNDIRofdXiyJ1PTW9O0AIcE2DIgJ62X1FnMwwIscXJfMfALRyqwumtWFtEkbCG
         ZhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564868; x=1703169668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JznIu9lNlIeiTo8wKTcxQuhhJ2zgIwL8Q7gBCogBxvY=;
        b=MnwJaIg3mnIko9r5cetaUs+JYxdWAvIGh0CsHwNUM8fCQP2RPZSWmrS3M7bNU7CnH0
         AMAS2OPSmHKY9yeKUuuEe+dt2/wfqgBYvKOSSZ4h8yZbfHAo8cu8Wv9L46yfMPqf1f27
         pCA+n85dFdbkQ3HI7GBSR9Rox3ocfuJiBCvMukMexcA45VZjARD7XCEE+f3eDq/hr5EF
         HQGx1s4lI8W3PLo+NnIouby8RuGEKeeog5+ypV5LiUPhF9VLNv8iU2ytBQMTUq4udUJG
         GewBg2/ArMBbDEKC9s0p7iW9uqT52p0xq2jMS39zdsW1NvWWE0jQUlF5sv+oyHh4MPYP
         x80Q==
X-Gm-Message-State: AOJu0YxUZmmRymMOEhav4aXJ//jBk5nY5Enf8GjTpgnCusv9Lw3PFrLu
        aP+lN8UpJR5wfIOGz+2pVUADAcFh5vhWreVQMyWhsw==
X-Google-Smtp-Source: AGHT+IH6Z7ttlPWqmsWbeFA/szWdyE6FZ1U9zu49mWSIzwza1ccFf3m2KxsdaL0W2oe0vmgh5g75w+m4VqHHxQxLixU=
X-Received: by 2002:a05:6808:140c:b0:3b9:ff46:fa9b with SMTP id
 w12-20020a056808140c00b003b9ff46fa9bmr12542705oiv.43.1702564868089; Thu, 14
 Dec 2023 06:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org> <20231207-kms-hdmi-connector-state-v5-7-6538e19d634d@kernel.org>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-7-6538e19d634d@kernel.org>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 14 Dec 2023 14:40:52 +0000
Message-ID: <CAPY8ntDT1X-2y7P-FAdw1CsT3SQuxCbfuhG6kPGR=v2KCnoQ8g@mail.gmail.com>
Subject: Re: [PATCH v5 07/44] drm/connector: hdmi: Create an HDMI sub-state
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

On Thu, 7 Dec 2023 at 15:50, Maxime Ripard <mripard@kernel.org> wrote:
>
> The next features we will need to share across drivers will need to
> store some parameters for drivers to use, such as the selected output
> format.
>
> Let's create a new connector sub-state dedicated to HDMI controllers,
> that will eventually store everything we need.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 35 +++++++++++++++++++++++++++++++
>  include/drm/drm_atomic_state_helper.h     |  4 ++++
>  include/drm/drm_connector.h               |  7 +++++++
>  3 files changed, 46 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 54975de44a0e..e69c0cc1c6da 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -570,6 +570,22 @@ void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
>
> +/**
> + * __drm_atomic_helper_connector_hdmi_reset() - Initializes all HDMI @drm_connector_state resources
> + * @connector: DRM connector
> + * @new_state: connector state to reset
> + *
> + * Initializes all HDMI resources from a @drm_connector_state without
> + * actually allocating it. This is useful for HDMI drivers, in
> + * combination with __drm_atomic_helper_connector_reset() or
> + * drm_atomic_helper_connector_reset().
> + */
> +void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
> +                                             struct drm_connector_state *new_state)
> +{
> +}
> +EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_reset);
> +
>  /**
>   * drm_atomic_helper_connector_tv_check - Validate an analog TV connector state
>   * @connector: DRM Connector
> @@ -619,6 +635,25 @@ int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_tv_check);
>
> +/**
> + * drm_atomic_helper_connector_hdmi_check() - Helper to check HDMI connector atomic state
> + * @connector: DRM Connector
> + * @state: the DRM State object
> + *
> + * Provides a default connector state check handler for HDMI connectors.
> + * Checks that a desired connector update is valid, and updates various
> + * fields of derived state.
> + *
> + * RETURNS:
> + * Zero on success, or an errno code otherwise.
> + */
> +int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
> +                                          struct drm_atomic_state *state)
> +{
> +       return 0;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_check);
> +
>  /**
>   * __drm_atomic_helper_connector_duplicate_state - copy atomic connector state
>   * @connector: connector object
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index b9740edb2658..d59d2b3aef9a 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -71,7 +71,11 @@ void __drm_atomic_helper_connector_state_reset(struct drm_connector_state *conn_
>  void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
>                                          struct drm_connector_state *conn_state);
>  void drm_atomic_helper_connector_reset(struct drm_connector *connector);
> +void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
> +                                             struct drm_connector_state *new_state);
>  void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
> +int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
> +                                          struct drm_atomic_state *state);
>  int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
>                                          struct drm_atomic_state *state);
>  void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 4491c4c2fb6e..000a2a156619 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1031,6 +1031,13 @@ struct drm_connector_state {
>          * DRM blob property for HDR output metadata
>          */
>         struct drm_property_blob *hdr_output_metadata;
> +
> +       /**
> +        * @hdmi: HDMI-related variable and properties. Filled by
> +        * @drm_atomic_helper_connector_hdmi_check().
> +        */
> +       struct {
> +       } hdmi;
>  };
>
>  /**
>
> --
> 2.43.0
>
