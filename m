Return-Path: <linux-kernel+bounces-17168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E382491E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE01E1F258CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4F2E415;
	Thu,  4 Jan 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHZFBngl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA582DF94
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e8e0c7f9a8so8954057b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704396800; x=1705001600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0pWRewVML3THHyHBKdvHicJcjc77QfdHT58HpJUsd+w=;
        b=hHZFBngl6cXkkW9cqPaOdTdqlfCGEmebC2/XeRxCvHHgwCUbcAIoYVOVxgBCR14MLy
         sOagNIeVwmyba1YL5CWToc0XSraYmAY/HcHY97xY+vIyNjY5RjVZ+QghOjMiXyoiphpo
         Yw51nX2pWpdPxziQvK/AFsfjG6LCXkzyzEtG/YbIyYCZcb+JWixFT5cWzqPBTwgmgMW3
         R4mzDCpDBDjVAtjmF+4p+k+39C5iUU3tP8B0lp1rxGZqF0IYtaIK67K0IRsnx8vJ78K7
         mrBmRW8hizFZe4J3BufIm2sEvD706v9EWXCZRf1m3OfbX93H1jirpR1ptfe3qCeSSNP6
         KrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396800; x=1705001600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pWRewVML3THHyHBKdvHicJcjc77QfdHT58HpJUsd+w=;
        b=Asp2dk6pHL0g7C+KS0gLM3XpISCBZQD4PkNr98k9W6YnBybd8eA323a+a8+B43NqJ4
         OaUKkZiSUDktnJ6W1PbzB2jM6pEr+GV3H2ndkPsYswTJ1xzEaGUVf7AOEjNCIe7bI1v4
         klp63WqG0k8WB5Cj/SijBp1CydAdl9BA2UGb7AO5Zxrqh8yTCmoI5/1Uukp7I5Sx38oy
         CKlxhRcNWRgvwGyOaDJu0UNQGTlqOcLTvCtSxSz2bkWrdzyJ3Wf9kwAX4brdzV6eNV+d
         AZTxmvGizzSW7LX0MzwN/eOR+nkfRBBGV3XK/wHCctTs1UKWOFBt5tDQDoLAXJX/9QtC
         ov7g==
X-Gm-Message-State: AOJu0YyUSFpMTHsBiqNj4tb9bumChmMOCPkZDFSN8s+3QxQJM4U9EaUB
	x+tOaXxiwI/U9vH2zNEQyrLhEqVh5r4wzL47eQ==
X-Google-Smtp-Source: AGHT+IG3YR1z/dH9NaNeLNzmjdyBkk6SYg1+JIgVwF9bDiK0k2OpLHL2tJ2/LqdSor2WTcXib4lKE/MP3M8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d7c2:0:b0:5e7:cd0b:7940 with SMTP id
 z185-20020a0dd7c2000000b005e7cd0b7940mr327798ywd.4.1704396800678; Thu, 04 Jan
 2024 11:33:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  4 Jan 2024 11:33:02 -0800
In-Reply-To: <20240104193303.3175844-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104193303.3175844-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240104193303.3175844-8-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM changes for 6.8
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A few minor fixes and cleanups, along with feature "enabling" for flush-by-ASID
to play nice with newer versions of VMware Workstation that require it.

The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b2f:

  selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:58:25 -0500)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-6.8

for you to fetch changes up to 72046d0a077a8f70d4d1e5bdeed324c1a310da8c:

  KVM: SVM: Don't intercept IRET when injecting NMI and vNMI is enabled (2023-11-30 12:51:22 -0800)

----------------------------------------------------------------
KVM SVM changes for 6.8:

 - Revert a bogus, made-up nested SVM consistency check for TLB_CONTROL.

 - Advertise flush-by-ASID support for nSVM unconditionally, as KVM always
   flushes on nested transitions, i.e. always satisfies flush requests.  This
   allows running bleeding edge versions of VMware Workstation on top of KVM.

 - Sanity check that the CPU supports flush-by-ASID when enabling SEV support.

 - Fix a benign NMI virtualization bug where KVM would unnecessarily intercept
   IRET when manually injecting an NMI, e.g. when KVM pends an NMI and injects
   a second, "simultaneous" NMI.

----------------------------------------------------------------
Sean Christopherson (4):
      Revert "nSVM: Check for reserved encodings of TLB_CONTROL in nested VMCB"
      KVM: nSVM: Advertise support for flush-by-ASID
      KVM: SVM: Explicitly require FLUSHBYASID to enable SEV support
      KVM: SVM: Don't intercept IRET when injecting NMI and vNMI is enabled

 arch/x86/kvm/svm/nested.c | 15 ---------------
 arch/x86/kvm/svm/sev.c    |  7 +++++--
 arch/x86/kvm/svm/svm.c    | 18 ++++++++++++++++--
 3 files changed, 21 insertions(+), 19 deletions(-)

