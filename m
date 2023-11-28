Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131F77FC298
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbjK1R5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346600AbjK1R4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:56:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFAC324E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:55:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bbf7a6029so160e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701194135; x=1701798935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugBeSgSYCz9ybgMm2e5vxSBN02IdcZ2SmwFOGZ5+9F0=;
        b=oB/5DRkOGxxviIWEL62mZQ+uG/0sNBpNs0jLysXVVgRcN9OW9HuPqk26AHPZfOwar3
         3pajZmcJGgfnaxcAs1xvQQ5TBBloOdFFGA//cYjJbX02TXjzqBEBistq2P0+BEViDwpi
         YkRjtsfxrZU88QJMwrf0o50x2mDGhguvsp+kJV04AQYYma5I+DWTqSONHq1W7fdCPVVX
         kacUv0XK6GM4YAEymoR4Thb6S3OGDNCX0T4ota/IB9URp/y4XcOSvESNPsb9V2X3wNT+
         hzdGwno4t4PXmWd8+H2b2kK7pfOL4Vz8Mn3zvSc6IvHfETFz1+Irzyu402A9O0YyyFay
         WLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194135; x=1701798935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugBeSgSYCz9ybgMm2e5vxSBN02IdcZ2SmwFOGZ5+9F0=;
        b=nWvWas2XBwpwVsNct3aprRb+7LlS9XVzPNS7HMuPQ5OjT0eH8JMKVua6NTd1lUihcy
         Ylb+LtQrlCYu0MONQi8EzSupUBJRw0mXtj1vDia3LruT9CHCCcUPkH60ylFlXYIk9WQz
         SGcwgGynVmoYzJX4ByQtWsbpyPxsKVHzsEdH2hHtAWyA392xM2BPC8JQdIP9n3fz1PDK
         w4cz2AdqQqMzeVLuC8+HSnopAs3rTcdz9ympIC8C0MZpLDiH8ByQDMt79iSUhgWa14VV
         Qc1JbiCNFLKu1J9evc6KMUYE/IIMpKq7d/rkdxI99oA6BV4C4MoizfUbKUW9vWuee5g9
         XXGg==
X-Gm-Message-State: AOJu0YwIFmCqeKO5aAUWWMgWvzf508zAWIlZWXPLJTso5/S5X9i2fuX0
        jmTtKhL+SVG2G0pdP4BgHYno6C7m4JvUZ3WoYSIY4Q==
X-Google-Smtp-Source: AGHT+IFaDkaMABJ614yhVDsD1gyDQpT8ElYwuxkdZVgJr7NOCU4EaS8jYCxz2m7q7PAH8Cgd13o5YCt9dKwp9QyPghQ=
X-Received: by 2002:a19:3811:0:b0:50b:bca9:72c with SMTP id
 f17-20020a193811000000b0050bbca9072cmr65388lfa.3.1701194134505; Tue, 28 Nov
 2023 09:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-5-irogers@google.com>
 <ZWURZvDA2L4Mr3HR@kernel.org> <ZWYf+Sy6JKd7CYlN@kernel.org> <ZWYlgPwGmAEUKIsE@kernel.org>
In-Reply-To: <ZWYlgPwGmAEUKIsE@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Nov 2023 09:55:22 -0800
Message-ID: <CAP-5=fVgVY8hhhhgW-aJic6Vez2CJmA8VLx+Az3kKJFB7fz1Pg@mail.gmail.com>
Subject: Re: [PATCH v4 04/53] perf mmap: Lazily initialize zstd streams
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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

On Tue, Nov 28, 2023 at 9:38=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Nov 28, 2023 at 02:14:33PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Mon, Nov 27, 2023 at 07:00:06PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Thu, Nov 02, 2023 at 10:56:46AM -0700, Ian Rogers escreveu:
> > > > Zstd streams create dictionaries that can require significant RAM,
> > > > especially when there is one per-CPU. Tools like perf record won't =
use
> > > > the streams without the -z option, and so the creation of the strea=
ms
> > > > is pure overhead. Switch to creating the streams on first use.
>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > > Thanks, applied to perf-tools-next.
>
> > Trying to fix this now:
> >
> >   6    20.59 alpine:3.18                   : FAIL gcc version 12.2.1 20=
220924 (Alpine 12.2.1_git20220924-r10)
> >     In file included from util/zstd.c:5:
> >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown=
 type name 'ssize_t'; did you mean 'size_t'?
