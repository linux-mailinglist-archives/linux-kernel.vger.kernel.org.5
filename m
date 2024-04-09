Return-Path: <linux-kernel+bounces-137369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF289E12C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F8DB2177F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A7155396;
	Tue,  9 Apr 2024 17:09:51 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E00F153826
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682591; cv=none; b=FWx22334qyCsU6MA3ftNFXLzBjIRc+78PG8pDjZaOZuLVH8JBFo5PpguLBi3FKe/0g6GnMJbrAb6Qt1nWOdwtOMma2QLl6wNiB+ZVC3PaKNRL6DfRnDRPnGQzpY9daTwr05LeXIUdlchC/l75lK/XlCKhl7fiNbfItTxIcEQmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682591; c=relaxed/simple;
	bh=auzz5duMFq+QgDwdD2uySQTTN2yYy3Ubzon6A1IEd3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8H94WNElvVB5qv7b3hsbW9Qq4wxX7Tu9SBpVP+0PP75mT+eoTwOTPJLri6tzMQbFzTOjDPjd+2aSzdXWjStbvPFdo+q7jLs+S/C7nli4A+I1arjZb0Ad7d+XO8LcjS4e/TeSyNv98XfcmxJjKk5hc9DCjumuLxWwEmdrAZsyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DB87640E01C5;
	Tue,  9 Apr 2024 17:09:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id djey4s2-02-2; Tue,  9 Apr 2024 17:09:37 +0000 (UTC)
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAB5A40E00B2;
	Tue,  9 Apr 2024 17:09:22 +0000 (UTC)
Date: Tue, 9 Apr 2024 19:09:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 01/14] x86/sev: Rename snp_init() in the
 boot/compressed/sev.c file
Message-ID: <20240409170917.GCZhV2PWPhmzTHhMRO@fat_crate.local>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <425afa6512994b1ca1bb366eb7abfb24d65175aa.1711405593.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <425afa6512994b1ca1bb366eb7abfb24d65175aa.1711405593.git.thomas.lendacky@amd.com>

On Mon, Mar 25, 2024 at 05:26:20PM -0500, Tom Lendacky wrote:
> The snp_init() in boot/compressed/sev.c is local to that file and is not
> called from outside of the file. Change the name so that it is not tied
> to the function definition in arch/x86/include/asm/sev.h.

That part I don't understand: I can rename the function without making
it static and it builds fine, so where is it "tied" to the function
definition in kernel proper?

Don't get me wrong - leaking kernel proper symbols into the decompressor
has been a pet peeve of mine for a while now but this is not the case
here, is it?

And yes, the patch is fine - I'm just asking...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

