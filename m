Return-Path: <linux-kernel+bounces-47909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E984547E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD21F28F03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D464DA0F;
	Thu,  1 Feb 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TQcDCnUs"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A154D9F3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780800; cv=none; b=GIDH7B2XYeCaJij/iIOOzoqRM647UKqliVQf3qBg1xygzDUkO9uu1aF2LLdBW6S0h33NxVuVOpe1oIv0J0IHPvPt3bCe9VwA6Cm2Qotx/xqojFV9/4Sfa0BHZxl/XwcZJY7c8Fyzr9oKzZpZTjx7udGk0zDHFwaMYvBUtvsG5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780800; c=relaxed/simple;
	bh=kKYjNvK4oZU2NxCNeQBgkFZ76JqC6AzlS/9Mqhq6mCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYtQCHxSCpHSeWzkvkIi0Jhp6lT5rZpISqITFP2pIK/uHg1XeOaM3VbTxlkWiKjbk/cFRxP9D4Gaq41PK9k/Nw/RcAuu5U7g1tZ0iJeveSah5rEXB4tctBblm/juX7/Q6EQIpZwk5kt86P3qPTIQUWHtje/pylQy4InblZcThWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TQcDCnUs; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4119k4ts3918155
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 1 Feb 2024 01:46:08 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4119k4ts3918155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706780768;
	bh=vjcWBDBUoGUeHxYNPS1IXd9Yqbe6TvxBMc8AURC1JUU=;
	h=From:To:Cc:Subject:Date:From;
	b=TQcDCnUsBgOp7A8Zkl2vhlqR/KfyWh0fS5DNQVf5IFXKEZJKl+wTAIrbPDLKJnRRu
	 MCNm6DZTwPDb6t+8Op2gg5TgKLzZUiOzPGlVrfmuPq2YY+acyrOAmrzVumRvb4x6Ht
	 cQcesLQdNd4aP9NUp/mgcTiLHyruFT5FgGH/MPMTrZ0Mh4qvisn2hAgKHr0RSI3u8E
	 6eSmTlGlSS+krY51Hl5bCZVaiEPmILxMVDllD6YOiGR7jtmWMMBF3wEZ+ytbz8D8Ww
	 UJVE3a5G+rczOUNJ4NG35Z5vNcFSsFMDeEr/+Q9c3pGrKDdbECHhvXCGwDmgPFxJHy
	 Y4llq46gDffuA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: [PATCH v1 1/1] x86/nmi: Remove an unnecessary IS_ENABLED(CONFIG_SMP)
Date: Thu,  1 Feb 2024 01:46:04 -0800
Message-ID: <20240201094604.3918141-1-xin@zytor.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IS_ENABLED(CONFIG_SMP) is unnecessary here: smp_processor_id() should
always return zero on UP, and arch_cpu_is_offline() reduces to
!(cpu == 0), so this is a statically false condition on UP.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index db1c1848a1e6..6ba713406262 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -503,7 +503,7 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU))
 		raw_atomic_long_inc(&nsp->idt_calls);
 
-	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id())) {
+	if (arch_cpu_is_offline(smp_processor_id())) {
 		if (microcode_nmi_handler_enabled())
 			microcode_offline_nmi_handler();
 		return;

base-commit: b2803076903a83ea927c7f34deeaddf75ee38679
-- 
2.43.0


