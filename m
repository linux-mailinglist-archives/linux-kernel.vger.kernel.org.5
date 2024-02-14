Return-Path: <linux-kernel+bounces-65562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8C7854EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A53281649
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E5460ECB;
	Wed, 14 Feb 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T4+Q2Q7H"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC0B5FF03
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928647; cv=none; b=U03E9idUa5SIkVvb1NXxyKd/Gzj/YntcQGkS82p6Mj92IUhM51oDzEqDXYypqsWD6jsWbU6lSFL6RHvhJkRYMp2OoyCzwlHUX8gzgiu0ibZ4JldT1p8KcA9eiayWUQb9UkzOkfevHHBck2YzIZgZpDWh9Eh1ptqKdntvwHxW9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928647; c=relaxed/simple;
	bh=9voo30oNITjqcl95HrTR+YJsE+CMPDocBizyzA23bz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyLgQaLrjbniWYhFygSdjlPmAQqitm/eptLaJICcEGkr5J5N+5/IvsUjapGP1jMFDMhSEBgeVAJrgLDWQwf1XCkWGIOjWrCJtC1lDJvp8y/oz9cNcEQSDvEyiPZ7nFkiQfRKfV8tZHSYsTUkpNSYaOrb6HxXVNcoohF6QRrIYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T4+Q2Q7H; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1112)
	id DDCCD207ECBE; Wed, 14 Feb 2024 08:37:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDCCD207ECBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707928645;
	bh=+kmK/2svGs1ufSiHAszH1wJVvcNtLuRM2uodeUxuFqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4+Q2Q7HVRE7NyIVkRErx6go+pIXm3Gi4BCXg+jhkBYwC/LflqXaSAuKKktgempiy
	 rI7MByuyRDgkehY58yH9Ug8nrU25W1TX/21KWN5Ypi7Bb8dgQA2bwsNkzrPnSzYaIS
	 ba4XaTGO1ADvT6hf1aka+pQkkF0sSCIGHVrQbv3E=
Date: Wed, 14 Feb 2024 08:37:25 -0800
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sev: Dump SEV_STATUS
Message-ID: <20240214163725.GA13407@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240213163311.32130-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213163311.32130-1-bp@alien8.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 13, 2024 at 05:33:11PM +0100, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> It is, and will be even more useful in the future, to dump the SEV
> features enabled according to SEV_STATUS. Do so:
> 
>   [    0.542753] Memory Encryption Features active: AMD SEV SEV-ES SEV-SNP
>   [    0.544425] SEV: Status: SEV SEV-ES SEV-SNP DebugSwap
> 

This could use some commas/delimiters to improve readability for those multi-word
bits (or stick to the name from the APM). This is from an Azure SNP CVM(*):

Feb 14 16:16:55 vm kernel: SEV: Status: SEV SEV-ES SEV-SNP vTom Reflect VC AI DebugSwap No HostIBS BTB Isol VMSA reg prot

(*): tested with the below patch applied (I'm not suggesting this should be
incorporated) because from a kernel point of view only vTOM is present in the
cached sev_status, the rest is handled by VMPL0:

--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2285,6 +2285,8 @@
 void sev_show_status(void)
 {
        int i;
+       u64 sev_status;
+       rdmsrl(MSR_AMD64_SEV, sev_status);

        pr_info("Status: ");
        for (i = 0; i < MSR_AMD64_SNP_RESV_BIT; i++) {


