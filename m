Return-Path: <linux-kernel+bounces-104611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602887D0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1511F24236
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC3C44C76;
	Fri, 15 Mar 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="m455OtMp"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937203FB32;
	Fri, 15 Mar 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518805; cv=none; b=Fm127+o5+mpMA/NKthWi9+0IsEbB8sNUFX1E2BBOvyUygDQoC7YSC6FmnFOFWq+upxbUuuQ5qFPd1FzRiJysHYnP+PuPWAI2PJx1vMwLh0H194hhUUKFkqeHvlueB0FJ2tGub7Lb7jMY52jUgwTKi/dQlIenuj7/0BVWc4ZuBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518805; c=relaxed/simple;
	bh=ItJPQq7JRzxEIAmeaiJNt26yQwr3RBi2ycQsx51xG6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMd7neIBahHAFaZMKLKR3R0C7+/CqVk947+rmqp+U5Iu4lyoxSI0xvVDk+B2gTbff22A8J0JpCKyWubBjdcRO7etLqQaZGw8EUywQXHyb7Y5a+5rYpex8fkDNRSAs9FmByKz9renMbEquRJ2TJA6wIMHagFbFLRz7Dzu72RSxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=m455OtMp; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 6A527635B049;
	Fri, 15 Mar 2024 17:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1710518793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gQPqkmpk7YcIRX+3vXEzzFZadeD6j9GpNAUrT87K2w=;
	b=m455OtMp+a550FiS/k3Pm5B2/T5fuwsx1P9u65sQguqhS2BXAItk95mtLXGfjP0fmWACIr
	76Xr1TRO06j1v1nnL4DvMOEbd/UI9xpQwL1GlgIWFBCnBwQgBDejbJktoOnAYPfuxVViNm
	Wq69Ip7aemt08MSAMDDqXPfK9wri+0A=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] AMD Pstate Driver Core Performance Boost
Date: Fri, 15 Mar 2024 17:06:22 +0100
Message-ID: <4975219.31r3eYUQgx@natalenko.name>
In-Reply-To: <cover.1710473712.git.perry.yuan@amd.com>
References: <cover.1710473712.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4623272.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4623272.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v5 0/8] AMD Pstate Driver Core Performance Boost
Date: Fri, 15 Mar 2024 17:06:22 +0100
Message-ID: <4975219.31r3eYUQgx@natalenko.name>
In-Reply-To: <cover.1710473712.git.perry.yuan@amd.com>
References: <cover.1710473712.git.perry.yuan@amd.com>
MIME-Version: 1.0

On p=C3=A1tek 15. b=C5=99ezna 2024 4:38:01, CET Perry Yuan wrote:
> Hi all,
> The patchset series add core performance boost feature for AMD pstate
> driver including passisve ,guide and active mode support.
>=20
> User can change core frequency boost control with a new sysfs entry:
>=20
> "/sys/devices/system/cpu/amd_pstate/cpb_boost"
>=20
> The legancy boost interface has been removed due to the function
> conflict with new cpb_boost which can support all modes.
>=20
> 1). enable core boost:
> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ lscpu -ae
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
>   0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
>   1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
>   2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
>   3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
>   4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578
>=20
> 2). disabble core boost:
> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ lscpu -ae
>    0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
>   1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
>   2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
>   3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
>   4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578
>=20
>=20
> The patches have been tested with the AMD 7950X processor and many users
> would like to get core boost control enabled for power saving.
>=20
> If you would like to test this patchset, it needs to apply the patchset
> based on below one latest version patchset.
> https://lore.kernel.org/lkml/20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.=
local/
>=20
>=20
> Perry.
>=20
> Changes from v4:
>  * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>  * pick RB flag from Gautham R. Shenoy
>  * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>

That didn't work =C2=AF\_(=E3=83=84)_/=C2=AF.

