Return-Path: <linux-kernel+bounces-107246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C513C87F9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815BF28305D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F454BCB;
	Tue, 19 Mar 2024 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="HZ3aT2qx"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78762548F8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837067; cv=none; b=hjC/jyHpfrjO9gE822bp0lapk5ztF/78deaKrmrx8499kvMmm+eKYtP2UezGS1yaUrZD69PjgRTKHI8RYFGP8FF9gdeYfXE39RexPBsfE9Cidu62mvB3krUGbkahWZmQrJP4P2IzuPycJ0Im9Ue6iDFDvNkBvSsdzTeEC40QT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837067; c=relaxed/simple;
	bh=9eh9Mce20G8kV32TZt3BCMXWNixzHImnHuGbC8f5HvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPK7dWIqVBLQWoc2nO/7paAE8JoC4uQkQNL88CmACnY7EmbT9Xm44E0GqDRDrYrjCKtFmI4ilWUx9g73uZ+DkjsE2+b5P3sM+7OIhWQrYfTauYEX+1F8ppSDT7NYXf0Uw8R+CKzIP0ZnpiVJoAQnOJq7k7vopHacMv/E96Yqhuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=HZ3aT2qx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29fa98705b1so1370098a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1710837063; x=1711441863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iC286gqeu87dpLs4MzEjxy2NyBEm8le59VZf4WE61d0=;
        b=HZ3aT2qxzOrL49vlXpjp70a8VLhH7QgDgTtVSF9zZceluP8860pb8YHxsM47M7m8Vc
         CbTPrZbXh/oU48qCEHPqJbTRtAtVyDA6UzlEt0gA4W6Z6O7hNSys4Ba1DQVtkNLua4sX
         nHrv5CS4ikiO8VdX9ST1iQS4zJ7PrwU4i/OZHJeEVqvEVGpp7d1Acoeap+MO7jQ7s+WG
         HwZsU1PxKrvK0xHv/MTNXzP3KShwTTKhan/uPL+ievVCFAugYEKOoNQkWkfodjcq7IwN
         l9qFVyZDozSV8ds9gUEPGxzfZbORtH/sKDKQaX0w7QPx4A/S0Htis2r0evg7Z2rqOPCc
         R+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710837063; x=1711441863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iC286gqeu87dpLs4MzEjxy2NyBEm8le59VZf4WE61d0=;
        b=PgRSZPURJfVHS8YjYqFF9BlS6p9UwE6W6IWOd7guV9P+LAJIoiQ2NfG434dLF8A18a
         UN9p2EAlBqpBWWGrnQwgbFWsMTORlYS8D9wkuhDZ9/Vl+3w8rebmpz2rMuhhz0Bedkbo
         1svUeC5jpS2fDiWfwQacMM65cTFE13AX1AAHYLYtNKcd0LJTnMcxoQqj5JkvixKqONxK
         i95wT02cWw3TxZR8LVbNHHrI5FQJd65T5FxHZCnJXn+PvTG9Nx2iSYFJkOFhhHauK8Nx
         2TY57Vq1KUya7BshY1BGDFh9pUOU4g8vHgZoRLf7JW9n+nxw22a2W9zBnOBhgey3QqvO
         XSRA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZC+g9OX2pqB6kOfpMwtDHeH3lmulUu5mZmvJcY78Peq3sXgojZ1EVsKwodJDpIuHxNIiFcv16qc4wbmr08/5gCmIb3mczTtAozWj
X-Gm-Message-State: AOJu0Yyr2crXrWXNazJxb2do8YA6ljVoz/doIKlina9K2DkyZZhFY81y
	+4CKwBQOspGDLvjyxqPA6/BVf7JMaE7GWnIiiLIw7mWbii0HgNsgrlbXK8IInFs=
X-Google-Smtp-Source: AGHT+IFU8wMBn+TegkCWAEmm0MesjQjAYvuEWxjgmyw2w+xFgWQ61hWTlvku1dpOQeyJSKuyuc/Trg==
X-Received: by 2002:a17:90a:c7cb:b0:29f:6753:ca66 with SMTP id gf11-20020a17090ac7cb00b0029f6753ca66mr1764789pjb.41.1710837062887;
        Tue, 19 Mar 2024 01:31:02 -0700 (PDT)
Received: from seacloud.vm ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id k90-20020a17090a4ce300b0029ddd0a6ed4sm9941249pjh.38.2024.03.19.01.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:31:02 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com,
	james.morse@arm.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v6 0/2] x86/resctrl: Track llc_occupancy of RMIDs in limbo list
Date: Tue, 19 Mar 2024 16:30:37 +0800
Message-Id: <20240319083039.223088-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After removing a monitor group, its RMID may not be freed immediately
unless its llc_occupancy is less than the re-allocation threshold. If
turning up the threshold, the RMID can be reused. In order to know how
much the threshold should be, it's necessary to acquire the llc_occupancy.

The patch series provides a new tracepoint to track the llc_occupancy.

Changes since v1:
- Rename pseudo_lock_event.h instead of creating a new header file.
- Modify names used in the tracepoint.
- Update changelog.

Changes since v2:
- Fix typo and use the x86/resctrl subject prefix in the cover letter.
- Track both CLOSID and RMID in the tracepoint.
- Remove the details on how perf can be used in patch2's changelog.

Changes since v3:
- Put the tracepoint in the 'else' section of the if/else after
  resctrl_arch_rmid_read().
- Modify names used in the tracepoint.
- Document the properties of the tracepoint.

Changes since v4:
- Add Reviewed-by tags.
- Include more maintainers in the submission.

Changes since v5:
- Update the documentation and comments of the tracepoint.
- Code cleanup.

Haifeng Xu (2):
  x86/resctrl: Rename pseudo_lock_event.h to trace.h
  x86/resctrl: Add tracepoint for llc_occupancy tracking

 Documentation/arch/x86/resctrl.rst            |  6 +++++
 arch/x86/kernel/cpu/resctrl/monitor.c         | 11 +++++++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
 .../resctrl/{pseudo_lock_event.h => trace.h}  | 24 +++++++++++++++----
 4 files changed, 38 insertions(+), 5 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (56%)

-- 
2.25.1


