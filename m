Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8C77500C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjHIBHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHIBG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:06:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44CFB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:06:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26824c32cfbso306768a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691543218; x=1692148018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDlgdWSio+yXC/Nn1OBq/QVRcrUPGuqsehLIooX+ZW0=;
        b=BQapDrqI+OjZfikqLkxLY65qdTymK0gAxbUzjF6zV8We6Vb2d8vMz7oJTWweMvHFrq
         EqboTd20jkq/w2uBIqGD/gNu13ECL4seqIw0bOMihPy41IdAyn636ZmQsYjpsOkCRtZ2
         klKj/Gsje16RMljkXyjI1n5+mEXA/tWxS0+o3VD+nILn4UO2Vor4K7G7QipR4oyGOOgm
         tEJPdhJ0YpgCp+HavKPFuRkjEENq3uEOu7EiBz/VuNb9/0UB1DrGveJtLyXSHL/Wxnb5
         otzCnNmSDQPfEoXCjt4MPXGFi+GeqcVvbYKVnakwsDZyE7DoWPRFKZ69Qc1h6LgF9ppV
         /Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543218; x=1692148018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDlgdWSio+yXC/Nn1OBq/QVRcrUPGuqsehLIooX+ZW0=;
        b=a7QY6NBO6+39mE4o8cIpX8aML3WiHMF+oKA+AoKe+cPo4/SZO+DnqZpOelIy351m7l
         JJlFE04ErLUbyMCvn613AYHS547OCV8xstASNTBuPGN6f1hjfFSBdcwyeBHyV4nZqRcb
         +m4B+LurYITmuiatmb+x4ATgTZLoWLio19eRp8j86GWghR/DFNoHrw9APav+ar5obZ+d
         mRb1HzGtrHpWrVsLbFPzgyB5WDSeKFvJ28cDZQhyF++JgPX3ZVkFCA5W5daN+QLbaTMQ
         6Yazi80XcWxd4RvRP/GxVlwyxapSZCvPwhFgf6QiArd6E5eOcqVG3+VIZfHW5QOw20om
         DsXg==
X-Gm-Message-State: AOJu0YxYBTO80H2NEnTyOhfHV/tuvIgkYXuZZ/33xVAoUPpTYMapGcBL
        +GyrLbCx9Dw5TWKMOnnaqwDGTw==
X-Google-Smtp-Source: AGHT+IF/KuDoa6Xy7Sv9D2QnbMq24T7k3TtXKaq4Eap7G32v0u2qaPX5My72Dth6grb2O2/jypJi9A==
X-Received: by 2002:a17:90a:674b:b0:268:abf:6431 with SMTP id c11-20020a17090a674b00b002680abf6431mr1548680pjm.24.1691543217835;
        Tue, 08 Aug 2023 18:06:57 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a898a00b00263fc1ef1aasm161087pjn.10.2023.08.08.18.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:06:57 -0700 (PDT)
Date:   Tue, 8 Aug 2023 18:06:55 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: kprobes: simulate c.jr and c.jalr instructions
Message-ID: <ZNLmr0S956z76hkg@ghost>
References: <cover.1690704360.git.namcaov@gmail.com>
 <db8b7787e9208654cca50484f68334f412be2ea9.1690704360.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8b7787e9208654cca50484f68334f412be2ea9.1690704360.git.namcaov@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 10:27:08AM +0200, Nam Cao wrote:
> kprobes currently rejects c.jr and c.jalr instructions. Implement them.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/kernel/probes/decode-insn.c   |  4 +--
>  arch/riscv/kernel/probes/simulate-insn.c | 37 ++++++++++++++++++++++++
>  arch/riscv/kernel/probes/simulate-insn.h |  2 ++
>  3 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
> index 39adb07a342d..6dba23a55ac7 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -29,14 +29,14 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
>  	 * TODO: the REJECTED ones below need to be implemented
>  	 */
>  #ifdef CONFIG_RISCV_ISA_C
> -	RISCV_INSN_REJECTED(c_jr,		insn);
>  	RISCV_INSN_REJECTED(c_jal,		insn);
> -	RISCV_INSN_REJECTED(c_jalr,		insn);
>  	RISCV_INSN_REJECTED(c_beqz,		insn);
>  	RISCV_INSN_REJECTED(c_bnez,		insn);
>  	RISCV_INSN_REJECTED(c_ebreak,		insn);
>  
>  	RISCV_INSN_SET_SIMULATE(c_j,		insn);
> +	RISCV_INSN_SET_SIMULATE(c_jr,		insn);
> +	RISCV_INSN_SET_SIMULATE(c_jalr,		insn);
>  #endif
>  
>  	RISCV_INSN_SET_SIMULATE(jal,		insn);
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> index 3ba45c612cd8..1ead6f4951f9 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -212,3 +212,40 @@ bool __kprobes simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs
>  
>  	return true;
>  }
> +
> +static bool __kprobes simulate_c_jr_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs,
> +					 bool is_jalr)
> +{
> +	/*
> +	 *  15    12 11  7 6   2 1  0
> +	 * | funct4 | rs1 | rs2 | op |
> +	 *     4       5     5    2
> +	 */
> +
> +	unsigned long jump_addr;
> +
> +	u32 rs1 = (opcode >> 7) & 0x1f;
> +
> +	if (rs1 == 0) /* C.JR is only valid when rs1 != x0 */
> +		return false;
> +
> +	if (!rv_insn_reg_get_val(regs, rs1, &jump_addr))
> +		return false;
> +
> +	if (is_jalr && !rv_insn_reg_set_val(regs, 1, addr + 2))
> +		return false;
> +
> +	instruction_pointer_set(regs, jump_addr);
> +
> +	return true;
> +}
> +
> +bool __kprobes simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs)
> +{
> +	return simulate_c_jr_jalr(opcode, addr, regs, false);
> +}
> +
> +bool __kprobes simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs)
> +{
> +	return simulate_c_jr_jalr(opcode, addr, regs, true);
> +}
> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
> index 4bd6c266e7d3..472a1948ec4f 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.h
> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> @@ -25,5 +25,7 @@ bool simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs);
> +bool simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs);
> +bool simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  
>  #endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
You can add:

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
