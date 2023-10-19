Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567B57D0563
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbjJSX2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjJSX2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:28:07 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A9119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:28:06 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b7179ff4easo199429a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697758085; x=1698362885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOmP8c5NeeH7TXcXaN2HrwkjPkwyGFnNq0SijEHuFgE=;
        b=RoRvil4TJtnHo2SeBus3MFbxC3BHtsZ+wpc4SjxxEb7xnKmfWGxc8ZxobJzIL312Kx
         tQeanAhGMrIDCdQbjBhSM3BQ5BSFQng4SXZ7BVDqYdOnGreWzJRYS55J5B55Gfi6V9Nf
         t1LCV/ZxFHi7e2qV/cyPr9re2ye4plxsCCzeOcqZv0pvepgiapzBB9ZED9DZCf8D672X
         muOHGhFnt1QZdecK5G7eS2/lKU0Kp6aLiJESKcfVW91eCL0Prfz1pThXnzgOU7+WsG8v
         naNbNXgh2WvUcfBjvmtf/cackSCgmGcRT9X5dG0jsHf/4Zei/wCaFxy1+4KJtJijFRLA
         7vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697758085; x=1698362885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOmP8c5NeeH7TXcXaN2HrwkjPkwyGFnNq0SijEHuFgE=;
        b=NeVZFMv3T8LsIk2cmOXMC+qHofVkErSeb5pSH+FkCS9LNpARHY1n1RQsHmAD51P/rK
         vlqFXCAjjwsI0/ck7onTNx3NG123s85+dKwIGISF0NgbMyoXfUgaEUBblOMsTPbDBdFT
         pPtnhzBvC5dAEOa/Ak+1hjeNu5WTzqf5DhO0UmvrwvAkKIbwdmo5QJbeAii17VLZBWH/
         CT865ckDU8bCKUtBcuUK3bzAENBuzfxkn+gLs0WxDCKNOISO3QMvW4xMCrgCepOup59O
         FuTUxRwcT0d7/PbqIQDMB4sXEpZVp/XVOnyS0wAZuADANxPvSledpSuynNYHmgsB5C0V
         HcCA==
X-Gm-Message-State: AOJu0Yyzk2OKgZhc3laiuDQl43LxFq2YSSUgRf1HY3fMUttj9KRPxHgM
        /OIqDqRiNhPm/o3NkOLrUS85L1Tr1Cs=
X-Google-Smtp-Source: AGHT+IH8Q4XvOBKeGesjh2tb2no8ri27Cqj7zrJ6/8fyIzUPHsWTfMLWnCrsI2XRDTMoThWz7GyYdqVeBVQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1f59:0:b0:5b5:5e20:b802 with SMTP id
 q25-20020a631f59000000b005b55e20b802mr2138pgm.0.1697758085515; Thu, 19 Oct
 2023 16:28:05 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:28:03 -0700
In-Reply-To: <20230911114347.85882-2-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230911114347.85882-1-cloudliang@tencent.com> <20230911114347.85882-2-cloudliang@tencent.com>
Message-ID: <ZTG7g7__AgUBbWIk@google.com>
Subject: Re: [PATCH v4 1/9] KVM: selftests: Add vcpu_set_cpuid_property() to
 set properties
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Like Xu <likexu@tencent.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add vcpu_set_cpuid_property() helper function for setting properties,
> which simplifies the process of setting CPUID properties for vCPUs.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h       |  4 ++++
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 4fd042112526..6b146e1c6736 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -973,6 +973,10 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
>  
>  void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr);
>  
> +void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
> +			     struct kvm_x86_cpu_property property,
> +			     uint32_t value);

The vcpu_set_cpuid_maxphyaddr() helper right above this can and should be converted
as part of this patch.  X86_PROPERTY_MAX_PHY_ADDR is already defined, i.e. it's a
trivial conversion, and that way there's an immediate user of the the new helper.
