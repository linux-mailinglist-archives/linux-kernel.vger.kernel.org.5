Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5C6808DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjLGQcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjLGQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:32:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73039132
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:32:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d06d42a58aso9536485ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701966759; x=1702571559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s/G2fCaPsfjUltC6wP5KXnRvEhfZWy1kUDC1w9CkeU=;
        b=tiK93JOw6EPMlDBLuaJ/56pp8ogzhRE44uzkXTpapanoNVxCbmfA3JCwlBCothnklj
         D0CDgbkSyMrxwut27IKSkZ+JNz83pnmsUSv30MWZi7FUZhEDbvgDMtGSNkEoSR2bEFDt
         AdBM7NtZzQ3PIyE30dZ3dAGDiwzewJCTSr59ov/i+zs8tU6DPytidoA9LAeJu8aFmaZo
         KWVMnub4fVgmkx/91jyqHqM+0rbUHnfOfg2ZQEpNVwvDgR3NyaTEkAShO5jJKa6w/3Es
         w1R9x+VAznk4DHhunBmSXPX5ucXq8PXkBVy7MERjHnczqfgFaHUz2cmOV0BZ8xCXm3MQ
         w8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966759; x=1702571559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s/G2fCaPsfjUltC6wP5KXnRvEhfZWy1kUDC1w9CkeU=;
        b=IreN8b7D5Qfit5mrwq6GGgcIqpmOO5pnzE6pPhrRQqSv6w7Ty9Rsc03Rb2oXaNkSFW
         PHQz3274QNUbpHoPxHCrtkSQm13IsKhdRT3iNqWNqLQOLvR+8uXQgDPfqigj1HZ7F3s1
         oqdjcgrSo0BxdWpIh3il7feRbvj0eVFp4ubvhE/vXnxuOzzzlJk3UZGKDLCoygYCHzq9
         9dGsXuliAQ8mi/Yv0HmfMMJ6vA/4huYz2zz735DWf4UKPfecutrCWOByCMDzuPF6hnCk
         4snh+t/dLSm4z+1zqYwCeNbjD0iHuy+j7Ir0/120LbY6wmDQV16Ub2zP2jHI6MuULE5R
         PyNg==
X-Gm-Message-State: AOJu0YwXOAXtUQCV7PKW9gViNSwqz+jm1Un2blK80DK9Yudpx0NWXuoW
        mbrL76PPm3eHqygIMQvGGY29dA==
X-Google-Smtp-Source: AGHT+IF7Xpf8qGhXSViJn/hwJ0E80pM/or7yhBmz9pZajunl52yozMy7wL1M2cV5+TGdlip1I553Fg==
X-Received: by 2002:a17:902:c411:b0:1d0:8e61:1020 with SMTP id k17-20020a170902c41100b001d08e611020mr3546038plk.89.1701966758757;
        Thu, 07 Dec 2023 08:32:38 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001cc3a6813f8sm6281plj.154.2023.12.07.08.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:32:38 -0800 (PST)
Date:   Thu, 7 Dec 2023 16:32:34 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nhat Pham <nphamcs@gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the mm tree
Message-ID: <ZXHzooF07LfQQYiE@google.com>
References: <20231207134213.25631ae9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207134213.25631ae9@canb.auug.org.au>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:42:13PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/android/binder_alloc.c
> 
> between commit:
> 
>   8b59d7857c30 ("list_lru: allow explicit memcg and NUMA node selection")
> 
> from the mm tree and commits:
> 
>   ea9cdbf0c727 ("binder: rename lru shrinker utilities")
>   ea2735ce19c1 ("binder: refactor page range allocation")
> (and maybe others)
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell

Oh I wasn't aware of this patch. Thanks for fixing it Stephen!

I checked the diff against the char-misc tree and it looks correct. It's
a much much easier read too. I'll post it below if anyone is interested.

--
Carlos Llamas

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a4a4dc87ba53aa..ea5e1ba2d0d77f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -210,7 +210,7 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,

 		trace_binder_free_lru_start(alloc, index);

-		ret = list_lru_add(&binder_freelist, &page->lru);
+		ret = list_lru_add_obj(&binder_freelist, &page->lru);
 		WARN_ON(!ret);

 		trace_binder_free_lru_end(alloc, index);
@@ -317,7 +317,7 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		if (page->page_ptr) {
 			trace_binder_alloc_lru_start(alloc, index);

-			on_lru = list_lru_del(&binder_freelist, &page->lru);
+			on_lru = list_lru_del_obj(&binder_freelist, &page->lru);
 			WARN_ON(!on_lru);

 			trace_binder_alloc_lru_end(alloc, index);
@@ -931,7 +931,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			if (!alloc->pages[i].page_ptr)
 				continue;

-			on_lru = list_lru_del(&binder_freelist,
+			on_lru = list_lru_del_obj(&binder_freelist,
 					      &alloc->pages[i].lru);
 			page_addr = alloc->buffer + i * PAGE_SIZE;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
@@ -1307,4 +1307,3 @@ int binder_alloc_copy_from_buffer(struct binder_alloc *alloc,
 	return binder_alloc_do_buffer_copy(alloc, false, buffer, buffer_offset,
 					   dest, bytes);
 }
-
