Return-Path: <linux-kernel+bounces-153766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAB18AD2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5769AB2538C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB86015442C;
	Mon, 22 Apr 2024 16:58:54 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1950153BE8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805134; cv=none; b=H35o5PWoGGJZqiWKS+sWEYlZlPgv9W3pe07elZT6M1upXpq94hdTwwS7ozbZJ4NY5MpJDUAYJLUmDjCVvqfGTstD2xMoySGLMf2RtyS3Sdl6MRmXXETrxTLAZOfFBhD43PMLMaetMAgNZc9esvNFbZzImd9zwhu+PKSRzsUaZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805134; c=relaxed/simple;
	bh=4j2F0EFY2Yri+8LKZZQa1pCui+wm0yqkixqXtoGKqRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpW3AWX2f4Se2D2ACfLn2x9aqP9GwFWJ87Rj4tWdokBQ1rJlzHAHOx5ymBxSu1y8QASDBzKWeDnzkDIQwR/OemSHGvUyBw4hw1CewLszE7zmt6vO3a2JTWbm5Xfk5RqZFXsviD41YSyDeiLSGaz6wFzYipmS2kRm86U4qLSPlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso5738389a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805131; x=1714409931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK705pcIgnhmhCzc4RbNjj6wL1B8xNlcTBtJq2Nw8E4=;
        b=h+b9dSbr/HWGAZ+PszSxhPXvRtmyS9ULYHZhUDRkpG2w4CIJbBv4i7OeHJaADlxvmP
         S6eHj1xSDpVpVvCCUcQw0x3TBh+O29p16DK6OdWO0v3K8oVhyN8zgjRBeZrF4A532kLd
         Kt+wLSR4YfhoxL/jx6Jd39CHg0vGcRM+rxhgaQLU1kyTV6H7ehRlVk/Skm+Veg4YFQXE
         iW66QAWCyOTvZ30/LnOVRA296qTo/aS4Gp/hJOeahraXxJh8D3AGwCeOQ34YhcppEatq
         ktUS6jx8pmC3l9Imeh9TgYuZn6T0pWaYYC9Xd/0d37ZiI+IxM1KYg23RMqkXYUgkBjrw
         9iIg==
X-Gm-Message-State: AOJu0Yxe2/0rPrQWQQV89U0k2NDIPZY9MXMt0N+Zsau6QlDhOPgPIZHb
	2HNZjnXHnx/jDpC4eSC2owT4h6aofj4qmMM3XcYVlywH7iA7UZOZ
X-Google-Smtp-Source: AGHT+IGGgoJyWOIdgqTLHjaCOVGQqIo8EWeZYJevCWHkYfuD9jSpb6viiEarBZbmugs3VNfqkTbUkQ==
X-Received: by 2002:a50:ab17:0:b0:56e:2f2c:e249 with SMTP id s23-20020a50ab17000000b0056e2f2ce249mr7133310edc.7.1713805130787;
        Mon, 22 Apr 2024 09:58:50 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7dc0a000000b0056fe755f1e6sm5678307edu.91.2024.04.22.09.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:58:50 -0700 (PDT)
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
Subject: [PATCH v3 02/10] x86/bugs: Add a separate config for MDS
Date: Mon, 22 Apr 2024 09:58:16 -0700
Message-ID: <20240422165830.2142904-3-leitao@debian.org>
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

Create an entry for the MDS CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 9 +++++++++
 arch/x86/kernel/cpu/bugs.c | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d99b758c8d35..5d0227b50faa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2653,6 +2653,15 @@ config MITIGATION_SPECTRE_BHI
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
+config MITIGATION_MDS
+	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
+	  a hardware vulnerability which allows unprivileged speculative access
+	  to data which is available in various CPU internal buffers.
+	  See also <file:Documentation/admin-guide/hw-vuln/mds.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f2bdfb359f6b..fb6515b1b33e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -233,7 +233,8 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
-static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+static enum mds_mitigations mds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_FULL : MDS_MITIGATION_OFF;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
-- 
2.43.0


