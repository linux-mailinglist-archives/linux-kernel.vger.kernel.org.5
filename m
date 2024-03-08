Return-Path: <linux-kernel+bounces-96875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF1876279
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BD0B228CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5BF55777;
	Fri,  8 Mar 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F29bxdXH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DF14A82
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895369; cv=none; b=XmCtQps+vrugXch8ny3I5dSApl9H6tscKy2+gG59cpIAEukvHTyGVBvZ8FhtyWwW8EW6ZGxEIjLxhOPA+yMr7c8+xHe7g0v6ladjue/96QvOVU+osRwUwhOA6YVoNbD12JdN6Sq5hEDkBgJnVv9BvwGWSRs0JIDJiqc1blXMAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895369; c=relaxed/simple;
	bh=vXkMUwP2iGNOK6Xz2bMKT4lqKsvSco6aYYOJrkgKviU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv9Ia47ccJZhdEG2T0bYziPcT1E/8BLA01vh36NWqu1ipgKZi+GsAKWQscgoFQqEP3+6xbvLG+DtyyvI6356FjlkkFn6YHAs7lR4ghBu+9GD1b5OksBi7JmwOa1S/rKrY/HaIeeJnpTUBXDakPTyHK1zvQAQjygiR9Tugdpyz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F29bxdXH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709895367; x=1741431367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vXkMUwP2iGNOK6Xz2bMKT4lqKsvSco6aYYOJrkgKviU=;
  b=F29bxdXHTCn9BQP5vk4UH0FHop1/MXz0oTvcX/VwCFQb9WzDslywy69S
   +cUoE2AbOi+XH7fGOOJLg8aPYL+ViapWa79AL2dgBmlfGcmbtfjl8wpUr
   UY/AhoIPL1+lxz8g+Dq5fUpa/FlWYJoEaxKarghbusZpYYVNJWWhqdPZ5
   YMBHw50/C/9A+Wp8yB8m+6nzJ6kjGBcvzDXPN3oX3QAp6OzSBK0LA558M
   rINXlcnrtg40+eDf/iwBPh3UM4P7pkTX1bAUzFq/+ot/T5qpEYl1nq9oU
   8omAPrQqLhbUAjL701HL5w0N2uFf3M1lxWLLIJRT8eWx+/9QZKLiYqsVJ
   A==;
X-CSE-ConnectionGUID: PZ5niwm1Rr+UCEdoA/m20g==
X-CSE-MsgGUID: mFoPl2fYRp+cuyl44O5MCA==
X-IronPort-AV: E=Sophos;i="6.07,109,1708412400"; 
   d="asc'?scan'208";a="184667445"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 03:55:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 03:55:28 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Mar 2024 03:55:26 -0700
Date: Fri, 8 Mar 2024 10:54:41 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: Charlie Jenkins <charlie@rivosinc.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, Evan Green
	<evan@rivosinc.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<cleger@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, Elliot Berman
	<quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/4] riscv: Set unaligned access speed at compile time
Message-ID: <20240308-docile-pretense-b44c3a84d8b2@wendy>
References: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
 <20240307-disable_misaligned_probe_config-v8-4-55d696cb398b@rivosinc.com>
 <CAJM55Z9SYA=QMg0Wg-e0Q8nOTP6qSKkc+kxHMGOmmmWrEcVf7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nNYYXJCx7WAmCO2a"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9SYA=QMg0Wg-e0Q8nOTP6qSKkc+kxHMGOmmmWrEcVf7w@mail.gmail.com>

--nNYYXJCx7WAmCO2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 01:52:24AM -0800, Emil Renner Berthing wrote:
> Charlie Jenkins wrote:

