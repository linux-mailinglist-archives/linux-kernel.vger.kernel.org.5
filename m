Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B684D7BAB45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjJEUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjJEUKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:10:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AC8E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:10:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so2385631a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696536640; x=1697141440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDEWPhSFZT2wrr3lmK3HQACNYGeh2PGdg05lzm75XYw=;
        b=ZyxS2oNYLc1SjY9u5UhomTI2VO1W6BPg0xWKcJAMXGA8eX0e0z1QgSxbQdI3kyl/o5
         P24Dq6ejvaiU2gLVEbruuaKxJ3KMhnp/6UfbHgx3y1d+XMejob82saUTU1zHUBem1OZB
         RRVF/LY6wO0RbwYmV8cR/DPv4yjspwWzH7eG99nF1/dOpiuy8AEg06iTAaqbmyz4ezSH
         BEA6y1zT363b7kTgn/ui/XCgNz/W/p9xTf4SeBdp2hQvZGO4VA3QR9DM5q2WinIrTwCc
         H3Y9tbLWYUI57lrOk+vH+YoSOqQWi/6ltyKdO0E/H3o+mcZD86GpPfFCylVWeYh8wKIK
         U3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696536640; x=1697141440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDEWPhSFZT2wrr3lmK3HQACNYGeh2PGdg05lzm75XYw=;
        b=qVSvVNJZGIZg3eSY2VglHge/77maZq2k9UEgV349KGK0vb6V4Xzf8AEujjjPnNga3B
         qBImj9OVolQpQ1w/SiAOx/0g4Vnja8mTDNCLtPTGsneyjYs3LIxdkb80mWlbZV6kAnHs
         qECVnti0QMZB6M/P6a83HjrZLtgm097xCh6Rr2/+dbXz/F4Fy+hRWVHvyohaTADnmSWy
         EgWolt3p/HZQg8/wV038N6Mp/Z2exw3/22i+QpOvwpe16ID/UeU2jVAnEUEV8MYtsvgF
         UwbGVv6lfWSjKQJMmaWDcV9LvsX1s3PhmhSrCl9JRm3KHN5dLZT3awh5bjPNLivRa8aX
         p1/Q==
X-Gm-Message-State: AOJu0Yy7k7iMDGLUUir7962wQ+gAYLyckfUWV2aosOppC+19hW3/LhNy
        FJHx6IQ4Iytqk1Cc3n47nSG3biLZEIOst33NRocL9w==
X-Google-Smtp-Source: AGHT+IGmRqAhhgC6r5i5H8FuY2pS87uhv9hSsrz4ZgPgSwVKtydn6UqIDH22wogY2BL1vHz/cPGmiJLK11Q1xLAy2g0=
X-Received: by 2002:aa7:d503:0:b0:538:ae5:6138 with SMTP id
 y3-20020aa7d503000000b005380ae56138mr6430924edq.34.1696536639868; Thu, 05 Oct
 2023 13:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
 <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
 <CAFhGd8oTHFDQ05M++E3ggAvs0567w5fSxovumX+vs8YXT8VXTA@mail.gmail.com>
 <6e13b9b1a964b49079a2f7814c0d65e767cd010a.camel@perches.com>
 <CAFhGd8rGr3fm-U3XCjRkJQRymvjqGFYzsPu61zbMZCebuN5Rww@mail.gmail.com>
 <a8b680c03379ed7a07418e471b29dccd801f23cb.camel@perches.com>
 <CAFhGd8rGZ6w7bz90LRnwd_1K3ibR2KsT6cJ2kiuO5mSAdnWjFw@mail.gmail.com> <eea5087a2bd94b80b5a16af95a4caf20376bbc52.camel@perches.com>
