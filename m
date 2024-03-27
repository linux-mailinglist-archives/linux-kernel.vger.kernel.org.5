Return-Path: <linux-kernel+bounces-121068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B80788E209
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA05E2971C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CDF13AD30;
	Wed, 27 Mar 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH0tDSyr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446F161339;
	Wed, 27 Mar 2024 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541994; cv=none; b=iUB9waQoPZtR0QYJeSSKdt6+47C5k7046/QZyVdmuE57UGYV9GqO7UrAJeXelVEI5f4kcEnDNIJwg2mgYBXCpkhw2MQ6bfn3LRSIe+2MSjn8llxYvMM2aCtoI0ZrIUxfm+IBcAKs5E5XZkzALTvKfyLglXEBLA9FMU4NmZAKxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541994; c=relaxed/simple;
	bh=Tv6o3r7sQVwgQRW6nRj1GjB2HdqmINurVXYvEg1NhLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTUQ2C4564PmgDwqES876sgHEDzoURGtNW7bcL3ofR5Wk6CeRMHLKRmp7R71wst2MP4s9hMHiRLQqrviM7tPohgGP2J0haM/JlH99Vn3iCo81GE5GfnYYesoRKb/mWtndiE6kfBRXc7VuF/CA9yksednWIsszvq0ngBZJslrdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH0tDSyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92634C433F1;
	Wed, 27 Mar 2024 12:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541993;
	bh=Tv6o3r7sQVwgQRW6nRj1GjB2HdqmINurVXYvEg1NhLE=;
	h=From:To:Cc:Subject:Date:From;
	b=mH0tDSyr2NT7mE8UnbGwyHbHO9nbpU8nB9AzNsTHqH9oEc7ItOKdRGBtbSIm7R+NE
	 gNGSFmeWqwV8nFVbKDlifihjVqNl9nVIEM+i0pke5WMCZxNf8UEmV6cDJoHY81Gtge
	 kQhEICEGqHfHGWKmsYwqipj5ZkOGkA1eRTP3HgYTu6IjZKC9uYvcC3X+y5/RAuA0Qd
	 N6IqGgobri8J2Zx9f6gvKp9y8/sMueoitgC7HR2bwreRCO/SMhOLwg+TGszJQH+fUb
	 pSYb9A4rhLUHp5fCkPLTHrB5k/EbAcJ85oJoktK3KTtfMJ8dQ54wAszIcXrrHYdVem
	 Xg6DepzWReX/A==
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
Subject: FAILED: Patch "Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:51 -0400
Message-ID: <20240327121951.2835537-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





