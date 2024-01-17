Return-Path: <linux-kernel+bounces-28669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCA8301A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9A81F21795
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8861400A;
	Wed, 17 Jan 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK6rFsBi"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6D13FF5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481726; cv=none; b=SRBCXhwLzWlB/frkrx1fXsJ0FazNQumwq7Im9FyA4TDM1Ip1ui2/VdurklsI5SyZZ3LU6cCssGGKrKLkF8K+pkezkfb2otTPVx79QKPljhqEO30svbZ0gKa1pj7LAHbo6mljmaoXTxPVVfyJ5JGSd/Cp5Fazyb4nfwX2JTlh+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481726; c=relaxed/simple;
	bh=YLcoWIy06Arq4JTfJu2/m7c5pkHFQGM6slJxzCbN+h0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type; b=YD62RFYiMQnvwEtddq4RoMGXFPew0EilEzBGYOqSrO01RowmzD7r3M1nqPX7ZyEouUOSivvcG7yuKgGELbf+AxE7RZYj7i91AiOAp2fsA5suoLaE1VPQcqma0zSeMD9vEw3MU2X4eNga4UV24Mg7vnlW+SzRzmcymyZ9J4ssPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK6rFsBi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so12944471e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 00:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705481721; x=1706086521; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBhzqek/6fd7CREjB7gj0PgcE8vXqoFMHvhu7g1QD50=;
        b=jK6rFsBiA/cClNp3zNJr+q+KOGeoLNISHXVkUvkGuSBSCF60P1hUcJvDwbKch0h+pl
         5mjRXQu1fs0fukpK5oMbVxjcHlnOdvHi98W9dITIkZKV7b2s1TWBEAZwzJtbv7L3PEn5
         WHHtABY1R+utOmoZ3c0zSiBnalskbI0nO/vm9DYG2NA7yedZOTZ2xigI49U/p4HvSY5E
         IV4TGzR9xw3T5UulgSVtKoTctWXhivnmol/CgPxjq+5nrzsHWdL3zLgY4bzHVw4pyNpc
         3HQwFqjjZhM3wBFGSN4yBML+qfAxddI7//y35LDsL6MVo9+SUONmYFhowmXkAYrjUYkv
         9qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705481721; x=1706086521;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBhzqek/6fd7CREjB7gj0PgcE8vXqoFMHvhu7g1QD50=;
        b=H/fxDkoVgGWZm0/UCEcWXnDQVmscRhk3p2Ava0YgxzpTEyUzFTufzzD33G7p4z3g4u
         s7jO3OFVjdW5hU0mqkshsjMCrIMA1Orx/tWM7LLl/0z5CJVX21zg6NtnHD4Oza5/Jn6b
         /1KsRA0jCpJd0uFhQ4FOVlrBW0gV1UnbrBbdNXmervtX8fEx1wW1OuVV+uxrpiXPxo/8
         idW3iOHnwFo9InDJPnn3Gl48cYTk38QeIqG2m4osTt1nAATn8yepJzOLMdwIWIqEvPLm
         lxP2cV5CknY0K1fcvPtL2ATmletU+HFQMFhI1MZVGp7C3CazuGCR4ekFfDfusJCw2RYj
         WuPA==
X-Gm-Message-State: AOJu0YzDr3+ngXpTbR9JPHbEnT3C5OuGkBGfMIGCCLi9/MoRDqvxrZQ3
	8RNlSaOmtfInzuRrZoE2kkI=
X-Google-Smtp-Source: AGHT+IHhkXxluDe4N7YGLtu2N2AxQtwIH8y92VnGpUGxrLimI7QLF2GoeO0C1Wyx2JopwGlhJsASaQ==
X-Received: by 2002:ac2:5d23:0:b0:50e:6332:8083 with SMTP id i3-20020ac25d23000000b0050e63328083mr1775703lfb.183.1705481720786;
        Wed, 17 Jan 2024 00:55:20 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id dx5-20020a0565122c0500b0050e7741f582sm180895lfb.161.2024.01.17.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 00:55:20 -0800 (PST)
