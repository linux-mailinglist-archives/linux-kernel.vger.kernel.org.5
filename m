Return-Path: <linux-kernel+bounces-56549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB2284CB90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BD428D8F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11E76C7C;
	Wed,  7 Feb 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="EjiwfJou"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118076C8F;
	Wed,  7 Feb 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312487; cv=none; b=VVkChoEtlu0Kb/WBnI28cg4RSqEMoseLIBYD1ZID93jy7MpvV9l3MB61YWymVjfd0A/CMKD63kjZdv8QR3+PIVTrLMGJv46EVXIhEliG9qrBepZxjxYGU78RU/ZJReSCrHPds7jabCQeEYTTYELgENtF5hCbczOuxl/757kRweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312487; c=relaxed/simple;
	bh=DvdlY6gEln8xLlp7txNw2XR2dlB/OCHAqkbx0Qr7n9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXyrgoa+1174WXGMGuYtwGP2n1hIzSdrrnAZJaqdrrK+ibR4FEx01uolhxY2wtI9hdCLK9H/PRF3ymPGySb0QFHYtEffF2N/SaZ4SAPfZNQll5uhdsal5np0aM5y65hWaL2xTcFcS6ob/wbcwD1fkbDD4zVBZsp9jJAdhByaIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=EjiwfJou; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 48FE7635B069;
	Wed,  7 Feb 2024 14:28:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1707312481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4cMXeY/Kh7m8qMA8TBfsP3a0MdHiYMkQr/AQMRNVpA=;
	b=EjiwfJoum02Qy0tJOcE/zvuxNlEuH3MCUUUsGZt7xOOhreazfWYBjStmccUkYesQv8KRbA
	Fah4p3Eiwgi5zoLsajklSmCLRmMpvh6c4Cug0fxTgdxyOKdawUhCGjgNHJS2bPQGAMkNaf
	/wT4d1U7zDdzds1euRJnSieNB9R7L9I=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Petkov, Borislav" <Borislav.Petkov@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Shimmer" <Shimmer.Huang@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v3 6/7] cpufreq: amd-pstate: remove legacy set_boost callback for
 passive mode
Date: Wed, 07 Feb 2024 14:27:29 +0100
Message-ID: <5065083.31r3eYUQgx@natalenko.name>
In-Reply-To:
 <CYYPR12MB8655B6D156512E187F2A736B9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
References:
 <cover.1707297581.git.perry.yuan@amd.com> <2887380.mvXUDI8C0e@natalenko.name>
 <CYYPR12MB8655B6D156512E187F2A736B9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4713795.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4713795.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 07 Feb 2024 14:27:29 +0100
Message-ID: <5065083.31r3eYUQgx@natalenko.name>
MIME-Version: 1.0

