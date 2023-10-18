Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B303C7CD6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjJRIpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjJRIo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:44:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1058AFE;
        Wed, 18 Oct 2023 01:44:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso293353366b.0;
        Wed, 18 Oct 2023 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697618694; x=1698223494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSgTjdOEv9o43R13g98wkLpNBZhKvWTIsoJaIcBH5Qg=;
        b=dUT+VUwSgajNZTNtOq55n8P0FbvbUTCnglGBanOK6I5IP00cBd1CPq9bHdy3/nWYfk
         3D63mrlvDkTXi2BTPsBenI+S+k7Cx+NFrSG7fGHZXsgsdFueRaZTnpDUd2Qe/2kaao5D
         BYdOHRIm0M1RrHIjaCp/kz80vucEeFJcuBZpotGv+Iyx36NkCsxCQCnxN9KV4miHU+vm
         6nKFDINB2ZntP9eO80e21w+RZrGQ+mahObOFdTiVzE52gOjHKS4WQH7ILR+srxjamJif
         ZsrG8MZIgSRDOzv0MHHy7QEF0Sxe82X8CW7m1fudx5bjSqQlyh08wuSKr3Fop3wRazjW
         kSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618694; x=1698223494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSgTjdOEv9o43R13g98wkLpNBZhKvWTIsoJaIcBH5Qg=;
        b=Shgw45MmT0yiYaJcoTiUl+PNTYBhCGNeLkul5TPiLfbsqNxC6UHSXqeMfYMwAFnuEc
         c7IMQAbD2qRb7lsbuY7Atn3PewU2cWG8gBi0hfT1zwWzsks/gYCexOYg2x9LG5adWyyy
         Z9RXqcK71KDD4rKFDFE3H31cFpRfhpGZrjqfKQsYJjvozvXyvebuG3u6UAs+FRCyemEF
         ACJy8ET03907fltuDKG6rH2tSZEdMg+E8bNCcI+E4kNKTJR9EMn94pzA9O26hIj3GibH
         NA2avAzc55V0ipQOMl+ni1nEl17qlMKNLjWNtgkeWOWShBkJQ/zE1jAmQdzFXtwZZyXs
         bB5Q==
X-Gm-Message-State: AOJu0YzBTdorps58Blrrcd0ojcdAA9FrrKt4i5IWfWG/YdbDv7rITZ97
        8LFRqDr7ceB78PUNRrk4bXU=
X-Google-Smtp-Source: AGHT+IHJtepEuoueIQMXTSwDOKujhTHfpU5bGtfZ1JuGIz+mNfQtsgcwCoVq7SqybQGWRk3sN1hh+g==
X-Received: by 2002:a17:907:7d9e:b0:9be:8ead:54c7 with SMTP id oz30-20020a1709077d9e00b009be8ead54c7mr3542268ejc.12.1697618694114;
        Wed, 18 Oct 2023 01:44:54 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906468700b009b957d5237asm1199002ejr.80.2023.10.18.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:44:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 10:44:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 02/10] x86/mm/cpa: Reject incorrect encryption change
 requests
Message-ID: <ZS+bA2l/yh0zZLmd@gmail.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
 <20231017202505.340906-3-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017202505.340906-3-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> Kernel memory is "encrypted" by default.  Some callers may "decrypt" it
> in order to share it with things outside the kernel like a device or an
> untrusted VMM.
> 
> There is nothing to stop set_memory_encrypted() from being passed memory
> that is already "encrypted" (aka. "private" on TDX).  In fact, some
> callers do this because ... $REASONS.  Unfortunately, part of the TDX
> decrypted=>encrypted transition is truly one way*.  It can't handle
> being asked to encrypt an already encrypted page
> 
> Allow __set_memory_enc_pgtable() to detect already-encrypted memory
> before it hits the TDX code.
> 
> * The one way part is "page acceptance"
> 
> [commit log written by Dave Hansen]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/mm/pat/set_memory.c | 41 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bda9f129835e..1238b0db3e33 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2122,6 +2122,21 @@ int set_memory_global(unsigned long addr, int numpages)
>  				    __pgprot(_PAGE_GLOBAL), 0);
>  }
>  
> +static bool kernel_vaddr_encryped(unsigned long addr, bool enc)
> +{
> +	unsigned int level;
> +	pte_t *pte;
> +
> +	pte = lookup_address(addr, &level);
> +	if (!pte)
> +		return false;
> +
> +	if (enc)
> +		return pte_val(*pte) == cc_mkenc(pte_val(*pte));
> +
> +	return pte_val(*pte) == cc_mkdec(pte_val(*pte));
> +}
> +
>  /*
>   * __set_memory_enc_pgtable() is used for the hypervisors that get
>   * informed about "encryption" status via page tables.
> @@ -2130,7 +2145,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  {
>  	pgprot_t empty = __pgprot(0);
>  	struct cpa_data cpa;
> -	int ret;
> +	int ret, numpages_in_state = 0;
>  
>  	/* Should not be working on unaligned addresses */
>  	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
> @@ -2143,6 +2158,30 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
>  	cpa.pgd = init_mm.pgd;
>  
> +	/*
> +	 * If any page is already in the right state, bail with an error
> +	 * because the code doesn't handled it. This is likely because

Grammar mistake here.

> +	 * something has gone wrong and isn't worth optimizing for.
> +	 *
> +	 * If all the memory pages are already in the desired state return
> +	 * success.

Missing comma.

> +	 *
> +	 * kernel_vaddr_encryped() does not synchronize against huge page
> +	 * splits so take pgd_lock. A caller doing strange things could

Missing comma.

Thanks,

	Ingo
