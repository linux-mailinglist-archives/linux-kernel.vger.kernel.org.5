Return-Path: <linux-kernel+bounces-103573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B135287C143
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD12B223A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916B74401;
	Thu, 14 Mar 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ddlCZvhK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386A6E605;
	Thu, 14 Mar 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433825; cv=none; b=P448IYXRyf/+B4PzY8uWS1/q+9aso7dic/rn165+vIy/QKsCjZ6s+Qcl/FZc5i6G457wnTmuIH/72Pnl13kPyI3kPM5RXLEpSFbf8ldQWs0qhK7mzTZqb9YCxuRmOwf9lkeJH+5Q2S6j4X6oysb9WlaoiaU++skUO7OAzD349G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433825; c=relaxed/simple;
	bh=TZ7kb0JpX2EDeDNiQSqRVWw8cf5MgXlt1NOM1zD3RNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMRWYVxQe9PXK/DiSNArQ1qoLwKz189p9+NAc9zgKVNgTXPswVEMkKXzkft0a6OUyodvLoksYm5X0v35bmAGPMLn7fHgOwCaaUcP/462I8NLunvP1usnkPk5ez37MAJP+V27MFfaDepRzexJnxJ27xRHs96lzttfJkzdlCgToNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ddlCZvhK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B2F840E0174;
	Thu, 14 Mar 2024 16:30:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id co3JfxzjaIvC; Thu, 14 Mar 2024 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710433818; bh=TDNTVQ6N/4Ma+VE1wv9KFMROi1UWZqALylRp98/G0mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddlCZvhK2bva1wkCFISPWhSgA7oIf8S2dPWHppglYZqtz2vSxx8HWA+RSdmHdKToP
	 OXiDCpFXON42bb3RABzcGuvB1VcNP+f46sdsuckHwDSIGgbzUfxd2sW7VA45U7YhIY
	 zKGAvZ2OsSZrlyo2UNQNOAnwT3d6RBb8y3L/G/4yPBqpQXrINgbYSoCXWF6d9IrIu8
	 uJviBtaXalfqUB+yQlT6brtKj8nY0vqkvoYeSyoYRcYvm+04ai8X4NBVX/jGJ+hew+
	 dsMNF2MHZyedo8t1y17yeo+d6xZHxKm7ufX97aqPVNYq41tpTncoXBicw2r50mUTab
	 Y4wNs/ovE3xZVjvzgyAEUg6yZFVua6Fu9WByko2XBA9PFBaQbG7yZekZ23pq+K4wDY
	 aFgxfQyTkKc8iNPSfuZoVynMtbBCaVJIV9sAiMdWw8iqFQcXtRI3kYZpu00yHs9Q4W
	 6UmIy+mT3JGW8uuvS6LAMEFBS6pwCeeCkkFAKrK+e7UuPvDcf+qXmARG2CkCym2cH3
	 dYYYwQntIQfkZPc0hf9tjG7WLVcILOT2TUw0TebHm/cIgFKLNTpwdEPDbTZBikrpzx
	 boTN8C5W0q/AR9R7VsUiKow4otv0wXPMKJjbw1ZeycSxcXSns3SGs0P1gthQAv0Kpv
	 TMQv0SmS6/g1mehnnlDUuNsE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 27BBC40E016B;
	Thu, 14 Mar 2024 16:29:59 +0000 (UTC)
Date: Thu, 14 Mar 2024 17:29:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <20240314162954.GAZfMmAnYQoRjRbRzc@fat_crate.local>
References: <20240314112359.50713-1-vigbalas@amd.com>
 <20240314112359.50713-2-vigbalas@amd.com>
 <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
 <20240314160824.GDZfMg-J1VOyjxIMiV@fat_crate.local>
 <6ce6aa20-25d2-4784-823f-2a18f592e002@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ce6aa20-25d2-4784-823f-2a18f592e002@intel.com>

On Thu, Mar 14, 2024 at 09:19:15AM -0700, Dave Hansen wrote:
> Are you envisioning an *XSAVE* state component that's not described by
> CPUID?

I want to be prepared. You can imagine some of the short cuts and
corners cutting hw guys would do so I'd want to be prepared there and
not tie this to CPUID.

> Or some _other_ (non-XSAVE) component in a core dump that isn't
> described by CPUID?

Yes, that too.

Since the format of this buffer is so simple and machine-independent, it
can be extended as needed without issues.

> That argument breaks down a bit on the flags though:
> 
> 	xc.xfeat_flags = xstate_flags[i];
> 
> Because it comes _directly_ from CPUID with zero filtering:
> 
> 	cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
> 	...
> 	xstate_flags[i] = ecx;
> 
> So this layout is quite dependent on what's in x86's CPUID.

Yeah, no, this should not be copying CPUID flags - those flags should be
*translated* to independently defined flags which describe those
buffers.

This is even more important if we change our xstate_flags[] machinery.
This buffer should not use any kernel-internal definitions and
structures but be completely self-describing.

Vignesh, pls fix that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

