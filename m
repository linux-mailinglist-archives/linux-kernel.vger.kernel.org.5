Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4380F098
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376940AbjLLP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376867AbjLLP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:27:47 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE1138
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:27:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d33751a322so2763065ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702394867; x=1702999667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ6xyLlDqP2HzhoisoMpXYUdm7Lsr0C0A2wp2zF5kO8=;
        b=NtYTEJvpIInPuiK1P400P2OKYM+/1HhFnmXNfTUUD0LTOXR3EcXW2q/VF/2xSx8PHl
         +MBHA1nCt+twQcr0oP9/k/fIp9AAJdABnxTFEK2i8JSYPvylqEd9wYiUmJxajGOdw7ZX
         pGeqCKsB6Fb5z4+XWvJemeYGCcnsfBKTztyq0S2CLvGVJ4PFUBrBFTVSrN1JX2kLidw6
         0YMLRYfDr5JCUmC72XU922oHvEliODPFxOdVhSc8mk2F60E4ADTopm+fh6e6UMeWdYn4
         LnAITHss40shGX4VC5sN/SV91r/sinQ8fJvWy5/3IUwwqAkaMv6GTNDSzfnRxuhbJmZ0
         CToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394867; x=1702999667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ6xyLlDqP2HzhoisoMpXYUdm7Lsr0C0A2wp2zF5kO8=;
        b=A1/UW6lN1CsRpU/QYYCKun/1F1QWrxRd5+LJgq7n3pBu0Es04bNipXLTTK6gLj5Sgj
         rJwGKrK8a50ctsGkhxiX49KgNrqWhWyFs9Q6ik3pAfmT+E1z+cwVkehStH9vBNLPUvZx
         mnU2ChzPOiABa+R8DLMdtT+X1DQVQhRlMocKAsgQvfimekgtPLHGEryJH4LCUnZA40mB
         OqoLDL5J8g9nzqR6TgdoCCIUVbJb/RWnTLnk6TYLrZMdGgPsNhPHlfRI0Oeicg3n2w08
         FOmB+6/81nDp5x9lmeo5vwI2xcrWFs1VLHFOXHu421U8JnpoU7yziM3J9itV7GD6wCvY
         1T6A==
X-Gm-Message-State: AOJu0Yww05LUzPQz1+QBCFFNYws/7MBLdg7LToeZmoZB6hz34tsPe8cA
        0/26sJlIOoW9+/+gOrl5Q0acjpp4SKg=
X-Google-Smtp-Source: AGHT+IF4zAbXwYb4+IXMcu495kEYZwrX7tw6+iGcHG9KiTeZyGMfQkHxjPCXE4yUrFFiRWQdoFDwM2Qpflw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ecc2:b0:1d0:53f6:b590 with SMTP id
 a2-20020a170902ecc200b001d053f6b590mr51464plh.8.1702394866819; Tue, 12 Dec
 2023 07:27:46 -0800 (PST)
Date:   Tue, 12 Dec 2023 07:27:45 -0800
In-Reply-To: <20231207001142.3617856-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20231207001142.3617856-1-dionnaglaze@google.com>
Message-ID: <ZXh78TApz80DAWUb@google.com>
Subject: Re: [PATCH] kvm: x86: use a uapi-friendly macro for BIT
From:   Sean Christopherson <seanjc@google.com>
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com
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

On Thu, Dec 07, 2023, Dionna Glaze wrote:
> Change uapi header uses of BIT to instead use the uapi/linux/const.h bit
> macros, since BIT is not defined in uapi headers.
> 
> The PMU mask uses _BITUL since it targets a 32 bit flag field, whereas
> the longmode definition is meant for a 64 bit flag field.
> 
> Cc: Sean Christophersen <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 1a6a1f987949..a8955efeef09 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -7,6 +7,7 @@
>   *
>   */
>  
> +#include <linux/const.h>
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
>  #include <linux/stddef.h>
> @@ -526,7 +527,7 @@ struct kvm_pmu_event_filter {
>  #define KVM_PMU_EVENT_ALLOW 0
>  #define KVM_PMU_EVENT_DENY 1
>  
> -#define KVM_PMU_EVENT_FLAG_MASKED_EVENTS BIT(0)
> +#define KVM_PMU_EVENT_FLAG_MASKED_EVENTS _BITUL(0)

It's not just BIT(), won't BIT_ULL() and GENMASK_ULL() also be problematic?  And
sadly, I don't see an existing equivalent for GENMASK_ULL().
