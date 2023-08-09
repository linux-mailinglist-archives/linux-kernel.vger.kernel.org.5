Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B3677502D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjHIBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHIBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:14:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26523198A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:14:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-687ca37628eso1758111b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691543681; x=1692148481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWT4JhC42VfaKttFZ++aGV4mz8fzIMvfW1JXvYZt6jU=;
        b=AKPPIdzgf5z4ql2dIwRxYxtZgU6yihBrCucSx1FoB56iu2tFoCtrmXI68WMZ12d8OT
         9vnGfLJtNFfmQNbcdJHkSR+ku34GWr8t9T7RFEj6uWjjeTa8RAgbw1iv0y0t8TPlz+D6
         TDT7DDK2kDfhkbohGyXha8IGl9cLCy4GFUTodqIlGwt0fil85hNUJfiX6ATJC3jA25r9
         SVwHKLOzhuOR6hDTdTB3VIhKmyxuirENwL5/mOm9aRHGMyphfTdeANcRy9JFx8R2RVD4
         f4C3c0JJTBCA5Rssnhcubux5aH4uxZki5vACwEtHAMfBQoJP6TTmDzp+Oljkh5qigmx6
         tLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543681; x=1692148481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWT4JhC42VfaKttFZ++aGV4mz8fzIMvfW1JXvYZt6jU=;
        b=aRuhkQPC0ZIqnuznUPIirka/qVFJC9SPyGSQEZRhe0sXGyti2bD3vzplluC0j2s1VX
         XzU3eTrJarQB7m6EXP54cHmGW72vwtB9nFzEc++2f6zksb04hs5J2o6hJvYEkFjxsj/w
         SaFS005eUM/YxNKpiqO4IyQgs3L+UUIYGI1KkwFdCW7T6MmcB7aEv0OCvSZCx3o13zYL
         K+NmwBOkvbvcskmk6Tw/RfDoUvDSnxbaPIQvl+TnXm5qr6h6QFKxF0UP9qumyjVlYhut
         /gPqHzGulvQsKHsXvc1M7/MUlryuNGI41/UlqBZ9R7VxLDoYbBLluxEoYOa9DTMl8IdX
         gxTA==
X-Gm-Message-State: AOJu0Yx8H5V+bMvJwW+AO+FWLsP1LNzJN6zbkCkU0kvapi/JC0HjYpi3
        rp1RelF8Zj9MLrlFxS45en3C7Q==
X-Google-Smtp-Source: AGHT+IE/iLSVocB1sUWQOlB0rXMjY7Smu2LPsv2p8+xBp1gQzKa7hcnl6+aGjso9Wvnm5iI9l0XN9g==
X-Received: by 2002:a05:6a20:1385:b0:11d:4c79:90ee with SMTP id hn5-20020a056a20138500b0011d4c7990eemr1218698pzc.25.1691543681550;
        Tue, 08 Aug 2023 18:14:41 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p27-20020a63951b000000b00563590be25esm7232226pgd.29.2023.08.08.18.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:14:41 -0700 (PDT)
Date:   Tue, 8 Aug 2023 18:14:39 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: kprobes: simulate c.beqz and c.bnez
Message-ID: <ZNLof08CrlQ8eNAg@ghost>
References: <cover.1690704360.git.namcaov@gmail.com>
 <1d879dba4e4ee9a82e27625d6483b5c9cfed684f.1690704360.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d879dba4e4ee9a82e27625d6483b5c9cfed684f.1690704360.git.namcaov@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 10:27:09AM +0200, Nam Cao wrote:
> kprobes currently rejects instruction c.beqz and c.bnez. Implement them.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/kernel/probes/decode-insn.c   |  4 +--
>  arch/riscv/kernel/probes/simulate-insn.c | 44 ++++++++++++++++++++++++
>  arch/riscv/kernel/probes/simulate-insn.h |  2 ++
>  3 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
> index 6dba23a55ac7..65d9590bfb9f 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -30,13 +30,13 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
>  	 */
>  #ifdef CONFIG_RISCV_ISA_C
>  	RISCV_INSN_REJECTED(c_jal,		insn);
> -	RISCV_INSN_REJECTED(c_beqz,		insn);
> -	RISCV_INSN_REJECTED(c_bnez,		insn);
>  	RISCV_INSN_REJECTED(c_ebreak,		insn);
>  
>  	RISCV_INSN_SET_SIMULATE(c_j,		insn);
>  	RISCV_INSN_SET_SIMULATE(c_jr,		insn);
>  	RISCV_INSN_SET_SIMULATE(c_jalr,		insn);
> +	RISCV_INSN_SET_SIMULATE(c_beqz,		insn);
> +	RISCV_INSN_SET_SIMULATE(c_bnez,		insn);
>  #endif
>  
>  	RISCV_INSN_SET_SIMULATE(jal,		insn);
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> index 1ead6f4951f9..d3099d67816d 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -249,3 +249,47 @@ bool __kprobes simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *r
>  {
>  	return simulate_c_jr_jalr(opcode, addr, regs, true);
>  }
> +
> +static bool __kprobes simulate_c_bnez_beqz(u32 opcode, unsigned long addr, struct pt_regs *regs,
> +					   bool is_bnez)
> +{
> +	/*
> +	 *  15    13 12           10 9    7 6                 2 1  0
> +	 * | funct3 | offset[8|4:3] | rs1' | offset[7:6|2:1|5] | op |
> +	 *     3            3          3             5           2
> +	 */
> +
> +	s32 offset;
> +	u32 rs1;
> +	unsigned long rs1_val;
> +
> +	rs1 = 0x8 | ((opcode >> 7) & 0x7);
> +
> +	if (!rv_insn_reg_get_val(regs, rs1, &rs1_val))
> +		return false;
> +
> +	if ((rs1_val != 0 && is_bnez) || (rs1_val == 0 && !is_bnez)) {
> +		offset =  ((opcode >> 3)  & 0x3) << 1;
> +		offset |= ((opcode >> 10) & 0x3) << 3;
> +		offset |= ((opcode >> 2)  & 0x1) << 5;
> +		offset |= ((opcode >> 5)  & 0x3) << 6;
> +		offset |= ((opcode >> 12) & 0x1) << 8;
> +		offset = sign_extend32(offset, 8);
> +	} else {
> +		offset = 2;
> +	}
> +
> +	instruction_pointer_set(regs, addr + offset);
> +
> +	return true;
> +}
> +
> +bool __kprobes simulate_c_bnez(u32 opcode, unsigned long addr, struct pt_regs *regs)
> +{
> +	return simulate_c_bnez_beqz(opcode, addr, regs, true);
> +}
> +
> +bool __kprobes simulate_c_beqz(u32 opcode, unsigned long addr, struct pt_regs *regs)
> +{
> +	return simulate_c_bnez_beqz(opcode, addr, regs, false);
> +}
> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
> index 472a1948ec4f..44ebbc444db9 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.h
> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> @@ -27,5 +27,7 @@ bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
> +bool simulate_c_bnez(u32 opcode, unsigned long addr, struct pt_regs *regs);
> +bool simulate_c_beqz(u32 opcode, unsigned long addr, struct pt_regs *regs);
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

