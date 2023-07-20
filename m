Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6075A7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGTHbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjGTHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:31:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674102684
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:31:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso690167e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689838258; x=1690443058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLpdS0nzS/H8+/h/goVnv+WGk0clAZf3NPIfiJp71qw=;
        b=HncJdPIMTX+qaBUzG5i7VRrv3rlQHnfotrPx77BG6Hos32iVEoRSfuqxZeQP0171dj
         ykH5K9ZhNSOvXRruKTEh95RBW7AO8GfX0bkO4yiwXe3YWtex88q/JArnx6WoZ/qN8ty0
         TwA28LqoAeJhPXIszAbArFSNQW7m4/Tx8ladtFdzd8w1JzwqHxvNA8OpEoacz2L/JPGC
         Db2+PuchclXWyfm+5CokonBKeA0oI4ppi2gj240FEX6Mdz0lluzwJTHf+6uIbvmEv1pi
         wWDs/OQi26gG8guKVQkN2kiVsoZ+Cb5ejFsLcAGM/i9W2W9y3ujgJIpOC4eEhzYxwn09
         RGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689838258; x=1690443058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLpdS0nzS/H8+/h/goVnv+WGk0clAZf3NPIfiJp71qw=;
        b=a5wK9AriwWH+ZPnYsz5o4QNlYxzfPQRKQmpxlngolrzZcraxJRB305jqL4KhcmMDXt
         ZiMURFzkxMiaIJRLYbx3ttCD9JLRKrQLFcI9AWKoC9w4OzLQ4jfdAiw7L+CAhrt0fJRZ
         5QzPzE9B84ygTou+4Co7Wq1N7wnGpqm38j/ms1BxGO+YNOxFGHleZXtQ0eo0fCGl5+Ar
         FAnamklFdLtItX/XiOBiYJgDDpOwittlXwxWC4jVrZN/H5SFpm/l+Fnx5zO7SXGp51zH
         lKw1Yo0N7CP2bPVnBjwJS+XBuHxic3wlJB2y2Q04hEaeMrZorAHJ8yEC/K32/1GLuwwi
         ECQQ==
X-Gm-Message-State: ABy/qLbsqiKhDXw4axOnXJ9r9BYRVRjx1WiaE8NUGTq8+fT7QEjhVCiT
        9A5JnGlJSugfaPaG2QehyQoT0+PD1HQWuw2scVThrD1VOZzZMz9k2S8=
X-Google-Smtp-Source: APBJJlFAiH/JoVFj0bMzbBtL7BPWkJik1Ym14XHd5gxOagEWC7ViCtUOB6qhZPnenQP/Nkl28TyhGjZUeoHXeOR3oaI=
X-Received: by 2002:a2e:924b:0:b0:2b6:d5af:1160 with SMTP id
 v11-20020a2e924b000000b002b6d5af1160mr1285758ljg.28.1689838258061; Thu, 20
 Jul 2023 00:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190716131005.761-1-bogdan.togorean@analog.com> <20230719060143.63649-1-alex@shruggie.ro>
In-Reply-To: <20230719060143.63649-1-alex@shruggie.ro>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Thu, 20 Jul 2023 10:30:46 +0300
Message-ID: <CAH3L5QqJ_VgS=_95WOK9-yj6dr1Qmkjyb_MNAjBgkgfxu3vW3g@mail.gmail.com>
Subject: Re: [PATCH v4] drm: adv7511: Fix low refresh rate register for ADV7533/5
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     bogdan.togorean@analog.com, nuno.sa@analog.com, daniel@ffwll.ch,
        airlied@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, rfoss@kernel.org,
        neil.armstrong@linaro.org, andrzej.hajda@intel.com,
        festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 9:02=E2=80=AFAM Alexandru Ardelean <alex@shruggie.r=
o> wrote:
>
> From: Bogdan Togorean <bogdan.togorean@analog.com>
>
> For ADV7533 and ADV7535 low refresh rate is selected using
> bits [3:2] of 0x4a main register.
> So depending on ADV model write 0xfb or 0x4a register.
>
> Fixes: 2437e7cd88e8 ("drm/bridge: adv7533: Initial support for ADV7533")
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---

Right.
I forgot a changelog here.
Apologies

Changelog v3 -> v4:
* Ran ./scripts/checkpatch.pl --strict
* Added Reviewed-by: Robert Foss <rfoss@kernel.org>

Changelog v2 -> v3:
* https://lore.kernel.org/dri-devel/1c3fde3a873b0f948d3c4d37107c5bb67dc9f7b=
b.camel@gmail.com/T/#u
* Added my S-o-b tag back

Changelog v1 -> v2:
* https://lore.kernel.org/dri-devel/20190716131005.761-1-bogdan.togorean@an=
alog.com/
* added Fixes: tag
* added Reviewed-by: tag for Nuno


>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index ddceafa7b637..8d6c93296503 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511=
,
>         else
>                 low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_NONE;
>
> -       regmap_update_bits(adv7511->regmap, 0xfb,
> -               0x6, low_refresh_rate << 1);
> +       if (adv7511->type =3D=3D ADV7511)
> +               regmap_update_bits(adv7511->regmap, 0xfb,
> +                                  0x6, low_refresh_rate << 1);
> +       else
> +               regmap_update_bits(adv7511->regmap, 0x4a,
> +                                  0xc, low_refresh_rate << 2);
> +
>         regmap_update_bits(adv7511->regmap, 0x17,
>                 0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
>
> --
> 2.41.0
>