On st=C5=99eda 7. =C3=BAnora 2024 14:17:06 CET Yuan, Perry wrote:
> [AMD Official Use Only - General]
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Sent: Wednesday, February 7, 2024 6:11 PM
> > To: rafael.j.wysocki@intel.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> > <Ray.Huang@amd.com>; Shenoy, Gautham Ranjal
> > <gautham.shenoy@amd.com>; Petkov, Borislav
> > <Borislav.Petkov@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 6/7] cpufreq: amd-pstate: remove legacy set_boost
> > callback for passive mode
> >
> > Hello.
> >
> > On st=C5=99eda 7. =C3=BAnora 2024 10:21:57 CET Perry Yuan wrote:
> > > With new freqency boost interface supported, legacy boost control
> > > doesn't make sense any more which only support passive mode.
> > > so it can remove the legacy set_boost interface from amd-pstate driver
> > > in case of there is conflict with new boost control logic.
> > >
> > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > > ---
> > >  drivers/cpufreq/amd-pstate.c | 1 -
> > >  include/linux/amd-pstate.h   | 1 -
> > >  2 files changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c
> > > b/drivers/cpufreq/amd-pstate.c index 35791efc6e88..1dd523db3871
> > 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -1675,7 +1675,6 @@ static struct cpufreq_driver amd_pstate_driver =
=3D
> > {
> > >     .exit           =3D amd_pstate_cpu_exit,
> > >     .suspend        =3D amd_pstate_cpu_suspend,
> > >     .resume         =3D amd_pstate_cpu_resume,
> > > -   .set_boost      =3D amd_pstate_set_boost,
> > >     .update_limits  =3D amd_pstate_update_limits,
> > >     .name           =3D "amd-pstate",
> > >     .attr           =3D amd_pstate_attr,
> > > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > > index 465e9295a60c..ab7ca26974da 100644
> > > --- a/include/linux/amd-pstate.h
> > > +++ b/include/linux/amd-pstate.h
> > > @@ -93,7 +93,6 @@ struct amd_cpudata {
> > >     struct amd_aperf_mperf prev;
> > >
> > >     u64     freq;
> > > -   bool    boost_supported;
> >
> > As a result of this removal the kernel-doc for this struct should be am=
ended
> > too because even after this patch is applied the `boost_supported` field
> > remains documented.
>=20
> The set_boost is callback used by cpufreq.c, the boost_supported is not d=
ocumented before the patch.
> We just need to add new sysfs "cpb_boost" introduction in the "/Documenta=
tion/admin-guide/pm/amd-pstate.rst"
> The legacy boost is not supported any more, we have no need to document i=
t again as it is.

`boost_supported` as a field of `struct amd_cpudata` is documented in the k=
ernel-doc right before the structure, and this bit should be removed like s=
hown below:

```
=2D-- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -56,7 +56,6 @@ struct amd_aperf_mperf {
  * @cur: Difference of Aperf/Mperf/tsc count between last and current samp=
le
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value
=2D * @boost_supported: check whether the Processor or SBIOS supports boost=
 mode
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
  * 		  AMD P-State driver supports preferred core featue.

```

> Perry.
>=20
> >
> > >     bool    hw_prefcore;
> > >
> > >     /* EPP feature related attributes*/
> > >
> >
> >
> > --
> > Oleksandr Natalenko (post-factum)
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4713795.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXDhUEACgkQil/iNcg8
M0viNA/+JgIrXfN2tea1g1fTzeFTG6W846DHmLLtTYZNsXjvObcK63bHl/Mr4dZp
4DiU49PMjfueTC8Smmt94hFJ0DjLJWMhK/IRQXvyUzMQG78FwFRjbE70rTfz96TQ
vwj1i95YcaPkgkBQUJFAFIOs/NONm4VjbpMMoXp0n3tqirMGArwxJVUXxZ+SkqDb
yioZ3Bq8o4qTeBd+A89XCNk1KKiGAtvRyuZMR1x0HUYdXyXG5ptIjkNe5DDtaMet
hacyeaubCgQw2+3i1t+EvYTnNjfgJG1HIiYslyrz0VvNv0VjhWx1Iql7LY1HHwR5
+W3eX/A6zwNuOCfmFitU9XgsN6yqKeuiATz8oCNJOjOVs+G7YZtqV0GNuF1Oq8RP
nnHKfXPEsDNY653ITys6HNNz0e2GH4Z3ocyRFJEn6MWxvukEjZSzDa0FjiIp78Hs
q/+/HaA3BDqJwNrTrcS3GzO5fnnTqFjtaki7gFvEAA33uMbDtTX9utWxqdSAENEd
InTrlrpl2GFjdEn0jbIKOpHqEovCYnObw4eR8AJeO+htCKSTApVTPTI2p5I4Ap9f
jnHaleyKPom4yI92o7gIKTPRaB706HgzY1PSwQy1O/LtrWe+zHsHEYYLB0JBm3Gv
L0a/T4FZE9p4Higm3IpLrf4Nlo3iZX/7TlxQtbmm1iByx+ZRMSE=
=W5i2
-----END PGP SIGNATURE-----

--nextPart4713795.LvFx2qVVIh--




