Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6AC78C01D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjH2ITH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjH2ISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:18:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C42DF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:18:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d8332f50so528598566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693297112; x=1693901912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YzI1T+2NbKPa+ILrlCcTyXygxu+/4IOX+GwCCixXUy8=;
        b=NYqm+ES5G3BCmnDsMWFKt/TeHhfHzrc6N0RlaHKeosp2s3hMJvNTvhSuZLHZinQ3vz
         yyKfWl956ojMfRGxDPM8DrrHDUL/kggaWV09Xp20KzHpVoc+SHYxdipH+Yj2qG1TYadW
         B/HpKKdxxqKY4eo2sGjjYJwdpUe/SU4PcjPT6EkfeP0YIiXJiIHI00uQmG3wj/9T20bG
         Hfg5gMSaPLgoqmEGl72HQ/Cy1jdgdnZmRfcdywC+eyX9f+U91irMD1QbMTljUBbqcZ8I
         bkw83L0Z8SGXFoMEqhAkNmAQydx1VaqngfwyUn0m2NslBQNVNLN+/KaruZorZCfH6znq
         +BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693297112; x=1693901912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzI1T+2NbKPa+ILrlCcTyXygxu+/4IOX+GwCCixXUy8=;
        b=SP0VZKqC0e0aixlOx8Q+KADmUYQo12XBg0pPleygUK5jes//zqFE6TNUFPtnlM4Zzm
         YIWGZI+G4K8n8w/1QuLmrxF6KxnimeyNcqdeYYQ9RWg2240UwVNpv0TfqjFJI0+1y5pa
         Fy03IA/Xo95QGNNkHBBJlmA2yA3DO6GhK9Cqpup/Czs0gAdiepYASrU5bnobvnvqedPU
         bv+gEB9iSLIxQI00v1fGeqjVJkRwdaOerFCFiCFcOTERFho/yrqJvxlhIU0BjZObx/Ds
         /xPtfTXAp4D2jje10ZQky6cQk9HVYPFwfhIWZjxinfB5fLsujmq3CdVa5jsWKetuZrfD
         guhw==
X-Gm-Message-State: AOJu0Yw8eSlt0deaGC/4lmkSfDxdI/kNL/Vq+zChA64YMFn9GTbCe6Y8
        +2RS87BLK1iS+j+63LrGCTc=
X-Google-Smtp-Source: AGHT+IE3mRfIvKXbHtpMoS5M4OQ2ByoT6MjDiGZeA537rzrccA/PlIFgswGlCI+WiS/AtJ9r8K2W1A==
X-Received: by 2002:a17:906:3193:b0:9a2:256a:65cd with SMTP id 19-20020a170906319300b009a2256a65cdmr10288792ejy.4.1693297112147;
        Tue, 29 Aug 2023 01:18:32 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906590b00b00992e14af9b9sm5643992ejq.134.2023.08.29.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:18:31 -0700 (PDT)
Date:   Tue, 29 Aug 2023 10:18:30 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn@kernel.org
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
Message-ID: <ZO2p1tScBT1UFMh1@nam-dell>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <CAJF2gTQysBBSbtFcx1uY_ztTnzN5jRWpG2OD4O3aJ0u9Ekwsag@mail.gmail.com>
 <20230829-unbridle-condense-2fc45a442bb6@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829-unbridle-condense-2fc45a442bb6@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:26:54AM +0100, Conor Dooley wrote:
> On Tue, Aug 29, 2023 at 01:56:34PM +0800, Guo Ren wrote:
> > On Mon, Aug 28, 2023 at 4:56 AM Nam Cao <namcaov@gmail.com> wrote:
> > >
> > > uprobes expects is_trap_insn() to return true for any trap instructions,
> > > not just the one used for installing uprobe. The current default
> > > implementation only returns true for 16-bit c.ebreak if C extension is
> > > enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> > > exception from userspace: uprobes asks is_trap_insn() who says there is no
> > > trap, so uprobes assume a probe was there before but has been removed, and
> > > return to the trap instruction. This cause an infinite loop of entering
> > > and exiting trap handler.
> > >
> > > Instead of using the default implementation, implement this function
> > > speficially for riscv which checks for both ebreak and c.ebreak.
> > >
> > > Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> > > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > > ---
> > >  arch/riscv/kernel/probes/uprobes.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> > > index 194f166b2cc4..91f4ce101cd1 100644
> > > --- a/arch/riscv/kernel/probes/uprobes.c
> > > +++ b/arch/riscv/kernel/probes/uprobes.c
> > > @@ -3,6 +3,7 @@
> > >  #include <linux/highmem.h>
> > >  #include <linux/ptrace.h>
> > >  #include <linux/uprobes.h>
> > > +#include <asm/insn.h>
> > >
> > >  #include "decode-insn.h"
> > >
> > > @@ -17,6 +18,15 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
> > >  #endif
> > >  }
> >  >
> > > +bool is_trap_insn(uprobe_opcode_t *insn)
> > > +{
> > > +#ifdef CONFIG_RISCV_ISA_C
> 
> > Can we remove the CONFIG_RISCV_ISA_C? As you said, "uprobes expects
> > is_trap_insn() to return true for any trap instructions". So userspace
> > wouldn't be limited by CONFIG_RISCV_ISA_C.
> 
> Isn't the RISCV_ISA_C required because there's a different encoding for
> EBREAK vs C_EBREAK? That said, this should be using IS_ENABLED() not
> #ifdef, since the definition for riscv_insn_is_c_ebreak() is provided
> unconditionally afaict.

Sorry, was too quick that I missed the last sentence.

Now I'm not sure what you mean. But I agree with Guo Ren here, users can use
compressed instructions but kernel does not have it enabled. So we should
always check c.ebreak regardless of RISCV_ISA_C.

Best regards,
Nam
