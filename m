Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB17BE6A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbjJIQhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377272AbjJIQhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:37:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B52AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:37:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50302e8fca8so8290e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696869456; x=1697474256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCcIV6Mm7zw1gNMMm0ZkrKGglzNc/5vCe0dsXvh6bqw=;
        b=37ySzjw6oM68AS1MPLubhdp5REUPwceWOVzpL1c0kqRWwWifzCwx+AvAPRKPADLUnn
         cNUJO1qbzeMpE4jekHT9NTcYCN/6JXsJl1birvpZveWlyEiQslZ5n2F6W8PmmFfxsoZh
         kWl8ndmpARsNOxKSRIx8UxnSbWqqalljAonuvqllttnTCuhKL5iY5/iTRfdP+9sT87fY
         w81jLGpRquC+1d1gqcj98EUF91x0en1JTPLWDbsCh0gefi5TnqNG+/keZKu+gFnfol1y
         M0I219jS3n7k5U1YT89I8wk+0tYOb022s/mTiOw+NBeWLLItllIvp/j/qVrp6hD5Sebk
         M3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869456; x=1697474256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCcIV6Mm7zw1gNMMm0ZkrKGglzNc/5vCe0dsXvh6bqw=;
        b=DxaLSqKRbR9aYCBeSgT4DJYEER1DABg+d+uhTZc7Iij4YD2tspenTBP6LzKKu+QMRl
         s5arvzNWNbaaKpFT9eGNozjiFNG6MGJNpD4BIvmrLZ6UYGvMkuyKpPgEda0iEghF2YCP
         zusz5rA5BnaxJd4W/T0UlHOMIop6HWAD112fbhig4EQNr3xaUIwl252xgxte8K+T0xFG
         yqgU+kkPWs6zOU1wwxkqHQeTxGj3q0huCJ/SZ96Xc9ftPty27gzW8130ZnzSCaqhmGZb
         VQWN1SzADZef362plNpCuFa2ukMkhDPa/sO+yVrUhaLzyhv9olKFqXvMit2IusQRT0DI
         gvdg==
X-Gm-Message-State: AOJu0YxqDnxOpP7V0LhOrMIf5jnPTT33ZoYNPmrbgmClX1qnW5ZaNiBg
        AXjjJ1QNMn+2Bk6FnLzcyQ21KgBV7k5F8syRWIWlbA==
X-Google-Smtp-Source: AGHT+IFrz2vFJU/zI3Q1h36XuYf4dJwSe0vnT+pqWgCqVmuceBLNptLoibz7FuY74kPBGRakIVvBm12RbdQ4QIDmIJE=
X-Received: by 2002:ac2:44db:0:b0:505:7c88:9e45 with SMTP id
 d27-20020ac244db000000b005057c889e45mr231500lfm.0.1696869455500; Mon, 09 Oct
 2023 09:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-14-irogers@google.com>
 <CAM9d7cj-ANu1j-6WxGDQ_+pJtDt1xfyuGCNyC_dTpCDECZZgCQ@mail.gmail.com>
In-Reply-To: <CAM9d7cj-ANu1j-6WxGDQ_+pJtDt1xfyuGCNyC_dTpCDECZZgCQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Oct 2023 09:37:24 -0700
Message-ID: <CAP-5=fVpkvtf=8niBTcLUcpEjypJAui0yT4ATtY763-mCSXamg@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] perf svghelper: Avoid memory leak
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 11:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On success path the sib_core and sib_thr values weren't being
> > freed. Detected by clang-tidy.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-lock.c   | 1 +
> >  tools/perf/util/svghelper.c | 5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index d4b22313e5fc..1b40b00c9563 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -2463,6 +2463,7 @@ static int parse_call_stack(const struct option *=
opt __maybe_unused, const char
> >                 entry =3D malloc(sizeof(*entry) + strlen(tok) + 1);
> >                 if (entry =3D=3D NULL) {
> >                         pr_err("Memory allocation failure\n");
> > +                       free(s);
> >                         return -1;
> >                 }
> >
>
> This is unrelated.  Please put it in a separate patch.

Sorry, will fix in v3.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> > index 0e4dc31c6c9c..1892e9b6aa7f 100644
> > --- a/tools/perf/util/svghelper.c
> > +++ b/tools/perf/util/svghelper.c
> > @@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
> >         int i, nr_cpus;
> >         struct topology t;
> >         char *sib_core, *sib_thr;
> > +       int ret =3D -1;
> >
> >         nr_cpus =3D min(env->nr_cpus_online, MAX_NR_CPUS);
> >
> > @@ -799,11 +800,11 @@ int svg_build_topology_map(struct perf_env *env)
> >
> >         scan_core_topology(topology_map, &t, nr_cpus);
> >
> > -       return 0;
> > +       ret =3D 0;
> >
> >  exit:
> >         zfree(&t.sib_core);
> >         zfree(&t.sib_thr);
> >
> > -       return -1;
> > +       return ret;
> >  }
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
