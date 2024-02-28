Return-Path: <linux-kernel+bounces-84419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7823586A692
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C78286F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A61B7E9;
	Wed, 28 Feb 2024 02:31:08 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE136F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709087468; cv=none; b=BL18Y6O5tZsFPneSFdOOpMdVhy7o/KPSu8m8ki5VfLzSW+c0ppMAH9mm2zptvEpu3BRAppjWh2h8wE3d8ljR5uzqc3smjAaiXV4Ix4R3vGQmA6vs41OVzVm70q451r9gyCHCYmV408xu+urzvD9KYslo4j8nwy/rW6oqvOEmrv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709087468; c=relaxed/simple;
	bh=TDewXOwSKEBbU/n1ATOBooKhwj8GAiAew0DBEgkv0qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YmK+B+pJdH+5ZoqPKv3m4fsvncCodnXMhrjwZmt4G8uhOSGM0np/fa3nJKVh6K9lKuuEXf2acugQBBh+TwH+H5u0QNjQEYy8zqnKpHt7JBkvxsh3zKwSe/EuI6Nv6YFS3aieUVI4EctKm+UQzaH5pL6fJ5s+UJglQf4afQDJUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id C6736A96D0;
	Wed, 28 Feb 2024 11:30:57 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Ph-QfXkB3Gv; Wed, 28 Feb 2024 11:30:57 +0900 (JST)
Received: from localhost.localdomain (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id A2A86A96AD;
	Wed, 28 Feb 2024 11:30:57 +0900 (JST)
From: takakura@valinux.co.jp
To: mark.rutland@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	ardb@kernel.org,
	rmk+kernel@armlinux.org.uk,
	Jonathan.Cameron@huawei.com,
	gregkh@linuxfoundation.org,
	james.morse@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH v2] arm64/kernel/setup: Update comment on interrupt masking
Date: Wed, 28 Feb 2024 11:28:36 +0900
Message-Id: <20240228022836.1756-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225021812.4834-1-takakura@valinux.co.jp>
References: <20240225021812.4834-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

Hi Mark,

Thanks for reviewing!
I agree that it is more simple/clear with the suggested wording.

Sincerely,
Ryo Takakura

Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
---
 arch/arm64/kernel/setup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 0ea45b6d0177..65a052bf741f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -298,9 +298,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	dynamic_scs_init();
 
 	/*
-	 * Unmask asynchronous aborts and fiq after bringing up possible
-	 * earlycon. (Report possible System Errors once we can report this
-	 * occurred).
+	 * Unmask SError as soon as possible after initializing earlycon so
+	 * that we can report any SErrors immediately.
 	 */
 	local_daif_restore(DAIF_PROCCTX_NOIRQ);
 
-- 
2.34.1


