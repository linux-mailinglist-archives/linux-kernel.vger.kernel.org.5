Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF53F79EF54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjIMQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjIMQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:48:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743EB2139
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:48:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-501bd164fbfso11576014e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694623696; x=1695228496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQjO5I3ejJ11+YkmxgcLlgBI7nBSQ5PbV23tc1Goj3o=;
        b=dM+5Hga83kCR3mRVVJFDLHonpcvBOu/71cqIE0ONpB65neM+dU59zohpaCo62felJl
         O5XjKhgwApfHBUGCxl/HT7TpsLrUNZbIqFgVElBVvUrzEoyEz7G+Uf4Mniw4GIeuMj5l
         l4fzPIfefyXdvEIILekEBqiW6UrL2N8rOdQfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623696; x=1695228496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQjO5I3ejJ11+YkmxgcLlgBI7nBSQ5PbV23tc1Goj3o=;
        b=NnL5+189ililzeOa/CKelcLFaaH8RXcejnoMU6Wz0MO4D+6IUc1ig3+7qtZui19kro
         ttVdMWNZ2XEDuiXlOja/XeJmo+qFMqM0mDAd4Ou/Y7jQOYzeMMBQ6PCTzRZAQqizJWC6
         74SljfDhT2KhGsw+jN3vlbbuGTvWpXLa5t8ABloYZcTKh9oxP1jWRSFaiEb9zAD6VsTB
         mufDY60Qzq1WVQ+ItkUEQNURCuPbDUQHpIcX+yr3gpORqdpmrLiPdyV57lJRq03mchO1
         b4N+me8HvEFBISe/K5zdLMzdt+8DECpeRSljj79FGwwbx0Xp4UxitL77FwWW+Nt6RnKB
         /1wg==
X-Gm-Message-State: AOJu0YylsbOES1++fBMaega27YJIIAGjFJgCsugK169nwjPwinTnxj4Q
        nvGErIl/ZsfYusWS4L6IhwCpD7HZvnplz2d6uCXHsY+T
X-Google-Smtp-Source: AGHT+IHwqiLmn+C1ET1M26iitupV4PJ/YLcjdTDoZY94y2Bym94PW+Fp3P7dyAM2NysKDOaj+GVS1w==
X-Received: by 2002:a05:6512:3e2:b0:500:bb99:69a6 with SMTP id n2-20020a05651203e200b00500bb9969a6mr2392438lfq.39.1694623696595;
        Wed, 13 Sep 2023 09:48:16 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k24-20020ac24578000000b004f764716afdsm2218012lfm.257.2023.09.13.09.48.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 09:48:15 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so120334001fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:48:15 -0700 (PDT)
X-Received: by 2002:a2e:8206:0:b0:2b9:ee3e:2412 with SMTP id
 w6-20020a2e8206000000b002b9ee3e2412mr2818557ljg.22.1694623695030; Wed, 13 Sep
 2023 09:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230913110709.6684-1-hdanton@sina.com> <99d99007-8385-31df-a659-665bf50193bc@I-love.SAKURA.ne.jp>
In-Reply-To: <99d99007-8385-31df-a659-665bf50193bc@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2023 09:47:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgb9ccWN3Nks5STYUDqQUeHZdCLsK4kA37SdDJuGZfukg@mail.gmail.com>
Message-ID: <CAHk-=wgb9ccWN3Nks5STYUDqQUeHZdCLsK4kA37SdDJuGZfukg@mail.gmail.com>
Subject: Re: drm/vkms: deadlock between dev->event_lock and timer
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Maira Canal <mairacanal@riseup.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        syzkaller@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sept 2023 at 07:21, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello. A deadlock was reported in drivers/gpu/drm/vkms/ .
> It looks like this locking pattern remains as of 6.6-rc1. Please fix.
>
> void drm_crtc_vblank_off(struct drm_crtc *crtc) {
>   spin_lock_irq(&dev->event_lock);
>   drm_vblank_disable_and_save(dev, pipe) {
>     __disable_vblank(dev, pipe) {
>       crtc->funcs->disable_vblank(crtc) == vkms_disable_vblank {
>         hrtimer_cancel(&out->vblank_hrtimer) { // Retries with dev->event_lock held until lock_hrtimer_base() succeeds.
>           ret = hrtimer_try_to_cancel(timer) {
>             base = lock_hrtimer_base(timer, &flags); // Fails forever because vkms_vblank_simulate() is in progress.

Heh. Ok. This is clearly a bug, but it does seem to be limited to just
the vkms driver, and literally only to the "simulate vblank" case.

The worst part about it is that it's so subtle and not obvious.

Some light grepping seems to show that amdgpu has almost the exact
same pattern in its own vkms thing, except it uses

        hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);

directly, which presumably fixes the livelock, but means that the
cancel will fail if it's currently running.

So just doing the same thing in the vkms driver probably fixes things.

Maybe the vkms people need to add a flag to say "it's canceled" so
that it doesn't then get re-enabled?  Or maybe it doesn't matter
and/or already happens for some reason I didn't look into.

                       Linus
