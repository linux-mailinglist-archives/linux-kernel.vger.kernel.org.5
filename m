Return-Path: <linux-kernel+bounces-153767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CCF8AD2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CA8B25729
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743F4154453;
	Mon, 22 Apr 2024 16:58:56 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95B153BFF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805136; cv=none; b=rMWNELjBlWGOPYCZNcSVCn8il4Nzys/KvffKTO8Brga7i/JiPJgJc33sFefzWqxVWO1j+SX44w93tMXOWCC/ZvMAQmu2HWVMTFm9mS1idjIPpUWDzYY4Fxm8991RKxxT2pTOfiC2ja5/wGzwqehXQrLVGP7Us9JYlAxeb90MJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805136; c=relaxed/simple;
	bh=Qmp5+zGyzuWu/JzO2kuQaFdzbwby1isRVhT5C+Q3O5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8YGaTPaPfvf9Xoo2g2lyQvjKWBr2z879mOBdA5jM5eyGPsx5kYyjXTDbtqVQEok5uLI1MYcHpIN3LYp2+xj5pMYXCFrDogHE/xneeUnTmXCBEZjDqK2gtJSEJyfTu7wYiMyVHTawxczhQAl/DvHF1qcxlwAWASACZn//vgCb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a55b0213a0dso184268166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805133; x=1714409933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=molyJkYPrlpsod52dTAqAh/H3c51fMrduV3arIMX/F8=;
        b=JIpQGvPv1soBu5CF4U5Mj6j4R5vWVdJbL5FAiKhLoZ4oCO9pYKMw8mu3qWNCINdrlc
         gFKo7VdN1+LeRj9r+aSzd2zIGGcufQZPJIZWYmDE9rH+mzBNOuvvCgxeVCKC0mTDsmdA
         TXB3Sx/t58zGhnUbLnJbfIcbeNdw+IBHzfUoLrSt6dYeoVBgGb1MFHcuIDY5qitJRLXL
         N3IEoBg7/Opg4Vf46L1Yd7NyInVGDqkj26l+u4hbYIMPRGhEBVZ2pQ9YfEEUee7OYTPF
         piFD7cUNdAXSkF9me4zHgeIKzY3s2pXtXO2GWNSVdQMtiMEw4T9p24+1Pb+dZoSJxuRQ
         Tf3g==
X-Gm-Message-State: AOJu0YzZNL0Ch6c3Vz1vKUSU0ZCAimLZZfZlq3V09piAOdfYgBu+lJdl
	mWwG42FIn0Ll9n6t66Y5Ecr/eNEdwFq8HwTsFTyPyMsZRgIm5B7o
X-Google-Smtp-Source: AGHT+IECwH6f4odSqajI+L0ebMJpuroLfwnYHt2+zDymfQ7G2oMLL0zyhhTOJetwDL3Mj7o7fgBxEw==
X-Received: by 2002:a17:906:3106:b0:a52:57ee:4464 with SMTP id 6-20020a170906310600b00a5257ee4464mr6642683ejx.19.1713805132739;
        Mon, 22 Apr 2024 09:58:52 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a522f867697sm5925075ejz.132.2024.04.22.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:58:52 -0700 (PDT)
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
Subject: [PATCH v3 03/10] x86/bugs: Add a separate config for TAA
Date: Mon, 22 Apr 2024 09:58:17 -0700
Message-ID: <20240422165830.2142904-4-leitao@debian.org>
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

Create an entry for the TAA CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 11 +++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5d0227b50faa..c7ce800fcdb2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2662,6 +2662,17 @@ config MITIGATION_MDS
 	  a hardware vulnerability which allows unprivileged speculative access
 	  to data which is available in various CPU internal buffers.
 	  See also <file:Documentation/admin-guide/hw-vuln/mds.rst>
+
+config MITIGATION_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+	  See also <file:Documentation/admin-guide/hw-vuln/tsx_async_abort.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fb6515b1b33e..87f3cc6c438d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -294,7 +294,8 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+static enum taa_mitigations taa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
-- 
2.43.0


