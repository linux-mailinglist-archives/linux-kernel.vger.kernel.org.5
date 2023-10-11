Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773537C4F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjJKJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:42:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F6791
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:42:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406553f6976so17003855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1697017347; x=1697622147; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHZc3uBW9IIAR3rBehSgAGKb6AZ2IUIIfp7RDHag/Ng=;
        b=K2LQzL/bjGZLBulCip4vCroqYBeXwyVUwIg8FzdsXgYfMSXgTMO2iq4e44obASdUBA
         bczR7iG3Z435ZLGv9iFIlT8TmVUVleIwtHZJlwE2ODvqyHWwwS+lOTArIgzlsnKc7HRV
         muPJ0uVQI7akPXHHtdVV4blI+oJDTiDgz6ZGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697017347; x=1697622147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHZc3uBW9IIAR3rBehSgAGKb6AZ2IUIIfp7RDHag/Ng=;
        b=SAJRjIsEsx83F8tZlHXPF3b/2/CRAcrF69fHO6083lKwPrtpBMPFsFoSLJTHbt0tFp
         7lhkxs+oDHOarxU9wKyM3IYXhk6aBrswFOiHrlnwRKStBGBUdlRn5gzmbtnO0TjmsC8W
         G2VbiBF1ZS5uLcrwRZodyJ73r1DPYiLQNBavrJXtgODpUcKg8IttcCgF8S8/yM4Uz/+D
         KGCi2JW96ac3prgDBtRNH9UQg88FKlwtGVBSyHGfgTmZuu5K8oW9mUYhxhcnKbgK4YbP
         KFZN8bLF2D84uYq9pFFhxuyUmBbK/lSOQKDcyzdyu0UP6tMMrME7g+0PcITGZY5ePNj2
         djLA==
X-Gm-Message-State: AOJu0YzpSihqwK7VIUE4SxTCm+W9IJHDDDcFGdHDnVbNGh9hxue8GMpL
        bwCTlWcigizPY79OlxVswvs1Bg==
X-Google-Smtp-Source: AGHT+IGXFBdyFz2gREF34kBsSRJt/P1uZ2NH2QgSfhCvEFM5aD2Qa9v5uopir1DX9UXcxkU+MG7lJg==
X-Received: by 2002:a05:600c:1c1f:b0:405:38d1:621 with SMTP id j31-20020a05600c1c1f00b0040538d10621mr18116725wms.3.1697017347495;
        Wed, 11 Oct 2023 02:42:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003feae747ff2sm18644018wmi.35.2023.10.11.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:42:26 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:42:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     jim.cromie@gmail.com,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "wayland-devel@lists.freedesktop.org" 
        <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
Message-ID: <ZSZuACLwt5_XAL2n@phenom.ffwll.local>
Mail-Followup-To: Pekka Paalanen <ppaalanen@gmail.com>,
        jim.cromie@gmail.com,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home>
 <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
 <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
 <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com>
 <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
 <CAJfuBxy9qn-4i3SteTL1LBbBxPrFM52KkBd=1UhcKV3S_KdQvw@mail.gmail.com>
 <20231011114816.19d79f43@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011114816.19d79f43@eldfell>
X-Operating-System: Linux phenom 6.5.0-1-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:48:16AM +0300, Pekka Paalanen wrote:
> On Tue, 10 Oct 2023 10:06:02 -0600
> jim.cromie@gmail.com wrote:
> 
> > since I name-dropped you all,
> 
> Hi everyone,
> 
> I'm really happy to see this topic being developed! I've practically
> forgot about it myself, but the need for it has not diminished at all.
> 
> I didn't understand much of the conversation, so I'll just reiterate
> what I would use it for, as a Wayland compositor developer.
> 
> I added a few more cc's to get better coverage of DRM and Wayland
> compositor developers.
> 
> > On Tue, Oct 10, 2023 at 10:01 AM <jim.cromie@gmail.com> wrote:
> > >
> > > On Mon, Oct 9, 2023 at 4:47 PM Łukasz Bartosik <lb@semihalf.com> wrote:  
> 
> ...
> 
> > > > I don't have a real life use case to configure different trace
> > > > instance for each callsite.
> > > > I just tried to be as much flexible as possible.
> > > >  
> > >
> > > Ive come around to agree - I looked back at some old threads
> > > (that I was a part of, and barely remembered :-}
> > >
> > > At least Sean Paul, Lyude, Simon Ser, Pekka Paalanen
> > > have expressed a desire for a "flight-recorder"
> > > it'd be hard to say now that 2-3 such buffers would always be enough,
> > > esp as theres a performance reason for having your own.
> 
> A Wayland compositor has roughly three important things where the kernel
> debugs might come in handy:
> - input
> - DRM KMS
> - DRM GPU rendering
> 
> DRM KMS is the one I've been thinking of in the flight recorder context
> the most, because KMS hardware varies a lot, and there is plenty of
> room for both KMS drivers and KMS userspace to go wrong. The usual
> result is your display doesn't work, so the system is practically
> unusable to the end user. In the wild, the simplest or maybe the only
> way out of that may be a reboot, maybe an automated one (e.g. digital
> signage). In order to debug such problems, we would need both
> compositor logs and the relevant kernel debug messages.
> 
> For example, Weston already has a flight recorder framework of its own,
> so we have the compositor debug logs. It would be useful to get the
> selected kernel debug logs in the same place. It could be used for
> automated or semi-manual bug reporting, for example, making the
> administrator or end user life much easier reporting issues.
> 
> Since this is usually a production environment, and the Wayland
> compositor runs without root privileges, we need something that works
> with that. We would likely want the kernel debug messages in the
> compositor to combine and order them properly with the compositor debug
> messages.
> 
> It's quite likely that developers would like to pick and choose which
> kernel debug messages might be interesting enough to record, to avoid
> excessive log flooding. The flight recorder in Weston is fixed size to
> avoid running out of memory or disk space. I can also see that Weston
> could have debugging options that affect which kernel debug messages it
> subscribes to. We can have a reasonable default setup that allows us to
> pinpoint the problem area and figure out most problems, and if needed,
> we could ask the administrator pass another debug option to Weston. It
> helps if there is just one place to configure everything about the
> compositor.
> 
> This implies that it would be really nice to have userspace subscriber
> specific debug message streams from the kernel, or a good way to filter
> the messages we want. A Wayland compositor would not be interested in
> file system or wireless debugs for example, but another system
> component might be. There is also a security aspect of which component is
> allowed to see which messages in case they could contain anything
> sensitive (input debug could contain typed passwords).
> 
> Configuring the kernel debug message selection for our debug message
> stream can and probably should require elevated privileges, and we can
> likely solve that in userspace with a daemon or such, to allow the
> Wayland compositor to run as a regular user.
> 
> Thinking of desktop systems, and especially physically multi-seat systems:
> - there can be multiple different Wayland compositors running simultaneously
> - each of them may want debug messages only from a specific DRM KMS
>   device instance, and not from others
> - each of them may have a different idea of which debug messages are important
> - because DRM KMS leasing is a thing, different compositor instances
>   could be using the same DRM KMS device instance simultaneously; since
>   this is specific to DRM KMS, and it should be harmless to get a
>   little too much DRM KMS debug (that is, from the whole device instead
>   of just the leased parts), it may not be worth to consider splitting
>   debug message streams this far.
> 
> If userspace is offered some standardised fields in kernel debug
> structures, then userspace could do some filtering on its own too, but I
> guess it would be better to filter at the source and not need that.
> 
> There is also an anti-goal. The kernel debug message contents are
> specifically not machine-parsable. I very much do not want to impose
> debug strings as ABI, they are for human (and AI?) readers only.
> 
> 
> As a summary, here are the most important requirements first:
> - usable in production as a normal thing to enable always by default
> - final delivery to unprivileged userspace process

