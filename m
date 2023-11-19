Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3547F0496
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 07:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjKSGrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 01:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 01:47:18 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93468C6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 22:47:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d242846194so453887866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 22:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700376433; x=1700981233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWWstq9VEzb+u3ForlZQdBiFb99f3/DYp4agyqbW5EU=;
        b=QhvMKxJnbkxGQKPntBOGkglTtDjVRgWPvkQknutEvXncVb0pm96aHBDK8fCf3iLv4g
         X4oMLyhczKjoDcfvnkoyb8l9as8BN5hMer5o3DafKtnQlnG/7p65xA+57Mg1UStDfiJn
         WnBg9y4UkK1Ef1UrrWcVyvlejMBRBRuuLH+TpK4K9h49BHhSdEvNgHPLwmXnMC+oh9Eu
         n7T1MDWuOtyDaXFBS3Jnl2C0SqZsJor4IvmuMMVN1yOEGcJoHUsPJkzwhvs+RaF1yFjv
         17Lz2N+UWyQ3+KmYm5WtjeTop8pltTdR8sXlAkGqPAuT8WO44vLR55TOOscjh3vqUr40
         AcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700376433; x=1700981233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWWstq9VEzb+u3ForlZQdBiFb99f3/DYp4agyqbW5EU=;
        b=tyiYHIbnOvhYB0sUmR7OyjzHLDqq/GUnGOmD9uSlBuskVsUkwIYbCi/oUxzeoz2+hb
         C2LeK43JJhwgVh0c4YMJz/A6u0Spm+n7slkqGHkD4c/+us8PMpt0p8o/Aod8QMKNyviS
         UsZ/mQ2OGpq/L62V7+kfNiL8q1bUss40T+xsHl7NeukJstLa/oDDME8fHXJNyHok7RI3
         qwAAsaz7MWz/gR4JU1zmOStS4KMdXbr2wbFZXQQwy3W7F6jUnXr3NPW4ANDdHtpuUEyg
         W/BC+igfntNg5bICcj8nlPlhKPj/6hrsal7gbka/4gWkQbZ8hXS+6nkiNklPsPP0Ofmr
         JNWg==
X-Gm-Message-State: AOJu0YzccKW5uid3r2xX6Ekep4DhaolWeAarJ8r2lVFqInpfCTRDF97Y
        v6LyKAJkxd0JzRedtdvYXoQuLUuLIALb3ju4Qr4=
X-Google-Smtp-Source: AGHT+IFLNYwN5aPDqVp9nauy22AjSvZ5hVHdqJZuBwEFqmr6KS+jP04ZULl0PxzMF602oe1DOWARDCaSrSEte4v5yec=
X-Received: by 2002:a17:907:7283:b0:9f7:b6c2:cd3b with SMTP id
 dt3-20020a170907728300b009f7b6c2cd3bmr2888671ejc.5.1700376433186; Sat, 18 Nov
 2023 22:47:13 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
In-Reply-To: <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 19 Nov 2023 16:47:01 +1000
Message-ID: <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Phillip Susi <phill@thesusis.net>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 12.11.23 01:46, Phillip Susi wrote:
> > I had been testing some things on a post 6.6-rc5 kernel for a week or
> > two and then when I pulled to a post 6.6 release kernel, I found that
> > system suspend was broken.  It seems that the radeon driver failed to
> > suspend, leaving the display dead, the wayland display server hung, and
> > the system still running.  I have been trying to bisect it for the last
> > few days and have only been able to narrow it down to the following 3
> > commits:
> >
> > There are only 'skip'ped commits left to test.
> > The first bad commit could be any of:
> > 56e449603f0ac580700621a356d35d5716a62ce5
> > c07bf1636f0005f9eb7956404490672286ea59d3
> > b70438004a14f4d0f9890b3297cd66248728546c
> > We cannot bisect more!
>
> Hmm, not a single reply from the amdgpu folks. Wondering how we can
> encourage them to look into this.
>
> Phillip, reporting issues by mail should still work, but you might have
> more luck here, as that's where the amdgpu afaics prefer to track bugs:
> https://gitlab.freedesktop.org/drm/amd/-/issues
>
> When you file an issue there, please mention it here.
>
> Furthermore it might help if you could verify if 6.7-rc1 (or rc2, which
> comes out later today) or 6.6.2-rc1 improve things.

It would also be good to test if reverting any of these is possible or not.

File the gitlab issue and we should poke amd a but more to take a look.

Dave.
