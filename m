Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22257C7BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjJMDNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:13:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05AEB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:13:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so2843515a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmn-com-au.20230601.gappssmtp.com; s=20230601; t=1697166817; x=1697771617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh9GrgKa9j4l+aRPCooNGk8I84arXkGHoVeRTOb15Bc=;
        b=DSXt9k9q9EKnm5nRqQihLdlzTVvEQENvJfLAeYzF9nr2GxafYdXWEWQmFrSD6LRMt/
         8afJJvn4PaOV4WU6iNyqiCCRRvScsAYxAgbCMe5tSKxolPpwSlAjwOZtvWVFDqZ4ohT6
         wuhwT2JsUL8VT28kKhdTbCepnWEl8N/plb3Vs54aNnq24DLXJdUc/Ypd97+xS6ZM3J6b
         DPE3sg/52sn94H8+FbKsUEFVkAjuK0X0FBihEyvyYHkM9FKOMngNu/TulyLfz17hhb+F
         kHaDVQx4uXViueMtvuS0rQQDDCU10TH0BndHY+okOJ3O3IfWftWqz1e2WtfDrgInWhFa
         60Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697166817; x=1697771617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh9GrgKa9j4l+aRPCooNGk8I84arXkGHoVeRTOb15Bc=;
        b=EuHR/ENimy7AmRIBO1sfnzByix7Hdon/pO/IHGMFG3mYM8J97uuAOiPfVMJKfoMDg8
         iOhAerKEj89BsyceV5DhawXDSaGrnPeufu5Vo6XfvRMgc0SJJ4WotQikC+Umb7JGs86w
         MUjU/KAIS8OZURYDr7zV20nbdH296Oz9ltLvAIZY1XJcQusFYroY1GXlFbiFTVWzCzKm
         SWsjYuLPFUvhE4k0Qj2EZsZc+Hx3GFl631L7dIXMlsgoz2gD4vSeD20kOkubaB1cKLi6
         UQaPMhFbdbGR1AcszYkea9w17M5Ws9YkTG/7hOS99UbbYKosqRmEASFSxBsCh8zGu6To
         tmNg==
X-Gm-Message-State: AOJu0YyMgx1gROcs60UYg6Lo4jbch7GapSTUCKXunPT4h83sZc53YQWy
        iyYlubMzcKgJoAuPhA2VnQnZ0RbM3P9FHIEKvHItbw==
X-Google-Smtp-Source: AGHT+IHvZ17To1stiQJWyyQrwQlN6RKbchB9YFbwir7UWOPkkbeRgkjImvF8R8r7Uu/GXf6SqTrnjuJnH7mu7BYs6Ow=
X-Received: by 2002:a17:906:2d1:b0:9b2:b765:8802 with SMTP id
 17-20020a17090602d100b009b2b7658802mr25418604ejk.40.1697166816430; Thu, 12
 Oct 2023 20:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231005123413.GA488417@alecto.usersys.redhat.com> <20231012114550.152846-1-asavkov@redhat.com>
In-Reply-To: <20231012114550.152846-1-asavkov@redhat.com>
From:   Rod Webster <rod@vmn.com.au>
Date:   Fri, 13 Oct 2023 13:13:25 +1000
Message-ID: <CANV1gkc4yXXAnEu6N1xB_oX_YQ7-8TiPyJ=p8pgZ_Y7o3OCg1g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in struct syscall_tp_t
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the novice with the RT kernel, Could somebody  tell me what kernel
this bug was first introduced in and what kernel we need to install to
get the fix?

