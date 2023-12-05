Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C20804EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbjLEJxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbjLEJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE09E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701770010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ru2Q8LqNVd+OfIoZSkL+gRLJdnRdSfTo4OU5DPaWpec=;
        b=PDYoYaR0gMfqm8nCz99VnvoGVsdMZPpgrdy8aeSR/uK4m04pkzTqqDtJ8EUuRtAIumTAtL
        PHsqjKDkl++hJjC6g8PUoxMKZYdg/0H5hipE9HoJdaJ5kdx5cWuctMCTqhAuipGfrSweZ6
        /AAwqjjxtE4quNZRGeY8qMqD+VJj/eA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-z_N53KYgPZ2Yzty2P_iCcw-1; Tue, 05 Dec 2023 04:53:28 -0500
X-MC-Unique: z_N53KYgPZ2Yzty2P_iCcw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b3dbe99d9so42352125e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770007; x=1702374807;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ru2Q8LqNVd+OfIoZSkL+gRLJdnRdSfTo4OU5DPaWpec=;
        b=LbUKoHXvV8aPSp/B8kLk6EWufYE+39yCazs/tRjGjCxC89pIqoJho8tGxyL2GiMDF1
         srr5NgT06yHQt0CZL55fMtIlmSQiUXbzSkF1RJf8u/nxjYKij0Pk509sUxXAJQAMFNV9
         P48KCiIbGVyVmJYF7GBsxyyy+PgxSz1atAPilhd6UK3O1LvX8J3oWVZ1ecoaN4Zfv7uP
         fPE8mj5RUpQSock2h6WR4HvEs+8rgF4xIU13R57d9tUtdf+uEMqgaKUkhJJsa/a4dvYH
         wV2ONxSe+rZcCKfpuaNwZP+z5E3qS/S8eY/T88GrY6Pz+aPHgiFsNFufQW6wHeQCfBDn
         5MhQ==
X-Gm-Message-State: AOJu0YzeKqXLZPwYyPLy34LP7RWmH4wjYz343McoKe93p6YHSc876ZQZ
        8Cwaz+GYp/4ncl2M7rJpU05XpDEJqTg46koqry/yONJoHeNt46Cr54th8Pqb3h0CJZjnfwnZyyA
        mrz9elupqg4jYv4rHbrAcQRt3
X-Received: by 2002:a05:600c:4688:b0:40a:20f3:d127 with SMTP id p8-20020a05600c468800b0040a20f3d127mr311556wmo.35.1701770007511;
        Tue, 05 Dec 2023 01:53:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUDPgWhFuD8g2XSbmPMaubU5h6S01wzv1LcabCc79waLe3iLvsP33xawM6QP4GRaBOLDkfxw==
X-Received: by 2002:a05:600c:4688:b0:40a:20f3:d127 with SMTP id p8-20020a05600c468800b0040a20f3d127mr311544wmo.35.1701770007169;
        Tue, 05 Dec 2023 01:53:27 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id c12-20020a056000104c00b00333339e5f42sm10701380wrx.32.2023.12.05.01.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:53:26 -0800 (PST)
Message-ID: <20d45cb6adaa4a8203822535e069cdbbf3b8ba2d.camel@redhat.com>
Subject: Re: [PATCH v7 02/26] x86/fpu/xstate: Refine CET user xstate bit
 enabling
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dave.hansen@intel.com, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 05 Dec 2023 11:53:24 +0200
In-Reply-To: <cdf53e44-62d0-452d-9c06-5c2d2ce3ce66@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-3-weijiang.yang@intel.com>
         <c22d17ab04bf5f27409518e3e79477d579b55071.camel@redhat.com>
         <cdf53e44-62d0-452d-9c06-5c2d2ce3ce66@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 14:51 +0800, Yang, Weijiang wrote:
