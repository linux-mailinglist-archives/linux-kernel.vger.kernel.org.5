Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC04C7D71FC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJYRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjJYRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:02:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E370999
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:02:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40837124e1cso1395e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698253343; x=1698858143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czCS6bkZzuq5kVRt6QX5nEuyCy15sTQLBfnjWZCCDAg=;
        b=vdLZ8Eaz/6Unzt9cIZL4IFErfHqV9r65a+04jDAREkulMfE/ZclkRviQrHEuWdekFj
         eEqr72FisxbE/NY+vB/c1E3+EgcpT0K2BpvjP/SlrJgZ5TkYXw/QiAtWJ/xAosZAiWxo
         JUFJhwE8LSSg/EFsBoradvpUnSwhokoeMnZvbl4Ejy+uqQPS4YEV3mHGyXa+44i+JoKA
         NptOyvOC2qIdpLzWGlL21ui7FcLGTZjaUKv+DYlV5pDFO0oVECK6Q+5R3x1kW0sEQmh5
         lQ2z5b1MoqI1dSwLA2V9mmjlK+x5Y6v50/Ek4IXHdysdyMz5GxhbtRyJm+ovEt/y20rV
         lDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698253343; x=1698858143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czCS6bkZzuq5kVRt6QX5nEuyCy15sTQLBfnjWZCCDAg=;
        b=e8iTi7NO0oTDmMtQX6KR87cyDeD7869ssJdLSYwr5Jz3UmFqA9/OfU5Cwf1TJuWtL+
         KYXBBrazualMw33CY7yRk2HXRWnYd4x8P++FxDzDD+Qi+UMHjVC3Bskj4qZAplfYJZXY
         exYaWPFpoMIqsBOdpJ9aXqmEJJphH8VkNWS0ai4J1hBW+3DKUt1ha1kyEE+gZFYNc2u+
         WAQ4WFHdUk2Nv49J1tJbdxOP6TfvVQ5cXv35NBrB95RImxobck/FFLOpSITuiBdF7AL7
         iOgaZdv8y7c9n1Ghw2ljfa7J31DaRvLFkZz8FBu1Kof8wLea1hYslLJUUEVgDfcDt7PA
         QmGw==
X-Gm-Message-State: AOJu0Yy+ehmIX3GtpkqxntdjL0ez7ZC13yuah5EPJAXYvZYxn+uHCLzX
        huLSCSQkC6ka6UOYKQ35SnAYlcwyXI+2bme7Qs7hpA==
X-Google-Smtp-Source: AGHT+IFZzohsaXvy9bd8j2j9iMbKp9KQZ6VP0nwne5dVXq1cs5evJlXM8eKUR5RX7hoNRe7TxtJRMh9oVDHgMKjsOj8=
X-Received: by 2002:a05:600c:3b05:b0:404:7462:1f87 with SMTP id
 m5-20020a05600c3b0500b0040474621f87mr126070wms.6.1698253343087; Wed, 25 Oct
 2023 10:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <ZTj6mfM9UqY2DggC@kernel.org>
