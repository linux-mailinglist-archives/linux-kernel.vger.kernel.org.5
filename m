Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C524280111A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjLAQcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjLAQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:32:16 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A510E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:32:22 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c5dd157f5cso735599a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701448342; x=1702053142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/K7HE0EB9COwZnWNHAn0RCBpw/EJerDEKjS1XCTH01o=;
        b=sb81ttRMy+4zDNQ3pBlsxtaovroVp6bOprAEQjGOKZqjl1VlY+AH9qes2XuFym/dfG
         6CuzeVxgDSh9s0x9SwuRY13U5jo+e2pb6iECKRbtETREHex7+URnpkgizRdvBlz1HXTW
         76EyyQiNlpCB4mzeGDYPdrwL5DaneL/LhpWQpBczUPRDmyQYZnrX0syjuG/4EQ01t97R
         SHPpnoajTXJ6aBkl5urglMFAJ/1iIU0lNpMN6zmXGl8X4HZUCkhXPPnT8hMRI4NbKcYl
         JtcD83MLhirCDMETTLLZJEN7n5PAUn/i8+b4fZp2csdMq4EL0J4/GdFNWwm6osa5slxq
         p/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448342; x=1702053142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/K7HE0EB9COwZnWNHAn0RCBpw/EJerDEKjS1XCTH01o=;
        b=AyYYw9tFKfnCwzVWCLK0LL5wQdSq96TnVnbZkFzTY+HBx9VC8T2APQ0PRZXdsIYZS0
         gdoQOIWHADUk8nKAnI8dvYXnCdIf3xAK5T8opbbN4uqVUJbqI8pWiWVhxe0vNV8Rf/LA
         v2E+Z4DFOuGQ7/3S85zAL2H+HSALobrCkYDA48fxAVWYPIMX3reV6opGpTvxQgYDXkX4
         wm0TJesEOawgbl2L/eeNZVsJvur/kcFjotpNVDdNmSxsq3fNzLYTcpKE+7uGW3i/hAXM
         pBkol90Wt0Rww8XbsF/bHbE17yDZlUG8TSlrn5eR6feOUyzullcBD7RLJWw06lEkimtz
         fNcw==
X-Gm-Message-State: AOJu0YwDpOoZXnFvQZYk4G3/SeNHHXoW4a+xYMu/sLPuiXc0cafQmdRa
        wsomgYke9SrGBKfjc/OwTvCeDKE8oEs=
X-Google-Smtp-Source: AGHT+IH1lYPeVLhg1fK/372dKtjjpuPIbf/djPz/KyZw6BQ3OgmjhAtwIR2bi7SaI0dtlhyObZ26zc2sufk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:211f:0:b0:5bd:bbb4:5275 with SMTP id
 h31-20020a63211f000000b005bdbbb45275mr3949230pgh.10.1701448342043; Fri, 01
 Dec 2023 08:32:22 -0800 (PST)
Date:   Fri, 1 Dec 2023 08:32:20 -0800
In-Reply-To: <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-6-nsaenz@amazon.com>
 <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com> <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com>
Message-ID: <ZWoKlJUKJGGhRRgM@google.com>
Subject: Re: [RFC 05/33] KVM: x86: hyper-v: Introduce VTL call/return
 prologues in hypercall page
From:   Sean Christopherson <seanjc@google.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, anelkz@amazon.com,
        graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > To support this I think that we can add a userspace msr filter on the HV_X64_MSR_HYPERCALL,
> > although I am not 100% sure if a userspace msr filter overrides the in-kernel msr handling.
> 
> I thought about it at the time. It's not that simple though, we should
> still let KVM set the hypercall bytecode, and other quirks like the Xen
> one.

Yeah, that Xen quirk is quite the killer.

Can you provide pseudo-assembly for what the final page is supposed to look like?
I'm struggling mightily to understand what this is actually trying to do.
