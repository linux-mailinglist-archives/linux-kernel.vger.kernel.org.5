Return-Path: <linux-kernel+bounces-152948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136248AC67D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38ECD1C213AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4DA4F890;
	Mon, 22 Apr 2024 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ODa4UVgU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08592482EB;
	Mon, 22 Apr 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773661; cv=none; b=npIbKSa/v0jJ4p0H4orl8ogMz+RF6gKeXw5W0AXvSrGsU8SDsD41Z+9MA1SxKsQogvM3lDsyJ/GmD+x4f/HaGb8kJWYUCfsUtY8QWy8OpPyTLqSOLx2hs5pj/O3IS9D24OZ1PkQfvcLuy7RAbPoM8cCIISno2sGAq97sX2VtNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773661; c=relaxed/simple;
	bh=pyVFiuAfy7XAn0IEcf4iOP2CM5tvBES1hnxniwTA0bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpUZJkk2B0tT5EjL0UnUcrn/tDj/wZuxdIxSuIK4E+HuwEu9hkmsbKnakTP+7J2yadzoCvL/S+s1IaG7c5qOCIpYsp8dZa89CdPMDegrKpg9rhH6j+Mgwm0qYaIveIhTJQiT1aoq37fSRxSXoQh5w6YCXkGYueZKu1fWb7FJ91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ODa4UVgU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1379540E0240;
	Mon, 22 Apr 2024 08:14:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HjYZ0OpByO0R; Mon, 22 Apr 2024 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713773644; bh=XdKXvkBTiqBuozdh39J0WHnmLua4mYbtgVNTHSbsfKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODa4UVgUZI++/7QwAcwQFO9i4GCIs7smRHGgkpCLlCSIG/FQzVhyQ97dsXFmkxz33
	 PFvi9j/nS0hoGmTcrl0Ifl36JEuoDKhQ27r52nXULAJMMufU9YBhbP6aSwBuHloTPP
	 0ag7bTsoAKFY10UpvjSncsSP1Q2nwKEMtZnG8aq3ABqS30pHjCvenygZaoWdhGreBL
	 j+Q5PdjYvu1vQOELHhKm7yfbv1olFrbCzE7h1woB+vZtNb+TPZ1ZNp3thc14fY0bLX
	 XFvcn7JpfDnLNi0CRwNw1SR+5kX8GIv04bsCylin8/NlMZvF1FmfMOQdkReDGA66Jm
	 SXy9RmVTCyxM2StBCxeiHZZRvAoHHu2H7gk6U33bwYoC2CuCVJfitI8CQh8hJh5hE7
	 OlPR+SRdvLHP6CCv0W0S2nU+m7EoJgF/eF1fQ6AIMCHs5PlQKjTtJHo0OY/LVejI3g
	 ebIYWuVka49VDKIYZ+oECMM9JHy6K7uFwPoC/shTMWRCvx/VyUdgg8Iooizna9h1Ke
	 ZiAmwsx4EXaFJEXlXLsAVue7pQbCjLIFHGuIV04KSDVXe9M4OYQiQ4ZL+GwlLoIDLF
	 qEWEo0oEM6gEhxdkqpRgSpgzmU02BaWn0cbFBJ7j6XF4bywlyXKjU/Mb71JlOx0XAo
	 Dyhcpbt4iOxKczuaXwhSsUiU=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D5C440E016C;
	Mon, 22 Apr 2024 08:13:57 +0000 (UTC)
Date: Mon, 22 Apr 2024 10:13:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 01/16] x86/mce: Define mce_setup() helpers for common
 and per-CPU fields
Message-ID: <20240422081350.GBZiYcPme1Xx1RRqhp@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-2-yazen.ghannam@amd.com>
 <20240416100206.GEZh5MnlDJMeaERfQ5@fat_crate.local>
 <b5ecdc56-11c6-47b0-9cc1-87d384b01d0f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5ecdc56-11c6-47b0-9cc1-87d384b01d0f@amd.com>

On Wed, Apr 17, 2024 at 09:50:58AM -0400, Yazen Ghannam wrote:
> Should I send another revision of this entire set? Or should I split out
> the mce_setup() patches?

I leave it up to you.

If it makes sense to keep it all together then wait for me to go through
the rest first and send a whole new set or if you want to break this
out, that's fine too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

