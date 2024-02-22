Return-Path: <linux-kernel+bounces-77353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDF386043E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7378B1C256F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8873F3B;
	Thu, 22 Feb 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVo0v/0u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD612D1F2;
	Thu, 22 Feb 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635577; cv=none; b=rOP35tO2ReXFKMGN63JThNNxrg3bb7qr64O7SwFiVfn3D9fUM1ASLAyuMXryF1z+9smETulI+lEPrZ3HviY/x7/dPeiT0dZmEeXbDvq6i91borqUn8rsufvw5OYhe0W9itbODGeYZhU7QZvXH0qku3AVX/QIY6ZsaCNjfiqfswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635577; c=relaxed/simple;
	bh=ytKA8bnCAML3L4KEyiobLKKKomm+iv1MKMnix7R21fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6A6TOfk2ig3AhjmtgBDmoAjs8da8ze36TRFwj9rQL0FWRDD5yXG5BoEBDmlYf7SB9/zvEKFNJkKV/2ApDP2v2DMOHIGIcwrsuD9wNy7oErSEJn0nExIDwcdk3SN3Y2fDnlk8cTC8kaWAsxdOqI+11MwpCTMO2ptXAGFp9Xg0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVo0v/0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8004C433C7;
	Thu, 22 Feb 2024 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708635575;
	bh=ytKA8bnCAML3L4KEyiobLKKKomm+iv1MKMnix7R21fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVo0v/0ulRFyWKSSRrkJ8IyGHJsWcpYJZINTZxAXPS2WRT3wuaCHeXACQzYYNoz3V
	 n9L8daC9BKpIUMQU9fpW2ig+QNCGBNdfC/GLxnY2Hw9R621kUpV9hR3aMNZkUYqViI
	 pmrBOvC6N0mMCiyToOzsR0o+y7bnZNxz9+tWd/ooBYM/NapmLesart2v6zwSM6ShkM
	 /ctG37WkF2yXfW504mlnFMH3pB28O6n+bh9Y3ZRxCGj7b2lRXnv0t8BqAKn2TFgvH8
	 ODZwiYkgMWjrtysT5cD7aYo7zvuip+J3VOCgv3Eq8coe6oEsMq84fi2QHBJ0Io1ZFd
	 eurmgMmAPFSJQ==
Date: Thu, 22 Feb 2024 20:59:31 +0000
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
Message-ID: <20240222-crawlers-prankish-ecf425d1f0b5@spud>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
 <20240221-islamic-quartered-3863e44bc862@spud>
 <tencent_DF3D7C2E8248DA188E3FB8DF31FE21478D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IWs1APhR73R7CYvv"
Content-Disposition: inline
In-Reply-To: <tencent_DF3D7C2E8248DA188E3FB8DF31FE21478D08@qq.com>


--IWs1APhR73R7CYvv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:28:08PM +0800, Yangyu Chen wrote:
> On Wed, 2024-02-21 at 11:30 +0000, Conor Dooley wrote:
> > Hey,
> >=20
> > On Wed, Feb 21, 2024 at 03:01:53AM +0800, Yangyu Chen wrote:
> > > The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC
> > > only. This
> > > patch moved this configuration to entire riscv.
> >=20
> > To be honest, I would rather delete BUILTIN_DTB (and the
> > configurations
> > that depend on it) than expand its usefulness.
> >=20
>=20
> I agree it=E2=80=99s useless for most platforms because we need to start =
SBI
> before kernel on RISC-V except NOMMU M-Mode Linux and SBI also need a
> DT to work. However, it has been there for M-Mode K210 and it is set by
> default for XIP kernel. So there might eventually be another patch to
> support some new soc that will do this like this patch.

To be clear, I was not suggesting that it was useless. I was saying that
I would rather reduce the number of configurations that use builtin dtbs
than increase the level of support for it.

>=20
> > > Although BUILTIN_DTB is not a good choice for most platforms, it is
> > > likely
> > > to be a debug feature when some bootloader will always override
> > > something
> > > like the memory node in the device tree to adjust the memory size
> > > from SPD
> > > or configuration resistor, which makes it hard to do some
> > > debugging.
> >=20
> > My inclination here is to say "fix your bootloader" and if that's not
> > possible, chainload a bootloader that allows you control over
> > modifications to your devicetree.
> >=20
>=20
> Chainload a bootloader like S-Mode U-Boot on some platforms is hard due
> to some drivers like pcie controller does not come to the mainline repo
> of the bootloader, and some bootloader source repos provided by the
> vendor may require specific versions of the compiler to work, which
> makes users not easy to do some kernel debugging if change DT is
> needed. The simplest way to do this I can imagine is to write a simple
> bootloader by myself link the kernel binary and the dtb I want to it
> and replace the a1 register point to the dtb address before jumping to
> the kernel. However, kernel has this feature, why should I do it
> manually rather than provide a more generic patch for everyone with
> this need to use?
>=20
> > > As an
> > > example, some platforms with numa like sg2042 only support sv39
> > > will fail
> > > to boot when there is no ZONE_HIGHMEM patch with 128G memory. If we
> > > want
> > > a kernel without this patch to boot, we need to write the memory
> > > nodes=20
> > > in the DT manually.
> >=20
> > If, as Alex suggests, there's a way to gain support some more memory
> > in
> > sv39, we should do so - but it is worth mentioning that highmem is on
> > the
> > removal list for the kernel, so mainline support for that is highly
> > unlikely.
> >=20
>=20
> Yes. But I=E2=80=99m debugging some mm performance issues on the sg2042 k=
ernel.
> Specifically, it=E2=80=99s about the IPI latency when doing rfence on
> sfence.vma or fence.i. I would like to reduce the memory size and allow
> the mainline kernel to boot and test without taking some out-of-tree
> kernel patches. If I remove some DIMM modules from the board to reduce
> the memory size, it will also lose some memory channels and even leave
> some numa nodes with zero memory, and the compatible DIMM module is
> hard to find.

