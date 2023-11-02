Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58FF7DF99A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjKBSK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjKBSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF0E1B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIFznvQlxk51k3f904KCSD64BoprihpIPN0Cj8duUj0=;
        b=MeZyCA/J46OlSxW6otdFlxFCRxivhcYeUMjmn6fDL7qMCf1mdEcCfN4mJ7GCXjXyMJwxi3
        Kb/N80Erfl7AWvwqJSiGv4pxk23hsP0SnoUQoeYeb6NmL1hBs1xf2S89srMoiy3kxeP4Ar
        fmjbICWHECfp2d4ZyKvKWVMyLIxs9J8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-E6oTF7gqNZucZyfzucrHfA-1; Thu, 02 Nov 2023 14:07:39 -0400
X-MC-Unique: E6oTF7gqNZucZyfzucrHfA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f7cf9c33bso609030f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948458; x=1699553258;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIFznvQlxk51k3f904KCSD64BoprihpIPN0Cj8duUj0=;
        b=OrcfQzMtlq0hbv6gDj8+SxrxpCb6QrmHJPRqi6fm10c+mgJYLa69WEseax7WNLV9QE
         kJdfQzT5UCC2W6xyD2pz8jg7Cz37sfDIoKjYKhzFNLGEhzj/m3O5QZJw27LvAohXUlKg
         fGvxzTKZTeIBDXCqoQVrnvNd6wB10OZnUQa84bmBMtHfUqQEXeLcGrl/rsSeiV8E1ujy
         6m83tRcmaDe8eMf2g/do9fLQzzKEExpXt/d0Qe2mrcWVJkQmP6+kfpqZMVeoZwt/c7l4
         CXObbSbsV1fJdWOMF1HuJngz7G/8idSo/Q3D6Kx8OKLRNLSmx4VE2DCxlXKjZYSMOFLY
         1PVw==
X-Gm-Message-State: AOJu0Yxv8PI/kr2+huy+D2fFcxf5z2JFSIpYZyV45VNOYcI25+f2Swaz
        XiY/r2wfVX5hJUjLxpsJ77Xj6QMgKA0R/EJLrUY8yJorTGpBfbYVXIuo4jNW+42grdLOsZqG2JF
        Pv+z6fu4m4qO1vw67S0ieNgzK
X-Received: by 2002:adf:ef02:0:b0:32d:a688:8813 with SMTP id e2-20020adfef02000000b0032da6888813mr14611596wro.32.1698948458077;
        Thu, 02 Nov 2023 11:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDOc+TH+n8PNZsR7qYgqGWsihlIO9CVD2E86cBDK98UHrTnMH3KOjuJbGY69nHoE8ayCu1Dw==
X-Received: by 2002:adf:ef02:0:b0:32d:a688:8813 with SMTP id e2-20020adfef02000000b0032da6888813mr14611578wro.32.1698948457782;
        Thu, 02 Nov 2023 11:07:37 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d60c4000000b0031aef72a021sm3020841wrt.86.2023.11.02.11.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:07:37 -0700 (PDT)
Message-ID: <963fbc8076172bd430621446070cfd6ca8f165b8.camel@redhat.com>
Subject: Re: [PATCH 8/9] KVM: SVM: Use KVM-governed features to track SHSTK
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        weijiang.yang@intel.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de
Date:   Thu, 02 Nov 2023 20:07:35 +0200
In-Reply-To: <20231010200220.897953-9-john.allen@amd.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-9-john.allen@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 20:02 +0000, John Allen wrote:
> Use the KVM-governed features framework to track whether SHSTK can be by
> both userspace and guest for SVM.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ee7c7d0a09ab..00a8cef3cbb8 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4366,6 +4366,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VGIF);
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VNMI);
> +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_SHSTK);
>  
>  	svm_recalc_instruction_intercepts(vcpu, svm);
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

