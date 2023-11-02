Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693BF7DFB40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377399AbjKBUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjKBUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:09:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE55138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:09:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so1439631b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698955789; x=1699560589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frbIFMcPahMuJnundehXBvpEDhaieyav7O9JILL7nRI=;
        b=o+w8dFD+a8U1kV186JoDqputlzkTm/OvRBpP/lIZBYzRoNz9Yo1rzWbm9Tcarii0Qn
         VdS3IgcEv/qQ2EELTB68pmlZ3cbP77xmAJapEoyREioZsb3JgRuf4FB+/tGSYlzG04Gj
         TtwwSjtJ0MYEnCii0ZJT1lNrPyEXHGFEhqEeEeG3Cj5ntdEed+Ew+2OGfh64nubWPxcO
         gZ68dXMk7JQDQIBgMTrZ+RWt58I+EUuouSWhxB9sl1kNztplJwFkt3yWqL76pLxNXHj+
         Tq2y5/7WLICf/heTqwfbUoXteYxUraBku/SKjZufCOf18h/lNPj6AS39wcFGsUDpchXD
         rPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698955789; x=1699560589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frbIFMcPahMuJnundehXBvpEDhaieyav7O9JILL7nRI=;
        b=ImtZNftLNfbeNsh6Ck7IUnbX+AJFQAwKOpi+Nf0YhxBz7HNa3RMjmlzZtuPyt3uToQ
         BXcjPaT9AK/qA/PWpZQ4M8ZdMcfFN8qgQq8LviO+W6wHxsyvZ5L2q8mn8+vEhSVdud4M
         FiIODFzC7EpLYhPpWVSsgmJJRTlSyIcG8MLFqVaHhwJZN+ZRZwrc+I0tR4fRGg37tCVc
         tJhT1MLy8vLDSsr0UdhaEvuMX8t+tXGEeKUDmto+JPg9RqoAO326v/SRN2ieTOMJNacW
         vujlBcpAGMVuwYtS8Z/rc99zv0Z+gVKvygqCFwoCxA09oQT3DZUQZ/jj4eoYLPF4vANd
         6LCg==
X-Gm-Message-State: AOJu0Yyq9cJWmLf4b1YT30YSeU1IAZrAb92eNkHHGuC7W6Rv7vxzNJKP
        XFUEfa+ZYM7ID3C3ghHtjkpexg==
X-Google-Smtp-Source: AGHT+IGKB3QRmtw+9Vg4zgB8QhI/Yswi9pUMHSf/qthfEpCA3X6S+uv0RWgRtFPw+Pg96oQkxFzp9w==
X-Received: by 2002:a05:6a00:2d09:b0:6bc:f819:fcf0 with SMTP id fa9-20020a056a002d0900b006bcf819fcf0mr22638289pfb.1.1698955789068;
        Thu, 02 Nov 2023 13:09:49 -0700 (PDT)
Received: from google.com (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with ESMTPSA id u8-20020a627908000000b006baa1cf561dsm162301pfc.0.2023.11.02.13.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:09:47 -0700 (PDT)
Date:   Thu, 2 Nov 2023 20:09:42 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, stable@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 02/21] binder: fix use-after-free in shinker's callback
Message-ID: <ZUQCBnPYf_fzlWnD@google.com>
References: <20231102185934.773885-1-cmllamas@google.com>
 <20231102185934.773885-3-cmllamas@google.com>
 <20231102192051.innr2tbugspgmotw@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102192051.innr2tbugspgmotw@revolver>
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

On Thu, Nov 02, 2023 at 03:20:51PM -0400, Liam R. Howlett wrote:
> * Carlos Llamas <cmllamas@google.com> [231102 15:00]:
> > The mmap read lock is used during the shrinker's callback, which means
> > that using alloc->vma pointer isn't safe as it can race with munmap().
> 
> I think you know my feelings about the safety of that pointer from
> previous discussions.
> 

Yeah. The work here is not done. We actually already store the vm_start
address in alloc->buffer, so in theory we don't even need to swap the
alloc->vma pointer we could just drop it. So, I agree with you.

I want to include this saftey "fix" along with some other work that uses
the page fault handler and get_user_pages_remote(). I've tried a quick
prototype of this and it works fine.

> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > index e3db8297095a..c4d60d81221b 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -1005,7 +1005,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> >  		goto err_mmget;
> >  	if (!mmap_read_trylock(mm))
> >  		goto err_mmap_read_lock_failed;
> > -	vma = binder_alloc_get_vma(alloc);
> > +	vma = vma_lookup(mm, page_addr);
> > +	if (vma && vma != binder_alloc_get_vma(alloc))
> > +		goto err_invalid_vma;
> 
> Doesn't this need to be:
> if (!vma || vma != binder_alloc_get_vma(alloc))
> 
> This way, we catch a different vma and a NULL vma.
> 
> Or even, just:
> if (vma != binder_alloc_get_vma(alloc))
> 
> if the alloc vma cannot be NULL?
> 

If the vma_lookup() is NULL then we still need to isolate and free the
given binder page and we obviously skip the zap() in this case.

However, if we receive a random unexpected vma because of a corrupted
address or similar, then the whole process is skipped.

Thus, why we use the check above.

--
Carlos Llamas
