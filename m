Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5E17FC135
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbjK1QsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjK1QsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:48:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B900D4B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:48:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da040c021aeso7902994276.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701190104; x=1701794904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uA6IXD+Y3WRAlqXJ/CITjoEeJvV8WozOfc0Um1r0Klo=;
        b=yN4tDn5HJWeYr0l+fYp9PpLEGYA/ueaTCQaVJJwPyJZ6FVHIUnzOjz0vBmFqWnI3yI
         0mPUEmxUhVhw1hVGLqCht3HtBOTX7L4R5JW90r+o/SC30DhjKiTiZrK63C6SCOyYZtLM
         dfmbvQgLRdlTBu67Hbyy0xIlAlm2ynB8JBEkrWJO7XJKEuRXxvWHrcTQ6dUfzJJiA4C3
         lS/+DfUJe84jc/5bRo5ZTKQfTCU0ahdmrwepjW+GIA2RSLTRssppru81SRm2aYOQ9l+5
         F3g3p5Gbiw+G0RQ1SF7/4irSv2VrdvadI9xlHjp0DZtXQ5DOd50O/HSAficrwPQIKnrd
         3N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190104; x=1701794904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uA6IXD+Y3WRAlqXJ/CITjoEeJvV8WozOfc0Um1r0Klo=;
        b=jfFWeJt97h6c6XRyV5cznv/Zq1ND3+SAdG3RBw013QxI5jUlGBq0fXZsA5QK71dc+X
         JBWZKwTOTyyGu8ye9cfOtWI+QxYw0DhiM17CBIQxyDQHRX69MDWB0UZEtoafjdtBrxmH
         0B+kC/EJlpiz2Y9j0sW6i1PLGPqIMFmm5022ft8REU24ZKaDbpEWtKq3bAhQXovpwTO4
         d2nZHUXgb7Qo9B1iaU4uA9H5Ldx997FjavLQ1mJ2mrPpTrkiaJKWjImLsbZWBs6BPuSv
         7xgZdo+wy1O844SpHKyzDWXA+oXkaaJqWQwHkQPbmu2BJxa6d3tb1eXiWbK3cyelhZUd
         bxcg==
X-Gm-Message-State: AOJu0YxOSo529rQXYesMI+8H+oqczxWaL9YhdXjqIr67x4jgVjNkXtb6
        t2E1oz2qX1mfdOzX2mqQYdWELVtHXvs=
X-Google-Smtp-Source: AGHT+IFUGK7/QTbQin6XENsFSAaDkeT3IWWH8DLbxWfvEu8yMLlQc6felk11vuaE8kO9WUWqRWfY2d5B078=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:3d44:0:b0:da0:567d:f819 with SMTP id
 k65-20020a253d44000000b00da0567df819mr515103yba.10.1701190103797; Tue, 28 Nov
 2023 08:48:23 -0800 (PST)
Date:   Tue, 28 Nov 2023 08:48:22 -0800
In-Reply-To: <50076263-8b4f-4167-8419-e8baede7e9b0@maciej.szmigiero.name>
Mime-Version: 1.0
References: <c858817d3e3be246a1a2278e3b42d06284e615e5.1700766316.git.maciej.szmigiero@oracle.com>
 <ZWTQuRpwPkutHY-D@google.com> <50076263-8b4f-4167-8419-e8baede7e9b0@maciej.szmigiero.name>
Message-ID: <ZWYZ1ldqQ1Q-7Jk0@google.com>
Subject: Re: [PATCH] KVM: x86: Allow XSAVES on CPUs where host doesn't use it
 due to an errata
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023, Maciej S. Szmigiero wrote:
> On 27.11.2023 18:24, Sean Christopherson wrote:
> > On Thu, Nov 23, 2023, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Since commit b0563468eeac ("x86/CPU/AMD: Disable XSAVES on AMD family 0x17")
> > > kernel unconditionally clears the XSAVES CPU feature bit on Zen1/2 CPUs.
> > > 
> > > Since KVM CPU caps are initialized from the kernel boot CPU features this
> > > makes the XSAVES feature also unavailable for KVM guests in this case, even
> > > though they might want to decide on their own whether they are affected by
> > > this errata.
> > > 
> > > Allow KVM guests to make such decision by setting the XSAVES KVM CPU
> > > capability bit based on the actual CPU capability
> > 
> > This is not generally safe, as the guest can make such a decision if and only if
> > the Family/Model/Stepping information is reasonably accurate.
> 
> If one lies to the guest about the CPU it is running on then obviously
> things may work non-optimally.

But this isn't about running optimally, it's about functional correctness.  And
"lying" to the guest about F/M/S is extremely common.

> > > This fixes booting Hyper-V enabled Windows Server 2016 VMs with more than
> > > one vCPU on Zen1/2 CPUs.
> > 
> > How/why does lack of XSAVES break a multi-vCPU setup?  Is Windows blindly doing
> > XSAVES based on FMS?
> 
> The hypercall from L2 Windows to L1 Hyper-V asking to boot the first AP
> returns HV_STATUS_CPUID_XSAVE_FEATURE_VALIDATION_ERROR.

If it's just about CPUID enumeration, then userspace can simply stuff the XSAVES
feature flag.  This is not something that belongs in KVM, because this is safe if
and only if F/M/S is accurate and the guest is actually aware of the erratum (or
will not actually use XSAVES for other reasons), neither of which KVM can guarantee.
