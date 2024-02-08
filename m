Return-Path: <linux-kernel+bounces-58207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAC984E2BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B46B25A73
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231B76C75;
	Thu,  8 Feb 2024 14:02:13 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F92B9D8;
	Thu,  8 Feb 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400932; cv=none; b=T4GeAhQS2Iok05kjHEXvbrtn4ftLLqQtins+TxjWVYS4PECc+OgUpiPnqEOK7xJYdYt5zMqCDGGzhNQUXumw27GYIK3TwFUIv39Oq0H0Zz4Vuie2K+T/EdER+2QY9z+vfMbM2VmZ1iuL+t7Bl4w5XaCUe/f0byQ6AtElVl/DG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400932; c=relaxed/simple;
	bh=PIWqxDKKpXjwbRPVte06VEXadehQLcrL52E+ex+2kGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzb+Mtj7W2QVq0uQ7w5UyYnKvrqsbQFe1LinsAvtmcKeHSaOj0rFbeU4M9qmjqPp558SG+i5nfe3MZXmqizYaKmLqc7b6bIAnYr6t8J8H5AMxDFurmfKygpiHSmY49m5JWF/fYEPL3V08mat28x8QkJFMRjz/01Tr7xdkg2ghvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59cbf204d52so99859eaf.1;
        Thu, 08 Feb 2024 06:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400930; x=1708005730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC0AhVwncxrKUZLFd50VvucAEc4mu/rIDY9WObgNg1U=;
        b=Xf8bSDUtYTKpX5q18b2vs8GUb17xbLwYzXU5dkOIRkDcdgJPIQ2ktB8C2/enjkC3EA
         rxUVYE94n0k/5Ie/UAQbf/VzgmSMt1a53mzHsMqKtSRuPtnzVEO/tULxQhgXmDPxB8zw
         A0su/SvaIXXoAo6FGn9Vn1Ljz/JAf/msfI3xMUD1WZ0sweGAV9Mgu4ulFldLARFML6ql
         09RmxOH32zB7kIFSnxIu6FLNydgoLBy2/+lQ2h+3yjrQfJ1DplzBNXxQv3n4PfnXPAcX
         JDOh+onP9mYGVu+aEgba0jfxG8ToSovFDKCiaQpTC0lEFXWMmpnggyXMR0LFYJ6hUTXL
         RHkg==
X-Gm-Message-State: AOJu0YzifRfC4NEeNlFUwVaiVXTjrnDOB5M9S/SnO9UvV5lveap3XihD
	Qy5FM3AOCmjlKXVCrfDEH2e9KXVUsjkGLcJ7/yw2z7pmvoGcMEmH/LIA7OH4BWW8zylAoIHvHkN
	wOmQ+DwDmj0Ao+Uj7IRS5krV8Y5o=
X-Google-Smtp-Source: AGHT+IEvU3PJRu3bEfG9dWUAbvEXbKLM++hKMPdA9Gs1FdV/ff3NDVOAg2PAai8b57JhPeSvjzrcx6Y1x2ZV6lktQWc=
X-Received: by 2002:a4a:ce99:0:b0:59c:d8cd:ecee with SMTP id
 f25-20020a4ace99000000b0059cd8cdeceemr9398313oos.1.1707400929652; Thu, 08 Feb
 2024 06:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208115557.1273962-1-lukasz.luba@arm.com>
