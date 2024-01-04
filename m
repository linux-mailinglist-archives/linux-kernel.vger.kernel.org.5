Return-Path: <linux-kernel+bounces-17165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B685B824918
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684351F2584B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20CA2D622;
	Thu,  4 Jan 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sX3wrLLs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18562D05E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9dacc912so1168167276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704396795; x=1705001595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0gL82psZOay2fkE6NWKDmgNyb6GicZeTgyQYLdcvkDM=;
        b=sX3wrLLsuT6j7vDEVEP1PtFuBrOTbW7VqyXVMzlPy0Oeijrug3Wz7FT0sRENFm+yuh
         PUEst8CKAsBI0KOfvr/zHxOz9MMl9aGcUhYUBPyIEDGIpaTCwHU8cd9f8arpGa7eAEI7
         dqHk3+thCy5KVMRIRLw4wPpGf4tM3hfUaljbu5nlZc0DgNddM5VhEdb1d05bguY2qWtn
         0Ke4qbiTblN6GReoDR6JmbFvOZh1BItln5A0BuZ4eFDLi6ZuRKtZhDv2NWsbhCjchlMo
         ObS4hnUtvSvDUtiwZGT60fX5gxkJ958zVdECpcU74XkXc0gM+T6rHyHRKdakWRug90bc
         Lq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396795; x=1705001595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gL82psZOay2fkE6NWKDmgNyb6GicZeTgyQYLdcvkDM=;
        b=FVSYpm9qUvtdp/Xod5bM2gcGiGbPDLTGZ72/GO04r6sDvc1m8Qy9CzCR7WQ3UZ0+wQ
         b/uMNaNixzfyls4OtVhPfIbW+DYztaHnYH0oy7uKMA0CCzKkmFyuZadYMnUYM208LIVl
         REc9+3t3EXk2cV3zO8GqvNkvbkc6/v/fmb1+ancX1IC8U+Visi6IJLWMhG+/0zyatWy0
         9tuYneJ8eo3ZtXVaEEuBrA1W+pCt78V9U23Jjvr4RYdlXwyo1kTROO5sQN2/CFRVpRNC
         rE2y3obwnKAib3QbpwLLEQ7Nk9Msa5Ppav1LP7oltAmKFOKbiimyrOthN+Dlh0X9XoDT
         2/4A==
X-Gm-Message-State: AOJu0YyWAQ0P+RdHGUoU6SwUZeb2u8MozeAVjYyhYcCuWHn2PLDxRfbV
	AAAubowe98tuJMXJx+OMlTOIolzdDDFTWmWdiw==
X-Google-Smtp-Source: AGHT+IHiEIv32pEw7qtAgHWDlk+hCdfXeHNfURJg05mMSlvid89DZjvpCXEgbhuK5FzQrfqkdt5Gmt7Kskc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:81ce:0:b0:dbd:b1d3:85e4 with SMTP id
 n14-20020a2581ce000000b00dbdb1d385e4mr37002ybm.1.1704396794928; Thu, 04 Jan
 2024 11:33:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  4 Jan 2024 11:32:59 -0800
In-Reply-To: <20240104193303.3175844-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104193303.3175844-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240104193303.3175844-5-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Misc changes for 6.8
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A variety of one-off changes...

The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b2f:

  selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:58:25 -0500)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-6.8

for you to fetch changes up to 15223c4f973a6120665ece9ce1ad17aec0be0e6c:

  KVM: SVM,VMX: Use %rip-relative addressing to access kvm_rebooting (2023-11-30 12:51:54 -0800)

----------------------------------------------------------------
KVM x86 misc changes for 6.8:

 - Turn off KVM_WERROR by default for all configs so that it's not
   inadvertantly enabled by non-KVM developers, which can be problematic for
   subsystems that require no regressions for W=1 builds.

 - Advertise all of the host-supported CPUID bits that enumerate IA32_SPEC_CTRL
   "features".

 - Don't force a masterclock update when a vCPU synchronizes to the current TSC
   generation, as updating the masterclock can cause kvmclock's time to "jump"
   unexpectedly, e.g. when userspace hotplugs a pre-created vCPU.

 - Use RIP-relative address to read kvm_rebooting in the VM-Enter fault paths,
   partly as a super minor optimization, but mostly to make KVM play nice with
   position independent executable builds.

----------------------------------------------------------------
Jim Mattson (2):
      KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace
      KVM: x86: Use a switch statement and macros in __feature_translate()

Sean Christopherson (2):
      KVM: x86: Turn off KVM_WERROR by default for all configs
      KVM: x86: Don't unnecessarily force masterclock update on vCPU hotplug

Uros Bizjak (1):
      KVM: SVM,VMX: Use %rip-relative addressing to access kvm_rebooting

 arch/x86/kvm/Kconfig         | 14 +++++++-------
 arch/x86/kvm/cpuid.c         | 21 ++++++++++++++++++---
 arch/x86/kvm/reverse_cpuid.h | 33 ++++++++++++++++++++++-----------
 arch/x86/kvm/svm/vmenter.S   | 10 +++++-----
 arch/x86/kvm/vmx/vmenter.S   |  2 +-
 arch/x86/kvm/x86.c           | 29 ++++++++++++++++-------------
 6 files changed, 69 insertions(+), 40 deletions(-)

