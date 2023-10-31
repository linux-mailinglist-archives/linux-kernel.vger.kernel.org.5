Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C017DCD76
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjJaNA2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbjJaNAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:00:25 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1DBD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:00:20 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7afd45199so55483867b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698757220; x=1699362020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2/9SzfZn7NzTarkU7G1sDrbFVriBS+2+GtDvbflE38=;
        b=oe44+V/DqLmMjBSbe77GVxFcw7xyuBWlDiyv8AMWfvLNCWOspSYzLIjcDHcti8kRZH
         05xcS+g1IKy6xe4pggArgc137lD9WsVVoQgvV/jps63qTkiwhZFiGnlOsWzXT/nDKDxd
         aUQa7J7NesacMScaUj3+D1KtIM492QnaaKPsDHXXxajmGXeQDiD7z5Cu3A0GGXKEWbJY
         7YrxIQHNgQWoRFCd0qPhgwkm1HovdQGjGI9aeHf+Pun8JvGljcHDuH2fEsOsDJRqPToN
         p2cJAlbrOvs4lp4zIDMGXOTpMYUOuvdor7r6QH3BnF3tBDUNeIlCNBfLQ/8AUTraTYGG
         XKjQ==
X-Gm-Message-State: AOJu0Yx17eXTPXxAp63FsUNeyQLgRLFESs7ZnotpEv753YIwIc1JxYzL
        5+FZf55hmZ5/2X5Tlc7qLlXhSp7lhp8rKw==
X-Google-Smtp-Source: AGHT+IFFczy/Go/6fWSm/bu52igGl7v0ILF+MsYApzCHsbpGTJb3OoT8fUaGqM/dMDSpas8FxX8bfg==
X-Received: by 2002:a81:bc4f:0:b0:577:a46:26e5 with SMTP id b15-20020a81bc4f000000b005770a4626e5mr11317034ywl.31.1698757219769;
        Tue, 31 Oct 2023 06:00:19 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id d77-20020a814f50000000b005a7bbd713ddsm748692ywb.108.2023.10.31.06.00.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 06:00:19 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d9a398f411fso5050687276.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:00:18 -0700 (PDT)
X-Received: by 2002:a5b:c49:0:b0:d9c:7d48:3020 with SMTP id
 d9-20020a5b0c49000000b00d9c7d483020mr10891107ybr.20.1698757218586; Tue, 31
 Oct 2023 06:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231020225338.1686974-1-javierm@redhat.com> <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
 <87v8aso1ha.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdVLf=H7QWaUXrN17ABw9eE1MjBdzFEM0AhMNj8_ULSz+Q@mail.gmail.com>
 <87lebjksoj.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdXdYm6Opyhgte7CaScs_jdPNUqrQTbPCMSQXqkKpKTd8w@mail.gmail.com>
 <87il6nkp6e.fsf@minerva.mail-host-address-is-not-set> <2eh6i4ttpepnpehw47zucgrs3rvzugxiay7eqy65phktcm2m4r@zwzyn5rn55yl>
In-Reply-To: <2eh6i4ttpepnpehw47zucgrs3rvzugxiay7eqy65phktcm2m4r@zwzyn5rn55yl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Oct 2023 14:00:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXHq6yE14YqA+GNj=V79Z1rYTK=8Dx5WWw3RczrzMy21A@mail.gmail.com>
Message-ID: <CAMuHMdXHq6yE14YqA+GNj=V79Z1rYTK=8Dx5WWw3RczrzMy21A@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Fix possible uninitialized usage of
 crtc_state variable
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, Oct 31, 2023 at 12:53 PM Maxime Ripard <mripard@kernel.org> wrote:
> On Tue, Oct 31, 2023 at 12:27:05PM +0100, Javier Martinez Canillas wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > >> >> Pushed to drm-misc (drm-misc-next). Thanks!
> > >> >
> > >> > Looks like you introduced an unintended
> > >> >
> > >> >     (cherry picked from commit 9e4db199e66d427c50458f4d72734cc4f0b92948)
> > >> >
> > >> > ?
> > >>
> > >> No, that's intended. It's added by the `dim cherry-pick` command, since I
> > >> had to cherry-pick to drm-misc-next-fixes the commit that was already in
> > >> the drm-misc-next branch.
> > >>
> > >> You will find that message in many drm commits, i.e:
> > >>
> > >> $ git log --oneline --grep="(cherry picked from commit" drivers/gpu/drm/ | wc -l
> > >> 1708
> > >
> > > Ah, so that's why it's (way too) common to have merge conflicts between
> > > the fixes and non-fixes drm branches :-(

> That's also not as bad as Geert put it: merging two branches with the
> exact same commit applied won't create conflict. If the two commits
> aren't exactly the same then we can indeed create conflicts, but that
> would have been the case anyway with or without the "double-commits"

Oh it is, as soon as one branch receives more commits that make changes
to the same location.  Which is fairly common, too, to the point
that I am surprised when merging a drm for-next branch does not trigger
a conflict...

Cfr. the conflict I had to resolve this morning between commit
64ffd2f1d00c6235 ("drm/amd: Disable ASPM for VI w/ all Intel systems")
already upstream, and commits e5f52a84bf0a8170 ("drm/amd: Disable ASPM
for VI w/ all Intel systems") and follow-up 2757a848cb0f1848
("drm/amd: Explicitly disable ASPM when dynamic switching disabled")
in drm/drm-next.

Note that none of 64ffd2f1d00c6235 and 2757a848cb0f1848 has a "cherry
picked from commit" line in the commit description.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
