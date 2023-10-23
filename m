Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210507D4357
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjJWXka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjJWXkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:40:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A54D7D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:40:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da033914f7cso402293276.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698104411; x=1698709211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kKpVqTewUTpqij+D7Vj0c8pKvN0oprp2NzBGTWeq1ms=;
        b=s7VJKKgHcoYFE5Dij2QE/tI8xY6NlFHhPB8tUg99k3JQGa1yD4DLHcm5ihnc1CvgAm
         P9w+Yk5uxYwxu5yCn7I3LYIHj+JnYHDqzChw5FLLtXHxwhs7OAATvWkTeO8zMQKdFTRo
         HLdGlx716GGnCaMCiqsYrHeZd1bctuyd+NQc3rZPh3p+GfuG2eGYCYcalf21ufCu8R4D
         UM7ZSV9+DtIikBty260LyZ0JP5damI9soG2bgTfjiqhN9WiW0LDQC2t8IvS7A7f551R3
         1Ej7LuCHWsXzRWI3n7vrf3Zdn1xNujVTg4PBmNL0M6sa2dDcsspIKUiqXVC/PkU9oQB5
         lUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698104411; x=1698709211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKpVqTewUTpqij+D7Vj0c8pKvN0oprp2NzBGTWeq1ms=;
        b=QK0Ia4uu046W0LV4H/b/Emsm5uGgQM+8DbqsiaaRnq3VsjyYDQ4oVLmHotXGM8qkEM
         5s3dyR6IsjHiZYI7GnkvA5t1yixCzpWZIb6j8W7n38h6jDQ9ktqXGkaI3BmlP0oeJSDS
         f5nxA0jMysja2joyMKBdUHKwK0x0N9RSfgAKk2kqG1ZqA7WYi9gzzxyaSR1EC64b/57G
         b2vek/sEC0JnbQ4N2tCqhU+HwHa9dLWEb2zCAyWllx4lcfV39OFRKfMBTKnqip/JdTSd
         uc9vOVA+SdQwvZ320nXu+8aYucmPYWaXBSHPmzIuQ6lSr2aHodfS/aTLaiWvtg3H5QCt
         mBxg==
X-Gm-Message-State: AOJu0YxM7reyOl8quKkMPiag4dqCMEYAwzBQ5ZtzCiAAneRRft7nZNQz
        ixSK0W+lmxa/t3nMpKBowTAlaLxfaxI=
X-Google-Smtp-Source: AGHT+IG/UQLvAHopvlX3+fTkoIXCZSG5C6SXuHDql5k5q4ixhxWwZSrg8qKFxtMws9CheBH+5kxBTEGrXKQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b951:0:b0:da0:1ba4:6fa2 with SMTP id
 s17-20020a25b951000000b00da01ba46fa2mr52717ybm.4.1698104410953; Mon, 23 Oct
 2023 16:40:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 23 Oct 2023 16:39:58 -0700
In-Reply-To: <20231023234000.2499267-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231023234000.2499267-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023234000.2499267-5-seanjc@google.com>
Subject: [PATCH 4/6] KVM: x86/pmu: Remove manual clearing of fields in kvm_pmu_init()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code the unnecessarily clears event_count and need_cleanup in
kvm_pmu_init(), the entire kvm_pmu is zeroed just a few lines earlier.
Vendor code doesn't set event_count or need_cleanup during .init(), and
if either VMX or SVM did set those fields it would be a flagrant bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 458e836c6efe..c06090196b00 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -710,8 +710,6 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 
 	memset(pmu, 0, sizeof(*pmu));
 	static_call(kvm_x86_pmu_init)(vcpu);
-	pmu->event_count = 0;
-	pmu->need_cleanup = false;
 	kvm_pmu_refresh(vcpu);
 }
 
-- 
2.42.0.758.gaed0368e0e-goog

