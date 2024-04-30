Return-Path: <linux-kernel+bounces-164191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A38B7A79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387F1B217C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBAA174EF8;
	Tue, 30 Apr 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yn371kQb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD677109;
	Tue, 30 Apr 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488325; cv=none; b=SwgLMSEfUhmLe+JAvrkWQw63AlpRON6qLOufCZZMIeELuR1yOlOR37dTWlV+W1hx39vpB2ebYdwV/iMLhLhRkLKBRWGALc1e7SFOgOqbhQqZRoSua3jwrhzBHLUL7up+IlE0Uf4ZWZXgUIUVOiqkENM26rjMfEiogw264rlQtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488325; c=relaxed/simple;
	bh=GO3JqT8vODgdjJL18arG9BEgpjAliVjYhrBCpB/dLvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNEql8dkCDAu4tqqbITFkcxOa6ujjZWJbGaGaeKpkXRCpISQ3Dc9h+WcWgaUbwrEkfjqOTzMLS2EWFiDurAJ3AJUelR4QuQS3KdqO/Q7k6DQUkCYKbmOudHOW+3jaRHu+VT3pEyK2lllZx+gwKD0pIWEHjimo1xxbIQqwaZkp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yn371kQb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714488324; x=1746024324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GO3JqT8vODgdjJL18arG9BEgpjAliVjYhrBCpB/dLvA=;
  b=Yn371kQbD/cdimhXXi2QPcaquh0EwkmXQrAlFD3Q8ClS8U46ds3MunSu
   HSNdL4npnc+kvDKch9+kSqSuoCwFzidDbLg4/gPgu4o0iDnk9XLTzTaqv
   oZ/qhJWONFMjVeREyDYwEWioukUiHOgGxU43ss3Hn8bgPCcB6NsX6EMbg
   zVVv0XtSbMYsdvhFsucseuEalpLOE24dRSjdvhYZ1LQVH2jt1HAG/VHyc
   391lA+rQs0OD69FX6Yjih40+shuqCzZdvNFgHLj6OGuBafC7c9mTCi/WN
   9xrBU6LWLfUnn4RKU+Mqs5izO3zLqc4DV1bZll3hSWtAug6AnEkcoAebK
   w==;
X-CSE-ConnectionGUID: x2i2zLUYTTub7r//AC45ZA==
X-CSE-MsgGUID: UOEzPH1IRJOv7EoTjE3ccQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14025512"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="14025512"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:45:24 -0700
X-CSE-ConnectionGUID: p7IfGD9fS0OzmfhDsU+daA==
X-CSE-MsgGUID: 04tj7VsLTmCw6qYFqInTuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26566817"
Received: from mehlow-prequal01.jf.intel.com ([10.54.102.156])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:45:22 -0700
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
	mwk@invisiblethingslab.com,
	reinette.chatre@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/sgx: Resolve EAUG race where losing thread returns SIGBUS
Date: Tue, 30 Apr 2024 07:37:01 -0700
Message-Id: <20240430143701.902597-1-dmitrii.kuvaiskii@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D0WMM3MYQODE.3A89L7D6OVG3E@kernel.org>
References: <D0WMM3MYQODE.3A89L7D6OVG3E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Content-Transfer-Encoding: 8bit

On Mon, Apr 29, 2024 at 04:04:24PM +0300, Jarkko Sakkinen wrote:
> On Mon Apr 29, 2024 at 1:43 PM EEST, Dmitrii Kuvaiskii wrote:
> > Two enclave threads may try to access the same non-present enclave page
> > simultaneously (e.g., if the SGX runtime supports lazy allocation). The
> > threads will end up in sgx_encl_eaug_page(), racing to acquire the
> > enclave lock. The winning thread will perform EAUG, set up the page
> > table entry, and insert the page into encl->page_array. The losing
> > thread will then get -EBUSY on xa_insert(&encl->page_array) and proceed
> > to error handling path.
> 
> And that path removes page. Not sure I got gist of this tbh.

Well, this is not about a redundant EREMOVE performed. This is about the
enclave page becoming inaccessible due to a bug triggered with a data race.

Consider some enclave page not yet added to the enclave. The enclave
performs a memory access to it at the same time on CPU1 and CPU2. Since the
page does not yet have a corresponding PTE, the #PF handler on both CPUs
calls sgx_vma_fault(). Scenario proceeds as follows:

/*
 * Fault on CPU1
 */
sgx_vma_fault() {

  xa_load(&encl->page_array) == NULL ->

  sgx_encl_eaug_page() {

    ...                            /*
                                    * Fault on CPU2
                                    */
                                   sgx_vma_fault() {

                                     xa_load(&encl->page_array) == NULL ->

                                     sgx_encl_eaug_page() {

                                       ...

                                       mutex_lock(&encl->lock);
                                       /*
                                        * alloc encl_page
                                        */
                                       /*
                                        * alloc EPC page
                                        */
                                       epc_page = sgx_alloc_epc_page(...);
                                       /*
                                        * add page_to enclave's xarray
                                        */
                                       xa_insert(&encl->page_array, ...);
                                       /*
                                        * add page to enclave via EAUG
                                        * (page is in pending state)
                                        */
                                       /*
                                        * add PTE entry
                                        */
                                       vmf_insert_pfn(...);

                                       mutex_unlock(&encl->lock);
                                       return VM_FAULT_NOPAGE;
                                     }
                                   }
     mutex_lock(&encl->lock);
     /*
      * alloc encl_page
      */
     /*
      * alloc EPC page
      */
     epc_page = sgx_alloc_epc_page(...);
     /*
      * add page_to enclave's xarray,
      * this fails with -EBUSY
      */
     xa_insert(&encl->page_array, ...);

   err_out_shrink:
     sgx_encl_free_epc_page(epc_page) {
       /*
        * remove page via EREMOVE
        */
       /*
        * free EPC page
        */
       sgx_free_epc_page(epc_page);
     }

      mutex_unlock(&encl->lock);
      return VM_FAULT_SIGBUS;
    }
  }

