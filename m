Return-Path: <linux-kernel+bounces-112521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047C887B1A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7EB281FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BE5BACB;
	Sat, 23 Mar 2024 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+CT/nGK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D761DFCE;
	Sat, 23 Mar 2024 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711236687; cv=none; b=S0wYIsTJGjqnywweMOK2BgxQupwApIgLdIju9WaRySEvpZN23UKdFCbqAp0NMEH5qPnIGnNYWO6t2t5nlwzuuDWjrpNd6emG7jqVg+rqRzvtBS1Ilr2SuciKJjLzPixGjSL5DHy17jF31crGR9e+IiEuL4eUq9SY5O52HssCZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711236687; c=relaxed/simple;
	bh=zaCzTXTmfGaOIRrExHx7AGoKpSQHIl2a+NZcwpR6yNg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fD8qAubZo6GDH11myjHKMZG4QZRhBdu7aQqYTNO7TqIl4ZfBTYQigXFOCkYkCIV5vpvjRLrd2bV1CLN+5PvLzRT/JoDgVgzAM9baK1fspTk47InfgkQ9JgbMA3qYZZZo6XecyJ7cgBjFzURSeUWGGrSBn9aywH2BzZp7E/cVozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+CT/nGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC63C433C7;
	Sat, 23 Mar 2024 23:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711236687;
	bh=zaCzTXTmfGaOIRrExHx7AGoKpSQHIl2a+NZcwpR6yNg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=B+CT/nGKhqVVameavzKkjzu7u2X4gajroTTT/+9VaH8ooN8jgr3lBp9AdNC2aoCgd
	 kORqLGS6Sb91q55FOXkNLnRjnRAYKKhEUNsJndVRAjnxEjlYQZEI9A3IvT5HyIEbko
	 CBHJL+hMcBuZTXCdXE+FQZUVRop6QsIJjso8TMh4KTniE9zxoZzRK4hEkrVUxTcQ83
	 +sEQf7sSKFkvoVHN8oM5BHI1ShLRhgtnFiIkSvYdWr2fwihvXRZLd2Zu53QE4A3dWd
	 daE/S8+bPPNci8N927EFua7d8rek8C3Ov3g3xelOYZNJoAedMQXpfXXuzDEz9RL8Nr
	 sB/UNVvMbWksg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 Mar 2024 01:31:23 +0200
Message-Id: <D01IRZK3V45H.3594SKXE83TN9@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-riscv@lists.infradead.org>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 <linux-kernel@vger.kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240323232908.13261-1-jarkko@kernel.org>
In-Reply-To: <20240323232908.13261-1-jarkko@kernel.org>

On Sun Mar 24, 2024 at 1:29 AM EET, Jarkko Sakkinen wrote:
> Tracing with kprobes while running a monolithic kernel is currently
> impossible due the kernel module allocator dependency.
>
> Address the issue by allowing architectures to implement module_alloc()
> and module_memfree() independent of the module subsystem. An arch tree
> can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.
>
> Realize the feature on RISC-V by separating allocator to module_alloc.c
> and implementing module_memfree().
>
> Link: https://www.sochub.fi # for power on testing new SoC's with a minim=
al stack
> Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian=
com/ # continuation
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

As for testing I tried the kprobes example for boottime tracing
dcoumentation:

https://www.kernel.org/doc/html/v5.7/trace/boottime-trace.html

I.e.

ftrace.event {
	kprobes.vfs_read {
		probes =3D "vfs_read $arg1 $arg2"
		filter =3D "common_pid < 100"
		enable
	}
}

kernel {
	console =3D hvc0
	earlycon =3D sbi
	trace_options =3D sym-addr
	trace_event =3D "initcall:*"
	tp_printk
	dump_on_oops =3D 2
	trace_buf_size =3D 1M
}

BR, Jarkko

