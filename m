Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A723D7D4D12
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjJXJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjJXJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:57:02 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B2F9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:56:59 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so1499953241.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698141418; x=1698746218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZmQw87wWu1ilebiZdLFiZTY4pr7HbiJ8vUC+a+GPRs=;
        b=Y1wxrMZy1k/4FBm8A2U476YZIHerlSRC/2lZEGR3TsdTro02PKRW9bEEBrI+OrX2jZ
         x2O8pPR63iXPR79TfbMTP+2C6IsLwpYjWJyYkwUFE0a5pK8cVU+mxATxae2dhXHSafQ2
         +HGVzVHt7HkKWb4QOZFVDb41tkfA+jSfeCwkM/G8OfAm3ACV/STR+eDTQE5z+P+DK82U
         fWSB24SRol9vRk9f3S8AAf//8zzDVOyOr3K5WrmyxLMsGNYoZ96/yZYxXahdbZmRrlX+
         6Q2ahxHTvVJxO3c9Ue4d/o4TOEP+iYl0cumWmsWUmKnrPTsaOHZiAZwBTkrddvfLXKYc
         nA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141418; x=1698746218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZmQw87wWu1ilebiZdLFiZTY4pr7HbiJ8vUC+a+GPRs=;
        b=LuSYQXCmwh70VzEKhuGQSMmya3kN9rjU7RuQsoCz5uXDJ5HdLlx1qihzief89xGXKI
         KRVzSLnNQcNROb0TCF5ziLh8g54aD/M0ku8hyKOZyQH2Nwi5pIjr0bTZt1jg3WIZq1tv
         2YMl3mGEVCB48CLCXsjROMWBQFwTJZgMqneQGM+zQbiGMYKU1vYsOnrhNQJg9iK/bPCJ
         1CS8uOLTyY7Qc6m44izN9jp2SJLhB7rRzBHLD8tMP66934w9+/3wPL/gCshNTyU+A18k
         qT+nA+Do7WVNgZK+VO1fEtUucYZMNs9uFkRu6e68bc479KWzyLF117gG8rp/9P9ZJGsu
         z7jg==
X-Gm-Message-State: AOJu0Yy8X+ezNI+dhmbaJ5EXI9Ohuwghh5qeNy/9hGSSlq2EyauQS5Af
        U9+r4cTxuzlBM8dfIg8QVQpCwzFXRlhvdY0zyZGQZA==
X-Google-Smtp-Source: AGHT+IF/FMkfyP/7/zLROy5Ws/WEeWc1OLNc41dw+XpTZWtkqgbB228Ev9XsffAxvviNM6m98X3y97EFL0UsiFArJ7o=
X-Received: by 2002:a67:ac48:0:b0:45a:67da:658 with SMTP id
 n8-20020a67ac48000000b0045a67da0658mr5359507vsh.33.1698141418696; Tue, 24 Oct
 2023 02:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-6-vincent.guittot@linaro.org> <CAJZ5v0hS7bdUv=-k4ut2Fw0LYfB7Hb1_rro7UOVTRq4=JLNchg@mail.gmail.com>
 <60497d6d-dfe3-4edc-9553-311fdd9c63d0@arm.com>
