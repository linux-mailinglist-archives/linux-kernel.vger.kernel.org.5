Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151F6812E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443935AbjLNLan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443953AbjLNLal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:30:41 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950FBB7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:30:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33646500f1aso573870f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702553443; x=1703158243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGyR5IM589pNwJshXT2QlygyEFYgsSWq45p1PM9PHw8=;
        b=myew4EOAGPfRQ5Y9S5VfBGcv+xp3xeY/XhhRzuLsaRxml0Ml0NHh4lFrQ4/yE+0pmj
         UfLO0mT2/HIO5aaa+LBsqnESbo+aIEAIXBlMnSE8ZmoxVHLqirbQBK7Kr2+wjK+AttWh
         o1libXfXTi3pTkZQYASmxd6I9HA/zhziJOFZ/zK+tjJwnk+w6aalXgGpeYNItnwlDaNj
         V+776M3/23z9iPA41mW2/yvzhixS3WfooBTLXGxGy5qVPpoLDVCEyuBecgELW718V/Zl
         nlWHNDlDYe5erOlS8K7Qq+Axgd7Au0UUVm2m9EB0PtNQkuDOHmUxCF4QMsnWVp5VzeB7
         Nhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702553443; x=1703158243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGyR5IM589pNwJshXT2QlygyEFYgsSWq45p1PM9PHw8=;
        b=WWAnLM4AVWN42U5AUyLQDdBrjjUXIO/Rozmlc3oq5jDXzU+ZFAiaEmxoBghB3j9p8M
         6R2DPPZCHfKJ/iLcTuHCGIR3BU9ncqtTrfXmVXgP0tS5B4pYbfCEhvgwuoZDD6EQm5cR
         lOZ+w/mqMTGSNC91y3cfEYURF2stMLpemsTzpXEOp2ywZSmz3LpD+Tz2me+rfhEZ9W6u
         +ezAZTuw/e8w/PPORkYAJgSIy1SCyHTvXRZjaNlvvznZPWFNztC8KieBunizW+0TK06M
         edew+zSguLpqL0xgsirBi8SkGsLc9kGdIm0L3iEHY0cLEDG2mj3P2mcjXMixHuspWNIM
         Eu4g==
X-Gm-Message-State: AOJu0Yxto+i5bZaC3eog7py9zW6qHvD9WL7kZxCpi/yBf0kd66LE9t6w
        77zphCVbrlTucu9abxji4FEXPQ==
X-Google-Smtp-Source: AGHT+IGlunMuhMf+wJNo9In2hayzFruWkeU7cG8jgxWDtUBf1ufk3oh/44gl3xD2yS1qQogfw0HhwQ==
X-Received: by 2002:a05:6000:11c4:b0:333:2fd2:3be2 with SMTP id i4-20020a05600011c400b003332fd23be2mr3801476wrx.155.1702553443052;
        Thu, 14 Dec 2023 03:30:43 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000100400b00333371c7382sm15875496wrx.72.2023.12.14.03.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:30:42 -0800 (PST)
Date:   Thu, 14 Dec 2023 14:30:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Message-ID: <e2da3c78-85f7-4516-bbab-97fac9629dcc@suswa.mountain>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-5-ryan.roberts@arm.com>
 <cb1fe352-ca47-4c3b-ab51-ecf51a83ce50@moroto.mountain>
 <43a8bfff-f939-4f2d-a8cd-97306d5e44c9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43a8bfff-f939-4f2d-a8cd-97306d5e44c9@arm.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:54:19AM +0000, Ryan Roberts wrote:
> On 13/12/2023 07:21, Dan Carpenter wrote:
> > On Thu, Dec 07, 2023 at 04:12:05PM +0000, Ryan Roberts wrote:
> >> @@ -4176,10 +4260,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >>  	/* Allocate our own private page. */
> >>  	if (unlikely(anon_vma_prepare(vma)))
> >>  		goto oom;
> >> -	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> >> +	folio = alloc_anon_folio(vmf);
> >> +	if (IS_ERR(folio))
> >> +		return 0;
> >>  	if (!folio)
> >>  		goto oom;
> > 
> > Returning zero is weird.  I think it should be a vm_fault_t code.
> 
> It's the same pattern that the existing code a little further down this function
> already implements:
> 
> 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
> 	if (!vmf->pte)
> 		goto release;
> 
> If we fail to map/lock the pte (due to a race), then we return 0 to allow user
> space to rerun the faulting instruction and cause the fault to happen again. The
> above code ends up calling "return ret;" and ret is 0.
> 

Ah, okay.  Thanks!

> > 
> > This mixing of error pointers and NULL is going to cause problems.
> > Normally when we have a mix of error pointers and NULL then the NULL is
> > not an error but instead means that the feature has been deliberately
> > turned off.  I'm unable to figure out what the meaning is here.
> 
> There are 3 conditions that the function can return:
> 
>  - folio successfully allocated
>  - folio failed to be allocated due to OOM
>  - fault needs to be tried again due to losing race
> 
> Previously only the first 2 conditions were possible and they were indicated by
> NULL/not-NULL. The new 3rd condition is only possible when THP is compile-time
> enabled. So it keeps the logic simpler to keep the NULL/not-NULL distinction for
> the first 2, and use the error code for the final one.
> 
> There are IS_ERR() and IS_ERR_OR_NULL() variants so I assume a pattern where you
> can have pointer, error or NULL is somewhat common already?

People are confused by this a lot so I have written a blog about it:

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

The IS_ERR_OR_NULL() function should be used like this:

int blink_leds()
{
	led = get_leds();
	if (IS_ERR_OR_NULL(led))
		return PTR_ERR(led);  <-- NULL means zero/success
	return led->blink();
}

In the case of alloc_anon_folio(), I would be tempted to create a
wrapper around it where NULL becomes ERR_PTR(-ENOMEM).  But this is
obviously fast path code and I haven't benchmarked it.

Adding a comment is the other option.

regards,
dan carpenter

