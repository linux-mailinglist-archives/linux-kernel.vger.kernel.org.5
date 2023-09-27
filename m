Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050817B06B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjI0OZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjI0OZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:25:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE4192
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:25:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5924b2aac52so223533497b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695824722; x=1696429522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqAxbQV9ra/o+abZK/vXaA4SUDewuk6D2ce8STXbtvU=;
        b=gEOaL0Vs4YogqAoEZ5IXf+8QmxNbryq9ea4Ux4iBu3Gj2ixWmPmSY/n6SWQJLdRzIw
         GUoRFFf1rxcmF9hAoFeRCrYEvDrbqvDwanpaKNBWdNHLixGrtx9Zt3Hj5eDu+SFsFCBc
         QQGBsJUDY4x1bFvyLj0WTI4duZAIurru7nKdo/ak/0F36ko9sZMwYUPR7pXhvr/86WPF
         hrFd9+HCnzs+FCwG1VITSS3jgTPe8ke2MPQMm1EK9Mnuyoy7dGlvzEcXlftGYVKB89m8
         Be3Nzc9CGV+REbti1AzvFHQn3+GM9z3v9eNcyC0XwCkv7wjRYDvm5bt1csb2LoLZjPRs
         DnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824722; x=1696429522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqAxbQV9ra/o+abZK/vXaA4SUDewuk6D2ce8STXbtvU=;
        b=ZBOdLrBYl+k1E+V73dgnOtNvoh1He4HQSAkbKxMCdRQOHZ0qTJgZqGPkFnqTuWaH3R
         1MVs8TlInIWvkTcACKzSRZHyN9dAGhYuUW1NuI4B239GijeoM8IrTPJ5ZOn28ApNn/ZL
         182qcrlbjvp1o2Y8eCeyIZkdpo3+l30Mf2SoS2B6PeRnqV0KEzk/D8E2O2odW31lSX9i
         8lSbPyoU0AM66PKJ0eUt1r/9aV3O4FZnqfQMHfzkz3lEL2CIUgRoTrqoTqk36KyljFfZ
         VD5VFevXR087LyCLImEOyXdYQQ0XELL/LWzzCDADDc4VDbejlsrFiAOouJOnpxIfiMaF
         uMxw==
X-Gm-Message-State: AOJu0Yy/k+Gdral/8i6lebFk19rtQWSnkUoQlwopZ2JTr2fXEvdTt4MC
        d6JGkrKHtGFpRQR54GhNhohuQV53DIY=
X-Google-Smtp-Source: AGHT+IECviyK2mWw7YEH/ELrmynpu1LCdY1pd2TucuzEdK/OXrDiGIiGPSa1RKhlW0+0ZPBNklQubZOh/Lc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1821:b0:d81:43c7:61ed with SMTP id
 cf33-20020a056902182100b00d8143c761edmr28872ybb.5.1695824722347; Wed, 27 Sep
 2023 07:25:22 -0700 (PDT)
Date:   Wed, 27 Sep 2023 07:25:21 -0700
In-Reply-To: <303a3382-32e7-6afd-bdfa-1cefdbdfb41e@linux.intel.com>
Mime-Version: 1.0
References: <20230921203331.3746712-1-seanjc@google.com> <20230921203331.3746712-8-seanjc@google.com>
 <303a3382-32e7-6afd-bdfa-1cefdbdfb41e@linux.intel.com>
Message-ID: <ZRQ7USnIybRXx-GR@google.com>
Subject: Re: [PATCH 07/13] KVM: x86/mmu: Track PRIVATE impact on hugepage
 mappings for all memslots
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michael Roth <michael.roth@amd.com>
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

On Wed, Sep 27, 2023, Binbin Wu wrote:
> 
> On 9/22/2023 4:33 AM, Sean Christopherson wrote:
> > Track the effects of private attributes on potential hugepage mappings if
> > the VM supports private memory, i.e. even if the target memslot can only
> > ever be mapped shared.  If userspace configures a chunk of memory as
> > private, KVM must not allow that memory to be mapped shared regardless of
> > whether or not the *current* memslot can be mapped private.  E.g. if the
> > guest accesses a private range using a shared memslot, then KVM must exit
> > to userspace.
> How does usersapce handle this case?
> IIRC, in gmem v12 patch set, it says a memslot can not be convert to private
> from shared.
> So, userspace should delete the old memslot and and a new one?

That depends on the contract between userspace and the VM, e.g. if the access is
to a range that the VMM and the guest have agreed is shared-only, then the VMM
could also "resolve" the access by injecting an error or killing the VM.

But yes, deleting the memslot and creating a new one is the only approach that
will work if userspace wants to map the gfn as private.  I don't actually expect
any real world VMMs to actually do anything like this, the purpose of this change
is mainly to ensure KVM has robust, consistent behavior.