In-Reply-To: <20240208115557.1273962-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Feb 2024 15:01:58 +0100
Message-ID: <CAJZ5v0hxubw0VvzTikEwMeS0JQEx=YTqdbhOLhu+Q_n6u4i5gQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/23] Introduce runtime modifiable Energy Model
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com, xuewen.yan94@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:56=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi all,
>
> This patch set adds a new feature which allows to modify Energy Model (EM=
)
> power values at runtime. It will allow to better reflect power model of
> a recent SoCs and silicon. Different characteristics of the power usage
> can be leveraged and thus better decisions made during task placement in =
EAS.
>
> It also optimizes the EAS code hot path, by removing 2 division and 1
> multiplication operations in the em_cpu_energy(). Speed-up results:
> the em_cpu_energy() should run faster on the Big CPU by 1.43x and on the
> Little CPU by 1.69x (mainline board RockPi 4B).
>
> This patch set is part of feature set known as Dynamic Energy Model. It h=
as been
> presented and discussed recently at OSPM2023 [3].
>
>
> The concepts:
> 1. The CPU power usage can vary due to the workload that it's running or =
due
> to the temperature of the SoC. The same workload can use more power when =
the
> temperature of the silicon has increased (e.g. due to hot GPU or ISP).
> In such situation the EM can be adjusted and reflect the fact of increase=
d
> power usage. That power increase is due to static power
> (sometimes called simply: leakage). The CPUs in recent SoCs are different=
.
> We have heterogeneous SoCs with 3 (or even 4) different microarchitecture=
s.
> They are also built differently with High Performance (HP) cells or
> Low Power (LP) cells. They are affected by the temperature increase
> differently: HP cells have bigger leakage. The SW model can leverage that
> knowledge.
>
> 2. It is also possible to change the EM to better reflect the currently
> running workload. Usually the EM is derived from some average power value=
s
> taken from experiments with benchmark (e.g. Dhrystone). The model derived
> from such scenario might not represent properly the workloads usually run=
ning
> on the device. Therefore, runtime modification of the EM allows to switch=
 to
> a different model, when there is a need.
>
> 3. The EM can be adjusted after boot, when all the modules are loaded and
> more information about the SoC is available e.g. chip binning. This would=
 help
