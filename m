Return-Path: <linux-kernel+bounces-128454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C4895B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D44AB293C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631815AAC7;
	Tue,  2 Apr 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TwyZmeRJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39A15AABA;
	Tue,  2 Apr 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079983; cv=none; b=MPf8pfl4n4F7E8cNy8jFMeUtiXXYM2XmyrZlZvdgkfZY8cjMOT64i6+G/LXk4KJnXYnCrJxPgc1FN5si7eVE1TTyzA9CBlLaJs37SWKD9M4VycSo3vlNnmBMWIW00ZDBUrSFB5FXNVwB1zdM8aosustcBcUIvxtKUx/7wn0G80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079983; c=relaxed/simple;
	bh=pAUFdiwIlE1ioQQwbu0Wim5W+f/P5B5pF1oot4QK2eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaaSUy3GcR1kbBRhznIfMsX+luAWxEA7HxxGL5PwRhvGeeXcWbSmfRQvhaQDrlsY1+j7AXHucfW5mFmSX6fbOBP8l/mrHAOPP8iSQMe98fHcxdRWEBdz7W2aGjs8fsjDUm0PHjxvXxgxtxzVthU1+VJwbgj9YXkEY1UUtHFSXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TwyZmeRJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 25AEE40E01A8;
	Tue,  2 Apr 2024 17:46:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gbEdqk9YiJaJ; Tue,  2 Apr 2024 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712079954; bh=wHbaVNqGVy1LWaXB4BlrvHPuKVAKWB8nGYxe0uVjbuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwyZmeRJFGNxqKzSbhpLs/WgSCPjZJHB3+etEoq5jacr1kcnmsu/jrKIVarlUZHPX
	 mA3BCHiCaIDCpbyEvwdDZLGK28wHQ01iUpc8NgZpobz6YD5KKAs50FcsI6N9AAyrji
	 mLm/efArrBI6OeF8HS3rRMHf8DkITOuJLD4krNoU7WPAJTGdbJJxPf7ukAe4CyQKN/
	 GZqvb+FzREkQ7nxpF2HNOXXUmgyQTwde3fgn6S6ZbEP+04jsO0anhfJLEoNCpr438E
	 JMOIHiQpc5UE0L0o9BZNjXN0m7uaxs3xImbIuDmrTxNzlEMP5MgZ3K+LnUVQA1iW+R
	 Bx9rso1vn9MKQXiT8jBRTGhPF+fnIYEyuR1EbFye8dGNFiOz3+SyqwyDboqAErSGRZ
	 /LY2IjpYqBmHRSteX++FShcY4N8D0TZ0/Fn2MhpHIN/7jd9t9ypzDLZ1isLDClGhug
	 if65NC3Gchk9IkdVb3imb/kiBTx1sHrXG9Rt+i/inQ49cUJFiFpgIRzOlvzfhsqo/B
	 SdPgFn7pfAmo7bFz2tkBlZbhTGxichcnII5g7yNtCb8hYT9GqvATqxVbmyJt+VdaTZ
	 BEKwlKrofAyfas277zG+kQuVdePeDpctpQUhtAqem8TNo4w3l4dff9/hgrbemp4y+x
	 V70/EELTQLcrfI/IcH42zjJI=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D9F340E01A1;
	Tue,  2 Apr 2024 17:45:47 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:45:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: bp@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, michael.roth@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Message-ID: <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
 <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
 <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <359264a1-e4ef-438c-8f24-32848e131272@amd.com>

On Tue, Apr 02, 2024 at 12:11:03PM -0500, Kalra, Ashish wrote:
> > And if you mean the reservation in the kernel page tables (directmap)
> > then that will not help as kexec uses it's own identity mapped page
> > tables.

So how hard would it be to *always* reserve the chunk of memory at the
2M boundary where the RMP table starts and up to the 2M boundary where
the RMP  table ends?

In *every* kernel.

By default.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

