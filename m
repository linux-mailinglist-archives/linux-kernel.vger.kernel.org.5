Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC47BAE91
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjJEWD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEWD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:03:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F139895
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:03:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405459d9a96so36615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696543405; x=1697148205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT1UXws5EaLoSLlRb6+SPNkgqpM3S+hu1ZvOKq4ES/E=;
        b=saxmJmKlGUJ+FQMfZsmD1UF+pwbmXD3WGRqwnalbmkj7HgcZyfte9FhDIj1ITEH444
         Obvm2GpZenL60foXRjLT08cKdZ0d1VhHA8qEHf/hSQuGkWNYfQY2urQN9UdfXN8UYkvh
         3CmV9IvfbZDQ1vQhIGP0TBXdm6k7sju1BURzn3ypRpX/rfsE7vLAzBPGLqoFMeUqpr0v
         NAXrxfdDFznfpWAWfa7gZ7AH+lB8jlVBQYLsCIHgsRmErJ53aK1UVYwS/Dt+svmhr3a7
         II3Pkcf1i2blTiZ197xw5+A94TDYWqU+T63Y/9+WpfTwvSwXEJun5R3i8nFJ+aqCqCZw
         G91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543405; x=1697148205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT1UXws5EaLoSLlRb6+SPNkgqpM3S+hu1ZvOKq4ES/E=;
        b=lLSvC7OqmVn59KEVIrErfSrwyFYini6Hr07Bhb3HbzLs7CuR8eKwZKLMim1BkP67yn
         fLzvW6V5qn9rJmxxXilqO4MaDYP8MySxzmOTJZz31CCKyZaq3DwYWWQ9y2Xc7rWUCLLp
         AkTiPqNL+AGEsecLFJLz7T4KC3Z431jMV/6YcQgH8h+RayuUVmQIjlYzEcvnl5Dj6u4y
         P2YZ8+FSNI0n/nQvldXZarV8itzyy5qc6tld4rQX5k4MyIS9hZ5VISvOUeSio3ntq27/
         jGhf525WOLqJz5nhOsf78mWm4EcZSLMLB3wbz+BqWRexLYgX/ROwXwnUOr+Xs8GCmuAj
         Lc9g==
X-Gm-Message-State: AOJu0YwVwJH5lEKRmJZZg3wWGKsAy4JiKKFPDhw1F6K9AtvcSdWYa+M/
        8xLnzUCxhsCKPt/XxeRUveYEPQJYAo+vaclpAA6ijA==
X-Google-Smtp-Source: AGHT+IHgdetxaCDp/Q2yZTcDE1g0qogeilw5jplia3TNRnClpg1xF2p5U/mvDp+4nAWn1MzWyfPRsmQYFtu7/KnuDmA=
X-Received: by 2002:a05:600c:2182:b0:404:7462:1f87 with SMTP id
 e2-20020a05600c218200b0040474621f87mr106347wme.6.1696543405189; Thu, 05 Oct
 2023 15:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231004222323.3503030-1-irogers@google.com> <20231004222323.3503030-2-irogers@google.com>
 <173829f3-817e-4937-808f-7f9bfc22207f@isovalent.com>
In-Reply-To: <173829f3-817e-4937-808f-7f9bfc22207f@isovalent.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Oct 2023 15:03:12 -0700
Message-ID: <CAP-5=fUyDUV_XzaTKF4V5h5yzkqtM27AfK2qRTncQiAryHHYcg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] bpftool: Align bpf_load_and_run_opts insns and data
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 8:54=E2=80=AFAM Quentin Monnet <quentin@isovalent.co=
m> wrote:
>
> On 04/10/2023 23:23, Ian Rogers wrote:
> > A C string lacks alignment so use aligned arrays to avoid potential
> > alignment problems. Switch to using sizeof (less 1 for the \0
> > terminator) rather than a hardcode size constant.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/bpf/bpftool/gen.c | 47 ++++++++++++++++++++++-------------------
> >  1 file changed, 25 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index b8ebcee9bc56..7a545dcabe38 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -408,8 +408,8 @@ static void codegen(const char *template, ...)
> >               /* skip baseline indentation tabs */
> >               for (n =3D skip_tabs; n > 0; n--, src++) {
> >                       if (*src !=3D '\t') {
> > -                             p_err("not enough tabs at pos %td in temp=
late '%s'",
> > -                                   src - template - 1, template);
> > +                             p_err("not enough tabs at pos %td in temp=
late '%s'\n'%s'",
> > +                                     src - template - 1, template, src=
);
>
> Nit: This line is no longer aligned with the opening parenthesis.
>
> Other than that:
>
> Acked-by: Quentin Monnet <quenti@isovalent.com>

Thanks! Nit fixed in v5.

Ian
