Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516F7774FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHIAFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjHIAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:05:03 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD171986
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:05:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565334377d0so85510a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691539502; x=1692144302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0frE2f0ZwmwDpwGntxAbYu1s68vRKA54Dy0bxFno04U=;
        b=GuM9mr85ilFJlInrXd6nystKeoCGRZAkEDwAnLldE9vyoHURH4Wcz8gWeUhOvhLpcy
         84TVATmPvfSoFszG2SrtpDg9Co3zoB6sds0IKptQXozWwZLb1xi/PPk/WsApOt7tLSJZ
         w1je6C0uRZ9c+8N5bfSasMpdQRZRitBLT8yios04wyZb6rMYG+KG3WjDr0GTqpvcj7nv
         YgOF3hmEnLXD7npICqG9R6AH3kAPxKEXRYubcF8gEYG3QHTysHv5Alrs6wht97PBxDNJ
         vNrpMrcPteFtbJkgfdoo6WkNtZE+ukHGAewrbfcw9WNydObs4G4HS+h5TCUyJRgTX7PZ
         8roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539502; x=1692144302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0frE2f0ZwmwDpwGntxAbYu1s68vRKA54Dy0bxFno04U=;
        b=lPXYB34VmFV5c1mZXO7Xk/4kjqIKsMmpJOPovg6G4hE/+gMqAATVrWKQqoSfXgdjI6
         /ZG5g1aS8Phb2lbs5zecUGq6TC16sK13Bw9TwOjPJxuWdaeBL/G9qGVsa5KRKcn5TKb8
         Sv4fzxPMrXRTXxHkyueKpYePcReBxkrrCTxy2/MtabpPXJwdexeRpwAuaTmM0m+Lu4iX
         bcIHFB/YZ+mcGWjlghsRD6kOqBfk7TQTXleVUwSkBUK6FxTwRP0t1BuJMDaC7SQkvPeF
         dJ77XrRl/MBc3OSkzC29JyV2xhiH+lxSfTKTm42XwI/NfP29GjgSoev4NMThK1OcHGfI
         KE9g==
X-Gm-Message-State: AOJu0Ywzrp46FCM0Zmjg7dQRX6nrczwYfzLP9v2C84Az4T+jz9ECAAo/
        7k/kuT6dbj2QuGSNTpwf2gulyA==
X-Google-Smtp-Source: AGHT+IGSSXwefr0+64H0kQkpXvTdBuqS8Z5UjODkmDhotkSB2RHkwLkDVHZfodi9zPHyCKzIWF3R8w==
X-Received: by 2002:a17:90a:8a0f:b0:269:303f:8fec with SMTP id w15-20020a17090a8a0f00b00269303f8fecmr904984pjn.42.1691539502157;
        Tue, 08 Aug 2023 17:05:02 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id az9-20020a17090b028900b00263f5ac814esm108984pjb.38.2023.08.08.17.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:05:01 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:04:59 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: correct riscv_insn_is_c_jr() and
 riscv_insn_is_c_jalr()
Message-ID: <ZNLYK/efGcZ0uSyN@ghost>
References: <20230731183925.152145-1-namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731183925.152145-1-namcaov@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 08:39:25PM +0200, Nam Cao wrote:
> The instructions c.jr and c.jalr must have rs1 != 0, but
> riscv_insn_is_c_jr() and riscv_insn_is_c_jalr() do not check for this. So,
> riscv_insn_is_c_jr() can match a reserved encoding, while
> riscv_insn_is_c_jalr() can match the c.ebreak instruction.
> 
> Rewrite them with check for rs1 != 0.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/include/asm/insn.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 4e1505cef8aa..fce00400c9bc 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -110,6 +110,7 @@
>  #define RVC_INSN_FUNCT4_OPOFF	12
>  #define RVC_INSN_FUNCT3_MASK	GENMASK(15, 13)
>  #define RVC_INSN_FUNCT3_OPOFF	13
> +#define RVC_INSN_J_RS1_MASK	GENMASK(11, 7)
>  #define RVC_INSN_J_RS2_MASK	GENMASK(6, 2)
>  #define RVC_INSN_OPCODE_MASK	GENMASK(1, 0)
>  #define RVC_ENCODE_FUNCT3(f_)	(RVC_FUNCT3_##f_ << RVC_INSN_FUNCT3_OPOFF)
> @@ -245,8 +246,6 @@ __RISCV_INSN_FUNCS(c_jal, RVC_MASK_C_JAL, RVC_MATCH_C_JAL)
>  __RISCV_INSN_FUNCS(auipc, RVG_MASK_AUIPC, RVG_MATCH_AUIPC)
>  __RISCV_INSN_FUNCS(jalr, RVG_MASK_JALR, RVG_MATCH_JALR)
>  __RISCV_INSN_FUNCS(jal, RVG_MASK_JAL, RVG_MATCH_JAL)
> -__RISCV_INSN_FUNCS(c_jr, RVC_MASK_C_JR, RVC_MATCH_C_JR)
> -__RISCV_INSN_FUNCS(c_jalr, RVC_MASK_C_JALR, RVC_MATCH_C_JALR)
>  __RISCV_INSN_FUNCS(c_j, RVC_MASK_C_J, RVC_MATCH_C_J)
>  __RISCV_INSN_FUNCS(beq, RVG_MASK_BEQ, RVG_MATCH_BEQ)
>  __RISCV_INSN_FUNCS(bne, RVG_MASK_BNE, RVG_MATCH_BNE)
> @@ -273,6 +272,18 @@ static __always_inline bool riscv_insn_is_branch(u32 code)
>  	return (code & RV_INSN_OPCODE_MASK) == RVG_OPCODE_BRANCH;
>  }
>  
> +static __always_inline bool riscv_insn_is_c_jr(u32 code)
> +{
> +	return (code & RVC_MASK_C_JR) == RVC_MATCH_C_JR &&
> +	       (code & RVC_INSN_J_RS1_MASK) != 0;
> +}
> +
> +static __always_inline bool riscv_insn_is_c_jalr(u32 code)
> +{
> +	return (code & RVC_MASK_C_JALR) == RVC_MATCH_C_JALR &&
> +	       (code & RVC_INSN_J_RS1_MASK) != 0;
> +}
> +
>  #define RV_IMM_SIGN(x) (-(((x) >> 31) & 1))
>  #define RVC_IMM_SIGN(x) (-(((x) >> 12) & 1))
>  #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
> -- 
> 2.34.1
> 
Good catch. You can add:

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
