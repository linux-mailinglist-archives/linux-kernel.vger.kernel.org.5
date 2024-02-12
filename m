Return-Path: <linux-kernel+bounces-62456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA50852106
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB1B1C22EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B34D9F2;
	Mon, 12 Feb 2024 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xq7jEqcW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC64EB3D;
	Mon, 12 Feb 2024 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775735; cv=none; b=ki8DubXAbepLM43s6Wt14G8ffMa7PGju8XB77If6j3INhIWlYGt+NRX5f6VObuVBJKX4PGZQl4Q1jeRVK6emY+dx2wT8qUKcOLRWa2VgexVrq0sKayacwjBBgl4n8uA69GmIWDWpKDE68eqEGn0gzTfi2PwuHM1PL1VJ6MNJoSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775735; c=relaxed/simple;
	bh=0wF0cKT0EXGdUjS1bSMv6RN0BhD7RAd8cRtVDioiiVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8lmLfixFVDgHJJ/3cVNOFAfMSwLZmGhF+jYgxjU+h/x+dhk+DXF3ERygG02HhuCrYt/7y1uZjs0QaS/r6lxiDxKP+mXx0hGk0ceCDikKzxD9xdxwm7ZLItxAcwvKJtxIt/QMfE20MkeFEq2YngNvRywgsywAVMrBHrzDCVTPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xq7jEqcW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 505DF40E01BB;
	Mon, 12 Feb 2024 22:08:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6-v2LGsbJJfl; Mon, 12 Feb 2024 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707775728; bh=nr2K5kbVCtDalYxSYbdURjwJgeoC1QmXrEfXCA1PjV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xq7jEqcW0w8WY55Wjnp/G7wvIrnXEBRhQD8GKtSu2gR/ZDXOkYfae80gnsW0hb5C4
	 rnHcQYlK2HCC43Cyjzjc1Zb6VFXUvMZqU4jK8tF8ikh2ZTPn0BBAd6JrNMxIfi2G4I
	 wR9sl21d6sM/u3q/Qnunw6+9vuDNzwZW0Vu3vH6K7h9EVl773DwEOhUamZySkDgWMu
	 eoTZEv/rfsHXzIGzE7Fnu2oQAv/MAxVrVQrfFfoJLKTN7Od8pVuIYrjRiAbbLaFCEV
	 d3QQ81Ioub24KIa49bJyznB3IpA75h6buTcD+On5VibRpPrrn8tyP884Ubqqub1b/H
	 LPWnYU4QT3v+p6fuM7iJdU0hSmdeuiZ+nN4GYiazxr+mxbzcDgT9XeME9yqN7skZXw
	 NIjV+gt6Vs0k39zdquVm5QsWBWCBFJtX0JA/s3+RFuBOTc+LaawhSsrFukwtPmgNIg
	 ZnGlttaLGkRv/F3T7Wpa/LWPBS0zY/emhc7PrSw8oTFE5FEMMb1MgrmUdQchCNVa/P
	 9AuFYb9HZ+NF3HwKj2Kdz+yUHHj1eFV/L/HrVSbFfQNLMqXsYq9bEs03y8QD63TKDC
	 2y338gmH2kjNSvt5fyE6nfNWZRJKfdZHOLcwhRVPCP96Za2LvA5p9GZvOZvKzhzahP
	 F3SQuOsGp/IkORmiLyzH/+NE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED79E40E0192;
	Mon, 12 Feb 2024 22:08:39 +0000 (UTC)
Date: Mon, 12 Feb 2024 23:08:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
References: <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcqPhVO_DtD2x5N7@agluck-desk3>

On Mon, Feb 12, 2024 at 01:37:09PM -0800, Tony Luck wrote:
> This made me question the "we don't have an allocator in
> mce_gen_pool_init()". Because if we got through all the
> ACPI stuff, we surely have an allocator.
> 
> Below patch doesn't explode at runtime.

Yap, I see it.

And I can't dig out why it didn't use to work and we had to do it this
way. The earliest thing I found is:

https://lore.kernel.org/all/1432150538-3120-2-git-send-email-gong.chen@linux.intel.com/T/#mf673ed669ee0d4c27b75bd48450c13c01cbb2cbf

I'll have to dig into my archives tomorrow, on a clear head...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

