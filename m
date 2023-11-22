Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7067F5471
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjKVXWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKVXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:22:38 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E79199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:22:34 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so4247001fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700695350; x=1701300150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJOhF/4HhsMcq+4OhCmL3qx9GecDZNXGyPEGgiyFfNA=;
        b=encP0i+Ppnh7ztHLt+CScwSAYAHU0Co72tFErALQ0FiJpvvOOq66kGqPmMYtA7A1lU
         Jw7gHEY4vfILzEAwQ/LWBCMU736GaHiznwiESieDckfYwMGpQAs008ah0wTbap4dcAgC
         rMpIidBTYQ/cbgcybzUtXbGDYYP/ljQiyEgFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695350; x=1701300150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJOhF/4HhsMcq+4OhCmL3qx9GecDZNXGyPEGgiyFfNA=;
        b=duW3CQye9T7EpwDJxIjWuNe8LNAQoKAU+lU8Qer3O0cWFPBnFN+Tv8mdEUegR3MwLD
         RfjXfFl65dnxgstuTifCWcsVtT6qqSCkltbBykbfV4z1qDE+hPo0NKpMtoyKy8JL6pBr
         tEzsAKLlnmWa4XplDUtX98xwDU+wnU8hbqUFnzdrY4Q/TeWC38gwFT4+ibkRZYXA6XKI
         VgLXuQzvt37o5mSX9gkBrREqQX8x+dqL+CwekfWJezOVoalgYtI4U+U1g2MLufPyQKKa
         hrV9iBCZWNceN7a1r4iOijISV56xp2XzHAxhXQYX+UdMS9KGgbTrffVJwdEtW0KKKDgP
         Moag==
X-Gm-Message-State: AOJu0Yz+GCsNGOkWfOFolL66aNOKy48J8QDyPY99DCO5Ckk57vkJBF+B
        0cMN6zeTI6NmekAruYON/KaBTbS5W+3htopTfwZtk8Io
X-Google-Smtp-Source: AGHT+IHDfPJGxWi+94sx2ahgU3JQRzJDrsPDvv+zKjWo/XpXDq6cZ4QUPPJLmkB1HILG96HjaD2JLA==
X-Received: by 2002:a05:651c:14c:b0:2c5:14d3:f295 with SMTP id c12-20020a05651c014c00b002c514d3f295mr2368091ljd.35.1700695350356;
        Wed, 22 Nov 2023 15:22:30 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906135800b009fc8233fb66sm17043ejb.36.2023.11.22.15.22.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 15:22:29 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so9625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:22:29 -0800 (PST)
X-Received: by 2002:a05:600c:1d23:b0:40b:3483:8488 with SMTP id
 l35-20020a05600c1d2300b0040b34838488mr95421wms.3.1700695349234; Wed, 22 Nov
 2023 15:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20231122100212.94327-1-lizhe.67@bytedance.com> <20231122140521.85c66b789625e8d270722b3c@linux-foundation.org>
In-Reply-To: <20231122140521.85c66b789625e8d270722b3c@linux-foundation.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Nov 2023 15:22:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VwaL7VSpEir6Ocyh3cttk8Abj5ZJ61h_CrPkYzYZDRYQ@mail.gmail.com>
Message-ID: <CAD=FV=VwaL7VSpEir6Ocyh3cttk8Abj5ZJ61h_CrPkYzYZDRYQ@mail.gmail.com>
Subject: Re: [PATCH v2] softlockup: serialized softlockup's log
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     lizhe.67@bytedance.com, pmladek@suse.com,
        lecopzer.chen@mediatek.com, kernelfans@gmail.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 22, 2023 at 2:05=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 22 Nov 2023 18:02:12 +0800 lizhe.67@bytedance.com wrote:
