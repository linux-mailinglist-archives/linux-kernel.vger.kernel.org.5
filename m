Return-Path: <linux-kernel+bounces-146201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB7B8A6201
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667DBB2113A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380BD21342;
	Tue, 16 Apr 2024 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="V6rHyZ3Y"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E314A8F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240454; cv=none; b=KmeJZXnxcpWQxAvxvJrAHPbPm+qIKQqyifcq86YnPeK9v5Rl12nbJAQMZsUNRWuTzLFFwEcVqlOFLkaCQPA2aVjnzvTUoeBhA72gfMmXdKvYlx1sdOOEcAj621kHroTvFfmNcrK/FBTJQQKikdYz16g17PL7wwTExpqZMxi1pek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240454; c=relaxed/simple;
	bh=7/7G0SneFincR317RboAeX7LwyJoaP+YC+itBzI3+cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlJsVofAfwpWzA3661zGvH8ZstARSkRR/d1mtlWpz8dcl1Gc8NQAtsCwCAAiaX7TBvEH9qSipqQtyoCWnTCy1YrT7xWUI9EFlMZE2FSabYzyL8Nrj36hfx2pPhar9l6BzzrY37a3KCu3zj2Udlv+kfxQQfNeX6t+A7+9a9tlo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=V6rHyZ3Y; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a3af91497so18260895ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713240450; x=1713845250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8upnhEhLFp1tbjfp7BYUAOZCTyEUYU/ovG6J7BQLZY=;
        b=V6rHyZ3YRBu0mh+ILNRWF0dUtuOsbYCoHLI4hYbWy8N9ra3GO8Os1kotVYruIFzZZz
         v1djjKK7yP9dRxbAXzUF60Xzs6jMchI9U1mBCIKpdWgsMr7UW0QiaKkTzfbJYh3RZ6XR
         ttNV6P45bwVzuUXE2lL+wl3DKNWy2074PAqQHqkkyoazjh2K2R9a/YSuI7JV6+6oyNSW
         ZzuDtz6VpB5AVsk2qyReUMKqPINirBzwX3eQJZ/qREbGkjCVox8UON7FlYr69Lojr5Al
         2tP39B0NDzsnxrGlPYM80KW1Qe4+HmF7RRcKD1oPr/boFbIX9a8j6ZbUGftTroZ6mUrf
         G54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240450; x=1713845250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8upnhEhLFp1tbjfp7BYUAOZCTyEUYU/ovG6J7BQLZY=;
        b=ne1gf50bbuzVRVjJ6W8YZG2va8eC6PeSvqhK9X28fgS3z151A9U/0V0cqowJjW/ZRQ
         07KMz3fX4/7NMLXHB0Dp5Q2dbsJoizb5j7sMs0xN5bTrfc3EEgzdLxX0NEDRoiOcP+4q
         SPaglriqF02KFEKSBLNeW4N2yHP2lvl1muuD9tL+m8/DnqG4xv8dQtIkFZanupQXsvID
         RZ4w4WewIw18B0xMAzh1vz3HA5B/Rrpgu/6G2VsxkVkTAKM6fyf6dE9PdZ3pWd4x2ib6
         w0JmHmEUcXC5PZkURoeweEmHa+JvMP0VsJtHEBjpUOeaehbveDY9MiOQKgbZWhkvOYFE
         WTBw==
X-Forwarded-Encrypted: i=1; AJvYcCWvOPVt0adPHiS5zafKpTOTXve7WbTRrn1tp+Y78Z5dnZ8Lsj0kbjn3+YAKPXFcnenrb0yOgtO+jKyQTspZHl/fD2FzN0k4LvBLTibk
X-Gm-Message-State: AOJu0YxiX9AE97xBIOAiuC8KjCVTCNETKIgCADxEnc7Zy+rZ3zen8G8O
	ZjScELWBsYDD4MnKcAmVQHrFLBuRW/JM+6EvDabstxx4bvJ0h0+PmFuLzcctSlEm0YPDA6yvKfs
	wBSRB8olHDpIyIwLGlgv/BfibMFEpyKf1PfpC4f8wXdAjDpUb
