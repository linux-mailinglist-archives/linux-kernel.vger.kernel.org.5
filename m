Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6417F7DCAE0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjJaKb1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjJaKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:31:24 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED0A2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:31:22 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a8628e54d4so48662907b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698748282; x=1699353082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sHseqslpAHK7KgV7P/BcLuw8uc0JkMkTgTl4k752Ts=;
        b=Lt1Re2EFNqNvFqk2hYpOh9mifGpsffEiZq5VoY6o7hfLPBaOT36lqd20BV9bs6aRXe
         eat2xBfrN/WIJ7fkxtwxXh1z2Cysx8QaCsU41AX1CM+tP3Z5Gb0bGc9L/ggLI4Iegcvr
         pI/JuuCoLgPVFjkMVAFb/OEUU4iZrxVtWivl82Cct0aBg/pCB55Plg9Nn1mqt/GTc0Hp
         wvrFEKcTZNyL8gIJCJbuL4rK0e9V1tkEMAGbc4aGMBp69roOxch+V/MMeNUf8oNhCUFa
         tZ4uO8pNcEmhRJWyL6WTOFY8/pt/Etx7jGpjkIeY45JX1D8zNIf7++hSMwX2ud6NmefU
         hLUA==
X-Gm-Message-State: AOJu0YwJfNc/NPac8gO5lyqJR3NZVxRCGELwn0c+uwAowSpX63zYL5Ye
        Qcsy5H3jEORcqQD8U6SB1Gr5zWqIFOUxnA==
X-Google-Smtp-Source: AGHT+IHjBzdMtahxdomPDz9IEPVkmXMHm5jjalGGgj+z8OJSN9XVvJ33rfHN5lGdOt2jpjfMU2DSHA==
X-Received: by 2002:a81:8d48:0:b0:59f:699b:c3b3 with SMTP id w8-20020a818d48000000b0059f699bc3b3mr1511766ywj.0.1698748281759;
        Tue, 31 Oct 2023 03:31:21 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id v62-20020a0dd341000000b005950e1bbf11sm604042ywd.60.2023.10.31.03.31.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 03:31:21 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so4820331276.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:31:20 -0700 (PDT)
X-Received: by 2002:a5b:ec1:0:b0:da0:3a37:61d5 with SMTP id
 a1-20020a5b0ec1000000b00da03a3761d5mr1526353ybs.4.1698748280706; Tue, 31 Oct
 2023 03:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231020225338.1686974-1-javierm@redhat.com> <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
 <87v8aso1ha.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdVLf=H7QWaUXrN17ABw9eE1MjBdzFEM0AhMNj8_ULSz+Q@mail.gmail.com>
 <87lebjksoj.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87lebjksoj.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Oct 2023 11:31:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXdYm6Opyhgte7CaScs_jdPNUqrQTbPCMSQXqkKpKTd8w@mail.gmail.com>
Message-ID: <CAMuHMdXdYm6Opyhgte7CaScs_jdPNUqrQTbPCMSQXqkKpKTd8w@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Fix possible uninitialized usage of
 crtc_state variable
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>
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

On Tue, Oct 31, 2023 at 11:11 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Fri, Oct 27, 2023 at 11:33 AM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> Jocelyn Falempe <jfalempe@redhat.com> writes:
> >> > On 21/10/2023 00:52, Javier Martinez Canillas wrote:
> >> >> Avoid a possible uninitialized use of the crtc_state variable in function
> >> >> ssd132x_primary_plane_atomic_check() and avoid the following Smatch warn:
> >> >>
> >> >>      drivers/gpu/drm/solomon/ssd130x.c:921 ssd132x_primary_plane_atomic_check()
> >> >>      error: uninitialized symbol 'crtc_state'.
> >> >
> >> > That looks trivial, so you can add:
> >> >
> >> > Acked-by: Jocelyn Falempe <jfalempe@redhat.com>
> >> >
> >>
> >> Pushed to drm-misc (drm-misc-next). Thanks!
> >
> > Looks like you introduced an unintended
> >
> >     (cherry picked from commit 9e4db199e66d427c50458f4d72734cc4f0b92948)
> >
> > ?
> >
>
> No, that's intended. It's added by the `dim cherry-pick` command, since I
> had to cherry-pick to drm-misc-next-fixes the commit that was already in
> the drm-misc-next branch.
>
> You will find that message in many drm commits, i.e:
>
> $ git log --oneline --grep="(cherry picked from commit" drivers/gpu/drm/ | wc -l
> 1708

Ah, so that's why it's (way too) common to have merge conflicts between
the fixes and non-fixes drm branches :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