> On 12/1/2023 1:26 AM, Maxim Levitsky wrote:
> > On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> > > Remove XFEATURE_CET_USER entry from dependency array as the entry doesn't
> > > reflect true dependency between CET features and the user xstate bit.
> > > Enable the bit in fpu_kernel_cfg.max_features when either SHSTK or IBT is
> > > available.
> > > 
> > > Both user mode shadow stack and indirect branch tracking features depend
> > > on XFEATURE_CET_USER bit in XSS to automatically save/restore user mode
> > > xstate registers, i.e., IA32_U_CET and IA32_PL3_SSP whenever necessary.
> > > 
> > > Note, the issue, i.e., CPUID only enumerates IBT but no SHSTK is resulted
> > > from CET KVM series which synthesizes guest CPUIDs based on userspace
> > > settings,in real world the case is rare. In other words, the exitings
> > > dependency check is correct when only user mode SHSTK is available.
> > > 
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > ---
> > >   arch/x86/kernel/fpu/xstate.c | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > > index 73f6bc00d178..6e50a4251e2b 100644
> > > --- a/arch/x86/kernel/fpu/xstate.c
> > > +++ b/arch/x86/kernel/fpu/xstate.c
> > > @@ -73,7 +73,6 @@ static unsigned short xsave_cpuid_features[] __initdata = {
> > >   	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
> > >   	[XFEATURE_PKRU]				= X86_FEATURE_OSPKE,
> > >   	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
> > > -	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
> > >   	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
> > >   	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
> > >   };
> > > @@ -798,6 +797,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
> > >   			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
> > >   	}
> > >   
> > > +	/*
> > > +	 * CET user mode xstate bit has been cleared by above sanity check.
> > > +	 * Now pick it up if either SHSTK or IBT is available. Either feature
> > > +	 * depends on the xstate bit to save/restore user mode states.
> > > +	 */
> > > +	if (boot_cpu_has(X86_FEATURE_SHSTK) || boot_cpu_has(X86_FEATURE_IBT))
> > > +		fpu_kernel_cfg.max_features |= BIT_ULL(XFEATURE_CET_USER);
> > > +
> > >   	if (!cpu_feature_enabled(X86_FEATURE_XFD))
> > >   		fpu_kernel_cfg.max_features &= ~XFEATURE_MASK_USER_DYNAMIC;
> > >   
> > I am curious:
> > 
> > Any reason why my review feedback was not applied even though you did agree
> > that it is reasonable?
> 
> My apology! I changed the patch per you feedback but found XFEATURE_CET_USER didn't
> work before sending out v7 version, after a close look at the existing code:
> 
>          for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
>                  unsigned short cid = xsave_cpuid_features[i];
> 
>                  /* Careful: X86_FEATURE_FPU is 0! */
>                  if ((i != XFEATURE_FP && !cid) || !boot_cpu_has(cid))
>                          fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
>          }
> 
> With removal of XFEATURE_CET_USER entry from xsave_cpuid_features, actually
> above check will clear the bit from fpu_kernel_cfg.max_features. 

Are you sure about this? If we remove the XFEATURE_CET_USER from the xsave_cpuid_features,
then the above loop will not touch it - it loops only over the items in the xsave_cpuid_features
array.

What I suggested was that we remove the XFEATURE_CET_USER from the xsave_cpuid_features
and instead do this after the above loop.

if (!boot_cpu_has(X86_FEATURE_SHSTK) && !boot_cpu_has(X86_FEATURE_IBT))
   fpu_kernel_cfg.max_features &= ~BIT_ULL(XFEATURE_CET_USER);

Which is pretty much just a manual iteration of the loop, just instead of checking
for absence of single feature, it checks that both features are absent.

Best regards,
	Maxim Levitsky


> So now I need
> to add it back conditionally.
> Your sample code is more consistent with existing code in style, but I don't want to
> hack into the loop and handle XFEATURE_CET_USER specifically.  Just keep the handling
> and rewording the comments which is also straightforward.
> 
> > 
> > https://lore.kernel.org/lkml/c72dfaac-1622-94cf-a81d-9d7ed81b2f55@intel.com/
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 




