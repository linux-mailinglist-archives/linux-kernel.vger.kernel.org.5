Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448D97AA0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjIUUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjIUUsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:48:25 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F0B9280A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:48:45 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id 5614622812f47-3adbcfd059aso1744845b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318525; x=1695923325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wz9DrRdcdVVuAipyFL7+yUJ9r1lHv1bDpxPkFxDk1Ys=;
        b=OJMlhkKR1I+UDMSPZvsRWNOqeJK7nBF/NcFbN6EHRR0q3q96Yt/7OaPuxORzqHLYHZ
         D0Sd4e/Xub912jW0cOlqRYI9uXa8LE1HwJts3KCJ7tSs8DFZQ9M9dl9YOQR5Ekm2Ge1a
         0FG6zoptouzK8g07hy/zw15oKBpVY3viWhqCtPwysnjMyoyLHGWv3aM3527hvjUrj+5/
         yYP2rpN4mQ1PgEpr9mBq9HZbSUCopa7C0EQ0gIGcVOhJKa0gKGpJ+ab8/iUaw5K45iOj
         dhoZlVFqjiUe4qVBuXWX30Oxn/JJFuIHRnDLm+7lVyRlTWbdzYyI2yo9zN3dRD3io28N
         PNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318525; x=1695923325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wz9DrRdcdVVuAipyFL7+yUJ9r1lHv1bDpxPkFxDk1Ys=;
        b=kZ5ejE7jWaH7uEAU0UHSupXzNVO4L1ZbAsCQv3y0oI+TCC1yu8nixtmf2xwKrqhLjI
         73h+p3bzigQVJ2bpfvuVCb2yvCp1/T7FH01BBoi8n0yfm7mPk1CuXTqbPiNaj/G1cMlW
         8SywZpFvEZWR9CGb2EHxN7Je69ZtRYCyOoIVW+3uFYlWWYlSICtIoTPTJJhqkXC+Pk61
         3RjOQt2jcPPNpiv21SxRthmRJOZSm6vD7zZla5279v8GRykbgT6/fHvXENfJyDAH9+G2
         Q6X4hCgcYWl+0mAtOGA/ioJPp9oQf9Jat9sewGjo3wPpG2GVMYYqBgngNOEdoOOVlxVd
         8naA==
X-Gm-Message-State: AOJu0YzIYpIY8O2aPK19kdoNtoxAJGRq3xAdIe5V1UVl4HPR9cLuCCtB
        M236U2pmmyb3LL7sheQamjFxy80pRKk=
X-Google-Smtp-Source: AGHT+IGUFnCnwTB8D/pvi+zCV50rb2MP1v9iWe+0I6TPrLEdJFPDsHjmkXHNGKAnIJkUwJqPY2g2IiDhfbg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1704:b0:d64:f7ec:6d5d with SMTP id
 by4-20020a056902170400b00d64f7ec6d5dmr84990ybb.10.1695306762523; Thu, 21 Sep
 2023 07:32:42 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:32:41 +0000
In-Reply-To: <adebc422-2937-48d7-20c1-aef2dc1ac436@redhat.com>
Mime-Version: 1.0
References: <20230916003916.2545000-1-seanjc@google.com> <20230916003916.2545000-3-seanjc@google.com>
 <adebc422-2937-48d7-20c1-aef2dc1ac436@redhat.com>
Message-ID: <ZQxUCc3BEHA91FgY@google.com>
Subject: Re: [PATCH 2/3] KVM: x86/mmu: Take "shared" instead of "as_id" TDP
 MMU's yield-safe iterator
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pattara Teerapong <pteerapong@google.com>,
        David Stevens <stevensd@google.com>,
        Yiwei Zhang <zzyiwei@google.com>,
        Paul Hsia <paulhsia@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023, Paolo Bonzini wrote:
> On 9/16/23 02:39, Sean Christopherson wrote:
> > Replace the address space ID in for_each_tdp_mmu_root_yield_safe() with a
> > shared (vs. exclusive) param, and have the walker iterate over all address
> > spaces as all callers want to process all address spaces.  Drop the @as_id
> > param as well as the manual address space iteration in callers.
> > 
> > Add the @shared param even though the two current callers pass "false"
> > unconditionally, as the main reason for refactoring the walker is to
> > simplify using it to zap invalid TDP MMU roots, which is done with
> > mmu_lock held for read.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> You konw what, I don't really like the "bool shared" arguments anymore.

Yeah, I don't like the "shared" arguments either.  Never did, but they are necessary
for some paths, and I don't see an obviously better solution. :-/

> For example, neither tdp_mmu_next_root nor kvm_tdp_mmu_put_root need to know
> if the lock is taken for read or write; protection is achieved via RCU and
> tdp_mmu_pages_lock.  It's more self-documenting to remove the argument and
> assert that the lock is taken.
> 
> Likewise, the argument is more or less unnecessary in the
> for_each_*_tdp_mmu_root_yield_safe() macros.  Many users check for the lock
> before calling it; and all of them either call small functions that do the
> check, or end up calling tdp_mmu_set_spte_atomic() and
> tdp_mmu_iter_set_spte(), so the per-iteration checks are also overkill.

Agreed.
 
> It may be useful to a few assertions to make up for the lost check before
> the first execution of the body of for_each_*_tdp_mmu_root_yield_safe(), but
> even this is more for documentation reasons than to catch actual bugs.

I think it's more than sufficient, arguably even better, to document which paths
*require* mmu_lock be held for read vs. write, and which paths work with either.

> I'll send a v2.

Can we do a cleanup of the @shared arguments on top?  I would like to keep the
diff reasonably small to minimize the v6.1 backport.
