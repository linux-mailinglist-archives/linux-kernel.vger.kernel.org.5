Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F67E4C86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjKGXK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjKGXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26F199A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:05 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc1682607eso49650515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 15:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699398604; x=1700003404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MhGzAd189djAcHtpfQuANQf9GCRzOFZiv20M9Q/FQY=;
        b=Kr0OE8g57m6fmvWbd9Fn7l1PjEP/0pwffK6GpFHKYIrKVGAa8fD7Qn/s+4MjrBv2gE
         Cj697TN97TnaNVnCcdHOMuO5y2jPI3Lixh3TVQiBab3xTKy5iQ2nFW6EuPK7cGEId86P
         LxcloMJlqBVGzDSygTLwVhnpSrDO2wAulGcIjSqvPyS+OsephMFJKNaa7FLHOGEX8QVP
         heKeX2K2mNBMCvKoQGVDUU9rlxO1wYm/ZMKUH1ebqGN9uWLPV+MwZ8RvV2R5JexC1emW
         05eOgvW4YH6So7Yjg1SL2M9bHfTS1yHI8JkuILIKpz8NhKDdhTY4GPV8Vf9lUwNaSijl
         Ohag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699398604; x=1700003404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MhGzAd189djAcHtpfQuANQf9GCRzOFZiv20M9Q/FQY=;
        b=gJarykxZ0GL7saWyZ3vYu/DQ74gX873YBUB6Y5XOqdGjW1QBeMkhzlgC15cifSuFbI
         RlLzw7BD+5OeNsIgi3S2AYsvKqRbatlhfs4fFpdGTZeXPWE6rWXVw2g8UuUj474BvKDI
         qj8g22ncUWMIvT8URcADk9gKDerOf5zoebFCcch75qn313seuyHOWhov4J1FO/mXfH6D
         999nitp5gXQtu2KhHaujLLlnJc8Mo5CpbtEqfU9KslrEd1xIeEc6/t9LclNc2k3pAB6j
         oAMz5fMM2J904U/I/NuGtWfKUY50XuS/dxhfb5aMZUFnBtDyM35PPCLjYlWDPApHJQ0I
         ksdQ==
X-Gm-Message-State: AOJu0YyNDvTXXEg1pXuOlJqwN8BhYC96osK8NypAsVD4crxzV2oKHDfh
        ihOU9vswDAHfxoPPNzoQ//l1TlqcMis=
X-Google-Smtp-Source: AGHT+IHXw4ruuMN9510jTMEQylrvlGOQL4x+riapUEeOGqH+xy8A01/RrDz2wfubezgYgQbwN6JnNYGVgd4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6b02:b0:1cc:3597:9e2f with SMTP id
 o2-20020a1709026b0200b001cc35979e2fmr7836plk.2.1699398604419; Tue, 07 Nov
 2023 15:10:04 -0800 (PST)
Date:   Tue, 7 Nov 2023 15:10:02 -0800
In-Reply-To: <2b27196c2b5d10625e10ea73e9f270c7ef0bf5a0.camel@redhat.com>
Mime-Version: 1.0
References: <20231010200220.897953-1-john.allen@amd.com> <20231010200220.897953-4-john.allen@amd.com>
 <8484053f-2777-eb55-a30c-64125fbfc3ec@amd.com> <ZS7PubpX4k/LXGNq@johallen-workstation>
 <c65817b0-7fa6-7c0b-6423-5f33062c9665@amd.com> <874ae0019fb33784520270db7d5213af0d42290d.camel@redhat.com>
 <ZUkYPfxHmMZB03iv@google.com> <2b27196c2b5d10625e10ea73e9f270c7ef0bf5a0.camel@redhat.com>
Message-ID: <ZUrDyqXAQZsQzCzl@google.com>
Subject: Re: [PATCH 3/9] KVM: x86: SVM: Pass through shadow stack MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     nikunj@amd.com, John Allen <john.allen@amd.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, weijiang.yang@intel.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023, Maxim Levitsky wrote:
> Since no sane L1 hypervisor will ever allow access to all its msrs from L2,
> it might make sense to always use a dedicated MSR bitmap for L2.

Hmm, there might be a full passthrough use case out there, but in general, yeah,
I agree.  I think even kernel hardening use cases where the "hypervisor" is just
a lowvisor would utilize MSR bitmaps to prevent modifying the de-privileged
kernel from modifying select MSRs.

> Also since all sane L1 hypervisors do use a msr bitmap means that
> dedicated code path that doesn't use it is not well tested.
> 
> On VMX if I am not mistaken, this is not an issue because either all
> MSRS are intercepted or a bitmap is used.

Yep, if the MSR bitmaps aren't used then all MSR accesses are intercepted.
