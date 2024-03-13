Return-Path: <linux-kernel+bounces-101651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7783E87A9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34591F22F88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E40446AF;
	Wed, 13 Mar 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="rnTAli7W"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C126119;
	Wed, 13 Mar 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341958; cv=none; b=ET6gCExg72jOWTEfo3nTLPj5wMYLuMRKFaqpSrb04hcsV5ciPk9a2T3nnB2ioU8GipnR9fzXKqV1qp6JalyOCba3aIEXdUv38fPZiY8DlmEHeN682tYGAvQtvI2eUGgiIGGzIxY/zpOPfJtAHIHPTkhQsZ0HG4PyfK1KGRqMTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341958; c=relaxed/simple;
	bh=Oq5ehj0jgtkb/PT5kiTlAvv5HCm7BnWN2D7UlVXc1po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6weYxyNvYONH1oodBFEQuBkHnFXr0aILnyrE/3vM5znYyZog2kXq3YC1pZVf1nIhd9SohEBFOBfLwTinXMSBkC8L1rj0/406o6IpFTNsrHq6hbbdmGeFi9TgjkKoqdIM4juRTrc8MkZ1jvQmXPtcwsHelZSXUheDd4HAlacQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=rnTAli7W; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 1A917635B049;
	Wed, 13 Mar 2024 15:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1710341350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iwfkBYf3yJiDaRw2lxcFE7exRFkrA4jEAyCuZ8fP2A=;
	b=rnTAli7WrlY35E48+oZ1f4A/GguMmiD+kSf16h6wUZdwtv1ztTKx+DS7Tb9Ebr2542K5IU
	nm+65NJ863HCfnC73H0poAoptFskFChwk+deECjDvOd7qqgz2tSBDb0C496TeOff9coT2N
	/27yHnC8EokEQCvNOUx7tJ/dG6RmZJI=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 13 Mar 2024 15:48:58 +0100
Message-ID: <2721197.mvXUDI8C0e@natalenko.name>
In-Reply-To: <cover.1710322310.git.perry.yuan@amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12395831.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12395831.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v4 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 13 Mar 2024 15:48:58 +0100
Message-ID: <2721197.mvXUDI8C0e@natalenko.name>
In-Reply-To: <cover.1710322310.git.perry.yuan@amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
MIME-Version: 1.0

On st=C5=99eda 13. b=C5=99ezna 2024 11:04:37, CET Perry Yuan wrote:
>=20
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
> based on below one latest version patchset.=20
> https://lore.kernel.org/lkml/20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.=
local/
>=20
>=20
> Perry.
>=20
>=20
> Changes from v3:
>  * rebased to linux-pm/bleeding-edge v6.8
>  * rename global to amd_pstate_global_params(Oleksandr Natalenko)

Would appreciate being in Cc: then.

>  * remove comments for boot_supported in amd_pstate.h
>  * fix the compiler warning for amd-pstate-ut.ko
>  * use for_each_online_cpu in cpb_boost_store which fix the null pointer
>    error during testing=20
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
>=20
> Perry Yuan (7):
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
>  drivers/cpufreq/amd-pstate-ut.c             |   2 +-
>  drivers/cpufreq/amd-pstate.c                | 157 +++++++++++++++-----
>  include/linux/amd-pstate.h                  |  16 +-
>  4 files changed, 149 insertions(+), 37 deletions(-)
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12395831.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXxvNoACgkQil/iNcg8
M0vVbBAAjuIVAWC5tJ9yDAmxbzbCwI/34/400d1rFGcEP2vrRUA51G5yCK7YWOGz
3N2SXE4B24N+9upXbIkyBjHQSZu402PdalldNasFl/nFsAQrdJxvoBKLvx3WTC78
NHkFCZMaRy9wMrB8JyA63hjoh30BYDcxHHfL/1axm24Q0HEvc9Ab5cnAE6i3SH9x
0d2Jey91hs4lwYm/5VP/VLlaV03DiXjuLZpO0lpi0SoDu3i2gLsazSijFz/NEJqB
LTjEd7hmpK0L8PiZRAiMv1G5HdAP/X5Qujd7+dY/Hmf1WUrypr42hnQQajfaFMvS
ctfMbUtRZ9PQd85nZXhmljPxKyONAdX+6Qi4oU+skWO5YHuuKrJqofLln27OEDPK
uY590jH+maYu5I0dKnqaIPt5H+4T5J2G8h0QB/imKYIebmRqFBHYXOHtC3ygUt7z
MbAgIerB47Jcjawri2GN1OclbSUOQ3jj64RR7thODrlfwphUAsSKIIbiNHGpPIob
1UU3n6ZWQr4sO2K2vq4kl3ZThQHPWHf59v6m2Au3jaxQMkEGE2tjOLaujwDRAP4j
yEHZRfg2+Vg3in+Vq57mJV3ZgivGdCIE+vjAA1d0r+/q+7FXAIPte0M7ZCO5Rd8d
bUckmx8FTuKMfXPtA5GybH5UlVohqtXuNBDjQjOztKtvYWOO0Kw=
=f6Gb
-----END PGP SIGNATURE-----

--nextPart12395831.O9o76ZdvQC--




