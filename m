Return-Path: <linux-kernel+bounces-117796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C988AFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C852321D45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369F1773A;
	Mon, 25 Mar 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvHK54vC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDF1CAAA;
	Mon, 25 Mar 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394220; cv=none; b=AVG4jf3vGOrJryF8nu9vSKYRfttdD3xiIB70rIMNFhhb1wOSfFPE8+8isgzDCbHJ5Os5SKleOKBx6IM/CMcd5H0g0NiJXcVVQRRQYmtIgBTFUPklSHSZJV3XYJ/eU8sGF0B8wcHAbJUsq/2fbx5TKLF/LQ42J1mVd7c3KvT0RVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394220; c=relaxed/simple;
	bh=hii92yni5m4VfZz2P67wncTjXZJRmTHvfpwyMPi4358=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=BM7ILefssegu7/EisV1x66dkfwY+aLy8b9iysp2iJdL1QSJc5pLi0oC7dE6B/5l5ezY2SRt/6qdyEtB3ys0gUu/LjlvQryd0LdDj0AkVJJFUlugp+dCHZAlPZfWF11/i0cnGDp447rm6Yoo3Kv3xzibpjwO/+Wgb6X7mtBJXtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvHK54vC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FEDC433C7;
	Mon, 25 Mar 2024 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711394219;
	bh=hii92yni5m4VfZz2P67wncTjXZJRmTHvfpwyMPi4358=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvHK54vCdibf8Bx3wsJsAhxLlpKrBU2MsRU/IPvCTu6oTcuXEieM7ySmo+I/P16YC
	 /DdrWdwGtdEN5Q5T12edc/DsKmVXyuiWybT/F9vnLo9t+zrDP9e4E1BK6qw0K4j+aZ
	 OmDi+tUZ7HmB9qQPQ8i7epvDcgkX/G4cC0jPiy1nsWBNAGndu+kQdJlHsKOLZ9vJUK
	 3F2xfv/uj+L8hL++3pnZtwWAVmYQjKG2iI5g8uu4CmtfeVBtGAbS/XWo92bbRT4aSG
	 PLdDhVg5aIR938fsKUCBoiodr3ZQ3xPoFvE42SkRe/nQW4ppf6bleuUOBQaLXPoeUs
	 Snh0j5cU67dMQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Mar 2024 21:16:55 +0200
Message-Id: <D032M8W5K5M5.1ZBHEIJFFNTCI@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Naveen N .
 Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 <linux-trace-kernel@vger.kernel.org>, "Calvin Owens"
 <jcalvinowens@gmail.com>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
X-Mailer: aerc 0.17.0
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
 <D031SE4QN1CG.18GY6AS20QF1J@kernel.org>
 <D032IFOPKJI8.3TKDPQQI9I6LG@kernel.org>
In-Reply-To: <D032IFOPKJI8.3TKDPQQI9I6LG@kernel.org>

On Mon Mar 25, 2024 at 9:11 PM EET, Jarkko Sakkinen wrote:
> On Mon Mar 25, 2024 at 8:37 PM EET, Jarkko Sakkinen wrote:
> > > You also should consider using IS_ENABLED(CONFIG_MODULE) in the code =
to
> > > avoid using #ifdefs.
>
> Hmm... I need make a couple of remarks but open for feedback ofc.
>
> First, trace_kprobe_module_exist depends on find_module()
>
> Second, there is a notifier callback that heavily binds to the module
> subsystem.
>
> In both cases using IS_ENABLED would emit a lot of compilation errors.

Also I think adding 'gfp' makes sense exactly at the point as it has
a use case, i.e. two call sites with differing flags. It makes sense
but should be IMHO added exactly at that time.

Leaving it from my patch set does not do any measurable harm but please
correct if I'm missing something.

BR, Jarkko

