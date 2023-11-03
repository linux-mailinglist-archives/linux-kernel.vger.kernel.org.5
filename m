Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D127E0C14
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjKCXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjKCXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:12:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D6D50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:12:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc23f2226bso20223495ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699053137; x=1699657937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWpNJzpcviJ8HN4AR4VYrTNI3mSogXEyInh9qBThUzw=;
        b=3gVAx73UHIgdqnkgpSXTaffpSMJfpHm942IWhx3UizBYlrunpz1OsrmfugEwdqwtOd
         z2ckacnFPzGbJIob5uBi0q+sTwuzYm8alNflVKINsT1FUl/Ub/P7ZCNDRPqI7+5A2474
         +9JvPHxHqLX3jLSwFIf/6cMlNTLFJnjV5ZAcbfwUQxm6ApJ2EN/NuJ3w6KU5WLhjIdle
         eca+NOSGyvgGUMcbf431VictHWyq5zWoebR2995bgMj1CXJdYsrT+2ycE1ttPanr43t2
         ootP0/JQuyzzHa9Niv9D4fgK8oqeMWSZWDaSQNP1ctyGcgjKE++tjOor7xoJ0HDsIq9Q
         Op3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053137; x=1699657937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWpNJzpcviJ8HN4AR4VYrTNI3mSogXEyInh9qBThUzw=;
        b=chtRmPtEQW2CF27By1636BKrB4mi3t5Q9qFgOilBvPlZOU9EKRDi4Zj1tXyG1juRzt
         UoNk1lzB/+GhBRZG87uxHsPLD+2WAtSDZlKBG95yEoDxW2oVIB8QbxNH+9zQd594HyCL
         rcAwZLoTkukiU4kHGNYPiIpTN55d3X533YdhoJak6MC8UiwrNO5NagI3UepfCLweb2xN
         6wGzF1tzEs8+dI4pKO/O2usDHq3crP28NYFCsx/ERh00IcVBjGlgw+J7o7K/4g8PIooF
         AeMBnVUCZMIsUFAKnsA9VERitu2aHXDlT5ijrLPxZeTtjosN5Z4CQ0BW4Op1DkqMOgxu
         QBZw==
X-Gm-Message-State: AOJu0Ywj7FTuGpSD86ZbwPjdwVg60+wDzPQljVHFvlnAav10ZPXpJMi0
        AqQ5R4dJhBtKA52MOL/1ro3tbVceGyw=
X-Google-Smtp-Source: AGHT+IFSO9Ge1yBsJBn5l1J8siOSY/aVOAMFxvQrCCJE97w9Asv0vaEXbHVWsg9syCa1FdKi2anFw4FJ3H0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ac8e:b0:1cc:30cf:eae6 with SMTP id
 h14-20020a170902ac8e00b001cc30cfeae6mr365192plr.10.1699053137621; Fri, 03 Nov
 2023 16:12:17 -0700 (PDT)
Date:   Fri, 3 Nov 2023 16:12:16 -0700
In-Reply-To: <8c6f06ae-d1d3-40ea-9bed-8ca949eaff5f@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-6-paul@xen.org>
 <ZUGScpSFlojjloQk@google.com> <8c6f06ae-d1d3-40ea-9bed-8ca949eaff5f@xen.org>
Message-ID: <ZUV-UG-Tm6HREWi2@google.com>
Subject: Re: [PATCH v7 05/11] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
From:   Sean Christopherson <seanjc@google.com>
To:     paul@xen.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <pdurrant@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
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

On Thu, Nov 02, 2023, Paul Durrant wrote:
> On 31/10/2023 23:49, Sean Christopherson wrote:
> > On Mon, Oct 02, 2023, Paul Durrant wrote:
> > > diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> > > index 6f4737d5046a..d49946ee7ae3 100644
> > > --- a/include/linux/kvm_types.h
> > > +++ b/include/linux/kvm_types.h
> > > @@ -64,7 +64,7 @@ struct gfn_to_hva_cache {
> > >   struct gfn_to_pfn_cache {
> > >   	u64 generation;
> > > -	gpa_t gpa;
> > > +	u64 addr;
> > 
> > Holy moly, we have unions for exactly this reason.
> > 
> > 	union {
> > 		gpa_t gpa;
> > 		unsigned long addr;
> > 	};
> > 
> > But that's also weird and silly because it's basically the exact same thing as
> > "uhva".  If "uhva" stores the full address instead of the page-aligned address,
> > then I don't see a need for unionizing the gpa and uhva.
> 
> Ok, I think that'll be more invasive but I'll see how it looks.

Invasive is fine.  Not ideal, but fine.  If the resulting code is a mess, then
that's a problem, but churn in and of itself isn't awful if the end result is a
net positive.

> > kvm_xen_vcpu_get_attr() should darn well explicitly check that the gpc stores
> > the correct type and not bleed ABI into the gfn_to_pfn_cache implementation.
> 
> I guess if we leave gpa alone and make it INVALID_GPA for caches initialized
> using an HVA then that can be checked. Is that what you mean here?

Yep, that should work.
