Return-Path: <linux-kernel+bounces-161107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC98B4736
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E4E1F226AF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB11428E7;
	Sat, 27 Apr 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DjGXAN+b"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8748F77
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714236950; cv=none; b=ot6i7SG6APTbER8boJFqri4DEFl8xBmEogDEv+fPBOFgnTJrOJIjOpsZr+TUuOv9MmpFwRf6SSjoP4sgh+r4Kj2NI+kTI8t/HxZRO95kD1np0BFVeaRjjpJV1UGk0xpXfKcUEb9T4scNTQMLg7XZZQ3TMfPvmvlpNbv1YkwbEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714236950; c=relaxed/simple;
	bh=B+EwIW3/BGAmVbm61WUgZ9X7DpD/uEeYcPKZ0BRR3dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnUnmczR6y/IGl9Apy22MLqbsJHeshB+MRmd+pnBk3yNPQdoZOW9C4HhIQJfcrQsBvRppfOA2MS6FPmVg+sHMFJPMh541ZzKIrd8lUMBp7ucOz5Ga7JnL0ktmiPbs8Jr3KZJsjdlSC9Ey+JuHbO8zKOPtoWdb01MlhZ+ZgpZaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DjGXAN+b; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 05F6740E0187;
	Sat, 27 Apr 2024 16:48:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RJqSXYuWMYl9; Sat, 27 Apr 2024 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714236494; bh=SQR9m3AlnZH/DoVLOL78q+n6vHtGt70RLlgLJ3+EdQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjGXAN+b8wx5Km/bOJsO0ZI7VOO8xPDmfWqfW9OmLLleG0fdy/h8yBpHmZEFNOg7l
	 tQZd0ZkO/ujyqgn/tRcghWxqpMJL8W71cRx6yggVBsm5c5AsKPqH5mAatwZCB7xZTE
	 KorsprTHlyDtCLstPx/3aiTaQjasP2LdyvZW3TuVBRvK8UD8u+MSeJsgI7ww0v0dWk
	 lI2HFNxI1TmbgjPJ7+Q4NN2jfPCsi1nGWOftkZ/9mc1Kvhj+vdeTfilKimvNzOkGAw
	 syf9J5Ruw4c6Qw6R3h2f75cxRCyCcED9hFofDHFCgI3Sh/TtlKCt65mzh4CYNuEZR5
	 x8ZIU2Zw20taEdkP48LQ/eqVmzLY7aByaogExDmDokQhpWRCiLg8gRia1i7JXwb/nj
	 Sfh4DAXa4p9rR426wKQTOv0G+g4j0zEWBNbwKuf2qVco12zHvqyHmZDJNimQM6NGhc
	 nSyZOzlfQRkIEKdxZJ/oQmirPtXa5Q5a+48XB5ab0O1PV5G0XEqqQopa/gaG9Ia/ad
	 ChY80GmGaeXjVq8kNRbqkvF5QFmsnKI2kd8zYfNbA0AS5sdwG13ir5hSEaNx17vIw4
	 uYeA7jdWVeg+7GmxPjJHc11qf0yzFRgdOLzVS1ErEhxZplrbsG9wdobsPO44KRJ8/r
	 18rO1xRu2is89599r8DzbBoQ=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 831FE40E0177;
	Sat, 27 Apr 2024 16:47:52 +0000 (UTC)
Date: Sat, 27 Apr 2024 18:47:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 09/18] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Message-ID: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-10-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-10-kirill.shutemov@linux.intel.com>

On Tue, Apr 09, 2024 at 02:30:01PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e74d0c4286c1..7a1560d7e62d 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -128,6 +128,12 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  #ifdef CONFIG_HPET_TIMER
>  	hpet_disable();
>  #endif
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> +		x86_platform.guest.enc_kexec_stop_conversion(true);
> +		x86_platform.guest.enc_kexec_unshare_mem();
> +	}

This is not how this is done - the point of those function pointers is
to avoid random checks in the code but simply unconditionally call them.

The platform which needs something special to happen, assigns to them
its own function pointers and the rest assigns dummy stubs.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