>  * rebase to latest linux-pm/bleeding-edge branch
>  * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enh=
ancements
>  * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT=20
>=20
> Changes from v3:
>  * rebased to linux-pm/bleeding-edge v6.8
>  * rename global to amd_pstate_global_params(Oleksandr Natalenko)
>  * remove comments for boot_supported in amd_pstate.h
>  * fix the compiler warning for amd-pstate-ut.ko
>  * use for_each_online_cpu in cpb_boost_store which fix the null pointer
>    error during testing
>  * fix the max frequency value to be KHz when cpb boost disabled(Gautham =
R. Shenoy)
>=20
> Changes from v2:
>  * move global struct to amd-pstate.h
>  * fix the amd-pstate-ut with new cpb control interface
>=20
> Changes from v1:
>  * drop suspend/resume fix patch 6/7 because of the fix should be in
>    another fix series instead of CPB feature
>  * move the set_boost remove patch to the last(Mario)
>  * Fix commit info with "Closes:" (Mario)
>  * simplified global.cpb_supported initialization(Mario)
>  * Add guide mode support for CPB control
>  * Fixed some Doc typos and add guide mode info to Doc as well.
>=20
> v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
> v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
> v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
>=20
> *** BLURB HERE ***
>=20
> Perry Yuan (8):
>   cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>   cpufreq: amd-pstate: initialize new core precision boost state
>   cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
>   cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
>   cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
>     while cpb boost off
>   Documentation: cpufreq: amd-pstate: introduce the new cpu boost
>     control method
>   cpufreq: amd-pstate: remove legacy set_boost callback for passive mode
>   cpufreq: amd-pstate-ut: support new cpb boost control interface
>=20
>  Documentation/admin-guide/pm/amd-pstate.rst |  11 ++
>  arch/x86/include/asm/msr-index.h            |   2 +
>  drivers/cpufreq/acpi-cpufreq.c              |   2 -
>  drivers/cpufreq/amd-pstate-ut.c             |   2 +-
>  drivers/cpufreq/amd-pstate.c                | 157 +++++++++++++++-----
>  include/linux/amd-pstate.h                  |  15 +-
>  6 files changed, 150 insertions(+), 39 deletions(-)
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4623272.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmX0cf4ACgkQil/iNcg8
M0ugkBAArLlCqziEZ0odyHf+1VpTOwmr29jG39+2AJux0CuyZYWCwx49KZcWFAKB
kRvDDvBfjq7ydUFYydBjF6GpX5HG3cezei0rSfWqfRYBisNfcPvRP/Qyllz6V37B
szPHsr+eBXYJTTwt+V9hr3PNautne9A0mbnV55ocILF/2FDFTScQeLz8QvrNI1yB
0VuIeFyvd3llpx1+iUXC28y+tSCx4IyG4idPVNw0uQJ2uMKDWa8ptXLb08h8Yw6C
xT3BZl26gbgIRyV6yXrC14bbniHvskxzYRkAGknHia9CFjnuZpP2DmMyE0bd8hyg
z9rMzaAVclskayoLumEesLlUQAze19f6Q7R0jcR2btq+G5FNyvX3poTJ0p/LD5KL
1OIbCVg0yFtU7whEul7wHRd40zFaH52kjyJjvlcUlG7qQWuSCCn6HwcRc+U5Jgco
cjh/dZiV9U99LxUNr2C5qbnt6oE8aSKqQgrc4fe4WVkNxiSXfnU3eC2uWf9zPODH
EdC8AHVP+1JYGWX32YLAgBhLkNVPhokBVhjzKbsMiwgqgHi0IsCF4GajtUNvF17O
YASnq1/Zn/Nd/NHT7MdHxmiuYQrI+g0LWxxyTd84KxX3FeXM/RIyE+vz5q1bKqJt
jrL9d0Ti3tbC7I8LptWfVB/iljdawBuswF3O0tnRwOCqjLybv9c=
=D2Q3
-----END PGP SIGNATURE-----

--nextPart4623272.LvFx2qVVIh--




