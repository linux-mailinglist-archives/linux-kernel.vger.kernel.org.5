Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3F7CFAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345801AbjJSNWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjJSNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:22:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52069115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:22:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo13496618a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1697721725; x=1698326525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3pSfkid+NE6ixcnRc69gMHhW0aTwHLFCkm71kYsxME=;
        b=dD3Kv2uPdOYVI7sNLPdNS8+hjU3JfD82pINFYFXZiO9vHQFC6N/e64JtvOO7j6vvsB
         HDYFpVTWMOfnhF/CtobjkQ1tC7fuJ9uF9zH6h2+Ne6XO/BsuIbd7lM5+kz+irX1iGV46
         zZp3Z8DsRGLSsl8MWcGfsfzcW/Da5VDYVLFs95BMIYHoMTot1zJA8Unt04mIfwhdB3uK
         fZUHGeaBChWmifxXlJARWqMRD6jJ/I2rWm9KV8JF+48Mxz6K87A7QGqVNCmRBhXgYAGU
         sS8hgWKKjqSEBNlR4f+MEZ4NUCYnRRFMqlmqyEqDR5kEgGrEYlGJyn5SwMn8UP7iGfSz
         mPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721725; x=1698326525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3pSfkid+NE6ixcnRc69gMHhW0aTwHLFCkm71kYsxME=;
        b=lVXW5Emb2awkgMf8p57OW35O1FSsPg/eC6HuFMC2LmSnb0PPz7KT5Vrlpmj4Fjdc6B
         id4dTvqB1KHTygORTEbAZAET8iS7bBbV1u34CAz3zPPoqfaLJvlFeeru5uX5X1zWsBw6
         9GO3nYU+lXCWhp/Ak7oGAxsvCdRxXMcWDOV0aCiFo//rW35cCwGPZoElpj55KPt5Wibx
         1JJcoiwMQqOT634rfOjSPCo4KDUdfMx6rMBgWN/rCnDAHWFfoQ8TcWMcW+GsS71Q+rM/
         zrhjGTAFD4c/mYl3tFy+tBNCEunvaHuFSFtqDqYUpmxQhb9R5/n2Zc0Uq6knC/MJSlxa
         8v/w==
X-Gm-Message-State: AOJu0YwbrBy+3tHB7K5xHAEpVCEnJ5KdvAvq7vw2bO4IA7jTQnQTUxzp
        rMka6VtRN9DQ0dbEFglJhyjrUNgA7hkJgvqLf4kT
X-Google-Smtp-Source: AGHT+IEBKD+r9u8iuZQVZMW4x4RDucBMtdtA6xpvJVjsOlqpHZ5FUg+FfH5xMof3TJOUrRC4y3QDXL0KTlq+n9pd9z0=
X-Received: by 2002:a50:d08f:0:b0:53d:b6ac:5f64 with SMTP id
 v15-20020a50d08f000000b0053db6ac5f64mr1748350edd.18.1697721724800; Thu, 19
 Oct 2023 06:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
 <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
 <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com>
 <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
 <CAJfuBxy9qn-4i3SteTL1LBbBxPrFM52KkBd=1UhcKV3S_KdQvw@mail.gmail.com>
 <20231011114816.19d79f43@eldfell> <ZSZuACLwt5_XAL2n@phenom.ffwll.local>
 <CAJfuBxytOcUDmPBO7uQ9mMRvpNvzA3tgg_-pSGmdXpjDPe5sNQ@mail.gmail.com>
 <CAK8Bye+v+fYsN-716vQKJCoTmDQWmTw_Z1ZGD2A=HvuuAApwig@mail.gmail.com> <CAJfuBxyFe4rDW2gUozPig9=dSS9b0oiADnTTGjOtCSJ=khA=wQ@mail.gmail.com>
In-Reply-To: <CAJfuBxyFe4rDW2gUozPig9=dSS9b0oiADnTTGjOtCSJ=khA=wQ@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Thu, 19 Oct 2023 15:21:52 +0200
Message-ID: <CAK8ByeLPCDgrwEwD3=+DscoDjmnu+4qHKKj4J5S_w5xerayP0w@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "wayland-devel@lists.freedesktop.org" 
        <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 18 pa=C5=BA 2023 o 05:08 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> adding in Jason, not sure how he got missed.