X-Google-Smtp-Source: AGHT+IGcMRDGb45nvPaWSiKnkGdmNsG3NdTP+tCw5UNhUIOvJSGkE8XS1QyDDx6JKj2pkQvImgzj3QIghiJ0sOvAmTE=
X-Received: by 2002:a05:6e02:1789:b0:36a:1290:4368 with SMTP id
 y9-20020a056e02178900b0036a12904368mr17084209ilu.22.1713240450232; Mon, 15
 Apr 2024 21:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103165438.633054-1-samuel.holland@sifive.com>
 <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
 <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com> <a4c4c9f2-9fe1-4c22-a99c-1667481ddd6b@rivosinc.com>
In-Reply-To: <a4c4c9f2-9fe1-4c22-a99c-1667481ddd6b@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 16 Apr 2024 09:37:18 +0530
Message-ID: <CAAhSdy1yoCMtR52X7tS6dB2x_ysgA8K4hSSXH044bbq2uFY7jQ@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Atish Patra <atishp@rivosinc.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:31=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> On 4/10/24 18:40, Samuel Holland wrote:
> > Hi Atish,
> >
> > On 2024-03-18 2:44 PM, Atish Patra wrote:
> >> On Wed, Jan 3, 2024 at 8:54=E2=80=AFAM Samuel Holland <samuel.holland@=
sifive.com> wrote:
> >>>
> >>> The RISC-V SBI PMU specification defines several standard hardware an=
d
> >>> cache events. Currently, all of these events appear in the `perf list=
`
> >>> output, even if they are not actually implemented. Add logic to check
> >>> which events are supported by the hardware (i.e. can be mapped to som=
e
> >>> counter), so only usable events are reported to userspace.
> >>>
> >>
> >> Thanks for the patch.
> >> This adds tons of SBI calls at every boot for a use case which is at
> >> best confusing for a subset of users who actually wants to run perf.
> >
> > I should have been clearer in the patch description. This is not just a=
 cosmetic
> > change; because perf sees these as valid events, it tries to use them i=
n
> > commands like `perf stat`. When the error from SBI_EXT_PMU_COUNTER_CFG_=
MATCH
> > causes the ->add() callback to fail, this prevents any other events fro=
m being
> > scheduled on that same CPU (search can_add_hw in kernel/events/core.c).=
 That is
> > why the dTLB/iTLB miss counts are missing in the "before" example below=
.
> >
>
> Thanks for explaining the problem. I can reproduce it in qemu as well if
> enough number of invalid events given on the command line and the
> workload is short enough.
>
> >> This probing can be done at runtime by invoking the
> >> pmu_sbi_check_event from pmu_sbi_event_map.
> >> We can update the event map after that so that it doesn't need to
> >> invoke pmu_sbi_check_event next time.
> >
> > I tried to implement this suggestion, but it did not work. The SBI inte=
rface
> > does not distinguish between "none of the counters can monitor the spec=
ified
> > event [because the event is unsupported]" and "none of the counters can=
 monitor
> > the specified event [because the counters are busy]". It is not suffici=
ent for
> > the kernel to verify that at least one counter is available before perf=
orming
> > the check, because certain events may only be usable on a subset of cou=
nters
> > (per riscv,event-to-mhpmcounters), and the kernel does not know that ma=
pping.
> >
>
> Yeah. My suggestion was to fix the perf list issue which is different
> than the issue reported now.
>
> > As a result, checking for event support is only reliable when none of t=
he
> > counters are in use. So the check can be asynchronous/deferred to later=
 in the
> > boot process, but I believe it still needs to be performed for all even=
ts before
> > userspace starts using the counters.
> >
>
> We should defer it a work queue for sure. We can also look at improving
> SBI PMU extension to support bulk matching behavior as well.
>
> However, I think a better solution would be to just rely on the json
> file mappings instead of making SBI calls. We are going to have the
> event encoding and mappings in the json in the future.

The problem with JSON based event encoding is how to deal in-case
we are running inside Guest/VM because Host could be anything.

IMO, the JSON based approach is not suitable for SBI PMU. For now,
we either defer the work using the work queue or keep the approach
of this patch as-is.

The good part about SBI PMU extension is that we do have a standard
set of events and we only need a way to discover supported standard
events with a minimum number of SBI calls. It is better to add a new
SBI PMU call to assist supported event discovery which will also
help us virtualize it.

Regards,
Anup

