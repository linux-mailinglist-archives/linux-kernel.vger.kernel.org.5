Return-Path: <linux-kernel+bounces-41378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB3C83EFCC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D25B23852
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D852E62D;
	Sat, 27 Jan 2024 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Wk06wVF2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246E2D60C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384523; cv=none; b=uvUv3kPdVVIW28M0yQFv8pyvmHnuM0hmZ5mClqggZd46kWFIc9skKJUUzm5jMvyKhntO7Jps8VNAWA7EQhYnoybdivTvooVN2lDW0jR6p4Neag4CWfbk8RakEIpNwu4RDYzrT31gyFUS8F/KHmtrPQxrhOrENsUO47d1O34YHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384523; c=relaxed/simple;
	bh=N+HQGSPvGEFJF5vZUghR+56A9Yj9OMZ2px/x1DpUtnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjRLmMaafw+xlimuMtWxICQb5v5bR2aIFPdn92aVgCJO2TzwF5Ck5RF+X4X8g4QxVuHDMtw3dwZc91BK/Khwqkm2C81jLPJqxZ5a41a2YlnWV4W5FwgoVJVYIM2nLw8Jpee1DHOQ3tFzbAlcLZvQOI/78AT/Q2A2nG72bOIbGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Wk06wVF2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6A2B740E01AE;
	Sat, 27 Jan 2024 19:41:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QT2qD9DQsCsU; Sat, 27 Jan 2024 19:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706384515; bh=XVNfoApR1kw7gBsmv5mYWYynR352cvF0hjq5rpDmZK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wk06wVF2Iq15ELCS6cgFW2FYl4OCuoxgrKYxtWyEM/O6AMSs6PnjpMicqzi+X6Ryh
	 PRGOYtQzTfC6awhphemWbfto+lCQBbFJghBjQpRpBNvvu+/2yDbSK/xTfBmjf9wj/Q
	 gXlG5gTnTFLX9ypl3rsDyzlFhkGBbavcDH5FPL5lb6RvHcA5zG5x9SbYAfE/ekGNF/
	 pGpe0IvAZfszANRXTj0OIjxI42bmTOQ6mfptsPN+jLL3FIpRF1vMUhkZabSbF00AaY
	 b6grhrZKa5ZELm2fHZQ8b/In5C1a9LgDEPbwjhQbsUThd+oEj5dlv0PVNwbZARPEhn
	 qho1wtgWEt9WltNUacIn0LF5T32pbcvjDVJYjVX7i4CE7u52cP1oV+4nDHvqAOirNf
	 /ZdmH3EJFR8j/L2fPjzu42zQv2jYC0XmfAJIrkcRzrwEWZ3IMBzRvvLTcJfsfVJc/8
	 dk2c84L3hua9IYafX3DmYFiYj4ugPoSsE/mp4kak9J+nVcKS9pEVBn8Of/YRXZWSlQ
	 X05H1XiliUIAizX3umSFCQdG3WM2QKWPzbvy+06vD6QV06s08KTwHTxRyv/wmYJM30
	 5CEdOzCTYjO1OI6YL3OIMJYbcXKMlWkUJl6bDLPoVuh+q2gfNAIUPj+e5G+KX9b6At
	 5laqWFIJcODG4YC+1Wnun/Bk=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44A2640E016C;
	Sat, 27 Jan 2024 19:41:47 +0000 (UTC)
Date: Sat, 27 Jan 2024 20:41:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: a-development@posteo.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
	jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Message-ID: <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>

On Sat, Jan 27, 2024 at 07:27:45PM +0000, a-development@posteo.de wrote:
> I can umount the FUSE mounts and it will work fine.

Aha, so it is FUSE-related.

How do I trigger it here? What are the steps to reproduce? Suspend while
I have a FUSE mount? How do I set it up so that it is as close to yours
as possible?

> Previously I didn't even suspend.  Also, in the log I had provided,
> I was on a cachyos kernel, but it didn't matter, even the most recent
> arch kernel had the same issues.

You should try an upstream kernel to confirm it reproduces there - no
distro kernels.

> full dmesg is no problem - I can do that the next day, when I startup
> the server again full ~/.config folder I don't want to share

Not the full .config folder - just the kernel .config of the kernel
you're triggering this with so that I can try to do it here too.

> here is /proc/cpuinfo https://paste.cachyos.org/p/158b767

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

