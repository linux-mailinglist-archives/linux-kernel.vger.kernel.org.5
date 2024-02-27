Return-Path: <linux-kernel+bounces-83135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE4B868F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE071C229F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8113959A;
	Tue, 27 Feb 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IMK/m4+t"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D412F581
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034037; cv=none; b=sfUfOMozyi8LvN15C5sl/P5+1m2GfghnjjQbxIWoSPfzHKWyLAhlR4ciLDTRYgoLXN13hCSuUQ3BD+2xkExfzSRcbjnALhgup2j7/5gOEcDdEk3pIqx6jfyA+C6BBzx8E4r3ntE2sX41bZLB2PDkOqwh2kx3dQXvY3YJQtAqz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034037; c=relaxed/simple;
	bh=nAcqQcoVlavgogzMMv0AJtTW2BknoALl9ZTHNc2lkI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv/QGKoDwIpYDIBLpmAA+IFiE/nF0dr5sliKbowlhMJsSAd1vzi5t21I10bXT3DJn2kyIJzw1r/M5bkmw99eF29tijnfZzbgEZnDUqO+dCMpHmULiUatY6MZw+WqF5EkHNZHt3Pj8HQ7TOaEPxBEGsbxef8IL8npTmZIbPk3MBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IMK/m4+t; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709034035; x=1740570035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nAcqQcoVlavgogzMMv0AJtTW2BknoALl9ZTHNc2lkI8=;
  b=IMK/m4+txu4CIy/y+vADJWCfXfSQyJVGg/H9eFdUSaTiXvAPXA3qaKWZ
   rQ2Dzml3Db4f0vcLONf8fl84FI+BB0xk2U3GYoqz02ADAQ/CO/sQafbcm
   tYyHwXK8dJuOHuMrri0gL2s7xN2xkWo/s9nreTd7gW2L38aHkaPDQOIXV
   g05GJEO0op90X1i5aXUsJyShjwWVufzM/NIy+63sgeTlZf4v1k8XJnKaq
   xeopy1bBrI8i2wFo8g2ndUX7zQYAFGN5QgRTwRgvqpFrbWJb2YvmuzBuz
   5p7UPzULtyHuvB+IQ1XZ1RdSa1uxnskSYSPUC5sMh6GJV/XEiIGD59D2/
   Q==;
X-CSE-ConnectionGUID: bVyENMktQsa0J3zoirwwlw==
X-CSE-MsgGUID: KyHdUvHKQ+mwrCRxqQUDzg==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="18453223"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 04:40:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 04:40:10 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 04:40:08 -0700
Date: Tue, 27 Feb 2024 11:39:25 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang
	<jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Eric Biggers
	<ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr
	<lohr85@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] riscv: Set unalignment speed at compile time
Message-ID: <20240227-condone-impeach-9469dffc6b47@wendy>
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
 <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qwP6EXChpel/sZvo"
Content-Disposition: inline
In-Reply-To: <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>

--qwP6EXChpel/sZvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:33:19PM -0800, Charlie Jenkins wrote:
> Introduce Kconfig options to set the kernel unaligned access support.
> These options provide a non-portable alternative to the runtime
> unaligned access probe.
>=20
> To support this, the unaligned access probing code is moved into it's
> own file and gated behind a new RISCV_PROBE_UNALIGNED_ACCESS_SUPPORT
> option.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                          |  58 +++++-
>  arch/riscv/include/asm/cpufeature.h         |  30 +++-
>  arch/riscv/kernel/Makefile                  |   6 +-
>  arch/riscv/kernel/cpufeature.c              | 255 ----------------------=
----
>  arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/probe_emulated_access.c   |  64 +++++++
>  arch/riscv/kernel/sys_hwprobe.c             |  25 +++
>  arch/riscv/kernel/traps_misaligned.c        |  54 +-----
>  8 files changed, 442 insertions(+), 315 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..3cf700adc43b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -690,25 +690,71 @@ config THREAD_SIZE_ORDER
>  config RISCV_MISALIGNED


Why can we not make up our minds on what to call this? The majority of
users are "unaligned" but the file you add and this config option are
"misaligned."

>  	bool "Support misaligned load/store traps for kernel and userspace"
>  	select SYSCTL_ARCH_UNALIGN_ALLOW
> +	depends on RISCV_PROBE_UNALIGNED_ACCESS || RISCV_EMULATED_UNALIGNED_ACC=
ESS
>  	default y
>  	help
>  	  Say Y here if you want the kernel to embed support for misaligned
>  	  load/store for both kernel and userspace. When disable, misaligned
>  	  accesses will generate SIGBUS in userspace and panic in kernel.
> =20
> +choice
> +	prompt "Unaligned Accesses Support"
> +	default RISCV_PROBE_UNALIGNED_ACCESS
> +	help
> +	  This selects the hardware support for unaligned accesses. This
> +	  information is used by the kernel to perform optimizations. It is also
> +	  exposed to user space via the hwprobe syscall. The hardware will be
> +	  probed at boot by default.
> +
> +config RISCV_PROBE_UNALIGNED_ACCESS
> +	bool "Probe for hardware unaligned access support"
> +	help
> +	  During boot, the kernel will run a series of tests to determine the
> +	  speed of unaligned accesses. This is the only portable option. This
> +	  probing will dynamically determine the speed of unaligned accesses on
> +	  the boot hardware.
> +
> +config RISCV_EMULATED_UNALIGNED_ACCESS
> +	bool "Assume the CPU expects emulated unaligned memory accesses"
> +	depends on NONPORTABLE

