Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10B770B34
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHDVqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHDVq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:46:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D718B;
        Fri,  4 Aug 2023 14:46:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so7877025e9.3;
        Fri, 04 Aug 2023 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691185585; x=1691790385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/pOSfgbyVT5LQxnNymgKpK05ihGgzeqo1fmPwKo4cM=;
        b=a4GiJzdqv+qk8GtXsrJmdKutL523iO/jKkD1Gd/zbu6JYYdPAn4zLqpp4/JPAO1ysS
         wtqxE8CsmEcwfV9Ove0bJCJnmMGGV6Kn/MjWnLXRYvp3B3QYpGfNBQKNrIkszewrCKHx
         c/cotekgWT4fnr7Kx08vJnKsw3SLeSGW6rFs0yWNmZgwOJhFrKOxr5Cp4ZUvkQBCEA+4
         NWcuECwaIC2nDyL6LfgMHhR6CzMuWN+vOZe3VJTKm+90ZaWdhiw4pbDdzrbAsEEKyzHz
         mpayLVtTYyHnz4GQTcbqJuZQssyMVFYpcI4D6yl+jo881L1rIzs/P8T8EURCo9UAnNcJ
         3QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691185585; x=1691790385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/pOSfgbyVT5LQxnNymgKpK05ihGgzeqo1fmPwKo4cM=;
        b=lHoFcwYNyRKDOvjECnuAek2VoJgd7N+gl7ri7dNPtAbGEO7GwxG/R1GjFEryPf3f2m
         km/+ZHT4Ou5DSPyG6GNaTfqM4WAb2atCgScu40jGizUeGVWEAsW7kk1WxIs703gFHMFA
         g6NfAPNGngeAEh0NVPfjxXf8d3tfteQcST7YjzBaM57VcnBSI1KTSyfacKLNjFZ0Agb1
         t4cyCkqa/Oml1GO0mkvwZjDBWCwdjLYxooK2yqaC0t9cFFr0txeVI5N88u5NVsQaq/Ag
         P07kfjg8EW8qHLRSUiosOzF/fpq+r36Skf37oxgWh84NVvROfnybC9JZ5Qx1Wtwfp83a
         FmQg==
X-Gm-Message-State: AOJu0Yw95iZ3tGuF+pRfTQKo9O6ldN2V/6WBSC0aLxVqgh/uKpRNXRva
        VD1Dmi1KCFZZ7yjIyDVjpHY=
X-Google-Smtp-Source: AGHT+IGOtBUSiK39LU5+0tpNJevAeU4Xfb74Y4DRTOPaM0nN2Uvb1A/IoQQ+f7RQvAmDLiwJ9gr3Zg==
X-Received: by 2002:a1c:f603:0:b0:3fe:21b9:806 with SMTP id w3-20020a1cf603000000b003fe21b90806mr2415552wmc.0.1691185584689;
        Fri, 04 Aug 2023 14:46:24 -0700 (PDT)
Received: from f (cst-prg-21-219.cust.vodafone.cz. [46.135.21.219])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d5483000000b0030ae53550f5sm3423406wrv.51.2023.08.04.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:46:24 -0700 (PDT)
Date:   Fri, 4 Aug 2023 23:46:20 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
Message-ID: <20230804214620.btgwhsszsd7rh6nf@f>
References: <20230708191212.4147700-1-surenb@google.com>
 <20230708191212.4147700-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230708191212.4147700-3-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 12:12:12PM -0700, Suren Baghdasaryan wrote:
[..]
> Lock VMAs of the parent process when forking a child, which prevents
> concurrent page faults during fork operation and avoids this issue.
> This fix can potentially regress some fork-heavy workloads. Kernel build
> time did not show noticeable regression on a 56-core machine while a
> stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> shows ~5% regression. If such fork time regression is unacceptable,
> disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> optimizations are possible if this regression proves to be problematic.
> 
> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b85814e614a5..d2e12b6d2b18 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	for_each_vma(old_vmi, mpnt) {
>  		struct file *file;
>  
> +		vma_start_write(mpnt);
>  		if (mpnt->vm_flags & VM_DONTCOPY) {
>  			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>  			continue;
> 

I don't see it mentioned in the discussion, so at a risk of ruffling
feathers or looking really bad I'm going to ask: is the locking of any
use if the forking process is single-threaded? The singular thread in
this case is occupied executing this very code, so it can't do any op
in parallel. Is there anyone else who could trigger a page fault? Are
these shared with other processes? Cursory reading suggests a private
copy is made here, so my guess is no. But then again, I landed here
freshly from the interwebz.

Or in short: if nobody can mess up the state if the forking process is
single-threaded, why not check for mm_users or whatever other indicator
to elide the slowdown for the (arguably) most common case?

If the state can be messed up anyway, that's a shame, but short
explanation how would be welcome.

to illustrate (totally untested):
diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..aac6b08a0b21 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -652,6 +652,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
        LIST_HEAD(uf);
        VMA_ITERATOR(old_vmi, oldmm, 0);
        VMA_ITERATOR(vmi, mm, 0);
+       bool singlethread = READ_ONCE(oldmm->mm_users) == 1;

        uprobe_start_dup_mmap();
        if (mmap_write_lock_killable(oldmm)) {
@@ -686,7 +687,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
        for_each_vma(old_vmi, mpnt) {
                struct file *file;

-               vma_start_write(mpnt);
+               if (!singelthreaded)
+                       vma_start_write(mpnt);
                if (mpnt->vm_flags & VM_DONTCOPY) {
                        vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
                        continue;
