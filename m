Return-Path: <linux-kernel+bounces-128524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF95895C05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A11AB22141
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CF815B543;
	Tue,  2 Apr 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bdORgrfQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86615B977;
	Tue,  2 Apr 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083863; cv=none; b=MGElJ4gyrnXUZH7R0RjJQKXofXTZz6Vqa+MOICFAsNV7CcSKRFVW7mXJbH3iuxA0gEe0IXM7AB9wlja+me3ofSVTmKU4m44QTXnE+W+sGDvAEZlWWjZTwbuSUhqRcyIUfACJ+I/CLSJZrT8lzkE5Iov4qnl0f9UaxUlrPC1zZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083863; c=relaxed/simple;
	bh=LyOcqjehe0C8GdNEtYBxd/yH9A8diXghTfIfxOpO63E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3ISaf5FTTNPZwkjquA0ti4ed53DzR3s/ZVI3VAh+FHnLwI7us8t6pFaF6MrqgO8fUqaULueLarsdwVCc/VgB2q5Weh5nSWtcjwRUKVHqX7krvENpd0L+ueu+iNbLYiU4w0wg5pGaiBLohv4gnknaBoPQBfQ8ze0Q5Qwbmr0WHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bdORgrfQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3AC8E40E0177;
	Tue,  2 Apr 2024 18:50:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MANSbN9D6sRd; Tue,  2 Apr 2024 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712083854; bh=osp4RXlfR2Zjt46qGea4CEBzROK//B6RdJtuh3E1oGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdORgrfQR2c3Usx1QsvOn0mA7z6QhW1KrcHF6SrDfojPDla7c1No/qkjM5F6nlLwW
	 JPVC30y07kQkyxZ63iKHhbZMwUwzAmmUJq+QbJbHFNOx7kg3BJy370Sv00bWqcZFZz
	 K7zg2Nhrk33f1ib3q/4EYv4N7tX2fP5KUc/vDJ/tgY3JZMXvVZuEXYDxujsyuKKscY
	 QbvgGlfpCNMsS0yMpIC/z+xF92q59nkKFvqp1VRvl9hpzn8oOE0x9OdMKw8cN5lmbA
	 3DUeE/5561v0oTRvi3qkLsmu5IdC8z/2UZyTtzjJTXiAJcCpIzcsnHN96G4pJlfJBI
	 IfoF/Ywnj1uqhalU2PPEc4ZXvm82BnblONRE2ShkqQeRSZgTaNZjLwBlWcRcdxoDAK
	 xg4GIz0xBNIqKDRASskIOQ1gRGa5fXhS6/aLuZsmS31eTOnfoug4BPMO8yorxGq++1
	 UHi7NWUR27YppnK7RBnEXLGtB4GYP8orFTL0gzD14nf52Ob/hDD5A1UOCGb6UbmDfz
	 R5cYh/Ti06hXtnlJBmnpZ1e2pMumPRvy3pgfgSX4Bu/mznUvmN/PEIv1ZxjkoPbRMB
	 DSuMOQURtMkRyCb+nw88NQgMHujxiYqofh6BlFhqNgyuhZ0fQygA6sTFH47a1k3f5I
	 fwceZP5SCvMG1Pyp/axXdgB4=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 091B740E00B2;
	Tue,  2 Apr 2024 18:50:46 +0000 (UTC)
Date: Tue, 2 Apr 2024 20:50:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: bp@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, michael.roth@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Message-ID: <20240402185039.GBZgxTfwvEP45OxVjm@fat_crate.local>
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
 <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
 <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
 <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
 <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>

On Tue, Apr 02, 2024 at 01:41:05PM -0500, Kalra, Ashish wrote:
> But, that's what the e820 table fixup is doing,

And can it be doing it in snp_probe_rmptable_info() where all the RMP
table stuff is being done?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