>
> I had added it only for platforms with counter delegation[1] but I think
> this can be generalized for platforms with SBI PMU as well.
>
> I had some hacks to specify the legacy event encodings but Ian rogers
> improved with a generic support by preferring sysfs/json event encodings
> over fixed ones. I am yet to rebase and try Ian's series on top of the
> counter delegation though. Thoughts ?
>
> [1]
> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com=
/
> [2]
> https://lore.kernel.org/bpf/20240415063626.453987-2-irogers@google.com/T/
>
>
> > Regards,
> > Samuel
> >
> >>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >>> ---
> >>> Before this patch:
> >>> $ perf list hw
> >>>
> >>> List of pre-defined events (to be used in -e or -M):
> >>>
> >>>    branch-instructions OR branches                    [Hardware event=
]
> >>>    branch-misses                                      [Hardware event=
]
> >>>    bus-cycles                                         [Hardware event=
]
> >>>    cache-misses                                       [Hardware event=
]
> >>>    cache-references                                   [Hardware event=
]
> >>>    cpu-cycles OR cycles                               [Hardware event=
]
> >>>    instructions                                       [Hardware event=
]
> >>>    ref-cycles                                         [Hardware event=
]
> >>>    stalled-cycles-backend OR idle-cycles-backend      [Hardware event=
]
> >>>    stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event=
]
> >>>
> >>> $ perf stat -ddd true
> >>>
> >>>   Performance counter stats for 'true':
> >>>
> >>>                4.36 msec task-clock                       #    0.744 =
CPUs utilized
> >>>                   1      context-switches                 #  229.325 =
/sec
> >>>                   0      cpu-migrations                   #    0.000 =
/sec
> >>>                  38      page-faults                      #    8.714 =
K/sec
> >>>           4,375,694      cycles                           #    1.003 =
GHz                         (60.64%)
> >>>             728,945      instructions                     #    0.17  =
insn per cycle
> >>>              79,199      branches                         #   18.162 =
M/sec
> >>>              17,709      branch-misses                    #   22.36% =
of all branches
> >>>             181,734      L1-dcache-loads                  #   41.676 =
M/sec
> >>>               5,547      L1-dcache-load-misses            #    3.05% =
of all L1-dcache accesses
> >>>       <not counted>      LLC-loads                                   =
                            (0.00%)
> >>>       <not counted>      LLC-load-misses                             =
                            (0.00%)
> >>>       <not counted>      L1-icache-loads                             =
                            (0.00%)
> >>>       <not counted>      L1-icache-load-misses                       =
                            (0.00%)
> >>>       <not counted>      dTLB-loads                                  =
                            (0.00%)
> >>>       <not counted>      dTLB-load-misses                            =
                            (0.00%)
> >>>       <not counted>      iTLB-loads                                  =
                            (0.00%)
> >>>       <not counted>      iTLB-load-misses                            =
                            (0.00%)
> >>>       <not counted>      L1-dcache-prefetches                        =
                            (0.00%)
> >>>       <not counted>      L1-dcache-prefetch-misses                   =
                            (0.00%)