In-Reply-To: <eea5087a2bd94b80b5a16af95a4caf20376bbc52.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 5 Oct 2023 13:10:28 -0700
Message-ID: <CAFhGd8r6B=PAXNzDEOaWAVOHdH+3ZKOCuAqadvR3cXtAy4gQDg@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer/MAINTAINERS: confine K content matching to patches
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 1:05=E2=80=AFPM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2023-10-05 at 12:52 -0700, Justin Stitt wrote:
> > On Thu, Oct 5, 2023 at 11:42=E2=80=AFAM Joe Perches <joe@perches.com> w=
rote:
> > >
> > > On Thu, 2023-10-05 at 11:30 -0700, Justin Stitt wrote:
> > > > On Thu, Oct 5, 2023 at 11:15=E2=80=AFAM Joe Perches <joe@perches.co=
m> wrote:
> > > > >
> > > > > On Thu, 2023-10-05 at 11:06 -0700, Justin Stitt wrote:
> > > > > > On Wed, Oct 4, 2023 at 7:40=E2=80=AFPM Joe Perches <joe@perches=
.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2023-10-04 at 21:21 +0000, Justin Stitt wrote:
> > > > > > > > The current behavior of K: is a tad bit noisy. It matches a=
gainst the
> > > > > > > > entire contents of files instead of just against the conten=
ts of a
> > > > > > > > patch.
> > > > > > > >
> > > > > > > > This means that a patch with a single character change (fix=
ing a typo or
> > > > > > > > whitespace or something) would still to/cc maintainers and =
lists if the
> > > > > > > > affected file matched against the regex pattern given in K:=
. For
> > > > > > > > example, if a file has the word "clang" in it then every si=
ngle patch
> > > > > > > > touching that file will to/cc Nick, Nathan and some lists.
> > > > > > > >
> > > > > > > > Let's change this behavior to only content match against pa=
tches
> > > > > > > > (subjects, message, diff) as this is what most people expec=
t the
> > > > > > > > behavior already is. Most users of "K:" would prefer patch-=
only content
> > > > > > > > matching. If this is not the case let's add a new matching =
type as
> > > > > > > > proposed in [1].
> > > > > > >
> > > > > > > I'm glad to know  you are coming around to my suggestion.
> > > > > > :)
> > > > > >
> > > > > > >
> > > > > > > I believe the file-based keyword matching should _not_ be
> > > > > > > removed and the option should be added for it like I suggeste=
d.
> > > > > >
> > > > > > Having a command line flag allowing get_maintainer.pl
> > > > > > users to decide the behavior of K: is weird to me. If I'm a mai=
ntainer setting
> > > > > > my K: in MAINTAINERS I want some sort of consistent behavior. S=
ome
> > > > > > patches will start hitting mailing list that DO have keywords i=
n the patch
> > > > > > and others, confusingly, not.
> > > > >
> > > > > Not true.
> > > > >
> > > > > If a patch contains a keyword match, get_maintainers will _always=
_
> > > > > show the K: keyword maintainers unless --nokeywords is specified
> > > > > on the command line.
> > > >
> > > > ...
> > > >
> > > > >
> > > > > If a file contains a keyword match, it'll only show the K:
> > > > > keyword  if --keywords-in-file is set.
> > > >
> > > > Right, what I'm saying is a patch can arrive in a maintainer's inbo=
x
> > > > wherein the patch itself has no mention of the keyword (if
> > > > get_maintainer user opted for --keywords-in-file). Just trying to
> > > > avoid some cases of the question: "Why is this in my inbox?"
> > >
> > > Because the script user specifically asked for it.
> > >
> > > > > > To note, we get some speed-up here as pattern matching a patch =
that
> > > > > > touches lots of files would result in searching all of them in =
their
> > > > > > entirety. Just removing this behavior _might_ have a measurable
> > > > > > speed-up for patch series touching dozens of files.
> > > > >
> > > > > Again, not true.
> > > > >
> > > > > Patches do _not_ scan the original modified files for keyword mat=
ches.
> > > > > Only the patch itself is scanned.  That's the current behavior as=
 well.
> > > > >
> > > >
> > > > Feel like I'm missing something here. How is K: matching keywords i=
n
> > > > files without reading them.
> > > >
> > > > If my patch touches 10 files then all 10 of those files are scanned=
 for
> > > > K: matches right?
> > >
> > > Nope.
> > >
> > > Understand the patches are the input to get_maintainer and not
> > > just files.
> > >
> > > If a patch is fed to get_maintainer then any files modified by
> > > the patch are _not_ scanned.
> > >
> > > Only the patch _content_ is used for keyword matches.
> > >
> >
> > Got it. I'll roll your patch into a v3.
> >
>
> Actually, I have a slightly improved patch as
> the actual keyword is shown too.
>
> I'll get it uploaded and make sure you are credited
> with the effort to make the change.
>

Dang, we just collided in mid-air. I just sent a new patch.
Let's disregard my patch that was sent.

Thanks for the efforts here. I appreciate it.

> cheers, Joe

Thanks
Justin
