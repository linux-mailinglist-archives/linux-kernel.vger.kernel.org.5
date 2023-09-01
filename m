Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51F078FCEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346699AbjIAMI2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 08:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIAMI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:08:27 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C4CED
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:08:25 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a99eeb95aaso1154592b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693570104; x=1694174904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0eLku2x7Gqxfah9HHr3k8QumPRfxLwdATDwnW94z94=;
        b=V6DpZ6osy5/CQS7kUyGssaCSutpk8HOFl+6pFoQeqvTE8I6chU/f/pe+1CQ0H0yaat
         38jWrHnv/ez2lc07hGCWFUCpCVURk1821Wy5MLpVSzHmcD9EsCT3G30MX38couCn4Vis
         PqveV8wbio9zSY4tYdvHoOop10fJ6zj+H4M3Yp5QiMx7PUp1Joa4fqJvTVfYzIJxoc6K
         rLHxqLxcfhEMeyiBoOMiY3Q7umtQjLQayD/Mh2tHVZdRYZK4eFu2Bbe5V25VyQ+cO2Ua
         1K8nl8F4pMI0FHByg51E5RSZCd9sbV3e2iYfVW9hGMdC8zhHSGZfCZ9IiazfGJmLAZku
         JuAg==
X-Gm-Message-State: AOJu0YzbB7lKsv5b52p/5nibQfHs4rCg3M/DinnsViL4mI6h5tXAiHhQ
        eymGohOOFbV81bsR5N5thyhKDIp2PNKkbA==
X-Google-Smtp-Source: AGHT+IHqCF/s+28HcefRmPxdbWiFgPRSbVH7HVmNF0lr2J7G62iOpskSTHyDtxMXFGCTeqFQ7nRncA==
X-Received: by 2002:a05:6808:17a6:b0:3a7:250a:7948 with SMTP id bg38-20020a05680817a600b003a7250a7948mr3138886oib.13.1693570104181;
        Fri, 01 Sep 2023 05:08:24 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id bx33-20020a0568081b2100b003a3b321712fsm1863056oib.35.2023.09.01.05.08.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:08:23 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6bee392fe9dso1437367a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:08:23 -0700 (PDT)
X-Received: by 2002:a05:6358:7e53:b0:139:b4c0:93c with SMTP id
 p19-20020a0563587e5300b00139b4c0093cmr2780839rwm.5.1693570102753; Fri, 01 Sep
 2023 05:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230830062546.720679-1-javierm@redhat.com> <zitno3p7tbnld5auedkx5g4wey2csng4ncmtdhzinbuhblunyk@chnwsnsgq36v>
 <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com> <4zfgmvfstyjfo5slggfmfuvnirrhrq773el52gkav2r6jxliub@7qjbyy7rkj3g>
In-Reply-To: <4zfgmvfstyjfo5slggfmfuvnirrhrq773el52gkav2r6jxliub@7qjbyy7rkj3g>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 14:08:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_775mPbTgWmzCo4mKCd3kqL=vfVFrt2W=bR3uveNW_Q@mail.gmail.com>
Message-ID: <CAMuHMdV_775mPbTgWmzCo4mKCd3kqL=vfVFrt2W=bR3uveNW_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Fri, Sep 1, 2023 at 2:00 PM Maxime Ripard <mripard@kernel.org> wrote:
> On Fri, Sep 01, 2023 at 10:36:17AM +0200, Geert Uytterhoeven wrote:
> > On Fri, Sep 1, 2023 at 10:22 AM Maxime Ripard <mripard@kernel.org> wrote:
> > > On Wed, Aug 30, 2023 at 08:25:08AM +0200, Javier Martinez Canillas wrote:
> > > > The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
> > > > .atomic_check() callback") moved the allocation of the intermediate and
> > > > HW buffers from the encoder's .atomic_enable callback to primary plane's
> > > > .atomic_check callback.
> > > >
> > > > This was suggested by Maxime Ripard because drivers aren't allowed to fail
> > > > after drm_atomic_helper_swap_state() has been called, and the encoder's
> > > > .atomic_enable happens after the new atomic state has been swapped.
> > > >
> > > > But that change caused a performance regression in very slow platforms,
> > > > since now the allocation happens for every plane's atomic state commit.
> > > > For example, Geert Uytterhoeven reports that is the case on a VexRiscV
> > > > softcore (RISC-V CPU implementation on an FPGA).
> > >
> > > I'd like to have numbers on that. It's a bit surprising to me that,
> > > given how many objects we already allocate during a commit, two small
> > > additional allocations affect performances so dramatically, even on a
> > > slow platform.
> >
> > To be fair, I didn't benchmark that.  Perhaps it's just too slow due to
> > all these other allocations (and whatever else happens).
> >
> > I just find it extremely silly to allocate a buffer over and over again,
> > while we know that buffer is needed for each and every display update.
>
> Maybe it's silly, but I guess it depends on what you want to optimize
> for. You won't know the size of that buffer before you're in
> atomic_check. So it's a different trade-off than you would like, but I
> wouldn't call it extremely silly.

The size of ssd130x_plane_state.data_array[] is fixed, and depends
on the actual display connected.
The size of ssd130x_plane_state.buffer[]  is also fixed, and depends
on the plane's size (which is currently fixed to the display size).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
