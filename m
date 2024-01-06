Return-Path: <linux-kernel+bounces-18577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E3825F96
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C621F22971
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9226FDD;
	Sat,  6 Jan 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYclDUZE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC36FB2;
	Sat,  6 Jan 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9ac5bd128so241618b3a.0;
        Sat, 06 Jan 2024 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704546169; x=1705150969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQBeH1d+zJfCWRGzF9Oem4ERzxHut3wyC+MBoVxDWQQ=;
        b=HYclDUZE4lQq4f4h837aDYmwqLuvqcJd9bFWCFFC/eLxj3jyCc8CfvZ1Eg74cacSZI
         48mMsj6t1acRrrZWeWntHo1a4EY8KtyicNErLZsf36A+gab5Bj9TuXoOCzImQ3ONrIJd
         U3X/jI3xynsO4Tj6HVS42m8+LSO8M3AWIZIzhXN5eSUO2WGkqloBBJ075+qBLZUOB//J
         vzp8cP4f9sHBV7v1bpdLqggeub9bXUIX2EY4UmiA3ZqyM3ZFUg12ZgJzO19KDCccQMuc
         Do2PikBEQDWGh/4OKospEjFxuPrbohrLibFunjUQFwRv/8WDXmwhv1BNV4lv2RxZodAi
         xE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704546169; x=1705150969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQBeH1d+zJfCWRGzF9Oem4ERzxHut3wyC+MBoVxDWQQ=;
        b=Pi65+R7iCcGByAg9dsje6oXw4EMj/F6CHjQHCCbRqWIL9ALoF8oV9CrlhxzLZKy2j9
         hUcaY4qoFHSKZU+jN134OUjSRt2777rr1hCRo3ECQTAxR+itUZmo8hwMzs5UoQCbnUvP
         McU8NpPUPbVREhpPLkuZNRuFirY35cjggLvf9MxV0nusxr1UHa5RqU/nrXJjgXRLcatc
         qJ9J9+hKpWyWhTxlyACFejoSyvqlfiUXDwdaAenHRfRPYtjxdjNv2edcCBjJKYKI+1OD
         Xz4fW0zbUPfGR2ZklP7SKi/eEE+WN8LBMCKIrOcZAsB/3zINt+FM19GoZUj57ln8Rfu8
         Jg+w==
X-Gm-Message-State: AOJu0YyJIm5ai6US9y3f7jNyDfDfA4Unvhy0CpaPvic2sprB783f1F3S
	QQ6GNnSIfpJYwWzhnA3YNCQ=
X-Google-Smtp-Source: AGHT+IEdumSoV1x2jgCJt7eZaRq2MSBeQHK5jlL4N1HppUb2XhTcwxeHOpybsXGEZFDAiiOfqO6QBQ==
X-Received: by 2002:a17:902:6bcc:b0:1d4:4c91:b8a1 with SMTP id m12-20020a1709026bcc00b001d44c91b8a1mr242284plt.129.1704546169105;
        Sat, 06 Jan 2024 05:02:49 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001cca8a01e68sm2988805plx.278.2024.01.06.05.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 05:02:48 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D6FE618360C56; Sat,  6 Jan 2024 20:02:45 +0700 (WIB)
Date: Sat, 6 Jan 2024 20:02:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Vegard Nossum <vegard.nossum@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: Adding warning icon to warning admonitions?
Message-ID: <ZZlPdfm3TLuhE10Q@archie.me>
References: <ZZgSGFhvT3SOI4fe@archie.me>
 <87edev3jya.fsf@meer.lwn.net>
 <ce59e493-59ba-4875-97b9-17dba71f8302@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iUcTUZ3yJ4DYOHba"
Content-Disposition: inline
In-Reply-To: <ce59e493-59ba-4875-97b9-17dba71f8302@oracle.com>


--iUcTUZ3yJ4DYOHba
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 07:12:10PM +0100, Vegard Nossum wrote:
>=20
> On 05/01/2024 15:59, Jonathan Corbet wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >=20
> > > For the icon itself, the approach is to use Font Awesome [2] (many ot=
her doc
> > > sites that uses Sphinx also do that due to site theme they use but Al=
abaster
> > > theme don't use the icon, hence this question). I personally prefer r=
egular
> > > icon variant (like in TT), but alas it is in non-free PRO plan (and o=
nly
> > > solid variant is free and that is what Sphinx themes using).
> > >=20
> > > Does adding warning icon like above idea make sense for the kernel do=
cs? And
> > > does it require non-trivial (complex) changes to Alabaster theme?
> >=20
> > It can probably be done with a bit of CSS tweaking.  I don't really like
> > the idea of requiring the installation of another font to build the
> > docs, though, and Font Awesome looks like it could bring in licensing
> > issues of its own - that's not clear from the site at all.
>=20
> You could use the unicode symbol as a replacement for the graphic by
> adding something like this to custom.css:
>=20
> div.admonition.warning p.admonition-title::before {
>         content: "\26A0";
>         font-weight: bold;
>         font-size: 120%;
>         padding-right: 8px;
>         float: left;
> }
>=20
> It doesn't look great to me, but maybe with some additional tweaking it
> could (e.g. text-stroke property, sizing, positioning, etc.).

Thanks for the tip!

--=20
An old man doll... just what I always wanted! - Clara

--iUcTUZ3yJ4DYOHba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZlPcgAKCRD2uYlJVVFO
o9x3AQDpOYH339ql4vuulf2QYL/kSJHNMCsDOh25N+HiAD/3rgD/eH4QGQ3bfAOI
sDoclp3RZUsgGtR3TNxP+OttHRSkswA=
=TcPt
-----END PGP SIGNATURE-----

--iUcTUZ3yJ4DYOHba--

