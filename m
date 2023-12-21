Return-Path: <linux-kernel+bounces-8281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E681B4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD101F25F11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054D6BB54;
	Thu, 21 Dec 2023 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UVAEsq1w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BCA6EB67
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1703157902;
	bh=FEH0A7jz7vXNvZgR/E0+au0EVLX99YxTzXY6b6eAv40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UVAEsq1wLn9+mnU9rDvkKvREUHvZ2B1o29gMCbNQJsjq5rD2GZWCSsBfngwMoSb2H
	 H07uyGdzhdeXKCnIyQsGSKsD1RQmIZmvo6m0nJGPQxEi4aJTMIHPRKVc80HkIt1Dx4
	 +yscMrdXLBkI0dBELSx1XhFvg8znOKNTtHkXaC7SqNseL0XJmSuAPaXJi0IE/CedYj
	 3xpTEwpE5ktNJRT8ralxe/O79+HB+gguAHbmgFD/o5ldHMz3w6mUlTbbuwuwW/QHOO
	 Jz+vMLXteXdLEilwDkriX1qKyrQf9LxLDTskaLXJ0cwszCXR2ezv7NEz5RNf/SqcCR
	 KetiZLajfYtFA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swp4Z2MYlz4xVd;
	Thu, 21 Dec 2023 22:25:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, mahesh@linux.ibm.com,
 oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: powerpc: kernel: fixed some typos
In-Reply-To: <20231215115857.575697-1-ghanshyam1898@gmail.com>
References: <20231215115857.575697-1-ghanshyam1898@gmail.com>
Date: Thu, 21 Dec 2023 22:25:01 +1100
Message-ID: <87il4rlrw2.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ghanshyam Agrawal <ghanshyam1898@gmail.com> writes:
> Fixed some typos
>
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
>  arch/powerpc/kernel/eeh_pe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Please also fix the case in arch/powerpc/include/asm/eeh.h

The subject should use the correct prefix. You can see what it should be
using:

$ git log --oneline arch/powerpc/kernel/eeh_pe.c

Please give the patch a better subject, not "some typos", tell me what
misspelling you're fixing. Same comment for the commit description.

> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index e0ce81279624..8e0c1a8b8641 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -24,10 +24,10 @@ static int eeh_pe_aux_size = 0;
>  static LIST_HEAD(eeh_phb_pe);
>  
>  /**
> - * eeh_set_pe_aux_size - Set PE auxillary data size
> - * @size: PE auxillary data size
> + * eeh_set_pe_aux_size - Set PE auxiliary data size
> + * @size: PE auxiliary data size
 
While you're changing it you could also mention what the units of the
size are.

>   *
> - * Set PE auxillary data size
> + * Set PE auxiliary data size
 
This should gain a full stop at the end of the sentence.

>   */
>  void eeh_set_pe_aux_size(int size)
>  {
> -- 
> 2.25.1


cheers

