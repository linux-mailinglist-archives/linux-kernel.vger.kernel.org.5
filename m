Return-Path: <linux-kernel+bounces-118214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226BB88B62B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298E32E728D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3B18AED;
	Tue, 26 Mar 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1VRJNiN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899EFBEA;
	Tue, 26 Mar 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413374; cv=none; b=E7gbaBJuIJcvuEli7F2I0MT8QkcptfCT0zvxmxcezK873jn8ZtScbix9/oHH4pNaA53Hsyvw0OCoTROadoHQQ62RSCj5ULF1U+0k7oUFADwU6tpDPXfxAuA+XcetIjoIDp9WWZw0jvnd+ltYOLBNDVbKd97ZKUGZ5vXqPX+Pk6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413374; c=relaxed/simple;
	bh=xE992nxnooOSMpHEL8KfQyXIz2aD8fuvJwriFo5N6/c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lXHv4wwjcZsoG63LEEsUhdhzd7jUIUIZLI3EikixE/Zux7N8J/4tP7JHvKSyUKUVhUyS3gkcPT0zyWdAaCdx/f/XJjMDpy7vtE96H6ueoowxeZKaYMPWooG/hVvDXF3twy6fkYN3RfQYDDcTq7pJNvxHRKkl7TNaqia+lTM7ADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1VRJNiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B26C433C7;
	Tue, 26 Mar 2024 00:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711413374;
	bh=xE992nxnooOSMpHEL8KfQyXIz2aD8fuvJwriFo5N6/c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=H1VRJNiNWYhI+4V6opqODUgwJ+FQYQs04FpCcw+FrvrHpJ05AeCr3C9moPTNC7M2M
	 m1KITlz+y004QgwfaB4Tf5lbe9P+5n6ezFqDLiF1oH5XAVlR5AadOCOqYMyZ9htdDe
	 qnBZk3yrBc4aLzBsODzKiQ+xzoWFTMUK1tlLQ9EuS4kZgqepcIOTs4jDMcd8zVhNk1
	 ge7eWjVY6BzZo/JezXcB3/Qcr95DG9OQdU3clrvSKh/sJT80q9ZOZHx0nqLPDxVf5F
	 EFyJwk+5J96QRWGkPnlA4Lcnv7U7EEwt6oMEHw2KFLwijoDe6E0+6nHWPsLh2f4CvW
	 /2K4kfpHeS+gw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 02:36:10 +0200
Message-Id: <D039EOFEEV74.3U6K3816DEQ28@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Masami Hiramatsu" <mhiramat@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
 <D036AJAEAOUF.34494O217N0RI@kernel.org>
 <20240326085037.0142d7dadc702e3b49a3251e@kernel.org>
In-Reply-To: <20240326085037.0142d7dadc702e3b49a3251e@kernel.org>

On Tue Mar 26, 2024 at 1:50 AM EET, Masami Hiramatsu (Google) wrote:
> On Tue, 26 Mar 2024 00:09:42 +0200
> "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
>
> > On Mon Mar 25, 2024 at 11:55 PM EET, Jarkko Sakkinen wrote:
> > > +#ifdef CONFIG_MODULES
> > >  	if (register_module_notifier(&trace_kprobe_module_nb))
> > >  		return -EINVAL;
> > > +#endif /* CONFIG_MODULES */
> >=20
> > register_module_notifier() does have "dummy" version but what
> > would I pass to it. It makes more mess than it cleans to declare
> > also a "dummy" version of trace_kprobe_module_nb.
>
> That is better than having #ifdef in the function.
>
> >=20
> > The callback itself has too tight module subsystem bindings so
> > that they could be simply flagged with IS_DEFINED() (or correct
> > if I'm mistaken, this the conclusion I've ended up with).
>
> Please try this.
>
> -----
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 70dc6179086e..bc98db14927f 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2625,6 +2625,7 @@ static void remove_module_kprobe_blacklist(struct m=
odule *mod)
>  	}
>  }
> =20
> +#ifdef CONFIG_MODULES
>  /* Module notifier call back, checking kprobes on the module */
>  static int kprobes_module_callback(struct notifier_block *nb,
>  				   unsigned long val, void *data)
> @@ -2675,6 +2676,9 @@ static int kprobes_module_callback(struct notifier_=
block *nb,
>  	mutex_unlock(&kprobe_mutex);
>  	return NOTIFY_DONE;
>  }
> +#else
> +#define kprobes_module_callback	(NULL)
> +#endif
> =20
>  static struct notifier_block kprobe_module_nb =3D {
>  	.notifier_call =3D kprobes_module_callback,
> @@ -2739,7 +2743,7 @@ static int __init init_kprobes(void)
>  	err =3D arch_init_kprobes();
>  	if (!err)
>  		err =3D register_die_notifier(&kprobe_exceptions_nb);
> -	if (!err)
> +	if (!err && IS_ENABLED(CONFIG_MODULES))
>  		err =3D register_module_notifier(&kprobe_module_nb);
> =20
>  	kprobes_initialized =3D (err =3D=3D 0);

OK, thanks for the suggestion WFM.

I'll give this also a spin with VisionFive2 RISC-V SBC before sending
v6.

BR, Jarkko

