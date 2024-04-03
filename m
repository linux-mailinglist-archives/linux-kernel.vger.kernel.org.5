Return-Path: <linux-kernel+bounces-130173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0908974EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F22E1F222B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E514E2F2;
	Wed,  3 Apr 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjPhTdrk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73714B073
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160664; cv=none; b=PrDGrv5Spk8tEALL8q6A5LxLNegdsSnapjlDxSEOQZX55SYOibkK0q/H4mibOr23rToVYLWvqCktFY/y9WLkHjJGBeGY13//4jTVwwCZBZ2EwSfSO9bPVAMHme+vJZlgctxCovlrGZkNSyL8MXPutIjotkYb4nIoaQmBip6fkOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160664; c=relaxed/simple;
	bh=nyU0F3ej83LHBArYWvHTmUMX9HPrzUZJ7A/Qsu6qybw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sR3gUkVP1gE7vDeIl6Plv8BXlXHlJFYASBcHf1HAffhGVTjeOoHyggRA2dYQRjQXAKveAvhYyaqqSgzzUVbwKu8ZQdve3wHZBkESItpsjwBDOp9BhOtQXfkUw7lmN7Fjy2hj8vch/XQl19pgLXPan3JVLV66RYh4surQjQNlBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjPhTdrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167ACC433C7;
	Wed,  3 Apr 2024 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712160664;
	bh=nyU0F3ej83LHBArYWvHTmUMX9HPrzUZJ7A/Qsu6qybw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gjPhTdrkX6vjBSuS+zaKuaiyoGR/UHwImYh5jczdwkYJGVKzTI8yf2hpvYuYivheF
	 9cAasLK2QGmMR19zPptwl9h0ZbUmVIMRICLp23Kjwu2VcYz0+/6ZeLdy4bzT59PDc2
	 l63iyGVEr2qZXLKQT6+2lXJITHV3yENnPasAhVdiRKDDtUBVDx+h/fqVo0cbFGV7t1
	 u7dlbbHFhMewEnqBVLHRm7gTFbvCN1GWPuV+Llr16q96XepFSjlvVBfIIp39cnhcMb
	 LqkfZqDv4tft76m0tI2QRTWTUo2DDnMJBAR90COOO/G7XwDSHBgrqRskp2gieKHvJt
	 RLvt1DTrQcT8g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 19:10:58 +0300
Message-Id: <D0AMARUFBCNN.21GJ0PXUDK0F6@kernel.org>
Cc: <agordeev@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <aou@eecs.berkeley.edu>, <bp@alien8.de>, <catalin.marinas@arm.com>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>, <gor@linux.ibm.com>,
 <hca@linux.ibm.com>, <jcalvinowens@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <mhiramat@kernel.org>,
 <mingo@redhat.com>, <mpe@ellerman.id.au>, <naveen.n.rao@linux.ibm.com>,
 <palmer@dabbelt.com>, <paul.walmsley@sifive.com>, <tglx@linutronix.de>,
 <will@kernel.org>
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mark Rutland" <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240326163624.3253157-1-mark.rutland@arm.com>
 <20240326163624.3253157-5-mark.rutland@arm.com>
 <Zg07hrb_RMUu2tq7@FVFF77S0Q05N>
In-Reply-To: <Zg07hrb_RMUu2tq7@FVFF77S0Q05N>

On Wed Apr 3, 2024 at 2:20 PM EEST, Mark Rutland wrote:
> On Tue, Mar 26, 2024 at 04:36:24PM +0000, Mark Rutland wrote:
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > Tracing with kprobes while running a monolithic kernel is currently
> > impossible because KPROBES depends on MODULES. While this dependency is
> > necessary when KPROBES_USE_MODULE_ALLOC=3Dy, all the other module-speci=
fic
> > code only exist to handle the case when MODULES=3Dy, and can be hidden
> > behind ifdeffery.
> >=20
> > Add the necessary ifdeffery, and remove the dependency on MODULES=3DN w=
hen
> > KPROBES_USE_MODULE_ALLOC=3Dn.
> >=20
> > Currently this allows kprobes to be used when CONFIG_MODULES=3Dn on arm=
64
> > and riscv, and other architectures can enable support by implementing
> > their own kprobes_alloc_insn_page() and kprobes_free_insn_page() which
> > do not depend on MODULES.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Link: https://lore.kernel.org/all/20240326012102.27438-1-jarkko@kernel.=
org/
> > [Mark: Remove execmem changes, depend on !KPROBES_USE_MODULE_ALLOC]
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> > ---
> >  arch/Kconfig                |  2 +-
> >  kernel/kprobes.c            | 12 +++++++++++-
> >  kernel/trace/trace_kprobe.c | 15 +++++++++++++--
> >  3 files changed, 25 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 85bb59f7b8c07..cf43de9ffb5b9 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -52,7 +52,7 @@ config GENERIC_ENTRY
> > =20
> >  config KPROBES
> >  	bool "Kprobes"
> > -	depends on MODULES
> > +	depends on MODULES || !KPROBES_USE_MODULE_ALLOC
>
> Whoops; that should be:
>
> 	depends on MODULES || HAVE_KPROBES_ALLOC
>
> ... with similar fixups in the commit message to describe HAVE_KPROBES_AL=
LOC
> rather than KPROBES_USE_MODULE_ALLOC (which does not exist in any version=
 of
> the series that got sent to the list).
>
> I'll send a v2 with that fixed (and the other changes from Jarkko's v7 ba=
se
> patch) once I've locally tested that for architectures with and without
> HAVE_KPROBES_ALLOC.

OK, please put to me to the CC list as I'm not ATM subscribed
to the tracing list.

BR, Jarkko

