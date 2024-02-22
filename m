Return-Path: <linux-kernel+bounces-75984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D385F190
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047BF1F22B30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CA101C2;
	Thu, 22 Feb 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFGxZum4"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA77469;
	Thu, 22 Feb 2024 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584122; cv=none; b=AdzckGnBk/d1zlt5hEkwTCecmXQ8aaY356ejBHJ1JavXVYVh0gZtgs9BAYd3PWFSI6ntzMX728StRxAFmxougfXWq2dPdFgqpPfKmnlqFEgCR6KbJXd9/rka44oNsHt87R/OOk9Md7SY4DjOPIS3EqV00aF7GQiBeNmU0aAtjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584122; c=relaxed/simple;
	bh=J17X2fBxQ1cxsLJfPGVRLC571YnOIdb1/QJy66FmZRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i2RSPVObxZfo6D52PrHWxIObT+VOI/IwMtcFDhHw+CNdaSjgPVdLkervyWZeuyVzLiMS/qVatr3ZesvCU7hF2KWf8qS2l9kFpf9DhRoga2ON2Psjn+k9GuvvoK1xQ8k8nDBvgYVFxrMJWLUVgFDxQs0GHwAxiUVEzvE1miJbLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFGxZum4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299e4b352cdso1816715a91.0;
        Wed, 21 Feb 2024 22:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708584120; x=1709188920; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J17X2fBxQ1cxsLJfPGVRLC571YnOIdb1/QJy66FmZRc=;
        b=PFGxZum4XgxU8gIk6wkbnOSSgEjatcl2/lyGve22z7ts6IyEd/mqP+qEsmhV2P4NeE
         CCCcXkCltc8KdX/5cyPLZbV7RkAz69gcYy/78QsvXWPQVB7mHweyAdGZ7n8kRIj4x6Z0
         4F6CC7eNNRMTiyDKNErDCdqoFnmTrKAzkwqPmznwMjVgCKFFXYJzS7uWY9/Xevhlj8Tf
         SWPkKUv3aF4O/BX1FzwDb0LJ4OTI2fZPRawoBjPVVupdfKLV9PbKx6JfZ6VYu+V1eqma
         uzQjYTF6TPRnmeNvKfm9zqVYcv0VDbFyX9P35HszfvFMNfNqFTQ5aZKQUNATjxUETsyg
         fcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708584120; x=1709188920;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J17X2fBxQ1cxsLJfPGVRLC571YnOIdb1/QJy66FmZRc=;
        b=ZeLZPHtJnFCCi1iXZsCBhFk5SMJ1G7QWgoy9vW29VN5QcUBV7ze4tqJoPcvydlLFWk
         rvo/H2cnp4uBVgRcmjJoarMQSPKAjyLk/g3riOVMQhOFQBtxnYPtHtRQaOezvsi1saaJ
         5kFibiBdeAy1HBPNa/COakl1wqoziLb0pWsWCKNsbLHNh8sU7OqTQ7W0bXIP6ArDBHa7
         6LTXYOxIVIU3aCUGDMn0vS9PI+6ar7QtJMnTdkLyim2fSTz+xZxSjFo98I8W3D53GD3h
         1UpHVuEje2Vft+8JKp053O7VrDzbRCQDHx5/g/5arfgwd3Tn0+bYba+l6MZvg/oWEd89
         hZbw==
X-Forwarded-Encrypted: i=1; AJvYcCXwv+I40K6l6EEU7jEOxysrhZMcuRqDcR/or9lKUlPN9ucZ86qUWqERMatvuhccfC9qyriSVkuviFynEGv4r+uCumF9Nw2dri19sp6T4QXgSCZtubsh
X-Gm-Message-State: AOJu0YyuVnNWww3fK91ELznLlTf4d9jY/THZ/6QaqNRsHLKDqbhtCz/f
	T0s3oEms/3L+NgTpVtu17OlxuukjmQBHIIOmul7jko7w0+hxikhh
X-Google-Smtp-Source: AGHT+IFNdst8YpA7UlBoxrtkXY44+qmfRxyM/UNjZ+zqbHALDY2Qvssh+kpwN8fcAzukd4cx6Nqc7A==
X-Received: by 2002:a17:90a:bd09:b0:299:281:e1b2 with SMTP id y9-20020a17090abd0900b002990281e1b2mr16365685pjr.30.1708584119879;
        Wed, 21 Feb 2024 22:41:59 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id bx12-20020a17090af48c00b0029a4089fbf0sm919060pjb.16.2024.02.21.22.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 22:41:59 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 4AE3D1830534E; Thu, 22 Feb 2024 13:41:57 +0700 (WIB)
Date: Thu, 22 Feb 2024 13:41:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Security Module Subsystem <linux-security-module@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Theodore Ts'o <tytso@mit.edu>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ali Polatel <alip@chesswob.org>
Subject: TOCTOU-free exec(), chdir(), open() with O_PATH sandbox emulation
 support?
Message-ID: <ZdbstX5p4M_-RjXC@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MO7InTU0UHS36JK5"
Content-Disposition: inline


--MO7InTU0UHS36JK5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Ali Polatel <alip@chesswob.org> opened feature request bug on Bugzilla
regarding TOCTOU-free sandbox emulation support [1]. He wrote:

> Thanks to the addition of seccomp_addfd, now it is possible to emulate a =
vast number of system calls to achieve a TOCTOU-free sandbox in userspace. =
There're however three exceptions to this:
> 1. exec family calls cannot be emulated so a sandbox disallowing exec cal=
ls has no choice but to continue the exec call in sandbox process allowing =
TOCTOU.
> 2. chdir family calls cannot be emulated so a sandbox disallowing chdir c=
alls to hide paths has no choice but to continue the chdir call in sandbox =
process allowing TOCTOU.
> 3. open calls with the O_PATH flag cannot be emulated (addfd returns EBAD=
F on o_path fds) again a sandbox disallowing open calls with O_PATH flag to=
 hide paths has no choice but to continue the open call in sandbox process =
allowing TOCTOU.
>=20
> It'd be awesome for the kernel to provide TOCTOU-free ways to sandbox the=
se three cases.
>=20
> For a bit of context, I am the author of syd, a seccomp and landlock base=
d application sandbox with support for namespaces, you can read here about =
why this feature request is relevant and more: http://man.exherbolinux.org/=
syd.7.html
>=20
> To quote the relevant bit from the manual page:
>> BUGS
>>=20
>> In the operation of syd, certain system calls are not fully emulated due=
 to seccomp(2) limitations, resulting in the sandbox process continuing the=
se calls directly. These include execve(2), execveat(2) for execution, chdi=
r(2), fchdir(2) for directory changes, and open(2) operations with O_PATH f=
lag. Consequently, this behavior exposes vulnerabilities to time-of-check t=
o time-of-use attacks, allowing for the circumvention of Exec Sandboxing to=
 execute denylisted paths, the bypass of Stat Sandboxing for unauthorized d=
irectory access without disclosing directory contents (owing to getdents(2)=
 call emulation), and the detection of hidden files without revealing file =
metadata, as stat(2) calls are emulated.

Is the feature request viable/realistic?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218501

--=20
An old man doll... just what I always wanted! - Clara

--MO7InTU0UHS36JK5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZdbstAAKCRD2uYlJVVFO
o6t8AQD79KsszDwGub+XNmsGyw95WsE0YmAkVahpYrYhSOwgFQEAqPBzxT+wpYN+
0UuCHIC627WdHRuS7KLGWSiFT5IG/Qs=
=lS1J
-----END PGP SIGNATURE-----

--MO7InTU0UHS36JK5--

