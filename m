Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB80D7FAB50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjK0U0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjK0U0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:26:37 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67CD4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:26:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50aa698b384so13984e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701116802; x=1701721602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNtbW7bb1joRBd02cZwF5zPKpcLSt2ynX6nmeWUG++o=;
        b=v2u4G/NikjoCRNKLXT7gRsYoU/kJ2LI4RxhcCkFKP6AyoYIIZHUueQToNBIinzlOmP
         lN3xbMLJRPjngBLVSAbLZrnc0S1GmL/PPxfl/7J5QVNSK4S1xd6IcYGscb5/Br/VWeC8
         encknEOx/j4fcHsxKJmiNX5D1gZA6gg/ZpAw3D7T3kMzB+0GhcAYO1+UtJ30aRV/MFWx
         iVBClxyZ3DhH2IG6y7b61MUBgRs4MGevC9eEiQcoWzwbeoIrdQsrBOKFmz4UGkVwFea4
         1D5hSBzZTBZpA4BeDu5GVaHVmqRCJPPGxuj9/yo8hoIxi/TNXfMw1PsJirm/pPvGpe66
         8tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116802; x=1701721602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNtbW7bb1joRBd02cZwF5zPKpcLSt2ynX6nmeWUG++o=;
        b=vd6tYmO1AXB+tsC957ClQfyWMubhauN59NKHtsSOHL2T1Qwn6KcyiGh03HqPK2Rdp8
         L2vVJnlNr2TDk2tWIK60bHuAzenP+XjGEuRWLI+HLbCZu+/Q6l2b2jRAFmSuHpd/6l6o
         b3QigLDD+XDZZ9ByCtEEcHYTMEikUZkO/XGsbS28ZO+8JirqdUrnDAeMTm9o1gxA7SA7
         YSXmncfMsyE+SNmXM7ZCy3yyPZK/4Kse/eVljbm5CAZsg8aDN/Zu7k5N5RByaUFh8PrG
         QoojA57Vh8oROQL+1249b2wXb1n6DOG9sgvtBpolYQlq30ITyepT/X27fE2qHzEn+qh7
         V7nQ==
X-Gm-Message-State: AOJu0YwN85yfUTa+SUz9conRgS2lLJ9RXSkRSJKKz6YiyV1BQCfOFDrD
        FPRpa6obg+/ZefAFhMfO+W6me5hR72rl4S52LT9Klw==
X-Google-Smtp-Source: AGHT+IE0vJHXXs+UpDyTFUu/c9agbsDp0hdFxUpV6rm235xacPJlBYe+WQXjBEzMzPbALedPRf2rjhzf79SOYkWJSjM=
X-Received: by 2002:a05:6512:1585:b0:50a:519d:5a8a with SMTP id
 bp5-20020a056512158500b0050a519d5a8amr327946lfb.5.1701116802002; Mon, 27 Nov
 2023 12:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-7-irogers@google.com>
 <CAM9d7chgQBGMmyDyi98OUzyJHWaNUfw34VD=pStkX_n-t5Vpkg@mail.gmail.com>
In-Reply-To: <CAM9d7chgQBGMmyDyi98OUzyJHWaNUfw34VD=pStkX_n-t5Vpkg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Nov 2023 12:26:29 -0800
Message-ID: <CAP-5=fVLOghVQjHAjLrJPN9wMTAwbCY+Fx4DU-QuJBVPq6BejA@mail.gmail.com>
Subject: Re: [PATCH v4 06/53] tools api fs: Switch filename__read_str to use io.h
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
        linux-perf-users@vger.kernel.org
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

On Sun, Nov 5, 2023 at 7:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 2, 2023 at 10:58=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > filename__read_str has its own string reading code that allocates
> > memory before reading into it. The memory allocated is sized at BUFSIZ
> > that is 8kb. Most strings are short and so most of this 8kb is
> > wasted.
> >
> > Refactor io__getline so that the newline character can be configurable
> > and ignored in the case of filename__read_str.
> >
> > Code like build_caches_for_cpu in perf's header.c will read many
> > strings and hold them in a data structure, in this case multiple
> > strings per cache level per CPU. Using io.h's io__getline avoids the
> > wasted memory as strings are temporarily read into a buffer on the
> > stack before being copied to a buffer that grows 128 bytes at a time
> > and is never sized larger than the string.
> >
> > For a 16 hyperthread system the memory consumption of "perf record
> > true" is reduced by 180kb, primarily through saving memory when
> > reading the cache information.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
>
> [SNIP]
> > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > index a77b74c5fb65..50d33e14fb56 100644
> > --- a/tools/lib/api/io.h
> > +++ b/tools/lib/api/io.h
> > @@ -141,7 +141,7 @@ static inline int io__get_dec(struct io *io, __u64 =
*dec)
> >  }
> >
> >  /* Read up to and including the first newline following the pattern of=
 getline. */
>
> You may want to update the comment as well.
>
> > -static inline ssize_t io__getline(struct io *io, char **line_out, size=
_t *line_len_out)
> > +static inline ssize_t io__getline_nl(struct io *io, char **line_out, s=
ize_t *line_len_out, int nl)
>
> How about io__getdelim() similar to POSIX?

Thanks done for v5.

Ian

> Thanks,
> Namhyung
>
>
> >  {
> >         char buf[128];
> >         int buf_pos =3D 0;
> > @@ -151,7 +151,7 @@ static inline ssize_t io__getline(struct io *io, ch=
ar **line_out, size_t *line_l
> >
> >         /* TODO: reuse previously allocated memory. */
> >         free(*line_out);
> > -       while (ch !=3D '\n') {
> > +       while (ch !=3D nl) {
> >                 ch =3D io__get_char(io);
> >
> >                 if (ch < 0)
> > @@ -184,4 +184,9 @@ static inline ssize_t io__getline(struct io *io, ch=
ar **line_out, size_t *line_l
> >         return -ENOMEM;
> >  }
> >
> > +static inline ssize_t io__getline(struct io *io, char **line_out, size=
_t *line_len_out)
> > +{
> > +       return io__getline_nl(io, line_out, line_len_out, /*nl=3D*/'\n'=
);
> > +}
> > +
> >  #endif /* __API_IO__ */
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
>
