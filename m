Return-Path: <linux-kernel+bounces-138675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5429E89F8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A1E28C67F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0415F418;
	Wed, 10 Apr 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTmKoz4s"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9315F411
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756920; cv=none; b=RutzQSMHm6kjQoZj7OFN1jqeZPuQrfEA4H86LeCnlHJbEaIdREAMkirhrmIKPD1o9u0cUCkWmXYGZMndZIoBJEoutGghWwMI8BN2o0Jl9BaIRLVZfPdHQWEJfy/unPfSFqMtGWiVvyLMbf18ulSGEGPQRw3NGpBHzacG0PKfjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756920; c=relaxed/simple;
	bh=vmXk+SAst356u34cCEqJ50TKWWJkZlemDS0s4I+2/5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNXyTD/VE8E7gW0NfVcc+3V4KlAif42hVXQcSwJt7NVZRtrewXU9r4wWAz7nxcaSjRRHaqPRsg7nj7/uAfe7kWycSpmTL7CoBYfb2zdyvCwyW0AuYS3vlRl1h8+88F6Y11q/xY4GpvsNK9aS6KioW1l67Ich6b0HW5T8inI0wYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTmKoz4s; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516c403cc46so12890481e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712756916; x=1713361716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxMt7To/rBHmDe2wvrBGXvblS5dXRQ5rorH0JH8RPuc=;
        b=aTmKoz4s64xPgAXKlbdc36onAc2hPxBM3pJK0ZuJwPZCY7ljwI2zVz/uLbvXENV0w1
         4maYT3GQ0VMkX9l6nBQk/ZwWtVbZsq3+il1BDs3qW24TlmfBUUxWhnL93JwO4vVtAL6y
         7j9bDBZ68cVh9nMBMeLAV9Jv2z49XRG3MHHRLf25moqxM3mFGKdQ8qaaTe4SDJVwy6wB
         FKMSWWKhCvz7ZUEZpmuw+Q8tBt5dAGKayNT/vYensprM911GRpfl/RsSi97UbH7gSM12
         2a042NxBRFjgFg6/+OI8hBjgU/aEhyhgBPnlRjPwugzOQRydfpMLpDGxkg2pOgqSq+0R
         zKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756916; x=1713361716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxMt7To/rBHmDe2wvrBGXvblS5dXRQ5rorH0JH8RPuc=;
        b=cAMkS6ooIOjlPwS0QvodYZpU/JBrOgZZe0YvCkxNsNrF6UpbgW49Xz7l6R7r0xcxvI
         bmx/iL20HbAsyzMj5867tCEoHAfaOw3fsQQFDL43KsD0c/UsA30ZZI9cKIyyzlWOP0Ol
         VFD7lm9iyKrm3HnX+syscmQaHALmowS2JuTp/SBjjEzxcg9eMzufBpEz8KJ7fXyQZL0o
         9yTBv5GmfVYixIWxuuPRAJF9EmDZkOwdJQIsPbLG6dUDHt646FSDpLzeUWrPbRtS+8MK
         uoxSk9xu5IoDA7NF0iEKO7HCnpoYr6Ma9cuTcMpshAA/a/oHoHuoHuq0ocqEGmGy4GUY
         Btmw==
X-Gm-Message-State: AOJu0YzwiVFm2GGK+sh/o1II7uSHnlBF3W9wt++ZGrZ9HASobY/VOHXs
	fOpJHUp6UtJUsOOMKSTor1USotM3b/kXMOX0Q7f2hNywj4BkgwoC
X-Google-Smtp-Source: AGHT+IEErt20UxgtbjOl4ueyBisjAY86VNz0NmfPKw3ecyVWn1dIbIAdmu9rplzuE6lr9Riq7Vho2Q==
X-Received: by 2002:a05:6512:6c4:b0:515:cf42:117b with SMTP id u4-20020a05651206c400b00515cf42117bmr2813343lff.60.1712756915606;
        Wed, 10 Apr 2024 06:48:35 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id r4-20020a170906c28400b00a51e05711b9sm3000950ejz.166.2024.04.10.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:48:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 15:48:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	xen-devel@lists.xenproject.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH] x86/pat: fix W^X violation false-positives when running
 as Xen PV guest
Message-ID: <ZhaYsAuhhqomQUWT@gmail.com>
References: <20240409094712.21285-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409094712.21285-1-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> When running as Xen PV guest in some cases W^X violation WARN()s have
> been observed. Those WARN()s are produced by verify_rwx(), which looks
> into the PTE to verify that writable kernel pages have the NX bit set
> in order to avoid code modifications of the kernel by rogue code.
> 
> As the NX bits of all levels of translation entries are or-ed and the
> RW bits of all levels are and-ed, looking just into the PTE isn't enough
> for the decision that a writable page is executable, too. When running
> as a Xen PV guest, kernel initialization will set the NX bit in PMD
> entries of the initial page tables covering the .data segment.
> 
> When finding the PTE to have set the RW bit but no NX bit, higher level
> entries must be looked at. Only when all levels have the RW bit set and
> no NX bit set, the W^X violation should be flagged.
> 
> Additionally show_fault_oops() has a similar problem: it will issue the
> "kernel tried to execute NX-protected page" message only if it finds
> the NX bit set in the leaf translation entry, while any NX bit in
> non-leaf entries are being ignored for issuing the message.
> 
> Modify lookup_address_in_pgd() to return the effective NX and RW bit
> values of the non-leaf translation entries and evaluate those as well
> in verify_rwx() and show_fault_oops().

