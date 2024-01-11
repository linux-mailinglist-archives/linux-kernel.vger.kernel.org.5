Return-Path: <linux-kernel+bounces-23459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8A82AD12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F85B23057
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54D156CD;
	Thu, 11 Jan 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdWzFpeS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B8156C4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D4EC433C7;
	Thu, 11 Jan 2024 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704971559;
	bh=YP720qY+V6lat6L4rh1Qgia2UZoDpEKIiI/Bz0OXSVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdWzFpeSXepCJ4igfnit4t7299ra1ncWtXVC3dDdjyyB9X8zF14Vj444iFzOG4cvy
	 Wnft3x8iyXos5ecyW/LuiUW49j1LTDLySn1MRRbrjRZmoXgrpORdbA64BzRkj381sf
	 jC2GIcEA2cQMFkE9QF4bnPoTlLsdjp67eBSq9DP0v4vZhqx0H8aUuJnZMGr/qOlIM8
	 2N6ycsf0ArkJ9SwO1qtqe5N97E/FUoBmg1Bm9ICwj+jfiutkx1ang+XAjAEItm72v/
	 QHLSSicxa3pNsGCCx1OnUHP8pGD4l6DLujftEZX8f1XZOlQwQRVdXDa3wgdRAXOxjB
	 8vKw7QKXlR0lQ==
Date: Thu, 11 Jan 2024 11:12:33 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, guoren@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com,
	conor.dooley@microchip.com, leobras@redhat.com,
	peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com, chao.wei@sophgo.com,
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org,
	wefu@redhat.com, atishp@atishpatra.org
Subject: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions &
 cpufeature
Message-ID: <20240111-populate-sterilize-8e241ead0b00@spud>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
 <6bce1adb-6808-40df-8dd7-b0b2c6031547@rivosinc.com>
 <20240103-77f6b0856efb7a9f4591c53b@orel>
 <331610f6-9987-4d1b-8d57-f21311a43f5d@rivosinc.com>
 <20240111-416377ebfcaff924b71fb419@orel>
 <78afc7ce-c6ce-4edd-b91a-1f8a94ce298a@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vus9tltaRDvMwieT"
Content-Disposition: inline
In-Reply-To: <78afc7ce-c6ce-4edd-b91a-1f8a94ce298a@rivosinc.com>


