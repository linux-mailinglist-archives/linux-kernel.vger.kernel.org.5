Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3036805DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbjLER7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLER7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:59:09 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5FE1FE8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:59:15 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf1de91c6so101e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701799154; x=1702403954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gc6EPrb7sJMi5FLo8PEKP3q9XU/ASOLnpitI/EDUi8=;
        b=mUFzuW2j4i5cHGKoIsxLhbYUhdPktzcy0ai1owCSBP+8qPTrxPivhBwn4bmdUquMYm
         aidNDWfKUBMPlg1hX8NmQpjjiZLRlPP1OXLbFOGDr7C/Ceg3uLDuZ1EsIC6alU4LHCM8
         IVx9Hsk1VNuLByjJfbxBc/JmYqLqe45IQA2UqhsWezV6fNJcZEboRSLmkqLU+tSyf9uO
         Mhv6V/2LNhvW6zuA7/0I2tm6ZfUr0AETm4q7vspZJIaklTjk0htDJZgQibcZ9czCbWbu
         CWOGzBUd0lDl4HFmeZgc5DnHuIaRvteohM6UT9tKDEjswT8fYyvg7IW7q0e6+MNU8tDW
         XO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799154; x=1702403954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gc6EPrb7sJMi5FLo8PEKP3q9XU/ASOLnpitI/EDUi8=;
        b=oAszzDxAvGc5CRjTafmHBtvCj2w1xcA/uZ7iLVXlk+zQ812n8yBe0PxBnXkeeaMDR5
         9KFdcBFJo0WJFGtvIzGp/IAhoOMBw7TiOlbhuzVW9gfkFKrrW8r+gmjor3XeB+u2kgVF
         FPvB78GFwqSSl5WYzmFFVrBriGMULMmRyoK5j3fl5k+YZU9vNTsV3gCGIZrMa9KmX/89
         d1kaZZbSrsOmsV1wgkXCF5RElsJ2gXIkHxwrLatQYFjBMgFiVGhHyN1wKX+jDe1TwYmV
         iu9JNf4AWckXDroarIPSlypw1OWMqV4dKwlIiTJ3aqNM7KjM56XUlcXwQGqgESJjN0fc
         1N9w==
X-Gm-Message-State: AOJu0Yxq8ldu2ZSpDlUGMi/Ip+BChiWeZW/EkDaUhWpccISoQjU1EWnl
        czosMRJg6att7JeBI2+4TZv54uo6b3uKuwFeA0w9Cg==
X-Google-Smtp-Source: AGHT+IEreAhwBUj3VoXijNV76YGN0BLzvw/1/zLgkxdshVRnOF58QsEUVJChSnIlSNqThA+x+IZWBAr9X6ybdnnCvE4=
X-Received: by 2002:a19:7418:0:b0:50b:fa8d:f28b with SMTP id
 v24-20020a197418000000b0050bfa8df28bmr149957lfe.1.1701799153760; Tue, 05 Dec
 2023 09:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
 <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com> <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
In-Reply-To: <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 Dec 2023 09:59:02 -0800
Message-ID: <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 2:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 30, 2023 at 10:37=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Nov 29, 2023 at 3:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, Nov 28, 2023 at 11:14=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > On Tue, Nov 28, 2023 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > It used to have annotation_options for each command separately (f=
or
> > > > > example, perf report, annotate, and top), but we can make it glob=
al as
> > > > > they never used together (with different settings).  This would s=
ave
> > > > > some memory for each symbol when annotation is enabled.
> > > > >
> > > > > This code is available at 'perf/annotate-option-v1' branch in
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-pe=
rf.git
> > > > >
> > > > > Thanks,
> > > > > Namhyung
> > > >
> > > > Thanks for doing this and I think it is progress. I think there is =
a
> > > > common problem with having things be an option rather than say part=
 of
> > > > session. Having a global variable seems unfortunate but I'm not sur=
e
> > > > if in all locations we have easy access to the session.
> > >
> > > That's not the case when you deal with hist entry or TUI browser.
> > > I think that's the reason we have the option in the annotation.
> > >
> > >
> > > > The rough
> > > > structure with annotations as I understand it is:
> > > >
> > > > session has machines
> > > > a machine has dsos
> > > > a dso has symbols
> > > > a symbol has an annotation
> > >
> > > That's true.  But the annotation struct is used only if
> > > symbol__annotation_init() is called.
> >
> > Right. I find this approach likely to lead to errors, such as a symbol
> > created globally before symbol__annotation_init() was called breaking
> > the container_of assumptions.
>
> Sure, but that's a different issue.  Maybe we can add a hash table
> to map a symbol to annotation or annotated_source directly.  But
> I don't think we need annotation_option for each symbol/annotation.

Agreed.

> >
> > > >
> > > > Annotation is something of unfortunate abstraction as it covers thi=
ngs
> > > > like an IPC per symbol (why hard code to just IPC?) and things like
> > > > source files and line numbers.
> > >
> > > Right, that's why I splitted the struct annotated_branch.
> > >
> > > >
> > > > A recent success story where we got rid of a configuration variable
> > > > was by switching to lazy allocation with sorting by name for symbol=
s
> > > > within a dso. If we could have a lazy allocation model with
> > > > annotations then maybe we can do away with large hammers like globa=
l
> > > > options.
> > >
> > > Maybe I can move the pointer to option into the annotated_source
> > > which is allocated lazily.  But I don't think it needs to keep the op=
tion
> > > for each symbol or annotation.  It's usually to control some display
> > > behaviors in the disasm output globally.  So I think it's better to h=
ave
> > > a global variable.
> >
> > Sgtm. My point wasn't to criticize, I think this is a good change, I
> > was just trying to imagine doing things in a way that could overall
> > reduce complexity
>
> Yep, thanks for your review.  Can I get your ACKs? :)

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung
