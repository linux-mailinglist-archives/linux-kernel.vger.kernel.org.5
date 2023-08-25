Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859C7787D98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjHYCYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjHYCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:24:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32FDCCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:24:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d72f3290e6eso539374276.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692930245; x=1693535045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GjBTHZffictDqC7SXUKAVMLWKYcOQkz6MY9f+b7B5hg=;
        b=mCR4QFTFn5Jcy7nVzhsR24Gy5QiLBgy+rUHCssS/UWljXUqPZ/9kTgEm20It7zc9dL
         yCbzxb76WoVG4xjUDLV6nnEc8FEc9VFBkgECVKIAz8FyiOxtfDSu5sFaejwwjpBuKAuM
         cer3fi5dlDKmlpwgT0KZRlQfcUXN4pQtWOmQK1Dp1kM3MvWkTL+V6AhzIbXE/dtBnNj7
         Al9zPJfQQ8QyvEpJgPd8jEVOAhRh8pMCz4wV9McbG5K9BDrFUGqWjr9G7IFihwncm83Q
         6PsJhJJCoxmgyiLX8u5+EFnT95D/21rP+JFMQRc05j2boYfptlVs3WR8u08yqJ2IRoWC
         ro1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692930245; x=1693535045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjBTHZffictDqC7SXUKAVMLWKYcOQkz6MY9f+b7B5hg=;
        b=l1fdbfx4P+e9jtCHwnRb2HSvxYsVUJgJWEEtheLfmsO8N8THwlX+jtYD5nfJoHLIGe
         Ot80biYVDUx3ChZx9yHgzMipIMT/rJPGgX+Tg66qR1ggf5zH6BG40rcX6fU1/CGVBuYb
         uTeXTwtVLFR+Ya4RKOfWxxt4in9PgCQR7dh2jRBECIkiZs9gKE8ZtJED/vM6iyTjyPXO
         HBDKPCmDgJ9AvQXAwXxJn5zJ5HoQJ4wrIg4pAcWR5syCdyGnl93/O6+xEulZIPmSDaOX
         F5DpplEuvjlzDUCgy/I5ZlOcKv70Lfib30l2h/RSb5Rk/b8E7ryS1vpc3iu1YoKr6neE
         loKg==
X-Gm-Message-State: AOJu0Yxc64li/LS8izZxsmHEhlqB+2xMbvpe21rLLQMTAzr5XzMw2FnI
        JuiIohi6oQDGesP+DiEmQnGsxUl9cSw=
X-Google-Smtp-Source: AGHT+IHA5Eyi8VPBlQpGEpV3E3TFwf1qKhES69a23NWfw66yifQWct5N7aW51NAyG07iqC1K9Y5sJF5pnB8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aba2:0:b0:d77:f6f9:159 with SMTP id
 v31-20020a25aba2000000b00d77f6f90159mr161317ybi.9.1692930245006; Thu, 24 Aug
 2023 19:24:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 24 Aug 2023 19:23:57 -0700
In-Reply-To: <20230825022357.2852133-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230825022357.2852133-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230825022357.2852133-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: SVM: Skip VMSA init in sev_es_init_vmcb() if pointer
 is NULL
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip initializing the VMSA physical address in the VMCB if the VMSA is
NULL, which occurs during intrahost migration as KVM initializes the VMCB
before copying over state from the source to the destination (including
the VMSA and its physical address).

In normal builds, __pa() is just math, so the bug isn't fatal, but with
CONFIG_DEBUG_VIRTUAL=y, the validity of the virtual address is verified
and passing in NULL will make the kernel unhappy.

Fixes: 6defa24d3b12 ("KVM: SEV: Init target VMCBs in sev_migrate_from")
Cc: stable@vger.kernel.org
Cc: Peter Gonda <pgonda@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index acc700bcb299..5585a3556179 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2975,9 +2975,12 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
 	/*
 	 * An SEV-ES guest requires a VMSA area that is a separate from the
 	 * VMCB page. Do not include the encryption mask on the VMSA physical
-	 * address since hardware will access it using the guest key.
+	 * address since hardware will access it using the guest key.  Note,
+	 * the VMSA will be NULL if this vCPU is the destination for intrahost
+	 * migration, and will be copied later.
 	 */
-	svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
+	if (svm->sev_es.vmsa)
+		svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
 
 	/* Can't intercept CR register access, HV can't modify CR registers */
 	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

