Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3C77500B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHIBFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHIBFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:05:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31997FB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:05:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-267fc1d776eso3555114a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691543138; x=1692147938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUsRmY1Xcm7ykK1suZsMHzelnTN7LprhzE12kZ8tIlw=;
        b=qEPdQN5/ZsibsJ6Ek13P2srY5X3spB6dVg4KnKybNiazDj5Iebdbp+Aa9/CL+72tDw
         6KHAGRh+sOJrFr8wYK+a8mMmGDqrBI4dr9jnKvbkpzZ0+ZMREBXoSspnBSLhbNHY+95x
         JaclkyIXapqhKBraR+aZQMw4hm0aOPn0vKKGmpJVuvbQwmRD8gdzbZdqTuQsBCOklpOx
         NQL2uAPdZsAWxdIb4wWeuidFBQ+7DcAvRtyMjdUdklxwtKVU0KnynrNnf3ZakQzFgu31
         FwDK11crbEjCmOGRGGBeZiFS21Dq+IpX9f0KWvhj7tAKFq+R2TR78JOjG/u/819aQm5d
         9Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543138; x=1692147938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUsRmY1Xcm7ykK1suZsMHzelnTN7LprhzE12kZ8tIlw=;
        b=GLYvMP9CGpLznRF7MTL7HaIV0UmXJu8IC7H9ZmSiQKNfDPcAwmBhjtmlUyBQPGCzn4
         FD02Ymdys35yEK2H6TaHonSlPQ9CksvIxOmoQBYLAxAxAM605ft4Mz5pxcGDnJ42DM3E
         EvrmM4tw/hbpIXPAkz7lCYNJTHGFBiiB8W6aX4asw0kuZRT8R/nj/fzf8FmWBEDBKqYQ
         hPdkVvZHzs2PefxL+Mg6/7vblD5AJe1f8hXibmQIDLSVWW2C06q0hHM/UNcGEVSUta+S
         0Vlolh7ugBXU5p/r3gI/ZpQufB4lO26eEd/uoSny25vXMK9KEwlGN+QTD4LDURjf2dCj
         e6mA==
X-Gm-Message-State: AOJu0YwVqMzM1SqbJ5Ev66wbOpq/Ghm9rQ6ApuPNyRXkQ2RcWfWcY2E9
        0TH8fonfva/LPs0jmBP6uEjo2UPNFVjP7xjIw/E=
X-Google-Smtp-Source: AGHT+IHTG2Or7nHex78SXgFtLnlCCknVmk+JqbSPUpPVeu1LWA3NvZlbOygXREgny3gbuBb8VrRdkQ==
X-Received: by 2002:a17:90b:3613:b0:268:522a:e31 with SMTP id ml19-20020a17090b361300b00268522a0e31mr866650pjb.42.1691543138656;
        Tue, 08 Aug 2023 18:05:38 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090a280f00b00267eead2f16sm179426pjd.36.2023.08.08.18.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:05:38 -0700 (PDT)
Date:   Tue, 8 Aug 2023 18:05:35 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: kprobes: simulate c.j instruction
Message-ID: <ZNLmX1wXu3ZivilA@ghost>
References: <cover.1690704360.git.namcaov@gmail.com>
 <6ef76cd9984b8015826649d13f870f8ac45a2d0d.1690704360.git.namcaov@gmail.com>
 <ZNLZxIRM5iIjmdcD@ghost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNLZxIRM5iIjmdcD@ghost>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 05:11:48PM -0700, Charlie Jenkins wrote:
> On Sun, Jul 30, 2023 at 10:27:07AM +0200, Nam Cao wrote:
> > kprobes currently rejects c.j instruction. Implement it.
> > 
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > ---
> >  arch/riscv/kernel/probes/decode-insn.c   |  3 ++-
> >  arch/riscv/kernel/probes/simulate-insn.c | 24 ++++++++++++++++++++++++
> >  arch/riscv/kernel/probes/simulate-insn.h |  1 +
> >  3 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
> > index 64f6183b4717..39adb07a342d 100644
> > --- a/arch/riscv/kernel/probes/decode-insn.c
> > +++ b/arch/riscv/kernel/probes/decode-insn.c
> > @@ -29,13 +29,14 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
> >  	 * TODO: the REJECTED ones below need to be implemented
> >  	 */
> >  #ifdef CONFIG_RISCV_ISA_C
> > -	RISCV_INSN_REJECTED(c_j,		insn);
> >  	RISCV_INSN_REJECTED(c_jr,		insn);
> >  	RISCV_INSN_REJECTED(c_jal,		insn);
> >  	RISCV_INSN_REJECTED(c_jalr,		insn);
> >  	RISCV_INSN_REJECTED(c_beqz,		insn);
> >  	RISCV_INSN_REJECTED(c_bnez,		insn);
> >  	RISCV_INSN_REJECTED(c_ebreak,		insn);
> > +
> > +	RISCV_INSN_SET_SIMULATE(c_j,		insn);
> >  #endif
> >  
> >  	RISCV_INSN_SET_SIMULATE(jal,		insn);
> > diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> > index 7441ac8a6843..3ba45c612cd8 100644
> > --- a/arch/riscv/kernel/probes/simulate-insn.c
> > +++ b/arch/riscv/kernel/probes/simulate-insn.c
> > @@ -188,3 +188,27 @@ bool __kprobes simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *r
> >  
> >  	return true;
> >  }
> > +
> > +bool __kprobes simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs)
> > +{
> > +	/*
> > +	 *  15    13 12                            2 1      0
> > +	 * | funct3 | offset[11|4|9:8|10|6|7|3:1|5] | opcode |
> > +	 *     3                   11                    2
> > +	 */
> > +
> > +	s32 offset;
> > +
> > +	offset  = ((opcode >> 3)  & 0x7) << 1;
> > +	offset |= ((opcode >> 11) & 0x1) << 4;
> > +	offset |= ((opcode >> 2)  & 0x1) << 5;
> > +	offset |= ((opcode >> 7)  & 0x1) << 6;
> > +	offset |= ((opcode >> 6)  & 0x1) << 7;
> > +	offset |= ((opcode >> 9)  & 0x3) << 8;
> > +	offset |= ((opcode >> 8)  & 0x1) << 10;
> > +	offset |= ((opcode >> 12) & 0x1) << 11;
> > +
> > +	instruction_pointer_set(regs, addr + sign_extend32(offset, 11));
> Can you use riscv_insn_insert_jtype_imm() from insn.h since it is
> already created? It will also sign extend for you. Don't worry about
> creating a similar function for the branches, I am in the process of
> refactoring the insn.h file.
> > +
> > +	return true;
> > +}
> > diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
> > index 61e35db31001..4bd6c266e7d3 100644
> > --- a/arch/riscv/kernel/probes/simulate-insn.h
> > +++ b/arch/riscv/kernel/probes/simulate-insn.h
> > @@ -24,5 +24,6 @@ bool simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs);
> >  bool simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *regs);
> >  bool simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs);
> >  bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
> > +bool simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs);
> >  
> >  #endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> Thanks,
> Charlie
Oh sorry, I forgot this was compressed. You can ignore the last message.
The changes look good. You can add:

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
