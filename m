Return-Path: <linux-kernel+bounces-121152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F9688E2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56B11F29334
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8259D178317;
	Wed, 27 Mar 2024 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVlWiT5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7F178307;
	Wed, 27 Mar 2024 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542215; cv=none; b=O55dqZNr5ApbAA3dB5OemZjh6nRkJFD3Ivuw8UzMu7US4mmRXQ7Yv+vd0xSnccFdp4QSgT/MVuv0KJzH3/L7j2PXH02yq0Vc32m85wnA0jGFDAAYIrkcSL/zPiM2WSkeaetyvJzl4oSL23fJhWwmdHnTwQff29jTFQK/tjG34zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542215; c=relaxed/simple;
	bh=M4cEZc6pH2ZVDPLDAgKpeqysBEuqTnjTg3HjkXM3Nzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDXoqJAMCRMTS+qoJL6W55D3TIOHnriE7JWwg5ef0Z+hP2jp1JCfdL86I1MkFvAs7VgFg3qJWEU5zwK5fSN9JldYe5W7gGo2fC0LPMjn8OqYe/BG8FR4wVjsRmAE5UYCmTwqWs8/zCGrstqnItZQH25CMEjD//6uOP3Iml0fnVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVlWiT5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FE7C433F1;
	Wed, 27 Mar 2024 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542215;
	bh=M4cEZc6pH2ZVDPLDAgKpeqysBEuqTnjTg3HjkXM3Nzg=;
	h=From:To:Cc:Subject:Date:From;
	b=dVlWiT5L5ET/nSsk+0TWXo9NbakoBwZw/CC3N/MwGcaGDtiREE+HbrSBgy3CtzV4K
	 tUpEhPk7p1N8tLklhn7/EgVqXBp7FlrgrP0MkLJ/SCvXft7W1fOFCarNRrhwPNedN7
	 GMZ2rr/KyjpORxjO7GNe6y3bZ+lsD+/1Xn2YPH7wqxBrUeP1zoBpUyPiltpdW/qSin
	 MOgbT+IdL51Gmy2xO40ct9/4gLjzwwRSh3E2aSgVq5uVMDqRw6+xdEKZJ2Fi5A3wdC
	 1csLJ9aktiOCoQYLGvzR2Hpekk6vqLh1ZLj13ObL7aFrkUDDmzX4tU9SiWVp317qmD
	 ov4mGAv25+UhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sohaib.nadeem@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:33 -0400
Message-ID: <20240327122333.2838651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 194bef0cc1f5ce5e2ca84d366c74be2bd9736aa3 Mon Sep 17 00:00:00 2001
From: Sohaib Nadeem <sohaib.nadeem@amd.com>
Date: Mon, 29 Jan 2024 17:33:40 -0500
Subject: [PATCH] Revert "drm/amd/display: increased min_dcfclk_mhz and
 min_fclk_mhz"

[why]:
This reverts commit 2ff33c759a4247c84ec0b7815f1f223e155ba82a.

The commit caused corruption when running some applications in fullscreen

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index ba76dd4a2ce29..a0a65e0991041 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2760,7 +2760,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
-	unsigned int min_dcfclk_mhz = 399, min_fclk_mhz = 599;
+	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
 
 	static const unsigned int num_dcfclk_stas = 5;
 	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};
-- 
2.43.0





