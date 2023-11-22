Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0B7F5324
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjKVWPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjKVWPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:15:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCE9B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:15:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da033914f7cso323441276.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700691331; x=1701296131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rHQ5lVYi4/2MX2skoChLDy6Ocqhy29V3zUGeEPzVvPk=;
        b=4nje9Ql02zOsTvSoAPAvpOBNu7wg0GEhOvHpvYlYXOFidCjelO2vDEHo7qUJZ9VTU4
         xgnyqJZhshN0b1WfZk+ZvPvShKSbvthyw0HEKtWDGAGg6nfn9KXeCHkg4u9WSbMYyUvr
         y0Fb+1bawhV8YtiH+tJ2MbrucEmYDruXoV0kME455LZd5F91cm+YJ9Nlclhs4d+PjCNs
         9aa68yQMTXmq692YlD7PnPpZNjrWx5sgRnQB6urz2vIlE2+KzrxnueHo96POFFCrLxIP
         M5YQNxbP9XALPBXEYqzk8BuYqtAAUjfHcv6evKKrg5f7uLqj+05o/Ui+AvSaJFtG246X
         6vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691331; x=1701296131;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHQ5lVYi4/2MX2skoChLDy6Ocqhy29V3zUGeEPzVvPk=;
        b=qifJxJgLY1neM1IOcbbXbxK0XLmV0wHpJLfOoPurnTaBKjELhTrcy1B40fa4K+KT62
         wmVuKoCHnoV+2QdE0pMBWM6NHn9FnMI7P5AaEwYu0LpDdNiEzHu1fFSoMDESOKclmlFk
         1u3vjm0d91vSO/aGDJfM3b+YPqZIFnlY2aB/m9sMBdqJ3gjem/xrFdC6mZycxbMr6obs
         0ob4mbUISH3hMCo8NQrOe3SQeOINQguBjbepIKP3FEWZ18V1CMiCE5cKNefpljoAh1oL
         r3+mF1JlRbdAZMKBIQFobg1YNI72PSlCBtGro1NSRp6/KREz3cdoOhyCDmjVbeGJ5gHa
         YjIQ==
X-Gm-Message-State: AOJu0YxYYR5cbICpbh7dLG2bIoXLwxfncbzJiGd6Eva4AnKppI6Qk4HQ
        PNfHViYPBLDV7lQHrGmLcSaLWQXuWTcP
X-Google-Smtp-Source: AGHT+IEKPFb2EHSzpX16MEr8UpukYHRCQvq4K7GrE1lzHEciYPJMeZQvd7fCFY+au119NI7M63atWhaudwtg
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:20a1])
 (user=rananta job=sendgmr) by 2002:a25:ce4e:0:b0:da0:c6d7:8231 with SMTP id
 x75-20020a25ce4e000000b00da0c6d78231mr109435ybe.0.1700691330951; Wed, 22 Nov
 2023 14:15:30 -0800 (PST)
Date:   Wed, 22 Nov 2023 22:15:26 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122221526.2750966-1-rananta@google.com>
Subject: [PATCH] KVM: selftests: aarch64: Remove unused functions from vpmu test
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

vpmu_counter_access's disable_counter() carries a bug that disables
all the counters that are enabled, instead of just the requested one.
Fortunately, it's not an issue as there are no callers of it. Hence,
instead of fixing it, remove the definition entirely.

Remove enable_counter() as it's unused as well.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 .../selftests/kvm/aarch64/vpmu_counter_access.c  | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index 5ea78986e665f..e2f0b720cbfcf 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
@@ -94,22 +94,6 @@ static inline void write_sel_evtyper(int sel, unsigned long val)
 	isb();
 }
 
-static inline void enable_counter(int idx)
-{
-	uint64_t v = read_sysreg(pmcntenset_el0);
-
-	write_sysreg(BIT(idx) | v, pmcntenset_el0);
-	isb();
-}
-
-static inline void disable_counter(int idx)
-{
-	uint64_t v = read_sysreg(pmcntenset_el0);
-
-	write_sysreg(BIT(idx) | v, pmcntenclr_el0);
-	isb();
-}
-
 static void pmu_disable_reset(void)
 {
 	uint64_t pmcr = read_sysreg(pmcr_el0);
-- 
2.43.0.rc1.413.gea7ed67945-goog

