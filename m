Return-Path: <linux-kernel+bounces-128720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608BA895E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8F5283587
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DCF15E5B4;
	Tue,  2 Apr 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="epXMOtcH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25915E1ED;
	Tue,  2 Apr 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092831; cv=none; b=KwF9C49r1TtXZ11+7p70t041JMVLWkf7YeGAUwCp3ugJKvQtP6pZz9xng3H/bzcsJfHSQbX499Qdt5++PgshZKI6HhZYMsEVwADLZ0EFGHApqkxCE9w5snzwhl80uST3NtVOjXi6lKkudIND6jByKmEfnSaEMnnUBvoahip+IEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092831; c=relaxed/simple;
	bh=PbJBzqx/lsFGDJR0ovIcDgCqmRfvfod3VfDgwbV/Uqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As/V+7NSxIxiFZtannuLsO7A+5grV9C1cNwJMH6stA4TJ6S/5gdb/+uNCya3sInVp+Bp/Q22ULW1NZCQQfSyxYC7KradkESxAsn8BbkhT8EWFK6oK35P/05E70kfOqg+AYIu2CeZXEmegVFEMrIizXlqovNTCtVLLbkNy14lcMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=epXMOtcH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8A31940E00B2;
	Tue,  2 Apr 2024 21:20:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hYV6f0ddzFA4; Tue,  2 Apr 2024 21:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712092821; bh=VCuf++VjbGdwzOxmI7rmPEokbNsMqpfPelO3955p8Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epXMOtcHzP77gnPQOLqAHF1b3yzppkXnh/NwvRQ1EK7M02A3m44UBW/YsBkDuksTU
	 knMVuEjKErl/GwSyAHpK6DcdV6g/L8oOtop+C8eet8wx2NErNIZ0o40FsyitcPAI3V
	 rXSIFu6cYrZEUeLz6SosX6Sk8GHe1PvsPFUV3vs8TObzFy15LGWcq5F5EzvYpKON1Q
	 29509K91zcszHY0T5yxapEP075OfbaOh1D1vwTJDc6GBGeCY4bESSgMqHBSWT8eTA7
	 jx0NE0oMOJWGeZJVmpksioTK30rvLIJvkqBQwtiaCko5q3mmXw7SmTOqdy0FiJafYV
	 1/6EUi1OlzzpTUcB2Lju1apIjAzTZUw4QBhclHKqloZJx16bsAG6NPL8lsvuN0bLMo
	 Ixki3Gx1JfduE3O8+5LuKeOE0Wk5oHKdwDMdNwlAx0BmNZBG45scd4PlsujcT5qlzH
	 jVA9kopu/txhlso5vyiEr3IJNq8i2yGNWf7QalCqqrJThc2GxtAif3diTkPLGDoCA2
	 cW2Jg+qDH+PA0bIlZBzMa9KW8gqKmxe/bTIvkHD3MwjtOivAcmgVU8LvhvOLt32x0E
	 kXCHmq+/Vy496CDahgZaLWqlJgr9QalAnkfzKWsJVTp+2pDwEIWp24pOOWeOty9S7N
	 E/RmsnvTuH+tK10N0Bh0IXwk=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3764B40E019C;
	Tue,  2 Apr 2024 21:20:14 +0000 (UTC)
Date: Tue, 2 Apr 2024 23:20:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: bp@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, michael.roth@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Message-ID: <20240402212009.GEZgx2iZC_Plx-ajKW@fat_crate.local>
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
 <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
 <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
 <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
 <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>
 <20240402185039.GBZgxTfwvEP45OxVjm@fat_crate.local>
 <8daf448f-eb52-4b1f-9f98-099a83665321@amd.com>
 <20240402202118.GCZgxovu-pgPKYvner@fat_crate.local>
 <6fdb98f8-b4e2-474d-b8e9-c3092e77e56e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fdb98f8-b4e2-474d-b8e9-c3092e77e56e@amd.com>

On Tue, Apr 02, 2024 at 04:00:03PM -0500, Kalra, Ashish wrote:
> The main issue with doing that in snp_rmptable_init() is that there is no
> e820 API interfaces available to update the e820_table_kexec and
> e820_table_firmware and e820_table_firmware has already been exposed to
> sysfs.

And?

You can't change it later? Tried?

> The e820 API only exports e820__range_update() which *only* fixes
> e820_table.
> 
> The important point to note here is that in most cases BIOS would have
> reserved RMP table start and end aligned to 2M boundary and setup the e820
> table which the BIOS passes to the kernel as such,

So what was this "RMP table start and end physical range may not be
aligned to 2MB" in your commit message?

/me is completely confused now.

Or does "most cases" mean that there can be cases where the RMP table
placement in the BIOS is not 2M aligned and then the kexec kernel could
try to allocate from within that chunk and there's RMP faults?

And you want to allocate those chunks up to the 2M boundary
unconditionally, regardless of SNP enablement?

Now look at your original commit message and tell me how much of what
came out on this thread, was in it?

Not a lot, I'd say...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

