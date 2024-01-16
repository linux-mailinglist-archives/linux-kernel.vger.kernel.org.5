Return-Path: <linux-kernel+bounces-27198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04282EC13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C681F22FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB917BB0;
	Tue, 16 Jan 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKhV3XY7"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD401756C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so10113260e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705398326; x=1706003126; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=At3B4QtrmUgiNbmYWMG1cCFn3JGTUgYF5xXfwvD36po=;
        b=EKhV3XY7YIbGSyXsEfe5wVEGHQjlkAlHYPz71ysfymWWP25O/Dbhx68QsjZ4Mqv+vn
         svFf8agoVHIBNeJ/h2hFKlAC9NknoS22ZbuqBE9I1RKhin2ubZ6qpuCyMc/orsW3bZnO
         /aw+Nn6O77CFnfmiB6wc7KbRM01+bjLmLyOlTOgrNzeGwJuzW/gT7nTTaiI5X/p236qi
         STRfbZu0bkdpxGB0SvrBIXuTvda9XVIuFRq1Mv929z2vf7jhbcY166db0ZeTB5hHrmdL
         yeg5DuuY+709Ff6be/jchLymKJJOcjzOmDqbq1tBreU5PsmhHdSJlLY4yksAogeUypzR
         q20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705398326; x=1706003126;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=At3B4QtrmUgiNbmYWMG1cCFn3JGTUgYF5xXfwvD36po=;
        b=OArSwxE4y9gaqEfSdTFoaNxQfgNoKsGwOiMFAlpAOw8qpoK2PpP8gVxrmyhry//mY1
         Myh2ituHnEikZPZNf4w2wR+a4omEesc9sqMuzN6n9Xm/6WGyWFbwEPJPLln3zGIF0TuI
         BjmYMCvSsptDqRpl22GZehUUKS7CiKn1bo422wxqck8HMZpfBTTQIHa7dqJqpQWTnvQZ
         eWzg+Ap9OQDc48YHDRtdnqLc3DzNhInf0hJQ1zD3HPU8e855mZeZQRmsgPJEK7NeBCe7
         tr4BHqBN7rgKVPIcCDhlGTOXkA9l30ZcCD+6DULV6y6u5WsJ39ICZNWOFgVNVdH7g/Yb
         HEvg==
X-Gm-Message-State: AOJu0YzJtUY4+3fYLGjbZTa2JP6OoOqs3Sb1UFmnLOJiY4xLpoMr90D9
	Lk2CjZ746FCy/7OLXh+VmB0=
X-Google-Smtp-Source: AGHT+IFyMG7eYvg8LSV5tNpbngAXDBcufgSyuhCwNWX2XrqZTzxCIqdYkVwV4ZdSUCFyqvwg2OriXg==
X-Received: by 2002:a05:6512:2355:b0:50e:a431:de30 with SMTP id p21-20020a056512235500b0050ea431de30mr4479968lfu.6.1705398325438;
        Tue, 16 Jan 2024 01:45:25 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id a6-20020ac25206000000b0050ee78fd23esm1404395lfl.262.2024.01.16.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 01:45:25 -0800 (PST)
Date: Tue, 16 Jan 2024 11:45:22 +0200
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
Message-ID: <20240116114522.5b83d8b6@eldfell>
In-Reply-To: <20240116045159.1015510-1-andrealmeid@igalia.com>
References: <20240116045159.1015510-1-andrealmeid@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qpm4_L9s_xn4TQueKpnXLKx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Qpm4_L9s_xn4TQueKpnXLKx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 01:51:57 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Hi,
>=20
> AMD hardware can do more on the async flip path than just the primary pla=
ne, so
> to lift up the current restrictions, this patchset allows drivers to writ=
e their
> own check for planes for async flips.

Hi,

what's the userspace story for this, how could userspace know it could do m=
ore?
What kind of userspace would take advantage of this and in what situations?

Or is this not meant for generic userspace?


Thanks,
pq

> I'm not sure if adding something new to drm_plane_funcs is the right way =
to do,
> because if we want to expand the other object types (crtc, connector) we =
would
> need to add their own drm_XXX_funcs, so feedbacks are welcome!
>=20
> 	Andr=C3=A9
>=20
> Andr=C3=A9 Almeida (2):
>   drm/atomic: Allow drivers to write their own plane check for async
>     flips
>   drm/amdgpu: Implement check_async_props for planes
>=20
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 +++++++++
>  drivers/gpu/drm/drm_atomic_uapi.c             | 62 ++++++++++++++-----
>  include/drm/drm_atomic_uapi.h                 | 12 ++++
>  include/drm/drm_plane.h                       |  5 ++
>  4 files changed, 92 insertions(+), 17 deletions(-)
>=20


--Sig_/Qpm4_L9s_xn4TQueKpnXLKx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmWmUDIACgkQI1/ltBGq
qqeVeA//crRWJQuEXHaVAo60Oo43iWZpDJ9PFF6fFN4a0ez+KAFPjNRNo21jRuSw
waL6xm/WyX46I37DXUSRZHiDD8pOrZ+/VBxoT47EWsNpCJE3muJFsLQq1Wt+htwE
wL1rludAND0O63+sY4TGsyfR6EWNUg81teQoVZT+kEKDoxsJ+7eKDIgf1s7vKzT1
lv5thV2FTEAHD8zcnWons4bKpARIdtq0ZFbnkC0ycV9RzctH2ZxTgARts16DU8e9
5QmJEOYf1POkwHOCZoioBiejixLy9jPHuUw2i4ZIu07nuPncXnxMxXRPi5Y8zzJD
t6X2rHBwo/ZFBlcNdXiIRCUiPoV0POeKm2Q3mjicpn+AsR6abbVoR6oNOis/SrTL
jrQQ7BtP5lXCUSrsMrNErXiDwKnXkgg4ewI59HpJ7aWSrt6gXr19votpVACAeemM
aTVBVdPHZxr3fdUlVOHhPqrq2+bHDU3sld6or2da8hZ1sMUNYNe1z31h55FiUpEH
HL4IQ3EsqFeJbsq/3VrVY3V7PCYwSHYQb4ULl1MwqWai/oqQYgrFqTOjqcpGDq/P
yXyyXWLJD7OVMkhSATZuvzow2zBYpMm0dPdYhOPSOQmKraIvvs/Sj4AkTga7Q9Jz
cm3FWB4qP9H+6qBlk/coEue22ncdunJTApcIh/SI8AA0n58Dhz4=
=GGuB
-----END PGP SIGNATURE-----

--Sig_/Qpm4_L9s_xn4TQueKpnXLKx--

