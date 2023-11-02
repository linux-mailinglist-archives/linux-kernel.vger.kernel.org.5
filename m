Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3414B7DF9A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbjKBSLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjKBSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF25F2684
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zINgmLEM4y/IYGJ6cER3rWqUY+I7ZJgEaJpIssBF02I=;
        b=UA7lMKOiyvQDfdRicEt742ujfXLWlr7ua11StmOl44jh9aFjNw+l9zfxBTthDRg0jQo3QW
        RxpYA5Ghb4nFhvE3h3Bj6XWg68/DbtQ3C+pghFbCAwFNEbcWnyYd2C6L6jlXfjmmbIRkCs
        EQd1Fg6bFA1Hm345y9wL+ZarzcxIbGo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-uKbPN6CpPlqeYcgjPB8D6g-1; Thu, 02 Nov 2023 14:07:49 -0400
X-MC-Unique: uKbPN6CpPlqeYcgjPB8D6g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c53c85e482so13629001fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948468; x=1699553268;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zINgmLEM4y/IYGJ6cER3rWqUY+I7ZJgEaJpIssBF02I=;
        b=U3kt45pWDJx+/+36C3dYEiQQ5QFmSX7vXePw0JAv5NseTr2SI4yTYM3GtiYwQ7XVw4
         FHbQUbm5d+fR5sf1CQyyuyvaw+mf0uB0GO9B03DNWpSN/EfNJRnD12b0ai3aFU0lTCTQ
         18FE2nSnUm//nF2cmDrYChFbC42cS75ldwohCa22dWaWKFtiOFTsXuBPaD0O+RbI/uO4
         xjCh1b7si3QxOuB7B95b10VKDreFyE01fGt9yoCp1+gtTSbbku21UtWTsZAiO9krr0Ah
         RGCqqJvghBzNtTaonT0lRKgSpMgbGZ6MajJ6S/p5/WkvALpRr+iJH/KR2O+OtPMPJz7E
         3B0Q==
X-Gm-Message-State: AOJu0YzZwVp+yRWVqDs7vJveI0neVKD2UoAsRfp2YuI2WFo9yGxplvkg
        gwWsxhYm2P2VfPEQwsK3wT7pap/CQlW9dWFJrwZVb/z9XjGZ23dJgI/VAZEvbztgNNSok+2BfDr
        jZfa1bWOSuZmApQGhsIVxP9TM
X-Received: by 2002:a2e:b012:0:b0:2c6:eab4:84a6 with SMTP id y18-20020a2eb012000000b002c6eab484a6mr3426349ljk.48.1698948468251;
        Thu, 02 Nov 2023 11:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdUEjgS7PG9GhauxVXM5EOr3ap/D3wP5H6TRULsVzmP0fxfQq4HG2TkR3twytAokRXmT0GBg==
X-Received: by 2002:a2e:b012:0:b0:2c6:eab4:84a6 with SMTP id y18-20020a2eb012000000b002c6eab484a6mr3426341ljk.48.1698948468058;
        Thu, 02 Nov 2023 11:07:48 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4849000000b0032d8eecf901sm3078149wrs.3.2023.11.02.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:07:47 -0700 (PDT)
Message-ID: <1e8ae50b41418d7df2cc44e2bde8d8713132e5c2.camel@redhat.com>
Subject: Re: [PATCH 9/9] KVM: SVM: Add CET features to supported_xss
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        weijiang.yang@intel.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de
Date:   Thu, 02 Nov 2023 20:07:45 +0200
In-Reply-To: <20231010200220.897953-10-john.allen@amd.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-10-john.allen@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 20:02 +0000, John Allen wrote:
> If the CPU supports CET, add CET XSAVES feature bits to the
> supported_xss mask.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 00a8cef3cbb8..f63b2bbac542 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5151,6 +5151,10 @@ static __init void svm_set_cpu_caps(void)
>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
>  
> +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK))
> +		kvm_caps.supported_xss |= XFEATURE_MASK_CET_USER |
> +					  XFEATURE_MASK_CET_KERNEL;
> +
>  	if (enable_pmu) {
>  		/*
>  		 * Enumerate support for PERFCTR_CORE if and only if KVM has

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

