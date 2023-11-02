Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3187DF9A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377124AbjKBSMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346483AbjKBSMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341C830DA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xV4OsSroeIKFiXRR8BxZ00kklBCCrfUOWbKM2Xj1GaY=;
        b=a6gX4r1oOHEqO2YxV/UCy9rLK4VDGt6T4VpkC2F+cQVhLtX5vhuuXkw2tGnkeNI+uoGwBx
        sM0bXxB73mmGv9z8T2N9H00kxUJWmEIQJFXngmEiOICJ5/1lcphk5XyCszEmzmuP3NUmhN
        X0++dyPAfGatrU5wNPby3/VsuBXTebQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-CQHeTWSfNcaRIARxfI8_Vg-1; Thu, 02 Nov 2023 14:07:23 -0400
X-MC-Unique: CQHeTWSfNcaRIARxfI8_Vg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4094d1e52daso7723165e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948442; x=1699553242;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xV4OsSroeIKFiXRR8BxZ00kklBCCrfUOWbKM2Xj1GaY=;
        b=Tl54+oVruYngMot4jkqxyPAY0XXgXxPVzVm7pvbryWDFay4ED91amoJDF/D7r2VCP/
         eGNagbZB/CG8tqIrkbCVO3JeCno+icxKn9PURYeSQ5f7d0rSZuP+rlXhDcU2yA8YvPKG
         IS7IrKuHFduCT7124gqvH6Uw/X+TLmWJMtQBMF8BJVrf2loFqby9M5h0ZzQrbZhbbrvQ
         IDkVxYujy0PNBf7J9QUbXydfCCRrrsBJC120m9d8QV7ScIznyo3oeFZpEBfslpPaZO6x
         6oPJ3UcV1xczGCPXV9GirbFW3/s1oI9j3V0Oselx0ryo2cjKPQqQ/06bNoDAaD5NSrP3
         +brA==
X-Gm-Message-State: AOJu0YxzoCG+JjqVz4d6S3Q+YuFDgPkMO8iR0K+POQD2h3AyZpV5efuV
        VF8/fOwiISuZltMns5IdH+kLBpC3Fv2tpe/x0x6flXrDIxR8+23XXBXHSPi+YmrSAe3J4x455+u
        M0jxJYNa4LCcW+STVkVdAd2Mi
X-Received: by 2002:a05:600c:1547:b0:406:81e9:ad0c with SMTP id f7-20020a05600c154700b0040681e9ad0cmr16827334wmg.41.1698948442748;
        Thu, 02 Nov 2023 11:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNupal50RfnLTDojuadiZN7cm9qZfL4/oN/Pr2H/7qmvna/zS0MMuJshH8pueYzIwAPLb+2Q==
X-Received: by 2002:a05:600c:1547:b0:406:81e9:ad0c with SMTP id f7-20020a05600c154700b0040681e9ad0cmr16827310wmg.41.1698948442416;
        Thu, 02 Nov 2023 11:07:22 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id er10-20020a05600c84ca00b00405bbfd5d16sm236543wmb.7.2023.11.02.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:07:22 -0700 (PDT)
Message-ID: <cc44a4a7e7a4cabacad76c875e50cc5ff19c6e23.camel@redhat.com>
Subject: Re: [PATCH 5/9] KVM: SVM: Save shadow stack host state on VMRUN
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        weijiang.yang@intel.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de
Date:   Thu, 02 Nov 2023 20:07:20 +0200
In-Reply-To: <20231010200220.897953-6-john.allen@amd.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-6-john.allen@amd.com>
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
> When running as an SEV-ES guest, the PL0_SSP, PL1_SSP, PL2_SSP, PL3_SSP,
> and U_CET fields in the VMCB save area are type B, meaning the host
> state is automatically loaded on a VMEXIT, but is not saved on a VMRUN.
> The other shadow stack MSRs, S_CET, SSP, and ISST_ADDR are type A,
> meaning they are loaded on VMEXIT and saved on VMRUN. PL0_SSP, PL1_SSP,
> and PL2_SSP are currently unused. Manually save the other type B host
> MSR values before VMRUN.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index b9a0a939d59f..bb4b18baa6f7 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3098,6 +3098,15 @@ void sev_es_prepare_switch_to_guest(struct sev_es_save_area *hostsa)
>  		hostsa->dr2_addr_mask = amd_get_dr_addr_mask(2);
>  		hostsa->dr3_addr_mask = amd_get_dr_addr_mask(3);
>  	}
> +
> +	if (boot_cpu_has(X86_FEATURE_SHSTK)) {
> +		/*
> +		 * MSR_IA32_U_CET and MSR_IA32_PL3_SSP are restored on VMEXIT,
> +		 * save the current host values.
> +		 */
> +		rdmsrl(MSR_IA32_U_CET, hostsa->u_cet);
> +		rdmsrl(MSR_IA32_PL3_SSP, hostsa->pl3_ssp);
> +	}
>  }


Do we actually need this patch?

Host FPU state is not encrypted, and as far as I understood from the common CET patch series,
that on return to userspace these msrs will be restored.

Best regards,
	Maxim Levitsky


PS: AMD's APM is silent on how 'S_CET, SSP, and ISST_ADDR' are saved/restored for non encrypted guests.
Are they also type A?

Can the VMSA table be trusted in general to provide the same swap type as for the non encrypted guests?


>  
>  void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)


