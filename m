Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C637E777C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbjKJC3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbjKJC3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:29:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE53469A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:29:17 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a9012ab0adso22950677b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699583356; x=1700188156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ViZOepyyuHgGywDg5p020KLGJgQ5sVyIecAWPub5Hkc=;
        b=FVYanNPjEfH+zeSC5oEqFite2i8NIG+HdTxHDaSx6wnqHorabARC7TWVNA9o5LYRaS
         TCEyrbmz2I4tdvWVo5zg5a2SjyPRbuvd2xwLDfdj1r0eZuoGExVICIckYrGhkoPgYF9F
         rxvro0cjTbu4zNRXx7/8ejk3q8INK80cCE7N+vUHD6nJyhOlD7/ARqs6gX/VVQQkugHg
         cDT5mHrtS93c4vXPaVfqr8bDT7U8orVJYuVFowQccUvjwv2qaysrVb0EZ/+JL+IDsoYF
         J7wQgdtDSVt5KsGbthOYVbWfRFiFLFl8OFc6nDi0I1nwnvzEfU9eaq4Zav/TJePoeW6k
         Q3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583356; x=1700188156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViZOepyyuHgGywDg5p020KLGJgQ5sVyIecAWPub5Hkc=;
        b=Dev/fiJ18E9Rf5H02qcs8NGQT+zQXw74FhTrhODs7ejmTLagui8pJnnib21hWWJZec
         dGDMiU5heQPPdJ73mij0SewWHZwsRkPareRePTu7EQcNmReg4HcyYZwyqUGmJF7ghH2d
         E69bBXn32SYOSsYyRPIFDzN4Jpwcc4HCXT6nyz39TVak29Bbk1+iwRfoD7hqXJFuJPnq
         aKro/mPY5yasTrXgg6DKPDNDK5YUUcfUbbpFfWFvhm7mD3IMyooWJO/pOA6B961HgccO
         hLLDIS9oxrf56fxdfETqGoGpwTHX+nH+SQO5y42IECw6o6EAcG3ljrpWytRf7yihkT90
         AyOw==
X-Gm-Message-State: AOJu0YxmjzBsLIkUVgaZzudiP8v46pI2QmdIK+S/meucJ7llNWVz3Kpy
        Ge1O1CKgy2XHaHd/MZKGrIlGOGkDsVc=
X-Google-Smtp-Source: AGHT+IEz4Npt3on2y4c0ZdLIwoyVoJbdLf5cd4Ndcm7P56uuGjm8a/8+nhf+7OOsw6XqF0hZ+DExIx7za1w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9a44:0:b0:5be:94a6:d84b with SMTP id
 r65-20020a819a44000000b005be94a6d84bmr197455ywg.5.1699583356692; Thu, 09 Nov
 2023 18:29:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:28:55 -0800
In-Reply-To: <20231110022857.1273836-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110022857.1273836-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110022857.1273836-9-seanjc@google.com>
Subject: [PATCH 08/10] KVM: x86/pmu: Expand the comment about what bits are
 check emulating events
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the comment about what bits are and aren't checked when emulating
PMC events in software.  As pointed out by Jim, AMD's mask includes bits
35:32, which on Intel overlap with the IN_TX and IN_TXCP bits (32 and 33)
as well as reserved bits (34 and 45).

Checking The IN_TX* bits is actually correct, as it's safe to assert that
the vCPU can't be in an HLE/RTM transaction if KVM is emulating an
instruction, i.e. KVM *shouldn't count if either of those bits is set.

For the reserved bits, KVM is has equal odds of being right if Intel adds
new behavior, i.e. ignoring them is just as likely to be correct as
checking them.

Opportunistically explain *why* the other flags aren't checked.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 45cb8b2a024b..ba561849fd3e 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -850,7 +850,20 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
 		if (!pmc_event_is_allowed(pmc))
 			continue;
 
-		/* Ignore checks for edge detect, pin control, invert and CMASK bits */
+		/*
+		 * Ignore checks for edge detect (all events currently emulated
+		 * but KVM are always rising edges), pin control (unsupported
+		 * by modern CPUs), and counter mask and its invert flag (KVM
+		 * doesn't emulate multiple events in a single clock cycle).
+		 *
+		 * Note, the uppermost nibble of AMD's mask overlaps Intel's
+		 * IN_TX (bit 32) and IN_TXCP (bit 33), as well as two reserved
+		 * bits (bits 35:34).  Checking the "in HLE/RTM transaction"
+		 * flags is correct as the vCPU can't be in a transaction if
+		 * KVM is emulating an instruction.  Checking the reserved bits
+		 * might be wrong if they are defined in the future, but so
+		 * could ignoring them, so do the simple thing for now.
+		 */
 		if ((pmc->eventsel ^ eventsel) & AMD64_RAW_EVENT_MASK_NB)
 			continue;
 
-- 
2.42.0.869.gea05f2083d-goog

