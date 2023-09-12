Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0A79D8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbjILSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjILSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:46:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B7D10D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:45:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b6083fa00so47053377b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694544358; x=1695149158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KxsKqPZq5p15xyDVXXLvft8EHyxkBVs3E9jtZwaSo4E=;
        b=beoIYyLFM6CO3BCIy1jNFebumt2d2ns9gQYUKwO8+Q9KedfEyiM4fjqVxRku4Xi7By
         YiS6U3jeonxaFNPbMT83ihaXc6eX/exIotwuQoDt/WDBId7nUhZbEC9jEqvlc8ikl4AQ
         KOTd41NHeMWUCF2Dg7r56FsABJwdmU1NZ72sBuEEqqdeKnMdNfrdj/9iQq2LzKaosplr
         hAC232JS3B43leablPeUM8hxRkbAsGBs+UYAf51jXBeXh1SzFTBT/tPLdXTKRjSewhBv
         7DaeH5chbzOTuY/V7Vq/F8LxMAMkgelzhGo2+dEQ18hzESGTZZEp7Vx8UxFhPwuKEdMT
         5PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544358; x=1695149158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxsKqPZq5p15xyDVXXLvft8EHyxkBVs3E9jtZwaSo4E=;
        b=bn+59xeS+X3OnerE/96ygX9AzWTSdsegd4oZP2XjAW97iQStRb9wk0gO3APx45DDs5
         5+W/gSTUWTanbldvQjb93O2x9L3nTzficmTJK1DHze+iWk4O2Mtqthlmw3BxCF2r/JEd
         NVoN6lDHW9VamI0oYNK3Q2gGvKgRa08o6zRHiOZk+qpHDgQcAHuIM06tnavO+XkwqXGh
         Z0LjLflGbKNx673T17+XE3Tbf+B9iolUkNx9l4NSI9QOegailaGnZCmE3PO1Z9VBIMEW
         IIqTiv8pQkBSOjXXLxqGrjABvcfR2t1qTEuaRzvyiqHx+Zs6+o3jV3tfaSkCZTYccnAn
         6Xgw==
X-Gm-Message-State: AOJu0YwGYYuIMs4spMbJgq3gcDL2daYpQjrZ6XQeRz7IBozm/MKVbKKI
        sVm6ouQC0HOWYVFRqZ/eGNssPqC/5gza
X-Google-Smtp-Source: AGHT+IFD8uQU6j1QBXjlKBLUMj8KgXKe6xDa8o8kykJFhbrLmwmFQU0DfU98SyrqwHQvlTqlsPmIHW+g351a
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a81:ac55:0:b0:581:3899:91bc with SMTP id
 z21-20020a81ac55000000b00581389991bcmr10628ywj.6.1694544358303; Tue, 12 Sep
 2023 11:45:58 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 12 Sep 2023 18:45:48 +0000
In-Reply-To: <20230912184553.1887764-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230912184553.1887764-1-mizhang@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912184553.1887764-2-mizhang@google.com>
Subject: [PATCH v4 1/6] KVM: Documentation: Add the missing description for
 guest_mode in kvm_mmu_page_role
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, Xu Yilun <yilun.xu@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing description for guest_mode in kvm_mmu_page_role
description.  guest_mode tells KVM whether a shadow page is used for the L1
or an L2. Update the missing field in documentation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 Documentation/virt/kvm/x86/mmu.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
index 26f62034b6f3..23c20455d4e7 100644
--- a/Documentation/virt/kvm/x86/mmu.rst
+++ b/Documentation/virt/kvm/x86/mmu.rst
@@ -202,6 +202,8 @@ Shadow pages contain the following information:
     Is 1 if the MMU instance cannot use A/D bits.  EPT did not have A/D
     bits before Haswell; shadow EPT page tables also cannot use A/D bits
     if the L1 hypervisor does not enable them.
+  role.guest_mode:
+    Indicates the shadow page is created for a nested guest.
   role.passthrough:
     The page is not backed by a guest page table, but its first entry
     points to one.  This is set if NPT uses 5-level page tables (host
-- 
2.42.0.283.g2d96d420d3-goog

