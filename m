Return-Path: <linux-kernel+bounces-91860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97391871786
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83601C22618
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD77EF07;
	Tue,  5 Mar 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="opMY1aLN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B17E112;
	Tue,  5 Mar 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625644; cv=none; b=U4rC/ACO2n9DYvPZ4yhnkL0RPfEzGiQL8LlO/r25hHs5026kg6viKi4NtEII2qD0wnpmDZ1OSyUsCVEuaP4zft/Exj+OLusugU8EOJ7w5qtVnthaeZretryR7LKqMYSG0WyGI0oYhoakHybKpZo1km2gIVgkP+EPdRh/In45DSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625644; c=relaxed/simple;
	bh=gWFAJuQry3gzF9uH7O4D0aDTDmuwfZxjmqEXA+RPFLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHIYPS4rxGfLf7JWMXIlQ/Wer4AP6eT0VStuz81scm2X7BgVUWRY4beyPZxcjCs4Arzw2QouIboifsr2HyT6d2n0V/R9mTBGdaA2JgRKpfcbIXgcbXIi26TsKPVpsYyYMkHr8trYuySSMlFXBwnRSeaOxSNpKntaXv24S0+ScPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=opMY1aLN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709625642; x=1741161642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWFAJuQry3gzF9uH7O4D0aDTDmuwfZxjmqEXA+RPFLQ=;
  b=opMY1aLNw84azCOOm8MEYFUR9SZu+S3Jh4uNPHhqXfHjqtH6yEWmcEiw
   LBsMzMo0zZKVjq+OUSalP0h/X9mgVnfNAgD7wDQIGHa2SziI95xhErfmW
   C7x6BnkI+nLz+BQ5gP60ekZ7zbmAZIfytiJhYHLhFQInuwhBkqALjjiYA
   XF3kYa+PsSLH8I4+5h6fx4YgRPlcEfOG45yXzTacO8JyNDyAxA7f02nuZ
   WTnDx/YHog+JOukD9Btfi5PjFvtwPCBuhejL88FEnzCeK4jXHIlv9+T6O
   SYoUHg7qbMx8XHjjOYsKuenwHHDZ8xoIbsbOxm49eC45cyU8dnkEm2XBI
   w==;
X-CSE-ConnectionGUID: aFDr3hW/QMqfVKlnMUlmNA==
X-CSE-MsgGUID: 6fJ54n74SV+WjGmrURhuaQ==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
   d="asc'?scan'208";a="18837278"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 01:00:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 01:00:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 01:00:21 -0700
Date: Tue, 5 Mar 2024 07:59:37 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Anup Patel <apatel@ventanamicro.com>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Conor Dooley
	<conor@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel
	<anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri
	<andrea@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>, Andrea Parri
	<parri.andrea@gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Fix text patching when IPI are used
Message-ID: <20240305-sarcasm-ending-0f7946490aea@wendy>
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
 <20240229121056.203419-3-alexghiti@rivosinc.com>
 <20240304-makeshift-bakeshop-26c9611de1a3@spud>
 <87msrdzqxi.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2Xjgr9_H-sHkmAAc95dAm2jd+_dxLUxSM3RM3NrQJFKGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ofyVMJD7bERZqUGb"
Content-Disposition: inline
In-Reply-To: <CAK9=C2Xjgr9_H-sHkmAAc95dAm2jd+_dxLUxSM3RM3NrQJFKGQ@mail.gmail.com>

--ofyVMJD7bERZqUGb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 08:33:30AM +0530, Anup Patel wrote:
> On Tue, Mar 5, 2024 at 1:54=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
> >
> > Conor Dooley <conor@kernel.org> writes:
> >
> > > On Thu, Feb 29, 2024 at 01:10:56PM +0100, Alexandre Ghiti wrote:
> > >> For now, we use stop_machine() to patch the text and when we use IPI=
s for
> > >> remote icache flushes (which is emitted in patch_text_nosync()), the=
 system
> > >> hangs.
> > >>
> > >> So instead, make sure every CPU executes the stop_machine() patching
> > >> function and emit a local icache flush there.
> > >>
> > >> Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > >> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > >> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
> > >
> > > What commit does this fix?
> >
> > Hmm. The bug is exposed when the AIA IPI are introduced, and used
> > (instead of the firmware-based).
> >
> > I'm not sure this is something we'd like backported, but rather a
> > prerequisite to AIA.
> >
> > @Anup @Alex WDYT?
> >
>=20
> The current text patching never considered IPIs being injected
> directly in S-mode from hart to another so we are seeing this
> issue now with AIA IPIs.
>=20
> We certainly don't need to backport this fix since it's more
> of a preparatory fix for AIA IPIs.

Whether or not this is backportable, if it fixes a bug, it should get
a Fixes: tag for the commit that it fixes. Fixes: isn't "the backport"
tag, cc: stable is.

--ofyVMJD7bERZqUGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZebQ6QAKCRB4tDGHoIJi
0qg3AQD+yvdHglvWYh8y5lWj9K/+QDa9GdWm0cjqVDuvHYScUgD9FI61pKq1ci91
LXvSARs1oJvF0xK/zbm2iRwaXt4gCAw=
=F+Fw
-----END PGP SIGNATURE-----

--ofyVMJD7bERZqUGb--

