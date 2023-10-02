Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4F7B5D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjJBW4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJBW4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:56:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65509E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:56:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so3035025e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696287398; x=1696892198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ImvWh+2gFsWJ7StqF/6mOZboIVtJA4miy8m0Nl6hNSk=;
        b=E7xu8MxVr6S0zAdLBKWVPuR1Z80KdlVTKSSx7boHTHumGSlYgpSSYsfVME1NV5F1/N
         2nY+vJ8Dvoa3Gc3h/tqMqGKfgHNzs5STjg5cHA3RLBqgBbl4MNx5Fk4rIdlmsG0BQFZP
         QRKWobjccPwEa4s2QwW8jtYn9t3txhJ6Xw4/3cl8gDiFWUGu52tNKBCVH6sFTx4c/GMt
         4RkujR2b6M6ypptxqSg6X6XS4AwLdR/+xZTI9PUGAJ5mrB5Mz1bWMzCMWuHxU3uyeOqN
         iyS8BmKDV3ksPH6wbL8UW/XrE/rV7qpXtNv2gRSsAexr9EhjFmRPZK+7dnE7LqPZgpcb
         d3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696287398; x=1696892198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImvWh+2gFsWJ7StqF/6mOZboIVtJA4miy8m0Nl6hNSk=;
        b=n1nsNw8vHwhnZQM8HXOOmUHY0VDQpp9ap5QPtnSaEw6kt7M7ht5z6jz0i2I+/Ln+fN
         syzLrwcZ5X814N9BY5+IFcpzUPteE3ZyIFFpJr1XsW0w+yGBDEbcilzrB0gSf3jUvUs0
         6l1OthGUn9OL1bCHuYC3mKud0J/oyNVaXqFxvb08EkQIU9GuslMW+MkjriC28BJ8/4DR
         1Pc1TBDYRhipQBWRecjTxh+WaRjID1+/8mESJsDzO8UMYO5CK239EieciBgD+BKsjR/D
         J6g2QHZyfnQ3ylAxZ8zqzXLVCB9v1nO44I5WPzP/K0dio+QN4CRxN3WvlGQRJgVCP+U9
         ly8g==
X-Gm-Message-State: AOJu0Yw/cE93Bmv/CXPf9WDpc2IG6KzypobJMDKmvcORB+SuLdT9Gdhs
        K1NvtnfNZpvVvJoaZELOogv4HD820po=
X-Google-Smtp-Source: AGHT+IFcnCA/4f2yRCa8G3jG6RHvM645UIAuU4RM06c4eQxvrBs6hJr6/bFhIF2Ft4Kcf/YlwHdJVQ==
X-Received: by 2002:adf:eecd:0:b0:314:a3f:9c08 with SMTP id a13-20020adfeecd000000b003140a3f9c08mr10062481wrp.39.1696287397782;
        Mon, 02 Oct 2023 15:56:37 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b0031ad2f9269dsm34796wrp.40.2023.10.02.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 15:56:37 -0700 (PDT)
Date:   Mon, 2 Oct 2023 23:56:36 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] mm/gup: adapt get_user_page_vma_remote() to never
 return NULL
Message-ID: <a1868eac-b6da-4be8-b32a-ec31ed059d55@lucifer.local>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <b57d5f6618818f2f781a664039ace025c932074c.1696174961.git.lstoakes@gmail.com>
 <f29e6a5d-39db-8f11-2182-1f13c97882c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29e6a5d-39db-8f11-2182-1f13c97882c9@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:08:41PM +0200, David Hildenbrand wrote:
> On 01.10.23 18:00, Lorenzo Stoakes wrote:
> > get_user_pages_remote() will never return 0 except in the case of
> > FOLL_NOWAIT being specified, which we explicitly disallow.
> >
> > This simplifies error handling for the caller and avoids the awkwardness of
> > dealing with both errors and failing to pin. Failing to pin here is an
> > error.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >   arch/arm64/kernel/mte.c |  4 ++--
> >   include/linux/mm.h      | 16 +++++++++++++---
> >   kernel/events/uprobes.c |  4 ++--
> >   mm/memory.c             |  3 +--
> >   4 files changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index 4edecaac8f91..8878b392df58 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -411,8 +411,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> >   		struct page *page = get_user_page_vma_remote(mm, addr,
> >   							     gup_flags, &vma);
> > -		if (IS_ERR_OR_NULL(page)) {
> > -			err = page == NULL ? -EIO : PTR_ERR(page);
> > +		if (IS_ERR(page)) {
> > +			err = PTR_ERR(page);
> >   			break;
> >   		}
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7b89f7bd420d..da9631683d38 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2425,6 +2425,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
> >   			   unsigned int gup_flags, struct page **pages,
> >   			   int *locked);
> > +/* Either retrieve a single VMA and page, or an error. */
> >   static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
> >   						    unsigned long addr,
> >   						    int gup_flags,
> > @@ -2432,12 +2433,21 @@ static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
> >   {
> >   	struct page *page;
> >   	struct vm_area_struct *vma;
> > -	int got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
> > +	int got;
> > +
> > +	if (unlikely(gup_flags & FOLL_NOWAIT))
> > +		return ERR_PTR(-EINVAL);
> > +
>
> Do we have any callers or do we want to make that official (document it) and
> use WARN_ON_ONCE() instead?

We have no callers who want to do that, will WARN_ON_ONCE() and update
comment in v2.

>
> > +	got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
> >   	if (got < 0)
> >   		return ERR_PTR(got);
> > -	if (got == 0)
> > -		return NULL;
> > +
> > +	/*
> > +	 * get_user_pages_remote() is guaranteed to not return 0 for
> > +	 * non-FOLL_NOWAIT contexts, so this should never happen.
> > +	 */
> > +	VM_WARN_ON(got == 0);
>
> You should probably just drop that. Not worth the comment + code and its
> better checked inside get_user_pages_remote().
>
> Ideally, just document that behavior for get_user_pages_remote() "Will never
> return 0 without FOLL_NOWAIT."

Well you'd need to put it at all the other callers of
__get_user_pages_locked() too :) so I think probably not worth doing that,
at least in this patch series.

In any case, we have explicitly added this check there to ensure that's not
possible so I think we're good, will just strip in v2.

>
> --
> Cheers,
>
> David / dhildenb
>