This could be the issue we have been experiencing in the Linuxcnc
community with excessive RT network latency (mostly with realtek
NIC's).
I had flagged Lazy preemption as being the possible  changes causing
this issue. I thought Lazy Preemption was added Circa kernel 5.09 as
it affected Debian Bullseye on Kernel 5.10 which coincided with when
we first observed the problem.

Thanks in anticipation.

Rod Webster

Rod Webster
1300 896 832
+61 435 765 611
VMN=C2=AE
www.vmn.com.au

Sole Queensland Distributor


On Thu, 12 Oct 2023 at 21:46, Artem Savkov <asavkov@redhat.com> wrote:
>
> linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add support
> for lazy preemption")) that adds an extra member to struct trace_entry.
> This causes the offset of args field in struct trace_event_raw_sys_enter
> be different from the one in struct syscall_trace_enter:
>
> struct trace_event_raw_sys_enter {
>         struct trace_entry         ent;                  /*     0    12 *=
/
>
>         /* XXX last struct has 3 bytes of padding */
>         /* XXX 4 bytes hole, try to pack */
>
>         long int                   id;                   /*    16     8 *=
/
>         long unsigned int          args[6];              /*    24    48 *=
/
>         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>         char                       __data[];             /*    72     0 *=
/
>
>         /* size: 72, cachelines: 2, members: 4 */
>         /* sum members: 68, holes: 1, sum holes: 4 */
>         /* paddings: 1, sum paddings: 3 */
>         /* last cacheline: 8 bytes */
> };
>
> struct syscall_trace_enter {
>         struct trace_entry         ent;                  /*     0    12 *=
/
>
>         /* XXX last struct has 3 bytes of padding */
>
>         int                        nr;                   /*    12     4 *=
/
>         long unsigned int          args[];               /*    16     0 *=
/
>
>         /* size: 16, cachelines: 1, members: 3 */
>         /* paddings: 1, sum paddings: 3 */
>         /* last cacheline: 16 bytes */
> };
>
> This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
> test_profiler testcase because max_ctx_offset is calculated based on the
> former struct, while off on the latter:
>
>   10488         if (is_tracepoint || is_syscall_tp) {
>   10489                 int off =3D trace_event_get_offsets(event->tp_eve=
nt);
>   10490
>   10491                 if (prog->aux->max_ctx_offset > off)
>   10492                         return -EACCES;
>   10493         }
>
> What bpf program is actually getting is a pointer to struct
> syscall_tp_t, defined in kernel/trace/trace_syscalls.c. This patch fixes
> the problem by aligning struct syscall_tp_t with with struct
> syscall_trace_(enter|exit) and changing the tests to use these structs
> to dereference context.
>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  kernel/trace/trace_syscalls.c                    | 4 ++--
>  tools/testing/selftests/bpf/progs/profiler.inc.h | 2 +-
>  tools/testing/selftests/bpf/progs/test_vmlinux.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
> index de753403cdafb..9c581d6da843a 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -556,7 +556,7 @@ static int perf_call_bpf_enter(struct trace_event_cal=
l *call, struct pt_regs *re
>  {
>         struct syscall_tp_t {
>                 struct trace_entry ent;
> -               unsigned long syscall_nr;
> +               int syscall_nr;
>                 unsigned long args[SYSCALL_DEFINE_MAXARGS];
>         } __aligned(8) param;
>         int i;
> @@ -661,7 +661,7 @@ static int perf_call_bpf_exit(struct trace_event_call=
 *call, struct pt_regs *reg
>  {
>         struct syscall_tp_t {
>                 struct trace_entry ent;
> -               unsigned long syscall_nr;
> +               int syscall_nr;
>                 unsigned long ret;
>         } __aligned(8) param;
>
> diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/tes=
ting/selftests/bpf/progs/profiler.inc.h
> index f799d87e87002..897061930cb76 100644
> --- a/tools/testing/selftests/bpf/progs/profiler.inc.h
> +++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
> @@ -609,7 +609,7 @@ ssize_t BPF_KPROBE(kprobe__proc_sys_write,
>  }
>
>  SEC("tracepoint/syscalls/sys_enter_kill")
> -int tracepoint__syscalls__sys_enter_kill(struct trace_event_raw_sys_ente=
r* ctx)
> +int tracepoint__syscalls__sys_enter_kill(struct syscall_trace_enter* ctx=
)
>  {
>         struct bpf_func_stats_ctx stats_ctx;
>
> diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/tes=
ting/selftests/bpf/progs/test_vmlinux.c
> index 4b8e37f7fd06c..78b23934d9f8f 100644
> --- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
> +++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
> @@ -16,12 +16,12 @@ bool kprobe_called =3D false;
>  bool fentry_called =3D false;
>
>  SEC("tp/syscalls/sys_enter_nanosleep")
> -int handle__tp(struct trace_event_raw_sys_enter *args)
> +int handle__tp(struct syscall_trace_enter *args)
>  {
>         struct __kernel_timespec *ts;
>         long tv_nsec;
>
> -       if (args->id !=3D __NR_nanosleep)
> +       if (args->nr !=3D __NR_nanosleep)
>                 return 0;
>
>         ts =3D (void *)args->args[0];
> --
> 2.41.0
>
>
