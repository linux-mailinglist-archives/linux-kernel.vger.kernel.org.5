Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A1805DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbjLESVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbjLESVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:21:33 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C0137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:21:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a186e5d1056so762594566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701800497; x=1702405297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+nkDPugKKNNkRBSOn2CVgjn9FjQf79ux7IfHoEDnOg=;
        b=W32wTH4h5PuyCsKJT+O5qeimqf9gUO1Bi9ihc/ahqaX6CWx/Um5+clPktn1WLKCSKd
         GEkmI8TkBaVSIerOmjdFO15b+QoGblnZelT6abp218oD7+W63lXYZnsjFmksee8Ob3sR
         XDpO3G+ttuAFW0Oq0IjW/BsePkoQZYVRPJw/0RTykBaLtzDrSnOLhtbWW+eOJDyeMNaM
         ic7f4tpPurSLzGUvvHHwE5m1w3irhGiuVjSOY1FQpwuAvaV6r+vbzI8mRSTov1EJ1kw/
         x16swUkx+HSiU2Z83/vF3CKKeJCJg4Cl/WofC9T3EeZspHJ6qBbm6JM0/Ot8H0wY/CLI
         5N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800497; x=1702405297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+nkDPugKKNNkRBSOn2CVgjn9FjQf79ux7IfHoEDnOg=;
        b=WPcNMT/DfZK3nLZYJLD864Yw4zYZD+cY9FSE5egE+9tn1FUmPxrQVXeH1b2vqh4UCK
         T5RoVXF9Wfcl1uy8dYgJeYq2/wwy0/QaIzA/Ru0FRQGL3/WzpT37pHCdG9QbsOJ3qii4
         VTxgPH5aLULgP+tARFRikUmnEKY9UE8nqjm9rrWUQNKzUytms0Xnd2u+TATTC60rvSvn
         LLTGFis+Yp9H7dXVqiLLijU6wmpjmVvhvGF56jph1W70Sek+tIibwRX04fPR4aXZzN43
         c+FjzPaFcJ+1DtQ3nI+jUAI514WqaPOiX6zkBwsgPPRp/AIOV+Wd4YLfyARzJoqOX/D6
         y1hw==
X-Gm-Message-State: AOJu0Yx73Ngo3zBTGcmDCnCHhXHvTkNO/9hVZrljohH96+BLQuJAwXQx
        luQjUFpg6mmoamS5GVWjymjjUkK5f3gQn0TLToiE5g==
X-Google-Smtp-Source: AGHT+IFAN1L/kvER1ufG3on6wWYdyv6ejtbTg8SseJjhbevswgH/r5YufXiyrXeH+9/nPN+BLLF/ykvExC2TujbviVw=
X-Received: by 2002:a17:906:2241:b0:a19:a19b:5605 with SMTP id
 1-20020a170906224100b00a19a19b5605mr892974ejr.149.1701800497041; Tue, 05 Dec
 2023 10:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-3-khuey@kylehuey.com>
 <CAEf4BzbDKiP7femK5DZ8jeyK0u63KrV+FogEDVPaYS7mc4if7g@mail.gmail.com>
In-Reply-To: <CAEf4BzbDKiP7femK5DZ8jeyK0u63KrV+FogEDVPaYS7mc4if7g@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 5 Dec 2023 10:21:25 -0800
Message-ID: <CAP045ArrF81xNqRZcW=8Uw7R2Vvgman1QODbt7wgL_U6HKQ6Mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftest/bpf: Test returning zero from a perf bpf
 program suppresses SIGIO.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 2:14=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 4, 2023 at 12:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote=
:
> >
> > The test sets a hardware breakpoint and uses a bpf program to suppress =
the
> > I/O availability signal if the ip matches the expected value.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > ---
> >  .../selftests/bpf/prog_tests/perf_skip.c      | 95 +++++++++++++++++++
> >  .../selftests/bpf/progs/test_perf_skip.c      | 23 +++++
> >  2 files changed, 118 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools=
/testing/selftests/bpf/prog_tests/perf_skip.c
> > new file mode 100644
> > index 000000000000..b269a31669b7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > @@ -0,0 +1,95 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +#include <test_progs.h>
> > +#include "test_perf_skip.skel.h"
> > +#include <linux/hw_breakpoint.h>
> > +#include <sys/mman.h>
> > +
> > +#define BPF_OBJECT            "test_perf_skip.bpf.o"
>
> leftover?

Indeed. Fixed.

