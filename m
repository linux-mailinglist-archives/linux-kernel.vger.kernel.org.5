Return-Path: <linux-kernel+bounces-108615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C4880D03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F85FB23854
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A129374CF;
	Wed, 20 Mar 2024 08:28:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B846438FB6;
	Wed, 20 Mar 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923334; cv=none; b=p4vbiYfNluc6YB6dKqQN2SuGa6xrutZt0SjjzvG6KZJVkR5OjiAimskCO3eRg79GpFQWpsi0zEVc8aP2W/0LcEeRufmmvUmG1V7dlsZGgSEKKuym8danXqXXLQ9kI19FEq3OIQJKL/Dsat3j7S2VnFMjWM+Eei4GLNXnVI+V1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923334; c=relaxed/simple;
	bh=O86kC/nBu+0ytMYN2Z0A3TlwR/TL+tNc4Uu3IXZHekY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsAdLOGqjNAZh2E6pGjDrmIXyZ0dCNXXOnwkDpPRk993esIMyrHhSyuZUClCynO2Ed/RSr0Dun1EslFv3mFMZhm85izUssbsIpVAIElyM4Yi5VZJPWi3+WIgYIg0qMG/3uoIp2fE1QKn99ieullJp4lt/grenO72m1pg04eCMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,139,1708354800"; 
   d="scan'208";a="198441850"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2024 17:28:50 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.11])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 808BB417039C;
	Wed, 20 Mar 2024 17:28:47 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
Date: Wed, 20 Mar 2024 08:28:30 +0000
Message-Id: <20240320082831.9666-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The r9a07g043_mod_clks and r9a07g043_resets arrays describe the module
clocks and reset signals (respectively) in this SoC and do not change at
runtime.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 33532673d25d..e36d2ec2c0f5 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -149,7 +149,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 #endif
 };
 
-static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
+static const struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 #ifdef CONFIG_ARM64
 	DEF_MOD("gic",		R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
 				0x514, 0),
@@ -282,7 +282,7 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x5ac, 0),
 };
 
-static struct rzg2l_reset r9a07g043_resets[] = {
+static const struct rzg2l_reset r9a07g043_resets[] = {
 #ifdef CONFIG_ARM64
 	DEF_RST(R9A07G043_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A07G043_GIC600_DBG_GICRESET_N, 0x814, 1),
-- 
2.44.0


