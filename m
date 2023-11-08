Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA57E5D44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjKHSdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:33:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BF210A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 10:33:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so7390936276.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699468393; x=1700073193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=50ipMfBLEUA7xDJ0NQzorJYtn8bk8XRkn5YPeYvT/r0=;
        b=uFaeB68VTHrGLbgfLw3MxRn1VfxX8HS5w6+ut3fXoq/g75D7YJRACneD44JdFfngkV
         mvUxjBwP2uuwjEMwKcnmT7q730uXmqiC7j4WpeNZFwI7nP84ei59J7QfxeT0srfBG1HA
         5TtxaSyoudUXmRc+6pDkIgjPYOirCSryyw2mTLwHQ+rBSNe/6medhZwG8+6xXk+k3JBW
         u9OBVMN1Zf0tR7S99r3a1Jxl2RoTQW7011X5R4kf8kD/UiWwcpschgeIo3AA6RYEzt0L
         /M2oc3sRO3PUX9ynqIKlOCHrACijBZQvF3dW3cVWvIRdeQ+cYqmnIEpS2HYI2a86WnHd
         cRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699468393; x=1700073193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50ipMfBLEUA7xDJ0NQzorJYtn8bk8XRkn5YPeYvT/r0=;
        b=GIhpY6aquL+VC0yw5RjojzFt+PsS37MYakIV6gCFYm9FiiR457x6a9Fjf+zD5Lb2Ac
         /jX3Jm3yrgSyzsY3ZFQtRLOPJGxpOYFy8UK6Ly17JPlwOTu7dVYp9gQMM5aXkghkX5Pm
         rkb2K7JwVyNbHKsRM5flPEPjlX+wEM/HABLLxX6nE9IXG81pbDDawvGXleb4Z+Vn+7e4
         aIbkdqFuoWTEvJ/gGKG99fZUTwOGsDT8WIqN5WhVdyFFYS+Y00vrIsJmzJ6HacubLP6c
         hsU47rQmWjpY6m9cm6yxShRH3/9WIEK6ZhVj/spApeL4nxe47ekBu63o+EcWm0zP4DXl
         GsTw==
X-Gm-Message-State: AOJu0YxgI2MHr7//dzyoS0qY08TNN+xYvqvfeu39pQ/clL5YkFXom+Z3
        zTq+d03bidaAeUaDK7HCjt45BpqYjfw=
X-Google-Smtp-Source: AGHT+IFHQg/YDcEIocO0Ni0JZ0CPuBXAmwWA3839QbB/g3j7+q1xZZYyE3IrNG+D7YVTAx/aop/3By26fig=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:701:b0:d9a:6007:223a with SMTP id
 k1-20020a056902070100b00d9a6007223amr60840ybt.8.1699468393385; Wed, 08 Nov
 2023 10:33:13 -0800 (PST)
Date:   Wed, 8 Nov 2023 10:33:11 -0800
In-Reply-To: <ZUu9lwJHasi2vKGg@google.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <ZUu9lwJHasi2vKGg@google.com>
Message-ID: <ZUvUZytj1AabvvrB@google.com>
Subject: Re: [RFC 0/33] KVM: x86: hyperv: Introduce VSM support
From:   Sean Christopherson <seanjc@google.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, anelkz@amazon.com, graf@amazon.com,
        dwmw@amazon.co.uk, jgowans@amazon.com, corbert@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023, Sean Christopherson wrote:
> On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> > This RFC series introduces the necessary infrastructure to emulate VSM
> > enabled guests. It is a snapshot of the progress we made so far, and its
> > main goal is to gather design feedback.
> 
> Heh, then please provide an overview of the design, and ideally context and/or
> justification for various design decisions.  It doesn't need to be a proper design
> doc, and you can certainly point at other documentation for explaining VSM/VTLs,
> but a few paragraphs and/or verbose bullet points would go a long way.
> 
> The documentation in patch 33 provides an explanation of VSM itself, and a little
> insight into how userspace can utilize the KVM implementation.  But the documentation
> provides no explanation of the mechanics that KVM *developers* care about, e.g.
> the use of memory attributes, how memory attributes are enforced, whether or not
> an in-kernel local APIC is required, etc.
> 
> Nor does the documentation explain *why*, e.g. why store a separate set of memory
> attributes per VTL "device", which by the by is broken and unnecessary.

After speed reading the series..  An overview of the design, why you made certain
choices, and the tradeoffs between various options is definitely needed.

A few questions off the top of my head:

 - What is the split between userspace and KVM?  How did you arrive at that split?

 - How much *needs* to be in KVM?  I.e. how much can be pushed to userspace while
   maintaininly good performance?
   
 - Why not make VTLs a first-party concept in KVM?  E.g. rather than bury info
   in a VTL device and APIC ID groups, why not modify "struct kvm" to support
   replicating state that needs to be tracked per-VTL?  Because of how memory
   attributes affect hugepages, duplicating *memslots* might actually be easier
   than teaching memslots to be VTL-aware.

 - Is "struct kvm_vcpu" the best representation of an execution context (if I'm
   getting the terminology right)?  E.g. if 90% of the state is guaranteed to be
   identical for a given vCPU across execution contexts, then modeling that with
   separate kvm_vcpu structures is very inefficient.  I highly doubt it's 90%,
   but it might be quite high depending on how much the TFLS restricts the state
   of the vCPU, e.g. if it's 64-bit only.

The more info you can provide before LPC, the better, e.g. so that we can spend
time discussing options instead of you getting peppered with questions about the
requirements and whatnot.