> to better reflect the silicon characteristics. Thus, this EM modification
> API allows it now. It wasn't possible in the past and the EM had to be
> 'set in stone'.
>
> Example of such runtime modification after boot can be found in a follow-=
up
> patch set. It adds the OPP API and usage in Exynos5 SoC driver after the
> voltage values has been adjusted and power changes [5].
>
> More detailed explanation and background can be found in presentations
> during LPC2022 [1][2] or in the documentation patches.
>
> Some test results:
> The EM can be updated to fit better the workload type. In the case below =
the EM
> has been updated for the Jankbench test on Pixel6 (running v5.18 w/ mainl=
ine backports
> for the scheduler bits). The Jankbench was run 10 times for those two con=
figurations,
> to get more reliable data.
>
> 1. Janky frames percentage
> +--------+-----------------+---------------------+-------+-----------+
> | metric |    variable     |       kernel        | value | perc_diff |
> +--------+-----------------+---------------------+-------+-----------+
> | gmean  | jank_percentage | EM_default          |  2.0  |   0.0%    |
> | gmean  | jank_percentage | EM_modified_runtime |  1.3  |  -35.33%  |
> +--------+-----------------+---------------------+-------+-----------+
>
> 2. Avg frame render time duration
> +--------+---------------------+---------------------+-------+-----------=
+
> | metric |      variable       |       kernel        | value | perc_diff =
|
> +--------+---------------------+---------------------+-------+-----------=
+
> | gmean  | mean_frame_duration | EM_default          | 10.5  |   0.0%    =
|
> | gmean  | mean_frame_duration | EM_modified_runtime |  9.6  |  -8.52%   =
|
> +--------+---------------------+---------------------+-------+-----------=
+
>
> 3. Max frame render time duration
> +--------+--------------------+---------------------+-------+-----------+
> | metric |      variable      |       kernel        | value | perc_diff |
> +--------+--------------------+---------------------+-------+-----------+
> | gmean  | max_frame_duration | EM_default          | 251.6 |   0.0%    |
> | gmean  | max_frame_duration | EM_modified_runtime | 115.5 |  -54.09%  |
> +--------+--------------------+---------------------+-------+-----------+
>
> 4. OS overutilized state percentage (when EAS is not working)
> +--------------+---------------------+------+------------+------------+
> |    metric    |       wa_path       | time | total_time | percentage |
> +--------------+---------------------+------+------------+------------+
> | overutilized | EM_default          | 1.65 |   253.38   |    0.65    |
> | overutilized | EM_modified_runtime | 1.4  |   277.5    |    0.51    |
> +--------------+---------------------+------+------------+------------+
>
> 5. All CPUs (Little+Mid+Big) power values in mW
> +------------+--------+---------------------+-------+-----------+
> |  channel   | metric |       kernel        | value | perc_diff |
> +------------+--------+---------------------+-------+-----------+
> |    CPU     | gmean  | EM_default          | 142.1 |   0.0%    |
> |    CPU     | gmean  | EM_modified_runtime | 131.8 |  -7.27%   |
> +------------+--------+---------------------+-------+-----------+
>
> The time cost to update the EM decreased in this v5 vs v4:
> big: 5us vs 2us -> 2.6x faster
> mid: 9us vs 3us -> 3x faster
> little: 16us vs 16us -> no change
>
> We still have to update the inefficiency in the cpufreq framework, thus
> a bit of overhead will be there.
>
> These series is based on linux next tree, tag 'v6.8-rc3'.
>
> Changelog:
> v8:
> - addressed cosmetic comments (Hongyan, Dietmar)
> - collected all reviewed-by and tested-by tags (Hongyan, Dietmar)
> - re-based on top of v6.8-rc3 (Rafael)
> v7 [6]:
> - dropped em_table_get/put() (Rafael)
> - renamed memory function to em_table_alloc/free() (Rafael)
> - use explicit rcu_read_lock/unlock() instead of wrappers and aligned
>   frameworks & drivers using EM (Rafael)
> - adjusted documentation to the new functions
> - fixed doxygen comments (Rafael)
> - renamed 'refcount' to 'kref' (Rafael)
> - changed patch headers according to comments (Rafael)
> - rebased on 'next-20240112' to get Ingo's revert affecting energy_model.=
h
> v6 can be found here [4]
>
> Regards,
> Lukasz Luba
>
> [1] https://lpc.events/event/16/contributions/1341/attachments/955/1873/D=
ynamic_Energy_Model_to_handle_leakage_power.pdf
> [2] https://lpc.events/event/16/contributions/1194/attachments/1114/2139/=
LPC2022_Energy_model_accuracy.pdf
> [3] https://www.youtube.com/watch?v=3D2C-5uikSbtM&list=3DPL0fKordpLTjKsBO=
UcZqnzlHShri4YBL1H
> [4] https://lore.kernel.org/lkml/20240104171553.2080674-1-lukasz.luba@arm=
com/
> [5] https://lore.kernel.org/lkml/20231220110339.1065505-1-lukasz.luba@arm=
com/
> [6] https://lore.kernel.org/lkml/20240117095714.1524808-1-lukasz.luba@arm=
com/
>
> Lukasz Luba (23):
>   PM: EM: Add missing newline for the message log
>   PM: EM: Extend em_cpufreq_update_efficiencies() argument list
>   PM: EM: Find first CPU active while updating OPP efficiency
>   PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
>   PM: EM: Introduce em_compute_costs()
>   PM: EM: Check if the get_cost() callback is present in
>     em_compute_costs()
>   PM: EM: Split the allocation and initialization of the EM table
>   PM: EM: Introduce runtime modifiable table
>   PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
>   PM: EM: Add functions for memory allocations for new EM tables
>   PM: EM: Introduce em_dev_update_perf_domain() for EM updates
>   PM: EM: Add em_perf_state_from_pd() to get performance states table
>   PM: EM: Add performance field to struct em_perf_state and optimize
>   PM: EM: Support late CPUs booting and capacity adjustment
>   PM: EM: Optimize em_cpu_energy() and remove division
>   powercap/dtpm_cpu: Use new Energy Model interface to get table
>   powercap/dtpm_devfreq: Use new Energy Model interface to get table
>   drivers/thermal/cpufreq_cooling: Use new Energy Model interface
>   drivers/thermal/devfreq_cooling: Use new Energy Model interface
>   PM: EM: Change debugfs configuration to use runtime EM table data
>   PM: EM: Remove old table
>   PM: EM: Add em_dev_compute_costs()
>   Documentation: EM: Update with runtime modification design
>
>  Documentation/power/energy-model.rst | 183 ++++++++++-
>  drivers/powercap/dtpm_cpu.c          |  39 ++-
>  drivers/powercap/dtpm_devfreq.c      |  34 +-
>  drivers/thermal/cpufreq_cooling.c    |  45 ++-
>  drivers/thermal/devfreq_cooling.c    |  49 ++-
>  include/linux/energy_model.h         | 166 ++++++----
>  kernel/power/energy_model.c          | 474 +++++++++++++++++++++++----
>  7 files changed, 821 insertions(+), 169 deletions(-)
>
> --

All applied as 6.9 material, thanks!