I think this is the one that's trickiest, and I don't fully understand why
you need it. The issues I'm seeing:

- logs tend to leak a lot of kernel internal state that's useful for
  attacks. There's measures for the worst (like obfuscating kernel
  pointers by hashing them), so there's always going to be a difference
  here between what full sysadmin can get and what unpriviledged userspace
  can get. And there's always a risk we miss something that we should
  obfuscate but didn't.

- handing this to userspace increases the risks it becomes uapi. Who's
  going to stop compositors from sussing out the reason an atomic commit
  failed from the logs if they can get them easily, and these logs contain
  very interesting information about why something failed?

  Much better if journald or a crash handler assemebles all the different
  flight recorder logs and packages it into a bug report so that the
  compositor cannot ever get at these directly. Yeah this needs some OS
  support with a dbus request or similar so that the compositor can ask
  for a crash dump with everything relevant to its session.

- the idea of an in-kernel flight recorder is that it's really fast. The
  entire tracing infra is built such that recording an event is really
  quick, but printing it is not - the entire string formatting is delayed
  to when userspace reads the buffers. If you constantly push the log
  messages to userspace we toss the advantage of the low-overhead
  in-kernel flight recorder. If you push logs to dmesg there's a
  substantial measureable overhead which you don't really want in
  production, and your requirement would impose the same.

- I'm not sure how this is supposed to mesh with userspace log aggregators
  like journald when every compositor has it's own flight recorder on top.
  Feels a bit like a solution that ignores the entire os stack and assumes
  that the only pieces we can touch are the kernel and the compositor to
  get to such a flight recorder.

  You might object that events will get out-of-order if you merge multiple
  logs after the fact, but that's the case anyway if we use the tracing
  framework since that's always a ringbuffer within the kernel and not
  synchronous. The only thing we could do is allow userspace to push
  markers into that ringbuffer, which is easily done by adding more debug
  output lines (heck we could even add a logging cookie to certain ioctl
  when userspace really cares about knowing exact ordering of it's
  requests with the stuff the kernel does).

- If you really want direct deliver to userspace I guess we could do
  something where sessiond opens the flight recorder fd for you, sets it
  all up and passes it to the compositor. But I'm really not a big fan of
  sending the full kms dbg spam to compositors to freely digest in real
  time.

> - per debug-print selection of messages (finer or coarser, categories
>   within a kernel sub-system could be enough)
> - per originating device (driver instance) selection of messages

The dyndbg stuff can do all that already, which is why I'm so much in
favour of relying on that framework.

> - all selections tailored separately for each userspace subscriber
> (- per open device file description selection of messages)

Again this feels like a userspace problem. Sessions could register what
kind of info they need for their session, and something like journald can
figure out how to record it all.

If you want the kernel to keep separate flight recorders I guess we could
add that, but I don't think it currently exists for the dyndbg stuff at
least. Maybe a flight recorder v2 feature, once the basics are in.

> That's my idea of it. It is interesting to see how far the requirements
> can be reasonably realised.

I think aside from the "make it available directly to unpriviledged
userspace" everything sounds reasonable and doable.

More on the process side of things, I think Jim is very much looking for
acks and tested-by by people who are interested in better drm logging
infra. That should help that things are moving in a direction that's
actually useful, even when it's not yet entirely complete.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
