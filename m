Return-Path: <linux-kernel+bounces-153773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683DD8AD2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6268B20EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF9155384;
	Mon, 22 Apr 2024 16:59:06 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0D15383D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805145; cv=none; b=eHNnW5VdRGOpAsLgPjvBoN4DwAqK3RJ/dM+qBq9Ih1nj9VzD9d4EmcAcigo7ArdgqEp1oYFxnl1sHF+n8e2nOWmqmawjF0mwdc+n4s7jnuDKuY3l9vaManw3QD1vQ49D/hvl8LpDF/u1UYDHI9EINQxJnGXC1nzKVpeRCL1yThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805145; c=relaxed/simple;
	bh=0eNYc3U8bi8yFGwIPgL760ITQK0uo5T4ZF7tYuJAh1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/uWwLy1itgyDLkUSpOaSjyZNmmfd2D9b6TdwQGJYaZ8pJTYTcFyfaj0C5mu/1JN8yjR5owQCXHnCM6aaFyAjdFKRTOsR7eZDuCR7bTjEWhA2IFruQxMXbwA9qGHt5Wgczqh+Y85c/OB1DMi6ijb/5QG/69cEIm/xQ8GgLxdVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57217644ba1so643232a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805142; x=1714409942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgNecKF6e69eTU5ORwqqxrLsP2M1JB+/ViIEEiJZ4uo=;
        b=vLxssY52woEpm9hXEa5XeacnmEU7rxOvpWm/GsRIOuQX7EUzV4GjXSu1iZSRBOlTzH
         dauqFT7lrTpOiGIQ9+VQpxssrXpTGQhFaGFRikbPVBqCrwU2ZAwq51PommAoiOA/Usev
         9SVGyKh/3rC48Wz5PdDvj4T1uugEK0xs+tR1cwoDnpdAU4LRaUYaAuUemJJndRMIhS67
         z/lXlsxf08KZwgPsBQaHraxhmDatUQ8KqC5GtGaVSDO6OMgjeQN/Igzn0tys+91+LXf9
         bADG0IAygkqN2Kj0xUgxgTVmKFQ3DhIuc4U0PXQmrmeouOv5Cw5h5KPJ03hSni2PC/jU
         xndg==
X-Gm-Message-State: AOJu0YymLluVyYFg3swIMt1R6pNqr8IdutTOFQf+PeK8dhgSg4FosXdS
	wDmp1YnZo6e5ubvg/rCiankFAcBOhjtTfyfZV+Vq65lTW3x5hkAi
X-Google-Smtp-Source: AGHT+IGAUIfBNmriNWmrq9qh/66AGd5fePHPSkIfiX5W8VPoGe229RwikpGgOkvjuPqZxvqu818xeA==
X-Received: by 2002:a50:8d52:0:b0:56f:e4f7:fbd9 with SMTP id t18-20020a508d52000000b0056fe4f7fbd9mr7408789edt.20.1713805142412;
        Mon, 22 Apr 2024 09:59:02 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id p23-20020aa7cc97000000b0056fede24155sm5730216edt.89.2024.04.22.09.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:59:02 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: jpoimboe@kernel.org,
	mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] x86/bugs: Add a separate config for SRBDS
Date: Mon, 22 Apr 2024 09:58:22 -0700
Message-ID: <20240422165830.2142904-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422165830.2142904-1-leitao@debian.org>
References: <20240422165830.2142904-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the SRBDS CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 14 ++++++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 43dd45720fb1..fdf1c894fcb8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2718,6 +2718,20 @@ config MITIGATION_SPECTRE_V1
 	  execution that bypasses conditional branch instructions used for
 	  memory access bounds check.
 	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
+
+config MITIGATION_SRBDS
+	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
+	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
+	  Sampling (MDS) techniques to infer values returned from special
+	  register accesses. An unprivileged user can extract values returned
+	  from RDRAND and RDSEED executed on another core or sibling thread
+	  using MDS techniques.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 00c3438519be..49b60c0e2eb4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -608,7 +608,8 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
-static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+static enum srbds_mitigations srbds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
-- 
2.43.0


