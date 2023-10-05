Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911607BA91F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjJESbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJESbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:31:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B75A6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:31:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-327be5fe4beso1239151f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696530661; x=1697135461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ct+AkMEgp1QkkUYEj6CQZHQ0//yvYcFdWaKg1efiRw=;
        b=smpWQWty0mBai19eQbSSKcKS6l/c3SxwtK9e7B+E/ef/5Frt83+m+HY37xVXTz+2SB
         TibMW8GNq0aAbcfg1m6nsZLmX6fdlN8pVXnwEggS5ZfxbQoLAWQoI18Nu30wv5lYEllr
         ni8n/elv5PNr6ierpgqgw8S5OGz/UimD1w73yU4G0HKYUl4vGLiW6K61mdKTyG4d+X9I
         aN5Bs05n1hI09w6FfQaNfjvNhxb8+m60GZvFPrzqP7oQcO1of62+OTFb+Rsott/UQQpj
         216gdHDmrky1nNl+cb89OLUuEXVv6Wwx7vEI8hCzrvpx6DH6l4so+9TRiCAqaAp1D9hd
         D6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530661; x=1697135461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ct+AkMEgp1QkkUYEj6CQZHQ0//yvYcFdWaKg1efiRw=;
        b=Dn5Ldksse0D3tcAYmp1Tk5bjilLbW6R5+euJGm8FjHhxBJ7UIiZt+Lv7xvVpS1fAb1
         mucjM0lw3Y8w+4/y+S6Au4DIGgqyyIzcUPH1Gao+HA1K1sUMdv/A8aX8xT37c4rh6L2z
         gi+jo+h/VXu9W2k4ptbZyfQRylPOZhwy5ygbNyBpVnkT/HcRkZ/xWQn16usdb0FP7vYa
         3tgKkucEozvhtbqxfqsvrL1ikW4cXJZwfxN/QhfpI58BS729IeeeP0Cfstog6vnJMGKR
         d6HQDW1wFls5f4Qa11A+VYTMUfjUcChu86Lm2u4vjuITjAQ2/4FNkAqsvtDMTdlu+Rvp
         7AUQ==
X-Gm-Message-State: AOJu0YymtBcTq7l1X+H+faK1+DLJ+GrgxfjszJaOoEx7ZmtLKdL0iyZ1
        iBFeTp/TR/iueo4Xcs05QC+SGFR6Rk10/7CUatuy2w==
X-Google-Smtp-Source: AGHT+IGYhKlWVxgkWpQZjJbT1GNRTG9pGZEQrwu3fXCJVkckhu9WcQqlRRfiNIJTqAGn4kEqIwXLv0yjSA5OPS+NKLk=
X-Received: by 2002:adf:f892:0:b0:321:3c37:ec81 with SMTP id
 u18-20020adff892000000b003213c37ec81mr5105399wrp.10.1696530661284; Thu, 05
 Oct 2023 11:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
 <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
 <CAFhGd8oTHFDQ05M++E3ggAvs0567w5fSxovumX+vs8YXT8VXTA@mail.gmail.com> <6e13b9b1a964b49079a2f7814c0d65e767cd010a.camel@perches.com>
In-Reply-To: <6e13b9b1a964b49079a2f7814c0d65e767cd010a.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 5 Oct 2023 11:30:48 -0700
Message-ID: <CAFhGd8rGr3fm-U3XCjRkJQRymvjqGFYzsPu61zbMZCebuN5Rww@mail.gmail.com>
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

On Thu, Oct 5, 2023 at 11:15=E2=80=AFAM Joe Perches <joe@perches.com> wrote=
:
>
> On Thu, 2023-10-05 at 11:06 -0700, Justin Stitt wrote:
> > On Wed, Oct 4, 2023 at 7:40=E2=80=AFPM Joe Perches <joe@perches.com> wr=
ote:
> > >
> > > On Wed, 2023-10-04 at 21:21 +0000, Justin Stitt wrote:
> > > > The current behavior of K: is a tad bit noisy. It matches against t=
he
> > > > entire contents of files instead of just against the contents of a
> > > > patch.
> > > >
> > > > This means that a patch with a single character change (fixing a ty=
po or
> > > > whitespace or something) would still to/cc maintainers and lists if=
 the
> > > > affected file matched against the regex pattern given in K:. For
> > > > example, if a file has the word "clang" in it then every single pat=
ch
> > > > touching that file will to/cc Nick, Nathan and some lists.
> > > >
> > > > Let's change this behavior to only content match against patches
> > > > (subjects, message, diff) as this is what most people expect the
> > > > behavior already is. Most users of "K:" would prefer patch-only con=
tent
> > > > matching. If this is not the case let's add a new matching type as
> > > > proposed in [1].
> > >
> > > I'm glad to know  you are coming around to my suggestion.
> > :)
> >
> > >
> > > I believe the file-based keyword matching should _not_ be
> > > removed and the option should be added for it like I suggested.
> >
> > Having a command line flag allowing get_maintainer.pl
> > users to decide the behavior of K: is weird to me. If I'm a maintainer =
setting
> > my K: in MAINTAINERS I want some sort of consistent behavior. Some
> > patches will start hitting mailing list that DO have keywords in the pa=
tch
> > and others, confusingly, not.
>
> Not true.
>
> If a patch contains a keyword match, get_maintainers will _always_
> show the K: keyword maintainers unless --nokeywords is specified
> on the command line.

...

>
> If a file contains a keyword match, it'll only show the K:
> keyword  if --keywords-in-file is set.

Right, what I'm saying is a patch can arrive in a maintainer's inbox
wherein the patch itself has no mention of the keyword (if
get_maintainer user opted for --keywords-in-file). Just trying to
avoid some cases of the question: "Why is this in my inbox?"

>
> > To note, we get some speed-up here as pattern matching a patch that
> > touches lots of files would result in searching all of them in their
> > entirety. Just removing this behavior _might_ have a measurable
> > speed-up for patch series touching dozens of files.
>
> Again, not true.
>
> Patches do _not_ scan the original modified files for keyword matches.
> Only the patch itself is scanned.  That's the current behavior as well.
>

Feel like I'm missing something here. How is K: matching keywords in
files without reading them.

If my patch touches 10 files then all 10 of those files are scanned for
K: matches right?
