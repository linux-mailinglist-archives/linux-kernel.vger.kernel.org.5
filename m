Return-Path: <linux-kernel+bounces-33443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206328369BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ED21C24202
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E24F5EB;
	Mon, 22 Jan 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ7MIOpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C34F5E5;
	Mon, 22 Jan 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936314; cv=none; b=GEq23Lidfticrz50WliUcoS4Xy30jmP9GYtA5bYrQwX/u3w+4l7htYnnFJ7VGdMim2sAxUd4pS22m+WP9CHkT0UcPDvboiGA1hx2V9ZRAipyve1sMVQCog5KEYN4qFW3HXG/7pYMFDOBmXtsUebAE+dmN8+NdwLFPYlVeNdVhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936314; c=relaxed/simple;
	bh=o1xs7JIqRwXyo59t+vI4O/U9bDmpnzviPesjWKaE8UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zkc+OWU/vh2BzKU2IajvLHgWCIO/c7zSf1kTrly+Par42QGEvIMnu4xvKCGFUDdtgiwtsC6SHfOo9GRDdSBccL4BO/cuMRnUmxYOOS0Dgeo9/JJpOSrhJxNo2n6JmdRJ4P2VtiH/4Bq9vL2lTHwDlgPziyf4DBnwzDkn2k0MQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ7MIOpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A60CC433F1;
	Mon, 22 Jan 2024 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936314;
	bh=o1xs7JIqRwXyo59t+vI4O/U9bDmpnzviPesjWKaE8UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQ7MIOpIy9X4njg6QBOTF85Y175/bh9Wv6wfLt13OrxRcGcm9DoBCuLmMACYHTs4M
	 hSG6YliAGdW2A8WYUVjzhY4LVOMqV28zRcHTif82t9b/IMQg6rYq1+7s98DH0k97a4
	 NhYaJjSI6II2+oosDj3YGRaYXGliLPvPPe+UwrJgaIct/Cat4rmHvkyj9D02Z7fBQs
	 1X4SA5GIQ2+yOhClxBsdbTvOavM6NFCRfhf+hR8/BlvHUuLT2CFlvU9XLij+70WlIA
	 GGdUGOz8G7D75jdD5DDKYOTs4hEyHIyLBWTZQ6Noiz09Q6Al1CvDDFWFO3N2UceO0z
	 hQVJL3vz1JBYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josip Pavic <josip.pavic@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	qingqing.zhuo@amd.com,
	hamza.mahfooz@amd.com,
	wenjing.liu@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 42/53] drm/amd/display: make flip_timestamp_in_us a 64-bit variable
Date: Mon, 22 Jan 2024 10:08:43 -0500
Message-ID: <20240122150949.994249-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Josip Pavic <josip.pavic@amd.com>

[ Upstream commit 6fb12518ca58412dc51054e2a7400afb41328d85 ]

[Why]
This variable currently overflows after about 71 minutes. This doesn't
cause any known functional issues but it does make debugging more
difficult.

[How]
Make it a 64-bit variable.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 46c2b991aa10..811c117665e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -244,7 +244,7 @@ enum pixel_format {
 #define DC_MAX_DIRTY_RECTS 3
 struct dc_flip_addrs {
 	struct dc_plane_address address;
-	unsigned int flip_timestamp_in_us;
+	unsigned long long flip_timestamp_in_us;
 	bool flip_immediate;
 	/* TODO: add flip duration for FreeSync */
 	bool triplebuffer_flips;
-- 
2.43.0


