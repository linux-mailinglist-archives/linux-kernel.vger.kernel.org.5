Return-Path: <linux-kernel+bounces-162339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAEB8B598E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3F228A4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76375804;
	Mon, 29 Apr 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZkJT+KE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30F74E09;
	Mon, 29 Apr 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396267; cv=none; b=eRP7uhs/pdS9mPxXGzSwHXPR2XB5IfJh/GsRR17yj6ADuB79AEYcbbe38g4dZoMK9E9m+5nAwZIoaxg/5xNZdjLcY8a/u56sIVd32KQIwNLyfxL03BnRPCjR6GMK5wrWIyDaXTwJ0MXTmHUH4d/FwJyUTNg+FaNn7rbRq8UtvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396267; c=relaxed/simple;
	bh=R1UTtJT+uCWZh4nuC8+cBSQQbi4Zt4uHEdWDrtkOgC8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=b/G2qQLkmvpMAj7MiTnaEdlvVpQNaybPOcPqYlo6CYbsB2WvR8433RFXbS5DzaEwLWUkPNjbys4fU1EE8puLAKzcp77sfmvDh26Ea3p+J3v4ryzJJ3KdVBE2luPf71k3BJW8sX5Q303p95wv21VkgW50TxQTV374VT+GZAhLdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZkJT+KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922A3C116B1;
	Mon, 29 Apr 2024 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714396267;
	bh=R1UTtJT+uCWZh4nuC8+cBSQQbi4Zt4uHEdWDrtkOgC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZkJT+KESuOXKJCmj7z1WgncbrlZZaqmsCr+7vvy9mdeH/MDoBe5I6KWlV2x5geaP
	 /PDBYUrCpOP3sADI8xemeDggKrEV6/dB0unAL1bUKUZEd/5tNB8jW+JzSO3She/SjI
	 bFJV1mpIcltDAsNxm/CLT5kCEEdm+Hu6hGGnOyJ7cS8P4ctjbfUGUCXIvTKK80mlI6
	 4Bx51IbOId5D1rv7EXtxMd7/yFpPOOOolKMckG8qvvVq34fegsYFLM7TXeEG55roS/
	 vSOye6v5UAoVLD/nQsbdsL+AyO3NBg6Utl0SoeZiu/0wm9FYGtkEKg7D4XyJlw1u3z
	 EhyRCIcAAj4Ug==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 16:11:03 +0300
Message-Id: <D0WMR6UESTUC.IMBRWMJ80RHQ@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dmitrii Kuvaiskii" <dmitrii.kuvaiskii@intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>,
 <haitao.huang@linux.intel.com>, <reinette.chatre@intel.com>,
 <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <mona.vij@intel.com>, <kailun.qin@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/sgx: Resolve EREMOVE page vs EAUG page data
 race
X-Mailer: aerc 0.17.0
References: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
 <20240429104330.3636113-3-dmitrii.kuvaiskii@intel.com>
In-Reply-To: <20240429104330.3636113-3-dmitrii.kuvaiskii@intel.com>

On Mon Apr 29, 2024 at 1:43 PM EEST, Dmitrii Kuvaiskii wrote:
> Two enclave threads may try to add and remove the same enclave page
> simultaneously (e.g., if the SGX runtime supports both lazy allocation
> and `MADV_DONTNEED` semantics). Consider this race:
>
> 1. T1 performs page removal in sgx_encl_remove_pages() and stops right
>    after removing the page table entry and right before re-acquiring the
>    enclave lock to EREMOVE and xa_erase(&encl->page_array) the page.
> 2. T2 tries to access the page, and #PF[not_present] is raised. The
>    condition to EAUG in sgx_vma_fault() is not satisfied because the
>    page is still present in encl->page_array, thus the SGX driver
>    assumes that the fault happened because the page was swapped out. The
>    driver continues on a code path that installs a page table entry
>    *without* performing EAUG.
> 3. The enclave page metadata is in inconsistent state: the PTE is
>    installed but there was no EAUG. Thus, T2 in userspace infinitely
>    receives SIGSEGV on this page (and EACCEPT always fails).
>
> Fix this by making sure that T1 (the page-removing thread) always wins
> this data race. In particular, the page-being-removed is marked as such,
> and T2 retries until the page is fully removed.
>
> Fixes: 9849bb27152c ("x86/sgx: Support complete page removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c  | 3 ++-
>  arch/x86/kernel/cpu/sgx/encl.h  | 3 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 41f14b1a3025..7ccd8b2fce5f 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -257,7 +257,8 @@ static struct sgx_encl_page *__sgx_encl_load_page(str=
uct sgx_encl *encl,
> =20
>  	/* Entry successfully located. */
>  	if (entry->epc_page) {
> -		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
> +		if (entry->desc & (SGX_ENCL_PAGE_BEING_RECLAIMED |
> +				   SGX_ENCL_PAGE_BEING_REMOVED))
>  			return ERR_PTR(-EBUSY);
> =20
>  		return entry;
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/enc=
l.h
> index f94ff14c9486..fff5f2293ae7 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -25,6 +25,9 @@
>  /* 'desc' bit marking that the page is being reclaimed. */
>  #define SGX_ENCL_PAGE_BEING_RECLAIMED	BIT(3)
> =20
> +/* 'desc' bit marking that the page is being removed. */
> +#define SGX_ENCL_PAGE_BEING_REMOVED	BIT(2)
> +
>  struct sgx_encl_page {
>  	unsigned long desc;
>  	unsigned long vm_max_prot_bits:8;
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index b65ab214bdf5..c542d4dd3e64 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -1142,6 +1142,7 @@ static long sgx_encl_remove_pages(struct sgx_encl *=
encl,
>  		 * Do not keep encl->lock because of dependency on
>  		 * mmap_lock acquired in sgx_zap_enclave_ptes().
>  		 */
> +		entry->desc |=3D SGX_ENCL_PAGE_BEING_REMOVED;
>  		mutex_unlock(&encl->lock);
> =20
>  		sgx_zap_enclave_ptes(encl, addr);

It is somewhat trivial to NAK this as the commit message does
not do any effort describing the new flag. By default at least
I have strong opposition against any new flags related to
reclaiming even if it needs a bit of extra synchronization
work in the user space.

One way to describe concurrency scenarios would be to take
example from https://www.kernel.org/doc/Documentation/memory-barriers.txt

I.e. see the examples with CPU 1 and CPU 2.

BR, Jarkko