This is portable too, right?

> +	select RISCV_MISALIGNED
> +	help
> +	  Assume that the CPU expects emulated unaligned memory accesses.
> +	  When enabled, this option notifies the kernel and userspace that
> +	  unaligned memory accesses will be emulated by the kernel.

> To enforce
> +	  this expectation, RISCV_MISALIGNED is selected by this option.

Drop this IMO, let Kconfig handle displaying the dependencies.

> +
> +config RISCV_SLOW_UNALIGNED_ACCESS
> +	bool "Assume the CPU supports slow unaligned memory accesses"
> +	depends on NONPORTABLE
> +	help
> +	  Assume that the CPU supports slow unaligned memory accesses. When
> +	  enabled, this option improves the performance of the kernel on such
> +	  CPUs.

Does it? Are you sure that generating unaligned accesses on systems
where they are slow is a performance increase?
That said, I don't really see this option actually doing anything other
than setting the value for hwprobe, so I don't actually know what the
effect of this option actually is on the kernel's performance.

Generally I would like to suggest a change from "CPU" to "system" here,
since the slow cases that exist are mostly because the unaligned access
is actually emulated in firmware.

> However, the kernel will run much more slowly, or will not be
> +	  able to run at all, on CPUs that do not support unaligned memory
> +	  accesses.
> +
>  config RISCV_EFFICIENT_UNALIGNED_ACCESS
>  	bool "Assume the CPU supports fast unaligned memory accesses"
>  	depends on NONPORTABLE
>  	select DCACHE_WORD_ACCESS if MMU
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	help
> -	  Say Y here if you want the kernel to assume that the CPU supports
> -	  efficient unaligned memory accesses.  When enabled, this option
> -	  improves the performance of the kernel on such CPUs.  However, the
> -	  kernel will run much more slowly, or will not be able to run at all,
> -	  on CPUs that do not support efficient unaligned memory accesses.
> +	  Assume that the CPU supports fast unaligned memory accesses. When
> +	  enabled, this option improves the performance of the kernel on such
> +	  CPUs.  However, the kernel will run much more slowly, or will not be
> +	  able to run at all, on CPUs that do not support efficient unaligned
> +	  memory accesses.
> +
> +config RISCV_UNSUPPORTED_UNALIGNED_ACCESS

This option needs to be removed. The uabi states that unaligned access
is supported in userspace, if the cpu or firmware does not implement
unaligned access then the kernel must emulate it.

> +	bool "Assume the CPU doesn't support unaligned memory accesses"
> +	depends on NONPORTABLE
> +	help
> +	  Assume that the CPU doesn't support unaligned memory accesses. Only
> +	  select this option if there is no registered trap handler to emulate
> +	  unaligned accesses.
> =20
> -	  If unsure what to do here, say N.
> +endchoice
> =20
>  endmenu # "Platform type"

> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index eb3ac304fc42..928ad3384406 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -33,10 +33,26 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
> =20
>  void riscv_user_isa_enable(void);
> =20
> -#ifdef CONFIG_RISCV_MISALIGNED
> +#if defined(CONFIG_RISCV_MISALIGNED)
> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>  bool unaligned_ctl_available(void);
>  bool check_unaligned_access_emulated(int cpu);
>  void unaligned_emulation_finish(void);
> +#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
> +static inline bool unaligned_ctl_available(void)
> +{
> +	return true;
> +}
> +
> +static inline bool check_unaligned_access_emulated(int cpu)
> +{
> +	return true;
> +}
> +
> +static inline void unaligned_emulation_finish(void) {}
> +#else
> +#error "CONFIG_RISCV_MISALIGNED is only supported if CONFIG_RISCV_PROBE_=
UNALIGNED_ACCESS or CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS is selected."

Why is this an error? Enforce this in Kconfig (you already have) and drop
the clause.

Cheers,
Conor.

--qwP6EXChpel/sZvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3J7QAKCRB4tDGHoIJi
0ia+AQCU5YCXF9J0kaM+Tt9OAbetH7+JzZR2O/sLLeCFxZg9GQD+KADsdA0Xelx3
k1fmt+5ayKCVcruP4O6xdFtjtpGOUgo=
=fwKH
-----END PGP SIGNATURE-----

--qwP6EXChpel/sZvo--

