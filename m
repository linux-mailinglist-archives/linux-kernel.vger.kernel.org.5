Return-Path: <linux-kernel+bounces-140552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A069A8A161A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7311F2171C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89BE14F116;
	Thu, 11 Apr 2024 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUC9jrel"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BF14F108
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842785; cv=none; b=E7hshCjKxo1XViY0ejtfUhaI3ID4RfKdovjbrnKQGpLhjNYUGHJChFrr1O55MBpNIX9+Tg/B/woU0613G62YzDAIud+M+ciz1AxVdDZFAnLb5PdkrOK48pQ4NRCEZQ35y68TsnFaAP70xV9qodcg8iK0MiQem6lh6WLkEddTi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842785; c=relaxed/simple;
	bh=4oN+a+zwOcFIxBURlcm9yUU4A+T5A8wkvMcvEQR5ceA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1v5JiV+DGEdD/S/Yh4rHEgWRRxgKgcjOmC4ijNOYwniSBY8XBecOMcB/C815pFhgjj1Q7DL/YQkr6uDCb1zpUNsAbDMNJBfxwm6nhQ5FYSt6vmP8PpO9uFrkutH/zXCHENwBunG7g4W4VE+Nww1v/JiWZTaw438GMvZbUPGdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUC9jrel; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46de423039so539558866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842782; x=1713447582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D12lcUYKF2o3izGuPoofsyaAfBqSAmidnmp2XsHMons=;
        b=XUC9jrelGLYrWJFSqaiKinSfj4+NvjvtKT03FS0liexmYrFjSnQ/aoc7zkRZ/WtYKE
         7y7LYO5rCDoWjJsocBYRCJ/rm37zSeX/Cl2r/7iiRC7KjCiNo09S3oxbKJO59/z2YStk
         Y0pXPYZDmYPXjLCRBFa7GOgbarQx97r/6qUaBSqrOMfY9D+RC0cTtgI/rToS6OqAXZnI
         EdfCrwbOpuFJXMiPthycQHyv/KbVmZNnR3Vqu9J6aFq5sWDnrsnZuqh9FpHJIJJwhKPK
         Mogi+MnA4Nvx0nYsrY3HXrd3hWwgPIBezRj4O4lFy47JNVD67P6l4ML3tN331NLUap5H
         hHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842782; x=1713447582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D12lcUYKF2o3izGuPoofsyaAfBqSAmidnmp2XsHMons=;
        b=QVE0jVfVS3ls/Dky173K4muhOJBivlpd1ktEgBuNQJ11bOBMgZgYM2TE7k/zeBG3cI
         lSIIlIJJKNjgISD07KNkb1XYxoitYvVkUmnsyNtIsr8p96gwwXjt1zNpQjmwn9/SPFaO
         rbcY8mRHDLllr/UqL/5PkvitIcobSV4hDk1FpzGzl4c2E+mUe4NmTazSmqDxgkakAo/f
         4cPT5f+rZRMw/F2OxBD2O8Sh50NY9K7cDviDuPYbJpWTJ8aUGI1PGBd5w9ZS2tyrVrzF
         82kUxSQTT9lW69+Ejg6il1T9N2nIF5FWfWie0qncmII5oajm2voxVWbdDlTEBwqWGQen
         hklg==
X-Gm-Message-State: AOJu0YyPqu9FE9lupSTJyPIDauC/mUGEdGxqbDlpUKPJKo8TyXB51B1Z
	q2drVFPtUlG/FIHgGcVQkcQEmYtOm5mdHNuTAjt9azMoZZ2oi+Sl
X-Google-Smtp-Source: AGHT+IE1JY1W8Es9jN5la+0VIgGMI5cJCiRcCOKfL69j/DB7dEodD5OQlpLBngX0v6iXd1MqLN8BRg==
X-Received: by 2002:a50:baa7:0:b0:56e:2e0e:2544 with SMTP id x36-20020a50baa7000000b0056e2e0e2544mr4586678ede.33.1712842782174;
        Thu, 11 Apr 2024 06:39:42 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id u12-20020a056402110c00b0056e51535a2esm703800edv.82.2024.04.11.06.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:39:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 11 Apr 2024 15:39:39 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Conrad Grobler <grobler@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v2] x86/boot/64: Clear CR4.PGE to disable global 1:1
 mappings
Message-ID: <ZhfoG1ghBUopaAH1@gmail.com>
References: <20240410151354.506098-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410151354.506098-2-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The early 64-bit boot code must be entered with a 1:1 mapping of the
> bootable image, but it cannot operate without a 1:1 mapping of all the
> assets in memory that it accesses, and therefore, it creates such
> mappings for all known assets upfront, and additional ones on demand
> when a page fault happens on a memory address.
> 
> These mappings are created with the global bit G set, as the flags used
> to create page table descriptors are based on __PAGE_KERNEL_LARGE_EXEC
> defined by the core kernel, even though the context where these mappings
> are used is very different.
> 
> This means that the TLB maintenance carried out by the decompressor is
> not sufficient if it is entered with CR4.PGE enabled, which has been
> observed to happen with the stage0 bootloader of project Oak. While this
> is a dubious practice if no global mappings are being used to begin
> with, the decompressor is clearly at fault here for creating global
> mappings and not performing the appropriate TLB maintenance.
> 
> Since commit
> 
>   f97b67a773cd84b ("x86/decompressor: Only call the trampoline when changing paging levels")
> 
> CR4 is no longer modified by the decompressor if no change in the number
> of paging levels is needed. Before that, CR4 would always be set to a
> consistent value with PGE cleared.
> 
> So let's reinstate a simplified version of the original logic to put CR4
> into a known state, and preserve the PAE, MCE and LA57 bits, none of
> which can be modified freely at this point (PAE and LA57 cannot be
> changed while running in long mode, and MCE cannot be cleared when
> running under some hypervisors)
> 
> Cc: Conrad Grobler <grobler@google.com>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Fixes: f97b67a773cd84b ("x86/decompressor: Only call the trampoline when ...")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: Bring back the original logic rather than only clearing PGE. Note
>     that this means that the load of CR4 cannot be elided since MCE and
>     LA57 cannot be set unconditionally.
> 
>  arch/x86/boot/compressed/head_64.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index bf4a10a5794f..d0f2c591f730 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -398,6 +398,11 @@ SYM_CODE_START(startup_64)
>  	call	sev_enable
>  #endif
>  
> +	/* Preserve only the CR4 bits that must be preserved, and clear the rest */
> +	movq	%cr4, %rax
> +	andl	$(X86_CR4_PAE | X86_CR4_MCE | X86_CR4_LA57), %eax
> +	movq	%rax, %cr4

Yeah, this is still better IMO than the original patch.

Note that you reused the original title, which isn't entirely accurate 
anymore:

   x86/boot/64: Clear CR4.PGE to disable global 1:1 mappings

I updated it to:

   x86/boot/64: Clear most of CR4 in startup_64(), except PAE, MCE and LA57

Thanks,

	Ingo

