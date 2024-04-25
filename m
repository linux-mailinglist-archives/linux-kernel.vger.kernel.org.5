Return-Path: <linux-kernel+bounces-158074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B48B1B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F97C1F21F92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920645A0E6;
	Thu, 25 Apr 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JROX5upS"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734C26293
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027005; cv=none; b=Z7tle4EMCE1BRSasssOU9ZsV+3Hv0Q3ajjCbW8qqMJ+efiH+sr3zQfl4na5yXsTtKNJ3vgjwNxPv2V5rc7t6CAsjntP8ab2d5LSMjd6bcBiNusLYlppSKqvJ3NDUw95K2hJo/uQ6jYosJz1cqdTCppzakRG//z7hhyLrzgOOpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027005; c=relaxed/simple;
	bh=fXX7PNIq+eqUBp26vAao/Ry5cR8n5yzz3VEhOgtDbKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoEU9a00ylRBhgtLmmIueGdV/UTUyl2qQPnkTfizx/bWWOC+LTvzcYTQyQAVoNFIRqjSAUCCR7mN5BuxRWE9sPsLOMDG0PrpZg52juwJmsYGYsLoYK6jjEPq4T5HsUeLAgVx+ey3xXNoiFYzmu9xNp0fqDjc36EjLSlm+IPo47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JROX5upS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d3907ff128so517004a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714027003; x=1714631803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8/CVMgQfWxFUq1jS+amCjYb3SFmeSwZaVXuqq9MhTDg=;
        b=JROX5upSshUdovN1xafooW9z/xP+lzEbfTYbCvTGwiB/LjbtqTnrvAunR1JnQX6z5Q
         VD0nSNiik1N/YCYMJIOd17mT+tfYSDvPUPWgGJ8zC1reGFm5F7udn0dPcSC8dPrUMfJa
         qhd/hJ0yLiJpKLCp2ME1c2lFLlZ93Y5Ab4LhNiTKV7v2CpPDrYVrGWQx6Hu0VVg684Xh
         bjhC75HPA95MUPkHACB3glYvKekJxrHmilooCqmmp1AV9D/VxecErEM9t5IVWfDvn3K3
         UHbNNhe1aBAzO/3kLFavVbVSani92VWoetMQ9GXW1u6WgkwY+b+3morsHztbJolhB19o
         v2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714027003; x=1714631803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/CVMgQfWxFUq1jS+amCjYb3SFmeSwZaVXuqq9MhTDg=;
        b=u/i9bV7fd7TFfqkJccPDW7OHIpb0CMQTAx821+Rkl5ncujd5PaWIUkzj/MR2i9jQiN
         X7c5X6wvjWN3PrLLII2lRAcZSNh0R8MrM1Kn2sgAFhOS51k87cVJ8fM+BrVwNJZFmHD9
         /Hax34FIdN7NzVOSpP3YNr3+RJ63AowvrwA3S64Wmih+4Aj59KUSKUDXrowmw+dHrOnu
         dkAv0LOeMFGaHXH5UIWqGnwNdQPar9Aovs43ByHKKzll61od08fCp4Ja83yMeYhXaXM5
         VF88YY01My0KsZZPIAc0MjL5YaRMVeSw9QkJ17GQhPhtuPvmkNE9bcvymZiV5T7qkmLI
         Q7vA==
X-Forwarded-Encrypted: i=1; AJvYcCW+k789K/EcnoFhv77ylC6ibLilM6OOdAJ/XlRIOn1HZCgVy0zPEdlwv+g5bQMNlVPB8559CYhT6xEMPHfgc8rqKzVnVPhzYH3k89fD
X-Gm-Message-State: AOJu0YyeRZLi2McecHN3ndQIR9XHu6WmPgJMCvjBkWQGKSoSwR0IpyBw
	Nju0j32ppm97/1yp1dII0RRx5z5rMeMiCtuhPqGbGDzxfzaByAF09Qr/DDRScnqXAUjCiyQKwWk
	353FzKQpOx4+FOsgczkJrUVmAimO3ZMUugki6dw==
