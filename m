Return-Path: <linux-kernel+bounces-121740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1483888ED26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4603A1C26717
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59059153833;
	Wed, 27 Mar 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbVTnNry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19914F9F1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561616; cv=none; b=KtN/29+24K6QeJUOue2WY46t9jQ9/1E66ro3Ugc5N495ktg3IUPrernjAwmQ3uhvVCTUelukTCTyiVmN6PzVK9pvWp0cf7vYcVJBZJl+vTeGV/ejLj3/ljakMLLJ77fTs0OG3T4rrj6SV9n7MLJZxRP7oqIGE15O2mf7OI50eEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561616; c=relaxed/simple;
	bh=+JLGX36YP90VROvvA1SVh8R1mRHl0Ghl/7lpEVb6bo0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eXrDun6d1wgI4i9Dpy/8bq97vO8qRMOwnorappqMTmaCDftkU/F1uOrKmAjm0rlSXrn+sgJxrpZN9e4GyrUWZANUgZ8gQ3/3+RAQnanJK8+k9VMroLizzDz798zoqGhN4cvO6EbKrvXkYn4CkX3t3U55W26KOedoyx0f5W4UbrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbVTnNry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C063C433C7;
	Wed, 27 Mar 2024 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711561616;
	bh=+JLGX36YP90VROvvA1SVh8R1mRHl0Ghl/7lpEVb6bo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbVTnNryCOCvZ0IKvA3CTaFuKaG//yheGiNyp7ASv2D6PEhQi3q9LxNZbbShnm8MO
	 sZdyp4MdS4nTGIy1KXIGiROGocQpc61GKmJYSb3j47b2VoIOTIoHMjz9OG4Ft0dV9c
	 VhOeFDQStAaK/z4wUv8tPETLT41Af9SRMwkllKIdGZ70o+lZt16ibupYK3/+EbIv01
	 DTZWIYZHRo+tUsQZu1jJ7R5kq4/r0566Qrw09MD4+qR1udomiyigb0sLWPu0ebGyvr
	 hkCmbstnM7u49tESQQzyL94fdAL5JYujU3ZzS5RFhfUymvplvreuHx8KxeIRL2pAPQ
	 nRPIOumYqKH3g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Mar 2024 19:46:50 +0200
Message-Id: <D04PYD185FIK.WABP6RZDCC06@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Masami Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>
Cc: <linux-kernel@vger.kernel.org>, <agordeev@linux.ibm.com>,
 <anil.s.keshavamurthy@intel.com>, <aou@eecs.berkeley.edu>, <bp@alien8.de>,
 <catalin.marinas@arm.com>, <dave.hansen@linux.intel.com>,
 <davem@davemloft.net>, <gor@linux.ibm.com>, <hca@linux.ibm.com>,
 <jcalvinowens@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
 <mingo@redhat.com>, <mpe@ellerman.id.au>, <naveen.n.rao@linux.ibm.com>,
 <palmer@dabbelt.com>, <paul.walmsley@sifive.com>, <tglx@linutronix.de>,
 <will@kernel.org>
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
X-Mailer: aerc 0.17.0
References: <20240326163624.3253157-1-mark.rutland@arm.com>
 <20240326163624.3253157-5-mark.rutland@arm.com>
 <D03UMKC71414.2D6NN1BIWD5TZ@kernel.org>
 <ZgMICo-dZJgVklc4@FVFF77S0Q05N.cambridge.arm.com>
 <20240327090155.873f1ed32700dbdb75f8eada@kernel.org>
In-Reply-To: <20240327090155.873f1ed32700dbdb75f8eada@kernel.org>

On Wed Mar 27, 2024 at 2:01 AM EET, Masami Hiramatsu (Google) wrote:
> On Tue, 26 Mar 2024 17:38:18 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
>
> > On Tue, Mar 26, 2024 at 07:13:51PM +0200, Jarkko Sakkinen wrote:
> > > On Tue Mar 26, 2024 at 6:36 PM EET, Mark Rutland wrote:
> >=20
> > > > +#ifdef CONFIG_MODULES
> > > >  	/* Check if 'p' is probing a module. */
> > > >  	*probed_mod =3D __module_text_address((unsigned long) p->addr);
> > > >  	if (*probed_mod) {
> > > > @@ -1605,6 +1606,8 @@ static int check_kprobe_address_safe(struct k=
probe *p,
> > > >  			ret =3D -ENOENT;
> > > >  		}
> > > >  	}
> > > > +#endif
> > >=20
> > > This can be scoped a bit more (see v7 of my patch set).
> >=20
> > > > +#ifdef CONFIG_MODULES
> > > >  static nokprobe_inline bool trace_kprobe_module_exist(struct trace=
_kprobe *tk)
> > > >  {
> > > >  	char *p;
> > > > @@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_module=
_exist(struct trace_kprobe *tk)
> > > > =20
> > > >  	return ret;
> > > >  }
> > > > +#else
> > > > +#define trace_kprobe_module_exist(tk) false /* aka a module never =
exists */
> > > > +#endif /* CONFIG_MODULES */
> > > > =20
> > > >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> > > >  {
> > > > @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct trace_k=
probe *tk)
> > > >  	return ret;
> > > >  }
> > > > =20
> > > > +#ifdef CONFIG_MODULES
> > > >  /* Module notifier call back, checking event on the module */
> > > >  static int trace_kprobe_module_callback(struct notifier_block *nb,
> > > >  				       unsigned long val, void *data)
> > > > @@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(struct =
notifier_block *nb,
> > > > =20
> > > >  	return NOTIFY_DONE;
> > > >  }
> > > > +#else
> > > > +#define trace_kprobe_module_callback (NULL)
> > > > +#endif /* CONFIG_MODULES */
> > >=20
> > > The last two CONFIG_MODULES sections could be combined. This was also=
 in
> > > v7.
> >=20
> > > Other than lgtm.
> >=20
> > Great! I've folded your v7 changes in, and pushed that out to:
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=
=3Dkprobes/without-modules
> >=20
> > I'll hold off sending that out to the list until other folk have had a =
chance
> > to comment.
>
> Yeah, the updated one looks good to me too.
>
> Thanks!

As for RISC-V:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # arch/riscv

I'm fine with adding to all patches because it would be hard
to place tested-by to any specific patch (e.g. if this was a
syscall I would give tested-by just for that patch).

Just adding disclaimer because depending on subsystem people
are more or less strict with this tag :-)

BR, Jarkko

