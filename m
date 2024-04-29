Return-Path: <linux-kernel+bounces-162722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A341F8B5FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B1828294C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA0127E2D;
	Mon, 29 Apr 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrBYSvx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A08626A;
	Mon, 29 Apr 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410341; cv=none; b=kt58iljqlHcttPWtTTLw2K4ZGcU83VlRXvJRXhb39Q6UEF3FxeA7I2w6WveEwUYRxb/E4X3MAc+8sY7Z/r0UZrwQzZ/Mqc5/mLWDcRcTUPEgutYDn1ogw3SbpSegn9Sm+SkqiXJOY5s40+Yubri3FAVIQ49mL+2JNKvGgWaDy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410341; c=relaxed/simple;
	bh=IPJECLU9geyIAPxkpdaOuQiLCc7eWA8wXmou6E2kg98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvmLqmY7eqbnEWH6UcwsdPfzm0xs/bhvdrLGi33pQQl2I+SZmswkCM2FdhWbGvujV5zZO5LPEsY5M3hPBpsJJxmFV6rEpvrXjA2Q4+wb8ScliCBQ5jCIhah2TrREnnBWUdazr6oB+rufCzUrUjZKuYfyYgdIg2+VkQC0IyxYafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrBYSvx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B898DC113CD;
	Mon, 29 Apr 2024 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714410340;
	bh=IPJECLU9geyIAPxkpdaOuQiLCc7eWA8wXmou6E2kg98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HrBYSvx5elPB5n5aXNHoHGEsk4lw9qbg714s1g5/b27QWCqupr0Fn98Gc8WBmzqHM
	 cioioBH5VY4CL0JtiguToBZxMYADXeCaRHDQnw2NnSkzzAAibkVovkYLfo9nFC29L9
	 oBKhrk/bnb4kXSvfcD3tUBTzltmM4NJUtoyZwYE8FXJiZwCyBP3X9O3yj8foIpzs6h
	 ZWOyvQyf4kaNES49sUswc6iJF/R0s2RQb6vofUM+J27pvqpqUuPxlUHRcI5vMti9HN
	 m8DZLbT7zkbLlQC/UBpQDUR6nZESWy210+3E3Zgl7BpKdnRPDyAf7OlUio48K4HE9v
	 pumzRlPcD5mhg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5afbeaa1ea5so54544eaf.1;
        Mon, 29 Apr 2024 10:05:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxKNdVUcC9+tk/7kvgRhE+GF3wcrTmyDomucDSRWtfsMHc+6doy1Oj9I4l8Q+eHmnHNvVtwz9r+oGkDJXQoKXkwJnuODUfUTtqXvf2fdxEEHSuRrFH50altXJ1IY/KykWrZt8b/Us=
X-Gm-Message-State: AOJu0YyKYZEuDRmFe3KXvLdb7GsBWuZMIEJ4G1lFpvwwtBeMtrAXldqF
	SPd7iRxjaNvhg5k/Bg1ek2Ov9fw3p0djfYmaLaAInBoJP8asCSMY045rAV4lbSWTl+o+c36gnZp
	8EK7Tj9ozMJd+BiYqxscIcgH/S14=
X-Google-Smtp-Source: AGHT+IFkBwNLZnMVhENJSo7yzkOUNf+yPEW63QiH/UGO10tZuxquRULayPHNaFN/AaPL/xFyo859GnYXQaenrLm+rCw=
X-Received: by 2002:a05:6870:d690:b0:22e:7cc0:ebd5 with SMTP id
 z16-20020a056870d69000b0022e7cc0ebd5mr11500038oap.5.1714410340096; Mon, 29
 Apr 2024 10:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714032153.git.perry.yuan@amd.com> <CAJZ5v0iF_NUAMhTCaakUi_F+2CrRgiQMXmrVm00+W7vd+H=wjw@mail.gmail.com>
 <CYYPR12MB8655B901D5176249F0C67FF99C1B2@CYYPR12MB8655.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB8655B901D5176249F0C67FF99C1B2@CYYPR12MB8655.namprd12.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Apr 2024 19:05:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hfiOkoj45QOO70Dqq18JYgNhxza_VCx5YDXfwVnfmcwA@mail.gmail.com>
