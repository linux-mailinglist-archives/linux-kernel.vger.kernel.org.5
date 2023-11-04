Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E47E0C91
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjKDAC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjKDACu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:02:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C8D5A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:02:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso3024044276.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056166; x=1699660966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=D/rIH8GJk/IJPB5pqHHZ2EWC6jVCZLZPq4HYOnxUc90=;
        b=Cf35BIGgAvlwQ+n1pQBl2TYlhFecQtLuiALXRejxKRxu8FSdNrEBVqY404/+ZunHwF
         1/A3RdiT2KpfK2JDtTPWw6ZpVyqQ3yvWlSPj3KGXOQfokkhfhOQkS5uGWtQEy3LwIjSr
         F0VFdPqlsxuMHhKoAywFRRhmaTFU9pV1ZZIS5Mf2VBzp78alsa1P+sWhkFVvaiNUDL1u
         qCrziZX2Zcn/Od6TZfKIdGzumybkDniVdyWReh2/H0FxboEyC48+6GXzt11douvrP1Jk
         HuzG5VDnhyjY5G6xP+9/ETJ02RqrHTzAO5kGuKlLoE7Wds9yQle/VRJTnRBta/vjNq53
         LalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056166; x=1699660966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/rIH8GJk/IJPB5pqHHZ2EWC6jVCZLZPq4HYOnxUc90=;
        b=C3SwEPJGAkvug0c3bHDA/T77C+s7IUMezEPcRRURkgGAGudBoCWfTTA6jGBVz0Nstm
         Q7m4obSVPhfDK2zl4hdKqmF4Zvs+fkkDXxJGKFKtOOdMlfMuy7XJuKutZxeDjdyzr5nw
         fBf9RhbOLdR0D85sXsOmtSNGm2WOG6DLcyCgZC4Ivk+97j/ENC3aNNgI6l10yqI/HUXK
         dCEjM3oINvdwn1/02lpxvkbXJsMrjZTQPGMChemHBJ9s8rIipNTgfv2VvsipYffisE3K
         bcKLXG2a2l0fdTRXyLOxfsc39jrpkAvcSy2Bflhqu4tPv9SqegL0gu9vGBGQZ/61VFq6
         dYhA==
X-Gm-Message-State: AOJu0YwN71i3BcrKKJYL928PKdM3ZroUWwE9Nkss3Y8YsJZ7qsP3qaOn
        0IoEPVTqUEc5JT5JskVGInADKkBXAYg=
X-Google-Smtp-Source: AGHT+IG48HKOrJNtDtKClRR1cSurzfdJukbcmuWuNiNDq8LQjymDh0gNZfHiM6JwALmJySH4WydrLAOP3ds=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr544412ybu.7.1699056166538; Fri, 03 Nov
 2023 17:02:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:21 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-4-seanjc@google.com>
Subject: [PATCH v6 03/20] KVM: x86/pmu: Don't enumerate arch events KVM
 doesn't support
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't advertise support to userspace for architectural events that KVM
doesn't support, i.e. for "real" events that aren't listed in
intel_pmu_architectural_events.  On current hardware, this effectively
means "don't advertise support for Top Down Slots".

Mask off the associated "unavailable" bits, as said bits for undefined
events are reserved to zero.  Arguably the events _are_ defined, but from
a KVM perspective they might as well not exist, and there's absolutely no
reason to leave useless unavailable bits set.

Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 3316fdea212a..8d545f84dc4a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -73,6 +73,15 @@ static void intel_init_pmu_capability(void)
 	int i;
 
 	/*
+	 * Do not enumerate support for architectural events that KVM doesn't
+	 * support.  Clear unsupported events "unavailable" bit as well, as
+	 * architecturally such bits are reserved to zero.
+	 */
+	kvm_pmu_cap.events_mask_len = min(kvm_pmu_cap.events_mask_len,
+					  NR_REAL_INTEL_ARCH_EVENTS);
+	kvm_pmu_cap.events_mask &= GENMASK(kvm_pmu_cap.events_mask_len - 1, 0);
+
+	 /*
 	 * Perf may (sadly) back a guest fixed counter with a general purpose
 	 * counter, and so KVM must hide fixed counters whose associated
 	 * architectural event are unsupported.  On real hardware, this should
-- 
2.42.0.869.gea05f2083d-goog

