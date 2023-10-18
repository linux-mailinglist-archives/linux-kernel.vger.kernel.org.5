Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB177CD908
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjJRKU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjJRKUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:20:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50AFB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:20:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so377863966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697624419; x=1698229219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtKsd5ATsOd1KMkyRCem0ZdPb7Hx7kw84A3vydeYqsg=;
        b=J0Aq0Y/391GD8Ol0MHJyIBae0fyMbhmWrGiNv4P8/a3xSYE2bptEpGYUW8y2N2gVe8
         Hjw1dRhrzshJIo+VuuBjysX3/bEdJeR6BKg3pOv+vqoyu7J0IPbqSv7HcOt1O+7tRMxe
         pJ6F56wPcgZqnHzj5wdrsvCDWhtfcPqZ5y90xzFXuf82msHMfc//H482T0vA7aC/vnNE
         M9YVmNE1FhXNW7rAEXFCLHrjlriqmS2oq1Zi28+KVQcIj+yPw6AVPAO424V7f28xEEBX
         PDRgR9N6joyf/eUQmJtV8zgbiDoqJJkw6pzaafDP9StFVJnL/Rq5Pv1Wk0GAl3vaDTrT
         2A+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697624419; x=1698229219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtKsd5ATsOd1KMkyRCem0ZdPb7Hx7kw84A3vydeYqsg=;
        b=sQE+UH7DujmQRzyRNFxnqhZeRgsKudvfcP9jsO53UhOniQaG2KWHZnErmVoaxV4ggp
         swpRbf77PiV55czOWt01P736TBuGUGMgh1J2q7RCEB4biTvqMO0faJq/4Hc1FqcRkweI
         +n+91pfLk7LL4wK9i5AKs+9t0a+W0hRDRZMKt/+/YtL/mdNANzrxjbCp/UnxjpHtrwmD
         PJM9G2Yvs52MC5DUjTFIrxLB5KabVCkGC0r/bWGEDOhptdHvsdG8fDfTpxKPUaYHwfoe
         vnipHY5NuZSgm9qiDSnJeFmr286/cHCy77fE0ZGEPrBGeyCHf69hvFViBX9ByV3RzSSW
         hKmw==
X-Gm-Message-State: AOJu0YzzWC+kQoFy3/xfe3DrQGQDM1b3NzNqyUHjqGKzD3682eDk4EPh
        EQtnLNxdnEuppS6zGTrlIDc=
X-Google-Smtp-Source: AGHT+IG0+ghLdJP7xh3+UP6P4HtKSqnJEfawLlc1VP0eTK3Zib0vchGv3+FHOcSs8FrAjjQ1PbF3xA==
X-Received: by 2002:a17:906:4784:b0:9be:ea59:1457 with SMTP id cw4-20020a170906478400b009beea591457mr3804310ejc.40.1697624419019;
        Wed, 18 Oct 2023 03:20:19 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id mc8-20020a170906eb4800b0098d2d219649sm1382751ejb.174.2023.10.18.03.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:20:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 12:20:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Rutherford <srutherford@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] x86/sme: Mark the code as __head in
 mem_encrypt_identity.c
Message-ID: <ZS+xX7IJfdGJj7Ix@gmail.com>
References: <cover.1697525407.git.houwenlong.hwl@antgroup.com>
 <b2670a8a79a7b4a5c8993fb916904af7c675b7f8.1697525407.git.houwenlong.hwl@antgroup.com>
 <ZS6DngTm9ILei4dM@gmail.com>
 <20231018071347.GA87734@k08j02272.eu95sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018071347.GA87734@k08j02272.eu95sqa>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:

> On Tue, Oct 17, 2023 at 08:52:46PM +0800, Ingo Molnar wrote:
> > 
> > * Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > 
> > > The functions sme_enable() and sme_encrypt_kernel() are only called by
> > > the head code which runs in identity virtual address. Therefore, it's
> > > better to mark them as __head as well.
> > > 
> > > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > > ---
> > >  arch/x86/include/asm/mem_encrypt.h |  8 ++++----
> > >  arch/x86/mm/mem_encrypt_identity.c | 27 ++++++++++++++-------------
> > >  2 files changed, 18 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> > > index 359ada486fa9..48469e22a75e 100644
> > > --- a/arch/x86/include/asm/mem_encrypt.h
> > > +++ b/arch/x86/include/asm/mem_encrypt.h
> > > @@ -46,8 +46,8 @@ void __init sme_unmap_bootdata(char *real_mode_data);
> > >  
> > >  void __init sme_early_init(void);
> > >  
> > > -void __init sme_encrypt_kernel(struct boot_params *bp);
> > > -void __init sme_enable(struct boot_params *bp);
> > > +void sme_encrypt_kernel(struct boot_params *bp);
> > > +void sme_enable(struct boot_params *bp);
> > >  
> > >  int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
> > >  int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
> > > @@ -75,8 +75,8 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
> > >  
> > >  static inline void __init sme_early_init(void) { }
> > >  
> > > -static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
> > > -static inline void __init sme_enable(struct boot_params *bp) { }
> > > +static inline void sme_encrypt_kernel(struct boot_params *bp) { }
> > > +static inline void sme_enable(struct boot_params *bp) { }
> > 
> > So I think we should preserve the previous convention of marking functions 
> > __init in the header-declaration and at the definition site as well, and do 
> > the same with __head as well?
> > 
> Hi Ingo,
> 
> I tried to include <asm/init.h> into <asm/mem_encrypt.h> and mark the
> function declaration as __head, but it resulted in a build failure. This
> is because <asm/init.h> is not self-contained; the type "pgd_t" is
> defined in <asm/pgtable_types.h>, which includes <asm/mem_encrypt.h>,
> leading to mutual inclusion of header files. To avoid the issue of
> complicated header file inclusion, I removed the annotation from the
> function declaration.

The right solution at that point is to make <asm/init.h> self-contained...

> Actually, initially, I noticed that the __init definition is in
> <linux/init.h>, so I first placed the __head definition in
> <linux/init.h> as well. However, this conflicted with the local variable
> in the "list_next_or_null_rcu" macro in <linux/rculist.h>. Then I
> realized that __head was only used in x86, so I made the decision to put
> it in the architecture-specific header. Considering simplicity, I chose
> to put the definition in <asm/init.h>. I also attempted to put the
> definition in other headers such as <asm/boot.h> and
> <asm/bootparam_utils.h>, and included them in <asm/mem_encrypt.h>, but
> the build still failed.

When exporting a localized definition you should consider namespace 
collisions - the name '__head' is way too generic, no wonder it caused 
problems elsewhere.

I'd suggest naming it __init_head or so, but still keep it in a x86-only 
header.

I presume keeping it all in the  separate section and widening its usage has a 
specific purpose? Please outline that in the changelog as well.

Ie. instead of mechanical patches that try to follow existing patterns 
cargo-cult style, this area of x86 code requires well-argued, well thought 
out patches that show background knowledge of the area.

Thanks,

	Ingo
