Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6127BAABA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjJETww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJETwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:52:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3FCE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 12:52:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso258841466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696535566; x=1697140366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxDtktB+suAurP27xOoQABfqd/VT1E6iw5B33oUMYZQ=;
        b=Z3VjpX+WiZ31yf3GivCjjyE01cCcmRAKGK9RONxSKea/zlvMzgc2NNuw8iy5DCJ2hW
         ZM5qh03qAUwAOA/BZBBSmo8K+PaIMOsBGRmyhu0owsWNz4PZKUDxh8PWR+wR0VMRY/Bc
         0zZs5EFjboWMuANe1vRdDBmuRZSlSoth1XKe7PGs5/4NxhjLHJ0FUeCUoNrVCUIPGiTL
         rRTGa3E79OW4FxARCoJEeRs9MitzsLp1TKr2/TPHiuWYTYoNwDG96fBX879Q8+yiqFTC
         835OSQrtXKKxsiaDidzuH2oc0xZBz3yEGmS42lkU9yPjc94x2SpSH/hu1xam7/uMJddf
         OWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696535566; x=1697140366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxDtktB+suAurP27xOoQABfqd/VT1E6iw5B33oUMYZQ=;
        b=Lm0BUU+aB35w137M2Fy76J/qAzObBSq1FRsyNEm0l4oe4oOzLYAFacZdVSQFydxOiN
         IFd6MHpeTXwBhLHkT/ivLgM72FBU5hMUsJ/txIlac0lOsxo+BcNDfQT+/2rAgHAI7AV1
         XgYLcZKRZQO5D07BsNfCyemDlKhg8NGPfs6evyFMt9swk7aXyI3QQCaTeJteTxOL+Qn0
         fQ8ZDprTifQv04rYG6eqHpth9XN9apEB121nlk1tsMep+trDQ5eSwc2FWc/ZojA0L1Ru
         Ylm0z/B5J4+K+0xKEaK4/FDeLi1xIoliieGm1SaKkiU9PrVlE9Sm6iyd4paoFclN2ABC
         N3Ww==
X-Gm-Message-State: AOJu0Ywm/WemYd5cTQeMYL1VQ/FBcTB5UlUprWxeSTCU1YIgVe/uCFii
        hu6SPMiq43yV/NsVlJLtLdB1Usp6duoJUPAEfEeHiw==
X-Google-Smtp-Source: AGHT+IF0PaeMqn+ciWfpNtRBx9QXyxqaGwKFijUB9k4Kdmi6Psa0Wuzego6ADgpdOKf9zUvQ3l7FTKhkNfHxsZbjyR0=
X-Received: by 2002:a17:906:3012:b0:9ae:4054:5d2a with SMTP id
 18-20020a170906301200b009ae40545d2amr5322327ejz.16.1696535566465; Thu, 05 Oct
 2023 12:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
 <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
 <CAFhGd8oTHFDQ05M++E3ggAvs0567w5fSxovumX+vs8YXT8VXTA@mail.gmail.com>
 <6e13b9b1a964b49079a2f7814c0d65e767cd010a.camel@perches.com>
 <CAFhGd8rGr3fm-U3XCjRkJQRymvjqGFYzsPu61zbMZCebuN5Rww@mail.gmail.com> <a8b680c03379ed7a07418e471b29dccd801f23cb.camel@perches.com>
In-Reply-To: <a8b680c03379ed7a07418e471b29dccd801f23cb.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 5 Oct 2023 12:52:34 -0700
Message-ID: <CAFhGd8rGZ6w7bz90LRnwd_1K3ibR2KsT6cJ2kiuO5mSAdnWjFw@mail.gmail.com>
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

On Thu, Oct 5, 2023 at 11:42=E2=80=AFAM Joe Perches <joe@perches.com> wrote=
:
>
> On Thu, 2023-10-05 at 11:30 -0700, Justin Stitt wrote:
> > On Thu, Oct 5, 2023 at 11:15=E2=80=AFAM Joe Perches <joe@perches.com> w=
rote:
> > >
> > > On Thu, 2023-10-05 at 11:06 -0700, Justin Stitt wrote:
> > > > On Wed, Oct 4, 2023 at 7:40=E2=80=AFPM Joe Perches <joe@perches.com=
> wrote:
> > > > >
> > > > > On Wed, 2023-10-04 at 21:21 +0000, Justin Stitt wrote:
> > > > > > The current behavior of K: is a tad bit noisy. It matches again=
st the
> > > > > > entire contents of files instead of just against the contents o=
f a
> > > > > > patch.
> > > > > >
> > > > > > This means that a patch with a single character change (fixing =
a typo or
> > > > > > whitespace or something) would still to/cc maintainers and list=
s if the
> > > > > > affected file matched against the regex pattern given in K:. Fo=
r
> > > > > > example, if a file has the word "clang" in it then every single=
 patch
> > > > > > touching that file will to/cc Nick, Nathan and some lists.
> > > > > >
> > > > > > Let's change this behavior to only content match against patche=
s
> > > > > > (subjects, message, diff) as this is what most people expect th=
e
> > > > > > behavior already is. Most users of "K:" would prefer patch-only=
 content
> > > > > > matching. If this is not the case let's add a new matching type=
 as
> > > > > > proposed in [1].
> > > > >
> > > > > I'm glad to know  you are coming around to my suggestion.
> > > > :)
> > > >
> > > > >
> > > > > I believe the file-based keyword matching should _not_ be
> > > > > removed and the option should be added for it like I suggested.
> > > >
> > > > Having a command line flag allowing get_maintainer.pl
> > > > users to decide the behavior of K: is weird to me. If I'm a maintai=
ner setting
> > > > my K: in MAINTAINERS I want some sort of consistent behavior. Some
> > > > patches will start hitting mailing list that DO have keywords in th=
e patch
> > > > and others, confusingly, not.
> > >
> > > Not true.
> > >
> > > If a patch contains a keyword match, get_maintainers will _always_
> > > show the K: keyword maintainers unless --nokeywords is specified
> > > on the command line.
> >
> > ...
> >
> > >
> > > If a file contains a keyword match, it'll only show the K:
> > > keyword  if --keywords-in-file is set.
> >
> > Right, what I'm saying is a patch can arrive in a maintainer's inbox
> > wherein the patch itself has no mention of the keyword (if
> > get_maintainer user opted for --keywords-in-file). Just trying to
> > avoid some cases of the question: "Why is this in my inbox?"
>
> Because the script user specifically asked for it.
>
> > > > To note, we get some speed-up here as pattern matching a patch that
> > > > touches lots of files would result in searching all of them in thei=
r
> > > > entirety. Just removing this behavior _might_ have a measurable
> > > > speed-up for patch series touching dozens of files.
> > >
> > > Again, not true.
> > >
> > > Patches do _not_ scan the original modified files for keyword matches=
.
> > > Only the patch itself is scanned.  That's the current behavior as wel=
l.
> > >
> >
> > Feel like I'm missing something here. How is K: matching keywords in
> > files without reading them.
> >
> > If my patch touches 10 files then all 10 of those files are scanned for
> > K: matches right?
>
> Nope.
>
> Understand the patches are the input to get_maintainer and not
> just files.
>
> If a patch is fed to get_maintainer then any files modified by
> the patch are _not_ scanned.
>
> Only the patch _content_ is used for keyword matches.
>

Got it. I'll roll your patch into a v3.

Thanks
Justin
