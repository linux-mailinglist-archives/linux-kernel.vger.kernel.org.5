Return-Path: <linux-kernel+bounces-27409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42982EF90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABDC1C2342A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EC1BDC9;
	Tue, 16 Jan 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtKBiMqL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFE1BDC2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so11504250e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705410866; x=1706015666; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5HYLxVw6fM3ypadLsACTrsy4pVl4M83eVfP/j5l+MM=;
        b=FtKBiMqLVZNbfoTaHHqpeQXeOgYW00xtkFIQet7+LATUX2w6O79HRr9ONQ23LKrw8x
         HJ5EWoqLZR2+1sSix9CjDt5ZUNUseSLaU6BWChpNEHqM+AhBItGtCH2/jRdz9/knWgV1
         yrR21NwNnNfJA/SXmRoRRAL5omk8fbmFP4aGCBNYt1ZldYPJEinaBcY5ZkmuaA+KjL1j
         yTRNgB8fEzXPxxU8mLmfH/SJ6NGgdKiMABfNTlRkW6KDddlo2FOwyKR8SHahyGjywsrK
         8o7gh8mo60hRotMjTNS9+ijlDbAbvGg0xlFk6jfh4Fo3D0TPk7L3WaDZoo65ajA2Fbo8
         4jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410866; x=1706015666;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5HYLxVw6fM3ypadLsACTrsy4pVl4M83eVfP/j5l+MM=;
        b=O6PxI/+a3G3VJbiSJZutqtyhsjGcWS+VW0rEiTGrdgtFK1EqQUjGBsKPSOHDn9+/MS
         z2PIGkx29anhrpaaZMz+KQNh9gOikMeFDIEThhJ1RmcAzdrTCV06YBmzUGLHvtm6qHKS
         u0X4cAm7c1KJgz8uiGeCZqcYvFP5K5s1dEngThtVOMxhuGicsM0Af5xzRrYWxTshQyq+
         wQl8fV4fRAV3HJFGm2eUMRihHIlHRqJm7S8Hz9MqXx9wGr4FIhFw4lWrHIUPUFtxY5YK
         oplyZEHhGzg3M6TAnyMk+NWSORLra8p6dv7Z+Hd82MpUcZ2svDxKIAhDsTYUUCrBep/8
         NPFQ==
X-Gm-Message-State: AOJu0YyhiVbhuZ6LFTQzqSEy4xVx51j8vYvUMl08RUhegYkp108RFO8N
	ApLad1JNkEXJb722WcZfDSY=
X-Google-Smtp-Source: AGHT+IHYkDYUaH4R12WjJHu/IEaUkPCn6D0JlewBPNsBKwyAmM+WY5OUDQc/8qPQn00n0BWlGsKp1w==
X-Received: by 2002:a05:6512:3042:b0:50e:73fe:c4ab with SMTP id b2-20020a056512304200b0050e73fec4abmr3983941lfb.94.1705410865335;
        Tue, 16 Jan 2024 05:14:25 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512040900b0050e3615f608sm1750943lfk.209.2024.01.16.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:14:24 -0800 (PST)
Date: Tue, 16 Jan 2024 15:14:14 +0200
From: Pekka Paalanen <ppaalanen@gmail.com>
To: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Simon Ser
 <contact@emersion.fr>, daniel@ffwll.ch, Daniel Stone
 <daniel@fooishbar.org>, 'Marek =?UTF-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Xaver Hugl
 <xaver.hugl@gmail.com>
Subject: Re: [PATCH 0/2] drm/atomic: Allow drivers to write their own plane
 check for async
Message-ID: <20240116151414.10b831e6@eldfell>
In-Reply-To: <a6099681-1ae9-48ef-99bc-d3c919007413@igalia.com>
References: <20240116045159.1015510-1-andrealmeid@igalia.com>
	<20240116114522.5b83d8b6@eldfell>
	<a6099681-1ae9-48ef-99bc-d3c919007413@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i2t6EBxqq.bTAjLBweow2/Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/i2t6EBxqq.bTAjLBweow2/Q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 08:50:59 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Hi Pekka,
