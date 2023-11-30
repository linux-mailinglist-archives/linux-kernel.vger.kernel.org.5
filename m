Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592387FE816
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344400AbjK3EDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjK3EDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:03:43 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A5D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:03:48 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cc642e4c69so5498807b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701317028; x=1701921828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jxl8V7SoUueHtisey+knlKp1RuXYZdbFzSs7V8BWyIE=;
        b=g3vZUl3OHu9f49CbbNcBR2wtWnRkeml0cMJ4vD6r6oUG8JXUrAhfz9vplKBRYw/QRS
         xs4GA+pUyNIOWkLLYzKTO/4QUfT/KKglMX04SoP46gV8AzGlNrYxF7n+LuV176/0FdR0
         BwuljykVSSstX4HsipCqYWTHFXH7Y7j//eDOsc4qr1DpikHCoh/lB41cgVA8Hv8K+M6A
         4yys0TocqXjQ7D38uH9LeEGCK5rFOglreC6BVdJySWCQhu4mdjjrKupwGDAcsGGSq6ve
         +AYsvlBtG129A8KWY4dYRzAB3fnlVgy3OZ3fKQUEDbiaMraWv3sx9PzX3UhdOBSaH2Pq
         KyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701317028; x=1701921828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jxl8V7SoUueHtisey+knlKp1RuXYZdbFzSs7V8BWyIE=;
        b=Boan/g4d2BsqNhhzody6oWEDv5pqRT42Cbtg1In2ExG0tNhtJeEYjziEAPQ/dLlTKg
         nPOVHKm9A7t2bVI3HcsSTXmYeyEKCDqbyvh/fq0dVflxSIqCHb1tKfHZKgl6XHLbqAA7
         wgMMTzetwGZwNaYKpqNrhoZnT5FzL7a4vcWrTNN11F/ZNWAtI5IipsaP+ox0dHpZGA61
         u6ymoE+ccpUcl2d0PTQgkC90nCE4/Wle4/5w1nQRRyLT7KAY4VUjSb5v2uRNW27jH0Hk
         5hFLxvCqxscVYoIu9J6JAnyJtdJ/rcbSULm9z3kw3okndhJ+gDZOyuguZ8zasGgZMrvi
         xEMw==
X-Gm-Message-State: AOJu0YwjpcSl2o7WY4jYZcAyiCNePcJmJgO/qvgiqf0txOaXi3fmiYDu
        31nojUdoTUMlXoGc60H9X/IIpE9Lta+5j3hqby1RhQ==
X-Google-Smtp-Source: AGHT+IEwWLHqph3JGgHycFzt1NMlSK3FF6ZkBFWeALtSzoO9O/ZiigKO6lVXvEx4s2H9Pp71up9RUvjDqtMEhNaWtmY=
X-Received: by 2002:a81:93c6:0:b0:5ca:71fe:4dbc with SMTP id
 k189-20020a8193c6000000b005ca71fe4dbcmr19556613ywg.49.1701317027922; Wed, 29
 Nov 2023 20:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com> <20231027-solid-fill-v7-2-780188bfa7b2@quicinc.com>
In-Reply-To: <20231027-solid-fill-v7-2-780188bfa7b2@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 30 Nov 2023 06:03:36 +0200
Message-ID: <CAA8EJpoKvufcKvkYCBY2XoLVkbdNK_O1TFEGe889ETXeqR=dpg@mail.gmail.com>
Subject: Re: [PATCH RFC v7 02/10] drm: Introduce solid fill DRM plane property
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Sebastian Wick <sebastian@sebastianwick.net>
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

On Sat, 28 Oct 2023 at 01:33, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> Document and add support for solid_fill property to drm_plane. In
> addition, add support for setting and getting the values for solid_fill.
>
> To enable solid fill planes, userspace must assign a property blob to
> the "solid_fill" plane property containing the following information:
>
> struct drm_mode_solid_fill {
>         u32 r, g, b, pad;
> };
>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
> Acked-by: Sebastian Wick <sebastian@sebastianwick.net>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c |  9 ++++++++
>  drivers/gpu/drm/drm_atomic_uapi.c         | 26 ++++++++++++++++++++++
>  drivers/gpu/drm/drm_blend.c               | 30 ++++++++++++++++++++++++++
>  include/drm/drm_blend.h                   |  1 +
>  include/drm/drm_plane.h                   | 36 +++++++++++++++++++++++++++++++
>  include/uapi/drm/drm_mode.h               | 24 +++++++++++++++++++++
>  6 files changed, 126 insertions(+)



-- 
With best wishes
Dmitry
