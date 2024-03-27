Return-Path: <linux-kernel+bounces-120995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355AC88E154
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC884298760
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96031386A4;
	Wed, 27 Mar 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/0Ryloy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933E157466;
	Wed, 27 Mar 2024 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541792; cv=none; b=NFRjnArjVoS0w6owoVyo3jEGS7SImzh6G8uRLvFDbDgDELalU3qAX42xYCRWY8ezR8sDX4f/5Fo9g8lbd6Fwe2A2ymH1xFuODhVEsf5jmB/hYHLlNBqrF2c2twsenBX1MUeQ2x7hbGnORqQ60rueOas0HqhsSghUBx6uQkdEAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541792; c=relaxed/simple;
	bh=FujCHVpJ5gIRHrfDclljDZRoTl+bci6ruXRGgOBsMmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7d+011y7O/taPkMI8DQDSj4lbI7l7lvGbsmsF71lUOubX1AL4FLlB1z7zv8c+c25RC2I5IpDzFQ50rEQmLB6zF4NDwPE3t3Axh5dT2J3rPC7bUhn/oSaK8xa14qvlMPxPApL5911XeWy/MyEuaEvpi+Cl8Wy0SqesHl4fS3NFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/0Ryloy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72727C433F1;
	Wed, 27 Mar 2024 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541792;
	bh=FujCHVpJ5gIRHrfDclljDZRoTl+bci6ruXRGgOBsMmo=;
	h=From:To:Cc:Subject:Date:From;
	b=L/0Ryloy+BaDX1WU6D6vyQWmbA/HubURatRsftdcXvdddt1+aCZZIGRRCT+e9me6J
	 fym4zFUh7wFYSExezPQ9DSvaRf1twXIzBch3rJ+ccpoj2GaE/L31ykN4tWIxnxqDB9
	 TrybJ9kBFgBa4nG2lvOl6tgjMNVKMoncUSOZFKFlbKb2p79ya6E/01H3uG5RdkcsHd
	 rb5j5ckcA2GZVZxjGxH7jlducf1YujtLCV0pFSLekn8QWdX389j/kjIJwo0VXUTjGo
	 XkuAKIwoK8k4Z+c6J5GJrEfIZVVqk+v2bVxVWc2bGmBE6a9K3q2oF/+8K0IWeDThWm
	 MGB9hPI7k7W4Q==
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
Subject: FAILED: Patch "Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:30 -0400
Message-ID: <20240327121630.2832767-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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





