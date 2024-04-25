Return-Path: <linux-kernel+bounces-158432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C55E8B2007
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B00B210F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF684FB3;
	Thu, 25 Apr 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqgLHzy3"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469C200BF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043653; cv=none; b=ILrmneL0xvSKKhcKcnQjDODRUFKQZZvQf8OK6W4Y6/K1QsYthLWFOXYF5bawbrM34zQhQdfJ4bwIwH0INlQG7FqYxZzD6BRrskaXIwv7Vm9Acgl6o9/xcROs+JOfMN0Ce8c1AXcErsjgyVBy85EY//x1vn0NM9NfFnmrfy/khUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043653; c=relaxed/simple;
	bh=kTOzGcQ5aQEn7UrM3I498Fj5MNDc/QUMR/VfveDFqhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Msm+dAXHopL+i1PgULvnr0jPRbzULSwoApSKjKmgYCUXLyXY7wKzxFDKXlITmyYsoBRgC6N4UTqMm05L4oAjX2rFX0ABuBTvdk6AoIUxR2gZlik4mkyPF2aeLU6QYYT1Pb44zRlD5/T5B0FTM/ZAooX+WB1E+IOuls5U8AbvzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqgLHzy3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ac1674d890so792870a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714043649; x=1714648449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiX9sIJ5oSEZCY3qAk0BfXb+wEMv1W08zEvS0llOwRo=;
        b=RqgLHzy3RbInj/SOhQtcGXzaZDsN7LqDVN+qEgwzJaAj2mUIdhnGh4pYXQ+6pZ05gt
         AGkPa3Ssmtn93JY0i/EbPr33t9YRbF96QZwwL4sIni8v9M7pngscs0omaNyRDY4BWbe7
         B8ylSpVbY77sj9NTmn0SrZIjYEK2xWrUo8HDTlJ16MhTB01/x4jPz16qXO47iljtqaY8
         R6SQUFWTYqBjpAIEfrbFTgwdf6EdAecFU0JOxtsmM6xpdyUQUmPSzR9tYlgAktGiOZjV
         tqj1pwXiwInHEQrCkp5aA3smVimN9Qj5TAjILzC4dJLDCxCGLhdqEpxYt3qzylq1SLsY
         +6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714043649; x=1714648449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiX9sIJ5oSEZCY3qAk0BfXb+wEMv1W08zEvS0llOwRo=;
        b=KjK/Xq74qF8EBxGTHmEHI+B7jyFTfQsYhoq5IVaHPu4tm8CKKPiFeXhDBInIvs5b+B
         GOhql1BpmuCBk+E5QD8s4qcVcwvK8rwAKFtXi3cF/R8dGInzI+CA6ZqJ4W5AT72od8RP
         JPk4XCgdw5Y5afCAkd/gBoMPnmWgFLidB9doPRzT0+rC6meZJwVQMF9whF3r6sbOWW8y
         RzvPP76S8wO9a129anM7UxlRrBkBaf91cMxTJRaxGOut63HQTCNMlpyqLZgSpbwkLq7c
         O2W06SXjFftfjYs+fslmKquTZEZiKhuRIDyGwC7BGmmYYVv3uwVB41nb/ebanQMkz27t
         jeRw==
X-Forwarded-Encrypted: i=1; AJvYcCWGCoUFrmj1rXG2PU7fLJ/50Xz6N2xbCcxqk1wI2L4b00M/+oKKmESBaBo5WcAssD5jC/3ZFfj6zwmZS5oNvX7XaGbdF3Y1kS0Ce3qr
X-Gm-Message-State: AOJu0Yw6uQrpEc+zrE04lXiE3GW0jzjASxHQwj5o3luB24a6swsBidl4
	zD3dzOKHug29GJjlYmn90QdhZdPTYSretV/iLvRvNxUySfSebQ5CvrK7pSczZeEBUXfT+lGstTa
	S6204ocJTEYYd06UDZTI0Sbz9l1LbR6NvjNhaow==
X-Google-Smtp-Source: AGHT+IGHzu3G8yxQ/p0gaXugnk9sL7Q64CgkJgXhRT1vcq50gLYObcdKyQYNwCmp/Ac0GVHu0oU0kDhVwQiwEXkaGuQ=
X-Received: by 2002:a17:90a:7e8d:b0:2af:2dce:707c with SMTP id
 j13-20020a17090a7e8d00b002af2dce707cmr5138352pjl.35.1714043649477; Thu, 25
 Apr 2024 04:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404250740.VhQQoD7N-lkp@intel.com> <CAKfTPtBmhCFWmeb7oaM3t3WMb0_RUwY32gzgVzyruYaP9VpfUA@mail.gmail.com>
 <Zio1gGgpl0FJ4qPg@yujie-X299>
In-Reply-To: <Zio1gGgpl0FJ4qPg@yujie-X299>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 25 Apr 2024 13:13:57 +0200
Message-ID: <CAKfTPtB6vnf+KU5CyPaTZS+kvCeLjUGH9RqNrOUM7epbnOWzew@mail.gmail.com>
Subject: Re: [tip:sched/core 26/27] drivers/base/arch_topology.c:204:17:
 sparse: sparse: incorrect type in initializer (different address spaces)
To: Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Qais Yousef <qyousef@layalina.io>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Yujie,

