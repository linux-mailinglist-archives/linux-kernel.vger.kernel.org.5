Return-Path: <linux-kernel+bounces-16882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B660824558
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DC1F232ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0A624B31;
	Thu,  4 Jan 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4KOpV8j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E89249F2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704383330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LEkXE+nGh1hML2Kin8fvXleSDZDt4l2jScZiF0pGVTI=;
	b=A4KOpV8juIbl2XItOgviZHGhDVxXISuhIkI9PK4YRWLdGs4uugNhUGMOOamTxCAbGAOqRe
	riQbSemw+5oCBGUV5bT5utHeBj2Mbh9KtXZ9Wl1tJZ/G8o0hb+fS1W2jLL3KHCoYQ78Q4l
	wIs6CicwCPbY2je4CrsV0u3j83H7E5c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-jn8Ks9_vOoyuYSb6dokwwg-1; Thu, 04 Jan 2024 10:48:48 -0500
X-MC-Unique: jn8Ks9_vOoyuYSb6dokwwg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ccd5b5306fso5473461fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704383326; x=1704988126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEkXE+nGh1hML2Kin8fvXleSDZDt4l2jScZiF0pGVTI=;
        b=Rxxuq1uVliVa3rDndabIJXS19/ltd4QRZGW6J/2JQ0Gxy/RWcxIR2M2N1tlHxpytIn
         UKEsPD5Ng+HGA0eCW/sdcGwtVV1WPetNlydxvtOJU8h4uN23MEPUM/vttuTEK8b+SoEV
         B3AaAK7cSIc5LmNT/EqV0oGtvmQtAX214XukzAzn4POj3VOSEu6ripbKQdWd0+u0FvKp
         nFkUKb620zkSKBNRjRGwJRdmDdyuqs4laFxWxgJIuSHSDv1eO4YLb3e0N3AsLOQAXx4A
         MES75ipXRqYkXSSSwj2wKw7EiH1Q/DY7tDEeCoD4fSXV0OhOKmqv49cqgHm45T1M3/2e
         xmbg==
X-Gm-Message-State: AOJu0Yx/3KHnGQaT67Ve1+VUTEqG0NqiMmzK+GY1Y9ufODpiNWEWl1TB
	Gv+zVBwjDvGjy+5+5wWNOnEuXD351BC/JHLg87TdYoE+3WxOcRVqyw5bFmy4Ttk6BFZ7DxcMRcK
	joZ4aqKc2E39loPz9QSYHBTOvSbci/zSv
X-Received: by 2002:a05:651c:b0f:b0:2cd:10aa:7624 with SMTP id b15-20020a05651c0b0f00b002cd10aa7624mr561133ljr.33.1704383326835;
        Thu, 04 Jan 2024 07:48:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbD40GgCcQdkfbcxayvmWSKagJAdDIM37gasJKUfGbYEzWfxvsHVgZQOLKCEqIXhaJ0toqYw==
X-Received: by 2002:a05:651c:b0f:b0:2cd:10aa:7624 with SMTP id b15-20020a05651c0b0f00b002cd10aa7624mr561125ljr.33.1704383326527;
        Thu, 04 Jan 2024 07:48:46 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.gmail.com with ESMTPSA id q1-20020a056402040100b0055520e4f17csm12396978edv.45.2024.01.04.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:48:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org
Subject: [GIT PULL] Final KVM fix for Linux 6.7
Date: Thu,  4 Jan 2024 16:48:44 +0100
Message-ID: <20240104154844.129586-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit ac865f00af293d081356bec56eea90815094a60e:

  Merge tag 'pci-v6.7-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2024-01-03 14:18:57 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 971079464001c6856186ca137778e534d983174a:

  KVM: x86/pmu: fix masking logic for MSR_CORE_PERF_GLOBAL_CTRL (2024-01-04 16:31:27 +0100)

This is technically not a KVM patch, but I am sending it anyway considering that:

- the patch is doing nothing but undoing a Boolean logic brain fart, restoring
  the pre-6.0 logic

- the function is literally called intel_guest_get_msrs and I am touching only
  the "guest" field, so the non-KVM effects are clearly nil

- this part of the file is often marked as "KVM" in the commit summaries, and
  sent via the KVM tree with Acked-by (usually from PeterZ, whom I am CCing)

- we are pretty close to the release but many people are still in Christmas
  vacation mode/mood

- the bug is not theoretical, Paul described the reproducer as triggering
  "rarely but intolerably often"

- writing this explanation almost took more time than writing the patch,
  thus proving that I reaallyy would like this in 6.7

Thanks,

Paolo

----------------------------------------------------------------
* Fix Boolean logic in intel_guest_get_msrs

----------------------------------------------------------------
Paolo Bonzini (1):
      KVM: x86/pmu: fix masking logic for MSR_CORE_PERF_GLOBAL_CTRL

 arch/x86/events/intel/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


