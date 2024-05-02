Return-Path: <linux-kernel+bounces-165880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B98B92DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5053DB2218C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E4C8F3;
	Thu,  2 May 2024 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3yKvZhk"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A910F4;
	Thu,  2 May 2024 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610341; cv=none; b=VvsP95Xu9F6zI5GoPNxlyVwABFYxLce51L3dsoU6xASLvEmDIEZP2v+noLL2wLK8+/7OuuJdaQyi2auY+WO3yOx629pBApJJVUySgMnYjssy7/BDzBSyQwxUP1S/MnYSK4qwXDoHQt0iqSy7QCBiOGVpTxQfvxeGiceKxzNN6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610341; c=relaxed/simple;
	bh=TZ8+VDr69gDyqoGIFAry3J35ioYRKCi9wmOmJrkxuMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owPMtgKLM+ujZIibY6g131KEDM5xZ5b94gycaJqUVb2VHnAJVi1/F9s4XsxpjWF37J/hfAkgk71myG38C3m9GSG+OilIZ0COGGo5p49o7wvLfT2mm+WGtlW/lnZ/XGhYHnZqqPEQMDl+n84nO8If7RC0KRM3KZrBZQdjMQgWOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3yKvZhk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e5715a9ebdso61744265ad.2;
        Wed, 01 May 2024 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714610339; x=1715215139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9m2b0o1wK+T/Fvt5ffh+ydSyFh99r4onqUVu9qct9So=;
        b=N3yKvZhkslZ6PacQ8zShhP3jcicINluOYafhzq2OurktYHzKI2XUgLRiuDilR9Ldtr
         /LziquDSqeTQEvCknF++uAhVJ1S3AtZT+7Nx/6Lr5N/ll84p3w7oZeY2Mlb9F49OCatH
         YaPs//FomEcMoO+3pLPv25ysGmZg4SxFpllAbZMxH3q0HItcURriPkJY3fPyU+mbq0Rh
         lDc984/c5MufDYDTvZnJV2oe8MJE4ZeNe97lS3abufyDo3KVW0jdz0F1mr6V62vfvbc+
         p3gA58T83CeZyn/R88vixRWeNPSzhAvtWiE61tbiVkTTNdPPcYMFndgNwEOvWW+XTMkX
         a1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714610339; x=1715215139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9m2b0o1wK+T/Fvt5ffh+ydSyFh99r4onqUVu9qct9So=;
        b=hZXaDGBjI9UufkQWSVkfrejARUuCRx494dSygvKHQ6Rkl/broAWB8UJ/i5YPE9sbJl
         THcZmG63yrSD0a/govLkjUKPpp1WNcvrnKf8j7EpxgI2JF2T+ASQxqgZUxh54vbprVLE
         eYXchmAQJ8LMl8aGPvlCQsaIHVsHM+ZNGuvbLA1GyXqZQW8i9palgrQkRRARUOFG3QnE
         dc1qcxXKeoufqlVEzrlBKYq/MO5H7LuFm/XkIuSz750VliYHadMZQZ+iEyVTjx+SdoRb
         FhkWjKQ1t41+E+SSxRLkmlu3HrnxgwAegsUfDdJ6zDVIsAbYgxD3xY3YRK7MEf0eQewk
         QwHg==
X-Forwarded-Encrypted: i=1; AJvYcCVgkHFRPY4klIegnpNSsbgUe74tpvzTssIrsa/fSNbVbMu+WwzYFhol9xfujyxaruWXYt2JFY3btZMG4MoscF7Ikmz+3ASmnihGD6gBDEf4pAzdsIKTBDYtev5ms22th9HfYJpDXcEGNGNQliQE
X-Gm-Message-State: AOJu0YxztAMviaRx170sNVacSietoAcVMzSGiw4Ib50AvQiLWG5Dis5H
	3Y843mje3dZRbUy6JDNPeQabpfxt68fMLD4+UbFHzMZVq1LWS7sX