In-Reply-To: <ZTj6mfM9UqY2DggC@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Oct 2023 10:02:11 -0700
Message-ID: <CAP-5=fX1buB97VDWZn8_3S8f++VxjASty4PEc=gu9=8WeJ65Cw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Address stray '\' before # that is warned
 about since grep 3.8
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 4:23=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> To address this grep 3.8 warning:
>
>   grep: warning: stray \ before #
>
> We needed to remove the '' around the grep expression and keep the \
> before # so that it is escaped by the $(shell grep ...) and thus doesn't
> get to grep.
>
> We need that \ before the #, otherwise we get this:
>
>   Makefile.perf:364: *** unterminated call to function 'shell': missing '=
)'.  Stop.
>
> As everything after the # will be considered a comment.
>
> Removing the single quotes needs some more escaping so that _some_ of
> the escaped chars gets to grep, like the '\|' that becomes '\\\|=E0=B8=94=
.
>
> Running on debian:10, where there is no libtraceevent-devel available,
> we get:
>
>   Makefile.perf:367: *** PYTHON_EXT_SRCS=3D util/python.c ../lib/ctype.c =
util/cap.c util/evlist.c util/evsel.c util/evsel_fprintf.c util/perf_event_=
attr_fprintf.c util/cpumap.c util/memswap.c util/mmap.c util/namespaces.c .=
./lib/bitmap.c ../lib/find_bit.c ../lib/list_sort.c ../lib/hweight.c ../lib=
/string.c ../lib/vsprintf.c util/thread_map.c util/util.c util/cgroup.c uti=
l/parse-branch-options.c util/rblist.c util/counts.c util/print_binary.c ut=
il/strlist.c ../lib/rbtree.c util/string.c util/symbol_fprintf.c util/units=
.c util/affinity.c util/rwsem.c util/hashmap.c util/perf_regs.c util/fncach=
e.c util/perf-regs-arch/perf_regs_aarch64.c util/perf-regs-arch/perf_regs_a=
rm.c util/perf-regs-arch/perf_regs_csky.c util/perf-regs-arch/perf_regs_loo=
ngarch.c util/perf-regs-arch/perf_regs_mips.c util/perf-regs-arch/perf_regs=
_powerpc.c util/perf-regs-arch/perf_regs_riscv.c util/perf-regs-arch/perf_r=
egs_s390.c util/perf-regs-arch/perf_regs_x86.c.  Stop.
>   make[1]: *** [Makefile.perf:242: sub-make] Error 2
>
> I.e. both the comments and the util/trace-event.c were removed.
>
> When using:
>
> msg :=3D $(error PYTHON_EXT_SRCS=3D$(PYTHON_EXT_SRCS))
>
> While on the more recent fedora:38, with the new grep and make packages
> and libtraceevent-devel installed:
>
>   Makefile.perf:367: *** PYTHON_EXT_SRCS=3D util/python.c ../lib/ctype.c =
util/cap.c util/evlist.c util/evsel.c util/evsel_fprintf.c util/perf_event_=
attr_fprintf.c util/cpumap.c util/memswap.c util/mmap.c util/namespaces.c .=
./lib/bitmap.c ../lib/find_bit.c ../lib/list_sort.c ../lib/hweight.c ../lib=
/string.c ../lib/vsprintf.c util/thread_map.c util/util.c util/cgroup.c uti=
l/parse-branch-options.c util/rblist.c util/counts.c util/print_binary.c ut=
il/strlist.c util/trace-event.c ../lib/rbtree.c util/string.c util/symbol_f=
printf.c util/units.c util/affinity.c util/rwsem.c util/hashmap.c util/perf=
_regs.c util/fncache.c util/perf-regs-arch/perf_regs_aarch64.c util/perf-re=
gs-arch/perf_regs_arm.c util/perf-regs-arch/perf_regs_csky.c util/perf-regs=
-arch/perf_regs_loongarch.c util/perf-regs-arch/perf_regs_mips.c util/perf-=
regs-arch/perf_regs_powerpc.c util/perf-regs-arch/perf_regs_riscv.c util/pe=
rf-regs-arch/perf_regs_s390.c util/perf-regs-arch/perf_regs_x86.c.  Stop.
>   make[1]: *** [Makefile.perf:242: sub-make] Error 2
>   make: *** [Makefile:113: install-bin] Error 2
>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>   $
>
> I.e. only the comments were removed.
>
> If we build it on the same fedora:38 system, but using NO_LIBTRACEEVENT=
=3D1
>
>   $ make NO_LIBTRACEEVENT=3D1 CORESIGHT=3D1 O=3D/tmp/build/$(basename $PW=
D) -C tools/perf install-bin
>   Makefile.perf:367: *** PYTHON_EXT_SRCS=3D util/python.c ../lib/ctype.c =
util/cap.c util/evlist.c util/evsel.c util/evsel_fprintf.c util/perf_event_=
attr_fprintf.c util/cpumap.c util/memswap.c util/mmap.c util/namespaces.c .=
./lib/bitmap.c ../lib/find_bit.c ../lib/list_sort.c ../lib/hweight.c ../lib=
/string.c ../lib/vsprintf.c util/thread_map.c util/util.c util/cgroup.c uti=
l/parse-branch-options.c util/rblist.c util/counts.c util/print_binary.c ut=
il/strlist.c ../lib/rbtree.c util/string.c util/symbol_fprintf.c util/units=
.c util/affinity.c util/rwsem.c util/hashmap.c util/perf_regs.c util/fncach=
e.c util/perf-regs-arch/perf_regs_aarch64.c util/perf-regs-arch/perf_regs_a=
rm.c util/perf-regs-arch/perf_regs_csky.c util/perf-regs-arch/perf_regs_loo=
ngarch.c util/perf-regs-arch/perf_regs_mips.c util/perf-regs-arch/perf_regs=
_powerpc.c util/perf-regs-arch/perf_regs_riscv.c util/perf-regs-arch/perf_r=
egs_s390.c util/perf-regs-arch/perf_regs_x86.c.  Stop.
>   make[1]: *** [Makefile.perf:242: sub-make] Error 2
>   make: *** [Makefile:113: install-bin] Error 2
>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>   $
>
> Both comments and the util/trace-event.c file removed.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 456872ac410df4c0..d80dcaa5a1e337ae 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -361,7 +361,7 @@ python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -=
r $(PYTHON_EXTBUILD) $(OUTPUT
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# util/python-ext-sources)
>  else
> -  PYTHON_EXT_SRCS :=3D $(shell grep -v '^\#\|util/trace-event.c' util/py=
thon-ext-sources)
> +  PYTHON_EXT_SRCS :=3D $(shell grep -v ^\#\\\|util/trace-event.c util/py=
thon-ext-sources)
>  endif
>
>  PYTHON_EXT_DEPS :=3D util/python-ext-sources util/setup.py $(LIBAPI)
> --
> 2.41.0
>
