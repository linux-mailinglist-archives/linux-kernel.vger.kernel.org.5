Return-Path: <linux-kernel+bounces-17167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119EF82491C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1651A1C2275A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21B2DF91;
	Thu,  4 Jan 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ix45oHyI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D02D792
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e9de9795dfso16767037b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704396798; x=1705001598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvs1u2UtIbd55nr7bpVl91Chzlx2v1NykCiBhL368XY=;
        b=ix45oHyInUXiCRhMeIXBXTxzHOn3L/gX75THjJXEKAIZ4igIMHx0LgEqqxn89OIpFV
         7lKE+jewj4hKu2OvOpU6YMl/QdH38kZTwgsBypgKE0qRG+FPgzXcm+S1ro8gWaCNP5NP
         BVyboQxxfbXyx5QvTQGnCjMglOgQyy9lK3S6RWxC6skSWAQL7JlYnzMzHvMnZzsIdD5w
         ndOnoal82b5iuUfL8crO9XdY64Oyycq3F0Y5SWLNVBjuk+Xr+4+x/tlITwKe6/3YGfYe
         g2w4jEaUvwunJOAfO7GOQdld2yAVA9DpKFP6NebGDbkSWeOaokSbvqU7hRWCJrY3Go9T
         iWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396798; x=1705001598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zvs1u2UtIbd55nr7bpVl91Chzlx2v1NykCiBhL368XY=;
        b=VlqkFlsi8gWhRPsewUWw+qQE3rNZlxtjKn0V6iFLWRymMolMILeYowRgtdwzshcA/M
         4HO1iBv7jUWE+NnMc+bgWopE+hy14d1FAOopM/Bys5ALnfPXab/xEVcvRtD8AauTwn3Y
         Qa1ci5u2LJ4/RHRIcpqkeuhjQDBr30HmHmDb8LmfhwZr5rug2xHXmgSWbu4h/1E/LqC1
         xdfPvNWeTpn9SAMxZW+6bmVD8OIT5xabBwfbUvfMXAea+FNn3JCfjI3Cr3KJ08kLHEO6
         P/4wgZlsfjS6/Brlks+wAKt5GraMdibFNlgis9588t4LubB40s5rlgputSdipbj+MBKt
         ebqA==
X-Gm-Message-State: AOJu0YyXfRs7B86KbugC/K58o8bdTgoqcqZiVmjFeDIqDs7yPC8K4zJP
	R/ww7n2PbT1FpM3IFI25gN9UctY4vbQMOEdOUA==
X-Google-Smtp-Source: AGHT+IGniD5RZs01GuQn8t/R1ijNbDU476I20QYDCRF+bCklQbWXRXZG3dXY2zFFeJL5+esDsmID+eaLHwg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6b11:0:b0:dbe:696c:1208 with SMTP id
 g17-20020a256b11000000b00dbe696c1208mr374709ybc.7.1704396798754; Thu, 04 Jan
 2024 11:33:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  4 Jan 2024 11:33:01 -0800
In-Reply-To: <20240104193303.3175844-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104193303.3175844-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240104193303.3175844-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: PMU changes for 6.8
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

PMU fixes and cleanups.  The highlight is a fix for a double-overflow PMI bug
when KVM manually emulates counter events, which was made mostly benign by
commit a16eb25b09c0 ("KVM: x86: Mask LVTPC when handling a PMI"), but is still
a bug.

Note, the "Track emulated counter events instead of previous counter" fix
breaks the PMU KVM-Unit-Test due to a long-standing "bug" in perf[*].  If need
be, it's trivial to fudge around the shortcomings in the KUT code, I just
haven't carved out time to push things along.

[*] https://lore.kernel.org/all/20231107183605.409588-1-seanjc@google.com

The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b2f:

  selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:58:25 -0500)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-pmu-6.8

for you to fetch changes up to fd89499a5151d197ba30f7b801f6d8f4646cf446:

  KVM: x86/pmu: Track emulated counter events instead of previous counter (2023-11-30 12:52:55 -0800)

----------------------------------------------------------------
KVM x86 PMU changes for 6.8:

 - Fix a variety of bugs where KVM fail to stop/reset counters and other state
   prior to refreshing the vPMU model.

 - Fix a double-overflow PMU bug by tracking emulated counter events using a
   dedicated field instead of snapshotting the "previous" counter.  If the
   hardware PMC count triggers overflow that is recognized in the same VM-Exit
   that KVM manually bumps an event count, KVM would pend PMIs for both the
   hardware-triggered overflow and for KVM-triggered overflow.

----------------------------------------------------------------
Sean Christopherson (6):
      KVM: x86/pmu: Move PMU reset logic to common x86 code
      KVM: x86/pmu: Reset the PMU, i.e. stop counters, before refreshing
      KVM: x86/pmu: Stop calling kvm_pmu_reset() at RESET (it's redundant)
      KVM: x86/pmu: Remove manual clearing of fields in kvm_pmu_init()
      KVM: x86/pmu: Update sample period in pmc_write_counter()
      KVM: x86/pmu: Track emulated counter events instead of previous counter

 arch/x86/include/asm/kvm-x86-pmu-ops.h |   2 +-
 arch/x86/include/asm/kvm_host.h        |  17 +++-
 arch/x86/kvm/pmu.c                     | 140 +++++++++++++++++++++++++++------
 arch/x86/kvm/pmu.h                     |  47 +----------
 arch/x86/kvm/svm/pmu.c                 |  17 ----
 arch/x86/kvm/vmx/pmu_intel.c           |  22 ------
 arch/x86/kvm/x86.c                     |   1 -
 7 files changed, 137 insertions(+), 109 deletions(-)

