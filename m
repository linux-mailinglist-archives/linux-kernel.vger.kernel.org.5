Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A49D80E921
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjLLK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjLLK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:29:06 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E02D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:29:12 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c6734e0c22so2683587a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702376951; x=1702981751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHmbx/TAJnGNEEz0o7g8cBj5c1EY3ZNmozjuVxS5uaw=;
        b=Zc3mT6EOiFdPj3Aou0tS5NxRXcidukYZ0EFefyByswGqZrCwliUDrqIVXGvccLxdJ9
         h6h5BxX+RFzeRBoNZsvk8BKFdTT8uigLF1QZ8+2TIYpD94AgW2Uv2MEggTdYgW2B0fxO
         G+GS5979ohcYNnF3eSOJhGQhamHnJoQj8eEAA4GTloMUXTWgFwqDLVEZP13ckbgEmvqc
         DYg9wvdNruH9YBWe32Zc+YBEkjXAVkJiwlPGn++Noy0tFp5XIxUPzdfj4V3GNegKnqrt
         jU1prFXQcyK48MwcJ1JSbC8U0jOdJgR6h2o6fTsCP4OPbB/t7CXeC4YmT+E0s9+5UfSW
         1Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376951; x=1702981751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHmbx/TAJnGNEEz0o7g8cBj5c1EY3ZNmozjuVxS5uaw=;
        b=iUbnPyCdOAFiI29B0FuFaQh5+mqB6HnthxiBNwk7zl+HOJr+lYvuTiZTWly588s9mg
         xSd97R5MR1q8oLqXBLWNeb36kr+x4JdEhniacxxfnRSLXGT2W/70XWSy0k6mWr7i8ZA/
         EqFmTOwWZwVGAsXKiKu4ve3MRgRFNoSb3ChxfW9Ij6QZnC5tdhfIcoGxGttUplQnlcbk
         BV2/ULjnlqUaxUVcFptDRjPFvAU3Li/QXWWmp9kQ+pEg/iM333Jbv+gzP4gkHzznE2vs
         aiS0bHgL6abXDfUXbpjl1GO3JRDdEtH7UgSuzcnPgQdRv9ghWJDyYPcdEE+Hd9RwGEWc
         IM5Q==
X-Gm-Message-State: AOJu0YzLV06+QvI+wqovdEbbqiVld0fZIh/7dSgDx8InkXnxFVtDxP0o
        v9Vllgfo4q5HBFw7uAGMaEHh11AEoHRvjdbtLe8=
X-Google-Smtp-Source: AGHT+IE48kxlzdKD3yLytlZEb4kSrO2sHIRT3ZAoG2MXpUlCf7iBAfbi5OAjmRU9iIoXDqrpN6Spq6yjmg/XfwEqDd4=
X-Received: by 2002:a17:90a:8a0e:b0:286:a944:abb2 with SMTP id
 w14-20020a17090a8a0e00b00286a944abb2mr2532263pjn.20.1702376951377; Tue, 12
 Dec 2023 02:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20231212033259.189718-1-aford173@gmail.com> <20231212033259.189718-2-aford173@gmail.com>
In-Reply-To: <20231212033259.189718-2-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 12 Dec 2023 04:29:00 -0600
Message-ID: <CAHCN7xJC_+0uHa1_ODXLjEXAL-S2hZWr-GBPATQ_BBZaY2c4_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 9:33=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> When using video sync pulses, the HFP, HBP, and HSA are divided between
> the available lanes if there is more than one lane.  For certain
> timings and lane configurations, the HFP may not be evenly divisible.
> If the HFP is rounded down, it ends up being too small which can cause
> some monitors to not sync properly. In these instances, adjust htotal
> and hsync to round the HFP up, and recalculate the htotal.
>

For anyone who's following this,  I added a note which I apparently
forgot to save:

This adds support for 720p60 in the i.MX8M Plus.

NXP uses a look-up table in their downstream code to accomplish this.
Using this calculation, the driver can adjust without the need for a
complicated table and should be flexible for different timings and
resolutions depending on the monitor.

I don't have a DSI analyzer, and this appears to only work on
i.MX8M Plus but not Mini and Nano for some reason, despite their
having a similar DSI bridge.

When Frieder teste this, he reported no changes on the Kontrol BL
i.MX8MM:   "So at least there is no negative impact in this case"


If someone else has an i.MX8MP, I would appreciate any feedback.

thanks

adam

> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.=
MX8MM with HDMI monitor
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 239d253a7d71..f5795da1d8bb 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1628,6 +1628,27 @@ static int samsung_dsim_atomic_check(struct drm_br=
idge *bridge,
>                 adjusted_mode->flags |=3D (DRM_MODE_FLAG_PHSYNC | DRM_MOD=
E_FLAG_PVSYNC);
>         }
>
> +       /*
> +        * When using video sync pulses, the HFP, HBP, and HSA are divide=
d between
> +        * the available lanes if there is more than one lane.  For certa=
in
> +        * timings and lane configurations, the HFP may not be evenly div=
isible.
> +        * If the HFP is rounded down, it ends up being too small which c=
an cause
> +        * some monitors to not sync properly. In these instances, adjust=
 htotal
> +        * and hsync to round the HFP up, and recalculate the htotal. Thr=
ough trial
> +        * and error, it appears that the HBP and HSA do not appearto nee=
d the same
> +        * correction that HFP does.
> +        */
> +       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lane=
s > 1) {
> +               int hfp =3D adjusted_mode->hsync_start - adjusted_mode->h=
display;
> +               int remainder =3D hfp % dsi->lanes;
> +
> +               if (remainder) {
> +                       adjusted_mode->hsync_start +=3D remainder;
> +                       adjusted_mode->hsync_end   +=3D remainder;
> +                       adjusted_mode->htotal      +=3D remainder;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.40.1
>
