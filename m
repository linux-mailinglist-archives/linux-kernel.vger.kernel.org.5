Return-Path: <linux-kernel+bounces-17169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187C824920
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8581F25944
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E02E643;
	Thu,  4 Jan 2024 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptYFktOZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E732E40B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e20c9c4080so14923497b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704396802; x=1705001602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CN9HeZvjoKV2Wbxa5HUcERhzb0PDW7VNeTNnQhNqYY4=;
        b=ptYFktOZ81SR9eU2hJ+qphSNARh22huNILugdiXABtaA0IADQU+cv81LCFtAjRS8mx
         NTIYJFZsbntDvn+46Ee6iRusV8W1RabwWXU8Qtzzg26Xm3rXhrzmY2euURhjsS6kXIhV
         U8FaoCCh7FK4wolJvtK+3mkwSAPrfl3YUMGiuZxT/yq+3rkyeorWGzGL3y+Qpac+uSE8
         3JA551Y7KREzM3B1irlYMDainzDCHo/DSqUSz6W5FnBGSCmF77HI5j/ORnQuMZSH7gaU
         BaBeZa8JBU5BehP9MFi+zjGBlWsGUSBWe3IXutxpAItgzpW/m5VPjIWZcP90RfGAZwqA
         W5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396802; x=1705001602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CN9HeZvjoKV2Wbxa5HUcERhzb0PDW7VNeTNnQhNqYY4=;
        b=S5P/T3BGush7QLdoDwt5D8M2kRpQwQTY69tfi3GfXQB5clkmqCW4nCZvVt5CAeVpzJ
         ps/H4cfMSAJ6hkEUj6pCSj2CIYEYVB25xQjPKJw/8OrKoSvHhxH3kKZpf0bL3OwRiruy
         LQdhiI0HFwZ7PpHiLWsEBlZWxU5/tt31DH/mCy94UjBXC5NoZiLdHBDFv0euvigs1Ivt
         bJmubbB4P5gavFGZE8Tq17vDvGXgGoyBp+tnEOryorSUbzzXslXgQM5J+NuYkOlaFnXi
         VWde6VtxSVdrodmlsDQW0pLVayHEDQNqJVsIY1cDV7R3QUMwv3ht4DMw187h2J4Al6VD
         pBDQ==
X-Gm-Message-State: AOJu0YxMJnSk7THiz471gs3cX+FSSjZVoMt5984UBHFMu5kIt11RIR3P
	kJxcJUenL2Z2bouvKYTDN84fwhRlx22qSIS4sA==
X-Google-Smtp-Source: AGHT+IFT/g6O0Qb3XCPrLkmEfM9ghUwoCpSLZ0U8QfzItbGRmdDrzn0VvnHqW7rZg6pFB83y2uw+DVets8Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8512:0:b0:dbd:99af:daba with SMTP id
 w18-20020a258512000000b00dbd99afdabamr354711ybk.5.1704396802607; Thu, 04 Jan
 2024 11:33:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  4 Jan 2024 11:33:03 -0800
In-Reply-To: <20240104193303.3175844-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104193303.3175844-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240104193303.3175844-9-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Xen change for 6.8
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A single Xen fix (of sorts) to let userspace workaround buggy guests that don't
react well to KVM setting the "stable TSC" bit in Xen PV clocks.

The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b2f:

  selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:58:25 -0500)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-xen-6.8

for you to fetch changes up to 6d72283526090850274d065cd5d60af732cc5fc8:

  KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT (2023-12-07 15:52:57 -0800)

----------------------------------------------------------------
KVM Xen change for 6.8:

To workaround Xen guests that don't expect Xen PV clocks to be marked as being
based on a stable TSC, add a Xen config knob to allow userspace to opt out of
KVM setting the "TSC stable" bit in Xen PV clocks.  Note, the "TSC stable" bit
was added to the PVCLOCK ABI by KVM without an ack from Xen, i.e. KVM isn't
entirely blameless for the buggy guest behavior.

----------------------------------------------------------------
Paul Durrant (1):
      KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT

 Documentation/virt/kvm/api.rst |  6 ++++++
 arch/x86/kvm/x86.c             | 28 +++++++++++++++++++++++-----
 arch/x86/kvm/xen.c             |  9 ++++++++-
 include/uapi/linux/kvm.h       |  1 +
 4 files changed, 38 insertions(+), 6 deletions(-)

