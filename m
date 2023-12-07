Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC5807CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441875AbjLGAGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjLGAGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:06:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6212D1989
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:05:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf09be81bso679e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 16:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701907550; x=1702512350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k2IKvmRw3JV6Mu9BGLsJLEfNzigcqLo+aqtqyuGelw=;
        b=z96xXkvkiWFV1Yd+AeDWXio5WKTfYnVpdhNAJ1Iv/BinHENhd0b++pcO7pdujm8jL6
         6tsI9Qha3B1iUPzyXG8hrTv41H6X0zU/j0i9lH2UmEcp6rhUMHZhJhlXc5O4nVPyn3YM
         NKtX9Wj+xBgXeddjZDyfGTGp09jKlj5FsndtgiBwjvKwCEJ+epSTOdav6ggfCpsc6SWg
         wPXQ8jzc3mJkPJsW41kfaseM6grKK4bIdnSjRnrmPG4a9xSnmA1LYvJIP264q3Vqsbvt
         C9d0gZ/cm6TztaS1G+0CwXdyIYMkWGKGAOyx8nWLH7CT80ygJo8LgMokcmSdftGcEpsl
         /T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907550; x=1702512350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/k2IKvmRw3JV6Mu9BGLsJLEfNzigcqLo+aqtqyuGelw=;
        b=N98zxQYPu9cEPlISQBQp24NSr/FMEcdmQ+FxFo/x7kkZXV3rNH3xjT2ObrJKEeKN/O
         WKnV5/O6kvnQbdeHNr9Fp7HBfgE/Y7VgjSk71pcIThDeppLVB514DJAPzKuaW0C0K+o1
         CWMoEbF7QE9HTqzu+/WR9zcdxTUZYBJ8feTJtAMxLMXmeHQ4FkwK9u98algTQSHi4n+u
         jvHb0GPXAxFjHISVqJNZW685czJ2CkT0ZLHEI85q3k6jnc6Lo5kDS2yYipXk+aITvsm/
         HGNrpmioGiobLp7NJcuJD58jxGVrH91n7fk2MkUPVvevttOB7PITnT2emSqMIu/EdKJB
         BVLA==
X-Gm-Message-State: AOJu0YyubyXe4az2MNBB5yBhcwzm2jutdcLzrx4NmbmKeKxvzrwv6RZV
        fk9wuoJC6SpAXHC6KxUHMsWvcrP/Vk9f9I1C9Xk+Cg==
X-Google-Smtp-Source: AGHT+IFYYRTtLVRu5chVfy5+omY29a3FcQ6VToXuO3fc0ReQiXuE180fajnw3qWX/Fd5ecO6WJAxyfN6b/eOQoR3ufM=
X-Received: by 2002:a05:6512:2314:b0:50c:e19:b658 with SMTP id
 o20-20020a056512231400b0050c0e19b658mr87546lfu.1.1701907550214; Wed, 06 Dec
 2023 16:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-2-irogers@google.com>
 <CAM9d7cjCO8e7nbrtrcy4rsbexemQ94=XK+b5byMFFTDDgoJ2eg@mail.gmail.com>
 <CAP-5=fUBr60o22P4Op-J=TPkdfnby9vLetHQZ4UqjuX+nvbG9w@mail.gmail.com> <CAM9d7cjO2vxa_bvKFrVpX2PViHqZy_dtyf28EaSACwKv6BEHiw@mail.gmail.com>
In-Reply-To: <CAM9d7cjO2vxa_bvKFrVpX2PViHqZy_dtyf28EaSACwKv6BEHiw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 16:05:38 -0800
Message-ID: <CAP-5=fUBf41b=p7iVwoANZtRifR8ftuE00zQqLWz54KZ-9VWtw@mail.gmail.com>
Subject: Re: [PATCH v5 01/50] perf comm: Use regular mutex
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

On Sat, Dec 2, 2023 at 3:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 30, 2023 at 10:28=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Nov 29, 2023 at 4:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > The rwsem is only after used for writing so switch to a mutex that =
has
> > > > better error checking.
> > > >
> > > > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex"=
)
> > >
> > > I think we talked about fixing this separately, no?
> >
> > Sorry, I'm unclear on an action to do. Currently changing the
> > RWS_ERRORCHECK in tools/perf/util/rwsem.h will break the build without
> > this change.
>
> Can it be like this?
>
> #ifdef RWS_ERRORCHECK
> #define RWSEM_INITIALIZER  { .lock =3D PTHREAD_MUTEX_INITIALIZER, }
> #else
> #define RWSEM_INITIALIZER  { .lock =3D PTHREAD_RWLOCK_INITIALIZER, }
> #endif
>
> >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/comm.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> > > > index afb8d4fd2644..4ae7bc2aa9a6 100644
> > > > --- a/tools/perf/util/comm.c
> > > > +++ b/tools/perf/util/comm.c
> > > > @@ -17,7 +17,7 @@ struct comm_str {
> > > >
> > > >  /* Should perhaps be moved to struct machine */
> > > >  static struct rb_root comm_str_root;
> > > > -static struct rw_semaphore comm_str_lock =3D {.lock =3D PTHREAD_RW=
LOCK_INITIALIZER,};
> > > > +static struct mutex comm_str_lock =3D {.lock =3D PTHREAD_ERRORCHEC=
K_MUTEX_INITIALIZER_NP,};
> > >
> > > IIUC it has a problem with musl libc.  Actually I think it's better t=
o
> > > hide the field and the pthread initializer under some macro like
> > > MUTEX_INITIALIZER or DEFINE_MUTEX() like in the kernel.
> >
> > Will there be enough use to justify this? I think ideally we'd not be
> > having global locks needing global initializers as we run into
> > problems like we see in metrics needing to mix counting and sampling.
>
> I don't know but there might be a reason to use global locks.
> Then we need to support the initialization and it'd be better
> to make it easier to handle internal changes like this.

Right. So you are suggesting I make a macro for initialization but
when this change is applied it will remove the only user of the macro.
The macro would clearly be redundant which is why I didn't do a
separate fix for that before doing this change - to use a mutex as the
rwsem here is only ever used as a write lock. If we're looking to
improve rwsem I don't think adding unused macros is the best thing,
for example, we could remove references to perf_singlethreaded which
is an idea that has had its day.

Thanks,
Ian

> Thanks,
> Namhyung
