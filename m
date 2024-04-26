Return-Path: <linux-kernel+bounces-160506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FD58B3E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D7BB266BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051C15B974;
	Fri, 26 Apr 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScqyGOcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042D1DDF8;
	Fri, 26 Apr 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153089; cv=none; b=l4hyBDoIDqqWOaUeA8XA1Wd/6HE+b5NNH8lyFVgOOQyC5WU+ep7oO1bQO/lncndmvbTI1LVYd746nREGwK5BU4RxJLmYKjaveyRDv2iycOEttj7CoWeKPfeOC2cbGr7kzbIdlWp+tTDk9kPV/5H+y1adH913UlJ0UUOGgM0I2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153089; c=relaxed/simple;
	bh=oU1tYfYgDpdxfhx+6CCQsyq+5gOrTMC1OgJolal92e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glDAxjInH/zpnluCYe8FNWoPRXMiwnypXz3LE9ReX/8l7KxqX+FsvPqX9UhLhfpevZoFbk21Kmj7thMk9pKhpEw5SNOdQKKKUWydMyyEi8aW/fcVDjp6PS3qkA2sRLmyasB2xZ4HWXLzbCHwkF0BuHSEWE5cEumCQpVMxx32w7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScqyGOcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB58AC4AF07;
	Fri, 26 Apr 2024 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714153088;
	bh=oU1tYfYgDpdxfhx+6CCQsyq+5gOrTMC1OgJolal92e4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ScqyGOcZQeO0mQv8NQf9Yt7ZSVAdcAfx2KNwS6vqOGz28zWrUm/wTeEqt2iC+nPrG
	 kwPB637OJmjLx+SfQ5eG/+gUO/j7ECMx18MUuZRNAUKd4E/MsPUHsl+Ms66Wr4wk2Z
	 8Ky5cYQDlXq7Tw0EGXraNNhzkhcqRkSbyPlkujgLEmlN8jB25Tuz0Clh4kMR25xKkK
	 2WoaqFf9tQ7ixYkS16eHJlCgXo71SiYgm/jsKiid/AFOCn2iWztz04PcGIQ25f28i1
	 skQoDBvOp46DWpS4+UGzF6lzjLJqC/vrgAqVHpjKdsonqcLx15aMip3BmOlCjVjCv7
	 RLwoBuLjWOFHw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ac4470de3bso481096eaf.0;
        Fri, 26 Apr 2024 10:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgLeT/SdhZC2drBnsZAVMkYNIBQN8J1RBT0z0tV2CeVdYcVBEGlt606tCgUTneK9MQ2ZPVNoUc9P1wa8JOarR3d9mSjoJB3ANTEGQGCojSnjEijE96TS/fu9nLhp7rEFBjEGQXMDY=
X-Gm-Message-State: AOJu0YxY7s5clG6ke7UVSieg1ogeTGXfaT2Em3xmbqWXbl8hJYi//FlB
	hDOCLCqxVceU4Y8YznV85DGJLjfGWiBc/vlgDbl2ydKJdXU936fm2EZufxf0QJrUfqxQalFCHP5
	xtxB3NGzrSOuRVhN9IMAgYreZ8yo=
X-Google-Smtp-Source: AGHT+IHAFi/UsFgkmPDeflkAaVOV3pUloq6R10MSKx9Susw2khziD/O1W495CEudCqCu6pn4U1q79SyTvSgtdAO9XRw=
X-Received: by 2002:a4a:a882:0:b0:5aa:241a:7f4b with SMTP id
 q2-20020a4aa882000000b005aa241a7f4bmr4104406oom.1.1714153087944; Fri, 26 Apr
 2024 10:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714032153.git.perry.yuan@amd.com>
In-Reply-To: <cover.1714032153.git.perry.yuan@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 19:37:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iF_NUAMhTCaakUi_F+2CrRgiQMXmrVm00+W7vd+H=wjw@mail.gmail.com>
Message-ID: <CAJZ5v0iF_NUAMhTCaakUi_F+2CrRgiQMXmrVm00+W7vd+H=wjw@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, gautham.shenoy@amd.com, Borislav.Petkov@amd.com, 
	Ray.Huang@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	oleksandr@natalenko.name, Xiaojian.Du@amd.com, Li.Meng@amd.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 10:08=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wr=
