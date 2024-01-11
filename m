Return-Path: <linux-kernel+bounces-23696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517082B040
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BE1C23A32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52B3B780;
	Thu, 11 Jan 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkkHnibh"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692093B193;
	Thu, 11 Jan 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cedfc32250so2638454a12.0;
        Thu, 11 Jan 2024 06:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704981879; x=1705586679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwkQlPT3rMSnBVUPCXT1z+btzrKsyT0yeiCXmdDcEaA=;
        b=QkkHnibhkYE3Pbq+3FFDx1OUou6jUaGLMcx0huRhE0V2uZuAdzn0VK5C0e8ZcPITXg
         A+wDOvwE4MxCcntvP3/bp7nL9S1wZ0ekkSrBrPZDqw+30cSevcrCI42vkiW7cf+7PEIO
         CpK7+OZHAaDwF4jtJYr/oxVWjb5qyHLbmGHbv/FFPzvCxxJ0L+a4BwHdKePH7S/PwyIt
         1oXvHjty9aZag/LsPjJOR+f7cYtGCdBiGEV7nYdpQQn83dNrIJBbsxiawEoTTeYkm/AU
         SNJuAH06N+KVixUAY997JVNtnmVC/O2AXQb0i9caS2+4DxN/NWQv1jQsJ+cvSbWmCAiW
         XUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704981879; x=1705586679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwkQlPT3rMSnBVUPCXT1z+btzrKsyT0yeiCXmdDcEaA=;
        b=fmHRdx50NhvJTivbQmetJyNfayOuw4zGLtVxJ90vZW80yV/SiE/hVOrCTIu576tpIW
         ro0DW8AvtaKbRrJdk9XKNX1V2z4YfRw4avY/ifaVWNoNYEaCvoivnlQGEq3CfkRfRD6y
         arEKBtiIxKQad2w7RNYiajeGOPWu94XAlU5JfX72F0bsazhJZgm0VN/8o6wLIdzPgIyT
         4C65pYA/RwMjnrtjS6AqRGzP/pdSjBxtBL29bnTvUxj/hgoAlDt9IW1HqJPdKbWZhuNs
         upRmwo8UNhZVkEx3k+/0axUC1bFqTPVuP0hHwxWVPpnw93CaqmJqgxglZfJ90RPTmN+f
         9nqA==
X-Gm-Message-State: AOJu0Yz3YlYECxR46tm6Lg8Jw733d+kOLyazx9fK4axyHppDNzdZFG7v
	psYw/Ms44p5VsoWruzTxkQ8=
X-Google-Smtp-Source: AGHT+IF586UDHQQc2eEUbJe6b10ZbgDf7M3gajntVHWrbfiTL9vxRrpV4cWw5zjIehhxlSTu9FMd6A==
X-Received: by 2002:a17:90a:cc0a:b0:28d:add8:b687 with SMTP id b10-20020a17090acc0a00b0028dadd8b687mr887909pju.44.1704981878337;
        Thu, 11 Jan 2024 06:04:38 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902778c00b001d4160c4f97sm1183286pll.188.2024.01.11.06.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:04:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1E7D1184790E2; Thu, 11 Jan 2024 21:04:33 +0700 (WIB)
Date: Thu, 11 Jan 2024 21:04:33 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Vegard Nossum <vegard.nossum@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
	Attreyee M <tintinm2017@gmail.com>,
	Adam Turner <9087854+aa-turner@users.noreply.github.com>
Subject: Re: [PATCH] Documentation: sphinx: Require alabaster <0.7.14
Message-ID: <ZZ_1cflRM2jo22on@archie.me>
References: <20240111102128.37192-4-bagasdotme@gmail.com>
 <50045aff-91f9-4809-ba3e-b722b325d233@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L2BJbRGut8pyO475"
Content-Disposition: inline
In-Reply-To: <50045aff-91f9-4809-ba3e-b722b325d233@oracle.com>


--L2BJbRGut8pyO475
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 12:18:44PM +0100, Vegard Nossum wrote:
> On 11/01/2024 11:21, Bagas Sanjaya wrote:
> > Alabaster commit 640273fd3ca7 ("Drop support for Python 3.8 and
> > earlier") [1] bumps minimum Sphinx version to v3.4, which breaks
> > htmldocs build due to version incompatibility with Sphinx version used
> > in Linux kernel documentation (v2.4.4):
> >=20
> > ```
> > Sphinx version error:
> > The alabaster extension used by this project needs at least Sphinx v3.4=
; it therefore cannot be built with this version.
> > ```
> >=20
> > Fix the build error by requiring alabaster version less than 0.7.14 (in
> > other words, at most 0.7.13).
> >=20
> > Link: https://github.com/sphinx-doc/alabaster/commit/640273fd3ca7cdc152=
8c591172fd9cce2ead911c [1]
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >   I'm noticing htmldocs error when trying to build current master (stil=
l in
> >   merge window). Is this patch OK for 6.8 material after v6.8-rc1 is re=
leased
> >   (as stabilizing fix)?
> >=20
> >   Documentation/sphinx/requirements.txt | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphi=
nx/requirements.txt
> > index 335b53df35e22f..b2ca7432437518 100644
> > --- a/Documentation/sphinx/requirements.txt
> > +++ b/Documentation/sphinx/requirements.txt
> > @@ -1,3 +1,5 @@
> >   # jinja2>=3D3.1 is not compatible with Sphinx<4.0
> >   jinja2<3.1
> >   Sphinx=3D=3D2.4.4
> > +# alabaster>=3D0.7.14 is not compatible with Sphinx<3.4
> > +alabaster<0.7.14
> >=20
> > base-commit: de927f6c0b07d9e698416c5b287c521b07694cac
>=20
> Note: I submitted almost exactly the same patch yesterday:
>=20
> https://lore.kernel.org/linux-doc/20240110104646.3647600-1-vegard.nossum@=
oracle.com/
>=20

Oops, I didn't see your patch before I submitted mine. Thanks anyway.

--=20
An old man doll... just what I always wanted! - Clara

--L2BJbRGut8pyO475
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZ/1bAAKCRD2uYlJVVFO
oy3oAP9GYFmuXacSSlb14NeuB+XhxDnep0fl0SrVFtmbzVDL7gEAwM5XgEn1Xb3N
0CQwjNNN+Mz2PMDM1r9o3GSn8LYcKgo=
=gEdX
-----END PGP SIGNATURE-----

--L2BJbRGut8pyO475--