In-Reply-To: <60497d6d-dfe3-4edc-9553-311fdd9c63d0@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 24 Oct 2023 11:56:46 +0200
Message-ID: <CAKfTPtCogPYyfe2aoNQE4BLRM+++3ezdx-3NsVFFMBKnZNWfiw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] cpufreq/cppc: set the frequency used for computing
 the capacity
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 at 18:05, Pierre Gondois <pierre.gondois@arm.com> wrote=
:
>
> Hello Vincent,
>
> On 10/18/23 19:26, Rafael J. Wysocki wrote:
> > On Wed, Oct 18, 2023 at 6:25=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> Save the frequency associated to the performance that has been used wh=
en
> >> initializing the capacity of CPUs.
> >> Also, cppc cpufreq driver can register an artificial energy model. In =
such
> >> case, it needs the frequency for this compute capacity.
> >> We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them
> >> outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
> >>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > For the changes in drivers/acpi/cppc_acpi.c :
> >
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >
> >> ---
> >>   drivers/acpi/cppc_acpi.c       |  93 ++++++++++++++++++++++
> >>   drivers/base/arch_topology.c   |  15 +++-
> >>   drivers/cpufreq/cppc_cpufreq.c | 141 ++++++-------------------------=
--
> >>   include/acpi/cppc_acpi.h       |   2 +
> >>   4 files changed, 133 insertions(+), 118 deletions(-)
> >>
>
> [snip]
>
> >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology=
.c
> >> index 9a073c2d2086..2372ce791bb4 100644
> >> --- a/drivers/base/arch_topology.c
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -350,6 +350,7 @@ bool __init topology_parse_cpu_capacity(struct dev=
ice_node *cpu_node, int cpu)
> >>   void topology_init_cpu_capacity_cppc(void)
> >>   {
> >>          struct cppc_perf_caps perf_caps;
> >> +       u64 capacity, capacity_scale;
>
> I think capacity_scale should be initialized to 0 here,
> since it is used to find the max value of raw_capacity[cpu].

yes

>
> >>          int cpu;
> >>
> >>          if (likely(!acpi_cpc_valid()))
> >> @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
> >>                      (perf_caps.highest_perf >=3D perf_caps.nominal_pe=
rf) &&
> >>                      (perf_caps.highest_perf >=3D perf_caps.lowest_per=
f)) {
> >>                          raw_capacity[cpu] =3D perf_caps.highest_perf;
> >> +                       capacity_scale =3D max_t(u64, capacity_scale, =
raw_capacity[cpu]);
> >> +
> >> +                       per_cpu(capacity_ref_freq, cpu) =3D cppc_perf_=
to_khz(&perf_caps, raw_capacity[cpu]);
>
> I think capacity_ref_freq in in Hz, so the freq should be multiplied by 1=
000 .

yes, I forgot the *1000. I'm going to add * HZ_PER_KHZ

>
> With these two modifications, the patches worked well on a cppc-based pla=
tform.
>
> Sorry I forgot to detail what it was. It's a modified Juno with CPPC enab=
led. AMUs are not
> enabled, so the CPPC performance counters are not handled correctly and F=
IE cannot be enabled,
> but it is possible to change frequencies.
>
> The _CPC objects are setup as:
> little CPUs:
> - lowest_freq =3D 450 (MHz)
> - nominal_freq =3D 800 (MHz)
> - highest_perf =3D 383 * 1000
> - nominal_perf =3D 322 * 1000
> - lowest_perf =3D 181 * 1000
> - lowest_nonlinear_perf =3D 181 * 1000
>
> big CPUs:
> - lowest_freq =3D 600 (MHz)
> - nominal_freq =3D 1200 (MHz)
> - highest_perf =3D 1024 * 1000
> - nominal_perf =3D 833 * 1000
> - lowest_perf =3D 512 * 1000
> - lowest_nonlinear_perf =3D 512 * 1000
>
> As a remainder, available frequencies are:
> - little CPUs: 450, 800, 950 MHz
> - big CPUs: 600, 1000, 1200 Mhz
> So the platform is setup to have the last frequency as a boost frequency =
(for testing).
>
> ----
>
> Just to make a note of 2 potential side-issues for later (independent fro=
m these patches):
>
> - When testing with boosted/non-bossted frequencies, it didn't seem that =
cpu_overutilized()
>    was taking the maximum frequency into consideration. This might mean t=
hat when lowering the
>    maximum frequency of a policy, the maximum capacity of the CPUs of thi=
s policy is used
>    to detect over-utilization.
>    I would have thought that the over-utilization threshold would be lowe=
red at the same time.

No it's not, It will be part of a next step patchset. This patchset
aims to consolidate and use the same reference so we can then easily
propagate changes if needed

>
> - Similarly for EAS, the energy computation doesn't take into account the=
 maximum frequency
>    of the policy. This should mean that EAS is taking into consideration =
frequencies that
>    are not actually available.
>
>
> Regards,
> Pierre
