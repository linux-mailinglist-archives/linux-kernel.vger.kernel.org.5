Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF677A98C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjIURwj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjIURwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:52:24 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273B35102C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:33 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-577a98f78b2so809348a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316523; x=1695921323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1b4te39uCS0E/NkoW2Yy3eXJPfyE4+wAq2OQTK/UETI=;
        b=GSKffE7dc3Vo7apg1c7uEf9VYQtNmPJmZc7el7hyiUtM6U4zZluSqO+t9lwpMV6cbU
         7x2VyeAPae9bsHWQpS2FCrULDQeihBqzwd2YRrcQ3DN9k56gGrZtTugwz8xDGpLZVe1W
         FZZqCmSFDELUPCPoz4jEaJIjv/9JEOoC/6gDmDYBf/R58muAFiSoAmdT1L8LOoR0fTTT
         oYO7/zEZ0lwoOJx1IMwEsWDomgTghtlQKBMP/tGNtL6WxEepVhhX938VhMCg+u20MpDn
         33LIjIeRdmoQMe56mSywQ/mK18L59uNIlyYpBcK/T5TpFB8Nbbkk8qHwWEEq/GZaKdp1
         XYqQ==
X-Gm-Message-State: AOJu0Yxh5HX1ZjVJaAiq3SUw9Llldj2i/0YHyfXna31PeoPvfEVgNkAz
        cD1Bit5KtwbbsQfJoZTEAxggfEIb6C9DFjP7
X-Google-Smtp-Source: AGHT+IH0xICT0fZvW8uG0Nt+4+xZJLZqJMC48aQRW8HZWsB6vNLxDG873OOyhqYM2ffKo6ewIo8cfg==
X-Received: by 2002:a0d:d7d7:0:b0:59b:eb5b:fbbb with SMTP id z206-20020a0dd7d7000000b0059beb5bfbbbmr4723580ywd.12.1695283055147;
        Thu, 21 Sep 2023 00:57:35 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id k125-20020a0dfa83000000b0054f50f71834sm204578ywf.124.2023.09.21.00.57.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:57:34 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59c00b5c8b2so8053307b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 00:57:34 -0700 (PDT)
X-Received: by 2002:a0d:d205:0:b0:59b:de0f:c23b with SMTP id
 u5-20020a0dd205000000b0059bde0fc23bmr4756114ywd.46.1695283054573; Thu, 21 Sep
 2023 00:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230914195138.1518065-1-javierm@redhat.com> <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
 <87wmwo3q50.fsf@minerva.mail-host-address-is-not-set> <552hpgr7qzbjxuyei3n5m7rsn7ekwbdgzv25oe5vy6qb35gf23@q4etussk5jwl>
In-Reply-To: <552hpgr7qzbjxuyei3n5m7rsn7ekwbdgzv25oe5vy6qb35gf23@q4etussk5jwl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 09:57:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGVgj6V+N865QZaAusqD7O2f1askE544Z4MF0h4zBERg@mail.gmail.com>
Message-ID: <CAMuHMdUGVgj6V+N865QZaAusqD7O2f1askE544Z4MF0h4zBERg@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Sep 21, 2023 at 9:44 AM Maxime Ripard <mripard@kernel.org> wrote:
> On Mon, Sep 18, 2023 at 09:19:07AM +0200, Javier Martinez Canillas wrote:
> > Thomas Zimmermann <tzimmermann@suse.de> writes:
> > > Am 14.09.23 um 21:51 schrieb Javier Martinez Canillas:
> > >> The driver uses a naming convention where functions for struct drm_*_funcs
> > >> callbacks are named ssd130x_$object_$operation, while the callbacks for
> > >> struct drm_*_helper_funcs are named ssd130x_$object_helper_$operation.
> > >>
> > >> The idea is that this helper_ prefix in the function names denote that are
> > >> for struct drm_*_helper_funcs callbacks. This convention was copied from
> > >> other drivers, when ssd130x was written but Maxime pointed out that is the
> > >> exception rather than the norm.
> > >
> > > I guess you found this in my code. I want to point out that I use the
> > > _helper infix to signal that these are callback for
> > > drm_primary_plane_helper_funcs and *not* drm_primary_plane_funcs. The
> > > naming is intentional.
> >
> > Yes, that's what tried to say in the commit message and indeed I got the
> > convention from drivers in drivers/gpu/drm/tiny. In fact I believe these
> > function names are since first iteration of the driver, when was meant to
> > be a tiny driver.
> >
> > According to Maxime it's the exception rather than the rule and suggested
> > to change it, I don't really have a strong opinion on either naming TBH.
>
> Maybe that's just me, but the helper in the name indeed throws me off. In my
> mind, it's supposed to be used only for helpers, not functions implementing the
> helpers hooks.

With several callbacks using the same (field) name, it is very helpful
to name the actual implementation by combining the struct type name
and the field name.  Anything else confuses the casual reader.
Perhaps the real question is whether the structures should have "helper"
in their name in the first place?

Just my 2€c as a DRM novice...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
