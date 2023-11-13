Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9347EA3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjKMTRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjKMTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:17:39 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B33527D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:15:24 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so1917986241.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699902924; x=1700507724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdlPS/pyygBulJYw0Ss7dnRkR9HsnG2KcJpv/WTkXTk=;
        b=gKJ5S+vlBx9h6SBsFKIwaIiOlTlmJzG0mAQMqtHmi6Y7bRfxvuCGg7lxdrLrNwqI9/
         TI/t5Vnnk+I0M0pYrCHji+GgW+8bi46YgbdDMCAOXjxvk+jTjRFRaraUQzJEeZYUpT79
         H9RrDDxz79iQb654lzRBNR0tB6PdESJB/Mgu/8X2d0XXGVQcFF9iLJQLbm11spF/Zktx
         8QFVUf82oFpRFkDUF2n+OyXGbAvfCwJiVwgGxBEZ0kVeeDKTxjgBc4ujjvSSj6tamndC
         1TUioPwFn/clRkr7fx7bvvLsrdpDkuez8ta+4VpR+N+rqrhjG+1pUgNbMa5dFeZ8Dva/
         wv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699902924; x=1700507724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdlPS/pyygBulJYw0Ss7dnRkR9HsnG2KcJpv/WTkXTk=;
        b=rXkgnqtN4OHHQuEWAp8GfT8Dw2OtlI1ysW86nnLi4uiJBexi3TqVH0xhqYcwYPPDXn
         ZRKOFN7c4H5e5jfc71gBgY0lD1dvBrxw0avq606F5XQ9IhHYxYEe8GC0saDoILxI7oX5
         wX4lS5r1L/+nFtMVFxAaIthRTAfZB7grlCO3dZiiFGGRWk8i1n8eAgOElsfzprFkEV4c
         k9hUKEicdd+lPAHnKq6DWZUblniWR/82dPCw+bE4+F63FTg+vvyWIE6g7pa8Li8Wtf9n
         Lo9Vs+tjagRGvZ65Tjw7DNXlZWFuN/KZ6L7M7uccJP1ycmTqFtgh7LNMogUlml5ZnTps
         yeVA==
X-Gm-Message-State: AOJu0YyFzPTVMv58fnUZh+KHXs/etbkH11qhjfWjsqgIHFt/8xt6fpRd
        jAVAMuPal7sYQ5qUsnVtDT06qEmkdAt+RVDGCL8=
X-Google-Smtp-Source: AGHT+IF7gh1x8kbVW7JTi/JQ+4UbauUOckNaRiSSZ2YAlsE06DXlN3lNBqNHRVapO0IwajHHemCmdvMBtaPBxx7A+Yk=
X-Received: by 2002:a05:6102:2d06:b0:45d:aa3e:a78 with SMTP id
 ih6-20020a0561022d0600b0045daa3e0a78mr9970637vsb.10.1699902923569; Mon, 13
 Nov 2023 11:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-11-lb@semihalf.com>
 <CAJfuBxxVGaqG4wVu-kM3ynA8ARTD6DFPBuz0a1GqunMqdvRBgQ@mail.gmail.com>
 <CAK8ByeL9UJzNr=kAdyHZcdt6-B8c57OxUW+ccm4GmLrW26CxDg@mail.gmail.com>
 <CAJfuBxxTuiEun9YFtWY_99nvCwnJQ_LByJioOTxsCkMS6URQnw@mail.gmail.com> <CAK8Bye+jVZwAta7mfd=zY2qk84MR3dRrX-6iZYhijTcO-o_uFg@mail.gmail.com>
In-Reply-To: <CAK8Bye+jVZwAta7mfd=zY2qk84MR3dRrX-6iZYhijTcO-o_uFg@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 13 Nov 2023 12:14:57 -0700
Message-ID: <CAJfuBxwmxbmGmjOYU7VcnTovv-FS-cKZQ5rP8LK6DXP1HrdA9Q@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] dyndbg: add processing of T(race) flag argument
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 9:29=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> pt., 10 lis 2023 o 20:51 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Nov 10, 2023 at 7:52=E2=80=AFAM =C5=81ukasz Bartosik <lb@semiha=
lf.com> wrote:
> > >
> > > sob., 4 lis 2023 o 04:06 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > >
> > > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@sem=
ihalf.com> wrote:
> > > > >
> > > > > Add processing of argument provided to T(race) flag.
> > > > > The argument value determines destination of debug logs:
> > > > >
> > > > > 0 - debug logs will be written to prdbg and devdbg trace events
> > > > > [1..255] - debug logs will be written to trace instance
> > > > >
> > > > > A user can provide trace destination by folowing T flag with
> > > > > ":" and trace destination value in range [0..255], for example:
> > > > >
> > > > > echo "module thunderbolt =3DpT:7" > /sys/kernel/debug/dynamic_deb=
ug/control
> > > > > echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_d=
ebug/control
> > > > >
> > > > > When T flag with argument is followed by other flags then the nex=
t flag has
> > > > > to be preceded with ",".
> > > > >
> > > >
> > > > the trailing , seems punctuation heavy.
> > > > Could we just stipulate that any :string  (leading : trailing anyth=
ing)
> > > > be the last flag in the spec ?
> > > > bare T flags are not constrained otherwise.
> > > > seems fine as API-spec-by-error-codes.
> > > >
> > >
> > > I followed Jason's suggestion to use "," when T flag is not the last
> > > flag and destination is explicitly provided for the T flag, like in
> > > the example above
> > > "echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_debu=
g/control".
> > >
> > > With "," we can have the following cases:
> > > - when T is the last flag then it doesn't need to be followed by ","
> > > even if destination is explicitly provided, for example "lpT:7",
> > > - when T is not the last flag and destination is explicitly provided
> > > then "," has to be used before next flag, for example "lT:7,p",
> > > - when T is not the last flag and destination is not explicitly
> > > provided then "," is not required, for example "lTp",
> > >
> > > Jim, Jason, would you please come to terms if we want to use "," or
> > > just assume that T has to be the last flag in the spec ?
> > >
> >
> > Im fine either way -   eliminating punctuation has a cost too,
> > it adds some order dependency which isnt there now.
> > If that complicates the code, no-good.
> >
>
> Ok, I will keep the option to use "," to separate T with explicitly
> provided destination from a next flag.
>
> >
> > > >
> > > >
> > > >
> > > > > When no value is provided trace destination defaults to 0, for ex=
ample:
> >
> > That seems wrong now - it should default to whatever it was previously =
set to,
> >
>
> It was in my original proposal before you suggested to create
> open/close commands.
>
>
> > this allows setting a non-default dest while disabling the site:
> >    echo class DRM_UT_CORE -T:core-log  > /proc/dynamic_debug/control
> >
> > then just enabling it later, to use the preset dest
> >    echo class DRM_UT_CORE +T  > /proc/dynamic_debug/control
> > or more likely:
> >    echo 0x01 > /sys/module/drm/parameters/debug_trace
> >
> > this way, debug_trace is just like debug, but still can write to the
> > separate trace-instances
> >
>
> Ack, I also clarified my suggestion related to this topic in patch 11.
>

to reiterate and add context:

echo 0x01 > /sys/module/drm/parameters/debug
is the legacy way of enabling DRM_UT_CORE logging.
in CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy builds,
this uses classmaps, but controls only the +p flag.

echo 0x01 > /sys/module/drm/parameters/debug_trace
doesnt exist yet, but is simple to add with the classmap impl.

this legacy interface cannot handle private trace-instances.
only >control  can do that.
ISTM thats fine.
