Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF7778CCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjH2TF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbjH2TFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:05:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D15DCE0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:04:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c3ec0578bso2195234b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693335897; x=1693940697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkhRA/lQC5h1Knqaf4HRNhdd9OJwWl6v8O5LTA25fgQ=;
        b=FPbi8VSGU8Jt8VNJDVnmiNKcqUS14FOYP4C668LaF1ubPunYULj38n1j+/VT1qLUMb
         SSaVYO87Ea8M9p9i0TCLKzmuGru1GlQ58Ek9Oh+ybJBxWSK0C7C0BQyUXBb0mJnfLEg5
         vib+2zxUZ3t+Cgmp7btZ2R1reXUcYzQ9EB6cY3tbwMk3vftqHfIkjAusXxtY4zpuvypU
         mIRV4Iii2c8YdI/CXg0g1xI91DUOpCc1S+gxsbwlxIIEXNAup+MJu94GrVXwAm3z/NYT
         JGCDt9hukI19PorheiUGDee7VxR/hNz7TJ6Dz3VXw9rUyfR1JlsKf9cO7bcKH4xdTup4
         mHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335897; x=1693940697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkhRA/lQC5h1Knqaf4HRNhdd9OJwWl6v8O5LTA25fgQ=;
        b=BxjUgLZTIvQ27iXSMhinu+BJqVe5cRs5NybTS+6FmFOUAMJ4hpPwnRrNlVAkgRBmqu
         W7XpWRjOfIwztfRj83X8vslCz3sRtQ4DU88N9oS9Aas591lArNLKcTdlyzSZ6cctwKV2
         xSM0YBKkDE0nGENFSnu6uCRvB011x5eZl1mwRAkcr5yqZwQ2y1P7ncN1tBEXP0PMz90u
         NNO7empLA8Fd9wnI1LOcIuRLCiMqDRvjouC0DKKDnoS8I+MI0yOT/oEaDQ5D0Le3o9N+
         0LpSk9ow3wWT182z/iU7enRyzoosl4xQYJHhC2HOZQscqKDydrAqaFTiLhM9K/oO/Rzv
         FoxQ==
X-Gm-Message-State: AOJu0YxG6NHqbMmx8tU15clubEntLqGqXVvACbzM+xxvKToF1oxdWnhG
        m72VpBSoJTBd8f5A2cerUOWb3Q==
X-Google-Smtp-Source: AGHT+IEmWzR2EFRVld8dtFg6O30X0kJHSic7sbU0n0pIaph9jOGM2LqjeEEvBi7SdfgiWpDGjX3Tww==
X-Received: by 2002:a17:90a:e015:b0:270:1611:484b with SMTP id u21-20020a17090ae01500b002701611484bmr105814pjy.41.1693335896703;
        Tue, 29 Aug 2023 12:04:56 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id gd9-20020a17090b0fc900b0026d034f6badsm9189710pjb.38.2023.08.29.12.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:04:56 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:04:53 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: kprobes: allow writing to x0
Message-ID: <ZO5BVWFbAwXLf0WS@ghost>
References: <20230829182500.61875-1-namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829182500.61875-1-namcaov@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 08:25:00PM +0200, Nam Cao wrote:
> Instructions can write to x0, so we should simulate these instructions
> normally.
> 
> Currently, the kernel hangs if an instruction who writes to x0 is
> simulated.
> 
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/kernel/probes/simulate-insn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> index d3099d67816d..6c166029079c 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -24,7 +24,7 @@ static inline bool rv_insn_reg_set_val(struct pt_regs *regs, u32 index,
>  				       unsigned long val)
>  {
>  	if (index == 0)
> -		return false;
> +		return true;
>  	else if (index <= 31)
>  		*((unsigned long *)regs + index) = val;
>  	else
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
Thank you for this change. 

simulate_auipc would previously fail with an rd = 0 which made sense
because auipc it is defined as a HINT in the riscv spec when rd = 0,
but QEMU and spike don't say it is an illegal instruction so I think
it is okay to make this change.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
