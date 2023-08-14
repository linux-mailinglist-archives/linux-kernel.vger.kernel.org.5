Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0477B9A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjHNNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjHNNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:19:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD0510CE;
        Mon, 14 Aug 2023 06:19:36 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ED8CGN013635;
        Mon, 14 Aug 2023 13:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ivlxHGJUa5WEXVDIeqbk7IOfO8a4tLrJjax9uvT8zR4=;
 b=fw8DfJiagxeAwiqTEuLISwEmywPEHtCVynpFsiV76y/s0AfjE8hL3uU1lFm1cS/5smF3
 zWgEsg9Mxf2Ffg7lUfdnii+SNohySFp+NO+zdE+bY8BNWFyzuZEvsTlucfxRXFcB1nD7
 1lPl0fHWtP14JEJtRHrRTwYXCnWPBq5R/WHzDzwMwpQppPrGDOptVtajLEO/8l59h17l
 GGilBai9KPJY/hQSdOlRnfnZM8m7mkrm0TNkP6e012j9duQCWOlpXv/4bqMIlSNYgIh+
 eWgK82ECg1SxjCchkAxCzNq2+pehhcYFBYK1Jtuejn9LzvKagOEYE08jlx+PvKYnU155 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfm9q1d1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 13:19:26 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37ED8cJg016113;
        Mon, 14 Aug 2023 13:19:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfm9q1d1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 13:19:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37EBZWeM003456;
        Mon, 14 Aug 2023 13:19:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semds4yft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 13:19:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37EDJM8P28508824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 13:19:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FD8820043;
        Mon, 14 Aug 2023 13:19:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77FF52004B;
        Mon, 14 Aug 2023 13:19:21 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.86.49])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Aug 2023 13:19:21 +0000 (GMT)
