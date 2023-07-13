Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488B3752641
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjGMPKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjGMPKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:10:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68719B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:10:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so7571965e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689261014; x=1691853014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbh8/8YR2OYwgBsozxXjeHWBOMoncqGng7RkrjUyFwA=;
        b=mn1AOQABIhLQtgpaF09UwJ9IIzomZ6nEQcprYyn2FRSn4Y90dqBbK6CJg8iWhXUY49
         fpxZFnAS90xWFVmKfTfkCItAJHos9W59gwcdDVqhsPuTJXrekbubqjym0xZFetMFRRct
         CZ5ySetSCy3vTd9EvK1enjtjdsraEoqAbP3FSY7h9XBHXHgHI7ta9ah5Xc5tvmkOBZZP
         0Kk/jxK2PRHtNDyXojHbclN64FXzJ4gW4TWpXrCl/SWV3a879SatabcK5DjwX4NMCm1X
         LZjpAE17IWkIeKlBS76Z10TVZ6zU51CKeL9ujqSpPxRTl+f3bs16L3CNDPcd+HxY1Tlb
         jBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261014; x=1691853014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbh8/8YR2OYwgBsozxXjeHWBOMoncqGng7RkrjUyFwA=;
        b=OuZMnCvcLDEPQ6V6zU/IG0EmWVCM/xR0ADS4dRccMVNue31Bk9ee9axtnGYGePV6hM
         GpIOu+xovszPwY96KNUeUnQ7DvwXfB6pbPX54dH5OAHlCMi+uByjvVz3u6UsMCOcMbDu
         Aa2Ak00wDmyWtv15PQTP1sS/xIwisirBAli5Dw3MWu/gZCUxu+b+rtptz6rLduzjzmzU
         p8VYvsvZUOhuuKGUhVR1oc/OrYGgFCpo0xauoz8ZwNDNbbdqlfEko5uDbx9NvUFUxaN4
         mJOPy9DLbrN7XwAVioCnlbJGHRTA//wNyuf73rbzT49W4mxRwciURcwIvzXG3mP7MUln
         8iow==
X-Gm-Message-State: ABy/qLbeC/2NHhYxAEGDjBq0ys/YxaxyGDuzOCneu+uoJm5p7MAsAPVk
        WAmciV3+NuBF7oOXofc46/4ymw==
X-Google-Smtp-Source: APBJJlGyuz/1zMyMkHxcVsDhm5iLo+cD8ocAAMhXeNuD+fErHxdiD+gYMz9JijcyDuyzeV/gMAbBeQ==
X-Received: by 2002:a05:600c:acd:b0:3fc:b86:d3fa with SMTP id c13-20020a05600c0acd00b003fc0b86d3famr1679806wmr.1.1689261014235;
        Thu, 13 Jul 2023 08:10:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003fbe36a4ce6sm18534778wmc.10.2023.07.13.08.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:10:12 -0700 (PDT)
Date:   Thu, 13 Jul 2023 18:10:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     linke li <lilinke99@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Linke Li <lilinke99@foxmail.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in
 hugetlbfs_file_mmap()
Message-ID: <6c3191e1-23fd-4f9e-9b5e-321c51599897@moroto.mountain>
References: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
 <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com>
 <20230712235813.GE6354@monkey>
 <CAKdjhyD4RVHFVLrcfcuEnvwrjjxAk_GL=kjcm1iw3WTrmmFb9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdjhyD4RVHFVLrcfcuEnvwrjjxAk_GL=kjcm1iw3WTrmmFb9Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:57:00PM +0800, linke li wrote:
> > However, if this is a real issue it would make more
> > sense to look for and change all such checks rather than one single occurrence.
> 
> Hi, Mike. I have checked the example code you provided, and the
> difference between
> those codes and the patched code is that those checks are checks for
> unsigned integer
>  overflow, which is well-defined. Only undefined behavior poses a
> security risk. So they
>  don't need any modifications. I have only found one occurrence of
> signed number
> overflow so far.

I used to have a similar check to that but I eventually deleted it
because I decided that the -fno-strict-overflow option works.  It didn't
produce a lot of warnings.

Historically we have done a bad job at open coding integer overflow
checks.  Some that I wrote turned out to be incorrect.  And even when
I write them correctly a couple times people have "fixed" them even
harder without CCing me or asking me why I wrote them the way I did.

What about using the check_add_overflow() macro?

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7b17ccfa039d..c512165736e0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -155,9 +155,8 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
-	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	/* check for overflow */
-	if (len < vma_len)
+	if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT,
+			       &len))
 		return -EINVAL;
 
 	inode_lock(inode);

