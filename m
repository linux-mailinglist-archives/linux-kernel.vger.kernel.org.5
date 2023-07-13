Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF757525AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGMOyQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGMOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:54:14 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9F319B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:54:13 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-cabf1dbafc4so759684276.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260052; x=1691852052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QVCqYOG8VAURqceBDpWKjPxyj1fgO2WW9WWrQCQVBU=;
        b=JBxNurmli4cefIssW3RidoUNrUBIPS6jPj/tqCUEZE/5gV7Yt5SVw2F4s2Qougn0sL
         ehUJ4z/aEh4Wl6zr/tz/dDNFi6aNFvfMAqlc0htjV1F1hskfq20XTdCbCG3aMnkvisjf
         Tx/UVc3053LEBiG3Jxlp4apcWUdfA+7gRqImqi7HOCqAIotRWQeocaYuOGJizowW3wxe
         hdR1+M/hsBuJmchAy8SUnYoc20tj6Twrh3QC1Chc+VSEAbQLJvbEzwvkELUcfwYChR+u
         i14snkZqZLiVGs5ukAvuJvA8hA1L0sUzfRaATdDU+A51QkG/6mbLK3Z+0SEHUmiCjeKd
         HG0Q==
X-Gm-Message-State: ABy/qLYZ1RszceKqJgsqQEI+nz75TQxAnHA52Bn/7spYQpVgisD2GyPf
        Ynx+IscAnFtfpU/mxnviHKK5h48SVtrUAhHw
X-Google-Smtp-Source: APBJJlFuB+ulE1TC96zXHD9mEKV7gZhQu6erFW/qmS/1DdpDK+g1JvMEcF1luS9TbQq6YZoF8mIF0g==
X-Received: by 2002:a25:6057:0:b0:c69:cf9a:4a6e with SMTP id u84-20020a256057000000b00c69cf9a4a6emr1369232ybb.45.1689260052153;
        Thu, 13 Jul 2023 07:54:12 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id k16-20020a25fe10000000b00c74e24a68e8sm1371931ybe.55.2023.07.13.07.54.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:54:11 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c7a5600d04dso758321276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:54:11 -0700 (PDT)
X-Received: by 2002:a25:ad49:0:b0:c4b:ada8:8b86 with SMTP id
 l9-20020a25ad49000000b00c4bada88b86mr1391571ybe.64.1689260051536; Thu, 13 Jul
 2023 07:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230609170941.1150941-1-javierm@redhat.com> <20230609170941.1150941-5-javierm@redhat.com>
 <CAMuHMdVXhi52KfpCmnum+9t74UWP+AOLE95xQU6VV6Nz=VHk1Q@mail.gmail.com>
 <87fs5sgdfh.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdWmJjGX+s=z0bBMDz0=zqZJHrGhkzWyRkmstS0eW9aiTg@mail.gmail.com>
 <87cz0vhpd1.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87cz0vhpd1.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jul 2023 16:53:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3VNcP1MS_Padps2Qwy=cmAU-4=XddVj+4-1sevCuErg@mail.gmail.com>
Message-ID: <CAMuHMdX3VNcP1MS_Padps2Qwy=cmAU-4=XddVj+4-1sevCuErg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/ssd130x: Don't allocate buffers on each plane update
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Thu, Jul 13, 2023 at 4:13 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Thu, Jul 13, 2023 at 3:21 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> >> > On Fri, Jun 9, 2023 at 7:09 PM Javier Martinez Canillas
> >> > <javierm@redhat.com> wrote:
> >> >> The resolutions for these panels are fixed and defined in the Device Tree,
> >> >> so there's no point to allocate the buffers on each plane update and that
> >> >> can just be done once.
> >> >>
> >> >> Let's do the allocation and free on the encoder enable and disable helpers
> >> >> since that's where others initialization and teardown operations are done.
> >> >>
> >> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> >> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> >> ---
> >> >>
> >> >> (no changes since v1)
> >> >
> >> > Thanks for your patch, which is now commit 49d7d581ceaf4cf8
> >> > ("drm/ssd130x: Don't allocate buffers on each plane update") in
> >> > drm-misc/for-linux-next.
> >> >
> >> >> --- a/drivers/gpu/drm/solomon/ssd130x.c
> >> >> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> >> >> @@ -701,14 +709,22 @@ static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
> >> >>                 return;
> >> >>
> >> >>         ret = ssd130x_init(ssd130x);
> >> >> -       if (ret) {
> >> >> -               ssd130x_power_off(ssd130x);
> >> >> -               return;
> >> >> -       }
> >> >> +       if (ret)
> >> >> +               goto power_off;
> >> >> +
> >> >> +       ret = ssd130x_buf_alloc(ssd130x);
> >> >
> >> > This appears to be too late, causing a NULL pointer dereference:
> >> >
> >>
> >> Thanks for reporting this issue.
> >>
> >> > [   59.302761] [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
> >> > [   59.304231] [<c0304200>]
> >> > ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
> >> > [   59.305716] [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
> >> >
> >>
> >> I wonder how this could be too late. I thought that the encoder
> >> .atomic_enable callback would be called before any plane .atomic_update.

[...]

> Thanks for the log, so I think the problem is that the default struct
> drm_mode_config_helper_funcs .atomic_commit_tail is
> drm_atomic_helper_commit_tail():
>
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_atomic_helper.c#L1710
>
> That helper calls drm_atomic_helper_commit_planes() and attempts to commit
> the state for all planes even for CRTC that are not enabled. I see that
> there is a drm_atomic_helper_commit_tail_rpm() helper that instead calls:
>
> drm_atomic_helper_commit_planes(dev, old_state, DRM_PLANE_COMMIT_ACTIVE_ONLY),
> which I thought that was the default behaviour.
>
> Can you please try the following change [0] ? If that works then I can
> propose as a proper patch.
>
> [0]:
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index afb08a8aa9fc..c543caa3ceee 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -795,6 +795,10 @@ static const struct drm_mode_config_funcs ssd130x_mode_config_funcs = {
>         .atomic_commit = drm_atomic_helper_commit,
>  };
>
> +static const struct drm_mode_config_helper_funcs ssd130x_mode_config_helpers = {
> +        .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> +};
> +
>  static const uint32_t ssd130x_formats[] = {
>         DRM_FORMAT_XRGB8888,
>  };
> @@ -923,6 +927,7 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
>         drm->mode_config.max_height = max_height;
>         drm->mode_config.preferred_depth = 24;
>         drm->mode_config.funcs = &ssd130x_mode_config_funcs;
> +       drm->mode_config.helper_private = &ssd130x_mode_config_helpers;
>
>         /* Primary plane */
>

Thanks, that works!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
