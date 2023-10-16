Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77747CAD13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjJPPNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjJPPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:13:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2553AB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:13:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso9591748a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1697469208; x=1698074008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eR5ud+X4G99kqXhYup2CajHlyncDkkFQVZGmFycYE4=;
        b=aBOxAnP8RYmytbkIQU/05delHEWjWFIC5SsD9GIXFO5yFEs+5rd6yTHkVgsF5AZtx+
         bT0csrs84IHH5EScvN8ByTMz9p+Dc7mz7/Pscu3pFj3aW5nNI/WjeUupx4X7TF3etw3e
         tpUy64NnMt+K8cFnH5sJYNW3dDvW16ixx0+Sh2fI+OgAXpTQ0tLH6zs0xZ3WUijO58Ne
         N0bJ99HMIzztUwCam8crOzeApjMayv0ZscUUn7drpqVBFxnyk3JkAWBPJdqu99KBJi9S
         CFUCSRVrdDa+wNImsrgaZgqLgw8DBYUL/PdHSerXkB4pgzXgShb9Ab/qLesKuU82KKI1
         0WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697469208; x=1698074008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eR5ud+X4G99kqXhYup2CajHlyncDkkFQVZGmFycYE4=;
        b=FALqEFU29DQUBcaGbsJecCLEqyEeFP5G+W7MvFpVuIzrqX7lsT4XN6sp5nSNLuzzU6
         hWIz2EKvcsfyBOjddPpPRRXYBmxa64Evk3Q7uksf2YGQ3JlPBE122Y3wj/fK/+bVdSUr
         Hj4o0JdOLVZVbmtFnOm9rijPzJfkdBjk1T/B6S/XqtZdYbHq4q+fDWdYKZHVKhXKhaNn
         jjYTkDvn3zQVPB2rl5gHELpQF8T+xS2dC9/NMULmlhdnjP0qHEJ4KK87mmt6NtlCFotD
         x/aVqjZ4IISnLUlhnNHEE6b732C9u23TsaVIjJ03Y8TjjWamJieoOI5kmTCnlQYxO2bl
         FyqA==
X-Gm-Message-State: AOJu0Yw3+0xzfmWQJ1cBWh6njpELWOoYY4rVR8s6xbz/Q13tPSY1nuB3
        eg/18KkeHOSjewhCZxGQIl+/zZGhvWFhYvYWIbGl
X-Google-Smtp-Source: AGHT+IFg3/KAz6Mip/C3DXnI335HIk46uxk8vrysOfN9E7iyF67oOzOnHex+ShwEAuJmJYfekwilB0L9GS9E/6rpGz0=
X-Received: by 2002:a05:6402:354c:b0:53d:b59c:8f8d with SMTP id
 f12-20020a056402354c00b0053db59c8f8dmr7999575edd.8.1697469208569; Mon, 16 Oct
 2023 08:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
 <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
 <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com>
 <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
 <CAJfuBxy9qn-4i3SteTL1LBbBxPrFM52KkBd=1UhcKV3S_KdQvw@mail.gmail.com>
 <20231011114816.19d79f43@eldfell> <ZSZuACLwt5_XAL2n@phenom.ffwll.local> <CAJfuBxytOcUDmPBO7uQ9mMRvpNvzA3tgg_-pSGmdXpjDPe5sNQ@mail.gmail.com>
In-Reply-To: <CAJfuBxytOcUDmPBO7uQ9mMRvpNvzA3tgg_-pSGmdXpjDPe5sNQ@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Mon, 16 Oct 2023 17:13:16 +0200
Message-ID: <CAK8Bye+v+fYsN-716vQKJCoTmDQWmTw_Z1ZGD2A=HvuuAApwig@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     jim.cromie@gmail.com
Cc:     Pekka Paalanen <ppaalanen@gmail.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "wayland-devel@lists.freedesktop.org" 
        <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 12 pa=C5=BA 2023 o 20:48 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> > If you want the kernel to keep separate flight recorders I guess we cou=
ld
> > add that, but I don't think it currently exists for the dyndbg stuff at
> > least. Maybe a flight recorder v2 feature, once the basics are in.
> >
>
> dyndbg has   +p    writes to syslog
> +T  would separately independently write the same to global trace
>
> This would allow  graceful switchover to tracefs,
> without removing logging from dmesg, where most folks
> (and any monitor tools) would expect it.
>
> Lukas (iiuc) wants to steer each site to just 1 destination.
> Or maybe (in addition to +p > syslog) one trace destination,
> either global via events, or a separate tracebuf
>
> Im ambivalent, but thinking the smooth rollover from syslog to trace
> might be worth having to ease migration / weaning off syslog.
>
> And we have a 4 byte hole in struct _ddebug we could just use.

I'm glad you brought that up. This means we can leave class_id field
untouched, have separate +T in flags (for consistency)
and dst_id can be easily 8 bits wide.

Also can you point me to the latest version of writing debug logs to
trace events (+T option).
I would like to base trace instances work on that because both are
closely related.

> Unless the align 8 is optional on 32-bits,

I verified with "gcc -g -m32 ..." that the align(8) is honored on 32 bits.

> I think we're never gonna close the hole anywhere.
>

:)

> is align 8 a generic expression of an architectural simplifying constrain=
t ?
> or a need for 1-7 ptr offsets ?
>
>
>
>
> > > That's my idea of it. It is interesting to see how far the requiremen=
ts
> > > can be reasonably realised.
> >
> > I think aside from the "make it available directly to unpriviledged
> > userspace" everything sounds reasonable and doable.
> >
> > More on the process side of things, I think Jim is very much looking fo=
r
> > acks and tested-by by people who are interested in better drm logging
> > infra. That should help that things are moving in a direction that's
> > actually useful, even when it's not yet entirely complete.
> >
>
> yes, please.  Now posted at
>
> https://lore.kernel.org/lkml/20231012172137.3286566-1-jim.cromie@gmail.co=
m/T/#t
>
> Lukas, I managed to miss your email in the send phase.
> please consider yourself a direct recipient :-)
>
> thanks everyone
>
> > Cheers, Sima
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