>=20
> Em 16/01/2024 06:45, Pekka Paalanen escreveu:
> > On Tue, 16 Jan 2024 01:51:57 -0300
> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> >  =20
> >> Hi,
> >>
> >> AMD hardware can do more on the async flip path than just the primary =
plane, so
> >> to lift up the current restrictions, this patchset allows drivers to w=
rite their
> >> own check for planes for async flips. =20
> >=20
> > Hi,
> >=20
> > what's the userspace story for this, how could userspace know it could =
do more?
> > What kind of userspace would take advantage of this and in what situati=
ons?
> >=20
> > Or is this not meant for generic userspace? =20
>=20
> Sorry, I forgot to document this. So the idea is that userspace will=20
> query what they can do here with DRM_MODE_ATOMIC_TEST_ONLY calls,=20
> instead of having capabilities for each prop.

That's the theory, but do you have a practical example?

What other planes and props would one want change in some specific use
case?

Is it just "all or nothing", or would there be room to choose and pick
which props you change and which you don't based on what the driver
supports? If the latter, then relying on TEST_ONLY might be yet another
combinatorial explosion to iterate through.


Thanks,
pq

> >> I'm not sure if adding something new to drm_plane_funcs is the right w=
ay to do,
> >> because if we want to expand the other object types (crtc, connector) =
we would
> >> need to add their own drm_XXX_funcs, so feedbacks are welcome!
> >>
> >> 	Andr=C3=A9
> >>
> >> Andr=C3=A9 Almeida (2):
> >>    drm/atomic: Allow drivers to write their own plane check for async
> >>      flips
> >>    drm/amdgpu: Implement check_async_props for planes
> >>
> >>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 +++++++++
> >>   drivers/gpu/drm/drm_atomic_uapi.c             | 62 ++++++++++++++---=
--
> >>   include/drm/drm_atomic_uapi.h                 | 12 ++++
> >>   include/drm/drm_plane.h                       |  5 ++
> >>   4 files changed, 92 insertions(+), 17 deletions(-)
> >> =20
> >  =20


--Sig_/i2t6EBxqq.bTAjLBweow2/Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmWmgSYACgkQI1/ltBGq
qqcJGhAAmfkcI63j+PXidMJLZ9COPIfRspF9wDzlPbiyZOH2nvffM9dDdNKWIm+j
8dMw6bbmp8/AjEdymqKUmqsI0u0G8/otViBEYHA5DPJTNZxmFDW5awvwPZo/86fL
i8jfM9XTDN637bQKorVUR+QEu/CXag/IH5R19YT5QSRfmKGwvfvOYKkdHwAoe29m
Zazcouunhbns8EeRQnxWrwFpn7+gQunM79AwaUt88CxyFFbpxN9t6iU0UThtNFnb
CYKjIwIvYsE3ncULhV47giKpd05tSP0yRDBdPCVgzZO80n16yzvtZDe3pzQGZd2p
4zxOzYmDlu8789qfQReCCzQWoAJ9Wn5H7o4WH09gygqbRtEhpaUbbjX+WQJVl5j5
WCyH2ezdqOSz6mGN1Un9t1thK9oE13fM5v/EdCj+DWUsJbUEeoMcI2ymcBoHWB9C
GSetbRreGTejPDnCvW7c5i4Aa1TxJHHuNWLeBH2MbjLIjzSE/TCBaSoyJr/lol1L
xkDBFD6fnIIK9aNzkAFLjHZDZU/xOz06JlG/CtEE4cOmXfWrm/3PCzCXBF2C5FZn
ppeC1BKzvDIlgA9+lwV+H1YIN7xAc4EDYbksjCWpQwmZAYTcfJrLv732nA7ysRdr
92k6OK5F8WoaaZor9qs2dIT6lUbUoATCzJnY2yoXNl6si+ERA3g=
=EpBy
-----END PGP SIGNATURE-----

--Sig_/i2t6EBxqq.bTAjLBweow2/Q--

