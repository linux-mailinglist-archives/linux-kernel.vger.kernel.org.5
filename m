Return-Path: <linux-kernel+bounces-123184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D728B8903D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773DA1F21189
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1A130AF5;
	Thu, 28 Mar 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xl7jqUI+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C8FC11;
	Thu, 28 Mar 2024 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640706; cv=none; b=mZAqct3D9/FumZ3KUEawErq/N87pp7XVOhMqjabPV4ZNsE2V8x1rMNLMhr8HjDE5D1bx+tOfSZa9+F2hcSPe/BDu0/DBIOu+xpHUMre22AkuOxSc9gt4qFgP1hoY5d+/2m7Ison5Q7BoFOyHHC+uQmVnnTgasXJgEQzw89pBkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640706; c=relaxed/simple;
	bh=Uw5OJopEW+p/K0FZ5wOA7vWjuMNSzi/xuCD7fzcrxAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQS9SiAO4J7d3qWLx/UzctLFohmMcJmCVNekrzDkJxFkpUEp8moR6DGeZkmZ7oXMn85k5byyZ18KqPOVDsfEsG+ttI49LwhrpvZ7grcXzysoghGFTno9HCm1P2xxfU4m8vauO9UCUgaVKipybLw40K/Gvjzzler4yhPmusTV1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xl7jqUI+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7DA7A40E016C;
	Thu, 28 Mar 2024 15:45:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FCFFXOAxSdz5; Thu, 28 Mar 2024 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711640699; bh=2s0TKMfc9cI/JnKa6Lhb22qwjshY12Z0TDskuNsSujs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xl7jqUI+mJCxaRjDOB3ofNmaAlLcyTgPnH+Umb9d1VM4UmZg9TfgFMuyoboahPToY
	 KLlFq5OtMRdd9koc0dWhgO7RbDCCJ/XinL5ko2jH5zsTno3skctyA7WIk96vVrwa8A
	 QVK2txxS10Q7cQXVqZ0odEiHEmVMBYBC8dpZUxAqp1IPk9EDptKU5nt3tIAG5B26mW
	 ZfZsz9K+6OAePI5bDTmL7Oc0a2BPDFaWf1oz5TSq7wnxnIWgklHVHiR+rHZCI4SYa/
	 QwbmC7xr44dStiNpvna0UWjjKG36TMOt+3kTVaM6mGWKoGgthl0LSEqe8VIPW8EEMh
	 NHZXcICY8PTVeoZFQiwllza8T+78tpqonATuxSdjhVw5f08D17zRPQDU+KbGRxJUCA
	 sda/NWuxJwEamMUz11qhN9rHGVerayqcQn9yFaLlO3X6Z47aK9sNN4DRDjP0471SjC
	 CrXEPMWw8CbZFPiSeoOMJU2k+97ueeYVfooxz/K2b3tu36XpGgP53g/juYp8JTjemw
	 xASQ/qYulkSxxrvUhOSDRrTlfHBF48Vt9WFNCxbFL8qwO2lhjxHv0nWXWHu20rhJ5S
	 BBfkg+4F4YwJ0H1sd8a/80xjX5xqxo/wiGd9QMB7UIYRtFY/Yc3Qr0n6PzLLGoM2wP
	 VROlYVvvAf8JpjBTMlTNNdEM=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C430F40E00B2;
	Thu, 28 Mar 2024 15:44:48 +0000 (UTC)
Date: Thu, 28 Mar 2024 16:44:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-trace-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, rostedt@goodmis.org,
	tony.luck@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	yazen.ghannam@amd.com, Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
Message-ID: <20240328154447.GCZgWQbx6oy4dJl0sm@fat_crate.local>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
 <20240327205435.3667588-3-avadhut.naik@amd.com>
 <67ba2ece-6b46-4ae1-a944-a38f84360d0f@intel.com>
 <20240327223522.GDZgSfKj1CVyZ0zfxs@fat_crate.local>
 <d63a6e47-204f-44a4-8789-d4e41de39ec3@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d63a6e47-204f-44a4-8789-d4e41de39ec3@amd.com>

On Thu, Mar 28, 2024 at 01:17:43AM -0500, Naik, Avadhut wrote:
> SOCKET -> Socket
> PROCESSOR -> Processor
> MICROCODE -> Microcode

SOCKET -> socket
PROCESSOR -> processor
MICROCODE -> microcode

And yeah, the acronyms need to obviously stay in all caps.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