Date: Wed, 17 Jan 2024 10:55:09 +0200
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Xaver Hugl <xaver.hugl@gmail.com>
Cc: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Simon Ser
 <contact@emersion.fr>, daniel@ffwll.ch, Daniel Stone
 <daniel@fooishbar.org>, Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Joshua
 Ashton <joshua@froggi.es>
Subject: Re: [PATCH 0/2] drm/atomic: Allow drivers to write their own plane
 check for async
Message-ID: <20240117105509.1984837f@eldfell>
In-Reply-To: <CAFZQkGyOQ5Tfu++-cHqgZ9NOJxqxm8cAF5XT18LmisuPAUbXAg@mail.gmail.com>
References: <20240116045159.1015510-1-andrealmeid@igalia.com>
	<20240116114522.5b83d8b6@eldfell>
	<a6099681-1ae9-48ef-99bc-d3c919007413@igalia.com>
	<20240116151414.10b831e6@eldfell>
	<47c6866a-34d6-48b1-a977-d21c48d991dc@igalia.com>
	<CAFZQkGyOQ5Tfu++-cHqgZ9NOJxqxm8cAF5XT18LmisuPAUbXAg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uaSCk2iCuPC2HhY2IGqSpLb";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uaSCk2iCuPC2HhY2IGqSpLb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 17:10:18 +0100
Xaver Hugl <xaver.hugl@gmail.com> wrote:

> My plan is to require support for IN_FENCE_FD at least. If the driver
> doesn't
> allow tearing with that, then tearing just doesn't happen.

That's an excellent point. I think this is important enough in its own
right, that it should be called out in the patch series.

Is it important enough to be special-cased, e.g. to be always allowed
with async commits?

Now that I think of it, if userspace needs to wait for the in-fence
itself before kicking KMS async, that would defeat much of the async's
point, right? And cases where in-fence is not necessary are so rare
they might not even exist?

So if driver/hardware cannot do IN_FENCE_FD with async, is there any
use of supporting async to begin with?

> For overlay planes though, it depends on how the compositor prioritizes
> things.
> If the compositor prioritizes overlay planes and would like to do tearing
> if possible,
> then this patch works.

Ok, I can see that.

> If the compositor prioritizes tearing and would like to do overlay planes
> if possible,
> it would have to know that switching to synchronous commits for a single
> frame,
> setting up the overlay planes and then switching back to async commits
> works, and
> that can't be figured out with TEST_ONLY commits.

I had to ponder a bit why. So I guess the synchronous commit in between
is because driver/hardware may not be able to enable/disable extra
planes in async, so you need a synchronous commit to set them up, but
afterwards updates can tear.

The comment about Intel needing one more synchronous commit when
switching from sync to async updates comes to mind as well, would that
be a problem?

> So I think having a CAP or immutable plane property to signal that async
> commits
> with overlay and/or cursor planes is supported would be useful.

Async cursor planes a good point, particularly moving them around. I'm
not too informed about the prior/on-going efforts to allow cursor
movement more often than refresh rate, I recall something about
amending atomic commits? How would these interact?

I suppose the kernel still prevents any new async commit while a
previous commit is not finished, so amending commits would still be
necessary for cursor plane motion? Or would it, if you time "big
commits" to finish quickly and then spam async "cursor commits" in the
mean time?


Thanks,
pq

