Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89A47E5AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjKHQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKHQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:15:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD631FE1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:15:21 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc5ef7e815so49798385ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699460121; x=1700064921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkv2aSpFw25Sjc2pDxCz5exBlHcYk4gTYVmkV2GOyQs=;
        b=jmM381QoHM6/g0FB4YGETIBR5O3J1Dych7X+lotMdYThzDNuBSm38Bvy2TsfZPUuBz
         LzlpsoZeXenCsP0R9cO1z5mCRUWbfMliqX3Z3O7dCfsTunpZ30Cgf3LrGqt/mpzbZSbW
         O46em/jCPUWIkZdsHEfghHGMlEzU+D2q9+JXzOIJcLoFDjOuitCNXbMB6+FW+S0LNsxc
         F5WUZwqo/HTJJeTLt/A3/SNIOAkpsY83aURbgEu8jX3rhG1CNmCXmqlv5kG2IL5HBNiD
         v9M9nQ6x4wQbc3Uuw3RJHsDPVCYkYFT/ksNlNSKDpcP6VV1dYHtf7ofUP8DUxJg0LVXp
         aDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699460121; x=1700064921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkv2aSpFw25Sjc2pDxCz5exBlHcYk4gTYVmkV2GOyQs=;
        b=DGszCAcm7vopUaP2MhM9qvNeC2r5fwp+tGcRzxZVYkrg5XETDPLT4kg0WK5XMm7ni0
         x/B5XxTj9Jtr2WlvFgeLrbCZeLhzHYFAADNCOsnEJP/DR0zWh4AR+BRjOYzMUVhoCPFx
         QGsuz1MQ2zFAZCS1TmGNW21rif7jC5LEKOlGE/C68l7Fb9VcSxf0nLJtT4YhDNFWnPoO
         mqsLzsbndxL2BMpfTK7eHIUeE8kaYEHMLO8twerEDjljqSoQ0A8Gg9nSIxvkwrHUKj0d
         4x7AJG55cG9HjDGdciAjSpluAOordXlw/JNPRUmXFDP6ojh676kXx4sadOAAFweS1Bw9
         IK5w==
X-Gm-Message-State: AOJu0YyMUYzJUmoVQytod9p/EjYASKPTlxx8xh6miYsRD08m3FQWKWqm
        JfM8+wWjjG8G9Pt25KdZW5iIS5qgiio=
X-Google-Smtp-Source: AGHT+IFTaQxuB68rES3N/Ouf34zgkF8c8VJFXOJJTqeB2NI7Tbr2np/f2yCXpxs97M+wYFrZ4r8BXQsnFFA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1386:b0:1cc:5674:9177 with SMTP id
 jx6-20020a170903138600b001cc56749177mr37933plb.11.1699460120994; Wed, 08 Nov
 2023 08:15:20 -0800 (PST)
Date:   Wed, 8 Nov 2023 08:15:19 -0800
In-Reply-To: <2573d04d-feff-4119-a79c-dbf9b85e62fd@amazon.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-30-nsaenz@amazon.com>
 <2573d04d-feff-4119-a79c-dbf9b85e62fd@amazon.com>
Message-ID: <ZUu0FzbW5tr2Werz@google.com>
Subject: Re: [RFC 29/33] KVM: VMX: Save instruction length on EPT violation
From:   Sean Christopherson <seanjc@google.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, anelkz@amazon.com,
        dwmw@amazon.co.uk, jgowans@amazon.com, corbert@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023, Alexander Graf wrote:
> 
> On 08.11.23 12:18, Nicolas Saenz Julienne wrote:
> > Save the length of the instruction that triggered an EPT violation in
> > struct kvm_vcpu_arch. This will be used to populate Hyper-V VSM memory
> > intercept messages.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> 
> 
> In v1, please do this for SVM as well :)

Why?  KVM caches values on VMX because VMREAD is measurable slower than memory
accesses, especially when running nested.  SVM has no such problems.  I wouldn't
be surprised if adding a "cache" is actually less performant due to increased
pressure and misses on the hardware cache.
