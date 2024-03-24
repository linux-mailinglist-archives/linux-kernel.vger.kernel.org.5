Return-Path: <linux-kernel+bounces-115338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5048893AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773B6299BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05F51E5F63;
	Mon, 25 Mar 2024 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL1rhFvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4537F7CD;
	Sun, 24 Mar 2024 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320476; cv=none; b=P1MmbcjIwaLG23BMHwBg+eR1FnGmuDHvhn1qYqCO29Ec1wQEXs2k2kFi3Il56cgaltYqGxKvE3WhCV4foT1Eqmt6lLBkfbYxrf7ITDXiImaCGqOsrf2GATT5+UmSLQ92ASWsJ7dY362G+H2qxZ12qa0S1rEteGwokt4A9cI+qs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320476; c=relaxed/simple;
	bh=DM56fWUpnYs8NKGcPFxbzDsx0rC5E5rIw5nd28XokT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmf+goJqLyCqLW4jKhGnLaDS4N8wruAM6rczLXxRNvDCYRATjkLzZv6rwXS41X6UXwa+vS5dDtlRgGFyl5cx/Bdyui7KeZiqFlZ5Lm5N9SpAYoCQD7g+QIs+0KDE5Xv1p0ryjIm9tUN2Li0U/LfI6Wt1UFZF12FbpRsmfC729ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL1rhFvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C263C433C7;
	Sun, 24 Mar 2024 22:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320476;
	bh=DM56fWUpnYs8NKGcPFxbzDsx0rC5E5rIw5nd28XokT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HL1rhFvlgCfPfrBvKifhzOHGaHbz98UqA1Kt6/B0UfIwgjUovv5iJvslQqt+5mX89
	 1WhmYo2P6f06tJVbZI3O+PuRT9UGjVYkF6NYZGDkIeFERry0WoT9aPGB0UQokNrNOt
	 L+Txco/ftazKy7NARwdY8c+o2Ho8ydu60lh1GuyTjnobGgk+WG59T0WaYSXeZERE9p
	 6GtBwv+YNV7BDZ+DofrosKBvOSYKRF2LTVE7yMWU/Gag9a9iGRcnKrqAenOfhgB4gJ
	 s2wTMEKMlQSESk49EtBaCiA9XBr+Gf31ayEqr9I+huE/KGB7lBTPN3NLRXQt3pLRLW
	 SRGyrepIwT4Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 035/713] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Sun, 24 Mar 2024 18:36:01 -0400
Message-ID: <20240324224720.1345309-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 250f5402e636a5cec9e0e95df252c3d54307210f ]

Fixes a bug revealed by -Wmissing-prototypes when
CONFIG_FUNCTION_GRAPH_TRACER is enabled but not CONFIG_DYNAMIC_FTRACE:

 arch/parisc/kernel/ftrace.c:82:5: error: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Werror=missing-prototypes]
    82 | int ftrace_enable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 arch/parisc/kernel/ftrace.c:88:5: error: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Werror=missing-prototypes]
    88 | int ftrace_disable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index d1defb9ede70c..621a4b386ae4f 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -78,7 +78,7 @@ asmlinkage void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	static_key_enable(&ftrace_graph_enable.key);
-- 
2.43.0


