Return-Path: <linux-kernel+bounces-164194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871898B7A80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39EF1F23D47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813E143751;
	Tue, 30 Apr 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqNVGY11"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0393143749;
	Tue, 30 Apr 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488400; cv=none; b=DQTnwsq3qd6j2LYvuKr73vXKzyaMOAbbv9tMRIzlA5wp0Xzow7wYjlZVREANvj4JaUJRNr6xPqev8G85Pl9qJ/tdVigkm/N83XODaypYtY53NXOHTSxyvo/BMNtEO/lbXeFk4dQFIPbn8KbZZrUmjrWQvUKIAmBf3wBvOYW3zQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488400; c=relaxed/simple;
	bh=OF1B/2fqikOk+fZA1b0m3nwOF46QgYsAg2cEBeOpOXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOLIDrLKjad3dvSunKwdfZxJqM3DLVRFV9hazN6HJXcaVKKcZm12lFTapOuTArTRSmBi4p6s/5lTdGmR28jFKeEL+efWi13ZswwGoYZyvl62Db0gHRyDyWDF2J8WXMNAIUbveKvmMUDFBkr6feiFLx3BfAYLH5luDqjroANoX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqNVGY11; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714488398; x=1746024398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OF1B/2fqikOk+fZA1b0m3nwOF46QgYsAg2cEBeOpOXU=;
  b=bqNVGY11NlH91HCURuJyifSUyCpMrHdgpDKxZBPCV/4JsbPvmiuVSxHG
   lswKGLtBvXnja057NWG06Z9jpNtunbh5fKpq2ijz4jdaAgU4c06vQMVqg
   Qlu4VKw9n/cM1oVQ16b6u2Bn4yTkltBoGVGAydKrgfGp7IK3pNTB88VkW
   wAiSx8yJ9Z6lGLworBp6v4ESagCuHvq86oo0NYMNi0SlF6hSSur/sC7QQ
   GSNKPOntPVOGuZI7Pnu7u9qp5CjHA9VB+qxJnXHNoC/9iVlh4K7WD7h0W
   Vc3kMqAXcwQq97gsNVwLiw9WvFmqDeBGOQbde+aJhsuENtDkF14VmEVX4
   w==;