> >>>
> >>>         0.005860375 seconds time elapsed
> >>>
> >>>         0.000000000 seconds user
> >>>         0.010383000 seconds sys
> >>>
> >>> After this patch:
> >>> $ perf list hw
> >>>
> >>> List of pre-defined events (to be used in -e or -M):
> >>>
> >>>    branch-instructions OR branches                    [Hardware event=
]
> >>>    branch-misses                                      [Hardware event=
]
> >>>    cache-misses                                       [Hardware event=
]
> >>>    cache-references                                   [Hardware event=
]
> >>>    cpu-cycles OR cycles                               [Hardware event=
]
> >>>    instructions                                       [Hardware event=
]
> >>>
> >>> $ perf stat -ddd true
> >>>
> >>>   Performance counter stats for 'true':
> >>>
> >>>                5.16 msec task-clock                       #    0.848 =
CPUs utilized
> >>>                   1      context-switches                 #  193.817 =
/sec
> >>>                   0      cpu-migrations                   #    0.000 =
/sec
> >>>                  37      page-faults                      #    7.171 =
K/sec
> >>>           5,183,625      cycles                           #    1.005 =
GHz
> >>>             961,696      instructions                     #    0.19  =
insn per cycle
> >>>              85,853      branches                         #   16.640 =
M/sec
> >>>              20,462      branch-misses                    #   23.83% =
of all branches
> >>>             243,545      L1-dcache-loads                  #   47.203 =
M/sec
> >>>               5,974      L1-dcache-load-misses            #    2.45% =
of all L1-dcache accesses
> >>>     <not supported>      LLC-loads
> >>>     <not supported>      LLC-load-misses
> >>>     <not supported>      L1-icache-loads
> >>>     <not supported>      L1-icache-load-misses
> >>>     <not supported>      dTLB-loads
> >>>              19,619      dTLB-load-misses
> >>>     <not supported>      iTLB-loads
> >>>               6,831      iTLB-load-misses
> >>>     <not supported>      L1-dcache-prefetches
> >>>     <not supported>      L1-dcache-prefetch-misses
> >>>
> >>>         0.006085625 seconds time elapsed
> >>>
> >>>         0.000000000 seconds user
> >>>         0.013022000 seconds sys
> >>>
> >>>
> >>>   drivers/perf/riscv_pmu_sbi.c | 37 +++++++++++++++++++++++++++++++++=
+--
> >>>   1 file changed, 35 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sb=
i.c
> >>> index 16acd4dcdb96..b58a70ee8317 100644
> >>> --- a/drivers/perf/riscv_pmu_sbi.c
> >>> +++ b/drivers/perf/riscv_pmu_sbi.c
> >>> @@ -86,7 +86,7 @@ struct sbi_pmu_event_data {
> >>>          };
> >>>   };
> >>>
> >>> -static const struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> >>> +static struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> >>>          [PERF_COUNT_HW_CPU_CYCLES]              =3D {.hw_gen_event =
=3D {
> >>>                                                          SBI_PMU_HW_C=
PU_CYCLES,
> >>>                                                          SBI_PMU_EVEN=
T_TYPE_HW, 0}},
> >>> @@ -120,7 +120,7 @@ static const struct sbi_pmu_event_data pmu_hw_eve=
nt_map[] =3D {
> >>>   };
> >>>
> >>>   #define C(x) PERF_COUNT_HW_CACHE_##x
> >>> -static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUN=
T_HW_CACHE_MAX]
> >>> +static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_C=
ACHE_MAX]
> >>>   [PERF_COUNT_HW_CACHE_OP_MAX]
> >>>   [PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
> >>>          [C(L1D)] =3D {
> >>> @@ -265,6 +265,36 @@ static const struct sbi_pmu_event_data pmu_cache=
_event_map[PERF_COUNT_HW_CACHE_M
> >>>          },
> >>>   };
> >>>
> >>> +static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
> >>> +{
> >>> +       struct sbiret ret;
> >>> +
> >>> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
> >>> +                       0, cmask, 0, edata->event_idx, 0, 0);
> >>> +       if (!ret.error) {
> >>> +               sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> >>> +                         ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0,=
 0, 0);
> >>> +       } else if (ret.error =3D=3D SBI_ERR_NOT_SUPPORTED) {
> >>> +               /* This event cannot be monitored by any counter */
> >>> +               edata->event_idx =3D -EINVAL;
> >>> +       }
> >>> +}
> >>> +
> >>> +static void pmu_sbi_update_events(void)
> >>> +{
> >>> +       /* Ensure events are not already mapped to a counter */
> >>> +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> >>> +                 0, cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> >>> +
> >>> +       for (int i =3D 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> >>> +               pmu_sbi_check_event(&pmu_hw_event_map[i]);
> >>> +
> >>> +       for (int i =3D 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
> >>> +               for (int j =3D 0; j < ARRAY_SIZE(pmu_cache_event_map[=
i]); j++)
> >>> +                       for (int k =3D 0; k < ARRAY_SIZE(pmu_cache_ev=
ent_map[i][j]); k++)
> >>> +                               pmu_sbi_check_event(&pmu_cache_event_=
map[i][j][k]);
> >>> +}
> >>> +
> >>>   static int pmu_sbi_ctr_get_width(int idx)
> >>>   {
> >>>          return pmu_ctr_list[idx].width;
> >>> @@ -1046,6 +1076,9 @@ static int pmu_sbi_device_probe(struct platform=
_device *pdev)
> >>>          if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
> >>>                  goto out_free;
> >>>
> >>> +       /* Check which standard events are available */
> >>> +       pmu_sbi_update_events();
> >>> +
> >>>          ret =3D pmu_sbi_setup_irqs(pmu, pdev);
> >>>          if (ret < 0) {
> >>>                  pr_info("Perf sampling/filtering is not supported as=
 sscof extension is not available\n");
> >>> --
> >>> 2.42.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>