Date:   Mon, 14 Aug 2023 15:19:19 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/mm: Make virt_to_pfn() a static inline
Message-ID: <ZNop13CA5+UaTj2/@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230812-virt-to-phys-s390-v2-1-6c40f31fe36f@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812-virt-to-phys-s390-v2-1-6c40f31fe36f@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m3DGSqVCAnVGUrNSKh9ZydrDFzK1ElzK
X-Proofpoint-ORIG-GUID: B3t5oLeNKn44h2L0Xd7DarOZcjKUaHLo
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 05:12:54PM +0200, Linus Walleij wrote:
> Making virt_to_pfn() a static inline taking a strongly typed
> (const void *) makes the contract of a passing a pointer of that
> type to the function explicit and exposes any misuse of the
> macro virt_to_pfn() acting polymorphic and accepting many types
> such as (void *), (unitptr_t) or (unsigned long) as arguments
> without warnings.
> 
> For symmetry do the same with pfn_to_virt() reflecting the
> current layout in asm-generic/page.h.
> 
> Doing this reveals a number of offenders in the arch code and
> the S390-specific drivers, so just bite the bullet and fix up
> all of those as well.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Just drop the cast to (unsigned long) in drivers/s390/char/vmcp.c,
>   we do not need to cast to (void *) from (char *), a pointer is
>   a pointer.
> - Link to v1: https://lore.kernel.org/r/20230811-virt-to-phys-s390-v1-1-b661426ca9cd@linaro.org
> ---
>  arch/s390/include/asm/kfence.h |  2 +-
>  arch/s390/include/asm/page.h   | 12 ++++++++++--
>  arch/s390/mm/cmm.c             |  2 +-
>  arch/s390/mm/vmem.c            |  2 +-
>  drivers/s390/block/scm_blk.c   |  2 +-
>  drivers/s390/char/vmcp.c       |  2 +-
>  6 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kfence.h b/arch/s390/include/asm/kfence.h
> index d55ba878378b..e47fd8cbe701 100644
> --- a/arch/s390/include/asm/kfence.h
> +++ b/arch/s390/include/asm/kfence.h
> @@ -35,7 +35,7 @@ static __always_inline void kfence_split_mapping(void)
>  
>  static inline bool kfence_protect_page(unsigned long addr, bool protect)
>  {
> -	__kernel_map_pages(virt_to_page(addr), 1, !protect);
> +	__kernel_map_pages(virt_to_page((void *)addr), 1, !protect);
>  	return true;
>  }
>  
> diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
> index a9c138fcd2ad..cfec0743314e 100644
> --- a/arch/s390/include/asm/page.h
> +++ b/arch/s390/include/asm/page.h
> @@ -191,8 +191,16 @@ int arch_make_page_accessible(struct page *page);
>  #define phys_to_page(phys)	pfn_to_page(phys_to_pfn(phys))
>  #define page_to_phys(page)	pfn_to_phys(page_to_pfn(page))
>  
> -#define pfn_to_virt(pfn)	__va(pfn_to_phys(pfn))
> -#define virt_to_pfn(kaddr)	(phys_to_pfn(__pa(kaddr)))
> +static inline void *pfn_to_virt(unsigned long pfn)
> +{
> +	return __va(pfn_to_phys(pfn));
> +}
> +
> +static inline unsigned long virt_to_pfn(const void *kaddr)
> +{
> +	return phys_to_pfn(__pa(kaddr));
> +}
> +
>  #define pfn_to_kaddr(pfn)	pfn_to_virt(pfn)
>  
>  #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
> diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
> index 5300c6867d5e..f47515313226 100644
> --- a/arch/s390/mm/cmm.c
> +++ b/arch/s390/mm/cmm.c
> @@ -90,7 +90,7 @@ static long cmm_alloc_pages(long nr, long *counter,
>  			} else
>  				free_page((unsigned long) npa);
>  		}
> -		diag10_range(virt_to_pfn(addr), 1);
> +		diag10_range(virt_to_pfn((void *)addr), 1);
>  		pa->pages[pa->index++] = addr;
>  		(*counter)++;
>  		spin_unlock(&cmm_lock);
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b26649233d12..30cd6e1be10d 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -36,7 +36,7 @@ static void vmem_free_pages(unsigned long addr, int order)
>  {
>  	/* We don't expect boot memory to be removed ever. */
>  	if (!slab_is_available() ||
> -	    WARN_ON_ONCE(PageReserved(virt_to_page(addr))))
> +	    WARN_ON_ONCE(PageReserved(virt_to_page((void *)addr))))
>  		return;
>  	free_pages(addr, order);
>  }
> diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
> index 0c1df1d5f1ac..3a9cc8a4a230 100644
> --- a/drivers/s390/block/scm_blk.c
> +++ b/drivers/s390/block/scm_blk.c
> @@ -134,7 +134,7 @@ static void scm_request_done(struct scm_request *scmrq)
>  
>  		if ((msb->flags & MSB_FLAG_IDA) && aidaw &&
>  		    IS_ALIGNED(aidaw, PAGE_SIZE))
> -			mempool_free(virt_to_page(aidaw), aidaw_pool);
> +			mempool_free(virt_to_page((void *)aidaw), aidaw_pool);
>  	}
>  
>  	spin_lock_irqsave(&list_lock, flags);
> diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
> index 4cebfaaa22b4..eb0520a9d4af 100644
> --- a/drivers/s390/char/vmcp.c
> +++ b/drivers/s390/char/vmcp.c
> @@ -89,7 +89,7 @@ static void vmcp_response_free(struct vmcp_session *session)
>  	order = get_order(session->bufsize);
>  	nr_pages = ALIGN(session->bufsize, PAGE_SIZE) >> PAGE_SHIFT;
>  	if (session->cma_alloc) {
> -		page = virt_to_page((unsigned long)session->response);
> +		page = virt_to_page(session->response);
>  		cma_release(vmcp_cma, page, nr_pages);
>  		session->cma_alloc = 0;
>  	} else {
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230809-virt-to-phys-s390-2fa3d38b8855

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>

Thanks!
