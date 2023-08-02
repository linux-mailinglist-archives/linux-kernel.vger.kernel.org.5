Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774AB76C943
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjHBJRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHBJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:17:05 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3E32D74
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:16:36 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7658752ce2fso416078285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690967795; x=1691572595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RqvQQdJp1hFdbPf4OMSlvaFhWgja7uGQCZmj+KNPJo=;
        b=WWYRFt6UWcgMzlZL5nC3JdxOCVTJWdxzp0Jxn+KUdVY2M25MT0FVMkmrj/SEp/wTRg
         Tr0AKXCZd1Z2T/qWRVdazVCF4NO3qllZzMyNQRZJgLTPiqX8VDxF5Af6o/xF6HEz0tHX
         Sa8uhIMgc46GeDVp2TSipQ7kXiW1+sfQSzYtC/J2AaomnjimbYgJiZJyP55T5NM+Rx3v
         Uxqr7WbFgFbefjxNkImg9rL5O3n4TiD4Gz0XA9yyiZv4OODGqqA1zGPjYMvApwWAOwOQ
         BQChS4H0f/MurUPwDccnGZzSNdeY6SaWa8CaL1odlR1rEiZsZ8JMXkZdDe68ABXNbJp4
         imhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690967795; x=1691572595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RqvQQdJp1hFdbPf4OMSlvaFhWgja7uGQCZmj+KNPJo=;
        b=HnOcKHEOSj6RttyuSgWaLP79mH5nky2lLYuzHf8IAbt1GKdr7h5VbNLnDbUF3ePsm6
         DCkXOCTZDjUxeoaI/CcBG6Ez9lLMkTI8tOBj2I56q+e1nKmyDbfW7pKw3a2CrHa/F9Bm
         LWWcrrSZUwVWVP//ujOBxSBr3qNv0KsQ84KZMSOEQZvCKeppbLxTobIh/IkW+9ZJMFhC
         0po4RMALUsjMXsnVkIF4DWs78LFegxePGUfSaMk+eMNoPLwBjpLresqTy9SPoy4MuOtR
         a61ZtdJLwy7nQwYcSy0cWOX0u6M5mAt9XSNcwzAUn1F9CbHIOL1KL3d7A/c+DkE9dqPg
         A+YA==
X-Gm-Message-State: ABy/qLbCiPSFS1ujM2wC1rPmBk5XidROwgnNGRmE2IMCPqNceOxKA35O
        KKowI00wag8vTuIIK68SauQCUwmFekzLP6ILAi+t/g==
X-Google-Smtp-Source: APBJJlHNhb6YQYwgaQkW+eQSgd89TWqGTpASPIjO4FBQatVAtmJ/oaGPRCiRuTtehzFZJx+nyEw7ycYC5dIh2IsESJI=
X-Received: by 2002:a0c:eace:0:b0:63c:fb87:625d with SMTP id
 y14-20020a0ceace000000b0063cfb87625dmr13972844qvp.3.1690967795200; Wed, 02
 Aug 2023 02:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
In-Reply-To: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 2 Aug 2023 14:45:59 +0530
Message-ID: <CAMi1Hd31A53-87EdnupZio_FCjgMRyPRxvsfzeY=q-iT=3qBfA@mail.gmail.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
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

On Wed, 2 Aug 2023 at 14:22, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> This reverts commit [1] to fix display regression on the Dragonboard 845c
> (SDM845) devboard.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

Regards,
Amit Pundir

>
> There's a mismatch on the real action of the following flags:
> - MIPI_DSI_MODE_VIDEO_NO_HSA
> - MIPI_DSI_MODE_VIDEO_NO_HFP
> - MIPI_DSI_MODE_VIDEO_NO_HBP
> which leads to a non-working display on qcom platforms.
>
> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
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