> Am Di., 16. Jan. 2024 um 14:35 Uhr schrieb Andr=C3=A9 Almeida <
> andrealmeid@igalia.com>: =20
>=20
> > + Joshua
> >
> > Em 16/01/2024 10:14, Pekka Paalanen escreveu: =20
> > > On Tue, 16 Jan 2024 08:50:59 -0300
> > > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> > > =20
> > >> Hi Pekka,
> > >>
> > >> Em 16/01/2024 06:45, Pekka Paalanen escreveu: =20
> > >>> On Tue, 16 Jan 2024 01:51:57 -0300
> > >>> Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> > >>> =20
> > >>>> Hi,
> > >>>>
> > >>>> AMD hardware can do more on the async flip path than just the prim=
ary =20
> > plane, so =20
> > >>>> to lift up the current restrictions, this patchset allows drivers =
to =20
> > write their =20
> > >>>> own check for planes for async flips. =20
> > >>>
> > >>> Hi,
> > >>>
> > >>> what's the userspace story for this, how could userspace know it co=
uld =20
> > do more? =20
> > >>> What kind of userspace would take advantage of this and in what =20
> > situations? =20
> > >>>
> > >>> Or is this not meant for generic userspace? =20
> > >>
> > >> Sorry, I forgot to document this. So the idea is that userspace will
> > >> query what they can do here with DRM_MODE_ATOMIC_TEST_ONLY calls,
> > >> instead of having capabilities for each prop. =20
> > >
> > > That's the theory, but do you have a practical example?
> > >
> > > What other planes and props would one want change in some specific use
> > > case?
> > >
> > > Is it just "all or nothing", or would there be room to choose and pick
> > > which props you change and which you don't based on what the driver
> > > supports? If the latter, then relying on TEST_ONLY might be yet anoth=
er
> > > combinatorial explosion to iterate through.
> > > =20
> >
> > That's a good question, maybe Simon, Xaver or Joshua can share how they
> > were planning to use this on Gamescope or Kwin.
> > =20
> > >
> > > Thanks,
> > > pq
> > > =20
> > >>>> I'm not sure if adding something new to drm_plane_funcs is the rig=
ht =20
> > way to do, =20
> > >>>> because if we want to expand the other object types (crtc, connect=
or) =20
> > we would =20
> > >>>> need to add their own drm_XXX_funcs, so feedbacks are welcome!
> > >>>>
> > >>>>    Andr=C3=A9
> > >>>>
> > >>>> Andr=C3=A9 Almeida (2):
> > >>>>     drm/atomic: Allow drivers to write their own plane check for a=
sync
> > >>>>       flips
> > >>>>     drm/amdgpu: Implement check_async_props for planes
> > >>>>
> > >>>>    .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 +++++++++
> > >>>>    drivers/gpu/drm/drm_atomic_uapi.c             | 62 =20
> > ++++++++++++++----- =20
> > >>>>    include/drm/drm_atomic_uapi.h                 | 12 ++++
> > >>>>    include/drm/drm_plane.h                       |  5 ++
> > >>>>    4 files changed, 92 insertions(+), 17 deletions(-)
> > >>>> =20
> > >>> =20
> > > =20
> > =20


--Sig_/uaSCk2iCuPC2HhY2IGqSpLb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmWnle0ACgkQI1/ltBGq
qqc0zRAAmsYLm9QbFAy7oGFE5ESCY1Ws0GyM7zBZ9ZbDTOGpyvJT5ShZzao3l/j2
sDO1wxeC7xW9KhHQGEmJlWMlG+dWv1pXimYEKV0DY5+6e+6WfGA1sGODtn9xKJKd
hFBnZqMnfvKLeowHBIt/00aJoyqwBXovoWyH59kAqSsh8TIKsyp7G5uwFtSHrJl7
wiOysCWzlY8db9onusa9LMBgLG+2K/wDm1PDpjUqKDGidY23CMvz+L2afZf92Hl9
zglYB4UrR9JAVBH88Bi6rhGVMKsidnLpNsPK07ZIvTU8dxlqU5Bxp6zKZmWIOSMF
weCqzq1CatqKo1WvMKU92rS8wQSSEa+TN0/9JIN8TbOb0k6UJwv3yxJ8VjjRPiV3
5L3TjjJOqLxzM4j5K4wS6UQvzY/lpecydBiTNesdniMdCpuNcX3TmAlF8zxJin/G
olK37BM0+4qeEuqRTbYrhDVzmfaASSEzY4i0AgT7Zkk+wYCYReQ0Z6o6wSN570V9
/H1dWPoQlD60lV/2ZPZTGRmLzo3KIgtrNMFqquuE2eIn02PkWSp78B/MORKAslol
EYqBIHM3+DBy5LZiA3kZGO0V1Gj1j4/eShzSxx7WoF0X4FIP5OhMd01AQir0n1B1
h1tk+5WRYgxVja8ZD3ZbySDboTrJw61iD5EFlLA537G9vBSwhRI=
=JhIu
-----END PGP SIGNATURE-----

--Sig_/uaSCk2iCuPC2HhY2IGqSpLb--

