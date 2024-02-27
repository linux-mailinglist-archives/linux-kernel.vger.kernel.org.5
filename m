Return-Path: <linux-kernel+bounces-83079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBAD868E23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7A41F232EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045513A261;
	Tue, 27 Feb 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kfImgNVg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A64A13A251
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031258; cv=none; b=Z2TWg2r7eMo3QQpm2fsivmm6g8ZcFE8Nw70UVzPwU1JUkec+OYJ2uviQaP8qjZdqcxum3eX3D4SBzXNuluEMIgZy3MF+Z4nEgCkf77YmLrY8LJKeSfc892buNXZw60owXbkYoe0HvowlIipNK5ltWVg3gtT7Z9Pz1ReRywYTUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031258; c=relaxed/simple;
	bh=Zcgijc5vPPptdctl+wg2B12sHDKGtr2xobNvuM+Whrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH4gW4Fc1lZyJGjC2pHUK7XyDmmNjah4is2uzpsJh2N+1eToW+DiZk/m7Zr8ydTKoiLtqFjCxQVTdvA8QG8ccQMi/nCdFRsFEwDgjK98pc6h5dxhzd4zZc4xPdSE7H84Ok+3hnd33q57zoj+kYv6a6ZYx3NgdV1ZtoOS4asnXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kfImgNVg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A80FA40E0196;
	Tue, 27 Feb 2024 10:54:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9OAj06JUKUQb; Tue, 27 Feb 2024 10:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709031251; bh=PUQwc0dEBkTywhDKpsFReUB5uxk2BgEqJwvA+nNQ3z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfImgNVghkBePQQdPtGbtA3b1QLrVOVgAtZpQsUCPnvx8CkVYF7HL0DIVg5yGS0CX
	 Ta4+mc5WOKHL7ZgRzN1XbWt9GKrlasOmLWevqBEhHtSTbrPQpoFIaOzLD5YIv+Yhxc
	 3hoeWt8CmcZItW1y/BUKBcvvqMmujjL2XuBGI8JeinccS9LeyrEdVBLRiHhZsfBxem
	 JGSUklrv9S38nAnJ0ACaVLiWTy5AFigkiIrbnWO9njaHH3zDyO689ijRsMAfiYXUNP
	 1fAhLuPj4E/yLaU5978DsP9IseyQhr+mZ/cDh3oUf7AylqjfzvC6VRqN2En1qj9ypn
	 4gaaFm3+OxhD9jLGck3mydLP0dGSMaz6jPhR6jttzHXGfPBmmj8dsreK4t0gdjOVnu
	 2mJJGm3Drq06jiuqnrlp2dpWAyu1aMLuTHtro/wlr5pskZou196o7VmCsj9GW/Xff7
	 eDsXYg1utp447TCHsAITFVphojOuJrDpATP/QrqAScbvQXe5uTt9AzpBLQzdPoJdJF
	 Vb6JMKgY9USCU2gO9Rhr9iXqc+k//3CXtTt+/8BSIwS7gK/FDjfIcUNTtPZpE/+BEN
	 OgthfqOpJOz0s9PZb4Rz4s4FPpL8x1xvU6GZcZYqv/Mt4xumGgshaGlqU3SUNNLWKp
	 r7CZRtz4rUKR6sZDs1lSv62g=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 591AC40E016C;
	Tue, 27 Feb 2024 10:54:02 +0000 (UTC)
Date: Tue, 27 Feb 2024 11:53:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 drivers/gpu/drm/i915/gem/i915_gem_pages.c:526
Message-ID: <20240227105356.GBZd2_RL9hjC_LupZB@fat_crate.local>
References: <20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local>
 <87jzmqjir5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzmqjir5.fsf@intel.com>

On Tue, Feb 27, 2024 at 12:37:02PM +0200, Jani Nikula wrote:
> Is this a recent regression?

Yeah, no clue. Hadn't booted that machine since 6.7-rc1... I can bisect
if you want me to.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

