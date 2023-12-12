Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A7080EA95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjLLLki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLLLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:40:37 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA87CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:40:42 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db7d198e791so4126026276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1702381242; x=1702986042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0iUPBvo8eOmT//4vl8DQjGC5UmJmCx85Al5r4t/jUw0=;
        b=ADzG07U8MZzVm7biIm5aHAbXumTWnvHUl+oNS/+GIup3vnxEqT+ndCr41WZRAKQHHL
         ScGjPd0F//kXvvuN09xkgQ46CSKKxCcSTkyjNjjc/gbjFXel0YTWYvRL0AXJyZNH+EWj
         VJOLlU93T6a1pBTV3BngOZ/0jhoEfJLsqvMzRUC6+W+44Qi7X3Zb9WbuQji45MkMJfOu
         EoVS6oWEpNtc/MfXa/OfBQ0HnS7gO2BEP+098XWhJWkCpI3eKhTbzA7Fxdkitj7osKJi
         //BNLT1cZ4oly25Zk+wjbZ7raBvIiOwCgW6MQIyTvdo+mg2qgLbp4xYAd5PPoTs3yMq9
         dfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381242; x=1702986042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iUPBvo8eOmT//4vl8DQjGC5UmJmCx85Al5r4t/jUw0=;
        b=Yf2RdFJHqtBGR0HRhPpZimnBbBwet6Fzf6pjLlnrOtTUSNnPXAHvpbs+zA1EscLbdx
         bMijzsjEZlVPCZZ6GJ4T9iNkgdv3ZCH21ZuFzOlM07X8YXF9RBae6cuO8qplv6oJjR+P
         i/CtX+3pYkjFkDFPd6xs2rE12FeqqHMglSLJ87odcW6qVpuIH9krJAgefkxTXTMvJF7P
         YvIqATQhkvogvc8ZNk+C/hOUnI2fetZjN9Sp2MRMfjS39dHWup/h6UqfQmFbQCXeXnW8
         7JbrOZkgluaRBStp58UPlHx3r0q5pSvc1gyWY4nBEz5zXoprct5ENZmZy/px3LLjyN8A
         BLgw==
X-Gm-Message-State: AOJu0YxDyQh0nkJJhpKu+yMQbgOu+l827JvxwO4stgIuSARByElfPLHx
        dLFjtZBrimYj4ZvqmpE14Ooz7lLsYGMvhwprIWbtHW1invOEQxB1
X-Google-Smtp-Source: AGHT+IGkFxJXB+75F7npYS3Sl7fcGotb27eRrk6u5Q+tryG0nLGLjgw4n/C3z2I9FmEbcpAIdKRvpPS2VqJqFmY8cyo=
X-Received: by 2002:a25:ce8a:0:b0:db5:47ee:47c4 with SMTP id
 x132-20020a25ce8a000000b00db547ee47c4mr2442389ybe.53.1702381242014; Tue, 12
 Dec 2023 03:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org> <20231207-kms-hdmi-connector-state-v5-18-6538e19d634d@kernel.org>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-18-6538e19d634d@kernel.org>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 12 Dec 2023 11:40:26 +0000
Message-ID: <CAPY8ntBe9RfSjdnd5Smx23La5gQaR9WqY8ehXQyp=4D_11N55Q@mail.gmail.com>
Subject: Re: [PATCH v5 18/44] drm/vc4: hdmi: Create destroy state implementation
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
> Even though we were rolling our own custom state for the vc4 HDMI
> controller driver, we were still using the generic helper to destroy
> that state.
>
> It was mostly working since the underlying state is the first member of
> our state so the pointers are probably equal in all relevant cases, but
> it's still fragile so let's fix this properly.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 25c9c71256d3..f05e2c95a60d 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -672,11 +672,21 @@ vc4_hdmi_connector_duplicate_state(struct drm_connector *connector)
>         return &new_state->base;
>  }
>
> +static void vc4_hdmi_connector_destroy_state(struct drm_connector *connector,
> +                                            struct drm_connector_state *state)
> +{
> +       struct vc4_hdmi_connector_state *vc4_state =
> +               conn_state_to_vc4_hdmi_conn_state(state);
> +
> +       __drm_atomic_helper_connector_destroy_state(state);
> +       kfree(vc4_state);
> +}
> +
>  static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
>         .fill_modes = drm_helper_probe_single_connector_modes,
>         .reset = vc4_hdmi_connector_reset,
>         .atomic_duplicate_state = vc4_hdmi_connector_duplicate_state,
> -       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +       .atomic_destroy_state = vc4_hdmi_connector_destroy_state,
>         .atomic_get_property = vc4_hdmi_connector_get_property,
>         .atomic_set_property = vc4_hdmi_connector_set_property,
>  };
>
> --
> 2.43.0
>
