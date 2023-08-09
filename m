Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87229774FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjHIALx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHIALw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:11:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716D1981
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:11:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso41267195ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 17:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691539911; x=1692144711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AT1C4AerJlXwIiNecJBhQV/P+t8hVTh2ACzgYtgXBrE=;
        b=r0sC93j/WMXkSVhGupG2mhApM1DKDknlkIb01eiNXioWHNaKXtc6cKNWIiTPKCq6s2
         KTwSZn2Vw60lzPMwUQMnQMI0VRUO82mogV5vd9zyhsIFD+alyY0sXwNK1pGSM9fjf+IJ
         RwoWK/7509wPgYpDG9r2AQsCVHb4qlbsdHZiHLDYGKusNixz9PRgMajiwl8RwueUQOid
         d4fUVsIWCvca6B4Dmnd/CCybBVKUiqOOJtLdCYFIPZZffWOEOLMdK5HXUXY7gwQRaNES
         TObY5mvrTgsJzmOTLT+7WyJl5DsJ7jDRCs4sBSxY1cYZLaJ71+W0tB9dITHGn3XYvdpu
         Ft5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539911; x=1692144711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT1C4AerJlXwIiNecJBhQV/P+t8hVTh2ACzgYtgXBrE=;
        b=dgcLpnDCmTbcKpVhJ4ByjyeYsOcLngE5moHqaZJd4nuaAC7wV31J3XLwFztSI6L7tG
         USNwE3TPdb73cnHYTq6Lzjbw62c6DrP2ctAqq3nyf0/yp5mc208WlhOIzBFsbhr1fyUV
         bjcx+k8CK9xDzhX9z3qc1ggvbDhrbfeEjJqNh/mIHciFjK14heVI6KZHf+z8Vpgrzdby
         7X1ApwibY22KPXM8AVkBcp3wxMB9ZHs+xcUrS8oh3ZVRt/keQgnUf6jVinJCdHW9zVDt
         xUDKxx9oa04jiyptacWDccra8OqAMWeF5VNXWoTP3hwnKboERHjYHfmxjS2OjoIYm2cM
         IByg==
X-Gm-Message-State: AOJu0YzXgH6v/Dey05qQEdtx5SBxKKBIF2EE1dezvDiXgg8Y7wm+8Tii
        Cv/7oKknxV7cFgeLRS9Rm0a3gw==
X-Google-Smtp-Source: AGHT+IH84L0Lj4niri8+x73RnRq6aCUwjs8P/OOQlxApk4kGCMI8KyIKsJ9TzMnoltLfoEdgpF48Cg==
X-Received: by 2002:a17:903:2283:b0:1b8:1b79:a78c with SMTP id b3-20020a170903228300b001b81b79a78cmr1260219plh.44.1691539911175;
        Tue, 08 Aug 2023 17:11:51 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001b8b45b177esm9562281plp.274.2023.08.08.17.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:11:50 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:11:48 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: kprobes: simulate c.j instruction
Message-ID: <ZNLZxIRM5iIjmdcD@ghost>
References: <cover.1690704360.git.namcaov@gmail.com>
 <6ef76cd9984b8015826649d13f870f8ac45a2d0d.1690704360.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ef76cd9984b8015826649d13f870f8ac45a2d0d.1690704360.git.namcaov@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 10:27:07AM +0200, Nam Cao wrote:
> kprobes currently rejects c.j instruction. Implement it.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/kernel/probes/decode-insn.c   |  3 ++-
>  arch/riscv/kernel/probes/simulate-insn.c | 24 ++++++++++++++++++++++++
>  arch/riscv/kernel/probes/simulate-insn.h |  1 +
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
> index 64f6183b4717..39adb07a342d 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -29,13 +29,14 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
>  	 * TODO: the REJECTED ones below need to be implemented
>  	 */
>  #ifdef CONFIG_RISCV_ISA_C
> -	RISCV_INSN_REJECTED(c_j,		insn);
>  	RISCV_INSN_REJECTED(c_jr,		insn);
>  	RISCV_INSN_REJECTED(c_jal,		insn);
>  	RISCV_INSN_REJECTED(c_jalr,		insn);
>  	RISCV_INSN_REJECTED(c_beqz,		insn);
>  	RISCV_INSN_REJECTED(c_bnez,		insn);
>  	RISCV_INSN_REJECTED(c_ebreak,		insn);
> +
> +	RISCV_INSN_SET_SIMULATE(c_j,		insn);
>  #endif
>  
>  	RISCV_INSN_SET_SIMULATE(jal,		insn);
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> index 7441ac8a6843..3ba45c612cd8 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -188,3 +188,27 @@ bool __kprobes simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *r
>  
>  	return true;
>  }
> +
> +bool __kprobes simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs)
> +{
> +	/*
> +	 *  15    13 12                            2 1      0
> +	 * | funct3 | offset[11|4|9:8|10|6|7|3:1|5] | opcode |
> +	 *     3                   11                    2
> +	 */
> +
> +	s32 offset;
> +
> +	offset  = ((opcode >> 3)  & 0x7) << 1;
> +	offset |= ((opcode >> 11) & 0x1) << 4;
> +	offset |= ((opcode >> 2)  & 0x1) << 5;
> +	offset |= ((opcode >> 7)  & 0x1) << 6;
> +	offset |= ((opcode >> 6)  & 0x1) << 7;
> +	offset |= ((opcode >> 9)  & 0x3) << 8;
> +	offset |= ((opcode >> 8)  & 0x1) << 10;
> +	offset |= ((opcode >> 12) & 0x1) << 11;
> +
> +	instruction_pointer_set(regs, addr + sign_extend32(offset, 11));
Can you use riscv_insn_insert_jtype_imm() from insn.h since it is
already created? It will also sign extend for you. Don't worry about
creating a similar function for the branches, I am in the process of
refactoring the insn.h file.
> +
> +	return true;
> +}
> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
> index 61e35db31001..4bd6c266e7d3 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.h
> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> @@ -24,5 +24,6 @@ bool simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
> +bool simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs);
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
Thanks,
Charlie