CPU2 added the enclave page (in pending state) to the enclave and installed
the PTE. The kernel gives control back to the user space, without raising a
signal. The user space on CPU2 retries the memory access and induces a page
fault, but now with the SGX bit set in the #PF error code. The #PF handler
calls do_user_addr_fault(), which calls access_error() and ultimately
raises a SIGSEGV. The userspace SIGSEGV handler is supposed to perform
EACCEPT, after which point the enclave page becomes accessible.

CPU1 however jumps to the error handling path because the page was already
inserted into the enclave's xarray. This error handling path EREMOVEs the
page and also raises a SIGBUS signal to user space. The PTE entry is not
removed.

After CPU1 performs EREMOVE, this enclave page becomes perpetually
inaccessible (until an SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl). This is because
the page is marked accessible in the PTE entry but is not EAUGed. Because
of this combination, the #PF handler sees the SGX bit set in the #PF error
code and does not call sgx_vma_fault() but instead raises a SIGSEGV. The
userspace SIGSEGV handler cannot perform EACCEPT because the page was not
EAUGed. Thus, the user space is stuck with the inaccessible page.

Also note that in the scenario, CPU1 raises a SIGBUS signal to user space
unnecessarily. This signal is spurious because a page-access retry on CPU2
will also raise the SIGBUS signal. That said, this side effect is less
severe because it affects only user space. Therefore, it could be
circumvented in user space alone, but it seems reasonable to fix it in this
patch.

> > This error handling path contains two bugs: (1) SIGBUS is sent to
> > userspace even though the enclave page is correctly installed by another
> > thread, and (2) sgx_encl_free_epc_page() is called that performs EREMOVE
> > even though the enclave page was never intended to be removed. The first
> > bug is less severe because it impacts only the user space; the second
> > bug is more severe because it also impacts the OS state by ripping the
> > page (added by the winning thread) from the enclave.
> >
> > Fix these two bugs (1) by returning VM_FAULT_NOPAGE to the generic Linux
> > fault handler so that no signal is sent to userspace, and (2) by
> > replacing sgx_encl_free_epc_page() with sgx_free_epc_page() so that no
> > EREMOVE is performed.
> 
> What is the collateral damage caused by ENCLS[EREMOVE]?

As explained above, the damage is that the SGX driver leaves the enclave
page metadata in an inconsistent state: on the one hand, the PTE entry is
installed which forces the generic Linux fault handler to raise SIGSEGV,
and on the other hand, the page is not in a correct state to be EACCEPTed
(i.e., EAUG was not performed on this page).

> > Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
> > Cc: stable@vger.kernel.org
> > Reported-by: Marcelina Kościelnicka <mwk@invisiblethingslab.com>
> > Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> > index 279148e72459..41f14b1a3025 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -382,8 +382,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> >  	 * If ret == -EBUSY then page was created in another flow while
> >  	 * running without encl->lock
> >  	 */
> > -	if (ret)
> > +	if (ret) {
> > +		if (ret == -EBUSY)
> > +			vmret = VM_FAULT_NOPAGE;
> >  		goto err_out_shrink;
> > +	}
> >  
> >  	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
> >  	pginfo.addr = encl_page->desc & PAGE_MASK;
> > @@ -419,7 +422,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> >  err_out_shrink:
> >  	sgx_encl_shrink(encl, va_page);
> >  err_out_epc:
> > -	sgx_encl_free_epc_page(epc_page);
> > +	sgx_free_epc_page(epc_page);
> 
> This ignores check for the page being reclaimer tracked, i.e. it does
> changes that have been ignored in the commit message.

Indeed, sgx_encl_free_epc_page() performs the following check:

  WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);

However, the EPC page is allocated in sgx_encl_eaug_page() and has
zeroed-out flags in all error-handling paths. In other words, the page is
marked as reclaimable only in the happy path of sgx_encl_eaug_page().
Therefore, in the particular code path that I changed this "page reclaimer
tracked" condition is always false, and the warning is never printed.

Do you want me to explain this in the commit message?

---

(Below questions are from follow-up emails, I add them to this reply email
to have all discussions in one place.)

> > > > What is the collateral damage caused by ENCLS[EREMOVE]?
> >
> > Have you measured cost of eremove on an empty page?
> >
> > I tried to lookup for a thread from lore because I have a faint memory
> > that it was concluded that its cost irrelevant. Please correct if I'm
> > wrong.
> 
> Also pseudocode for EREMOVE supports this as it just returns without
> actually doing anything.

I have not measured the cost of EREMOVE on an empty page. This cost may be
negligible. But as stated above, my patch does not get rid of EREMOVE
simply for performance reasons. My patch removes a data race that leads to
a forever-inaccessible enclave page.

--
Dmitrii Kuvaiskii

