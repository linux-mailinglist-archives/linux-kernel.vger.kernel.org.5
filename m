Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A910078E090
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbjH3UZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbjH3UZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:25:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88745B38
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:00:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500b66f8b27so362535e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693425580; x=1694030380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFxy/5km8F3IE+PzA+aM3e4Lk7VngPbyZnO7tUwI/KY=;
        b=WkScFHhBr8ZQDgUrCVnomqd3irdtaG7IdW6Du0WmvD/FOCPcv4l+JrCDWJicJAUaZZ
         lcwSD/1Pk33BaH20D5R1aFBktomv6xhBHx7DXOoSmiVnyJEIMu/fkp4NlZh7xEsu+g2G
         l+tlV2c18xMXEfH+nx6Or4UiQcBp0rliy9CeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693425580; x=1694030380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFxy/5km8F3IE+PzA+aM3e4Lk7VngPbyZnO7tUwI/KY=;
        b=X6yv1zZOGLjJBqlEC+vs+S0oFua8Pp6gNUD1ShM/n6LU7QXM2h6+V2wl4JYeW04viS
         Rij/ZvviigAkYc5JElYdLCFtuRh4isJLwvylnAN6ODnx7GtIzgmlrRZtjwzNEOuIpYxx
         GlSEL+Hh7QAeNw0WT6Len61RUgd5erRhCqoTBZlpIndipi18fVTOn7KbLC1P6vhc5b2U
         /InciJvUmnYswd0FwzdhgXRvbt0z2VOGF/Ryi1TuhMpQokwlI+mM3dbcxUPK6d0GhvlQ
         L8S4iyOUhzVcsAA5eiJyUBPJTnoT99NHLp71oOTR//Wgiv07C+Z0hBbx1Q27qgik4Gk/
         UD1A==
X-Gm-Message-State: AOJu0YxaJAb9QcUwNE1WOehTuK37Rpj0giWlFZl0kQgaCCbfdzNxdQxU
        i7phmkCEftulA5bE3F5HXxJ84SeR2tjW0UyMZQsOGmRk
X-Google-Smtp-Source: AGHT+IHxGX3WpcSKeFcwwEXS3uST8v/+wu2CfP8xCvYSCD7CY+49ZrOzLeNwiy8HrW92/kQKLEBP1A==
X-Received: by 2002:a05:6512:749:b0:500:bc14:3e06 with SMTP id c9-20020a056512074900b00500bc143e06mr1948585lfs.44.1693425579710;
        Wed, 30 Aug 2023 12:59:39 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id z1-20020ac25de1000000b004fbdba4b075sm2494961lfq.57.2023.08.30.12.59.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 12:59:39 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so893e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:59:39 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:400:c6de:6a20 with SMTP id
 fj15-20020a05600c0c8f00b00400c6de6a20mr23687wmb.3.1693425105614; Wed, 30 Aug
 2023 12:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230830170819.309269-1-biju.das.jz@bp.renesas.com> <20230830170819.309269-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230830170819.309269-3-biju.das.jz@bp.renesas.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 12:51:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=USEXGTEYNLQaQX+fzn0AifZTEMwkNSZCncF0ORu2q1Xw@mail.gmail.com>
Message-ID: <CAD=FV=USEXGTEYNLQaQX+fzn0AifZTEMwkNSZCncF0ORu2q1Xw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] drm/bridge: Drop conditionals around of_node pointers
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 30, 2023 at 10:08=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.c=
om> wrote:
>
> The commit c9e358dfc4a8 ("driver-core: remove conditionals around
> devicetree pointers") supposed to remove conditionals around of_node
> pointer, but it missed out drm/bridge.h. So drop #if conditionals by
> adding struct device_node forward declaration.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5:
>  * Split from patch#2
>  * Updated commit description
>  * Added struct device_node forward declaration.
> ---
>  include/drm/drm_bridge.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
