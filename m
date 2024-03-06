Return-Path: <linux-kernel+bounces-93974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950158737B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B931F1C21968
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59534130AFC;
	Wed,  6 Mar 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6CNpEuN"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E9131720;
	Wed,  6 Mar 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731629; cv=none; b=JlJHA03Auhrp7Mv/ONis8P1HJQmOwYNACdYJl2sEs4a/L/Oe1BcOKkOoehU/W2bAKJ01A47/HGWCVsaH3GUUEz1UORJuld+RM5nkXJ0fUbyV1cPCZ7hOyGc+3FyXHmpNsu82fNzUUgOiwPfuMy0DhnlgE9k3EO2WhhlLHXLmMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731629; c=relaxed/simple;
	bh=+sPm+oKCXQGcQ9Lw/Yo0t+Ryp5HfmG552sHNArAQGDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOxlD7Pm6dkk2zwVgnZqDwbJKkfkwh1X+DKJD+kTfP8aFk6aw+zmX/GFeV7NI1Vkyb/cr/VjUVWFyaeqL7UM50NTB6YnOiKsyHCr0zLgQPo4WAu/Nk/JIQQHzwfy6fEVDE+w8F1ycB1vRM23RACGCYagY5CYctBIqfOsYu/xkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6CNpEuN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dbd32cff0bso58555285ad.0;
        Wed, 06 Mar 2024 05:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709731627; x=1710336427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiLQ/Gwlknvzeh2DwRC01mhrnxKX+BxC7evLtK7aSHk=;
        b=O6CNpEuNynMXFhVrUVE+esfKEaZik87vlfFsj5rH0RWolbce4aRS6D0b8+U4mikLsY
         S9khQXVsOOboQtUZZ8piRTUJ7sszbvuCBYnIWACGrC4tNkp0bLyIBufR7JTtBik+bkgQ
         yt5e9fxc619wmlHXzqTSySZ3ppTLDFrSVRUNKr8oMX967VeGTjCL/zM2Cx/Ujw5XznL5
         YCDp1kbZVK5E4beOrqwvy5M++lJZpCyMShFTnyZQzLSDqzoDGhwALLqdpXf6dibnjl26
         zIRc5f96xs+jNkM++eSGzcPx/2Vz9RAH8qT91voAl5pGrR1Efd2A9pInUfCZcxaPuxYX
         ReRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731627; x=1710336427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiLQ/Gwlknvzeh2DwRC01mhrnxKX+BxC7evLtK7aSHk=;
        b=EjbXUeFPV8ZWuzeg/uwVJIleZeQnHOUyz9oVdN3DMOgxY+mzlZhbbPAIQummlXCsvz
         YSm5i7jTuvMKTSYpqs5VjIGpVMsjb7CJk4l7C5jFFnV1t7A1ez9+NvL3iyT49MIoEpIR
         DvT6sApGiFTpTd4bLht3+NyPqUJbiCSCJWmJktzBN6m0iFCU2MtKukRnDQus+EkaZFqt
         70+FzWREHyHSsimsTzLFL4bEfAPJ7ftkKH3fCcOGdAPWoPfZ74fHUe5/uyW7mqLUmUz6
         OWn6NYOs3qt4l2R1z4P+lgjGZwR6RLpwHw7A1W1eTEtz4o/SONGWqCT5cenjjNOEpNMg
         xnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU88h7W1eryUafyfnRcJvqY0Dt+7RfigxYUGzZOcJfZtmG5QLJBXlXiaUV6wWyt6+0zVL9V32uLjqeRqLDiBfmj1V9pNWsj3bTJsLq6zv3PHqnKmN7wlF5NnPY+GZ7U2k9+P2kQlBT
X-Gm-Message-State: AOJu0YwuaLfWlTOOb2u63YqFIAODmRE05mf4u+mj95yJeeTve8rlIEoV
	/jVx8EbwAvzRtbt6JCpqXcTZX9j4O4hxTjwGIEqMtzAOsbKxOBFK7MKSpANcDUo=
X-Google-Smtp-Source: AGHT+IGbzpjggy4PP+k4v7TS6DtV6f8SDz9RQOR92oZBLAFBg7AXN3v+tlMA5JaLtbGxDD0Ip5wRKA==
X-Received: by 2002:a17:903:1cf:b0:1db:fd4e:329f with SMTP id e15-20020a17090301cf00b001dbfd4e329fmr5516641plh.15.1709731627409;
        Wed, 06 Mar 2024 05:27:07 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b001da105d6a83sm12473865pls.224.2024.03.06.05.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:27:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E12A918163A92; Wed,  6 Mar 2024 20:27:02 +0700 (WIB)
Date: Wed, 6 Mar 2024 20:27:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v1] docs: verify/bisect: fixes, finetuning, and support
 for Arch
Message-ID: <ZehvJv3fDZIPs9Kc@archie.me>
References: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lazs5xFE0/5FrnVE"
Content-Disposition: inline
In-Reply-To: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>


--lazs5xFE0/5FrnVE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 10:21:12AM +0100, Thorsten Leemhuis wrote:
> diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions=
=2Erst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> index 54bde8bac95c67..58211840ac6ffb 100644
> --- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> +++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> @@ -192,8 +192,8 @@ will be considered the 'good' release and used to pre=
pare the .config file.
> =20
>         sudo rm -rf /lib/modules/6.0-rc1-local-gcafec0cacaca0
>         sudo kernel-install -v remove 6.0-rc1-local-gcafec0cacaca0
> -       # * Note, if kernel-install is missing, you will have to
> -       #   manually remove the kernel image and related files.
> +       # * Note, on some distributions kernel-install is missing
> +       #   or does only part of the job.

Consult documentation of your distribution for how to manually install/remo=
ve
the kernel.

>  Install build requirements
>  --------------------------
> @@ -1076,72 +1078,103 @@ about to build.
>  Here are a few examples what you typically need on some mainstream
>  distributions:
> =20
> +* Arch Linux and derivatives::
> +
> +    sudo pacman --needed -S bc binutils bison flex gcc git kmod libelf o=
penssl \
> +      pahole perl zlib ncurses qt6-base
> +
>  * Debian, Ubuntu, and derivatives::
> =20
> -    sudo apt install bc binutils bison dwarves flex gcc git make openssl=
 \
> -      pahole perl-base libssl-dev libelf-dev
> +    sudo apt install bc binutils bison dwarves flex gcc git kmod libelf-=
dev \
> +      libssl-dev make openssl pahole perl-base pkg-config zlib1g-dev \
> +      libncurses-dev qt6-base-dev g++
> =20
>  * Fedora and derivatives::
> =20
> -    sudo dnf install binutils /usr/include/{libelf.h,openssl/pkcs7.h} \
> -      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole}
> +    sudo dnf install binutils \
> +      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole,rpmbuild}=
 \
> +      /usr/include/{libelf.h,openssl/pkcs7.h,zlib.h,ncurses.h,qt6/QtGui/=
QAction}

IMO qt packages are for people who wish to do xconfig instead of menuconfig
or nconfig.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--lazs5xFE0/5FrnVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZehvHQAKCRD2uYlJVVFO
o8QAAQDL2QAo686CyoAn0M4a/QzWk42pLsA/+Yxo1q8pRmmQ8gEA9v12OA9wft3g
ear6xki6AjucstJTnmst30tNIF03OAo=
=mmbI
-----END PGP SIGNATURE-----

--lazs5xFE0/5FrnVE--

