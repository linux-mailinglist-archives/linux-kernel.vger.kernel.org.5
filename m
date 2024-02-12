Return-Path: <linux-kernel+bounces-61225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3111E850F33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606C01C21647
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C122F101E8;
	Mon, 12 Feb 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DZv6WyXu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF5F9F6;
	Mon, 12 Feb 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728303; cv=none; b=JRBKgBHUGNE4tvvx0+d6aSSlV93iANjT4iNChxT8dzSRzuMtqoqSOxYc8UbAaSankJDMekJL5kelx0HAvvk3Bf1H+v3lPubW+N/TBKIYWHcTIcPrxwphjwC1yH0JKT3AZmazeRC5xF6EhP4xLUORDvqEzCh3m17mhvq1ZkRcHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728303; c=relaxed/simple;
	bh=EFbAo5Rl95aibYF8oFEUt72wxVkfbyL6b/P7OhQU69M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV2Hxj+TYtuMe3Yf2rHjhvrmEQ06R9Soj+IzNtYoqmeF7kDi1aMmlQuQsmLsAWXfkCUlaJp2S0bs3xK9FsLvhaj9jHNtkm7wRN3JhOrUnsu4vNaYih9fmNwpuV0+qnDFazKNp2c4FiUOBJvsB6PH0CPxE+RXRwZRoCGBwYttm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DZv6WyXu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A7C540E01BB;
	Mon, 12 Feb 2024 08:58:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FxmW8naFuC6X; Mon, 12 Feb 2024 08:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707728295; bh=ALQo+vhtcBSeaciFu9mi9BnzZHS69M+JAJQ5itizn1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZv6WyXuUps4/WYMeUUGXuVF8kT1YuzBhba3JkwV+7/FDAT/gH908g3MkniZNYlC8
	 GTmM/aFmUSxLJi7PZp5dcKWe8FWxYmiKuu/1SMBaJER1ZswvBGNcX7RjDa8EEYJfS2
	 UJgPgkTqmliPp02bFPXvIh7+HPyzi6EhJpxu/GAOo6HLLCEzkiN9ERJZ8ii6u+beRd
	 ERv4L21DhSSAzFDUqsuKVt0nbrE0IZrmhFZ4FB9r1sNGdbS8EqkrILy7RCOt3sDXK1
	 LSnd5hPHxZDxs3RfrddoCXqJiRqZlQ48sidJwGIQxUJoeHZB1IZ5A0WtTuz/u/XGV0
	 RqRawwoxwKzme7tinRwmbk9a+1npsEoM97NxONb07TcbcfwEOz7HjnbyPFvwBOY7Yc
	 /PW3WP8GEh6G3YOyqooSBE/qHbD0mpG23zb1pYxRzWKVxYKQjHtTi6CTSoQo/xSXyM
	 i2o9u/O/st+1TotjhXL/19hjrZgGPT7299tPTBhpOGRkDbSg18WQwvODnTv36J5hWZ
	 96S5GuhZrqbwQ77t5zXMs9CG/A7+ca9RPzb8W/nDqAeBE9yAZ07tztkBvDxidOsghL
	 0W+ZquRdYCfjKhld4qKiTM15lBWvwyOU7OUNG589YsUZVxmRKMamjZmdpqEpEi5M0X
	 oZvgV1JSdonrhkt3U5QfIkiw=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9A2040E0196;
	Mon, 12 Feb 2024 08:58:07 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:58:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
References: <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>

On Sun, Feb 11, 2024 at 08:54:29PM -0600, Naik, Avadhut wrote:
> Okay. Will make changes to allocate memory and set size of the pool
> when it is created. Also, will remove the command line parameter and
> resubmit.

Before you do, go read that original thread again but this time take
your time to grok it.

And then try answering those questions:

* Why are *you* fixing this? I know what the AWS reason is, what is
yours?

* Can you think of a slick deduplication scheme instead of blindly
raising the buffer size?

* What's wrong with not logging some early errors, can we live with that
too? If it were firmware-first, it cannot simply extend its buffer size
because it has limited space. So what does firmware do in such cases?

Think long and hard about the big picture, analyze the problem properly
and from all angles before you go and do patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

