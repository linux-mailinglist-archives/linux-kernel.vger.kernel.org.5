Return-Path: <linux-kernel+bounces-135138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A789BB8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F9F1F22D1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383BC4595A;
	Mon,  8 Apr 2024 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="JiIH9CeM"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09F38FB9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568243; cv=none; b=taNupUtIRF1Q77VlGIQ+pp8qGvctC7Cnmp2swrnK+fkMzhzIGEmNX7239DHkrt0Z2j9D4iVVYV5USnjDCZtWLnWNw8lycedS7bY10qyjv+VA4VZ6EZ86A9CCxQxPmVxLaHJZpkAj3rBALdNVY9xV0UgBPq8AjSS6zr384zZGTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568243; c=relaxed/simple;
	bh=ICs+u9rBG30iLIjqnwXZWGRQcWcMg94L9Zi4ej2fBQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YBnGnRYqbYIXFsh6kZUcNV9/xaRDj5g8SXxQEAH092x2nj85voUfCOV+GgRDiGFAyj4K6O8AwiCSzI8C7XrWGLdVskFQAxB3Xyl5fM65wjyOI2r4RA+jdZpK7+7cMN9QRv3QkxUv1R6jBRHNasRwzDmQy7jGR/3Bs1XwR6Y0ZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=JiIH9CeM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3199315a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1712568241; x=1713173041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeAbRrJDztscl5/TW7V1ARLwQeuNe6mEEXuD02Yifdg=;
        b=JiIH9CeMgynto2NyxCffV39aSrwn1c6s2kK0c6kkIPBhhEoM31Vn4aD7udHGK9V7C+
         EJLo6BmAoyUo8k/Pz6rZ4CAnEmGtn01FK/UOfsrliGuj6PUmtQ6XEUgLPlz6uIaUyWtU
         uz9pjNHxgd4wb7c1i7edU7+GcKKATRc6tyv8WStvwYFpjY12zqQ0QGQUyy9nO0Pc1Rng
         I9vNqjJ3Pcpn0/x+t4UxRHLoHAXCf4tWMzXf0OK093aGRY0FxbOik7sNPVhC38V8fgiz
         FNQY/nCXJpXcsu+TszuRD1qEzLF1lhRii3SI61aFs6C/aqCmojl4axSDMRDTskA7Knwp
         jlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712568241; x=1713173041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeAbRrJDztscl5/TW7V1ARLwQeuNe6mEEXuD02Yifdg=;
        b=PADCpwEsXGtTT4W/XLveWe2AJZUtkPM1T6Lkux69koLPVi351ooDA5P1KELZu8x3rf
         jVJMTR1vIAN6tUIQ2bx6Oc0re3dy0nZgZ0Py7Agleja0udXmi5gsoBMPfunxRtWLAYRl
         PIuq7EUal5QF8Sp9w6t+P5tqjuEfHCd/H/RtDt4mgSr1fmUmdWmgbRuvVle2D19Uf/bM
         T8mmPgF5hULfGcLATbtfYhYNRWR+sbRdX7IE41aydVAa95M8LPfkZ19iF67krf1TemOC
         Rl2mrsefONRK7rZVsMHaz8L88q7B9MSHfqxVlrm7QLrFTbxyABscsYXwk/bR+AWLQDz6
         vryQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV5G9YFmumAnP9tFecFe3ZsLwJvumfW1+7a493P3azzLuahxuhK8QiCPggutrch9Z7TN7b7pTKggVM3vWby9SrofSMfXNeCLrCwjky
X-Gm-Message-State: AOJu0Yw0G20gutBufDRhXWADyKGSllBKQBBhcWREokfYEkSyIvF3fyzT
	fnwl9jZ8WJEn2Bnpi8v6iN8c1z0xMpp5Ie4v9l8raegkRlJTShrdgPGVVnpz0VQ=
X-Google-Smtp-Source: AGHT+IGiGt/VGr1bX2Yiw0D3BskqlspmfTUIHtrmQu+g7RLq1HRe3/xZmJQ/zwHYv3XKJbJ9OaS96A==
X-Received: by 2002:a05:6a20:6a0d:b0:1a7:8ef6:12d2 with SMTP id p13-20020a056a206a0d00b001a78ef612d2mr425870pzk.18.1712568241381;
        Mon, 08 Apr 2024 02:24:01 -0700 (PDT)
Received: from seacloud.vm ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b001e293b16d8dsm3258731ple.1.2024.04.08.02.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:24:01 -0700 (PDT)
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
Subject: [PATCH v7 0/2] x86/resctrl: Track llc_occupancy of RMIDs in limbo list
Date: Mon,  8 Apr 2024 17:23:01 +0800
Message-Id: <20240408092303.26413-1-haifeng.xu@shopee.com>
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

Changes since v6:
- Add Reviewed-by tags.

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