I'm not really sure how this relates to my comment about HIGHMEM. If
Alex is able to give you the extra 4 GiB of memory that he says there is
space for in the memory map, will the device boot properly?

> > > Also, changing DT on some platforms is not easy. For Milk-V
> > > Pioneer, the
> > > boot procedure is ZSBL -> OpenSBI -> LinuxBoot -> Linux. If DT gets
> > > changed, OpenSBI or LinuxBoot may refuse to boot. And there is some
> > > bug on
> > > LinuxBoot now which does not consume --dtb argument on kexec and
> > > always
> > > uses DT from memory.
> >=20
> > I don't use Linuxboot, but let me try to understand. Linuxboot uses
> > kexec
> > to boot the main Linux kernel, but the dtb you want to use is not
> > used, and
> > instead the one that Linuxboot itself was booted with is used?
> >=20
> > It sounds like Linuxboot has a --dtb argumet that is meant to be used
> > to
> > set the dtb for the next stage, but that argument is being ignored?
> >=20
>=20
> Yes. That=E2=80=99s correct.
>=20
> > That sounds like a pretty serious issue with Linuxboot which should
> > be
> > fixed - what am I missing?
> >=20
>=20
> Sure, that should be fixed in the LinuxBoot. However, I think not every
> kernel developer should fix some complex bootloader like LinuxBoot
> which is built upon the linux kernel with a huge initrd rootfs and runs
> some userspace tools to support the boot process. If something is hard
> to control, skip it, and doing some override for debugging will be a
> better choice.

Has anyone even /reported/ the issues with LinuxBoot to the LinuxBoot
developers? Without that being fixed, there's unlikely to ever be
mainstream distro support for it, since they're going to have to build
kernels for it alone.

> > > So I would like to do debugging on DT using
> > > BUILTIN_DTB, which makes it very simple,
> >=20
> > > I can even install the kernel in
> > > the distro's way and provide a kernel package for other users to
> > > test.
> >=20
> > I'm not sure what you mean by this, other distros manage to create
> > kernel packages without using builtin dtbs.
> >=20
>=20
> I mean I can provide a distro package like Debian .deb and distribute
> it to other users to test without changing their dtb from the entire
> boot process.

Other distros, like Ubuntu, manage to do this without relying on builtin
dtbs. I suppose this comes down to having bootloaders that

> Because changing the DT from the entire boot process
> might prevent their vendor-provided OpenSBI or LinuxBoot from working.
> Some vendor kernels may be developed out-of-tree and do not use the dt-
> binding from mainline. Even for very basic CLINT and PLIC dt bindings.

Which is verging on ridiculous at this point. Does the sg2042 also have
a version of OpenSBI that is not capable of booting a mainline kernel?

> It is only for testing, not for the production environment.

If things are just for testing, I'm not particularly keen on merging on
that basis alone. We all have various bits of testing code that doesn't
end up being merged to mainline. That said, it is broken at present and
its hard to argue against fixing it and any patch fixing it would
ultimately look very similar to your patch here.

> I want this feature to allow more people to participate in debugging
> some kernel issues without taking a huge amount of time to deal with
> bootloader issues about changing the DT. I think it will be good for
> our under-development RISC-V community.

And on the other hand, it provides no incentive for vendors to fix
broken bootloaders or firmware, which is some we suffer from on RISC-V,
in particular vendors that ship T-Head's vendor copy of OpenSBI.

> Imagine we hardly change the
> ACPI table for x86 machines but we sometimes change the DT for
> ARM/RISC-V board, right?

Usually we change them because nobody gets things "right" and we end up
having different stuff in mainline to what the vendor did. Usually also
a vendor has a relatively complete description in their vendor tree, but
things only trickle into mainline, so mainline ends up requiring regular
dtb updates until a platform stabilises. More infrequently, changes are
needed for bugfixes.

The other thing you do is compare to the ACPI table. I don't think it is
quite apples to apples there - those machines mostly have devices on
discoverable buses etc. If they had the same number of non discoverable
devices, I think you'd end up having to do more BIOS updates etc.

> Also, some SoCs that run M-Mode NOMMU Linux
> may need it in the future like K210 for XIP without a prior bootloader.

And the k210 is one of the things that is on the chopping block at the
moment. It's removal was discussed at LPC this year, with Damien
surprisingly agreeing to its removal. FWIW, builtin dtb is not required
for XIP.

BTW, I noticed that your patch only removes one of the $(addsuffix)
calls in a platform makefile.
Thanks,
Conor.

--IWs1APhR73R7CYvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZde1swAKCRB4tDGHoIJi
0vGLAP9mlz8G/cmt1LN0xZm+9IXamM5sZ5RJ2rxzpk3oruvnWAD8CZW5LJcYm1Ei
h7g1r2VazlNUr4sw53KSHjnfQo3mRAg=
=BZzm
-----END PGP SIGNATURE-----

--IWs1APhR73R7CYvv--

