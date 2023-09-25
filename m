Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C305E7AD397
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjIYIlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjIYIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:41:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1F5C4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:41:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8bba8125so775711766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695631287; x=1696236087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nZM1wjScMD2Az3LPRwqpKiggBr0NlZk5J18HvgucsI=;
        b=X47QOaPHGKcV7O6PQYiYiUsO072ErhBhaNtOvLWc3zE5t/0jHcL8zIgsRhDctxl9I2
         0YqKDcFTbL/rz9kmPatiMg1NPn24HjTSTOePv+MYF20i7DEZLMESsjrRD3d/t9P7qeyN
         +V+a+kpcdkjnEH6OQsEZiaS6TZCesB+011sK1zi33/rz6jCtCEhfJI1cJq7rJwhF1rNN
         hYYWd32z75vYFb9oyIVOc6bHGVcnaMB+lkD+ZsWTJK0UP3UUtgkDISmdc49dln70NXx8
         Iz5/oXDFL/3z+Pl1D++t/PLqBMxzgO3IgW1H28dTvevYbD5rAB55wWtyqV8NlL4y341b
         FWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631287; x=1696236087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nZM1wjScMD2Az3LPRwqpKiggBr0NlZk5J18HvgucsI=;
        b=NCQPreBFxDUHKsrXnvXw3/cpPoHAGJZJxqda3JKSH5gZgN+/y/OMut1udUMc3yG1f/
         6PmsjTpyZn4h+sospA3BfBh/YuUl6uoDLkww/job+b8lJ/D8qMII1difvSfbo//mWjNk
         aK73BRZEQiwgcy67gaMvlH7oNGI8zKw3EjrQHaevTzdsHwDjO/p2/g1Dhqq9bnYNNXNo
         YEyY2ntYmbwuD2va6YDk47bJjac/auxsQ3tefmzRdrVmGA+gOSywvNMYOj2uhaoV2OiU
         yegO8dtCM1A5d5vYJ7ZmFhQyb3DJFXFkfKc1oqqCSMF5vh5CDKufrFrV4r97ogcpscSc
         JMKA==
X-Gm-Message-State: AOJu0Yz9vHS1eQ4rJfCKgJVS1Fw1jMVVVPLt0PsJ7Ymb4UO2jRliB3IZ
        We/i7166vg4uhgRd4+yG+Mw=
X-Google-Smtp-Source: AGHT+IE97aDC9pNM5/oAHpLAXFsIDcfeHVEMTKLED3XZ88HKiUyF5K0qTPkmyKMrTGca3vJu0hXPEg==
X-Received: by 2002:a17:906:cc0c:b0:9ae:6355:6435 with SMTP id ml12-20020a170906cc0c00b009ae63556435mr6059333ejb.15.1695631286890;
        Mon, 25 Sep 2023 01:41:26 -0700 (PDT)
Received: from gmail.com (195-38-113-94.pool.digikabel.hu. [195.38.113.94])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906591500b0099bd0b5a2bcsm5978408ejq.101.2023.09.25.01.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:41:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 25 Sep 2023 10:41:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <ZRFHtCCsL4kKajKF@gmail.com>
References: <20230925042302.593317-1-aik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925042302.593317-1-aik@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Kardashevskiy <aik@amd.com> wrote:

> For certain intercepts an SNP guest uses the GHCB protocol to talk to
> the hypervisor from the #VC handler. The protocol requires a shared page so
> there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
> handler triggers a #VC, there is another "backup" GHCB page which stores
> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
> The vc_raw_handle_exception() handler manages main and backup GHCB pages
> via __sev_get_ghcb/__sev_put_ghcb.
> 
> This works fine for #VC and occasional NMIs. This does not work so fine if
> the #VC handler causes intercept + another #VC, if NMI arrives during
> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
> The problem place is the #VC CPUID handler. Running perf in the SNP guest
> crashes with:
> 
> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use
> 
> vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1
> We lock the main GHCB and while it is locked we get to
> snp_cpuid_postprocess() which executes "rdmsr" of MSR_IA32_XSS==0xda0 which
> triggers:
> 
> vc_raw_handle_exception #2: exit_code 7c (MSR) ecx da0
> Here we lock the backup ghcb.
> 
> And then PMC NMI comes which cannot complete as there is no GHCB page left
> to use:
> 
> CPU: 5 PID: 566 Comm: touch Not tainted 6.5.0-rc2-aik-ad9c-g7413e71d3dcf-dirty #27
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
> Call Trace:
>  <NMI>
>  dump_stack_lvl+0x44/0x60
>  panic+0x222/0x310
>  ____sev_get_ghcb+0x21e/0x220
>  __sev_es_nmi_complete+0x28/0xf0
>  exc_nmi+0x1ac/0x1c0
>  end_repeat_nmi+0x16/0x67
> ...
>  </NMI>
>  <TASK>
>  vc_raw_handle_exception+0x9e/0x2c0
>  kernel_exc_vmm_communication+0x4d/0xa0
>  asm_exc_vmm_communication+0x31/0x60
> RIP: 0010:snp_cpuid+0x2ad/0x420
> 
> Drop one #VC by replacing "rdmsr" with GHCB's VMGEXIT to read the value from
> the hypervisor.
> 
> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
> Cc: x86@kernel.org
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
> 
> This is made on top of (which has the "efi/unaccepted: Make sure unaccepted table is mapped"
> fix for booting SNP):
> b996cbe1203c (tip/master) 15 hours ago Ingo Molnar Merge branch into tip/master: 'x86/tdx'
> 
> plus:
> https://lore.kernel.org/lkml/a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com/
> ---
>  arch/x86/kernel/sev-shared.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index e73c90c9cc5b..399219de5a9b 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -477,11 +477,19 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  		if (leaf->subfn == 1) {
>  			/* Get XSS value if XSAVES is enabled. */
>  			if (leaf->eax & BIT(3)) {
> -				unsigned long lo, hi;
> -
> -				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
> -						     : "c" (MSR_IA32_XSS));
> -				xss = (hi << 32) | lo;
> +				/*
> +				 * Since we're here, it is SNP and rdmsr will trigger
> +				 * another #VC and waste one of just two GHCB pages.
> +				 * Skip the intercept and do direct hypercall.
> +				 */
> +				ghcb_set_rcx(ghcb, MSR_IA32_XSS);
> +				if (sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0) != ES_OK)
> +					return -EINVAL;
> +
> +				xss = (ghcb->save.rdx << 32) | ghcb->save.rax;
> +
> +				/* Invalidate qwords for likely another following GHCB call */
> +				vc_ghcb_invalidate(ghcb);

Ok, so I agree with this fix, but could you please reduce the ugliness
of this open-coded RDMSR by factoring out this sequence into a new
helper, called rdmsr_GHCB() or so, with a similar signature as
rdmsr(), where rdmsr_GHCB() emulates RDMSR behavior via a hypercall?

That makes this workaround to reduce nesting a lot easier to read & maintain
in the longer run.

Thanks,

	Ingo
