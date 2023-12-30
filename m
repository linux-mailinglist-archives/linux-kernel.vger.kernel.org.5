Return-Path: <linux-kernel+bounces-13377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB03682042E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577C9B2132A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B193C23CF;
	Sat, 30 Dec 2023 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QIlnA7Mi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A902104
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E049D40E01A1;
	Sat, 30 Dec 2023 09:48:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SS_dBzpDZhG7; Sat, 30 Dec 2023 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703929725; bh=Fu4L2zCSkbiKR4dJzwtG+70wDGkGO3J3afoXz7NoQGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIlnA7Mia13VIuONdHSN9CdNMroe4KDWZMTnGwDCaZGZVc3mwQaxoJfEaI0Wr0dKo
	 fSc6cWypxa/sCEMQuc6UeLepRpAH8lyXC3wL6edPpNcPuQAAgpT+2DjyZ7UJwv6/1u
	 AMF1KTKAiNPxUbKz/urhk+P2KvIjmNPkM+uelfyXZGFkQ3Qh0YM/dXv6isakjhFqyk
	 xFSnjaPmOPwCxb4EA6vCKVAY0h0fO7qAcUmMyzn67rL/OrViPW5TUK2CrIAlZX66Fi
	 vtuViNMpTOdUsiRnIKoTV0hWEx2H2/oXPR2S6XRVDIgiO/5OGNat7EUqFUwWFGshdt
	 lgTklXrDVq2ILZ3YQ9qfxYVB6oeCGVV8hdmNRtJXzGgkwbg7zbWOSnLVRq1S1TYKoS
	 ffjAc5OKu0nj9ZGauIaeN9W1san5OfgIioxXNAIIkADrWFdQkhLU8hjyQymigxh9AZ
	 iZixSKN7qfF2kzdrkQVsmXyjDcMH2pGZy6Z3m4MmqDAYi2XSS8sP3jUKpyvvWo6rFU
	 mdAGKtUt58xMB7q8TOx9QQkmURoC0/16Bp4m+dFhgLKyBpdQpIwpXQ6FueM11ERpb+
	 hUCsRnFISlLL9Bl7u2L6UHnk0I0V4YZ6krSJebueaS6SqIk5EuKqbOMM2Ne3unjwZA
	 hkTCK/1/KKoftbIexc04ooYY=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB15340E00C9;
	Sat, 30 Dec 2023 09:48:34 +0000 (UTC)
Date: Sat, 30 Dec 2023 10:48:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashok Raj <ashok.raj@intel.com>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	regressions@lists.linux.dev, Mike Rapoport <rppt@kernel.org>
Subject: Re: [REGRESSION] Platforms supporting SGX fail to kexec due to
 96c6b8f212a ("memblock: report failures when memblock_can_resize is not
 set")
Message-ID: <20231230094828.GAZY/nbBwBCP58RuxX@fat_crate.local>
References: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>

On Thu, Dec 28, 2023 at 04:33:49PM -0800, Ashok Raj wrote:
> Hi 
> 
> 96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")
> 
> Causes kexec failure. Backing out this change, kexec succeeds. Symptom is
> it appears to hang, possibly hung at the panic. Although I have the
> earlyprintk enabled, I don't see any console messages when new kernel
> boots. 
> 
> Also tested turning off CONFIG_X86_SGX, the kernel with this commit
> included also kexec's fine.
> 
> Booting from warm/cold reset has no issues. Only kexec to new kernel with
> this change included and CONFIG_X86_SGX=y causes the kexec failure.
> 
> #regzbot introduced: 96c6b8f212a

Leaving in the whole mail for the people who you should have CCed. Lemme
CC them.

$ git show 96c6b8f212a
fatal: ambiguous argument '96c6b8f212a': unknown revision or path not in the working tree.

/me greps a bit.

Ah, you've dropped the first char of the sha1 - an 'e':

$ git show e96c6b8f212a
commit e96c6b8f212a510c9b22362de519f6e1d7920de5
Author: Song Shuai <songshuaishuai@tinylab.org>
Date:   Sat Jun 24 11:26:07 2023 +0800

    memblock: report failures when memblock_can_resize is not set

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