> > +
> > +static void handle_sig(int)
> > +{
> > +       ASSERT_OK(1, "perf event not skipped");
> > +}
> > +
> > +static noinline int test_function(void)
> > +{
>
> please add
>
> asm volatile ("");
>
> here to prevent compiler from actually inlining at the call site

Ok.

> > +       return 0;
> > +}
> > +
> > +void serial_test_perf_skip(void)
> > +{
> > +       sighandler_t previous;
> > +       int duration =3D 0;
> > +       struct test_perf_skip *skel =3D NULL;
> > +       int map_fd =3D -1;
> > +       long page_size =3D sysconf(_SC_PAGE_SIZE);
> > +       uintptr_t *ip =3D NULL;
> > +       int prog_fd =3D -1;
> > +       struct perf_event_attr attr =3D {0};
> > +       int perf_fd =3D -1;
> > +       struct f_owner_ex owner;
> > +       int err;
> > +
> > +       previous =3D signal(SIGIO, handle_sig);
> > +
> > +       skel =3D test_perf_skip__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "skel_load"))
> > +               goto cleanup;
> > +
> > +       prog_fd =3D bpf_program__fd(skel->progs.handler);
> > +       if (!ASSERT_OK(prog_fd < 0, "bpf_program__fd"))
> > +               goto cleanup;
> > +
> > +       map_fd =3D bpf_map__fd(skel->maps.ip);
> > +       if (!ASSERT_OK(map_fd < 0, "bpf_map__fd"))
> > +               goto cleanup;
> > +
> > +       ip =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED=
, map_fd, 0);
> > +       if (!ASSERT_OK_PTR(ip, "mmap bpf map"))
> > +               goto cleanup;
> > +
> > +       *ip =3D (uintptr_t)test_function;
> > +
> > +       attr.type =3D PERF_TYPE_BREAKPOINT;
> > +       attr.size =3D sizeof(attr);
> > +       attr.bp_type =3D HW_BREAKPOINT_X;
> > +       attr.bp_addr =3D (uintptr_t)test_function;
> > +       attr.bp_len =3D sizeof(long);
> > +       attr.sample_period =3D 1;
> > +       attr.sample_type =3D PERF_SAMPLE_IP;
> > +       attr.pinned =3D 1;
> > +       attr.exclude_kernel =3D 1;
> > +       attr.exclude_hv =3D 1;
> > +       attr.precise_ip =3D 3;
> > +
> > +       perf_fd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> > +       if (CHECK(perf_fd < 0, "perf_event_open", "err %d\n", perf_fd))
>
> please don't use CHECK() macro, stick to ASSERT_xxx()

Done.

> also, we are going to run all this on different hardware and VMs, see
> how we skip tests if hardware support is not there. See test__skip
> usage in prog_tests/perf_branches.c, as one example

Hmm I suppose it should be conditioned on CONFIG_HAVE_HW_BREAKPOINT.

> > +               goto cleanup;
> > +
> > +       err =3D fcntl(perf_fd, F_SETFL, O_ASYNC);
>
> I assume this is what will send SIGIO, right? Can you add a small
> comment explicitly saying this?

Done.

> > +       if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
> > +               goto cleanup;
> > +
> > +       owner.type =3D F_OWNER_TID;
> > +       owner.pid =3D gettid();
> > +       err =3D fcntl(perf_fd, F_SETOWN_EX, &owner);
> > +       if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
> > +               goto cleanup;
> > +
> > +       err =3D ioctl(perf_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
> > +       if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_SET_BPF)"))
> > +               goto cleanup;
>
> we have a better way to do this, please use
> bpf_program__attach_perf_event() instead

Done.

> > +
> > +       test_function();
> > +
> > +cleanup:
> > +       if (perf_fd >=3D 0)
> > +               close(perf_fd);
> > +       if (ip)
> > +               munmap(ip, page_size);
> > +       if (skel)
> > +               test_perf_skip__destroy(skel);
> > +
> > +       signal(SIGIO, previous);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools=
/testing/selftests/bpf/progs/test_perf_skip.c
> > new file mode 100644
> > index 000000000000..ef01a9161afe
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > +       __uint(max_entries, 1);
> > +       __uint(map_flags, BPF_F_MMAPABLE);
> > +       __type(key, uint32_t);
> > +       __type(value, uintptr_t);
> > +} ip SEC(".maps");
>
> please use global variable:
>
> __u64 ip;
>
> and then access it from user-space side through skeleton
>
> skel->bss.ip =3D &test_function;

Done.

> > +
> > +SEC("perf_event")
> > +int handler(struct bpf_perf_event_data *data)
> > +{
> > +       const uint32_t index =3D 0;
> > +       uintptr_t *v =3D bpf_map_lookup_elem(&ip, &index);
> > +
> > +       return !(v && *v =3D=3D PT_REGS_IP(&data->regs));
>
> and so we the above global var suggestion this will be just:
>
> return ip =3D=3D PT_REGS_IP(&data->regs);
>
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.34.1
> >

- Kyle