>
> So the problem was really the one above, that got fixed with the patch
> below, that is what 'man size_t' documents on my fedora:38 system.


Thanks, perhaps this is something clang-tidy, clang-format or similar
could help with in the future. There was event IWYU discussion at LPC:
https://lpc.events/event/17/contributions/1620/attachments/1228/2520/Linux%=
20Kernel%20Header%20Optimization.pdf

Thanks,
Ian

> - Arnaldo
>
> diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
> index 9eb6eb5bf038ce54..b29109cd36095c4f 100644
> --- a/tools/perf/util/compress.h
> +++ b/tools/perf/util/compress.h
> @@ -3,7 +3,8 @@
>  #define PERF_COMPRESS_H
>
>  #include <stdbool.h>
> -#include <stdlib.h>
> +#include <stddef.h>
> +#include <sys/types.h>
>  #ifdef HAVE_ZSTD_SUPPORT
>  #include <zstd.h>
>  #endif
>
> >        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           | ^~~~~~~
> >           | size_t
> >     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_strea=
m_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, s=
ize_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_da=
ta *, void *, long unsigned int,  void *, long unsigned int,  long unsigned=
 int,  long unsigned int (*)(void *, long unsigned int))'}
> >        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous=
 declaration of 'zstd_compress_stream_to_records' with type 'int(struct zst=
d_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, siz=
e_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, lo=
ng unsigned int,  long unsigned int,  long unsigned int (*)(void *, long un=
signed int))'}
> >        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: u=
til] Error 2
> >       CC      /tmp/build/perf/util/zstd.o
> >       CC      /tmp/build/perf/util/cap.o
> >       CXX     /tmp/build/perf/util/demangle-cxx.o
> >       CC      /tmp/build/perf/util/demangle-ocaml.o
> >     In file included from util/zstd.c:5:
> >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown=
 type name 'ssize_t'; did you mean 'size_t'?
> >        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           | ^~~~~~~
> >           | size_t
> >       CC      /tmp/build/perf/util/demangle-java.o
> >     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_strea=
m_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, s=
ize_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_da=
ta *, void *, long unsigned int,  void *, long unsigned int,  long unsigned=
 int,  long unsigned int (*)(void *, long unsigned int))'}
> >        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous=
 declaration of 'zstd_compress_stream_to_records' with type 'int(struct zst=
d_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, siz=
e_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, lo=
ng unsigned int,  long unsigned int,  long unsigned int (*)(void *, long un=
signed int))'}
> >        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >    7    21.14 alpine:edge                   : FAIL gcc version 13.1.1 2=
0230722 (Alpine 13.1.1_git20230722)
> >     In file included from util/zstd.c:5:
> >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown=
 type name 'ssize_t'; did you mean 'size_t'?
> >        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           | ^~~~~~~
> >           | size_t
> >     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_strea=
m_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, s=
ize_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_da=
ta *, void *, long unsigned int,  void *, long unsigned int,  long unsigned=
 int,  long unsigned int (*)(void *, long unsigned int))'}
> >        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous=
 declaration of 'zstd_compress_stream_to_records' with type 'int(struct zst=
d_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, siz=
e_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, lo=
ng unsigned int,  long unsigned int,  long unsigned int (*)(void *, long un=
signed int))'}
> >        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: u=
til] Error 2
> >       CC      /tmp/build/perf/util/cap.o
> >       CXX     /tmp/build/perf/util/demangle-cxx.o
> >       CC      /tmp/build/perf/util/demangle-ocaml.o
> >       CC      /tmp/build/perf/util/demangle-java.o
> >     In file included from util/zstd.c:5:
> >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown=
 type name 'ssize_t'; did you mean 'size_t'?
> >        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           | ^~~~~~~
> >           | size_t
> >     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_strea=
m_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, s=
ize_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_da=
ta *, void *, long unsigned int,  void *, long unsigned int,  long unsigned=
 int,  long unsigned int (*)(void *, long unsigned int))'}
> >        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous=
 declaration of 'zstd_compress_stream_to_records' with type 'int(struct zst=
d_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, siz=
e_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, lo=
ng unsigned int,  long unsigned int,  long unsigned int (*)(void *, long un=
signed int))'}
> >        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *d=
ata, void *dst, size_t dst_size,
> >           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
>
> --
