Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A901B7FF951
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjK3S2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3S2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:28:04 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D4AD6C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:28:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso13615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701368888; x=1701973688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQnDDplBo/xl6TSnDTzhQLPLA7PVAh8kIH3hmpt4VIo=;
        b=KmwuZucqW16iZcPXuZ9CKNpoJ7tTag643kqrHwLMuQbBh6GvfT/Do1AycmiQ/HMhWY
         DmSBNC9EVe7S4An/XcSR1HYsld1t0p2N2XvhE1y9gAy7E8AUdKwTUvuo4D5GiV+8LbIa
         BUgq374jE6Oaaw7JHPz7XNPIB0aLe5HbdWCXUHuFfA4o8ajeu/a2/ncL60ju06ejIdrf
         EScd+gKMz9YnlBSCxX4D8mDssafAjS+cYdnqSNXP7p80UvO6MkiycuX3L7Xlb+w6RVHD
         a/gwzIxLBh5yNO5ZDg8NcnH/dTwGiAw+rvelIgOSmtNg1BaPhxo7++GZZZNy8bNMluS3
         dtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368888; x=1701973688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQnDDplBo/xl6TSnDTzhQLPLA7PVAh8kIH3hmpt4VIo=;
        b=tFah87Hqo3uxrQ2n+Qv7qlqURdxVrHxmrP8CfiB3BbC3Pjo5/6e1l7G74FzsOykyWN
         1soGsLHtHkmo47ODRzM7pf08gPvx4gRbn8eVAoCLstVIY0P2N+7TnZqhZu7fpBfhhkk6
         qi3XZCNzaI6tUgxCsN7t1ZYCp5gpmW6BoWk42Q6JncbCr7H611vPpnkwxa3vEXd5dfST
         NmH4frLEXdPLpgN/FyfNyTBAo5pQr890t6adLj5qoU+DlkBnXEJTQRO41avnGS83l3hx
         FD6CEE79xsv5ab+hZyI2aBdcw+6mUn2LIib8+7JZvibO7VioiotBONTeXGTXPY8vLaF+
         9vQA==
X-Gm-Message-State: AOJu0Yy24p/C3W+kw6YRC58U+5vCBOaEDTWEro/cN8WLVy0ATyZG6VF9
        GCdp377pS0TSoZyOQ7FzDF4qZ87gq81Hn+ygGBuxFg==
X-Google-Smtp-Source: AGHT+IH0qly/6N+PSKn52LeY7Db2raJh+S9M05YJg7N3XXfn1ABYr8yEwAJWvPy/CS8/VZRIHxvhhPQpFR/o8ze+5CA=
X-Received: by 2002:a05:600c:a686:b0:40b:4355:a04b with SMTP id
 ip6-20020a05600ca68600b0040b4355a04bmr214963wmb.6.1701368888211; Thu, 30 Nov
 2023 10:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-2-irogers@google.com>
 <CAM9d7cjCO8e7nbrtrcy4rsbexemQ94=XK+b5byMFFTDDgoJ2eg@mail.gmail.com>
In-Reply-To: <CAM9d7cjCO8e7nbrtrcy4rsbexemQ94=XK+b5byMFFTDDgoJ2eg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Nov 2023 10:27:56 -0800
Message-ID: <CAP-5=fUBr60o22P4Op-J=TPkdfnby9vLetHQZ4UqjuX+nvbG9w@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 4:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > The rwsem is only after used for writing so switch to a mutex that has
> > better error checking.
> >
> > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")
>
> I think we talked about fixing this separately, no?

Sorry, I'm unclear on an action to do. Currently changing the
RWS_ERRORCHECK in tools/perf/util/rwsem.h will break the build without
this change.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/comm.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> > index afb8d4fd2644..4ae7bc2aa9a6 100644
> > --- a/tools/perf/util/comm.c
> > +++ b/tools/perf/util/comm.c
> > @@ -17,7 +17,7 @@ struct comm_str {
> >
> >  /* Should perhaps be moved to struct machine */
> >  static struct rb_root comm_str_root;
> > -static struct rw_semaphore comm_str_lock =3D {.lock =3D PTHREAD_RWLOCK=
_INITIALIZER,};
> > +static struct mutex comm_str_lock =3D {.lock =3D PTHREAD_ERRORCHECK_MU=
TEX_INITIALIZER_NP,};
>
> IIUC it has a problem with musl libc.  Actually I think it's better to
> hide the field and the pthread initializer under some macro like
> MUTEX_INITIALIZER or DEFINE_MUTEX() like in the kernel.

Will there be enough use to justify this? I think ideally we'd not be
having global locks needing global initializers as we run into
problems like we see in metrics needing to mix counting and sampling.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> >  static struct comm_str *comm_str__get(struct comm_str *cs)
> >  {
> > @@ -30,9 +30,9 @@ static struct comm_str *comm_str__get(struct comm_str=
 *cs)
> >  static void comm_str__put(struct comm_str *cs)
> >  {
> >         if (cs && refcount_dec_and_test(&cs->refcnt)) {
> > -               down_write(&comm_str_lock);
> > +               mutex_lock(&comm_str_lock);
> >                 rb_erase(&cs->rb_node, &comm_str_root);
> > -               up_write(&comm_str_lock);
> > +               mutex_unlock(&comm_str_lock);
> >                 zfree(&cs->str);
> >                 free(cs);
> >         }
> > @@ -98,9 +98,9 @@ static struct comm_str *comm_str__findnew(const char =
*str, struct rb_root *root)
> >  {
> >         struct comm_str *cs;
> >
> > -       down_write(&comm_str_lock);
> > +       mutex_lock(&comm_str_lock);
> >         cs =3D __comm_str__findnew(str, root);
> > -       up_write(&comm_str_lock);
> > +       mutex_unlock(&comm_str_lock);
> >
> >         return cs;
> >  }
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
