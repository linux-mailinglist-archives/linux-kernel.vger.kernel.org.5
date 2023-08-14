Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3212C77BFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjHNSOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjHNSOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:14:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DD0E65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:14:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586bd766310so45100987b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692036855; x=1692641655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TcUt5zW6/E4ltHD2CEijny9mRikM7dBfVWLbZzVbJkw=;
        b=P+bgdAKyd45vaYQ61IXZt+f5Na0b7y3QK3JuZSBZ7HwukKMrVFeYlhwVPqn3ewsgS/
         bpg6NytGeHhTOvnKBWRPp3Wo8oN+fxuoiqSvHRRUmqnJ+vjNeZhpIn5OD+eH6eBlpQmZ
         Uh/US6O1IMyTLx51zMtFJ7fmAbVDu5udYFFCi32WCg7JKZNGCqs8OCrromX91CLCZgZa
         igYjZPgLfglv4IXbmy91wV4+nPGJeTU31IFlEJ0fiPqigXldgoxCoxtnZHRHkalgWLzT
         ZV+VnbqGoNwVuxQ1DmK337ZWpcaRlUS/i9O02NO485TfPIDkmtnkdGh++TMv4yx7n0mK
         MhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036855; x=1692641655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcUt5zW6/E4ltHD2CEijny9mRikM7dBfVWLbZzVbJkw=;
        b=F9CwhQvSFgpCHKio2POg0/XP4VZdL2Eq+JJC2JLRX4epv1YGRnG+dliXW8XVdW0UfW
         f93A5d2xx00V20+mkYupFzJV4MOlg9DU0SndfmFA0WD7ng9vZrdNP/BrB6pIfox5Pelg
         sRSGlGwcz8dJqzSXYtnPW8WoSXujEMyrAoCYCVdnRnz1XPDLZtWS491PRx24WrqHmIPl
         hmlPgpFKwf3T8aiiyLbSjVWLcixBZtNDKS8LyM/R3+1Q9tvtmOJv/5LJCJHWlGYyh2GD
         gvzX5WtOmyTlndhAxx1GAPazyYxTMYmvW8pWv72PxtuhLx34vgU09NgHtMqDA9OxPXpQ
         WCbg==
X-Gm-Message-State: AOJu0YyisM8b9DMxrZ4UC9btAVhWNlk56WB5jBqV5PnVV8WeHZi2h1Gt
        +utUd7NfmIAMYtjKtN7OzbpAOjedSoM=
X-Google-Smtp-Source: AGHT+IG9X7NdYXbyEcrVSHdTlTWKoUAZVUFnTX57K0tA4O3BInAE5p03f3vrkZO4ks4H7gKJuLR3Lc6UC9o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:e8d:0:b0:d42:42f8:93bf with SMTP id
 z13-20020a5b0e8d000000b00d4242f893bfmr150139ybr.0.1692036855263; Mon, 14 Aug
 2023 11:14:15 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:14:14 -0700
In-Reply-To: <20230810113853.98114-1-gaoshiyuan@baidu.com>
Mime-Version: 1.0
References: <20230810113853.98114-1-gaoshiyuan@baidu.com>
Message-ID: <ZNpu9qJOqLxG5pq4@google.com>
Subject: Re: [PATCH] KVM: VMX: Rename vmx_get_max_tdp_level to vmx_get_max_ept_level
From:   Sean Christopherson <seanjc@google.com>
To:     Shiyuan Gao <gaoshiyuan@baidu.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, Shiyuan Gao wrote:
> In vmx, ept_level looks better than tdp level and is consistent with
> svm get_npt_level().
> 
> Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index df461f387e20..f0cfd1f10a06 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3350,7 +3350,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>  	vmx->emulation_required = vmx_emulation_required(vcpu);
>  }
>  
> -static int vmx_get_max_tdp_level(void)
> +static int vmx_get_max_ept_level(void)
>  {
>  	if (cpu_has_vmx_ept_5levels())
>  		return 5;
> @@ -8526,7 +8526,7 @@ static __init int hardware_setup(void)
>  	 */
>  	vmx_setup_me_spte_mask();
>  
> -	kvm_configure_mmu(enable_ept, 0, vmx_get_max_tdp_level(),
> +	kvm_configure_mmu(enable_ept, 0, vmx_get_max_ept_level(),
>  			  ept_caps_to_lpage_level(vmx_capability.ept));

Anyone else have an opinion on this?  I'm leaning toward applying it, but a small
part of me also kinda likes the "tdp" name (though every time I look at this patch
that part of me gets even smaller...).
