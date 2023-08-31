Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0778F495
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347589AbjHaV1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbjHaV1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:27:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FE910C2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:27:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c79850df5so1097124f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693517254; x=1694122054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iupIS6httnGz7fIFmLRtaWsIeoTcrOCgOigpl3lsPnI=;
        b=LxaYlAcPHCKDILPNmLqXi/7MOM6L4vVRdSBH1xKGKPhLkl+KqyvowgERK3JYY8y1rZ
         a2vY7wK4wFk5UEcPj4/UEvph5ExvmcNwyuhHLpTmvWO6NQxjJVnoXJMtpybF1L4W6WKO
         /bYUYxbEQFnZX0RHlFWB/5QDCnkhRmUO1vKsda6M7eHmORhuRaSY6gxnWSbTH1y2hFGr
         3HfIjLZGFksnsaZ8isOSP7z/1RLessWLE93zqDq96qm1Jd6u6Xj/AxjrY4jZwVo8RYDO
         oB1ljJUc0j5pDllNLiUwKAD8UY9lsIcdpBljDbzbqHR7/RLmREvkfS3avvZU8UGpLkMM
         Xjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693517254; x=1694122054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iupIS6httnGz7fIFmLRtaWsIeoTcrOCgOigpl3lsPnI=;
        b=MqmjJQijPPymAb6qduULSAvG9AeqHs9tkr9OEbdeK9ISES9OBoQdvb44l0lHU3eca8
         ce4apjX/Oy0/9aoJi53Te/m/cG4bWFtXxG4HlX1Xuxz7EMauXu7y6a+lLpYZAnWNoojR
         hKt0d+/Imakn5R5Jt0KJiSIrOI8B3vvs7y+gw5+wW+dReflX6/kfyF7HGMSF8FyoXF48
         l9XafYykU4QJjSvx98dm749gbcq8VKTl04R1Regh7o2oMljzQSsgTbkH0Yfx90aXbbaO
         0O9jXye550R9jGwZ5IOTvm6CH+ZZ2WsGFt3zf+3qbRw6q336tXRdYW7gcE1wqKjqsPjj
         gC2g==
X-Gm-Message-State: AOJu0YxTeGXqKokEZYwb9In0JWXT/BnaLDKaI3iWOfCMr6G12Ir2KKGs
        eZHTn7aHwvVfinI7j8RcjevKJxUJ7TQ=
X-Google-Smtp-Source: AGHT+IFzXfZgzc7JItB3iHju8fUuIV3J9BS+3eO1oyJ42ucX2P4sD6yGCzM5Q3fc5dqNzCF4AHcucg==
X-Received: by 2002:adf:f30d:0:b0:317:eee2:6fba with SMTP id i13-20020adff30d000000b00317eee26fbamr455352wro.40.1693517254017;
        Thu, 31 Aug 2023 14:27:34 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id s10-20020adfecca000000b003197869bcd7sm3332128wro.13.2023.08.31.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:27:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 31 Aug 2023 23:27:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Fix pud_mkwrite() definition after pte_mkwrite()
 API changes [was: Re: [GIT PULL] x86/shstk for 6.6-rc1]
Message-ID: <ZPEFw1XGrI69ZbJ6@gmail.com>
References: <20230830234752.19858-1-dave.hansen@linux.intel.com>
 <CAHk-=wipDVFEfSJxbnUSDqENs5i8RzSsgJOFdb69pH=b7BOFiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wipDVFEfSJxbnUSDqENs5i8RzSsgJOFdb69pH=b7BOFiQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 30 Aug 2023 at 16:48, Dave Hansen <dave.hansen@linux.intel.com> wrote:
> >
> > Add x86 shadow stack support
> 
> I assume you are aware of the system call renumbering from linux-next,
> but I thought I'd mention it anyway. 452 was taken by fchmodat2, so
> your new map_shadow_stack() system call is merged as 453.
> 
> I do also note that it looks like the merge resolution of the
> _COMMON_PAGE_CHG_MASK bits in linux-next is wrong, and lost the
> _PAGE_DIRTY_BITS part in Ingo's -tip merge 783560d95e0e ("Merge branch
> 'x86/mm' into x86/merge, to ease integration testing").
> 
> Anyway, please do double-check my merge for correctness, and test it
> on some machine that hopefully supports this and has the
> infrastructure set up for it.

I believe there's one semantic conflict you missed, which breaks the powerpc64
build: recent changes to arch/powerpc/include/asm/book3s/64/pgtable.h created
a new semantic conflict due to the changes to the pte_mkwrite() API:

  161e393c0f63 ("mm: Make pte_mkwrite() take a VMA")

... resolved with the fix below.

Only build tested though.

The crossing upstream commit was:

  27af67f35631 ("powerpc/book3s64/mm: enable transparent pud hugepage")

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>

 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 136232a89739..5c497c862d75 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -931,7 +931,7 @@ static inline pte_t *pudp_ptep(pud_t *pud)
 #define pud_mkdirty(pud)	pte_pud(pte_mkdirty(pud_pte(pud)))
 #define pud_mkclean(pud)	pte_pud(pte_mkclean(pud_pte(pud)))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
-#define pud_mkwrite(pud)	pte_pud(pte_mkwrite(pud_pte(pud)))
+#define pud_mkwrite(pud)	pte_pud(pte_mkwrite_novma(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY

