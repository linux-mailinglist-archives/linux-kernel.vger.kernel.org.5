Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E187B2A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjI2DHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjI2DH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:07:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC319C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:07:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b0168a9e05so1514825366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695956845; x=1696561645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R94+FuQqsaH0naS+S/05gaVsqGwPVCr20di+DpmfQaw=;
        b=gcy3UWf3rbEK/a0rrdgRVd3HgvWG5lzHkzdk6i7NA6vyxaP224bERho2F4SFzK7XQ7
         9vbyd7n9tWZ4FVff5mbiyaWD/R2ca1Peg1WtuaTnDukHZeLwve7BpDMUGV4JlGsZgDBd
         +bFFT9YIDlmUePjzIBkkqFPtyOFlN07/AmoqGU5bFpLhAb3EwitxkZWfeiRnuwtj6njy
         q/z8QixXn71hG1sKc/5kozrUyzBjdtxaor2T6n3Ph2/6+cniwlCUYjyrYf+tUGQN3sOq
         +O7rOWkscMGoinX3jDRd2hBdwwlqnbvex8FqeVf4ZoXYTsrXjcu2ab22MwkaleJAPi9s
         Ry4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695956845; x=1696561645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R94+FuQqsaH0naS+S/05gaVsqGwPVCr20di+DpmfQaw=;
        b=l4S3T1uvjV82GJIlpdkLzVCNDGQbrQfWMU4RawjdBa+4fgjM2lNdJBDNJqCe729mcj
         WMexvaPmVu+kHhgC9Gj4+oAGUwALzSptWCKP/jCnHBXwsUVANobIzwNzQqDO74yKnJnZ
         VCBnOZhP7EuIrlTlcs0YGQeqT/TYQYX9+zGVZl1+TQajBPqobTeEleVXgGRPcgTw6nCU
         zmB3b+zwQPVvZJCyB36g0Bucze+zaEG+0CICCMh1VeMwhpErmAoQ4F3VG7Y2+RyBMbzA
         aG1vCcNwB1IB0uXMbhoYKB9z2FOIvnM8A7LGLyWKQoaplv0NMalrWT2KHvJ45ByPa5sq
         i/HA==
X-Gm-Message-State: AOJu0Ywc67cVgVfqjdk0PYtrPnnebKU7OMorleZqXOUtIrl6sS4ZVFFv
        7oj8oT/pUkOki3abASRi9HyGSbggWRZ2msKhUjGN1w==
X-Google-Smtp-Source: AGHT+IElb19EkQXAJT5ws9MsyM54PfkaUXP2jiLmHRE42pZPn9FPpqfsT1tn7cTnf6CsFaIGnbyMBT/OhUOI2zP9uaA=
X-Received: by 2002:a17:906:f15:b0:9b2:b85d:cec0 with SMTP id
 z21-20020a1709060f1500b009b2b85dcec0mr2712301eji.60.1695956844884; Thu, 28
 Sep 2023 20:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
 <5707f3bef3ecd8220a8bf7c8b72c72c53e65b666.camel@perches.com>
 <CAFhGd8rtnvipRVAKRQAEcyGqCknVmx+bd2NMT7mCuTZjhrqULA@mail.gmail.com>
 <137a309b313cc8a295f3affc704f0da049f233aa.camel@perches.com>
 <CAKwvOdnGzTvSXf7VeyG8tPEONpqSgkDiBTmgJbUUWsRHzbc5JQ@mail.gmail.com>
 <CAFhGd8rrHp1V4NpExpdNwWV4FAdLYhixLMB5HGygNSe7NKPUMA@mail.gmail.com> <6691251158ab59ba4090de26012c34788df8f2ed.camel@perches.com>
In-Reply-To: <6691251158ab59ba4090de26012c34788df8f2ed.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 29 Sep 2023 12:07:13 +0900
Message-ID: <CAFhGd8rZLpfOhfmBChRTXsGkUjaCUMLiYzBcLbWE9xACK7SFwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] get_maintainer: add patch-only keyword matching
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
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

On Fri, Sep 29, 2023 at 11:50=E2=80=AFAM Joe Perches <joe@perches.com> wrot=
e:
>
> On Fri, 2023-09-29 at 11:07 +0900, Justin Stitt wrote:
> > On Fri, Sep 29, 2023 at 12:52=E2=80=AFAM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Wed, Sep 27, 2023 at 11:09=E2=80=AFPM Joe Perches <joe@perches.com=
> wrote:
> > > >
> > > > On Thu, 2023-09-28 at 14:31 +0900, Justin Stitt wrote:
> > > > > On Thu, Sep 28, 2023 at 2:01=E2=80=AFPM Joe Perches <joe@perches.=
com> wrote:
> > > > > >
> > > > > > On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> > > > > > > Changes in v2:
> > > > > > > - remove formatting pass (thanks Joe) (but seriously the form=
atting is
> > > > > > >   bad, is there opportunity to get a formatting pass in here =
at some
> > > > > > >   point?)
> > > > > >
>
> LG G7 Battery Replacement | Guide | Is it actually a Samsung? I t
> > > > > > Why?  What is it that makes you believe the formatting is bad?
> > > > > >
> > > > >
> > > > > Investigating further, it looked especially bad in my editor. The=
re is
> > > > > a mixture of
> > > > > tabs and spaces and my vim tabstop is set to 4 for pl files. Sett=
ing this to
> > > > > 8 is a whole lot better. But I still see some weird spacing
> > > > >
> > > >
> > > > Yes, it's a bit odd indentation.
> > > > It's emacs default perl format.
> > > > 4 space indent with 8 space tabs, maximal tab fill.
> > > >
> > >
> > > Oh! What?! That's the most surprising convention I've ever heard of
> > > (after the GNU C coding style).  Yet another thing to hold against
> > > perl I guess. :P
> > >
> > > I have my editor setup to highlight tabs vs spaces via visual cues, s=
o
> > > that I don't mess up kernel coding style. (`git clang-format HEAD~`
> > > after a commit helps).  scripts/get_maintainer.pl has some serious
> > > inconsistencies to the point where I'm not sure what it should or was
> > > meant to be.  Now that you mention it, I see it, and it does seem
> > > consistent in that regard.
> > >
> > > Justin, is your formatter configurable to match that convention?
> > > Maybe it's still useful, as long as you configure it to stick to the
> > > pre-existing convention.
> >
> > Negative, all the perl formatters I've tried will convert everything to=
 spaces.
> > The best I've seen is perltidy.
> >
> > https://gist.github.com/JustinStitt/347385921c80a5212c2672075aa769b6
>
> emacs with cperl mode works fine.
>
> I don't know much about vim, but when I open this file in vim
> it looks perfectly normal and it's apparently properly syntax
> highlighted.
>

I believe a :set tabstop=3D2 will make it look weird. But really,
this whole formatting thing is a non-issue for me personally
once I discovered what the problem was. I'm not sure this
file attracts nearly enough eyes to warrant an eager
formatting attempt as I was previously preaching for.

Nick and I using vim with special tab handling are most definitely
the exception and for most folks this file probably looks fine.
