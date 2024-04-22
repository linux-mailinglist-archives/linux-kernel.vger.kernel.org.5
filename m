Return-Path: <linux-kernel+bounces-153768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE48AD2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80941B25A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770D3154C19;
	Mon, 22 Apr 2024 16:58:58 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77084154454
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805138; cv=none; b=BdypewaEv2mU7mKMqt0cZhJove4cqa21QB/h2f8W/uaxTZNpASZwQLiSBsqIyMEgVQWQ5MiPFjitxo5RdF45AleOlt9Rv68vINsaMzgLxaDyVqy/CDsRPm5a6GNji5bHuwY7pNK8kYFZUORsgTLGIVt7EZvPmyPN3LkXGFwzw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805138; c=relaxed/simple;
	bh=3A12Je8N2N3tDKk5OJkio/7RhXVpNZtBOA/vmXVCnuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPNpP6ZsCvq08MiZzH6ogE0qcDP3s+8XRg8d2cycqPKmwpcqNLkllAvBR9L7j23JHCTOGx+78kfM1niVDYlCPAmb2ISKpjfEikFyy11AdzpuosZkHSTVg8UacnQbPW30ntr+OMNv2JjgIm/nTK2JaD+SoQXGHefIib/lXkj05dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-347c197a464so3489052f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805135; x=1714409935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYD1WGAneao6/IXWzO2Ys5ucl8QyNywmWKSSkk1/LxU=;
        b=Vr4CcIumQGzM1VmFfWnypZmULmakzNUja+FlGa64F2aic+D/NaCnYun1CqAxhHVnAd
         +rOsCott6f5r0qwnNXB4oo4XSR6DDc/5fOxkS0xyshbLgGKkr5U88KrWwtYmVRU4CYbS
         qT+A2pbMPr61MstIJuWPLLceH6rs43NsIW3nm27bFphi5CxX+sxwV0tjdPDWbHun5Hk5
         McavKCFeI5roCHO68GUkNUHyOPoRfx7VHQFkti45xMrp5A64khbAj1Hu/qEKDUfzI5Zj
         ihJh0Hyi1rw5kXJgmUomKoXKgPsRX2279AqeJll1KfmOfocyvTQzjzKleR165mL6/omp
         sv1w==
X-Gm-Message-State: AOJu0YxxdlghYeMj+Ire5a6kSaR+pYgpt6uMOGoIxK54/ERs+zphSLNn
	/TCJ+EERFj8lnXhbHOdK7PW/l71X8AcAhiKR9zKQLHnuvVG7+xsZ
X-Google-Smtp-Source: AGHT+IElkgHGZ/eFalN1+eHYDS1LXVvvJEumR4Ymv77dPjVSsSzJCFl6lewge/1+OYwxdEHRGr/FXg==
X-Received: by 2002:a5d:45c2:0:b0:34b:5d10:1d48 with SMTP id b2-20020a5d45c2000000b0034b5d101d48mr283794wrs.26.1713805134815;
        Mon, 22 Apr 2024 09:58:54 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906504e00b00a558014ab2csm4933932ejk.145.2024.04.22.09.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:58:54 -0700 (PDT)
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
Subject: [PATCH v3 04/10] x86/bugs: Add a separate config for MMIO Stable Data
Date: Mon, 22 Apr 2024 09:58:18 -0700
Message-ID: <20240422165830.2142904-5-leitao@debian.org>
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

Create an entry for the MMIO Stale data CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 12 ++++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c7ce800fcdb2..bba5b65034dc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2673,6 +2673,18 @@ config MITIGATION_TAA
 	  which is available in various CPU internal buffers by using
 	  asynchronous aborts within an Intel TSX transactional region.
 	  See also <file:Documentation/admin-guide/hw-vuln/tsx_async_abort.rst>
+
+config MITIGATION_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 87f3cc6c438d..21daaf202b7f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -393,7 +393,8 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+static enum mmio_mitigations mmio_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
-- 
2.43.0


