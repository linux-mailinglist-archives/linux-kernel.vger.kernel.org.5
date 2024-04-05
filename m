Return-Path: <linux-kernel+bounces-133344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3909289A296
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28A51F249C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F05163A97;
	Fri,  5 Apr 2024 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="AIbz7XCx"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADBB2869B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334912; cv=none; b=NftED30EUk6KlZbBVqq80LybtAVTdMGJaHhe2uKpv1nxJqrwTlgbHJlcEEpaEAyrPKht8SemfyJxCB+5Y9BQnGEevk476brJb43+/x1KDW3ye8AvxQRepE0SNQsBnHa16GroDwzK34F0gvjIf1mt7IzdCWPNAtpnCBlnhev9/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334912; c=relaxed/simple;
	bh=O+UnvDut8VP1erLUptBy2LRJVciHe8+vp0N0w/zfIa4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5ee74fwqFJ72PybWKR/849h1p/l4rheSeFtfBfExXT4zGBzLSpAbJAhhzpvSJ8k1c9O9rGOw2WUG5HAGxWI57WWxJ0zXSFaNe5+Ju02MIIRUc6C8FRIFZHxCV7lyVXf7FatSYgJuwoUktwkyGmIvlpefeeDT0+/AQ2nx/F964Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=AIbz7XCx; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712334901; x=1712594101;
	bh=S3WQALqPQkgNA4pAsO5tIwgQszOpcZJAo1yOP3F/ne0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AIbz7XCx1kxCmMrfMHXFnmgxeaXtcWXNZHadfoIuneQnq8ltsXCS45mrqKOztcfmL
	 82aRIXMWdvr7D5s7S0O2A55FUGTNQDcIDMb95xf1i1vCw8TpEoO/nUgr9BFejmPeSC
	 wun1UzgVf5gQDrt/FScjLqTNc0WQ4SkKKWQVWnjRpVqOxreF3XFQM5r4/Jgr/mZcl9
	 3X2XkDKMGTlylO4zOrqaEUzCaTgEPWnrjH0SHPc+b02vIJdaGmHwyAcjnHQqQl0mpA
	 rIuVsPwXD+vQbq9Ryd+irQgGunhfbUAcCX83e+S5B/fv8wdVmoFxUPv/LTdWa3LlxQ
	 GFjWbwZN1Qhdw==
Date: Fri, 05 Apr 2024 16:34:58 +0000
To: Gergo Koteles <soyer@irl.hu>
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ACPI: platform-profile: add platform_profile_cycle()
Message-ID: <g_07w0jkBp9IeComzpK26YHPB1QZNjN_amEZ2bTG6xrOMMltvaav0Rd9Oh4a0nlzPsW2guvvUHkNQrfzSdFGbJhKDB0SHgUJB4belZNrapI=@protonmail.com>
In-Reply-To: <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
References: <cover.1712282976.git.soyer@irl.hu> <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
Feedback-ID: 20568564:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi


2024. =C3=A1prilis 5., p=C3=A9ntek 5:05 keltez=C3=A9ssel, Gergo Koteles <so=
yer@irl.hu> =C3=ADrta:

> Some laptops have a key to switch platform profiles.
>=20
> Add a platform_profile_cycle() function to cycle between the enabled
> profiles.
>=20
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  drivers/acpi/platform_profile.c  | 42 ++++++++++++++++++++++++++++++++
>  include/linux/platform_profile.h |  1 +
>  2 files changed, 43 insertions(+)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index d418462ab791..1579f380d469 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -136,6 +136,48 @@ void platform_profile_notify(void)
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_notify);
>=20
> +int platform_profile_cycle(void)
> +{
> +=09enum platform_profile_option profile;
> +=09enum platform_profile_option next;
> +=09int err;
> +
> +=09err =3D mutex_lock_interruptible(&profile_lock);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (!cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -ENODEV;
> +=09}
> +
> +=09err =3D cur_profile->profile_get(cur_profile, &profile);
> +=09if (err) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return err;
> +=09}
> +
> +=09next =3D ffs(cur_profile->choices[0] >> (profile + 1)) + profile;
> +
> +=09/* current profile is the highest, select the lowest */
> +=09if (next =3D=3D profile)
> +=09=09next =3D ffs(cur_profile->choices[0]) - 1;

I think you can use `find_next_bit()` or similar instead.


> +
> +=09if (WARN_ON((next < 0) || (next >=3D ARRAY_SIZE(profile_names)))) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09err =3D cur_profile->profile_set(cur_profile, next);
> +=09mutex_unlock(&profile_lock);
> +
> +=09if (!err)
> +=09=09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
> +=09return err;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_cycle);
> +
>  int platform_profile_register(struct platform_profile_handler *pprof)
>  {
>  =09int err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> index e5cbb6841f3a..f5492ed413f3 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -36,6 +36,7 @@ struct platform_profile_handler {
>=20
>  int platform_profile_register(struct platform_profile_handler *pprof);
>  int platform_profile_remove(void);
> +int platform_profile_cycle(void);
>  void platform_profile_notify(void);
>=20
>  #endif  /*_PLATFORM_PROFILE_H_*/
> --
> 2.44.0
>=20


Regards,
Barnab=C3=A1s P=C5=91cze