X-Google-Smtp-Source: AGHT+IEAe/HHub1ei86S9CG+gD2y0pj6R5pixPjFuAsWbmobQR4b3cECCFFHCDRgF/Z/lgPVgYg1yQ==
X-Received: by 2002:a17:902:e751:b0:1e3:cf2b:7151 with SMTP id p17-20020a170902e75100b001e3cf2b7151mr5014419plf.59.1714610339215;
        Wed, 01 May 2024 17:38:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001dd69aca213sm24542053plt.270.2024.05.01.17.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 17:38:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 051D418462B26; Thu, 02 May 2024 07:38:56 +0700 (WIB)
Date: Thu, 2 May 2024 07:38:56 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Saurav Shah <sauravshah.31@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Mao Zhu <zhumao001@208suo.com>,
	Ran Sun <sunran001@208suo.com>, Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>
Subject: Re: [PATCH] Documentation: tracing: Fix spelling mistakes
Message-ID: <ZjLgoMzTsyFoR03R@archie.me>
References: <20240501233659.25441-1-sauravshah.31@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+qpWXA4C62hzXlBX"
Content-Disposition: inline
In-Reply-To: <20240501233659.25441-1-sauravshah.31@gmail.com>


--+qpWXA4C62hzXlBX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 05:06:59AM +0530, Saurav Shah wrote:
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fp=
robetrace.rst
> index 0f187e3796e4..b4c2ca3d02c1 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -74,7 +74,7 @@ Function arguments at exit
>  --------------------------
>  Function arguments can be accessed at exit probe using $arg<N> fetcharg.=
 This
>  is useful to record the function parameter and return value at once, and
> -trace the difference of structure fields (for debuging a function whethe=
r it
> +trace the difference of structure fields (for debugging a function wheth=
er it
>  correctly updates the given data structure or not)
>  See the :ref:`sample<fprobetrace_exit_args_sample>` below for how it wor=
ks.
> =20
> @@ -248,4 +248,4 @@ mode. You can trace that changes with return probe.
>               cat-143     [007] ...1.  1945.720616: vfs_open__entry: (vfs=
_open+0x4/0x40) mode=3D0x1 inode=3D0x0
>               cat-143     [007] ...1.  1945.728263: vfs_open__exit: (do_o=
pen+0x274/0x3d0 <- vfs_open) mode=3D0xa800d inode=3D0xffff888004ada8d8
> =20
> -You can see the `file::f_mode` and `file::f_inode` are upated in `vfs_op=
en()`.
> +You can see the `file::f_mode` and `file::f_inode` are updated in `vfs_o=
pen()`.
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.=
rst
> index 7e7b8ec17934..5aba74872ba7 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1968,7 +1968,7 @@ wakeup
>  One common case that people are interested in tracing is the
>  time it takes for a task that is woken to actually wake up.
>  Now for non Real-Time tasks, this can be arbitrary. But tracing
> -it none the less can be interesting.=20
> +it nonetheless can be interesting.=20
> =20
>  Without function tracing::
> =20
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kp=
robetrace.rst
> index a49662ccd53c..69cb7776ae99 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -74,7 +74,7 @@ Function arguments at kretprobe
>  -------------------------------
>  Function arguments can be accessed at kretprobe using $arg<N> fetcharg. =
This
>  is useful to record the function parameter and return value at once, and
> -trace the difference of structure fields (for debuging a function whethe=
r it
> +trace the difference of structure fields (for debugging a function wheth=
er it
>  correctly updates the given data structure or not).
>  See the :ref:`sample<fprobetrace_exit_args_sample>` in fprobe event for =
how
>  it works.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--+qpWXA4C62hzXlBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjLgoAAKCRD2uYlJVVFO
owHbAP9QPvQUjv50nrdmOPTbYojD5JzZT+xPeihn8CgadhePkwD/eExr1FkI5Di9
hrmTqwY12CpSjjyeFpuelUeEKpw5LQg=
=TxGH
-----END PGP SIGNATURE-----

--+qpWXA4C62hzXlBX--

