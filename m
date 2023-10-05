Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790807BAEE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjJEWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjJEWjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:39:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5EE8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:39:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-502f29ed596so2377e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696545549; x=1697150349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVE7SUNr8dOdJFRW7Bjbr6OwiQITtpL3cHyTpIFhRi4=;
        b=bTiotfDdAPF4nHiV/ClmWPcLxLPVdP1Gzv4XqO7IeAj8bCbqqdr2cRaqWj0ZB8HiW1
         VKUC31zn7F3h4zN3JE7VTZWebmM8WhyhoQKv8wNdMusUhuKb4ckbdTzv8Nmleg1dr0ho
         klq96i6nkOO2yKvcECGQNhvAYsMU/RmUJiAFTOhVpCTAGiFd91NC4OaDvz+75aTgtbVQ
         ucbrWzcYarrN2MEN6aPBwtnSEq+cd9Ulfps4joKTcmcBcUSof7kmlMeG3rWaBRf+5rd5
         oes35L8IwDpwuGVegH7fRMA7Avntwd5PKv2sThAh1aj+nZBP3udNcPHwTuidBf+4IT4L
         wDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545549; x=1697150349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVE7SUNr8dOdJFRW7Bjbr6OwiQITtpL3cHyTpIFhRi4=;
        b=aPXByoECrqtcZwsL+i3bcOxPT3KH/QZCelevdPo+VBgKawsCMDi+WwBpkbWP7xVtGn
         n9NEejbcfx0GxBMETPoYonmF3AZAuf/PsavYBcLTvJc7fwhP3ZFrcJTXTw5OKpBvqyHL
         1zZBOh0hasLtte15eUncbjBZgDF7kNpF5xULypiMnIUJsDpLssCDof99+8rqXxu2xddO
         /luX5XNG4tC/BnwaqQL0RI1yRKXyjn49PUivzBbQ9ZIyTsy+2yOdUlGsvo3r5bWsO/gx
         M0HJTAm1+3AYWh5k6aykebh57CIR9SqQouKm3Yw5xMguH2VzNGFlmxQQWXONtXLvyrz0
         i1+g==
X-Gm-Message-State: AOJu0YyhgMDA55HcFA9vdHJsa2IT8TouwC01lLiP/toIgvuChpD9tfS3
        U8+EJ24YieCcd4CYhH53v0GHBZNnk/JwnIgLpmyf8g==
X-Google-Smtp-Source: AGHT+IHYdBFarHeFFHinCQkTkwRAYhuGd8qGiXmmKvGN+V9Xz8zSAPN3oWFopZLixwBanSyCcHoIrKXARV0tZ/Pi7x8=
X-Received: by 2002:ac2:51a5:0:b0:501:a2b9:6046 with SMTP id
 f5-20020ac251a5000000b00501a2b96046mr70418lfk.7.1696545549064; Thu, 05 Oct
 2023 15:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com> <20230923053515.535607-4-irogers@google.com>
 <CAKwvOdngy8a0n7TapeMPvANvp1uQuJAJk9i3kDNWx+czFL0=cQ@mail.gmail.com>
In-Reply-To: <CAKwvOdngy8a0n7TapeMPvANvp1uQuJAJk9i3kDNWx+czFL0=cQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Oct 2023 15:38:57 -0700
Message-ID: <CAP-5=fUos9Hv2OmVVGrcLdZz15U-L+xD5d-6HYaqaVSoT39siQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/18] run-clang-tools: Add pass through checks and and
 header-filter arguments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 8:44=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 22, 2023 at 10:35=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Add a -checks argument to allow the checks passed to the clang-tool to
> > be set on the command line.
> >
> > Add a pass through -header-filter option.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  scripts/clang-tools/run-clang-tools.py | 34 ++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-too=
ls/run-clang-tools.py
> > index 3266708a8658..5dfe03852cb4 100755
> > --- a/scripts/clang-tools/run-clang-tools.py
> > +++ b/scripts/clang-tools/run-clang-tools.py
> > @@ -33,6 +33,11 @@ def parse_arguments():
> >      path_help =3D "Path to the compilation database to parse"
> >      parser.add_argument("path", type=3Dstr, help=3Dpath_help)
> >
> > +    checks_help =3D "Checks to pass to the analysis"
> > +    parser.add_argument("-checks", type=3Dstr, default=3DNone, help=3D=
checks_help)
> > +    header_filter_help =3D "Pass the -header-filter value to the tool"
> > +    parser.add_argument("-header-filter", type=3Dstr, default=3DNone, =
help=3Dheader_filter_help)
> > +
> >      return parser.parse_args()
> >
> >
> > @@ -45,14 +50,29 @@ def init(l, a):
> >
> >  def run_analysis(entry):
> >      # Disable all checks, then re-enable the ones we want
> > -    checks =3D []
> > -    checks.append("-checks=3D-*")
> > -    if args.type =3D=3D "clang-tidy":
> > -        checks.append("linuxkernel-*")
> > +    global args
> > +    checks =3D None
> > +    if args.checks:
> > +        checks =3D args.checks.split(',')
> >      else:
> > -        checks.append("clang-analyzer-*")
> > -        checks.append("-clang-analyzer-security.insecureAPI.Deprecated=
OrUnsafeBufferHandling")
> > -    p =3D subprocess.run(["clang-tidy", "-p", args.path, ",".join(chec=
ks), entry["file"]],
> > +        checks =3D ["-*"]
> > +        if args.type =3D=3D "clang-tidy":
> > +            checks.append("linuxkernel-*")
> > +        else:
> > +            checks.append("clang-analyzer-*")
> > +            checks.append("-clang-analyzer-security.insecureAPI.Deprec=
atedOrUnsafeBufferHandling")
> > +    file =3D entry["file"]
> > +    if not file.endswith(".c") and not file.endswith(".cpp"):
> > +        with lock:
> > +            print(f"Skipping non-C file: '{file}'", file=3Dsys.stderr)
> > +        return
> > +    pargs =3D ["clang-tidy", "-p", args.path]
> > +    if checks:
>
> ^ can `checks` ever be falsy here?  I don't think we need this
> conditional check?

Agreed, it was for an option that I removed. Will fix in v2.

Thanks,
Ian

> > +        pargs.append("-checks=3D" + ",".join(checks))
> > +    if args.header_filter:
> > +        pargs.append("-header-filter=3D" + args.header_filter)
> > +    pargs.append(file)
> > +    p =3D subprocess.run(pargs,
> >                         stdout=3Dsubprocess.PIPE,
> >                         stderr=3Dsubprocess.STDOUT,
> >                         cwd=3Dentry["directory"])
> > --
> > 2.42.0.515.g380fc7ccd1-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
