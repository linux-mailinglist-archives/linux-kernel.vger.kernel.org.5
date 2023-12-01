Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E1800FBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjLAQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjLAQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:00:13 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0D10FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:00:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c612589cfcso770674a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701446418; x=1702051218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=crvm5e2ydDZMUM2EHuPCr67zijP1BJbvH57wgKGfkc4=;
        b=oSGx4aw83nAs9hJ7rtA9uik28ECNKILlwli8YxyXg44Gos4yZUlmSRewsEo2KIoOl7
         VllN5OjiIZEGm8BxlQFs7sesFbX+J8HIlXFw40VnasiZf8Ki+46LO9jdR/+jEjq0WisP
         VyaH+7zw77LzV/UcIfUYciZ6dSASiWnN8BA4TibV7Y25uNvaCUiCIWi+cA95XqdgByZI
         5D00levSwADTFj6s/J6MD8GGVACl790CoziEz+Vwr7Pwj7mdpUDxo4COq7OAHXaCGPRk
         8R6NlD/kD+KMLkqBOIdTPYaaxFDFb9Zv08YWJ5yxaaRmsv0crZ4lJhXTHl0sso8+qHGp
         YQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446418; x=1702051218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crvm5e2ydDZMUM2EHuPCr67zijP1BJbvH57wgKGfkc4=;
        b=i8LnRBGr7NU2WGevuLK1nZ4BTsMNIdsqsJ1rQzOl9/g4KzwJS3V8Veg5/btVlYngig
         lM7ODR+JXeIacHtpCbRlbe48s6MgQZvaneRl83QkipXv1WlKcd63yXczoAKtMQObJ3Ad
         Y0vIZXS1XhtwerhpB9rtdvRDkamj3Py81COkEvlUW7z2M/4AQJZ9thi642zslj8M8Tjz
         XSPBGYCJnAKSidv1b3E+rsmuc/tuw9boNJmFjLDqeJbUbjwEY5iAOgJyxAWwJKBqKyRj
         JNHySbSB6Fq7uL4TrULXreITpx9T8ljXgXq3RV3SZ17tFe+pcpXndpFo2sby0y8mg9ho
         EcwQ==
X-Gm-Message-State: AOJu0YzwyLYphESqDbBVgven8BjMXK0FAJLV7SXw5I8Fd8kSrMMP0vWR
        w7Wl4abOdJbfX8SzJhjmo7nEmuLCRER7A+/n4Oa0IjtU1tmZ/BZNYNI0bHEdl79asKk422EoOL9
        tgMpkstBaRtZH3cxQCM5gSfqC1D6fQMqtQY8sTNUqtQk5O4rUb0BF5LGVGBS6r+fBiFHMHA==
X-Google-Smtp-Source: AGHT+IHo21+oBQWexEhm/gxZmQsFScsbXTirStRty1cwR0cGqSYO0hxdNViq14P4BW30477qGXZixHekO6o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6142:0:b0:5bd:d3f7:5192 with SMTP id
 o2-20020a656142000000b005bdd3f75192mr3924418pgv.6.1701446418251; Fri, 01 Dec
 2023 08:00:18 -0800 (PST)
Date:   Fri, 1 Dec 2023 08:00:16 -0800
In-Reply-To: <170137684485.660161.8230111667906795222.b4-ty@google.com>
Mime-Version: 1.0
References: <20231125083400.1399197-1-pbonzini@redhat.com> <170137684485.660161.8230111667906795222.b4-ty@google.com>
Message-ID: <ZWoDEIJHD7cv-LU9@google.com>
Subject: Re: [PATCH v2 0/4] KVM: x86/mmu: small locking cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     mlevitsk@redhat.com
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

On Thu, Nov 30, 2023, Sean Christopherson wrote:
> On Sat, 25 Nov 2023 03:33:56 -0500, Paolo Bonzini wrote:
> > Remove "bool shared" argument from functions and iterators that need
> > not know if the lock is taken for read or write.  This is common because
> > protection is achieved via RCU and tdp_mmu_pages_lock or because the
> > argument is only used for assertions that can be written by hand.
> > 
> > Also always take tdp_mmu_pages_lock even if mmu_lock is currently taken
> > for write.
> > 
> > [...]
> 
> Applied to kvm-x86 mmu, thanks!
> 
> [1/4] KVM: x86/mmu: remove unnecessary "bool shared" argument from functions
>       https://github.com/kvm-x86/linux/commit/2d30059d38e6
> [2/4] KVM: x86/mmu: remove unnecessary "bool shared" argument from iterators
>       https://github.com/kvm-x86/linux/commit/59b93e634b40
> [3/4] KVM: x86/mmu: always take tdp_mmu_pages_lock
>       https://github.com/kvm-x86/linux/commit/4072c73104f2
> [4/4] KVM: x86/mmu: fix comment about mmu_unsync_pages_lock
>       https://github.com/kvm-x86/linux/commit/9dc2973a3b20

FYI, I had to force push to mmu to fixup an unrelated Fixes: issue, new hashes:

[1/4] KVM: x86/mmu: remove unnecessary "bool shared" argument from functions
      https://github.com/kvm-x86/linux/commit/5f3c8c9187b6
[2/4] KVM: x86/mmu: remove unnecessary "bool shared" argument from iterators
      https://github.com/kvm-x86/linux/commit/484dd27c0602
[3/4] KVM: x86/mmu: always take tdp_mmu_pages_lock
      https://github.com/kvm-x86/linux/commit/250ce1b4d21a
[4/4] KVM: x86/mmu: fix comment about mmu_unsync_pages_lock
      https://github.com/kvm-x86/linux/commit/e59f75de4e50
