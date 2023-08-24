Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F174E786828
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbjHXHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbjHXHOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:14:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC48E4E;
        Thu, 24 Aug 2023 00:14:18 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O79t9V007786;
        Thu, 24 Aug 2023 07:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WlYEZfZCf0ozJ1tZc7MZf5FbLW/t+nxFBsciNbifwtA=;
 b=Oi4TfOxu6Sxi9puD2LucXhSgcaGmYR6GxEyyMnZWXYCm72n/s5LX8UoY6gPT8kwSjsi0
 djDZlZcNPPZa8NP2I/NdX09KVld0f+c//v1W72ER5tNZS7lcVMQDnEjC/r7iQKcLlxos
 2bc9EnBcQGdO9+Q64ihV9S+dDR4fwsifhCvOY5R0yQZtg0sECyhba0kTqzSOEZyKQIvN
 NQYLG0DzsapLaDTEyvB2uUuVuBkxL0n81D1HYhWBDGiPMS+UmOavGUyrPYJyJdqpfPiQ
 zS8zT7UmJIDKtW1K8r8o3g2wfNzWMOtX0eQjC8BC5Rh7YzS3U5XpbPnNkMSWv7gaLJx2 wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp2ba09ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 07:12:55 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37O7B3NX013367;
        Thu, 24 Aug 2023 07:12:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp2ba09a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 07:12:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37O4MerU016435;
        Thu, 24 Aug 2023 07:12:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn227w42u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 07:12:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37O7Cnei9896518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 07:12:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B2B020043;
        Thu, 24 Aug 2023 07:12:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39CD720040;
        Thu, 24 Aug 2023 07:12:47 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.83.96])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 24 Aug 2023 07:12:47 +0000 (GMT)
Date:   Thu, 24 Aug 2023 09:12:45 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        surenb@google.com, willy@infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH rfc v2 01/10] mm: add a generic VMA lock-based page fault
 handler
Message-ID: <ZOcC7RsYy5yJLgNb@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230821123056.2109942-1-wangkefeng.wang@huawei.com>
 <20230821123056.2109942-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821123056.2109942-2-wangkefeng.wang@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XRoDdEmpcV5g5_mmP6WT_85M4g4eI751
X-Proofpoint-ORIG-GUID: RuEgWxQsYQ1DVXl1GZzqprjH3NxBC5KY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_03,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=456 mlxscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308240057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 08:30:47PM +0800, Kefeng Wang wrote:

Hi Kefeng,

> The ARCH_SUPPORTS_PER_VMA_LOCK are enabled by more and more architectures,
> eg, x86, arm64, powerpc and s390, and riscv, those implementation are very
> similar which results in some duplicated codes, let's add a generic VMA
> lock-based page fault handler try_to_vma_locked_page_fault() to eliminate
> them, and which also make us easy to support this on new architectures.
> 
> Since different architectures use different way to check vma whether is
> accessable or not, the struct pt_regs, page fault error code and vma flags
> are added into struct vm_fault, then, the architecture's page fault code
> could re-use struct vm_fault to record and check vma accessable by each
> own implementation.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/mm.h       | 17 +++++++++++++++++
>  include/linux/mm_types.h |  2 ++
>  mm/memory.c              | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3f764e84e567..22a6f4c56ff3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -512,9 +512,12 @@ struct vm_fault {
>  		pgoff_t pgoff;			/* Logical page offset based on vma */
>  		unsigned long address;		/* Faulting virtual address - masked */
>  		unsigned long real_address;	/* Faulting virtual address - unmasked */
> +		unsigned long fault_code;	/* Faulting error code during page fault */
> +		struct pt_regs *regs;		/* The registers stored during page fault */
>  	};
>  	enum fault_flag flags;		/* FAULT_FLAG_xxx flags
>  					 * XXX: should really be 'const' */
> +	vm_flags_t vm_flags;		/* VMA flags to be used for access checking */
>  	pmd_t *pmd;			/* Pointer to pmd entry matching
>  					 * the 'address' */
>  	pud_t *pud;			/* Pointer to pud entry matching
> @@ -774,6 +777,9 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  					  unsigned long address);
>  
> +bool arch_vma_access_error(struct vm_area_struct *vma, struct vm_fault *vmf);
> +vm_fault_t try_vma_locked_page_fault(struct vm_fault *vmf);
> +
>  #else /* CONFIG_PER_VMA_LOCK */
>  
>  static inline bool vma_start_read(struct vm_area_struct *vma)
> @@ -801,6 +807,17 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>  	mmap_assert_locked(vmf->vma->vm_mm);
>  }
>  
> +static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> +		unsigned long address)
> +{
> +	return NULL;
> +}
> +
> +static inline vm_fault_t try_vma_locked_page_fault(struct vm_fault *vmf)
> +{
> +	return VM_FAULT_NONE;
> +}
> +
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index f5ba5b0bc836..702820cea3f9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1119,6 +1119,7 @@ typedef __bitwise unsigned int vm_fault_t;
>   * fault. Used to decide whether a process gets delivered SIGBUS or
>   * just gets major/minor fault counters bumped up.
>   *
> + * @VM_FAULT_NONE:		Special case, not starting to handle fault
>   * @VM_FAULT_OOM:		Out Of Memory
>   * @VM_FAULT_SIGBUS:		Bad access
>   * @VM_FAULT_MAJOR:		Page read from storage
> @@ -1139,6 +1140,7 @@ typedef __bitwise unsigned int vm_fault_t;
>   *
>   */
>  enum vm_fault_reason {
> +	VM_FAULT_NONE		= (__force vm_fault_t)0x000000,
>  	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
>  	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
>  	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
> diff --git a/mm/memory.c b/mm/memory.c
> index 3b4aaa0d2fff..60fe35db5134 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5510,6 +5510,45 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	count_vm_vma_lock_event(VMA_LOCK_ABORT);
>  	return NULL;
>  }
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +bool __weak arch_vma_access_error(struct vm_area_struct *vma, struct vm_fault *vmf)
> +{
> +	return (vma->vm_flags & vmf->vm_flags) == 0;
> +}
> +#endif
> +
> +vm_fault_t try_vma_locked_page_fault(struct vm_fault *vmf)
> +{
> +	vm_fault_t fault = VM_FAULT_NONE;
> +	struct vm_area_struct *vma;
> +
> +	if (!(vmf->flags & FAULT_FLAG_USER))
> +		return fault;
> +
> +	vma = lock_vma_under_rcu(current->mm, vmf->real_address);
> +	if (!vma)
> +		return fault;
> +
> +	if (arch_vma_access_error(vma, vmf)) {
> +		vma_end_read(vma);
> +		return fault;
> +	}
> +
> +	fault = handle_mm_fault(vma, vmf->real_address,
> +				vmf->flags | FAULT_FLAG_VMA_LOCK, vmf->regs);
> +
> +	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> +		vma_end_read(vma);

Could you please explain how vma_end_read() call could be conditional?

> +
> +	if (fault & VM_FAULT_RETRY)
> +		count_vm_vma_lock_event(VMA_LOCK_RETRY);
> +	else
> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +
> +	return fault;
> +}
> +
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
>  #ifndef __PAGETABLE_P4D_FOLDED
