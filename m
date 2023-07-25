Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80CD761C47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGYOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGYOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:52:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C57E78
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:52:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0f35579901so6375884276.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690296728; x=1690901528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuswUUvQmlUzTdyahqM81yDJAxq5BDNLAyifzL2kDmw=;
        b=7enRUTFU36NlUV9k9d1LrREoh+PMOSydJcFHqM8HdWaoNOed7TBfam0E/XN0ZlxYSk
         4tmDx90iMpGViFu3k2dOrI7kt7F7JiNgFrj+RNcyVDf3Hv/YxtEm1OJRcfvvElOt2kaw
         iOdJL6cbiLfFdZ8bLmX7zwAJWQ32b/+TP5oyS2n6J7mUwa1huLnwQFScSv9ia0JQqMeM
         Ej8edqyM+Iqq9l++k1hKMa5Jh1/+2nDihG0RaQTghkMXCxPOhaXtTbDwOhdErn3xQG3G
         D3kyvvd9WhJz06j/rAEQPPwC3N4y/gBNo2O6x5esGTdPgmI6FxAQoJU7HFp3Ju74s6HW
         p3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296728; x=1690901528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuswUUvQmlUzTdyahqM81yDJAxq5BDNLAyifzL2kDmw=;
        b=KaDthRaJ/bz5xKKZ3pH5vYg+Gh4ejwyCbTSkG8rvVFcCRrJF+qGFG7gvG9aYpSx1Yq
         eg4NgyHyW5HKfrJa2GmX1vr0oRZPUE8CT1gf9IZ8l516vtMnvo2aRMu8Jn5+g5bz+viz
         ++ASc2PsQ8vjA+F7rBnEX9TGUZ26JFWpEfqtQs2X2K2CTTpqzuHzrP7eEQ0HQCAD3zXo
         cKqzSDfJR88RzF1HP6vxtBizCRW8OeS2feK+3ttONA4VfbthYNhyGQlhP3sfW3CIkdZY
         028dpNvaIVMT7+MADw/U/gnFtzakX9C9Aw6Gb0T46NJKHt/ILc982SqCUVVv3W1q3QAz
         uRcA==
X-Gm-Message-State: ABy/qLarN3teCNzlHSM9Ku24fitT6O6KyqMFEMC1ErJ6OLzbx6bMuUhw
        VHr+Yjwu610d1QdNHylO7gAEu9/vzdE=
X-Google-Smtp-Source: APBJJlHwdGIL3JCt/pfGQUNXJV+D65iPFoi1/mWhFsnklNLdam+UscJ1tOBOQQ3YxFKj5jbkaGWuXjffR6s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:521:b0:d11:3c58:2068 with SMTP id
 y1-20020a056902052100b00d113c582068mr30906ybs.2.1690296728331; Tue, 25 Jul
 2023 07:52:08 -0700 (PDT)
Date:   Tue, 25 Jul 2023 07:52:06 -0700
In-Reply-To: <20230725100844.3416164-1-foxywang@tencent.com>
Mime-Version: 1.0
References: <20230725100844.3416164-1-foxywang@tencent.com>
Message-ID: <ZL/hlrWFzrtcdcmH@google.com>
Subject: Re: [PATCH] kvm: vmx: fix a trivial comment in vmx_vcpu_after_set_cpuid()
From:   Sean Christopherson <seanjc@google.com>
To:     Yi Wang <up2wing@gmail.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanpengli@tencent.com, Yi Wang <foxywang@tencent.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023, Yi Wang wrote:
> The commit b6247686b7571 ("KVM: VMX: Drop caching of KVM's desired
> sec exec controls for vmcs01") renamed vmx_compute_secondary_exec_control()
> to vmx_secondary_exec_control(), but forgot to modify the comment.
> 
> Signed-off-by: Yi Wang <foxywang@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0ecf4be2c6af..26d62990fea7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7722,7 +7722,7 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  
> -	/* xsaves_enabled is recomputed in vmx_compute_secondary_exec_control(). */
> +	/* xsaves_enabled is recomputed in vmx_secondary_exec_control(). */
>  	vcpu->arch.xsaves_enabled = false;

I have an in-progress patch[*] that reworks this code and wipes out the stale
comment as a side effect.  Thank you though!

[*] https://lore.kernel.org/all/20230217231022.816138-4-seanjc@google.com