X-CSE-ConnectionGUID: qUDLK2G+TSGZWvv3iYDZuw==
X-CSE-MsgGUID: ktr/4aH0QzCc5yC3gF0kKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20742972"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20742972"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:46:38 -0700
X-CSE-ConnectionGUID: rzw2MU5JTHScR5pKYAZF+g==
X-CSE-MsgGUID: EoaWC4eZTXa2IUNbKusdUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26981468"
Received: from mehlow-prequal01.jf.intel.com ([10.54.102.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:46:38 -0700
From: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
To: jarkko@kernel.org
Cc: dave.hansen@linux.intel.com,
	dmitrii.kuvaiskii@intel.com,
	haitao.huang@linux.intel.com,
	kai.huang@intel.com,
	kailun.qin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	mona.vij@intel.com,
	reinette.chatre@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/sgx: Resolve EREMOVE page vs EAUG page data race
Date: Tue, 30 Apr 2024 07:38:16 -0700
Message-Id: <20240430143816.913292-1-dmitrii.kuvaiskii@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D0WMR6UESTUC.IMBRWMJ80RHQ@kernel.org>
References: <D0WMR6UESTUC.IMBRWMJ80RHQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Content-Transfer-Encoding: 8bit

On Mon, Apr 29, 2024 at 04:11:03PM +0300, Jarkko Sakkinen wrote:
> On Mon Apr 29, 2024 at 1:43 PM EEST, Dmitrii Kuvaiskii wrote:
> > Two enclave threads may try to add and remove the same enclave page
> > simultaneously (e.g., if the SGX runtime supports both lazy allocation
> > and `MADV_DONTNEED` semantics). Consider this race:
> >
> > 1. T1 performs page removal in sgx_encl_remove_pages() and stops right
> >    after removing the page table entry and right before re-acquiring the
> >    enclave lock to EREMOVE and xa_erase(&encl->page_array) the page.
> > 2. T2 tries to access the page, and #PF[not_present] is raised. The
> >    condition to EAUG in sgx_vma_fault() is not satisfied because the
> >    page is still present in encl->page_array, thus the SGX driver
> >    assumes that the fault happened because the page was swapped out. The
> >    driver continues on a code path that installs a page table entry
> >    *without* performing EAUG.
> > 3. The enclave page metadata is in inconsistent state: the PTE is
> >    installed but there was no EAUG. Thus, T2 in userspace infinitely
> >    receives SIGSEGV on this page (and EACCEPT always fails).
> >
> > Fix this by making sure that T1 (the page-removing thread) always wins
> > this data race. In particular, the page-being-removed is marked as such,
> > and T2 retries until the page is fully removed.
> >
> > Fixes: 9849bb27152c ("x86/sgx: Support complete page removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c  | 3 ++-
> >  arch/x86/kernel/cpu/sgx/encl.h  | 3 +++
> >  arch/x86/kernel/cpu/sgx/ioctl.c | 1 +
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> > index 41f14b1a3025..7ccd8b2fce5f 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -257,7 +257,8 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
> >  
> >  	/* Entry successfully located. */
> >  	if (entry->epc_page) {
> > -		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
> > +		if (entry->desc & (SGX_ENCL_PAGE_BEING_RECLAIMED |
> > +				   SGX_ENCL_PAGE_BEING_REMOVED))
> >  			return ERR_PTR(-EBUSY);
> >  
> >  		return entry;
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> > index f94ff14c9486..fff5f2293ae7 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.h
> > +++ b/arch/x86/kernel/cpu/sgx/encl.h
> > @@ -25,6 +25,9 @@
> >  /* 'desc' bit marking that the page is being reclaimed. */
> >  #define SGX_ENCL_PAGE_BEING_RECLAIMED	BIT(3)
> >  
> > +/* 'desc' bit marking that the page is being removed. */
> > +#define SGX_ENCL_PAGE_BEING_REMOVED	BIT(2)
> > +
> >  struct sgx_encl_page {
> >  	unsigned long desc;
> >  	unsigned long vm_max_prot_bits:8;
> > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> > index b65ab214bdf5..c542d4dd3e64 100644
> > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > @@ -1142,6 +1142,7 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
> >  		 * Do not keep encl->lock because of dependency on
> >  		 * mmap_lock acquired in sgx_zap_enclave_ptes().
> >  		 */
> > +		entry->desc |= SGX_ENCL_PAGE_BEING_REMOVED;
> >  		mutex_unlock(&encl->lock);
> >  
> >  		sgx_zap_enclave_ptes(encl, addr);
> 
> It is somewhat trivial to NAK this as the commit message does
> not do any effort describing the new flag. By default at least
> I have strong opposition against any new flags related to
> reclaiming even if it needs a bit of extra synchronization
> work in the user space.
> 
> One way to describe concurrency scenarios would be to take
> example from https://www.kernel.org/doc/Documentation/memory-barriers.txt
> 
> I.e. see the examples with CPU 1 and CPU 2.

Thank you for the suggestion. Here is my new attempt at describing the racy
scenario:

Consider some enclave page added to the enclave. User space decides to
temporarily remove this page (e.g., emulating the MADV_DONTNEED semantics)
on CPU1. At the same time, user space performs a memory access on the same
page on CPU2, which results in a #PF and ultimately in sgx_vma_fault().
Scenario proceeds as follows:

/*
 * CPU1: User space performs
 * ioctl(SGX_IOC_ENCLAVE_REMOVE_PAGES)
 * on a single enclave page
 */
sgx_encl_remove_pages() {

  mutex_lock(&encl->lock);

  entry = sgx_encl_load_page(encl);
  /*
   * verify that page is
   * trimmed and accepted
   */

  mutex_unlock(&encl->lock);

  /*
   * remove PTE entry; cannot
   * be performed under lock
   */
  sgx_zap_enclave_ptes(encl);
                                   /*
                                    * Fault on CPU2
                                    */
                                   sgx_vma_fault() {
                                     /*
                                      * PTE entry was removed, but the
                                      * page is still in enclave's xarray
                                      */
                                     xa_load(&encl->page_array) != NULL ->
                                     /*
                                      * SGX driver thinks that this page
                                      * was swapped out and loads it
                                      */
                                     mutex_lock(&encl->lock);
                                     /*
                                      * this is effectively a no-op
                                      */
                                     entry = sgx_encl_load_page_in_vma();
                                     /*
                                      * add PTE entry
                                      */
                                     vmf_insert_pfn(...);

                                     mutex_unlock(&encl->lock);
                                     return VM_FAULT_NOPAGE;
                                   }
  /*
   * continue with page removal
   */
  mutex_lock(&encl->lock);

  sgx_encl_free_epc_page(epc_page) {
    /*
     * remove page via EREMOVE
     */
    /*
     * free EPC page
     */
    sgx_free_epc_page(epc_page);
  }

  xa_erase(&encl->page_array);

  mutex_unlock(&encl->lock);
}

CPU1 removed the page. However CPU2 installed the PTE entry on the
same page. This enclave page becomes perpetually inaccessible (until
another SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl). This is because the page is
marked accessible in the PTE entry but is not EAUGed. Because of this
combination, any subsequent access to this page raises a fault, and the #PF
handler sees the SGX bit set in the #PF error code and does not call
sgx_vma_fault() but instead raises a SIGSEGV. The userspace SIGSEGV handler
cannot perform EACCEPT because the page was not EAUGed. Thus, the user
space is stuck with the inaccessible page.

This race can be fixed by forcing the fault handler on CPU2 to back off if
the page is currently being removed (on CPU1). Thus a simple change is to
introduce a new flag SGX_ENCL_PAGE_BEING_REMOVED, which is unset by default
and set only right-before the first mutex_unlock() in
sgx_encl_remove_pages(). Upon loading the page, CPU2 checks whether this
page is being removed, and if yes then CPU2 backs off and waits until the
page is completely removed. After that, any memory access to this page
results in a normal "allocate and EAUG a page on #PF" flow.

--
Dmitrii Kuvaiskii

