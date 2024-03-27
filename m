Return-Path: <linux-kernel+bounces-120874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CE488DFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A72B25C45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE01428FA;
	Wed, 27 Mar 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgiUcBWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8B1428EA;
	Wed, 27 Mar 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541452; cv=none; b=ncM7mtE2a7aSZfm/jWR+JPte4ottUXXL5clWmCyAzLJu3u+Wg0NQZOfWXWo/532NMmC/fMEOOuNoe1apxMc+Hu2SzqNyDnF4TT2A/w6Nfvpud70yyVSvLZYA/PIvVqnYHu+wRsSe6ap+5cBOkJVUnfwU8Par7Z2D/jhQCf1aY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541452; c=relaxed/simple;
	bh=yZ/g3QPxU4ucsblv84ZF+pwPT1hwKQ6o5ID8iL0X2jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYIAK5Lj4lAc6LPeL6hXF/GogO74No0BsN3KpPZMThpi/87KdNbr0GBjdeKCi+Og4R/sJnJNZzYg1MkQirl9ZDxeQUwb3i+DCM5cDiUEPDL1SisTR1t5DCViKBbbx4GfXksxwGDy4gMHhPXRYsiG8MdHKqvmqiGHRogpQLr40k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgiUcBWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8383DC433F1;
	Wed, 27 Mar 2024 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541452;
	bh=yZ/g3QPxU4ucsblv84ZF+pwPT1hwKQ6o5ID8iL0X2jk=;
	h=From:To:Cc:Subject:Date:From;
	b=lgiUcBWrid29lJn7eN3S2APDHay7VmPmStW9SHK5K+rhY8pZpl3E4EIdkBpGZlB9T
	 N0PA3GSguWsb84HJZWaP76ZYJZOX74I+YDqk+5UnBlHccHmKXvwVp8mj+rFI/4aI+F
	 3A19vtNKHod0YJ/CM30BgTvaL0zYb/aaDnfzfzFK/9Q47LPCtCEz45JuXX3eSyeAAJ
	 8wAv05SDNvd2Mg/f52KuW/fmkW7Xa0NNaur9BnWljWiF6BH/1abKqxNYxCdp5H0tsT
	 p9AJ20zwTvMu5kMiivehaGk3YgCFCLnEDj9QkWZAWF3DhmeMGRAB3y5RHbyzcrL0ZO
	 hXYnctTUScQpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	josip.pavic@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Allow dirty rects to be sent to dmub when abm is active" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:50 -0400
Message-ID: <20240327121050.2828297-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7fb19d9510937121a1f285894cffd30bc96572e3 Mon Sep 17 00:00:00 2001
From: Josip Pavic <josip.pavic@amd.com>
Date: Fri, 9 Feb 2024 16:05:18 -0500
Subject: [PATCH] drm/amd/display: Allow dirty rects to be sent to dmub when
 abm is active

[WHY]
It's beneficial for ABM to know when new frame data are available.

[HOW]
Add new condition to allow dirty rects to be sent to DMUB when ABM is
active. ABM will use this as a signal that a new frame has arrived.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5211c1c0f3c0c..613d09c42f3b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3270,6 +3270,9 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
 	if (stream->link->replay_settings.config.replay_supported)
 		return true;
 
+	if (stream->ctx->dce_version >= DCN_VERSION_3_5 && stream->abm_level)
+		return true;
+
 	return false;
 }
 
-- 
2.43.0





