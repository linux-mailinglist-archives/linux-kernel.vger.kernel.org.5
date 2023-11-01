Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950237DE788
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbjKAVgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjKAVgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:36:42 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F844120;
        Wed,  1 Nov 2023 14:36:36 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso162487fac.0;
        Wed, 01 Nov 2023 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698874595; x=1699479395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzeWTgZIZ83OtuqSWokoE3B69bPXrO05k5OrT4HO0NY=;
        b=cR0tWBZFAfZVJ1As6fccsiRW7OpponvgbO2TqgFJ9jSqhe3m9EcjD4pNccaUihIZ3g
         sTCnVbRwJ7KKBADPAM1RfubBjNZLv+9+iopTi6JnnGfk8BDTsfgK10NKC/Cm4Op92VLz
         kaxql7fD9uaPLv85bAkB84mIH6XSnLC3M0CanWy+5ZTqPnepiGA5fJMvyaUtzvXlGhaM
         ztvk/PPT3YVIFcJVHb6+4u3MqKVIeqEDSsXmYhyR197xZfXuo6fldzpbA/25/dIRdV8l
         mrOcqN37DUiZwC5ehw7o6Em2cuWaAUgGBBl2BBdX9BIVJsJnYPfvYmUT3MWesTUrqzBj
         d+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698874595; x=1699479395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzeWTgZIZ83OtuqSWokoE3B69bPXrO05k5OrT4HO0NY=;
        b=tKlhikUL3TlKQvHadpvAp/UN0gHTiw44bPN4ZV58/oZ6wadJe8KAXHTVXORsuJzZBk
         tb/4EMLX0gHBNrrzWvAl+caUog+TfFfCp0yU+7EskxoGFWicqwOP81/490yVal5I5qgX
         pKYzSRghVtfxTIjUrxJiDO8ZN7pJkpz8Ohamj411T9roxPm53ft5C/gFvIsWIz2gVsTO
         NslVI1ZZKPMYpfFGWHo84L8z1106iMcbDPGbHBO8Wp6G1MenOGwcSFlN0xcXFuB9+8/w
         ERH8MteDPTH05zEGLRx38kwq/U9IrMvGWydiXoxn8aNUVm+lz8RAy8APnWyvLVAZ/nPA
         ckHg==
X-Gm-Message-State: AOJu0YwaYJRO7CR6xHlcK3xDkPqdMwkWzTAK/oUAOREXNLia6dBBOSgt
        jwkuCv9zuK+ESXky3+XlKVxKC9DPYriveCIqnqc=
X-Google-Smtp-Source: AGHT+IGVaW7xWUNgn6WGaMiP138/xSb7/M1aRCKqX5RPCLQjltubi4nNgmznGdjRFlY6UmtBEOIaKOjSpBWCTg7AsRA=
X-Received: by 2002:a05:6871:60d:b0:1e9:88e0:b8ba with SMTP id
 w13-20020a056871060d00b001e988e0b8bamr2121816oan.29.1698874595339; Wed, 01
 Nov 2023 14:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231101210037.130494-1-hamza.mahfooz@amd.com>
In-Reply-To: <20231101210037.130494-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Nov 2023 17:36:24 -0400
Message-ID: <CADnq5_Nv0MnG+pPvRQO37OP8iYwz8oGvFLs2g-+U=URHWcqJGw@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: add a quirk for two 240Hz Samsung monitors
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jerry Zuo <jerry.zuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 5:01=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.com=
> wrote:
>
> Without this fix the 5120x1440@240 timing of these monitors
> leads to screen flickering.
>
> Cc: stable@vger.kernel.org # 6.1+
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1442
> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 47 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index bca2af4fe1fc..3fdb8907f66b 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -89,6 +89,8 @@ static int oui(u8 first, u8 second, u8 third)
>  #define EDID_QUIRK_NON_DESKTOP                 (1 << 12)
>  /* Cap the DSC target bitrate to 15bpp */
>  #define EDID_QUIRK_CAP_DSC_15BPP               (1 << 13)
> +/* Fix up a particular 5120x1440@240Hz timing */
> +#define EDID_QUIRK_FIXUP_5120_1440_240         (1 << 14)

What is wrong with the original timing that needs to be fixed?

Alex