Ok, this fix makes sense, as that's how the hardware works and we interpret 
the pagetables poorly.

> Fixes: 652c5bf380ad ("x86/mm: Refuse W^X violations")
> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/pgtable_types.h |  2 +-
>  arch/x86/kernel/sev.c                |  3 +-
>  arch/x86/mm/fault.c                  |  7 ++--
>  arch/x86/mm/pat/set_memory.c         | 56 +++++++++++++++++++++-------
>  arch/x86/virt/svm/sev.c              |  3 +-
>  5 files changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 0b748ee16b3d..91ab538d3872 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -565,7 +565,7 @@ static inline void update_page_count(int level, unsigned long pages) { }
>   */
>  extern pte_t *lookup_address(unsigned long address, unsigned int *level);
>  extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> -				    unsigned int *level);
> +				    unsigned int *level, bool *nx, bool *rw);
>  extern pmd_t *lookup_pmd_address(unsigned long address);
>  extern phys_addr_t slow_virt_to_phys(void *__address);
>  extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,

Please introduce a new lookup_address_in_pgd_attr() function or so, which 
is used by code intentionally.

This avoids changing the arch/x86/kernel/sev.c and arch/x86/virt/svm/sev.c 
uses, that retrieve these attributes but don't do anything with them:

> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 38ad066179d8..adba581e999d 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -516,12 +516,13 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
>  	unsigned long va = (unsigned long)vaddr;
>  	unsigned int level;
>  	phys_addr_t pa;
> +	bool nx, rw;
>  	pgd_t *pgd;
>  	pte_t *pte;
>  
>  	pgd = __va(read_cr3_pa());
>  	pgd = &pgd[pgd_index(va)];
> -	pte = lookup_address_in_pgd(pgd, va, &level);
> +	pte = lookup_address_in_pgd(pgd, va, &level, &nx, &rw);
>  	if (!pte) {
>  		ctxt->fi.vector     = X86_TRAP_PF;
>  		ctxt->fi.cr2        = vaddr;
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 622d12ec7f08..eb8e897a5653 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -514,18 +514,19 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
>  
>  	if (error_code & X86_PF_INSTR) {
>  		unsigned int level;
> +		bool nx, rw;
>  		pgd_t *pgd;
>  		pte_t *pte;
>  
>  		pgd = __va(read_cr3_pa());
>  		pgd += pgd_index(address);
>  
> -		pte = lookup_address_in_pgd(pgd, address, &level);
> +		pte = lookup_address_in_pgd(pgd, address, &level, &nx, &rw);
>  
> -		if (pte && pte_present(*pte) && !pte_exec(*pte))
> +		if (pte && pte_present(*pte) && (!pte_exec(*pte) || nx))
>  			pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
>  				from_kuid(&init_user_ns, current_uid()));
> -		if (pte && pte_present(*pte) && pte_exec(*pte) &&
> +		if (pte && pte_present(*pte) && pte_exec(*pte) && !nx &&
>  				(pgd_flags(*pgd) & _PAGE_USER) &&
>  				(__read_cr4() & X86_CR4_SMEP))
>  			pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",

This should be a separate patch - as it might change observed behavior.

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 80c9037ffadf..baa4dc4748e9 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -619,7 +619,8 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
>   * Validate strict W^X semantics.
>   */
>  static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
> -				  unsigned long pfn, unsigned long npg)
> +				  unsigned long pfn, unsigned long npg,
> +				  bool nx, bool rw)
>  {
>  	unsigned long end;
>  
> @@ -641,6 +642,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
>  		return new;
>  
> +	/* Non-leaf translation entries can disable writing or execution. */
> +	if (!rw || nx)
> +		return new;
> +
>  	end = start + npg * PAGE_SIZE - 1;
>  	WARN_ONCE(1, "CPA detected W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
>  		  (unsigned long long)pgprot_val(old),
> @@ -660,17 +665,22 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>   * Return a pointer to the entry and the level of the mapping.
>   */
>  pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> -			     unsigned int *level)
> +			     unsigned int *level, bool *nx, bool *rw)
>  {
>  	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
>  
>  	*level = PG_LEVEL_NONE;
> +	*nx = false;
> +	*rw = true;
>  
>  	if (pgd_none(*pgd))
>  		return NULL;
>  
> +	*nx |= pgd_flags(*pgd) & _PAGE_NX;
> +	*rw &= pgd_flags(*pgd) & _PAGE_RW;
> +
>  	p4d = p4d_offset(pgd, address);
>  	if (p4d_none(*p4d))
>  		return NULL;
> @@ -679,6 +689,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>  	if (p4d_leaf(*p4d) || !p4d_present(*p4d))
>  		return (pte_t *)p4d;
>  
> +	*nx |= p4d_flags(*p4d) & _PAGE_NX;
> +	*rw &= p4d_flags(*p4d) & _PAGE_RW;
> +
>  	pud = pud_offset(p4d, address);
>  	if (pud_none(*pud))
>  		return NULL;
> @@ -687,6 +700,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>  	if (pud_leaf(*pud) || !pud_present(*pud))
>  		return (pte_t *)pud;
>  
> +	*nx |= pud_flags(*pud) & _PAGE_NX;
> +	*rw &= pud_flags(*pud) & _PAGE_RW;
> +
>  	pmd = pmd_offset(pud, address);
>  	if (pmd_none(*pmd))
>  		return NULL;
> @@ -695,6 +711,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>  	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
>  		return (pte_t *)pmd;
>  
> +	*nx |= pmd_flags(*pmd) & _PAGE_NX;
> +	*rw &= pmd_flags(*pmd) & _PAGE_RW;
> +
>  	*level = PG_LEVEL_4K;
>  

This should be a separate preparatory patch that also introduces the new 
method - without changing any behavior.

  	return pte_offset_kernel(pmd, address);
> @@ -710,18 +729,24 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>   */
>  pte_t *lookup_address(unsigned long address, unsigned int *level)
>  {
> -	return lookup_address_in_pgd(pgd_offset_k(address), address, level);
> +	bool nx, rw;
> +
> +	return lookup_address_in_pgd(pgd_offset_k(address), address, level,
> +				     &nx, &rw);
>  }
>  EXPORT_SYMBOL_GPL(lookup_address);
>  
>  static pte_t *_lookup_address_cpa(struct cpa_data *cpa, unsigned long address,
> -				  unsigned int *level)
> +				  unsigned int *level, bool *nx, bool *rw)
>  {
> -	if (cpa->pgd)
> -		return lookup_address_in_pgd(cpa->pgd + pgd_index(address),
> -					       address, level);
> +	pgd_t *pgd;
> +
> +	if (!cpa->pgd)
> +		pgd = pgd_offset_k(address);
> +	else
> +		pgd = cpa->pgd + pgd_index(address);
>  
> -	return lookup_address(address, level);
> +	return lookup_address_in_pgd(pgd, address, level, nx, rw);

I think it would be better to split out this change as well into a separate 
patch. It changes the flow from lookup_address_in_pgd() + lookup_address() 
to only use lookup_address_in_pgd(), which is an identity transformation 
that should be better done separately.

>  }
>  
>  /*
> @@ -849,12 +874,13 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
>  	pgprot_t old_prot, new_prot, req_prot, chk_prot;
>  	pte_t new_pte, *tmp;
>  	enum pg_level level;
> +	bool nx, rw;
>  
>  	/*
>  	 * Check for races, another CPU might have split this page
>  	 * up already:
>  	 */
> -	tmp = _lookup_address_cpa(cpa, address, &level);
> +	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
>  	if (tmp != kpte)
>  		return 1;
>  
> @@ -965,7 +991,8 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
>  	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
>  				      psize, CPA_DETECT);
>  
> -	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages);
> +	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages,
> +			      nx, rw);
>  
>  	/*
>  	 * If there is a conflict, split the large page.
> @@ -1046,6 +1073,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	pte_t *pbase = (pte_t *)page_address(base);
>  	unsigned int i, level;
>  	pgprot_t ref_prot;
> +	bool nx, rw;
>  	pte_t *tmp;
>  
>  	spin_lock(&pgd_lock);
> @@ -1053,7 +1081,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	 * Check for races, another CPU might have split this page
>  	 * up for us already:
>  	 */
> -	tmp = _lookup_address_cpa(cpa, address, &level);
> +	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
>  	if (tmp != kpte) {
>  		spin_unlock(&pgd_lock);
>  		return 1;
> @@ -1594,10 +1622,11 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
>  	int do_split, err;
>  	unsigned int level;
>  	pte_t *kpte, old_pte;
> +	bool nx, rw;
>  
>  	address = __cpa_addr(cpa, cpa->curpage);
>  repeat:
> -	kpte = _lookup_address_cpa(cpa, address, &level);
> +	kpte = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
>  	if (!kpte)
>  		return __cpa_process_fault(cpa, address, primary);
>  
> @@ -1619,7 +1648,8 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
>  		new_prot = static_protections(new_prot, address, pfn, 1, 0,
>  					      CPA_PROTECT);
>  
> -		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1);
> +		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1,
> +				      nx, rw);
>  
>  		new_prot = pgprot_clear_protnone_bits(new_prot);

And then this should be the final patch, which fixes RWX verification 
within the CPA code.

Thanks,

	Ingo

