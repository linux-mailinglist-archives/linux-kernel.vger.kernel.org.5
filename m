Return-Path: <linux-kernel+bounces-44062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E9841CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499EE286554
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71053E1A;
	Tue, 30 Jan 2024 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL6du7hr"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690853E07;
	Tue, 30 Jan 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600767; cv=none; b=A335lqfk8nkLcb3ZVp6TwaPpSxSEFIv3azxLSOSwLX81nBTU+RQb5XiZGw4mMWzRAkMdwz7XH0C0nyxCY63s0Vui/mEpvNp+FgxycNw+o0mcb9P81SXGJeih0hCpXL4PgnVhQs37KOlwIWEXsm6/O4zVe73piTcrBGRmjDr4beo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600767; c=relaxed/simple;
	bh=AkGwsk78SYVj3QkKhupfNGuYhyJ3mkDX4xS2J2NQkPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LfCsAiJSODqui+wrFKFcoZ9TNeIpEolGjrfgc45YbQQ6MXieKE5HF+xXCnNx5z6/itY7UDv9QGLRSN/E5f1xeFiRLzL9PKP8OTUADORRo4eKV5NNZZdCQtwbz+t/e5KGfEDnc+HuJK+f73EM8lRwNlR16PYBjsBNuuvNqs3WI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL6du7hr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d8f3acc758so9288495ad.1;
        Mon, 29 Jan 2024 23:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706600766; x=1707205566; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIBszCx+QIzycUsQUzGrkuia87lRjitTl5A16QTacjc=;
        b=UL6du7hrpxkniAovUTYHV3o0VaZz7l0oIlkEVDAJ08PXGvHEVRfUVXakNb0cLlbk5J
         o0jIIJEVX40zGLxaigwQz0lVXXRrV6rnYu3mgr4FU2DRA649uH8a0KSVvpnFJHMEUHCw
         33qBAOyfOq65FOIxNCDcnb1ukpmIpo3DsB5cVmKGPVjN8Bi2Q3xlvk5u+UItH6qYuBFn
         iGqUb8lNk558yg+51PEKOuqzGpKYj0nCPjsDiORU57jtfPbMPg67s+eiSudW9vkMSKz/
         Q+pMy/LnlbXBW6RP/bSFDoFnwClHSF4XFh3FPEuy47AZxNzEmuPAIChQBxw22guwkVlO
         XLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600766; x=1707205566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIBszCx+QIzycUsQUzGrkuia87lRjitTl5A16QTacjc=;
        b=wibMLe148+oBs1pVuqIUAHb97aBAcbFVLEk3/oT2luUbpmqm8VrMLGvgYoa9WdmSAX
         ja4ItkT1KC6fZ5oEhmp11JvNy78Mw0si5Icy8q4BCfAdZREycA+elkotgy5kcLQc+oYI
         IA4QrGN3lSEcdxFpL9nQ6rPluL96BdV1dvuROSRmStru+0I84JeM5m6QHwKIJ3bjGFmf
         h/Do8CNZIAM2/HPd6d0+hls+acU2ufm55CjI7qk4BLqC6qszxhDnzRQnBQ8KVVv4JA4p
         O6ERPXv3YVdTV9IZDcbYMZYphSa02UITUcKhzOAtsAJyXYmwuu4i/H+lOS5mEa3MiROv
         St2A==
X-Gm-Message-State: AOJu0YwWw/88zTeCEV/HQT57wpweFrEQDMRqV5kZoPdNpEORkU65t5rU
	gg1wg+HuUvkEKnhxDRDvUkmscPTL8NfUkm0kAOZEKMERmUGNA0OrB4BlAuVtkR0=
X-Google-Smtp-Source: AGHT+IEYXgOLOU5Zo4xUkARpQNfTQH16+hQNmRSvBPhUlbJFQGcaNsfb+iHP67DVmMZVPRdobKxwtg==
X-Received: by 2002:a17:902:f544:b0:1d8:e5f9:19b0 with SMTP id h4-20020a170902f54400b001d8e5f919b0mr845318plf.30.1706600765640;
        Mon, 29 Jan 2024 23:46:05 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001c407fac227sm6511401plh.41.2024.01.29.23.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 23:46:04 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A78DA18638724; Tue, 30 Jan 2024 14:46:00 +0700 (WIB)
Date: Tue, 30 Jan 2024 14:46:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ma Ke <make_ruc2021@163.com>, Deming Wang <wangdeming@inspur.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Wang Ming <machel@vivo.com>,
	Eric Biggers <ebiggers@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: CONFIG_INET_{AH,ESP} say y if unsure - rationale?
Message-ID: <ZbipOApntQMw8q0S@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zL6UcHUWgrAwMc6"
Content-Disposition: inline


--7zL6UcHUWgrAwMc6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I stumbled upon CONFIG_INET_AH and CONFIG_INET_ESP every time I configure
my custom kernels. Kconfig description of each options says:

> Support for IPsec AH (Authentication Header).
>=20
> AH can be used with various authentication algorithms.  Besides
> enabling AH support itself, this option enables the generic
> implementations of the algorithms that RFC 8221 lists as MUST be
> implemented.  If you need any other algorithms, you'll need to enable
> them in the crypto API.  You should also enable accelerated
> implementations of any needed algorithms when available.
>=20
> If unsure, say Y.
=20
> Support for IPsec ESP (Encapsulating Security Payload).
>=20
> ESP can be used with various encryption and authentication algorithms.
> Besides enabling ESP support itself, this option enables the generic
> implementations of the algorithms that RFC 8221 lists as MUST be
> implemented.  If you need any other algorithms, you'll need to enable
> them in the crypto API.  You should also enable accelerated
> implementations of any needed algorithms when available.
>=20
> If unsure, say Y.

Yet, distributions like Debian ([1]), Fedora ([2]), and Arch ([3]) instead
enable both options as module, but I followed the Kconfig recommendation
above.

I was wonder the rationale behind "say Y if unsure" for both
options, and whether `default Y` should be justified or not.

Thanks.

[1]: https://salsa.debian.org/kernel-team/linux/-/raw/master/debian/config/=
config?ref_type=3Dheads
[2]: https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-x86_64-=
fedora.config
[3]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/=
main/config?ref_type=3Dheads

--=20
An old man doll... just what I always wanted! - Clara

--7zL6UcHUWgrAwMc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbipMwAKCRD2uYlJVVFO
o7bEAP47vu8LywxU4Q4VtItyckJTrKh/VznPmIw0wHdE0SkfcAEA4QZYjIFRSqAt
GLIgnj/wkkYth9LWWHkEe99fb3miXQs=
=S8O9
-----END PGP SIGNATURE-----

--7zL6UcHUWgrAwMc6--

