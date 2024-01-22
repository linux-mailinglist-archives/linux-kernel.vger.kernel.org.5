Return-Path: <linux-kernel+bounces-33488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E4836A41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CD3284C75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE3113667A;
	Mon, 22 Jan 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZfkfn11"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3C52F92;
	Mon, 22 Jan 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936480; cv=none; b=kzAnRVYPW+5ZWqB3Glr1nv0B0mzhdeEhTUXNaoO6B8qDBapmEIlftyVbxSnrkGNaj9VRWLjkT+WyU3I6zMjgE43prGh0yQUMQq1BHbgKwrHjbFDw8VnOdjLGo+ZvORYSCGguV8AU/doaN+Cx60C4+dXRw0FC+OxPrgWOqkH1pLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936480; c=relaxed/simple;
	bh=Jd0GnDBeFTQubdqt0c3PXvhofZjUNnmhhtUNGmhdwJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOzWwGC9VlmZmh6MFx1YzO7G2QhUy+FN5C/mmKd6w/7i9tqxjRMwOb4egY4Uu0qHqrv1vGK+a+q/VcNEo5BDP1J9DQeeKrkf75O0IPgOScMyRsR6K6r6JLAjht0OqJS5j/eECmJuuZZkVIQmuXj+R2OOyZWPnoMYUKD8m13jmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZfkfn11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99618C43394;
	Mon, 22 Jan 2024 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936480;
	bh=Jd0GnDBeFTQubdqt0c3PXvhofZjUNnmhhtUNGmhdwJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZfkfn11ZxVE1uHUwMOqamgRPLNmTarp84B5brikkBZbdImDrYUqrRRuYvasq7lSZ
	 DDPXNnkEmRERm+jzFQcdUtJWJb6br4bRX9DPV2RGODtKD//TJhDsPcaH1kOafGwPCg
	 PgrltDDbvPQSNEDptpgqcTq2hLRHXehfsNOKeu9MbS1U3Mbthd8H55UmKpb7GuKAxi
	 UUA8hwUQgIZhukyhXak1b+i44MnRKoFKvo40S6E1YnD8B1ns+IMkFTIppJHZJ7gLk+
	 mPwkPZ1P2OJwJo62Bz9aKjDbmRU/ow5KBeHrBOaDJpfJQ6vKgw+wkUXq9Q25Vht6EA
	 Q/5bOpKQa5dDA==
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
	qingqing.zhuo@amd.com,
	wenjing.liu@amd.com,
	hamza.mahfooz@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 30/35] drm/amd/display: make flip_timestamp_in_us a 64-bit variable
Date: Mon, 22 Jan 2024 10:12:27 -0500
Message-ID: <20240122151302.995456-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 52355fe6994c..51df38a210e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -417,7 +417,7 @@ struct dc_cursor_position {
 };
 
 struct dc_cursor_mi_param {
-	unsigned int pixel_clk_khz;
+	unsigned long long pixel_clk_khz;
 	unsigned int ref_clk_khz;
 	struct rect viewport;
 	struct fixed31_32 h_scale_ratio;
-- 
2.43.0