>
> On Mon, Oct 16, 2023 at 9:13=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > czw., 12 pa=C5=BA 2023 o 20:48 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > > If you want the kernel to keep separate flight recorders I guess we=
 could
> > > > add that, but I don't think it currently exists for the dyndbg stuf=
f at
> > > > least. Maybe a flight recorder v2 feature, once the basics are in.
> > > >
> > >
> > > dyndbg has   +p    writes to syslog
> > > +T  would separately independently write the same to global trace
> > >
> > > This would allow  graceful switchover to tracefs,
> > > without removing logging from dmesg, where most folks
> > > (and any monitor tools) would expect it.
> > >
> > > Lukas (iiuc) wants to steer each site to just 1 destination.
> > > Or maybe (in addition to +p > syslog) one trace destination,
> > > either global via events, or a separate tracebuf
> > >
> > > Im ambivalent, but thinking the smooth rollover from syslog to trace
> > > might be worth having to ease migration / weaning off syslog.
> > >
> > > And we have a 4 byte hole in struct _ddebug we could just use.
> >
> > I'm glad you brought that up. This means we can leave class_id field
> > untouched, have separate +T in flags (for consistency)
> > and dst_id can be easily 8 bits wide.
> >
> > Also can you point me to the latest version of writing debug logs to
> > trace events (+T option).
> > I would like to base trace instances work on that because both are
> > closely related.
> >
>
> Ive got 3 branches, all stacked up on rc6
> (last I checked, they were clean on drm-tip)
>
> https://github.com/jimc/linux/tree/dd-fix-7c
> the regression fix, reposting this version next.
> it also grabs another flag bit: _DPRINTK_FLAGS_INCL_LOOKUP
>
>
> https://github.com/jimc/linux/tree/dd-shrink-3b
> split modname,filename,function to new __dyndbg_sites section
> loads the 3 column values and their intervals into 3 maple trees
> and implements 3 accessor functions to retrieve the vals
> from the descriptor addresses.
> it "works" but doesnt erase intervals properly on rmmod
> it also claims another flag - _DPRINTK_FLAGS_PREFIX_CACHED
> and uses it to mark cached prefix fragment that get created for enabled c=
alls.
>
> https://github.com/jimc/linux/tree/dd-kitchen-sink
> this adds the +T flag stuff.
> its still a little fuzzy, esp around the descriptor arg -
> using it to render the prefix str at buffer-render time
> got UNSAFE warnings - likely due to loadable module
> descriptors which could or did go away between
> capture and render (after rmmod)
>

Great, I will use commits related to adding +T from this tree as a
baseline for adding trace instances.

>
>
>
> > > Unless the align 8 is optional on 32-bits,
> >
> > I verified with "gcc -g -m32 ..." that the align(8) is honored on 32 bi=
ts.
> >
>
> this is sorta the opposite of what I was probing, but I think result
> is the same.
> istm  align(8) is only for JUMP_LABEL, nothing else in the struct
> appears to need it
> so moving it to the top trades the hole for padding.
>

Ahh I see what you meant now.  Although I have to admit that looking
at the jump label code and static key usage cases
around the kernel code I don't see where align(8) requirement for jump
label comes from.

>
>
> > > I think we're never gonna close the hole anywhere.
> > >
> >
> > :)
> >
> > > is align 8 a generic expression of an architectural simplifying const=
raint ?
> > > or a need for 1-7 ptr offsets ?
> > >
> > >
> > >
> > >
> > > > > That's my idea of it. It is interesting to see how far the requir=
ements
> > > > > can be reasonably realised.
> > > >
> > > > I think aside from the "make it available directly to unpriviledged
> > > > userspace" everything sounds reasonable and doable.
> > > >
> > > > More on the process side of things, I think Jim is very much lookin=
g for
> > > > acks and tested-by by people who are interested in better drm loggi=
ng
> > > > infra. That should help that things are moving in a direction that'=
s
> > > > actually useful, even when it's not yet entirely complete.
> > > >
> > >
> > > yes, please.  Now posted at
> > >
> > > https://lore.kernel.org/lkml/20231012172137.3286566-1-jim.cromie@gmai=
l.com/T/#t
> > >
> > > Lukas, I managed to miss your email in the send phase.
> > > please consider yourself a direct recipient :-)
> > >
> > > thanks everyone
> > >
> > > > Cheers, Sima
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
