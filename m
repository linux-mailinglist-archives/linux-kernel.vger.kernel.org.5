Return-Path: <linux-kernel+bounces-133917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3689AAB3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF54282862
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C162D051;
	Sat,  6 Apr 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwyQhtKZ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020313ACC;
	Sat,  6 Apr 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712405890; cv=none; b=bc3RHMpcnQZFvseZE+c8GboUlVP7cdgkCdddUznq/zzUAaFgrRltlIkI9LfzFOZlx8tu/8Ly0AGiWDm7BiVB7Hrw8JUSzqTQzqyGSo0SqQ4b6yWFD7EL4TmgXnqy5zbKKJhtEd+kAlLVrUk9dihzXRBMOFAWBhpsJbni4fHL7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712405890; c=relaxed/simple;
	bh=HMqxkQVw5ClLHO8uz/q7lloBVQ8OoW2lW1vT1IPuxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mjdTQoHqjzRwdffQ3dYP2corHc+wQ6Muu5/c9Pqrbmx2KZWG6b/H7bN1IWclK4nYX34POgSKSvY81N2U71mCvIo0ydA837PItKQpdy+JAIah0G9m//y4FapN1SGOeMc+mxpdNDqc/JqXPsNH2KoVitG8secilu1Er2ZV9Ng7BCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwyQhtKZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so2484243a12.0;
        Sat, 06 Apr 2024 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712405888; x=1713010688; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMqxkQVw5ClLHO8uz/q7lloBVQ8OoW2lW1vT1IPuxmE=;
        b=MwyQhtKZYthok3G0nrwgOjI6Z5jjfpFbHqJORZx6y8PhUIDDVJsvvnfk9QgBFxVgnQ
         N2EAtZF7mVnr30j1jDGAgz75lWGarX+K5CV/7PSvauMZviw0oU5+ZwFAUnARghSklTJZ
         rq1a7IUKChhHPHXcO/HujBIJJd2gICRb0MgamOQmKAHRSiHpc3FAuWTimm1Oa7f5wpZ2
         l+a43p2JNfgRx/4dTjwMIxVD4nvXt6S6/tYrWZdhH/g+Tt1xcDaMiKbLJvuRHp51hJYW
         XnW2oyE6ZIfHcl/EBl56kfJZvlMOPn5hKQ4pVcDcYhsIK0TuoqERoU5d+b6oxS3B8RHL
         zg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712405888; x=1713010688;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMqxkQVw5ClLHO8uz/q7lloBVQ8OoW2lW1vT1IPuxmE=;
        b=fhg/FgIEHMaNnkLSaQV/MrnlbiwHIxXaXDssvQ9InmlUAOwtLuZtoEBcisGJx8Evrf
         HQJQk/Ly+rfphmM8CXTU90WE2cQy9SFUFGmOPxN8U/uEydwCUfkED0+hPDLR9chSPxVK
         uIP2G+w2nl16uySZg+O5FSLbU7aNPXDfghGSqLqU4Z1vKN76hWHyYmBazPSYlU37gB5c
         2ILTPJyA/G2wGXszbin18N3M7r4McW9P/eCkmnqrBaXtmDM033h7IxBCcrXDJHMiEXvz
         cu8XvUAPiLuxNSwkP4WRWOloR7hIX8b3TOguUlnLEQSQ4JU2OyCCUkWT3U+uu32E5QQ5
         qKcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNfID4AJwy0Vq2HRfZv3KdEgl+cyhx4tsZWO9f3BhNAceNcWZ+4ahVNHwjaKbqOX5IYY1PZswcA6W3uDWeVQ87K7mNabMpYP+++NY=
X-Gm-Message-State: AOJu0YyhgKT6GKeWJEoQc3hOI4EoKt9dbSu93MwKmlA2T0OAZpkuiPF1
	cjjXQ5QwBeaCAq9IIfAJ25VU+oR1N73/dhl6G6hddnRIjzFG+8fw
X-Google-Smtp-Source: AGHT+IGQPlaSFuYq9fPQYp0icxQCR+ZbK3UWXnqwUFy+ktbJf/r7OsELtMIgKwLkW6f+kXuEOMnVSw==
X-Received: by 2002:a05:6a20:9497:b0:1a6:fe4f:755f with SMTP id hs23-20020a056a20949700b001a6fe4f755fmr4181955pzb.32.1712405888182;
        Sat, 06 Apr 2024 05:18:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00188700b006ecfe20d38csm3091883pfh.30.2024.04.06.05.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 05:18:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 17A1C186046F6; Sat,  6 Apr 2024 19:18:05 +0700 (WIB)
Date: Sat, 6 Apr 2024 19:18:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Linux ALSA Development <alsa-devel@alsa-project.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	=?utf-8?Q?franti=C5=A1ek?= <Oddy38@seznam.cz>
Subject: Fwd: No speaker output on lenovo legion s7 16arha7
Message-ID: <ZhE9fDBVvqC1SL4p@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t65VTSFms3bdx3p0"
Content-Disposition: inline


--t65VTSFms3bdx3p0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Bugzilla, franti=C5=A1ek <Oddy38@seznam.cz> reported speaker problem on
his Lenovo laptop [1]:

> Hello after troubleshooting the issue on linux mint support we have come =
to the fact that it report a bug=20
> my laptop's repeaters don't work (headphones work)
> I updated to kernel 6.5.0-26-generic before I had the old version and it =
also did not work=20
> I updated this firmware https://git.kernel.org/pub/scm/linux/kernel/git/f=
irmware/linux-firmware.git/commit/t
> in the sound settings it detects sound for example from youtube but still=
 nothing comes out of the speakers=20
> here is a link to how we troubleshot it
> https://forums.linuxmint.com/viewtopic.php?p=3D2450183#p2450183

See Bugzilla for details.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218667

--=20
An old man doll... just what I always wanted! - Clara

--t65VTSFms3bdx3p0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhE9fAAKCRD2uYlJVVFO
oylMAP9FWBpRiuurHGBjj8js1NmTUwQRASwlhl8u3ENJ5s0l8AD9FOsyZWu6kNjc
8jsgR0ZBqX5aTOWx1c8q1Ap3Hv3/egM=
=6VN6
-----END PGP SIGNATURE-----

--t65VTSFms3bdx3p0--

