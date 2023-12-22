Return-Path: <linux-kernel+bounces-9794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B181CB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9166D284B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52923748;
	Fri, 22 Dec 2023 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+N++2V0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BF23741
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C44C433C8;
	Fri, 22 Dec 2023 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703256863;
	bh=h1sYjxXs/BoGIevsNfBe5AqphkFcDWhg0nXp3wZemrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+N++2V07ZnRWHIxSTLxPZ0ATvi5IuRVHkipLU+T5nujnqrswaXe7S6V9UVyZeevT
	 QorrWfbqmUj/zb7Ekn/MafDAWTo3CbPv4Ui+XHRKU0fpqCdmCyKGu6bHiJNP+aecy4
	 38RsSn9qmeF+aiY1z5mADjUrz1S70mz+IvuaEYcw4E8WIPaYqmLwWRIlwLWUf9raPa
	 JT33J6ba8nZKkjwLzE0OBdvIaqKFjgGtYKo+8WmaJgHiPj7FIyWx9Tlgte30+zrLcu
	 ZH4QkgIjb8N3s7YWAMvTCGbcR9dDWGwOLxMPoz+JAaTli38vawIupITp/Xj05CXJoE
	 tZ3yt55pJtJ/A==
Date: Fri, 22 Dec 2023 14:54:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: Christoph Hellwig <hch@lst.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, mpe@ellerman.id.au, aou@eecs.berkeley.edu,
	palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
Message-ID: <20231222-outburst-spoiling-75082a7826dd@spud>
References: <20231221185152.327231-1-fido_max@inbox.ru>
 <20231221-discount-decade-e306e5878c46@spud>
 <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com>
 <20231222041428.GA2803@lst.de>
 <c53c22dd-c482-4808-bdd7-e81c01c04f9e@inbox.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5//zPWq/C4g8xMfn"
Content-Disposition: inline
In-Reply-To: <c53c22dd-c482-4808-bdd7-e81c01c04f9e@inbox.ru>


--5//zPWq/C4g8xMfn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 05:39:34PM +0300, Maxim Kochetkov wrote:
>=20
>=20
> On 22.12.2023 07:14, Christoph Hellwig wrote:
> > On Thu, Dec 21, 2023 at 10:27:33PM +0000, Jiaxun Yang wrote:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/12/21 20:29, Conor Dooley =E5=86=99=E9=81=93:
> > > > + Christoph
> > > >=20
> > > > I don't think this patch is correct. Regardless of whether we suppo=
rt
> > > > cache management operations, DMA is assumed to be coherent unless
> > > > peripherals etc are specified to otherwise in DT (or however ACPI d=
eals
> > > > with that kind of thing).
> > > >=20
> > > > What problem are you trying to solve here?
> > > >=20
> > > > On Thu, Dec 21, 2023 at 09:51:52PM +0300, Maxim Kochetkov wrote:
> > > > > Not all the RISCV are DMA coherent by default.
> > >=20
> > > Sorry for chime in here.
> > > IMO if your platform is not coherent by default, just insert
> > > "dma-noncoherent"
> > > at devicetree root node.
> >=20
> > Exactly.  ARCH_DMA_DEFAULT_COHERENTis a setting that just says for
> > a given architecture assumes coherent unless otherwise specified,
> > which has historically been the case for mips.  Not setting it means
> > non-coherent unless specified, which has historially been the case
> > for arm.
> >=20
> > RISC-V starte out without support for non-coherent DMA, and high ups
> > in RISCV still told me in 2019 that RISC-V doesn't need cache
> > management instructions because no new hardware would ever not be
> > dma coherent.  Yeah, right..
> >=20
> > Anyay, Linux for RISC-V has historically been coherent only and then
> > coherent default, so this option is wrong, and you need to mark
> > you platform as non-coherent by inserting dma-noncoherent somewhere.
> >=20
> Conor, Christoph, Jiaxun, thanks for quick feedback!
>=20
> The problem is very simple:
> For non mips platforms dma_default_coherent is used at of_dma_is_coherent=
()
> and device_initialize().
> of_dma_is_coherent() affects only DT devices. And we can override it with
> "dma-coherent"/"dma-noncoherent". ACPI devices can specify by
> "attr =3D=3D DEV_DMA_COHERENT". But all other devices (platform_device, u=
sb,

I would have expected that usb devices "inherit" the value from the usb
controller whose bus they are on. Similarly, platform devices are on a
bus that should be marked as non-coherent if that is the case.
Christoph certainly knows better how things operate here however.

> etc..) do not have this feature. These devices will use value from
> device_initialize(). And we have no possibility to change
> dma_default_coherent value by disabling ARCH_DMA_DEFAULT_COHERENT.
> Moreover, changing dma_default_coherent from false to true may cause
> regression for other devices.

How can there be a regression when dma has been coherent by default for
the RISC-V kernel from day 1?

> That is why I suggest possibility to disable
> ARCH_DMA_DEFAULT_COHERENT by RISCV_DMA_NONCOHERENT option.
> It will works like for PPC:
> .....
> config PPC
> 	bool
> 	default y
> 	#
> 	# Please keep this list sorted alphabetically.
> 	#
> 	select ARCH_32BIT_OFF_T if PPC32
> 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
> 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
> .....
> Doesn't the option RISCV_DMA_NONCOHERENT say the DMA should be non-cohere=
nt
> by default?

No. That option only controls whether or not support for cache
management operations is built into the kernel. It is expected that this
option can be enabled for multiplatform kernels, like those used by
distributions, that will run on systems that are entirely coherent as
well as those that are not.
It does not work the same was as this PPC option appears to.

Cheers,
Conor.

--5//zPWq/C4g8xMfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYWjGAAKCRB4tDGHoIJi
0kh4AQCy/DmyJqEzO0UfUNW7jC/E7LLYxcDZ3qSUEhKoIPC6YQEA8YqL9p+Ng/Qe
cu7+3I0y2J9vgEUq7+8V2Z3ijNwgZQY=
=cA60
-----END PGP SIGNATURE-----

--5//zPWq/C4g8xMfn--

