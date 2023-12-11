Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A243880C346
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjLKIbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjLKIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:31:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00671ED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:31:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33338c47134so3976575f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702283496; x=1702888296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9TssOoYj5sq85cjGlO/OWfUu7/5yk2nPtfgDzXrsu4=;
        b=b/exAFwl1xEjLGjHrsK8kWRYbVdGJl+RKzc/k56POwnbn40kdYE38lU2eVnAQSzZNv
         1Pg0QzFqzdtwVLdK/6IulXVmaiqkjcKMQgaMTpNe7aDunluqVu//50joowZh1OZR8bur
         XQsh4J30Q5atWBeORwJJn/EoQ51RCU+y1ocUQp60uoeKKV3vK7ZnV0AY8/0s6Mp7bxLr
         8qKN5GiD+C73xyRGv5fOtjUgENuYY9zMEoYKsbtBtDhxwcdAipNaFm2HBxRHY6naHyu3
         1vifF9nfjr0/fXS3sKHnp7CpyLwmog6xebg1bjmFkqx6mnDL/jpPKhDyv57ANU9nvi0d
         2Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702283496; x=1702888296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9TssOoYj5sq85cjGlO/OWfUu7/5yk2nPtfgDzXrsu4=;
        b=q58u7NnuU5nw3IqJEQNrp4z17UCqx4Onxi3e14TuA+QzqsJb1e0ZzJ+I6998txJ/qy
         Bbhpi8cctvvVhcrj/NAQqc/VfKqskAtcql7fWI9IXdJaJ5HRXf2oTlYzQK5p9Kybk8Ql
         71uqRf6+R+SPwsHP7NF9q8hkHbShZvSB+1RIAmj+z7xToVgnhYgFz7tdli80haa+45N7
         eAzc9RlsP4pbBCQEOFd+aYlxGr3Ww2cRdL7sJ4sBgTZlKoSbh3qe/tl36lQ/ndqtdw3i
         gP1lunqepQ622pSt74uUBUQbshhIOOlooOZWDK/reNcN35Ny+3YC3d57tOqdkgEldKQ0
         9gfw==
X-Gm-Message-State: AOJu0Yy6oAXOE1vDSxjiQ/iWlYYlrzKMRLKFgoST3tHj06XVNtfxb2JZ
        opjv6eqllnDwyLO8+sOq3d616EKoOVwz8M8629p84Q==
X-Google-Smtp-Source: AGHT+IHw6KbgF5ZdUqFJP2PUqyg2V4aLIlCnsgX6uYnrOdbdZVebUYLmRkdZ3Ba2r7B6LHXVcwP2IURHq+gQ2dAl7eo=
X-Received: by 2002:adf:e781:0:b0:333:2fd2:6f7a with SMTP id
 n1-20020adfe781000000b003332fd26f7amr2089438wrm.132.1702283496334; Mon, 11
 Dec 2023 00:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20231211171406.71fdc29b@canb.auug.org.au>
In-Reply-To: <20231211171406.71fdc29b@canb.auug.org.au>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 11 Dec 2023 09:31:25 +0100
Message-ID: <CAHVXubio372X_xXiWBMYk5=C7K49Wv6uki-uqWk1eyH-YuGGnA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the percpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Dec 11, 2023 at 7:14=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the percpu tree, today's linux-next build (sparc64
> defconfig) failed like this:
>
> mm/percpu.c: In function 'pcpu_page_first_chunk':
> mm/percpu.c:3336:17: error: implicit declaration of function 'flush_cache=
_vmap_early'; did you mean 'flush_cache_vmap'? [-Werror=3Dimplicit-function=
-declaration]
>  3336 |                 flush_cache_vmap_early(unit_addr, unit_addr + ai-=
>unit_size);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~
>       |                 flush_cache_vmap
> cc1: some warnings being treated as errors
>
> Caused by commit
>
>   a95c15a43f4a ("mm: Introduce flush_cache_vmap_early() and its riscv imp=
lementation")
>
> I have applied the following fix patch for today.  Are there other
> archs that don't use asm-generic/cacheflush.h?

It seems like most archs do not include this file, I should have
checked. As I'm a bit scared of the possible side-effects of including
asm-generic/cacheflush.h, I'll define flush_cache_vmap_early() on all
archs that do define flush_cache_vmap().

Stephen, do you want a patch fix? Or do you want me to send a new
version of the current patches so that you can drop them for now?

Sorry for the oversight,

Thanks,

Alex

>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 11 Dec 2023 16:57:00 +1100
> Subject: [PATCH] fix up for "mm: Introduce flush_cache_vmap_early() and i=
ts riscv implementation"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/sparc/include/asm/cacheflush.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/sparc/include/asm/cacheflush.h b/arch/sparc/include/asm=
/cacheflush.h
> index 881ac76eab93..9d87b2bcb217 100644
> --- a/arch/sparc/include/asm/cacheflush.h
> +++ b/arch/sparc/include/asm/cacheflush.h
> @@ -10,4 +10,11 @@
>  #else
>  #include <asm/cacheflush_32.h>
>  #endif
> +
> +#ifndef __ASSEMBLY__
> +static inline void flush_cache_vmap_early(unsigned long start, unsigned =
long end)
> +{
> +}
> +#endif
> +
>  #endif
> --
> 2.40.1
>
> --
> Cheers,
> Stephen Rothwell