X-Google-Smtp-Source: AGHT+IHyqZEcfsfPUmwPYTICqPTYsja7jffEAzz+Mo8AnWurcRqCd7FU3lPpsWSsWQ9HOzxVDXNmlkUL/ok4odKJ8/s=
X-Received: by 2002:a17:90a:fa06:b0:2ac:d9f:de9b with SMTP id
 cm6-20020a17090afa0600b002ac0d9fde9bmr5162954pjb.45.1714027003235; Wed, 24
 Apr 2024 23:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404250740.VhQQoD7N-lkp@intel.com>
In-Reply-To: <202404250740.VhQQoD7N-lkp@intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 25 Apr 2024 08:36:31 +0200
Message-ID: <CAKfTPtBmhCFWmeb7oaM3t3WMb0_RUwY32gzgVzyruYaP9VpfUA@mail.gmail.com>
Subject: Re: [tip:sched/core 26/27] drivers/base/arch_topology.c:204:17:
 sparse: sparse: incorrect type in initializer (different address spaces)
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 25 Apr 2024 at 01:22, kernel test robot <lkp@intel.com> wrote:
>
> Hi Vincent,
>
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   97450eb909658573dcacc1063b06d3d08642c0c1
> commit: d4dbc991714eefcbd8d54a3204bd77a0a52bd32d [26/27] sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()

I'm going to look at this more deeply but this patch only rename
"thermal_pressure" by "hw_pressure" so unless I miss a renaming, this
should not trigger anything new.

> config: arm64-randconfig-r132-20240425 (https://download.01.org/0day-ci/archive/20240425/202404250740.VhQQoD7N-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240425/202404250740.VhQQoD7N-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404250740.VhQQoD7N-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
>    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
>    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
>    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
>    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
>    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
>    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
>    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
>
> vim +204 drivers/base/arch_topology.c
>
>    164
>    165  /**
>    166   * topology_update_hw_pressure() - Update HW pressure for CPUs
>    167   * @cpus        : The related CPUs for which capacity has been reduced
>    168   * @capped_freq : The maximum allowed frequency that CPUs can run at
>    169   *
>    170   * Update the value of HW pressure for all @cpus in the mask. The
>    171   * cpumask should include all (online+offline) affected CPUs, to avoid
>    172   * operating on stale data when hot-plug is used for some CPUs. The
>    173   * @capped_freq reflects the currently allowed max CPUs frequency due to
>    174   * HW capping. It might be also a boost frequency value, which is bigger
>    175   * than the internal 'capacity_freq_ref' max frequency. In such case the
>    176   * pressure value should simply be removed, since this is an indication that
>    177   * there is no HW throttling. The @capped_freq must be provided in kHz.
>    178   */
>    179  void topology_update_hw_pressure(const struct cpumask *cpus,
>    180                                        unsigned long capped_freq)
>    181  {
>    182          unsigned long max_capacity, capacity, hw_pressure;
>    183          u32 max_freq;
>    184          int cpu;
>    185
>    186          cpu = cpumask_first(cpus);
>    187          max_capacity = arch_scale_cpu_capacity(cpu);
>    188          max_freq = arch_scale_freq_ref(cpu);
>    189
>    190          /*
>    191           * Handle properly the boost frequencies, which should simply clean
>    192           * the HW pressure value.
>    193           */
>    194          if (max_freq <= capped_freq)
>    195                  capacity = max_capacity;
>    196          else
>    197                  capacity = mult_frac(max_capacity, capped_freq, max_freq);
>    198
>    199          hw_pressure = max_capacity - capacity;
>    200
>    201          trace_hw_pressure_update(cpu, hw_pressure);
>    202
>    203          for_each_cpu(cpu, cpus)
>  > 204                  WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
>    205  }
>    206  EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
>    207
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

