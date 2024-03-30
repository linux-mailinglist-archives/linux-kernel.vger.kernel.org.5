Return-Path: <linux-kernel+bounces-125702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEAF892AD7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C4B283385
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8138FA5;
	Sat, 30 Mar 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI8AfALq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2F383A5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711798369; cv=none; b=ZnG2rVHQpsGM1404PfqycIqULzaE2So5knE1GezTmza8PcAb6eD+PnqHVGi/OIfml1T91RDMo0EMmMJs4Fr0e2sj0EvNUPp7rRlpDywKutGnP15GDwx6fsfeaTHu6oOAM1wm4ft/3pIWOhzAJINzp6WPFJ1f2uHOvrUiFvy08ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711798369; c=relaxed/simple;
	bh=59t14P97Qbus2k7ECGdDRfg5v7qHQzW7QSOAb39Y840=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rG8iYOoLb4ZT16Ymk8nHIHPB4g3A3cZmToBgwdidN7ZDuiXKz3T7lcoK4cS5dVMmr7APoNUphDfMRg0hEfDxxtlH2/DAaKrSoC4i96gM+02nm/W7nbQMcWVDhZaQKA5uv6tgLUOScnW/fV3VjYsO0t+Z9enpPWpsvezHm5Ih5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI8AfALq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FB8C433F1;
	Sat, 30 Mar 2024 11:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711798368;
	bh=59t14P97Qbus2k7ECGdDRfg5v7qHQzW7QSOAb39Y840=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UI8AfALqa5k08DmOn0ncQGJ6dPo6DXfPJCLns+pNs/e3FsDwAvZOmyNaX4MrwE51K
	 smIJTvT7idUGoFXigrO0k7y7DZlzpJksYmrxdMVyth1XtySR1y3AOH3uP0xY5Y6PZb
	 zLYY6n8sz6CgWI5k389/TdlF4XGtgCbOEOsSjHGf/D9yQMPdD+1Ga+14AaksAehmqR
	 PrTAID0Wrl7DZYE8S8Znb/spWMN6yYsgyspYdGbahpt1M5uFlDtySZI6VnEhe/EU3A
	 w9+fF8rQ2LmyspSg4C8K2uLIlKmBAHccQLpnTnfD+uO0bxxXqCvKBjhU4OYKAmxhkW
	 pUPlnusm/ZwXQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Mar 2024 13:32:42 +0200
Message-Id: <D071VJN6N6WH.18MFJ944XMZ0O@kernel.org>
Cc: "Mark Rutland" <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
 <agordeev@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <aou@eecs.berkeley.edu>, <bp@alien8.de>, <catalin.marinas@arm.com>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>, <gor@linux.ibm.com>,
 <hca@linux.ibm.com>, <jcalvinowens@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>,
 <mpe@ellerman.id.au>, <naveen.n.rao@linux.ibm.com>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>, <tglx@linutronix.de>, <will@kernel.org>
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Masami Hiramatsu" <mhiramat@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240326163624.3253157-1-mark.rutland@arm.com>
 <20240326163624.3253157-5-mark.rutland@arm.com>
 <D03UMKC71414.2D6NN1BIWD5TZ@kernel.org>
 <ZgMICo-dZJgVklc4@FVFF77S0Q05N.cambridge.arm.com>
 <20240327090155.873f1ed32700dbdb75f8eada@kernel.org>
 <D04PYD185FIK.WABP6RZDCC06@kernel.org>
 <20240328084701.84aacecba30e83a9ce08a6d8@kernel.org>
In-Reply-To: <20240328084701.84aacecba30e83a9ce08a6d8@kernel.org>

On Thu Mar 28, 2024 at 1:47 AM EET, Masami Hiramatsu (Google) wrote:
> On Wed, 27 Mar 2024 19:46:50 +0200
> "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
>
> > On Wed Mar 27, 2024 at 2:01 AM EET, Masami Hiramatsu (Google) wrote:
> > > On Tue, 26 Mar 2024 17:38:18 +0000
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > > On Tue, Mar 26, 2024 at 07:13:51PM +0200, Jarkko Sakkinen wrote:
> > > > > On Tue Mar 26, 2024 at 6:36 PM EET, Mark Rutland wrote:
> > > >=20
> > > > > > +#ifdef CONFIG_MODULES
> > > > > >  	/* Check if 'p' is probing a module. */
> > > > > >  	*probed_mod =3D __module_text_address((unsigned long) p->addr=
);
> > > > > >  	if (*probed_mod) {
> > > > > > @@ -1605,6 +1606,8 @@ static int check_kprobe_address_safe(stru=
ct kprobe *p,
> > > > > >  			ret =3D -ENOENT;
> > > > > >  		}
> > > > > >  	}
> > > > > > +#endif
> > > > >=20
> > > > > This can be scoped a bit more (see v7 of my patch set).
> > > >=20
> > > > > > +#ifdef CONFIG_MODULES
> > > > > >  static nokprobe_inline bool trace_kprobe_module_exist(struct t=
race_kprobe *tk)
> > > > > >  {
> > > > > >  	char *p;
> > > > > > @@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_mo=
dule_exist(struct trace_kprobe *tk)
> > > > > > =20
> > > > > >  	return ret;
> > > > > >  }
> > > > > > +#else
> > > > > > +#define trace_kprobe_module_exist(tk) false /* aka a module ne=
ver exists */
> > > > > > +#endif /* CONFIG_MODULES */
> > > > > > =20
> > > > > >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> > > > > >  {
> > > > > > @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct tra=
ce_kprobe *tk)
> > > > > >  	return ret;
> > > > > >  }
> > > > > > =20
> > > > > > +#ifdef CONFIG_MODULES
> > > > > >  /* Module notifier call back, checking event on the module */
> > > > > >  static int trace_kprobe_module_callback(struct notifier_block =
*nb,
> > > > > >  				       unsigned long val, void *data)
> > > > > > @@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(str=
uct notifier_block *nb,
> > > > > > =20
> > > > > >  	return NOTIFY_DONE;
> > > > > >  }
> > > > > > +#else
> > > > > > +#define trace_kprobe_module_callback (NULL)
> > > > > > +#endif /* CONFIG_MODULES */
> > > > >=20
> > > > > The last two CONFIG_MODULES sections could be combined. This was =
also in
> > > > > v7.
> > > >=20
> > > > > Other than lgtm.
> > > >=20
> > > > Great! I've folded your v7 changes in, and pushed that out to:
> > > >=20
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/lo=
g/?h=3Dkprobes/without-modules
> > > >=20
> > > > I'll hold off sending that out to the list until other folk have ha=
d a chance
> > > > to comment.
> > >
> > > Yeah, the updated one looks good to me too.
> > >
> > > Thanks!
> >=20
> > As for RISC-V:
> >=20
> > Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # arch/riscv
>
> Thank you for testing!
>
> >=20
> > I'm fine with adding to all patches because it would be hard
> > to place tested-by to any specific patch (e.g. if this was a
> > syscall I would give tested-by just for that patch).
>
> Except for the 1st patch because that is for arm64, right? :)

Right! For that not required :-)

>
> >=20
> > Just adding disclaimer because depending on subsystem people
> > are more or less strict with this tag :-)
> >=20
> > BR, Jarkko
>
> Thanks,

BR, Jarkko