On Thu, 25 Apr 2024 at 12:57, Yujie Liu <yujie.liu@intel.com> wrote:
>
> Hi Vincent,
>
> On Thu, Apr 25, 2024 at 08:36:31AM +0200, Vincent Guittot wrote:
> > Hi,
> >
> > On Thu, 25 Apr 2024 at 01:22, kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Vincent,
> > >
> > > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> > > head:   97450eb909658573dcacc1063b06d3d08642c0c1
> > > commit: d4dbc991714eefcbd8d54a3204bd77a0a52bd32d [26/27] sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()
> >
> > I'm going to look at this more deeply but this patch only rename
> > "thermal_pressure" by "hw_pressure" so unless I miss a renaming, this
> > should not trigger anything new.
>
> Before renaming, there is a global "thermal_pressure", and a local
> "th_pressure" inside topology_update_thermal_pressure function. They
> live together peacefully since they have different names.
>
> DEFINE_PER_CPU(unsigned long, thermal_pressure);
>                               ^____
>
> void topology_update_thermal_pressure(const struct cpumask *cpus,
>                                       unsigned long capped_freq)
> {
>         unsigned long max_capacity, capacity, th_pressure;
>                                               ^____
> ...
>         for_each_cpu(cpu, cpus)
>                 WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
>                                    ^____                   ^____
> }
>
> After renaming, the global and local variables are both given the same
> name "hw_pressure", so the local one shadows the global one, causing
> this sparse warning.
>
> DEFINE_PER_CPU(unsigned long, hw_pressure);
>                               ^___
>
> void topology_update_hw_pressure(const struct cpumask *cpus,
>                                       unsigned long capped_freq)
> {
>         unsigned long max_capacity, capacity, hw_pressure;
>                                               ^___
> ...
>         for_each_cpu(cpu, cpus)
>                 WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
>                                    ^____              ^____
> }
>
>
> We can give them different names as before to fix this warning:

Yes, that's what I noticed as well. I sent the fix here:
https://lore.kernel.org/lkml/20240425073709.379016-1-vincent.guittot@linaro.org/

>
> ---------------------------------------------------------------
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 0248912ff6875..c66d070207a0e 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -179,7 +179,7 @@ DEFINE_PER_CPU(unsigned long, hw_pressure);
>  void topology_update_hw_pressure(const struct cpumask *cpus,
>                                       unsigned long capped_freq)
>  {
> -       unsigned long max_capacity, capacity, hw_pressure;
> +       unsigned long max_capacity, capacity, pressure;
>         u32 max_freq;
>         int cpu;
>
> @@ -196,12 +196,12 @@ void topology_update_hw_pressure(const struct cpumask *cpus,
>         else
>                 capacity = mult_frac(max_capacity, capped_freq, max_freq);
>
> -       hw_pressure = max_capacity - capacity;
> +       pressure = max_capacity - capacity;
>
> -       trace_hw_pressure_update(cpu, hw_pressure);
> +       trace_hw_pressure_update(cpu, pressure);
>
>         for_each_cpu(cpu, cpus)
> -               WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
> +               WRITE_ONCE(per_cpu(hw_pressure, cpu), pressure);
>  }
>  EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
>
> --
>
> Thanks,
> Yujie
>
> > > config: arm64-randconfig-r132-20240425 (https://download.01.org/0day-ci/archive/20240425/202404250740.VhQQoD7N-lkp@intel.com/config)
> > > compiler: aarch64-linux-gcc (GCC) 13.2.0
> > > reproduce: (https://download.01.org/0day-ci/archive/20240425/202404250740.VhQQoD7N-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202404250740.VhQQoD7N-lkp@intel.com/
> > >
> > > sparse warnings: (new ones prefixed by >>)
> > > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> > >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> > >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> > >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> > >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> > >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> > >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> > >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> > >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> > >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> > >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> > >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> > >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> > >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> > >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > >
> > > vim +204 drivers/base/arch_topology.c
> > >
> > >    164
> > >    165  /**
> > >    166   * topology_update_hw_pressure() - Update HW pressure for CPUs
> > >    167   * @cpus        : The related CPUs for which capacity has been reduced
> > >    168   * @capped_freq : The maximum allowed frequency that CPUs can run at
> > >    169   *
> > >    170   * Update the value of HW pressure for all @cpus in the mask. The
> > >    171   * cpumask should include all (online+offline) affected CPUs, to avoid
> > >    172   * operating on stale data when hot-plug is used for some CPUs. The
> > >    173   * @capped_freq reflects the currently allowed max CPUs frequency due to
> > >    174   * HW capping. It might be also a boost frequency value, which is bigger
> > >    175   * than the internal 'capacity_freq_ref' max frequency. In such case the
> > >    176   * pressure value should simply be removed, since this is an indication that
> > >    177   * there is no HW throttling. The @capped_freq must be provided in kHz.
> > >    178   */
> > >    179  void topology_update_hw_pressure(const struct cpumask *cpus,
> > >    180                                        unsigned long capped_freq)
> > >    181  {
> > >    182          unsigned long max_capacity, capacity, hw_pressure;
> > >    183          u32 max_freq;
> > >    184          int cpu;
> > >    185
> > >    186          cpu = cpumask_first(cpus);
> > >    187          max_capacity = arch_scale_cpu_capacity(cpu);
> > >    188          max_freq = arch_scale_freq_ref(cpu);
> > >    189
> > >    190          /*
> > >    191           * Handle properly the boost frequencies, which should simply clean
> > >    192           * the HW pressure value.
> > >    193           */
> > >    194          if (max_freq <= capped_freq)
> > >    195                  capacity = max_capacity;
> > >    196          else
> > >    197                  capacity = mult_frac(max_capacity, capped_freq, max_freq);
> > >    198
> > >    199          hw_pressure = max_capacity - capacity;
> > >    200
> > >    201          trace_hw_pressure_update(cpu, hw_pressure);
> > >    202
> > >    203          for_each_cpu(cpu, cpus)
> > >  > 204                  WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
> > >    205  }
> > >    206  EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
> > >    207
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> >

