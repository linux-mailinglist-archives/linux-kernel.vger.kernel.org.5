Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA08C8004D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377731AbjLAHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:39:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0C110F3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:39:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cdd13c586fso1706067b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701416363; x=1702021163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnJ59VAhsdbO2avTSjDqatw8/IsdchoyFGlEW3iQESU=;
        b=qRVomScxrXIjbm/Bb9otC5RcEmqHv/K0QizV31f/WQUwIKJrEDglK/dsDcip3aPJCT
         7eKjn31YPgAvtYsW2tDZpTaz35lj4xdYZULXG4xgfn8T/MQwvazJYRdZntsvlLMicsfA
         8YEHq/pK4XYYTlSSAJC0KRWeZxBOLj6Bs+HVgFNIiJm8705F7WYDThcAcUqZ6/6ZPsOm
         gavLipju/yRz/dGR8p/3H4ZFIJLVQLfdA9QdxqJtkVHBMCL2SyM1IiDD0uWbVR8nMx+1
         OkaOKvtD6apmyf9Bt2THR/9IzFVE8LbuVF0z47nz8n1+qZUlnxrWQUDFucN3nlSCqcGa
         l8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701416363; x=1702021163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnJ59VAhsdbO2avTSjDqatw8/IsdchoyFGlEW3iQESU=;
        b=RJ80ti93zw0s59JdGnC5g8xL4PMJcce4q3q1Fx+Eb/ZHFRooAjKHdnMPX+1UjNU04f
         tAErkgEmD/3ermf/XAzLsVuJkb0dLGAkTBy15masznHuuevc5EtEHXmX0IHfsTt32JYP
         sscZuHTuBSrsQoM0T5RzuZTn1ofFYl2Rts3h8onJPD8wBJ/7aEVanTEAZS8DFh2oepP3
         pq3tB4mxJ8Kh4A3B5nWOJZSQK92nfMe8npHEG6EbFkNNeGttahqw15kWlRpzYHTgE5E6
         lyp9vJFV4i9AAzA3WAK4YLjRRUfxXEbKjuYz/MS/eYZh+uaIenN3a/xMppl1+UVQvlnS
         ZqsA==
X-Gm-Message-State: AOJu0Yxhyp4so1DWOWWsC/iRwXoEzJjjNAybhkKI8gx/hfT9PcXrNbiN
        5+4VY0SkoYf1fHeTDOVaA2SKfQ==
X-Google-Smtp-Source: AGHT+IFG/SdDk1RTMw6HQxwG73vMuqGfe/ea0elZ20cJZXjolVwdWasUtDD4H99j3GE6bLN2p9uOkQ==
X-Received: by 2002:a05:6a00:2d83:b0:6cd:e320:b0d5 with SMTP id fb3-20020a056a002d8300b006cde320b0d5mr6073415pfb.12.1701416363180;
        Thu, 30 Nov 2023 23:39:23 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id k24-20020a63f018000000b0057825bd3448sm2411730pgh.51.2023.11.30.23.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:39:22 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:39:19 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH 19/21] binder: perform page allocation outside of locks
Message-ID: <ZWmNpxPXZSxdmDE1@google.com>
References: <20231102185934.773885-20-cmllamas@google.com>
 <20231107090843.261410-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090843.261410-1-aliceryhl@google.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:08:43AM +0000, Alice Ryhl wrote:
> I would really like a comment on each function explaining that:
> 
>  * The binder_allocate_page_range function ensures that existing pages
>    will not be reclaimed by the shrinker.
>  * The binder_get_page_range function ensures that missing pages are
>    allocated and inserted.

Ok, I think I rather go for a better naming than compensating through
comments, so I came up with the following names:
 - binder_lru_freelist_{add,del}()
 - binder_install_buffer_pages()

There will be more details in the v2. The new names give a clear
separation of the scope of these function.

> >  	mmap_write_lock(alloc->mm);
> > +	if (lru_page->page_ptr)
> > +		goto out;
> 
> Another comment that I'd like to see somewhere is one that says
> something along these lines:
> 
>     Multiple processes may call `binder_get_user_page_remote` on the
>     same page in parallel. When this happens, one of them will allocate
>     the page and insert it, and the other process will use the mmap
>     write lock to wait for the insertion to complete. This means that we
>     can't use a mmap read lock here.
> 

I've added a shorter version of this to v2, thanks.

> > +	/* mark page insertion complete and safe to acquire */
> > +	smp_store_release(&lru_page->page_ptr, page);
> > [snip]
> > +		/* check if page insertion is marked complete by release */
> > +		if (smp_load_acquire(&page->page_ptr))
> > +			continue;
> 
> We already discussed this when I asked you to make this an acquire /
> release operation so that it isn't racy, but it could use a comment
> explaining its purpose.

I've wrapped these calls into inline functions with better names in v2.
The purpose should now be evident.

> 
> >  	mmap_write_lock(alloc->mm);
> > +	if (lru_page->page_ptr)
> > +		goto out;
> > +
> >  	if (!alloc->vma) {
> >  		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> >  		ret = -ESRCH;
> >  		goto out;
> >  	}
> >  
> >  	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> >  	if (!page) {
> >  		pr_err("%d: failed to allocate page\n", alloc->pid);
> >  		ret = -ENOMEM;
> >  		goto out;
> >  	}
> 
> Maybe it would be worth to allocate the page before taking the mmap
> write lock? It has the disadvantage that you may have to immediately
> deallocate it if we trigger the `if (lru_page->page_ptr) goto out`
> branch, but that shouldn't happen that often, and it would reduce the
> amount of time we spend holding the mmap write lock.

If we sleep on alloc_page() then chances are that having other tasks
allocating more pages could create more memory pressure. In some cases
this would be unecessary (e.g. if it's the same page). I do think this
could happen often since buffer requests tend to be < PAGE_SIZE and
adjecent too. I'll look into this with more detail and send a follow up
patch if needed. Thanks!

--
Carlos Llamas


