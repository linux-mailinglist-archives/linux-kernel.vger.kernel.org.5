Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0237E0C88
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjKDADG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjKDAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:02:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EAED62
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:02:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da040c021aeso3008165276.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056172; x=1699660972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yY/rmfF8uWP2qcFcrSxU2iBcqr1KyrUXkO4fHTVenYU=;
        b=bVxgGu2lCXmKuMm5QSCv4s4eEQMRPejB9mbV+VIMt8rwNnEbc4fGpD9gfpa/rIO62D
         a9YtZYAMX9/ZVajKB5TnBX6lraaMPSTFQGbb3kyLxn0b6AFUdHezzYwQviGz2GydGkWr
         js0oeQM1pRmxbl+jlS/Kk5Im2HNFp2H3XTCuHjtroLJi3sJl7vLc6MNeJrBi73Y+RZw/
         yanHmcJyR6NWW5VC96HE+sxYFKF/MkbkWAu43pvYUWD61Peq0k/g2ztgNUCEOmPR6Ez/
         blcVDM8flPsc/ljnxrf6iaeVLAXE0pTXboK1+CrKOv01ZvOPz8i4fsyCGEIxQSpkV+fi
         /BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056172; x=1699660972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yY/rmfF8uWP2qcFcrSxU2iBcqr1KyrUXkO4fHTVenYU=;
        b=Be2ESMbya+3/fkCULnf9dHKN+8EpcQQNEfllQiyKySNYKT7Jq8kDcq/3sH+QHIUAUg
         xrQyDa0de7EQc4f2vm8Xk2BNx9PW9cQpIG8PFg65B01lP8zohKGJkMxTWxMKiYUjEUKb
         FNeW3qKCxU9oxDqgmA4x6dI3vPjk3U4IPVrDyHMK1G6K77XBxlMEwNGVvXWTzgGqI7AF
         4CR5Fh4ZZVCU2Be1N0/7Ti6Rcc+c//XRuwsjwPCDlg69/lyP7DRflcooZ1suOmblWml7
         dVx8iDjCm9p7lUVK29I6msXMlLJcCvgSzd/KnEqD7leY+EemP0/WuIMtjHdgp22KqEfR
         39uw==
X-Gm-Message-State: AOJu0YyxeZX0neWBv3lDfaEB9xYFpS1p755F6cw7oiQOyLPFLi5WXPn9
        cPeGECqChfrm/6GWaMqN5fvu4a4vmZM=
X-Google-Smtp-Source: AGHT+IFwZt1P5Flriq9GqFcVYmLFgZ3LqYDtH2Fw5lrbDAOEtYZcr2cmtoQB2HW7yndqlTSKrdJ1ZHlMIX8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9011:0:b0:da0:4f83:60c1 with SMTP id
 s17-20020a259011000000b00da04f8360c1mr432157ybl.9.1699056172262; Fri, 03 Nov
 2023 17:02:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:24 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-7-seanjc@google.com>
Subject: [PATCH v6 06/20] KVM: selftests: Add vcpu_set_cpuid_property() to set properties
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
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

From: Jinrong Liang <cloudliang@tencent.com>

Add vcpu_set_cpuid_property() helper function for setting properties, and
use it instead of open coding an equivalent for MAX_PHY_ADDR.  Future vPMU
testcases will also need to stuff various CPUID properties.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h |  4 +++-
 tools/testing/selftests/kvm/lib/x86_64/processor.c   | 12 +++++++++---
 .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c   |  2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 25bc61dac5fb..a01931f7d954 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -994,7 +994,9 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
 }
 
-void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr);
+void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
+			     struct kvm_x86_cpu_property property,
+			     uint32_t value);
 
 void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function);
 void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index d8288374078e..9e717bc6bd6d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -752,11 +752,17 @@ void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid)
 	vcpu_set_cpuid(vcpu);
 }
 
-void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr)
+void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
+			     struct kvm_x86_cpu_property property,
+			     uint32_t value)
 {
-	struct kvm_cpuid_entry2 *entry = vcpu_get_cpuid_entry(vcpu, 0x80000008);
+	struct kvm_cpuid_entry2 *entry;
+
+	entry = __vcpu_get_cpuid_entry(vcpu, property.function, property.index);
+
+	(&entry->eax)[property.reg] &= ~GENMASK(property.hi_bit, property.lo_bit);
+	(&entry->eax)[property.reg] |= value << (property.lo_bit);
 
-	entry->eax = (entry->eax & ~0xff) | maxphyaddr;
 	vcpu_set_cpuid(vcpu);
 }
 
diff --git a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
index 06edf00a97d6..9b89440dff19 100644
--- a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
@@ -63,7 +63,7 @@ int main(int argc, char *argv[])
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
 
-	vcpu_set_cpuid_maxphyaddr(vcpu, MAXPHYADDR);
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_MAX_PHY_ADDR, MAXPHYADDR);
 
 	rc = kvm_check_cap(KVM_CAP_EXIT_ON_EMULATION_FAILURE);
 	TEST_ASSERT(rc, "KVM_CAP_EXIT_ON_EMULATION_FAILURE is unavailable");
-- 
2.42.0.869.gea05f2083d-goog

