Return-Path: <linux-kernel+bounces-74621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551E85D707
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671AC1C2276B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA3B3FE4C;
	Wed, 21 Feb 2024 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDaPoHyg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D540BF0;
	Wed, 21 Feb 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515062; cv=none; b=ucMusyf8lfU6aaor5rIt7eqjx6esaYs3mXXI+wxPTjP15gFownIt6+LlFRSd8vQFa6+qy77zzs8A8iEeP9AZCKJDwTlqsHpLY5RiWMmxiUYyMdHNmAQXYarIw1U66sAs7+oF3GB9AGhJOMHPkXQQXT7sCzjC4J2TXcUMg4tDQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515062; c=relaxed/simple;
	bh=R06aAEMhs4VND/RSzWUYXOWMIOf4o7CtU24ik/gBYso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHgaOVAt2TeZ3kN94RTFjwWeNMf+2f9kQPjRs/SZsgzcAwXN9IngFOXB0Nr+oEaE9Xj61a3qZ8Yuw/W7kbK691p1F46nwvvk2j/mUMvXcENFGXoh54NyWgkzawzMbPculevuMnMN8ibFhALzVSt+kO/BhEeZlTuqyJ5Ee2UPzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDaPoHyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8BCC433F1;
	Wed, 21 Feb 2024 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515061;
	bh=R06aAEMhs4VND/RSzWUYXOWMIOf4o7CtU24ik/gBYso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDaPoHyg0AHRcXQMxanR12gVR12clkhaAkwfKJCuJzmieyysXJRL9eC6SSH6dTa+r
	 HCsjYMivTJUX7bKJLQVWT9nXnfedTTBy8Hn+pr8Suf014f+f8dap/wwR1GCj20jMkz
	 4iORMgd7Hl+JTKLIpPn8UE+9TvHOtTwakxCKPgXF5/hWBj7+msySjnAtNIup4dIEqj
	 WmQztSkiw3aUB8pbyvo85E9XXRGvH70OtAMF3LNRhbYoHv/7Iw/YZZ/HZV4c+EWwFA
	 UXyoXCMHo7GRT734ub1xahDq7M/Gy5+0vUuYJHxoGr0is8QtBFWas3hI31JqicvcuC
	 5FUbGRU7CRnyA==
Date: Wed, 21 Feb 2024 11:30:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] riscv: dts: Allow BUILTIN_DTB for all socs
Message-ID: <20240221-islamic-quartered-3863e44bc862@spud>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6BDdXDRGwPxzf+xE"
Content-Disposition: inline
In-Reply-To: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>


--6BDdXDRGwPxzf+xE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Feb 21, 2024 at 03:01:53AM +0800, Yangyu Chen wrote:
> The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC only. This
> patch moved this configuration to entire riscv.

To be honest, I would rather delete BUILTIN_DTB (and the configurations
that depend on it) than expand its usefulness.

> Although BUILTIN_DTB is not a good choice for most platforms, it is likely
> to be a debug feature when some bootloader will always override something
> like the memory node in the device tree to adjust the memory size from SPD
> or configuration resistor, which makes it hard to do some debugging.

My inclination here is to say "fix your bootloader" and if that's not
possible, chainload a bootloader that allows you control over
modifications to your devicetree.

> As an
> example, some platforms with numa like sg2042 only support sv39 will fail
> to boot when there is no ZONE_HIGHMEM patch with 128G memory. If we want
> a kernel without this patch to boot, we need to write the memory nodes=20
> in the DT manually.

If, as Alex suggests, there's a way to gain support some more memory in
sv39, we should do so - but it is worth mentioning that highmem is on the
removal list for the kernel, so mainline support for that is highly
unlikely.

> Also, changing DT on some platforms is not easy. For Milk-V Pioneer, the
> boot procedure is ZSBL -> OpenSBI -> LinuxBoot -> Linux. If DT gets
> changed, OpenSBI or LinuxBoot may refuse to boot. And there is some bug on
> LinuxBoot now which does not consume --dtb argument on kexec and always
> uses DT from memory.

I don't use Linuxboot, but let me try to understand. Linuxboot uses kexec
to boot the main Linux kernel, but the dtb you want to use is not used, and
instead the one that Linuxboot itself was booted with is used?

It sounds like Linuxboot has a --dtb argumet that is meant to be used to
set the dtb for the next stage, but that argument is being ignored?

That sounds like a pretty serious issue with Linuxboot which should be
fixed - what am I missing?

> So I would like to do debugging on DT using
> BUILTIN_DTB, which makes it very simple,

> I can even install the kernel in
> the distro's way and provide a kernel package for other users to test.

I'm not sure what you mean by this, other distros manage to create
kernel packages without using builtin dtbs.

Thanks,
Conor.

--6BDdXDRGwPxzf+xE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdXe8QAKCRB4tDGHoIJi
0vrYAP9VXm6khUlWB8q8p1RxXCZDwC0wOdqAAu2teabf2mgMbAEA0oaXGtQIWT+6
hRyOdPEH0c08Xd4EhI/UdYf2kNSMkwc=
=yHib
-----END PGP SIGNATURE-----

--6BDdXDRGwPxzf+xE--

