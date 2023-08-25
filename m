Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3348B788B82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbjHYOTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343713AbjHYOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:19:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2DE2D44
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:19:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so1445020a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692973137; x=1693577937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14tHzTgrKzLolOWDMGY+nCkYOzM5n5tEd4Wo+rV44J4=;
        b=jgxnpqLVyRWBEzkzqMJHxlp+4RyLZATMl8vCzhpYXZdl/6nyjvTuDvzSmDvKxkt7St
         F1IzOYroxpQ3SsQzIjDPcWvx/FAtfJE1lHDvPA3aEmB+jnE2KejXdaX7lB5+qrRbWwG0
         LEQPn15fp53+M0CaW9it9GpTlckHS3DsbsSHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692973137; x=1693577937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14tHzTgrKzLolOWDMGY+nCkYOzM5n5tEd4Wo+rV44J4=;
        b=lmSE7DPlfk6ke5CAe26gBhi0/DoQ3jCIe3+CCW4Sol249AkKGAZT5hIGkhphcOAUCw
         ZlNDybpD6fb3wb5HUyRJjy9cBRl/o3yAwAPwKiJKYaFDoxME/EueS7vq26suCoA3JXVG
         iK2D+VO4ygysgWYkvtCnbGW9p94aZ6wtX4J2ySTr9P39otePpg5u/9mbVXwIT/FqRws8
         ius7bQ+IGkrx9BJL9rZXVCcwn+wNKCqKhTgis/PCg7FsIV1V5Snbw7963J41i74nddmG
         78lsxG6GHzlWcMPglCLjw2ylEEnJKj2NbmwwOnjx94MtpR6d2D07i/YxeWY6BmOSsS+B
         lDaw==
X-Gm-Message-State: AOJu0YxSBLNKEpPQCnkrTsuapwvT9a3gNUI0RQwEr7bFZFU7y/u/kFiY
        X3L61UoqeZXR3udjU886z90a0al3wbOjaIiXwTgvtMPP
X-Google-Smtp-Source: AGHT+IEo35Rq84yeB3C98DZmWcdojYmaC/17+JmnziVqa2tL9/WX3lZowLs3RonccA1twZLzdnpqtg==
X-Received: by 2002:a17:906:51:b0:9a1:e293:9882 with SMTP id 17-20020a170906005100b009a1e2939882mr5647261ejg.63.1692973137532;
        Fri, 25 Aug 2023 07:18:57 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906339300b0099bc8db97bcsm1002784eja.131.2023.08.25.07.18.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 07:18:57 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso77415e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:18:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1d98:b0:401:a494:2bbb with SMTP id
 p24-20020a05600c1d9800b00401a4942bbbmr173381wms.5.1692973136430; Fri, 25 Aug
 2023 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230822131945.1.I5b460ae8f954e4c4f628a373d6e74713c06dd26f@changeid>
 <20230825100854.GC270740@aspen.lan>
In-Reply-To: <20230825100854.GC270740@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Aug 2023 07:18:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VHa1arysMgqZcGFGFi2N8i0BeKWD6BM8dSsg0Xq2LUFQ@mail.gmail.com>
Message-ID: <CAD=FV=VHa1arysMgqZcGFGFi2N8i0BeKWD6BM8dSsg0Xq2LUFQ@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Flush console before entering kgdb on panic
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 25, 2023 at 3:09=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Aug 22, 2023 at 01:19:46PM -0700, Douglas Anderson wrote:
> > When entering kdb/kgdb on a kernel panic, it was be observed that the
> > console isn't flushed before the `kdb` prompt came up. Specifically,
> > when using the buddy lockup detector on arm64 and running:
> >   echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> >
> > I could see:
> >   [   26.161099] lkdtm: Performing direct entry HARDLOCKUP
> >   [   32.499881] watchdog: Watchdog detected hard LOCKUP on cpu 6
> >   [   32.552865] Sending NMI from CPU 5 to CPUs 6:
> >   [   32.557359] NMI backtrace for cpu 6
> >   ... [backtrace for cpu 6] ...
> >   [   32.558353] NMI backtrace for cpu 5
> >   ... [backtrace for cpu 5] ...
> >   [   32.867471] Sending NMI from CPU 5 to CPUs 0-4,7:
> >   [   32.872321] NMI backtrace forP cpuANC: Hard LOCKUP
> >
> >   Entering kdb (current=3D..., pid 0) on processor 5 due to Keyboard En=
try
> >   [5]kdb>
> >
> > As you can see, backtraces for the other CPUs start printing and get
> > interleaved with the kdb PANIC print.
> >
> > Let's replicate the commands to flush the console in the kdb panic
> > entry point to avoid this.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  kernel/debug/debug_core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index d5e9ccde3ab8..3a904d8697c8 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -1006,6 +1006,9 @@ void kgdb_panic(const char *msg)
> >       if (panic_timeout)
> >               return;
> >
> > +     debug_locks_off();
> > +     console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > +
> >       if (dbg_kdb_mode)
> >               kdb_printf("PANIC: %s\n", msg);
>
> I'm somewhat included to say *this* (calling kdb_printf() when not
> actually in the debugger) is the cause of the problem. kdb_printf()
> does some pretty horid things to the console and isn't intended to
> run while the system is active.
>
> I'd therefore be more tempted to defer the print to the b.p. trap
> handler itself and make this part of kgdb_panic() look more like:
>
>         kgdb_panic_msg =3D msg;
>         kgdb_breakpoint();
>         kgdb_panic_msg =3D NULL;

Unfortunately I think that only solves half the problem. As a quick
test, I tried simply commenting out the "kdb_printf" line in
kgdb_panic(). While that avoids the interleaved panic message and
backtrace, it does nothing to actually get the backtraces printed out
before you end up in kdb. As an example, this is what happened when I
used `echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT` and
had the "kdb_printf" in kgdb_panic() commented out:

[   72.658424] lkdtm: Performing direct entry HARDLOCKUP
[   82.181857] watchdog: Watchdog detected hard LOCKUP on cpu 6
...
[   82.234801] Sending NMI from CPU 5 to CPUs 6:
[   82.239296] NMI backtrace for cpu 6
... [ stack trace for CPU 6 ] ...
[   82.240294] NMI backtrace for cpu 5
... [ stack trace for CPU 5 ] ...
[   82.576443] Sending NMI from CPU 5 to CPUs 0-4,7:
[   82.581291] NMI backtrace
Entering kdb (current=3D0xffffff80da5a1080, pid 6978) on processor 5 due
to Keyboard Entry
[5]kdb>

As you can see, I don't see the traces for CPUs 0-4 and 7. Those do
show up if I use the "dmesg" command but it's a bit of a hassle to run
"dmesg" to look for any extra debug messages every time I drop in kdb.

I guess perhaps that part isn't obvious from the commit message?
Should I send a new version with an updated commit message indicating
that it's not just the jumbled text that's a problem but also the lack
of stack traces?

Thanks!

-Doug
