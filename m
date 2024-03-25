Return-Path: <linux-kernel+bounces-117987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 269DB88B5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0CEDC636E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FDF5C8E1;
	Mon, 25 Mar 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB97ZrcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BD59B52;
	Mon, 25 Mar 2024 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399845; cv=none; b=bLNfdAjCAFCVUtAT+Hxid//cpBbYjbTIXZyIWaQ4ZFaiaZ6/UC76y33hrpviNVCpbJNzU+uFH0SdeFniOnEZRP14kuL66YapmD3MPzMG8v8Ol1UCAR8ar42uyzGZrR5qed24k7grL0LyHvZjNCOUpa5EcIy3gEyn2BhZ9ViRXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399845; c=relaxed/simple;
	bh=nwpWNJ7Rq9nWxFjGUbTYvZ8rrXcuvUx4PD8XjiRJP98=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ltlk/HA/zVtcJLku15+JXemCo5vMQsGh4tlQL1A8Rt7HQdqbBIZ6Prla4C4rjTNJSfag+jUbIw7KrzS+kJ389kCX6wA2xbacNQ02VwrRMiznH0DSNEUow9/DuIpo8H8aeeUXAhLgdfslVL8gNlz4uFB6TPovjIVjOXJ0gUcQG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB97ZrcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCEEC433C7;
	Mon, 25 Mar 2024 20:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399845;
	bh=nwpWNJ7Rq9nWxFjGUbTYvZ8rrXcuvUx4PD8XjiRJP98=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SB97ZrcSI2pLHFXsw+oj5amBylNVmymv+FPWWcYtfpoQwYznb+o7ooG/Q3UrhCMmR
	 NrnumCMSzASq3eFhi1FVniahuIvABwjhcof2L3TyuOkd5noG3RnHb5DGz0H6KDQR0k
	 uSxFsmyYmAg5xxTllnUFXfTCF+lWEojUu7QSlTfAyfbm0oVX1+G5kZKgI5LEK3Dgw0
	 A1GOKSqg8lOw1Jr3snDb103h8/CwoNAW6HSWvRJzDqTI3djLJwxF+4fLBRdGHclh7m
	 ZL7SFlRWjjEsbXsFXa5gIhRFaDusjA+RfF6fU5C5NQoF8SBF7Ig8OH2HY1O66R7ltU
	 s8lO9DVr9bvkw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Mar 2024 22:50:40 +0200
Message-Id: <D034M18D63EC.2Y11D954YSZYK@kernel.org>
Cc: "Masami Hiramatsu" <mhiramat@kernel.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/2] kprobes: textmem API
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-riscv@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20240325203755.1811-1-jarkko@kernel.org>
In-Reply-To: <20240325203755.1811-1-jarkko@kernel.org>

On Mon Mar 25, 2024 at 10:37 PM EET, Jarkko Sakkinen wrote:
> -	if (ret =3D=3D -ENOENT && !trace_kprobe_module_exist(tk)) {
> +#ifdef CONFIG_MODULES
> +	if (ret =3D=3D -ENOENT && trace_kprobe_module_exist(tk))
> +		ret =3D 0;
> +#endif /* CONFIG_MODULES */

For this we could have

#ifndef CONFIG_MODULES
#define trace_kprobe_module_exist(tk) false
#endif

That would clean up at least two locations requiring no changes. Should
I go forward this or not?

BR, Jarkko

