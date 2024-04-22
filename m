Return-Path: <linux-kernel+bounces-153769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90D8AD2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EEC1F2191A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CF61552F9;
	Mon, 22 Apr 2024 16:59:00 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDFB154C12
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805140; cv=none; b=mqHBwB2ECECBURLax9TGEWnDzAymAGPy1zP9rlBG3Y11SbIPctlwNa8WNVV0+mG49cza9xCYsh3ib8qTw/5vs9yaj6zQlqV+67Sb4iOtZbSG1NZUHsbQifUv/2Mh0b7b53n28rIo08xZAfuvKD1ZwZM/04fMKeEVjWQAKy2AwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805140; c=relaxed/simple;
	bh=Fjjwd9JMyXBtYEIPinJUKp5+nS7NszZndg1YDzHArOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgPeMWrEbpKxodE01uXT7+lE1GP1ZIHP1Ituecvwl49ExfPFZUP8n/x+zHTEkeH9ZSFlJ5qdjKNrg1BikBc8JpxFlBzCxDP1+/NSkafBa8uK0F3ADXzLSYEvmguSqCT/Z23q+oyRU0riokcXHgY6yyBezo//56TPBDkTe2t/4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34665dd7744so3539565f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805137; x=1714409937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcxZMik0TKevJdYhFoU/PQpjeiPff+g7faQ8eEohWOM=;
        b=DpqUhgxNAKxqw0WOjyhFje6iaJ6GnMSAPXiZXS6SVxix4m/OSUjFHX4MB+ohdw39J6
         LljkQ0i3zrMaxu5EDgpqZVgZL7UMirL9bH/6pPtzgIfcYNZ6Rz9KURpq2s2u+0qPR2wF
         hOjMPj1gi1oQBVRF5L5ewZyo90EWPCaajinQ0Lc7qTeWZZWc55EAKyJlccr5y0f74CoO
         Tt+Wrz8k5Siu5YBt/DnGM6PhrRyqIYjnQjEobLakm+NMPrVje7gynBhzj/lyNmWIe788
         NHsovbFkFGOzlsEoOGs63erhyyO4CB5qqYBiXD63d2JD5pbNWoogoWGRPg8anAyx4kI6
         ygjg==
X-Gm-Message-State: AOJu0YzPO7cyH2naCq+ZnnUeb6CuRmx9zLWOs1h3gDiMJJDP+/MJbJc9
	6XvF4vkKuUh30xPMKeM9ONA6xPlNU/dmmBzmxF4HCEuYPjlfvW5T
X-Google-Smtp-Source: AGHT+IFqbwGIM5IHp0KMW3LoQg1VfO9D2TyJ2R2GVaZE4/ZnvqlBuYGGKO/fTTHY3crNhp52NwKRhw==
X-Received: by 2002:a05:6000:1212:b0:349:c76f:c737 with SMTP id e18-20020a056000121200b00349c76fc737mr6751728wrx.47.1713805136761;
        Mon, 22 Apr 2024 09:58:56 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090615c900b00a555be38aaasm5941202ejd.164.2024.04.22.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:58:56 -0700 (PDT)
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
Subject: [PATCH v3 05/10] x86/bugs: Add a separate config for L1TF
Date: Mon, 22 Apr 2024 09:58:19 -0700
Message-ID: <20240422165830.2142904-6-leitao@debian.org>
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

Create an entry for the L1TF CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bba5b65034dc..192d20348b41 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2685,6 +2685,16 @@ config MITIGATION_MMIO_STALE_DATA
 	  attacker to have access to MMIO.
 	  See also
 	  <file:Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst>
+
+config MITIGATION_L1TF
+	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
+	  hardware vulnerability which allows unprivileged speculative access to data
+	  available in the Level 1 Data Cache.
+	  See <file:Documentation/admin-guide/hw-vuln/l1tf.rst
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 21daaf202b7f..d20299b350d7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2373,7 +2373,8 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+enum l1tf_mitigations l1tf_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
-- 
2.43.0