>
>  #define MICROSOFT_IEEE_OUI     0xca125c
>
> @@ -170,6 +172,12 @@ static const struct edid_quirk {
>         EDID_QUIRK('S', 'A', 'M', 596, EDID_QUIRK_PREFER_LARGE_60),
>         EDID_QUIRK('S', 'A', 'M', 638, EDID_QUIRK_PREFER_LARGE_60),
>
> +       /* Samsung C49G95T */
> +       EDID_QUIRK('S', 'A', 'M', 0x7053, EDID_QUIRK_FIXUP_5120_1440_240)=
,
> +
> +       /* Samsung S49AG95 */
> +       EDID_QUIRK('S', 'A', 'M', 0x71ac, EDID_QUIRK_FIXUP_5120_1440_240)=
,
> +
>         /* Sony PVM-2541A does up to 12 bpc, but only reports max 8 bpc *=
/
>         EDID_QUIRK('S', 'N', 'Y', 0x2541, EDID_QUIRK_FORCE_12BPC),
>
> @@ -6586,7 +6594,37 @@ static void update_display_info(struct drm_connect=
or *connector,
>         drm_edid_to_eld(connector, drm_edid);
>  }
>
> -static struct drm_display_mode *drm_mode_displayid_detailed(struct drm_d=
evice *dev,
> +static void drm_mode_displayid_detailed_edid_quirks(struct drm_connector=
 *connector,
> +                                                   struct drm_display_mo=
de *mode)
> +{
> +       unsigned int hsync_width;
> +       unsigned int vsync_width;
> +
> +       if (connector->display_info.quirks & EDID_QUIRK_FIXUP_5120_1440_2=
40) {
> +               if (mode->hdisplay =3D=3D 5120 && mode->vdisplay =3D=3D 1=
440 &&
> +                   mode->clock =3D=3D 1939490) {
> +                       hsync_width =3D mode->hsync_end - mode->hsync_sta=
rt;
> +                       vsync_width =3D mode->vsync_end - mode->vsync_sta=
rt;
> +
> +                       mode->clock =3D 2018490;
> +                       mode->hdisplay =3D 5120;
> +                       mode->hsync_start =3D 5120 + 8;
> +                       mode->hsync_end =3D 5120 + 8 + hsync_width;
> +                       mode->htotal =3D 5200;
> +
> +                       mode->vdisplay =3D 1440;
> +                       mode->vsync_start =3D 1440 + 165;
> +                       mode->vsync_end =3D 1440 + 165 + vsync_width;
> +                       mode->vtotal =3D 1619;
> +
> +                       drm_dbg_kms(connector->dev,
> +                                   "[CONNECTOR:%d:%s] Samsung 240Hz mode=
 quirk applied\n",
> +                                   connector->base.id, connector->name);
> +               }
> +       }
> +}
> +
> +static struct drm_display_mode *drm_mode_displayid_detailed(struct drm_c=
onnector *connector,
>                                                             struct displa=
yid_detailed_timings_1 *timings,
>                                                             bool type_7)
>  {
> @@ -6605,7 +6643,7 @@ static struct drm_display_mode *drm_mode_displayid_=
detailed(struct drm_device *d
>         bool hsync_positive =3D (timings->hsync[1] >> 7) & 0x1;
>         bool vsync_positive =3D (timings->vsync[1] >> 7) & 0x1;
>
> -       mode =3D drm_mode_create(dev);
> +       mode =3D drm_mode_create(connector->dev);
>         if (!mode)
>                 return NULL;
>
> @@ -6628,6 +6666,9 @@ static struct drm_display_mode *drm_mode_displayid_=
detailed(struct drm_device *d
>
>         if (timings->flags & 0x80)
>                 mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> +
> +       drm_mode_displayid_detailed_edid_quirks(connector, mode);
> +
>         drm_mode_set_name(mode);
>
>         return mode;
> @@ -6650,7 +6691,7 @@ static int add_displayid_detailed_1_modes(struct dr=
m_connector *connector,
>         for (i =3D 0; i < num_timings; i++) {
>                 struct displayid_detailed_timings_1 *timings =3D &det->ti=
mings[i];
>
> -               newmode =3D drm_mode_displayid_detailed(connector->dev, t=
imings, type_7);
> +               newmode =3D drm_mode_displayid_detailed(connector, timing=
s, type_7);
>                 if (!newmode)
>                         continue;
>
> --
> 2.42.0
>