> >  config RISCV_MISALIGNED
> > -	bool "Support misaligned load/store traps for kernel and userspace"
> > +	bool
> >  	select SYSCTL_ARCH_UNALIGN_ALLOW
> > -	default y
> >  	help
> > -	  Say Y here if you want the kernel to embed support for misaligned
> > -	  load/store for both kernel and userspace. When disable, misaligned
> > -	  accesses will generate SIGBUS in userspace and panic in kernel.
> > +	  Embed support for misaligned load/store for both kernel and userspa=
ce.
> > +	  When disabled, misaligned accesses will generate SIGBUS in userspace
> > +	  and panic in the kernel.
>=20
> Hmm.. this is *may* generate SIGBUS in userspace and panic the kernel. Th=
e CPU
> could support unaligned access natively or there might be a handler in M-=
mode,
> right?

Correct. The last sentence could become "When disabled, and there is no
support in hardware or firmware, unsigned accesses will...". That said,
this option is no longer user visible, so we could really simplify the
hell out of this option to just mention that it controls building the
in-kernel emulator.

> > +choice
> > +	prompt "Unaligned Accesses Support"
> > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > +	help
> > +	  This determines the level of support for unaligned accesses. This
> > +	  information is used by the kernel to perform optimizations. It is a=
lso
> > +	  exposed to user space via the hwprobe syscall. The hardware will be
> > +	  probed at boot by default.
> > +
> > +config RISCV_PROBE_UNALIGNED_ACCESS
> > +	bool "Probe for hardware unaligned access support"
> > +	select RISCV_MISALIGNED
> > +	help
> > +	  During boot, the kernel will run a series of tests to determine the
> > +	  speed of unaligned accesses. This probing will dynamically determine
> > +	  the speed of unaligned accesses on the underlying system. If unalig=
ned
> > +	  memory accesses trap into the kernel as they are not supported by t=
he
> > +	  system, the kernel will emulate the unaligned accesses to preserve =
the
> > +	  UABI.
> > +
> > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > +	bool "Emulate unaligned access where system support is missing"
> > +	select RISCV_MISALIGNED
> > +	help
> > +	  If unaligned memory accesses trap into the kernel as they are not
> > +	  supported by the system, the kernel will emulate the unaligned
> > +	  accesses to preserve the UABI. When the underlying system does supp=
ort
> > +	  unaligned accesses, the unaligned accesses are assumed to be slow.
>=20
> It's still not quite clear to me when you'd want to choose this over prob=
ing
> above. Assuming the probe measures correctly this can only result in a ke=
rnel
> that behaves the same or slower than with the option above, right?

Aye, mostly the same - some people don't want the boot-time overhead
of actually running the profiling code, so this option is for them.
Maybe that's not such a big deal anymore with the improvements to do it
in parallel, but given how bad performance on some of the systems is
when firmware does the emulation, it is definitely still noticeable.
I know we definitely have customers that care about their boot time very
strongly, so I can imagine they'd be turning this off.

> > +
> > +config RISCV_SLOW_UNALIGNED_ACCESS
> > +	bool "Assume the system supports slow unaligned memory accesses"
> > +	depends on NONPORTABLE
> > +	help
> > +	  Assume that the system supports slow unaligned memory accesses. The
> > +	  kernel and userspace programs may not be able to run at all on syst=
ems
> > +	  that do not support unaligned memory accesses.
>=20
> Again you're just explicitly saying no to the optimizations the kernel mi=
ght do
> if it detects fast unaligned access, only here you'll also crash if they'=
re not
> handled by the CPU or M-mode. Why would you want that?
>=20
> I'm probably missing something, but the only reason I can think of is if =
you
> want build a really small kernel and save the few bytes for the handler a=
nd
> probing code.

Aye, just to allow you to disable the in-kernel emulator. That's
currently a choice that is presented to people, so this option preserves
that. IMO this is by far the least useful option and is locked behind
NONPORTABLE anyway. Maybe we could delete it, and if someone really wants
it, it would not be all that much of a hassle to add back in the future?

--nNYYXJCx7WAmCO2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZerucQAKCRB4tDGHoIJi
0mYvAQDA4Z//e444zAvLcCQ11CntZbnOPnEpaTmVf2TcOSn8FQD/bWM68sqlUJ8F
8ndc7uMmJh0Lk1xAl9DJK/ONWQOWiwU=
=4z8b
-----END PGP SIGNATURE-----

--nNYYXJCx7WAmCO2a--

