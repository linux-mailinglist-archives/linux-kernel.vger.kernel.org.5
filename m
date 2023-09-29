Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1B57B3CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjI2WpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjI2WpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:45:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5D3193;
        Fri, 29 Sep 2023 15:45:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so13847246f8f.2;
        Fri, 29 Sep 2023 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696027504; x=1696632304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3AZdgAbXxIxX67W7zXRgmBiBYYg4CVuMev8xbcA4Ww=;
        b=SgVqgjgmG3hqDEMtTzJiML0bjPf1hN10cI3cOgFmpnxK4DppOSxELsmtEOf5Nwd221
         SkCDTLL8TK65yQo85g0xhTWM2kRZ/orjOWXAT+1E//qOuCAPi0O+w9xkT8l8UCYs2W5Q
         V6kY2og/6H93TBaqE5k5WWkdtL4IrE1cUsXnl3WWV41FcxluZs5zMKofNkR6Jp3U56zO
         8i3PHCVhX1RG23KaBOtO1HfkoFWjeNF7oYbo2wN3fd7XSp1N4Vt88gnZUp5kqNeM8izB
         DsqxK0k/WlD/8dQ6cERxYNe9IwdSFWmRQZGTskyCXg6bV2Nz4PCvcFgnAaAi7deYU1io
         QpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696027504; x=1696632304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3AZdgAbXxIxX67W7zXRgmBiBYYg4CVuMev8xbcA4Ww=;
        b=MX15uvAAHNCLp1LISJsmymMiSLW3jB1nX6+yKRH2+Hxbmue0TVxpifhevCCgl+WhC5
         VgPA6EPzucrTg1Uj1lQkQ+iQVw6SXQ1V1+YzHrX5uEqf/DZJOAoPPKYYbhGu14ZsOz2W
         YjFBG3sTCH6lwZWJcN40vKR4Q3mWpQc7hrTBEatXazcntYZ4lkVzE5TBTp7dFmHzjdEB
         mOI2olLB66xBlEj0bZGj3pPMhevQ21cVgQ0SoetpxGAsFn2ZXoFTie8ENoJS6uNZKIMo
         q+F2A2T+hjHLC0V7X8OF5clj11NgxAigPBL9vlwrzK0VkYzan6tePdZXKOY2yamfKyD4
         5L6g==
X-Gm-Message-State: AOJu0YyX8nAMp6La5WorxuL4epxN4S2U6UxkVh8CdUPCDrElLmlU5hZM
        r8V5P2zSS8OaZuiWWSMl601dfnN2K1Q=
X-Google-Smtp-Source: AGHT+IE7CcZqMJ7N9YJVqzwtt5ORehS/NU44ZxNTap0IgZfOtNwcEvBT3dyN1LAr+OdK1fJUX8oVOw==
X-Received: by 2002:adf:db48:0:b0:319:6327:6adb with SMTP id f8-20020adfdb48000000b0031963276adbmr4718831wrj.70.1696027503939;
        Fri, 29 Sep 2023 15:45:03 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4d0f000000b00324ae863ac1sm3544532wrt.35.2023.09.29.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 15:45:02 -0700 (PDT)
Date:   Fri, 29 Sep 2023 23:45:02 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yikebaer Aizezi <yikebaer61@gmail.com>
Subject: Re: [PATCH] mm/mempolicy: Fix set_mempolicy_home_node() previous VMA
 pointer
Message-ID: <b88ef554-ea55-48c1-a42a-564faf8a16e6@lucifer.local>
References: <20230928172432.2246534-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928172432.2246534-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 01:24:32PM -0400, Liam R. Howlett wrote:
> The two users of mbind_range() are expecting that mbind_range() will
> update the pointer to the previous VMA, or return an error.  However,
> set_mempolicy_home_node() does not call mbind_range() if there is no VMA
> policy.  The fix is to update the pointer to the previous VMA prior to
> continuing iterating the VMAs when there is no policy.
>
> Users may experience a WARN_ON() during VMA policy updates when updating
> a range of VMAs on the home node.
>
> Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
> Link: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
> Fixes: f4e9e0e69468 ("mm/mempolicy: fix use-after-free of VMA iterator")
> Cc: stable@vger.kernel.org
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mempolicy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
>
> For completeness, here is the syzbot reproducer so that it is available
> from the mailing list:
>
> #define _GNU_SOURCE
>
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> #ifndef __NR_set_mempolicy_home_node
> #define __NR_set_mempolicy_home_node 450
> #endif
>
> int main(void)
> {
>                 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>         syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>         syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>
> *(uint64_t*)0x20000000 = 0xffffffffffffff81;
>         syscall(__NR_mbind, /*addr=*/0x20ffa000ul, /*len=*/0x4000ul, /*mode=*/2ul, /*nodemask=*/0x20000000ul, /*maxnode=*/7ul, /*flags=*/0ul);
>         syscall(__NR_mbind, /*addr=*/0x20ff9000ul, /*len=*/0x3000ul, /*mode=*/0ul, /*nodemask=*/0ul, /*maxnode=*/0ul, /*flags=*/0ul);
>         syscall(__NR_set_mempolicy_home_node, /*addr=*/0x20ffa000ul, /*len=*/0x4000ul, /*home_node=*/0ul, /*flags=*/0ul);
>         return 0;
> }
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..717d93c175f2 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1544,8 +1544,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
>  		 * the home node for vmas we already updated before.
>  		 */
>  		old = vma_policy(vma);
> -		if (!old)
> +		if (!old) {
> +			prev = vma;
>  			continue;
> +		}
>  		if (old->mode != MPOL_BIND && old->mode != MPOL_PREFERRED_MANY) {
>  			err = -EOPNOTSUPP;
>  			break;
> --
> 2.40.1
>

It feels a bit like the prev assignment is in the wrong place, however
looking at mbind_range() it's because of the possible merge that this is so
I guess. Just a pity the two bits get separated, as obviously it is at this
upper loop where the assignment of prev is most meaningful.

But definitely looks correct,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
