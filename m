Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC25C7A574A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjISCP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjISCPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:15:24 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F042126
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:15:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414ba610766so210521cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695089716; x=1695694516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quPggTFwi0XTpntnGHPGihRCg7HVdEcvKNxZf56FGgw=;
        b=vxEIIpYrug5u43l70R8bkYvN7SMAwxQWtYO2OAcRY7uL4wXC/njoqWpRWh1Y2pmyfS
         ZlGN44YPisgptekSL3/HOtnPyBqQoNII0YpXxtOo2en7//043svnsFjAfo/jkqDQRfVS
         JevOYEV9conmfyD4a7wXNUCIyWOUIW2fmBuv8DIirCcsxS5kqkZFpTK+n3ULLqgBSPNl
         ii6wYq1vyYXPa6DwgaLl+KVqngwxeMta/7v/bLqz7HmyYH4ZCIveutFGgZfa4o00LP+3
         4YCwkNZtpyyVm0ZSbyv2ZPbq/4b6m1oz0v0kxgaHZz4JOo2hHXIkWzW/yAWUimuJbYfT
         4oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695089716; x=1695694516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quPggTFwi0XTpntnGHPGihRCg7HVdEcvKNxZf56FGgw=;
        b=Nxl0w7W1tpc2Iftb/5U0uiti3vcRS8jCYQRFNTh3iFQ2DlmHIl12uy5hvslmrgw9iH
         oZdJJ++z3J4dhI2/PR/mr8nJlRDTC8r51FMIEwswgavprTcOrv+sw+Om+UbGFiEzDFzY
         x3AUFgf1Ud8xPrZYbpRjGzxxFqMjjlKRu2mZgKYtLcQsxDTX3yP/85Gq9j5QKyiIt6HS
         YJLTfpoU+RgNr2ldch40p4C8HsgCwsz/KuylrtE9bdPI+EyI+Y4OEh4+bKENqqx9oi7P
         F2o97wLII9vpXNCNM63yWZrhJ+zg6vuJSYI5UTmNxXnRgAyZBRyfkM+Z0WCOUXpGPW8G
         YyuQ==
X-Gm-Message-State: AOJu0YyU53ayCxqGztH2xgyz18NtxoacZ3nH7V0P4/xiQXp25o3T4dji
        tXEqt8FYNttPZu7XuzuJ6VhYEei3upcYEEngQoulQg==
X-Google-Smtp-Source: AGHT+IHoBSJFRxW0g2Vvg66ZyOabyfndhAOtH+QMKpyq3zzNhS3e3yt+3MKN21XQ9/koIthaqFEP3eTmXB3B3rh2hQg=
X-Received: by 2002:a05:622a:188d:b0:3f2:1441:3c11 with SMTP id
 v13-20020a05622a188d00b003f214413c11mr145770qtc.2.1695089716163; Mon, 18 Sep
 2023 19:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com> <20230914211948.814999-5-irogers@google.com>
 <CAM9d7ci3JPZ8ABamXUCRrAEV3jE=twPLSByOU_LC8LdzPedP2w@mail.gmail.com>
In-Reply-To: <CAM9d7ci3JPZ8ABamXUCRrAEV3jE=twPLSByOU_LC8LdzPedP2w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 18 Sep 2023 19:15:04 -0700
Message-ID: <CAP-5=fWTr9f79k=AqGtE0BtwtXBygp6PKtqJGu8dH2W8p0Gs2A@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf test: Ensure EXTRA_TESTS is covered in build test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
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

On Mon, Sep 18, 2023 at 4:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Sep 14, 2023 at 2:20=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Add to run variable.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/make | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index a3a0f2a8bba0..d9945ed25bc5 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -138,6 +138,7 @@ endif
> >  run +=3D make_python_perf_so
> >  run +=3D make_debug
> >  run +=3D make_nondistro
> > +run +=3D make_extra_tests
>
> I'm curious why it's missed.. I couldn't find a commit to delete it.
> Maybe due to an incorrect resolution of a merge conflict?

I think it was just a mistake in the original patch:
https://lore.kernel.org/lkml/683fea7c-f5e9-fa20-f96b-f6233ed5d2a7@intel.com=
/

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >  run +=3D make_no_bpf_skel
> >  run +=3D make_gen_vmlinux_h
> >  run +=3D make_no_libperl
> > --
> > 2.42.0.459.ge4e396fd5e-goog
> >
