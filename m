Return-Path: <linux-kernel+bounces-112545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7027887B5A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013A928230D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09FC1C05;
	Sun, 24 Mar 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4USRb7l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83581E;
	Sun, 24 Mar 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246181; cv=none; b=SujF9aZDfiE7s03MEaqwiFoSWa9GCB21WIp493rQ8KZX82U9x6COBfyi33/K2K+nDsUeKmzHUx+Dtol7WABDb6fsONf/h1SPBxcT4mGZ0gStMfusPO/SfSM6gNxAAxMXhBJ7tX6NDz+SE0AtWDKeP/m2/j0xa7ym8BrPKwGeyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246181; c=relaxed/simple;
	bh=xLFaz7y9iLJbenBgB0XSOQ7OAJTa+9SPB03yg2l70K4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bBpjMGTPEcIBE4aHqglHV2/k5QaNSc21OrBvX/VmZb2XS6eeza3sc/chLv+jVy0R5y4ObuaGhMVCqgqoVg3lh4LogFHBXVNj/vm4eZbgadn274/ZzRyGqRm1kkaSLosm4i4fu/2OOKN0N1WldbmdLm5QyV2M/bzgs+abJA0bSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4USRb7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F56C433C7;
	Sun, 24 Mar 2024 02:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711246180;
	bh=xLFaz7y9iLJbenBgB0XSOQ7OAJTa+9SPB03yg2l70K4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=l4USRb7l32g9v7Lkc9P2AyB3UUtf7sayKNOxlLtFvzeUmTi5an51pxlE+M+tezxqh
	 feKB8/Zh+/TPPQm2gIrcJ8f3WkUIPXcSovyIb4gf1sjH7oguPpsQMVXYwFVUB8N7AN
	 uwphr1NNMu8kB2MwBIsoDwBTeU6h2/guGX4/0Jma5Clu6HKmyPbOBgxPNzv1Pr9q7p
	 7OuwWyrlmLgIpaOZbtl7vDidi5HTyUGJKT6hiw4RKuZ3gzUwcQJPAYZDMgqYZFM15x
	 b34WTOWTyYUkMRZHjnJ936PU4sAmgTG6SpNQBx+m6jNYPdm8EykPflDBsk0jt60+te
	 lUAY0G6IeDA1g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 Mar 2024 04:09:36 +0200
Message-Id: <D01M54N1B35C.2SDKQ5GG2CJP@kernel.org>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 <linux-kernel@vger.kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>,
 <linux-riscv@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20240323232908.13261-1-jarkko@kernel.org>
 <40c96057-4bd8-4743-bea1-5d848f0e0c84@infradead.org>
In-Reply-To: <40c96057-4bd8-4743-bea1-5d848f0e0c84@infradead.org>

On Sun Mar 24, 2024 at 2:37 AM EET, Randy Dunlap wrote:
>
>
> On 3/23/24 16:29, Jarkko Sakkinen wrote:
> > +config HAVE_KPROBES_ALLOC
> > +	bool
> > +	help
> > +	  Architectures that select this option are capable of allocating mem=
ory
> > +	  for kprobes withou the kernel module allocator.
>
> 	              without

Thanks, will fix.

BR, Jarkko

