Return-Path: <linux-kernel+bounces-21378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B21828E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5111F25165
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E164C3D57E;
	Tue,  9 Jan 2024 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jRDFwKkX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC43D553;
	Tue,  9 Jan 2024 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DEB9540E016C;
	Tue,  9 Jan 2024 20:04:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NiYoeZQQalKc; Tue,  9 Jan 2024 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704830687; bh=myWkA513SB++du6rtg253t0uQ7b+BjB5yRYgGmBmizI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRDFwKkXwbGGoD+MXs3OvMjNvwwQ9+CgDrEGogr4gtth8jcaqGA8nzkG6phHrHdiw
	 8ugfNNYWrUrEjXOAuS7WmAVEc6Y4KIY8DxF9XSwUt9/FsYqf3a1Hamp+z/8pqKTZXR
	 vxF759udYi/x+hWjxVmhoRYBoXlnI0F3rxwra4MNrw7ykwLZqxN1fCsbKQi0JGJU6E
	 4UqhwVYJsprHSek0/xQUfGtb1DLdycaE60aYKDt0TKzEm8l1ArGPczjygFuQN5qxCm
	 svHe9DvPmA9s/xj3vir7igBmlPzYsp0V8ghadpKNLDqBm49MbyPk6iVTZK8j7DW9nd
	 9mf1Nxo/tdGpx+otoEPf46qdRbI4oijuNAqW2lYw553J5+baptZe/KXrr6zYOqtxJG
	 0XYW9abUMNjA1b4j8k07YZ7TYcVMxRGRUOt0CArFdP5nGaKX/+qHlmEIUD4oKXHsEa
	 22w8Sygby3jq0bPFUFnqkSZ/cU/7Ip3h0dWZyjmknv55YL/CprPIE+v1AA2OM0GFXN
	 DRuIn5lu3UmZ6RQ1D2KwB0UoCnQGw5UJXsACuo/hU92ngguf2Y0hQQGxoyXVhxH3cZ
	 tGehj+8PwCjVI3ktug0TE2g8tqg2Kjx6G+koOtkF5L0CEzTj+5nfWogJufXG0pmPHQ
	 tbGUBMauPQB+Ejg4fQpSfNnY=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52EFA40E01B2;
	Tue,  9 Jan 2024 20:04:39 +0000 (UTC)
Date: Tue, 9 Jan 2024 21:04:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muralidhara M K <muralidhara.mk@amd.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Begin a RAS section
Message-ID: <20240109200434.GBZZ2m0vWjm9v795YX@fat_crate.local>
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
 <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
 <87a5pes8jy.fsf@meer.lwn.net>
 <20240109183646.GAZZ2SPiMZv83J3f0a@fat_crate.local>
 <87wmsiqok6.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmsiqok6.fsf@meer.lwn.net>

On Tue, Jan 09, 2024 at 12:44:41PM -0700, Jonathan Corbet wrote:
> Of course, I miss things in my own email too...you know the drill...

Yeah, tell me about it.

My train of thought with CCing maintainers in such cases usually is: I'd
CC the mailing list as I don't want to bother the maintainer - she/he gets
too much email anyway and this is an FYI thing anyway so she/he'll find
it in the archives eventually.

> Yes, there is a lot of existing documentation that still doesn't live up
> to this idea, but we can try to follow it for new stuff while the rest
> is (slowly) fixed up.

The problem I see here is that not all of the RAS stuff will be
"admin-guide" stuff but some design decisions we've made. I mean, if it
is a really curious admin, it'll fit her/his alley but it won't be
purely administrative tasks' descriptions.

In the end of the day, I don't really care where it is as long as it is
in one place and we can point people to it and say, here, that's why we
did it the way we did it and what you can do about it.

So I'm fine with admin-guide too - just pointing out a potential issue
I see.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