Message-ID: <CAJZ5v0hfiOkoj45QOO70Dqq18JYgNhxza_VCx5YDXfwVnfmcwA@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, 
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, 
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, 
	"Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, 
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, 
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 4:56=E2=80=AFAM Yuan, Perry <Perry.Yuan@amd.com> wr=
ote:
>
> [AMD Official Use Only - General]
>
> Hi Rafael,
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Saturday, April 27, 2024 1:38 AM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy, Gautham
> > Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
> > <Borislav.Petkov@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
> > <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> > pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
> >
> > On Thu, Apr 25, 2024 at 10:08=E2=80=AFAM Perry Yuan <perry.yuan@amd.com=
>
> > wrote:
> > >
> > > The patch series adds some fixes and enhancements to the AMD pstate
> > > driver.
> > >
> > > It enables CPPC v2 for certain processors in the family 17H, as
> > > requested by TR40 processor users who expect improved performance and
> > > lower system temperature.
> > >
> > > changes latency and delay values to be read from platform firmware
> > > firstly for more accurate timing.
> > >
> > > A new quirk is introduced for supporting amd-pstate on legacy
> > > processors which either lack CPPC capability, or only only have CPPC
> > > v2 capability
> > >
> > > Testing done with one APU system while cpb boost on:
> > >
> > > amd_pstate_lowest_nonlinear_freq:1701000
> > > amd_pstate_max_freq:3501000
> > > cpuinfo_max_freq:3501000
> > > cpuinfo_min_freq:400000
> > > scaling_cur_freq:3084836
> > > scaling_max_freq:3501000
> > > scaling_min_freq:400000
> > >
> > > analyzing CPU 6:
> > >   driver: amd-pstate-epp
> > >   CPUs which run at the same hardware frequency: 6
> > >   CPUs which need to have their frequency coordinated by software: 6
> > >   maximum transition latency:  Cannot determine or is not supported.
> > >   hardware limits: 400 MHz - 3.50 GHz
> > >   available cpufreq governors: performance powersave
> > >   current policy: frequency should be within 400 MHz and 3.50 GHz.
> > >                   The governor "powersave" may decide which speed to =
use
> > >                   within this range.
> > >   current CPU frequency: Unable to call hardware
> > >   current CPU frequency: 3.50 GHz (asserted by call to kernel)
> > >   boost state support:
> > >     Supported: yes
> > >     Active: yes
> > >     AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.50 GHz.
> > >     AMD PSTATE Nominal Performance: 204. Nominal Frequency: 2.80 GHz.
> > >     AMD PSTATE Lowest Non-linear Performance: 124. Lowest Non-linear
> > Frequency: 1.70 GHz.
> > >     AMD PSTATE Lowest Performance: 30. Lowest Frequency: 400 MHz.
> > >
> > >
> > > I would greatly appreciate any feedbacks.
> > > Thank you!
> > > Perry.
> > >
> > > Changes from v11:
> > >  * minmor change for patch 1 "perf" change to "performance"(Huang ray=
)
> > >  * rebased to lastest linux-pm/bleeding-edge branch
> > >
> > > Changes from v10:
> > >  * pick ack-by flags from huang ray for all patches.
> > >  * run testing on AMD Ryzen 5 7640U without regression issue.
> > >
> > > Changes from v9:
> > >  * pick review by flag from Meng Li
> > >  * pick test by flag from Ugwekar Dhananjay
> > >  * picl review by flag from Gautham R. Shenoy
> > >
> > > Changes from v8:
> > >  * add commit log for patch 1 and patch 2 (Rafael)
> > >  * add missing Perry signed-off-by for new patches #1,#2,#4 (Rafael)
> > >  * rebased to latest linux-pm/bleeding-edge
> > >
> > > Changes from v7:
> > >  * Gautham helped to invole some new improved patches into the patchs=
et.
> > >  * Adds comments for cpudata->{min,max}_limit_{perf,freq}, variables =
[New
> > Patch].
> > >  * Clarifies that the units for cpudata->*_freq is in khz via comment=
s [New
> > Patch].
> > >  * Implements the unified computation of all cpudata->*_freq
> > >  * v7 Patch 2/6 was dropped which is not needed any more
> > >  * moved the quirk check to the amd_pstate_get_freq() function
> > >  * pick up RB flags from Gautham
> > >  * After the cleanup in patch 3, we don't need the helpers
> > >    amd_get_{min,max,nominal,lowest_nonlinear}_freq(). This
> > >    patch removes it [New Patch].
> > >  * testing done on APU system as well, no regression found.
> > >
> > > Changes from v6:
> > >  * add one new patch to initialize capabilities in
> > >    amd_pstate_init_perf which can avoid duplicate cppc capabilities r=
ead
> > >    the change has been tested on APU system.
> > >  * pick up RB flags from Gautham
> > >  * drop the patch 1/6 which has been merged by Rafael
> > >
> > > Changes from v5:
> > >  * rebased to linux-pm v6.8
> > >  * pick up RB flag from for patch 6(Mario)
> > >
> > > Changes from v4:
> > >  * improve the dmi matching rule with zen2 flag only
> > >
> > > Changes from v3:
> > >  * change quirk matching broken BIOS with family/model ID and Zen2
> > >    flag to fix the CPPC definition issue
> > >  * fix typo in quirk
> > >
> > > Changes from v2:
> > >  * change quirk matching to BIOS version and release (Mario)
> > >  * pick up RB flag from Mario
> > >
> > > Changes from v1:
> > >  * pick up the RB flags from Mario
> > >  * address review comment of patch #6 for amd_get_nominal_freq()
> > >  * rebased the series to linux-pm/bleeding-edge v6.8.0-rc2
> > >  * update debug log for patch #5 as Mario suggested.
> > >  * fix some typos and format problems
> > >  * tested on 7950X platform
> > >
> > >
> > > V1:
> > > https://lore.kernel.org/lkml/63c2b3d7-083a-4daa-ba40-
> > 629b3223a92d@mail
> > > box.org/
> > > V2:
> > > https://lore.kernel.org/all/cover.1706863981.git.perry.yuan@amd.com/
> > > v3:
> > > https://lore.kernel.org/lkml/cover.1707016927.git.perry.yuan@amd.com/
> > > v4:
> > > https://lore.kernel.org/lkml/cover.1707193566.git.perry.yuan@amd.com/
> > > v5:
> > > https://lore.kernel.org/lkml/cover.1707273526.git.perry.yuan@amd.com/
> > > v6:
> > > https://lore.kernel.org/lkml/cover.1707363758.git.perry.yuan@amd.com/
> > > v7:
> > > https://lore.kernel.org/lkml/cover.1710323410.git.perry.yuan@amd.com/
> > > v8:
> > > https://lore.kernel.org/lkml/cover.1710754409.git.perry.yuan@amd.com/
> > > v9:
> > > https://lore.kernel.org/lkml/cover.1710836407.git.perry.yuan@amd.com/
> > > v10:
> > > https://lore.kernel.org/lkml/cover.1711335714.git.perry.yuan@amd.com/
> > > v11:
> > > https://lore.kernel.org/lkml/cover.1713858800.git.perry.yuan@amd.com/
> > >
> > >
> > > Gautham R. Shenoy (3):
> > >   cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudat=
a
> > >   cpufreq: amd-pstate: Document the units for freq variables in
> > >     amd_cpudata
> > >   cpufreq: amd-pstate: Remove
> > >     amd_get_{min,max,nominal,lowest_nonlinear}_freq()
> > >
> > > Perry Yuan (5):
> > >   cpufreq: amd-pstate: Unify computation of
> > >     {max,min,nominal,lowest_nonlinear}_freq
> > >   cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
> > >   cpufreq: amd-pstate: get transition delay and latency value from AC=
PI
> > >     tables
> > >   cppc_acpi: print error message if CPPC is unsupported
> > >   cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities
> > >     missing
> > >
> > >  drivers/acpi/cppc_acpi.c     |   4 +-
> > >  drivers/cpufreq/amd-pstate.c | 257 +++++++++++++++++++++------------=
--
> > >  include/linux/amd-pstate.h   |  20 ++-
> > >  3 files changed, 174 insertions(+), 107 deletions(-)
> > >
> > > --
> >
> > Whole series applied as 6.10 material, thanks!
>
> Thank you so much for merging the changes!

No problem.

However, there are compiler warnings in the new material that need to
be addressed before it goes into linux-next.

I've seen your patch addressing some of them, but there is still an
unused local variable to deal with.