ote:
>
> The patch series adds some fixes and enhancements to the AMD pstate
> driver.
>
> It enables CPPC v2 for certain processors in the family 17H, as
> requested by TR40 processor users who expect improved performance and low=
er system
> temperature.
>
> changes latency and delay values to be read from platform firmware
> firstly
> for more accurate timing.
>
> A new quirk is introduced for supporting amd-pstate on legacy processors =
which either lack CPPC capability,
> or only only have CPPC v2 capability
>
> Testing done with one APU system while cpb boost on:
>
> amd_pstate_lowest_nonlinear_freq:1701000
> amd_pstate_max_freq:3501000
> cpuinfo_max_freq:3501000
> cpuinfo_min_freq:400000
> scaling_cur_freq:3084836
> scaling_max_freq:3501000
> scaling_min_freq:400000
>
> analyzing CPU 6:
>   driver: amd-pstate-epp
>   CPUs which run at the same hardware frequency: 6
>   CPUs which need to have their frequency coordinated by software: 6
>   maximum transition latency:  Cannot determine or is not supported.
>   hardware limits: 400 MHz - 3.50 GHz
>   available cpufreq governors: performance powersave
>   current policy: frequency should be within 400 MHz and 3.50 GHz.
>                   The governor "powersave" may decide which speed to use
>                   within this range.
>   current CPU frequency: Unable to call hardware
>   current CPU frequency: 3.50 GHz (asserted by call to kernel)
>   boost state support:
>     Supported: yes
>     Active: yes
>     AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.50 GHz.
>     AMD PSTATE Nominal Performance: 204. Nominal Frequency: 2.80 GHz.
>     AMD PSTATE Lowest Non-linear Performance: 124. Lowest Non-linear Freq=
uency: 1.70 GHz.
>     AMD PSTATE Lowest Performance: 30. Lowest Frequency: 400 MHz.
>
>
> I would greatly appreciate any feedbacks.
> Thank you!
> Perry.
>
> Changes from v11:
>  * minmor change for patch 1 "perf" change to "performance"(Huang ray)
>  * rebased to lastest linux-pm/bleeding-edge branch
>
> Changes from v10:
>  * pick ack-by flags from huang ray for all patches.
>  * run testing on AMD Ryzen 5 7640U without regression issue.
>
> Changes from v9:
>  * pick review by flag from Meng Li
>  * pick test by flag from Ugwekar Dhananjay
>  * picl review by flag from Gautham R. Shenoy
>
> Changes from v8:
>  * add commit log for patch 1 and patch 2 (Rafael)
>  * add missing Perry signed-off-by for new patches #1,#2,#4 (Rafael)
>  * rebased to latest linux-pm/bleeding-edge
>
> Changes from v7:
>  * Gautham helped to invole some new improved patches into the patchset.
>  * Adds comments for cpudata->{min,max}_limit_{perf,freq}, variables [New=
 Patch].
>  * Clarifies that the units for cpudata->*_freq is in khz via comments [N=
ew Patch].
>  * Implements the unified computation of all cpudata->*_freq
>  * v7 Patch 2/6 was dropped which is not needed any more
>  * moved the quirk check to the amd_pstate_get_freq() function
>  * pick up RB flags from Gautham
>  * After the cleanup in patch 3, we don't need the helpers
>    amd_get_{min,max,nominal,lowest_nonlinear}_freq(). This
>    patch removes it [New Patch].
>  * testing done on APU system as well, no regression found.
>
> Changes from v6:
>  * add one new patch to initialize capabilities in
>    amd_pstate_init_perf which can avoid duplicate cppc capabilities read
>    the change has been tested on APU system.
>  * pick up RB flags from Gautham
>  * drop the patch 1/6 which has been merged by Rafael
>
> Changes from v5:
>  * rebased to linux-pm v6.8
>  * pick up RB flag from for patch 6(Mario)
>
> Changes from v4:
>  * improve the dmi matching rule with zen2 flag only
>
> Changes from v3:
>  * change quirk matching broken BIOS with family/model ID and Zen2
>    flag to fix the CPPC definition issue
>  * fix typo in quirk
>
> Changes from v2:
>  * change quirk matching to BIOS version and release (Mario)
>  * pick up RB flag from Mario
>
> Changes from v1:
>  * pick up the RB flags from Mario
>  * address review comment of patch #6 for amd_get_nominal_freq()
>  * rebased the series to linux-pm/bleeding-edge v6.8.0-rc2
>  * update debug log for patch #5 as Mario suggested.
>  * fix some typos and format problems
>  * tested on 7950X platform
>
>
> V1: https://lore.kernel.org/lkml/63c2b3d7-083a-4daa-ba40-629b3223a92d@mai=
lbox.org/
> V2: https://lore.kernel.org/all/cover.1706863981.git.perry.yuan@amd.com/
> v3: https://lore.kernel.org/lkml/cover.1707016927.git.perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/cover.1707193566.git.perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/cover.1707273526.git.perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/cover.1707363758.git.perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/cover.1710323410.git.perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/cover.1710754409.git.perry.yuan@amd.com/
> v9: https://lore.kernel.org/lkml/cover.1710836407.git.perry.yuan@amd.com/
> v10: https://lore.kernel.org/lkml/cover.1711335714.git.perry.yuan@amd.com=
/
> v11: https://lore.kernel.org/lkml/cover.1713858800.git.perry.yuan@amd.com=
/
>
>
> Gautham R. Shenoy (3):
>   cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
>   cpufreq: amd-pstate: Document the units for freq variables in
>     amd_cpudata
>   cpufreq: amd-pstate: Remove
>     amd_get_{min,max,nominal,lowest_nonlinear}_freq()
>
> Perry Yuan (5):
>   cpufreq: amd-pstate: Unify computation of
>     {max,min,nominal,lowest_nonlinear}_freq
>   cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
>   cpufreq: amd-pstate: get transition delay and latency value from ACPI
>     tables
>   cppc_acpi: print error message if CPPC is unsupported
>   cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities
>     missing
>
>  drivers/acpi/cppc_acpi.c     |   4 +-
>  drivers/cpufreq/amd-pstate.c | 257 +++++++++++++++++++++--------------
>  include/linux/amd-pstate.h   |  20 ++-
>  3 files changed, 174 insertions(+), 107 deletions(-)
>
> --

Whole series applied as 6.10 material, thanks!

