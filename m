Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ABA76C8FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjHBJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjHBJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:08:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638CC2D4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:08:48 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d0728058651so6772382276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690967327; x=1691572127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V4JyHfiibRFYZGtLi4yuv7+iKXcqBb0CdEPjLP4kQ2Y=;
        b=l53X+3415Ye0gUqITzWhdICHp8ql0L5zj2ofJ39sRbUcud8MnyMZgGmPl7PPDknW7W
         ZxxoEPUuMBdk17JHUt9HX5v15+ccj7h0e+yFcA20u3XLYNfHLw8clpq7ZEw1ygK7+gYA
         0qo1CTVGDJucmA/jBxri1xVKFYadOCd19EX/h3qGuuk650EaC07c55xddL1cseC34KoZ
         sS/QblvBhHmXAHjRYALBlqOroSPVF7k0gmUu7ZG7TRnK+iHHZQk7S5SnJwxBvhvI1Mqi
         aru1yuNg+DHksd06u6DZcaU3JyqWm4/Z9cf0lSPrBGDnAMT2Gr88QDLjI0cEJamW80t5
         +vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690967327; x=1691572127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4JyHfiibRFYZGtLi4yuv7+iKXcqBb0CdEPjLP4kQ2Y=;
        b=AeVVbo4GkhVi5ieBrMKfK72z9h7eVelNShSOBmu/Dl3wualPk7snlQf47Jln46ZI6C
         L94dXG2PGOsdli94O3KaY7TnV8BI9CjU/u9UPEeTzmS3tFxyldkPPVX7Vjamz9B0TgoU
         3CVLMBci89swnQpDulGL0YpjHzdFQUIq8lYPJXQXkL1NvcjgeZve7QePVfOwiacbTqvD
         GQGtFdyOn2ox7Cfipb7o27YgborrvLBUbmyAAJFuBgG2bGHg04uFgHFZyN2q8AsA9K0G
         YC0sbvK+tZIVTiiWjXYIILf7i93x4L3FbIA7ThCmFpi0QV+nC/g+mMWaK4GdO1XxG9C3
         EjuQ==
X-Gm-Message-State: ABy/qLZ6MrMVt1qSjPFZQYVv6+fGfPcDa7Qtk5LgTk6O3s7dUz5GyxaK
        ZdzkrglirdSp7uZ4JGd2EWxcUSuUkPlUX3XngjJfUg==
X-Google-Smtp-Source: APBJJlFAfrBBrLo31ENsKKGz80A86bC7eYZ0qRII1yo+K9xeF/aUOlOrLSstsENHwHA6hSEg+zwlHKiH/6hRv+kDKhg=
X-Received: by 2002:a25:ac42:0:b0:d15:cbbb:d44a with SMTP id
 r2-20020a25ac42000000b00d15cbbbd44amr16311636ybd.42.1690967326014; Wed, 02
 Aug 2023 02:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
In-Reply-To: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 2 Aug 2023 12:08:35 +0300
Message-ID: <CAA8EJportnT-xHFH8QP+aiomXMLbm1r=02HMB-eNDEU+JqgEoQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 11:52, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> This reverts commit [1] to fix display regression on the Dragonboard 845c
> (SDM845) devboard.
>
> There's a mismatch on the real action of the following flags:
> - MIPI_DSI_MODE_VIDEO_NO_HSA
> - MIPI_DSI_MODE_VIDEO_NO_HFP
> - MIPI_DSI_MODE_VIDEO_NO_HBP
> which leads to a non-working display on qcom platforms.
>
> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")

Nit: I think the preferred form is to write `... reverts commit abcdef
("foo and bar")', but I might be wrong.

Other than that:

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Link: https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index 5163e5224aad..9663601ce098 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -774,9 +774,7 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
>         dsi->lanes = 4;
>         dsi->format = MIPI_DSI_FMT_RGB888;
>         dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> -                         MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
> -                         MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> -                         MIPI_DSI_MODE_NO_EOT_PACKET;
> +                         MIPI_DSI_MODE_VIDEO_HSE;
>
>         ret = devm_mipi_dsi_attach(dev, dsi);
>         if (ret < 0) {
>
> ---
> base-commit: f590814603bf2dd8620584b7d59ae94d7c186c69
> change-id: 20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-6f042b1ba813
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>


-- 
With best wishes
Dmitry
