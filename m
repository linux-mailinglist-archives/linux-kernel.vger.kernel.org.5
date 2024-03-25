Return-Path: <linux-kernel+bounces-117676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D949088AE53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750C81F32E15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4C984D1E;
	Mon, 25 Mar 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZUGf+Spw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278F370CA7;
	Mon, 25 Mar 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389810; cv=none; b=pUE0t25EBPGd0KabtF2wHAjJqK5kAcstpJT9BasCBHrrqmTE9CZZjH1ZI6AdTLfqQeNEfBQA49beQY6vCRoI4H94dfwOZhNQ3id9e067Y2kE+wgM0Znak+e1QOOq4nxS+M0pFQX9mWqr3qXfhGAZxa88fFFWM0QyhPy+cO561zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389810; c=relaxed/simple;
	bh=LuBX/hwxrNqsaHF8GMs2eI9t/d/qRYLH80vZIH7ILXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwuEmysJq8fTLMT0i3n+RCajcS2Y6lIR3p8iAOqDATGnC17urPR1JSsae1oUJFKE+jxR1G5XUWUh16BEZAxJNjZYj2sS9w+sAIYHulu0bdkySEjyf6FDzv9fxrA6cVKSzExQuoGS7vDMMyVdJ/XsFczcpVkwlxJYEs0Xspbnx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZUGf+Spw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1C2F40E02A6;
	Mon, 25 Mar 2024 18:03:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wlcl9MQjtol4; Mon, 25 Mar 2024 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711389802; bh=9Pg6rGDcXIBzldK9Xr90ie8sezD4Qwc8cPFnAvknNgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUGf+SpwjUc/glkd12A8HONzOUpkLlGCU4RnbT7T3v1/PXgaldgYvNXo1CEDPMEA4
	 SspenGIJu9yszJqDijo6wGz/BQfVgexPy3jbXFcQUegoDJpDDMe5iMSV9c6SgmHDXQ
	 wp7aFDLNX7IwmkLTvuktDlmy18iMDJKdQ+QM4YSa2YuuQiBBE4R5H2M+yRFUd/FaOa
	 OHTFAvqdbDNL1VxTO+CuymAaNdKhQ1s9QwKyOxF8zK4qZMZ9GOl6pMSv3lX6h6SilT
	 SDQ2qfN7XivCIaxqC2GlIsp75p+v9j4+MKG8DHYev5ZHyu3wTN+zRCuouUmpxHhEvF
	 e5vFEdx68SwIpf2jXgQTGwswj9bVtxqdkDEF8stj/iwTlx65Ze3bSwuRMEuZH6FIuJ
	 +weDaZU7Bhe7luxv3Izlnkvf29Yf6Z0DFvbaGWkQQLGV8rXpTZKEpPSRFevIJPrInT
	 RGkS7DKsPhVad45C3QRMVqMjjLxdCSpmY0o8Vo8GXFWcxKFnWBLfuhlZu+namo18qV
	 69xpNvHlD9JuX57KwRWKj4UnxTw+aKwGRfsmaGo6t77S0dRtFt713Mm0RUVe7wutdh
	 IFTgHVPgq5IqL8CanmqmmxOIekO4pMkPsg97vCX3UEWWzFjrrbFxXRcmzm1Tj1uVol
	 WlZQTfdatcY7EYXNn7YAFDt8=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD88A40E024C;
	Mon, 25 Mar 2024 18:03:14 +0000 (UTC)
Date: Mon, 25 Mar 2024 19:03:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, naveenkrishna.chatradhi@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH 0/2] FMPM Fixes
Message-ID: <20240325180309.GEZgG8XTmYUQZaJ4wP@fat_crate.local>
References: <20240319113322.280096-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319113322.280096-1-yazen.ghannam@amd.com>

On Tue, Mar 19, 2024 at 06:33:20AM -0500, Yazen Ghannam wrote:
> Hi all,
> 
> This set includes two fixes for issues found during further testing of
> the FMPM module.
> 
> Patch 1 fixes a NULL pointer dereference. This is a resend.
> 
> Link:
> https://lore.kernel.org/r/20240312154937.1102727-1-yazen.ghannam@amd.com
> 
> Patch 2 fixes a record restoration issue affecting a couple of
> scenarios.
> 
> Both include Murali's Tested-by tag.
> 
> Thanks,
> Yazen
> 
> Yazen Ghannam (2):
>   RAS/AMD/FMPM: Avoid NULL ptr deref in get_saved_records()
>   RAS/AMD/FMPM: Safely handle saved records of various sizes
> 
>  drivers/ras/amd/fmpm.c | 57 +++++++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 18 deletions(-)

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

