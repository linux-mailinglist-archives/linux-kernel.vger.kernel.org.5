Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2C80DAD7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbjLKTZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjLKTZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:25:17 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10DBD5;
        Mon, 11 Dec 2023 11:25:21 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ca0b968d8dso569447a12.1;
        Mon, 11 Dec 2023 11:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322721; x=1702927521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+vj8h5bQ6vZDfhKWD5PwxhRlKf++3gbeBs7wv6EQbA=;
        b=pzJ2ZaPGGYpvNlJmdkTSpJqHpMhyFzkT7MYho5TFX1/Nphvqit3mypeQZKjesLZezU
         de1Y1+N0P6muFU+kbl7O1Up5kgPtIStCPGuJPQ0q+goGzJdxyjknOO3fjdCoxy8D+c/5
         NCns5ZSr5tsl8e1GChNP7p94xvOMvUl+XbqE03iY9kTh3UywbukAot3R67v99OMRRvmC
         2mlUVUSU58Kp993nkY0K/8PXpS14oqSdpc2gPeilwMqM6pqZMQyde+2t93JRJZdro1eY
         SlBoYRveUXt9BGQ0rWy2BkNBr3N5CUQ3QE4mV5i0J2IoqkhmGOs8QBeAGvs8scvRXPvy
         +7ug==
X-Gm-Message-State: AOJu0YzKfUA5it4nkeaHKmR6nicA4HKEei3kxuOThIOs78g9vJK9L+E0
        aGZYdvISnYWIiQbMvDSaf0I=
X-Google-Smtp-Source: AGHT+IFFpcQo0QMAcNfUT+pXDc6oiE7I8V3rXSH1IVcXpXkGeDiqBxijBRYHU228Fv4nkBmeU1SQAg==
X-Received: by 2002:a05:6a20:9706:b0:18d:b43:78f9 with SMTP id hr6-20020a056a20970600b0018d0b4378f9mr1765345pzc.39.1702322721017;
        Mon, 11 Dec 2023 11:25:21 -0800 (PST)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id ka36-20020a056a0093a400b006ce7f0502f0sm6646512pfb.151.2023.12.11.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:25:20 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:25:14 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the percpu tree
Message-ID: <ZXdiGqq0GBR++ONz@snowbird>
References: <20231211171406.71fdc29b@canb.auug.org.au>
 <CAHVXubio372X_xXiWBMYk5=C7K49Wv6uki-uqWk1eyH-YuGGnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubio372X_xXiWBMYk5=C7K49Wv6uki-uqWk1eyH-YuGGnA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 11, 2023 at 09:31:25AM +0100, Alexandre Ghiti wrote:
> Hi Stephen,
> 
> On Mon, Dec 11, 2023 at 7:14 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the percpu tree, today's linux-next build (sparc64
> > defconfig) failed like this:
> >
> > mm/percpu.c: In function 'pcpu_page_first_chunk':
> > mm/percpu.c:3336:17: error: implicit declaration of function 'flush_cache_vmap_early'; did you mean 'flush_cache_vmap'? [-Werror=implicit-function-declaration]
> >  3336 |                 flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~
> >       |                 flush_cache_vmap
> > cc1: some warnings being treated as errors
> >
> > Caused by commit
> >
> >   a95c15a43f4a ("mm: Introduce flush_cache_vmap_early() and its riscv implementation")
> >
> > I have applied the following fix patch for today.  Are there other
> > archs that don't use asm-generic/cacheflush.h?
> 

I'm surprised automation didn't catch this as this should have failed
for any sparc build? It passed `sparc allmodconfig gcc` on my branches.

> It seems like most archs do not include this file, I should have
> checked. As I'm a bit scared of the possible side-effects of including
> asm-generic/cacheflush.h, I'll define flush_cache_vmap_early() on all
> archs that do define flush_cache_vmap().
> 

Hmmm. That makes sense, but we'd still need to check so we have the
generic #ifndef definition included everywhere too.

> Stephen, do you want a patch fix? Or do you want me to send a new
> version of the current patches so that you can drop them for now?
> 

The for-next tree gets recreated from pulls of the maintainers' trees.
I'm going to drop the series from percpu and then we can go again with a
v2.

> Sorry for the oversight,
> 

All good it happens. It's why the automation is there.

Thanks,
Dennis

> Thanks,
> 
> Alex
> 
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 11 Dec 2023 16:57:00 +1100
> > Subject: [PATCH] fix up for "mm: Introduce flush_cache_vmap_early() and its riscv implementation"
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  arch/sparc/include/asm/cacheflush.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/sparc/include/asm/cacheflush.h b/arch/sparc/include/asm/cacheflush.h
> > index 881ac76eab93..9d87b2bcb217 100644
> > --- a/arch/sparc/include/asm/cacheflush.h
> > +++ b/arch/sparc/include/asm/cacheflush.h
> > @@ -10,4 +10,11 @@
> >  #else
> >  #include <asm/cacheflush_32.h>
> >  #endif
> > +
> > +#ifndef __ASSEMBLY__
> > +static inline void flush_cache_vmap_early(unsigned long start, unsigned long end)
> > +{
> > +}
> > +#endif
> > +
> >  #endif
> > --
> > 2.40.1
> >
> > --
> > Cheers,
> > Stephen Rothwell