--Vus9tltaRDvMwieT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:49:48AM +0100, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 11/01/2024 11:45, Andrew Jones wrote:
> > On Thu, Jan 11, 2024 at 11:31:32AM +0100, Cl=E9ment L=E9ger wrote:
> >>
> >>
> >> On 03/01/2024 13:00, Andrew Jones wrote:
> >>> On Wed, Jan 03, 2024 at 10:31:37AM +0100, Cl=E9ment L=E9ger wrote:
> >>>>
> >>>>
> >>>> On 31/12/2023 09:29, guoren@kernel.org wrote:
> >>>>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>>>
> >>>>> Cache-block prefetch instructions are HINTs to the hardware to
> >>>>> indicate that software intends to perform a particular type of
> >>>>> memory access in the near future. This patch adds prefetch.i,
> >>>>> prefetch.r and prefetch.w instruction definitions by
> >>>>> RISCV_ISA_EXT_ZICBOP cpufeature.
> >>>>>
> >>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>>> ---
> >>>>>  arch/riscv/Kconfig                | 15 ++++++++
> >>>>>  arch/riscv/include/asm/hwcap.h    |  1 +
> >>>>>  arch/riscv/include/asm/insn-def.h | 60 +++++++++++++++++++++++++++=
++++
> >>>>>  arch/riscv/kernel/cpufeature.c    |  1 +
> >>>>>  4 files changed, 77 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>>>> index 24c1799e2ec4..fcbd417d65ea 100644
> >>>>> --- a/arch/riscv/Kconfig
> >>>>> +++ b/arch/riscv/Kconfig
> >>>>> @@ -579,6 +579,21 @@ config RISCV_ISA_ZICBOZ
> >>>>> =20
> >>>>>  	   If you don't know what to do here, say Y.
> >>>>> =20
> >>>>> +config RISCV_ISA_ZICBOP
> >>>>> +	bool "Zicbop extension support for cache block prefetch"
> >>>>> +	depends on MMU
> >>>>> +	depends on RISCV_ALTERNATIVE
> >>>>> +	default y
> >>>>> +	help
> >>>>> +	  Adds support to dynamically detect the presence of the ZICBOP
> >>>>> +	  extension (Cache Block Prefetch Operations) and enable its
> >>>>> +	  usage.
> >>>>> +
> >>>>> +	  The Zicbop extension can be used to prefetch cache block for
> >>>>> +	  read/write fetch.
> >>>>> +
> >>>>> +	  If you don't know what to do here, say Y.
> >>>>> +
> >>>>>  config TOOLCHAIN_HAS_ZIHINTPAUSE
> >>>>>  	bool
> >>>>>  	default y
> >>>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/as=
m/hwcap.h
> >>>>> index 06d30526ef3b..77d3b6ee25ab 100644
> >>>>> --- a/arch/riscv/include/asm/hwcap.h
> >>>>> +++ b/arch/riscv/include/asm/hwcap.h
> >>>>> @@ -57,6 +57,7 @@
> >>>>>  #define RISCV_ISA_EXT_ZIHPM		42
> >>>>>  #define RISCV_ISA_EXT_SMSTATEEN		43
> >>>>>  #define RISCV_ISA_EXT_ZICOND		44
> >>>>> +#define RISCV_ISA_EXT_ZICBOP		45
> >>>>
> >>>> Hi Guo,
> >>>>
> >>>> Since you are adding support for the Zicbop extension, you could
> >>>> probably also allow to probe it from userspace using hwprobe. Add a =
few
> >>>> definitions to sys_riscv.c/hwprobe.h and it will be fine.
> >>>
> >>> To expose to userspace, we should also start parsing the block size,
> >>> so it can also be exposed to userspace. Starting to parse the block
> >>> size first requires that we decide we need to parse the block size
> >>> (see [1]).
> >>
> >> Hi Andrew, thanks for the thread.
> >>
> >> I read it (and the other ones that are related to it) and basically, it
> >> seems there was a first decision (expose Zicbop block size indivudally)
> >> due to the fact the specification did not mentioned anything specific
> >> about clock sizes  but then after that, there was a clarification in t=
he
> >> spec stating that Zicbop and Zicbom have the same block size so the
> >> first decision was questioned again.
> >>
> >> From a user coherency point of view, I think it would make more sense =
to
> >> expose it individually in hwprobe  so that zicboz, zicbop and zicbom
> >> have their "own" block size (even though zicbop and zicbom would use t=
he
> >> same one). Moreover, it would allow us for future evolution easily
> >> without breaking any userspace later if zicbop and zicbom block size a=
re
> >> decoupled.
> >=20
> > I agree and QEMU has already headed down the road of generating
> > riscv,cbop-block-size (I guess Conor's ack on [1] was interpreted as
> > being sufficient to merge the QEMU bits), so we can add the Linux
> > support and test with QEMU now. The work could probably be a separate
> > series to this one, though.
>=20
> Yes, it QEMU had it merged. and agreed, since this requires a bit more
> plumbing, it can probably be left out of this series. I could probably
> take care of that later.

I think some crack slippage happened with that patch. I pinged Palmer
about it on irc.



--Vus9tltaRDvMwieT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ/NCwAKCRB4tDGHoIJi
0twzAQCwvEXASDogfPIZYSCzU6w1F/dvowWIaUiGrKqzVB85bQEAh1XD/90MeTCu
cO3AjtTsut9bSC6xTI2xH2/0/JPVxwU=
=iM4A
-----END PGP SIGNATURE-----

--Vus9tltaRDvMwieT--

