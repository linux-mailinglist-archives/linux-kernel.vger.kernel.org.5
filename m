Return-Path: <linux-kernel+bounces-41161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A8F83ECC1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76DCDB223E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67831F5F3;
	Sat, 27 Jan 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KVB37s6i"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD98831
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706352783; cv=none; b=Ikqc5Rt0vQQXxkjsJggthbOiQfunHWrG8QOLOch2uGLUn9mI2Yy1MD1XVrSSQYNZ/EH8i3Cjc7ZneDirkgMbm1hDC8ii/F9HUhOyo2ECoF9qhopzmgoxcp3ZDo/FX4av64jw/6FsUUzhc7jQ2zdXe0cfROfq4qguA8DVGOuAoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706352783; c=relaxed/simple;
	bh=DyoUpSoxEx47XCTjNHBHjIl/ty6E7ZVtuvhmYoyyVnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1E97bs70aQj6UToNUuNiNaK2YOIJdt5uEnM34WgZ5OuVXQGnkBJ8/4dbCUv/01vnHoKcQ5NPZKh0l/sIXLIzqtSuHtv6n5v/zAFFB7vrfg4NFt8VXug+kwrUUrIyiCd1YuH55n4CGbc9LjFCwQU7y8h5ZQMRrxV4yhxJR39jOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KVB37s6i; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E3F5840E01A9;
	Sat, 27 Jan 2024 10:52:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fVxqixxfNtXk; Sat, 27 Jan 2024 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706352773; bh=OLjAmBzqcHS3trlzUm53Oc4m3KbabTJB0bcuDDd9nu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVB37s6ijlYMqmGnUPiIYDPknHWYweiVGiB0zF60TQUFL/mTHXSqcfRt0EYS4VmPG
	 2SPdWu+jT9KnR1/BRMlyEOfXV+zHSGv0jsnWI+Bg7PhVLDvpbXFe3HvmfW642u4fnS
	 5RDFunZ/jjqKQd1ZtESBX8PQN44dtWbobRwfKEjeeGtauDIdEXpUj/qFbvi8YVFlcX
	 IbyzkVBlx/mY1u4HPtKAksklcpdi7ODxCx/IsvKhHk6MYCbnNS1E5s7cc6r8qDwQWS
	 79zd9W3gMow3D+d6XCNnWmMCPZ+n4UjrFmTQr7me58ybBXlHoSnzzzaRlJ1fJVI4bm
	 QglFr57VuJStpQkon+OWHpXoEr61nEeyvvSKrCIMjms5/1E+bIs7h2HhJ4/Gf3peyt
	 0bPfAleiGnlxahkc8hBhyHP9GeBuAdklMyUgcbvpOcoTHSA/xdOJzCP5OwOcGQoUmp
	 vLRKUExNP8Qly2PDCO6R/OzSGnt6A/U60TsD3GkTY+lcdsP2qrBo8ue7uMxxHtD/af
	 PiAW0C+LTSR0uUX3SPj39ifXk9nzYQMGloeVTNenHTirPuX4GPba6KC8OFu8YJo038
	 mZG8fhpIczyWIdJktPaWpj3Dpkb1zR7VcpiF2d3EvI/nNx6C2ib41cpJK3BjdVl+yg
	 6RQKRGZI7GE68PVTqM2oo7rw=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 99E0640E016C;
	Sat, 27 Jan 2024 10:52:46 +0000 (UTC)
Date: Sat, 27 Jan 2024 11:52:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH] x86/sme: Fix memory encryption if enabled by default and
 not overridden
Message-ID: <20240127105240.GAZbTgeOwAmYbSfgXR@fat_crate.local>
References: <20240126163918.2908990-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240126163918.2908990-2-ardb+git@google.com>

On Fri, Jan 26, 2024 at 05:39:19PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Commit cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in
> sme_enable()") 'fixed' an issue in sme_enable() detected by static
> analysis, and broke the common case in the process.
> 
> cmdline_find_option() will return < 0 on an error, or when the command
> line argument does not appear at all.

Is it just me or cmdline_find_option() should be fixed to return 0 when
there's no cmdline argument and < 0 only when there was a real error
parsing?

Hohumm, sounds like a TODO for me or someone who wants to audit all
callers and fix them up accordingly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

