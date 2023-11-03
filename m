Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAF97E0618
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjKCQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbjKCQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:02:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F274D5E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:02:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso4496829a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699027367; x=1699632167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=griz2BFiZEJVkDOK8xMpjXUbb64ilzQ2lF7lpZbQxN0=;
        b=j3N95xsDCKCm5EhcBxmIUweN7uE+YyX4rjkyaJP8bxvZCo+m/L0gXiWq3mE8gS/SQw
         fZIe2YFZuxYv3vt1fgSkQews/XpAmKlcPL3N+Fjf0GRmnW1aTfuOuIiFETLtnddUr7E6
         iqQdkd42WmMifJRPRRUIdxf4DJY1QnTs9yRec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027367; x=1699632167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=griz2BFiZEJVkDOK8xMpjXUbb64ilzQ2lF7lpZbQxN0=;
        b=FuyZPfezqDfBaHMLr0lCmYhFGre44vRdDa58DUua+R9XZgiKMi7UDH4Uuuu+jfK97K
         mP0NQRXTx3SYWy9n+dlq72kMcXLFwr3SujjUFNkn4PKNpK4Ta1poz/BEtRifj5DE69mc
         BP+3u9zJ9GZIFIaJRdAMvDojAZZ+n4Ofcy+BBjTJqFjm7X0ZYas1Fc2uSFV3HpASeXbU
         z3CW2xlxIkqSJ9on1L6CTkM4nkpRs71b7xbzwDiy4eVR8iwyPkkgkUslDnmqcY1mKb76
         vhPCtPoBqtTMhWJm1+9C8vpD8cNRLbJHb/iSCjOQImT/ih9JZpBvfXzLEE7NvZt2y/87
         CIYg==
X-Gm-Message-State: AOJu0YzJyM/VovtvGE7IwYckSY+A6nUD82V1F7Snkj0qMBDIoRMvaYtb
        4VpJp9GlvdIHU3QZ4AF0IbvBi3oS/ZQp8zHmiIx+1TSs
X-Google-Smtp-Source: AGHT+IH0lr/7TfL1oRdr/fa5/q+WQN7rDrfKL+5IbynpQR4wHPsw7aqXW3dDh42B+fxQ3X/UwNeMRA==
X-Received: by 2002:a50:d648:0:b0:543:d8c0:d34f with SMTP id c8-20020a50d648000000b00543d8c0d34fmr2684308edj.20.1699027366504;
        Fri, 03 Nov 2023 09:02:46 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7d613000000b00537666d307csm1091296edr.32.2023.11.03.09.02.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 09:02:46 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40837124e1cso95555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:02:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1c26:b0:404:74f8:f47c with SMTP id
 j38-20020a05600c1c2600b0040474f8f47cmr179376wms.5.1699027365615; Fri, 03 Nov
 2023 09:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231102221309.1971910-1-hsinyi@chromium.org> <20231102221309.1971910-4-hsinyi@chromium.org>
In-Reply-To: <20231102221309.1971910-4-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Nov 2023 09:02:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUNdSzppccDO=y0iu_QR8nEe3poRLMmWvFMfZsnWZo4A@mail.gmail.com>
Message-ID: <CAD=FV=VUNdSzppccDO=y0iu_QR8nEe3poRLMmWvFMfZsnWZo4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/modes: Add a function to clear preferred modes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> Add a function to clear the preferred bit of a connector's existing modes=
.
> This is useful for edp panel to unset the preferred modes read from edid
> if the panel has hard-coded modes.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v1->v2:
> - fix doc string (reported by kernel test robot).
> - split mode and panel patches.
> ---
>  drivers/gpu/drm/drm_modes.c | 16 ++++++++++++++++
>  include/drm/drm_modes.h     |  1 +
>  2 files changed, 17 insertions(+)

This seems fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Since it introduces a new API to the core and Hsin-Yi and I work
directly together, I'd probably give this ~2 weeks on the list before
landing so there is adequate time for people to comment. That'll be
right in the middle of Plumbers, though, so it might be more like 3
weeks. If someone non-ChromeOS wants to review and/or apply sooner, I
certainly wouldn't object.
