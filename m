Return-Path: <linux-kernel+bounces-121980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C411F88F029
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EC029B279
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29114152DE1;
	Wed, 27 Mar 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1aKgMjR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F5152526;
	Wed, 27 Mar 2024 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571558; cv=none; b=KI9UKrIr7XLSo1AaI/jTiyG/r2+XZCi+KslOeIKMcLFcH5+3V87cI2qzYLyYCqhDnD/Lvze6boktDre2yFIvYv5Q9E1iKP2/u/hXRhrh5Y7uflEpkGwXhol/vfGmYKsSQlf0LMmJSAp5FfXdq0DkTGFEyOxtDjwyhAmpt1SdTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571558; c=relaxed/simple;
	bh=bUD7hRVKwVDpYh8ceARY/rXBSbxh69k1obIrokK7TR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYjfx9TTba+ofvUEiaqBFjbEPDa/8bDRRbQwFKv5vZcorgp2AahaJ5UwlzCSmpD4WrmRDODQrUlNtF6sbqy8C2yPXALxSnoOs63IB9Jf4rp9TmwPQ9FZc31MpNUhUfFo2Sxb8zzKLZonvORU1enpwfpywaFdNMoEMZ01mNOpWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1aKgMjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B50C433C7;
	Wed, 27 Mar 2024 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711571557;
	bh=bUD7hRVKwVDpYh8ceARY/rXBSbxh69k1obIrokK7TR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1aKgMjRz70NgKGq3kD7zdlCAncjjYgZt6draVS17IT5OqyIWMKVqHkFdF+uIiBdw
	 wKwCAAXNnOc1SNd+WdyxcSVCn03YYTUgpJW4iCHcOVq90o8OexCDaIkYStDtPUxUBr
	 at82lhQwaBm5ZRWywlyHGN0mh5omIQzwAzghqk5EPIqUqY5eIOxGPEb1ZALZ86PUPB
	 CZBD9DnUhpMXBlIZRjBkzaKCm9EfqstsXrL8k0/4RY6iBVld0d/ZhxBr1dWD1oFd0F
	 XzXaBERa6K2024PS0nriLLOIiT6+5MbTCiDKJ/8dpvnCaQQ7fxxD1j3B9refO27qTZ
	 wTDGskEYXb1/w==
Date: Wed, 27 Mar 2024 20:32:33 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: RISC-V for-next/fixes (cont'd from PW sync)
Message-ID: <20240327-irrigate-unread-d9de28174437@spud>
References: <87ttkro3b5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+H3UkLQ2ywM6BKxo"
Content-Disposition: inline
In-Reply-To: <87ttkro3b5.fsf@all.your.base.are.belong.to.us>


--+H3UkLQ2ywM6BKxo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 08:57:50PM +0100, Bj=F6rn T=F6pel wrote:
> Hi,
>=20
> I figured I'd put some words on the "how to update the RISC-V
> for-next/fixes branches [1]" that came up on the patchwork call today.
>=20
> In RISC-V land, the for-next branch is used for features, and typically
> sent as a couple of PRs to Linus when the merge window is open. The
> fixes branch is sent as PR(s) between the RCs of a release.
>=20
> Today, the baseline for for-next/fixes is the CURRENT_RELEASE-rc1, and
> features/fixes are based on that.
>=20
> This has IMO a couple of issues:
>=20
> 1. fixes is missing the non-RISC-V fixes from releases later than
>    -rc1, which makes it harder for contributors.
> 2. for-next does not have the fixes from RISC-V/rest of the kernel,
>    and it's hard for contributors to test the work on for-next (buggy,
>    no fixes, and sometime missing deps).
>=20
> I used to spend a whole lot of mine time in the netdev tree of the
> kernel, and this is how they manage it (Thanks Kuba!):
>=20
> Netdev (here exchanged to RISC-V trees), fast-forward fixes, and then
> cross-merge fixes into for-next -- for every -rc.
>=20
> E.g., say fixes is submitted for -rc2 to Linus, once he pulls, do:
>=20
>   git push --delete origin $SOMETAG
>   git tag -d $SOMETAG
>   git pull --ff-only --tags git://git.kernel.org/pub/scm/linux/kernel/git=
/torvalds/linux.git
>   build / test / push out.
>=20
> Then pull fixes into for-next:
>=20
>   git pull --tags git://git.kernel.org/pub/scm/linux/kernel/git/riscv/lin=
ux.git fixes
>=20
>=20
> Personally (obviously biased), I think this would be easier for
> contributors. Any downsides from a RISC-V perspective?

After you left, Palmer said he'd go for merging his fixes tag into
for-next after they got merged by Linus. At least I think it was that,
rather than Linus' -rcs...

--+H3UkLQ2ywM6BKxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgSCYQAKCRB4tDGHoIJi
0jSXAQC9hx3TKykVdHY3TVEbOmGffTwUej+VecLBQq9NlaLEaQD8DHwblxB6xvNU
37YujV2wcGemH2l70tsYuN6yZnL1vwg=
=ZRKV
-----END PGP SIGNATURE-----

--+H3UkLQ2ywM6BKxo--

