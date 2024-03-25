Return-Path: <linux-kernel+bounces-118090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9B88B3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2EA305B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284C768EC;
	Mon, 25 Mar 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxDMNdWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8B76026;
	Mon, 25 Mar 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405011; cv=none; b=prJy7OvHmEd/sQJr0tC9C73VL73R4NFyrbzMhRkFpsyyCvyyH0vQ6kTnpmoueC3hBJnq8JUopFAsfNh4nu31e5Iac/Gg0BR7O0AW+DZ4NDwa313302u8Nkxbj8nXuVf6zPujdV+iQxRc0pYLv/PPgvQxRXL6Ja2/hp9GnR1lFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405011; c=relaxed/simple;
	bh=OXhGVZPdG3D/LddT2Wq1BEL14paCWK/DFyKMWaLrsZA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Upv95FVvxoCPKXAh3B3VBhyZ2ZXBT3rd0Fr3JWP8sBim/0ZsHrnutSbZQ/zksvu9Dblg7z+uyvL7kfbemtVuoCaNnriO/Slbr+LB2p72aGIIbTzCltf3Op0qq6rn0wYkpwHASejyVe8YycR9/A4AWCjVMzfE0g7QzTM+kODbCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxDMNdWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3090C433C7;
	Mon, 25 Mar 2024 22:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711405011;
	bh=OXhGVZPdG3D/LddT2Wq1BEL14paCWK/DFyKMWaLrsZA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UxDMNdWQkRpfuq/NE9RO36csB0eXkWTvW9/ekSSg/CAUrs1oVq1JezifL7/4ZMVy/
	 NL3vHYHuOyNkfWTwOn9oYOiyjQmOPWg6Iqx5LJZhshKTUJLpnow6aK4MlG/l29Th7a
	 x44I1AaMRFq3AQYlaThm1A2FWuqpEBXw4QlusUwsAMyMd6nFjcaPX446CZZtqz7pDr
	 dk6MHakJDWI9VAx3n3tYIlqn8bnQ6H2qGd4hxekUHuch/XJnvBQVDeskPB3Pzo+IY1
	 HRxizaNEivdeN0OvdCOHeZPJlpWDIkQjqLhFoC0PYehzOQMC3lWoNIoDbUBmJAYnAl
	 4z7N0ASHEujjQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 00:16:46 +0200
Message-Id: <D036FYBQUMIX.L5TL0SUCAO49@kernel.org>
Cc: "Masami Hiramatsu" <mhiramat@kernel.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-riscv@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
 <D036AJAEAOUF.34494O217N0RI@kernel.org>
In-Reply-To: <D036AJAEAOUF.34494O217N0RI@kernel.org>

On Tue Mar 26, 2024 at 12:09 AM EET, Jarkko Sakkinen wrote:
> On Mon Mar 25, 2024 at 11:55 PM EET, Jarkko Sakkinen wrote:
> > +#ifdef CONFIG_MODULES
> >  	if (register_module_notifier(&trace_kprobe_module_nb))
> >  		return -EINVAL;
> > +#endif /* CONFIG_MODULES */
>
> register_module_notifier() does have "dummy" version but what
> would I pass to it. It makes more mess than it cleans to declare
> also a "dummy" version of trace_kprobe_module_nb.
>
> The callback itself has too tight module subsystem bindings so
> that they could be simply flagged with IS_DEFINED() (or correct
> if I'm mistaken, this the conclusion I've ended up with).

One way to clean that up would be to create trace_kprobe_module.c and
move kernel module specific code over there and then change
kernel/trace/Makefile as follows:

ifeq ($(CONFIG_PERF_EVENTS),y)
obj-y +=3D trace_kprobe.o
obj-$(CONFIG_MODULES) +=3D trace_kprobe_module.o
endif

and define trace_kprobe_module_init() or similar to do all the dance
with notifiers etc.

This crossed my mind but did not want to do it without feedback.

BR, Jarkko

