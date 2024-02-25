Return-Path: <linux-kernel+bounces-79926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C598628C7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B81F2171F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397046AB;
	Sun, 25 Feb 2024 02:18:41 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79971C01
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708827521; cv=none; b=cYRyQ59Jbpojw6oGygOExb9GqRjpopIQtBeFY26uufyFmNrPCPRmDFDQblgDSxzLRfBFCy/4dKrO3XvZ4mvJGRHLauWMX/Xl6l9nqqYvCZ87fL1l0GVtXi2N7CISnnv+vXezflqDkZYaVsPQe0ZHi2O8M0e5CxqkQVTtM77j5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708827521; c=relaxed/simple;
	bh=gcBF1+aClADX0NRWekLAdsckdciGHrFDD7NeQvgKGCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JTF3ZsPfCdcL7EVdUfeCPjAdaoFdbQH9AIkKwMEcd5E2ttuxfo308ht2kVkzf/4unmxcHxor36Y/jjzM7IpjTm16GXSEnOKdd3YShmJdEF8Ol7OtrPQ9hcGBjlNF2rT4JeDwudK07UZydxvieDC30IMR/P+MpYwhuPx3qQlNYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 6DB74A96E6;
	Sun, 25 Feb 2024 11:18:36 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJb2ONr3jnWH; Sun, 25 Feb 2024 11:18:36 +0900 (JST)
Received: from localhost.localdomain (p10626078-ipngn25201marunouchi.tokyo.ocn.ne.jp [153.201.134.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 1944DA96D2;
	Sun, 25 Feb 2024 11:18:36 +0900 (JST)
From: takakura@valinux.co.jp
To: catalin.marinas@arm.com,
	will@kernel.org,
	ardb@kernel.org,
	rmk+kernel@armlinux.org.uk,
	Jonathan.Cameron@huawei.com,
	gregkh@linuxfoundation.org,
	james.morse@arm.com,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH] arm64/kernel/setup: Update comment on interrupt masking
Date: Sun, 25 Feb 2024 11:18:12 +0900
Message-Id: <20240225021812.4834-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

DAIF_PROCCTX_NOIRQ contains FIQ bit.
Update the comment as only asynchronous aborts are unmasked
and FIQ is still masked.

Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
---
 arch/arm64/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 0ea45b6d0177..9b9fdb64c684 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -298,7 +298,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	dynamic_scs_init();
 
 	/*
-	 * Unmask asynchronous aborts and fiq after bringing up possible
+	 * Unmask asynchronous aborts after bringing up possible
 	 * earlycon. (Report possible System Errors once we can report this
 	 * occurred).
 	 */
-- 
2.34.1