>
> > From: Li Zhe <lizhe.67@bytedance.com>
> >
> > If multiple CPUs trigger softlockup at the same time with
> > 'softlockup_all_cpu_backtrace=3D0', the softlockup's logs will appear
> > staggeredly in dmesg, which will affect the viewing of the logs for
> > developer. Since the code path for outputting softlockup logs is not
> > a kernel hotspot and the performance requirements for the code are
> > not strict, locks are used to serialize the softlockup log output to
> > improve the readability of the logs.
>
> Seems reasonable, but...
>
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -28,6 +28,8 @@
> >  #include <linux/kvm_para.h>
> >
> >  static DEFINE_MUTEX(watchdog_mutex);
> > +/* This lock is used to prevent concurrent actions of softlockup outpu=
t logs */
> > +static DEFINE_SPINLOCK(watchdog_output_lock);
>
> It would be a little neater to reduce the scope of this - move the
> definition into that little code block in watchdog_timer_fn() where it
> is actually used.

That's where Li Zhe had it in v1. I actually requested it move to a
larger scope since I think we'll want a future patch that also uses
the same lock for hardlockup and I was thinking of sending that out
after Li Zhe's patch lands. Specifically, I've seen cases on arm64
when pseudo-NMI isn't enabled that we can end up with a soft lockup
triggering while we're waiting for a backtrace of a hardlockup (since
we wait 10 seconds if a CPU isn't responding to the request to
backtrace it).

I've also been testing hardlockup (with pseudo-NMI enabled) and I also
notice similar problems with hardlockup itself. Specifically, I'm
looking at a an output currently that looks like this:

[  102.619905] lkdtm: Performing direct entry HARDLOCKUP
[  112.037900] Watchdog detected hard LOCKUP on cpu 1
[  112.038031] Watchdog detected hard LOCKUP on cpu 7
[  112.042872] Modules linked in:
[  112.047807] Modules linked in:
...

...but I'd also be OK with limiting the scope until I send my later
patch, so up to you.


> >  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HARDLOCKUP_D=
ETECTOR_SPARC64)
> >  # define WATCHDOG_HARDLOCKUP_DEFAULT 1
> > @@ -514,6 +516,7 @@ static enum hrtimer_restart watchdog_timer_fn(struc=
t hrtimer *hrtimer)
> >               /* Start period for the next softlockup warning. */
> >               update_report_ts();
> >
> > +             spin_lock(&watchdog_output_lock);
>
> The hrtimer callout function is called from [soft]irq context, yes?
> Doesn't lockdep get upset when we take a spinlock in such a context?

I don't think so, but I could certainly be wrong. As far as I knew:

* spin_lock_irqsave / spin_unlock_irqrestore: Always safe to call,
whether from normal context or IRQ context. Saves whether IRQs were
disabled or not, then disables them, then restores them to how they
were before.

* spin_lock_irq, spin_unlock_irq: Safe to call as long as you're _not_
in IRQ context (because spin_lock_irq disables IRQs and
spin_unlock_irq unconditionally re-enables them)

* spin_lock / spin_unlock: Safe to call as long as you _are_ in IRQ
context. Being in IRQ context means IRQs are already disabled so the
function doesn't need to disable/reenable them. Also safe to call if
no users of this spinlock ever run in IRQ context.

The reason for all that complexity is to specifically to avoid:

1. spin_lock(&my_lock);
2. IRQ fires off
3. In IRQ context: spin_lock(&my_lock);

...because that would make us spin forever.


Just to be sure, I just tried with lockdep and things seemed OK.
Specifically, I did:

sysctl -w kernel.softlockup_panic=3D0
sysctl -w kernel.softlockup_all_cpu_backtrace=3D0
for i in $(seq 3); do
  echo SOFTLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT&
done

I got no lockdep splats and things seemed synchronized. Of course, the
system was in pretty bad shape because the "provoke-crash" module
never gets out of its soft lockup, but that's part for the course and
why on our systems we run with kernel.softlockup_panic=3D1. I guess that
also means I'd be happy with this now:

Tested-by: Douglas Anderson <dianders@chromium.org>
